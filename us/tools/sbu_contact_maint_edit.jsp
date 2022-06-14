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
		<SCRIPT LANGUAGE="JavaScript">
			function checkThis(){
				var fRet;
				fRet=confirm('Are you sure?');
				if(fRet){
					return true;
				}
				else{
					return false;
				}
			}
			function goback(){
				document.location.href="sbu_contact_maint.jsp?cmd="+document.editForm.cmd.value+"&type="+document.editForm.type.value+"&group1="+document.editForm.group1.value;
			}
		</script>
		<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con.jsp"%>
		<%
		String repNo=request.getParameter("rn");
		String contactName=request.getParameter("cn");
		String contactEmail=request.getParameter("ce");
		String optio_email=request.getParameter("oe");
		//String sales_email=request.getParameter("se");
		String sample_email=request.getParameter("sample");
		String productId=request.getParameter("pi");
		String errorMessage=request.getParameter("message");
		String cmd=request.getParameter("cmd");
		String type=request.getParameter("type");
		String group1=request.getParameter("group1");
		//out.println(cmd+"<-->"+type+"<-->"+group1+"<BR>");
		if(errorMessage != null && errorMessage.length()>0){
			out.println("<font color='red'> "+errorMessage+"</font><BR>");
		}
		//if(sales_email==null || sales_email.equals("null")){
		//	sales_email="";
		//}
		out.println("<form name='editForm' action='sbu_contact_maint_edit_save.jsp' onsubmit='return checkThis()'>");
		out.println("<input type='hidden' name='cmd' value='"+cmd+"'>");
		out.println("<input type='hidden' name='type' value='"+type+"'>");
		out.println("<input type='hidden' name='group1' value='"+group1+"'>");
		out.println("<table border='1'><tr><td>Rep #</td><td>Product Id</td><td>Contact Name</td><td>Contact Email</td><td>Optio Email</td><td>Sample Email</td></tr>");
		out.println("<tr><td><input type='text' name='repNo' value='"+repNo+"'size='10' readonly></td>");
		out.println("<td><input type='text' name='productId' size='10' value='"+productId+"' readonly></td>");
		out.println("<td><input type='text' name='contactName' size='30' value='"+contactName+"' ></td>");
		out.println("<td><input type='text' name='contactEmail' size='30' value='"+contactEmail+"'></td>");
		out.println("<td><input type='text' name='optio_email' size='30' value='"+optio_email+"'></td>");
		//out.println("<td><input type='text' name='sales_email' size='30' value='"+sales_email+"'></td>");
		out.println("<td><input type='text' name='sample_email' size='30' value='"+sample_email+"'></td>");
		out.println("<td><input type='submit' value='submit' class='button'></td>");
		out.println("<td><input type='button' value='cancel' onclick='goback()' class='button'></tr>");
		out.println("</form>");
		stmt.close();
		myConn.close();
		%>
	</body>
</html>
<%
}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>