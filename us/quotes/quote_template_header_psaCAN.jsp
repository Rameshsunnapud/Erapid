
<html>
<head>
<title><%= Project_name %> --- Quote:: <%= order_no %></title>
<link rel='stylesheet' href='quotes.css' type='text/css' /></head>
<body bgcolor="white" topmargin="25" leftmargin="25" bgcolor="white" marginheight="0" marginwidth="0">
<table cellspacing='0' cellpadding='0' border='0' width='100%'>
<tr>
<%
String pdf=request.getParameter("pdf");
if(pdf==null ||  !pdf.toUpperCase().equals("TRUE")){


	out.println("<td align='left'><img src='http://csimages.c-sgroup.com/eRapid/cs_logo.jpg' width='138' height='16' alt></td>");

%>
	</tr></table>

	<%
}
%>
<table cellspacing='0' cellpadding='0' border='0' width='100%'>
<%
		out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, CO</b>");
		out.println("<br><font class='subtitle'>");
		out.println("2240 Argentia Rd.<br>Suite 102 Mississauga, Ontario L5N 2K7");

		out.println("</font></td></tr>");

 %>
</table>
<table cellspacing='0' cellpadding='0' border='0' width='100%'>
<tr>
<td width='65%' valign='top' rowspan='3 nowrap class='mainbody'>
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
//						out.println("t"+rep_email);
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
<td width='75%' valign='top' rowspan='3' class='mainbody'>&nbsp;</td>
<%
if( (product.equals("LVR"))|(product.equals("BV"))|(product.equals("GRILLE")|product.equals("ADS")) ){
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
	<td width='200' valign='top' align='left' nowrap class='mainbody'><b>Quote No:</b><br><b>Erapid No:</b><br><b>Scan:</b></td>
	<td width='125' valign='top' nowrap class='mainbody'><%= psa_quote_type %><%= QuoteID %><br><%= order_no %>(<%= psa_type_of_quote %>)<br><%= scan_no %></td>
<%}else if((product.equals("GE")|product.equals("APC")|group_id.startsWith("Decolink"))){
 %>
 	<td width='200' valign='top' align='left' nowrap class='mainbody'><b>Quote No:</b></td>
	<td width='125' valign='top' nowrap class='mainbody'><%= order_no %></td>
<%
}
else{
if(alias == null || alias.equals("null")){
	alias="";
}
 %>
 	<td width='200' valign='top' align='left' nowrap class='mainbody'><b>Quote No:</b><br><b>Scan:</b></td>
	<td width='125' valign='top' nowrap class='mainbody'><%= order_no %> (<%= alias %>)<br><%= scan_no %></td>
<%
}
%>
</tr>
<tr>
 	<td width='200' valign='top' align='left' nowrap class='mainbody'><b>Quote Date:</b></td>
	<td width='125' valign='top' nowrap class='mainbody'><%= odate %></td>
</tr>
<%if( !(product.equals("GE")|product.equals("APC")|(product.equals("LVR"))|(product.equals("BV"))|(product.equals("GRILLE"))|(group_id.startsWith("Decolink"))) ){ %>
<tr>
	<td width='225' valign='top' align='left' nowrap class='mainbody'><b>Bid Date:</b></td>
	<td width='100' valign='top' nowrap class='mainbody'><%= edate %></td>
</tr>
<%
}
%>
</table>
<br>
<table cellspacing='0' cellpadding='0' border='0' width='100%'>
<tr><td nowrap valign='top' class='mainbodyh'><b>Project:</b>&nbsp;</td>
<%
if( (product.equals("LVR"))|(product.equals("BV"))|(product.equals("GRILLE")) ){
out.println("<td width='150' nowrap valign='top' class='mainbody'><b>"+Project_name+"<br>"+project_city+"&nbsp;&nbsp;"+project_state+" </td>");
}
else{
out.println("<td width='150' nowrap valign='top' class='mainbody'>"+Project_name+"<br>"+project_city+"&nbsp;&nbsp;"+project_state+"</td>");
}
 %>
<td width='88%' rowspan='3'>&nbsp;</td>
<td valign='top' width='300' rowspan='3' align='left' nowrap class='mainbody'>
<%
if(rep_account==null){rep_account="";}
if(rep_city==null){rep_city="";}
if(rep_state==null){rep_state="";}
if(rep_zip_code==null){rep_zip_code="";}
if(rep_telephone==null){rep_telephone="";}
if(rep_fax==null){rep_fax="";}
if(rep_email==null){rep_email="";}
if(rep_name==null){rep_name="";}
if( ((product.equals("LVR"))|(product.equals("BV"))|product.equals("ADS")|(product.equals("GRILLE"))|(product.equals("EJC"))|(product.equals("IWP"))|(product.equals("EJC"))|product.equals("GCP")|product.equals("EXP")) ){
		out.println("<b>Representative:</b><br>");
		if(cust_name1.trim().length()>0){out.println(cust_name1+"<br>");}
		if(cust_addr1.trim().length()>0){out.println(cust_addr1+"<br>");}
		if(cust_addr2.trim().length()>0){out.println(cust_addr2+"<br>");}
		out.println(city+",&nbsp;"+state+"&nbsp; "+zip_code+"<br>");
		if(cust_phone != null && cust_phone.trim().length() >0){out.println("Phone: "+cust_phone+"<br>");}
		if(cust_fax != null && cust_fax.trim().length() > 0){out.println("Fax: "+cust_fax+"<br>");}
		if (product.equals("IWP")){if(rep_email.trim().length()>0){out.println("e-mail:"+rep_email+"<br>");}}
}
else if(product.equals("GE")){
		if(rep_name.trim().length()>0){	out.println("Prepared by: "+rep_name +"<br>");}
		out.println("e-mail:"+rep_email+"<br>");
}
else if(product.equals("APC")){
/*
	out.println("<td valign='top' width='300' rowspan='3' nowrap class='mainbody'><b>CS Representative:</b><br>");
	out.println("<b>e-mail:</b> "+ rep_email +"<br>");
	if(rep_name.trim().length()>0){
		out.println("Rep Name: "+rep_name +"<br>");

	}

	*/
}
else{
		out.println(rep_account+"<br>");
		if(address1==null){address1="";}else{out.println(address1+"<br>");}
		if(address2==null){address2="";}else{out.println(address2+"<br>");}
		out.println(rep_city+",&nbsp;"+rep_state+"&nbsp; "+rep_zip_code+"<br>");
		out.println("Phone #:"+rep_telephone+"<br>");
		out.println("Fax No#:"+rep_fax+"<br>");
		out.println("&nbsp;&nbsp;");
}
%>

</td>
</tr>
<%if( !((product.equals("GE"))|(product.equals("APC"))|(product.equals("LVR"))|(product.equals("BV"))|(product.equals("GRILLE"))  ) ){ %>
<tr>
<td valign='top' class='mainbodyh'><b>Architect:</b>&nbsp;</td>
<td width='200' valign='top' class='mainbody'><%= Arch_name %> </td>
<td width='100%'></td>
</tr>
<tr><td valign='top' class='mainbodyh'><b>Location:</b>&nbsp;</td>
<td width='200' valign='top' class='mainbody'><%= Arch_loc %>&nbsp;<%= Arch_state %></td>
<td width='100%'></td>
</tr>
<%
}
else if( (product.equals("LVR"))|(product.equals("BV"))|(product.equals("GRILLE")) ){
%>
<tr>
<td valign='top' class='mainbodyh'><b>Architect:</b>&nbsp;</td>
<td width='200' valign='top' class='mainbody'><b><%= Arch_name %></b> </td>
<td width='100%'></td>
</tr>
<tr><td valign='top' class='mainbodyh'><b>Location:</b>&nbsp;</td>
<td width='200' valign='top' class='mainbody'><b><%= Arch_loc %>&nbsp;<%= Arch_state %></b></td>
<td width='100%'></td>
</tr>
<%
}

%>
</table>
<%
if( (product.equals("IWP")) ){
			if(!(spec_level==null)){
				if(spec_level.trim().length()>0){
				 	ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT * FROM dba.user_lookup where lookup_id like '"+spec_level.trim()+"'");
				  		if (rs_psa_lookup !=null) {
				        	while (rs_psa_lookup.next()) {
				        		spec_level= rs_psa_lookup.getString(3);
							}
						}
					rs_psa_lookup.close();
					spec_level=spec_level.substring(4,spec_level.length());
				}
			}else{spec_level="";}
			%>
<table cellspacing='0' cellpadding='0' border='0' width='100%'>
<tr><td nowrap valign='top' class='mainbodyh'><b>Spec Level:</b>&nbsp;</td>
	<td nowrap valign='top' class='mainbodyh'><%=spec_level %>&nbsp;</td>
	<td nowrap width='100%' class='mainbodyh'>&nbsp;</td>

</tr>
</table>
<%
} %>
<br>