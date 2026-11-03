# CCM101 Cloud Computing Final – Laboratory 10: Enterprise Cloud Architect

A secure, automated, multi-tier WordPress + MySQL stack running in Docker on an Ubuntu Server virtual machine in VirtualBox.

## Stack
- WordPress (web tier) and MySQL 8.0 (database tier) in Docker containers, managed with Docker Compose
- Named Docker volumes for persistent database and WordPress files
- UFW firewall: default deny incoming, with only SSH (22) and HTTP (80) allowed
- Bash backup script scheduled with cron

## Files in this folder
- `docker-compose.yml`: defines the WordPress and MySQL services, volumes, and restart policy
- `.env.example`: template for the database passwords (copy to `.env`; the real `.env` is never committed)
- `automation-script.sh`: daily MySQL backup with 7-day retention
- `architecture-diagram.png`: network and architecture diagram
- `operational-manual.md`: how to deploy, secure, and maintain the stack
- `final-reflection.md`: reflection on Missions 1 to 10

## Quick start
```bash
cp .env.example .env
nano .env                  # set your own passwords
docker compose up -d
docker compose ps
chmod +x automation-script.sh
```

## Access
- Website: http://localhost:8080 (VirtualBox forwards host port 8080 to guest port 80)
- SSH: `ssh -p 2222 guren@localhost` (host port 2222 forwards to guest port 22)

## AI-use disclosure
We used Claude (an AI assistant) for step-by-step guidance, troubleshooting, diagram layout, and review of our documentation. Claude also edited the wording and formatting of the operational manual, this README, and the final reflection. We performed the VM setup, deployment, security configuration, and testing ourselves, and we are responsible for everything in this repository.

## Members
- Felix, Mark Francis J.
- Eulalio, Jericho O.
- Felipe, Frederick O.

Section: BSIT 4G | Instructor: Jenkielyn C. Torres
