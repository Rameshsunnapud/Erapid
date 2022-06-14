<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<%
//if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
//        erapidBean.setServerName("server1");
//}
try{

%>
<html>
	<head>
		<title>SBU Contacts</title>
		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>
	<body>
		<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con.jsp"%>
		<%
		String repNo=request.getParameter("rn");
		String productId=request.getParameter("pi");
		String contactName=request.getParameter("cn");
		String contactEmail=request.getParameter("ce");
		String cmd=request.getParameter("cmd");
		String type=request.getParameter("type");
		String group1=request.getParameter("group1");
		//out.println(cmd+"<-->"+type+"<-->"+group1+"<BR>");
		myConn.setAutoCommit(false);
		try{
			stmt.executeUpdate("delete from cs_sbu_contacts where rep_no='"+repNo+"' and product_id='"+productId+"'");
		}
		catch (java.sql.SQLException e){
			out.println("Problem with deleting from cs_sbu_cotnacts table");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}
		myConn.commit();
		stmt.close();
		myConn.close();
		out.println("delete complete");
		%>
		<jsp:include page="sbu_contact_maint.jsp" flush="true">
			<jsp:param name="cmd" value="<%= cmd%>"/>
			<jsp:param name="type" value="<%= type%>"/>
			<jsp:param name="group1" value="<%= group1%>"/>
		</jsp:include>
	</body>
</html>
<%
}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>