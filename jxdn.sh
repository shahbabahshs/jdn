clear
sleep 1
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -t raw -F
sleep 1
clear
sudo iptables -t nat -F
sudo iptables -t mangle -F
sudo iptables -t raw -F
sudo iptables -N SAMP-DDOS
iptables -A INPUT -p icmp -j REJECT
iptables -A INPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -A INPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -A OUTPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -A OUTPUT -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -A FORWARD -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j REJECT
iptables -A FORWARD -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -A INPUT -p udp --dport 30000:65535 -m geoip ! --src-cc ID,MY,US,CN,SC -j REJECT
iptables -A INPUT -p udp --dport 1:7776 -j REJECT
iptables -A INPUT -p udp --dport 7778:30000 -j REJECT
iptables -A INPUT -p udp --dport 7777 -m limit --limit 1/s --limit-burst 1 -j REJECT
iptables -A INPUT -p udp --dport 7777 -j ACCEPT
iptables -A INPUT -p udp --dport 7777 -m ttl --ttl-eq=128 -j SAMP-DDOS
iptables -A SAMP-DDOS -p udp --dport 7777 -m length --length 17:604 -j DROP
iptables -A INPUT -p udp -m ttl --ttl-eq=128 -j DROP
iptables -A INPUT -p udp --dport 7777 -m limit --limit 6/s --limit-burst 12 -j DROP
iptables -A INPUT -f -j DROP
iptables -A INPUT -p ICMP -f -j DROP
iptables -A INPUT -m state --state INVALID -j REJECT
iptables -A INPUT -m conntrack --ctstate INVALID -j REJECT
iptables -A INPUT -p tcp ! --syn -m conntrack --ctstate NEW -j REJECT
iptables -A INPUT -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j REJECT
iptables -A INPUT -p tcp --tcp-flags FIN,SYN FIN,SYN -j REJECT
iptables -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j REJECT
iptables -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j REJECT
iptables -A INPUT -p tcp --tcp-flags FIN,RST FIN,RST -j REJECT
iptables -A INPUT -p tcp --tcp-flags FIN,ACK FIN -j REJECT
iptables -A INPUT -p tcp --tcp-flags ACK,URG URG -j REJECT
iptables -A INPUT -p tcp --tcp-flags ACK,FIN FIN -j REJECT
iptables -A INPUT -p tcp --tcp-flags ACK,PSH PSH -j REJECT
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j REJECT
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j REJECT
iptables -A INPUT -p tcp --tcp-flags ALL FIN,PSH,URG -j REJECT
iptables -A INPUT -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j REJECT
iptables -A INPUT -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j REJECT
iptables -A INPUT -s 224.0.0.0/3 -j REJECT
iptables -A INPUT -s 169.254.0.0/16 -j REJECT
iptables -A INPUT -s 172.16.0.0/12 -j REJECT
iptables -A INPUT -s 192.0.2.0/24 -j REJECT
iptables -A INPUT -s 192.168.0.0/16 -j REJECT
iptables -A INPUT -s 10.0.0.0/8 -j REJECT
iptables -A INPUT -s 0.0.0.0/8 -j REJECT
iptables -A INPUT -s 240.0.0.0/5 -j REJECT
iptables -A INPUT -s 127.0.0.0/8 ! -i lo -j REJECT
iptables -t mangle -A PREROUTING -p icmp -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m geoip ! --src-cc ID,MY -j DROP
iptables -t mangle -A PREROUTING -p udp --dport 30000:65535 -m geoip ! --src-cc ID,MY,US,CN,SC -j RETURN
iptables -t mangle -A PREROUTING -p tcp --dport 1:65535 -m geoip ! --src-cc ID,MY,US,CN,SC -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 1:7776 -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7778:30000 -j RETURN
iptables -t mangle -A PREROUTING -p udp --dport 7777 -m limit --limit 1/s --limit-burst 1 -j RETURN
iptables -t mangle -A PREROUTING -f -j DROP
iptables -t mangle -A PREROUTING -p ICMP -f -j DROP
iptables -t mangle -A PREROUTING -m state --state INVALID -j RETURN
iptables -t mangle -A PREROUTING -m conntrack --ctstate INVALID -j RETURN
iptables -t mangle -A PREROUTING -p tcp ! --syn -m conntrack --ctstate NEW -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG NONE -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,SYN FIN,SYN -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags SYN,RST SYN,RST -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags SYN,FIN SYN,FIN -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,RST FIN,RST -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags FIN,ACK FIN -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,URG URG -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,FIN FIN -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ACK,PSH PSH -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL ALL -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL NONE -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL FIN,PSH,URG -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,FIN,PSH,URG -j RETURN
iptables -t mangle -A PREROUTING -p tcp --tcp-flags ALL SYN,RST,ACK,FIN,URG -j RETURN
iptables -t mangle -A PREROUTING -s 224.0.0.0/3 -j RETURN
iptables -t mangle -A PREROUTING -s 169.254.0.0/16 -j RETURN
iptables -t mangle -A PREROUTING -s 172.16.0.0/12 -j RETURN
iptables -t mangle -A PREROUTING -s 192.0.2.0/24 -j RETURN
iptables -t mangle -A PREROUTING -s 192.168.0.0/16 -j RETURN
iptables -t mangle -A PREROUTING -s 10.0.0.0/8 -j RETURN
iptables -t mangle -A PREROUTING -s 0.0.0.0/8 -j RETURN
iptables -t mangle -A PREROUTING -s 240.0.0.0/5 -j RETURN
iptables -t mangle -A PREROUTING -s 127.0.0.0/8 ! -i lo -j RETURN
iptables -A INPUT -p udp --dport 7777 -i eth0 -m state --state NEW -m recent --update --seconds 3 --hitcount 3 -j DROP
iptables -t nat -A PREROUTING -p udp --dport 7777 -s 127.0.0.1 -m string --algo bm --string 'SAMP' -j REDIRECT --to-port 7777
iptables -t nat -A PREROUTING -p udp --dport 7777 -m string -- algo bm --string 'SAMP' -j REDIRECT --to-port 7777
iptables -I INPUT -p udp --dport 7777 -m string --algo bm --string 'SAMP' -m hashlimit ! --hashlimit-upto 3/sec --hashlimit-burst 3/sec --hashlimit-mode srcip --hashlimit-name query -j DROP
iptables -I INPUT -p udp --dport 7777 -m string --algo kmp --hex-string'|081e77da|' -m recent --name test ! --rcheck  -m recent --name test --set -j  DROP
iptables -I INPUT -p udp --dport 7777 -m string --algo kmp --hex-string '|081e77da|'  -m recent --name test --rcheck --seconds 2  --hitcount 1 -j DROP
iptables -I INPUT -p udp --dport 7777 -m string --algo kmp --hex-string '|53414d50|' -m string --algo kmp --hex-string '|611e63|' -m recent --name limitC7777 ! --rcheck -m recent --name limitC7777 --set -j DROP
iptables -I INPUT -p udp --dport 7777 -m string --algo kmp --hex-string '|53414d50|' -m string --algo kmp --hex-string '|611e63|' -m recent --name limitC7777 --rcheck --seconds 2 --hitcount 1   -j DROP
iptables -I INPUT -p udp --dport 7777 -m string --algo kmp --hex-string '|53414d50|' -m string --algo kmp --hex-string '|611e69|' -m recent --name limitI7777 ! --rcheck -m recent --name limitI7777 --set
iptables -I INPUT -p udp --dport 7777 -m string --algo kmp --hex-string '|53414d50|' -m string --algo kmp --hex-string '|611e69|' -m recent --name limitI7777 --rcheck --seconds 2 --hitcount 1   -j DROP
iptables -I INPUT -p udp --dport 7777 -m string --algo kmp --hex-string '|53414d50|' -m string --algo kmp --hex-string '|611e72|' -m recent --name limitR7777 ! --rcheck -m recent --name limitR7777 --set -j DROP
iptables -I INPUT -p udp --dport 7777 -m string --algo kmp --hex-string '|53414d50|' -m string --algo kmp --hex-string '|611e72|' -m recent --name limitR7777 --rcheck --seconds 2 --hitcount 1 -j DROP
iptables -I INPUT -p udp --dport 7777 -m string --algo kmp --hex-string '|53414d50|' -m string --algo kmp --hex-string '|611e72|' -m recent --name limitR7777 --rcheck --seconds 2 --hitcount 1 -j DROP
iptables -t filter -A OUTPUT -p tcp --dport 53 -j ACCEPT
iptables -t filter -A OUTPUT -p udp --dport 53 -j ACCEPT
iptables -t filter -A INPUT -p tcp --dport 53 -j ACCEPT
iptables -t filter -A INPUT -p udp --dport 53 -j ACCEPT
iptables -I INPUT -p udp --dport 80 -m string --string 'GET / HTTP/1.1' --algo bm -j DROP
iptables -I INPUT -p tcp --dport 443 -m string --string 'POST / HTTP/1.1' --algo bm -j DROP
iptables -I OUTPUT -p udp --dport 80 -m string --string 'GET / HTTP/1.1' --algo bm -j DROP
iptables -I OUTPUT -p tcp --dport 443 -m string --string 'POST / HTTP/1.1' --algo bm -j DROP
iptables -A INPUT -p tcp --dport 80 -i eth0 -m state --state NEW -m recent --update --seconds 5 --hitcount 5 -j DROP
iptables -A INPUT -p tcp --dport 443 -i eth0 -m state --state NEW -m recent --update --seconds 5 --hitcount 5 -j DROP
iptables -A INPUT -p icmp --fragment -j DROP
iptables -A OUTPUT -p icmp --fragment -j DROP
iptables -A FORWARD -p icmp --fragment -j DROP
iptables -A INPUT -p icmp -m state --state ESTABLISHED -j DROP
iptables -A OUTPUT -p icmp -m state --state ESTABLISHED -j DROP
iptables -A INPUT -p icmp -m state --state RELATED -j RELATED_ICMP DROP
iptables -A OUTPUT -p icmp -m state --state RELATED -j RELATED_ICMP DROP
iptables -A INPUT -p icmp -j DROP
iptables -A OUTPUT -p icmp -j DROP
iptables -A FORWARD -p icmp -j DROP
iptables -A INPUT -p UDP --dport 7777 -i eth0 -m state --state NEW -m recent --update --seconds 5 --hitcount 5 -j DROP
iptables -A INPUT -p TCP --dport 135:139 -j DROP
iptables -A INPUT -p TCP --syn -m iplimit --iplimit-above 3 -j DROP
iptables -A INPUT -p UDP -m pkttype --pkt-type broadcast -j DROP
iptables -A INPUT -p UDP -m limit --limit 3/s -j ACCEPT
iptables -A INPUT -p tcp --syn -i eth0 -m state --state NEW -m recent --update --seconds 10 --hitcount 10 -j DROP
iptables -A INPUT -m conntrack --ctstate NEW -p tcp --tcp-flags SYN,RST,ACK,FIN,URG,PSH SYN -i eth0 -m state --state NEW -m recent --update --seconds 10 --hitcount 10 -j DROP
iptables -A INPUT -m conntrack --ctstate NEW -p tcp --tcp-flags SYN,RST,ACK,FIN,URG,PSH FIN -i eth0 -m state --state NEW -m recent --update --seconds 10 --hitcount 10 -j DROP
iptables -A INPUT -m conntrack --ctstate NEW -p tcp --tcp-flags SYN,RST,ACK,FIN,URG,PSH ACK -i eth0 -m state --state NEW -m recent --update --seconds 10 --hitcount 10 -j DROP
iptables -A INPUT -m conntrack --ctstate INVALID -p tcp --tcp-flags SYN,RST,ACK,FIN,URG,PSH SYN,RST,ACK,FIN,URG,PSH -j DROP
iptables -A INPUT -m conntrack --ctstate NEW -p tcp --tcp-flags SYN,RST,ACK,FIN,URG,PSH FIN,URG,PSH -i eth0 -m state --state NEW -m recent --update --seconds 10 --hitcount 10 -j DROP
iptables -A INPUT -p UDP -f -j DROP
iptables -A INPUT -p TCP --syn -m iplimit --iplimit-above 5 -j DROP
iptables -A INPUT -m pkttype --pkt-type broadcast -j DROP
sleep 3
netfilter-persistent save
sleep 3
systemctl enable netfilter-persistent
sleep 3
systemctl restart netfilter-persistent
sleep 4
iptables -L
sleep 5
clear
echo '[!] Finished Setup...'