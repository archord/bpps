/*1*/

CREATE TABLE disease (
  dis_id number(10)  primary key,
  dis_name varchar2(100) DEFAULT NULL,
  dis_name_en varchar2(100) DEFAULT NULL,
  dis_introduction varchar2(1000) DEFAULT NULL,
  dis_content CLOB DEFAULT NULL,
  dis_image_path VARCHAR2(100) DEFAULT NULL
);

CREATE SEQUENCE disease_sequence
  INCREMENT BY 1
  START WITH 1
  NOMAXVALUE
  NOCYCLE
  CACHE 10;
     
CREATE TRIGGER disease_trigger BEFORE
insert ON disease FOR EACH ROW
begin
select disease_sequence.nextval into:New.dis_id from dual;
end;

/*2*/

CREATE TABLE picture (
  pic_id NUMBER(10) PRIMARY KEY,
  pos_id NUMBER(10) DEFAULT NULL,
  dis_id NUMBER(10) DEFAULT NULL,
  pic_path VARCHAR2(100)  DEFAULT NULL
) ;

CREATE SEQUENCE picture_sequence
  INCREMENT BY 1
  START WITH 1
  NOMAXVALUE
  NOCYCLE
  CACHE 10;
     
CREATE TRIGGER picture_trigger BEFORE
INSERT ON picture FOR EACH ROW
BEGIN
SELECT picture_sequence.nextval into:New.pic_id from dual;
END;


/*3*/

CREATE TABLE position (
  pos_id NUMBER(10) PRIMARY KEY,
  pos_name VARCHAR2(100) DEFAULT NULL,
  pos_describe VARCHAR2(1000) DEFAULT NULL,
  pos_image_path VARCHAR2(100) DEFAULT NULL
) ;

CREATE SEQUENCE position_sequence
  INCREMENT BY 1
  START WITH 1
  NOMAXVALUE
  NOCYCLE
  CACHE 10;
     
CREATE TRIGGER position_trigger BEFORE
INSERT ON position FOR EACH ROW
BEGIN
SELECT position_sequence.nextval into:New.pos_id from dual;
END;


/*4
sym_property: 1,是否   2，文字描述
*/

CREATE TABLE symptom (
  sym_id NUMBER(10) PRIMARY KEY,
  pos_id NUMBER(10) DEFAULT NULL,
  sym_name VARCHAR2(100) DEFAULT NULL,
  sym_property NUMBER(10) DEFAULT NULL,
  parent_sym_id NUMBER(10) DEFAULT 0,
  has_child NUMBER(10) DEFAULT 0
) ;

CREATE SEQUENCE symptom_sequence
  INCREMENT BY 1
  START WITH 1
  NOMAXVALUE
  NOCYCLE
  CACHE 10;
     
CREATE TRIGGER symptom_trigger BEFORE
INSERT ON symptom FOR EACH ROW
BEGIN
SELECT symptom_sequence.nextval into:New.sym_id from dual;
END;


/*5 
pos_dis_flag 0:未关联  1：关联
*/

CREATE TABLE position_disease (
  pos_id NUMBER(10) NOT NULL,
  dis_id NUMBER(10) NOT NULL,
  pos_dis_flag NUMBER(10) NOT NULL
) ;


/*6

CREATE TABLE position_symptom (
  pos_id NUMBER(10) NOT NULL,
  sym_id NUMBER(10) NOT NULL
) ;
*/

/*7*/

CREATE TABLE symptom_disease (
  pos_id NUMBER(10) NOT NULL,
  sym_id NUMBER(10) NOT NULL,
  dis_id NUMBER(10) NOT NULL,
  sym_dis_discribe NUMBER(10) DEFAULT 0
) ;

/*8*/
CREATE TABLE symptom_discribe(
  sym_disc_id  NUMBER(10) NOT NULL,
  sym_id NUMBER(10) DEFAULT 0,
  sym_disc_name VARCHAR2(50) DEFAULT NULL
);

CREATE SEQUENCE symptom_discribe_sequence
  INCREMENT BY 1
  START WITH 1
  NOMAXVALUE
  NOCYCLE
  CACHE 10;
     
CREATE TRIGGER symptom_discribe_trigger BEFORE
INSERT ON symptom_discribe FOR EACH ROW
BEGIN
SELECT symptom_discribe_sequence.nextval into:New.sym_disc_id from dual;
END;
