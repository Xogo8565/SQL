select * from all_tab_columns where table_name = 'TB_CATEGORY';
select * from all_tab_columns where table_name = 'TB_CLASS_TYPE';

--1
create table TB_CATEGORY(
    name varchar2(10),
    use_yn char(1) default ('Y')
);

--2

create table TB_CLASS_TYPE(
    no varchar2(5) primary key,
    name varchar2(10)
);

--3

alter table tb_category add constraint category_pk primary key (name); 

--4

alter table tb_class_type modify name constraint name_nn not null;

--5
alter table tb_category modify name varchar2(20);
alter table tb_class_type modify (no varchar2(10), name varchar(20));

--6
alter table tb_category rename column name to category_name;
alter table tb_category rename column use_yn to category_use_yn;
alter table tb_class_type rename column no to class_type_no;
alter table tb_class_type rename column name to class_type_name;

--7
select constaint_name from user_constaints where table_name ='TB_CATEGORY';
alter table tb_category rename constraint category_pk to  pk_catergory_name;
select constaint_name from user_constaints where table_name ='TB_CLASS_TYPE';
alter table tb_class_type rename constraint SYS_C007243 to pk_class_type_no;

--8
INSERT INTO TB_CATEGORY VALUES ('공학','Y'); 
INSERT INTO TB_CATEGORY VALUES ('자연과학','Y'); 
INSERT INTO TB_CATEGORY VALUES ('의학','Y'); 
INSERT INTO TB_CATEGORY VALUES ('예체능','Y'); 
INSERT INTO TB_CATEGORY VALUES ('인문사회','Y'); 
COMMIT;

select * from tb_category;
--9
alter table tb_department add constraint fk_department_category foreign key (category) references tb_category (category_name);