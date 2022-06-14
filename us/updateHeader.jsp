<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="csproject" class="com.csgroup.general.QuoteHeaderBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String orderNo=request.getParameter("orderNo");
csproject.setOrderNo(orderNo);
//docheader.setOrderNo(orderNo);
String result=csproject.getXml();
//logger.info(result);
%><%=result.trim()%>