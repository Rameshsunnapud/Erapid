<%

out.println("<tr>");
out.println("<td width='30%' height='30%' class='test1' bordercolor='#C0C0C0'>"+"&nbsp; Order Information: "+"<td>");
out.println("<td width='70%' height='30%' bordercolor='#C0C0C0'>"+"&nbsp;"+"<td>");
out.println("</tr>");
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
out.println("<td width='100%' height='30%'  bordercolor='#C0C0C0'>");
out.println("<table width='100%' border='1' cellspacing='0' cellpadding='0' class='tb'>");
out.println("<tr>");
out.println("<td align='center' height='30' class='tdheader2'>QTY</td>");
out.println("<td align='center' height='30' class='tdheader2'>MODEL# </td>");
out.println("<td align='center' height='30' class='tdheader2'>SIZE</td>");
out.println("<td align='center' height='30' class='tdheader2'>SCREEN</td>");
out.println("<td align='center' height='30' class='tdheader2'>FINISH</td>");
//out.println("<td align='center' height='30' class='tdheader2'>BLANK 9</td>");
//out.println("<td align='center' height='30' class='tdheader2'>TEXTURE/COLOR</td>");
//out.println("<td align='center' height='30' class='tdheader2'>UNIT PRICE</td>");
out.println("<td align='center' height='30' class='tdheader2'>EXT. PRICE</td>");
out.println("</tr>");
String dimension="";String cuts_notches="";	String logo="";String template_art="";String texture_color="";
String schedule="";double com_perc=0;double l_cost1=0.0;String stdcost="";String runcost="";String setupcost="";double t_cost=0.0;

// for the schdule
										for(int k=0;k<line;k++){
											
				//out.println("QTY1"+QTY.elementAt(k)+"<br>");
							String bgcolor="";
							if ((k%2)==1){bgcolor="white";}else {bgcolor="#E7E7E7";}
							for (int mn=0;mn<line_item.size();mn++){
								
							if ((line_item.elementAt(mn).toString()).equals((items.elementAt(k).toString()))){
							quan=QTY.elementAt(mn).toString();//QTY
							if ((block_id.elementAt(mn).toString()).equals("A_APRODUCT")){
								//out.println("block_id.elementAt(mn).toString()-----------------------------: "+block_id.elementAt(mn).toString());
							description=(desc.elementAt(mn)).toString();
					// for the costs
							stdcost=std_cost.elementAt(mn).toString();
							runcost=run_cost.elementAt(mn).toString();
							setupcost=setup_cost1.elementAt(mn).toString();
							BigDecimal d1 = new BigDecimal(stdcost);
							BigDecimal d2 = new BigDecimal(runcost);
							BigDecimal d3 = new BigDecimal(setupcost);
						    l_cost1=d1.doubleValue()+d2.doubleValue()+d3.doubleValue();
							//System.out.println("---------- "+l_cost1);
							
							t_cost=d1.doubleValue()+d2.doubleValue()+d3.doubleValue()+(l_cost/line);
							totprice=t_cost/sp_factor;
							totprice_dis=totprice_dis+totprice;
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
							//out.println("Quantity"+quan+" MODEL#"+description+" Cuts size "+dimension);
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

out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+">&nbsp;"+quan+"</td>");
out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+">&nbsp;"+description+"</td>");
out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+"> &nbsp;"+dimension+"</td>");
out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+"> &nbsp;"+cuts_notches+"</td>");
out.println("<td align='center' nowrap class='tdheader2' bgcolor="+bgcolor+"> &nbsp;"+logo+"</td>");
//out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+"> &nbsp;"+template_art+"</td>");
//out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+">&nbsp;"+texture_color+" </td>");
//out.println("<td>&nbsp;</td>");
out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+">&nbsp;"+for1.format(totprice)+"</td>");
out.println("</tr>");

//intializing the values
totprice=0;
imp.clear();
dimension="";cuts_notches="";logo="";template_art="";texture_color="";schedule="";
                      }
    }
	
 else{
 out.println("<Tr><TD><BR>PER QUOTE : "+order_no +"<BR><BR><td></tr>");

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

// Next row
        out.println("<tr>");
        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tddashtop' colspan='6'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
		totprice_dis=totprice_dis+(new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(setup_cost).doubleValue())+(new Double(freight_cost).doubleValue());
        out.println("<td class='tdnodash' width='33%'>TOTAL PRICE($):&nbsp;<b>"+for1.format(totprice_dis)+"</b></td>");
        out.println("<td class='tdnodash' width='33%'>STD.COMISSION:&nbsp;<b>"+for1.format(totcomm_dol)+"</b></td>");
		out.println("<td class='tdnodash' width='33%'>OVERAGE AMOUNT($):&nbsp;<b>"+for1.format(new Double(overage).doubleValue())+"</b></td>");
		out.println("</tr>");
		out.println("</table></td>");
		out.println("</tr>");
		out.println("<tr>");
        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tdsolid' colspan='6'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
        out.println("<td class='tdnodash' width='25%'>HANDLING CHARGES:&nbsp;<b>"+for1.format(new Double(handling_cost).doubleValue())+"</b></td>");
        out.println("<td class='tdnodash' width='25%'>SETUP COST($):&nbsp;<b>"+for1.format(new Double(setup_cost).doubleValue())+"</b></td>");
		out.println("<td class='tdnodash' width='25%'>EXTRA CHARGES:&nbsp;<b>"+for1.format(new Double(freight_cost).doubleValue())+"</b></td>");
		out.println("<td class='tdnodash' width='25%'>STD COMISSION(%):&nbsp;<b>"+commission+"</b></td>");
		out.println("</tr>");
		out.println("</table></td>");
		out.println("</tr>");

out.println("<tr>");
out.println("<td align='center' width='100%' height='30' class='tdheader' colspan='6'>"+"&nbsp;"+"</td>");
out.println("</tr>");



%>
