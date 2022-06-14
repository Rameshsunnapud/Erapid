<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java"  contentType="text/xml;charset=UTF-8" %><jsp:useBean id="quoteHeader" class="com.csgroup.general.QuoteHeaderBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String orderNo=request.getParameter("orderNo");
String repQuote=request.getParameter("repQuote");
quoteHeader.setRepQuote(orderNo,repQuote);
%>