export TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
export THIS_BACKUP_DIR=${BACKUP_DIR}/${TIMESTAMP}
mkdir -p ${THIS_BACKUP_DIR}
dc exec -T mariadb mysqldump -u root -p${MYSQL_ROOT_PASSWORD} --routines --triggers ${MYSQL_DATABASE} | gzip -9 > ${THIS_BACKUP_DIR}/${TIMESTAMP}.mysql.dump.sql.gzip
/usr/local/bin/docker-compose -f ${PROJECT_ROOT}/config/services/backup/backup.yml run --rm backup
echo Done!
