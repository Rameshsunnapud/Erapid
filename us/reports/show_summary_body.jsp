<%
try{
if(numberOfSections>1){
	for(int j=0;j< numberOfSections; j++){

	String overageTEMP=overage;
	String setupTEMP=setup_cost;
	String freightTEMP=freight_cost;
	String handlingTEMP=handling_cost;
	double sectionSUM=0;


	//out.println(secLINES.elementAt(j).toString()+"<BR>");





















%>
<font class='mainbodyh'><B>QUOTE SUMMARY ::</B><br><br></font>
<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'>
	<tr height='20'>
		<td width='4%' bgcolor='#006600'><font class='schedule'><b></b></font></td>
		<td width='13%' bgcolor='#006600'><font class='schedule'><b>Mark</b></font></td>
		<td width='35%' bgcolor='#006600'><font class='schedule'><b>Model</b></font></td>
		<td width='8%' bgcolor='#006600'><font class='schedule'><b>Qty</b></font></td>
		<td width='13%' bgcolor='#006600'><font class='schedule'><b>Price</b></font></td>
		<td width='13%' bgcolor='#006600'><font class='schedule'><b>Size(w x l)</b></font></td>
		<td width='21%' bgcolor='#006600'><font class='schedule'><b>Price/sq ft<sup> *</sup></b></font></td>
		<td width='18%' bgcolor='#006600'><font class='schedule'><b>Discount</b></font></td>
		<td width='18%' bgcolor='#006600'><font class='schedule'><b>Comission </b></font></td>
	</tr>
	<%
	String dimension="";String area="";String discount_show="";String quan1=""; String line_no="";
				for(int k=0;k<line;k++){
				if(secLINES.elementAt(j).toString().indexOf(","+items.elementAt(k).toString()+",")>=0){
								String bgcolor="";
								if ((k%2)==1){bgcolor="#e4e4e4";}else {bgcolor="#EFEFDE";}
						//Getting the Area
						String config_s0 = config_string.elementAt(k).toString();
						int config_s1= config_s0.indexOf("AREA[");
						int config_s2=config_s0.indexOf("]",config_s1+1);
						area=config_s0.substring(config_s1+5,config_s2);
						if(config_s1<0){area="0";}
						//Getting the Area done
					   for (int mn=0;mn<line_item.size();mn++){
							if ((line_item.elementAt(mn).toString()).equals((items.elementAt(k).toString()))){
								String totwt=price.elementAt(mn).toString();//Extended_Price
								String fact=fact_per.elementAt(mn).toString().trim();//FIELD16
								sectionSUM=sectionSUM+new Double(totwt).doubleValue();
								quan=QTY.elementAt(mn).toString();//QTY
								if ((fact.equals(""))){fact="0.0"; }
								  BigDecimal d1 = new BigDecimal(totwt);
								 BigDecimal d2 = new BigDecimal(fact);
								  BigDecimal d3 = d1.multiply(d2);
	//							  d3 = d3.setScale(0, BigDecimal.ROUND_HALF_UP);
								 factor = factor+d3.doubleValue();// total comission dollars for the line
								  totprice=totprice+d1.doubleValue();//just the materail price no comission for the line
								totprice_dis=totprice_dis+d1.doubleValue();//Total material price for the job
								totcomm_dol= totcomm_dol+d3.doubleValue();// final commission dollars for the job
								if ((block_id.elementAt(mn).toString()).equals("A_APRODUCT")){
									line_no=line_item.elementAt(mn).toString();
								quan1=QTY.elementAt(mn).toString();
								description=(desc.elementAt(mn)).toString();
								mark=(mark_no.elementAt(mn)).toString();
									if (!(discount.elementAt(mn)==null)){
									discount_show=discount.elementAt(mn).toString().trim().replace('L','B');//FIELD19
									}
									else{
									discount_show="";
									}
						   }
								if ((block_id.elementAt(mn).toString()).endsWith("PRICES")){
									String field_16=(fact_per.elementAt(mn)).toString().trim();
/* 									if (prio.equals("E")){
									BigDecimal d4 = new BigDecimal(field_16);
									com_perc=((d4.doubleValue()*100));
									}
									else{ */
									BigDecimal d4 = new BigDecimal(field_16);
									BigDecimal d6 = new BigDecimal("0.91");
									BigDecimal d5 = d4.divide(d6,0);
									com_perc=((d5.doubleValue()*100));
									//}
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
		if(product.equals("EFS")){
			quan=quan1;
		}
	//		double price_sqft= totprice/new Double(area).doubleValue();
	out.println("<tr><td width='4%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+line_no+"</td>");
		out.println("<td width='10%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+mark+"</td>");
		out.println("<td width='25%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+description+"</td>");
		out.println("<td valign='top' width='6%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+quan+"</td>");
		out.println("<td valign='top' width='10%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(totprice)+"</td>");
		out.println("<td valign='top' width='10%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+dimension+"</td>");
		if(area.equals("0")){
		out.println("<td valign='top' width='19%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+"&nbsp;--"+""+"</td>");
		}
		else{
		out.println("<td valign='top' width='19%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+"&nbsp;"+for1.format(totprice/(new Double(area).doubleValue()*new Double(quan).doubleValue()))+"</td>");
		}
		out.println("<td valign='top' width='50%'bgcolor='"+bgcolor+"' class='maindesc'>"+discount_show+"</td>");
		out.println("<td valign='top' width='50%'bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(factor)+"</td>");
		out.println("</tr>");
				}
	factor=0;totprice=0;area="";discount_show="";

			}
	%>

</table>
<br><br>

<%

	//out.println(sectionSUM+"::"+tot_sum);






















	if(isOVERAGE){
		if(sectionOVERAGE.elementAt(j).toString()!= null && sectionOVERAGE.elementAt(j).toString().trim().length()>0){
			overage=sectionOVERAGE.elementAt(j).toString();
		}
		else{
			overage="0";
		}
	}
	else{
		overage=""+new Double(overage).doubleValue()*(new Double(sectionSUM).doubleValue()/new Double(tot_sum).doubleValue());
	}
	if(isFREIGHT){
		if(sectionFREIGHT.elementAt(j).toString()!= null && sectionFREIGHT.elementAt(j).toString().trim().length()>0){
			freight_cost=sectionFREIGHT.elementAt(j).toString();
		}
		else{
			freight_cost="0";
		}
	}
	else{
		freight_cost=""+new Double(freight_cost).doubleValue()*(new Double(sectionSUM).doubleValue()/new Double(tot_sum).doubleValue());
	}
	if(isSETUP){
		if(sectionSETUP.elementAt(j).toString()!= null && sectionSETUP.elementAt(j).toString().trim().length()>0){
			setup_cost=sectionSETUP.elementAt(j).toString();
		}
		else{
			setup_cost="0";
		}
	}
	else{
		setup_cost=""+new Double(setup_cost).doubleValue()*(new Double(sectionSUM).doubleValue()/new Double(tot_sum).doubleValue());
	}
	if(isHANDLING){
		if(sectionHANDLING.elementAt(j).toString()!= null && sectionHANDLING.elementAt(j).toString().trim().length()>0){
			handling_cost=sectionHANDLING.elementAt(j).toString();
		}
		else{
			handling_cost="0";
		}
	}
	else{
		handling_cost=""+new Double(handling_cost).doubleValue()*(new Double(sectionSUM).doubleValue()/new Double(tot_sum).doubleValue());
	}



	tot_sum=sectionSUM;












		if( (!(( product.equals("EJC")|product.equals("IWP")|product.equals("EFS")) & (st.equals("2")|st.equals("3"))) )){%><%@ include file="show_summary_foot.jsp"%><%}
		overage=overageTEMP;
		setup_cost=setupTEMP;
		freight_cost=freightTEMP;
		handling_cost=handlingTEMP;
		totprice_dis=0;
	}

}
else{
%>
<font class='mainbodyh'><B>QUOTE SUMMARY ::</B><br><br></font>
<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'>
	<tr height='20'>
		<td width='4%' bgcolor='#006600'><font class='schedule'><b></b></font></td>
		<td width='13%' bgcolor='#006600'><font class='schedule'><b>Mark</b></font></td>
		<td width='35%' bgcolor='#006600'><font class='schedule'><b>Model</b></font></td>
		<td width='8%' bgcolor='#006600'><font class='schedule'><b>Qty</b></font></td>
		<td width='13%' bgcolor='#006600'><font class='schedule'><b>Price</b></font></td>
		<td width='13%' bgcolor='#006600'><font class='schedule'><b>Size(w x l)</b></font></td>
		<td width='21%' bgcolor='#006600'><font class='schedule'><b>Price/sq ft<sup> *</sup></b></font></td>
		<td width='18%' bgcolor='#006600'><font class='schedule'><b>Discount</b></font></td>
		<td width='18%' bgcolor='#006600'><font class='schedule'><b>Comission </b></font></td>
	</tr>
	<%
	String dimension="";String area="";String discount_show="";String quan1=""; String line_no="";
				for(int k=0;k<line;k++){
								String bgcolor="";
								if ((k%2)==1){bgcolor="#e4e4e4";}else {bgcolor="#EFEFDE";}
						//Getting the Area
						String config_s0 = config_string.elementAt(k).toString();
						int config_s1= config_s0.indexOf("AREA[");
						int config_s2=config_s0.indexOf("]",config_s1+1);
						area=config_s0.substring(config_s1+5,config_s2);
						if(config_s1<0){area="0";}
						//Getting the Area done
					   for (int mn=0;mn<line_item.size();mn++){
							if ((line_item.elementAt(mn).toString()).equals((items.elementAt(k).toString()))){
								String totwt=price.elementAt(mn).toString();//Extended_Price
								String fact=fact_per.elementAt(mn).toString().trim();//FIELD16

								if(group.startsWith("Can")){
										fact=""+(new Double(commission).doubleValue()/100);
								}




								quan=QTY.elementAt(mn).toString();//QTY
								if ((fact.equals(""))){fact="0.0"; }
								  BigDecimal d1 = new BigDecimal(totwt);
								 BigDecimal d2 = new BigDecimal(fact);
								  BigDecimal d3 = d1.multiply(d2);
	//							  d3 = d3.setScale(0, BigDecimal.ROUND_HALF_UP);
								 factor = factor+d3.doubleValue();// total comission dollars for the line
								  totprice=totprice+d1.doubleValue();//just the materail price no comission for the line
								totprice_dis=totprice_dis+d1.doubleValue();//Total material price for the job
								totcomm_dol= totcomm_dol+d3.doubleValue();// final commission dollars for the job
								if ((block_id.elementAt(mn).toString()).equals("A_APRODUCT")){
									line_no=line_item.elementAt(mn).toString();
								quan1=QTY.elementAt(mn).toString();
								description=(desc.elementAt(mn)).toString();
								mark=(mark_no.elementAt(mn)).toString();
									if (!(discount.elementAt(mn)==null)){
									discount_show=discount.elementAt(mn).toString().trim().replace('L','B');//FIELD19
									}
									else{
									discount_show="";
									}
						   }
								if ((block_id.elementAt(mn).toString()).endsWith("PRICES")){
									String field_16=(fact_per.elementAt(mn)).toString().trim();
/* 									if (prio.equals("E")){
									BigDecimal d4 = new BigDecimal(field_16);
									com_perc=((d4.doubleValue()*100));
									}
									else{ */
									BigDecimal d4 = new BigDecimal(field_16);
									BigDecimal d6 = new BigDecimal("0.91");
									BigDecimal d5 = d4.divide(d6,0);
									com_perc=((d5.doubleValue()*100));
									//}
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
		if(product.equals("EFS")){
			quan=quan1;
		}
		
	//		double price_sqft= totprice/new Double(area).doubleValue();
		out.println("<tr><td width='10%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+line_no+"</td>");
		out.println("<td width='10%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+mark+"</td>");
		out.println("<td width='25%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+description+"</td>");
		out.println("<td valign='top' width='6%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+quan+"</td>");
		out.println("<td valign='top' width='10%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(totprice)+"</td>");
		out.println("<td valign='top' width='10%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+dimension+"</td>");
		if(area.equals("0")){
		out.println("<td valign='top' width='19%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+"&nbsp;--"+""+"</td>");
		}
		else{
		out.println("<td valign='top' width='19%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+"&nbsp;"+for1.format(totprice/(new Double(area).doubleValue()*new Double(quan).doubleValue()))+"</td>");
		}
		out.println("<td valign='top' width='50%'bgcolor='"+bgcolor+"' class='maindesc'>"+discount_show+"</td>");
		out.println("<td valign='top' width='50%'bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(factor)+"</td>");
		out.println("</tr>");
		out.println("<tr><td> -- factor value --- "+for1.format(factor)+"</td>");
		out.println("</tr>");
		

	factor=0;totprice=0;area="";discount_show="";
			}
	%>

</table>
<br><br>

<%
}
}
catch(Exception e2){
out.println("show_summary_body.jsp error::"+e2);  
}
%>