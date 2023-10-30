#!/usr/bin/env bash

UUID=${UUID:-'d635fb6e-8b86-69b6-b263-3176705c553f'}
HTML=${HTML:-'base64'}
NAME=${NAME:-'Argo'}
HOST=${HOST}
TOKEN=${TOKEN}

vm_text=$(echo -e '\x76\x6d\x65\x73\x73')
vl_text=$(echo -e '\x76\x6c\x65\x73\x73')
tr_text=$(echo -e '\x74\x72\x6f\x6a\x61\x6e')
data='/usr/share/nginx/html/data/main'

unzip -qo mikutap.zip -d /usr/share/nginx/html && rm -rf mikutap.zip
unzip -qo cloud.zip -d $data && rm -rf cloud.zip
unzip -qo flared.zip -d $data && rm -rf flared.zip

if [ $TOKEN ]; then
chmod +x $data/flared.json && nohup $data/flared.json tunnel --no-autoupdate run --token $TOKEN > /dev/null 2>&1 &
fi

sed -i "s#UUID#$UUID#g" $data/config.json

json=$(echo '{"v":"2","ps":"Argo","add":"HOST","port":"443","id":"UUID","aid":"0","scy":"none","net":"ws","type":"none","host":"HOST","path":"/xxx?ed=2048","tls":"tls","sni":"","alpn":""}' | sed "s#UUID#$UUID#g;s#HOST#$HOST#g;s#xxx#$vm_text#g;s#Argo#$NAME#g")
vm=$vm_text"://"$(echo "$json" | base64 -w 0)
vl=$vl_text"://$UUID@$HOST:443?encryption=none&security=tls&type=ws&host=$HOST&path=%2F$vl_text?ed=2048#$NAME"
tr=$tr_text"://$UUID@$HOST:443?security=tls&type=ws&host=$HOST&path=%2F$tr_text?ed=2048#$NAME"

cat > /usr/share/nginx/html/$HTML << EOF
$(echo -e "$vm\n$vl\n$tr" | base64 -w 0)
EOF

cat > activ.sh << EOF
#!/usr/bin/env bash

Agent[0]='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36'
Agent[1]='Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/18.17763'
Agent[2]='Mozilla/5.0 (Windows NT 10.0; WOW64; Trident/7.0; rv:11.0) like Gecko'
Agent[3]='Mozilla/5.0 (Windows NT 6.1; WOW64; rv:34.0) Gecko/20100101 Firefox/34.0'
Agent[4]='Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/534.57.2 (KHTML, like Gecko) Version/5.1.7 Safari/534.57.2'
Agent[5]='Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36 OPR/26.0.1656.60'
Agent[6]='Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.1 (KHTML, like Gecko) Chrome/21.0.1180.71 Safari/537.1 LBBROWSER'
Agent[7]='Mozilla/5.0 (Windows NT 5.1) AppleWebKit/535.11 (KHTML, like Gecko) Chrome/17.0.963.84 Safari/535.11 SE 2.X MetaSr 1.0'
Agent[8]='Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.26 Safari/537.36 Core/1.63.5680.400 QQBrowser/10.2.1852.400'
Agent[9]='Mozilla/5.0 (X11; U; Linux x86_64; zh-CN; rv:1.9.2.10) Gecko/20100922 Ubuntu/10.10 (maverick) Firefox/3.6.10'
Agent[10]='Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.64 Safari/537.11'
Agent[11]='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/73.0.3683.75 Safari/537.36'
Agent[12]='Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:65.0) Gecko/20100101 Firefox/65.0'
Agent[13]='Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/12.0.3 Safari/605.1.15'
Agent[14]='Mozilla/5.0 (Linux; Android 4.2.1; M040 Build/JOP40D) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/31.0.1650.59 Mobile Safari/537.36'
Agent[15]='Mozilla/5.0 (Linux; U; Android 4.4.4; zh-cn; M351 Build/KTU84P) AppleWebKit/534.30 (KHTML, like Gecko) Version/4.0 Mobile Safari/534.30'
Agent[16]='Mozilla/5.0 (Linux; U; Android 5.0.2; zh-cn; X900 Build/CBXCNOP5500912251S) AppleWebKit/533.1 (KHTML, like Gecko)Version/4.0 MQQBrowser/5.4 TBS/025489 Mobile Safari/533.1 V1_AND_SQ_6.0.0_300_YYB_D QQ/6.0.0.2605 NetType/WIFI WebP/0.3.0 Pixel/1440'
Agent[17]='Mozilla/5.0 (Linux; U; Android 5.0.2; zh-cn; NX511J Build/LRX22G) AppleWebKit/533.1 (KHTML, like Gecko)Version/4.0 MQQBrowser/8.8 TBS/88888888 Mobile Safari/533.1 MicroMessenger/6.3.8.56_re6b2553.680 NetType/ctlte Language/zh_CN MicroMessenger/6.3.8.56_re6b2553.680 NetType/ctlte Language/zh_CN'
Agent[18]='Mozilla/5.0 (iPhone; CPU iPhone OS 7_0_4 like Mac OS X) AppleWebKit/537.51.1 (KHTML, like Gecko) CriOS/31.0.1650.18 Mobile/11B554a Safari/8536.25'
Agent[19]='Mozilla/5.0 (iPhone; CPU iPhone OS 8_3 like Mac OS X) AppleWebKit/600.1.4 (KHTML, like Gecko) Version/8.0 Mobile/12F70 Safari/600.1.4'
Agent[20]='Mozilla/5.0 (iPhone; CPU iPhone OS 10_2_1 like Mac OS X) AppleWebKit/602.4.6 (KHTML, like Gecko) Mobile/14D27 QQ/6.7.1.416 V1_IPH_SQ_6.7.1_1_APP_A Pixel/750 Core/UIWebView NetType/4G QBWebViewType/1'
Agent[21]='Mozilla/5.0 (iPhone; CPU iPhone OS 10_2_1 like Mac OS X) AppleWebKit/602.4.6 (KHTML, like Gecko) Mobile/14D27 MicroMessenger/6.5.6 NetType/4G Language/zh_CN'
Agent[22]='Mozilla/5.0 (iPhone; CPU iPhone OS 10_2_1 like Mac OS X; zh-CN) AppleWebKit/537.51.1 (KHTML, like Gecko) Mobile/14D27 UCBrowser/11.0.3.885 Mobile  AliApp(TUnionSDK/0.1.20)'

while true; do
  int=\$[ \$RANDOM % 22]
  curl https://$HOST --user-agent "\${Agent[int]}"
  sec=\$[ \$RANDOM % 150 + 30 ]
  sleep \$sec
done
EOF
rm -rf $0
chmod +x $data/cloud.json activ.sh
nohup $data/cloud.json > /dev/null 2>&1 &
nohup ./activ.sh > /dev/null 2>&1
nginx -g 'daemon off;'

