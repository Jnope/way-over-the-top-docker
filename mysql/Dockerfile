FROM alibaba-cloud-linux-3-registry.cn-hangzhou.cr.aliyuncs.com/alinux3/mysql_optimized:20240221-8.0.32-2.3.0

RUN rm -rf /etc/my.cnf.d
RUN mkdir -p /etc/my.cnf.d
ADD new_conf /etc/my.cnf.d
RUN chmod -R 777 /etc/my.cnf.d

COPY new_mysql_keentune.sh /usr/local/bin/mysql_keentune.sh
RUN chmod 777 /usr/local/bin/mysql_keentune.sh

RUN mkdir -p /init_sql
ADD init /init_sql
RUN chmod -R 777 /init_sql
