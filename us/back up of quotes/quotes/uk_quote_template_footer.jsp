<%
for1.setMaximumFractionDigits(0);

if( !((product.equals("BV"))|(product.equals("GRILLE"))  ) ){
if((product.equals("GCP")||product.equals("ELM")||product.equals("APC")||product.equals("GE")||product.equals("SLM")||product.equals("LVR")||product.equals("EFS")||product.equals("IWP"))||(product.equals("EJC") && (sections<2||(section_page!=null&&section_page.equals("1"))))){
//out.println(product+"HERE"+ sections);
%>
<Table width='100%'>
	<tr>

		<td class='maindesc' width='50%' valign='middle'><b></b></td>
				<%

	double temphandling_cost=new Double(handling_cost).doubleValue();
	if(sections>1){
		temphandling_cost=handlingX;
	}
		for1.setMaximumFractionDigits(0);
		if (!(tax_perc==null||tax_perc.equals("0"))){
			if(product.equals("ELM")||product.equals("GE")){
				if(freight_cost != null && freight_cost.trim().length()>0 && new Double(freight_cost).doubleValue()>0){
				%>
		<td class='maindesc' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>$<%=for12x.format(grand_total1-new Double(freight_cost).doubleValue())  %></font></b></td>
	</tr>
	<tr>
		<td class='maindesc' width='50%' valign='middle'><B>Freight</b></td>
		<td class='maindesc' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>$<%=for12x.format(new Double(freight_cost).doubleValue())  %></font></b></td>
	</tr>
	<%
}
else{
	//out.println("HERE");
	%>
	<td class='maindesc' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>$<%=for12x.format(grand_total1)  %></font></b></td>

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
<td class='maindesc' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>$<%=for12x.format(new Double(price).doubleValue()) %></font></b></td>
</tr>
<%
}
else{
if(product.equals("IWP")){
	String inittotal=df0.format(grand_total1-temphandling_cost)  ;
%>
<td class='maindesc' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>$<%=for12x.format(new Double(inittotal).doubleValue())  %></font></b></td>
</tr>
<% if(temphandling_cost>0){
%>
<tr>
	<td class='maindesc' width='50%' valign='middle'><b>Freight Surcharge</b></td>
	<td class='maindesc' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$<%=for12x.format(temphandling_cost)%></font></b></td>
</tr>
<%
}
}
else{
if(product.equals("LVR")){ //added by AC 3/11/2013 as the LVR quote subtotal was the grand total

%>
<td class='maindesc' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= for12x.format(grand_total1) %></font></b></td>
</tr>
<%
}
else {
%>
<td class='maindesc' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%=  for12x.format(new Double(price).doubleValue()) %></font></b></td>
</tr>
<%
}
}
}
}
}
else{
if(product.equals("ELM")||product.equals("GE")){

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
<td class='maindesc' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>$<%=for12x.format(new Double(inittotal).doubleValue())  %></font></b></td>
</tr>
<%
if(temphandling_cost>0){
%>
<tr>
	<td class='maindesc' width='50%' valign='middle'><b>Freight Surcharge</b></td>
	<td class='maindesc' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$<%=for12x.format(temphandling_cost)%></font></b></td>
</tr>
<tr>
	<td class='maindesc' width='50%' valign='middle'>&nbsp;</td>
	<td class='maindesc' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>$<%= for12x.format(totalnew) %></font></b></td>
</tr>
<%
}

}
else{
%>

<td class='maindesc' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= for12x.format(new Double(price).doubleValue()) %></font></b></td>
</tr>
<%
}

}
}




%>
<tr>
	<td class='maindesc' width='50%' valign='middle'>&nbsp;</td>
	<td class='maindesc' width='50%' align='right' valign='middle' nowrap><b>Currency:</b> US Dollars</td>
</tr>
</table>
<%

	float tax_dollar=0;
	if (!(tax_perc==null||tax_perc.equals("0"))){
		tax_dollar=(grand_total3*Float.parseFloat(tax_perc))/100;
	}
	float temptax=tax_dollar*100;
	temptax=Math.round(temptax);
	temptax=temptax/100;
	tax_dollar=temptax;
	grand_total1=grand_total1+tax_dollar;

	for1.setMaximumFractionDigits(2);
	for1.setMinimumFractionDigits(2);
	DecimalFormat df1 = new DecimalFormat("####.##");
	df1.setMaximumFractionDigits(2);
	df1.setMinimumFractionDigits(2);


	if (!(tax_perc==null||tax_perc.equals("0"))){
		if(product.equals("IWP")||product.equals("EFS")||product.equals("GCP")||product.equals("ELM")||product.equals("GE")){
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
out.println("<Table width='100%'><tr>");
out.println("<tr>");
out.println("<td class='maindesc' width='50%' valign='middle'><b>Tax Only</b></td>");
out.println("<td class='maindesc' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$"+df1.format(tax_dollar)+"</font></b></td>");
out.println("</tr>");
out.println("</table>");
out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
out.println("<tr>");
if(product.equals("GE")){
out.println("<td class='maindesc' width='50%' valign='middle'><b>Quote Total: </b></td>");
}
else{
out.println("<td class='maindesc' width='50%' valign='middle'><b>Material and Tax Only </b></td>");
}
out.println("<td class='maindesc' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(grand_total1)+"</font></b></td>");
out.println("</tr>");
out.println("<tr><td class='maindesc' colspan='2' valign='middle'>Price is FOB plant, freight prepaid (to jobsite) within  continental U.S. or FAS dock export point.</td></tr>");
out.println("</table>");
}

}


}
}
%>
















<Table width='100%'>
	<tr><td class='maindesc'><b>TERMS & CONDITIONS</b></td></tr>
	<tr><td class='maindesc'>&nbsp;</td></tr>
	<tr><td class='maindesc'>1. The Buyer/Customer agrees to all CS Terms and Conditions when they place their purchase order against this quote. 		</td></tr>
	<tr><td class='maindesc'>&nbsp;</td></tr>
	<tr><td class='maindesc'>2. Payment Terms:   (to choose one)					<br>
			Option 1  -	30% payment upon placing of order and balance 70% prior to shipping/collection of goods.	<br>
			Option 2  -	100% full payment upon placing of order.	</td></tr>
	<tr><td class='maindesc'>&nbsp;</td></tr>
	<tr><td class='maindesc'>3. All banking, consulate, government requirements and/or inspection fees will be Buyer/Customer's responsibility. 	</td></tr>
	<tr><td class='maindesc'>&nbsp;</td></tr>
	<tr><td class='maindesc'>4. Prices are Ex Works (EXW) CS supply source. Exclude shipping.</td></tr>
	<tr><td class='maindesc'>&nbsp;</td></tr>
	<tr><td class='maindesc'>5.  Prices are firm against escalation for 30 days from date of this quote, and for shipment within 90 days thereafter. Orders shipped beyond shall be subject to escalation of 1.5% per month or partial month thereafter and invoiced at time of shipment. </td></tr>
	<tr><td class='maindesc'>&nbsp;</td></tr>
	<tr><td class='maindesc'>6. This quote number must be present on your order. </td></tr>
	<tr><td class='maindesc'>&nbsp;</td></tr>
	<tr><td class='maindesc'>7. All orders with a material value of under $500.00 will have a minimum order fee of $75.00 in addition to the material costs.  Doc fee is USD50 per order.</td></tr>
	<tr><td class='maindesc'>&nbsp;</td></tr>
	<tr><td class='maindesc'>8. Special documentation application (such as Asean Form D/E) is chargeable at USD100 per set per application. Any subsequent amendment after issuance of document is chargeable.	</td></tr>
	<tr><td class='maindesc'>&nbsp;</td></tr>
	<!-- <tr><td class='maindesc'>9. All CS orders will be shipped EX Works (EXW), or Free Carrier (FCA) Buyer's Forwarder - Continental U.S. Port (to be determined in final quote), referencing INCOTERMS 2010. 	</td></tr>
	<tr><td class='maindesc'>&nbsp;</td></tr>	-->
	<tr><td class='maindesc'>9. All duties, fees, taxes or other costs associated with customs clearance or import duties are the sole responsibility of the Buyer/Customer. 	</td></tr>
	<tr><td class='maindesc'>&nbsp;</td></tr>
	<tr><td class='maindesc'>10. This written contract supersedes all oral agreements. </td></tr>
	<tr><td class='maindesc'>&nbsp;</td></tr>
	<tr><td class='maindesc'>11.  Cancellation charge of not less than 35% of the full order value or a minimum of USD500, whichever is higher, will be applied once an order is cancelled.	</td></tr>
	<tr><td class='maindesc'>&nbsp;</td></tr>
	<tr><td class='maindesc'>12. For collection of goods from the USA, Construction Specialties require that all freight forwarders who handle CS product be C-TPAT certified. 	</td></tr>
	<tr><td class='maindesc'>&nbsp;</td></tr>
	<tr><td class='maindesc'>13. Product supply will be in accordance with the standard supply length of CS supply origin unless otherwise specific.	</td></tr>
</Table>
