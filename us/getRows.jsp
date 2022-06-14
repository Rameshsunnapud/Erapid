<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" import="java.util.*" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="tableMaint" class="com.csgroup.general.TableMaint" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
	String tableName=request.getParameter("tableName");
	String count=request.getParameter("count");
	//logger.debug(count);
tableMaint.clearValues();
	Vector values=new Vector();
	for(int i=0; i<Integer.parseInt(count); i++){
		String tempValue=request.getParameter("value"+i);
		if(tempValue==null){
			tempValue="";
		}
		values.addElement(tempValue);
	}

	for(int y=0; y<values.size(); y++){
		tableMaint.setValue(""+y,values.elementAt(y).toString());
	}
	result=tableMaint.getRowValues(tableName);
	//logger.debug(result);
}
catch(Exception e){
	logger.debug("getRows.jsp");
	logger.debug(e.getMessage());
	logger.debug("getRows.jsp end");
}
//logger.info("getRows.jsp"+result);
%><%=result.trim()%>