<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="contactSave" class="com.csgroup.general.CustomerBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
	String custNo=request.getParameter("custNo");
	String contactNo=request.getParameter("contactNo");
	String countryCode=request.getParameter("countryCode");
	String contactName=request.getParameter("contactName");
	String contactPhone=request.getParameter("contactPhone");
	String contactFax=request.getParameter("contactFax");
	String contactEmail=request.getParameter("contactEmail");
	String contactDormant=request.getParameter("contactDormant");
	//logger.debug("savecontact.jsp::"+custNo+"::"+contactNo+"::"+countryCode+"::"+contactName+"::"+contactPhone+"::"+contactFax+"::"+contactEmail+"::"+contactDormant);
	result=contactSave.saveContact(custNo,contactNo,countryCode,contactName,contactPhone,contactFax,contactEmail,contactDormant);
}
catch(Exception e){
	logger.debug("saveCustomer.jsp");
	logger.debug(e.getMessage());
	logger.debug("saveCustomer.jsp end");
}
%><%=result.trim()%>