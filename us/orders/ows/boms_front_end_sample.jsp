
<html>
<HEAD>
<title>BOM/ROU product MAP</title>
<link rel='stylesheet' href='../../../style1.css' type='text/css' />
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function toForm() {	
	document.selectform.prod_code.focus();
}
function checkThis(){
	if(document.selectform.entry.value.length == 6){
		document.selectform.entry.value=document.selectform.entry.value+"_00";
		return true;
	}
	else if(document.selectform.entry.value.length == 9){
		return true;
	}
	else{
		alert("Please enter a valid quote number");
		return false;
	}
}
// Form Focus script
//  End -->
//24W004
</script>
</HEAD>
<%

%>
<BODY bgcolor="whitesmoke" onLoad="toForm()" >
<center>
<h1>BOM/ROU product sample MAP</h1>
<form name="selectform" action="boms_tree_sample.jsp">
<table border=0 width='75%'>
<tr>	<td class='noheader' align='right' >Enter the product code:</td>
		<td class='noheader'><input type='text' name="prod_code" value='4C102' class='notext1'></td>
	</tr>
	<tr>	<td class='header' align='right' >Enter the Quantity :</td>
		<td class='header'><input type='text' name="prod_quant" value='100' class='text1'></td>
	</tr>
</table>
<br><br>
<input type='submit' name='enter' value='Search' class='button'>
</form>
</center>
</body>
</html>
