/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.struts;

import com.bpps.dao.FunctionPageDAO;
import com.bpps.pojo.FunctionPage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

/**
 *
 * @author xy
 */
public class FunctionPageAction extends DispatchAction {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private final static String LIST = "list";
    private final static String DETAIL = "detail";
    private final static String UPDATE = "update";

    public ActionForward addAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        FunctionPage obj = (FunctionPage)form;
        FunctionPageDAO dao= new FunctionPageDAO();
        dao.addFunctionPage(obj);
        return mapping.findForward(LIST);
    }

    public ActionForward listAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String pId =  request.getParameter("pid");
        int intPId = 0;
        if(pId!=null && !pId.isEmpty()){
            intPId = Integer.parseInt(pId);
        }
        request.setAttribute("pid", intPId);
        return mapping.findForward(SUCCESS);
    }

    public ActionForward detailAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = DETAIL;
        String strId = request.getParameter("pageId");
        if(!strId.isEmpty()){
            Integer pageId = Integer.parseInt(strId);
            FunctionPageDAO dao= new FunctionPageDAO();
            FunctionPage functionPage = dao.getFunctionPageById(pageId);
            request.setAttribute("detail", functionPage);
        }else{
            forward = LIST;
        }

        return mapping.findForward(forward);
    }
    public ActionForward updateAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = UPDATE;
        String strId = request.getParameter("pageId");
        if (!strId.isEmpty()) {
            Integer pageId = Integer.parseInt(strId);
            FunctionPageDAO dao = new FunctionPageDAO();
            FunctionPage functionPage = dao.getFunctionPageById(pageId);
            request.setAttribute("detail", functionPage);
        } else {
            forward = LIST;
        }

        return mapping.findForward(forward);
    }

    public ActionForward doUpdateAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        FunctionPage obj = (FunctionPage)form;
        FunctionPageDAO dao= new FunctionPageDAO();
        dao.updateFunctionPage(obj);
        return mapping.findForward(LIST);
    }

    public ActionForward deleteAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = LIST;
        String strId = request.getParameter("pageId");
        if(!strId.isEmpty()){
            Integer pageId = Integer.parseInt(strId);
            FunctionPageDAO dao= new FunctionPageDAO();
            dao.deleteFunctionPage(pageId);
        }

        return mapping.findForward(forward);
    }
}
