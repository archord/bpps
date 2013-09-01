/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.dao;

import com.bpps.pojo.Disease;
import com.bpps.pojo.Position;
import com.bpps.pojo.PositionDisease;
import com.jdbc.DatabaseManager;
import com.util.MyTools;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import oracle.sql.CLOB;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 *
 * @author Administrator
 */
public class PosDisDAO {

    private static final Log log = LogFactory.getLog(DiseaseDAO.class);

    public List<Integer> getPosIdByDisId(int disId) {
        log.debug("get posid by disid");

        try {
            List<Integer> objs = new ArrayList<Integer>();
            String sql = "select pos_id from position_disease where pos_dis_flag = 1 and dis_id=" + disId;
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

    public List<Integer> getDisIdByPosId(int posId) {
        log.debug("get posid by disid");

        try {
            List<Integer> objs = new ArrayList<Integer>();
            String sql = "select dis_id from position_disease where pos_dis_flag = 1 and pos_id=" + posId;
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

    public List<Disease> getDiseasesByPosId(int posId) {
        log.debug("get All Disease from position_disease");

        try {
            List<Disease> objs = new ArrayList<Disease>();
            String sql = "select dis.dis_id, dis.dis_name, dis.dis_image_path from disease dis, position_disease posdis where posdis.pos_dis_flag = 1 and dis.dis_id=posdis.dis_id and posdis.pos_id=" + posId + " order by dis_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                Disease obj = new Disease();
                obj.setDisId(rs.getInt("dis_id"));
                obj.setDisName(rs.getString("dis_name"));
                obj.setDisImagePath(rs.getString("dis_image_path"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (Exception ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public void addPosDisByPosId(int posId, int labelId) {
        log.debug("add position and disease by posid");

        DiseaseDAO diseaseDAO = new DiseaseDAO();
        List<Integer> diseases = diseaseDAO.getAllDiseaseIDByLabelId(labelId);

        DatabaseManager dbm = new DatabaseManager();
        for (Integer disease : diseases) {
            String sql = sql = "insert into position_disease(pos_id, dis_id, pos_dis_flag)values(" + posId + "," + disease + ", 0)";
            dbm.doExecute(sql);
        }
        dbm.close();
    }

    public void deletePosDisByPosId(int posId) {
        log.debug("delete position and disease status");

        List<Integer> disId = getDisIdByPosId(posId);

        DatabaseManager dbm = new DatabaseManager();
        String sql = "delete from position_disease where pos_id=" + posId;
        dbm.doExecute(sql);
        dbm.close();

        SymDisDAO symDisDAO = new SymDisDAO();
        for (Integer disease : disId) {
            symDisDAO.deleteSymDisByDisId(posId, disease);
        }
    }

    public void addPosDisByDisId(int disId, int labelId) {
        log.debug("add position and disease by disid");

        PositionDAO positionDAO = new PositionDAO();
        List<Integer> positions = positionDAO.getAllPositionIDByLabelId(labelId);

        DatabaseManager dbm = new DatabaseManager();
        for (Integer position : positions) {
            String sql = sql = "insert into position_disease(pos_id, dis_id, pos_dis_flag)values(" + position + "," + disId + ", 0)";
            dbm.doExecute(sql);
        }
        dbm.close();
    }

    public void deletePosDisByDisId(int disId) {
        log.debug("delete position and disease by disid");

        List<Integer> posIds = getPosIdByDisId(disId);

        DatabaseManager dbm = new DatabaseManager();
        String sql = "delete from position_disease where dis_id=" + disId;
        dbm.doExecute(sql);
        dbm.close();

        SymDisDAO symDisDAO = new SymDisDAO();
        for (Integer position : posIds) {
            symDisDAO.deleteSymDisByDisId(position, disId);
        }
    }

    public void addAllPosDis(int labelId) {
        log.debug("add all position and disease");

        DiseaseDAO diseaseDAO = new DiseaseDAO();
        List<Integer> diseases = diseaseDAO.getAllDiseaseIDByLabelId(labelId);
        PositionDAO positionDAO = new PositionDAO();
        List<Integer> positions = positionDAO.getAllPositionIDByLabelId(labelId);

        DatabaseManager dbm = new DatabaseManager();
        for (Integer position : positions) {
            for (Integer disease : diseases) {
                try {
                    String sql = "select * from position_disease where pos_id = " + position + " and dis_id = " + disease;
                    ResultSet rs = dbm.doSelect(sql);
                    if (!rs.next()) {
                        sql = "insert into position_disease(pos_id, dis_id, pos_dis_flag)values(" + position + "," + disease + ", 0)";
                        dbm.doExecute(sql);
                    }
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        }
        dbm.close();
    }

    public void updatePosDisStatus(DatabaseManager dbm, int posId, List<Integer> disChecked, List<Integer> disUnchecked) {
        log.debug("update position and disease status");

        SymDisDAO symDisDAO = new SymDisDAO();
        //DatabaseManager dbm = new DatabaseManager();
        String sql = "update position_disease set pos_dis_flag = ? where dis_id = ? and pos_id = " + posId;
        for (Integer disease : disChecked) {
            Object[] objs = {1, disease};
            dbm.doExecute(sql, objs);
            //add
            symDisDAO.addSymDisByDisId(posId, disease);
        }
        for (Integer disease : disUnchecked) {
            Object[] objs = {0, disease};
            dbm.doExecute(sql, objs);
            //delete
            symDisDAO.deleteSymDisByDisId(posId, disease);
        }
        //dbm.close();
    }

    public void updatePosDisImagePath(PositionDisease obj) {
        log.debug("update position and disease image path");

        DatabaseManager dbm = new DatabaseManager();
        String sql = "update position_disease set pos_dis_image_path = ? where dis_id = ? and pos_id = ?";
        Object[] objs = {obj.getPosDisImagePath(), obj.getDisId(), obj.getPosId()};
        dbm.doExecute(sql, objs);
    }
}
