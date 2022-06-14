<%@ page import = "java.io.*,java.util.*,javax.servlet.*" %>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.SimpleDateFormat"%>
<html>
	<head><title>ORDER SHEET</title>
		<link rel='stylesheet' href='order1.css' type='text/css' />
		<style type="text/css" media="print">
			.printbutton {
				visibility: hidden;
				display: none;
			}
		</style>
	</head>
	<body>
<!-- 		<script>
			document.write("<input type='button' "+
				   "onClick='window.print()' "+
				   "class='printbutton' "+
				   "value='Print This Page'/>");
		</script> -->

		<%!
		public static double round(double value, int places) {
		    if (places < 0) throw new IllegalArgumentException();

		    BigDecimal bd = new BigDecimal(value);
		    bd = bd.setScale(places, RoundingMode.HALF_UP);
		    return bd.doubleValue();
		}
		%>

		<%

			java.util.Date date_required = new java.util.Date(); // Right now
			double totcomm_dol=0;
		String submit_prep="";String email_to="";String submit_by="";String special_notes="";
		String copies_requested="";String type_of_quote="";String order_notes="";String cust_order_notes="";String drafting_email="";String image_contact_email="";

		NumberFormat for1 = DecimalFormat.getCurrencyInstance();
		 for1.setMaximumFractionDigits(numDecimals);
		 for1.setMinimumFractionDigits(numDecimals);

		//eorders for the
		String prio="";String order_entry_indicator="";

				ResultSet e_order = stmt.executeQuery("SELECT * FROM doc_header where doc_number like '"+order_no+"' ");
				if (e_order !=null) {
			   while (e_order.next()) {
				prio= e_order.getString("doc_priority");
				order_entry_indicator= e_order.getString("doc_stage");
										}
									 }
									 e_order.close();

		// cs_order_info
if(order_entry_indicator==null){
order_entry_indicator="";
}

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
				cust_order_notes= rs_order.getString("customer_notes");
				order_rep=rs_order.getString("order_rep");
				terr_rep=rs_order.getString("terr_rep");
				spec_rep=rs_order.getString("spec_rep");
				extra_order_notes=rs_order.getString("extra_order_notes");
				drafting_email=rs_order.getString("drafting_email");
				image_contact_email=rs_order.getString("image_contact_email");
										}
									}
									rs_order.close();
if(type_of_quote==null||type_of_quote.equals("null")){
	type_of_quote="";
}
if(drafting_email==null){
	drafting_email="";
}
if(image_contact_email==null){
	image_contact_email="";
}

				if(order_notes == null||order_notes.trim().length()<=0){
					order_notes="";
				}
				else{
					order_notes="<u>order notes:</u>"+order_notes;
				}
				if(cust_order_notes == null||cust_order_notes.trim().length()<=0){
					cust_order_notes="";
				}
				else{
					cust_order_notes="<u>customer order notes:</u>"+cust_order_notes;
				}

		//Invoice variables
				String invoice_name="";String invoice_addr1="";String invoice_addr2="";String invoice_city="";String invoice_state="";
				String invoice_zip="";String invoice_phone="";String invoice_fax="";String invoice_email="";String attention_invoice="";
				String invoice_cust_no="";
				// Getting the Invoice info
						ResultSet rs_invoice = stmt.executeQuery("SELECT * FROM cs_invoice where Order_no like '"+order_no+"' ");
						if (rs_invoice !=null) {
					   while (rs_invoice.next()) {

						if(rs_invoice.getString("bpcs_cust_no") != null && !rs_invoice.getString("bpcs_cust_no").equals("0")){
							invoice_cust_no="("+rs_invoice.getString("bpcs_cust_no")+")";
						}
						invoice_name= rs_invoice.getString("name1");
						invoice_addr1= rs_invoice.getString("address1");
						invoice_addr2= rs_invoice.getString("address2");
						invoice_city= rs_invoice.getString("City");
						invoice_state= rs_invoice.getString("State");
						invoice_zip= rs_invoice.getString("Zip_code");
						invoice_phone= rs_invoice.getString("Phone");
						invoice_fax= rs_invoice.getString("fax");
						invoice_email= rs_invoice.getString("email");
						attention_invoice=rs_invoice.getString("attention");
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
				String cust_no="";
				String eu_cust_no="";
				//Customer tbale
				String eu_cust_name1="";String eu_cust_addr1="";String eu_cust_addr2="";String eu_city="";String eu_state="";String eu_zip_code="";
				String eu_phone="";String eu_fax="";String market_type1="";
				//
				ResultSet rs_bill = stmt.executeQuery("SELECT * FROM cs_billed_customers where order_no like '"+order_no+"' ");
				if (rs_bill !=null) {
			   while (rs_bill.next()) {
				//cust_no=rs_bill.getString("bpcs_cust_no");
				if(rs_bill.getString("bpcs_cust_no") != null && !rs_bill.getString("bpcs_cust_no").equals("0")){
						cust_no="("+rs_bill.getString("bpcs_cust_no")+")";
				}
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
									    }
							 }
							 rs_bill.close();

				if(billed_email == null){ billed_email="";}
				billed_email=billed_email.replaceAll("<","&lt");
				billed_email=billed_email.replaceAll(">","&gt");
				ResultSet rs_customer = stmt.executeQuery("SELECT * FROM cs_end_users where order_no like '"+order_no+"'");
				if (rs_customer !=null) {
			   while ( rs_customer.next() ) {
					if(rs_customer.getString("bpcs_cust_no") != null && !rs_customer.getString("bpcs_cust_no").equals("0")){
						eu_cust_no="("+rs_customer.getString("bpcs_cust_no")+")";
					}
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
										
				//invoking cs_quote_sections to get the transferred date
				String sectionTransfer = null;
				String numberOfSections = null;
				ResultSet csQuotesSectionRS = stmt.executeQuery("SELECT sections,section_transfer from cs_quote_sections where order_no like '"+order_no+"'");
				if (csQuotesSectionRS !=null) {
				   while (csQuotesSectionRS.next()){
					   numberOfSections=csQuotesSectionRS.getString("sections");
					   sectionTransfer=csQuotesSectionRS.getString("section_transfer");
				   }
				}
				csQuotesSectionRS.close();
				
				String[] sectionSpecificValue = null;
				String[] dateParts1 = null;
				String[] dateParts2 = null;
				String sectionTransferredDate = null;
				String latestSectionTransferred = null;
				
				sectionSpecificValue = sectionTransfer.split(";");
				int totalSections = Integer.parseInt(numberOfSections);
				
				if(!sectionTransfer.isEmpty()){
					if(!(totalSections>0)){
						dateParts1 = sectionTransfer.split("@");
						dateParts2 = dateParts1[0].toString().split("=");
						sectionTransferredDate = dateParts2[1];					
					}else{					
						latestSectionTransferred = sectionSpecificValue[sectionSpecificValue.length-1];			 
						dateParts1 = latestSectionTransferred.split("@");
						dateParts2 = dateParts1[0].toString().split("=");					
						sectionTransferredDate = dateParts2[1]; 
					}
				}
				
				if(sectionTransferredDate==null || sectionTransferredDate.isEmpty()){
					SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
					sectionTransferredDate=df.format(new java.util.Date()); 
				}else{
					SimpleDateFormat df = new SimpleDateFormat("MM/dd/yyyy");
					sectionTransferredDate=df.format(new java.util.Date(sectionTransferredDate));
				}
				
				
		// vars for the credit card info
if(market_type==null||market_type.equals("null")){
	market_type="";
}
		String payment_method="";String payment_name="";String payment_address1="";
		String payment_address2="";String payment_city="";String payment_state="";String payment_zip="";
		String payment_credit_type="";String payment_credit_no="";int pay_coun=0;
		//String payment_exp_date="";
			//java.util.Date payment_exp_date = new java.util.Date();
		String payment_material_sales="";String payment_tax="";String payment_total_charged="";String payment_exp_date ="";
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
				payment_exp_date= rs_payment.getString("exp_date");
				payment_material_sales= rs_payment.getString("total_material_sales");
				payment_tax= rs_payment.getString("tax");
				payment_total_charged= rs_payment.getString("total_charged");
				pay_coun++;
										  }
								   }
								   rs_payment.close();
if(payment_credit_no != null && payment_credit_no.trim().length()>4){
	payment_credit_no="***************"+payment_credit_no.substring(payment_credit_no.length()-4);
}
				if(pay_coun<=0){



		}
// shipping info

//Ship variables
String ship_name="";String ship_addr1="";String ship_addr2="";String ship_city="";String ship_state="";
String ship_zip="";String ship_phone="";String ship_fax="";String ship_email="";String ship_method="";
String ship_tax_exempt="";String ship_terms="";String ship_rdate="";String ship_attention="";
String ship_prior_notice_name="";String ship_prior_notice_phone="";String ship_prior_notice="";
String ship_cust_no="";
//java.util.Date ship_rdate = new java.util.Date();
//java.util.Date ship_edate = new java.util.Date();
//java.util.Date ship_fdate = new java.util.Date();
//String ship_rdate="";String ship_edate="";String ship_fdate="";
// Getting the shipping info
		ResultSet rs_ship = stmt.executeQuery("SELECT * FROM SHIPPING where Order_no like '"+order_no+"' ");
		if (rs_ship !=null) {
        while (rs_ship.next()) {
			if(rs_ship.getString("bpcs_cust_no") != null && !rs_ship.getString("bpcs_cust_no").equals("0")){
				ship_cust_no="("+rs_ship.getString("bpcs_cust_no")+")";
			}
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
		ship_attention= rs_ship.getString("attention");
		ship_prior_notice_name= rs_ship.getString("prior_notice_name");
		ship_prior_notice_phone= rs_ship.getString("prior_notice_phone");
		ship_prior_notice= rs_ship.getString("prior_notice");
//		ship_edate= rs_ship.getDate("estimated_date");
//		ship_fdate= rs_ship.getDate("firm_date");
							   }
						   }
						   rs_ship.close();
// Getting the shipping info	end
// vars for arch

		//Date format changes for Request ship date
				String endDateFormat = "MM-dd-yyyy";
				String initDateFormat = "yyyy-MM-dd";
				if (ship_rdate != null && !ship_rdate.isEmpty() && ship_rdate != null) {
						java.util.Date initDate = new SimpleDateFormat(initDateFormat).parse(ship_rdate);
						SimpleDateFormat formatter = new SimpleDateFormat(endDateFormat);
						String parsedDate = formatter.format(initDate);
						ship_rdate = parsedDate;	
					}

String arch_name="";String arch_addr1="";String arch_addr2="";String arch_city="";String arch_state="";
String arch_zip="";String arch_phone="";String arch_fax="";String arch_email="";String arch_required="";
if(ship_prior_notice_name==null){ship_prior_notice_name=" ";}if(ship_prior_notice_phone==null){ship_prior_notice_phone=" ";}
	if(ship_prior_notice==null){ship_prior_notice=" ";}
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

//Getting the Architect done

							 //rs3.close();

if(order_rep==null || order_rep.trim().length()==0){
	order_rep=rep_no;
}
String rep_name="";
// Getting the Rep's name
		ResultSet rs3_rep = stmt.executeQuery("SELECT rep_account FROM cs_reps where rep_no = '"+order_rep+"' ");
        while ( rs3_rep.next() ) {
		rep_name=rs3_rep.getString("rep_account");
							 }
			rs3_rep.close();

if(fax==null||fax.equals("null")){
	fax="";
}
if(arch_fax==null||arch_fax.equals("null")){
	arch_fax="";
}
if(ship_fax==null||ship_fax.equals("null")){
	ship_fax="";
}
if(eu_fax==null||eu_fax.equals("null")){
	eu_fax="";
}
if(invoice_fax==null||invoice_fax.equals("null")){
	invoice_fax="";
}
// Displaying the final form
//out.println(type_of_quote+":: TYPE");
out.println("<table width='100%' border='0px solid black' align='center' cellspacing='0' cellpadding='0' class=''>");
out.println("<tr>");
if(type_of_quote.equals("DECOGARD")){
	type_of_quote="FACILITY SALES";
}

if(project_type.equals("PSA")){
	out.println("<td align='center' height='30' class='tdheader' colspan='8'><img src='http://csimages.c-sgroup.com/eRapid/cs-logo_email.jpg'  alt='CS Logo'><BR>"+type_of_quote+"&nbsp;&nbsp;FACTORY ORDER SHEET"+"</td>");
}
else{
	out.println("<td align='center' height='20' class='tdheader' colspan='7'><img align='left' style='margin-left:-30px;' src='cs-logo.jpg' alt='CS Logo'></td>");
}
out.println("</tr>");

out.println("<tr>");
out.println("<td align='center' height='20' class='tdheader' colspan='7'>"+type_of_quote+"&nbsp;&nbsp;ORDER SHEET"+"</td>");
out.println("</tr>");

out.println("<tr><td align='left'><div id='sideHead'><p style='font-size:14px;color:black;margin-top:0px;font-stretch:expanded;'><b>ORDER DETAILS</b></p></div></td>");
out.println("<td colspan='8' align='right' height='10%' class='tdOrder' bordercolor='#C0C0C0'>"+"Date: <B>"+sectionTransferredDate+"</B></td>");
out.println("</tr>");
out.println("<tr><td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td></tr>");
out.println("<tr align='center'>");
String tempDocType=doc_type;
if(quote_origin != null && quote_origin.equals("sample")){
	tempDocType="SAMPLE";
}

//Null Checks on Order details
if(tempDocType == null || tempDocType.equalsIgnoreCase("null")){
	tempDocType="";
}
if(add_deduct_job == null || add_deduct_job.equalsIgnoreCase("null")){
	add_deduct_job="";
}
if(sales_region == null || sales_region.equalsIgnoreCase("null")){
	sales_region="";
}
if(cs_company == null || cs_company.equalsIgnoreCase("null")){
	cs_company="";
}
if(order_rep == null || order_rep.equalsIgnoreCase("null")){
	order_rep="";
}
if(rep_name == null || rep_name.equalsIgnoreCase("null")){
	rep_name="";
}
if(Project_name == null || Project_name.equalsIgnoreCase("null")){
	Project_name="";
}
if(Job_loc == null || Job_loc.equalsIgnoreCase("null")){
	Job_loc="";
}

out.println("<td align='RIGHT' height='10%' class='tdOrder' bordercolor='#C0C0C0'>"+"ORDER TYPE&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='LEFT' height='10%' class='tdOrder' bordercolor='#C0C0C0'><b>"+tempDocType+"</b></td>");
out.println("<td align='RIGHT' height='10%' class='tdOrder' bordercolor='#C0C0C0'>ADD/DEDUCT&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='LEFT' height='10%' class='tdOrder' bordercolor='#C0C0C0'><b>"+add_deduct_job+"</b></td>");

out.println("</tr>");


     //out.println("<table border='1' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
out.println("<tr>");
out.println("<td align='RIGHT' width='20%' class='tdOrder' >SALES REGION&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='LEFT' width='20%' class='tdOrder' align='LEFT' ><b>"+sales_region+"</b></td>");
out.println("<td align='RIGHT' width='20%' class='tdOrder' >COMPANY DIVISION &nbsp;&nbsp;:&nbsp;&nbsp; </td>");
out.println("<td align='LEFT' width='20%' class='tdOrder' ><b>"+cs_company+"</b></td>");
/**/
out.println("</tr>");

out.println("<tr>");
out.println("<td align='RIGHT' class='tdOrder' >REP#&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='LEFT' class='tdOrder' ><b>"+order_rep+"</b></td>");
out.println("<td align='RIGHT' class='tdOrder' >REP NAME&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='LEFT' class='tdOrder' ><b>"+rep_name+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td  align='RIGHT' height='10%' class='tdOrder' bordercolor='#C0C0C0'>"+"PROJECT NAME &nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td  align='LEFT' class='tdOrder'><b>"+Project_name+"</b></td>");
out.println("<td align='RIGHT' class='tdOrder' >"+"QUOTE NO&nbsp;&nbsp;:&nbsp;&nbsp;"+"</td>");
out.println("<td align='LEFT'  class='tdOrder' ><b>"+order_no+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td  align='RIGHT' height='10%' class='tdOrder' bordercolor='#C0C0C0'>"+"LOCATION &nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td  align='LEFT' class='tdOrder'><b>"+Job_loc+"</b></td>");
out.println("<td align='RIGHT' class='tdOrder' >"+"&nbsp;"+"</td>");
out.println("<td align='LEFT'  class='tdOrder' ><b>&nbsp;</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("</tr>");

//Null Checks on Billing details
if(cust_name1 == null || cust_name1.equalsIgnoreCase("null")){
	cust_name1="";
}
if(cust_no == null || cust_no.equalsIgnoreCase("null")){
	cust_no="";
}
if(cust_addr1 == null || cust_addr1.equalsIgnoreCase("null")){
	cust_addr1="";
}
if(cust_addr2 == null || cust_addr2.equalsIgnoreCase("null")){
	cust_addr2="";
}
if(contact_name == null || contact_name.equalsIgnoreCase("null")){
	contact_name="";
}
if(city == null || city.equalsIgnoreCase("null")){
	city="";
}
if(state == null || state.equalsIgnoreCase("null")){
	state="";
}
if(zip_code == null || zip_code.equalsIgnoreCase("null")){
	zip_code="";
}
if(customer_type == null || customer_type.equalsIgnoreCase("null")){
	customer_type="";
}
if(phone == null || phone.equalsIgnoreCase("null")){
	phone="";
}
if(market_type == null || market_type.equalsIgnoreCase("null")){
	market_type="";
}
if(fax == null || fax.equalsIgnoreCase("null")){
	fax="";
}
if(customer_po_no == null || customer_po_no.equalsIgnoreCase("null")){
	customer_po_no="";
}
if(billed_email == null || billed_email.equalsIgnoreCase("null")){
	billed_email="";
}
if(sales_exempt_no == null || sales_exempt_no.equalsIgnoreCase("null")){
	sales_exempt_no="";
}

out.println("<tr><td align='left'><div id='sideHead'><p style='font-size:14px;color:black;margin-top:20px;font-stretch:expanded;'><b>BILLING DETAILS</b></p></div></td><td colspan='8' align='right' height='10%' class='tdOrder' bordercolor='#C0C0C0'>&nbsp;</td></tr>");
out.println("<tr><td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td></tr>");
out.println("<tr>");
out.println("<td align='right' class='tdOrder'>"+"BILLING CUSTOMER&nbsp;&nbsp;:&nbsp;&nbsp;</td><td align='left' class='tdOrder'><b>"+cust_name1+"&nbsp;"+cust_no+"</b></td>");
out.println("<td align='right' class='tdOrder' >ADDRESS&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder'><b>"+cust_addr1+",&nbsp;</b><td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</b></td>");
out.println("<td class='tddash' >&nbsp;</b></td>");
out.println("<td align='left' class='tdOrder'><b> "+cust_addr2+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align='right' class='tdOrder' >CONTACT NAME&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' ><b>"+contact_name+"</b></td>");
out.println("<td align='right' class='tdOrder' >CITY/STATE/ZIP&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder'><b>"+city+",&nbsp;"+state+"&nbsp;&nbsp;"+zip_code+"</b><td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align='right' class='tdOrder' >CUSTOMER TYPE&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' ><b>"+customer_type+"</b></td>");
out.println("<td align='right' class='tdOrder' >PHONE&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' ><b>"+phone+"</b></td>");
out.println("</tr>");

out.println("<tr>");
out.println("<td align='right' class='tdOrder' >MARKET TYPE&nbsp;&nbsp;:&nbsp;&nbsp;<b></td>");
out.println("<td align='left' class='tdOrder' ><b>"+market_type+"</b></b></td>");
out.println("<td align='right' class='tdOrder' >FAX&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' ><b>"+fax+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align='right' class='tdOrder' >CUST PO NUMBER&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' ><b>"+customer_po_no+"</b></td>");
out.println("<td align='right' class='tdOrder' >EMAIL&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' ><b>"+billed_email+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align='right' class='tdOrder' >TAX EXEMP NUMBER#&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder'><b>"+sales_exempt_no+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("</tr>");

//Null Checks on Invoice details
if(invoice_name == null || invoice_name.equalsIgnoreCase("null")){
	invoice_name="";
}
if(invoice_cust_no == null || invoice_cust_no.equalsIgnoreCase("null")){
	invoice_cust_no="";
}
if(invoice_addr1 == null || invoice_addr1.equalsIgnoreCase("null")){
	invoice_addr1="";
}
if(invoice_addr2 == null || invoice_addr2.equalsIgnoreCase("null")){
	invoice_addr2="";
}
if(attention_invoice == null || attention_invoice.equalsIgnoreCase("null")){
	attention_invoice="";
}
if(invoice_city == null || invoice_city.equalsIgnoreCase("null")){
	invoice_city="";
}
if(invoice_state == null || invoice_state.equalsIgnoreCase("null")){
	invoice_state="";
}
if(invoice_zip == null || invoice_zip.equalsIgnoreCase("null")){
	invoice_zip="";
}
if(payment_terms == null || payment_terms.equalsIgnoreCase("null")){
	payment_terms="";
}
if(invoice_phone == null || invoice_phone.equalsIgnoreCase("null")){
	invoice_phone="";
}
if(payment_credit_type == null || payment_credit_type.equalsIgnoreCase("null")){
	payment_credit_type="";
}
if(invoice_fax == null || invoice_fax.equalsIgnoreCase("null")){
	invoice_fax="";
}
if(invoice_email == null || invoice_email.equalsIgnoreCase("null")){
	invoice_email="";
}


out.println("<tr><td align='left' colspan='3'><div id='sideHead'><p style='font-size:14px;color:black;margin-top:20px;font-stretch:expanded;'><b>INVOICE DETAILS</b></p></div></td><td colspan='8' align='right' height='10%' class='tdOrder' bordercolor='#C0C0C0'>&nbsp;</td></tr>");
out.println("<tr><td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td></tr>");
out.println("<tr>");
out.println("<td  align='right' class='tdOrder'>"+"INVOICE TO NAME&nbsp;&nbsp;:&nbsp;&nbsp;</td><td  align='left' class='tdOrder'><b>"+invoice_name+"&nbsp; "+invoice_cust_no+"</b></td>");
out.println("<td align='right' class='tdOrder'>"+"ADDRESS&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder'><b>"+invoice_addr1+",&nbsp;</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</b></td>");
out.println("<td class='tddash' >&nbsp;</b></td>");
out.println("<td align='left' class='tdOrder'><b> "+invoice_addr2+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align='right' class='tdOrder' >"+"INVOICE ATTENTION&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder'><b>"+attention_invoice+"</b></td>");
out.println("<td align='right' class='tdOrder'>CITY/STATE/ZIP&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder'><b>"+invoice_city+",&nbsp;"+invoice_state+"&nbsp;&nbsp;"+invoice_zip+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("</tr>");


//ROW

		// INVOICE INFORMATION ENDED
//ROW
if(payment_terms.equals("NET 30 DAYS")){
payment_name="";payment_address1="";payment_address2="";payment_city="";payment_state="";payment_zip="";
		payment_credit_type="";payment_credit_no="";payment_material_sales="0";	payment_tax="0";payment_total_charged="0";
                             }


out.println("<tr>");
out.println("<td align='right' class='tdOrder' >PAYMENT TERMS&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder'><b>"+payment_terms+"</b></td>");
out.println("<td align='right' class='tdOrder'>PHONE&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' ><b>"+invoice_phone+"</b></td>");
out.println("</tr>");

out.println("<tr>");
out.println("<td align='right' class='tdOrder' >CREDIT CARD TYPE&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder'><b>"+payment_credit_type+"</b></td>");
out.println("<td align='right' class='tdOrder'>FAX&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' ><b>"+invoice_fax+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align='right' class='tdOrder' >&nbsp;&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' ><b>&nbsp;</b></td>");
out.println("<td align='right' class='tdOrder' >EMAIL&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' style='page-break-after: always;'><b>"+invoice_email+"</b></td>");
out.println("</tr>");




if(payment_credit_no != null && payment_credit_no.trim().length()>4){
	//out.println("<td class='tddash' width='33%'>CREDIT CARD NUMBER:&nbsp;<b>****************"+payment_credit_no.substring(payment_credit_no.length()-4)+"</b></td>");
}

if (pay_coun<=0){
	payment_material_sales="0";
	payment_tax="0";
	payment_total_charged="0";
}

//out.println("<tr>");
double grandTotal = 0.0;
double totalValue = Double.parseDouble(totmat_price);
double tax_dollar=((totalValue)*(Float.parseFloat(tax_perc)))/100;
NumberFormat forIWP = NumberFormat.getInstance();
		forIWP.setMaximumFractionDigits(2);
		//out.println("-------------------"+tax_dollar+" $$%%%$$ "+totmat_price+" totmatsales "+totmatsales);
		tax_dollar=Double.parseDouble(forIWP.format(tax_dollar).replace(",",""));
	//out.println("-------------------"+tax_dollar+" $$%%%$$ "+totmat_price+" totmatsales "+totmatsales);
//Below condition commented based on Greg's confirmation
//if(!payment_terms.equals("NET 30 DAYS") && payment_terms != ""){
	grandTotal = (new Double(totmat_price).doubleValue())+tax_dollar;
//}
/*
//      out.println("<td class='tddash' width='33%'>TOTAL MATERIAL SALES:&nbsp;<b>"+for1.format(new Double(payment_material_sales).doubleValue())+"</td>");
out.println("<td class='tddash' >TOTAL MATERIAL SALES:</td>");
out.println("<td class='tddash' ><b>"+for1.format(new Double(totmat_price).doubleValue())+"</b></td>");
out.println("<td class='tddash' >TAX:</td>");
out.println("<td class='tddash' ><b>"+for1.format(tax_dollar)+"</b></td>");
out.println("<td class='tddash' >TOTAL CHARGED TO THE CARD:&nbsp;<b></td>");
out.println("<td class='tddash' >"+for1.format(grandTotal)+"</b></td>");
out.println("</tr>");
*/

//Null Checks on Shipping details
if(ship_name == null || ship_name.equalsIgnoreCase("null")){
	ship_name="";
}
if(ship_cust_no == null || ship_cust_no.equalsIgnoreCase("null")){
	ship_cust_no="";
}
if(ship_addr1 == null || ship_addr1.equalsIgnoreCase("null")){
	ship_addr1="";
}
if(ship_addr2 == null || ship_addr2.equalsIgnoreCase("null")){
	ship_addr2="";
}
if(ship_method == null || ship_method.equalsIgnoreCase("null")){
	ship_method="";
}
if(ship_city == null || ship_city.equalsIgnoreCase("null")){
	ship_city="";
}
if(ship_state == null || ship_state.equalsIgnoreCase("null")){
	ship_state="";
}
if(ship_zip == null || ship_zip.equalsIgnoreCase("null")){
	ship_zip="";
}
if(ship_rdate == null || ship_rdate.equalsIgnoreCase("null")){
	ship_rdate="";
}
if(ship_phone == null || ship_phone.equalsIgnoreCase("null")){
	ship_phone="";
}
if(ship_prior_notice == null || ship_prior_notice.equalsIgnoreCase("null")){
	ship_prior_notice="";
}
if(ship_prior_notice_name == null || ship_prior_notice_name.equalsIgnoreCase("null")){
	ship_prior_notice_name="";
}
if(ship_prior_notice_phone == null || ship_prior_notice_phone.equalsIgnoreCase("null")){
	ship_prior_notice_phone="";
}
if(ship_fax == null || ship_fax.equalsIgnoreCase("null")){
	ship_fax="";
}
if(ship_email == null || ship_email.equalsIgnoreCase("null")){
	ship_email="";
}


out.println("<tr><td align='left'><div id='sideHead'><p style='font-size:14px;color:black;margin-top:20px;font-stretch:expanded;'><b>SHIPPING DETAILS</b></p></div></td><td colspan='8' align='right' height='10%' class='tdOrder' bordercolor='#C0C0C0'>&nbsp;</td></tr>");
out.println("<tr><td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td></tr>");
out.println("<tr>");
out.println("<td align='right' class='tdOrder'>SHIP TO NAME&nbsp;&nbsp;:&nbsp;&nbsp;</td><td align='left' class='tdOrder'><b>"+ship_name+"&nbsp; "+ship_cust_no+"</b></td>");
out.println("<td  align='right' class='tdOrder'>ADDRESS&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder'><b>"+ship_addr1+",&nbsp;</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</b></td>");
out.println("<td class='tddash' >&nbsp;</b></td>");
out.println("<td align='left' class='tdOrder'><b> "+ship_addr2+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align='right' class='tdOrder' >SHIPPING METHOD&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' ><b>"+ship_method+"</b></td>");
out.println("<td align='right' class='tdOrder'>"+"CITY/STATE/ZIP&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder'><b>"+ship_city+",&nbsp;"+ship_state+"&nbsp;&nbsp;"+ship_zip+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align='right' class='tdOrder' >REQUEST SHIP DATE&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder'><b>"+ship_rdate+"</b></td>");
out.println("<td align='right' class='tdOrder'>PHONE&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' ><b>"+ship_phone+"</b></td>");

out.println("</tr>");
out.println("<tr>");
out.println("<td align='right' class='tdOrder'>SHIP ATTENTION&nbsp;&nbsp;:&nbsp;&nbsp;</td><td align='left' class='tdOrder'><b>"+ship_attention+"</b></td>");
out.println("<td align='right' class='tdOrder' >FAX&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder'><b>"+ship_fax+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align='right' class='tdOrder' >DEL NOTICE(HRS)&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' ><b>"+ship_prior_notice+"</b></td>");
out.println("<td align='right' class='tdOrder' >DELIVERY NAME&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' ><b>"+ship_prior_notice_name+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align='right' class='tdOrder' >&nbsp;</td>");
out.println("<td align='left' class='tdOrder'><b>&nbsp;</b></td>");
out.println("<td align='right' class='tdOrder' >DELIVERY PHONE&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder'><b>"+ship_prior_notice_phone+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("</tr>");

//Null Checks on End user details
if(eu_cust_name1 == null || eu_cust_name1.equalsIgnoreCase("null")){
	eu_cust_name1="";
}
if(eu_cust_no == null || eu_cust_no.equalsIgnoreCase("null")){
	eu_cust_no="";
}
if(eu_cust_addr1 == null || eu_cust_addr1.equalsIgnoreCase("null")){
	eu_cust_addr1="";
}
if(eu_cust_addr2 == null || eu_cust_addr2.equalsIgnoreCase("null")){
	eu_cust_addr2="";
}
if(market_type1 == null || market_type1.equalsIgnoreCase("null")){
	market_type1="";
}
if(eu_city == null || eu_city.equalsIgnoreCase("null")){
	eu_city="";
}
if(eu_state == null || eu_state.equalsIgnoreCase("null")){
	eu_state="";
}
if(eu_zip_code == null || eu_zip_code.equalsIgnoreCase("null")){
	eu_zip_code="";
}
if(submit_by == null || ship_rdate.equalsIgnoreCase("null")){
	ship_rdate="";
}
if(eu_phone == null || eu_phone.equalsIgnoreCase("null")){
	eu_phone="";
}
if(copies_requested == null || copies_requested.equalsIgnoreCase("null")){
	copies_requested="";
}
if(drafting_email == null || drafting_email.equalsIgnoreCase("null")){
	drafting_email="";
}
if(image_contact_email == null || image_contact_email.equalsIgnoreCase("null")){
	image_contact_email="";
}
if(eu_fax == null || eu_fax.equalsIgnoreCase("null")){
	eu_fax="";
}
if(email_to == null || email_to.equalsIgnoreCase("null")){
	email_to="";
}
if(special_notes == null || special_notes.equalsIgnoreCase("null")){
	special_notes="";
}

out.println("<tr><td align='left'><div id='sideHead'><p style='font-size:14px;color:black;margin-top:20px;font-stretch:expanded;'><b>OWNER/END USER DETAILS</b></p></div></td><td colspan='8' align='right' height='10%' class='tdOrder' bordercolor='#C0C0C0'>&nbsp;</td></tr>");
out.println("<tr><td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td></tr>");
out.println("<td align='right' class='tdOrder'>"+"END USER NAME&nbsp;&nbsp;:&nbsp;&nbsp;</td><td align='left' class='tdOrder'><b>"+eu_cust_name1+" &nbsp;"+eu_cust_no+"</b></td>");
out.println("<td align='right' class='tdOrder'>"+"ADDRESS&nbsp;&nbsp;:&nbsp;&nbsp;</td><td align='left' class='tdOrder'><b>"+eu_cust_addr1+",&nbsp;</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</b></td>");
out.println("<td class='tddash' >&nbsp;</b></td>");
out.println("<td align='left' class='tdOrder'><b> "+eu_cust_addr2+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align='right' class='tdOrder'>MARKET TYPE&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' ><b>"+market_type1+"</b></td>");
out.println("<td align='right' class='tdOrder'>"+"CITY/STATE/ZIP&nbsp;&nbsp;:&nbsp;&nbsp;</td><td align='left' class='tdOrder'><b>"+eu_city+",&nbsp;"+eu_state+"&nbsp;&nbsp;"+eu_zip_code+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align='right' class='tdOrder'>SUBMITTALS BY&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' ><b> "+submit_by+"</b></td>");
out.println("<td align='right' class='tdOrder'>PHONE&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' ><b>"+eu_phone+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align='right' class='tdOrder' width='200'>NO OF COPIES REQ&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' ><b> "+copies_requested+"</b></td>");
out.println("<td align='right' class='tdOrder'>FAX&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' ><b>"+eu_fax+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align='right' class='tdOrder'>"+"FACTORY CONTACT&nbsp;&nbsp;:&nbsp;&nbsp;</td><td align='left' class='tdOrder'><b> "+email_to+"</b></td>");
out.println("<td align='right' class='tdOrder'>DRAFTING EMAIL&nbsp;&nbsp;:&nbsp;&nbsp;</td><td align='left' class='tdOrder'><b> "+drafting_email+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td align='right' class='tdOrder'>"+"ABD IMAGE CONTACT&nbsp;&nbsp;:&nbsp;&nbsp;</td><td align='left' class='tdOrder'><b> "+image_contact_email+"</b></td>");
out.println("<td align='right' class='tdOrder'>"+"SPECIAL INSTRUCTIONS&nbsp;&nbsp;:&nbsp;&nbsp;</td><td align='left' class='tdOrder'><b> "+special_notes+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("</tr>");

//Null Checks on Arch details
if(arch_name == null || arch_name.equalsIgnoreCase("null")){
	arch_name="";
}
if(arch_addr1 == null || arch_addr1.equalsIgnoreCase("null")){
	arch_addr1="";
}
if(arch_addr2 == null || arch_addr2.equalsIgnoreCase("null")){
	arch_addr2="";
}
if(arch_city == null || arch_city.equalsIgnoreCase("null")){
	arch_city="";
}
if(arch_state == null || arch_state.equalsIgnoreCase("null")){
	arch_state="";
}
if(arch_zip == null || arch_zip.equalsIgnoreCase("null")){
	arch_zip="";
}
if(arch_phone == null || arch_phone.equalsIgnoreCase("null")){
	arch_phone="";
}
if(arch_fax == null || arch_fax.equalsIgnoreCase("null")){
	arch_fax="";
}
if(arch_email == null || arch_email.equalsIgnoreCase("null")){
	arch_email="";
}

// Checking if the architect is required
if(arch_required.equals("N")){
	arch_name="NONE";arch_addr1="";arch_addr2="";arch_city="";arch_state="";arch_zip="";
	arch_phone="";arch_fax="";
}
out.println("<tr><td align='left'><div id='sideHead'><p style='font-size:14px;color:black;margin-top:20px;font-stretch:expanded;'><b>ARCHITECT DETAILS</b></p></div></td><td colspan='8' align='right' height='10%' class='tdOrder' bordercolor='#C0C0C0'>&nbsp;</td></tr>");
out.println("<tr><td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td>");
out.println("<td><!-- Red Separation Line Goes Here --><div id='Line'></div></td></tr>");
out.println("<tr>");
out.println("<td align='right' class='tdOrder'>"+"ARCHITECT'S NAME&nbsp;&nbsp;:&nbsp;&nbsp;</td><td align='left' class='tdOrder'><b> "+arch_name+"</b></td>");
out.println("<td  align='right' class='tdOrder'>"+"ADDRESS&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder'><b> "+arch_addr1+",&nbsp;</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</b></td>");
out.println("<td class='tddash' >&nbsp;</b></td>");
out.println("<td align='left' class='tdOrder'><b> "+arch_addr2+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</b></td>");
out.println("<td align='right' class='tdOrder'>"+"CITY/STATE/ZIP&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder'><b> "+arch_city+",&nbsp;"+arch_state+"&nbsp;&nbsp;"+arch_zip+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</b></td>");
out.println("<td align='right' class='tdOrder' >PHONE&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder' ><b> "+arch_phone+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</b></td>");
out.println("<td align='right' class='tdOrder' >FAX&nbsp;&nbsp;:&nbsp;&nbsp;</td>");
out.println("<td align='left' class='tdOrder'  style='page-break-after: always;'><b> "+arch_fax+"</b></td>");
out.println("</tr>");
//out.println("<tr>");
//out.println("<td align='center' colspan='8' height='20' class='tdheader1'>"+"&nbsp;SEE NEXT PAGE FOR MORE INFORMATION"+"</td>");
//out.println("</tr>");

		%>