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
#sed -i 's/0x6e00000/0x7680000/g' target/linux/mediatek/files-5.4/arch/arm64/boot/dts/mediatek/mt7981-nokia-ea0326gmp.dts

# 修正连接数
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=65536' package/base-files/files/etc/sysctl.conf

# 替换编译目录文件
cp -f $GITHUB_WORKSPACE/config/vipshmily-immortalwrt-mt798x/mt7981-nokia-ea0326gmp.dts $GITHUB_WORKSPACE/openwrt/target/linux/mediatek/files-5.4/arch/arm64/boot/dts/mediatek/mt7981-nokia-ea0326gmp.dts

# 自定义添加/删除/更新软件包
rm -rf package/istore/luci-app-quickstart
rm -rf package/istore/luci-app-store
rm -rf package/istore/quickstart
git clone https://github.com/kenzok8/small-package.git package/small-package

rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

rm -rf feeds/luci/applications/luci-app-adbyby-plus
git clone https://github.com/coolsnowwolf/luci.git package/luci-app-adbyby-plus

rm -rf feeds/luci/applications/luci-app-openclash
rm -rf package/small-package/luci-app-openclash
git clone --depth=1 -b master https://github.com/vernesong/OpenClash.git package/luci-app-openclash

##-----------------Add OpenClash dev core------------------
curl -sL -m 30 --retry 2 https://raw.githubusercontent.com/vernesong/OpenClash/core/master/dev/clash-linux-arm64.tar.gz -o /tmp/clash.tar.gz
tar zxvf /tmp/clash.tar.gz -C /tmp >/dev/null 2>&1
chmod +x /tmp/clash >/dev/null 2>&1
mkdir -p package/luci-app-openclash/luci-app-openclash/root/etc/openclash/core
mv /tmp/clash package/luci-app-openclash/luci-app-openclash/root/etc/openclash/core/clash >/dev/null 2>&1
rm -rf /tmp/clash.tar.gz >/dev/null 2>&1

##-----------------Manually set CPU frequency for MT7981B-----------------
sed -i '/"mediatek"\/\*|\"mvebu"\/\*/{n; s/.*/\tcpu_freq="1680MHz" ;;/}' package/emortal/autocore/files/generic/cpuinfo