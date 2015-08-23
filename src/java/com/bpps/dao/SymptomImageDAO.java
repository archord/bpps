/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.dao;

import com.bpps.pojo.SymptomImage;
import com.jdbc.DatabaseManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 *
 * @author xy
 */
public class SymptomImageDAO {
    
    private static final Log log = LogFactory.getLog(SymptomDAO.class);

    public void addSymptomImage(SymptomImage obj) {
        log.debug("add SymptomImage");

        String sql = "insert into symptom_image(label_id, pos_id, sym_id, si_image_path)values(?,?,?,?)";
        DatabaseManager dbm = new DatabaseManager();
        Object[] objs = {obj.getLabelId(), obj.getPosId(), obj.getSymId(), obj.getSiImagePath()};
        dbm.doExecute(sql, objs);
        dbm.close();

    }

    public void updateSymptomImage(SymptomImage obj) {
        log.debug("update SymptomImage");

        String sql = "update symptom_image set pos_id = ?, sym_id = ?, si_image_path = ? where si_id = ?";
        DatabaseManager dbm = new DatabaseManager();
        Object[] objs = {obj.getPosId(), obj.getSymId(), obj.getSiImagePath(), obj.getSiId()};
        dbm.doExecute(sql, objs);
        dbm.close();
    }

    public void deleteSymptomImage(int id) {
        log.debug("delete SymptomImage");

        //SymptomImage symptomDiscribe = getSymptomImageById(id);

        String sql = "delete from symptom_image where si_id = "+id;
        DatabaseManager dbm = new DatabaseManager();
        dbm.doExecute(sql);
        dbm.close();
    }

    public SymptomImage getSymptomImageById(int id) {
        log.debug("get SymptomImage by ID");

        try {
            SymptomImage obj = new SymptomImage();
            String sql = "select syi.*, psi.pos_name, sym.sym_name "
                    + "from symptom_image syi "
                    + "LEFT JOIN position psi ON psi.pos_id = syi.pos_id "
                    + "LEFT JOIN symptom sym ON sym.sym_id = syi.sym_id "
                    + "where si_id=" + id;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            if (rs.next()) {
                obj.setSiId(rs.getLong("si_id"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setPosId(rs.getLong("pos_id"));
                obj.setSymId((rs.getLong("sym_id")));
                obj.setSiImagePath(rs.getString("si_image_path"));
                obj.setPosName(rs.getString("pos_name"));
                obj.setSymName(rs.getString("sym_name"));
            }
            dbm.close();
            return obj;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List<SymptomImage> getSymptomImagesBySymId(int symId) {
        log.debug("get SymptomImages by posid");

        try {
            List<SymptomImage> objs = new ArrayList<SymptomImage>();
            String sql = "select syi.*, psi.pos_name, sym.sym_name "
                    + "from symptom_image syi "
                    + "LEFT JOIN position psi ON psi.pos_id = syi.pos_id "
                    + "LEFT JOIN symptom sym ON sym.sym_id = syi.sym_id "
                    + "where syi.sym_id=" + symId;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                SymptomImage obj = new SymptomImage();
                obj.setSiId(rs.getLong("si_id"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setPosId(rs.getLong("pos_id"));
                obj.setSymId((rs.getLong("sym_id")));
                obj.setSiImagePath(rs.getString("si_image_path"));
                obj.setPosName(rs.getString("pos_name"));
                obj.setSymName(rs.getString("sym_name"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<SymptomImage> getSymptomImagesByPosId(int posId) {
        log.debug("get SymptomImages by posid");

        try {
            List<SymptomImage> objs = new ArrayList<SymptomImage>();
            String sql = "select syi.*, psi.pos_name, sym.sym_name "
                    + "from symptom_image syi "
                    + "LEFT JOIN position psi ON psi.pos_id = syi.pos_id "
                    + "LEFT JOIN symptom sym ON sym.sym_id = syi.sym_id "
                    + "where syi.pos_id=" + posId;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                SymptomImage obj = new SymptomImage();
                obj.setSiId(rs.getLong("si_id"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setPosId(rs.getLong("pos_id"));
                obj.setSymId((rs.getLong("sym_id")));
                obj.setSiImagePath(rs.getString("si_image_path"));
                obj.setPosName(rs.getString("pos_name"));
                obj.setSymName(rs.getString("sym_name"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<SymptomImage> getSymptomImagesByLabelId(int labelId) {
        log.debug("get SymptomImages by labelId");

        try {
            List<SymptomImage> objs = new ArrayList<SymptomImage>();
            String sql = "select syi.*, psi.pos_name, sym.sym_name "
                    + "from symptom_image syi "
                    + "LEFT JOIN position psi ON psi.pos_id = syi.pos_id "
                    + "LEFT JOIN symptom sym ON sym.sym_id = syi.sym_id "
                    + "where syi.label_id=" + labelId;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                SymptomImage obj = new SymptomImage();
                obj.setSiId(rs.getLong("si_id"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setPosId(rs.getLong("pos_id"));
                obj.setSymId((rs.getLong("sym_id")));
                obj.setSiImagePath(rs.getString("si_image_path"));
                obj.setPosName(rs.getString("pos_name"));
                obj.setSymName(rs.getString("sym_name"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List<SymptomImage> getSymptomImages() {
        log.debug("get All Symptom");

        try {
            List<SymptomImage> objs = new ArrayList<SymptomImage>();
            String sql = "select syi.*, psi.pos_name, sym.sym_name "
                    + "from symptom_image syi "
                    + "LEFT JOIN position psi ON psi.pos_id = syi.pos_id "
                    + "LEFT JOIN symptom sym ON sym.sym_id = syi.sym_id ";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                SymptomImage obj = new SymptomImage();
                obj.setSiId(rs.getLong("si_id"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setPosId(rs.getLong("pos_id"));
                obj.setSymId((rs.getLong("sym_id")));
                obj.setSiImagePath(rs.getString("si_image_path"));
                obj.setPosName(rs.getString("pos_name"));
                obj.setSymName(rs.getString("sym_name"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }
}
