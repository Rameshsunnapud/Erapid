

<tr><td>
		<table width='100%' cellpadding='0' cellspacing='0' style='border-left: 1px solid;border-right: 1px solid;border-top: 1px solid; '>
			<tr>
				<td rowspan='6' colspan='1' style='border-right: 1px solid;border-bottom: 1px solid;' align='center' valign='center' width='2%'><img src='../../images/verify.jpg' alt='' width='14' height='73'></td>
					<%if(rep_tear_sheet.equals("2") || rep_quote.equals("1")){%>
				<td align='center' width='5%' style='border-right: 1px solid;border-bottom: 1px solid;'>QTY</td>
				<%} %>
				<td align='center' width='5%' style='border-right: 1px solid;border-bottom: 1px solid;'>UM</td>
				<td align='center' width='5%' style='border-right: 1px solid;border-bottom: 1px solid;' >MARK</td>
				<td align='center'  width='9%' style='border-right: 1px solid;border-bottom: 1px solid;' colspan='2'>LOCATION</td>
				<td align='center' width='9%' style='border-right: 1px solid;border-bottom: 1px solid;' colspan='2'>MODEL</td>


				<td align='center' width='25%' style='border-right: 1px solid;border-bottom: 1px solid;'>NOTES</td>
				<td align='center' valign='top' rowspan='6' colspan='1' class='boxrb'>
					<table class='sty_table' cellpadding='0' cellspacing='0' border='0'><tr><td valign='top' width='26%' colspan='3' class='boxltr'>PROJECT: <%= pname %></td></tr>
						<tr><td valign='top' colspan='3' width='13%' >LOCATION:<%= ploc %> <%= pstate %></td></tr>
						<tr><td valign='top' colspan='3' width='8%' style='border-top: 1px solid;'>CONTRACTOR: <%= cust_name1 %></td></tr>
						<tr><td valign='top' colspan='2' width='4%' style='border-top: 1px solid;border-right: 1px solid;'>AGENT: <%= pagent %></td>
							<td valign='top' colspan='1' width='4%' style='border-top: 1px solid;'>TEAR SHEET:<%= m+1 %> </td> </tr>
						<tr><td colspan='3'>
								<table class='sty_table' border='0' cellpadding='0' cellspacing='0'><tr>
										<td width='2%' colspan='1' style='border-right: 1px solid;border-top: 1px solid;border-bottom: 1px solid;'>DWG. BY:<BR>&nbsp;</td>
										<td width='2%' colspan='1' style='border-right: 1px solid;border-top: 1px solid;border-bottom: 1px solid;'>DATE:<BR><%= sDate %></td>
										<td width='2%' colspan='1' style='border-top: 1px solid;border-bottom: 1px solid;'>JOB NO:<BR><%= order_no %></td>
									</tr>
									<!--<tr>
										<td width='2%' colspan='1' class='boxltb'>&nbsp;</td>
										<td width='2%' colspan='1' class='boxltb'>&nbsp;</td>
										<td width='2%' colspan='1' >&nbsp;</td>
									</tr>-->
								</table>
							</td></tr>

					</table>
				</td>
			</tr>
