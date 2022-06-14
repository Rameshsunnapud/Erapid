
<%
if(numberOfSections>1){
	for(int j=0;j< numberOfSections; j++){
		String overageTEMP=overage;
		String setupTEMP=setup_cost;
		String freightTEMP=freight_cost;
		String handlingTEMP=handling_cost;
		double sectionSUM=0;
		double secSUM=0;
	for(int aa=0; aa<price.size(); aa++){
		if(secLINES.elementAt(j).toString().indexOf(","+line_item.elementAt(aa).toString()+",")>=0){
			secSUM=new Double(price.elementAt(aa).toString()).doubleValue()+secSUM;
		}
	}
	if(isOVERAGE){

		if(sectionOVERAGE.elementAt(j).toString()!= null && sectionOVERAGE.elementAt(j).toString().trim().length()>0){
			overage=sectionOVERAGE.elementAt(j).toString();
		}
		else{
			overage="0";
		}
	}
	else{
		if(new Double(tot_sum).doubleValue()>0){
			overage=""+new Double(overage).doubleValue()*(secSUM/new Double(tot_sum).doubleValue());
		}
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
		if(new Double(tot_sum).doubleValue()>0){
			freight_cost=""+new Double(freight_cost).doubleValue()*(secSUM/new Double(tot_sum).doubleValue());
		}
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
		if(setup_cost != null && setup_cost.trim().length()>0&&new Double(tot_sum).doubleValue()>0){
			setup_cost=""+new Double(setup_cost).doubleValue()*(secSUM/new Double(tot_sum).doubleValue());
		}
		else{
			setup_cost="0";
		}
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
		if(new Double(tot_sum).doubleValue()>0){
			handling_cost=""+new Double(handling_cost).doubleValue()*(secSUM/new Double(tot_sum).doubleValue());
		}
	}
%>
<font class='mainbodyh'><B>QUOTE SUMMARY ::</B><br><br></font>
<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'>
	<tr height='20'>
		<td width='4%' bgcolor='#006600'><font class='schedule'></font></td>
		<td width='8%' bgcolor='#006600'><font class='schedule'><b>Mark</b></font></td>
		<td width='18%' bgcolor='#006600'><font class='schedule'><b>Model</b></font></td>
		<td width='12%' bgcolor='#006600'><font class='schedule'><b>Qty</b></font></td>
		<td width='12%' bgcolor='#006600'><font class='schedule'><b>Price</b></font></td>
		<td width='12%' bgcolor='#006600'><font class='schedule'><b>Line Overage</b></font></td>
		<td width='12%' bgcolor='#006600'><font class='schedule'><b>Total Line Price</b></font></td>
		<td width='10%' bgcolor='#006600'><font class='schedule'><b>Discount/Pricing Level</b></font></td>
		<td width='12%' bgcolor='#006600'><font class='schedule'><b>Comission </b></font></td>
	</tr>
	<%
	String discount_show="";String line_no="";
			for(int k=0;k<line;k++){
	if(secLINES.elementAt(j).toString().indexOf(","+items.elementAt(k).toString()+",")>=0){

								String bgcolor="";
								if ((k%2)==1){bgcolor="#e4e4e4";}else {bgcolor="#EFEFDE";}
					   for (int mn=0;mn<line_item.size();mn++){
							if ((line_item.elementAt(mn).toString()).equals((items.elementAt(k).toString()))){
								if ((block_id.elementAt(mn).toString()).equals("A_APRODUCT")){
									line_no=line_item.elementAt(mn).toString();
								description=(desc.elementAt(mn)).toString();
								mark=(mark_no.elementAt(mn)).toString();
									if (!(discount.elementAt(mn)==null)){
									discount_show="B"+discount.elementAt(mn).toString().trim();//FIELD19
									}
									else{
									discount_show="";
									}
				    }
								if( !((block_id.elementAt(mn).toString()).equals("A_APRODUCT"))&&!block_id.elementAt(mn).toString().equals("B_CHARGES_DP"))	{
								String totwt=price.elementAt(mn).toString();//Extended_Price
								String fact=fact_per.elementAt(mn).toString().trim();//FIELD                                                                          16
								quan=QTY.elementAt(mn).toString();//QTY
								if ((fact.equals(""))){fact="0.0"; }
								  BigDecimal d1 = new BigDecimal(totwt);
								 BigDecimal d2 = new BigDecimal(fact);
								  BigDecimal d3 = d1.multiply(d2);
								 factor = factor+d3.doubleValue();// total comission dollars for the line
								  totprice=totprice+d1.doubleValue();//just the materail price no comission for the line
								totprice_dis=totprice_dis+d1.doubleValue();//Total material price for the job
								totcomm_dol= totcomm_dol+d3.doubleValue();// final commission dollars for the job
									if ((!(((fact_per.elementAt(mn)).toString()).equals("")))){
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
						}// then new if block specific to EJC
							}
					   }
		out.println("<tr><td width='4%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+line_no+"</td>");
		out.println("<td width='8%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+mark+"</td>");
		out.println("<td width='20%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+description+"</td>");
		out.println("<td valign='top' align='right' width='10%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+quan+"</td>");
		out.println("<td valign='top' align='right' width='12%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(totprice)+"</td>");
		if(secSUM>0){
			out.println("<td valign='top' align='right' width='12%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format((totprice/secSUM)*new Double(overage).doubleValue())+"</td>");
			out.println("<td valign='top' align='right' width='16%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(totprice+((totprice/secSUM)*new Double(overage).doubleValue()))+"</td>");
		}
		else{
			out.println("<td valign='top' align='right' width='12%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(0)+"</td>");
			out.println("<td valign='top' align='right' width='16%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(0)+"</td>");

		}
		out.println("<td valign='top' align='center' width='8%' bgcolor='"+bgcolor+"' class='maindesc'>"+discount_show+"</td>");
		out.println("<td valign='top' align='right' width='10%'bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(factor)+"</td>");
		out.println("</tr>");

	factor=0;totprice=0;discount_show="";
			}
			}
	%>

</table>
<br><br>
<%

		if( (!(( product.equals("EJC")|product.equals("IWP")|product.equals("EFS")) & (st.equals("2")|st.equals("3"))) )){%><%@ include file="show_summary_foot.jsp"%><%}
		overage=overageTEMP;
		//out.println(overage +" HERE");
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
		<td width='4%' bgcolor='#006600'><font class='schedule'></font></td>
		<td width='8%' bgcolor='#006600'><font class='schedule'><b>Mark</b></font></td>
		<td width='18%' bgcolor='#006600'><font class='schedule'><b>Model</b></font></td>
		<td width='12%' bgcolor='#006600'><font class='schedule'><b>Qty</b></font></td>
		<td width='12%' bgcolor='#006600'><font class='schedule'><b>Price</b></font></td>
		<td width='12%' bgcolor='#006600'><font class='schedule'><b>Line Overage</b></font></td>
		<td width='12%' bgcolor='#006600'><font class='schedule'><b>Total Line Price</b></font></td>
		<td width='10%' bgcolor='#006600'><font class='schedule'><b>Discount/Pricing Level</b></font></td>
		<td width='12%' bgcolor='#006600'><font class='schedule'><b>Comission </b></font></td>
	</tr>
	<%
	String discount_show="";String line_no="";
				for(int k=0;k<line;k++){
								String bgcolor="";
								if ((k%2)==1){bgcolor="#e4e4e4";}else {bgcolor="#EFEFDE";}
					   for (int mn=0;mn<line_item.size();mn++){
							if ((line_item.elementAt(mn).toString()).equals((items.elementAt(k).toString()))){
								if ((block_id.elementAt(mn).toString()).equals("A_APRODUCT")){
									line_no=line_item.elementAt(mn).toString();
								description=(desc.elementAt(mn)).toString();
								mark=(mark_no.elementAt(mn)).toString();
									if (!(discount.elementAt(mn)==null)){
									discount_show="B"+discount.elementAt(mn).toString().trim();//FIELD19
									}
									else{
									discount_show="";
									}
				    }
						if( !((block_id.elementAt(mn).toString()).equals("A_APRODUCT"))&&!block_id.elementAt(mn).toString().equals("B_CHARGES_DP"))	{
								String totwt=price.elementAt(mn).toString();//Extended_Price
								String fact=fact_per.elementAt(mn).toString().trim();//FIELD                                                                          16
								quan=QTY.elementAt(mn).toString();//QTY
								if ((fact.equals(""))){fact="0.0"; }
								  BigDecimal d1 = new BigDecimal(totwt);
								 BigDecimal d2 = new BigDecimal(fact);
								  BigDecimal d3 = d1.multiply(d2);
								 factor = factor+d3.doubleValue();// total comission dollars for the line
								  totprice=totprice+d1.doubleValue();//just the materail price no comission for the line
								totprice_dis=totprice_dis+d1.doubleValue();//Total material price for the job
								totcomm_dol= totcomm_dol+d3.doubleValue();// final commission dollars for the job
									if ((!(((fact_per.elementAt(mn)).toString()).equals("")))){
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
						}// then new if block specific to EJC
							}
					   }
		out.println("<tr><td width='4%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+line_no+"</td>");
		out.println("<td width='8%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+mark+"</td>");
		out.println("<td width='20%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+description+"</td>");
		out.println("<td valign='top' align='right' width='10%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+quan+"</td>");
		out.println("<td valign='top' align='right' width='12%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(totprice)+"</td>");
		if(tot_sum>0){
			out.println("<td valign='top' align='right' width='12%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format((totprice/tot_sum)*new Double(overage).doubleValue())+"</td>");
			out.println("<td valign='top' align='right' width='16%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(totprice+((totprice/tot_sum)*new Double(overage).doubleValue()))+"</td>");
		}
		else{
			out.println("<td valign='top' align='right' width='12%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(0)+"</td>");
			out.println("<td valign='top' align='right' width='16%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(0)+"</td>");

		}
		out.println("<td valign='top' align='center' width='8%' bgcolor='"+bgcolor+"' class='maindesc'>"+discount_show+"</td>");
		out.println("<td valign='top' align='right' width='10%'bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(factor)+"</td>");
		out.println("</tr>");

	factor=0;totprice=0;discount_show="";
			}
	%>
</table>
<br><br>
<%
}
%>

