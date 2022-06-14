<html><head>
		<script language="Javascript">
			function goHome(){
				
				//alert(document.form1.url.value+"?orderNox="+document.form1.orderNo.value+"&page="+document.form1.page.value+"&userName="+document.form1.username.value);
				document.location.href=document.form1.url.value+"?orderNox="+document.form1.orderNo.value+"&page="+document.form1.page.value
				+"&env="+document.form1.env.value;
				
				
			}
		</script>
	</head>
	<%@ page language="java" import="java.lang.*" import="java.util.*" import="java.io.*"  import="java.sql.*" %>
	<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/>
	<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
	<%
		org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String username=request.getParameter("login");
	String initialusername=request.getParameter("login");
	String orderNo=request.getParameter("order_no");
	String SFDCpage=request.getParameter("page");
	String env="";
	
	if(request.getParameter("env") != null && !request.getParameter("env").isEmpty()){
		 env=request.getParameter("env");
	}
	
	//out.println("env :: "+request.getParameter("env"));
	//out.println(username+"::"+initialusername+"::"+orderNo+"::"+SFDCpage);
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
	//out.println(username+"2::");
	userSession.setUserId(username);
	userSession.setEnv(env);
	userSession.setSalesForceSession(true);
	userSession.setOrderNo(orderNo);
	
	//logger.debug(userSession.getRepNo()+"::"+userSession.getUserId()+":::"+userSession.getUserName());
	if(erapidBean.getServerName()==null || erapidBean.getServerName().trim().length()==0){
		erapidBean.setServerName("x");
	}
	String countryCode=userSession.getCountry();
	String url=erapidBean.getFullServerName()+"/erapid/";
	//if(username.equals("gsuisham")){
	//	url=url+"us/lineItemSFDC.jsp";
	//}
	//else{
		url=url+"us/lineItem.jsp";
	//}
	//out.println(url);

String javaVersion=System.getProperty("java.version");

//if(javaVersion.startsWith("1.7")){
	%>
	<body onload='goHome()'>
		<noscript><FONT COLOR=red SIZE='3'>Your browser does not support JavaScript!  CONTACT ERAPID TEAM IF YOU SEE THIS MESSAGE !!!</FONT></noscript>
		<form name='form1'>
			<input type='hidden' name='username' value='<%=username%>'>
			<input type='hidden' name='url' value='<%=url%>'>
			<input type='hidden' name='page' value='<%=SFDCpage%>'>
			<input type='hidden' name='orderNox' value='<%=orderNo%>'>
			<input type='hidden' name='orderNo' value='<%=orderNo%>'>
			<input type='hidden' name='env' value='<%=env%>'>
		</form>
	</body>
	<%
	/*}
	else{
	out.println("<font color='red' size='5'>YOU NEED JAVA VERSION 7 TO RUN ERAPID");
	out.println("YOUR CURRENT VERSION IS "+javaVersion+"</font>");


	}
	*/
	out.println(userSession.getUserId()+":::"+userSession.getCountry()+":: country"+"::"+javaVersion);
	%>
</html>