# Custom Docker Image – Apache + Nano Project

This project builds a custom Docker image based on Ubuntu 22.04 with Apache2.

## Included
- Apache HTTP Server
- Nano Folio static website
- Custom Dockerfile

## Build Image
```bash
docker build -t nanoimg .
------------------
Run Container
docker run -d -p 9081:80 nanoimg

Verification
http://<VM_PUBLIC_IP>:9081
