if [[ $# -eq 2 ]]; 
then
  file=/etc/mysql/my.cnf
  if grep -Fxq "[mysqld]" $file 
  then
    if grep -Fq "secure_file_priv=" $file 
    then
      if ! grep -Fxq "secure_file_priv=/var/lib/mysql-files/" $file 
      then
        sudo sed -i -r "s/secure_file_priv=.*/secure_file_priv=\/var\/lib\/mysql-files\//" $file
        sudo service mysql restart
        sudo sed -i "/secure_file_priv=\/var\/lib\/mysql-files\//d" $file
      fi
    else
      sudo sed -i "/\[mysqld\]/a secure_file_priv=\/var\/lib\/mysql-files\/" $file
      sudo service mysql restart
      sudo sed -i "/secure_file_priv=\/var\/lib\/mysql-files\//d" $file
    fi
  else
    sudo echo "[mysqld]" | sudo tee -a $file > /dev/null
    sudo echo "secure_file_priv=/var/lib/mysql-files/" | sudo tee -a $file > /dev/null
    sudo service mysql restart
    sudo sed -i "/\[mysqld\]/d" $file
    sudo sed -i "/secure_file_priv=\/var\/lib\/mysql-files\//d" $file
  fi

  sudo cp ./fetdata/* /var/lib/mysql-files/
  sed -i "0,/IZMIJENI/s//${1:0:2}${2:0:2}/" init.sql
  sed -i "0,/IZMIJENI/s//${1:0:2}${2:0:2}/" init.sql
  mysql --local-infile=1 -u root -p < init.sql
  sed -i "0,/${1:0:2}${2:0:2}/s//IZMIJENI/" init.sql
  sed -i "0,/${1:0:2}${2:0:2}/s//IZMIJENI/" init.sql
  sudo rm /var/lib/mysql-files/FET_init_*.unl
else	
  echo "Broj argumenata nije validan (koristite . ./init.sh Ime Prezime)"
fi
