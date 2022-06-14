<%

//Global
int tot_lines=0;double totprice=0;double factor=0.0;double totprice_dis=0;String description="",product_id="";
Vector QTY=new Vector();
Vector price=new Vector();
Vector line_item=new Vector();
Vector desc=new Vector();
Vector rec_no=new Vector();
Vector fact_per=new Vector();
Vector mark=new Vector();
Vector block_id=new Vector();
ArrayList<String> alist = null;
String sectionGroup = null; int count = 0;
TreeMap<Integer, String> section_lines = new TreeMap<Integer, String>();
Map<String, String> sectionGroupMap = new HashMap<String, String>();
Vector imp=new Vector();Vector run_cost=new Vector();Vector std_cost=new Vector();Vector setup_cost1=new Vector();
String quan="";
ResultSet rs3 = stmt.executeQuery("SELECT * FROM csquotes where order_no like '"+order_no+"' and Block_ID !='A_APRODUCT'  and cast(extended_price as numeric)>0 and product_id in('IWP','EJC') order by cast(Line_no as integer),block_id desc");
while (rs3.next()) {
	line_item.addElement(rs3.getString ("Line_no"));
	desc.addElement(rs3.getString ("Descript"));
	price.addElement(rs3.getString ("extended_price"));
	//out.println(rs3.getString("extended_price")+"::<BR>");
	QTY.addElement(rs3.getString("QTY"));
	rec_no.addElement(rs3.getString("Record_no"));
	block_id.addElement(rs3.getString("Block_ID"));
	fact_per.addElement(rs3.getString("field16"));
	mark.addElement(rs3.getString("field17"));
	run_cost.addElement(rs3.getString("run_cost"));
	std_cost.addElement(rs3.getString("std_cost"));
	setup_cost1.addElement(rs3.getString("setup_cost"));
	product_id=rs3.getString("product_id");
	tot_lines++;
}
rs3.close();
//invoking cs_quote_sections to get the transferred section lines
String sectionTransferValue = null;
String totalNumberOfSections = null;
ResultSet csQuotesSectionResultSet = stmt.executeQuery("SELECT sections,section_transfer, section_group from cs_quote_sections where order_no like '"+order_no+"'");
if (csQuotesSectionResultSet !=null) {
   while (csQuotesSectionResultSet.next()){
	   sectionGroup = csQuotesSectionResultSet.getString("section_group");
	   totalNumberOfSections=csQuotesSectionResultSet.getString("sections");
	   sectionTransferValue=csQuotesSectionResultSet.getString("section_transfer");
   }
}
csQuotesSectionResultSet.close();

String session_rep_no1="";String session_group="";
HttpSession UserSession_rep = request.getSession();
if(UserSession_rep!=null){
	if(UserSession_rep.getAttribute("rep_no") != null){
		session_rep_no1= UserSession_rep.getAttribute("rep_no").toString();
	}
	if(UserSession_rep.getAttribute("usergroup") != null){
		session_group= UserSession_rep.getAttribute("usergroup").toString();
	}
}
if(project_type != null &((project_type.equals("PSA")||project_type.equals("SFDC"))& userGroup.toUpperCase().startsWith("REP") )&&(userGroup==null || userGroup.toUpperCase().startsWith("REP"))){
	if(session_rep_no1==null||session_rep_no1.trim().length()<=0){
		session_rep_no1=rep_no;
		session_group="REP";
	}
}
if(session_rep_no1==null||session_rep_no1.trim().length()<=0){
	session_rep_no1=rep_no;
	session_group=email_rep_group;
}
if(tot_lines>0){

	out.println("<tr><td align='left' style='page-break-before: always;'><div id='sideHead'><p style='font-size:14px;color:black;margin-top:20px;font-stretch:expanded;'><b>"+product_id+" ORDER CONFIRMATION</b></p></div></td><td colspan='8' align='right' height='10%' class='tdOrder' bordercolor='#C0C0C0'>&nbsp;</td></tr>");
out.println("<tr><td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td></tr>");
	if(project_type != null && (project_type.equals("PSA")||project_type.equals("SFDC")) &&(userGroup.toUpperCase().startsWith("REP")  ) ){
				out.println("<tr>");
		out.println("<td align='right' class='tdOrder' >PER QUOTE&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder' ><b>"+order_no+"</b></td>");
		
		//out.println("<Tr><TD align='right' class='tdOrder'>PER QUOTE : "+order_no +"<td></tr>");
		String schedule="";double com_perc=0;String markf="";String gas_color="NONE";
		double adders=0;
		for(int k=0;k<line;k++){
			String bgcolor="";
			for (int mn=0;mn<line_item.size();mn++){//if 3
				if ((mn%2)==1){bgcolor="white";}else {bgcolor="#E7E7E7";}
				if ((items.elementAt(k).toString()).equals((line_item.elementAt(mn).toString()))){
					if(block_id.elementAt(mn).toString().equals("C_OPTIONS")){
						adders=adders+new Double(price.elementAt(mn).toString()).doubleValue();
					}
					else{
						String totwt=""+(new Double(price.elementAt(mn).toString()).doubleValue()+adders);//Extended_Price
						adders=0;
						String fact=fact_per.elementAt(mn).toString().trim();//FIELD16
						quan=QTY.elementAt(mn).toString();//QTY
						if ((fact.trim().length()<=0)){fact="0.0"; }
						BigDecimal d1 = new BigDecimal(totwt);
						BigDecimal d2 = new BigDecimal(fact);
						BigDecimal d3 = d1.multiply(d2);
						factor = factor+d3.doubleValue();// total commission dollars
						totprice=d1.doubleValue();//just the materail price no commission
						totprice_dis=totprice_dis+d1.doubleValue();//
						description=(desc.elementAt(mn)).toString();
						markf=(mark.elementAt(mn)).toString();
						if ((!(((fact_per.elementAt(mn)).toString()).equals("")))){//if 1
							String field_16=(fact_per.elementAt(mn)).toString().trim();
							//out.println("THe priority"+prio);
							/*if (prio.equals("E")||prio.equals("D")){
								BigDecimal d4 = new BigDecimal(field_16);
								com_perc=((d4.doubleValue()*100));
							}
							else{*/
								BigDecimal d4 = new BigDecimal(field_16);
								BigDecimal d6 = new BigDecimal("0.91");
								BigDecimal d5 = d4.divide(d6,0);
								com_perc=((d5.doubleValue()*100));
							//}
						}
					}
				}
			}
		}
		if(project_type.equals("NCP")){
			totprice_dis=new Double(totmat_price).doubleValue();
		}
		
		out.println("<td align='right' class='tdOrder'>TOTAL PRICE($)&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder'><b>"+for1.format(totprice_dis)+"</b></td>");
		out.println("</tr>");
		//out.println("<tr><td align='right' class='tdOrder'>TOTAL PRICE($):&nbsp;<b>"+for1.format(totprice_dis)+"</b></td></tr>");
		totprice_dis=totprice_dis+(new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(freight_cost).doubleValue());
	}
	else{

		if(project_type != null && project_type.equals("NCP")){
			if(nonconfigPRICE == null || nonconfigPRICE.equals("null")){	nonconfigPRICE="0";	}
			totprice_dis=totprice_dis+new Double(nonconfigPRICE).doubleValue();
			out.println("<tr><td height='30' colspan='6'>"+nonconfigDesc+"</td></tr>");
		}
		else{
			out.println("<tr>");
			out.println("<td align='left' class='tdOrder' ><b>MODEL</b></td>");
			out.println("<td align='center' class='tdOrder' style='marging-left:0px;'><b>QTY</b></td>");
			out.println("<td align='left' class='tdOrder'><b>Unit Price</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b>EXT. PRICE</b></td>");
			//out.println("<td align='left' class='tdOrder'><b>EXT. PRICE</b></td>");
			out.println("<td align='left' class='tdOrder'><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Comm(%)</b></td>");
			out.println("</tr>");
			String schedule="";double com_perc=0;String markf="";String gas_color="NONE";
			//  for the schdule
			//  which varies from product to product
			//	out.println("The lines are "+line+"The csquotes"+line_item.size());
			double adders=0;double unit_price=0;int lines_to_show=0;
			
			
			for( int i=0; i<sectionGroup.length(); i++ ) {
			    if( sectionGroup.charAt(i) == ';' ) {
			    	count++;
			    } 
			}
			
			for (int i = 0; i < count; i++) {
				if (!(sectionGroup == null || sectionGroup.equalsIgnoreCase("NULL")
						|| sectionGroup.equalsIgnoreCase(""))) {
					String dims15[] = sectionGroup.split(";");
					dims15[i] = dims15[i] + "=end";
					String dims16[] = dims15[i].split("=");
					section_lines.put(Integer.parseInt(dims16[0]), dims16[1]);
					// 1 dims16[0]) s1 dims16[1])
					sectionGroupMap.put(dims16[0], dims16[1]);
				}
			}
			if(siValue==null){
				siValue = sectionString;
			}
			if(siValue.equals(",")){
				siValue="s1";
			}
			String currentSectionsTransferred[] = siValue.split(",");
				alist = new ArrayList<String>();
				for(int a=0;a<currentSectionsTransferred.length;a++){
					Iterator it = sectionGroupMap.entrySet().iterator();
				    while (it.hasNext()) {
				    	Map.Entry pair = (Map.Entry)it.next();
				    	if(currentSectionsTransferred[a].equals((pair.getValue().toString()))){
				    		alist.add(pair.getKey().toString());
				    	}
				    }
					
				}
				
			//}
			
			if("true".equals(bpcsTransferSheet)){
				//out.println(" Call is coming from bpcsTransferSheet -------------"+siValue);
				
					String bgcolor="";lines_to_show=0;
					for (int mn=0;mn<alist.size();mn++){//if 3
						int mnValue = Integer.parseInt(alist.get(mn));
						if (((mnValue-1)%2)==1){bgcolor="white";}else {bgcolor="#E7E7E7";}
						
							if(block_id.elementAt(mnValue-1).toString().equals("C_OPTIONS")){
								adders=adders+new Double(price.elementAt(mnValue-1).toString()).doubleValue();
							}
							else{
								String totwt=""+(new Double(price.elementAt(mnValue-1).toString()).doubleValue()+adders);//Extended_Price
								adders=0;
								String fact=fact_per.elementAt(mnValue-1).toString().trim();//FIELD16
								quan=QTY.elementAt(mnValue-1).toString();//QTY
								if ((fact.trim().length()<=0)){fact="0.0"; }
								BigDecimal d1 = new BigDecimal(totwt);
								BigDecimal d2 = new BigDecimal(fact);
								BigDecimal d3 = d1.multiply(d2);
								factor = factor+d3.doubleValue();// total commission dollars
								totprice=d1.doubleValue();//just the materail price no commission
								totprice_dis=totprice_dis+d1.doubleValue();//
								description=(desc.elementAt(mnValue-1)).toString();
								markf=(mark.elementAt(mnValue-1)).toString();
								if(quan==null|(quan.trim().length()<=0)){quan="0.0";}
								unit_price=totprice/new Double(quan).doubleValue();
								
								
								
								if ((!(((fact_per.elementAt(mnValue-1)).toString()).equals("")))){//if 1
									String field_16=(fact_per.elementAt(mnValue-1)).toString().trim();
									/*if (prio.equals("E")||prio.equals("D")){
										BigDecimal d4 = new BigDecimal(field_16);
										com_perc=((d4.doubleValue()*100));
									}
									else{*/
										BigDecimal d4 = new BigDecimal(field_16);
										BigDecimal d6 = new BigDecimal("0.91");
										BigDecimal d5 = d4.divide(d6,0);
										com_perc=((d5.doubleValue()*100));
									//}
								}//if 1
								if(new Double(quan).doubleValue()>0){
									out.println("<tr>");
									out.println("<td align='left' class='tdOrder'>&nbsp;"+description.trim()+"</td>");
									out.println("<td align='center' class='tdOrder' style='marging-right:-25px;'>&nbsp;"+quan+"</td>");
									for1.setMaximumFractionDigits(5);
									out.println("<td align='left' class='tdOrder'>&nbsp;"+for1.format(unit_price)+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+for1.format(totprice)+"</td>");
									if(project_type.equals("web")){
										for1.setMaximumFractionDigits(2);
										for1.setMinimumFractionDigits(2);
									}
									else{
										for1.setMaximumFractionDigits(0);
									}
									//out.println("<td align='left' class='tdOrder'>&nbsp;"+for1.format(totprice)+"</td>");
									out.println("<td align='left' class='tdOrder'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+Math.round(com_perc)+"</td>");
									out.println("</tr>");
								}
							}//if 2
						//intializing the values
						totprice=0;unit_price=0;
						imp.clear();
						schedule="";markf="";gas_color="NONE";description="";
					}
			}else{
				for(int k=0;k<line;k++){
					String bgcolor="";lines_to_show=0;
					for (int mn=0;mn<line_item.size();mn++){//if 3
						if ((mn%2)==1){bgcolor="white";}else {bgcolor="#E7E7E7";}
						if ((items.elementAt(k).toString()).equals((line_item.elementAt(mn).toString()))){
							if(block_id.elementAt(mn).toString().equals("C_OPTIONS")){
								adders=adders+new Double(price.elementAt(mn).toString()).doubleValue();
							}
							else{
								String totwt=""+(new Double(price.elementAt(mn).toString()).doubleValue()+adders);//Extended_Price
								adders=0;
								String fact=fact_per.elementAt(mn).toString().trim();//FIELD16
								quan=QTY.elementAt(mn).toString();//QTY
								if ((fact.trim().length()<=0)){fact="0.0"; }
								BigDecimal d1 = new BigDecimal(totwt);
								BigDecimal d2 = new BigDecimal(fact);
								BigDecimal d3 = d1.multiply(d2);
								factor = factor+d3.doubleValue();// total commission dollars
								totprice=d1.doubleValue();//just the materail price no commission
								totprice_dis=totprice_dis+d1.doubleValue();//
								description=(desc.elementAt(mn)).toString();
								markf=(mark.elementAt(mn)).toString();
								if(quan==null|(quan.trim().length()<=0)){quan="0.0";}
								unit_price=totprice/new Double(quan).doubleValue();
								if ((!(((fact_per.elementAt(mn)).toString()).equals("")))){//if 1
									String field_16=(fact_per.elementAt(mn)).toString().trim();
									/*if (prio.equals("E")||prio.equals("D")){
										BigDecimal d4 = new BigDecimal(field_16);
										com_perc=((d4.doubleValue()*100));
									}
									else{*/
										BigDecimal d4 = new BigDecimal(field_16);
										BigDecimal d6 = new BigDecimal("0.91");
										BigDecimal d5 = d4.divide(d6,0);
										com_perc=((d5.doubleValue()*100));
									//}
								}//if 1
								if(new Double(quan).doubleValue()>0){
									out.println("<tr>");
									out.println("<td align='left' class='tdOrder'>&nbsp;"+description.trim()+"</td>");
									out.println("<td align='center' class='tdOrder' style='marging-right:-25px;'>&nbsp;"+quan+"</td>");
									for1.setMaximumFractionDigits(5);
									out.println("<td align='left' class='tdOrder'>&nbsp;"+for1.format(unit_price)+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+for1.format(totprice)+"</td>");
									if(project_type.equals("web")){
										for1.setMaximumFractionDigits(2);
										for1.setMinimumFractionDigits(2);
									}
									else{
										for1.setMaximumFractionDigits(0);
									}
									//out.println("<td align='left' class='tdOrder'>&nbsp;"+for1.format(totprice)+"</td>");
									out.println("<td align='left' class='tdOrder'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+Math.round(com_perc)+"</td>");
									out.println("</tr>");
								}
							}//if 2
						}//if 3
						//intializing the values
						totprice=0;unit_price=0;
						imp.clear();
						schedule="";markf="";gas_color="NONE";description="";
					}
				}//end of inner for loop
			}
			
			

		}// END OF THE FOR LOOP
		if(project_type == null){
			project_type="";
		}

		NumberFormat for12 = NumberFormat.getInstance();
		for12.setMaximumFractionDigits(2);
		out.println("<tr><td align='left'><div id='sideHead'><p style='font-size:14px;color:black;margin-top:20px;font-stretch:expanded;'><b>PRICE SUMMARY</b></p></div></td><td colspan='8' align='right' height='10%' class='tdOrder' bordercolor='#C0C0C0'>&nbsp;</td></tr>");
out.println("<tr><td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td></tr>");
		out.println("<tr>");
		//totprice_dis=totprice_dis+(new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(freight_cost).doubleValue());
		out.println("<td align='right' class='tdOrder'>TOTAL MAT PRICE($)&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		for1.setMaximumFractionDigits(2);
		out.println("<td align='left' class='tdOrder' ><b>"+for1.format(totprice_dis)+"</b></td>");
		
		out.println("<td align='right' class='tdOrder' >Tax&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder' ><b>"+for1.format(tax_dollar)+"</b></td>");
		
		out.println("</tr>");


		out.println("<tr>");
		out.println("<td align='right' class='tdOrder' >OVERAGE AMOUNT($)&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder' ><b>"+for1.format(new Double(overage).doubleValue())+"</b></td>");
		for1.setMaximumFractionDigits(0);
		out.println("<td align='right' class='tdOrder'>FREIGHT SURCHARGE&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder'><b>"+for1.format(new Double(handling_cost).doubleValue())+"</b></td>");
		out.println("</tr>");



		out.println("<tr>");
		out.println("<td align='right' class='tdOrder' >SETUP COST($)&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder' ><b>"+"0.0"+"</b></td>");
		out.println("<td align='right' class='tdOrder'>EXTRA CHARGES&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder' ><b>"+for1.format(new Double(freight_cost).doubleValue())+"</b></td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td align='right' class='tdOrder' >STD.commission&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder' ><b>"+for1.format(factor)+"</b></td>");
		totprice_dis=totprice_dis+(new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(freight_cost).doubleValue());
		if(project_type != null && project_type.equals("NCP")){
			out.println("<td align='right' class='tdOrder' >STD commission(%)&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder' ><b>"+commission+"</b></td>");
		}
		/*else if (prio.equals("E")||prio.equals("D")){
			out.println("<td align='right' class='tdOrder' >STD commission(%)&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder' ><b>"+for12.format((factor/((totprice_dis-((new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(freight_cost).doubleValue())))))*100)+"</b></td>");
		}*/
		else {
			out.println("<td align='right' class='tdOrder'>STD commission(%)&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder' ><b>"+for12.format((factor/((totprice_dis-((new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(freight_cost).doubleValue())))*.91))*100)+"</b></td>");
		}
for1.setMaximumFractionDigits(2);
out.println("</tr>");
	out.println("<tr>");
		out.println("<td align='right' class='tdOrder'>GRAND TOTAL&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder' ><b>"+for1.format(grandTotal)+"</b></td>");
		out.println("</tr>");


	}

}
%>


