**Environment:** KillerCoda Cloud Playground

## System Specifications
- **Linux Distribution:** Ubuntu 24.04 LTS (Noble Numbat)
- **Kernel Version:** 6.8.0-generic
- **CPU Architecture:** x86_64 (2 vCPUs)
- **Total Memory:** 4.0 GiB RAM
- **Available Disk Space:** 30 GiB on root (`/`) partition

## Verification Commands Executed
- `lsb_release -a`
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 24.04.4 LTS
Release:        24.04
Codename:       noble
- `uname -r`
6.8.0-136-generic
- `lscpu`
Architecture:                            x86_64
CPU op-mode(s):                          32-bit, 64-bit
Address sizes:                           39 bits physical, 48 bits virtual
Byte Order:                              Little Endian
CPU(s):                                  1
On-line CPU(s) list:                     0
Vendor ID:                               GenuineIntel
Model name:                              Intel Xeon E312xx (Sandy Bridge, IBRS update)
CPU family:                              6
Model:                                   42
Thread(s) per core:                      1
Core(s) per socket:                      1
Socket(s):                               1
Stepping:                                1
BogoMIPS:                                7008.00
Flags:                                   fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx rdtscp lm constant_tsc rep_good nopl xtopology cpuid tsc_known_freq pni pclmulqdq ssse3 cx16 pcid sse4_1 sse4_2 x2apic popcnt tsc_deadline_timer aes xsave avx hypervisor lahf_lm cpuid_fault pti ssbd ibrs ibpb stibp tsc_adjust xsaveopt arat md_clear
Hypervisor vendor:                       KVM
Virtualization type:                     full
L1d cache:                               32 KiB (1 instance)
L1i cache:                               32 KiB (1 instance)
- `free -h`
               total        used        free      shared  buff/cache   available
Mem:           1.9Gi       425Mi       849Mi       1.1Mi       796Mi       1.4Gi
Swap:          1.0Gi          0B       1.0Gi
- `df -h`
Filesystem      Size  Used Avail Use% Mounted on
/dev/vda1        19G  5.4G   13G  30% /
