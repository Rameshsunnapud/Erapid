<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="csproject" class="com.csgroup.general.QuoteHeaderBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
try{

String altCpyNo=request.getParameter("altCpyNo");
String qtype=request.getParameter("qtype");
String product=request.getParameter("product");
csproject.setOriginalNo(altCpyNo);
csproject.setQType(qtype);
if(altCpyNo==null || altCpyNo.trim().length()==0){
	csproject.setDefaultNotes(product);
}
String result=csproject.getXml();
%><%=result.trim()%><%}catch(Exception e){ logger.debug(e.getMessage());}%>