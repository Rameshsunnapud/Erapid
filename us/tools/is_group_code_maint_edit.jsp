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
				document.location.href="is_group_code_maint.jsp?cmd="+document.editForm.cmd.value+"&type="+document.editForm.type.value+"&group1="+document.editForm.group1.value;
			}
		</script>
		<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con.jsp"%>
		<%
		String CCDESC=request.getParameter("cd");
		String COMPANIES=request.getParameter("co");
		String REGION=request.getParameter("re");
		String NOTES=request.getParameter("no");
		String HDQTS=request.getParameter("hq");
		String CUST_SHIPPING_NO=request.getParameter("cs");
		String CCODE=request.getParameter("cc");
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
		out.println("<form name='editForm' action='is_group_code_maint_edit_save.jsp' onsubmit='return checkThis()'>");
		out.println("<input type='hidden' name='cmd' value='"+cmd+"'>");
		out.println("<input type='hidden' name='type' value='"+type+"'>");
		out.println("<input type='hidden' name='group1' value='"+group1+"'>");
		out.println("<table border='1'><tr><td>Description</td><td>Companies</td><td>Region</td><td>Notes</td><td>Headquarters</td><td>Customer Number</td><td>CCode</td></tr>");
		out.println("<tr><td><input type='text' name='CCDESC' value='"+CCDESC+"'size='30' readonly></td>");
		out.println("<td><input type='text' name='COMPANIES' size='30' value='"+COMPANIES+"' ></td>");
		out.println("<td><input type='text' name='REGION' size='4' value='"+REGION+"' ></td>");
		out.println("<td><input type='text' name='NOTES' size='40' value='"+NOTES+"'></td>");
		out.println("<td><input type='text' name='HDQTS' size='4' value='"+HDQTS+"'></td>");
		out.println("<td><input type='text' name='CUST_SHIPPING_NO' size='12' value='"+CUST_SHIPPING_NO+"'></td>");
		out.println("<td><input type='text' name='CCODE' size='30' value='"+CCODE+"'></td>");
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