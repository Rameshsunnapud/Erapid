<html>
	<head>
		<title>Work Copy # <%= request.getParameter("q_no") %> </title>
		<link rel='stylesheet' href='style1.css' type='text/css'/>


		<%
				String order_no = request.getParameter("q_no");//Login id
		%>
		<%@ page language="java" import="java.net.*" import="java.sql.*" import="java.io.*" errorPage="error.jsp" %>
	<body >
		<iframe id='secIframe' height='1%' width='1%' frameborder="0" src="work_copy_home_ads.jsp?orderNo=<%=order_no %>&pid=3&tp=1&close=yes"></iframe>



		<!--
	</body>onload='javascript:window.close();'>-->
	</body>
</html>
