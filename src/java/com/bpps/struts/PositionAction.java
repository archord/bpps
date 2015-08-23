/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.bpps.struts;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.actions.DispatchAction;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionForward;
import com.bpps.dao.PositionDAO;
import com.bpps.pojo.Position;
import com.util.UploadFile;
import org.apache.struts.upload.FormFile;

/**
 *
 * @author Administrator
 */
public class PositionAction extends DispatchAction {

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
        
        Position obj = (Position)form;
        UploadFile uploadFile = new UploadFile();
        String saveUrl = uploadFile.uploadImage(obj.getPosImage(),request, 200, 200);
        //System.out.println(saveUrl);
        if(saveUrl==null)
            saveUrl = "";
        obj.setPosImagePath(saveUrl);
        PositionDAO dao= new PositionDAO();
        dao.addPosition(obj);
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
//        String name =  request.getParameter("disName");
//        request.setAttribute("list", "abd");
        return mapping.findForward(SUCCESS);
    }

    public ActionForward detailAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = DETAIL;
        String strId = request.getParameter("posId");;
        if(!strId.isEmpty()){
            Integer posId = Integer.parseInt(strId);
            PositionDAO dao= new PositionDAO();
            Position Position = dao.getPositionById(posId);
            request.setAttribute("detail", Position);
        }else{
            forward = LIST;
        }

        return mapping.findForward(forward);
    }

    public ActionForward updateAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = UPDATE;
        String strId = request.getParameter("posId");
        if(!strId.isEmpty()){
            Integer posId = Integer.parseInt(strId);
            PositionDAO dao= new PositionDAO();
            Position Position = dao.getPositionById(posId);
            request.setAttribute("detail", Position);
        }else{
            forward = LIST;
        }

        return mapping.findForward(forward);
    }

    public ActionForward doUpdateAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        Position obj = (Position)form;
        UploadFile uploadFile = new UploadFile();
        String saveUrl = uploadFile.uploadImage(obj.getPosImage(),request, 200, 200);
        //System.out.println(saveUrl);
        if(saveUrl!=null)
            obj.setPosImagePath(saveUrl);
        if(obj.getPosImagePath()==null || obj.getPosImagePath().equals("")){
            obj.setPosImagePath("");
        }
        PositionDAO dao= new PositionDAO();
        dao.updatePosition(obj);
        
        return mapping.findForward(LIST);
    }

    public ActionForward deleteAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = LIST;
        String strId = request.getParameter("posId");
        if(!strId.isEmpty()){
            Integer posId = Integer.parseInt(strId);
            PositionDAO dao= new PositionDAO();
            dao.deletePosition(posId);
        }

        return mapping.findForward(forward);
    }
}