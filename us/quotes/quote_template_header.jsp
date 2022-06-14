<%                String action=request.getParameter("action");
                if(action==null){
                    action="";
                }
if(action.equals("rtf")||action.equals("pdf")){
%>
<link rel='stylesheet' href='../../css/quotes2.css' type='text/css' />
<%
//repAddress=repAddress.replaceAll("Prepared","&nbsp;<BR>&nbsp;<br>Prepared");
}
else{
%>
<link rel='stylesheet' href='../../css/quotes.css' type='text/css' />
<%
}
%>

<!-- header -->
<%
if(pdf==null ||  !pdf.toUpperCase().equals("TRUE")){
%>
<table cellspacing='0' cellpadding='0' border='0' width='100%'>
	<tr>
		<%
		if ( (product.equals("GE")) ){
			//out.println("<td align='left'><img src='http://csimages.c-sgroup.com/eRapid/impact_logo.png' width='150' alt></td>");
			out.println("<td align='left'><img src='../../images/impact_logo.png' width='200' alt></td>");
		}
		else if ( (product.equals("ELM")) ){
			out.println("<td align='left'><img src='http://csimages.c-sgroup.com/eRapid/Logo-CF.jpg' width='150' alt></td>");
		}
		else {
			out.println("<td align='left'><img src='http://csimages.c-sgroup.com/eRapid/cs_logo.jpg' alt='CS Logo'></td>");

		}
		%>
	</tr></table>

<%
}

%>
<!-- end header -->
<table cellspacing='0' cellpadding='0' border='0' width='100%'>
	<%
	//out.println(doc_priority+"::<BR>");
	if ( (doc_priority.equals("E"))||(doc_priority.equals("D") )||doc_type_alt.equals("dl")){
		if(session_group_id.startsWith("Decolink")||doc_type_alt.equals("dl")||(doc_priority.equals("D")) ){
			out.println("<tr><td align='center' class='maintitle'><b>CS Senior Living</b><BR>");
			//out.println("<br><font class='subtitle'>Formerly DecoLink Division<br>");
			//out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
			//out.println("<br><font class='subtitle'>CS ElderCare Interiors Division<br>");
			out.println("225 Regency Court<br>Brookfield, WI 53045<br>Tel: 888.331.2031<br>");
		}else{
			out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b><BR>");
			out.println("P.O. Box 380<br>Muncy, PA 17756");
		}
		out.println("</font></td></tr>");
	}
	else{
		if(session_group_id.startsWith("Decolink")||doc_type_alt.equals("dl")){
			//out.println("<tr><td align='center' class='maintitle'><b>CS Eldercare Interiors</b>");
			//out.println("<br><font class='subtitle'>Formerly DecoLink Division<br>");
			out.println("<tr><td align='center' class='maintitle'><b>CS Senior Living</b><BR>");
			//out.println("<br><font class='subtitle'>CS ElderCare Interiors Division<br>");
			out.println("225 Regency Court<br>Brookfield, WI 53045<br>Tel: 888.331.2031<br>");
		}else if(isInternational) {
			out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
			out.println("<br><font class='subtitle'>");
			out.println("3 Werner Way<br>Lebanon, NJ 08833");
		}
		else{
			if(product.equals("GCP")){
				out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
				out.println("<br><font class='subtitle'>CS Cubicle Curtains Division<br>");
				out.println("3 Werner Way<br>");
				out.println("Lebanon, NJ 08833<br>&nbsp;");
			}
			else if(product.endsWith("LVR")||product.equals("GRILLE")||product.equals("APC")){
				out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
				out.println("<br><font class='subtitle'>");
				out.println("3 Werner Way <br>Lebanon, NJ 08833");
			}
			else if(product.endsWith("GE")) {
				out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES</b>");
				out.println("<br><font class='subtitle'>National Accounts<br>");
				out.println("4005 Royal Drive Ste 100<br>Kennesaw, GA 30144<br>Tel: 888.331.2031 <br>");
			}
			else if(product.endsWith("ELM")) {
				out.println("<tr><td align='center' class='maintitle'><b>Elementz Commercial Flooring</b>");
				out.println("<br><font class='subtitle'>A Division of Construction Specialties, Inc.<br>");
				out.println("4005 Royal Drive Suite 300<br>Kennesaw, GA 30144<br>Tel: 888.331.2031 <br>");
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

<table cellspacing='0' cellpadding='0' border='0' width='100%'>
	<tr>
	<td>&nbsp;&nbsp;</td>
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
			if(null==city || city.trim().equalsIgnoreCase("null")){
				city = "";
			}
			if(null==state || state.trim().equalsIgnoreCase("null")){
				state = "";
			}
			if(null==zip_code || zip_code.trim().equalsIgnoreCase("null")){
				zip_code = "";
			}

			%>
			<%= city %>&nbsp;<%= state %>&nbsp;<%= zip_code %>&nbsp;<br>
			
			<%	if(cust_phone != null && cust_phone.trim().length() >0){
					out.println("Phone: "+cust_phone+"<br>");
				}
				if(cust_fax != null && cust_fax.trim().length() > 0){
					out.println("Fax: "+cust_fax+"<br>");
				}
//if(cust_contact_name.trim().length()>0){out.println("<b>Attention:</b> "+cust_contact_name+"<br>");}
if(agent_name != null && agent_name.trim().length()>0){
			%>


			<b>Attention: </b><%= agent_name %>
			<%
}
			%>
		</td>
		<%
		if( !(product.equals("ELM")) ){
		%>
		<!--<td  valign='top' rowspan='3' class='mainbody'>&nbsp;</td>-->
		<td width='15%' valign='top' align='LEFT' class='mainbody'><b>Quote No:</b><BR><b>Quote Date: </b><BR><b>Bid Date: </b></td>
					<td width='30%' valign='top' class='mainbody'><%out.println("&nbsp;&nbsp; "+order_no); %><br><%out.println("&nbsp;&nbsp; "+odate); %><br><%out.println("&nbsp;&nbsp; "+edate );%></td>
					</tr>
					<%
				}
				else{
					%>
					<!--<td  valign='top' rowspan='3' class='mainbody'>&nbsp;</td>-->
					<td width='15%' valign='top' align='LEFT' class='mainbody'><b>Quote No:<b><BR><b>Quote Date: </b><BR><b>Customer No: </b></td>
								<td width='30%' valign='top' class='mainbody'><%out.println("&nbsp;&nbsp; "+order_no); %><br><%out.println("&nbsp;&nbsp; "+odate); %><br><%out.println("&nbsp;&nbsp; "+bpcs_cust_no );%></td>
								</tr>
								<%
							}
								%>
								<!--
								<tr>
									<td width='200' valign='top' align='right' nowrap class='mainbody'><b>Quote Date: </b></td>
									<td width='100' valign='top' nowrap class='mainbody'><%out.println("&nbsp;&nbsp; "+odate); %></td>
								</tr>
								<%
								if( !(product.equals("GE") || product.equals("ELM")) ){
								%>
								<tr>
									<td width='200' valign='top' align='right' nowrap class='mainbody'><b>Bid Date: </b></td>
									<td width='100' valign='top' nowrap class='mainbody'><%out.println("&nbsp;&nbsp; "+edate );%></td>
								</tr>
								<%
							}
								%>
								-->
								</table>
								<br>
								<table cellspacing='0' cellpadding='0' border='0' width='100%'>
									<tr><td>&nbsp;&nbsp;</td>
									<td nowrap valign='top' width='15%' class='mainbody'><b>Project:
												<%
if( !(product.equals("GE")) ){ %>
												<br><br><br>
												<b>Architect:</b>&nbsp;
												<%
												}
												%>

											</b>&nbsp;</td>
										<td width='40%'  valign='top' class='mainbody'><%= Project_name %><br>
											<%
											if(project_city!=null&project_state!=null&project_state.trim().length()>0&project_city.trim().length()>0){
												if(project_city.startsWith("null")){project_city="";}
												if(project_state.startsWith("null")){project_state="";}
												if(project_state.trim().length()>0&project_city.trim().length()>0){
													out.println(project_city+",  "+project_state);
												}else{out.println(project_city+project_state+"");}

											}else{out.println(project_city+project_state+"");}
											if( !(product.equals("GE")) ){ %>

											<BR><br><%= Arch_name %>
											<%
											}
											%>
										</td>
										<%
										if(!product.endsWith("ELM")) {
										%>
										<!--<td width='500' rowspan='3'>&nbsp;</td>-->
										<td valign='top' width='45%' nowrap class='mainbody'><b>CS Representative:</b><br>
											<%
											if(rep_account==null){rep_account="";}
											if(rep_city==null){rep_city="";}
											if(rep_state==null){rep_state="";}
											if(rep_zip_code==null){rep_zip_code="";}
											if(rep_telephone==null){rep_telephone="";}
											if(rep_fax==null){rep_fax="";}
											if(rep_email==null){rep_email="";}
											if(rep_name==null){rep_name="";}
											//out.println(session_group_id+"::"+doc_type_alt);
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
										//out.println("HERE2");
											if(rep_name.trim().length()>0){
												out.println("<B>"+rep_name +"</b><br>");

											}
										}
											%>

											
											<b>Phone:</b> <%= rep_telephone %><br>
											
											
											<!--	<b>Fax No:</b> <%= rep_fax %><br> -->
											
											<%}
											%>
											<b>e-mail:</b> <%= rep_email %>

											<%
										}
										else{
											%>
										<td valign='top' width='45%' nowrap class='mainbody'><b>Prepared by:</b><%=prepared_by%><br>
											<b>e-mail:</b><%=prepared_by_email%></td>
											<%
										}
										if (product.equals("GE")) {
											//out.println("here<BR>");
											if(rep_name.trim().length()>0){
												out.println("<BR>Rep Name: "+rep_name +"<br>");

											}
										}
											%>

										</td>
									</tr>

									<%
									/*
									if( !(product.equals("GE")) ){ %>
									<tr>
										<td valign='bottom' class='mainbodyh'><b>Architect:</b>&nbsp;</td>
										<td valign='bottom' class='mainbody'><%= Arch_name %> </td>
										<!--<td >&nbsp;</td>-->
									</tr>
									<!--<tr><td valign='top' class='mainbodyh'><b>Location:</b>&nbsp;</td>//commented out from Gord's comment on June 27'06-->
									<tr><td valign='top' class='mainbodyh'>&nbsp;</td>
										<td valign='top' class='mainbody'><%= Arch_loc %></td>
										<!--<td >&nbsp;</td>-->
									</tr>
									<%
									}
									*/
									%>
								</table>
								<hr>