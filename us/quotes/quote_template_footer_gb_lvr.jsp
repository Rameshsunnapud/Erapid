<%
	double cSqftTemp=0;
	int cSqft =0;
	ResultSet rsCosting=stmt.executeQuery("select qty,clad_code,stile_code,sqft from cs_costing where order_no='"+order_no+"'");
	if(rsCosting != null){
		while(rsCosting.next()){
			cSqftTemp=cSqftTemp+rsCosting.getDouble("sqft");
		}
	}
	cSqft = (int) cSqftTemp;
	rsCosting.close();
	
for1.setMaximumFractionDigits(0);

//added by AC 3/11/2013 as the LVR quote subtotal was the grand total
grand_total1=new Double(price).doubleValue();
grand_total3=(float) grand_total1;

//out.println(product+"HERE"+ sections);
%>

<table cellspacing='0' cellpadding='0' border='0' width='100%' height='25'>
	<tr>
			<td align="center"><div class="styletr">&nbsp;<div></td>
		</tr>
	<tr>
		
		<td width='25%' valign='center' align='right'><b>Material Furnished Only: Total SQFT: </b><%=cSqft%>&nbsp;</td>
		</tr>
<tr>
<td class='tableline_row mainbody' width='75%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>$<%= for12x.format(grand_total1) %></font>&nbsp;<%=currencyName%></b>
    <%if(customerCountry.equals("CANADA")){
		out.println("&nbsp;CAD (F.O.B. Origin, Freight Included, Excluding Tax)");

	}%>
</td>
</tr>

<tr>
			<td align="center"><div class="styletr">&nbsp;<div></td>
		</tr>
</table>

<br><br>

<%
if(sections<=1){
	String pricing_options_text="";
	
	if(pricing_options.trim().length()>0 ||pricing_options_free_text.trim().length()>0){
		//out.println("<table cellspacing='0' align='center' cellpadding='0' border='0' width='100%'>");
		//out.println("<tr><td class='mainbodyh'><b>Pricing Options: </b></td></tr> ");
		
		ResultSet rsPricingOptions=stmt.executeQuery("select description from cs_pricing_options where product_id='"+product+"' and code in ("+pricing_options+")");
		if(rsPricingOptions != null){
			while(rsPricingOptions.next()){
				//out.println("<tr><td class='mainbodyh'>"+rsPricingOptions.getString(1)+"</td></tr>");
				pricing_options_text = rsPricingOptions.getString(1);
				if (pricing_options_text == null) {
					pricing_options_text = "";
				}
			}
		}
		rsPricingOptions.close();
		
		if(pricing_options_free_text.trim().length()>0){
			//out.println("<tr><td class='mainbodyh'>"+pricing_options_free_text+"<BR>");
			pricing_options_text = pricing_options_text + ". " + pricing_options_free_text;
		}
		//out.println("&nbsp;</td></tr></table>");
	}
	if(qualifying_notes_free_text==null){
		qualifying_notes_free_text="";
	}
	if(exclusions_free_text==null){
		exclusions_free_text="";
	}
	if(free_text==null){
		free_text="";
	}

	for(int rr=0; rr<qualifying_notes_free_text.length(); rr++){
		//out.println((int)qualifying_notes_free_text.charAt(rr)+"#"+qualifying_notes_free_text.charAt(rr)+"::");
		if((int)qualifying_notes_free_text.charAt(rr)==10){
			qualifying_notes_free_text=qualifying_notes_free_text.substring(0,rr)+"<br>"+qualifying_notes_free_text.substring(rr);
			rr=rr+4;
		}
	}
	for(int rr=0; rr<exclusions_free_text.length(); rr++){
		if((int)exclusions_free_text.charAt(rr)==10){
			exclusions_free_text=exclusions_free_text.substring(0,rr)+"<br>"+exclusions_free_text.substring(rr);
			rr=rr+4;
		}
	}
	for(int rr=0; rr<free_text.length(); rr++){
		//out.println((int)qualifying_notes_free_text.charAt(rr)+"#"+qualifying_notes_free_text.charAt(rr)+"::");
		if((int)free_text.charAt(rr)==10){
			free_text=free_text.substring(0,rr)+"<br>"+free_text.substring(rr);
			rr=rr+4;
		}
	}

		if (((free_text.trim()).length()>0)){
			/*out.println("<table cellspacing='0' align='center' cellpadding='1' border='0' width='100%'>");
			out.println("<tr><td class='mainbodyh'>");
			out.println("<font class='mainbodyh'>"+free_text+"<br></font>");
			out.println("</td></tr>");
			out.println("</table>");*/
		}

%>

<div class="Title"><label>QUOTE NOTES<label><br><hr></div>

<table width='100%' border='0' cellspacing='0' cellpadding='0'>
	<tr>
		<td align='left' class='data2'><b>Pricing Options: </b><%=pricing_options_text%></td>
	</tr>
	<tr>
		<td align='left' class='data2'><b>Exclusion Notes: </b><%=free_text%></td>
	</tr>
</table>

<%
}
%>

<br>
<br>

<div class="Title"><label>CUSTOMER APPROVAL<label><hr></div>

<table width='100%' border='0' cellspacing='0' cellpadding='0'>
	<tr>
		<td width='50%'>
			<table border='0' cellspacing='0' cellpadding='0'>
				<tr>
					<td align='left' valign='bottom' nowrap class="data2">Bill To</td>
				</tr>
				<tr>
					<td align='left' valign='bottom' nowrap class="data2">Customer Name:<span width="100%" style='padding-right: 23.5em;' class='underline'/></span></td>
				</tr>
				<tr>
					<td align='left' valign='bottom' nowrap class="data2">Address:<span width="100%" style='padding-right: 27em;' class='underline'/></td>
				</tr>
				<tr>
					<td align='left' valign='bottom' nowrap class="data2">City/State/Zip:<span width="100%" style='padding-right: 24.5em;' class='underline'/></td>
				</tr>
				<tr>
					<td align='left' valign='bottom' nowrap class="data2">Email Address:<span width="100%" style='padding-right: 24em;' class='underline'/></td>
				</tr>
				<tr>
					<td align='left' valign='bottom' nowrap class="data2">Purchase Order No:<span width="100%" style='padding-right: 22em;' class='underline'/></td>
				</tr>
				<tr>
					<td align='left' valign='bottom' nowrap class="data2">Contact Phone Number:<span width="100%" class='underline'/></td>
				</tr>
				<tr>
					<td align='left' valign='bottom' nowrap class="data2">Customer Signature:<span width="100%" style='padding-right: 21.5em;' class='underline'/></td>
				</tr>
			</table>
		</td>
		<td width='50%'>
			<table border='0' cellspacing='0' cellpadding='0'>
				<tr>
					<td align='left' valign='bottom' nowrap>Ship To</td>
				</tr>
				<tr>
					<td align='left' valign='bottom' nowrap>Address:<span width="100%" style='padding-right: 27em;' class='underline'/></td>
				</tr>
				<tr>
					<td align='left' valign='bottom' nowrap>City/State/Zip:<span width="100%" style='padding-right: 24.5em;' class='underline'/></td>
				</tr>
				<tr>
					<td align='left' valign='bottom' nowrap>Requested Delivery Date:<span width="100%" style='padding-right: 19.5em;' class='underline'/></td>
				</tr>
				<tr>
					<td align='left' valign='bottom' nowrap>Site Phone No:<span width="100%" style='padding-right: 24.5em;' class='underline'/></td>
				</tr>
				<tr>
					<td align='left' valign='bottom' nowrap>&nbsp;</td>
				</tr>
				<tr>
					<td align='left' valign='bottom' nowrap>&nbsp;</td>
				</tr>
				<tr>
					<td align='left' valign='bottom' nowrap>&nbsp;</td>
				</tr>
			</table>
		</td>
	</tr>
<table>
<br>
<br>

<div class="Title"><label>TERMS & CONDITIONS<label><br><hr></div>

<table cellspacing='0' cellpadding='0' border='0' width='100%'>
	<tr>
		<td class='data2'>
			This quotation is subject to Construction Specialties Terms and Conditions of offer in effect as of the date hereon 
			and located at www.c-sgroup.com/termsandconditions. Printed Terms and Conditions of Offer can be provided 
			by emailing your request to terms@c-sgroup.com. This quotation together with Construction Specialties Terms and 
			Conditions of Offer constitute the entire agreement between the parties.
		</td>
	</tr>
</table>

<br>
<br>


