
	<%
	   	Class.forName("com.sybase.jdbc2.jdbc.SybDriver");
	   	Connection myConn = DriverManager.getConnection("jdbc:sybase:Tds:"+ application.getInitParameter("DBHOST")+":2638/csedev?SERVICENAME=csedev", "dba", "sql");//
		Statement stmt=myConn.createStatement();
	%>
