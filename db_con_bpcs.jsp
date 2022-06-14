<%
String bpcsffgServerName=erapidBean.getDbBPCSServerName();
String bpcsffgUserName=erapidBean.getBPCSDBUsername();
String bpcsffgPassword=erapidBean.getBPCSDBPassword();
String bpcsffgBPCSDB=erapidBean.getBPCSDB();
DriverManager.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
Connection con_bpcs=DriverManager.getConnection("jdbc:as400://"+bpcsffgServerName+"/"+bpcsffgBPCSDB+";naming=sql;errors=full",bpcsffgUserName,bpcsffgPassword);
Statement stmt_bpcs =con_bpcs.createStatement();
%>
