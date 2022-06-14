<%
Class.forName("net.sourceforge.jtds.jdbc.Driver");

String dbServerName=erapidBean.getDbServerName();
String dbServerPort=erapidBean.getDbServerPort();
String erapidDB=erapidBean.getErapidDB();
String erapidDBUsername=erapidBean.getErapidDBUsername();
String erapidDBPassword=erapidBean.getErapidDBPassword();

Connection myConn =DriverManager.getConnection("jdbc:jtds:sqlserver://"+dbServerName+":"+dbServerPort+"/"+erapidDB,erapidDBUsername,erapidDBPassword);
Statement stmt=myConn.createStatement();
stmt.executeUpdate( "set ANSI_warnings off");
%>
