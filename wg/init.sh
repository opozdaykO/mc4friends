#!/bin/bash

# Ждем запуска интерфейса wg0
sleep 5

# Включаем IP forwarding
#echo 1 > /proc/sys/net/ipv4/ip_forward
IP=$(getent hosts minecraft | awk '{print $1}')
echo "MC IP: $IP"

# Настраиваем iptables правила
iptables -t nat -A PREROUTING -i wg0 -p tcp --dport 25565 -j DNAT --to-destination $IP:25565
iptables -t nat -A PREROUTING -i wg0 -p udp --dport 25565 -j DNAT --to-destination $IP:25565
iptables -t nat -A PREROUTING -i wg0 -p tcp --dport 25575 -j DNAT --to-destination $IP:25575

iptables -A FORWARD -i wg0 -o eth0 -p tcp --dport 25565 -j ACCEPT
iptables -A FORWARD -i wg0 -o eth0 -p udp --dport 25565 -j ACCEPT
iptables -A FORWARD -i wg0 -o eth0 -p tcp --dport 25575 -j ACCEPT

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

echo "WireGuard routing rules configured"
