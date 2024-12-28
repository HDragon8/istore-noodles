# istore-noodles

Copy from
```bash
1、https://github.com/kenzok8/small-package
2、https://github.com/kiddin9/openwrt-packages
```

一键命令(防止插件冲突，删除重复)
```bash
sed -i '1i src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '2i src-git small https://github.com/kenzok8/small' feeds.conf.default
./scripts/feeds update -a && rm -rf feeds/luci/applications/luci-app-mosdns
rm -rf feeds/packages/net/{alist,adguardhome,mosdns,xray*,v2ray*,v2ray*,sing*,smartdns}
rm -rf feeds/packages/utils/v2dat
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang
./scripts/feeds install -a 
make menuconfig
```
注意
编译新版Sing-box和hysteria，尽量使用golang版本1.22以上版本 ，可以用以下命令
```bash
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang
```
