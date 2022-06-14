<%
NumberFormat forcan = NumberFormat.getNumberInstance();
forcan.setMinimumFractionDigits(2);
forcan.setMaximumFractionDigits(2);
out.println("<table width='100%' class='table_thin_borders' style='border-collapse: collapse;' cellspacing='0' cellpadding='3' border='1'>");
out.println("<tr height='20'>");
out.println("<td  class='maindesc'><b><u>Product</u></b></td>");
out.println("<td width='5%' class='maindesc'><b><u>Qty</u></b></td>");
out.println("<td width='5%' class='maindesc'><b><u>UOM</u></b></td>");
if(type.equals("2")){
	out.println("<td width='9%' class='maindesc'><b><u>Unit Price</u></b></td>");
	out.println("<td width='9%' class='maindesc'><b><u>Line Total</u></b></td>");
}
out.println("</tr>");
Vector description=new Vector();
Vector uom=new Vector();
Vector unit_price=new Vector();
Vector qty=new Vector();
Vector lineprice=new Vector();
double erapidcharges=0;
double totalvalue=0;
ResultSet rsquote_item=stmt_psa.executeQuery("select description, quantity,unit_price from dba.quote_item where quote_id='"+QuoteID+"' order by qt_item_id");
if(rsquote_item != null){
	while(rsquote_item.next()){
		if(rsquote_item.getString(1).equals("CHARGES")){
			erapidcharges=erapidcharges+new Double(rsquote_item.getString(3)).doubleValue();
		}
		else{
			description.addElement(rsquote_item.getString(1));
			uom.addElement("EA");
			unit_price.addElement(rsquote_item.getString(3));
			qty.addElement(rsquote_item.getString(2));
			double tempprice=new Double(rsquote_item.getString(3)).doubleValue()*new Double(rsquote_item.getString(2)).doubleValue();
			totalvalue=totalvalue+tempprice;
			lineprice.addElement(""+tempprice);
		}		
	}
}
rsquote_item.close();
for (int n=0;n<description.size();n++){
	out.println("<tr><td valign='top'   class='maindesc'>"+description.elementAt(n).toString()+"</td>");
	out.println("<td valign='top' nowrap  class='maindesc'>"+forcan.format(new Double(qty.elementAt(n).toString()).doubleValue())+"</td>");
	out.println("<td valign='top' nowrap  class='maindesc'>"+uom.elementAt(n).toString()+"</td>");
	if(type.equals("2")){
		double templineprice=new Double(lineprice.elementAt(n).toString()).doubleValue()/totalvalue*erapidcharges;
		templineprice=templineprice+new Double(lineprice.elementAt(n).toString()).doubleValue();
		double tempunitprice=templineprice/new Double(qty.elementAt(n).toString()).doubleValue();
		out.println("<td valign='top' nowrap  class='maindesc' >"+forcan.format(tempunitprice)+"</td>");
		out.println("<td valign='top' nowrap  class='maindesc' >"+forcan.format(templineprice)+"</td>");
	}
	out.println("</tr>");
}
totalvalue=totalvalue+erapidcharges;	
//out.println(totalvalue);
price=for1.format(totalvalue);
%>
</table>
<BR>



