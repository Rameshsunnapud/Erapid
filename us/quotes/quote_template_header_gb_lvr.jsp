<%                String action=request.getParameter("action");
                if(action==null){
                    action="";
                }
%>

<link rel='stylesheet' href='greenbelt_lvr.css' type='text/css' />
<!-- header -->
<%
if(pdf==null ||  !pdf.toUpperCase().equals("TRUE")){
%>
<table cellspacing='0' cellpadding='0' border='0' width='100%' class="FirstLayoutLeft">
	<tr>
		<%
			out.println("<td align='left'><img src='../../images/cs_logo_large.jpg' alt='CS Logo' class='logo'></td>");
		%>
	</tr></table>

<%
}

%>
<!-- end header -->
<table cellspacing='0' cellpadding='0' border='0' width='100%' class="FirstLayoutRight">
	<%
		out.println("<tr><td align='right' class='TextStyleGrey' style='padding: 0px'>3 Werner Way; Lebanon, NJ 08833</td></tr>");
		out.println("<tr><td align='right' class='TextStyleGrey' style='padding: 0px'>TEL 888.331.2031</td></tr>");
	%>

</table>
<div class="Title"><label>PROJECT INFORMATION<label><br><hr></div>

<%
if(Project_name == null || Project_name.startsWith("null")) {Project_name="";}
if(project_city == null || project_city.startsWith("null")) {project_city="";}
if(project_state == null || project_state.startsWith("null")) {project_state="";}
if(cust_name1 == null || cust_name1.startsWith("null")) {cust_name1="";}
if(city == null || city.startsWith("null")) {city="";}
if(Arch_name == null || Arch_name.startsWith("null")) {Arch_name="";}
if(Arch_loc == null || Arch_loc.startsWith("null")) {Arch_loc="";}
if(rep_account == null || rep_account.startsWith("null")) {rep_account="";}
String rep_address = "";
if(!(address1 == null || address1.startsWith("null"))) {rep_address=address1.trim();}
if(!(address2 == null || address2.startsWith("null"))) {rep_address=rep_address+" "+address2.trim();}
if(rep_city == null || rep_city.startsWith("null")) {rep_city="";}
if(rep_zip_code == null || rep_zip_code.startsWith("null")) {rep_zip_code="";}
if(rep_state == null || rep_state.startsWith("null")) {rep_state="";}
if(rep_email == null || rep_email.startsWith("null")) {rep_email="";}
if(rep_telephone == null || rep_telephone.startsWith("null")) {rep_telephone="";}
if(odate == null || odate.startsWith("null")) {odate="";}
if(edate == null || edate.startsWith("null")) {edate="";}
%>
				
<table cellspacing='0' cellpadding='0' border='0' width='100%'>
	<tr>
		<td width="70%" align="left">
			<table cellspacing='0' cellpadding='0' border='0' class='inner_table'>
				<tr>
					<td align="left"><label>Project:</label>&nbsp;<%= Project_name %></td>
				</tr>
				<tr>
					<td align="left" class="data">Location:&nbsp;<%= project_city %>, <%= project_state %></td>
				</tr>
				<tr>
					<td align="left"><label>Prepared For:</label>&nbsp;<%= cust_name1 %>, <%= city %></td>
				</tr>
				<tr>
					<td align="left"><label>Architect:</label>&nbsp;<%= Arch_name %></td>
				</tr>
				<tr>
					<td align="left" class="data">Location:&nbsp;<%= Arch_loc %></td>
				</tr>
				<tr>
					<td align="left"><label>Representative:</label>&nbsp;<%= rep_account %></td>
				</tr>
				<tr>
					<td align="left" class="data">Location:&nbsp;<%= rep_address.trim() %>, <%= rep_city %> <%= rep_zip_code %> <%= rep_state %></td>
				</tr>
				<tr>
					<td align="left" class="data">Email:&nbsp;<%= rep_email %></td>
				</tr>
				<tr>
					<td align="left" class="data">Phone:&nbsp;<%= rep_telephone %>&nbsp;&nbsp;Fax:&nbsp;<%= rep_fax %></td>
				</tr>
			</table>
			
		</td>
		<td width="30%" align="left">
			<table cellspacing='0' cellpadding='0' border='0' class='inner_table'>
				<tr>
					<td align="left"><label class="product_title">Louvers</label></td>
				</tr>
				<tr>
					<td align="left"><label>Opportunity:</label>&nbsp;</td>
				</tr>
				<tr>
					<td align="left"><label>Quote No:</label>&nbsp;</td>
				</tr>
				<tr>
					<td align="left"><label>Scan:</label>&nbsp;<%= session_group_id %></td>
				</tr>
				<tr>
					<td align="left"><label>ERapid No:</label>&nbsp;<%= order_no %></td>
				</tr>
				<tr>
					<td align="left"><label>Quote Date:</label>&nbsp;<%= odate %></td>
				</tr>
				<tr>
					<td align="left"><label>Bid Date:</label>&nbsp;<%= edate %></td>
				</tr>
			</table>
		</td>
	</tr>
<table>

<br>
