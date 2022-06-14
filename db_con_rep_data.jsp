<%
	//Class.forName("com.newatlanta.jturbo.driver.Driver");
Class.forName("net.sourceforge.jtds.jdbc.Driver");
	String dbUSRepServerName=erapidBean.getUSRepDbServerName();
	String dbUSRepServerPort=erapidBean.getUSRepDbServerPort();
	String USRepDB=erapidBean.getUSRepDB();
	String USRepDBUsername=erapidBean.getUSRepDBUsername();
	String USRepDBPassword=erapidBean.getUSRepDBPassword();
	Connection myConnRepData = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbUSRepServerName + ":" + dbUSRepServerPort + "/" + USRepDB,USRepDBUsername,USRepDBPassword);

	//Connection myConnRepData =DriverManager.getConnection("jdbc:JTurbo://"+dbUSRepServerName+":"+dbUSRepServerPort+"/"+USRepDB+"/sql70=true/sp=false",USRepDBUsername,USRepDBPassword);
	Statement stmtRepData=myConnRepData.createStatement();
	stmtRepData.executeUpdate( "set ANSI_warnings off");
%>
