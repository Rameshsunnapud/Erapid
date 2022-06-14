<%

for1.setMaximumFractionDigits(0);
if( !((product.equals("LVR"))|(product.equals("BV"))|(product.equals("GRILLE"))  ) ){
//out.println(section_page+"::"+sections);
	if(product.equals("EFS")||product.equals("REF")||((product.equals("EJC")||product.equals("IWP")||product.equals("GCP")||product.equals("APC"))&&((section_page != null && !section_page.equals("0")) || sections<=1))||product.equals("EJC")){
		if(product.equals("EJC")){
%>
<table class='<%= border_color %>' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only (Includes Freight and Submittals)</b></td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= price %></font></b></td>
	</tr>
	<%

}
else if(product.equals("IWP")){
	DecimalFormat df0 = new DecimalFormat("####");
	DecimalFormat for9 = new DecimalFormat("####.##");
	for9.setMinimumFractionDigits(2);
	for9.setMaximumFractionDigits(2);
	double temphandling_cost=new Double(handling_cost).doubleValue();
	//if(sections>1){
	//	temphandling_cost=handlingX;
	//}
	String inittotal=df0.format(grand_total-temphandling_cost)  ;
	%>
	<table class='<%= border_color %>' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
			<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only </b></td>
			<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'><%=for1.format(new Double(inittotal).doubleValue())  %>.00</font></b></td>
		</tr>
		<%
		if(temphandling_cost>0 ){
		%>
		<tr>
			<td class='tableline_row mainbody' width='50%' valign='middle'><b>Freight Surcharge</b></td>
			<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$<%=for9.format(temphandling_cost)%></font></b></td>
		</tr>
		<%
}
		if(!(tax_perc == null  || tax_perc.equals("0") || tax_perc.trim().length()<1)||temphandling_cost>0){
			for9.setMinimumFractionDigits(0);
			for9.setMaximumFractionDigits(0);
			String tempprice=for9.format(grand_total);
			for9.setMinimumFractionDigits(2);
			for9.setMaximumFractionDigits(2);
		%>
		<!--<tr>
			<td class='tableline_row mainbody' width='50%' valign='middle'>&nbsp;</td>
			<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>$<%= for1.format(new Double(tempprice).doubleValue())%></font></b></td>
		</tr>-->
		<%
	}

if((tax_perc == null  || tax_perc.equals("0") || tax_perc.trim().length()<1)){
			for9.setMinimumFractionDigits(0);
			for9.setMaximumFractionDigits(0);
			String tempprice=for9.format(grand_total);
			for9.setMinimumFractionDigits(2);
			for9.setMaximumFractionDigits(2);
		%>
		<tr>
			<td class='tableline_row mainbody' width='50%' valign='middle'>&nbsp;</td>
			<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>$<%= for9.format(new Double(tempprice).doubleValue())%></font></b></td>
		</tr>
		<%
	}

if(canType.equals("CAD")){
	out.println("<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>F.O.B PLANT, FREIGHT ALLOWED EXCLUDING TAX.</td></tr>");

			}
}
else{
DecimalFormat for9x = new DecimalFormat("####.##");
			for9x.setMinimumFractionDigits(2);
			for9x.setMaximumFractionDigits(2);


if(price.indexOf("$")<0&& price.indexOf(",")<0){

	price= "$"+for9x.format(new Double(price).doubleValue());
}
		%>
		<table class='<%= border_color %>' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
				<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only</b></td>
				<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%=price%></font></b></td>
			</tr>
			<%
		}
		double tax_dollar=0;
		if(tax_perc != null && tax_perc.trim().length()>0){
			tax_dollar=(grand_total*Double.parseDouble(tax_perc))/100;
		}
		grand_total=grand_total+tax_dollar;
		if(tax_perc != null && !tax_perc.equals("0") && tax_perc.trim().length()>0){
			if(product.equals("IWP")||product.equals("GCP")){
			%>
			<jsp:include page="summary_tax.jsp" flush="true">
				<jsp:param name="order_no" value="<%= order_no%>"/>
				<jsp:param name="tax_perc" value="<%= tax_perc%>"/>
				<jsp:param name="overage" value="<%=overage %>"/>
				<jsp:param name="handling_cost" value="<%=handling_cost %>"/>
				<jsp:param name="freight_cost" value="<%=freight_cost %>"/>
				<jsp:param name="setup_cost1" value="0"/>
				<jsp:param name="setup_cost" value="<%= setup_cost%>"/>
				<jsp:param name="totprice_dis" value="<%= taxtotal%>"/>
				<jsp:param name="isquote" value="yes"/>
				<jsp:param name="product_id" value="<%= product%>"/>
				<jsp:param name="secLines" value="<%= secLines%>"/>
			</jsp:include>
			<%
		}
		else{
			out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
			out.println("<tr>");
			out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Tax Only</b></td>");
			out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(tax_dollar)+"</font></b></td>");
			out.println("</tr>");
			out.println("</table>");
			out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
			out.println("<tr>");
			out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material and Tax Only </b></td>");
			out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(grand_total)+"</font></b></td>");
			out.println("</tr>");

		}
	}
	out.println("</table>");
}
if(product.equals("GE")||product.equals("ELM")){
	NumberFormat for2ge = NumberFormat.getInstance();
	for2ge.setMaximumFractionDigits(2);
	for2ge.setMinimumFractionDigits(2);
	if(tax_perc != null && !tax_perc.equals("0") && !tax_perc.equals("0.0") && tax_perc.trim().length()>0){
		if(freight_cost != null && freight_cost.trim().length()>0 && new Double(freight_cost).doubleValue()>0){
			%>
			<table class='tableline_iwp' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'>
				<tr>
					<td class='tableline_row mainbody' width='50%' valign='middle'>&nbsp;</td>
					<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= for2ge.format(new Double((price1)).doubleValue()-new Double(freight_cost).doubleValue()) %></font></b></td>
				</tr>
				<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB plant. </td></tr>
			</table>

			<table class='tableline_iwp' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'>
				<tr>
					<td class='tableline_row mainbody' width='50%' valign='middle'><b>Freight:</b></td>
					<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b> <font class='totprice'>$<%= for2ge.format(new Double(freight_cost).doubleValue()) %></font></b></td>
				</tr>

			</table>
			<%
		}
		else{
			%>
			<table class='tableline_iwp' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'>
				<tr>
					<td class='tableline_row mainbody' width='50%' valign='middle'>&nbsp;</td>
					<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= for2ge.format(new Double((price1)).doubleValue()) %></font></b></td>
				</tr>
				<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB plant. </td></tr>
			</table>
			<%
		}
	}
	else{
		if(freight_cost != null && freight_cost.trim().length()>0 && new Double(freight_cost).doubleValue()>0){
			%>
			<table class='tableline_iwp' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'>
				<tr>
					<td class='tableline_row mainbody' width='50%' valign='middle'>&nbsp;</td>
					<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= for2ge.format(new Double((price1)).doubleValue()-new Double(freight_cost).doubleValue()) %></font></b></td>
				</tr>
				<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB plant. </td></tr>
			</table>

			<table class='tableline_iwp' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'>
				<tr>
					<td class='tableline_row mainbody' width='50%' valign='middle'><b>Freight:</b></td>
					<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b> <font class='totprice'>$<%= for2ge.format(new Double(freight_cost).doubleValue()) %></font></b></td>
				</tr>

			</table>
			<table class='tableline_iwp' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'>
				<tr>
					<!--<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material and Freight Only: </b></td>-->
					<td class='tableline_row mainbody' width='50%' valign='middle'><b>Quote Total: </b></td>
					<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>$<%=for2ge.format(grand_total)%></font></b></td>
				</tr>
			</table>
			<%
		}
		else{
			%>
			<table class='tableline_iwp' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'>
				<tr>
					<td class='tableline_row mainbody' width='50%' valign='middle'>&nbsp;</td>
					<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= for2ge.format(new Double((price1)).doubleValue()) %></font></b></td>
				</tr>
				<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB plant. </td></tr>
			</table>
			<%
		}

	}
			double tax_dollar=0;
			if(tax_perc != null && tax_perc.trim().length()>0){
				tax_dollar=(grand_total*Double.parseDouble(tax_perc))/100;
			}
	grand_total=grand_total+tax_dollar;
	if(tax_perc != null && !tax_perc.equals("0") && !tax_perc.equals("0.0") && tax_perc.trim().length()>0){
		if(setup_cost != null && setup_cost.trim().length()>0){
			taxtotal=taxtotal+new Double(setup_cost).doubleValue();
		}
		if(freight_cost != null && freight_cost.trim().length()>0){
			taxtotal=taxtotal+new Double(freight_cost).doubleValue();
		}
		if(overage != null && overage.trim().length()>0){
			taxtotal=taxtotal+new Double(overage).doubleValue();
		}
			%>
			<jsp:include page="summary_tax.jsp" flush="true">
				<jsp:param name="order_no" value="<%= order_no%>"/>
				<jsp:param name="tax_perc" value="<%= tax_perc%>"/>
				<jsp:param name="overage" value="<%=overage %>"/>
				<jsp:param name="handling_cost" value="<%=handling_cost %>"/>
				<jsp:param name="freight_cost" value="<%=freight_cost %>"/>
				<jsp:param name="setup_cost1" value="0"/>
				<jsp:param name="setup_cost" value="<%= setup_cost%>"/>
				<jsp:param name="totprice_dis" value="<%= taxtotal%>"/>
				<jsp:param name="isquote" value="yes"/>
				<jsp:param name="product_id" value="<%= product%>"/>
				<jsp:param name="secLines" value="<%= secLines%>"/>
			</jsp:include>
			<%
		}
	}
}
			%>
			<table border='0' width='100%'>
				<%


				//out.println("<tr><td class='mainbody'>&nbsp;</td></tr>");
				out.println("<tr>");
				//out.println("<TR><TD>"+product+" HERE</td></tr>");
				if(!group_id.startsWith("Internatio")&!type.equals("5")&!type.equals("6")) {
					if(product.endsWith("IWP")&& !canType.equals("CAD")){
						out.println("<td width=45% class='mainbody' align=left>&nbsp;&nbsp;</td>");
						if(group_id.startsWith("Decolink")){
							out.println("<td width=55% class='mainbody' align='left'><b>Estimator:</b>"+sfdc_estimator+"</td>");
						}else{
							out.println("<td width=55% class='mainbody' align='left'><b>Regional Sales Manager(RSM):</b>"+ psa_rsm+"</td>");
						}
					}
					else if(product.endsWith("LVR")|product.equals("BV")|product.endsWith("GRILLE")|product.endsWith("GCP") ||canType.equals("CAD")){
						out.println("<td width=45% class='mainbody' align='left'><b>Estimator:</b>&nbsp;"+sfdc_estimator+"</td>");
						out.println("<td width=55% class='mainbody' align='left'>&nbsp;</td>");
					}
					else if(product.endsWith("GE")){
					}
					else{
						out.println("<td width=45% class='mainbody' align='left'><b>Estimator:</b>&nbsp;"+sfdc_estimator+"</td>");

							out.println("<td width=55% class='mainbody' align='left'><b>Regional Sales Manager(RSM):</b>"+ psa_rsm+"</td>");

					}
					out.println("</tr>");
				}
				else{
					out.println("<td width=50% class='mainbody' align=left>&nbsp;&nbsp;</td>");
					if(group_id.startsWith("Internatio")) {
						out.println("<td width=15% class='mainbody' align='left' valign='top'><b>Estimator:</b></td><td width='35%' align='left' class='mainbody'>"+rep_name+"<BR>"+rep_telephone+"<br>"+rep_fax+"<BR>"+rep_email2+"</td>");
					}
					else{
						out.println("<td width=15% class='mainbody' align='left' valign='top'><b>Estimator:</b></td><td width='35%' align='left' class='mainbody'>"+rep_name+"<BR>"+rep_telephone+"<br>"+rep_fax+"</td>");
					}
					out.println("</tr>");
					out.println("<tr><td class='mainbody'>&nbsp;</td></tr>");
				}

				%>
			</table>
			<%

			%>


			<!--<table width='100%' border='0'>-->

			<%
			/*
			if( ((product.equals("GE"))|(product.equals("LVR"))|(product.equals("BV"))|(product.equals("GRILLE"))|(product.equals("GCP"))  ) ){
			%>






			<tr>
				<td width='50%' valign='top' >
					<font class='maindesc'>Ship To Address:</td>
				<td width='15%' align='left'class='maindesc'>&nbsp;</td>
				<td width='35%' valign='bottom' class='mainbody'>&nbsp;</td></tr>
			<tr><td>..........................................................</td>
				<td width='15%' align='left' nowrap class='maindesc'>Printed Name: </td>
				<td width='35%' valign='bottom' class='mainbody'>................................................</td></tr>
			<tr><td>..........................................................</td>
				<td width='15%' align='left' nowrap class='maindesc'>Signature: </td>
				<td width='35%' valign='bottom' class='mainbody'>................................................</td></tr>
			<tr><td>..........................................................</td>
				<td width='15%' align='left' nowrap class='maindesc'>Company Name: </td>
				<td width='35%' valign='bottom' class='mainbody'>................................................</td></tr>
			<tr><td>..........................................................</td>
				<%
				if( !(product.equals("LVR")|product.equals("BV")|product.equals("GRILLE")  ) ){
				%>
				<td width='15%' align='left' nowrap class='maindesc'>PO No: </td>
				<td width='35%' valign='bottom' class='mainbody'>................................................</td></tr>
				<%
				}
				else{
				%>
			<!--<td width='15%' align='left' nowrap class='maindesc'>&nbsp;</td>
			<td width='35%' valign='bottom' class='mainbody'>&nbsp;</td></tr> -->
			<%
		}
			%>
			<tr><td>..........................................................</td>
				<td colspan='2' rowspan='1'></td></tr>




			<% }
				else{
			%>
			<tr>
				<td width='50%' valign='top' >
					<font class='maindesc'>Ship To Address:</td>
				<td width='15%' align='left'class='maindesc'>&nbsp;</td>
				<td width='35%' valign='bottom' class='mainbody'>&nbsp;</td></tr>

			<tr><td>..........................................................</td>
				<td width='15%' align='left' nowrap class='maindesc'>Signature: </td>
				<td width='35%' valign='bottom' class='mainbody'>................................................</td></tr>
			<tr><td>..........................................................</td>
				<td width='15%' align='left' nowrap class='maindesc'>Company Name: </td>
				<td width='35%' valign='bottom' class='mainbody'>................................................</td></tr>
			<tr><td>..........................................................</td>
				<td width='15%' align='left' nowrap class='maindesc'>PO No: </td>
				<td width='35%' valign='bottom' class='mainbody'>................................................</td></tr>
			<tr><td>..........................................................</td>
				<td width='100%' colspan='2' rowspan='1'></td></tr>
			<tr><td>..........................................................</td>
				<td width='100%' colspan='2' rowspan='1'></td></tr>

			<%
		}
		*/
			%>
			<!--</table>-->










			<table width='100%' border='0' style='border-collapse: collapse;' cellspacing='0' cellpadding='2'>
				<tr>
					<td width='45%' align='left' valign='bottom' colspan='2' nowrap class='maindesc'><b><u>Acceptance:</u></b></td>
					<td width='55%' align='left' valign='bottom' colspan='2' nowrap class='maindesc'><b><u>Shipping:</u></b> </td>
				</tr>
				<tr>
					<td width='15%' align='left' valign='bottom' nowrap class='maindesc'>Bill To: </td>
					<td width='30%' valign='bottom' class='mainbody'>................................................</td>
					<td width='25%' align='left' valign='bottom' nowrap class='maindesc'>Ship To: </td>
					<td width='30%' valign='bottom' class='mainbody'>................................................</td>
				</tr>
				<tr><td align='left' valign='bottom' nowrap class='maindesc'>Address:</td>
					<td valign='bottom' class='mainbody'>................................................</td>
					<td w align='left' valign='bottom' nowrap class='maindesc'>Address: </td>
					<td valign='bottom' class='mainbody'>................................................</td>
				</tr>
				<tr><td align='left' valign='bottom' nowrap class='maindesc'>City/State/Zip: </td>
					<td valign='bottom' class='mainbody'>................................................</td>
					<td align='left' valign='bottom' nowrap class='maindesc'>City/State/Zip: </td>
					<td valign='bottom' class='mainbody'>................................................</td>
				</tr>
				<tr><td align='left' valign='bottom' nowrap class='maindesc'>Purchase Order No: </td>
					<td valign='bottom' class='mainbody'>................................................</td>
					<td align='left' valign='bottom' nowrap class='maindesc'>Requested Delivery Date: </td>
					<td valign='bottom' class='mainbody'>................................................</td>
				</tr>
				<tr><td align='left' valign='bottom' nowrap class='maindesc'>Customer Name: </td>
					<td valign='bottom' class='mainbody'>................................................</td>
					<td align='left' valign='bottom' nowrap class='maindesc'>Site Phone No</td>
					<td valign='bottom' class='mainbody'>................................................</td>
				</tr>
				<tr><td align='left' valign='bottom' nowrap class='maindesc'>Customer Signature: </td>
					<td valign='bottom' class='mainbody'>................................................</td>
					<td align='left' valign='bottom' nowrap class='maindesc'>&nbsp;</td>
					<td valign='bottom' class='mainbody'>&nbsp;</td>
				</tr>
				<tr><td align='left' valign='bottom' nowrap class='maindesc'>Email Address: </td>
					<td valign='bottom' class='mainbody'>................................................</td>
					<td align='left' valign='bottom' nowrap class='maindesc'>&nbsp;</td>
					<td valign='bottom' class='mainbody'>&nbsp;</td>
				</tr>
				<tr><td align='left' valign='bottom' nowrap class='maindesc'>Contact Phone No: </td>
					<td valign='bottom' class='mainbody'>................................................</td>
					<td align='left' valign='bottom' nowrap class='maindesc'>&nbsp;</td>
					<td valign='bottom' class='mainbody'>&nbsp;</td>
				</tr>
				<!--<tr><td width='100%' colspan='4'></td></tr>-->
			</table>
























			<br>
			<table cellspacing='0' cellpadding='0' border='0' width='100%'>
				<tr><td class='mainbody'>
						<%	if (product.equals("GE")){out.println("");}
							else if(product.equals("APC")){	out.println("Price is FOB plant.  Tax not included.");}
							else{
								if(group_id.startsWith("Internatio")|type.equals("5")|type.equals("6")) {
									if (product.equals("EJC")|product.equals("IWP")){
									//out.println("<br><br>NOTE: This price is based on furnishing types and quantities as listed and described above and in C/S standard colors and finishes. Pricing is based on furnishing material only in stock lengths of 10 LF or 20 LF.  If ultimate quantities or types change from those listed, this price will change accordingly. Prices do not include installation.");
									}
									if (product.equals("EFS")){
										out.println("<br>NOTE:  Attached production description sheets to be completed and returned with purchase order<br>");
									}
								}
								else{
									if(!quoteHeader.getExchName().equals("CAD")){
										out.println("Price is FOB plant, freight prepaid within continental U.S. or FAS dock export point. Tax not included.");
									}
								}
							}
						%>
					</td></tr>
				<!--<p style='page-break-after : always;' >&nbsp;</p>-->
				<tr><td >&nbsp;</td></tr>
				<!-- footer -->

				<tr><td class='mainfooter'>
						<%
						   String actionx=request.getParameter("action");
									 if(actionx==null){
										actionx="";
                }
						if(product.equals("LVR")||product.equals("GRILLE")){
						if(actionx.equals("rtf")){
						%>
						<font face="arial" style='font-size:9pt; '>
						<%
						}
						else{
						%>
						<font face="arial" style='font-size:6pt; '>
						<%
						}
					}
					else{
						%>
						<font face="arial" style='font-size:8pt; '>
						<%
					}

						%>

						TERMS & CONDITIONS
						<%

						if(quoteHeader.getExchName().equals("CAD")&&! (product.equals("LVR") || product.equals("GRILLE"))){
						%>
						<br>1. ON "SUPPLY ONLY" ORDERS THE FIELD DIMENSIONS ARE TO BE PROVIDED BY THE CUSTOMER.
						<br>2. THIS QUOTATION IS VALID FOR 45 DAYS FROM ABOVE DATE. AFTER SUCH DATE IT BECOMES NULL & VOID.
						<br>3. PAYMENT TERMS ARE NET 30 DAYS O.A.C.  NO HOLDBACKS ON SUPPLY ONLY. ORDERS ARE NOT ACCEPTED  FOR ACCOUNTS WITH OVERDUE BALANCES.
						<br>4. NO ORDERS WILL BE PROCESSED WITHOUT A WRITTEN PURCHASE ORDER OR SIGNED C/S QUOTE.
						<br>5. ON "SUPPLY ONLY" ITEMS, WARRANTY PERIOD COMMENCES ON THE DATE OF SHIPMENT.
						<br>6. DUE TO THE CUSTOM NATURE OF OUR PRODUCTS, REFUNDS WILL NOT BE GIVEN ON RETURNED MATERIALS.
						<br>7. PRE-PAID ORDERS UNDER $500.00 : COMPANY CHEQUE ACCEPTED,	OVER $500.00: CERTIFIED CHEQUE, MASTERCARD OR VISA.
						<br>8. STANDARD LEED DOCUMENTS WILL BE PROVIDED.
						<%
						}
						else if(group_id.startsWith("Internatio")|type.equals("5")|type.equals("6")) {
						%>
						<br>1.	The Buyer/Customer agrees to all C/S Terms and Conditions when they place their purchase order against this quote.
						<br>2.	Payment Terms: Payment in advance or Letter of Credit (LOC) prior to production; all C/S invoices must be paid in US Dollars.
						<br>3.	All banking, consulate, government requirements and/or inspection fees will be Buyer/Customer's responsibility.
						<br>4.  Prices are firm against escalation for 90 days from date of this quote, and for shipment within 6 months thereafter. Orders shipped beyond shall be subject to escalation of 1.5% per month or partial month thereafter and invoiced at time of shipment.
						<br>5.	Orders resulting from this quotation should be made out to Construction Specialties, Inc.
						<br>6.	This quote number must be present on your order.
						<br>7.	All orders with a material value of under $300.00 will have a minimum order fee of $50.00 in addition to the material costs (EJC only).
						<br>8.	Freight rate is subject to change based on actual weights and dimensions.
						<br>9.	All C/S orders will be shipped EX Works (EXW), or Free Carrier (FCA) Buyer's Forwarder - Continental U.S. Port (to be determined in final quote), referencing INCOTERMS 2010.
						<br>10.	All duties, fees, taxes or other costs associated with customs clearance or import duties are the sole responsibility of the Buyer/Customer. C/S will issue Certificates of Origin for eligible products only.
						<br>11.	This written contract supersedes all oral agreements.
						<br>12.	These commodities, technology or software, will be exported from the United States in accordance with the Export Administration Regulations. Diversion contrary to U.S. law is prohibited.
						<BR>13. For projects located outside the U.S. Construction Specialties requires that all freight forwarders who handle C/S product be C-TPAT certified. Please contact your local representative for more information and a list of available C-TPAT carriers in your area.
						<BR>14. Construction Specialties, Inc. will be listed as the USPPI (United States Principal Party in Interest) on all transactions for shipments exporting from the US.  This will include filing with US Customs and Export Documentation completion.
						<br><br>All claims, controversies, disputes, disagreements arising out of or related to this Agreement shall be subject to the exclusive jurisdiction of the courts of the State of New Jersey, United States of America. Any claims, controversies, disputes or disagreements arising out of or related to this Agreement shall be settled by arbitration administered by the American Arbitration Association under its Commercial Arbitration Rules. Such findings as are made by an arbitral panel agreed to by the parties to the Agreement shall be final and binding on both parties, with any such judgment enforceable in a federal or state court of the United States of America.
						<%
					}
					else{
						%>
						<br>1. <%
	//if(product.equals("GCP")){out.println("C/S Cubicle Curtains Company");}
	//else
	if(product.equals("GE")) {out.println("Impact Specialties, formerly Grand Entrance");}
	else {out.println("C/S");} %> Standard Terms and Conditions shall apply.
						<%
						if(product.equals("GE")) {
								out.println("View at <a href=\"javascript:n_window('http://www.c-sgroup.com/terms-conditions-sale')\">http://www.c-sgroup.com/terms-conditions-sale</a>");

						}
						%>
						<br>2. Payment terms are Net 30 Days, with no retention allowed.
						<br>3. Prices are firm against escalation for 90 days from date of this quote, and for shipment within 6 months thereafter. Orders shipped beyond shall be subject to escalation of <b>1.5%</b> per month for each month or partial month thereafter and invoiced at time of shipment.
						<br>4. The quotation may be withdrawn if not accepted within 90 days of quotation.
						<br>5. Orders resulting from this quotation should be made out to <%
						//if ((product.equals("GCP"))){out.println("Cubicle Curtains Company.");}
						//else
						if(product.equals("GE")) {out.println("Impact Specialties, formerly Grand Entrance");}
						else{

								out.println("Construction Specialties, Inc. c/o the representative listed above.");
						}
						if(product.equals("GRILLES") || product.equals("LVR")){
							out.println("<BR>6. C/S will supply our standard 1-year warranty for material.");
							out.println("<BR>7. Price includes a single delivery shipment in box trucking with standard wood crating.");
							out.println("<BR>8. For projects located outside the U.S. Construction Specialties requires that all freight forwarders who handle C/S product be C-TPAT certified. Please contact your local representative for more information and a list of available C-TPAT carriers in your area.");
							out.println("<BR>9. Construction Specialties, Inc. will be listed as the USPPI (United States Principal Party in Interest) on all transactions for shipments exporting from the US.  This will include filing with US Customs and Export Documentation completion.");
						}
						else{
							out.println("<BR>6. For projects located outside the U.S. Construction Specialties requires that all freight forwarders who handle C/S product be C-TPAT certified. Please contact your local representative for more information and a list of available C-TPAT carriers in your area.");
							out.println("<BR>7. Construction Specialties, Inc. will be listed as the USPPI (United States Principal Party in Interest) on all transactions for shipments exporting from the US.  This will include filing with US Customs and Export Documentation completion.");
						}
					//}
					}
						%>
					</td></tr></font>
				<!-- end footer -->
			</table>

