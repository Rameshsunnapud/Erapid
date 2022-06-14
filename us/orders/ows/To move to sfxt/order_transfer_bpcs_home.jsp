<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="validation" 		class="com.csgroup.general.ValidationBean" 		scope="page"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<html>
	<head>
		<title>Order Transfer # <%= request.getParameter("q_no") %> </title>
		<link rel='stylesheet' href='style1.css' type='text/css'/>
		<SCRIPT language="JavaScript">
			<!--
		function n_window(theurl){
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
			function goBackToOWS(){
				alert("BPCS ORDER IS CLOSED.  Your can not add to this order.  You must change the order type on page1 of the ows and try again.");
				window.close();
			}
			//-->
		</SCRIPT>
	</head>

	<%
			String order = request.getParameter("order");
			String sections = request.getParameter("sections");
			String rep_no=request.getParameter("rep_no");
			String product="";
String bpcs_order_no="";
boolean isBpcsClosed=false;
boolean isGood=true;

	%>
	<%@ page language="java" import="java.net.*" import="java.sql.*" import="java.io.*" errorPage="error.jsp" %>
	<%@ include file="../../../db_con.jsp"%>
	<%
		ResultSet rs_project = stmt.executeQuery("SELECT product_id,creator_id,bpcs_order_no FROM cs_project where Order_no like '"+order+"'");
			if (rs_project !=null) {
		   while (rs_project.next()) {
			product= rs_project.getString("product_id");
			bpcs_order_no=rs_project.getString("bpcs_order_no");
									  }
							   }
   if(bpcs_order_no==null){
	bpcs_order_no="";
	}

	if(bpcs_order_no!=null && bpcs_order_no.trim().length()>0){
		isBpcsClosed=validation.checkBpcsOrderClose(bpcs_order_no);
	}
	//out.println(isBpcsClosed);
	if(isBpcsClosed){
		ResultSet rs_billed=stmt.executeQuery("select order_type from cs_billed_customers where order_no='"+order+"'");
		if(rs_billed != null){
			while(rs_billed.next()){
				if(rs_billed.getString(1).toUpperCase().startsWith("ADD")){
					isGood=false;
				}
			}
		}
		rs_billed.close();
	}


	myConn.setAutoCommit(false);
	java.util.Date datex = new java.util.Date();
	String date=(datex.getMonth()+1)+"/"+datex.getDate()+"/"+(datex.getYear()+1900);
	//Statement stmt=myConn.createStatement();
	//out.println(doc_type+"::<BR>");
	String doc_type_old="";
	String doc_salesperson="";
	String doc_customer="";
	String doc_status="";
	String ship_date="";
	String valid_price="";
	String sales_office="";
	//String discount_factor="";
	String doc_priority="";
	String total_quantity="";
	String need_change="";
	String po_date="";
	String dm_complete="";
	String doc_date="";
	String status="";
	String bid_date="";
	String expire="";
	String order_entry_indicator="";

	ResultSet rsDoc=stmt.executeQuery("Select * from doc_header where doc_number='"+order+"'");
	if(rsDoc != null){
		while(rsDoc.next()){
			doc_type_old=rsDoc.getString("doc_type");
			doc_salesperson=rsDoc.getString("doc_salesperson");
			doc_customer=rsDoc.getString("doc_customer");
			doc_status=rsDoc.getString("win_loss");
			ship_date=rsDoc.getString("ship_date");
			if(ship_date == null){
				ship_date=""+date;
			}
			sales_office=rsDoc.getString("doc_office");
			doc_priority=rsDoc.getString("doc_priority");
			po_date=rsDoc.getString("po_date");
			if(po_date == null){
				po_date=""+date;
			}
			doc_date=rsDoc.getString("doc_date");
			status=rsDoc.getString("win_loss");
			bid_date=rsDoc.getString("entry_date");
			expire=rsDoc.getString("expires_date");
			order_entry_indicator=rsDoc.getString("doc_date");
			if(doc_date == null){
				doc_date=""+date;
			}
			if(bid_date == null){
				bid_date=""+date;
			}
			if(expire == null){
				expire=""+date;
			}
			dm_complete=rsDoc.getString("dm_complete");
		}
	}
	rsDoc.close();

	myConn.setAutoCommit(false);
	if(!doc_type_old.equals("O")){
		String doc_typex="O";
			try{
				int nrows= stmt.executeUpdate("INSERT INTO doc_header (doc_salesperson,doc_customer,doc_status,ship_date,doc_office,doc_priority,po_date,dm_complete,doc_number,doc_revision,doc_type,doc_date,win_loss,entry_date,expires_date,doc_stage) VALUES('"+doc_salesperson+"','"+doc_customer+"','"+doc_status+"','"+ship_date+"','"+sales_office+"','"+doc_priority+"','"+po_date+"','"+dm_complete+"','"+order+"','1','"+doc_typex+"','"+doc_date+"','"+status+"','"+bid_date+"','"+expire+"','"+order_entry_indicator+"')");
		
				java.sql.PreparedStatement update_docLine = myConn.prepareStatement("UPDATE doc_line set doc_type= ? where doc_number= ? and doc_revision='1' ");
				update_docLine.setString(1,doc_typex);
				update_docLine.setString(2,order);
				int roCount2=update_docLine.executeUpdate();			
				int result1=stmt.executeUpdate("delete from doc_header where doc_number='"+order+"' and doc_revision='1' and doc_type='"+doc_type_old+"'");
			}
			catch (java.sql.SQLException e)
			{
				out.println("Problem with deleting from doc_header"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				System.exit(0);
				return;
		}

	}









	myConn.commit();

	rs_project.close();
	stmt.close();
	myConn.close();
	%>
	<%
	//out.println("HERE");
if(isGood){
//out.println("is good");

	if(product.equals("EFS")){
	%>
	<jsp:forward page="order_transfer_bpcs.jsp">
		<jsp:param name="order" value="<%= order %>" />
		<jsp:param name="sections" value="<%= sections%>" />
		<jsp:param name="rep_no" value="<%= rep_no %>" />
		<jsp:param name="doc_priority" value="<%= doc_priority %>" />
	</jsp:forward>
	<%
	}

	else if(product.equals("IWP")){
	%>
	<SCRIPT language="JavaScript">alert('In order transfer bpcs home page IWP condition');</script>
	<jsp:forward page="order_transfer_bpcs_iwp.jsp">
		<jsp:param name="order" value="<%= order %>" />
		<jsp:param name="sections" value="<%= sections%>" />
		<jsp:param name="rep_no" value="<%= rep_no %>" />
		<jsp:param name="doc_priority" value="<%= doc_priority %>" />
	</jsp:forward>
	<%
	}

	else if(product.equals("EJC")){
	%>
	<jsp:forward page="order_transfer_bpcs_ejc.jsp">
		<jsp:param name="order" value="<%= order %>" />
		<jsp:param name="sections" value="<%= sections%>" />
		<jsp:param name="rep_no" value="<%= rep_no %>" />
		<jsp:param name="doc_priority" value="<%= doc_priority %>" />
	</jsp:forward>
	<%
	}

	else if(product.equals("LVR")){
	%>
	<jsp:forward page="order_transfer_bpcs_lvr.jsp">
		<jsp:param name="order" value="<%= order %>" />
		<jsp:param name="sections" value="<%= sections%>" />
		<jsp:param name="rep_no" value="<%= rep_no %>" />
		<jsp:param name="doc_priority" value="<%= doc_priority %>" />
	</jsp:forward>
	<%
	}
	else if(product.equals("GE")){

	%>
	<jsp:forward page="order_transfer_bpcs_ge.jsp">
		<jsp:param name="order" value="<%= order %>" />
		<jsp:param name="sections" value="<%= sections%>" />
		<jsp:param name="rep_no" value="<%= rep_no %>" />
		<jsp:param name="doc_priority" value="<%= doc_priority %>" />
	</jsp:forward>
	<%
}
else if(product.equals("ADS")){
	%>
	<jsp:forward page="order_transfer_bpcs_ads.jsp">
		<jsp:param name="order" value="<%= order %>" />
		<jsp:param name="sections" value="<%= sections%>" />
		<jsp:param name="rep_no" value="<%= rep_no %>" />
		<jsp:param name="doc_priority" value="<%= doc_priority %>" />
	</jsp:forward>
	<%
}
else if(product.equals("GCP")){
	%>
	<jsp:forward page="order_transfer_bpcs_gcp.jsp">
		<jsp:param name="order" value="<%= order %>" />
		<jsp:param name="sections" value="<%= sections%>" />
		<jsp:param name="rep_no" value="<%= rep_no %>" />
		<jsp:param name="doc_priority" value="<%= doc_priority %>" />
	</jsp:forward>
	<%
	}

}
else{
	%>
	<body onload="goBackToOWS()">
		<%
	}
			}
			catch(Exception e){
			out.println(e);
			}
		%>
	</body>
</html>














































