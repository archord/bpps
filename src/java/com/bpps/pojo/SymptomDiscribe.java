/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.bpps.pojo;

/**
 *
 * @author Administrator
 */
public class SymptomDiscribe extends org.apache.struts.action.ActionForm  {

     private Integer symDiscId;
     private int symId;
     private String symName;
     private String symDiscName;
     private Integer labelId;

    public SymptomDiscribe() {
    }


    public SymptomDiscribe(int symDiscId) {
        this.symDiscId = symDiscId;
    }

    /**
     * @return the symDiscId
     */
    public Integer getSymDiscId() {
        return symDiscId;
    }

    /**
     * @param symDiscId the symDiscId to set
     */
    public void setSymDiscId(Integer symDiscId) {
        this.symDiscId = symDiscId;
    }

    /**
     * @return the symId
     */
    public int getSymId() {
        return symId;
    }

    /**
     * @param symId the symId to set
     */
    public void setSymId(int symId) {
        this.symId = symId;
    }

    /**
     * @return the symDiscName
     */
    public String getSymDiscName() {
        return symDiscName;
    }

    /**
     * @param symDiscName the symDiscName to set
     */
    public void setSymDiscName(String symDiscName) {
        if(symDiscName==null)
            symDiscName = "";
        this.symDiscName = symDiscName;
    }

    /**
     * @return the symName
     */
    public String getSymName() {
        return symName;
    }

    /**
     * @param symName the symName to set
     */
    public void setSymName(String symName) {
        this.symName = symName;
    }

    /**
     * @return the labelId
     */
    public Integer getLabelId() {
        return labelId;
    }

    /**
     * @param labelId the labelId to set
     */
    public void setLabelId(Integer labelId) {
        this.labelId = labelId;
    }
}
