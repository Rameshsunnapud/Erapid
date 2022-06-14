<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<html>
	<HEAD>
		<title>
			BPCS Customer search Helper
		</title>
		<link rel='stylesheet' href='style1.css' type='text/css' />
		<SCRIPT LANGUAGE="JavaScript">
			function toForm(){
				document.selectform.entry_no.focus();
			}
			function checkThis(){
				if(document.selectform.entry_no.value.length>0||document.selectform.cust_name.value.length>0){
					//alert("HERE");
					return true;
				}
				else{
					alert("You must either search by BPCS customer number or do another search with part of the customer name");
					return false;
				}
			}
		</script>
	</HEAD>
	<%
	/*
	HttpSession UserSession1 = request.getSession();
	String country_code=UserSession1.getAttribute("country_code").toString();

	HttpSession UserSession = request.getSession();
	String country_code_session=UserSession.getValue("country_code").toString();
	String usergroup=UserSession.getValue("usergroup").toString();
*/
	String mode=request.getParameter("mode");
String rep_no = request.getParameter("rep_no");
String country_code=userSession.getCountry();
String country_code_session=userSession.getCountry();
String usergroup=userSession.getGroup();

	%>
	<BODY bgcolor="whitesmoke" onLoad="toForm()">
	<center>
		<h1>Customer Name Searching/Editing</h1>
		<form name='selectform' action='bpcs_order_cust_picker2_new.jsp' onsubmit='return checkThis()'>
			<input type='hidden' name='rep_no' value=<%= rep_no %> >
			<input type='hidden' name='mode' value='<%=mode%>'>
			<table>
				<tr>
					<td>
						<b>BPCS Customer Number :</b>
					</td>
					<td>
						<input type='text' name='entry_no' >
					</td>
				</tr>
				<tr>
					<td colspan='2'>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td colspan='2' align='center'>
						<B>OR</B>
					</td>
				</tr>
				<tr>
					<td colspan='2'>
						&nbsp;
					</td>
				</tr>
				<tr>
					<td>
						<b>Customer Name :</b>
					</td>
					<td>
						<input type='text' name="cust_name" >
					</td>
				</tr>
				<tr>
					<td>
						<b>Address 1 :</b>
					</td>
					<td>
						<input type='text' name="addr1" >
					</td>
				</tr>
				<tr>
					<td>
						<b>Address 2 :</b>
					</td>
					<td>
						<input type='text' name="addr2" >
					</td>
				</tr>
				<tr>
					<td>
						<b>City :</b>
					</td>
					<td>
						<input type='text' name="city" >
					</td>
				</tr>
				<tr>
					<td>
						<b>State :</b>
					</td>
					<td>
						<input type='text' name="state" >
					</td>
				</tr>
				<tr>
					<td>
						<b>Zip Code :</b>
					</td>
					<td>
						<input type='text' name="zip" >
					</td>
				</tr>
				<tr>
					<td>
						<b>Phone Number :</b>
					</td>
					<td>
						<input type='text' name="phone" >
					</td>
				</tr>
				<tr>
					<td>
						<b>Address Type :</b>
					</td>
					<td>
						<input type='text' name="addr_type" >
					</td>
				</tr>
				<tr>
					<td colspan='2' align='center'>
						<input type='submit' name='enter' value='Search' class='button' >
					</td>
				</tr>
		</form>
	</center>
	<div align= 'right'>
	</div>


</body>
</html>



