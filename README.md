# v2ray-padavan-doh

本文为在k2p路由器使用padavan(N56U/改华硕)固件安装配置v2ray及doh的进阶流程，v2ray一揽子方案（简单）在这里[v2ray-padavan](https://github.com/felix-fly/v2ray-padavan)，本文同时也是建立在此基础上的，有些内容不做过多说明，不明白可以先看一下此文。

## 上传软件

支持json并压缩好的v2ray可以[在此下载](https://github.com/felix-fly/v2ray-openwrt/releases)

将所有文件上传至路由器，并添加执行权限

```shell
mkdir /etc/storage/v2ray
cd /etc/storage/v2ray
chmod +x v2ray https_dns_proxy *.sh
```

## dnsmasq配置

通过padavan管理界面修改，dnsmasq拦截广告并将gw转至doh进行解析。

**内部网络(LAN) -> DHCP服务器 -> 自定义配置文件 "dnsmasq.conf"**

```shell
conf-dir=/etc/storage/v2ray/,*.hosts
```

## doh配置

通过[https_dns_proxy](https://github.com/aarond10/https_dns_proxy)实现，对应脚本doh.sh
```shell
./https_dns_proxy -p 1053 -d -r "https://1.1.1.1/dns-query?" &
```
此处**1.1.1.1**为上级dns地址，可以使用红鱼提供的，替换即可
* 东亚: ea-dns.rubyfish.cn
* 美国西部: uw-dns.rubyfish.cn
建议使用自建的，和v2ray同server可以享受到cdn加速的效果

## 设置v2ray开机自动启动

**高级设置 -> 自定义设置 -> 脚本 -> 在路由器启动后执行:**

```shell
/etc/storage/v2ray/check.sh &
```

**高级设置 -> 自定义设置 -> 脚本 -> 在防火墙规则启动后执行:**

```shell
/etc/storage/v2ray/doh.sh
/etc/storage/v2ray/iptables.sh
```

## 保存软件及配置

padavan系统文件系统是构建在内存中的，重启后软件及配置会丢失，所以操作完成后，需要将v2ray及配置写入闪存。

**高级设置 -> 系统管理 -> 配置管理 -> 保存内部存储到闪存: 提交**

由于v2ray程序比较大，提交保存操作需要一定的时间，点过提交后请耐心等待1分钟，以确保写入成功。

如果一切顺利，重启路由器后你想要的v2ray依然在默默守护着你。Good luck!

## 更新记录
2019-08-06
* 草稿，doh待处理
