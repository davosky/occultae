# README

## OCCULTAE

### Small web-app to manage users in SinCGIL

* Ruby version >= 8
* PostgreSQL >= 16
* Node.js >= 24
* Yarn >= 1.22
* ESbuild
* Bootstrap >= 5
* FontAwesome free

## Deploy on Alma Linux 9x

---

`sudo dnf update -y`

`sudo dnf install -y curl git wget gcc gcc-c++ make bzip2 \`
  `openssl-devel readline-devel zlib-devel libffi-devel \`
  `libyaml-devel gdbm-devel ncurses-devel libxml2-devel \`
  `libxslt-devel postgresql-devel`

Install rbenv

`git clone https://github.com/rbenv/rbenv.git ~/.rbenv`
`echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc`
`echo 'eval "$(rbenv init -)"' >> ~/.bashrc`
`source ~/.bashrc`

Install ruby-build plugin
`git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build`

Install Ruby 3.3.x (compatible with Rails 8)
`rbenv install 3.3.4`
`rbenv global 3.3.4`

Verify
`ruby -v`

`gem install bundler rails --no-document`
`rbenv rehash`

`sudo dnf install -y postgresql-server postgresql-contrib`
`sudo postgresql-setup --initdb`
`sudo systemctl enable --now postgresql`

Create DB user
`sudo -u postgres psql -c "CREATE USER myapp_user WITH PASSWORD 'securepassword';"`
`sudo -u postgres psql -c "CREATE DATABASE myapp_production OWNER myapp_user;"`

`sudo dnf install -y httpd httpd-devel`
`sudo systemctl enable --now httpd`

Open firewall ports
`sudo firewall-cmd --permanent --add-service=http`
`sudo firewall-cmd --permanent --add-service=https`
`sudo firewall-cmd --reload`

Install Passenger gem
`gem install passenger --no-document`

Compile the Apache module (follow the prompts)
`s`udo env PATH=$PATH:~/.rbenv/bin:~/.rbenv/shims \`
  passenger-install-apache2-module`

Create a Passenger config file:
`sudo nano /etc/httpd/conf.d/passenger.conf`

Paste the block copied from the installer above, then add:
*PassengerMaxPoolSize 5*
*PassengerPoolIdleTime 0*
*PassengerMaxRequests 1000*
*PassengerStatThrottleRate 120*

---

Deploy:

Create deploy directory
`sudo mkdir -p /var/www/myapp`
`sudo chown -R your_user:your_user /var/www/myapp`

Clone your app
`cd /var/www/myapp`
`git clone https://github.com/youruser/myapp.git current`
`cd current`

Install gems (production only)
`bundle config set --local deployment true`
`bundle config set --local without 'development test'`
`bundle install`

Configure Environment Variables
`nano /var/www/myapp/current/.env`

*RAILS_ENV=production*
*SECRET_KEY_BASE=your_secret_key_base_here   # rails secret*
*DB_HOST=localhost*
*DB_NAME=myapp_production*
*DB_USERNAME=myapp_user*
*DB_PASSWORD=securepassword*

Generate your secret key with:
`cd /var/www/myapp/current && rails secret`

Precompile Assets & Migrate DB
`cd /var/www/myapp/current`

`RAILS_ENV=production bundle exec rails db:migrate`
`RAILS_ENV=production bundle exec rails assets:precompile`

Configure Apache Virtual Host
`sudo nano /etc/httpd/conf.d/myapp.conf`

<VirtualHost *:80>
    ServerName yourdomain.com
    DocumentRoot /var/www/myapp/current/public

    <Directory /var/www/myapp/current/public>
        AllowOverride all
        Options -MultiViews
        Require all granted
    </Directory>

    PassengerEnabled on
    PassengerAppRoot /var/www/myapp/current
    PassengerAppEnv production
    PassengerRuby /home/your_user/.rbenv/shims/ruby

    # Serve static assets directly via Apache
    <LocationMatch "^/assets/">
        Header unset ETag
        FileETag None
        ExpiresActive On
        ExpiresDefault "access plus 1 year"
    </LocationMatch>

    ErrorLog /var/log/httpd/myapp_error.log
    CustomLog /var/log/httpd/myapp_access.log combined
</VirtualHost>

Serve static assets directly via Apache

​    <LocationMatch "^/assets/">
​        Header unset ETag
​        FileETag None
​        ExpiresActive On
​        ExpiresDefault "access plus 1 year"
​    </LocationMatch>

​    ErrorLog /var/log/httpd/myapp_error.log
​    CustomLog /var/log/httpd/myapp_access.log combined
</VirtualHost>

Set SELinux Permissions
Allow Apache to access the app directory
`sudo chcon -R -t httpd_sys_content_t /var/www/myapp/current`
`sudo chcon -R -t httpd_sys_rw_content_t /var/www/myapp/current/tmp`
`sudo chcon -R -t httpd_sys_rw_content_t /var/www/myapp/current/log`
`sudo chcon -R -t httpd_sys_rw_content_t /var/www/myapp/current/storage`

Allow Apache to connect to the network (e.g. DB, external APIs)
`sudo setsebool -P httpd_can_network_connect on`
`sudo setsebool -P httpd_can_network_connect_db on`

Restart Apache & Test
`sudo apachectl configtest     # Check for config errors`
`sudo systemctl restart httpd`

Visit http://yourdomain.com — your app should be live! 