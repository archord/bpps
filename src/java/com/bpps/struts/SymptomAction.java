/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.bpps.struts;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;
import com.bpps.dao.SymptomDAO;
import com.bpps.pojo.Symptom;
import com.bpps.pojo.Symptom2;

/**
 *
 * @author Administrator
 */
public class SymptomAction extends DispatchAction {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private final static String LIST = "list";
    private final static String DETAIL = "detail";
    private final static String UPDATE = "update";

    /**
     * This is the Struts action method called on
     * http://.../actionPath?method=myAction1,
     * where "method" is the value specified in <action> element :
     * ( <action parameter="method" .../> )
     */
    public ActionForward addAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Symptom obj = (Symptom)form;
        SymptomDAO dao= new SymptomDAO();
        dao.addSymptom(obj);
        return mapping.findForward(LIST);
    }

    /**
     * This is the Struts action method called on
     * http://.../actionPath?method=myAction2,
     * where "method" is the value specified in <action> element :
     * ( <action parameter="method" .../> )
     */
    public ActionForward listAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String posId =  request.getParameter("posId");
        int intPosId = 0;
        if(posId!=null && !posId.isEmpty()){
            intPosId = Integer.parseInt(posId);
        }
        request.setAttribute("posId", intPosId);
        return mapping.findForward(SUCCESS);
    }

    public ActionForward detailAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = DETAIL;
        String strId = request.getParameter("symId");;
        if(!strId.isEmpty()){
            Integer disId = Integer.parseInt(strId);
            SymptomDAO dao= new SymptomDAO();
            Symptom Symptom = dao.getSymptomById(disId);
            request.setAttribute("detail", Symptom);
        }else{
            forward = LIST;
        }

        return mapping.findForward(forward);
    }

    public ActionForward updateAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = UPDATE;
        String strId = request.getParameter("symId");
        if(!strId.isEmpty()){
            Integer disId = Integer.parseInt(strId);
            SymptomDAO dao= new SymptomDAO();
            Symptom2 symptom = dao.getSymptom2ById(disId);
            request.setAttribute("detail", symptom);
        }else{
            forward = LIST;
        }

        return mapping.findForward(forward);
    }

    public ActionForward doUpdateAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Symptom obj = (Symptom)form;
        SymptomDAO dao= new SymptomDAO();
        dao.updateSymptom(obj);
        return mapping.findForward(LIST);
    }

    public ActionForward deleteAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = LIST;
        String strId = request.getParameter("symId");
        if(!strId.isEmpty()){
            Integer disId = Integer.parseInt(strId);
            SymptomDAO dao= new SymptomDAO();
            dao.deleteSymptom(disId);
        }

        return mapping.findForward(forward);
    }
}
