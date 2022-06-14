<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" import="java.io.*"   contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="error.jsp" %>
<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<%

if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<%@ include file="../db_con.jsp"%>
<%@ include file="../db_con_bpcs.jsp"%>
<%
    String greg="";
    ResultSet rs0=stmt.executeQuery("select top(200) b.model,b.uom,a.model,a.bpcs from cs_ejc_bpcs a, cs_ejc_pricing b where a.model=b.model and b.model like 'ASM400X'");
    if(rs0 != null){
        while(rs0.next()){
            out.println(rs0.getString(1)+"::");
            out.println(rs0.getString(2)+"::");
            //out.println(rs0.getString(3)+"::");
            out.println(rs0.getString(4)+"::<BR>");
                 
            greg=greg+"'"+rs0.getString(4)+"',";
        }
    }
    rs0.close();
    greg=greg.substring(0,greg.length()-1);
    //out.println(greg+"<BR><BR><BR>");
    int a=0;
ResultSet rs1=stmt_bpcs.executeQuery("select  IIM.IPROD, IIM.IDESC,IIM.IVEND,IIM.IUMS,IIM.IDSCE from IIM where IIM.IPROD in ("+greg+")");
if(rs1 !=null){
    while(rs1.next()){
        
        for(int i=1; i<=5;i++){
            out.println(rs1.getString(i)+"::");
        }
        out.println("<BR>");
        a++;
        if(a>200){
            rs1=null;
        }
    }
}
rs1.close();
stmt_bpcs.close();
stmt.close();
con_bpcs.close();
myConn.close();
}
catch(Exception e){
out.println(e);
}
%>
