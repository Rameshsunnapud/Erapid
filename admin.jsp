<% request.setCharacterEncoding( response.getCharacterEncoding() ); %>

<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.text.*" import="java.io.*" import="java.sql.*" import="java.util.*" import="com.configsc.servlets.*" import="java.io.FileOutputStream" import="java.beans.XMLEncoder" import="java.io.BufferedOutputStream" import="java.math.*" errorPage="error.jsp" %>

<link rel='stylesheet' href='css/stylelogin.css' type='text/css' />
<script language="JavaScript" src="javascript/admin.js"	></script>
<script language="JavaScript" src="javascript/ajax.js"		></script>
<script language="JavaScript" src="javascript/polishCharacters.js"	></script>
<script language="Javascript">
	function hideReps(){
		unhide();
		var selection=document.form1.RepNo.value;
		var listLength=document.getElementById("ulList").getElementsByTagName("li").length;
		for(var i=0;i<listLength;i++){
			var temp=document.getElementById("ulList").children[i].innerHTML
			temp=temp.substring(temp.indexOf("<SPAN>")+6,temp.length);
			temp=temp.substring(0,temp.indexOf("&"));
			var temp2=document.getElementById("ulList").children[i].innerHTML
			temp2=temp2.substring(temp2.indexOf("?username=")+10,temp2.length);
			var tempx=temp2;
			var tempx2=temp2.indexOf("&");
			temp2=temp2.substring(0,temp2.indexOf("&"));

			if(isNaN(selection)){

				temp=temp.substring(0,selection.length);
				temp2=temp2.substring(0,selection.length);
				//alert("HERE");
				//alert(tempx2+"::"+selection+"::"+temp2);
				if(selection.toUpperCase()!=temp.substring(0,selection.length)&&selection.toUpperCase()!=temp2.substring(0,selection.length).toUpperCase()){
					document.getElementById("ulList").children[i].style.display="none";
				}
			}
			else{
				if(isNaN(temp)){
					temp=temp.substring(2,temp.length);
				}
				temp2=temp2.substring(0,selection.length);
				if(selection.toUpperCase()!=temp.substring(0,selection.length)&&selection.toUpperCase()!=temp2.substring(0,selection.length).toUpperCase()){
					document.getElementById("ulList").children[i].style.display="none";
				}

			}
		}
	}
	function hideGroup(){
		unhide();
		var selection=document.form1.userGroup.value;
		if(selection==""){


		}
		else{
			var listLength=document.getElementById("ulList").getElementsByTagName("li").length;

			for(var i=0;i<listLength;i++){
				var temp=document.getElementById("ulList").children[i].innerHTML;
				//alert(temp);
				temp=temp.substring(temp.indexOf("(")+1,temp.length);
				temp=temp.substring(0,temp.indexOf(")"));
				//if(selection=="US"){
				//var temp2=Number(temp);
				if(temp!=selection){
					document.getElementById("ulList").children[i].style.display="none";
				}
				//}
				//else{
				//	var temp2=temp.substring(0,2);
				////	if(temp2!=selection){
				//		document.getElementById("ulList").children[i].style.display="none";
				//	}
				//}
			}
		}
	}
	function unhide(){
		var listLength=document.getElementById("ulList").getElementsByTagName("li").length;
		for(var i=0;i<listLength;i++){
			document.getElementById("ulList").children[i].style.display="block";
		}
	}
</script>
<jsp:useBean id="admin" class="com.csgroup.general.AdminBean"/>
<%

String env=request.getParameter("env");
admin.setEnv(env);

%>
<html>
	<body bgcolor="silver"  onLoad="javascript:setTypes();" >
		<div class="header">
			<img src='http://csimages.c-sgroup.com/eRapid/cs_logo_small.jpg'  height='75'  alt>
		</div>
	<center>
		<div class="mainbody">
			<form name='form1'>
				<input type='hidden' name='urlSaveMessage' value='adminSaveMessage.jsp'>
				<input type='hidden' name='urlErapidBean' value='erapidBean.jsp'>
				<table border='0' width='100%'  cellpadding='0'>
					<tr>
						<td width='40%' align='left' valign='top'>
							<ul class="menu" id='ulList'>
								<%
								out.println(admin.getButtons());
								%>
							</ul>
							<select name='userGroup' id='selectGroup' onchange='hideGroup()'>
								<option value=''></option>
								<%=admin.getGroups()%>
							</select>
							<input type='text' name='RepNo' onkeyup='hideReps()'>

							<input type='hidden' name='messageTypeUSTemp' value='<%=admin.getMessageTypeUS()%>'>

						</td>
						<td bgcolor='white' align='right' valign='top'>
							<table width='100%' border='1'>
								<tr><td colspan='3' align='center' BGCOLOR='#3ea5ea'>MESSAGES</td></tr>

								<tr>
									<td>US MESSAGE:</td>
									<td><input type='text' name='messageUS' value='<%=admin.getMessageUS()%>' class='longtext'></td>
									<td>
										<select name='messageTypeUS'>
											<option value=''></option>
											<option value='1'>Tip</option>
											<option value='2'>Urgent</option>
											<option value='3'>Message</option>
										</select>
									</td>

								</tr>
								<tr>
									<td colspan='3' align='center'>
										<input type='button' class='button' name='save' value='save' onclick='saveMessage()'>
									</td>
								</tr>
							</table><BR><BR><BR>
							<table border='1' width='100%'>
								<tr><td colspan='2' align='center' BGCOLOR='#3ea5ea'>INFO</td></tr>
								<tr>
									<td width='40%'>DATABASE SERVER NAME:</td>
									<td width='60%'><%=admin.getDbServerName()%></td>
								</tr>
								<tr>
									<td>DATABASE PORT:</td>
									<td><%=admin.getDbServerPort()%></td>
								</tr>
								<tr>
									<td>ERAPID DATABASE NAME:</td>
									<td><%=admin.getErapidDB()%></td>
								</tr>
								<tr>
									<td>ERAPID SYSTEM DATABASE NAME:</td>
									<td><%=admin.getErapidSysDB()%></td>
								</tr>
								<tr>
									<td>ERAPID DATABASE USER NAME:</td>
									<td><%=admin.getErapidDBUsername()%></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</center>
</html>