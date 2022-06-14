
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>OWS</title>
		<link rel='stylesheet' href='../../../css/styleMain.css' type='text/css'/>
		<script language="JavaScript" src="../../../test/date-picker.js"></script>
		<script language="JavaScript" >
		 window.onload = zipCodeCheck;
			function check(){
				
				
				
				var radio_choice=false;
				for(var i=0;i<selectform.order_status.length;i++){
					if(selectform.order_status[i].checked){
						radio_choice=true;
					}
				}

				if(radio_choice){
					//alert('Order Status selected good to proceed');
					if(selectform.ship_date.value==null||selectform.ship_date.value==""){
						alert('Please enter ship date');
					}
					else{
						var agree=confirm("Are you sure?");
						if(agree){
							selectform.submit();
						}






					}
				}
				else{
					alert('Please select an Order Status to proceed');
				}

			}
			function dothis(){
				selectform.submit();
			}
			
			function zipCodeCheck(){
				var project_type = document.selectform.project_type.value;
				if(project_type=="RP" || project_type=="SFDC")
				{						
						var quote_type = document.selectform.quote_type.value;
						var taxZipCode = document.selectform.tax_zip.value;
						var order_no = document.selectform.order_no.value;
						var product_id = document.selectform.product_id.value;
						var sfdc_QuoteId = document.selectform.sfdc_QuoteId.value;
						
						//alert("  sfdc_QuoteId  "+sfdc_QuoteId)
				if(product_id!=="ADS" && product_id!=="LVR" && product_id!=="GRILLE")
				{
					if(quote_type=="O" && (taxZipCode==null || taxZipCode=="" || taxZipCode=="null" || taxZipCode=="NULL"))
					{
						alert("Zip code is missing from the order. Please update the zip code in the price calculator.");
						window.top.location.href = 'https://maya-cscrm.cs67.force.com/apex/CSQuoteLineProcessing?sfQuoteId='+sfdc_QuoteId+'1';
					}
				}
				}						
				
			}
				
	
		</script>

	</head>
	<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
	<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/>
	<%
	if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
		   erapidBean.setServerName("server1");
	}
	try{
		String username=request.getParameter("username");
		String fp= request.getParameter("fp");
		if(fp==null){
			fp="";
		}
		userSession.setUserId(username);
		String message="<font color='blue'>"+"Order Validation page"+"<font>";
		String name=userSession.getUserId();
		String group=userSession.getGroup();
//out.println(name+"::"+group);

	%>
	<%//@ include file="../../../rqs_head.jsp"%>
	<table width='100%'>
		<tr class='header1'><td>
				<h3>Erapid Order Write-up & Transfer Page::</h3></td></tr></table>



	<%@ page language="java" import="java.sql.*" import="java.text.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
	<%@ include file="../../../db_con.jsp"%>
	<%

			String order_no = request.getParameter("orderNo");//
			String cmd = request.getParameter("cmd");//what page
			String rep_no = request.getParameter("id");//rep_no

			String order_status="";String section_transfer="";String checked="";String quote_origin="";
			String[] oType ={"DR","HA","RF"};
			String[] oName ={"CS Drafting", "Hold for Approval", "Release for Fabrication"};
			//for getting the order status
			ResultSet rs = stmt.executeQuery("SELECT * FROM cs_order_info where order_no = '"+order_no+"'");
			if (rs !=null) {
			while (rs.next()) {
				order_status= rs.getString("order_status");
				}
			}
			rs.close();
			String ship_date="";
			ResultSet rs_ship = stmt.executeQuery("SELECT * FROM SHIPPING where Order_no like '"+order_no+"' ");
			if (rs_ship !=null) {
					while (rs_ship.next()) {
					ship_date= rs_ship.getString("request_date");
				}
			}
			rs_ship.close();
			if (order_status==null){order_status="";}
	//checking for release jobs are not
			//for checking if the job is sent to bpcs
			String product_id="";
			String project_type="",quote_type="",tax_zip="";
			ResultSet rs1_origin = stmt.executeQuery("SELECT quote_origin,product_id,project_type,quote_type,tax_zip FROM  cs_project where order_no = '"+order_no+"'");
			if (rs1_origin !=null) {
			while (rs1_origin.next()) {
				quote_origin= rs1_origin.getString("quote_origin");
				product_id= rs1_origin.getString("product_id");
				project_type=rs1_origin.getString("project_type");
				quote_type=rs1_origin.getString("quote_type");
				tax_zip=rs1_origin.getString("tax_zip");
				}
			}
			rs1_origin.close();
if(project_type==null){
				project_type="";
			}
			if(project_type.equals("RP")){
				fp="rp";
			}
		//	out.println(order_status+"::"+product_id);
	if(quote_origin!=null){
		if(quote_origin.startsWith("release")){
			order_status="RF";
		}
	}
		if (order_status==null|order_status.trim().equals("")){
			if(product_id.equals("GCP")){order_status="RF";}
		//	out.println(order_status+"1::"+product_id);
		}
			//for checking if the job is sent to bpcs
			ResultSet rs1 = stmt.executeQuery("SELECT * FROM  cs_quote_sections where order_no = '"+order_no+"'");
			if (rs1 !=null) {
			while (rs1.next()) {
				section_transfer= rs1.getString("section_transfer");

				}
			}
			rs1.close();
			
			// added by Yasoda GSO
			String sfdc_QuoteId = "";
			ResultSet rs_find = stmt.executeQuery("SELECT SFDC_QuoteId FROM cs_project where order_no like '"+order_no+"'");
			if (rs_find !=null) {
			while (rs_find.next()){
			sfdc_QuoteId=rs_find.getString ("SFDC_QuoteId");
			}
			}
			rs_find.close();
			
			if(product_id.equals("ADS")&&group.toUpperCase().startsWith("REP")||project_type.toUpperCase().equals("WEB")){
	%>
	<body onload='dothis()'>
		<%
	}
	else{
		%>
	<body>
		<%
	}
		%>
		<table border=0 align='center'>
			<tr class='important1' align="center" valign="middle">
				<%
				//out.println("Test"+order_status+"Test: "+section_transfer+"::"+section_transfer.length());
				out.println("<form name='selectform' action='order_entry_transfer_save.jsp' method='get'>");
				out.println("<input type='hidden' name='fp' value='"+fp+"'>");
				out.println("<td align='center' valign='top' colspan='2'><h5><b>Please select order status:</b></h5><br></td></tr>");
				if(project_type.toUpperCase().equals("WEB")){
					out.println("<input type='hidden' name='order_status' value='RF'>");
				}
				else if(product_id.equals("ADS")&&group.toUpperCase().startsWith("REP")){
					out.println("<input type='hidden' name='order_status' value='DR'>");
				}

				else{
					if(section_transfer==null||section_transfer.trim().length()<=0){// if the job is not transferred
					//out.println("NO");
						for(int u=0; u<oType.length; u++){
							String selected="";
							if(oType[u].equals(order_status)){checked="checked";}
							out.println("<tr>");
							out.println("<td align='left' valign='top' ><input type='radio' name='order_status' "+checked+" value='"+oType[u]+"'></td>");
							out.println("<td align='left' valign='top'  >"+oName[u]+"</td>");
							out.println("</tr>");
							checked="";
						}
					}else{	//if the job is transferred
						//out.println("YES");
						for(int u=0; u<oType.length; u++){
							String selected="";
							if(oType[u].equals(order_status)){checked="checked";}
							out.println("<tr>");
							out.println("<td align='left' valign='top' ><input type='radio' name='order_status' "+checked+" value='"+oType[u]+"'></td>");
							out.println("<td align='left' valign='top' >"+oName[u]+"</td>");
							out.println("</tr>");
							checked="";
						}
					}
				}
			out.println("<tr><td align='center' valign='top' colspan='2'>&nbsp; </td></tr>");
			if(quote_origin != null && quote_origin.trim().equals("release") && product_id.equals("ADS")){
				out.println("<tr class='important'>");
				out.println("<td align='right'><font face='arial'   SIZE='2'><b>");
				out.println("Requested Ship Date:</b></td>");
				out.println("<td align='right' nowrap>");
				if ((ship_date==null)|(ship_date.equals(""))){
					ship_date="";
				}
				out.println("<input type='text' name='ship_date' class='text1' readonly value='"+ ship_date +"'  MAXLENGTH=15>");
				%>
			<a href="javascript:show_calendar('selectform.ship_date');" onmouseover="window.status='Date Picker';
					return true;" onmouseout="window.status='';
							return true;">
				<%
				out.println("<img src='../../../images/show-calendar.gif' id='imgCalendar3' name='imgCalendar3' width=24 height=22 border=0></a>");
			}
			else{
				out.println("<input type='hidden' name='ship_date' value='na'>");
			}
			try{
				%>
				<%@ include file="../../../db_con_bpcs.jsp"%>
				<%



				ResultSet rsBPCS=stmt_bpcs.executeQuery("Select count(*) from zcc where CCTABL = 'CUSTGRP' and CCSDSC='GE'");
				if(rsBPCS !=null){
					while(rsBPCS.next()){
					}
				}
				rsBPCS.close();

				out.println("</td>");
				out.println("<tr><td align='center' valign='top' colspan='2'>&nbsp;</td></tr>");
				out.println("<tr><td align='center' valign='top' colspan='2' ><input type='button' name='enter' value='Continue' onclick='check()' class='button'></td></tr>");
				out.println("<tr><td align='center' valign='top' colspan='2'> &nbsp; </td></tr>");
				out.println("<input type='hidden' name='order_no' value='"+order_no+"'>");
				out.println("<input type='hidden' name='cmd' value='"+cmd+"'>");
				out.println("<input type='hidden' name='id' value='"+rep_no+"'>");
				out.println("<input type='hidden' name='order_status_value' value='"+order_status+"'>");
				out.println("<input type='hidden' name='project_type' value='"+project_type+"'>");
				out.println("<input type='hidden' name='quote_type' value='"+quote_type+"'>");
				out.println("<input type='hidden' name='tax_zip' value='"+tax_zip+"'>");
				out.println("<input type='hidden' name='product_id' value='"+product_id+"'>");
				out.println("<input type='hidden' name='sfdc_QuoteId' value='"+sfdc_QuoteId+"'>");
			out.println("</form>");




				con_bpcs.close();
				stmt_bpcs.close();
			}
			catch(SQLException ee){
				out.println("<tr><td align='center' valign='top' colspan='2'><font color='red' size='3'>Attn: We have encountered an error connecting to BPCS.  Transfer is currently down.  Please contact CS Group It.</font></td></tr><tr><td align='center' valign='top' colspan='2'><input type='button' value='Go Back' OnClick='history.go( -1 );return true;'></td></tr>");
			}
			catch(Exception eeee){
				out.println("<tr><td align='center' valign='top' colspan='2'><font color='red' size='3'>Attn: We have encountered an error connecting to BPCS.  Transfer is currently down.  Please contact CS Group It.</font></td></tr><tr><td align='center' valign='top' colspan='2'><input type='button' value='Go Back' OnClick='history.go( -1 );return true;'></td></tr>"+eeee);
			}



				stmt.close();
				myConn.close();


}
  catch(Exception e){
  out.println(e);
  }
				%>
				</tr>
		</table>
		<br><br><br><br><br><br><br><br><br><br><br><br>
		<%//@ include file="../../../rqs_footer.jsp"%>
	</body>
</html>