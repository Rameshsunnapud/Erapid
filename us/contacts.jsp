<script language="JavaScript" src="../javascript/contacts.js"		></script>
<div id="contacts" class='contacts'></div>
<div id="contactEdit" class='contactEdit'>
	<form name='editContact'>
		<input type='hidden' name='custNo'>
		<input type='hidden' name='contactNo'>
		<input type='hidden' name='countryCode'>
		<table width='1180px;' border='0'>
			<tr>
				<td width='50%' align='left'>Contact Name</td>
				<td width='50%' align='left'><input type='text' name='contactName' value=''></td>
			</tr>
			<tr>
				<td width='50%' align='left'>Phone</td>
				<td width='50%' align='left'><input type='text' name='contactPhone' value=''></td>
			</tr>
			<tr>
				<td width='50%' align='left'>Fax</td>
				<td width='50%' align='left'><input type='text' name='contactFax' value=''></td>
			</tr>
			<tr>
				<td width='50%' align='left'>Email</td>
				<td width='50%' align='left'><input type='text' name='contactEmail' value=''></td>
			</tr>
			<tr>
				<td width='50%' align='left'>Dormant</td>
				<td width='50%' align='left'><input type='checkbox' name='contactDormant' value=''></td>
			</tr>
			<tr>
				<td colspan='2'>
					<input type='button' name='saveContact' value='Save' onclick='saveContacts()' class='button'>
					<input type='button' name='cancel' value='Cancel' onclick='closeContactEdit()' class='button'>
				</td>
			</tr>
		</table>
	</form>
</div>
<div id='selectContact' class='selectContact'>
</div>