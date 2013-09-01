/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.struts;

import com.bpps.dao.ExpertDAO;
import com.bpps.pojo.Expert;
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
public class ExpertAction extends DispatchAction {

    private final static String SUCCESS = "success";
    private final static String LIST = "list";
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
        Expert obj = (Expert) form;

        UploadFile uploadFile = new UploadFile();
        String saveUrl = uploadFile.uploadImage(obj.getEptPhoto(), request, 125, 170);
        //System.out.println(saveUrl);
        if (saveUrl == null) {
            saveUrl = request.getContextPath() + "/attached/image/sysimg/default_people.gif";;
        }
        obj.setEptPhotoUrl(saveUrl);

        ExpertDAO dao = new ExpertDAO();
        dao.addExpert(obj);
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
        String strId = request.getParameter("eptId");

        if (!strId.isEmpty()) {
            Integer articleId = Integer.parseInt(strId);
            ExpertDAO dao = new ExpertDAO();
            Expert article = dao.getExpertById(articleId);
            request.setAttribute("detail", article);
        } else {
            forward = LIST;
        }

        return mapping.findForward(forward);
    }

    public ActionForward updateAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = UPDATE;
        String strId = request.getParameter("eptId");
        if (!strId.isEmpty()) {
            Integer articleId = Integer.parseInt(strId);
            ExpertDAO dao = new ExpertDAO();
            Expert article = dao.getExpertById(articleId);
            request.setAttribute("detail", article);
        } else {
            forward = LIST;
        }

        return mapping.findForward(forward);
    }

    public ActionForward doUpdateAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Expert obj = (Expert) form;

        UploadFile uploadFile = new UploadFile();
        String saveUrl = uploadFile.uploadImage(obj.getEptPhoto(), request, 125, 170);
        //System.out.println(saveUrl);
        if (saveUrl == null) {
            saveUrl = request.getContextPath() + "/attached/image/sysimg/default_people.gif";;
        }
        obj.setEptPhotoUrl(saveUrl);

        ExpertDAO dao = new ExpertDAO();
        dao.updateExpert(obj);
        return mapping.findForward(LIST);
    }

    public ActionForward deleteAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = LIST;
        String strId = request.getParameter("eptId");
        if (strId != null && !strId.isEmpty()) {
            Integer articleId = Integer.parseInt(strId);
            ExpertDAO dao = new ExpertDAO();
            dao.deleteExpert(articleId);
        }

        return mapping.findForward(forward);
    }
}
