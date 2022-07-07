create table Student(sID int primary key, sName text unique, GPA real, sizeHS int unique);
insert into Student values (123, 'Amy', 3.9, 1000);
insert into Student values (456, 'Doris', 3.9, 1000);
insert into Student values (567, 'Amy', 3.8, 1500);
create table College(cName varchar(10), state varchar(2), enrollment int, primary key (cName,state));
insert into College values ('Mason', 'CA', 10000);
insert into College values ('Mason', 'NY', 5000);
insert into College values ('Mason', 'CA', 2000);
create table Apply(sID int, cName varchar(10), major varchar(10), decision text, unique(sID,cName), unique(sID,major));
insert into Apply values (123, 'Stanford', 'CS', null);
insert into Apply values (123, 'Berkeley', 'EE', null);
insert into Apply values (123, 'MIT', 'biology', null);
update Apply set major = 'CS' where cName = 'MIT';
insert into Apply values (123, null, null, 'Y');
insert into Apply values (123, null, null, 'N');
#Q1
insert into College
values ('Carnegie Mellon', 'PA', 11500);
#Q2
insert into Apply
select sID, 'Carnegie Mellon', 'CS', null
from Student
where sID not in (select sID from Apply);
#Q3
delete from Student
where sID in (select sID
              from Apply
              group by sID
              having count(distinct major) > 2);