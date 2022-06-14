<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="validate" class="com.csgroup.general.ValidationBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
//logger.debug("getArchitects.jsp");
String result="";
try{
	String bpcsNo=request.getParameter("bpcsNo");
	result=validate.checkBpcsOrderCloseXML(bpcsNo);
}
catch(Exception e){
	logger.debug("checkBpcsNo.jsp");
	logger.debug(e.getMessage());
	logger.debug("checkBpcsNo.jsp end");
}
%><%=result%>