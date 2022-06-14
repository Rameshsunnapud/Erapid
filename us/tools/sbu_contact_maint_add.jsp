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
		String repNo=request.getParameter("repNo");
		String productId=request.getParameter("productId");
		String contactEmail=request.getParameter("contactEmail");
		String contactName=request.getParameter("contactName");
		String optio_email=request.getParameter("optio_email");
		//String sales_email=request.getParameter("sales_email");
		String sample_email=request.getParameter("sample_email");
		String cmd=request.getParameter("cmd");
		String type=request.getParameter("type");
		String group1=request.getParameter("group1");
		//out.println(cmd+"<-->"+type+"<-->"+group1+"<BR>");
		int rowCount=0;
		ResultSet rs=stmt.executeQuery("select count(*) from cs_sbu_contacts where rep_no='"+repNo+"' and product_id='"+productId+"'");
		if(rs !=null){
			while(rs.next()){
				rowCount=rs.getInt(1);
			}
		}
		rs.close();
		if(rowCount == 0){
			myConn.setAutoCommit(false);
			try{
				String updateString ="INSERT INTO cs_sbu_contacts (rep_no,contact_name,contact_email,product_id,optio_email,prod_sample_contact)VALUES(?,?,?,?,?,?) ";
				java.sql.PreparedStatement updateSBU = myConn.prepareStatement(updateString);
				updateSBU.setString(1,repNo);
				updateSBU.setString(2,contactName);
				updateSBU.setString(3,contactEmail);
				updateSBU.setString(4,productId);
				updateSBU.setString(5,optio_email);
				//updateSBU.setString(6,sales_email);
				updateSBU.setString(6,sample_email);
				int rocount=updateSBU.executeUpdate();
				updateSBU.close();
			}
			catch (java.sql.SQLException e){
				out.println("Problem with entering into cs_sbu_contacts table");
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
		<jsp:include page="sbu_contact_maint.jsp?" flush="true">
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