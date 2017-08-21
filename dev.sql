-- create table

create table book(
	no number(10),
	title varchar2(4000),
	author varchar2(5),
	pub_date date
);

select * from book;


-- insert
insert into book values (1, '토지', '박경리', to_date('2017/08/21', 'yyyy/mm/dd'));
insert into book values (1, '토지', '가나', sysdate);


select value
	from nls_database_parameters
	where parameter = 'NLS_CHARACTERSET';

drop table book;

select rowid from book;



