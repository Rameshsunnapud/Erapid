<html>
<head>
	<title>EFS Shop Report</title>
	<link rel='stylesheet' href='craft.css' type='text/css' />
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td align='center'>CONSTRUCTION SPECIALTIES, INC.<br>6696 ROUTE 405 HWY.<br>MUNCY, PA 17756</td>
</tr>
<tr>
	<td align='center'>&nbsp;</td>
</tr>

<tr>
	<td align="left" valign="top" >
		<table width='20%' border='0' cellspacing="0" cellpadding="0">
			<tr><td nowrap><h1><%= titl %></h1></td></tr>
		</table>
	</td>
</tr>
<tr>
	<td align="center" valign="top">&nbsp;</td>
</tr>

<tr>
<td align='center'>		
			<table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
						<tr>
							<td width='15%' align='right'><b>Job no#&nbsp;&nbsp;</b></td>
							<td width='55%' align='left'><%= bpcs_no %></td>
							<td width='15%' align='right'><b>Date:&nbsp;&nbsp;</b></td>
							<td width='15%' align='left'><%= sDate %></td>
						</tr>
						<tr>
							<td align='right'><b>Job Name:&nbsp;&nbsp;</b></td>
							<td align='left'><%= project_name %></td>							
							<td align='right'><b>Date Due:&nbsp;&nbsp;</b></td>
							<td align='left'><%= due_date %></td>							
						</tr>
						<tr>
							<td align='right'><b>Planner:</b>&nbsp;&nbsp;</td>
							<td align='left'><%= planner %></td>							
							<td align='right'><b>CSE Order no:&nbsp;&nbsp;</b></td>
							<td align='left'><%= order_no %></td>							
						</tr>
						
			</table>
</td>
</tr>
<tr>
	<td>&nbsp;<hr></td>
</tr>

