/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import method.DateHelper;
import util.Global;

/**
 *
 * @author mns
 */
public class ValidImageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String date = "", variable = "", time = "", depth = "";
        if (request != null) {
            date = request.getParameter("date");
            variable = request.getParameter("variable");
            time = request.getParameter("time");
            depth = request.getParameter("depth");
            String fullPath = date.substring(0, 6) + "/" + date + "/" + date + "_" + time + "_" + variable;

            if (depth != null && !depth.isEmpty()) {
                fullPath += "_" + depth;
            }

            fullPath += ".kmz";

            response.setContentType("text/plain");
            File file = new File(Global.circulation_figures_location + fullPath);
            if (file.exists()) {
                response.getWriter().write(fullPath);
            } else {
                String[] metaInfo = null;
                try {
                    metaInfo = getPreviousFile(date, variable, time, depth);
                } catch (ParseException ex) {
                    Logger.getLogger(ValidImageServlet.class.getName()).log(Level.SEVERE, null, ex);
                }
                response.getWriter().write(metaInfo[0]);
            }

            System.out.println(fullPath);
        }
    }

    private String[] getPreviousFile(String date, String variable, String time, String depth) throws ParseException {

        String timeStrings[] = {"0000", "0300", "0600", "0900", "1200", "1500", "1800", "2100"};
        int timeIndex = Arrays.binarySearch(timeStrings, time);
        if (timeIndex == -1) {
            timeIndex = 0;
        }

        for (int i = 0; i < 10; i++) {
            for (int j = 0; j < timeStrings.length; j++) {
                String fullPath = date.substring(0, 6) + "/" + date + "/" + date + "_" + time + "_" + variable;

                if (depth != null && !depth.isEmpty()) {
                    fullPath += "_" + depth;
                }

                fullPath += ".kmz";

                File file = new File(Global.circulation_figures_location + fullPath);
                if (file.exists()) {
                    return new String[]{fullPath,date};
                }
                //Logger.getLogger(ValServlet1.class.getName()).severe(filePath);
                timeIndex = timeIndex - 1;
                if (timeIndex < 0) {
                    timeIndex = timeStrings.length - 1;
                    break;
                }
            }
            date = DateHelper.prevDateString(date);

        }
        return new String[]{null, null};
    }

}
