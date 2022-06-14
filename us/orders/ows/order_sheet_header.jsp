<%@ page import="java.text.SimpleDateFormat" %>
<html>
	<head><title>ORDER SHEET</title>
		<link rel='stylesheet' href='order.css' type='text/css' />
		<style type="text/css" media="print">
			.printbutton {
				visibility: hidden;
				display: none;
			}
		</style>
	</head>
	<body>
		<script>
			document.write("<input type='button' "+
				   "onClick='window.print()' "+
				   "class='printbutton' "+
				   "value='Print This Page'/>");
		</script>

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
		String copies_requested="";String type_of_quote="";String order_notes="";String cust_order_notes="";String drafting_email="";

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
										}
									}
									rs_order.close();
if(type_of_quote==null||type_of_quote.equals("null")){
	type_of_quote="";
}
if(drafting_email==null){
	drafting_email="";
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
				
				if(null!= sectionTransfer){
					sectionSpecificValue = sectionTransfer.split(";");
				}
						
				int totalSections = Integer.parseInt(numberOfSections);
				//out.println("bpcsTransferSheetbpcs$$$$$$TransferSheetproductbefore     :    "+totalSections);
				if(null!= sectionTransfer && !sectionTransfer.isEmpty()){
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
				
				if(sectionTransferredDate==null){
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
out.println("<table width='100%' border='1' cellspacing='0' cellpadding='0' class='tb'>");
out.println("<tr>");
if(type_of_quote.equals("DECOGARD")){
	type_of_quote="FACILITY SALES";
}
if(type_of_quote.equals("DECOLINK")){
	//type_of_quote="CS SENIOR LIVING" AS PER TAC: 101289
	type_of_quote="FACILITY SALES";
}
if(project_type.equals("PSA")){
	out.println("<td align='center' height='30' class='tdheader' colspan='6'>&<img src='http://csimages.c-sgroup.com/eRapid/cs-logo_email.jpg'  alt='CS Logo'><BR>"+type_of_quote+"&nbsp;&nbsp;FACTORY ORDER SHEET"+"</td>");
}
else{
	out.println("<td align='center' height='30' class='tdheader' colspan='6'><img src='http://csimages.c-sgroup.com/eRapid/cs-logo_email.jpg' alt='CS Logo'><BR>"+type_of_quote+"&nbsp;&nbsp;ORDER SHEET"+"</td>");
}
out.println("</tr>");

out.println("<tr>");
out.println("<td colspan='6' align='right' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"Date: <B>"+sectionTransferredDate+"</B><td>");
out.println("</tr>");
out.println("<tr>");
String tempDocType=doc_type;
if(quote_origin != null && quote_origin.equals("sample")){
	tempDocType="SAMPLE";
}
out.println("<td align='LEFT' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"ORDER TYPE:<b></td>");
out.println("<td align='LEFT' height='10%' class='tddash' bordercolor='#C0C0C0'><b>"+tempDocType+"</b></td>");
out.println("<td align='LEFT' height='10%' class='tddash' bordercolor='#C0C0C0'>ADD/DEDUCT:<b></td>");
out.println("<td align='LEFT' height='10%' class='tddash' colspan='3' bordercolor='#C0C0C0'><b>"+add_deduct_job+"</b></td>");
out.println("</tr>");


     //out.println("<table border='1' cellpadding='0' cellspacing='0' width='100%' class='tb'>");
out.println("<tr>");
out.println("<td width='20%' class='tddash' >SALES REGION:</td>");
out.println("<td width='20%' class='tddash' align='LEFT' >&nbsp;<b>"+sales_region+"</b></td>");
out.println("<td width='15%' class='tddash' >COMPANY DIVISION:</td>");
out.println("<td width='15%' class='tddash' >&nbsp;<b>"+cs_company+"</b></td>");
out.println("<td width='15%' class='ttddash' >"+"QUOTE NO:"+"</td>");
out.println("<td width='15%' class='tddash' >&nbsp;<b>"+order_no+"</b></td>");
out.println("</tr>");

out.println("<tr>");
out.println("<td class='tddash' >REP#</td>");
out.println("<td class='tddash' >&nbsp;<b>"+order_rep+"</b></td>");
out.println("<td class='tddash' >REP NAME:</td>");
out.println("<td class='tddash' colspan='3'>&nbsp;<b>"+rep_name+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td  height='10%' class='tdsolid' bordercolor='#C0C0C0'>"+"PROJECT NAME & LOCATION:</td>");
out.println("<td colspan='5' class='tddash'><b>"+Project_name+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+Job_loc+"&nbsp;&nbsp;&nbsp;"+project_state+"</b><td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td colspan='6' height='10%' class='tddashtop' bordercolor='#C0C0C0'>"+"BILLING CUSTOMER:&nbsp;<b>"+cust_name1+" "+cust_no+"</b><td>");
out.println("</tr>");

out.println("<tr>");
out.println("<td class='tddash' >ADDRESS:&nbsp;");
out.println("<td class='tddash' colspan='5'><b>"+cust_addr1+"&nbsp;&nbsp;&nbsp;"+cust_addr2+"</b><td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >CITY/STATE/ZIP:&nbsp;");
out.println("<td class='tddash' colspan='5' ><b>"+city+",&nbsp;"+state+"&nbsp;&nbsp;"+zip_code+"</b><td>");
out.println("</tr>");

out.println("<tr>");
out.println("<td class='tddash' >PHONE:</td>");
out.println("<td class='tddash' colspan='2' >&nbsp;<b>"+phone+"</b></td>");
out.println("<td class='tddash' >FAX:</td>");
out.println("<td class='tddash' colspan='2' >&nbsp;<b>"+fax+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >CONTACT NAME:</td>");
out.println("<td class='tddash' colspan='2' >&nbsp;<b>"+contact_name+"</b></td>");
out.println("<td class='tddash' >EMAIL:</td>");
out.println("<td class='tddash' colspan='2' >&nbsp;<b>"+billed_email+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >CUSTOMER TYPE:&nbsp;</td>");
out.println("<td class='tddash' colspan='2' ><b>"+customer_type+"</b></td>");
out.println("<td class='tddash' >MARKET TYPE:&nbsp;<b></td>");
out.println("<td class='tddash' colspan='2' ><b>"+market_type+"</b></b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >CUSTOMER PO NUMBER:</td>");
out.println("<td class='tddash' colspan='2' ><b>"+customer_po_no+"</b></td>");
out.println("<td class='tddash' >TAX EXEMPT NUMBER#&nbsp;");
out.println("<td class='tddash' colspan='2'><b>"+sales_exempt_no+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td height='10%' colspan='6' class='tddashtop' bordercolor='#C0C0C0'>"+"INVOICE TO NAME:&nbsp;<b>"+invoice_name+" "+invoice_cust_no+"</b><td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td height='10%' class='tddash' bordercolor='#C0C0C0'>"+"ADDRESS:</td>");
out.println("<td class='tddash' colspan='5'><b>"+invoice_addr1+",&nbsp;"+invoice_addr2+"</b><td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td height='10%' class='tddash' bordercolor='#C0C0C0'>"+"CITY/STATE/ZIP:</td>");
out.println("<td class='tddash' colspan='5'><b>"+invoice_city+",&nbsp;"+invoice_state+"&nbsp;&nbsp;"+invoice_zip+"</b><td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >PHONE:</td>");
out.println("<td class='tddash' ><b>"+invoice_phone+"</b></td>");
out.println("<td class='tddash' >FAX:</td>");
out.println("<td class='tddash' ><b>"+invoice_fax+"</b></td>");
out.println("<td class='tddash' >EMAIL:</td>");
out.println("<td class='tddash' ><b>"+invoice_email+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td height='10%' class='tddash' >"+"INVOICE ATTENTION:</td>");
out.println("<td height='10%' class='tddash' colspan='5'><b>"+attention_invoice+"</b><td>");
out.println("</tr>");

//ROW

		// INVOICE INFORMATION ENDED
//ROW
if(payment_terms.equals("NET 30 DAYS")){
payment_name="";payment_address1="";payment_address2="";payment_city="";payment_state="";payment_zip="";
		payment_credit_type="";payment_credit_no="";payment_material_sales="0";	payment_tax="0";payment_total_charged="0";
                             }


out.println("<tr>");
out.println("<td class='tddash' >PAYMENT TERMS:</td>");
out.println("<td class='tddash' colspan='5'><b>"+payment_terms+"</b></td>");
out.println("</tr>");




out.println("<tr>");
out.println("<td class='tddash' >CREDIT CARD TYPE:</td>");
out.println("<td class='tddash' colspan='5'><b>"+payment_credit_type+"</b></td>");
if(payment_credit_no != null && payment_credit_no.trim().length()>4){
	//out.println("<td class='tddash' width='33%'>CREDIT CARD NUMBER:&nbsp;<b>****************"+payment_credit_no.substring(payment_credit_no.length()-4)+"</b></td>");
}
out.println("</tr>");
if (pay_coun<=0){
	payment_material_sales="0";
	payment_tax="0";
	payment_total_charged="0";
}

//out.println("<tr>");
double grandTotal = 0.0;
double totalValue = Double.parseDouble(totmat_price);
double tax_dollar=((totalValue)*(Float.parseFloat(tax_perc)))/100;
//	out.println("-------------------"+tax_dollar+" $$%%%$$ "+totmat_price+" totmatsales "+totmatsales);
if(!payment_terms.equals("NET 30 DAYS") && payment_terms != ""){
	grandTotal = (new Double(totmat_price).doubleValue())+tax_dollar;
}
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
out.println("<tr>");
out.println("<td colspan='6' height='10%' class='tddashtop' bordercolor='#C0C0C0'>"+"SHIP TO NAME:&nbsp;<b>"+ship_name+" "+ship_cust_no+"</b><td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td  height='10%' class='tddash' bordercolor='#C0C0C0'>ADDRESS:</td>");
out.println("<td class='tddash' colspan='5'><b>"+ship_addr1+",&nbsp;"+ship_addr2+"</b><td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td height='10%' class='tddash' bordercolor='#C0C0C0'>"+"CITY/STATE/ZIP:</td>");
out.println("<td class='tddash' colspan='5'><b>"+ship_city+",&nbsp;"+ship_state+"&nbsp;&nbsp;"+ship_zip+"</b><td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >PHONE:</td>");
out.println("<td class='tddash' >&nbsp;<b>"+ship_phone+"</b></td>");
out.println("<td class='tddash' >FAX:</td>");
out.println("<td class='tddash' colspan='3'>&nbsp;<b>"+ship_fax+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >SHIPPING METHOD:</td>");
out.println("<td class='tddash' ><b>"+ship_method+"</b></td>");
out.println("<td class='tddash' >REQUEST SHIP DATE:</td>");
out.println("<td class='tddash' ><b>"+ship_rdate+"</b></td>");
out.println("<td class='tddash' colspan='3'>SHIP ATTENTION:&nbsp;<b>"+ship_attention+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >DELIVERY NOTICE(HRS):</td>");
out.println("<td class='tddash' ><b>"+ship_prior_notice+"</b></td>");
out.println("<td class='tddash' >DELIVERY NAME:</td>");
out.println("<td class='tddash' ><b>"+ship_prior_notice_name+"</b></td>");
out.println("<td class='tddash' >DELIVERY PHONE:</td>");
out.println("<td class='tddash' ><b>"+ship_prior_notice_phone+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td colspan='6' height='10%' class='tddashtop' bordercolor='#C0C0C0'>"+"OWNER/END USER NAME:&nbsp;<b>"+eu_cust_name1+" "+eu_cust_no+"</b><td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td colspan='6' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"ADDRESS:&nbsp;<b>"+eu_cust_addr1+",&nbsp;"+eu_cust_addr2+"</b><td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td colspan='6' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"CITY/STATE/ZIP:&nbsp;<b>"+eu_city+",&nbsp;"+eu_state+"&nbsp;&nbsp;"+eu_zip_code+"</b><td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash'>PHONE:&nbsp;</td>");
out.println("<td class='tddash' ><b>"+eu_phone+"</b></td>");
out.println("<td class='tddash'>FAX:&nbsp;</td>");
out.println("<td class='tddash' ><b>"+eu_fax+"</b></td>");
out.println("<td class='tddash'>MARKET TYPE:</td>");
out.println("<td class='tddash' ><b>"+market_type1+"</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >SUBMITTALS BY:</td>");
out.println("<td class='tddash' ><b> "+submit_by+"</b></td>");
out.println("<td class='tddash' >NUMBER OF COPIES REQUIRED:</td>");
out.println("<td class='tddash' ><b> "+copies_requested+"</b></td>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</b></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td colspan='6' height='10%' class='tddash' bordercolor='#C0C0C0'>"+"FACTORY CONTACT:<b> "+email_to+"</b><td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td colspan='6' height='10%' class='tddash' bordercolor='#C0C0C0'>DRAFTING EMAIL:<b> "+drafting_email+"</b><td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td colspan='6' height='10%' class='tdsolid' bordercolor='#C0C0C0'>"+"SPECIAL INSTRUCTIONS:<b> "+special_notes+"</b><td>");
out.println("</tr>");

// Checking if the architect is required
if(arch_required.equals("N")){
	arch_name="NONE";arch_addr1="";arch_addr2="";arch_city="";arch_state="";arch_zip="";
	arch_phone="";arch_fax="";
}
out.println("<tr>");
out.println("<td colspan='6' height='10%' class='tddashtop' bordercolor='#C0C0C0'>"+"ARCHITECT'S FIRM NAME:<b> "+arch_name+"</b><td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td  height='10%' class='tddash' bordercolor='#C0C0C0'>"+"ADDRESS:</td>");
out.println("<td class='tddash' colspan='5'><b> "+arch_addr1+",&nbsp;"+arch_addr2+"</b><td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td height='10%' class='tddash' bordercolor='#C0C0C0'>"+"CITY/STATE/ZIP:</td>");
out.println("<td class='tddash' colspan='5'><b> "+arch_city+",&nbsp;"+arch_state+"&nbsp;&nbsp;"+arch_zip+"</b><td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td class='tddash' >PHONE:</td>");
out.println("<td class='tddash' ><b> "+arch_phone+"</b></td>");
out.println("<td class='tddash' >FAX:</td>");
out.println("<td class='tddash' ><b> "+arch_fax+"</b></td>");
out.println("<td class='tddash' >&nbsp;</td>");
out.println("<td class='tddash' >&nbsp;</b></td>");
out.println("</tr>");
//out.println("<tr>");
//out.println("<td align='center' colspan='6' height='20' class='tdheader1'>"+"&nbsp;SEE NEXT PAGE FOR MORE INFORMATION"+"</td>");
//out.println("</tr>");

		%>