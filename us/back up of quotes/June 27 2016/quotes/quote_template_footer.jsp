<%
for1.setMaximumFractionDigits(0);
//out.println(price);
if(product.equals("LVR")||product.equals("GRILLE")){ //added by AC 3/11/2013 as the LVR quote subtotal was the grand total
	grand_total1=new Double(price).doubleValue();
	grand_total3=(float) grand_total1;
}
if( !((product.equals("BV"))|(product.equals("GRILLE"))  ) ){
if((product.equals("GCP")||product.equals("ELM")||product.equals("APC")||product.equals("GE")||product.equals("SLM")||product.equals("LVR")||product.equals("EFS")||product.equals("IWP"))||(product.equals("EJC") && (sections<2||(section_page!=null&&section_page.equals("1"))))){
//out.println(product+"HERE"+ sections);
%>
<table class='<%= border_color %>' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'>
	<tr>
		<%
		if((product.equals("EFS")||product.equals("IWP"))&&!(tax_perc==null||tax_perc.equals("0"))){
		%>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only:(Tax not included)</b></td>
		<%
	}
	else{
		if(product.equals("GE")||product.equals("ELM")){
		%>
		<td class='tableline_row mainbody' width='50%' valign='middle'>&nbsp;</td>
		<%
	}
	else{
		%>
		<td class='tableline_row mainbody' width='25%' valign='middle'><b>Material Furnished Only</b></td>
		<%
	}
}
double temphandling_cost=new Double(handling_cost).doubleValue();
if(sections>1){
temphandling_cost=handlingX;
}
for1.setMaximumFractionDigits(0);
if (!(tax_perc==null||tax_perc.equals("0"))){
	if(product.equals("ELM")||product.equals("GE")){
		if(freight_cost != null && freight_cost.trim().length()>0 && new Double(freight_cost).doubleValue()>0){
		%>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$<%=for12x.format(grand_total1-new Double(freight_cost).doubleValue())  %></font></b></td>
	</tr>

	<tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'><B>Freight</b></td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$<%=for12x.format(new Double(freight_cost).doubleValue())  %></font></b></td>
	</tr>
	<tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'><B>Total</b></td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$<%=for12x.format(grand_total1) %></font></b></td>
	</tr>
	<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB factory. </td></tr>
	<%
}
else{
	//out.println("HERE");
	%>
	<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$<%=for12x.format(grand_total1)  %></font></b></td>
	<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB factory. </td></tr>
</tr>
<%
}
}
else{
if(product.equals("EJC")){
//out.println(price);
if(price.startsWith("$")){
	price=price.substring(1);
}
price=price.replaceAll(",","");
//out.println(price);
%>
<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%=for1.format(new Double(price).doubleValue()) %></font></b></td>
</tr>
<%
}
else{
if(product.equals("IWP")){
	String inittotal=df0.format(grand_total1-temphandling_cost)  ;
%>
<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$<%=for12x.format(new Double(inittotal).doubleValue())  %></font></b></td>
</tr>
<% if(temphandling_cost>0){
%>
<tr>
	<td class='tableline_row mainbody' width='50%' valign='middle'><b>Freight Surcharge</b></td>
	<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$<%=for12x.format(temphandling_cost)%></font></b></td>
</tr>
<%
}
}
else{
if(product.equals("LVR")){ //added by AC 3/11/2013 as the LVR quote subtotal was the grand total
//grand_total1=new Double(price).doubleValue();
%>
<td class='tableline_row mainbody' width='75%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= for12x.format(grand_total1) %></font></b></td>
</tr>
<%
}
else {
if(product.equals("EFS")){
%>
<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>$<%= for13x.format(new Double(price).doubleValue()) %>.00</font></b></td>
</tr>
<%
}
else{
%>
<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= for13x.format(new Double(price).doubleValue()) %></font></b></td>
</tr>
<%
}
}
}
}
}
}
else{
if(product.equals("ELM")||product.equals("GE")){
if(freight_cost != null && freight_cost.trim().length()>0 && new Double(freight_cost).doubleValue()>0){
%>
<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$<%=for12x.format(grand_total1-new Double(freight_cost).doubleValue())  %></font></b></td>
</tr>

<tr>
	<td class='tableline_row mainbody' width='50%' valign='middle'><B>Freight</b></td>
	<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$<%=for12x.format(new Double(freight_cost).doubleValue())  %></font></b></td>
</tr>
<tr>
	<td class='tableline_row mainbody' width='50%' valign='middle'><b>Total:</b></td>
	<%
	}
	//else{
	//out.println("HERE");
	%>
	<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$<%=for12x.format(grand_total1)  %></font></b></td>
</tr>
<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB factory. </td></tr>
<%
//}
}
else{

if(product.equals("IWP")){
String inittotal=df0.format(grand_total1-temphandling_cost)  ;
inittotal=inittotal.replaceAll(",","");
//out.println(inittotal);
DecimalFormat df2t = new DecimalFormat("####.##");
df2t.setMaximumFractionDigits(2);
df2t.setMinimumFractionDigits(2);
double totalnew=new Double(df2t.format(new Double(inittotal).doubleValue())).doubleValue()+temphandling_cost;
//out.println(totalnew);

%>
<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$<%=for12x.format(new Double(inittotal).doubleValue())  %></font></b></td>
</tr>
<%
if(temphandling_cost>0){
%>
<tr>
	<td class='tableline_row mainbody' width='50%' valign='middle'><b>Freight Surcharge</b></td>
	<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$<%=for12x.format(temphandling_cost)%></font></b></td>
</tr>
<tr>
	<td class='tableline_row mainbody' width='50%' valign='middle'>&nbsp;</td>
	<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>$<%= for12x.format(totalnew) %></font></b></td>
</tr>
<%
}

}
else{
%>

<td class='tableline_row mainbody' width='50%' align='right' valign='bottom' nowrap><b>Total: <font class='totprice'><%= for1.format(new Double(grand_total1).doubleValue()) %></font></b></td>
</tr>
<%
}

}
if(product.equals("ELM")||product.equals("GE")){
%>
<!--<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB plant. </td></tr>-->
<%}
else if(product.equals("GCP")){
%>
<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB plant. Freight not included. Tax not included. </td></tr>
<%
}
else{
if(customerCountry.equals("CANADA")){
				//out.println("<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>HST Extra   FOB CS PLANT,  FREIGHT EXTRA</td></tr>");
				out.println("<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>F.O.B PLANT, FREIGHT ALLOWED EXCLUDING TAX.</td></tr>");

			}
else{
if(!product.equals("LVR")){
%>
<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB plant, freight prepaid (to jobsite) within continental U.S. or FAS dock export point. Tax not included.</td></tr>
<%
}
else{
%>
<jsp:include page="lvrFooter.jsp" flush="true">
	<jsp:param name="order_no" value="<%= order_no%>"/>
	<jsp:param name="tax" value="no"/>
</jsp:include>
<%
}









}
}
}




%>

</table>
<%
	DecimalFormat df1 = new DecimalFormat("####.##");
	df1.setMaximumFractionDigits(0);
	df1.setMinimumFractionDigits(0);
	float tax_dollar=0;
	//out.println(grand_total3+"::"+grand_total1);
	grand_total1=new Double(df1.format(grand_total1)).doubleValue();
	grand_total3=Float.parseFloat(""+grand_total1);
	if (!(tax_perc==null||tax_perc.equals("0"))){
		tax_dollar=(grand_total3*Float.parseFloat(tax_perc))/100;
	}
//out.println(grand_total3+"::"+grand_total1);
	float temptax=tax_dollar*100;
	temptax=Math.round(temptax);
	temptax=temptax/100;
	tax_dollar=temptax;
//out.println(grand_total1+"::a");
	grand_total1=grand_total1+tax_dollar;
//out.println(grand_total1+"::b");
	for1.setMaximumFractionDigits(2);
	for1.setMinimumFractionDigits(2);
	df1.setMaximumFractionDigits(2);
	df1.setMinimumFractionDigits(2);


	if (!(tax_perc==null||tax_perc.equals("0"))){
		if(product.equals("IWP")||product.equals("GCP")||product.equals("ELM")||product.equals("GE")){
			//out.println(df0.format(grand_total3)+":::HERE<BR>");
			if((grandtotalforsec != null && grandtotalforsec.trim().length()>0)||product.equals("GCP")||product.equals("ELM")||product.equals("GE")){
				if(grandtotalforsec == null || grandtotalforsec.trim().length()==0){
					grandtotalforsec="0";
				}
				//out.println(taxtotal);

				if((new Double(grandtotalforsec).doubleValue()>0)||product.equals("GCP")||product.equals("ELM")||product.equals("GE")){
					//out.println(overage+":::"+freight_cost+"::<BR>");
					if(sections<=1){
%>
<jsp:include page="summary_tax.jsp" flush="true">
	<jsp:param name="order_no" value="<%= order_no%>"/>
	<jsp:param name="tax_perc" value="<%= tax_perc%>"/>
	<jsp:param name="overage" value="<%=overage %>"/>
	<jsp:param name="handling_cost" value="<%=handling_cost %>"/>
	<jsp:param name="freight_cost" value="<%=freight_cost %>"/>
	<jsp:param name="setup_cost1" value="<%=setup_cost%>"/>
	<jsp:param name="totprice_dis" value="<%= taxtotal%>"/>
	<jsp:param name="grandtotalforsec" value="<%= grandtotalforsec%>"/>
	<jsp:param name="isRepQuote" value="yes"/>
	<jsp:param name="product_id" value="<%= product%>"/>
</jsp:include>
<%
}
else{
//out.println(grandtotalforsec+"::<BR>");
//out.println(taxtotal+"::<BR>");
//	out.println(tax_perc+"::"+overageX+"::"+handlingX+"::"+freightX+"::"+taxtotal+"::"+grandtotalforsec+"::");
%>
<jsp:include page="summary_tax.jsp" flush="true">
	<jsp:param name="order_no" value="<%= order_no%>"/>
	<jsp:param name="tax_perc" value="<%= tax_perc%>"/>
	<jsp:param name="overage" value="<%=overageX %>"/>
	<jsp:param name="handling_cost" value="<%=handlingX %>"/>
	<jsp:param name="freight_cost" value="<%=freightX %>"/>
	<jsp:param name="setup_cost1" value="<%=setup_cost%>"/>
	<jsp:param name="setup_cost" value="0"/>
	<jsp:param name="totprice_dis" value="<%= taxtotal%>"/>
	<jsp:param name="grandtotalforsec" value="<%= grandtotalforsec%>"/>
	<jsp:param name="isRepQuote" value="yes"/>
	<jsp:param name="section" value="<%= sect_group_linesx%>"/>
	<jsp:param name="secLines" value="<%= secLines%>"/>
	<jsp:param name="product_id" value="<%= product%>"/>
</jsp:include>
<%
}
}
}
}
else{
out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
out.println("<tr>");
out.println("<td class='tableline_row mainbody' width='25%' valign='middle'><b>Tax Only</b></td>");
out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$"+df1.format(tax_dollar)+"</font></b></td>");
out.println("</tr>");
out.println("</table>");
out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
out.println("<tr>");
if(product.equals("GE")){
out.println("<td class='tableline_row mainbody' width='25%' valign='middle'><b>Quote Total: </b></td>");
}
else{
out.println("<td class='tableline_row mainbody' width='25%' valign='middle'><b>Material and Tax Only</b></td>");
}
out.println("<td class='tableline_row mainbody' width='75%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(grand_total1)+"</font></b></td>");
out.println("</tr>");

			if(customerCountry.equals("CANADA")){
				out.println("<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>HST Extra   FOB CS PLANT,  FREIGHT EXTRA</td></tr>");

			}
			else{
				if(!product.equals("LVR")){
					out.println("<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB plant, freight prepaid (to jobsite) within  continental U.S. or FAS dock export point.</td></tr>");
				}
				else{
%>
<jsp:include page="lvrFooter.jsp" flush="true">
	<jsp:param name="order_no" value="<%= order_no%>"/>
	<jsp:param name="tax" value="YES"/>
</jsp:include>
<%
}
}
out.println("</table>");
}

}


}
}
%>
<br>
<table width='100%' border='0' style='border-collapse: collapse;' cellspacing='0' cellpadding='2'>
	<tr>
		<td width='50%' align='left' valign='bottom' colspan='2' nowrap class='maindesc'><b><u>Acceptance:</u></b></td>
		<td width='50%' align='left' valign='bottom' colspan='2' nowrap class='maindesc'><b><u>Shipping:</u></b> </td>
	</tr>
	<tr>
		<td width='15%' align='left' valign='bottom' nowrap class='maindesc'>Bill To: </td>
		<td width='30%' valign='bottom' class='mainbodyh'>.....................................</td>
		<td width='25%' align='left' valign='bottom' nowrap class='maindesc'>Ship To: </td>
		<td width='30%' valign='bottom' class='mainbodyh'>.....................................</td>
	</tr>
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>Address:</td>
		<td valign='bottom' class='mainbodyh'>.....................................</td>
		<td w align='left' valign='bottom' nowrap class='maindesc'>Address: </td>
		<td valign='bottom' class='mainbodyh'>.....................................</td>
	</tr>
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>City/State/Zip: </td>
		<td valign='bottom' class='mainbodyh'>.....................................</td>
		<td align='left' valign='bottom' nowrap class='maindesc'>City/State/Zip: </td>
		<td valign='bottom' class='mainbodyh'>.....................................</td>
	</tr>
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>Purchase Order No: </td>
		<td valign='bottom' class='mainbodyh'>.....................................</td>
		<td align='left' valign='bottom' nowrap class='maindesc'>Requested Delivery Date: </td>
		<td valign='bottom' class='mainbodyh'>.....................................</td>
	</tr>
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>Customer Name: </td>
		<td valign='bottom' class='mainbodyh'>.....................................</td>
		<td align='left' valign='bottom' nowrap class='maindesc'>Site Phone No:</td>
		<td valign='bottom' class='mainbodyh'>.....................................</td>
	</tr>
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>Customer Signature: </td>
		<td valign='bottom' class='mainbodyh'>.....................................</td>
		<!-- following changed by AC 2/5/2013 to add Attention to on GE quotes footers -->
		<%		if (product.equals("GE")){
					out.println("<td align='left' valign='bottom' nowrap class='maindesc'>Attention To:</td><td valign='bottom' class='mainbodyh'>.....................................</td>");
				} else {
					out.println("<td align='left' valign='bottom' nowrap class='maindesc'></td><td valign='bottom' class='mainbodyh'></td>");
				} %>
	</tr>
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>Email Address: </td>
		<td valign='bottom' class='mainbodyh'>.....................................</td>
		<td align='left' valign='bottom' nowrap class='maindesc'></td>
		<td valign='bottom' class='mainbodyh'></td>
	</tr>
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>Contact Phone No: </td>
		<td valign='bottom' class='mainbodyh'>.....................................</td>
		<td align='left' valign='bottom' nowrap class='maindesc'></td>
		<td valign='bottom' class='mainbodyh'></td>
	</tr>
	<!--<tr><td width='100%' colspan='4'></td></tr>-->
</table>

<table cellspacing='0' cellpadding='0' border='0' width='100%'>
	<tr><td class='mainbodyh'>
			<%	if (product.equals("GE")){out.println("");}
				else{
					if(isInternational) {
						out.println("<br>Material Prices are in U.S. Dollars  - FCA your forwarder, Continental US Port, domestic packed in corrugated cardboard.  For ocean crating add additional 5% to material value.");
						if (product.equals("EJC")|product.equals("IWP")){
						out.println("<br><br>NOTE: This price is based on furnishing types and quantities as listed and described above and in CS standard colors and finishes. Pricing is based on furnishing material only in stock lengths of 10 LF or 20 LF.  If ultimate quantities or types change from those listed, this price will change accordingly. Prices do not include installation.");
						}
						out.println("<br>NOTE:  Attached production description sheets to be completed and returned with purchase order<br>");
					}
					else{
					//	out.println("Forward completed & signed acceptance to CS Representative, name & address as listed in the quotation header above.");
					//out.println("<br>Price is FOB plant, freight prepaid within continental U.S. or FAS dock export point. Tax not included.");
					}
				}
			%>
		</td></tr>
	<tr><td >&nbsp;</td></tr>
	<tr><td class='mainfooter'>
			TERMS & CONDITIONS
			<%
			if(customerCountry.equals("CANADA")){
			%>
			<br>1. ON "SUPPLY ONLY" ORDERS THE FIELD DIMENSIONS ARE TO BE PROVIDED BY THE CUSTOMER.
			<br>2. THIS QUOTATION IS VALID FOR 45 DAYS FROM ABOVE DATE. AFTER SUCH DATE IT BECOMES NULL & VOID.
			<br>3. PAYMENT TERMS ARE NET 30 DAYS O.A.C.  NO HOLDBACKS ON SUPPLY ONLY. ORDERS ARE NOT ACCEPTED  FOR ACCOUNTS WITH OVERDUE BALANCES.
			<br>4. NO ORDERS WILL BE PROCESSED WITHOUT A WRITTEN PURCHASE ORDER OR SIGNED CS QUOTE.
			<br>5. ON "SUPPLY ONLY" ITEMS, WARRANTY PERIOD COMMENCES ON THE DATE OF SHIPMENT.
			<br>6. DUE TO THE CUSTOM NATURE OF OUR PRODUCTS, REFUNDS WILL NOT BE GIVEN ON RETURNED MATERIALS.
			<br>7. PRE-PAID ORDERS UNDER $500.00 : COMPANY CHEQUE ACCEPTED,	OVER $500.00: CERTIFIED CHEQUE, MASTERCARD OR VISA.
			<br>8. STANDARD LEED DOCUMENTS WILL BE PROVIDED.
			<%
			}
			else{
			%>
			<br>1. <%

					if(product.equals("GE")) {out.println("Impact Specialties, formerly Grand Entrance");}
					else if(product.equals("ELM")){ out.println("Elements Commercial Flooring");}
					else {out.println("CS");} %> Standard Terms and Conditions shall apply.
			<%
			if(product.equals("GE")) {
				out.println("View at <a href=\"javascript:n_window('http://www.c-sgroup.com/terms-conditions-sale')\">http://www.c-sgroup.com/terms-conditions-sale</a>");

			}

			%>
			<br>2. Payment terms are Net 30 Days, with no retention allowed.
			<br>3. Prices are firm against escalation for 90 days from date of this quote, and for shipment within 6 months thereafter. Orders shipped beyond shall be subject to escalation of 1.5% per month for each month or partial month thereafter and invoiced at time of shipment.
			<br>4. The quotation may be withdrawn if not accepted within 90 days of quotation.
			<br><%
			if(session_group_id.startsWith("Decolink")){
				out.println("5. Returned materials are subject to a 30% restock fee and return freight.");
			}else{
				out.println("5. Orders resulting from this quotation must be made out to ");
				if ((product.equals("GCP"))){out.println("CS Cubicle Curtains Company.");}
				else if(product.equals("GE")) {out.println("Impact Specialties, formerly Grand Entrance");}
				else if(product.equals("ELM")){ out.println("Elements Commercial Flooring");}
				else{
					if ( (doc_priority.equals("E")) ){
						out.println("Construction Specialties, Inc.");
					}
					else{
						out.println("Construction Specialties, Inc.");
					}
			    }
			}
			if(isInternational) {
				out.println("<BR>6. All orders with a material value of under $500.00 will have a minimum order fee of $50.00 in addition to material.");
				out.println("<BR>7. Freight rate is subject to change based on actual weights and dimensions.");
				out.println("<BR>8. Estimated delivery:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i>-If all material is available from stock, 3 weeks shipment ex-factory after receipt of confirming purchase order and release by CS Credit Dept.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-If all material is not in stock, 7-8 weeks shipment ex factory after receipt of confirming Purchase Order and release by CS Credit Dept.</i>");
				out.println("<BR>9. For projects located outside the U.S. Construction Specialties requires that all freight forwarders who handle CS product be C-TPAT certified. Please contact your local representative for more information and a list of available C-TPAT carriers in your area.");
				out.println("<BR>10.Construction Specialties, Inc. will be listed as the USPPI (United States Principal Party in Interest) on all transactions for shipments exporting from the US.  This will include filing with US Customs and Export Documentation completion.");
			}
			else if(product.equals("GRILLES") || product.equals("LVR")){
				out.println("<BR>6. CS will supply our standard 1-year warranty for material.");
				out.println("<BR>7. Price includes a single delivery shipment in box trucking with standard wood crating.");
				out.println("<BR>8. For projects located outside the U.S. Construction Specialties requires that all freight forwarders who handle CS product be C-TPAT certified. Please contact your local representative for more information and a list of available C-TPAT carriers in your area.");
				out.println("<BR>9. Construction Specialties, Inc. will be listed as the USPPI (United States Principal Party in Interest) on all transactions for shipments exporting from the US.  This will include filing with US Customs and Export Documentation completion.");

			}
			else{
				out.println("<BR>6. For projects located outside the U.S. Construction Specialties requires that all freight forwarders who handle CS product be C-TPAT certified. Please contact your local representative for more information and a list of available C-TPAT carriers in your area.");
				out.println("<BR>7. Construction Specialties, Inc. will be listed as the USPPI (United States Principal Party in Interest) on all transactions for shipments exporting from the US.  This will include filing with US Customs and Export Documentation completion.");

			}

					}
			%>
		</td></tr>
</table>

