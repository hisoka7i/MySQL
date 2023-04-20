
/*Declaring a cursor*/
drop PROCEDURE if EXISTS pro8;
delimiter $
create PROCEDURE pro8()
begin
DECLARE _repid, _custid, _prodid int DEFAULT 0;
DECLARE _custname, _prodname VARCHAR(78) DEFAULT "";
DECLARE _amount DOUBLE DEFAULT 0.00;


DECLARE c1 CURSOR for select repid,custid,custname,prodid,prodname,amount from sales;
DECLARE EXIT handler for 1329 SELECT "End of Table" as End;
open c1;
lbl:LOOP
FETCH c1 into _repid,_custid,_custname,_prodid,_prodname,_amount;
SELECT _repid,_custid,_custname,_prodid,_prodname,_amount;

end LOOP lbl;
CLOSE c1;
end $
delimiter ;


/*Triggers for Inserting data, Data is inserted into table d */
drop trigger if EXISTS tr1;
delimiter $
create trigger tr1 after insert on dept for each row
BEGIN
insert into d values (new.deptno, new.dname, new.loc, new.pwd, new.startedon);
end $
delimiter ;


/*Trigger for Deleting data, deleted data is inserted into table d1*/
drop trigger if EXISTS tr2;
delimiter $
create trigger tr2 after delete on dept for each row
BEGIN
insert into d1 values (old.deptno, old.dname, old.loc, old.pwd, old.startedon);
end $
delimiter ;


/*Creating a auto increment using trigger */
drop trigger if exists tr3;
delimiter $
create trigger tr3 before insert on dept for each row
BEGIN
DECLARE x int default 0;
select max(deptno)+1 into x from dept;
set new.deptno=x;
insert into d values (new.deptno, new.dname, new.loc, new.pwd, new.startedon);
end $
delimiter ;


/**/
