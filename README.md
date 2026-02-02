# Privileged Account Audit Script

[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-5391FE?logo=powershell&logoColor=white)](https://learn.microsoft.com/powershell/)
[![Windows](https://img.shields.io/badge/Windows-Supported-0078D6?logo=windows&logoColor=white)](https://www.microsoft.com/windows)
[![Active%20Directory](https://img.shields.io/badge/Active%20Directory-Module-00A4EF?logo=microsoft&logoColor=white)](https://learn.microsoft.com/powershell/module/activedirectory/)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](LICENSE)

A PowerShell script that audits privileged Active Directory (AD) security groups in Windows domains and produces an Excel report with key user attributes (account status, last logon, password age, and more). Ideal for domain admin audits, privileged access reviews, and compliance reporting.

## ✨ Features

- Retrieves direct memberships of specified privileged groups.
- Collects user details (DisplayName, LastLogonDate, Enabled, PasswordLastSet, Description).
- Exports results to Excel with sorting and filtering enabled.

## ✅ Prerequisites

- Windows PowerShell **5.1+**
- Active Directory PowerShell module
- ImportExcel PowerShell module
- Administrative privileges on the system where the script runs

## 🔍 Audited Active Directory Groups

The default report includes direct members of the following privileged AD groups:

- Domain Admins
- Enterprise Admins
- Administrators
- Backup Operators
- Account Operators
- Schema Admins

## ⚙️ Setup

1. **Install required modules** (if not already installed):

   ```powershell
   Install-Module -Name ActiveDirectory
   Install-Module -Name ImportExcel
   ```

2. **Download the script**:
   - Save `Privileged-Account-Audit.ps1` locally.

3. **Prepare the output directory**:
   - Ensure `C:\Audit` exists, or update the script to point to your preferred location.

## ▶️ Usage

1. **Open PowerShell** with administrative privileges.
2. **Navigate to the script directory**:

   ```powershell
   cd path\to\your\script
   ```

3. **Run the script**:

   ```powershell
   .\Privileged-Account-Audit.ps1
   ```

4. **Authenticate** when prompted with credentials that can query Active Directory.
5. **Review the report** at `C:\temp` (or your configured output directory).

## 🧾 Output

The Excel report includes:

- Group membership (direct members of privileged groups)
- Display name
- Account enabled/disabled state
- Last logon date
- Password last set date
- Account description

## 📄 License

Licensed under the GNU General Public License v3.0. See [LICENSE](LICENSE) for details.
