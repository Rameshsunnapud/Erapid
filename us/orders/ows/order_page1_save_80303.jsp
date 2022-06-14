<%@ page language="java" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" errorPage="error.jsp" %>
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
		String contact_name = request.getParameter("contact_name");//
		String sales_region = request.getParameter("sales_region");//
		String cust_addr2 = request.getParameter("cust_addr2");//
		String cust_addr1 = request.getParameter("cust_addr1");//
		String state = request.getParameter("state");//
//		String expire_date = request.getParameter("expire_date");//
		String Job_loc  = request.getParameter("Job_loc");//
		String fax = request.getParameter("fax");//			String
		String doc_type = request.getParameter("doc_type");//
//		String credit_card_no = request.getParameter("credit_card_no");//
//		String credit_card_name = request.getParameter("credit_card_name");//
		String type_of_cust = request.getParameter("type_of_cust");//	new or old
		String rep_no = request.getParameter("rep_no");//	new or old
//CS_customers tabel
		String cs_market_type = request.getParameter("eu_market_type");//	new or old

if (payment==null){
payment="";
}
else {
payment="CC";
}

%>
<%@ include file="db_con.jsp"%>
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
try	{
	String insert ="INSERT INTO cs_billed_customers(cust_no,cust_name1,cust_addr1,cust_addr2,city,state,zip_code,country,phone,country_code,fax,created_rep_no,order_no,customer_type,market_type,customer_po_no,sales_exempt_no,payment_terms,cs_company,doc_type,sales_region,contact_name,add_deduct_job)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
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
			update_customer.setString(10,"US");
			update_customer.setString(11,fax);
			update_customer.setString(12,rep_no);
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
			int rocount = update_customer.executeUpdate();
			update_customer.close();
	}
	catch (java.sql.SQLException e)
	{
		out.println("Problem with ENTERING TO customer TABLEs"+"<br>");
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
	String insert ="update cs_billed_customers	set cust_name1=?,cust_addr1=?,cust_addr2=?,city=?,state=?,zip_code=?,phone=?,fax=?,customer_type=?,market_type=?,customer_po_no=?,sales_exempt_no=?,payment_terms=?,cs_company=?,doc_type=?,sales_region=?,contact_name=?,add_deduct_job=? WHERE order_no= ? and created_rep_no=?";
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
			update_customer.setString(19,order_no);
			update_customer.setString(20,rep_no);
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
//out.println("Updated billing info ");
myConn.commit();
stmt.close();
myConn.close();
// After saving the the first page
URL yahoo = new URL("http://"+ application.getInitParameter("HOST")+"/elo//classes/customxs/order_transfer.jsp?cmd=2&order_no="+order_no+"&id="+rep_no+" ");
BufferedReader in = new BufferedReader(	new InputStreamReader(yahoo.openStream()));
	String inputLine;
	while ((inputLine = in.readLine()) != null)
out.println(inputLine);
in.close();
//out.println("Updated billing info done");
%>







