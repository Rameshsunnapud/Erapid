<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="page"/><jsp:useBean id="customerSearch" class="com.csgroup.general.CustomerBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
//	logger.debug("customerSearch bean start");
	String repNo=request.getParameter("repNo");
	String repGroup=request.getParameter("repGroup");
	String repCountry=request.getParameter("repCountry");
	String customerName=request.getParameter("customerName");
	String customerCity=request.getParameter("customerCity");
	String customerBpcsNo=request.getParameter("customerBpcsNo");
//logger.debug(repNo);
	if(repNo==null || repNo.length()==0){
		repNo=userSession.getRepNo();
	}
	//logger.debug(repNo);
	if(repNo==null||repNo.length()==0){
		repNo="";
	}
	if(repCountry==null||repCountry.length()==0){
		repCountry="";
	}
	if(repGroup==null||repGroup.length()==0){
		repGroup="";
	}
	if(customerName==null||customerName.length()==0){
		customerName="";
	}
	if(customerCity==null||customerCity.length()==0){
		customerCity="";
	}
	if(customerBpcsNo==null||customerBpcsNo.length()==0){
		customerBpcsNo="";
	}
	//logger.debug("customersearchbean.jsp"+customerBpcsNo);
	customerSearch.setSearchRepNo(repNo);
	customerSearch.setSearchRepGroup(repGroup);
	customerSearch.setSearchRepCountry(repCountry);
	customerSearch.setSearchCustomerName(customerName);
	customerSearch.setSearchCustomerCity(customerCity);
	customerSearch.setSearchCustomerBpcsNo(customerBpcsNo);
	result=customerSearch.getCustomerSearchDiv();
}
catch(Exception e){
	logger.debug("customerSearchBean.jsp");
	logger.debug(e.getMessage());
	logger.debug("customerSearchBean.jsp end");
}
%><%=result.trim()%>