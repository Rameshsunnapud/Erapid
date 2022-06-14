<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="architect" class="com.csgroup.general.ArchitectBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
//logger.debug("getArchitects.jsp");
String result="";
try{
	String name=request.getParameter("name");
	String city=request.getParameter("city");
	String state=request.getParameter("state");
	result=architect.getArchitects(name,city,state);

}
catch(Exception e){
	logger.debug("getArchitects.jsp");
	logger.debug(e.getMessage());
	logger.debug("getArchitects.jsp end");
}
%><%=result%>