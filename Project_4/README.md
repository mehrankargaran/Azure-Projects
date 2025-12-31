# Azure VM Deployment Project

This project contains a PowerShell script (`MyProject6.ps1`) to automate the deployment of an **Ubuntu 22.04 VM** in Microsoft Azure. It creates all required resources including Resource Group, Virtual Network, Subnets, Network Security Group, Public IP, Network Interface, and the VM itself.
---

## Features

- **Resource Group:** IT
- **Location:** East Asia
- **Virtual Network:** VM-NET
  - Address space: `10.0.0.0/16`
  - Subnets:
    - `subnetA`: `10.0.0.0/24`
    - `subnetB`: `10.1.0.0/24`
- **Network Security Group:** SEC1
  - Inbound rules:
    - HTTP (port 80) allowed
    - SSH (port 22) allowed
- **Public IP:** vm001-pip (static)
- **Network Interface:** vm001-nic
- **VM:** vm001
  - Image: Ubuntu 22.04 LTS
  - Size: Standard_D2s_v3 (default)
  - Username & Password: prompted during script execution
- Fully automated provisioning

---

## Prerequisites

- Azure subscription
- Azure PowerShell module installed
- Internet access to Azure
- Git Bash / SSH client (for connecting to VM)

---

## Deployment

1. Open **Azure Cloud Shell** or PowerShell connected to your Azure account.
2. Clone this repository or download the `MyProject6.ps1` script.
3. Run the script:

```powershell
./MyProject.ps1
4. You will be prompted to enter:

VM username

VM password (must contain at least 3 of: uppercase, lowercase, number, special character)

5. Confirm overwriting existing resources if prompted.

6. Script will create all Azure resources and deploy the VM.

Post-Deployment

SSH to the VM:

ssh <username>@<Public-IP>

Example:
	ssh mehran@<vm001-pip-IP-address>

Check firewall status inside VM:

	sudo ufw status


Verify SSH service is running:

	sudo systemctl status ssh


Check network listening ports:

	sudo ss -tulpn | grep :22

	
Notes:

If the VM fails to deploy due to Trusted Launch / SecurityType, the script automatically handles standard VM creation.

The default VM size may change in upcoming Az PowerShell versions (Standard_D2s_v3 → Standard_D2s_v5).

Boot diagnostics is enabled by default; a new storage account will be created if none exists in the region.

NSG rules ensure HTTP and SSH are accessible from the internet.

License:

This project is provided for learning and demonstration purposes. Modify and use freely under MIT License

---
