<html>
	<head>
		<title>Quote No <%= order_no %></title>
		<style type="text/css">
			.maintitle { color:#333333; font-size:12pt; font-family:arial, helvetica; }
			.subtitle10 { color:#333333; font-size:10pt; font-family:arial, helvetica; }
			.mainfooter { color:#666666; font-size:8pt; font-family:tahoma, arial, helvetica; }

			.mainbody { color:#333333; font-size:10pt; font-family:arial, verdana, helvetica; text-decoration:none; }
			.mainbodyh { color:#333333; font-size:8.5pt;font-family:verdana, arial, helvetica; text-decoration:none; }
			.maindesc { color:#333333; font-size:8pt; font-family:arial, verdana, helvetica; text-decoration:none; }

			.schedule { color:#ffffff; font-size:9pt; font-family:arial, verdana, helvetica; text-decoration:none; }
			.schedule1 { color:#333333; font-size:9pt; font-family:arial, verdana, helvetica; text-decoration:none; }

			.totprice { color:#000000; font-size:12pt; font-family:arial, helvetica; text-decoration:none; }
			.tableline { border-right: #B4DC61 1px solid; border-top: #B4DC61 1px solid; border-left: #B4DC61 1px solid; border-bottom: #B4DC61 1px solid; }
			.tableline_row { padding-right: 5px; padding-left: 5px; padding-bottom: 3px; padding-top: 3px; }
		</style>
	</head>

	<body bgcolor="white" topmargin="25" leftmargin="25" bgcolor="white" marginheight="0" marginwidth="0">
		<table cellspacing='0' cellpadding='0' border='0' width='100%'>
			<tr><td align='left'><img src='http://csimages.c-sgroup.com/eRapid/cs_logo.jpg' alt='CS Logo'></td></tr>
					<%
					if(priority.equals("E")){
					%>

			<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC.</b><br><br>
					<%
					}
					else{
					%>
			<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC.</b><br><br>
					<%
					}
					%><%
					if(st.equals("1")){out.println("<font class='subtitle10'><b>E-RAPID PRICING SUMMARY SHEET</b></font>");
					}
					else{
					out.println("<font class='subtitle10'><b>E-RAPID FACTORY SUMMARY SHEET</b></font>");
					}
					%>

				</td></tr>
		</table>







		<table cellspacing='0' cellpadding='0' border='0' width='100%'>
			<tr>

				<td class='mainbody' width='15%'><b>Customer :</b></td>
				<td class='mainbodyh' width='30%'>
					<%
					if(cust_name1 != null && cust_name1.trim().length()>0){out.println(cust_name1+"<br>");}
					if(cust_addr1 != null && cust_addr1.trim().length()>0){out.println(cust_addr1+"<br>");}
					if(cust_addr2 != null && cust_addr2.trim().length()>0){out.println(cust_addr2+"<br>");}
					%>
					<%= city %>,&nbsp;<%= state %>&nbsp;<%= zip_code %>&nbsp;</td>
				<td width='10%' valign='top' class='mainbody'>&nbsp;</td>
				<td width='15%' valign='top' align='right' class='mainbody'><b>Quote No:</b></td>
				<td width='30%' valign='top' class='mainbody'><%= order_no %></td>
			</tr>
			<tr>
				<td nowrap valign='top' class='mainbodyh'><b>Project:</b>&nbsp;</td>
				<td nowrap valign='top' class='mainbody'><%= Project_name %><br></td>
				<td valign='top' class='mainbody'>&nbsp;</td>
				<td valign='top' align='right' nowrap class='mainbody'><b>Quote Date:</b></td>
				<td valign='top' nowrap class='mainbody'><%= odate %></td>
			</tr>
			<tr>
				<td valign='top'class='mainbodyh'>&nbsp;</td>
				<td valign='top' class='mainbody'>&nbsp;</td>
				<td valign='top' class='mainbody'>&nbsp;</td>
				<td valign='top' align='right' nowrap class='mainbody'><b>Bid Date:</b></td>
				<td valign='top' nowrap class='mainbody'><%= edate %></td>
			</tr>

			<tr>
				<td valign='top'class='mainbodyh'><b>Architect:</b>&nbsp;</td>
				<td  valign='top' class='mainbody'><%= Arch_name %></td>
				<td >&nbsp;</td>
				<td rowspan='2' colspan='2' valign='top'>
					<%
					if(rep_account==null){rep_account="";}
					if(address1==null){address1="";}
					if(address2==null){address2="";}
					if(rep_city==null){rep_city="";}
					if(rep_state==null){rep_state="";}
					if(rep_zip_code==null){rep_zip_code="";}
					if(rep_telephone==null){rep_telephone="";}
					if(rep_fax==null){rep_fax="";}
					if(rep_email==null){rep_email="";}
					if(Arch_name==null){Arch_name="";}
					if(Arch_loc==null){Arch_loc="";}
					if(rep_account.trim().length()>0){
						out.println(rep_account+"<BR>");
					}
					if(address1.trim().length()>0){
						out.println(address1);
					}
					if(address2.trim().length()>0){
						out.println(address2);
					}
					if(address1.trim().length()>0||address2.trim().length()>0){
						out.println("<BR>");
					}
					if(rep_city.trim().length()>0){
						out.println(rep_city +",&nbsp");
					}
					if(rep_state.trim().length()>0){
						out.println(rep_state +",&nbsp");
					}
					if(rep_zip_code.trim().length()>0){
						out.println(rep_zip_code);
					}
					if(rep_zip_code.trim().length()>0 || rep_state.trim().length()>0||rep_city.trim().length()>0){
						out.println("<BR>");
					}
					%>

					Phone #: <%= rep_telephone %><br>
					Fax No: <%= rep_fax %><br>
					eMail: <%= rep_email %>
				</td>
			</tr>
			<tr>

				<td valign='top' class='mainbodyh'><b>Location:</b>&nbsp;</td>
				<td  valign='top' class='mainbody'><%= Arch_loc %></td>
				<td >&nbsp;</td>
			</tr>
			<%
			if(quote_type_alt==null){
				quote_type_alt="";
			}
			String final_type="";

			if(quote_typex.equals("E") && quote_type_alt.equals("dl")){
				final_type="Decolink";
			}
			else if(quote_typex.equals("E")){
				final_type="Deco";
			}
			else if(quote_typex.toUpperCase().equals("C")){
				final_type="CS";
			}
			if(final_type.trim().length()>0){
			%>
			<tr><td valign='top' class='mainbodyh'><b><%=final_type%></b>&nbsp;</td>
				<td colspan='4'></td>
			</tr>
			<%
		}
			%>
		</table>
		<%
		String dnotes="";
		ResultSet rsdnotes=stmt.executeQuery("select line_no,descript from csquotes where order_no='"+order_no+"' and blocK_id='d_notes' order by cast(line_no as numeric)");
		if(rsdnotes != null){
			while(rsdnotes.next()){
				dnotes=dnotes+"<tr><td colspan='1' class='mainbodyh' >"+rsdnotes.getString(1)+"</td><td  colspan='3' class='mainbodyh' >"+rsdnotes.getString(2)+"</td></tr>";
			}
		}
		rsdnotes.close();
		if(dnotes.trim().length()>0){
			out.println("<table align ='center' cellspacing='0' cellpadding='0' border='0' width='94%'>");
			out.println("<tr><td nowrap valign='top' Colspan='4' class='mainbodyh'>&nbsp;</td></tr>");
			out.println("<tr><td  valign='top' Colspan='4' class='mainbodyh' ><b>Line Notes:</b></TD></TR><tr><td valign='top' Colspan='1' class='mainbodyh' width='10%'>eRapid Line #</td><td valign='top' width='90%' colspan='3' class='mainbodyh'>Notes</td></tr>");
			out.println(dnotes);
			out.println("</table>");
		}










		%>
		<br>
