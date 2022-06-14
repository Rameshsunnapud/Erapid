<%
	DecimalFormat df0x = new DecimalFormat("####");
	df0x.setMaximumFractionDigits(0);
	df0x.setMinimumFractionDigits(0);
	if(sec_lines.endsWith(","))
	{
	sec_lines=sec_lines.substring(0,sec_lines.lastIndexOf(','));
	}
	//out.println(totprice_dis+"::<BR>");
	if(project_type.equals("web")){
		df0x.setMaximumFractionDigits(2);
		df0x.setMinimumFractionDigits(2);
		totprice_dis=new Double(df0x.format(totprice_dis)).doubleValue();
		df0x.setMaximumFractionDigits(0);
		df0x.setMinimumFractionDigits(0);
	}
	else{
		totprice_dis=new Double(df0x.format(totprice_dis)).doubleValue();
	}

%>
<font class='mainbodyh'><B>PRICE SUMMARY ::</B><br><br></font>
<table cellspacing='0' align='center' cellpadding='1' border='0' width='75%' class='tableline'>
	<tr><td class='schedule1'>Configured Price:<b>&nbsp;

				<%
					if(project_type.equals("web")){
						out.println(totprice_dis);
					}
					else{
						out.println(for123.format(totprice_dis));
					}
				%>
			</b></td><td class='schedule1'>Extra Charges:<b><%= for1.format(new Double(freight_cost).doubleValue()) %></b></td></tr>
	<tr><td class='schedule1' colspan='2'>&nbsp;</td></tr>
	<tr><td class='schedule1'>Overage:<b><%= for1.format(new Double(overage).doubleValue()) %></b></td><td class='schedule1'>Freight Surcharge:<b><%= for1.format(new Double(handling_cost).doubleValue()) %></b></td></tr>
	<tr><td class='schedule1' colspan='2'>&nbsp;</td></tr>
	<tr><td class='schedule1'>Setup Cost:<b><%= for1.format(new Double(setup_cost).doubleValue()) %></b></td>
		<td class='schedule1'>Commission (%):<b>

				<%
				if(pid.equals("LVR")|pid.equals("REP_LVR")|pid.equals("BV")|pid.equals("GCP")|group.startsWith("Can")){
					out.println(commission);
				}
				else{
					if(totprice_dis>0){

						//if (prio.equals("E")){
							//out.println(for12.format(((totcomm_dol/(totprice_dis))*100)) );
						//}
						//else{
							//out.println(totcomm_dol+"::"+totprice_dis+":: ");
							out.println(for12.format(((totcomm_dol/(totprice_dis*0.91))*100)) );
						//}
					}
					else{
						out.println(for12.format(0));
					}
				}
				%>
			</b></td></tr>
	<tr><td class='schedule1' colspan='2'>&nbsp;</td></tr>


	<%

	if(!(st.equals("1"))){
		out.println("<tr><td class='schedule1'>Total Cost:<b>"+ for123.format(tot_cost) +"</b></td>");
		out.println("<td class='schedule1'>Total Weight:<b>"+ for12.format(tot_weight)+"</b></tr>");
		out.println("<tr><td class='schedule1' colspan='2'>&nbsp;</td></tr>");
	}


	if (!(pid.equals("GCP"))){

	%>
	<tr><td class='schedule1'>Total Commission :<b><%=  for1.format(totcomm_dol) %></b></td>
		<%
		if(isSafetyDollars){
			out.println("<td class='schedule1'>Total Safety :<b>"+  for1.format(safetyDollars)+" </b></td><td class='schedule1'>&nbsp;</td>");
		}

		if (pid.equals("EFS")&&!(st.equals("1"))){

	//out.println("EFS");
	double tempgmdol2=0;
	double tempgmperc2=0;


	tempgmdol2=totprice_dis+(new Double(overage).doubleValue())+(new Double(freight_cost).doubleValue())+(new Double(setup_cost).doubleValue())-totcomm_dol-tot_cost;


	tempgmperc2=(tempgmdol2/totprice_dis)*100;
	//out.println(tempgmperc2+"::");

		%>

		<td class='schedule1'>Total Gross Margin % :<b><%=  for12.format(tempgmperc2) %></b></td>
		<%


	}
	else{
		%>
		<td class='schedule1'>&nbsp;</td>
		<%
}
		%>
	</tr>
	<%


}

if(pid.equals("EJC")&&!group.toUpperCase().startsWith("REP")&&group.trim().length()>0){
	double tempgmdol2=0;
	double tempgmperc2=0;


	tempgmdol2=totprice_dis+(new Double(overage).doubleValue())-totcomm_dol-tot_cost-(new Double(overage).doubleValue()*0.5);


	tempgmperc2=(tempgmdol2/totprice_dis)*100;
	out.println("<tr><td class='schedule1' colspan='2'>&nbsp;</td></tr>");
	out.println("<tr>");
	%>
	<td class='schedule1'>Total Gross Margin $ :<b><%=  for12.format(tempgmdol2) %></b></td>
	<td class='schedule1'>Total Gross Margin % :<b><%=  for12.format(tempgmperc2) %></b></td></tr>
	<%

	}

	%>
</table>
<br>

<%
double adderGCP=totprice_dis;
//out.println(totprice_dis+"::1<BR>");
double taxtotalprice=totprice_dis;
totprice_dis=totprice_dis+(new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(setup_cost).doubleValue())+(new Double(freight_cost).doubleValue());
//out.println(totprice_dis+"::2<BR>");

if (pid.equals("GCP")){
	//out.println(commission+"::HERE");
	if(commission == null || commission.trim().equals("null") || commission.trim().length()==0){
		commission="0";
	}

	BigDecimal d2 = new BigDecimal(commission);
	totprice_dis=totprice_dis+((adderGCP*d2.doubleValue())/100);

}
else if(pid.equals("LVR")){
	/*ResultSet rs_projectx = stmt.executeQuery("SELECT configured_price,overage,handling_cost,freight_cost,setup_cost FROM cs_project where Order_no like '"+order_no+"'");
	if (rs_projectx !=null) {
		while (rs_projectx.next()) {
			if(rs_projectx.getString(1)!= null && rs_projectx.getString(1).length()>0){
				totprice_dis=rs_projectx.getDouble(1);
			}
			if(rs_projectx.getString(2)!= null && rs_projectx.getString(2).length()>0){
				totprice_dis=totprice_dis+rs_projectx.getDouble(2);
			}
			if(rs_projectx.getString(3)!= null && rs_projectx.getString(3).length()>0){
				totprice_dis=totprice_dis+rs_projectx.getDouble(3);
			}
			if(rs_projectx.getString(4)!= null && rs_projectx.getString(4).length()>0){
				totprice_dis=totprice_dis+rs_projectx.getDouble(4);
			}
			if(rs_projectx.getString(5)!= null && rs_projectx.getString(5).length()>0){
				totprice_dis=totprice_dis+rs_projectx.getDouble(5);
			}
		}

	}
	rs_projectx.close();*/
}

//out.println(totprice_dis+"::3<BR>");

//DecimalFormat df0 = new DecimalFormat("####");
//df0.setMaximumFractionDigits(0);
//df0.setMinimumFractionDigits(0);
%>
<table class='tableline' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only</b></td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>
				<%
					if(pid.equals("IWP")){
						if(project_type.equals("web")){
							out.println("$"+(totprice_dis-new Double(handling_cost).doubleValue()));
						}
						else{
							out.println("$"+df0.format(totprice_dis-new Double(handling_cost).doubleValue()));
						}
					}
					else{
						if(project_type.equals("web")){
							out.println("$"+totprice_dis);
						}
						else{
							out.println("$"+df0.format(totprice_dis));
						}
					}
				%>

				</font></b></td>
	</tr></table>

<%
if(pid.equals("IWP")){
%>
<table class='tableline' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b>Freight Surcharge</b></td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$<%=df0.format(new Double(handling_cost).doubleValue())%></font></b></td>
	</tr>
	<%
}
totcomm_dol=0;
double tax_dollar=0;
double grand_total=0;
if(tax_perc.equals("null")||tax_perc==null){
	tax_perc="0";
}
if(pid.equals("GCP")){
	totprice_dis=taxtotalprice;
}
//Earlier this below piece was commented. Praveen is removing to fix 2 times overage issue. 
//But this one was commented due to some reason need to check with Greg
if(pid.equals("IWP")){
	totprice_dis=totprice_dis-new Double(handling_cost).doubleValue()-new Double(overage).doubleValue();
}
//out.println(order_no+"::"+tax_perc+"::"+overage+"::"+handling_cost+"::"+freight_cost+"::a"+setup_cost1+"a::"+setup_cost+"::-->"+totprice_dis+"<--::b"+sec_lines+"b::"+pid+"::<BR>");
String temptotalprice_dis=df0.format(totprice_dis);
if(project_type.equals("web")){
	temptotalprice_dis=""+totprice_dis;
}

	%>

	<jsp:include page="../quotes/summary_tax.jsp" flush="true">
		<jsp:param name="order_no" value="<%= order_no%>"/>
		<jsp:param name="tax_perc" value="<%= tax_perc%>"/>
		<jsp:param name="overage" value="<%=overage %>"/>
		<jsp:param name="handling_cost" value="<%=handling_cost %>"/>
		<jsp:param name="freight_cost" value="<%=freight_cost %>"/>
		<jsp:param name="setup_cost1" value=""/>
		<jsp:param name="setup_cost" value="<%= setup_cost%>"/>
		<jsp:param name="totprice_dis" value="<%= temptotalprice_dis%>"/>
		<jsp:param name="secLines" value="<%= sec_lines%>"/>
		<jsp:param name="product_id" value="<%= pid%>"/>
	</jsp:include>







</table>

<br>
<%

if(pid.equals("EFS")){
%>
<table cellspacing='0' cellpadding='0' border='0' width='100%'>
	<tr><td class='mainbodyh'><sup>* </sup>Dollars/sq ft does not include "Extra costs"</td></tr>
	<tr><td >&nbsp;</td></tr>
</table>
<%
}

%>

