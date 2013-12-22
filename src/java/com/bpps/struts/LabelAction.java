/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.struts;

import com.bpps.dao.LabelDAO;
import com.bpps.pojo.LabelSystem;
import com.util.GenerateMenus;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.List;
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
public class LabelAction extends DispatchAction {

    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private final static String LIST = "list";
    private final static String DETAIL = "detail";
    private final static String UPDATE = "update";
    private final static String ADJUSTMENUORDER = "adjustMenuOrder";

    /**
     * This is the Struts action method called on
     * http://.../actionPath?method=myAction1, where "method" is the value
     * specified in <action> element : ( <action parameter="method" .../> )
     */
    public ActionForward addAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        LabelSystem obj = (LabelSystem) form;
        LabelDAO dao = new LabelDAO();
        dao.addLabelSystem(obj);

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
        String pId = request.getParameter("pid");
        int intPId = 0;
        if (pId != null && !pId.isEmpty()) {
            intPId = Integer.parseInt(pId);
        }
        request.setAttribute("pid", intPId);
        return mapping.findForward(SUCCESS);
    }

    public ActionForward detailAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = DETAIL;
        String strId = request.getParameter("labelId");
        if (!strId.isEmpty()) {
            Integer labelId = Integer.parseInt(strId);
            LabelDAO dao = new LabelDAO();
            LabelSystem labelSystem = dao.getLabelById(labelId);
            request.setAttribute("detail", labelSystem);
        } else {
            forward = LIST;
        }

        return mapping.findForward(forward);
    }

    public ActionForward updateAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = UPDATE;
        String strId = request.getParameter("labelId");
        if (!strId.isEmpty()) {
            Integer labelId = Integer.parseInt(strId);
            LabelDAO dao = new LabelDAO();
            LabelSystem labelSystem = dao.getLabelById(labelId);
            request.setAttribute("detail", labelSystem);
        } else {
            forward = LIST;
        }

        return mapping.findForward(forward);
    }

    public ActionForward updateLabelAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = LIST;

        //每次添加或更新菜单后，生成静态的下拉菜单，加快主页的显示速度
        GenerateMenus gm = new GenerateMenus();
        String path = request.getSession().getServletContext().getRealPath("/") + "WEB-INF\\jspf\\head_static.jspf";
        gm.generateHeadJSP(path);
        path = request.getSession().getServletContext().getRealPath("/") + "WEB-INF\\jspf\\mutil_level_selectbox.jspf";
        gm.generateMultiLevelSelectBoxJSP(path);

        return mapping.findForward(forward);
    }

    public ActionForward doUpdateAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        LabelSystem obj = (LabelSystem) form;
        LabelDAO dao = new LabelDAO();
        dao.updateLabelSystem(obj);

        return mapping.findForward(LIST);
    }

    public ActionForward deleteAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = LIST;
        String strId = request.getParameter("labelId");
        if (!strId.isEmpty()) {
            Integer labelId = Integer.parseInt(strId);
            LabelDAO dao = new LabelDAO();
            dao.deleteLabelSystem(labelId);
        }

        return mapping.findForward(forward);
    }

    public ActionForward adjustMenuOrder(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = ADJUSTMENUORDER;
        LabelDAO labelDAO = new LabelDAO();
        List<LabelSystem> level1 = labelDAO.getMenuLabels();
        for (LabelSystem label : level1) {
            String labelOrder = request.getParameter("label"+label.getLabelId());
            //System.out.println(labelOrder);
            labelDAO.updateLabelOrder(label.getLabelId(), Integer.parseInt(labelOrder));
        }

        return mapping.findForward(forward);
    }
}
