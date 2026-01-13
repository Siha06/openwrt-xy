sed -i 's/192.168.1.1/10.3.2.1/g' package/base-files/files/bin/config_generate
sed -i "s/192\.168\.[0-9]*\.[0-9]*/10.3.2.1/g" $(find ./feeds/luci/modules/luci-mod-system/ -type f -name "flash.js")
sed -i 's/LEDE/OpenWrt/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/10.3.2.1/g' package/base-files/luci/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/base-files/luci/bin/config_generate
sed -i 's/LEDE/OpenWrt/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh
mv $GITHUB_WORKSPACE/patch/lean/199-diy-762x package/base-files/files/etc/uci-defaults/zz-diy
mv $GITHUB_WORKSPACE/patch/banner package/base-files/files/etc/banner
sed -i '/openwrt_release/d' package/lean/default-settings/files/zzz-default-settings
sed -i '/shadow/d' package/lean/default-settings/files/zzz-default-settings
sed -i 's#mirrors.tencent.com/lede#mirrors.pku.edu.cn/immortalwrt#g' package/lean/default-settings/files/zzz-default-settings

#mv $GITHUB_WORKSPACE/patch/lean/patch/fstools-Makefile package/system/fstools/Makefile

#DTS
#mv $GITHUB_WORKSPACE/patch/lean/dts/jcg_q20-based-on-cr660x.dts target/linux/ramips/dts/mt7621_xiaomi_mi-router-cr660x.dts
# mv $GITHUB_WORKSPACE/patch/lean/dts/mt7621_xiaomi_mi-router-4a-3g-v2.dtsi target/linux/ramips/dts/mt7621_xiaomi_mi-router-4a-3g-v2.dtsi
# sed -i 's/14848/16064/g' target/linux/ramips/image/mt7621.mk



# 添加kenzok8_small插件库, 编译新版Sing-box和hysteria，需golang版本1.20或者以上版本 ，可以用以下命令
rm -rf feeds/packages/lang/golang
git clone --depth 1 https://github.com/sbwml/packages_lang_golang -b 25.x feeds/packages/lang/golang
#删除自带的旧插件
rm -rf feeds/packages/net/{mosdns,v2ray-geodata}
rm -rf feeds/luci/applications/{luci-app-bypass，luci-app-passwall,luci-app-passwall2,luci-app-ssr-plus,luci-app-openclash,luci-app-mosdns}
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall.git package/luci-app-passwall
git clone --depth 1 https://github.com/Openwrt-Passwall/openwrt-passwall2.git package/luci-app-passwall2
git clone --depth 1 https://github.com/vernesong/OpenClash.git  package/openclash
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
git clone https://github.com/sbwml/luci-app-mosdns -b v5-lua package/mosdns

git clone --depth 1 -b lua https://github.com/sirpdboy/luci-app-ddns-go.git package/ddns-go
git clone --depth 1 https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
git clone --depth 1 https://github.com/Erope/openwrt_nezha.git package/openwrt_nezha

#有编译openwrt环境后，加入UA2F模块和RKP-IPID模块
#git clone --depth 1 https://github.com/lucikap/luci-app-ua2f.git package/luci-app-ua2f
#git clone --depth 1 https://github.com/Zxilly/UA2F.git package/ua2f
#git clone https://github.com/EOYOHOO/UA2F.git package/UA2F
#git clone https://github.com/EOYOHOO/rkp-ipid.git package/rkp-ipid
#rm -rf feeds/packages/net/ua2f
#rm -rf feeds/luci/applications/luci-app-ua2f

# iStore
git clone --depth 1 -b main https://github.com/linkease/istore.git package/istore
git clone --depth 1 -b master https://github.com/linkease/nas-packages.git package/nas-packages
git clone --depth 1 -b main https://github.com/linkease/nas-packages-luci.git package/nas-luci
mv package/nas-packages/network/services/* package/nas-packages/
rm -rf package/nas-packages/network

#下载5g模块
#git clone --depth=1 https://github.com/Siriling/5G-Modem-Support.git package/5g-modem
#sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh-cn/modem.po
#sed -i 's/移动通信模组/通信模组/g' package/5g-modem/luci-app-modem/po/zh_Hans/modem.po

rm -rf feeds/luci/themes/luci-theme-argon
rm -rf feeds/luci/applications/luci-app-argon-config
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-theme-argon.git package/luci-theme-argon
git clone -b 18.06 --depth 1 https://github.com/jerrykuku/luci-app-argon-config.git package/luci-app-argon-config


#git clone --depth 1 https://github.com/wiwizcom/WiFiPortal.git package/WiFiPortal
#cp -r package/WiFiPortal/dcc2-wiwiz package/
#cp -r package/WiFiPortal/eqos-master-wiwiz package/
#cp -r package/WiFiPortal/wifidog-wiwiz package/
#rm -rf feeds/packages/net/eqos
#rm -rf feeds/luci/applications/luci-app-eqos

rm -rf feeds/packages/net/{adguardhome,tailscale}
git clone --depth 1 https://github.com/kenzok8/small-package.git package/kz8-small
mv package/kz8-small/adguardhome package/adguardhome
mv package/kz8-small/luci-app-adguardhome package/luci-app-adguardhome
mv package/kz8-small/luci-app-bypass package/luci-app-bypass
mv package/kz8-small/luci-app-easymesh package/luci-app-easymesh
mv package/kz8-small/luci-app-eqosplus package/luci-app-eqosplus
mv package/kz8-small/tailscale package/tailscale
mv package/kz8-small/luci-app-tailscale package/luci-app-tailscale
rm -rf package/kz8-small
#修复TailScale配置文件冲突
#sed -i '/\/etc\/init\.d\/tailscale/d;/\/etc\/config\/tailscale/d;' package/tailscale/Makefile
sed -i '/\/files/d' package/tailscale/Makefile
