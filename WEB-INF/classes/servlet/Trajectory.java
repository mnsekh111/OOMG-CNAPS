package servlet;

import java.io.BufferedInputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;
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
	throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		List<String>lonlats =new LinkedList<String>();
		int n=Integer.valueOf( request.getParameter("n"));

		//		for(int i=0;i<Integer.valueOf(n);i++){
		//			out.print(request.getParameter("lon"+String.valueOf(i)));
		//			out.print(" ");
		//			out.print(request.getParameter("lat"+String.valueOf(i)));
		//			out.println();
		//		}

		if (n<1) return ;

		String ID=RandomID.getID();
        String dir = Global.dir+"trajectory/";
		
		FileWriter input=new FileWriter(dir+Global.input_drift+ID);
		
		for (int i=0;i<n;i++){
			input.write(request.getParameter("lon"+String.valueOf(i)));
			input.write(" ");
			input.write(request.getParameter("lat"+String.valueOf(i)));
			input.write("\n");
		}
		input.close();
		
		Process p;

		try{
			String line;
			 p=Runtime.getRuntime().exec("bash "+Global.bash_drift+" "+ID,null,new File(dir));
		      BufferedReader reader =
		          new BufferedReader
		            (new InputStreamReader(p.getInputStream()));
		        while ((line = reader.readLine()) != null ) {
		        		//new Log().log(line);
		        		if (line=="end\n")
		        			break;
		        		//Thread.sleep(1000);
		        }
		        
/*			 BufferedReader reader_e =
			          new BufferedReader
			            (new InputStreamReader(p.getErrorStream()));
			        while ((line = reader_e.readLine()) != null ) {
			        		new Log().log("error "+line);
			        }*/
		        
		    reader.close();
		   // reader_e.close();
/*		    if (timeout==Global.MaxTimeout){
		    	//p.destroy();
			    BufferedWriter writer= new BufferedWriter(new OutputStreamWriter(p.getOutputStream()));
			    writer.write("exit\n");
			    writer.close();
		    	return;
		    }*/

		}catch(Exception e){
			new Log().log(e.getMessage());
			
			return;
		}

		File file=new File(dir+Global.output_drift+ID+Global.output_drift_type);

		
/*	
 * This snippet of code is WRONG because the existence of output file doesn't mean all the result have been computed and written to the file 
 * 	
 		int timeout=0;
		while(!file.exists() && timeout<Global.MaxTimeout )
		{
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			timeout++;
			new Log().log(String.valueOf(timeout));
		}
		if (timeout>=Global.MaxTimeout)	
		{
		    BufferedWriter writer= new BufferedWriter(new OutputStreamWriter(p.getOutputStream()));
		    writer.write("exit\n");
		    writer.close();
			return;			
		}*/
		

		response.setContentLength((int)file.length());
		//new Log().log("length "+String.valueOf(file.length()));

		BufferedReader br=new BufferedReader(new FileReader(file));
		String line;
		Pattern p1=Pattern.compile("(\\S+)\\s+(\\S+)\\s+");

		while((line=br.readLine())!=null){
			//new Log().log("line "+line);
			if (line.length()==0)
				out.println();
			else
			{
				Matcher matcher= p1.matcher(line);
				if (matcher.find()){
					//			    for (int i=1; i<=matcher.groupCount(); i++) {
					//			        String groupStr = matcher.group(i);
					//			        out.print(groupStr+" ");
					//			    }
					out.print(matcher.group(1)+",");
					out.print(matcher.group(2)+";");
				}
			}
			
		}


		br.close();
		
		//new File(dir+Global.input_drift+ID).delete();
		//file.delete();


		out.flush();
		out.close();

		/*
		String lon1,lat1;
		lon1=request.getParameter("lon1");
		lat1=request.getParameter("lat1");

		FileWriter input=new FileWriter(dir+Global.input_tracking);
		input.write(lon1+" "+lat1+"\n");
		input.close();

		try{
		Process p = Runtime.getRuntime().exec("bash "+Global.bash_tracking, null, new File(dir));
		}catch (Exception e){
			out.println("Process error");
			out.println(e);
		}

		File file=new File(dir+Global.output_tracking);

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
	    if (timeout>=Global.MaxTimeout)	
	    	return;

	    response.setContentLength((int)file.length());

	    BufferedReader br=new BufferedReader(new FileReader(file));
	    String line;
	    Pattern p=Pattern.compile("(\\S+)\\s+(\\S+)\\s+");

	    while((line=br.readLine())!=null){
	    		Matcher matcher= p.matcher(line);
				if (matcher.find()){
//				    for (int i=1; i<=matcher.groupCount(); i++) {
//				        String groupStr = matcher.group(i);
//				        out.print(groupStr+" ");
//				    }
				    out.print(matcher.group(1)+" ");
				    out.println(matcher.group(2));
				}

	    }


	    br.close();
	    file.delete();


	    out.flush();
		out.close();

		 */
	}

}
