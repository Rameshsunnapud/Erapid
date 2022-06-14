<html>
	<HEAD>
		<title>
			Order Write-up sheet # <%= order_no %>
		</title>
		<link rel='stylesheet' href='../../../css/styleMain.css' type='text/css'/>
		<script language="JavaScript" src="check_order_sheet.js"></script>
		<jsp:useBean id="priceCalc"		class="com.csgroup.general.PriceCalcBean" 		scope="page"/>
		<SCRIPT LANGUAGE="JavaScript">
			//<!-- Begin
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
					write('<body onLoad="document.form.box.focus()"><form name=form><h1>'+msg+'</h1><br>');
					write('<p>Search for '+name+' BPCS customer here.');
					write('<p><center>'+name+':  <textarea name=box cols=30 rows=6 onKeyUp='+output+'=this.value>'+window.document.selectform.order_notes.value+'</textarea>');
					write('<p><input type=button value="Done" class="button" onClick=window.close()>');
					write('</center></form></body></html>');
					close();
				}
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
			function showPopup2(myurl){
				var newWindow;
				var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=yes,location=no,directories=no,width=550,height=450';
				newWindow=window.open(myurl,"Add_from_Src_to_Dest",props);
			}
			function showPopup2x(myurl){
				var newWindow;
				var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=yes,location=no,directories=no,width=1080,height=800';
				newWindow=window.open(myurl,"Add_from_Src_to_Dest",props);
			}
			function checkCompany(){
				//alert("First in checkCompany method");
				//if(document.selectform.rep_no.value.length==3){

				if(document.selectform.doc_type.value=="ADD"){
					if(document.selectform.add_deduct_job.value.length<=0){
						document.selectform.add_deduct_job.value=document.selectform.tempBPCSno.value;
					}

				}
				if(document.selectform.group_id.value.indexOf("REP")>=0){
					if(document.selectform.doc_type.value=="BUYSELL"){
						//alert(document.selectform.cs_company.value);
						if(document.selectform.cs_company.value="TR - CS Trade"){
							//alert("HERE");
							document.selectform.cs_company.disabled=false;
							document.selectform.cs_company.value="IT - rep buy/sell trade";
							document.selectform.cs_company.disabled=true;
						}
						if(document.selectform.cs_company.value="DG - CS Facility Sales (decogard)"){
							//alert("HERE");
							document.selectform.cs_company.disabled=false;
							document.selectform.cs_company.value="ID - Rep buy/sell facility sales (deco)";
							document.selectform.cs_company.disabled=true;
						}

					}
					if(document.selectform.doc_type.value=="NEW ORDER"){
						if(document.selectform.cs_company.value="IT - rep buy/sell trade"){
							//alert("HERE");
							document.selectform.cs_company.disabled=false;
							document.selectform.cs_company.value="TR - CS Trade";
							document.selectform.cs_company.disabled=true;
						}
						if(document.selectform.cs_company.value="ID - Rep buy/sell facility sales (deco)"){
							//alert("HERE");
							document.selectform.cs_company.disabled=false;
							document.selectform.cs_company.value="DG - CS Facility Sales (decogard)";
							document.selectform.cs_company.disabled=true;
						}
					}
				}
				else{
					//	if(document.selectform.doc_type.value!="BUYSELL"){
					//		if(document.selectform.cs_company.value=="ID - Rep buy/sell facility sales (deco)" ||document.selectform.cs_company.value=="IT - rep buy/sell trade"){
					//			alert("BUYSELL Order type must be selected to use this Company");
					//			document.selectform.cs_company[0].selected=true;
					//		}
					//	}
					//	else{
					//		if(document.selectform.cs_company.value!="ID - Rep buy/sell facility sales (deco)" &&document.selectform.cs_company.value!="IT - rep buy/sell trade"){
					//			alert("NEW ORDER Order type must be selected to use this Company");
					//			document.selectform.cs_company[0].selected=true;
					//		}
					//	}
				}
			}
			function endUser(){
				if(document.selectform.end_user_info.checked==true){
					//alert("1");
					document.selectform.eu_cust_name1.value=document.selectform.cust_name1.value;
					document.selectform.eu_cust_bpcs_no.value=document.selectform.bill_cust_bpcs_no.value;
					document.selectform.eu_cust_addr1.value=document.selectform.cust_addr1.value;
					document.selectform.eu_cust_addr2.value=document.selectform.cust_addr2.value;
					document.selectform.eu_city.value=document.selectform.city.value;
					document.selectform.eu_state.value=document.selectform.state.value;
					document.selectform.eu_zip_code.value=document.selectform.zip_code.value;
					document.selectform.eu_phone.value=document.selectform.phone.value;
					document.selectform.eu_fax.value=document.selectform.fax.value;
				}
				else{
					//alert("2"+document.selectform.end_user_info.value+"::"+document.selectform.end_user_info.checked);
					document.selectform.eu_cust_name1.value="";
					document.selectform.eu_cust_bpcs_no.value="";
					document.selectform.eu_cust_addr1.value="";
					document.selectform.eu_cust_addr2.value="";
					document.selectform.eu_city.value="";
					document.selectform.eu_state.value="";
					document.selectform.eu_zip_code.value="";
					document.selectform.eu_phone.value="";
					document.selectform.eu_fax.value="";
				}

			}
			//  End -->
		</script>
	</HEAD>
	<BODY bgcolor="whitesmoke">
		<%
		String message="<font color='blue'>"+"Order Write-up sheet::"+order_no+"</font>";
		HttpSession UserSession1 = request.getSession();
		String fp=request.getParameter("fp");
		String name="";
			if(UserSession1.getAttribute("username")==null){
			name="";
			}
			else{
				name=UserSession1.getAttribute("username").toString();
			}
		//	out.println(type_of_cust+":");
		%>
		<%//@ include file="../../../rqs_head.jsp"%>
		<table width='100%'>
			<tr class='header1'><td>
					<h3>Order Write-up Sheet <%=order_no%></h3></td></tr></table>
		<form name="selectform" action="order_page1_save.jsp" onsubmit="return formCheck(this);">
			<input type='hidden' name='tempBPCSno' value='<%=bpcs_order_no%>'>
			<input type='hidden' name="order_no" value='<%= order_no %>'>
			<input type='hidden' name='product_id' value='<%=product%>'>
			<input type='hidden' name="type_of_cust" value='<%= type_of_cust %>'>
			<input type='hidden' name="rep_no" value='<%= rep_no %>'>
			<input type='hidden' name="arch_detect" value='N'>
			<table border='0' width='100%'>
				<tr class='header1'><td COLSPAN='2'><h3>ORDER/JOB INFO ::</h3></td></tr>
				<tr><td  align='right' ><b>COMPANY:</b></td>
					<%
						if(group_id.toUpperCase().startsWith("REP")){
					%>
					<td >
						<a href="javascript:alert('If you require this changed, please try with global changes or contact the factory.')" color="navy" face="Arial">
							<img src="images/help.gif" type="image" title="Help" name="Help" width=15 height=15 border=0></a> &nbsp;
						<select name='cs_companyx' onchange='checkCompany()' disabled='disabled'>

							<%
						}
						else{
							%>
							<td ><select name='cs_company' onchange='checkCompany()'>
									<%
								}
									%>

									<option></option>
									<%
									//int cosize=9;
								String[] company;
								if(group_id.toUpperCase().startsWith("CAN")){
									company=new String[2];
									company[0] = "SH - CS Canada";
									company[1] = "AE - CS Canada NEW";
								}
								else if(product.equals("ADS")){
									company=new String[7];
									company[0] = "TR - CS Trade";
									company[1] = "DG - CS Facility Sales (decogard)";
									company[2] = "IC - Intercompany";
									company[3] = "DL - CS Senior Living";
									company[4] = "IN - International";
									company[5] = "ID - Rep buy/sell facility sales (deco)";
									company[6] = "IT - rep buy/sell trade";
								}
								else{
									company=new String[8];
									company[0] = "CS-MUNCY";
									company[1] = "CS-CRANFORD";
									company[2] = "CS-INTERNATIONAL";
									company[3] = "DG - CS Facility Sales (decogard)";
									company[4] = "DL - CS Senior Living";
									company[5] = "GRAND ENTRANCE";
									company[6] = "IC - Intercompany";
									company[7] = "AE - CS Canada NEW";
								}











								for (int i = 0; i < company.length; i++) {
								 String selected = (company[i].equals(cs_company)) ? "selected" : "";
									%>
									<option value='<%= company[i] %>' <%= selected %>><%= company[i] %></option>
									<%
										}


									%>
								</select>


								<%
								if(group_id.toUpperCase().startsWith("REP")){
									out.println("<input type='hidden' name='cs_company' value='"+cs_company+"'>");

								}
								%>
							</td>
							<td  align='right' >ORDER TYPE:</td>
							<td ><select name='doc_type' onchange='checkCompany()'>
									<%
							if(isBpcsClosed){
								String[] otype = {"NEW ORDER","BUYSELL"};//"ADD/DEDUCT" used to an option was removed based on Jim on April 28'2006
								for (int i = 0; i < otype.length; i++) {
								String selected = (otype[i].equals(doc_type)) ? "selected" : "";
									%>			    <option value='<%= otype[i] %>' <%= selected %>><%= otype[i] %></option>
									<%
									    }
						}
						else{
							String[] otype = {"NEW ORDER","BUYSELL","ADD"};//"ADD/DEDUCT" used to an option was removed based on Jim on April 28'2006
							for (int i = 0; i < otype.length; i++) {
							String selected = (otype[i].equals(doc_type)) ? "selected" : "";
									%>			    <option value='<%= otype[i] %>' <%= selected %>><%= otype[i] %></option>
									<%
									    }
						}

									%>
								</select></td>
							<TD align='right'>BPCS NUMBER:</TD>
							<TD>
								<%
							if(isBpcsClosed){
								out.println("<FONT COLOR='RED'>"+bpcs_order_no+"&nbsp;CLOSED IN BPCS</FONT>");
							}
							else{
								out.println(bpcs_order_no);
							}
								%>
							</TD>
				</tr>
				<tr>
					<td class='noheader' align='right' ><b>SALES REGION:</b></td>
					<td class='noheader' >

						<%
	//out.println(product+"::"+georder);

					//ut.println(group_id+"::<BR>");
						if(sales_region==null || sales_region.equals("null")){
							sales_region="";
						}
						//out.println(product+":::"+sales_region+"::<BR>");
						//out.println(project_type);
						if((project_type.equals("PSA")&&!group_id.toUpperCase().startsWith("REP"))|group_id.startsWith("Deco")|group_id.startsWith("Grand")){
							out.println("<select name='sales_region'>");
						}else{

							if(group_id.toUpperCase().startsWith("REP")&&sales_region.trim().length()!=0){
								out.println("<input type='hidden' name='sales_region' value='"+sales_region+"'>");
								out.println("<select name='sales_regionx' disabled='disabled'>");
							}
							else{
								out.println("<select name='sales_region' >");
								//onfocus='this.initialSelect = this.selectedIndex;' onchange='this.selectedIndex = this.initialSelect;'>");
							}
						}

						%>


						<!-- <option></option> -->

						<%

					if(group_id.toUpperCase().startsWith("CAN")){
						String[] sregion = {"AB--Alberta","BC--British Columbia","MB--Manitoba","NB--New Brunswick","NL--Newfoundland","NSC--Nova Scotia","NU--Nunavut","NWT--Northwest Territ.","ON--Ontario","PEI--Prince Edward Island","QC--Quebec","SK--Saskatchewan","YT--Yukon Territories",""};
						for (int i = 0; i < sregion.length; i++) {
							String selected = (sregion[i].startsWith(sales_region)) ? "selected" : "";
						%>
				<option value='<%= sregion[i] %>' <%= selected %>><%= sregion[i] %></option>
				<%
			}
		}
		else if(product.equals("EFS")&&!georder.toUpperCase().equals("GE")){
		//String[] sregion = {"T--EFS EAST","U--EFS WEST",""};
		String[] sregion = {"T--EFS EAST","U--EFS WEST","B--INTERNATIONAL","E--LATIN AMERICA"};
		for (int i = 0; i < sregion.length; i++) {
			String selected = (sregion[i].startsWith(sales_region)) ? "selected" : "";
				%>
				<option value='<%= sregion[i] %>' <%= selected %>><%= sregion[i] %></option>
				<%
			}
		}
		else if (product.equals("EJC")){
			String[] sregion = {"CT--EJC CENTRAL","D--EJC EAST","MT--EJC MOUNTAIN","Q--EJC WEST","V--EJC PARKING","G--LATIN AMERICA","R--INTERNATIONAL"};
		//String[] sregion = {"CT--EJC CENTRAL","D--EJC EAST","MT--EJC MOUNTAIN","Q--EJC WEST","V--EJC PARKING","G--INT. EJC",""};
		for (int i = 0; i < sregion.length; i++) {
		String selected = (sregion[i].startsWith(sales_region)) ? "selected" : "";
				%>
				<option value='<%= sregion[i] %>' <%= selected %>><%= sregion[i] %></option>
				<%
					}
				}
				else if (product.equals("IWP")&&!georder.toUpperCase().equals("GE")){


					//String[] sregion = {"A--IWP EAST","W--IWP WEST","E--INTERNATIONAL","F--LATIN AMERICA",""};
					String[] sregion = {"A--IWP EAST","W--IWP WEST","J--IWP MIDWEST","IE--IWP SOUTHEAST","E--INTERNATIONAL","F--LATIN AMERICA"};

						for (int i = 0; i < sregion.length; i++) {
						String selected = (sregion[i].startsWith(sales_region)) ? "selected" : "";
				%>
				<option value='<%= sregion[i] %>' <%= selected %>><%= sregion[i] %></option>
				<%
				}









		}
		else if (product.equals("LVR")|product.equals("BV")){
		String[] sregion = {"MW--LVR","NE--LVR","WT--LVR"};
		for (int i = 0; i < sregion.length; i++) {
		String selected = (sregion[i].startsWith(sales_region)) ? "selected" : "";
				%>
				<option value='<%= sregion[i] %>' <%= selected %>><%= sregion[i] %></option>
				<%
					}
				}
				else if (product.equals("GE")|georder.equals("GE")){

					ResultSet rsGroupCode=stmt.executeQuery("select region from cs_ge_group_codes where ccode='"+group_code+"'");
					if(rsGroupCode != null){
						while(rsGroupCode.next()){
							sales_region=rsGroupCode.getString(1);
						}
					}
					rsGroupCode.close();
					String select ="";
					ResultSet rsRegion=stmt.executeQuery("select * from cs_regions where product_id='ge'");
					if(rsRegion != null){
						while(rsRegion.next()){
							if(sales_region.equals(rsRegion.getString("region_code"))){
								select="selected";
							}
							out.println("<option value='"+rsRegion.getString("region_code")+"--"+rsRegion.getString("region")+"' "+select+">"+rsRegion.getString("region_code")+"--"+rsRegion.getString("region")+"</option>");
							select="";
						}
					}
					rsRegion.close();

				}
				else if (product.equals("GCP")){
					String[] sregion = {"EA--GCP","MD--GCP","WW--GCP","Y--International"};
					for (int i = 0; i < sregion.length; i++) {
					String selected = (sregion[i].startsWith(sales_region)) ? "selected" : "";
				%>
				<option value='<%= sregion[i] %>' <%= selected %>><%= sregion[i] %></option>
				<%
					}
			}
			else if (product.equals("ADS")){
				String[] sregion = {"","DE - ADS East","DS - ADS Midwest","DU - ADS South","DW - ADS West","DI - ADS I/C"};
				for (int i = 0; i < sregion.length; i++) {
				String selected = (sregion[i].startsWith(sales_region)) ? "selected" : "";
				%>
				<option value='<%= sregion[i] %>' <%= selected %>><%= sregion[i] %></option>
				<%
					}
			}
			else {
				String[] sregion = {"----","----"};
				for (int i = 0; i < sregion.length; i++) {
					String selected = (sregion[i].equals(sales_region)) ? "selected" : "";
				%>
				<option value='<%= sregion[i] %>' <%= selected %>><%= sregion[i] %></option>
				<%
			}
		}
if(!group_id.toUpperCase().startsWith("CAN")){
						String[] sregion = {"AB--Alberta","BC--British Columbia","MB--Manitoba","NB--New Brunswick","NL--Newfoundland","NSC--Nova Scotia","NU--Nunavut","NWT--Northwest Territ.","ON--Ontario","PEI--Prince Edward Island","QC--Quebec","SK--Saskatchewan","YT--Yukon Territories",""};
						for (int i = 0; i < sregion.length; i++) {
							String selected = (sregion[i].startsWith(sales_region+"-")) ? "selected" : "";
							if(sregion[i].equals(sales_region)){
															selected="selected";
							}
				%>
				<option value='<%= sregion[i] %>' <%= selected %>><%= sregion[i] %></option>
				<%
			}
		}
				%></select></td>
				<td>&nbsp;</td><td>&nbsp;</td>
				<td  align='right' >ADD/DEDUCT JOB#:</td>
				<td ><input type='text' name="add_deduct_job" value='<%= add_deduct_job %>' class='text1'></td>
				</tr>

				<tr>
					<%
					if((product.equals("LVR") && rep_no.equalsIgnoreCase(project_rep_no)) || !product.equals("LVR")){

					%>
					<td  NOWRAP align='right'>OVERAGE</td>
					<td ><input type='text' name="overage" value='<%= overage%>' readonly class='text1'></td>
						<%
						}else{
						%>
					<td></td>
					<td></td>
					<%
				}
					%>
					<td class='noheader' align='right' >JOB NAME:</td>
					<td class='noheader' ><input type='text' name="Project_name" value='<%= Project_name %>' class='notext1'></td>
					<td class='noheader' align='right' >JOB LOCATION:</td>
					<td class='noheader' ><input type='text' name="Job_loc" value='<%= Job_loc %>' class='notext1'></td>
				</tr>
				<tr><td class='noheader' COLSPAN='6' align='right' ><HR></td></tr>
			</table>
			<table  border='0' width='100%'>
				<tr class='header1'><td COLSPAN='2' valign><h3>BILLING CUSTOMER ::</h3></td></tr>
				<tr><td  align='right' valign='top' ><b><a href="javascript:showPopup2x('bpcs_order_cust_search_new.jsp?mode=1&rep_no=<%= rep_no %>')" color="navy" face="Arial"">BILLING CUST NAME:</a></b>
								<%//<td  align='right' ><b><a href="javascript:explain1('BPCS Customer NO', 'opener.document.selectform.order_notes.value', 'Order Notes');" onMouseOver="window.status='Click for searchin BPCS Customer No...';return true;" onMouseOut="window.status='';return true;"">BILLING CUST NAME:</a></b></td>%>
								<%
								if(show.equals("Y")&cou<=0){
								//out.println("The CS CUSTOMER TIME"+cust_name11);
								cust_name1=cust_name11;cust_addr1=cust_addr11;cust_addr2=cust_addr21;city=cust_city1;state=cust_state1;
								zip_code=cust_zip_code1;phone=cust_phone1;fax=cust_fax1;
								if (cust_addr1==null){cust_addr1="";}
								}
								%>
					<td ><input type='text' name='cust_name1' value='<%= cust_name1 %>' class='text1' MAXLENGTH=40>
						<input type='hidden' name='bill_cust_bpcs_no' value='<%= bpcs_cust_no%>' class='text1'>
						<input type='hidden' name='bill_cust_bpcs_no_alt' value='<%= bpcs_cust_no_alt%>' class='text1'>
					</td>
					<td  align='right' >ADDRESS1:</td>
					<td ><input type='text' name='cust_addr1' value='<%= cust_addr1.trim() %>' class='text1' MAXLENGTH=40></td>
					<td  align='right' >ADDRESS2:</td>
					<td ><input type='text' name='cust_addr2' value='<%= cust_addr2 %>' class='text1' MAXLENGTH=40></td>
				</tr>
				<tr><td class='noheader' align='right' ><b>CITY:</b></td>
					<td class='noheader'><input type='text' name='city' value='<%= city %>' class='notext1' MAXLENGTH=40></td>
					<td class='noheader' align='right' ><b>STATE:</b></td>






					<td class='noheader'><select name='state'>
							<option></option>
							<%

							for (int i = 0; i < countryCodes.size(); i++) {
							 String selected = "";
							if(countryCodes.elementAt(i).toString().equals(state) || countrydesc.elementAt(i).toString().equals(state)){
									selected="selected";
							}
							%>
							<option value='<%= countryCodes.elementAt(i).toString() %>' <%= selected %>><%= countrydesc.elementAt(i).toString() %></option>
							<%
								}
							%>
						</select>






	<!--<input type='text' name='state' value='<%= state %>' class='notext1' MAXLENGTH=40>-->

					</td>

					<td class='noheader' align='right' >ZIP:</td>
					<td class='noheader'><input type='text' name='zip_code' value='<%= zip_code %>' class='notext1' MAXLENGTH=15>
					</td>
				</tr>
				<tr><td  align='right' ><b>PHONE:</b></td>
					<td ><input type='text' name='phone' value='<%= phone %>' class='text1' MAXLENGTH=25>	</td>
					<td  align='right' >FAX:</td>
					<td ><input type='text' name='fax' value='<%= fax %>' class='text1' MAXLENGTH=40>
					</td>
					<td  align='right' >
						<%
							if(product.equals("ADS")){
						%>
						<B>CONTACT NAME::</b>
							<%
						}
						else{
							%>
						CONTACT NAME:
						<%
					}
						%>


					</td>
					<td ><input type='text' name="contact_name" value='<%= contact_name.trim() %>' class='text1' MAXLENGTH=40></td>
				</tr>
				<tr>
					<td class='noheader' align='right' NOWRAP><b>P.O.NUMBER (OR) SIGNED BY</b><BR>(Ex:John Doe as JDOE):</td>
					<td class='noheader'><input type='text' name="customer_po_no" value='<%= customer_po_no%>' class='notext1'></td>
					<td class='noheader' align='right' >TAX EXEMPT NUMBER:</td>
					<td class='noheader'><input type='text' name="sales_exempt_no" value='<%= sales_exempt_no%>' class='notext1' MAXLENGTH=20></td>
					<td class='noheader' align='right' >
						<%
						if(product.equals("ADS")){
						%>
						<B>CUSTOMER TYPE:</b>
							<%
						}
						else{
							%>
						CUSTOMER TYPE:
						<%
					}
						%></td>
					<td class='noheader'><select name='customer_type'>
							<option></option>
							<%
					String[] cust_type = {"CTR-CONTRACTOR","EU-END USER","RES-RESELLER","DIST-DISTRIBUTOR","OEM-ORIG EQUIP MFG","JV-JOINT VENTURE","ARCH-ARCHITECT","COMP-COMPETITOR","FF-FREIGHT FORWADER"};
					for (int i = 0; i < cust_type.length; i++) {
					String selected = (cust_type[i].equals(customer_type)) ? "selected" : "";
							%>			    <option value='<%= cust_type[i] %>' <%= selected %>><%= cust_type[i] %></option>
							<%
							    }
							%>
						</select></td>

				</tr>
				<tr><td  nowrap align='right' >MARKET TYPE:</td>
					<td ><input type='text' name="market_type" value='<%= market_type%>'  class='text1' MAXLENGTH=40></td>
					<td  nowrap align='right' >CREDIT CARD SALE:</td>
					<td ><select name='payment'>
							<%
							if(payment_terms.equals("CC")){
								out.println("<option value='NET 30 DAYS' >"+"&nbsp;"+"</option>");
								out.println("<option value='CC' selected>"+"Credit Card"+"</option>");
								out.println("<option value='CC1'>"+"Credit Card(Same as Billing)"+"</option>");
								if(project_type.toUpperCase().equals("WEB")){
									out.println("<option value='CW'>"+"Web Store"+"</option>");
								}
							}
							else if(payment_terms.equals("CC1")){
								out.println("<option value='NET 30 DAYS'>"+"&nbsp;"+"</option>");
								out.println("<option value='CC' >"+"Credit Card"+"</option>");
								out.println("<option value='CC1' selected>"+"Credit Card(Same as Billing)"+"</option>");
								if(project_type.toUpperCase().equals("WEB")){
									out.println("<option value='CW'>"+"Web Store"+"</option>");
								}
							}
							else if(payment_terms.equals("CW")){
								out.println("<option value='NET 30 DAYS'>"+"&nbsp;"+"</option>");
								out.println("<option value='CC' >"+"Credit Card"+"</option>");
								out.println("<option value='CC1' >"+"Credit Card(Same as Billing)"+"</option>");
								if(project_type.toUpperCase().equals("WEB")){
									out.println("<option value='CW' selected>"+"Web Store"+"</option>");
								}
							}
							else{
								out.println("<option value='NET 30 DAYS' selected>"+"&nbsp;"+"</option>");
								out.println("<option value='CC'>"+"Credit Card"+"</option>");
								out.println("<option value='CC1' >"+"Credit Card(Same as Billing)"+"</option>");
								if(project_type.toUpperCase().equals("WEB")){
									out.println("<option value='CW'>"+"Web Store"+"</option>");
								}
							}
							%>
						</select></td>
					<td  nowrap align='right' >SAME FOR:</td>
					<td >SHIPPING&nbsp;
						<% if (cust_ship_info.equals("Y")){
						out.println("<input type='checkbox' name='cust_ship_info' checked>");
						}
						else{
						out.println("<input type='checkbox' name='cust_ship_info' >");
						}
						%>
						&nbsp;INVOICE&nbsp;
						<% if (cust_invoice_info.equals("Y") || ((cust_invoice_info==null || cust_invoice_info.trim().length()<1) && (project_type.toUpperCase().equals("WEB")||product.equals("GE")))){
						out.println("<input type='checkbox' name='cust_invoice_info' checked>");
						}
						else{
						out.println("<input type='checkbox' name='cust_invoice_info' >");
						}
						%>
						END USER
						<%
						String endUserChecked="";

						if (end_user_info.equals("Y")){
							endUserChecked="checked";
						}
						%>
						<input type='checkbox' name='end_user_info' onclick='endUser()' value='1' <%=endUserChecked%>>
					</td>
				</tr>
				<tr><td class='noheader' align='right'><b>EMAIL:</b> </td>
					<td class='noheader'><input type='text' name='billed_email' value="<%= billed_email%>" class='notext1' MAXLENGTH=100></td>
					<td class='noheader' align='right' >COUNTRY:</td>
					<td class='noheader'><select name='country'>
							<option></option>
							<%

							for (int i = 0; i < ccodes.size(); i++) {
							 String selected = (ccodes.elementAt(i).toString().equals(cust_country)) ? "selected" : "";
							%>
							<option value='<%= ccodes.elementAt(i).toString() %>' <%= selected %>><%= cdesc.elementAt(i).toString() %></option>
							<%
								}
							%>
						</select>	</td>
					<td></td>
					<%
					String acknowledgementChecked="";
					if(email_acknowledgement.equals("on")|| ((email_acknowledgement==null || email_acknowledgement.trim().length()<1) && (project_type.toUpperCase().equals("WEB")||((product.equals("IWP")||product.equals("EFS")||product.equals("EJC")||product.equals("ADS"))&&cou==0)))){
							acknowledgementChecked="checked";
					}
					%>
					<td class='noheader'><input type='checkbox' name='email_acknowledgement' <%=acknowledgementChecked%>>EMAIL ACKNOWLEDGEMENT</TD>
				</tr>

				<tr><td class='noheader' COLSPAN='6' align='right' ><HR></td></tr>
			</table>
			<table  border='0' width='100%'>
				<tr class='header1'><td COLSPAN='2'><h3>END USER ::</h3></td></tr>
				<tr><td  align='right' >

						<%
						if (product.equals("GE")){
							String bpcsEndUserNo="";
							ResultSet rsGe1=stmt.executeQuery("select end_user from cs_project where order_no ='"+order_no+"'");
							if(rsGe1 != null){
								while(rsGe1.next()){
									if(rsGe1.getString(1)!= null &&rsGe1.getString(1).trim().length()>0){
										bpcsEndUserNo=rsGe1.getString(1);
									}
								}
							}
							rsGe1.close();
							//out.println(bpcsEndUserNo);
							if(bpcsEndUserNo==null || bpcsEndUserNo.trim().length()==0){
								String queryCodes="SELECT cust_shipping_no FROM cs_ge_group_codes where ccode='"+group_code+"'";
								ResultSet rsCodes=stmt.executeQuery(queryCodes);

								if(rsCodes != null){
									while(rsCodes.next()){
										bpcsEndUserNo=rsCodes.getString(1);
									}
								}
								rsCodes.close();
							}

							if(bpcsEndUserNo!=null && bpcsEndUserNo.trim().length()>0){
								//out.println("BPCS END USER NO :: "+bpcsEndUserNo+"::<BR>");
								String query="SELECT ccust, cnme, cad1, cad2, cad3, cste, czip, cphon, stadtp, tship, tname, tatn, tadr1, tadr2, tadr3, tste, tpost, tphone, CMFAXN from bpcsffg/rcm left outer join bpcsffg/est on ccust = tcust where ccust = "+bpcsEndUserNo+" and cmid='CM' order by ccust, stadtp, tship";

								ResultSet rs0=stmt_bpcsusrmm.executeQuery(query);
								if(rs0 != null){
									while(rs0.next()){
										//out.println(rs0.getString(1)+"::"+rs0.getString(2)+"::"+rs0.getString(3)+"::"+rs0.getString(4)+"::<BR>");
										eu_cust_name1=rs0.getString(2);
										eu_cust_addr1=rs0.getString(3);
										eu_cust_addr2=rs0.getString(4);
										eu_city=rs0.getString(5);
										eu_state=rs0.getString(6);
										eu_zip_code=rs0.getString(7);
										eu_phone=rs0.getString(8);
										eu_fax=rs0.getString(19);
										eu_bpcs_cust_no=rs0.getString(1);


									}
								}
								rs0.close();
							}


						}
						%>







						<a href="javascript:showPopup2('bpcs_order_cust_search_new.jsp?mode=2&rep_no=<%= rep_no %>')" color="navy" face="Arial"">OWNER/END USER NAME:</a>
						<!--&nbsp;&nbsp;&nbsp;<a href="javascript:showPopup2('http://<%= application.getInitParameter("HOST")%>/erapid/us/orders/ows/bpcs_order_cust_search.jsp?mode=2&rep_no=<%= rep_no %>')" color="navy" face="Arial"">OWNER/END USER NAME:</a>-->
					</td>
					<td ><input type='text' name="eu_cust_name1" value='<%= eu_cust_name1 %>' class='text1'>
						<input type='hidden' name="eu_cust_bpcs_no"  class='text1' value='<%= eu_bpcs_cust_no%>'>
						<input type='hidden' name="eu_cust_bpcs_no_alt"  class='text1' value='<%= eu_bpcs_cust_no_alt%>'>
					</td>
					<td  align='right' >ADDRESS1:</td>
					<td ><input type='text' name="eu_cust_addr1" value='<%= eu_cust_addr1.trim() %>' class='text1' MAXLENGTH=40></td>
					<td  align='right' >ADDRESS2:</td>
					<td ><input type='text' name="eu_cust_addr2" value='<%= eu_cust_addr2 %>' class='text1' MAXLENGTH=40></td>

				</tr>
				<tr><td class='noheader' align='right' >CITY:</td>
					<td class='noheader'><input type='text' name="eu_city" value='<%= eu_city %>' class='notext1' MAXLENGTH=40></td>
					<td class='noheader' align='right' >STATE:</td>


					<td class='noheader'><select name='eu_state'>
							<option></option>
							<%

							for (int i = 0; i < countryCodes.size(); i++) {




							 String selected = (countryCodes.elementAt(i).toString().equals(eu_state)) ? "selected" : "";



							//String selected = "";
							//if(countryCodes.elementAt(i).toString().equals(eu_state) || countrydesc.elementAt(i).toString().equals(eu_state)){
							//		selected="selected"
							//}





							%>
							<option value='<%= countryCodes.elementAt(i).toString() %>' <%= selected %>><%= countryCodes.elementAt(i).toString() %></option>
							<%
								}
							%>
						</select>





					</td>






	<!--<td class='noheader'><input type='text' name="eu_state" value='<%= eu_state %>' class='notext1' MAXLENGTH=40></td>-->
					<td class='noheader' align='right' >ZIP:</td>
					<td class='noheader'><input type='text' name="eu_zip_code" value='<%= eu_zip_code %>' class='notext1' MAXLENGTH=15></td>
				</tr>
				<tr><td  align='right' >PHONE:</td>
					<td ><input type='text' name="eu_phone" value='<%= eu_phone %>' class='text1' MAXLENGTH=40></td>
					<td  align='right' >FAX:</td>
					<td ><input type='text' name="eu_fax" value='<%= eu_fax %>' class='text1' MAXLENGTH=40></td>
					<td  align='right' >MARKET TYPE:</td>
					<%if ( market_type1 ==null ){
					market_type1="";
					}

					%>
					<td ><input type='text' name="eu_market_type" value='<%= market_type1 %>' class='text1' MAXLENGTH=40></td>
				</tr>

				<tr><td class='noheader' COLSPAN='6' align='right' ><HR></td></tr>
			</table>

			<table border='0' align='right'>
				<tr>
					<td COLSPAN='3' align='right'>Page 1</td>
					<%
					if (ow_sent.equals("Y")){
					%>
					<td COLSPAN='3' align='right'>| <a href="order_transfer.jsp?cmd=2&order_no=<%= order_no %>&id=<%= rep_no %>">View Page 2</a></td>
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
if(fp==null && fpx!=null){
	fp=fpx;
}
if(fp==null){
	fp="";
}
String repPortalUsersList="'128', '331', '347', '329', '112', '381', '180', '133', '289', '1832', '1750', '150', '111', '85', '108', '102','104','275','9093'";
if((fp.equals("rp") || project_type.equals("SFDC") || project_type.equals("RP")) && (repPortalUsersList.contains("'"+assigned_rep_no+"'") || repPortalUsersList.contains("'"+project_rep_no+"'"))){
	
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