<%
//NumberFormat for13x = NumberFormat.getCurrencyInstance();
for13x.setMaximumFractionDigits(2);
NumberFormat forge = NumberFormat.getCurrencyInstance();
forge.setMaximumFractionDigits(2);
forge.setMinimumFractionDigits(2);
int k_new=0;String bgcolor_new="";Vector desc_new=new Vector();Vector qty_new=new Vector();Vector extended_price_new=new Vector();
Vector line_no_new=new Vector();double totprice=0.0;Vector desc_new_group=new Vector();Vector block_id=new Vector();Vector desc_new_group_line=new Vector();Vector line_group_line=new Vector();
Vector uom_new=new Vector();Vector bpcs_uom=new Vector();Vector bpcs_qty=new Vector();double tot_sum=0;
Vector line_block=new Vector();Vector line_block_price=new Vector();Vector mark_iwp=new Vector();
	ResultSet rs_csquotes_new = stmt.executeQuery("select * from csquotes where order_no='"+order_no+"' and product_id='EFS' order by cast(line_no as integer),block_id ");
		if (rs_csquotes_new !=null) {
        while (rs_csquotes_new.next()) {
		line_no_new.addElement(rs_csquotes_new.getString("line_no"));
		desc_new.addElement(rs_csquotes_new.getString("descript"));
		extended_price_new.addElement(rs_csquotes_new.getString("extended_price"));
		//out.println(rs_csquotes_new.getString("extended_price")+"::<BR>");
    	tot_sum=tot_sum+new Double(rs_csquotes_new.getString("extended_price")).doubleValue();
		block_id.addElement(rs_csquotes_new.getString("Block_ID"));
		uom_new.addElement(rs_csquotes_new.getString("uom"));
		qty_new.addElement(rs_csquotes_new.getString("qty"));
		//out.println(rs_csquotes_new.getString("bpcs_qty")+"::bpcs :"+rs_csquotes_new.getString("qty")+"::qty<BR>");
		bpcs_qty.addElement(rs_csquotes_new.getString("bpcs_qty"));
		bpcs_uom.addElement(rs_csquotes_new.getString("bpcs_um"));
		mark_iwp.addElement(rs_csquotes_new.getString("field17"));
		//out.println(rs_csquotes_new.getString("block_id")+"::<BR>");
		k_new++;
									}
								}
								rs_csquotes_new.close();
	if(k_new>0){
//	out.println("<tr ><td colspan='2' align='top' class='mainbodyh'><b>Entrance Flooring System#</b>&nbsp;</tr></td>");
	}
	ResultSet rs_csquotes_new_group = stmt.executeQuery("select cast(CSQUOTES.descript as varchar(700)) as a1 from csquotes where order_no='"+order_no+"'  and product_id='EFS' and block_id='A_APRODUCT' group by cast(CSQUOTES.descript as varchar(700))");
		if (rs_csquotes_new_group !=null) {
		   while (rs_csquotes_new_group.next()) {
			desc_new_group.addElement(rs_csquotes_new_group.getString("a1"));
			}
		}
		rs_csquotes_new_group.close();
	ResultSet rs_csquotes_new_group_line = stmt.executeQuery("select cast(CSQUOTES.descript as varchar(700)) as a1,line_no,sum(cast(extended_price as decimal)) from csquotes where order_no='"+order_no+"'  and product_id='EFS' and block_id='A_APRODUCT' group by cast(CSQUOTES.descript as varchar(700)),line_no order by cast(line_no as integer)");
		if (rs_csquotes_new_group_line !=null) {
		   while (rs_csquotes_new_group_line.next()) {
			desc_new_group_line.addElement(rs_csquotes_new_group_line.getString("a1"));
			line_group_line.addElement(rs_csquotes_new_group_line.getString("line_no"));
			}
		}
		rs_csquotes_new_group_line.close();
	ResultSet rs_csquotes_blocks = stmt.executeQuery("select line_no,sum(cast(extended_price as float)) from csquotes where order_no='"+order_no+"'  and product_id='EFS' and block_id not in ('E_DIM','E_DIM1','E_DIM2','A_APRODUCT') and block_id not like 'B%' group by line_no");
		if (rs_csquotes_blocks !=null) {
		   while (rs_csquotes_blocks.next()) {
				//out.println(rs_csquotes_blocks.getString(1)+"::"+rs_csquotes_blocks.getString(2)+"<BR>");
				line_block.addElement(rs_csquotes_blocks.getString(1));
				line_block_price.addElement(rs_csquotes_blocks.getString(2));
			}
		}
		rs_csquotes_blocks.close();
//out.println("Overage"+overage+"Tot Price"+price1);
int bcount=0;int grp_count=0;int grp_count1=0;String dim_unit="";String unit_price_new="";String line_tot_price="";
double unit_price1=0;int main_color=0;String qty_bpcs="";double tot_price1=0;String qty_origi="";
int count1=0;
String dimension="";String cuts_notches="";	String logo="";String template_art="";String texture_color="";
for(int ng=0;ng<desc_new_group.size();ng++){
	for (int n=0;n<desc_new_group_line.size();n++){
		if( (desc_new_group.elementAt(ng).toString().equals(desc_new_group_line.elementAt(n).toString()))) {
			if(bcount==0 || count1==0){
				out.println("<table width='100%' class='table_thin_borders' cellspacing='0' cellpadding='0' border='1'>");
				out.println("<tr height='20'>");
				out.println("<td width='5%' bgcolor='#006600' class='schedule'><b><u>Qty</u></b></td>");
				out.println("<td  bgcolor='#006600' class='schedule'><b><u>Description</u></b></td>");
				out.println("<td width='5%' bgcolor='#006600' class='schedule'><b><u>U/M</u></b></td>");
				if(type.equals("2")){
					out.println("<td width='7%' bgcolor='#006600' class='schedule'><b><u>Unit Price</u></b></td>");
					out.println("<td width='7%' bgcolor='#006600' class='schedule'><b><u>Total</u></b></td>");
				}
				out.println("</tr>");
				count1++;
			}
			for(int nl=0;nl<k_new;nl++){
				if((line_group_line.elementAt(n).toString().equals(line_no_new.elementAt(nl).toString())) ){
					if(grp_count==0){
						if( !((block_id.elementAt(nl).toString().trim().equals("A_APRODUCT"))|(block_id.elementAt(nl).toString().trim().equals("E_DIM"))) ){
							if( ((block_id.elementAt(nl).toString().startsWith("B_"))) ){
								double adders=0;
								double adders2=0;
								double adders3=0;
								for(int xl=0; xl<line_no_new.size(); xl++){
									if(desc_new.elementAt(nl).toString().equals(desc_new.elementAt(xl).toString()) && nl!=xl){
										//adders=adders+new Double(bpcs_qty.elementAt(xl).toString()).doubleValue();
										adders2=adders2+new Double(extended_price_new.elementAt(xl).toString()).doubleValue();
										adders3=adders3+new Double(bpcs_qty.elementAt(xl).toString()).doubleValue()*new Double(qty_new.elementAt(xl).toString()).doubleValue();
									}
								}
								BigDecimal d1 = new BigDecimal(extended_price_new.elementAt(nl).toString());// configured line price
								BigDecimal d2 = new BigDecimal(price1);//total quote price
								BigDecimal d3_o = new BigDecimal(overage);
								BigDecimal d3 = d1.divide(d2,BigDecimal.ROUND_HALF_UP);
								BigDecimal d4 = d3.multiply(d3_o);
								d4 = d4.setScale(0, BigDecimal.ROUND_HALF_UP);

								tot_price1=adders2+(new Double(extended_price_new.elementAt(nl).toString())).doubleValue()+d4.doubleValue();
								//out.println(qty_bpcs+"::"+qty_origi+"::0<BR>");
								if(bpcs_qty.elementAt(nl).toString().trim().length()<=0){qty_bpcs=""+new Double("1").doubleValue()+adders;}else{qty_bpcs=""+(new Double(bpcs_qty.elementAt(nl).toString()).doubleValue());}
								//out.println(qty_bpcs+"::"+qty_origi+"::1<BR>");
								if(qty_new.elementAt(nl).toString().trim().length()<=0){qty_origi="1";}else{qty_origi=qty_new.elementAt(nl).toString().trim();}
								adders3=adders3+(new Double(qty_bpcs).doubleValue()*new Double(qty_origi).doubleValue());
								//out.println(qty_bpcs+"::"+qty_origi+"::2<BR>");
								if ((main_color%2)==1){bgcolor="#EFEFDE";}else {bgcolor="#e4e4e4";}
								out.println("<tr>");
								out.println("<td valign='top' align='right' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for13x.format(adders3)+"</td>");
								out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+desc_new.elementAt(nl).toString()+"</td>");
								out.println("<td valign='top' align='left'  nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+bpcs_uom.elementAt(nl).toString()+"</td>");
								if(type.equals("2")){
									out.println("<td valign='top' align='right' nowrap nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+forge.format(tot_price1/(new Double(qty_bpcs)).doubleValue())+"</td>");
									out.println("<td valign='top' align='right' nowrap nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+forge.format(tot_price1)+"</td>");
								}
								out.println("</tr>");
								main_color++;
							}// If for the B_block done
							if( ((block_id.elementAt(nl).toString().startsWith("A_"))) ){
								//out.println("<tr><td colspan='3'>"+qty_new.elementAt(nl).toString()+"::"+bpcs_qty.elementAt(nl).toString()+"::</td></tr>");
								double adders=0;
								double adders2=0;
								double adders3=0;
								for(int xl=0; xl<line_no_new.size(); xl++){
									if(desc_new.elementAt(nl).toString().equals(desc_new.elementAt(xl).toString()) && nl!=xl){
										adders=adders+new Double(bpcs_qty.elementAt(xl).toString()).doubleValue();
										adders2=adders2+new Double(extended_price_new.elementAt(xl).toString()).doubleValue();
										adders3=adders3+new Double(bpcs_qty.elementAt(xl).toString()).doubleValue()*new Double(qty_new.elementAt(xl).toString()).doubleValue();

									}
								}

								BigDecimal d1 = new BigDecimal(line_block_price.elementAt(n).toString());// configured line price
								if(desc_new.elementAt(nl).toString().startsWith("HELIX")){
									d1=new BigDecimal(extended_price_new.elementAt(nl).toString());
								}
								BigDecimal d2 = new BigDecimal(price1);//total quote price
								BigDecimal d3_o = new BigDecimal(overage);
								BigDecimal d3 = d1.divide(d2,BigDecimal.ROUND_HALF_UP);
								BigDecimal d4 = d3.multiply(d3_o);
								d4 = d4.setScale(0, BigDecimal.ROUND_HALF_UP);
								tot_price1=adders2+(new Double(line_block_price.elementAt(n).toString())).doubleValue()+d4.doubleValue();
								if(desc_new.elementAt(nl).toString().startsWith("HELIX")){
									tot_price1=adders2+(new Double(extended_price_new.elementAt(nl).toString())).doubleValue()+d4.doubleValue();
								}
								if(bpcs_qty.elementAt(nl).toString().trim().length()<=0){qty_bpcs=""+new Double("1").doubleValue()+adders;}else{qty_bpcs=""+(new Double(bpcs_qty.elementAt(nl).toString()).doubleValue());}
								if(qty_new.elementAt(nl).toString().trim().length()<=0){qty_origi="1";}else{qty_origi=qty_new.elementAt(nl).toString().trim();}
								//out.println("<tr><td>"+adders3+"aaaa</td></tr>");
								adders3=adders3+(new Double(qty_bpcs).doubleValue()*new Double(qty_origi).doubleValue());
								//out.println("<tr><td>"+adders3+"bbbb"+qty_bpcs+"::"+qty_origi+"</td></tr>");
								if ((main_color%2)==1){bgcolor="#EFEFDE";}else {bgcolor="#e4e4e4";}
								out.println("<tr>");
								//out.println("<tr><td colspan='3'>"+qty_origi+"::"+qty_bpcs"::</td></tr>");
								out.println("<td valign='top' align='right' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for13x.format(adders3)+"</td>");
								out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+desc_new.elementAt(nl).toString()+"</td>");
								out.println("<td valign='top' align='left' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+bpcs_uom.elementAt(nl).toString()+"</td>");
								if(type.equals("2")){
									out.println("<td valign='top' align='right' nowrap nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+forge.format(tot_price1/(new Double(adders3)).doubleValue())+"</td>");
									out.println("<td valign='top' align='right' nowrap nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+forge.format(tot_price1)+"</td>");
								}
								out.println("</tr>");
								main_color++;
							}//If for the A_Block's done
						}
						if( block_id.elementAt(nl).toString().startsWith("D_NOTES") ){
							out.println("<tr>");
if(product.equals("GE")){
							if(type.equals("2")){
								out.println("<td>&nbsp;</td><td colspan='5' class='maindesc'>"+desc_new.elementAt(nl).toString());out.println("</td>");
							}
							else{
								out.println("<td>&nbsp;</td><td colspan='7' class='maindesc'>"+desc_new.elementAt(nl).toString());out.println("</td>");
							}
}
else{
							if(type.equals("2")){
								out.println("<td colspan='6' class='maindesc'>"+desc_new.elementAt(nl).toString());out.println("</td>");
							}
							else{
								out.println("<td colspan='8' class='maindesc'>"+desc_new.elementAt(nl).toString());out.println("</td>");
							}
}
							out.println("</tr>");
						}
						if( block_id.elementAt(nl).toString().startsWith("C_FINISHES") ){
							out.println("<tr>");
							if(type.equals("2")){
								out.println("<td colspan='6' class='maindesc'>Note: "+desc_new.elementAt(nl).toString());out.println("</td>");
							}
							else{
								out.println("<td colspan='8' class='maindesc'>Note: "+desc_new.elementAt(nl).toString());out.println("</td>");
							}
							out.println("</tr>");
						}
					}
				}
			}// the for loop
			out.println("</table>");
			//out.println("<tr><td colspan='8'>");
			out.println("<table cellpadding='0' class='table_thin_borders' cellspacing='0' border='1' width='100%'>");

			for(int nl=0;nl<k_new;nl++){
				if((line_group_line.elementAt(n).toString().equals(line_no_new.elementAt(nl).toString())) ) {
					if ((nl%2)==1){bgcolor="#EFEFDE";}else {bgcolor="#e4e4e4";	}
					if(grp_count1==0){
						if((block_id.elementAt(nl).toString().trim().equals("E_DIM")) ){
							out.println("<tr>");
							out.println("<td align='center' width='5%'  bgcolor='#C0C0C0' class='mainbodyh'><u>Mark</u></td>");
							out.println("<td align='center' width='15%'  bgcolor='#C0C0C0' class='mainbodyh'><u>Qty</u></td>");
							out.println("<td align='center' width='15%'  bgcolor='#C0C0C0' class='mainbodyh'><u>Size W x L (TD)</u></td>");
							out.println("<td align='center' width='16%'  bgcolor='#C0C0C0' class='mainbodyh'><u>Cuts/Notches</u></td>");
							out.println("<td align='center' width='17%'  bgcolor='#C0C0C0' class='mainbodyh'><u>Logo</u></td>");
							out.println("<td align='center' width='16%'  bgcolor='#C0C0C0' class='mainbodyh'><u>Template/Art Work</u></td>");
							out.println("<td align='center' width='16%'  bgcolor='#C0C0C0' class='mainbodyh'><u>Texture/Color</u></td>");
							out.println("</tr>");
							String dim=(desc_new.elementAt(nl)).toString();
							int n_s=dim.indexOf("@");
							int n_s1=dim.indexOf("@",n_s+1);
							int n_s2=dim.indexOf("@",n_s1+1);
							int n_s3=dim.indexOf("@",n_s2+1);
							dimension=dim.substring(0,n_s);
							cuts_notches=dim.substring(n_s+1,n_s1);
							logo=dim.substring(n_s1+1,n_s2);
							template_art=dim.substring(n_s2+1,n_s3);
							texture_color=dim.substring(n_s3+1,dim.length());
							if (dimension.equals("")){dimension="-";}
							if (cuts_notches.equals("")){cuts_notches="-NONE-";}
							if (logo.equals("")){logo="-NONE-";}
							if (template_art.equals("")){template_art="-NONE-";}
							if (texture_color.equals("")){texture_color="-STD-";}
							out.println("<tr>");
							out.println("<td valign='top' nowrap width='5%' bgcolor='#f1f1f1' class='maindesc'>"+mark_iwp.elementAt(nl).toString()+"</td>");
							out.println("<td valign='top' nowrap width='15%' bgcolor='#f1f1f1' class='maindesc'>"+qty_new.elementAt(nl).toString()+"</td>");
							out.println("<td valign='top' nowrap width='15%' bgcolor='#f1f1f1' class='maindesc'>"+dimension+"</td>");
							out.println("<td valign='top' nowrap width='16%' bgcolor='#f1f1f1' class='maindesc'>"+cuts_notches+"</td>");
							out.println("<td valign='top' nowrap width='17%' bgcolor='#f1f1f1' class='maindesc'>"+logo+"</td>");
							out.println("<td valign='top' nowrap width='16%' bgcolor='#f1f1f1' class='maindesc'>"+template_art+"</td>");
							out.println("<td valign='top' nowrap width='16%' bgcolor='#f1f1f1' class='maindesc'>"+texture_color+"</td>");
							out.println("</tr>");
							out.println("<tr>");
							out.println("<td width='100%' height='5' colspan='7'>&nbsp;</td>");
							out.println("</tr>");
						}
					}
					else{
						if((block_id.elementAt(nl).toString().trim().equals("E_DIM")) ){
							String dim=(desc_new.elementAt(nl)).toString();
							int n_s=dim.indexOf("@");
							int n_s1=dim.indexOf("@",n_s+1);
							int n_s2=dim.indexOf("@",n_s1+1);
							int n_s3=dim.indexOf("@",n_s2+1);
							dimension=dim.substring(0,n_s);
							cuts_notches=dim.substring(n_s+1,n_s1);
							logo=dim.substring(n_s1+1,n_s2);
							template_art=dim.substring(n_s2+1,n_s3);
							texture_color=dim.substring(n_s3+1,dim.length());
							if (dimension.equals("")){dimension="-";}
							if (cuts_notches.equals("")){cuts_notches="-NONE-";}
							if (logo.equals("")){logo="-NONE-";}
							if (template_art.equals("")){template_art="-NONE-";}
							if (texture_color.equals("")){texture_color="-STD-";}
							out.println("<tr>");
							out.println("<td valign='top' nowrap width='5%' bgcolor='#f1f1f1' class='maindesc'>"+mark_iwp.elementAt(nl).toString()+"</td>");
							out.println("<td valign='top' nowrap width='15%' bgcolor='#f1f1f1' class='maindesc'>"+qty_new.elementAt(nl).toString()+"</td>");
							out.println("<td valign='top' nowrap width='15%' bgcolor='#f1f1f1' class='maindesc'>"+dimension+"</td>");
							out.println("<td valign='top' nowrap width='16%' bgcolor='#f1f1f1' class='maindesc'>"+cuts_notches+"</td>");
							out.println("<td valign='top' nowrap width='17%' bgcolor='#f1f1f1' class='maindesc'>"+logo+"</td>");
							out.println("<td valign='top' nowrap width='16%' bgcolor='#f1f1f1' class='maindesc'>"+template_art+"</td>");
							out.println("<td valign='top' nowrap width='16%' bgcolor='#f1f1f1' class='maindesc'>"+texture_color+"</td>");
							out.println("</tr>");
							out.println("<tr>");
							out.println("<td width='100%' height='5' colspan='7'>&nbsp;</td>");
							out.println("</tr>");
						}
					}
				}
			}//inner for
			out.println("</table><table width='100%' class='table_thin_borders' cellspacing='0' cellpadding='0' border='1'>");
			grp_count++;grp_count1++;dim_unit="";unit_price_new="";line_tot_price="";dimension="";cuts_notches="";logo="";template_art="";texture_color="";
		}//IF LOOP
		bcount++;
	}//INSIDE FOR
	grp_count=0;grp_count1=0;bcount=0;
}//OUT SIDE FOR
%>

</table>
