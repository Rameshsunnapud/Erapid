<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="validate" class="com.csgroup.general.ValidationBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
//logger.debug("getArchitects.jsp");
String result="";
try{
	String orderNo=request.getParameter("orderNo");
	result=validate.checkSections(orderNo);
}
catch(Exception e){
	logger.debug("checkSections.jsp");
	logger.debug(e.getMessage());
	logger.debug("checkSections.jsp end");
}
%><%=result%>