FROM alpine:3.6
RUN apk add --no-cache curl docker \
	apache2 php7-apache2 curl php7 php7-json php7-curl nano
COPY scripts/  /
RUN mkdir /run/apache2 \
    && sed -i "s#^DocumentRoot \".*#DocumentRoot \"/app\"#g" /etc/apache2/httpd.conf \
    && sed -i "s#/var/www/localhost/htdocs#/app#" /etc/apache2/httpd.conf \
    sed -i 's#AllowOverride none#AllowOverride All#' /etc/apache2/httpd.conf \
    && mkdir /app && chown -R apache:apache /app && chmod -R 755 /app
EXPOSE 80
ENTRYPOINT ["/bootstrap.sh"]