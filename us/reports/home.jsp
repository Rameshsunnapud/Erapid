<HTML>
	<HEAD>
		<LINK href="craft.css" type=text/css rel=stylesheet>
		<title>Shop paper </title>
		<script language="JavaScript" src="../../test/date-picker.js"></script>
		<SCRIPT LANGUAGE="JavaScript">
			<!-- Begin
			function checkAll(var1){
				//alert(document.checkboxform.checkbox.length)
				//alert("The form object count: "+var1)
				///alert("Should have been: "+var1+" not sure why?.......thinking")
				if(document.calform.cy.checked){
					for(var j=1;j<=var1;j++){
						box=eval("document.calform.C"+j);
						//				alert(box.checked)
						if(box.checked==false)
							box.checked=true;
					}

				}
				else{
					for(var j=1;j<=var1;j++){
						box=eval("document.calform.C"+j);
						//				alert(box.checked)
						if(box.checked==true)
							box.checked=false;
					}

				}
			}
			//  End -->
		</script>

		<SCRIPT language="JavaScript">
			<!--
			function n_window(theurl)
			{
				// set width and height
				var the_width=400;
				var the_height=400;
				// set window position
				var from_top=150;
				var from_left=250;
				// set other attributes
				var has_toolbar='no';
				var has_location='no';
				var has_directories='no';
				var has_status='yes';
				var has_menubar='yes';
				var has_scrollbars='yes';
				var is_resizable='yes';
				// atrributes put together
				var the_atts='width='+the_width+',height='+the_height+',top='+from_top+',screenY='+from_top+',left='+from_left+',screenX='+from_left;
				the_atts+=',toolbar='+has_toolbar+',location='+has_location+',directories='+has_directories+',status='+has_status;
				the_atts+=',menubar='+has_menubar+',scrollbars='+has_scrollbars+',resizable='+is_resizable;
				// open the window
				window.open(theurl,'',the_atts);
			}
			//-->
		</SCRIPT>


	</head>
	<BODY bgColor=#f1f1f1 leftMargin=0 topMargin=0>
		<TABLE height="100%" bgColor=#f1f1f1 cellSpacing=0 cellPadding=0 class='nob' width="100%" border=0>
			<tr>
				<td valign="top" height='60' bgcolor="#330099"><img src="../../images/img_logo.jpg" border="0" alt="" width="797" height="68">&nbsp;</td>
				<td height="60" valign="top" bgcolor="#330099"><IMG height=1 src="" width=175>&nbsp;</td>
			</TR>
			<TR>
				<TD colspan='2' class='test'>&nbsp;</TD>
			</TR>
			<TR><td valign="top" colspan='2'>
					<table border='0' bgColor=#f1f1f1 cellSpacing=0 cellPadding=0 class='nob1' width="100%">
						<tr>
							<TD vAlign=bottom noWrap align=middle>&nbsp;&nbsp;Shop Header&nbsp;&nbsp;</TD>
							<TD noWrap width=1 bgColor=#e1e1e1><IMG height=1 src="" width=1></TD>
							<TD width="100%"><IMG height=1 src="" width=1></TD>
						</tr>
					</table>
				</td>
			</TR>
			<form name="calform"  id="search" method="get" action="shop_header_save.jsp">
				<TR >
					<TD vAlign=top colspan='2'  width="100%">
						<TABLE cellSpacing=0 bgColor=#f1f1f1 cellPadding=0  width="100%" border=0>
							<tr>
								<td width='10%'>&nbsp;</td>
								<td width='80%' class='box' align='center'>
									<TABLE cellSpacing=0 bgColor=#f1f1f1 cellPadding=0  width="80%" border=0>
										<tr>
											<td align='left' valign='top' width='30%' ><div class="regnow-header">Shop Header info::</div></td>
											<td align='center' valign="top" colspan='1' width='15%'>&nbsp;</td>
											<td align='center' valign="top" colspan='1' width='55%'>&nbsp;</td>
										</tr>
										<tr><td align='center' valign="top" colspan='3'>&nbsp;</td></tr>
										<tr>
											<td align='right'  colspan='2'>BPCS Customer Order no:</td>
											<td align='left'  colspan='1'><input type="text" class="text" name="bpcs_no" value='<%= bpcs_no %>' size='12' title="Search" />
											</td>
										</tr>
										<tr>
											<td align='right' colspan='2'>Date Due:</td>
											<td align='left' colspan='1' valgin='bottom'><input type="text" class="text" name="due_date" value='<%= due_date %>' size="12" readonly >
												<a href="javascript:show_calendar('calform.due_date');" onmouseover="window.status='Date Picker';
														return true;" onmouseout="window.status='';
																return true;">
													<img src="../../images/cal.gif" id="imgCalendar2" name="imgCalendar2"  height=22 border=0></a>
											</td>

										</tr>
										<tr>
											<td align='right'  colspan='2'>CSE Order no:</td>
											<td align='left'  colspan='1'><input type="text" class="text" name="order_no" value=<%= order_no %> readonly size="12" title="Search" />
											</td>
										</tr>
										<tr>
											<td align='right'  colspan='2'>Planner:</td>
											<td align='left'  colspan='1'><input type="text" class="text" name="planner"  value='<%= planner %>' size="30" >
											</td>
										</tr>
										<tr>
											<td align='right' colspan='2'>Project Name:</td>
											<td align='left' colspan='1'><input type="text" class="text" name="sp-q" value='<%= project_name %>' readonly size="40" />
											</td>
										</tr>

										<tr><td align='center'  colspan='3'>&nbsp;</td></tr>
										<tr><td align='center'  colspan='3'>&nbsp;</td></tr>
										<tr><td align='center'  colspan='3'><font color='red'> Shop Header information doesn't exist for this job.
												Please enter header information to proceed further.</font></td></tr>
										<tr><td align='center'  colspan='3'>&nbsp;</td></tr>
										<tr>
											<td align='left' valign='top' width='30%' ><div class="regnow-header">Shop Order info::</div></td>
											<td align='center' valign="top" colspan='1' width='15%'>&nbsp;</td>
											<td align='center' valign="top" colspan='1' width='55%'>&nbsp;</td>
										</tr>
										<tr><td align='center' colspan='3'>&nbsp;</td></tr>
										<!--New row for the bpcs table info-->
										<TR>
											<td valign="top" colspan='3'>
												<table width="100%" border="1" cellspacing="0" bgColor="white"  cellpadding="0" bordercolor=#f1f1f1>
													<tr>
														<TD vAlign=bottom noWrap bgColor='#f1f1f1' align=middle>&nbsp;</TD>
														<TD vAlign=bottom noWrap bgColor='#6699CC' align=middle><font color='white'>#</font></TD>
														<TD vAlign=bottom noWrap bgColor='#6699CC' align=middle><font color='white'>Type</font></TD>
														<TD vAlign=bottom noWrap bgColor='#6699CC' align=middle><font color='white'>BPCS Part no</font></TD>
														<TD vAlign=bottom noWrap bgColor='#6699CC' width='15%' align=middle><font color='white'>CSE Item no</font></TD>
														<TD vAlign=bottom noWrap bgColor='#6699CC' align=middle><font color='white'>Shop Order Number</font></TD>
														<TD vAlign=bottom noWrap bgColor='#f1f1f1' align=middle>&nbsp;</TD>
													</tr>
													<%
													int shop_orders=0;// The looping for materials
													int tester=0;int tester1=0;int tester2=0;String checker="";
													for (int i=0;i<rout_tot_count;i++){
																out.println("<tr>");
																out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f1' align=middle>&nbsp;</TD>");
																out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f1' colspan='5' align=left >"+detail_desc.elementAt(i)+"</TD>");
																out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f1' align=middle>&nbsp;</TD>");
																out.println("</tr>");
															for (int j=0;j<mat_tot_count;j++){
																	if (item_no.elementAt(j).toString().equals(item_no_rout.elementAt(i).toString()))   {
																			if ((text_identifier.elementAt(j).toString().startsWith("FRAMES"))){
																				if (tester1==0){
																				frame_counter.addElement(new String().valueOf(j));
																				tester1++;
																//				out.println("The j value"+j+"<br>");
																				}
																			}
																			else if((text_identifier.elementAt(j).toString().startsWith("PANS"))){
																				if (tester2==0){
																				shop_orders++;
																				out.println("<tr>");
																				out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f1' align=middle>&nbsp;</TD>");
																				out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=middle>"+shop_orders+"</TD>");
																				out.println("<input type='hidden' name='seq_no"+shop_orders+"' value='"+shop_orders+"' >");
																				out.println("<input type='hidden' name='product"+shop_orders+"' value='pan' >");
																				out.println("<input type='hidden' name='bpcs_part_no"+shop_orders+"' value='"+bpcs_part_sub.elementAt(j)+"' >");
																				out.println("<input type='hidden' name='item_no"+shop_orders+"' value='"+item_no.elementAt(j)+"' >");
																				out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=middle>"+"Pan"+"</TD>");
																				out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=middle>"+bpcs_part_sub.elementAt(j)+"</TD>");
																				out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=middle>"+item_no.elementAt(j)+"</TD>");
																				if((bpcs_mat_tot_count<=0)) {
																				out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=middle>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' class='text' name='shop_order"+shop_orders+"'  length='6' value='' size='6' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for='sgr'><input type='checkbox' id='sgr' name='C"+shop_orders+"' ></label></TD>");
																				}
																				else{
																						String c1="";String c2="";String c3="";int final_count=0;String c4="";String flag="";String sent="";
																					 for(int k=0;k<bpcs_mat_tot_count;k++){
																							c1=detail_desc_bpcs.elementAt(k).toString();c2=bpcs_part_sub_bpcs.elementAt(k).toString();c3=item_no_bpcs.elementAt(k).toString();c4=transfer.elementAt(k).toString();
																							if(c4.equals("Y")){flag="checked";}else{flag="";}
																							if ((c1.equals("pan"))&(c2.equals(bpcs_part_sub.elementAt(j).toString()))&(c3.equals(item_no.elementAt(j).toString()))){
																							// to see if the job has been sent already
																							for(int mun=0;mun<ikea;mun++){
																									if(bpcs_shop_order_no.elementAt(k).toString().trim().equals(transfered_shop_no.elementAt(mun).toString().trim())){
																									sent="  Already sent "+transfered_counter.elementAt(mun)+" times";
																									}
																							}
																							// to see if the job has been sent already done
																						    out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=LEFT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' class='text' name='shop_order"+shop_orders+"'  length='6' value='"+bpcs_shop_order_no.elementAt(k)+"' size='6' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for='sgr'><input type='checkbox' "+flag+" id='sgr' name='C"+shop_orders+"' ></label>"+sent+"</TD>");
																							final_count++;
																							}
																						  }
																						if(final_count<=0){
																						    out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=LEFT><input type='text' class='text' name='shop_order"+shop_orders+"'  length='6' value='' size='6' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for='sgr'><input type='checkbox' id='sgr' name='C"+shop_orders+"' ></label></TD>");
																							}

																				}
																				out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f1' align=middle>&nbsp;</TD>");
																			    out.println("</tr>");
																				tester2++;
																				}
																			}
																			else {
																				if (tester==0){
																				shop_orders++;
																				out.println("<tr>");
																				out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f1' align=middle>&nbsp;</TD>");
																				out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=middle>"+shop_orders+"</TD>");
																				out.println("<input type='hidden' name='seq_no"+shop_orders+"' value='"+shop_orders+"' >");
																				out.println("<input type='hidden' name='product"+shop_orders+"' value='product' >");
																				out.println("<input type='hidden' name='bpcs_part_no"+shop_orders+"' value='"+bpcs_part_main.elementAt(j)+"' >");
																				out.println("<input type='hidden' name='item_no"+shop_orders+"' value='"+item_no.elementAt(j)+"' >");
																				out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=middle>"+"Product"+"</TD>");
																				out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=middle>"+bpcs_part_main.elementAt(j)+"</TD>");
																				out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=middle>"+item_no.elementAt(j)+"</TD>");
																				if((bpcs_mat_tot_count<=0)) {
																				out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=LEFT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' class='text' name='shop_order"+shop_orders+"'  length='6' value='' size='6' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for='sgr'><input type='checkbox' id='sgr' name='C"+shop_orders+"' ></label></TD>");
																				}
																				else{
																						String c1="";String c2="";String c3="";int final_count=0;String c4="";String flag="";String sent="";
																					 for(int k=0;k<bpcs_mat_tot_count;k++){
																							c1=detail_desc_bpcs.elementAt(k).toString();c2=bpcs_part_sub_bpcs.elementAt(k).toString();c3=item_no_bpcs.elementAt(k).toString();c4=transfer.elementAt(k).toString();
																							if(c4.equals("Y")){flag="checked";}else{flag="";}
																							if ((c1.equals("product"))&(c2.equals(bpcs_part_main.elementAt(j).toString()))&(c3.equals(item_no.elementAt(j).toString()))){
																								// to see if the job has been sent already
																								for(int mun=0;mun<ikea;mun++){
																										if(bpcs_shop_order_no.elementAt(k).toString().trim().equals(transfered_shop_no.elementAt(mun).toString().trim())){
																										sent="  Already sent "+transfered_counter.elementAt(mun)+" times";
																									//	out.println("The times "+sent+"shop "+bpcs_shop_order_no.elementAt(k).toString()+"shop also "+transfered_shop_no.elementAt(mun).toString()+" @ "+"vee"+item_no.elementAt(j).toString()+"<br>");
																										}
																								}
																								// to see if the job has been sent already done
					//																		out.println("the outer K"+sent+"<br>");
																						    out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=LEFT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' class='text' name='shop_order"+shop_orders+"'  length='6' value='"+bpcs_shop_order_no.elementAt(k)+"' size='6' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for='sgr'><input type='checkbox' "+flag+" id='sgr' name='C"+shop_orders+"' ></label>"+sent+"</TD>");
																							final_count++;
																							}
																					  }
																						if(final_count<=0){
																						    out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=LEFT><input type='text' class='text' name='shop_order"+shop_orders+"'  length='6' value='' size='6' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for='sgr'><input type='checkbox' id='sgr' name='C"+shop_orders+"' ></label></TD>");
																						}

																				}
																				out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f1' align=middle>&nbsp;</TD>");
																			    out.println("</tr>");
																				tester++;
																				}
																			}
																	}
															}
													tester=0;tester1=0;tester2=0;
													}
					//out.println("Frame Counter "+frame_counter.size()+", ");
											int frame_grouper=0;
										for(int k2=0;k2<frame_count;k2++){
												if (k2==0){
													out.println("<tr>");
													out.println("<TD vAlign=bottom noWrap colspan='8' bgColor='#f1f1f1' align=middle>&nbsp;</TD>");
												    out.println("</tr>");
												}
											for(int kl=0;kl<frame_counter.size();kl++){
												int where=new Integer (frame_counter.elementAt(kl).toString()).intValue();
												checker=rout_sum_bpcs_part_sub.elementAt(k2).toString();
												if ((checker.equals(bpcs_part_sub.elementAt(where)))&(frame_grouper<=0)){
												frame_grouper++;
												shop_orders++;
												out.println("<tr>");
												out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f1' align=middle>&nbsp;</TD>");
												out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=middle>"+shop_orders+"</TD>");
												out.println("<input type='hidden' name='seq_no"+shop_orders+"' value='"+shop_orders+"' >");
												out.println("<input type='hidden' name='product"+shop_orders+"' value='frame' >");
												out.println("<input type='hidden' name='bpcs_part_no"+shop_orders+"' value='"+bpcs_part_sub.elementAt(where)+"' >");
												out.println("<input type='hidden' name='item_no"+shop_orders+"' value='"+item_no.elementAt(where)+"' >");
												out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=middle>"+"Frame"+"</TD>");
												out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=middle>"+bpcs_part_sub.elementAt(where)+"</TD>");
												out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=middle>"+item_no.elementAt(where)+"</TD>");
													if((bpcs_mat_tot_count<=0)) {
													out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=LEFT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' class='text' name='shop_order"+shop_orders+"'  length='6' value='' size='6' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for='sgr'><input type='checkbox' id='sgr' name='C"+shop_orders+"' ></label></TD>");
													}
													else{
															String c1="";String c2="";String c3="";int final_count=0;String c4="";String flag="";String sent="";
														 for(int k=0;k<bpcs_mat_tot_count;k++){
																c1=detail_desc_bpcs.elementAt(k).toString();c2=bpcs_part_sub_bpcs.elementAt(k).toString();c3=item_no_bpcs.elementAt(k).toString();c4=transfer.elementAt(k).toString();
																if(c4.equals("Y")){flag="checked";}else{flag="";}
																if ((c1.equals("frame"))&(c2.equals(bpcs_part_sub.elementAt(where).toString()))&(c3.equals(item_no.elementAt(where).toString()))){
																// to see if the job has been sent already
																	for(int mun=0;mun<ikea;mun++){
																			if(bpcs_shop_order_no.elementAt(k).toString().trim().equals(transfered_shop_no.elementAt(mun).toString().trim())){
																			sent="  Already sent "+transfered_counter.elementAt(mun)+" times";
							//												out.println("yes"+sent);
																			}
																	}
																// to see if the job has been sent already done
															    out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=left>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' class='text' name='shop_order"+shop_orders+"'  length='6' value='"+bpcs_shop_order_no.elementAt(k)+"' size='6' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for='sgr'><input type='checkbox' id='sgr' "+flag+" name='C"+shop_orders+"' ></label>"+sent+"</TD>");
																final_count++;
																}
														  }
														 if(final_count<=0){
															    out.println("<TD vAlign=bottom noWrap bgColor='#cccccc' align=LEFT>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type='text' class='text' name='shop_order"+shop_orders+"'  length='6' value='' size='6' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<label for='sgr'><input type='checkbox' id='sgr' name='C"+shop_orders+"' ></label></TD>");
														 }
													}
												out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f1' align=middle>&nbsp;</TD>");
											    out.println("</tr>");
												}
											}
											frame_grouper=0;
										}
					//	out.println("THe counter"+shop_orders);

					//out.println("Shop orders"+shop_orders+", Total # Frames "+frame_counter.size());
					/*
					for(int i=0;i<frame_counter.size();i++){
					out.println("THe frames are "+frame_counter.elementAt(i));
					}*/
													%>
												</table>
											</td>
										</TR>
										<input type="hidden" name="shop_orders" value='<%= shop_orders %>' >
										<!--New row for the bpcs table info end-->
										<tr><td align='center' valign="top" colspan='3'>&nbsp;</td></tr>
										<tr>
											<td align='right'  colspan='2'>
												<input type="submit" class="button" value="Save Header" /></td>
											<td align='right'  colspan='1'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Select all&nbsp;&nbsp;<label for='sgr'><input type='checkbox' id='sgr' name=cy onClick="checkAll(<%= shop_orders %>)" ></label> </td>
										</tr>
										<tr><td align='center' valign="top" colspan='3'>&nbsp;</td></tr>
										<tr><td align='center' valign="top" colspan='3'>&nbsp;</td></tr>
										<tr><td align='center' valign="top" colspan='3'>&nbsp;</td></tr>
										<tr>
											<td align='center' valign="top" colspan='1'>&nbsp;</td>
										<!-- <td align='Right' valign="top" colspan='1'><a href="javascript:n_window('https://<%= application.getInitParameter("HOST")%>/custom/orders/ows/order_transfer_bpcs_home.jsp?order=<%= order_no %>&sections=s1')" class='new' >Transfer Order</a></td> -->
											<td align='right' colspan='2'><a href="javascript:n_window('transfer.jsp?sp-q=<%= order_no %>&cmd=5')" class='new' >Transfer Bills & Routings</a>
											</td>
										</tr>
										<%// subhas changes%>

										<%

										int display_counter=0;
										int bpcs_c1 = 0;
										int bpcs_c2 = 0;
										int track = 0;
										String bpcs_equal = "0";
										//out.println("bpcs_no");
										//out.println(bpcs_no);

										Vector bpcs_v1=new Vector();
										Vector bpcs_v2=new Vector();
										Vector bpcs_v3=new Vector();
										Vector bpcs_v4=new Vector();


										if((bpcs_no.length() == 0)||((bpcs_no.length() == 1))){
											if (bpcs_no == null){bpcs_no = "0";}
										}
										else{
											if (bpcs_no == null){bpcs_no = "0";}
										out.println("<tr>");
										out.println("<td align='left' valign='top' width='30%' ><div class='regnow-header'>BPCS Shop Order::</div></td>");
										out.println("</tr>");

										out.println("<TR>");
										out.println(" <td valign='top' colspan='3'>");
										 out.println("<table width='100%' border='1' cellspacing='0' bgColor='white' cellpadding='0' bordercolor=#f1f1f1>");
										 out.println("<tr> ");
										 out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f1' width='1%' align=middle>&nbsp;</TD>");
										 out.println("<TD vAlign=bottom noWrap bgColor='#6699CC' width='15%' align=middle><font color='white'>Line NO:</font></TD>");
										 out.println("<TD vAlign=bottom noWrap bgColor='#6699CC' width='20%' align=middle><font color='white'>Shop Order No:</font></TD>	");
										 out.println("<TD vAlign=bottom noWrap bgColor='#6699CC' width='25%' align=middle><font color='white'>Product Code</font></TD>");
										 out.println("<TD vAlign=bottom noWrap bgColor='#6699CC' width='35%' align=middle><font color='white'>Line 1 of Notes</font></TD>");
										 out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f1' width='1%' align=middle>&nbsp;</TD>");
										 out.println("<TD vAlign=bottom noWrap bgColor='#6699CC' width='25%' align=middle><font color='white'>Qty</font></TD>");
										out.println("</tr> ");
										%>
										<%@ include file="../../db_con_bpcs.jsp"%>
										<%
										    ResultSet rs_bpcs = stmt_bpcs.executeQuery("SELECT BPCSFPG.ECLL02.LORD, BPCSFPG.ECLL02.LLINE, BPCSFPG.ECLL02.CLSORD,BPCSFPG.ECLL02.LPROD, BPCSFPG.ESN.SNDESC FROM BPCSFPG.ECLL02 INNER JOIN BPCSFPG.ESN ON (BPCSFPG.ECLL02.LORD = BPCSFPG.ESN.SNCUST) AND (BPCSFPG.ECLL02.LLINE = BPCSFPG.ESN.SNSHIP) WHERE BPCSFPG.ECLL02.LORD="+ bpcs_no+" AND BPCSFPG.ESN.SNTYPE='L' AND BPCSFPG.ESN.SNSEQ=1");
											while (rs_bpcs.next()){
											bpcs_v1.addElement(rs_bpcs.getString(2));
											bpcs_v2.addElement(rs_bpcs.getString(3));
										    bpcs_v3.addElement(rs_bpcs.getString(4));
										    bpcs_v4.addElement(rs_bpcs.getString(5));
											bpcs_c1++;
											}
										stmt_bpcs.close();
										rs_bpcs.close();


										Statement stmt_bpcs1 = con_bpcs.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
										ResultSet rs_bpcs1 = stmt_bpcs1.executeQuery("SELECT BPCSFPG.FSO.SORD,BPCSFPG.FSO.SPROD,BPCSFPG.FSO.SCLIN,BPCSFPG.FSO.SQREQ FROM BPCSFPG.FSO WHERE BPCSFPG.FSO.SCORD ="+bpcs_no+" AND BPCSFPG.FSO.SID = 'SO'");
										int count_parts=1;
										if (rs_bpcs1 !=null) {
										while (rs_bpcs1.next()){
											for(int bpcs_count=0;bpcs_count<bpcs_c1;bpcs_count++){
											  if (bpcs_v2.elementAt(bpcs_count).toString().trim().equals((rs_bpcs1.getString(1)).toString().trim())){
											   bpcs_equal = "1";
											   track = bpcs_count;
											  }
											 }
												  if (bpcs_equal.equals("1")){
												 out.println("<tr>");
												 out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f1' width='1%' align=middle>&nbsp;</TD>");
												 out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f1' width='15%' align=middle>"+bpcs_v1.elementAt(track)+"</TD>");
												 out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f' width='20%' align=middle>"+bpcs_v2.elementAt(track)+"</TD>");
												 out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f' width='15%' align=middle>"+bpcs_v3.elementAt(track)+"</TD>");
												 out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f' width='25%' align=middle>"+bpcs_v4.elementAt(track)+"</TD>");
												 out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f1' width='1%' align=middle>&nbsp;</TD>");
												 //out.println("</tr>");
												 }
												 else{
												 out.println("<tr>");
												 out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f1' width='1%' align=middle>&nbsp;</TD>");
												 out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f1' width='15%' align=middle>"+rs_bpcs1.getString(3)+"</TD>");
												 out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f' width='20%' align=middle>"+rs_bpcs1.getString(1)+"</TD>");
												 out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f' width='15%' align=middle>"+rs_bpcs1.getString(2)+"</TD>");
												 out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f' width='25%' align=middle>"+"NA"+"</TD>");
												 out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f1' width='1%' align=middle>&nbsp;</TD>");
												 //out.println("</tr>");
												 }
												  out.println("<TD vAlign=bottom noWrap bgColor='#f1f1f' width='15%' align=middle>"+rs_bpcs1.getString(4)+"</TD>");
												  out.println("<input type='hidden' name='qty"+count_parts+++"' value='"+rs_bpcs1.getString(4)+"' >");
												  out.println("</tr>");
										 track = 0;
										 bpcs_equal = "0";
										}
										}

										out.println("</table>");
										out.println("</td>");

										out.println("</TR>");




										//rs_bpcs.close();
										con_bpcs.close();
										}
										//subha changes done %>



									</table>
								</td>
								<td width='10%'>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>

				<TR>
					<TD width="100%" align='center'>Copyright � 2003,2004 CS Group of Companies, All rights reserved.</TD></TR>
			</form>
		</Table>
	</body>
</html>




