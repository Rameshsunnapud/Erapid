<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../Connections/conn_Intranet.asp" -->
<%
Dim rs_OutOfOffice__MMColParam
rs_OutOfOffice__MMColParam = "1"
If (Request("MM_EmptyValue") <> "") Then 
  rs_OutOfOffice__MMColParam = Request("MM_EmptyValue")
End If
%>
<%
Dim rs_OutOfOffice
Dim rs_OutOfOffice_cmd
Dim rs_OutOfOffice_numRows

Set rs_OutOfOffice_cmd = Server.CreateObject ("ADODB.Command")
rs_OutOfOffice_cmd.ActiveConnection = MM_conn_Intranet_STRING
rs_OutOfOffice_cmd.CommandText = "SELECT * FROM dbo.OutOfOffice WHERE ID <> ? ORDER BY DATE_TO ASC" 
rs_OutOfOffice_cmd.Prepared = true
rs_OutOfOffice_cmd.Parameters.Append rs_OutOfOffice_cmd.CreateParameter("param1", 5, 1, -1, rs_OutOfOffice__MMColParam) 
Set rs_OutOfOffice = rs_OutOfOffice_cmd.Execute

rs_OutOfOffice_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
rs_OutOfOffice_numRows = rs_OutOfOffice_numRows + Repeat1__numRows
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<SCRIPT RUNAT=SERVER LANGUAGE=VBSCRIPT>					
function DoDateTime(str, nNamedFormat, nLCID)				
	dim strRet								
	dim nOldLCID								
										
	strRet = str								
	If (nLCID > -1) Then							
		oldLCID = Session.LCID						
	End If									
										
	On Error Resume Next							
										
	If (nLCID > -1) Then							
		Session.LCID = nLCID						
	End If									
										
	If ((nLCID < 0) Or (Session.LCID = nLCID)) Then				
		strRet = FormatDateTime(str, nNamedFormat)			
	End If									
										
	If (nLCID > -1) Then							
		Session.LCID = oldLCID						
	End If									
										
	DoDateTime = strRet							
End Function									
</SCRIPT>									
<html xmlns="http://www.w3.org/1999/xhtml"><!-- InstanceBegin template="../Templates/template_std.dwt" codeOutsideHTMLIsLocked="false" -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<!-- #BeginEditable "doctitle" -->
<title>Welcome to the C/S Group in Aylesbury</title>
<style type="text/css">
<!--
.style2 {font-size: 9pt}
.cell_redBg_whiteDateText {
	font-size: 8pt;
	font-weight: normal;
	color: #FFFFFF;
	background-color: #CD202C;
	margin-bottom: 0px;
	margin-top: 0px;
}
-->
</style>
<!-- #EndEditable -->
<link rel="shortcut icon" href="http://172.19.201.203/images/favicon.ico" type="image/vnd.microsoft.icon" />
<link rel="stylesheet" type="text/css" href="../styles.css" />
<style type="text/css">
.style1 {
	background-color: #FFFFFF;
}
body {
	background-color: #C8C8C8;
}
</style>
<script type="text/javascript">
<!--
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}
//-->
</script>
</head>
<body onload="MM_preloadImages('../images/banner01.gif')">
<table width="800" align="center" cellpadding="0" cellspacing="0" class="style1">
  <tr>
	<td valign="top" style="height: 150px" colspan="3"><a href="../index.asp" onmouseout="MM_swapImgRestore()" onmouseover="MM_swapImage('Image4','','../images/banner01.gif',1)"><img src="../images/banner03.gif" alt="Welcome to C/S @ Westcott" name="Image4" width="800" height="150" border="0" id="Image4" /></a></td>
  </tr>
	<tr>
		<td width="175" valign="top">
		<div style="margin:10px">
		<table style="width: 100%" cellpadding="0" >
			<tr>
			  <td><p class="cell_redBg_whiteText">Product Links</p></td>
			</tr>
			<tr>
				<td><p class="list" style="margin-top:10px"><a href="../brochures.html">Brochures</a></p>
				  <p class="list" style="margin-top:10px"><a href="../products/acrovyn.html">Acrovyn</a></p>
				  <p class="list"><a href="../products/pedisystems.html">Pedisystems</a></p>
					<p class="list"><a href="../products/wallglaze.html">Wallglaze</a></p>
					<p class="list"><a href="../products/allway.html">Allway</a></p>
				  <p class="list"><a href="../products/airfoil.html">Airfoil / Solarmotion</a> </p>
					<p class="list"><a href="../products/supertrak.html">Supertrak</a></p>
					<p class="list"><a href="../products/louvres.html">Louvres</a></p>
					<p class="list"><a href="../products/explovent.html">Explovent</a></p>
					<p class="list"><a href="../marketsectors.html">Market Sectors</a></p>
					<p class="list"><a href="../contractorsleaflets.html">Contractor Leaflets</a></p>
				</td>
			</tr>
			<tr>
			  <td><p class="cell_redBg_whiteText">C/S Websites</p></td>
			</tr>
			<tr>
				<td>
				<p class="list" style="margin-top:10px"><a href="http://www.c-sgroup.co.uk/" target="_blank">C/S UK</a></p>
				<p class="list"><a href="http://www.c-sgroup.com">C/S North America</a></p>
				<p class="list"><a href="http://www.cs-france.fr/">C/S France</a></p>
				<p class="list"><a href="http://www.c-sgroup.de/">C/S Germany</a></p>
				<p class="list"><a href="http://www.cspolska.com.pl/">C/S Poland</a></p>
				<p class="list"><a href="http://www.c-sgroup.com.sg/">C/S Asia</a></p>
				<p class="list"><a href="http://csra">C/S Citrix Login</a></p>
			  	<p class="list"><a href="http://ifactory.c-sgroup.com">C/S Ideas Factory</a></p>
			  	<p class="list"><a href="http://cs.skillport.com/skillportfe/login.action">C/S eLearning Courses</a></p></td>
			</tr>
		</table>
		</div>
        <img src="../images/spacers/h175.gif" alt="" name="spacer_175" width="175" height="1" id="spacer_175" />		</td>
    <td width="446" valign="top" style="border-right-style:solid; border-right-width:2px; border-right-color:silver; border-left-style:solid; border-left-width:2px; border-left-color:silver">
		  <!-- #BeginEditable "content" -->
		  <div style="margin:10px">
            <table cellpadding="0" cellspacing="0" style="width: 100%">
              <tr>
                <td width="50%"><p class="cell_redBg_whiteText"> 
				Insert / Update / Delete<br />
				Staff Absentee Details</p></td>
                <td width="50%" style="background-color:#CD202C">
				<p class="cell_redBg_whiteDateText" align="right" >
				<%response.write(FormatDateTime(date(),vblongdate))%>
                &nbsp;</p>
              </tr>
              <tr>
                <td colspan="2" align="left">
				<p style="margin-top:15px; margin-bottom:15px"><strong>Please select your required action...</strong> (Please note: All dates are inclusive)</p>
				<p class="style1"><a href="absent_insert.asp">Insert New Absentee Details</a></p>
				<p class="style1"><a href="absent_del_search.asp">Delete Absentee Details</a></p>
				<p class="style1"><a href="absent_upd_search.asp">Update Absentee Details</a></p>
				<p class="style1" style="margin-bottom:15px"><a href="../index.asp">Return to Home page</a></p>
				</td>
              </tr>
            </table>
		    <table style="width: 100%" cellpadding="0">
              <tr>
				<td style="border-bottom-style:solid; border-bottom-width:1px; border-bottom-color:#999999">
				  <strong>Name</strong></td>
				<td style="border-bottom-style:solid; border-bottom-width:1px; border-bottom-color:#999999">
				  <strong>From</strong></td>
				<td style="border-bottom-style:solid; border-bottom-width:1px; border-bottom-color:#999999">
				  <strong>To</strong></td>
				<td style="border-bottom-style:solid; border-bottom-width:1px; border-bottom-color:#999999">
				  <strong>Reason</strong></td>
              </tr>
              <% 
While ((Repeat1__numRows <> 0) AND (NOT rs_OutOfOffice.EOF)) 
%>
                <tr>
                  <td class="style2"><%=(rs_OutOfOffice.Fields.Item("NAME").Value)%></td>
                  <td class="style2"><%= DoDateTime((rs_OutOfOffice.Fields.Item("DATE_FROM").Value), 2, 2070) %></td>
                  <td class="style2"><%= DoDateTime((rs_OutOfOffice.Fields.Item("DATE_TO").Value), 2, 2070) %></td>
                  <td class="style2"><%=(rs_OutOfOffice.Fields.Item("REASON").Value)%></td>
                </tr>
                <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  rs_OutOfOffice.MoveNext()
Wend
%>
            </table>
			
			<h1 class="style2" style="margin-top:15px">&nbsp;</h1>
		  </div>
		<!-- #EndEditable -->
        <img src="../images/spacers/h446.gif" alt="" id="spacer_446" height="1" width="446" />
		</td>
	  <td width="175" valign="top" style="height: 450px;">
		<div style="margin:10px">
		<table style="width: 100%" cellpadding="0">
			<tr>
				<td><p class="cell_redBg_whiteText" style="margin-bottom:0">
				Documents &amp; Utilities</p></td>
			</tr>
			<tr>
				<td>
				<p class="list" style="margin-top:10px"><a href="https://myfreedom.adp.com/ukWelcome.asp" target="_blank">ADP Freedom Login</a></p>
				<p class="list" style="margin-top:10px"><a href="../assistance.html">Employee Assistance Programme</a></p>
				<p class="list" style="margin-top:10px"><a href="../Jobs/jobvacancies.html">C/S UK Job Vacancies</a></p>
				<p class="list" style="margin-top:10px"><a href="../documents/Agents.pdf">Agent and Rep Directory</a></p>
				<p class="list" style="margin-top:10px"><a href="../documents/OverseasAgents.pdf">Overseas Agents</a></p>
				<p class="list"><a href="../forms.html">Internal Forms</a></p>
				<p class="list"><a href="../documents.html">Company Documents</a></p>
				<p class="list"><a href="../documents/Telephone_Directory.pdf">Internal Directory</a></p>
<p class="list"><a target="_blank" href="http://www.thephonebook.bt.com/">Directory Enquiries</a></p>
<p class="list"><a href="https://constructionspecialties.egnyte.com/dl/nMYtbuaBDL" target="_blank">Product Data Index</a></p>
<p class="list"><a target="_blank" href="http://translate.google.com/">Language Translation</a></p>
				<p class="list"><a target="_blank" href="http://www.google.com/finance/converter?a=1&amp;from=GBP&amp;to=EUR">
			  Currency Conversion</a></p>
			  <p class="list"><a href="http://portal.microsoftonline.com">CS Webmail </a></p>
			  <p class="list"><a href="http://info.c-sgroup.co.uk/" title="CS Blog">CS Blog</a></p>
			  <p class="list"><a href="http://bit.ly/csblogideas" title="Blog Ideas">CS Blog Ideas Form</a></p>
			  <p class="list"><a href="index.asp">Staff Absence</a></p></td>
			</tr>
		</table>
		
		</div>
        <img src="../images/spacers/h175.gif" alt="" name="spacer_175" width="175" height="1" id="spacer_175" />		</td>
  </tr>
</table>

</body>

<!-- InstanceEnd --></html>
<%
rs_OutOfOffice.Close()
Set rs_OutOfOffice = Nothing
%>
