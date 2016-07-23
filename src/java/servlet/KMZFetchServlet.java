/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.Global;

/**
 *
 * @author mns
 */
public class KMZFetchServlet extends HttpServlet {

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException {

        String date = "", variable = "", time = "";
        if (request != null) {
            date = request.getParameter("date");
            variable = request.getParameter("variable");
            time = request.getParameter("time");

            String fullPath = Global.figures_location + date.substring(0, 6) + "/" + date + "/" + date + "_" + time + "_" + variable+".kmz";
            System.out.println(fullPath);
            
            response.setContentType("application/vnd.google-earth.kmz");
            response.setHeader("Content-Disposition","attachment; filename=\"" + date + "_" + time + "_" + variable+".kmz\"");
            File file = new File(fullPath);
            try {
                FileInputStream fin = new FileInputStream(file);
                OutputStream sout = response.getOutputStream();
                byte[] buf = new byte[1024 * 10];
                int len = 0;
                int totalLen = 0;
                while ((len = fin.read(buf)) >= 0) {
                    sout.write(buf);
                    totalLen+=len;
                }

                sout.close();
                fin.close();
                response.setStatus(200);
                response.setContentLength(totalLen);
            } catch (FileNotFoundException fe) {
                fe.printStackTrace();
            } catch (IOException ex) {
                ex.printStackTrace();
                Logger.getLogger(KMZFetchServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

}
