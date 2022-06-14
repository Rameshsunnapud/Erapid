<%
double totQuotePrice=0;
String headerString="";
Vector line_no=new Vector();
Vector mark_no=new Vector();
Vector qty=new Vector();
Vector rec_no=new Vector();
Vector desc=new Vector();
Vector mark=new Vector();
int k=0;
double extra_charges=0;
double bcount=0;
String bgcolor="";

if(sections<=0){
	 for1.setMinimumFractionDigits(2);
	  for1.setMaximumFractionDigits(2);
	Vector price_csquotes=new Vector();
	Vector um=new Vector();
	Vector block_id=new Vector();

	ResultSet rs_csquotes = stmt.executeQuery("select line_no,descript,cast(extended_price as decimal),record_no,qty,field17,uom,block_id from csquotes where order_no='"+order_no+"' and Block_ID in ('PRICING','B_ADDERS') AND Sequence_no in('0.00','10') and cast(extended_price as decimal)>0 order by cast(Line_no as integer),block_id,Extended_Price ");
	if (rs_csquotes !=null) {
		while (rs_csquotes.next()) {
			block_id.addElement(rs_csquotes.getString("block_id"));
			line_no.addElement(rs_csquotes.getString("Line_no"));
			desc.addElement(rs_csquotes.getString("Descript"));
			String pricetemp="";
			pricetemp=rs_csquotes.getString (3);
			//ResultSet rsadders=stmt.executeQuery("select cast(extended_price as decimal) from csquotes where order_no='"+order_no+"' and block_id='b_adders' and line_no='"+rs_csquotes.getString("Line_no")+"'");
			//if(rsadders != null){
			//	while(rsadders.next()){
			//		pricetemp=""+(new Double(pricetemp).doubleValue()+new Double(rsadders.getString(1)).doubleValue());
			//	}
			//}
			//rsadders.close();
			price_csquotes.addElement(pricetemp);
			rec_no.addElement(rs_csquotes.getString("Record_no"));
			qty.addElement(rs_csquotes.getString("Qty"));
			mark.addElement(rs_csquotes.getString("field17"));
			if(rs_csquotes.getString("uom") != null){um.addElement(rs_csquotes.getString("uom"));}
			else{um.addElement("");	}
			k++;
		}
	}
	rs_csquotes.close();
for(int y=0; y<line_no.size(); y++){
	String pricetemp=""+new Double(price_csquotes.elementAt(y).toString()).doubleValue();
	//out.println(pricetemp+"<BR>");
	ResultSet rsadders=stmt.executeQuery("select cast(extended_price as decimal) from csquotes where order_no='"+order_no+"' and block_id='b_adders' and line_no='"+line_no.elementAt(y).toString()+"'");
	if(rsadders != null){
		while(rsadders.next()){
			pricetemp=""+(new Double(price_csquotes.elementAt(y).toString()).doubleValue()+new Double(rsadders.getString(1)).doubleValue());
		}
	}
	price_csquotes.setElementAt(pricetemp,y);
			//rsadders.close();
}

			double tot_sum=0;
			ResultSet rs_csquotes_sum = stmt.executeQuery("SELECT line_no, sum(cast(extended_price as decimal)) FROM CSQUOTES where order_no='"+order_no+"' group by line_no order by cast(Line_no as integer)");
			if (rs_csquotes_sum !=null) {
		 while (rs_csquotes_sum.next()) {
			 tot_sum=tot_sum+new Double(rs_csquotes_sum.getString(2)).doubleValue();
			 }
			}
			rs_csquotes_sum.close();
			tot_sum=tot_sum+extra_charges;
			double totprice=0;String line_cost="";
			out.println("<table width='100%' class='table_thin_borders' style='border-collapse: collapse;' cellspacing='0' cellpadding='3' border='1'>");

			out.println("<tr height='20'>");
			if(type.equals("1")|type.equals("2")|type.equals("5")|type.equals("6")){
			out.println("<td width='5%' class='maindesc'><b><u>Mark</u></b></td>");
			}
			out.println("<td  class='maindesc'><b><u>Product</u></b></td>");
			/*
			if(type.equals("4")){
				out.println("<td width='5%' class='maindesc'><b><u>Qty</u></b></td>");
			}
			*/
			if(type.equals("1")|type.equals("2")|type.equals("4")|type.equals("5")|type.equals("6")){
			out.println("<td width='5%' class='maindesc'><b><u>Qty</u></b></td>");
			out.println("<td width='5%' class='maindesc'><b><u>UOM</u></b></td>");
			}
			if(type.equals("2")|type.equals("5")){
			out.println("<td width='9%' class='maindesc'><b><u>Unit Price</u></b></td>");
			out.println("<td width='9%' class='maindesc'><b><u>Line Total</u></b></td>");
			}
			out.println("</tr>");

	for (int n=0;n<k;n++){

			if ((bcount%2)==1){bgcolor="";}else {bgcolor="";	}
			  line_cost=price_csquotes.elementAt(n).toString();
			  BigDecimal d1 = new BigDecimal(line_cost);
			 String tot_sumx=""+(new Double(tot_sum).doubleValue());
			 //-new Double(overage).doubleValue()-new Double(freight_cost).doubleValue()-new Double(handling_cost).doubleValue());
			double xCharges=(new Double(overage).doubleValue()+new Double(freight_cost).doubleValue()+new Double(handling_cost).doubleValue());
			xCharges=xCharges*(d1.doubleValue()/new Double(tot_sumx).doubleValue());

			  totprice=d1.doubleValue()+xCharges;

		String qty2=qty.elementAt(n).toString();
			out.println("<tr>");
			if(!block_id.elementAt(n).toString().equals("B_ADDERS")){
				if(type.equals("1")|type.equals("2")|type.equals("5")|type.equals("6")){
					out.println("<td valign='top'  nowrap  class='maindesc'>"+mark.elementAt(n).toString()+"</td>");
				}
				out.println("<td valign='top'   class='maindesc'>"+desc.elementAt(n).toString()+"</td>");
				/*
				if(type.equals("4")){
					out.println("<td valign='top' nowrap  class='maindesc'>"+qty.elementAt(n).toString()+"</td>");
				}
				*/
				if(type.equals("1")|type.equals("2")|type.equals("4")|type.equals("5")|type.equals("6")){
					out.println("<td valign='top' nowrap  class='maindesc'>"+qty.elementAt(n).toString()+"</td>");
					out.println("<td valign='top' nowrap  class='maindesc'>"+um.elementAt(n).toString()+"</td>");
				}
				if(type.equals("2")|type.equals("5")){
					out.println("<td valign='top' nowrap  class='maindesc' >"+for1.format(totprice/(new Double(qty2)).doubleValue())+"</td>");
					out.println("<td valign='top' nowrap  class='maindesc' >"+for1.format(totprice)+"</td>");
				}
				out.println("</tr>");
				bcount++;
			}
	}
}// if no sections
else{
String holdPrice=price;
	for1.setMinimumFractionDigits(2);
	double totprice=0;String line_cost="";double line_price=0;String qual_sect="";String exec_sect="";
	double adders=0;
	double Xcharge=0;
	String tempOverage="";
	String tempFreight_cost="";
	String tempHandling_cost="";

	for(int ye=0;ye<sect_group.size();ye++){
		tempOverage=overage;
		tempFreight_cost=freight_cost;
		tempHandling_cost=handling_cost;
		if(section_page==null||section_page.equals("1")){
%>
<%@ include file="quote_template_header_sfdc.jsp"%>
<%@ include file="quote_template_top_sfdc.jsp"%>
<%
}
double Xcharge3=0;
double TOTALPRICE=0;double secTOTALPRICE=0;
if ((bcount%2)==1){bgcolor="";}else {bgcolor="";	}
out.println("<table width='100%' cellspacing='1' cellpadding='2' border='0'>");
out.println("<tr height='20'>");
out.println("<td class='mainbodyh' colspan='6'> ");out.println("<b>Section:: "+(String)sect_group.elementAt(ye)+"</b>" );	out.println("</td>");
out.println("</tr>");
out.println("<tr height='20'>");
if(type.equals("1")|type.equals("2")|type.equals("5")|type.equals("6")){
	out.println("<td width='5%' class='maindesc'><b><u>Mark</u></b></td>");
}
out.println("<td  class='maindesc'><b><u>Product</u></b></td>");

if(type.equals("1")|type.equals("2")|type.equals("4")|type.equals("5")|type.equals("6")){
	out.println("<td width='5%' class='maindesc'><b><u>Qty</u></b></td>");
	out.println("<td width='5%' class='maindesc'><b><u>UOM</u></b></td>");
}
if(type.equals("2")|type.equals("5")){
	out.println("<td width='9%' class='maindesc'><b><u>Unit Price</u></b></td>");
	out.println("<td width='9%' class='maindesc'><b><u>Line Total</u></b></td>");
}
out.println("</tr>");
double greg=0;
double Xcharge2=0;

ResultSet rsx=stmt.executeQuery("select sum(cast(extended_price as decimal)) from csquotes where order_no='"+order_no+"' and ((Block_ID ='PRICING' and Sequence_no='0.00') or block_id='B_ADDERS')  and cast(extended_price as decimal)>0 ");
if(rsx != null){
	while(rsx.next()){
		TOTALPRICE=rsx.getDouble(1);
	}
}
rsx.close();
ResultSet rsx2=stmt.executeQuery("select sum(cast(extended_price as decimal)) from csquotes where order_no='"+order_no+"' and ((Block_ID ='PRICING' and Sequence_no='0.00') or block_id='B_ADDERS') and cast(extended_price as decimal)>0 and line_no in("+sect_group_lines.elementAt(ye).toString()+") ");
if(rsx2 != null){
	while(rsx2.next()){
		secTOTALPRICE=rsx2.getDouble(1);
	}
}

String 	stat1="select *,cast(extended_price as float) as x1 from csquotes where order_no='"+order_no+"' and ((Block_ID ='PRICING' and Sequence_no='0.00') or block_id='B_ADDERS') and cast(extended_price as decimal)>0 and line_no in("+sect_group_lines.elementAt(ye).toString()+") order by cast(Line_no as integer),block_id,Extended_Price";
ResultSet rsn=stmt.executeQuery(stat1);
while(rsn.next()){
	if(rsn.getString("block_id").equals("B_ADDERS")){
		adders=adders+new Double(rsn.getString("x1")).doubleValue();
	}
	else{
		//out.println(freight_cost+"::<BR>");
		if ((bcount%2)==1){bgcolor="";}else {bgcolor="";	}
		line_cost=""+(new Double(rsn.getString("x1")).doubleValue()+adders);
		greg=greg+new Double(line_cost).doubleValue();
		adders=0;
		/*
		//if(!product.equals("EJC")){
			if(overageSec.elementAt(ye).toString() != null && overageSec.elementAt(ye).toString().trim().length()>0){
				overage=""+new Double(overageSec.elementAt(ye).toString()).doubleValue()*(new Double(line_cost).doubleValue()/new Double(secTOTALPRICE).doubleValue());
			}
		//	else{
		//		overage=""+new Double(overage).doubleValue()*(new Double(line_cost).doubleValue()/new Double(TOTALPRICE).doubleValue());
		//	}
		//}
		*/
if(overageSec.elementAt(ye).toString() != null && overageSec.elementAt(ye).toString().trim().length()>0){
			overage=""+new Double(overageSec.elementAt(ye).toString()).doubleValue()*(new Double(line_cost).doubleValue()/new Double(secTOTALPRICE).doubleValue());
		}
		else{
			overage=""+new Double(overage).doubleValue()*(new Double(line_cost).doubleValue()/new Double(TOTALPRICE).doubleValue());
		}
		if(freightSec.elementAt(ye).toString() != null && freightSec.elementAt(ye).toString().trim().length()>0){
			freight_cost=""+new Double(freightSec.elementAt(ye).toString()).doubleValue()*(new Double(line_cost).doubleValue()/new Double(secTOTALPRICE).doubleValue());
			//out.println("1<BR>");
		}
		else{
			freight_cost=""+new Double(freight_cost).doubleValue()*(new Double(line_cost).doubleValue()/new Double(TOTALPRICE).doubleValue());
			//out.println("2<BR>");
		}
		if(handlingSec.elementAt(ye).toString() != null && handlingSec.elementAt(ye).toString().trim().length()>0){
			handling_cost=""+new Double(handlingSec.elementAt(ye).toString()).doubleValue()*(new Double(line_cost).doubleValue()/new Double(secTOTALPRICE).doubleValue());
		}
		else{
			handling_cost=""+new Double(handling_cost).doubleValue()*(new Double(line_cost).doubleValue()/new Double(TOTALPRICE).doubleValue());
		}

		double extraCharge=new Double(overage).doubleValue()+new Double(freight_cost).doubleValue()+new Double(handling_cost).doubleValue();
		//out.println(extraCharge+"::1<BR>");
		//out.println(line_cost+"::<BR><BR>");

		double overageX=0;
		double freightX=0;
		double handlingX=0;
		overageX=new Double(overage).doubleValue()*(new Double(line_cost).doubleValue()/new Double(TOTALPRICE).doubleValue());
		freightX=new Double(freight_cost).doubleValue()*(new Double(line_cost).doubleValue()/new Double(TOTALPRICE).doubleValue());
		handlingX=new Double(handling_cost).doubleValue()*(new Double(line_cost).doubleValue()/new Double(TOTALPRICE).doubleValue());
		boolean isManual=false;
		/*
		if(overageSec.elementAt(ye) != null && overageSec.elementAt(ye).toString().trim().length()>0){
			isManual=true;
			overageX=new Double(overageSec.elementAt(ye).toString()).doubleValue();
		}
		if(freightSec.elementAt(ye) != null && freightSec.elementAt(ye).toString().trim().length()>0){
			isManual=true;
			freightX=new Double(freightSec.elementAt(ye).toString()).doubleValue();
		}
		if(handlingSec.elementAt(ye) != null && handlingSec.elementAt(ye).toString().trim().length()>0){
			isManual=true;
			handlingX=new Double(handlingSec.elementAt(ye).toString()).doubleValue();
		}
		//out.println(extraCharge+"::2<BR>");
		//extraCharge=overageX+freightX+handlingX;
		//out.println(extraCharge+"::3<BR>");
		if(isManual){
			//out.println(extraCharge+"::"+line_cost+"::"+secTOTALPRICE);
			extraCharge=extraCharge*(new Double(line_cost).doubleValue()/new Double(secTOTALPRICE).doubleValue());
			//out.println(extraCharge+"::HERE");
		}
		*/
		//out.println(extraCharge+"::4<BR>");
		BigDecimal d1 = new BigDecimal(line_cost);
		BigDecimal d2 = new BigDecimal(tot_sum1);//total configured price
		BigDecimal d3_o = new BigDecimal(extraCharge);
		BigDecimal d3 = d1.divide(d2,BigDecimal.ROUND_HALF_UP);
		BigDecimal d4 = d3.multiply(d3_o);
		Xcharge=(extraCharge);
		Xcharge3=Xcharge3+extraCharge;
		d4 = d4.setScale(0, BigDecimal.ROUND_HALF_UP);
		line_price=(new Double(line_cost)).doubleValue()+Xcharge;
		totprice=totprice+(new Double(line_cost)).doubleValue();
		String qty2=rsn.getString("Qty");
		out.println("<tr>");
		if(type.equals("1")|type.equals("2")|type.equals("5")|type.equals("6")){
			out.println("<td valign='top'  nowrap  class='maindesc'>"+rsn.getString("field17")+"</td>");
		}
		out.println("<td valign='top'   class='maindesc'>"+rsn.getString("Descript")+"</td>");

		if(type.equals("1")|type.equals("2")|type.equals("4")|type.equals("5")|type.equals("6")){
			out.println("<td valign='top' nowrap  class='maindesc'>"+rsn.getString("Qty")+"</td>");
			out.println("<td valign='top' nowrap  class='maindesc'>"+rsn.getString("uom")+"</td>");
		}
		if(type.equals("2")|type.equals("5")){
			out.println("<td valign='top' nowrap  class='maindesc'>"+for1.format(line_price/(new Double(qty2)).doubleValue())+"</td>");
			out.println("<td valign='top' nowrap  class='maindesc'>"+for1.format(line_price)+"</td>");
		}
		out.println("</tr>");
		bcount++;
overage=tempOverage;
freight_cost=tempFreight_cost;
handling_cost=tempHandling_cost;
	}
}
rsn.close();

if(section_notes!=null){
	out.println("<tr height='20'>");
	out.println("<td class='mainbodyh' colspan='6' align='left'>");out.println(sect_notes.elementAt(ye));	out.println("</td>");
	out.println("</tr>");//free notes end
}
if( !(section_qual==null||section_qual.trim().equals("")||sect_qual.elementAt(ye).toString().trim().equals("")) ){
	out.println("<tr><td class='mainbodyh' colspan='3' ><b>QUALIFYING NOTES:</b></td></tr>");
	if (qual_count>0){qual_sect=qualifying_notes+","+sect_qual.elementAt(ye);}
	else{qual_sect=sect_qual.elementAt(ye).toString();}//			out.println("test"+qualifying_notes);
}
else if ( ((qualifying_notes_free_text.trim()).length()>0)|(qual_count>0)){
	out.println("<tr><td class='mainbodyh' colspan='3' ><b>QUALIFYING NOTES:</b></td></tr>");
	qual_sect=qualifying_notes;
}
if(product.equals("EJC")&&(type.equals("3")||type.equals("4"))){
	ResultSet cs_exc_notes0 = stmt.executeQuery("select description FROM cs_qlf_notes where product_id='"+product+"' and code ='102' order by code ");
	if (cs_exc_notes0 !=null) {
			while (cs_exc_notes0.next()) {
			out.println("<tr><td class='mainbodyh' colspan='3'>"+cs_exc_notes0.getString("description")+"</td></tr>");
		}
	}
	cs_exc_notes0.close();
}
if(qual_sect!=null&&qual_sect.trim().length()>0){
	//all in qualifying notes
	ResultSet cs_exc_notes1 = stmt.executeQuery("select description FROM cs_qlf_notes where product_id='"+product+"' and code in ("+qual_sect+") order by code ");
	if (cs_exc_notes1 !=null) {
		while (cs_exc_notes1.next()) {
			out.println("<tr><td class='mainbodyh' colspan='3'>"+cs_exc_notes1.getString("description")+"</td></tr>");
		}
	}
	cs_exc_notes1.close();
}
if(group_id.startsWith("Internatio")||type.equals("5")||type.equals("6")) {
	out.println("<tr><td colspan='3'  class='mainbodyh'>Material Prices are in U.S. Dollars  - FCA your forwarder, Continental US Port, domestic packed in corrugated cardboard.  For ocean crating add 6.8% to material value.</td></tr>");
}
out.println("<tr><td colspan='3'  class='mainbodyh'>"+qualifying_notes_free_text+"</td></tr>");
out.println("<tr><td  colspan='3' class='mainbodyh'>&nbsp;</td></tr>");
if( !(section_exc==null||section_exc.trim().equals("")||sect_exec.elementAt(ye).toString().trim().equals("")) ){
	if (exc_count>0){exec_sect=exclusions+","+sect_exec.elementAt(ye);}
	else{exec_sect=sect_exec.elementAt(ye).toString();}
	out.println("<tr><td class='mainbodyh' colspan='6' ><b>EXCLUSIONS/NOTES:</b></td></tr>");
}
else if ( ((exclusions_free_text.trim()).length()>0)|(exc_count>0)){
	out.println("<tr><td class='mainbodyh' colspan='6' ><b>EXCLUSIONS/NOTES:</b></td></tr>");
	exec_sect=exclusions;
}
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
//out.println(totprice+"::"+Xcharge2+"::"+Xcharge+"::1<BR>");

out.println("</table>");
Xcharge2=Xcharge2+Xcharge;
for1.setMaximumFractionDigits(0);
//totprice=totprice+Xcharge2;
totprice=totprice+Xcharge3;
price=for1.format(totprice);

grand_total=totprice;
//out.println(grand_total+"::"+totprice+"::"+Xcharge2+"::"+Xcharge+"::2<BR>");
//out.println(ye+"::"+sect_group.size());
if((section_page!=null&&section_page.equals("1"))||ye==(sect_group.size()-1)){
out.println("<tr><td  colspan='6' class='mainbodyh'>&nbsp;</td></tr>");
%>
<%@ include file="quote_template_foot_sfdc.jsp"%>
<%@ include file="quote_template_footer_sfdc.jsp"%>
<%
if(sect_group.size()-ye>1){out.println("<p style='page-break-after : always;' >&nbsp;</p>");}
}
else{
%>
<table class='<%= border_color %>' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only (Includes Freight and Submittals)</b></td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= price %></font>&nbsp;<%=currencyName%></b></td>
	</tr></table>
	<%
	double tax_dollar=0;
	tax_dollar=(grand_total*Double.parseDouble(tax_perc))/100;
	grand_total=grand_total+tax_dollar;
	for1.setMaximumFractionDigits(0);
	if (!(tax_perc==null||tax_perc.equals("0"))){
		out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
		out.println("<tr>");
		out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Tax Only</b></td>");
		out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(tax_dollar)+"</font>&nbsp;"+currencyName+"</b></td>");
		out.println("</tr>");
		out.println("</table>");
		out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
		out.println("<tr>");
		out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material and Tax Only </b></td>");
		out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(grand_total)+"</font>&nbsp;"+currencyName+"</b></td>");
		out.println("</tr>");
		out.println("</table>");
		out.println("<BR><BR><BR>");
	}
}
//out.println("HERE");
for1.setMaximumFractionDigits(2);
for1.setMinimumFractionDigits(2);
totQuotePrice=TOTALPRICE;
totprice=0;exec_sect="";qual_sect="";
overage=tempOverage;
freight_cost=tempFreight_cost;
handling_cost=tempHandling_cost;
}
price=holdPrice;
}// if sections are there

	%>

</table>



