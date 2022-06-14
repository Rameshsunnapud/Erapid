<!--<body onload="hoursChange(<%=hrrate%>, <%=enghrrate%>, <%=pmhrrate%>)">-->

<link rel='stylesheet' href='style1accesscentral.css' type='text/css' />
<body onload="checkCanada(<%=hrrate%>, <%=enghrrate%>, <%=pmhrrate%>)">
<%

	if(costCompare){
	%>
<form name='displayForm' action='access_central_out_ads.jsp'>
<%
}
	else{
%> 
<form name='displayForm' action='access_central_ads.jsp'>
<input type='hidden' name='cost' value='no'>
<input type='hidden' name='isNotSec' value='<%= isNotSec%>'>
<!--<input type='hidden' name='sectionLines' value='<%= sectionLines%>'>-->
<input type='hidden' name='section' value='<%= section%>'>
<input type='hidden' name='q_no' value='<%= order_no%>'>


<%
}  
%> 
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

<%
for(int b=0; b<7; b++){
%>
		<input type='hidden' name='sched_max' value='<%=sched_max[b]%>'>
		<%
}

out.println("</table>");
%>
   <div align="center">
<table width='80%'>
<tr><td width='22.5%' align=left>Total Cost($)</TD><td width='22.5%' align=right><input type='text'  name='pInfCOST' value='<%= for1.format(pInfCOST) %>' style="text-align:right" readonly class='notext1' onfocus="this.select()" ></td>
<td width="10%"></td>
<td width='22.5%' align=left>Total Cost(%)</TD><td width='22.5%' align=right><input type='text'  name='pInfCOSTPERC' value='<%= for1.format(pInfCOSTPERC)%>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td></tr>

<tr><td width='22.5%' align=left>Drafting(hrs)</TD><td width='22.5%' align=right><input type='text'  name='pInfDHOURS' value='<%= for1.format(pInfDHOURS)%>' style="text-align:right" onchange="hoursChange(<%=hrrate%>, <%=enghrrate%>, <%=pmhrrate%>)" class='text1' onfocus="this.select()" ></td>
<td width="10%"></td>
<td width='22.5%' align=left>Drafting($)</TD><td width='22.5%' align=right><input type='text'  name='pInfD' value='<%= for1.format(pInfD)%>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td></tr>

<tr><td width='22.5%' align=left>Layout(hrs)</TD><td width='22.5%' align=right><input type='text'  name='pInfLHOURS' value='<%= for1.format(pInfLHOURS)%>' style="text-align:right" onchange="hoursChange(<%=hrrate%>, <%=enghrrate%>, <%=pmhrrate%>)" class='text1' onfocus="this.select()" ></td>
<td width="10%"></td>
<td width='22.5%' align=left>Layout($)</TD><td width='22.5%' align=right><input type='text'  name='pInfL' value='<%= for1.format(pInfL) %>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td></tr>

<tr><td width='22.5%' align=left>Enginnering(hrs)</TD><td width='22.5%' align=right><input type='text'  name='pInfEHOURS' value='<%= for1.format(pInfEHOURS)%>' style="text-align:right" onchange="hoursChange(<%=hrrate%>, <%=enghrrate%>, <%=pmhrrate%>)" class='text1' onfocus="this.select()" ></td>
<td width="10%"></td>
<td width='22.5%' align=left>Enginnering($)</TD><td width='22.5%' align=right><input type='text'  name='pInfE' value='<%= for1.format(pInfE)%>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td></tr>

<tr><td width='22.5%' align=left>Project Mgmt.(hrs)</TD><td width='22.5%' align=right><input type='text'  name='pInfPMHOURS' value='<%= for1.format(pInfPMHOURS) %>' style="text-align:right" onchange="hoursChange(<%=hrrate%>, <%=enghrrate%>, <%=pmhrrate%>)" class='text1' onfocus="this.select()" ></td>
<td width="10%"></td>
<td width='22.5%' align=left>Project Mgmt.($)</TD><td width='22.5%' align=right><input type='text'  name='pInfP' value='<%= for1.format(pInfP)%>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td></tr>

<tr><td width='22.5%' align=left>Total admin(hrs)</TD><td width='22.5%' align=right><input type='text'  name='pInfTOTHOURS' value='<%= for1.format(pInfTOTHOURS)%>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td>
<td width="10%"></td>
<td width='22.5%' align=left>Hours(D,L,E,PM)</TD><td width='22.5%' align=right><input type='text' name= 'pInfALLHOURS' value='<%= pInfALLHOURS%>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td></tr>

<tr><td width='22.5%' align=left>Admin($)</TD><td width='22.5%' align=right><input type='text'  name='pInfADMINDOLLARS' value='<%= for1.format(pInfADMINDOLLARS)%>' style="text-align:right"  readonly class='notext1'onfocus="this.select()" ></td>
<td width="10%"></td>
<td width='22.5%' align=left>Admin(%)</TD><td width='22.5%' align=right><input type='text'  name='pInfADMINPERC' value='<%= for1.format(pInfADMINPERC)%>' style="text-align:right"  readonly class='notext1'onfocus="this.select()" ></td></tr>
<%
if(VS_ID.equals("GRILLE")){
//out.println(pInfFC + "HERE");
%>
<tr><td width='22.5%' align=left>Freight($)</TD><td width='22.5%' align=right><input type='text'  name='pInfFREIGHT' value='<%= for1.format(pInfFREIGHT)%>' style="text-align:right" class='text1' onchange="freightChange(<%=hrrate%>, <%=enghrrate%>, <%=pmhrrate%>)";></td>
<td width="10%"></td>
<td width='22.5%' align=left>Crate($)</TD><td width='22.5%' align=right><input type='text'  name='pInfCRATE' value='<%= for1.format(pInfCRATE)%>' style="text-align:right" class='text1' onchange="freightChange(<%=hrrate%>, <%=enghrrate%>, <%=pmhrrate%>)";></td></tr>
<%
	if(group.equals("CanEstim")){
	%>
		<tr><td width='22.5%' align=left>F&C to Del Rio ($)</TD><td width='22.5%' align=right><input type='text'  name='pInfFC' value='<%= for1.format(pInfFC)%>' style="text-align:right" class='notext1' onchange="hoursChange(<%=hrrate%>, <%=enghrrate%>, <%=pmhrrate%>)" onfocus="this.select()" readonly></td>
	<%
	}
	else{
	%>
		<tr><td width='22.5%' align=left>Freight & Crate($)</TD><td width='22.5%' align=right><input type='text'  name='pInfFC' value='<%= for1.format(pInfFC)%>' style="text-align:right" class='notext1' onchange="hoursChange(<%=hrrate%>, <%=enghrrate%>, <%=pmhrrate%>)" onfocus="this.select()" readonly></td>
	<%
	}
}
else{
%>
<input type='hidden' name='pInfCRATE' value='0'>
<input type='hidden' name='pInfFREIGHT' value='0'>

<%
	if(group.equals("CanEstim")){
		%>
		<tr><td width='22.5%' align=left>F&C to Del Rio ($)</TD><td width='22.5%' align=right><input type='text'  name='pInfFC' value='<%= for1.format(pInfFC)%>' style="text-align:right" class='text1' onchange="hoursChange(<%=hrrate%>, <%=enghrrate%>, <%=pmhrrate%>)" onfocus="this.select()" ></td>
		<%
	}
	else{
	%>
		<tr><td width='22.5%' align=left>Freight & Crate($)</TD><td width='22.5%' align=right><input type='text'  name='pInfFC' value='<%= for1.format(pInfFC)%>' style="text-align:right" class='text1' onchange="hoursChange(<%=hrrate%>, <%=enghrrate%>, <%=pmhrrate%>)" onfocus="this.select()" ></td>
	<%
	}

}
%>
<td width="10%"></td>
<td width='22.5%' align=left>Freight & Crate(%)</TD><td width='22.5%' align=right><input type='text'  name='pInfFCPERC' value='<%= for1.format(pInfFCPERC)%>' style="text-align:right"  readonly class='notext1'onfocus="this.select()" ></td></tr>

<tr><td width='22.5%' align=left>Proj. Catchall($)</TD><td width='22.5%' align=right><input type='text'  name='pInfCATCHALL' value='<%= for1.format(pInfCATCHALL)%>' style="text-align:right" onchange="hoursChange(<%=hrrate%>, <%=enghrrate%>, <%=pmhrrate%>)" class='text1' onfocus="this.select()" ></td>
<td width="10%"></td>
<td width='22.5%' align=left>Proj. Catchall(%)</TD><td width='22.5%' align=right><input type='text'  name='pInfCATCHALLPERC' value='<%= for1.format(pInfCATCHALLPERC)%>' style="text-align:right"  readonly class='notext1' onfocus="this.select()" ></td></tr>

<tr><td width='22.5%' align=left>Catchall weight(lbs)</TD><td width='22.5%' align=right><input type='text'  name='pInfCATCHALLWT' value='<%= for1.format(pInfCATCHALLWT) %>' style="text-align:right" class='text1'onfocus="this.select()" onblur="catchAllCheck()"></td>
<td width="10%"></td>
<td width='22.5%' align=left>Catchall descr.</TD><td width='22.5%' align=right><input type='text'  name='pInfCATCHALL_DESC' value='<%= pInfCATCHALL_DESC%>' style="text-align:right" class='text1'onfocus="this.select()" onblur="catchAllCheck()"></td></tr>

<tr><td width='22.5%' align=left>Subtotal($)</TD><td width='22.5%' align=right><input type='text'  name='pInfSUBTOTAL' value='<%= for1.format(pInfSUBTOTAL)%>' style="text-align:right"  readonly class='notext1'onfocus="this.select()" ></td>
<td width="10%"></td> 
<td width='22.5%' align=left>Subtotal(%)</TD><td width='22.5%' align=right><input type='text'  name='pInfSUBTOTPERC' value='<%= for1.format(pInfSUBTOTPERC) %>' style="text-align:right"  readonly class='notext1'onfocus="this.select()" ></td></tr>

<tr><td width='22.5%' align=left>Commission($)</TD><td width='22.5%' align=right><input type='text'  name='pInfCOMMDOLLARS' value='<%= for1.format(pInfCOMMDOLLARS)%>' style="text-align:right" onchange="dollarChange()" class='text1' onfocus="this.select()" ></td>
<td width="10%"></td>
<td width='22.5%' align=left>Commission(%)</TD><td width='22.5%' align=right><input type='text'  name='pInfCOMMPERC' value='<%= for1.format(pInfCOMMPERC)%>' style="text-align:right" onchange="commChange()" class='text1' onfocus="this.select()" ></td></tr>

<tr><td width='22.5%' align=left>Gross Margin($)</TD><td width='22.5%' align=right><input type='text'  name='pInfMARGDOLLARS' value='<%= for1.format(pInfMARGDOLLARS)%>' style="text-align:right" onchange="dollarChange()" class='text1' onfocus="this.select()" ></td>
<td width="10%"></td>
<td width='22.5%' align=left>Gross Margin(%)</TD><td width='22.5%' align=right><input type='text'  name='pInfMARGPERC' value='<%= for1.format(pInfMARGPERC)%>' style="text-align:right" onchange="margChange()" class='text1' onfocus="this.select()" ></td></tr>

<tr><td width='22.5%' align=left>Sell Price($)</TD><td width='22.5%' align=right><input type='text'  name='pInfSELLPRICE' value='<%= for1.format(pInfSELLPRICE)%>' style="text-align:right" onchange="sellChange()" class='text1' onfocus="this.select()" ></td>
<td width="10%"></td>
<td width='22.5%' align=left>Sell Price(%)</TD><td width='22.5%' align=right><input type='text'  name='pInfSELLPERC' value='<%= for1.format(pInfSELLPERC)%>' style="text-align:right"  readonly class='notext1'onfocus="this.select()" ></td></tr>

<tr><td width='22.5%' align=left>Installation($)</TD><td width='22.5%' align=right><input type='text'  name='pInfINSTALL' value='<%= for1.format(pInfINSTALL)%>' style="text-align:right" onchange="installChange()" class='text1' onfocus="this.select()" ></td>
<td width="10%"></td>
<td width='22.5%' align=left>Comm. with FC(%)</TD><td width='22.5%' align=right><input type='text'  name='pInfCOMMFCPERC' value='<%= for1.format(pInfCOMMFCPERC)%>' style="text-align:right"  readonly class='notext1'onfocus="this.select()" ></td></tr>

<tr><td width='22.5%' align=left>Sell + Install($)</TD><td width='22.5%' align=right><input type='text'  name='pInfTOTAL' value='<%= for1.format(pInfTOTAL)%>' style="text-align:right"  readonly class='notext1'onfocus="this.select()" ></td>
<td width="10%"></td>

<td></td><td></td>

</tr>


<tr><td width='22.5%' colspan='5'><hr></td></tr>
</table>
<table width='80%'>
<tr><td width='22.5%' align=left>Mat. Cost less Fin.($)</TD><td width='22.5%' align=right><input type='text' name='pIndMATLESSFIN' value='<%= for1.format(pIndMATLESSFIN)%>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td>
<td width="10%"></td>
<td width='22.5%' align=left>Total paintable sq.ft.</TD><td width='22.5%' align=right><input type='text'  name='pIndTOTPAINTSF' value='<%= for1.format(pIndTOTPAINTSF) %>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td></tr>
<tr><td width='22.5%' align=left>Total weight(lbs)</TD><td width='22.5%' align=right><input type='text'  name='pIndTOTWT' value='<%= for1.format(pIndTOTWT) %>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td>
<td width="10%"></td>
<td width='22.5%' align=left>Yield($/lb)</TD><td width='22.5%' align=right><input type='text'  name='pIndYIELD' value='<%= for1.format(pIndYIELD) %>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td></tr>
<tr><td width='22.5%' align=left>Total job sq. ft.</TD><td width='22.5%' align=right><input type='text'  name='pIndTOTSF' value='<%= for1.format(pIndTOTSF) %>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td>
<td width="10%"></td>
<td width='22.5%' align=left>Sell price($/sq. ft.)</TD><td width='22.5%' align=right><input type='text'  name='pIndDOLLARSF' value='<%= for1.format(pIndDOLLARSF) %>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td></tr>
<tr><td width='22.5%' align=left>Total perimeter(ft)</TD><td width='22.5%' align=right><input type='text'  name='pIndTOTPERIM' value='<%= for1.format(pIndTOTPERIM)%>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td>
<td width="10%"></td>
<td width='22.5%' align=left>Price per unit.</TD><td width='22.5%' align=right><input type='text'  name='pIndUNITPRICE' value='<%= for1.format(pIndUNITPRICE)%>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td>

</tr>
<TR><td COLSPAN='5'><hr onfocus="this.select()" ></td></TR>
<%
if(costCompare){
	%>
	<input type='hidden' name=section value='<%= section %>'>
	<!--<input type='hidden' name=sectionLines value='<%= sectionLines %>'>-->
	<input type='hidden' name=isNotSec value='<%= isNotSec%>'>
<tr><Td colspan='5' align=center><input type='submit' value='Save and Return' class='button' >
<input type='button' value='Reset' class='button' onclick='resetForm()'></td>
</tr>
<%
}
else{
%>
<tr><Td colspan='5' align=center><input type='submit' value='COST MISMATCH - CLICK HERE TO RESET' class='button' ></td></tr>
<%
}
%>
</table>
</form>
</body>
</html>