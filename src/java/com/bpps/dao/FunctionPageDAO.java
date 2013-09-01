/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.dao;

import com.bpps.pojo.FunctionPage;
import com.jdbc.DatabaseManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 *
 * @author xy
 */
public class FunctionPageDAO {

    private static final Log log = LogFactory.getLog(FunctionPageDAO.class);

    public List<FunctionPage> getAllFunctionPages() {
        log.debug("get all functionPage!");

        try {
            List<FunctionPage> objs = new ArrayList<FunctionPage>();
            String sql = "select fp.*, ar.article_name, ls.name label_name "
                    + "from function_page fp "
                    + "LEFT JOIN article ar ON fp.article_id = ar.article_id "
                    + "LEFT JOIN label_system ls ON fp.label_id = ls.label_id "
                    + "order by page_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                FunctionPage obj = new FunctionPage();
                obj.setPageId(rs.getLong("page_id"));
                obj.setName(rs.getString("name"));
                obj.setIspage(rs.getShort("ispage"));
                obj.setArticleId(rs.getLong("article_id"));
                obj.setArticleName(rs.getString("article_name"));
                obj.setUrl(rs.getString("url"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setLabelName(rs.getString("label_name"));
                obj.setOnlyHGShow(rs.getInt("only_hg_show"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public HashMap<String, String> getUrlsByLabelId(long labelId, boolean isHG) {
        log.debug("get urls by label id!");
        try {
            HashMap<String, String> urls = new HashMap<String, String>();
            String sql = "select url, name from function_page where only_hg_show=0 and label_id=" + labelId;
            if(isHG){
                sql = "select url, name from function_page where label_id=" + labelId;
            }
            
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                urls.put(rs.getString("url"), rs.getString("name"));
            }
            dbm.close();
            return urls;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public FunctionPage getFunctionPageById(long pageId) {
        log.debug("get FunctionPage by id");

        try {
            FunctionPage obj = new FunctionPage();
            String sql = "select fp.*, ar.article_name, ls.name label_name "
                    + "from function_page fp "
                    + "LEFT JOIN article ar ON fp.article_id = ar.article_id "
                    + "LEFT JOIN label_system ls ON fp.label_id = ls.label_id "
                    + "where page_id=" + pageId;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                obj.setPageId(rs.getLong("page_id"));
                obj.setName(rs.getString("name"));
                obj.setIspage(rs.getShort("ispage"));
                obj.setArticleId(rs.getLong("article_id"));
                obj.setArticleName(rs.getString("article_name"));
                obj.setUrl(rs.getString("url"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setLabelName(rs.getString("label_name"));
                obj.setOnlyHGShow(rs.getInt("only_hg_show"));
            }
            dbm.close();
            return obj;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public void addFunctionPage(FunctionPage obj) {
        log.debug("add FunctionPage");

        String sql = "insert into function_page(name, ispage, article_id, url, label_id, only_hg_show)values(?,?,?,?,?,?)";
        DatabaseManager dbm = new DatabaseManager();
        Object[] objs = {obj.getName(), obj.getIspage(), obj.getArticleId(), obj.getUrl(), obj.getLabelId(), obj.getOnlyHGShow()};
        dbm.doExecute(sql, objs);
        dbm.close();
    }

    public void updateFunctionPage(FunctionPage obj) {
        log.debug("update FunctionPage");

        String sql = "update function_page set name = ?, ispage=?, article_id=?, url=?, label_id=?, only_hg_show=?  where page_id = ?";
        DatabaseManager dbm = new DatabaseManager();
        Object[] objs = {obj.getName(), obj.getIspage(), obj.getArticleId(), obj.getUrl(), obj.getLabelId(), obj.getOnlyHGShow(), obj.getPageId()};
        dbm.doExecute(sql, objs);
        dbm.close();
    }

    public void deleteFunctionPage(int id) {
        log.debug("delete FunctionPage");

        String sql = "delete from function_page where page_id = " + id;
        DatabaseManager dbm = new DatabaseManager();
        dbm.doExecute(sql);
        dbm.close();
    }

    public int getTotalLabels() {

        log.debug("get total label");

        try {
            int disId = 0;
            String sql = "select count(*) from function_page";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            if (rs.next()) {
                disId = rs.getInt(1);
            }
            dbm.close();
            return disId;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return 0;
        }
    }
}
