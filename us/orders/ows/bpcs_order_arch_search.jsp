<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<html>
	<HEAD>
		<title>
			BPCS Customer search Helper
		</title>
		<link rel='stylesheet' href='style1.css' type='text/css' />
		<SCRIPT LANGUAGE="JavaScript">
			<!-- Begin
		 function toForm(){
				document.selectform.entry.focus();
			}
			// Form Focus script
			//  End -->
		</script>
	</HEAD>
	<%
		//HttpSession UserSession1 = request.getSession();
		//String country_code=UserSession1.getAttribute("country_code").toString();

	String rep_no = request.getParameter("rep_no");
	String mode = request.getParameter("mode");
	String cmd = request.getParameter("cmd");
	if (cmd==null){
	cmd="new";
	//out.println("Teasting"+cmd);
	}
	//HttpSession UserSession = request.getSession();
	//String country_code_session=UserSession.getValue("country_code").toString();
	//String usergroup=UserSession.getValue("usergroup").toString();
	//out.println("Teasting country"+usergroup);
	String country_code=userSession.getCountry();
	String country_code_session=userSession.getCountry();
	String usergroup=userSession.getGroup();
	%>
	<BODY bgcolor="whitesmoke" onLoad="toForm()">
	<center>
		<h1>Architect Name Searching</h1>
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
		out.println("<form name='selectform' action='bpcs_order_arch_picker.jsp'>");
		adder="Enter a few letters of the Architect's name & Click Search:";
		}
		%>
		<font face="verdana" size="-6"><b><%= adder %></b></font>
		<input type='hidden' name='rep_no' value=<%= rep_no %> >
		<input type='hidden' name='tmode' value=<%= mode %> >
		<br><br>Architect Name :
		<input type='text' name="entry" class='text'><br><br>

		<input type='submit' name='enter' value='Search' class='button'>
		</form>
	</center>
	<div align= 'right'>
		<%


		%>
	</div>

</body>
</html>



