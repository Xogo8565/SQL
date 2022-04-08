-- BRANDS 테이블 생성
CREATE TABLE BRANDS(
    BRAND_ID NUMBER PRIMARY KEY,
    BRAND_NAME VARCHAR2(100) NOT NULL
);
 
-- PRODUCTS 테이블 생성
CREATE TABLE PRODUCTS(
    PRODUCT_NO NUMBER PRIMARY KEY,
    PRODUCT_NAME VARCHAR2(50) NOT NULL,
    PRODUCT_PRICE NUMBER NOT NULL,
    BRAND_CODE NUMBER REFERENCES BRANDS,
    SERIAL_NO VARCHAR2(100),
    SOLD_OUT CHAR(1) DEFAULT 'N' CHECK(SOLD_OUT IN ('Y', 'N'))
);

--1
select * from all_constraints where table_name = 'PRODUCTS'; -- FK 명 확인

alter table products drop constraint sys_c007303; -- FK 제거

Alter table products
add constraint products_fk 
Foreign key (brand_code) 
REFERENCES Brands (Brand_id); -- FK 생성

--2
alter table products modify product_name varchar2(20);
 
-- SEQ_BRAND_ID 시퀀스 생성
CREATE SEQUENCE SEQ_BRAND_ID
    START WITH 100
    INCREMENT BY 100
    MAXVALUE 500
    NOCYCLE;

--3   
alter SEQUENCE SEQ_BRAND_ID
    MAXVALUE 1000;
    
 
-- SEQ_PRODUCT_NO 시퀀스 생성
CREATE SEQUENCE SEQ_PRODUCT_NO
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 10000
    NOCYCLE;

select * from user_sequences;
drop sequence seq_brand_id;
drop sequence seq_product_no;

-- BRANDS 테이블 데이터 삽입
INSERT INTO BRANDS VALUES (SEQ_BRAND_ID.NEXTVAL, '삼성');
INSERT INTO BRANDS VALUES (SEQ_BRAND_ID.NEXTVAL, '애플');
select * from brands;

update brands set brand_name = '애플' where brand_id ='200';
 
-- PRODUCTS 테이블 데이터 삽입
INSERT INTO PRODUCTS VALUES (SEQ_PRODUCT_NO.NEXTVAL, '갤럭시S8', 800000, 100, 'S8','Y');
INSERT INTO PRODUCTS VALUES (SEQ_PRODUCT_NO.NEXTVAL, '갤럭시S9', 900000, 100, 'S9','N');
INSERT INTO PRODUCTS VALUES (SEQ_PRODUCT_NO.NEXTVAL, '갤럭시S10', 1000000, 100, 'S10','N');
INSERT INTO PRODUCTS VALUES (SEQ_PRODUCT_NO.NEXTVAL, '아이폰9S', 900000, 200, '9S','N');
INSERT INTO PRODUCTS VALUES (SEQ_PRODUCT_NO.NEXTVAL, '갤럭시10S', 1000000, 200, '10S','N');

select * from products;

update products 
set product_name = '아이폰9S',
      brand_code = 200,
      serial_no = '9S' where product_no = 4;


update products 
set product_name = '아이폰10S',
      brand_code = 200,
      serial_no = '10S' where product_no = 5;
 
-- 결과 조회

SELECT 
    PRODUCT_NAME, PRODUCT_PRICE, BRAND_NAME, SOLD_OUT
FROM PRODUCTS JOIN BRANDS ON (BRAND_ID = BRAND_CODE);

drop table brands;
drop table products;
