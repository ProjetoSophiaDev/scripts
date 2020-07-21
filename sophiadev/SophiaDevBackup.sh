#!/bin/bash

DB_BKP="/mnt/nvme1n1p1/mdlbkpdev/db/" # moodle database backup folder
DATA_BKP="/mnt/nvme1n1p1/mdlbkpdev/data/"  # moodle data backup folder
HTML_BKP="/mnt/nvme1n1p1/mdlbkpdev/html/"  # moodle html backup folder

BKP_DIR="/mnt/nvme1n1p1/mdlbkpdev/"  # moodle backup folder

MOODLE_DATA="/mnt/nvme1n1p1/datadev"  # moodle data folder
MOODLE_HOME="/var/www/moodledev/html" # moodle core folder

# Database Credentials
DBNAME='moodledev'
filename=$(date +\%Y-\%m-\%d-\%H.\%M)

echo "Run automated backup..."
sudo -u www-data /usr/bin/php $MOODLE_HOME/admin/cli/automated_backups.php

echo "Kill all user sessions..."
sudo -u www-data /usr/bin/php $MOODLE_HOME/admin/cli/kill_all_sessions.php

echo "Activating Moodle Maintenance Mode in..."
sudo -u www-data /usr/bin/php $MOODLE_HOME/admin/cli/maintenance.php --enable

echo "purge Moodle cache..."
sudo -u www-data /usr/bin/php $MOODLE_HOME/admin/cli/purge_caches.php

echo "fix courses..."
sudo -u www-data /usr/bin/php $MOODLE_HOME/admin/cli/fix_course_sequence.php -c=* --fix


# make database backup
sudo -i -u postgres pg_dump $DBNAME | gzip > $DB_BKP$filename.psql.gz
md5sum $DB_BKP$filename.psql.gz > $DB_BKP$filename.psql.gz.md5
md5sum -c $DB_BKP$filename.psql.gz.md5

ls -lh $DB_BKP

# Backup the files using tar.
tar -czf $DATA_BKP$filename.tar.gz $MOODLE_DATA

md5sum $DATA_BKP$filename.tar.gz > $DATA_BKP$filename.tar.gz.md5
md5sum -c $DATA_BKP$filename.tar.gz.md5

# tar -czf $HTML_BKP$filename.tar.gz $MOODLE_HOME
#md5sum $HTML_BKP$filename.tar.gz > $HTML_BKP$filename.tar.gz.md5
#md5sum -c $HTML_BKP$filename.tar.gz.md5

#ls -lh $DATA_BKP

echo "disable the maintenance mode..."
sudo -u www-data /usr/bin/php $MOODLE_HOME/admin/cli/maintenance.php --disable
