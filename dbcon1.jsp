
<%
Class.forName("net.sourceforge.jtds.jdbc.Driver");
String dbServerNameSys=erapidBean.getDbServerName();
String dbServerPortSys=erapidBean.getDbServerPort(); 
String erapidSysDB=erapidBean.getErapidSysDB();
String erapidDBUsernameSys=erapidBean.getErapidDBUsername();
String erapidDBPasswordSys=erapidBean.getErapidDBPassword();
Connection myConns =DriverManager.getConnection("jdbc:jtds:sqlserver://"+dbServerNameSys+":"+dbServerPortSys+"/"+erapidSysDB,erapidDBUsernameSys,erapidDBPasswordSys);
Statement stmts=myConns.createStatement();
stmts.executeUpdate( "set ANSI_warnings off");
%>
