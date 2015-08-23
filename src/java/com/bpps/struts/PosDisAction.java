/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.bpps.struts;

import com.bpps.dao.DiseaseDAO;
import com.bpps.dao.PosDisDAO;
import com.bpps.dao.PositionDAO;
import com.bpps.pojo.Disease;
import com.bpps.pojo.Position;
import com.bpps.pojo.PositionDisease;
import com.jdbc.DatabaseManager;
import com.util.UploadFile;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

/**
 *
 * @author Administrator
 */
public class PosDisAction extends DispatchAction {
    
    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String ADDIMAGE = "addImage";
    
    public ActionForward updateAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        String labelId = request.getParameter("labelId");
        int labelIdInt = Integer.parseInt(labelId);
        DiseaseDAO diseaseDAO = new DiseaseDAO();
        List<Integer> disAll = diseaseDAO.getAllDiseaseIDByLabelId(labelIdInt);

        DatabaseManager dbm = new DatabaseManager();
        PosDisDAO pdDao = new PosDisDAO();
        //pdDao.addAllPosDisStatus();

        PositionDAO positionDAO = new PositionDAO();
        List<Integer> positions = positionDAO.getAllPositionIDByLabelId(labelIdInt);
        for (Integer position : positions) {
            List<Integer> disChecked = new ArrayList<Integer>();
            List<Integer> disUnchecked = new ArrayList<Integer>();
            String strDis[] = request.getParameterValues(position+"");
//            System.out.println("posid="+position+":");
//            System.out.print("\tchecked:   ");
            if(strDis!=null) {
                for(String dis : strDis){
    //                System.out.print(dis + " ");
                    Integer intPos = new Integer(dis);
                    disChecked.add(intPos);
                }
            }
//            System.out.println("");
//            System.out.print("\tunchecked: ");
            for(Integer dis : disAll){
                if(!disChecked.contains(dis)){
//                    System.out.print(dis + " ");
                    disUnchecked.add(dis);
                }
            }
//            System.out.println("");

            pdDao.updatePosDisStatus(dbm, position, disChecked, disUnchecked);
        }
        dbm.close();


        return mapping.findForward(SUCCESS);
    }


    public ActionForward addImageAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        PositionDisease obj = (PositionDisease)form;
        UploadFile uploadFile = new UploadFile();
        String saveUrl = uploadFile.uploadImage(obj.getPosDisImage(),request, 200, 200);
        //System.out.println(saveUrl);
        if(saveUrl==null)
            saveUrl = "";
        obj.setPosDisImagePath(saveUrl);
        PosDisDAO dao= new PosDisDAO();
        dao.updatePosDisImagePath(obj);
        request.setAttribute("resultMessage", "添加位置图像成功！");
        return mapping.findForward(ADDIMAGE);
    }
}
