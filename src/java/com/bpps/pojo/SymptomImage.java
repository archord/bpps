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
public class SymptomImage extends org.apache.struts.action.ActionForm implements Serializable {
    private static final long serialVersionUID = 1L;

    private Long siId;
    private Long labelId;
    private Long posId;
    private Long symId;
    private String siImagePath;
    private FormFile siImage;
    private String posName;
    private String symName;

    public SymptomImage() {
    }

    public SymptomImage(Long siId) {
        this.siId = siId;
    }

    public Long getSiId() {
        return siId;
    }

    public void setSiId(Long siId) {
        this.siId = siId;
    }

    public Long getLabelId() {
        return labelId;
    }

    public void setLabelId(Long labelId) {
        this.labelId = labelId;
    }

    public Long getPosId() {
        return posId;
    }

    public void setPosId(Long posId) {
        this.posId = posId;
    }

    public Long getSymId() {
        return symId;
    }

    public void setSymId(Long symId) {
        this.symId = symId;
    }

    public String getSiImagePath() {
        return siImagePath;
    }

    public void setSiImagePath(String siImagePath) {
        this.siImagePath = siImagePath;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (siId != null ? siId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof SymptomImage)) {
            return false;
        }
        SymptomImage other = (SymptomImage) object;
        if ((this.siId == null && other.siId != null) || (this.siId != null && !this.siId.equals(other.siId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.bpps.pojo.SymptomImage[ siId=" + siId + " ]";
    }

    /**
     * @return the siImage
     */
    public FormFile getSiImage() {
        return siImage;
    }

    /**
     * @param siImage the siImage to set
     */
    public void setSiImage(FormFile siImage) {
        this.siImage = siImage;
    }

    /**
     * @return the posName
     */
    public String getPosName() {
        return posName;
    }

    /**
     * @param posName the posName to set
     */
    public void setPosName(String posName) {
        this.posName = posName;
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
    
}
