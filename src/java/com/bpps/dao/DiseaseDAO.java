/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.dao;

import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.bpps.pojo.Disease;
import com.jdbc.ConnectionFactory;
import com.jdbc.DatabaseManager;
import com.util.MyTools;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.io.Writer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import oracle.sql.CLOB;

/**
 *
 * @author Administrator
 */
public class DiseaseDAO {

    private static final Log log = LogFactory.getLog(DiseaseDAO.class);

    public List<Integer> getAllDiseaseID() {
        log.debug("get All Disease ID");

        try {
            List<Integer> objs = new ArrayList<Integer>();
            String sql = "select dis_id from disease";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                Integer obj = rs.getInt(1);
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<Integer> getAllDiseaseIDByLabelId(int labelId) {
        log.debug("get All Disease ID by labelId");

        try {
            List<Integer> objs = new ArrayList<Integer>();
            String sql = "select dis_id from disease where label_id = "+ labelId;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                Integer obj = rs.getInt(1);
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List<Disease> getDiseases() {
        log.debug("get All Disease");

        try {
            List<Disease> objs = new ArrayList<Disease>();
            String sql = "select * from disease order by dis_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            CLOB clob = null;
            while (rs.next()) {
                Disease obj = new Disease();
                obj.setDisId(rs.getInt("dis_id"));
                obj.setDisName(rs.getString("dis_name"));
                obj.setDisNameEn(rs.getString("dis_name_en"));
                obj.setDisIntroduction(rs.getString("dis_introduction"));
                //obj.setDisContent(rs.getString("dis_content"));
                clob = (oracle.sql.CLOB) rs.getClob("dis_content");
                obj.setDisContent(MyTools.ClobToString(clob));
                obj.setDisImagePath(rs.getString("dis_image_path"));
                obj.setLabelId(rs.getInt("label_id"));
                clob = (oracle.sql.CLOB) rs.getClob("DIS_PREVENTION_CONTENT");
                obj.setDisPreventionContent(MyTools.ClobToString(clob));
                clob = (oracle.sql.CLOB) rs.getClob("DIS_SPECTRUM");
                obj.setDisSpectrum(MyTools.ClobToString(clob));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List<Disease> getDiseasesByLabelId(int labelId) {
        log.debug("get Diseases by labelId");

        try {
            List<Disease> objs = new ArrayList<Disease>();
            String sql = "select * from disease where label_id = "+ labelId +" order by dis_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            CLOB clob = null;
            while (rs.next()) {
                Disease obj = new Disease();
                obj.setDisId(rs.getInt("dis_id"));
                obj.setDisName(rs.getString("dis_name"));
                obj.setDisNameEn(rs.getString("dis_name_en"));
                obj.setDisIntroduction(rs.getString("dis_introduction"));
                //obj.setDisContent(rs.getString("dis_content"));
                clob = (oracle.sql.CLOB) rs.getClob("dis_content");
                obj.setDisContent(MyTools.ClobToString(clob));
                obj.setDisImagePath(rs.getString("dis_image_path"));
                obj.setLabelId(rs.getInt("label_id"));
                clob = (oracle.sql.CLOB) rs.getClob("DIS_PREVENTION_CONTENT");
                obj.setDisPreventionContent(MyTools.ClobToString(clob));
                clob = (oracle.sql.CLOB) rs.getClob("DIS_SPECTRUM");
                obj.setDisSpectrum(MyTools.ClobToString(clob));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<Disease> getDiseasesByPosId(int posId) {
        log.debug("get All Disease by pos id");

        try {
            List<Disease> objs = new ArrayList<Disease>();
            String sql = "select d.* from disease d, position_disease pd where  d.dis_id = pd.dis_id and pd.pos_id=" +posId+ " and pd.pos_dis_flag=1 order by d.dis_id";
            //System.out.println(sql);
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            CLOB clob = null;
            while (rs.next()) {
                Disease obj = new Disease();
                obj.setDisId(rs.getInt("dis_id"));
                obj.setDisName(rs.getString("dis_name"));
                obj.setDisNameEn(rs.getString("dis_name_en"));
                obj.setDisIntroduction(rs.getString("dis_introduction"));
                //obj.setDisContent(rs.getString("dis_content"));
                clob = (oracle.sql.CLOB) rs.getClob("dis_content");
                obj.setDisContent(MyTools.ClobToString(clob));
                obj.setDisImagePath(rs.getString("dis_image_path"));
                obj.setLabelId(rs.getInt("label_id"));
                clob = (oracle.sql.CLOB) rs.getClob("DIS_PREVENTION_CONTENT");
                obj.setDisPreventionContent(MyTools.ClobToString(clob));
                clob = (oracle.sql.CLOB) rs.getClob("DIS_SPECTRUM");
                obj.setDisSpectrum(MyTools.ClobToString(clob));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List<Disease> getDiseasesByPosIdForImageShow(int posId) {
        log.debug("get All Disease by pos id");

        try {
            List<Disease> objs = new ArrayList<Disease>();
            String sql = "select d.*, pd.pos_dis_image_path from disease d, position_disease pd where  d.dis_id = pd.dis_id and pd.pos_id=" +posId+ " and pd.pos_dis_flag=1 order by d.dis_id";
            //System.out.println(sql);
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            CLOB clob = null;
            String imagePath = "";
            while (rs.next()) {
                Disease obj = new Disease();
                obj.setDisId(rs.getInt("dis_id"));
                obj.setDisName(rs.getString("dis_name"));
                obj.setDisNameEn(rs.getString("dis_name_en"));
                obj.setDisIntroduction(rs.getString("dis_introduction"));
                //obj.setDisContent(rs.getString("dis_content"));
                clob = (oracle.sql.CLOB) rs.getClob("dis_content");
                obj.setDisContent(MyTools.ClobToString(clob));
                imagePath = rs.getString("pos_dis_image_path");
                if(imagePath==null||imagePath.equals("")) {
                    imagePath = rs.getString("dis_image_path");
                }
                obj.setDisImagePath(imagePath);
                obj.setLabelId(rs.getInt("label_id"));
                clob = (oracle.sql.CLOB) rs.getClob("DIS_SPECTRUM");
                obj.setDisSpectrum(MyTools.ClobToString(clob));
                objs.add(obj);
            }

            dbm.close();
            return objs;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public Disease getDiseaseById(int id){
        log.debug("get Disease by ID");

        try {
            Disease obj = new Disease();
            String sql = "select * from disease where dis_id = "+id;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            CLOB clob = null;
            if (rs.next()) {
                obj.setDisId(rs.getInt("dis_id"));
                obj.setDisName(rs.getString("dis_name"));
                obj.setDisNameEn(rs.getString("dis_name_en"));
                obj.setDisIntroduction(rs.getString("dis_introduction"));
                //obj.setDisContent(rs.getString("dis_content"));
                clob = (oracle.sql.CLOB) rs.getClob("dis_content");
                obj.setDisContent(MyTools.ClobToString(clob));
                obj.setDisImagePath(rs.getString("dis_image_path"));
                obj.setLabelId(rs.getInt("label_id"));
                clob = (oracle.sql.CLOB) rs.getClob("DIS_PREVENTION_CONTENT");
                obj.setDisPreventionContent(MyTools.ClobToString(clob));
                clob = (oracle.sql.CLOB) rs.getClob("DIS_SPECTRUM");
                obj.setDisSpectrum(MyTools.ClobToString(clob));
            }
            dbm.close();
            return obj;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public void addDisease(Disease obj){
        log.debug("add Disease");

        try {
            String sql = "insert into disease(dis_name, dis_name_en, dis_introduction, dis_content, dis_image_path, label_id, DIS_PREVENTION_CONTENT, DIS_SPECTRUM)values(?,?,?,?,?,?,?,?)";
            Connection con = ConnectionFactory.getConnection();
            boolean defaultCommit = con.getAutoCommit();
            con.setAutoCommit(false);
            PreparedStatement pStatement = con.prepareStatement(sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pStatement.setString(1, obj.getDisName());
            pStatement.setString(2, obj.getDisNameEn());
            pStatement.setString(3, obj.getDisIntroduction());
            pStatement.setClob(4, CLOB.empty_lob());
            pStatement.setString(5, obj.getDisImagePath());
            pStatement.setInt(6, obj.getLabelId());
            pStatement.setClob(7, CLOB.empty_lob());
            pStatement.setClob(8, CLOB.empty_lob());
            pStatement.execute();
            
            sql = "SELECT dis_content, DIS_PREVENTION_CONTENT, DIS_SPECTRUM FROM disease WHERE dis_id = (SELECT MAX(dis_id) FROM disease) for update";
            Statement statement = con.createStatement();
            ResultSet rs = statement.executeQuery(sql);
            if (rs.next()) {
                CLOB clob = (CLOB) rs.getClob("dis_content");
                Writer outStream = clob.getCharacterOutputStream();
                outStream.write(obj.getDisContent());
                outStream.flush();
                outStream.close();
                
                clob = (CLOB) rs.getClob("DIS_PREVENTION_CONTENT");
                outStream = clob.getCharacterOutputStream();
                outStream.write(obj.getDisPreventionContent());
                outStream.flush();
                outStream.close();
                
                clob = (CLOB) rs.getClob("DIS_SPECTRUM");
                outStream = clob.getCharacterOutputStream();
                outStream.write(obj.getDisSpectrum());
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

            int maxId = getMaxDisId();
            PosDisDAO posdisDAO = new PosDisDAO();
            posdisDAO.addPosDisByDisId(maxId, obj.getLabelId());

        } catch (Exception ex) {
            System.out.println("执行sql语句出错:");
            ex.printStackTrace();
        }
    }

    public void updateDisease(Disease obj){
        log.debug("add Disease");

        try {
            String sql = "update disease set dis_name = ?, dis_name_en = ?, dis_introduction = ?, dis_image_path = ? where dis_id = ?";
            Object[] objs = {obj.getDisName(), obj.getDisNameEn(), obj.getDisIntroduction(), obj.getDisId()};
            Connection con = ConnectionFactory.getConnection();
            boolean defaultCommit = con.getAutoCommit();
            con.setAutoCommit(false);
            PreparedStatement pStatement = con.prepareStatement(sql,
                    ResultSet.TYPE_SCROLL_INSENSITIVE,
                    ResultSet.CONCUR_READ_ONLY);
            pStatement.setString(1, obj.getDisName());
            pStatement.setString(2, obj.getDisNameEn());
            pStatement.setString(3, obj.getDisIntroduction());
            pStatement.setString(4, obj.getDisImagePath());
            pStatement.setInt(5, obj.getDisId());
            pStatement.execute();

            Statement statement = con.createStatement();
            sql = "UPDATE disease SET dis_content=EMPTY_CLOB(), DIS_PREVENTION_CONTENT=EMPTY_CLOB(), DIS_SPECTRUM=EMPTY_CLOB()  WHERE dis_id = " + obj.getDisId();
            statement.executeUpdate(sql);
            
            sql = "SELECT dis_content, DIS_PREVENTION_CONTENT, DIS_SPECTRUM FROM disease WHERE dis_id = " + obj.getDisId() +" for update";
            ResultSet rs = statement.executeQuery(sql);
            if (rs.next()) {
                CLOB clob = (CLOB) rs.getClob("dis_content");
                Writer outStream = clob.getCharacterOutputStream();
                outStream.write(obj.getDisContent());
                outStream.flush();
                outStream.close();
                
                clob = (CLOB) rs.getClob("DIS_PREVENTION_CONTENT");
                outStream = clob.getCharacterOutputStream();
                outStream.write(obj.getDisPreventionContent());
                outStream.flush();
                outStream.close();
                
                clob = (CLOB) rs.getClob("DIS_SPECTRUM");
                outStream = clob.getCharacterOutputStream();
                String tmp = obj.getDisSpectrum();
                System.out.println(tmp);
                outStream.write(tmp);
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

    public void deleteDisease(int id){
        log.debug("delete Disease");

        String sql = "delete from disease where dis_id = "+id;
        DatabaseManager dbm = new DatabaseManager();
        dbm.doExecute(sql);
        dbm.close();

        PosDisDAO posdisDAO = new PosDisDAO();
        posdisDAO.deletePosDisByDisId(id);
    }

    public int getMaxDisId(){
        log.debug("get max Disid");

        try {
            int disId = 0;
            String sql = "select max(dis_id) from disease";
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

    public int getTotalByLabelId(int labelId){

        log.debug("get total disease");

        try {
            int disId = 0;
            String sql = "select count(*) from disease where label_id="+labelId;
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
