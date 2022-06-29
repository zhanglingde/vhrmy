-- ----------------------------
-- Procedure structure for addDep
-- ----------------------------
DROP PROCEDURE IF EXISTS `addDep`;
delimiter ;;
CREATE PROCEDURE `addDep`(in depName varchar(32),in parentId int,in enabled boolean,out result int,out result2 int)
begin
    declare did int;
    declare pDepPath varchar(64);
    insert into department set name=depName,parentId=parentId,enabled=enabled;
    select row_count() into result;
    select last_insert_id() into did;
    set result2=did;
    select depPath into pDepPath from department where id=parentId;
    update department set depPath=concat(pDepPath,'.',did) where id=did;
    update department set isParent=true where id=parentId;
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
    select count(*) into a from department where id=did and isParent=false;
    if a=0 then set result=-2;
    else
        select count(*) into ecount from employee where departmentId=did;
        if ecount>0 then set result=-1;
        else
            select parentId into pid from department where id=did;
            delete from department where id=did and isParent=false;
            select row_count() into result;
            select count(*) into pcount from department where parentId=pid;
            if pcount=0 then update department set isParent=false where id=pid;
            end if;
        end if;
    end if;
end
;;
delimiter ;