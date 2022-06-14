

<!-- header -->
<table cellspacing='0' cellpadding='0' border='0' width='100%'>
<tr>
<%
if ( (product.equals("GE")) ){
	out.println("<td align='left'><img src='http://csimages.c-sgroup.com/eRapid/ge_logo.jpg' alt></td>");
}

else {
	out.println("<td align='left'><img src='http://csimages.c-sgroup.com/eRapid/cs_logo.jpg' alt='CS Logo'></td>");

}
%>
</tr>
<%
if ( (doc_priority.equals("E")) ||doc_type_alt.equals("dl")){
	if(session_group_id.startsWith("Decolink")||doc_type_alt.equals("dl")){ 
		out.println("<tr><td align='center' class='maintitle'><b>CS Senior Living</b>");
		//out.println("<br><font class='subtitle'>Formerly DecoLink Division<br>");
		out.println("225 Regency Court<br>Brookfield, WI 53045<br>Phone: 888.331.2031<br>");
	}else{
		out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b><BR>");
		out.println("P.O. Box 380<br>Muncy, PA 17756");
	}
	out.println("</font></td></tr>");
}
else{
	if(session_group_id.startsWith("Decolink")||doc_type_alt.equals("dl")){
		out.println("<tr><td align='center' class='maintitle'><b>CS Senior Living</b>");
		//out.println("<br><font class='subtitle'>CS ElderCare Interiors Division<br>");
		out.println("225 Regency Court<br>Brookfield, WI 53045<br>Phone: 888.331.2031<br>");
	}else if(isInternational) {
		out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
		out.println("<br><font class='subtitle'>");
		out.println("3 Werner Way<br>Lebanon, NJ 08833");
	}
	else{
		if(product.equals("GCP")){
			out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
			out.println("<br><font class='subtitle'>CS Cubicle Curtains Division<br>");
			out.println("3 Werner Way <br>Lebanon, NJ 08833<br>");
		}
		else if(product.endsWith("LVR")||product.equals("APC")){
			out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
			out.println("<br><font class='subtitle'>");
			out.println("3 Werner Way <br>Lebanon, NJ 08833");
		}
		else if(product.endsWith("GE")) {
			out.println("<tr><td align='center' class='maintitle'><b>GRAND ENTRANCE</b>");
			out.println("<br><font class='subtitle'>A Division of Construction Specialties, Inc.<br>");
			out.println("4005 Royal Drive Ste 100<br>Kennesaw, GA 30144<br>Phone No: 888.331.2031 <br>");
		}
		else{
			out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
			out.println("<br><font class='subtitle'>");
			out.println("P.O. Box 380<br>Muncy, PA 17756");
		}
	}
		out.println("</font></td></tr>");

}

 %>



</table>
<!-- end header -->
<table cellspacing='0' cellpadding='0' border='0' width='100%'>
<tr>
<td width='55%' valign='top' rowspan='3' nowrap class='mainbody'>
<%
if(cust_name1==null){cust_name1="";}
if(cust_addr1==null){cust_addr1="";}
if(cust_addr2==null){cust_addr2="";} 
if(cust_phone==null){cust_phone="";}
if(cust_fax==null){cust_fax="";}
if(cust_name1.trim().length()>0){out.println(cust_name1+"<br>");}
if(cust_addr1.trim().length()>0){out.println(cust_addr1+"<br>");}
if(cust_addr2.trim().length()>0){out.println(cust_addr2+"<br>");}
%>
<%= city %>,&nbsp;<%= state %>&nbsp;<%= zip_code %>&nbsp;<br>
<%	if(cust_phone != null && cust_phone.trim().length() >0){
		out.println("Phone: "+cust_phone+"<br>");
	}
	if(cust_fax != null && cust_fax.trim().length() > 0){
		out.println("Fax: "+cust_fax+"<br>");
	}

 %>


<b>Attention: </b><%= agent_name %>
</td>

<td width='15%' valign='top' align='LEFT' class='mainbody'><B>Job No:</b><br><b>CS PCO# No:</b><BR><b>Cust PO#: </b><BR><b>Quote Date: </b></td>
<td width='30%' valign='top' class='mainbody'><%out.println("&nbsp;&nbsp; "+bpcs_order_no); %><br><%out.println("&nbsp;&nbsp; "+order_no); %><br><%out.println("&nbsp;&nbsp; "+cust_po );%><br><%out.println("&nbsp;&nbsp; "+odate); %></td>
</tr>
</table>
<br>
<table cellspacing='0' cellpadding='0' border='0' width='100%'>
<tr><td nowrap valign='top' width='15%' class='mainbody'><b>Project:
<%
if( !(product.equals("GE")) ){ %>
<br><br><br>
<b>Architect:</b>&nbsp;
<%
}
%>

</b>&nbsp;</td>
<td width='40%' nowrap valign='top' class='mainbody'><%= Project_name %><br>
<%
if(project_city!=null&project_state!=null&project_state.trim().length()>0&project_city.trim().length()>0){
	if(project_city.startsWith("null")){project_city="";}
	if(project_state.startsWith("null")){project_state="";}
	if(project_state.trim().length()>0&project_city.trim().length()>0){
		out.println(project_city+",  "+project_state);
	}else{out.println(project_city+project_state+"");}	
		
}else{out.println(project_city+project_state+"");}
if( !(product.equals("GE")) ){ %>

<BR><%= Arch_name %>
<%
}
%>
</td>
<td valign='top' width='45%' nowrap class='mainbody'><b>Customer Service Representative:</b><br>
<%
if(rep_account==null){rep_account="";}
if(rep_city==null){rep_city="";}
if(rep_state==null){rep_state="";}
if(rep_zip_code==null){rep_zip_code="";}
if(rep_telephone==null){rep_telephone="";}
if(rep_fax==null){rep_fax="";}
if(rep_email==null){rep_email="";}
if(rep_name==null){rep_name="";}
if(!(product.equals("GE"))){
	if(!(session_group_id.startsWith("Decolink")||doc_type_alt.trim().equals("dl"))){
		%>

		<%= rep_account %><br>
		<%

		if(address1==null||address1.trim().length()<1){address1="";}
		else{out.println(address1+"<br>");}
		if(address2==null||address2.trim().length()<1){address2="";}
		else{out.println(address2+"<br>");}
		if(rep_city.trim().length()>0){
		out.println(rep_city.trim()+", ");
		}
		%>
		<%= rep_state %>&nbsp;<%= rep_zip_code %><br>
		<%
	}
	else{
		if(rep_name.trim().length()>0){
			out.println("<B>"+rep_name +"</b><br>");
	
		}
	}
%>

<b>Phone:</b> <%= rep_telephone %><br>
<b>Fax No:</b> <%= rep_fax %><br>
<%}
%>
<b>e-mail:</b> <%= rep_email %>


</td>
</tr>

</table>

<center>
<FONT SIZE='3'><B>PROPOSED CHANGE ORDER NOTIFICATION</B></FONT>
</center>
<hr>