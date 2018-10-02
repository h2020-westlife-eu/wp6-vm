cd /backup
now=$(date +"%m_%d_%Y")
pg_dump --username=westlife westlife > backup-westlife-$now.sql
