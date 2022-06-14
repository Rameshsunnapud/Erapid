<%
double totQuotePrice=0;

if(sections<=1){
	//out.println("here2");
	out.println("<table width='100%' class='table_thin_borders' style='border-collapse: collapse;' cellspacing='0' cellpadding='3' border='1'>");
	out.println("<tr height='20'>");
	if(type.equals("1")|type.equals("2")){
		out.println("<td width='5%'   class='maindesc'><b><u>Mark</u></b></td>");
	}
	out.println("<td    class='maindesc'><b><u>Product</u></b></td>");
	if(type.equals("1")|type.equals("2")){
		out.println("<td width='5%'   class='maindesc'><b><u>Qty</u></b></td>");
		out.println("<td width='9%'   class='maindesc'><b><u>UOM</u></b></td>");
	}
	if(type.equals("2")){
		out.println("<td width='5%'   class='maindesc'><b><u>Unit Price</u></b></td>");
		out.println("<td width='9%'   class='maindesc'><b><u>Line Total</u></b></td>");
	}
	out.println("</tr>");
	double tot_sum=0;

	Vector price_csquotes=new Vector();Vector um=new Vector();
	//ResultSet

	rs_csquotes = stmt.executeQuery("select * from csquotes where order_no='"+order_no+"' and Block_ID='PRICING' AND cast(Sequence_no as decimal)='0.00' order by cast(Line_no as integer),Extended_Price ");
	if (rs_csquotes !=null) {
		while (rs_csquotes.next()) {
			line_no.addElement(rs_csquotes.getString("Line_no"));
			desc.addElement(rs_csquotes.getString("Descript"));
			price_csquotes.addElement(rs_csquotes.getString ("Extended_Price"));
			//out.println(rs_csquotes.getString("Line_no")+"::"+rs_csquotes.getString ("Extended_Price")+"::<BR>");
			rec_no.addElement(rs_csquotes.getString("Record_no"));
			qty.addElement(rs_csquotes.getString("Qty"));
			mark.addElement(rs_csquotes.getString("field17"));
			if(rs_csquotes.getString("uom") != null){um.addElement(rs_csquotes.getString("uom"));}
			else{um.addElement("");}
			k++;
		}
	}
	rs_csquotes.close();

	ResultSet rs_csquotes_sum = stmt.executeQuery("SELECT line_no, sum(cast(extended_price as decimal)) FROM CSQUOTES where order_no='"+order_no+"' group by line_no order by cast(Line_no as integer)");
	if (rs_csquotes_sum !=null) {
         	while (rs_csquotes_sum.next()) {
			tot_sum=tot_sum+new Double(rs_csquotes_sum.getString(2)).doubleValue();
		}
	}
	rs_csquotes_sum.close();
	double totprice=0;String line_cost="";
	for (int n=0;n<k;n++){
		if ((bcount%2)==1){bgcolor="white";}else {bgcolor="white";	}
		if (((desc.elementAt(n).toString()).trim().startsWith("Gasket"))){
			color=(desc.elementAt(n).toString()).substring(((desc.elementAt(n).toString()).indexOf("Gasket Color - "))+15);
		}
		else{
			line_cost=price_csquotes.elementAt(n).toString();

			ResultSet badd=stmt.executeQuery("select extended_price from csquotes where order_no='"+order_no+"' and block_id='b_adders' and line_no='"+line_no.elementAt(n).toString()+"'");
			if(badd != null){
				while(badd.next()){
					//out.println("<tr><td>"+badd.getString(1)+"</td></tr>");
					line_cost=""+(new Double(line_cost).doubleValue()+badd.getDouble(1));
				}
			}
			badd.close();
			BigDecimal d1 = new BigDecimal(line_cost);
			BigDecimal d2 = new BigDecimal(tot_sum);//total configured price
			BigDecimal d3_o = new BigDecimal(overage);
			BigDecimal d3 = d1.divide(d2,BigDecimal.ROUND_HALF_UP);
			BigDecimal d4 = d3.multiply(d3_o);
			d4 = d4.setScale(0, BigDecimal.ROUND_HALF_UP);
			totprice=(new Double(line_cost)).doubleValue()+d4.doubleValue();
			//		 int qty1= qty.elementAt(n).toString().indexOf("(");
			String qty2=qty.elementAt(n).toString();
			out.println("<tr>");
			if(type.equals("1")|type.equals("2")){
				out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+mark.elementAt(n).toString()+"</td>");
			}
			out.println("<td valign='top'  bgcolor='"+bgcolor+"' class='maindesc'>"+desc.elementAt(n).toString()+"</td>");
			if(type.equals("1")|type.equals("2")){
				out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+qty.elementAt(n).toString()+"</td>");
				out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+um.elementAt(n).toString()+"</td>");
			}
			if(type.equals("2")){
				out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(totprice/(new Double(qty2)).doubleValue())+"</td>");
				out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(totprice)+"</td>");
			}
			out.println("</tr>");
			color="NONE";
			bcount++;
		}
	}
	out.println("</table>");
}// if no sections
else{//if sections
	//out.println("here2x");
	for1.setMinimumFractionDigits(2);
	double totprice=0;String line_cost="";double line_price=0;String qual_sect="";String exec_sect="";
	double adders=0;
	double sumTotal=0;
	ResultSet rsSumTot=stmt.executeQuery("Select extended_price from csquotes where order_no='"+order_no+"' and Block_ID !='A_APRODUCT'  ");
	if(rsSumTot != null){
		while(rsSumTot.next()){
			sumTotal=sumTotal+new Double(rsSumTot.getString(1)).doubleValue();
		}
	}
	//out.println(sumTotal+"::<BR>");
	for(int ye=0;ye<sect_group.size();ye++){
//	out.println("SG"+sect_group);
			//header for new pages
			if(section_page==null||section_page.equals("1")){
%>
<%@ include file="quote_template_header.jsp"%>
<%@ include file="quote_template_top.jsp"%>
<%
}
//table headers
double TOTALPRICE=0;double secTOTALPRICE=0;
if ((bcount%2)==1){bgcolor="#EFEFDE";}else {bgcolor="#e4e4e4";	}
out.println("<table width='100%' cellspacing='1' cellpadding='2' border='0'>");
out.println("<tr height='20'>");
out.println("<td class='mainbodyh' colspan='6'> ");out.println("<b>Section:: "+(String)sect_group.elementAt(ye)+"</b>" );	out.println("</td>");
out.println("</tr>");
out.println("<tr height='20'>");
if(type.equals("1")|type.equals("2")){
out.println("<td width='5%'   class='maindesc'><b><u>Mark</u></b></td>");
}
out.println("<td    class='maindesc'><b><u>Product</u></b></td>");
if(type.equals("1")|type.equals("2")){
out.println("<td width='5%'   class='maindesc'><b><u>Qty</u></b></td>");
out.println("<td width='9%'   class='maindesc'><b><u>UOM</u></b></td>");
}
if(type.equals("2")){
out.println("<td width='5%'   class='maindesc'><b><u>Unit Price</u></b></td>");
out.println("<td width='9%'   class='maindesc'><b><u>Line Total</u></b></td>");
}
out.println("</tr>");

ResultSet rsx=stmt.executeQuery("select sum(cast(extended_price as decimal)) from csquotes where order_no='"+order_no+"' and ((Block_ID ='PRICING' and cast(Sequence_no as decimal)='0.00') or block_id='B_ADDERS')  and cast(extended_price as decimal)>0 ");
if(rsx != null){
	while(rsx.next()){
		TOTALPRICE=rsx.getDouble(1);
	}
}
rsx.close();
ResultSet rsx2=stmt.executeQuery("select sum(cast(extended_price as decimal)) from csquotes where order_no='"+order_no+"' and ((Block_ID ='PRICING' and cast(Sequence_no as decimal)='0.00') or block_id='B_ADDERS') and cast(extended_price as decimal)>0 and line_no in("+sect_group_lines.elementAt(ye).toString()+") ");
if(rsx2 != null){
	while(rsx2.next()){
		secTOTALPRICE=rsx2.getDouble(1);
		//out.println(secTOTALPRICE+"::HERE<BR>");
	}
}
rsx.close();
String 	stat1="select * from csquotes where order_no='"+order_no+"' and ((Block_ID ='PRICING' and cast(Sequence_no as decimal)='0.00') or block_id='B_ADDERS') and cast(extended_price as decimal)>0 and line_no in("+sect_group_lines.elementAt(ye).toString()+") order by cast(Line_no as integer),block_id,Extended_Price";
ResultSet rsn=stmt.executeQuery(stat1);
	while(rsn.next()){
		if(rsn.getString("block_id").equals("B_ADDERS")){
		adders=adders+new Double(rsn.getString("extended_price")).doubleValue();
		}
		else{
			if ((bcount%2)==1){bgcolor="#EFEFDE";}else {bgcolor="#e4e4e4";	}
			line_cost=""+(new Double(rsn.getString("Extended_Price")).doubleValue()+adders);
			adders=0;
			//out.println(overage+"::<br>");

			//String ="0";


			//out.println(freightSec.elementAt(ye).toString()+"::<BR>");
			if(isSecOverage && overageSec.elementAt(ye).toString() != null && overageSec.elementAt(ye).toString().trim().length()>0){
				overageX=new Double(overageSec.elementAt(ye).toString()).doubleValue()*(new Double(line_cost).doubleValue()/secTOTALPRICE);
				//=new Double(overageSec.elementAt(ye).toString()).doubleValue()*(new Double(line_cost).doubleValue()/sumTotal);



				//out.println(line_cost+"::"+sumTotal);
				//out.println("1<BR>");
			}else{
				//out.println("2<BR>");
				overageX=new Double(overage).doubleValue()*(new Double(line_cost).doubleValue()/sumTotal);
				//out.println(overage+"::"+line_cost+"::"+secTOTALPRICE+"2<BR>");
			}

			if(freightSec.elementAt(ye).toString() != null && freightSec.elementAt(ye).toString().trim().length()>0){
				//freight_cost=""+new Double(freightSec.elementAt(ye).toString()).doubleValue()*(new Double(line_cost).doubleValue()/sumTotal);
				freightX=new Double(freightSec.elementAt(ye).toString()).doubleValue()*(new Double(line_cost).doubleValue()/secTOTALPRICE);
			}else{freightX=new Double(freight_cost).doubleValue()*(new Double(line_cost).doubleValue()/sumTotal);}
			//out.println(handling_cost+"::1<BR>");
			if(handlingSec.elementAt(ye).toString() != null && handlingSec.elementAt(ye).toString().trim().length()>0){
				//handling_cost=""+new Double(handlingSec.elementAt(ye).toString()).doubleValue()*(new Double(line_cost).doubleValue()/sumTotal);
				handlingX=new Double(handlingSec.elementAt(ye).toString()).doubleValue()*(new Double(line_cost).doubleValue()/secTOTALPRICE);
			}else{handlingX=new Double(handling_cost).doubleValue()*(new Double(line_cost).doubleValue()/sumTotal);}
			//out.println(handling_cost+"::2<BR>");


			double extraCharge=overageX+freightX+handlingX;
			//out.println(+"::"+freight_cost+"::"+handling_cost+"::"+extraCharge+"::<BR>");
			double Xcharge=(extraCharge);
			BigDecimal d1 = new BigDecimal(line_cost);
			BigDecimal d2 = new BigDecimal(tot_sum1);//total configured price
			BigDecimal d3_o = new BigDecimal(extraCharge);
			BigDecimal d3 = d1.divide(d2,BigDecimal.ROUND_HALF_UP);
			BigDecimal d4 = d3.multiply(d3_o);
			d4 = d4.setScale(0, BigDecimal.ROUND_HALF_UP);
//						//out.println("d1:"+d1+":d2:"+d2+":d3_0:"+Xcharge+"::"+d4 +" d4<BR>");
//						//out.println("overage"+overage+"freight_cost"+freight_cost+"handling_cost"+handling_cost);
			line_price=(new Double(line_cost)).doubleValue()+Xcharge;
			totprice=totprice+(new Double(line_cost)).doubleValue()+Xcharge;
			//out.println(line_cost+"::"+Xcharge+"::"+totprice+"::<BR>");
			String qty2=rsn.getString("Qty");
			out.println("<tr>");
			if(type.equals("1")|type.equals("2")){
			out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+rsn.getString("field17")+"</td>");
			}
			out.println("<td valign='top'  bgcolor='"+bgcolor+"' class='maindesc'>"+rsn.getString("Descript")+"</td>");
			if(type.equals("1")|type.equals("2")){
			out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+rsn.getString("Qty")+"</td>");
			out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+rsn.getString("uom")+"</td>");
			}
			if(type.equals("2")){
			out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(line_price/(new Double(qty2)).doubleValue())+"</td>");
			out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(line_price)+"</td>");
			}
			out.println("</tr>");
			bcount++;
		}//else end
	}//while end
	rsn.close();
if(section_notes!=null){
out.println("<tr height='20'>");
out.println("<td class='mainbodyh' colspan='6' align='left'>");out.println(sect_notes.elementAt(ye));	out.println("</td>");
out.println("</tr>");//free notes end
}
if( !(section_qual==null||section_qual.trim().equals("")||sect_qual.elementAt(ye).toString().trim().equals("")) ){
out.println("<tr><td class='mainbodyh' colspan='6' ><b>QUALIFYING NOTES:</b></td></tr>");
	if (qual_count>0){qual_sect=qualifying_notes+","+sect_qual.elementAt(ye);}
	else{qual_sect=sect_qual.elementAt(ye).toString();}//			out.println("test"+qualifying_notes);
}
else if ( ((qualifying_notes_free_text.trim()).length()>0)|(qual_count>0)){
			out.println("<tr><td class='mainbodyh' colspan='6' ><b>QUALIFYING NOTES:</b></td></tr>");
			qual_sect=qualifying_notes;
}
if(qual_sect!=null&&qual_sect.trim().length()>0){
//all in qualifying notes
ResultSet cs_exc_notes1 = stmt.executeQuery("select description FROM cs_qlf_notes where product_id='"+product+"' and code in ("+qual_sect+") order by code ");
if (cs_exc_notes1 !=null) {
while (cs_exc_notes1.next()) {
out.println("<tr><td class='mainbodyh' colspan='6'>"+cs_exc_notes1.getString("description")+"</td></tr>");
							}
						}
cs_exc_notes1.close();
}
out.println("<tr><td colspan='6'  class='mainbodyh'>"+qualifying_notes_free_text+"</td></tr>");
out.println("<tr><td  colspan='3' class='mainbodyh'>&nbsp;</td></tr>");
//qualifying notes end
if( !(section_exc==null||section_exc.trim().equals("")||sect_exec.elementAt(ye).toString().trim().equals("")) ){
	if (exc_count>0){exec_sect=exclusions+","+sect_exec.elementAt(ye);}
	else{exec_sect=sect_exec.elementAt(ye).toString();}
	out.println("<tr><td class='mainbodyh' colspan='6' ><b>EXCLUSIONS/NOTES:</b></td></tr>");
}
else if ( ((exclusions_free_text.trim()).length()>0)|(exc_count>0)){
	out.println("<tr><td class='mainbodyh' colspan='6' ><b>EXCLUSIONS/NOTES:</b></td></tr>");
	exec_sect=exclusions;
}
//exclusions
if(exec_sect!=null&&exec_sect.trim().length()>0){
ResultSet cs_qlf_notes1 = stmt.executeQuery("select description FROM cs_exc_notes where product_id='"+product+"' and code in ("+exec_sect+") order by code ");
if (cs_qlf_notes1 !=null) {
   while (cs_qlf_notes1.next()) {
	out.println("<tr><td class='mainbodyh' colspan='6' >"+cs_qlf_notes1.getString("description")+"</td></tr>");
	}
}
cs_qlf_notes1.close();
}
out.println("<tr><td colspan='6' class='mainbodyh'>"+exclusions_free_text+"</td></tr>");
if(free_text!=null){
out.println("<tr><td colspan='6'><font class='mainbodyh'>"+free_text+"</font></td></tr>");
}
	for1.setMaximumFractionDigits(0);
	//price=for1.format(totprice);
	price=""+totprice;
	grand_total1=totprice;
if(section_page==null||section_page.equals("1")){
	out.println("<tr><td  colspan='6' class='mainbodyh'>&nbsp;</td></tr>");
	//footer for new pages
%>
<%@ include file="quote_template_foot.jsp"%>
<%@ include file="quote_template_footer.jsp"%>
<%
if(sect_group.size()-ye>1){out.println("<p style='page-break-after : always;' >&nbsp;</p>");}
}else{
%>
</table>
<table class='<%= border_color %>' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only</b></td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>$<%= for12x.format(new Double(price).doubleValue()) %></font></b></td>
	</tr>
</table>
<%
		double tax_dollar=0;
//out.println("1"+tax_perc+"::"+grand_total1);
		if (!(tax_perc==null||tax_perc.equals("0"))){
		tax_dollar=(grand_total1*Double.parseDouble(tax_perc))/100;
//out.println("2");
		grand_total1=grand_total1+tax_dollar;
//out.println("3");
		for1.setMaximumFractionDigits(0);
//out.println("b");

			out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
			out.println("<tr>");
			out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Tax Only</b></td>");
			out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$"+for12x.format(tax_dollar)+"</font></b></td>");
			out.println("</tr>");
			out.println("</table>");
			out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
			out.println("<tr>");
			out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material and Tax Only </b></td>");
			out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>$"+for12x.format(grand_total1)+"</font></b></td>");
			out.println("</tr>");
			out.println("</table>");
			out.println("<BR><BR><BR>");
		}
//out.println("c");
}
//out.println("d");
for1.setMaximumFractionDigits(2);
for1.setMinimumFractionDigits(2);				//}
totQuotePrice=TOTALPRICE;
totprice=0;exec_sect="";qual_sect="";secTOTALPRICE=0;TOTALPRICE=0;
//overage="0";
freightX=0;handlingX=0;overageX=0;
//out.println("HEREx<BR>");
}//for loop end
price=""+totQuotePrice;
}//if sections

%>

