/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.util;

import com.bpps.dao.ArticleDAO;
import com.bpps.dao.FunctionPageDAO;
import com.bpps.dao.LabelDAO;
import com.bpps.dao.PosDisDAO;
import com.bpps.dao.PositionDAO;
import com.bpps.dao.SymptomDAO;
import com.bpps.dao.SymptomDiscribeDAO;
import com.bpps.dao.SymptomImageDAO;
import com.bpps.pojo.Disease;
import com.bpps.pojo.FunctionPage;
import com.bpps.pojo.LabelSystem;
import com.bpps.pojo.Position;
import com.bpps.pojo.Symptom;
import com.bpps.pojo.SymptomDiscribe;
import com.bpps.pojo.SymptomImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author xy
 */
public class GenerateMenus {

    private LabelDAO labelDAO = null;
    private FunctionPageDAO functionPageDAO = null;
    private ArticleDAO articleDAO = null;
    private String selfCheckSubMenu = null;
    private String preventionSubMenu = null;

    public GenerateMenus() {
        labelDAO = new LabelDAO();
        functionPageDAO = new FunctionPageDAO();
        articleDAO = new ArticleDAO();
    }

    /**
     * 生成首页导航菜单，生成规则如下：
     * 1，获取所有激活的一级标签，依次递归循环每个标签，分别生成其对应的子菜单
     * 2，如果一个标签是作物且激活且父标签id等于0，则调用cropsMenu函数单独进行
     *    菜单的生成，满足该规则的仅为“自助诊断和防治决策”两个标签
     * 3，如果一个标签有子标签，则只显示该标签，没有链接，并继续向下循环，直到下
     *    级标签没有子标签位置
     * 4，如果一个标签没有子标签，则这个标签为标签书的最底端，其会对应一个或多个
     *    链接，该链接会链接到“功能页”或“页面”。如果这个子标签有自己的“功能
     *    页”，则直接显示该功能页；如果这个子标签没有有自己的“功能页”，则获取
     *    一级父标签的功能页（通常为文章功能页），并在这里显示，并加上对应的文章ID。
     * @param cssId
     * @param pid 调用时pid的值设为0
     * @return 
     */
    public String generateMenus(String cssId, long pid) {

        List<LabelSystem> labels = null;
        StringBuilder sb = new StringBuilder();
        if (pid == 0) {
            labels = labelDAO.getMenuLabelsOrderByOrder();
            sb.append("<ul id=\"");
            sb.append(cssId);
            sb.append("\">");
        } else {
            labels = labelDAO.getLabelsByPId(pid);
            sb.append("<ul>");
        }
        for (LabelSystem label : labels) {
            //for 自助诊断和防治决策，通过cropsMenu生成作物分类多级菜单
            if ((label.getIscrop() == 1) && (label.getIsactive() == 1) && (label.getPid() == 0)) {
                sb.append("<li><a href=\"");
                sb.append("#\">");
                sb.append(label.getName());
                sb.append("</a>");
                String childStr = cropsMenu(0, label.getLabelId());
                sb.append(childStr);
                sb.append("</li>");
            } else {
                sb.append("<li><a href=\"");
                int articleId = 0;
                if (label.getChildNum() == 0) {//如果没有子菜单，则该菜单应该对应一个或多个URL
                    articleId = articleDAO.getArticleIdByLabelId(label.getLabelId());
                    List<FunctionPage> fps = functionPageDAO.getFunctionPagesByLabelId(label.getLabelId(), false);
                    int urlNum = fps.size();
                    if (urlNum == 0) {
                        fps = functionPageDAO.getFunctionPagesByLabelId(label.getLevel1(), false);
                        urlNum = fps.size();
                    }
                    if (urlNum > 1) {//该菜单应该对应多个URL
                        sb.append("#\">");
                        sb.append(label.getName());
                        sb.append("</a>");
                        sb.append("<ul>");
                        for(FunctionPage fp : fps){
                            String url = fp.getUrl();
                            String name = fp.getName();
                            sb.append("<li><a href=\"");
                            if (label.getIsactive() == 1) {
                                if(url.equals("") || url.equals("#")){
                                    sb.append("#");
                                }else{
                                    sb.append("${pageContext.request.contextPath}/functionPage/");
                                    sb.append(url);
                                    //在这里可以加上条件控制，判断对应功能页是否为文章
                                    if(fp.getIspage()==1){
                                        sb.append("?articleId=");
                                        sb.append(articleId);
                                    } else {
                                        sb.append("?labelId=");
                                        sb.append(label.getLabelId());
                                    }
//                                    if (articleId != 0) {
//                                        sb.append("?articleId=");
//                                        sb.append(articleId);
//                                    } else {
//                                        sb.append("?labelId=");
//                                        sb.append(label.getLabelId());
//                                    }
                                }
                            } else {
                                sb.append("#");
                            }
                            sb.append("\">");
                            sb.append(name);
                            sb.append("</a>");
                            sb.append("</li>");
                        }
                        sb.append("</ul>");
                    } else if (urlNum == 1) {//该菜单应该对应一个URL
                        if (label.getIsactive() == 1) {
                            FunctionPage fp = fps.get(0);
                            Object url = fp.getUrl();
                            sb.append("${pageContext.request.contextPath}/functionPage/");
                            sb.append(url);
                            if (fp.getIspage()==1) {
                                sb.append("?articleId=");
                                sb.append(articleId);
                            } else {
                                sb.append("?labelId=");
                                sb.append(label.getLabelId());
                            }
                            sb.append("\">");
                            sb.append(label.getName());
                            sb.append("</a>");
                        } else {
                            sb.append("#\">");
                            sb.append(label.getName());
                            sb.append("</a>");
                        }
                    } else {
                        sb.append("#\">");
                        sb.append(label.getName());
                        sb.append("</a>");
                    }
                } else {
                    sb.append("#\">");
                    sb.append(label.getName());
                    sb.append("</a>");
                    String childStr = generateMenus(cssId, label.getLabelId());
                    sb.append(childStr);
                }
                sb.append("</li>");
            }
        }
        sb.append("</ul>");
        String menuStr = sb.toString();
        return menuStr;
    }

    //for 自助诊断和防治决策，通过cropsMenu生成作物分类多级菜单
    //生成作物分类下拉标签, labelId为待寄生父菜单ID
    //调用时，pid的值设为0
    public String cropsMenu(long pid, long labelId) {

        List<LabelSystem> labels = null;
        StringBuilder sb = new StringBuilder();
        sb.append("<ul>");
        if (pid == 0) {
            labels = labelDAO.getCropTypes();
        } else {
            labels = labelDAO.getLabelsByPId(pid);
        }

        HashMap<String, String> urls1 = functionPageDAO.getUrlsByLabelId(labelId, true);
        HashMap<String, String> urls2 = functionPageDAO.getUrlsByLabelId(labelId, false);
        for (LabelSystem label : labels) {
            sb.append("<li><a href=\"");
            if (label.getChildNum() == 0) {//如果没有子菜单，则该菜单应该对应一个或多个URL

                sb.append("#\">");
                sb.append(label.getName());
                sb.append("</a>");
                if (label.getIsactive() == 1) {//是否激活
                    sb.append("<ul>");
                    if (label.getName().equals("黄瓜")) {
                        Iterator iter = urls1.entrySet().iterator();
                        while (iter.hasNext()) {
                            Map.Entry entry = (Map.Entry) iter.next();
                            Object url = entry.getKey();
                            Object name = entry.getValue();
                            sb.append("<li><a href=\"");
                            if (url.equals("") || url.equals("#")) {
                                sb.append("#");
                            } else {
                                sb.append("${pageContext.request.contextPath}/functionPage/");
                                sb.append(url);
                                sb.append("?labelId=");
                                sb.append(label.getLabelId());
                            }
                            sb.append("\">");
                            sb.append(name);
                            sb.append("</a>");

                            sb.append("</li>");
                        }
                    } else {
                        Iterator iter = urls2.entrySet().iterator();
                        while (iter.hasNext()) {
                            Map.Entry entry = (Map.Entry) iter.next();
                            Object url = entry.getKey();
                            Object name = entry.getValue();
                            sb.append("<li><a href=\"");
                            if (url.equals("") || url.equals("#")) {
                                sb.append("#");
                            } else {
                                sb.append("${pageContext.request.contextPath}/functionPage/");
                                sb.append(url);
                                sb.append("?labelId=");
                                sb.append(label.getLabelId());
                            }
                            sb.append("\">");
                            sb.append(name);
                            sb.append("</a>");

                            sb.append("</li>");
                        }
                    }
                    sb.append("</ul>");
                }
            } else {
                sb.append("#\">");
                sb.append(label.getName());
                sb.append("</a>");
                String childStr = cropsMenu(label.getLabelId(), labelId);
                sb.append(childStr);
            }
            sb.append("</li>");
        }
        sb.append("</ul>");
        String menuStr = sb.toString();
        return menuStr;

    }

    public String generateMultiLevelSelectBox() {

        StringBuilder sb = new StringBuilder();
        sb.append("<select id=\"level1\" name=\"level1\" onChange=\"setLevel2(this);\">");
        sb.append("<option value=\"0\">无</option>");

        List<LabelSystem> level1 = labelDAO.getLevel1Labels();
        for (LabelSystem label1 : level1) {
            sb.append("<option value=\"");
            sb.append(label1.getLabelId());
            sb.append("\">");
            sb.append(label1.getName());
            sb.append("</option>");
        }
        sb.append("</select><select id=\"level2\" name=\"level2\" onChange=\"setLevel3(this);\"><option value=\"0\">无</option></select>");
        sb.append("<select id=\"level3\" name=\"level3\" onchange=\"changeLevel3(this);\"><option value=\"0\">无</option></select>");
        for (LabelSystem label1 : level1) {
            StringBuilder level1Key = new StringBuilder();
            level1Key.append("key:[");
            StringBuilder level1Value = new StringBuilder();
            level1Value.append("value:[");
            List<LabelSystem> level2 = labelDAO.getLabelsByPId(label1.getLabelId());
            for (LabelSystem label2 : level2) {
                level1Key.append(label2.getLabelId());
                level1Key.append(",");
                level1Value.append("'");
                level1Value.append(label2.getName());
                level1Value.append("',");

                StringBuilder level2Key = new StringBuilder();
                level2Key.append("key:[");
                StringBuilder level2Value = new StringBuilder();
                level2Value.append("value:[");
                List<LabelSystem> level3 = labelDAO.getLabelsByPId(label2.getLabelId());
                for (LabelSystem label3 : level3) {
                    level2Key.append(label3.getLabelId());
                    level2Key.append(",");
                    level2Value.append("'");
                    level2Value.append(label3.getName());
                    level2Value.append("',");
                }
                String level2KeyStr = level2Key.toString();
                String level2ValueStr = level2Value.toString();
                if (!level2KeyStr.equals("key:[")) {
                    level2KeyStr = level2KeyStr.substring(0, level2KeyStr.length() - 1);
                }
                if (!level2ValueStr.equals("value:[")) {
                    level2ValueStr = level2ValueStr.substring(0, level2ValueStr.length() - 1);
                }
                sb.append("<input type=\"hidden\" id=\"label_");
                sb.append(label2.getLabelId());
                sb.append("\" value=\"");
                sb.append("{");
                sb.append(level2KeyStr);
                sb.append("],");
                sb.append(level2ValueStr);
                sb.append("]}");
                sb.append("\"/>");
            }
            String level1KeyStr = level1Key.toString();
            String level1ValueStr = level1Value.toString();
            if (!level1KeyStr.equals("key:[")) {
                level1KeyStr = level1KeyStr.substring(0, level1KeyStr.length() - 1);
            }
            if (!level1ValueStr.equals("value:[")) {
                level1ValueStr = level1ValueStr.substring(0, level1ValueStr.length() - 1);
            }
            sb.append("<input type=\"hidden\" id=\"label_");
            sb.append(label1.getLabelId());
            sb.append("\" value=\"" + "{");
            sb.append(level1KeyStr);
            sb.append("],");
            sb.append(level1ValueStr);
            sb.append("]}\"/>");
        }
        String rstStr = sb.toString();
        return rstStr;
    }

    public void generateHeadJSP(String path) {
        FileOutputStream fos = null;
        try {
            File fp = new File(path);
            fos = new FileOutputStream(fp);
            OutputStreamWriter bos = new OutputStreamWriter(fos, "UTF-8");
            String menuStr = generateMenus("JqueryMenu", 0);
            String head = "<%@ page pageEncoding=\"UTF-8\" %>";
            bos.write(head);
            bos.write(menuStr);
            bos.flush();
            bos.close();
            fos.close();
        } catch (Exception ex) {
            System.out.println("生成" + path + "出错！");
            ex.printStackTrace();
        } finally {
            try {
                fos.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }

    public void generateMultiLevelSelectBoxJSP(String path) {
        FileOutputStream fos = null;
        try {
            File fp = new File(path);
            fos = new FileOutputStream(fp);
            OutputStreamWriter bos = new OutputStreamWriter(fos, "UTF-8");
            String menuStr = generateMultiLevelSelectBox();
            String head = "<%@ page pageEncoding=\"UTF-8\" %>";
            bos.write(head);
            bos.write(menuStr);
            bos.flush();
            bos.close();
            fos.close();
        } catch (Exception ex) {
            System.out.println("生成" + path + "出错！");
            ex.printStackTrace();
        } finally {
            try {
                fos.close();
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
    }

    //生成防治决策下拉标签
    public String preventionMenu() {

        return null;
    }

    public String getSelfCheckSubMenu(long labelId) {

        return null;
    }

    public String generateSymImageJSON(int labelId, String function) {

        StringBuilder sb = new StringBuilder();
        sb.append(function);
        sb.append("({\"photos\":{\"page\":1, \"pages\":5, \"perpage\":100, \"total\":500, \"photo\":[");
        SymptomImageDAO symptomImageDAO = new SymptomImageDAO();
        List<SymptomImage> symptomImages = symptomImageDAO.getSymptomImagesByLabelId(labelId);
        int size = symptomImages.size();
        int i = 0;
        for (SymptomImage symptomImage : symptomImages) {
            i++;
            sb.append("{\"title\":\"");
            sb.append(symptomImage.getPosName());
            sb.append("_");
            sb.append(symptomImage.getSymName());
            sb.append("\", \"url\":\"");
            sb.append(symptomImage.getSiImagePath());
            sb.append("\"}");
            if (i < size) {
                sb.append(",");
            }
        }
        sb.append("]},\"stat\":\"ok\"})");
        String tmp = sb.toString();
        return tmp;
    }

    public String generateDisImageJSON(int labelId, String function) {

        StringBuilder sb = new StringBuilder();
        sb.append(function);
        sb.append("({\"photos\":{\"page\":1, \"pages\":5, \"perpage\":100, \"total\":500, \"photo\":[");
        SymptomImageDAO symptomImageDAO = new SymptomImageDAO();
        List<SymptomImage> symptomImages = symptomImageDAO.getSymptomImagesByLabelId(labelId);
        int size = symptomImages.size();
        int i = 0;
        for (SymptomImage symptomImage : symptomImages) {
            i++;
            sb.append("{\"title\":\"");
            sb.append(symptomImage.getPosName());
            sb.append("_");
            sb.append(symptomImage.getSymName());
            sb.append("\", \"url\":\"");
            sb.append(symptomImage.getSiImagePath());
            sb.append("\"}");
            if (i < size) {
                sb.append(",");
            }
        }
        sb.append("]},\"stat\":\"ok\"})");
        String tmp = sb.toString();
        return tmp;
    }

    public static void main(String[] arg) {
        String path = "E:\\program\\java\\netbeans\\bpps\\build\\web\\WEB-INF\\jspf";
        GenerateMenus gm = new GenerateMenus();
        gm.generatePosDisSymJSP(path);
    }

    public void generatePosDisSymJSP(String path) {

        SymptomDAO symptomDAO = new SymptomDAO();
        PosDisDAO posdisDAO = new PosDisDAO();
        PositionDAO posDAO = new PositionDAO();
        SymptomDiscribeDAO symDesDAO = new SymptomDiscribeDAO();

        List<LabelSystem> level1 = labelDAO.getActiveCrops();
        for (LabelSystem label1 : level1) {
            List<Position> positions = posDAO.getPositions(label1.getLabelId().intValue());
            if (positions == null || positions.isEmpty()) {
                continue;
            }

            FileOutputStream fos = null;
            try {
                StringBuilder sbContent = new StringBuilder();

                sbContent.append("<tr><th>部位：</th><td>");
                sbContent.append("<select id=\"posId\" name=\"posName\" onChange=\"setDisSym(this);\">\n");
                sbContent.append("<option value=\"0\">无</option>\n");

                for (Position pos : positions) {
                    sbContent.append("<option value=\"");
                    sbContent.append(pos.getPosId());
                    sbContent.append("\">");
                    sbContent.append(pos.getPosName());
                    sbContent.append("</option>\n");
                }
                sbContent.append("</select></td></tr>\n");
                sbContent.append("<tr><th>病害名称：</th><td>");
                sbContent.append("<select id=\"disId\" name=\"disName\" onChange=\"setDisSymAttr();\"><option value=\"0\">无</option></select>\n");
                sbContent.append("</td></tr>\n");
                sbContent.append("<tr><th>症状名称：</th><td>");
                sbContent.append("<select id=\"symId\" name=\"symName\" onchange=\"setDisSymAttr();\"><option value=\"0\">无</option></select>\n");

                for (Position pos : positions) {
                    List<Disease> diseases = posdisDAO.getDiseasesByPosId(pos.getPosId());
                    List<Symptom> symptoms = symptomDAO.getSymptomsByPosId(pos.getPosId());
                    //List<Symptom> symptoms = symptomDAO.getMutilAttrSymptomsByPosId(pos.getPosId());

                    //disease
                    StringBuilder posDisKey = new StringBuilder();
                    posDisKey.append("key:[");
                    StringBuilder posDisValue = new StringBuilder();
                    posDisValue.append("value:[");
                    for (Disease diss : diseases) {
                        posDisKey.append(diss.getDisId());
                        posDisKey.append(",");
                        posDisValue.append("'");
                        posDisValue.append(diss.getDisName());
                        posDisValue.append("',");
                    }
                    String posDisKeyStr = posDisKey.toString();
                    String posDisValueStr = posDisValue.toString();
                    if (!posDisKeyStr.equals("key:[")) {
                        posDisKeyStr = posDisKeyStr.substring(0, posDisKeyStr.length() - 1);
                    }
                    if (!posDisValueStr.equals("value:[")) {
                        posDisValueStr = posDisValueStr.substring(0, posDisValueStr.length() - 1);
                    }
                    sbContent.append("<input type=\"hidden\" id=\"pos");
                    sbContent.append(pos.getPosId());
                    sbContent.append("_dis\" value=\"");
                    sbContent.append("{");
                    sbContent.append(posDisKeyStr);
                    sbContent.append("],");
                    sbContent.append(posDisValueStr);
                    sbContent.append("]}");
                    sbContent.append("\"/>");
                    sbContent.append("\n");

                    //Symptom
                    StringBuilder posSymKey = new StringBuilder();
                    posSymKey.append("key:[");
                    StringBuilder posSymValue = new StringBuilder();
                    posSymValue.append("value:[");
                    for (Symptom syms : symptoms) {
                        posSymKey.append(syms.getSymId());
                        posSymKey.append(",");
                        posSymValue.append("'");
                        posSymValue.append(syms.getSymName());
                        posSymValue.append("',");
                    }
                    String posSymKeyStr = posSymKey.toString();
                    String posSymValueStr = posSymValue.toString();
                    if (!posSymKeyStr.equals("key:[")) {
                        posSymKeyStr = posSymKeyStr.substring(0, posSymKeyStr.length() - 1);
                    }
                    if (!posSymValueStr.equals("value:[")) {
                        posSymValueStr = posSymValueStr.substring(0, posSymValueStr.length() - 1);
                    }
                    sbContent.append("<input type=\"hidden\" id=\"pos");
                    sbContent.append(pos.getPosId());
                    sbContent.append("_sym\" value=\"");
                    sbContent.append("{");
                    sbContent.append(posSymKeyStr);
                    sbContent.append("],");
                    sbContent.append(posSymValueStr);
                    sbContent.append("]}");
                    sbContent.append("\"/>");
                    sbContent.append("\n");
                }

                List<Symptom> symptoms = symptomDAO.getAllMutilAttrSymptoms();
                for (Symptom sym : symptoms) {
                    StringBuilder symDesKey = new StringBuilder();
                    symDesKey.append("key:[");
                    StringBuilder symDesValue = new StringBuilder();
                    symDesValue.append("value:[");
                    List<SymptomDiscribe> symDess = symDesDAO.getSymptomDiscribesBySymId(sym.getSymId());
                    for (SymptomDiscribe symDes : symDess) {
                        symDesKey.append(symDes.getSymDiscId());
                        symDesKey.append(",");
                        symDesValue.append("'");
                        symDesValue.append(symDes.getSymDiscName());
                        symDesValue.append("',");
                    }
                    String symDesKeyStr = symDesKey.toString();
                    String symDesValueStr = symDesValue.toString();
                    if (!symDesKeyStr.equals("key:[")) {
                        symDesKeyStr = symDesKeyStr.substring(0, symDesKeyStr.length() - 1);
                    }
                    if (!symDesValueStr.equals("value:[")) {
                        symDesValueStr = symDesValueStr.substring(0, symDesValueStr.length() - 1);
                    }
                    sbContent.append("<input type=\"hidden\" id=\"sym");
                    sbContent.append(sym.getSymId());
                    sbContent.append("\" value=\"");
                    sbContent.append("{");
                    sbContent.append(symDesKeyStr);
                    sbContent.append("],");
                    sbContent.append(symDesValueStr);
                    sbContent.append("]}");
                    sbContent.append("\"/>");
                    sbContent.append("\n");
                }
                sbContent.append("</td></tr>\n");

                String fPath = path + "\\label" + label1.getLabelId() + "_pos_dis_sym.jspf";
                File fp = new File(fPath);
                fos = new FileOutputStream(fp);
                OutputStreamWriter bos = new OutputStreamWriter(fos, "GB2312"); //UTF-8
                String head = "<%@ page language=\"java\" contentType=\"text/html; charset=UTF-8\" pageEncoding=\"UTF-8\"%>\n";
                //bos.write(head);
                bos.write(sbContent.toString());
                bos.flush();
                bos.close();
                fos.close();
            } catch (Exception ex) {
                System.out.println("生成" + path + "出错！");
                ex.printStackTrace();
            } finally {
                try {
                    fos.close();
                } catch (IOException ex) {
                    ex.printStackTrace();
                }
            }
        }
    }
}
