<% request.setCharacterEncoding( response.getCharacterEncoding() ); %>
<jsp:useBean id="homeQuoteHeader" 	class="com.csgroup.general.QuoteHeaderBean" 	scope="page"/>
<%@ page language="java" import="java.text.*" import="java.util.*" import="java.io.*"   contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="error.jsp" %>
<%
        String pageName="home";
%>
<%@ include file="header.jsp"%>
<div id='container' class='container'>
	<div class="mainbody" id='mainbody'>
		<script language="JavaScript" src="../javascript/ajax.js"></script>
		<script language="JavaScript" src="../javascript/homeUS.js"></script>
		<script language="JavaScript" src="../test/date-picker.js"></script>
		<script language="JavaScript" src="../javascript/headerUS.js"></script>
		<script language="JavaScript" src="../javascript/polishCharacters.js"></script>
		<body onload=JavaScript:changeSearch('searchBean.jsp')>
			<%
			org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
			try{
				   String[] products=userSession.getProducts();
				   String[] productsDescription=userSession.getProductsDescription();
				   String[] editProducts=userSession.getEditProducts();
				   String[] editProductsDescription=userSession.getEditProductsDescription();
				   String[] reps=userSession.getReps();
				   String[] repsNames=userSession.getRepsNames();
				   String search="";
				   String selected2="";
				   String how="";
				   String by="";
				   String webNum="";
                                   String blockErapidQuoting=userSession.getblockErapidQuoting();
                                   
				   //out.println(userSession.getCountry()+":: country<BR>");
			%>
			<table border='0' width='1180px;' cellpadding='0' CELLSPACING="0">
				<tr><td valign='top' align='left' width='40%'>
						<form method='post' name='formNew' action='lineItem.jsp'>
							<input type='hidden' name='userRepNo' value='<%=userSession.getRepNo()%>'>
							<input type='hidden' name='env' value='<%=userSession.getEnv()%>'>
							<input type='hidden' name='altRep' value=''>
							<input type='hidden' name='psaNo' value=''>
							<input type='hidden' name='username' value='<%=userSession.getUserId()%>'>
                                                        <% if(blockErapidQuoting.equals("Y")){
                                                                   out.println("<font color='red' size='3'>You are no longer allowed to quote in erapid.<BR> Please use Rep Portal.</font>");
                                                                   out.println("<input type='hidden' name='qtype' value=''>");
                                                        }
                                                        else{ 
                                                        %>
                                                        
							<h2>NEW QUOTE</h2>
							<TABLE BORDER="0" CELLPADDING="0" CELLSPACING="0">
								<TR><TD WIDTH="125px" ALIGN="RIGHT" class="important">QUOTE TYPE: </TD>
									<TD align='left'><select name='qtype' onchange="SelectOrderNo()">
                                                                                
											<option value='1'>NEW</option>
											<option value='alt'>ALTERNATE</option>
											<option value='cpy'>COPY</option>
											<%=homeQuoteHeader.getPullDownValues(userSession.getCountry(),"*",userSession.getGroup(),"quote_type")%>
										</select>
									</TD>
								</TR>
								<TR id='productPullDown'>
									<TD WIDTH="125px" ALIGN="RIGHT" class="important">PRODUCT: </TD>
									<TD><select name='product'>
											<option value=''>----------SELECT ONE----------</option>
											<%
											for (int ik=0; ik<products.length;ik++){
												   out.println("<option value='"+products[ik]+"' >"+productsDescription[ik]+" </option>");
											}

											%>
										</select>
									</TD>
								</TR>
								<%
								if(userSession.getGroup().toUpperCase().indexOf("REP")<0){
								%>
								<TR id="divSubcat2"><TD WIDTH="125px" ALIGN="RIGHT" class="important">REP NO: </TD>
									<TD><select name='repNum'>
											<%
											out.println("<option value='"+userSession.getRepNo()+"'>&nbsp;</option>");
											for(int i=0; i<reps.length; i++){
												   out.println("<option value='"+reps[i]+"'>"+repsNames[i]+"--"+reps[i]+"</option>");
											}
											%>
										</select></TD></TR>
										<%
								  }


										%>
								<TR id="divSubcat" style="display: none;"><TD WIDTH="125px" ALIGN="RIGHT" class="important">QUOTE NO:</TD>
									<TD><input type='text' readonly name='altCpyNo'  value='' class='text'>
										<input type='text' name='altCpyNox' value=''>

									</TD></TR>
								<TR><TD>&nbsp;</TD><TD align='center'><input type='button' name='sbmt' id='sbmt' value='Start' onclick="check()" class='button'></TD></TR>
							
                                                        </table>
                                                                <%}%>
						</form>

					</td><td valign='top' width='60%' align='right' rowspan='2'>





						<form name='form1' action='lineItem.jsp' method='post'>
							<h2>EDIT/SEARCH QUOTE</h2>
							<input type='hidden' name='userId' value='<%=userSession.getUserId()%>'>
							<input type='hidden' name='countryCode' value='<%=userSession.getCountry()%>' %>
							<input type='hidden' name='orderNox'>
							<input type='hidden' name='currentRepNo' value='<%=userSession.getRepNo()%>'>
							<input type='hidden' name='currentUserId' value='<%=userSession.getUserId()%>'>
							<input type='hidden' name='firstOrderNo'>
							<input type='hidden' name='lastOrderNo'>
							<input type='hidden' name='rangeStart' value='0'>
							<input type='hidden' name='rangeEnd' value='0'>
							<input type='hidden' name='numberOfRecords' value='0'>
							<input type='hidden' name='functionName' value=''>
							<input type='hidden' name='searchGroup' value='<%=userSession.getGroup()%>'>
							<input type='hidden' name='searchCount' value='0'>
							<input type='hidden' name='env' value='<%=userSession.getEnv()%>'>
							<div id='searchDiv1'>
								<%
								String product=request.getParameter("product");
								String orderNo="";
								String orderDate="";
								String custLoc="";
								String projectName="";
								String archName="";
								String bpcsNo="";
								String repNo=request.getParameter("repNum");
								String select="";
								out.println("<table width='100%' border='0' CELLPADDING='0' CELLSPACING='0'>");
								out.println("<tr><td>PRODUCT:</td>");
								out.println("<td><select name='product_id' onchange=JavaScript:changeSearch('searchBean.jsp') class='select2'>");
								out.println("<option value=''></option>");
								for (int ik=0; ik<products.length;ik++){
									   if(products[ik].equals(product)){
											 select="selected";
									   }
									   out.println("<option value='"+products[ik]+"' "+select+">"+productsDescription[ik]+" </option>");
									   select="";
								}
								for (int ik=0; ik<editProducts.length;ik++){
									   if(editProducts[ik].equals(product)){
											 select="selected";
									   }
									   out.println("<option value='"+editProducts[ik]+"' "+select+">"+editProductsDescription[ik]+" </option>");
									   select="";
								}
								out.println("</select></td>");

								%>
								<td>QUOTE NO:</td><td><input type='text' name='orderNo' value='<%=orderNo%>' onkeyup='JavaScript:changeSearch("searchBean.jsp")' class='text2'></td>
								</tr>
								<tr>
									<td>QUOTE DATE:</td><td>

										<input type="text" name='orderDate1' id='orderDate1' value="" onfocus='JavaScript:changeSearch("searchBean.jsp")' onkeyup='JavaScript:changeSearch("searchBean.jsp")' onclick="show_calendar('form1.orderDate1')" readonly class='date' />

										<a href="javascript:show_calendar('form1.orderDate1');" 	onmouseover="return true;" 	onmouseout="return true;" >
											<img src="../images/cal.gif" width=19 height=18 border=0></a>

										<input type="text" name='orderDate2' id='orderDate2' value="" onfocus='JavaScript:changeSearch("searchBean.jsp")' onkeyup='JavaScript:changeSearch("searchBean.jsp")' onclick="show_calendar('form1.orderDate2')" readonly class='date' />

										<a href="javascript:show_calendar('form1.orderDate2');" onmouseover="return true;" 	onmouseout="return true;">

											<img src="../images/cal.gif" width=19 height=18 border=0></a>

									</td>

									<td>CUSTOMER:</td><td><input type='text' name='custLoc' value='<%=custLoc%>' onkeyup='JavaScript:changeSearch("searchBean.jsp")' class='text2'></td>
								</tr>
								<tr>
									<td>PROJECT NAME:</td><td><input type='text' name='projectName' value='<%=projectName%>' onkeyup='JavaScript:changeSearch("searchBean.jsp")' class='text2'></td>
									<td>ARCHITECT:</td><td><input type='text' name='archName' value='<%=archName%>' onkeyup='JavaScript:changeSearch("searchBean.jsp")' class='text2'></td>
								</tr>
								<tr>

									<%

									out.println("<td>TYPE:</td>");
									out.println("<td><select name='quoteType' onchange=JavaScript:changeSearch('searchBean.jsp') class='select2'>");
									out.println("<option value=''></option>");
									if(userSession.getGroup().equals("GrandE")){
										String byType[]={"quotes","orders","budget","lost","profile"};
										String byName[]={"Quotes","Orders","Budget","Lost","Profile"};
										for(int i=0; i<byType.length; i++){
											   if(byType[i].equals(by)){
													 select="selected";
											   }
											   out.println("<option value='"+byType[i]+"' "+select+">"+byName[i]+"</option>");
										}
									}
									else{
										String byType[]={"quotes","orders","budget","lost"};
										String byName[]={"Quotes","Orders","Budget","Lost"};
										for(int i=0; i<byType.length; i++){
											   if(byType[i].equals(by)){
													 select="selected";
											   }
											   out.println("<option value='"+byType[i]+"' "+select+">"+byName[i]+"</option>");
										}
									}
									out.println("</select></td>");
									%>
									<td>BPCS ORDER NO:</td><td><input type='text' name='bpcsNo' value='<%=bpcsNo%>' onkeyup='JavaScript:changeSearch("searchBean.jsp")' class='text2'></td>
								</tr>
								<%
									if(userSession.getGroup().toUpperCase().indexOf("REP")<0){
										out.println("<td>REP NUMBER:</td><td><select name='repNo' onchange=JavaScript:changeSearch('searchBean.jsp') class='select2'>");
										out.println("<option value=''></option>");
										out.println("<option value='myQuotes"+userSession.getRepNo()+"'>My Quotes</option>");
										for(int i=0; i<reps.length; i++){
											if(reps[i].equals(repNo)){
												select="selected";
											}
											out.println("<option value='"+reps[i]+"' "+select+">"+repsNames[i]+"--"+reps[i]+"</option>");
										}
										out.println("</select></td>");
									}
									else{
										   out.println("<input type='hidden' name='repNo' value='"+userSession.getRepNo()+"'>");
									}
									out.println("<td>WEBSTORE NO:</td><td><input type='text' name='webNum' value='"+webNum+"' onkeyup=JavaScript:changeSearch('searchBean.jsp') class='text2'></td>");

									//}
									//else{
									//	   out.println("<input type='hidden' name='repNo' value='"+userSession.getRepNo()+"'>");
									//		out.println("<input type='hidden' name='webNum' value=''>");
									//}
								%>

								</table>
								<br>


							</div>
							<div id='searchDiv2' class='searchDiv2'>
								<%
									out.println("<table width='100%' border='0' CELLPADDING='0' CELLSPACING='0'>");
									out.println("<tr><td>PSA PROJECT NAME:</td>");
									out.println("<td><input type='text' name='psaProjectName' onkeyup=JavaScript:changeSearch('psaSearchBean.jsp') >");
									out.println("</td></tr></table>");

								%>
							</div>
						</form>



						<table border='0' ><tr><td valign='center' align='right'>
									<input type="image" src="../images/start.gif" name="start" onclick='goToStart()' id='goToStart' height='16'>
									<input type='image' src='../images/back.gif' name='goBack' onclick='goBack()' id='goBack' height='16'></td><td valign='center'>
									<label id='rangeStartx'>rangeStart</label> - <label id='rangeEndx'>rangeEnd</label> of <label id='numberOfRecordx'>numberOfRecords</label></td><td>
									<input type='image' src='../images/forward.gif' name='goForward' id='goForward' onclick='goForward()' height='16'>
									<input type='image' src='../images/end.gif' name='goToEnd' id='goToEnd' onclick='goToEnd()' height='16'></td></tr></table>
					</td></tr>
				<tr>
					<td>
						<table border='0' width='100%'>
							<tr>
								<td valign='bottom' align='left'>
									<label id='searchNote'>Top 10</label>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<table table border='0' width='1180px;'><TR><TD>
							<div id="result" class='results'></div>
						</td></tr>

				</table>

				<%

		  }
		  catch(Exception e){
				//out.println("test");

				logger.debug("START ERROR home.jsp");
				logger.debug("Exception:"+e);
				logger.debug("User ID:"+userSession.getUserId());
				logger.debug("User Name:"+userSession.getUserName());
				logger.debug("Order Number:"+userSession.getOrderNo());
				logger.debug("Country: "+userSession.getCountry());
				logger.debug("END ERROR");
				out.println("ERROR: CONTACT ERAPID TEAM");
				out.println("::"+e);

		  }
				%>

				</td></tr></table>
	</div>
	<div id='customerSearch' class='customerSearch'>
		<form name='custSearch'>
			<table width='1180px;' border='0'>
				<tr class='header1'><td>
						<h3>CUSTOMER MAINT</h3></td></tr>
			</table>
			<input type='hidden' name='searchCustomerRepNo' value='<%=userSession.getRepNo() %>'>
			<input type='hidden' name='searchCustomerRepGroup' value='<%=userSession.getGroup() %>'>
			<input type='hidden' name='searchCustomerRepCountry' value='<%=userSession.getCountry() %>'>
			<input type='hidden' name='firstCustomerNo'>
			<input type='hidden' name='lastCustomerNo'>
			<input type='hidden' name='customerRangeStart' value='0'>
			<input type='hidden' name='customerRangeEnd' value='0'>
			<input type='hidden' name='numberOfCustomerRecords' value='0'>
			<table width='1180px;' border='0'>
				<tr>
					<td>
						NAME
					</td>
					<td>
						<input type='text' name='searchCustomerCustomerName' onkeyup='JavaScript:changeCustomerSearch("customerSearchBean.jsp")' class='text2'>
					</td>

					<td>
						CITY
					</td>
					<td>
						<input type='text' name='searchCustomerCity' onkeyup='JavaScript:changeCustomerSearch("customerSearchBean.jsp")' class='text2'>
					</td>

					<td>
						TAX NO
					</td>
					<td>
						<input type='text' name='searchCustomerTaxNo' onkeyup='JavaScript:changeCustomerSearch("customerSearchBean.jsp")' class='text2'>
					</td>
				</tr>
				<tr>
					<td colspan='6' align='center'>
						<input type='button' name='add' value='New Customer' onclick='addCustomer()' class='button'>
						<input type='button' name='cancel' value='Cancel' onclick='goHome()' class='button'>
					</td>
				</tr>
			</table>
		</form>
		<div id='customerSearchResults' ></div>
	</div>
	<div id='customerEdit' class='customerSearch'>
		<form name='editCustomer'>
			<%
			out.println("<input type='hidden' name='custNo' value=''>");
			out.println("<input type='hidden' name='isDup' value=''>");
			out.println("<input type='hidden' name='countryCode' value=''>");
			out.println("<input type='hidden' name='custNoText' value=''>");
			out.println("<input type='hidden' name='createdRepNo' value=''>");
			out.println("<input type='hidden' name='custName2' value=''>");
			out.println("<input type='hidden' name='attention' value=''>");
			out.println("<input type='hidden' name='salutation' value=''>");
			out.println("<input type='hidden' name='shippingCity' value=''>");
			//out.println("<input type='hidden' name='billCust' value=''>");
			out.println("<input type='hidden' name='marketType' value=''>");
			out.println("<input type='hidden' name='contactName' value=''>");

			out.println("<input type='hidden' name='currency' value=''>");
			out.println("<table width='1180px;' border='0'> ");
			out.println("<tr class='header1'>");
			out.println("<td colspan='4' align='center'><h3>CUSTOMER PROFILE</h3> </td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td width='25%' align='left'>Company Name :</td>");
			out.println("<td width='25%' align='left'><input type='text' name='custName1' class='text' value=''></td>");


			out.println("<td width='25%' align='left'>Address 1:</td>");
			out.println("<td width='25%' align='left'><input type='text' name='custAddr1' class='text' value=''></td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td width='25%' align='left'>Address 2:</td>");
			out.println("<td width='25%' align='left'><input type='text' name='custAddr2' class='text' value=''></td>");
			out.println("<td width='25%' align='left'>City:</td>");
			out.println("<td width='25%' align='left'><input type='text' name='city' class='text' value=''></td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td width='25%' align='left'>State:</td>");
			out.println("<td width='25%' align='left'><select name='state'>"+homeQuoteHeader.getPullDownValues(userSession.getCountry(),"*",userSession.getGroup(),"project_state")+"</select></td>");

			out.println("<td width='25%' align='left'>Zip:</td>");
			out.println("<td width='25%' align='left'><input type='text' name='zipCode' class='text' value=''></td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td width='25%' align='left'>Country:</td>");
			out.println("<td width='25%' align='left'><select name='country'>"+homeQuoteHeader.getCountries2()+"</select></td>");
			out.println("<td width='25%' align='left'>Phone:</td>");
			out.println("<td width='25%' align='left'><input type='text' name='phone' class='text' value=''></td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td width='25%' align='left'>Fax:</td>");
			out.println("<td width='25%' align='left'><input type='text' name='fax' class='text' value=''></td>");
			out.println("<td width='25%' align='left'>Email:</td>");
			out.println("<td width='25%' align='left'><input type='text' name='email' class='text' value=''></td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td width='25%' align='left'>BPCS Cust No:</td>");
			out.println("<td width='25%' align='left'><input type='text' name='bpcsCustNo' class='text' value=''></td>");
			out.println("<td width='25%' align='left'>Billing Customer:</td>");
			out.println("<td width='25%' align='left'><input type='checkbox' name='billCust' value=''></td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td colspan='2'>&nbsp;</td>");
			out.println("<td width='25%' align='left'>Dormant:</td>");
			out.println("<td width='25%' align='left'><input type='checkbox' name='dormant' value=''></td>");
			out.println("<tr>");

			out.println("<td align='center' colspan='4'><input type='button' name='saveCustomer' value='Save' onclick='checkCustomer()' class='button'><input type='button' name='cancel' value='Cancel' onclick='goHome()' class='button'>");
			out.println("</tr>");
			out.println("</table>");

			%>
		</form>
		<%@ include file="contacts.jsp"%>
	</div>

</div>
</body>
</html>