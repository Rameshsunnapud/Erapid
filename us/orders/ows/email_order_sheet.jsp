<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{


%>

<%@ page language="java" import="java.sql.*" import="java.text.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="../../../db_con.jsp"%>
<%
String sections=request.getParameter("sections");
String product="";
String order_no=request.getParameter("order_no");
String rep_no=request.getParameter("rep_no");
String message="<font color='blue'>"+"Order Write-up sheet"+"</font>";

//HttpSession UserSession1 = request.getSession();
String name=userSession.getUserId();
//out.println(name+":::");

String from="";
ResultSet rs1=stmt.executeQuery("select email from cs_reps where rep_no='"+rep_no+"'");
if(rs1 != null){
	while(rs1.next()){
		from=rs1.getString("email");
	}
}
rs1.close();
stmt.close();
myConn.close();
//out.println("Teh rep"+rep_no);

%>
<html>
	<head>
		<title>Order Sheet Mailing</title>
		<link rel='stylesheet' href='../../../style1.css' type='text/css'/>
		<SCRIPT LANGUAGE="JavaScript">
			function showPopup2(myurl){
				var newWindow;
				var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=yes,location=no,directories=no,width=450,height=350';
				newWindow=window.open(myurl,"Add_from_Src_to_Dest",props);
			}
			// following added by AC to prevent bad email addresses
			function validateEmail(){
				var email=document.selectform.to.value;
				var cc=document.selectform.cc.value;
				var msg="";
				if(cc.length>0){
					if(cc.indexOf(' ')>=0){
						msg=msg+"Spaces not allowed in CC: addresses.";
					}else if(cc.indexOf('@')==-1){
						msg=msg+"Missing @ symbol, example: user@domain.com in CC:";
					}else if(cc.substring(cc.indexOf('@')).indexOf('.')==-1){
						msg=msg+"Missing dot-something, such as .com, .net in CC:";
					}
				}
				if(email.length>0){
					if(email.indexOf(' ')>=0){
						alert("Spaces not allowed in email addresses.");
						return false;
					}else if(email.indexOf('@')==-1){
						alert("Missing @ symbol, example: user@domain.com");
						return false;
					}else if(email.substring(email.indexOf('@')).indexOf('.')==-1){
						alert("Missing dot-something, such as .com, .net");
						return false;
					}else{
						if(msg.length>0){
							alert(msg);
							return false
						}else{
							return true;
						}
					}
				}else{
					if(msg.length>0){
						alert(msg);
						return false;
					}else{
						alert("An email address is required.");
						return false;
					}
				}
			}
		</script>
	</head>
	<body>

		<h1>Mail to::</h1>
		<!-- email attachment try this file email.attach.jsp and also ENCTYPE="multipart/form-data" in the html form tag-->
		<form name="selectform"  action="mail.delivery2.jsp" method="get" onsubmit="return validateEmail()">

			<input type='hidden' name="sections" value="<%= sections %>">
			<input type='hidden' name="rep_no" value="<%= rep_no %>">
			<input type='hidden' name="order_no" value="<%= order_no %>">
			<input type='hidden' name="from" value="<%= from%>">
			<input type='hidden' name="name" value="<%= name%>">
			<table border='0' width='100%'>
				<tr><td class='noheader' align='right'>Mail to:</td>
					<td class='noheader'><input type='text' name="to" value="" class='notext1'></td>
				</tr>
				<tr><td class='header' align='right'>cc:</td>
					<td class='header'><input type='text' name="cc" class='text1'></td>
				</tr>
				<!--
				<tr><td class='noheader' align='right'>Attach file1:</td>
					<td class='noheader'><INPUT TYPE="file" class='notext1' NAME="file1">
					</td>
				</tr>
				<tr><td class='header' align='right'>Attach file2:</td>
					<td class='header'><INPUT TYPE="file" class='text1' NAME="file2"></td>
				</tr> -->
				<tr><td class='noheader' align='right'>Message:</td>
					<td class='noheader'><textarea name='message' cols=30 rows=6></textarea></td>
				</tr>
				<tr><td align='center' colspan='2'>&nbsp;&nbsp;</td></tr>
				<tr><td align='center' colspan='2'><input type='submit' name='Add' value='EMAIL' class='button'></td></tr>
				<tr><td class='noheader' COLSPAN='2' align='right' ><HR></td></tr>
			</table>
		</form>

	</body>
</html>


<%
 }
  catch(Exception e){
  out.println(e);
  }
%>
