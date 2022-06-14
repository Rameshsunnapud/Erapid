<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/>
<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>

<!DOCTYPE html> 
<html>
<head> 
<link rel='stylesheet' href='../css/styleMain.css' type='text/css' />
<link rel='stylesheet' href='../test/datepicker.css' type='text/css' />
</head>
<%
if(pageName.equals("lineitem")){
	%>
	<body bgcolor="silver" onload='isNew()'>
	<%
}
else{
	%>
	<body bgcolor="silver"> 
	<%
}
%>

<div class="header">
<img src='http://csimages.c-sgroup.com/eRapid/cs_logo_poland.jpg'  height='75'  alt>
</div>

<div class="main_menu">
	<ul>
		<li><a href="home.jsp" >Oferta Start</a></li>
		<li><a href="#">Pomoc</a>
			<ul>				
				<%=userSession.getHelpMenu()%>
			</ul>
		</li>
		<li><a href="#" >Maintenance</a>
			<ul>
				<li><a href="#" onclick='custMaint()' >Customer Maint</a></li> 
				<li><a href="#">User Maint</a></li>				
				<li><a href="#">Maint3</a></li>
			</ul>
	    	</li>
	    	<li><a href="../login.html" target="_blank">Wyloguj Si&#281;</a></li>
    	</ul>
		<%=userSession.getUserName()%> &nbsp;
</div>


