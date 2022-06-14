<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/><jsp:useBean id="priceCalc" class="com.csgroup.general.PriceCalcBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
	String orderNo=request.getParameter("orderNo");
	priceCalc.setOrderNo(orderNo);
	//logger.debug(userSession.getGroup()+"::"+userSession.getUserId()+":: pricecalcshow.jsp");
	result=priceCalc.getPriceCalc(userSession.getUserId(),userSession.getGroup());
}
catch(Exception e){
	logger.debug("priceCalcShow.jsp");
	logger.debug(e.getMessage());
	logger.debug("priceCalcShow.jsp end");
}
%><%=result%>