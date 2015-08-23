/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.bpps.dao;

import com.bpps.pojo.SymptomDiscribe;
import com.jdbc.DatabaseManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 *
 * @author Administrator
 */
public class SymptomDiscribeDAO {

    private static final Log log = LogFactory.getLog(SymptomDAO.class);

    public void addSymptomDiscribe(SymptomDiscribe obj) {
        log.debug("add SymptomDiscribe");

        String sql = "insert into symptom_discribe(sym_id, sym_disc_name, label_id)values(?,?,?)";
        DatabaseManager dbm = new DatabaseManager();
        Object[] objs = {obj.getSymId(), obj.getSymDiscName(), obj.getLabelId()};
        dbm.doExecute(sql, objs);
        dbm.close();

    }

    public void updateSymptomDiscribe(SymptomDiscribe obj) {
        log.debug("update SymptomDiscribe");

        String sql = "update symptom_discribe set sym_id = ?, sym_disc_name = ? where sym_disc_id = ?";
        DatabaseManager dbm = new DatabaseManager();
        Object[] objs = {obj.getSymId(), obj.getSymDiscName(), obj.getSymDiscId()};
        dbm.doExecute(sql, objs);
        dbm.close();
    }

    public void deleteSymptomDiscribe(int id) {
        log.debug("delete SymptomDiscribe");

        //SymptomDiscribe symptomDiscribe = getSymptomDiscribeById(id);

        String sql = "delete from symptom_discribe where sym_disc_id = "+id;
        DatabaseManager dbm = new DatabaseManager();
        dbm.doExecute(sql);
        dbm.close();
    }

    public SymptomDiscribe getSymptomDiscribeById(int id) {
        log.debug("get SymptomDiscribe by ID");

        try {
            SymptomDiscribe obj = new SymptomDiscribe();
            String sql = "select sd.*, s.sym_name from symptom_discribe sd, symptom s where sd.sym_id=s.sym_id and sd.sym_disc_id=" + id;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            if (rs.next()) {
                obj.setSymDiscId(rs.getInt("sym_disc_id"));
                obj.setSymId(rs.getInt("sym_id"));
                obj.setSymName(rs.getString("sym_name"));
                obj.setSymDiscName(rs.getString("sym_disc_name"));
                obj.setLabelId(rs.getInt("label_Id"));
            }
            dbm.close();
            return obj;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List<SymptomDiscribe> getSymptomDiscribesBySymId(int symId) {
        log.debug("get Symptoms by posid");

        try {
            List<SymptomDiscribe> objs = new ArrayList<SymptomDiscribe>();
            String sql = "select sd.*, s.sym_name from symptom_discribe sd, symptom s where sd.sym_id=s.sym_id and sd.sym_id=" + symId + " order by sym_disc_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                SymptomDiscribe obj = new SymptomDiscribe();
                obj.setSymDiscId(rs.getInt("sym_disc_id"));
                obj.setSymId(rs.getInt("sym_id"));
                obj.setSymName(rs.getString("sym_name"));
                obj.setSymDiscName(rs.getString("sym_disc_name"));
                obj.setLabelId(rs.getInt("label_Id"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List<SymptomDiscribe> getSymptomDiscribes() {
        log.debug("get All Symptom");

        try {
            List<SymptomDiscribe> objs = new ArrayList<SymptomDiscribe>();
            String sql = "select sd.*, s.sym_name from symptom_discribe sd, symptom s where sd.sym_id=s.sym_id order by sym_disc_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                SymptomDiscribe obj = new SymptomDiscribe();
                obj.setSymDiscId(rs.getInt("sym_disc_id"));
                obj.setSymId(rs.getInt("sym_id"));
                obj.setSymName(rs.getString("sym_name"));
                obj.setSymDiscName(rs.getString("sym_disc_name"));
                obj.setLabelId(rs.getInt("label_Id"));
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
