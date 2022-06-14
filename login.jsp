
<link rel='stylesheet' href='css/stylelogin.css' type='text/css' />
<script language="Javascript">
	try{
		//alert(document.form.x.value);
		function hide(x){
			//alert("here");
			//alert(x);
			var count=0;
			while(x.length>0){
				count++;
				var temp=x.substring(0,x.indexOf(","));
				//	alert(temp);
				x=x.substring(x.indexOf(",")+1);
				document.getElementById("ulList").children[temp].style.display="none";
				if(count>100){
					x="";
				}

			}
			document.getElementById("HIDE").style.display="none";
			document.getElementById("UNHIDE").style.display="block";
		}

		function unhide(){
			var listLength=document.getElementById("ulList").getElementsByTagName("li").length;
			for(var i=0;i<listLength;i++){
				document.getElementById("ulList").children[i].style.display="block";
			}
			document.getElementById("UNHIDE").style.display="none";
			document.getElementById("HIDE").style.display="block";
		}
	}
	catch(err){
		alert("CONTACT ERAPID TEAM:::JAVASCRIPT ERROR"+err.message);
	}
</script>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/>
<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" import="com.configsc.servlets.*" import="java.io.FileOutputStream" import="java.beans.XMLEncoder" import="java.io.BufferedOutputStream" import="java.math.*" errorPage="error.jsp" %>
<jsp:useBean id="buttons" class="com.csgroup.general.LoginBean"/>
<html>

	<%
String javaVersion=System.getProperty("java.version");
//out.println(javaVersion);
if(javaVersion.startsWith("1.7") || javaVersion.startsWith("1.8")){

		String repNumber=userSession.getRepNo();
		String userName=request.getParameter("userNAMEcs");
		String env=request.getParameter("env");
		
		buttons.setUserName(userName);
		buttons.setEnv(env);
		String buttonlist=buttons.getButtons();
		//out.println(buttonlist);
		//out.println(buttons.getHide());
		String isAdmin=buttons.getAdmin();

	%>
	<body bgcolor="silver" onload='hide("<%=buttons.getHide() %>")' >
		<div class="header">
			<img src='https://csimages.c-sgroup.com/eRapid/cs_logo_small.jpg'  height='75'  alt>


		</div>
	<center>

		<div class="mainbody">
			<ul class="menu" id='ulList'>
				<%
				out.println(buttonlist);
				%>
			</ul>
			<a onclick='unhide()' id='UNHIDE'><img src='images/plus.png' height='25'>SHOW ALL USERS</a>
			<a onclick='hide("<%=buttons.getHide() %>")' id='HIDE'><img src='images/minus.png' height='25'>HIDE OTHER USERS</a>
		</div>
		<%

	    if(isAdmin.equals("true")){

		%>
		<a href='admin.jsp?env=<%=env%>'><img src='images/admin_icon.png'  height='75'  alt></a>
		<//@ include file="admin.jsp"%>
		<%
	}
		%>

	</center>
	<%
}
else{
	out.println("<font color='red' size='5'>YOU NEED JAVA VERSION 7 or 8 TO RUN ERAPID");
	out.println("YOUR CURRENT VERSION IS "+javaVersion+"</font>");


}

//response.setHeader("Set-Cookie", "JSESSIONID567=test; HttpOnly; Secure;SameSite=none;Expires=session")	;	
	%>
	<!--<iframe height='1' width='1' border='0' src="http://"+application.getInitParameter("HOST")+"/cse/web/jsp/custom_interface/killSession.jsp">kill session</iframe>-->
</body>
</html>