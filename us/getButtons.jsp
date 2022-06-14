<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="buttons" class="com.csgroup.general.ButtonsBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
        String product=request.getParameter("product");
        String orderNo=request.getParameter("orderNo");
        String group=request.getParameter("group");
        String pagex=request.getParameter("page");
		logger.debug("ENV_GETBUTTINS:"+request.getParameter("env"));
        result=buttons.getButtons(pagex,product,"US",group,orderNo);
		//logger.debug(result);
}
catch(Exception e){
        logger.debug("getButtons.jsp");
        logger.debug(e.getMessage());
        logger.debug("getButtons.jsp end");
}
%><%=result%>