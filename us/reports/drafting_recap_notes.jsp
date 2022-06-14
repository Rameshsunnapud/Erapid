<HTML>
<HEAD>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE>Recap Notes</TITLE>
<link rel='stylesheet' href='style1.css' type='text/css' />
</HEAD>
<body><form name='form1' action='drafting_recap_notes_save.jsp'>
<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.io.*" errorPage="error.jsp" %>
<%@ include file="db_con.jsp"%>
<%
String order_nos=request.getParameter("order_no");
String line_no=request.getParameter("line_no");
Vector order_no=new Vector();
if(order_nos != null && order_nos.trim().length()>0 && line_no != null && line_no.trim().length()>0){
	order_nos="'"+order_nos.replaceAll(",","','")+"'";
	out.println("<table width='100%'><tr><td>Order Number</td><td>Note</td><td>Note2</td></tr>");
	//out.println(order_nos+"::<BR>");


	ResultSet rs0=stmt.executeQuery("select order_no from cs_project where order_no in("+order_nos+") order by order_no");
	if(rs0 != null){
		while(rs0.next()){
			order_no.addElement(rs0.getString(1));
		}
	}
	rs0.close();
	for(int i=0; i<order_no.size(); i++){
		String value="";
		ResultSet rs1=stmt.executeQuery("select descript from csquotes where order_no = '"+order_no.elementAt(i).toString()+"' and line_no='"+line_no+"' and block_id='d_notes' and sequence_no='41' order by order_no");
		if(rs1 != null){
			while(rs1.next()){
				value=rs1.getString(1);
			}
		}
		rs1.close();
		out.println("<tr><td>"+order_no.elementAt(i).toString()+"<input type='hidden' name='order_no' value='"+order_no.elementAt(i).toString()+"'></td><td><input type='text' size='75' name='notes' value='"+value+"'></td>");
		value="";
		ResultSet rs2=stmt.executeQuery("select descript from csquotes where order_no = '"+order_no.elementAt(i).toString()+"' and line_no='"+line_no+"' and block_id='d_notes' and sequence_no='40' order by order_no");
		if(rs2 != null){
				while(rs2.next()){
					value=rs2.getString(1);
				}
			}
		rs2.close();
		out.println("<td><input type='text' size='75' name='notes2' value='"+value+"'></td></tr>");
	}
	out.println("</table>");
	out.println("<input type='hidden' name='line_no' value='"+line_no+"'>");
	out.println("<center><input type='submit' name='save' value='save'></center>");
}
stmt.close();
myConn.close();
%>
</form>
</body>
</html>