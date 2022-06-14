<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="customerSave" class="com.csgroup.general.CustomerBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
	String custAddr1=request.getParameter("custAddr1");
	String city=request.getParameter("city");
	String createdRepNo=request.getParameter("createdRepNo");
	result=customerSave.checkCustomer(custAddr1,city,createdRepNo);
	//logger.debug(result);
}
catch(Exception e){
	logger.debug("saveCustomer.jsp");
	logger.debug(e.getMessage());
	logger.debug("saveCustomer.jsp end");
}
%><%=result.trim()%>