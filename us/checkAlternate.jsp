<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="quoteHeader" class="com.csgroup.general.QuoteHeaderBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
        String orderNo=request.getParameter("orderNo");
        result=quoteHeader.checkAlternate(orderNo);
        //logger.debug(result);
}
catch(Exception e){
        logger.debug("saveCustomer.jsp");
        logger.debug(e.getMessage());
        logger.debug("saveCustomer.jsp end");
}
%><%=result.trim()%>