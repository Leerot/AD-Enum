#!/bin/bash

# ┌─────────────────────────────────────────────────────────┐
# │               ENUM AD by Leerot                │
# └─────────────────────────────────────────────────────────┘

cat << 'EOF'
 ___           _______       _______       ________      ________      _________   
|\  \         |\  ___ \     |\  ___ \     |\   __  \    |\   __  \    |\___   ___\ 
\ \  \        \ \   __/|    \ \   __/|    \ \  \|\  \   \ \  \|\  \   \|___ \  \_| 
 \ \  \        \ \  \_|/__   \ \  \_|/__   \ \   _  _\   \ \  \\\  \       \ \  \  
  \ \  \____    \ \  \_|\ \   \ \  \_|\ \   \ \  \\  \|   \ \  \\\  \       \ \  \ 
   \ \_______\   \ \_______\   \ \_______\   \ \__\\ _\    \ \_______\       \ \__\
    \|_______|    \|_______|    \|_______|    \|__|\|__|    \|_______|        \|__|
EOF

# data
read -p "Domain (dc.machine.htb): " domain
read -p "Host (machine.htb): " name
read -p "IP machine: " ip
read -p "User: " user
read -s -p "Password: " password
echo ""

# users
echo "[*] Extracting users ..."
nxc smb "$name" -u "$user" -p "$password" --rid-brute | \
grep "SidTypeUser" | awk -F '\\' '{print $2}' | awk '{print $1}' > enum_users.txt

# smbmap
echo "[*] Extracting smbmap ..."
smbmap -H "$ip" -u "$user" -p "$password" > enum_smbmap.txt

# bloodhound json
echo "[*] Extracting bloodhound db ..."
bloodhound-python -u "$user" -p "$password" -d $domain -c All --zip -ns $ip


echo "[+] File obtained:"
echo " - enum-users.txt"
echo " - enum-smbmap.txt"
echo " - bloodhound.zip"



