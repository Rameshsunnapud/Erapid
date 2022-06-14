<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java" contentType="text/xml;charset=UTF-8" %><jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/><jsp:useBean id="priceCalc" class="com.csgroup.general.PriceCalcBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
	String orderNo=request.getParameter("orderNo");
	String totalCost=request.getParameter("totalCost");
	String totalTax=request.getParameter("totalTax");
	String total=request.getParameter("total");
	String weightEst=request.getParameter("weightEst");
	String weight=request.getParameter("weight");
	String distance=request.getParameter("distance");
	String transport=request.getParameter("transport");
	String installDistance=request.getParameter("installDistance");
	String installDiscount=request.getParameter("installDiscount");
	String overage=request.getParameter("overage");
	String setupCost=request.getParameter("setupCost");
	String handlingCost=request.getParameter("handlingCost");
	String freightCost=request.getParameter("freightCost");
	String shipZip=request.getParameter("shipZip");
	String taxExempt=request.getParameter("taxExempt");
	String freightOverride=request.getParameter("freightOverride");
	String commission=request.getParameter("commission");
//logger.debug("priceCalcChange"+commission+"::"+totalCost);
	if(taxExempt != null && taxExempt.equals("true")){
		taxExempt="Y";
	}
	else{
		taxExempt="N";
	}
	if(freightOverride !=null && freightOverride.equals("true")){
		freightOverride="Y";
	}
	else{
		freightOverride="N";
	}
	if(installDistance==null || installDistance.trim().length()==0){
		installDistance="0";
	}
	if(installDiscount==null || installDiscount.trim().length()==0){
		installDiscount="0";
	}
	if(transport==null || transport.trim().length()==0){
		transport="0";
	}
	if(distance==null || distance.trim().length()==0){
		distance="0";
	}
	priceCalc.setOrderNo(orderNo);

	result=priceCalc.savePriceCalc(orderNo,totalCost,totalTax,total,weightEst,weight,distance,transport,new Double(installDistance).doubleValue(),new Double(installDiscount).doubleValue(),overage,handlingCost,freightCost,setupCost,"USD","","","",shipZip,taxExempt,freightOverride,userSession.getUserId(),userSession.getGroup(),commission);
}
catch(Exception e){
	logger.debug("priceCalcChange.jsp");
	logger.debug(e.getMessage());
	logger.debug("priceCalcChange.jsp end");
}
%><%=result%>
