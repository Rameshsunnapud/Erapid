<html>
<HEAD>
<title>Resend</title>
<link rel='stylesheet' href='style1.css' type='text/css' />
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function toForm() {
	document.selectform.order_no.focus();
}
function checkThis(){
	if(document.selectform.order_no.value.length == 6){
		document.selectform.order_no.value=document.selectform.order_no.value+"_00";
		return true;
	}
	else if(document.selectform.order_no.value.length == 9){
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
</HEAD>
<%
String rep_no = request.getParameter("rep_no");;
%>
<BODY bgcolor="whitesmoke" onLoad="toForm()" >
<center>
<h1>Resend to IMS</h1>
<%
String adder="";
adder="Enter the Quote Number & Click Send to resend to IMS:";
out.println("<form name='selectform' action='resend.jsp' onsubmit='return checkThis()'>");
%>
<input type='hidden' name='rep_no' value=<%= rep_no %> >
<input type='text' name="order_no" class='text'>
<font face="verdana" size="-6">(Please enter the entire Quote Number.)</font>
<br><br>
<input type='submit' name='enter' value='Resend' class='button'>
</form>
</center>
</body>
</html>
