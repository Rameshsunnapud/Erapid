<%

if(sections<=0){
	Vector configString=new Vector();
	Vector configLineNo=new Vector();
	ResultSet rsDocLine=stmt.executeQuery("select doc_line, config_string from doc_line where doc_number='"+order_no+"'");
	if(rsDocLine != null){
		while(rsDocLine.next()){
			configString.addElement(rsDocLine.getString("config_string"));
			configLineNo.addElement(rsDocLine.getString("doc_line"));
		}
	}
	rsDocLine.close();
	NumberFormat for12 = NumberFormat.getInstance();
	for12.setMaximumFractionDigits(0);
	int k=0;String bgcolor="";Vector mark=new Vector();Vector desc=new Vector();Vector qty=new Vector();Vector rec_no=new Vector();int bcount=0;
	Vector line_no=new Vector();Vector block_id=new Vector();Vector field20=new Vector();Vector width=new Vector();Vector height=new Vector();Vector screen=new Vector();Vector finish=new Vector();
	Vector model=new Vector();Vector model_group=new Vector();Vector screen_group=new Vector();Vector finish_group=new Vector();Vector group_count=new Vector();Vector item_all=new Vector();
	Vector numMullions=new Vector();Vector secWide=new Vector(); Vector secHigh=new Vector(); Vector sskp_code=new Vector(); Vector sskp_code_group=new Vector();
	Vector actuator=new Vector();
	Vector actuatorGroup=new Vector();
	Vector field18=new Vector();
	ResultSet rs_csquotes = stmt.executeQuery("select * from csquotes where order_no='"+order_no+"' order by cast(Line_no as integer)");
	if (rs_csquotes !=null) {
		while (rs_csquotes.next()) {
			line_no.addElement(rs_csquotes.getString("Line_no"));
			desc.addElement(rs_csquotes.getString("Descript"));
			block_id.addElement(rs_csquotes.getString("block_id"));
			rec_no.addElement(rs_csquotes.getString("Record_no"));
			field20.addElement(rs_csquotes.getString("field20"));
			numMullions.addElement(rs_csquotes.getString("stock"));
			secWide.addElement(rs_csquotes.getString("field16"));
			secHigh.addElement(rs_csquotes.getString("field19"));
			field18.addElement(rs_csquotes.getString("field18"));
			//out.println(k+"::"+rs_csquotes.getString("field16")+"::"+rs_csquotes.getString("field19")+"::<BR>");
			k++;
		}
	}
	rs_csquotes.close();
	int t_costing=0;
	ResultSet rs_cscosting = stmt.executeQuery("select * from cs_costing where order_no='"+order_no+"' and model not in ('8615F') order by cast(item_no as integer)");
	if (rs_cscosting !=null) {
		while (rs_cscosting.next()) {
			item_all.addElement(rs_cscosting.getString("item_no"));
			model.addElement(rs_cscosting.getString("model"));
			width.addElement(rs_cscosting.getString("width"));
			height.addElement(rs_cscosting.getString("height"));
			finish.addElement(rs_cscosting.getString("finish"));
			screen.addElement(rs_cscosting.getString("screen"));
			qty.addElement(rs_cscosting.getString("qty"));
			mark.addElement(rs_cscosting.getString("mark"));
			if(rs_cscosting.getString("actuator")!=null){
				actuator.addElement(rs_cscosting.getString("actuator"));
			}
			else{
				actuator.addElement("");
			}
			if(rs_cscosting.getString("sskp_code")!=null){
				sskp_code.addElement(rs_cscosting.getString("sskp_code"));
			}
			else{
				sskp_code.addElement("");
			}
			t_costing++;
		}
	}
	rs_cscosting.close();
	int t_group=0;
	ResultSet rs_cscosting_group = stmt.executeQuery("SELECT MODEL,FINISH,SCREEN,actuator,sskp_code,COUNT(*)as v from cs_costing where order_no='"+order_no+"' and model not in ('8615F') GROUP BY MODEL,FINISH,SCREEN,actuator,sskp_code");
	if (rs_cscosting_group !=null) {
		while (rs_cscosting_group.next()) {
			if(t_group==0){
				model_group.addElement(rs_cscosting_group.getString("model"));
				finish_group.addElement(rs_cscosting_group.getString("finish"));
				screen_group.addElement(rs_cscosting_group.getString("screen"));
				group_count.addElement(rs_cscosting_group.getString("v"));
				if(rs_cscosting_group.getString("actuator")!=null){
					actuatorGroup.addElement(rs_cscosting_group.getString("actuator"));
				}
				else{
					actuatorGroup.addElement("");
				}
				if(rs_cscosting_group.getString("sskp_code")!=null){
					sskp_code_group.addElement(rs_cscosting_group.getString("sskp_code"));
				}
				else{
					sskp_code_group.addElement("");
				}
				t_group++;
			}
			else{
				String tempActuator=rs_cscosting_group.getString("actuator");
				if(tempActuator==null){
					tempActuator="";
				}
				if(!(sskp_code_group.elementAt(t_group-1).equals(rs_cscosting_group.getString("sskp_code"))&&model_group.elementAt(t_group-1).equals(rs_cscosting_group.getString("model"))&&finish_group.elementAt(t_group-1).equals(rs_cscosting_group.getString("finish"))&&screen_group.elementAt(t_group-1).equals(rs_cscosting_group.getString("screen"))&&actuatorGroup.elementAt(t_group-1).equals(tempActuator))){

					model_group.addElement(rs_cscosting_group.getString("model"));
					finish_group.addElement(rs_cscosting_group.getString("finish"));
					screen_group.addElement(rs_cscosting_group.getString("screen"));
					group_count.addElement(rs_cscosting_group.getString("v"));
					if(rs_cscosting_group.getString("actuator")!=null){
						actuatorGroup.addElement(rs_cscosting_group.getString("actuator"));
					}
					else{
						actuatorGroup.addElement("");
					}
					if(rs_cscosting_group.getString("sskp_code")!=null){
						sskp_code_group.addElement(rs_cscosting_group.getString("sskp_code"));
					}
					else{
						sskp_code_group.addElement("");
					}

					t_group++;

				}
			}

		}
	}
	rs_cscosting_group.close();
	String blank_off="";String sills="";String snap_ons="";String shape="";
	String numMullionsTemp="";
	String secSize="";
	String tempmodel="";
	if (t_group>0){
		out.println("<tr><td><b>"+lvr_sec_desc+"</b></td></tr>");
		for(int mn=0;mn<t_group;mn++){
			for (int n=0;n<t_costing;n++){
				if((sskp_code_group.elementAt(mn).toString().equals(sskp_code.elementAt(n).toString()))&(model_group.elementAt(mn).toString().equals(model.elementAt(n).toString()))&(finish_group.elementAt(mn).toString().equals(finish.elementAt(n).toString()))&(screen_group.elementAt(mn).toString().equals(screen.elementAt(n).toString()))&(actuatorGroup.elementAt(mn).toString().equals(actuator.elementAt(n).toString()))){
					if ((n%2)==1){bgcolor="#FFFFFF";}else {bgcolor="#F1F1F1";}
					if(bcount==0){
						out.println("<table width='100%' cellspacing='1' cellpadding='2' border='0'>");
						for (int v=0;v<k;v++){

							if ((line_no.elementAt(v).toString()).equals((item_all.elementAt(n).toString()))){
								//out.println(line_no.elementAt(v).toString()+"::<BR>");
								if ((block_id.elementAt(v).toString()).equals("A_PRICING")){
									String tempDescript=desc.elementAt(v).toString();

									tempmodel=field18.elementAt(v).toString();
									int start1=tempDescript.indexOf(",");

									int start2=tempDescript.indexOf(".",start1+1);
									//out.println(start1+"::"+start2+"::<BR>");
									start1=tempDescript.indexOf(",",start1+1);
									//out.println(start1+"::"+start2+"::<BR>");
									if(start2 >0 && start2<start1){
										start1=start2;
									}
									//out.println(start1+"::"+start2+"::<BR>");
									if(start1>0){
										tempDescript="<B>"+tempDescript.substring(0,start1)+"</b>"+tempDescript.substring(start1+1);
									}
									out.println("<tr width='100%'><td colspan='7' class='mainbody2'>"+tempDescript+"</td></tr>");
								}
								if ((block_id.elementAt(v).toString()).equals("E_DIM")){
									String dim=(desc.elementAt(v)).toString();
									if(field20.elementAt(v)==null){
										shape="";
									}
									else{
										shape=(field20.elementAt(v)).toString();
									}
									int n_s=dim.indexOf("@");
									int n_s1=dim.indexOf("@",n_s+1);
									int n_s2=dim.indexOf("@",n_s1+1);
									int n_s3=dim.indexOf("@",n_s2+1);
								    	int n_s4=dim.indexOf("@",n_s3+1);
									blank_off=dim.substring(n_s2+1,n_s3);
									sills=dim.substring(n_s3+1,n_s4);
									snap_ons=dim.substring(n_s4+1,dim.length());
								}
								if(numMullions.elementAt(v)!= null){
									numMullionsTemp=numMullions.elementAt(v).toString();
								}
								if(secWide.elementAt(v)!=null && secHigh.elementAt(v)!=null){
									secSize=secWide.elementAt(v).toString()+" x "+secHigh.elementAt(v).toString();
								}
							}
						}
						//GETTING THE FINISH AND THE SIZE FROM THE TABLES
						String finish_desc="";String screen_desc="";
						ResultSet rs_csfinish = stmt.executeQuery("select description from cs_finish where code='"+finish.elementAt(n).toString()+"'");
						if (rs_csfinish !=null) {
							while (rs_csfinish.next()) {
								finish_desc= rs_csfinish.getString("description");
							}
						}
						rs_csfinish.close();
						String tempScreen=screen.elementAt(n).toString();
						//out.println(tempScreen+"<BR>");
						if(tempScreen.indexOf("&")>0){
							ResultSet rs_csscreen1 = stmt.executeQuery("select description from cs_screen where code='"+tempScreen.substring(0,tempScreen.indexOf("&"))+"'");
							if (rs_csscreen1 !=null) {
								while (rs_csscreen1.next()) {
									screen_desc= rs_csscreen1.getString("description")+"&nbsp;";
								}
							}
							rs_csscreen1.close();
							tempScreen=tempScreen.substring(tempScreen.indexOf("&"));
							//out.println(tempScreen);
							tempScreen=tempScreen.replaceAll("&","','");
							ResultSet rs_csscreen = stmt.executeQuery("select description from cs_screen where code in('"+tempScreen+"')");
							if (rs_csscreen !=null) {
								while (rs_csscreen.next()) {
									if(screen_desc.trim().length()>0){
										screen_desc=screen_desc+ rs_csscreen.getString("description").replaceAll("SCREEN:","")+"&nbsp;";
									}
									else{
										screen_desc=screen_desc+ rs_csscreen.getString("description")+"&nbsp;";
									}
								}
							}
							rs_csscreen.close();
						}
						else{
							ResultSet rs_csscreen = stmt.executeQuery("select description from cs_screen where code='"+tempScreen+"'");
							if (rs_csscreen !=null) {
								while (rs_csscreen.next()) {
									screen_desc= rs_csscreen.getString("description");
								}
							}
							rs_csscreen.close();
						}
						finish_desc=finish_desc.replaceAll("FINISH","<B>FINISH</b>");
						screen_desc=screen_desc.replaceAll("SCREEN","<B>SCREEN</b>");
						out.println("<tr width='100%'><td colspan='7' class='mainbody2'>"+screen_desc+"</td></tr>");
						out.println("<tr width='100%'><td colspan='7' class='mainbody2'>"+finish_desc+"</td></tr>");
						out.println("</table>");
						out.println("<table width='100%' cellspacing='1' cellpadding='2' border='0'>");

						out.println("<tr valign='top'>");
						out.println("<td width='5%'  bgcolor='#FFFFFF' class='schedule' align='center'><b><u>Mark</u></b></td>");
						out.println("<td width='5%'  bgcolor='#FFFFFF' class='schedule' align='center'><b><u>Qty</u></b></td>");
						out.println("<td width='16%' bgcolor='#FFFFFF' class='schedule' align='center'><b><u>R.O. Size (W x H)</u></b></td>");
						//out.println(tempmodel);
						if(tempmodel!=null&&tempmodel.equals("RS7705")){
							out.println("<td width='10%' bgcolor='#FFFFFF' class='schedule' align='center'><b><u>Recessed<br>Mullions</u></b></td>");
						}
						else if(tempmodel!=null&&tempmodel.equals("6155")){
							out.println("<td width='10%' bgcolor='#FFFFFF' class='schedule' align='center'><b><u>Semi-Recessed<br>Mullions</u></b></td>");
						}
						else{
							out.println("<td width='10%' bgcolor='#FFFFFF' class='schedule' align='center'><b><u>Exposed<br>Mullions</u></b></td>");
						}
						out.println("<td width='10%' bgcolor='#FFFFFF' class='schedule' align='center'><b><u>Sections per<BR>Louver(W X H)</u></b></td>");
						out.println("<td width='10%' bgcolor='#FFFFFF' class='schedule' align='center'><b><u>Shape</u></b></td>");
						out.println("<td width='14%' bgcolor='#FFFFFF' class='schedule' align='center'><b><u>System Depth<br>Including Supports</u></b></td>");
						out.println("<td width='10%' bgcolor='#FFFFFF' class='schedule' align='center'><b><u>Blank Off</u></b></td>");
						out.println("<td width='20%' bgcolor='#FFFFFF' class='schedule' align='center'><b><u>Sills</u></b></td>");
						out.println("</tr>");
						out.println("<tr>");
						out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+mark.elementAt(n).toString()+"</td>");
						out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+for12.format(new Double(qty.elementAt(n).toString()).doubleValue())+"</td>");
						out.println("<td valign='top' nowrap nowrap bgcolor='"+bgcolor+"' class='maindesc'  align='center'>"+width.elementAt(n).toString()+" x "+height.elementAt(n).toString()+"</td>");
						if(blank_off.trim().length()<=0){blank_off="NONE";}
						if(sills.trim().length()<=0){sills="NONE";}
						if(snap_ons.trim().length()<=0){snap_ons="NONE";}
						String sysdepth="0";
						for(int aa=0; aa<configString.size(); aa++){
							//out.println("<BR>"+configString.elementAt(aa).toString()+" <BR>");
							if(item_all.elementAt(n).toString().equals(configLineNo.elementAt(aa).toString())){
								int starta=configString.elementAt(aa).toString().indexOf("SYSDEPTH[");
								int enda=0;
								if(starta>0){
									starta=starta+9;
									enda=starta+configString.elementAt(aa).toString().substring(starta).indexOf("]");
									if(enda>0){
										sysdepth=configString.elementAt(aa).toString().substring(starta,enda);
										//	out.println("test"+sysdepth);
									}
								}
							}
						}

						out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+numMullionsTemp+"</td>");
						out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+secSize+"</td>");

						out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+shape+"</td>");
						out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+new Double(sysdepth).doubleValue()+"&#34;</td>");
						out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+blank_off+"</td>");
						out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+sills+"</td>");
						out.println("</tr>");
						bcount++;finish_desc="";screen_desc="";rs_csfinish.close();
					}
					else{
						for (int v=0;v<k;v++){
							if ((line_no.elementAt(v).toString()).equals((item_all.elementAt(n).toString()))){
								if ((block_id.elementAt(v).toString()).equals("E_DIM")){
									String dim=(desc.elementAt(v)).toString();
									if(field20.elementAt(v)==null){
										shape="";
									}
									else{
										shape=(field20.elementAt(v)).toString();
									}
									int n_s=dim.indexOf("@");
									int n_s1=dim.indexOf("@",n_s+1);
									int n_s2=dim.indexOf("@",n_s1+1);
									int n_s3=dim.indexOf("@",n_s2+1);
									int n_s4=dim.indexOf("@",n_s3+1);
									blank_off=dim.substring(n_s2+1,n_s3);
									sills=dim.substring(n_s3+1,n_s4);
									snap_ons=dim.substring(n_s4+1,dim.length());
								}
							}
						}
						if(blank_off.trim().length()<=0){blank_off="NONE";}
						if(sills.trim().length()<=0){sills="NONE";}
						if(snap_ons.trim().length()<=0){snap_ons="NONE";}
						String sysdepth="0";
						for(int aa=0; aa<configString.size(); aa++){
							if(item_all.elementAt(n).toString().equals(configLineNo.elementAt(aa).toString())){
								int starta=configString.elementAt(aa).toString().indexOf("SYSDEPTH[");
								int enda=0;
								if(starta>0){
									starta=starta+9;
									enda=starta+configString.elementAt(aa).toString().substring(starta).indexOf("]");
									if(enda>0){
										sysdepth=configString.elementAt(aa).toString().substring(starta,enda);
									}
								}
							}






















						}
						for (int v=0;v<k;v++){
							//out.println(line_no.elementAt(v).toString()+"::"+item_all.elementAt(n).toString()+"::<BR>");
							if ((line_no.elementAt(v).toString()).equals(item_all.elementAt(n).toString())){
								//out.println(" done<BR><BR>");
								//numMullionsTemp=numMullions.elementAt(v).toString();
								//secSize=secWide.elementAt(v).toString()+" x "+secHigh.elementAt(v).toString();

								if(numMullions.elementAt(v)!= null){
									numMullionsTemp=numMullions.elementAt(v).toString();
								}
								if(secWide.elementAt(v)!=null && secHigh.elementAt(v)!=null){
									secSize=secWide.elementAt(v).toString()+" x "+secHigh.elementAt(v).toString();
								}

							}
						}
						out.println("<tr>");
						out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+mark.elementAt(n).toString()+"</td>");
						out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+for12.format(new Double(qty.elementAt(n).toString()).doubleValue())+"</td>");
						out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+width.elementAt(n).toString()+" x "+height.elementAt(n).toString()+"</td>");
						out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+numMullionsTemp+"</td>");
						out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+secSize+"</td>");
						out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+shape+"</td>");
						out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+new Double(sysdepth).doubleValue()+"&#34;</td>");
						out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+blank_off+"</td>");
						out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+sills+"</td>");
						out.println("</tr>");
					}

					blank_off="";sills="";snap_ons="";
				}

			}
			bcount=0;
			out.println("<tr><td>"+"&nbsp;"+"</td></tr>");
			out.println("</table>");
		}
		%>

		<%//@ include file="psa_quote_cran_price_block.jsp"%><!--PRice block-->
		<jsp:include page="psa_quote_cran_price_block.jsp" flush="true">
		<jsp:param name="order_no" value="<%= order_no%>"/>
		<jsp:param name="tax_perc" value="<%= tax_perc%>"/>
		<jsp:param name="overage" value="<%=overage %>"/>
		<jsp:param name="handling_cost" value="<%=handling_cost %>"/>
		<jsp:param name="freight_cost" value="<%=freight_cost %>"/>
		<jsp:param name="setup_cost1" value="0"/>
		<jsp:param name="setup_cost" value="<%= setup_cost%>"/>
		<jsp:param name="totprice_dis" value="<%= taxtotal%>"/>
		<jsp:param name="isquote" value="yes"/>
		<jsp:param name="product_id" value="<%= product%>"/>
		<jsp:param name="secLines" value="<%= secLines%>"/>
		<jsp:param name="sectotalname" value="<%=sectotalname %>"/>
		<jsp:param name="border_color" value="<%=border_color %>"/>
		<jsp:param name="price" value="<%=price %>"/>
		<jsp:param name="taxtotal" value="<%=taxtotal %>"/>
		</jsp:include>
		<%

	}//if tgroup

}// no sections
else {// if there are sections



double sumTotal=0;
double freightX=0;
double handlingX=0;
double tempOverage=0;
double tempFreight_cost=0;
double tempHandling_cost=0;
ResultSet rsSumTot=stmt.executeQuery("Select sum(cast(pinfsellprice as numeric)) from cs_access_central where order_no='"+order_no+"'");
if(rsSumTot != null){
	while(rsSumTot.next()){
		sumTotal=new Double(rsSumTot.getString(1)).doubleValue();
	}
}
rsSumTot.close();







Vector configString=new Vector();
Vector configLineNo=new Vector();

ResultSet rsDocLine=stmt.executeQuery("select doc_line, config_string from doc_line where doc_number='"+order_no+"'");
if(rsDocLine != null){
	while(rsDocLine.next()){
		configString.addElement(rsDocLine.getString("config_string"));
		configLineNo.addElement(rsDocLine.getString("doc_line"));
	}
}
rsDocLine.close();

double totprice=0;String line_cost="";double line_price=0;String qual_sect="";String exec_sect="";
   for(int ye=0;ye<sect_group.size();ye++){
	   	tempOverage=new Double(overage).doubleValue();
	   	tempFreight_cost=new Double(freight_cost).doubleValue();
		tempHandling_cost=new Double(handling_cost).doubleValue();
  // out.println(sect_value.elementAt(ye).toString()+"::"+sect_name.elementAt(ye).toString()+"::"+sect_group.elementAt(ye).toString()+"::"+sect_group_lines.elementAt(ye).toString());
   	sectotalname=""+sect_name.elementAt(ye).toString();
   grand_total=0;//intialize the total to zero
   ///Getting the sections totals
   	 	ResultSet rs_ac = stmt.executeQuery("SELECT * FROM cs_access_central where order_no like '"+order_no+"' and section_no like '"+sect_name.elementAt(ye).toString()+"'");
  		if (rs_ac !=null) {
        while (rs_ac.next()) {
		lvr_sec_desc=rs_ac.getString("ac_desc");
		lvr_sec_add=rs_ac.getString("ac_add");
		lvr_spec_sec=rs_ac.getString("sect");
		lvr_sec_date=rs_ac.getString("ac_date");
		grand_total=new Double(rs_ac.getString("pinfsellprice")).doubleValue();
		}
		}
		rs_ac.close();
   		// Header for new pages
		if(section_page==null||section_page.equals("1")){
		%>
		<%@ include file="quote_template_header_sfdc.jsp"%>
		<%@ include file="quote_template_top_sfdc.jsp"%>
		<%
		}









		double sumX=grand_total;


		double overageX=0;
		//out.println(sumX+"::"+sumTotal);
		overageX=new Double(overage).doubleValue()*(sumX/sumTotal);

		freightX=new Double(freight_cost).doubleValue()*(sumX/sumTotal);
		handlingX=new Double(handling_cost).doubleValue()*(sumX/sumTotal);
		//out.println(freightX+":: before<BR>");
		if(overageSec.elementAt(ye) != null && overageSec.elementAt(ye).toString().trim().length()>0){
			//out.println(overageSec.elementAt(ye).toString()+"::: to string<BR>");
			overageX=new Double(overageSec.elementAt(ye).toString()).doubleValue();
		}
		if(freightSec.elementAt(ye) != null && freightSec.elementAt(ye).toString().trim().length()>0){
			freightX=new Double(freightSec.elementAt(ye).toString()).doubleValue();
		}
		if(handlingSec.elementAt(ye) != null && handlingSec.elementAt(ye).toString().trim().length()>0){
			handlingX=new Double(handlingSec.elementAt(ye).toString()).doubleValue();
		}
		//out.println(freightX+":: after<BR>");









// the body of the quote per section
	NumberFormat for12 = NumberFormat.getInstance();
	for12.setMaximumFractionDigits(0);
	int k=0;String bgcolor="";Vector mark=new Vector();Vector desc=new Vector();Vector qty=new Vector();Vector rec_no=new Vector();int bcount=0;
	Vector line_no=new Vector();Vector block_id=new Vector();Vector field20=new Vector();Vector width=new Vector();Vector height=new Vector();Vector screen=new Vector();Vector finish=new Vector();
	Vector model=new Vector();Vector model_group=new Vector();Vector screen_group=new Vector();Vector finish_group=new Vector();Vector group_count=new Vector();Vector item_all=new Vector();
	Vector numMullions=new Vector();Vector secWide=new Vector(); Vector secHigh=new Vector();Vector field18=new Vector();
	 	ResultSet rs_csquotes = stmt.executeQuery("select * from csquotes where order_no='"+order_no+"' and line_no in("+sect_group_lines.elementAt(ye).toString()+") order by cast(Line_no as integer)");
	  		if (rs_csquotes !=null) {
		        while (rs_csquotes.next()) {
				line_no.addElement(rs_csquotes.getString("Line_no"));
				desc.addElement(rs_csquotes.getString("Descript"));
				block_id.addElement(rs_csquotes.getString("block_id"));
				rec_no.addElement(rs_csquotes.getString("Record_no"));
				field20.addElement(rs_csquotes.getString("field20"));
				numMullions.addElement(rs_csquotes.getString("stock"));
				secWide.addElement(rs_csquotes.getString("field16"));
				secHigh.addElement(rs_csquotes.getString("field19"));
				field18.addElement(rs_csquotes.getString("field18"));
				k++;
				}
			}
			rs_csquotes.close();
	int t_costing=0;
	 	ResultSet rs_cscosting = stmt.executeQuery("select * from cs_costing where order_no='"+order_no+"' and item_no in("+sect_group_lines.elementAt(ye).toString()+") order by cast(item_no as integer)");
	  		if (rs_cscosting !=null) {
		        while (rs_cscosting.next()) {
				item_all.addElement(rs_cscosting.getString("item_no"));
				model.addElement(rs_cscosting.getString("model"));
				width.addElement(rs_cscosting.getString("width"));
				height.addElement(rs_cscosting.getString("height"));
				finish.addElement(rs_cscosting.getString("finish"));
				screen.addElement(rs_cscosting.getString("screen"));
				qty.addElement(rs_cscosting.getString("qty"));
				mark.addElement(rs_cscosting.getString("mark"));
				t_costing++;
				}
			}
			rs_cscosting.close();
	int t_group=0;
	 	ResultSet rs_cscosting_group = stmt.executeQuery("SELECT MODEL,FINISH,SCREEN,COUNT(*)as v from cs_costing where order_no='"+order_no+"' and item_no in("+sect_group_lines.elementAt(ye).toString()+") GROUP BY MODEL,FINISH,SCREEN");
	//	SELECT MODEL,FINISH,SCREEN,COUNT(*) FROM "DBA"."CS_COSTING" where order_no='003894_00' GROUP BY MODEL,FINISH,SCREEN
	  		if (rs_cscosting_group !=null) {
		        while (rs_cscosting_group.next()) {
				model_group.addElement(rs_cscosting_group.getString("model"));
				finish_group.addElement(rs_cscosting_group.getString("finish"));
				screen_group.addElement(rs_cscosting_group.getString("screen"));
				group_count.addElement(rs_cscosting_group.getString("v"));
				t_group++;
				}
			}
			rs_cscosting_group.close();
//	out.println("the total"+t_group+"tHE Normal"+t_costing);
/*
			out.println("<table width='100%' cellspacing='1' cellpadding='2' border='0'>");
			out.println("<tr height='20'>");
			out.println("<td class='mainbodyh' colspan='6'> ");out.println("<b>Section:: "+(String)sect_group.elementAt(ye)+"</b>" );	out.println("</td>");
			out.println("</tr>");
			out.println("</table>");
*/

	String blank_off="";String sills="";String snap_ons="";String shape="";
	String numMullionsTemp="";
	String secSize="";
	String tempmodel="";
	if (t_group>0){
		out.println("<table width='100%' cellspacing='1' cellpadding='2' border='0'>");
		out.println("<tr><td><b>"+(String)sect_group.elementAt(ye)+"</b></td></tr>");
		/*
			 if(type.equals("3")){
					if(! ((lvr_sec_add==null)||((lvr_sec_add.trim()).length()==0)) )  {
					out.println("<tr><td class='mainbodyh'><b>Addenda:</b> "+lvr_sec_add+"</td></tr>");
					}
					if(! ( (lvr_spec_sec==null)||((lvr_spec_sec.trim()).length()==0)) )  {
					out.println("<tr><td class='mainbodyh'><b>Proposal Based on Material as Specified in Section:</b>"+ lvr_spec_sec +"</td></tr>");
					}
					if( ! ((lvr_sec_date==null)||((lvr_sec_date.trim()).length()==0)) )  {
					out.println("<tr><td class='mainbodyh'><b>Quantities per Plans Dated:</b> "+  lvr_sec_date +"</td></tr>");
					}
			 }
			 */
			out.println("</table>");
			for(int mn=0;mn<t_group;mn++){
				for (int n=0;n<t_costing;n++){
						if((model_group.elementAt(mn).toString().equals(model.elementAt(n).toString()))&(finish_group.elementAt(mn).toString().equals(finish.elementAt(n).toString()))&(screen_group.elementAt(mn).toString().equals(screen.elementAt(n).toString()))){
//								if ((n%2)==1){bgcolor="#EFEFDE";}else {bgcolor="#FFFFFF";}
								if ((n%2)==1){bgcolor="#FFFFFF";}else {bgcolor="#F1F1F1";}
								if(bcount==0){
									out.println("<table width='100%' cellspacing='1' cellpadding='2' border='0'>");
									for (int v=0;v<k;v++){
										if ((line_no.elementAt(v).toString()).equals((item_all.elementAt(n).toString()))){
											if ((block_id.elementAt(v).toString()).equals("A_PRICING")){
												String tempDescript=desc.elementAt(v).toString();
												tempmodel=field18.elementAt(v).toString();
												int start1=tempDescript.indexOf(",");
												int start2=tempDescript.indexOf(".",start1+1);
												start1=tempDescript.indexOf(",",start1+1);
												if(start2 >0 && start2<start1){
													start1=start2;
												}
												if(start1>0){
													tempDescript="<B>"+tempDescript.substring(0,start1)+"</b>"+tempDescript.substring(start1+1);
												}
												out.println("<tr width='100%'><td colspan='9' class='mainbody2'>"+tempDescript+"</td></tr>");
											}
											if ((block_id.elementAt(v).toString()).equals("E_DIM")){
												String dim=(desc.elementAt(v)).toString();
												if(field20.elementAt(v)==null){
												shape="";
												}
												else{
												shape=(field20.elementAt(v)).toString();
												}
											   	int n_s=dim.indexOf("@");
												int n_s1=dim.indexOf("@",n_s+1);
												int n_s2=dim.indexOf("@",n_s1+1);
												int n_s3=dim.indexOf("@",n_s2+1);
											    int n_s4=dim.indexOf("@",n_s3+1);
	//											blank_off=dim.substring(0,n_s);
	//											blank_off=dim.substring(n_s+1,n_s1);
	//											logo=dim.substring(n_s1+1,n_s2);
												blank_off=dim.substring(n_s2+1,n_s3);
												sills=dim.substring(n_s3+1,n_s4);
												snap_ons=dim.substring(n_s4+1,dim.length());
											}
										}
										//numMullionsTemp=numMullions.elementAt(v).toString();
										//tsecSize=secWide.elementAt(v).toString()+" x "+secHigh.elementAt(v).toString();
									}
								//GETTING THE FINISH AND THE SIZE FROM THE TABLES
								String finish_desc="";String screen_desc="";
							 	ResultSet rs_csfinish = stmt.executeQuery("select description from cs_finish where code='"+finish.elementAt(n).toString()+"'");
						  		if (rs_csfinish !=null) {
							        while (rs_csfinish.next()) {
									finish_desc= rs_csfinish.getString("description");
									}
								}
								rs_csfinish.close();
								String tempScreen=screen.elementAt(n).toString();
								//out.println(tempScreen+":::a<BR>");
								if(tempScreen.indexOf("&")>0){
									ResultSet rs_csscreen1 = stmt.executeQuery("select description from cs_screen where code='"+tempScreen.substring(0,tempScreen.indexOf("&"))+"'");
									if (rs_csscreen1 !=null) {
										while (rs_csscreen1.next()) {
											screen_desc= rs_csscreen1.getString("description")+"&nbsp;";
										}
									}
									rs_csscreen1.close();
									tempScreen=tempScreen.substring(tempScreen.indexOf("&"));
									//out.println(tempScreen);
									tempScreen=tempScreen.replaceAll("&","','");
									ResultSet rs_csscreen = stmt.executeQuery("select description from cs_screen where code in('"+tempScreen+"')");
									if (rs_csscreen !=null) {
										while (rs_csscreen.next()) {
											if(screen_desc.trim().length()>0){
												screen_desc=screen_desc+ rs_csscreen.getString("description").replaceAll("SCREEN:","")+"&nbsp;";
											}
											else{
												screen_desc=screen_desc+ rs_csscreen.getString("description")+"&nbsp;";
											}
										}
									}
									rs_csscreen.close();
								}
								else{
									ResultSet rs_csscreen = stmt.executeQuery("select description from cs_screen where code='"+tempScreen+"'");
									if (rs_csscreen !=null) {
										while (rs_csscreen.next()) {
											screen_desc= rs_csscreen.getString("description");
										}
									}
									rs_csscreen.close();
								}
								finish_desc=finish_desc.replaceAll("FINISH","<B>FINISH</b>");
								screen_desc=screen_desc.replaceAll("SCREEN","<B>SCREEN</b>");
								out.println("<tr width='100%'><td colspan='9' class='mainbody2'>"+screen_desc+"</td></tr>");
								out.println("<tr width='100%'><td colspan='9' class='mainbody2'>"+finish_desc+"</td></tr>");
								out.println("<tr width='100%'>");

						out.println("<td width='5%'  bgcolor='#FFFFFF' class='schedule' align='center'><b><u>Mark</u></b></td>");
						out.println("<td width='5%'  bgcolor='#FFFFFF' class='schedule' align='center'><b><u>Qty</u></b></td>");
						out.println("<td width='16%' bgcolor='#FFFFFF' class='schedule' align='center'><b><u>R.O. Size (W x H)</u></b></td>");
						if(tempmodel!=null&&tempmodel.equals("RS7705")){
							out.println("<td width='10%' bgcolor='#FFFFFF' class='schedule' align='center'><b><u>Recessed<br>Mullions</u></b></td>");
						}
						else if(tempmodel!=null&&tempmodel.equals("6155")){
							out.println("<td width='10%' bgcolor='#FFFFFF' class='schedule' align='center'><b><u>Semi-Recessed<br>Mullions</u></b></td>");
						}
						else{
							out.println("<td width='10%' bgcolor='#FFFFFF' class='schedule' align='center'><b><u>Exposed<br>Mullions</u></b></td>");
						}
						out.println("<td width='10%' bgcolor='#FFFFFF' class='schedule' align='center'><b><u>Sections per<BR>Louver(W X H)</u></b></td>");
						out.println("<td width='10%' bgcolor='#FFFFFF' class='schedule' align='center'><b><u>Shape</u></b></td>");
						out.println("<td width='14%'  bgcolor='#FFFFFF' class='schedule' align='center'><b><u>System Depth<br>Including Supports</u></b></td>");
						out.println("<td width='10% ' bgcolor='#FFFFFF' class='schedule' align='center'><b><u>Blank Off</u></b></td>");
						out.println("<td width='20%'  bgcolor='#FFFFFF' class='schedule' align='center'><b><u>Sills</u></b></td>");


								out.println("</tr>");

								out.println("<tr>");
								out.println("<td valign='top'  nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+mark.elementAt(n).toString()+"</td>");
								out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+for12.format(new Double(qty.elementAt(n).toString()).doubleValue())+"</td>");
								out.println("<td valign='top' nowrap nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+width.elementAt(n).toString()+" x "+height.elementAt(n).toString()+"</td>");
								if(blank_off.trim().length()<=0){blank_off="NONE";}
								if(sills.trim().length()<=0){sills="NONE";}
								if(snap_ons.trim().length()<=0){snap_ons="NONE";}
		//						if(shape.trim().length()<=0){shape=" ";}
							String sysdepth="0";

							for(int aa=0; aa<configString.size(); aa++){

								if(item_all.elementAt(n).toString().equals(configLineNo.elementAt(aa).toString())){
									int starta=configString.elementAt(aa).toString().indexOf("SYSDEPTH[");
									int enda=0;
									if(starta>0){
										starta=starta+9;
										enda=starta+configString.elementAt(aa).toString().substring(starta).indexOf("]");
										if(enda>0){
											sysdepth=configString.elementAt(aa).toString().substring(starta,enda);
										}
									}
								}
							}
							for (int v=0;v<k;v++){
								//out.println(line_no.elementAt(v).toString()+"::"+item_all.elementAt(n).toString()+"::<BR>");
								if ((line_no.elementAt(v).toString()).equals(item_all.elementAt(n).toString())){
									//out.println(" done<BR><BR>");
									//numMullionsTemp=numMullions.elementAt(v).toString();
									//secSize=secWide.elementAt(v).toString()+" x "+secHigh.elementAt(v).toString();
									if(numMullions.elementAt(v)!= null){
										numMullionsTemp=numMullions.elementAt(v).toString();
									}
									if(secWide.elementAt(v)!=null && secHigh.elementAt(v)!=null){
										secSize=secWide.elementAt(v).toString()+" x "+secHigh.elementAt(v).toString();
									}
								}
							}
								out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+numMullionsTemp+"</td>");
								out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+secSize+"</td>");
								out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+shape+"</td>");
								out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+new Double(sysdepth).doubleValue()+"&#34;</td>");
								out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+blank_off+"</td>");
								out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+sills+"</td>");
	//							out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+snap_ons+"</td>");
								out.println("</tr>");
								bcount++;finish_desc="";screen_desc="";rs_csfinish.close();
								}
								else{
									for (int v=0;v<k;v++){
										if ((line_no.elementAt(v).toString()).equals((item_all.elementAt(n).toString()))){
											if ((block_id.elementAt(v).toString()).equals("E_DIM")){
												String dim=(desc.elementAt(v)).toString();
												if(field20.elementAt(v)==null){
												shape="";
												}
												else{
												shape=(field20.elementAt(v)).toString();
												}
											   	int n_s=dim.indexOf("@");
												int n_s1=dim.indexOf("@",n_s+1);
												int n_s2=dim.indexOf("@",n_s1+1);
												int n_s3=dim.indexOf("@",n_s2+1);
											    int n_s4=dim.indexOf("@",n_s3+1);
	//											blank_off=dim.substring(0,n_s);
	//											blank_off=dim.substring(n_s+1,n_s1);
	//											logo=dim.substring(n_s1+1,n_s2);
												blank_off=dim.substring(n_s2+1,n_s3);
												sills=dim.substring(n_s3+1,n_s4);
												snap_ons=dim.substring(n_s4+1,dim.length());
											}
												   }
												}
											if(blank_off.trim().length()<=0){blank_off="NONE";}
											if(sills.trim().length()<=0){sills="NONE";}
											if(snap_ons.trim().length()<=0){snap_ons="NONE";}
				//							if(shape.trim().length()<=0){shape=" ";}
										String sysdepth="0";
							for(int aa=0; aa<configString.size(); aa++){
								if(item_all.elementAt(n).toString().equals(configLineNo.elementAt(aa).toString())){
									int starta=configString.elementAt(aa).toString().indexOf("SYSDEPTH[");
									int enda=0;
									if(starta>0){
										starta=starta+9;
										enda=starta+configString.elementAt(aa).toString().substring(starta).indexOf("]");
										if(enda>0){
											sysdepth=configString.elementAt(aa).toString().substring(starta,enda);
										}
									}
								}
							}
							for (int v=0;v<k;v++){
								//out.println(line_no.elementAt(v).toString()+"::"+item_all.elementAt(n).toString()+"::<BR>");
								if ((line_no.elementAt(v).toString()).equals(item_all.elementAt(n).toString())){
									//out.println(" done<BR><BR>");
									//numMullionsTemp=numMullions.elementAt(v).toString();
									//secSize=secWide.elementAt(v).toString()+" x "+secHigh.elementAt(v).toString();
									if(numMullions.elementAt(v)!= null){
										numMullionsTemp=numMullions.elementAt(v).toString();
									}
									if(secWide.elementAt(v)!=null && secHigh.elementAt(v)!=null){
										secSize=secWide.elementAt(v).toString()+" x "+secHigh.elementAt(v).toString();
									}
								}
							}


											out.println("<tr>");
											out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+mark.elementAt(n).toString()+"</td>");
											out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+for12.format(new Double(qty.elementAt(n).toString()).doubleValue())+"</td>");
											out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+width.elementAt(n).toString()+" x "+height.elementAt(n).toString()+"</td>");
											out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+numMullionsTemp+"</td>");
											out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+secSize+"</td>");
											out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+shape+"</td>");
											out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+new Double(sysdepth).doubleValue()+"&#34;</td>");
											out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+blank_off+"</td>");
											out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+sills+"</td>");
				//							out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+snap_ons+"</td>");
											out.println("</tr>");

											}

										  blank_off="";sills="";snap_ons="";
										}

						    }

						 bcount=0;
						out.println("<tr><td>"+"&nbsp;"+"</td></tr>");
						out.println("</table>");
					     }

				}// if t_group ends here

			//The total for each section
//				   out.println(sect_name.elementAt(ye).toString());
			for1.setMaximumFractionDigits(0);
			price=for1.format(grand_total);
			for1.setMaximumFractionDigits(2);
//			out.println(price+"::"+sect_name.elementAt(ye).toString());
	//out.println(freight_cost+"::"+freightX);
		overage=""+overageX;
		freight_cost=""+freightX;
		handling_cost=""+handlingX;
%>

		<jsp:include page="psa_quote_cran_price_block.jsp" flush="true">
		<jsp:param name="order_no" value="<%= order_no%>"/>
		<jsp:param name="tax_perc" value="<%= tax_perc%>"/>
		<jsp:param name="overage" value="<%=overage %>"/>
		<jsp:param name="handling_cost" value="<%=handling_cost %>"/>
		<jsp:param name="freight_cost" value="<%=freight_cost %>"/>
		<jsp:param name="setup_cost1" value="0"/>
		<jsp:param name="setup_cost" value="<%= setup_cost%>"/>
		<jsp:param name="totprice_dis" value="<%= taxtotal%>"/>
		<jsp:param name="isquote" value="yes"/>
		<jsp:param name="product_id" value="<%= product%>"/>
		<jsp:param name="secLines" value="<%= secLines%>"/>
		<jsp:param name="sectotalname" value="<%=sectotalname %>"/>
		<jsp:param name="border_color" value="<%=border_color %>"/>
		<jsp:param name="price" value="<%=price %>"/>
		<jsp:param name="taxtotal" value="<%=taxtotal %>"/>
		</jsp:include>

<%
	// the body of the quote per section ends	 s

		//footer for new pages
		if(section_page==null||section_page.equals("1")){
		%>
		<%@ include file="quote_template_foot_sfdc.jsp"%>
		<%@ include file="quote_template_footer_sfdc.jsp"%>
		<%

		if(sect_group.size()-ye>1){out.println("<p style='page-break-after : always;' >&nbsp;</p>");}
		}
		totprice=0;exec_sect="";qual_sect="";
		overage=""+tempOverage;
		freight_cost=""+tempFreight_cost;
		handling_cost=""+tempHandling_cost;
	}// the main for loop
}// if there are sections

%>




