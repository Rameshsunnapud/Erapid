<!--<body onload="hoursChange(<%=hrrate%>, <%=enghrrate%>, <%=pmhrrate%>)">-->
<%
String q_no=order_no;
String message="<font color='blue'>Pricing For Job No "+q_no+"<font>";
//HttpSession UserSession1 = request.getSession();
//String name=UserSession1.getAttribute("username").toString();
%>
<%//@ include file="rqs_head.jsp"%>
<link rel='stylesheet' href='../../css/<%=userSession.getStyleSheet()%>' type='text/css' />
<body onload="checkCanada(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)">
	<form name='displayForm' action='lvr_main_save.jsp'>
		<input type='hidden' name='cost' value='no'>
		<input type='hidden' name='isNotSec' value='<%= isNotSec%>'>
		<input type='hidden' name='section' value='<%= section%>'>
		<input type='hidden' name='q_no' value='<%= order_no%>'>
		<input type='hidden' name='interco' value='<%= interco%>'>
		<input type='hidden' name='countRows' value='<%= countRows%>'>
		<input type='hidden' name='group' value='<%= group%>'>
		<input type='hidden' name='city' value='<%= city %>'>
		<input type='hidden' name='state' value='<%= state %>'>
		<input type='hidden' name='urlReset' value='<%= urlReset %>'>
		<input type='hidden' name='crated_weight' value='<%= VR_ADJWEIGHT%>'>
		<input type='hidden' name='dh_rate' value='<%= hrrate %>'>
		<input type='hidden' name='eh_rate' value='<%= enghrrate%>'>
		<input type='hidden' name='pm_rate' value='<%= pmhrrate %>'>
		<input type='hidden' name='VR_WEIGHT' value='<%= VR_WEIGHT%>'>
		<input type='hidden' name='order_no' value='<%= order_no %>'>
		<input type='hidden' name='csdeco' value='<%= CSDECO %>'>
		<input type='hidden' name='ordertype' value='<%= ordertype %>'>
		<input type='hidden' name='qtype' value='<%= qtype %>'>
		<input type='hidden' name='add' value='<%= add %>'>
		<input type='hidden' name='sect' value='<%= sect %>'>
		<input type='hidden' name='date' value='<%= date %>'>
		<input type='hidden' name='VR_SQFT' value='<%= VR_SQFT %>'>
		<input type='hidden' name='VR_TOTQTY' value='<%= VR_TOTQTY %>'>
		<input type='hidden' name='VR_WEIGHT' value='<%= VR_WEIGHT %>'>
		<input type='hidden' name='VI_HAS_OPTIONS' value='<%= VI_HAS_OPTIONS %>'>
		<input type='hidden' name='VI_TEST_TYPE' value='<%= VI_TEST_TYPE %>'>
		<input type='hidden' name='VI_MAX_SUBLINE' value='<%= VI_MAX_SUBLINE %>'>
		<input type='hidden' name='desc_grp' value='<%= desc_grp%>'>
		<input type='hidden' name='desc' value='<%= desc%>'>
		<input type='hidden' name='VS_ID' value='<%= VS_ID%>'>
		<input type='hidden' name='setup_qty' value='<%= setup_qty%>'>
		<input type='hidden' name='rows' value='<%= rows%>'>
		<input type='hidden' name='catchallinit' value='<%=pInfCATCHALL%>'>
		<%
		for(int b=0; b<7; b++){
		%>
		<input type='hidden' name='sched_max' value='<%=sched_max[b]%>'>
		<%
}
		%>
		<div align="center">
			<input type='hidden'  name='pInfCOST' value='<%= for1.format(pInfCOST) %>'  readonly  onfocus="this.select()">
			<input type='hidden'  name='pInfCOSTPERC' value='<%= for1.format(pInfCOSTPERC)%>'  readonly onfocus="this.select()" >
			<input type='hidden'  name='pInfDHOURS' value='<%= for1.format(pInfDHOURS)%>'  onchange="hoursChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)"  onfocus="this.select()">
			<input type='hidden'  name='pInfD' value='<%= for1.format(pInfD)%>'  readonly onfocus="this.select()" >
			<input type='hidden'  name='pInfLHOURS' value='<%= for1.format(pInfLHOURS)%>'  onchange="hoursChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)"  onfocus="this.select()">
			<input type='hidden'  name='pInfL' value='<%= for1.format(pInfL) %>'  readonly onfocus="this.select()" >
			<input type='hidden'  name='pInfEHOURS' value='<%= for1.format(pInfEHOURS)%>'  onchange="hoursChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)"  onfocus="this.select()">
			<input type='hidden'  name='pInfE' value='<%= for1.format(pInfE)%>'  readonly onfocus="this.select()" >
			<input type='hidden'  name='pInfPMHOURS' value='<%= for1.format(pInfPMHOURS) %>'  onchange="hoursChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)"  onfocus="this.select()">
			<input type='hidden'  name='pInfP' value='<%= for1.format(pInfP)%>'  readonly onfocus="this.select()" >
			<input type='hidden'  name='pInfTOTHOURS' value='<%= for1.format(pInfTOTHOURS)%>'  readonly onfocus="this.select()">
			<input type='hidden' name= 'pInfALLHOURS' value='<%= pInfALLHOURS%>'  readonly onfocus="this.select()" >
			<input type='hidden'  name='pInfADMINDOLLARS' value='<%= for1.format(pInfADMINDOLLARS)%>'   readonly onfocus="this.select()">
			<input type='hidden'  name='pInfADMINPERC' value='<%= for1.format(pInfADMINPERC)%>'   readonly onfocus="this.select()" >
			<input type='hidden' name='pInfCRATE' value='0'>
			<input type='hidden' name='pInfFREIGHT' value='0'>
			<%
			if(group.equals("CanEstim")){
			%>
			<input type='hidden'  name='pInfFC' value='<%= for1.format(pInfFC)%>'   onchange="hoursChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)" onfocus="this.select()">
			<%
		}
		else{
			%>
			<input type='hidden'  name='pInfFC' value='<%= for1.format(pInfFC)%>'   onchange="hoursChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)" onfocus="this.select()">
			<%
		}
			%>
			<input type='hidden'  name='pInfFCPERC' value='<%= for1.format(pInfFCPERC)%>'   readonly onfocus="this.select()" >
			<input type='hidden'  name='pInfCATCHALL' value='<%= for1.format(pInfCATCHALL)%>'  onchange="hoursChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)"  onfocus="this.select()">
			<input type='hidden'  name='pInfCATCHALLPERC' value='<%= for1.format(pInfCATCHALLPERC)%>'   readonly  onfocus="this.select()" >
			<input type='hidden'  name='pInfCATCHALLWT' value='<%= for1.format(pInfCATCHALLWT) %>'  onfocus="this.select()" onblur="catchAllCheck()"></td>
			<input type='hidden'  name='pInfCATCHALL_DESC' value='<%= pInfCATCHALL_DESC%>'  onfocus="this.select()" onblur="catchAllCheck()">
			<input type='hidden'  name='pInfSUBTOTAL' value='<%= for1.format(pInfSUBTOTAL)%>'   readonly onfocus="this.select()">
			<input type='hidden'  name='pInfSUBTOTPERC' value='<%= for1.format(pInfSUBTOTPERC) %>'   readonly onfocus="this.select()" >
			<input type='hidden'  name='pInfCOMMDOLLARS' value='<%= for1.format(pInfCOMMDOLLARS)%>'  onchange="dollarChange()"  onfocus="this.select()">
			<input type='hidden'  name='pInfCOMMPERC' value='<%= for1.format(pInfCOMMPERC)%>'  onchange="commChange()"  onfocus="this.select()" >
			<input type='hidden'  name='pInfMARGDOLLARS' value='<%= for1.format(pInfMARGDOLLARS)%>'  onchange="dollarChange()"  onfocus="this.select()">
			<input type='hidden'  name='pInfMARGPERC' value='<%= for1.format(pInfMARGPERC)%>'  onchange="margChange()"  onfocus="this.select()" >
			<input type='hidden'  name='pInfSELLPRICE' value='<%= for1.format(pInfSELLPRICE)%>'  onchange="sellChange()"  onfocus="this.select()">
			<input type='hidden'  name='pInfSELLPERC' value='<%= for1.format(pInfSELLPERC)%>'   readonly onfocus="this.select()" >
			<input type='hidden'  name='pInfINSTALL' value='<%= for1.format(pInfINSTALL)%>'  onchange="installChange()"  onfocus="this.select()">
			<input type='hidden'  name='pInfCOMMFCPERC' value='<%= for1.format(pInfCOMMFCPERC)%>'   readonly onfocus="this.select()" >
			<input type='hidden'  name='pInfTOTAL' value='<%= for1.format(pInfTOTAL)%>'   readonly onfocus="this.select()">
			<input type='hidden'  name='pIndMATLESSFIN' value='<%= for1.format(pIndMATLESSFIN)%>'  readonly onfocus="this.select()">
			<input type='hidden'  name='pIndTOTPAINTSF' value='<%= for1.format(pIndTOTPAINTSF) %>'  readonly onfocus="this.select()" >
			<input type='hidden'  name='pIndTOTWT' value='<%= for1.format(VR_ADJWEIGHT) %>'  readonly onfocus="this.select()">
			<input type='hidden'  name='pIndYIELD' value='<%= for1.format(pIndYIELD) %>'  readonly onfocus="this.select()" >
			<input type='hidden'  name='pIndTOTSF' value='<%= for1.format(pIndTOTSF) %>'  readonly onfocus="this.select()">
			<input type='hidden'  name='pIndDOLLARSF' value='<%= for1.format(pIndDOLLARSF) %>'  readonly onfocus="this.select()" >
			<input type='hidden'  name='pIndTOTPERIM' value='<%= for1.format(pIndTOTPERIM)%>'  readonly onfocus="this.select()">
			<input type='hidden'  name='pIndUNITPRICE' value='<%= for1.format(pIndUNITPRICE)%>'  readonly onfocus="this.select()">
			<input type='hidden' name=section value='<%= section %>'>
			<input type='hidden' name=isNotSec value='<%= isNotSec%>'>
			<!--<input type='submit' value='Save and Return' class='button' >
			<input type='button' value='Reset' class='button' onclick='resetForm()'>-->
			<%
		out.println("<table width='100%' border='0'> ");
		out.println("<tr class='header1'>");
		out.println("<td colspan='4' align='center'><h3>Price Calculator</h3> </td>");
		out.println("</tr>");

			out.println("<tr >");
			out.println("<td align='left' width='50%'>");
if(group.equals("Rep-DLvr")){

		out.println("Configured Price: ");
}
else{
			out.println("Configured Price ( @ "+for1.format(pInfCOMMPERC)+" % Commission ): ");
}
			out.println("</td>");

			out.println("<td align='left'  width='50%'>");
			out.println("<input type='text' name='t_cost' value='"+for1.format(pInfSELLPRICE)+"' readonly>");
			out.println("</td>");

			out.println("</tr>");
			
			if((pInfCOMMPERC==0|(pInfCOMMPERC==15))|| (group.toUpperCase().startsWith("REP") && project_type!= null && project_type.equals("PSA")&&pInfCOMMPERC==10)){
				out.println("<tr >");
				out.println("<td align='left'>");
				out.println("Overage:");
				out.println("</td>");
				out.println("<td align='left'>");
				out.println("<input type='text' name='overage' id='overage' value='"+o_cost+"' >");
				out.println("</td>");
				out.println("</tr>");
			}
			else{
				out.println("<input type='hidden' name='overage' value='0'>");
			}
			if(tax_perc==null || tax_perc.equals("null")){
				tax_perc="";
			}
			out.println("<input type='hidden' name='project_type' value='"+project_type+"'>");
			out.println("<input type='hidden' name='creator_id' value='"+creator_id+"'>");
			out.println("<tr >");
			out.println("<td align='left'>");out.println("Custom Color Charge/Misc.:<BR>"+colorMSG);out.println("</td>");
			out.println("<td align='left'>");out.println("<font face='arial' color='blue' size='3'><input type='text' name='freight_cost'  value='"+freight_cost+"' onchange='catchallChange("+hrrate+", "+enghrrate+", "+pmhrrate+")'>");out.println("</td>");
			out.println("</tr>");
if(group.equals("Rep-DLvr")){
	out.println("<input type='hidden' name='commission' value='"+for1.format(pInfCOMMPERC)+"'>");
}
else{
			out.println("<tr >");
			out.println("<td align='left'>Commission(%):</td>");
			out.println("<td align='left'>");
			out.println(""+for1.format(pInfCOMMPERC)+"</b></font>");
			out.println("<input type='hidden' name='commission' value='"+for1.format(pInfCOMMPERC)+"'>");
			out.println("</td>");
			out.println("</tr>");
}


			out.println("<br>");
			out.println("<tr >");
			out.println("<td align='left'>");
			out.println("Tax(%):(Optional)");
			out.println("</td>");
			out.println("<td align='left'>");
			out.println("<input type='text' name='tax_perc'  value='"+tax_perc+"'>");
			out.println("</td>");
			out.println("</tr>");


			out.println("<tr >");
			out.println("<td colspan='2' align='center'>");
			out.println("<input type='submit' value='Get the Total' class='button' onmouseover=this.className='button4' onmouseout=this.className='button3' >");
			out.println("</td>");
			out.println("</tr>");


			out.println("</table>");

			%>
			</form>
			</body>
			</html>