/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.bpps.struts;

import com.bpps.dao.SymptomDiscribeDAO;
import com.bpps.pojo.SymptomDiscribe;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.actions.DispatchAction;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

/**
 *
 * @author Administrator
 */
public class SymptomDiscribeAction extends DispatchAction {
    
    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private final static String LIST = "list";
    private final static String DETAIL = "detail";
    private final static String UPDATE = "update";

    public ActionForward addAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        SymptomDiscribe obj = (SymptomDiscribe)form;
        SymptomDiscribeDAO dao= new SymptomDiscribeDAO();
        dao.addSymptomDiscribe(obj);
        return mapping.findForward(LIST);
    }

    public ActionForward listAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String symId =  request.getParameter("symId");
        int intSymId = 0;
        if(symId!=null && !symId.isEmpty()){
            intSymId = Integer.parseInt(symId);
        }
        request.setAttribute("symId", intSymId);
        return mapping.findForward(SUCCESS);
    }

    public ActionForward detailAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = DETAIL;
        String strId = request.getParameter("symDiscId");;
        if(!strId.isEmpty()){
            Integer symDiscId = Integer.parseInt(strId);
            SymptomDiscribeDAO dao= new SymptomDiscribeDAO();
            SymptomDiscribe symptomDiscribe = dao.getSymptomDiscribeById(symDiscId);
            request.setAttribute("detail", symptomDiscribe);
        }else{
            forward = LIST;
        }

        return mapping.findForward(forward);
    }

    public ActionForward updateAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = UPDATE;
        String strId = request.getParameter("symDiscId");
        if(!strId.isEmpty()){
            Integer symDiscId = Integer.parseInt(strId);
            SymptomDiscribeDAO dao= new SymptomDiscribeDAO();
            SymptomDiscribe symptomDiscribe = dao.getSymptomDiscribeById(symDiscId);
            request.setAttribute("detail", symptomDiscribe);
        }else{
            forward = LIST;
        }

        return mapping.findForward(forward);
    }

    public ActionForward doUpdateAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        SymptomDiscribe obj = (SymptomDiscribe)form;
        SymptomDiscribeDAO dao= new SymptomDiscribeDAO();
        dao.updateSymptomDiscribe(obj);
        return mapping.findForward(LIST);
    }

    public ActionForward deleteAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = LIST;
        String strId = request.getParameter("symDiscId");
        if(!strId.isEmpty()){
            Integer symDiscId = Integer.parseInt(strId);
            SymptomDiscribeDAO dao= new SymptomDiscribeDAO();
            dao.deleteSymptomDiscribe(symDiscId);
        }

        return mapping.findForward(forward);
    }
}