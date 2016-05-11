/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.dao;

import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.bpps.pojo.Symptom;
import com.bpps.pojo.Symptom2;
import com.jdbc.DatabaseManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Administrator
 */
public class SymptomDAO {

    private static final Log log = LogFactory.getLog(SymptomDAO.class);

    public List<Integer> getAllSymptomIDByLabelId(int labelId) {
        log.debug("get All Symptom ID");

        try {
            List<Integer> objs = new ArrayList<Integer>();
            String sql = "select sym_id from symptom where label_id = "+ labelId;
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

    public List<Integer> getSymIdByPosId(int posId) {
        log.debug("get Symptoms by posid");

        try {
            List<Integer> objs = new ArrayList<Integer>();
            String sql = "select sym_id from symptom where pos_id="+posId;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                objs.add(rs.getInt(1));
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List<Integer> getSymIdByPosId(DatabaseManager dbm, int posId) {
        log.debug("get Symptoms by posid");

        try {
            List<Integer> objs = new ArrayList<Integer>();
            String sql = "select sym_id from symptom where pos_id="+posId;
//            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                objs.add(rs.getInt(1));
            }
//            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<Symptom> getSymptomsByPosId(int posId) {
        log.debug("get Symptoms by posid");

        try {
            List<Symptom> objs = new ArrayList<Symptom>();
            String sql = "select * from symptom where pos_id="+posId + " order by sym_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                Symptom obj = new Symptom();
                obj.setSymId(rs.getInt("sym_id"));
                obj.setPosId(rs.getInt("pos_id"));
                obj.setSymName(rs.getString("sym_name"));
                obj.setSymProperty(rs.getInt("sym_property"));
                obj.setParentSymId(rs.getInt("parent_sym_id"));
                obj.setHasChild(rs.getInt("has_child"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    //获得多属性的症状，而不是单属性的症状
    public List<Symptom> getMutilAttrSymptomsByPosId(int posId) {
        log.debug("get Symptoms by posid");

        try {
            List<Symptom> objs = new ArrayList<Symptom>();
            String sql = "select * from symptom where pos_id="+posId + " and sym_property=2 order by sym_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                Symptom obj = new Symptom();
                obj.setSymId(rs.getInt("sym_id"));
                obj.setPosId(rs.getInt("pos_id"));
                obj.setSymName(rs.getString("sym_name"));
                obj.setSymProperty(rs.getInt("sym_property"));
                obj.setParentSymId(rs.getInt("parent_sym_id"));
                obj.setHasChild(rs.getInt("has_child"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    //获得所有多属性的症状，而不是单属性的症状
    public List<Symptom> getAllMutilAttrSymptoms() {
        log.debug("get Symptoms by posid");

        try {
            List<Symptom> objs = new ArrayList<Symptom>();
            String sql = "select * from symptom where sym_property=2 order by sym_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                Symptom obj = new Symptom();
                obj.setSymId(rs.getInt("sym_id"));
                obj.setPosId(rs.getInt("pos_id"));
                obj.setSymName(rs.getString("sym_name"));
                obj.setSymProperty(rs.getInt("sym_property"));
                obj.setParentSymId(rs.getInt("parent_sym_id"));
                obj.setHasChild(rs.getInt("has_child"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }


    public List<Symptom> getParSymptomsByPosId(int posId) {
        log.debug("get Symptoms by posid");

        try {
            List<Symptom> objs = new ArrayList<Symptom>();
            String sql = "select * from symptom where parent_sym_id=0 and pos_id="+posId + " order by sym_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                Symptom obj = new Symptom();
                obj.setSymId(rs.getInt("sym_id"));
                obj.setPosId(rs.getInt("pos_id"));
                obj.setSymName(rs.getString("sym_name"));
                obj.setSymProperty(rs.getInt("sym_property"));
                obj.setParentSymId(rs.getInt("parent_sym_id"));
                obj.setHasChild(rs.getInt("has_child"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List<Symptom> getChildSymptomsBySymId(int symId) {
        log.debug("get Symptoms by posid");

        try {
            List<Symptom> objs = new ArrayList<Symptom>();
            String sql = "select * from symptom where parent_sym_id="+symId + " order by sym_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                Symptom obj = new Symptom();
                obj.setSymId(rs.getInt("sym_id"));
                obj.setPosId(rs.getInt("pos_id"));
                obj.setSymName(rs.getString("sym_name"));
                obj.setSymProperty(rs.getInt("sym_property"));
                obj.setParentSymId(rs.getInt("parent_sym_id"));
                obj.setHasChild(rs.getInt("has_child"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<Symptom> getSymptomsByPosIdForImageAdd(int posId) {
        log.debug("get Symptoms by posid");

        try {
            List<Symptom> objs = new ArrayList<Symptom>();
            String sql = "select * from symptom where pos_id="+posId + " order by sym_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                Symptom obj = new Symptom();
                obj.setSymId(rs.getInt("sym_id"));
                obj.setPosId(rs.getInt("pos_id"));
                obj.setSymName(rs.getString("sym_name"));
                obj.setSymProperty(rs.getInt("sym_property"));
                obj.setParentSymId(rs.getInt("parent_sym_id"));
                obj.setHasChild(rs.getInt("has_child"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List<Symptom> getNeedDiscSymptomsByPosId(int posId) {
        log.debug("get Symptoms by posid");

        try {
            List<Symptom> objs = new ArrayList<Symptom>();
            String sql = "select * from symptom where sym_property=2 and pos_id="+posId + " order by sym_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                Symptom obj = new Symptom();
                obj.setSymId(rs.getInt("sym_id"));
                obj.setPosId(rs.getInt("pos_id"));
                obj.setSymName(rs.getString("sym_name"));
                obj.setSymProperty(rs.getInt("sym_property"));
                obj.setParentSymId(rs.getInt("parent_sym_id"));
                obj.setHasChild(rs.getInt("has_child"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List<Symptom> getSymptomsByLabelId(int labelId) {
        log.debug("get All Symptom");

        try {
            List<Symptom> objs = new ArrayList<Symptom>();
            String sql = "select * from symptom where label_id = "+ labelId;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                Symptom obj = new Symptom();
                obj.setSymId(rs.getInt("sym_id"));
                obj.setPosId(rs.getInt("pos_id"));
                obj.setSymName(rs.getString("sym_name"));
                obj.setSymProperty(rs.getInt("sym_property"));
                obj.setParentSymId(rs.getInt("parent_sym_id"));
                obj.setHasChild(rs.getInt("has_child"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List getSymptoms2ByLabelId(int labelId) {
        log.debug("get All Symptom");

        try {
            List<Symptom2> objs = new ArrayList<Symptom2>();
            String sql = "SELECT sym1.*, sym2.sym_name par_name, posi.pos_name "
                    + "FROM symptom sym1 "
                    + "LEFT JOIN symptom sym2  ON sym1.parent_sym_id =sym2.sym_id "
                    + "INNER JOIN position posi ON sym1.pos_id = posi.pos_id "
                    + "where sym1.label_id = "+ labelId + " "
                    + "ORDER BY sym1.sym_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                Symptom sym = new Symptom();
                sym.setSymId(rs.getInt("sym_id"));
                sym.setPosId(rs.getInt("pos_id"));
                sym.setSymName(rs.getString("sym_name"));
                sym.setSymProperty(rs.getInt("sym_property"));
                sym.setParentSymId(rs.getInt("parent_sym_id"));
                sym.setHasChild(rs.getInt("has_child"));

                Symptom2 obj = new Symptom2();
                obj.setPosName(rs.getString("pos_name"));
                obj.setSymptom(sym);
                obj.setParentSymName(rs.getString("par_name"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List<Symptom2> getSymptoms2ByPosId(int posId) {
        log.debug("get All Symptom");

        try {
            List<Symptom2> objs = new ArrayList<Symptom2>();
            //String sql = "select sym.*, pos.pos_name from symptom sym, position pos where sym.pos_id = pos.pos_id and pos.pos_id="+ posId;
            
            String sql = "SELECT sym1.*, sym2.sym_name par_name, posi.pos_name "
                    + "FROM symptom sym1 "
                    + "LEFT JOIN symptom sym2  ON sym1.parent_sym_id =sym2.sym_id "
                    + "INNER JOIN position posi ON sym1.pos_id = posi.pos_id and posi.pos_id="+ posId
                    //+ " where sym1.parent_sym_id=0 "
                    + "ORDER BY sym1.sym_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                Symptom sym = new Symptom();
                sym.setSymId(rs.getInt("sym_id"));
                sym.setPosId(rs.getInt("pos_id"));
                sym.setSymName(rs.getString("sym_name"));
                sym.setSymProperty(rs.getInt("sym_property"));
                sym.setParentSymId(rs.getInt("parent_sym_id"));
                sym.setHasChild(rs.getInt("has_child"));

                Symptom2 obj = new Symptom2();
                obj.setPosName(rs.getString("pos_name"));
                obj.setParentSymName(rs.getString("par_name"));
                obj.setSymptom(sym);
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public Symptom getSymptomById(int id) {
        log.debug("get Symptom by ID");

        try {
            Symptom obj = new Symptom();
            String sql = "select * from symptom where sym_id=" + id;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            if (rs.next()) {
                obj.setSymId(rs.getInt("sym_id"));
                obj.setPosId(rs.getInt("pos_id"));
                obj.setSymName(rs.getString("sym_name"));
                obj.setSymProperty(rs.getInt("sym_property"));
                obj.setParentSymId(rs.getInt("parent_sym_id"));
                obj.setHasChild(rs.getInt("has_child"));
                obj.setLabelId(rs.getInt("label_id"));
            }
            dbm.close();
            return obj;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public Symptom2 getSymptom2ById(int id) {
        log.debug("get Symptom by ID");

        try {
            Symptom2 obj = new Symptom2();
            //String sql = "select sym.*, pos.pos_name from symptom sym, position pos where sym.pos_id = pos.pos_id and sym.sym_id="+id;
            
            String sql = "SELECT sym1.*, sym2.sym_name par_name, posi.pos_name "
                    + "FROM symptom sym1 "
                    + "LEFT JOIN symptom sym2  ON sym1.parent_sym_id =sym2.sym_id "
                    + "INNER JOIN position posi ON sym1.pos_id = posi.pos_id "
                    + "WHERE sym1.sym_id = " + id;
            //System.out.println(sql);
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            if (rs.next()) {
                Symptom sym = new Symptom();
                sym.setSymId(rs.getInt("sym_id"));
                sym.setPosId(rs.getInt("pos_id"));
                sym.setSymName(rs.getString("sym_name"));
                sym.setSymProperty(rs.getInt("sym_property"));
                sym.setParentSymId(rs.getInt("parent_sym_id"));
                sym.setHasChild(rs.getInt("has_child"));
                sym.setLabelId(rs.getInt("label_id"));

                obj.setPosName(rs.getString("pos_name"));
                obj.setParentSymName(rs.getString("par_name"));
                obj.setSymptom(sym);
            }
            dbm.close();
            return obj;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public void addSymptom(Symptom obj) {
        log.debug("add Symptom");

        String sql = "insert into symptom(pos_id, sym_name, sym_property, parent_sym_id, label_id)values(?,?,?,?,?)";
        DatabaseManager dbm = new DatabaseManager();
        Object[] objs = {obj.getPosId(), obj.getSymName(), obj.getSymProperty(), obj.getParentSymId(), obj.getLabelId()};
        dbm.doExecute(sql, objs);
        dbm.close();

        int symId = getMaxSymId();
        SymDisDAO symDisDAO = new SymDisDAO();
        symDisDAO.addSymDisBySymId(obj.getPosId(), symId);
    }

    public void updateSymptom(Symptom obj) {
        log.debug("update Symptom");

        String sql = "update symptom set pos_id = ?, sym_name = ?, sym_property = ?, parent_sym_id=? where sym_id = ?";
        DatabaseManager dbm = new DatabaseManager();
        Object[] objs = {obj.getPosId(), obj.getSymName(), obj.getSymProperty(), obj.getParentSymId(), obj.getSymId()};
        dbm.doExecute(sql, objs);
        dbm.close();
    }

    public void deleteSymptom(int id) {
        log.debug("delete Symptom");

        Symptom symptom = getSymptomById(id);

        String sql = "delete from symptom where sym_id = "+id;
        DatabaseManager dbm = new DatabaseManager();
        dbm.doExecute(sql);
        dbm.close();

        SymDisDAO symDisDAO = new SymDisDAO();
        symDisDAO.deleteSymDisBySymId(symptom.getPosId(), symptom.getSymId());
    }


    public int getMaxSymId(){
        log.debug("get max Symid");

        try {
            int symId = 0;
            String sql = "select max(sym_id) from symptom";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            if (rs.next()) {
                symId = rs.getInt(1);
            }
            dbm.close();
            return symId;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return 0;
        }
    }

    public int getTotalByLabelId(int labelId){

        log.debug("get total symptom");

        try {
            int disId = 0;
            String sql = "select count(*) from symptom where label_id="+labelId;
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
