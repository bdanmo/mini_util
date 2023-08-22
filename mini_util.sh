#!/bin/bash
function show_ipinfo() {
#create var, ip_var, to show the ip address of the active interface. i.e., inet field is present -- exclude loopback (lo)
ip_var=$(ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}')
#create var, dgw_var, to show default gateway of this same interface
dgw_var=$(ip route show | grep 'default' | awk '{print $3}')
echo "IP Address: $ip_var"
echo "Default Gateway: $dgw_var"
cat /etc/resolv.conf | grep "nameserver" | grep -v "#"
}

while true
do
clear
echo
echo "UTILITY MENU"
echo "------------"
echo
echo "1 - IP Information"
echo 
echo "2 - Disk usage"
echo
echo "3 - tmpfs usage"
echo
echo "4 - Currently logged in user"
echo 
echo "5 - Quit"
echo
echo "Enter your choice: "
echo
read choice
echo
case $choice in
1) show_ipinfo ;;
2) df -h | grep -v tmpfs  ;;
3) df -h | grep tmpfs ;;
4) whoami ;;
5) clear;exit 0 ;;
*) echo "Invalid choice" ;;
esac
echo
echo "Press Enter to make another selection"
read junk
done


