create temporary tablespace hgbh_temp 
tempfile 'D:\oracle\product\10.2.0\hgbhdata\hgbh_temp01.dbf' 
size 32m 
autoextend on 
next 32m maxsize 2048m 
extent management local; 

create tablespace hgbh_data 
logging 
datafile 'D:\oracle\product\10.2.0\hgbhdata\hgbh_data01.dbf' 
size 32m 
autoextend on 
next 32m maxsize 2048m 
extent management local; 

create user hgbh identified by "123"
default tablespace hgbh_data 
temporary tablespace hgbh_temp; 

grant RESOURCE,CONNECT,DBA to hgbh;
