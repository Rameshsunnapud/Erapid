<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>

<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<%@ page language="java" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" errorPage="error.jsp" %>
<%@ include file="../../db_con.jsp"%>
<%@ include file="../../dbcon1.jsp"%>
<%
String order_no=request.getParameter("order_no");
//HttpSession UserSession1 = request.getSession();
//String name=UserSession1.getAttribute("username").toString();

	String name=userSession.getUserId();




String email="";
String rep_no="";
if(name != null && !name.equals("null") && name.trim().length()>0){
	ResultSet rs0=stmt.executeQuery("select rep_no from cs_reps where user_id='"+name+"'");
	if(rs0 != null){
		while(rs0.next()){
			rep_no=rs0.getString(1);
		}
	}
	rs0.close();
	if(rep_no != null && !rep_no.equals("null") && rep_no.trim().length()>0){
		ResultSet rs1=stmt.executeQuery("select email from cs_reps where rep_no='"+rep_no+"'");
		if(rs1 != null){
			while(rs1.next()){
				if(rs1.getString(1) != null && rs1.getString(1).trim().length()>0){
					email=rs1.getString(1);
				}
			}
		}
		rs1.close();
	}
}
//out.println(name+"::"+rep_no+"::"+email);
out.println("<form name='selectform' action='ads_change_order.jsp' method='post'>");
out.println("<input type='text' name='email' value='"+email+"'>");
out.println("<input type='hidden' name='order_no' value='"+order_no+"'>");
out.println("<input type='submit' name='go' value='go'>");
out.println("</form>");

stmt.close();
stmts.close();
myConn.close();
myConns.close();
 }
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>