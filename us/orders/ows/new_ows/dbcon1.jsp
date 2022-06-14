
<%
Class.forName("net.sourceforge.jtds.jdbc.Driver");
String dbServerNameSys="sec-cpqdbdev";
String dbServerPortSys="1435"; 
String erapidSysDB="csedevsys";
String erapidDBUsernameSys="erapid";
String erapidDBPasswordSys="erapid@382";
Connection myConns =DriverManager.getConnection("jdbc:jtds:sqlserver://"+dbServerNameSys+":"+dbServerPortSys+"/"+erapidSysDB,erapidDBUsernameSys,erapidDBPasswordSys);
Statement stmts=myConns.createStatement();
stmts.executeUpdate( "set ANSI_warnings off");
%>
