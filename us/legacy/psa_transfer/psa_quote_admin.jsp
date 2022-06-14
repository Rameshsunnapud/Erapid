
<html>
	<head>
		<title>PSA Quote Admin</title>
		<script language="JavaScript" src="date-picker.js"></script>
		<link rel='stylesheet' href='style1.css' type='text/css' />
		<SCRIPT LANGUAGE="JavaScript">
		<!-- Begin
			function toForm(){
				document.selectForm.quote_no.focus();
		//this.moveTo(0, 0);
				this.resizeTo(500,500);
			}
			function checkThis(){
		//alert("HERE")
				if(document.selectForm.quote_no.value.length==6){
					document.selectForm.quote_no.value=document.selectForm.quote_no.value+"_00";
					return true;
				}
				else if(document.selectForm.quote_no.value.length==9){
					return true;
				}
				else{
					alert("Please enter a valid quote number");
					return false;
				}
			}
		// Form Focus script
		//  End -->
		</script>
	</head>
	<BODY bgcolor="whitesmoke" onLoad="toForm()" >
		<%@ page language="java" import="java.sql.*" import="java.util.*" errorPage="error.jsp" %>
		<form name='selectForm' action='psa_quote_admin_forward.jsp' onsubmit='return checkThis()'>
			<font color='red' size='3'>WARNING: Do not use this link to issue PSA quotes.  <BR>
			For Emergency use only.<BR>
			Using this link will not update PSA tables.<BR><BR></font>
			<input type=text name='quote_no'>Please enter a valid Erapid quote number
			<input type='submit' value='Submit' class='button' >
		</form>
	</body>
</html>