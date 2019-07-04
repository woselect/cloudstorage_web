/*==============================================================*/
/* 数据库脚本                        */
/*==============================================================*/
drop database if exists swift;
create database swift character set utf8;
use swift;
	
drop table if exists t_user;
create table t_user
(
  id          int not null AUTO_INCREMENT,
  username    varchar(255) not null,
  realname    varchar(255) not null,
  email       varchar(255) not null,
  password    varchar(255) not null,
  joindate    varchar(255) default null,
  lastdate    varchar(255) default null,
  capacity    int default 1024,
  primary key (id)
)ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

drop table if exists t_sharefile;
CREATE TABLE t_sharefile (
  id 		  int(11) NOT NULL auto_increment,
  userid      int(11) default NULL,
  filename    varchar(255) default NULL,
  filepath    varchar(255) default NULL,
  type        int(11) default NULL,
  http        varchar(255) default NULL,
  pwd         varchar(255) default NULL,
  isdir       varchar(255) default NULL,
  filelength  varchar(255) default NULL,
  data        varchar(255) default NULL,
  PRIMARY KEY  (id),
  KEY shareuserid (userid),
  CONSTRAINT shareuserid FOREIGN KEY (userid) REFERENCES t_user (id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `t_group` (
  `id` int(11) NOT NULL auto_increment,
  `userid` int(11) default NULL,
  `name` varchar(255) default NULL,  
  `date` varchar(255) default NULL,
  PRIMARY KEY  (`id`),
  CONSTRAINT `userid` FOREIGN KEY (`userid`) REFERENCES `t_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `t_grouplink` (
  `id` int(11) NOT NULL auto_increment,
  `groupid` int(11) default NULL,
  `usersid`  int(11) default NULL,
  PRIMARY KEY  (`id`),
  CONSTRAINT `groupid` FOREIGN KEY (`groupid`) REFERENCES `t_group` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usersid` FOREIGN KEY (`usersid`) REFERENCES `t_user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
