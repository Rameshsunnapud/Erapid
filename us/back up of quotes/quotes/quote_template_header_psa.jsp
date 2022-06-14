

<body bgcolor="white" topmargin="25" leftmargin="25" bgcolor="white" marginheight="0" marginwidth="0">
	<!-- header -->
	<%
	String pdf=request.getParameter("pdf");
	if(pdf==null ||  !pdf.toUpperCase().equals("TRUE")){
	%>
	<table cellspacing='0' cellpadding='0' border='0' width='100%'>
		<tr>
			<%
			if ( (product.equals("GE")) ){
				out.println("<td align='left'><img src='http://csimages.c-sgroup.com/eRapid/ge_logo.jpg' alt></td>");
			}
			else if ( (product.equals("APC")) ){
				out.println("<td align='left'><img src='http://csimages.c-sgroup.com/eRapid/apc_logo.jpg' alt></td>");
			}
			else {
				out.println("<td align='left'><img src='http://csimages.c-sgroup.com/eRapid/cs_logo.jpg' alt='C/S Logo'></td>");
			}
			%>
		</tr></table>
		<%
	}
		%>
	<!-- end header -->
	<table cellspacing='0' cellpadding='0' border='0' width='100%'>
		<%

		//out.println(group_id+":: HERE");

			if ( (doc_priority.equals("E")) ){
				if(product.equals("ADS")){
					out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
					out.println("<br><font class='subtitle'>Acrovyn Door Systems Division<br>");

					//out.println("<tr><td align='center' class='maintitle'><b>ACROVYN DOOR SYSTEMS</b>");
					//out.println("<br><font class='subtitle'>A Division of Construction Specialties, Inc.");
					//out.println("<br><font class='subtitle'>A Member of C/S Group of Companies<br>");
					out.println("3 Werner Way<br>");
					out.println("Lebanon, NJ 08833<br>");
					out.println("Tel: 908-236-0800 Fax: 908-849-4285<br>");

				}
				else{
					if(group_id.startsWith("Decolink")){
						out.println("<tr><td align='center' class='maintitle'><b>C/S Eldercare Interiors</b>");
						out.println("<br><font class='subtitle'>Formerly DecoLink Division<br>");
						out.println("225 Regency Court<br>Brookfield, WI 53045<br>Phone: 800-304-2234<br> Fax: 262-789-1855");
					}else{
						if(product.equals("GCP")){
							out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
							out.println("<br><font class='subtitle'>C/S Cubicle Curtains Division<br>");
					out.println("3 Werner Way<br>");
					out.println("Lebanon, NJ 08833<br>");
							out.println("TEL:908-325-4900 FAX:908-849-4398");
						} else {
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
					//out.println("<br><font class='subtitle'>C/S ElderCare Interiors Division<br>");
					out.println("<tr><td align='center' class='maintitle'><b>C/S Eldercare Interiors</b>");
					out.println("<br><font class='subtitle'>Formerly DecoLink Division<br>");
					out.println("225 Regency Court<br>Brookfield, WI 53045<br>Phone: 800-304-2234<br> Fax: 262-789-1855");
				}
				else if(group_id.startsWith("Internatio")) {
					out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
					out.println("<br><font class='subtitle'>Construction Specialties International Division<br>");
					out.println("3 Werner Way<br>Lebanon, NJ 08833</font>");
					out.println("<br><font class='subtitle'>Phone: 908-236-0800 Fax: 908-236-2903</font>");
					out.println("<br><font class='subtitle'>Website: www.c-sgroup.com</font>");
					out.println("<br>");
				}
				else{
					//out.println("HERE1");
					if(product.equals("GCP")){
						out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
						out.println("<br><font class='subtitle'>General Cubicle Division<br>");
						out.println("49 Meeker Avenue <br>Cranford, NJ 07016");
						out.println("<br>TEL:908-325-4900 FAX:908-849-4398");
					}
					else if(product.endsWith("LVR")|product.endsWith("BV")|product.endsWith("GRILLE")|product.endsWith("DADE_LVR")|product.endsWith("SUNSHADE")){
					out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
					out.println("<br><font class='subtitle'>");
					out.println("49 MEEKER AVENUE.<br>CRANFORD, NJ 07016");
						if(product.endsWith("GRILLE")){
							out.println("<br>TEL:908-272-5200 FAX:908-272-6038");
						}
						else{
							out.println("<br>TEL:908-272-5200 FAX:908-272-2920");
						}
					}
					else if(product.endsWith("GE")) {
						out.println("<tr><td align='center' class='maintitle'><b>GRAND ENTRANCE</b>");
						out.println("<br><font class='subtitle'>A Division of Construction Specialties, Inc.<br>");
						out.println("4005 Royal Drive Ste 300<br>Kennesaw, GA 30144<br>Phone No: 888-424-6287 <br> Fax No: 908-849-4295");
					}
					else if(product.equals("EXP")){
					out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, Inc.</b>");
					out.println("<br><font class='subtitle'>");
					out.println("49 Meeker Avenue<BR>Crandford, NJ 07016<BR>Tel: (800)222-0201 Fax: (800)293-4509");
					}
					else if(product.equals("APC")){
						out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
						out.println("<br><font class='subtitle'>APC Dayliter Division Division<br>");
						out.println("A Division of Construction Specialties Inc<br>49 Meeker Avenue<BR>Crandford, NJ 07016<BR>Tel: (800)222-0201 Fax: (800)293-4509");
					}
					else if(product.equals("ADS")){
						out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
						out.println("<br><font class='subtitle'>Acrovyn Door Systems Division<br>");
						out.println("3 Werner Way<br>");
						out.println("Lebanon, NJ 08833<br>");
						out.println("Tel: 908-236-0800 Fax: 908-849-4285<br>");
					}
					else{
					out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
					out.println("<br><font class='subtitle'>");
					out.println("6696 ROUTE 405 HWY.<br>Muncy, PA 17756");
					}
				}
					out.println("</font></td></tr>");
			}


		%>
	</table>

	<table cellspacing='0' cellpadding='0' border='0' width='100%'>
		<tr>
			<td width='55%' valign='top' nowrap class='mainbody' >
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


					ResultSet rs_psa_account = stmt_psa.executeQuery("SELECT acctname,addr1,addr2,town,county,postcode,tel,fax,alias,country FROM dba.account where acct_id like '"+AcctID+"'");
						if (rs_psa_account !=null) {
						while (rs_psa_account.next()) {
									cust_name1= rs_psa_account.getString(1);
									//out.println(cust_name1+"::<BR>");
									cust_addr1= rs_psa_account.getString(2);
									cust_addr2= rs_psa_account.getString(3);
									city= rs_psa_account.getString(4);
									state= rs_psa_account.getString(5);
									zip_code= rs_psa_account.getString(6);
									cust_phone= rs_psa_account.getString(7);
									cust_fax= rs_psa_account.getString(8);
									country= rs_psa_account.getString(10);
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
						String project_address="";
						String provider_pl_id="";
						ResultSet rs_psa_project = stmt_psa.executeQuery("SELECT * FROM dba.project where project_id like '"+project_id+"'");
						if (rs_psa_project !=null) {
						while (rs_psa_project.next()) {
									Project_name=rs_psa_project.getString("project_title");
									project_city=rs_psa_project.getString("site_town");
									project_state=rs_psa_project.getString("site_county");
									scan_no=rs_psa_project.getString("provider_pl_id");
									project_address=rs_psa_project.getString("site_addr1");
									provider_pl_id=rs_psa_project.getString("provider_pl_id");
							}
						}
					if(project_city==null){project_city="";}
					if(project_state==null){project_state="";}
					if(project_address==null){project_address="";}
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
				if(! ((product.equals("LVR"))|(product.equals("BV"))|product.equals("ADS")|(product.equals("GRILLE"))|(product.equals("EJC"))|(product.equals("EFS"))|(product.equals("IWP"))|(product.equals("EJC"))|product.equals("GCP")|product.equals("EXP")) ){
						if(cust_name1.trim().length()>0){out.println(cust_name1+"<br>");}
						if(cust_addr1.trim().length()>0){out.println(cust_addr1+"<br>");}
						if(cust_addr2.trim().length()>0){out.println(cust_addr2+"<br>");}
						out.println(city+",&nbsp;"+state+"&nbsp; "+zip_code+"&nbsp; "+country+"<br>");
						if(cust_phone != null && cust_phone.trim().length() >0){out.println("Phone: "+cust_phone+"<br>");}
						if(cust_fax != null && cust_fax.trim().length() > 0){out.println("Fax: "+cust_fax+"<br>");}
						if( !((product.equals("LVR"))|(product.equals("BV"))|(product.equals("GRILLE"))) ){
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
			<td width='15%' valign='top' align='left' nowrap class='mainbody'><b>Quote No:</b><br><b>eRapid No:</b><br><b>Quote Date:</b><BR><b>Quote Source:</b><BR><b>Provider ID:</b></td>
			<td width='30%' valign='top' nowrap class='mainbody'><%= psa_quote_type %><%= QuoteID %><br><%= order_no %>(<%= psa_type_of_quote %>)<br><%= odate %><BR><%= quote_region %><BR><%= provider_pl_id %></td>
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
				if(!(group_id.startsWith("Internatio"))) {
			%>
			<td valign='top' align='left' nowrap class='mainbody'><b>Quote No:</b><br><b>Scan:</b></td>
			<td valign='top' nowrap class='mainbody'><%= order_no %>
				<%if(alias != null &&!alias.equals("null")&&alias.trim().length()>0){%>
				(<%= alias %>)
				<%}%>
				<br><%= scan_no %></td>
				<%
				}

				else{
				%>
			<td  valign='top' align='left' nowrap class='mainbody'><b>Quote No:</b></td>
			<td  valign='top' nowrap class='mainbody'><%= order_no %>

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
				if(cust_name1.trim().length()>0){out.println(cust_name1+"<br>");}
				if(cust_addr1.trim().length()>0){out.println(cust_addr1+"<br>");}
				if(cust_addr2.trim().length()>0){out.println(cust_addr2+"<br>");}
				out.println(city+",&nbsp;"+state+"&nbsp; "+zip_code+"&nbsp; "+country+"<br>");
				if(cust_phone != null && cust_phone.trim().length() >0){out.println("Phone: "+cust_phone+"<br>");}
				if(cust_fax != null && cust_fax.trim().length() > 0){out.println("Fax: "+cust_fax+"<br>");}
				if (product.equals("IWP")){if(rep_email.trim().length()>0){out.println("e-mail:"+rep_email+"<br>");}}
				%>
			</td>
			<td  valign='top' align='left' nowrap class='mainbody'><b>Quote Date:</b></td>
			<td  valign='top' nowrap class='mainbody'><%= odate %></td>
		</tr>
		<%
	}
	else if( !((product.equals("LVR"))|(product.equals("BV"))|(product.trim().equals("GRILLE"))) ){
		//out.println(product);
		%>
		<tr>
			<td  valign='top' nowrap class='mainbody'>&nbsp;</td>
			<td  valign='top' align='left' nowrap class='mainbody'><b>Quote Date:</b></td>
			<td  valign='top' nowrap class='mainbody'><%= odate %></td>
		</tr>
		<%
	}
	if( !(product.equals("GE")|product.equals("APC")|(product.equals("LVR"))|(product.equals("BV"))|(product.equals("GRILLE"))|(group_id.startsWith("Decolink"))) ){ %>
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
				out.println("<td width='30%' nowrap valign='top' class='mainbody'>"+Project_name+"<br>");
				if(project_address.trim().length()>0){
					out.println(project_address+"<BR>");
				}
				out.println(project_city+"&nbsp;&nbsp;"+project_state+"<br>"+psa_quote_desc+"</td>");
			} else {
				out.println("<td width='30%' nowrap valign='top' class='mainbody'>"+Project_name+"<br>"+project_city+"&nbsp;&nbsp;"+project_state+"</td>");
			}
		}
			%>
			<td width='15%' rowspan='1'>&nbsp;</td>
			<td valign='top' width='45%' rowspan='3' align='left' nowrap class='mainbody'>
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

				if(group_id.toUpperCase().indexOf("REP")>=0){
					//cust_name1=rep_name+"<BR>"+rep_account;
					//cust_addr1=address1;
					//cust_addr2=address2;
					//city=rep_city;
					//state=rep_sate;
					//zip_code=rep_zip_code;
					//country="";
					//cust_phone=rep_telephone;
					//cust_fax=rep_fax;
				}

/*
		rep_account= rs_reps.getString("rep_account");
		address1= rs_reps.getString("address1");
		address2= rs_reps.getString("address2");
		rep_city= rs_reps.getString("rep_city");
		rep_state= rs_reps.getString("state");
		rep_zip_code= rs_reps.getString("zip");
		rep_telephone= rs_reps.getString("telephone");
		rep_fax= rs_reps.getString("fax");
		rep_email2= rs_reps.getString("email");
		rep_name = rs_reps.getString("rep_name");
*/



				//out.println(group_id);
				if(!(group_id.equals("Decolink"))&& ((product.equals("LVR"))|(product.equals("BV"))|product.equals("ADS")|(product.equals("GRILLE"))|(product.equals("EJC"))|(product.equals("EFS"))|(product.equals("IWP"))|(product.equals("EJC"))|product.equals("GCP")|product.equals("EXP")) ){
					out.println("<b>Representative:</b><br>");
					if(cust_name1.trim().length()>0){out.println(cust_name1+"<br>");}
					if(cust_addr1.trim().length()>0){out.println(cust_addr1+"<br>");}
					if(cust_addr2.trim().length()>0){out.println(cust_addr2+"<br>");}


					out.println(city+",&nbsp;"+state+"&nbsp; "+zip_code+"&nbsp; "+country+"<br>");




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
					out.println("<td valign='top' width='300' rowspan='3' nowrap class='mainbody'><b>C/S Representative:</b><br>");
					out.println("<b>e-mail:</b> "+ rep_email +"<br>");
					if(rep_name.trim().length()>0){
						out.println("Rep Name: "+rep_name +"<br>");

					}

					*/
				}

				else if(group_id.equals("Decolink")){
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
					out.println("<b>e-mail:</b> "+ rep_email2 +"<br>");
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
		<%

		if( !((product.equals("GE"))|(product.equals("APC"))|(product.equals("LVR"))|(product.equals("BV"))|(product.equals("GRILLE")) |(product.equals("ADS"))  ) ){ %>
		<tr>
			<td  nowrap valign='top' align='left' class='mainbodyh'><b>Architect:</b>&nbsp;</td>
			<td  valign='top' class='mainbody'><%= Arch_name %> </td>
			<td ></td>
		</tr>
		<tr>
			<td  nowrap valign='top' align='left' class='mainbodyh'><b>Location:</b>&nbsp;</td>
			<td  valign='top' class='mainbody'><%= Arch_loc %>&nbsp;,<%= Arch_state %></td>
			<td></td>
		</tr>
		<%
	}
	/*
	else if( (product.equals("LVR"))|(product.equals("BV"))|(product.equals("GRILLE")) ){
		%>
		<tr>
			<td  nowrap valign='top' align='left' class='mainbodyh'><b>Architect:</b>&nbsp;</td>
			<td  valign='top' class='mainbody'><b><%= Arch_name %></b> </td>
			<td ></td>
		</tr>
		<tr><td  nowrap valign='top' align='left' class='mainbodyh'><b>Location:</b>&nbsp;</td>
			<td  valign='top' class='mainbody'><b><%= Arch_loc %>&nbsp;<%= Arch_state %></b></td>
			<td ></td>
		</tr>
		<%
	}
	*/

		%>
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
		if(!product.equals("IWP")){
	%>
	<table cellspacing='0' cellpadding='0' border='0' width='100%'>
		<tr><td nowrap valign='top' class='mainbodyh'><b>Spec Level:</b>&nbsp;</td>
			<td nowrap valign='top' class='mainbodyh'><%=spec_temp %>&nbsp;</td>
			<td nowrap width='100%' class='mainbodyh'>&nbsp;</td>

		</tr>
	</table>
	<%
}
}

	%>
