<%
Class.forName("net.sourceforge.jtds.jdbc.Driver");
String WEBServerName=erapidBean.getWEBServerName();
String WEBServerPort=erapidBean.getWEBServerPort();
String WEBDB=erapidBean.getWEBDB();
String WEBDBUsername=erapidBean.getWEBDBUsername();
String WEBDBPassword=erapidBean.getWEBDBPassword();
Connection myConn_web = DriverManager.getConnection("jdbc:jtds:sqlserver://"+WEBServerName+":"+WEBServerPort+"/"+WEBDB,WEBDBUsername,WEBDBPassword);
Statement stmt_web=myConn_web.createStatement();
stmt_web.executeUpdate( "set ANSI_warnings off");
%>