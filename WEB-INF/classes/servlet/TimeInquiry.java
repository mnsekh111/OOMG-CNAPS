package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import method.TimePeriod;

import util.Log;

public class TimeInquiry extends HttpServlet {

    /**
     * Constructor of the object.
     */
    public TimeInquiry() {
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
        PrintWriter out = response.getWriter();
        String date = util.TimeFormat.mmddyyy2yyymmdd(request.getParameter("date"));
        new Log().log(date);
        ArrayList<String> dates = new TimePeriod().getTimePeriod();

//        out.print(date+"\n");
//        for(int i=dates.size()-1;i>=0;i--)
//            out.print(dates.get(i)+"\n");



        if (dates.contains(date) == false) {
            out.print("no");
        } else {
            int start = dates.indexOf(date);
            //out.print("start index " + start + "\n");
            int end;
            if (start + 7 > dates.size() - 1) {
                end = dates.size() - 1;
            } else {
                end = start + 7;
            }

            //out.print("end index " + end + "\n");

            String output ="";

            for (int i = start; i <= end; i++) {
                for (int j = 0; j <= 21; j += 3) {
                    String str_date = dates.get(i) + "_";
                    if (j < 10) {
                        str_date += "0";
                    }
                    str_date += String.valueOf(j) + "00";
                    String str_date_format = dates.get(i).subSequence(4, 6) + "/" + dates.get(i).substring(6, 8) + "/" + dates.get(i).substring(0, 4)
                            + " " + str_date.substring(9, 11) + ":" + str_date.substring(11);

                    out.print("<option value=\""+ str_date + "\">" + str_date_format + "</option>");

//					out.print(
                    //							"<input type=\"radio\" id=\""+str_date+
                    //							"\" name=\"radio\" /><label for=\""+str_date+
                    //							"\">"+str_date_format+"</label>"
                    //					);

                }
            }

        }

        out.flush();
        out.close();
    }

}
