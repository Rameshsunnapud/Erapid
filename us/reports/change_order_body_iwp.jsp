<%
//out.println(overage+"::"+handling_cost+"::"+freight_cost+"::<BR>");
double add_total=0;
double deduct_total=0;
Vector add_description=new Vector();
Vector add_qty=new Vector();
Vector add_uom=new Vector();
Vector add_price=new Vector();
Vector add_block=new Vector();
Vector add_line=new Vector();
Vector deduct_description=new Vector();
Vector deduct_qty=new Vector();
Vector deduct_uom=new Vector();
Vector deduct_price=new Vector();
Vector deduct_block=new Vector();
Vector deduct_line=new Vector();
double totalprice=0;
String query="";
String queryAdd="";
String queryDeduct="";
double addSum=0;
double deductSum=0;
if(product.equals("EJC")){
	query="select * from csquotes where order_no ='"+order_no+"' and Block_ID like 'pricing%' order by deduct,line_no";
	queryAdd="select extended_price from csquotes where order_no ='"+order_no+"' and Block_ID like 'pricing%' and deduct='add'";
	queryDeduct="select extended_price from csquotes where order_no ='"+order_no+"' and Block_ID like 'pricing%' and deduct='deduct'";
}
else if(product.equals("IWP")){
	query="select * from csquotes where order_no ='"+order_no+"' and not block_id in ('a_aproduct','d_notes') and (Block_ID like 'A%' or block_id like 'b_char%') order by deduct,line_no";
	queryAdd="select extended_price from csquotes where order_no ='"+order_no+"' and not block_id in ('a_aproduct','d_notes') and (Block_ID like 'A%' or block_id like 'b_char%') and deduct='add'";
	queryDeduct="select extended_price from csquotes where order_no ='"+order_no+"' and not block_id in ('a_aproduct','d_notes') and (Block_ID like 'A%' or block_id like 'b_char%') and deduct='deduct'";
}
//out.println(query+"::<BR>"+queryAdd+"::"+queryDeduct);
int addcount=0;
ResultSet rsaddsum=stmt.executeQuery(queryAdd);
if(rsaddsum != null){
	while(rsaddsum.next()){
		addSum=addSum+rsaddsum.getDouble(1);
		addcount++;
	}
}
rsaddsum.close();
if(addcount==0){
	ResultSet rsdeductsum=stmt.executeQuery(queryDeduct);
	if(rsdeductsum != null){
		while(rsdeductsum.next()){
			deductSum=deductSum+rsdeductsum.getDouble(1);
		}
	}
	rsdeductsum.close();
}

//out.println(addSum+":::add sum<BR>");





ResultSet rscsquotes=stmt.executeQuery(query);
if(rscsquotes != null){
	while(rscsquotes.next()){
		if(rscsquotes.getString("deduct") != null && rscsquotes.getString("deduct").toUpperCase().equals("DEDUCT")){
			//out.println("HERE<br>");
			deduct_description.addElement(rscsquotes.getString("descript"));
			deduct_qty.addElement(rscsquotes.getString("bpcs_qty"));
			deduct_uom.addElement(rscsquotes.getString("bpcs_um"));
			deduct_block.addElement(rscsquotes.getString("block_id"));
			deduct_line.addElement(rscsquotes.getString("line_no"));
			if(addcount==0){
				if(overage !=null && overage.trim().length()>0){
					deduct_price.addElement(""+(rscsquotes.getDouble("extended_price")-(rscsquotes.getDouble("extended_price")/deductSum)*new Double(overage).doubleValue()));
				}
				else{
					deduct_price.addElement(rscsquotes.getString("extended_price"));
				}
			}
			else{
				deduct_price.addElement(rscsquotes.getString("extended_price"));
			}
		}
		else{
			//out.println("HERE2<br>");
			add_description.addElement(rscsquotes.getString("descript"));
			add_qty.addElement(rscsquotes.getString("bpcs_qty"));
			add_uom.addElement(rscsquotes.getString("bpcs_um"));
			add_block.addElement(rscsquotes.getString("block_id"));
			add_line.addElement(rscsquotes.getString("line_no"));
			if(overage !=null && overage.trim().length()>0){
				add_price.addElement(""+(rscsquotes.getDouble("extended_price")+(rscsquotes.getDouble("extended_price")/addSum)*new Double(overage).doubleValue()));
			}
			else{
				add_price.addElement(rscsquotes.getString("extended_price"));
			}
		}
	}
}
rscsquotes.close();



if(freight_cost != null && freight_cost.trim().length()>0){
	if(new Double(freight_cost).doubleValue()>0){
		add_description.addElement("Freight");
		add_qty.addElement("1");
		add_uom.addElement("EA");
		add_price.addElement(freight_cost);
		add_line.addElement("Freight");
		add_block.addElement("");
	}
}
if(handling_cost != null && handling_cost.trim().length()>0){
	if(new Double(handling_cost).doubleValue()>0){
		add_description.addElement("Handling");
		add_qty.addElement("1");
		add_uom.addElement("EA");
		add_price.addElement(handling_cost);
		add_line.addElement("Handling");
		add_block.addElement("");
	}
}

out.println("<table width='100%' border='1'><tr><td colspan='4'><u>Model ADD</u></td></tr>");
//out.println(add_description.size()+"::"+add_line.size()+"::<BR>");
for(int i=0; i<add_description.size(); i++){
	double tempAddPrice=0;
	for(int ii=0; ii<add_description.size(); ii++){
		if(add_line.elementAt(i).toString().equals(add_line.elementAt(ii).toString())){
			tempAddPrice=tempAddPrice+new Double(add_price.elementAt(ii).toString()).doubleValue();
		}

	}

	if(add_block.elementAt(i).toString().toUpperCase().startsWith("A")){
		out.println("<tr>");
		out.println("<td>"+add_description.elementAt(i).toString()+"</td>");
		out.println("<td>"+add_qty.elementAt(i).toString()+"</td>");
		out.println("<td>"+add_uom.elementAt(i).toString()+"</td>");
		if(!(cmd.equals("1")||cmd.equals("4"))){
			out.println("<td align='right'>"+for2.format(tempAddPrice)+"</td>");
		}
		out.println("</tr>");

		totalprice=totalprice+tempAddPrice;
		add_total=add_total+tempAddPrice;
	}

}

if(cmd.equals("3")||cmd.equals("4")){
	out.println("<tr><td colspan='4' align='right'><b>Total: <font class='totprice'> "+for0.format(Math.ceil(add_total))+"</font></b></td></tr>");
}

out.println("<tr><td colspan='4'><u>Model DEDUCT</u></td></tr>");
for(int i=0; i<deduct_description.size(); i++){
	double tempDeductPrice=0;
	for(int ii=0; ii<deduct_description.size(); ii++){
		if(deduct_line.elementAt(i).toString().equals(deduct_line.elementAt(ii).toString())){
			tempDeductPrice=tempDeductPrice+new Double(deduct_price.elementAt(ii).toString()).doubleValue();


		}
	}
	if(deduct_block.elementAt(i).toString().toUpperCase().startsWith("A")){
		out.println("<tr>");
		out.println("<td>"+deduct_description.elementAt(i).toString()+"</td>");
		out.println("<td>"+deduct_qty.elementAt(i).toString()+"</td>");
		out.println("<td>"+deduct_uom.elementAt(i).toString()+"</td>");
		if(!(cmd.equals("1")||cmd.equals("4"))){
			out.println("<td align='right'>("+for2.format(tempDeductPrice)+")</td>");
		}
		out.println("</tr>");
		totalprice=totalprice-new Double(tempDeductPrice).doubleValue();
		deduct_total=deduct_total+new Double(tempDeductPrice).doubleValue();
	}
}
if(cmd.equals("3")||cmd.equals("4")){
	out.println("<tr><td colspan='4' align='right'><b>Total: <font class='totprice'> ("+for0.format(Math.floor(deduct_total))+")</font></td></tr>");
}

out.println("</table>");
%>
<BR>
Shipping Information:<BR>
&nbsp;&nbsp;<input type='checkbox' name='sd1'>&nbsp;&nbsp;To Be Determined<BR>
&nbsp;&nbsp;<input type='checkbox' name='sd2'>&nbsp;&nbsp;As Soon As Possible<BR>
&nbsp;&nbsp;<input type='checkbox' name='sd3'>&nbsp;&nbsp;Requested Ship Date &nbsp;&nbsp;&nbsp;____/____/<u>20</u>____<BR>
Please note that while we will make every attempt to meet a requested ship date, check with your local representative for confirmed shipping information.<BR>

<%
if(free_text != null && free_text.trim().length()>0){
%>
<BR><BR>
<table  cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'><%=free_text%></td></tr>
</table>
<%
}
%>
<BR><BR>
<table border='0' width='100%' ><tr>
		<td class='maindesc' width='75%' align='left'><b>PLEASE NOTE THAT THIS CHANGE PROPOSAL PRICING IS FOR MATERIAL ONLY. <BR>PRICING EXCLUDES TAX AND ANY SPECIAL SHIPPING REQUESTS</b></td>
		<td class='tableline_row mainbody' width='25%' align='right'><b>Total: <font class='totprice'>
				<%
				double temppricenew=Math.ceil(add_total)-Math.floor(deduct_total);
				String totalpricetemp=for12x.format(totalprice);
				if(totalprice<0){
					totalpricetemp="("+for13x.format(totalprice).substring(1)+")";
				}
				//out.println(totalpricetemp);
				out.println(for0.format(temppricenew));
				%>
				</font></b></td>
	</tr></table>

