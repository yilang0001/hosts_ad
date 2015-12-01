#!/bin/bash
sleep 60
wget -qO- http://www.mvps.org/winhelp2002/hosts.txt|grep "^0.0.0.0" >> /tmp/hosts/block
echo winhelp2002 added, waiting...
wget -qO- http://www.malwaredomainlist.com/hostslist/hosts.txt|awk '{sub(/^127.0.0.1/, "0.0.0.0")} /^0.0.0.0/' >>/tmp/hosts/block
echo malwaredominlist added, waiting...
wget -qO- --no-check-certificate https://raw.githubusercontent.com/yilang0001/hosts_ad/master/host.txt|grep "^0.0.0.0" >> /tmp/hosts/block
echo personallist added, waiting...
wget -qO- --no-check-certificate https://raw.githubusercontent.com/rasso1/youkuantiads/master/hosts|awk '{sub(/^127.0.0.1/, "0.0.0.0")} /^0.0.0.0/' >> /tmp/hosts/block
echo youkuantiads added, waiting...
wget -qO- --no-check-certificate https://raw.githubusercontent.com/vokins/simpleu/master/hosts|awk '{sub(/^127.0.0.1/, "0.0.0.0")} /^0.0.0.0/' >> /tmp/hosts/block
echo simpleu added, waiting...
sort /tmp/hosts/block|uniq -u >>/tmp/hosts/sorted
wget -qO- --no-check-certificate https://raw.githubusercontent.com/yilang0001/hosts_ad/master/white.list>> /tmp/hosts/white
awk '/^[^#]/ {sub(/\r$/,"");print $1}' /tmp/hosts/white | grep -vf - /tmp/hosts/sorted >/tmp/hosts/block
/etc/init.d/dnsmasq restart
rm -f  /tmp/hosts/white
rm -f  /tmp/hosts/sorted
cat /tmp/hosts/block
