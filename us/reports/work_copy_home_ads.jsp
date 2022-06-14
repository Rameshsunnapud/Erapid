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
				String close=request.getParameter("close");
				if(close==null){
					close="";
				}

		%>
		<%@ page language="java" import="java.net.*" import="java.sql.*" import="java.io.*" errorPage="error.jsp" %>
		<%

		%>
		<jsp:forward page="show_summary2.jsp">
			<jsp:param name="orderNo" value="<%= order_no %>" />
			<jsp:param name="pid" value="<%= 3 %>" />
			<jsp:param name="nowc" value="<%= 1 %>" />
			<jsp:param name="close" value="<%= close %>" />
		</jsp:forward>

		<%

		%>
	</body>
</html>



