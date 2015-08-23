/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.bpps.struts;

import com.bpps.dao.PosDisDAO;
import com.bpps.dao.SymDisDAO;
import com.bpps.dao.SymptomDAO;
import com.bpps.pojo.Symptom;
import com.jdbc.DatabaseManager;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

/**
 *
 * @author Administrator
 */
public class SymDisAction extends org.apache.struts.action.Action {
    
    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    
    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String strPosId = request.getParameter("posId");
        int posId = 0;
        if (strPosId != null && !strPosId.isEmpty()) {
            posId = Integer.parseInt(strPosId);
            request.setAttribute("posid", posId);
        }

        DatabaseManager dbm = new DatabaseManager();
        SymptomDAO symptomDAO = new SymptomDAO();
        PosDisDAO posDisDAO = new PosDisDAO();
        SymDisDAO symDisDAO = new SymDisDAO();
        List<Symptom> symptoms = symptomDAO.getSymptomsByPosId(posId);
        List<Integer> disIds = posDisDAO.getDisIdByPosId(posId);
        for (Symptom symptom : symptoms) {
            Map<Integer, Integer> disChecked = new HashMap<Integer, Integer>();
            Map<Integer, Integer> disUnchecked = new HashMap<Integer, Integer>();
            if(symptom.getSymProperty()==1){
                //System.out.print("checkbox symptom="+symptom.getSymId()+": ");
                //System.out.println("");
                String strDis[] = request.getParameterValues(symptom.getSymId()+"");
                if (strDis != null) {
                    //System.out.print("\tchecked:   ");
                    for (String dis : strDis) {
                        //System.out.print(dis + " ");
                        Integer intDis = Integer.parseInt(dis);
                        disChecked.put(intDis, 1);
                    }
                }
                //System.out.println("");
                //System.out.print("\tunchecked: ");
                for (Integer dis : disIds) {
                    if (!disChecked.containsKey(dis)) {
                        //System.out.print(dis + " ");
                        disUnchecked.put(dis, 0);
                    }
                }
                //System.out.println("");
            }else{
                //System.out.print("input symptom="+symptom.getSymId()+": ");
                for (Integer disId : disIds) {
                    String parName = symptom.getSymId() + "_" + disId;
                    String strDis = request.getParameter(parName);
                    if(strDis==null)
                        strDis = "0";
                    //System.out.print(parName+"=");
                    //System.out.print(strDis+", ");
                    Integer intDis = Integer.parseInt(strDis);
                    disChecked.put(disId, intDis);
                }
                //System.out.println("");
            }
            symDisDAO.updateSymDisStatus(dbm, posId, symptom.getSymId(), disChecked, disUnchecked);
        }
        dbm.close();
        
        return mapping.findForward(SUCCESS);
    }
}
