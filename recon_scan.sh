#!/bin/bash

# Prompt user to enter a target IP address or domain
read -p "Enter target IP or domain: " target

# Ping the target to check if it's reachable
echo "[*] Pinging $target..."
ping -c 3 $target > /dev/null

# If the ping is successful, continue; otherwise exit
if [ $? -eq 0 ]; then
    echo "[*] $target is reachable. Continuing scan..."
else
    echo "[!] $target is not reachable. Exiting."
    exit 1

fi

# Run a quick Nmap scan on all ports
echo "[*] Running quick Nmap scan on all ports..."
nmap_output=$(nmap -p- -Pn -T5 -v $target)

# Ports of interest
ports_to_check=(3389 3306 22 23 445 80 8080 21 25)
open_ports=()

# Extract open ports from the scan
for port in "${ports_to_check[@]}"; do
    if echo "$nmap_output" | grep -q "$port/tcp open"; then
        open_ports+=("$port")
    fi
done

# If any important ports are open, run a detailed Nmap scan on those specific ports
if [ ${#open_ports[@]} -gt 0 ]; then
    ports_csv=$(IFS=, ; echo "${open_ports[*]}")
    echo "[*] Found open ports: $ports_csv"
    echo "[*] Running detailed Nmap scan..."

    # Create a filename with the current date and time
    timestamp=$(date +%Y%m%d_%H%M%S)
    output_file="recon${timestamp}.txt"
    
    # Run a detailed Nmap scan and save the results to a file
    nmap -p "$ports_csv" -A -Pn -v "$target" > "$output_file"

    echo "[✔] Scan complete. Report saved as $output_file"
else
    echo "[!] No target ports found open. Skipping detailed scan."
fi