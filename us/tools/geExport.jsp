<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="quoteHeader" 	class="com.csgroup.general.QuoteHeaderBean"		scope="page"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
	<body onload='initSelectedNotes()'>
	<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" import="java.lang.*" errorPage="error.jsp" %>
<%@ include file="db_con.jsp"%>
<%
ResultSet rs1=stmt.executeQuery("select * from csquotes where order_no='579913_00'");
if(rs1 !=null){
	while(rs1.next()){

	}
}
stmt.close();
myConn.close();

}
catch(Exception e){
out.println(e);
}
%>
</body>
</html>