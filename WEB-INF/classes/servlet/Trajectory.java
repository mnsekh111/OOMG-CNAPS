package servlet;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.TimeUnit;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.Global;
import util.Log;
import util.RandomID;

public class Trajectory extends HttpServlet {

    /**
     * Constructor of the object.
     */
    public Trajectory() {
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

        response.setContentType("text/html");

        List<String> lonlats = new LinkedList<String>();
        int n = Integer.valueOf(request.getParameter("n"));

        //		for(int i=0;i<Integer.valueOf(n);i++){
        //			out.print(request.getParameter("lon"+String.valueOf(i)));
        //			out.print(" ");
        //			out.print(request.getParameter("lat"+String.valueOf(i)));
        //			out.println();
        //		}
        if (n < 1) {
            return;
        }

        String ID = RandomID.getID();
        String dir = Global.dir + "trajectory/";

        FileWriter input;
        try {
            input = new FileWriter(dir + Global.input_drift + ID);
            for (int i = 0; i < n; i++) {
                input.write(request.getParameter("lon" + String.valueOf(i)));
                input.write(" ");
                input.write(request.getParameter("lat" + String.valueOf(i)));
                input.write("\n");
            }
            input.close();
        } catch (IOException ex) {
            Logger.getLogger(Trajectory.class.getName()).log(Level.SEVERE, null, ex);
        }

        Process p = null;

        try {
            p = Runtime.getRuntime().exec("bash " + Global.bash_drift + " " + ID, null, new File(dir));

            String line;
            BufferedReader reader
                    = new BufferedReader(new InputStreamReader(p.getInputStream()));
            while ((line = reader.readLine()) != null) {
                //new Log().log(line);
                if (line == "end\n") {
                    break;
                }

            }
            reader.close();
        } catch (IOException ex) {
            Logger.getLogger(Trajectory.class.getName()).log(Level.SEVERE, null, ex);
        }

        if (p != null) {
            try {
                p.waitFor();
            } catch (InterruptedException ex) {
                Logger.getLogger(Trajectory.class.getName()).log(Level.SEVERE, null, ex);
            }
        }

        File file = new File(dir + Global.output_drift + ID + Global.output_drift_type);
        //new Log().log("length "+String.valueOf(file.length()));

        try {
            BufferedReader br = new BufferedReader(new FileReader(file));
            PrintWriter out = response.getWriter();
            String line;
            Pattern p1 = Pattern.compile("(\\S+)\\s+(\\S+)\\s+");

            while ((line = br.readLine()) != null) {
                //new Log().log("line "+line);
                if (line.length() == 0) {
                    out.println();
                } else {
                    Matcher matcher = p1.matcher(line);
                    if (matcher.find()) {
                        //			    for (int i=1; i<=matcher.groupCount(); i++) {
                        //			        String groupStr = matcher.group(i);
                        //			        out.print(groupStr+" ");
                        //			    }
                        System.out.println(matcher.group(1) + ",");
                        System.out.println(matcher.group(2) + ",");
                        out.print(matcher.group(1) + ",");
                        out.print(matcher.group(2) + ";");
                    }
                }

            }

            br.close();
            out.flush();
            out.close();
            
        } catch (FileNotFoundException fe) {
            System.out.println(fe.getMessage());
        } catch (IOException ex) {
            Logger.getLogger(Trajectory.class.getName()).log(Level.SEVERE, null, ex);
        }
//        try {
//            response.getWriter().print("LOL");
//            response.getWriter().close();
//        } catch (IOException ie) {
//            ie.printStackTrace();
//        }
        //new File(dir+Global.input_drift+ID).delete();
        //file.delete();
    }

}
