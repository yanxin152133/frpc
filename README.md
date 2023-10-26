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
# 身份验证，与frps.ini中保存一致
token = 9LgPn24TaC2NYZXY

[ssh]
type = tcp
local_ip = 127.0.0.1
local_port = 233   ## 自定义本地转发端口
remote_port = 5000   ## 自定义服务端监听端口
```

## 1.3. 运行
### 1.3.1. 自定义配置文件
```bash
docker run --name frpc --restart=always -it -d --network host -v /etc/frp/frps.ini:/etc/frp/frps.ini  yancccccc/frpc:latest
```
