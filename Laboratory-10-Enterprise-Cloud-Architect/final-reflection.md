# Final Reflection

## Where I started and where I am now
During Mission 1, my understanding was limited to basic system concepts, high-level cloud architecture, and rudimentary system commands. All of my knowledge was theoretical in regard to system configuration, server environments, and container management.

Now, I am able to independently create and manage web infrastructure, secure it, and configure it from end to end. I am able to create services by putting together Docker containers with Docker Compose, write automation scripts, configure system firewalls (UFW), and troubleshoot low-level service or dependency issues. Additionally, I am now able to manage system security.

## Skills from each mission
- **Linux Commands & CLI Administration (Missions 1 & 2):** terminal commands and directory navigation; permissions; directory structure; file creation; packages and package managers; text editors.
- **Docker & Containerization (Mission 3):** image construction; writing Dockerfiles; understanding container lifecycles; working with multi-container setups using docker-compose.
- **Firewall & Network Security (Mission 4):** configuring ports; defining service network security policy; managing exposed network services via UFW.
- **Shell Scripting & Automation (Missions 2 & 5):** writing Bash scripts for service automation and for systems preparation and setup.

## What "an Architect writes the manual" means to me
In my view, "an Architect writes the manual" implies that building a system is only 50 percent of the battle. True system architecture means being able to create something that can be reproduced, is easy to maintain, and is easy to understand.

Clear documentation forces you to have a deep understanding of all the layers of your stack. The first time you come across edge cases, like unexpected errors or something getting stuck, you can create the documentation so that everyone else knows what to do in that situation and turn a one-time fix into part of the institutional knowledge. A true Architect builds systems that anyone on the team can use, understand, and easily fix without friction.

## The final mission (Mission 10)
The final mission asked me to build a secure, automated, multi-tier web application and document it as an operational manual. I built a WordPress + MySQL stack on an Ubuntu Server virtual machine in VirtualBox. Both tiers run as Docker containers managed with Docker Compose, with named volumes so the data survives restarts. The database has no published port and can only be reached by WordPress. UFW denies incoming traffic except SSH and HTTP, and a Bash script backs up the database every day at 2:00 AM with 7-day retention. I also wrote the operational manual so another person could rebuild the stack from it.

## Problems I hit and how I solved them
- **Install freeze:** the VM froze during the Ubuntu installation, and the console showed a CPU soft lockup. I fixed it by changing the VM's settings in VirtualBox, and I recorded the change in the manual's troubleshooting table.
- **Missing SSH server:** I could not connect over SSH because the OpenSSH option was not ticked in the installer. I installed `openssh-server` afterward and used the port forward on host port 2222.
- **Docker permission error:** Docker commands failed with "permission denied" because my user was not allowed to use the Docker socket. I added my user to the `docker` group.
- **`.env` file not found:** `docker compose up` showed "variable is not set" warnings, and WordPress displayed "Error establishing a database connection." I had not created the `.env` file. I copied `.env.example` to `.env` and filled in the passwords.

## What was hardest and what I would improve
The hardest part was the install freeze, because it stopped everything before I had a working system, and the error pointed at the virtual CPU instead of anything I had configured. It taught me to read the console messages first and change one setting at a time.

If I did this again, I would add three things. First, HTTPS, because the site currently serves plain HTTP. Second, backups stored off the VM, because right now a failure of the VM would take the backups with it. Third, monitoring and alerts, so a stopped container or a failed backup is noticed without anyone checking the logs.
