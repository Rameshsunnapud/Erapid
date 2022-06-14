<%

String bgcolor="";int bcount=0;

String headerString="bgcolor='#996600' class='schedule'";
//if(output.equals("rtf")){
//	headerString="";
//}

String bodyString="";
//out.println(bgcolor+"::");
if(bgcolor != null && bgcolor.trim().length()>0){
	bodyString="'"+bgcolor+"' class='maindesc'";
}
else{
	bodyString="class='maindesc'";
}
//if(output.equals("rtf")){
//	bodyString=" class='maindesc'";
//}
//out.println(sections);
if(sections<=1){
 for1.setMinimumFractionDigits(2);
  for1.setMaximumFractionDigits(2);
	int k=0;Vector mark=new Vector();Vector desc=new Vector();Vector qty=new Vector();Vector rec_no=new Vector();
	Vector price_csquotes=new Vector();
	Vector line_no=new Vector();String color="NONE";
	Vector um=new Vector();
	Vector blockId=new Vector();
	ResultSet rs_csquotes = stmt.executeQuery("select * from csquotes where order_no='"+order_no+"' and ((Block_ID !='A_APRODUCT' and Block_ID like 'A%') or Block_id = 'C_OPTIONS' or block_id like 'b_charg%') order by cast(Line_no as integer),block_id desc");
	if (rs_csquotes !=null) {
		while (rs_csquotes.next()) {
			line_no.addElement(rs_csquotes.getString("Line_no"));
			desc.addElement(rs_csquotes.getString("Descript"));
			price_csquotes.addElement(rs_csquotes.getString ("Extended_Price"));
			rec_no.addElement(rs_csquotes.getString("Record_no"));
			qty.addElement(rs_csquotes.getString("Qty"));
			mark.addElement(rs_csquotes.getString("field17"));
			//out.println(rs_csquotes.getString("block_id")+"::<BR>");
			blockId.addElement(rs_csquotes.getString("block_id"));
			if(rs_csquotes.getString("uom") != null){
				um.addElement(rs_csquotes.getString("uom"));
			}
			else{
				um.addElement("");
			}

			k++;
		}
	}
	rs_csquotes.close();
	String config_price="";Vector line_item_group=new Vector();Vector line_sum_group=new Vector();double tot_sum=0;
	ResultSet rs_csquotes_sum = stmt.executeQuery("SELECT line_no, sum(cast(extended_price as decimal)) FROM CSQUOTES where order_no='"+order_no+"' group by line_no order by cast(Line_no as integer)");
	if (rs_csquotes_sum !=null) {
		while (rs_csquotes_sum.next()) {
			//config_price=rs_csquotes_sum.getString(1);
			line_item_group.addElement(rs_csquotes_sum.getString(1));
			line_sum_group.addElement(rs_csquotes_sum.getString(2));
			tot_sum=tot_sum+new Double(rs_csquotes_sum.getString(2)).doubleValue();
		}
	}
	rs_csquotes_sum.close();
	tot_sum=tot_sum;
	//
	if(group_id.startsWith("Internatio")) {
		out.println("<table width='100%' border='1'>");
	}
	else{
		out.println("<table width='100%' border='2'>");
	}

	out.println("<tr height='20'>");


	if(type.equals("1")||type.equals("6")){
		out.println("<td  "+headerString+"><b><u>Model</u></b></td>");
		out.println("<td width='5%' "+headerString+" colspan='2'><b><u>Qty</u></b></td>");
		out.println("<td width='5%' "+headerString+" colspan='2'><b><u>UOM</u></b></td>");
	}
	else if(type.equals("2")||type.equals("5")){
		out.println("<td  "+headerString+" width='64%'><b><u>Model</u></b></td>");
		out.println("<td width='8%' "+headerString+" align='center'><b><u>Qty</u></b></td>");
		out.println("<td width='8%' "+headerString+" align='center'><b><u>UOM</u></b></td>");
		out.println("<td width='10%' "+headerString+" align='center'><b><u>Unit Price</u></b></td>");
		out.println("<td width='10%' "+headerString+" align='center'><b><u>Line Total</u></b></td>");
	}
	else if(type.equals("4")){
		out.println("<td  "+headerString+" width='90%'><b><u>Modela</u></b></td>");
		out.println("<td width='5%' "+headerString+" align='center'><b><u>Qty</u></b></td>");
		out.println("<td width='5%' "+headerString+" align='center'><b><u>UOM</u></b></td>");
	}
	else{
		out.println("<td  "+headerString+" colspan='5'><u>Model</u></b></td>");
	}
	out.println("</tr>");
	//overage="0";
	double totprice=0;String line_cost="";double adders=0;
	for (int n=0;n<line_no.size();n++){
		if(blockId.elementAt(n).toString().toUpperCase().equals("C_OPTIONS")||blockId.elementAt(n).toString().toUpperCase().startsWith("B_CHARGE")){
			adders=adders+new Double(price_csquotes.elementAt(n).toString()).doubleValue();
			//out.println(adders+" block id "+ blockId.elementAt(n).toString()+"<BR>");
		}
		else{
			String qty2="";
			if ((n%2)==1){bgcolor="#d6d6ad";}else {bgcolor="#ffffd9";	}
			out.println("<tr>");
			if(type.equals("1") || type.equals("2")||type.equals("4")||type.equals("6")||type.equals("5")){
				out.println("<td valign='top'  "+bodyString+">"+desc.elementAt(n).toString()+" </td>");
			}
			else{
				out.println("<td valign='top'  "+bodyString+" colspan='5'>"+desc.elementAt(n).toString()+"</td>");
			}
			//out.println(tot_sum + " TOTAL<BR>");
			String tot_sumx=""+tot_sum;
			//out.println("<td valign='top'  "+bodyString+">"+desc.elementAt(n).toString()+"</td>");
			if(type.equals("4")){
				out.println("<td valign='center' nowrap  "+bodyString+" >"+qty.elementAt(n).toString()+"</td>");
				out.println("<td valign='center' nowrap  "+bodyString+" align='right' >"+um.elementAt(n).toString()+"&nbsp;</td>");
			}
			if(type.equals("1")||type.equals("6")){
				out.println("<td valign='center' nowrap  "+bodyString+" colspan='2'>"+qty.elementAt(n).toString()+"</td>");
				line_cost=""+(new Double(price_csquotes.elementAt(n).toString()).doubleValue()+adders);
				//out.println(price_csquotes.elementAt(n).toString()+"::"+adders+"<BR>");
				BigDecimal d1 = new BigDecimal(line_cost);
				BigDecimal d2 = new BigDecimal(tot_sumx);//total configured price

				BigDecimal d3_o = new BigDecimal(overage);
				BigDecimal d5=d3_o.multiply(d1);


				BigDecimal d3 = d1.divide(d2,BigDecimal.ROUND_HALF_UP);
				BigDecimal d4 = d3.multiply(d3_o);
				d4 = d4.setScale(0, BigDecimal.ROUND_HALF_UP);
				totprice=(new Double(line_cost)).doubleValue()+d4.doubleValue();

				int qty1= qty.elementAt(n).toString().indexOf("(");
				if(qty1>0){
					qty2=qty.elementAt(n).toString().substring(0,qty1);
				}
				else{
					qty2=qty.elementAt(n).toString();
				}
				out.println("<td valign='center' nowrap  "+bodyString+" align='right' colspan='2'>"+um.elementAt(n).toString()+"&nbsp;</td>");
			}
			if(type.equals("2")||type.equals("5")){
				out.println("<td valign='center' nowrap  "+bodyString+" align='center'>"+qty.elementAt(n).toString()+"</td>");
				line_cost=""+(new Double(price_csquotes.elementAt(n).toString()).doubleValue()+adders);
				BigDecimal d1 = new BigDecimal(line_cost);
				BigDecimal d2 = new BigDecimal(tot_sumx);//total configured price
				BigDecimal d3_o = new BigDecimal(overage);
				BigDecimal d5=d3_o.multiply(d1);
				BigDecimal d6=d5.divide(d2,BigDecimal.ROUND_HALF_UP);
				totprice=new Double(line_cost).doubleValue()+d6.doubleValue();
				/*
				out.println(d5 +"::"+d2+"::"+d6+"::D5<br>");
				BigDecimal d3 = d1.divide(d2,BigDecimal.ROUND_HALF_UP);
				BigDecimal d4 = d3.multiply(d3_o);
				d4 = d4.setScale(0, BigDecimal.ROUND_HALF_UP);
				//totprice=(new Double(line_cost)).doubleValue()+d4.doubleValue();
				*/
				int qty1= qty.elementAt(n).toString().indexOf("(");
				//out.println(line_cost+"::"+overage+"::"+tot_sumx+"::"+d4+"<BR>");
				if(qty1>0){
					qty2=qty.elementAt(n).toString().substring(0,qty1);
				}
				else{
					qty2=qty.elementAt(n).toString();
				}
				out.println("<td valign='center' nowrap  "+bodyString+" align='center'>"+um.elementAt(n).toString()+"&nbsp;"+"</td>");
				out.println("<td valign='center' nowrap  "+bodyString+" align='right'>"+for1.format(totprice/(new Double(qty2)).doubleValue())+"&nbsp;"+"</td>");
				out.println("<td valign='center' nowrap  "+bodyString+"  align='right'>"+for1.format(totprice)+"&nbsp;"+"</td>");

			}
			//out.println(price_csquotes.elementAt(n).toString()+"::"+adders+" here<BR>");
			out.println("</tr>");
			adders=0;
		}
	}//for losop
	//out.println(type+"::<BR>");
			if((type.equals("2")||type.equals("5"))){
								String colspan="1";
								if(type.equals("1")||type.equals("6")){
									colspan="2";
					}
				if( (new Double(handling_cost)).doubleValue()>0 ){

					out.println("<tr>");
					out.println("<td valign='top'  "+bodyString+">"+"Small Order Handling Charge."+"</td>");
					out.println("<td valign='center' nowrap width='5%' "+bodyString+" align='center' colspan='"+colspan+"'>"+"1"+"</td>");
					String align="right";
					if(!(type.equals("2")||type.equals("5"))){
						align="left";
					}
else{
align="center";
}
						out.println("<td valign='center' nowrap  "+bodyString+" align='"+align+"' colspan='"+colspan+"'>"+"EA"+"</td>");
					if(type.equals("2")||type.equals("5")){
					out.println("<td valign='center' nowrap "+bodyString+" align='right'>"+"$"+handling_cost+"&nbsp;"+"</td>");

					out.println("<td valign='center' nowrap  "+bodyString+" align='right' colspan='"+colspan+"'>"+"$"+handling_cost+"&nbsp;"+"</td>");
					}
					out.println("</tr>");

				}

				if( (new Double(freight_cost)).doubleValue()>0 ){
					out.println("<tr>");
					out.println("<td valign='top'  "+bodyString+">"+"Special Freight Charge."+"</td>");
					out.println("<td valign='top' nowrap ' "+bodyString+" align='center' colspan='"+colspan+"'>"+"1"+"</td>");
					String align="right";
					if(!(type.equals("2")||type.equals("5"))){
						align="left";
					}
					out.println("<td valign='top' nowrap  "+bodyString+" align='"+align+"' colspan='"+colspan+"'>"+"EA"+"</td>");
					if(type.equals("2")||type.equals("5")){
					out.println("<td valign='top' nowrap "+bodyString+" align='right'>"+""+for1.format(new Double(freight_cost).doubleValue())+"&nbsp;"+"</td>");

					out.println("<td valign='top' nowrap  "+bodyString+" align='right' colspan='"+colspan+"'>"+""+for1.format(new Double(freight_cost).doubleValue())+"&nbsp;"+"</td>");
					}
					out.println("</tr>");
				}
}
%>

</table>

<table>
</table>
<%
rs_csquotes_sum.close();
}
else {

//out.println("HERE");
for1.setMinimumFractionDigits(2);
for1.setMaximumFractionDigits(2);
double sumTotal=0;
double freightX=0;
double handlingX=0;
double tempOverage=0;
double tempFreight_cost=0;
double tempHandling_cost=0;
ResultSet rsSumTot=stmt.executeQuery("Select sum(cast(extended_price as decimal)) from csquotes where order_no='"+order_no+"' and ((Block_ID !='A_APRODUCT' and Block_ID like 'A%') or Block_id = 'C_OPTIONS' or block_id like 'b_charge%')");
if(rsSumTot != null){
while(rsSumTot.next()){
	sumTotal=new Double(rsSumTot.getString(1)).doubleValue();
}
}
rsSumTot.close();





//out.println("HERE<BR>");
for1.setMinimumFractionDigits(2);
double totprice=0;String line_cost="";double line_price=0;String qual_sect="";

for(int ye=0;ye<sect_group.size();ye++){
	tempOverage=new Double(overage).doubleValue();
	tempFreight_cost=new Double(freight_cost).doubleValue();
	tempHandling_cost=new Double(handling_cost).doubleValue();
	//header for new pages
	if(section_page==null||section_page.equals("1")){
%>
<%@ include file="quote_template_header_sfdc.jsp"%>
<%@ include file="quote_template_top_sfdc.jsp"%>
<%
}
//out.println("<br>");
out.println("<table width='95%' cellspacing='0' cellpadding='1' border='1'>");
out.println("<tr height='20'>");
out.println("<td class='mainbodyh' colspan='5'> ");out.println("<b>Section: "+(String)sect_group.elementAt(ye)+"</b>" );	out.println("</td>");
out.println("</tr>");
out.println("<tr height='20'>");

if(type.equals("1")||type.equals("6")){
out.println("<td  "+headerString+"><b><u>Model</u></b></td>");
out.println("<td width='5%' "+headerString+" colspan='2'><b><u>Qty</u></b></td>");
out.println("<td width='5%' "+headerString+" colspan='2'><b><u>UOM</u></b></td>");
}
else if(type.equals("2")||type.equals("5")){
out.println("<td width='70%' "+headerString+"><b><u>Model</u></b></td>");
out.println("<td width='5%' "+headerString+"><b><u>Qty</u></b></td>");
out.println("<td width='5%' "+headerString+"><b><u>UOM</u></b></td>");
out.println("<td width='10%' "+headerString+"><b><u>Unit Price</u></b></td>");
out.println("<td width='10%' "+headerString+"><b><u>Line Total</u></b></td>");
}
else if(type.equals("4")){
out.println("<td  "+headerString+" width='90%'><b><u>Model</u></b></td>");
out.println("<td width='5%' "+headerString+" align='center'><b><u>Qty</u></b></td>");
out.println("<td width='5%' "+headerString+" colspan='2'><b><u>UOM</u></b></td>");
}
else{
out.println("<td  "+headerString+" colspan='5'><b><u>Model</u></b></td>");
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
double overageX=0;
overageX=new Double(overage).doubleValue()*(sumX/sumTotal);
//out.println(overageX+":: BEFORE");
freightX=new Double(freight_cost).doubleValue()*(sumX/sumTotal);
handlingX=new Double(handling_cost).doubleValue()*(sumX/sumTotal);
if(overageSec.elementAt(ye) != null && overageSec.elementAt(ye).toString().trim().length()>0){
overageX=new Double(overageSec.elementAt(ye).toString()).doubleValue();
}
if(freightSec.elementAt(ye) != null && freightSec.elementAt(ye).toString().trim().length()>0){
freightX=new Double(freightSec.elementAt(ye).toString()).doubleValue();
}
if(handlingSec.elementAt(ye) != null && handlingSec.elementAt(ye).toString().trim().length()>0){
handlingX=new Double(handlingSec.elementAt(ye).toString()).doubleValue();
}
//out.println(overageX+":: after"+overageSec);

//out.println(freightX+"::"+handlingX+"::"+overageX+" overageX<BR>");
//***********************************
//* Attn: Replace overageX with secOverage for section overage division
//***********************************
String 	stat1="select * from csquotes where order_no='"+order_no+"' and ((Block_ID !='A_APRODUCT' and Block_ID like 'A%') or Block_id = 'C_OPTIONS' or block_id like 'b_charge%') and line_no in("+sect_group_lines.elementAt(ye).toString()+") order by cast(Line_no as integer),block_id desc";
ResultSet rsn=stmt.executeQuery(stat1);
double adders=0;
String lineX="";
//overage="0";

while(rsn.next()){
//out.println(rsn.getString("block_id")+"<BR>");
if(rsn.getString("block_id").toUpperCase().equals("C_OPTIONS")||rsn.getString("block_id").toUpperCase().startsWith("B_CHARGE")){
	adders=adders+rsn.getDouble("extended_price");
	//out.println(adders+" adders<BR>");
	//lineX=rsn.getString("line_no");
}
else{
for1.setMaximumFractionDigits(2);
for1.setMinimumFractionDigits(2);
	if ((bcount%2)==1){bgcolor="#EFEFDE";}else {bgcolor="#e4e4e4";	}
		line_cost=rsn.getString("Extended_Price");
		//out.println(line_cost+"::"+adders+"::"+rsn.getString("block_id")+"<BR>");
	line_cost=""+(new Double(line_cost).doubleValue()+adders);
	BigDecimal d1 = new BigDecimal(line_cost);
	BigDecimal d2 = new BigDecimal(sumX);//total configured price
	BigDecimal d3_o = new BigDecimal(overageX);
	BigDecimal d5=d3_o.multiply(d1);
	BigDecimal d6=d5.divide(d2,BigDecimal.ROUND_HALF_UP);
	totprice=totprice+new Double(line_cost).doubleValue();
	//+d6.doubleValue();
		//BigDecimal d1 = new BigDecimal(line_cost);
		//BigDecimal d2 = new BigDecimal(tot_sum1);//total configured price
		//BigDecimal d3_o = new BigDecimal(""+overageX);
		//BigDecimal d3 = d1.divide(d2,BigDecimal.ROUND_HALF_UP);
		//BigDecimal d4 = d3.multiply(d3_o);
		//d4 = d4.setScale(0, BigDecimal.ROUND_HALF_UP);
		line_price=(new Double(line_cost)).doubleValue()+d6.doubleValue();
		//totprice=totprice+(new Double(line_cost)).doubleValue()+d4.doubleValue()+adders;
		String qty2=rsn.getString("Qty");
		out.println("<tr>");
		if(type.equals("1") || type.equals("2")||type.equals("4")||type.equals("6")||type.equals("5")){
			out.println("<td valign='top'  "+bodyString+">"+rsn.getString("Descript")+"</td>");
		}
		else{
			out.println("<td valign='top'  "+bodyString+" colspan='5'>"+rsn.getString("Descript")+"</td>");
		}
		if(type.equals("4")){
			out.println("<td valign='center' "+bodyString+" >"+qty2+"</td>");
			out.println("<td valign='center' "+bodyString+" align='right'>"+rsn.getString("uom")+"&nbsp;"+"</td>");
		}
		if(type.equals("1")||type.equals("6")){
			out.println("<td valign='center' nowrap width='5%' "+bodyString+" colspan='2'>"+qty2+"</td>");
			out.println("<td valign='center' nowrap width='5%' "+bodyString+" align='right' colspan='2'>"+rsn.getString("uom")+"&nbsp;"+"</td>");
		}
		if(type.equals("2")||type.equals("5")){
			out.println("<td valign='center' nowrap width='5%' "+bodyString+">"+qty2+"</td>");
			out.println("<td valign='center' nowrap width='5%' "+bodyString+" align='right'>"+rsn.getString("uom")+"&nbsp;"+"</td>");
				out.println("<td valign='center' nowrap width='5%' "+bodyString+" align='right'>"+for1.format(line_price/(new Double(qty2)).doubleValue())+"&nbsp;"+"</td>");
			out.println("<td valign='center' nowrap width='5%' "+bodyString+"  align='right'>"+for1.format(line_price)+"&nbsp;"+"</td>");
		}
		out.println("</tr>");
		bcount++;
		adders=0;
	}
	//adders=0;
}
totprice=totprice+overageX;
totprice=totprice+freightX;
totprice=totprice+handlingX;
if((type.equals("2")||type.equals("5"))){
					String colspan="1";
					if(type.equals("1")||type.equals("6")){
						colspan="2";
		}
	if( handlingX>0 ){
		out.println("<tr>");
		out.println("<td valign='top'  "+bodyString+">"+"Small Order Handling Charge."+"</td>");
		out.println("<td valign='center' nowrap width='5%' "+bodyString+" align='left' colspan='"+colspan+"'>"+"1"+"</td>");
			out.println("<td valign='center' nowrap width='5%' "+bodyString+" align='right' colspan='"+colspan+"'>"+"EA"+"</td>");
		if(type.equals("2")||type.equals("5")){
		out.println("<td valign='center' nowrap width='5%' "+bodyString+" align='right'>"+""+for1.format(handlingX)+"&nbsp;"+"</td>");
		out.println("<td valign='center' nowrap width='5%' "+bodyString+" align='right' colspan='"+colspan+"'>"+""+for1.format(handlingX)+"&nbsp;"+"</td>");
		}
		out.println("</tr>");
	}
	if( freightX>0 ){
		out.println("<tr>");
		out.println("<td valign='top'  "+bodyString+">"+"Special Freight Charge."+"</td>");
		out.println("<td valign='center' nowrap width='5%' "+bodyString+" align='left' colspan='"+colspan+"'>"+"1"+"</td>");
		out.println("<td valign='center' nowrap width='5%' "+bodyString+" align='right' colspan='"+colspan+"'>"+"EA"+"</td>");
		if(type.equals("2")||type.equals("5")){
		out.println("<td valign='center' nowrap width='5%' "+bodyString+" align='right'>"+""+for1.format(freightX)+"&nbsp;"+"</td>");
		out.println("<td valign='center' nowrap width='5%' "+bodyString+" align='right' colspan='"+colspan+"'>"+""+for1.format(freightX)+"&nbsp;"+"</td>");
		}
		out.println("</tr>");
	}
	}


%>




</table>

<table>
	<%


	if( !(section_qual==null||section_qual.trim().equals("")||sect_qual.elementAt(ye).toString().trim().equals("")) ){
		//out.println("<tr><td class='mainbodyh' colspan='3' ><b>QUALIFYING NOTES:</b>Section "+(String)sect_group.elementAt(ye).toString()+"</td></tr>");
		out.println("<tr><td class='mainbodyh' colspan='5' ><b>QUALIFYING NOTES:</b></td></tr>");
		if (qual_count>0){qual_sect=sect_qual.elementAt(ye).toString();}
		else{qual_sect=sect_qual.elementAt(ye).toString();}//			out.println("test"+qualifying_notes);
	}

	else if((qual_sect != null && qual_sect.trim().length()>0)||(qualifying_notes_free_text != null && qualifying_notes_free_text.trim().length()>0) || (free_text != null && free_text.trim().length()>0)){
	}
	//t.println("<tr><td>"+qual_sect+"</td></tr>");

	//all in qualifying notes
	if(qual_sect!=null&&qual_sect.trim().length()>0){
		ResultSet cs_exc_notes1 = stmt.executeQuery("select description FROM cs_qlf_notes where product_id='"+product+"' and code in ("+qual_sect+") order by code ");
		if (cs_exc_notes1 !=null) {
		while (cs_exc_notes1.next()) {
				out.println("<tr><td class='mainbodyh' colspan='3'>"+cs_exc_notes1.getString("description")+"</td></tr>");
			}
		}
		cs_exc_notes1.close();
	}
	//out.println(excl_sec);

String exec_sect="";
if( !(section_exc==null||section_exc.trim().equals("")||sect_exec.elementAt(ye).toString().trim().equals("")) ){
if (exc_count>0){exec_sect=exclusions+","+sect_exec.elementAt(ye);}
else{exec_sect=sect_exec.elementAt(ye).toString();}
//out.println("<tr><td class='mainbodyh' colspan='6' ><b>EXCLUSIONS/NOTES:</b></td></tr>");
}
else if ( ((exclusions_free_text.trim()).length()>0)|(exc_count>0)){
//out.println("<tr><td class='mainbodyh' colspan='6' ><b>EXCLUSIONS/NOTES:</b></td></tr>");
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

	if(section_notes!=null &&section_notes.trim().length()>0 && ! (section_notes.equals("null"))){
		out.println("<tr height='20'>");
		out.println("<td class='mainbodyh' colspan='5' align='left'>");out.println(sect_notes.elementAt(ye));	out.println("</td>");
		out.println("</tr>");//free notes end
	}

		for1.setMaximumFractionDigits(0);
for1.setMinimumFractionDigits(0);
		price=for1.format(totprice);
		grand_total=totprice;
		//out.println(" herex <BR>");
	overage=""+overageX;
	freight_cost=""+freightX;
	handling_cost=""+handlingX;
	if(section_page==null||section_page.equals("1")){
		totprice=totprice-overageX;
		price=for1.format(totprice);
		if(group_id.startsWith("Decolink")){for1.setMinimumFractionDigits(2);}else{for1.setMaximumFractionDigits(0);}
		//out.println("HERE");
	%>
	<%@ include file="quote_template_foot_sfdc.jsp"%>
	<%@ include file="quote_template_footer_sfdc.jsp"%>
	<%
	if(sect_group.size()-ye>1){out.println("<p style='page-break-after : always;' >&nbsp;</p>");}
	for1.setMaximumFractionDigits(2);
}

else{

	%>
</table>
<!-- <table class='<%= border_color %>' cellspacing='0' cellpadding='0' border='0' width='95%' height='25'><tr>-->
<%

DecimalFormat df0 = new DecimalFormat("####");
double temphandling_cost=new Double(handling_cost).doubleValue();
//if(sections>1){
//	temphandling_cost=handlingX;
//}
String inittotal=df0.format(grand_total-temphandling_cost)  ;
%>
<!-- </table>-->
<table class='<%= border_color %>' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only </b></td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%=for1.format(new Double(inittotal).doubleValue())  %></font></b></td>
	</tr>
	<%
	if(temphandling_cost>0){
	%>
	<tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b>Freight Surcharge</b></td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'><%=for1.format(temphandling_cost)%></font></b></td>
	</tr>
	<tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'>&nbsp;</td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%=for1.format(grand_total) %></font></b></td>
	</tr>
	<%
}
out.println("</table>");








/*
		if (!(tax_perc==null||tax_perc.equals("0"))){
	%>
	<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only:(Tax not included)</b></td>
	<%
				}
else{
	%>
	<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only</b></td>
	<%
}

	%>
	<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= price %></font></b></td>
</tr>

<%
*/
if(tax_perc==null || tax_perc.equals("null")){
	tax_perc="0";
}
double tax_dollar=0;
tax_dollar=(grand_total*Double.parseDouble(tax_perc))/100;
grand_total=grand_total+tax_dollar;
for1.setMaximumFractionDigits(0);
if (!(tax_perc==null||tax_perc.equals("0"))){
	out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='95%' height='25'><tr>");
	out.println("<tr>");
	out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Tax Only</b></td>");
	out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(tax_dollar)+"</font></b></td>");
	out.println("</tr>");
	out.println("</table>");
	out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='95%' height='25'><tr>");
	out.println("<tr>");
	out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material and Tax Only </b></td>");
	out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(grand_total)+"</font></b></td>");
	out.println("</tr></table>");
}
//out.println("</table>");
out.println("<BR><BR><BR>");
for1.setMaximumFractionDigits(2);
for1.setMinimumFractionDigits(2);

}
totprice=0;qual_sect="";
overage=""+tempOverage;
freight_cost=""+tempFreight_cost;
handling_cost=""+tempHandling_cost;
}

}


%>






