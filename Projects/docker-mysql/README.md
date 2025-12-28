# MySQL Container with Port Mapping

This project demonstrates running a MySQL 5.7 container on an Azure VM.

## Features
- Environment variable configuration
- Persistent storage using Docker volumes
- Port mapping for testing purposes

## Run
```bash
./run-mysql.sh
--------------------
Port Mapping:
	Host Port: 3030
	Container Port: 3306
⚠️ Exposing database ports publicly is not recommended in production
