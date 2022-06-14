<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/>
<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="quoteHeaderBean" class="com.csgroup.general.QuoteHeaderBean" scope="page"/>

<!DOCTYPE html>
<html>
	<head>
		<link rel='stylesheet' href='../css/<%=userSession.getStyleSheet()%>' type='text/css' />
		<link rel='stylesheet' href='../test/datepicker.css' type='text/css' />
		<link href="../test/styles.css" rel="stylesheet" type="text/css">
	</head>
	<%
	//out.println(userSession.getUserId()+":::"+userSession.getCountry()+":: country");
	String colorKey="";
	String bgcolorx="";
	out.println(userSession.getUserId()+":: user id");
	if(userSession.getUserId() != null && userSession.getUserId().trim().length()>0){
		if(pageName.equals("lineitem")){
	%>
	<body bgcolor="silver" onload='isNew()'>
		<%
}
else{
	if(userSession.getGroup().toUpperCase().indexOf("REP")>=0){
		colorKey="<table border='0' width='100%'><tr><td><font color='black' size='1'>QUOTE</font></td><td><font color='#0000EE' size='1'>ORDER</font></td></tr><tr><td colspan='2' ><font color='purple' size='1'>FACTORY QUOTE</font></td></tr></table>";
	}
	else{
		colorKey="<table border='0' width='100%'><tr><td><font color='purple' size='1'>PSA</font></td><td><font color='#00DDDD' size='1'>SALESFORCE</font></td></tr><tr><td><font color='orange' size='1'>WEB STORE</font></td><td><font color='#0000EE' size='1'>ORDER</font></td></tr><tr><td><font color='#GGDD00' size='1'>GE PROFILE</font></td></tr></table>";
	}
	bgcolorx="white";
		%>
	<body bgcolor="silver">
		<%
	}
}
else{
//logger.debug(userSession.getRepNo()+"::"+userSession.getUserId()+":::"+userSession.getUserName());


		%>
	<body bgcolor="silver" onload='userSessionEmpty()'>
		<%
	}
	String message=erapidBean.getMessageUS();
	String messageType=erapidBean.getMessageTypeUS();
	if(messageType.equals("1")){
		message="<font color='white'><b>Tip:</b></font><MARQUEE direction='LEFT' loop='true' scrolldelay='80'><font color='#3ea5ea'><b>"+message+"</b></MARQUEE></font>";
	}
	else if(messageType.equals("2")){
		message="<font color='white'><b>Alert:</b></font><MARQUEE direction='LEFT' loop='true' scrolldelay='80'><font color='red' size='4'><b>"+message+"</b></MARQUEE></font>";
	}
	else if(messageType.equals("3")){
		message="<MARQUEE direction='LEFT' loop='true' scrolldelay='80'><font color='white'><b>"+message+"</b></MARQUEE></font>";
	}
		%>
		<%	if(!userSession.getSalesForceSession()){
		%>
		<div class="header">

			<table width='100%'>
				<tr>
					<td width='30%' align='left'><img src='http://csimages.c-sgroup.com/eRapid/cs_logo.jpg'  height='75'  alt>
					</td>
					<td width='10%' bgcolor='<%=bgcolorx%>'>
						<%=colorKey%>
					</td>
					<td width='60%' align='right'><%= message %>
					</td>
				</tr>

			</table>

		</div>
		<%
}
		String userSecurity=userSession.getUserSecurity().replaceAll("%GROUP%",userSession.getGroup());

		userSecurity=userSecurity.replaceAll("%REPNO%",userSession.getRepNo());
		
		String salesforceUrl = "https://c-sgroup--sit.my.salesforce.com";
		if (userSession.getEnv() != null && userSession.getEnv().equalsIgnoreCase("dev")) {
			salesforceUrl = "https://c-sgroup--dev.my.salesforce.com";
		} else if (userSession.getEnv() != null && userSession.getEnv().equalsIgnoreCase("uat")) {
			salesforceUrl = "https://c-sgroup--uat.my.salesforce.com";
		}
		%>
		<div class="main_menu">
			<ul>
				<%
				if(userSession.getGroup().toUpperCase().indexOf("REP-DLVR")<0){

				%>
				<li><a href="#">Help</a>
					<ul>
						<li><a href='contact_help1.jsp' target='_blank'><span>CONTACTS</span></a></li>
							<%=userSession.getHelpMenu()%>
					</ul>
				</li>
				<li><a href="#" >Tools</a>
					<ul>
						<li><a href="#" onclick='custMaint()' >Customer Maint</a></li>
						<!--<li><a href='userAdmin.jsp' target='_blank'>User Preferences</a></li>-->
							<%=userSecurity%>


					</ul>
				</li>
				<li><a href="#" >Unit Pricing</a>
					<ul>
						<%=userSession.getUnitPrice()%>
					</ul>
				</li>
				<%
			}
				%>
			</ul>
			<ul class="ul2">
				<%
				if(userSession.getSalesForceSession()){
				%>
				<li></li>
				<li></li>
				<li><a href="#" onclick="javascript: window.open('<%=salesforceUrl%>/<%=quoteHeaderBean.getSFDC_QuoteId(userSession.getOrderNo())%>', '_blank')" >Open Salesforce</a></li>
					<%

    }
    else{
					%>
					<li><a href="#" onclick="javascript: window.open('<%=salesforceUrl%>/<%=quoteHeaderBean.getSFDC_QuoteId(userSession.getOrderNo())%>', '_blank')" >Open Salesforce</a></li>
				<li><a href="home.jsp" >Home</a></li>

				<li><a href="../login.html" target="_blank">Exit</a></li>
					<%
	}
					%>
				<li>&nbsp;&nbsp;&nbsp;<%=userSession.getUserName()%>&nbsp;&nbsp;&nbsp;</li>
			</ul>
		</div>

