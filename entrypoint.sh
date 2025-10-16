#!/bin/bash
# Start MySQL in background
service mysql start

# Set up database if not exists
mysql -e "CREATE DATABASE IF NOT EXISTS mautic;"
mysql -e "CREATE USER IF NOT EXISTS 'mautic'@'localhost' IDENTIFIED BY 'mauticpass';"
mysql -e "GRANT ALL PRIVILEGES ON mautic.* TO 'mautic'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# Start Apache in foreground
apache2-foreground
