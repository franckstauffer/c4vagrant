#!/usr/bin/env bash
apt-get -y install git
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password root'
apt-get -y install mysql-server
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root -proot mysql
apt-get -y install redis-server
apt-get -y install php5-fpm php5-cli php5-json php5-curl php5-gd php5-mysql php5-xsl php5-imagick php5-intl php5-mcrypt php5-redis
apt-get -y install nginx
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.1.deb -q 
apt-get -y  install openjdk-7-jre-headless    
dpkg -i elasticsearch-1.3.1.deb
service elasticsearch start
rm elasticsearch-1.3.1.deb
cp /vagrant/provisioning/assets/opcache.ini /etc/php5/mods-available/opcache.ini
cp /vagrant/provisioning/assets/php-cli.ini /etc/php5/cli/php.ini
cp /vagrant/provisioning/assets/php-fpm.ini /etc/php5/fpm/php.ini
cp /vagrant/provisioning/assets/www.conf /etc/php5/fpm/pool.d/www.conf
cp /vagrant/provisioning/assets/default /etc/nginx/sites-available/default
service php5-fpm restart
service nginx restart
apt-get install redis-server
wget -qO- https://getcomposer.org/installer | php
if [ ! -d  /vagrant/c4 ]; then
	php composer.phar --keep-vcs --stability=dev create-project rbschange/change /vagrant/c4
  cp /vagrant/provisioning/assets/reset.sh /vagrant/c4
	mysql -u root -proot -e 'create database rbschange;'
	mkdir -p /vagrant/c4/www
  mkdir -p /vagrant/c4/bin
	mkdir -p /vagrant/c4/App/Config
	wget -O /vagrant/c4/bin/change.phar http://github.com/RBSChange/skeleton-project/raw/master/bin/change.phar -q
	cp /vagrant/provisioning/assets/project.json /vagrant/c4/App/Config
	chmod -R 775 /vagrant/c4
	cd /vagrant/c4/
  git clone https://github.com/inthause/Change_samples.git
  bash reset.sh
fi
crontab /vagrant/provisioning/assets/crontab.file
