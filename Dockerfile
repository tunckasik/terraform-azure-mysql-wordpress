FROM wordpress:latest
ENV WORDPRESS_DB_HOST=bronze-wordpress.mysql.database.azure.com
ENV WORDPRESS_DB_USER=bronze
ENV WORDPRESS_DB_PASSWORD=Password1234
ENV WORDPRESS_DB_NAME=wordpress
EXPOSE 80
