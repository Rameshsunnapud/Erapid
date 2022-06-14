<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
	String repNo=request.getParameter("repNo");
	String repName=request.getParameter("repName");
	String repId=request.getParameter("repId");
	String repAccount=request.getParameter("repAccount");
	String styleSheet=request.getParameter("styleSheet");
	String address1=request.getParameter("address1");
	String address2=request.getParameter("address2");
	String city=request.getParameter("city");
	String state=request.getParameter("state");
	String telephone=request.getParameter("telephone");
	String fax=request.getParameter("fax");
	String email=request.getParameter("email");
	String zip=request.getParameter("zip");
	result=userSession.saveRep(repNo,repName,repId,repAccount,styleSheet,address1,address2,city,state,telephone,fax,email,zip);
}
catch(Exception e){
	logger.debug("userAdminSave.jsp");
	logger.debug(e.getMessage());
	logger.debug("userAdminSave.jsp end");
}
%><%=result.trim()%>