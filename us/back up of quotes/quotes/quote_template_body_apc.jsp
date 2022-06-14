<%
if(sect_name.size()>0){
	for(int g=0; g< sect_name.size(); g++){
		/*
		out.println(sect_name.elementAt(g).toString()+"::<BR>");
		out.println(sect_value.elementAt(g).toString()+"::<BR>");
		out.println(sect_qual.elementAt(g).toString()+"::<BR>");
		out.println(sect_exec.elementAt(g).toString()+"::<BR>");
		out.println(sect_group.elementAt(g).toString()+"::<BR>");
		out.println(sect_group_lines.elementAt(g).toString()+"::<BR>");
		out.println(sect_notes.elementAt(g).toString()+"::<BR>");
		out.println("<BR><BR><BR>");
		*/
		
		out.println("<table width='100%' cellspacing='1' cellpadding='2' border='0'>");
		out.println("<tr height='20'><td colspan='5'><B>"+sect_value.elementAt(g).toString()+"</b></td></tr>");
		out.println("<tr height='20'>");
		
		out.println("<td  bgcolor='#006600' class='schedule'><b><u>Product</u></b></td>");
		out.println("<td width='5%' bgcolor='#006600' class='schedule'><b><u>Qty</u></b></td>");
		out.println("<td width='9%' bgcolor='#006600' class='schedule'><b><u>Opening</u></b></td>");
		out.println("<td width='9%' bgcolor='#006600' class='schedule'><b><u>Unit Price</u></b></td>");
		out.println("<td width='9%' bgcolor='#006600' class='schedule'><b><u>Line Total</u></b></td>");
		out.println("</tr>");
		int k=0;String bgcolor="";Vector mark=new Vector();Vector desc=new Vector();Vector qty=new Vector();Vector rec_no=new Vector();
		Vector line_no=new Vector();String color="NONE";
		Vector block_id=new Vector();
		Vector price_csquotes=new Vector();
		Vector um=new Vector();
		Vector size=new Vector();
		ResultSet rscsquotes = stmt.executeQuery("select * from csquotes where order_no='"+order_no+"' and block_id = 'b_descript' and line_no in ("+sect_group_lines.elementAt(g).toString()+") order by cast(Line_no as integer),Extended_Price ");
		if (rscsquotes !=null) {
			while (rscsquotes.next()) {
				block_id.addElement(rscsquotes.getString("block_id"));
				line_no.addElement(rscsquotes.getString("Line_no"));
				desc.addElement(rscsquotes.getString("Descript")); 
				price_csquotes.addElement(rscsquotes.getString ("Extended_Price"));
				rec_no.addElement(rscsquotes.getString("Record_no"));
				qty.addElement(rscsquotes.getString("Qty"));
				if(rscsquotes.getString("field17") != null){
					mark.addElement(rscsquotes.getString("field17"));
				}
				else{
					mark.addElement("");
				}		
				if(rscsquotes.getString("uom") != null){
					um.addElement(rscsquotes.getString("uom"));
				}
				else{
					um.addElement("");
				}
				size.addElement(rscsquotes.getString("SQM"));
				k++;
			}
		}
		rscsquotes.close();
		double tot_sum=0;
		Vector line2 = new Vector();
		Vector price2 = new Vector();
		ResultSet rs_csquotes_sum = stmt.executeQuery("SELECT line_no, sum(cast(extended_price as decimal)) FROM CSQUOTES where order_no='"+order_no+"' and not block_id='a_aproduct' and line_no in ("+sect_group_lines.elementAt(g).toString()+") group by line_no order by cast(Line_no as integer)");
		if (rs_csquotes_sum !=null) {
			while (rs_csquotes_sum.next()) {
				 tot_sum=tot_sum+new Double(rs_csquotes_sum.getString(2)).doubleValue();
				// out.println(rs_csquotes_sum.getString(2)+"::<BR>");
				 line2.addElement(rs_csquotes_sum.getString(1));
				 price2.addElement(rs_csquotes_sum.getString(2));
			}
		}
		//out.println(tot_sum+"::HERE<BR>");
		rs_csquotes_sum.close();
		int bcount=0;
		double totprice=0;
		String line_cost="";

		for (int n=0;n<k;n++){
			for(int i=0; i<line2.size(); i++){
				if(line2.elementAt(i).toString().equals(line_no.elementAt(n).toString())){
					totprice=totprice+new Double(price2.elementAt(i).toString()).doubleValue();
				}

			}

			if ((bcount%2)==1){bgcolor="#EFEFDE";}else {bgcolor="#e4e4e4";	}
			if (((desc.elementAt(n).toString()).trim().startsWith("Gasket"))){
				color=(desc.elementAt(n).toString()).substring(((desc.elementAt(n).toString()).indexOf("Gasket Color - "))+15);
			}
			else{		
				line_cost=price_csquotes.elementAt(n).toString();
				BigDecimal d1 = new BigDecimal(line_cost);
				BigDecimal d2 = new BigDecimal(tot_sum);//total configured price
				BigDecimal d3_o = new BigDecimal(overage);
				BigDecimal d3 = d1.divide(d2,BigDecimal.ROUND_HALF_UP);
				BigDecimal d4 = d3.multiply(d3_o);
				d4 = d4.setScale(0, BigDecimal.ROUND_HALF_UP);
				//totprice=(new Double(line_cost)).doubleValue()+d4.doubleValue();
				String qty2=qty.elementAt(n).toString();
				String opening=size.elementAt(n).toString();
				out.println("<tr>");
				
				out.println("<td valign='top'  bgcolor='"+bgcolor+"' class='maindesc'>"+desc.elementAt(n).toString()+"</td>");
				out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+qty.elementAt(n).toString()+"</td>");
				out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+opening+"</td>");
				out.println("<td valign='top' nowrap width='7%' align='right' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(totprice/(new Double(qty2)).doubleValue())+"</td>");
				out.println("<td valign='top' nowrap width='7%' align='right' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(totprice)+"</td>");
				out.println("</tr>"); 
				bcount++;
			}
			totprice=0;
		}
		if(overageSec.elementAt(g).toString() != null && overageSec.elementAt(g).toString().trim().length()>0 && new Double(overageSec.elementAt(g).toString()).doubleValue()>0){
			out.println("<tr>");
			
			out.println("<td valign='top'  bgcolor='"+bgcolor+"' class='maindesc'>Overage</td>"); 
			out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>1</td>");
			out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>&nbsp;</td>");
			out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' align='right' class='maindesc'>"+for1.format(new Double(overageSec.elementAt(g).toString()).doubleValue())+"</td>");
			out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' align='right' class='maindesc'>"+for1.format(new Double(overageSec.elementAt(g).toString()).doubleValue())+"</td>");
			out.println("</tr>");
			tot_sum=tot_sum+new Double(overageSec.elementAt(g).toString()).doubleValue();
		}
		if(handlingSec.elementAt(g).toString() != null && handlingSec.elementAt(g).toString().trim().length()>0 && new Double(handlingSec.elementAt(g).toString()).doubleValue()>0){
			out.println("<tr>");
			//out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>1</td>");
			out.println("<td valign='top'  bgcolor='"+bgcolor+"' class='maindesc'>Handling</td>"); 
			out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>1</td>");
			out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>&nbsp;</td>");
			out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' align='right' class='maindesc'>"+for1.format(new Double(handlingSec.elementAt(g).toString()).doubleValue())+"</td>");
			out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' align='right' class='maindesc'>"+for1.format(new Double(handlingSec.elementAt(g).toString()).doubleValue())+"</td>");
			out.println("</tr>");
			tot_sum=tot_sum+new Double(handlingSec.elementAt(g).toString()).doubleValue();
		}
		if(freightSec.elementAt(g).toString() != null && freightSec.elementAt(g).toString().trim().length()>0 && new Double(freightSec.elementAt(g).toString()).doubleValue()>0){
			out.println("<tr>");
			//out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>1</td>");
			out.println("<td valign='top'  bgcolor='"+bgcolor+"' class='maindesc'>Freight</td>"); 
			out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>1</td>");
			out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>&nbsp;</td>");
			out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' align='right' class='maindesc'>"+for1.format(new Double(freightSec.elementAt(g).toString()).doubleValue())+"</td>");
			out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' align='right' class='maindesc'>"+for1.format(new Double(freightSec.elementAt(g).toString()).doubleValue())+"</td>");
			out.println("</tr>");
			tot_sum=tot_sum+new Double(freightSec.elementAt(g).toString()).doubleValue();
		}
		if(setupSec.elementAt(g).toString() != null && setupSec.elementAt(g).toString().trim().length()>0 && new Double(setupSec.elementAt(g).toString()).doubleValue()>0){
			out.println("<tr>");
			//out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>1</td>");
			out.println("<td valign='top'  bgcolor='"+bgcolor+"' class='maindesc'>Setup</td>"); 
			out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>1</td>");
			out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>&nbsp;</td>");
			out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' align='right' class='maindesc'>"+for1.format(new Double(setupSec.elementAt(g).toString()).doubleValue())+"</td>");
			out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' align='right' class='maindesc'>"+for1.format(new Double(setupSec.elementAt(g).toString()).doubleValue())+"</td>");
			out.println("</tr>");
			tot_sum=tot_sum+new Double(setupSec.elementAt(g).toString()).doubleValue();
		}		
		price=""+tot_sum;
		/*
		out.println(overageSec.elementAt(g).toString()+"::<BR>");
		out.println(handlingSec.elementAt(g).toString()+"::<BR>");
		out.println(freightSec.elementAt(g).toString()+"::<BR>");
		out.println(setupSec.elementAt(g).toString()+"::<BR>");
		*/ 
		%>

		</table>
		
		<table class='<%= border_color %>' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
			<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only</b></td>
			<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= for1.format(new Double(price).doubleValue()) %></font></b></td>
		</tr>		
		<%
	
		double tax_dollar=0; 
		//out.println(tax_perc+"<BR>");
		tax_dollar=(new Double(price).doubleValue()*Double.parseDouble(tax_perc))/100;
		grand_total=new Double(price).doubleValue()+tax_dollar;		
		if (!(tax_perc==null||tax_perc.equals("0"))){		
			out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
			out.println("<tr>");
			out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Tax Only</b></td>");
			out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(tax_dollar)+"</font></b></td>");
			out.println("</tr>");
			out.println("</table>");
			out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
			out.println("<tr>");
			out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material and Tax Only </b></td>");
			out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(grand_total)+"</font></b></td>");
			out.println("</tr>");
			out.println("</table>");
		}
		out.println("<BR>");
		grand_total=0;
		tot_sum=0;
		
		
	}

}
else{

	out.println("<table width='100%' cellspacing='1' cellpadding='2' border='0'>");
	out.println("<tr height='20'>");
	out.println("<td width='5%' bgcolor='#006600' class='schedule'><b><u>Qty</u></b></td>");
	out.println("<td  bgcolor='#006600' class='schedule'><b><u>Product</u></b></td>");
	out.println("<td width='9%' bgcolor='#006600' class='schedule'><b><u>Opening</u></b></td>");
	out.println("<td width='5%' bgcolor='#006600' class='schedule'><b><u>Unit Price</u></b></td>");
	out.println("<td width='9%' bgcolor='#006600' class='schedule'><b><u>Line Total</u></b></td>");
	out.println("</tr>");
	int k=0;String bgcolor="";Vector mark=new Vector();Vector desc=new Vector();Vector qty=new Vector();Vector rec_no=new Vector();
	Vector line_no=new Vector();String color="NONE";
	Vector block_id=new Vector();
	Vector price_csquotes=new Vector();
	Vector um=new Vector();
	Vector size=new Vector();
	ResultSet rscsquotes = stmt.executeQuery("select * from csquotes where order_no='"+order_no+"' and block_id = 'b_descript'order by cast(Line_no as integer),Extended_Price ");
	if (rscsquotes !=null) {
		while (rscsquotes.next()) {
			block_id.addElement(rscsquotes.getString("block_id"));
			line_no.addElement(rscsquotes.getString("Line_no"));
			desc.addElement(rscsquotes.getString("Descript")); 
			price_csquotes.addElement(rscsquotes.getString ("Extended_Price"));
			rec_no.addElement(rscsquotes.getString("Record_no"));
			qty.addElement(rscsquotes.getString("Qty"));
			if(rscsquotes.getString("field17") != null){
				mark.addElement(rscsquotes.getString("field17"));
			}
			else{
				mark.addElement("");
			}		
			if(rscsquotes.getString("uom") != null){
				um.addElement(rscsquotes.getString("uom"));
			}
			else{
				um.addElement("");
			}
			size.addElement(rscsquotes.getString("SQM"));
			k++;
		}
	}
	rscsquotes.close();
	double tot_sum=0;
	Vector line2 = new Vector();
	Vector price2 = new Vector();
	ResultSet rs_csquotes_sum = stmt.executeQuery("SELECT line_no, sum(cast(extended_price as decimal)) FROM CSQUOTES where order_no='"+order_no+"' and not block_id='a_aproduct' group by line_no order by cast(Line_no as integer)");
	if (rs_csquotes_sum !=null) {
		while (rs_csquotes_sum.next()) {
			 tot_sum=tot_sum+new Double(rs_csquotes_sum.getString(2)).doubleValue();
			 line2.addElement(rs_csquotes_sum.getString(1));
			 price2.addElement(rs_csquotes_sum.getString(2));
		}
	}
	rs_csquotes_sum.close();
	int bcount=0;
	double totprice=0;
	String line_cost="";

	for (int n=0;n<k;n++){
		for(int i=0; i<line2.size(); i++){
			if(line2.elementAt(i).toString().equals(line_no.elementAt(n).toString())){
				totprice=totprice+new Double(price2.elementAt(i).toString()).doubleValue();
			}

		}

		if ((bcount%2)==1){bgcolor="#EFEFDE";}else {bgcolor="#e4e4e4";	}
		if (((desc.elementAt(n).toString()).trim().startsWith("Gasket"))){
			color=(desc.elementAt(n).toString()).substring(((desc.elementAt(n).toString()).indexOf("Gasket Color - "))+15);
		}
		else{		
			line_cost=price_csquotes.elementAt(n).toString();
			BigDecimal d1 = new BigDecimal(line_cost);
			BigDecimal d2 = new BigDecimal(tot_sum);//total configured price
			BigDecimal d3_o = new BigDecimal(overage);
			BigDecimal d3 = d1.divide(d2,BigDecimal.ROUND_HALF_UP);
			BigDecimal d4 = d3.multiply(d3_o);
			d4 = d4.setScale(0, BigDecimal.ROUND_HALF_UP);
			//totprice=(new Double(line_cost)).doubleValue()+d4.doubleValue();
			String qty2=qty.elementAt(n).toString();
			String opening=size.elementAt(n).toString();
			out.println("<tr>");
			out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+qty.elementAt(n).toString()+"</td>");
			out.println("<td valign='top'  bgcolor='"+bgcolor+"' class='maindesc'>"+desc.elementAt(n).toString()+"</td>");
			out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+opening+"</td>");
			out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(totprice/(new Double(qty2)).doubleValue())+"</td>");
			out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(totprice)+"</td>");
			out.println("</tr>"); 
			bcount++;
		}
		totprice=0;
	}
	/*
	out.println("<tr>");
	out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>&nbsp;</td>"); 
	out.println("<td valign='top'  bgcolor='"+bgcolor+"' class='maindesc'>Freight</td>"); 
	out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>1</td>");
	out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>EA</td>");
	out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(new Double(freight_cost).doubleValue())+"</td>");
	out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(new Double(freight_cost).doubleValue())+"</td>");
	out.println("</tr>");
	*/
	%>

	</table>
	<%
}
%>