<%@ page isErrorPage = "true" import="java.io.*" import="java.util.*" contentType="text/html"%>
<html>
<head>
<title>Error</title>
<link rel='stylesheet' href='style1.css' type='text/css' />
</head>
<script language="JavaScript" >
function noSession() {
	alert(" You session may have expired.  If you have been sitting on one page for more than 30 minutes, please click the Restart button.  Session expired time is 30 minutes.");
	//window.opener=top;
	//var popurl="login.html";
	//var props = 'scrollBars=yes,resizable=yes,toolbar=yes,menubar=yes,location=yes,directories=yes';
	//winpops=window.open(popurl,"",props);
	//window.close();
}
function noSession2() {
	//alert(" Session has expired.  You will be redirected to the login page.  Session expired time is 30 minutes.");
	window.opener=top;
	var popurl="login.html";
	var props = 'scrollBars=yes,resizable=yes,toolbar=yes,menubar=yes,location=yes,directories=yes';
	winpops=window.open(popurl,"",props);
	window.close();
}
</script> 
<%
String body="";
String username="";
HttpSession UserSession = request.getSession();
if (UserSession.getValue("username")==null){
	body=" onload='noSession()'";
}
else{
	body="";
	username=UserSession.getValue("username").toString();
}
String msg=request.getParameter("msg");
if(msg==null ||msg.equals("null")){
	msg="";
}

%>
<body <%= body%>>
<h1> Error page</h1>
<INPUT TYPE="button" VALUE="Go Back" onClick="history.go(-1);return true;">
<INPUT TYPE="button" VALUE="Restart system" onClick='noSession2()'>
<input type='button' value='email Erapid Support' onclick='document.location.href="error_email.jsp?username=<%=username%>"'><BR>
<font size='3'><b>Sorry for the inconvenience.  The system has encountered an error.</font><BR><BR>
<font size='3'><b>Please try the following:<BR>
- click the 'Refresh' browser button or hit the 'F5' key,<BR>
- go Back and try the action again.<BR></font>
<font color='red' size='3'>If you still get the error and you can spare a couple of minutes please keep this page open and contact the CS Group I.T. Department.</b></font><BR>
<font color='red' size='3'>If you wish, please use the email button above. Be as detailed as you can. Do not forget to include the quote number. Thank you.</b></font><BR>
<BR>
<font size='6' color='red'><%=msg%></font><BR>
<strong><font size='3'>eRapid Help Contact Information:</font></strong><br><p algin='center'><table border="1" cellspacing="0" cellpadding="0" align="center" bordercolor="#000000" algin="center" width='100%'><tr>
 <td><h1>Contact</h1></td>
 <td><h1>Phone</h1></td>
 <td><h1>eMail</h1></td>
 </tr>
<tr>
 <td>Greg Suisham</td>
 <td>908-849-3778</td>
 <td>gsuisham@c-sgroup.com</td>
 </tr>
<tr>
 <td>Arthur Cosma</td>
 <td>908-849-3737</td>
 <td>acosma@c-sgroup.com</td>
 </tr>
<tr>
 <td>Sabina Zabiega</td>
 <td>908-849-7766</td>
 <td>szabiega@c-sgroup.com</td>
 </tr>
 </table>
 </div>
</p>
</HTML>

&nbsp;&nbsp;&nbsp;&nbsp;<%=exception %><br>
<table border="1">
<tr>
	<th colspan="2">Request Attribute </th>
</tr>
<%
   Enumeration Attribute1= request.getAttributeNames();
   while (Attribute1.hasMoreElements()){
   String name=(String)Attribute1.nextElement();
%>

<tr>
	<th><%=name %> </th>
	<td><%=request.getAttribute(name) %></td>
</tr>
<%
   }
%>
</table>
</body>
</html>
