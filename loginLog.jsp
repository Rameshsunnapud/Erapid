<html><head>
		<script language="Javascript">
			function goHome(){

				var group=document.form1.group.value;
				if(group.toUpperCase().indexOf("REP")==0&&group.toUpperCase().indexOf("REP-DLVR")<0&&group.toUpperCase().indexOf("FE")<=0){
					var URL="/erapid/us/sales.notice/sales.notice.jsp";
					popup=window.open(URL);
				}
				document.location.href=document.form1.url.value;
			}
		</script>
	</head>
	<%@ page language="java" import="java.lang.*" import="java.util.*" import="java.io.*" import="java.sql.*" %>
	<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/>
	<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
	<%

	String username=request.getParameter("username");
	String initialusername=request.getParameter("initialusername");
	String env = request.getParameter("env");
	
	//out.println("::"+username+"::"+initialusername+"::<BR>");
	java.util.Date date = new java.util.Date();
	FileOutputStream p;
	PrintStream out1;
	try{
		File f = new File("d:/erapid/logs/login.log");
		if(! f.exists()){
			p=new FileOutputStream("d:/erapid/logs/login.log");
		}
		else{
			p=new FileOutputStream("d:/erapid/logs/login.log", true);
		}
		out1 = new PrintStream(p);
		out1.println("User :: "+initialusername+"  Logged in as  :: "+username +" [" + date+"]");
		out1.close();
	}
	catch (Exception e){
	    out.println ("Error writing to file" + e);
	}
	userSession.setUserId(username);
	userSession.setEnv(env);
	
	if(erapidBean.getServerName()==null || erapidBean.getServerName().trim().length()==0){
		erapidBean.setServerName("x");
	}
	String countryCode=userSession.getCountry();
	String url=erapidBean.getFullServerName()+"/erapid/";
	if(countryCode.equals("US")){
		url=url+"us/home.jsp";
	}
	//out.println(userSession.getRepNo()+"::<BR>");
	//out.println(url);
	
	//response.setHeader("Set-Cookie", "JSESSIONID567=test; HttpOnly; Secure;SameSite=none;Expires=session")	;

	%>
	<body onload='goHome()'>
		<form name='form1'>
			<input type='hidden' name='username' value='<%=username%>'>
			<input type='hidden' name='url' value='<%=url%>'>
			<input type='hidden' name='group' value='<%=userSession.getGroup()%>'>
		</form>
	</body>
</html>