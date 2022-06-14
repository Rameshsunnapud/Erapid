	<%

		Class.forName("com.newatlanta.jturbo.driver.Driver");		
		Connection myConn = DriverManager.getConnection("jdbc:JTurbo://"+application.getInitParameter("DBHOST")+":1433/cse/sql70=true/sp=false","erapid","logincs07");
		Statement stmt=myConn.createStatement();
	%>
