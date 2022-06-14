<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/>
<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="quoteHeader" 	class="com.csgroup.general.QuoteHeaderBean" 	scope="page"/>
<script language="JavaScript" src="../javascript/ajax.js"></script>
<script language="JavaScript" src="../javascript/userAdmin.js"></script>
<html>
	<header>
		<title>
			User Preferences
		</title>
		<link rel='stylesheet' href='../css/<%=userSession.getStyleSheet()%>' type='text/css' />
	</header>
	<body onload='setPullDowns()'>
		<%@ page language="java" import="java.text.*" import="java.util.*" import="java.io.*"  errorPage="error.jsp" %>
		<form name='form1'>
			<table border='0' width='100%'>
				<tr class='header1'>
					<td COLSPAN='4' ALIGN='CENTER'>USER ADMIN</td>
				</tr>
				<tr>
					<td>Rep Number</td>
					<td><input type='text' name='repNo' class='text' value='<%=userSession.getRepNo().trim()%>' readonly></td>
					<td>Rep Name</td>
					<td>
						<input type='text' name='repName' class='text' value='<%=userSession.getUserName().trim()%>' readonly>
						<input type='hidden' name='repId' class='text' value='<%=userSession.getUserId().trim()%>' readonly>
					</td>
				</tr>
				<tr>
					<td>Rep Account</td>
					<td><input type='text' name='repAccount' value='<%=userSession.getRepAccount().trim()%>' class='text' readonly></td>
					<td>Style Sheet</td>
					<td>
						<input type='hidden' name='tempStyleSheet' value='<%=userSession.getStyleSheet().trim()%>'>
						<select name='styleSheet'>
							<%=quoteHeader.getPullDownValues(userSession.getCountry(),"*",userSession.getGroup(),"styleSheet")%>
						</select>
					</td>
				</tr>
				<tr>
					<td colspan='4'><hr></td>
				</tr>
				<tr>
					<td>Address 1</td>
					<td><input type='text' class='text' value='<%=userSession.getAddress1().trim()%>' name='address1'></td>
					<td>Address 2</td>
					<td><input type='text' class='text' value='<%=userSession.getAddress2().trim()%>' name='address2'></td>
				</tr>
				<tr>
					<td>City</td>
					<td><input type='text' class='text' value='<%=userSession.getCity().trim()%>' name='city'></td>
					<td>State</td>
					<td>
						<input type='hidden' name='tempState' value='<%=userSession.getState().trim()%>'>
						<select name='state'>
							<%=quoteHeader.getPullDownValues(userSession.getCountry(),"*",userSession.getGroup(),"project_state2")%>
						</select>
					</td>
				</tr>
				<tr>
					<td>Telephone</td>
					<td><input type='text' class='text' value='<%=userSession.getTelephone().trim()%>' name='telephone'></td>
					<td>Fax</td>
					<td><input type='text' class='text' value='<%=userSession.getFax().trim()%>' name='fax'></td>
				</tr>
				<tr>
					<td>Email</td>
					<td><input type='text' class='text' value='<%=userSession.getEmail().trim()%>' name='email'></td>
					<td>Zip</td>
					<td><input type='text' class='text' value='<%=userSession.getZip().trim()%>' name='zip'></td>
				</tr>
				<tr>
					<td colspan='4'><hr></td>
				</tr>
				<tr>
					<td colspan='4' align='center'><input type='button' class='button' value='Save' onclick='saveUser()'><input type='button' class='button' value='Close' onclick='cancel()'></td>
				</tr>
			</table>
		</form>
</html>