<%

		out.println("<table width='100%' cellspacing='1' cellpadding='2' border='0'>");
		/*
		out.println("<tr height='20'>");
		out.println("<td  bgcolor='#996600' class='schedule'><b><u>Model</u></b></td>");
		out.println("<td width='5%' bgcolor='#996600' class='schedule'><b><u>Qty</u></b></td>");
		//out.println("<td width='5%' bgcolor='#996600' class='schedule'><b><u>UOM</u></b></td>");
		if(type.equals("2")){
		out.println("<td width='5%' bgcolor='#996600' class='schedule'><b><u>Unit Price</u></b></td>");
		out.println("<td width='5%' bgcolor='#996600' class='schedule'><b><u>Line Total</u></b></td>");		
		}
		out.println("</tr>");
*/
		Vector desc2=new Vector();
		Vector seq=new Vector();
		Vector block_id=new Vector();
		int k=0;String bgcolor="";Vector mark=new Vector();Vector desc=new Vector();Vector qty=new Vector();Vector rec_no=new Vector();
		Vector price_csquotes=new Vector();Vector line_no=new Vector();String color="NONE";Vector um=new Vector();
		ResultSet rs_csquotes = stmt.executeQuery("select * from csquotes where order_no='"+order_no+"' and Block_ID !='A_APRODUCT' order by block_id desc, cast(Line_no as integer),sequence_no");
  		if (rs_csquotes !=null) {
        while (rs_csquotes.next()) {
        		seq.addElement(rs_csquotes.getString("sequence_no"));
        		block_id.addElement(rs_csquotes.getString("block_id"));
			line_no.addElement(rs_csquotes.getString("Line_no"));
			desc.addElement(rs_csquotes.getString("Descript"));
			price_csquotes.addElement(rs_csquotes.getString ("Extended_Price"));
			rec_no.addElement(rs_csquotes.getString("Record_no"));
			qty.addElement(rs_csquotes.getString("Qty"));
			mark.addElement(rs_csquotes.getString("field17"));
			if(rs_csquotes.getString("uom") != null){um.addElement(rs_csquotes.getString("uom"));}
			else{um.addElement("");} 
			k++;
									}
								}
		rs_csquotes.close();
		
		String pressure="";
		String finish="";
		Vector modelx=new Vector();
		Vector descriptx=new Vector();
		Vector modelx2=new Vector();
		Vector descriptx2=new Vector();
		for(int a=0; a<desc.size(); a++){
			if(block_id.elementAt(a).toString().equals("B_DESCRIPT")){
				if(seq.elementAt(a).equals("10.00")){
					descriptx.addElement(desc.elementAt(a).toString());
				}
				if(seq.elementAt(a).equals("20.00")){
					modelx.addElement(desc.elementAt(a).toString());
				}
				else{
					if(seq.elementAt(a).equals("30.00")){
						pressure=desc.elementAt(a).toString();
					}
					if(seq.elementAt(a).equals("40.00")){
						finish=desc.elementAt(a).toString();
					}
				}
			}
		}
		//out.println(descriptx.size()+"::"+modelx.size()+"<BR>");
		for(int t=0; t<descriptx.size(); t++){
			boolean isUnique=true;
			for(int q=0; q<descriptx.size(); q++){
				if(descriptx.elementAt(t).toString().trim().equals(descriptx.elementAt(q).toString().trim())){
					if(modelx.elementAt(t).toString().trim().equals(modelx.elementAt(q).toString().trim())){
						isUnique=false;
					}
				}
			}
			
			if(isUnique){
				descriptx2.addElement(descriptx.elementAt(t).toString());
				modelx2.addElement(modelx.elementAt(t).toString());
			}
			
			else{
				boolean isUnique2=true;
				
				for(int e=0; e<descriptx2.size(); e++){				
					if(descriptx.elementAt(t).toString().trim().equals(descriptx2.elementAt(e).toString().trim())){
						if(modelx.elementAt(t).toString().trim().equals(modelx2.elementAt(e).toString().trim())){
							isUnique2=false;
						}
					}				
				}
				
				if(isUnique2){
					//out.println(descriptx.elementAt(t).toString()+"::"+t+"::::HERE<BR>");
					descriptx2.addElement(descriptx.elementAt(t).toString());
					modelx2.addElement(modelx.elementAt(t).toString());
				}
				
				
			}
			
		}
		
		int countx=0;		
		for(int w=0; w<descriptx2.size(); w++){
			out.println("<BR><td valign='top'  bgcolor='#d6d6ad' class='maindesc'>"+descriptx2.elementAt(w).toString()+"</td></tr>");
			out.println("<BR><td valign='top'  bgcolor='#ffffd9' class='maindesc'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+modelx2.elementAt(w).toString()+"</td></tr>");
		}
		
		out.println("<BR><td valign='top'  bgcolor='#d6d6ad' class='maindesc'>"+pressure+"</td></tr>");
		out.println("<BR><td valign='top'  bgcolor='#ffffd9' class='maindesc'>"+finish+"</td></tr>");
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		String config_price="";Vector line_item_group=new Vector();Vector line_sum_group=new Vector();double tot_sum=0;
		ResultSet rs_csquotes_sum = stmt.executeQuery("SELECT line_no, sum(cast(extended_price as decimal)) FROM CSQUOTES where order_no='"+order_no+"' group by line_no order by cast(Line_no as integer)");
  		if (rs_csquotes_sum !=null) {
         while (rs_csquotes_sum.next()) {

		 line_item_group.addElement(rs_csquotes_sum.getString(1));
		 line_sum_group.addElement(rs_csquotes_sum.getString(2));
		 tot_sum=tot_sum+new Double(rs_csquotes_sum.getString(2)).doubleValue();
		//out.println(tot_sum+"::");
		 }
		}
		rs_csquotes_sum.close();
//
		double totprice=0;String line_cost="0";
		
for (int n=0;n<k;n++){
		
		if ((n%2)==0){bgcolor="#d6d6ad";}else {bgcolor="#ffffd9";	}
		if(block_id.elementAt(n).toString().equals("B_DESCRIPT")){
		/*
			out.println("<tr>");
			out.println("<td valign='top'  bgcolor='"+bgcolor+"' class='maindesc'>"+desc.elementAt(n).toString()+"<BR>&nbsp;</td>");
			out.println("</tr>");

			countx=0;
			*/
		}
		else{
			if(countx==0){
				out.println("<tr>");
				out.println("<td valign='top'  bgcolor='"+bgcolor+"' class='maindesc' align='center'><B>The scope of work is limited to the following sizes and quantities:</b></td>");
				out.println("</tr>");					
			}
			out.println("<tr>");
			out.println("<td valign='top'  bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+desc.elementAt(n).toString()+"</td>");
			out.println("</tr>");	
			countx++;
		}
		
			//out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+qty.elementAt(n).toString()+"</td>");
			line_cost=""+(new Double(line_cost).doubleValue()+new Double(price_csquotes.elementAt(n).toString()).doubleValue());
			//out.println(line_sum_group.elementAt(n).toString()+"::");
			//line_cost=line_sum_group.elementAt(n).toString();
		BigDecimal d1 = new BigDecimal(line_cost);
		BigDecimal d2 = new BigDecimal(tot_sum);//total configured price
		BigDecimal d3_o = new BigDecimal(overage);
		BigDecimal d3 = d1.divide(d2,BigDecimal.ROUND_HALF_UP);
		BigDecimal d4 = d3.multiply(d3_o);
		
		d4 = d4.setScale(0, BigDecimal.ROUND_HALF_UP);
		totprice=(new Double(line_cost)).doubleValue()+d4.doubleValue();
		int qty1= qty.elementAt(n).toString().indexOf("(");
		String qty2="";


		
		
 }//for loop
/*
	if( (new Double(handling_cost)).doubleValue()>0 ){
	out.println("<tr>");
	out.println("<td valign='top'  bgcolor='"+bgcolor+"' class='maindesc'>"+"Small Order Handling Charge."+"</td>");
	//out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+"1"+"</td>");
	//out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+"EA"+"</td>");
		if(type.equals("2")){
	//	out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+"$"+handling_cost+"&nbsp;"+"</td>");
	//	out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+"$"+handling_cost+"&nbsp;"+"</td>");
		}
	out.println("</tr>");
	}
	if( (new Double(freight_cost)).doubleValue()>0 ){
	out.println("<tr>");
	out.println("<td valign='top'  bgcolor='"+bgcolor+"' class='maindesc'>"+"Special Charge."+"</td>");
	//out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc' align='left'>"+"1"+"</td>");
	//out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+"EA"+"</td>");
		if(type.equals("2")){
	//	out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+"$"+freight_cost+"&nbsp;"+"</td>");
	//	out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+"$"+freight_cost+"&nbsp;"+"</td>");
		}
	out.println("</tr>");
	}
	
*/	
	
	
	
//BigDecimal bd=new BigDecimal(tot_sum / 1000000);
//out.println("::"+bd.setScale(0,BigDecimal.ROUND_DOWN)+"::<BR>");
	
	
	
	
	
	
	
	
	
	
String VS_MILLIONS="";	
String VS_THOUSANDS="";
String VS_UNITS="";
String VS_MANTISSA="";

BigDecimal bd=new BigDecimal(tot_sum2 / 1000000);
double VR_MILLIONS = bd.setScale(0,BigDecimal.ROUND_DOWN).doubleValue();

bd=new BigDecimal((tot_sum2 - VR_MILLIONS * 1000000) / 1000);
double VR_THOUSANDS = bd.setScale(0,BigDecimal.ROUND_DOWN).doubleValue();

bd=new BigDecimal(VR_THOUSANDS / 100);
double VR_THOU1 = bd.setScale(0,BigDecimal.ROUND_DOWN).doubleValue();

bd=new BigDecimal((VR_THOUSANDS - VR_THOU1 * 100) / 10);
double VR_THOU2 = bd.setScale(0,BigDecimal.ROUND_DOWN).doubleValue();

bd=new BigDecimal(VR_THOUSANDS - VR_THOU1 * 100 - VR_THOU2 * 10);
double VR_THOU3 = bd.setScale(0,BigDecimal.ROUND_DOWN).doubleValue();

bd=new BigDecimal(tot_sum2 - VR_MILLIONS * 1000000 - VR_THOUSANDS * 1000);
double VR_UNITS = bd.setScale(0,BigDecimal.ROUND_DOWN).doubleValue();

bd=new BigDecimal(VR_UNITS / 100);
double VR_UNIT1 = bd.setScale(0,BigDecimal.ROUND_DOWN).doubleValue();

bd=new BigDecimal((VR_UNITS - VR_UNIT1 * 100) / 10);
double VR_UNIT2 = bd.setScale(0,BigDecimal.ROUND_DOWN).doubleValue();

bd=new BigDecimal(VR_UNITS - VR_UNIT1 * 100 - VR_UNIT2 * 10);
double VR_UNIT3 = bd.setScale(0,BigDecimal.ROUND_DOWN).doubleValue();

BigDecimal bd2=new BigDecimal(tot_sum2);

bd=new BigDecimal((tot_sum2 - bd2.setScale(0,BigDecimal.ROUND_DOWN).doubleValue()) * 100);
//out.println(bd+"::"+bd2+"::"+tot_sum2+"<BR>");
double VR_MANTISSA = bd.setScale(0,BigDecimal.ROUND_HALF_UP).doubleValue();

bd=new BigDecimal(VR_MANTISSA / 10);
double VR_MANT1 = bd.setScale(0,BigDecimal.ROUND_DOWN).doubleValue();

bd=new BigDecimal(VR_MANTISSA - VR_MANT1 * 10);
double VR_MANT2 = bd.setScale(0,BigDecimal.ROUND_DOWN).doubleValue();

//out.println(VR_MILLIONS+"::X"+VR_THOUSANDS+"::"+VR_THOU1+"::"+VR_THOU2+"::"+VR_THOU3+"<br>");
//out.println(VR_MANTISSA+"::"+VR_MANT1+"::"+VR_MANT2);
String VS_CURRENCY = "dollars ";




int millions = (int)(VR_MILLIONS);
switch (millions) {
    case 0: VS_MILLIONS = ""; break;
    case 1: VS_MILLIONS = "one million "; break;
    case 2: VS_MILLIONS = "two million "; break;
    case 3: VS_MILLIONS = "three million "; break;
    case 4: VS_MILLIONS = "four million "; break;
    case 5: VS_MILLIONS = "five million "; break;
    case 6: VS_MILLIONS = "six million "; break;
    case 7: VS_MILLIONS = "seven million "; break;
    case 8: VS_MILLIONS = "eight million "; break;
    case 9: VS_MILLIONS = "nine million "; break;
    case 10: VS_MILLIONS = "ten million "; break;
    default: VS_MILLIONS = "exceeded "; break;
}

int thou1 = (int)(VR_THOU1);
String t1="";
switch (thou1) {
    case 1: t1 = "one hundred "; break;
    case 2: t1 = "two hundred "; break;
    case 3: t1 = "three hundred "; break;
    case 4: t1 = "four hundred "; break;
    case 5: t1 = "five hundred "; break;
    case 6: t1 = "six hundred "; break;
    case 7: t1 = "seven hundred "; break;
    case 8: t1 = "eight hundred "; break;
    case 9: t1 = "nine hundred "; break;
}

int thou2 = (int)(VR_THOU2);
String t2="";
switch (thou2) {
    case 2: t2 = "twenty "; break;
    case 3: t2 = "thirty "; break;
    case 4: t2 = "fourty "; break;
    case 5: t2 = "fifty "; break;
    case 6: t2 = "sixty "; break;
    case 7: t2 = "seventy "; break;
    case 8: t2 = "eighty "; break;
    case 9: t2 = "ninety "; break;
}

int thou3 = (int)(VR_THOU3);
if (thou2 == 1) {
thou3 = 10 * thou2 + thou3;
}
String t3="";
switch (thou3) {
    case 1: t3 = "one "; break;
    case 2: t3 = "two "; break;
    case 3: t3 = "three "; break;
    case 4: t3 = "four "; break;
    case 5: t3 = "five "; break;
    case 6: t3 = "six "; break;
    case 7: t3 = "seven "; break;
    case 8: t3 = "eight "; break;
    case 9: t3 = "nine "; break;
    case 10: t3 = "ten "; break;
    case 11: t3 = "eleven "; break;
    case 12: t3 = "twelve "; break;
    case 13: t3 = "thirteen "; break;
    case 14: t3 = "fourteen "; break;
    case 15: t3 = "fifteen "; break;
    case 16: t3 = "sixteen "; break;
    case 17: t3 = "seventeen "; break;
    case 18: t3 = "eighteen "; break;
    case 19: t3 = "nineteen "; break;
}

VS_THOUSANDS = t1 + t2 + t3;
//out.println(t1+"::"+t2+"::"+t3+"<BR>");
if (VR_THOUSANDS > 0) {
VS_THOUSANDS = VS_THOUSANDS + "thousand ";
}

int unit1 = (int)(VR_UNIT1);
String u1="";
switch (unit1) {
    case 1: u1 = "one hundred "; break;
    case 2: u1 = "two hundred "; break;
    case 3: u1 = "three hundred "; break;
    case 4: u1 = "four hundred "; break;
    case 5: u1 = "five hundred "; break;
    case 6: u1 = "six hundred "; break;
    case 7: u1 = "seven hundred "; break;
    case 8: u1 = "eight hundred "; break;
    case 9: u1 = "nine hundred "; break;
}

int unit2 = (int)(VR_UNIT2);
String u2="";
switch (unit2) {
    case 2: u2 = "twenty "; break;
    case 3: u2 = "thirty "; break;
    case 4: u2 = "fourty "; break;
    case 5: u2 = "fifty "; break;
    case 6: u2 = "sixty "; break;
    case 7: u2 = "seventy "; break;
    case 8: u2 = "eighty "; break;
    case 9: u2 = "ninety "; break;
}

int unit3 = (int)(VR_UNIT3);
if (unit2 == 1) {
unit3 = 10 * unit2 + unit3;
}
String u3="";
switch (unit3) {
    case 1: u3 = "one "; break;
    case 2: u3 = "two "; break;
    case 3: u3 = "three "; break;
    case 4: u3 = "four "; break;
    case 5: u3 = "five "; break;
    case 6: u3 = "six "; break;
    case 7: u3 = "seven "; break;
    case 8: u3 = "eight "; break;
    case 9: u3 = "nine "; break;
    case 10: u3 = "ten "; break;
    case 11: u3 = "eleven "; break;
    case 12: u3 = "twelve "; break;
    case 13: u3 = "thirteen "; break;
    case 14: u3 = "fourteen "; break;
    case 15: u3 = "fifteen "; break;
    case 16: u3 = "sixteen "; break;
    case 17: u3 = "seventeen "; break;
    case 18: u3 = "eighteen "; break;
    case 19: u3 = "nineteen "; break;
}

VS_UNITS = u1 + u2 + u3;

int mant1 = (int)(VR_MANT1);
String m1="";
switch (mant1) {
    case 2: m1 = "twenty "; break;
    case 3: m1 = "thirty "; break;
    case 4: m1 = "fourty "; break;
    case 5: m1 = "fifty "; break;
    case 6: m1 = "sixty "; break;
    case 7: m1 = "seventy "; break;
    case 8: m1 = "eighty "; break;
    case 9: m1 = "ninety "; break;
}

int mant2 = (int)(VR_MANT2);
if (mant1 == 1) {
mant2 = 10 * mant1 + mant2;
}
String m2 ="";
switch (mant2) {
    case 0: m2 = "zero "; break;
    case 1: m2 = "one "; break;
    case 2: m2 = "two "; break;
    case 3: m2 = "three "; break;
    case 4: m2 = "four "; break;
    case 5: m2 = "five "; break;
    case 6: m2 = "six "; break;
    case 7: m2 = "seven "; break;
    case 8: m2 = "eight "; break;
    case 9: m2 = "nine "; break;
    case 10: m2 = "ten "; break;
    case 11: m2 = "eleven "; break;
    case 12: m2 = "twelve "; break;
    case 13: m2 = "thirteen "; break;
    case 14: m2 = "fourteen "; break;
    case 15: m2 = "fifteen "; break;
    case 16: m2 = "sixteen "; break;
    case 17: m2 = "seventeen "; break;
    case 18: m2 = "eighteen "; break;
    case 19: m2 = "nineteen "; break;
}

VS_MANTISSA = "and " + m1 + m2 + "cents";
	
	
	
	
	//out.println(VS_MILLIONS + VS_THOUSANDS + VS_UNITS + VS_CURRENCY + VS_MANTISSA + "HERE");
	
	String totalWord=VS_MILLIONS + VS_THOUSANDS + VS_UNITS + VS_CURRENCY ;
	if(!product.equals("APC")){
%>
<table class='<%= border_color %>' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
	<td class='tableline_row mainbody' width='50%' align='left' valign='middle' nowrap><b>Total Price: <font class='totprice'><%=for11x.format(grand_total2)  %>.00(<%=totalWord%>)</font></b></td>
</tr>
</table>
<%
}
%>
