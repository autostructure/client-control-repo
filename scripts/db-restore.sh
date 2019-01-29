#!/bin/bash

# Restore the databases, fix database permissions, and recreate database extensions on the 2016.5 Puppet master. Run the following commands:
# Note: In this step, you’ll also edit PE classification groups to reflect the 2016.5 Puppet master’s certificate name.

# You can safely ignore the following errors:
# pg_restore: [archiver (db)] Error while PROCESSING TOC:
# pg_restore: [archiver (db)] Error from TOC entry 5; 2615 2200 SCHEMA public pe-postgres
# pg_restore: [archiver (db)] could not execute query: ERROR:  schema "public" already exists
# Command was: CREATE SCHEMA public;

BACKUP_DIR=/tmp/backup

puppet resource service puppet ensure=stopped
puppet resource service pe-puppetserver ensure=stopped
puppet resource service pe-puppetdb ensure=stopped
puppet resource service pe-console-services ensure=stopped
puppet resource service pe-nginx ensure=stopped
puppet resource service pe-activemq ensure=stopped
puppet resource service pe-orchestration-services ensure=stopped
puppet resource service pxp-agent ensure=stopped

sudo -u pe-postgres /opt/puppetlabs/server/bin/pg_restore -Cc $BACKUP_DIR/pe-puppetdb.backup.bin -d template1
sudo -u pe-postgres /opt/puppetlabs/server/bin/pg_restore -Cc $BACKUP_DIR/pe-classifier.backup.bin -d template1
sudo -u pe-postgres /opt/puppetlabs/server/bin/pg_restore -Cc $BACKUP_DIR/pe-activity.backup.bin -d template1
sudo -u pe-postgres /opt/puppetlabs/server/bin/pg_restore -Cc $BACKUP_DIR/pe-rbac.backup.bin -d template1

#Start PE services
#Install database extensions and repair database permissions
#Repair PE classification groups to reflect the 2016.5 Puppet master’s certificate name.
/opt/puppetlabs/bin/puppet-infrastructure configure
