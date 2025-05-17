# recon_scan

Bash script I created to help with basic network reconnaissance. It’s designed for cybersecurity tasks like checking if a target is reachable and running useful nmap scans automatically.

What the Script Does:

1. Pings the target IP or domain
- If it's not reachable, the script stops. 
- If it is reachable, it continues to scan.

2. Runs a quick nmap scan.
- Uses: nmap -p- [IP] -Pn -T5 -v
- Scans all TCP ports to find open ones.

3. Checks for common important ports
- Looks for these: 21, 22, 23, 25, 80, 445, 8080, 3389

4. If any of those ports are open:
- Runs a detailed scan with: nmap -p [ports] -A [IP] -Pn -v
- Creates a report file named: recon[date].txt (for example, recon20250517_153210.txt)