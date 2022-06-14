<html>
<head>
<title>GE MAINENANCE</title>
<link rel='stylesheet' href='style1.css' type='text/css' />
</head>
<script language="JavaScript">
function initSelectedNotes( ) {
	this.moveTo(0, 0);
	this.resizeTo(screen.width, screen.height);
}
function forwarding(){
	alert("here");
	document.location.href='bpcsItems.jsp';
}
function forwarding2(){
	alert("here2");
	document.location.href='bpcs_group_codes.jsp'
}
function closethis(){
	this.close();
}
</script>
<body onload='initSelectedNotes()'>
<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.lang.*" errorPage="error.jsp" %>
<%//@ include file="db_con.jsp"%>
<%
out.println(" <center><font color='336699' size='3'><b>WELCOME TO GE MAINTENANCE</b></font><center><BR><BR><BR>");
out.println("<table width='100%'><tr><td align='center'><input type='button' name='x' onclick='forwarding()' value='Click to run GE Vendor Items Update*'></td><td align='center'><input type='button' name='x2' onclick='forwarding2()' value='Click to run GE Group Code Update*'></td></tr>");
out.println("<tr><td colspan='2' align='center'><input type='button' name='x3' onclick='closethis()' value='CLOSE' ></td></tr>");
out.println("<tr><td colspan='2' align='center'>*Please note that these scripts will take a few moments to run</td></tr>");
%>
</table>
</body>
</html>