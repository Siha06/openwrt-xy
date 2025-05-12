sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/luci2/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/base-files/luci2/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
#mv $GITHUB_WORKSPACE/patch/lean/199-ipq-wifi package/base-files/files/etc/uci-defaults/zz-ipq
mv $GITHUB_WORKSPACE/patch/lean/199-ipq-nowifi package/base-files/files/etc/uci-defaults/zz-ipq
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner

if grep -q "openclash=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
    git clone --depth 1 -b core https://github.com/vernesong/OpenClash.git  package/openclash-core
    tar -zxf package/openclash-core/master/meta/clash-linux-arm64.tar.gz -C package/base-files/files/etc/
    mv package/base-files/files/etc/clash package/base-files/files/etc/my-clash
    rm -rf package/openclash-core
fi
rm -rf feeds/packages/lang/golang
git clone --depth 1 https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang
rm -rf feeds/packages/net/{alist,adguardhome,mosdns,smartdns}
rm -rf feeds/packages/net/{chinadns-ng,dns2socks,geoview,hysteria,ipt2socks,microsocks,naiveproxy,shadowsocks-libev,shadowsocks-rust,shadowsocksr-libev}
rm -rf feeds/packages/net/{simple-obfs,sing-box,tcping,trojan-plus,tuic-client,v2ray-geodata,v2ray-plugin,xray-core,xray-plugin}
rm -rf feeds/packages/net/{dns2socks-rust,dns2tcp,dnsproxy,gn,redsocks2,shadow-tls,trojan,v2ray-core}
#rm -rf feeds/packages/utils/v2dat
git clone --depth 1 https://github.com/fw876/helloworld.git package/helloworld
git clone --depth 1 https://github.com/vernesong/OpenClash.git  package/openclash
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall-packages
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/luci-app-passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2.git package/luci-app-passwall2
git clone https://github.com/sbwml/luci-app-mosdns -b v5-lua package/mosdns
#git clone --depth 1 https://github.com/sbwml/luci-app-filemanager.git package/luci-app-filemanager
git clone --depth 1 https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go
git clone --depth 1 -b lua https://github.com/sbwml/luci-app-alist.git package/alist

# iStore
git clone --depth 1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth 1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
git clone --depth 1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
mv package/nas-packages/network/services/* package/nas-packages/
rm -rf package/nas-packages/network

#ua2f
#git clone https://github.com/lucikap/luci-app-ua2f.git package/luci-app-ua2f
#git clone https://github.com/Zxilly/UA2F.git package/UA2F
#git clone https://github.com/EOYOHOO/rkp-ipid.git package/rkp-ipid
#rm -rf feeds/packages/net/ua2f


#下载5g模块
#git clone --depth 1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
#sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh-cn/modem.po
#sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh_Hans/modem.po

rm -rf feeds/luci/themes/luci-theme-argon
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git feeds/luci/themes/luci-theme-argon-config
git clone --depth 1 https://github.com/LemonCrab666/openwrt-luci-app-openvpn-server.git package/luci-app-openvpn-server
git clone --depth 1 https://github.com/sirpdboy/luci-app-autotimeset.git package/luci-app-autotimeset

rm -rf feeds/packages/net/adguardhome
rm -rf feeds/packages/net/alist
rm -rf feeds/luci/applications/luci-app-alist
rm -rf feeds/packages/net/lucky
rm -rf feeds/luci/applications/luci-app-lucky
rm -rf feeds/luci/applications/luci-app-openclash
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/luci/applications/luci-app-passwall2
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/applications/luci-app-smartdns
rm -rf feeds/luci/applications/luci-app-openvpn-server
rm -rf feeds/luci/applications/luci-app-pptp-server
git clone --depth 1 https://github.com/kenzok8/small-package.git package/kz8-small
mv package/kz8-small/adguardhome package/adguardhome
mv package/kz8-small/luci-app-adguardhome package/luci-app-adguardhome
mv package/kz8-small/luci-app-chatgpt-web package/luci-app-chatgpt-web
mv package/kz8-small/luci-app-dnsfilter package/luci-app-dnsfilter
mv package/kz8-small/luci-app-easymesh package/luci-app-easymesh
mv package/kz8-small/luci-app-eqosplus package/luci-app-eqosplus
mv package/kz8-small/iptvhelper package/iptvhelper
mv package/kz8-small/luci-app-iptvhelper package/luci-app-iptvhelper
mv package/kz8-small/lucky package/lucky
mv package/kz8-small/luci-app-lucky package/luci-app-lucky
mv package/kz8-small/homebox package/homebox
mv package/kz8-small/luci-app-netspeedtest package/luci-app-netspeedtest
mv package/kz8-small/luci-app-pptp-server package/luci-app-pptp-server
#mv package/kz8-small/luci-app-openvpn-server package/luci-app-openvpn-server
#mv package/kz8-small/luci-app-openvpn-client package/luci-app-openvpn-client
rm -rf package/kz8-small
