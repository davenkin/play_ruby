drop database if exists students; 
create database students;
grant all on students.* to 'root'@'localhost';  
use students;
drop table if exists rubyists;  
create table rubyists (  
  id int not null auto_increment,  
  name varchar(100) not null,  
  city text not null,  
  primary key (id)  
);  
