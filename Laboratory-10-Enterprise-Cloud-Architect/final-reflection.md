# Final Reflection

Before this project, our knowledge of cloud computing was mostly theory. We knew the concepts and a few basic commands, but we had never configured a real server or used Docker. By building a WordPress and MySQL stack in Docker containers on an Ubuntu Server virtual machine, we turned that theory into practical skills. We secured the system so that only the WordPress container can reach the database, and UFW allows only SSH and HTTP. We also wrote a backup script, and we wrote this manual so that anyone can rebuild the stack.

The hardest part was the CPU soft lockup during installation, because the error pointed at the CPU instead of the real cause. We also fixed SSH not connecting, Docker permission errors, and a missing .env file. These problems taught us to read every console message carefully and to change only one setting at a time.
