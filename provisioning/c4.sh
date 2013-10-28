#!/usr/bin/env bash

debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password root'
apt-get -y install mysql-server
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root -proot mysql
apt-get -y install php5 php5-cli php5-json php5-curl php5-gd php5-mysql php5-xsl php5-imagick php5-intl php5-mcrypt apache2-mpm-itk
a2dismod mpm_prefork
a2enmod mpm_itk
service apache2 restart
cp /vagrant/provisioning/assets/php.ini /etc/php5/apache2/php.ini
cp /vagrant/provisioning/assets/php.ini /etc/php5/cli/php.ini
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.5.deb -q 
apt-get -y  install openjdk-7-jre-headless    
dpkg -i elasticsearch-0.90.5.deb
service elasticsearch start
rm elasticsearch-0.90.5.deb
apt-get -y install git
wget -qO- https://getcomposer.org/installer | php
php composer.phar --keep-vcs --stability=dev create-project rbschange/change /vagrant/c4
mkdir /vagrant/c4/bin
mkdir /vagrant/c4/www
wget -O /vagrant/c4/bin/change.phar http://www.rbschange.fr/static/change.phar -q
mysql -u root -proot -e 'create database rbschange;'
mkdir -p /vagrant/c4/App/Config
cp /vagrant/provisioning/assets/project.json /vagrant/c4/App/Config
cp /vagrant/provisioning/assets/001-change.conf /etc/apache2/sites-available/
a2ensite 001-change.conf
a2dissite 000-default.conf
service apache2 restart
chmod -R 775 /vagrant/c4
su - vagrant
cd /vagrant/c4/
php bin/change.phar change:set-document-root www
php bin/change.phar change:generate-db-schema
php bin/change.phar change:register-plugin --all
php bin/change.phar change:install-package --vendor=Rbs Core
php bin/change.phar change:install-package --vendor=Rbs ECom
php bin/change.phar change:install-plugin --vendor=Rbs Elasticsearch
php bin/change.phar change:install-plugin --type=theme --vendor=Rbs Demo
php bin/change.phar rbs_user:add-user change4@bobmail.info admin --realms=Rbs_Admin,web --is-root=true --password=admin
 