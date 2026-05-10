#!/bin/bash
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# Modify default IP
sed -i 's/192.168.1.1/192.168.7.1/g' package/base-files/files/bin/config_generate

# 默认开启 wifi
#sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# 设置密码为空
#sed -i '/CYXluq4wUazHjmCDBCqXF/d' package/emortal/default-settings/files/99-default-settings

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# Modify ubi the partition size to max 118.5M
#sed -i 's/0x6e00000/0x7680000/g' target/linux/mediatek/dts/mt7981b-nokia-ea0326gmp.dts

# 替换编译目录文件
sed -i 's/14848/16064/g' target/linux/ramips/image/mt7621.mk
cp -f $GITHUB_WORKSPACE/config/immortalwrt/mt7621_xiaomi_mi-router-4a-common.dtsi $GITHUB_WORKSPACE/openwrt/target/linux/ramips/dts/mt7621_xiaomi_mi-router-4a-common.dtsi
cp -f $GITHUB_WORKSPACE/config/immortalwrt/mt7628an_xiaomi_mi-router-4c.dts $GITHUB_WORKSPACE/openwrt/target/linux/ramips/dts/mt7628an_xiaomi_mi-router-4c.dts

# 自定义添加/删除/更新软件包
#rm -rf feeds/packages/lang/golang
#git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

#rm -rf package/istore/luci-app-quickstart
#rm -rf package/istore/quickstart
#rm -rf package/istore/luci-app-store
#git clone https://github.com/kenzok8/small-package.git package/small-package
#git clone https://github.com/kiddin9/kwrt-packages.git package/luci-app-quickstart || luci-app-store

#rm -rf feeds/luci/applications/luci-app-adbyby-plus
#rm -rf feeds/net/applications/luci-app-adbyby-plus
#git clone https://github.com/coolsnowwolf/luci.git package/luci-app-adbyby-plus
#git clone --depth=1 -b main https://github.com/kongfl888/luci-app-adbyby-plus-lite.git package/luci-app-adbyby-plus

#rm -rf feeds/luci/applications/luci-app-openclash
#rm -rf package/small-package/luci-app-openclash
#git clone --depth=1 -b master https://github.com/vernesong/OpenClash.git package/luci-app-openclash

##-----------------Add OpenClash meta core------------------
#curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/meta/clash-linux-arm64.tar.gz -o /tmp/clash.tar.gz
#tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
#chmod +x /tmp/clash >/dev/null 2>&1
#mkdir -p feeds/luci/applications/luci-app-openclash/root/etc/openclash/core
#mv /tmp/clash feeds/luci/applications/luci-app-openclash/root/etc/openclash/core/clash_meta >/dev/null 2>&1
#rm -rf /tmp/clash.tar.gz >/dev/null 2>&1

##-----------------Manually set CPU frequency for MT7981B-----------------
#sed -i '/"mediatek"\/\*|\"mvebu"\/\*/{n; s/.*/\tcpu_freq="1.1GHz" ;;/}' package/emortal/autocore/files/generic/cpuinfo