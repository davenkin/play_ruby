drop database if exists mass_opinion; 
create database mass_opinion;
grant all on mass_opinion.* to 'root'@'localhost';  
use mass_opinion;

create table users (  
  id int not null auto_increment,  
  name varchar(50) not null,  
  password varchar(50) not null,
  email varchar(50) not null,
  register_date date not null,
  primary key (id)  
); 


create table questionnaires (
  id int not null auto_increment,
  name varchar(200) not null,
  post_date date not null,
  user_id int not null,
  primary key (id),
  foreign key (user_id) references users (id)
);


create table options (
  id int not null auto_increment,
  content varchar(200) not null,
  vote_count int default 0,
  questionnaire_id int not null,
  primary key (id),
  foreign key (questionnaire_id) references questionnaires (id)
);


create table comments (
  id int not null auto_increment,
  content varchar(500) not null,
  post_date date not null,
  user_id int not null,
  questionnaire_id int not null,
  primary key (id),
  foreign key (user_id) references users (id),
  foreign key (questionnaire_id) references questionnaires (id)
);

create table categories (
  id int not null auto_increment,
  name varchar(50) not null,
  primary key (id) 
);

create table categories_questionnaires (
  id int not null auto_increment,
  questionnaire_id int not null,
  category_id int not null,
  primary key (id),
  foreign key (questionnaire_id) references questionnaires (id),
  foreign key (category_id) references categories (id)
);


