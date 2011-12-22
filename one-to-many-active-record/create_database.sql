drop database if exists one_to_many;
create database one_to_many;
grant all on one_to_many.* to 'root'@'localhost';
use one_to_many;

create table categories (
  id int not null auto_increment,
  name varchar(50) not null,
  primary key (id)
);

create table books (
  id int not null auto_increment,
  name varchar(100) not null,
  category_id int,
  primary key (id),
  foreign key (category_id) references categories (id)
);

