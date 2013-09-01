package com.bpps.pojo;
// Generated 2012-6-10 23:02:51 by Hibernate Tools 3.2.1.GA



/**
 * Picture generated by hbm2java
 */
public class Picture  implements java.io.Serializable {


     private Integer picId;
     private Integer posId;
     private Integer disId;
     private String picPath;

    public Picture() {
    }

	
    public Picture(String picPath) {
        this.picPath = picPath;
    }
    public Picture(Integer posId, Integer disId, String picPath) {
       this.posId = posId;
       this.disId = disId;
       this.picPath = picPath;
    }
   
    public Integer getPicId() {
        return this.picId;
    }
    
    public void setPicId(Integer picId) {
        this.picId = picId;
    }
    public Integer getPosId() {
        return this.posId;
    }
    
    public void setPosId(Integer posId) {
        this.posId = posId;
    }
    public Integer getDisId() {
        return this.disId;
    }
    
    public void setDisId(Integer disId) {
        this.disId = disId;
    }
    public String getPicPath() {
        return this.picPath;
    }
    
    public void setPicPath(String picPath) {
        this.picPath = picPath;
    }




}


