sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.23.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/192.168.1.1/192.168.23.1/g' package/base-files/luci2/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/base-files/luci2/bin/config_generate

#mv $GITHUB_WORKSPACE/patch/banner $OPENWRT_PATH/package/base-files/files/etc/banner
#mv $GITHUB_WORKSPACE/patch/lean/defset $OPENWRT_PATH/package/lean/default-settings/files/zzz-default-settings

#git clone --depth=1 https://github.com/fw876/helloworld.git package/helloworld

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
#sed -i 's/\"network\"/\"modem\"/g' package/5g-modem/luci-app-modem/luasrc/controller/modem.lua

rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config
git clone --depth=1 https://github.com/jerrykuku/luci-app-argon-config.git  package/luci-app-argon-config
git clone --depth=1 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
