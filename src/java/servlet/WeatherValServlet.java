package servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.Global;
//import util.Log;

public class WeatherValServlet extends HttpServlet {

    /**
     * Constructor of the object.
     */
    public WeatherValServlet() {
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
            throws ServletException {

        String day, date, buoy, variable;
        day = request.getParameter("day");
        date = request.getParameter("date");
        buoy = request.getParameter("buoy");
        variable = request.getParameter("variable");

        String filepath = null;

        filepath = Global.val_figures_location
                + day.substring(0, 6) + "/"
                + day + "/BUOY/" + "ndbc." + buoy + "." + variable + "_" + day + ".png";
        System.out.println(filepath);
        // filepath = "/home/mns/remote/current/coawst_useast/Plot/201405/20140501/BUOY/ndbc.41002.Pair_20140501.png";

        File file = new File(filepath);
        try {
            if (!file.exists()) {
                String relativeWebPath = "/mns-images";
                String absoluteDiskPath = getServletContext().getRealPath(relativeWebPath);
                file = new File(absoluteDiskPath, "image-not-found.png");
            }

            // Open the file and output streams
            FileInputStream in = new FileInputStream(file);

            // Copy the contents of the file to the output stream
            byte[] buf = new byte[2048];
            int count = 0;
            // Get the MIME type of the image
            String mimeType = getServletContext().getMimeType(filepath);
            if (mimeType == null) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                return;
            }

            // Set content type
            response.setContentType(mimeType);
            ServletOutputStream sout = response.getOutputStream();
            while ((count = in.read(buf)) >= 0) {
                sout.write(buf, 0, count);
            }

            in.close();
            sout.close();

        } catch (IOException ex) {
            Logger.getLogger(WeatherValServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
