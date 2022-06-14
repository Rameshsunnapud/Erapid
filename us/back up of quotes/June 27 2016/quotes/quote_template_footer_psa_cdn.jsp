<%

for1.setMaximumFractionDigits(0); 
if( !((product.equals("LVR"))|(product.equals("BV"))|(product.equals("GRILLE"))  ) ){

	double gst_tax_dollar=0;
	double pst_tax_dollar=0;
	double harmonized_tax_dollar=0;

	double tax_dollar=0; 
	String gst="";
	String pst="";
	String harmonized="";
	String pstappliedtogst="";
	//out.println(project_state2+"::<BR>");
	ResultSet rsCDNTax=stmt.executeQuery("select * from cs_canadian_taxes where province='"+project_state2+"'");
	if(rsCDNTax != null){
		while(rsCDNTax.next()){
			gst=rsCDNTax.getString("gst");
			pst=rsCDNTax.getString("pst");
			harmonized=rsCDNTax.getString("harmonized");
			pstappliedtogst=rsCDNTax.getString("pstappliedtogst");
		}
	}
	rsCDNTax.close();
	//out.println(gst+"::"+pst+"::"+harmonized+"::"+pstappliedtogst+"::<BR>");
	if(harmonized == null || harmonized.trim().length()<=0 || harmonized.equals("0")){	
		if(pstappliedtogst!=null && pstappliedtogst.equals("1")){
			if(gst != null && gst.trim().length()>0){
				gst_tax_dollar=(grand_total*new Double(gst).doubleValue())/100;
			}
			if(pst != null && pst.trim().length()>0){
				pst_tax_dollar=((grand_total+gst_tax_dollar)*new Double(pst).doubleValue())/100;
			}
		}
		else{
			if(gst != null && gst.trim().length()>0){
				gst_tax_dollar=(grand_total*new Double(gst).doubleValue())/100;
			}
			if(pst != null && pst.trim().length()>0){
				pst_tax_dollar=(grand_total*new Double(pst).doubleValue())/100;
			}
		}
		tax_dollar=gst_tax_dollar+pst_tax_dollar;
	}
	else{
		harmonized_tax_dollar=(grand_total*new Double(harmonized).doubleValue())/100;
		tax_dollar=harmonized_tax_dollar;
	}
	

		if(supplyinstall.toUpperCase().equals("Y")){
			%>
			<table class='<%= border_color %>' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
			<td class='tableline_row mainbody' width='50%' valign='middle'><b>Supply & Installed</b><br><font class='maindesc'>*All Taxes Extra</font></td>		
			<%
		}
		else{
			%>
			<table class='<%= border_color %>' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
			<td class='tableline_row mainbody' width='50%' valign='middle'><b>Supply Only</b><br><font class='maindesc'>*All Taxes Extra</font></td>		
			<%
		
		}%>
		<td class='tableline_row mainbody' width='50%' align='right' valign='top' nowrap><b>Total: <font class='totprice'><%= price %></font></b></td>
		</tr>		
		<%


		grand_total=grand_total+tax_dollar;
		/*
		if (!(gst==null||gst.equals("0")||pst==null||pst.equals("0"))){		
			out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='95%' height='25'><tr>");
			out.println("<tr>");
			out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>PST Tax "+pst+"%</b></td>");
			out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(pst_tax_dollar)+"</font></b></td>");
			out.println("</tr>");
			out.println("</table>");
			out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='95%' height='25'><tr>");
			out.println("<tr>");
			out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>GST Tax "+gst+"%</b></td>");
			out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(gst_tax_dollar)+"</font></b></td>");
			out.println("</tr>");
			out.println("</table>");			
			out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='95%' height='25'><tr>");
			out.println("<tr>");
			out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Total </b></td>");
			out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(grand_total)+"</font></b></td>");
			out.println("</tr>");		
		}
		else 	if (!(harmonized==null||harmonized.equals("0"))){		
			out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='95%' height='25'><tr>");
			out.println("<tr>");
			out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>HST Tax</b></td>");
			out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(harmonized_tax_dollar)+"</font></b></td>");
			out.println("</tr>");
			out.println("</table>");
			
			out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='95%' height='25'><tr>");
			out.println("<tr>");
			out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Total </b></td>");
			out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(grand_total)+"</font></b></td>");
			out.println("</tr>");		
		}
		*/
		out.println("</table>");	


}
if(new Double(freight_cost).doubleValue()>0){
	%>
	<br>
	<table cellspacing='0' cellpadding='0' border='0' width='100%'>
	<tr><td class='mainbodyh'>F.O.B. CS Plant Mississauga, Freight cost included to job site.</td></tr></table><BR>
	<%
}
else{
	%>
	<br>
	<table cellspacing='0' cellpadding='0' border='0' width='100%'>
	<tr><td class='mainbodyh'>F.O.B. CS Plant Mississauga, Freight cost extra.</td></tr></table><BR>
	<%
}
%>
<table border='0' width='100%'>
<%
if(!(psa_estimator==null)){
//out.println(psa_estimator+"::<BR>");
	if(psa_estimator.trim().length()>0){ 
	 	ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT fullname FROM dba.sauser where sauser_id like '"+psa_estimator.trim()+"'");
	  		if (rs_psa_lookup !=null) {
	        	while (rs_psa_lookup.next()) {
						psa_estimator= rs_psa_lookup.getString(1);
				}
			}
		rs_psa_lookup.close();
	}
}else{psa_estimator="";}


//out.println("<tr><td class='mainbodyh'>&nbsp;</td></tr>");
if(!group_id.startsWith("Can")){
	out.println("<tr>");
	//out.println("<TR><TD>"+product+" HERE</td></tr>");

	if(!group_id.startsWith("Internatio")) {
		if(product.endsWith("IWP")){
			out.println("<td width=50% class='mainbodyh' align=left>&nbsp;&nbsp;</td>");
			if(group_id.startsWith("Decolink")){
				out.println("<td width=50% class='mainbodyh' align='left'><b>Estimator:</b>"+psa_estimator+"</td>");
			}else{
				out.println("<td width=50% class='mainbodyh' align='left'><b>Regional Sales Manager(RSM):</b>"+ psa_rsm+"</td>");
			}
		}
		else if(product.endsWith("LVR")|product.equals("BV")|product.endsWith("GRILLE")|product.endsWith("GCP")){
			out.println("<td width=50% class='mainbodyh' align='left'><b>Estimator:</b>&nbsp;"+psa_estimator+"</td>");
			out.println("<td width=50% class='mainbodyh' align='left'>&nbsp;</td>");
		}
		else if(product.endsWith("GE")){
		}
		else{
			out.println("<td width=50% class='mainbodyh' align='left'><b>Estimator:</b>&nbsp;"+psa_estimator+"</td>");

				out.println("<td width=50% class='mainbodyh' align='left'><b>Regional Sales Manager(RSM):</b>"+ psa_rsm+"</td>");

		}
	}
	else{
		out.println("<td width=50% class='mainbodyh' align=left>&nbsp;&nbsp;</td>");
		if(group_id.startsWith("Internatio")) {
			out.println("<td width=15% class='mainbodyh' align='left' valign='top'><b>Estimator:</b></td><td width='35%' align='left' class='mainbodyh'>"+rep_name+"<BR>"+rep_telephone+"<br>"+rep_fax+"<BR>"+rep_email2+"</td>");
		}
		else{
			out.println("<td width=15% class='mainbodyh' align='left' valign='top'><b>Estimator:</b></td><td width='35%' align='left' class='mainbodyh'>"+rep_name+"<BR>"+rep_telephone+"<br>"+rep_fax+"</td>");
		}
	}
	out.println("</tr>");
}
%>
</table>
<%

%>


<table width='100%' border='0' style='border-collapse: collapse;' cellspacing='0' cellpadding='2'>
	<tr>
		<td width='50%' align='left' valign='bottom' colspan='2' nowrap class='maindesc'><b><u>Acceptance:</u></b></td>
		<td width='50%' align='left' valign='bottom' colspan='2' nowrap class='maindesc'><b><u>Shipping:</u></b> </td>
	</tr>
	<tr>
		<td width='15%' align='left' valign='bottom' nowrap class='maindesc'>Bill To: </td>
		<td width='25%' valign='bottom' class='mainbodyh'>..................................................</td>
		<td width='30%' align='left' valign='bottom' nowrap class='maindesc'>Ship To: </td>
		<td width='30%' valign='bottom' class='mainbodyh'>..................................................</td>
	</tr>
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>Address:</td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
		<td w align='left' valign='bottom' nowrap class='maindesc'>Address: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
	</tr>
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>&nbsp;</td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
		<td w align='left' valign='bottom' nowrap class='maindesc'>&nbsp; </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
	</tr>	
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>City/Prov: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
		<td align='left' valign='bottom' nowrap class='maindesc'>City/Prov: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
	</tr>
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>Postal Code: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
		<td align='left' valign='bottom' nowrap class='maindesc'>Postal Code: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
	</tr>	
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>Purchase Order No: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
		<td align='left' valign='bottom' nowrap class='maindesc'>Requested Delivery Date: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
	</tr>
	<tr><td align='left' valign='bottom' nowrap class='maindesc'>Customer Name: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
		<td align='left' valign='bottom' nowrap class='maindesc'>Site Phone No</td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
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
<br>
<table cellspacing='0' cellpadding='0' border='0' width='100%'>
<!--<p style='page-break-after : always;' >&nbsp;</p>-->
<tr><td >&nbsp;</td></tr>
<!-- footer -->
	<tr><td class='mainfooter'>
<%
if(product.equals("LVR")||product.equals("GRILLE")){
	%>
	<font style='font-size:6pt; '>
	<%
}
else{
	%>
	<font style='font-size:8pt; '>
	<%
}
%>
TERMS & CONDITIONS
<br>1. ON "SUPPLY ONLY" ORDERS THE FIELD DIMENSIONS ARE TO BE PROVIDED BY THE CUSTOMER. 
<br>2. THIS QUOTATION IS VALID FOR 45 DAYS FROM ABOVE DATE. AFTER SUCH DATE IT BECOMES NULL & VOID.
<br>3. PAYMENT TERMS ARE NET 30 DAYS O.A.C.  NO HOLDBACKS ON SUPPLY ONLY. ORDERS ARE NOT ACCEPTED FOR ACCOUNTS WITH OVERDUE BALANCES.           
<br>4. NO ORDERS WILL BE PROCESSED WITHOUT A WRITTEN PURCHASE ORDER.
<br>5. ON "SUPPLY ONLY" ITEMS, WARRANTY PERIOD COMMENCES ON THE DATE OF SHIPMENT.
<br>6. DUE TO THE CUSTOM NATURE OF OUR PRODUCTS, REFUNDS WILL NOT BE GIVEN ON RETURNED MATERIALS.
</td></tr></font>
<!-- end footer -->
</table>


