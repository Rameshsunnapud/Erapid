<%                String action=request.getParameter("action");
                if(action==null){
                    action="";
                }
if(action.equals("rtf")||action.equals("pdf")){
%>
<link rel='stylesheet' href='../../css/quotes2.css' type='text/css' />
<%
if(repAddress.indexOf("&nbsp;<BR>&nbsp;")==0){
repAddress=repAddress.replaceAll("Prepared","&nbsp;<BR>&nbsp;<br>Prepared");
}
}
else{
%>
<link rel='stylesheet' href='../../css/quotes.css' type='text/css' >
<%
}
%>

<body bgcolor="white" topmargin="25" leftmargin="25" bgcolor="white" marginheight="0" marginwidth="0">
	<!-- header -->
	<%
			if(providerId==null){
				providerId="";
			}
			if(Arch_name==null || Arch_name.trim().equals("null")  ){
				Arch_name="";
			}

			if(Arch_loc==null || Arch_loc.trim().equals("null")  ){
				Arch_loc="";
			}

			if(project_city==null || project_city.trim().equals("null")  ){
				project_city="";
			}
			if(project_state==null || project_state.trim().equals("null")  ){
				project_state="";
			}
quoteHeader.setOrderNo(order_no);
//out.println(salesForceNo);
canType=quoteHeader.checkSFDCType(salesForceNo);
if(canType==null){
	canType="";
}
	String pdf=request.getParameter("pdf");
	if(pdf==null ||  !pdf.toUpperCase().equals("TRUE")){
	%>
	<table cellspacing='0' cellpadding='0' border='0' width='100%'>
		<tr>
			<%
			if ( (product.equals("GE")) ){
				//out.println("<td align='left'><img src='http://csimages.c-sgroup.com/eRapid/impact_logo.png' width='150' alt></td>");
				out.println("<td align='left'><img src='../../images/impact_logo.png' width='200' alt></td>");
			}
else if(product.equals("FSM")){
out.println("<td align='left'><img src='http://csimages.c-sgroup.com/eRapid/vista_aire_logo.jpg' width='150' alt></td>");
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
		if(Project_name.trim().length()>50){
			if(Project_name.substring(0,50).lastIndexOf(" ")>0){
				int temp=Project_name.substring(0,50).lastIndexOf(" ");
				Project_name=Project_name.substring(0,temp)+"<BR>"+Project_name.substring(temp);
			}
			else{
				Project_name=Project_name.substring(0,50)+"<BR>"+Project_name.substring(50);
			}
		}
		//out.println(group_id+":: HERE");
		//out.println(product+"::<BR>");
		if((group_id.toUpperCase().startsWith("CAN")||canType.equals("CAD")) &&! (product.equals("LVR") ||product.equals("FSM")|| product.equals("GRILLE"))){

					out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
					out.println("<br><font class='subtitle'>");
					out.println("2240 Argentia Rd.<br>Suite 102 Mississauga, Ontario L5N 2K7");
					out.println("Tel: 888-895-8955<br>");
					out.println("</font></td></tr>");


			}
			else{

			if ( (doc_priority.equals("E")) ){
				if(product.equals("ADS")||product.equals("REF")){
					out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
					out.println("<br><font class='subtitle'>Acrovyn Door Systems Division<br>");

					//out.println("<tr><td align='center' class='maintitle'><b>ACROVYN DOOR SYSTEMS</b>");
					//out.println("<br><font class='subtitle'>A Division of Construction Specialties, Inc.");
					//out.println("<br><font class='subtitle'>A Member of CS Group of Companies<br>");
					out.println("3 Werner Way<br>");
					out.println("Lebanon, NJ 08833<br>");
					out.println("Tel: 888.331.2031<br>");

				}
				else{
					//out.println("HERE0");
					if(group_id.startsWith("Decolink")){
						//out.println("<tr><td align='center' class='maintitle'><b>CS Senior Living</b><BR>"); As per tac 101289 we modified
						out.println("<tr><td align='center' class='maintitle'><b>Facility Sales</b><BR>"); 
						out.println("<br><font class='subtitle'>");
//Formerly DecoLink Division<br>");
						out.println("225 Regency Court<br>Brookfield, WI 53045<br>Tel: 888.331.2031<br>");
					}else{
						if(product.equals("GCP")){
							out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
							out.println("<br><font class='subtitle'>CS Cubicle Curtains Division<br>");
							out.println("3 Werner Way<br>");
							out.println("Lebanon, NJ 08833<br>");
							out.println("Tel:888.331.2031");
						}
						else if(product.endsWith("LVR")|product.endsWith("FSM")|product.endsWith("BV")|product.endsWith("GRILLE")|product.endsWith("DADE_LVR")|product.endsWith("SUNSHADE")){
							if(product.equals("FSM")){
out.println("<tr><td align='center' class='maintitle'><b>A DIVISION OF CONSTRUCTION SPECIALTIES, INC</b>");
							}
							else{
							out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
}
							out.println("<br><font class='subtitle'>");
							out.println("3 Werner Way <br>Lebanon, NJ 08833");
							if(product.endsWith("GRILLE")){
								out.println("<br>Tel:888.331.2031");
							}
							else{
								out.println("<br>Tel:888.331.2031");
							}
						}
						else {
							out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
							out.println("<BR>P.O. Box 380<br>Muncy, PA 17756");
						}
					}
					out.println("</font></td></tr>");
				}
			}

			else{
				if(group_id.startsWith("Decolink")){
					//out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
					//out.println("<br><font class='subtitle'>CS ElderCare Interiors Division<br>");
					//out.println("<tr><td align='center' class='maintitle'><b>CS Eldercare Interiors</b>");
					//out.println("<br><font class='subtitle'>Formerly DecoLink Division<br>");
					//out.println("<tr><td align='center' class='maintitle'><b>CS Senior Living</b><BR>"); As per tac 101289 we modified
					out.println("<tr><td align='center' class='maintitle'><b>Facility Sales</b><BR>"); 
					out.println("225 Regency Court<br>Brookfield, WI 53045<br>Tel: 888.331.2031<br>");
				}
				else if(group_id.startsWith("Internatio")) {
					out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
					out.println("<br><font class='subtitle'>Construction Specialties International Division<br>");
					out.println("3 Werner Way<br>Lebanon, NJ 08833</font>");
					out.println("<br><font class='subtitle'>Tel: 888.331.2031</font>");
					out.println("<br><font class='subtitle'>Website: www.c-sgroup.com</font>");
					out.println("<br>");
				}
				else{
					//out.println("HERE1");
					if(product.equals("GCP")){
						out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
						out.println("<br><font class='subtitle'>Cubicle Curtains Division<br>");
				out.println("3 Werner Way<br>");
				out.println("Lebanon, NJ 08833<br>");
						out.println("Tel:888.331.2031");
					}
					else if(product.equals("LVR")||product.endsWith("FSM")|product.endsWith("BV")|product.endsWith("GRILLE")|product.endsWith("DADE_LVR")|product.endsWith("SUNSHADE")){
						if(product.equals("FSM")){
							out.println("<tr><td align='center' class='maintitle'><b>A DIVISION OF CONSTRUCTION SPECIALTIES, INC</b>");
						}
						else{
							out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");

						}
						out.println("<br><font class='subtitle'>");
						out.println("3 Werner Way <br>Lebanon, NJ 08833");
						if(product.endsWith("GRILLE")){
							out.println("<br>Tel:888.331.2031");
						}
						else{
							out.println("<br>Tel:888.331.2031");
						}
					}
					else if(product.endsWith("GE")) {
						out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
						out.println("<br><font class='subtitle'>National Accounts<br>");
						out.println("4005 Royal Drive Ste 100<br>Kennesaw, GA 30144<br>Tel: 888.331.2031 <br>");
					}

					else if(product.equals("ADS")||product.equals("REF")){
						out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
						out.println("<br><font class='subtitle'>Acrovyn Door Systems Division<br>");
						out.println("3 Werner Way<br>");
						out.println("Lebanon, NJ 08833<br>");
						out.println("Tel: 888.331.2031<br>");
					}
					else{
						out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
						out.println("<br><font class='subtitle'>");
						out.println("6696 ROUTE 405 HWY.<br>Muncy, PA 17756");
					}
				}
					out.println("</font></td></tr>");
			}
}


		%>
	</table>
	&nbsp;<BR>
	<table cellspacing='0' cellpadding='0' border='0' width='100%'>
		<tr>
			<td width='55%' valign='top' nowrap class='mainbody'>
				<%
				// only for internal quotes

				//		HttpSession UserSession_rep = request.getSession();
				//		String session_rep_no= UserSession_rep.getAttribute("rep_no").toString();
				if(exchName.equals("CAD")||exchName.equals("CAN")){
						out.println(canCustomer);
				}
				else if((group_id.toUpperCase().startsWith("REP") && project_type != null && project_type.equals("PSA"))){
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


				if(cust_name1==null){cust_name1="";}
				if(cust_addr1==null){cust_addr1="";}
				if(cust_addr2==null){cust_addr2="";}
				if(cust_phone==null){cust_phone="";}
				if(cust_fax==null){cust_fax="";}
				if(! ((product.equals("LVR"))|product.equals("FSM")|(product.equals("BV"))|product.equals("ADS")|product.equals("REF")|(product.equals("GRILLE"))|(product.equals("EJC"))|(product.equals("EFS"))|(product.equals("IWP"))|(product.equals("EJC"))|product.equals("GCP")|product.equals("EXP")) ){
						if(cust_name1.trim().length()>0){out.println(cust_name1+"<br>");}
						if(cust_addr1.trim().length()>0){out.println(cust_addr1+"<br>");}
						if(cust_addr2.trim().length()>0){out.println(cust_addr2+"<br>");}
						out.println(city+",&nbsp;"+state+"&nbsp; "+zip_code+"&nbsp; "+country+"<br>");
						if(cust_phone != null && cust_phone.trim().length() >0){out.println("Phone: "+cust_phone+"<br>");}
						if(cust_fax != null && cust_fax.trim().length() > 0){out.println("Fax: "+cust_fax+"<br>");}
						if( !((product.equals("LVR"))|product.equals("FSM")|(product.equals("BV"))|(product.equals("GRILLE"))) ){
							if(agent_name != null && agent_name.trim().length()>0){
								out.println("<b>Attention: </b>"+agent_name+"<br>");
							}
						}
				}else{out.println("&nbsp;&nbsp;");}
				%>
			</td>
			<!--<td width='45%' valign='top' rowspan='3' class='mainbody'>&nbsp;</td>-->
			<%
			//out.println(product);
			if( (product.equals("LVR"))|product.equals("FSM")|(product.equals("BV"))|(product.equals("GRILLE")) ){
				String provider_pl_id="";


			%>
			<td width='15%' valign='top' align='left' nowrap class='mainbody'><b>Quote No:</b><br><b>eRapid No:</b><br><b>Quote Date:</b><BR><b>Quote Source:</b><BR><b>Provider ID:</b></td>
			<td width='30%' valign='top' nowrap class='mainbody'><%= salesForceNo %><br><%= order_no %><br><%= odate %><BR><%= quoteSource %><BR><%= providerId %></td>
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
if(providerId==null || providerId.equals("null")){
	providerId="";
}
				if(!(group_id.startsWith("Internatio"))) {
if(product.equals("IWP")){
			%>
			<td width='15%' valign='top' align='left' nowrap class='mainbody'><b>Opportunity:</b><BR><b>Quote No:</b><br><b>Scan:</b></td>
			<td width='30%' valign='top' nowrap class='mainbody'><%=opportunityId%><BR><%= order_no %>
				<%if(alias != null &&!alias.equals("null")&&alias.trim().length()>0){%>
				(<%= alias %>)
				<%}%>
				<br><%//= quoteSource %><%= providerId %></td>
				<%
}
else{
				%>
			<td width='15%' valign='top' align='left' nowrap class='mainbody'><b>Quote No:</b><br><b>Scan:</b></td>
			<td width='30%' valign='top' nowrap class='mainbody'><%= order_no %>
				<%if(alias != null &&!alias.equals("null")&&alias.trim().length()>0){%>
				(<%= alias %>)
				<%}%>
				<br><%//= quoteSource %><%= providerId %></td>
				<%
}
				}

				else{
				%>
			<td  width='15%' valign='top' align='left' nowrap class='mainbody'><b>Quote No:</b></td>
			<td  width='30%' valign='top' nowrap class='mainbody'><%= order_no %>

				<%if(alias != null &&!alias.equals("null")&&alias.trim().length()>0){%>
				(<%= alias %>)
				<%}%>
			</td>
			<%
			}

		}
			%>
		</tr>
		<%
		//out.println(product);
		if(group_id.equals("Decolink")){
			if(rep_email==null){rep_email="";}
		%>
		<tr>
			<td  valign='top' nowrap class='mainbody'>
				<%
				out.println(repAddress);
				/*
				if(cust_name1.trim().length()>0){out.println(cust_name1+"<br>");}
				if(cust_addr1.trim().length()>0){out.println(cust_addr1+"<br>");}
				if(cust_addr2.trim().length()>0){out.println(cust_addr2+"<br>");}
				out.println(city+",&nbsp;"+state+"&nbsp; "+zip_code+"&nbsp; "+country+"<br>");
				if(cust_phone != null && cust_phone.trim().length() >0){out.println("Phone: "+cust_phone+"<br>");}
				if(cust_fax != null && cust_fax.trim().length() > 0){out.println("Fax: "+cust_fax+"<br>");}
				if (product.equals("IWP")){if(rep_email.trim().length()>0){out.println("e-mail:"+rep_email+"<br>");}}
				*/
				%>
			</td>
			<td  valign='top' align='left' nowrap class='mainbody'><b>Quote Date:<BR>Bid Date</b></td>
			<td  valign='top' nowrap class='mainbody'><%= odate %><BR><%= edate%></td>
		</tr>
		<%
	}
	else if( !((product.equals("LVR"))|product.equals("FSM")|(product.equals("BV"))|(product.trim().equals("GRILLE"))) ){
		//out.println(product);
		%>
		<tr>
			<td  valign='top' nowrap class='mainbody'>&nbsp;</td>
			<td  valign='top' align='left' nowrap class='mainbody'><b>Quote Date:</b></td>
			<td  valign='top' nowrap class='mainbody'><%= odate %></td>
		</tr>
		<%
	}
	if( !(product.equals("GE")|product.equals("APC")|product.equals("FSM")|(product.equals("LVR"))|(product.equals("BV"))|(product.equals("GRILLE"))|(group_id.startsWith("Decolink"))) ){ %>
		<tr>
			<td  valign='top' nowrap class='mainbody'>&nbsp;</td>
			<td  valign='top' align='left' nowrap class='mainbody'><b>Bid Date:</b></td>
			<td  valign='top' nowrap class='mainbody'><%= edate %></td>
		</tr>
		<%
		}
		%>
	</table>
	&nbsp;<br>
	<table cellspacing='0' cellpadding='0' border='0' width='100%'>

		<tr>

			<%
			if((product.equals("LVR"))|product.equals("FSM")|(product.equals("BV"))|(product.equals("GRILLE")) ){
			%>
			<td nowrap valign='top' align='left' class='mainbody' width='10%'><b>Project:</b>&nbsp;<BR><BR>&nbsp;<BR>&nbsp;<BR><b>Architect:</b>&nbsp;<BR><b>Location:</b>&nbsp;<BR></td>
				<%
				if(Arch_loc==null){
				Arch_loc="";
				}
				if(Arch_loc.indexOf(",")>0 && Arch_loc.indexOf(", ")<0){
					Arch_loc=Arch_loc.replaceAll(",",", ");
				}

				out.println("<td width='30%' nowrap valign='top' class='mainbody'><b>"+Project_name+"<br>"+project_city+",&nbsp;"+project_state+"<br><BR>"+Arch_name+"<br><br>"+Arch_loc+",&nbsp;"+Arch_state+" </td>");

                                if(Arch_state != null && Arch_state.trim().length()>0){
					out.println(",&nbsp;"+Arch_state);
				}
				out.println(" </b></td>");

			}
			else if(product.equals("ADS")||product.equals("REF")){
				%>
			<td nowrap valign='top' align='left' class='mainbody' width='10%'><b>Project:</b>&nbsp;<BR><BR>&nbsp;<BR><b>Architect:</b>&nbsp;<BR>&nbsp;<BR><b>Location:</b>&nbsp;<BR></td>
				<%
				if(Arch_loc==null){
				Arch_loc="";
				}
				String archLoc="", archState="";
				//out.println("Test 0 "+Arch_loc);
				if(Arch_loc.indexOf(",")>0){
					//out.println("Test 1 "+Arch_loc);
					String Arch_loc2[]=Arch_loc.split(",");
					//out.println("Test 2 "+Arch_loc2[0]);
					archLoc=Arch_loc2[0];
					//out.println("Test 3 "+Arch_loc);
					archState=Arch_loc2[1];
				}
				out.println("<td width='30%' nowrap valign='top' class='mainbody'><b>"+opportunityName+"</b><br>"+project_city+",&nbsp;"+project_state+"<br><BR>"+Arch_name+"<br><br>"+Arch_loc+"&nbsp;"+Arch_state+" </td>");

			}
			else{
				%>
			<td nowrap valign='top' align='left' class='mainbody' width='10%'><b>Project:</b>&nbsp;</td>
			<%
			if(product.equals("GCP")){
				out.println("<td width='30%' nowrap valign='top' class='mainbody'>"+Project_name+"<br>");

				out.println(project_city+"&nbsp;&nbsp;"+project_state+"<br>"+psa_quote_desc+"</td>");
			} else {
				out.println("<td width='30%' nowrap valign='top' class='mainbody'>"+Project_name+"<br>"+project_city+",&nbsp;"+project_state+"</td>");
			}
		}
			%>
			<td width='15%' >&nbsp;</td>
			<td valign='top' width='45%' align='left' nowrap class='mainbody'>
				<%
				if(rep_account==null){rep_account="";}
				if(rep_city==null){rep_city="";}
				if(rep_state==null){rep_state="";}
				if(rep_zip_code==null){rep_zip_code="";}
				if(city==null||city.equals("null")){city="";}
				if(state==null||state.equals("null")){state="";}
				if(country==null||country.equals("null")){country="";}
				if(zip_code==null||zip_code.equals("null")){zip_code="";}
				if(rep_telephone==null){rep_telephone="";}
				if(rep_fax==null){rep_fax="";}
				if(rep_email==null){rep_email="";}
				if(rep_name==null){rep_name="";}
				//out.println(group_id);
				if(group_id.startsWith("Decolink")||product.equals("GE")){
				out.println("<b>CS Representative:</b><br>");
				//out.println(decoRep);
				out.println(repAddress);
				}
				else if(product.equals("FSM")){
				out.println("<b>Distributor:</b><br>");

				out.println(repAddress);

}
				else{
				out.println("<b>Representative:</b><br>");

				out.println(repAddress);
				}

				%>

			</td>
		</tr>
		<%

		if( !((product.equals("GE"))|(product.equals("APC"))|(product.equals("LVR"))|product.equals("FSM")|(product.equals("BV"))|(product.equals("GRILLE")) |(product.equals("ADS")||product.equals("REF"))  ) ){ %>
		<tr>
			<td  nowrap valign='top' align='left' class='mainbody'><b>Architect:</b>&nbsp;</td>
			<td  valign='top' class='mainbody'><%= Arch_name %> </td>
			<td ></td>
		</tr>
		<tr>
			<td  nowrap valign='top' align='left' class='mainbody'><b>Location:</b>&nbsp;</td>
			<%
				if(Arch_state!= null && Arch_state.trim().length()>0){
					Arch_state=", "+Arch_state;
				}
			%>
			<td  valign='top' class='mainbody'><%= Arch_loc %>&nbsp;<%= Arch_state %></td>
			<td></td>
		</tr>
		<%
	}


		%>
	</table>

	<%
	//out.println(group_id);
	if( !group_id.startsWith("Internatio")&&(product.equals("IWP")) ){
		//out.println(spec_level+":::HERE");
		String spec_temp="";
		if(!(spec_level==null)){
			if(spec_level.trim().length()>0){

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
		if(!product.equals("IWP")){
	%>
	<table cellspacing='0' cellpadding='0' border='0' width='100%'>
		<tr><td nowrap valign='top' class='mainbody'><b>Spec Level:</b>&nbsp;</td>
			<td nowrap valign='top' class='mainbody'><%=spec_temp %>&nbsp;</td>
			<td nowrap width='100%' class='mainbody'>&nbsp;</td>

		</tr>
	</table>
	<%
}
}

	%>
