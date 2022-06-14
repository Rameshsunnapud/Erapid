

<body bgcolor="white" topmargin="25" leftmargin="25" bgcolor="white" marginheight="0" marginwidth="0">
<!-- header -->
<%
String pdf=request.getParameter("pdf");
if(pdf==null ||  !pdf.toUpperCase().equals("TRUE")){
	%>
	<table cellspacing='0' cellpadding='0' border='0' width='100%'>
	<tr>
	<%
	out.println("<td align='left' width='80%'><img src='http://csimages.c-sgroup.com/eRapid/cs_logo.jpg' alt='C/S Logo'></td>");
	out.println("<td align='center' class='maintitle' width='20%' style='border:solid 1px #060'><b>QUOTATION</b></td>");
	%>
	</tr></table>
	<%
	}
%>
	<table cellspacing='0' cellpadding='0' border='0' width='100%'>
	<%
	out.println("<tr><td align='center' class='maintitle'><b>C/S CONSTRUCTION SPECIALTIES COMPANY</b>");
	out.println("<br><font class='subtitle'>");
	out.println("895 Lakefront Promenade, Mississauga, ON L5E 2C2</font>");
	out.println("<br><font class='subtitle'>Phone: 888-895-8955 Fax: 905-274-6241</font>");
	out.println("<br><font class='subtitle'>Website: www.c-sgroup.com</font>");
	%>
	</table>

<!-- end header -->
<table cellspacing='0' cellpadding='0' border='0' width='100%'>
<tr>
<td width='55%' valign='top' nowrap class='mainbody'>
<b>Customer:</b><BR>
<%
// only for internal quotes

//		HttpSession UserSession_rep = request.getSession();
//		String session_rep_no= UserSession_rep.getAttribute("rep_no").toString();
   if((group_id.toUpperCase().startsWith("REP") && project_type != null && project_type.equals("PSA"))){
   		String cust_name12="";String cust_addr12="";String cust_addr22="";String city2="";String state2="";String zip_code2="";String cust_contact_name2="";
		String cust_fax2="";String cust_phone2="";

					ccode=cust_no.substring(0,2);
				        if ((ccode.equals("GB"))|(ccode.equals("US"))) {cust_no=cust_no.substring(2);}
						else {ccode="US";}
						//out.println("SELECT * FROM cs_customers where cust_no like '"+cust_no+"' and country_code='"+ccode+"' ");
				 	ResultSet rs_customers = stmt.executeQuery("SELECT * FROM cs_customers where cust_no like '"+cust_no+"' and country_code='"+ccode+"' ");
			  		if (rs_customers !=null) {
			        while (rs_customers.next()) {
					cust_name12= rs_customers.getString("cust_name1");
					cust_addr12= rs_customers.getString("cust_addr1");
					cust_addr22= rs_customers.getString("cust_addr2");
					city2= rs_customers.getString("city");
					state2= rs_customers.getString("state");
					zip_code2= rs_customers.getString("zip_code");
					cust_phone2= rs_customers.getString("phone");
					cust_fax2= rs_customers.getString("fax");
//					cust_contact_name2= rs_customers.getString("contact_name");
				    }
				    }
				   rs_customers.close();

// writing the name

			if(cust_name12==null||cust_name12.equals("null")){cust_name1="";}
			if(cust_addr12==null||cust_addr12.equals("null")){cust_addr1="";}
			if(cust_addr22==null||cust_addr22.equals("null")){cust_addr2="";}
			if(cust_phone2==null||cust_phone2.equals("null")){cust_phone="";}
			if(cust_fax2==null||cust_fax2.equals("null")){cust_fax="";}

			if(cust_name12.trim().length()>0){out.println(cust_name12+"<br>");}
			if(cust_addr12 != null && cust_addr12.trim().length()>0){out.println(cust_addr12+"<br>");}
			if(cust_addr22 != null && cust_addr22.trim().length()>0){out.println(cust_addr22+"<br>");}
			if(city2==null){ city2="";}
			if(state2==null){ state2="";}
			if(zip_code2==null){ zip_code2="";}

			out.println(city2+",&nbsp;"+state2+"&nbsp;"+zip_code2+"&nbsp;<br>");
			if(cust_phone2 != null && cust_phone2.trim().length() >0){out.println("Phone: "+cust_phone2+"<br>");}
			if(cust_fax2 != null && cust_fax2.trim().length() > 0){out.println("Fax: "+cust_fax2+"<br>");}
			out.println("<b>Attention: </b>"+agent_name+"<br>");



   }

 //only for internal quotes done
//Getting the account info from PSA
String quoted_account="";String arch_acct_id="";String scan_no="";String cont_id=""; String alias="";
if(AcctID.trim().length()>0){
 	ResultSet rs_psa_account = stmt_psa.executeQuery("SELECT acctname,addr1,addr2,town,county,postcode,tel,fax,alias FROM dba.account where acct_id like '"+AcctID+"'");
  		if (rs_psa_account !=null) {
        	while (rs_psa_account.next()) {
					cust_name1= rs_psa_account.getString(1);
					cust_addr1= rs_psa_account.getString(2);
					cust_addr2= rs_psa_account.getString(3);
					city= rs_psa_account.getString(4);
					state= rs_psa_account.getString(5);
					zip_code= rs_psa_account.getString(6);
					cust_phone= rs_psa_account.getString(7);
					cust_fax= rs_psa_account.getString(8);
					alias= rs_psa_account.getString("alias");
			}
		}
		rs_psa_account.close();
	 	ResultSet rs_psa_quotes_issued = stmt_psa.executeQuery("SELECT * FROM dba.quotes_issued where quote_id like '"+QuoteID+"' and acct_id like '"+AcctID+"' ");
  		if (rs_psa_quotes_issued !=null) {
        	while (rs_psa_quotes_issued.next()) {
					cont_id= rs_psa_quotes_issued.getString(4);
					//out.println(cont_id+"::HERE<BR>");
			}
		}
		rs_psa_quotes_issued.close();
//		out.println("t"+cont_id);
		if (cont_id!=null){
		if(cont_id.trim().length()>0){
		 	ResultSet rs_psa_contact = stmt_psa.executeQuery("SELECT * FROM dba.contact where cont_id like '"+cont_id+"'");
	  		if (rs_psa_contact !=null) {
	        	while (rs_psa_contact.next()) {
						agent_name= rs_psa_contact.getString(4);
						agent_name=agent_name+" "+rs_psa_contact.getString(3);
						rep_email= rs_psa_contact.getString("e_mail");
						//out.println("t<BR><BR><BR"+rep_email);
				}
			}
			rs_psa_contact.close();
		}
		}else{agent_name="";rep_email="";}


}
//Gettig info for the project
	 	ResultSet rs_psa_project = stmt_psa.executeQuery("SELECT * FROM dba.project where project_id like '"+project_id+"'");
  		if (rs_psa_project !=null) {
        	while (rs_psa_project.next()) {
					Project_name=rs_psa_project.getString("project_title");
					project_city=rs_psa_project.getString("site_town");
					project_state=rs_psa_project.getString("site_county");
					scan_no=rs_psa_project.getString("provider_pl_id");
			}
		}
	if(project_city==null){project_city="";}	if(project_state==null){project_state="";}
//Getting proj_ac_link
	 	ResultSet rs_psa_proj_ac_link = stmt_psa.executeQuery("SELECT * FROM dba.proj_ac_link where project_id like '"+project_id+"' order by link_id");
  		if (rs_psa_proj_ac_link !=null) {
        	while (rs_psa_proj_ac_link.next()) {
					if(rs_psa_proj_ac_link.getString("role_type_id").equals("2")){arch_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");}
			}
		}
		rs_psa_proj_ac_link.close();
//Getting the arch Information
if(arch_acct_id.trim().length()>0){
 	ResultSet rs_psa_account = stmt_psa.executeQuery("SELECT acctname,addr2,town,county,postcode FROM dba.account where acct_id like '"+arch_acct_id+"'");
  		if (rs_psa_account !=null) {
        	while (rs_psa_account.next()) {
					Arch_name= rs_psa_account.getString(1);
					Arch_loc= rs_psa_account.getString(3);
					Arch_state= rs_psa_account.getString(4);
			}
		}
	rs_psa_account.close();
}

if(cust_name1==null){cust_name1="";}
if(cust_addr1==null){cust_addr1="";}
if(cust_addr2==null){cust_addr2="";}
if(cust_phone==null){cust_phone="";}
if(cust_fax==null){cust_fax="";}
if(! ((product.equals("LVR"))|(product.equals("BV"))|product.equals("ADS")|(product.equals("GRILLE"))|(product.equals("EJC"))|(product.equals("IWP"))|(product.equals("EJC"))|product.equals("GCP")|product.equals("EXP")) ){
		if(cust_name1.trim().length()>0){out.println(cust_name1+"<br>");}
		if(cust_addr1.trim().length()>0){out.println(cust_addr1+"<br>");}
		if(cust_addr2.trim().length()>0){out.println(cust_addr2+"<br>");}
		out.println(city+",&nbsp;"+state+"&nbsp; "+zip_code+"<br>");
		if(cust_phone != null && cust_phone.trim().length() >0){out.println("Phone: "+cust_phone+"<br>");}
		if(cust_fax != null && cust_fax.trim().length() > 0){out.println("Fax: "+cust_fax+"<br>");}
		if( !((product.equals("LVR"))|(product.equals("BV"))|(product.equals("GRILLE"))) ){
				out.println("<b>Attention: </b>"+agent_name+"<br>");
		}
}else{out.println("&nbsp;&nbsp;");}
 %>
</td>
<!--<td width='45%' valign='top' rowspan='3' class='mainbody'>&nbsp;</td>-->
<%
//out.println(product);
if( (product.equals("LVR"))|(product.equals("BV"))|(product.equals("GRILLE")) ){
			if(!(psa_quote_type==null)){
				if(psa_quote_type.trim().length()>0){
				 	ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT * FROM dba.user_lookup where lookup_id like '"+psa_quote_type.trim()+"'");
				  		if (rs_psa_lookup !=null) {
				        	while (rs_psa_lookup.next()) {
									psa_quote_type= rs_psa_lookup.getString(3);
							}
						}
					rs_psa_lookup.close();
				}
			}else{psa_quote_type="";}
			if(!(psa_type_of_quote==null)){
				if(psa_type_of_quote.trim().length()>0){
				 	ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT * FROM dba.user_lookup where lookup_id like '"+psa_type_of_quote.trim()+"'");
				  		if (rs_psa_lookup !=null) {
				        	while (rs_psa_lookup.next()) {
									psa_type_of_quote= rs_psa_lookup.getString(3);
							}
						}
					rs_psa_lookup.close();
				}
			}else{psa_type_of_quote="";}

 %>
	<td width='15%' valign='top' align='left' nowrap class='mainbody'><b>Quote No:</b><br><b>Erapid No:</b><br><b>Quote Date:</b><BR><b>Scan:</b></td>
	<td width='30%' valign='top' nowrap class='mainbody'><%= psa_quote_type %><%= QuoteID %><br><%= order_no %>(<%= psa_type_of_quote %>)<br><%= odate %><BR><%= scan_no %></td>
<%}else if((product.equals("GE")|product.equals("APC")|group_id.startsWith("Decolink"))){
 %>
 	<td width='15%' valign='top' align='left' nowrap class='mainbody'><b>Quote No:</b></td>
	<td width='30%' valign='top' nowrap class='mainbody'><%= order_no %></td>
<%
}
else{
if(alias == null || alias.equals("null")){
	alias="";
}
%>
		<td valign='top' align='left' nowrap class='mainbody'><b>Quote No:</b><br><b>Quote Date:</b></td>
		<td valign='top' nowrap class='mainbody'><%= order_no %>
		<%if(alias != null &&!alias.equals("null")&&alias.trim().length()>0){%>
		(<%= alias %>)
		<%}%>
		<BR><%= odate %></td>
	<%

}
%>
</tr>
<%

if( !(product.equals("GE")|product.equals("APC")|(product.equals("LVR"))|(product.equals("BV"))|(product.equals("GRILLE"))|(group_id.startsWith("Decolink")|(group_id.toUpperCase().startsWith("CAN")))) ){ %>
<tr>
<td  valign='top' nowrap class='mainbody'>
	<td  valign='top' align='left' nowrap class='mainbody'><b>Bid Date:</b></td>
	<td  valign='top' nowrap class='mainbody'><%= edate %></td>
</tr>
<%
}
%>
</table>
<br>
<table cellspacing='0' cellpadding='0' border='0' width='100%'>

	<tr>

		<%
		if((product.equals("LVR"))|(product.equals("BV"))|(product.equals("GRILLE"))|(product.equals("ADS")) ){
			%>
			<td nowrap valign='top' align='left' class='mainbodyh' width='10%'><b>Project:</b>&nbsp;<BR><BR>&nbsp;<BR>&nbsp;<BR><b>Architect:</b>&nbsp;<BR><BR><b>Location:</b>&nbsp;<BR></td>
			<%
			out.println("<td width='30%' nowrap valign='top' class='mainbody'><b>"+Project_name+"<br>"+project_city+",&nbsp;"+project_state+"<br><BR>"+Arch_name+"<br><br>"+Arch_loc+",&nbsp;"+Arch_state+" </td>");
		}
		else{
			%>
			<td nowrap valign='top' align='left' class='mainbodyh' width='10%'><b>Project:</b>&nbsp;</td>
			<%
			if(product.equals("GCP")){
				out.println("<td width='30%' nowrap valign='top' class='mainbody'>"+Project_name+"<br>"+project_city+"&nbsp;&nbsp;"+project_state+"<br>"+psa_quote_desc+"</td>");
			} else {
				out.println("<td width='30%' nowrap valign='top' class='mainbody'>"+Project_name+"<br>"+project_city+"&nbsp;&nbsp;"+project_state+"</td>");
			}
		}
		 %>
		<!--td width='15%' rowspan='1'>&nbsp;</td>-->
		<td valign='top' width='45%' rowspan='3' align='left' nowrap class='mainbody'>
		<%
		if(rep_account==null){rep_account="";}
		if(rep_city==null){rep_city="";}
		if(rep_state==null){rep_state="";}
		if(rep_zip_code==null){rep_zip_code="";}
		if(city==null||city.equals("null")){city="";}
		if(state==null||state.equals("null")){state="";}
		if(zip_code==null||zip_code.equals("null")){zip_code="";}
		if(rep_telephone==null){rep_telephone="";}
		if(rep_fax==null){rep_fax="";}
		if(rep_email==null){rep_email="";}
		if(rep_name==null){rep_name="";}
		out.println("<b>C/S Representative:</b><br>");
		if(rep_name.trim().length()>0){
			out.println("<B>"+rep_name +"</b><br>");
		}
		if(rep_telephone.trim().length()>0){
			out.println("<b>Phone:</b>"+rep_telephone +"<br>");
		}
		if(rep_fax.trim().length()>0){
			out.println("<b>Fax No:</b>"+rep_fax +"<br>");
		}
		if(rep_email2.trim().length()>0){
			out.println("<b>e-mail:</b> "+ rep_email2 +"<br>");
		}
		out.println("<br><b>C/S Estimator: </b>"+estimator+"<BR>");


		%>
		</td>
	</tr>


	<tr>
		<td  nowrap valign='top' align='left' class='mainbodyh'><b>Architect:</b>&nbsp;</td>
		<td  valign='top' class='mainbody'><%= Arch_name %> </td>
		<!--<td ></td>-->
	</tr>
	<tr>
		<td  nowrap valign='top' align='left' class='mainbodyh'><b>Location:</b>&nbsp;</td>
		<td  valign='top' class='mainbody'><%= Arch_loc %>&nbsp;,<%= Arch_state %></td>

	</tr>

</table>

<%
//out.println(group_id);
if( !group_id.startsWith("Internatio")&&(product.equals("IWP")) ){
	//out.println(spec_level+":::HERE");
	String spec_temp="";
	if(!(spec_level==null)){
		if(spec_level.trim().length()>0){
			ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT * FROM dba.user_lookup where lookup_id like '"+spec_level.trim()+"'");
			if (rs_psa_lookup !=null) {
				while (rs_psa_lookup.next()) {
					spec_temp= rs_psa_lookup.getString(3);
				}
			}
			rs_psa_lookup.close();
			if(product.equals("IWP")){
				if(spec_temp.indexOf("=")>0){
					spec_temp=spec_temp.substring(spec_temp.indexOf("=")+1,spec_temp.length());
				}
				else{
					spec_temp=spec_temp.substring(4,spec_temp.length());
				}
			}
			else{
				spec_temp=spec_temp.substring(spec_temp.indexOf("=")+1,spec_temp.length());
			}

		}

	}
	else{
		spec_temp="";
	}
	%>
	<table cellspacing='0' cellpadding='0' border='0' width='100%'>
	<tr><td nowrap valign='top' class='mainbodyh'><b>Spec Level:</b>&nbsp;</td>
	<td nowrap valign='top' class='mainbodyh'><%=spec_temp %>&nbsp;</td>
	<td nowrap width='100%' class='mainbodyh'>&nbsp;</td>

	</tr>
	</table>
	<%
}

%>
<hr>
<table  width='100%' align='center' cellspacing='0' cellpadding='0' border='0'>
<tr><td class='mainbodyh'>
<%
if(type.equals("3")){
	out.println("<BR>We propose to provide the following C/S Products at the price quoted and in accordance with the terms and conditions herein.  Such terms and conditions shall form part of any ensuing purchase agreement:  <b> All PO's are to be made out to C/S Construction Specialties Company without exception.  <B>");
}
else{
	out.println("<BR>We propose to provide the following C/S Products at the price quoted and in accordance with the terms and conditions herein.  Such terms and conditions shall form part of any ensuing purchase agreement:  <b> All PO's are to be made out to C/S Construction Specialties Company without exception.  <B>");
}
%>
</td></tr></table>

<%
if(! ((psa_spec_section==null)||((psa_spec_section.trim()).length()<0)) )  {
	out.println("<table border='1' width='100%' class='table_thin_borders' style='border-collapse: collapse;' cellspacing='0' cellpadding='3'>");
	out.println("<tr><td class='mainbodyh' width='20%'><b>Spec Section:</b></td>");
	out.println("<td class='mainbodyh' align='left'>&nbsp;"+psa_spec_section+"</td></tr>");
	out.println("</table>");
}
%><br>