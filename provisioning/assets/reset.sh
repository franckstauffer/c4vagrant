#!/bin/sh
mysql -u root -proot -e "drop database rbschange; create database rbschange;"
mysql -u root -proot -e "drop database rbschangetest; create database rbschangetest;"
rm -rf App/Config/project.autogen.json App/Storage Compilation/* tmp/* www/Assets www/Imagestorage www/index.php www/admin.php www/rest.php
php bin/change.phar change:set-document-root www
php bin/change.phar change:generate-db-schema
php bin/change.phar change:register-plugin --all
php bin/change.phar change:install-package --vendor=Rbs Core
php bin/change.phar change:install-package --vendor=Rbs ECom
php bin/change.phar change:install-plugin --type=module --vendor=Rbs Event
php bin/change.phar change:install-plugin --type=theme --vendor=Rbs Demo
php bin/change.phar change:install-plugin --type=module --vendor=Rbs Dev
php bin/change.phar change:install-plugin --type=module --vendor=Rbs Wishlist
php bin/change.phar change:install-plugin --type=module --vendor=Rbs Social
php bin/change.phar change:install-plugin --type=module --vendor=Rbs Merchandising
php bin/change.phar change:install-plugin --type=module --vendor=Rbs Highlight
php bin/change.phar rbs_website:add-default-website --baseURL="http://localhost:8888/"
php bin/change.phar rbs_user:add-user admin-change@bobmail.info admin --realms=Rbs_Admin,web --is-root=true --password=admin
php bin/change.phar change:clear-cache
php Change_samples/Samples/Initialize.php
php Change_samples/Samples/ElasticSearch.php
php Change_samples/Samples/Catalog.php
php Change_samples/Samples/Products.php
php Change_samples/Samples/Simpleform.php
php Change_samples/Samples/Event.php
php Change_samples/Samples/Publish.php
