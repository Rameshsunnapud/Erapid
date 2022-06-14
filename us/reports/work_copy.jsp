<%
		String order_no = request.getParameter("q_no");//Login id
		String tp = request.getParameter("tp");//Login id
//		String type= request.getParameter("type");//type
		String total=request.getParameter("total");
%>
<%@ page language="java" import="java.net.*" import="java.sql.*" import="java.io.*" errorPage="error.jsp" %>
<%@ include file="db_con.jsp"%>
<% String product="";URL output_st =null;
ResultSet rs_project = stmt.executeQuery("SELECT product_id FROM cs_project where Order_no like '"+order_no+"'");s
if (rs_project !=null) {
	while (rs_project.next()) { 
		product= rs_project.getString("product_id");
	}
}
rs_project.close();  
stmt.close();   
myConn.close();
if(!product.equals("LVR")){
	if(product.equals("EFS")){ 
		output_st =new URL("https://"+ application.getInitParameter("HOST")+"/word_quotes/show_quotes.asp?q_no="+order_no+"");
	}
	else{
		output_st =new URL("https://"+ application.getInitParameter("HOST")+"/erapid/us/show_quotes.jsp?q_no="+order_no+"&type=1&tp="+tp+"&total="+total);
	}
}
URL output_st1 = new URL("https://"+ application.getInitParameter("HOST")+"/erapid/us/show_summary.jsp?order_no="+order_no+"&pid=2");
//out.println(output_st+"<br>::"+output_st1);
if(!product.equals("LVR")){
	try{ 
		BufferedReader in = new BufferedReader(	new InputStreamReader(output_st.openStream()));
		String inputLine; 
		while ((inputLine = in.readLine()) != null){
			out.println(inputLine); 
		}
		in.close();
	}
	catch(Exception E){
		out.println(" error :::"+E);
	}

	out.println("<p style='page-break-after : always;' >&nbsp;</p>");
}
BufferedReader in1 = new BufferedReader(new InputStreamReader(output_st1.openStream()));
String inputLine1;
while ((inputLine1 = in1.readLine()) != null){
	out.println(inputLine1);
}
in1.close(); 
%>

