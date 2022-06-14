
<% request.setCharacterEncoding( response.getCharacterEncoding() ); %>
<jsp:useBean id="convert" class="com.csgroup.general.Convertor" scope="page"/>
<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<%@ page language="java" import="java.text.*" import="java.util.*" import="java.sql.*" import="java.io.*" contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="error.jsp" %>
<%@ include file="../../db_con.jsp"%>
<%
    org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String url="reports/work_copy_home_ads.jsp";
	String url2="quotes/show_sfdc_quotes2.jsp";
	String urlAdd="";
	String urlAdd2="&type=2";
	String orderNo=request.getParameter("orderNo");
	String action="IMS";
	String imstype="workcopy";
	if(url.indexOf("orderNo")<0){
		url=""+application.getInitParameter("HOST")+"/erapid/us/"+url+"?orderNo="+orderNo+"&action="+action;
	}
	else{
		url=""+application.getInitParameter("HOST")+"/erapid/us/"+url+"&action="+action;
	}
	if(url2.indexOf("orderNo")<0){
		url2=""+application.getInitParameter("HOST")+"/erapid/us/"+url2+"?orderNo="+orderNo+"&type=2&action="+action;
	}
	else{
		url2=""+application.getInitParameter("HOST")+"/erapid/us/"+url2+"&type=2&action="+action;
	}
	String path="";
	int count2=0;
	ResultSet rs2=stmt.executeQuery("select count(*) from cs_ads_price_calc where order_no='"+orderNo+"'");
	if(rs2 != null){
		while(rs2.next()){
			count2=rs2.getInt(1);
		}
	}
	rs2.close();
	if(count2>0){
		path=convert.htmlToIMS(url,"",orderNo,"","", "","workcopy");
		path=convert.htmlToIMS(url2,"",orderNo,"","", "","3");
		out.println("file complete");
	}
	else{
		out.println("not necessary");
	}
out.println("<body onload='window.close()'>");
	stmt.close();
	myConn.close();
}
catch(Exception e){
	out.println(e);
}
%>