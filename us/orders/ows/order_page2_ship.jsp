
<html>
	<HEAD>
		<title>
			Shipping Information
		</title>
		<link rel='stylesheet' href='../../../css/styleMain.css' type='text/css'/>

		<script language="JavaScript" src="check_order_sheet.js"></script>
		<script language="JavaScript" src="../../../test/date-picker.js"></script>

		<SCRIPT LANGUAGE="JavaScript">

			function showPopup2(myurl){
				var newWindow;
				var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=yes,location=no,directories=no,width=600,height=450';
				newWindow=window.open(myurl,"Add_from_Src_to_Dest",props);
			}
			function lineItem(){
				//alert("lineItem");
				//parent.postMessage("test","*");
				window.parent.postMessage("test2","*");
				//alert("after post");
			}
			function closeThis(x){
				//alert("CLOSE THIS"+x);
				window.location=x;
			}
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

		%>
		<%//@ include file="../../../rqs_head.jsp"%>

		<table width='100%'>
			<tr class='header1'><td>
					<h3>Order Write-up Sheet  <%=order_no%></h3></td></tr></table>
		<form name="selectform" action="order_page2_save.jsp" onsubmit="return formCheck(this);">
			<input type='hidden' name="page_type" value="two">
			<input type='hidden' name='product_id' value='<%=product%>'>
			<input type='hidden' name="order_no" value='<%= order_no %>'>
			<input type='hidden' name="rep_no" value='<%= rep_no %>'>
			<input type='hidden' name="arch_detect" value='N'>
			<input type='hidden' name='todaysDate' value='<%=sDate.toString() %>'>
			<% if (cust_ship_info.equals("Y")){
			ship_name=cust_name1;ship_addr1=cust_addr1;ship_addr2=cust_addr2;city=cust_city;state=cust_state;zip=cust_zip_code;ship_phone=cust_phone;
			ship_fax=cust_fax;ship_cust_bpcs_no=bpcs_cust_no;
			}
			 if (cust_invoice_info.equals("Y")){
			invoice_name=cust_name1;invoice_addr1=cust_addr1;invoice_addr2=cust_addr2;invoice_city=cust_city;invoice_state=cust_state;invoice_zip=cust_zip_code;invoice_phone=cust_phone;
			invoice_fax=cust_fax;invoice_cust_bpcs_no=bpcs_cust_no;
											 }
			if(ship_addr2==null){
				ship_addr2="";
			}
			%>

			<table border='0' width='100%'>
				<tr class='header1'><td COLSPAN='2'><h3>SHIPPING INFORMATION ::</h3></td></tr>
				<tr><td  align='right' ><b><a href="javascript:showPopup2('https://<%= application.getInitParameter("HOST")%>/erapid/us/orders/ows/bpcs_order_cust_search2_new.jsp?mode=1&rep_no=<%= rep_no %>')" color="navy" face="Arial">SHIP TO NAME:</a></b></td>
					<td ><input type='text' name="ship_name" value='<%= ship_name.trim() %>' class='text1' MAXLENGTH=30>
						<input type='hidden' name="ship_cust_bpcs_no" value='<%=ship_cust_bpcs_no%>' class='text1'>
						<input type='hidden' name="ship_cust_bpcs_no_alt" value='<%=ship_cust_bpcs_no_alt%>' class='text1'>
					</td>
					<td  align='right' ><b>ADDRESS 1:</b></td>
					<td ><input type='text' name="ship_addr1" value='<%= ship_addr1.trim() %>' class='text1' MAXLENGTH=30></td>

					<td  align='right' >ADDRESS 2:</td>
					<td ><input type='text' name="ship_addr2" value='<%= ship_addr2.trim() %>' class='text1' MAXLENGTH=30></td>
				</tr>

				<tr><td class='noheader' align='right' ><b>CITY:</b></td>
					<td class='noheader'><input type='text' name="city" value='<%= city.trim() %>' class='notext1' MAXLENGTH=30></td>
					<td class='noheader' align='right' ><b>STATE:</b></td>
					<td class='noheader'><select name='state'>
							<option></option>
							<%

							for (int i = 0; i < countryCodes.size(); i++) {
							 String selected = (countryCodes.elementAt(i).toString().equals(state)) ? "selected" : "";
							%>
							<option value='<%= countryCodes.elementAt(i).toString() %>' <%= selected %>><%= countryCodes.elementAt(i).toString() %></option>
							<%
								}
							%>
						</select>



	<!--<td class='noheader'><input type='text' name="state2" value='<%= state.trim() %>' class='notext1' MAXLENGTH=40></td>-->
					<td class='noheader' align='right' ><b>ZIP:</b></td>
					<td class='noheader'><input type='zip' name="zip" value='<%= zip.trim() %>' class='notext1' MAXLENGTH=14></td>
				</tr>
				<tr><td  align='right'><b>PHONE:</b></td>
					<td ><input type='text' name="ship_phone" value='<%= ship_phone.trim() %>' class='text1' MAXLENGTH=25></td>
					<td  align='right'>FAX:</td>
					<td ><input type='text' name="ship_fax" value='<%= ship_fax.trim() %>' class='text1' MAXLENGTH=40></td>
					<td  align='right'>EMAIL:</td>
					<td ><input type='text' name="ship_email" value="<%= ship_email.trim() %>" class='text1' MAXLENGTH=40></td>
				</tr>
				<tr><td class='noheader' align='right' >SHIPPING METHOD:</td>
					<td class='noheader'><select name='ship_method'>
							<%
					String[] ship = {"COMMON CARRIER","OTHER(SPECIFY)"};
					for (int i = 0; i < ship.length; i++) {
					 String selected = (ship[i].equals(ship_method)) ? "selected" : "";
							%>
							<option value='<%= ship[i] %>' <%= selected %>><%= ship[i] %></option>
							<%
								}
							%>

						</select></td>

					<td class='noheader' align='right' >TAX EXEMPT NUMBER:</td>
					<td class='noheader'><input type='text' name="ship_tax_exempt" value='<%= ship_tax_exempt %>' class='notext1' MAXLENGTH=40></td>
					<td class='noheader' align='right' >SHIPPING TERMS:</td>
					<td class='noheader'><select name='ship_terms'>
							<%
					String[] sh_terms = {"FOB:FACTORY","SPECIAL"};
					for (int i = 0; i < sh_terms.length; i++) {
					 String selected = (sh_terms[i].equals(ship_terms)) ? "selected" : "";
							%>
							<option value='<%= sh_terms[i] %>' <%= selected %>><%= sh_terms[i] %></option>
							<%
								}
							%>

						</select></td>
				</tr>
				<%
				if(product.equals("EFS")){
				%>
				<tr><td  align='right' ><b><a href="javascript:showPopup2('https://<%= application.getInitParameter("HOST")%>/docs/iwp/pricing guides/EFS leadtimes.xls')" color="navy" face="Arial"">REQUESTED SHIP DATE:</a></b></td>
								<%
							}
							else if(product.equals("IWP")){
								%>
				<tr><td  align='right' ><b><a href="javascript:showPopup2('http://lebhq-csedev.c-sgroup.com/docs/iwp/pricing guides/Leadtime Sheet.pdf')" color="navy" face="Arial"">REQUESTED SHIP DATE:</a></b></td>
								<%
							}
							else{
								%>
				<tr><td  align='right' ><b>REQUESTED SHIP DATE:</b></td>
					<%
				}
					if ((ship_rdate==null)|(ship_rdate.equals(""))){
				//	ship_rdate=sDate.toString();
					ship_rdate="";
					}
					%>
					<td  nowrap><input type='text' name="ship_rdate" id='ship_rdate'  class='text1' readonly value='<%= ship_rdate %>'  MAXLENGTH=15>
						<a href="javascript:show_calendar('selectform.ship_rdate');" onmouseover="window.status='Date Picker';
								return true;" onmouseout="window.status='';
										return true;">
							<img src="../../../images/cal.gif" id="imgCalendar3" name="imgCalendar3" width=24 height=22 border=0></a>
					</td>
					<td  nowrap  align='right'>
						Attention:
					</td>
					<td  nowrap>
						<input type='text' name='attention_ship' value='<%= attention_ship %>' class='notext1' MAXLENGTH=30>
					</td>
					<td  colspan='2'>
					</td>
				</tr>
				<tr>
					<td class='noheader' nowrap  align='right'>
						<%
						if(product.equals("ADS")){out.println("<B>");}
						%>
						DELIVERY NOTICE:
					</td>
					<td class='noheader'>
						<select name='notice_ship'>
							<option value=''></option>
							<%
							String selectNotice="";
							if(product.equals("ADS")){
								selectNotice="";
								if(notice_ship.equals("0")){ selectNotice="selected";}
							%>
							<option value='0' <%= selectNotice%>>0</option>
							<%
						}
							selectNotice="";
							if(notice_ship.equals("24")){ selectNotice="selected";}
							%>
							<option value='24' <%= selectNotice%>>24hrs</option>
							<%
								selectNotice="";
								if(notice_ship.equals("36")){ selectNotice="selected";}
							%>
							<option value='36' <%= selectNotice%>>36hrs</option>
							<%
								selectNotice="";
								if(notice_ship.equals("48")){ selectNotice="selected";}
							%>
							<option value='48' <%= selectNotice%>>48hrs</option>
						</select>
					</td>
					<td class='noheader' nowrap  align='right'>
						<%
						if(product.equals("ADS")){
						%>
						<B>Delivery Name:</b>
							<%
						}
						else{
							%>
						Delivery Name:
						<%
					}
						%>
					</td>
					<td class='noheader'>
						<input type='text' name='name_ship' value='<%= name_ship %>' class='notext1' MAXLENGTH=40>
					</td>
					<td class='noheader' nowrap  align='right'>
						<%
						if(product.equals("ADS")){
						%>
						<B>Delivery Phone:</b>
							<%
						}
						else{
							%>
						Delivery Phone:
						<%
					}
						%>
					</td>
					<td class='noheader'>
						<input type='text' name='phone_ship' value='<%= phone_ship %>' class='notext1' MAXLENGTH=40>
					</td>


				</tr>
				</tr>

				<tr><td class='noheader' COLSPAN='6' align='right' ><HR></td></tr>
			</table>

			<table border='0' width='100%'>
				<tr class='header1'><td COLSPAN='2'><h3>INVOICE INFORMATION ::</h3></td></tr>
				<tr><td  align='right' ><b><a href="javascript:showPopup2('https://<%= application.getInitParameter("HOST")%>/erapid/us/orders/ows/bpcs_order_cust_search2_new.jsp?mode=2&rep_no=<%= rep_no %>')" color="navy" face="Arial">INVOICE TO NAME:</a></b></td>
					<td ><input type='text' name="invoice_name" value='<%= invoice_name %>' class='text1'  MAXLENGTH=40>
						<input type='hidden' name="invoice_cust_bpcs_no" value='<%=invoice_cust_bpcs_no%>' class='text1'>
						<input type='hidden' name="invoice_cust_bpcs_no_alt" value='<%=invoice_cust_bpcs_no_alt%>' class='text1'>
					</td>
					<td  align='right' ><b>ADDRESS 1:<b></td>
								<td ><input type='text' name="invoice_addr1" value='<%= invoice_addr1 %>' class='text1' MAXLENGTH=40></td>
								<td  align='right' >ADDRESS 2:</td>
								<td ><input type='text' name="invoice_addr2" value='<%= invoice_addr2 %>' class='text1' MAXLENGTH=40></td>
								</tr>
								<tr><td class='noheader' align='right' ><b>CITY:</b></td>
									<td class='noheader'><input type='text' name="invoice_city" value='<%= invoice_city %>' class='notext1' MAXLENGTH=30></td>
									<td class='noheader' align='right' ><b>STATE:</b></td>
									<td class='noheader'><select name='invoice_state'>
											<option></option>
											<%

											for (int i = 0; i < countryCodes.size(); i++) {
											 String selected = (countryCodes.elementAt(i).toString().equals(invoice_state)) ? "selected" : "";
											%>
											<option value='<%= countryCodes.elementAt(i).toString() %>' <%= selected %>><%= countryCodes.elementAt(i).toString() %></option>
											<%
												}
											%>
										</select>
											<!--<td class='noheader'><input type='text' name="invoice_state" value='<%= invoice_state %>' class='notext1' MAXLENGTH=40></td>-->
									<td class='noheader' align='right' ><b>ZIP:</b></td>
									<td class='noheader'><input type='text' name="invoice_zip" value='<%= invoice_zip %>' class='notext1' MAXLENGTH=14></td>
								</tr>
								<tr><td  align='right'><b>PHONE:</b></td>
									<td ><input type='text' name="invoice_phone" value='<%= invoice_phone %>' class='text1' MAXLENGTH=20></td>
									<td  align='right'>FAX:</td>
									<td ><input type='text' name="invoice_fax" value='<%= invoice_fax %>' class='text1' MAXLENGTH=40></td>
									<td  align='right'>EMAIL:</td>
									<td ><input type='text' name="invoice_email" value="<%= invoice_email %>" class='text1' MAXLENGTH=40></td>
								</tr>
								<tr>
									<td class='noheader' nowrap align='right'>
										Attention:
									</td>
									<td><input type='text' name='attention_invoice' value='<%= attention_invoice %>' >
									</td>
								</tr>
								<tr><td class='noheader' COLSPAN='6' align='right' ><HR></td></tr>
								</table>



								<table border='0' align='right'>
									<tr>
										<td COLSPAN='3' align='right'><a href="order_transfer.jsp?cmd=1&order_no=<%= order_no %>&id=<%= rep_no %>">View Page 1</a></td>
										<td COLSPAN='3' align='right'>| Page 2</td>
										<%
										if (ow_sent.equals("Y")){
										%>
										<td COLSPAN='3' align='right'>| <a href="order_transfer.jsp?cmd=3&order_no=<%= order_no %>&id=<%= rep_no %>">View Page 3</a></td>
										<%
										if (product.equals("IWP")|product.equals("EJC")|product.equals("EFS")|product.equals("ADS")|product.equals("GE")){
										%>
										<td COLSPAN='3' align='right'>| <a href="order_transfer.jsp?cmd=5&order_no=<%= order_no %>&id=<%= rep_no %>">View Page 4</a></td>
										<%} %>
										<!--<td COLSPAN='3' align='right'>| <a href="order_transfer.jsp?cmd=4&order_no=<%= order_no %>&id=<%= rep_no %>">Order Sheet</a></td>-->
										<td COLSPAN='3' align='right'>| <a href="javascript:showPopup2('https://<%= application.getInitParameter("HOST")%>/erapid/us/orders/ows/email_order_sheet.jsp?sections=all&order_no=<%= order_no %>&rep_no=<%= rep_no %>&product=<%= product%>&Job_loc=<%=Job_loc%>&project_state=<%=project_state%>&line=<%= line%>&handling_cost=<%=handling_cost%>&setup_cost=<%=setup_cost%>&freight_cost=<%=freight_cost%>&overage=<%=overage%>&totmat_price=<%=totmat_price%>&commission=<%=commission%>')">Email Order Sheet</a></td>
										<%
										if(product.equals("LVR")){
											String sectionValue = "s1,";
										%>
										<td COLSPAN='3' align='right'>| <a href="javascript:showPopup2('https://<%= application.getInitParameter("HOST")%>/erapid/us/orders/ows/order_sheet.jsp?sections=<%=sectionValue%>&orderNo=<%= order_no %>&rep_no=<%= rep_no %>&product=<%= product%>&Job_loc=<%=Job_loc%>&project_state=<%=project_state%>&line=<%= line%>&handling_cost=<%=handling_cost%>&setup_cost=<%=setup_cost%>&freight_cost=<%=freight_cost%>&overage=<%=overage%>&totmat_price=<%=totmat_price%>&commission=<%=commission%>')">Order Sheet</a></td>
										<%}else if(!product.equals("LVR")){ %>
										<td COLSPAN='3' align='right'>| <a href="javascript:showPopup2('https://<%= application.getInitParameter("HOST")%>/erapid/us/orders/ows/order_sheet.jsp?sections=all&orderNo=<%= order_no %>&rep_no=<%= rep_no %>&product=<%= product%>&Job_loc=<%=Job_loc%>&project_state=<%=project_state%>&line=<%= line%>&handling_cost=<%=handling_cost%>&setup_cost=<%=setup_cost%>&freight_cost=<%=freight_cost%>&overage=<%=overage%>&totmat_price=<%=totmat_price%>&commission=<%=commission%>')">Order Sheet</a></td>
										<%} %>
										<%} %>
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
