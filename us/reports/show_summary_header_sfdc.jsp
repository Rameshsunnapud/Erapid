<html>
	<head>
		<title>Quote No <%= order_no %></title>
		<style type="text/css">a
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
			<tr><td align='left'><img src='../../images/cs_logo_new.jpg' width='138' height='16' alt></td></tr>
					<%
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
					<%@ include file="../../db_con_sfdc.jsp"%>
					<%
					if(!product.equals("ADS")&& (nowc == null || !nowc.equals("2"))){
						out.println("<font class='subtitle10'><b>E-RAPID FACTORY WORK COPY</b></font>");
					}
					else{
						out.println("<font class='subtitle10'><b>E-RAPID ORDER ENTRY</b></font>");
					}
					String psa_pid="";
					Vector psa_role_type_id=new Vector();Vector psa_acct_lookup_id=new Vector();Vector psa_quote_stps=new Vector();
					String spec_rep_acct_id="";String terr_rep_acct_id="";String arch_acct_id="";String order_rep_acct_id="";
					String project_id="";String Project_city="";String provider_id="";String Project_state="";
					String quoted_account="";String Arch_state="";
					String spec_section="";String quote_type="";String specified="";String rsm="";String addenda="";String alternate="";
					String exclusion="";String notes="";String tier="";String spec_section_level="";String qregion="";
					String projectId="";
					String opportunityId="";
					String opportunityId2="";
					String typeOfQuote="";
					ResultSet rsSf0=stmt.executeQuery("select * from cs_project where order_no='"+order_no+"'");
					if(rsSf0 != null){
						while(rsSf0.next()){

							typeOfQuote=rsSf0.getString("sfdc_type");
							notes=rsSf0.getString("sfdc_notes");
							rsm=rsSf0.getString("rsm");
							qregion= rsSf0.getString("region");
							addenda= rsSf0.getString("addenda");
							alternate=rsSf0.getString("alternate");
							spec_section=rsSf0.getString("spec_section");
							quote_type=rsSf0.getString("sfdc_quote_type");
							//edate=rsSf0.getString("Bid_Date__c");
							opportunityId=rsSf0.getString("sfdc_opportunity_no");
							opportunityId2=rsSf0.getString("sfdc_opportunity_no");
							tier=rsSf0.getString("sfdc_ejc_valuation");
							exclusion=rsSf0.getString("estimator_notes");
							spec_section_level=rsSf0.getString("spec_level");
							specified=rsSf0.getString("sfdc_specified");

							Project_city=rsSf0.getString("sfdc_city");
							Project_state=rsSf0.getString("sfdc_state");
							provider_id=rsSf0.getString("sfdc_provider");
							terr_rep_acct_id=rsSf0.getString("territory_rep");
							spec_rep_acct_id=rsSf0.getString("spec_rep");
							order_rep_acct_id=rsSf0.getString("order_rep");

						}
					}
					rsSf0.close();

if(addenda== null||addenda.equals("null")){
	addenda="";
}
if(alternate== null||alternate.equals("null")){
	alternate="";
}
if(spec_section== null||spec_section.equals("null")){
	spec_section="";
}
if(quote_type== null||quote_type.equals("null")){
	quote_type="";
}
if(opportunityId== null||opportunityId.equals("null")){
	opportunityId="";
}
if(opportunityId2== null||opportunityId2.equals("null")){
	opportunityId2="";
}
if(tier== null||tier.equals("null")){
	tier="";
}
if(exclusion== null||exclusion.equals("null")){
	exclusion="";
}
if(spec_section_level== null||spec_section_level.equals("null")){
	spec_section_level="";
}
if(specified== null||specified.equals("null")){
	specified="";
}
if(Project_city== null||Project_city.equals("null")){
	Project_city="";
}
if(Project_state== null||Project_state.equals("null")){
	Project_state="";
}
if(provider_id== null||provider_id.equals("null")){
	provider_id="";
}
if(terr_rep_acct_id== null||terr_rep_acct_id.equals("null")){
	terr_rep_acct_id="";
}
if(spec_rep_acct_id== null||spec_rep_acct_id.equals("null")){
	spec_rep_acct_id="";
}
if(order_rep_acct_id== null||order_rep_acct_id.equals("null")){
	order_rep_acct_id="";
}
if(notes== null||notes.equals("null")){
	notes="";
}
/*
					ResultSet rsSf0=stmt_sfdc.executeQuery("select * from Quotes__c where name='"+project_type_id+"'");
					if(rsSf0 != null){
						while(rsSf0.next()){

							typeOfQuote=rsSf0.getString("Type_of_quote__c");
							notes=rsSf0.getString("Notes__C");
							projectId=rsSf0.getString("Project__c");
							rsm=rsSf0.getString("Regional_Sales_Manager__c");
							qregion= rsSf0.getString("Region__c");
							addenda= rsSf0.getString("Addenda__c");
							alternate=rsSf0.getString("Alternate__c");
							spec_section=rsSf0.getString("Spec_section__c");
							quote_type=rsSf0.getString("Quote_Type__c");
							edate=rsSf0.getString("Bid_Date__c");
							opportunityId=rsSf0.getString("C_S_Opportunity__c");
							opportunityId2=rsSf0.getString("Opportunity_Id__c");
							tier=rsSf0.getString("EJC_Valuation__c");
							exclusion=rsSf0.getString("Estimator_notes__C");
						}
					}
					rsSf0.close();
*/
					if(rsm==null || rsm.equals("null")){
						rsm="";
					}
					if(edate==null || edate.equals("null")){
						edate="";
					}
					if(opportunityId2==null || opportunityId2.equals("null")){
						opportunityId2="";
					}
					if(edate != null && edate.length()>10){
						edate=edate.substring(0,10);
					}
					if(tier==null||tier.equals("null")){
						tier="";
					}
/*
					ResultSet rsSf2=stmt_sfdc.executeQuery("select Specification_Level__c,Competition_Specified__c,name from C_S_Opportunity__c where id='"+opportunityId+"'");
					if(rsSf2 != null){
						while(rsSf2.next()){
							spec_section_level=rsSf2.getString(1);
							specified=rsSf2.getString(2);
							opportunityId2=rsSf2.getString(3);
						}
					}
					rsSf2.close();
*/
					if(specified==null||specified.equals("null")){
						specified="";
					}
					if(opportunityId2==null || opportunityId2.equals("null")){
						opportunityId2="";
					}
/*
					ResultSet rsSf3=stmt_sfdc.executeQuery("select account_role__c,C_S_Rep_Agent_No__c from opp_related_accounts__c where  c_s_opportunity__c='"+opportunityId+"'");
					if(rsSf3 != null){
						while(rsSf3.next()){
							//out.println(rsSf3.getString(1)+"::<BR>");
							if(rsSf3.getString(1)!=null && rsSf3.getString(1).equals("Representative - Territory")){
								terr_rep_acct_id=rsSf3.getString(2);
							}
							if(rsSf3.getString(1)!=null && rsSf3.getString(1).equals("Representative - Specification")){
								spec_rep_acct_id=rsSf3.getString(2);
							}
							if(rsSf3.getString(1)!=null && rsSf3.getString(1).endsWith("Representative - Copy")){
								order_rep_acct_id=order_rep_acct_id.trim()+" "+rsSf3.getString(2);
							}
						}
					}
					rsSf3.close();
*/
					if(terr_rep_acct_id==null){
						terr_rep_acct_id="";
					}
					if(spec_rep_acct_id==null){
						spec_rep_acct_id="";
					}
					if(order_rep_acct_id==null){
						order_rep_acct_id="";
					}
					else{
						order_rep_acct_id=order_rep_acct_id.replaceAll(" ",",");
					}
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

							Vector sbu_order_rep_acct_id=new Vector();
							boolean sbuSpecificArch=false;
							boolean sbuSpecificTerr=false;
							boolean sbuSpecificSpec=false;
							boolean sbuSpecificOrder=false;

/*
							ResultSet rsSf1=stmt_sfdc.executeQuery("select * from Project__c where id='"+projectId+"'");
							if(rsSf1 != null){
								while(rsSf1.next()){
									Project_city=rsSf1.getString("City_Town__c");
									Project_state=rsSf1.getString("State_Province__c");
									//Project_name=rsSf1.getString("Name");
									provider_id=rsSf1.getString("Lead_Provider_id__c");

								}
							}
							rsSf1.close();

*/


















					%>

				</td></tr>
		</table>
		<table cellspacing='0' cellpadding='0' border='0' width='100%'>
			<tr>
				<%
				if(product.equals("ADS")){
				%>
				<td width='55%' valign='top' rowspan='8' nowrap class='mainbody'>

					<%

				}
				else{
					%>
				<td width='55%' valign='top' rowspan='7' nowrap class='mainbody'>

					<%
				}
					%>

					<table border='0' cellspacing='0' cellpadding='0'>
						<%

						if(product.equals("IWP")){
							out.println("<tr><td class='mainbody'>"+opportunityId2+"</td><td>&nbsp;</td></tr>");
							out.println("<tr><td class='mainbody'>"+order_no+"</td><td>&nbsp;</td></tr>");
							out.println("<tr><td class='mainbody'>"+terr_rep_acct_id+"</td><td>&nbsp;</td></tr>");
						}

						%>
						<tr><td class='mainbodyh' valign='top'><b>Customer :</b></td>
							<td class='mainbody'>

								<%
								String accountName="";

								ResultSet rsSf=stmt_sfdc.executeQuery("select * from contact where id='"+cust_no+"'");
								if(rsSf != null){
									while(rsSf.next()){
										accountName=rsSf.getString("account_name__c");
										if(rsSf.getString("name")!=null && !rsSf.getString("name").equals("null") && rsSf.getString("name").trim().length()>0){
											cust_name1=rsSf.getString("name")+"";
										}
										if(rsSf.getString("Street_Name__c")!=null && !rsSf.getString("Street_Name__c").equals("null") && rsSf.getString("Street_Name__c").trim().length()>0){
											cust_addr1=rsSf.getString("Street_Name__c")+"";
										}
										if(rsSf.getString("City_or_Town__c")!=null && !rsSf.getString("City_or_Town__c").equals("null") && rsSf.getString("City_or_Town__c").trim().length()>0){
											city=rsSf.getString("City_or_Town__c")+",";
										}
										if(rsSf.getString("State_or_Province__c")!=null && !rsSf.getString("State_or_Province__c").equals("null") && rsSf.getString("State_or_Province__c").trim().length()>0){
											state=rsSf.getString("State_or_Province__c")+" ";
										}
										if(rsSf.getString("Postal_Code_or_Zip_Code__c")!=null && !rsSf.getString("Postal_Code_or_Zip_Code__c").equals("null") && rsSf.getString("Postal_Code_or_Zip_Code__c").trim().length()>0){
											zip_code=rsSf.getString("Postal_Code_or_Zip_Code__c")+" ";
										}


									}
								}
								rsSf.close();
								if(accountName==null){ accountName="";}
								if(cust_name1==null){ cust_name1="";}
								if(cust_addr1==null){ cust_addr1="";}
								if(city==null){ city="";}
								if(state==null){ state="";}
								if(zip_code==null){ zip_code="";}
								if(accountName.trim().length()>0){out.println(accountName+"<br>");}
								if(cust_name1.trim().length()>0){out.println(cust_name1+"<br>");}
								if(cust_addr1.trim().length()>0){out.println(cust_addr1+"<br>");}
								%>
								<%= city %>&nbsp;<%= state %>&nbsp;<%= zip_code %>&nbsp;
								<%


								%>
							</td>
						</tr>
					</table>
				</td>
				<%
				if(product.equals("ADS")){
				%>
				<td width='100%' valign='top' rowspan='8' class='mainbody'>&nbsp;</td>

				<%

			}
			else{
				%>
				<td width='100%' valign='top' rowspan='7' class='mainbody'>&nbsp;</td>

				<%
			}
				%>

				<td width='10%' valign='top' align='right' class='mainbody'><b>Quote No:</b></td>
				<td width='10%' valign='top' class='mainbody'><%= order_no %></td>
			</tr>
			<tr>
				<td width='10%' valign='top' align='right' class='mainbody'><b>Opportunity No:</b></td>
				<td width='10%' valign='top' class='mainbody'><%= opportunityId2%></td>
			</tr>
			<%

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
			<tr>
				<td width='200' valign='top' align='right' nowrap class='mainbody'>&nbsp;</td>
				<td width='100' valign='top' nowrap class='mainbody'>&nbsp;</td>
			</tr>
			<tr>
				<td width='200' valign='top' align='right' nowrap class='mainbody'>&nbsp;</td>
				<td width='100' valign='top' nowrap class='mainbody'>&nbsp;</td>
			</tr>
			<tr>
				<td width='200' valign='top' align='right' nowrap class='mainbody'>&nbsp;</td>
				<td width='100' valign='top' nowrap class='mainbody'>&nbsp;</td>
			</tr>
		</table>
		<br>
		<table cellspacing='0' cellpadding='0' border='0' width='100%'>
			<tr><td nowrap valign='top' class='mainbodyh' width='100'><b>Project:</b>&nbsp;</td>
				<td width='500' nowrap valign='top' class='mainbody'><%= Project_name %><br></td>
				<td width='100' rowspan='3'>&nbsp;</td>
				<td valign='top' rowspan='3' nowrap class='mainbody'>
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
					if(Arch_name==null||Arch_name.equals("null")){Arch_name="";}
					if(Arch_loc==null||Arch_loc.equals("null")){Arch_loc="";}
					if(Arch_state==null||Arch_state.equals("null")){Arch_state="";}
					%>
					&nbsp;<br></td>
			</tr>
			<%

			if(Project_city==null){Project_city="";}
			if(Project_state==null){Project_state="";}
			if(provider_id==null){provider_id="";}
			%>
			<tr><td valign='top' class='mainbodyh'><b>Location:</b>&nbsp;</td>

				<td width='200' valign='top' class='mainbody'><%= Project_city %> <%= Project_state %></td>
				<td width='100%'></td>
			</tr>
			<tr>
				<td valign='top'class='mainbodyh'><b>Architect:</b>&nbsp;</td>
				<td width='200' valign='top' class='mainbody'><%= Arch_name %><br><%= Arch_loc %>&nbsp;<%= Arch_state %></td>
				<td width='100%'>&nbsp;</td>
			</tr>
			<%
			if(quote_typex==null){ quote_typex="";}
			if(quote_type_alt==null){ quote_type_alt="";}
			if(!product.equals("EJC")){
				String final_type="";

				if(quote_typex.equals("E") && quote_type_alt.equals("dl")){
					final_type="Decolink";
				}
				else if(quote_typex.equals("E")){
					if(product.equals("EJC")){
						final_type="Restofit";
					}
					else{
						final_type="Facility Sales";
					}
				}
				else if(quote_typex.equals("D")){
					final_type="Eldercare";
				}
				else if(quote_typex.toUpperCase().equals("C")){
					final_type="CS";
				}
				if(final_type.trim().length()>0){
			%>
			<tr><td valign='top' class='mainbodyh'><b><%=final_type%></b>&nbsp;</td>
				<td width='100%'></td>
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


				%>
				<td width='20%' nowrap valign='top' class='mainbodyh'><b>Quote Type:</b>&nbsp;<%= quote_type %>&nbsp;&nbsp;<b>Tier:</b>&nbsp;<%= tier %></td>
				<!--<td width='20%' valign='top' class='mainbodyh'><b>Specified:</b>&nbsp;<%= specified %></td>-->
				<td width='20%' nowrap valign='top' class='mainbodyh'><b>Spec Level:</b>&nbsp;<%=spec_section_level%></td>
				<td width='20%' nowrap valign='top' class='mainbodyh'><b>Scan No:</b>&nbsp;<%= provider_id %></td>
				<td width='20%' nowrap valign='top' class='mainbodyh' colspan='2'><b>Estimator:</b>&nbsp;<%= estimator %></td>
			</tr>
			<tr>
				<td Colspan='4' nowrap valign='top' class='mainbodyh'>&nbsp;</td>
			</tr>
			<!-- </table>
			<table width='100%' align ='center' cellspacing='0' cellpadding='0' border='0' >-->
			<tr>
				<%
				if(product.equals("IWP")||product.equals("EJC"))   {
				%>
				<td nowrap valign='top' class='mainbodyh'><b>Type of Quote:&nbsp;</b><%= typeOfQuote %></td>
				<%

			}
				%>
				<td nowrap valign='top' class='mainbodyh'><b>Territory Rep:&nbsp;</b><%= terr_rep_acct_id %></td>

				<%

				%>
				<td nowrap valign='top' class='mainbodyh'><b>Spec Rep:&nbsp;</b><%= spec_rep_acct_id %></td>
				<%


				%>
				<td nowrap valign='top' class='mainbodyh'><b>Copy Rep:&nbsp;</b><%= order_rep_acct_id %></td>
				<%



				%>
				<td nowrap valign='top' class='mainbodyh'><b>Region:</b>&nbsp;<%= qregion %></td>
				<td nowrap valign='top' class='mainbodyh'><b>RSM:</b>&nbsp;<%= rsm %></td>
			</tr>
			<tr>
							<td Colspan='4' nowrap valign='top' class='mainbodyh'>&nbsp;</td>
			</tr>
			<tr>
			<td colspan='5' valign='top' class='mainbodyh'><b>Specified:</b>&nbsp;<%= specified %></td>
			</td>
		</table>

		<table align ='center' cellspacing='0' cellpadding='0' border='0' width='94%'>
			<tr>
			<tr><td nowrap valign='top' Colspan='4' class='mainbodyh'>&nbsp;</td></tr>
			<tr>
				<td nowrap valign='top' Colspan='4' class='mainbodyh'><b>Section:</b>&nbsp;<%= spec_section %></td>
			</tr>
			<tr><td nowrap valign='top' Colspan='4' class='mainbodyh'>&nbsp;</td></tr>
			<tr>
				<td nowrap valign='top' Colspan='4' class='mainbodyh'><b>Exclusions:</b><br></td></tr>
					<%
					if(exc.trim().length()>0){
						if(exc.trim().substring(exc.trim().length()-1).equals(",")){
							exc=exc.trim().substring(0,exc.trim().length()-1);
						}
					}
					if(qual.trim().length()>0){
						if(qual.trim().substring(qual.trim().length()-1).equals(",")){
							qual=qual.trim().substring(0,qual.trim().length()-1);
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
stmt_sfdc.close();
myConn_sfdc.close();
	%>
