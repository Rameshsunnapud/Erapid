

<tr>
	<td>
		<table width='100%' border='0' cellpadding='0' cellspacing='0' class='test'>
			<tr>
				<td rowspan='6' colspan='1' class='boxlb' align='center' valign='center' width='2%'><img src='../../images/verify.jpg' alt='' width='14' height='73'></td>
				<td align='center' width='5%' class='boxl'>QTY</td>
				<td align='center' width='5%' class='boxl'>MARK</td>
				<td align='center'  width='9%' class='boxl'>LOCATION</td>
				<td align='center' width='9%' class='boxl'>MODEL</td>
				<td align='center' width='8%' class='boxl'>DIM 'A'<BR> WIDTH</td>
				<td align='center' width='8%' class='boxl'>DIM 'B'<BR> LENGTH</td>
				<td align='center' width='19%' class='boxl'>FINISH</td>
				<td align='center' width='13%' class='boxl'>NOTES</td>
				<td align='center' valign='top' rowspan='6' colspan='1' class='boxrb'>
					<table class='test' cellpadding='0' cellspacing='0' border='1'>
						<tr><td valign='top' width='8%' colspan='3' class='boxltr'>PROJECT: <%= pname %></td></tr>
						<tr><td valign='top' colspan='3' width='8%' class='boxltr'>LOCATION:<%= ploc %> <%= pstate %></td></tr>
						<tr><td valign='top' colspan='3' width='8%' class='boxltr'>CONTRACTOR: <%= cust_name1 %></td></tr>
						<tr>
							<td valign='top' colspan='2' width='4%' class='boxlt'>AGENT: <%= pagent %></td>
							<td valign='top' colspan='1' width='4%' class='boxltr'>TEAR SHEET:<%= m+1 %></td>
						</tr>
						<tr>
							<td colspan='3'>
								<table class='test' cellpadding='0' cellspacing='0'>
									<tr>
										<td width='2%' colspan='1' class='boxltb'>DWG. BY:<BR>&nbsp;</td>
										<td width='2%' colspan='1' class='boxltb'>DATE:<BR><%= sDate %></td>
										<td width='2%' colspan='1' >JOB NO:<BR><%= order_no %></td>
									</tr>
									<tr>
										<td width='2%' colspan='1' class='boxltb'>&nbsp;</td>
										<td width='2%' colspan='1' class='boxltb'>&nbsp;</td>
										<td width='2%' colspan='1' >&nbsp;</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
