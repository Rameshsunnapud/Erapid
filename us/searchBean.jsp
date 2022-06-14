<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" pageEncoding="utf-8" %><jsp:useBean id="search" class="com.csgroup.general.SearchBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
//ogger.debug("HERE");
String countryCode=request.getParameter("countryCode");
String product=request.getParameter("product");
String repNo=request.getParameter("repNo");
String userId=request.getParameter("userId");
String orderNo=request.getParameter("orderNo");
String archName=request.getParameter("archName");
String orderDate1=request.getParameter("orderDate1");
String orderDate2=request.getParameter("orderDate2");
String custLoc=request.getParameter("custLoc");
String projectName=request.getParameter("projectName");
String bpcsNo=request.getParameter("bpcsNo");
String quoteType=request.getParameter("quoteType");
String firstOrderNo=request.getParameter("firstOrderNo");
String lastOrderNo=request.getParameter("lastOrderNo");
String functionName=request.getParameter("functionName");
String webNum=request.getParameter("webNum");
if(repNo==null || repNo.length()==0){
//	repNo=userSession.getRepNo();
}
if(product==null||product.length()==0){
	product="";
}
if(orderNo==null||orderNo.length()==0){
	orderNo="";
}
if(archName==null||archName.length()==0){
	archName="";
}
if(orderDate1==null||orderDate1.length()==0){
	orderDate1="";
}
if(orderDate2==null||orderDate2.length()==0){
	orderDate2="";
}
if(custLoc==null||custLoc.length()==0){
	custLoc="";
}
if(projectName==null||projectName.length()==0){
	projectName="";
}
if(quoteType==null||quoteType.length()==0){
	quoteType="";
}
if(firstOrderNo==null||firstOrderNo.length()==0){
	firstOrderNo="";
}
if(lastOrderNo==null||lastOrderNo.length()==0){
	lastOrderNo="";
}
if(functionName==null||functionName.length()==0){
	functionName="";
}
if(repNo != null && repNo.startsWith("US")){
	repNo=repNo.substring(2);
}
if(bpcsNo==null||bpcsNo.length()==0){
	bpcsNo="";
}
if(webNum==null||webNum.length()==0){
	webNum="";
}
//logger.debug("1");
search.setProduct(product);
search.setRepNo(repNo);
search.setUserId(userId);
search.setOrderNo(orderNo);
search.setArchName(archName);
search.setOrderDate1(orderDate1);
search.setOrderDate2(orderDate2);
search.setCustLoc(custLoc);
search.setProjectName(projectName);
search.setBpcsNo(bpcsNo);
search.setQuoteType(quoteType);
search.setFirstOrderNo(firstOrderNo);
search.setLastOrderNo(lastOrderNo);
search.setFunctionName(functionName);
search.setWebNum(webNum);
//logger.debug("2");
//logger.debug("***"+webNum+"::: webNum");
String result=search.getSearchDiv(countryCode);
//logger.debug(result);
//logger.debug("3");
%><%=result.trim()%>
