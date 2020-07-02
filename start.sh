#!/bin/bash
domain="$1"
password="$2"
mail="qq@qq.com"
if  [ ! "$3" ] ;then
    mail=${mail}
    echo "建议填写邮箱📮"
else
    mail="$3"
fi
certbot certonly --standalone --preferred-challenges http -d ${domain} -m ${mail} <<EOF
A
Y
EOF
sed -i "s/helloworld/${password}/" /app/trojan.json
sed -i "s/domain/${domain}/" /app/trojan.json
echo "----------------------------------------- 配置文件 -----------------------------------------"
echo ""
cat /app/trojan.json
echo "---------------------------------------- 小火箭二维码 ----------------------------------------"
qrencode "trojan://${password}@${domain}:443?peer=${domain}#TrojanDocker" -o qr.txt -t UTF8
cat qr.txt
trojan -c /app/trojan.json