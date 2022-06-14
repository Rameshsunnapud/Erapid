<%
Class.forName("net.sourceforge.jtds.jdbc.Driver");

String dbServerName="lebhq-erdb";
String dbServerPort="1435";
String erapidDB="cse";
String erapidDBUsername="GsoHyd";
String erapidDBPassword="csgroup";

Connection myConn =DriverManager.getConnection("jdbc:jtds:sqlserver://"+dbServerName+":"+dbServerPort+"/"+erapidDB,erapidDBUsername,erapidDBPassword);
Statement stmt=myConn.createStatement();
stmt.executeUpdate( "set ANSI_warnings off");
%>
