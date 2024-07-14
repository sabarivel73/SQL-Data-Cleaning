/* we are going to cleaning the data */

select * from newdata.fbtable1;

/* we are going to apply self-join */

select a.`date`, a.stage, b.`date`, b.stage from newdata.fbtable1 a join newdata.fbtable1 b
on a.`date` = b.`date` and a.id <> b.id; 

/* we are going breaking the string using in sql server */

/* select substring(stage, 1, charindex('p',stage)) as new_stage,
substring(stage, charindex('p',stage) +1) as new_stage_1
from newdata.fbtable1;

alter table newdata.fbtable1 add new_stage varchar(250);

update newdata.fbtable1 set new_stage = substring(stage, 1, charindex('p',stage));

alter table newdata.fbtable1 add new_stage_1 varchar(250);

update newdata.fbtable1 set new_stage_1 = substring(stage, 1, charindex('p',stage) +1); */

/* we are going breaking the string using in sql server in backwards */

/* select parsename(replace(stage, ',','.') , 1),parsename(replace(stage, ',','.') , 2)
from newdata.fbtable1;

alter table newdata.fbtable1 add new_stage varchar(250);

update newdata.fbtable1 set new_stage = parsename(replace(stage, ',','.') , 1);

alter table newdata.fbtable1 add new_stage_1 varchar(250);

update newdata.fbtable1 set new_stage_1 = parsename(replace(stage, ',','.') , 2); */

/* we are going to change TRUE and FALSE to Yes and No */

select `Host team`, 
case when `host team` = "TRUE" then "Yes"
when `host team` = "FALSE" then "NO"
else `host team`
end as new_column
from newdata.fbtable1; 

/* we are going to remove duplicate */

create table newdata.fbtable1_new like newdata.fbtable1;

insert newdata.fbtable1_new select * from newdata.fbtable1;

with new_fbtable as
(select * , row_number() over(partition by id,`year`,`date`, satge, `home team`, `away team`, `host team`) as new_row 
from newdata.fbtable1_new) select * from new_fbtable where new_row > 1;

CREATE TABLE newdata.`fbtable` (
  `ID` int DEFAULT NULL,
  `Year` int DEFAULT NULL,
  `Date` text,
  `Stage` text,
  `Home Team` text,
  `Away Team` text,
  `Host Team` text,
  `new_row` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into newdata.fbtable select * , 
row_number() over(partition by id,`year`,`date`, satge, `home team`, `away team`, `host team`) as new_row 
from newdata.fbtable1_new;

delete from newdata.fbtable where new_row > 1; 

select * from newdata.fbtable;

/* we going to remove unwanted column */

alter table newdata.fbtable drop column new_row;

select * from newdata.fbtable;

/* Have a nice day */