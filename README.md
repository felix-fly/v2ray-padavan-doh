# v2ray-padavan-doh

本文为在k2p路由器使用padavan(N56U/改华硕)固件安装配置v2ray的进阶流程，v2ray一揽子方案（简单）在这里[v2ray-padavan](https://github.com/felix-fly/v2ray-padavan)，本文同时也是建立在此基础上的，有些内容不做过多说明，不明白可以先看一下此文。

***固件增加了新选择xray，用法参考v2ray**

前期v2ray是外置在storage下，现在改为将v2ray内置打包到padavan固件中。使用actions来构建，笔者使用的是k2p，如果是padavan支持的其它型号的路由，可以参考修改打造你自己的固件。

编译好的纯净版固件可以[在release下载](https://github.com/felix-fly/v2ray-padavan-doh/releases)，默认只保留了ipset和单文件的[v2ray](https://github.com/felix-fly/v2ray-openwrt/releases)。需要其它插件的话可以自行修改**k2p.config**文件编译。

### smartdns

2021年3月8日增加了smartdns，接替dnsmasq完成dns相关服务。[**性能更优，体验更好，进一步了解更多**](./smartdns.md)

v2ray使用tls相关协议时会需要验证证书的有效性，而padavan默认是没有包含ssl根证书的。简单的方式可以配置v2ray不验证，但是出于安全性的考虑，还是要验证的比较好。鉴于此，固件里内置了一份证书合集，放在了 ```/usr/lib/cacert.pem``` , 文件来源于 **https://curl.haxx.se/docs/caextract.html**

> CA certificates extracted from Mozilla

## 上传配置

刷好固件后，将v2ray文件夹里的所有文件上传至路由器/etc/storage/v2ray目录，并添加脚本执行权限

**如果配合 smartdns 一起使用，需要删除 v2ray 文件夹里面的 *.hosts 和 *.ips 文件**

```bash
mkdir /etc/storage/v2ray
cd /etc/storage/v2ray
chmod +x *.sh
```

## dnsmasq配置（二选一：不使用smartdns）

通过padavan管理界面修改，dnsmasq拦截广告并将gw域名转给v2ray进行解析。

**内部网络(LAN) -> DHCP服务器 -> 自定义配置文件 "dnsmasq.conf"**

```bash
conf-dir=/etc/storage/v2ray/,*.hosts
```

## dnsmasq配置（二选一：使用smartdns提供dns解析服务）

[**具体配置参考关于smartdns的描述**](./smartdns.md)

## 设置v2ray开机自动启动

**高级设置 -> 自定义设置 -> 脚本 -> 在路由器启动后执行:**

```bash
/etc/storage/v2ray/check.sh &
```

**高级设置 -> 自定义设置 -> 脚本 -> 在防火墙规则启动后执行:**

```bash
/etc/storage/v2ray/iptables.sh
```

## 保存软件及配置

padavan系统文件系统是构建在内存中的，重启后软件及配置会丢失，所以操作完成后，需要将v2ray配置写入闪存。

**高级设置 -> 系统管理 -> 配置管理 -> 保存内部存储到闪存: 提交**

由于配置文件比较大，提交保存操作需要耐心等待几秒钟，以确保写入成功。

如果一切顺利，重启路由hi起来。Good luck!

## 更新记录
2021-05-10
* 增加xray
* 使用自行动态编译smartdns

2021-03-08
* 增加smartdns

2020-11-13
* 内置证书文件
* 增加ad-ext，过滤更为严格

2020-07-16
* 内置v2ray
* 去掉doh相关，dns通过v2ray解析

2019-08-06
* 草稿，doh待处理
