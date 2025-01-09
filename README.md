Privileged Account Audit Script
This PowerShell script is designed to perform an audit of specified privileged groups within an Active Directory environment. It generates a detailed report listing each user's group memberships, along with other critical user attributes such as account status, last logon date, and more. The report is exported to an Excel file for easy viewing and further analysis.

Features
Retrieves direct memberships of specified privileged groups.
Gathers user details such as DisplayName, LastLogonDate, Enabled status, PasswordLastSet, and Description.
Exports the data to an Excel file with sorting and filtering enabled.
Prerequisites
Windows PowerShell 5.1 or higher.
Active Directory PowerShell module.
ImportExcel PowerShell module.
Administrative privileges on the system where the script is run.

Setup
Install PowerShell Modules: Ensure the ActiveDirectory and ImportExcel modules are installed. You can install them using the following PowerShell commands if not already installed:

Install-Module -Name ActiveDirectory
Install-Module -Name ImportExcel

Download the Script: Download Privileged-Account-Audit.ps1 from the source or copy the content into a new file named Privileged-Account-Audit.ps1 on your local machine.

Prepare the Environment: Ensure the directory where the report will be saved (C:\Audit) exists, or modify the script to point to an existing directory.

Usage

To run the script, follow these steps:

Open PowerShell: Open a PowerShell window with administrative privileges.

Navigate to the Script's Location: Use the cd command to change the directory to where Privileged-Account-Audit.ps1 is located.

cd path\to\your\script

Execute the Script: Run the script by typing:

.\Privileged-Account-Audit.ps1
You will be prompted to enter credentials. Provide credentials with sufficient rights to query Active Directory.

Review the Report: Once the script completes execution, check the specified output directory c:\temp for the Excel file. Review the report for accuracy and completeness.
