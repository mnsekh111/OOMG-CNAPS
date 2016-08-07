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

public class WaveValServlet extends HttpServlet {

    /**
     * Constructor of the object.
     */
    public WaveValServlet() {
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
        String day, date, buoy, variable;
        day = request.getParameter("day");
        date = request.getParameter("date");
        buoy = request.getParameter("buoy");
        variable = "Hwave";

        String filePath = null;

        filePath = Global.val_figures_location
                + day.substring(0, 6) + "/"
                + day + "/BUOY/" + "ndbc." + buoy + "." + variable + "_" + day + ".png";
        System.out.println(filePath);
        // filePath = "/home/mns/remote/current/coawst_useast/Plot/201405/20140501/BUOY/ndbc.41002.Pair_20140501.png";

        String[] metainfo = null;
        File file = new File(filePath);
        try {
            if (!file.exists()) {
                imgFound = false;
                String relativeWebPath = "/mns-images";
                String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);
                metainfo = getPreviousFile(date, buoy, variable);
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
            if (metainfo != null && metainfo[1] != null) {
                response.setHeader("meta-info", "Date: " + metainfo[1]);
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
            Logger.getLogger(WeatherValServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (ParseException ex) {
            Logger.getLogger(WaveValServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

    }
    
        private String[] getPreviousFile(String date, String buoy, String variable) throws ParseException {
        for (int i = 0; i < 10; i++) {

           String filePath = Global.val_figures_location
                + date.substring(0, 6) + "/"
                + date + "/BUOY/" + "ndbc." + buoy + "." + variable + "_" + date + ".png";

            File file = new File(filePath);
            if (file.exists()) {
                return new String[]{filePath, date};
            }

            date = DateHelper.prevDateString(date);

        }
        return new String[]{null, null};
    }

}
