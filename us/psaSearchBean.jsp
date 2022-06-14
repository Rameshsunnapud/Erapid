<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" pageEncoding="utf-8" %><jsp:useBean id="search" class="com.csgroup.general.SearchBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String psaProjectName=request.getParameter("psaProjectName");
String userName=request.getParameter("userName");
//logger.debug("psaSearchBean.jsp::"+psaProjectName);
if(psaProjectName==null){
	psaProjectName="";
}
String result="";
try{
	result=search.getPSASearchDiv(psaProjectName,userName);
}
catch(Exception e){
	logger.debug("psaSearchBean.jsp");
	logger.debug(e.getMessage());
	logger.debug("psaSearchBean.jsp end");
}
%><%=result.trim()%>
