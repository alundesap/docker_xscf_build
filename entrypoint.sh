#!/bin/bash
#
# run netcat listening on 1234 to simulate a TCP/IP based server
exec nc -l 1234 &>/dev/null &
#
# Start the MySQL Server
#
#exec /usr/lib/mysql/mysql-systemd-helper install
#exec /usr/lib/mysql/mysql-systemd-helper start &
#exec /usr/lib/mysql/mysql-systemd-helper wait
#
# Create a test table and populate it a bit
#
#exec /usr/bin/mysql -u root -D test -e "CREATE TABLE test2 (""id"" int(11) NOT NULL AUTO_INCREMENT, ""value"" varchar(45) DEFAULT NULL, PRIMARY KEY (""id"")) ENGINE=InnoDB DEFAULT CHARSET=utf8;"
#
#exec /usr/bin/mysql -u root -D test -e "INSERT INTO test.test2 (value) VALUES('One');"
#exec /usr/bin/mysql -u root -D test -e "INSERT INTO test.test2 (value) VALUES('Two');"
#exec /usr/bin/mysql -u root -D test -e "INSERT INTO test.test2 (value) VALUES('Thareee\!');"
#
#exec /usr/bin/mysql -u root -h 127.0.0.1 -P 3306 -D test -e "SELECT * FROM test.test2;"
#
# Set the MySQL root user password if desired
#exec /usr/bin/mysqladmin -u root password 'Nirvana8484'
##exec /usr/local/bin/start_mysql.sh &>/dev/null &
#
# Start the Chisel Tunnel Server
#
# exec chisel server -v --port 8080 --authfile /usr/bin/auth.json
