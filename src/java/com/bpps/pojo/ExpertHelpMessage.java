/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.pojo;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author xy
 */
public class ExpertHelpMessage extends org.apache.struts.action.ActionForm implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private Long ehmId;
    private Long userId;
    private Long eptId;
    private Short eptEnable;
    private String ehmUserQuestion;
    private String ehmExpertAnswer;
    private String ehmUserName;
    private Date ehmDate;

    public ExpertHelpMessage() {
    }

    public ExpertHelpMessage(Long ehmId) {
        this.ehmId = ehmId;
    }

    public Long getEhmId() {
        return ehmId;
    }

    public void setEhmId(Long ehmId) {
        this.ehmId = ehmId;
    }

    public Long getUserId() {
        return userId;
    }

    public void setUserId(Long userId) {
        this.userId = userId;
    }

    public Long getEptId() {
        return eptId;
    }

    public void setEptId(Long eptId) {
        this.eptId = eptId;
    }

    public Short getEptEnable() {
        return eptEnable;
    }

    public void setEptEnable(Short eptEnable) {
        this.eptEnable = eptEnable;
    }

    public String getEhmUserQuestion() {
        return ehmUserQuestion;
    }

    public void setEhmUserQuestion(String ehmUserQuestion) {
        this.ehmUserQuestion = ehmUserQuestion;
    }

    public String getEhmExpertAnswer() {
        return ehmExpertAnswer;
    }

    public void setEhmExpertAnswer(String ehmExpertAnswer) {
        this.ehmExpertAnswer = ehmExpertAnswer;
    }

    public Date getEhmDate() {
        return ehmDate;
    }

    public void setEhmDate(Date ehmDate) {
        this.ehmDate = ehmDate;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (ehmId != null ? ehmId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof ExpertHelpMessage)) {
            return false;
        }
        ExpertHelpMessage other = (ExpertHelpMessage) object;
        if ((this.ehmId == null && other.ehmId != null) || (this.ehmId != null && !this.ehmId.equals(other.ehmId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.bpps.pojo.ExpertHelpMessage[ ehmId=" + ehmId + " ]";
    }

    /**
     * @return the ehmUserName
     */
    public String getEhmUserName() {
        return ehmUserName;
    }

    /**
     * @param ehmUserName the ehmUserName to set
     */
    public void setEhmUserName(String ehmUserName) {
        this.ehmUserName = ehmUserName;
    }
    
}
