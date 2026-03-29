#!/bin/sh

# 修改默认 LAN IP
uci set network.lan.ipaddr='192.168.2.1'
uci commit network

# 修改主机名与时区
uci set system.@system[0].hostname='ImmortalWrt'
uci set system.@system[0].timezone='CST-8'
uci set system.@system[0].zonename='Asia/Shanghai'
uci commit system

# 启用 SmartDNS，监听本地 6053 端口
uci set smartdns.@smartdns[0].enabled='1'
uci set smartdns.@smartdns[0].port='6053'
uci set smartdns.@smartdns[0].bind_interface='lo'
uci commit smartdns

# 将 dnsmasq 上游指向 SmartDNS
uci set dhcp.@dnsmasq[0].server='127.0.0.1#6053'
uci set dhcp.@dnsmasq[0].noresolv='1'
uci commit dhcp

exit 0
