package servlet;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.Global;
import util.RandomID;

public class Vertical extends HttpServlet {

    /**
     * Constructor of the object.
     */
    public Vertical() {
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

        response.setContentType("text/html");
        String lon, lat, date, time;
        String ID = RandomID.getID();
        String dir = Global.dir + "vertical/";

        String imagename = dir + Global.output_vertical + ID + Global.output_vertical_type;

        lon = request.getParameter("lon");
        lat = request.getParameter("lat");
        date = request.getParameter("date");
        time = request.getParameter("time");

        ServletContext sc = getServletContext();
        try {

            FileWriter f_lon_lat_vetical = new FileWriter(dir + Global.input_vertical_1 + ID);
            f_lon_lat_vetical.write(lon + " " + lat + "\n");
            f_lon_lat_vetical.close();

            FileWriter f_verticaltime = new FileWriter(dir + Global.input_vertical_2 + ID);
            f_verticaltime.write(date.substring(0, 4) + " " + date.substring(4, 6) + " " + date.substring(6) + " " + time + "\n");
            f_verticaltime.close();

            int timeout = 0;
            String line;
            Process p = Runtime.getRuntime().exec("bash " + Global.bash_vertical + " " + ID, null, new File(dir));

            BufferedReader reader
                    = new BufferedReader(new InputStreamReader(p.getInputStream()));
            while ((line = reader.readLine()) != null) {
                timeout++;
            }

            BufferedReader reader_e
                    = new BufferedReader(new InputStreamReader(p.getErrorStream()));
            while ((line = reader_e.readLine()) != null) {
                //log.log("error "+line);
                timeout++;
            }

            p.waitFor();

            reader.close();
            reader_e.close();

        } catch (IOException e) {
            System.out.println(e.getMessage());
            //new Log().log(e.getMessage());				
        } catch (InterruptedException ex) {
            Logger.getLogger(Vertical.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Get the MIME type of the image
        String mimeType = sc.getMimeType(imagename);
        if (mimeType == null) {
            sc.log("Could not get MIME type of " + imagename);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            return;
        }

        // Set content type
        response.setContentType(mimeType);

        // Set content size
        File file = new File(imagename);

        //busy waiting for the image
        int timeout = 0;
        while (!file.exists() && timeout < Global.MaxTimeout) {
            try {
                Thread.sleep(1000);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            timeout++;
        }
        if (timeout >= Global.MaxTimeout) {
            return;
        }

        response.setContentLength((int) file.length());

        // Open the file and output streams
        FileInputStream in = new FileInputStream(file);

        // Copy the contents of the file to the output stream
        byte[] buf = new byte[2048];
        int count = 0;
        ServletOutputStream sout = response.getOutputStream();
        while ((count = in.read(buf)) >= 0) {
            sout.write(buf, 0, count);
        }

        in.close();

//	    new File(dir+Global.input_vertical_1+ID).delete();
//	    new File(dir+Global.input_vertical_2+ID).delete();
//	    file.delete();
        sout.close();

    }

}
