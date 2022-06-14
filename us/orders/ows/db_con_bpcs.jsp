<%
DriverManager.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
Connection con_bpcsffg=DriverManager.getConnection("jdbc:as400://csas400/BPCSFFG;naming=sql;errors=full","logiasrv","logiasrv");
Statement stmt_bpcsffg =con_bpcsffg.createStatement();
/*
DriverManager.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
Connection con_bpcsffg=DriverManager.getConnection("jdbc:as400://csas400/BCANFPG;naming=sql;errors=full","logiasrv","logiasrv");
Statement stmt_bpcsffg =con_bpcsffg.createStatement();
*/
%>
