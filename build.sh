#!/bin/sh
# rmagick for sierra
#export PKG_CONFIG_PATH=/usr/local/opt/imagemagick@6/lib/pkgconfig
#export PATH=/usr/local/Cellar/imagemagick@6/6.9.7-5/bin:$PATH

if [ -d "/opt/local/lib" ]; then
    bundle config --local build.mysql2 "--with-mysql-lib=/opt/local/lib/mysql8/mysql --with-mysql-dir=/opt/local/lib/mysql8 --with-mysql-config=/opt/local/lib/mysql8/mysql/bin --with-mysql-include=/opt/local/include/mysql8/mysql --with-ldflags=-L/opt/local/lib"
else
    bundle config --delete build.mysql2
fi

bundle_dir=./vendor/bundle
if [ -d "$bundle_dir" ] ; then
    /bin/rm -rf "$bundle_dir"
    bundle update    
else
    /bin/rm -rf "$bundle_dir"
    bundle install --path "$bundle_dir"
fi





