#!/bin/bash

# backup ssl annd db

# Backup these directories:
# /etc/puppetlabs/puppet/ssl/
# /etc/puppetlabs/puppetdb/ssl/
# /etc/puppetlabs/orchestration-services/ssl
# /opt/puppetlabs/server/data/console-services/certs/
# /opt/puppetlabs/server/data/postgresql/9.6/data/certs/
# NOTE: for 2016.5.2, the db version is actually 9.4:
# /opt/puppetlabs/server/data/postgresql/9.4/data

BACKUP_DIR=/tmp/backup

tar -zcvf $BACKUP_DIR/puppet_ssl.tar.gz /etc/puppetlabs/puppet/ssl/

chown pe-postgres:pe-postgres $BACKUP_DIR
sudo -u pe-postgres /opt/puppet/bin/pg_dump -Fc pe-puppetdb -f $BACKUP_DIR/pe-puppetdb.backup.bin
sudo -u pe-postgres /opt/puppet/bin/pg_dump -Fc pe-classifier -f $BACKUP_DIR/pe-classifier.backup.bin
sudo -u pe-postgres /opt/puppet/bin/pg_dump -Fc pe-rbac -f $BACKUP_DIR/pe-rbac.backup.bin
sudo -u pe-postgres /opt/puppet/bin/pg_dump -Fc pe-activity -f $BACKUP_DIR/pe-activity.backup.bin
