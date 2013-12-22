/*1创建病害信息*/
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
  CACHE 10
     
CREATE TRIGGER disease_trigger BEFORE
insert ON disease FOR EACH ROW
begin
select disease_sequence.nextval into:New.dis_id from dual;
end;

/*2创建照片信息*/

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


/*3作物部位*/

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


/*4症状
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


/*5 部位病害关联
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

/*7症状病害关联 sd.sym_dis_discribe=1 AND
sym_dis_discribe:
如果是“是否”，则1代表有关联；
如果是“描述”，则大于0（描述ID），代表有关联
*/

CREATE TABLE symptom_disease (
  pos_id NUMBER(10) NOT NULL,
  sym_id NUMBER(10) NOT NULL,
  dis_id NUMBER(10) NOT NULL,
  sym_dis_discribe NUMBER(10) DEFAULT 0
) ;

/*8症状*/
CREATE TABLE symptom_discribe(
  sym_disc_id  NUMBER(10) PRIMARY KEY,
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

/*9用户*/
CREATE TABLE user_info(
  ui_id  NUMBER(10) PRIMARY KEY,
  ui_name VARCHAR2(50) DEFAULT NULL,
  ui_password VARCHAR2(50) DEFAULT NULL
);

CREATE SEQUENCE user_info_sequence
  INCREMENT BY 1
  START WITH 1
  NOMAXVALUE
  NOCYCLE
  CACHE 10;
     
CREATE TRIGGER user_info_trigger BEFORE
INSERT ON user_info FOR EACH ROW
BEGIN
SELECT user_info_sequence.nextval into:New.ui_id from dual;
END;

INSERT INTO user_info(ui_name, ui_password)VALUES('root', '123');

/*10标签*/
CREATE TABLE label_system(
  label_id  NUMBER(10) PRIMARY KEY,
  pid NUMBER(10) DEFAULT 0,
  pageid NUMBER(10) DEFAULT 0,
  name VARCHAR2(50) DEFAULT NULL,
  isactive NUMBER(1) DEFAULT 0,
  iscrop NUMBER(1) DEFAULT 0,
  url VARCHAR2(50) DEFAULT NULL, 
  level1 NUMBER(10) default 0,
  level2 NUMBER(10) default 0,
  level3 NUMBER(10) default 0,
  child_num NUMBER(2) default 0,
  menu_order NUMBER(2) default 0
);

CREATE SEQUENCE label_system_sequence
  INCREMENT BY 1
  START WITH 1
  NOMAXVALUE
  NOCYCLE
  CACHE 10;
     
CREATE TRIGGER label_system_trigger BEFORE
INSERT ON label_system FOR EACH ROW
BEGIN
SELECT label_system_sequence.nextval into:New.label_id from dual;
END;

/*11功能页*/
CREATE TABLE function_page(
  page_id  NUMBER(10) PRIMARY KEY,
  name VARCHAR2(50) DEFAULT NULL,
  ispage NUMBER(1) DEFAULT 0,
  article_id  NUMBER(10) DEFAULT NULL,
  url VARCHAR2(50) DEFAULT NULL,
  ONLY_HG_SHOW NUMBER(1) DEFAULT 0
);

CREATE SEQUENCE function_page_sequence
  INCREMENT BY 1
  START WITH 1
  NOMAXVALUE
  NOCYCLE
  CACHE 10;
     
CREATE TRIGGER function_page_trigger BEFORE
INSERT ON function_page FOR EACH ROW
BEGIN
SELECT function_page_sequence.nextval into:New.page_id from dual;
END;


/*12文章*/
CREATE TABLE article(
  article_id  NUMBER(10) PRIMARY KEY,
  article_name VARCHAR2(50) DEFAULT NULL,
  article_content CLOB DEFAULT 0
);

CREATE SEQUENCE article_sequence
  INCREMENT BY 1
  START WITH 1
  NOMAXVALUE
  NOCYCLE
  CACHE 10;
     
CREATE TRIGGER article_trigger BEFORE
INSERT ON article FOR EACH ROW
BEGIN
SELECT article_sequence.nextval into:New.article_id from dual;
END;

/*13创建症状图片表*/
CREATE TABLE symptom_image (
  si_id number(10)  primary KEY,
  label_id number(10) DEFAULT NULL,
  pos_id number(10) DEFAULT NULL,
  sym_id number(10) DEFAULT NULL,
  si_image_path VARCHAR2(100) DEFAULT NULL
);

CREATE SEQUENCE symptom_image_sequence
  INCREMENT BY 1
  START WITH 1
  NOMAXVALUE
  NOCYCLE
  CACHE 10;
     
CREATE TRIGGER symptom_image_trigger BEFORE
insert ON symptom_image FOR EACH ROW
begin
select symptom_image_sequence.nextval into:New.si_id from dual;
end;


/*14专家*/
CREATE TABLE expert (
  ept_id number(10)  primary KEY,
  label_id number(10) DEFAULT NULL,
  ept_name VARCHAR2(20) DEFAULT NULL,
  ept_sex number(1) DEFAULT NULL,
  ept_zhichen VARCHAR2(100) DEFAULT NULL,
  ept_phone VARCHAR2(100) DEFAULT NULL,
  ept_postcode VARCHAR2(100) DEFAULT NULL,
  ept_email VARCHAR2(100) DEFAULT NULL,
  ept_feature VARCHAR2(100) DEFAULT NULL,
  ept_organization VARCHAR2(100) DEFAULT NULL,
  ept_address VARCHAR2(100) DEFAULT NULL,
  ept_web VARCHAR2(100) DEFAULT NULL,
  ept_photo_url VARCHAR2(100) DEFAULT NULL,
  ept_introduce blog DEFAULT NULL
);

CREATE SEQUENCE expert_sequence
  INCREMENT BY 1
  START WITH 1
  NOMAXVALUE
  NOCYCLE
  CACHE 10;
     
CREATE TRIGGER expert_trigger BEFORE
insert ON expert FOR EACH ROW
begin
select expert_sequence.nextval into:New.ept_id from dual;
end;

/*15专家协助
*ept_enable代表用户的问题需要审核后才能，展示出来，0为待审，1表示审核通过，2为审核不通过
*/
CREATE TABLE expert_help_message (
  ehm_id number(10)  primary KEY,
  user_id number(10) DEFAULT NULL,
  ept_id number(10) DEFAULT NULL,
  ept_enable number(2) DEFAULT 0,
  ehm_user_question  CLOB DEFAULT NULL,
  ehm_expert_answer  CLOB DEFAULT NULL,
  ehm_date date DEFAULT NULL,
  ehm_user_name VARCHAR2(20) DEFAULT NULL
);

CREATE SEQUENCE expert_help_message_sequence
  INCREMENT BY 1
  START WITH 1
  NOMAXVALUE
  NOCYCLE
  CACHE 10;
     
CREATE TRIGGER expert_help_message_trigger BEFORE
insert ON expert_help_message FOR EACH ROW
begin
select expert_help_message_sequence.nextval into:New.ehm_id from dual;
end;