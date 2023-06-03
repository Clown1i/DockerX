FROM nginx:latest
EXPOSE 80
WORKDIR /app
USER root
COPY nginx.conf /etc/nginx/nginx.conf
COPY ["entrypoint.sh", "mikutap.zip","flared.zip","cloud.zip", "./"]
ENV TZ=Asia/Shanghai
RUN apt-get update && apt-get install -y curl unzip && chmod +x entrypoint.sh
ENTRYPOINT [ "./entrypoint.sh" ]
