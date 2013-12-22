/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.bpps.servlet;

import com.bpps.dao.SymDisDAO;
import com.bpps.dao.SymptomDiscribeDAO;
import com.bpps.pojo.SymptomDiscribe;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author xy
 */
public class DisSymServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
            String posIdStr = request.getParameter("posId");
            String disIdStr = request.getParameter("disId");
            String symIdStr = request.getParameter("symId");
            if (posIdStr != null && disIdStr != null && symIdStr != null
                    && !posIdStr.isEmpty() && !disIdStr.isEmpty() && !symIdStr.isEmpty()) {
                int posId = Integer.parseInt(posIdStr);
                int disId = Integer.parseInt(disIdStr);
                int symId = Integer.parseInt(symIdStr);
                SymptomDiscribeDAO symDesDAO = new SymptomDiscribeDAO();
                SymDisDAO symDisDAO = new SymDisDAO();
                List<SymptomDiscribe> symDess = symDesDAO.getSymptomDiscribesBySymId(symId);
                List<Integer> symDescribeIds = symDisDAO.getDiscribeIdsByPosDisSymId(posId, disId, symId);

                StringBuilder disSymAttrSB = new StringBuilder();
                //该症状为"是否"属性
                if (symDess.isEmpty()) {
                    //symtype=0，表示为"是否"属性
                    disSymAttrSB.append("<input type=\"hidden\" id=\"symtype\" name=\"symtype\" value=\"0\"/>");
                    disSymAttrSB.append("<input type=\"radio\" name=\"disSymAttr\" value=\"1\" ");
                    if (!symDescribeIds.isEmpty() && symDescribeIds.get(0) == 1) {
                        disSymAttrSB.append("checked");
                    }
                    disSymAttrSB.append("/>&nbsp;关联");
                    disSymAttrSB.append("<input type=\"radio\" name=\"disSymAttr\" value=\"0\" ");
                    if (symDescribeIds.isEmpty() || symDescribeIds.get(0) != 1) {
                        disSymAttrSB.append("checked");
                    }
                    disSymAttrSB.append("/>&nbsp;不关联");
                } else {//该症状为多属性
                    //symtype=1，表示为"多"属性
                    disSymAttrSB.append("<input type=\"hidden\" id=\"symtype\" name=\"symtype\" value=\"1\"/>");
                    for (SymptomDiscribe tSymDes : symDess) {
                        //disSymAttrSB.append("<input style=\"border:0px;width:20px;\" class=checkbox type=\"checkbox\" name=\"disSymAttr\" value=\"");
                        disSymAttrSB.append("<span><input type=\"checkbox\" name=\"disSymAttr\" value=\"");
                        disSymAttrSB.append(tSymDes.getSymDiscId());
                        disSymAttrSB.append("\" ");
                        if(symDescribeIds.contains(tSymDes.getSymDiscId())) {
                            disSymAttrSB.append("checked");
                        }
                        disSymAttrSB.append("/>&nbsp;&nbsp;");
                        disSymAttrSB.append(tSymDes.getSymDiscName());
                        disSymAttrSB.append("</span>\n");
                    }
                }
                out.println(disSymAttrSB.toString());
            } else {
                out.println("Error Code:" + 500);
                System.out.println("DisSymServlet：请求数据错误！");
                System.out.println("posId=" + posIdStr + "disId=" + disIdStr + "symId=" + symIdStr);
            }
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
