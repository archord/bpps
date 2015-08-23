/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.struts;

import com.bpps.dao.ExpertHelpMessageDAO;
import com.bpps.pojo.ExpertHelpMessage;
import com.util.UploadFile;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.actions.DispatchAction;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;

/**
 *
 * @author xy
 */
public class ExpertHelpMessageAction extends DispatchAction {

    private final static String SUCCESS = "success";
    private final static String ADDLIST = "list2";
    private final static String UPDATELIST = "list1";
    private final static String DETAIL = "detail";
    private final static String UPDATE = "update";
    private final static String ERROR = "error";

    /**
     * This is the Struts action method called on
     * http://.../actionPath?method=myAction1, where "method" is the value
     * specified in <action> element : ( <action parameter="method" .../> )
     */
    public ActionForward addAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        ExpertHelpMessage obj = (ExpertHelpMessage) form;

        ExpertHelpMessageDAO dao = new ExpertHelpMessageDAO();
        dao.addExpertHelpMessage(obj);
        return mapping.findForward(ADDLIST);
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
        String strId = request.getParameter("ehmId");

        if (!strId.isEmpty()) {
            Integer articleId = Integer.parseInt(strId);
            ExpertHelpMessageDAO dao = new ExpertHelpMessageDAO();
            ExpertHelpMessage article = dao.getExpertHelpMessageById(articleId);
            request.setAttribute("detail", article);
        } else {
            forward = UPDATELIST;
        }

        return mapping.findForward(forward);
    }

    public ActionForward updateAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = UPDATE;
        String strId = request.getParameter("ehmId");
        if (!strId.isEmpty()) {
            Integer articleId = Integer.parseInt(strId);
            ExpertHelpMessageDAO dao = new ExpertHelpMessageDAO();
            ExpertHelpMessage article = dao.getExpertHelpMessageById(articleId);
            request.setAttribute("detail", article);
        } else {
            forward = UPDATELIST;
        }

        return mapping.findForward(forward);
    }

    public ActionForward doUpdateAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        ExpertHelpMessage obj = (ExpertHelpMessage) form;

        ExpertHelpMessageDAO dao = new ExpertHelpMessageDAO();
        dao.updateExpertHelpMessage(obj);
        return mapping.findForward(UPDATELIST);
    }

    public ActionForward deleteAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = UPDATELIST;
        String strId = request.getParameter("ehmId");
        if (strId != null && !strId.isEmpty()) {
            Integer articleId = Integer.parseInt(strId);
            ExpertHelpMessageDAO dao = new ExpertHelpMessageDAO();
            dao.deleteExpertHelpMessage(articleId);
        }

        return mapping.findForward(forward);
    }
}
