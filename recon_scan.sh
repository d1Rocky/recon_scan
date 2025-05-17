#!/bin/bash

read -p "Enter target IP or domain: " target

echo "[*] Pinging $target..."
ping -c 3 $target > /dev/null

if [ $? -eq 0 ]; then
    echo "[*] $target is reachable. Continuing scan..."
else
    echo "[!] $target is not reachable. Exiting."
    exit 1

fi

echo "[*] Running quick Nmap scan on all ports..."
nmap_output=$(nmap -p- -Pn -T5 -v $target)

# Ports of interest
ports_to_check=(3389 22 23 445 80 8080 21 25)
open_ports=()

# Extract open ports from the scan
for port in "${ports_to_check[@]}"; do
    if echo "$nmap_output" | grep -q "$port/tcp open"; then
        open_ports+=("$port")
    fi
done