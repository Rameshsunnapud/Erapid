<%
	DecimalFormat df0 = new DecimalFormat("####");
	int numLeafs=0;
	ResultSet rssum=stmt.executeQuery("SELECT sum(cast (qty as integer)) as a1 FROM csquotes WHERE order_no='"+ order_no +"' and block_id = 'A_CORE'");
	if(rssum != null){
		while(rssum.next()){
			numLeafs=Integer.parseInt(rssum.getString(1));
		}
	}
	rssum.close();
	out.println("<table border='0' width='100%' align='center'><tr><td><font class='maindesc'>Scope: CS proposes to furnish a total of ("+numLeafs+") Acrovyn Door leaf(s) as listed herein.</font></td></tr></table><BR>");
	/*out.println("<table border='0' width='100%' align='center'><tr><td><font class='maindesc'>Scope: CS proposes to furnish the following:</font></td></tr></table><BR>");
 // "total of ("+numLeafs+") 1-3/4\" thick Acrovyn Door leaf(s) as listed herein.</font></td></tr></table><BR>");*/
	out.println("<table border='1' width='100%' align='center'><tr><td wdith='15%' class='maindesc'><b>Model</b></td><td width='10%' class='maindesc' align='center'><b>Qty</b></td><td width='75%' class='maindesc'><b>Description</b></td></tr>");
	Vector v1=new Vector();
	Vector v2=new Vector();
	ResultSet rsa=stmt.executeQuery("select field18 as a2, sum(cast(qty as integer)) as a1 from csquotes where order_no = '"+ order_no +"' and block_id = 'A_CORE' group by field18 order by field18");
	if(rsa != null){
		while(rsa.next()){
			v1.addElement(rsa.getString(1));
			v2.addElement(rsa.getString(2));
		}
	}
	rsa.close();

	for(int i=0; i<v1.size();i++){
		String tempDesc="";
		ResultSet rsb=stmt.executeQuery("select description from cs_ads_margin where model='"+v1.elementAt(i).toString()+"'");
		if(rsb !=null){
			while(rsb.next()){
				tempDesc=rsb.getString(1);
			}
		}
		rsb.close();

		out.println("<tr><td class='maindesc'>"+v1.elementAt(i).toString()+"</td><td class='maindesc' align='center'>"+v2.elementAt(i).toString()+"</td><td class='maindesc'>"+tempDesc+"</td></tr>");
	}
	out.println("</table>");
	if(price1.trim().length()<=0){
		price1="0";
	}
	ResultSet rsb2 = stmt.executeQuery("SELECT extended_price as a1 FROM csquotes WHERE order_no='"+ order_no +"' ");
	if(rsb2 != null){
		while(rsb2.next()){
			//	out.println(df0.format(rsb2.getDouble("a1"))+"::"+rsb2.getString("a1")+"::"+price1+"::<BR>");
				price1=""+(new Double(price1).doubleValue()+rsb2.getDouble("a1"));
			//	out.println(price1+"::<BR><BR>");
		}
	}
	rsb2.close();

	if(price1 == null||price1.trim().length()==0){
		price1="0";
	}
	if(overage!=null && !overage.trim().equals("null")){
		price1=""+(new Double(price1).doubleValue()+new Double(overage).doubleValue());
	}
	if(handling_cost!=null && !handling_cost.trim().equals("null")){
		price1=""+(new Double(price1).doubleValue()+new Double(handling_cost).doubleValue());
	}
	if(freight_cost!=null && !freight_cost.trim().equals("null")){
		price1=""+(new Double(price1).doubleValue()+new Double(freight_cost).doubleValue());
	}
	if(setup_cost!=null && !setup_cost.trim().equals("null")){
		price1=""+(new Double(price1).doubleValue()+new Double(setup_cost).doubleValue());
	}
 if(sfdcNotes != null && sfdcNotes.trim().length()>0){
	out.println("<table width='100%'><tr><td class='mainbody'><b>"+sfdcNotes+"</b></td></tr></table><BR>");

 }
%>
&nbsp;

&nbsp;
<br>
<table class='<%= border_color %>' cellspacing='0' cellpadding='0' border='0' width='100%' align='center' height='25'><tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only</b></td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= for0.format(new Double(price1).doubleValue()) %></font>&nbsp;<%=currencyName%></b></td>
	</tr>


	<%
	if(setup_cost==null || setup_cost.trim().length()==0){
		setup_cost="0";
	}
	//out.println(":::"+setup_cost+":::"+taxtotal+":::"+product+":::"+secLines+":::<BR>");
	if(tax_perc != null && tax_perc.trim().length()>0 && ! tax_perc.equals("0")){
	%>
	<jsp:include page="summary_tax.jsp" flush="true">
		<jsp:param name="order_no" value="<%= order_no%>"/>
		<jsp:param name="tax_perc" value="<%= tax_perc%>"/>
		<jsp:param name="overage" value="<%=overage %>"/>
		<jsp:param name="handling_cost" value="<%=handling_cost %>"/>
		<jsp:param name="freight_cost" value="<%=freight_cost %>"/>
		<jsp:param name="setup_cost1" value="0"/>
		<jsp:param name="setup_cost" value="<%= setup_cost%>"/>
		<jsp:param name="totprice_dis" value="<%= price1%>"/>
		<jsp:param name="isquote" value="yes"/>
		<jsp:param name="product_id" value="<%= product%>"/>
		<jsp:param name="secLines" value="<%= secLines%>"/>
		<jsp:param name="currencyName" value="<%= currencyName%>"/>
	</jsp:include>
	<%
	if(setup_cost!=null && !setup_cost.trim().equals("null") && new Double(setup_cost).doubleValue()>0){

	%>

	<tr>
		<td class='maindesc' colspan='2' valign='middle' align='right'>Includes a Coordination fee of: $<%=setup_cost%></td>
	</tr>
	<%}

}
else{
	%>

	<tr>
		<td class='maindesc' colspan='2' valign='middle'>Price is FOB plant, freight prepaid within continental U.S. or FAS dock export point. Tax not included.</td>
	</tr>
	<%
	if(setup_cost!=null && !setup_cost.trim().equals("null") && new Double(setup_cost).doubleValue()>0){

	%>

	<tr>
		<td class='maindesc' colspan='2' valign='middle' align='right'>Includes a Coordination fee of: $<%=setup_cost%></td>
	</tr>
	<%
}
}
	%>




</table>
<br>
<table width='100%' align='center' border='0' style='border-collapse: collapse;' cellspacing='0' cellpadding='2'>
	<tr>
		<%

		out.println("<td colspan='2' width='50%' class='maindesc' align='left'><b>Estimator:</b> "+sfdc_estimator+"</td>");
		out.println("<td colspan='2' width='50%' class='maindesc' align='left'><b>Regional Sales Manager(RSM):</b>"+ psa_rsm+"</td>");
		%>
		<!--<td colspan='4' class='maindesc'><b>Regional Sales Manager(RSM):&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</b>....................................................................................................
		<BR></td>-->
	</tr>
	<tr>
		<td width='50%' align='left' colspan='2' nowrap class='maindesc'><b><u>Acceptance:</u></b></td>
		<td width='50%' align='left' colspan='2' nowrap class='maindesc'><b><u>Shipping:</u></b> </td>
	</tr>
	<tr>
		<td width='20%' align='left' nowrap class='maindesc'>Bill To: </td>
		<td width='30%' valign='bottom' class='mainbodyh'>..................................................</td>
		<td width='20%' align='left' nowrap class='maindesc'>Ship To: </td>
		<td width='30%' valign='bottom' class='mainbodyh'>..................................................</td>
	</tr>
	<tr><td align='left' nowrap class='maindesc'>Address:</td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
		<td align='left' nowrap class='maindesc'>Address: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
	</tr>
	<tr><td align='left' nowrap class='maindesc'>City/State/Zip: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
		<td align='left' nowrap class='maindesc'>City/State/Zip: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
	</tr>
	<tr><td align='left' nowrap class='maindesc'>Purchase Order No: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
		<td align='left' nowrap class='maindesc'>Requested Delivery Date: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
	</tr>
	<tr><td align='left' nowrap class='maindesc'>Customer Name: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
		<td align='left' nowrap class='maindesc'></td>
		<td valign='bottom' class='mainbodyh'></td>
	</tr>
	<tr><td align='left' nowrap class='maindesc'>Customer Signature: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
		<td align='left' nowrap class='maindesc'></td>
		<td valign='bottom' class='mainbodyh'></td>
	</tr>
	<tr><td align='left' nowrap class='maindesc'>Email Address: </td>
		<td valign='bottom' class='mainbodyh'>..................................................</td>
		<td align='left' nowrap class='maindesc'></td>
		<td valign='bottom' class='mainbodyh'></td>
	</tr>

	<tr><td  colspan='4'></td></tr>
</table>
<br>
<p style='page-break-after : always;' >&nbsp;</p>

<%
 if(qualifying_notes_free_text != null && qualifying_notes_free_text.trim().length()>0){
	//out.println("::"+free_text_cs_project+"::");
	//out.println("<table width='100%'><tr><td class='mainbody'><b><i>"+qualifying_notes_free_text+"</b></i></td></tr></table><BR>");
	out.println("<table width='100%' border='0'><tr><td class='maintitle' width='20%'><b>NOTES: </td><td width='80%'>&nbsp;</td></tr>");
	out.println("<tr><td><img src='../../images/ads_notes.png' width='20' rowspan='2'><td class='mainbody'><b><i>"+qualifying_notes_free_text+"</b></i></td></tr></table><BR>");
	out.println("<tr></td><td class='maintitle'>"+free_text_cs_project+"</td></tr></table><BR>");
 }
%>





<table border='0' width='100%' align='center'><tr><td>
			<font class='maindesc'>
			<b> Qualifying Notes:</b><br><br>
			<%
			String currentType="";
			if(qualifying_notes != null && qualifying_notes.trim().length()>0){
				ResultSet cs_qlf_notes = stmt.executeQuery("select description,type FROM cs_qlf_notes where product_id='ADS' and code in ("+qualifying_notes+") order by TYPE,code ");
				if (cs_qlf_notes !=null) {
					while (cs_qlf_notes.next()) {
						if((currentType.trim().length()==0||!currentType.equals(cs_qlf_notes.getString(2)))&&cs_qlf_notes.getString("type")!=null){
							String tempType="";
							if(cs_qlf_notes.getString("type").equals("DOOR")){
								tempType="Doors:";
							}
							else if(cs_qlf_notes.getString("type").equals("FRAME")){
								tempType="Frames:";
							}
							//if(tempType!=null && tempType.trim().length()>0){
							//	out.println("<b>"+ tempType+"</b><br>");
							//}
						}
						if(cs_qlf_notes.getString("type")!=null){
							currentType=cs_qlf_notes.getString("type");
						}
						out.println(cs_qlf_notes.getString("description")+"<br>");
					}
				}
				cs_qlf_notes.close();
			}





			%>
			<!--Net sizing and beveling.<br>
			Machining for mortised hardware.<br>
			Drilling of pilot holes for full mortise hinges and lock fronts.<br>
			Marking for openings.<br>
			Metal light frames primed for painting. <br> -->
			<br><b> Exclusions:</b><br>
			<%
			currentType="";
			if(exclusions != null && exclusions.trim().length()>0){
				ResultSet cs_exc_notes = stmt.executeQuery("select description,type FROM cs_exc_notes where product_id='ADS' and code in ("+exclusions+") order by code ");
				if (cs_exc_notes !=null) {
					while (cs_exc_notes.next()) {
						if((currentType.trim().length()==0||!currentType.equals(cs_exc_notes.getString(2)))&&cs_exc_notes.getString("type")!=null){
							String tempType="";
							if(cs_exc_notes.getString("type").equals("DOOR")){
								tempType="Doors:";
							}
							else if(cs_exc_notes.getString("type").equals("FRAME")){
								tempType="Frames:";
							}
							//if(tempType!=null && tempType.trim().length()>0){
							//	out.println("<b>"+ tempType+"</b><br>");
							//}
						}
						if(cs_exc_notes.getString("type")!=null){
							currentType=cs_exc_notes.getString("type");
						}
						out.println(cs_exc_notes.getString("description")+"<BR>");
					}
				}
				cs_exc_notes.close();
			}
			%>
			<!--
			Coordination with frames and hardware is by others.  Hardware templates and information to be provided at time of order.<br>
			Shop drawings.<br>
			Glass and glazing and louvers.<br>
			Door frames, hardware, and installation of door accessories and hardware.<br>
			Drilling of thrubolt holes.<br>
			Field measurements.<br>
			Export packaging or containers.<br>
			Concealed overhead closers, pivots and all recessed panic devices for all fire rated doors (not labeled).<br>
			Astragals unless specifically called out in quote request.  See add below.<br>
			Replaceable edges on 90-minute and all lead lined doors.  Acrovyn fixed wrapped edges apply.<br>
			<br><b> Comments(s):</b><br>
			Changes to machining or hardware on rated and non rated doors may affect the construction of the doors.  Price adjustments may apply.<br>
			Door Coordination: If CS is to coordinate the order add the following: $5.00 per door (new frame); $10.00 per door (existing frame).  Minimum $90.00 coordination charge applies.<br>
			For metal astragals add the following depending on the height of the doors: For 6&#39;-0" & 7&#39;-0" add $75.00; for 8&#39;-0" add $80.00.<br>
			Light frames have been quoted as primed metal frames.  If wood bead or veneer wrapped metal is required please contact the factory for correct pricing. <br>
			Lead times: Please call 800-972-7214 for up to date material lead times.<br> -->

			<br><b>TERMS & CONDITIONS:</b>
			<br>Prices are firm against escalation for 30 days from date of this quote and subject to Construction Specialties Terms and Conditions of Offer in effect as of the date here on and located at <a href="https://www.c-sgroup.com/terms-and-conditions">https://www.c-sgroup.com/terms-and-conditions</a>
			<br>Printed Terms and Conditions of Offer can be provided by emailing your request to terms@c-sgroup.com. 
			<br>This quotation together with Construction Specialties Terms and Conditions of Offer constitutes the entire agreement between the parties.
			
			<!--<br>1. CS Standard Terms and Conditions shall apply.-->
			<!-- <br>2. Payment terms are Net 30 Days, with no retention allowed. 
			<br>2. Payment terms are net 30 days with no retention allowed, subject to credit approval by Construction Specialties.  Construction Specialties reserves the right to modify payment terms upon review of customers credit history.
			<br>3. Prices are firm against escalation for 90 days from date of this quote, and for shipment within 6 months thereafter. Orders shipped beyond shall be subject to escalation of <b>0.5%</b> per month for each month or partial month thereafter and invoiced at time of shipment.
			<br>4. The quotation may be withdrawn if not accepted within 90 days of quotation.
			<br>5. Orders resulting from this quotation should be made out to Construction Specialties, Inc. c/o the representative listed above.
			<BR>6. Credit terms are subject to change upon investigation of credit prior to Construction Specialties acceptance of the order.
			<BR>7. Price includes a single delivery shipment in box trucking with standard packaging.
			<BR>8. For projects located outside the U.S. Construction Specialties requires that all freight forwarders who handle CS product be C-TPAT certified. Please contact your local representative for more information and a list of available C-TPAT carriers in your area.
			<BR>9. Construction Specialties, Inc. will be listed as the USPPI (United States Principal Party in Interest) on all transactions for shipments exporting from the US.  This will include filing with US Customs and Export Documentation completion.
			<BR><BR>>-->


		</td></tr></table>
<p style='page-break-after : always;' >&nbsp;</p>
<table width='100%' align='center' border='1'>
	<%

/*
	//cs_ads_price_calc
	Vector model2=new Vector();
	Vector qty2=new Vector();
	Vector cost2=new Vector();
	Vector catchall=new Vector();
	Vector drafting=new Vector();
	Vector layout=new Vector();
	Vector projectMgmt=new Vector();
	Vector coordination=new Vector();
	Vector coordinationDollar=new Vector();
	Vector defaultMargin=new Vector();
	Vector margin = new Vector();
	Vector linePrice=new Vector();
	Vector freight=new Vector();
	Vector commissionx=new Vector();
	Vector modelCost=new Vector();
	ResultSet rs11=stmt.executeQuery("select * from cs_ads_price_calc where order_no='"+order_no+"' and not model='GLOBAL' order by model");
	if(rs11 != null){
		while(rs11.next()){

			model2.addElement(rs11.getString("model"));
			qty2.addElement(rs11.getString("qty"));
			cost2.addElement(rs11.getString("cost"));
			catchall.addElement(rs11.getString("catchall"));
			drafting.addElement(rs11.getString("drafting"));
			layout.addElement(rs11.getString("layout"));
			projectMgmt.addElement(rs11.getString("projectMgmt"));
			coordination.addElement(rs11.getString("coordination"));
			coordinationDollar.addElement(rs11.getString("coordinationDollars"));
			margin.addElement(""+new Double(rs11.getString("margin")).doubleValue()/100);
			linePrice.addElement(rs11.getString("linePrice"));
			freight.addElement(rs11.getString("freight"));
			commissionx.addElement(rs11.getString("commission"));
			double tempModelCost=0;
			tempModelCost=tempModelCost+new Double(rs11.getString("cost")).doubleValue();
			tempModelCost=tempModelCost+new Double(rs11.getString("catchall")).doubleValue();
			tempModelCost=tempModelCost+new Double(rs11.getString("drafting")).doubleValue();
			tempModelCost=tempModelCost+new Double(rs11.getString("layout")).doubleValue();
			tempModelCost=tempModelCost+new Double(rs11.getString("projectMgmt")).doubleValue();
			tempModelCost=tempModelCost+new Double(rs11.getString("coordinationDollars")).doubleValue();
			tempModelCost=tempModelCost+new Double(rs11.getString("freight")).doubleValue();
			tempModelCost=tempModelCost+new Double(rs11.getString("commission")).doubleValue();
			modelCost.addElement(""+tempModelCost);
		}
	}
	rs11.close();
	Vector block_id3=new Vector();
	Vector line_no3=new Vector();
	Vector model3=new Vector();
	Vector qty3=new Vector();
	Vector cost3=new Vector();
	Vector mark3=new Vector();
	Vector bpcsNo3=new Vector();
	ResultSet rsCSQUOTES2=stmt.executeQuery("select block_id,field18,cast(field19 as integer), cast(extended_price as float),line_no,field17,bpcs_part_no from csquotes where order_no='"+order_no+"' and not block_id ='A_APRODUCT' order by cast(line_no as integer),bpcs_part_no,field18 desc");
	if(rsCSQUOTES2 != null){
		while(rsCSQUOTES2.next()){
			block_id3.addElement(rsCSQUOTES2.getString(1));
			model3.addElement(rsCSQUOTES2.getString(2));
			qty3.addElement(rsCSQUOTES2.getString(3));
			cost3.addElement(rsCSQUOTES2.getString(4));
			line_no3.addElement(rsCSQUOTES2.getString(5));
			//out.println(rsCSQUOTES2.getString(5)+"::<BR>");
			mark3.addElement(rsCSQUOTES2.getString(6));
			bpcsNo3.addElement(rsCSQUOTES2.getString(7));
			//out.println(rsCSQUOTES2.getString(7)+"::");
		}
	}
	rsCSQUOTES2.close();
	//out.println("<table border='1' width='100%'><tr class='important'><td class='header' colspan='9' align='center'>Line Detail</td></tr><tr><td class='header2' width='10%'>Line#</td><td class='header2' width='10%'>MK</td><td class='header2' width='20%'>Part</td><td class='header2' width='10%'>QTY</td><td class='header2' width='10%'>Base Tot Cost</td><td class='header2' width='10%'>Unit Cost</td><td class='header2' width='10%'>Tot Cost</td><td class='header2' width='10%'>Unit Sell</td><td class='header2' width='10%'>Total Sell</td></tr>");
	Vector line_no4=new Vector();
	Vector qty4=new Vector();
	Vector baseCost4=new Vector();
	Vector mark4=new Vector();
	Vector unitCost4=new Vector();
	Vector totCost4=new Vector();
	Vector unitSell4=new Vector();
	Vector totSell4=new Vector();
	Vector bpcsNo4=new Vector();
	String oldLineNo="";
	String oldMark="";
	String oldQty="";
	String oldBpcs="";
	double oldBaseCost=0;
	double oldUnitCost=0;
	double oldTotCost=0;
	double oldUnitSell=0;
	double oldTotSell=0;
	for(int i=0; i<line_no3.size(); i++){
		double percent=0;
		double costTemp=0;
		double sellTemp=0;
		double unitCostTemp=0;
		double unitSellTemp=0;
		for(int j=0; j<model2.size(); j++){
			if(model2.elementAt(j).toString().equals(model3.elementAt(i).toString())){
				percent=new Double(cost3.elementAt(i).toString()).doubleValue()/new Double(cost2.elementAt(j).toString()).doubleValue();
				costTemp=percent*new Double(modelCost.elementAt(j).toString()).doubleValue();
				sellTemp=percent*new Double(linePrice.elementAt(j).toString()).doubleValue();
				unitCostTemp=costTemp/new Double(qty3.elementAt(i).toString()).doubleValue();
				unitSellTemp=sellTemp/new Double(qty3.elementAt(i).toString()).doubleValue();
				j=model2.size();
			}
		}
		if(i==0||!oldLineNo.equals(line_no3.elementAt(i).toString())||!oldBpcs.equals(bpcsNo3.elementAt(i).toString())){
			if(i>0){
				bpcsNo4.addElement(oldBpcs);
				line_no4.addElement(oldLineNo);
				qty4.addElement(oldQty);
				mark4.addElement(oldMark);
				baseCost4.addElement(""+oldBaseCost);
				unitCost4.addElement(""+oldUnitCost);
				totCost4.addElement(""+oldTotCost);
				unitSell4.addElement(""+oldUnitSell);
				totSell4.addElement(""+oldTotSell);
			}

			oldQty="";
			if(block_id3.elementAt(i).toString().equals("A_CORE")){
				oldQty=""+Integer.parseInt(qty3.elementAt(i).toString());
			}
			oldBpcs=bpcsNo3.elementAt(i).toString();
			oldLineNo=line_no3.elementAt(i).toString();
			oldMark=mark3.elementAt(i).toString();
			oldBaseCost=new Double(cost3.elementAt(i).toString()).doubleValue();
			oldUnitCost=unitCostTemp;
			oldTotCost=costTemp;
			oldUnitSell=unitSellTemp;
			oldTotSell=sellTemp;
		}
		else{
			if(block_id3.elementAt(i).toString().equals("A_CORE")){
				if(oldQty.trim().length()<1){
					oldQty=""+Integer.parseInt(qty3.elementAt(i).toString());
				}
				else{
					oldQty=""+(Integer.parseInt(oldQty)+Integer.parseInt(qty3.elementAt(i).toString()));
				}
			}
			oldBaseCost=oldBaseCost+new Double(cost3.elementAt(i).toString()).doubleValue();
			oldUnitCost=oldUnitCost+unitCostTemp;
			oldTotCost=oldTotCost+costTemp;
			oldUnitSell=oldUnitSell+unitSellTemp;
			oldTotSell=oldTotSell+sellTemp;
		}
		if(i==line_no3.size()-1){
			bpcsNo4.addElement(oldBpcs);
			line_no4.addElement(oldLineNo);
			qty4.addElement(oldQty);
			mark4.addElement(oldMark);
			baseCost4.addElement(""+oldBaseCost);
			unitCost4.addElement(""+oldUnitCost);
			totCost4.addElement(""+oldTotCost);
			unitSell4.addElement(""+oldUnitSell);
			totSell4.addElement(""+oldTotSell);
		}
	}
	double configured=0;
	double totalcost=0;
	double sellprice=0;
	for(int i=0; i<line_no4.size(); i++){
		configured=configured+new Double(baseCost4.elementAt(i).toString()).doubleValue();
		totalcost=totalcost+new Double(totCost4.elementAt(i).toString()).doubleValue();
		sellprice=sellprice+new Double(totSell4.elementAt(i).toString()).doubleValue();
	}
	NumberFormat for2dec = NumberFormat.getInstance();
	for2dec.setMaximumFractionDigits(2);
	for2dec.setMinimumFractionDigits(2);
	Vector markx = new Vector();
	Vector openingsx = new Vector();
	Vector modelx = new Vector();
	Vector descx = new Vector();
	Vector bpcs_nox = new Vector();
	Vector line_nox = new Vector();

	String query2="select  cast(QTY as varchar) as a2,block_id as a3, field17 as a4, field18 as a5, descript as a1,line_no,bpcs_part_no from csquotes where order_no = '" +order_no+"' and block_id = 'a_core' order by cast(line_no as numeric),field18, block_id";
	ResultSet rsc=stmt.executeQuery(query2);
	if(rsc != null){
		while(rsc.next()){
			markx.addElement(rsc.getString(3));
			openingsx.addElement(rsc.getString(1));
			modelx.addElement(rsc.getString(4));
			descx.addElement(rsc.getString(5));
			bpcs_nox.addElement(rsc.getString("bpcs_part_no"));
			line_nox.addElement(rsc.getString("line_no"));
		}
	}
	rsc.close();
	if(type.equals("2")){
		out.println("<tr><td colspan='2' class='maindesc' valing='top'><b>The overall price is based on furnishing the types, quantities, and sizes listed herein. Unit prices are applicable only to this scope of doors. If ultimate quantities or types deviate from those listed, price is subject to increase or decrease accordingly.  Unit prices shall not be applied to any other scope of doors or any change orders.</b></td></tr>");
	}
	for(int ii=0; ii<markx.size(); ii++){
		String mark=markx.elementAt(ii).toString();
		String openings=openingsx.elementAt(ii).toString();
		String model=modelx.elementAt(ii).toString();
		String desc=descx.elementAt(ii).toString();
		String secPrice="";
		String secUnitPrice="";
		for(int i=0; i<line_no4.size(); i++){
			if(line_nox.elementAt(ii).toString().equals(line_no4.elementAt(i).toString())){
				if(bpcs_nox.elementAt(ii).toString().equals(bpcsNo4.elementAt(i).toString())){
					int divider=1;
					for(int iii=0; iii<markx.size(); iii++){
						if(ii!=iii){
							if(line_nox.elementAt(ii).toString().equals(line_nox.elementAt(iii).toString())){
								if(bpcs_nox.elementAt(ii).toString().equals(bpcs_nox.elementAt(iii).toString())){
									//out.println(bpcs_nox.elementAt(ii).toString()+"::"+bpcs_nox.elementAt(iii).toString()+"<BR>");
									divider++;
								}
							}

						}
					}
					if(exchName.equals("CAD")||exchName.equals("CAN")){
						secPrice=for2dec.format(new Double(totSell4.elementAt(i).toString()).doubleValue()*exchRate/divider);
						secUnitPrice=for2dec.format((new Double(totSell4.elementAt(i).toString()).doubleValue()*exchRate/divider)/new Double(openings).doubleValue());

					}
					else{

						secPrice=for2dec.format(new Double(totSell4.elementAt(i).toString()).doubleValue()/divider);
						secUnitPrice=for2dec.format((new Double(totSell4.elementAt(i).toString()).doubleValue()/divider)/new Double(openings).doubleValue());
					}
				}
			}
		}



*/
/*
out.println("<tr><td width='20%' class='maindesc' valign='top'><b>Mark</b>&nbsp;"+mark+"<br><b>Openings</b>&nbsp;"+openings+"<br><b>Model</b>&nbsp;"+model);
		if(type.equals("2")){
			if(exchName.equals("CAD")||exchName.equals("CAN")){
				out.println("<br><b>Price</b>&nbsp;"+secPrice+" "+exchName+"<BR><b>Unit Price</b>&nbsp;"+secUnitPrice+" "+exchName+"<BR>&nbsp;");

			}
			else{
				out.println("<br><b>Price</b>&nbsp;"+secPrice+"<BR><b>Unit Price</b>&nbsp;"+secUnitPrice+"<BR>&nbsp;");
			}
		}
		out.println("</td>");
		out.println("<td width='80%' class='maindesc'><b>Description</b><br>"+desc+"</td></tr>");

	}
*/
	if(type.equals("2")){
		out.println("<tr><td colspan='2' class='maindesc' valing='top'><b>The overall price is based on furnishing the types, quantities, and sizes listed herein. Unit prices are applicable only to this scope of doors. If ultimate quantities or types deviate from those listed, price is subject to increase or decrease accordingly.  Unit prices shall not be applied to any other scope of doors or any change orders.</b></td></tr>");
	}
	NumberFormat for2dec = NumberFormat.getInstance();
	for2dec.setMaximumFractionDigits(2);
	for2dec.setMinimumFractionDigits(2);
	Vector schQty= new Vector();
	Vector schDescipt= new Vector();
	Vector schField18= new Vector();
	Vector schExtended_price= new Vector();
	Vector schField17= new Vector();
	Vector schBlock_id= new Vector();
	Vector line_no= new Vector();
        double totalLineValue=0;
        double extraCharges=new Double(overage).doubleValue()+new Double(handling_cost).doubleValue()+new Double(freight_cost).doubleValue()+new Double(setup_cost).doubleValue();
        double activeAdder=0;
        double inactiveAdder=0;
	ResultSet rsSch=stmt.executeQuery("SELECT qty,descript,field18,extended_price,field17,block_id,line_no FROM csquotes WHERE order_no='"+ order_no +"' and not block_id = 'A_aproduct' order by cast(line_no as numeric),block_id");
	if(rsSch != null){
		while(rsSch.next()){
			if(rsSch.getString("block_id").equals("A_CORE")){
				schQty.addElement(rsSch.getString("qty"));
				schDescipt.addElement(rsSch.getString("descript"));
				schField18.addElement(rsSch.getString("field18"));
				schExtended_price.addElement(rsSch.getString("extended_price"));
				schField17.addElement(rsSch.getString("field17"));
				schBlock_id.addElement(rsSch.getString("block_id"));
				line_no.addElement(rsSch.getString("line_no"));
			}
			else{
				//out.println("adder"+schQty.size());
				//double tempValue=rsSch.getDouble("extended_price")+new Double(schExtended_price.elementAt(schQty.size()-1).toString()).doubleValue();
				//schExtended_price.setElementAt(tempValue+"",schQty.size()-1);

			}
		}
	}
	rsSch.close();
        for(int ii=0; ii<schQty.size(); ii++){
            totalLineValue=totalLineValue+new Double(schQty.elementAt(ii).toString()).doubleValue();
        }
	for(int i=0; i<schQty.size(); i++){
			out.println("<tr><td width='20%' class='maindesc' valign='top'><b>Mark</b>&nbsp;"+schField17.elementAt(i).toString()+"<br><b>Openings</b>&nbsp;"+schQty.elementAt(i).toString()+"<br><b>Model</b>&nbsp;"+schField18.elementAt(i).toString());
			if(type.equals("2")){
					//out.println("a");
                                        double tempAdder2=0;
                                        if(schDescipt.elementAt(i).toString().toUpperCase().indexOf("INACTIVE")>=0){
                                            ResultSet rsAdd1=stmt.executeQuery("select  extended_price from csquotes where order_no='"+order_no+"' and block_id like 'bi%' and line_no='"+line_no.elementAt(i).toString()+"'");
                                            if(rsAdd1!=null){
                                                while(rsAdd1.next()){
                                                //out.println(rsAdd1.getString(1)+"::<BR>");
                                                tempAdder2=tempAdder2+rsAdd1.getDouble(1);
                                                }
                                            }
                                            rsAdd1.close();
                                            double tempValue=tempAdder2+new Double(schExtended_price.elementAt(i).toString()).doubleValue();
                                            schExtended_price.setElementAt(tempValue+"",i);
                                        }
                                       else{
                                            ResultSet rsAdd1=stmt.executeQuery("select  extended_price from csquotes where order_no='"+order_no+"' and block_id like 'b%' and not block_id like 'bi%' and line_no='"+line_no.elementAt(i).toString()+"'");
                                            if(rsAdd1!=null){
                                                while(rsAdd1.next()){
                                                //out.println(rsAdd1.getString(1)+"::<BR>");
                                                tempAdder2=tempAdder2+rsAdd1.getDouble(1);
                                                }
                                            }
                                            rsAdd1.close();
                                           double tempValue=tempAdder2+new Double(schExtended_price.elementAt(i).toString()).doubleValue();
                                            schExtended_price.setElementAt(tempValue+"",i);
                                       }
                                         double tempAdder=extraCharges*(new Double(schQty.elementAt(i).toString()).doubleValue()/totalLineValue);
					String secUnitPrice=""+for2dec.format((new Double(schExtended_price.elementAt(i).toString()).doubleValue()+tempAdder)/new Double(schQty.elementAt(i).toString()).doubleValue());
					//out.println("b");
                                       
					out.println("<br><b>Price</b>&nbsp;"+for2dec.format(new Double(schExtended_price.elementAt(i).toString()).doubleValue()+tempAdder)+"<BR>");
					//out.println("c");
					out.println("<b>Unit Price</b>&nbsp;"+secUnitPrice+"<BR>&nbsp;");
			}
			out.println("</td>");
			out.println("<td width='80%' class='maindesc'><b>Description</b><br>"+schDescipt.elementAt(i).toString()+"</td></tr>");
	}
	out.println("</font></table>");

	%>