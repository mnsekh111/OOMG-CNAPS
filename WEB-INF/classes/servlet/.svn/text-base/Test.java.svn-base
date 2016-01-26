package servlet;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.Global;
import util.Log;

public class Test extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public Test() {
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
		Log log=new Log();

		
		
		
		try{
		log.log("1");
		
		Process p = Runtime.getRuntime().exec("bash test.bash", null, new File("/raid0/fchen"));		
		log.log("2");
		String line;
		String l="";
	     BufferedReader reader =
	          new BufferedReader
	            (new InputStreamReader(p.getInputStream()));
	        while ((line = reader.readLine()) != null ) {
	        		//Thread.sleep(1000);
       			//log.log("input "+line);
       			l+=line;
	        }
		log.log("input "+l);
	        
	     BufferedReader reader_e =
	          new BufferedReader
	            (new InputStreamReader(p.getErrorStream()));
	        while ((line = reader_e.readLine()) != null ) {
	        		//log.log("error "+line);
	        		l+=line;
	        }
	        log.log("error "+l);
	        		        
		p.waitFor();
  
   reader.close();
   reader_e.close();

//	    if (timeout==Global.MaxTimeout){
//	    	//p.destroy();
//		    BufferedWriter writer= new BufferedWriter(new OutputStreamWriter(p.getOutputStream()));
//		    writer.write("exit\n");
//		    writer.close();
//	    	return;
//	    }
	}catch(Exception e)
	{
			new Log().log("Exception"+e.getMessage());				
	}
	
	log.log("3");
	
	}


}
