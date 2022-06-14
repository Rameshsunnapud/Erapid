<html>

	<style type="text/css">
		<!--
		.sty_fnt_title_b { color:#004080; font-size:11pt; font-family:trebuchet ms, verdana, arial, helvetica; text-decoration:none; font-weight:bold; }
		.sty_fnt_title_bu { color:#004080; font-size:11pt; font-family:trebuchet ms, verdana, arial, helvetica; text-decoration:underline; font-weight:bold; }

		.sty_fnt_logo { color:#666666; font-size:6pt; font-family:verdana, arial, helvetica; text-decoration:none; }

		.sty_fnt_head_b { color:#004080; font-size:8pt; font-family:verdana, arial, helvetica; text-decoration:none; font-weight:bold; }
		.sty_fnt_head_bu { color:#004080; font-size:8pt; font-family:verdana, arial, helvetica; text-decoration:underline; font-weight:bold; }

		.sty_fnt_def { color:#333333; font-size:8pt;	font-family:verdana, arial, helvetica; text-decoration:none; }
		.sty_fnt_def_b { color:#333333; font-size:8pt; font-family:verdana, arial, helvetica; text-decoration:none; font-weight:bold; }
		.sty_fnt_def_bu { color:#333333; font-size:8pt; font-family:verdana, arial, helvetica; text-decoration:underline; font-weight:bold; }

		.sty_fnt_black { color:#000000; font-size:8pt; font-family:verdana, arial, helvetica; text-decoration:none; }
		.sty_fnt_black_b { color:#000000; font-size:8pt; font-family:verdana, arial, helvetica; text-decoration:none; font-weight:bold; }
		.sty_fnt_black_bu { color:#000000; font-size:8pt; font-family:verdana, arial, helvetica; text-decoration:underline; font-weight:bold; }

		.sty_fnt_white { color:#ffffff; font-size:8pt; font-family:verdana, arial, helvetica; text-decoration:none; }
		.sty_fnt_white_b { color:#ffffff; font-size:8pt; font-family:verdana, arial, helvetica; text-decoration:none; font-weight:bold; }
		.sty_fnt_white_bu { color:#ffffff; font-size:8pt; font-family:verdana, arial, helvetica; text-decoration:underline; font-weight:bold; }

		.sty_fnt_red_bu { color:red; font-size:8pt; font-family:verdana, arial, helvetica; text-decoration:underline; font-weight:bold; }

		.sty_div_free_text { position:relative; top:0; left:0; visibility:visible; }

		a:hover { color:red; }
		-->
	</style>

	<body>
		<!-- header -->
		<%
		if(ispdf== null || !ispdf.equals("true")){
		%>

		<table cellspacing='0' cellpadding='0' border='0' width='100%'>
			<tr>
				<%
				out.println("<td align='left'><img src='http://csimages.c-sgroup.com/eRapid/cs_logo.jpg' alt='CS Logo'></td>");
				%>
			</tr></table>
			<%
			}
			%>
		<!-- end header -->
		<table border='0' cellpadding='0' cellspacing='0' width='100%'>
			<tr>
				<td width='50%' align='left'><font class='sty_fnt_def'>Quote No: </font><font class='sty_fnt_def_b'><%= order_no %></font></td>
				<td width='50%' align='right'><font class='sty_fnt_def'>Date: <%= edate %></font></td>
			</tr>
		</table>
		<table border='0' cellpadding="3" cellspacing="0" width="100%">

			<tr>
				<td width='100%'><font class='sty_fnt_def'><tr><td width='100%' height='25'><img src='images/space.gif' width='1' height='1' alt></td></tr></font></td>
	</tr>
	<tr>
		<td width='100%'><font class='sty_fnt_def'><%= cust_name1 %><br><%= cust_addr1 %><br><%= cust_addr2 %><br><%= city %>,&nbsp;<%=customerCountry%><BR><%= state %>&nbsp;<BR><%= zip_code %>&nbsp;<br></font></td>
	</tr>
	<tr>
		<td width='100%'><font class='sty_fnt_def'><img src='images/space.gif' width='1' height='1' alt></font></td>
	</tr>
	<tr>
		<td width='100%'><font class='sty_fnt_def'><b><u>For the attention of: <%= cust_contact_name %></u></b></font></td>
	</tr>
	<tr>
		<td width='100%'><font class='sty_fnt_def'><tr><td width='100%' height='25'><img src='images/space.gif' width='1' height='1' alt></td></tr></font></td>
</tr>
<tr>
	<td width='100%'><font class='sty_fnt_def'>Dear:  <%= cust_contact_name %></font></td>
</tr>
<tr>
	<td width='100%'><font class='sty_fnt_def'><b><u>Re:<%= Project_name %></u></b></font></td>
</tr>
</table>
<BR><BR>