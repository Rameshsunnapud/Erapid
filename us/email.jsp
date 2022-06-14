<script language="JavaScript" src="../javascript/emailUS.js"		></script>
<%

boolean success = (new File(dirname)).mkdir();
//logger.debug(success+":: create directorY"+tempdate+"::"+dirname);
%>
<form name='emailForm' method='post' >

	<input type='hidden' name='dirname' value='<%=dirname%>'>
	<input type='hidden' name='attachfiles' value=''>

	<table width='100%' border='0'>
		<tr class='header1'>
			<td colspan='4' align='center'><h3>EMAIL</h3> </td>
		</tr>
		<tr>
			<td align='right'>To:</td>
			<td ><input type='text' name="to" class='text' value=""><input type='hidden' name="from" value="<%=repEmail %>" ></td>

			<td width='30%' rowspan='7' valign='top' style="border-left: 1px solid #333333; padding: 5px;"><b><u>Standard Attachments</b></u><div id='emailCheckBoxDiv'></div></td>
			<td width='40%' rowspan='7' valign='top' style="border-left: 1px solid #333333; padding: 5px;"><iframe id='emailIframe' height='350' width='500' frameborder="0" ></iframe> </td>
		</tr>

		<tr>
			<td align='right'>CC:</td>
			<td ><input type='text' name="cc" value='' class='text' ></td>

		</tr>
		<tr>
			<td align='right'>BCC:</td>
			<td ><input type='text' name="bcc" value='' class='text' ></td>
		</tr>
		<tr>
			<td align='right'>BCC3:</td>
			<td ><input type='text' name="bcc2" value='' class='text' ><input type='checkbox' name='copyMe' onchange='changeCopyMe()'></td>
		</tr>
		<!--<tr>
			<td>&nbsp;</td>
			<TD><SELECT NAME='bcc2'><%=quoteHeader.getPullDownValues(userSession.getCountry(),product,userSession.getGroup(),"BCC")%></SELECT></TD>
		</tr>-->

		<tr>
			<td align='right'>Quote:</td>
			<TD><SELECT NAME='url' id='url'><%=quoteHeader.getPullDownValues2(userSession.getCountry(),product,userSession.getGroup(),"emailQuotes",projectType,quoteOrigin)%></SELECT></TD>
		</tr>
		<tr>
			<td align='center' colspan='2'><input type='button' name='sendEmail' value='Send' onclick='sendEmailx();' class='button'></td>
		</tr>
		<tr>
			<td align='right'>Message:</td>
			<td ><textarea name='message' cols=50 rows=15 value=""></textarea></td>

		</tr>


	</table>
</form>

