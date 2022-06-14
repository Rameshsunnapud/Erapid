<html>
<HEAD>
<title>
BPCS Customer search Helper
</title>
<link rel='stylesheet' href='style1.css' type='text/css' />
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
 function toForm() {
document.selectform.entry.focus();
}
// Form Focus script
//  End -->
</script>
</HEAD>
<%
	HttpSession UserSession1 = request.getSession();
	String country_code=UserSession1.getAttribute("country_code").toString();

String rep_no = request.getParameter("rep_no");
String mode = request.getParameter("mode");
String cmd = request.getParameter("cmd");
if (cmd==null){
cmd="new";
//out.println("Teasting"+cmd);
}
HttpSession UserSession = request.getSession();
String country_code_session=UserSession.getValue("country_code").toString();
String usergroup=UserSession.getValue("usergroup").toString();
//out.println("Teasting country"+usergroup);
%>
<BODY bgcolor="whitesmoke" onLoad="toForm()">
<center>
<h1>Customer Name Searching/Editing</h1>
<%
String adder="";
 if (cmd.equals("edit")){
adder="Enter a few letters of the BPCS Customer's name & Click Search to edit the customer:";
		if (country_code_session.equals("GB"))
				out.println("<form name='selectform' action='edit_customer_uk.jsp'>");
		else{
			if(usergroup.startsWith("Grand")){
			out.println("Hello");
			out.println("<form name='selectform' action='edit_customer_ge.jsp'>");
			}
			else{
					out.println("<form name='selectform' action='edit_customer.jsp'>");
			}
		}
 }

else{
out.println("<form name='selectform' action='bpcs_order_cust_picker2.jsp'>");
adder="Enter a few letters of the BPCS Customer's name  or BPCS Customer Number & Click Search:";
}
%>
<font face="verdana" size="-6"><b><%= adder %></b></font>
<input type='hidden' name='rep_no' value=<%= rep_no %> >
<input type='hidden' name='tmode' value=<%= mode %> >
<br><br>BPCS Customer Name :
<input type='text' name="entry" class='text'><br><br>
BPCS Customer Number :
<input type='text' name="entry_no" class='text'><br><br>
<input type='submit' name='enter' value='Search' class='button'>
</form>
</center>
<div align= 'right'>
<%


 %>
</div>

</body>
</html>



