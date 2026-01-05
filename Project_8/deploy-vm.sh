#!/bin/bash

# Variables
RG_NAME="rg-session19-nano"
LOCATION="westus2"
VM_NAME="nano-vm"
VM_SIZE="Standard_D2s_v3"
ADMIN_USER="azureuser"
IMAGE="Ubuntu2204"
NANO_URL="https://www.tooplate.com/zip-templates/2122_nano_folio.zip"
NANO_ZIP="nano.zip"
APACHE_PATH="/var/www/html"

echo "Creating resource group..."
az group create --name $RG_NAME --location $LOCATION

echo "Creating VM..."
az vm create \
    --resource-group $RG_NAME \
    --name $VM_NAME \
    --image $IMAGE \
    --size $VM_SIZE \
    --admin-username $ADMIN_USER \
    --generate-ssh-keys \
    --output json

# Get public IP
PUBLIC_IP=$(az vm list-ip-addresses --resource-group $RG_NAME --name $VM_NAME --query "[0].virtualMachine.network.publicIpAddresses[0].ipAddress" -o tsv)
echo "VM public IP: $PUBLIC_IP"

echo "Opening port 80 for Apache..."
az vm open-port --port 80 --resource-group $RG_NAME --name $VM_NAME

echo "Installing Apache2 and deploying Nano project..."
ssh -o StrictHostKeyChecking=no $ADMIN_USER@$PUBLIC_IP << EOF
    sudo apt update -y
    sudo apt install -y apache2 unzip wget
    cd /tmp
    wget -O $NANO_ZIP $NANO_URL
    unzip $NANO_ZIP -d nano_project
    sudo cp -r nano_project/*/* $APACHE_PATH/
    sudo systemctl restart apache2
EOF

echo "Deployment completed!"
echo "You can access your project at: http://$PUBLIC_IP"
