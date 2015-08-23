/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.dao;

import com.bpps.pojo.Article;
import com.jdbc.ConnectionFactory;
import com.jdbc.DatabaseManager;
import com.util.MyTools;
import java.io.Writer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import oracle.sql.CLOB;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 *
 * @author xy
 */
public class ArticleDAO {

    private static final Log log = LogFactory.getLog(ArticleDAO.class);

    public List<Article> getArticles() {
        log.debug("get All Article");

        try {
            List<Article> objs = new ArrayList<Article>();
            String sql = "select ar.*, ls.name label_name "
                    + "from article ar "
                    + "LEFT JOIN label_system ls ON ar.label_id = ls.label_id "
                    + "order by article_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            CLOB clob = null;
            while (rs.next()) {
                Article obj = new Article();
                obj.setArticleId(rs.getLong("article_id"));
                obj.setArticleName(rs.getString("article_name"));
                clob = (oracle.sql.CLOB) rs.getClob("article_content");
                obj.setArticleContent(MyTools.ClobToString(clob));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setLabelName(rs.getString("label_name"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<Article> getArticlesByLabelId(int labelId) {
        log.debug("get All Article");

        try {
            List<Article> objs = new ArrayList<Article>();
            String sql = "select ar.*, ls.name label_name "
                    + "from article ar "
                    + "LEFT JOIN label_system ls ON ar.label_id = ls.label_id "
                    + "where ar.label_id = " + labelId + " "
                    + "order by article_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            CLOB clob = null;
            while (rs.next()) {
                Article obj = new Article();
                obj.setArticleId(rs.getLong("article_id"));
                obj.setArticleName(rs.getString("article_name"));
                clob = (oracle.sql.CLOB) rs.getClob("article_content");
                obj.setArticleContent(MyTools.ClobToString(clob));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setLabelName(rs.getString("label_name"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public Article getArticleById(int id) {
        log.debug("get Article by ID");

        try {
            Article obj = new Article();
            String sql = "select ar.*, ls.name label_name "
                    + "from article ar "
                    + "LEFT JOIN label_system ls ON ar.label_id = ls.label_id "
                    + "where article_id = " + id;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            CLOB clob = null;
            if (rs.next()) {
                obj.setArticleId(rs.getLong("article_id"));
                obj.setArticleName(rs.getString("article_name"));
                clob = (oracle.sql.CLOB) rs.getClob("article_content");
                obj.setArticleContent(MyTools.ClobToString(clob));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setLabelName(rs.getString("label_name"));
            }
            dbm.close();
            return obj;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public Article getSystemIntroduce() {
        log.debug("get Article by ID");

        try {
            Article obj = new Article();
            String sql = "select ar.*, ls.name label_name "
                    + "from article ar "
                    + "LEFT JOIN label_system ls ON ar.label_id = ls.label_id "
                    + "where article_name = '系统介绍'";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            CLOB clob = null;
            if (rs.next()) {
                obj.setArticleId(rs.getLong("article_id"));
                obj.setArticleName(rs.getString("article_name"));
                clob = (oracle.sql.CLOB) rs.getClob("article_content");
                obj.setArticleContent(MyTools.ClobToString(clob));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setLabelName(rs.getString("label_name"));
            }
            dbm.close();
            return obj;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    
    public int getArticleIdByLabelId(long labelId) {
        log.debug("get Article id by label ID");

        int articleId = 0;
        try {
            String sql = "select article_id "
                    + "from article "
                    + "where label_id = " + labelId;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            if (rs.next()) {
                articleId = (int) rs.getLong("article_id");
            }
            dbm.close();
            return articleId;
        } catch (Exception ex) {
            ex.printStackTrace();
            return articleId;
        }
    }

    public void addArticle(Article obj) {
        log.debug("add Article");

        try {
            String sql = "insert into article(article_name, article_content, label_id)values(?,?,?)";
            Connection con = ConnectionFactory.getConnection();
            boolean defaultCommit = con.getAutoCommit();
            con.setAutoCommit(false);
            PreparedStatement pStatement = con.prepareStatement(sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pStatement.setString(1, obj.getArticleName());
            pStatement.setClob(2, CLOB.empty_lob());
            pStatement.setLong(3, obj.getLabelId());
            pStatement.execute();

            sql = "SELECT article_content FROM article WHERE article_id = (SELECT MAX(article_id) FROM article) for update";
            Statement statement = con.createStatement();
            ResultSet rs = statement.executeQuery(sql);
            if (rs.next()) {
                CLOB clob = (CLOB) rs.getClob(1);
                Writer outStream = clob.getCharacterOutputStream();
                outStream.write(obj.getArticleContent());
                outStream.flush();
                outStream.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (pStatement != null) {
                pStatement.close();
            }
            con.setAutoCommit(defaultCommit);
            if (con != null) {
                con.close();
            }

        } catch (Exception ex) {
            System.out.println("执行sql语句出错:");
            ex.printStackTrace();
        }
    }

    public void updateArticle(Article obj) {
        log.debug("update Article");

        try {
            String sql = "update article set article_name = ?, label_id = ? where article_id = ?";
            Object[] objs = {obj.getArticleName(), obj.getLabelId(), obj.getArticleId()};
            Connection con = ConnectionFactory.getConnection();
            boolean defaultCommit = con.getAutoCommit();
            con.setAutoCommit(false);
            PreparedStatement pStatement = con.prepareStatement(sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pStatement.setString(1, obj.getArticleName());
            pStatement.setLong(2, obj.getLabelId());
            pStatement.setLong(3, obj.getArticleId());
            pStatement.execute();

            Statement statement = con.createStatement();
            sql = "UPDATE article SET article_content=EMPTY_CLOB()  WHERE article_id = " + obj.getArticleId();
            statement.executeUpdate(sql);

            sql = "SELECT article_content FROM article WHERE article_id = " + obj.getArticleId() + " for update";
            ResultSet rs = statement.executeQuery(sql);
            if (rs.next()) {
                CLOB clob = (CLOB) rs.getClob(1);

                Writer outStream = clob.getCharacterOutputStream();
                outStream.write(obj.getArticleContent());
                outStream.flush();
                outStream.close();
            }
            con.setAutoCommit(defaultCommit);
            if (statement != null) {
                statement.close();
            }
            if (pStatement != null) {
                pStatement.close();
            }
            if (con != null) {
                con.close();
            }
        } catch (Exception ex) {
            System.out.println("执行sql语句出错:");
            ex.printStackTrace();
        }
    }

    public void deleteArticle(int id) {
        log.debug("delete Article");

        String sql = "delete from article where article_id = " + id;
        DatabaseManager dbm = new DatabaseManager();
        dbm.doExecute(sql);
        dbm.close();

        PosDisDAO posdisDAO = new PosDisDAO();
        posdisDAO.deletePosDisByDisId(id);
    }

    public int getMaxArticleId() {
        log.debug("get max article_id");

        try {
            int disId = 0;
            String sql = "select max(article_id) from article";
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

    public int getTotal() {

        log.debug("get total article");

        try {
            int disId = 0;
            String sql = "select count(*) from article";
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
