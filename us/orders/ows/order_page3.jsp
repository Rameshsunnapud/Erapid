<html>
	<HEAD>
		<title>
			Order Write-up sheet <%=order_no%> <%=product%>
		</title>
		<link rel='stylesheet' href='../../../css/styleMain.css' type='text/css'/>
		<script language="JavaScript" src="check_order_sheet.js"></script>
		<script language="JavaScript" src="../../../test/date-picker.js"></script>
		<SCRIPT LANGUAGE="JavaScript">
			<!-- Begin
		function doThis(){
				//alert(document.selectform.order_no.value);
				var myurl=document.selectform.uploadUrl.value;
				var myWindow2;
				var props='scrollBars=no,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=800,height=350';
				myWindowx2=window.open(myurl,'myWindowx2',props);
				//alert("after");
				setTimeout("checkWindow();",1000);
			}
			function lineItem(){
				//alert("lineItem");
				//parent.postMessage("test","*");
				window.parent.postMessage("test2","*");
				//alert("after post");
			}
			function closeThis(x){
				window.location=x;
			}
			function checkWindow(){
				if(window.myWindowx2){
					if(myWindowx2&&typeof (myWindowx2.closed)!='unknown'&&!myWindowx2.closed){
						//alert("HERE3");
						setTimeout("checkWindow();",1000);
					}
					else{
						//alert("here2");
						document.location.reload();
					}
				}
				else{
					//alert("HERE");
					document.location.reload();
				}
			}
			function changeDraftingEmail(){
				//alert("HERE"+document.selectform.BillingEmailFrom.value);
				if(document.selectform.BillingEmailFrom.value.length>0){
					document.selectform.drafting_email.value=document.selectform.BillingEmailFrom.value;
				}
				else{
					alert("email is blank");
				}
			}









			function explain(name,output,msg){
				newwin=window.open('','','top=150,left=150,width=400%,height=400%');
				if(!newwin.opener)
					newwin.opener=self;
				with(newwin.document)
				{
					open();
					write('<html>');
					write('<head>');
					write('<link rel="stylesheet" href="style1.css" type="text/css"/>');
					write('</head>');
					write('<body onLoad="document.form.box.focus()"><form name=form><h3>'+msg+'</h3><br>');
					write('<p>Enter '+name+' here and it will be copied to the Quote for you.');
					write('<p><center>'+name+':  <textarea name=box cols=30 rows=6 onKeyUp='+output+'=this.value>'+window.document.selectform.special_notes.value+'</textarea>');
					write('<p><input type=button value="Done" class="button" onClick=window.close()>');
					write('</center></form></body></html>');
					close();
				}
			}
			//  End -->

			<!--Begin
			function explain1(name,output,msg){
				newwin=window.open('','','top=150,left=150,width=400%,height=400%');
				if(!newwin.opener)
					newwin.opener=self;
				with(newwin.document)
				{
					open();
					write('<html>');
					write('<head>');
					write('<link rel="stylesheet" href="style1.css" type="text/css"/>');
					write('</head>');
					write('<body onLoad="document.form.box.focus()"><form name=form><h3>'+msg+'</h3><br>');
					write('<p>Enter '+name+' here and it will be copied to the Quote for you.');
					write('<p><center>'+name+':  <textarea name=box cols=30 rows=6 onKeyUp='+output+'=this.value>'+window.document.selectform.order_notes.value+'</textarea>');
					write('<p><input type=button value="Done" class="button" onClick=window.close()>');
					write('</center></form></body></html>');
					close();
				}
			}
			function explain3(name,output,msg){
				newwin=window.open('','','top=150,left=150,width=400%,height=400%');
				if(!newwin.opener)
					newwin.opener=self;
				with(newwin.document)
				{
					open();
					write('<html>');
					write('<head>');
					write('<link rel="stylesheet" href="style1.css" type="text/css"/>');
					write('</head>');
					write('<body onLoad="document.form.box.focus()"><form name=form><h3>'+msg+'</h3><br>');
					write('<p>Enter '+name+' here and it will be copied to the Quote for you.');
					write('<p><center>'+name+':  <textarea name=box cols=30 rows=6 onKeyUp='+output+'=this.value>'+window.document.selectform.customer_notes.value+'</textarea>');
					write('<p><input type=button value="Done" class="button" onClick=window.close()>');
					write('</center></form></body></html>');
					close();
				}
			}
			function explain2(name,output,msg){
				newwin=window.open('','','top=75,left=75,width=800%,height=800%');
				if(!newwin.opener)
					newwin.opener=self;
				with(newwin.document)
				{
					open();
					write('<html>');
					write('<head>');
					write('<link rel="stylesheet" href="style1.css" type="text/css"/>');
					write('</head>');
					write('<body onLoad="document.form.box.focus()"><form name=form><h3>'+msg+'</h3><br>');
					write('<p>Enter '+name+' here and it will be copied to the Quote for you.');
					write('<p><center>'+name+':  <textarea name=box cols=30 rows=6 onKeyUp='+output+'=this.value>'+window.document.selectform.nonconfig_notes.value+'</textarea>');
					write('<p><input type=button value="Done" class="button" onClick=window.close()>');
					write('</center></form></body></html>');
					close();
				}
			}

			function showPopup2(myurl){
				var newWindow;
				var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=yes,location=no,directories=no,width=600,height=350';
				newWindow=window.open(myurl,"Add_from_Src_to_Dest",props);
			}
			function commPercChange(){
				//alert("HERE");
				var temp="";
				if(document.selectform.commsion.value="0"){
					document.selectform.commDollar.value="0";
				}
				else{
					temp=document.selectform.nonconfigPrice.value*(document.selectform.commission.value/100);
					document.selectform.commDollar.value=temp;
				}
			}
			function commDollarChange(){
				//alert("HERE");
				var temp="";
				temp=(document.selectform.commDollar.value/document.selectform.nonconfigPrice.value)*100;
				document.selectform.commission.value=temp;
			}
			function priceChange(){
				//alert("HERE");
				var temp="";
				temp=document.selectform.nonconfigPrice.value*(document.selectform.commission.value/100);
				document.selectform.commDollar.value=temp;
			}
			//  End -->

		</script>
	</HEAD>
	<BODY bgcolor="whitesmoke">
		<%
		String message="<font color='blue'>"+"Order Write-up sheet::"+order_no+"</font>";
		HttpSession UserSession1 = request.getSession();
		String name="";
		if(UserSession1.getAttribute("username")==null){
		name="";
		}
		else{
			   name=UserSession1.getAttribute("username").toString();
		}

		//out.println("The pro"+product);
		%>
		<%//@ include file="../../../rqs_head.jsp"%>
		<table width='100%'>
			<tr class='header1'><td>
					<h3>Order Write-up Sheet  <%=order_no%></h3></td></tr></table>
		<form name="selectform" action="order_page3_save.jsp" onsubmit="return formCheck(this);"  method='post'>
			<input type='hidden' name="order_no" value='<%= order_no %>'>
			<input type='hidden' name="rep_no" value='<%= rep_no %>'>
			<input type='hidden' name="product" value='<%= product %>'>
			<input type='hidden' name="product_id" value='<%= product %>'>
			<table border='0' width='100%'>
				<tr class='header1'><td COLSPAN='2'><h3>SUBMITTAL INFORMATION ::<%=orderStatus %></h3></td></tr>
				<tr><td  align='right' nowrap ><a href="javascript:showPopup2('https://<%= application.getInitParameter("HOST")%>/docs/iwp/pricing 20guides/Leadtime 20Sheet.xls')" color="navy" face="Arial">SUBMITTAL REQUEST DATE:</a></td>

					<%
						   if ((date_required==null)||(date_required.equals(""))){
								 date_required=sDate.toString();
						   }
					%>
					<td  NOWRAP><input type='hidden' name='todaysDate' value='<%=sDate.toString() %>'><input type='text' name="date_require" readonly value='<%= date_required %>' class='text1'>
						<a href="javascript:show_calendar('selectform.date_require');" onmouseover="window.status='Date Picker';
								return true;" onmouseout="window.status='';
										return true;">
							<img src="../../../images/cal.gif" id="imgCalendar3" name="imgCalendar3" width=24 height=22 border=0></a>
					</td>
					<td  NOWRAP align='right'>TYPE OF QUOTE:</td>
					<td ><input type='text' name="type_of_quote" readonly value='<%= type_of_quote %>' class='text1'></td>
					<td  align='right'>EMAIL TO :</td>
					<td ><input type='text' NAME="email" value='<%=emailList%>'>
						<input type='text' name='contactNameSBU' value='<%= emailName %>' readonly>
						<%
						String adsorderrep="";
						String adsorderrepcommperc="";
						String adsdesignspecrep="";
						String adsdesignspecrepcommperc="";
						String adsterritoryrep="";
						String adsterritoryrepcommperc="";
						String adsownerspecrep="";
						String adsownerspecrepcommperc="";
						String ads_color="";


						ResultSet rs_order_rep_info=stmt.executeQuery("select * from cs_order_rep_info where order_no='"+order_no+"'");
						if(rs_order_rep_info != null){
							   while(rs_order_rep_info.next()){
									 adsorderrep=rs_order_rep_info.getString("order_rep_no");
									 adsorderrepcommperc=rs_order_rep_info.getString("order_rep_comm_perc");
									 adsdesignspecrep=rs_order_rep_info.getString("design_rep_no");
									 adsdesignspecrepcommperc=rs_order_rep_info.getString("design_rep_no_comm_perc");
									 adsterritoryrep=rs_order_rep_info.getString("territory_rep_no");
									 adsterritoryrepcommperc=rs_order_rep_info.getString("territory_rep_no_comm_perc");
									 adsownerspecrep=rs_order_rep_info.getString("owner_spec_rep_no");
									 adsownerspecrepcommperc=rs_order_rep_info.getString("owner_spec_rep_no_comm_perc");
									 ads_color=rs_order_rep_info.getString("color");
							   }
						}
						rs_order_rep_info.close();

						if(adsorderrep==null){
							   adsorderrep="";
						}
						if(adsorderrepcommperc==null){
							   adsorderrepcommperc="";
						}
						if(adsdesignspecrep==null){
							   adsdesignspecrep="";
						}
						if(adsdesignspecrepcommperc==null){
							   adsdesignspecrepcommperc="";
						}
						if(adsterritoryrep==null){
							   adsterritoryrep="";
						}
						if(adsterritoryrepcommperc==null){
							   adsterritoryrepcommperc="";
						}
						if(adsownerspecrep==null){
							   adsownerspecrep="";
						}
						if(adsownerspecrepcommperc==null){
							   adsownerspecrepcommperc="";
						}
						if(ads_color==null){
							   ads_color="";
						}

						%>
					</td>
				</tr>

				<tr><td class='noheader' align='right' ><b>SUBMITTALS BY</b></td>
					<%
					if(product.equals("IWP") && !(orderStatus.equals("RF"))){
						   //out.println("status"+orderStatus);
						   out.println("<td class='noheader' nowrap><select id='submittals_by' name='submittals_by' disabled>");
					}
					else{
						   out.println("<td class='noheader' nowrap><select id='submittals_by' name='submittals_by'>");
					}
					%>
				<option></option>
				<%
		  String[] ship1;
    if(product.equals("IWP") && orderStatus.equals("RF")){
    ship1=new String[2];
    ship1[0] = "NOT REQUIRED";ship1[1] = "REP-(Release for Fabrication)";
    }else{
    ship1=new String[4];
    ship1[0] = "FACTORY";ship1[1] = "REP-(Release for Fabrication)";ship1[2] = "REP-(Hold for Approval)";ship1[3] = "NOT REQUIRED";
    }
    if((product.equals("GE") && (submit_by==null || submit_by.trim().length()==0))||((submit_by==null || submit_by.trim().length()==0) && project_type.toUpperCase().equals("WEB") )){
    submit_by="NOT REQUIRED";
    }
    for (int i = 0; i < ship1.length; i++) {
    String selected1 = (ship1[i].equals(submit_by)) ? "selected" : "";
				%>
				<option value='<%= ship1[i] %>' <%= selected1 %>><%= ship1[i] %></option>
				<%
					   }
				%>

				</select></td>
				<input type='hidden' name="submittals_by1" value='<%= submit_by %>'>
				<td class='noheader' align='right' nowrap>
					<a href="javascript:explain('Special Instructions', 'opener.document.selectform.special_notes.value', 'Special Instructions');" onMouseOver="window.status='Click for Entering Special Instructions...';
							return true;" onMouseOut="window.status='';
									return true;">
						SPECIAL INSTRUCTIONS:
				</td>
				<td class='noheader'><textarea name="special_notes" cols=11 rows=1 class='text1'><%= special_notes %> </textarea>
				<td class='noheader' align='right' >COPIES REQUESTED:</td>
				<td class='noheader'><input type='text' name="copy_req" value='<%= copies_requested %>' class='notext1'></td>

				</tr>
				<tr><td  align='right' nowrap ><b>ORDER STATUS:</b></td>
					<td  NOWRAP><select name='OT' disabled>
							<%
								   String[] oType ={"DR","HA","RF"};
								   String[] oName ={"CS Drafting", "Hold for Approval", "Release for Fabrication"};
								   for(int u=0; u<oType.length; u++){
										 String selected="";
										 if(oType[u].equals(orderStatus)){
											    selected="selected";
										 }
										 out.println("<option value='"+oType[u]+"' "+selected+">"+oName[u]+"</option>");
								   }
							%>
						</select></td>
					<!-- hidden field to order status -->
				<input type='hidden' name="OT1" id='OT1' value='<%= orderStatus %>'>

				<!--<td  NOWRAP align='right'>OVERAGE</td>-->
				<!--<td ><input type='text' name="overage" value='<%= overage%>' class='notext1'></td>-->













				<td  align='right'>DRAFTING EMAIL</td>
				<td > <input type='text' name='drafting_email' value='<%=drafting_email%>'></td>
				<td  align='right'>COPY DRAFTING EMAIL FROM</td>
				<td ><select name='BillingEmailFrom' onchange='changeDraftingEmail()'>
						<option value=''></option>
						<option value='<%=billedEmail2%>'>BILLING</option>
						<option value='<%=invoiceEmail2%>'>INVOICE</option>
					</select>
				</td>
				</tr>


				<%
		  //	out.println(project_type+":::<BR>");
				if(project_type.equals("PSA")|!project_group_id.toUpperCase().startsWith("REP")|project_rep_no.equals("999")){
					   if(group_id.toUpperCase().startsWith("REP")){
							 out.println("<td class='noheader'><input type='hidden' name='order_rep' value='"+usession_rep_no+"'>");
							 out.println("<input type='hidden' name='terr_rep' value='"+terr_rep+"'>");
							 out.println("<input type='hidden' name='spec_rep' value='"+spec_rep+"'></td>");
					   }
					   else{
				%>
				<tr>
					<td class='noheader' align='right'>ORDER REP:<%//= order_rep_acct_id%><%//=rep_no %></td>
					<td class='noheader'> <select name='order_rep'>
							<option></option>
							<%
							// psa_quote_id
							for (int i = 0; i < psa_reps.size(); i++) {
								   String selected = (psa_reps.elementAt(i).toString().equals(order_rep)) ? "selected" : "";
							%>
							<option value='<%= psa_reps.elementAt(i).toString() %>' <%= selected %>><%= psa_reps.elementAt(i).toString() %>::<%= psa_rep_names.elementAt(i).toString() %></option>
							<%
					  }
							%>
						</select>
					</td>


					<td class='noheader' align='right'>TERRITORY REP:</td>
					<td class='noheader'> <select name='terr_rep'>
							<option></option>
							<%
							for (int i = 0; i < psa_reps.size(); i++) {
								   String selected = (psa_reps.elementAt(i).toString().equals(terr_rep)) ? "selected" : "";
							%>
							<option value='<%= psa_reps.elementAt(i).toString() %>' <%= selected %>><%= psa_reps.elementAt(i).toString() %>::<%= psa_rep_names.elementAt(i).toString() %></option>
							<%
					  }
							%>
						</select>
					</td>


					<td class='noheader' align='right'>SPEC REP:</td>
					<td class='noheader'> <select name='spec_rep'>
							<option></option>
							<%
							for (int i = 0; i < psa_reps.size(); i++) {
								   String selected = (psa_reps.elementAt(i).toString().equals(spec_rep)) ? "selected" : "";
							%>
							<option value='<%= psa_reps.elementAt(i).toString() %>' <%= selected %>><%= psa_reps.elementAt(i).toString() %>::<%= psa_rep_names.elementAt(i).toString() %></option>
							<%
					  }
							%>
						</select>
					</td>










				</tr>
				<%
		  }
    }%>

				<tr><td class='noheader' COLSPAN='6' align='right' ><HR></td></tr>
			</table>
			<table  border='0' width='100%'>
				<tr class='header1'><td COLSPAN='2'><h3>ARCHITECT ::</h3></td>
				</tr>
				<tr><td  align='right' ><b><a href="javascript:showPopup2('https://<%= application.getInitParameter("HOST")%>/erapid/us/orders/ows/bpcs_order_arch_search.jsp?mode=3&rep_no=<%= rep_no %>')" color="navy" face="Arial">ARCHITECT'S NAME:</a></b></td>
					<td ><input type='text' name="arch_name" class='text1' value='<%= arch_name.trim() %>'>
						<input type='hidden' name="arch_cust_bpcs_no" value='' class='text1'>
					</td>
					<td  align='right' >ADDRESS1:</td>
					<%
						   if ((arch_addr1==null)){arch_addr1="";}
						   if ((arch_addr2==null)){arch_addr2="";}
						   if ((arch_city==null)){arch_city="";}
						   if ((arch_state==null)){arch_state="";}
						   if ((arch_zip==null)){arch_zip="";}
						   if ((arch_phone==null)){arch_phone="";}
						   if ((arch_fax==null)){arch_fax="";}
						   if ((arch_email==null)){arch_email="";}

					%>
					<td ><input type='text' name="arch_addr1" class='text1' value='<%= arch_addr1 %>'></td>
					<td  align='right' >ADDRESS2:</td>
					<td ><input type='text' name="arch_addr2" class='text1' value='<%= arch_addr2 %>'></td>

				</tr>
				<tr><td class='noheader' align='right' ><b>CITY:</b></td>
					<td class='noheader'><input type='text' name="arch_city" class='notext1' value='<%= arch_city.trim() %>'></td>
					<td class='noheader' align='right' ><b>STATE:</b></td>
					<td class='noheader'><select name='arch_state'>
							<option></option>
							<%

							for (int i = 0; i < countryCodes.size(); i++) {
							 String selected = (countryCodes.elementAt(i).toString().equals(arch_state.trim())) ? "selected" : "";
							%>
							<option value='<%= countryCodes.elementAt(i).toString() %>' <%= selected %>><%= countryCodes.elementAt(i).toString() %></option>
							<%
								   }

							%>
						</select></td>
							   <!--<td class='noheader'><input type='text' name="arch_state" class='notext1' value='<%= arch_state.trim() %>'></td>-->
					<td class='noheader' align='right' >ZIP:</td>
					<td class='noheader'><input type='text' name="arch_zip" class='notext1' value='<%= arch_zip %>'></td>
				</tr>
				<tr><td  align='right' >PHONE:</td>
					<td ><input type='text' name="arch_phone" class='text1' value='<%= arch_phone %>'></td>
					<td  align='right' >FAX:</td>
					<td ><input type='text' name="arch_fax" class='text1' value='<%= arch_fax %>'></td>
					<td  align='right' >EMAIL:</td>
					<td ><input type='text' name="arch_email" class='text1' value='<%= arch_email %>'></td>
				</tr>

				<tr><td class='noheader' align='right' ><b>ORDER ARCHITECT :</b></td>
					<td class='noheader'><select name='arch_detect'>

							<%
							if(arch_required==null){
								   arch_required="Y";
								   if(product.equals("GE")){
										 arch_required="N";
								   }
							}
							if(arch_required.trim().length()==0){
								   if(product.equals("GE")){
										 arch_required="N";
								   }
							}


							if(arch_required.equals("Y")){
							out.println("<option></option>");
							out.println("<option value='Y' selected>Required as Above</option>");
							out.println("<option value='N' >None</option>");
							}
							else if (arch_required.equals("N")){
							out.println("<option></option>");
							out.println("<option value='Y'>Required as Above</option>");
							out.println("<option value='N' selected>None</option>");
							}
							else {
							out.println("<option ></option>");
							out.println("<option value='Y'>Required as Above</option>");
							out.println("<option value='N' >None</option>");
							}
							%>
						</select></td>
				</tr>

				<tr><td class='noheader' COLSPAN='6' align='right' ><HR></td></tr>
			</table>
			<%

			if(order_notes==null){
			order_notes="";
			}
			%>
			<table border='0' width='100%'>
				<tr class='header1'><td COLSPAN='2'><h3>Additional Documents ::</h3></td></tr>
				<tr>
					<td  NOWRAP align='right'>ADDITIONAL DOCUMENTS TO FOLLOW:<br>(To select multiple documents hold <br><i>Shift</i> &nbsp;or <i>Ctrl</i>&nbsp; key and then select.)</td>
					<td ><select name='DOCS' multiple>
							<%
							    String[] docList={"PO","SO","LI","TE","DR","TD","CC","SA","CS","AA"};
								   String[] docName={"Purchase Order", "Signed Quote", "Letter of Intent", "Templates", "Drawings", "Tax Document", "Credit Card Form", "Sample", "Cut to Size Document","Air Freight Authorization"};
								   for(int b=0; b<docList.length; b++){
										 String selected="";
										 for(int v=0; v<docsAdd.size(); v++){
											    if(docList[b].equals(docsAdd.elementAt(v).toString())){
													  selected="selected";
											    }
										 }
										 out.println("<option value='"+docList[b]+"' "+selected+"> "+docName[b]+"</option>");
								   }
							%>
						</select></td>
						<%
						if(product.equals("IWP")||product.equals("EJC")||product.equals("EFS")||product.equals("GE")||product.equals("GCP")||product.equals("ADS")){
						%>
					<td  align='right' nowrap >Attach Additional documents:</td>

					<td  align='center' ><input type='button' class='button' name='Upload Files' value='Upload Files' onclick='doThis()'</td>
				</tr>
				<%
				String serverx=application.getInitParameter("HOST");
//out.println(serverx);
				if(serverx.indexOf("dev")>0){
					   out.println("<input type='hidden' name='uploadUrl' value='http://sec-avscan.c-sgroup.com/erapid/test/uploadinit.jsp?order_no="+order_no+"'>");
				}
				else{
					   out.println("<input type='hidden' name='uploadUrl' value='http://sec-avscan.c-sgroup.com/erapid/uploadinit.jsp?order_no="+order_no+"'>");
				}
				String file_details="";
				ResultSet rsUpload=stmt.executeQuery("select file_details from cs_ims_counter where order_no='"+order_no+"'");
				if(rsUpload != null){
					   while(rsUpload.next()){
								    if(rsUpload.getString(1) != null && rsUpload.getString(1).trim().length()>0){
										  file_details=rsUpload.getString(1);
								    }
					   }
				}
				rsUpload.close();
				if(file_details != null && file_details.trim().length()>0){
					   int found=file_details.indexOf("WORK COPY");
					   int safetycount=0;
					   if(found>0){
							 do{
								    int start1=file_details.substring(0,found).lastIndexOf("<tr>");
								    int end1=file_details.substring(start1).indexOf("</tr>");
								    file_details=file_details.substring(0,start1)+file_details.substring((start1+end1));
								    found=file_details.indexOf("WORK COPY");
								    safetycount++;
							 }while(found>0||safetycount==100);
					   }
				}
				if(file_details != null & file_details.trim().length()>0){
					   file_details=file_details.replaceAll("<td>","<td class='noheader'>");
					   out.println("<tr><td class='noheader' COLSPAN='6' align='right' ><table border='0' width='100%'><tr class='header1'><td colspan='6' ><h3><b>Files previously uploaded for Order Number "+order_no+":</h3></td></tr><tr><td width='10%'  ><b><u>Type</u></b></td><td width='20%'  ><b><u>Current Name</u></b></td><td width='20%'  ><b><u>Uploaded as</u></b></td><td width='10%'  ><b><u>Bytes</u></b></td><td width='10%'  ><b><u>Virus Status</u></b></td><td width='30%'  ><b><u>Date</u></b></td></tr>"+file_details+"</table></td></tr>");
				}
		  }
				%>



				<tr><td class='noheader' COLSPAN='6' align='right' ><HR></td></tr>
			</table>
			<table border='1' width='100%'>
				<tr class='header1'><td COLSPAN='1'><h3>ORDER NOTES ::</h3></td></tr>
				<tr>
					<td  align='right' nowrap >
						<a href="javascript:explain1('Order Notes', 'opener.document.selectform.order_notes.value', 'Order Notes');" onMouseOver="window.status='Click for Entering Order Notes...';
								return true;" onMouseOut="window.status='';
										return true;">
							ORDER NOTES:</a>
					</td>
					<td >
						<textarea name="order_notes" cols=50 rows=2 class='text1'><%= order_notes %> </textarea>
					</td>
					<td  align='right' nowrap >
						<a href="javascript:explain3('Order Notes', 'opener.document.selectform.customer_notes.value', 'Order Notes');" onMouseOver="window.status='Click for Entering Order Notes...';
								return true;" onMouseOut="window.status='';
										return true;">
							Order Notes to Customer:</a><br>(These notes print on customer statement)
					</td>
					<td >
						<textarea name="customer_notes" cols=50 rows=2 class='text1'><%=customer_notes %> </textarea>
					</td>

				</tr>

				<%
				if(product.equals("ADS")){

					   if(extra_notes==null){
							 extra_notes="";
					   }
					   extra_notes=","+extra_notes+",";
					   if(!group_id.toUpperCase().startsWith("REP")){
							 //out.println("::"+extra_notes+"::");
				%><tr><td class='noheader' COLSPAN='8' align='right' ><HR></td></tr>
						<%
						int adsnotecount=0;
						ResultSet rsordernotes=stmt.executeQuery("select * from cs_order_notes where product_id='"+product+"'");
						if(rsordernotes != null){
							   while(rsordernotes.next()){
									 if(adsnotecount%4==0){
										    out.println("<tr>");
									 }
									 String selected="";
									 if(extra_notes.indexOf(","+rsordernotes.getString(1)+",")>=0){
										    selected="checked";
									 }
									 out.println("<td><input type='checkbox' name='adsnote' value='"+rsordernotes.getString(1)+"' "+selected+"> <b>"+rsordernotes.getString(2)+"</B>::"+rsordernotes.getString(3)+"</td>");
									 adsnotecount++;
									 if(adsnotecount%4==0){
										    out.println("</tr>");
									 }
							   }
						}
						rsordernotes.close();
						if((adsnotecount+1)%4==0){
							   out.println("<tr>");
						}

						%>
				<td  align='center' nowrap colspan='2' >
					<a href="javascript:explain1('ADS Order Notes', 'opener.document.selectform.ads_order_notes.value', 'ADS Order Notes');" onMouseOver="window.status='Click for Entering Order Notes...';
							return true;" onMouseOut="window.status='';
									return true;">
						ADS ORDER NOTES:</a><textarea name="extra_order_notes" cols=30 rows=2 class='text1'><%= extra_order_notes %> </textarea>
				</td>
				</tr>
				<tr>
					<td>
						<table border='1'>

							<TR>
								<td>Rep</td>
								<td>Rep#</td>
								<td>&nbsp;</td>
								<td>Percent</td>
								<td>&nbsp;</td>
							</tr>
							<TR>
								<td>Order Rep</td>
								<td><input type='text' name='adsorderrep' value='<%=adsorderrep%>'></td>
								<td>@</td>
								<td><input type='text' name='adsorderrepcommperc' value='<%=adsorderrepcommperc%>'></td>
								<td>%</td>
							</tr>
							<TR>
								<td>Design Spec</td>
								<td><input type='text' name='adsdesignspecrep' value='<%=adsdesignspecrep%>'></td>
								<td>@</td>
								<td><input type='text' name='adsdesignspecrepcommperc' value='<%=adsdesignspecrepcommperc%>'></td>
								<td>%</td>
							</tr>
							<TR>
								<td>Territory Rep</td>
								<td><input type='text' name='adsterritoryrep' value='<%=adsterritoryrep%>'></td>
								<td>@</td>
								<td><input type='text' name='adsterritoryrepcommperc' value='<%=adsterritoryrepcommperc%>'></td>
								<td>%</td>
							</tr>
							<TR>
								<td>Owner Spec</td>
								<td><input type='text' name='adsownerspecrep' value='<%=adsownerspecrep%>'></td>
								<td>@</td>
								<td><input type='text' name='adsownerspecrepcommperc' value='<%=adsownerspecrepcommperc%>'></td>
								<td>%</td>
							</tr>
						</table>
					</td>
					<td colspan='1' align='left' valign='top' nowrap >PRODUCTION APPROVED DATE:

						<%
						if ((production_approved_date==null)||(production_approved_date.equals(""))){
							   production_approved_date="";
							   //sDate.toString();
						}
						%>
						<input type='text' name="production_approved_date" readonly value='<%= production_approved_date %>' >
						<a href="javascript:show_calendar('selectform.production_approved_date');" onmouseover="window.status='Date Picker';
								return true;" onmouseout="window.status='';
										return true;">
							<img src="../../../images/cal.gif" id="imgCalendar3" name="imgCalendar3" width=24 height=22 border=0></a>
					</td>

					<td  align='center' nowrap colspan='2' >
						Color:<textarea name='ads_color' cols=30 rows=2 class='text1'><%= ads_color.trim() %></textarea>
					</td>
					<%
					out.println("</tr>");
			  }
			  else{
					//out.println("::"+extra_notes+"::");
					%><tr><td class='noheader' COLSPAN='8' align='right' ><HR></td></tr>
				<input type='hidden' name='adsorderrep' value='<%=adsorderrep%>'>
				<input type='hidden' name='adsorderrepcommperc' value='<%=adsorderrepcommperc%>'>
				<input type='hidden' name='adsdesignspecrep' value='<%=adsdesignspecrep%>'>
				<input type='hidden' name='adsdesignspecrepcommperc' value='<%=adsdesignspecrepcommperc%>'>
				<input type='hidden' name='adsterritoryrep' value='<%=adsterritoryrep%>'>
				<input type='hidden' name='adsterritoryrepcommperc' value='<%=adsterritoryrepcommperc%>'>
				<input type='hidden' name='adsownerspecrep' value='<%=adsownerspecrep%>'>
				<input type='hidden' name='adsownerspecrepcommperc' value='<%=adsownerspecrepcommperc%>'>
				<%
				int adsnotecount=0;
		  if(extra_notes==null){
					   extra_notes="";
				}
				extra_notes=","+extra_notes+",";
				ResultSet rsodernotes0=stmt.executeQuery("select * from cs_order_notes where product_id='"+product+"' and not note_group ='other'");
				if(rsodernotes0 != null){
					   while(rsodernotes0.next()){

							 String selected="";
							 if(extra_notes.indexOf(","+rsodernotes0.getString(1)+",")>=0){

								    out.println("<input type='hidden' name='adsnote2' value='"+rsodernotes0.getString(1)+"' >" );
							 }


					   }
				}
				rsodernotes0.close();
				ResultSet rsordernotes=stmt.executeQuery("select * from cs_order_notes where product_id='"+product+"' and note_group ='other'");
				if(rsordernotes != null){
					   while(rsordernotes.next()){
							 if(adsnotecount%4==0){
								    out.println("<tr>");
							 }
							 String selected="";
							 if(extra_notes.indexOf(","+rsordernotes.getString(1)+",")>=0){
								    selected="checked";
							 }
							 out.println("<td><input type='checkbox' name='adsnote' value='"+rsordernotes.getString(1)+"' "+selected+"> <b>"+rsordernotes.getString(2)+"</B>::"+rsordernotes.getString(3)+"</td>");
							 adsnotecount++;
							 if(adsnotecount%4==0){
								    out.println("</tr>");
							 }
					   }
				}
				rsordernotes.close();

		  }
    }
    else if(product.equals("LVR")){
				%><tr><td class='noheader' COLSPAN='8' align='right' ><HR></td></tr>
				<td  align='center' nowrap colspan='2' >

					ADDS/DEDUCTS TAKEN:<textarea name="extra_order_notes" cols=30 rows=2 class='text1'><%= extra_order_notes.trim() %></textarea>
				</td>
				<%
				out.println("</tr>");
		  }
				%>

















				<tr><td class='noheader' COLSPAN='6' align='right' ><HR></td></tr>



















			</table>
			<%





			if(project_type != null && project_type.equals("NCP")){
			%>
			<table width='100%' border='0'>
				<tr class='header1'><td COLSPAN='3'><h3>NON CONFIGURED PRODUCT INFO ::</h3></td></tr>
				<tr>
					<td align='right' width='12.5%' >PRICE</td>
					<td width='12.5%' ><input type='text' name='nonconfigPrice' value='<%=config_price%>' onchange='priceChange();' class='text1'>
					<td align='right' width='12.5%' >OVERAGE</td>
					<td width='12.5%' ><input type='text' name='overage' value='<%=overage%>' class='text1'>
					<td align='right' width='12.5%' >COMMISSION(%)</td>
					<td width='12.5%' ><input type='text' name='commission' value='<%=commission%>' onchange='commPercChange();' class='text1'>
						<input type='hidden' name='commDollar' value='<%=commDollar%>' onchange='commDollarChange();' class='text1'>
				</tr>

				<tr><td align='Right' colspan='2' class='noheader' >
						<a href="javascript:explain2('NON CONFIGURED LINE ITEMS', 'opener.document.selectform.nonconfig_notes.value', 'NON CONFIGURED LINE ITEMS');" onMouseOver="window.status='Click for Entering Non Configured Notes...';
								return true;" onMouseOut="window.status='';
										return true;">
							<font size='3pt'>NON CONFIGURED LINE ITEMS:</font></a>
					</td>
					<td colspan='6' class='noheader' >
						<textarea name="nonconfig_notes" cols=80 rows=10 class='text1'><%= nonconfigDesc %> </textarea>
					</td>
				</tr>


				<tr><td class='noheader' COLSPAN='8' align='right' ><HR></td></tr>
			</table>
			<%
			}
			%>









			<table border='0' align='right'>
				<tr>
					<td COLSPAN='3' align='right'><a href="order_transfer.jsp?cmd=1&order_no=<%= order_no %>&id=<%= rep_no %>">View Page 1</a></td>
					<td COLSPAN='3' align='right'>| <a href="order_transfer.jsp?cmd=2&order_no=<%= order_no %>&id=<%= rep_no %>">View  Page 2</a></td>
					<td COLSPAN='3' align='right'>| Page 3 </td>
					<%
					if (ow_sent.equals("Y")){
						   if (product.equals("IWP")|product.equals("EJC")|product.equals("EFS")|product.equals("ADS")|product.equals("GE")){
					%>
					<td COLSPAN='3' align='right'>| <a href="order_transfer.jsp?cmd=5&order_no=<%= order_no %>&id=<%= rep_no %>">View Page 4</a></td>
					<%  } %>
					<!--<td COLSPAN='3' align='right'>| <a href="order_transfer.jsp?cmd=4&order_no=<%= order_no %>&id=<%= rep_no %>">Order Sheet</a></td>-->
					<td COLSPAN='3' align='right'>| <a href="javascript:showPopup2('http://<%= application.getInitParameter("HOST")%>/erapid/us/orders/ows/email_order_sheet.jsp?sections=all&order_no=<%= order_no %>&rep_no=<%= rep_no %>&product=<%= product%>&Job_loc=<%=Job_loc%>&project_state=<%=project_state%>&line=<%= line%>&handling_cost=<%=handling_cost%>&setup_cost=<%=setup_cost%>&freight_cost=<%=freight_cost%>&overage=<%=overage%>&totmat_price=<%=totmat_price%>&commission=<%=commission%>')">Email Order Sheet</a></td>
					<%
					if(product.equals("LVR")){
						String sectionValue = "s1,";
					%>
					<td COLSPAN='3' align='right'>| <a href="javascript:showPopup2('http://<%= application.getInitParameter("HOST")%>/erapid/us/orders/ows/order_sheet.jsp?sections=<%=sectionValue%>&orderNo=<%= order_no %>&rep_no=<%= rep_no %>&product=<%= product%>&Job_loc=<%=Job_loc%>&project_state=<%=project_state%>&line=<%= line%>&handling_cost=<%=handling_cost%>&setup_cost=<%=setup_cost%>&freight_cost=<%=freight_cost%>&overage=<%=overage%>&totmat_price=<%=totmat_price%>&commission=<%=commission%>')">Order Sheet</a></td>
					<%}else if(!product.equals("LVR")){ %>
					<td COLSPAN='3' align='right'>| <a href="javascript:showPopup2('http://<%= application.getInitParameter("HOST")%>/erapid/us/orders/ows/order_sheet.jsp?sections=all&orderNo=<%= order_no %>&rep_no=<%= rep_no %>&product=<%= product%>&Job_loc=<%=Job_loc%>&project_state=<%=project_state%>&line=<%= line%>&handling_cost=<%=handling_cost%>&setup_cost=<%=setup_cost%>&freight_cost=<%=freight_cost%>&overage=<%=overage%>&totmat_price=<%=totmat_price%>&commission=<%=commission%>')">Order Sheet</a></td>
					<%} %>
					<%  } %>
				</tr>
			</table>
			<br><br>
			<input type='submit' name='enter' value='Save & Continue' class='button' >
			<%
			String repPortalUsersList="'128', '331', '347', '329', '112', '381', '180', '133', '289', '1832', '1750', '150', '111', '85', '108', '102','104','275','9093'";
if((fpx.equals("rp") || project_type.equals("SFDC") || project_type.equals("RP")) && (repPortalUsersList.contains("'"+assigned_rep_no+"'") || repPortalUsersList.contains("'"+project_rep_no+"'"))){
	
	// sfdc_QuoteId
	String urlTemp="https://na1.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"0";

	if(application.getInitParameter("HOST").toUpperCase().indexOf("DEV")>0){
		urlTemp="https://maya-cscrm.cs67.force.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"0";
	}

			%>

			<input type='button' class='button' name='CLOSE' value='Return to Portal'   onclick='closeThis("<%=urlTemp%>")'>
			<%
			}
			else{
			%>

			<input type='button' class='button' name='LineItem' value='Line Item'   onclick='lineItem()'>
			<%
			}
			%>

		</form>
	</center>
	<br><br><br><br><br>

	<%//@ include file="../../../rqs_footer.jsp"%>
</body>
</html>
