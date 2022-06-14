<%

if(numberOfSections>1){
	boolean isBadd=false;
	String bAdderString="";
	for(int j=0;j< numberOfSections; j++){

		String overageTEMP=overage;
		String setupTEMP=setup_cost;
		String freightTEMP=freight_cost;
		String handlingTEMP=handling_cost;
		double sectionSUM=0;
		double secSUM=0;
		//out.println(totprice_dis+"::"+overage+"::"+setup_cost+"::"+freight_cost+"::"+handling_cost+" BEFORE <BR>");
	for(int aa=0; aa<price.size(); aa++){
		//out.println(secLINES.elementAt(j).toString()+"::"+price.elementAt(aa).toString()+"<BR>");
		if(secLINES.elementAt(j).toString().indexOf(","+line_item.elementAt(aa).toString()+",")>=0){
			secSUM=new Double(price.elementAt(aa).toString()).doubleValue()+secSUM;
		}
	}
	//out.println(secSUM+":: HERE<BR>");
	if(isOVERAGE){
		if(sectionOVERAGE.elementAt(j).toString()!= null && sectionOVERAGE.elementAt(j).toString().trim().length()>0){
			overage=sectionOVERAGE.elementAt(j).toString();
		}
		else{
			overage="0";
		}
	}
	else{
		overage=""+new Double(overage).doubleValue()*(secSUM/new Double(tot_sum).doubleValue());
	}
	if(isFREIGHT){
		if(sectionFREIGHT.elementAt(j).toString()!= null && sectionFREIGHT.elementAt(j).toString().trim().length()>0){
			freight_cost=sectionFREIGHT.elementAt(j).toString();
		}
		else{
			freight_cost="0";
		}
	}
	else{
		freight_cost=""+new Double(freight_cost).doubleValue()*(secSUM/new Double(tot_sum).doubleValue());
	}
	//out.println(setup_cost+"::HERE2<BR>");
	if(isSETUP){
		if(sectionSETUP.elementAt(j).toString()!= null && sectionSETUP.elementAt(j).toString().trim().length()>0){
			setup_cost=sectionSETUP.elementAt(j).toString();
		}
		else{
			setup_cost="0";
		}
	}
	else{
		//out.println("HEREx<BR>");
		if(setup_cost != null && setup_cost.trim().length()>0){
			//out.println("HERE greg" + setup_cost+"::"+secSUM+"::"+tot_sum+"<BR>");
			setup_cost=""+new Double(setup_cost).doubleValue()*(secSUM/new Double(tot_sum).doubleValue());
		}
		else{
			setup_cost="0";
		}
	}
	//out.println(setup_cost+"::HERE r<BR>");
	if(isHANDLING){
		if(sectionHANDLING.elementAt(j).toString()!= null && sectionHANDLING.elementAt(j).toString().trim().length()>0){
			handling_cost=sectionHANDLING.elementAt(j).toString();
		}
		else{
			handling_cost="0";
		}
	}
	else{
		handling_cost=""+new Double(handling_cost).doubleValue()*(secSUM/new Double(tot_sum).doubleValue());
	}
	//tot_sum=0;

%>


		<font class='mainbodyh'><B>QUOTE SUMMARY ::</B><br><br></font>
		<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'>
		<tr height='20'>
		<td width='3%' bgcolor='#006600'><font class='schedule'></font></td>
		<td width='10%' bgcolor='#006600'><font class='schedule'><b>Mark</b></font></td>
		<td width='35%' bgcolor='#006600'><font class='schedule'><b>Model</b></font></td>
		<td width='5%' bgcolor='#006600'><font class='schedule'><b>Qty</b></font></td>
		<!--<td width='13%' bgcolor='#006600'><font class='schedule'><b>Gasket Color</b></font></td>-->
		<td width='6%' bgcolor='#006600'><font class='schedule'><b>Price</b></font></td>
		<td width='11%' bgcolor='#006600'><font class='schedule'><b>Line Overage</b></font></td>
		<td width='10%' bgcolor='#006600'><font class='schedule'><b>Total Line Price</b></font></td>
		<td width='11%' bgcolor='#006600'><font class='schedule'><b>Discount</b></font></td>
		<td width='18%' bgcolor='#006600'><font class='schedule'><b>Comission </b></font></td>
		</tr>
		<%
		//out.println("The Overage"+overage);
		String gas_color="NONE";String discount_show="";String line_no="";
					for(int k=0;k<line;k++){
					//out.println(items.elementAt(k).toString()+"::"+secLINES.elementAt(j).toString()+":<BR>");
					if(secLINES.elementAt(j).toString().indexOf(","+items.elementAt(k).toString()+",")>=0){
						String bgcolor="";
						if ((k%2)==1){bgcolor="#e4e4e4";}else {bgcolor="#EFEFDE";}
						for (int mn=0;mn<line_item.size();mn++){
							if ((line_item.elementAt(mn).toString()).equals((items.elementAt(k).toString()))){
								if(block_id.elementAt(mn).toString().equals("B_ADDERS")){
								//	out.println(price.elementAt(mn).toString()+"::<BR>");
									isBadd=true;
									//bAddLine=mn;
									bAdderString=desc.elementAt(mn).toString();
								}
								//out.println(block_id.elementAt(mn).toString()+":::<BR>");
								if (block_id.elementAt(mn).toString().equals("A_APRODUCT") & block_id.elementAt(mn).toString().equals("PRICING")){
									line_no=line_item.elementAt(mn).toString();
									description=(desc.elementAt(mn)).toString();
									mark=(mark_no.elementAt(mn)).toString();
									if (!(discount.elementAt(mn)==null)){
										discount_show=discount.elementAt(mn).toString().trim();//FIELD19
										if (discount.elementAt(mn).toString().trim().length()>0){
											discount_show=discount.elementAt(mn).toString().trim();
										}
										else{discount_show="BOOK";}
									}
									else{
										discount_show="";
									}
					    			}
								out.println("Testing");
		//						and Block_ID='PRICING' AND Sequence_no='0.00'
								if( (((block_id.elementAt(mn).toString()).equals("PRICING"))&((seq_no.elementAt(mn).toString()).equals("0.00")))||block_id.elementAt(mn).toString().equals("B_ADDERS"))	{// then new if block specific to EJC
									String totwt=price.elementAt(mn).toString();//Extended_Price
									String fact=fact_per.elementAt(mn).toString().trim();//FIELD16
									quan=QTY.elementAt(mn).toString();//QTY
									if ((fact.equals(""))){fact="0.0"; }
									BigDecimal d1 = new BigDecimal(totwt);
								      	BigDecimal d2 = new BigDecimal(fact);
									BigDecimal d3 = d1.multiply(d2);
		//							d3 = d3.setScale(0, BigDecimal.ROUND_HALF_UP);
		out.println("Testing");
								      	factor = factor+d3.doubleValue();// total comission dollars for the line
									totprice=totprice+d1.doubleValue();//just the materail price no comission for the line
									totprice_dis=totprice_dis+d1.doubleValue();//Total material price for the job
									totcomm_dol= totcomm_dol+d3.doubleValue();// final commission dollars for the job
									if (((block_id.elementAt(mn).toString()).startsWith("PRICI"))&(!(((fact_per.elementAt(mn)).toString()).trim().equals("")))){
										String field_16=(fact_per.elementAt(mn)).toString().trim();
										//if (prio.equals("E")){
											//BigDecimal d4 = new BigDecimal(field_16);
											//com_perc=((d4.doubleValue()*100));
										//}
										//else{
											BigDecimal d4 = new BigDecimal(field_16);
											BigDecimal d6 = new BigDecimal("0.91");
											BigDecimal d5 = d4.divide(d6,0);
											com_perc=((d5.doubleValue()*100));
										//}
					    				}

									// Gasket Color
									if ((rec_no.elementAt(mn).toString()).equals("17622")){
										gas_color=(desc.elementAt(mn).toString()).substring(((desc.elementAt(mn).toString()).indexOf("Gasket Color - "))+15);
									}
									//Gasket Color

								}// then new if block specific to EJC
							}
						   }
		//		double price_sqft= totprice/new Double(area).doubleValue();
			out.println("<tr><td width='3%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+line_no+"</td>");
			out.println("<td width='10%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+mark+"</td>");
			out.println("<td width='25%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+description+"</td>");
			out.println("<td valign='top' width='6%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+quan+"</td>");
			//out.println("<td valign='top' width='6%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+gas_color+"</td>");
	//out.println(totprice+"::"+tot_sum+":: HERE");
			out.println("<td valign='top' width='10%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(totprice)+"</td>");
			out.println("<td valign='top' width='10%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format((totprice/secSUM)*new Double(overage).doubleValue())+"</td>");
			out.println("<td valign='top' width='10%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(totprice+((totprice/secSUM)*new Double(overage).doubleValue()))+"</td>");
			out.println("<td valign='top' width='50%'bgcolor='"+bgcolor+"' class='maindesc'>"+discount_show+"</td>");
			out.println("<td valign='top' width='50%'bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(factor)+"</td>");
			out.println("</tr>");
		factor=0;totprice=0;gas_color="NONE";discount_show="";


		if (isBadd){
					out.println("<tr><td width='17%' valign='top' bgcolor='"+bgcolor+"' align='center' class='maindesc' colspan='13'><b>"+bAdderString+"</b></td></tr>");
					isBadd=false;
		}







				}
				}

























		//tot_sum=sectionSUM;












		if( (!(( product.equals("EJC")|product.equals("IWP")|product.equals("EFS")) & (st.equals("2")|st.equals("3"))) )){%><%@ include file="show_summary_foot.jsp"%><%}
//out.println(overage+"::"+setup_cost+"::"+freight_cost+"::"+handling_cost+" before <BR>");
		overage=overageTEMP;
		setup_cost=setupTEMP;
		freight_cost=freightTEMP;
		handling_cost=handlingTEMP;
		//out.println(tot_sum+"<BR>");
		totprice_dis=0;
		//out.println(overage+"::"+setup_cost+" x ::"+freight_cost+"::"+handling_cost+" after <BR>");
		 %>

		</table>
		<br><br>


<%


	}














}
else{
	%>
	<font class='mainbodyh'><B>QUOTE SUMMARY ::</B><br><br></font>
	<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'>
	<tr height='20'>
	<td width='3%' bgcolor='#006600'><font class='schedule'></font></td>
	<td width='10%' bgcolor='#006600'><font class='schedule'><b>Mark</b></font></td>
	<td width='35%' bgcolor='#006600'><font class='schedule'><b>Model</b></font></td>
	<td width='5%' bgcolor='#006600'><font class='schedule'><b>Qty</b></font></td>
	<!--<td width='13%' bgcolor='#006600'><font class='schedule'><b>Gasket Color</b></font></td>-->
	<td width='6%' bgcolor='#006600'><font class='schedule'><b>Price</b></font></td>
	<td width='11%' bgcolor='#006600'><font class='schedule'><b>Line Overage</b></font></td>
	<td width='10%' bgcolor='#006600'><font class='schedule'><b>Total Line Price</b></font></td>
	<td width='11%' bgcolor='#006600'><font class='schedule'><b>Discount</b></font></td>
	<td width='18%' bgcolor='#006600'><font class='schedule'><b>Comission </b></font></td>
	</tr>
	<%
	boolean isBadd=false;
	String bAdderString="";
	//out.println("The Overage"+overage);
	String gas_color="NONE";String discount_show="";String line_no="";
	for(int k=0;k<line;k++){

		String bgcolor="";
		if ((k%2)==1){bgcolor="#e4e4e4";}else {bgcolor="#EFEFDE";}
		for (int mn=0;mn<line_item.size();mn++){

			//out.println("<tr><td colspan='8'>"+block_id.elementAt(mn).toString()+"::</td></tr>");

			if ((line_item.elementAt(mn).toString()).equals((items.elementAt(k).toString()))){
				//out.println(block_id.elementAt(mn).toString()+"::<BR>");
				if ((block_id.elementAt(mn).toString()).equals("A_APRODUCT")){
					line_no=line_item.elementAt(mn).toString();
					description=(desc.elementAt(mn)).toString();
					mark=(mark_no.elementAt(mn)).toString();
					if (!(discount.elementAt(mn)==null)){
						discount_show=discount.elementAt(mn).toString().trim();//FIELD19
						if (discount.elementAt(mn).toString().trim().length()>0){
							discount_show=discount.elementAt(mn).toString().trim();
						}
						else{discount_show="BOOK";}
					}
					else{
						discount_show="";
					}
				}
				if( !((block_id.elementAt(mn).toString()).equals("A_APRODUCT")))	{
					if(block_id.elementAt(mn).toString().equals("B_ADDERS")){
						isBadd=true;
						//bAddLine=mn;
						bAdderString=desc.elementAt(mn).toString();
					}
				}
				if( (((block_id.elementAt(mn).toString()).equals("PRICING"))&(!(price.elementAt(mn).toString()).equals("0.00")))||block_id.elementAt(mn).toString().equals("B_ADDERS"))	{// then new if block specific to EJC
					String totwt=price.elementAt(mn).toString();//Extended_Price
					String fact=fact_per.elementAt(mn).toString().trim();//FIELD16
					quan=QTY.elementAt(mn).toString();//QTY
					if ((fact.equals(""))){fact="0.0"; }
					BigDecimal d1 = new BigDecimal(totwt);
					BigDecimal d2 = new BigDecimal(fact);
					BigDecimal d3 = d1.multiply(d2);
					factor = factor+d3.doubleValue();// total comission dollars for the line
					totprice=totprice+d1.doubleValue();//just the materail price no comission for the line
					totprice_dis=totprice_dis+d1.doubleValue();//Total material price for the job
					totcomm_dol= totcomm_dol+d3.doubleValue();// final commission dollars for the job
					if (((block_id.elementAt(mn).toString()).startsWith("PRICI"))&(!(((fact_per.elementAt(mn)).toString()).trim().equals("")))){
						String field_16=(fact_per.elementAt(mn)).toString().trim();
/* 						if (prio.equals("E")){
							BigDecimal d4 = new BigDecimal(field_16);
							com_perc=((d4.doubleValue()*100));
						}
						else{ */
							BigDecimal d4 = new BigDecimal(field_16);
							BigDecimal d6 = new BigDecimal("0.91");
							BigDecimal d5 = d4.divide(d6,0);
							com_perc=((d5.doubleValue()*100));
						/* } */
					}
					// Gasket Color
					if ((rec_no.elementAt(mn).toString()).equals("17622")){
						gas_color=(desc.elementAt(mn).toString()).substring(((desc.elementAt(mn).toString()).indexOf("Gasket Color - "))+15);
					}
					//Gasket Color
					
					//		double price_sqft= totprice/new Double(area).doubleValue();
					out.println("<tr><td width='3%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+line_no+"</td>");
					out.println("<td width='10%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+mark+"</td>");
					out.println("<td width='25%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+description+"</td>");
					out.println("<td valign='top' width='6%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+quan+"</td>");
					//out.println("<td valign='top' width='6%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+gas_color+"</td>");
					out.println("<td valign='top' width='10%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(totprice)+"</td>");
					out.println("<td valign='top' width='10%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format((totprice/tot_sum)*new Double(overage).doubleValue())+"</td>");
					out.println("<td valign='top' width='10%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(totprice+((totprice/tot_sum)*new Double(overage).doubleValue()))+"</td>");
					out.println("<td valign='top' width='50%'bgcolor='"+bgcolor+"' class='maindesc'>"+discount_show+"</td>");
					out.println("<td valign='top' width='50%'bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(factor)+"</td>");
					out.println("</tr>");
					factor=0;totprice=0;gas_color="NONE";discount_show="";
					if (isBadd){
						out.println("<tr><td width='17%' valign='top' bgcolor='"+bgcolor+"' align='center' class='maindesc' colspan='13'><b>"+bAdderString+"</b></td></tr>");
						isBadd=false;
					}
				}// then new if block specific to EJC
			}

		}

		


	}

	//totprice_dis=totprice_dis+(new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(setup_cost).doubleValue())+(new Double(freight_cost).doubleValue());

	%>
	</table>
	<br><br>
<%
}
%>