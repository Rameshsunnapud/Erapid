<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java"  contentType="text/xml;charset=UTF-8" %><jsp:useBean id="csproject" class="com.csgroup.general.QuoteHeaderBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
try{
String psaNo=request.getParameter("psaNo");
//logger.debug("psaheader.jsp::"+psaNo);
String result=csproject.getPSAXml(psaNo);
//logger.info("psaHEader.jsp::"+result);
%><%=result.trim()%><%}catch(Exception e){ logger.debug(e.getMessage());}%>