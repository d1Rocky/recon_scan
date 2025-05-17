#!/bin/bash

read -p "Enter target IP or domain: " target

echo "[*] Pinging $target..."
ping -c 3 $target > /dev/null

if [ $? -eq 0 ]; then
    echo "[*] $target is reachable. Continuing scan..."
else
    echo "[!] $target is not reachable. Exiting."
    exit 1
