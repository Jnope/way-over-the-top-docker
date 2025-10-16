redis_port=${MY_REDIS_PORT:-9400}
redis_pwd=${MY_REDIS_PWD:-top_redis_12345}

yum install numactl -y

sed -i "s/^port .*/port $redis_port/" /etc/redis.conf;
sed -i "s/^bind.*/bind 0.0.0.0/" /etc/redis.conf;
sed -i "s/^# requirepass foobared/requirepass $redis_pwd/" /etc/redis.conf;
sed -i "s/^appendonly no/appendonly yes/" /etc/redis.conf;
sed -i "s#^pidfile.*#pidfile /var/run/redis_$redis_port.pid#" /etc/redis.conf

numactl -C 0 /usr/bin/redis-server /etc/redis.conf
