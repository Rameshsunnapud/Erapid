<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="validation" 		class="com.csgroup.general.ValidationBean" 		scope="page"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%><!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>

	<head>
		<title>Transfer to BPCS</title>
	</head>
	<SCRIPT language="JavaScript">
		function poponload(){
			var time=new Date();
			hours=time.getHours();
			mins=time.getMinutes();
			secs=time.getSeconds();
			closeTime=hours*3600+mins*60+secs;
			closeTime+=2;  // This number is how long the window stays open
			// Timer();
			var url="mail.delivery2.jsp?order_no="+document.selectform.order_no.value+"&to="+document.selectform.to.value+"&from="+document.selectform.from.value+"&message="+document.selectform.message.value+"&cc=&sections=all&rep_no="+document.selectform.rep_no.value+"&name="+document.selectform.userId.value;
			var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=450,height=200';
			my_window=window.open(url,"mywindow1",props);
		}
		function poponload2()
		{
			var time=new Date();
			hours=time.getHours();
			mins=time.getMinutes();
			secs=time.getSeconds();
			closeTime=hours*3600+mins*60+secs;
			closeTime+=4;  // This number is how long the window stays open
			//   Timer();

			var url="../efs/transfer.jsp?sp-q="+document.selectform.order_no.value+"&cmd=5";
			var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=20,height=20';
			my_window=window.open(url,"mywindow2",props);
		}

		//function Timer(){
		//      var time= new Date();
		//    hours= time.getHours();
		//  mins= time.getMinutes();
		// secs= time.getSeconds();
		// curTime=hours*3600+mins*60secs
		// if (curTime>=closeTime){
		// self.close();}
		//else{
		//      window.setTimeout("Timer()",1000)
		//}
		//}
	</SCRIPT>
	<body onload="poponload();
			poponload2();">
		<h1>CS Order Transfer System::</h1>
		<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.lang.*" import="java.io.*" import="java.text.*" import="java.math.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con.jsp"%>
		<%@ include file="../../../dbcon1.jsp"%>
		<%
		int lineIncrease=0;
		String order_no = request.getParameter("order");
		String si = request.getParameter("sections");
		String thisRep=request.getParameter("rep_no");
		String doc_priority=request.getParameter("doc_priority");
		String groupName="";
		boolean isGood=true;

		//out.println(url+"<BR>");
		//myConn.close();

		//out.println(si+":"+order_no);
		%>
		<%@ include file="../../../db_con_psa.jsp"%>
		<%
//out.println("1");
		double lineOver=0;
		double overageLine=0.0;
		String [] charMap = {"}","J","K","L","M","N","O","P","Q","R"};
		int notesCounter=1;
		String r="";
		DecimalFormat for12 = new DecimalFormat("####.##");
		for12.setMaximumFractionDigits(2);
		for12.setMinimumFractionDigits(2);
		//NumberFormat for10 = NumberFormat.getInstance();
		DecimalFormat for10 = new DecimalFormat("####");
		for10.setMaximumFractionDigits(0);
		for10.setMinimumFractionDigits(0);
		//NumberFormat for13 = NumberFormat.getInstance();
		DecimalFormat for13 = new DecimalFormat("####.##");
		for13.setMaximumFractionDigits(3);
		for13.setMinimumFractionDigits(3);

	String userId=request.getParameter("userId");



		DecimalFormat for19 = new DecimalFormat("####.##");
		for19.setMaximumFractionDigits(9);
		for19.setMinimumFractionDigits(9);
		DecimalFormat for14 = new DecimalFormat("####.##");
		for14.setMaximumFractionDigits(4);
		for14.setMinimumFractionDigits(4);
		//vars for io to file
						    String dir_path="D:\\TRANSFER\\BPCS_OE\\";String final_out="";String final_oh_out="";String final_os_out="";String final_oi_out="";
						    String final_on_out="";String final_oc_out="";String final_ic_out="";
						    String dir_path1="D:\\TRANSFER\\BPCS_OE\\testing\\EFS\\";
		//
		String section_group="";Vector si_final = new Vector();Vector li_final = new Vector();String Project_name="";String product_id="";String lines_final = "";
		String overage="";String freight_cost="";String handling_cost="";String setup_cost="";double config_price=0;double total_sale_price=0;
		String rep_no="";String quote_type="";String psa_quote_id="";String bpcs_tier_order="";String bpcs_order_no="";String quote_origin="";String base_quote_no="";String quote_no_origin="";
		//reteriving the lines from the sections
						    //out.println("Out put Transfer Started....... "+"to "+dir_path+ " folder for upload to BPCS"+"<br><br><br>");
						    out.println(".......Out put transfer to CS order system BPCS started....... <br><br><br>");
						    ResultSet rs_find = stmt.executeQuery("SELECT * FROM cs_quote_sections where order_no like '"+order_no+"'");
						    if (rs_find !=null) {
						    while (rs_find.next()){
						    section_group=rs_find.getString ("section_group");
		//			out.println("Testing"+section_group);
							}
						    }
		// Project info
		String sales_tax_code="";String georder="";
					 ResultSet rs_project = stmt.executeQuery("SELECT * FROM cs_project where Order_no like '"+order_no+"' ");
						    if (rs_project !=null) {
				  while (rs_project.next()) {
						    Project_name= rs_project.getString("Project_name");
						    product_id= rs_project.getString("product_id");
						    if(product_id.equals("EJC")){product_id="TPG";}
						    rep_no=rs_project.getString("creator_id");
						    overage= rs_project.getString("overage");
						    if(rs_project.getString("freight_cost")!= null && rs_project.getString("freight_cost").trim().length()>0){
								  freight_cost=rs_project.getString("freight_cost");
						    }
						    else{
								  freight_cost=String.valueOf(for14.format(0.0));
						    }
						    if(rs_project.getString("handling_cost")!= null && rs_project.getString("handling_cost").trim().length()>0){
								  handling_cost= rs_project.getString("handling_cost");
						    }
						    else{
								  handling_cost=String.valueOf(for14.format(0.0));
						    }
						    if(rs_project.getString("setup_cost")!= null && rs_project.getString("setup_cost").trim().length()>0){
								  //out.println(rs_project.getString("setup_cost")+" HERE<BR>");
								  setup_cost= rs_project.getString("setup_cost");
						    }
						    else{
								  setup_cost=String.valueOf(for14.format(0.0));
						    }
						    quote_type=rs_project.getString("project_type");
						    if(!(quote_type != null)){
								  quote_type="";
						    }
						    psa_quote_id=rs_project.getString("project_type_id");
		//			config_price= rs_project.getString("configured_price");
						    bpcs_tier_order=rs_project.getString("bpcs_tier");
						    sales_tax_code=rs_project.getString("tax_code");
						    georder=rs_project.getString("doc_type_alt");
						    quote_origin= rs_project.getString("quote_origin");
						    bpcs_order_no= rs_project.getString("BPCS_order_no");
						    if(rs_project.getString("base_quote_no") != null  && rs_project.getString("base_quote_no").trim().length()>0 && rs_project.getString("base_quote_no").trim().substring(0,6).startsWith(order_no.substring(0,6))){
								  base_quote_no=rs_project.getString("base_quote_no");
						    }
						    }
						    }
						    rs_project.close();
						    if(base_quote_no==null){
								  base_quote_no="";
						    }
						    if(quote_origin==null){
								  quote_origin="";
						    }
						    if(quote_origin.equals("Alternate")||quote_origin.equals("")||quote_origin.equals("Copy")){
								  base_quote_no=order_no;
						    }
						    if(georder==null){
								  georder="";
						    }

		if(base_quote_no.trim().length()>0 && base_quote_no.startsWith(order_no.substring(0,6)) && quote_origin.trim().length()>0 && !quote_origin.equals("Alternate")){
			   boolean keepgoing=true;
			   String tempquote_origin="";
			   String tempbase_quote_no=base_quote_no;
			   String tempbase_quote_no_old="";
			   //out.println(tempbase_quote_no+"::<BR>");
			   while(keepgoing){
					 int counter=0;
					 tempbase_quote_no_old=tempbase_quote_no;
					 ResultSet rsordernoalt=stmt.executeQuery("select quote_origin,base_quote_no from cs_project where order_no='"+tempbase_quote_no+"'");
					 if(rsordernoalt != null){
						    while(rsordernoalt.next()){
								  tempquote_origin=rsordernoalt.getString(1);
								  tempbase_quote_no=rsordernoalt.getString(2);
								  counter++;
						    }
					 }
					 rsordernoalt.close();
					 if(tempquote_origin==null){
						    tempquote_origin="";
					 }
					 if(tempbase_quote_no==null){
						    tempbase_quote_no="";
					 }
					 if(counter>0 && tempbase_quote_no.trim().length()>0 && tempbase_quote_no.startsWith(order_no.substring(0,6)) && tempquote_origin.trim().length()>0 && ! tempquote_origin.equals("Alternate")){
						    keepgoing=true;
						    //out.println("::"+tempbase_quote_no+":::"+tempquote_origin+"::<BR>");
					 }
					 else{
						    keepgoing=false;
						    out.println("FALSE::"+tempbase_quote_no_old+":::"+tempquote_origin+"::<BR>");
						    base_quote_no=tempbase_quote_no_old;
					 }
			   }

		}

		else{
			   quote_no_origin=order_no;
			   if(base_quote_no.trim().length()>0&&base_quote_no.startsWith(order_no.substring(0,6))){
					 quote_no_origin=base_quote_no;
			   }
		}










						    if(bpcs_tier_order==null){bpcs_tier_order="0";}
						    if(sales_tax_code==null){sales_tax_code="";}
						    if(georder==null){georder="";}
		//Tokenizer for breaking the sECTIONS
						    StringTokenizer st=new StringTokenizer(si,",");
						    while (st.hasMoreTokens()){
		//	        out.println("<br>"+st.nextToken());
						    si_final.addElement(st.nextToken());
						    }
		// Tokenizer for getting the line no's
						    StringTokenizer st1=new StringTokenizer(section_group,";");
						    while (st1.hasMoreTokens()){
		//	        out.println("<br>"+st1.nextToken());
						    li_final.addElement(st1.nextToken());
						    }
		//getting lines
		String km="";
		for(int k=0;k<si_final.size();k++){ //s1
					 for(int kl=0;kl<li_final.size();kl++){//1=s1
								  km=li_final.elementAt(kl).toString();
			   //		out.println("Hello"+km+":<br>");
							 if(km.endsWith(si_final.elementAt(k).toString())){
		//			 out.println("Hello"+km+":"+km.indexOf("="));
							 if(lines_final.length()==0){
							 lines_final=lines_final+km.substring(0,km.indexOf("="));
							 }else{lines_final=lines_final+","+km.substring(0,km.indexOf("=")); }
		//				out.println(km+":"+km.indexOf("="));
			//     out.println("Lines"+lines_final);
							}
					 }
		}
		//out.println("Lines"+lines_final);
		//doc_line
		// Checking the no of lines
		Vector items=new Vector();
					 ResultSet rs1 = stmt.executeQuery("SELECT doc_line FROM doc_line where doc_number like '"+order_no+"' order by cast(doc_line as integer)");
			   while ( rs1.next() ) {
			   items.addElement(rs1.getString("doc_line"));
											    }

		// Checking the no of lines	done
		//doc_line end
		//CS_QUOTES<br>
		double nonCommision=0.0;
			   Vector QTY=new Vector();Vector price=new Vector();Vector line_item=new Vector();Vector desc=new Vector();
					 Vector rec_no=new Vector();Vector fact_per=new Vector();Vector mark=new Vector();Vector block_id=new Vector();Vector bpcs_part_no=new Vector();
					 Vector bpcs_qty=new Vector();Vector bpcs_tier_lines=new Vector();
		//		 if (si==nul
		String largestLine="";
		double largestPrice=0.0;
		int counterLarge=0;
		int indexLarge=-1;
		int diLineCounter=1;
		double nonCommission=0;String special_cut="N";
//out.println("2");
//out.println(lines_final+"::<BR><BR><BR>");
					 ResultSet rs3 = stmt.executeQuery("SELECT *,REPLACE(REPLACE(CAST(Descript AS varchar(5000)), CHAR(10), ''), CHAR(13), '') AS description FROM csquotes where order_no like '"+order_no+"' and line_no in ("+lines_final+") order by cast(Line_no as integer)");
			   while ( rs3.next() ) {
					if(indexLarge<0){
						indexLarge=0;
					}
						    //out.println(rs3.getString("block_id")+"::"+rs3.getString("extended_price")+"<BR>");
					 line_item.addElement(rs3.getString ("Line_no"));
					 desc.addElement(rs3.getString ("description"));
 if(rs3.getString("Extended_Price")!= null && rs3.getString("Extended_Price").trim().length()>0 && (! rs3.getString("Extended_Price").trim().equals("0"))){

					 price.addElement(rs3.getString ("Extended_Price"));
}
else{
	price.addElement("0");
}
					 if(new Double(rs3.getString("extended_price")).doubleValue() >largestPrice && !rs3.getString("block_id").startsWith("D_")){
						    largestPrice=(new Double(rs3.getString("extended_price")).doubleValue());
						    largestLine=rs3.getString("line_no");
						    indexLarge=counterLarge;
					 }
					 config_price=config_price+ new BigDecimal(rs3.getString ("Extended_Price")).doubleValue();
					 QTY.addElement(rs3.getString("QTY"));
					 rec_no.addElement(rs3.getString("Record_no"));
					 block_id.addElement(rs3.getString("Block_ID"));
					 if(rs3.getString("field16")!= null && rs3.getString("field16").trim().length()>0 && (! rs3.getString("field16").trim().equals("0"))){
						    fact_per.addElement(rs3.getString("field16"));
					 }
					 else{
						    fact_per.addElement("0");
						    nonCommission=nonCommission+(new Double(rs3.getString("extended_price")).doubleValue());
					 }
					 mark.addElement(rs3.getString("field17"));
					 bpcs_part_no.addElement(rs3.getString("bpcs_gen"));//changed from bpcs_part_no
					 if(rs3.getString("bpcs_qty") != null && rs3.getString("bpcs_qty").trim().length()>0){
						    bpcs_qty.addElement(rs3.getString("bpcs_qty").trim());
					 }
					 else{
						    bpcs_qty.addElement("0");
					 }
					 //for special shape
					 if(rs3.getString("run_cost") != null && rs3.getString("run_cost").trim().length()>0 &&rs3.getString("run_cost").trim().equals("X")){
						    special_cut="Y";
					 }//for special shape done

					 //bpcs_line tiers
					 if(rs3.getString("bpcs_tier") != null && rs3.getString("bpcs_tier").trim().length()>0){
						    bpcs_tier_lines.addElement(rs3.getString("bpcs_tier").trim());
					 }else{bpcs_tier_lines.addElement("0");	}

					 counterLarge++;
											    }
			   double cents=Math.round(config_price)-config_price;
			   //out.println(cents+"cents<BR>");
			   if(quote_type!= null && quote_type.equals("web")){
					 cents=0;
			   }
			   else{
					 config_price=config_price+cents;
			   }
			  //	out.println(config_price+"config price :: largest Price"+largestPrice+"::largestLine"+largestLine+"::"+indexLarge+"index<BR>");


		//out.println(nonCommission+" here is the noncommissionable total<BR>");
//out.println("0:: "+indexLarge+"::"+counterLarge);
//		out.println("::"+price.elementAt(indexLarge).toString()+"::");
//+"::"+QTY.elementAt(indexLarge).toString()+"::"+fact_per.elementAt(indexLarge).toString()+"<-- here<BR>");
//out.println("1");
double priceLarge=new Double(price.elementAt(indexLarge).toString()).doubleValue()+cents;
//out.println("2");
		double comLarge=new Double(price.elementAt(indexLarge).toString()).doubleValue()*new Double(fact_per.elementAt(indexLarge).toString()).doubleValue();
//out.println("3");
			double newCom=comLarge/priceLarge;
if(priceLarge==0){
	newCom=0;
}
//out.println("4");
		price.setElementAt(String.valueOf(priceLarge),indexLarge);
//		out.println("5");
fact_per.setElementAt(String.valueOf(newCom),indexLarge);
//out.println("6");
		//out.println(price.elementAt(indexLarge).toString()+"::"+QTY.elementAt(indexLarge).toString()+"::"+fact_per.elementAt(indexLarge).toString()+"<-- NEW here<BR>");


		total_sale_price=config_price+Double.parseDouble(overage)+Double.parseDouble(handling_cost)+Double.parseDouble(freight_cost)+Double.parseDouble(setup_cost);

		//grand_total=(Float.parseFloat(o_cost)+Float.parseFloat(handling_cost)+Float.parseFloat(freight_cost)+Float.parseFloat(t));

		//db connectons
		 //billing customer
					 String cust_name1="";String cust_addr1="";String cust_addr2="";String city="";String state="";String zip_code="";
					 String phone="";String fax="";String contact_name="";String customer_po_no="";String payment_terms="";String bpcs_cust_no="";
					 String invoice_info="";String cs_order_type="";String order_rep_no="";String sales_region="";
					 String order_type="";
					 ResultSet rs_bill = stmt.executeQuery("SELECT * FROM cs_billed_customers where order_no like '"+order_no+"'");
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
					 order_type=rs_bill.getString("order_type");
					 contact_name= rs_bill.getString("contact_name");
					 customer_po_no= rs_bill.getString("customer_po_no");
					 payment_terms= rs_bill.getString("payment_terms");
					 bpcs_cust_no= rs_bill.getString("bpcs_cust_no");
					 invoice_info= rs_bill.getString("invoice_info");
					 cs_order_type=rs_bill.getString("order_type");
					 order_rep_no= rs_bill.getString ("created_rep_no");
					 sales_region= rs_bill.getString ("sales_region");
															   }
								  }
		if(sales_region==null){
			   sales_region="";
		}
		//getting the rep_no from cs_billed

					 if(order_rep_no== null){order_rep_no=thisRep;}
					 else{
						    if(order_rep_no.equals(thisRep)){}
						    else{
								  //out.println("This rep "+thisRep+" Order rep_no"+order_rep_no);
								  thisRep=order_rep_no;
						    }
						    if (order_rep_no.equals(rep_no)){}
								  else{
										String tempgroup="";
										ResultSet rstempgroup=stmt.executeQuery("select group_id from cs_reps where rep_no='"+rep_no+"'");
										if(rstempgroup != null){
											   while(rstempgroup.next()){
														    tempgroup=rstempgroup.getString(1);
											   }
										}
										rstempgroup.close();
										if(!tempgroup.toUpperCase().startsWith("REP")||rep_no.equals("999")){
										//	out.println("This rep_no "+rep_no+" Order rep_no"+order_rep_no);
											   rep_no=order_rep_no;
										}
						    }
					 }
					 ResultSet rstempgroup2=stmt.executeQuery("select group_id from cs_reps where rep_no='"+order_rep_no+"'");
					 if(rstempgroup2 != null){
						    while(rstempgroup2.next()){
								  groupName=rstempgroup2.getString(1);
						    }
					 }
					 rstempgroup2.close();
					 //getting rep_no from cs_billed done


		//Shipping
		//Ship variables
		String ship_name="";String ship_addr1="";String ship_addr2="";String ship_city="";String ship_state="";
		String ship_zip="";String ship_phone="";java.sql.Date ship_rdate=null;String ship_date="";String ship_attention="";
		String ship_prior_notice_name="";String ship_prior_notice_phone="";String ship_prior_notice="";
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
					 ship_rdate= rs_ship.getDate("request_date");
					 ship_attention= rs_ship.getString("attention");
					 ship_prior_notice_name= rs_ship.getString("prior_notice_name");
					 ship_prior_notice_phone= rs_ship.getString("prior_notice_phone");
					 ship_prior_notice= rs_ship.getString("prior_notice");
													    }
												 }

			   //restting nulls
					 if(ship_attention==null){ship_attention=" ";}if(ship_prior_notice_name==null){ship_prior_notice_name=" ";}if(ship_prior_notice_phone==null){ship_prior_notice_phone=" ";}
					 if(ship_prior_notice==null){ship_prior_notice=" ";}
		// Getting the orderinfo
  String drafting_email="";
		String email_to="";String win_loss="";String submit_by="";String add_docs="";String special_notes="";String copies_requested="";String order_notes="";
						    ResultSet rs_order = stmt.executeQuery("SELECT * FROM cs_order_info where order_no like '"+order_no+"' ");
								  if (rs_order !=null) {
						    while (rs_order.next()) {
								  email_to= rs_order.getString("email_to");
								  win_loss= rs_order.getString("order_status");
								  submit_by= rs_order.getString("submit_by");
								  add_docs= rs_order.getString("add_docs");
								  special_notes=rs_order.getString("special_notes");
								  copies_requested=rs_order.getString("copies_requested");
								  order_notes=rs_order.getString("order_notes");
								  drafting_email=rs_order.getString("drafting_email");
																		}
															    }

  if(drafting_email==null){
										drafting_email="";
								  }
		//eorders for the
		String prio="";
					 ResultSet e_order = stmt.executeQuery("SELECT * FROM doc_header where doc_number like '"+order_no+"' ");
					 if (e_order !=null) {
			   while (e_order.next()) {
					 prio= e_order.getString("doc_priority");
														    }
													  }
		rs_bill.close();
		rs_ship.close();
		rs_order.close();
		//db connections done
		//out out preparation to BPCS started,.
		//going to cs_invoice table for bpcs_cust_no
		String ship_to_customer="";//6 characters
		String invoice_customer="";//6 characters
			   ResultSet cs_invoice = stmt.executeQuery("SELECT bpcs_cust_no FROM cs_invoice where order_no like '"+order_no+"' ");
					 if (cs_invoice !=null) {
			   while (cs_invoice.next()) {
					 invoice_customer= cs_invoice.getString(1);
														    }
													  }
					 cs_invoice.close();
		//going to cs_end_users table for bpcs_cust_no
		ResultSet cs_end_users = stmt.executeQuery("SELECT bpcs_cust_no FROM cs_end_users where order_no like '"+order_no+"' ");
					 if (cs_end_users !=null) {
			   while (cs_end_users.next()) {
					 ship_to_customer= cs_end_users.getString(1);
														    }
													  }
					 cs_end_users.close();
					 if(ship_to_customer==null){ship_to_customer="";}
					 if(invoice_customer==null){invoice_customer="";}
					 //rep_no inti
		String source="";String psa_quote_type="";
		String spec_rep_acct_id="";String terr_rep_acct_id="";String arch_acct_id="";String order_rep_acct_id="";// for different accounts
		//out.println(quote_type+"<--<BR>");


					 if(quote_type.equals("PSA")){

					 String psa_pid="";
				 ResultSet rs_psa_reps = stmt_psa.executeQuery("SELECT * FROM dba.quotation where quote_id like '"+psa_quote_id+"%"+"' order by 1 desc ");
			  while ( rs_psa_reps.next() ) {
				 psa_pid= rs_psa_reps.getString("project_id");
				 psa_quote_type= rs_psa_reps.getString("quote_type");
					    //out.println(psa_pid+" this is the psa product type");
			   }
			  rs_psa_reps.close();
			  //Look up for quote_type in PSA starts
			  if(psa_quote_type==null){
			   source="TQ";
			   }else{
						    if(psa_quote_type.trim().length()>0){
								  ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT * FROM dba.user_lookup where lookup_id like '"+psa_quote_type.trim()+"'");
										if (rs_psa_lookup !=null) {
										while (rs_psa_lookup.next()) {
											   psa_quote_type= rs_psa_lookup.getString(3);
											   }
										}
								  rs_psa_lookup.close();
						    //	out.println("Test: "+psa_quote_type+"<br>");
								  if(psa_quote_type.equals("D")|psa_quote_type.endsWith("TQ")){
										source="TQ";
								  }else{
										source="PS";
								  }

						    }else{
								  source="TQ";
						    }
			   }

			  //Look up for quote_type in PSA ends


					 ResultSet rs_psa_proj_ac_link = stmt_psa.executeQuery("SELECT * FROM dba.proj_ac_link where project_id like '"+psa_pid+"' order by link_id");
					 if (rs_psa_proj_ac_link !=null) {
					 while (rs_psa_proj_ac_link.next()) {
										if(rs_psa_proj_ac_link.getString("role_type_id").equals("2")){arch_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");}
										if(rs_psa_proj_ac_link.getString("role_type_id").equals("8")){terr_rep_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");}
										if(rs_psa_proj_ac_link.getString("role_type_id").equals("7")){spec_rep_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");}
										if(rs_psa_proj_ac_link.getString("role_type_id").equals("10")){order_rep_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");}
						    }
					 }


		//out.println("this rep = "+thisRep+"<BR>");
			   String psa_account="";
			   ResultSet psaAccount=stmt_psa.executeQuery("Select ACCT_ID FROM dba.cs_rep where rep_id='"+thisRep+"'");
			   if(psaAccount != null){
					 while(psaAccount.next()){
						    psa_account=psaAccount.getString(1);
					 }
			   }

		//out.println("psa account "+psa_account+"<BR");
		ResultSet psaProj = stmt_psa.executeQuery("Select count(*) FROM dba.proj_ac_link where project_id like '"+psa_pid+"' and aclookup_id like '"+psa_account+"'");
		//out.println("HERE!<BR>");
		if(psaProj != null){
			   //out.println("HERE<BR>");
			   while(psaProj.next()){
					 if(new Double(psaProj.getString(1)).doubleValue() >0){
						    //out.println("good to go<BR>");
						    rep_no=thisRep;
					 }
					 else{
						    //out.println("no good<BR>");
						    isGood=false;
					 }
			   }
		}


		}else{
			   source="TQ"; //for rep quotes always
		}


					 //oh out
					 if(bpcs_cust_no==null){bpcs_cust_no="000000";}if(cust_name1==null){cust_name1=" ";}if(cust_addr1==null){cust_addr1=" ";}if(cust_addr2==null){cust_addr2=" ";}
					 if(city==null){city=" ";}if(state==null){state=" ";}if(zip_code==null){zip_code=" ";}if(phone==null){phone=" ";}if(fax==null){fax=" ";}if(contact_name==null){contact_name=" ";}
					 if(customer_po_no==null){customer_po_no=" ";}if(payment_terms.startsWith("NET")){payment_terms=" ";}else{payment_terms="V";}if(Project_name==null){Project_name=" ";}
					 if(customer_po_no==null){customer_po_no=" ";}if(email_to==null){email_to ="";}
					 if(ship_rdate==null){ship_date ="00000000";}
					 else{Format formatter = new SimpleDateFormat("yyyyMMdd");
				  ship_date = formatter.format(ship_rdate);
					 }


//out.println("3");
			   if(rep_no.length()<6){
										String tv="";
										for(int v=0;v<(6-rep_no.length());v++){
										tv="0"+tv;
										   }
										rep_no=tv+rep_no;
										 }//rep_no field
													 r="";
													 for (int i = 0; i < bpcs_cust_no.length(); i ++) {
														    if (bpcs_cust_no.charAt(i) != '.' && bpcs_cust_no.charAt(i) != ',') r += bpcs_cust_no.charAt(i);
													 }
													 bpcs_cust_no=r;
													 if(bpcs_cust_no.length()<6){
																  String tv="";
																  for(int v=0;v<(6-bpcs_cust_no.length());v++){
																  tv="0"+tv;
		//									out.println("the T3 value: "+t3.length()+"vb"+v+"***"+tv+"<br>");
															   }
																  bpcs_cust_no=tv+bpcs_cust_no;
													 }
													 if(invoice_customer.length()<6){
														    String tv="";
														    for(int v=0;v<(6-invoice_customer.length());v++){
														    tv="0"+tv;
		//								out.println("the T3 value: "+t3.length()+"vb"+v+"***"+tv+"<br>");
														}
														    invoice_customer=tv+invoice_customer;
													 }
													 if(ship_to_customer.length()<6){
														    String tv="";
														    for(int v=0;v<(6-ship_to_customer.length());v++){
														    tv="0"+tv;
		//								out.println("the T3 value: "+t3.length()+"vb"+v+"***"+tv+"<br>");
														}
														    ship_to_customer=tv+ship_to_customer;
													 }
													 if(cust_name1.length()<30){
																  String tv="";
																  for(int v=0;v<(30-cust_name1.length());v++){
																  tv=" "+tv;
															   }
																  cust_name1=cust_name1+tv;
													 }else{cust_name1=cust_name1.substring(0,30);}
													 if(cust_addr1.length()<30){
																  String tv="";
																  for(int v=0;v<(30-cust_addr1.length());v++){
																  tv=" "+tv;
															   }
																  cust_addr1=cust_addr1+tv;
													 }else{cust_addr1=cust_addr1.substring(0,30);}
													 if(cust_addr2.length()<30){
																  String tv="";
																  for(int v=0;v<(30-cust_addr2.length());v++){
																  tv=" "+tv;
															   }
																  cust_addr2=cust_addr2+tv;
													 }else{cust_addr2=cust_addr2.substring(0,30);}
													 if(city.length()<30){
																  String tv="";
																  for(int v=0;v<(30-city.length());v++){
																  tv=" "+tv;
															   }
																  city=city+tv;
													 }else{city=city.substring(0,30);}
													 if(state.length()<3){
																  String tv="";
																  for(int v=0;v<(3-state.length());v++){
																  tv=" "+tv;
															   }
																  state=state+tv;
													 }else{state=state.substring(0,3);}
													 if(zip_code.length()<9){
																  String tv="";
																  for(int v=0;v<(9-zip_code.length());v++){
																  tv=" "+tv;
															   }
																  zip_code=zip_code+tv;
													 }else{zip_code=zip_code.substring(0,9);}
													 if(phone.length()<25){
																  String tv="";
																  for(int v=0;v<(25-phone.length());v++){
																  tv=" "+tv;
															   }
																  phone=phone+tv;
													 }else{phone=phone.substring(0,25);}
													 if(fax.length()<25){
																  String tv="";
																  for(int v=0;v<(25-fax.length());v++){
																  tv=" "+tv;
															   }
																  fax=fax+tv;
													 }else{fax=fax.substring(0,25);}
													 if(contact_name.length()<30){
																  String tv="";
																  for(int v=0;v<(30-contact_name.length());v++){
																  tv=" "+tv;
															   }
																  contact_name=contact_name+tv;
													 }else{contact_name=contact_name.substring(0,30);}
													 if(customer_po_no.length()<15){
																  String tv="";
																  for(int v=0;v<(15-customer_po_no.length());v++){
																  tv=" "+tv;
															   }
																  customer_po_no=customer_po_no+tv;
													 }else{customer_po_no=customer_po_no.substring(0,15);}
													 if(Project_name.length()<50){
																  String tv="";
																  for(int v=0;v<(50-Project_name.length());v++){
																  tv=" "+tv;
															   }
																  Project_name=Project_name+tv;
													 }else{Project_name=Project_name.substring(0,50);}
													 r="";
													 for (int i = 0; i < ship_date.length(); i ++) {
														    if (ship_date.charAt(i) != '.' && ship_date.charAt(i) != ',') r += ship_date.charAt(i);
													 }
													 ship_date=r;

													 if(ship_date.length()<8){
																  String tv="";
																  for(int v=0;v<(8-ship_date.length());v++){
																  tv="0"+tv;
															   }
																  ship_date=tv+ship_date;
													 }
													 if(email_to.length()<30){
																  String tv="";
																  for(int v=0;v<(30-email_to.length());v++){
																  tv=" "+tv;
															   }
																  email_to=email_to+tv;
													 }else{email_to=email_to.substring(0,30);}
										// phase -2 code starts here
													 //1.market
													 String market="";

													 if(product_id.equals("EJC")|product_id.equals("TPG")||georder.trim().equals("GE")){
														    market="TR";
													 }else{
															if(doc_priority.equals("C")){
																  market="TR";
															}
															else{
																  market="DG";
															 }
													 }
													 //formattting
													 if(market.length()<5){
																  String tv="";
																  for(int v=0;v<(5-market.length());v++){
																  tv=" "+tv;
															   }
																  market=market+tv;
													 }else{market=market.substring(0,5);}
													 //market ends
													 //2.Region starts
													 //2.Region starts
													 if(georder.trim().equals("GE")){
														    int na=sales_region.indexOf("--");
														    if (na >=0 ){
																  sales_region=sales_region.substring(0,na);
														    }
													 }
													 else{
														    if(groupName.toUpperCase().startsWith("CAN")){
																  if(sales_region.trim().length()>0 && sales_region.indexOf("-")>0){
																		sales_region=sales_region.substring(0,sales_region.indexOf("-"));
																  }
																  else{
																		if(sales_region.trim().length()>0){
																			   sales_region=sales_region.substring(0,1);
																		}
																  }
														    }
														    else{
																  if(sales_region.trim().length()>0){
																		sales_region=sales_region.substring(0,1);
																  }
														    }
													 }
													 //formattting
													 if(sales_region.length()<6){
																  String tv="";
																  for(int v=0;v<(6-sales_region.length());v++){
																  tv=" "+tv;
															   }
																  sales_region=sales_region+tv;
													 }else{sales_region=sales_region.substring(0,6);}
													 //Region ends
													 //3.Terms start
													 String terms="";
													 if(payment_terms.startsWith("CC")|payment_terms.startsWith("V")|payment_terms.startsWith("CW")){
														    terms="CC";
													 }else{
														    terms="30";
													 }
													 //terms end
													 //4.Source
													 if(source.length()<3){
																  String tv="";
																  for(int v=0;v<(3-source.length());v++){
																  tv=" "+tv;
															   }
																  source=source+tv;
													 }else{source=source.substring(0,3);}
													 //source ends
											   //ware house on the header line
													 String ware_house_header="";String ware_house_line="";
													 if(win_loss.equals("RF")&& special_cut.equals("N")){//Relase and with out cuts
														    ware_house_header="1 ";
													 }else{
														    ware_house_header="DR";
													 }
													 if(ware_house_header.length()<2){
														    String tv="";
														    for(int v=0;v<(2-ware_house_header.length());v++){
														    tv=" "+tv;
														}
														    ware_house_header=ware_house_header+tv;
											   }else{ware_house_header=ware_house_header.substring(0,2);}
													 if(groupName.toUpperCase().startsWith("CAN")){
														    ware_house_header="CW";
														    ware_house_line="CW";
													 }
										// phase -2 ends starts here
										// shock wave addition starts here
						    //tax code
						    //String sales_tax_code="00000";
						    if(sales_tax_code.length()<5){
								  String tv="";
								  for(int v=0;v<(5-sales_tax_code.length());v++){
								  tv=" "+tv;
							   }
								  sales_tax_code=sales_tax_code+tv;
						    }else{sales_tax_code=sales_tax_code.substring(0,5);}
						    //tax code done
						    String release_flag="";String user_hold="";
						    if(win_loss.equals("RF")){release_flag="1";}else{release_flag=" ";}
						    if(win_loss.equals("HA")){user_hold="01";}else{user_hold="00";}
						    if(bpcs_tier_order == null && bpcs_tier_order.trim().length()<=0){
								  bpcs_tier_order=" ";
						    }
						    // shock wave addition ends here
						    //code for GE orders divison
						    String divison="";
						    if(georder.trim().equals("GE")){divison="A6";}
						    else{divison="A2";}
						    // shock wave addition ends here
						    if(groupName.toUpperCase().startsWith("CAN")){
								  divison="AE";
						    }
if(quote_origin.equals("sample")){
divison="SA";
ware_house_header="SA";
}
		final_oh_out=final_oh_out+"HO"+order_no+bpcs_cust_no+cust_name1+cust_addr1+cust_addr2+city+state+zip_code+phone+fax+contact_name+customer_po_no+payment_terms+Project_name+ship_date+email_to+ware_house_header+market+divison+sales_region+terms+source+ship_to_customer+invoice_customer+sales_tax_code+release_flag+user_hold+bpcs_tier_order+"\r\n";
		//os out
													 if(ship_name.length()<30){
																  String tv="";
																  for(int v=0;v<(30-ship_name.length());v++){
																  tv=" "+tv;
															   }
																  ship_name=ship_name+tv;
													 }else{ship_name=ship_name.substring(0,30);}
													 if(ship_addr1.length()<30){
																  String tv="";
																  for(int v=0;v<(30-ship_addr1.length());v++){
																  tv=" "+tv;
															   }
																  ship_addr1=ship_addr1+tv;
													 }else{ship_addr1=ship_addr1.substring(0,30);}
													 if(ship_addr2.length()<30){
																  String tv="";
																  for(int v=0;v<(30-ship_addr2.length());v++){
																  tv=" "+tv;
															   }
																  ship_addr2=ship_addr2+tv;
													 }else{ship_addr2=ship_addr2.substring(0,30);}
													 if(ship_city.length()<30){
																  String tv="";
																  for(int v=0;v<(30-ship_city.length());v++){
																  tv=" "+tv;
															   }
																  ship_city=ship_city+tv;
													 }else{ship_city=ship_city.substring(0,30);}
													 if(ship_state.length()<3){
																  String tv="";
																  for(int v=0;v<(3-ship_state.length());v++){
																  tv=" "+tv;
															   }
																  ship_state=ship_state+tv;
													 }else{ship_state=ship_state.substring(0,3);}
													 if(ship_zip.length()<9){
																  String tv="";
																  for(int v=0;v<(9-ship_zip.length());v++){
																  tv=" "+tv;
															   }
																  ship_zip=ship_zip+tv;
													 }else{ship_zip=ship_zip.substring(0,9);}
													 if(ship_phone.length()<25){
																  String tv="";
																  for(int v=0;v<(25-ship_phone.length());v++){
																  tv=" "+tv;
															   }
																  ship_phone=ship_phone+tv;
													 }else{ship_phone=ship_phone.substring(0,25);}
													 if(ship_attention.length()<30){
														    String tv="";
														    for(int v=0;v<(30-ship_attention.length());v++){
														    tv=" "+tv;
														}
														    ship_attention=ship_attention+tv;
											   }else{ship_attention=ship_attention.substring(0,30);}
													 final_os_out=final_os_out+"SO"+order_no+ship_name+ship_addr1+ship_addr2+ship_city+ship_state+ship_zip+ship_phone+ship_attention+"\r\n";
		//oi out
		//out.println("This is test0"+win_loss+":"+"special cut"+special_cut);
		//Stuff for Bills and routings added on Jan'14 10
		Vector shop_parts=new Vector();Vector shop_qty=new Vector();Vector shop_part_desc=new Vector();Vector shop_line_no=new Vector();String win_loss_final="";
		//Stuff for Bills and routings added done
//out.println("4");
//out.println("1");
														    String tot_price_string= String.valueOf(for13.format(total_sale_price));
														    if(!quote_origin.equals("sample")&&win_loss.equals("DR")|(special_cut.equals("Y")& win_loss.equals("RF"))){
			   //								out.println("This is test");
//out.println("2");
														    if(win_loss.equals("DR")){
win_loss_final="DRAFTLOG"+product_id;
}
else{
win_loss_final="DRAFTLOGREP"+product_id;
}
														    lineIncrease++;
														    diLineCounter++;
														    if(win_loss_final.length()<15){
														    String tv="";
														    for(int v=0;v<(15-win_loss_final.length());v++){
														    tv=" "+tv;
															  }
														    win_loss_final=win_loss_final+tv;
														    }
														    r="";
														    for (int i = 0; i < tot_price_string.length(); i ++) {
																  if (tot_price_string.charAt(i) != '.' && tot_price_string.charAt(i) != ',') r += tot_price_string.charAt(i);
														    }
														    tot_price_string=r;
														    if(tot_price_string.length()<11){
														    String tv="";
														    for(int v=0;v<(11-tot_price_string.length());v++){
														    tv="0"+tv;
															  }
														    tot_price_string=tv+tot_price_string;
														    }
														    ware_house_line="DR";
														    //stuff for BOMS/Routings
														    shop_parts.addElement(win_loss_final);
														    shop_qty.addElement("1");
														    shop_part_desc.addElement("misc");
														    shop_line_no.addElement("0");
														    //stuff for BOMS/Routings done
														    final_oi_out=final_oi_out+"IO"+order_no+win_loss_final+tot_price_string+"00000000000000"+ware_house_line+bpcs_tier_order+"\r\n";
														    }else if(!quote_origin.equals("sample")&&win_loss.equals("HA")){
//out.println("3");
														    win_loss_final=product_id+"INFOHOLD";
														    lineIncrease++;
														    diLineCounter++;
														    if(win_loss_final.length()<15){
														    String tv="";
														    for(int v=0;v<(15-win_loss_final.length());v++){
														    tv=" "+tv;
															  }
														    win_loss_final=win_loss_final+tv;
														    }
														    r="";
														    for (int i = 0; i < tot_price_string.length(); i ++) {
																  if (tot_price_string.charAt(i) != '.' && tot_price_string.charAt(i) != ',') r += tot_price_string.charAt(i);
														    }
														    tot_price_string=r;
														    if(tot_price_string.length()<11){
														    String tv="";
														    for(int v=0;v<(11-tot_price_string.length());v++){
														    tv="0"+tv;
															  }
														    tot_price_string=tv+tot_price_string;
														    }
														    ware_house_line="DR";
														    //stuff for BOMS/Routings
														    shop_parts.addElement(win_loss_final);
														    shop_qty.addElement("1");
														    shop_part_desc.addElement("misc");
														    shop_line_no.addElement("0");
														    //stuff for BOMS/Routings done
														    final_oi_out=final_oi_out+"IO"+order_no+win_loss_final+tot_price_string+"00000000000000"+ware_house_line+bpcs_tier_order+"\r\n";
														    }
														    //for getting ware house info for the lines
														    else{
//out.println("4");
																  if(georder.trim().equals("GE")){
																		ware_house_line="1G";
																  }
																else if(quote_origin.equals("sample")){
ware_house_line="SA";
														}
																  else{
																		ware_house_line="1 ";
																  }
														    }
		/*								if(win_loss.equals("RF")){//Release and cuts donot matter
																  ware_house_line="1 ";
														    }else{
																  ware_house_line="DR";
														    } */
		// OI rules are different for products change them accordingly
//out.println("4");
boolean mat=false;
boolean template=false;
boolean grid=false;
								  if(product_id.equals("EFS")){
								  //Vars
								  String line_no_text="";
								  String blockId="";String bpcs_tier_line="";
								  String efs_qty_mat_grid="";double efs_price_mat_grid=0.0;String efs_bpcs_item="";double efs_com_price_mat_grid=0.0;double efs_com_perc_mat_grid=0.0;
								  int efs_qty_template_mat=0;double efs_price_template_mat=0.0;String efs_bpcs_item_template_mat="";double efs_com_price_template_mat=0.0;double efs_com_perc_template_mat=0.0;
								  int efs_qty_template_grid=0;double efs_price_template_grid=0.0;String efs_bpcs_item_template_grid="";double efs_com_price_template_grid=0.0;double efs_com_perc_template_grid=0.0; double efs_qty_mat_grid_up=0.0;
								  for(int ii=0;ii<items.size();ii++){
mat=false;
template=false;
grid=false;
					    for(int i=0;i<block_id.size();i++){
//out.println(i+"::<BR>");
//out.println("::"+line_item.elementAt(i).toString()+"::"+items.elementAt(ii).toString()+"::<BR>");

										  if(line_item.elementAt(i).toString().equals(items.elementAt(ii).toString())){
//out.println(block_id.elementAt(i).toString()+"::"+items.elementAt(ii).toString()+"after<BR>");
											   //line_no_text=items.elementAt(ii).toString();
											if( !(block_id.elementAt(i).toString().startsWith("E_DIM")|block_id.elementAt(i).toString().startsWith("A_APRODUCT")|block_id.elementAt(i).toString().startsWith("D_NOTES")) ){
												if(block_id.elementAt(i).toString().startsWith("A_")){//MAT/GRID PARTS
													 blockId=block_id.elementAt(i).toString();
													//out.println("<BR>"+block_id.elementAt(i).toString()+"::"+price.elementAt(i).toString()+" here<BR>");
													 efs_bpcs_item=bpcs_part_no.elementAt(i).toString();
													 efs_qty_mat_grid=String.valueOf(for13.format((new Double(bpcs_qty.elementAt(i).toString()).doubleValue())*(new Double(QTY.elementAt(i).toString()).doubleValue()) ));
													 efs_qty_mat_grid_up=(new Double(QTY.elementAt(i).toString()).doubleValue())*(new Double(bpcs_qty.elementAt(i).toString()).doubleValue());
													 //out.println(price.elementAt(i).toString()+"<BR>");
													 efs_price_mat_grid=efs_price_mat_grid+Double.parseDouble(price.elementAt(i).toString());
													 efs_com_price_mat_grid=efs_com_price_mat_grid+Double.parseDouble(fact_per.elementAt(i).toString())*Double.parseDouble(price.elementAt(i).toString());
													mat=true;
}
												if(block_id.elementAt(i).toString().startsWith("C_FINISHES")){//ROLL TO MAT/GRID
mat=true;
													efs_price_mat_grid=efs_price_mat_grid+Double.parseDouble(price.elementAt(i).toString());
													efs_com_price_mat_grid=efs_com_price_mat_grid+Double.parseDouble(fact_per.elementAt(i).toString())*Double.parseDouble(price.elementAt(i).toString());
												}
												if(block_id.elementAt(i).toString().startsWith("D_MISC5")){// ROLL TO MAT/GRID
mat=true;
													efs_price_mat_grid=efs_price_mat_grid+Double.parseDouble(price.elementAt(i).toString());
													efs_com_price_mat_grid=efs_com_price_mat_grid+Double.parseDouble(fact_per.elementAt(i).toString())*Double.parseDouble(price.elementAt(i).toString());
												}
												if(block_id.elementAt(i).toString().startsWith("FACTORY")){// ROLL TO MAT/GRID
mat=true;
													efs_price_mat_grid=efs_price_mat_grid+Double.parseDouble(price.elementAt(i).toString());
													efs_com_price_mat_grid=efs_com_price_mat_grid+Double.parseDouble(fact_per.elementAt(i).toString())*Double.parseDouble(price.elementAt(i).toString());
												}
												if(block_id.elementAt(i).toString().startsWith("C_MISC")){// ROLL TO MAT/GRID EXCEPTION ARE TEMPLATE MAT/GRID
													if( !(bpcs_part_no.elementAt(i).toString().startsWith("TEMPLATEMAT")|bpcs_part_no.elementAt(i).toString().startsWith("TEMPLATEGRID"))){
mat=true;
efs_price_mat_grid=efs_price_mat_grid+Double.parseDouble(price.elementAt(i).toString());
														efs_com_price_mat_grid=efs_com_price_mat_grid+Double.parseDouble(fact_per.elementAt(i).toString())*Double.parseDouble(price.elementAt(i).toString());
													}
													else if(bpcs_part_no.elementAt(i).toString().startsWith("TEMPLATEMAT")){
template=true;
														efs_price_template_mat=efs_price_template_mat+Double.parseDouble(price.elementAt(i).toString());
														efs_qty_template_mat=efs_qty_template_mat+Integer.parseInt(bpcs_qty.elementAt(i).toString());
														efs_com_price_template_mat=efs_com_price_template_mat+Double.parseDouble(fact_per.elementAt(i).toString())*Double.parseDouble(price.elementAt(i).toString());
													}
													else if(bpcs_part_no.elementAt(i).toString().startsWith("TEMPLATEGRID")){
grid=true;
														efs_price_template_grid=efs_price_template_grid+Double.parseDouble(price.elementAt(i).toString());
														efs_qty_template_grid=efs_qty_template_grid+Integer.parseInt(bpcs_qty.elementAt(i).toString());
														efs_com_price_template_grid=efs_com_price_template_grid+Double.parseDouble(fact_per.elementAt(i).toString())*Double.parseDouble(price.elementAt(i).toString());
													}
												}
										}//inner if statment
								   }//outer if statment
										 bpcs_tier_line=bpcs_tier_lines.elementAt(i).toString();//tier line for shockwave changes
						    }//INNER for loop
							   if (efs_price_mat_grid>0||mat&&quote_origin.equals("sample")){
										//out.println(blockId+"< inside efs_price_mat_grid<BR>");
											   r="";
											   for (int i = 0; i < efs_qty_mat_grid.length(); i ++) {
													 if (efs_qty_mat_grid.charAt(i) != '.' && efs_qty_mat_grid.charAt(i) != ',') r += efs_qty_mat_grid.charAt(i);
											   }
											   efs_qty_mat_grid=r;
											   if(efs_qty_mat_grid.length()<11){
											   String tv="";
											   for(int v=0;v<(11-efs_qty_mat_grid.length());v++){
											   tv="0"+tv;
												 }
											   efs_qty_mat_grid=tv+efs_qty_mat_grid;
											   }
											   if(efs_bpcs_item.length()<15){
											   String tv="";
											   for(int v=0;v<(15-efs_bpcs_item.length());v++){
											   tv=" "+tv;
												 }
											   efs_bpcs_item=efs_bpcs_item+tv;
											   }
											   efs_com_perc_mat_grid=(efs_com_price_mat_grid/efs_price_mat_grid)*100;
											   lineOver=efs_price_mat_grid;
											   String efs_price_mat_grid_string= String.valueOf(for14.format(efs_price_mat_grid));
											   String efs_com_price_mat_grid_string= for12.format(efs_com_price_mat_grid);
											   String efs_com_perc_mat_grid_string= for19.format(efs_com_perc_mat_grid);
											   String efs_price_mat_grid_string_up = String.valueOf(for14.format(efs_price_mat_grid/efs_qty_mat_grid_up));
											   //String comPerc=String.valueOf(for19.format(100*(efs_com_price_mat_grid/efs_price_mat_grid)));
											   String comPerc="";
											   if (prio.equals("E")){
													 comPerc=String.valueOf(for19.format(100*(efs_com_price_mat_grid/efs_price_mat_grid)));
											   }
											   else{
													 comPerc=String.valueOf(for19.format(100*(efs_com_price_mat_grid/(efs_price_mat_grid*(0.91)))));
											   }
											   r="";
											   for (int i = 0; i < comPerc.length(); i ++) {
													 if (comPerc.charAt(i) != '.' && comPerc.charAt(i) != ',') r += comPerc.charAt(i);
											   }
											   comPerc=r;
											   if(comPerc.length()<12){
											   String tv="";
											   for(int v=0;v<(12-comPerc.length());v++){
											   tv="0"+tv;
												 }
											   comPerc=tv+comPerc;
											   }
											   r="";
											   for (int i = 0; i < efs_price_mat_grid_string.length(); i ++) {
													 if (efs_price_mat_grid_string.charAt(i) != '.' && efs_price_mat_grid_string.charAt(i) != ',') r += efs_price_mat_grid_string.charAt(i);
											   }
											   efs_price_mat_grid_string=r;
											   if(efs_price_mat_grid_string.length()<14){
											   String tv="";
											   for(int v=0;v<(14-efs_price_mat_grid_string.length());v++){
											   tv="0"+tv;
											   }
											   efs_price_mat_grid_string=tv+efs_price_mat_grid_string;
											   }
											   r="";
											   for (int i = 0; i < efs_price_mat_grid_string_up.length(); i ++) {
													 if (efs_price_mat_grid_string_up.charAt(i) != '.' && efs_price_mat_grid_string_up.charAt(i) != ',') r += efs_price_mat_grid_string_up.charAt(i);
											   }
											   efs_price_mat_grid_string_up=r;
											   if(efs_price_mat_grid_string_up.length()<14){
													 String tv="";
													 for(int v=0;v<(14-efs_price_mat_grid_string_up.length());v++){
														    tv="0"+tv;
													 }
													 efs_price_mat_grid_string_up=tv+efs_price_mat_grid_string_up;
											   }
											   r="";
											   for (int i = 0; i < efs_com_price_mat_grid_string.length(); i ++) {
													 if (efs_com_price_mat_grid_string.charAt(i) != '.' && efs_com_price_mat_grid_string.charAt(i) != ',') r += efs_com_price_mat_grid_string.charAt(i);
											   }
											   efs_com_price_mat_grid_string=r;
											   if(efs_com_price_mat_grid_string.length()<15){
											   String tv="";
											   for(int v=0;v<(15-efs_com_price_mat_grid_string.length());v++){
											   tv="0"+tv;
												}
											   efs_com_price_mat_grid_string=tv+efs_com_price_mat_grid_string;
											   }
											   r="";
											   for (int i = 0; i < efs_com_perc_mat_grid_string.length(); i ++) {
													 if (efs_com_perc_mat_grid_string.charAt(i) != '.' && efs_com_perc_mat_grid_string.charAt(i) != ',') r += efs_com_perc_mat_grid_string.charAt(i);
											   }
											   efs_com_perc_mat_grid_string=r;
											   if(efs_com_perc_mat_grid_string.length()<12){
											   String tv="";
											   for(int v=0;v<(12-efs_com_perc_mat_grid_string.length());v++){
											   tv="0"+tv;
												 }
											   efs_com_perc_mat_grid_string=tv+efs_com_perc_mat_grid_string;
											   }
											   //Overage calcs\
											   //out.println(efs_com_price_mat_grid+"*("+overage+"/"+config_price+")<BR>");
											   //double over_price=efs_com_price_mat_grid*(Double.parseDouble(overage)/config_price);
											   double over_price=lineOver*(Double.parseDouble(overage)/(config_price-nonCommission));
											   //over price
											   if(new Double(efs_com_price_mat_grid_string).doubleValue() <=0){
													 over_price=0;
											   }
											   String over_price_string=for12.format(over_price);
													 String overx=String.valueOf(over_price);
											   //over_price_string="0";
											   // as requested by ACosma
											   // bpcs will do line overage automatically based on job overage
											   // Sept 21/05
										int neg = over_price_string.indexOf("-");
										if(neg >= 0){
											   //out.println(over_price_string +" original<BR>");
											   over_price_string=over_price_string.substring(neg+1);
											   //out.println(over_price_string +" with out negative<BR>");
											   String lastDigit=over_price_string.substring(over_price_string.length() -1);
											   over_price_string=over_price_string.substring(0,over_price_string.length()-1)+charMap[Integer.parseInt(lastDigit)];
											   //out.println(over_price_string+" with char replaced<BR>");
										}
											   r="";
											   for (int i = 0; i < over_price_string.length(); i ++) {
													 if (over_price_string.charAt(i) != '.' && over_price_string.charAt(i) != ',') r += over_price_string.charAt(i);
											   }
											   over_price_string=r;
											   if(over_price_string.length()<15){
											   String tv="";
											   for(int v=0;v<(15-over_price_string.length());v++){
											   tv="0"+tv;
												 }
											   over_price_string=tv+over_price_string;
											   }
											   //overage perc
											   double over_perc=(over_price*100)/Double.parseDouble(overage);
											   String over_perc_string=for19.format(over_perc);
											   r="";
											   for (int i = 0; i < over_perc_string.length(); i ++) {
													 if (over_perc_string.charAt(i) != '.' && over_perc_string.charAt(i) != ',') r += over_perc_string.charAt(i);
											   }
											   over_perc_string=r;
											   if(over_perc_string.length()<12){
											   String tv="";
											   for(int v=0;v<(12-over_perc_string.length());v++){
											   tv="0"+tv;
												 }
											   over_perc_string=tv+over_perc_string;
											   }
											   //Overage calcs done
											   // feight calcs
											   String fc_value="";
											   //if (prio.equals("E")){//deco
											   fc_value="0";
											   //}
											   //else{//cs
											   //fc_value=for12.format(efs_com_price_mat_grid*0.09);
											   //}
											   r="";
											   for (int i = 0; i < fc_value.length(); i ++) {
													 if (fc_value.charAt(i) != '.' && fc_value.charAt(i) != ',') r += fc_value.charAt(i);
											   }
											   fc_value=r;
											   if(fc_value.length()<15){
											   String tv="";
											   for(int v=0;v<(15-fc_value.length());v++){
											   tv="0"+tv;
												 }
											   fc_value=tv+fc_value;
											   }
											   line_no_text=String.valueOf(diLineCounter);
											   //out.println(line_no_text+"::"+diLineCounter+"<BR>");
											   r="";
											   for (int iii = 0; iii < line_no_text.length(); iii ++) {
													 if (line_no_text.charAt(iii) != '.' && line_no_text.charAt(iii) != ',') r += line_no_text.charAt(iii);
											   }
											   line_no_text=r;
											   if(line_no_text.length()<3){
													 String tv="";
													 for(int v=0;v<(3-line_no_text.length());v++){
														    tv="0"+tv;
													   }
													 line_no_text=tv+line_no_text;
											   }
											   diLineCounter++;
											   //out.println(lineOver+" here<BR>");
										overageLine=overageLine+over_price;
										//stuff for BOMS/Routings
										shop_parts.addElement(efs_bpcs_item.trim());
										shop_qty.addElement(for13.format(new Double(efs_qty_mat_grid_up).doubleValue()));
										shop_part_desc.addElement("product");
										shop_line_no.addElement(items.elementAt(ii).toString());
										//stuff for BOMS/Routings done
								   //   out.println("<br>"+efs_bpcs_item+":"+efs_qty_mat_grid+":"+efs_price_mat_grid+"ip::"+efs_qty_mat_grid_up+"<br>");
										final_oi_out=final_oi_out+"IO"+order_no+efs_bpcs_item+efs_qty_mat_grid+efs_price_mat_grid_string_up+ware_house_line+bpcs_tier_line+"\r\n";
										final_ic_out=final_ic_out+"DI"+order_no+line_no_text+efs_bpcs_item+efs_price_mat_grid_string_up+rep_no+"001"+comPerc+efs_com_price_mat_grid_string+"100000000000"+over_price_string+fc_value+"\r\n";
									}
										efs_price_mat_grid=0;efs_bpcs_item="";efs_qty_mat_grid="";efs_com_price_mat_grid=0;
						    }//outer for loop for eorder_item lines
								  //frame
								  //Template Mat Starts
								   if(efs_qty_template_mat>0||template&&quote_origin.equals("sample")){
										efs_com_perc_template_mat=(efs_com_price_template_mat/efs_price_template_mat)*100;
										String efs_com_perc_template_mat_string=for19.format(efs_com_perc_template_mat);
										String efs_price_template_mat_string= String.valueOf(for14.format(efs_price_template_mat));
										String efs_price_template_mat_string_up= String.valueOf(for14.format(efs_price_template_mat/efs_qty_template_mat));
										lineOver=efs_price_template_mat;
										String efs_qty_template_mat_string= String.valueOf(for13.format(efs_qty_template_mat));
										String efs_com_price_template_mat_string= for12.format(efs_com_price_template_mat);
										String efs_bpcs_part_template="TEMPLATEMAT";
										//String comPerc=for19.format(100*(efs_com_price_template_mat/efs_price_template_mat));
										String comPerc="";
										if (prio.equals("E")){
											   comPerc=String.valueOf(for19.format(100*(efs_com_price_template_mat/efs_price_template_mat)));
										}
										else{
											   comPerc=String.valueOf(for19.format(100*(efs_com_price_template_mat/(efs_price_template_mat*(0.91)))));
										}
										r="";
											   for (int i = 0; i < comPerc.length(); i ++) {
													 if (comPerc.charAt(i) != '.' && comPerc.charAt(i) != ',') r += comPerc.charAt(i);
											   }
																					 //out.println(comPerc+"c<BR>");
											   comPerc=r;
											   if(comPerc.length()<12){
											   String tv="";
											   for(int v=0;v<(12-comPerc.length());v++){
											   tv="0"+tv;
												 }
											   comPerc=tv+comPerc;
											   }
											   if(efs_bpcs_part_template.length()<15){
											   String tv="";
											   //out.println(efs_bpcs_part_template+"< first<BR>");
											   for(int v=0;v<(15-efs_bpcs_part_template.length());v++){
											   tv=" "+tv;
												 }
											   efs_bpcs_part_template=efs_bpcs_part_template+tv;
											   }
											   //out.println(efs_bpcs_part_template+"< here<BR>");
											   r="";
											   for (int i = 0; i < efs_qty_template_mat_string.length(); i ++) {
													 if (efs_qty_template_mat_string.charAt(i) != '.' && efs_qty_template_mat_string.charAt(i) != ',') r += efs_qty_template_mat_string.charAt(i);
											   }
											   efs_qty_template_mat_string=r;
											   if(efs_qty_template_mat_string.length()<11){
											   String tv="";
											   for(int v=0;v<(11-efs_qty_template_mat_string.length());v++){
											   tv="0"+tv;
											   }
											   efs_qty_template_mat_string=tv+efs_qty_template_mat_string;
											   }
											   r="";
											   for (int i = 0; i < efs_price_template_mat_string.length(); i ++) {
													 if (efs_price_template_mat_string.charAt(i) != '.' && efs_price_template_mat_string.charAt(i) != ',') r += efs_price_template_mat_string.charAt(i);
											   }
											   efs_price_template_mat_string=r;
											   if(efs_price_template_mat_string.length()<14){
											   String tv="";
											   for(int v=0;v<(14-efs_price_template_mat_string.length());v++){
											   tv="0"+tv;
												 }
											   efs_price_template_mat_string=tv+efs_price_template_mat_string;
											   }
											   r="";
											   for (int i = 0; i < efs_price_template_mat_string_up.length(); i ++) {
													 if (efs_price_template_mat_string_up.charAt(i) != '.' && efs_price_template_mat_string_up.charAt(i) != ',') r += efs_price_template_mat_string_up.charAt(i);
											   }
											   efs_price_template_mat_string_up=r;
											   if(efs_price_template_mat_string_up.length()<14){
													 String tv="";
													 for(int v=0;v<(14-efs_price_template_mat_string_up.length());v++){
														    tv="0"+tv;
													 }
													 efs_price_template_mat_string_up=tv+efs_price_template_mat_string_up;
											   }
											   r="";
											   for (int i = 0; i < efs_com_price_template_mat_string.length(); i ++) {
													 if (efs_com_price_template_mat_string.charAt(i) != '.' && efs_com_price_template_mat_string.charAt(i) != ',') r += efs_com_price_template_mat_string.charAt(i);
											   }
											   efs_com_price_template_mat_string=r;
											   if(efs_com_price_template_mat_string.length()<15){
											   String tv="";
											   for(int v=0;v<(15-efs_com_price_template_mat_string.length());v++){
											   tv="0"+tv;
												 }
											   efs_com_price_template_mat_string=tv+efs_com_price_template_mat_string;
											   }
											   r="";
											   for (int i = 0; i < efs_com_perc_template_mat_string.length(); i ++) {
													 if (efs_com_perc_template_mat_string.charAt(i) != '.' && efs_com_perc_template_mat_string.charAt(i) != ',') r += efs_com_perc_template_mat_string.charAt(i);
											   }
											   efs_com_perc_template_mat_string=r;
											   if(efs_com_perc_template_mat_string.length()<12){
											   String tv="";
											   for(int v=0;v<(12-efs_com_perc_template_mat_string.length());v++){
											   tv="0"+tv;
												 }
											   efs_com_perc_template_mat_string=tv+efs_com_perc_template_mat_string;
											   }
		//						out.println("123"+efs_com_perc_template_mat_string+"test "+"<br>");
											   ////Overage calcs
										//	out.println(efs_price_template_mat+"*("+overage+"/"+config_price+")<BR>");
											   double over_price=lineOver*(Double.parseDouble(overage)/(config_price-nonCommission));
											   //double over_price=efs_price_template_mat*(Double.parseDouble(overage)/config_price);
											   if(new Double(efs_com_price_template_mat_string).doubleValue()<=0){
													 over_price=0;
											   }
											   //over price
											   String over_price_string=for12.format(over_price);
											   String overx=String.valueOf(over_price);
											   //over_price_string="0";
											   // as requested by ACosma
											   // bpcs will do line overage automatically based on job overage
											   // Sept 21/05
										int neg = over_price_string.indexOf("-");
										if(neg >= 0){
											   //out.println(over_price_string +" original<BR>");
											   over_price_string=over_price_string.substring(neg+1);
											   //out.println(over_price_string +" with out negative<BR>");
											   String lastDigit=over_price_string.substring(over_price_string.length() -1);
											   over_price_string=over_price_string.substring(0,over_price_string.length()-1)+charMap[Integer.parseInt(lastDigit)];
											   //out.println(over_price_string+" with char replaced<BR>");
										}
											   r="";
											   for (int i = 0; i < over_price_string.length(); i ++) {
													 if (over_price_string.charAt(i) != '.' && over_price_string.charAt(i) != ',') r += over_price_string.charAt(i);
											   }
											   over_price_string=r;
											   if(over_price_string.length()<15){
											   String tv="";
											   for(int v=0;v<(15-over_price_string.length());v++){
											   tv="0"+tv;
												 }
											   over_price_string=tv+over_price_string;
											   }
		//						//out.println("Overage amount"+over_price_string+"<br>");
											   //overage perc
											   double over_perc=(over_price*100)/Double.parseDouble(overage);
											   String over_perc_string=for12.format(over_perc);
											   r="";
											   for (int i = 0; i < over_perc_string.length(); i ++) {
													 if (over_perc_string.charAt(i) != '.' && over_perc_string.charAt(i) != ',') r += over_perc_string.charAt(i);
											   }
		//						over_price_string=r;
											   over_perc_string=r;
											   if(over_perc_string.length()<12){
											   String tv="";
											   for(int v=0;v<(12-over_perc_string.length());v++){
											   tv="0"+tv;
												 }
											   over_perc_string=tv+over_perc_string;
											   }
											   //Overage calcs done
											   // feight calcs
											   String fc_value="";
											   //if (prio.equals("E")){//deco
											   fc_value="0";
											   //}
											   //else{//cs
											   //fc_value=for12.format(efs_price_template_mat*0.09);
											   //}
											   r="";
											   for (int i = 0; i < fc_value.length(); i ++) {
													 if (fc_value.charAt(i) != '.' && fc_value.charAt(i) != ',') r += fc_value.charAt(i);
											   }
											   fc_value=r;
											   if(fc_value.length()<15){
											   String tv="";
											   for(int v=0;v<(15-fc_value.length());v++){
											   tv="0"+tv;
												 }
											   fc_value=tv+fc_value;
											   }
											   line_no_text=String.valueOf(diLineCounter);
											   //out.println(line_no_text+"::"+diLineCounter+"<BR>");
											   r="";
											   for (int iii = 0; iii < line_no_text.length(); iii ++) {
													 if (line_no_text.charAt(iii) != '.' && line_no_text.charAt(iii) != ',') r += line_no_text.charAt(iii);
											   }
											   line_no_text=r;
											   if(line_no_text.length()<3){
													 String tv="";
													 for(int v=0;v<(3-line_no_text.length());v++){
														    tv="0"+tv;
													   }
													 line_no_text=tv+line_no_text;
											   }
											   diLineCounter++;
																		//out.println(comPerc+"c<BR>");
																		//out.println(lineOver+" here<BR>");
								  overageLine=overageLine+over_price;

											   //stuff for BOMS/Routings
											   shop_parts.addElement(efs_bpcs_part_template.trim());
											   shop_qty.addElement(for13.format(new Double(efs_qty_template_mat).doubleValue()));
											   shop_part_desc.addElement("product");
											   shop_line_no.addElement(" ");
											   //stuff for BOMS/Routings done
										final_oi_out=final_oi_out+"IO"+order_no+efs_bpcs_part_template+efs_qty_template_mat_string+efs_price_template_mat_string_up+ware_house_line+bpcs_tier_line+"\r\n";
										final_ic_out=final_ic_out+"DI"+order_no+line_no_text+efs_bpcs_part_template+efs_price_template_mat_string_up+rep_no+"001"+comPerc+efs_com_price_template_mat_string+"100000000000"+over_price_string+fc_value+"\r\n";

										}
//out.println("5");
										// Template Mat ends
								  //Template grid Starts
								   if(efs_qty_template_grid>0||grid&&quote_origin.equals("sample")){
										efs_com_perc_template_grid=(efs_com_price_template_grid/efs_price_template_mat)*100;
										String efs_com_perc_template_grid_string=for19.format(efs_com_perc_template_grid);
										String efs_price_template_grid_string= String.valueOf(for14.format(efs_price_template_grid));
										lineOver=efs_price_template_grid;
										String efs_price_template_grid_string_up= String.valueOf(for14.format(efs_price_template_grid/efs_qty_template_grid));
										String efs_qty_template_grid_string= String.valueOf(for13.format(efs_qty_template_grid));
										String efs_com_price_template_grid_string= for12.format(efs_com_price_template_grid);
										String efs_bpcs_part_template="TEMPLATEGRID";
										//String comPerc=for19.format(100*(efs_com_price_template_grid/efs_price_template_grid));
										String comPerc="";
										if (prio.equals("E")){
											   comPerc=String.valueOf(for19.format(100*(efs_com_price_template_grid/efs_price_template_grid)));
										}
										else{
											   comPerc=String.valueOf(for19.format(100*(efs_com_price_template_grid/(efs_price_template_grid*(0.91)))));
										}
											   r="";
											   for (int i = 0; i < comPerc.length(); i ++) {
													 if (comPerc.charAt(i) != '.' && comPerc.charAt(i) != ',') r += comPerc.charAt(i);
											   }
											   comPerc=r;
											   //out.println(comPerc+"b<BR>");
											   if(comPerc.length()<12){
											   String tv="";
											   for(int v=0;v<(12-comPerc.length());v++){
											   tv="0"+tv;
												 }
											   comPerc=tv+comPerc;
											   }
											   //out.println(comPerc+"b<BR>");
											   if(efs_bpcs_part_template.length()<15){
													 String tv="";
													 for(int v=0;v<(15-efs_bpcs_part_template.length());v++){
														    tv=" "+tv;
													  }
													 efs_bpcs_part_template=efs_bpcs_part_template+tv;
											   }
											   r="";
											   for (int i = 0; i < efs_qty_template_grid_string.length(); i ++) {
													 if (efs_qty_template_grid_string.charAt(i) != '.' && efs_qty_template_grid_string.charAt(i) != ',') r += efs_qty_template_grid_string.charAt(i);
											   }
											   efs_qty_template_grid_string=r;
											   if(efs_qty_template_grid_string.length()<11){
											   String tv="";
											   for(int v=0;v<(11-efs_qty_template_grid_string.length());v++){
											   tv="0"+tv;
												 }
											   efs_qty_template_grid_string=tv+efs_qty_template_grid_string;
											   }
											   r="";
											   for (int i = 0; i < efs_price_template_grid_string.length(); i ++) {
													 if (efs_price_template_grid_string.charAt(i) != '.' && efs_price_template_grid_string.charAt(i) != ',') r += efs_price_template_grid_string.charAt(i);
											   }
											   efs_price_template_grid_string=r;
											   if(efs_price_template_grid_string.length()<14){
											   String tv="";
											   for(int v=0;v<(14-efs_price_template_grid_string.length());v++){
											   tv="0"+tv;
												 }
											   efs_price_template_grid_string=tv+efs_price_template_grid_string;
											   }
											   r="";
											   for (int i = 0; i < efs_price_template_grid_string_up.length(); i ++) {
													 if (efs_price_template_grid_string_up.charAt(i) != '.' && efs_price_template_grid_string_up.charAt(i) != ',') r += efs_price_template_grid_string_up.charAt(i);
											   }
											   efs_price_template_grid_string_up=r;
											   if(efs_price_template_grid_string_up.length()<14){
											   String tv="";
											   for(int v=0;v<(14-efs_price_template_grid_string_up.length());v++){
											   tv="0"+tv;
											   }
											   efs_price_template_grid_string_up=tv+efs_price_template_grid_string_up;
											   }
											   r="";
											   for (int i = 0; i < efs_com_price_template_grid_string.length(); i ++) {
													 if (efs_com_price_template_grid_string.charAt(i) != '.' && efs_com_price_template_grid_string.charAt(i) != ',') r += efs_com_price_template_grid_string.charAt(i);
											   }
											   efs_com_price_template_grid_string=r;
											   //out.println("BeFORE IF<BR>");
											   if(efs_com_price_template_grid_string.length()<15){
													 //out.println("INside if<BR>");
											   String tv="";
											   for(int v=0;v<(15-efs_com_price_template_grid_string.length());v++){
											   tv="0"+tv;
												 }
											   efs_com_price_template_grid_string=tv+efs_com_price_template_grid_string;
											   }
											   //out.println(efs_com_price_template_grid_string+"< here<BR>");
											   r="";
											   for (int i = 0; i < efs_com_perc_template_grid_string.length(); i ++) {
													 if (efs_com_perc_template_grid_string.charAt(i) != '.' && efs_com_perc_template_grid_string.charAt(i) != ',') r += efs_com_perc_template_grid_string.charAt(i);
											   }
											   efs_com_perc_template_grid_string=r;
											   if(efs_com_perc_template_grid_string.length()<12){
											   String tv="";
											   for(int v=0;v<(12-efs_com_perc_template_grid_string.length());v++){
											   tv="0"+tv;
												 }
											   efs_com_perc_template_grid_string=tv+efs_com_perc_template_grid_string;
											   }
											   //Overage calcs
											   //out.println(efs_price_template_grid+"*("+overage+"/"+config_price+")<BR>");
											   double over_price=lineOver*(Double.parseDouble(overage)/(config_price-nonCommission));
											   //double over_price=efs_price_template_grid*(Double.parseDouble(overage)/config_price);
											   if(new Double(efs_com_price_template_grid_string).doubleValue()<=0){
													 over_price=0;
											   }
											   //over price
											   String over_price_string=for12.format(over_price);
											   String overx=String.valueOf(over_price);
											   //String over
											   //over_price_string="0";
											   // as requested by ACosma
											   // bpcs will do line overage automatically based on job overage
											   // Sept 21/05

										int neg = over_price_string.indexOf("-");
										if(neg >= 0){
											   //out.println(over_price_string +" original<BR>");
											   over_price_string=over_price_string.substring(neg+1);
											   //out.println(over_price_string +" with out negative<BR>");
											   String lastDigit=over_price_string.substring(over_price_string.length() -1);
											   over_price_string=over_price_string.substring(0,over_price_string.length()-1)+charMap[Integer.parseInt(lastDigit)];
											   //out.println(over_price_string+" with char replaced<BR>");
										}
											   r="";
											   for (int i = 0; i < over_price_string.length(); i ++) {
													 if (over_price_string.charAt(i) != '.' && over_price_string.charAt(i) != ',') r += over_price_string.charAt(i);
											   }
											   over_price_string=r;
											   if(over_price_string.length()<15){
											   String tv="";
											   for(int v=0;v<(15-over_price_string.length());v++){
											   tv="0"+tv;
												 }
											   over_price_string=tv+over_price_string;
											   }
											   //overage perc
											   double over_perc=(over_price*100)/Double.parseDouble(overage);
											   String over_perc_string=for12.format(over_perc);
											   r="";
											   for (int i = 0; i < over_perc_string.length(); i ++) {
													 if (over_perc_string.charAt(i) != '.' && over_perc_string.charAt(i) != ',') r += over_perc_string.charAt(i);
											   }
											   over_perc_string=r;
											   if(over_perc_string.length()<12){
											   String tv="";
											   for(int v=0;v<(12-over_perc_string.length());v++){
											   tv="0"+tv;
												 }
											   over_perc_string=tv+over_perc_string;
											   }
											   //Overage calcs done
											   // feight calcs
											   String fc_value="";
											   //if (prio.equals("E")){//deco
											   fc_value="0";
											   //}
											   //else{//cs
											   //fc_value=for12.format(efs_price_template_grid*0.09);
											   //}
											   r="";
											   for (int i = 0; i < fc_value.length(); i ++) {
													 if (fc_value.charAt(i) != '.' && fc_value.charAt(i) != ',') r += fc_value.charAt(i);
											   }
											   fc_value=r;
											   if(fc_value.length()<15){
											   String tv="";
											   for(int v=0;v<(15-fc_value.length());v++){
											   tv="0"+tv;
												 }
											   fc_value=tv+fc_value;
											   }
											   line_no_text=String.valueOf(diLineCounter);
											   //out.println(line_no_text+"::"+diLineCounter+"<BR>");
											   r="";
											   for (int iii = 0; iii < line_no_text.length(); iii ++) {
													 if (line_no_text.charAt(iii) != '.' && line_no_text.charAt(iii) != ',') r += line_no_text.charAt(iii);
											   }
											   line_no_text=r;
											   if(line_no_text.length()<3){
													 String tv="";
													 for(int v=0;v<(3-line_no_text.length());v++){
														    tv="0"+tv;
													   }
													 line_no_text=tv+line_no_text;
											   }
											   diLineCounter++;
								  //out.println(overx+"::"+line_no_text+"::"+efs_qty_template_grid+"<BR>");
								  //out.println(lineOver+" heRE<BR>");
										overageLine=overageLine+over_price;
											   //stuff for BOMS/Routings
											   shop_parts.addElement(efs_bpcs_part_template.trim());
											   shop_qty.addElement(for13.format(new Double(efs_qty_template_grid).doubleValue()));
											   shop_part_desc.addElement("product");
											   shop_line_no.addElement(" ");
											   //stuff for BOMS/Routings done
										final_oi_out=final_oi_out+"IO"+order_no+efs_bpcs_part_template+efs_qty_template_grid_string+efs_price_template_grid_string_up+ware_house_line+bpcs_tier_line+bpcs_tier_line+"\r\n";
										final_ic_out=final_ic_out+"DI"+order_no+line_no_text+efs_bpcs_part_template+efs_price_template_grid_string_up+rep_no+"001"+comPerc+efs_com_price_template_grid_string+"100000000000"+over_price_string+fc_value+"\r\n";
										}
										// Template grid ends
								  // Frames block start
								  // getting the pan lines// added is on Aug'1 08 as per Jim and Charlie
								  Vector pan_bpcs_part_no= new Vector();Vector pan_bpcs_qty= new Vector();int pan_count=0;Vector pan_bpcs_line_no= new Vector();
										ResultSet rs_pan_group = stmt.executeQuery("SELECT line_no,bpcs_gen,bpcs_qty FROM CSQUOTES where order_no like '"+order_no+"' and line_no in ("+lines_final+") and (Block_ID LIKE '%pan%')  and block_id not like '%A_APRODUCT%'");
										if (rs_pan_group !=null) {
								   while (rs_pan_group.next()) {
										 pan_count++;
											   pan_bpcs_line_no.addElement(rs_pan_group.getString(1));
											   pan_bpcs_part_no.addElement(rs_pan_group.getString(2));
											   pan_bpcs_qty.addElement(String.valueOf(for13.format(new Double(rs_pan_group.getString(3)).doubleValue())));
										//	out.println("Pan::"+pan_count+"::"+rs_pan_group.getString(2)+"<br>");
								   }
										}
										rs_pan_group.close();
								  //pan block ends
								  //counting the frames only
								  Vector frame_only_bpcs_part_nos= new Vector();Vector frame_only_bpcs_qty= new Vector();Vector frame_only_bpcs_price= new Vector();
								  Vector frame_only_bpcs_comm= new Vector();Vector frame_only_bpcs_test= new Vector();int frame_parts_count=0;
										ResultSet rs_frame_group_only = stmt.executeQuery("SELECT bpcs_gen, SUM(CAST(bpcs_qty AS decimal(10, 2)) * CAST(QTY AS decimal(10, 2))),sum(cast(extended_price as decimal(10, 2))),sum(CAST(Extended_Price AS decimal(10, 2)) * CAST(field16 AS decimal(10, 5))) FROM CSQUOTES where order_no = '"+order_no+"' and line_no in ("+lines_final+") and (Block_ID LIKE '%frames%')  and block_id not like '%A_APRODUCT%' group by bpcs_gen ");
										//,sum( cast(bpcs_qty as decimal)) used to be but changed to mutiple with qty also on
										if (rs_frame_group_only !=null) {
								  while (rs_frame_group_only.next()) {
										frame_only_bpcs_part_nos.addElement(rs_frame_group_only.getString(1));
										frame_only_bpcs_qty.addElement(String.valueOf(for13.format(new Double(rs_frame_group_only.getString(2)).doubleValue())));
										frame_only_bpcs_price.addElement(String.valueOf(new Double(rs_frame_group_only.getString(3)).doubleValue()));
										frame_only_bpcs_comm.addElement(String.valueOf(new Double(rs_frame_group_only.getString(4)).doubleValue()));
										frame_only_bpcs_test.addElement("N");
										frame_parts_count++;
							    //   	out.println("Frame test::"+frame_parts_count+"::"+rs_frame_group_only.getString(1)+"<br>");
								   }
										}
										rs_frame_group_only.close();
								  //counting the frames only
								  //frame blocks
								  Vector frame_bpcs_part_no_list= new Vector();Vector frame_bpcs_line_no_list= new Vector();Vector frame_bpcs_qty_list= new Vector();
								  Vector frame_bpcs_price_list= new Vector();Vector frame_bpcs_com_price_list= new Vector();Vector pan_or_frame=new Vector();
										ResultSet rs_frame_group = stmt.executeQuery("SELECT bpcs_gen,sum( cast(bpcs_qty as decimal)),sum(cast(extended_price as decimal(10, 2))),sum(CAST(Extended_Price AS decimal(10, 2)) * CAST(field16 AS decimal(10, 5))), Line_no,count(*) FROM CSQUOTES where order_no like '"+order_no+"' and line_no in ("+lines_final+") and (Block_ID LIKE '%pan%' OR Block_ID LIKE '%frames%')  and block_id not like '%A_APRODUCT%' group by bpcs_gen, Line_no ");
										if (rs_frame_group !=null) {
								  while (rs_frame_group.next()) {
										String bpcs_quant_init=String.valueOf(for13.format(new Double(rs_frame_group.getString(2)).doubleValue()));
										String bpcs_price_init=String.valueOf(new Double(rs_frame_group.getString(3)).doubleValue());
										String bpcs_comm_init=String.valueOf(new Double(rs_frame_group.getString(4)).doubleValue());
										String p_or_f="frame";
										//for pans
										if(pan_count>0){
											   for (int ii = 0; ii < pan_count; ii++) {
													 if(rs_frame_group.getString(1).equals(pan_bpcs_part_no.elementAt(ii).toString())&&rs_frame_group.getString(5).equals(pan_bpcs_line_no.elementAt(ii).toString())){
														    bpcs_quant_init=pan_bpcs_qty.elementAt(ii).toString();//use the pan qty not the total frame+pan qty
														    p_or_f="pan";
													 //	out.println("::"+"the pan part"+rs_frame_group.getString(1)+"the before:"+rs_frame_group.getString(2)+"the after::"+pan_bpcs_qty.elementAt(ii).toString()+"<br>");
														    frame_bpcs_part_no_list.addElement(rs_frame_group.getString(1));
														    frame_bpcs_line_no_list.addElement(rs_frame_group.getString(5));
														    frame_bpcs_price_list.addElement(bpcs_price_init);
														    frame_bpcs_com_price_list.addElement(bpcs_comm_init);
														    frame_bpcs_qty_list.addElement(bpcs_quant_init);
														    pan_or_frame.addElement(p_or_f);
														    for (int iz = 0; iz < frame_parts_count; iz++) {
																  if(frame_only_bpcs_part_nos.elementAt(iz).toString().equals(rs_frame_group.getString(1))){
																  //	out.println("<br>test"+rs_frame_group.getString(1)+"<br>");
																		frame_only_bpcs_test.removeElementAt(iz);
																		frame_only_bpcs_test.add(iz,"Y");
																  }
														    }
													 }
											   }
										}	//end of pans
										//for frames
		//						if(rs_frame_group.getDouble(6)<=1){
		//						if(frame_parts_count>0){	//
													 for (int iz = 0; iz < frame_parts_count; iz++) {
														    if(frame_only_bpcs_part_nos.elementAt(iz).toString().equals(rs_frame_group.getString(1))&&frame_only_bpcs_test.elementAt(iz).toString().equals("N") ){
																  bpcs_quant_init=frame_only_bpcs_qty.elementAt(iz).toString();
																  bpcs_comm_init=frame_only_bpcs_comm.elementAt(iz).toString();
																  bpcs_price_init=frame_only_bpcs_price.elementAt(iz).toString();
													 //		out.println(frame_parts_count+"::"+"the frame part"+frame_only_bpcs_part_nos.elementAt(iz).toString()+"::"+rs_frame_group.getString(1)+"the Qty::"+bpcs_quant_init+"::<br>");
													 //		out.println("PRice::"+bpcs_price_init+"Commm::"+bpcs_comm_init+"<br>");
																  frame_only_bpcs_test.removeElementAt(iz);
																  frame_only_bpcs_test.add(iz,"Y");
																  frame_bpcs_part_no_list.addElement(rs_frame_group.getString(1));
																  frame_bpcs_line_no_list.addElement(rs_frame_group.getString(5));
																  frame_bpcs_price_list.addElement(bpcs_price_init);
																  frame_bpcs_com_price_list.addElement(bpcs_comm_init);
																  frame_bpcs_qty_list.addElement(bpcs_quant_init);
																  pan_or_frame.addElement(p_or_f);
														    }
													 }
		//						}
								   }
										}
										rs_frame_group.close();

										for (int iit = 0; iit < frame_bpcs_part_no_list.size(); iit++) {
						    //		out.println("the final2::"+frame_bpcs_qty+"<br>");
										String frame_bpcs_part_no=frame_bpcs_part_no_list.elementAt(iit).toString();
										String frame_bpcs_line_no=frame_bpcs_line_no_list.elementAt(iit).toString();
										double frame_bpcs_price=new Double(frame_bpcs_price_list.elementAt(iit).toString()).doubleValue();
										String frame_bpcs_qty=frame_bpcs_qty_list.elementAt(iit).toString();
										lineOver=frame_bpcs_price;
										double frame_bpcs_com_price=new Double(frame_bpcs_com_price_list.elementAt(iit).toString()).doubleValue();
										double frame_com_perc=(frame_bpcs_com_price/frame_bpcs_price)*100;
										String frame_com_perc_string=for19.format(frame_com_perc);
										String frame_bpcs_com_price_string=for12.format(frame_bpcs_com_price);
										String frame_bpcs_price_string=for14.format(frame_bpcs_price);
										String frame_bpcs_price_string_up=for14.format(frame_bpcs_price/(new Double(frame_bpcs_qty).doubleValue()));
										//String comPerc=for19.format(100*(frame_bpcs_com_price/frame_bpcs_price));
											   String comPerc="";
											   if (prio.equals("E")){
													 comPerc=String.valueOf(for19.format(100*(frame_bpcs_com_price/frame_bpcs_price)));
											   }
											   else{
													 comPerc=String.valueOf(for19.format(100*(frame_bpcs_com_price/(frame_bpcs_price*(0.91)))));
											   }
											   r="";
											   for (int i = 0; i < comPerc.length(); i ++) {
													 if (comPerc.charAt(i) != '.' && comPerc.charAt(i) != ',') r += comPerc.charAt(i);
											   }
											   //out.println(comPerc+"a<BR>");
											   comPerc=r;
											   if(comPerc.length()<12){
											   String tv="";
											   for(int v=0;v<(12-comPerc.length());v++){
											   tv="0"+tv;
												 }
											   comPerc=tv+comPerc;
											   }
											   //out.println(comPerc+"x<BR>");
											   r="";
											   for (int i = 0; i < frame_bpcs_qty.length(); i ++) {
													 if (frame_bpcs_qty.charAt(i) != '.' && frame_bpcs_qty.charAt(i) != ',') r += frame_bpcs_qty.charAt(i);
											   }
											   frame_bpcs_qty=r;
											   if(frame_bpcs_qty.length()<11){
											   String tv="";
											   for(int v=0;v<(11-frame_bpcs_qty.length());v++){
											   tv="0"+tv;
												 }
											   frame_bpcs_qty=tv+frame_bpcs_qty;
											   }
											   r="";
											   for (int i = 0; i < frame_bpcs_part_no.length(); i ++) {
													 if (frame_bpcs_part_no.charAt(i) != '.' && frame_bpcs_part_no.charAt(i) != ',') r += frame_bpcs_part_no.charAt(i);
											   }
											   frame_bpcs_part_no=r;
											   if(frame_bpcs_part_no.length()<15){
											   String tv="";
											   for(int v=0;v<(15-frame_bpcs_part_no.length());v++){
											   tv=" "+tv;
												 }
											   frame_bpcs_part_no=frame_bpcs_part_no+tv;
											   }
											   r="";
											   for (int i = 0; i < frame_bpcs_price_string.length(); i ++) {
													 if (frame_bpcs_price_string.charAt(i) != '.' && frame_bpcs_price_string.charAt(i) != ',') r += frame_bpcs_price_string.charAt(i);
											   }
											   frame_bpcs_price_string=r;
											   if(frame_bpcs_price_string.length()<14){
											   String tv="";
											   for(int v=0;v<(14-frame_bpcs_price_string.length());v++){
											   tv="0"+tv;
												 }
											   frame_bpcs_price_string=tv+frame_bpcs_price_string;
											   }
											   r="";
											   for (int i = 0; i < frame_bpcs_price_string_up.length(); i ++) {
													 if (frame_bpcs_price_string_up.charAt(i) != '.' && frame_bpcs_price_string_up.charAt(i) != ',') r += frame_bpcs_price_string_up.charAt(i);
											   }
											   frame_bpcs_price_string_up=r;
											   if(frame_bpcs_price_string_up.length()<14){
											   String tv="";
											   for(int v=0;v<(14-frame_bpcs_price_string_up.length());v++){
											   tv="0"+tv;
											   }
											   frame_bpcs_price_string_up=tv+frame_bpcs_price_string_up;
											   }
											   r="";
											   for (int i = 0; i < frame_bpcs_com_price_string.length(); i ++) {
													 if (frame_bpcs_com_price_string.charAt(i) != '.' && frame_bpcs_com_price_string.charAt(i) != ',') r += frame_bpcs_com_price_string.charAt(i);
											   }
											   frame_bpcs_com_price_string=r;
											   if(frame_bpcs_com_price_string.length()<15){
											   String tv="";
											   for(int v=0;v<(15-frame_bpcs_com_price_string.length());v++){
											   tv="0"+tv;
												 }
											   frame_bpcs_com_price_string=tv+frame_bpcs_com_price_string;
											   }
		//						out.println("123"+frame_bpcs_com_price_string+"test "+"<br>");
											   r="";
											   for (int i = 0; i < frame_com_perc_string.length(); i ++) {
													 if (frame_com_perc_string.charAt(i) != '.' && frame_com_perc_string.charAt(i) != ',') r += frame_com_perc_string.charAt(i);
											   }
											   frame_com_perc_string=r;
											   //out.println("x"+frame_com_perc_string+"x"+frame_com_perc_string.length()+"<-- length<BR>");
											   if(frame_com_perc_string.length()<12){
											   String tv="";
											   for(int v=0;v<(12-frame_com_perc_string.length());v++){
											   tv="0"+tv;
												 }
											   frame_com_perc_string=tv+frame_com_perc_string;
											   }
											   //Overage calcs
											   //out.println(frame_bpcs_price+"*("+overage+"/"+config_price+")<BR>");
											   double over_price=lineOver*(Double.parseDouble(overage)/(config_price-nonCommission));
											   if(new Double(frame_bpcs_com_price_string).doubleValue()<=0){
													 over_price=0;
											   }
											   //double over_price=frame_bpcs_price*(Double.parseDouble(overage)/config_price);
											   //over price
											   String over_price_string=for12.format(over_price);
											   String overx=String.valueOf(over_price);
											   //over_price_string="0";
											   // as requested by ACosma
											   // bpcs will do line overage automatically based on job overage
											   // Sept 21/05
											   int neg = over_price_string.indexOf("-");
											   if(neg >= 0){
											   //out.println(over_price_string +" original<BR>");
											   over_price_string=over_price_string.substring(neg+1);
											   //out.println(over_price_string +" with out negative<BR>");
											   String lastDigit=over_price_string.substring(over_price_string.length() -1);
											   over_price_string=over_price_string.substring(0,over_price_string.length()-1)+charMap[Integer.parseInt(lastDigit)];
											   //out.println(over_price_string+" with char replaced<BR>");
											   }
											   r="";
											   for (int i = 0; i < over_price_string.length(); i ++) {
													 if (over_price_string.charAt(i) != '.' && over_price_string.charAt(i) != ',') r += over_price_string.charAt(i);
											   }
											   over_price_string=r;
											   if(over_price_string.length()<15){
											   String tv="";
											   for(int v=0;v<(15-over_price_string.length());v++){
											   tv="0"+tv;
												 }
											   over_price_string=tv+over_price_string;
											   }
											   //overage perc
											   double over_perc=(over_price*100)/Double.parseDouble(overage);
											   String over_perc_string=for19.format(over_perc);
											   r="";
											   for (int i = 0; i < over_perc_string.length(); i ++) {
													 if (over_perc_string.charAt(i) != '.' && over_perc_string.charAt(i) != ',') r += over_perc_string.charAt(i);
											   }
											   over_perc_string=r;
											   if(over_perc_string.length()<12){
											   String tv="";
											   for(int v=0;v<(12-over_perc_string.length());v++){
											   tv="0"+tv;
												 }
											   over_perc_string=tv+over_perc_string;
											   }
											   //Overage calcs done
											   // feight calcs
											   String fc_value="";
											   //if (prio.equals("E")){//deco
											   fc_value="0";
											   //}
											   //else{//cs
											   //fc_value=for12.format(frame_bpcs_price*0.09);
											   //}
											   r="";
											   for (int i = 0; i < fc_value.length(); i ++) {
													 if (fc_value.charAt(i) != '.' && fc_value.charAt(i) != ',') r += fc_value.charAt(i);
											   }
											   fc_value=r;
											   if(fc_value.length()<15){
											   String tv="";
											   for(int v=0;v<(15-fc_value.length());v++){
											   tv="0"+tv;
												 }
											   fc_value=tv+fc_value;
											   }
											   //out.println(comPerc+"a<BR>");
											   line_no_text=String.valueOf(diLineCounter);
											   //out.println(line_no_text+"::"+diLineCounter+"<BR>");
											   r="";
											   for (int iii = 0; iii < line_no_text.length(); iii ++) {
													 if (line_no_text.charAt(iii) != '.' && line_no_text.charAt(iii) != ',') r += line_no_text.charAt(iii);
											   }
											   line_no_text=r;
											   if(line_no_text.length()<3){
													 String tv="";
													 for(int v=0;v<(3-line_no_text.length());v++){
														    tv="0"+tv;
													   }
													 line_no_text=tv+line_no_text;
											   }
											   diLineCounter++;
											   //out.println(lineOver+" ehre<bR>");
										overageLine=overageLine+over_price;
										//stuff for BOMS/Routings
										shop_parts.addElement(frame_bpcs_part_no.trim());
										shop_qty.addElement(for13.format(new Double(frame_bpcs_qty_list.elementAt(iit).toString()).doubleValue()));
										shop_part_desc.addElement(pan_or_frame.elementAt(iit).toString());
										shop_line_no.addElement(frame_bpcs_line_no_list.elementAt(iit).toString());
										//stuff for BOMS/Routings done
										final_oi_out=final_oi_out+"IO"+order_no+frame_bpcs_part_no+frame_bpcs_qty+frame_bpcs_price_string_up+ware_house_line+bpcs_tier_line+"\r\n";
										final_ic_out=final_ic_out+"DI"+order_no+line_no_text+frame_bpcs_part_no+frame_bpcs_price_string_up+rep_no+"001"+comPerc+frame_bpcs_com_price_string+"100000000000"+over_price_string+fc_value+"\r\n";


										}//end of for loop
								  // Frames block	end
								  }// product is EFS


								  else if(product_id.equals("TPG")){
								  }// product is TPG
								  else if(product_id.equals("IWP")){
								  }// product is IWP
								  else if(product_id.equals("LVR")){
								  }// product is LVR

								  // Getting the setup_cost
								  if(Double.parseDouble(setup_cost)>0){
								  String setup_part="MINOR"+product_id;
								  String setup_bpcs_qty="1.000";
											   r="";
											   for (int i = 0; i < setup_bpcs_qty.length(); i ++) {
													 if (setup_bpcs_qty.charAt(i) != '.' && setup_bpcs_qty.charAt(i) != ',') r += setup_bpcs_qty.charAt(i);
											   }
											   setup_bpcs_qty=r;
											   if(setup_bpcs_qty.length()<11){
											   String tv="";
											   for(int v=0;v<(11-setup_bpcs_qty.length());v++){
											   tv="0"+tv;
												 }
											   setup_bpcs_qty=tv+setup_bpcs_qty;
											   }
											   if(setup_part.length()<15){
											   String tv="";
											   for(int v=0;v<(15-setup_part.length());v++){
											   tv=" "+tv;
												 }
											   setup_part=setup_part+tv;
											   }
											   r="";
											   setup_cost= String.valueOf(for14.format(new Double(setup_cost).doubleValue()));
											   for (int i = 0; i < setup_cost.length(); i ++) {
													 if (setup_cost.charAt(i) != '.' && setup_cost.charAt(i) != ',') r += setup_cost.charAt(i);
											   }
											   setup_cost=r;
											   if(setup_cost.length()<14){
											   String tv="";
											   for(int v=0;v<(14-setup_cost.length());v++){
											   tv="0"+tv;
												 }
											   setup_cost=tv+setup_cost;
											   }
											   //stuff for BOMS/Routings
											   shop_parts.addElement(setup_part);
											   shop_qty.addElement("1");
											   shop_part_desc.addElement("misc");
											   shop_line_no.addElement("0");
											   //stuff for BOMS/Routings done
										final_oi_out=final_oi_out+"IO"+order_no+setup_part+setup_bpcs_qty+setup_cost+ware_house_line+bpcs_tier_order+"\r\n";
								  }//setup cost


if(Double.parseDouble(handling_cost)>0){
								  String setup_part="MINOR"+product_id;
								  String setup_bpcs_qty="1.000";
											   r="";
											   for (int i = 0; i < setup_bpcs_qty.length(); i ++) {
													 if (setup_bpcs_qty.charAt(i) != '.' && setup_bpcs_qty.charAt(i) != ',') r += setup_bpcs_qty.charAt(i);
											   }
											   setup_bpcs_qty=r;
											   if(setup_bpcs_qty.length()<11){
											   String tv="";
											   for(int v=0;v<(11-setup_bpcs_qty.length());v++){
											   tv="0"+tv;
												 }
											   setup_bpcs_qty=tv+setup_bpcs_qty;
											   }
											   if(setup_part.length()<15){
											   String tv="";
											   for(int v=0;v<(15-setup_part.length());v++){
											   tv=" "+tv;
												 }
											   setup_part=setup_part+tv;
											   }
											   r="";
											   setup_cost= String.valueOf(for14.format(new Double(handling_cost).doubleValue()));
											   for (int i = 0; i < setup_cost.length(); i ++) {
													 if (setup_cost.charAt(i) != '.' && setup_cost.charAt(i) != ',') r += setup_cost.charAt(i);
											   }
											   setup_cost=r;
											   if(setup_cost.length()<14){
											   String tv="";
											   for(int v=0;v<(14-setup_cost.length());v++){
											   tv="0"+tv;
												 }
											   setup_cost=tv+setup_cost;
											   }
											   //stuff for BOMS/Routings
											   shop_parts.addElement(setup_part);
											   shop_qty.addElement("1");
											   shop_part_desc.addElement("misc");
											   shop_line_no.addElement("0");
											   //stuff for BOMS/Routings done
										final_oi_out=final_oi_out+"IO"+order_no+setup_part+setup_bpcs_qty+setup_cost+ware_house_line+bpcs_tier_order+"\r\n";
								  }
								  // Getting the freight_cost
								  //if(Double.parseDouble(freight_cost)>0||georder.trim().equals("GE")){
								  // as per Courtney April 2 2014
								  if(Double.parseDouble(freight_cost)>0){
										String freight_part="FREIGHT"+product_id;
										if(georder.trim().equals("GE")){
											   freight_part="GEFREIGHT";
											   /*
											   ResultSet rsFreightTax=stmt.executeQuery("select count(*) from cs_state_codes where state_code='"+ship_state+"' and country_code='US' and taxable_freight='1'");
											   if(rsFreightTax != null){
													 while(rsFreightTax.next()){
														    //out.println(rsFreightTax.getInt(1)+":: HERE<BR>");
														    if(rsFreightTax.getInt(1)>0){
																  freight_part=freight_part+"TAX";
														    }
														    else{
																  if(georder.trim().equals("GE")){
																		freight_part="";
																  }
														    }
													 }
											   }
											   rsFreightTax.close();
											   */
										}
										String freight_bpcs_qty="1.000";
											   r="";
											   for (int i = 0; i < freight_bpcs_qty.length(); i ++) {
													 if (freight_bpcs_qty.charAt(i) != '.' && freight_bpcs_qty.charAt(i) != ',') r += freight_bpcs_qty.charAt(i);
											   }
											   freight_bpcs_qty=r;
											   if(freight_bpcs_qty.length()<11){
											   String tv="";
											   for(int v=0;v<(11-freight_bpcs_qty.length());v++){
											   tv="0"+tv;
												 }
											   freight_bpcs_qty=tv+freight_bpcs_qty;
											   }
											   if(freight_part.length()<15){
											   String tv="";
											   for(int v=0;v<(15-freight_part.length());v++){
											   tv=" "+tv;
												 }
											   freight_part=freight_part+tv;
											   }
											   r="";
											   freight_cost= String.valueOf(for14.format(new Double(freight_cost).doubleValue()));
											   for (int i = 0; i < freight_cost.length(); i ++) {
													 if (freight_cost.charAt(i) != '.' && freight_cost.charAt(i) != ',') r += freight_cost.charAt(i);
											   }
											   freight_cost=r;
											   if(freight_cost.length()<14){
											   String tv="";
											   for(int v=0;v<(14-freight_cost.length());v++){
											   tv="0"+tv;
												 }
											   freight_cost=tv+freight_cost;
											   }
											   //stuff for BOMS/Routings
											   shop_parts.addElement(freight_part);
											   shop_qty.addElement("1");
											   shop_part_desc.addElement("misc");
											   shop_line_no.addElement("0");
											   //stuff for BOMS/Routings done
											   if(!(georder.trim().equals("GE")&&freight_part.trim().length()<=0)){
													 final_oi_out=final_oi_out+"IO"+order_no+freight_part+freight_bpcs_qty+freight_cost+ware_house_line+bpcs_tier_order+"\r\n";
											   }
								  }//freight cost


		//on out


          //drafting email

         if(drafting_email != null && drafting_email.length()>0){
                        String acknowledgenote="Drafting Email address: "+drafting_email;
                        //out.println(acknowledgenote+"::<BR>");
                        if(acknowledgenote.length()>50){
                                while(acknowledgenote.length()>50){
                                        String isti=String.valueOf(notesCounter);
                                        r="";
                                        for (int j = 0; j < isti.length(); j ++) {
                                                if (isti.charAt(j) != '.' && isti.charAt(j) != ',') r += isti.charAt(j);
                                        }
                                        isti=r;
                                        if(isti.length()<4){
                                                String tv2="";
                                                for(int v=0;v<(4-isti.length());v++){
                                                        tv2="0"+tv2;
                                                }
                                                isti=tv2+isti;
                                        }
                                        String acknowledgenoteo=acknowledgenote.substring(0,50);
                                        acknowledgenote=acknowledgenote.substring(50);
                                        final_on_out=final_on_out+"NO"+order_no+"000"+isti+acknowledgenoteo+"\r\n";
                                        notesCounter++;
                                }
                        }

                if(acknowledgenote.length()<=50 && acknowledgenote.length() >0){
                                String isti=String.valueOf(notesCounter);
                                r="";
                                for (int j = 0; j < isti.length(); j ++) {
                                        if (isti.charAt(j) != '.' && isti.charAt(j) != ',') r += isti.charAt(j);
                                }
                                isti=r;
                                if(isti.length()<4){
                                        String tv2="";
                                        for(int v=0;v<(4-isti.length());v++){
                                                tv2="0"+tv2;
                                        }
                                        isti=tv2+isti;
                                }
                                String tv1="";
                                for(int v=0;v<(50-acknowledgenote.length());v++){
                                        tv1=" "+tv1;
                                }
                                acknowledgenote=acknowledgenote+tv1;
                                final_on_out=final_on_out+"NO"+order_no+"000"+isti+acknowledgenote+"\r\n";
                                notesCounter++;
                        }
         }

          //end drafting email
		    //  order notes
				   //SUBMITTALS
		//			  submit_by="1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123";
			   if(submit_by != null && submit_by.trim().length()>0 && !(submit_by.equals("NOT REQUIRED")) ){
							 submit_by="Submittals by "+submit_by;
							 int lp=submit_by.length()/50;
							  if(lp>0){
								    for(int i=0;i<lp;i++){
									String isti=String.valueOf(notesCounter);
											   r="";
											   for (int j = 0; j < isti.length(); j ++) {
													 if (isti.charAt(j) != '.' && isti.charAt(j) != ',') r += isti.charAt(j);
											   }
											   isti=r;
									  if(isti.length()<4){
											   String tv="";
											   for(int v=0;v<(4-isti.length());v++){
											   tv="0"+tv;
												 }
											   isti=tv+isti;
										 }
										//out.println("no1<BR>");
										final_on_out=final_on_out+"NO"+order_no+"000"+isti+submit_by.substring(i*50,((i+1)*50))+"\r\n";
										notesCounter++;
								    }
								    if(submit_by.length()>(lp*50)){
										String submit_rem=submit_by.substring(lp*50,submit_by.length());
											   String tv="";
											   for(int v=0;v<(50-submit_rem.length());v++){
											   tv=" "+tv;
												 }
											   submit_rem=submit_rem+tv;
											   // for getting the order seq no

									String isti=String.valueOf(notesCounter);
											   r="";
											   for (int j = 0; j < isti.length(); j ++) {
													 if (isti.charAt(j) != '.' && isti.charAt(j) != ',') r += isti.charAt(j);
											   }
											   isti=r;
									  if(isti.length()<4){
											   String tv6="";
											   for(int v=0;v<(4-isti.length());v++){
											   tv6="0"+tv6;
												 }
											   isti=tv6+isti;
										 }
											   //out.println("no2<BR>");
											   final_on_out=final_on_out+"NO"+order_no+"000"+isti+submit_rem+"\r\n";
											   notesCounter++;
								    }
							  }
							  else{
									String isti=String.valueOf(notesCounter);
											   r="";
											   for (int j = 0; j < isti.length(); j ++) {
													 if (isti.charAt(j) != '.' && isti.charAt(j) != ',') r += isti.charAt(j);
											   }
											   isti=r;
									  if(isti.length()<4){
											   String tv5="";
											   for(int v=0;v<(4-isti.length());v++){
											   tv5="0"+tv5;
												 }
											   isti=tv5+isti;
										 }
											   r="";
											   for (int i = 0; i < submit_by.length(); i ++) {
													 if (submit_by.charAt(i) != '.' && submit_by.charAt(i) != ',') r += submit_by.charAt(i);
											   }
											   submit_by=r;
											   if(submit_by.length()<50){
											   String tv="";
											   for(int v=0;v<(50-submit_by.length());v++){
											   tv=" "+tv;
												 }
											   submit_by=submit_by+tv;
											   }
								  //out.println("no3<BR>");
									final_on_out=final_on_out+"NO"+order_no+"000"+isti+submit_by+"\r\n";
										notesCounter++;
							  }
			   }  //submittals by done
								  //copies requested started
		    if(copies_requested != null && copies_requested.trim().length()>0 && !(copies_requested.equals("0")) ){
									String isti=String.valueOf(notesCounter);
											   r="";
											   for (int j = 0; j < isti.length(); j ++) {
													 if (isti.charAt(j) != '.' && isti.charAt(j) != ',') r += isti.charAt(j);
											   }
											   isti=r;
									  if(isti.length()<4){
											   String tv2="";
											   for(int v=0;v<(4-isti.length());v++){
											   tv2="0"+tv2;
												 }
											   isti=tv2+isti;
										 }
					 String cust_oo="Copies Requested: "+copies_requested;
							    if(cust_oo.length()<50){
										String tv1="";
										for(int v=0;v<(50-cust_oo.length());v++){
										tv1=" "+tv1;
										   }
										cust_oo=cust_oo+tv1;
								   }// order seq no
						    //out.println("no6<BR>");
							  final_on_out=final_on_out+"NO"+order_no+"000"+isti+cust_oo+"\r\n";
						    notesCounter++;



				    //out.println("Test"+bpcs_cust_no);
			    }//copies requested done
//out.println("6");
			   // Additional documents
			   // Tokenizer for getting the add doc's
			   Vector docs_final=new Vector();String doc_type="";
						    StringTokenizer stdoc=new StringTokenizer(add_docs,";");
						    while (stdoc.hasMoreTokens()){docs_final.addElement(stdoc.nextToken());}
							for (int doc=0;doc<docs_final.size();doc++){
								  doc_type=docs_final.elementAt(doc).toString();
								    if(doc_type.equals("PO")){doc_type="Purchase Order";}
								    else if (doc_type.equals("SO")){doc_type="Signed Quote";}
										else if (doc_type.equals("LI")){doc_type="Letter of Intent";}
										else if (doc_type.equals("DR")){doc_type="Drawings";}
										else if (doc_type.equals("TD")){doc_type="Taxed Document";}
										else if (doc_type.equals("CC")){doc_type="Credit Card Form";}
										else if (doc_type.equals("SA")){doc_type="Sample";}
										else if (doc_type.equals("CS")){doc_type="Cut to Size Document";}
										else if (doc_type.equals("TE")){doc_type="Templates";}
											   if(doc_type.length()<50){
											   String tv="";
											   for(int v=0;v<(50-doc_type.length());v++){
											   tv=" "+tv;
												 }
											   doc_type=doc_type+tv;
											   }
										// for getting the order seq no

									String isti=String.valueOf(notesCounter);
											   r="";
											   for (int j = 0; j < isti.length(); j ++) {
													 if (isti.charAt(j) != '.' && isti.charAt(j) != ',') r += isti.charAt(j);
											   }
											   isti=r;
									  if(isti.length()<4){
											   String tv4="";
											   for(int v=0;v<(4-isti.length());v++){
											   tv4="0"+tv4;
												 }
											   isti=tv4+isti;
										 }
								  //out.println("no4<BR>");
							  final_on_out=final_on_out+"NO"+order_no+"000"+isti+doc_type+"\r\n";
								  notesCounter++;
							}
						    // Invoice info
							if (invoice_info.equals("N")){
							 invoice_info="Invoice customer different than Billing";
							    if(invoice_info.length()<50){
										String tv1="";
										for(int v=0;v<(50-invoice_info.length());v++){
										tv1=" "+tv1;
										   }
										invoice_info=tv1+invoice_info;
								   }// order seq no

									String isti=String.valueOf(notesCounter);
											   r="";
											   for (int j = 0; j < isti.length(); j ++) {
													 if (isti.charAt(j) != '.' && isti.charAt(j) != ',') r += isti.charAt(j);
											   }
											   isti=r;
									  if(isti.length()<4){
											   String tv3="";
											   for(int v=0;v<(4-isti.length());v++){
											   tv3="0"+tv3;
												 }
											   isti=tv3+isti;
										 }
										// out.println("no5<BR>");
							  final_on_out=final_on_out+"NO"+order_no+"000"+isti+invoice_info+"\r\n";
								  notesCounter++;
							}
		// new customer 000
						    //commmented on Oct 15'08 as per Jim and Renee
											   /*
			if(bpcs_cust_no.equals("000000")){
									String isti=String.valueOf(notesCounter);
											   r="";
											   for (int j = 0; j < isti.length(); j ++) {
													 if (isti.charAt(j) != '.' && isti.charAt(j) != ',') r += isti.charAt(j);
											   }
											   isti=r;
									  if(isti.length()<4){
											   String tv2="";
											   for(int v=0;v<(4-isti.length());v++){
											   tv2="0"+tv2;
												 }
											   isti=tv2+isti;
										 }
					 String cust_oo="New Customer Not existing in BPCS";
							    if(cust_oo.length()<50){
										String tv1="";
										for(int v=0;v<(50-cust_oo.length());v++){
										tv1=" "+tv1;
										   }
										cust_oo=cust_oo+tv1;
								   }// order seq no
						    //out.println("no6<BR>");
							  final_on_out=final_on_out+"NO"+order_no+"000"+isti+cust_oo+"\r\n";
						    notesCounter++;
				   // out.println("Test"+bpcs_cust_no);
			    }
		*/
											   //commmented on Oct 15'08 as per Jim and Renee

		// for shipping notice info added on Sep'10'2008
//out.println("7");
								  if(ship_prior_notice != null && ship_prior_notice.trim().length()>0){

										String cust_oo="Call "+ship_prior_notice_name+" @ "+ship_prior_notice_phone+", "+ship_prior_notice+" hrs prior to delivery.";
												   if(cust_oo.length()>50){
															while(cust_oo.length()>50){
														    String isti=String.valueOf(notesCounter);
																  r="";
																  for (int j = 0; j < isti.length(); j ++) {
																		if (isti.charAt(j) != '.' && isti.charAt(j) != ',') r += isti.charAt(j);
																  }
																  isti=r;
														    if(isti.length()<4){
																		String tv2="";
																		for(int v=0;v<(4-isti.length());v++){
																			   tv2="0"+tv2;
																	}
																  isti=tv2+isti;
																  }
																  String cust_ooo=cust_oo.substring(0,50);
																  cust_oo=cust_oo.substring(50);
																  final_on_out=final_on_out+"NO"+order_no+"000"+isti+cust_ooo+"\r\n";
																  notesCounter++;
														    }
													  }

												   if(cust_oo.length()<=50 && cust_oo.length() >0){
															String isti=String.valueOf(notesCounter);
														    r="";
														    for (int j = 0; j < isti.length(); j ++) {
																  if (isti.charAt(j) != '.' && isti.charAt(j) != ',') r += isti.charAt(j);
														    }
														    isti=r;
														    if(isti.length()<4){
																  String tv2="";
																  for(int v=0;v<(4-isti.length());v++){
																		tv2="0"+tv2;
															  }
														    isti=tv2+isti;
														    }
													 String tv1="";
													 for(int v=0;v<(50-cust_oo.length());v++){
													 tv1=" "+tv1;
													    }
													 cust_oo=cust_oo+tv1;
													 final_on_out=final_on_out+"NO"+order_no+"000"+isti+cust_oo+"\r\n";
													 notesCounter++;
											    }
												   // order seq no
											   //out.println("no6<BR>");

									  //out.println("Test"+);
								   }

		///for shipping notice info ended

//out.println("8");
		    if(special_notes != null && special_notes.trim().length()>0 ){
					 String cust_oo="Special notes: "+special_notes;
					 //checking for carriage returns
					 r="";
					 for (int j = 0; j < cust_oo.length(); j ++) {
						    if (cust_oo.charAt(j) != '\r' && cust_oo.charAt(j) != '\n') {
						    r += cust_oo.charAt(j);
						    }
					 }
					 cust_oo=r;
								  if(cust_oo.length()>50){
										while(cust_oo.length()>50){
											    String isti=String.valueOf(notesCounter);
											   r="";
											   for (int j = 0; j < isti.length(); j ++) {
													 if (isti.charAt(j) != '.' && isti.charAt(j) != ',') r += isti.charAt(j);
											   }
											   isti=r;
											   if(isti.length()<4){
													 String tv2="";
													 for(int v=0;v<(4-isti.length());v++){
														    tv2="0"+tv2;
												 }
											   isti=tv2+isti;
											   }

											   String cust_ooo=cust_oo.substring(0,50);
											   cust_oo=cust_oo.substring(50);
											   final_on_out=final_on_out+"NO"+order_no+"000"+isti+cust_ooo+"\r\n";
											   notesCounter++;
										}
								  }
							    if(cust_oo.length()<=50 && cust_oo.length() >0){
											    String isti=String.valueOf(notesCounter);
											   r="";
											   for (int j = 0; j < isti.length(); j ++) {
													 if (isti.charAt(j) != '.' && isti.charAt(j) != ',') r += isti.charAt(j);
											   }
											   isti=r;
											   if(isti.length()<4){
													 String tv2="";
													 for(int v=0;v<(4-isti.length());v++){
														    tv2="0"+tv2;
												 }
											   isti=tv2+isti;
											   }
										String tv1="";
										for(int v=0;v<(50-cust_oo.length());v++){
										tv1=" "+tv1;
										   }
										cust_oo=cust_oo+tv1;
										final_on_out=final_on_out+"NO"+order_no+"000"+isti+cust_oo+"\r\n";
										notesCounter++;
								   }// order seq no

						    //out.println("no6<BR>");




				    //out.println("Test"+bpcs_cust_no);
			    }
//out.println("9");

		    if(order_notes != null && order_notes.trim().length()>0 ){
					 String cust_oo="Order notes: "+order_notes;
					 //checking for carrige returns and new lines characters
						    r="";
		//		out.println(":"+cust_oo.length());
								  for (int j = 0; j < cust_oo.length(); j ++) {
										if (cust_oo.charAt(j) != '\r' && cust_oo.charAt(j) != '\n') {
										r += cust_oo.charAt(j);
										}
								  }
								  cust_oo=r;
					 //checking done
								  if(cust_oo.length()>50){
										while(cust_oo.length()>50){
											    String isti=String.valueOf(notesCounter);
											   r="";
											   for (int j = 0; j < isti.length(); j ++) {
													 if (isti.charAt(j) != '.' && isti.charAt(j) != ',') r += isti.charAt(j);
											   }
											   isti=r;
											   if(isti.length()<4){
													 String tv2="";
													 for(int v=0;v<(4-isti.length());v++){
														    tv2="0"+tv2;
												 }
											   isti=tv2+isti;
											   }
											   String cust_ooo=cust_oo.substring(0,50);
											   cust_oo=cust_oo.substring(50);
											   final_on_out=final_on_out+"NO"+order_no+"000"+isti+cust_ooo+"N\r\n";
											   notesCounter++;
										}
								  }
							    if(cust_oo.length()<=50 && cust_oo.length() >0){
											    String isti=String.valueOf(notesCounter);
											   r="";
											   for (int j = 0; j < isti.length(); j ++) {
													 if (isti.charAt(j) != '.' && isti.charAt(j) != ',') r += isti.charAt(j);
											   }
											   isti=r;
											   if(isti.length()<4){
													 String tv2="";
													 for(int v=0;v<(4-isti.length());v++){
														    tv2="0"+tv2;
												 }
											   isti=tv2+isti;
											   }
										String tv1="";
										for(int v=0;v<(50-cust_oo.length());v++){
										tv1=" "+tv1;
										   }
										cust_oo=cust_oo+tv1;
										final_on_out=final_on_out+"NO"+order_no+"000"+isti+cust_oo+"N\r\n";
										notesCounter++;
								   }// order seq no
			    }

if(bpcs_order_no==null || bpcs_order_no.equals("null")){
	bpcs_order_no="";
}
//out.println("c"+quote_origin+"::"+bpcs_order_no);

		    if((quote_origin.equals("sample")&&base_quote_no.trim().length()==0&&bpcs_order_no.trim().equals(""))||(bpcs_order_no.trim().equals("")||bpcs_order_no==null)&&((quote_origin==null)||!(quote_origin.startsWith("change")|quote_origin.startsWith("release")|quote_origin.startsWith("revision")|quote_origin.startsWith("submittal")))){
			   //out.println(final_on_out+"::NOTES<BR>");
		    }
		    else{
			   final_on_out="";
			   notesCounter=0;
		    }



//out.println("8");




//out.println("11"+win_loss+"::"+special_cut);



		    if(!(win_loss.equals("DR")|win_loss.equals("HA")|(special_cut.equals("Y")& win_loss.equals("RF")))){
			    int lineCounter=0;
		//out.println(win_loss+"<br>");
						    // architect is not BPCS
						    // Sections Y or N
						    // Line notes

						    String dimension="";String cuts_notches="";String logo="";String template_art="";String texture_color="";
						    String d_notes="";int lc_count=1;String qty_line="";String line_no_note="";int lp1=0;String isti="";String marks="";
						    //separting product lines to extract notes
						    Vector product_final_line_no=new Vector();Vector product_bpcs_line_no=new Vector();
//out.println("12");
						    for (int zt = 0; zt < shop_parts.size(); zt ++) {
								  if(shop_part_desc.elementAt(zt).toString().equals("product")){
										for(int ip=0;ip<block_id.size();ip++){//from csquotes
										//converting csquotes string to 10 character string like BPCS and then compare it
											   r="";
											   String bpcs_cs_quotes_product_qty=for13.format(new Double(bpcs_qty.elementAt(ip).toString()).doubleValue());
		/*
											   for (int i = 0; i < bpcs_cs_quotes_product_qty.length(); i ++) {
													 if (bpcs_cs_quotes_product_qty.charAt(i) != '.' && bpcs_cs_quotes_product_qty.charAt(i) != ',') r += bpcs_cs_quotes_product_qty.charAt(i);
											   }
											   bpcs_cs_quotes_product_qty=r;
											   if(bpcs_cs_quotes_product_qty.length()<11){
											   String tv="";
											   for(int v=0;v<(11-bpcs_cs_quotes_product_qty.length());v++){
											   tv="0"+tv;
												 }
											   bpcs_cs_quotes_product_qty=tv+bpcs_cs_quotes_product_qty;
											   }
		*/
					 //				out.println("Final"+bpcs_cs_quotes_product_qty);
										//converting done
		//						if(bpcs_part_no.elementAt(ip).toString().equals(shop_parts.elementAt(zt).toString())& bpcs_cs_quotes_product_qty.equals(shop_qty.elementAt(zt).toString())&line_item.elementAt(ip).toString().equals(shop_line_no.elementAt(zt).toString())){
										if(bpcs_part_no.elementAt(ip).toString().equals(shop_parts.elementAt(zt).toString())&line_item.elementAt(ip).toString().equals(shop_line_no.elementAt(zt).toString())){
													   product_final_line_no.addElement(line_item.elementAt(ip));
													   product_bpcs_line_no.addElement(String.valueOf(zt+1));
					 //				  out.println("<br>VTest:"+line_item.elementAt(ip)+"::"+(zt+1)+":bpcs_part_no"+bpcs_part_no.elementAt(ip).toString()+":shop part:"+shop_parts.elementAt(zt).toString()+":shop qty:"+shop_qty.elementAt(zt).toString()+":bpcs qty:"+bpcs_cs_quotes_product_qty+"<br>");
												}
										}
								  }
						    }
						    //separting product lines to extract notes done.
					 //
//out.println("13");
								  for(int ii=0;ii<product_final_line_no.size();ii++){//line_items from eorderitems
													 line_no_note=product_bpcs_line_no.elementAt(ii).toString().trim();
													 if(line_no_note.length()<3){
													 String tv="";
													 for(int v=0;v<(3-line_no_note.length());v++){
													 tv="0"+tv;
													    }
													 line_no_note=tv+line_no_note;
													 }
//out.println("14");
					    for(int i=0;i<block_id.size();i++){//from csquotes
										  if(line_item.elementAt(i).toString().equals(product_final_line_no.elementAt(ii).toString())){
											   if( block_id.elementAt(i).toString().equals("E_DIM2")){
													 String dim=desc.elementAt(i).toString().trim();
													 qty_line=QTY.elementAt(i).toString().trim();
													 marks=mark.elementAt(i).toString().trim();
						    /*			   	int n_s=dim.indexOf("@");
													 int n_s1=dim.indexOf("@",n_s+1);
													 int n_s2=dim.indexOf("@",n_s1+1);
													 int n_s3=dim.indexOf("@",n_s2+1);
													 dimension=dim.substring(0,n_s);
													 cuts_notches=dim.substring(n_s+1,n_s1);
													 logo=dim.substring(n_s1+1,n_s2);
													 template_art=dim.substring(n_s2+1,n_s3);
													 texture_color=dim.substring(n_s3+1,dim.length());
													 if (dimension.equals("")){dimension="-";}
													 if (cuts_notches.equals("")){cuts_notches="-NONE-";}
													 if (logo.equals("")){logo="-NONE-";}
													 if (template_art.equals("")){template_art="-NONE-";}
													 if (texture_color.equals("")){texture_color="-STD-";}
													 dimension=qty_line+" at "+dimension;*/
													 dimension=desc.elementAt(i).toString();
													  lp1=dimension.length()/50;//di
												 if(lp1>0){
													   for(int ik=0;ik<lp1;ik++){
														    isti=String.valueOf(lc_count);
														    String tv1="";
														    for(int v=0;v<(4-isti.length());v++){tv1="0"+tv1; }
														    isti=tv1+isti;
														    final_on_out=final_on_out+"NO"+order_no+line_no_note+isti+dimension.substring(ik*50,((ik+1)*50))+"\r\n";
														    lc_count++;
													 //	out.println("Testa");
													   }
													   if(dimension.length()>(lp1*50)){
															   isti=String.valueOf(lc_count);
															   String tv1="";
															   for(int v=0;v<(4-isti.length());v++){tv1="0"+tv1; }
																  isti=tv1+isti;
														    String dimension_rem=dimension.substring(lp1*50,dimension.length());
																  String tv="";
																  for(int v=0;v<(50-dimension_rem.length());v++){tv=" "+tv; }
																  dimension_rem=dimension_rem+tv;
														    //	out.println("no2<BR>");
																  final_on_out=final_on_out+"NO"+order_no+line_no_note+isti+dimension_rem+"\r\n";
																  lc_count++;
														    //out.println("Testb");
													   }
												 }else{
															   isti=String.valueOf(lc_count);
															   String tv1="";
															   for(int v=0;v<(4-isti.length());v++){tv1="0"+tv1; }
																  isti=tv1+isti;
																  if(dimension.length()<50){
																  String tv="";
																  for(int v=0;v<(50-dimension.length());v++){
																  tv=" "+tv;
																	}
																  dimension=dimension+tv;
																  }
													    final_on_out=final_on_out+"NO"+order_no+line_no_note+isti+dimension+"\r\n";
														    lc_count++;
														    //out.println(line_no_note+"Testc<br>");
												 }//dimension
											   //mark no
											   if(marks.trim().length()>0){
												   //  lc_count=1;
														isti=String.valueOf(lc_count);
														String tv1="";
														for(int v=0;v<(4-isti.length());v++){tv1="0"+tv1; }
														    isti=tv1+isti;
														    if(marks.length()<50){
														    String tv="";
														    for(int v=0;v<(50-marks.length());v++){
														    tv=" "+tv;
															  }
														    marks=marks+tv;
														    }
														    //out.println(line_no_note+"teste<BR>");
												 final_on_out=final_on_out+"NO"+order_no+line_no_note+isti+marks+"\r\n";
													 lc_count++;
											   }
											   //amrk no
											   //
													 //line_no_note
											   }//e_dim
											   if( block_id.elementAt(i).toString().startsWith("D_NOTES")){
											   d_notes=desc.elementAt(i).toString().trim();
											   //lc_count=1;
											   //notes
											    lp1=d_notes.length()/50;//di
												 if(lp1>0){
													   for(int ik=0;ik<lp1;ik++){
													    isti=String.valueOf(lc_count);
													    String tv1="";
														    for(int v=0;v<(4-isti.length());v++){tv1="0"+tv1; }
														    isti=tv1+isti;
														    final_on_out=final_on_out+"NO"+order_no+line_no_note+isti+d_notes.substring(ik*50,((ik+1)*50))+"\r\n";
														    lc_count++;
														    //out.println("Testa");
													   }
													   if(d_notes.length()>(lp1*50)){
															   isti=String.valueOf(lc_count);
															   String tv1="";
															   for(int v=0;v<(4-isti.length());v++){tv1="0"+tv1; }
																  isti=tv1+isti;
														    String d_notes_rem=d_notes.substring(lp1*50,d_notes.length());
																  String tv="";
																  for(int v=0;v<(50-d_notes_rem.length());v++){tv=" "+tv; }
																  d_notes_rem=d_notes_rem+tv;
																  //out.println("no2<BR>");
																  final_on_out=final_on_out+"NO"+order_no+line_no_note+isti+d_notes_rem+"\r\n";
																  lc_count++;
														    //out.println("Testb");
													   }
												 }
												 else{
													 // out.println(lc_count);
															   isti=String.valueOf(lc_count);
															   String tv1="";
															   for(int v=0;v<(4-isti.length());v++){tv1="0"+tv1; }
																  isti=tv1+isti;
																  if(d_notes.length()<50){
																  String tv="";
																  for(int v=0;v<(50-d_notes.length());v++){
																  tv=" "+tv;
																	}
																  d_notes=d_notes+tv;
																  }
													    final_on_out=final_on_out+"NO"+order_no+line_no_note+isti+d_notes+"\r\n";
														    lc_count++;
														    //out.println("Testc");
												 }	//notes

		// 						   final_on_out=final_on_out+"NO"+order_no+"000"+isti+cust_oo+"\r\n";
											   }//d_notes

										  }//if checking the if they are same line items.
										  isti="";

									}//for csquotes
//out.println("15");
																			   // out.println(lc_count);
																						isti=String.valueOf(lc_count);
																						String tv1="";
																						for(int v=0;v<(4-isti.length());v++){tv1="0"+tv1; }
																  isti=tv1+isti;
		//final_on_out=final_on_out+"NO"+order_no+line_no_note+isti+"PENDING APPROVAL\r\n";
		lineCounter=Integer.parseInt(line_no_note)+1;
									 lc_count=1;
									dimension="";cuts_notches="";logo="";template_art="";texture_color="";d_notes="";line_no_note="";
								  }//for eorder items
//out.println("9");
		//order notes for the pan and frame lines
		String frame_pan_notes="";line_no_note="";isti="";lc_count=1;
					 for (int itt = 0; itt < shop_parts.size(); itt ++) {
						    if(shop_part_desc.elementAt(itt).toString().equals("pan")){
								  for(int ip=0;ip<block_id.size();ip++){//from csquotes
										  if(line_item.elementAt(ip).toString().equals(shop_line_no.elementAt(itt).toString())){
												isti=String.valueOf(lc_count);
											   if( block_id.elementAt(ip).toString().equals("E_DIM2")|block_id.elementAt(ip).toString().equals("D_NOTES")){
													 line_no_note=String.valueOf(itt+1);
													 if(line_no_note.length()<3){
														    String tv="";
														    for(int v=0;v<(3-line_no_note.length());v++){
														    tv="0"+tv;
															  }
														    line_no_note=tv+line_no_note;
													 }//line_no_note ends
													 isti=String.valueOf(lc_count);
													 String tv1="";
													 for(int v=0;v<(4-isti.length());v++){tv1="0"+tv1; }
													 isti=tv1+isti;
													 //isti value for line notes
													 frame_pan_notes=desc.elementAt(ip).toString().trim();
													 //cleaning if any special characters
													 for (int j = 0; j < frame_pan_notes.length(); j ++) {
														    if (frame_pan_notes.charAt(j) != '\r' && frame_pan_notes.charAt(j) != '\n') {
														    r += frame_pan_notes.charAt(j);
														    }
													 }	//cleaning done
													 //for  greater than 50 characters
													 if(frame_pan_notes.length()>50){
														    while(frame_pan_notes.length()>50){
																  if(isti.length()<4){
																		String tv2="";
																		for(int v=0;v<(4-isti.length());v++){
																			   tv2="0"+tv2;
																	}
																  isti=tv2+isti;
																  }

																  String frame_pan_noteso=frame_pan_notes.substring(0,50);
																  frame_pan_notes=frame_pan_notes.substring(50);
																  final_on_out=final_on_out+"NO"+order_no+line_no_note+isti+frame_pan_noteso+"\r\n";
																  lc_count++;
														    }
													 }
													 //for less than 50 chars
													 if(frame_pan_notes.length()<=50){
														    String tv="";
														    for(int v=0;v<(50-frame_pan_notes.length());v++){
														    tv=" "+tv;
															  }
														    frame_pan_notes=frame_pan_notes+tv;
														    final_on_out=final_on_out+"NO"+order_no+line_no_note+isti+frame_pan_notes+"\r\n";
														    lc_count++;
													 }
													 //fram_pan_notes end

											   }
										  }	//outer if
								  }//for loop
						    }//PAN NOTES DONE
						    if(shop_part_desc.elementAt(itt).toString().equals("frame")){
								  for(int ip=0;ip<block_id.size();ip++){//from csquotes
										if(block_id.elementAt(ip).toString().equals("B_FRAMES")&&bpcs_part_no.elementAt(ip).toString().equals(shop_parts.elementAt(itt).toString())){
										//	out.println("Iam in 1+<br>");
											   for(int ip2=0;ip2<block_id.size();ip2++){//going again to get the line_nos
													 if(line_item.elementAt(ip).toString().equals(line_item.elementAt(ip2).toString())){
															 isti=String.valueOf(lc_count);
																  if( block_id.elementAt(ip2).toString().equals("E_DIM2")|block_id.elementAt(ip2).toString().equals("D_NOTES")){
																  //	out.println("Iam in 2+<br>");
																		line_no_note=String.valueOf(itt+1);
																		if(line_no_note.length()<3){
																			   String tv="";
																			   for(int v=0;v<(3-line_no_note.length());v++){
																			   tv="0"+tv;
																				 }
																			   line_no_note=tv+line_no_note;
																		}//line_no_note ends
																		isti=String.valueOf(lc_count);
																		String tv1="";
																		for(int v=0;v<(4-isti.length());v++){tv1="0"+tv1; }
																		isti=tv1+isti;
																		//isti value for line notes
																		frame_pan_notes=desc.elementAt(ip2).toString().trim();
																  //cleaning if any special characters
																		for (int j = 0; j < frame_pan_notes.length(); j ++) {
																			   if (frame_pan_notes.charAt(j) != '\r' | frame_pan_notes.charAt(j) != '\n') {
																			   r += frame_pan_notes.charAt(j);
																			   }
																		}	//cleaning done
																  //for  greater than 50 characters
																		if(frame_pan_notes.length()>50){
																			   while(frame_pan_notes.length()>50){
																					 if(isti.length()<4){
																						    String tv2="";
																						    for(int v=0;v<(4-isti.length());v++){
																								  tv2="0"+tv2;
																					    }
																					 isti=tv2+isti;
																					 }
																					 String frame_pan_noteso=frame_pan_notes.substring(0,50);
																					 frame_pan_notes=frame_pan_notes.substring(50);
																					 final_on_out=final_on_out+"NO"+order_no+line_no_note+isti+frame_pan_noteso+"\r\n";
																					 lc_count++;
																			   }
																		}
																		//for less than 50 chars
																		if(frame_pan_notes.length()<50){
																			   String tv="";
																			   for(int v=0;v<(50-frame_pan_notes.length());v++){
																			   tv=" "+tv;
																				 }
																			   frame_pan_notes=frame_pan_notes+tv;
																		}//fram_pan_notes end
																		final_on_out=final_on_out+"NO"+order_no+line_no_note+isti+frame_pan_notes+"\r\n";
																		lc_count++;
																  }
													 }
											   }//2nd for loop
										}//outer if
								  }//for loop
						    }//FRAME NOTES DONE
						    lc_count=1;
					 }
		//
		//out.println("Out of frame/pan blocks");
		    }//only for RF not for HA and DR
		//out.println(diLineCounter+"di line counter"+lineCounter+"<BR>");
						    // Line Item NOtes done
		//oc out
//out.println("16");
		//out.println("Out of all notes");
		double totprice=0;double factor=0;double totprice_dis=0;double totcomm_dol=0;String com_perc="";String tot_com_dol_str="";
		String fc_value="";String fc_perc="";
								  for(int ii=0;ii<items.size();ii++){
					    for(int i=0;i<block_id.size();i++){
//out.println("a");
										  if(line_item.elementAt(i).toString().equals(items.elementAt(ii).toString())){
													 String totwt=price.elementAt(i).toString();//Extended_Price
													 String fact=fact_per.elementAt(i).toString().trim();//FIELD16
													   if ((fact.equals(""))){fact="0.0"; }
//out.println("b"+totwt+"::"+fact);
													   BigDecimal d1 = new BigDecimal(totwt);
												    BigDecimal d2 = new BigDecimal(fact);
													   BigDecimal d3 = d1.multiply(d2);
//out.println("c");
												    factor = factor+d3.doubleValue();// Line comission dollars for the line
													   totprice=totprice+d1.doubleValue();//Line materail price no comission for the line
													   totprice_dis=totprice_dis+d1.doubleValue();//Total material price for the job
													   totcomm_dol= totcomm_dol+d3.doubleValue();// Total commission dollars for the job
//out.println("d");
}
									}
								    factor=0;totprice=0;
								  }
//out.println("17");

			   // Global commission %
			   fc_value="0";String t="";double t1=0.0; double t2=totcomm_dol;
			   if (prio.equals("E")){//deco
					  if(nonCommision>0){
					 com_perc=for19.format(((totcomm_dol/((totprice_dis-nonCommission)))*100));
					  }
					  else{
							 for(int z=0;z<price.size();z++){
										if( (Double.parseDouble(bpcs_qty.elementAt(z).toString().trim())>0)&(Double.parseDouble(price.elementAt(z).toString().trim())>0) ){

											    //  t1=t1+ (Double.parseDouble(price.elementAt(z).toString()))*0.91;
											    t1=t1+ (Double.parseDouble(price.elementAt(z).toString()));
										}
							 }
							com_perc=for19.format((t2/t1)*100);
					  }
			   fc_perc="00.000";
			   }
			   else{//cs
					  if(nonCommision>0){
					  com_perc=for19.format(((totcomm_dol/((totprice_dis-nonCommision)*0.91))*100));
					  }
					  else{
			   //		 out.println("Hello");
							 for(int z=0;z<price.size();z++){
										if( (Double.parseDouble(bpcs_qty.elementAt(z).toString())>0)&(Double.parseDouble(price.elementAt(z).toString())>0) ){
											  //t=for12.format((Double.parseDouble(price.elementAt(z).toString()))*0.91);
												 t1=t1+(Double.parseDouble(price.elementAt(z).toString()))*0.91;
										}
							 }
							com_perc=for19.format((t2/t1)*100);
					  }
			   fc_perc="09.000";
		//	out.println("<br>"+":"+"comm perc"+com_perc+"<br>");
			   //fc_value=for12.format(totcomm_dol*0.09);
			   }
//out.println("18");
//out.println("10");
		//	out.println("Com_perc"+com_perc+"::"+for12.format(totcomm_dol)+"non comission::"+nonCommision+"totPrice"+totprice_dis+"<br>");
		//overage perc
		// printing the actual values
		/*String t="";double t1=0.0;double t2=Double.parseDouble(for12.format(totcomm_dol));
		 for(int z=0;z<price.size();z++){
		   if( (Integer.parseInt(bpcs_qty.elementAt(z).toString())>0)&(Double.parseDouble(price.elementAt(z).toString())>0) ){
			  t=for12.format((Double.parseDouble(price.elementAt(z).toString()))*0.91);
				 t1=t1+(Double.parseDouble(t));
			 out.println("test"+price.elementAt(z).toString()+"qty::"+bpcs_qty.elementAt(z).toString()+"t::"+t+"t1::"+t1+"<br>");
			   }
		  }*/
		//priting the actual values done

		String overage_perc=for19.format(((Double.parseDouble(overage)/(total_sale_price))*100));
										r="";
										for (int i = 0; i <com_perc.length(); i ++) {
											   if (com_perc.charAt(i) != '.' && com_perc.charAt(i) != ',') r += com_perc.charAt(i);
										}
										com_perc=r;
							    if(com_perc.length()<12){
										String tv="";
										for(int v=0;v<(12-com_perc.length());v++){
										tv="0"+tv;
										   }
										com_perc=tv+com_perc;
										 }// commission perc
										tot_com_dol_str=for12.format( totcomm_dol);
										r="";
										for (int i = 0; i < tot_com_dol_str.length(); i ++) {
											   if (tot_com_dol_str.charAt(i) != '.' && tot_com_dol_str.charAt(i) != ',') r += tot_com_dol_str.charAt(i);
										}
										tot_com_dol_str=r;
										r="";
										for (int i = 0; i <tot_com_dol_str.length(); i ++) {
											   if (tot_com_dol_str.charAt(i) != '.' && tot_com_dol_str.charAt(i) != ',') r += tot_com_dol_str.charAt(i);
										}
										tot_com_dol_str=r;
							    if(tot_com_dol_str.length()<15){
										String tv="";
										for(int v=0;v<(15-tot_com_dol_str.length());v++){
										tv="0"+tv;
										   }
										tot_com_dol_str=tv+tot_com_dol_str;
										 }// commission perc
										String overage_str=String.valueOf(for12.format(new Double(overage).doubleValue()));
										int neg = overage_str.indexOf("-");
										if(neg >= 0){
											   //out.println(overage_str +" original<BR>");
											   overage_str=overage_str.substring(neg+1);
											   //out.println(overage_str +" with out negative<BR>");
											   String lastDigit=overage_str.substring(overage_str.length() -1);
											   overage_str=overage_str.substring(0,overage_str.length()-1)+charMap[Integer.parseInt(lastDigit)];
											   //out.println(overage_str+" with char replaced<BR>");
										}
										r="";
										for (int i = 0; i <overage_str.length(); i ++) {
											   if (overage_str.charAt(i) != '.' && overage_str.charAt(i) != ',') r += overage_str.charAt(i);
										}
										overage_str=r;
							    if(overage_str.length()<15){
										String tv="";
										for(int v=0;v<(15-overage_str.length());v++){
										tv="0"+tv;
										   }
										overage_str=tv+overage_str;
										 }// commission perc
										r="";
										for (int i = 0; i <overage_perc.length(); i ++) {
											   if (overage_perc.charAt(i) != '.' && overage_perc.charAt(i) != ',') r += overage_perc.charAt(i);
										}
										overage_perc=r;
							    if(overage_perc.length()<12){
										String tv="";
										for(int v=0;v<(12-overage_perc.length());v++){
										tv="0"+tv;
										   }
										overage_perc=tv+overage_perc;
										 }//
										r="";
										for (int i = 0; i <fc_perc.length(); i ++) {
											   if (fc_perc.charAt(i) != '.' && fc_perc.charAt(i) != ',') r += fc_perc.charAt(i);
										}
										fc_perc=r;
							    if(fc_perc.length()<6){
										String tv="";
										for(int v=0;v<(6-fc_perc.length());v++){
										tv="0"+tv;
										   }
										fc_perc=tv+fc_perc;
										 }//
										r="";
										for (int i = 0; i <fc_value.length(); i ++) {
											   if (fc_value.charAt(i) != '.' && fc_value.charAt(i) != ',') r += fc_value.charAt(i);
										}
										fc_value=r;
									  if(fc_value.length()<15){
										String tv="";
										for(int v=0;v<(15-fc_value.length());v++){
										tv="0"+tv;
										   }
										fc_value=tv+fc_value;
										 }//
										// if(quote_type==null){quote_type="E";}else{quote_type="P";}



										//quote_type="E";
											   if(quote_type==null||quote_type.trim().length()==0){
													  quote_type="E";
											   }
											   else if(quote_type.equals("PSA")){
													 quote_type="E";
											   }
											   else if(quote_type.equals("web")){
													 quote_type="W";
											   }
											    else if(quote_type.equals("SFDC")||quote_type.equals("RP")){
													 quote_type="S";
											   }




										// String cs_doc_type="";
										//if(rep_no.trim().length()==3){cs_doc_type="B";}else{cs_doc_type="R";}
								  //if(cs_order_type.startsWith("BUY")){cs_order_type="B";}else{cs_order_type="R";}
										if(cs_order_type.startsWith("BUY")){
											   cs_order_type="B";
											   overage_perc="100000000000"; // changed as per Charlie on Aug 14 2008

										}
										else{
											   cs_order_type="R";
											   overage_perc="000000000000";
										}
		//if(isGood){
//out.println("19");
			   final_oc_out=final_oc_out+"CO"+order_no+com_perc+tot_com_dol_str+overage_str+fc_perc+fc_value+rep_no+"001"+"100000000000"+tot_com_dol_str+overage_perc+overage_str+order_no+" "+quote_type+"000000"+cs_order_type+"100"+"\r\n";
			   //out.println("OUTput not send for order details<br>");
			   //ic out
			   //final out
		//out.println(overageLine+" from lines<BR>");
		//out.println( overage+" total<BR>");
		String url="WS"+order_no+"http://ims.c-sgroup.com/go.asp?APPA=CS&SUBJ=NEWORDERS&KEY="+product_id+order_no+"&REPNO="+thisRep;
		//String url="WS"+order_no+"http://ims.c-sgroup.com/go.asp?APPA=TESTCS&SUBJ=NEWORDERS&KEY="+product_id+order_no;
								   final_out=final_oh_out+final_os_out+final_oi_out+final_on_out+final_oc_out+final_ic_out;
								    final_out=final_out.toUpperCase()+url;

								    if(bpcs_order_no == null){
											   bpcs_order_no="";
										}
										if(quote_origin==null){
											   quote_origin="";
										}
		//out.println(bpcs_order_no+"::"+quote_origin+":: quote origin<BR>");
		//if((bpcs_order_no.trim().equals("")||bpcs_order_no==null)&&((quote_origin==null)||!(quote_origin.startsWith("change")|quote_origin.startsWith("release")|quote_origin.startsWith("revision")|quote_origin.startsWith("submittal")))){
		if(!(order_type.startsWith("ADD")&&bpcs_order_no.trim().length()>0)){
			final_out=final_oh_out+final_os_out+final_oi_out+final_on_out+final_oc_out+final_ic_out;
			  final_out=final_out.toUpperCase()+url;
			   //out.println("HERE1");
		}

		else{

			   final_out=final_oi_out+final_on_out+final_ic_out;
			   int lastIndex = 0; int countv =0;
			   while(lastIndex != -1){
				    lastIndex = final_out.indexOf(order_no.substring(6,9),lastIndex+1);
				    if( lastIndex != -1){
						 countv ++;
						 String tempend1=base_quote_no.substring(6,9);
						 final_out=final_out.substring(0,lastIndex)+tempend1+final_out.substring(lastIndex+3,final_out.length());
				    }
			   }
			   dir_path="D:\\TRANSFER\\BPCS_OEA\\";
			   dir_path1="D:\\TRANSFER\\BPCS_OEA\\testing\\";
			   //out.println("HERE2");
		}
		if(base_quote_no==null|| base_quote_no.trim().length()==0){
			   base_quote_no=order_no;
		}
		String tempend2=base_quote_no.substring(6,9);
//out.println("11");
if(!(order_type.startsWith("ADD"))){
			base_quote_no=order_no;
			tempend2=order_no.substring(6,9);
		}


		// out.println(final_out);
		 BufferedWriter out1 = new BufferedWriter(new FileWriter(dir_path+"\\"+"O"+order_no.substring(0,6)+tempend2+".txt"));
		 out1.write(final_out);
								   out.flush();
								   out1.flush();
								   out1.close();
								  out.println("Output file created succesfully for eRapid Order... "+order_no+"<br><br><br>");
								  //writing the output to second folder also
								   BufferedWriter out2 = new BufferedWriter(new FileWriter(dir_path1+"\\"+"O"+order_no+".txt"));
								   out2.write(final_out);
								   out2.flush();
								   out2.close();
		//}
		//else{

		//	out.println("We have encountered an error matching up to PSA please contact CS Group to resolve issue<BR>");
		//}

		///To Send Bills and routing files
		//out.println("OUTput send for order details");
		out.flush();
											   //	myConn.setAutoCommit(false);
													 try	{
														    int nrow1= stmt.executeUpdate("delete from cs_bpcs_mat_shop_orders WHERE cse_order_no like '"+order_no+"'");

													 }
													 catch (java.sql.SQLException e){
														    out.println("Problem with deleting the efs shop paper header info"+"<br>");
														    out.println("Illegal Operation try again/Report Error"+"<br>");
											   //		myConn.rollback();
														    out.println(e.toString());
														    return;
													 }
													 try	{
														    for (int itt = 0; itt < shop_parts.size(); itt ++) {
																  String insert ="INSERT INTO cs_bpcs_mat_shop_orders(cse_order_no,seq_no,prod_desc,bpcs_part_sub,item_no,bpcs_shop_order_no,transfer,qty)VALUES(?,?,?,?,?,?,?,?) ";
														    PreparedStatement update_mat_shop_orders = myConn.prepareStatement(insert);
														    update_mat_shop_orders.setString(1,order_no);
														    update_mat_shop_orders.setInt(2,itt+1);
														    update_mat_shop_orders.setString(3,shop_part_desc.elementAt(itt).toString());
														    update_mat_shop_orders.setString(4,shop_parts.elementAt(itt).toString());
														    update_mat_shop_orders.setString(5,shop_line_no.elementAt(itt).toString());
														    update_mat_shop_orders.setString(6,"");
														    update_mat_shop_orders.setString(7,"Y");
														    update_mat_shop_orders.setString(8,shop_qty.elementAt(itt).toString());
																  int rocount = update_mat_shop_orders.executeUpdate();
																  update_mat_shop_orders.close();
														    //	out.println("::"+shop_parts.elementAt(itt).toString()+"::"+shop_qty.elementAt(itt).toString()+"::"+shop_part_desc.elementAt(itt).toString()+"line::"+shop_line_no.elementAt(itt).toString()+"<br>");
														    }
													 }
													 catch (java.sql.SQLException e){
														    out.println("Problem with Inserting the shop orders into the database: "+order_no+"<br>");
														    out.println("Illegal Operation try again/Report Error"+"<br>");
											   //		myConn.rollback();
														    out.println(e.toString());
														    return;
													 }
		///To Send Bills and routing files done

								  //the last step sending the mail to the rep.
								  //email stuff
String name=request.getParameter("userSessionId");

					String to="";
										    //out.println(thisRep+"::"+name+"::<BR>"+"select  TOP 1 email from cs_reps where rep_no='"+thisRep+"' and user_id in('"+name+"','') ORDER BY user_id DESC");
														    ResultSet rs_rep=stmt.executeQuery("select  TOP 1 email from cs_reps where rep_no='"+thisRep+"' and user_id in('"+name+"','') ORDER BY user_id DESC");
														   out.println("select  TOP 1 email from cs_reps where rep_no='"+thisRep+"' and user_id in('"+name+"','') ORDER BY user_id DESC<BR>");
														   if(rs_rep != null){
																  while(rs_rep.next()){
																		to=rs_rep.getString("email");
																  }
														    }
														    rs_rep.close();
														    if(to==null){
														    ResultSet rs_rep2=stmt.executeQuery("select  TOP 1 email from cs_reps where rep_no='"+thisRep+"' ORDER BY user_id DESC");
														    if(rs_rep2 != null){
																  while(rs_rep2.next()){
																		to=rs_rep2.getString("email");
																  }
														    }
														    rs_rep2.close();



}
														    if(to==null){to="";}
														    String message="Thank you for the order.";
								  //out.println("Test"+thisRep+"::"+rep_no+"Order rep"+order_rep_no);
														    //getting the customer service contact info.
														    if(georder.trim().equals("GE")){product_id="GE";}
														    String cust_serv_cont="";
														    ResultSet rs_emails=stmt.executeQuery("Select contact_name from cs_sbu_contacts where product_id ='"+product_id+"' and optio_email = '"+email_to.trim()+"' order by rep_no");
														    if(rs_emails != null){
																  while(rs_emails.next()){
																		cust_serv_cont=rs_emails.getString("contact_name");
																  }
														    }
														    rs_emails.close();
														    //getting the customer service contact done.
		%>
		<form name='selectform' method='post'>
			<input type="hidden" name="order_no" value="<%=order_no%>">
			<input type="hidden" name="rep_no" value="<%=thisRep%>">
			<input type="hidden" name="userId" value="<%=userId%>">
			<input type="hidden" name="to" value="<%=to%>">
			<input type="hidden" name="from" value="Erapid_Order_<%=order_no%>_confirmation@c-sgroup.com">
			<input type="hidden" name="cc" value="">
			<% if(email_to.trim().length()<=0){%>
			<input type="hidden" name="message" value="Thank you for your order. Your Erapid Order:<%=order_no%> successfully transferred. A Construction Specialties, Inc. Customer service representative will contact you with further details.">
			<input type="hidden" name="message1" value="A Construction Specialties, Inc Customer service representative will contact you with further details.">
			<%
								}else{%>
			<input type="hidden" name="message" value="Thank you for your order. Your Erapid Order:<%=order_no%> successfully transferred. Your Construction Specialties, Inc. Customer service representative: <%=cust_serv_cont%> (<%=email_to.trim()%>) will contact you with further details.">
			<input type="hidden" name="message1" value="Your Construction Specialties, Inc Customer service representative:<b> <%=cust_serv_cont%></b> (<%=email_to.trim()%>) will contact you with further details.">
			<%}
			%>
		</form>

		<%
		//email logging
		/*
		try	{
					 String insert ="INSERT INTO cs_ows_transfer_email_log([order_no],[time_sent],[rep_no],[product_id],[from_email],[to_email],[user_id])VALUES(?,?,?,?,?,?,?) ";
			   PreparedStatement update_mat_shop_orders = myConn.prepareStatement(insert);
			   update_mat_shop_orders.setString(1,order_no);
			   update_mat_shop_orders.setTimestamp(2,new java.sql.Timestamp(Calendar.getInstance().getTime().getTime()));
			   update_mat_shop_orders.setString(3,thisRep);
			   update_mat_shop_orders.setString(4,product_id);
			   update_mat_shop_orders.setString(5,"Erapid_Order_"+order_no+"_confirmation@c-sgroup.com");
			   update_mat_shop_orders.setString(6,to);
			   update_mat_shop_orders.setString(7,name);
					 int rocount = update_mat_shop_orders.executeUpdate();
					 update_mat_shop_orders.close();
		}
		catch (java.sql.SQLException e){
			   out.println("Problem with Inserting into the '"+product_id+"' database log for: "+order_no+"<br>");
			   out.println("Illegal Operation try again/Report Error"+"<br>");
			   out.println(e.toString());
			   return;
		}
		*/
  //email logging done

  stmt.close();
  //myConn.commit();
  myConn.close();
  stmt_psa.close();
  myConn_psa.close();

			}
			catch(Exception e){
			out.println(e);
			}
		%>
