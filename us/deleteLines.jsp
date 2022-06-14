<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="lines" class="com.csgroup.general.LineItemBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
	String orderNo=request.getParameter("orderNo");
	String linesDelete=request.getParameter("lines");
	String country=request.getParameter("country");
	String product=request.getParameter("product");
	//logger.debug(linesDelete+"::"+orderNo+"::"+country+"::"+product);
	result=lines.deleteLines(orderNo,linesDelete,product,country);
	if(result.startsWith("FAILED")){
		logger.debug("ERROR DELETING LINES:::"+result);
	}
	//logger.debug(result+"::: RESULT");
}
catch(Exception e){
	logger.debug("updatelines.jsp");
	logger.debug(e.getMessage());
	logger.debug("updatelines.jsp done");
}
%><%=result.trim()%>