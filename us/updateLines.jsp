<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="lines" class="com.csgroup.general.LineItemBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{	
	String orderNo=request.getParameter("orderNo");
	lines.setOrderNo(orderNo);
	result=lines.getXml(orderNo);
	
}
catch(Exception e){
	logger.debug("updatelines.jsp");
	logger.debug(e.getMessage());
	logger.debug("updatelines.jsp done");
}
%><%=result.trim()%>