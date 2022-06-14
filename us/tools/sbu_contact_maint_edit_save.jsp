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
	<SCRIPT LANGUAGE="JavaScript">
		function sendThis(){
			var variables="";
			//alert(document.errorForm.vn.value);
			variables="vn="+document.errorForm.vn.value+"&vc="+document.errorForm.vc.value+"&in="+document.errorForm.inn.value+"&pc="+document.errorForm.pc.value+"&pu="+document.errorForm.pu.value+"&pn="+document.errorForm.pn.value+"&message="+document.errorForm.message.value;
			//alert(variables);
			document.location.href="sbu_contact_maint_edit.jsp?"+variables;
		}
	</script>

	<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
	<%@ include file="../../../db_con.jsp"%>
	<%
	String repNo=request.getParameter("repNo");
	String contactName=request.getParameter("contactName");
	String contactEmail=request.getParameter("contactEmail");
	String optio_email=request.getParameter("optio_email");
	//String sales_email=request.getParameter("sales_email");
	String sample_email=request.getParameter("sample_email");
	String productId=request.getParameter("productId");
	String cmd=request.getParameter("cmd");
	String type=request.getParameter("type");
	String group1=request.getParameter("group1");
	//out.println(cmd+"<-->"+type+"<-->"+group1+"<BR>");
	String message="";
	boolean noGood=false;
	if(!(contactName != null) || contactName.trim().length()==0){
		noGood=true;
		message=message+" Contact Name,";
	}

	if(!(contactEmail != null) || contactEmail.trim().length()==0){
		noGood=true;
		message=message+" ContactEmail,";
	}

	if(noGood){
		message = "Please enter a proper "+message;
		out.println("<body onload='javascript:sendThis();'>");
		out.println("<form name='errorForm'>");
		out.println("<input type='hidden' name='rn' value='"+repNo+"'>");
		out.println("<input type='hidden' name='cn' value='"+contactName+"'>");
		out.println("<input type='hidden' name='ce' value='"+contactEmail+"'>");
		out.println("<input type='hidden' name='oe' value='"+optio_email+"'>");
		//out.println("<input type='hidden' name='se' value='"+sales_email+"'>");
		out.println("<input type='hidden' name='sample' value='"+sample_email+"'>");
		out.println("<input type='hidden' name='pi' value='"+productId+"'>");
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
		String insert ="update cs_sbu_contacts set contact_name=?,contact_email=?,optio_email=?,prod_sample_contact=? WHERE rep_no=? and product_id=?";
		PreparedStatement update_sbu = myConn.prepareStatement(insert);
				update_sbu.setString(1, contactName);
				update_sbu.setString(2, contactEmail);
				update_sbu.setString(3, optio_email);
				//update_sbu.setString(4, sales_email);
				update_sbu.setString(4, sample_email);
				update_sbu.setString(5, repNo);
				update_sbu.setString(6, productId);
				int rocount = update_sbu.executeUpdate();
				update_sbu.close();
		}
		catch (java.sql.SQLException e)
		{
			out.println("Problem with Updating sbu contact TABLE"+"<br>");
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
	<jsp:include page="sbu_contact_maint.jsp" flush="true">
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