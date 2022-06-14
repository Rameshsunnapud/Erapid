<%
String bpcsmmmServerName=erapidBean.getDbBPCSServerName();
String bpcsmmmUserName=erapidBean.getBPCSDBUsername();
String bpcsmmmPassword =erapidBean.getBPCSDBPassword();
DriverManager.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
Connection con_bpcsusrmm=DriverManager.getConnection("jdbc:as400:"+bpcsmmmServerName+"; translate binary=true; naming=system; extended metadata=true;libraries=BPCSFFG, BPCSUSRFFG, BPCSUSRMM; date format=iso",bpcsmmmUserName,bpcsmmmPassword);
Statement stmt_bpcsusrmm =con_bpcsusrmm.createStatement();
%>
