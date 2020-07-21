#!/bin/bash

DB_BKP="/mnt/nvme1n1p1/mdlbkpdev/db/" # moodle database backup folder
DATA_BKP="/mnt/nvme1n1p1/mdlbkpdev/data/"  # moodle data backup folder
#HTML_BKP="/mnt/nvme1n1p1/mdlbkpdev/html/"  # moodle html backup folder
AUTO_BKP="/mnt/nvme1n1p1/mdlbkpdev/auto/"  # moodle auto backup folder

cd $DB_BKP

ls -lh $DB_BKP
rm -rf *.gz
rm -rf *.gz.md5

cd $DATA_BKP

ls -lh $DATA_BKP
rm -rf *.gz
rm -rf *.gz.md5

#cd $HTML_BKP

#ls -lh $HTML_BKP
#rm -rf *.gz
#rm -rf *.gz.md5

cd $AUTO_BKP

ls -lh $AUTO_BKP
rm -rf *.mbz



