
<font class='mainbodyh'><B>QUOTE SUMMARY ::</B><br><br></font>
<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'>
	<tr height='20'>
		<td width='13%' bgcolor='#006600'><font class='schedule'><b>Mark</b></font></td>
		<td width='29%' bgcolor='#006600'><font class='schedule'><b>Model</b></font></td>
		<td width='12%' bgcolor='#006600'><font class='schedule'><b>Qty</b></font></td>
		<td width='6%' bgcolor='#006600'><font class='schedule'><b>Sections</b></font></td>
		<td width='10%' bgcolor='#006600'><font class='schedule'><b>Price</b></font></td>
		<td width='13%' bgcolor='#006600'><font class='schedule'><b>Size(w x l)</b></font></td>
		<td width='8%' bgcolor='#006600'><font class='schedule'><b>System Depth</b></font></td>
		<!--<td width='21%' bgcolor='#006600'><font class='schedule'><b>Price/sq ft<sup> *</sup></b></font></td>-->
		<td width='18%' bgcolor='#006600'><font class='schedule'><b>Commission </b></font></td>
		<td width='8%' bgcolor='#006600'><font class='schedule'><b>SQ.FT</b></font></td>
	</tr>
	<%

	for12.setMaximumFractionDigits(2);
	String dimension="";String area="";String stdcost="";String runcost="";String setupcost="";String sys_depth="";String sections="";
	double t_cost=0.0;String sqft="";String totwt1="";//double l_cost=0.0;
	//totals
	double tot_crate_wt=0;double tot_sqft=0;double tot_dol_sqft=0;
				for(int k=0;k<line;k++){
								String bgcolor="";
								if ((k%2)==1){bgcolor="#e4e4e4";}else {bgcolor="#EFEFDE";}
						//Getting the Area
						String config_s0 = config_string.elementAt(k).toString();
						int config_s1= config_s0.indexOf("AREA[");
						int config_s2=config_s0.indexOf("]",config_s1+1);
						area=config_s0.substring(config_s1+5,config_s2);
						//Getting the Area done

						//Getting the System Depth
						int nsdep=config_s0.indexOf("SYSDEPTH");
						if (nsdep >=0 ){
						int ns1=config_s0.indexOf("]",nsdep);
						sys_depth=config_s0.substring(nsdep+9,ns1);
	//					out.println("<td align='center' class='tdt' width='10%'>"+((new Float(sys_depth)).intValue())+"</td>");
						}
						else{
						sys_depth=" ";
	//					out.println("<td align='center' class='tdt' width='10%'>"+sys_depth+"</td>");
					    }
						//Getting the System Depth Done
						//Getting the Sections
						int nssec=config_s0.indexOf(",SECTS[");
						if (nssec >=0 ){
						int ns1=config_s0.indexOf("]",nssec);
						sections=config_s0.substring(nssec+7,ns1);
						}
						else{
						sections="0";
					    }
						//Getting the Sections
						//Getting the SQFT
						int nssqft=config_s0.indexOf(",TOTLVRSF[");
						if (nssqft >=0 ){
						int ns1=config_s0.indexOf("]",nssqft);
						sqft=config_s0.substring(nssqft+10,ns1);
						BigDecimal d1 = new BigDecimal(sqft);
						tot_sqft=tot_sqft+d1.doubleValue();
						}
						else{
						sqft="0";
						tot_sqft=tot_sqft+0;
					    }
						//Getting the SQFT
						//Getting the Weight
						int nswt=config_s0.indexOf(",TOTWT[");
						if (nswt >=0 ){
						int ns1=config_s0.indexOf("]",nswt);
						totwt1=config_s0.substring(nswt+7,ns1);
	//					out.println("the totwt"+totwt1);
						BigDecimal d1 = new BigDecimal(totwt1);
						tot_crate_wt=tot_crate_wt+d1.doubleValue();
						}
						else{
						totwt1="0";
						tot_crate_wt=tot_crate_wt+0;
					    }
						//Getting the Weight Done
					   for (int mn=0;mn<line_item.size();mn++){

							if ((line_item.elementAt(mn).toString()).equals((items.elementAt(k).toString()))){
								String totwt=price.elementAt(mn).toString();//Extended_Price
								String fact=fact_per.elementAt(mn).toString().trim();//FIELD
								quan=QTY.elementAt(mn).toString();//QTY
								if ((fact.equals(""))){fact="0.0"; }
								if ((block_id.elementAt(mn).toString()).equals("A_APRODUCT")){
								description=(desc.elementAt(mn)).toString();
								mark=(mark_no.elementAt(mn)).toString();
						// total price for lvr
								stdcost=std_cost.elementAt(mn).toString();
								runcost=run_cost.elementAt(mn).toString();
								setupcost=setup_cost1.elementAt(mn).toString();
	//							out.println("THe stdcost"+stdcost+"THe runcost"+runcost+"THe setupcost"+setupcost);
								BigDecimal d1 = new BigDecimal(stdcost);
								BigDecimal d2 = new BigDecimal(runcost);
								BigDecimal d3 = new BigDecimal(setupcost);
							    double l_cost1=d1.doubleValue()+d2.doubleValue()+d3.doubleValue();
	//							out.println("THe total costs: "+l_cost1);

								t_cost=d1.doubleValue()+d2.doubleValue()+d3.doubleValue()+(l_cost/line);
	//out.println("THe total costs w/layout"+t_cost+"::"+stdcost+"::"+runcost+"::"+setupcost+" layout"+(l_cost/line)+"<br>");
	//out.println(l_cost+"::"+t_cost+"::"+l_cost1+"::"+sp_factor+"<BR>");


								//switched by Greg.  July 3/07 to match the pricing on the quotes.
								totprice=t_cost/sp_factor;
//totprice=new Double(totwt).doubleValue();
								//totprice=l_cost/sp_factor;





								//out.println(totprice+"::<BR>");
								//For Hawai Rep add an freight to the cost price of 1.15 by John Oct18'04
								// added back in aug 30/07 by Greg as per ACOSMA and TOM SZ
								if (rep_no.equals("147")||rep_no.equals("351")){
									//out.println("Hawai"+totprice);
									totprice=totprice*1.20;
									// add extra 15% to the cost price.
									//out.println("Hawai"+totprice);
								}//hawai rep
								totprice_dis=totprice_dis+totprice;
								//out.println("THe totprice"+totprice);
	//						    factor = (((totprice+(new Double(overage).doubleValue())+(new Double(freight_cost).doubleValue()))*0.91)*new Double(commission).doubleValue())/100;// total comission dollars for the line
	//						    factor = (((totprice+(new Double(freight_cost).doubleValue()))*0.91)*new Double(commission).doubleValue())/100;// total comission dollars for the line
								// john made this change of taking the extra charges out of  the comission dollars on Sep30'04
							    factor = ((totprice*0.91)*new Double(commission).doubleValue())/100;// total comission dollars for the line
								totcomm_dol=totcomm_dol+factor;
						   }
								if ((block_id.elementAt(mn).toString()).endsWith("PRICES")){
									String field_16=(fact_per.elementAt(mn)).toString().trim();
									if (prio.equals("E")){
									BigDecimal d4 = new BigDecimal(field_16);
									com_perc=((d4.doubleValue()*100));
									}
									else{
									BigDecimal d4 = new BigDecimal(field_16);
									BigDecimal d6 = new BigDecimal("0.91");
									BigDecimal d5 = d4.divide(d6,0);
									com_perc=((d5.doubleValue()*100));
									}
						   }
								//DIMENSIONS
								if ((block_id.elementAt(mn).toString()).equals("E_DIM")){
								String dim=(desc.elementAt(mn)).toString();
								int n_s=dim.indexOf("@");
								dimension=dim.substring(0,n_s);
																			   }
								//End of Dimensions
							}
					   }

	//		double price_sqft= totprice/new Double(area).doubleValue();
		out.println("<tr><td width='13%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+mark+"</td>");
		out.println("<td width='29%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+description+"</td>");
		out.println("<td valign='top' width='12%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+quan+"</td>");
		out.println("<td valign='top' width='6%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for12.format(new Double(sections).doubleValue())+"</td>");
		out.println("<td valign='top' width='10%' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+for1.format(totprice)+"</td>");
		out.println("<td valign='top' width='13%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+dimension+"</td>");
		out.println("<td valign='top' width='8%' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+for12.format(new Double(sys_depth).doubleValue())+"</td>");
	//	out.println("<td valign='top' width='19%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+"&nbsp;"+for1.format(totprice/new Double(area).doubleValue())+"</td>");
		out.println("<td valign='top' width='18%'bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+for1.format(factor)+"</td>");
		out.println("<td valign='top' width='8%'bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+for12.format(new Double(sqft).doubleValue())+"</td>");
		out.println("</tr>");

	factor=0;totprice=0;area="";sys_depth="";sqft="";sections="";
			}
out.println("</table>");
	// calcuclating the extra charge commission dollars		from john
	totcomm_dol=totcomm_dol+((( (new Double(freight_cost).doubleValue()) )*0.91)*new Double(commission).doubleValue())/100;
//out.println(totprice_dis+"::"+overage+"::"+handling_cost+":::"+setup_cost+":::"+freight_cost);
	double totprice_dis1=totprice_dis+(new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(setup_cost).doubleValue())+(new Double(freight_cost).doubleValue());
	//for12.setMaximumFractionDigits(1);
	%>

	<br><br>
	<!--// The new block for showing the extra info added on Oct-14'04 as per John-->
	<font class='mainbodyh'><B>JOB SUMMARY ::</B><br><br></font>
	<table cellspacing='0' align='center' cellpadding='1' border='0' width='75%' class='tableline'>
		<tr>
			<td class='schedule1'>xTotal Crated Weight:<b>&nbsp;<%=for12.format(tot_crate_wt*1.2)%></b></td>
			<td class='schedule1'>Total SQFT:<b>&nbsp;<%=for12.format(tot_sqft) %></b></td>
		</tr>
		<tr><td class='schedule1' colspan='2'>&nbsp;</td></tr>
		<tr>
			<td class='schedule1'>Total $/SQFT:<b>&nbsp;<%=for1.format(totprice_dis1/tot_sqft) %></b></td>
			<% if(!(group.toUpperCase().startsWith("REP"))){ %>
			<td class='schedule1'>Yield:<b>&nbsp;<%=for1.format(totprice_dis1/(tot_crate_wt*1.2)) %></b></td>
			<%}
			else{
			out.println("<td class='schedule1'>&nbsp;</td>");
			}
			%>
		</tr>
	</table>
	<br><br>
	<%
	for12.setMaximumFractionDigits(1);

	%>

