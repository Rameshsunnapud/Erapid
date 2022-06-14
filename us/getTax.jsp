<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="tax" class="com.csgroup.general.TaxCalc" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
    String orderNo=request.getParameter("orderNo");
    result=tax.getTotalTaxValueXML(orderNo);
    logger.debug("Taxt test by Praveen "+result);
}
catch(Exception e){
    logger.debug("getTax.jsp");
    logger.debug(e.getMessage());
    logger.debug("getTax end");
}
%><%=result%>