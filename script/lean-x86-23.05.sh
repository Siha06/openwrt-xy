sed -i 's/192.168.1.1/172.168.1.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/172.168.1.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/192.168.1.1/172.168.1.1/g' package/base-files/luci2/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/base-files/luci2/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
sed -i '/shadow/d' package/lean/default-settings/files/zzz-default-settings
sed -i '/distfeeds.conf/d' package/lean/default-settings/files/zzz-default-settings

#完全删除luci版本
sed -i "s/+ ' \/ ' : '') + (luciversion ||/:/g" feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js

if grep -q "openclash=y" "$GITHUB_WORKSPACE/$CONFIG_FILE"; then
    git clone --depth 1 -b core https://github.com/vernesong/OpenClash.git  package/openclash-core
    tar -zxf package/openclash-core/master/meta/clash-linux-amd64.tar.gz -C package/base-files/files/etc/
    mv package/base-files/files/etc/clash package/base-files/files/etc/my-clash
    rm -rf package/openclash-core
fi
mv $GITHUB_WORKSPACE/patch/lean/199-x86-23.05 package/base-files/files/etc/uci-defaults/zz-diy

git clone --depth 1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth 1 https://github.com/fw876/helloworld.git package/helloworld
git clone --depth 1 https://github.com/vernesong/OpenClash.git  package/openclash
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall-packages
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/luci-app-passwall
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2.git package/luci-app-passwall2
git clone --depth 1 https://github.com/destan19/OpenAppFilter.git package/openwrt-oaf
git clone https://github.com/sbwml/luci-app-filemanager.git package/luci-app-filemanager
git clone --depth 1 https://github.com/gSpotx2f/luci-app-cpu-status.git package/luci-app-cpu-status

rm -rf feeds/packages/lang/golang
git clone --depth 1 https://github.com/sbwml/packages_lang_golang -b 24.x feeds/packages/lang/golang

rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git  package/luci-app-argon-config
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon

rm -rf feeds/packages/net/ddns-go
rm -rf feeds/luci/applications/luci-app-ddns-go
sed -i 's/上网时间控制/用户管控/g' feeds/luci/applications/luci-app-accesscontrol/po/zh_Hans/mia.po
git clone --depth 1 https://github.com/sirpdboy/luci-app-advancedplus package/luci-app-advancedplus
git clone --depth 1 https://github.com/sirpdboy/luci-app-ddns-go.git package/luci-app-ddns-go
git clone --depth 1 https://github.com/sirpdboy/luci-app-taskplan.git package/luci-app-taskplan
git clone --depth 1 https://github.com/sirpdboy/luci-app-netwizard package/luci-app-netwizard
git clone --depth 1 https://github.com/sirpdboy/luci-app-parentcontrol package/luci-app-parentcontrol
git clone --depth 1 https://github.com/sirpdboy/netspeedtest.git package/netspeedtest
git clone --depth 1 -b js https://github.com/sirpdboy/luci-theme-kucat.git package/luci-theme-kucat
mv $GITHUB_WORKSPACE/patch/lean/ezopwrt/netwizard.lua package/luci-app-netwizard/luci-app-netwizard/luasrc/controller/netwizard.lua

rm -rf feeds/luci/applications/luci-app-socat
git clone --depth 1 https://github.com/sirpdboy/sirpdboy-package.git package/sirpdboy-package
#mv package/sirpdboy-package/luci-app-pppoe-server package/luci-app-pppoe-server
mv package/sirpdboy-package/luci-app-socat package/luci-app-socat
rm -rf package/sirpdboy-package


rm -rf feeds/packages/utils/docker
rm -rf feeds/packages/utils/dockerd
rm -rf feeds/packages/utils/containerd
rm -rf feeds/packages/utils/runc
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/packages package/imm24pkg
mv package/imm24pkg/utils/containerd feeds/packages/utils/containerd
mv package/imm24pkg/utils/docker feeds/packages/utils/docker
mv package/imm24pkg/utils/dockerd feeds/packages/utils/dockerd
mv package/imm24pkg/utils/runc feeds/packages/utils/runc
rm -rf package/imm24pkg
git clone --depth 1 -b openwrt-23.05 https://github.com/immortalwrt/luci.git package/imm23luci
mv package/imm23luci/applications/luci-app-softethervpn package/luci-app-softethervpn
sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' package/luci-app-softethervpn/Makefile
rm -rf package/imm23luci
git clone --depth 1 -b openwrt-24.10 https://github.com/immortalwrt/luci.git package/imm24luci
mv package/imm24luci/applications/luci-app-pppoe-server package/luci-app-pppoe-server
sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' package/luci-app-pppoe-server/Makefile
rm -rf package/imm24luci
git clone --depth 1 -b master https://github.com/coolsnowwolf/luci.git package/ledeluci
mv package/ledeluci/applications/luci-app-openvpn-server package/luci-app-openvpn-server
sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' package/luci-app-openvpn-server/Makefile
mv package/ledeluci/applications/luci-app-adbyby-plus package/luci-app-adbyby-plus
sed -i 's#../../luci.mk#$(TOPDIR)/feeds/luci/luci.mk#g' package/luci-app-adbyby-plus/Makefile
rm -rf package/ledeluci

rm -rf feeds/luci/applications/luci-app-ipsec-server
git clone --depth 1 https://github.com/kiddin9/kwrt-packages.git package/kwrt-packages
mv package/kwrt-packages/luci-app-ipsec-server package/luci-app-ipsec-server
rm -rf package/kwrt-packages

rm -rf feeds/packages/net/adguardhome
rm -rf feeds/packages/net/alist
rm -rf feeds/luci/applications/luci-app-alist
#rm -rf feeds/packages/net/aria2
#rm -rf feeds/packages/net/ariang
#rm -rf feeds/luci/applications/luci-app-aria2
rm -rf feeds/packages/net/lucky
rm -rf feeds/luci/applications/luci-app-dockerman
rm -rf feeds/luci/applications/luci-app-lucky
rm -rf feeds/packages/net/mosdns
rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/luci/applications/luci-app-openclash
rm -rf feeds/luci/applications/luci-app-openvpn-server
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/luci/applications/luci-app-passwall2
rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/applications/luci-app-smartdns
rm -rf feeds/luci/applications/luci-app-softether
git clone --depth 1 https://github.com/kenzok8/small-package.git package/kz8-small
mv package/kz8-small/adguardhome package/adguardhome
mv package/kz8-small/luci-app-adguardhome package/luci-app-adguardhome
mv package/kz8-small/alist package/alist
mv package/kz8-small/luci-app-alist package/luci-app-alist
#mv package/kz8-small/aria2 package/aria2
#mv package/kz8-small/ariang package/ariang
#mv package/kz8-small/luci-app-aria2 package/luci-app-aria2
mv package/kz8-small/luci-app-bypass package/luci-app-bypass
mv package/kz8-small/luci-app-control-timewol package/luci-app-control-timewol
mv package/kz8-small/luci-app-control-webrestriction package/luci-app-control-webrestriction
mv package/kz8-small/luci-app-control-weburl package/luci-app-control-weburl
mv package/kz8-small/luci-app-chatgpt-web package/luci-app-chatgpt-web
#mv package/kz8-small/luci-app-design-config package/luci-app-design-config
mv package/kz8-small/luci-app-dockerman package/luci-app-dockerman
mv package/kz8-small/luci-app-easymesh package/luci-app-easymesh
mv package/kz8-small/luci-app-eqosplus package/luci-app-eqosplus
mv package/kz8-small/luci-app-guest-wifi package/luci-app-guest-wifi
mv package/kz8-small/luci-app-ikoolproxy package/luci-app-ikoolproxy
mv package/kz8-small/luci-app-ipsec-server package/luci-app-ipsec-server
mv package/kz8-small/iptvhelper package/iptvhelper
mv package/kz8-small/luci-app-iptvhelper package/luci-app-iptvhelper
mv package/kz8-small/lucky package/lucky
mv package/kz8-small/luci-app-lucky package/luci-app-lucky
mv package/kz8-small/mosdns package/mosdns
mv package/kz8-small/luci-app-mosdns package/luci-app-mosdns
#mv package/kz8-small/luci-app-openvpn-server package/luci-app-openvpn-server
#mv package/kz8-small/openvpn-easy-rsa-whisky package/openvpn-easy-rsa-whisky
mv package/kz8-small/luci-app-onliner package/luci-app-onliner
mv package/kz8-small/luci-app-partexp package/luci-app-partexp
mv package/kz8-small/luci-app-pushbot package/luci-app-pushbot
mv package/kz8-small/luci-app-poweroffdevice package/luci-app-poweroffdevice
mv package/kz8-small/luci-app-pptp-server package/luci-app-pptp-server
mv package/kz8-small/smartdns package/smartdns
mv package/kz8-small/luci-app-smartdns package/luci-app-smartdns
#mv package/kz8-small/luci-app-softethervpn package/luci-app-softethervpn
mv package/kz8-small/luci-app-wolplus package/luci-app-wolplus
mv package/kz8-small/wrtbwmon package/wrtbwmon
mv package/kz8-small/luci-app-wrtbwmon package/luci-app-wrtbwmon
sed -i 's/联机用户/已连接用户/g' package/kz8-small/luci-app-onliner/po/zh-cn/onliner.po
rm -rf package/kz8-small
