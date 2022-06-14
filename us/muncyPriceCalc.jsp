<div id='pricecalc' class='pricecalc'>
	<form name='priceCalcForm'>
		<%
		priceCalc.setOrderNo(orderNo);
		String hiddenValues="";
		hiddenValues=hiddenValues+"<input type='hidden' name='weightEst' value=''>";
		hiddenValues=hiddenValues+"<input type='hidden' name='weight' value=''>";
		hiddenValues=hiddenValues+"<input type='hidden' name='distance' value=''>";
		hiddenValues=hiddenValues+"<input type='hidden' name='totalTax' value=''>";
		hiddenValues=hiddenValues+"<input type='hidden' name='total' value=''>";
		hiddenValues=hiddenValues+"<input type='hidden' name='transport' value=''>";
		hiddenValues=hiddenValues+"<input type='hidden' name='installDistance' value=''>";
		hiddenValues=hiddenValues+"<input type='hidden' name='installDiscount' value=''>";
		hiddenValues=hiddenValues+"<input type='hidden' name='overageMax' value=''>";
		if(!(product.equals("LVR") || product.equals("GRILLE"))){
			hiddenValues=hiddenValues+"<input type='hidden' name='commission' value=''>";
		}
		out.println("<table width='100%' border='0'> ");
		out.println("<tr class='header1'>");
		out.println("<td colspan='4' align='center'><h3>Price Calculator</h3> </td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td width='50%' align='left'>Configured Price:</td>");
		out.println("<td width='50%' align='left'><input type='text' name='totalCost' value='' readonly>");
		out.println("</tr>");
		if(priceCalc.labelCharges("overage",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"overage",repNum,product)).length()>0){
			   out.println("<tr>");
			   out.println("<td width='50%' align='left'>"+priceCalc.labelCharges("overage",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"overage",repNum,product))+"</td>");
			   out.println("<td width='50%' align='left'><input type='text' name='overage' value='' >");
			   out.println("</tr>");
		}
		else{
			   hiddenValues=hiddenValues+"<input type='hidden' name='overage' value=''>";
		}
		if(priceCalc.labelCharges("setup",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"setup",repNum,product)).length()>0){
				String readOnly="";
				if(product.equals("EFS")){
					readOnly="readonly";
				}
			   out.println("<tr>");
			   out.println("<td width='50%' align='left'>"+priceCalc.labelCharges("setup",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"setup",repNum,product))+"</td>");
			   out.println("<td width='50%' align='left'><input type='text' name='setupCost' value='' "+readOnly+">");

			   out.println("</tr>");
		}
		else{
			   hiddenValues=hiddenValues+"<input type='hidden' name='setupCost' value=''>";
		}
		if(userSession.getGroup().toUpperCase().indexOf("REP")<0&&(product.equals("IWP")||product.equals("EFS")||product.equals("EJC"))){
			   out.println("<tr>");
			   out.println("<td width='50%' align='left'>Calculated Freight</td>");
			   out.println("<td width='50%' align='left'><input type='text' name='calculatedFreight'  readonly></td>");
			   out.println("</tr>");
			   out.println("<tr>");
			   out.println("<td width='50%' align='left'>Freight Override</td>");
			   out.println("<td width='50%' align='left'><input type='checkbox' name='freightOverride' onchange='freightOverrideChange()' ></td>");
			   out.println("</tr>");
		}
		else{
			hiddenValues=hiddenValues+"<input type='hidden' name='freightOverride' value=''>";
			hiddenValues=hiddenValues+"<input type='hidden' name='calculatedFreight' value=''>";
		}
		
		if(priceCalc.labelCharges("handling",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"handling",repNum,product)).length()>0){
			   out.println("<tr>");
			   out.println("<td width='50%' align='left'>"+priceCalc.labelCharges("handling",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"handling",repNum,product))+"</td>");
			   out.println("<td width='50%' align='left'><input type='text' name='handlingCost' value='' >");
			   out.println("</tr>");
		}
		else{
			   hiddenValues=hiddenValues+"<input type='hidden' name='handlingCost' value=''>";
		}
		if(priceCalc.labelCharges("freight",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"freight",repNum,product)).length()>0){
			   out.println("<tr>");
			   out.println("<td width='50%' align='left'>"+priceCalc.labelCharges("freight",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"freight",repNum,product))+"</td>");
			   out.println("<td width='50%' align='left'><input type='text' name='freightCost' value='' >");
			   out.println("</tr>");
		}
		else{
			   hiddenValues=hiddenValues+"<input type='hidden' name='freightCost' value=''>";
		}
		if((product.equals("LVR") || product.equals("GRILLE")) && userSession.getGroup().toUpperCase().equals("REP-DLVR")){
			hiddenValues=hiddenValues+"<input type='hidden' name='commission' value='2'>";
		}
		else	if(product.equals("LVR") || product.equals("GRILLE")){
			out.println("<tr>");
			out.println("<td width='50%' align='left'>Commission GSO:</td>");
			out.println("<td width='50%' align='left'><select name='commission' onchange='getLVRRepPrice()'>"+quoteHeader.getPullDownValues(userSession.getCountry(),product,userSession.getGroup(),"commission")+"</select></td>");
			out.println("</tr>");
		}
		out.println("<tr>");
		out.println("<td width='50%' align='left'>Ship to zip for tax:(optional)</td>");
		out.println("<td width='50%' align='left'><input type='text' name='shipZip' value='' >");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td width='50%' align='left'>Tax Exempt:</td>");
		out.println("<td width='50%' align='left'><input type='checkbox' name='taxExempt' value='' >");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td colspan='2' align='center'><BR><input type='button' class='button' name='Save' value='Save' onclick='savePriceCalc()'><input type='button' class='button' name='Cancel' id='cancel' value='Line Item' onclick='cancelHeader()'></td>");
		out.println("</tr>");
		out.println("</table>");
		out.println(hiddenValues);
		%>
	</form>
</div>
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
		<table width='100%' border='0'>
			<tr class='header1'>
				<td colspan='3' align='center'><h3>Price Calculator</h3> </td>
			</tr>
			<tr>
				<td width='34%' align='left'>Total Cost :</td>
				<td width='23%'  align='right'><label id='totalCostLabel'></td>
				<td width='43%' >&nbsp;</td>
			</tr>
















			<%
		String hiddenLabels="";
		if(priceCalc.labelCharges("overage",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"overage",repNum,product)).length()>0){
			%>
			<tr>
				<td><%=priceCalc.labelCharges("overage",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"overage",repNum,product))%>: </td>
				<td align='right'><label id='overageLabel'></label></td>
				<td>&nbsp;</td>
			</tr>
			<%
		}
		else{
			hiddenLabels=hiddenLabels+"<label id='overageLabel' style='visibility: hidden;'></label>";
		}
		if(priceCalc.labelCharges("setup",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"setup",repNum,product)).length()>0){
			%>
			<tr>
				<td><%=priceCalc.labelCharges("setup",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"setup",repNum,product))%>: </td>
				<td align='right'><label id='setupCostLabel'></label></td>
				<td>&nbsp;</td>
			</tr>
			<%
}
else{
	hiddenLabels=hiddenLabels+"<label id='setupCostLabel' style='visibility: hidden;'></label>";
}
if(priceCalc.labelCharges("handling",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"handling",repNum,product)).length()>0){

			%>
			<tr>
				<td><%=priceCalc.labelCharges("handling",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"handling",repNum,product))%>: </td>
				<td align='right'><label id='handlingCostLabel'></label></td>
				<td>&nbsp;</td>
			</tr>
			<%
}
else{
	hiddenLabels=hiddenLabels+"<label id='handlingCostLabel' style='visibility: hidden;'></label>";
}
if(priceCalc.labelCharges("freight",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"freight",repNum,product)).length()>0){

			%>
			<tr>
				<td><%=priceCalc.labelCharges("freight",product,userSession.getGroup(),priceCalc.getConditions(orderNo,userSession.getGroup(),"freight",repNum,product))%>: </td>
				<td align='right'><label id='freightCostLabel'></label></td>
				<td>&nbsp;</td>
				<!--<td align='right'>Is Freight taxable:<label id='IsTaxStateLabel'></label>&nbsp;</td>-->
			</tr>
			<%
}
else{
	hiddenLabels=hiddenLabels+"<label id='freightCostLabel' style='visibility: hidden;'></label>";
}
			%>


			<%
			out.println("<tr><td width='40%' style='display: none !important;'>"+sfdc_QuoteId+"</td>");

			//out.println("<tr><td width='10%'>SFDC_QuoteId GSO</td><td width='40%'><b><label id='orderNoLabel'>"+sfdc_QuoteId+"</label></b></td>");
			%>
			<tr>
				<td>Tax Total (<label id='taxRateLabel'>%</label>): </td>
				<td align='right'><label id='totalTaxLabel'><font color='red'>calculating</font></label></td>
				<td>&nbsp;</td>
				<!--<<td align='right'>Zip:<label id='taxZipLabel'></label>&nbsp;</td>-->
			</tr>
			<tr>
				<td>Total : </td>
				<td align='right'><label id='totalLabel'><font color='red'>calculating</font></label></td>
				<td>&nbsp;</td>
				<!--<<td align='right'>Is Valid Zip:<label id='IsValidZipLabel'></label>&nbsp;</td> just a comment-->
			</tr>
			<tr>
				<td><%
                           
        if((quoteHeader.getProjectType()!=null && quoteHeader.getProjectType().trim().equals("RP")) && (creatorGroup.toUpperCase().equalsIgnoreCase("Rep-SFDC")) ){
            if(application.getInitParameter("HOST").toUpperCase().indexOf("DEV")>0){
				if(env.equalsIgnoreCase("sit")){
                    out.println("<a href='https://c-sgroup--sit.my.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../images/sfdc_image1.jpg'></a>");
                    //out.println("<a href='https://c.cs3.visual.force.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../images/sfdc_image1.jpg'></a>");	
				}else if(env.equalsIgnoreCase("UAT")){
                    out.println("<a href='https://c-sgroup--uat.my.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../images/sfdc_image1.jpg'></a>");	
				}else if(env.equalsIgnoreCase("maya") || env.equalsIgnoreCase("dev")){
                    out.println("<a href='https://c-sgroup--dev.my.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../images/sfdc_image1.jpg'></a>");
                    //out.println("<a href='https://c.cs3.visual.force.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../images/sfdc_image1.jpg'></a>");	
				}else{
                    out.println("<a href='https://c-sgroup--sit.my.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../images/sfdc_image1.jpg'></a>");
				}
			}else{
                out.println("<a href='https://na1.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../images/sfdc_image1.jpg'></a>");
            }
		}
                           
		else if(quoteHeader.getProjectType()!=null && quoteHeader.getProjectType().trim().equals("SFDC")&& (( creatorGroup.toUpperCase().indexOf("REP")<0 &&userSession.getGroup().toUpperCase().indexOf("REP")<0)) ){
            if(application.getInitParameter("HOST").toUpperCase().indexOf("DEV")>0){
				if(env.equalsIgnoreCase("sit")){
                    out.println("<a href='https://c-sgroup--sit.my.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../images/sfdc_image1.jpg'></a>");
                    //out.println("<a href='https://c.cs3.visual.force.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../images/sfdc_image1.jpg'></a>");	
				}else if(env.equalsIgnoreCase("UAT")){
                    out.println("<a href='https://c-sgroup--uat.my.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../images/sfdc_image1.jpg'></a>");	
				}else if(env.equalsIgnoreCase("maya") || env.equalsIgnoreCase("dev")){
                    out.println("<a href='https://c-sgroup--dev.my.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../images/sfdc_image1.jpg'></a>");
                    //out.println("<a href='https://c.cs3.visual.force.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../images/sfdc_image1.jpg'></a>");	
				}else{
                    out.println("<a href='https://c-sgroup--dev.my.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../images/sfdc_image1.jpg'></a>");
				}
			}else{
                out.println("<a href='https://na1.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../images/sfdc_image1.jpg'></a>");
            }
	}
        
	else if(creatorGroup.toUpperCase().indexOf("REP")>=0){	
           // if(env==null){
            //    env="";
            //}
		//out.println("<tr><td width='10%'>env GSO</td><td width='40%'><b><label id='orderNoLabel'>"+env+"</label></b></td>");
		if(env.equalsIgnoreCase("sit")){
            out.println("<a href='https://sit-cscrm.cs1.force.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../images/sfdc_image1.jpg'></a>");	
		}else if(env.equalsIgnoreCase("UAT")){
            out.println("<a href='https://uat-cscrm.cs35.force.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../images/sfdc_image1.jpg'></a>");	
		}else if(env.equalsIgnoreCase("maya") || env.equalsIgnoreCase("dev")){
            out.println("<a href='https://dev-cscrm.cs36.force.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../images/sfdc_image1.jpg'></a>");	
		}else{
            out.println("<a href='https://c-sgroup--dev.my.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../images/sfdc_image1.jpg'></a>");
        }
	}
        

                                
                                %></td>
				<td><input type='button' name='Price' value='Modify Price' class='button2' onclick='editPrice()'><input type='button' class='button' name='Cancel' id='cancel' value='Line Item' onclick='cancelHeader()'></td>
				<td>&nbsp;</td>
			</tr>
		</table>

		<%=hiddenLabels%>
	</form>
	<div id='buttonsDiv' >





	</div>
	<%
            
if(product.equals("GE")){
	String[] repList=userSession.getReps();
String[] repList2=userSession.getRepsNames();

	%>
	<center>
		<form name="assignRepForm" >
			<select name='assignRep' onchange="assignRepx()">
				<option value=''></option>
				<%
				String assignedRepNo=quoteHeader.getAssignedRepNo();
				String selectedx="";
				for(int i=0; i<repList.length; i++){
					if(assignedRepNo.equals(repList[i])){
						selectedx="selected";
					}
					out.println("<option value='"+repList[i]+"' "+selectedx+">"+repList[i]+"--"+repList2[i]+"</option>");
					selectedx="";
				}

				%>
			</select>
			<input type='hidden' name='q_no' value='<%= orderNo %>' >
		</form>
	</center>
	<%
}

if(quoteHeader.getProjectType()!=null && quoteHeader.getProjectType().trim().equals("SFDC")&&userSession.getGroup().toUpperCase().indexOf("REP")<0){
String selected="";
String options="";
String optionsTear="";
if(product.equals("EFS")){
	options=options+"<option value='1'>Types & Quantities</option>";
	options=options+"<option value='2'>Line & Item</option>";
	options=options+"<option value='3'>Plans & Specs</option>";
	options=options+"<option value='4'>Plans & Specs W/ Quantities</option>";
	options=options+"<option value='5'>Intl Line & Item</option>";
	options=options+"<option value='6'>Intl Types & Quantities</option>";
}
else if(product.equals("ADS")){
	options=options+"<option value='1'>Types & Quantities</option>";
	options=options+"<option value='2'>Line & Item</option>";
	options=options+"<option value='3'>Plans & Specs</option>";
	options=options+"<option value='4'>Plans & Specs W/ Quantities</option>";
	options=options+"<option value='5'>Intl Line & Item</option>";
	options=options+"<option value='6'>Intl Types & Quantities</option>";
}
else if(product.equals("IWP")){
	options=options+"<option value='1'>Types & Quantities</option>";
	options=options+"<option value='2'>Line & Item</option>";
	options=options+"<option value='3'>Plans & Specs</option>";
	options=options+"<option value='4'>Plans & Specs W/ Quantities</option>";
	options=options+"<option value='5'>Intl Line & Item</option>";
	options=options+"<option value='6'>Intl Types & Quantities</option>";
}
else if(product.equals("EJC")){
	options=options+"<option value='1'>Types & Quantities</option>";
	options=options+"<option value='2'>Line & Item</option>";
	options=options+"<option value='3'>Plans & Specs</option>";
	options=options+"<option value='4'>Plans & Specs W/ Quantities</option>";
	options=options+"<option value='5'>Intl Line & Item</option>";
	options=options+"<option value='6'>Intl Types & Quantities</option>";
}
else if(product.equals("GCP")){
	options=options+"<option value='1'>Types & Quantities</option>";

	options=options+"<option value='3'>Plans & Specs</option>";
}
if(repQuote != null && repQuote.trim().length()>0){
	options=options.replace(repQuote+"'",repQuote+"' selected");
}
optionsTear="<option value='1'>With No Quantity</option>";
optionsTear=optionsTear+"<option value='2'>With Quantity</option>";
if(repTear != null && repTear.trim().length()>0){
	optionsTear=optionsTear.replace(repTear+"'",repTear+"' selected");
}
	%>
	<center>
		<form name="repQuoteForm" >
			<select name='repQuote' onchange="setRepQuote()">
				<option value=''></option>
				<%=options%>
			</select>
			<input type='hidden' name='q_no' value='<%= orderNo %>' >
		</form>




		<form name="repTearForm" onchange="setRepTear()">
			<select name='tearSheet' onchange="setTearSheet()">
				<%=optionsTear%>
			</select>
		</form>

	</center>																													</form>

<%
}

%>
</div>
<div id='mailDiv' ><%@ include file="email.jsp"%>    </div>

</div>
