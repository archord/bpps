/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.dao;

import com.bpps.pojo.Expert;
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
public class ExpertDAO {
    
    private static final Log log = LogFactory.getLog(ExpertDAO.class);

    public List<Expert> getExperts() {
        log.debug("get All Expert");

        try {
            List<Expert> objs = new ArrayList<Expert>();
            String sql = "SELECT ept.*, ls.name label_name "
                    + "FROM expert ept "
                    + "LEFT JOIN Label_System ls ON ls.label_id = ept.label_id "
                    + "order by ept_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            CLOB clob = null;
            while (rs.next()) {
                Expert obj = new Expert();
                obj.setEptAddress(rs.getString("ept_address"));
                obj.setEptEmail(rs.getString("ept_email"));
                obj.setEptId(rs.getLong("ept_id"));
                clob = (oracle.sql.CLOB) rs.getClob("ept_introduce");
                obj.setEptIntroduce(MyTools.ClobToString(clob));
                //obj.setEptIntroduce(rs.getString("ept_introduce"));
                obj.setEptName(rs.getString("ept_name"));
                obj.setEptPhone(rs.getString("ept_phone"));
                obj.setEptPostcode(rs.getString("ept_postcode"));
                obj.setEptSex(rs.getShort("ept_sex"));
                obj.setEptWeb(rs.getString("ept_web"));
                obj.setEptZhichen(rs.getString("ept_zhichen"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setLabelName(rs.getString("label_name"));
                obj.setEptPhotoUrl(rs.getString("ept_photo_url"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<Expert> getExpertsByLabelId(int labelId) {
        log.debug("get Experts by label id");

        try {
            List<Expert> objs = new ArrayList<Expert>();
            String sql = "SELECT ept.*, ls.name label_name "
                    + "FROM expert ept "
                    + "LEFT JOIN Label_System ls ON ls.label_id = ept.label_id "
                    + "where ept.label_id = "+ labelId + " "
                    + "order by ept_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            CLOB clob = null;
            while (rs.next()) {
                Expert obj = new Expert();
                obj.setEptAddress(rs.getString("ept_address"));
                obj.setEptEmail(rs.getString("ept_email"));
                obj.setEptId(rs.getLong("ept_id"));
                clob = (oracle.sql.CLOB) rs.getClob("ept_introduce");
                obj.setEptIntroduce(MyTools.ClobToString(clob));
                //obj.setEptIntroduce(rs.getString("ept_introduce"));
                obj.setEptName(rs.getString("ept_name"));
                obj.setEptPhone(rs.getString("ept_phone"));
                obj.setEptPostcode(rs.getString("ept_postcode"));
                obj.setEptSex(rs.getShort("ept_sex"));
                obj.setEptWeb(rs.getString("ept_web"));
                obj.setEptZhichen(rs.getString("ept_zhichen"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setLabelName(rs.getString("label_name"));
                obj.setEptPhotoUrl(rs.getString("ept_photo_url"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public Expert getExpertById(int id) {
        log.debug("get Expert by ID");

        try {
            Expert obj = new Expert();
            String sql = "SELECT ept.*, ls.name label_name "
                    + "FROM expert ept "
                    + "LEFT JOIN Label_System ls ON ls.label_id = ept.label_id "
                    + "where ept_id = " + id;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            CLOB clob = null;
            if (rs.next()) {
                obj.setEptAddress(rs.getString("ept_address"));
                obj.setEptEmail(rs.getString("ept_email"));
                obj.setEptId(rs.getLong("ept_id"));
                clob = (oracle.sql.CLOB) rs.getClob("ept_introduce");
                obj.setEptIntroduce(MyTools.ClobToString(clob));
                //obj.setEptIntroduce(rs.getString("ept_introduce"));
                obj.setEptName(rs.getString("ept_name"));
                obj.setEptPhone(rs.getString("ept_phone"));
                obj.setEptPostcode(rs.getString("ept_postcode"));
                obj.setEptSex(rs.getShort("ept_sex"));
                obj.setEptWeb(rs.getString("ept_web"));
                obj.setEptZhichen(rs.getString("ept_zhichen"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setLabelName(rs.getString("label_name"));
                obj.setEptPhotoUrl(rs.getString("ept_photo_url"));
            }
            dbm.close();
            return obj;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }


    public void addExpert(Expert obj) {
        log.debug("add Expert");

        try {
            String sql = "insert into expert("
                    + "label_id, ept_name, ept_sex, "
                    + "ept_phone, ept_postcode, ept_email, ept_address, "
                    + "ept_web, ept_photo_url, ept_zhichen, ept_introduce)values(?,?,?,?,?,?,?,?,?,?,?)";
            Connection con = ConnectionFactory.getConnection();
            boolean defaultCommit = con.getAutoCommit();
            con.setAutoCommit(false);
            PreparedStatement pStatement = con.prepareStatement(sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pStatement.setLong(1, obj.getLabelId());
            pStatement.setString(2, obj.getEptName());
            pStatement.setShort(3, obj.getEptSex());
            pStatement.setString(4, obj.getEptPhone());
            pStatement.setString(5, obj.getEptPostcode());
            pStatement.setString(6, obj.getEptEmail());
            pStatement.setString(7, obj.getEptAddress());
            pStatement.setString(8, obj.getEptWeb());
            pStatement.setString(9, obj.getEptPhotoUrl());
            pStatement.setString(10, obj.getEptZhichen());
            pStatement.setClob(11, CLOB.empty_lob());
            pStatement.execute();

            sql = "SELECT ept_introduce FROM expert WHERE ept_id = (SELECT MAX(ept_id) FROM expert) for update";
            Statement statement = con.createStatement();
            ResultSet rs = statement.executeQuery(sql);
            if (rs.next()) {
                CLOB clob = (CLOB) rs.getClob(1);
                Writer outStream = clob.getCharacterOutputStream();
                outStream.write(obj.getEptIntroduce());
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

    public void updateExpert(Expert obj) {
        log.debug("update Expert");

        try {
            String sql = "update expert set "
                    + "label_id = ?, ept_name = ?, ept_sex = ?, "
                    + "ept_phone = ?, ept_postcode = ?, ept_email = ?, ept_address = ?, "
                    + "ept_web = ?, ept_photo_url = ?, ept_zhichen = ? where ept_id = ?";
             
            //Object[] objs = {obj.getLabelId(), obj.getEptName(), obj.getEptSex(), obj.getEptPhone(), 
                //obj.getEptPostcode(), obj.getEptEmail(), obj.getEptAddress(), obj.getEptWeb(), 
                //obj.getEptPhotoUrl(), obj.getEptZhichen(), obj.getEptId()};
            Connection con = ConnectionFactory.getConnection();
            boolean defaultCommit = con.getAutoCommit();
            con.setAutoCommit(false);
            PreparedStatement pStatement = con.prepareStatement(sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pStatement.setLong(1, obj.getLabelId());
            pStatement.setString(2, obj.getEptName());
            pStatement.setShort(3, obj.getEptSex());
            pStatement.setString(4, obj.getEptPhone());
            pStatement.setString(5, obj.getEptPostcode());
            pStatement.setString(6, obj.getEptEmail());
            pStatement.setString(7, obj.getEptAddress());
            pStatement.setString(8, obj.getEptWeb());
            pStatement.setString(9, obj.getEptPhotoUrl());
            pStatement.setString(10, obj.getEptZhichen());
            //pStatement.setClob(11, CLOB.empty_lob());
            pStatement.setLong(11, obj.getEptId());
            pStatement.execute();

            Statement statement = con.createStatement();
            sql = "UPDATE expert SET ept_introduce=EMPTY_CLOB()  WHERE ept_id = " + obj.getEptId();
            statement.executeUpdate(sql);

            sql = "SELECT ept_introduce FROM expert WHERE ept_id = " + obj.getEptId() + " for update";
            ResultSet rs = statement.executeQuery(sql);
            if (rs.next()) {
                CLOB clob = (CLOB) rs.getClob(1);
                Writer outStream = clob.getCharacterOutputStream();
                outStream.write(obj.getEptIntroduce());
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

    public void deleteExpert(int id) {
        log.debug("delete Expert");

        String sql = "delete from expert where ept_id = " + id;
        DatabaseManager dbm = new DatabaseManager();
        dbm.doExecute(sql);
        dbm.close();

        PosDisDAO posdisDAO = new PosDisDAO();
        posdisDAO.deletePosDisByDisId(id);
    }

    public int getMaxExpertId() {
        log.debug("get max article_id");

        try {
            int disId = 0;
            String sql = "select max(article_id) from expert";
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
            String sql = "select count(*) from expert";
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
