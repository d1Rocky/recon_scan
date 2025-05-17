#!/bin/bash

read -p "Enter target IP or domain: " target

echo "[*] Pinging $target..."
ping -c 3 $target > /dev/null


