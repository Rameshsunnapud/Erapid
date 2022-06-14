<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="priceCalc" class="com.csgroup.general.PriceCalcBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
	String orderNo=request.getParameter("orderNo");
	String charge=request.getParameter("charge");
	String productId=request.getParameter("productId");
	String total=request.getParameter("total");
	//logger.debug("pricecalcchartes.jsp::"+charge+"::"+productId+":::"+total);
	result=priceCalc.extraCharges(orderNo,charge,productId,total);
	//logger.debug(result);
}
catch(Exception e){
	logger.debug("priceCalcChange.jsp");
	logger.debug(e.getMessage());
	logger.debug("priceCalcChange.jsp end");
}
%><%=result%>