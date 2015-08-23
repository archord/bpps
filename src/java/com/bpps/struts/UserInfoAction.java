/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package com.bpps.struts;

import com.bpps.dao.UserInfoDAO;
import com.bpps.pojo.UserInfo;
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
public class UserInfoAction extends DispatchAction {
    
    /* forward name="success" path="" */
    private static final String SUCCESS = "success";
    private static final String LOGINSUCCESS = "loginsuccess";
    private static final String LOGINERROR = "loginerror";
    private final static String LIST = "list";
    private final static String UPDATE = "update";
    private final static String ERROR = "error";
    
    public ActionForward addAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        UserInfo obj = (UserInfo) form;
        UserInfoDAO userDAO = new UserInfoDAO();
        userDAO.addUser(obj);
        return mapping.findForward(LIST);
    }

    /**
     * This is the Struts action method called on
     * http://.../actionPath?method=myAction2,
     * where "method" is the value specified in <action> element :
     * ( <action parameter="method" .../> )
     */
    public ActionForward listAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
//        String name =  request.getParameter("disName");
//        request.setAttribute("list", "abd");
        return mapping.findForward(SUCCESS);
    }

    public ActionForward loginAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String flag = LOGINSUCCESS;
        UserInfo obj = (UserInfo) form;
        if (obj.getUserName() != null && obj.getPassword() != null) {
            obj.setUserId(0);
            UserInfoDAO userDAO = new UserInfoDAO();
            userDAO.checkUser(obj);
            if (obj.getUserId() == 0) {
                flag = LOGINERROR;
                request.setAttribute("loginerror", 1);
            } else {
                request.getSession().setAttribute("userInfo", obj);
            }
        } else {
            flag = LOGINERROR;
            request.setAttribute("loginerror", 2);
        }
        return mapping.findForward(flag);
    }

    public ActionForward updateAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = UPDATE;
        String strId = request.getParameter("userId");
        if (!strId.isEmpty()) {
            Integer userId = Integer.parseInt(strId);
            UserInfoDAO dao = new UserInfoDAO();
            UserInfo article = dao.getUserById(strId);
            request.setAttribute("detail", article);
        } else {
            forward = LIST;
        }

        return mapping.findForward(forward);
    }

    public ActionForward doUpdateAction(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        UserInfo obj = (UserInfo) form;

        UserInfoDAO dao = new UserInfoDAO();
        dao.updateUserInfo(obj);
        return mapping.findForward(LIST);
    }

    public ActionForward deleteAction(ActionMapping mapping, ActionForm  form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {
        String forward = LIST;
        String strId = request.getParameter("userId");
        if(!strId.isEmpty()){
            Integer posId = Integer.parseInt(strId);
            UserInfoDAO dao= new UserInfoDAO();
            UserInfo user = dao.getUserById(strId);
            if(!user.getUserName().equalsIgnoreCase("root")) {
                dao.deletePosition(posId);
            }
        }

        return mapping.findForward(forward);
    }
}
