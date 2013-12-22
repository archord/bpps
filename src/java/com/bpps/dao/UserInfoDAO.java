/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.bpps.dao;

import com.bpps.pojo.UserInfo;
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
public class UserInfoDAO {

    private static final Log log = LogFactory.getLog(SymptomDAO.class);

    public List<UserInfo> getAllUsers(){
        log.debug("get All Users");

        try {
            ArrayList<UserInfo> objs = new ArrayList<UserInfo>();
            String sql = "select * from user_info";
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                UserInfo obj = new UserInfo();
                obj.setUserId(rs.getInt("ui_id"));
                obj.setUserName(rs.getString("ui_name"));
                obj.setPassword(rs.getString("ui_password"));
                objs.add(obj);
            }
            dbm.close();
            return objs;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }

    }
    
    public UserInfo getUserById(String userId){
        log.debug("get User by id");

        try {
            UserInfo userInfo = new UserInfo();
            String sql = "select * from user_info where ui_id = " + userId;
            DatabaseManager dbm = new DatabaseManager();
            ResultSet rs = dbm.doSelect(sql);
            while (rs.next()) {
                userInfo.setUserId(rs.getInt("ui_id"));
                userInfo.setUserName(rs.getString("ui_name"));
                userInfo.setPassword(rs.getString("ui_password"));
            }
            dbm.close();
            return userInfo;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }

    }

    public void addUser(UserInfo obj){
        log.debug("add Symptom");

        String sql = "insert into user_info(ui_name, ui_password)values(?,?)";
        DatabaseManager dbm = new DatabaseManager();
        Object[] objs = {obj.getUserName(),obj.getPassword()};
        dbm.doExecute(sql, objs);
        dbm.close();
    }

    public void checkUser(UserInfo obj){
        log.debug("check user");

        try {
            String sql = "select ui_id from user_info where ui_name=? and ui_password=?";
            DatabaseManager dbm = new DatabaseManager();
            Object[] objs = {obj.getUserName(),obj.getPassword()};
            ResultSet rs = dbm.doExecute(sql, objs);
            if (rs!=null && rs.next()) {
                obj.setUserId(rs.getInt("ui_id"));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void deletePosition(int id){
        log.debug("add Position");

        String sql = "delete from user_info where ui_id = "+id;
        DatabaseManager dbm = new DatabaseManager();
        dbm.doExecute(sql);
        dbm.close();
    }

}
