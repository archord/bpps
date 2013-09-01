/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.dao;

import com.bpps.pojo.ExpertHelpMessage;
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
public class ExpertHelpMessageDAO {
    
    private static final Log log = LogFactory.getLog(ExpertHelpMessageDAO.class);

    public List<ExpertHelpMessage> getExpertHelpMessages() {
        log.debug("get All ExpertHelpMessage");

        try {
            List<ExpertHelpMessage> objs = new ArrayList<ExpertHelpMessage>();
            String sql = "SELECT * FROM expert_help_message order by ehm_id, ept_enable";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            CLOB clob = null;
            while (rs.next()) {
                ExpertHelpMessage obj = new ExpertHelpMessage();
                obj.setEhmDate(rs.getDate("ehm_date"));
                obj.setEhmId(rs.getLong("ehm_id"));
                clob = (oracle.sql.CLOB) rs.getClob("ehm_expert_answer");
                obj.setEhmExpertAnswer(MyTools.ClobToString(clob));
                clob = (oracle.sql.CLOB) rs.getClob("ehm_user_question");
                obj.setEhmUserQuestion(MyTools.ClobToString(clob));
                obj.setEptEnable(rs.getShort("ept_enable"));
                obj.setUserId(rs.getLong("user_id"));
                obj.setEhmUserName(rs.getString("ehm_user_name"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List<ExpertHelpMessage> getEnabledExpertHelpMessages() {
        log.debug("get All ExpertHelpMessage");

        try {
            List<ExpertHelpMessage> objs = new ArrayList<ExpertHelpMessage>();
            String sql = "SELECT * FROM expert_help_message where ept_enable = 1 order by ehm_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            CLOB clob = null;
            while (rs.next()) {
                ExpertHelpMessage obj = new ExpertHelpMessage();
                obj.setEhmDate(rs.getDate("ehm_date"));
                obj.setEhmId(rs.getLong("ehm_id"));
                clob = (oracle.sql.CLOB) rs.getClob("ehm_expert_answer");
                obj.setEhmExpertAnswer(MyTools.ClobToString(clob));
                clob = (oracle.sql.CLOB) rs.getClob("ehm_user_question");
                obj.setEhmUserQuestion(MyTools.ClobToString(clob));
                obj.setEptEnable(rs.getShort("ept_enable"));
                obj.setUserId(rs.getLong("user_id"));
                obj.setEhmUserName(rs.getString("ehm_user_name"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }
    
    public ExpertHelpMessage getExpertHelpMessageById(int id) {
        log.debug("get ExpertHelpMessage by ID");

        try {
            ExpertHelpMessage obj = new ExpertHelpMessage();
            String sql = "SELECT * FROM expert_help_message "
                    + "where ehm_id = " + id;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            CLOB clob = null;
            if (rs.next()) {
                obj.setEhmDate(rs.getDate("ehm_date"));
                obj.setEhmId(rs.getLong("ehm_id"));
                clob = (oracle.sql.CLOB) rs.getClob("ehm_expert_answer");
                obj.setEhmExpertAnswer(MyTools.ClobToString(clob));
                clob = (oracle.sql.CLOB) rs.getClob("ehm_user_question");
                obj.setEhmUserQuestion(MyTools.ClobToString(clob));
                obj.setEptEnable(rs.getShort("ept_enable"));
                obj.setUserId(rs.getLong("user_id"));
                obj.setEhmUserName(rs.getString("ehm_user_name"));
            }
            dbm.close();
            return obj;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }


    public void addExpertHelpMessage(ExpertHelpMessage obj) {
        log.debug("add ExpertHelpMessage");

        try {
            String sql = "insert into expert_help_message(ehm_user_name, ehm_user_question, ehm_date)values(?,?,SYSDATE)";
            Connection con = ConnectionFactory.getConnection();
            boolean defaultCommit = con.getAutoCommit();
            con.setAutoCommit(false);
            PreparedStatement pStatement = con.prepareStatement(sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pStatement.setString(1, obj.getEhmUserName());
            pStatement.setClob(2, CLOB.empty_lob());
            pStatement.execute();

            sql = "SELECT ehm_user_question FROM expert_help_message WHERE ehm_id = (SELECT MAX(ehm_id) FROM expert_help_message) for update";
            Statement statement = con.createStatement();
            ResultSet rs = statement.executeQuery(sql);
            if (rs.next()) {
                CLOB clob = (CLOB) rs.getClob(1);
                Writer outStream = clob.getCharacterOutputStream();
                outStream.write(obj.getEhmUserQuestion());
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

    public void updateExpertHelpMessage(ExpertHelpMessage obj) {
        log.debug("update ExpertHelpMessage");

        try {
            String sql = "update expert_help_message set ept_enable = ? where ehm_id = ?";
             
            Connection con = ConnectionFactory.getConnection();
            boolean defaultCommit = con.getAutoCommit();
            con.setAutoCommit(false);
            PreparedStatement pStatement = con.prepareStatement(sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pStatement.setShort(1, obj.getEptEnable());
            pStatement.setLong(2, obj.getEhmId());
            pStatement.execute();

            Statement statement = con.createStatement();
            sql = "UPDATE expert_help_message SET ehm_expert_answer=EMPTY_CLOB()  WHERE ehm_id = " + obj.getEhmId();
            statement.executeUpdate(sql);

            sql = "SELECT ehm_expert_answer FROM expert_help_message WHERE ehm_id = " + obj.getEhmId() + " for update";
            ResultSet rs = statement.executeQuery(sql);
            if (rs.next()) {
                CLOB clob = (CLOB) rs.getClob(1);
                Writer outStream = clob.getCharacterOutputStream();
                outStream.write(obj.getEhmExpertAnswer());
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

    public void deleteExpertHelpMessage(int id) {
        log.debug("delete ExpertHelpMessage");

        String sql = "delete from expert_help_message where ehm_id = " + id;
        DatabaseManager dbm = new DatabaseManager();
        dbm.doExecute(sql);
        dbm.close();

        PosDisDAO posdisDAO = new PosDisDAO();
        posdisDAO.deletePosDisByDisId(id);
    }

    public int getMaxExpertHelpMessageId() {
        log.debug("get max article_id");

        try {
            int disId = 0;
            String sql = "select max(ehm_id) from ehm_expert_answer";
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
            String sql = "select count(*) from ehm_expert_answer";
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
