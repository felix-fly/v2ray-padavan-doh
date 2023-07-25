## dnsmasq配置（不使用smartdns）

* 将 dnsmasq 文件夹里的所有文件上传至路由器 /etc/storage/dnsmasq 目录

* 通过padavan管理界面修改，dnsmasq拦截广告并将gw域名转给v2ray进行解析。

**内部网络(LAN) -> DHCP服务器 -> 自定义配置文件 "dnsmasq.conf"**

目前广告列表已经超过五万条了，dnsmasq 加载后查询效率已经有所下降，具体表现为 cpu 使用率较之前有升高。如果影响正常使用，可以不加载广告规则，或者选用 smartdns 的方案。

```bash
conf-dir=/etc/storage/dnsmasq, *.hosts
```

**高级设置 -> 自定义设置 -> 脚本 -> 在防火墙规则启动后执行:**

```bash
/etc/storage/dnsmasq/iptables.sh
```
