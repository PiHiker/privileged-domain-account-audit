# Import the required modules
Import-Module ActiveDirectory
Import-Module ImportExcel

# Prompt for credentials
$ADCredentials = Get-Credential -Message "Enter domain admin credentials"

# Set the date and report path
$reportDate = (Get-Date).ToString("yyyy-MM-dd")
$reportPath = "C:\Temp\PrivilegedAccountAudit_$reportDate.xlsx"

# Ensure the directory exists
if (-not (Test-Path -Path "C:\Temp")) {
    New-Item -ItemType Directory -Path "C:\Temp"
}

# Define privileged groups to audit
$privilegedGroups = @("Domain Admins", "Enterprise Admins", "Administrators", "Backup Operators", "Account Operators", "Schema Admins")

# Gather group memberships directly, showing progress
$memberMap = @{}
$groupCount = $privilegedGroups.Count
for ($i = 0; $i -lt $groupCount; $i++) {
    $group = $privilegedGroups[$i]
    Write-Progress -Activity "Privileged Account Audit" -Status "Gathering memberships: $group" -PercentComplete (($i / $groupCount) * 100)

    $directMemberObjects = Get-ADGroup -Identity $group -Credential $ADCredentials -Properties Members |
                           Select-Object -ExpandProperty Members |
                           ForEach-Object {
                               $obj = Get-ADObject -Identity $_ -Credential $ADCredentials -Properties ObjectClass, SamAccountName
                               if ($obj.ObjectClass -eq 'user' -and -not [string]::IsNullOrWhiteSpace($obj.SamAccountName)) {
                                   if (-not $memberMap.ContainsKey($obj.SamAccountName)) {
                                       $memberMap[$obj.SamAccountName] = @()
                                   }
                                   $memberMap[$obj.SamAccountName] += $group
                               }
                           }
}

# Retrieve user properties, showing progress
$allUserProps = @()
$userCount = $memberMap.Keys.Count
$i = 0
foreach ($sam in $memberMap.Keys) {
    $i++
    Write-Progress -Activity "Privileged Account Audit" -Status "Retrieving user properties: $sam" -PercentComplete (($i / $userCount) * 100)
    $userProps = Get-ADUser -Identity $sam -Properties DisplayName, LastLogonDate, Enabled, PasswordLastSet, Description -Credential $ADCredentials
    if ($userProps) {
        $allUserProps += $userProps
    }
}

# Build final report objects, showing progress
$reportObjects = @()
$userCount = $allUserProps.Count
for ($i = 0; $i -lt $userCount; $i++) {
    $user = $allUserProps[$i]
    Write-Progress -Activity "Privileged Account Audit" -Status "Building report for: $user.SamAccountName" -PercentComplete (($i / $userCount) * 100)
    
    $groups = $memberMap[$user.SamAccountName]
    $reportObject = [PSCustomObject]@{
        SamAccountName    = $user.SamAccountName
        DisplayName       = $user.DisplayName
        LastLogonDate     = $user.LastLogonDate
        Enabled           = $user.Enabled
        PasswordLastSet   = $user.PasswordLastSet
        Description       = $user.Description
    }

    # Add direct group membership status to the report object
    foreach ($group in $privilegedGroups) {
        $reportObject | Add-Member -NotePropertyName $group -NotePropertyValue ($groups -contains $group)
    }

    $reportObjects += $reportObject
}

# Export to Excel, final progress update
Write-Progress -Activity "Privileged Account Audit" -Status "Exporting to Excel" -PercentComplete 100
$reportObjects | Sort-Object SamAccountName | Export-Excel -Path $reportPath -AutoSize -AutoFilter -BoldTopRow -WorksheetName "Audit_$reportDate" -FreezeTopRow
Write-Host "Privileged Account Audit completed. Report generated at $reportPath"
Write-Progress -Activity "Privileged Account Audit" -Status "Completed" -Completed
