#!/bin/bash
function show_ipinfo() {
    #create var, ip_var, to show the ip address of the active interface, put on one line separated by commas and spaces
    ip_var=$(ifconfig | grep 'inet ' | grep -v '127.0.0.1' | awk '{print $2}' | awk 'BEGIN{ORS=", "}{print}' | sed 's/, $//')
    #create var, dgw_var, to show default gateway of this same interface
    dgw_var=$(ip route show | grep 'default' | awk '{print $3}')
    #get dns servers from nmcli, remove repeated lines, and put on one line separated by commas and spaces
    dns_var=$(nmcli dev show | grep DNS | awk '{print $2}' | sort | uniq | awk 'BEGIN{ORS=", "}{print}' | sed 's/, $//')
    echo "IP Address: $ip_var"
    echo "Default Gateway: $dgw_var"
    echo "DNS Servers: $dns_var"
}

while true; do
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
    read -s -n 1 choice
    case $choice in
    1) show_ipinfo ;;
    2) df -h | grep -v tmpfs ;;
    3) df -h | grep tmpfs ;;
    4) whoami ;;
    5)
        clear
        exit 0
        ;;
    *) echo "Invalid choice" ;;      
    esac
    echo
    echo -n "Press any key to continue"
    read -n 1
done
