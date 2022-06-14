<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<%@ page language="java" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" errorPage="error.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
	function popUpx(){
		document.form1x.submit();
	}
</script>
<%
// rEUQEST objects
		String order_no = request.getParameter("order_no");//
		String add_deduct_job = request.getParameter("add_deduct_job");//
		String phone = request.getParameter("phone");//
		String sales_exempt_no  = request.getParameter("sales_exempt_no");//
		String zip_code = request.getParameter("zip_code");//
		String Project_name = request.getParameter("Project_name");//
		String customer_po_no = request.getParameter("customer_po_no");//
		String cs_company = request.getParameter("cs_company");//
		String payment = request.getParameter("payment");//
		String market_type = request.getParameter("market_type");//
		String city = request.getParameter("city");//
		String customer_type = request.getParameter("customer_type");//
		String cust_name1 = request.getParameter("cust_name1");//
		String cust_bpcs_no = request.getParameter("bill_cust_bpcs_no");//
		String cust_bpcs_no_alt = request.getParameter("bill_cust_bpcs_no_alt");//
		String contact_name = request.getParameter("contact_name");//
		String sales_region = request.getParameter("sales_region");//
		String cust_addr2 = request.getParameter("cust_addr2");//
		String cust_addr1 = request.getParameter("cust_addr1");//
		String state = request.getParameter("state");//
		String cust_country = request.getParameter("country");//
//		String expire_date = request.getParameter("expire_date");//
		String Job_loc  = request.getParameter("Job_loc");//
		String fax = request.getParameter("fax");//			String
		String doc_type = request.getParameter("doc_type");//
//		String credit_card_no = request.getParameter("credit_card_no");//
//		String credit_card_name = request.getParameter("credit_card_name");//
		String type_of_cust = request.getParameter("type_of_cust");//	new or old
		String rep_no = request.getParameter("rep_no");//	new or old
		String cust_ship_info = request.getParameter("cust_ship_info");//	new or old
		String cust_invoice_info = request.getParameter("cust_invoice_info");//	new or old
		String end_user_info = request.getParameter("end_user_info");//	new or old
//CS_customers tabel
		String cs_market_type = request.getParameter("eu_market_type");//	new or old
		String eu_cust_name1 = request.getParameter("eu_cust_name1");//	new or old
		String eu_cust_bpcs = request.getParameter("eu_cust_bpcs_no");
		String eu_cust_bpcs_alt = request.getParameter("eu_cust_bpcs_no_alt");//	new or old
		String eu_cust_addr1 = request.getParameter("eu_cust_addr1");//	new or old
		String eu_cust_addr2 = request.getParameter("eu_cust_addr2");//	new or old
		String eu_city = request.getParameter("eu_city");//	new or old
		String eu_state = request.getParameter("eu_state");//	new or old
		String eu_zip_code = request.getParameter("eu_zip_code");//	new or old
		String eu_phone = request.getParameter("eu_phone");//	new or old
		String eu_fax = request.getParameter("eu_fax");//	new or old
		String overage=request.getParameter("overage");
		String billed_email=request.getParameter("billed_email");
		String email_acknowledgement=request.getParameter("email_acknowledgement");

		//out.println(email_acknowledgment+"::<BR>");


		if(billed_email == null){ billed_email="";}
		if(email_acknowledgement==null || email_acknowledgement.equals("null")){
			email_acknowledgement="";
		}

if ((payment==null)|(payment=="")){payment="NET 30 DAYS";}
if (cust_ship_info==null){cust_ship_info="N";}else{cust_ship_info="Y";}
if (cust_invoice_info==null){cust_invoice_info="N";}else{cust_invoice_info="Y";}
if (end_user_info==null){end_user_info="N";}else{end_user_info="Y";}
if(cust_bpcs_no==null || cust_bpcs_no.equals("null")||cust_bpcs_no.equals("")){
	cust_bpcs_no="0";
}
//getting rep_no from the sessions
HttpSession UserSession1 = request.getSession();
String session_rep_no="";
	if(UserSession1.getAttribute("rep_no")==null){
		session_rep_no=rep_no;
	}
	else{
		session_rep_no=UserSession1.getAttribute("rep_no").toString();
	}

%>
<%@ include file="../../../db_con.jsp"%>
<%

// Updating all the project and Billed customer tables
				myConn.setAutoCommit(false);
//
if (type_of_cust.equals("new")){
// Getting the new billed customer number from the
ResultSet rs = stmt.executeQuery("select rec_no from rec_no_control where tablename='billed_customers'");
String cust_no="";int number=0;
while(rs.next())
	{
	 cust_no = rs.getString("rec_no");
	number=Integer.parseInt(cust_no);
	}
	rs.close();
// cs_billed_customers inserting
number++;
	try
	{
		int nrow= stmt.executeUpdate("UPDATE rec_no_control SET rec_no ="+number+" WHERE tablename ='billed_customers'");
	}
	catch (java.sql.SQLException e)
	{
		out.println("Problem with Updating rec_no_control"+"<br>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}
number--;
// Inserting into cs_billed_customers
//out.println(number+"::"+cust_name1+"::"+cust_addr1+"::"+cust_addr2+"::"+city+"::<BR>");
//out.println(state+"::"+zip_code+"::"+phone+"::"+fax+"::"+rep_no+"::<BR>");
//out.println(order_no+"::"+customer_type+"::"+market_type+"::"+customer_po_no+"::"+sales_exempt_no+"::<BR>");
//out.println(payment+"::"+cs_company+"::"+doc_type+"::"+sales_region+"::"+contact_name+"::<BR>");
//out.println(add_deduct_job+"::"+cust_ship_info+"::"+cust_invoice_info+"::"+cust_bpcs_no+"::<BR>");
if(cust_bpcs_no == null || cust_bpcs_no.equals("null")){
	cust_bpcs_no="0";
}

try	{
	String insert ="INSERT INTO cs_billed_customers(cust_no,cust_name1,cust_addr1,cust_addr2,city,state,zip_code,country,phone,country_code,fax,created_rep_no,order_no,customer_type,market_type,customer_po_no,sales_exempt_no,payment_terms,cs_company,order_type,sales_region,contact_name,add_deduct_job,ship_info,invoice_info,bpcs_cust_no,email,end_user_info,email_acknowledgement,alt_no)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
	PreparedStatement update_customer = myConn.prepareStatement(insert);
			update_customer.setInt(1,number);
			update_customer.setString(2,cust_name1);
			update_customer.setString(3,cust_addr1);
			update_customer.setString(4, cust_addr2);
			update_customer.setString(5, city);
			update_customer.setString(6, state);
			update_customer.setString(7, zip_code);
			update_customer.setString(8, "USA");
			update_customer.setString(9,phone);
			update_customer.setString(10,cust_country);
			update_customer.setString(11,fax);
			update_customer.setString(12,session_rep_no);
			update_customer.setString(13,order_no);
			update_customer.setString(14,customer_type);
			update_customer.setString(15,market_type);
			update_customer.setString(16,customer_po_no);
			update_customer.setString(17,sales_exempt_no);
			update_customer.setString(18,payment);
	//		update_customer.setString(19,credit_card_name);
	//		update_customer.setString(20,credit_card_no);
	//		update_customer.setString(21,expire_date);
			update_customer.setString(19,cs_company);
			update_customer.setString(20,doc_type);
			update_customer.setString(21,sales_region);
			update_customer.setString(22,contact_name);
			update_customer.setString(23,add_deduct_job);
			update_customer.setString(24,cust_ship_info);
			update_customer.setString(25,cust_invoice_info);
			update_customer.setString(26,cust_bpcs_no);
			update_customer.setString(27,billed_email);
			update_customer.setString(28,end_user_info);
			update_customer.setString(29,email_acknowledgement);
			update_customer.setString(30,cust_bpcs_no_alt);
			int rocount = update_customer.executeUpdate();
			update_customer.close();
	}
	catch (java.sql.SQLException e)
	{
		out.println("Problem with ENTERING TO customer2 TABLEs"+"<br>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}

// Inserting into cs_billed_customers

}
else{
// just update the customer
	try
	{
	String insert ="update cs_billed_customers	set cust_name1=?,cust_addr1=?,cust_addr2=?,city=?,state=?,zip_code=?,phone=?,fax=?,customer_type=?,market_type=?,customer_po_no=?,sales_exempt_no=?,payment_terms=?,cs_company=?,order_type=?,sales_region=?,contact_name=?,add_deduct_job=?,ship_info=?,invoice_info=?,bpcs_cust_no=?, email=?,end_user_info=?,email_acknowledgement=?, alt_no=? WHERE order_no= ? ";
	PreparedStatement update_customer = myConn.prepareStatement(insert);
			update_customer.setString(1,cust_name1);
			update_customer.setString(2,cust_addr1);
			update_customer.setString(3,cust_addr2);
			update_customer.setString(4,city);
			update_customer.setString(5,state);
			update_customer.setString(6,zip_code);
			update_customer.setString(7,phone);
			update_customer.setString(8,fax);
			update_customer.setString(9,customer_type);
			update_customer.setString(10,market_type);
			update_customer.setString(11,customer_po_no);
			update_customer.setString(12,sales_exempt_no);
			update_customer.setString(13,payment);
			update_customer.setString(14,cs_company);
			update_customer.setString(15,doc_type);
			update_customer.setString(16,sales_region);
			update_customer.setString(17,contact_name);
			update_customer.setString(18,add_deduct_job);
			update_customer.setString(19,cust_ship_info);
			update_customer.setString(20,cust_invoice_info);
			update_customer.setString(21,cust_bpcs_no);
			update_customer.setString(22, billed_email);
			update_customer.setString(23,end_user_info);
				update_customer.setString(24,email_acknowledgement);
				update_customer.setString(25,cust_bpcs_no_alt);
				update_customer.setString(26,order_no);
			//update_customer.setString(24,session_rep_no);
			int rocount = update_customer.executeUpdate();
			update_customer.close();
	}
	catch (java.sql.SQLException e)
		{
		out.println("Problem with Updating cs/billedcustomer TABLEs"+"<br>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}
}
// Saving the data to the cs_end users
/*
		try
			{
				int nrow= stmt.executeUpdate("delete from cs_end_users WHERE order_no like '"+order_no+"'");
			}
			catch (java.sql.SQLException e)
			{
				out.println("Problem with deleting the shipping & credit card info"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}

*/
// new code added by Greg.  Will enable users to veiw and edit an order sheet, with out changing the
// initial rep id assigned to the job
// after succesfully deletintg the end user inserting the changed one
int endUserCount=0;
ResultSet rsEndUser=stmt.executeQuery("select count(*) from cs_end_users where order_no='"+order_no+"'");
if(rsEndUser != null){
	while(rsEndUser.next()){
		endUserCount=Integer.parseInt(rsEndUser.getString(1));
	}
}
boolean endUserExists=false;
if(endUserCount > 0){
	endUserExists=true;
}

if( ! endUserExists){
	try	{
		String insert ="INSERT INTO cs_end_users(cust_name1,cust_addr1,cust_addr2,city,state,zip_code,country,phone,fax,created_rep_no,order_no,market_type,bpcs_cust_no,alt_no)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
		PreparedStatement update_customer = myConn.prepareStatement(insert);
			update_customer.setString(1,eu_cust_name1);
				update_customer.setString(2,eu_cust_addr1);
				update_customer.setString(3,eu_cust_addr2);
				update_customer.setString(4,eu_city);
				update_customer.setString(5,eu_state);
				update_customer.setString(6,eu_zip_code);
				update_customer.setString(7,"USA");
			update_customer.setString(8,eu_phone);
				update_customer.setString(9,eu_fax);
				update_customer.setString(10,rep_no);
				update_customer.setString(11,order_no);
				update_customer.setString(12,cs_market_type);
				update_customer.setString(13,eu_cust_bpcs);
				update_customer.setString(14,eu_cust_bpcs_alt);
				int rocount = update_customer.executeUpdate();
				update_customer.close();
		}
		catch (java.sql.SQLException e)
		{
			out.println("Problem with ENTERING TO customer1 TABLEs"+"<br>");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}
}
else{
	try{
		String insert="update cs_end_users set cust_name1=?,cust_addr1=?,cust_addr2=?,city=?,state=?,zip_code=?,country=?,phone=?,fax=?,market_type=?,bpcs_cust_no=?,alt_no=? where order_no=?";
		PreparedStatement update_customer=myConn.prepareStatement(insert);
		update_customer.setString(1,eu_cust_name1);
		update_customer.setString(2,eu_cust_addr1);
		update_customer.setString(3,eu_cust_addr2);
		update_customer.setString(4,eu_city);
		update_customer.setString(5,eu_state);
		update_customer.setString(6,eu_zip_code);
		update_customer.setString(7,"USA");
		update_customer.setString(8,eu_phone);
		update_customer.setString(9,eu_fax);
		update_customer.setString(10,cs_market_type);
		update_customer.setString(11,eu_cust_bpcs);
		update_customer.setString(12,eu_cust_bpcs_alt);
		update_customer.setString(13,order_no);
		int c=update_customer.executeUpdate();
		update_customer.close();

	}
	catch(java.sql.SQLException e)
	{
		out.println("Problem updating the cs_end_users table<BR>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;

	}

}
try{
	String insert="update cs_project set overage=? where order_no=?";
	PreparedStatement update_project=myConn.prepareStatement(insert);
	update_project.setString(1,overage);
	update_project.setString(2,order_no);
	int c=update_project.executeUpdate();
	update_project.close();


}
catch(java.sql.SQLException e)
{
	out.println("Problem updating the projects table<BR>");
	out.println("Illegal Operation try again/Report Error"+"<br>");
	myConn.rollback();
	out.println(e.toString());
	return;

}

out.println("<body onload='popUpx()'>");

out.println("<form name='form1x' action='order_transfer.jsp'>");
out.println("<input type='hidden' name='cmd' value='2'>");
out.println("<input type='hidden' name='order_no' value='"+order_no+"'>");
out.println("<input type='hidden' name='id' value='"+rep_no+"'>");
out.println("</form>");

out.println("</body>");
//out.println("Updated billing info ");
myConn.commit();
stmt.close();
myConn.close();
/*
// After saving the the first page
URL yahoo = new URL("http://"+ application.getInitParameter("HOST")+"/erapid/us/orders/ows/order_transfer.jsp?cmd=2&order_no="+order_no+"&id="+rep_no+" ");
BufferedReader in = new BufferedReader(	new InputStreamReader(yahoo.openStream()));
	String inputLine;
	while ((inputLine = in.readLine()) != null)
out.println(inputLine);
in.close();
//out.println("Updated billing info done");
*/

}
catch(Exception e){
out.println(e);
}
%>







