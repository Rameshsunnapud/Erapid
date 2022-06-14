<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="accessCentral" class="com.csgroup.general.AccessCentral" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
//logger.debug("getArchitects.jsp");
String result="";
try{
	String weight=request.getParameter("weight");
	String city=request.getParameter("city");
	String state=request.getParameter("state");
	String orderNo=request.getParameter("orderNo");
        String sectionLines=request.getParameter("sectionLines");
	logger.debug("accessCentralChangeWeight.jsp::"+weight+"::"+city+"::"+state+"::"+orderNo+"::"+sectionLines);
	result=accessCentral.getFreight(new Double(weight).doubleValue(),city,state,orderNo,sectionLines);
	//logger.debug("accessCentralChangeWeight.jsp::"+result);
}
catch(Exception e){
	logger.debug("accessCentralChangeWeight.jsp");
	logger.debug(e.getMessage());
	logger.debug("accessCentralChangeWeight.jsp end");
}
%><%=result%>