/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.catalina.connector.Response;
import util.Global;

/**
 *
 * @author mns
 */


public class AnimationServlet extends HttpServlet {

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
            throws ServletException, IOException {

        response.setContentType("text/plain");
        try {
            String startDateStr = request.getParameter("startDate");
            String endDateStr = request.getParameter("endDate");
            String variable = request.getParameter("variable");
            String depth = request.getParameter("depth");
            if (depth == null) {
                depth = "";
            }

            File dir = new File(Global.figures_location);
            String[] yyyymmDirs = dir.list();

            //System.out.println(Arrays.toString(yyyymmDirs));
            String currentDate = startDateStr;
            String currentMonth = currentDate.substring(0, 6);
            KMZFileFilter filter = new KMZFileFilter(depth.isEmpty() ? "_" + variable + ".kmz" : "_" + variable + "_" + depth + ".kmz");

            ArrayList<String> allValidStrings = new ArrayList<>();
            do {

                for (int i = 0; i < yyyymmDirs.length; i++) {
                    if (yyyymmDirs[i].contentEquals(currentMonth)) {

                        //Go into the current month directory
                        File currMonthDir = new File(dir.getAbsoluteFile() + File.separator + yyyymmDirs[i]);
                        //Get the list of days within the month directory
                        String[] allDays = currMonthDir.list(new DayFolderFilter(currentDate));
                        //Can be only one folder
                        File currDayDir = new File(currMonthDir.getAbsoluteFile() + File.separator + allDays[0]);

                        String[] allFiles = currDayDir.list(filter);
                        Arrays.sort(allFiles);
                        allValidStrings.addAll(Arrays.asList(allFiles));
                    }
                }

                currentDate = getNextDate(currentDate);
                currentMonth = currentDate.substring(0, 6);
                System.out.println(currentDate + " " + currentMonth);

            } while (!currentDate.contentEquals(getNextDate(endDateStr)));

            for(int i=0;i<allValidStrings.size();i++){
                response.getOutputStream().println(allValidStrings.get(i));
            }
            
            response.getOutputStream().close();
            response.setStatus(200);

        } catch (ParseException ex) {
            Logger.getLogger(AnimationServlet.class.getName()).log(Level.SEVERE, null, ex);
            response.setStatus(Response.SC_INTERNAL_SERVER_ERROR);
        }

    }

    public static String getNextDate(String curDate) throws ParseException {
        final SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        final Date date = format.parse(curDate);
        System.out.println(date.toString());
        final Calendar calendar = Calendar.getInstance();
        calendar.setTime(date);
        calendar.add(Calendar.DAY_OF_YEAR, 1);
        return format.format(calendar.getTime());
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

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

    static class DayFolderFilter implements FilenameFilter {

        String date;

        public DayFolderFilter(String date) {
            this.date = date;
        }

        @Override
        public boolean accept(File dir, String name) {
            if (name.contentEquals(date)) {
                return true;
            }
            return false;
        }
    }

    static class KMZFileFilter implements FilenameFilter {

        String fileEnd;

        public KMZFileFilter(String val) {
            fileEnd = val;
            System.out.println("<<<<<<" + val);
        }

        @Override
        public boolean accept(File dir, String name) {
            //System.out.println(name);
            if (name.contains(fileEnd)) {
                return true;
            }
            return false;
        }

    }

    public static void main(String[] args) throws ParseException {
        String startDateStr = "20160714";
        String endDateStr = "20160716";
        String variable = "s";
        String depth = "10";

        File dir = new File(Global.figures_location);
        String[] yyyymmDirs = dir.list();

        //System.out.println(Arrays.toString(yyyymmDirs));
        String currentDate = startDateStr;
        String currentMonth = currentDate.substring(0, 6);
        KMZFileFilter filter = new KMZFileFilter(depth.isEmpty() ? "_" + variable + ".kmz" : "_" + variable + "_" + depth + ".kmz");

        ArrayList<String> allValidStrings = new ArrayList<>();
        do {
            for (int i = 0; i < yyyymmDirs.length; i++) {
                if (yyyymmDirs[i].contentEquals(currentMonth)) {

                    //Go into the current month directory
                    File currMonthDir = new File(dir.getAbsoluteFile() + File.separator + yyyymmDirs[i]);
                    //System.out.println(currMonthDir.getAbsolutePath());

                    System.out.println(currMonthDir.getAbsolutePath());
                    //Get the list of days within the month directory
                    String[] allDays = currMonthDir.list(new DayFolderFilter(currentDate));
                    System.out.println(Arrays.toString(allDays));

                    File currDayDir = new File(currMonthDir.getAbsoluteFile() + File.separator + allDays[0]);
                    //System.out.println(currDayDir.getAbsolutePath());
                    //Can be only one folder
                    String[] allFiles = currDayDir.list(filter);

                    Arrays.sort(allFiles);
                    //System.out.println(Arrays.toString(allFiles));
                    allValidStrings.addAll(Arrays.asList(allFiles));
                }
            }

            currentDate = getNextDate(currentDate);
            currentMonth = currentDate.substring(0, 6);
            System.out.println(currentDate + " " + currentMonth);

        } while (!currentDate.contentEquals(getNextDate(endDateStr)));

        System.out.println(allValidStrings.toString());
    }

}
