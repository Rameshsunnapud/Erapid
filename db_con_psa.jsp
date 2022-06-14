<%
/*(
Class.forName("com.sybase.jdbc2.jdbc.SybDriver");
String dbPSAServerName=erapidBean.getPSADbServerName();
String dbPSAServerPort=erapidBean.getPSADbServerPort();
String PSADBUsername=erapidBean.getPSADBUsername();
String PSADBPassword=erapidBean.getPSADBPassword();
Connection myConn_psa = DriverManager.getConnection("jdbc:sybase:Tds:"+dbPSAServerName+":"+dbPSAServerPort,PSADBUsername, PSADBPassword);
Statement stmt_psa=myConn_psa.createStatement();

*/


Class.forName("net.sourceforge.jtds.jdbc.Driver");
String dbPSAServerName=erapidBean.getPSADbServerName();
String dbPSAServerPort=erapidBean.getPSADbServerPort();
String PSADBUsername=erapidBean.getPSADBUsername();
String PSADBPassword=erapidBean.getPSADBPassword();
String PSADB=erapidBean.getPSADB();

Connection myConn_psa = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbPSAServerName + ":" + dbPSAServerPort + "/" + PSADB,PSADBUsername,PSADBPassword);

Statement stmt_psa=myConn_psa.createStatement();
stmt_psa.executeUpdate( "set ANSI_warnings off");



%>
