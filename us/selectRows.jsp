<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java"  contentType="text/xml;charset=UTF-8" %><jsp:useBean id="tableMaint" class="com.csgroup.general.TableMaint" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String tableName=request.getParameter("tableName");
String result=tableMaint.getRows(tableName);
//logger.info(result);
%><%=result.trim()%>