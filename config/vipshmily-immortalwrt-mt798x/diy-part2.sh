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
sed -i 's/192.168.1.1/192.168.6.1/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# Modify ubi the partition size to max 118.5M
sed -i 's/0x6e00000/0x7680000/g' target/linux/mediatek/files-5.4/arch/arm64/boot/dts/mediatek/mt7981-nokia-ea0326gmp.dts

# 修正连接数
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=65536' package/base-files/files/etc/sysctl.conf

# 添加或更新软件包
git clone -b v5 https://github.com/sbwml/luci-app-mosdns.git package/mosdns
#git clone https://github.com/kongfl888/luci-app-adbyby-plus-lite.git package/luci-app-adbyby-plus
#git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages
#rm -rf package/istore/luci-app-quickstart
#rm -rf package/istore/luci-app-store
#git clone https://github.com/kenzok8/openwrt-packages.git package/luci-app-quickstart || luci-app-store
#rm -rf ./feeds/luci/applications/luci-app-openclash
#git clone https://github.com/kenzok8/openwrt-packages.git package/luci-app-openclash