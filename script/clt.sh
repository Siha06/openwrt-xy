sed -i 's/192.168.1.1/192.168.7.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/192.168.7.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/ImmortalWrt/AX3000Pro/g' package/base-files/files/bin/config_generate
sed -i 's#mirrors.vsean.net/openwrt#mirror.nju.edu.cn/immortalwrt#g' package/emortal/default-settings/files/99-default-settings-chinese
mv $GITHUB_WORKSPACE/patch/banner $OPENWRT_PATH/package/base-files/files/etc/banner
mv $GITHUB_WORKSPACE/patch/imm23.05/clt/mac80211.sh $OPENWRT_PATH/package/kernel/mac80211/files/lib/wifi/mac80211.sh
mv $GITHUB_WORKSPACE/patch/imm23.05/clt/defset $OPENWRT_PATH/package/emortal/default-settings/files/99-default-settings
mv $GITHUB_WORKSPACE/patch/imm23.05/clt/10_system.js $OPENWRT_PATH/feeds/luci/modules/luci-mod-status/htdocs/luci-static/resources/view/status/include/10_system.js
mv $GITHUB_WORKSPACE/patch/imm23.05/clt/argon/bg1.jpg $OPENWRT_PATH/feeds/luci/themes/luci-theme-argon/htdocs/luci-static/argon/img/bg1.jpg

git clone --depth=1 https://github.com/Siha06/my-openwrt-packages.git package/my-openwrt-packages

git clone --depth=1 -b openwrt-23.05 https://github.com/immortalwrt/luci.git package/imm-luci23
mv package/imm-luci23/applications/luci-app-accesscontrol feeds/luci/applications/luci-app-accesscontrol
mv package/imm-luci23/applications/luci-app-autoreboot feeds/luci/applications/luci-app-autoreboot
rm -rf package/lean-luci23
