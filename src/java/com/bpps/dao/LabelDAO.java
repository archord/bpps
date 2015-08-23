/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.dao;

import com.bpps.pojo.LabelSystem;
import java.util.List;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import com.jdbc.DatabaseManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 *
 * @author Administrator
 * 1，获取导航标签列表，pid为0，且active为1
 * 2，根据id获取子标签列表
 * 3，增加标签
 * 4，删除标签
 * 5，标签列表
 */
public class LabelDAO {

    private static final Log log = LogFactory.getLog(LabelDAO.class);

    public List<LabelSystem> getLevel1Labels() {
        log.debug("get all level 1 label!");

        try {
            List<LabelSystem> objs = new ArrayList<LabelSystem>();
            String sql = "select ls1.*, ls2.name pname, fp.name pageName "
                    + "from label_system ls1 "
                    + "LEFT JOIN label_system ls2 ON ls2.label_id = ls1.pid "
                    + "LEFT JOIN Function_Page fp ON fp.page_id = ls1.pageid "
                    + "WHERE ls1.pid = 0 "
                    + "ORDER BY ls1.label_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                LabelSystem obj = new LabelSystem();
                obj.setIsactive(rs.getShort("isactive"));
                obj.setIscrop(rs.getShort("iscrop"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setName(rs.getString("name"));
                obj.setPageid(rs.getLong("pageid"));
                obj.setPid(rs.getLong("pid"));
                obj.setUrl(rs.getString("url"));
                obj.setPageName(rs.getString("pageName"));
                obj.setpName(rs.getString("pname"));
                obj.setLevel1(rs.getLong("level1"));
                obj.setLevel2(rs.getLong("level2"));
                obj.setLevel3(rs.getLong("level3"));
                obj.setChildNum(rs.getInt("child_num"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<LabelSystem> getLabelsForFunctionPage() {
        log.debug("get all level 1 label!");

        try {
            List<LabelSystem> objs = new ArrayList<LabelSystem>();
            String sql = "select ls1.*, ls2.name pname, fp.name pageName "
                    + "from label_system ls1 "
                    + "LEFT JOIN label_system ls2 ON ls2.label_id = ls1.pid "
                    + "LEFT JOIN Function_Page fp ON fp.page_id = ls1.pageid "
                    + "WHERE ls1.pid = 0 or (ls1.iscrop != 1 and  ls1.label_id !=0)"
                    + "ORDER BY ls1.label_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                LabelSystem obj = new LabelSystem();
                obj.setIsactive(rs.getShort("isactive"));
                obj.setIscrop(rs.getShort("iscrop"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setName(rs.getString("name"));
                obj.setPageid(rs.getLong("pageid"));
                obj.setPid(rs.getLong("pid"));
                obj.setUrl(rs.getString("url"));
                obj.setPageName(rs.getString("pageName"));
                obj.setpName(rs.getString("pname"));
                obj.setLevel1(rs.getLong("level1"));
                obj.setLevel2(rs.getLong("level2"));
                obj.setLevel3(rs.getLong("level3"));
                obj.setChildNum(rs.getInt("child_num"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<LabelSystem> getMenuLabels() {
        log.debug("get all level 1 menu label!");

        try {
            List<LabelSystem> objs = new ArrayList<LabelSystem>();
            String sql = "select ls1.*, ls2.name pname, fp.name pageName "
                    + "from label_system ls1 "
                    + "LEFT JOIN label_system ls2 ON ls2.label_id = ls1.pid "
                    + "LEFT JOIN Function_Page fp ON fp.page_id = ls1.pageid "
                    + "WHERE ls1.pid = 0 and ls1.isactive=1"
                    + "ORDER BY ls1.label_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                LabelSystem obj = new LabelSystem();
                obj.setIsactive(rs.getShort("isactive"));
                obj.setIscrop(rs.getShort("iscrop"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setName(rs.getString("name"));
                obj.setPageid(rs.getLong("pageid"));
                obj.setPid(rs.getLong("pid"));
                obj.setUrl(rs.getString("url"));
                obj.setPageName(rs.getString("pageName"));
                obj.setpName(rs.getString("pname"));
                obj.setLevel1(rs.getLong("level1"));
                obj.setLevel2(rs.getLong("level2"));
                obj.setLevel3(rs.getLong("level3"));
                obj.setChildNum(rs.getInt("child_num"));
                obj.setMenuOrder(rs.getInt("menu_order"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<LabelSystem> getMenuLabelsOrderByOrder() {
        log.debug("get all level 1 menu label!");

        try {
            List<LabelSystem> objs = new ArrayList<LabelSystem>();
            String sql = "select ls1.*, ls2.name pname, fp.name pageName "
                    + "from label_system ls1 "
                    + "LEFT JOIN label_system ls2 ON ls2.label_id = ls1.pid "
                    + "LEFT JOIN Function_Page fp ON fp.page_id = ls1.pageid "
                    + "WHERE ls1.pid = 0 and ls1.isactive=1"
                    + "ORDER BY ls1.menu_order";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                LabelSystem obj = new LabelSystem();
                obj.setIsactive(rs.getShort("isactive"));
                obj.setIscrop(rs.getShort("iscrop"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setName(rs.getString("name"));
                obj.setPageid(rs.getLong("pageid"));
                obj.setPid(rs.getLong("pid"));
                obj.setUrl(rs.getString("url"));
                obj.setPageName(rs.getString("pageName"));
                obj.setpName(rs.getString("pname"));
                obj.setLevel1(rs.getLong("level1"));
                obj.setLevel2(rs.getLong("level2"));
                obj.setLevel3(rs.getLong("level3"));
                obj.setChildNum(rs.getInt("child_num"));
                obj.setMenuOrder(rs.getInt("menu_order"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }
    
    //作物分类，label_id=0 and isActive=0 and iscrop=1
    public List<LabelSystem> getCropType() {
        log.debug("get all level 1 menu label!");

        try {
            List<LabelSystem> objs = new ArrayList<LabelSystem>();
            String sql = "select ls1.*, ls2.name pname, fp.name pageName "
                    + "from label_system ls1 "
                    + "LEFT JOIN label_system ls2 ON ls2.label_id = ls1.pid "
                    + "LEFT JOIN Function_Page fp ON fp.page_id = ls1.pageid "
                    + "WHERE ls1.pid = 0 and ls1.isactive=0 and ls1.iscrop=1"
                    + "ORDER BY ls1.label_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                LabelSystem obj = new LabelSystem();
                obj.setIsactive(rs.getShort("isactive"));
                obj.setIscrop(rs.getShort("iscrop"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setName(rs.getString("name"));
                obj.setPageid(rs.getLong("pageid"));
                obj.setPid(rs.getLong("pid"));
                obj.setUrl(rs.getString("url"));
                obj.setPageName(rs.getString("pageName"));
                obj.setpName(rs.getString("pname"));
                obj.setLevel1(rs.getLong("level1"));
                obj.setLevel2(rs.getLong("level2"));
                obj.setLevel3(rs.getLong("level3"));
                obj.setChildNum(rs.getInt("child_num"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<LabelSystem> getActiveCrops() {
        log.debug("get crop types!");

        try {
            List<LabelSystem> objs = new ArrayList<LabelSystem>();
            String sql = "select ls1.*, ls2.name pname, fp.name pageName "
                    + "from label_system ls1 "
                    + "LEFT JOIN label_system ls2 ON ls2.label_id = ls1.pid "
                    + "LEFT JOIN Function_Page fp ON fp.page_id = ls1.pageid "
                    + "WHERE ls1.pid != 0 and ls1.iscrop=1 and ls1.isactive=1"
                    + "ORDER BY ls1.label_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                LabelSystem obj = new LabelSystem();
                obj.setIsactive(rs.getShort("isactive"));
                obj.setIscrop(rs.getShort("iscrop"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setName(rs.getString("name"));
                obj.setPageid(rs.getLong("pageid"));
                obj.setPid(rs.getLong("pid"));
                obj.setUrl(rs.getString("url"));
                obj.setPageName(rs.getString("pageName"));
                obj.setpName(rs.getString("pname"));
                obj.setLevel1(rs.getLong("level1"));
                obj.setLevel2(rs.getLong("level2"));
                obj.setLevel3(rs.getLong("level3"));
                obj.setChildNum(rs.getInt("child_num"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<LabelSystem> getAllCrops() {
        log.debug("get crop types!");

        try {
            List<LabelSystem> objs = new ArrayList<LabelSystem>();
            String sql = "select ls1.*, ls2.name pname, fp.name pageName "
                    + "from label_system ls1 "
                    + "LEFT JOIN label_system ls2 ON ls2.label_id = ls1.pid "
                    + "LEFT JOIN Function_Page fp ON fp.page_id = ls1.pageid "
                    + "WHERE ls1.pid != 0 and ls1.iscrop=1"
                    + "ORDER BY ls1.label_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                LabelSystem obj = new LabelSystem();
                obj.setIsactive(rs.getShort("isactive"));
                obj.setIscrop(rs.getShort("iscrop"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setName(rs.getString("name"));
                obj.setPageid(rs.getLong("pageid"));
                obj.setPid(rs.getLong("pid"));
                obj.setUrl(rs.getString("url"));
                obj.setPageName(rs.getString("pageName"));
                obj.setpName(rs.getString("pname"));
                obj.setLevel1(rs.getLong("level1"));
                obj.setLevel2(rs.getLong("level2"));
                obj.setLevel3(rs.getLong("level3"));
                obj.setChildNum(rs.getInt("child_num"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }
    
    public List<LabelSystem> getCropTypes() {
        log.debug("get crop types!");

        try {
            List<LabelSystem> objs = new ArrayList<LabelSystem>();
            String sql = "select ls1.*, ls2.name pname, fp.name pageName "
                    + "from label_system ls1 "
                    + "LEFT JOIN label_system ls2 ON ls2.label_id = ls1.pid "
                    + "LEFT JOIN Function_Page fp ON fp.page_id = ls1.pageid "
                    + "WHERE ls1.pid = 0 and ls1.iscrop=1 and ls1.isactive=0"
                    + "ORDER BY ls1.label_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                LabelSystem obj = new LabelSystem();
                obj.setIsactive(rs.getShort("isactive"));
                obj.setIscrop(rs.getShort("iscrop"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setName(rs.getString("name"));
                obj.setPageid(rs.getLong("pageid"));
                obj.setPid(rs.getLong("pid"));
                obj.setUrl(rs.getString("url"));
                obj.setPageName(rs.getString("pageName"));
                obj.setpName(rs.getString("pname"));
                obj.setLevel1(rs.getLong("level1"));
                obj.setLevel2(rs.getLong("level2"));
                obj.setLevel3(rs.getLong("level3"));
                obj.setChildNum(rs.getInt("child_num"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List<LabelSystem> getAllLabels() {
        log.debug("get LabelSystems by pid");

        try {
            List<LabelSystem> objs = new ArrayList<LabelSystem>();
            String sql = "select ls1.*, ls2.name pname, fp.name pageName "
                    + "from label_system ls1 "
                    + "LEFT JOIN label_system ls2 ON ls2.label_id = ls1.pid "
                    + "LEFT JOIN Function_Page fp ON fp.page_id = ls1.pageid "
                    + "order by ls1.label_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                LabelSystem obj = new LabelSystem();
                obj.setIsactive(rs.getShort("isactive"));
                obj.setIscrop(rs.getShort("iscrop"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setName(rs.getString("name"));
                obj.setPageid(rs.getLong("pageid"));
                obj.setPid(rs.getLong("pid"));
                obj.setUrl(rs.getString("url"));
                obj.setPageName(rs.getString("pageName"));
                obj.setpName(rs.getString("pname"));
                obj.setLevel1(rs.getLong("level1"));
                obj.setLevel2(rs.getLong("level2"));
                obj.setLevel3(rs.getLong("level3"));
                obj.setChildNum(rs.getInt("child_num"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public List<LabelSystem> getLabelsByPId(long pId) {
        log.debug("get LabelSystems by pid");

        try {
            List<LabelSystem> objs = new ArrayList<LabelSystem>();
            String sql = "select ls1.*, ls2.name pname, fp.name pageName "
                    + "from label_system ls1 "
                    + "LEFT JOIN label_system ls2 ON ls2.label_id = ls1.pid "
                    + "LEFT JOIN Function_Page fp ON fp.page_id = ls1.pageid "
                    + "WHERE ls1.pid = " + pId + " "
                    + "ORDER BY ls1.label_id";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                LabelSystem obj = new LabelSystem();
                obj.setIsactive(rs.getShort("isactive"));
                obj.setIscrop(rs.getShort("iscrop"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setName(rs.getString("name"));
                obj.setPageid(rs.getLong("pageid"));
                obj.setPid(rs.getLong("pid"));
                obj.setUrl(rs.getString("url"));
                obj.setPageName(rs.getString("pageName"));
                obj.setpName(rs.getString("pname"));
                obj.setLevel1(rs.getLong("level1"));
                obj.setLevel2(rs.getLong("level2"));
                obj.setLevel3(rs.getLong("level3"));
                obj.setChildNum(rs.getInt("child_num"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    public LabelSystem getLabelById(long labelId) {
        log.debug("get LabelSystem by id");

        try {
            LabelSystem obj = new LabelSystem();
            String sql = "select ls1.*, ls2.name pname, fp.name pageName "
                    + "from label_system ls1 "
                    + "LEFT JOIN label_system ls2 ON ls2.label_id = ls1.pid "
                    + "LEFT JOIN Function_Page fp ON fp.page_id = ls1.pageid "
                    + "WHERE ls1.label_id = " + labelId;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                obj.setIsactive(rs.getShort("isactive"));
                obj.setIscrop(rs.getShort("iscrop"));
                obj.setLabelId(rs.getLong("label_id"));
                obj.setName(rs.getString("name"));
                obj.setPageid(rs.getLong("pageid"));
                obj.setPid(rs.getLong("pid"));
                obj.setUrl(rs.getString("url"));
                obj.setPageName(rs.getString("pageName"));
                obj.setpName(rs.getString("pname"));
                obj.setLevel1(rs.getLong("level1"));
                obj.setLevel2(rs.getLong("level2"));
                obj.setLevel3(rs.getLong("level3"));
                obj.setChildNum(rs.getInt("child_num"));
            }
            dbm.close();
            return obj;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }
    
    public void addLabelSystem(LabelSystem obj) {
        log.debug("add LabelSystem");

        String sql = "insert into label_system(pid, name, isactive, iscrop, level1, level2, level3)values(?,?,?,?,?,?,?)";
        DatabaseManager dbm = new DatabaseManager();
        Object[] objs = {obj.getPid(), obj.getName(), 
            obj.getIsactive(), obj.getIscrop(), obj.getLevel1(), obj.getLevel2(), obj.getLevel3()};
        dbm.doExecute(sql, objs);
        dbm.close();
        
        updateAllChildNum();
    }

    public void updateLabelSystem(LabelSystem obj) {
        log.debug("update LabelSystem");

        String sql = "update label_system set pid = ?, name = ?, isactive=?, iscrop=?, "
                + "level1=?, level2=?, level3=? where label_id = ?";
        DatabaseManager dbm = new DatabaseManager();
        Object[] objs = {obj.getPid(), obj.getName(), obj.getIsactive(), obj.getIscrop(), 
            obj.getLevel1(), obj.getLevel2(), obj.getLevel3(), obj.getLabelId()};
        dbm.doExecute(sql, objs);
        dbm.close();
    }

    public void deleteLabelSystem(int id) {
        log.debug("delete LabelSystem");

        String sql = "delete from label_system where label_id = "+id;
        DatabaseManager dbm = new DatabaseManager();
        dbm.doExecute(sql);
        dbm.close();
        
        updateAllChildNum();
    }

    public int getTotalLabels(){

        log.debug("get total label");

        try {
            int disId = 0;
            String sql = "select count(*) from label_system";
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
    
    public void updateAllChildNum() {
        log.debug("update child number");

        String sql = "UPDATE label_system ls1 SET child_num = (SELECT COUNT(*) FROM label_system ls2 WHERE ls2.pid=ls1.label_id)";
        DatabaseManager dbm = new DatabaseManager();
        dbm.doExecute(sql);
        dbm.close();
    }

    public void updateLabelOrder(long id, int order) {
        log.debug("update Label order");

        String sql = "update label_system set menu_order = ? where label_id = ?";
        DatabaseManager dbm = new DatabaseManager();
        Object[] objs = {order, id};
        dbm.doExecute(sql, objs);
        dbm.close();
    }
    
}