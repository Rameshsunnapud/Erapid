<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{

	String orderNo=request.getParameter("orderNo");
	String url=request.getParameter("url");
	String to=request.getParameter("to");
	String from=request.getParameter("from");
	String cc=request.getParameter("cc");
	String bcc=request.getParameter("bcc");
	String bcc2=request.getParameter("bcc2");
	String bcc3=request.getParameter("bcc3");
	String message=request.getParameter("message");
	String dirname=request.getParameter("dirname");
	String attachfiles=request.getParameter("attachfiles");
	String productId=request.getParameter("productId");
	String repNum=request.getParameter("repNum");
	String userId=request.getParameter("userId");
	//out.println("Test "+url);
	result=convertor.emailPdf(url,"",orderNo,"","", "", to, from, cc,bcc,bcc2,message,dirname,attachfiles,productId,repNum,bcc3,userId);
}
catch(Exception e){
	logger.debug("emailBean.jsp");
	logger.debug(e.getMessage());
	logger.debug("emailBean.jsp end");
}
%><%=result.trim()%>