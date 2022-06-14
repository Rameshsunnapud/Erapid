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
				<td width='45%' valign='top' rowspan='3' nowrap class='mainbody'>
					<table border='0' cellspacing='0' cellpadding='0'>
						<tr><td class='mainbodyh'><b>Customer:</b></td><td>&nbsp;</td></tr>
						<tr><td>&nbsp;</td>
							<td class='mainbody'>
								<%
								if(cust_name1 != null && cust_name1.trim().length()>0){out.println(cust_name1+"<br>");}
								if(cust_addr1 != null && cust_addr1.trim().length()>0){out.println(cust_addr1+"<br>");}
								if(cust_addr2 != null && cust_addr2.trim().length()>0){out.println(cust_addr2+"<br>");}
								%>
								<%= city %>&nbsp;<%= state %>&nbsp;<%= zip_code %>&nbsp;</td>
						</tr>
					</table>
				</td>
				<td width='100%' valign='top' rowspan='3' class='mainbody'>&nbsp;</td>
				<td width='10%' valign='top' align='right' class='mainbody'><b>Quote No:</b></td>
				<td width='10%' valign='top' class='mainbody'><%= order_no %></td>
			</tr>
			<tr>
				<td width='200' valign='top' align='right' nowrap class='mainbody'><b>Quote Date:</b></td>
				<td width='100' valign='top' nowrap class='mainbody'><%= odate %></td>
			</tr>
			<tr>
				<td width='200' valign='top' align='right' nowrap class='mainbody'><b>Bid Date:</b></td>
				<td width='100' valign='top' nowrap class='mainbody'><%= edate %></td>
			</tr>
		</table>
		<br>
		<table cellspacing='0' cellpadding='0' border='0' width='100%'>
			<tr><td nowrap valign='top' class='mainbodyh'><b>Project:</b>&nbsp;</td>
				<td width='200' nowrap valign='top' class='mainbody'><%= Project_name %><br></td>
				<td width='100' rowspan='3'>&nbsp;</td>
				<td valign='top' width='300' rowspan='3' nowrap class='mainbody'>
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
					%>
					<%= rep_account %><br>
					<%= address1 %> <%= address2 %><br>
					<%= rep_city %>,&nbsp;<%= rep_state %>&nbsp;<%= rep_zip_code %><br>
					Phone #: <%= rep_telephone %><br>
					Fax No: <%= rep_fax %><br>
					eMail: <%= rep_email %></td>

			</tr>
			<tr>
				<td valign='top'class='mainbodyh'><b>Architect:</b>&nbsp;</td>
				<td width='200' valign='top' class='mainbody'><%= Arch_name %></td>
				<td width='100'>&nbsp;</td>
			</tr>
			<tr><td valign='top' class='mainbodyh'><b>Location:</b>&nbsp;</td>
				<td width='200' valign='top' class='mainbody'><%= Arch_loc %></td>
				<td width='100'></td>
			</tr>
			<%
			if(quote_type_alt==null){ quote_type_alt="";}
			if(quote_typex== null){ quote_typex="";}
			if(product.equals("EJC")){
				if(quote_type_alt != null && quote_type_alt.equals("v")){
			%>
			<tr><td valign='top' class='mainbodyh'><b>Parking</b>&nbsp;</td>

				<td width='100'></td>
			</tr>
			<%
				}
			}
			else{
				String final_type="";
				//out.println(quote_typex+"::"+quote_type_alt+"<BR>");
				if(quote_typex.equals("E") && quote_type_alt.equals("dl")){
					final_type="Decolink";
				}
				else if(quote_typex.equals("E")){
					if(product.equals("EJC")){
						final_type="Restofit";
					}
					else{
						final_type="Facility Sales";
					}
				}
				else if(quote_typex.equals("D")){
					final_type="Eldercare";
				}
				else if(quote_typex.toUpperCase().equals("C")){
					final_type="CS";
				}
				if(final_type.trim().length()>0){
			%>
			<tr><td valign='top' class='mainbodyh'><b><%=final_type%></b>&nbsp;</td>
				<td width='80%'></td>
			</tr>
			<%
		}
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
		//out.println("End");










		%>
		<br>
