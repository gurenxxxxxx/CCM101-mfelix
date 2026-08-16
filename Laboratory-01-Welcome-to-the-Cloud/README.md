## Mission Overview
This mission covers onboarding as a Junior Cloud Infrastructure Engineer Trainee at CloudNova Technologies. The task involves accessing a cloud-based Linux environment, performing core administration tasks, documenting system state, and initializing a public portfolio on GitHub.

## Objectives
- Access and configure a Linux cloud playground on KillerCoda.
- Perform Linux user management (`useradd`, `usermod`, `passwd`).
- Inspect system hardware and operating system parameters.
- Organize directory structures and document workflows using Markdown.
- Initialize and maintain a version-controlled GitHub repository.

## Activities Performed
1. Provisioned an Ubuntu 24.04 instance in KillerCoda.
2. Created standard user account `mfelix` with sudo privileges.
3. Queried OS distribution, kernel details, CPU metrics, memory allocation, and storage capacity.
4. Structured local workspace folders and created markdown documentation (`system-information.md`, `about-me.md`, `reflection.md`).
5. Configured Git tracking and pushed the repository to GitHub.

## Linux Commands Used
| Command | Purpose |
| :--- | :--- |
| `sudo useradd -m -s /bin/bash mfelix` | Creates a new user with home directory and Bash shell |
| `sudo usermod -aG sudo mfelix` | Grants administrative (sudo) privileges |
| `su - mfelix` | Switches session to the new user account |
| `whoami` / `pwd` / `hostname` | Inspects active user, current directory, and host |
| `lsb_release -a` / `uname -r` | Queries Linux distribution and kernel version |
| `free -h` / `df -h` | Checks memory consumption and available disk storage |
| `mkdir -p` | Creates parent and child directories concurrently |
| `git init` / `git commit` / `git push` | Initializes tracking and pushes updates to remote repository |

## Skills Learned
- Linux System Administration & Privilege Escalation
- Command-Line Interface (CLI) Navigation & Environment Discovery
- Structured Technical Documentation in Markdown
- Version Control Workflows with Git & GitHub
