<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="admin" class="com.csgroup.general.AdminBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
try{

	String messageUS=request.getParameter("messageUS");

	String messageTypeUS=request.getParameter("messageTypeUS");
	admin.saveMessage(messageUS,messageTypeUS);
}
catch(Exception e){
	logger.debug("adminSaveMessage.jsp");
	logger.debug(e.getMessage());
	logger.debug("adminSaveMessage.jsp end");
}
%>