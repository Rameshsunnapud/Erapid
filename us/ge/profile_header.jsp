<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>

<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<HTML>
	<HEAD>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<SCRIPT LANGUAGE="JavaScript">
			<!-- Begin
		function writerep(){
				var url="edit_delete_home.jsp?cmd=edit&order_no="+document.repform.q_no.value;
				window.opener.document.location=url;
			}
			function createQuote(){
				//alert("HERE");
				var url="../lineItem.jsp?product=GE&qtype=1&altCpyNox="+document.repform.q_no.value;
				window.opener.document.location=url;
				self.close();
			}
			function editLine(c){
				//alert(c.value);
				window.opener.document.location=c.value;
			}
			function toForm(){
				//alert("test ge");
				this.moveTo(0,0);
				this.resizeTo(screen.width,screen.height);
				document.repform.OK.focus();
			}
-->
		</script>
		<TITLE>E-Rapid Remote Quoting System</TITLE>
		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>
	<body OnLoad="toForm();">
		<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con.jsp"%>
		<%@ include file="../../../dbcon1.jsp"%>
		<%@ include file="../../../db_con_psa.jsp"%>
		<%
		String OrderNum=request.getParameter("orderNo");
		String message="Profile";

		String name=request.getParameter("name");

//out.println("Before profile_main");
		%>
		<%@ include file="profile_main.jsp"%>
		<%
		//out.println("After profile_main");
		stmts.close();
		myConns.close();
		stmt.close();
		myConn.close();
		stmt_psa.close();
		myConn_psa.close();

		}
		  catch(Exception e){
			out.println("ERROR::"+e);
		  }
		%>
	</body>
</html>