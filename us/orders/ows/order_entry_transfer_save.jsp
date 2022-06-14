<%@ page language="java" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" errorPage="error.jsp" %>
<SCRIPT language="JavaScript">
	function n_window2(theurl){
		// set width and height
		//alert(theurl);
		var the_width=450;
		var the_height=400;
		// set window position
		var from_top=300;
		var from_left=300;
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
		myWindowx2=window.open(theurl,'myWindowx2',the_atts);
		setTimeout("checkWindow();",1000);
	}
	function checkWindow(){
		//alert("HERE");
		if(window.myWindowx2){
			if(myWindowx2&&typeof (myWindowx2.closed)!='unknown'&&!myWindowx2.closed){
				setTimeout("checkWindow();",1000);
				//alert("window exists");
			}
			else{
				//alert(document.form1.product_id.value);
				if(document.form1.product_id.value=="ADS"){
					var the_width=100;
					var the_height=100;
					/// set window position
					var from_top=100;
					var from_left=100;
					/// set other attributes
					var has_toolbar='no';
					var has_location='no';
					var has_directories='no';
					var has_status='yes';
					var has_menubar='yes';
					var has_scrollbars='yes';
					var is_resizable='yes';
					/// atrributes put together
					var the_atts='width='+the_width+',height='+the_height+',top='+from_top+',screenY='+from_top+',left='+from_left+',screenX='+from_left;
					the_atts+=',toolbar='+has_toolbar+',location='+has_location+',directories='+has_directories+',status='+has_status;
					the_atts+=',menubar='+has_menubar+',scrollbars='+has_scrollbars+',resizable='+is_resizable;
					/// open the window
					Windows3=window.open(document.form1.workcopyurl.value,'a',the_atts);
				}

				if(document.form1.product_id.value=="IWP"){
					//runoptimizer('test');
				}
				document.location.href=document.form1.url.value;

			}
		}
		else{
			//alert("window doesnt exists");
			document.location.reload();
		}
	}
	function runoptimizer(theurl){
		theurl=document.opt.optimizerurl.value;
		var the_width=450;
		var the_height=400;
		var from_top=300;
		var from_left=300;
		var has_toolbar='no';
		var has_location='no';
		var has_directories='no';
		var has_status='no';
		var has_menubar='no';
		var has_scrollbars='no';
		var is_resizable='no';
		var the_atts='width='+the_width+',height='+the_height+',top='+from_top+',screenY='+from_top+',left='+from_left+',screenX='+from_left;
		the_atts+=',toolbar='+has_toolbar+',location='+has_location+',directories='+has_directories+',status='+has_status;
		the_atts+=',menubar='+has_menubar+',scrollbars='+has_scrollbars+',resizable='+is_resizable;
		// open the window
		gregx=window.open(theurl,'gregx',the_atts);
		setTimeout("checkWindow2();",1000);
	}
	function checkWindow2(){
		if(window.gregx){
		if(gregx&&typeof (gregx.closed)!='unknown'&&!gregx.closed){
		setTimeout("checkWindow2();",1000);
		}
		else{
		alert("done"+sysgchurl);
			   n_window2(document.form1.sysgchurl.value);
		}
		}
		else{
		setTimeout("checkWindow2();",1000);
			   //document.location.reload();
		}
	}
</script>
<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
	   erapidBean.setServerName("server1");
}
try{

// REUQEST objects
	String quote_type="";
	String order_no = request.getParameter("order_no");//
	String fp= request.getParameter("fp");
	//out.println(order_no+":: order_no");
	String cmd = request.getParameter("cmd");//what page
	String rep_no = request.getParameter("id");//rep_no
	String ship_date=request.getParameter("ship_date");
	String order_status = request.getParameter("order_status");//rep_no
	String order_status_value = request.getParameter("order_status_value");//rep_no
	//out.println(order_status+"Test value"+order_status_value);
	if(order_status_value==null||order_status_value.trim().length()<=0){
	}else{
		if (order_status==null||order_status.trim().length()<=0){
			order_status=order_status_value;
		}
	}


%>
<form name='opt'>
	<input type='hidden' name='optimizerurl' value='http://lebhq-opt.c-sgroup.com/optimizer/optimizer_line_init.jsp?order_no=<%=order_no%>'>
</form>
<%@ include file="../../../db_con.jsp"%>
<%
myConn.setAutoCommit(false);
int order_status_count=0;
//for getting the order status
ResultSet rs = stmt.executeQuery("SELECT count(*) FROM cs_order_info where order_no = '"+order_no+"'");
if (rs !=null) {
	while (rs.next()) {
		order_status_count= rs.getInt(1);
	}
}
rs.close();
ResultSet rsproject=stmt.executeQuery("select quote_type from cs_project where order_no='"+order_no+"'");
if(rsproject !=null){
	while(rsproject.next()){
		quote_type=rsproject.getString(1);
	}
}
rsproject.close();
if(quote_type ==null){
	quote_type="";
}
if(order_status_count>0){
	//out.println("updating");
		try{
			String insert="update cs_order_info set order_status=? where order_no=?";
			PreparedStatement update_project=myConn.prepareStatement(insert);
			update_project.setString(1,order_status);
			update_project.setString(2,order_no);
			int c=update_project.executeUpdate();
			update_project.close();
		}
		catch(java.sql.SQLException e)
		{
			out.println("Problem updating the cs_order_info table<BR>");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}
}else{
	//out.println("insert");
			try	{
				String insert ="INSERT INTO cs_order_info(order_no,order_status)VALUES(?,?) ";
				PreparedStatement update_customer = myConn.prepareStatement(insert);
						update_customer.setString(1,order_no);
						update_customer.setString(2,order_status);
						int rocount = update_customer.executeUpdate();
						update_customer.close();
				}
				catch (java.sql.SQLException e)
				{
					out.println("Problem with ENTERING data TO order info TABLEs"+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					myConn.rollback();
					out.println(e.toString());
					return;
				}
}
	myConn.commit();
	// getting from project
	String product_id="";
		ResultSet rs1 = stmt.executeQuery("SELECT product_id FROM cs_project where order_no = '"+order_no+"'");
		if (rs1 !=null) {
		while (rs1.next()) {
			product_id= rs1.getString("product_id");
			}
		}
		rs1.close();





		if(!ship_date.equals("na")){
			int countdate=0;
			ResultSet rs00=stmt.executeQuery("select count(*) from shipping where order_no='"+order_no+"'");
			if(rs00 != null){
				while(rs00.next()){
					countdate=rs00.getInt(1);
				}
			}
			rs00.close();
			if(countdate>0){
				try{
					java.sql.PreparedStatement ps=myConn.prepareStatement("UPDATE shipping SET request_date =? WHERE Order_no =? ");
					ps.setString(1,ship_date);
					ps.setString(2,order_no);
					int re=ps.executeUpdate();
					ps.close();
				}
				catch (java.sql.SQLException e){
					out.println("Problem with updating shipping"+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					myConn.rollback();
					out.println(e.toString());
					return;
				}
				myConn.commit();
			}
			else{
				try{
					int nrows= stmt.executeUpdate("INSERT INTO shipping (order_no,request_date) VALUES('"+order_no+"','"+ship_date+"')");
				}
				catch (java.sql.SQLException e){;
					out.println("Problem with ENTERING TO shipping"+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					myConn.rollback();
					out.println(e.toString());
					return;
				}
				myConn.commit();
			}
		}







		stmt.close();
		myConn.close();



//naviagtion and forwarding
String name=userSession.getUserId();
String session_rep_no= userSession.getRepNo();
String usergroup= userSession.getGroup();
//out.println(product_id+"::<BR>");
//out.println(name+"::"+session_rep_no+":: IN ORDER SAVE PAGE"+usergroup);
if(product_id.equals("EJC")|product_id.equals("IWP")|product_id.equals("EFS")|product_id.equals("ADS")|( product_id.equals("GE")&(!usergroup.toUpperCase().startsWith("REP")) )){

if(!fp.equals("rp")){

%>
<body onload="javascript:n_window2('https://cpqdev.c-sgroup.com/cse/cfglauncher?cmd=CI&csc=true&qt=L&cwf=true&readonly=true&revision=1&username=<%=userSession.getUserId()%>&pid=SYS_GCH&orderno=<%=order_no%>&item_no=1000&doc_type=O&detail1=DATA|ORDER|<%=order_no%>&detail2=DATA|TYPE|OU&detail3=DATA|PID|<%=product_id%>&canurl=http://<%=application.getInitParameter("HOST")%>/erapid/us/orders/ows/order_entry_transfer_navigator.jsp&returl=http://<%=application.getInitParameter("HOST")%>/erapid/us/lineItem.jsp')">
	<%
}
else{  
	%>


<body onload=window.location='https://cpqdev.c-sgroup.com/cse/cfglauncher?cmd=CI&csc=true&qt=L&readonly=true&revision=1&username=<%=userSession.getUserId()%>&pid=SYS_GCH&orderno=<%=order_no%>&item_no=1000&doc_type=O&detail1=DATA|ORDER|<%=order_no%>&detail2=DATA|TYPE|OU&detail3=DATA|PID|<%=product_id%>&canurl=http://<%=application.getInitParameter("HOST")%>/erapid/us/orders/ows/order_entry_transfer_navigator.jsp&returl=http://<%=application.getInitParameter("HOST")%>/erapid/us/orders/ows/order_entry_transfer_navigator.jsp'>

	<%
	}
	%>


	<form name='form1'>
		<input type='hidden' name='product_id' value='<%=product_id%>'>
	<!--	<input type='hidden' name='sysgchurl' value='https://<%=application.getInitParameter("HOST")%>/cse/cse?cmd=CI&csc=true&readonly=true&revision=1&username=<%=userSession.getUserId()%>&pid=SYS_GCH&order_no=<%=order_no%>&item_no=1000&doc_type=O&detail1=DATA|ORDER|<%=order_no%>&detail2=DATA|TYPE|OU&detail3=DATA|PID|<%=product_id%>&canurl=http://<%=application.getInitParameter("HOST")%>/erapid/us/orders/ows/order_entry_transfer_navigator.jsp&returl=http://<%=application.getInitParameter("HOST")%>/erapid/us/lineItem.jsp')">
		-->
		<input type='hidden' name='optimizerurl' value='http://lebhq-opt.c-sgroup.com/optimizer/optimizer_line_init.jsp?order_no=<%=order_no%>'>
		<input type='hidden' name='url' value='https://<%=application.getInitParameter("HOST")%>/erapid/us/orders/ows/order_entry_transfer_navigator.jsp?order_no=<%=order_no%>'>
		<input type='hidden' name='workcopyurl' value='https://<%=application.getInitParameter("HOST")%>/erapid/us/reports/work_copy_home_ads_wrapper.jsp?q_no=<%=order_no%>&pid=3&tp=0'>
		<FONT SIZE='3' COLOR='RED'><B><%=application.getInitParameter("HOST")%> PROCESSING... PLEASE WAIT...  DO NOT CLOSE THIS WINDOW...</B></FONT>
	</form>
</body>
<%

}else{

%>
<jsp:forward page="order_transfer.jsp">
	<jsp:param name="order_no" value="<%= order_no %>" />
	<jsp:param name="cmd" value="<%= cmd %>" />
	<jsp:param name="id" value="<%=  rep_no %>" />
</jsp:forward>
<%

}

}
catch(Exception e){
out.println(e);
}
%>

