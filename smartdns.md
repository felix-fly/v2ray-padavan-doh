路由器刷Padavan固件，安装集成smartdns，实现加速dns解析，广告过滤，域名分流等。

## 说明

简单来说smartdns是一个dns缓存服务器，与dnsmasq相比，并不提供dhcp相关的功能，但是dns解析方面，提供了许多增强功能，具体的可以去[smartdns官方](https://github.com/pymumu/smartdns#faq)了解。

笔者使用k2p做主路由，目前刷的是padavan自编译固件。由于k2p本身并没有usb接口，无法使用smartdns官方的方式进行安装。但是官方提供了mipsel平台静态编译好的二进制文件，这样就可以通过手工的方式进行安装，实现曲线救国。

笔者编译的固件为纯净版，只包含了smartdns和v2ray。还有一个k2p_5.0_me.trx是我自己用的，因为v2ray独立放在了另外的r2s盒子上（类似旁路由），这个版本只内置了smartdns本身。

**固件里不含相关的配置文件，只有软件本身。**

## 配置smartdns

my.conf文件里包含了相关的配置项，更多的配置项可从查阅[官方文档](https://github.com/pymumu/smartdns#%E9%85%8D%E7%BD%AE%E5%8F%82%E6%95%B0)。

此处的配置包含：域名分流、广告过滤、域名预查询、禁用ipv6解析。使用时结合自身情况修改，建议增加宽带运营商DNS服务器实现更好效果。

分流部分gw组由本地的v2ray进行解析，关于v2ray可查看笔者之前相关的文章。

仓库smartdns文件夹下包含了smartdns相关的配置文件。

下载到本地后，通过scp上传整个smartdns文件夹到路由器

```bash
scp -r smartdns k2p:/etc/storage
```

ssh登陆到路由器，给文件添加执行权限

```bash
chmod +x /etc/storage/smartdns/check.sh
```

## 配置dnsmasq

通过padavan管理界面修改，禁用dnsmasq的dns服务。

**内部网络(LAN) -> DHCP服务器 -> 自定义配置文件 "dnsmasq.conf"**

```bash
port=0
```

## 设置smartdns开机自动启动

**高级设置 -> 自定义设置 -> 脚本 -> 在路由器启动后执行:**

```bash
/etc/storage/smartdns/check.sh &
```

## 测试效果

可以在ssh手动执行脚本，稍等一会用ps命令查看smartdns是否启动成功。

```bash
/etc/storage/smartdns/check.sh &
```

在电脑上用 nslookup 查询看看，分别有效果哦

```bash
nslookup www.baidu.com
nslookup ad.qq.com
nslookup www.google.com
```

## 手工安装smartdns（在现有固件上安装）

如果不喜欢纯净版固件，或者有自己的需求，可以自行编译固件。编译时可以选择内置软件，具体可参考仓库actions构建脚本，也可以增加storage分区大小（[查看之前的文章](https://github.com/felix-fly/v2ray-padavan)），然后再手动安装软件。

smartdns文件可以从仓库bin目录下获取，个人习惯已经使用upx将smartdns进行压缩，瘦身后1mb多一点点，毕竟对于路由器寸土寸金，存储大户可以无视。不放心的小伙伴可以自行从smartdns官方下载获取。

默认的是mipsel平台，如果需要其它平台的，请提issue，我再加上。

将下载到的smartdns文件与配置文件放在一起（都放在smartdns文件下），修改 check.sh 文件，替换路径

```bash
# /usr/bin/smartdns -c /etc/storage/smartdns/my.conf
/etc/storage/smartdns/smartdns -c /etc/storage/smartdns/my.conf
```

然后通过scp上传整个smartdns文件夹到路由器

```bash
scp -r smartdns k2p:/etc/storage
```

ssh登陆到路由器，给文件添加执行权限

```bash
chmod +x /etc/storage/smartdns/smartdns
chmod +x /etc/storage/smartdns/check.sh
```

后续配置前文有述，雷同。

## 更新记录
2021-03-08
* 初版
