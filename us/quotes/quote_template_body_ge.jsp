
<%
{

int k=0;String bgcolor="";Vector mark=new Vector();Vector desc=new Vector();Vector qty=new Vector();Vector rec_no=new Vector();
Vector line_no=new Vector();Vector extended_price=new Vector();Vector uom=new Vector();Vector field19=new Vector();Vector blockId=new Vector();
double unit_price=0;

	ResultSet rs_csquotes = stmt.executeQuery("select * from csquotes where order_no='"+order_no+"' and not block_id in ('A_APRODUCT','e_dim1','e_dim2','e_dim') and product_id='"+product+"' order by cast(Line_no as integer), sequence_no");
		if (rs_csquotes !=null) {
        while (rs_csquotes.next()) {
		line_no.addElement(rs_csquotes.getString("Line_no"));
		desc.addElement(rs_csquotes.getString("Descript"));
		rec_no.addElement(rs_csquotes.getString("Record_no"));
		qty.addElement(rs_csquotes.getString("Qty"));
		mark.addElement(rs_csquotes.getString("field17"));
		extended_price.addElement(rs_csquotes.getString("Extended_Price"));
		//out.println(rs_csquotes.getString("line_no")+"::"+rs_csquotes.getString("block_id")+"::"+rs_csquotes.getString("extended_price")+"::<BR>");
		uom.addElement(rs_csquotes.getString("UOM"));
		field19.addElement(rs_csquotes.getString("field19"));
		blockId.addElement(rs_csquotes.getString("block_id"));
		k++;
									}
								}
								rs_csquotes.close();

int bcount=0; double tot_price1=0;
//out.println(k);
	if(k>0){
//out.println(type);
			out.println("<table width='100%' class='table_thin_borders' cellspacing='0' cellpadding='0' border='1'>");
			out.println("<tr height='20'>");
			out.println("<td width='5%' bgcolor='grey' class='schedule'><b><u>Qty</u></b></td>");
			out.println("<td  bgcolor='grey' class='schedule'><b><u>Description</u></b></td>");
			out.println("<td width='5%' bgcolor='grey' class='schedule'><b><u>U/M</u></b></td>");
			if(type.equals("2")){
			out.println("<td width='7%' bgcolor='grey' class='schedule'><b><u>Unit Price</u></b></td>");
			out.println("<td width='7%' bgcolor='grey' class='schedule'><b><u>Total</u></b></td>");
			}
			out.println("</tr>");

		for (int n=0;n<k;n++){
				//out.println("a");

				//out.println("<tr height='20'>");
				//out.println("<td width='7%' bgcolor='#006600' class='schedule'><b><u>"+price1+"</u></b></td>");
				//out.println("<td width='5%' bgcolor='#006600' class='schedule'><b><u>Yasodddda</u></b></td>");
				//out.println("</tr>");


				if ((bcount%2)==1){bgcolor="#EFEFDE";}else {bgcolor="#e4e4e4";	}
				String qty_final=qty.elementAt(n).toString();
				if(qty_final.trim().length()<=0){qty_final="1";}else{qty_final=qty_final.trim();}
				String factor_final="1";//field19.elementAt(n).toString();
				if(factor_final.trim().length()<=0){factor_final="1";}else{factor_final=factor_final.trim();}
				//out.println("1");
			  BigDecimal d1 = new BigDecimal(extended_price.elementAt(n).toString());
			 BigDecimal d21 = new BigDecimal(qty_final);
			 BigDecimal d4 = new BigDecimal(factor_final);
			 BigDecimal d2 = new BigDecimal(price1);//total quote price
			  BigDecimal d3_o = new BigDecimal(overage);
			  BigDecimal d3 = d1.divide(d2,BigDecimal.ROUND_HALF_UP);
			  //BigDecimal d41 = d3.multiply(d3_o);
			  BigDecimal d41 = d3_o.divide(new BigDecimal(k),BigDecimal.ROUND_HALF_UP);
			  //d41 = d41.setScale(0, BigDecimal.ROUND_HALF_UP);
			  tot_price1=(new Double(extended_price.elementAt(n).toString())).doubleValue()+d41.doubleValue();
			  unit_price=tot_price1/d21.doubleValue();

				out.println("<tr>");
if(blockId.elementAt(n).toString().equals("D_NOTES")){
				out.println("<td valign='top' align='right' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>&nbsp;</td>");
}
else{
				out.println("<td valign='top' align='right' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+qty_final+"</td>");
}
if(blockId.elementAt(n).toString().equals("D_NOTES")){

				if(type.equals("2")){
								out.println("<td colspan='4' valign='top'  bgcolor='"+bgcolor+"' class='maindesc'>"+desc.elementAt(n).toString()+"</td>");
}
else{
				out.println("<td colspan='2' valign='top'  bgcolor='"+bgcolor+"' class='maindesc'>"+desc.elementAt(n).toString()+"</td>");

}
}
else{
out.println("<td valign='top'  bgcolor='"+bgcolor+"' class='maindesc'>"+desc.elementAt(n).toString()+"</td>");
				out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+uom.elementAt(n).toString()+"</td>");
				if(type.equals("2")){
				out.println("<td valign='top' align='right' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(unit_price*d4.doubleValue())+"</td>");
				out.println("<td valign='top' align='right' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(tot_price1*d4.doubleValue())+"</td>");
				}
}
				out.println("</tr>");
				bcount++;

		}
	}
}
//	out.println("<tr ><td valign='top' colspan='3' class='mainbodyh'>&nbsp;test</td></tr>");
%>
</table>
<br>