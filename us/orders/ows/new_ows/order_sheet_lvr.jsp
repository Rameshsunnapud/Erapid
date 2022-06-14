<%

out.println("<tr><td align='left'><div id='sideHead'><p style='font-size:14px;color:black;margin-top:20px;font-stretch:expanded;'><b>LVR ORDER INFORMATION</b></p></div></td><td colspan='8' align='right' height='10%' class='tdOrder' bordercolor='#C0C0C0'>&nbsp;</td></tr>");
out.println("<tr><td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td></tr>");
//Global
int tot_lines=0;double totprice=0;double factor=0.0;double totprice_dis=0;String description="";
Vector QTY=new Vector();
Vector price=new Vector();
Vector line_item=new Vector();
Vector desc=new Vector();
Vector rec_no=new Vector();
Vector fact_per=new Vector();
Vector mark=new Vector();
Vector block_id=new Vector();
Vector imp=new Vector();Vector run_cost=new Vector();Vector std_cost=new Vector();Vector setup_cost1=new Vector();
String quan="";
//Getting the order information
ResultSet rs3 = stmt.executeQuery("SELECT * FROM csquotes where order_no like '"+order_no+"' order by cast(Line_no as integer)");
while ( rs3.next() ) {
line_item.addElement(rs3.getString ("Line_no"));
desc.addElement(rs3.getString ("Descript"));
price.addElement(rs3.getString ("Extended_Price"));
QTY.addElement(rs3.getString("QTY"));
block_id.addElement(rs3.getString("Block_ID"));
fact_per.addElement(rs3.getString("field16"));
run_cost.addElement(rs3.getString("run_cost"));
std_cost.addElement(rs3.getString("std_cost"));
setup_cost1.addElement(rs3.getString("setup_cost"));
tot_lines++;
						 }

if(project_type==null){
	project_type="";
}

if( ! (project_type.equals("PSA")||project_type.equals("SFDC"))){
out.println("<tr>");


out.println("<td align='left' class='tdOrder' colspan='1'><b>MODEL</b></td>");
out.println("<td align='left' class='tdOrder'><b>QTY</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
			out.println("<b>SIZE</b></td>");
			out.println("<td align='left' class='tdOrder'><b>SCREEN</b></td>");
			out.println("<td align='center' class='tdOrder'><b>FINISH</b></td>");
			out.println("<td align='left' class='tdOrder'><b>EXT. PRICE</b></td>");





out.println("</tr>");
String dimension="";String cuts_notches="";	String logo="";String template_art="";String texture_color="";
String schedule="";double com_perc=0;String stdcost="";String runcost="";String setupcost="";double t_cost=0.0;
// for the schdule
										for(int k=0;k<line;k++){
							String bgcolor="";
							if ((k%2)==1){bgcolor="white";}else {bgcolor="#E7E7E7";}
							for (int mn=0;mn<line_item.size();mn++){
							if ((line_item.elementAt(mn).toString()).equals((items.elementAt(k).toString()))){
							quan=QTY.elementAt(mn).toString();//QTY
							if ((block_id.elementAt(mn).toString()).equals("A_APRODUCT")){
							description=(desc.elementAt(mn)).toString();
					// for the costs
							stdcost=std_cost.elementAt(mn).toString();
							runcost=run_cost.elementAt(mn).toString();
							setupcost=setup_cost1.elementAt(mn).toString();
							BigDecimal d1 = new BigDecimal(stdcost);
							BigDecimal d2 = new BigDecimal(runcost);
							BigDecimal d3 = new BigDecimal(setupcost);
						    double l_cost1=d1.doubleValue()+d2.doubleValue()+d3.doubleValue();
							out.println("<BR>"+l_cost+"/"+line+"THe total costs: "+l_cost1);
							t_cost=d1.doubleValue()+d2.doubleValue()+d3.doubleValue()+(l_cost/line);
							out.println("<BR>t_cost "+t_cost);
							totprice=t_cost/sp_factor;
							out.println("<BR>totprice "+totprice);
							out.println("<BR>totprice_dis 1 "+totprice_dis);
							totprice_dis=totprice_dis+totprice;
							out.println("<BR>totprice_dis 2 "+totprice_dis);
						    factor = (((totprice_dis+(new Double(freight_cost).doubleValue()))*0.91)*new Double(commission).doubleValue())/100;// total comission dollars for the line
// has been changed on May 26 05 to below
//						    factor = (((totprice)*0.91)*new Double(commission).doubleValue())/100;// total comission dollars for the line
							totcomm_dol=factor;
                            }

/*							if ((block_id.elementAt(mn).toString()).endsWith("PRICES")){
							String field_16=(fact_per.elementAt(mn)).toString().trim();
							if (prio.equals("E")){
							BigDecimal d4 = new BigDecimal(field_16);
							com_perc=((d4.doubleValue()*100));
							}
							else{
							BigDecimal d4 = new BigDecimal(field_16);
							BigDecimal d6 = new BigDecimal("0.91");
							BigDecimal d5 = d4.divide(d6,0);
							com_perc=((d5.doubleValue()*100));
							}
//							out.println("The field16 "+field_16+"sdasds"+(d5.doubleValue()*100));
                            }*/

							if ((block_id.elementAt(mn).toString()).equals("E_DIM")){
							String dim=(desc.elementAt(mn)).toString();
							int n_s=dim.indexOf("@");
//							if (n_s >=0 ){
							int n_s1=dim.indexOf("@",n_s+1);
							int n_s2=dim.indexOf("@",n_s1+1);
							int n_s3=dim.indexOf("@",n_s2+1);
//							int n_s4=dim.indexOf("@",n_s3+1);
							dimension=dim.substring(0,n_s);
							cuts_notches=dim.substring(n_s+1,n_s1);
							logo=dim.substring(n_s1+1,n_s2);
							template_art=dim.substring(n_s2+1,n_s3);
							texture_color=dim.substring(n_s3+1,dim.length());
							if (cuts_notches.equals("")){cuts_notches="-NONE-";}
							if (logo.equals("")){logo="-NONE-";}
							if (template_art.equals("")){template_art="-NONE-";}
							if (texture_color.equals("")){texture_color="-STD-";}
/*							out.println("The token 1 "+dimension+"no"+n_s+"<br>");
							out.println("The token 2"+cuts_notches+"no"+n_s1+"<br>");
							out.println("The token 3"+logo+"no"+n_s2+"<br>");
							out.println("The token 4"+template_art+"no"+n_s3+"<br>");
							out.println("The token 5"+texture_color+"no"+dim.length()+"<br>");*/
																		   }
																								  }
																}
/*out.println("<tr>");
out.println("<td align='left' colspan='5' bgcolor="+bgcolor+" class='tdheader2'>&nbsp;"+schedule+"</td>");
out.println("</tr>");
*/










out.println("<tr>");
out.println("<td align='left' class='tdOrder' colspan='1'>&nbsp;"+description.trim()+"</td>");
out.println("<td align='left' class='tdOrder'>&nbsp;"+quan+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");

out.println("&nbsp;"+dimension+"</td><td align='left' class='tdOrder'>"+cuts_notches+"</td>");
out.println("<td align='center' class='tdOrder'>&nbsp;"+logo+"</td>");
//out.println("<td align='center' nowrap class='tdheader2' bgcolor="+bgcolor+"> &nbsp;"+logo+"</td>");
//out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+"> &nbsp;"+template_art+"</td>");
//out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+">&nbsp;"+texture_color+" </td>");
//out.println("<td>&nbsp;</td>");
out.println("<td align='left' class='tdOrder'>&nbsp;"+for1.format(totprice)+"</td>");
//out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+">&nbsp;"+for1.format(totprice)+"</td>");
out.println("</tr>");
//intializing the values
totprice=0;
imp.clear();
dimension="";cuts_notches="";logo="";template_art="";texture_color="";schedule="";
                      }
    }
 else{
 //out.println("<Tr><TD><BR>PER QUOTE : "+order_no +"<BR><BR><td></tr>");
 //out.println("<tr>");
		//out.println("<td align='right' class='tdOrder' >PER QUOTE&nbsp&nbsp:&nbsp&nbsp</td>");
		//out.println("<td align='left' class='tdOrder' ><b>"+order_no+"</b></td></tr>");

 ResultSet rs_customer1 = stmt.executeQuery("SELECT * FROM  CS_ACCESS_CENTRAL where order_no like '"+order_no+"'");
	if (rs_customer1 !=null) {
		while ( rs_customer1.next() ) {
			totprice_dis=rs_customer1.getDouble("pinftotal");

			totcomm_dol=rs_customer1.getDouble("pinfSTDCommdollars");
		}
	}

 rs_customer1.close();


 }
//out.println("</table>");
//out.println("<td>");
//out.println("</tr>");

NumberFormat for12 = NumberFormat.getInstance();
for12.setMaximumFractionDigits(1);

if(!(project_type != null && project_type.equals("SFDC") &&userGroup.toUpperCase().startsWith("REP") )){
// Next row
out.println("<tr><td align='left'><div id='sideHead'><p style='font-size:14px;color:black;margin-top:20px;font-stretch:expanded;'><b>PRICE SUMMARY</b></p></div></td><td colspan='8' align='right' height='10%' class='tdOrder' bordercolor='#C0C0C0'>&nbsp;</td></tr>");
out.println("<tr><td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td></tr>");
		//totprice_dis=totprice_dis+(new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(setup_cost).doubleValue())+(new Double(freight_cost).doubleValue());
		out.println("<tr>");
		out.println("<td align='right' class='tdOrder'>TOTAL MATERIAL PRICE($)&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder' ><b>"+for1.format(totprice_dis)+"</b></td>");
		out.println("<td align='right' class='tdOrder' >STD.COMISSION&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder' ><b>"+for1.format(totcomm_dol)+"</b></td>");
		
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td align='right' class='tdOrder' >OVERAGE AMOUNT($)&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder' ><b>"+for1.format(new Double(overage).doubleValue())+"</b></td>");
		
		out.println("<td align='right' class='tdOrder'>HANDLING CHARGES&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder'><b>"+for1.format(new Double(handling_cost).doubleValue())+"</b></td>");
		out.println("</tr>");
				out.println("<tr>");
		out.println("<td align='right' class='tdOrder' >SETUP COST($)&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder' ><b>"+for1.format(new Double(setup_cost).doubleValue())+"</b></td>");
		out.println("<td align='right' class='tdOrder'>EXTRA CHARGES&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder' ><b>"+for1.format(new Double(freight_cost).doubleValue())+"</b></td>");
		out.println("</tr>");


out.println("<tr>");
		out.println("<td align='right' class='tdOrder'>STD COMISSION(%)&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder'><b>"+commission+"</b></td>");
		//out.println("<td align='right' class='tdOrder' >Tax&nbsp&nbsp:&nbsp&nbsp</td>");
		//for1.setMaximumFractionDigits(2);
		//out.println("<td align='left' class='tdOrder' ><b>"+for1.format(tax_dollar)+"</b></td>");
		out.println("</tr>");
		/*out.println("<tr>");
out.println("<td align='right' class='tdOrder'>GRAND TOTAL&nbsp;&nbsp;:&nbsp;&nbsp;</td>");

		out.println("<td align='left' class='tdOrder' ><b>"+for1.format(grandTotal)+"</b></td>");
out.println("<td align='center' width='100%' height='30' class='tdheader' colspan='6'>"+"&nbsp;"+"</td>");
out.println("</tr>");*/
		//out.println("</table></td>");
		//out.println("</tr>");

out.println("<tr>");
out.println("<td align='center' width='100%' height='30' class='tdheader' colspan='6'>"+"&nbsp;"+"</td>");
out.println("</tr>");
}
if(project_type != null && project_type.equals("SFDC") && userGroup.toUpperCase().startsWith("REP") ){
out.println("<tr>");
		out.println("<td align='right' class='tdOrder' >PER QUOTE&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder' ><b>"+order_no+"</b></td>");
		out.println("<td align='right' class='tdOrder'>TOTAL MATERIAL PRICE($)&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
		out.println("<td align='left' class='tdOrder'><b>"+for1.format(totprice_dis)+"</b></td>");
		out.println("</tr>");
		//out.println("<Tr><TD><BR>PER QUOTE : "+order_no +"<BR><BR><td></tr>");
}
%>
