# Create Zabbix database and grant privileges to zabbix user

create database zabbix character set utf8 collate utf8_bin;

grant all privileges on zabbix.* to zabbix@localhost identified by 'zabbix-password';
grant all privileges on zabbix.* to zabbix@zabbix_server identified by 'zabbix-password';
grant all privileges on zabbix.* to zabbix@zabbix_frontend  identified by 'zabbix-password';

# can not work out the circular linking between db and server/frontend containers
grant all privileges on zabbix.* to 'zabbix'@'%'  identified by 'zabbix-password';

exit
