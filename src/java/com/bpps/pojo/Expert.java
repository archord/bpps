/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.pojo;

import java.io.Serializable;
import org.apache.struts.upload.FormFile;

/**
 *
 * @author xy
 */
public class Expert extends org.apache.struts.action.ActionForm implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private Long eptId;
    private Long labelId;
    private String labelName;
    private String eptName;
    private Short eptSex;
    private String eptZhichen;
    private String eptPhone;
    private String eptPostcode;
    private String eptEmail;
    private String eptAddress;
    private String eptWeb;
    private String eptIntroduce;
    private String eptPhotoUrl;
    private FormFile eptPhoto;
    private String eptFeature;
    private String eptOrganization;

    public Expert() {
    }

    public Expert(Long eptId) {
        this.eptId = eptId;
    }

    public Long getEptId() {
        return eptId;
    }

    public void setEptId(Long eptId) {
        this.eptId = eptId;
    }

    public String getEptName() {
        return eptName;
    }

    public void setEptName(String eptName) {
        this.eptName = eptName;
    }

    public Short getEptSex() {
        return eptSex;
    }

    public void setEptSex(Short eptSex) {
        this.eptSex = eptSex;
    }

    public String getEptZhichen() {
        return eptZhichen;
    }

    public void setEptZhichen(String eptZhichen) {
        if(eptZhichen==null || eptZhichen.equals("")){
            this.eptZhichen="";
        }else
        this.eptZhichen = eptZhichen;
    }

    public String getEptPhone() {
        return eptPhone;
    }

    public void setEptPhone(String eptPhone) {
        if(eptPhone==null || eptPhone.equals("")){
            this.eptPhone="";
        }else
        this.eptPhone = eptPhone;
    }

    public String getEptPostcode() {
        return eptPostcode;
    }

    public void setEptPostcode(String eptPostcode) {
        if(eptPostcode==null || eptPostcode.equals("")){
            this.eptPostcode="";
        }else
        this.eptPostcode = eptPostcode;
    }

    public String getEptEmail() {
        return eptEmail;
    }

    public void setEptEmail(String eptEmail) {
        if(eptEmail==null || eptEmail.equals("")){
            this.eptEmail="";
        }else
        this.eptEmail = eptEmail;
    }

    public String getEptAddress() {
        return eptAddress;
    }

    public void setEptAddress(String eptAddress) {
        if(eptAddress==null || eptAddress.equals("") || eptAddress.equals("null")){
            this.eptAddress="";
        }else
        this.eptAddress = eptAddress;
    }

    public String getEptWeb() {
        return eptWeb;
    }

    public void setEptWeb(String eptWeb) {
        if(eptWeb==null || eptWeb.equals("")){
            this.eptWeb="";
        }else
        this.eptWeb = eptWeb;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (eptId != null ? eptId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Expert)) {
            return false;
        }
        Expert other = (Expert) object;
        if ((this.eptId == null && other.eptId != null) || (this.eptId != null && !this.eptId.equals(other.eptId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.bpps.pojo.Expert[ eptId=" + eptId + " ]";
    }

    /**
     * @return the labelId
     */
    public Long getLabelId() {
        return labelId;
    }

    /**
     * @param labelId the labelId to set
     */
    public void setLabelId(Long labelId) {
        this.labelId = labelId;
    }

    /**
     * @return the eptIntroduce
     */
    public String getEptIntroduce() {
        return eptIntroduce;
    }

    /**
     * @param eptIntroduce the eptIntroduce to set
     */
    public void setEptIntroduce(String eptIntroduce) {
        if(eptIntroduce==null || eptIntroduce.equals("")){
            this.eptIntroduce="";
        }else
        this.eptIntroduce = eptIntroduce;
    }

    /**
     * @return the labelName
     */
    public String getLabelName() {
        return labelName;
    }

    /**
     * @param labelName the labelName to set
     */
    public void setLabelName(String labelName) {
        if(labelName==null || labelName.equals("")){
            this.labelName="";
        }else
        this.labelName = labelName;
    }

    /**
     * @return the eptPhotoUrl
     */
    public String getEptPhotoUrl() {
        return eptPhotoUrl;
    }

    /**
     * @param eptPhotoUrl the eptPhotoUrl to set
     */
    public void setEptPhotoUrl(String eptPhotoUrl) {
        if(eptPhotoUrl==null || eptPhotoUrl.equals("")){
            this.eptPhotoUrl="";
        }else
        this.eptPhotoUrl = eptPhotoUrl;
    }

    /**
     * @return the eptPhoto
     */
    public FormFile getEptPhoto() {
        return eptPhoto;
    }

    /**
     * @param eptPhoto the eptPhoto to set
     */
    public void setEptPhoto(FormFile eptPhoto) {
        this.eptPhoto = eptPhoto;
    }

    /**
     * @return the eptFeature
     */
    public String getEptFeature() {
        return eptFeature;
    }

    /**
     * @param eptFeature the eptFeature to set
     */
    public void setEptFeature(String eptFeature) {
        if(eptFeature==null || eptFeature.equals("")){
            this.eptFeature="";
        }else
        this.eptFeature = eptFeature;
    }

    /**
     * @return the eptOrganization
     */
    public String getEptOrganization() {
        return eptOrganization;
    }

    /**
     * @param eptOrganization the eptOrganization to set
     */
    public void setEptOrganization(String eptOrganization) {
        if(eptOrganization==null || eptOrganization.equals("")){
            this.eptOrganization="";
        }else
        this.eptOrganization = eptOrganization;
    }
    
}
