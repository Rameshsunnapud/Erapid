<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="customerEdit" class="com.csgroup.general.CustomerBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
	//logger.debug("customerEdit bean start");
	String custNo=request.getParameter("custNo");
	String countryCode=request.getParameter("countryCode");
	if(custNo==null||custNo.length()==0){
		custNo=""; 
	}
	if(countryCode==null||countryCode.length()==0){
		countryCode=""; 
	}	
	customerEdit.setEditCountryCode(countryCode);
	customerEdit.setEditCustNo(custNo);
	result=customerEdit.getCustomerEditDiv();
}
catch(Exception e){
	logger.debug("editCustomer.jsp");
	logger.debug(e.getMessage());
	logger.debug("editCustomer.jsp end");
}
%><%=result.trim()%>