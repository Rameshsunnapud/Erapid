<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" import="java.util.*" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="tableMaint" class="com.csgroup.general.TableMaint" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
	logger.debug("editRow.jsp");
	String tableName=request.getParameter("tableName");
logger.debug(tableName+":: table name");
	String val[]=request.getParameterValues("val");
logger.debug(val.length+":: val length");
	for(int i=0; i<val.length; i++){
		logger.debug(i+"::"+val[i]);
	}

}
catch(Exception e){
	logger.debug("editRows.jsp");
	logger.debug(e.getMessage());
	logger.debug("editRows.jsp end");
}
//logger.info("getRows.jsp"+result);
%><%=result.trim()%>