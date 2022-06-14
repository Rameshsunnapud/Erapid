<%
String spaces="..................................................";
String shipping_name1=spaces;
String shipping_address1=spaces;
String shipping_address2="";
String shipping_city="................";
String shipping_state="................";
String shipping_zipcode="................";
String shipping_phone=spaces;
String bill_name1=spaces;
String bill_address1=spaces;
String bill_address2="";
String bill_city="................";
String bill_state="................";
String bill_zipcode="................";
String bill_customer_po_no=spaces;

ResultSet rsshipping=stmt.executeQuery("select name_1,address_1,address_2,city,state,zip_code,phone from shipping where order_no='"+order_no+"'");
if(rsshipping != null){
	while(rsshipping.next()){
		if(rsshipping.getString("name_1")!=null){
			shipping_name1=rsshipping.getString("name_1");
		}
		else{
			shipping_name1=spaces;
		}
		if(rsshipping.getString("address_1")!=null){
			shipping_address1=rsshipping.getString("address_1");
		}
		else{
			shipping_address1=spaces;
		}
		if(rsshipping.getString("address_2")!=null){
			shipping_address2=rsshipping.getString("address_2");
		}
		if(rsshipping.getString("city")!=null){
			shipping_city=rsshipping.getString("city");
		}
		else{
			shipping_city="................";
		}
		if(rsshipping.getString("state")!=null){
			shipping_state=rsshipping.getString("state");
		}
		else{
			shipping_state="................";
		}
		if(rsshipping.getString("zip_code")!=null){
			shipping_zipcode=rsshipping.getString("zip_code");
		}
		else{
			shipping_zipcode="................";
		}
		if(rsshipping.getString("phone")!=null){
			shipping_phone =rsshipping.getString("phone ");
		}
		else{
			shipping_phone =spaces;
		}
	}
}
rsshipping.close();
ResultSet rsbill=stmt.executeQuery("select * from cs_billed_customers where order_no='"+order_no+"'");
if(rsbill != null){
	while(rsbill.next()){
		if(rsbill.getString("cust_name1") != null && rsbill.getString("cust_name1").trim().length()>0){
			bill_name1=rsbill.getString("cust_name1");
		}
		if(rsbill.getString("cust_addr1") != null && rsbill.getString("cust_addr1").trim().length()>0){
			bill_address1=rsbill.getString("cust_addr1");
		}
		if(rsbill.getString("cust_addr2") != null && rsbill.getString("cust_addr2").trim().length()>0){
			bill_address2=rsbill.getString("cust_addr2");
		}
		if(rsbill.getString("city") != null && rsbill.getString("city").trim().length()>0){
			bill_city=rsbill.getString("city");
		}
		if(rsbill.getString("state") != null && rsbill.getString("state").trim().length()>0){
			bill_state=rsbill.getString("state");
		}
		if(rsbill.getString("zip_code") != null && rsbill.getString("zip_code").trim().length()>0){
			bill_zipcode=rsbill.getString("zip_code");
		}
		if(rsbill.getString("customer_po_no") != null && rsbill.getString("customer_po_no").trim().length()>0){
			bill_customer_po_no=rsbill.getString("customer_po_no");
		}
	}
}
rsbill.close();


%>
<font class='maindesc'><b>Price is FOB plant, freight prepaid (to jobsite) within continental U.S. or FAS dock export point.</b> CS Standard Terms and Conditions shall apply. Payment terms are net 30 days with no retention allowed, subject to credit approval by Construction Specialties.  Construction Specialties reserves the right to modify payment terms upon review of customers credit history. Prices are firm against escalation for 90 days from date of this quote, and for shipment within 6 months thereafter. Orders shipped beyond shall be subject to escalation of 1.5% per month for each month or partial month thereafter and invoiced at time of shipment. The quotation may be withdrawn if not accepted within 90 days of quotation.
</font>
<BR><BR>
<%

if(carriage_loc.equals("1")){
	%>
	<font class='maindesc'>Construction Specialties, Inc. is NOT proceeding with the above proposed change order until a signed change proposal is received. Contractor agrees to the above quoted material by signing below and returning this proposal via fax or e-mail.</font>
	<%
}
else if(carriage_loc.equals("2")){
	%>
	<font class='maindesc'>Construction Specailties, Inc. is proceeding with the above proposed changes. Please forward a signed change order immediately or sign below and forward via fax or e-mail.</font>
	<%
}
out.println("<br><br>");
out.println("<table width='100%' border='0'><tr><td width='10%' align='right'><font class='maindesc'><b>Signature</td><td width='40%' align='left'><font class='maindesc'><b>_______________________________________________</td><td width='10%' align='right'><font class='maindesc'><b>Date</td><td width='40%' align='left'><font class='maindesc'><b>_______________________________________________</td></tr></table>");
/*
%>
<BR><BR>
<table width='100%' border='0' cellspacing='0' cellpadding='2'>
	<tr>
		<td width='50%' align='left' valign='bottom' colspan='2' nowrap class='maindesc'><b><u>Acceptance:</u></b></td>
		<td width='50%' align='left' valign='bottom' colspan='2' nowrap class='maindesc'><b><u>Shipping:</u></b> </td>
	</tr>
	<tr>
		<td width='12%' align='left' valign='bottom' nowrap class='maindesc'>Bill To: </td>
		<td width='25%' valign='bottom' class='mainbodyh'><%=bill_name1%></td>
		<td width='15%' align='left' valign='bottom' nowrap class='maindesc'>Ship To: </td>
		<td width='25%' valign='bottom' class='mainbodyh'><%=shipping_name1%></td>
	</tr>
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>Address:</td>
		<td valign='bottom' class='mainbodyh'><%=bill_address1%> <%=bill_address2%></td>
		<td w align='left' valign='bottom' nowrap class='maindesc'>Address: </td>
		<td valign='bottom' class='mainbodyh'><%=shipping_address1%> <%=shipping_address2%></td>
	</tr>
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>City/State/Zip: </td>
		<td valign='bottom' class='mainbodyh'><%=bill_city%>/<%=bill_state%>/<%=bill_zipcode%></td>
		<td align='left' valign='bottom' nowrap class='maindesc'>City/State/Zip: </td>
		<td valign='bottom' class='mainbodyh'><%=shipping_city%>/<%=shipping_state%>/<%=shipping_zipcode%></td>
	</tr>
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>Purchase Order No: </td>
		<td valign='bottom' class='mainbodyh'><%=bill_customer_po_no%></td>
		<td align='left' valign='bottom' nowrap class='maindesc'>Requested Delivery Date: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
	</tr>
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>Customer Name: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
		<td align='left' valign='bottom' nowrap class='maindesc'>Site Phone No:</td>
		<td valign='bottom' class='mainbodyh'><%=shipping_phone%></td>
	</tr>
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>Customer Signature: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
		<td align='left' valign='bottom' nowrap class='maindesc'></td>
		<td valign='bottom' class='mainbodyh'></td>
	</tr>
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>Email Address: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
		<td align='left' valign='bottom' nowrap class='maindesc'></td>
		<td valign='bottom' class='mainbodyh'></td>
	</tr>
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>Contact Phone No: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
		<td align='left' valign='bottom' nowrap class='maindesc'></td>
		<td valign='bottom' class='mainbodyh'></td>
	</tr>
	<!--<tr><td width='100%' colspan='4'></td></tr>-->

</table>
<%

*/
%>