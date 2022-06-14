<html>
<HEAD>
<title>
Adding a New Customer
</title>	
<link rel='stylesheet' href='style1.css' type='text/css' />
<script language="JavaScript" src="check_order_sheet.js"></script>
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function explain1(name, output, msg) {
newwin = window.open('','','top=150,left=150,width=400%,height=400%');
if (!newwin.opener) newwin.opener = self;
with (newwin.document)
{
open();
write('<html>'); 
write('<head>');
write('<link rel="stylesheet" href="style1.css" type="text/css"/>');
write('</head>');
write('<body onLoad="document.form.box.focus()"><form name=form><h1>' + msg + '</h1><br>');
write('<p>Search for ' + name + ' BPCS customer here.');
write('<p><center>' + name + ':  <textarea name=box cols=30 rows=6 onKeyUp=' + output + '=this.value>'+window.document.selectform.order_notes.value+'</textarea>');
write('<p><input type=button value="Done" class="button" onClick=window.close()>');
write('</center></form></body></html>');
close();
   }
}
//  End -->
</script>
</HEAD>
<BODY bgcolor="whitesmoke">
<center>
<h1>Order Write-up Sheet</h1>
<form name="selectform" action="order_page1_save.jsp" onsubmit="return formCheck(this);">
	<input type='hidden' name="order_no" value='<%= order_no %>'>
	<input type='hidden' name="type_of_cust" value='<%= type_of_cust %>'>	
	<input type='hidden' name="rep_no" value='<%= rep_no %>'>
	<input type='hidden' name="arch_detect" value='N'>
<table border='0' width='100%'>
<tr><td COLSPAN='2'><h1>ORDER/JOB INFO ::</h1></td></tr>
<tr><td class='header' align='right' ><b>COMPANY:</b></td>
	<td class='header'>	<select name='cs_company'>
	<option></option>
	<%
String[] company = {"CS-MUNCY","CS-CRANFORD","CS-WISCONSIN","DECOGARD PRODUCTS","DECOLINK","SAM-CS","SAM-DECO"};
for (int i = 0; i < company.length; i++) {
 String selected = (company[i].equals(cs_company)) ? "selected" : ""; 
 %>
 						    <option value='<%= company[i] %>' <%= selected %>><%= company[i] %></option>
<% 
	} 
 %>						
						</select>
	</td>
	<td class='header' align='right' >ORDER TYPE:</td>
	<td class='header'><select name='doc_type'>
		<%
String[] otype = {"NEW ORDER","ADD/DEDUCT"};
for (int i = 0; i < otype.length; i++) {
String selected = (otype[i].equals(doc_type)) ? "selected" : ""; 
 %>			    <option value='<%= otype[i] %>' <%= selected %>><%= otype[i] %></option>
 <% 
	} 
 %>						
						</select></td>
	<td class='header' align='right' >ADD/DEDUCT JOB#:</td>
	<td class='header'><input type='text' name="add_deduct_job" class='text1'></td>	
</tr>
<tr>
	<td class='noheader' align='right' ><b>SALES REGION:</b></td>
	<td class='noheader' ><select name='sales_region'>
		<option></option>
		<%
if(product.equals("EFS")){
String[] sregion = {"T--EFS EAST","U--EFS WEST"};
for (int i = 0; i < sregion.length; i++) {
String selected = (sregion[i].equals(sales_region)) ? "selected" : ""; 
 %>
 <option value='<%= sregion[i] %>' <%= selected %>><%= sregion[i] %></option>
<% 
	}
}
else if (product.equals("EJC")){
String[] sregion = {"D--EJC EAST","Q--EJC WEST","V--EJC PARKING"};
for (int i = 0; i < sregion.length; i++) {
String selected = (sregion[i].equals(sales_region)) ? "selected" : ""; 
 %>
 <option value='<%= sregion[i] %>' <%= selected %>><%= sregion[i] %></option>
<% 
	}
}
else if (product.equals("IWP")){
String[] sregion = {"A--IWP EAST","J--IWP MID WEST","W--IWP WEST"};
for (int i = 0; i < sregion.length; i++) {
String selected = (sregion[i].equals(sales_region)) ? "selected" : ""; 
 %>
 <option value='<%= sregion[i] %>' <%= selected %>><%= sregion[i] %></option>
<% 
	}
}
else if (product.equals("LVR")|product.equals("BV")){
String[] sregion = {"MW--LVR","NE--LVR","WT--LVR"};
for (int i = 0; i < sregion.length; i++) {
String selected = (sregion[i].equals(sales_region)) ? "selected" : ""; 
 %>
 <option value='<%= sregion[i] %>' <%= selected %>><%= sregion[i] %></option>
<% 
	}
}
else {
String[] sregion = {"----","----"};
for (int i = 0; i < sregion.length; i++) {
String selected = (sregion[i].equals(sales_region)) ? "selected" : ""; 
 %>
 <option value='<%= sregion[i] %>' <%= selected %>><%= sregion[i] %></option>
<% 
	}
}
 
 %></select></td>		
	<td class='noheader' align='right' >JOB NAME:</td>
	<td class='noheader' ><input type='text' name="Project_name" value='<%= Project_name %>' class='notext1'></td>	
	<td class='noheader' align='right' >JOB LOCATION:</td>
	<td class='noheader' ><input type='text' name="Job_loc" value='<%= Job_loc %>' class='notext1'></td>		
</tr>
<tr><td class='noheader' COLSPAN='6' align='right' ><HR></td></tr>
</table>
<table  border='0' width='100%'>
<tr><td COLSPAN='2'><h1>BILLING CUSTOMER ::</h1></td></tr>
<tr><td class='header' align='right' ><b><a href="javascript:explain1('BPCS Customer NO', 'opener.document.selectform.order_notes.value', 'Order Notes');" onMouseOver="window.status='Click for searchin BPCS Customer No...';return true;" onMouseOut="window.status='';return true;">BILLING CUST NAME:</a></b></td>
<%
if(show.equals("Y")&cou<=0){
//out.println("The CS CUSTOMER TIME"+cust_name11);
cust_name1=cust_name11;cust_addr1=cust_addr11;cust_addr2=cust_addr21;city=cust_city1;state=cust_state1;
zip_code=cust_zip_code1;phone=cust_phone1;fax=cust_fax1;
} 

 %>
	<td class='header'><input type='text' name='cust_name1' value='<%= cust_name1 %>' class='text1'>	
	</td>
	<td class='header' align='right' >ADDRESS1:</td>
	<td class='header'><input type='text' name='cust_addr1' value='<%= cust_addr1 %>' class='text1'></td>
	<td class='header' align='right' >ADDRESS2:</td>
	<td class='header'><input type='text' name='cust_addr2' value='<%= cust_addr2 %>' class='text1'></td>
</tr>
<tr><td class='noheader' align='right' ><b>CITY:</b></td>
	<td class='noheader'><input type='text' name='city' value='<%= city %>' class='notext1'></td>
	<td class='noheader' align='right' ><b>STATE:</b></td>
	<td class='noheader'><input type='text' name='state' value='<%= state %>' class='notext1'>
		
	</td>	
	
	<td class='noheader' align='right' >ZIP:</td>
	<td class='noheader'><input type='text' name='zip_code' value='<%= zip_code %>' class='notext1'>
	</td>		
</tr>
<tr><td class='header' align='right' ><b>PHONE:</b></td>
	<td class='header'><input type='text' name='phone' value='<%= phone %>' class='text1'>	</td>
	<td class='header' align='right' >FAX:</td>
	<td class='header'><input type='text' name='fax' value='<%= fax %>' class='text1'>		
	</td>
	<td class='header' align='right' >CONTACT NAME:</td>
	<td class='header'><input type='text' name="contact_name" value='<%= contact_name %>' class='text1'></td>	
</tr>
<tr>
	<td class='noheader' align='right' NOWRAP><b>P.O.NUMBER (OR) SIGNED BY</b><BR>(Ex:John Doe as JDOE):</td>
	<td class='noheader'><input type='text' name="customer_po_no" value='<%= customer_po_no%>' class='notext1'></td>	
	<td class='noheader' align='right' >TAX EXEMPT NUMBER:</td>
	<td class='noheader'><input type='text' name="sales_exempt_no" value='<%= sales_exempt_no%>' class='notext1'></td>
	<td class='noheader' align='right' >CUSTOMER TYPE:</td>
	<td class='noheader'><select name='customer_type'>
	<option></option>
		<% 
String[] cust_type = {"CTR-CONTRACTOR","EU-END USER","RES-RESELLER","DIST-DISTRIBUTOR","OEM-ORIG EQUIP MFG","JV-JOINT VENTURE","ARCH-ARCHITECT","COMP-COMPETITOR","FF-FREIGHT FORWADER"};
for (int i = 0; i < cust_type.length; i++) {
String selected = (cust_type[i].equals(customer_type)) ? "selected" : ""; 
 %>			    <option value='<%= cust_type[i] %>' <%= selected %>><%= cust_type[i] %></option>
 <% 
	} 
 %>
						</select></td>
	
</tr>
<tr><td class='header' nowrap align='right' >MARKET TYPE:</td>
	<td class='header'><input type='text' name="market_type" value='<%= market_type%>'  class='text1'></td>	
	<td class='header' nowrap align='right' >CREDIT CARD SALE:</td>
		<td class='header'><select name='payment'>		
<%
if(payment_terms.equals("CC")){
out.println("<option value='NET 30 DAYS' >"+"&nbsp;"+"</option>");
out.println("<option value='CC' selected>"+"Credit Card"+"</option>");
out.println("<option value='CC1'>"+"Credit Card(Same as Billing)"+"</option>");
}
else if(payment_terms.equals("CC1")){
out.println("<option value='NET 30 DAYS'>"+"&nbsp;"+"</option>");
out.println("<option value='CC' >"+"Credit Card"+"</option>");
out.println("<option value='CC1' selected>"+"Credit Card(Same as Billing)"+"</option>");
}
else{
out.println("<option value='NET 30 DAYS' selected>"+"&nbsp;"+"</option>");
out.println("<option value='CC'>"+"Credit Card"+"</option>");
out.println("<option value='CC1' >"+"Credit Card(Same as Billing)"+"</option>");
}
%>  
</select></td>
<td class='header' nowrap align='right' >SAME FOR:</td>
<td class='header'>SHIPPING&nbsp;
<% if (cust_ship_info.equals("Y")){
out.println("<input type='checkbox' name='cust_ship_info' checked>"); 
}
else{
out.println("<input type='checkbox' name='cust_ship_info' >"); 
} 
%>
&nbsp;INVOICE&nbsp;
<% if (cust_invoice_info.equals("Y")){
out.println("<input type='checkbox' name='cust_invoice_info' checked>"); 
}
else{
out.println("<input type='checkbox' name='cust_invoice_info' >"); 
} 
%>
</td>	
</tr>
<tr><td class='noheader' COLSPAN='6' align='right' ><HR></td></tr>
</table>
<table  border='0' width='100%'>
<tr><td COLSPAN='2'><h1>END USER ::</h1></td></tr>
<tr><td class='header' align='right' ><a href="javascript:explain1('BPCS Customer NO', 'opener.document.selectform.order_notes.value', 'Order Notes');" onMouseOver="window.status='Click for searchin BPCS Customer No...';return true;" onMouseOut="window.status='';return true;">OWNER/END USER NAME:</a></td>
	<td class='header'><input type='text' name="eu_cust_name1" value='<%= eu_cust_name1 %>' class='text1'></td>
	<td class='header' align='right' >ADDRESS1:</td>
	<td class='header'><input type='text' name="eu_cust_addr1" value='<%= eu_cust_addr1 %>' class='text1'></td>
	<td class='header' align='right' >ADDRESS2:</td>
	<td class='header'><input type='text' name="eu_cust_addr2" value='<%= eu_cust_addr2 %>' class='text1'></td>

</tr>
<tr><td class='noheader' align='right' >CITY:</td>
	<td class='noheader'><input type='text' name="eu_city" value='<%= eu_city %>' class='notext1'></td>	
	<td class='noheader' align='right' >STATE:</td>
	<td class='noheader'><input type='text' name="eu_state" value='<%= eu_state %>' class='notext1'></td>		
	<td class='noheader' align='right' >ZIP:</td>
	<td class='noheader'><input type='text' name="eu_zip_code" value='<%= eu_zip_code %>' class='notext1'></td>		
</tr>	
<tr><td class='header' align='right' >PHONE:</td>
	<td class='header'><input type='text' name="eu_phone" value='<%= eu_phone %>' class='text1'></td>
	<td class='header' align='right' >FAX:</td>
	<td class='header'><input type='text' name="eu_fax" value='<%= eu_fax %>' class='text1'></td>	
	<td class='header' align='right' >MARKET TYPE:</td>
	<%if ( market_type1 ==null ){
	market_type1="";
	}	
	
	%>
	<td class='header'><input type='text' name="eu_market_type" value='<%= market_type1 %>' class='text1'></td>		
</tr>
<tr><td class='noheader' COLSPAN='6' align='right' ><HR></td></tr>
</table>

<table border='0' align='right'>
<tr>
<td COLSPAN='3' align='right'>Page 1</td>
<td COLSPAN='3' align='right'>| <a href="order_transfer.jsp?cmd=2&order_no=<%= order_no %>&id=<%= rep_no %>">View Page 2</a></td>
<td COLSPAN='3' align='right'>| <a href="order_transfer.jsp?cmd=3&order_no=<%= order_no %>&id=<%= rep_no %>">View Page 3</a></td>
<td COLSPAN='3' align='right'>| <a href="order_transfer.jsp?cmd=5&order_no=<%= order_no %>&id=<%= rep_no %>">View Page 4</a></td>
<td COLSPAN='3' align='right'>| <a href="order_transfer.jsp?cmd=4&order_no=<%= order_no %>&id=<%= rep_no %>">Order Sheet</a></td>
</tr>
</table>
<br><br>
<input type='submit' name='enter' value='Save & Continue' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6'>
<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='Line Item List' value='Line Item List' onclick=javascript:document.location.href='https://<%= application.getInitParameter("HOST")%>/erapid/us/order_list.jsp?order_no=<%= order_no%>'>
<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='Header'         value='Quote Header'   onclick=javascript:document.location.href='https://<%= application.getInitParameter("HOST")%>/erapid/us/edit_delete_home.jsp?cmd=edit&order_no=<%= order_no%>&item_no=1&amp;subline_no=0'></form>

</form>
</center>
</body>
</html>

