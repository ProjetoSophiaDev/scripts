#!/bin/bash

DB_BKP="/mnt/mdl/bkp/db/" # moodle database backup folder
DATA_BKP="/mnt/mdl/bkp/data/" # moodle data backup folder
AUTO_BKP="/mnt/mdl/bkp/auto/"  # moodle auto backup folder

cd $DB_BKP

ls -lh $DB_BKP
rm -rf *.gz
rm -rf *.gz.md5

cd $DATA_BKP

ls -lh $DATA_BKP
rm -rf *.gz
rm -rf *.gz.md5

cd $AUTO_BKP

ls -lh $AUTO_BKP
rm -rf *.mbz



