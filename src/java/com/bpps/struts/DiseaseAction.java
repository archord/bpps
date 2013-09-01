/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.struts;

import com.bpps.dao.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.actions.DispatchAction;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;
import com.bpps.pojo.Disease;
import com.bpps.pojo.Position;
import com.bpps.pojo.Symptom;
import com.util.UploadFile;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.apache.catalina.Session;

/**
 *
 * @author Administrator
 */
public class DiseaseAction extends DispatchAction {

    /*
     * forward name="success" path=""
     */
    private final static String SUCCESS = "success";
    private final static String LIST = "list";
    private final static String DETAIL = "detail";
    private final static String UPDATE = "update";
    private final static String SYMSEARCH = "symSearch";
    private final static String SEARCH_RESULT_LIST = "searchResultList";
    private final static String ERROR = "error";

    /**
     * This is the Struts action method called on
     * http://.../actionPath?method=myAction1, where "method" is the value
     * specified in <action> element : ( <action parameter="method" .../> )
     */
    public ActionForward addAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Disease obj = (Disease) form;
        UploadFile uploadFile = new UploadFile();
        String saveUrl = uploadFile.uploadImage(obj.getDisImage(), request, 200, 200);
        System.out.println(saveUrl);
        if (saveUrl == null) {
            saveUrl = "";
        }
        obj.setDisImagePath(saveUrl);

        DiseaseDAO dao = new DiseaseDAO();
        dao.addDisease(obj);
        
        //request.getSession().setAttribute("labelId", obj.getLabelId());
        return mapping.findForward(LIST);
    }

    /**
     * This is the Struts action method called on
     * http://.../actionPath?method=myAction2, where "method" is the value
     * specified in <action> element : ( <action parameter="method" .../> )
     */
    public ActionForward listAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
//        String name =  request.getParameter("disName");
//        request.setAttribute("list", "abd");
        return mapping.findForward(SUCCESS);
    }

    public ActionForward detailAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = DETAIL;
        String strId = request.getParameter("disId");
        ;
        if (!strId.isEmpty()) {
            Integer disId = Integer.parseInt(strId);
            DiseaseDAO dao = new DiseaseDAO();
            Disease disease = dao.getDiseaseById(disId);
            request.setAttribute("detail", disease);
        } else {
            forward = LIST;
        }

        return mapping.findForward(forward);
    }

    public ActionForward updateAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = UPDATE;
        String strId = request.getParameter("disId");
        if (!strId.isEmpty()) {
            Integer disId = Integer.parseInt(strId);
            DiseaseDAO dao = new DiseaseDAO();
            Disease disease = dao.getDiseaseById(disId);
            request.setAttribute("detail", disease);
        } else {
            forward = LIST;
        }

        return mapping.findForward(forward);
    }

    public ActionForward doUpdateAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Disease obj = (Disease) form;
        UploadFile uploadFile = new UploadFile();
        String saveUrl = uploadFile.uploadImage(obj.getDisImage(), request, 200, 200);
        //System.out.println(saveUrl);
        if (saveUrl != null) {
            obj.setDisImagePath(saveUrl);
        }
        if (obj.getDisImagePath() == null || obj.getDisImagePath().equals("")) {
            obj.setDisImagePath("");
        }

        DiseaseDAO dao = new DiseaseDAO();
        dao.updateDisease(obj);
        
        return mapping.findForward(LIST);
    }

    public ActionForward deleteAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = LIST;
        String strId = request.getParameter("disId");
        if (strId != null && !strId.isEmpty()) {
            Integer disId = Integer.parseInt(strId);
            DiseaseDAO dao = new DiseaseDAO();
            dao.deleteDisease(disId);
        }

        return mapping.findForward(forward);
    }

    public ActionForward searchAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = SEARCH_RESULT_LIST;
        String strId = request.getParameter("posId");
        if (strId != null && !strId.isEmpty()) {
            Integer posId = Integer.parseInt(strId);
            PosDisDAO posDisDAO = new PosDisDAO();
            SymptomDAO symptomDAO = new SymptomDAO();
            SymDisDAO symDisDAO = new SymDisDAO();
            List<Symptom> symptoms = symptomDAO.getParSymptomsByPosId(posId);
            List<Disease> diseases = posDisDAO.getDiseasesByPosId(posId);

            List<Disease> rstDiseases = new ArrayList<Disease>();
            List<String> userDisease = new ArrayList<String>();
            for (Symptom symptom : symptoms) {
                String strSyms[] = request.getParameterValues(symptom.getSymId() + "");
                //System.out.print("symptom " + symptom.getSymId() + ":\t");
                if (strSyms != null) {
                    for (String sym : strSyms) {
                        //System.out.print(sym + " ");
                        Integer intSym = Integer.parseInt(sym);
                        if (intSym != 0)//不搜索症状为否的，因为症状为否的在数据库中没有存储
                        {
                            if (symptom.getSymProperty() == 1 && intSym == 1) {
                                //为了避免SymDisDAO的getStrDiscribeByPosDisId方法前注释所描述的问题，在这里做特殊处理，将0编码为1，以方便后面的统一集合操作
                                userDisease.add(symptom.getSymId() + "_" + 0);
                            } else {
                                userDisease.add(symptom.getSymId() + "_" + sym);
                            }
                        }
                    }
                }
                //System.out.println("");
                List<Symptom> childSymptoms = symptomDAO.getChildSymptomsBySymId(symptom.getSymId());
                if (childSymptoms.size() > 0) {
                    for (Symptom childSymptom : childSymptoms) {
                        String strChildSyms[] = request.getParameterValues(childSymptom.getSymId() + "");
                        //System.out.print("\tchildSymptom " + childSymptom.getSymId() + ":\t");
                        if (strChildSyms != null) {
                            for (String sym : strChildSyms) {
                                //System.out.print(sym + " ");
                                Integer intSym = Integer.parseInt(sym);
                                if (childSymptom.getSymProperty() == 1 && intSym == 1) {
                                    userDisease.add(childSymptom.getSymId() + "_" + 0);
                                } else {
                                    userDisease.add(childSymptom.getSymId() + "_" + sym);
                                }
                            }
                        }
                        //System.out.println("");
                    }

                }
                //System.out.println("");
            }

            //System.out.println(userDisease);
            //统一集合操作
            for (Disease disease : diseases) {
                List<String> tDisSym = symDisDAO.getStrDiscribeByPosDisId(posId, disease.getDisId());
                //System.out.println(tDisSym);
                if (tDisSym.containsAll(userDisease)) {
                    rstDiseases.add(disease);
                    //System.out.println(disease.getDisId() + ":" + disease.getDisName());
                }
            }
            //System.out.println(rstDiseases.size());
            request.setAttribute("rstDiseases", rstDiseases);

        } else {
            forward = ERROR;
        }


        return mapping.findForward(forward);
    }

    public ActionForward mutilSearchAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = SYMSEARCH;   //SYMSEARCH  SEARCH_RESULT_LIST

        try{
        HttpSession session = request.getSession();

        String startSymSearch = request.getParameter("startSymSearch");
        if (startSymSearch.equals("1")) {
            String posIds[] = request.getParameterValues("posIds");
            if (posIds != null && posIds.length > 0) {
                int curId = 0;
                session.removeAttribute("posSyms");
                session.removeAttribute("posIds");
                session.removeAttribute("curId");
                HashMap<Integer, List> posSyms = new HashMap<Integer, List>();

                PositionDAO positionDAO = new PositionDAO();
                Position position = positionDAO.getPositionById(Integer.parseInt(posIds[curId]));
                request.setAttribute("detail", position);

                curId++;

                session.setAttribute("posSyms", posSyms);
                session.setAttribute("posIds", posIds);
                session.setAttribute("curId", curId);

                forward = SYMSEARCH;
            }
        } else {
            int flag = 0;//代表该部位是否有症状被选中, 0没有选中症状，1有选中症状
            String strId = request.getParameter("posId");
            if (strId != null && !strId.isEmpty()) {
                Integer posId = Integer.parseInt(strId);
                PosDisDAO posDisDAO = new PosDisDAO();
                SymptomDAO symptomDAO = new SymptomDAO();
                SymDisDAO symDisDAO = new SymDisDAO();
                List<Symptom> symptoms = symptomDAO.getParSymptomsByPosId(posId);
                List<Disease> diseases = posDisDAO.getDiseasesByPosId(posId);

                List<Integer> rstDiseases = new ArrayList<Integer>();
                List<String> userDisease = new ArrayList<String>();
                for (Symptom symptom : symptoms) {
                    String strSyms[] = request.getParameterValues(symptom.getSymId() + "");
                    //System.out.print("symptom " + symptom.getSymId() + ":\t");
                    if (strSyms != null) {
                        flag = 1;
                        for (String sym : strSyms) {
                            //System.out.print(sym + " ");
                            Integer intSym = Integer.parseInt(sym);
                            if (intSym != 0)//不搜索症状为否的，因为症状为否的在数据库中没有存储
                            {
                                if (symptom.getSymProperty() == 1 && intSym == 1) {
                                    //为了避免SymDisDAO的getStrDiscribeByPosDisId方法前注释所描述的问题，在这里做特殊处理，将0编码为1，以方便后面的统一集合操作
                                    userDisease.add(symptom.getSymId() + "_" + 0);
                                } else {
                                    userDisease.add(symptom.getSymId() + "_" + sym);
                                }
                            }
                        }
                    }
                    //System.out.println("");
                    List<Symptom> childSymptoms = symptomDAO.getChildSymptomsBySymId(symptom.getSymId());
                    if (childSymptoms.size() > 0) {
                        for (Symptom childSymptom : childSymptoms) {
                            String strChildSyms[] = request.getParameterValues(childSymptom.getSymId() + "");
                            //System.out.print("\tchildSymptom " + childSymptom.getSymId() + ":\t");
                            if (strChildSyms != null) {
                                flag = 1;
                                for (String sym : strChildSyms) {
                                    //System.out.print(sym + " ");
                                    Integer intSym = Integer.parseInt(sym);
                                    if (childSymptom.getSymProperty() == 1 && intSym == 1) {
                                        userDisease.add(childSymptom.getSymId() + "_" + 0);
                                    } else {
                                        userDisease.add(childSymptom.getSymId() + "_" + sym);
                                    }
                                }
                            }
                            //System.out.println("");
                        }

                    }
                    //System.out.println("");
                }

                //System.out.println(userDisease);
                //统一集合操作
                for (Disease disease : diseases) {
                    List<String> tDisSym = symDisDAO.getStrDiscribeByPosDisId(posId, disease.getDisId());
                    //System.out.println(tDisSym);
                    if (tDisSym.containsAll(userDisease)) {
                        rstDiseases.add(disease.getDisId());
                        //System.out.println(disease.getDisId() + ":" + disease.getDisName());
                    }
                }
                //System.out.println(rstDiseases.size());
                //request.setAttribute("rstDiseases", rstDiseases);

                HashMap<Integer, List> posSyms = (HashMap<Integer, List>) session.getAttribute("posSyms");
                posSyms.remove(posId);
                posSyms.put(posId, rstDiseases);
                session.setAttribute("posSyms", posSyms);

                int curId = (Integer) session.getAttribute("curId");
                String posIds[] = (String[]) session.getAttribute("posIds");
                for (int i = 0; i <= curId; i++) {
                    if (Integer.parseInt(posIds[i]) == posId) {
                        curId = i;
                        curId++;
                        break;
                    }
                }

                if (curId == posIds.length) {
                    forward = SEARCH_RESULT_LIST;
                    List<Integer> mutilRst = posSyms.get(Integer.parseInt(posIds[0]));
                    for (int j = 1; j < posIds.length; j++) {
                        List<Integer> list1 = posSyms.get(Integer.parseInt(posIds[j]));
                        List<Integer> list2 = new ArrayList<Integer>();
                            for (Integer tmp : mutilRst) {
                                if (!list1.contains(tmp)) {
                                    list2.add(tmp);
                                }
                            }
                            mutilRst.removeAll(list2);
                    }

                    List<Disease> mutilRstDisease = new ArrayList<Disease>();
                    DiseaseDAO diseaseDAO = new DiseaseDAO();
                    for (Integer tmp : mutilRst) {
                        Disease disease = diseaseDAO.getDiseaseById(tmp);
                        mutilRstDisease.add(disease);
                    }
                    request.setAttribute("rstDiseases", mutilRstDisease);

                    //session.removeAttribute("posSyms");
                    //session.removeAttribute("posIds");
                    //session.removeAttribute("curId");

                } else {
                    PositionDAO positionDAO = new PositionDAO();
                    Position position = positionDAO.getPositionById(Integer.parseInt(posIds[curId]));
                    request.setAttribute("detail", position);

                    curId++;
                    session.setAttribute("curId", curId);
                    forward = SYMSEARCH;
                }
            } else {
                forward = ERROR;
            }
        }
        }catch(Exception e){
            System.out.println("症状查找病害出错");
            forward = ERROR;
        }
        return mapping.findForward(forward);
    }
}
