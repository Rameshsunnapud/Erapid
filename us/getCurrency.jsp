<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="currency" class="com.csgroup.general.CurrencyBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";

String custNo=request.getParameter("custNo");
try{
	result=currency.getCurrencyByRepNo(custNo);
	//out.println(result);
	//logger.debug("getCurrency.jsp::"+result);
}
catch(Exception e){
	logger.debug("getCurrency.jsp");
	logger.debug(e.getMessage());
	logger.debug("getCurrency.jsp end");
}

%><%=result%>