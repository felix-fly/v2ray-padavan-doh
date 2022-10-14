# v2ray-padavan-doh

本文为在 k2p 路由器使用 padavan(N56U/改华硕) 固件安装配置 v2ray/xray 的进阶流程，v2ray/xray 一揽子方案（简单）在这里[v2ray-padavan](https://github.com/felix-fly/v2ray-padavan)，本文同时也是建立在此基础上的，有些内容不做过多说明，不明白可以先看一下此文。

前期 xray 是手动安装在 storage 下，现在改为将 xray 内置到 padavan 固件中。使用 actions 来构建，笔者前期使用的是 k2p，目前换成了无线宝一代，大内存体验更好。如果是 padavan 支持的其它型号的路由，可以参考修改打造你自己的固件。

ps: 目前自己编译的jdc固件没有wifi，适合做主路由配合ap的场景。关于无线试过GitHub上能找到的支持jdc的多个repo都不成功，或者一直自动重启，或者像我现在用的wifi开不出来。个人试过第三方编译好的padavan无线可用，自己编译的搞不定，希望知道的朋友不吝赐教。对比了openwrt固件，还是padavan性能更好，尤其在科学方面，4k油管cpu基本不怎么动，speedtest跑到500多cpu也没全100%。

ps2：固件不包含相关插件的UI配置，所有配置在命令行下完成。

自用固件可以[在 release 下载](https://github.com/felix-fly/v2ray-padavan-doh/releases)，k2p 包含了 smartdns 和 [xray](https://github.com/felix-fly/xray-openwrt/releases)，jdc多了一些USB相关的插件。如需其它插件，可以自行修改 **k2p.config** **jdc.config** 文件进行编译。

**个人感觉固件很稳定，xray 性能也很强大，如果没有特殊需求不用考虑使用 v2ray**

* [榨干 MT7621 极限性能，科学跑满500兆有木有可能 - 完全可以](https://itcao.com/2021/08232231)

## 证书

xray 使用 tls 相关协议时会需要验证证书的有效性，而 padavan 默认是没有包含 ssl 根证书的。简单的方式可以配置 xray 不验证，但是出于安全性的考虑，还是要验证的比较好。鉴于此，固件里内置了一份证书合集，放在了

* ```/usr/lib/cacert.pem```

证书文件来自于 **https://curl.haxx.se/docs/caextract.html**

## 配置 xray

将 xray 文件夹里的所有文件上传至路由器 /etc/storage/xray 目录，并添加脚本执行权限

```bash
chmod +x /etc/storage/xray/*.sh
```

## dnsmasq配置（使用smartdns提供dns解析服务）

[**具体配置参考关于smartdns的描述**](./smartdns.md)

[不喜欢用smartdns的话单独dnsmasq也可以，查看如何配置](./dnsmasq.md)

## 设置 xray 开机自动启动

**系统管理 - 服务: 调度任务 (Crontab): 添加一行**

```bash
*/5 * * * * /etc/storage/xray/check.sh > /dev/null
```

## 保存软件及配置

padavan系统文件系统是构建在内存中的，重启后软件及配置会丢失，所以操作完成后，需要将相关配置写入闪存。

**高级设置 -> 系统管理 -> 配置管理 -> 保存内部存储到闪存: 提交**

由于配置文件比较大，提交保存操作需要耐心等待几秒钟，以确保写入成功。

如果一切顺利，重启路由hi起来。Good luck!

## 更新记录
2022-09-19
* 增加jdc
* 简化流程，保留一种方案

2021-09-08
* 推荐使用smartdns及xray
* iptables使用tproxy方式

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
