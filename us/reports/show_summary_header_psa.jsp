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
	<%
	try{
	%>
	<body bgcolor="white" topmargin="25" leftmargin="25" bgcolor="white" marginheight="0" marginwidth="0">
		<table cellspacing='0' cellpadding='0' border='0' width='100%'>
			<tr><td align='left'><img src='http://csimages.c-sgroup.com/eRapid/cs_logo.jpg' alt='CS Logo'></td></tr>
			<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC.</b><br><br>
					<%@ include file="../../db_con_psa.jsp"%>
					<%
					out.println("<font class='subtitle10'><b>E-RAPID FACTORY WORK COPY</b></font>");
					String psa_pid="";
					Vector psa_role_type_id=new Vector();Vector psa_acct_lookup_id=new Vector();Vector psa_quote_stps=new Vector();
					String spec_rep_acct_id="";String terr_rep_acct_id="";String arch_acct_id="";String order_rep_acct_id="";// for different accounts
					String project_id="";String Project_city="";String provider_id="";String Project_state="";
					String quoted_account="";String Arch_state="";
					//quotation table
					// out.println("PSA"+project_type_id);
					String spec_section="";String quote_type="";String specified="";String estimator="";String rsm="";String addenda="";String alternate="";
					String exclusion="";String notes="";String tier="";
					//out.println(project_type_id+" id<BR>");
							ResultSet rs_psa_quotation = stmt_psa.executeQuery("SELECT * FROM dba.quotation where quote_id like '"+project_type_id+"'");
							if (rs_psa_quotation !=null) {
							while (rs_psa_quotation.next()) {
									//out.println("here!!!<BR>");
										psa_pid= rs_psa_quotation.getString("project_id");
										estimator= rs_psa_quotation.getString("creator_id");
										spec_section= rs_psa_quotation.getString("SPEC_SECTION_M");
										//out.println("<font size='6'>"+spec_section+" Here</font><BR>");
										quote_type= rs_psa_quotation.getString("quote_type");
										specified= rs_psa_quotation.getString("specified");
									    rsm= rs_psa_quotation.getString("RSM");
										addenda= rs_psa_quotation.getString("addenda");
										alternate= rs_psa_quotation.getString("alternate_t");
										exclusion= rs_psa_quotation.getString("exclusion");
										notes= rs_psa_quotation.getString("notes");
										tier= rs_psa_quotation.getString("tier");
								}
							}
							rs_psa_quotation.close();
					//		out.println(psa_pid+" here<br>");

					if((spec_section==null)){spec_section="";}
					if((addenda ==null)){addenda ="";}
					if((alternate==null)){alternate="";}
					if((notes ==null)){notes ="";}
					if((exclusion ==null)){exclusion ="";}

							ResultSet rs_psa_proj_ac_link = stmt_psa.executeQuery("SELECT * FROM dba.proj_ac_link where project_id like '"+psa_pid+"' order by link_id");
							if (rs_psa_proj_ac_link !=null) {
							while (rs_psa_proj_ac_link.next()) {
					//					psa_acct_lookup_id.addElement(rs_psa_proj_ac_link.getString("aclookup_id"));
					//					psa_role_type_id.addElement(rs_psa_proj_ac_link.getString("role_type_id"));
										project_id=	rs_psa_proj_ac_link.getString("project_id");
										if(rs_psa_proj_ac_link.getString("role_type_id").equals("2")){arch_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");}
										if(rs_psa_proj_ac_link.getString("role_type_id").equals("8")){terr_rep_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");}
										if(rs_psa_proj_ac_link.getString("role_type_id").equals("7")){spec_rep_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");}
										if(rs_psa_proj_ac_link.getString("role_type_id").equals("10")){order_rep_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");}
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
							ResultSet rs_psa_quote_lines = stmt_psa.executeQuery("SELECT * FROM dba.quote_lines where line_type='P' and quote_id like '"+project_type_id+"' ORDER BY LINE_ID");
							if (rs_psa_quote_lines !=null) {
							while (rs_psa_quote_lines.next()) {
							 psa_quote_stps.addElement(rs_psa_quote_lines.getString("entity_id"));
								}
							}

					rs_psa_quote_lines.close();
					// Territory Rep
					//Spec Rep
					//out.println(psa_pid+" arch"+arch_acct_id+"terr"+terr_rep_acct_id+"spec"+spec_rep_acct_id);
					%>

				</td></tr>
		</table>
		<table cellspacing='0' cellpadding='0' border='0' width='100%'>
			<tr>
				<td width='55%' valign='top' rowspan='3' nowrap class='mainbody'>
					<table border='0' cellspacing='0' cellpadding='0'>
						<tr><td class='mainbodyh'><b>Customer:</b></td><td>&nbsp;</td></tr>
						<tr><td>&nbsp;</td>
							<td class='mainbody'>

								<%
								if(project_type_id.trim().length()>0){
									ResultSet rs_psa_account = stmt_psa.executeQuery("SELECT * FROM dba.quoted_accounts where quote_id like '"+project_type_id+"'");
										if (rs_psa_account !=null) {
										while (rs_psa_account.next()) {
													quoted_account= rs_psa_account.getString(2);
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
									if(cust_addr2.trim().length()>0){out.println(cust_addr2+"<br>");}
								%>
								<%= city %>,&nbsp;<%= state %>&nbsp;<%= zip_code %>&nbsp;
								<%
								}

								%>
							</td>
						</tr>
					</table>
				</td>
				<td width='100%' valign='top' rowspan='3' class='mainbody'>&nbsp;</td>
				<td width='10%' valign='top' align='right' class='mainbody'><b>Quote No:</b></td>
				<td width='10%' valign='top' class='mainbody'><%= order_no %></td>
			</tr>
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
			<tr><td nowrap valign='top' class='mainbodyh'><b>Project:</b>&nbsp;</td>
				<td width='200' nowrap valign='top' class='mainbody'><%= Project_name %><br></td>
				<td width='100' rowspan='3'>&nbsp;</td>
				<td valign='top' width='300' rowspan='3' nowrap class='mainbody'>
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
			<tr><td valign='top' class='mainbodyh'><b>Location:</b>&nbsp;</td>

				<td width='200' valign='top' class='mainbody'><%= Project_city %> <%= Project_state %></td>
				<td width='100'></td>
			</tr>
			<tr>
				<td valign='top'class='mainbodyh'><b>Architect:</b>&nbsp;</td>
				<td width='200' valign='top' class='mainbody'><%= Arch_name %><br><%= Arch_loc %>&nbsp;<%= Arch_state %></td>
				<td width='100'>&nbsp;</td>
			</tr>
		</table>
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


				%>
				<td nowrap valign='top' class='mainbodyh'><b>Quote Type:</b>&nbsp;<%= quote_type %>&nbsp;&nbsp;<b>Tier:</b>&nbsp;<%= tier %></td>
				<td nowrap valign='top' class='mainbodyh'><b>Specified:</b>&nbsp;<%= specified %></td>
				<td nowrap valign='top' class='mainbodyh'><b>Scan No:</b>&nbsp;<%= provider_id %></td>
				<td nowrap valign='top' class='mainbodyh'><b>Estimator:</b>&nbsp;<%= estimator %></td>
			</tr>
			<tr>
				<td Colspan='4' nowrap valign='top' class='mainbodyh'>&nbsp;</td>
			</tr>
		</table>
		<table align ='center' cellspacing='0' cellpadding='0' border='0' width='94%'>
			<tr>
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

				if(!(order_rep_acct_id==null)){
					if(order_rep_acct_id.trim().length()>0){
						ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT * FROM dba.cs_rep where acct_id like '"+order_rep_acct_id.trim()+"'");
							if (rs_psa_lookup !=null) {
							while (rs_psa_lookup.next()) {
										order_rep_acct_id= rs_psa_lookup.getString(1);
								}
							}
						rs_psa_lookup.close();
					}
				}else{order_rep_acct_id="";}
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
				%>

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
				    if(psa_quote_stps.size()>0){
				    String stpas="";
				    for(int i=0;i<psa_quote_stps.size();i++){
						    ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT * FROM dba.STANDARD_PARAS where para_id like '"+psa_quote_stps.elementAt(i).toString()+"'");
							    if (rs_psa_lookup !=null) {
							    while (rs_psa_lookup.next()) {
								    stpas=rs_psa_lookup.getString(2);
								    int kj=stpas.indexOf(":");
								    out.println("<tr width='90%'>");
								    out.println("<td wrap valign='top' Colspan='4' class='mainbodyh'>");
								    out.println( stpas.substring(kj+1,stpas.length())+"</td>");
								    out.println("</tr>");
								    }
							    }
						    rs_psa_lookup.close();
				    }
				    }
					%>

			</tr>
			<tr><td nowrap valign='top' Colspan='4' class='mainbodyh'>&nbsp;</td></tr>
			<td nowrap valign='top' Colspan='4' class='mainbodyh'><b>Addenda:</b>&nbsp;<%= addenda %></td>
		</tr>
		<tr><td nowrap valign='top' Colspan='4' class='mainbodyh'>&nbsp;</td></tr>
		<tr>
			<td nowrap valign='top' Colspan='4' class='mainbodyh'><b>Alternate:</b>&nbsp;<%= alternate %></td>
		</tr>
		<tr><td nowrap valign='top' Colspan='4' class='mainbodyh'>&nbsp;</td></tr>
		<tr>
			<td wrap valign='top' Colspan='4' class='mainbodyh'><b>Notes:</b>&nbsp;<%= notes %></td>
		</tr>
		<tr><td nowrap valign='top' Colspan='4' class='mainbodyh'>&nbsp;</td></tr>
		<tr>
			<td nowrap valign='top' Colspan='4' class='mainbodyh'><b>Estimator Notes:</b>&nbsp;<%= exclusion %></td>
		</tr>
	</table>
	<br>
	<%
	stmt_psa.close();
	myConn_psa.close();


}
catch(Exception e){
	out.println("show_summary_header_psa_new.jsp ERROR::"+e);
}
	%>
