<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/>
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
// REUQEST objects
		String order_no = request.getParameter("order_no");//
		String page_type = request.getParameter("page_type");//
	// Credit card info
		String payment_name = request.getParameter("payment_name");//
		String payment_address1 = request.getParameter("payment_address1");//
		String payment_address2 = request.getParameter("payment_address2");//
		String payment_city = request.getParameter("payment_city");//
		String payment_state = request.getParameter("payment_state");//
		String payment_zip = request.getParameter("payment_zip");//
		String payment_credit_type = request.getParameter("payment_credit_type");//
		String payment_credit_no  = request.getParameter("payment_credit_no");//
		String payment_exp_date ="";//request.getParameter("payment_exp_date");//
		String year=request.getParameter("year");
		String month=request.getParameter("month");
		String payment_cvc=request.getParameter("payment_cvc");
		String payment_phone=request.getParameter("payment_phone");
		String payment_email=request.getParameter("payment_email");
		String day="";

		String usession_user_id="";
		//usession_user_id
		usession_user_id=userSession.getUserId();
		//out.println(year +"::"+month+"<BR>");
		if(year==null){
			year = "0";
		}
		if(month==null){
			month = "0";
		}
		//out.println(year +"::"+month+" new<BR>");

		int yearX=2000+Integer.parseInt(year);
		int monthX=Integer.parseInt(month);
		Calendar cal=new GregorianCalendar(yearX,monthX,1);
		int days=28;
		String monthS="0"+(monthX);
		if(monthS.length()>2){
			monthS=monthS.substring(1);
		}
		payment_exp_date="20"+year+"-"+monthS+"-"+days;;
		String payment_material_sales  = request.getParameter("payment_material_sales");//
		String payment_tax = request.getParameter("payment_tax");//
		String payment_total_charged  = request.getParameter("payment_total_charged");//
	// Credit card info
//Shipping info
		String ship_name = request.getParameter("ship_name");//
		String ship_addr1 = request.getParameter("ship_addr1");//
		String ship_addr2 = request.getParameter("ship_addr2");//
		String city = request.getParameter("city");//
		String state = request.getParameter("state");//
		String zip = request.getParameter("zip");//
		String ship_phone = request.getParameter("ship_phone");//
		String ship_fax = request.getParameter("ship_fax");//
		String ship_email = request.getParameter("ship_email");//
		String ship_method = request.getParameter("ship_method");//
		String ship_terms = request.getParameter("ship_terms");//
		String ship_tax_exempt = request.getParameter("ship_tax_exempt");//
		String ship_rdate = request.getParameter("ship_rdate");//
//		String ship_fdate = request.getParameter("ship_fdate");//
//		String ship_edate = request.getParameter("ship_edate");//
		String attention_ship=request.getParameter("attention_ship");
		String notice_ship=request.getParameter("notice_ship");
		String phone_ship=request.getParameter("phone_ship");
		String name_ship=request.getParameter("name_ship");
		String ship_cust_bpcs_no=request.getParameter("ship_cust_bpcs_no");
		String ship_cust_bpcs_no_alt=request.getParameter("ship_cust_bpcs_no_alt");

		String rep_no = request.getParameter("rep_no");//	new or old
//Shipping info
//Invoice info
		String invoice_name = request.getParameter("invoice_name");//
		String invoice_addr1 = request.getParameter("invoice_addr1");//
		String invoice_addr2 = request.getParameter("invoice_addr2");//
		String invoice_city = request.getParameter("invoice_city");//
		String invoice_state = request.getParameter("invoice_state");//
		String invoice_zip = request.getParameter("invoice_zip");//
		String invoice_phone = request.getParameter("invoice_phone");//
		String invoice_fax = request.getParameter("invoice_fax");//
		String invoice_email = request.getParameter("invoice_email");//
		String attention_invoice=request.getParameter("attention_invoice");
		//out.println(invoice_state+"::"+payment_state+"::"+state);
		String invoice_cust_bpcs_no=request.getParameter("invoice_cust_bpcs_no");
		String invoice_cust_bpcs_no_alt=request.getParameter("invoice_cust_bpcs_no_alt");
%>
<%@ include file="../../../db_con.jsp"%>
<%

myConn.setAutoCommit(false);
if (page_type.equals("one")){
// Inserting into cs_billed_customers
//out.println("Updated Shipping info +1 Ven");
		try
			{
				int nrow= stmt.executeUpdate("delete from cs_payment_details WHERE order_no like '"+order_no+"'");
				int nrow1= stmt.executeUpdate("delete from SHIPPING WHERE Order_no like '"+order_no+"'");
				int nrow2= stmt.executeUpdate("delete from cs_invoice WHERE Order_no like '"+order_no+"'");
			}
			catch (java.sql.SQLException e)
			{
				out.println("Problem with deleting the shipping & credit card info"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
// Inserting the shipping info
try	{
	String insert ="INSERT INTO SHIPPING(Order_no,Name_1,Address_1,Address_2,City,State,Zip_code,Phone,fax,email,ship_method,sales_exempt_number,ship_terms,request_date,attention,prior_notice,prior_notice_name,prior_notice_phone,bpcs_cust_no,alt_no)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
	PreparedStatement update_customer = myConn.prepareStatement(insert);
			update_customer.setString(1,order_no);
			update_customer.setString(2,ship_name);
			update_customer.setString(3,ship_addr1);
			update_customer.setString(4,ship_addr2);
			update_customer.setString(5,city);
			update_customer.setString(6,state);
			update_customer.setString(7,zip);
			update_customer.setString(8,ship_phone);
			update_customer.setString(9,ship_fax);
			update_customer.setString(10,ship_email);
			update_customer.setString(11,ship_method);
			update_customer.setString(12,ship_tax_exempt);
			update_customer.setString(13,ship_terms);
			update_customer.setString(14,ship_rdate);
			update_customer.setString(15,attention_ship);
			update_customer.setString(16,notice_ship);
			update_customer.setString(17,name_ship);
			update_customer.setString(18,phone_ship);
			update_customer.setString(19,ship_cust_bpcs_no);
			update_customer.setString(20,ship_cust_bpcs_no_alt);
			int rocount = update_customer.executeUpdate();
			update_customer.close();
	}
	catch (java.sql.SQLException e)
	{
		out.println("Problem with ENTERING data TO Shipping TABLEs"+"<br>");
		out.println(order_no+"::"+ship_name+"::"+ship_addr1+"::"+ship_addr2+"::"+city+"::"+state+"::"+zip+"<BR>");
		out.println(ship_phone+"::"+ship_fax+"::"+ship_email+"::"+ship_method+"::"+ship_tax_exempt+"::"+ship_terms+"::"+ship_rdate+"<BR>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}

// Inserting the Invoice info
try	{
	String insert ="INSERT INTO CS_INVOICE(Order_no,name1,address1,address2,City,State,Zip_code,Phone,fax,email,attention,bpcs_cust_no,alt_no)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?) ";
	PreparedStatement update_invoice = myConn.prepareStatement(insert);
			update_invoice.setString(1,order_no);
			update_invoice.setString(2,invoice_name);
			update_invoice.setString(3,invoice_addr1);
			update_invoice.setString(4,invoice_addr2);
			update_invoice.setString(5,invoice_city);
			update_invoice.setString(6,invoice_state);
			update_invoice.setString(7,invoice_zip);
			update_invoice.setString(8,invoice_phone);
			update_invoice.setString(9,invoice_fax);
			update_invoice.setString(10,invoice_email);
			update_invoice.setString(11,attention_invoice);
			update_invoice.setString(12,invoice_cust_bpcs_no);
			update_invoice.setString(13,invoice_cust_bpcs_no_alt);
			int rocount = update_invoice.executeUpdate();
			update_invoice.close();
	}
	catch (java.sql.SQLException e)
	{
		out.println("Problem with ENTERING data TO Invoice TABLEs"+"<br>");
		out.println(invoice_name+"::"+invoice_addr1+"::"+invoice_addr2+"::"+invoice_city+"::"+invoice_state+"::"+invoice_zip+"<BR>");
		out.println(invoice_phone+"::"+invoice_fax+"::"+invoice_email+"<BR>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}


// 	Credit Card info

try	{
//out.println(payment_exp_date+":: HERE");
	String insert ="INSERT INTO cs_payment_details(order_no,payment_method,name,address1,address2,city,state,zip_code,credit_card_type,credit_card_no,exp_date,total_material_sales,tax,total_charged	)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
	PreparedStatement update_payment = myConn.prepareStatement(insert);
			update_payment.setString(1,order_no);
			update_payment.setString(2,"CC");
			update_payment.setString(3,payment_name);
			update_payment.setString(4,payment_address1);
			update_payment.setString(5,payment_address2);
			update_payment.setString(6,payment_city);
			update_payment.setString(7,payment_state);
			update_payment.setString(8,payment_zip);
			update_payment.setString(9,payment_credit_type);
			update_payment.setString(10,payment_credit_no);
			update_payment.setString(11,payment_exp_date);
			update_payment.setString(12,payment_material_sales);
			update_payment.setString(13,payment_tax);
			update_payment.setString(14,payment_total_charged);
			int rocount = update_payment.executeUpdate();
			update_payment.close();
	}
	catch (java.sql.SQLException e)
	{
		out.println("Problem with ENTERING data to credit card information TABLEs"+"<br>"+year+"::"+month+"::"+payment_exp_date);
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}
/// aslo updating credit card tables
/*
%>
<%@ include file="db_con_ccf.jsp"%>
<%//credit card info from New Credit card database ends
int count_ccf=0;String ref_no=""; String payment_credit_type_cv="";String payment_credit_no_cv="";String month_cv="";String year_cv="";String cc_cv="";
	ResultSet rs_payment_ccf = stmt_ccf.executeQuery("SELECT Top 1 * FROM cvuCCTrans where QuoteNo like '"+order_no+"' and OLD='N' order by Refno desc ");
	if (rs_payment_ccf !=null) {
   while (rs_payment_ccf.next()) {
	out.println("In cc file <br>");
	ref_no=rs_payment_ccf.getString("RefNo");
 //  	payment_method= "CC";
//		payment_name= rs_payment_ccf.getString("Name");
//		payment_address1= rs_payment_ccf.getString("Addr1");
//		payment_address2= rs_payment_ccf.getString("Addr2");
//		payment_city= rs_payment_ccf.getString("City");
//		payment_state= rs_payment_ccf.getString("St");
//		payment_zip= rs_payment_ccf.getString("Zip");
	payment_credit_type_cv= rs_payment_ccf.getString("CardType").trim();
	payment_credit_no_cv= rs_payment_ccf.getString("CCNo").trim();
	month_cv= rs_payment_ccf.getString("ExpDtMM").trim();
	year_cv= rs_payment_ccf.getString("ExpDtYYYY").trim();
	cc_cv= rs_payment_ccf.getString("CVC").trim();
//		payment_material_sales= rs_payment_ccf.getString("TotMat");
//		payment_tax= rs_payment_ccf.getString("Tax");
//		payment_total_charged= rs_payment_ccf.getString("TotSale");
	count_ccf++;
   }
   }
	rs_payment_ccf.close();

String product_id="";
ResultSet rsProduct_id=stmt.executeQuery("select product_id from cs_project where order_no='"+order_no+"'");
if(rsProduct_id != null){
while(rsProduct_id.next()){
	product_id=rsProduct_id.getString(1);
}
}
rsProduct_id.close();
if (count_ccf>0){ //for modifying an order
//out.println("In cc file modify"+payment_name);
if(payment_credit_type_cv.equals(payment_credit_type.trim())&&payment_credit_no_cv.equals(payment_credit_no.trim())&&month_cv.equals(month.trim())&&year_cv.equals(year.trim())&&cc_cv.equals(payment_cvc.trim())){
	try {
		CallableStatement cs_ccf = myConn_ccf.prepareCall("{? = call dbo.cspInsCC('E','M','"+usession_user_id+"','"+order_no+"','000000','000000','000000','','"+ref_no+"','"+payment_name+"','"+payment_address1+"','"+payment_address2+"','"+payment_city+"','"+payment_state+"','"+payment_zip+"','US','"+payment_phone+"','"+payment_credit_type_cv+"','"+payment_credit_no_cv+"','"+month_cv+"','20"+year_cv+"','"+cc_cv+"','"+payment_material_sales+"','"+payment_tax+"','0.0','"+payment_total_charged+"','','','"+payment_email+"','','')}");
		cs_ccf.registerOutParameter(1, Types.INTEGER);
		cs_ccf.execute();
		int tran_id = cs_ccf.getInt(1);
	   cs_ccf.close();
	} catch (java.sql.SQLException e) {
		out.println("Problem with Updating to CCF database"+"<br>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		out.println(e.toString());
		return;
	}
}else{
	//voiding and inserting a new changes.
	out.println("In cc file void & insert"+payment_name);
	try {
		CallableStatement cs_ccf = myConn_ccf.prepareCall("{? = call dbo.cspInsCC('E','V','"+usession_user_id+"','"+order_no+"','000000','000000','000000','','"+ref_no+"','"+payment_name+"','"+payment_address1+"','"+payment_address2+"','"+payment_city+"','"+payment_state+"','"+payment_zip+"','US','"+payment_phone+"','"+payment_credit_type+"','"+payment_credit_no+"','"+month+"','20"+year+"','"+payment_cvc+"','"+payment_material_sales+"','"+payment_tax+"','0.0','"+payment_total_charged+"','','','"+payment_email+"','','','"+product_id+"')}");
		cs_ccf.registerOutParameter(1, Types.INTEGER);
		cs_ccf.execute();
		int tran_id = cs_ccf.getInt(1);
	   cs_ccf.close();
	} catch (java.sql.SQLException e) {
		out.println("Problem with Voiding to CCF database"+"<br>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		out.println(e.toString());
		return;
	}
	try {
		CallableStatement cs_ccf = myConn_ccf.prepareCall("{? = call dbo.cspInsCC('E','N','"+usession_user_id+"','"+order_no+"','000000','000000','000000','','','"+payment_name+"','"+payment_address1+"','"+payment_address2+"','"+payment_city+"','"+payment_state+"','"+payment_zip+"','US','"+payment_phone+"','"+payment_credit_type+"','"+payment_credit_no+"','"+month+"','20"+year+"','"+payment_cvc+"','"+payment_material_sales+"','"+payment_tax+"','0.0','"+payment_total_charged+"','','','"+payment_email+"','','','"+product_id+"')}");
		cs_ccf.registerOutParameter(1, Types.INTEGER);
		cs_ccf.execute();
		int tran_id = cs_ccf.getInt(1);
	   cs_ccf.close();
	} catch (java.sql.SQLException e) {
		out.println("Problem with Voiding & inserting to CCF database"+"<br>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		out.println(e.toString());
		return;
    }

}
//	CallableStatement cs_ccf = myConn_ccf.prepareCall("{call dbo.cspInsCC(E,M,"+usession_user_id+","+order_no+","","",,?)}");
}
else{ //for new orders
out.println("In cc file New <br>");
out.println("In cc file New values+"+payment_material_sales+" <br>");
try {
	CallableStatement cs_ccf = myConn_ccf.prepareCall("{? = call dbo.cspInsCC('E','N','"+usession_user_id+"','"+order_no+"','000000','000000','000000','','','"+payment_name+"','"+payment_address1+"','"+payment_address2+"','"+payment_city+"','"+payment_state+"','"+payment_zip+"','US','"+payment_phone+"','"+payment_credit_type+"','"+payment_credit_no+"','"+month+"','20"+year+"','"+payment_cvc+"','"+payment_material_sales+"','"+payment_tax+"','0.0','"+payment_total_charged+"','','','"+payment_email+"','','','"+product_id+"')}");
	cs_ccf.registerOutParameter(1, Types.INTEGER);
	cs_ccf.execute();
	int tran_id = cs_ccf.getInt(1);
   cs_ccf.close();
} catch (java.sql.SQLException e) {
	out.println("Problem with inserting to CCF database"+"<br>");
	out.println("Illegal Operation try again/Report Error"+"<br>");
	out.println(e.toString());
	return;
}
}

stmt_ccf.close();
myConn_ccf.close();
*/
}
else{
//out.println("Updated Shipping info 2");
try
{
	int nrow1= stmt.executeUpdate("delete from SHIPPING WHERE Order_no like '"+order_no+"'");
	int nrow2= stmt.executeUpdate("delete from cs_invoice WHERE Order_no like '"+order_no+"'");
}
catch (java.sql.SQLException e)
{
	out.println("Problem with deleting the shipping info"+"<br>");
	out.println("Illegal Operation try again/Report Error"+"<br>");
	myConn.rollback();
	out.println(e.toString());
	return;
}

// Inserting the shipping info
try	{
String insert ="INSERT INTO SHIPPING(Order_no,Name_1,Address_1,Address_2,City,State,Zip_code,Phone,fax,email,ship_method,sales_exempt_number,ship_terms,request_date,attention,prior_notice,prior_notice_name,prior_notice_phone,bpcs_cust_no,alt_no)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
PreparedStatement update_customer = myConn.prepareStatement(insert);
update_customer.setString(1,order_no);
update_customer.setString(2,ship_name);
update_customer.setString(3,ship_addr1);
update_customer.setString(4,ship_addr2);
update_customer.setString(5,city);
update_customer.setString(6,state);
update_customer.setString(7,zip);
update_customer.setString(8,ship_phone);
update_customer.setString(9,ship_fax);
update_customer.setString(10,ship_email);
update_customer.setString(11,ship_method);
update_customer.setString(12,ship_tax_exempt);
update_customer.setString(13,ship_terms);
//			update_customer.setString(14,ship_fdate);
//			update_customer.setString(15,ship_edate);
update_customer.setString(14,ship_rdate);

update_customer.setString(15,attention_ship);
update_customer.setString(16,notice_ship);
update_customer.setString(17,name_ship);
update_customer.setString(18,phone_ship);
update_customer.setString(19,ship_cust_bpcs_no);
update_customer.setString(20,ship_cust_bpcs_no_alt);
int rocount = update_customer.executeUpdate();
update_customer.close();
}
catch (java.sql.SQLException e)
{
out.println("Problem with ENTERING data TO Shipping TABLEs"+"<br>");
out.println("Illegal Operation try again/Report Error"+"<br>");
myConn.rollback();
out.println(e.toString());
return;
}

// Inserting the Invoice info
try	{
String insert ="INSERT INTO CS_INVOICE(Order_no,name1,address1,address2,City,State,Zip_code,Phone,fax,email,attention,bpcs_cust_no,alt_no)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?) ";
PreparedStatement update_invoice = myConn.prepareStatement(insert);
update_invoice.setString(1,order_no);
update_invoice.setString(2,invoice_name);
update_invoice.setString(3,invoice_addr1);
update_invoice.setString(4,invoice_addr2);
update_invoice.setString(5,invoice_city);
update_invoice.setString(6,invoice_state);
update_invoice.setString(7,invoice_zip);
update_invoice.setString(8,invoice_phone);
update_invoice.setString(9,invoice_fax);
update_invoice.setString(10,invoice_email);
update_invoice.setString(11,attention_invoice);
update_invoice.setString(12,invoice_cust_bpcs_no);
update_invoice.setString(13,invoice_cust_bpcs_no_alt);
int rocount = update_invoice.executeUpdate();
update_invoice.close();
}
catch (java.sql.SQLException e)
{
out.println("Problem with ENTERING data TO Invoice TABLEs"+"<br>");
out.println("Illegal Operation try again/Report Error"+"<br>");
myConn.rollback();
out.println(e.toString());
return;
}





// 	Credit Card info
}
out.println("<body onload='popUpx()'>");

out.println("<form name='form1x' action='order_transfer.jsp'>");
out.println("<input type='hidden' name='cmd' value='3'>");
out.println("<input type='hidden' name='order_no' value='"+order_no+"'>");
out.println("<input type='hidden' name='id' value='"+rep_no+"'>");
out.println("</form>");

out.println("</body>");
myConn.commit();
stmt.close();
myConn.close();
/*
//out.println("Generating the next page: "+rep_no);
// After saving the the first page
URL yahoo = new URL("http://"+ application.getInitParameter("HOST")+"/erapid/us/orders/ows/order_transfer.jsp?cmd=3&order_no="+order_no+"&id="+rep_no+" ");
BufferedReader in = new BufferedReader(	new InputStreamReader(yahoo.openStream()));
String inputLine;
while ((inputLine = in.readLine()) != null)
out.println(inputLine);
in.close();
*/
//out.println("Updated billing info done");
}
catch(Exception e){
out.println(e);
}
%>








