<%
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
ResultSet rs3 = stmt.executeQuery("SELECT * FROM csquotes where order_no like '"+order_no+"' and Block_ID !='A_APRODUCT'  and cast(extended_price as numeric)>0 and product_id in('GCP') order by cast(Line_no as integer),block_id desc");
while (rs3.next()) {
	line_item.addElement(rs3.getString ("Line_no"));
	desc.addElement(rs3.getString ("Descript"));
	price.addElement(rs3.getString ("extended_price"));
	QTY.addElement(rs3.getString("QTY"));
	rec_no.addElement(rs3.getString("Record_no"));
	block_id.addElement(rs3.getString("Block_ID"));
	fact_per.addElement(rs3.getString("field16"));
	mark.addElement(rs3.getString("field17"));
	run_cost.addElement(rs3.getString("run_cost"));
	std_cost.addElement(rs3.getString("std_cost"));
	setup_cost1.addElement(rs3.getString("setup_cost"));
	totprice_dis=totprice_dis+ new Double(rs3.getString("extended_price")).doubleValue();
	//out.println(totprice_dis+"::<BR>");
	tot_lines++;
}
rs3.close();
//out.println(totprice_dis+"::"+freight_cost+"::<BR>");
//totprice_dis=totprice_dis+new Double(freight_cost).doubleValue();
//out.println(totprice_dis+"::"+freight_cost+"::<BR>");
double default_gross_margin=0.43; //per Tino 6/25/08
if(commission==null){
	commission="0";
}
BigDecimal d2x = new BigDecimal(commission);
double comm = 0;
double cost = totprice_dis * (1 - default_gross_margin);
double subtotal = cost + new Double(freight_cost).doubleValue();
if(userGroup.toUpperCase().startsWith("REP")){
	//out.println("HERE");
	totprice_dis=totprice_dis+((totprice_dis*new Double(commission).doubleValue())/100);
	//if (prio.equals("E")){
		//comm = totprice_dis  * d2x.doubleValue() / 100;
	//}
	//else{
		comm = totprice_dis * 0.91 * d2x.doubleValue() / 100;
	//}
	//out.println(totprice_dis+"::"+commission+"<br>");
}
double sell = new Double(totprice_dis).doubleValue();
double margin = 0;

if(!userGroup.toUpperCase().startsWith("REP")){
	if((gross_margin!=null) && (new Double(gross_margin).doubleValue()>0)){
		sell = subtotal / (1 - new Double(gross_margin).doubleValue() / 100 - 0.91 * d2x.doubleValue() / 100);
		//if (prio.equals("E")){
			//comm = sell* d2x.doubleValue() / 100;
	//	}
		//else{
			comm = sell * 0.91 * d2x.doubleValue() / 100;
		//}
		//out.println(comm+"::<BR>");
		totprice_dis=(sell - new Double(freight_cost).doubleValue());
	}
}
BigDecimal d0 = new BigDecimal(totprice_dis);
/*
grand_total=Double.parseDouble(o_cost)+Double.parseDouble(handling_cost)+sell;
double grand_totalx=grand_total;
double tax_dollar=(grand_total*Float.parseFloat(tax_perc))/100;
grand_total=grand_total+tax_dollar;
*/


/*
double fcomm=(totprice_dis*0.91*(new Double(commission).doubleValue()/100))/(1-(new Double(gross_margin).doubleValue()/100)-0.91*(new Double(commission).doubleValue()/100));
totprice_dis=totprice_dis+fcomm;
out.println(fcomm+"::");
*/
//outputPrice=""+(new Double(outputPrice).doubleValue()+fgm+fcomm);

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
if(project_type != null &(project_type.equals("PSA")& userGroup.toUpperCase().startsWith("REP") )&&(userGroup==null || userGroup.toUpperCase().startsWith("REP"))){
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
	out.println("<tr>");
	out.println("<td width='30%' height='30%' class='test1' bordercolor='#C0C0C0'>"+"&nbsp; GCP Order Information : "+"<td>");
	out.println("<td width='70%' height='30%' bordercolor='#C0C0C0'>"+"&nbsp;"+"<td>");
	out.println("</tr>");
	if(project_type != null && project_type.equals("PSA") &&(userGroup.toUpperCase().startsWith("REP") &&session_group.toUpperCase().startsWith("REP") ) ){
	 	out.println("<Tr><TD><BR>PER QUOTE : "+order_no +"<BR><BR><td></tr>");
		String schedule="";double com_perc=0;String markf="";String gas_color="NONE";
		double adders=0;
		for(int k=0;k<line;k++){
			String bgcolor="";
			for (int mn=0;mn<line_item.size();mn++){
				if ((mn%2)==1){bgcolor="white";}else {bgcolor="#E7E7E7";}
				if ((items.elementAt(k).toString()).equals((line_item.elementAt(mn).toString()))){
					//String totwt=""+(new Double(price.elementAt(mn).toString()).doubleValue()+adders);
					//adders=0;
					//String fact=fact_per.elementAt(mn).toString().trim();
					quan=QTY.elementAt(mn).toString();
					//if ((fact.trim().length()<=0)){fact="0.0"; }
					//BigDecimal d1 = new BigDecimal(totwt);
					//BigDecimal d2 = new BigDecimal(fact);
					////BigDecimal d3 = d1.multiply(d2);
					//factor = factor+d3.doubleValue();
					//totprice=d1.doubleValue();
					//totprice_dis=totprice_dis+d1.doubleValue();
					description=(desc.elementAt(mn)).toString();
					markf=(mark.elementAt(mn)).toString();
					/*
					if ((!(((fact_per.elementAt(mn)).toString()).equals("")))){
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
					*/
				}
			}
		}
		out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
		out.println("<tr>");
		//if(project_type.equals("NCP")){
		//	totprice_dis=new Double(totmat_price).doubleValue();
		//}
		//totprice_dis=totprice_dis+(new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(freight_cost).doubleValue());
		out.println("<td class='tdnodash' width='33%'>TOTAL PRICE($):&nbsp;<b>"+for1.format(totprice_dis)+"</b></td>");

	}
	else{
		//out.println("HERE");
		out.println("<tr>");
		out.println("<td width='100%' height='30%'  bordercolor='#C0C0C0'>");
		out.println("<table width='100%' border='1' cellspacing='0' cellpadding='0' class='tb'>");
		/*
		if(project_type != null && project_type.equals("NCP")){
			if(nonconfigPRICE == null || nonconfigPRICE.equals("null")){	nonconfigPRICE="0";	}
			totprice_dis=totprice_dis+new Double(nonconfigPRICE).doubleValue();
			out.println("<tr><td height='30' class='tdheader2'>"+nonconfigDesc+"</td></tr>");
		}
		else{
		*/
			out.println("<tr>");
			out.println("<td align='center' height='30' class='tdheader2'>MODEL</td>");
			out.println("<td align='center' height='30' class='tdheader2'>QTY</td>");
			out.println("<td align='center' height='30' class='tdheader2'>Unit Price</td>");
			out.println("<td align='center' height='30' class='tdheader2'>EXT. PRICE</td>");
			out.println("<td align='center' height='30' class='tdheader2'>Comm(%)</td>");
			out.println("</tr>");
			String schedule="";double com_perc=0;String markf="";String gas_color="NONE";
			//double adders=0;
			double unit_price=0;
			int lines_to_show=0;
			for(int k=0;k<line;k++){
				String bgcolor="";lines_to_show=0;
				for (int mn=0;mn<line_item.size();mn++){
					if ((mn%2)==1){bgcolor="white";}else {bgcolor="#E7E7E7";}
					if ((items.elementAt(k).toString()).equals((line_item.elementAt(mn).toString()))){
					/*
						if(block_id.elementAt(mn).toString().equals("C_OPTIONS")){
							adders=adders+new Double(price.elementAt(mn).toString()).doubleValue();
						}
						else{


							adders=0;
							*/
							String totwt=""+(new Double(price.elementAt(mn).toString()).doubleValue());
							String fact=fact_per.elementAt(mn).toString().trim();
							BigDecimal d1 = new BigDecimal(totwt);
							if ((fact.trim().length()<=0)){fact="0.0"; }

							BigDecimal d2 = new BigDecimal(fact);
							BigDecimal d3 = d1.multiply(d2);
							factor = factor+d3.doubleValue();

							//totprice_dis=totprice_dis+d1.doubleValue();

							quan=QTY.elementAt(mn).toString();


							totprice=d1.doubleValue();
							description=(desc.elementAt(mn)).toString();
							markf=(mark.elementAt(mn)).toString();
							if(quan==null|(quan.trim().length()<=0)){quan="0.0";}
							unit_price=totprice/new Double(quan).doubleValue();
							/*
							if ((!(((fact_per.elementAt(mn)).toString()).equals("")))){
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
							*/
							out.println("<tr>");
							out.println("<td align='left' class='tdheader2' bgcolor="+bgcolor+">&nbsp;"+description.trim()+"</td>");
							out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+">&nbsp;"+quan+"</td>");
							for1.setMaximumFractionDigits(5);
							out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+">&nbsp;"+for1.format(unit_price)+"</td>");
							if(project_type.equals("web")){
								for1.setMaximumFractionDigits(2);
								for1.setMinimumFractionDigits(2);
							}
							else{
								for1.setMaximumFractionDigits(0);
							}
							out.println("<td align='RIGHT' class='tdheader2' bgcolor="+bgcolor+">&nbsp;"+for1.format(totprice)+"</td>");
							out.println("<td align='RIGHT' class='tdheader2' bgcolor="+bgcolor+">&nbsp;"+commission+"</td>");
							out.println("</tr>");
						//}
					}
					totprice=0;unit_price=0;
					imp.clear();
					schedule="";markf="";gas_color="NONE";description="";
				}
			}
		//}
		if(project_type == null){
			project_type="";
		}
		out.println("</table>");
		out.println("<td>");
		out.println("</tr>");
		NumberFormat for12 = NumberFormat.getInstance();
		for12.setMaximumFractionDigits(2);
		out.println("<tr>");
		out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tddashtop'>");
		out.println("<table border='1' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
		out.println("<tr>");
		totprice_dis=totprice_dis+(new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(freight_cost).doubleValue())+(new Double(setup_cost).doubleValue());
		out.println("<td class='tdnodash' width='33%'>TOTAL PRICE($):&nbsp;<b>"+for1.format(totprice_dis)+"</b></td>");
		for1.setMaximumFractionDigits(2);
		out.println("<td class='tdnodash' width='33%'>STD.commission:&nbsp;<b>"+for1.format(comm)+"</b></td>");
		out.println("<td class='tdnodash' width='33%'>OVERAGE AMOUNT($):&nbsp;<b>"+for1.format(new Double(overage).doubleValue())+"</b></td>");
		for1.setMaximumFractionDigits(0);
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
		if(project_type != null && project_type.equals("NCP")){
			out.println("<td class='tdnodash' width='25%'>STD commission(%):&nbsp;<b>"+commission+"</b></td>");
		
		}
		/*else if (prio.equals("E")){
			out.println("<td class='tdnodash' width='25%'>STD commission(%):&nbsp;<b>"+for12.format((factor/((totprice_dis-((new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(freight_cost).doubleValue())))))*100)+"</b></td>");
		}*/
		else {
			out.println("<td class='tdnodash' width='25%'>STD commission(%):&nbsp;<b>"+for12.format((factor/((totprice_dis-((new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(freight_cost).doubleValue())))*.91))*100)+"</b></td>");
		}
		
		out.println("</tr>");
		out.println("</table></td>");
		out.println("</tr>");
	}
	out.println("<tr>");
	out.println("<td align='center' width='100%' height='30' class='tdheader'>"+"&nbsp;"+"</td>");
	out.println("</tr>");

}

%>


