alter table FUNCTION_PAGE
  add constraint PAGEIDKEY primary key (PAGE_ID)
  using index 
  tablespace HGBH_DATA
  pctfree 10
  initrans 2
  maxtrans 255;
