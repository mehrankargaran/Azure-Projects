# Nginx Container on Azure VM

This project demonstrates deploying an Nginx container on an Ubuntu 22.04
virtual machine running on Microsoft Azure.

## Steps
1. Install Docker Engine
2. Run Nginx container using port mapping
3. Configure Azure NSG to allow inbound traffic on port 80

## Run
```bash
./run-nginx.sh

Verification

Access the application via browser:

http://<VM_PUBLIC_IP>


Expected output:

Welcome to nginx!
