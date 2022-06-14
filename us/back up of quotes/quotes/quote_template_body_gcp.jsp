<%

if(sect_name.size()>0){
	for(int g=0; g< sect_name.size(); g++){
		/*
		out.println(overageSec.elementAt(g).toString()+"::<BR>");
		out.println(handlingSec.elementAt(g).toString()+"::<BR>");
		out.println(freightSec.elementAt(g).toString()+"::<BR>");
		*/
		out.println("<table width='100%' cellspacing='0' cellpadding='0' border='0'>");
		out.println("</font><tr><td class='tableline_row mainbody'><b><font class='tableline_row mainbody'>"+sect_value.elementAt(g).toString()+"</font></b></td></tr></table>");
		%>
		<table width='100%' class='table_thin_borders' cellspacing='0' cellpadding='0' border='1'>
			<tr height='20'>
				<td bgcolor='#FFFFFF' class='maindesc'><b><u>Item Description</u></b></td>
				<td width='5%' bgcolor='#FFFFFF' class='maindesc'><b><u>Qty</u></b></td>
				<td width='5%' bgcolor='#FFFFFF' class='maindesc'><b><u>Units</u></b></td>
			</tr>
		<%
		int k=0;String bgcolor="";
		Vector mark=new Vector();
		Vector desc=new Vector();
		Vector qty=new Vector();
		Vector rec_no=new Vector();
		Vector line_no=new Vector();
		String color="NONE";
		String fob="";
		Vector sale_price=new Vector();
		Vector block_id=new Vector();
		Vector uom=new Vector();

		ResultSet rs_csquotes = stmt.executeQuery("SELECT cast(line_no as numeric) as a4, sequence_no, cast(CSQUOTES.descript as varchar(700)) as a1,CAST (QTY AS Integer),UOM FROM CSQUOTES where order_no = '"+order_no+"' and line_no in ("+sect_group_lines.elementAt(g).toString()+") and block_id != 'a_aproduct' GROUP BY cast(line_no as numeric), cast(CSQUOTES.descript as varchar(700)), sequence_no,CAST (QTY AS Integer),UOM");
		if (rs_csquotes !=null) {
			while (rs_csquotes.next()) {
				line_no.addElement(rs_csquotes.getString("a4"));
				desc.addElement(rs_csquotes.getString("a1"));
				qty.addElement(rs_csquotes.getString(4));
				//rec_no.addElement(rs_csquotes.getString("Record_no"));
				//sale_price.addElement(rs_csquotes.getString("Extended_Price"));
				//block_id.addElement(rs_csquotes.getString("Block_ID"));
				uom.addElement(rs_csquotes.getString("UoM"));
				//qty.addElement(rs_csquotes.getString("Qty"));
				//mark.addElement(rs_csquotes.getString("field17"));
				//out.println(qty.elementAt(k)+"::<BR>");
				k++;
			}
		}
		rs_csquotes.close();

		double tot1=0;
		ResultSet rs_csquotes1 = stmt.executeQuery("SELECT extended_price FROM CSQUOTES where order_no = '"+order_no+"' and line_no in ("+sect_group_lines.elementAt(g).toString()+") ");
		if (rs_csquotes1 !=null) {
			while (rs_csquotes1.next()) {
				tot1=tot1+new Double(rs_csquotes1.getString(1)).doubleValue();
			}
		}
		rs_csquotes1.close();
		//out.println(tot1+" section cost?<BR>");


		double tot2=0;
		ResultSet rs_csquotesSum=stmt.executeQuery("select extended_price from csquotes where order_no='"+order_no+"'");
		if(rs_csquotesSum != null){
			while(rs_csquotesSum.next()){
				//out.println(rs_csquotesSum.getString(1)+"::<BR>");
				tot2=tot2+new Double(rs_csquotesSum.getString(1)).doubleValue();
			}
		}
		rs_csquotesSum.close();

		// out.println("Tot1="+tot1+", Tot2="+tot2+", Freight="+freight_cost+", Configured_price="+configured_price);
		tot2=tot1/tot2;

		int bcount=0;
		for (int n=0;n<k;n++){
//			if ((bcount%2)==1){bgcolor="#EFEFDE";}else {bgcolor="#e4e4e4";	}
			if ((bcount%2)==1){bgcolor="#FFFFFF";}else {bgcolor="#FFFFFF";	}
			out.println("<tr>");
				out.println("<td valign='top'  bgcolor='"+bgcolor+"' class='maindesc'>"+desc.elementAt(n).toString()+"</td>");
				out.println("<td valign='top' ALIGN='RIGHT' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+qty.elementAt(n).toString()+"</td>");
				out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+uom.elementAt(n).toString()+"</td>");
				//out.println("<td valign='top' nowrap width='9%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+sale_price.elementAt(n).toString()+"</td>");
			out.println("</tr>");
			bcount++;
		}
		String outputPrice="";

		if(product.equals("GCP")){

			String temp_configured_price=configured_price;
			//out.println("<table BORDER ='1' WIDTH='50%'><Tr><td>PRICE</td><td>freight</td><td>FGM</td><td>FCOMM</td><TD>&nbsp;</TD></tr>");
			if(isOverage){
				temp_configured_price=""+(new Double(temp_configured_price).doubleValue()-new Double(overage).doubleValue());
			}
			if(isHandling){
				temp_configured_price=""+(new Double(temp_configured_price).doubleValue()-new Double(handling_cost).doubleValue());
			}

			if(isFreight){
				double fcomm=(new Double(freight_cost).doubleValue()*0.91*(new Double(commission).doubleValue()/100))/(1-(new Double(gross_margin).doubleValue()/100)-0.91*(new Double(commission).doubleValue()/100));
				double fgm=(new Double(freight_cost).doubleValue()/(1-(new Double(gross_margin).doubleValue()/100)-(new Double(commission).doubleValue()/100)*0.91))-fcomm;
				temp_configured_price=""+(new Double(temp_configured_price).doubleValue()-fgm-fcomm);
			}

			outputPrice=""+(new Double(temp_configured_price).doubleValue()*tot2);
			price=""+(new Double(temp_configured_price).doubleValue()*tot2);
			if(isOverage){
				outputPrice=""+(new Double(outputPrice).doubleValue()+new Double(overageSec.elementAt(g).toString()).doubleValue());
				price=""+(new Double(temp_configured_price).doubleValue()*tot2+new Double(overageSec.elementAt(g).toString()).doubleValue());
			}
			if(isHandling){
				outputPrice=""+(new Double(outputPrice).doubleValue()+new Double(handlingSec.elementAt(g).toString()).doubleValue());
				price=""+(new Double(temp_configured_price).doubleValue()*tot2+new Double(handlingSec.elementAt(g).toString()).doubleValue());
			}

			if(isFreight){

				double fcomm=(new Double(freightSec.elementAt(g).toString()).doubleValue()*0.91*(new Double(commission).doubleValue()/100))/(1-(new Double(gross_margin).doubleValue()/100)-0.91*(new Double(commission).doubleValue()/100));

				double fgm=(new Double(freightSec.elementAt(g).toString()).doubleValue()/(1-(new Double(gross_margin).doubleValue()/100)-(new Double(commission).doubleValue()/100)*0.91))-fcomm;

				//outputPrice=""+(new Double(outputPrice).doubleValue()+new Double(freightSec.elementAt(g).toString()).doubleValue()+fgm+fcomm);
				outputPrice=""+(new Double(outputPrice).doubleValue()+fgm+fcomm);
				//out.println("<tr><td>"+outputPrice+"</td><td>"+freightSec.elementAt(g).toString()+"</td><td>"+fgm+"</td><td>"+fcomm+"</TD><TD>SECTION</td></tr></table>");
				price=""+(new Double(temp_configured_price).doubleValue()*tot2+new Double(freightSec.elementAt(g).toString()).doubleValue());

			}
			outputPrice=for0.format(new Double(outputPrice).doubleValue());
			DecimalFormat df0efs = new DecimalFormat("####");
		price=df0efs.format(new Double(price).doubleValue());
			//price=for1.format(new Double(price).doubleValue());
			fob = ", FOB Plant, Excluding Tax";
			//out.println(tot1+"::"+price+"::HERE");

		}

		%>
		</table>
		<table class='<%= border_color %>' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'>
		<tr>
<%
	if(isInstall != null && isInstall.equals("Y")){
	%>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished, FOB Plant, Installation included, Excluding Tax</b></td>
	<%
	}
	else{
	%>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only, FOB Plant, Excluding Tax</b></td>
	<%
	}
	%>
			<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>
			<%
				out.println(outputPrice);

			%></font></b>
			</td>
		</tr>
		<%
		double tax_dollar=0;
		//out.println(configured_price+"::HERE1");
		tax_dollar=(new Double(configured_price).doubleValue()*Double.parseDouble(tax_perc))/100;
		grand_total=new Double(configured_price).doubleValue()+tax_dollar;
		//out.println("before tax"+tax_perc);
		if (!(tax_perc==null||tax_perc.equals("0"))){
			out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'>");
			out.println("<tr>");
				out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Tax Only</b></td>");
				out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(tax_dollar)+"</font></b></td>");
			out.println("</tr>");
			out.println("</table>");
			out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'>");
			out.println("<tr>");
				out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material and Tax Only </b></td>");
				out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(grand_total)+"</font></b></td>");
			out.println("</tr>");
			out.println("</table>");
		}
		//out.println("after tax");
		%>
		</table>
		<br>
		<%
		out.println("<table cellspacing='0' align='center' cellpadding='1' border='0' width='100%'>");
		if (sect_qual.elementAt(g).toString().trim().length()>0){
			out.println("<tr><td class='mainbodyh'><b>QUALIFYING NOTES:</b></td></tr>");
			ResultSet cs_exc_notes = stmt.executeQuery("select description FROM cs_qlf_notes where product_id='GCP' and code in ("+sect_qual.elementAt(g).toString().trim()+") order by code ");
	  		if (cs_exc_notes !=null) {
	        		while (cs_exc_notes.next()) {
					out.println("<tr><td class='mainbodyh'>"+cs_exc_notes.getString("description")+" </td></tr>");
				}
			}
			cs_exc_notes.close();
		}
		if (sect_exec.elementAt(g).toString().trim().length()>0){
			out.println("<tr><td class='mainbodyh'><BR><b>EXCLUSION NOTES:</b></td></tr>");
			ResultSet cs_qlf_notes = stmt.executeQuery("select description FROM cs_exc_notes where product_id='GCP' and code in ("+sect_exec.elementAt(g).toString()+") order by code ");
			if (cs_qlf_notes !=null) {
				while (cs_qlf_notes.next()) {
					out.println("<tr><td class='mainbodyh'>"+cs_qlf_notes.getString("description")+"</td></tr>");
				}
			}
			cs_qlf_notes.close();
		}


		if(sect_notes.elementAt(g).toString().trim().length()>0){
			out.println("<tr><td class='mainbodyh'>"+sect_notes.elementAt(g).toString()+"</td></tr>");
		}
		out.println("<tr><td class='mainbodyh'>&nbsp;</td></tr></table>");
	}
}
else{
	%>
	<table width='100%' class='table_thin_borders' cellspacing='0' cellpadding='0' border='1'>
			<tr height='20'>
				<td bgcolor='#FFFFFF' class='maindesc'><b><u>Item Description</u></b></td>
				<td width='5%' bgcolor='#FFFFFF' class='maindesc'><b><u>Qty</u></b></td>
				<td width='5%' bgcolor='#FFFFFF' class='maindesc'><b><u>Units</u></b></td>
			</tr>
	<%
	int k=0;String bgcolor="";
	Vector mark=new Vector();
	Vector desc=new Vector();
	Vector qty=new Vector();
	Vector rec_no=new Vector();
	Vector line_no=new Vector();
	String color="NONE";
	String fob="";
	Vector sale_price=new Vector();
	Vector block_id=new Vector();
	Vector uom=new Vector();

	ResultSet rs_csquotes = stmt.executeQuery("SELECT cast(line_no as numeric) as a4, sequence_no, cast(CSQUOTES.descript as varchar(700)) as a1,CAST (QTY AS Integer),UOM FROM CSQUOTES where order_no = '"+order_no+"' and block_id != 'a_aproduct' GROUP BY cast(line_no as numeric), cast(CSQUOTES.descript as varchar(700)),sequence_no,CAST (QTY AS Integer),UOM");
	if (rs_csquotes !=null) {
		while (rs_csquotes.next()) {
			line_no.addElement(rs_csquotes.getString("a4"));
			desc.addElement(rs_csquotes.getString("a1"));
			qty.addElement(rs_csquotes.getString(4));
			uom.addElement(rs_csquotes.getString("UoM"));
			k++;
		}
	}
	rs_csquotes.close();
	int bcount=0;
	for (int n=0;n<k;n++){
		if ((bcount%2)==1){bgcolor="#FFFFFF";}else {bgcolor="#F1F1F1";	}
		out.println("<tr>");
		out.println("<td valign='top'  bgcolor='"+bgcolor+"' class='maindesc'>"+desc.elementAt(n).toString()+"</td>");
		out.println("<td valign='top' ALIGN='RIGHT' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+qty.elementAt(n).toString()+"</td>");
		out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+uom.elementAt(n).toString()+"</td>");
		out.println("</tr>");
		bcount++;
	}
	if(product.equals("GCP")){
		//out.println(price+"::HERE");
	DecimalFormat df0efs = new DecimalFormat("####");
		price=df0efs.format(new Double(configured_price).doubleValue());
		fob = ", FOB Plant, Excluding Tax";
		//out.println(price+"::HERE");
	}
	%>
	</table>
	<BR>


<%
}
//out.println(price);
%>