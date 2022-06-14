<%
DriverManager.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
Connection con_bpcsusrmm=DriverManager.getConnection("jdbc:as400:csas400; translate binary=true; naming=system; extended metadata=true;libraries=BPCSFFG, BPCSUSRFFG, BPCSUSRMM; date format=iso","logiasrv","logiasrv");
Statement stmt_bpcsusrmm =con_bpcsusrmm.createStatement();
/*
DriverManager.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
Connection con_bpcsusrmm=DriverManager.getConnection("jdbc:as400:csas400; translate binary=true; naming=system; extended metadata=true;libraries=BCANFPG, BCANUSRFPG, BPCSUSRMM; date format=iso","logiasrv","logiasrv");
Statement stmt_bpcsusrmm =con_bpcsusrmm.createStatement();
*/
%>
