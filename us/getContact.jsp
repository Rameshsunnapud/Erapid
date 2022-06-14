<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="customer" class="com.csgroup.general.CustomerBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
	String custNo=request.getParameter("custNo");
	String countryCode=request.getParameter("countryCode");
	result=customer.getContacts(custNo,countryCode);
       // logger.debug(result);
} 
catch(Exception e){
	logger.debug("emailBean.jsp");
	logger.debug(e.getMessage());
	logger.debug("emailBean.jsp end");
}
%><%=result.trim()%>