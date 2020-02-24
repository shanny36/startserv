#!/bin/bash

# sources .bashrc alias + binds
cd && rm .bashrc ; wget https://github.com/shanny36/startserv/raw/master/.bashrc && source .bashrc

# Update the system
qup2 && apt -y install apt-transport-https ca-certificates curl gnupg-agent software-properties-common nano bash-completion sudo ufw git lsb-release wget qrencode

# Add the Repo and Install Wireguard
echo 'Add the repository and Install Wireguard'
sleep 1

add-apt-repository -y ppa:wireguard/wireguard

apt update

apt install wireguard -y

# remove dnsmasq as it will run inside the container
echo ''
echo ''
echo 'Remove DNSMasq'
sleep 1

apt remove -y dnsmasq

# install OpenResolv for DNS handling
echo ''
echo ''
echo 'Install OpenResolv'
sleep 1
apt install openresolv -y

# Load Modules
echo ''
echo ''
echo 'Load the Modules for Wireguard'
sleep 1

echo '--> modprobe wireguard'
modprobe wireguard

echo '--> modprobe iptable_nat'
modprobe iptable_nat

echo '--> modprobe ip6table_nat'
modprobe ip6table_nat

# Enable IP Packet forwarding
echo ''
echo ''
echo 'Enable IP Packet Forwarding'
sleep 1

sysctl -w net.ipv4.ip_forward=1
sysctl -w net.ipv6.conf.all.forwarding=1

# Install Docker
echo ''
echo ''
echo 'Install WireGuard Scripts'
sleep 1
curl https://raw.githubusercontent.com/complexorganizations/wireguard-manager/master/wireguard-server.sh --create-dirs -o /etc/wireguard/wireguard-server.sh

chmod +x /etc/wireguard/wireguard-server.sh

echo ''
echo ''

sleep 5

echo ''
echo ''
