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

