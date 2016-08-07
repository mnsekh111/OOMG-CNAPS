package servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.text.ParseException;
import java.util.Arrays;
import java.util.Base64;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import method.DateHelper;

import util.Global;
//import util.Log;

public class ValServlet1 extends HttpServlet {

    /**
     * Constructor of the object.
     */
    public ValServlet1() {
        super();
    }

    /**
     * The doGet method of the servlet. <br>
     *
     * This method is called when a form has its tag value method equals to get.
     *
     * @param request the request send by the client to the server
     * @param response the response send by the server to the client
     * @throws ServletException if an error occurred
     * @throws IOException if an error occurred
     */
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        boolean imgFound = true;
        String day, hfDate, areaNum;
        String time = request.getParameter("time");
        day = request.getParameter("day");
        hfDate = request.getParameter("hfdate");
        areaNum = request.getParameter("areanum");

        String filePath = null;

        filePath = Global.circulation_figures_location
                + day.substring(0, 6) + "/"
                + day + "/HF/"
                + hfDate + "_" + time + "_hfuv_" + areaNum + ".png";

        File file = new File(filePath);
        String[] metainfo = null;
        try {
            if (!file.exists()) {
                imgFound = false;
                String relativeWebPath = "/mns-images";
                String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);
                metainfo = getPreviousFile(hfDate, areaNum, time);
                filePath = metainfo[0];
                if (filePath != null) {
                    file = new File(filePath);
                } else {
                    file = new File(absoluteDiskPath, "image-not-found.png");
                }

            }

            // Open the file and output streams
            FileInputStream in = new FileInputStream(file);

            // Copy the contents of the file to the output stream
            byte[] buf = new byte[2048 * 100];
            int count = 0;
            // Get the MIME type of the image
            String mimeType = getServletContext().getMimeType(filePath);
            if (mimeType == null) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                return;
            }

            // Set content type
            response.setContentType(mimeType);
            response.setHeader("meta-correct", Boolean.toString(imgFound));
            if(metainfo!=null && metainfo[1] !=null && metainfo[2]!=null){
                response.setHeader("meta-info", "Date: " + metainfo[1]+ " time : "+metainfo[2]);
            }
            
            ServletOutputStream sout = response.getOutputStream();
            while ((count = in.read(buf)) >= 0) {

                byte[] trimBuf = Arrays.copyOf(buf, count);
                byte[] encodedByteArr = Base64.getEncoder().encode(trimBuf);
                sout.write(encodedByteArr, 0, encodedByteArr.length);
            }

            in.close();
            sout.close();

        } catch (IOException ex) {
            Logger.getLogger(ValServlet1.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(ValServlet1.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    private String[] getPreviousFile(String hfDate, String areaNum, String time) throws ParseException {
        String timeStrings[] = {"0000", "0300", "0600", "0900", "1200", "1500", "1800", "2100"};
        int timeIndex = Arrays.binarySearch(timeStrings, time);
        if (timeIndex == -1) {
            timeIndex = 0;
        }

        for (int i = 0; i < 10; i++) {
            for (int j = 0; j < timeStrings.length; j++) {
                String filePath = Global.circulation_figures_location
                        + hfDate.substring(0, 6) + "/"
                        + hfDate + "/HF/"
                        + hfDate + "_" + timeStrings[timeIndex] + "_hfuv_" + areaNum + ".png";

                File file = new File(filePath);
                if (file.exists()) {
                    return new String[]{filePath, hfDate, timeStrings[timeIndex]};
                }
                Logger.getLogger(ValServlet1.class.getName()).severe(filePath);
                timeIndex = timeIndex - 1;
                if (timeIndex < 0) {
                    timeIndex = timeStrings.length - 1;
                    break;
                }
            }
            hfDate = DateHelper.prevDateString(hfDate);

        }
        return new String[]{null, null, null};
    }

}
