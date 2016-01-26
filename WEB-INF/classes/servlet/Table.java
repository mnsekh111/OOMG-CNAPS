package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Table extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public Table() {
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
		String year=request.getParameter("year");
		String month=request.getParameter("month");
		String day=request.getParameter("day");
		String files=request.getParameter("files");
		
		String base_url="http://omglnx6.meas.ncsu.edu/sabgom_nfcast/"+
							year+month+"/"+
							year+month+day+"/";
		
		String[] file_name=files.split(",");
		
		int[] isFileExist=new int[file_name.length];
		
		URL url;
		int i=0;
		for(String name: file_name){

			url=new URL(base_url+name);
			URLConnection conn=url.openConnection();
			if(	conn.getHeaderField(0).contains("200"))		//File exists
				isFileExist[i]=1;
			else
				isFileExist[i]=0;
			
			i++;
		}		
		for(int f:isFileExist){
			out.print(f);
		}
		out.flush();
		out.close();
	}

}
