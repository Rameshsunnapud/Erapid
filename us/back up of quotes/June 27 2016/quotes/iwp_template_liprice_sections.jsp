<%
String bgcolor="";int bcount=0;
String bodyString="";
//out.println(bgcolor+"::");
if(bgcolor != null && bgcolor.trim().length()>0){
	bodyString="'"+bgcolor+"' class='tableline_row mainbody'";
}
else{
	bodyString="class='tableline_row mainbody'";
}
if(sections<=1){

	for1.setMinimumFractionDigits(2);for1.setMaximumFractionDigits(2);
	out.println("<table width='100%' class='table_thin_borders' style='border-collapse: collapse;' cellspacing='0' cellpadding='3' border='1'>");
	out.println("<tr height='20' class='table_thin_borders'>");
	out.println("<td   "+bodyString+"><b><u>Model</u></b></td>");
	out.println("<td width='5%'  "+bodyString+"><b><u>Qty</u></b></td>");
	out.println("<td width='5%'  "+bodyString+"><b><u>UOM</u></b></td>");
	if(type.equals("2")){
		out.println("<td width='5%'  "+bodyString+"><b><u>Unit Price</u></b></td>");
		out.println("<td width='5%'  "+bodyString+"><b><u>Line Total</u></b></td>");
	}
	out.println("</tr>");
	int k=0;Vector mark=new Vector();Vector desc=new Vector();Vector qty=new Vector();Vector rec_no=new Vector();
	Vector price_csquotes=new Vector();Vector line_no=new Vector();String color="NONE";Vector um=new Vector();Vector blockId=new Vector();
	ResultSet rs_csquotes = stmt.executeQuery("select * from csquotes where order_no='"+order_no+"' and Block_ID !='A_APRODUCT' and Block_ID like 'A%' order by cast(Line_no as integer)");
	if (rs_csquotes !=null) {
		while (rs_csquotes.next()) {
			line_no.addElement(rs_csquotes.getString("Line_no"));
			desc.addElement(rs_csquotes.getString("Descript"));
			//out.println(rs_csquotes.getString("line_no")+"::"+rs_csquotes.getString("descript")+"::"+rs_csquotes.getString("extended_price")+"::<BR>");
			price_csquotes.addElement(rs_csquotes.getString ("Extended_Price"));
			rec_no.addElement(rs_csquotes.getString("Record_no"));
			qty.addElement(rs_csquotes.getString("Qty"));
			mark.addElement(rs_csquotes.getString("field17"));
			blockId.addElement(rs_csquotes.getString("block_id"));
			if(rs_csquotes.getString("uom") != null){um.addElement(rs_csquotes.getString("uom"));}
			else{um.addElement("");}
			k++;
		}
	}
	rs_csquotes.close();
	String config_price="";Vector line_item_group=new Vector();Vector line_sum_group=new Vector();double tot_sum=0;
	ResultSet rs_csquotes_sum = stmt.executeQuery("SELECT line_no, sum(cast(extended_price as decimal)) FROM CSQUOTES where order_no='"+order_no+"' group by line_no order by cast(Line_no as integer)");
	if (rs_csquotes_sum !=null) {
         	while (rs_csquotes_sum.next()) {
			//		 config_price=rs_csquotes_sum.getString(1);
			line_item_group.addElement(rs_csquotes_sum.getString(1));
			line_sum_group.addElement(rs_csquotes_sum.getString(2));
			tot_sum=tot_sum+new Double(rs_csquotes_sum.getString(2)).doubleValue();
		}
	}
	rs_csquotes_sum.close();
	double totprice=0;String line_cost="";double adders=0;
	for (int n=0;n<k;n++){
		if(blockId.elementAt(n).toString().toUpperCase().equals("C_OPTIONS")||blockId.elementAt(n).toString().toUpperCase().startsWith("B_CHARGE")){
			adders=adders+new Double(price_csquotes.elementAt(n).toString()).doubleValue();
		}
		else{
			if ((n%2)==1){bgcolor="white";}else {bgcolor="white";	}
			out.println("<tr class='table_thin_borders'>");
			out.println("<td valign='top'  bgcolor='"+bgcolor+"' "+bodyString+">"+desc.elementAt(n).toString()+"</td>");
			out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+">"+qty.elementAt(n).toString()+"</td>");
			//line_cost=line_sum_group.elementAt(n).toString();//commented temperioraly
			line_cost=""+(new Double(price_csquotes.elementAt(n).toString()).doubleValue()+adders);
			BigDecimal d1 = new BigDecimal(line_cost);
			BigDecimal d2 = new BigDecimal(tot_sum);//total configured price
			//out.println(d1+"::"+d2+"<BR>");
			double gregFact=0;
			if(new Double(tot_sum).doubleValue()>0){
				gregFact=new Double(overage).doubleValue()*(new Double(line_cost).doubleValue()/new Double(tot_sum).doubleValue());
			}
			BigDecimal d3_o = new BigDecimal(overage);
			if(new Double(tot_sum).doubleValue()>0){
				BigDecimal d3 = d1.divide(d2,BigDecimal.ROUND_HALF_UP);
				BigDecimal d4 = d3.multiply(d3_o);
				d4 = d4.setScale(0, BigDecimal.ROUND_HALF_UP);
				totprice=(new Double(line_cost)).doubleValue()+gregFact;
			}
			int qty1= qty.elementAt(n).toString().indexOf("(");
			String qty2="";
			if(qty1>0){qty2=qty.elementAt(n).toString().substring(0,qty1); }
			else{ qty2=qty.elementAt(n).toString();}
			out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='left'>"+um.elementAt(n).toString()+"&nbsp;"+"</td>");
			if(type.equals("2")){
				out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='right'>"+for1.format(totprice/(new Double(qty2)).doubleValue())+"&nbsp;"+"</td>");
				out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+"  align='right'>"+for1.format(totprice)+"&nbsp;"+"</td>");
			}
			out.println("</tr>");
			adders=0;
		}
	}//for loop
	if((type.equals("2"))){
		String colspan="1";
		if(type.equals("1")){colspan="2";}
		/*
		if( (new Double(handling_cost)).doubleValue()>0 ){
			out.println("<tr class='table_thin_borders'>");
			out.println("<td valign='top'  bgcolor='"+bgcolor+"' "+bodyString+">"+"Freight Surcharge."+"</td>");
			out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='left' colspan='"+colspan+"'>"+"1"+"</td>");
			String align="right";if(!type.equals("2")){align="left";}
			out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='"+align+"' colspan='"+colspan+"'>"+"EA"+"</td>");
			if(type.equals("2")){
				out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='right'>"+"$"+handling_cost+"&nbsp;"+"</td>");
				out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='right' colspan='"+colspan+"'>"+"$"+handling_cost+"&nbsp;"+"</td>");
			}
			out.println("</tr>");
		}
		*/
		if( (new Double(freight_cost)).doubleValue()>0 ){
			out.println("<tr class='table_thin_borders'>");
			out.println("<td valign='top'  bgcolor='"+bgcolor+"' "+bodyString+">"+"Special Freight Charge."+"</td>");
			out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='left' colspan='"+colspan+"'>"+"1"+"</td>");
			String align="right";if(!type.equals("2")){align="left";	}
			out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='"+align+"' colspan='"+colspan+"'>"+"EA"+"</td>");
			if(type.equals("2")){
				out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='right'>"+""+for1.format(new Double(freight_cost).doubleValue())+"&nbsp;"+"</td>");
				out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='right' colspan='"+colspan+"'>"+""+for1.format(new Double(freight_cost).doubleValue())+"&nbsp;"+"</td>");
			}
			out.println("</tr>");
		}
	}
	grandtotalforsec=df0.format(grand_total3);
}// if no sections
else {// if sections are there
	grandtotalforsec=df0.format(grand_total3);
	//out.println(grandtotalforsec+"::HERE<BR>");
	for1.setMinimumFractionDigits(2); for1.setMaximumFractionDigits(2);
	double sumTotal=0;
	ResultSet rsSumTot=stmt.executeQuery("Select sum(cast(extended_price as decimal)) from csquotes where order_no='"+order_no+"' and ((Block_ID !='A_APRODUCT' and Block_ID like 'A%') or Block_id = 'C_OPTIONS' or block_id like 'b_charge%')");
	if(rsSumTot != null){
		while(rsSumTot.next()){
			sumTotal=new Double(rsSumTot.getString(1)).doubleValue();
		}
	}
	rsSumTot.close();
	for1.setMinimumFractionDigits(2);
	double totprice=0;String line_cost="";double line_price=0;String qual_sect="";String exec_sect="";
	for(int ye=0;ye<sect_group.size();ye++){
		secLines = sect_group_lines.elementAt(ye).toString();
		//header for new pages
		if(section_page==null||section_page.equals("1")){
%>
<%@ include file="quote_template_header.jsp"%>
<%@ include file="quote_template_top.jsp"%>
<%
}
out.println("<table width='100%' cellspacing='0' cellpadding='1' border='1'>");
out.println("<tr height='20'>");
out.println("<td class='mainbodyh' colspan='5'> ");out.println("<b>Section: "+(String)sect_group.elementAt(ye)+"</b>" );	out.println("</td>");
out.println("</tr>");
out.println("<tr height='20'>");
if(type.equals("1") || type.equals("2")){
out.println("<td   "+bodyString+"><b><u>Model</u></b></td>");
}
else{
out.println("<td   "+bodyString+" colspan='5'><b><u>Model</u></b></td>");
}
if(type.equals("1")){
out.println("<td width='5%'  "+bodyString+" colspan='2'><b><u>Qty</u></b></td>");
out.println("<td width='5%'  "+bodyString+" colspan='2'><b><u>UOM</u></b></td>");
}
if(type.equals("2")){
out.println("<td width='5%'  "+bodyString+"><b><u>Qty</u></b></td>");
out.println("<td width='5%'  "+bodyString+"><b><u>UOM</u></b></td>");
out.println("<td width='5%'  "+bodyString+"><b><u>Unit Price</u></b></td>");
out.println("<td width='5%'  "+bodyString+"><b><u>Line Total</u></b></td>");
}
out.println("</tr>");
double sumX=0;
ResultSet rsSum=stmt.executeQuery("select sum(cast(extended_price as decimal)) from csquotes where order_no='"+order_no+"' and ((Block_ID !='A_APRODUCT' and Block_ID like 'A%') or Block_id = 'C_OPTIONS' or block_id like 'b_charge%') and line_no in("+sect_group_lines.elementAt(ye).toString()+")");
if(rsSum != null){
while(rsSum.next()){
	sumX=new Double(rsSum.getString(1)).doubleValue();
}
}
rsSum.close();

//out.println(sect_group_lines.elementAt(ye).toString()+"::BR>");
//			out.println("freightb:"+freight_cost+"sumx"+sumX+":::::"+sumTotal);
//out.println(isSecOverage + "::" + overageSec.size()+"<BR>");
if(isSecOverage && overageSec.size()>0){
//out.println("HERE");
if((overageSec.elementAt(ye) != null && overageSec.elementAt(ye).toString().trim().length()>0)){
	overageX=new Double(overageSec.elementAt(ye).toString()).doubleValue();
}
}
else{
overageX=new Double(overage).doubleValue()*(sumX/sumTotal);
}
if(isSecFreight && freightSec.size()>0){
if(freightSec.elementAt(ye) != null && freightSec.elementAt(ye).toString().trim().length()>0){
	freightX=new Double(freightSec.elementAt(ye).toString()).doubleValue();
	//					out.println("<br>hello"+freightX+"<br>");
}
}
else{
freightX=new Double(freight_cost).doubleValue()*(sumX/sumTotal);
}
if(isSecHandling && handlingSec.size()>0){
if(handlingSec.elementAt(ye) != null && handlingSec.elementAt(ye).toString().trim().length()>0){
	handlingX=new Double(handlingSec.elementAt(ye).toString()).doubleValue();
}
}
else{
handlingX=new Double(handling_cost).doubleValue()*(sumX/sumTotal);
}
//out.println(overageX+"::"+freightX+"::"+handlingX+"::<BR>");
//			out.println("freight:"+freightX);
String 	stat1="select * from csquotes where order_no='"+order_no+"' and ((Block_ID !='A_APRODUCT' and Block_ID like 'A%') or Block_id = 'C_OPTIONS' or block_id like 'b_charge%') and line_no in("+sect_group_lines.elementAt(ye).toString()+") order by cast(Line_no as integer),block_id desc";
ResultSet rsn=stmt.executeQuery(stat1);
String lineX="";double adders=0;bcount=0;

while(rsn.next()){

if(rsn.getString("block_id").toUpperCase().equals("C_OPTIONS")||rsn.getString("block_id").toUpperCase().startsWith("B_CHARGE")){
	if(!lineX.equals(rsn.getString("line_no"))){
		adders=0;
	}
	adders=adders+rsn.getDouble("extended_price");
	//out.println(adders+"::<BR>");
	lineX=rsn.getString("line_no");
}
else{
	if(!lineX.equals(rsn.getString("line_no"))){
		adders=0;
	}
	if ((bcount%2)==1){bgcolor="white";}else {bgcolor="white";	}
	//					out.println("color"+bcount);
	for1.setMaximumFractionDigits(2);for1.setMinimumFractionDigits(2);
	line_cost=rsn.getString("Extended_Price");
	line_cost=""+(new Double(line_cost).doubleValue()+adders);
	//out.println(adders+"::"+line_cost+"::<BR>");
	if(new Double(sumX).doubleValue()>0){
		BigDecimal d1 = new BigDecimal(line_cost);
		BigDecimal d2 = new BigDecimal(sumX);//total configured price
		BigDecimal d3_o = new BigDecimal(overageX);
		BigDecimal d5=d3_o.multiply(d1);
		BigDecimal d6=d5.divide(d2,BigDecimal.ROUND_HALF_UP);

		totprice=totprice+new Double(line_cost).doubleValue();
		//+d6.doubleValue();
		//out.println(totprice+"::"+new Double(line_cost).doubleValue()+"::<BR>");
		line_price=(new Double(line_cost)).doubleValue()+d6.doubleValue();
	}
	String qty2=rsn.getString("Qty");
	out.println("<tr>");
	if(type.equals("1") || type.equals("2")){
		out.println("<td valign='top'  bgcolor='"+bgcolor+"' "+bodyString+">"+rsn.getString("Descript")+"</td>");
	}
	else{
		out.println("<td valign='top'  bgcolor='"+bgcolor+"' "+bodyString+" colspan='5'>"+rsn.getString("Descript")+"</td>");
	}
	if(type.equals("1")){
		out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" colspan='2'>"+qty2+"</td>");
		out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='right' colspan='2'>"+rsn.getString("uom")+"&nbsp;"+"</td>");
	}
	if(type.equals("2")){
		out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+">"+qty2+"</td>");
		out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='right'>"+rsn.getString("uom")+"&nbsp;"+"</td>");
		out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='right'>"+for1.format(line_price/(new Double(qty2)).doubleValue())+"&nbsp;"+"</td>");
		out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+"  align='right'>"+for1.format(line_price)+"&nbsp;"+"</td>");
	}
	out.println("</tr>");
	bcount++;
}//else

}//while
totprice=Math.round(totprice);
totprice=totprice+freightX;
totprice=totprice+handlingX;
//out.println(totprice+"::<BR>");
totprice=totprice+overageX;
//out.println(totprice+"::"+overageX+"::<BR>");
if((type.equals("2"))){
String colspan="1";
if(type.equals("1")){
	colspan="2";
}
if( handlingX>0 ){
	if ((bcount%2)==1){bgcolor="white";}else {bgcolor="white";	}
	bcount++;
	out.println("<tr>");
	out.println("<td valign='top'  bgcolor='"+bgcolor+"' "+bodyString+">"+"Freight Surcharge."+"</td>");
	out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='left' colspan='"+colspan+"'>"+"1"+"</td>");
	out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='right' colspan='"+colspan+"'>"+"EA"+"</td>");
	if(type.equals("2")){
		out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='right'>"+""+for1.format(handlingX)+"&nbsp;"+"</td>");
		out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='right' colspan='"+colspan+"'>"+""+for1.format(handlingX)+"&nbsp;"+"</td>");
	}
	out.println("</tr>");
}
if( freightX>0 ){
	if ((bcount%2)==1){bgcolor="white";}else {bgcolor="white";	}
	bcount++;
	out.println("<tr>");
	out.println("<td valign='top'  bgcolor='"+bgcolor+"' "+bodyString+">"+"Special Freight Charge."+"</td>");
	out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='left' colspan='"+colspan+"'>"+"1"+"</td>");
	out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='right' colspan='"+colspan+"'>"+"EA"+"</td>");
	if(type.equals("2")){
		out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='right'>"+""+for1.format(freightX)+"&nbsp;"+"</td>");
		out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' "+bodyString+" align='right' colspan='"+colspan+"'>"+""+for1.format(freightX)+"&nbsp;"+"</td>");
	}
	out.println("</tr>");
}
}
%>
</table>
<!--<table>-->
<%
out.println("<table width='100%' cellspacing='0' cellpadding='1' border='0'>");
if(section_notes!=null &&section_notes.trim().length()>0 && ! (section_notes.equals("null"))){
	out.println("<tr height='20'>");
	out.println("<td class='mainbodyh' colspan='5' align='left'>");out.println(sect_notes.elementAt(ye));	out.println("</td>");
	out.println("</tr>");//free notes end
}
if( !(section_qual==null||section_qual.trim().equals("")||sect_qual.elementAt(ye).toString().trim().equals("")) ){
	out.println("<tr><td class='mainbodyh' colspan='5' ><b>QUALIFYING NOTES:</b></td></tr>");
	if (qual_count>0){qual_sect=sect_qual.elementAt(ye).toString();}
	else{qual_sect=sect_qual.elementAt(ye).toString();}//			out.println("test"+qualifying_notes);
}
if(qual_sect!=null&&qual_sect.trim().length()>0){
	ResultSet cs_exc_notes1 = stmt.executeQuery("select description FROM cs_qlf_notes where product_id='"+product+"' and code in ("+qual_sect+") order by code ");
	if (cs_exc_notes1 !=null) {
	while (cs_exc_notes1.next()) {
			out.println("<tr><td class='mainbodyh' colspan='3'>"+cs_exc_notes1.getString("description")+"</td></tr>");
		}
	}
	cs_exc_notes1.close();
}
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
for1.setMaximumFractionDigits(0);for1.setMinimumFractionDigits(0);

price=for1.format(totprice);
grand_total1=totprice;
//out.println(totprice);
grandtotalforsec=""+totprice;
taxtotal=totprice;

 sect_group_linesx=sect_group_lines.elementAt(ye).toString();
if(section_page==null||section_page.equals("1")){
	//out.println("HERE");
%>
<%@ include file="quote_template_foot.jsp"%>
<%@ include file="quote_template_footer.jsp"%>
<%
if(sect_group.size()-ye>1){
	out.println("<p style='page-break-after : always;' >&nbsp;</p>");
}
for1.setMaximumFractionDigits(2);
}
else{

if((""+ye).equals(""+(sect_group.size()-1))){
	//out.println("HERE1");

	grand_total3=Float.parseFloat(""+grand_total1);
%>
<%@ include file="quote_template_foot.jsp"%>
<%@ include file="quote_template_footer.jsp"%>
<%
}
else{
DecimalFormat for0dec = new DecimalFormat("####");
DecimalFormat for2dec = new DecimalFormat("####.##");
for0dec.setMinimumFractionDigits(0);
for0dec.setMaximumFractionDigits(0);
for2dec.setMinimumFractionDigits(2);
for2dec.setMaximumFractionDigits(2);
%>
</table>
<table class='<%= border_color %>' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
		<%
		if (!(tax_perc==null||tax_perc.equals("0"))){
		%>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only:(Tax not included)</b></td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$<%= for2dec.format(totprice-handlingX) %></font></b></td>
				<%
			}
			else{
				%>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only</b></td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$<%= for2dec.format(totprice-handlingX) %></font></b></td>
				<%
			}
				%>

	</tr>


	<%
	if(handlingX>0){
	%>
	<tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b>Freight Surcharge</b></td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$<%= for2dec.format(handlingX) %></font></b></td>
	</tr>


	<% if ((tax_perc==null||tax_perc.equals("0"))){ %>

	<tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'>&nbsp;</td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>$<%= for2dec.format(totprice) %></font></b></td>
	</tr>


	<%
			if(customerCountry.equals("CANADA")){
				out.println("<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>HST Extra   FOB CS PLANT,  FREIGHT EXTRA</td></tr>");

			}
			else{
				out.println("<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB plant, freight prepaid (to jobsite) within continental U.S. or FAS dock export point. Tax not included.</td></tr></table>");
			}
}
}



double tax_dollar=0;
//out.println(grand_total1+"::"+tax_perc);
	//out.println("a<BR><BR>b");
	%>
</table>

<%
if(tax_perc==null || tax_perc.trim().length()<=0){

	tax_perc="0";
}
tax_dollar=(grand_total1*Double.parseDouble(tax_perc))/100;
float temptax=Float.parseFloat(""+tax_dollar)*100;
temptax=Math.round(temptax);
//out.println(temptax);
temptax=temptax/100;
//out.println(temptax);
tax_dollar=new Double(""+temptax).doubleValue();
//out.println(tax_dollar);
grand_total1=grand_total1+tax_dollar;
for1.setMaximumFractionDigits(2);
//out.println(grand_total1+"::"+tax_dollar+"<BR>");
//grand_total1=grand_total1+tax_dollar;
for1.setMaximumFractionDigits(2);
for1.setMinimumFractionDigits(2);
DecimalFormat df2 = new DecimalFormat("####.##");
df2.setMaximumFractionDigits(2);
df2.setMinimumFractionDigits(2);

if (!(tax_perc==null||tax_perc.equals("0"))){

%>
<jsp:include page="summary_tax.jsp" flush="true">
	<jsp:param name="order_no" value="<%= order_no%>"/>
	<jsp:param name="tax_perc" value="<%= tax_perc%>"/>
	<jsp:param name="overage" value="<%=overageX %>"/>
	<jsp:param name="handling_cost" value="<%=handlingX %>"/>
	<jsp:param name="freight_cost" value="<%=freightX %>"/>
	<jsp:param name="setup_cost1" value="0"/>
	<jsp:param name="setup_cost" value="0"/>
	<jsp:param name="totprice_dis" value="<%= taxtotal%>"/>
	<jsp:param name="grandtotalforsec" value="<%= grandtotalforsec%>"/>
	<jsp:param name="secLines" value="<%= secLines%>"/>
	<jsp:param name="isRepQuote" value="yes"/>
	<jsp:param name="section" value="<%= sect_group_lines.elementAt(ye).toString()%>"/>
	<jsp:param name="product_id" value="<%= product%>"/>
</jsp:include>
<%

}

for1.setMaximumFractionDigits(2);
for1.setMinimumFractionDigits(2);
out.println("<BR><BR>");
}
}
totprice=0;qual_sect=""; freightX=0;handlingX=0;overageX=0;
}//for loop
}// if sections are there
%>
</table>

