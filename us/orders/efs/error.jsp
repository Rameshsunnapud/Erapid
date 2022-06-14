<%@ page import="java.util.Enumeration" isErrorPage="true" %> 
<html>
<head><title>Error Home </title>
</head>
<body> 
<h1> Error page</h1>
we got ourselves an exception<br>
&nbsp;&nbsp;&nbsp;&nbsp;<%=exception %>
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