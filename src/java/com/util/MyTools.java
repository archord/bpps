/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.Reader;
import java.sql.SQLException;
import oracle.sql.CLOB;

/**
 *
 * @author Administrator
 */
public class MyTools {

    public static String ClobToString(CLOB clob) throws SQLException, IOException {
        String reString = "";
        if (clob != null) {
            Reader is = clob.getCharacterStream();// 得到流
            BufferedReader br = new BufferedReader(is);
            String s = br.readLine();
            StringBuffer sb = new StringBuffer();
            // 执行循环将字符串全部取出付值给StringBuffer由StringBuffer转成STRING
            while (s != null) {
                sb.append(s);
                s = br.readLine();
            }
            reString = sb.toString();
        }
        return reString;
    }

    public static String splitAndFilterString(String input, int length) {
        if (input == null || input.trim().equals("")) {
            return "";
        } // 去掉所有html元素, 
        String str = input.replaceAll("\\&[a-zA-Z]{1,10};", "").replaceAll("<[^>]*>", "");
        str = str.replaceAll("[(/>)<]", "");
        int len = str.length();
        if (len <= length) {
            return str;
        } else {
            str = str.substring(0, length);
            str += "...";
        }
        return str;
    }
}
