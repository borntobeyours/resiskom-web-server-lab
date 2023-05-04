# Use the official Ubuntu base image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Update package list and install required packages
RUN apt-get update && \
    apt-get install -y apache2 mysql-server php php-mysql libapache2-mod-php && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Copy your web application files to the container
COPY html/ /var/www/html/

# Expose the ports for Apache and MySQL
EXPOSE 80 3306

# Start Apache and MySQL services
CMD service mysql start && service apache2 start && tail -f /var/log/apache2/access.log -f /var/log/apache2/error.log
