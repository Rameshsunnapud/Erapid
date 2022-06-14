<% request.setCharacterEncoding( response.getCharacterEncoding() ); %>
<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" import="java.io.*"   contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="error.jsp" %>
<%
	String pageName="lineitem";


%>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/>
<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>

<!DOCTYPE html>
<html>
	<head>
		<link rel='stylesheet' href='../css/styleMainSFDC.css' type='text/css' />
	</head>
	<%
	String colorKey="";
	String bgcolorx="";

	if(userSession.getUserId() != null && userSession.getUserId().trim().length()>0){
		if(pageName.equals("lineitem")){
	%>
	<body onload='isNew()' >
		<%
}
else{

		%>
	<body >
		<%
	}
}
else{
		%>
	<body onload='userSessionEmpty()' >
		<%
	}
	String message=erapidBean.getMessageUS();
	String messageType=erapidBean.getMessageTypeUS();

		String userSecurity=userSession.getUserSecurity().replaceAll("%GROUP%",userSession.getGroup());

		userSecurity=userSecurity.replaceAll("%REPNO%",userSession.getRepNo());
		%>




		<script language="JavaScript" src="../javascript/ajax.js"		></script>
		<script language="JavaScript" src="../javascript/lineItemUSSFDC.js"	></script>

		<script language="JavaScript" src="../test/date-picker.js"		></script>
		<script language="JavaScript" src="../javascript/polishCharacters.js"></script>
		<jsp:useBean id="quoteHeader" 	class="com.csgroup.general.QuoteHeaderBean"		scope="page"/>
		<jsp:useBean id="docHeader"		class="com.csgroup.general.DocHeaderBean" 		scope="page"/>
		<jsp:useBean id="currency"		class="com.csgroup.general.CurrencyBean" 		scope="page"/>
		<jsp:useBean id="quoteLines"		class="com.csgroup.general.LineItemBean" 		scope="page"/>
		<jsp:useBean id="priceCalc"		class="com.csgroup.general.PriceCalcBean" 		scope="page"/>
		<jsp:useBean id="customer" 		class="com.csgroup.general.CustomerBean" 		scope="page"/>
		<jsp:useBean id="buttons" 		class="com.csgroup.general.ButtonsBean" 		scope="page"/>
		<jsp:useBean id="validation" 		class="com.csgroup.general.ValidationBean" 		scope="page"/>
		<%
		org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
		String orderNo="";
		String altCpyNo="";
		String qtype="";
		String product="";
		String repNum="";
		String noteDate="";
		String repEmail="";
		String psaNo="";
		String bpcsOrderNo="";
		String creatorUserName="";
		String creatorGroup="";
		String SFDCpage="";
		String exchName="";
		String exchDate="";
		String exchRate="";
		String repQuote="";
		String repTear="";
		String projectType="";
		String type="";
		boolean isBpcsClosed=false;
		boolean isCDN=false;
		java.util.Date date=new java.util.Date();
		String tempdate=""+date.getTime();
		String dirname="d:/erapid/shared/email/"+tempdate;
		String quoteOrigin="";
		String env="";
		try{
			java.util.Date uDate = new java.util.Date(); // Right now
			java.sql.Date sDate = new java.sql.Date(uDate.getTime());
			String sDate2=""+sDate;
			noteDate=sDate2.substring(8)+"/"+sDate2.substring(5,7)+"/"+sDate2.substring(0,4);
			orderNo=request.getParameter("orderNox");
			if(request.getParameter("env") != null && !request.getParameter("env").isEmpty()){
			 env=request.getParameter("env");
		    }
			altCpyNo=request.getParameter("altCpyNox");
			product=request.getParameter("product");
			psaNo=request.getParameter("psaNo");
			SFDCpage=request.getParameter("page");
			qtype=request.getParameter("qtype");
			String userRepNo=request.getParameter("userRepNo");
			repNum=request.getParameter("altRep");
			String repNumTemp=request.getParameter("repNum");
			//out.println(repNum+"::1");
			if(repNumTemp != null && repNumTemp.trim().length()>0 && (repNum == null || repNum.trim().length()==0)){
				repNum=repNumTemp;
			}
			//out.println(repNum+"::2");
			//repNum=request.getParameter("repNum");
			if(repNum == null || repNum.trim().length()==0){
				if(userRepNo!= null && userRepNo.trim().length()>0){
					repNum=userRepNo;
				}
			}
			if(request.getParameter("doc_number") != null && request.getParameter("doc_number").trim().length()>0){
				orderNo=request.getParameter("doc_number");
			}
			if(request.getParameter("order_no") != null && request.getParameter("order_no").trim().length()>0){
				orderNo=request.getParameter("order_no");
			}
			if(orderNo==null||orderNo.trim().equals("null")){
				orderNo="";
			}
			if(orderNo.trim().length()>0){
				quoteHeader.setOrderNo(orderNo);
				projectType=quoteHeader.getProjectType();
				//logger.debug(orderNo+":::"+quoteHeader.getProjectType()+"::"+quoteHeader.getProjectTypeId());
				if(quoteHeader.getProjectType().equals("SFDC")){
					//type=quoteHeader.checkSFDCType(quoteHeader.getProjectTypeId());
					//logger.debug(quoteHeader.getProjectTypeId()+":: project type id");
					//logger.debug(type+"::type");
					type=quoteHeader.getExchName();
					if(type.toUpperCase().indexOf("CAD")>=0){
						type="CA";
						String tempExchRate=quoteHeader.getExchRate();
						if(tempExchRate==null || tempExchRate.trim().length()==0){
							currency.updateExchange(orderNo,type);
						}
					}
					quoteHeader.setOrderNo(orderNo);
				}
				product=quoteHeader.getProductId();
				//out.println(product+"::::");
				docHeader.setOrderNo(orderNo);
				qtype=quoteHeader.getQuoteType();
				repNum=quoteHeader.getCreatorId();
				repEmail=quoteHeader.getRepEmail();
				bpcsOrderNo=quoteHeader.getBpcsOrderNo();
				if(bpcsOrderNo!=null && bpcsOrderNo.trim().length()>0){
					isBpcsClosed=validation.checkBpcsOrderClose(bpcsOrderNo);
				}
				else{
					bpcsOrderNo="";
				}
				exchRate=quoteHeader.getExchRate();
				exchDate=quoteHeader.getExchDate();
				exchName=quoteHeader.getExchName();
				quoteOrigin=quoteHeader.getQuoteOrigin();
				if(exchName.equals("CAD")){
					isCDN=true;
					exchDate=exchDate.substring(0,10);
				}
				creatorUserName=quoteHeader.getCreatorUserName();
				creatorGroup=quoteHeader.getCreatorGroup();
				repQuote=quoteHeader.getRepQuote();
				repTear=quoteHeader.getRepTear();
				//logger.debug(quoteHeader.getProjectType());
				if(quoteHeader.getProjectType().equals("web")){
					//out.println("WEB ORDER");
		%>
		<%@ include file="legacy/import_web_order.jsp"%>
		<%
	}

}
else if(qtype != null && qtype.trim().length()>0){
	repNum=userSession.getRepNo();
}


		%>

		<div id='pbHeader'>
			<table border='0' cellpadding='0' cellspacing='0'>
				<tbody><tr><td class='pbTitle'>
							<img src="https://c-sgroup.my.salesforce.com/s.gif" alt="" width="1" height="1" class="minWidth" title="">
							<h2 class='mainTitle'>Quotation Detail</h2></div></td>
						<td class='pbButton'>
							<div id='headerButtonsDiv'></div>
						</td>
					</tr></tbody>
			</table>
		</div>
		<div class='test'>
			<table border='0' cellpadding='0' cellspacing='0'>
				<tbody><tr><td class='pbTitle'>
							<img src="https://c-sgroup.my.salesforce.com/s.gif" alt="" width="1" height="1" class="minWidth" title="">
							<h3 class='mainTitle'>Information</h3></div></td>
					</tr></tbody>
			</table>
		</div>
		<div class='pbBody'>
			<div class="pbSubsection">
				<table class="detailList" cellspacing="0" cellpadding="0" border="0" >

					<tbody>
						<tr>
							<td class="labelCol">Quote Number</td>
							<td class="dataCol"><%=quoteHeader.getOrderNo()%></td>
							<td class="labelCol">Project</td>
							<td class="dataCol"><%=quoteHeader.getProjectName()%></td>

						</tr>
						<tr>
							<td class="labelCol">Type</td>
							<td class="dataCol"><%=quoteHeader.getQuoteType()%>

								<%
								out.println("<label id='bpcsClosedLabel'>");
								if(isBpcsClosed){
									out.println("<FONT COLOR='RED'>"+bpcsOrderNo+"&nbsp;CLOSED IN BPCS</FONT>");
								}
								out.println("</label>");
								if(isCDN){
									out.println("<a name ='cdn1' title=' Name:"+exchName+"\r\n Rate:"+exchRate+"\r\n Date:"+exchDate+"' onclick=isCanada('"+exchName+"','"+exchRate+"','"+exchDate+"')><img id='cdnFlag1' src='../images/flag-ca.png' width='20px'></a>");
								}
								else{
									out.println("<a name ='cdn1' title=''><img id='cdnFlag1' src='../images/flag-ca.png' width='20px'  style='visibility:hidden' ></a>");
								}
								%>

							</td>
							<td class="labelCol">Status</td>
							<td class="dataCol"><%=docHeader.getWinLoss()%></td>
						</tr>
						<tr>
							<td class="labelCol">Quote Type</td>
							<td class="dataCol"><%=quoteHeader.getDocPriorityName()%></td>
							<td class="labelCol">Entry Date</td>
							<td class="dataCol"><%=docHeader.getEntryDate()%></td>
						</tr>
						<tr>
							<td class="labelCol">Product Id</td>
							<td class="dataCol"><%=product%></td>
							<td class="labelCol">Bid Date</td>
							<td class="dataCol"><%=docHeader.getDocDate()%></td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class='test'>
				<table border='0' cellpadding='0' cellspacing='0'>
					<tbody><tr><td class='pbTitle'>
								<img src="https://c-sgroup.my.salesforce.com/s.gif" alt="" width="1" height="1" class="minWidth" title="">
								<h3 class='mainTitle'>Price Calculator</h3></div></td>
							<td class='pbButton'>
								<input value='Edit Price' class='btn' title='Edit Price' name='priceCalc' type='button' onclick='editPrice()'>
								<input value='Send to Salesforce' class='btn' title='Send to Salesforce' name='priceCalc' type='button' onclick=''>
							</td>



						</tr></tbody>
				</table>
			</div>
			<div class="priceCalcSFDC" id='priceCalcSFDC'>

				<%

if((product.equals("LVR")||product.equals("GRILLE")) && userSession.getGroup().toUpperCase().indexOf("REP")<0 && creatorGroup.toUpperCase().indexOf("REP")<0){
				%>a
				<%@ include file="cranPriceCalc.jsp"%>
				<%
			}
			else if((product.equals("LVR")||product.equals("GRILLE")) && userSession.getGroup().toUpperCase().indexOf("REP")>=0 && creatorGroup.toUpperCase().indexOf("REP")<0){
				%>
				<%//@ include file="cranPriceCalcRep.jsp"%>
				<%
			}
			else if (product.equals("ADS")&& userSession.getGroup().toUpperCase().indexOf("REP")<0){
				%>
				<%//@ include file="adsPriceCalc.jsp"%>
				<%
			}
			else{%>


				<div id='pricecalc2' class='pricecalc'>
					<form name='priceCalcForm2'>
						<%
						out.println("<input type='hidden' name='installPriceLabel' id=installPriceLabel value=''>");
						out.println("<input type='hidden' name='installTotalLabel' id='installTotalLabel' value=''>");
						out.println("<input type='hidden' name='transportLabel' id='transportLabel' value=''>");
						out.println("<input type='hidden' name='transportTotalLabel' id='transportTotalLabel' value=''>");
						out.println("<input type='hidden' name='totalPriceLabel' id='totalPriceLabel' value=''>");
						out.println("<input type='hidden' name='installNotesLabel' id='installNotesLabel' value=''>");
						%>
						<table class="detailList" cellspacing="0" cellpadding="0" border="0" >

							<tbody>
								<tr>
									<td class="labelCol">Total Cost :</td>
									<td class="dataCol" colspan='3'><label id='totalCostLabel'></label></td>

								</tr>
								<%
								String hiddenLabels="";
								if(priceCalc.labelCharges("overage",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"overage",repNum,product)).length()>0){
								%>
								<tr>
									<td class="labelCol"><%=priceCalc.labelCharges("overage",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"overage",repNum,product))%>: </td>
									<td align='right' class="dataCol" colspan='3'><label id='overageLabel'></label></td>

								</tr>
								<%
							}
							else{
								hiddenLabels=hiddenLabels+"<label id='overageLabel' style='visibility: hidden;'></label>";
							}
							if(priceCalc.labelCharges("setup",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"setup",repNum,product)).length()>0){
								%>
								<tr>
									<td class="labelCol"><%=priceCalc.labelCharges("setup",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"setup",repNum,product))%>: </td>
									<td align='right' class="dataCol" colspan='3'><label id='setupCostLabel'></label></td>

								</tr>
								<%
					}
					else{
						hiddenLabels=hiddenLabels+"<label id='setupCostLabel' style='visibility: hidden;'></label>";
					}
					if(priceCalc.labelCharges("handling",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"handling",repNum,product)).length()>0){

								%>
								<tr>
									<td class="labelCol"><%=priceCalc.labelCharges("handling",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"handling",repNum,product))%>: </td>
									<td align='right' class="dataCol" colspan='3'><label id='handlingCostLabel'></label></td>

								</tr>
								<%
					}
					else{
						hiddenLabels=hiddenLabels+"<label id='handlingCostLabel' style='visibility: hidden;'></label>";
					}
					if(priceCalc.labelCharges("freight",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"freight",repNum,product)).length()>0){

								%>
								<tr>
									<td class="labelCol"><%=priceCalc.labelCharges("freight",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"freight",repNum,product))%>: </td>
									<td align='right' class="dataCol" colspan='3'><label id='freightCostLabel'></label></td>
								</tr>
								<%
					}
					else{
						hiddenLabels=hiddenLabels+"<label id='freightCostLabel' style='visibility: hidden;'></label>";
					}
								%>
								<tr>
									<td class="labelCol">Tax Total (<label id='taxRateLabel'>%</label>): </td>
									<td align='right' class="dataCol" colspan='3'><label id='totalTaxLabel'><font color='red'>calculating</font></label></td>

									<!--<<td align='right'>Zip:<label id='taxZipLabel'></label>&nbsp;</td>-->
								</tr>
								<tr>
									<td class="labelCol">Total : </td>
									<td align='right' class="dataCol" colspan='3'><label id='totalLabel'><font color='red'>calculating</font></label></td>

									<!--<<td align='right'>Is Valid Zip:<label id='IsValidZipLabel'></label>&nbsp;</td>-->
								</tr>

						</table>

						<%=hiddenLabels%>
					</form>
					<%


					%>
				</div>


				<%

								}
				%>
			</div>
			<div class='test'>
				<table border='0' cellpadding='0' cellspacing='0'>
					<tbody><tr><td class='pbTitle'>
								<img src="https://c-sgroup.my.salesforce.com/s.gif" alt="" width="1" height="1" class="minWidth" title="">
								<h3 class='mainTitle'>Quote Line Items</h3></td>
						</tr></tbody>
				</table>
			</div>
			<div class="lineItems" id='lineItems'>

			</div>


		</div>
		<%
				}
				catch(Exception e){
				logger.debug("START ERROR lineItem.jsp");
				logger.debug("Exception:"+e.getMessage());
				logger.debug("User ID:"+userSession.getUserId());
				logger.debug("User Name:"+userSession.getUserName());
				logger.debug("Order Number:"+userSession.getOrderNo());
				logger.debug("Country: "+userSession.getCountry());
				logger.debug("END ERROR");
				out.println("ERROR: CONTACT ERAPID TEAM");
				out.println("::"+e);
				}


		%>

		<%
						String emailUrl="http://sec-avscan.c-sgroup.com/erapid/erapidintl3/uploadinit_us.jsp?order_no="+orderNo +"&dirname="+tempdate +"&group="+userSession.getGroup();
						if(application.getInitParameter("HOST").toUpperCase().indexOf("DEV")>0){
							emailUrl="http://sec-avscan.c-sgroup.com/erapid/erapidintl3/test/uploadinit_us.jsp?order_no="+orderNo +"&dirname="+tempdate +"&group="+userSession.getGroup();
						}
						//out.println(product+":: product3<BR>");
		%>
		<!--</form>-->
		<%

		%>
		<form name='form1'>
			<input type='hidden' name='today' value='<%=noteDate%>- '>
			<input type='hidden' name='params' value=''>
			<input type='hidden' name='orderNo' value='<%=orderNo%>'>
			<input type='hidden' name='bpcsNo' value='<%=bpcsOrderNo%>'>
			<input type='hidden' name='psaNo' value='<%=psaNo%>'>
			<input type='hidden' name='altCpyNo' value='<%=altCpyNo%>'>
			<input type='hidden' name='qtype' value='<%=qtype%>'>
			<input type='hidden' name='reload' value=''>
			<input type='hidden' name='product' value='<%=product%>'>
			<input type='hidden' name='repNum' value='<%=repNum%>'>
			<input type='hidden' name='userCountryCode' value='US'>
			<input type='hidden' name='userId' value='<%=userSession.getUserId()%>'>
			<input type='hidden' name='userRepNo' value='<%=userSession.getRepNo()%>'>
			<input type='hidden' name='userName' value='<%=userSession.getUserName()%>'>
			<input type='hidden' name='group' value='<%=userSession.getGroup()%>'>
			<input type='hidden' name='fullServerName' value='<%=erapidBean.getFullServerName()%>'>
			<input type='hidden' name='creatorUserName' value='<%=creatorUserName%>'>
			<input type='hidden' name='creatorGroup' value='<%=creatorGroup%>'>
			<input type='hidden' name='SFDCpage' value='<%=SFDCpage%>'>
			<input type='hidden' name='url' value='updateHeader.jsp'>
			<input type='hidden' name='url2' value='headerChange.jsp'>
			<input type='hidden' name='url3' value='priceCalcSFDC.jsp'>
			<input type='hidden' name='url4' value='priceCalcShow.jsp'>
			<input type='hidden' name='url5' value='getButtons.jsp'>
			<input type='hidden' name='url6' value='newHeader.jsp'>
			<input type='hidden' name='url7' value='altHeader.jsp'>
			<input type='hidden' name='url8' value='updateLines.jsp'>
			<input type='hidden' name='url9' value='deleteLines.jsp'>
			<input type='hidden' name='url10' value='emailBean.jsp'>
			<input type='hidden' name='url11' value='emailCheckBox.jsp'>
			<input type='hidden' name='url12' value='priceCalcCharges.jsp'>
			<input type='hidden' name='url13' value='psaHeader.jsp'>
			<input type='hidden' name='url14' value='getLVRRepPrice.jsp'>
			<input type='hidden' name='owsUrl' value='https://<%=application.getInitParameter("HOST")%>/erapid/us/orders/ows/order_entry_transfer_home.jsp?orderNo=<%=orderNo %>&cmd=1&username=<%=userSession.getUserId()%>'>
			<input type='hidden' name='emailUrl' value='<%=emailUrl%>'>
			<input type='hidden' name='cranPriceCalcUrl' value='https://<%=application.getInitParameter("HOST")%>/erapid/us/legacy/order_transfer_home.jsp?orderNo=<%=orderNo %>&cmd=1'>
			<input type='hidden' name='cranPriceCalcRepUrl' value='https://<%=application.getInitParameter("HOST")%>/erapid/us/legacy/access_central_rep.jsp?orderNo=<%=orderNo %>&cmd=1'>
			<input type='hidden' name='repQuote' value='<%=repQuote%>'>
			<input type='hidden' name='repTear' value='<%=repTear%>'>
			<input type='hidden' name='projectType' value='<%=projectType%>'>
			<input type='hidden' name='quoteOrigin' value='<%=quoteOrigin%>'>
			<input type='hidden' name='exchName'>
			<input type='hidden' name='exchRate'>
			<input type='hidden' name='exchRateDate'>
			<%
			if(quoteHeader.getProjectType()!=null && quoteHeader.getProjectType().trim().equals("SFDC")){
				if(application.getInitParameter("HOST").toUpperCase().indexOf("DEV")>0){
					if(env.equalsIgnoreCase("sit")){
						out.println("<input type='hidden' name='sfdcUrl' value='https://c-sgroup--sit.my.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1'>");
					}else if(env.equalsIgnoreCase("UAT")){
						out.println("<input type='hidden' name='sfdcUrl' value='https://c-sgroup--uat.my.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1'>");
					}else if(env.equalsIgnoreCase("maya") || env.equalsIgnoreCase("dev")){
	                   out.println("<input type='hidden' name='sfdcUrl' value='https://c-sgroup--dev.my.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1'>");	
					}else{
	                    out.println("<input type='hidden' name='sfdcUrl' value='https://c-sgroup--sit.my.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1'>");
					}
					//out.println("<input type='hidden' name='sfdcUrl' value='https://c.cs3.visual.force.com/apex/TestLink?quoteNO="+orderNo+"1'>");
				}
				else{
					out.println("<input type='hidden' name='sfdcUrl' value='https://na44.salesforce.com/apex/TestLink?quoteNO="+orderNo+"1'>");
				}
			}
			else{
				out.println("<input type='hidden' name='sfdcUrl' value=''>");
			}
			%>

		</form>




		<div id='secDiv' class='secDivision' >
			<iframe id='secIframe' height='95%' width='100%' frameborder="0" src="http://<%=application.getInitParameter("HOST")%>/erapid/us/legacy/sections.home.jsp?orderNo=<%=orderNo %>&cmd=1&env=<%=env%>"></iframe>
		</div>
		<div id='owsDiv' class='owsDivision' >
			<iframe id='owsIframe' height='95%' width='100%' frameborder="0" ></frame>
		</div>


	</body>
</html>