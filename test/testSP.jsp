<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" import="java.io.*"   contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="error.jsp" %>
<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<%

if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<%@ include file="../db_con.jsp"%>
<%
String tempOrderNo="";
CallableStatement proc = myConn.prepareCall("{ call sp_Get_order_no }");
ResultSet result = proc.executeQuery();
if(result !=null){
	while(result.next()){
		tempOrderNo=result.getString(1);
	}
}
result.close();




stmt.close();
myConn.close();
out.println("8");
}
catch(Exception e){
out.println(e);
}
%>