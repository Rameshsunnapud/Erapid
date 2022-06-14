
<html>
<head><title>ORDER SHEET</title>
<link rel='stylesheet' href='order.css' type='text/css' />
</head>
<body>
<%
//out.println(rep_no+"::<BR>");
//
	// vars for display // cs_order_info
//String date_required="";
	java.util.Date date_required = new java.util.Date(); // Right now

String submit_prep="";String email_to="";String submit_by="";String special_notes="";
String copies_requested="";String type_of_quote="";String order_notes="";
 NumberFormat for1 = NumberFormat.getCurrencyInstance();
      for1.setMaximumFractionDigits(0);
//eorders for the
String prio="";
		ResultSet e_order = stmt.executeQuery("SELECT * FROM doc_header where doc_number like '"+order_no+"' ");
  		if (e_order !=null) {
        while (e_order.next()) {
		prio= e_order.getString("doc_priority");
								}
							 }
// cs_order_info
		ResultSet rs_order = stmt.executeQuery("SELECT * FROM cs_order_info where order_no like '"+order_no+"' ");
  		if (rs_order !=null) {
        while (rs_order.next()) {
		date_required= rs_order.getDate("date_required");
		submit_prep= rs_order.getString("submit_prep");
		email_to= rs_order.getString("email_to");
		submit_by= rs_order.getString("submit_by");
		special_notes= rs_order.getString("special_notes");
		copies_requested= rs_order.getString("copies_requested");
		type_of_quote= rs_order.getString("type_of_quote");
		order_notes= rs_order.getString("order_notes");

								}
							}
							rs_order.close();


//Invoice variables
		String invoice_name="";String invoice_addr1="";String invoice_addr2="";String invoice_city="";String invoice_state="";
		String invoice_zip="";String invoice_phone="";String invoice_fax="";String invoice_email="";

		// Getting the Invoice info
				ResultSet rs_invoice = stmt.executeQuery("SELECT * FROM cs_invoice where Order_no like '"+order_no+"' ");
		  		if (rs_invoice !=null) {
		        while (rs_invoice.next()) {
				invoice_name= rs_invoice.getString("name1");
				invoice_addr1= rs_invoice.getString("address1");
				invoice_addr2= rs_invoice.getString("address2");
				invoice_city= rs_invoice.getString("City");
				invoice_state= rs_invoice.getString("State");
				invoice_zip= rs_invoice.getString("Zip_code");
				invoice_phone= rs_invoice.getString("Phone");
				invoice_fax= rs_invoice.getString("fax");
				invoice_email= rs_invoice.getString("email");
									   }
								   }
			   rs_invoice.close();
// Getting the Invoice info	end

// CS_BILLED_CUSTOMERS
		String cust_name1="";String cust_addr1="";String cust_addr2="";String city="";String state="";String zip_code="";
		String phone="";String fax="";String contact_name="";String customer_po_no="";String sales_exempt_no="";
		String customer_type="";String market_type="";String cs_company="";String doc_type="";String add_deduct_job="";String payment_terms="";
		String sales_region="";
		String billed_email="";
		//Customer tbale
		String eu_cust_name1="";String eu_cust_addr1="";String eu_cust_addr2="";String eu_city="";String eu_state="";String eu_zip_code="";
		String eu_phone="";String eu_fax="";String market_type1="";
		//
		ResultSet rs_bill = stmt.executeQuery("SELECT * FROM cs_billed_customers where order_no like '"+order_no+"' ");
  		if (rs_bill !=null) {
        while (rs_bill.next()) {
		cust_name1= rs_bill.getString("cust_name1");
		cust_addr1= rs_bill.getString("cust_addr1");
		cust_addr2= rs_bill.getString("cust_addr2");
		city= rs_bill.getString("city");
		state= rs_bill.getString("state");
		zip_code= rs_bill.getString("zip_code");
		phone= rs_bill.getString("phone");
		fax= rs_bill.getString("fax");
		contact_name= rs_bill.getString("contact_name");
		customer_po_no= rs_bill.getString("customer_po_no");
		sales_exempt_no= rs_bill.getString("sales_exempt_no");
		market_type= rs_bill.getString("market_type");
		cs_company= rs_bill.getString("cs_company");
		doc_type= rs_bill.getString("order_type");
		add_deduct_job= rs_bill.getString("add_deduct_job");
		payment_terms= rs_bill.getString("payment_terms");
		sales_region= rs_bill.getString("sales_region");
		customer_type= rs_bill.getString("customer_type");
		billed_email=rs_bill.getString("email");
		rep_no=rs_bill.getString("created_rep_no");
       						    }
		                }
		                rs_bill.close();
		if(billed_email == null){ billed_email="";}
		ResultSet rs_customer = stmt.executeQuery("SELECT * FROM cs_end_users where order_no like '"+order_no+"'");
		if (rs_customer !=null) {
        while ( rs_customer.next() ) {
		eu_cust_name1= rs_customer.getString("cust_name1");
		eu_cust_addr1= rs_customer.getString("cust_addr1");
		eu_cust_addr2= rs_customer.getString("cust_addr2");
		eu_city= rs_customer.getString("city");
		eu_state= rs_customer.getString("state");
		eu_zip_code= rs_customer.getString("zip_code");
		eu_phone= rs_customer.getString("phone");
		eu_fax= rs_customer.getString("fax");
		market_type1= rs_customer.getString("market_type");
	   						         }
								}
								rs_customer.close();
// vars for the credit card info
String payment_method="";String payment_name="";String payment_address1="";
String payment_address2="";String payment_city="";String payment_state="";String payment_zip="";
String payment_credit_type="";String payment_credit_no="";int pay_coun=0;
//String payment_exp_date="";
	java.util.Date payment_exp_date = new java.util.Date();
String payment_material_sales="";String payment_tax="";String payment_total_charged="";
		ResultSet rs_payment = stmt.executeQuery("SELECT * FROM cs_payment_details where order_no like '"+order_no+"' ");
  		if (rs_payment !=null) {
        while (rs_payment.next()) {
		payment_method= rs_payment.getString("payment_method");
		payment_name= rs_payment.getString("name");
		payment_address1= rs_payment.getString("address1");
		payment_address2= rs_payment.getString("address2");
		payment_city= rs_payment.getString("city");
		payment_state= rs_payment.getString("state");
		payment_zip= rs_payment.getString("zip_code");
		payment_credit_type= rs_payment.getString("credit_card_type");
		payment_credit_no= rs_payment.getString("credit_card_no");
		payment_exp_date= rs_payment.getDate("exp_date");
		payment_material_sales= rs_payment.getString("total_material_sales");
		payment_tax= rs_payment.getString("tax");
		payment_total_charged= rs_payment.getString("total_charged");
		pay_coun++;
								  }
		                       }
		                       rs_payment_details.close();
// shipping info

//Ship variables
String ship_name="";String ship_addr1="";String ship_addr2="";String ship_city="";String ship_state="";
String ship_zip="";String ship_phone="";String ship_fax="";String ship_email="";String ship_method="";
String ship_tax_exempt="";String ship_terms="";String ship_rdate="";

//java.util.Date ship_rdate = new java.util.Date();
//java.util.Date ship_edate = new java.util.Date();
//java.util.Date ship_fdate = new java.util.Date();
//String ship_rdate="";String ship_edate="";String ship_fdate="";
// Getting the shipping info
		ResultSet rs_ship = stmt.executeQuery("SELECT * FROM SHIPPING where Order_no like '"+order_no+"' ");
  		if (rs_ship !=null) {
        while (rs_ship.next()) {
		ship_name= rs_ship.getString("Name_1");
		ship_addr1= rs_ship.getString("Address_1");
		ship_addr2= rs_ship.getString("Address_2");
		ship_city= rs_ship.getString("City");
		ship_state= rs_ship.getString("State");
		ship_zip= rs_ship.getString("Zip_code");
		ship_phone= rs_ship.getString("Phone");
		ship_fax= rs_ship.getString("fax");
		ship_email= rs_ship.getString("email");
		ship_method= rs_ship.getString("ship_method");
		ship_tax_exempt= rs_ship.getString("sales_exempt_number");
		ship_terms= rs_ship.getString("ship_terms");
		ship_rdate= rs_ship.getString("request_date");
//		ship_edate= rs_ship.getDate("estimated_date");
//		ship_fdate= rs_ship.getDate("firm_date");
							   }
						   }
						   rs_ship.close();
// Getting the shipping info	end
// vars for arch
String arch_name="";String arch_addr1="";String arch_addr2="";String arch_city="";String arch_state="";
String arch_zip="";String arch_phone="";String arch_fax="";String arch_email="";String arch_required="";

// Getting the Architect
		ResultSet rs_arch = stmt.executeQuery("	select * from cs_order_architects where order_no= '"+order_no+"' ");
  		if (rs_arch !=null) {
        while (rs_arch.next()) {
		arch_name= rs_arch.getString("name1");
		arch_addr1= rs_arch.getString("address1");
		arch_addr2= rs_arch.getString("address2");
		arch_city= rs_arch.getString("city");
		arch_state= rs_arch.getString("state");
		arch_zip= rs_arch.getString("zip_code");
		arch_phone= rs_arch.getString("phone");
		arch_fax= rs_arch.getString("fax");
		arch_email= rs_arch.getString("email");
		arch_required= rs_arch.getString("required");
							}
					}
					rs_arch.close();

//Getting the Arcitect done
// Global
		int tot_lines=0;double totprice=0;double factor=0;double totprice_dis=0;String description="";
		Vector QTY=new Vector();
		Vector price=new Vector();
		Vector line_item=new Vector();
		Vector desc=new Vector();
		Vector rec_no=new Vector();
		Vector fact_per=new Vector();
		Vector mark=new Vector();
		Vector imp=new Vector();
		Vector block_id=new Vector();
String quan="";
// Getting the order information
		ResultSet rs3 = stmt.executeQuery("SELECT * FROM csquotes where order_no like '"+order_no+"' and Block_ID='PRICING' AND Sequence_no='0.00' order by cast(Line_no as integer)");
        while ( rs3.next() ) {
		line_item.addElement(rs3.getString ("Line_no"));
		desc.addElement(rs3.getString ("Descript"));
		price.addElement(rs3.getString ("Extended_Price"));
		QTY.addElement(rs3.getString("QTY"));
		rec_no.addElement(rs3.getString("Record_no"));
		block_id.addElement(rs3.getString("Block_ID"));
		fact_per.addElement(rs3.getString("field16"));
		mark.addElement(rs3.getString("field17"));
		tot_lines++;
       						 }
       						// rs3.close();
String rep_name="";
// Getting the Rep's name
		ResultSet rs3_rep = stmt.executeQuery("SELECT rep_account FROM cs_reps where rep_no = '"+rep_no+"' ");
        while ( rs3_rep.next() ) {
		rep_name=rs3_rep.getString("rep_account");
       						 }
       						 rs3_rep.close();



// Displaying the final form
out.println("<table width='100%' border='0' cellspacing='0' cellpadding='0' class='tb'>");
out.println("<tr>");
out.println("<td align='center' width='100%' height='30' class='tdheader'>&nbsp;"+type_of_quote+"&nbsp;&nbsp;ORDER SHEET"+"</td>");
out.println("</tr>");

out.println("<tr>");
out.println("<td width='100%' align='right' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"date:<B>"+date_required+"</B><td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td width='100%' align='LEFT' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"ORDER TYPE:<b>"+doc_type+"</b><td>");
out.println("</tr>");

        out.println("<tr>");
        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tddash'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
        out.println("<td class='tdnodash' width='10%'>SALES REGION:</td>");
        out.println("<td class='tdnodash' align='LEFT' width='18%'>&nbsp;<b>"+sales_region+"</b></td>");
        out.println("<td class='tdnodash' width='13%'>COMPANY DIVISION:</td>");
        out.println("<td class='tdnodash' width='25%'>&nbsp;<b>"+cs_company+"</b></td>");
		out.println("<td class='tdnodash' width='7%'>"+"QUOTE NO:"+"</td>");
		out.println("<td class='tdnodash' width='25%'>&nbsp;<b>"+order_no+"</b></td>");
		out.println("</tr>");
		out.println("</table></td>");
  		out.println("</tr>");
		out.println("</tr>");
        out.println("<tr>");
        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tddash'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
        out.println("<td class='tdnodash' width='4%'>REP#</td>");
        out.println("<td class='tdnodash' width='24%'>&nbsp;<b>"+rep_no+"</b></td>");
        out.println("<td class='tdnodash' width='8%'>REP NAME:</td>");
        out.println("<td class='tdnodash' width='65%'>&nbsp;<b>"+rep_name+"</b></td>");
		out.println("</tr>");
		out.println("</table></td>");
  		out.println("</tr>");
		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tdsolid' bordercolor='#C0C0C0'>"+"JOB NAME & LOCATION:&nbsp;<b>"+Project_name+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+Job_loc+"&nbsp;&nbsp;&nbsp;"+project_state+"</b><td>");
		out.println("</tr>");
	//row
		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tddashtop' bordercolor='#C0C0C0'>"+"BILLING CUSTOMER:&nbsp;<b>"+cust_name1+"</b><td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"ADDRESS:&nbsp;<b>"+cust_addr1+"&nbsp;&nbsp;&nbsp;"+cust_addr2+"</b><td>");
		out.println("</tr>");
//ROW
		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"CITY/STATE/ZIP:&nbsp;<b>"+city+",&nbsp;"+state+"&nbsp;&nbsp;"+zip_code+"</b><td>");
		out.println("</tr>");
//ROW
        out.println("<tr>");
        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tddash'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
        out.println("<td class='tdnodash' width='12%'>PHONE:</td>");
        out.println("<td class='tdnodash' width='40%'>&nbsp;<b>"+phone+"</b></td>");
        out.println("<td class='tdnodash' width='15%'>FAX:</td>");
        out.println("<td class='tdnodash' width='35%'>&nbsp;<b>"+fax+"</b></td>");
		out.println("</tr>");
		out.println("</table></td>");
  		out.println("</tr>");
//ROW
        out.println("<tr>");
        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tddash'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
        out.println("<td class='tdnodash' width='12%'>CONTACT NAME:</td>");
        out.println("<td class='tdnodash' width='40%'>&nbsp;<b>"+contact_name+"</b></td>");
        out.println("<td class='tdnodash' width='15%'>EMAIL:</td>");
        out.println("<td class='tdnodash' width='35%'>&nbsp;<b>"+billed_email+"</b></td>");
		out.println("</tr>");
		out.println("</table></td>");
  		out.println("</tr>");
//ROW
        out.println("<tr>");
        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tddash'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
        out.println("<td class='tdnodash' width='50%'>CUSTOMER TYPE:&nbsp;<b>"+customer_type+"</b></td>");
        out.println("<td class='tdnodash' width='50%'>MARKET TYPE:&nbsp;<b>"+market_type+"</b></td>");
		out.println("</tr>");
		out.println("</table></td>");
  		out.println("</tr>");
//ROW
        out.println("<tr>");
        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tdsolid'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
        out.println("<td class='tdnodash' width='50%'>CUSTOMER PO NUMBER:&nbsp;<b>"+customer_po_no+"</b></td>");
        out.println("<td class='tdnodash' width='50%'>TAX EXEMPT NUMBER#&nbsp;<b>"+sales_exempt_no+"</b></td>");
		out.println("</tr>");
		out.println("</table></td>");
  		out.println("</tr>");
  		 // INVOICE INFORMATION ADDED TO THE ORDER-WRITE UP ON MAY -12'08
  	  //row
  			out.println("<tr>");
  			out.println("<td width='100%' height='10%' class='tddashtop' bordercolor='#C0C0C0'>"+"INVOICE TO NAME:&nbsp;<b>"+invoice_name+"</b><td>");
  			out.println("</tr>");
  			out.println("<tr>");
  			out.println("<td width='100%' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"ADDRESS:&nbsp;<b>"+invoice_addr1+",&nbsp;"+invoice_addr2+"</b><td>");
  			out.println("</tr>");
  	//ROW
  			out.println("<tr>");
  			out.println("<td width='100%' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"CITY/STATE/ZIP:&nbsp;<b>"+invoice_city+",&nbsp;"+invoice_state+"&nbsp;&nbsp;"+invoice_zip+"</b><td>");
  			out.println("</tr>");
  	//ROW
  	        out.println("<tr>");
  	        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tdsolid'>");
  	        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
  	        out.println("<tr>");
  	        out.println("<td class='tdnodash' width='33%'>PHONE:&nbsp;<b>"+invoice_phone+"</b></td>");
  	        out.println("<td class='tdnodash' width='33%'>FAX:&nbsp;<b>"+invoice_fax+"</b></td>");
  			out.println("<td class='tdnodash' width='34%'>EMAIL:&nbsp;<b>"+invoice_email+"</b></td>");
  			out.println("</tr>");
  			out.println("</table></td>");
  	  		out.println("</tr>");
  	//ROW
  	  		// INVOICE INFORMATION ENDED



//ROW
if(payment_terms.equals("NET 30 DAYS")){
payment_name="";payment_address1="";payment_address2="";payment_city="";payment_state="";payment_zip="";
		payment_credit_type="";payment_credit_no="";payment_material_sales="0";	payment_tax="0";payment_total_charged="0";
                             }

        out.println("<tr>");
        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tddash'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
        out.println("<td class='tdnodash' width='50%'>PAYMENT TERMS:&nbsp;<b>"+payment_terms+"</b></td>");
        out.println("<td class='tdnodash' width='50%'>NAME ON CREDIT CARD:&nbsp;<b>"+payment_name+"<b></td>");
		out.println("</tr>");
		out.println("</table></td>");
  		out.println("</tr>");


		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"ADDRESS:&nbsp;<b>"+payment_address1+",&nbsp;"+payment_address2+"</b><td>");
		out.println("</tr>");
//ROW
		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"CITY/STATE/ZIP:&nbsp;<b>"+payment_city+", &nbsp;"+payment_state+"&nbsp;&nbsp;"+payment_zip+"</b><td>");
		out.println("</tr>");
//ROW
        out.println("<tr>");
        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tddash'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
        out.println("<td class='tdnodash' width='33%'>CREDIT CARD TYPE:&nbsp;<b>"+payment_credit_type+"</td>");
        out.println("<td class='tdnodash' width='33%'>CREDIT CARD NUMBER:&nbsp;<b>"+payment_credit_no+"</td>");
if(payment_terms.equals("CC")|payment_terms.equals("CC1")){
		out.println("<td class='tdnodash' width='33%'>EXPIRE DATE:&nbsp;<b>"+payment_exp_date+"</td>");
		}
		out.println("</tr>");
		out.println("</table></td>");
  		out.println("</tr>");
	if (pay_coun<=0){
payment_material_sales="0";
payment_tax="0";
payment_total_charged="0";
	}
//ROW

        out.println("<tr>");
        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tdsolid'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");

//      out.println("<td class='tdnodash' width='33%'>TOTAL MATERIAL SALES:&nbsp;<b>"+for1.format(new Double(payment_material_sales).doubleValue())+"</td>");
        out.println("<td class='tdnodash' width='33%'>TOTAL MATERIAL SALES:&nbsp;<b>"+for1.format(new Double(totmat_price).doubleValue())+"</td>");
        out.println("<td class='tdnodash' width='33%'>TAX:&nbsp;<b>"+for1.format(new Double(payment_tax).doubleValue())+"</td>");
		out.println("<td class='tdnodash' width='33%'>TOTAL CHARGED TO THE CARD:&nbsp;<b>"+for1.format(new Double(payment_total_charged).doubleValue())+"</td>");
		out.println("</tr>");
		out.println("</table></td>");
  		out.println("</tr>");
//ROW
//

	//row
		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tddashtop' bordercolor='#C0C0C0'>"+"SHIP TO NAME:&nbsp;<b>"+ship_name+"<td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"ADDRESS:&nbsp;<b>"+ship_addr1+",&nbsp;"+ship_addr2+"<td>");
		out.println("</tr>");
//ROW
		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"CITY/STATE/ZIP:&nbsp;<b>"+ship_city+",&nbsp;"+ship_state+"&nbsp;&nbsp;"+ship_zip+"<td>");
		out.println("</tr>");
//ROW
        out.println("<tr>");
        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tddash'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
        out.println("<td class='tdnodash' width='12%'>PHONE:</td>");
        out.println("<td class='tdnodash' width='40%'>&nbsp;<b>"+ship_phone+"</td>");
        out.println("<td class='tdnodash' width='15%'>FAX:</td>");
        out.println("<td class='tdnodash' width='35%'>&nbsp;<b>"+ship_fax+"</td>");
		out.println("</tr>");
		out.println("</table></td>");
  		out.println("</tr>");
//ROW
		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"SHIPPING METHOD:&nbsp;<b>"+ship_method+"<td>");
		out.println("</tr>");
//ROW

//ROW
//		out.println("<tr>");
//		out.println("<td width='100%' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"SPECIAL SHIPPING INSRTUCTIONS:&nbsp;<b>"+ship_terms+"<td>");
//		out.println("</tr>");

//ROW
        out.println("<tr>");
        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tdsolid'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
        out.println("<td class='tdnodash' width='33%'>REQUEST SHIP DATE:&nbsp;<b>"+ship_rdate+"</b></td>");
//        out.println("<td class='tdnodash' width='33%'>FIRM DATE:&nbsp;<b>"+ship_edate+"</b></td>");
//		out.println("<td class='tdnodash' width='34%'>ESTIMATED DATE:&nbsp;<b>"+ship_fdate+"</b></td>");
		out.println("</tr>");
		out.println("</table></td>");
  		out.println("</tr>");
//ROW
	//row
		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tddashtop' bordercolor='#C0C0C0'>"+"OWNER/END USER NAME:&nbsp;<b>"+eu_cust_name1+"</b><td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"ADDRESS:&nbsp;<b>"+eu_cust_addr1+",&nbsp;"+eu_cust_addr2+"</b><td>");
		out.println("</tr>");
//ROW
		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"CITY/STATE/ZIP:&nbsp;<b>"+eu_city+",&nbsp;"+eu_state+"&nbsp;&nbsp;"+eu_zip_code+"</b><td>");
		out.println("</tr>");
//ROW
        out.println("<tr>");
        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tdsolid'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
        out.println("<td class='tdnodash' width='33%'>PHONE:&nbsp;<b>"+eu_phone+"</b></td>");
        out.println("<td class='tdnodash' width='33%'>FAX:&nbsp;<b>"+eu_fax+"</b></td>");
		out.println("<td class='tdnodash' width='34%'>MARKET TYPE:&nbsp;<b>"+market_type1+"</b></td>");
		out.println("</tr>");
		out.println("</table></td>");
  		out.println("</tr>");
//ROW
	//row

        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tddashtop'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
        out.println("<td class='tdnodash' width='50%'>SUBMITTALS BY:<b> "+submit_by+"</b></td>");
        out.println("<td class='tdnodash' width='50%'>NUMBER OF COPIES REQUIRED:<b> "+copies_requested+"</b></td>");
		out.println("</tr>");
		out.println("</table></td>");
//ROW
		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"FACTORY CONTACT:<b> "+email_to+"</b><td>");
		out.println("</tr>");
//ROW
		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tdsolid' bordercolor='#C0C0C0'>"+"SPECIAL INSTRUCTIONS:<b> "+special_notes+"</b><td>");
		out.println("</tr>");

//row

// Checking if the architect is required
if(arch_required.equals("N")){
arch_name="NONE";arch_addr1="";arch_addr2="";arch_city="";arch_state="";arch_zip="";
arch_phone="";arch_fax="";
                             }
		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tddashtop' bordercolor='#C0C0C0'>"+"ARCHITECT'S FIRM NAME:<b> "+arch_name+"</b><td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"ADDRESS:&nbsp;<b> "+arch_addr1+",&nbsp;"+arch_addr2+"</b><td>");
		out.println("</tr>");
//ROW
		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"CITY/STATE/ZIP:&nbsp;<b> "+arch_city+",&nbsp;"+arch_state+"&nbsp;&nbsp;"+arch_zip+"</b><td>");
		out.println("</tr>");
//ROW

//ROW
        out.println("<tr>");
        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tdsolid'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
        out.println("<td class='tdnodash' width='50%'>PHONE:<b> "+arch_phone+"</b></td>");
        out.println("<td class='tdnodash' width='50%'>FAX:<b> "+arch_fax+"</b></td>");
		out.println("</tr>");
		out.println("</table></td>");
  		out.println("</tr>");
//ROW
out.println("<tr>");
out.println("<td align='center' width='100%' height='30' class='tdheader1'>"+"&nbsp;SEE NEXT PAGE FOR MORE INFORMATION"+"</td>");
out.println("</tr>");

out.println("<tr>");
out.println("<td width='30%' height='30%' class='test1' bordercolor='#C0C0C0'>"+"&nbsp; Order Information: "+"<td>");
out.println("<td width='70%' height='30%' bordercolor='#C0C0C0'>"+"&nbsp;"+"<td>");
out.println("</tr>");
String schedule="";double com_perc=0;String markf="";String gas_color="NONE";

if(project_type != null && project_type.equals("PSA")){
	 out.println("<Tr><TD><BR>PER QUOTE : "+order_no +"<BR><BR><td></tr>");












String schedule="";double com_perc=0;String markf="";String gas_color="NONE";
// for the schdule
										for(int k=0;k<line;k++){
				//out.println("QTY1"+QTY.elementAt(k)+"<br>");
												String bgcolor="";
							if ((k%2)==1){bgcolor="white";}else {bgcolor="#E7E7E7";}
							for (int mn=0;mn<line_item.size();mn++){
							if ((line_item.elementAt(mn).toString()).equals((items.elementAt(k).toString()))){
							String totwt=price.elementAt(mn).toString();//Extended_Price
							String fact=fact_per.elementAt(mn).toString().trim();//FIELD16
							quan=QTY.elementAt(mn).toString();//QTY
							if ((fact.equals(""))){fact="0.0"; }
							  BigDecimal d1 = new BigDecimal(totwt);
						      BigDecimal d2 = new BigDecimal(fact);
							  BigDecimal d3 = d1.multiply(d2);
//l							  d3 = d3.setScale(0, BigDecimal.ROUND_HALF_UP);
						      factor = factor+d3.doubleValue();// total comission dollars
							 totprice=totprice+d1.doubleValue();//just the materail price no comission
							totprice_dis=totprice_dis+d1.doubleValue();//
							//The desription
							if (!((price.elementAt(mn).toString()).startsWith("0.00"))){
							description=(desc.elementAt(mn)).toString();
							}
							markf=(mark.elementAt(mn)).toString();
//							if ((rec_no.elementAt(mn).toString()).equals("17622")){
							if (((desc.elementAt(mn).toString()).startsWith("Gasket Color"))){
					gas_color=(desc.elementAt(mn).toString()).substring(((desc.elementAt(mn).toString()).indexOf("Gasket Color - "))+15);
																		          }
//The Comission percentage
							if (((block_id.elementAt(mn).toString()).startsWith("PRICI"))&(!(((fact_per.elementAt(mn)).toString().trim()).equals("")))){
							String field_16=(fact_per.elementAt(mn)).toString().trim();
							if(field_16.equals("")){field_16="0.0";}
//out.println("THe priority"+prio);
							//if (prio.equals("E")){
							//BigDecimal d4 = new BigDecimal(field_16);
							//com_perc=((d4.doubleValue()*100));
							//}
						//	else{
							BigDecimal d4 = new BigDecimal(field_16);
							BigDecimal d6 = new BigDecimal("0.91");
							BigDecimal d5 = d4.divide(d6,0);
							com_perc=((d5.doubleValue()*100));
						//	}
																						}


																											  }
				                      								}
				                      								}


        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
//Set up cost has been removed (new Double(setup_cost).doubleValue())
		totprice_dis=totprice_dis+(new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(freight_cost).doubleValue());
        out.println("<td class='tdnodash' width='33%'>TOTAL PRICE($):&nbsp;<b>"+for1.format(totprice_dis)+"</b></td>");

























	 }
	 else{
out.println("<tr>");
out.println("<td width='100%' height='30%'  bordercolor='#C0C0C0'>");
out.println("<table width='100%' border='1' cellspacing='0' cellpadding='0' class='tb'>");
	if(project_type != null && project_type.equals("NCP")){

// out.println("HERE2");
		if(nonconfigPRICE == null || nonconfigPRICE.equals("null")){	nonconfigPRICE="0";	}
		totprice_dis=totprice_dis+new Double(nonconfigPRICE).doubleValue();
		out.println("<tr><td height='30' class='tdheader2'>"+nonconfigDesc+"</td></tr>");

	}
	else{
out.println("<tr>");
out.println("<td align='center' height='30' class='tdheader2'>MARK</td>");
out.println("<td align='center' height='30' class='tdheader2'>PRODUCT</td>");
out.println("<td align='center' height='30' class='tdheader2'>QTY</td>");
out.println("<td align='center' height='30' class='tdheader2'>GASKET COLOR</td>");
out.println("<td align='center' height='30' class='tdheader2'>EXT. PRICE</td>");
out.println("</tr>");
String schedule="";double com_perc=0;String markf="";String gas_color="NONE";
// for the schdule
										for(int k=0;k<line;k++){
				//out.println("QTY1"+QTY.elementAt(k)+"<br>");
												String bgcolor="";
							if ((k%2)==1){bgcolor="white";}else {bgcolor="#E7E7E7";}
							for (int mn=0;mn<line_item.size();mn++){
							if ((line_item.elementAt(mn).toString()).equals((items.elementAt(k).toString()))){
							String totwt=price.elementAt(mn).toString();//Extended_Price
							String fact=fact_per.elementAt(mn).toString().trim();//FIELD16
							quan=QTY.elementAt(mn).toString();//QTY
							if ((fact.equals(""))){fact="0.0"; }
							  BigDecimal d1 = new BigDecimal(totwt);
						      BigDecimal d2 = new BigDecimal(fact);
							  BigDecimal d3 = d1.multiply(d2);
//l							  d3 = d3.setScale(0, BigDecimal.ROUND_HALF_UP);
						      factor = factor+d3.doubleValue();// total comission dollars
							 totprice=totprice+d1.doubleValue();//just the materail price no comission
							totprice_dis=totprice_dis+d1.doubleValue();//
							//The desription
							if (!((price.elementAt(mn).toString()).startsWith("0.00"))){
							description=(desc.elementAt(mn)).toString();
							}
							markf=(mark.elementAt(mn)).toString();
//							if ((rec_no.elementAt(mn).toString()).equals("17622")){
							if (((desc.elementAt(mn).toString()).startsWith("Gasket Color"))){
					gas_color=(desc.elementAt(mn).toString()).substring(((desc.elementAt(mn).toString()).indexOf("Gasket Color - "))+15);
																		          }
//The Comission percentage
							if (((block_id.elementAt(mn).toString()).startsWith("PRICI"))&(!(((fact_per.elementAt(mn)).toString().trim()).equals("")))){
							String field_16=(fact_per.elementAt(mn)).toString().trim();
							if(field_16.equals("")){field_16="0.0";}
//out.println("THe priority"+prio);
							//if (prio.equals("E")){
							//BigDecimal d4 = new BigDecimal(field_16);
							//com_perc=((d4.doubleValue()*100));
							//}
							//else{
							BigDecimal d4 = new BigDecimal(field_16);
							BigDecimal d6 = new BigDecimal("0.91");
							BigDecimal d5 = d4.divide(d6,0);
							com_perc=((d5.doubleValue()*100));
							//}
																						}

}
																											  }
				                      								}
/*out.println("<tr>");
out.println("<td align='left' colspan='5' bgcolor="+bgcolor+" class='tdheader2'>&nbsp;"+schedule+"</td>");
out.println("</tr>");
*/
out.println("<tr>");
out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+"> &nbsp;"+markf+"</td>");
out.println("<td align='left' class='tdheader2' bgcolor="+bgcolor+">&nbsp;"+description+"</td>");
out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+">&nbsp;"+quan+"</td>");
out.println("<td align='center' class='tdheader2' bgcolor="+bgcolor+">&nbsp;"+gas_color+"</td>");
//out.println("<td>&nbsp;</td>");
if(project_type.equals("web")){
	for1.setMaximumFractionDigits(2);
	for1.setMinimumFractionDigits(2);
}
else{
	for1.setMaximumFractionDigits(0);
}
out.println("<td align='RIGHT' class='tdheader2' bgcolor="+bgcolor+">&nbsp;"+for1.format(totprice)+"</td>");
out.println("</tr>");
//intializing the values
totprice=0;
imp.clear();
schedule="";markf="";gas_color="NONE";
                      }// END OF THE FOR LOOP
out.println("</table>");
out.println("<td>");
out.println("</tr>");

NumberFormat for12 = NumberFormat.getInstance();
for12.setMaximumFractionDigits(1);


// Next row
        out.println("<tr>");
        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tddashtop'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
//Set up cost has been removed (new Double(setup_cost).doubleValue())
		totprice_dis=totprice_dis+(new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(freight_cost).doubleValue());
        out.println("<td class='tdnodash' width='33%'>TOTAL PRICE($):&nbsp;<b>"+for1.format(totprice_dis)+"</b></td>");
        out.println("<td class='tdnodash' width='33%'>STD.COMISSION:&nbsp;<b>"+for1.format(factor)+"</b></td>");
		out.println("<td class='tdnodash' width='33%'>OVERAGE AMOUNT($):&nbsp;<b>"+for1.format(new Double(overage).doubleValue())+"</b></td>");
		out.println("</tr>");
		out.println("</table></td>");
  		out.println("</tr>");
		out.println("<tr>");
        out.println("<td width='100%' bordercolor='#C0C0C0' height='10%' class='tdsolid'>");
        out.println("<table border='0' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
        out.println("<tr>");
        out.println("<td class='tdnodash' width='25%'>HANDLING CHARGES:&nbsp;<b>"+for1.format(new Double(handling_cost).doubleValue())+"</b></td>");
//        out.println("<td class='tdnodash' width='25%'>SETUP COST($):&nbsp;<b>"+for1.format(new Double(setup_cost).doubleValue())+"</b></td>");
        out.println("<td class='tdnodash' width='25%'>SETUP COST($):&nbsp;<b>"+"0.0"+"</b></td>");
		out.println("<td class='tdnodash' width='25%'>EXTRA CHARGES:&nbsp;<b>"+for1.format(new Double(freight_cost).doubleValue())+"</b></td>");
		out.println("<td class='tdnodash' width='25%'>STD COMISSION(%):&nbsp;<b>"+for12.format((factor/((totprice_dis-((new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(freight_cost).doubleValue())))*.91))*100)+"</b></td>");
		out.println("</tr>");
		out.println("</table></td>");
  		out.println("</tr>");
}
out.println("<tr>");
out.println("<td align='center' width='100%' height='30' class='tdheader'>"+"&nbsp;"+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td alighn-'left' width='100%' height='30' class='tdheader'>");
out.println("Order Sheet generated by "+userName+"<BR>");
out.println("</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align='center' width='100%' height='30' class='tdheader'>"+"&nbsp;ORDER NOTES"+"</td>");
out.println("</tr>");


		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"&nbsp;"+order_notes+"<td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"&nbsp;"+"<td>");
		out.println("</tr>");
		out.println("<tr>");
		out.println("<td width='100%' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"&nbsp;"+"<td>");
		out.println("</tr>");

out.println("</table>");
myConn.commit();
stmt.close();
myConn.close();

 %>
</body>
</html>

