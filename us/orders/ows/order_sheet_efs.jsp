
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
   						 }

if(project_type== null){project_type="";}
if(tot_lines>0){
	out.println("<tr>");
	out.println("<td width='30%' height='30%' class='test1' bordercolor='#C0C0C0'>"+"&nbsp; EFS Order Information : "+"<td>");
	out.println("<td width='70%' height='30%' bordercolor='#C0C0C0'>"+"&nbsp;"+"<td>");
	out.println("</tr>");
if( ! project_type.equals("PSA")){
		out.println("<tr>");
		out.println("<td width='100%' height='30%'  bordercolor='#C0C0C0'>");
		out.println("<table width='100%' border='1' cellspacing='0' cellpadding='0' class='tb'>");
			if(project_type != null && project_type.equals("NCP")){
				if(nonconfigPRICE == null || nonconfigPRICE.equals("null")){	nonconfigPRICE="0";	}
				totprice_dis=totprice_dis+new Double(nonconfigPRICE).doubleValue();
				out.println("<tr><td height='30' class='tdheader2'>"+nonconfigDesc+"</td></tr>");
			}
			else{
			out.println("<tr>");
			out.println("<td align='center' height='30' class='tdheader2'>QTY</td>");
			out.println("<td align='center' height='30' class='tdheader2'>MODEL# </td>");
			out.println("<td align='center' height='30' class='tdheader2'>SIZE W x L (TD)</td>");
			out.println("<td align='center' height='30' class='tdheader2'>CUTS/NOTCHES</td>");
			out.println("<td align='center' height='30' class='tdheader2'>LOGO</td>");
			out.println("<td align='center' height='30' class='tdheader2'>TEMPLATE/ART WORK</td>");
			out.println("<td align='center' height='30' class='tdheader2'>TEXTURE/COLOR</td>");
			//out.println("<td align='center' height='30' class='tdheader2'>UNIT PRICE</td>");
			out.println("<td align='center' height='30' class='tdheader2'>EXT. PRICE</td>");
			out.println("</tr>");
			String dimension="";String cuts_notches="";	String logo="";String template_art="";String texture_color="";
			String schedule="";double com_perc=0;int lines_to_show=0;
			// for the schdule
			
			//out.println("Lines: "+line+"line_items: "+line_item+"items: "+items);
								for(int k=0;k<line;k++){
							//		out.println("I am in k"+k+"Line item size"+line_item.size());
										String bgcolor="";lines_to_show=0;
										if ((k%2)==1){bgcolor="white";}else {bgcolor="#E7E7E7";}
								for (int mn=0;mn<line_item.size();mn++){
								if ((line_item.elementAt(mn).toString()).equals((items.elementAt(k).toString()))){
						//			out.println("I am in mn"+mn);
									String totwt=price.elementAt(mn).toString();//Extended_Price
									String fact=fact_per.elementAt(mn).toString().trim();//FIELD16
										if ((fact.equals(""))){fact="0.0"; }
									  BigDecimal d1 = new BigDecimal(totwt);
								      BigDecimal d2 = new BigDecimal(fact);
									  BigDecimal d3 = d1.multiply(d2);
		//							  d3 = d3.setScale(0, BigDecimal.ROUND_HALF_UP);
								      factor = factor+d3.doubleValue();// total comission dollars
									  totprice=totprice+d1.doubleValue();//just the materail price no comission
									totprice_dis=totprice_dis+d1.doubleValue();//
									if ((block_id.elementAt(mn).toString()).equals("A_APRODUCT")){
										description=(desc.elementAt(mn)).toString();
						//			out.println("I am in a_aproduct "+mn);
			                        }
									if ((block_id.elementAt(mn).toString()).endsWith("PRICES")){
										String field_16=(fact_per.elementAt(mn)).toString().trim();
										//if (prio.equals("E")){
										//BigDecimal d4 = new BigDecimal(field_16);
										//com_perc=((d4.doubleValue()*100));
										//}
										//else{
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
				out.println("<tr>");
				out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+">&nbsp;"+quan+"</td>");
				out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+">&nbsp;"+description+"</td>");
				out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+"> &nbsp;"+dimension+"</td>");
				out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+"> &nbsp;"+cuts_notches+"</td>");
				out.println("<td align='center' nowrap class='tdheader2' bgcolor="+bgcolor+"> &nbsp;"+logo+"</td>");
				out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+"> &nbsp;"+template_art+"</td>");
				out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+">&nbsp;"+texture_color+" </td>");
				//out.println("<td>&nbsp;</td>");
				if(project_type.equals("web")){
					for1.setMaximumFractionDigits(2);
					for1.setMinimumFractionDigits(2);
				}
				else{
					for1.setMaximumFractionDigits(0);
				}				
				out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+">&nbsp;"+for1.format(totprice)+"</td>");
				out.println("</tr>");
						 }//lines to show
				//intializing the values
				totprice=0;imp.clear();
				dimension="";cuts_notches="";logo="";template_art="";texture_color="";schedule="";description="";
				  }//outer for
		}
			out.println("</table>");
			out.println("<td>");
			out.println("</tr>");
}else{
 out.println("<Tr><TD><BR>PER QUOTE : "+order_no +"<BR><BR><td></tr>");
}
NumberFormat for12 = NumberFormat.getInstance();
for12.setMaximumFractionDigits(1);
NumberFormat for120 = NumberFormat.getInstance();
for120.setMaximumFractionDigits(0);

// Next row
        out.println("<tr>");
        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tddashtop'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
       // out.println(totprice_dis+"<BR>");
        /*
        if(project_type.equals("NCP")){
		totprice_dis=new Double(totmat_price).doubleValue();
	}
	*/
//out.println(totprice_dis+"<BR>");

//	out.println("The price1"+totprice_dis+":"+overage+"::"+handling_cost+"::"+setup_cost+"::"+freight_cost);
		totprice_dis=totprice_dis+(new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(setup_cost).doubleValue())+(new Double(freight_cost).doubleValue());
//out.println("The price2"+totprice_dis);
//out.println(totprice_dis);
        out.println("<td class='tdnodash' width='33%'>TOTAL PRICE($):&nbsp;<b>"+for120.format(totprice_dis)+"</b></td>");
        out.println("<td class='tdnodash' width='33%'>STD.COMISSION:&nbsp;<b>"+for1.format(factor)+"</b></td>");
		out.println("<td class='tdnodash' width='33%'>OVERAGE AMOUNT($):&nbsp;<b>"+for1.format(new Double(overage).doubleValue())+"</b></td>");
		out.println("</tr>");
		out.println("</table></td>");
  		out.println("</tr>");
		out.println("<tr>");
        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tdsolid'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
        out.println("<td class='tdnodash' width='25%'>HANDLING CHARGES:&nbsp;<b>"+for1.format(new Double(handling_cost).doubleValue())+"</b></td>");
        out.println("<td class='tdnodash' width='25%'>SETUP COST($):&nbsp;<b>"+for1.format(new Double(setup_cost).doubleValue())+"</b></td>");
		out.println("<td class='tdnodash' width='25%'>EXTRA CHARGES:&nbsp;<b>"+for1.format(new Double(freight_cost).doubleValue())+"</b></td>");
		//if (prio.equals("E")){
//		 out.println( for12.format(((totcomm_dol/(totprice_dis))*100)) );
		//out.println("<td class='tdnodash' width='25%'>STD COMISSION(%):&nbsp;<b>"+for12.format((factor/((totprice_dis-((new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(setup_cost).doubleValue())+(new Double(freight_cost).doubleValue())))))*100)+"</b></td>");
		//}
		//else{
		//out.println(for12.format(((totcomm_dol/(totprice_dis*0.91))*100)) );
		out.println("<td class='tdnodash' width='25%'>STD COMISSION(%):&nbsp;<b>"+for12.format((factor/((totprice_dis-((new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(setup_cost).doubleValue())+(new Double(freight_cost).doubleValue())))*.91))*100)+"</b></td>");
		//}
		out.println("</tr>");
		out.println("</table></td>");
  		out.println("</tr>");

out.println("<tr>");
out.println("<td align='center' width='100%' height='30' class='tdheader'>"+"&nbsp;"+"</td>");
out.println("</tr>");

}//if any lines

 %>

