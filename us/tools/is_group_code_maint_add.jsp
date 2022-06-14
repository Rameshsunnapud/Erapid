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
		<title>IS Group Codes</title>
		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>
	<body>
		<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con.jsp"%>
		<%
		String CCDESC=request.getParameter("CCDESC");
		String COMPANIES=request.getParameter("COMPANIES");
		String REGION=request.getParameter("REGION");
		String NOTES=request.getParameter("NOTES");
		String HDQTS=request.getParameter("HDQTS");
		String CUST_SHIPPING_NO=request.getParameter("CUST_SHIPPING_NO");
		String CCODE=request.getParameter("CCODE");
		String cmd=request.getParameter("cmd");
		String type=request.getParameter("type");
		String group1=request.getParameter("group1");
		//out.println(cmd+"<-->"+type+"<-->"+group1+"<BR>");
		int rowCount=0;
		ResultSet rs=stmt.executeQuery("select count(*) from cs_ge_group_codes where CCDESC='"+CCDESC+"'");
		if(rs !=null){
			while(rs.next()){
				rowCount=rs.getInt(1);
			}
		}
		rs.close();
		if(rowCount == 0){
			myConn.setAutoCommit(false);
			try{
				String updateString ="INSERT INTO cs_ge_group_codes (CCDESC,COMPANIES,REGION,NOTES,HDQTS,CUST_SHIPPING_NO,CCODE)VALUES(?,?,?,?,?,?,?) ";
				java.sql.PreparedStatement updateSBU = myConn.prepareStatement(updateString);
				updateSBU.setString(1,CCDESC);
				updateSBU.setString(2,COMPANIES);
				updateSBU.setString(3,REGION);
				updateSBU.setString(4,NOTES);
				updateSBU.setString(5,HDQTS);
				updateSBU.setString(6,CUST_SHIPPING_NO);
				updateSBU.setString(7,CCODE);
				int rocount=updateSBU.executeUpdate();
				updateSBU.close();
			}
			catch (java.sql.SQLException e){
				out.println("Problem with entering into cs_ge_group_codes");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
			myConn.commit();
		}
		else{
			out.println("<font color='red'>You have tried to enter a part number that already exists in the database.<br>");
			out.println("Please try again</font><BR>");
		}
		stmt.close();
		myConn.close();
		out.println("Add complete<BR>");
		%>
		<jsp:include page="is_group_code_maint.jsp?" flush="true">
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