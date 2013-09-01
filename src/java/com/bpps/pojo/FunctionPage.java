/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.pojo;

/**
 *
 * @author xy
 */
public class FunctionPage extends org.apache.struts.action.ActionForm  implements java.io.Serializable {
    private static final long serialVersionUID = 1L;

    private Long pageId;
    private String name;
    private Short ispage;
    private Long articleId;
    private String articleName;
    private String url;
    private Long labelId;
    private String labelName;
    private int onlyHGShow;

    public FunctionPage() {
    }

    public FunctionPage(Long pageId) {
        this.pageId = pageId;
    }

    public Long getPageId() {
        return pageId;
    }

    public void setPageId(Long pageId) {
        this.pageId = pageId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Short getIspage() {
        return ispage;
    }

    public void setIspage(Short ispage) {
        this.ispage = ispage;
    }

    public Long getArticleId() {
        return articleId;
    }

    public void setArticleId(Long articleId) {
        this.articleId = articleId;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        if(url == null) {
            this.url = "";
        }
        else {
            this.url = url;
        }
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (pageId != null ? pageId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof FunctionPage)) {
            return false;
        }
        FunctionPage other = (FunctionPage) object;
        if ((this.pageId == null && other.pageId != null) || (this.pageId != null && !this.pageId.equals(other.pageId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.bpps.pojo.FunctionPage[ pageId=" + pageId + " ]";
    }

    /**
     * @return the articleName
     */
    public String getArticleName() {
        return articleName;
    }

    /**
     * @param articleName the articleName to set
     */
    public void setArticleName(String articleName) {
        if(articleName==null) {
            this.articleName = "";
        }
        else {
            this.articleName = articleName;
        }
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
     * @return the labelName
     */
    public String getLabelName() {
        return labelName;
    }

    /**
     * @param labelName the labelName to set
     */
    public void setLabelName(String labelName) {
        if(labelName==null) {
            this.labelName = "";
        }
        else {
            this.labelName = labelName;
        }
    }

    /**
     * @return the onlyHGShow
     */
    public int getOnlyHGShow() {
        return onlyHGShow;
    }

    /**
     * @param onlyHGShow the onlyHGShow to set
     */
    public void setOnlyHGShow(int onlyHGShow) {
        this.onlyHGShow = onlyHGShow;
    }
    
}
