#! /bin/bash
SITE=$1
ARCHIVE=$2
DATABASE=$3

if [ \( ${ARCHIVE: -6} == "tar.gz" \) -a \( ${DATABASE: -4} == ".sql" \) ]
then

tar -xvf $ARCHIVE

DB_NAME=$( cat $SITE/wp-config.php | grep "DB_NAME" | cut -d "'" -f4 )
DB_USER=$( cat $SITE/wp-config.php | grep "DB_USER" | cut -d"'" -f4 )
DB_PASSWORD=$( cat $SITE/wp-config.php | grep "DB_PASSWORD" | cut -d"'" -f4 )
DB_HOST=$( cat $SITE/wp-config.php | grep "DB_HOST" | cut -d"'" -f4 )

########### Just in case we don't have user and database anymore
#mysql -e "CREATE DATABASE $DB_NAME"
#mysql -e "CREATE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_PASSWORD' "
#mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'localhost'"
################################################################

if [ "$DB_HOST" == "locahost" ]
then
	mysql -u $DB_USER -p$DB_PASSWORD $DB_NAME < $DATABASE
else  
	mysql -h$DB_HOST -u $DB_USER -p$DB_PASSWORD $DB_NAME < $DATABASE
fi


else
 echo "The files that you've entered as an argument are invalid"
exit 1
fi
