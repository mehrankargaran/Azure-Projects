# Project 8 - Nano-Folio Deployment on Azure

## Overview

This project demonstrates deploying a static HTML/CSS/JS portfolio website (Nano-Folio template) on an Azure Virtual Machine (VM) running Ubuntu 22.04 with Apache2. The goal is to simulate a real-world enterprise scenario of hosting a personal portfolio on cloud infrastructure.

## Project Structure

Project_8/
├── css/ # Stylesheets
├── js/ # JavaScript files
├── img/ # Images
├── fontawesome/ # Fonts 
├── index.html # Main landing page
├── deploy-vm.sh # My Script for creating the VM 
├── Output.txt # Output of Running deploy-vm.sh
└── README.md # Project documentation


## Technologies Used

- **Azure Virtual Machine (Ubuntu 22.04)**
- **Apache2 Web Server**
- **HTML/CSS/JS**
- **Azure CLI** for resource provisioning and VM deployment
- **Bash scripting** for automation

## Deployment Steps

1. **Create Resource Group**

   ```bash
   az group create --name rg-session19-nano --location westus2

2. Create Virtual Machine

az vm create \
    --resource-group rg-session19-nano \
    --name nano-vm \
    --image Ubuntu2204 \
    --size Standard_D2s_v3 \
    --admin-username azureuser \
    --generate-ssh-keys

3. Open Port 80 for HTTP

 az vm open-port --port 80 --resource-group rg-session19-nano --name nano-vm

4. Install Apache2 and Deploy Project

-Connect via SSH

-Install Apache2 and unzip

-Download and unzip Nano-Folio template

-Copy files to /var/www/html

-Restart Apache

5. Access the website via the VM public IP: http://<PUBLIC_IP>

Purpose:

-Learn Azure VM provisioning and configuration

-Automate deployment with Bash and Azure CLI

-Host a static web project on the cloud

-Understand network security group (NSG) configuration


Notes:

-Make sure the VM size and location are available in your subscription

-All deployment scripts are idempotent and can be rerun safely

-Customize your HTML/CSS as needed for portfolio presentation
