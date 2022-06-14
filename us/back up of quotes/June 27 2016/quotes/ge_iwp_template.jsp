
<%
String bgcolor="";

{
int k=0;Vector mark=new Vector();Vector desc=new Vector();Vector qty=new Vector();Vector rec_no=new Vector();
Vector line_no=new Vector();String color="NONE";Vector extended_price=new Vector();Vector uom=new Vector();double unit_price=0; String um="";
String d_notes="";Vector block_id=new Vector();
ResultSet rs_csquotes = stmt.executeQuery("select * from csquotes where order_no='"+order_no+"' and Block_ID !='A_APRODUCT' and (Block_ID like 'A%' or Block_ID like 'D_NOTE%') and product_id='IWP' order by cast(Line_no as integer), sequence_no");
		if (rs_csquotes !=null) {
        while (rs_csquotes.next()) {
		line_no.addElement(rs_csquotes.getString("Line_no"));
		desc.addElement(rs_csquotes.getString("Descript"));
		rec_no.addElement(rs_csquotes.getString("Record_no"));
		block_id.addElement(rs_csquotes.getString("Block_ID"));
		extended_price.addElement(rs_csquotes.getString("Extended_price"));
		uom.addElement(rs_csquotes.getString("UoM"));
		if(rs_csquotes.getString("qty") == null||rs_csquotes.getString("qty").trim().length()==0){
			qty.addElement("0");
		}
		else{
			qty.addElement(rs_csquotes.getString("Qty"));
		}
		mark.addElement(rs_csquotes.getString("field17"));
		k++;
		}
		}
		rs_csquotes.close();

if(k>0){

double tot_price1=0;
		//The base header table
		out.println("<table width='100%' class='table_thin_borders' cellspacing='0' cellpadding='0' border='1'>");
//		out.println("<tr ><td colspan='2' align='top' class='mainbodyh'><b>Interior Wall Protection#</b>&nbsp;</tr></td>");
		out.println("<tr height='20'>");
		out.println("<td width='5%' bgcolor='#006600' class='schedule'><b><u>Qty</u></b></td>");
		out.println("<td  bgcolor='#006600' class='schedule'><b><u>Description</u></b></td>");
		out.println("<td width='5%' bgcolor='#006600' class='schedule'><b><u>U/M</u></b></td>");
		if(type.equals("2")){
		out.println("<td width='7%' bgcolor='#006600' class='schedule'><b><u>Unit Price</u></b></td>");
		out.println("<td width='7%' bgcolor='#006600' class='schedule'><b><u>Total</u></b></td>");
		}
		out.println("</tr>");
		//The base header table
		for (int n=0;n<k;n++){
			if ((n%2)==1){bgcolor="#EFEFDE";}else {bgcolor="#e4e4e4";	}
			BigDecimal d1 = new BigDecimal(extended_price.elementAt(n).toString());
				BigDecimal d21 = new BigDecimal(qty.elementAt(n).toString().trim());
			BigDecimal d2 = new BigDecimal(price1);//total quote price
			BigDecimal d3_o = new BigDecimal(overage);
			BigDecimal d3 = d1.divide(d2,BigDecimal.ROUND_HALF_UP);
			BigDecimal d4 = d3.multiply(d3_o);
			d4 = d4.setScale(0, BigDecimal.ROUND_HALF_UP);
			tot_price1=(new Double(extended_price.elementAt(n).toString())).doubleValue()+d4.doubleValue();
			//out.println(tot_price1);

		  if (uom.elementAt(n)==null){um="";}else{um=uom.elementAt(n).toString();}
			if (!(block_id.elementAt(n).toString().equals("D_NOTES"))){
				out.println("<tr>");
				out.println("<td valign='top' align='right' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+qty.elementAt(n).toString()+"</td>");
				out.println("<td valign='top' align='left' bgcolor='"+bgcolor+"' class='maindesc'>"+desc.elementAt(n).toString()+"</td>");
				out.println("<td valign='top' align='left' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+um+"</td>");
				if(type.equals("2")){
				out.println("<td valign='top' nowrap width='7%' align='right' bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(tot_price1/d21.doubleValue())+"</td>");
				out.println("<td valign='top' nowrap width='7%' align='right' bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(tot_price1)+"</td>");
				}
				out.println("</tr>");
			 }
			if (block_id.elementAt(n).toString().equals("D_NOTES")){
			out.println("<tr><td>&nbsp;</td><td colspan='3' class='maindesc'>"+desc.elementAt(n).toString()+"</td></tr>");
			}

	 }//for loop
  }
//	out.println(d_notes);
//	out.println("<tr ><td valign='top' colspan='2' class='mainbodyh'>&nbsp;</td></tr>");
}
%>
</table>
<br>
