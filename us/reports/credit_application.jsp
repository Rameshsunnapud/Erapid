<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<html>
	<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
	<%@ include file="../../db_con.jsp"%>
	<%
		String order_no=request.getParameter("orderNo");
		String price="_______";
		ResultSet rs1=stmt.executeQuery("select configured_price from cs_project where order_no='"+order_no+"'");
		if(rs1 != null){
			while(rs1.next()){
				if(rs1.getString(1) != null && rs1.getString(1).trim().length()>0){
					price=rs1.getString(1);
				}
			}
		}
		rs1.close();
		stmt.close();
		myConn.close();
	%>
	<head>
		<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
		<meta name=Generator content="Microsoft Word 12 (filtered)">
		<style>
			<!--
			/* Font Definitions */
			@font-face
			{font-family:"Cambria Math";
			 panose-1:2 4 5 3 5 4 6 3 2 4;}
			@font-face
			{font-family:Calibri;
			 panose-1:2 15 5 2 2 2 4 3 2 4;}
			@font-face
			{font-family:Tahoma;
			 panose-1:2 11 6 4 3 5 4 4 2 4;}
			/* Style Definitions */
			p.MsoNormal, li.MsoNormal, div.MsoNormal
			{margin-top:0cm;
			 margin-right:0cm;
			 margin-bottom:10.0pt;
			 margin-left:0cm;
			 line-height:115%;
			 font-size:11.0pt;
			 font-family:"Calibri","sans-serif";}
			a:link, span.MsoHyperlink
			{color:blue;
			 text-decoration:underline;}
			a:visited, span.MsoHyperlinkFollowed
			{color:purple;
			 text-decoration:underline;}
			p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
			{mso-style-link:"Balloon Text Char";
			 margin:0cm;
			 margin-bottom:.0001pt;
			 font-size:8.0pt;
			 font-family:"Tahoma","sans-serif";}
			p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
			{margin-top:0cm;
			 margin-right:0cm;
			 margin-bottom:10.0pt;
			 margin-left:36.0pt;
			 line-height:115%;
			 font-size:11.0pt;
			 font-family:"Calibri","sans-serif";}
			p.MsoListParagraphCxSpFirst, li.MsoListParagraphCxSpFirst, div.MsoListParagraphCxSpFirst
			{margin-top:0cm;
			 margin-right:0cm;
			 margin-bottom:0cm;
			 margin-left:36.0pt;
			 margin-bottom:.0001pt;
			 line-height:115%;
			 font-size:11.0pt;
			 font-family:"Calibri","sans-serif";}
			p.MsoListParagraphCxSpMiddle, li.MsoListParagraphCxSpMiddle, div.MsoListParagraphCxSpMiddle
			{margin-top:0cm;
			 margin-right:0cm;
			 margin-bottom:0cm;
			 margin-left:36.0pt;
			 margin-bottom:.0001pt;
			 line-height:115%;
			 font-size:11.0pt;
			 font-family:"Calibri","sans-serif";}
			p.MsoListParagraphCxSpLast, li.MsoListParagraphCxSpLast, div.MsoListParagraphCxSpLast
			{margin-top:0cm;
			 margin-right:0cm;
			 margin-bottom:10.0pt;
			 margin-left:36.0pt;
			 line-height:115%;
			 font-size:11.0pt;
			 font-family:"Calibri","sans-serif";}
			span.BalloonTextChar
			{mso-style-name:"Balloon Text Char";
			 mso-style-link:"Balloon Text";
			 font-family:"Tahoma","sans-serif";}
			.MsoPapDefault
			{margin-bottom:10.0pt;
			 line-height:115%;}
			@page Section1
			{size:612.0pt 792.0pt;
			 margin:1.0cm 37.9pt 42.55pt 72.0pt;}
			div.Section1
			{page:Section1;}
			/* List Definitions */
			ol
			{margin-bottom:0cm;}
			ul
			{margin-bottom:0cm;}
			-->
		</style>

	</head>

	<body lang=EN-CA link=blue vlink=purple>

		<div class=Section1>

			<table class=MsoTableGrid border=0 cellspacing=0 cellpadding=0 width=836
				  style='width:501.55pt;border-collapse:collapse;border:none'>
				<tr>
					<td width=238 rowspan=6 valign=top style='width:120pt;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:0cm;margin-bottom:.0001pt;line-height:
						   normal'><!--<img width=174 height=24 id="Picture 1"
						   src="credit%20application_files/image002.jpg" alt="cs_logo_flat_large.jpg">-->

							<img src='http://csimages.c-sgroup.com/eRapid/cs_logo.jpg' alt='CS Logo' width=174 height=24></p>
					</td>
					<td width=397 rowspan=6 style='width:175pt;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal align=center style='margin-bottom:0cm;margin-bottom:.0001pt;
						   text-align:center;line-height:normal'><b><span style='font-size:14.0pt'>Credit
									Application</span></b></p>
					</td>
					<td width=201 valign=top style='width:170.5pt;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;
						   margin-left:15.85pt;margin-bottom:.0001pt;line-height:normal'><span
								style='font-size:7.0pt'>Construction Specialties, Inc.</span></p>
					</td>
				</tr>
				<tr>
					<td width=201 valign=top style='width:120.5pt;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;
						   margin-left:15.85pt;margin-bottom:.0001pt;line-height:normal'><span
								style='font-size:7.0pt'>6696 Route 405</span></p>
					</td>
				</tr>
				<tr>
					<td width=201 valign=top style='width:120.5pt;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;
						   margin-left:15.85pt;margin-bottom:.0001pt;line-height:normal'><span
								style='font-size:7.0pt'>Muncy, PA 17756</span></p>
					</td>
				</tr>
				<tr>
					<td width=201 valign=top style='width:120.5pt;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;
						   margin-left:15.85pt;margin-bottom:.0001pt;line-height:normal'><span
								style='font-size:7.0pt'>jbarton@c-sgroup.com</span></p>
					</td>
				</tr>
				<tr>
					<td width=201 valign=top style='width:120.5pt;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;
						   margin-left:15.85pt;margin-bottom:.0001pt;line-height:normal'><span
								style='font-size:7.0pt'>Tel.: 570-546-4757</span></p>
					</td>
				</tr>
				<tr>
					<td width=201 valign=top style='width:120.5pt;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-top:0cm;margin-right:0cm;margin-bottom:0cm;
						   margin-left:15.85pt;margin-bottom:.0001pt;line-height:normal'><span
								style='font-size:7.0pt'>Fax: 908-849-3151</span></p>
					</td>
				</tr>
			</table>

			<p class=MsoNormal style='margin-top:6.0pt;margin-right:0cm;margin-bottom:0cm;
			   margin-left:0cm;margin-bottom:.0001pt;line-height:normal'><span
					style='font-size:7.0pt'>Thank you for your interest in Construction
					Specialties. Please complete the following information in full and fax or email
					to Jennifer Barton.</span></p>

			<p class=MsoNormal style='margin-bottom:6.0pt;line-height:normal'><span
					style='font-size:7.0pt'>This information and credit results will be held in
					strict confidence. If you need assistance please contact Jennifer Barton at
					570-546-4757.</span></p>

			<p class=MsoNormal style='margin-bottom:2.0pt;line-height:normal'><b><span
						style='font-size:7.0pt'>BILLING ADDRESS</span></b></p>

			<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 width=848
				  style='width:508.65pt;border-collapse:collapse;border:none'>
				<tr>
					<td width=848 colspan=6 valign=bottom style='width:508.65pt;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>NAME _________________________________________________________________________________________________________</span></p>
					</td>
				</tr>
				<tr>
					<td width=848 colspan=6 valign=bottom style='width:508.65pt;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>ADDRESS
								_______________________________________________________________________________________________________</span></p>
					</td>
				</tr>
				<tr>
					<td width=848 colspan=6 valign=bottom style='width:508.65pt;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>CITY, STATE, ZIP
								_________________________________________________________________________________________________</span></p>
					</td>
				</tr>
				<tr>
					<td width=210 colspan=2 valign=bottom style='width:125.9pt;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>PHONE ___________________</span></p>
					</td>
					<td width=236 colspan=3 valign=bottom style='width:5.0cm;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>FAX _________________________</span></p>
					</td>
					<td width=402 valign=bottom style='width:241.0pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>Accounts Payable Email  _______________________________</span></p>
					</td>
				</tr>
				<tr>
					<td width=115 valign=bottom style='width:69.2pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:9.0pt;font-family:Symbol'><input type='checkbox' name='box' disabled> </span><span
								style='font-size:7.0pt'>SUBSIDIARY</span></p>
					</td>
					<td width=95 valign=bottom style='width:2.0cm;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:9.0pt;font-family:Symbol'><input type='checkbox' name='box' disabled> </span><span
								style='font-size:7.0pt'>BRANCH</span></p>
					</td>
					<td width=236 colspan=3 valign=bottom style='width:5.0cm;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:9.0pt;font-family:Symbol'><input type='checkbox' name='box' disabled> </span><span
								style='font-size:7.0pt'>DIVISION OF ________________</span></p>
					</td>
					<td width=402 valign=bottom style='width:241.0pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>Standard Payment Terms are Net 30 Days</span></p>
					</td>
				</tr>
				<tr>
					<td width=446 colspan=5 valign=bottom style='width:267.65pt;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>ACCOUNTS PAYABLE CONTACT
								_______________________________</span></p>
					</td>
					<td width=402 valign=bottom style='width:241.0pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:9.0pt;font-family:Symbol'><input type='checkbox' name='box' disabled> </span><span
								style='font-size:7.0pt'>YES, WE ARE TAX EXEMPT</span></p>
					</td>
				</tr>
				<tr>
					<td width=281 colspan=3 valign=bottom style='width:168.45pt;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>PHONE ____________________________</span></p>
					</td>
					<td width=165 colspan=2 valign=bottom style='width:99.2pt;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>EXT. _______________</span></p>
					</td>
					<td width=402 valign=bottom style='width:241.0pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:9.0pt;font-family:Symbol'><input type='checkbox' name='box' disabled> </span><span
								style='font-size:7.0pt'>ATTACHED IS OUR TAX EXEMPT CERTIFICATE</span></p>
					</td>
				</tr>
				<tr>
					<td width=446 colspan=5 valign=bottom style='width:267.65pt;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>FAX
								_____________________________________________________</span></p>
					</td>
					<td width=402 valign=bottom style='width:241.0pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>    WE ACCEPT VISA, MasterCard, American Express</span></p>
					</td>
				</tr>
				<tr>
					<td width=424 colspan=4 valign=bottom style='width:254.3pt;border:none;
					    border-bottom:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal align=right style='margin-bottom:3.0pt;text-align:right;
						   line-height:normal'><b><span style='font-size:6.0pt'>&nbsp;</span></b></p>
					</td>
					<td width=424 colspan=2 valign=bottom style='width:254.35pt;border:none;
					    border-bottom:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal align=center style='margin-bottom:3.0pt;text-align:center;
						   line-height:normal'><b><span style='font-size:6.0pt'>Construction Specialties
									will charge tax unless a tax exemption Certificate is provided.</span></b></p>
					</td>
				</tr>
				<tr height=0>
					<td width=145 style='border:none'></td>
					<td width=117 style='border:none'></td>
					<td width=71 style='border:none'></td>
					<td width=126 style='border:none'></td>
					<td width=22 style='border:none'></td>
					<td width=440 style='border:none'></td>
				</tr>
			</table>

			<p class=MsoNormal style='margin-bottom:2.0pt;line-height:normal'><b><span
						style='font-size:7.0pt'>OWNERSHIP</span></b></p>

			<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 width=848
				  style='width:508.65pt;border-collapse:collapse;border:none'>
				<tr>
					<td width=127 valign=top style='width:76.3pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:9.0pt;font-family:Symbol'><input type='checkbox' name='box' disabled> </span><span
								style='font-size:7.0pt'>CORPORATION</span></p>
					</td>
					<td width=118 valign=top style='width:70.85pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:9.0pt;font-family:Symbol'><input type='checkbox' name='box' disabled> </span><span
								style='font-size:7.0pt'>PARTNERSHIP</span></p>
					</td>
					<td width=176 valign=top style='width:105.75pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:9.0pt;font-family:Symbol'><input type='checkbox' name='box' disabled> </span><span
								style='font-size:7.0pt'>SOLE PROPRIETORSHIP</span></p>
					</td>
					<td width=426 colspan=2 valign=top style='width:255.75pt;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>NAME OF PRINCIPAL(S) _____________________________</span></p>
					</td>
				</tr>
				<tr>
					<td width=422 colspan=3 valign=top style='width:252.9pt;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>NUMBER OF YEARS IN BUSINESS  _____________________</span></p>
					</td>
					<td width=426 colspan=2 valign=top style='width:255.75pt;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>ADDRESS _________________________________________</span></p>
					</td>
				</tr>
				<tr>
					<td width=422 colspan=3 valign=top style='width:252.9pt;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>DUN &amp; BRADSTREET #
								______________________________</span></p>
					</td>
					<td width=426 colspan=2 valign=top style='width:255.75pt;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>CITY, STATE, ZIP ___________________________________</span></p>
					</td>
				</tr>
				<tr>
					<td width=422 colspan=3 valign=top style='width:252.9pt;border:none;
					    border-bottom:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>EMAIL ADDRESS  __________________________________</span></p>
					</td>
					<td width=214 valign=top style='width:128.15pt;border:none;border-bottom:
					    solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>TELEPHONE _____________</span></p>
					</td>
					<td width=213 valign=top style='width:127.6pt;border:none;border-bottom:solid black 1.0pt;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>CELL PHONE ____________</span></p>
					</td>
				</tr>
			</table>

			<p class=MsoNormal style='margin-bottom:2.0pt;line-height:normal'><b><span
						style='font-size:7.0pt'>BANK REFERENCES</span></b></p>

			<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 width=848
				  style='width:508.65pt;border-collapse:collapse;border:none'>
				<tr>
					<td width=422 valign=top style='width:252.9pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>BANK ___________________________________________</span></p>
					</td>
					<td width=426 valign=top style='width:255.75pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>BANK ____________________________________________</span></p>
					</td>
				</tr>
				<tr>
					<td width=422 valign=top style='width:252.9pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>ADDRESS ________________________________________</span></p>
					</td>
					<td width=426 valign=top style='width:255.75pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>ADDRESS _________________________________________</span></p>
					</td>
				</tr>
				<tr>
					<td width=422 valign=top style='width:252.9pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>CITY, STATE, ZIP ___________________________________</span></p>
					</td>
					<td width=426 valign=top style='width:255.75pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>CITY, STATE, ZIP ___________________________________</span></p>
					</td>
				</tr>
				<tr>
					<td width=422 valign=top style='width:252.9pt;border:none;border-bottom:solid black 1.0pt;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>BUSINESS CHECKING ACCOUNT # _____________________</span></p>
					</td>
					<td width=426 valign=top style='width:255.75pt;border:none;border-bottom:
					    solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>BUSINESS CHECKING ACCOUNT # _____________________</span></p>
					</td>
				</tr>
			</table>

			<p class=MsoNormal style='margin-bottom:2.0pt;line-height:normal'><b><span
						style='font-size:7.0pt'>TRADE REFERENCES</span></b></p>

			<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 width=848
				  style='width:508.65pt;border-collapse:collapse;border:none'>
				<tr>
					<td width=422 valign=top style='width:252.9pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>1. BUSINESS NAME
								______________________________</span></p>
					</td>

					<td width=422 valign=top style='width:252.9pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>2.BUSINESS NAME
								______________________________</span></p>
					</td>
				</tr>
				<tr>
					<td width=422 valign=top style='width:252.9pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>ACCOUNT NUMBER
								___________________________</span></p>
					</td>
					<td width=426 valign=top style='width:255.75pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>ACCOUNT NUMBER
								___________________________</span></p>
					</td>
				</tr>
				<tr>
					<td width=422 valign=top style='width:252.9pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>CONTACT NAME ______________________________</span></p>
					</td>
					<td width=426 valign=top style='width:255.75pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>CONTACT NAME
								______________________________</span></p>
					</td>
				</tr>
				<tr>
					<td width=422 valign=top style='width:252.9pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>TELEPHONE NUMBER
								__________________________</span></p>
					</td>
					<td width=426 valign=top style='width:255.75pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>TELEPHONE NUMBER
								__________________________</span></p>
					</td>
				</tr>
				<tr style='height:20.3pt'>
					<td width=422 valign=top style='width:252.9pt;border:none;padding:0cm 5.4pt 0cm 5.4pt;
					    height:20.3pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>CREDIT FAX NUMBER
								__________________________</span></p>
					</td>
					<td width=426 valign=top style='width:255.75pt;border:none;padding:0cm 5.4pt 0cm 5.4pt;
					    height:20.3pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>CREDIT FAX NUMBER
								__________________________</span></p>
					</td>
				</tr>
				<tr>
					<td width=422 valign=top style='width:252.9pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>3. BUSINESS NAME
								______________________________</span></p>
					</td>

					<td width=422 valign=top style='width:252.9pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>4.BUSINESS NAME
								______________________________</span></p>
					</td>
				</tr>
				<tr>
					<td width=422 valign=top style='width:252.9pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>ACCOUNT NUMBER
								___________________________</span></p>
					</td>
					<td width=426 valign=top style='width:255.75pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>ACCOUNT NUMBER
								___________________________</span></p>
					</td>
				</tr>
				<tr>
					<td width=422 valign=top style='width:252.9pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>CONTACT NAME
								______________________________</span></p>
					</td>
					<td width=426 valign=top style='width:255.75pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>CONTACT NAME ______________________________</span></p>
					</td>
				</tr>
				<tr>
					<td width=422 valign=top style='width:252.9pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>TELEPHONE NUMBER
								__________________________</span></p>
					</td>
					<td width=426 valign=top style='width:255.75pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>TELEPHONE NUMBER
								__________________________</span></p>
					</td>
				</tr>
				<tr>
					<td width=422 valign=top style='width:252.9pt;border:none;border-bottom:solid black 1.0pt;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>CREDIT FAX NUMBER
								__________________________</span></p>
					</td>
					<td width=426 valign=top style='width:255.75pt;border:none;border-bottom:
					    solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;text-indent:21.3pt;line-height:
						   normal'><span style='font-size:7.0pt'>CREDIT FAX NUMBER
								__________________________</span></p>
					</td>
				</tr>
			</table>

			<p class=MsoNormal style='margin-top:0cm;margin-right:-1.15pt;margin-bottom:
			   0cm;margin-left:0cm;margin-bottom:.0001pt;line-height:7.0pt'><span
					style='font-size:7.0pt'><BR>The signing of this application authorizes Construction
					Specialties to perform the necessary credit investigation on the above company
					or individuals.</span></p>

			<p class=MsoNormal style='margin-top:0cm;margin-right:-1.15pt;margin-bottom:
			   3.0pt;margin-left:0cm;line-height:7.0pt'><span style='font-size:7.0pt'>I
					authorize the above references to release information necessary to determine
					my/our creditworthiness. In the event the account is turned over to an attorney
					or collection agency, I/my company shall be responsible for all fees/costs
					incurred by Construction Specialties in collecting the balance due.
					Furthermore, I understand that any pending orders may not be shipped if my
					account is past due or is over the previously established credit limit. Should
					Construction Specialties grant credit, all decisions with respect to the
					extension or continuation shall be in the sole discretion of Construction
					Specialties, Inc. Notwithstanding any provision in any agreement, the
					undersigned acknowledges that the extensions of credit may be changed or
					withdrawn at any time. Seller’s terms and conditions will supersede any and all
					contracts and/or documents unless expressly agreed to in writing by all parties
					to the contract.</span></p>

			<p class=MsoNormal style='margin-top:0cm;margin-right:-1.15pt;margin-bottom:
			   3.0pt;margin-left:0cm;line-height:7.0pt'><span style='font-size:7.0pt'>&nbsp;</span></p>

			<table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 width=848
				  style='width:508.65pt;border-collapse:collapse;border:none'>
				<tr>
					<td width=458 colspan=4 valign=bottom style='width:274.75pt;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>Authorized signature __________________________________</span></p>
					</td>
					<td width=378 colspan=4 valign=bottom style='width:8.0cm;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>Title _______________________________________</span></p>
					</td>
					<td style='border:none;padding:0cm 0cm 0cm 0cm' width=12><p class='MsoNormal'>&nbsp;</td>
				</tr>
				<tr>
					<td width=209 valign=top style='width:125.35pt;border:none;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal align=center style='margin-bottom:3.0pt;text-align:center;
						   line-height:normal'><b><span style='font-size:6.0pt'>&nbsp;</span></b></p>
					</td>
					<td width=209 colspan=2 valign=top style='width:125.4pt;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal align=center style='margin-bottom:3.0pt;text-align:center;
						   line-height:normal'><b><span style='font-size:6.0pt'>(Officer or Owner)</span></b></p>
					</td>
					<td width=209 colspan=3 valign=top style='width:125.4pt;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal align=center style='margin-bottom:3.0pt;text-align:center;
						   line-height:normal'><b><span style='font-size:6.0pt'>&nbsp;</span></b></p>
					</td>
					<td width=209 colspan=2 valign=top style='width:125.4pt;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal align=center style='margin-bottom:3.0pt;text-align:center;
						   line-height:normal'><b><span style='font-size:6.0pt'>&nbsp;</span></b></p>
					</td>
					<td style='border:none;padding:0cm 0cm 0cm 0cm' width=12><p class='MsoNormal'>&nbsp;</td>
				</tr>
				<tr>
					<td width=458 colspan=4 valign=top style='width:274.75pt;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>Print Name  _________________________________________</span></p>
					</td>
					<td width=378 colspan=4 valign=top style='width:8.0cm;border:none;padding:
					    0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>Date _______________________________________</span></p>
					</td>
					<td style='border:none;padding:0cm 0cm 0cm 0cm' width=12><p class='MsoNormal'>&nbsp;</td>
				</tr>
				<tr>
					<td width=836 colspan=8 valign=top style='width:501.55pt;border:none;
					    border-bottom:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><b><i><span
										style='font-size:7.0pt'>(Applicant agrees that a facsimile or emailed copy of
										the signature shall be accepted as the original)</span></i></b></p>
					</td>
					<td style='border:none;border-bottom:solid black 1.0pt' width=12><p class='MsoNormal'>&nbsp;</td>
				</tr>
				<tr>
					<td width=848 colspan=9 valign=top style='width:508.65pt;border:none;
					    padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>To be completed by Construction Specialties Credit
								Dept:</span></p>
					</td>
				</tr>
				<tr>
					<td width=316 colspan=2 valign=top style='width:189.7pt;border:none;
					    border-bottom:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>Customer # __________________________</span></p>
					</td>
					<td width=177 colspan=3 valign=top style='width:106.3pt;border:none;
					    border-bottom:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>Order # ____________</span></p>
					</td>
					<td width=165 colspan=2 valign=top style='width:99.25pt;border:none;
					    border-bottom:solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-top:0cm;margin-right:0cm;margin-bottom:3.0pt;
						   margin-left:2.2pt;line-height:normal'><span style='font-size:7.0pt'>Quote #
								<%=order_no%></span></p>
					</td>
					<td width=189 colspan=2 valign=top style='width:4.0cm;border:none;border-bottom:
					    solid black 1.0pt;padding:0cm 5.4pt 0cm 5.4pt'>
						<p class=MsoNormal style='margin-bottom:3.0pt;line-height:normal'><span
								style='font-size:7.0pt'>Initial Dollar Value $ <%=price%></span></p>
					</td>
				</tr>
			</table>

		</div>

	</body>

</html>
<%			}
			catch(Exception e){
			out.println(e);
			}
%>