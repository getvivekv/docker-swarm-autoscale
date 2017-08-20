FROM gliderlabs/alpine:3.1
RUN apk --update add docker php-apache2 curl php-cli php-json php-phar php-openssl && rm -f /var/cache/apk/* && \
    mkdir /app && chown -R apache:apache /app && \
    sed -i 's#^DocumentRoot ".*#DocumentRoot "/app"#g' /etc/apache2/httpd.conf && \
    sed -i 's#AllowOverride none#AllowOverride All#' /etc/apache2/httpd.conf
EXPOSE 80
COPY scripts/  /
ENTRYPOINT ["/entrypoint.sh"]
