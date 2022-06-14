<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<html>
	<head>
		<title>Work Copy # <%= request.getParameter("q_no") %> </title>
		<link rel='stylesheet' href='style1.css' type='text/css'/>
		<SCRIPT language="JavaScript">
			<!--
		function n_window(theurl)
			{
				// set width and height
				var the_width=450;
				var the_height=400;
				// set window position
				var from_top=180;
				var from_left=460;
				// set other attributes
				var has_toolbar='no';
				var has_location='no';
				var has_directories='no';
				var has_status='yes';
				var has_menubar='yes';
				var has_scrollbars='yes';
				var is_resizable='yes';
				// atrributes put together
				var the_atts='width='+the_width+',height='+the_height+',top='+from_top+',screenY='+from_top+',left='+from_left+',screenX='+from_left;
				the_atts+=',toolbar='+has_toolbar+',location='+has_location+',directories='+has_directories+',status='+has_status;
				the_atts+=',menubar='+has_menubar+',scrollbars='+has_scrollbars+',resizable='+is_resizable;
				// open the window
				window.open(theurl,'',the_atts);
			}
			//-->
		</SCRIPT>
	</head>
	<body>
		<%
				String order_no = request.getParameter("orderNo");//Login id
		%>
		<%@ page language="java" import="java.net.*" import="java.sql.*" import="java.io.*" errorPage="error.jsp" %>
		<%@ include file="../../db_con.jsp"%>
		<%
			String tempPid="";
			ResultSet rs1=stmt.executeQuery("select product_id from cs_project where order_no ='"+order_no+"'");
			if(rs1 != null){
				while(rs1.next()){
					tempPid=rs1.getString(1);
				}
			}
			rs1.close();
//out.println(tempPid+":::HERE");

		if(tempPid.equals("EJC")||tempPid.equals("EJC")){
		%>
		<jsp:forward page="show_summary3.jsp">
			<jsp:param name="order_no" value="<%= order_no %>" />
			<jsp:param name="pid" value="<%= 2 %>" />
		</jsp:forward>
		<%
		}
		else{
		%>
		<jsp:forward page="show_summary.jsp">
			<jsp:param name="order_no" value="<%= order_no %>" />
			<jsp:param name="pid" value="<%= 2 %>" />
		</jsp:forward>
		<%
		}

		}
		catch(Exception e){
		out.println(e);
		}
		%>
	</body>
</html>


