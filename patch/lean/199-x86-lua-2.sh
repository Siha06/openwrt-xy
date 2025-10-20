#!/bin/sh

#uci set network.lan.ipaddr=192.168.2.2
#uci set network.lan.gateway=192.168.2.1
#uci set network.lan.dns=192.168.2.1
#uci set dhcp.lan.ignore=1
#uci set network.lan.proto='dhcp'
#uci set luci.main.mediaurlbase=/luci-static/design
#uci commit luci

# 设置默认防火墙规则，方便虚拟机首次访问 WebUI
uci set firewall.@zone[1].input='ACCEPT'
# 设置所有网口可访问网页终端
uci delete ttyd.@ttyd[0].interface

# 设置所有网口可连接 SSH
uci set dropbear.@dropbear[0].Interface=''

uci commit

sed -i '/core/d' /etc/opkg/distfeeds.conf
sed -i '/smpackage/d' /etc/opkg/distfeeds.conf
sed -i '/kwrt/d' /etc/opkg/distfeeds.conf
sed -i 's#24.10.0/packages/aarch64_cortex-a53/luci#packages-18.06-k5.4/x86_64/luci#g' /etc/opkg/distfeeds.conf
date_version=$(date +"%Y.%m.%d")
sed -i '/DISTRIB_REVISION/d' /etc/openwrt_release
echo "DISTRIB_REVISION='V${date_version}'" >> /etc/openwrt_release
sed -i '/DISTRIB_DESCRIPTION/d' /etc/openwrt_release
echo "DISTRIB_DESCRIPTION='OpenWrt  '" >> /etc/openwrt_release

OPENCLASH_FILE="/etc/config/openclash"
if [ -f "$OPENCLASH_FILE" ]; then
    tar -zxf /etc/clash-linux-amd64.tar.gz -C /etc/openclash/core/
    mv /etc/openclash/core/clash /etc/openclash/core/clash_meta
    rm -rf /etc/clash-linux-amd64.tar.gz
fi

#sed -i 's/eth0/eth99/g' /etc/config/network

# 根据网卡数量配置网络
eth_count=0
for iface in /sys/class/net/*; do
  iface_name=$(basename "$iface")
  # 检查是否为物理网卡（排除回环设备和无线设备）
  if [ -e "$iface/device" ] && echo "$iface_name" | grep -Eq '^eth|^en'; then
    eth_count=$((count + 1))
  fi
done
# 统计eth接口数量，大于1个则将eth0设为wan其它网口设为lan，只有1个则设置成DHCP模式
eth_count=$(ls /sys/class/net | grep -c '^eth')
if [ $eth_count -gt 1 ]; then
    uci set network.wan.ifname='eth0'
    uci set network.wan6.ifname='eth0'
    uci set network.lan.ifname="$(ls /sys/class/net | grep -E '^eth[1-9]$' | tr '\n' ' ' | sed 's/ \+$//')"
else
    uci set network.lan.proto='dhcp'
    uci set dhcp.lan.ignore='1'
fi

#uci set network.lan._orig_bridge=true
#uci set network.wan._orig_bridge=false
uci commit network

uci commit
/etc/init.d/network restart

exit 0
