<%@ page import="java.util.Enumeration" isErrorPage="true" %>
<html>
	<head><title>Error Home </title>
	</head>
	<body>
		<h1> Error page</h1>
		<font size='3'><b>Sorry for the inconvenience.  The system has encountered an error.</font><BR><BR>
			<font size='3'><b>Please try the following:<BR>
				- click the 'Refresh' browser button or hit the 'F5' key,<BR>
				- go Back and try the action again.</font><BR>
				<font color='red' size='3'>If you still get the error and you can spare a couple of minutes please keep this page open and contact the C/S Group I.T. Department.</b></font><BR>
			<BR>
			<HTML>
				<HEAD>
					<TITLE>E-Rapid Remote Quoting System</TITLE>
					<link rel='stylesheet' href='style1.css' type='text/css' />
				</HEAD>

				<strong><font size='3'>eRapid Help Contact Information:</font></strong><br><p algin='center'><table border="1" cellspacing="0" cellpadding="0" align="center" bordercolor="#000000" algin="center" width='100%'><tr>
						<td><h1>Contact</h1></td>
						<td><h1>Phone</h1></td>
						<td><h1>EMail</h1></td>
					</tr>
					<tr>
						<td>Arthur Cosma</td>
						<td>908-849-4836</td>
						<td>acosma@c-sgroup.com</td>
					</tr>

					<tr>
						<td>Greg Suisham</td>
						<td>888-895-8955 x340</td>
						<td>gsuisham@c-sgroup.com</td>
					</tr>


				</table>

				</div>
				</p>
			</HTML>




			&nbsp;&nbsp;&nbsp;&nbsp;<%=exception %><br>
			<p>
			<table border="1">
				<tr>
					<th colspan="2">Application Attribute </th>
				</tr>
				<% Enumeration appAttribute=application.getAttributeNames();
				   while (appAttribute.hasMoreElements()){
				   String name=(String)appAttribute.nextElement();
				%>
				<tr>
					<th><%=name %> </th>
					<td><%=application.getAttribute(name) %></td>
				</tr>
				<%
				   }
				%>
			</table>
			<p>
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
			<p>
			<table border="1">
				<tr>
					<th colspan="2">Parameters </th>
				</tr>
				<%
				   Enumeration param1= request.getParameterNames();
				   while (param1.hasMoreElements()){
				   String name=(String)param1.nextElement();
				%>

				<tr>
					<th><%=name %> </th>
					<td><%=request.getParameter(name) %></td>
				</tr>
				<%
				   }
				%>
			</table>
	</body>
</html>