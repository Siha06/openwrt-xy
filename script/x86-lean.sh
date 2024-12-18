sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.10.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/luci2/bin/config_generate
#sed -i 's/LEDE/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/LEDE/EzOpWrt/g' package/base-files/files/bin/config_generate
sed -i 's/LEDE/EzOpWrt/g' package/base-files/luci2/bin/config_generate
sed -i 's/LEDE/EzOpWrt/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

mv $GITHUB_WORKSPACE/patch/lean/index.htm feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/lean/defset package/lean/default-settings/files/zzz-default-settings
rm -rf feeds/smpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd*,miniupnpd-iptables,wireless-regdb}
rm -rf feeds/smpackage/luci-app-advanced
rm -rf feeds/smpackage/luci-app-wizard
mv $GITHUB_WORKSPACE/patch/lean/others/99-msd_lite package/base-files/files/etc/99-msd_lite
mv $GITHUB_WORKSPACE/patch/lean/others/99-udpxy package/base-files/files/etc/99-udpxy
git clone --depth=1 -b main https://github.com/linkease/istore.git package/istore

#下载5g模块
#git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
#sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh-cn/modem.po
#sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh_Hans/modem.po


rm -rf feeds/luci/themes/luci-theme-argon
#rm -rf feeds/luci/applications/luci-app-argon-config
#git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git  package/luci-app-argon-config
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon

#rm -rf package/luci-app-amlogic
#git clone https://github.com/ophub/luci-app-amlogic.git package/luci-app-amlogic
#git clone --depth=1 https://github.com/kiddin9/openwrt-clouddrive2.git  package/clouddrive2
#git clone --depth=1 https://github.com/fw876/helloworld.git package/helloworld
联机用户
sed -i 's/联机用户/已连接用户/g' feeds/smpackage/luci-app-onliner/po/zh-cn/onliner.po
sed -i 's/上网时间控制/用户管控/g' feeds/luci/applications/luci-app-accesscontrol/po/zh-cn/mia.po
git clone --depth 1 https://github.com/sirpdboy/luci-app-advancedplus package/luci-app-advancedplus
git clone --depth 1 https://github.com/sirpdboy/luci-app-netwizard package/luci-app-netwizard
git clone --depth 1 https://github.com/sirpdboy/luci-app-parentcontrol package/luci-app-parentcontrol
git clone --depth 1 https://github.com/sirpdboy/sirpdboy-package.git package/sirpdboy-package
mv package/sirpdboy-package/luci-app-pppoe-server feeds/luci-app-pppoe-server
mv package/sirpdboy-package/luci-app-socat feeds/luci-app-socat
mv package/sirpdboy-package/luci-app-wolplus feeds/luci-app-wolplus
rm -rf package/sirpdboy-package

rm -rf feeds/packages/utils/docker
rm -rf feeds/packages/utils/dockerd
rm -rf feeds/packages/net/aria2
rm -rf feeds/luci/applications/luci-app-aria2
rm -rf feeds/luci/applications/luci-app-socat
rm -rf feeds/luci/applications/luci-app-pptp-server

rm -rf feeds/smpackage/luci-app-pppoe-server
rm -rf feeds/smpackage/luci-app-socat
rm -rf feeds/smpackage/luci-app-wolplus
