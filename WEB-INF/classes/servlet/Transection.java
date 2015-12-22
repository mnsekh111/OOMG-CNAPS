package servlet;

import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;

import javax.imageio.ImageIO;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import util.*;

public class Transection extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public Transection() {
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
		
		String dir=Global.dir+"transect/";
		String ID=RandomID.getID();

		
		String imagename=dir+Global.output_section+ID+Global.output_section_type;
		
		String lon1,lon2,lat1,lat2,vname,date,time;

		vname=request.getParameter("vname");
		lon1=request.getParameter("lon1");
		lat1=request.getParameter("lat1");
		lon2=request.getParameter("lon2");
		lat2=request.getParameter("lat2");
		date=request.getParameter("date");
		time=request.getParameter("time");
		

		
		ServletContext sc = getServletContext();

		
		try{
			FileWriter f_vname=new FileWriter(dir+Global.input_section_1+ID);
			f_vname.write(vname+"\n");
			f_vname.close();
			
			FileWriter f_lon_lat_sectoin=new FileWriter(dir+Global.input_section_2+ID);
			f_lon_lat_sectoin.write(lon1+" "+lat1+"\n");
			f_lon_lat_sectoin.write(lon2+" "+lat2+"\n");
			f_lon_lat_sectoin.close();
			
			FileWriter f_sectiontime=new FileWriter(dir+Global.input_section_3+ID);
			f_sectiontime.write(date.substring(0, 4)+" "+date.substring(4, 6)+" "+date.substring(6)+" "+time+"\n");
			f_sectiontime.close();
			
			int timeout=0;
			String line;
			Process p = Runtime.getRuntime().exec("bash "+Global.bash_section+" "+ID, null, new File(dir));
			
			
			
			
		     BufferedReader reader_e =
		          new BufferedReader
		            (new InputStreamReader(p.getErrorStream()));
		        while ((line = reader_e.readLine()) != null ) {
		        		//Thread.sleep(1000);
		        	//new Log().log(line);
		        		timeout++;
		        		//System.out.println(line);
		        }
			
			
			
		     BufferedReader reader =
	          new BufferedReader
	            (new InputStreamReader(p.getInputStream()));
	        while ((line = reader.readLine()) != null ) {
	        		//Thread.sleep(1000);
	        		timeout++;
	        		System.out.println(line);
	        }
	        
			p.waitFor();

//	        
//
//	        
	    reader.close();

//		    if (timeout==Global.MaxTimeout){
//		    	//p.destroy();
//			    BufferedWriter writer= new BufferedWriter(new OutputStreamWriter(p.getOutputStream()));
//			    writer.write("exit\n");
//			    writer.close();
//		    	return;
//		    }
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		
		 
		
	 // Get the MIME type of the image
	    String mimeType = sc.getMimeType(imagename);
	    if (mimeType == null) {
	        sc.log("Could not get MIME type of "+imagename);
	        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	        return;
	    }
	    
	 // Set content type
	    response.setContentType(mimeType);

	    // Set content size
	    
	    
	    File file = new File(imagename);
	    
	    //busy waiting for the image
	    int timeout=0;
	    while(!file.exists() && timeout<Global.MaxTimeout )
	    {
	    	try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
	    	timeout++;
	    }
	    if (timeout>=Global.MaxTimeout)	return;
	    
	    response.setContentLength((int)file.length());

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

	    
	    //new File(dir+Global.input_section_1+ID).delete();
	    //new File(dir+Global.input_section_2+ID).delete();
	    //new File(dir+Global.input_section_3+ID).delete();

	    
	    //file.delete();
	    
	    sout.close();
	    
	    
		
		
		
	}

}
