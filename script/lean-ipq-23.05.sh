sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/luci2/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/base-files/luci2/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
mv $GITHUB_WORKSPACE/patch/lean/defset package/lean/default-settings/files/zzz-default-settings
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/lean/mac80211.sh package/kernel/mac80211/files/lib/wifi/mac80211.sh

rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang
rm -rf feeds/packages/net/{alist,adguardhome,mosdns,xray*,v2ray*,v2ray*,sing*,smartdns}
rm -rf feeds/packages/utils/v2dat
#git clone --depth=1 https://github.com/kenzok8/small.git package/small
#git clone --depth=1 https://github.com/fw876/helloworld.git package/helloworld
git clone --depth 1 https://github.com/vernesong/OpenClash.git  package/openclash
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages.git package/passwall-packages
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall.git package/luci-app-passwall
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone --depth 1 https://github.com/sbwml/luci-app-filemanager.git package/luci-app-filemanager


# iStore
git clone --depth=1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth=1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
git clone --depth=1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
mv package/nas-packages/network/services/* package/nas-packages/
rm -rf package/nas-packages/network

#下载5g模块
#git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
#sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh-cn/modem.po
#sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh_Hans/modem.po

rm -rf feeds/luci/themes/luci-theme-argon
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
git clone --depth 1 https://github.com/sirpdboy/luci-app-advancedplus package/luci-app-advancedplus

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
git clone --depth=1 https://github.com/kenzok8/small-package.git package/kz8-small
mv package/kz8-small/adguardhome package/adguardhome
mv package/kz8-small/luci-app-adguardhome package/luci-app-adguardhome
mv package/kz8-small/alist package/alist
mv package/kz8-small/luci-app-chatgpt-web package/luci-app-chatgpt-web
mv package/kz8-small/luci-app-easymesh package/luci-app-easymesh
mv package/kz8-small/luci-app-eqosplus package/luci-app-eqosplus
mv package/kz8-small/iptvhelper package/iptvhelper
mv package/kz8-small/luci-app-iptvhelper package/luci-app-iptvhelper
mv package/kz8-small/lucky package/lucky
mv package/kz8-small/luci-app-lucky package/luci-app-lucky
mv package/kz8-small/homebox package/homebox
mv package/kz8-small/luci-app-netspeedtest package/luci-app-netspeedtest
rm -rf package/kz8-small
