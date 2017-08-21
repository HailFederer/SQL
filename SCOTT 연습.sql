select * from REG_TEST order by text asc;

insert into reg_test values('0*');

SELECT *
FROM REG_TEST
WHERE REGEXP_LIKE(TEXT, '[a-z]');

select * from reg_test where REGEXP_LIKE(TEXT, '^[^a-z0-9]');

select text, length(text), LPAD(text, 9, '123456789') from REG_TEST r;

select rtrim('    ' || 'abdd' || '    ') from dual;

select round('3.4356',3) from dual;

SELECT value FROM nls_session_parameters WHERE parameter = 'NLS_DATE_FORMAT';


insert into reg_test values('a');
insert into reg_test values('aa');
insert into reg_test values('ab');
insert into reg_test values('bb');
insert into reg_test values('ba');