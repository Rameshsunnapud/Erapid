<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="customerSave" class="com.csgroup.general.CustomerBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
	//logger.debug("customerSave bean start");
	String custNo=request.getParameter("custNo");
	String custName1=request.getParameter("custName1");
	//logger.debug(custName1+"::: customer name1");
	String custName2=request.getParameter("custName2");
	String custAddr1=request.getParameter("custAddr1");
	String custAddr2=request.getParameter("custAddr2");
	String city=request.getParameter("city");
	String state=request.getParameter("state");
	String zipCode=request.getParameter("zipCode");
	String country=request.getParameter("country");
	String countryCode=request.getParameter("countryCode");
     ///logger.debug(countryCode+"::save customer.jsp");
	String bpcsCustNo=request.getParameter("bpcsCustNo");
	String attention=request.getParameter("attention");
	String salutation=request.getParameter("salutation");
	String phone=request.getParameter("phone");
	String currency=request.getParameter("currency");
	String shippingCity=request.getParameter("shippingCity");
	String fax=request.getParameter("fax");
	String email=request.getParameter("email");
	String custNoText=request.getParameter("custNoText");
	String createdRepNo=request.getParameter("createdRepNo");
	String billCust=request.getParameter("billCust");
	String marketType=request.getParameter("marketType");
	String contactName=request.getParameter("contactName");
	String dormant=request.getParameter("dormant");
	//logger.debug(billCust+"::: savecustomer.jsp");
	result=customerSave.saveCustomer(custNo,custName1,custName2,custAddr1,custAddr2,city,state,zipCode,country,countryCode,bpcsCustNo,attention,salutation,phone,currency,shippingCity,fax,email,custNoText,createdRepNo,billCust,marketType,contactName,dormant);
    customerSave.setEditCountryCode(countryCode);
	customerSave.setEditCustNo(result);
	result=customerSave.getCustomerEditDiv();

}
catch(Exception e){
	logger.debug("saveCustomer.jsp");
	logger.debug(e.getMessage());
	logger.debug("saveCustomer.jsp end");
}
%><%=result.trim()%>