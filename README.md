# 1. frpc
frp 客户端

## 1.1. 简单介绍
[frp通过 SSH 访问内网机器](https://gofrp.org/docs/examples/ssh/)

## 1.2. 配置文件
### 1.2.1. frpc.ini
```
[common]
server_addr = x.x.x.x
server_port = 7000

[ssh]
type = tcp
local_ip = 127.0.0.1
local_port = 233   ## 自定义本地转发端口
remote_port = 5000   ## 自定义服务端监听端口
```

## 1.3. 运行
### 1.3.1. 自定义配置文件
```bash
docker run --name frpc --restart=always -it -d -v ~/Github/frpc/frpc.ini:/usr/local/frp/frp_0.37.1_linux_amd64/frpc.ini -p 7000:7000 -p 233:233 yancccccc/frpc:latest

~/Github/frpc/frpc.ini:/usr/local/frp/frp_0.37.1_linux_amd64/frpc.ini   本地的frpc.ini：容器frpc.ini所在的路径
```

## 1.4. 账号密码
```html
root/root
```

## 1.5. 测试连接
```bash
ssh -p 5000 root@x.x.x.x

ssh -p remote_port root@server_addr
```

## 1.6. 日志
可根据日志来确定问题。

```bash
docker logs frpc
```

# 2. openvpn(不稳定)
## 2.1. docker 运行openvpn
```bash
## 创建一个路径用来保存配置文件和证书
mkdir -p /home/openvpn

## 生成私钥
docker run -v /home/openvpn:/etc/openvpn --rm kylemanna/openvpn ovpn_genconfig -u udp://x.x.x.x    ## 公网ip

docker run -v /home/openvpn:/etc/openvpn --rm -it kylemanna/openvpn ovpn_initpki

## 上面命令出现的过程
输入私钥密码（输入时是看不见的）：
Enter PEM pass phrase:12345678  ## 密码自定义
再输入一遍
Verifying - Enter PEM pass phrase:12345678
输入一个CA名称（直接回车）
Common Name (eg: your user, host, or server name) [Easy-RSA CA]:
输入刚才设置的私钥密码（输入完成后会再让输入一次）
Enter pass phrase for /etc/openvpn/pki/private/ca.key:12345678

## 启动openvpn进程
docker run --restart=always --name openvpn -v /home/openvpn:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn

## 生成客户端证书
docker run -v /home/openvpn:/etc/openvpn --rm -it kylemanna/openvpn easyrsa build-client-full CLIENTNAME nopass

## 导出证书
docker run -v /home/openvpn:/etc/openvpn --rm kylemanna/openvpn ovpn_getclient CLIENTNAME > CLIENTNAME.ovpn

## CLIENTNAME.ovpn生成路径为/home下
```

## 2.2. frpc.ini
```
## 添加Openvpn
[openvpn_test_tcp]
type = tcp
local_port = 1194
remote_port = 1194

[openvpn_test_udp]
type = udp
local_port = 1194
remote_port = 1194
```

## 2.3. openvpn客户端
[openvpn](https://openvpn.net/vpn-client/)

将生成的客户端证书`CLIENTNAME.ovpn`导入进行测试。

# 3. socks5
frpc.ini 增加以下内容

```html
[plugin_socks5_backup]
type = tcp
remote_port = 5006
plugin = socks5
#plugin_user = admin
#plugin_passwd = admin
use_encryption =true
use_compression =true
```


