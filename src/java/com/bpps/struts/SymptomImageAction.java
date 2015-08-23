/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.struts;

import com.bpps.dao.SymptomImageDAO;
import com.bpps.pojo.SymptomImage;
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
public class SymptomImageAction extends DispatchAction {
 
    /* forward name="success" path="" */
    private final static String SUCCESS = "success";
    private final static String LIST = "list";
    private final static String DETAIL = "detail";
    private final static String UPDATE = "update";

    public ActionForward addAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        SymptomImage obj = (SymptomImage)form;
        
        UploadFile uploadFile = new UploadFile();
        String saveUrl = uploadFile.uploadSymImage(obj, request);
        //System.out.println(saveUrl);
        if(saveUrl==null)
            saveUrl = "";
        obj.setSiImagePath(saveUrl);
        
        SymptomImageDAO dao= new SymptomImageDAO();
        dao.addSymptomImage(obj);
        return mapping.findForward(LIST);
    }

    public ActionForward listAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
//        String symId =  request.getParameter("symId");
//        int intSymId = 0;
//        if(symId!=null && !symId.isEmpty()){
//            intSymId = Integer.parseInt(symId);
//        }
//        request.setAttribute("symId", intSymId);
        return mapping.findForward(SUCCESS);
    }

    public ActionForward detailAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = DETAIL;
        String strId = request.getParameter("siId");;
        if(!strId.isEmpty()){
            Integer symDiscId = Integer.parseInt(strId);
            SymptomImageDAO dao= new SymptomImageDAO();
            SymptomImage symptomDiscribe = dao.getSymptomImageById(symDiscId);
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
        String strId = request.getParameter("siId");
        if(!strId.isEmpty()){
            Integer symDiscId = Integer.parseInt(strId);
            SymptomImageDAO dao= new SymptomImageDAO();
            SymptomImage symptomDiscribe = dao.getSymptomImageById(symDiscId);
            request.setAttribute("detail", symptomDiscribe);
        }else{
            forward = LIST;
        }

        return mapping.findForward(forward);
    }

    public ActionForward doUpdateAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        SymptomImage obj = (SymptomImage)form;
        SymptomImageDAO dao= new SymptomImageDAO();
        dao.updateSymptomImage(obj);
        return mapping.findForward(LIST);
    }

    public ActionForward deleteAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = LIST;
        String strId = request.getParameter("siId");
        if(!strId.isEmpty()){
            Integer symDiscId = Integer.parseInt(strId);
            SymptomImageDAO dao= new SymptomImageDAO();
            dao.deleteSymptomImage(symDiscId);
        }

        return mapping.findForward(forward);
    }
}
