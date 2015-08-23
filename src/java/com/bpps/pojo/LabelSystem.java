/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.pojo;

/**
 *
 * @author xy
 */
public class LabelSystem extends org.apache.struts.action.ActionForm  implements java.io.Serializable {
    private Long labelId;
    private Long pid;
    private Long pageid;
    private String name;
    private String pName;
    private String pageName;
    private Short isactive;
    private Short iscrop;
    private String url;
    private Long level1;
    private Long level2;
    private Long level3;
    private int childNum;
    private int menuOrder;

    public LabelSystem() {
    }

    public LabelSystem(Long labelId) {
        this.labelId = labelId;
    }

    public Long getLabelId() {
        return labelId;
    }

    public void setLabelId(Long labelId) {
        this.labelId = labelId;
    }

    public Long getPid() {
        return pid;
    }

    public void setPid(Long pid) {
        this.pid = pid;
    }

    public Long getPageid() {
        return pageid;
    }

    public void setPageid(Long pageid) {
        this.pageid = pageid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Short getIsactive() {
        return isactive;
    }

    public void setIsactive(Short isactive) {
        this.isactive = isactive;
    }

    public Short getIscrop() {
        return iscrop;
    }

    public void setIscrop(Short iscrop) {
        this.iscrop = iscrop;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        if(url==null) {
            this.url = "";
        }
        else {
            this.url = url;
        }
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (labelId != null ? labelId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof LabelSystem)) {
            return false;
        }
        LabelSystem other = (LabelSystem) object;
        if ((this.labelId == null && other.labelId != null) || (this.labelId != null && !this.labelId.equals(other.labelId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.bpps.pojo.LabelSystem[ labelId=" + labelId + " ]";
    }

    /**
     * @return the pName
     */
    public String getpName() {
        return pName;
    }

    /**
     * @param pName the pName to set
     */
    public void setpName(String pName) {
        if(pName==null) {
            this.pName = "";
        }
        else {
            this.pName = pName;
        }
    }

    /**
     * @return the pageName
     */
    public String getPageName() {
        return pageName;
    }

    /**
     * @param pageName the pageName to set
     */
    public void setPageName(String pageName) {
        if(pageName==null) {
            this.pageName = "";
        }
        else {
            this.pageName = pageName;
        }
    }

    /**
     * @return the level1
     */
    public Long getLevel1() {
        return level1;
    }

    /**
     * @param level1 the level1 to set
     */
    public void setLevel1(Long level1) {
        this.level1 = level1;
    }

    /**
     * @return the level2
     */
    public Long getLevel2() {
        return level2;
    }

    /**
     * @param level2 the level2 to set
     */
    public void setLevel2(Long level2) {
        this.level2 = level2;
    }

    /**
     * @return the level3
     */
    public Long getLevel3() {
        return level3;
    }

    /**
     * @param level3 the level3 to set
     */
    public void setLevel3(Long level3) {
        this.level3 = level3;
    }

    /**
     * @return the childNum
     */
    public int getChildNum() {
        return childNum;
    }

    /**
     * @param childNum the childNum to set
     */
    public void setChildNum(int childNum) {
        this.childNum = childNum;
    }

    /**
     * @return the menuOrder
     */
    public int getMenuOrder() {
        return menuOrder;
    }

    /**
     * @param menuOrder the menuOrder to set
     */
    public void setMenuOrder(int menuOrder) {
        this.menuOrder = menuOrder;
    }
    
}
