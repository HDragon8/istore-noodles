#!/bin/bash
function git_clone() {
  git clone --depth 1 $1 $2 || true
 }
function git_sparse_clone() {
  branch="$1" rurl="$2" localdir="$3" && shift 3
  git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
  cd $localdir
  git sparse-checkout init --cone
  git sparse-checkout set $@
  mv -n $@ ../
  cd ..
  rm -rf $localdir
  }
function mvdir() {
mv -n `find $1/* -maxdepth 0 -type d` ./
rm -rf $1
}
git clone --depth 1 https://github.com/HDragon8/A-default-settings A-default-settings
git clone --depth 1 https://github.com/HDragon8/iS-default-settings iS-default-settings

git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall-packages && mvdir openwrt-passwall-packages
git clone --depth 1 https://github.com/fw876/helloworld && mvdir helloworld
rm -rf shadowsocks-rust
#git clone --depth 1 -b luci https://github.com/xiaorouji/openwrt-passwall passwall1 && mv -n passwall1/luci-app-passwall  ./; rm -rf passwall1
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall passwall1 && mv -n passwall1/luci-app-passwall  ./; rm -rf passwall1
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2 passwall2 && mv -n passwall2/luci-app-passwall2 ./;rm -rf passwall2
git clone --depth 1 https://github.com/kenzok8/small && mvdir small
git clone --depth 1 https://github.com/kenzok8/openwrt-packages && mvdir openwrt-packages

rm -rf luci-app-wechatpush
git clone --depth 1 https://github.com/tty228/luci-app-wechatpush
git clone --depth 1 https://github.com/esirplayground/luci-app-poweroff
git clone --depth 1 https://github.com/sirpdboy/luci-app-poweroffdevice
git clone --depth 1 https://github.com/sirpdboy/luci-app-autotimeset
git clone --depth 1 https://github.com/sirpdboy/luci-app-lucky lucik && mv -n lucik/luci-app-lucky ./ ; rm -rf lucik

git clone --depth 1 https://github.com/linkease/nas-packages && mv -n nas-packages/{network/services/*,multimedia/*} ./; rm -rf nas-packages
git clone --depth 1 https://github.com/linkease/nas-packages-luci && mv -n nas-packages-luci/luci/* ./; rm -rf nas-packages-luci
git clone --depth 1 https://github.com/linkease/istore && mv -n istore/luci/* ./; rm -rf istore
git clone --depth 1 https://github.com/linkease/openwrt-app-actions && mv -n openwrt-app-actions/applications/* ./;rm -rf openwrt-app-actions
git clone --depth 1 https://github.com/Lienol/openwrt-package && mv -n openwrt-package/luci-app-timecontrol ./; rm -rf openwrt-package

git_sparse_clone master "https://github.com/immortalwrt/luci" "immluci1" applications/luci-app-timewol applications/luci-app-dufs \
applications/luci-app-autoreboot applications/luci-app-ramfree
git_sparse_clone master "https://github.com/immortalwrt/packages" "impaks" net/dufs lang/rust

rm -rf ./*/.git & rm -f ./*/.gitattributes
rm -rf ./*/.svn & rm -rf ./*/.github & rm -rf ./*/.gitignore

sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?2. Clash For OpenWRT?3. Applications?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
-e 's/ca-certificates/ca-bundle/' \
*/Makefile

sed -i 's/luci-lib-ipkg/luci-base/g' luci-app-store/Makefile
sed -i "/minisign:minisign/d" luci-app-dnscrypt-proxy2/Makefile
#sed -i 's/+dockerd/+dockerd +cgroupfs-mount/' luci-app-docker*/Makefile
#sed -i '$i /etc/init.d/dockerd restart &' luci-app-docker*/root/etc/uci-defaults/*
sed -i 's/+libcap /+libcap +libcap-bin /' luci-app-openclash/Makefile
sed -i 's/\(+luci-compat\)/\1 +luci-theme-argon/' luci-app-argon-config/Makefile
sed -i 's/\(+luci-compat\)/\1 +luci-theme-design/' luci-app-design-config/Makefile
#sed -i 's/\(+luci-compat\)/\1 +luci-theme-argonne/' luci-app-argonne-config/Makefile
sed -i 's/ +uhttpd-mod-ubus//' luci-app-packet-capture/Makefile
sed -i 's/	ip.neighbors/	luci.ip.neighbors/' luci-app-wifidog/luasrc/model/cbi/wifidog/wifidog_cfg.lua
sed -i -e 's/nas/services/g' -e 's/NAS/Services/g' $(grep -rl 'nas\|NAS' luci-app-fileassistant)
#find -type f -name Makefile -exec sed -ri  's#mosdns[-_]neo#mosdns#g' {} \;

#rm -rf luci-app-adguardhome/po/zh_Hans
#cp -Rf luci-app-adguardhome/po/zh-cn luci-app-adguardhome/po/zh_Hans

#rm -rf luci-app-wxedge/po/zh_Hans
#cp -Rf luci-app-wxedge/po/zh-cn luci-app-wxedge/po/zh_Hans
#rm -rf luci-app-wifischedule/po/zh_Hans
#cp -Rf luci-app-wifischedule/po/zh-cn luci-app-wifischedule/po/zh_Hans
#rm -rf luci-app-minidlna/po/zh_Hans
#cp -Rf luci-app-minidlna/po/zh-cn luci-app-minidlna/po/zh_Hans
#cp -Rf luci-app-wrtbwmon/po/zh_Hans luci-app-wrtbwmon/po/zh-cn

#bash diy/create_acl_for_luci.sh -a >/dev/null 2>&1
#bash diy/convert_translation.sh -a >/dev/null 2>&1

#rm -rf create_acl_for_luci.err & rm -rf create_acl_for_luci.ok
#rm -rf create_acl_for_luci.warn

exit 0
