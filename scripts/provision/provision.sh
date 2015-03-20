#!/bin/bash

# refresh packages
echo "Refreshing packages"
apt-get update
echo "done"

# install python-software-properties
echo "Installing python-software-properties"
apt-get install -y python-software-properties
echo "done"

# add PPA for PHP 5.4 and node.js
echo "Adding PPAs for PHP 5.4 and node.js"
if [ ! -f "/etc/apt/sources.list.d/ondrej-php5-oldstable-precise.list" ] && [ ! -f "/etc/apt/sources.list.d/chris-lea-node_js-precise.list" ];
then
    add-apt-repository -y ppa:ondrej/php5-oldstable
    add-apt-repository -y ppa:chris-lea/node.js
    apt-get update
fi
echo "done"

echo "Installing vim and set as default editor"
apt-get install -y vim vim-doc vim-scripts mc
#update-alternatives --set editor /usr/bin/vim.basic
echo "done"

# install Apache and PHP
echo "Installing Apache and PHP"
apt-get install -y php-apc php5 php5-cli php5-curl php5-gd php5-intl php5-mcrypt php5-mysql php-pear php5-xdebug php5-sqlite
echo "done"

# configure Apache and PHP
echo "Configuring Apache and PHP"
if [ -f "/etc/apache2/sites-enabled/000-default" ];
then
    a2dissite default
fi
cp /vagrant/scripts/provision/m1.loc /etc/apache2/sites-available/m1.loc
a2ensite m1.loc
a2enmod rewrite
cp /vagrant/scripts/provision/php.ini /etc/php5/apache2/php.ini
cp /vagrant/scripts/provision/php.ini /etc/php5/cli/php.ini
cp /vagrant/scripts/provision/xdebug.ini /etc/php5/apache2/conf.d/20-xdebug.ini
sed -i 's/\(APACHE_RUN_USER=\)www-data/\1vagrant/g' /etc/apache2/envvars
chown vagrant:www-data /var/lock/apache2
service apache2 restart
echo "done"

# install MySQL
echo "Installing MySQL server"
export DEBIAN_FRONTEND=noninteractive
apt-get -q -y install mysql-server-5.5
echo "done"

# install Git
echo "Installing Git"
apt-get install -y git-core
echo "done"

# install composer
#echo "Installing composer"
#if [ ! -f "/usr/local/bin/composer" ];
#then
#    php -r "readfile('https://getcomposer.org/installer');" | php
#    mv composer.phar /usr/local/bin/composer
#fi
#echo "done"

echo "change SSH login dir"
echo "cd /vagrant" >> /home/vagrant/.bashrc
echo "done"
