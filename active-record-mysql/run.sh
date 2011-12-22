#!/bin/sh
export PATH=/usr/local/mysql/bin:$PATH
mysql -u root < create_database.sql
ruby active_record_mysql.rb
