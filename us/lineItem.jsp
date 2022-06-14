<% request.setCharacterEncoding( response.getCharacterEncoding() ); %>
<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" import="java.io.*"   contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="error.jsp" %>
<%
		org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String pageName="lineitem";
%>

<%@ include file="header.jsp"%>
<div	class='container'	id='container'	>
	<div	class='mainbody' 	id='mainbody'	>
	
		<script language="JavaScript" src="../javascript/ajax.js"		></script>
		<script language="JavaScript" src="../javascript/lineItemUS.js"	></script>
		<script language="JavaScript" src="../javascript/headerLineUS.js"	></script>
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
                String template="";
		String type="";
		boolean isBpcsClosed=false;
		boolean isCDN=false;
		java.util.Date date=new java.util.Date();
		String tempdate=""+date.getTime();
		String dirname="d:/erapid/shared/email/"+tempdate;
		String quoteOrigin="";
		String sfdc_QuoteId="";
		String env="";
		try{
			java.util.Date uDate = new java.util.Date(); // Right now
			java.sql.Date sDate = new java.sql.Date(uDate.getTime());
			String sDate2=""+sDate;
			noteDate=sDate2.substring(8)+"/"+sDate2.substring(5,7)+"/"+sDate2.substring(0,4);
			orderNo=request.getParameter("orderNox");
			//env=request.getParameter("env");
			if(request.getParameter("env") != null && !request.getParameter("env").isEmpty()){
			 env=request.getParameter("env");			
		    }			
			
			//out.println("env ::  "+env);
			if(env.isEmpty()){
				env = userSession.getEnv();
			}
			//out.println(orderNo+":: order number");
			altCpyNo=request.getParameter("altCpyNox");
			product=request.getParameter("product");
			psaNo=request.getParameter("psaNo");
			SFDCpage=request.getParameter("page");
			qtype=request.getParameter("qtype");
			String userRepNo=request.getParameter("userRepNo");
			repNum=request.getParameter("altRep");
			String repNumTemp=request.getParameter("repNum");
			//out.println(repNum+"::1 IN LINE ITEM PAGE ");


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
				sfdc_QuoteId = quoteHeader.getSFDC_QuoteId();
				//out.println(sfdc_QuoteId+"::SFDC_QuoteId");
				projectType=quoteHeader.getProjectType();
				template=quoteHeader.getTemplate();
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
//out.println(product+":: product");
out.println("<div id='displayHeader' class='lineItemHeader'><br><table border=0 width='100%'>");
out.println("<tr><td width='10%'>Quote No</td><td width='40%'><b><label id='orderNoLabel'>"+quoteHeader.getOrderNo()+"</label></b></td>");
//	out.println("<td width='10%'>Quote Type</td><td width='30%'><b><label id='quoteTypeLabel'>"+quoteHeader.getQuoteType()+"</label></b></td>");
out.println("<td width='10%'>Type</td><td width='30%' valign='center'><b><label id='quoteTypeLabel'>"+quoteHeader.getQuoteType()+"</label></b>");
out.println("<label id='bpcsClosedLabel'>");
if(isBpcsClosed){
	out.println("<FONT COLOR='RED'>"+bpcsOrderNo+"&nbsp;CLOSED IN BPCS</FONT>");
}
out.println("</label>");
//out.println(isCDN+"::"+exchName+"::");
if(isCDN){
	out.println("<a name ='cdn1' title=' Name:"+exchName+"\r\n Rate:"+exchRate+"\r\n Date:"+exchDate+"' onclick=isCanada('"+exchName+"','"+exchRate+"','"+exchDate+"')><img id='cdnFlag1' src='../images/flag-ca.png' width='20px'></a>");
}
else{
	out.println("<a name ='cdn1' title=''><img id='cdnFlag1' src='../images/flag-ca.png' width='20px'  style='visibility:hidden' ></a>");
}
out.println("</td>");
out.println("<td width='10%' rowspan='4' valign='top'><input type='button' name='Edit' value='Header' class='button2' onclick='editHeader()'><BR><input type='button' name='Price' value='Price Calc' class='button2' onclick='editPrice()'>	");
//if(quoteHeader.getProjectType().equals("SFDC")){
out.println("<input type='button' name='lineItemScreen' value='Line Item' class='button2' onclick='lineItemScreen()'>");
//}
out.println("<div id='headerButtonsDiv'></div>");
out.println("</td></tr>");
out.println("<tr><td>Project Name</td><td><b><label id='projectNameLabel'>"+quoteHeader.getProjectName()+"</label></b></td>");
//out.println("<tr><td width='10%'>SFDC_QuoteId GSO</td><td width='40%'><b><label id='orderNoLabel'>"+sfdc_QuoteId+"</label></b></td>");
out.println("<td>Architect</td><td><b><label id='archNameLabel'>"+quoteHeader.getArchName()+"</label></b></td></tr>");
String tempwinloss=docHeader.getWinLoss();
out.println("<tr><td>Status </td><td><b><label id='winLossLabel'>"+tempwinloss+"</label></b></td>");
out.println("<td>Rep Number</td><td><b><label id='docSalesPersonLabel'>"+quoteHeader.getCreatorId()+"</label></b></td></tr>");
out.println("<tr><td>Bid Date</td><td><b><label id='docHeaderLabel'>"+docHeader.getDocDate()+"</label></b></td>");
out.println("<td>Entry Date</td><td><b><label id='entryDateLabel'>"+docHeader.getEntryDate()+"</label></b></td> </tr>");
if(product.equals("IWP")||product.equals("EFS")||product.equals("EJC")||product.equals("GCP")){
out.println("<tr><td>Quote Type</td><td><b><label id='docHeaderLabel'>"+quoteHeader.getDocPriorityName()+"</label></b></td>");
out.println("<td>&nbsp;</td><td>&nbsp;</td> </tr>");
}
out.println("</table><Br>&nbsp;<BR></div>");
quoteLines.setOrderNo(orderNo);
String[] lineNo=quoteLines.getLineNo();

String[] productId=quoteLines.getProductId();
String[] description=quoteLines.getDescription();
String[] extendedPrice=quoteLines.getExtendedPrice();
String[] field19=quoteLines.getField19();
String[] status=quoteLines.getStatus();
int rowcount=0;
out.println("<div class='lineItems' id='lineItems'></div>");
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
		<div id='header' class='headerbody'  >
			<div  class='customer' id="customerx">
				<div id='customerTEST'>
					<form name='custSearchHeader'>
						<table width='1180px;' border='0'>
							<tr class='header1'><td>
									<h3>Customer Profile</h3></td></tr>
						</table>
						<input type='hidden' name='selectx' value='no'>
						<input type='hidden' name='searchCustomerRepNo' value='<%=userSession.getRepNo() %>'>
						<input type='hidden' name='searchCustomerRepGroup' value='<%=userSession.getGroup() %>'>
						<input type='hidden' name='searchCustomerRepCountry' value='<%=userSession.getCountry() %>'>
						<table width='1180px;' border='0'>
							<tr>
								<td>
									Customer
								</td>
								<td>
									<input type='text' name='searchCustomerCustomerName' onkeyup='JavaScript:changeCustomerSearchHeader("customerSearchBean.jsp")' class='text2'>
								</td>

								<td>
									City
								</td>
								<td>
									<input type='text' name='searchCustomerCity' onkeyup='JavaScript:changeCustomerSearchHeader("customerSearchBean.jsp")' class='text2'>
									<input type='hidden' name='searchCustomerTaxNo' value=''>
								</td>
								<td>
									BpcsNo
								</td>
								<td>
									<input type='text' name='searchCustomerBpcsNo' onkeyup='JavaScript:changeCustomerSearchHeader("customerSearchBean.jsp")' class='text2'>
								</td>
							</tr>
							<tr>
								<td colspan='6' align='center'>
									<input type='button' name='add' value='New Customer' onclick='addCustomer2()' class='button'>
									<input type='button' name='cancel' value='Cancel' onclick='goHome()' class='button'>
								</td>
							</tr>
						</table>
					</form>
				</div>
				<div id='customerSearchResultsHeader' ></div>
			</div>
			<div id='customerEditHeader' class='customer'>
				<form name='editCustomer'>
					<%

					out.println("<input type='hidden' name='custNo' value=''>");
					out.println("<input type='hidden' name='isUse' value=''>");
					out.println("<input type='hidden' name='isDup' value=''>");
					out.println("<input type='hidden' name='isStop' value=''>");
					out.println("<input type='hidden' name='countryCode' value=''>");
					out.println("<input type='hidden' name='custNoText' value=''>");
					out.println("<input type='hidden' name='createdRepNo' value=''>");
					out.println("<input type='hidden' name='custName2' value=''>");
					out.println("<input type='hidden' name='attention' value=''>");
					out.println("<input type='hidden' name='salutation' value=''>");
					out.println("<input type='hidden' name='shippingCity' value=''>");
					//out.println("<input type='hidden' name='billCust' value=''>");
					out.println("<input type='hidden' name='marketType' value=''>");
					out.println("<input type='hidden' name='contactName' value=''>");
					//out.println("<input type='hidden' name='bpcsCustNo' value=''>");
					out.println("<input type='hidden' name='currency' value=''>");
					out.println("<table width='1180px;' border='0'> ");
					out.println("<tr class='header1'>");
					out.println("<td colspan='4' align='center'><h3>Customer Profile</h3> </td>");
					out.println("</tr>");
					out.println("<tr>");
					out.println("<td width='25%' align='left'>Customer Name:</td>");
					out.println("<td width='25%' align='left'><input type='text' class='text' name='custName1' value=''></td>");
					out.println("<td width='25%' align='left'>Address 1:</td>");
					out.println("<td width='25%' align='left'><input type='text' class='text' name='custAddr1' value=''></td>");
					out.println("</tr>");
					out.println("<tr>");
					out.println("<td width='25%' align='left'>Address 2:</td>");
					out.println("<td width='25%' align='left'><input type='text' class='text' name='custAddr2' value=''></td>");
					out.println("<td width='25%' align='left'>City:</td>");
					out.println("<td width='25%' align='left'><input type='text' class='text' name='city' value=''></td>");
					out.println("</tr>");
					out.println("<tr>");
					out.println("<td width='25%' align='left'>State:</td>");
					out.println("<td width='25%' align='left'><select name='state'>"+quoteHeader.getPullDownValues(userSession.getCountry(),"*",userSession.getGroup(),"project_state")+"</select></td>");
					out.println("<td width='25%' align='left'>Zip:</td>");
					out.println("<td width='25%' align='left'><input type='text' class='text' name='zipCode' value=''></td>");
					out.println("</tr>");
					out.println("<tr>");
					out.println("<td width='25%' align='left'>Country:</td>");
					out.println("<td width='25%' align='left'><select name='country'>"+quoteHeader.getCountries2()+"</select></td>");
					out.println("<td width='25%' align='left'>Phone:</td>");
					out.println("<td width='25%' align='left'><input type='text' class='text' name='phone' value=''></td>");
					out.println("</tr>");
					out.println("<tr>");
					out.println("<td width='25%' align='left'>Fax:</td>");
					out.println("<td width='25%' align='left'><input type='text' class='text' name='fax' value=''></td>");
					out.println("<td width='25%' align='left'>Email:</td>");
					out.println("<td width='25%' align='left'><input type='text' class='text' name='email' value=''></td>");
					out.println("</tr>");
					out.println("<tr>");
					out.println("<td width='25%' align='left'>BPCS Cust No:</td>");
					out.println("<td width='25%' align='left'><input type='text' name='bpcsCustNo' class='text' value=''></td>");
					out.println("<td width='25%' align='left'>Billing Customer:</td>");
					out.println("<td width='25%' align='left'><input type='checkbox' name='billCust' value=''></td>");
					out.println("</tr>");
					out.println("<tr>");
					out.println("<td colspan='2'>&nbsp;</td>");
					out.println("<td width='25%' align='left'>Dormant:</td>");
					out.println("<td width='25%' align='left'><input type='checkbox' name='dormant' value=''></td>");
					out.println("</tr>");
					out.println("<tr>");
					%>
					<td align='center' colspan='4'><BR>
						<input type='button' name='cancel' value='Cancel' onclick='goHome()' class='button'><input type='button' name='saveCustomer' value='Save' onclick='checkCustomer("stop")' class='button'>
						<%
						out.println("<br><div  id='saveUserCustomerDiv'><input type='button' name='saveUseCustomer' value='Save and Use' onclick='saveUseCustomerx()' class='button'></div>");
						out.println("</td></tr>");
						out.println("</table>");
						%>
				</form>
				<%@ include file="contacts.jsp"%>
			</div>
			<div class='notes' id='notesDiv'>
				<div id='topnotes' class='topnotesx'>
					<table width='100%'><tr><td align='right'>
								<input type='button' name='save' value='Save' onclick='saveNotes()' class='button'><input type='button' name='cancel' value='Cancel' onclick='cancelNotes()' class='button'>
							</td></tr></table>
				</div>
				<div id='bottomnotes' class='bottomnotesx'>
					<form name='notesForm'>
						<table width='90%'>
							<tr>
								<td valign='top'>Exclusions</td>
								<td  valign='top'><%=quoteHeader.getNotes(product,"exclusion") %></td>
							</tr>
							<tr><td colspan='3'>&nbsp;</td></tr>
							<tr>
								<td valign='top'>Qualifying</td>
								<td valign='top'><%=quoteHeader.getNotes(product,"qualify") %></td>
							</tr>
							<tr><td colspan='3'>&nbsp;</td></tr>

							<tr><td colspan='3'>&nbsp;</td></tr>
							<tr>
								<td width='15%' valign='top'>Free Exclusions</td>
								<td width='80%' colspan='3'><textarea name='exclusionsFreeNotesForm' class='headerTextArea'></textarea></td>
							</tr>
							<tr>
								<td valign='top'><label id='testLabel'>Free Qualifying</label> </td>
								<td colspan='3'><textarea  name='qualifyingFreeNotesForm' class='headerTextArea'></textarea></td>
							</tr>
							<tr>
								<td valign='top'>Free Text</td>
								<td colspan='3'><textarea name='freeTextNotesForm' class='headerTextArea'></textarea><input type='hidden' name='internalNotes2NotesForm' ><input type='hidden' name='internalNotesNotesForm' ></td>
							</tr>

						</table>
					</form>
				</div>
			</div>
			<div class='notes' id='notesDiv2'>
				<div id='topnotes' class='topnotesx'>
					<table width='100%'><tr><td align='right'>
								<input type='button' name='save' value='Save' onclick='saveNotes2()' class='button'><input type='button' name='cancel' value='Cancel' onclick='cancelNotes2()' class='button'>
							</td></tr></table>
				</div>
				<div id='bottomnotes' class='bottomnotesx'>
					<form name='notesForm2'>
						<table width='90%'>
							<%
							if(product.equals("LVR")||product.equals("GRILLE")||product.equals("GCP")||product.equals("FSM")){
							%>
							<tr>
								<td valign='top'>Pricing Options</td>
								<td valign='top'><%=quoteHeader.getNotes(product,"pricingOptions") %></td>
							</tr>
							<tr>
								<td valign='top'>Pricing Options</td>
								<td colspan='3'><textarea name='pricingOptionsFree' class='headerTextArea'></textarea></td>
							</tr>
							<%
							}
							else if(projectType.equals("PFL")){
							%>
							<tr>
								<td valign='top'>Internal Notes</td>
								<td colspan='3'><textarea name='instructions' class='headerTextArea'></textarea></td>
							</tr>
							<%}
							%>
						</table>
					</form>
				</div>
			</div>
			<form name='headerForm'>
				<%
				String html="";
				html=html+"<table width='100%' border='0'> ";
				html=html+"<tr class='header1'>";

				html=html+"<td colspan='4' align='right'><center><h3>Header:</h3></center>";

				if(quoteHeader.getOrderNo()!=null && quoteHeader.getOrderNo().length()>0){
				    html=html+"Quote No: <label id='orderNoLabel2'>"+quoteHeader.getOrderNo()+"</label>";
				}
				else if(altCpyNo!=null && altCpyNo.length()>0 && qtype != null && qtype.equals("alt")){
				    html=html+"Alternate of Quote No: <label id='orderNoLabel2'>"+altCpyNo+"</label>";
				}
				else if(altCpyNo!=null && altCpyNo.length()>0 && qtype != null && qtype.equals("cpy")){
				    html=html+"Copy of Quote No: <label id='orderNoLabel2'>"+altCpyNo+"</label>";
				}
				html=html+"</td>";
				html=html+"</tr>";
				html=html+"<tr>";


				if(orderNo.trim().length()>0||(altCpyNo!=null && altCpyNo.length()>0 && qtype != null && (qtype.equals("alt")||qtype.equals("cpy")))){
					html=html+"<td width='25%'></td>";
					html=html+"<td width='25%'><input type='hidden' name='quoteType' value='"+quoteHeader.getDocPriority()+"' readonly></td>";
				}
				else{
					html=html+"<td width='25%'><b>*Quote Type:</b></td>";
					html=html+"<td width='25%'><select name='quoteType' >";
					html=html+quoteHeader.getPullDownValues(userSession.getCountry(),product,userSession.getGroup(),"quoteType");
					html=html+"</select></td>";
				}

				html=html+"<td></td><td></td>";
				html=html+"</tr>";
				html=html+"<tr>";
				html=html+"<td width='25%'>Status:</td>";
				html=html+"<td width='25%'><select name='winLoss'>"+quoteHeader.getPullDownValues(userSession.getCountry(),product,userSession.getGroup(),"status")+"</select></td>";
				html=html+"<td width='25%'>Type:";
				if(isCDN){
					 html=html+"<a name ='cdn2' title='  Name:"+exchName+"\r\n Rate:"+exchRate+"\r\n Date:"+exchDate+"' onclick=isCanada('"+exchName+"','"+exchRate+"','"+exchDate+"')><img id='cdnFlag2' src='../images/flag-ca.png' width='20px'  ></a>";
				}
				else{
					html=html+"<a name ='cdn2' title=''><img id='cdnFlag2' src='../images/flag-ca.png' width='20px'  style='visibility:hidden' ></a>";
				}
				html=html+"</td>";

				html=html+"<td width='25%'><select name='docType' onchange='closeOrder()'>"+quoteHeader.getPullDownValues(userSession.getCountry(),product,userSession.getGroup(),"type")+"</select></td>";
				html=html+"</tr>";
				html=html+"<tr>";
				if(product.equals("GE")&&userSession.getGroup().toUpperCase().indexOf("REP")>=0&&creatorGroup.toUpperCase().indexOf("REP")<0){
					html=html+"<td>Bid Date:</td>";
					html=html+"<td><input type='text' class='text'  name='docDate' >";
					html=html+"</td>";
					html=html+"<td>Entry Date:</td>";
					html=html+"<td><input type='text' class='text'  name='entryDate' ></td>";
					html=html+"</tr>";
					html=html+"<tr>";
					html=html+"<td>Expires Date:</td>";
					html=html+"<td><input type='text' class='text' name='expiresDate' ><input type='hidden' class='text'  name='followUpDate' ></td>";

				}
				else{

					html=html+"<td><a href=\"javascript:show_calendar('headerForm.docDate');\" onmouseover=\"window.status='Date Picker';return true;\" onmouseout=\"window.status='';return true;\">Bid Date:</a></td>";
					html=html+"<td><input type='text' class='text'  name='docDate' >";
					html=html+"</td>";
					html=html+"<td><a href=\"javascript:show_calendar('headerForm.entryDate');\" onmouseover=\"window.status='Date Picker';return true;\" onmouseout=\"window.status='';return true;\">Entry Date:</a></td>";
					html=html+"<td><input type='text' class='text'  name='entryDate' ></td>";
					html=html+"</tr>";
					html=html+"<tr>";
					html=html+"<td><a href=\"javascript:show_calendar('headerForm.expiresDate');\" onmouseover=\"window.status='Date Picker';return true;\" onmouseout=\"window.status='';return true;\">Expires Date:</a></td>";
					html=html+"<td><input type='text' class='text' name='expiresDate' ><input type='hidden' class='text'  name='followUpDate' ></td>";

				}
				html=html+"<td><a href='#' onclick='openCustomer(\"select\")'><b>* CustomerName:</b></a></td>";
				html=html+"<td><input type='text' class='text'  name='custLoc' readonly><input type='hidden' class='text'  name='customer'><input type='hidden'  name='custName' ></td>";
				html=html+"</tr>";
				html=html+"<tr>";
				html=html+"<td><b>* Project Name:</b></td>";
				html=html+"<td><input type='text' class='text' name='projectName'></td>";
				html=html+"<td>Contact Name:</td>";
				html=html+"<td><input type='text' class='text'  name='agentName'></td>";
				html=html+"</tr>";
				html=html+"<tr>";
				if(projectType.equals("PFL")){
					html=html+"<td>Tax Exempt:</td>";
				}
				else{
					html=html+"<td>Project City:</td>";
				}
				html=html+"<td><input type='text' class='text' name='jobLoc'></td>";
				html=html+"<td><b>* Project State:</b></td>";
				html=html+"<td><select name='projectState'>"+quoteHeader.getPullDownValues(userSession.getCountry(),product,userSession.getGroup(),"project_state")+"</select>";
				html=html+"<input type='hidden' name='shipPhone'>";
				html=html+"<input type='hidden' name='quoteSource'>";
				html=html+"<input type='hidden' name='shipName1'>";
				html=html+"<input type='hidden' name='shipCountry'>";
				html=html+"<input type='hidden' name='marketType'>";
				html=html+"<input type='hidden' name='closeDate' >";
				html=html+"<input type='hidden' name='closePerc' >";
				html=html+"<input type='hidden' name='internalNo' >";

				html=html+"<input type='hidden' name='terriRep' >";
				html=html+"<input type='hidden' name='internalNotes2' >";
				html=html+"<input type='hidden' name='winLossDesc' >";
				html=html+"<input type='hidden' name='projectState2' >";
				html=html+"<input type='hidden' name='marketing' >";
				html=html+"<input type='hidden' name='competition' >";
				html=html+"<input type='hidden' name='projectType' value=''>";
				html=html+"<input type='hidden' name='projectTypeId' value=''>";
				html=html+"<input type='hidden' name='exchName' value=''>";
				html=html+"<input type='hidden' name='exchRate' value=''>";
				html=html+"<input type='hidden' name='exchDate' value=''>";
				html=html+"<input type='hidden' name='changeCustomer' value=''>";
				html=html+"<input type='hidden' name='changeArch' value=''>";
				html=html+"<input type='hidden' name='taxExempt' value=''>";
				html=html+"<input type='hidden' name='taxZip' value=''>";
				if(!(product.equals("LVR")||product.equals("GRILLE")||product.equals("GCP")||product.equals("FSM"))){

					html=html+"<input type='hidden' name='pricingOptionsFree' value=''>";
					html=html+"<input type='hidden' name='pricingOptions' value=''>";

				}
				if(!product.equals("GE")){
					//put fields only used for ge as hidden elements for other sbus here
					html=html+"<input type='hidden' name='internalNotes' >";
					html=html+"<input type='hidden' name='groupCodes' >";
					html=html+"<input type='hidden' name='salesRegion' >";
					html=html+"<input type='hidden' name='constructionType' >";
				}
				if(projectType.equals("PFL")){
					html=html+"<input type='hidden' name='constructionType' >";
					html=html+"<input type='hidden' name='internalNotes' >";
				}
				else{
					html=html+"<input type='hidden' name='endUser' >";
					html=html+"<input type='hidden' name='instructions'>";

				}
				if(!product.equals("IWP")||userSession.getGroup().indexOf("REP")>=0){
					html=html+"<input type='hidden' name='docStage'>";
				}
				html=html+"</td></tr>";

				if(product.equals("LVR")||product.equals("GRILLE")||product.equals("GCP")||product.equals("FSM")){

					html=html+"<tr>";
					html=html+"<td><a href='#' onclick=notes('pricing')>Pricing Options Free:</a></td>";
					html=html+"<td><textarea name='pricingOptionsFree' class='texta'></textarea></td>";
					html=html+"<td><a href='#' onclick=notes('pricing')>Pricing Options:</a></td>";
					html=html+"<td><input type='text' class='text'  name='pricingOptions'></td>";
					html=html+"</tr>";
				}
				html=html+"<tr>";
if(product.equals("GE")&&userSession.getGroup().toUpperCase().indexOf("REP")>=0&&creatorGroup.toUpperCase().indexOf("REP")<0){

					html=html+"<td>Free Text/Special Instructions:</td>";

				html=html+"<td><textarea name='freeText' class='texta'></textarea></td>";
				html=html+"<td>Qualifying Notes:</td>";
				html=html+"<td><input type='text' class='text'  name='qualifyingNotes'></td>";
				html=html+"</tr>";
				html=html+"<tr>";

					html=html+"<td>Qualifying Free Text/Lead Times</td>";

				html=html+"<td><textarea name='qualifyingNotesFreeText' class='texta'></textarea></td>";
				html=html+"<td>Exclusion Notes:</td>";
				html=html+"<td><input type='text' class='text'  name='exclusions'></td>";
				html=html+"</tr>";
				html=html+"<tr>";

					html=html+"<td>Exclusions Free/Freight Charges</td>";

				html=html+"<td><textarea name='exclusionsFreeText' class='texta'></textarea></td>";

					if(projectType.equals("PFL")){
						html=html+"<td>Billing Customer Name</td>";
					}
					else{
						html=html+"<td>Architect Name/Billing Customer Name:</td>";
					}
				html=html+"<td><input type='text' class='text'  name='archName' onclick='showArchitect()'></td>";
				html=html+"</tr>";
				html=html+"<tr>";


					if(projectType.equals("PFL")){
						html=html+"<td>&nbsp;</td>";
					}
					else{
						html=html+"<td>Architect City/Billing Customer location:</td>";
					}



}
else{
				if(product.equals("GE")){
					html=html+"<td><a href='#' onclick=notes('bottom')>Free Text/Special Instructions:</a></td>";
				}
				else{
					html=html+"<td><a href='#' onclick=notes('bottom')>Free Text:</a></td>";
				}
				html=html+"<td><textarea name='freeText' class='texta'></textarea></td>";
				html=html+"<td><a href='#' onclick=notes('top')>Qualifying Notes:</a></td>";
				html=html+"<td><input type='text' class='text'  name='qualifyingNotes'></td>";
				html=html+"</tr>";
				html=html+"<tr>";
				if(product.equals("GE")){
					html=html+"<td><a href='#' onclick=notes('bottom')>Qualifying Free Text/Lead Times</a></td>";
				}
				else{
					html=html+"<td><a href='#' onclick=notes('bottom')>Qualifying Free Text:</a></td>";
				}
				html=html+"<td><textarea name='qualifyingNotesFreeText' class='texta'></textarea></td>";
				html=html+"<td><a href='#' onclick=notes('top')>Exclusion Notes:</a></td>";
				html=html+"<td><input type='text' class='text'  name='exclusions'></td>";
				html=html+"</tr>";
				html=html+"<tr>";
				if(product.equals("GE")){
					html=html+"<td><a href='#' onclick=notes('bottom')>Exclusions Free/Freight Charges</a></td>";
				}
				else{
					html=html+"<td><a href='#' onclick=notes('bottom')>Exclusions Free Text</a></td>";
				}
				html=html+"<td><textarea name='exclusionsFreeText' class='texta'></textarea></td>";
				if(product.equals("GE")){
					if(projectType.equals("PFL")){
						html=html+"<td><a href='#' onclick='showArchitect()'>Billing Customer Name</a></td>";
					}
					else{
						html=html+"<td><a href='#' onclick='showArchitect()'>Architect Name/Billing Customer Name:</a></td>";
					}
				}
				else{
					html=html+"<td><a href='#' onclick='showArchitect()'>Architect Name:</a></td>";
				}
				html=html+"<td><input type='text' class='text'  name='archName' onclick='showArchitect()'></td>";
				html=html+"</tr>";
				html=html+"<tr>";

				if(product.equals("GE")){
					if(projectType.equals("PFL")){
						html=html+"<td>&nbsp;</td>";
					}
					else{
						html=html+"<td><a href='#' onclick='showArchitect()'>Architect City/Billing Customer location:</a></td>";
					}
				}
				else{
					html=html+"<td><a href='#' onclick='showArchitect()'>Architect City:</a></td>";
				}
}

				if(projectType.equals("PFL")){
					html=html+"<td><input type='hidden'   name='archLoc' ></td>";
				}
				else{
					html=html+"<td><input type='text' class='text'  name='archLoc' onclick='showArchitect()'></td>";
				}
				if((product.equals("IWP")||product.equals("EJC"))&&userSession.getGroup().indexOf("REP")<0){
					html=html+"<td>Show on recap</td>";
					html=html+"<td><input type='hidden' name='bpcsOrderNo' value=''><input type='checkbox' name='showRecap'></td>";
				}
				else{
					if(product.equals("ADS")){
						html=html+"<td>BPCS Order Number</td>";
						html=html+"<td><input type='text' class='text'  name='bpcsOrderNo'></td>";
					}
					else{
						html=html+"<td colspan='2'><input type='hidden' name='bpcsOrderNo' value=''>";
					}
					html=html+"<input type='hidden' name='showRecap' value='N'></td>";
				}
				html=html+"</tr>";
				if(product.equals("GE")){
					html=html+"<tr>";
					html=html+"<td><b>* Group Code</b>:</td>";
					html=html+"<td><select name='groupCodes' onchange='getSalesRegion()'>"+quoteHeader.getPullDownValues(userSession.getCountry(),product,userSession.getGroup(),"groupCode")+"</select></td>";
					html=html+"<td><b>* Sales Region</b>:</td>";
					html=html+"<td><select name='salesRegion'>"+quoteHeader.getPullDownValues(userSession.getCountry(),product,userSession.getGroup(),"salesRegion")+"</select></td>";
					html=html+"</tr>";
					html=html+"<tr>";
					if(!projectType.equals("PFL")){
						html=html+"<td>Construction Type:</td>";
						html=html+"<td><input type='text' class='text' name='constructionType' value''></td>";
						html=html+"<td>Internal Notes:</td>";
						html=html+"<td><input type='text' class='text' name='internalNotes' value''></td>";
						html=html+"</tr>";
					}
					else if(projectType.equals("PFL")){
						html=html+"<tr>";
						html=html+"<td>End User:</td>";
						html=html+"<td><input type='text' class='text' name='endUser' value''></td>";

						html=html+"<td><a href='#' onclick=notes('pricing')>Internal Notes:</a></td>";
						html=html+"<td><input type='text' class='text' name='instructions' value''></td>";
						html=html+"</tr>";
					}
				}
				if(product.equals("IWP")&&userSession.getGroup().indexOf("REP")<0){
						html=html+"<tr>";
						html=html+"<td></td><td></td>";
						html=html+"<td>Use Expired Pricing:</td>";
						html=html+"<td><input type='checkbox' name='docStage'></td>";
						html=html+"</tr>";
				}


				html=html+"<tr>";
				html=html+"<td colspan='4' align='center'><BR><input type='button' class='button' name='Save' value='Save' onclick='saveHeader()'><input type='button' class='button' name='Cancel' id='cancelheader' value='Cancel' onclick='cancelHeader()'></td>";
				html=html+"</tr>";
				html=html+"</table>";
				out.println(html);
				String emailUrl="http://sec-avscan.c-sgroup.com/erapid/erapidintl3/uploadinit_us.jsp?order_no="+orderNo +"&dirname="+tempdate +"&group="+userSession.getGroup();
				if(application.getInitParameter("HOST").toUpperCase().indexOf("DEV")>0){
					emailUrl="http://sec-avscan.c-sgroup.com/erapid/erapidintl3/test/uploadinit_us.jsp?order_no="+orderNo +"&dirname="+tempdate +"&group="+userSession.getGroup();
				}
				//out.println(product+":: product3<BR>");
				%>
			</form>
			<form name='form1'>

				<input type='hidden' name='today' value='<%=noteDate%>- '>
				<input type='hidden' name='params' value=''>
				<input type='hidden' name='orderNo' value='<%=orderNo%>'>
				<input type='hidden' name='bpcsNo' value='<%=bpcsOrderNo%>'>
				<input type='hidden' name='psaNo' value='<%=psaNo%>'>
				<input type='hidden' name='altCpyNo' value='<%=altCpyNo%>'>
				<input type='hidden' name='qtype' value='<%=qtype%>'>
				<input type='hidden' name='template' value='<%=template%>'>
				<input type='hidden' name='reload' value=''>
				<input type='hidden' name='product' value='<%=product%>'>
				<input type='hidden' name='repNum' value='<%=repNum%>'>
				<input type='hidden' name='userCountryCode' value='US'>
				<input type='hidden' name='userId' value='<%=userSession.getUserId()%>'>
				<input type='hidden' name='userRepNo' value='<%=userSession.getRepNo()%>'>
				<input type='hidden' name='userName' value='<%=userSession.getUserName()%>'>
				<input type='hidden' name='group' value='<%=userSession.getGroup()%>'>
				<input type='hidden' name='fullServerName' value='<%=erapidBean.getFullServerName()%>'>
				<input type='hidden' name='cpqServerName' value='<%=erapidBean.getCpqServerName()%>'>
				<input type='hidden' name='creatorUserName' value='<%=creatorUserName%>'>
				<input type='hidden' name='creatorGroup' value='<%=creatorGroup%>'>
				<input type='hidden' name='SFDCpage' value='<%=SFDCpage%>'>
				<input type='hidden' name='url' value='updateHeader.jsp'>
				<input type='hidden' name='url2' value='headerChange.jsp'>
				<input type='hidden' name='url3' value='priceCalcChange.jsp'>
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
				<input type='hidden' name='xurl'>
				<input type='hidden' name='env' value='<%=env%>'>
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
		                    out.println("<input type='hidden' name='sfdcUrl' value='https://c-sgroup--dev.my.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1'>");
						}
						//out.println("<input type='hidden' name='sfdcUrl' value='https://c.cs3.visual.force.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1'>");
					}
					else{
						out.println("<input type='hidden' name='sfdcUrl' value='https://na44.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1'>");
					}
				}
				else{
					out.println("<input type='hidden' name='sfdcUrl' value=''>");
				}
				%>

			</form>
		</div>

		<%
	if((product.equals("LVR")||product.equals("GRILLE")||product.equals("FSM")||product.equals("SUN")) && userSession.getGroup().toUpperCase().indexOf("REP")<0 && creatorGroup.toUpperCase().indexOf("REP")<0){
		%>
		<%@ include file="cranPriceCalc.jsp"%>
		<%
	}
	else if((product.equals("LVR")||product.equals("GRILLE")||product.equals("SUN")) && userSession.getGroup().toUpperCase().indexOf("REP")>=0 && creatorGroup.toUpperCase().indexOf("REP")<0){
		%>
		<%@ include file="cranPriceCalcRep.jsp"%>
		<%
	}

	else{
		%>
		<%@ include file="muncyPriceCalc.jsp"%>
		<%
	}
		%>
		<div id='architectDiv' class='secDivision' >
			<iframe id='archIframe' height='95%' width='100%' frameborder="0" ></iframe>
		</div>

		<div id='secDiv' class='secDivision' >
			<iframe id='secIframe' height='95%' width='100%' frameborder="0" src="https://<%=application.getInitParameter("HOST")%>/erapid/us/legacy/sections.home.jsp?orderNo=<%=orderNo %>&cmd=1&env=<%=env%>"></iframe>
		</div>
		<div id='owsDiv' class='owsDivision' >
			<iframe id='owsIframe' height='95%' width='100%' frameborder="0" ></frame>
		</div>
	</div>

</body>
</html>