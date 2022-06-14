<%@ page language="java" contentType="text/xml;charset=ISO-8859-1" %><jsp:useBean id="search" class="com.csgroup.general.SearchBean" scope="page"/><%
String product=request.getParameter("product");
String repNo=request.getParameter("repNo");
String orderNo=request.getParameter("orderNo");
String archName=request.getParameter("archName");
String orderDate=request.getParameter("orderDate");
String custLoc=request.getParameter("custLoc");
String projectName=request.getParameter("projectName");
String quoteType=request.getParameter("quoteType");
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
if(orderDate==null||orderDate.length()==0){
	orderDate="";
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
search.setProduct(product);
search.setRepNo(repNo);
search.setOrderNo(orderNo);
search.setArchName(archName);
search.setOrderDate(orderDate);
search.setCustLoc(custLoc);
search.setProjectName(projectName);
search.setQuoteType(quoteType);
String result=search.getSearchDiv();
%><%=result.trim()%>

