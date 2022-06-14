<!--<body onload="hoursChange(<%=hrrate%>, <%=enghrrate%>, <%=pmhrrate%>)">-->
<%
String q_no=order_no;
String message="<font color='blue'>Pricing For Job No "+q_no+"<font>";
//HttpSession UserSession1 = request.getSession();
String name=userSession.getUserId();
%>
<%//@ include file="rqs_head.jsp"%>
<link rel='stylesheet' href='style1accesscentral.css' type='text/css' />
<%
if(runCalcEngg){
%>
	<body onload="checkCanada(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>);calcEng()">
	<%
}else{
	%>
	<body onload="checkCanada(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)">
	<%
}
%>

	<%

		if(costCompare||isSf){
	%>
	<form name='displayForm' action='access_central_out.jsp' method='post'>
		<input type='hidden' name='sectionLines' value='<%= sectionLines%>'>

		<input type='hidden' name='q_no' value='<%= order_no%>'>
		<%
		}
			else{
		%>
		<form name='displayForm' action='access_central.jsp' method='post'>
			<input type='hidden' name='cost' value='no'>
			<input type='hidden' name='isNotSec' value='<%= isNotSec%>'>
			<input type='hidden' name='sectionLines' value='<%= sectionLines%>'>
			<input type='hidden' name='section' value='<%= section%>'>
			<input type='hidden' name='q_no' value='<%= order_no%>'>


			<%
			}
			%>
			<input type='hidden' name='manualFreight' value='<%=manualFreight%>'>
			<input type='hidden' name='interco' value='<%= interco%>'>
			<input type='hidden' name='exportx' value='<%= export%>'>
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
			<input type='hidden' name='exchName' value='<%= exchName%>'>
			<input type='hidden' name='exchRate' value='<%= exchRate%>'>
			<input type='hidden' name='exchRateDate' value='<%= exchRateDate%>'>
			<%
			for(int b=0; b<7; b++){
			%>
			<input type='hidden' name='sched_max' value='<%=sched_max[b]%>'>
			<%
	}
	//out.println("lines: "+VI_MAX_SUBLINE+"::"+product_c.length+"::"+subl_c.length+"::"+model_c.length+"::"+finish_c.length+"::"+screen_c.length+"::"+weight_c.length+"::"+qty_c.length+"::"+cost_c.length+"::"+schedule.length+"::"+opts_c.length+"::"+sched_qty.length+"::"+sched_mark.length+"::"+sched_size.length+"<BR>");
	//out.println("<table border='1'><tr><td>count1</td><td>finish_c</td><td>screen_c</td><td>weight_c</td><td>qty_c</td><td>cost_c</td><td>opts_c</td><Td>sched_qty</td></tr>");

	out.println("</table>");
			%>
			<div align="center">
				<table width='100%'>
					<%
					if(!costCompare ){
					%>
					<%
if(resetAndRunCalcEngg){
%>
	<tr><Td colspan='5' align=center><input type='button' value='COST MISMATCH - CLICK HERE TO RESET' class='buttonRed' onclick='resetForm();calcEng()'></td></tr>
	<%
}else{
	%>
	<tr><Td colspan='5' align=center><input type='button' value='COST MISMATCH - CLICK HERE TO RESET' class='buttonRed' onclick='resetForm()'></td></tr>
	<%
}
%>
							<%
					}
							%>
                                        <tr><td width='22.5%' align=left>Total Cost($)<BR>
                                                <input type='button' name='w2' value='2YR WTY' onclick='TWOyrWty()' class='button'>
						<input type='button' name='w3' value='3YR WTY' onclick='THREEyrWty()' class='button'>
                                                <input type='button' name='w4' value='4YR WTY' onclick='FOURyrWty()' class='button'>
                                                <input type='button' name='w5' value='5YR WTY' onclick='FIVEyrWty()' class='button'>                                            
                                            </TD><td width='22.5%' align=right>
							<%
							if(isSf){
							%>
							<input type='text'  name='pInfCOST' value='<%= for1.format(pInfCOST) %>' style="text-align:right"   onchange="hoursChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)" class='text1' onfocus="this.select()" >
							<%
						}
						else{
							%>
							<input type='text'  name='pInfCOST' value='<%= for1.format(pInfCOST) %>' style="text-align:right"   readonly class='notext1' onfocus="this.select()" >
							<%
						}
							%>
                                               
						</td>
						<td width="10%"></td>
						<td width='22.5%' align=left>Total Cost(%)</TD><td width='22.5%' align=right><input type='text'  name='pInfCOSTPERC' value='<%= for1.format(pInfCOSTPERC)%>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td></tr>

					<tr><td width='22.5%' align=left>Drafting(hrs)
						</TD><td width='22.5%' align=right><input type='text'  name='pInfDHOURS' value='<%= for1.format(pInfDHOURS)%>' style="text-align:right" onchange="hoursChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)" class='text1' onfocus="this.select()" ></td>
						<td width="10%"></td>
						<td width='22.5%' align=left>Drafting($)</TD><td width='22.5%' align=right><input type='text'  name='pInfD' value='<%= for1.format(pInfD)%>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td></tr>

					<tr><td width='22.5%' align=left>Layout(hrs)</TD><td width='22.5%' align=right><input type='text'  name='pInfLHOURS' value='<%= for1.format(pInfLHOURS)%>' style="text-align:right" onchange="hoursChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)" class='text1' onfocus="this.select()" ></td>
						<td width="10%"></td>
						<td width='22.5%' align=left>Layout($)</TD><td width='22.5%' align=right><input type='text'  name='pInfL' value='<%= for1.format(pInfL) %>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td></tr>

					<tr><td width='22.5%' align=left>Engineering(hrs)<BR>
							<input type='button' name='a2' value='Calc' onclick='calcEng()' class='button'>
							<input type='button' name='a3' value='OSHPD' onclick='calcEngOSHPD()' class='button'>
							<input type='button' name='a4' value='Blast' onclick='calcEngBlast()' class='button'>
                                                        <%
                                                            if(VS_ID.equals("GRILLE")||VS_ID.equals("SUN")){%>
                                                        <BR>
                                                        <input type='button' name='sunInhouse' value='SUN IN' onclick='calcEngSunInHouse()' class='button'>
							<input type='button' name='sunOutside' value='SUN OUT' onclick='calcEngSunOutside()' class='button'>
							<input type='button' name='sunOshpd' value='SUN OSHPD' onclick='calcEngSunOshpd()' class='button'>
					<%}%>	
                                            </TD><td width='22.5%' align=right><input type='text'  name='pInfEHOURS' value='<%= for1.format(pInfEHOURS)%>' style="text-align:right" onchange="hoursChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)" class='text1' onfocus="this.select()" ></td>
						<td width="10%"></td>
						<td width='22.5%' align=left>Engineering($)</TD><td width='22.5%' align=right><input type='text'  name='pInfE' value='<%= for1.format(pInfE)%>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td></tr>

					<tr><td width='22.5%' align=left>Project Mgmt.(hrs)<input type='button' name='a4' value='Calc' onclick='calcProject()' class='button'></TD><td width='22.5%' align=right><input type='text'  name='pInfPMHOURS' value='<%= for1.format(pInfPMHOURS) %>' style="text-align:right" onchange="hoursChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)" class='text1' onfocus="this.select()" ></td>
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
								//out.println(pInfFREIGHT+"::HERE");
							%>
					<tr>

						<td width='22.5%' align=left>Export Crating($)<input type='button' name='a2' value='Calc' onclick='calcExportGrille()' class='button'></TD><td width='22.5%' align=right><input type='text'  name='exportCrate' value='<%= for1.format(exportCrate)%>' style="text-align:right" class='text1' onchange="freightChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)";></tr>

				
					<tr><td width='22.5%' align=left>Freight($)</TD><td width='22.5%' align=right><input type='text'  name='pInfFREIGHT' value='<%= for1.format(pInfFREIGHT)%>' style="text-align:right" class='text1' onchange="freightChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>);
							markOverride()"></td>
						<td width="10%"></td>
						<td width='22.5%' align=left>Crate($)</TD><td width='22.5%' align=right><input type='text'  name='pInfCRATE' value='<%= for1.format(pInfCRATE)%>' style="text-align:right" class='text1' onchange="freightChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)";></td></tr>
							<%
								if(group.equals("CanEstim")){
							%>
					<tr><td width='22.5%' align=left>F&C to Del Rio ($)</TD><td width='22.5%' align=right><input type='text'  name='pInfFC' value='<%= for1.format(pInfFC)%>' style="text-align:right" class='notext1' onchange="hoursChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)" onfocus="this.select()" readonly></td>
							<%
							}
							else{
							%>
					<tr><td width='22.5%' align=left>Freight & Crate($)</TD><td width='22.5%' align=right><input type='text'  name='pInfFC' value='<%= for1.format(pInfFC)%>' style="text-align:right" class='notext1' onchange="hoursChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)" onfocus="this.select()" readonly></td>
							<%
							}
						}
						else{
							if(group.equals("CanEstim")){
							%>
					<input type='hidden' name='pInfCRATE' value='0' >
					<input type='hidden' name='pInfFREIGHT' value='0'>
					<tr><td width='22.5%' align=left>F&C to Del Rio ($)</TD><td width='22.5%' align=right><input type='text'  name='pInfFC' value='<%= for1.format(pInfFC)%>' style="text-align:right" class='text1' onchange="hoursChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)" onfocus="this.select()" ></td>
							<%
						}
						else{
							%>
					<tr><td width='22.5%' align=left>Freight($)</TD><td width='22.5%' align=right><input type='text'  name='pInfFREIGHT' value='<%= for1.format(pInfFREIGHT)%>' style="text-align:right" class='text1' onchange="freightChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>);
							markOverride()";></td>
						<td width="10%"></td>
						<td>&nbsp;</td>
					<tr><td width='22.5%' align=left>Standard Crating($)</TD><td width='22.5%' align=right><input type='text'  name='pInfCRATE' value='<%= for1.format(pInfCRATE)%>' style="text-align:right" class='text1' onchange="freightChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)";></td>
						<td width="10%"></td>
						<td>&nbsp;</td>
					<tr>

						<td width='22.5%' align=left>Export Crating($)<input type='button' name='a2' value='Calc' onclick='calcExport()' class='button'></TD><td width='22.5%' align=right><input type='text'  name='exportCrate' value='<%= for1.format(exportCrate)%>' style="text-align:right" class='text1' onchange="freightChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)";></tr>

					<td width="10%"></td>
					<td>&nbsp;</td>
					<tr><td width='22.5%' align=left>Freight & Crate($)</TD><td width='22.5%' align=right><input type='text'  name='pInfFC' value='<%= for1.format(pInfFC)%>' style="text-align:right" class='notext1' readonly onchange="hoursChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)" onfocus="this.select()" ></td>
							<%
							}

						}
							%>
						<td width="10%"></td>
						<td width='22.5%' align=left>Freight & Crate(%)</TD><td width='22.5%' align=right><input type='text'  name='pInfFCPERC' value='<%= for1.format(pInfFCPERC)%>' style="text-align:right"  readonly class='notext1'onfocus="this.select()" ></td></tr>

					<tr><td colspan='5'>
							<table width='100%' border='0'>
								<tr>
									<td width='10%'><input type='button' name='Fasteners' value='Include Fasteners' class='button' onclick='addFasteners()'></td>
									<td width='10%'>Dollars</td>
									<td width='8%'>Weight</td>
									<td width='72%'>Description</td>
								</tr>
								<tr>
									<td align='left'>Catchall1</td>
									<td><input type='text'  name='pInfCATCHALL1' value='<%=pInfCATCHALL1 %>' style="text-align:right" class='text1' onfocus="this.select()" onchange="catchallprice(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)" ></td>
									<td><input type='text'  name='pInfCATCHALLWT1' value='<%=pInfCATCHALLWT1 %>' style="text-align:right" class='text1' onfocus="this.select()" onchange="catchallwt()"></td>
									<td><input type='text'  name='pInfCATCHALL_DESC1' value='<%=pInfCATCHALL_DESC1 %>' style="text-align:left" class='text1' onfocus="this.select()"></td>
								</tr>
								<tr>
									<td align='left'>Catchall2</td>
									<td><input type='text'  name='pInfCATCHALL2' value='<%=pInfCATCHALL2 %>' style="text-align:right" class='text1' onfocus="this.select()" onchange="catchallprice(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)"></td>
									<td><input type='text'  name='pInfCATCHALLWT2' value='<%=pInfCATCHALLWT2 %>' style="text-align:right" class='text1' onfocus="this.select()" onchange="catchallwt()"></td>
									<td><input type='text'  name='pInfCATCHALL_DESC2' value='<%=pInfCATCHALL_DESC2 %>' style="text-align:left" class='text1' onfocus="this.select()"></td>
								</tr>
								<tr>
									<td align='left'>Catchall3</td>
									<td><input type='text'  name='pInfCATCHALL3' value='<%=pInfCATCHALL3 %>' style="text-align:right" class='text1' onfocus="this.select()" onchange="catchallprice(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)"></td>
									<td><input type='text'  name='pInfCATCHALLWT3' value='<%=pInfCATCHALLWT3 %>' style="text-align:right" class='text1' onfocus="this.select()" onchange="catchallwt()"></td>
									<td><input type='text'  name='pInfCATCHALL_DESC3' value='<%=pInfCATCHALL_DESC3 %>' style="text-align:left" class='text1' onfocus="this.select()"></td>
								</tr>
								<tr>
									<td align='left'>Catchall4</td>
									<td><input type='text'  name='pInfCATCHALL4' value='<%=pInfCATCHALL4 %>' style="text-align:right" class='text1' onfocus="this.select()" onchange="catchallprice(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)"></td>
									<td><input type='text'  name='pInfCATCHALLWT4' value='<%=pInfCATCHALLWT4 %>' style="text-align:right" class='text1' onfocus="this.select()" onchange="catchallwt()"></td>
									<td><input type='text'  name='pInfCATCHALL_DESC4' value='<%=pInfCATCHALL_DESC4 %>' style="text-align:left" class='text1' onfocus="this.select()"></td>
								</tr>
								<tr>
									<td align='left'>Catchall5</td>
									<td><input type='text'  name='pInfCATCHALL5' value='<%=pInfCATCHALL5 %>' style="text-align:right" class='text1' onfocus="this.select()" onchange="catchallprice(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)"></td>
									<td><input type='text'  name='pInfCATCHALLWT5' value='<%=pInfCATCHALLWT5 %>' style="text-align:right" class='text1' onfocus="this.select()" onchange="catchallwt()"></td>
									<td><input type='text'  name='pInfCATCHALL_DESC5' value='<%=pInfCATCHALL_DESC5 %>' style="text-align:left" class='text1' onfocus="this.select()"></td>
								</tr>
							</table>
						</td></tr>
					<tr><td width='22.5%' align=left>Proj. Catchall($)</TD><td width='22.5%' align=right><input type='text'  name='pInfCATCHALL' value='<%= for1.format(pInfCATCHALL)%>' style="text-align:right" readonly onchange="hoursChange(<%=hrrate%>,<%=enghrrate%>,<%=pmhrrate%>)" readonly class='notext1' onfocus="this.select()" ></td>
						<td width="10%"></td>
					<input type='hidden'  name='pInfCATCHALLPERC' value='<%= for1.format(pInfCATCHALLPERC)%>'  >

					<td width='22.5%' align=left>Catchall weight(lbs)</TD><td width='22.5%' align=right><input type='text'  name='pInfCATCHALLWT' value='<%= for1.format(pInfCATCHALLWT) %>' style="text-align:right" readonly class='notext1'onfocus="this.select()" onblur="catchAllCheck()"></td>
					<input type='hidden'  name='pInfCATCHALL_DESC' value='<%= pInfCATCHALL_DESC%>' ></tr>



					<tr><td width='22.5%' align=left>Subtotal($)</TD><td width='22.5%' align=right><input type='text'  name='pInfSUBTOTAL' value='<%= for1.format(pInfSUBTOTAL)%>' style="text-align:right"  readonly class='notext1' onfocus="this.select()" ></td>
						<td width="10%"></td>
						<td width='22.5%' align=left>Subtotal(%)</TD><td width='22.5%' align=right><input type='text'  name='pInfSUBTOTPERC' value='<%= for1.format(pInfSUBTOTPERC) %>' style="text-align:right"  readonly class='notext1' onfocus="this.select()" ></td></tr>





					<tr><td width='22.5%' align=left>Special Commission($)</TD><td width='22.5%' align=right><input type='text'  name='pInfKACOMMDOLLARS' value='<%= for1.format(pInfKACOMMDOLLARS)%>' style="text-align:right" onchange="commDollarUpdate('KA')" class='notext1' onfocus="this.select()" ></td>
						<td width="10%"></td>
						<td width='22.5%' align=left>Special Commission(%)</TD><td width='22.5%' align=right><input type='text'  name='pInfKACOMMPERC' value='<%= for1.format(pInfKACOMMPERC)%>' style="text-align:right" onchange="commUpdate('KA')" class='text1' onfocus="this.select()" ></td></tr>

					<tr><td width='22.5%' align=left>Commission($)</TD><td width='22.5%' align=right><input type='text'  name='pInfSTDCOMMDOLLARS' value='<%= for1.format(pInfSTDCOMMDOLLARS)%>' style="text-align:right" onchange="commDollarUpdate('STD')" class='notext1' onfocus="this.select()" ></td>
						<td width="10%"></td>
						<td width='22.5%' align=left>Commission(%)</TD><td width='22.5%' align=right><input type='text'  name='pInfSTDCOMMPERC' value='<%= for1.format(pInfSTDCOMMPERC)%>' style="text-align:right" onchange="commUpdate('STD')" class='text1' onfocus="this.select()" ></td></tr>

					<tr><td width='22.5%' align=left>Total Commission($)</TD><td width='22.5%' align=right><input type='text'  name='pInfCOMMDOLLARS' readonly value='<%= for1.format(pInfCOMMDOLLARS)%>' style="text-align:right" onchange="dollarChange()" class='notext1' onfocus="this.select()" ></td>
						<td width="10%"></td>
						<td width='22.5%' align=left>Total Commission(%)</TD><td width='22.5%' align=right><input type='text'  name='pInfCOMMPERC' readonly value='<%= for1.format(pInfCOMMPERC)%>' style="text-align:right" onchange="commChange()" class='notext1' onfocus="this.select()" ></td></tr>








					<tr><td width='22.5%' align=left>Gross Margin($)</TD><td width='22.5%' align=right><input type='text'  name='pInfMARGDOLLARS' value='<%= for1.format(pInfMARGDOLLARS)%>' style="text-align:right" onchange="dollarChange()" class='notext1' onfocus="this.select()" ></td>
						<td width="10%"></td>
						<td width='22.5%' align=left>Gross Margin(%)</TD><td width='22.5%' align=right><input type='text'  name='pInfMARGPERC' value='<%= for1.format(pInfMARGPERC)%>' style="text-align:right" onchange="margChange()" class='text1' onfocus="this.select()" ></td></tr>

					<tr><td width='22.5%' align=left>Sell Price($)<BR>
							<%
							if(exchName!=null&&exchName.equals("CAD")){
								out.println(exchRate+"::"+exchRateDate.substring(0,10) +"<input type='button' class='button' name='cdnRoundUp' value='Round' onclick='roundCanada()'>");
							}
							%>

						</TD><td width='22.5%' align=right><input type='text'  name='pInfSELLPRICE' value='<%= for1.format(pInfSELLPRICE)%>' style="text-align:right" onchange="sellChange()" class='text1' onfocus="this.select()" ><BR>
							<%
							if(exchName!=null&&exchName.equals("CAD")){
							%>
							<input type='text'  name='pInfSELLPRICECAN' value='<%= for1.format(pInfSELLPRICECAN)%>' style="text-align:right" class='textCAN' readonly ></a>
							<%
						}
						else{
							out.println("<input type='hidden' name='pInfSELLPRICECAN'>");
						}%>
						</td>
						<td width="10%"></td>
						<td width='22.5%' align=left valign='top' >Sell Price(%)</TD><td width='22.5%' align=right valign='top' ><input type='text'  name='pInfSELLPERC' value='<%= for1.format(pInfSELLPERC)%>' style="text-align:right"  readonly class='notext1'onfocus="this.select()" ></td></tr>

					<tr><td width='22.5%' align=left>Installation($)</TD><td width='22.5%' align=right><input type='text'  name='pInfINSTALL' value='<%= for1.format(pInfINSTALL)%>' style="text-align:right" onchange="installChange()" class='notext1' onfocus="this.select()" ></td>
						<td width="10%"></td>
						<td width='22.5%' align=left>Comm. with FC(%)</TD><td width='22.5%' align=right><input type='text'  name='pInfCOMMFCPERC' value='<%= for1.format(pInfCOMMFCPERC)%>' style="text-align:right"  readonly class='notext1'onfocus="this.select()" ></td></tr>

					<tr><td width='22.5%' align=left>Sell + Install($)</TD><td width='22.5%' align=right><input type='text'  name='pInfTOTAL' value='<%= for1.format(pInfTOTAL)%>' style="text-align:right"  readonly class='notext1'onfocus="this.select()" ></td>
						<td width="10%"></td>

						<td></td><td></td>

					</tr>


					<tr><td colspan='5'><hr></td></tr>
				</table>
				<table width='80%'>
					<tr><td width='22.5%' align=left>Mat. Cost less Fin.($)</TD><td width='22.5%' align=right><input type='text' name='pIndMATLESSFIN' value='<%= for1.format(pIndMATLESSFIN)%>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td>
						<td width="10%"></td>
						<td width='22.5%' align=left>Total paintable sq.ft.</TD><td width='22.5%' align=right><input type='text'  name='pIndTOTPAINTSF' value='<%= for1.format(pIndTOTPAINTSF) %>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td></tr>
						<!--<tr><td width='22.5%' align=left>Total weight(lbs)</TD><td width='22.5%' align=right><input type='text'  name='pIndTOTWT' value='<%= for1.format(pIndTOTWT) %>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td>
						changed as per eric som to include catchall weight
						dec 20 2010
						Greg
					-->

					<tr><td width='22.5%' align=left>Total weight(lbs)</TD><td width='22.5%' align=right>
							<input type='hidden'  name='pIndTOTWTbeforeCatchall' value='<%= for1.format(VR_ADJWEIGHT) %>' >
							<%
							double doubleTempCatchallWT=0;
									if(VR_ADJWEIGHT<250){
										doubleTempCatchallWT = pInfCATCHALLWT * 1.56;
									}
									else if(VR_ADJWEIGHT<500){
										doubleTempCatchallWT = pInfCATCHALLWT * 1.36;
									}
									else if(VR_ADJWEIGHT<2000){
										doubleTempCatchallWT = pInfCATCHALLWT * 1.29;
									}
									else if(VR_ADJWEIGHT<5000){
										doubleTempCatchallWT = pInfCATCHALLWT * 1.25;
									}
									else if(VR_ADJWEIGHT<10000){
										doubleTempCatchallWT = pInfCATCHALLWT * 1.22;
									}
									else{
										doubleTempCatchallWT = pInfCATCHALLWT * 1.20;
		}
                //out.println(doubleTempCatchallWT+"::"+VR_WEIGHT);
							double tempWeight=doubleTempCatchallWT+VR_ADJWEIGHT;
							%>
							<input type='text'  name='pIndTOTWT' value='<%= for1.format(tempWeight) %>' style="text-align:right" readonly class='notext1' onfocus="this.select()" onchange='weightChange()' ></td>


						<td width="10%"></td>
						<td width='22.5%' align=left>Yield($/lb)</TD><td width='22.5%' align=right><input type='text'  name='pIndYIELD' value='<%= for1.format(pIndYIELD) %>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td></tr>
					<tr><td width='22.5%' align=left>Total job sq. ft.</TD><td width='22.5%' align=right><input type='text'  name='pIndTOTSF' value='<%= for1.format(pIndTOTSF) %>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td>
						<td width="10%"></td>
						<td width='22.5%' align=left>Sell price($/sq. ft.)</TD><td width='22.5%' align=right><input type='text'  name='pIndDOLLARSF' value='<%= for1.format(pIndDOLLARSF) %>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td></tr>
					<tr><td width='22.5%' align=left>Total perimeter(ft)</TD><td width='22.5%' align=right><input type='text'  name='pIndTOTPERIM' value='<%= for1.format(pIndTOTPERIM)%>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td>
						<td width="10%"></td>
						<td width='22.5%' align=left>Price per unit.</TD><td width='22.5%' align=right><input type='text'  name='pIndUNITPRICE' value='<%= for1.format(pIndUNITPRICE)%>' style="text-align:right" readonly class='notext1'onfocus="this.select()" ></td>

					</tr>
					<!--<TR><td COLSPAN='5'><hr onfocus="this.select()" ></td></TR>-->
					<%
					if(costCompare||isSf){
						if(isSf){
							out.println("<tr><Td colspan='5' align=center><FONT COLOR='red' size='4'>WARNING: THIS QUOTE CONTAINS GENERIC PRODUCTS.  PLEASE VERIFY ALL COSTS.</font></td></tr>");
						}
					%>
					<input type='hidden' name=section value='<%= section %>'>
					<!--<input type='hidden' name=sectionLines value='<%= sectionLines %>'>-->
					<input type='hidden' name=isNotSec value='<%= isNotSec%>'>
					<tr><Td colspan='5' align=center><input type='button' class='button' value='Save and Return' onclick='submitThis()' >
							
							<%
if(resetAndRunCalcEngg){
%>
	<input type='button' value='Reset' class='button' onclick='resetForm();calcEng()'></td>
	<%
}else{
	%>
	<input type='button' value='Reset' class='button' onclick='resetForm()'></td>
	<%
}
%>
					</tr>
					<%
					}
					else{
					%>
					
					<%
if(resetAndRunCalcEngg){
%>
	<tr><Td colspan='5' align=center><input type='button' value='COST MISMATCH - CLICK HERE TO RESET' class='buttonRed' onclick='resetForm();calcEng()'></td></tr>
	<%
}else{
	%>
	<tr><Td colspan='5' align=center><input type='button' value='COST MISMATCH - CLICK HERE TO RESET' class='buttonRed' onclick='resetForm()'></td></tr>
	<%
}
%>
					
							<%
							}
							%>
				</table>
		</form>
</body>
</html>