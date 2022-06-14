<font class='mainbodyh'><B>QUOTE SUMMARY ::</B><br><br></font>
<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'>
<tr height='20'>
<td width='4%' bgcolor='#006600'><font class='schedule'></font></td>
<td width='13%' bgcolor='#006600'><font class='schedule'><b>Mark</b></font></td>
<td width='35%' bgcolor='#006600'><font class='schedule'><b>Model</b></font></td>
<td width='8%' bgcolor='#006600'><font class='schedule'><b>Qty</b></font></td>
<td width='13%' bgcolor='#006600'><font class='schedule'><b>Price</b></font></td>
<td width='13%' bgcolor='#006600'><font class='schedule'><b>Size(w x l)</b></font></td>
<td width='21%' bgcolor='#006600'><font class='schedule'><b>Price/sq ft<sup> *</sup></b></font></td>
<td width='18%' bgcolor='#006600'><font class='schedule'><b>Discount</b></font></td>
<td width='18%' bgcolor='#006600'><font class='schedule'><b>Comission </b></font></td>
</tr>
<% 
String dimension="";String area="";String discount_showx="";String factx=""; String quan1="0";String line_no="";
for(int k=0;k<line;k++){	
	String bgcolor="";
	if ((k%2)==1){bgcolor="#e4e4e4";}else {bgcolor="#EFEFDE";}
	//Getting the Area
	String config_s0 = config_string.elementAt(k).toString();
	int config_s1= config_s0.indexOf("AREA[");
	int config_s2=config_s0.indexOf("]",config_s1+1);
	area=config_s0.substring(config_s1+5,config_s2);
	if(config_s1<0){area="0";}
	//Getting the Area done
	for (int mnx=0;mnx<line_item.size();mnx++){
		if ((line_item.elementAt(mnx).toString()).equals((items.elementAt(k).toString()))){
			factx=fact_per.elementAt(mnx).toString().trim();//FIELD16
			if(factx.length() <= 0){
				factx="0";
			}
			String totwtx=price.elementAt(mnx).toString();//Extended_Price
			BigDecimal d1x = new BigDecimal(totwtx);
			BigDecimal d2x = new BigDecimal(factx);
			BigDecimal d3x = d1x.multiply(d2x);
			factor = factor+d3x.doubleValue();// total comission dollars for the line
			totprice=totprice+d1x.doubleValue();//just the materail price no comission for the line
			if ((block_id.elementAt(mnx).toString()).equals("A_APRODUCT")){
				line_no=line_item.elementAt(mnx).toString();
				quan1=QTY.elementAt(mnx).toString();
				description=(desc.elementAt(mnx)).toString();
				mark=(mark_no.elementAt(mnx)).toString();
				if (!(discount.elementAt(mnx)==null)){
					discount_showx=discount.elementAt(mnx).toString().trim().replace('L','B');//FIELD19
				}
				else{
					discount_showx="";
				}
			}
			if ((block_id.elementAt(mnx).toString()).equals("E_DIM")){
				String dim=(desc.elementAt(mnx)).toString();
			   int n_s=dim.indexOf("@");
				dimension=dim.substring(0,n_s);
			}
		}
	}
	out.println("<tr><td width='4%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+line_no+"</td>");
	out.println("<td width='10%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+mark+"</td>");
	out.println("<td width='25%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+description+"</td>");
	out.println("<td valign='top' width='6%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+quan1+"</td>");
	out.println("<td valign='top' width='10%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for123.format(totprice)+"</td>");
	out.println("<td valign='top' width='10%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+dimension+"</td>");
	if(area.equals("0")){
		out.println("<td valign='top' width='19%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+"&nbsp;--"+""+"</td>");
	}
	else{
		out.println("<td valign='top' width='19%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+"&nbsp;"+for1.format(totprice/(new Double(area).doubleValue()*new Double(quan1).doubleValue()))+"</td>");
	}
	out.println("<td valign='top' width='50%'bgcolor='"+bgcolor+"' class='maindesc'>"+discount_showx+"</td>");
	out.println("<td valign='top' width='50%'bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(factor)+"</td>");
	out.println("</tr>");
	factor=0;totprice=0;area="";discount_showx="";dimension="";	
}
 %>
</table>
<br><br>
