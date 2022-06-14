<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="quoteHeader" class="com.csgroup.general.QuoteHeaderBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
	String groupCode=request.getParameter("groupCode");
	result=quoteHeader.getSalesRegion(groupCode);
	//logger.debug(result);
}
catch(Exception e){
	logger.debug("setSalesRegion.jsp");
	logger.debug(e.getMessage());
	logger.debug("setSalesRegion.jsp end");
}
%><%=result.trim()%>