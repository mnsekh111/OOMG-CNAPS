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
		
		String day,hfdate,variable,depth,areanum, reqtype;
		day=request.getParameter("day");
		hfdate=request.getParameter("hfdate");
		areanum=request.getParameter("areanum");
		
                String filepath = null;
            
                    filepath = Global.circulation_figures_location+"/"
                    +day.substring(0,6)+"/"
                    +day+"/HF/"
                    +hfdate+"_hfuv_"+areanum+".png";
                
		File file = new File(filepath);
		
		if (!file.exists())	
		{
			response.getWriter().write("fail");
			response.getWriter().write(filepath);
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
