FROM nginx:latest
EXPOSE 80
WORKDIR /app
USER root
COPY nginx.conf /etc/nginx/nginx.conf
COPY ["entrypoint.sh", "mikutap.zip","flared.zip","cloud.zip", "./"]
ENV TZ=Asia/Shanghai
RUN apt-get update && apt-get install -y curl unzip && chmod +x entrypoint.sh
RUN groupadd -g 1002 myuser && useradd -u 1002 -g 1002 -m -s /usr/sbin/nologin myuser
USER myuser
ENTRYPOINT [ "./entrypoint.sh" ]
