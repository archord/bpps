/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.dao;

import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.bpps.pojo.Position;
import com.jdbc.DatabaseManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Administrator
 */
public class PositionDAO {

    private static final Log log = LogFactory.getLog(PositionDAO.class);

    public List<Integer> getAllPositionIDByLabelId(int labelId) {
        log.debug("get All Position ID");

        try {
            List<Integer> objs = new ArrayList<Integer>();
            String sql = "select pos_id from position where label_id = " + labelId;
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

    public List<Position> getPositionsByDisId(int disId) {
        log.debug("get Positions by disid");

        try {
            List<Position> objs = new ArrayList<Position>();
            String sql = "select p.* "
                    + "from position p "
                    + "inner join position_disease pd on p.pos_id=pd.pos_id and pd.pos_dis_flag=1 and pd.dis_id="+disId;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                Position obj = new Position();
                obj.setPosId(rs.getInt("pos_id"));
                obj.setPosName(rs.getString("pos_name"));
                obj.setPosDescribe(rs.getString("pos_describe"));
                obj.setPosImagePath(rs.getString("pos_image_path"));
                obj.setLabelId(rs.getInt("label_id"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List<Position> getPositions(int labelId) {
        log.debug("get All Position");

        try {
            List<Position> objs = new ArrayList<Position>();
            String sql = "select * from position where label_id = " + labelId + " order by pos_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                Position obj = new Position();
                obj.setPosId(rs.getInt("pos_id"));
                obj.setPosName(rs.getString("pos_name"));
                obj.setPosDescribe(rs.getString("pos_describe"));
                obj.setPosImagePath(rs.getString("pos_image_path"));
                obj.setLabelId(rs.getInt("label_id"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public Position getPositionById(int id) {
        log.debug("get Position by ID");

        try {
            Position obj = new Position();
            String sql = "select * from position where pos_id = " + id;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            if (rs.next()) {
                obj.setPosId(rs.getInt("pos_id"));
                obj.setPosName(rs.getString("pos_name"));
                obj.setPosDescribe(rs.getString("pos_describe"));
                obj.setPosImagePath(rs.getString("pos_image_path"));
                obj.setLabelId(rs.getInt("label_id"));
            }
            dbm.close();
            return obj;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public void addPosition(Position obj) {
        log.debug("add Position");

        String sql = "insert into position(pos_name, pos_describe, pos_image_path, label_id)values(?,?,?,?)";
        DatabaseManager dbm = new DatabaseManager();
        Object[] objs = {obj.getPosName(), obj.getPosDescribe(), obj.getPosImagePath(), obj.getLabelId()};
        dbm.doExecute(sql, objs);
        dbm.close();

        int maxId = getMaxPosId();
        PosDisDAO posdisDAO = new PosDisDAO();
        posdisDAO.addPosDisByPosId(maxId, obj.getLabelId());
    }

    public void updatePosition(Position obj) {
        log.debug("add Position");

        String sql = "update position set pos_name = ?, pos_describe = ?, pos_image_path=? where pos_id = ?";
        DatabaseManager dbm = new DatabaseManager();
        Object[] objs = {obj.getPosName(), obj.getPosDescribe(), obj.getPosImagePath(), obj.getPosId()};
        dbm.doExecute(sql, objs);
        dbm.close();
    }

    public void deletePosition(int id) {
        log.debug("add Position");

        String sql = "delete from position where pos_id = " + id;
        DatabaseManager dbm = new DatabaseManager();
        dbm.doExecute(sql);
        dbm.close();

        PosDisDAO posdisDAO = new PosDisDAO();
        posdisDAO.deletePosDisByPosId(id);
    }

    public int getMaxPosId() {
        log.debug("get max Posid");

        try {
            int posId = 0;
            String sql = "select max(pos_id) from position";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            if (rs.next()) {
                posId = rs.getInt(1);
            }
            dbm.close();
            return posId;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return 0;
        }
    }

    public int getTotalByLabelId(int labelId) {

        log.debug("get total position");

        try {
            int disId = 0;
            String sql = "select count(*) from position where label_id=" + labelId;
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
