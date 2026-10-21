# CCM101 - Cloud Computing
**Enterprise Cloud Architect – Operational Manual**

**Project:** Secure Multi-Tier Web Application

**Application Stack:** WordPress + MySQL

**Prepared by:** Felix, Mark Francis J. | Eulalio, Jericho O | Felipe, Frederick O.

**Section:** BSIT 4G

**Instructor:** Jenkielyn C. Torres

**Date:** October 2026

# Overview and Architecture
<img width="2000" height="1414" alt="architecture-diagram" src="https://github.com/user-attachments/assets/62a36d94-24a4-4aee-9eba-badc18abb201" />


# VM Setup and Networking
**Virtual Machine SpecificationsHypervisor:**

Oracle VM VirtualBox (Type 2 Hypervisor)   

**Operating System:** Ubuntu Server 26.04.1 LTS (Headless distribution)   

**Allocated RAM:** 4096 MB (4 GB)

**Virtual Disk Size:** 25 GB

**Services Installed:** OpenSSH Server for remote administration

**NAT Port Forwarding Configuration**

To allow the host machine to securely interact with the isolated headless virtual machine, Network Address Translation (NAT) port forwarding is configured on the hypervisor:

**Host Port** 8080 -> **Guest Port 80 (Web Traffic):** Allows a web browser on the physical host laptop to access the WordPress site via http://localhost:8080.   

**Host Port 2222** -> **Guest Port 22 (SSH Administration):** Allows secure terminal management from the host using ssh -p 2222 guren@localhost. 

<img width="593" height="388" alt="vbox-port-forwarding" src="https://github.com/user-attachments/assets/716e54c2-a1f4-4620-b50f-a9c295bb1eb2" />

# Deployment
**Docker Installation Method & Versions**

Docker was installed on Ubuntu Server using the Official Docker APT Repository (via containerd.io, docker-ce, docker-ce-cli, and docker-compose-plugin).

<img width="1392" height="115" alt="docker-versions" src="https://github.com/user-attachments/assets/c1129a97-5e52-4a8e-8a34-81f57429b83a" />
<img width="1917" height="155" alt="containers-running" src="https://github.com/user-attachments/assets/313835d0-c941-458c-a535-65b834fe1a00" />

<img width="500" height="1000" alt="ray-so-export" src="https://github.com/user-attachments/assets/ca2368b6-9dcf-4190-a437-36ceb0e80352" />

services:: Declares the multi-container components that make up the stack.

**db::** Names the service block for the database tier.

**image:** mysql:8.0: Pulls the official, stable MySQL version 8.0 image from Docker Hub.

**container_name:** ccmfinal_db: Assigns a predictable container identifier (ccmfinal_db) for logging and monitoring.   

**restart: unless-stopped:** Configures Docker to automatically restart the container on system reboots or unexpected crashes, unless manually stopped.

**environment::** Passes secure database initialization variables loaded from the external .env file (MYSQL_ROOT_PASSWORD, MYSQL_DATABASE, MYSQL_USER, MYSQL_PASSWORD).

**volumes::** Mounts a named persistent storage volume (ccmfinal_mysql_data) to MySQL's default data directory (/var/lib/mysql) so database records survive container recreation or system reboots.

**wordpress::** Names the second service block for the web application frontend.

**image: wordpress:latest:** Pulls the official WordPress image containing pre-configured Apache and PHP runtimes.container_name: 

**ccmfinal_wordpress:** Sets an explicit container name (ccmfinal_wordpress).   

**depends_on::** Instructs Docker Compose to start the db service first, ensuring the database backend is fully initialized before WordPress attempts connection.

**ports::** Maps port 80 inside the container to port 80 on the VM's network interface, exposing the web frontend.

**WORDPRESS_DB_HOST: db:3306:** Directs WordPress to connect to the database service using its internal Docker DNS name (db) on port 3306.

**volumes::** Mounts a separate named volume (ccmfinal_wp_data) to /var/www/html to preserve uploaded media, themes, and configuration changes.

<img width="1917" height="1198" alt="wordpress-site" src="https://github.com/user-attachments/assets/02df4552-2c6a-4c5f-b935-c02fc64217dc" />

**Why MySQL Has No Published Port**
The database service does not feature a ports mapping block. By omitting port publishing, MySQL is completely isolated from the host machine and public network interfaces. It can only be reached by the WordPress container across the internal Docker network (wp-net), minimizing the attack surface.

**Environment Management (.env vs .env.example)**
The .env File: Holds live plain-text secrets and database passwords used at runtime. Because credentials pose a major security risk if exposed in version control, the actual .env file is excluded from GitHub via .gitignore.
The .env.example File: A safe template file containing blank keys or dummy placeholders that is committed to the repository, guiding other administrators on required configuration variables.

# Security Hardening
**Host-Based Firewall (UFW) Configuration**

To secure the Ubuntu Server instance, the Uncomplicated Firewall (UFW) is configured with a strict default deny policy:

<img width="700" height="350" alt="ufw" src="https://github.com/user-attachments/assets/59ad100d-26ae-48c0-8691-d4a03747594a" />

- Default Deny Incoming: Rejects all unapproved incoming connection attempts by default.   

- Port 22 (SSH): Explicitly allowed to maintain remote administration.

- Port 80 (HTTP): Explicitly allowed to serve web requests to visitors.

**The Docker-and-UFW Caveat**

Docker manages its own network packet routing by injecting custom iptables rules directly into the Linux kernel to support container port publishing. Even with UFW set to deny incoming traffic, Docker rules allow published container ports (like port 80) to function correctly while host-level UFW controls overall network exposure. 

<img width="1556" height="366" alt="ufw-status" src="https://github.com/user-attachments/assets/63069b52-a9b2-424d-9c14-6167542e01bb" />

# Automation and Disaster Recovery

**Password Security:** To avoid storing plain-text passwords directly in the script body, the script evaluates environment variables securely at runtime or reads container context.

**Cron Job Scheduling**

The backup script is automated to execute daily at 2:00 AM Philippine Time (PST).

  - **Cron Expression:**
    0 2 * * * /home/guren/wp-stack/automation-script.sh >> /home/guren/backups/backup.log 2>&1   

  - **Field Breakdown:**
      - 0 — Minute 0
     
      - 2 — Hour 2 (2:00 AM)
      
      - * — Every day of the month

      - * — Every month

      - * — Every day of the week

**Backup Retention & Restoration**

  - Storage & Retention: Backups are saved in ~/backups/ and automatically pruned after 7 days using find ... -mtime +7 -delete.

  - Restoration Command: To restore a database snapshot from a compressed backup file:

<img width="1865" height="568" alt="backup-proof" src="https://github.com/user-attachments/assets/4128ab56-a964-420d-ad70-c33f2ed7211f" />
<img width="1462" height="605" alt="crontab" src="https://github.com/user-attachments/assets/adaf7f9a-2868-4b8c-bbfc-8b706a28d85d" />


# Verification and Persistence Test
<img width="1917" height="1125" alt="reboot-test" src="https://github.com/user-attachments/assets/709da6f7-0ac5-4093-983e-b9bec6d72fe4" />

**Reboot Persistence Proof**

Executing a system reboot (sudo reboot) and validating the environment proves that:

1. Containers restart automatically under the unless-stopped policy.

2. Host UFW security firewall rules remain active.
  
3. Named Docker volumes preserve all application data, configuration settings, and database contents without loss.

# Maintenance and Troubleshooting
**Daily Operational Commands**

- Check Status: docker compose ps   

- View Container Logs: docker compose logs -f

- Stop Stack: docker compose down

- Start Stack: docker compose up -d

- ⚠️ CRITICAL WARNING: Never execute docker compose down -v. The -v flag deletes named volumes, permanently erasing all database records and uploaded files.

**Troubleshooting Reference Table**

| Issue Encountered | Root Cause | Solution / Fix |
| :--- | :--- | :--- |
| **.env not found error** | Missing configuration file during stack initialization. | Copy `.env.example` to `.env` and fill in required database parameters. |
| **Docker permission denied** | User account lacks privileges to access the Docker Unix socket. | Add user to the docker group: `sudo usermod -aG docker $USER && newgrp docker`. |
| **SSH server not installed** | Minimal Ubuntu Server installation omitted OpenSSH package. | Install package manually: `sudo apt update && sudo apt install openssh-server -y`. |
| **Package installation freeze** | Background unattended-upgrades locking the APT package manager. | Wait for background tasks to finish or terminate the lock: `sudo killall apt apt-get`. |
