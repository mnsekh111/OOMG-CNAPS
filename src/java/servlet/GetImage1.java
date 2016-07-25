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

public class GetImage1 extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public GetImage1() {
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
		depth=request.getParameter("depth");
                
        reqtype = request.getParameter("reqtype");
		
                String filepath = null;
                
            if( reqtype == "yizhen")
            {
               filepath = Global.yizhen_figures_location+"/"+"track_sabgom_ltrans_floats_NF_"
											+day+".png";
			}
            else if( reqtype == "zxue_validation")
                {
                    filepath = Global.figures_location+"/"
                    +day.substring(0,6)+"/"
                    +day+"/"+"HF/longbay/"
                    +date+"_"+"hfuv"+".png";
                }
            else if( reqtype == "zxue")
                {
                    filepath = Global.figures_location+"/"
                    +day.substring(0,6)+"/"
                    +day+"/"
                    +date+"_"+variable+"_"+depth+".png";
                }
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