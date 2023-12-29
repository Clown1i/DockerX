#!/usr/bin/env bash

cat > config.json << EOF
{
    "log": {
        "access": "none",
        "error": "none",
        "loglevel": "none"
    },
    "inbounds": [
        {
            "port": 80,
            "listen": "127.0.0.1",
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "d635fb6e-8b86-69b6-b263-3176705c553f",
                        "alterId": 0
                    }
                ]
            },
            "streamSettings": {
                "network": "ws",
                "wsSettings": {
                    "path": "/"
                }
            }
        }
    ],
    "dns": {
        "servers": [
            "https+local://8.8.8.8/dns-query"
        ]
    },
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
chmod +x cloudflared-linux-amd64
./cloudflared-linux-amd64 tunnel --no-autoupdate run --token ${TOKEN} > /dev/null 2>&1 &

RANDOM_NAME=$(tr -dc 'A-Za-z0-9' </dev/urandom | head -c 6)
wget -O temp.zip https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip
unzip temp.zip xray geosite.dat geoip.dat
mv xray ${RANDOM_NAME}
rm -f temp.zip

./${RANDOM_NAME} run -config config.json > /dev/null 2>&1 &
