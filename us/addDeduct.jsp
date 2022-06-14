<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="lines" class="com.csgroup.general.LineItemBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
	String orderNo=request.getParameter("orderNo");
	String lineNo=request.getParameter("lineNo");
	String addDeduct=request.getParameter("addDeduct");
	lines.setAddDeduct(orderNo,lineNo,addDeduct);


}
catch(Exception e){
	logger.debug("addDeduct.jsp");
	logger.debug(e.getMessage());
	logger.debug("addDeduct.jsp done");
}
%><%=result.trim()%>