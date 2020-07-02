# TrojanDocker

* Docker 一键  Trojan
* Certbot 自动获取证书
* iOS shadowrocket 二维码

# 使用方法

- 提前安装好docker

```shell
 curl -fsSL https://get.docker.com -o get-docker.sh  && \
 bash get-docker.sh
```

- 解析好域名 确认 你的域名正确解析到了你安装的这台服务器

- 会占用 443 和 80 端口请提前确认没有跑其他的业务 （ lsof -i:80 和 lsof -i:443 能查看）

- 请将下面命令中的 YOURDOMAIN.COM（域名）替换成自己的域名（此IP解析的域名）！！！password 设置为密码，email 填写自己的邮件作为 Certbot 邮件接收。

  ```
  sudo docker run -d  --rm --name trojan -p 443:443 -p 80:80 pengchujin/trojan_docker:0.08 YOURDOMAIN.COM password email@email.com && sleep 3s && sudo docker logs trojan
  ```

- 命令执行完会显示链接信息，如果想查看链接信息，执行下面命令即可

```
sudo docker logs trojan
```

- 想停止这个 docker 和服务

```
sudo docker stop trojan

- 想启用这个 docker 和服务

```
sudo docker run trojan
