<%
String bpcsffgUSRServerName=erapidBean.getDbBPCSServerName();
String bpcsffgUSRUserName=erapidBean.getBPCSDBUsername();
String bpcsffgUSRPassword=erapidBean.getBPCSDBPassword();
String bpcsffgBPCSUSRDB=erapidBean.getBPCSUSRDB();
DriverManager.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
Connection con_bpcsusr=DriverManager.getConnection("jdbc:as400://"+bpcsffgUSRServerName+"/"+bpcsffgBPCSUSRDB+";naming=sql;errors=full",bpcsffgUSRUserName,bpcsffgUSRPassword);
Statement stmt_bpcsusr =con_bpcsusr.createStatement();

%>
