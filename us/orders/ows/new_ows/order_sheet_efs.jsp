
<%

//Global
int tot_lines=0;double totprice=0;double factor=0.0;double totprice_dis=0;String description="";
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

if(queryLines.trim().length()>0){
	ResultSet rs3 = stmt.executeQuery("SELECT * FROM csquotes where order_no like '"+order_no+"' and line_no in("+queryLines+") and product_id='EFS' order by cast(Line_no as integer)");
    while ( rs3.next() ) {
	line_item.addElement(rs3.getString ("Line_no"));
	desc.addElement(rs3.getString ("Descript"));
	price.addElement(rs3.getString ("Extended_Price"));
	totmatsales=totmatsales+new Double(rs3.getString ("Extended_Price")).doubleValue();
	QTY.addElement(rs3.getString("QTY"));
	block_id.addElement(rs3.getString("Block_ID"));
	fact_per.addElement(rs3.getString("field16"));
	tot_lines++;
   						 }
    rs3.close();
   						 }


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


if(project_type== null){project_type="";}
if(tot_lines>0){
	out.println("<tr><td align='left' style='page-break-before: always;'><div id='sideHead'><p style='font-size:14px;color:black;margin-top:20px;font-stretch:expanded;'><b>EFS ORDER CONFIRMATION</b></p></div></td><td colspan='8' align='right' height='10%' class='tdOrder' bordercolor='#C0C0C0'>&nbsp;</td></tr>");
out.println("<tr><td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td></tr>");
	
		//out.println("<tr>");
		//out.println("<td width='100%' height='30%'  bordercolor='#C0C0C0'>");
		//out.println("<table width='100%' border='1' cellspacing='0' cellpadding='0' class='tb'>");
			if(project_type != null && project_type.equals("NCP")){
				if(nonconfigPRICE == null || nonconfigPRICE.equals("null")){	nonconfigPRICE="0";	}
				totprice_dis=totprice_dis+new Double(nonconfigPRICE).doubleValue();
				out.println("<tr><td height='30' class='tdheader2'>"+nonconfigDesc+"</td></tr>");
			}
			else{
				if(!(project_type != null && project_type.equals("SFDC") &&userGroup.toUpperCase().startsWith("REP") )){
			out.println("<tr>");
			out.println("<td align='left' class='tdOrder'><b>QTY</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("<b>MODEL# </b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
			out.println("<td align='center' class='tdOrder'><b>SIZE W x L (TD)</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("<b>CUTS/NOTCHES</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
			out.println("<td align='left' class='tdOrder'><b>LOGO</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("<b>TEMPLATE/ART WORK</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
			out.println("<td align='center' class='tdOrder'><b>TEXTURE/COLOR</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			//out.println("<b>UNIT PRICE</b>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp</td>");
			out.println("<td align='left' class='tdOrder'><b>EXT. PRICE</b></td>");
			out.println("</tr>");
				}
			String dimension="";String cuts_notches="";	String logo="";String template_art="";String texture_color="";
			String schedule="";double com_perc=0;int lines_to_show=0;
			// for OWS-743		
			
			//out.println("Lines: "+line+"line_items: "+line_item+"items: "+items);
			
				// for the schdule
					for(int k=0;k<line;k++){
							String bgcolor="";lines_to_show=0;
							if ((k%2)==1){bgcolor="white";}else {bgcolor="#E7E7E7";}
					for (int mn=0;mn<line_item.size();mn++){
					if ((line_item.elementAt(mn).toString()).equals((items.elementAt(k).toString()))){
						String totwt=price.elementAt(mn).toString();//Extended_Price
						String fact=fact_per.elementAt(mn).toString().trim();//FIELD16
							if ((fact.equals(""))){fact="0.0"; }
						  BigDecimal d1 = new BigDecimal(totwt);
					      BigDecimal d2 = new BigDecimal(fact);
						  BigDecimal d3 = d1.multiply(d2);
					      factor = factor+d3.doubleValue();// total comission dollars
						  totprice=totprice+d1.doubleValue();//just the materail price no comission
						totprice_dis=totprice_dis+d1.doubleValue();//
						if ((block_id.elementAt(mn).toString()).equals("A_APRODUCT")){
							description=(desc.elementAt(mn)).toString();
                        }
						if ((block_id.elementAt(mn).toString()).endsWith("PRICES")){
							String field_16=(fact_per.elementAt(mn)).toString().trim();
							/*if (prio.equals("E")){
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
						if ((block_id.elementAt(mn).toString()).equals("E_DIM")){
							String dim=(desc.elementAt(mn)).toString();
						   	int n_s=dim.indexOf("@");
//							if (n_s >=0 ){
							int n_s1=dim.indexOf("@",n_s+1);
							int n_s2=dim.indexOf("@",n_s1+1);
							int n_s3=dim.indexOf("@",n_s2+1);
//							int n_s4=dim.indexOf("@",n_s3+1);
							dimension=dim.substring(0,n_s);
							cuts_notches=dim.substring(n_s+1,n_s1);
							logo=dim.substring(n_s1+1,n_s2);
							template_art=dim.substring(n_s2+1,n_s3);
							texture_color=dim.substring(n_s3+1,dim.length());
							if (cuts_notches.equals("")){cuts_notches="-NONE-";}
							if (logo.equals("")){logo="-NONE-";}
							if (template_art.equals("")){template_art="-NONE-";}
							if (texture_color.equals("")){texture_color="-STD-";}
							quan=QTY.elementAt(mn).toString();//QTY
						//    }
						}
						lines_to_show++;
					 }//end of if statement
			 }//inner for
			 if(lines_to_show>0){
				 if(!(project_type != null && project_type.equals("SFDC") &&userGroup.toUpperCase().startsWith("REP") )){
	out.println("<tr>");
	out.println("<td align='left' class='tdOrder'>&nbsp;"+quan+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
	out.println("&nbsp;"+description+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
	out.println("<td align='center' class='tdOrder'> &nbsp;"+dimension+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
	out.println(" &nbsp;"+cuts_notches+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
	out.println("<td align='center' class='tdOrder'> &nbsp;"+logo+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
	out.println(" &nbsp;"+template_art+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>");
	out.println("<td align='left' class='tdOrder'>&nbsp;"+texture_color+" </td>");
	//out.println("<td>&nbsp;</td>");
	if(project_type.equals("web")){
		for1.setMaximumFractionDigits(2);
		for1.setMinimumFractionDigits(2);
	}
	else{
		for1.setMaximumFractionDigits(0);
	}				
	out.println("<td align='left' class='tdOrder'>&nbsp;"+for1.format(totprice)+"</td>");
	out.println("</tr>");
				 }
	}//lines to show
	//intializing the values
	totprice=0;imp.clear();
	dimension="";cuts_notches="";logo="";template_art="";texture_color="";schedule="";description="";
}//outer for
								
			//}								
								
		}
			//out.println("</table>");
			//out.println("<td>");
			//out.println("</tr>");

NumberFormat for12 = NumberFormat.getInstance();
for12.setMaximumFractionDigits(1);
NumberFormat for120 = NumberFormat.getInstance();
for120.setMaximumFractionDigits(0);

// Next row
if(!(project_type != null && project_type.equals("SFDC") &&userGroup.toUpperCase().startsWith("REP") )){
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
        //out.println("<BR>"+totprice_dis+"<BR>");
        /*
        if(project_type.equals("NCP")){
		totprice_dis=new Double(totmat_price).doubleValue();
	}
	*/
//out.println(totprice_dis+"<BR>");

//	out.println("The price1"+totprice_dis+":"+overage+"::"+handling_cost+"::"+setup_cost+"::"+freight_cost);
		//totprice_dis=totprice_dis+(new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(setup_cost).doubleValue())+(new Double(freight_cost).doubleValue());
//out.println("The price2"+totprice_dis);
//out.println(totprice_dis);
out.println("<td align='right' class='tdOrder'>TOTAL MATERIAL PRICE($)&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
        out.println("<td align='left' class='tdOrder'><b>"+for120.format(totprice_dis)+"</b></td>");
        //out.println("<td align='right' class='tdOrder'>STD.COMISSION&nbsp&nbsp:&nbsp&nbsp</td><td align='left' class='tdOrder'><b>"+for1.format(factor)+"</b></td>");
		for1.setMaximumFractionDigits(2);
		out.println("<td align='right' class='tdOrder' >Tax&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder' ><b>"+for1.format(tax_dollar)+"</b></td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td align='right' class='tdOrder'>OVERAGE AMOUNT($)&nbsp;&nbsp;:&nbsp;&nbsp;</td><td align='left' class='tdOrder'><b>"+for1.format(new Double(overage).doubleValue())+"</b></td>");
		out.println("<td align='right' class='tdOrder'>HANDLING CHARGES&nbsp;&nbsp;:&nbsp;&nbsp;</td><td align='left' class='tdOrder'><b>"+for1.format(new Double(handling_cost).doubleValue())+"</b></td>");
		out.println("</tr>");
		out.println("<tr>");        
        out.println("<td align='right' class='tdOrder'>SETUP COST($)&nbsp;&nbsp;:&nbsp;&nbsp;</td><td align='left' class='tdOrder'><b>"+for1.format(new Double(setup_cost).doubleValue())+"</b></td>");
		out.println("<td align='right' class='tdOrder'>EXTRA CHARGES&nbsp;&nbsp;:&nbsp;&nbsp;</td><td align='left' class='tdOrder'><b>"+for1.format(new Double(freight_cost).doubleValue())+"</b></td>");
		out.println("</tr>");
		out.println("<tr>");  
		totprice_dis=totprice_dis+(new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(setup_cost).doubleValue())+(new Double(freight_cost).doubleValue());
		/*if (prio.equals("E")){
//		 out.println( for12.format(((totcomm_dol/(totprice_dis))*100)) );
		out.println("<td align='right' class='tdOrder'>STD COMISSION(%)&nbsp;&nbsp;:&nbsp;&nbsp;</td><td align='left' class='tdOrder'><b>"+for12.format((factor/((totprice_dis-((new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(setup_cost).doubleValue())+(new Double(freight_cost).doubleValue())))))*100)+"</b></td>");
		}
		else{*/
	//	out.println(for12.format(((totcomm_dol/(totprice_dis*0.91))*100)) );
		out.println("<td align='right' class='tdOrder'>STD COMISSION(%)&nbsp;&nbsp;:&nbsp;&nbsp;</td><td align='left' class='tdOrder'><b>"+for12.format((factor/((totprice_dis-((new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(setup_cost).doubleValue())+(new Double(freight_cost).doubleValue())))*.91))*100)+"</b></td>");
		//}
		out.println("<td align='right' class='tdOrder'>STD.COMISSION&nbsp;&nbsp;:&nbsp;&nbsp;</td><td align='left' class='tdOrder'><b>"+for1.format(factor)+"</b></td>");
		out.println("</tr>");
out.println("<tr>");
		out.println("<td align='right' class='tdOrder'>GRAND TOTAL&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder' ><b>"+for1.format(grandTotal)+"</b></td>");
		out.println("</tr>");
	out.println("<tr>");
	out.println("<td align='center' colspan='6'  height='30' class='tdheader'>"+"&nbsp;"+"</td>");
	out.println("</tr>");
}

if(project_type != null && project_type.equals("SFDC") &&userGroup.toUpperCase().startsWith("REP") ){
out.println("<tr>");
		out.println("<td align='right' class='tdOrder' >PER QUOTE&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder' ><b>"+order_no+"</b></td>");
		out.println("<td align='right' class='tdOrder'>TOTAL MATERIAL PRICE($)&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder'><b>"+for1.format(totprice_dis)+"</b></td>");
		out.println("</tr>");
		//out.println("<Tr><TD><BR>PER QUOTE : "+order_no +"<BR><BR><td></tr>");
}
}//if any lines

 %>

