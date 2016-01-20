
package servlet;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
//import org.apache.log4j.Logger;

import util.Global;
//import util.Log;

public class Ensemble extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public Ensemble() {
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
		
		String day,date,variable,depth, reqtype;
		day=request.getParameter("day");
		date=request.getParameter("date");
        variable=request.getParameter("variable");		

		
        String filepath = null;
            
        //filepath = Global.circulation_figures_location+"/"+day.substring(0,6)+"/"+day+"/"+day+"_Ensemble_0.png";
        filepath = Global.circulation_figures_location+"/201309/20130911/20130911_Ensemble_0.png";
        //Logger logger = Logger.
        //20130911_t_Ensemble_0.png 
        System.out.println("trying to access: "+filepath);

                
		File file = new File(filepath);
		
		if (!file.exists())	
		{
			response.getWriter().write("fail");
			return;
		}
		// Open the file and output streams
	    FileInputStream in = new FileInputStream(file);
    
	    // Copy the contents of the file to the output stream
	    byte[] buf = new byte[2048];
	    int count = 0;
	    ServletOutputStream sout= response.getOutputStream();
	    while ((count = in.read(buf)) >= 0) {
	        sout.write(buf, 0, count);
	    }
	    
	    
	    in.close();    
	    sout.close();
		

	}

}
