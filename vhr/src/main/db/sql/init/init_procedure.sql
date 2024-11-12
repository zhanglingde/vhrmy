-- ----------------------------
-- Procedure structure for addDep
-- ----------------------------
DROP PROCEDURE IF EXISTS `addDep`;
delimiter ;;
CREATE PROCEDURE `addDep`(in departmentName varchar(32),in parentId int,in enabled boolean,out result int,out result2 int)
begin
    declare did int;
    declare parentDepPath varchar(64);
insert into department set department_name=departmentName,parent_id=parentId,enabled=enabled;
select row_count() into result;
select last_insert_id() into did;
set result2=did;
select dep_path into parentDepPath from department where id=parentId;
update department set dep_path=concat(parentDepPath,'.',did) where id=did;
update department set is_parent=true where id=parentId;
end
;;
delimiter ;

-- ----------------------------
-- Procedure structure for deleteDep
-- ----------------------------
DROP PROCEDURE IF EXISTS `deleteDep`;
delimiter ;;
CREATE PROCEDURE `deleteDep`(in did int,out result int)
begin
    declare ecount int;
    declare pid int;
    declare pcount int;
    declare a int;
select count(*) into a from department where id=did and is_parent=false;
if a=0 then set result=-2;
else
select count(*) into ecount from employee where department_id=did;
if ecount>0 then set result=-1;
else
select parent_id into pid from department where id=did;
delete from department where id=did and is_parent=false;
select row_count() into result;
select count(*) into pcount from department where parent_id=pid;
if pcount=0 then update department set is_parent=false where id=pid;
end if;
end if;
end if;
end
;;
delimiter ;