#!/bin/bash
nohup keentuned > /dev/null &
nohup keentune-target > /dev/null &
sleep 5

keentune profile set mysql.conf

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MySQL for the first time..."
    cat > /etc/my.cnf.d/init-user.sql <<EOF
ALTER USER 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF
    chmod 755 /etc/my.cnf.d/init-user.sql
    mysqld --user=mysql --initialize-insecure --init-file=/etc/my.cnf.d/init-user.sql
fi
sudo -u mysql /usr/sbin/mysqld
