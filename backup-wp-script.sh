#! /bin/bash

# Dumping  MYSQL information


SITE=${1%/}

DB_NAME=$( cat $SITE/wp-config.php | grep "DB_NAME" | cut -d "'" -f4 )
DB_USER=$( cat $SITE/wp-config.php | grep "DB_USER" | cut -d"'" -f4 )
DB_PASSWORD=$( cat $SITE/wp-config.php | grep "DB_PASSWORD" | cut -d"'" -f4 )
DB_HOST=$( cat $SITE/wp-config.php | grep "DB_HOST" | cut -d"'" -f4 )

echo $DB_NAME
if [ "$DB_HOST" == "locahost" ]
then
	mysqldump -u$DB_USER -p$DB_PASSWORD $DB_NAME > $SITE$(date +%F_%H-%M-%S ).sql
else
	mysqldump -h$DB_HOST -u$DB_USER -p$DB_PASSWORD $DB_NAME > $SITE$(date +%F_%H-%M-%S ).sql

fi

# Create an archive of Wordpress
tar -cvzf $SITE$(date +%F_%H-%M-%S).tar.gz $SITE


