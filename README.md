# Install terraform 
$ brew install terraform terraform-inventory

# Adequation to terraform 0.12
terraform 0.12upgrade

# Adequate variables.tf

# terraform init

# terraform plan -out vpc.plan

# terraform apply vpc.plan

# terraform show

# terraform destroy


# Install Zabbix Manually

sudo apt update -y

sudo apt upgrade -y

sudo apt install apache2 libapache2-mod-php mysql-server mysql-client  -y

sudo apt install php php-mbstring php-gd php-xml php-bcmath php-ldap php-mysql -y

wget https://repo.zabbix.com/zabbix/4.4/ubuntu/pool/main/z/zabbix-release/zabbix-release_4.4-1+bionic_all.deb

sudo dpkg -i zabbix-release_4.4-1+bionic_all.deb

sudo apt update -y

sudo apt -y install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent

MySQL 5.7
sudo cat /etc/mysql/debian.cnf
mysql -u debian-sys-maint -p
SELECT User, Host, plugin FROM mysql.user;
UPDATE mysql.user SET authentication_string=PASSWORD('root') where user='root';
flush privileges;
commit;
sudo service mysql restart
mysql -u root -p
create database zabbix character set utf8 collate utf8_bin;
grant all privileges on zabbix.* to zabbix@localhost identified by 'zabbix';
UPDATE mysql.user SET authentication_string=PASSWORD('zabbix') where user='zabbix';
flush privileges;
quit;
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql --password="zabbix" -u zabbix -h localhost zabbix


