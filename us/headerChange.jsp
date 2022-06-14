<% request.setCharacterEncoding( response.getCharacterEncoding() ); %><%@ page language="java"  contentType="text/xml;charset=UTF-8" %><jsp:useBean id="csproject" class="com.csgroup.general.QuoteHeaderBean" scope="page"/><%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String result="";
try{
logger.debug("orderNo"+"::"+request.getParameter("orderNo"));
logger.debug("archName"+"::"+request.getParameter("archName"));
String orderNo=request.getParameter("orderNo");
String projectName=request.getParameter("projectName");
String custName=request.getParameter("custName");
String agentName=request.getParameter("agentName");
String custNo=request.getParameter("custNo");
String custLoc=request.getParameter("custLoc");
String jobLoc=request.getParameter("jobLoc");
String projectState=request.getParameter("projectState");
String archName=request.getParameter("archName");
String archLoc=request.getParameter("archLoc");
String exclusions=request.getParameter("exclusions");
String qualifyingNotes=request.getParameter("qualifyingNotes");
String terriRep=request.getParameter("terriRep");
String marketType=request.getParameter("marketType");
String projectState2=request.getParameter("projectState");
String internalNo=request.getParameter("internalNo");
String marketing=request.getParameter("marketing");
String winLoss=request.getParameter("winLoss");
String docType=request.getParameter("docType");
String quoteType=request.getParameter("quoteType");
String docDate=request.getParameter("docDate");
String entryDate=request.getParameter("entryDate");
String expiresDate=request.getParameter("expiresDate");
String winLossDesc=request.getParameter("winLossDesc");
String exclusionsFreeText=request.getParameter("exclusionsFreeText");
String qualifyingNotesFreeText=request.getParameter("qualifyingNotesFreeText");
String freeText=request.getParameter("freeText");
String internalNotes=request.getParameter("internalNotes");
String qtype=request.getParameter("qtype");
String product=request.getParameter("product");
String repNum=request.getParameter("repNum");
String altCpyNo=request.getParameter("altCpyNo");
String userId=request.getParameter("userId");
String projectType=request.getParameter("projectType");
String projectTypeId=request.getParameter("projectTypeId");
String showRecap=request.getParameter("showRecap");
String exchRate=request.getParameter("exchRate");
String exchDate=request.getParameter("exchDate");
String exchName=request.getParameter("exchName");
String groupCodes=request.getParameter("groupCodes");
String constructionType=request.getParameter("constructionType");
String endUser=request.getParameter("endUser");
String salesRegion=request.getParameter("salesRegion");
String bpcsOrderNo=request.getParameter("bpcsOrderNo");
String pricingOptions =request.getParameter("pricingOptions");
String pricingOptionsFree =request.getParameter("pricingOptionsFree");
String instructions=request.getParameter("instructions");
String shipAttention=request.getParameter("shipAttention");
String docStage=request.getParameter("docStage");
String changeCustomer=request.getParameter("changeCustomer");
String changeArch=request.getParameter("changeArch");
String taxExempt=request.getParameter("taxExempt");
String taxZip=request.getParameter("taxZip");
if(showRecap.equals("true")){
	showRecap="on";
}
else{
	showRecap="N";
}
if(docStage.equals("true")){
	docStage="Y";
}
else{
	docStage="N";
}

//csproject.saveHeader(orderNo,projectName,custName,custLoc,jobLoc,projectState,archName,archLoc,exclusions,qualifyingNotes,terriRep,marketType,projectState2,internalNo,winLoss,docType,docDate,entryDate,expiresDate,winLossDesc,exclusionsFreeText,qualifyingNotesFreeText,freeText,internalNotes,qtype,product,repNum,altCpyNo,custNo,userId,agentName,projectType,projectTypeId,quoteType,showRecap,exchName,exchRate,exchDate,groupCodes,salesRegion,constructionType,endUser,bpcsOrderNo,pricingOptions,pricingOptionsFree,instructions);
csproject.saveHeader(orderNo,projectName,custName,custLoc,jobLoc,projectState,archName,archLoc,exclusions,qualifyingNotes,terriRep,marketType,projectState2,internalNo,winLoss,docType,docDate,entryDate,expiresDate,winLossDesc,exclusionsFreeText,qualifyingNotesFreeText,freeText,internalNotes,qtype,product,repNum,altCpyNo,custNo,userId,agentName,projectType,projectTypeId,quoteType,showRecap,exchName,exchRate,exchDate,groupCodes,salesRegion,constructionType,endUser,bpcsOrderNo,pricingOptions,pricingOptionsFree,instructions,docStage,changeCustomer,changeArch,taxZip,taxExempt);


String temporderno=csproject.getOrderNo();
csproject.setOrderNo(temporderno);
result=csproject.getXml();
//logger.debug(result);
}
catch(Exception e){
	logger.debug("headerChange.jsp");
	logger.debug(e.getMessage());
	logger.debug("headerChange.jsp end");
}
%><%=result.trim()%>