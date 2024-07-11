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

# 默认开启 wifi
sed -i 's/disabled=1/disabled=0/g' package/kernel/mac80211/files/lib/wifi/mac80211.sh

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# 修正连接数
#sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=65536' package/base-files/files/etc/sysctl.conf

# 使用原始最新版本，而不是上游package里面的
git clone -b v5 https://github.com/sbwml/luci-app-mosdns.git package/mosdns