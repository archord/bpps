/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.pojo;

import java.io.Serializable;

/**
 *
 * @author xy
 */
public class Article extends org.apache.struts.action.ActionForm implements Serializable {
    private static final long serialVersionUID = 1L;
    
    private Long articleId;
    private String articleName;
    private String articleContent;
    private Long labelId;
    private String labelName;

    public Article() {
    }

    public Article(Long articleId) {
        this.articleId = articleId;
    }

    public Long getArticleId() {
        return articleId;
    }

    public void setArticleId(Long articleId) {
        this.articleId = articleId;
    }

    public String getArticleName() {
        return articleName;
    }

    public void setArticleName(String articleName) {
        this.articleName = articleName;
    }

    public String getArticleContent() {
        return articleContent;
    }

    public void setArticleContent(String articleContent) {
        this.articleContent = articleContent;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (articleId != null ? articleId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Article)) {
            return false;
        }
        Article other = (Article) object;
        if ((this.articleId == null && other.articleId != null) || (this.articleId != null && !this.articleId.equals(other.articleId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.bpps.pojo.Article[ articleId=" + articleId + " ]";
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
        if(labelName == null) {
            this.labelName = "";
        }
        else {
            this.labelName = labelName;
        }
    }
    
}
