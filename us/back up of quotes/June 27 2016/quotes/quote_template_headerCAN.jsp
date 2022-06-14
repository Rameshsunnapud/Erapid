
<html>
	<head>
		<title>Quote No <%= order_no %></title>
		<link rel='stylesheet' href='quotes.css' type='text/css' /></head>
	<body bgcolor="white" topmargin="25" leftmargin="25" bgcolor="white" marginheight="0" marginwidth="0">
		<table cellspacing='0' cellpadding='0' border='0' width='100%'>
			<tr>
				<%

					out.println("<td align='left'><img src='http://csimages.c-sgroup.com/eRapid/cs_logo.jpg' width='138' height='16' alt></td>");

				%>
			</tr>
			<%

					out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
					out.println("<br><font class='subtitle'>");
					out.println("895 Lakefront Prom.<br>Mississauga, ON L5E 2C2");

					out.println("</font></td></tr>");


			%>
		</table>
		<table cellspacing='0' cellpadding='0' border='0' width='100%'>
			<tr>
				<td width='45%' valign='top' rowspan='3' nowrap class='mainbody'>
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


					<b>Attention: </b><%= agent_name %><br>
				</td>
				<td width='35%' valign='top' rowspan='3' class='mainbody'>&nbsp;</td>
				<td width='10%' valign='top' align='right' class='mainbody'><b>Quote No:<b></td>
							<td width='10%' valign='top' class='mainbody'><%out.println("&nbsp;&nbsp; "+order_no); %></td>
							</tr>
							<tr>
								<td width='200' valign='top' align='right' nowrap class='mainbody'><b>Quote Date: </b></td>
								<td width='100' valign='top' nowrap class='mainbody'><%out.println("&nbsp;&nbsp; "+odate); %></td>
							</tr>
							<%if( !(product.equals("GE")) ){ %>
							<tr>
								<td width='200' valign='top' align='right' nowrap class='mainbody'><b>Bid Date: </b></td>
								<td width='100' valign='top' nowrap class='mainbody'><%out.println("&nbsp;&nbsp; "+edate );%></td>
							</tr>
							<%
							}
							%>
							</table>
							<br>
							<table cellspacing='0' cellpadding='0' border='0' width='100%'>
								<tr><td nowrap valign='top' class='mainbodyh'><b>Project:</b>&nbsp;</td>
									<td width='200' nowrap valign='top' class='mainbody'><%= Project_name %><br>
										<%
										if(project_city!=null&project_state!=null&project_state.trim().length()>0&project_city.trim().length()>0){
										out.println(project_city+",  "+project_state);
										}else{out.println(project_city+project_state+"");}
										%>
									</td>
									<td width='100%' rowspan='3'>&nbsp;</td>
									<td valign='top' width='300' rowspan='3' nowrap class='mainbody'><b>CS Representative:</b><br>
										<%
										if(rep_account==null){rep_account="";}
											if(rep_name==null){rep_name="";}
										if(rep_city==null){rep_city="";}
										if(rep_state==null){rep_state="";}
										if(rep_zip_code==null){rep_zip_code="";}
										if(rep_telephone==null){rep_telephone="";}
										if(rep_fax==null){rep_fax="";}
										if(rep_email==null){rep_email="";}
										if(rep_name==null){rep_name="";}
										if(!(product.equals("GE"))){
										%>

										<%= rep_account %><br>
										<%= rep_name %><br>
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
										<b>Phone:</b> <%= rep_telephone %><br>
										<b>Fax No:</b> <%= rep_fax %><br>
										<%}
										%>
										<b>e-mail:</b> <%= rep_email %><br>

										<%
										if (product.equals("GE")) {
											//out.println("here<BR>");
											if(rep_name.trim().length()>0){
												out.println("Rep Name: "+rep_name +"<br>");

											}
										}
										%>

									</td>
								</tr>
								<%if( !(product.equals("GE")) ){ %>
								<tr>
									<td valign='bottom' class='mainbodyh'><b>Architect:</b>&nbsp;</td>
									<td width='200' valign='bottom' class='mainbody'><%= Arch_name %> </td>
									<td width='100%'>&nbsp;</td>
								</tr>
								<!--<tr><td valign='top' class='mainbodyh'><b>Location:</b>&nbsp;</td>//commented out from Gord's comment on June 27'06-->
								<tr><td valign='top' class='mainbodyh'>&nbsp;</td>
									<td width='200' valign='top' class='mainbody'><%= Arch_loc %></td>
									<td width='100%'>&nbsp;</td>
								</tr>
								<%
								}
								%>
							</table>
							<hr>