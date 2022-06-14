<%
NumberFormat for11 = NumberFormat.getInstance();
for11.setMaximumFractionDigits(1);
for11.setMinimumFractionDigits(1);
if(sections<=0){
	//out.println("sections < = 0");
	NumberFormat for12 = NumberFormat.getInstance();
	for12.setMaximumFractionDigits(0);
	double sqft=0;

	int k=0;String bgcolor="";Vector mark=new Vector();Vector desc=new Vector();Vector qty=new Vector();Vector rec_no=new Vector();int bcount=0;
	Vector line_no=new Vector();Vector block_id=new Vector();Vector field20=new Vector();Vector width=new Vector();Vector height=new Vector();Vector screen=new Vector();Vector finish=new Vector();
	Vector model=new Vector();Vector model_group=new Vector();Vector screen_group=new Vector();Vector finish_group=new Vector();Vector group_count=new Vector();Vector item_all=new Vector();
	Vector sch=new Vector();
		ResultSet rs_csquotes = stmt.executeQuery("select * from csquotes where order_no='"+order_no+"' order by cast(Line_no as integer)");
			if (rs_csquotes !=null) {
			while (rs_csquotes.next()) {
				line_no.addElement(rs_csquotes.getString("Line_no"));
				desc.addElement(rs_csquotes.getString("Descript"));
				block_id.addElement(rs_csquotes.getString("block_id"));
				rec_no.addElement(rs_csquotes.getString("Record_no"));
				field20.addElement(rs_csquotes.getString("field20"));
				k++;
				}
			}
			rs_csquotes.close();
	int t_costing=0;
		ResultSet rs_cscosting = stmt.executeQuery("select * from cs_costing where order_no='"+order_no+"' order by cast(item_no as integer)");
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
				sch.addElement(rs_cscosting.getString("s_options"));
				t_costing++;
				model_group.addElement(rs_cscosting.getString("model"));
				finish_group.addElement(rs_cscosting.getString("finish"));
				screen_group.addElement(rs_cscosting.getString("screen"));
				sqft=sqft+new Double(rs_cscosting.getString("sqft")).doubleValue();
				}
			}
			rs_cscosting.close();
	int t_group=0;
		ResultSet rs_cscosting_group = stmt.executeQuery("SELECT MODEL,FINISH,SCREEN,COUNT(*)as v from cs_costing where order_no='"+order_no+"' GROUP BY MODEL,FINISH,SCREEN");
	//	SELECT MODEL,FINISH,SCREEN,COUNT(*) FROM "DBA"."CS_COSTING" where order_no='003894_00' GROUP BY MODEL,FINISH,SCREEN
			if (rs_cscosting_group !=null) {
			while (rs_cscosting_group.next()) {
				//model_group.addElement(rs_cscosting_group.getString("model"));
				//finish_group.addElement(rs_cscosting_group.getString("finish"));
				////screen_group.addElement(rs_cscosting_group.getString("screen"));
				group_count.addElement(rs_cscosting_group.getString("v"));
				//sch.addElement(rs_cscosting_group.getString("s_options"));
				t_group++;
				}
			}
			rs_cscosting_group.close();
	//out.println("the total"+t_group+"tHE Normal"+t_costing);
	String blank_off="";String sills="";String snap_ons="";String shape="";
	if (t_group>0){
		out.println("<tr><td><b>"+lvr_sec_desc+" </b></td></tr>");
		for(int mn=0;mn<t_group;mn++){
		//out.println(mn+"::"+t_group);
			for (int n=0;n<t_costing;n++){
					if((model_group.elementAt(mn).toString().equals(model.elementAt(n).toString()))&(finish_group.elementAt(mn).toString().equals(finish.elementAt(n).toString()))&(screen_group.elementAt(mn).toString().equals(screen.elementAt(n).toString()))){
//							if ((n%2)==1){bgcolor="#EFEFDE";}else {bgcolor="#FFFFFF";}
							if ((n%2)==1){bgcolor="#FFFFFF";}else {bgcolor="#F1F1F1";}
							boolean isMod=false;
														boolean isMyr=false;
														String cellsize="";
														String grilldepth="";
														String thickness="";
							String angle="";
							if(bcount==0){

								out.println("<table width='100%' cellspacing='1' cellpadding='2' border='0'>");
								for (int v=0;v<k;v++){
								//out.println(v+"::"+k);
									if ((line_no.elementAt(v).toString()).equals((item_all.elementAt(n).toString()))){
										if ((block_id.elementAt(v).toString()).equals("A_PRICING")){
											out.println("<tr width='100%'><td colspan='7' class='mainbody'>"+desc.elementAt(v).toString()+"</td></tr>");
										}
										else if ((block_id.elementAt(v).toString()).equals("A_APRODUCT")){
											if(desc.elementAt(v).toString().indexOf("MODULAR")>=0){
												isMod=true;
											}
											if(desc.elementAt(v).toString().indexOf("MYR")>=0){
												isMyr=true;
											}
										}
										else if ((block_id.elementAt(v).toString()).equals("E_DIM")){
											//out.println("HERE1<BR>");
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
											if(isMod || isMyr){
												//out.println("::::::::::::::::::"+desc.elementAt(v).toString()+"::<BR>");
												String tempdesc=desc.elementAt(v).toString().substring(desc.elementAt(v).toString().indexOf("@")+1);
												tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@"));
												tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
												tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
												tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
												tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
												tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
												cellsize=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
												tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
												grilldepth=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
												tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
												thickness=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
												tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
												angle=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
											}
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
						 	ResultSet rs_csscreen = stmt.executeQuery("select description from cs_screen where code='"+screen.elementAt(n).toString()+"'");
					  		if (rs_csscreen !=null) {
						        while (rs_csscreen.next()) {
								screen_desc= rs_csscreen.getString("description");
								}
							}
							rs_csscreen.close();
							if(screen_desc.trim().length()>0){out.println("<tr width='100%'><td colspan='7' class='mainbody'>"+screen_desc+"</td></tr>");}
							if(finish_desc.trim().length()>0){out.println("<tr width='100%'><td colspan='7' class='mainbody'>"+finish_desc+"</td></tr>");}
							out.println("<tr height='20'>");
							out.println("<td width='5%' bgcolor='#cccccc' class='schedule'><b><u>Mark</u></b></td>");
							out.println("<td width='5%' bgcolor='#cccccc' class='schedule'><b><u>Qty</u></b></td>");
							out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>Size</u></b></td>");
							//out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>Schedule</u></b></td>");
							//out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>Shape</u></b></td>");
							//out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>Blank Off</u></b></td>");
							//out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>Sills</u></b></td>");
							Vector a1=new Vector();String a3="";Vector optName=new Vector();Vector optDesc=new Vector();

							if(isMod || isMyr){
								out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>Cell Size</u></b></td>");
								out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>Grille Depth</u></b></td>");
								out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>Thickness</u></b></td>");
								out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>Angle</u></b></td>");
								out.println("</tr>");
							}
							else{

								String schedule="";
								if(sch.elementAt(n).toString() != null){
									schedule=sch.elementAt(n).toString();
								}
								else{
									schedule="0000";
								}

								if(schedule.trim().length()>=4){
									for(int a2=0; a2<4; a2++){
										a1.addElement(schedule.substring(a2,a2+1));
									}
								}
								if(schedule.length()>4){
									a3=schedule.substring(4);
									//a3=""+for11.format(new Double(a3).doubleValue()/12)+" feet";
								}
								for(int a4=0; a4<a1.size(); a4++){
									ResultSet rsSch=stmt.executeQuery("Select opt_name,opt_desc from cs_sch_opts where opt_index='"+(a4+1)+"' and opt_code='"+a1.elementAt(a4).toString()+"' and prod_id='GRILLE'");
									if(rsSch != null){
										int test=0;
										while(rsSch.next()){
											test++;
											//out.println((a4+1)+"here<BR>");
											if(rsSch.getString(1) != null){
												optName.addElement(rsSch.getString(1));
											}
											else{
												optName.addElement("");
											}
											if(rsSch.getString(2) != null){
												optDesc.addElement(rsSch.getString(2));
											}
											else{
												optDesc.addElement("");
											}
											//out.println(rsSch.getString(1)+"::"+rsSch.getString(2)+"<BR>");
										}
										if(test==0){
											optName.addElement("");
											optDesc.addElement("");
										}
									}
									else{
										optName.addElement("");
										optDesc.addElement("");
									}
									rsSch.close();
								}

								out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>"+optName.elementAt(0).toString()+"</u></b></td>");
								out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>"+optName.elementAt(3).toString()+"</u></b></td>");
								out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>"+optName.elementAt(1).toString()+"</u></b></td>");
								out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>"+optName.elementAt(2).toString()+"</u></b></td>");
							}

							out.println("</tr>");
							out.println("<tr>");
							out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+mark.elementAt(n).toString()+"</td>");
							out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+for12.format(new Double(qty.elementAt(n).toString()).doubleValue())+"</td>");
							out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+width.elementAt(n).toString()+" x "+height.elementAt(n).toString()+"</td>");
							if(blank_off.trim().length()<=0){blank_off="NONE";}
							if(sills.trim().length()<=0){sills="NONE";}
							if(snap_ons.trim().length()<=0){snap_ons="NONE";}
	//						if(shape.trim().length()<=0){shape=" ";}

						if(isMod || isMyr){
									out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+cellsize+"</td>");
									out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+grilldepth+"</td>");
									out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+thickness+"</td>");
									out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+angle+" degrees</td>");
								}
							else{
								//out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+sch.elementAt(n).toString()+"</td>");

								out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+optDesc.elementAt(0).toString()+"</td>");
								out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+a3.toString()+"</td>");
								out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+optDesc.elementAt(1).toString()+"</td>");
								out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+optDesc.elementAt(2).toString()+"</td>");
								//out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+shape+"</td>");
								//out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+blank_off+"</td>");
								//out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+sills+"</td>");
	//							//out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+snap_ons+"</td>");
							}

							out.println("</tr>");
							bcount++;finish_desc="";screen_desc="";rs_csscreen.close();rs_csfinish.close();
							}
							else{
								/*
								boolean isMod=false;
								boolean isMyr=false;
								String cellsize="";
								String grilldepth="";
								String thickness="";
								String angle="";
								*/
								for (int v=0;v<k;v++){

									if ((line_no.elementAt(v).toString()).equals((item_all.elementAt(n).toString()))){
										if ((block_id.elementAt(v).toString()).equals("A_APRODUCT")){
											if(desc.elementAt(v).toString().indexOf("MODULAR")>=0){
												isMod=true;
											}
											if(desc.elementAt(v).toString().indexOf("MYR")>=0){
												isMyr=true;
											}
										}
										else if ((block_id.elementAt(v).toString()).equals("E_DIM")){
											//out.println("HERE2<BR>");
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

											if(isMod || isMyr){

												//out.println("::::::::::::::::::"+desc.elementAt(v).toString()+"::<BR>");
												String tempdesc=desc.elementAt(v).toString().substring(desc.elementAt(v).toString().indexOf("@")+1);
												tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@"));
												tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
												tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
												tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
												tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
												tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
												cellsize=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
												tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
												grilldepth=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
												tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
												thickness=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
												tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
												angle=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
											}

										}
								   	}
								}















							String schedule="";
							if(sch.elementAt(n).toString() != null){
								schedule=sch.elementAt(n).toString();
							}
							else{
								schedule="0000";
							}

							Vector a1=new Vector();String a3="";Vector optName=new Vector();Vector optDesc=new Vector();
							if(schedule.trim().length()>=4){
								for(int a2=0; a2<4; a2++){
									a1.addElement(schedule.substring(a2,a2+1));
								}
							}
							if(schedule.length()>4){
								a3=schedule.substring(4);
								//a3=""+for11.format(new Double(a3).doubleValue()/12)+" feet";
							}
							for(int a4=0; a4<a1.size(); a4++){
								ResultSet rsSch=stmt.executeQuery("Select opt_name,opt_desc from cs_sch_opts where opt_index='"+(a4+1)+"' and opt_code='"+a1.elementAt(a4).toString()+"' and prod_id='GRILLE'");
								if(rsSch != null){
									int test=0;
									while(rsSch.next()){
										test++;
										//out.println((a4+1)+"here<BR>");
										if(rsSch.getString(1) != null){
											optName.addElement(rsSch.getString(1));
										}
										else{
											optName.addElement("");
										}
										if(rsSch.getString(2) != null){
											optDesc.addElement(rsSch.getString(2));
										}
										else{
											optDesc.addElement("");
										}
										//out.println(rsSch.getString(1)+"::"+rsSch.getString(2)+"<BR>");
									}
									if(test==0){
										optName.addElement("");
										optDesc.addElement("");
									}
								}
								else{
									optName.addElement("");
									optDesc.addElement("");
								}
								rsSch.close();
							}





















							if(blank_off.trim().length()<=0){blank_off="NONE";}
							if(sills.trim().length()<=0){sills="NONE";}
							if(snap_ons.trim().length()<=0){snap_ons="NONE";}
//							if(shape.trim().length()<=0){shape=" ";}
							out.println("<tr>");
							out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+mark.elementAt(n).toString()+"</td>");
							out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+for12.format(new Double(qty.elementAt(n).toString()).doubleValue())+"</td>");
							out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+width.elementAt(n).toString()+" x "+height.elementAt(n).toString()+"</td>");
			//				out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+shape+"</td>");
			//				out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+blank_off+"</td>");
			//				out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+sills+"</td>");
//							out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+snap_ons+"</td>");
							if(isMod || isMyr){
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+cellsize+"</td>");
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+grilldepth+"</td>");
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+thickness+"</td>");
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+angle+" degrees</td>");
							}
							else{
								out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+optDesc.elementAt(0).toString()+"</td>");
								out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+a3.toString()+"</td>");
								out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+optDesc.elementAt(1).toString()+"</td>");
								out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+optDesc.elementAt(2).toString()+"</td>");
							}
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
	     <!--
	     <table cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
	     	<td class='tableline_row mainbody' width='50%' valign='middle'><b>Total SQFT: <%=sqft%></b></td>


	     	</td>
	     </tr>
		</table>-->
		<%
	    // out.println("<table><tr><td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+"Total SQFT: "+sqft+"</td></tr><table>");
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
	Vector sch=new Vector();
	double totprice=0;String line_cost="";double line_price=0;String qual_sect="";String exec_sect="";
   	for(int ye=0;ye<sect_group.size();ye++){
   		double sqft=0;
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
			<%@ include file="quote_template_header_psa.jsp"%>
			<%@ include file="quote_template_top_psa.jsp"%>
			<%
		}
		// the body of the quote per section
		NumberFormat for12 = NumberFormat.getInstance();
		for12.setMaximumFractionDigits(0);
		int k=0;String bgcolor="";Vector mark=new Vector();Vector desc=new Vector();Vector qty=new Vector();Vector rec_no=new Vector();int bcount=0;
		Vector line_no=new Vector();Vector block_id=new Vector();Vector field20=new Vector();Vector width=new Vector();Vector height=new Vector();Vector screen=new Vector();Vector finish=new Vector();
		Vector model=new Vector();Vector model_group=new Vector();Vector screen_group=new Vector();Vector finish_group=new Vector();Vector group_count=new Vector();Vector item_all=new Vector();
		ResultSet rs_csquotes = stmt.executeQuery("select * from csquotes where order_no='"+order_no+"' and line_no in("+sect_group_lines.elementAt(ye).toString()+") order by cast(Line_no as integer)");
	  	if (rs_csquotes !=null) {
		        while (rs_csquotes.next()) {
				line_no.addElement(rs_csquotes.getString("Line_no"));
				desc.addElement(rs_csquotes.getString("Descript"));
				block_id.addElement(rs_csquotes.getString("block_id"));
				rec_no.addElement(rs_csquotes.getString("Record_no"));
				field20.addElement(rs_csquotes.getString("field20"));
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
				sch.addElement(rs_cscosting.getString("s_options"));
				sqft=sqft+new Double(rs_cscosting.getString("sqft")).doubleValue();
				t_costing++;
			}
		}
		rs_cscosting.close();
		int t_group=0;
	 	ResultSet rs_cscosting_group = stmt.executeQuery("SELECT MODEL,FINISH,SCREEN,COUNT(*)as v from cs_costing where order_no='"+order_no+"' and item_no in("+sect_group_lines.elementAt(ye).toString()+") GROUP BY MODEL,FINISH,SCREEN");
	  	if (rs_cscosting_group !=null) {
		        while (rs_cscosting_group.next()) {
				model_group.addElement(rs_cscosting_group.getString("model"));
				finish_group.addElement(rs_cscosting_group.getString("finish"));
				screen_group.addElement(rs_cscosting_group.getString("screen"));
				group_count.addElement(rs_cscosting_group.getString("v"));
				//sch.addElement(rs_cscosting_group.getString("s_options"));
				t_group++;
			}
		}
		rs_cscosting.close();
		String blank_off="";String sills="";String snap_ons="";String shape="";

		if (t_group>0){
			out.println("<table width='100%' cellspacing='1' cellpadding='2' border='0'>");
			out.println("<tr><td><b>Section: "+(String)sect_group.elementAt(ye)+"</b></td></tr>");
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
			out.println("</table>");

			for(int mn=0;mn<t_group;mn++){
				for (int n=0;n<t_costing;n++){
					//out.println(n+"::"+t_costing+" HERE<BR>");
					if((model_group.elementAt(mn).toString().equals(model.elementAt(n).toString()))&(finish_group.elementAt(mn).toString().equals(finish.elementAt(n).toString()))&(screen_group.elementAt(mn).toString().equals(screen.elementAt(n).toString()))){
					//	if ((n%2)==1){bgcolor="#EFEFDE";}else {bgcolor="#FFFFFF";}
						if ((n%2)==1){bgcolor="#FFFFFF";}else {bgcolor="#F1F1F1";}

						if(bcount==0){
							boolean isMod=false;
							boolean isMyr=false;
							String cellsize="";
							String grilldepth="";
							String thickness="";
							String angle="";
							out.println("<table width='100%' cellspacing='1' cellpadding='2' border='0'>");
							for (int v=0;v<k;v++){
								if ((line_no.elementAt(v).toString()).equals((item_all.elementAt(n).toString()))){
									if ((block_id.elementAt(v).toString()).equals("A_PRICING")){
										out.println("<tr width='100%'><td colspan='7' class='mainbody'>"+desc.elementAt(v).toString()+"</td></tr>");
									}
									else if ((block_id.elementAt(v).toString()).equals("A_APRODUCT")){
										if(desc.elementAt(v).toString().indexOf("MODULAR")>=0){
											isMod=true;
										}
										if(desc.elementAt(v).toString().indexOf("MYR")>=0){
											isMyr=true;
										}
									}
									else if ((block_id.elementAt(v).toString()).equals("E_DIM")){
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
										if(isMod || isMyr){
											//out.println("::::::::::::::::::"+desc.elementAt(v).toString()+"::<BR>");
											String tempdesc=desc.elementAt(v).toString().substring(desc.elementAt(v).toString().indexOf("@")+1);
											tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@"));
											tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
											tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
											tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
											tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
											tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
											cellsize=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
											tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
											grilldepth=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
											tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
											thickness=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
											tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
											angle=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
										}
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
						 	ResultSet rs_csscreen = stmt.executeQuery("select description from cs_screen where code='"+screen.elementAt(n).toString()+"'");
						  	if (rs_csscreen !=null) {
						        	while (rs_csscreen.next()) {
									screen_desc= rs_csscreen.getString("description");
								}
							}
							rs_csscreen.close();
							out.println("<tr width='100%'><td colspan='7' class='mainbody'>"+screen_desc+"</td></tr>");
							out.println("<tr width='100%'><td colspan='7' class='mainbody'>"+finish_desc+"</td></tr>");
							out.println("<tr height='20'>");
							out.println("<td width='5%' bgcolor='#cccccc' class='schedule'><b><u>Mark</u></b></td>");
							out.println("<td width='5%' bgcolor='#cccccc' class='schedule'><b><u>Qty</u></b></td>");
							out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>Size</u></b></td>");
							Vector a1=new Vector();String a3="";Vector optName=new Vector();Vector optDesc=new Vector();
							if(isMod || isMyr){
								//out.println("HERE");
								out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>Cell Size</u></b></td>");
								out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>Grille Depth</u></b></td>");
								out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>Thickness</u></b></td>");
								out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>Angle</u></b></td>");
								out.println("</tr>");
							}
							else{
								String schedule="";
								if(sch.elementAt(n).toString() != null){
									schedule=sch.elementAt(n).toString();
								}
								else{
									schedule="0000";
								}


								if(schedule.trim().length()>=4){
									for(int a2=0; a2<4; a2++){
										a1.addElement(schedule.substring(a2,a2+1));
									}
								}
								//out.println(schedule+"::"+schedule.substring(4));

								if(schedule.length()>4){
									a3=schedule.substring(4);
									//a3=""+for11.format(new Double(a3).doubleValue()/12)+" feet";
								}

								for(int a4=0; a4<a1.size(); a4++){
									ResultSet rsSch=stmt.executeQuery("Select opt_name,opt_desc from cs_sch_opts where opt_index='"+(a4+1)+"' and opt_code='"+a1.elementAt(a4).toString()+"' and prod_id='GRILLE'");
									if(rsSch != null){
										int test=0;
										while(rsSch.next()){
											test++;
											//out.println((a4+1)+"here<BR>");
											if(rsSch.getString(1) != null){
												optName.addElement(rsSch.getString(1));
											}
											else{
												optName.addElement("");
											}
											if(rsSch.getString(2) != null){
												optDesc.addElement(rsSch.getString(2));
											}
											else{
												optDesc.addElement("");
											}
											//out.println(rsSch.getString(1)+"::"+rsSch.getString(2)+"<BR>");
										}
										if(test==0){
											optName.addElement("");
											optDesc.addElement("");
										}
									}
									else{
										optName.addElement("");
										optDesc.addElement("");
									}
									rsSch.close();
								}

								out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>"+optName.elementAt(0).toString()+"</u></b></td>");
								out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>"+optName.elementAt(3).toString()+"</u></b></td>");
								out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>"+optName.elementAt(1).toString()+"</u></b></td>");
								out.println("<td width='9%' bgcolor='#cccccc' class='schedule'><b><u>"+optName.elementAt(2).toString()+"</u></b></td>");
								out.println("</tr>");
							}
							out.println("<tr>");
							out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+mark.elementAt(n).toString()+"</td>");
							out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+for12.format(new Double(qty.elementAt(n).toString()).doubleValue())+"</td>");
							out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+width.elementAt(n).toString()+" x "+height.elementAt(n).toString()+"</td>");
							//out.println("HERE4");
							if(isMod || isMyr){
							//out.println("HERE2");
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+cellsize+"&nbsp;</td>");
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+grilldepth+"&nbsp;</td>");
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+thickness+"&nbsp;</td>");
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+angle+"&nbsp; degrees</td>");
							}
							else{
							//out.println("HERE3");
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+optDesc.elementAt(0).toString()+"</td>");
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+a3.toString()+"</td>");
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+optDesc.elementAt(1).toString()+"</td>");
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+optDesc.elementAt(2).toString()+"</td>");
							}
							if(blank_off.trim().length()<=0){blank_off="NONE";}
							if(sills.trim().length()<=0){sills="NONE";}
							if(snap_ons.trim().length()<=0){snap_ons="NONE";}
							out.println("</tr>");
							bcount++;finish_desc="";screen_desc="";rs_csscreen.close();rs_csfinish.close();

						}

						else{
							boolean isMod=false;
							boolean isMyr=false;
							String cellsize="";
							String grilldepth="";
							String thickness="";
							String angle="";
							for (int v=0;v<k;v++){
								if ((line_no.elementAt(v).toString()).equals((item_all.elementAt(n).toString()))){
									if ((block_id.elementAt(v).toString()).equals("A_APRODUCT")){
										if(desc.elementAt(v).toString().indexOf("MODULAR")>=0){
											isMod=true;
										}
										if(desc.elementAt(v).toString().indexOf("MYR")>=0){
											isMyr=true;
										}
									}
									else if ((block_id.elementAt(v).toString()).equals("E_DIM")){
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
										if(isMod || isMyr){
											//out.println("::::::::::::::::::"+desc.elementAt(v).toString()+"::<BR>");
											String tempdesc=desc.elementAt(v).toString().substring(desc.elementAt(v).toString().indexOf("@")+1);
											tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@"));
											tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
											tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
											tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
											tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
											tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
											cellsize=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
											tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
											grilldepth=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
											tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
											thickness=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
											tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
											angle=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
										}
									}
								}
							}
							if(blank_off.trim().length()<=0){blank_off="NONE";}
							if(sills.trim().length()<=0){sills="NONE";}
							if(snap_ons.trim().length()<=0){snap_ons="NONE";}
							Vector a1=new Vector();String a3="";Vector optName=new Vector();Vector optDesc=new Vector();




							if(!isMod && !isMyr){

								String schedule="";
								if(sch.elementAt(n).toString() != null){
									schedule=sch.elementAt(n).toString();
								}
								else{
									schedule="0000";
								}


								if(schedule.trim().length()>=4){
									for(int a2=0; a2<4; a2++){
										a1.addElement(schedule.substring(a2,a2+1));
									}
								}
								//out.println(schedule+"::"+schedule.substring(4));

								if(schedule.length()>4){
									a3=schedule.substring(4);
									//a3=""+for11.format(new Double(a3).doubleValue()/12)+" feet";
								}

								for(int a4=0; a4<a1.size(); a4++){
									ResultSet rsSch=stmt.executeQuery("Select opt_name,opt_desc from cs_sch_opts where opt_index='"+(a4+1)+"' and opt_code='"+a1.elementAt(a4).toString()+"' and prod_id='GRILLE'");
									if(rsSch != null){
										int test=0;
										while(rsSch.next()){
											test++;
											//out.println((a4+1)+"here<BR>");
											if(rsSch.getString(1) != null){
												optName.addElement(rsSch.getString(1));
											}
											else{
												optName.addElement("");
											}
											if(rsSch.getString(2) != null){
												optDesc.addElement(rsSch.getString(2));
											}
											else{
												optDesc.addElement("");
											}
											//out.println(rsSch.getString(1)+"::"+rsSch.getString(2)+"<BR>");
										}
										if(test==0){
											optName.addElement("");
											optDesc.addElement("");
										}
									}
									else{
										optName.addElement("");
										optDesc.addElement("");
									}
									rsSch.close();
								}

							}









							out.println("<tr>");
							out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+mark.elementAt(n).toString()+"</td>");
							out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+for12.format(new Double(qty.elementAt(n).toString()).doubleValue())+"</td>");
							out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+width.elementAt(n).toString()+" x "+height.elementAt(n).toString()+"</td>");
							if(isMod || isMyr){
								//out.println("HERE2");
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+cellsize+"&nbsp;</td>");
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+grilldepth+"&nbsp;</td>");
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+thickness+"&nbsp;</td>");
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+angle+"&nbsp; degrees</td>");
							}
							else{
								//out.println("HERE3");
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+optDesc.elementAt(0).toString()+"</td>");
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+a3.toString()+"</td>");
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+optDesc.elementAt(1).toString()+"</td>");
								out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc'>"+optDesc.elementAt(2).toString()+"</td>");
							}
							if(blank_off.trim().length()<=0){blank_off="NONE";}
							if(sills.trim().length()<=0){sills="NONE";}
							if(snap_ons.trim().length()<=0){snap_ons="NONE";}
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

		for1.setMaximumFractionDigits(0);
		price=for1.format(grand_total);
		for1.setMaximumFractionDigits(2);
		%>

	     	<table cellspacing='0' cellpadding='0' border='0' width='100%' height='25'>
	     	<tr>
	     	<td class='tableline_row mainbody' width='50%' valign='middle'>
	     	<b>Total SQFT: <%=sqft%></b>
	     	</td>
	     	</tr>
		</table>
		<%//@ include file="psa_quote_cran_price_block.jsp"%>
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
		// the body of the quote per section ends
		//footer for new pages
		if(section_page==null||section_page.equals("1")){
			%>
			<%@ include file="quote_template_foot_psa.jsp"%>
			<%@ include file="quote_template_footer_psa.jsp"%>
			<%
			if(sect_group.size()-ye>1){out.println("<p style='page-break-after : always;' >&nbsp;</p>");}
		}
		totprice=0;exec_sect="";qual_sect="";
	}// the main for loop
}// if there are sections

%>




