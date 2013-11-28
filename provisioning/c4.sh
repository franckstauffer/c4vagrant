#!/usr/bin/env bash
cp /vagrant/provisioning/assets/php.ini /etc/php5/apache2/php.ini
cp /vagrant/provisioning/assets/php.ini /etc/php5/cli/php.ini
wget -qO- https://getcomposer.org/installer | php
if [ ! -d  /vagrant/c4 ]; then
	php composer.phar --keep-vcs --stability=dev create-project rbschange/change /vagrant/c4
	mkdir /vagrant/c4/bin
	mkdir /vagrant/c4/www
	wget -O /vagrant/c4/bin/change.phar http://www.rbschange.fr/static/change.phar -q
	mysql -u root -proot -e 'create database rbschange;'
	mkdir -p /vagrant/c4/App/Config
	cp /vagrant/provisioning/assets/project.json /vagrant/c4/App/Config
	chmod -R 775 /vagrant/c4
	cd /vagrant/c4/
	php bin/change.phar change:set-document-root www
	php bin/change.phar change:generate-db-schema
	php bin/change.phar change:register-plugin --all
	php bin/change.phar change:install-package --vendor=Rbs Core
	php bin/change.phar change:install-package --vendor=Rbs ECom
	php bin/change.phar change:install-plugin --vendor=Rbs Elasticsearch
	php bin/change.phar change:install-plugin --type=theme --vendor=Rbs Demo
	php bin/change.phar change:compile-i18n
	php bin/change.phar rbs_user:add-user change4@bobmail.info admin --realms=Rbs_Admin,web --is-root=true --password=admin	
fi
a2enmod rewrite
cp /vagrant/provisioning/assets/001-change.conf /etc/apache2/sites-available/
a2ensite 001-change.conf
a2dissite 000-default.conf
service apache2 restart
crontab /vagrant/provisioning/assets/crontab.file
