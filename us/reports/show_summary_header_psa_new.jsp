<html>
	<head>
		<title>Quote No <%= order_no %></title>
		<style type="text/css">
			.maintitle { color:#333333; font-size:12pt; font-family:arial, helvetica; }
			.subtitle10 { color:#333333; font-size:10pt; font-family:arial, helvetica; }
			.mainfooter { color:#666666; font-size:8pt; font-family:tahoma, arial, helvetica; }
			.mainbody { color:#333333; font-size:10pt; font-family:arial, verdana, helvetica; text-decoration:none; }
			.mainbodyh { color:#333333; font-size:8.5pt;font-family:verdana, arial, helvetica; text-decoration:none; }
			.maindesc { color:#333333; font-size:8pt; font-family:arial, verdana, helvetica; text-decoration:none; }
			.schedule { color:#ffffff; font-size:9pt; font-family:arial, verdana, helvetica; text-decoration:none; }
			.schedule1 { color:#333333; font-size:9pt; font-family:arial, verdana, helvetica; text-decoration:none; }
			.totprice { color:#000000; font-size:12pt; font-family:arial, helvetica; text-decoration:none; }
			.tableline { border-right: #B4DC61 1px solid; border-top: #B4DC61 1px solid; border-left: #B4DC61 1px solid; border-bottom: #B4DC61 1px solid; }
			.tableline_row { padding-right: 5px; padding-left: 5px; padding-bottom: 3px; padding-top: 3px; }
		</style>
	</head>

	<body bgcolor="white" topmargin="25" leftmargin="25" bgcolor="white" marginheight="0" marginwidth="0">
		<table cellspacing='0' cellpadding='0' border='0' width='100%'>
			<tr><td align='left'><img src='http://csimages.c-sgroup.com/eRapid/cs_logo.jpg' alt='CS Logo'></td></tr>
					<%

try{
					String adsusername="";
					ResultSet rsLogia=stmt.executeQuery("select rep_name from cs_reps where user_id='"+user_id+"'");
					if(rsLogia != null){
						while(rsLogia.next()){
							adsusername=rsLogia.getString(1);
						}
					}
					rsLogia.close();
					if(adsusername == null ||adsusername.trim().length()==0){
						adsusername=user_id;
					}
					if(priority.equals("E")){
					%>

			<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC.</b><br><br>
					<%
					}
					else{
					%>
			<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC.</b><br><br>
					<%
					}
					%>
					<%@ include file="../../db_con_psa.jsp"%>
					<%
					if(!product.equals("ADS")&& (nowc == null || !nowc.equals("2"))){
						out.println("<font class='subtitle10'><b>E-RAPID FACTORY WORK COPY</b></font>");
					}
					else{
						out.println("<font class='subtitle10'><b>E-RAPID ORDER ENTRY</b></font>");
					}
					String psa_pid="";
					Vector psa_role_type_id=new Vector();Vector psa_acct_lookup_id=new Vector();Vector psa_quote_stps=new Vector();
					String spec_rep_acct_id="";String terr_rep_acct_id="";String arch_acct_id="";String order_rep_acct_id="";// for different accounts
					String project_id="";String Project_city="";String provider_id="";String Project_state="";
					String quoted_account="";String Arch_state="";
					//quotation table
					// out.println("PSA"+project_type_id);

					String spec_section="";String quote_type="";String specified="";String estimator="";String rsm="";String addenda="";String alternate="";
					String exclusion="";String notes="";String tier="";String spec_section_level="";String qregion="";
					//out.println(project_type_id+" id<BR>"+"qid"+project_type_id);
							ResultSet rs_psa_quotation = stmt_psa.executeQuery("SELECT * FROM dba.quotation where quote_id like '"+project_type_id+"'");
							if (rs_psa_quotation !=null) {
							while (rs_psa_quotation.next()) {
									//out.println("here!!!<BR>");
										psa_pid= rs_psa_quotation.getString("project_id");
										estimator= rs_psa_quotation.getString("creator_id");
										spec_section= rs_psa_quotation.getString("SPEC_SECTION_M");
										spec_section_level= rs_psa_quotation.getString("spec_level");
					//					out.println("<font size='1'>"+spec_section_level+" Here</font><BR>");
										quote_type= rs_psa_quotation.getString("quote_type");
										specified= rs_psa_quotation.getString("specified");
									    rsm= rs_psa_quotation.getString("RSM");
									    qregion= rs_psa_quotation.getString("quote_region");
										addenda= rs_psa_quotation.getString("addenda");
										alternate= rs_psa_quotation.getString("alternate_t");
										exclusion= rs_psa_quotation.getString("exclusion");
										notes= rs_psa_quotation.getString("notes");
										tier= rs_psa_quotation.getString("tier");
										edate= rs_psa_quotation.getString("mbid_date");
					//					out.println("eda"+edate);
								}
							}
							rs_psa_quotation.close();
					//		out.println(psa_pid+" here<br>");

					if((spec_section==null)){spec_section="";}
					if((spec_section_level==null)){spec_section_level="";}
					if((addenda ==null)){addenda ="";}
					if((alternate==null)){alternate="";}
					if((notes ==null)){notes ="";}
					if((exclusion ==null)){exclusion ="";}


					if(spec_section != null){
					for(int rr=0; rr<spec_section.length(); rr++){
						if((int)spec_section.charAt(rr)==10){
							spec_section=spec_section.substring(0,rr)+"<BR>"+spec_section.substring(rr);
							rr=rr+4;
						}
					}
					}
					if(addenda != null){
					for(int rr=0; rr<addenda.length(); rr++){
						if((int)addenda.charAt(rr)==10){
							addenda=addenda.substring(0,rr)+"<BR>"+addenda.substring(rr);
							rr=rr+4;
						}
					}
					}
					if(notes != null){
					for(int rr=0; rr<notes.length(); rr++){
						if((int)notes.charAt(rr)==10){
							notes=notes.substring(0,rr)+"<BR>"+notes.substring(rr);
							rr=rr+4;
						}
					}
					}
					if(exclusion != null){
					for(int rr=0; rr<exclusion.length(); rr++){
						if((int)exclusion.charAt(rr)==10){
							exclusion=exclusion.substring(0,rr)+"<BR>"+exclusion.substring(rr);
							rr=rr+4;
						}
					}
					}
					Vector role=new Vector();
					Vector role_class=new Vector();
					ResultSet rs_role_mapping=stmt.executeQuery("select * from cs_psa_role_mapping where sbu in ('"+product+"')");
					if(rs_role_mapping != null){
						while(rs_role_mapping.next()){
							role.addElement(rs_role_mapping.getString("role"));
							role_class.addElement(rs_role_mapping.getString("role_class"));
						}
					}
					rs_role_mapping.close();
					//	out.println("::<BR>");
							Vector sbu_order_rep_acct_id=new Vector();
							boolean sbuSpecificArch=false;
							boolean sbuSpecificTerr=false;
							boolean sbuSpecificSpec=false;
							boolean sbuSpecificOrder=false;
							ResultSet rs_psa_proj_ac_link = stmt_psa.executeQuery("SELECT * FROM dba.proj_ac_link where project_id like '"+psa_pid+"' order by link_id");
							if (rs_psa_proj_ac_link !=null) {
							while (rs_psa_proj_ac_link.next()) {
					//					psa_acct_lookup_id.addElement(rs_psa_proj_ac_link.getString("aclookup_id"));
					//					psa_role_type_id.addElement(rs_psa_proj_ac_link.getString("role_type_id"));
										project_id=	rs_psa_proj_ac_link.getString("project_id");
										//out.println(rs_psa_proj_ac_link.getString("role_type_id")+":::"+rs_psa_proj_ac_link.getString("aclookup_id")+"::<BR>");
										for(int i=0; i<role.size(); i++){
											if(role_class.elementAt(i).toString().equals("2")){
												if(rs_psa_proj_ac_link.getString("role_type_id").equals(role.elementAt(i).toString())){
													arch_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");
													sbuSpecificArch=true;
												}
											}
											else{
												if(!sbuSpecificArch&&rs_psa_proj_ac_link.getString("role_type_id").equals("2")){
													arch_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");
												}
											}

											if(role_class.elementAt(i).toString().equals("8")){
												if(rs_psa_proj_ac_link.getString("role_type_id").equals(role.elementAt(i).toString())){
													terr_rep_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");
													sbuSpecificTerr=true;
												}
											}
											else{
												if(!sbuSpecificTerr&&rs_psa_proj_ac_link.getString("role_type_id").equals("8")){
													terr_rep_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");
												}
											}
											if(role_class.elementAt(i).toString().equals("7")){
												if(rs_psa_proj_ac_link.getString("role_type_id").equals(role.elementAt(i).toString())){
													spec_rep_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");
													sbuSpecificSpec=true;
												}
											}
											else{
												if(!sbuSpecificSpec&&rs_psa_proj_ac_link.getString("role_type_id").equals("7")){
													spec_rep_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");
												}
											}
											if(role_class.elementAt(i).toString().equals("35")){
												if(rs_psa_proj_ac_link.getString("role_type_id").equals(role.elementAt(i).toString())){
													//out.println(order_rep_acct_id+"::"+role.elementAt(i).toString()+"::<BR>");
													sbu_order_rep_acct_id.addElement(rs_psa_proj_ac_link.getString("aclookup_id"));
													sbuSpecificOrder=true;
												}
											}
											else{
												if(!sbuSpecificOrder&&rs_psa_proj_ac_link.getString("role_type_id").equals("35")){
													order_rep_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");
												}
											}
										}

								}
							}
							rs_psa_proj_ac_link.close();
							ResultSet rs_psa_project = stmt_psa.executeQuery("SELECT * FROM dba.project where project_id like '"+project_id+"'");
							if (rs_psa_project !=null) {
							while (rs_psa_project.next()) {
										Project_name=rs_psa_project.getString("project_title");
										Project_city=rs_psa_project.getString("site_town");
										Project_state=rs_psa_project.getString("site_county");
										provider_id=rs_psa_project.getString("provider_pl_id");
								}
							}
							rs_psa_project.close();
							ResultSet rs_psa_quote_lines = stmt_psa.executeQuery("select substring(note,CHARINDEX(':', note)+1) FROM dba.STANDARD_PARAS where para_id in (select entity_id from dba.quote_lines where quote_id='"+project_type_id+"' and line_type='P') order by note;");
					//		SELECT * FROM dba.quote_lines where line_type='P' and quote_id like '"+project_type_id+"' ORDER BY LINE_ID
							if (rs_psa_quote_lines !=null) {
							while (rs_psa_quote_lines.next()) {
							 psa_quote_stps.addElement(rs_psa_quote_lines.getString(1));
								}
							}

					rs_psa_quote_lines.close();

					//erritory Rep
					//Spec Rep
					//out.println(psa_pid+" arch"+arch_acct_id+"terr"+terr_rep_acct_id+"spec"+spec_rep_acct_id);

					%>

				</td></tr>
		</table>
		<table cellspacing='0' cellpadding='0' border='0' width='100%'>
			<tr>
				<%
				if(product.equals("ADS")){
				%>
				<td width='55%' valign='top' rowspan='4' nowrap class='mainbody'>

					<%

				}
				else{
					%>
				<td width='55%' valign='top' rowspan='3' nowrap class='mainbody'>

					<%
				}
					%>

					<table border='0' cellspacing='0' cellpadding='0'>
						<%
						if(!(terr_rep_acct_id==null)){
							if(terr_rep_acct_id.trim().length()>0){
								ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT * FROM dba.cs_rep where acct_id like '"+terr_rep_acct_id.trim()+"'");
									if (rs_psa_lookup !=null) {
									while (rs_psa_lookup.next()) {
												terr_rep_acct_id= rs_psa_lookup.getString(1);
										}
									}
								rs_psa_lookup.close();
							}
						}else{terr_rep_acct_id="";}
						if(product.equals("IWP")){
							out.println("<tr><td class='mainbody'>"+order_no+"</td><td>&nbsp;</td></tr>");
							out.println("<tr><td class='mainbody'>"+terr_rep_acct_id+"</td><td>&nbsp;</td></tr>");
						}

						%>
						<tr><td class='mainbodyh'><b>Customer:</b></td><td>&nbsp;</td></tr>
						<tr><td>&nbsp;</td>
							<td class='mainbody'>

								<%

								if(project_type_id != null && project_type_id.trim().length()>0){
									ResultSet rs_psa_account = stmt_psa.executeQuery("SELECT * FROM dba.quoted_accounts where quote_id like '"+project_type_id+"'");
										if (rs_psa_account !=null) {
										while (rs_psa_account.next()) {
													//quoted_account= rs_psa_account.getString(2);
											}
										}
										rs_psa_account.close();
								}

								if(quoted_account.trim().length()>0){
									ResultSet rs_psa_account = stmt_psa.executeQuery("SELECT acctname,addr2,town,county,postcode FROM dba.account where acct_id like '"+quoted_account+"'");
										if (rs_psa_account !=null) {
										while (rs_psa_account.next()) {
													cust_name1= rs_psa_account.getString(1);
													if(cust_name1==null){ cust_name1="";}
													cust_addr1= rs_psa_account.getString(2);
													if(cust_addr1==null){ cust_addr1="";}
													city= rs_psa_account.getString(3);
													if(city==null){ city="";}
													state= rs_psa_account.getString(4);
													if(state==null){ state="";}
													zip_code= rs_psa_account.getString(5);
													if(zip_code==null){ zip_code="";}
											}
										}
										rs_psa_account.close();

									if(cust_name1.trim().length()>0){out.println(cust_name1+"<br>");}
									if(cust_addr1.trim().length()>0){out.println(cust_addr1+"<br>");}
									//if(cust_addr2.trim().length()>0){out.println(cust_addr2+"<br>");}
								%>
								<%= city %>,&nbsp;<%= state %>&nbsp;<%= zip_code %>&nbsp;
								<%
								}

								%>
							</td>
						</tr>
					</table>
				</td>
				<%
				if(product.equals("ADS")){
				%>
				<td width='100%' valign='top' rowspan='4' class='mainbody'>&nbsp;</td>

				<%

			}
			else{
				%>
				<td width='100%' valign='top' rowspan='3' class='mainbody'>&nbsp;</td>

				<%
			}
				%>
				<td width='10%' valign='top' align='right' class='mainbody'><b>Quote No:</b></td>
				<td width='10%' valign='top' class='mainbody'><%= order_no %></td>
			</tr>
			<%
			//out.println(product);
			if(product.equals("ADS")){
			%>
			<tr>
				<td width='200' valign='top' align='right' nowrap class='mainbody'><b>User Name:</b></td>
				<td width='100' valign='top' nowrap class='mainbody'><%= adsusername %></td>
			</tr>
			<%
		}
			%>
			<tr>
				<td width='200' valign='top' align='right' nowrap class='mainbody'><b>Quote Date:</b></td>
				<td width='100' valign='top' nowrap class='mainbody'><%= odate %></td>
			</tr>
			<tr>
				<td width='200' valign='top' align='right' nowrap class='mainbody'><b>Bid Date:</b></td>
				<td width='100' valign='top' nowrap class='mainbody'><%= edate %></td>
			</tr>
		</table>
		<br>
		<table cellspacing='0' cellpadding='0' border='0' width='100%'>
			<tr><td nowrap valign='top' class='mainbodyh' width='5%'><b>Project:</b>&nbsp;</td>
				<td width='40%' nowrap valign='top' class='mainbody'><%= Project_name %><br></td>
				<td width='20%' rowspan='3'>&nbsp;</td>
				<td valign='top' width='20%' rowspan='3' nowrap class='mainbody'>
					<%
					if(rep_account==null){rep_account="";}
					if(address1==null){address1="";}
					if(address2==null){address2="";}
					if(rep_city==null){rep_city="";}
					if(rep_state==null){rep_state="";}
					if(rep_zip_code==null){rep_zip_code="";}
					if(rep_telephone==null){rep_telephone="";}
					if(rep_fax==null){rep_fax="";}
					if(rep_email==null){rep_email="";}
					%>
					&nbsp;<br></td>
			</tr>
			<%
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

			if(Project_city==null){Project_city="";}
			if(Project_state==null){Project_state="";}
			if(provider_id==null){provider_id="";}
			%>
			<tr><td valign='top' class='mainbodyh' width="5%"><b>Location:</b>&nbsp;</td>

				<td width='200' valign='top' class='mainbody'><%= Project_city %> <%= Project_state %></td>
				<td width='100'></td>
			</tr>
			<tr>
				<td valign='top'class='mainbodyh'><b>Architect:</b>&nbsp;</td>
				<td width='200' valign='top' class='mainbody'><%= Arch_name %><br><%= Arch_loc %>&nbsp;<%= Arch_state %></td>
				<td width='100'>&nbsp;</td>
			</tr>
			<%
			if(quote_typex==null){ quote_typex="";}
			if(quote_type_alt==null){ quote_type_alt="";}
			if(!product.equals("EJC")){
				String final_type="";
				//out.println(quote_typex+"::"+quote_type_alt+"<BR>");
				if(quote_typex.equals("E") && quote_type_alt.equals("dl")){
					final_type="Decolink";
				}
				else if(quote_typex.equals("E")){
					final_type="Deco";
				}
				else if(quote_typex.toUpperCase().equals("C")){
					final_type="CS";
				}
				if(final_type.trim().length()>0){
			%>
			<tr><td valign='top' class='mainbodyh'><b><%=final_type%></b>&nbsp;</td>
				<td width='100'></td>
			</tr>
			<%
		}
	}

			%>
		</table>
		<%
		if(!product.equals("ADS")&& (nowc == null || !nowc.equals("2"))){
		%>
		<br>
		<font class='mainbodyh'><B>QUOTE INFO ::</B><br><br></font>
		<table align ='center' cellspacing='0' cellpadding='0' border='0' width='94%'>
			<tr>
				<%
				if(!(quote_type==null)){
					if(quote_type.trim().length()>0){
						ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT * FROM dba.user_lookup where lookup_id like '"+quote_type.trim()+"'");
							if (rs_psa_lookup !=null) {
							while (rs_psa_lookup.next()) {
										quote_type= rs_psa_lookup.getString(3);
								}
							}
						rs_psa_lookup.close();
					}
				}else{quote_type="";}
				if(!(specified==null)){
					if(specified.trim().length()>0){
						ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT * FROM dba.user_lookup where lookup_id like '"+specified.trim()+"'");
							if (rs_psa_lookup !=null) {
							while (rs_psa_lookup.next()) {
										specified= rs_psa_lookup.getString(3);
								}
							}
						rs_psa_lookup.close();
					}
				}else{specified="";}
				//Teir
				if(!(tier==null)){
					if(tier.trim().length()>0){
						ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT * FROM dba.user_lookup where lookup_id like '"+tier.trim()+"'");
							if (rs_psa_lookup !=null) {
							while (rs_psa_lookup.next()) {
										tier= rs_psa_lookup.getString(3);
								}
							}
						rs_psa_lookup.close();
					}
				}else{tier="";}
				//spec_section_level
				if(!(spec_section_level==null)){
					if(spec_section_level.trim().length()>0){
						ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT * FROM dba.user_lookup where lookup_id like '"+spec_section_level.trim()+"'");
							if (rs_psa_lookup !=null) {
							while (rs_psa_lookup.next()) {
										spec_section_level= rs_psa_lookup.getString(3);
								}
							}
						rs_psa_lookup.close();
					}
				}else{spec_section_level="";}

				if(!(estimator==null)){
					if(estimator.trim().length()>0){
						ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT fullname FROM dba.sauser where sauser_id like '"+estimator.trim()+"'");
							if (rs_psa_lookup !=null) {
							while (rs_psa_lookup.next()) {
										estimator= rs_psa_lookup.getString(1);
								}
							}
						rs_psa_lookup.close();
					}
				}else{estimator="";}



				%>
				<td nowrap valign='top' class='mainbodyh'><b>Quote Type:</b>&nbsp;<%= quote_type %>&nbsp;&nbsp;<b>Tier:</b>&nbsp;<%= tier %></td>
				<td nowrap valign='top' class='mainbodyh'><b>Specified:</b>&nbsp;<%= specified %></td>
				<td nowrap valign='top' class='mainbodyh'><b>Spec Level:</b>&nbsp;<%=spec_section_level%></td>
				<td nowrap valign='top' class='mainbodyh'><b>Scan No:</b>&nbsp;<%= provider_id %></td>
				<td nowrap valign='top' class='mainbodyh'><b>Estimator:</b>&nbsp;<%= estimator %></td>
			</tr>
			<tr>
				<td Colspan='4' nowrap valign='top' class='mainbodyh'>&nbsp;</td>
			</tr>
		</table>
		<table width='100%' align ='center' cellspacing='0' cellpadding='0' border='0' >
			<tr>
				<%

				%>
				<td nowrap valign='top' class='mainbodyh'><b>Territory Rep:&nbsp;<%= terr_rep_acct_id %></b></td>

				<%
				if(!(spec_rep_acct_id==null)){
					if(spec_rep_acct_id.trim().length()>0){
						ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT * FROM dba.cs_rep where acct_id like '"+spec_rep_acct_id.trim()+"'");
							if (rs_psa_lookup !=null) {
							while (rs_psa_lookup.next()) {
										spec_rep_acct_id= rs_psa_lookup.getString(1);
								}
							}
						rs_psa_lookup.close();
					}
				}else{spec_rep_acct_id="";}
				%>
				<td nowrap valign='top' class='mainbodyh'><b>Spec Rep:&nbsp;<%= spec_rep_acct_id %></b></td>
				<%
				if(sbu_order_rep_acct_id.size()>0){
					order_rep_acct_id="";
					for(int i=0; i<sbu_order_rep_acct_id.size();i++){
						if(sbu_order_rep_acct_id.elementAt(i).toString().trim().length()>0){
							ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT * FROM dba.cs_rep where acct_id like '"+sbu_order_rep_acct_id.elementAt(i).toString()+"'");
								if (rs_psa_lookup !=null) {
								while (rs_psa_lookup.next()) {
											order_rep_acct_id= order_rep_acct_id+rs_psa_lookup.getString(1)+",";
									}
								}
							rs_psa_lookup.close();
						}

					}
					if(order_rep_acct_id!=null && order_rep_acct_id.endsWith(",")){
						order_rep_acct_id=order_rep_acct_id.substring(0,order_rep_acct_id.length()-1);
					}

				}
				else if(!(order_rep_acct_id==null)){
					if(order_rep_acct_id.trim().length()>0){
						ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT * FROM dba.cs_rep where acct_id like '"+order_rep_acct_id.trim()+"'");
							if (rs_psa_lookup !=null) {
							while (rs_psa_lookup.next()) {
										order_rep_acct_id= rs_psa_lookup.getString(1);
								}
							}
						rs_psa_lookup.close();
					}
				}
				else{
					order_rep_acct_id="";
				}

				%>
				<td nowrap valign='top' class='mainbodyh'><b>Copy Rep:&nbsp;<%= order_rep_acct_id %></b></td>
				<%
				if(!(rsm==null)){
					if(rsm.trim().length()>0){
						ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT * FROM dba.user_lookup where lookup_id like '"+rsm.trim()+"'");
							if (rs_psa_lookup !=null) {
							while (rs_psa_lookup.next()) {
										rsm= rs_psa_lookup.getString(3);
								}
							}
						rs_psa_lookup.close();
					}
				}else{rsm="";}

				if(!(qregion==null)){
					if(qregion.trim().length()>0){
						ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT * FROM dba.user_lookup where lookup_id like '"+qregion.trim()+"'");
							if (rs_psa_lookup !=null) {
							while (rs_psa_lookup.next()) {
										qregion= rs_psa_lookup.getString(3);
								}
							}
						rs_psa_lookup.close();
					}
				}else{qregion="";}


				%>
				<td nowrap valign='top' class='mainbodyh'><b>Region:</b>&nbsp;<%= qregion %></td>
				<td nowrap valign='top' class='mainbodyh'><b>RSM:</b>&nbsp;<%= rsm %></td>
			</tr>
		</table>

		<table align ='center' cellspacing='0' cellpadding='0' border='0' width='94%'>
			<tr>
			<tr><td nowrap valign='top' Colspan='4' class='mainbodyh'>&nbsp;</td></tr>
			<tr>
				<td nowrap valign='top' Colspan='4' class='mainbodyh'><b>Section:</b>&nbsp;<%= spec_section %></td>
			</tr>
			<tr><td nowrap valign='top' Colspan='4' class='mainbodyh'>&nbsp;</td></tr>
			<tr>
				<td nowrap valign='top' Colspan='4' class='mainbodyh'><b>Exclusions:</b><br></td>
					<%





					if(exc.trim().length()>0){
						if(exc.trim().substring(exc.trim().length()-1).equals(",")){
							//out.println(exc+"::1<BR>");
							exc=exc.trim().substring(0,exc.trim().length()-1);
							//out.println(exc+"::2<BR>");
						}
					}
					if(qual.trim().length()>0){
						if(qual.trim().substring(qual.trim().length()-1).equals(",")){
							//out.println(qual+"::1<BR>");
							qual=qual.trim().substring(0,qual.trim().length()-1);
							//out.println(qual+"::2<BR>");
						}
					}










					if (exc.trim().length()>0){
					ResultSet cs_qlf_notes = stmt.executeQuery("select description FROM cs_exc_notes where product_id='"+product+"' and code in ("+exc+") order by code ");
								if (cs_qlf_notes !=null) {
								while (cs_qlf_notes.next()) {
									out.println("<tr  width='90%'><td wrap valign='top' Colspan='4' class='mainbodyh'>"+cs_qlf_notes.getString("description")+"</td></tr>");
									}
								}
					cs_qlf_notes.close();
					}
					if(free_exc != null && free_exc.trim().length()>0){
						out.println("<tr width='90%'><td wrap valign='top' Colspan='4' class='mainbodyh'>"+free_exc+"</td></tr>");
					}
					//if(!(qual.trim().length()>0|exc.trim().length()>0)){
					if(psa_quote_stps.size()>0){
								for(int kl=0;kl<psa_quote_stps.size();kl++){
								out.println("<tr  width='90%'><td wrap valign='top' Colspan='4' class='mainbodyh'>"+psa_quote_stps.elementAt(kl).toString()+"</td></tr>");
								}
					}
					//}
					%>

			</tr>
			<tr><td nowrap valign='top' Colspan='4' class='mainbodyh'>&nbsp;</td></tr>
			<tr><td valign='top' Colspan='4' class='mainbodyh'><b>Addenda:</b>&nbsp;<%= addenda %></td>
			</tr>
			<tr><td nowrap valign='top' Colspan='4' class='mainbodyh'>&nbsp;</td></tr>
			<tr>
				<td valign='top' Colspan='4' class='mainbodyh'><b>Alternate:</b>&nbsp;<%= alternate %></td>
			</tr>
			<tr><td nowrap valign='top' Colspan='4' class='mainbodyh'>&nbsp;</td></tr>
			<tr>
				<%
				if(notes != null && notes.trim().length()>0){
					out.println("<td wrap valign='top' Colspan='4' class='mainbodyh'><b>Notes:</b>&nbsp;"+ notes +"<br>");
					if(era_notes != null && era_notes.trim().length()>0){
						out.println(era_notes);
					}
				out.println("</td></tr>");
				}
				else if(era_notes != null && era_notes.trim().length()>0){
					out.println("<td wrap valign='top' Colspan='4' class='mainbodyh'><b>Notes:</b>&nbsp;"+ era_notes +"</td></tr>");
				}
				else{
					out.println("<td wrap valign='top' Colspan='4' class='mainbodyh'><b>Notes:</b>&nbsp;</td></tr>");
				}
				if (qual.trim().length()>0){
				ResultSet cs_exc_notes = stmt.executeQuery("select description FROM cs_qlf_notes where product_id='"+product+"' and code in ("+qual+") order by code ");
						if (cs_exc_notes !=null) {
					while (cs_exc_notes.next()) {
						out.println("<tr width='90%'><td wrap valign='top' Colspan='4' class='mainbodyh'>"+cs_exc_notes.getString("description")+"</td></tr>");
													}
												}
				cs_exc_notes.close();
				}
				if(free_qual != null && free_qual.trim().length()>0){
					out.println("<tr width='90%'><td wrap valign='top' Colspan='4' class='mainbodyh'>"+free_qual+"</td></tr>");
				}
				%>
			</tr>
			<tr><td nowrap valign='top' Colspan='4' class='mainbodyh'>&nbsp;</td></tr>
			<tr>
				<td valign='top' Colspan='4' class='mainbodyh' ><b>Estimator Notes:</b>&nbsp;<%= exclusion %></td>
			</tr>
			<%
			String dnotes="";
			ResultSet rsdnotes=stmt.executeQuery("select line_no,descript from csquotes where order_no='"+order_no+"' and blocK_id='d_notes' order by cast(line_no as numeric)");
			if(rsdnotes != null){
				while(rsdnotes.next()){
					dnotes=dnotes+"<tr><td colspan='1' class='mainbodyh' >"+rsdnotes.getString(1)+"</td><td  colspan='3' class='mainbodyh' >"+rsdnotes.getString(2)+"</td></tr>";
				}
			}
			rsdnotes.close();
			if(dnotes.trim().length()>0){
				out.println("<tr><td nowrap valign='top' Colspan='4' class='mainbodyh'>&nbsp;</td></tr>");
				out.println("<tr><td  valign='top' Colspan='4' class='mainbodyh' ><b>Line Notes:</b></TD></TR><tr><td valign='top' Colspan='1' class='mainbodyh'>eRapid Line #</td><td valign='top' colspan='3' class='mainbodyh'>Notes</td></tr>");
				out.println(dnotes);
			}










			%>
		</table>
		<br>
		<%
	}
	stmt_psa.close();
	myConn_psa.close();

}
catch(Exception e){
	out.println("show_summary_header_psa_new.jsp ERROR::"+e);
}
		%>
