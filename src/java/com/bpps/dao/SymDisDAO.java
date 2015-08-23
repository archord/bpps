/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.dao;

import com.bpps.pojo.Position;
import com.bpps.pojo.Symptom;
import com.bpps.pojo.SymptomDisease;
import com.jdbc.DatabaseManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 *
 * @author Administrator
 */
public class SymDisDAO {

    private static final Log log = LogFactory.getLog(DiseaseDAO.class);

    public List<Integer> getDiscribeIdsByPosDisSymId(int posId, int disId, int symId) {
        log.debug("get Discribe by posid, disid and symid");

        try {
            List<Integer> objs = new ArrayList<Integer>();
            //String sql = "select * from symptom_disease where sym_dis_discribe!=0 and pos_id=" + posId + " and dis_id=" + disId;
            String sql = "SELECT sd.*, s.sym_property "
                    + "FROM symptom_disease sd "
                    + "INNER JOIN symptom s ON sd.sym_id=s.sym_id "
                    + "WHERE sd.sym_dis_discribe!=0 and sd.pos_id=" + posId + " and sd.dis_id=" + disId + "and sd.sym_id=" + symId;
            //System.out.println(sql);
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                objs.add(rs.getInt("sym_dis_discribe"));
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public Map<Integer, Integer> getDiscribeByPosDisId(int posId, int disId) {
        log.debug("get All Symptom ID");

        try {
            Map<Integer, Integer> objs = new HashMap<Integer, Integer>();
            String sql = "select * from symptom_disease where pos_id=" + posId + " and dis_id=" + disId;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                objs.put(rs.getInt("sym_id"), rs.getInt("sym_dis_discribe"));
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    /*
     * 获取对应位置疾病对应的症状及症状描述
     * sym_property的取值为1或2：
     *      1代表sym_dis_discribe的取值为布尔类型（是或否、1或0），
     *      2代表sym_dis_discribe的值为字符串类型（其值为症状描述所的id）。
     * sym_dis_discribe的取值为正整数
     *      等于0：sym_property的取值为1，
     *      等于1：sym_property的取值为1且sym_dis_discribe的取值为1为布尔值（是），或，sym_property的取值为2且sym_dis_discribe的取值为1为症状描述所的id
     *      大于1：症状描述所的id
     */
    public List<String> getStrDiscribeByPosDisId(int posId, int disId) {
        log.debug("get All Symptom ID");

        try {
            List<String> objs = new ArrayList<String>();
            //String sql = "select * from symptom_disease where sym_dis_discribe!=0 and pos_id=" + posId + " and dis_id=" + disId;
            String sql = "SELECT sd.*, s.sym_property "
                    + "FROM symptom_disease sd "
                    + "INNER JOIN symptom s ON sd.sym_id=s.sym_id "
                    + "WHERE sd.sym_dis_discribe!=0 and sd.pos_id=" + posId + " and sd.dis_id=" + disId;
            //System.out.println(sql);
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                if (rs.getInt("sym_property") == 1 && rs.getInt("sym_dis_discribe") == 1) {
                    objs.add(rs.getInt("sym_id") + "_0");//为了避免前面注释所描述的问题，在这里做特殊处理，将1编码为0，以方便后面的统一集合操作
                } else {
                    objs.add(rs.getInt("sym_id") + "_" + rs.getInt("sym_dis_discribe"));
                }
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List<SymptomDisease> getSymDisByPosDisId(int posId, int disId) {
        log.debug("get All Symptom ID");

        try {
            List<SymptomDisease> objs = new ArrayList<SymptomDisease>();
            String sql = "select * from symptom_disease where pos_id=" + posId + " and dis_id=" + disId + " order by sym_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                SymptomDisease obj = new SymptomDisease();
                obj.setPosId(rs.getInt("pos_id"));
                obj.setDisId(rs.getInt("dis_id"));
                obj.setSymId(rs.getInt("sym_id"));
                obj.setSymDisDiscribe(rs.getString("sym_dis_discribe"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public Map<Position, List<SymptomDisease>> getSympDisByDisId(int disId) {
        log.debug("get Symptoms by pos and dis id");

        try {
            Map<Position, List<SymptomDisease>> rst = new HashMap();
            DatabaseManager dbm = new DatabaseManager();
            List<Position> poss = new ArrayList<Position>();
            String sql = "select p.* "
                    + "from position p "
                    + "inner join position_disease pd on p.pos_id=pd.pos_id and pd.pos_dis_flag=1 and pd.dis_id=" + disId;
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                Position obj = new Position();
                obj.setPosId(rs.getInt("pos_id"));
                obj.setPosName(rs.getString("pos_name"));
                obj.setPosDescribe(rs.getString("pos_describe"));
                obj.setPosImagePath(rs.getString("pos_image_path"));
                obj.setLabelId(rs.getInt("label_id"));
                poss.add(obj);
            }

            for (Position pos : poss) {
                List<SymptomDisease> syms = new ArrayList<SymptomDisease>();
                sql = "select s.*, sd.sym_dis_discribe, sd2.sym_disc_name  "
                        + "from symptom s "
                        + "inner join symptom_disease sd on s.sym_id=sd.sym_id and sd.sym_dis_discribe!=0 and sd.pos_id=" + pos.getPosId() + " and sd.dis_id=" + disId + " "
                        + "left join symptom_discribe sd2 on sd.sym_dis_discribe=sd2.sym_disc_id "
                        + "where s.sym_property!=1 "
                        + "union "
                        + "select s.*, sd.sym_dis_discribe, '是' "
                        + "from symptom s "
                        + "inner join symptom_disease sd on s.sym_id=sd.sym_id and sd.sym_dis_discribe!=0 and sd.pos_id=" + pos.getPosId() + " and sd.dis_id=" + disId + " "
                        + "left join symptom_discribe sd2 on sd.sym_dis_discribe=sd2.sym_disc_id "
                        + "where s.sym_property=1";
                rs = dbm.doSelect(sql);
                while (rs.next()) {
                    SymptomDisease obj = new SymptomDisease();
                    obj.setPosId(rs.getInt("pos_id"));
                    obj.setSymId(rs.getInt("sym_id"));
                    obj.setSymName(rs.getString("sym_name"));
                    obj.setSymDisDiscribe(rs.getString("sym_disc_name"));
                    syms.add(obj);
                }
                if (!syms.isEmpty()) {
                    rst.put(pos, syms);
                }
            }
            dbm.close();
            return rst;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List<SymptomDisease> getAssSymDisByPosDisId(int posId, int disId) {
        log.debug("get All Symptom ID");

        try {
            List<SymptomDisease> objs = new ArrayList<SymptomDisease>();
            //String sql = "select * from symptom_disease where pos_id=" + posId + " and dis_id=" + disId + " order by sym_id";
            String sql = "select sd.*, s.sym_name "
                    + "from symptom_disease sd "
                    + "LEFT JOIN symptom s ON s.sym_id = sd.sym_id "
                    + "where sd.pos_id=" + posId + " and sd.dis_id=" + disId + " AND sd.sym_dis_discribe!=0 "
                    + "order by sd.sym_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                SymptomDisease obj = new SymptomDisease();
                obj.setPosId(rs.getInt("pos_id"));
                obj.setDisId(rs.getInt("dis_id"));
                obj.setSymId(rs.getInt("sym_id"));
                obj.setSymName(rs.getString("sym_name"));
                obj.setSymDisDiscribe(rs.getString("sym_dis_discribe"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List<SymptomDisease> getSymDisBySymId(int symId) {
        log.debug("get SymptomDisease by sym ID");

        try {
            List<SymptomDisease> objs = new ArrayList<SymptomDisease>();
            String sql = "SELECT sd.*, pd.pos_dis_image_path, pst.pos_name, sym.sym_name, dis.dis_name "
                    + "FROM symptom_disease sd "
                    + "INNER JOIN disease dis ON sd.dis_id = dis.dis_id "
                    + "INNER JOIN position pst ON sd.pos_id = pst.pos_id "
                    + "INNER JOIN symptom sym ON sd.sym_id = sym.sym_id "
                    + "LEFT JOIN  POSITION_DISEASE pd ON sd.pos_id = pd.pos_id AND sd.dis_id = pd.dis_id "
                    + "WHERE sd.sym_dis_discribe>0 AND sd.sym_id = " + symId
                    + " ORDER BY sd.dis_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                SymptomDisease obj = new SymptomDisease();
                obj.setPosId(rs.getInt("pos_id"));
                obj.setDisId(rs.getInt("dis_id"));
                obj.setSymId(rs.getInt("sym_id"));
                obj.setSymDisDiscribe(rs.getString("sym_dis_discribe"));
                obj.setPosName(rs.getString("pos_name"));
                obj.setSymName(rs.getString("sym_name"));
                obj.setDisName(rs.getString("dis_name"));
                obj.setDisImagePath(rs.getString("pos_dis_image_path"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public void addSymDisBySymId(int posId, int symId) {
        log.debug("add symptom and disease status");

        PosDisDAO posDisDAO = new PosDisDAO();
        List<Integer> diseases = posDisDAO.getDisIdByPosId(posId);

        DatabaseManager dbm = new DatabaseManager();
        for (Integer disease : diseases) {
            String sql = "insert into symptom_disease(pos_id, sym_id, dis_id)values(" + posId + "," + symId + "," + disease + ")";
            dbm.doExecute(sql);
        }
        dbm.close();
    }

    public void deleteSymDisBySymId(int posId, int symId) {
        log.debug("delete symptom and disease status");

        DatabaseManager dbm = new DatabaseManager();
        String sql = "delete from symptom_disease where pos_id=" + posId + " and sym_id=" + symId;
        dbm.doExecute(sql);
        dbm.close();
    }

    public void addSymDisByDisId(int posId, int disId) {
        log.debug("add symptom and disease status");

        SymptomDAO symptomDAO = new SymptomDAO();
        List<Integer> symptoms = symptomDAO.getSymIdByPosId(posId);
        DatabaseManager dbm = new DatabaseManager();
        try {
            String sql = "select * from symptom_disease where pos_id = " + posId + " and dis_id = " + disId;
            ResultSet rs = dbm.doSelect(sql);
            if (!rs.next()) {
                for (Integer symptom : symptoms) {
                    sql = "insert into symptom_disease(pos_id, sym_id, dis_id)values(" + posId + "," + symptom + "," + disId + ")";
                    dbm.doExecute(sql);
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        dbm.close();
    }

    public void addSymDisByPosDisSymId(int posId, int disId, int symId, String symDess[]) {
        log.debug("add symptom and disease status");

        DatabaseManager dbm = new DatabaseManager();
        for (String symDes : symDess) {
            String sql = "insert into symptom_disease(pos_id, sym_id, dis_id, sym_dis_discribe)values(" + posId + "," + symId + "," + disId + "," + symDes + ")";
            dbm.doExecute(sql);
        }
        dbm.close();
    }

    public void deleteSymDisByDisId(int posId, int disId) {
        log.debug("delete symptom and disease status");

        DatabaseManager dbm = new DatabaseManager();
        String sql = "delete from symptom_disease where pos_id=" + posId + " and dis_id=" + disId;
        dbm.doExecute(sql);
        dbm.close();
    }

    public void deleteSymDisByPosDisSymId(int posId, int disId, int symId) {
        log.debug("delete symptom and disease status");

        DatabaseManager dbm = new DatabaseManager();
        String sql = "delete from symptom_disease where pos_id=" + posId + " and dis_id=" + disId + " and sym_id=" + symId;
        dbm.doExecute(sql);
        dbm.close();
    }

    public void addAllSymDis(int labelId) {
        log.debug("add position and disease status");

        PositionDAO positionDAO = new PositionDAO();
        PosDisDAO posDisDAO = new PosDisDAO();
        SymptomDAO symptomDAO = new SymptomDAO();
        List<Integer> positions = positionDAO.getAllPositionIDByLabelId(labelId);

        DatabaseManager dbm = new DatabaseManager();
        for (Integer position : positions) {
            List<Integer> diseases = posDisDAO.getDisIdByPosId(position);
            List<Integer> symptoms = symptomDAO.getSymIdByPosId(position);
            for (Integer symptom : symptoms) {
                for (Integer disease : diseases) {
                    try {
                        String sql = "select * from symptom_disease where pos_id = " + position + " and sym_id = " + symptom + " and dis_id = " + disease;
                        ResultSet rs = dbm.doSelect(sql);
                        if (!rs.next()) {
                            sql = "insert into symptom_disease(pos_id, sym_id, dis_id)values(" + position + "," + symptom + "," + disease + ")";
                            dbm.doExecute(sql);
                        }
                    } catch (SQLException ex) {
                        ex.printStackTrace();
                    }
                }
            }
        }
        dbm.close();
    }

    public void updateSymDisStatus(DatabaseManager dbm, int posId, int symId, Map<Integer, Integer> disChecked, Map<Integer, Integer> disUnchecked) {
        log.debug("update symptom and disease status");

        //DatabaseManager dbm = new DatabaseManager();
        String sql = "update symptom_disease set sym_dis_discribe = ? where pos_id = ? and sym_id = ? and dis_id = ?";
        Set<Integer> disSet = disChecked.keySet();
        Object intDis[] = disSet.toArray();
        for (Object disease : intDis) {
            Object[] objs = {disChecked.get((Integer) disease), posId, symId, disease};
            dbm.doExecute(sql, objs);
        }
        disSet = disUnchecked.keySet();
        intDis = disSet.toArray();
        for (Object disease : intDis) {
            Object[] objs = {disUnchecked.get((Integer) disease), posId, symId, disease};
            dbm.doExecute(sql, objs);
        }
        //dbm.close();
    }
}
