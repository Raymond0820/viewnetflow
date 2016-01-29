
#Requirement
1.flow-export

2.mysql

3.perl and php

#Parameter
##Database configuration as below

dbname=flowtool

id=root

password=raymond0820

##netflow tool path as below

tool flow-export path = /usr/bin/flow-export

netflow raw data path = /data/flowtool

#Install
1 
directory "flow2mysql" move to "/data/flow2mysql"

2
mysql -u root -p flowtool < viewnetflow.sql 

3
echo crontab >> /etc/crontab

4
directory "viewnetflow" move to "/var/www/html/viewnetflow"

#Configuration
modify /var/www/html/viewnetflow/ipnamelist.php
