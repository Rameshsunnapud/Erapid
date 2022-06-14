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
	<SCRIPT LANGUAGE="JavaScript">
		function sendThis(){
			var variables="";
			//alert(document.errorForm.vn.value);
			variables="vn="+document.errorForm.vn.value+"&vc="+document.errorForm.vc.value+"&in="+document.errorForm.inn.value+"&pc="+document.errorForm.pc.value+"&pu="+document.errorForm.pu.value+"&pn="+document.errorForm.pn.value+"&message="+document.errorForm.message.value;
			//alert(variables);
			document.location.href="is_group_code_maint_edit.jsp?"+variables;
		}
	</script>

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
	String message="";
	boolean noGood=false;
	if(!(CCDESC != null) || CCDESC.trim().length()==0){
		noGood=true;
		message=message+" Description,";
	}

	//if(!(contactEmail != null) || contactEmail.trim().length()==0){
	//	noGood=true;
	//	message=message+" ContactEmail,";
	//}

	if(noGood){
		message = "Please enter a proper "+message;
		out.println("<body onload='javascript:sendThis();'>");
		out.println("<form name='errorForm'>");
		out.println("<input type='hidden' name='cd' value='"+CCDESC+"'>");
		out.println("<input type='hidden' name='co' value='"+COMPANIES+"'>");
		out.println("<input type='hidden' name='re' value='"+REGION+"'>");
		out.println("<input type='hidden' name='no' value='"+NOTES+"'>");
		out.println("<input type='hidden' name='hq' value='"+HDQTS+"'>");
		out.println("<input type='hidden' name='cs' value='"+CUST_SHIPPING_NO+"'>");
		out.println("<input type='hidden' name='cc' value='"+CCODE+"'>");
		out.println("<input type='hidden' name='message' value='"+message+"'>");
		out.println("<input type='hidden' name='cmd' value='"+cmd+"'>");
		out.println("<input type='hidden' name='type' value='"+type+"'>");
		out.println("<input type='hidden' name='group1' value='"+group1+"'>");
		out.println("</form>");
	}
	else{
	myConn.setAutoCommit(false);
		out.println("<body>");
		try
		{
		String insert ="update cs_ge_group_codes set COMPANIES=?,REGION=?,NOTES=?,HDQTS=?,CUST_SHIPPING_NO=?,CCODE=? WHERE CCDESC=?";
		PreparedStatement update_sbu = myConn.prepareStatement(insert);
				update_sbu.setString(1, COMPANIES);
				update_sbu.setString(2, REGION);
				update_sbu.setString(3, NOTES);
				update_sbu.setString(4, HDQTS);
				update_sbu.setString(5, CUST_SHIPPING_NO);
				update_sbu.setString(6, CCODE);
				update_sbu.setString(7, CCDESC);
				int rocount = update_sbu.executeUpdate();
				update_sbu.close();
		}
		catch (java.sql.SQLException e)
		{
			out.println("Problem with Updating group codes TABLE"+"<br>");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}


	myConn.commit();
	stmt.close();
	myConn.close();
	out.println("Edit complete<BR>");
	%>
	<jsp:include page="is_group_code_maint.jsp" flush="true">
		<jsp:param name="cmd" value="<%= cmd%>"/>
		<jsp:param name="type" value="<%= type%>"/>
		<jsp:param name="group1" value="<%= group1%>"/>
	</jsp:include>
	<%
	}
	%>
</body>
</html>
<%
}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>