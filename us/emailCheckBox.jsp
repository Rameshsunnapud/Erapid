<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="priceCalc" class="com.csgroup.general.PriceCalcBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
	String productId=request.getParameter("productId");
	String group=request.getParameter("group");
	String projectType=request.getParameter("projectType");


	if(group==null){
		group="";
	}
	if(projectType==null){
		projectType="";
	}
	//logger.debug("3");
	result=priceCalc.getCheckBoxes(productId,group,projectType);

}
catch(Exception e){
	logger.debug("emailBean.jsp");
	logger.debug(e.getMessage());
	logger.debug("emailBean.jsp end");
}
%><%=result.trim()%>


