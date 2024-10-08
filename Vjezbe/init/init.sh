sudo cp -r ./tmp/ /var/lib/mysql/
mysql --local-infile=1 -u root -p < init.sql
sudo rm -r /var/lib/mysql/tmp
