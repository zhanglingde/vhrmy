create table permission(
                           id int not null auto_increment primary key ,
                           code varchar(255) comment '权限编码',
                           url varchar(255) comment '接口路径',
                           method varchar(10) not null comment '请求对应 http 方法',
                           description varchar(1024) comment '权限描述',
                           action varchar(64) not null comment '权限对应的方法名'
);