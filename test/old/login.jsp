<html><head>
<title>CS-Login</title>
<link rel='stylesheet' href='style1.css' type='text/css' />

 

<body topmargin="0" leftmargin="0" class="scrollbar">
<table border="0" width="658" cellpadding="0" cellspacing="0" bgcolor="whitesmoke" height="152">

<%@ page language="java" import="java.text.*" import="java.net.*" import="java.io.*" import="java.sql.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="db_con.jsp"%>        
<%//@ include file="dbcon1.jsp"%>
<%//@ include file="quoteClose.jsp"%>
<script language="Javascript">
function goToServer(){
		var url="serverStatus.jsp?cmd="+document.tableForm.userId.value;
		window.open(url, "_self", "location=0");
}
function goHere(){ 
	if(document.adminLoginForm.goToButtons.checked){
		document.location="login.jsp?userNAMEcs="+document.adminLoginForm.login.value
	}
	else{
		document.location="loginLog.jsp?login="+document.adminLoginForm.login.value
	}

}
function goHere2(myurl){
	var newWindow;     
	//var myurl2; 
	//myurl2=""+myurl;    
	var props = 'scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=800,height=600';
	newWindow = window.open(myurl, "Add_from_Src_to_Dest", props);
}
//function init(){
	this.moveTo(0, 0);
//	this.resizeTo(screen.width, screen.height);
//}
</script>
<%
/*
String ccodeold="";
	int height=30;
	String reps[]=new String[100];
	int x=0;
	boolean test=true;
	boolean grande=false;
boolean developer =  false;
	String userName=request.getParameter("userNAMEcs");
if(userName == null || userName.equals("null")){
	userName="";
}

	//session.invalidate();
	if(request.getSession()!=null){

		HttpSession UserSession=request.getSession();
		String nullx=null; 
		UserSession.removeAttribute("username");
		if(UserSession.getAttribute("country_code")!=null){
      ccodeold=UserSession.getAttribute("country_code").toString();;
      if(ccodeold==null){
        ccodeold="";
      }
      //out.println(ccodeold+"<BR>");
		}

	} 
 	String groupName="";
 	
 	String queryCommonUsers="Select Distinct rep_no,group_id from logia_users where user_name = (Select user_name from logia_users where  user_id = '"+userName+"') order by rep_no";
 	if(ccodeold != null && ccodeold.trim().length()>0){
    queryCommonUsers="Select Distinct rep_no,group_id from logia_users where user_name = (Select user_name from logia_users where  user_id = '"+userName+"') and country_code ='"+ccodeold+"' order by rep_no";
 	}
 	
 	
	ResultSet commonUsers= stmts.executeQuery(queryCommonUsers);
	String groups="";
	
	//populated rep array
	if (commonUsers != null){
		while(commonUsers.next()){
			groupName=groupName+commonUsers.getString("group_id");

		     reps[x]=commonUsers.getString("rep_no");
			//if(commonUsers.getString(2).equals("Austria")){
			//	groups=groups+"'AT_REP'"+",";
			//}	
			//if(commonUsers.getString(2).equals("Germany")){
			//	groups=groups+"'GERMAN_REP'"+",";
			//}
			//if(commonUsers.getString(2).equals("Poland")){
			//	groups=groups+"'POLISH_REP'"+",";
			//}	
		     if(reps[x]==null && test){
				out.println("You do not have a Rep number. Please contact the System Administrator");
				test=false;
		     }
		     x++;
		}
	}
if(groups != null && groups.trim().length()>0){
	groups=groups.substring(0,groups.length()-1);
}
else{
	groups="''";
}
//out.println(groups);

	// searchs if rep is grande entrance
        ResultSet grandEnt= stmts.executeQuery("Select group_id from logia_users where  user_id = '"+userName+"'");
		while(grandEnt.next() && !grande){
		    	if(grandEnt.getString("group_id").equals("GrandE")){
				grande=true;
		    	}

		    	if(grandEnt.getString("group_id").equals("super")||grandEnt.getString("group_id").equals("Develop")||grandEnt.getString("group_id").equals("Admins")||grandEnt.getString("group_id").equals("UK-DEVELOP")||grandEnt.getString("group_id").equals("admins")){
		    		developer=true;
							    //out.println(grandEnt.getString("group_id")+"<---x<BR>");
		    	}
		 }


	//if grand enterance then repopulate rep array with ge users
	if(grande){
		x=0;
		ResultSet grandeUsers=stmts.executeQuery("Select Rep_no from logia_users where group_id ='grande' order by user_name");
		if(grandeUsers != null){
	        	while(grandeUsers.next()){
				reps[x]=grandeUsers.getString("rep_no");
				x++;
				height=19;
			}
		}

	}

// prints table
//out.println(groupName+"::<BR>");
if(groupName.indexOf("Poland")>=0 || groupName.indexOf("POLISH_REP")>=0){

%>

    <tr>

<td align="center" vAlign="top" height="26" width="541" bgcolor="#FFFFFF" bordercolor="#FFFFFF" colspan="5"><H1>&nbsp; ERAPID - SYSTEM DO OFERTOWANIA </H1></td>
</tr>
<tr>

<td align="center" vAlign="top" height="148" width="541" colspan="5"  >
        <FORM action= "loginLog.jsp" method=GEt name=webLoginFrm>

	<b>Prosz&#281; klikn&#261;&#263; na Identyfikatorze: </b><br><br>
<%
}

else if(groupName.indexOf("Germany")>=0 || groupName.indexOf("GERMAN_REP")>=0 || groupName.indexOf("Austria")>=0 || groupName.indexOf("AT_REP")>=0){



%>

    <tr>

<td align="center" vAlign="top" height="26" width="541" bgcolor="#FFFFFF" bordercolor="#FFFFFF" colspan="5"><H1>&nbsp; ERAPID ANGEBOTSPROGRAMM </H1></td>
</tr>
<tr>

<td align="center" vAlign="top" height="148" width="541" colspan="5"  >
        <FORM action= "loginLog.jsp" method=GEt name=webLoginFrm>

	<b>Bitte klicken Sie auf Identifikation : </b><br><br>
<%
}
else{
%>

    <tr>

<td align="center" vAlign="top" height="26" width="541" bgcolor="#FFFFFF" bordercolor="#FFFFFF" colspan="5"><H1>&nbsp; ERAPID QUOTE SYSTEM</H1></td>
</tr>
<tr>

<td align="center" vAlign="top" height="148" width="541" colspan="5"  >
        <FORM action= "loginLog.jsp" method=GEt name=webLoginFrm>

	<b>Please Click on Desired User ID:</b><br><br>
<%

}

   if(test){
	if(groupName.indexOf("Poland")>=0 || groupName.indexOf("POLISH_REP")>=0){
		out.println("<input type='hidden' name='user' value="+userName+">");
		out.println("<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'><tr height='20'>");
		out.println("<td valign='top' align='center' width='33%' nowrap><b>PH - Numer</b></td>");
		out.println("<td valign='top' align='center' width='33%' nowrap><b>U&#378;ytkownik</b></td>");
		out.println("<td valign='top' align='center' width='33%' nowrap><b>Identyfikator</b></td>");
		//out.println("<td valign='top' align='center' width='25%' nowrap>Identyfikator</td>");
	}
	else if(groupName.indexOf("Germany")>=0 || groupName.indexOf("GERMAN_REP")>=0 || groupName.indexOf("Austria")>=0 || groupName.indexOf("AT_REP")>=0){
		out.println("<input type='hidden' name='user' value="+userName+">");
		out.println("<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'><tr height='20'>");
		out.println("<td valign='top' align='center' width='33%' nowrap><b>ADM Nr</b></td>");
		out.println("<td valign='top' align='center' width='33%' nowrap><b>Benutzer</b></td>");
		out.println("<td valign='top' align='center' width='33%' nowrap><b>Identifikation</b></td>");
		//out.println("<td valign='top' align='center' width='25%' nowrap>Identyfikator</td>");
	}
	else{
			out.println("<input type='hidden' name='user' value="+userName+">");
		out.println("<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'><tr height='20'>");
		out.println("<td valign='top' align='center' width='33%' nowrap><b>Rep#</b></td>");
		out.println("<td valign='top' align='center' width='33%' nowrap><b>User Name</b></td>");
		out.println("<td valign='top' align='center' width='33%' nowrap><b>User ID</b></td>");
		//out.println("<td valign='top' align='center' width='25%' nowrap>Identyfikator</td>");
	}
	out.println("<input type='hidden' name='group' value=''>");

	for(int i=0; i<=x; i++){
		ResultSet repUsers=stmts.executeQuery("Select Rep_no, user_name, user_id,group_id from logia_users where rep_no='"+reps[i]+"' order by user_name");
		if(repUsers != null){
			while(repUsers.next()){
				out.println("<tr><td valign='top' align='center' width='33%' nowrap>"+repUsers.getString(1)+"</td><td valign='top' align='center' width='33%' nowrap>"+repUsers.getString(2)+"</td>");//+"</td><td valign='top' align='center' width='25%' nowrap>"+repUsers.getString(3)+"</td>");
				out.println("<td valign='top' align='center' width='33%' nowrap>");
				out.println("<input type='submit' name='login' value='"+repUsers.getString(3)+"' class='button' style='width:150;height:"+height+"'");
				//out.println("onclick='document.webLoginFrm.login="+repUsers.getString(3)+"' ");
				//out.println("onclick='document.webLoginFrm.group="+repUsers.getString(4)+"' ");
				out.println("></td></tr>");
				//out.println("</tr>");
			}
		}
		repUsers.close();


	}

   }
   
	if(groups.trim().length()>2){
		ResultSet repUsers2=stmts.executeQuery("Select Rep_no, user_name, user_id, group_id from logia_users where group_id in ("+groups+") order by group_id,user_name");
		if(repUsers2 != null){
			while(repUsers2.next()){
				out.println("<tr><td valign='top' align='center' width='33%' nowrap>"+repUsers2.getString(1)+"</td><td valign='top' align='center' width='33%' nowrap>"+repUsers2.getString(2)+"</td>");//+"</td><td valign='top' align='center' width='25%' nowrap>"+repUsers2.getString(3)+"</td>");
				out.println("<td valign='top' align='center' width='33%' nowrap>");
				out.println("<input type='submit' name='login' value='"+repUsers2.getString(3)+"' class='button' style='width:150;height:"+height+"'");
				//out.println("onclick='document.webLoginFrm.login="+repUsers2.getString(3)+"'");
				//out.println("onclick='document.webLoginFrm.group="+repUsers2.getString(4)+"' ");
				out.println("></td></tr>");
				//out.println("</tr>");
			}
		}


		repUsers2.close();
		if(groups.indexOf("AT_REP")>=0 || groups.indexOf("GERMAN_REP")>=0){
			out.println("<tr><td colspan='3'><font color='red'><b>To log in as a different user, please close all opened erapid screens and log in from the Citrix desktop.</b></font></td></tr>");
		}
		if(groups.indexOf("POLISH_REP")>=0){
			out.println("<tr><td colspan='3'><font color='red'><b>Aby zalogowa&#263; si&#281; jako inny u&#380;ytkownik, musisz kompletnie zamkn&#261;&#263; wszystkie ekrany erapid i powr&#243;ci&#263; do pulpitu CITRIX</b></font></td></tr>");
		}
	}
	out.println("</table>");
   
%>
           </FORM>

      </td>
</tr>
<!--<tr>
      <td align="left" vAlign="bottom" height="148" width="122"  rowspan="1"> <img src="csgroup_smlogo.jpg"></td>
	  <td align="left" vAlign="bottom" height="148" width="122"  rowspan="1"> <img src="csgroup_smlogo.jpg"></td>
        <td align="left" vAlign="bottom" height="148" width="122"  rowspan="1"> <img src="csgroup_smlogo.jpg"></td>
</tr>-->
</table>



</BODY>
</HTML>

<%


if(developer || userName.equals("szabiega") ){
	%><BR>
	<h1> ADMIN LOGIN </h1>

 	<FORM method=GEt name=adminLoginForm> 
	<input type='hidden' name='login' value=''>
	<input type='checkbox' name='goToButtons'>Show Buttons<BR>
	<%
	
	out.println("<input type='hidden' name='user' value="+userName+">");
	out.println("<select name='test' onchange='document.adminLoginForm.login.value=this.options[this.selectedIndex].value'>");
	out.println("<option value=''></option>");
	
	ResultSet repUsers=stmts.executeQuery("Select Rep_no, user_name, user_id from logia_users where country_code in ('AT','DE','PL','GB','FR','US','SG','AE') and not rep_no is null order by user_id,rep_no ");
	
	if(repUsers != null){
		while(repUsers.next()){
			%>
			<option value='<%=repUsers.getString(3)%>' ><%=repUsers.getString(3)%>&nbsp;&nbsp;-&nbsp;&nbsp;<%=repUsers.getString(1)%></option>
			<%
		}
	}
	repUsers.close();
	
	%>
	</select>
	<input type='button' class='button' value='go' onclick="goHere()">
	</form>
	<a href="javascript:goHere2('rqs_message_center.jsp')">RQS MESSAGE</a><br>
	<a href="javascript:goHere2('quote_user_change.jsp')">Quote User Change</a>
	<%

}

stmt.close();
stmts.close();
myConn.close();
myConns.close();
*/
%>


