<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="priceCalc" class="com.csgroup.general.PriceCalcBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
String orderNo=request.getParameter("orderNo");
String commission=request.getParameter("commission");
String product=request.getParameter("product");
try{
	result=priceCalc.getLVRRepPrice(orderNo,commission,product);
	//out.println(result);
	//logger.debug("getCurrency.jsp::"+result);
}
catch(Exception e){
	logger.debug("getLVRRepPrice.jsp");
	logger.debug(e.getMessage());
	logger.debug("getLVRRepPrice.jsp end");
}

%><%=result%>