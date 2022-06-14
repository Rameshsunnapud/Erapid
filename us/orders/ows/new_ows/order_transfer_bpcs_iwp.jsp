
<%

try{

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>Transfer to BPCS</title>
		<link rel='stylesheet' href='style1.css' type='text/css'/>
	</head>
	<SCRIPT LANGUAGE="JavaScript">
		function poponload()
		{
			var time=new Date();
			hours=time.getHours();
			mins=time.getMinutes();
			secs=time.getSeconds();
			closeTime=hours*3600+mins*60+secs;
			closeTime+=4;  // This number is how long the window stays open

			var url="mail.delivery2.jsp?order_no="+document.selectform.order_no.value+"&to="+document.selectform.to.value+"&from="+document.selectform.from.value+"&message="+document.selectform.message.value+"&cc=&sections=all&rep_no="+document.selectform.rep_no.value+"&name="+document.selectform.userId.value;
			var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=450,height=200';
			if(document.selectform.to.value.length>0){
			}
			else{
				//alert("PLEASE NOTE WE ARE UNABLE TO EMAIL YOU.  PLEASE CONTACT ERAPID TEAM.");
			}

		}

		function Timer(){
			var time=new Date();
			hours=time.getHours();
			mins=time.getMinutes();
			secs=time.getSeconds();
			curTime=hours*3600+mins*60+secs
			if(curTime>=closeTime){
				self.close();
			}
			else{
				window.setTimeout("Timer()",1000)
			}
		}
	</script>

	<body onload="poponload()">
		
		<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.lang.*"  import="java.io.*" import="java.text.*" import="java.math.*" errorPage="error.jsp" %>
		<%@ include file="db_con.jsp"%>
		<%-- <%@ page autoFlush="true" buffer="1094kb"%> --%>


		<%
		org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
		int lineIncrease=0;
		String order_no = request.getParameter("order");
		String si = request.getParameter("sections");
		String userId=request.getParameter("userId");
		String thisRep=request.getParameter("rep_no");
		if(thisRep == null || thisRep.trim().length()==0){
			//thisRep=userSession.getRepNo();
		}
		//out.println(thisRep);
		String groupName="";
		String doc_priority=request.getParameter("doc_priority");
		String bpcsTransferSheet = request.getParameter("bpcsTransferSheet");
		String order_sheet_url = request.getParameter("order_sheet_url");
		//out.println("order sheet url : "+order_sheet_url);
		//order_sheet_url = order_sheet_url + "&userId="+userId+ "&bpcsTransferSheet="+bpcsTransferSheet+ "&sections="+si+ "&rep_no="+thisRep;
								String environment = request.getParameter("environment");
								%>
												<br>
		<center><b>Please click on the Order Write Up button to open Order document</b>
	
&nbsp;&nbsp;<input type='button' name='order_sheet' id='order_sheet' value='Order Write Up' onclick='openOrdersheet("<%=order_sheet_url %>")'/></center>
<br>
 			<script type="text/javascript"> 
			
			function openOrdersheet(url)
			{
				//alert('Order transfer is successfully. We are opening order document for you.'+url);
				 window.location.href=url;
			}
 	</script>
	<h1>CS Order Transfer System::</h1>
								<%

		boolean isGood=true;


		%>
		
		<%@ include file="dbcon1.jsp"%>
		<%@ include file="db_con_bpcsusrmm.jsp"%>
		<%
  try{
		double lineOver=0;
		double overageLine=0.0;
		String [] charMap = {"}","J","K","L","M","N","O","P","Q","R"};
		int notesCounter=1;
		String r="";
		NumberFormat for12 = NumberFormat.getInstance();
		for12.setMaximumFractionDigits(2);
		for12.setMinimumFractionDigits(2);
		NumberFormat for10 = NumberFormat.getInstance();
		for10.setMaximumFractionDigits(0);
		for10.setMinimumFractionDigits(0);
		NumberFormat for13 = NumberFormat.getInstance();
		for13.setMaximumFractionDigits(3);
		for13.setMinimumFractionDigits(3);
		NumberFormat for14 = NumberFormat.getInstance();
		for14.setMaximumFractionDigits(4);
		for14.setMinimumFractionDigits(4);
		NumberFormat for19 = NumberFormat.getInstance();
		for19.setMaximumFractionDigits(9);
		for19.setMinimumFractionDigits(9);
		//vars for io to file

		String dir_path="\\\\lebhq-erusdev\\TRANSFER\\BPCS_OE\\";String final_out="";String final_oh_out="";String final_os_out="";String final_oi_out="";
		String final_on_out="";String final_oc_out="";String final_ic_out="";
		String dir_path1="\\\\lebhq-erusdev\\TRANSFER\\BPCS_OE\\testing\\";
		String add_deduct_job="";
		//
		Vector items=new Vector();
		String section_group="";Vector si_final = new Vector();Vector li_final = new Vector();String Project_name="";String product_id="";String lines_final = "";
		String overage="";String freight_cost="";String handling_cost="";String setup_cost="";double config_price=0;double total_sale_price=0;
		String rep_no="";String quote_type="";String psa_quote_id="";String bpcs_tier_order="";
		double nonCommision=0.0;
		Vector QTY=new Vector();Vector price=new Vector();Vector line_item=new Vector();Vector desc=new Vector();
					 Vector rec_no=new Vector();Vector fact_per=new Vector();Vector mark=new Vector();Vector block_id=new Vector();Vector bpcs_part_no=new Vector();
					 Vector add_release_flag=new Vector();
					 Vector bpcs_qty=new Vector();Vector bpcs_tier_lines=new Vector();String quote_origin="";String bpcs_order_no=""; String base_quote_no=""; String quote_no_origin="";
		//		 if (si==nul
		String largestLine="";
		double largestPrice=0.0;
		int counterLarge=0;
		int indexLarge=-1;
		int diLineCounter=1;
		double nonCommission=0;
		String prio="";
String source="";
		String georder="";

		//reteriving the lines from the sections
						    //out.println("Out put Transfer Started....... "+"to "+dir_path+ " folder for upload to BPCS"+"<br><br><br>");
					 out.println(".......Out put transfer to CS order system BPCS started for IWP....... <br><br><br>");
						    ResultSet rs_find = stmt.executeQuery("SELECT * FROM cs_quote_sections where order_no like '"+order_no+"'");
						    if (rs_find !=null) {
						    while (rs_find.next()){
						    section_group=rs_find.getString ("section_group");
		//			out.println("Testing"+section_group);
							}
						    }
						    rs_find.close();
		// Project info
		String sales_tax_code="";
					 ResultSet rs_project = stmt.executeQuery("SELECT * FROM cs_project where Order_no like '"+order_no+"' ");
						    if (rs_project !=null) {
				  while (rs_project.next()) {
							if(rs_project.getString("project_type")!=null&& rs_project.getString("project_type").equals("SFDC")){
								source=rs_project.getString("sfdc_type");
							}
						    Project_name= rs_project.getString("Project_name");
						    product_id= rs_project.getString("product_id");
						    if(product_id.equals("EJC")){product_id="TPG";}
						    rep_no=rs_project.getString("creator_id");
						    overage= rs_project.getString("overage");
						    georder=rs_project.getString("doc_type_alt");
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
						    //out.println(setup_cost+":: setup cost<BR>");
						    quote_type=rs_project.getString("project_type");
						    if(!(quote_type != null)){
								  quote_type="";
						    }
						    psa_quote_id=rs_project.getString("project_type_id");
						    bpcs_tier_order=rs_project.getString("bpcs_tier");
						    sales_tax_code=rs_project.getString("tax_code");
						    quote_origin= rs_project.getString("quote_origin");
						    bpcs_order_no= rs_project.getString("BPCS_order_no");
						    if(rs_project.getString("base_quote_no") != null && rs_project.getString("base_quote_no").trim().length()>6&& rs_project.getString("base_quote_no").trim().substring(0,6).startsWith(order_no.substring(0,6))){
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
							out.println("1");
		if(base_quote_no!=null &&base_quote_no.trim().length()>0 && base_quote_no.startsWith(order_no.substring(0,6)) && quote_origin.trim().length()>0 && !quote_origin.equals("Alternate")){
			   boolean keepgoing=true;
			   String tempquote_origin="";
			   String tempbase_quote_no=base_quote_no;
			   String tempbase_quote_no_old="";
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
					 }
					 else{
						    keepgoing=false;
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
		

						    if(quote_origin==null){quote_origin="";}
						    if(bpcs_tier_order==null){bpcs_tier_order="0";}
						    if(sales_tax_code==null){sales_tax_code="";}
						    StringTokenizer st=new StringTokenizer(si,",");
						    while (st.hasMoreTokens()){
						    si_final.addElement(st.nextToken());
						    }
						    StringTokenizer st1=new StringTokenizer(section_group,";");
						    while (st1.hasMoreTokens()){
						    li_final.addElement(st1.nextToken());
						    }

		//getting lines
			out.println("2");
		String km="";
		for(int k=0;k<si_final.size();k++){ //s1
					 for(int kl=0;kl<li_final.size();kl++){//1=s1
								  km=li_final.elementAt(kl).toString();
							 if(km.endsWith(si_final.elementAt(k).toString())){
							 if(lines_final.length()==0){
							 lines_final=lines_final+km.substring(0,km.indexOf("="));
							 }else{lines_final=lines_final+","+km.substring(0,km.indexOf("=")); }
							}
					 }
		}

		//doc_line
		// Checking the no of lines

					 ResultSet rs1 = stmt.executeQuery("SELECT doc_line FROM doc_line where doc_number like '"+order_no+"' order by cast(doc_line as integer)");
			   while ( rs1.next() ) {
			   items.addElement(rs1.getString("doc_line"));
											    }
			   rs1.close();

		// Checking the no of lines	done
		//doc_line end
		//CS_QUOTES<br>
		double draftLogTime=0;
		
		Vector line_whse=new Vector();
					 ResultSet rs3 = stmt.executeQuery("SELECT * FROM csquotes where order_no like '"+order_no+"' and line_no in ("+lines_final+") and not block_id in ('KP_A','CTS') order by cast(Line_no as integer)");
			   while ( rs3.next() ) {
					 line_item.addElement(rs3.getString ("Line_no"));
					 desc.addElement(rs3.getString ("Descript"));
					 price.addElement(rs3.getString ("Extended_Price"));
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
						    }else{fact_per.addElement("0");
								  nonCommission=nonCommission+(new Double(rs3.getString("extended_price")).doubleValue());
						    }
					 mark.addElement(rs3.getString("field17"));
					 bpcs_part_no.addElement(rs3.getString("bpcs_gen"));
						    if(rs3.getString("bpcs_qty") != null && rs3.getString("bpcs_qty").trim().length()>0){
								  bpcs_qty.addElement(rs3.getString("bpcs_qty").trim());
						    }else{bpcs_qty.addElement("0");	}
					 //bpcs_line tiers
						    if(rs3.getString("bpcs_tier") != null && rs3.getString("bpcs_tier").trim().length()>0){
								  bpcs_tier_lines.addElement(rs3.getString("bpcs_tier").trim());
						    }else{bpcs_tier_lines.addElement(" ");	}


						    if(quote_origin.startsWith("change")& rs3.getString("deduct").trim().equals("add")){
								   add_release_flag.addElement("A");
						    }
						    else if(quote_origin.startsWith("release")|quote_origin.startsWith("revision")|quote_origin.startsWith("submittal")){
								   add_release_flag.addElement("R");
						    }else{
								   add_release_flag.addElement("A");
						    }
						    if(rs3.getString("block_id").toUpperCase().equals("A_APRODUCT")){
								  if(rs3.getString("bpcs_confirm") != null && rs3.getString("bpcs_confirm").trim().length()>0){
										draftLogTime=draftLogTime+new Double(rs3.getString("bpcs_confirm")).doubleValue();
								  }
						    }

			   if(rs3.getString("whse") != null && rs3.getString("whse").trim().length()>0){
					 line_whse.addElement(rs3.getString("whse").trim());
			   }else{line_whse.addElement("");	}
					 counterLarge++;
											    }
			   rs3.close();
			   double cents=Math.round(config_price)-config_price;
			   if(quote_type!= null && quote_type.equals("web")){
					 cents=0;
			   }
			   else{
					 config_price=config_price+cents;
			   }
			   //DecimalFormat for1_roundup=new DecimalFormat("#.##");
			   //for1_roundup.setMaximumFractionDigits(0);


		//      	out.println(cents+"::cents"+config_price+"config price :: largest Price"+largestPrice+"::largestLine"+largestLine+"::"+indexLarge+"index<BR>");
	out.println("3");
		if(indexLarge>=0){
		double priceLarge=new Double(price.elementAt(indexLarge).toString()).doubleValue()+cents;
		double comLarge=new Double(price.elementAt(indexLarge).toString()).doubleValue()*new Double(fact_per.elementAt(indexLarge).toString()).doubleValue();
		double newCom=comLarge/priceLarge;
		price.setElementAt(String.valueOf(priceLarge),indexLarge);
		fact_per.setElementAt(String.valueOf(newCom),indexLarge);
		}


		total_sale_price=config_price+Double.parseDouble(overage)+Double.parseDouble(handling_cost)+Double.parseDouble(freight_cost)+Double.parseDouble(setup_cost);
		//grand_total=(Float.parseFloat(o_cost)+Float.parseFloat(handling_cost)+Float.parseFloat(freight_cost)+Float.parseFloat(t));

		//db connectons
		 //billing customer
					 String cust_name1="";String cust_addr1="";String cust_addr2="";String city="";String state="";String zip_code="";
					 String phone="";String fax="";String contact_name="";String customer_po_no="";String payment_terms="";String bpcs_cust_no="";
					 String invoice_info="";String cs_order_type="";String order_rep_no="";String sales_region="";
					 String email_acknowledgement="";String bill_email="";String order_type="";
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
						bill_email=rs_bill.getString("email");
					 email_acknowledgement=rs_bill.getString("email_acknowledgement");
						add_deduct_job=rs_bill.getString("add_deduct_job");
															   }
								  }
		//getting the rep_no from cs_billed
		if(sales_region==null){
			   sales_region="";
		}
		if(email_acknowledgement==null){
			   email_acknowledgement="";
		}
		if(bill_email==null){
			   bill_email="";
		}
		//if(cs_company==null){
		//	cs_company="";
		//}
					 if(order_rep_no== null){order_rep_no=thisRep;}
					 else{
						    if(order_rep_no.equals(thisRep)){}
						    else{
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

	out.println("4");
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
		String email_to="";String win_loss="";String submit_by="";String add_docs="";String special_notes="";String copies_requested="";String order_notes="";String drafting_email="";
		String customer_notes="";
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
								  customer_notes=rs_order.getString("customer_notes");
								  drafting_email=rs_order.getString("drafting_email");
																		}
															    }
								  if(drafting_email==null){
										drafting_email="";
								  }
		//eorders for the
					 ResultSet e_order = stmt.executeQuery("SELECT * FROM doc_header where doc_number like '"+order_no+"' ");
					 if (e_order !=null) {
			   while (e_order.next()) {
					 prio= e_order.getString("doc_priority");
														    }
													  }
		rs_bill.close();
		rs_ship.close();
		rs_order.close();
		e_order.close();
		//db connections done
		//out out preparation to BPCS started,.
		//going to cs_invoice table for bpcs_cust_no
		String ship_to_customer="";//6 characters
		String invoice_customer="";//6 characters
			   ResultSet cs_invoice = stmt.executeQuery("SELECT bpcs_cust_no FROM cs_invoice where order_no like '"+order_no+"' ");
					 if (cs_invoice !=null) {
			   while (cs_invoice.next()){
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
			   String psa_quote_type="";
		String spec_rep_acct_id="";String terr_rep_acct_id="";String arch_acct_id="";String order_rep_acct_id="";// for different accounts

	 if(quote_type.equals("SFDC")){
	if(source.endsWith("PS")||source.equals("IPS")||source.equals("SPS")){
		source="PS";
	}
	else{
		source="TQ";
	}
}
if(quote_type ==null || quote_type.trim().length()==0 || quote_type.equals("null")){
			   source="TQ"; //for rep quotes always
		}


			if( bpcs_cust_no != null &&  bpcs_cust_no.trim().length()>0){
				String query="SELECT CMSTTP from bpcsffg/rcm where ccust = "+bpcs_cust_no+" ";
				ResultSet rs0=stmt_bpcsusrmm.executeQuery(query);
				if(rs0 != null){
					while(rs0.next()){
						if(rs0.getString(1)!= null && rs0.getString(1).trim().length()>0){
							source=rs0.getString(1);
						}
					}
				}
				rs0.close();
			}
stmt_bpcsusrmm.close();
con_bpcsusrmm.close();

					 //oh out
					 if(bpcs_cust_no==null){bpcs_cust_no="000000";}if(cust_name1==null){cust_name1=" ";}if(cust_addr1==null){cust_addr1=" ";}if(cust_addr2==null){cust_addr2=" ";}
					 if(city==null){city=" ";}if(state==null){state=" ";}if(zip_code==null){zip_code=" ";}if(phone==null){phone=" ";}if(fax==null){fax=" ";}if(contact_name==null){contact_name=" ";}
					 if(customer_po_no==null){customer_po_no=" ";} 
					 if(payment_terms.startsWith("NET")){payment_terms=" ";}else{payment_terms="V";} 
					 if(Project_name==null){Project_name=" ";}
					 if(customer_po_no==null){customer_po_no=" ";}if(email_to==null){email_to ="";}
					 if(ship_rdate==null){ship_date ="00000000";}
					 else{Format formatter = new SimpleDateFormat("yyyyMMdd");
				  ship_date = formatter.format(ship_rdate);
					 }

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
															   }
																  bpcs_cust_no=tv+bpcs_cust_no;
													 }
													 if(invoice_customer.length()<6){
														    String tv="";
														    for(int v=0;v<(6-invoice_customer.length());v++){
														    tv="0"+tv;
														}
														    invoice_customer=tv+invoice_customer;
													 }
													 if(ship_to_customer.length()<6){
														    String tv="";
														    for(int v=0;v<(6-ship_to_customer.length());v++){
														    tv="0"+tv;
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
													 cust_addr1=cust_addr1.replace("\n", "").replace("\r", "");
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
															else if(doc_priority.equals("E")){market="DG";}
															else{
																  market="DL";
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
																  if(sales_region.trim().length()>0 && sales_region.indexOf("-")>0){
																		sales_region=sales_region.substring(0,sales_region.indexOf("-"));
																  }
																	else{
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
													 if(win_loss.equals("RF")|win_loss.equals("HA")){
														    ware_house_header="1 ";
														    ware_house_line="1 ";
													 }else{
														    ware_house_header="DR";
														    ware_house_line="DR";
													 }
													 if(quote_origin.toUpperCase().equals("SAMPLE")){
														    ware_house_header="SM";
														    ware_house_header="SM";
													 }

													 if(groupName.toUpperCase().startsWith("CAN")){
														    ware_house_header="CW";
														    ware_house_line="CW";
													 }

													 if(georder.trim().equals("GE")){
														    ware_house_line="1G";
													 }



											   if(ware_house_header.length()<2){
														    String tv="";
														    for(int v=0;v<(2-ware_house_header.length());v++){
														    tv=" "+tv;
														}
														    ware_house_header=ware_house_header+tv;

											   }else{ware_house_header=ware_house_header.substring(0,2);}
											   if(ware_house_line.length()<2){
														    String tv="";
														    for(int v=0;v<(2-ware_house_line.length());v++){
														    tv=" "+tv;
														}
														    ware_house_line=ware_house_line+tv;

											   }else{ware_house_line=ware_house_line.substring(0,2);}
										// phase -2 ends here
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
						    String divisionx="";
						    if(georder.trim().equals("GE")){
								  divisionx="A6";
						    }
						    else if(groupName.toUpperCase().startsWith("CAN")){
								  divisionx="AE";
						    }
						    else{
								  divisionx="A2";
						    }

//logger.debug("h");
		final_oh_out=final_oh_out+"HO"+order_no+bpcs_cust_no+cust_name1+cust_addr1+cust_addr2+city+state+zip_code+phone+fax+contact_name+customer_po_no+payment_terms+Project_name+ship_date;
		final_oh_out=final_oh_out.toUpperCase()+email_to+ware_house_header+market+divisionx+sales_region+terms+source+ship_to_customer+invoice_customer+sales_tax_code+release_flag+user_hold+bpcs_tier_order+"\r\n";
		
		out.println("5");
		//os out
													 if(ship_name.length()<30){
																  String tv="";
																  for(int v=0;v<(30-ship_name.length());v++){
																  tv=" "+tv;
															   }
																  ship_name=ship_name+tv;
													 }else{ship_name=ship_name.substring(0,30);}
													 ship_addr1 = ship_addr1.replace("\n", "").replace("\r", "");
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
													 final_os_out=final_os_out+"SO"+order_no+ship_name+ship_addr1+ship_addr2+ship_city+ship_state+ship_zip+ship_phone+ship_attention;
													 final_os_out=final_os_out.toUpperCase()+"\r\n";
		//oi out

														    String add_release_bpcs="";
														    if(quote_origin.startsWith("change")|quote_origin.startsWith("release")|quote_origin.startsWith("revision")|quote_origin.startsWith("submittal")){
																  add_release_bpcs=" ";
														    }else{
																  ship_date="";
																  add_release_bpcs=" ";
														    }


														    //String tot_price_string= String.valueOf(for13.format(total_sale_price));
														    String draftLogTimeString= String.valueOf(for13.format(draftLogTime));
														    if(win_loss.equals("DR")){
																  win_loss="DRAFTLOG"+product_id;
																  if(product_id.equals("IWP")){
																		win_loss="DRAFTLOGIPG";
																  }
																  lineIncrease++;
																  diLineCounter++;
																  if(win_loss.length()<15){
																  String tv="";
																  for(int v=0;v<(15-win_loss.length());v++){
																  tv=" "+tv;
																	}
																  win_loss=win_loss+tv;
																  }
																  r="";

																  for (int i = 0; i < draftLogTimeString.length(); i ++) {
																		if (draftLogTimeString.charAt(i) != '.' && draftLogTimeString.charAt(i) != ',') r += draftLogTimeString.charAt(i);
																  }
																  draftLogTimeString=r;
																  if(draftLogTimeString.length()<11){
																		String tv="";
																		for(int v=0;v<(11-draftLogTimeString.length());v++){
																			   tv="0"+tv;
																		}
																		draftLogTimeString=tv+draftLogTimeString;
																  }
																  //final_oi_out=final_oi_out+"IO"+order_no+win_loss+tot_price_string+"00000000000000"+ware_house_line+"0"+add_release_bpcs+ship_date+"\r\n";
																  final_oi_out=final_oi_out+"IO"+order_no+win_loss+draftLogTimeString+"00000000000000"+ware_house_line+"0"+add_release_bpcs+ship_date+"\r\n";
														    }
														    else if(win_loss.equals("HA")){
																  win_loss="DRAFTLOGREP"+product_id;
																  if(product_id.equals("IWP")){
																		win_loss="DRAFTLOGREPIPG";
																  }
																  lineIncrease++;
																  diLineCounter++;
																  if(win_loss.length()<15){
																  String tv="";
																  for(int v=0;v<(15-win_loss.length());v++){
																  tv=" "+tv;
																	}
																  win_loss=win_loss+tv;
																  }
																  r="";

																  for (int i = 0; i < draftLogTimeString.length(); i ++) {
																		if (draftLogTimeString.charAt(i) != '.' && draftLogTimeString.charAt(i) != ',') r += draftLogTimeString.charAt(i);
																  }
																  draftLogTimeString=r;
																  if(draftLogTimeString.length()<11){
																		String tv="";
																		for(int v=0;v<(11-draftLogTimeString.length());v++){
																			   tv="0"+tv;
																		}
																		draftLogTimeString=tv+draftLogTimeString;
																  }
																  //final_oi_out=final_oi_out+"IO"+order_no+win_loss+tot_price_string+"00000000000000"+ware_house_line+"0"+add_release_bpcs+ship_date+"\r\n";
																  final_oi_out=final_oi_out+"IO"+order_no+win_loss+draftLogTimeString+"00000000000000"+ware_house_line+"0"+add_release_bpcs+ship_date+"\r\n";
														    }
		// OI rules are different for products change them accordingly
		//vectors for fixing the linenote issue
		Vector di_erapid_line_nos=new Vector();Vector di_bpcs_line_nos=new Vector();
		//vectors for  fixing the linenote issue done
								  if(product_id.equals("EFS")){
								  // Frames block	end
								  }// product is EFS
								  else if(product_id.equals("TPG")){
								  }// product is TPG
								  else if(product_id.equals("IWP")){
								  String line_no_text="";String blockId="";String iwp_bpcs_item="";String iwp_qty="";double iwp_qty_up=0; double iwp_price=0;double iwp_com_price=0;
								  //Vars
					 //		out.println("Item Sizes:"+items.size()+"Line_item::"+block_id.size()+"test"+line_item.size()+"<br>");
										for(int ii=0;ii<items.size();ii++){
								  for(int i=0;i<block_id.size();i++){
													 if(line_item.elementAt(i).toString().equals(items.elementAt(ii).toString())){
														    if( !(block_id.elementAt(i).toString().startsWith("E_DIM")|block_id.elementAt(i).toString().startsWith("A_APRODUCT")|block_id.elementAt(i).toString().startsWith("D_NOTES")) ){
																  if(block_id.elementAt(i).toString().startsWith("A_")|block_id.elementAt(i).toString().startsWith("B_")|(bpcs_part_no.elementAt(i).toString()!=null&&bpcs_part_no.elementAt(i).toString().trim().length()>0)){//MAT/GRID PARTS
																		blockId=block_id.elementAt(i).toString();
						    //						out.println(line_item.elementAt(i).toString()+"<BR>"+block_id.elementAt(i).toString()+"::"+price.elementAt(i).toString()+" here<BR>");
																		iwp_bpcs_item=bpcs_part_no.elementAt(i).toString();
																		iwp_qty=String.valueOf(for13.format(new Double(bpcs_qty.elementAt(i).toString()).doubleValue()));
																		iwp_qty_up=new Double(bpcs_qty.elementAt(i).toString()).doubleValue();
																		//out.println(price.elementAt(i).toString()+"<BR>");
																		iwp_price=iwp_price+Double.parseDouble(price.elementAt(i).toString());
																		iwp_com_price=iwp_com_price+Double.parseDouble(fact_per.elementAt(i).toString())*Double.parseDouble(price.elementAt(i).toString());
																		//out.println(efs_price_mat_grid+" efs price mat<BR>");
																		add_release_bpcs=add_release_flag.elementAt(i).toString();
																  }
																  else{
																		iwp_price=iwp_price+Double.parseDouble(price.elementAt(i).toString());
																		iwp_com_price=iwp_com_price+Double.parseDouble(fact_per.elementAt(i).toString())*Double.parseDouble(price.elementAt(i).toString());
																  }
														    ware_house_line=line_whse.elementAt(i).toString();
											   if(ware_house_line.length()<2){
														    String tv="";
														    for(int v=0;v<(2-ware_house_line.length());v++){
														    tv=" "+tv;
														}
														    ware_house_line=ware_house_line+tv;

											   }else{ware_house_line=ware_house_line.substring(0,2);}
		//                		if (iwp_price>0&&!(block_id.elementAt	(ii).toString().equals("A_APRODUCT"))){
										//out.println("Test"+iwp_price+":::"+iwp_bpcs_item+"<BR>");
								  if (iwp_price>=0||quote_origin.toUpperCase().equals("SAMPLE")){
													 //out.println(blockId+"< inside efs_price_mat_grid<BR>");
														    r="";
														    for (int ik = 0; ik < iwp_qty.length(); ik ++) {
																  if (iwp_qty.charAt(ik) != '.' && iwp_qty.charAt(ik) != ',') r += iwp_qty.charAt(ik);
														    }
														    iwp_qty=r;
														    if(iwp_qty.length()<11){
														    String tv="";
														    for(int v=0;v<(11-iwp_qty.length());v++){
														    tv="0"+tv;
															  }
														    iwp_qty=tv+iwp_qty;
														    }
														    if(iwp_bpcs_item.length()<15){
														    String tv="";
														    for(int v=0;v<(15-iwp_bpcs_item.length());v++){
														    tv=" "+tv;
															  }
														    iwp_bpcs_item=iwp_bpcs_item+tv;
														    }
														    double iwp_com_perc=(iwp_com_price/iwp_price)*100;
														    lineOver=iwp_price;

														    String iwp_price_string= String.valueOf(for14.format(iwp_price));

														    String iwp_com_price_string= for12.format(iwp_com_price);
														    String iwp_com_perc_string= for19.format(iwp_com_perc);
														    String iwp_price_string_up = String.valueOf(for14.format(iwp_price/iwp_qty_up));
														    String comPerc="";
														    /*if (prio.equals("E")){
																  if(iwp_price>0){
																  comPerc=String.valueOf(for19.format(100*(iwp_com_price/iwp_price)));
																  }else{
																		comPerc="0";
																  }
														    }else{*/
																  if(iwp_price>0){
																  comPerc=String.valueOf(for19.format(100*(iwp_com_price/(iwp_price*(0.91)))));
																  }else{
																		comPerc="0";
																  }
														    //}
														    r="";
														    for (int ik = 0; ik < comPerc.length(); ik ++) {
																  if (comPerc.charAt(ik) != '.' && comPerc.charAt(ik) != ',') r += comPerc.charAt(ik);
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
														    for (int ik = 0; ik < iwp_price_string.length(); ik ++) {
																  if (iwp_price_string.charAt(ik) != '.' && iwp_price_string.charAt(ik) != ',') r += iwp_price_string.charAt(ik);
														    }
														    iwp_price_string=r;
														    if(iwp_price_string.length()<14){
														    String tv="";
														    for(int v=0;v<(14-iwp_price_string.length());v++){
														    tv="0"+tv;
															  }
														    iwp_price_string=tv+iwp_price_string;
														    }
														    r="";
														    for (int ik = 0; ik < iwp_price_string_up.length(); ik ++) {
																  if (iwp_price_string_up.charAt(ik) != '.' && iwp_price_string_up.charAt(ik) != ',') r += iwp_price_string_up.charAt(ik);
														    }
														    iwp_price_string_up=r;
														    if(iwp_price_string_up.length()<14){
																  String tv="";
																  for(int v=0;v<(14-iwp_price_string_up.length());v++){
																		tv="0"+tv;
																  }
																  iwp_price_string_up=tv+iwp_price_string_up;
														    }
														    r="";
														    for (int ik = 0; ik < iwp_com_price_string.length(); ik ++) {
																  if (iwp_com_price_string.charAt(ik) != '.' && iwp_com_price_string.charAt(ik) != ',') r += iwp_com_price_string.charAt(ik);
														    }
														    iwp_com_price_string=r;
														    if(iwp_com_price_string.length()<15){
														    String tv="";
														    for(int v=0;v<(15-iwp_com_price_string.length());v++){
														    tv="0"+tv;
															  }
														    iwp_com_price_string=tv+iwp_com_price_string;
														    }
														    r="";
														    for (int iw = 0; iw < iwp_com_perc_string.length(); iw ++) {
																  if (iwp_com_perc_string.charAt(iw) != '.' && iwp_com_perc_string.charAt(iw) != ',') r += iwp_com_perc_string.charAt(iw);
														    }
														    iwp_com_perc_string=r;
														    if(iwp_com_perc_string.length()<12){
														    String tv="";
														    for(int v=0;v<(12-iwp_com_perc_string.length());v++){
														    tv="0"+tv;
															  }
														    iwp_com_perc_string=tv+iwp_com_perc_string;
														    }
														    //Overage calcs\
														    //out.println(efs_com_price_mat_grid+"*("+overage+"/"+config_price+")<BR>");
														    //double over_price=efs_com_price_mat_grid*(Double.parseDouble(overage)/config_price);
														    double over_price=lineOver*(Double.parseDouble(overage)/(config_price-nonCommission));
														    //over price
														    //iwp_com_price_string="x";
														    if(new Double(iwp_com_price_string).doubleValue() <=0){
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
														    for (int iw = 0; iw < over_price_string.length(); iw ++) {
																  if (over_price_string.charAt(iw) != '.' && over_price_string.charAt(iw) != ',') r += over_price_string.charAt(iw);
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
														    for (int iw = 0; iw < over_perc_string.length(); iw ++) {
																  if (over_perc_string.charAt(iw) != '.' && over_perc_string.charAt(iw) != ',') r += over_perc_string.charAt(iw);
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
														    //fc_value=for12.format(iwp_com_price*0.09);
														    //}
														    r="";
														    for (int iw = 0; iw < fc_value.length(); iw ++) {
																  if (fc_value.charAt(iw) != '.' && fc_value.charAt(iw) != ',') r += fc_value.charAt(iw);
														    }
														    fc_value=r;
														    if(fc_value.length()<15){
														    String tv="";
														    for(int v=0;v<(15-fc_value.length());v++){
														    tv="0"+tv;
															  }
														    fc_value=tv+fc_value;
														    }

														    //adding this to the notes line no vectors
														    line_no_text=String.valueOf(diLineCounter);
														    di_erapid_line_nos.addElement(items.elementAt(ii).toString()); di_bpcs_line_nos.addElement(line_no_text);
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
													 //for shock wave getting the tier levels
													 String bpcs_tier_line=bpcs_tier_lines.elementAt(i).toString();
													 //for shock wave getting the tier levels done
													 final_oi_out=final_oi_out+"IO"+order_no+iwp_bpcs_item+iwp_qty+iwp_price_string_up+ware_house_line+bpcs_tier_line+add_release_bpcs+ship_date+"\r\n";
													 final_ic_out=final_ic_out+"DI"+order_no+line_no_text+iwp_bpcs_item+iwp_price_string_up+rep_no+"001"+comPerc+iwp_com_price_string+"100000000000"+over_price_string+fc_value+"\r\n";
												 }
																  }//inner if statment
														    }//outer if statment
													 iwp_price=0;iwp_bpcs_item="";iwp_qty="";iwp_com_price=0;
											  }//INNER for loop// BLOCK_ID.SIZE()
										}//outer for ii<items.size()
								  }// product is IWP
								  else if(product_id.equals("LVR")){
								  }// product is LVR
								  // Getting the setup_cost
								  if(Double.parseDouble(handling_cost)>0){
										String setup_part="FREIGHT"+product_id;

	if(georder.trim().equals("GE")){
													 setup_part="GEFREIGHT";
											   }
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
										handling_cost= String.valueOf(for14.format(new Double(handling_cost).doubleValue()));
										for (int i = 0; i < handling_cost.length(); i ++) {
											   if (handling_cost.charAt(i) != '.' && handling_cost.charAt(i) != ',') r += handling_cost.charAt(i);
										}
										handling_cost=r;
										if(handling_cost.length()<14){
											   String tv="";
											   for(int v=0;v<(14-handling_cost.length());v++){
													 tv="0"+tv;
											   }
											   handling_cost=tv+handling_cost;
										}
										final_oi_out=final_oi_out+"IO"+order_no+setup_part+setup_bpcs_qty+handling_cost+ware_house_line+bpcs_tier_order+add_release_bpcs+ship_date+"\r\n";
								  }//setup cost
								  // Getting the freight_cost
								  //if(Double.parseDouble(freight_cost)>0||georder.trim().equals("GE")){
								  // as per Courtney April 2 2014
								  if(Double.parseDouble(freight_cost)>0){
											   String freight_part="MINOR"+product_id;
											   if(georder.trim().equals("GE")){
													 freight_part="GEFREIGHT";
											   }
											   //out.println("select count(*) from cs_state_codes where state_code='"+ship_state+"' and country_code='US' and taxable_freight='1'<BR>");



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
											   if(!(georder.trim().equals("GE")&&freight_part.trim().length()<=0)){
													 final_oi_out=final_oi_out+"IO"+order_no+freight_part+freight_bpcs_qty+freight_cost+ware_house_line+bpcs_tier_order+add_release_bpcs+ship_date+"\r\n";
											   }
								  }//freight cost
		//on out
		    //  order notes
		  //email acknowledgement
		  //out.println("HERE"+email_acknowledgement+"::<BR>");
		 if(email_acknowledgement != null && email_acknowledgement.equals("on")){
					 String acknowledgenote="CUST ACK TO: "+bill_email;
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
		  //end email acknowledgement


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




		 if(add_deduct_job != null && add_deduct_job.length()>0){
					 String acknowledgenote="BPCS JOB REFERENCE: "+add_deduct_job;
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
									final_on_out=final_on_out+"NO"+order_no+"000"+isti+submit_by+"\r\n";
										notesCounter++;
							  }
						    } //submittals by done
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
							  final_on_out=final_on_out+"NO"+order_no+"000"+isti+cust_oo+"\r\n";
						    notesCounter++;
				    //out.println("Test"+bpcs_cust_no);
			    }//copies requested done
			   // Additional documents
			   // Tokenizer for getting the add doc's
			   Vector docs_final=new Vector();String doc_type="";
			   if(add_docs==null){add_docs="";}
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
							  final_on_out=final_on_out+"NO"+order_no+"000"+isti+invoice_info+"\r\n";
								  notesCounter++;
							}
		// new customer 000
						    //commmented on Oct 15'08 as per Jim and Renee

											   //commmented on Oct 15'08 as per Jim and Renee

						    // for shipping notice info added on Sep'10'2008 first for EJC
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

								   }

		///for shipping notice info ended
//logger.debug("j");
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
			    }

		    if(order_notes != null && order_notes.trim().length()>0 ){
					 String cust_oo="Order notes: "+order_notes;
					 //checking for carrige returns and new lines characters
					 r="";
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

		    if(customer_notes != null && customer_notes.trim().length()>0 ){
					 String cust_oo=customer_notes;
					 //checking for carrige returns and new lines characters
					 r="";
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
											   final_on_out=final_on_out+"NO"+order_no+"000"+isti+cust_ooo+"Y"+"\r\n";
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
										final_on_out=final_on_out+"NO"+order_no+"000"+isti+cust_oo+"Y"+"\r\n";
										notesCounter++;
								   }// order seq no
			    }

			   if(bpcs_order_no==null){
					 bpcs_order_no="";
			   }

		    if((quote_origin.equals("sample")&&base_quote_no.trim().length()==0&&bpcs_order_no.trim().equals(""))||(bpcs_order_no.trim().equals("")||bpcs_order_no==null)&&((quote_origin==null)||!(quote_origin.startsWith("change")|quote_origin.startsWith("release")|quote_origin.startsWith("revision")|quote_origin.startsWith("submittal")))){
		    }
		    else{
			   final_on_out="";
			   notesCounter=0;
		    }




			    int lineCounter=0;

						    // architect is not BPCS
						    // Sections Y or N
						    // Line notes
						    String dimension="";String cuts_notches="";String logo="";String template_art="";String texture_color="";
						    String d_notes="";int lc_count=1;String qty_line="";String line_no_note="";int lp1=0;String isti="";String marks="";
								  for(int ii=0;ii<items.size();ii++){//line_items from eorderitems
										for(int ki=0;ki<di_erapid_line_nos.size();ki++){//Lines from DI erapid line nos for getting the bpcs lines
											   if(di_erapid_line_nos.elementAt(ki).toString().equals(items.elementAt(ii).toString())){
								  //di_erapid_line_nos.addElement(items.elementAt(ii).toString()); di_bpcs_line_nos.addElement(line_no_text);
		//							line_no_note=String.valueOf(Integer.parseInt(items.elementAt(ii).toString().trim())+lineIncrease);
													 line_no_note=di_bpcs_line_nos.elementAt(ki).toString();
													 if(line_no_note.length()<3){
														    String tv="";
														    for(int v=0;v<(3-line_no_note.length());v++){
														    tv="0"+tv;
														    }
														    line_no_note=tv+line_no_note;
													 }
					    for(int i=0;i<block_id.size();i++){//from csquotes
										  if(line_item.elementAt(i).toString().equals(items.elementAt(ii).toString())){
											   if( block_id.elementAt(i).toString().equals("E_DIM")){
													 String dim=desc.elementAt(i).toString().trim();
													 qty_line=QTY.elementAt(i).toString().trim();

													 int n_s=dim.indexOf("@");
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
													 dimension=qty_line+" required @ "+dimension;
													  lp1=dimension.length()/50;//di
												 if(lp1>0){
													   for(int ik=0;ik<lp1;ik++){
														    isti=String.valueOf(lc_count);
														    String tv1="";
														    for(int v=0;v<(4-isti.length());v++){tv1="0"+tv1; }
														    isti=tv1+isti;
														    final_on_out=final_on_out+"NO"+order_no+line_no_note+isti+dimension.substring(ik*50,((ik+1)*50))+"\r\n";
														    lc_count++;
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
																  final_on_out=final_on_out+"NO"+order_no+line_no_note+isti+dimension_rem+"\r\n";
																  lc_count++;
													   }
												 }
												 else{
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
												 }//dimension
											   }//e_dim
											   //mark no
											   if( block_id.elementAt(i).toString().equals("A_APRODUCT")){
													 if(mark.elementAt(i).toString().trim().length()>0){
												   //  lc_count=1;
												   marks="Mark::"+mark.elementAt(i).toString().trim();
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
													 final_on_out=final_on_out+"NO"+order_no+line_no_note+isti+marks+"\r\n";
													 lc_count++;
											   }
											   //amrk no
											   }	//line_no_note for mark only for line

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
																  final_on_out=final_on_out+"NO"+order_no+line_no_note+isti+d_notes_rem+"\r\n";
																  lc_count++;
													   }
												 }
												 else{
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
												 }	//notes

											   }//d_notes

										  }//if checking the if they are same line items.
										  isti="";

									}//for csquotes
																						isti=String.valueOf(lc_count);
																						String tv1="";
																						for(int v=0;v<(4-isti.length());v++){tv1="0"+tv1; }
		lineCounter=Integer.parseInt(line_no_note)+1;
									 lc_count=1;
									dimension="";cuts_notches="";logo="";template_art="";texture_color="";d_notes="";line_no_note="";
										}
								   }
								  }//for eorder items
		for(int y=lineCounter; y<diLineCounter; y++){
			   String line_no=String.valueOf(y);
			   String tv1="";
			   for(int v=0; v<(3-line_no.length()); v++){ tv1="0"+tv1;}
			   line_no=tv1+line_no;
		}
						    // Line Item NOtes done
		//oc out
//logger.debug("l");
		double totprice=0;double factor=0;double totprice_dis=0;double totcomm_dol=0;String com_perc="";String tot_com_dol_str="";
		String fc_value="";String fc_perc="";
								  for(int ii=0;ii<items.size();ii++){
					    for(int i=0;i<block_id.size();i++){
										  if(line_item.elementAt(i).toString().equals(items.elementAt(ii).toString())){
													 String totwt=price.elementAt(i).toString();//Extended_Price
													 String fact=fact_per.elementAt(i).toString().trim();//FIELD16
													   if ((fact.equals(""))){fact="0.0"; }
													   BigDecimal d1 = new BigDecimal(totwt);
												    BigDecimal d2 = new BigDecimal(fact);
													   BigDecimal d3 = d1.multiply(d2);
												    factor = factor+d3.doubleValue();// Line comission dollars for the line
													   totprice=totprice+d1.doubleValue();//Line materail price no comission for the line
													   totprice_dis=totprice_dis+d1.doubleValue();//Total material price for the job
													   totcomm_dol= totcomm_dol+d3.doubleValue();// Total commission dollars for the job
										  }
									}
								    factor=0;totprice=0;
								  }

			   //commission %
			   fc_value="0";
		if(quote_origin.toUpperCase().equals("SAMPLE")){
			   com_perc="0";
			   fc_perc="00.000";
		}
			   /*else if (prio.equals("E")|prio.equals("D")){//deco
			   com_perc=for19.format(((totcomm_dol/((totprice_dis-nonCommission)))*100));
			   fc_perc="00.000";

			   }*/
			   else{//cs
			   com_perc=for19.format(((totcomm_dol/((totprice_dis-nonCommision)*0.91))*100));
			   fc_perc="09.000";
			   //fc_value=for12.format(totcomm_dol*0.09);
			   }
		//overage perc


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
										else{
											quote_type="E";
										}
										if(cs_order_type.startsWith("BUY")){
											   cs_order_type="B";
											   overage_perc="100000000000"; // changed as per Charlie on Dec 12 2009

										}
										else{
											   cs_order_type="R";
											   overage_perc="000000000000";
										}
		 //					if(rep_no.trim().length()==3){cs_doc_type="B";}else{cs_doc_type="R";}
								   //if(cs_order_type.startsWith("BUY")){cs_order_type="B";}else{cs_order_type="R";}
		//if(isGood){
			   final_oc_out=final_oc_out+"CO"+order_no+com_perc+tot_com_dol_str+overage_str+fc_perc+fc_value+rep_no+"001"+"100000000000"+tot_com_dol_str+overage_perc+overage_str+order_no+" "+quote_type+"000000"+cs_order_type+"100"+"\r\n";
			   //ic out
			   //final out
		//String url="WS"+order_no+"http://"+application.getInitParameter("HOST")+"/erapid/us/orders/ows/order_sheet.jsp?sections="+si+"&order_no="+order_no+"&rep_no="+thisRep;
			   String url="WS"+order_no+"http://ims.c-sgroup.com/go.asp?APPA=CS&SUBJ=NEWORDERS"+"&REPNO="+thisRep+"&KEY="+product_id+order_no+"\r\n";
			   //String url="WS"+order_no+"http://ims.c-sgroup.com/go.asp?APPA=TESTCS&SUBJ=NEWORDERS"+"&KEY="+product_id+order_no;
		%>
		<%@ include file="order_transfer_bpcs_ds.jsp"%>
		<%
										   final_out=final_oh_out+final_os_out+final_oi_out+final_on_out+final_oc_out+final_ic_out;
										    final_out=final_out.toUpperCase()+url+final_ds_out;

										    if(bpcs_order_no == null){
													   bpcs_order_no="";
												}
												if(quote_origin==null){
													   quote_origin="";
												}
												//out.println("::"+base_quote_no+"::");

				//if((quote_origin.equals("sample")&&base_quote_no.trim().length()==0&&bpcs_order_no.trim().equals(""))||(bpcs_order_no.trim().equals("")||bpcs_order_no==null)&&((quote_origin==null)||!(quote_origin.startsWith("change")|quote_origin.startsWith("release")|quote_origin.startsWith("revision")|quote_origin.startsWith("submittal")))){
				if(!(order_type.startsWith("ADD")&&bpcs_order_no.trim().length()>0)){
					final_out=final_oh_out+final_os_out+final_oi_out+final_on_out+final_oc_out+final_ic_out;
					   final_out=final_out.toUpperCase()+url+final_ds_out;
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

					   dir_path="\\\\lebhq-erusdev\\TRANSFER\\BPCS_OEA\\";
					   dir_path1="\\\\lebhq-erusdev\\TRANSFER\\BPCS_OEA\\testing\\";
				}
				if(base_quote_no==null|| base_quote_no.trim().length()==0){
					   base_quote_no=order_no;
				}
				String tempend2=base_quote_no.substring(6,9);

				if(!(order_type.startsWith("ADD"))){
					base_quote_no=order_no;
					tempend2=order_no.substring(6,9);
				}
				 BufferedWriter out1 = new BufferedWriter(new FileWriter(dir_path+"\\"+"O"+order_no.substring(0,6)+tempend2+".txt"));
				 out1.write(final_out);

										   out.flush();
										   out1.flush();
										   out1.close();
										  out.println(".......Output file created successfully for eRapid Order... "+order_no+"<br><br><br>");
										  //writing the output to second folder also
										   BufferedWriter out2 = new BufferedWriter(new FileWriter(dir_path1+"\\"+"O"+order_no+".txt"));
										   out2.write(final_out);
										   out2.flush();
										   out2.close();

				//}
				//else{
				//	out.println("We have encountered an error matching up to PSA please contact CS Group to resolve issue<BR>");
				//}

				//sending the bills and routings added on May-26'09
				//1) bills transfer start here
								    Vector erapid_quote_line=new Vector();Vector bpcs_parent=new Vector();Vector bpcs_child=new Vector();Vector bpcs_child_qty=new Vector();
								    Vector bpcs_over_ride=new Vector();Vector bpcs_scrap_factor=new Vector();Vector bpcs_op_no=new Vector();Vector bpcs_comp_ucode=new Vector();
								    Vector bpcs_parent_qty=new Vector();Vector bpcs_seq=new Vector();
								    dir_path="\\\\lebhq-erusdev\\TRANSFER\\BPCS_BOM\\";String final_bom_out="";String final_rou_out="";dir_path1="\\\\lebhq-erusdev\\TRANSFER\\BPCS_BOM\\test\\";
								    out.println("BOM's transfer start......<br>");
								    ResultSet rs_mbm = stmt.executeQuery("SELECT * FROM cs_bpcs_mbm where doc_number like '"+order_no+"' and doc_line in ("+lines_final+") and not bprod is null and not bprod='' order by cast(doc_line as integer)");
								    if (rs_mbm !=null) {
										while (rs_mbm.next()){
											erapid_quote_line.addElement(rs_mbm.getString ("doc_line"));
											bpcs_seq.addElement(rs_mbm.getString ("BSEQ"));
											bpcs_parent.addElement(rs_mbm.getString ("BPROD"));
											bpcs_child.addElement(rs_mbm.getString ("BCHLD"));
											bpcs_child_qty.addElement(rs_mbm.getString ("BQREQ"));
											bpcs_over_ride.addElement(rs_mbm.getString ("BMISS"));
											bpcs_scrap_factor.addElement(rs_mbm.getString ("BMSCP"));
											bpcs_op_no.addElement(rs_mbm.getString ("BOPNO"));
											bpcs_comp_ucode.addElement(rs_mbm.getString ("BUSC"));
											bpcs_parent_qty.addElement(rs_mbm.getString ("PQTY"));
										}
								    }
								    rs_mbm.close();
									for(int im=0;im<bpcs_parent.size();im++){
								    //final count
										  String final_count=im+1+"";
										  if(final_count.length()<3){
												String tv="";
												for(int v=0;v<(3-final_count.length());v++){
												tv=tv+"0";
											 }
												final_count=tv+final_count;
										  }
									//bpcs seq
									 String seq=bpcs_seq.elementAt(im).toString();
										  if(seq.length()<3){
												String tv="";
												for(int v=0;v<(3-seq.length());v++){
												tv=tv+"0";
											 }
												seq=tv+seq;
										  }
									//parent item
									String parent=bpcs_parent.elementAt(im).toString();
										  if(parent.length()<15){
												String tv="";
												for(int v=0;v<(15-parent.length());v++){
												tv=tv+" ";
											 }
												parent=parent+tv;
										  }
								    // Child item
										   String child=bpcs_child.elementAt(im).toString();
												if(child.length()<15){
													   String tv="";
													   for(int v=0;v<(15-child.length());v++){
													   tv=tv+" ";
												    }
													   child=child+tv;
												}
								    //child qty
												String child_qty=bpcs_child_qty.elementAt(im).toString();
												r="";
												for (int ii = 0; ii < child_qty.length(); ii ++) {
													   if (child_qty.charAt(ii) != '.' && child_qty.charAt(ii) != ',') r += child_qty.charAt(ii);
												}
												child_qty=r;
												if(child_qty.length()<15){
													   String tv="";
													   for(int v=0;v<(15-child_qty.length());v++){
													   tv="0"+tv;
													   }
													   child_qty=tv+child_qty;
												}
								    //override
								    String over_ride=bpcs_over_ride.elementAt(im).toString().trim();
								    if(over_ride.trim().length()<=0){over_ride=" ";}
								    //line_no
										  String erapid_line_no=erapid_quote_line.elementAt(im).toString();
										  if(erapid_line_no.length()<3){
												String tv="";
												for(int v=0;v<(3-erapid_line_no.length());v++){
												tv=tv+"0";
											 }
												erapid_line_no=tv+erapid_line_no;
										  }
								    //scrap factor
										  String scrap_factor=bpcs_scrap_factor.elementAt(im).toString();
										  r="";
										  for (int ii = 0; ii < scrap_factor.length(); ii ++) {
												if (scrap_factor.charAt(ii) != '.' && scrap_factor.charAt(ii) != ',') r += scrap_factor.charAt(ii);
										  }
										  scrap_factor=r;
										  if(scrap_factor.length()<5){
												String tv="";
												for(int v=0;v<(5-scrap_factor.length());v++){
												tv="0"+tv;
												}
												scrap_factor=tv+scrap_factor;
										  }
							 //op.no
							 String op_no=bpcs_op_no.elementAt(im).toString().trim();
							 if(op_no.length()<3){
								    String tv="";
								    for(int v=0;v<(3-op_no.length());v++){
								    tv="0"+tv;
								}
								    op_no=tv+op_no;
							 }
							 //component u.code
								    String comp_ucode=bpcs_comp_ucode.elementAt(im).toString().trim();
								    if(comp_ucode.trim().length()<=0){comp_ucode=" ";}
							 //parent qty
								    String parent_qty=bpcs_parent_qty.elementAt(im).toString().trim();
								    r="";
								    for (int ii = 0; ii < parent_qty.length(); ii ++) {
										  if (parent_qty.charAt(ii) != '.' && parent_qty.charAt(ii) != ',') r += parent_qty.charAt(ii);
								    }
								    parent_qty=r;
								    if(parent_qty.length()<11){
										  String tv="";
										  for(int v=0;v<(11-parent_qty.length());v++){
										  tv="0"+tv;
										  }
										  parent_qty=tv+parent_qty;
								    }
								    String optimized_flag=" ";
								    ResultSet rs_opt = stmt.executeQuery("SELECT optimizer_no FROM cs_optimizer where order_no like '"+order_no+"' and line_no ='"+erapid_quote_line.elementAt(im).toString()+"' and model ='"+parent.trim()+"' ");
								    if(rs_opt != null){
										  while(rs_opt.next()){
												if(rs_opt.getString("optimizer_no")!=null&&rs_opt.getString("optimizer_no").trim().length()>0 ){
													   optimized_flag="Y";
												}
										  }
								    }
								    rs_opt.close();
										  final_bom_out=final_bom_out+seq+"MU"+parent+child+child_qty+"  "+over_ride+ware_house_header+"000000"+order_no.trim()+erapid_line_no+scrap_factor+op_no+comp_ucode+parent_qty+optimized_flag+"\r\n";
									}//for loop ends

								    //BOM out put to text files
									BufferedWriter out_bom = new BufferedWriter(new FileWriter(dir_path+"\\"+"B"+order_no.trim()+".txt"));
									out_bom.write(final_bom_out);
									out.println("BOM transfer done "+"<br>");
									out.flush();
									out_bom.flush();
									out_bom.close();
								    //out put to text files done
								    //outputting to second folder
									BufferedWriter out_bom1 = new BufferedWriter(new FileWriter(dir_path1+"\\"+"B"+order_no+".txt"));
										   out_bom1.write(final_bom_out);
										   out_bom1.flush();
										   out_bom1.close();


				//Routings out put start
					   dir_path="\\\\lebhq-erusdev\\TRANSFER\\BPCS_ROU\\";dir_path1="\\\\lebhq-erusdev\\TRANSFER\\BPCS_ROU\\test\\";
					   out.println("ROU's transfer start......<br>");
					   Vector bpcs_rou_parent=new Vector();Vector bpcs_rou_op_no=new Vector();Vector bpcs_rou_op_desc=new Vector();Vector bpcs_rou_work_ctr=new Vector();
					   Vector bpcs_rou_bcode=new Vector();Vector bpcs_rou_rlab=new Vector();Vector bpcs_rou_rset=new Vector();	Vector bpcs_rou_whs=new Vector();
					   Vector erapid_rou_quote_line=new Vector();Vector bpcs_rou_mhrs=new Vector();Vector bpcs_run_ops=new Vector();
					   Vector bpcs_rmove=new Vector();Vector bpcs_rque=new Vector();Vector bpcs_rstyd=new Vector();
					   Vector bpcs_rsoup=new Vector();Vector bpcs_rtrtem=new Vector();Vector bpcs_rtoflg=new Vector();
					   Vector bpcs_rsbas=new Vector();Vector bpcs_rcold=new Vector();Vector bpcs_rtoutc=new Vector();
					   ResultSet rs_frt = stmt.executeQuery("SELECT * FROM cs_bpcs_frt where doc_number like '"+order_no+"' and doc_line in ("+lines_final+") order by cast(doc_line as integer)");
					   if (rs_frt !=null) {
					   while (rs_frt.next()){
							 erapid_rou_quote_line.addElement(rs_frt.getString ("doc_line"));
							 bpcs_rou_parent.addElement(rs_frt.getString ("RPROD"));
							 bpcs_rou_op_no.addElement(rs_frt.getString ("ROPNO"));
							 bpcs_rou_op_desc.addElement(rs_frt.getString ("ROPDS"));
							 bpcs_rou_work_ctr.addElement(rs_frt.getString ("RWRKC"));
							 bpcs_rou_bcode.addElement(rs_frt.getString ("RBAS"));
							 bpcs_rou_rlab.addElement(rs_frt.getString ("RLAB"));
							 bpcs_rou_rset.addElement(rs_frt.getString ("RSET"));
							 bpcs_rou_whs.addElement(rs_frt.getString ("RTWHS"));
							 bpcs_rou_mhrs.addElement(rs_frt.getString ("RMAC"));
							 bpcs_run_ops.addElement(rs_frt.getString ("ROPER"));
							 bpcs_rmove.addElement(rs_frt.getString ("RMOVE"));
							 bpcs_rque.addElement(rs_frt.getString ("RQUE"));
							 bpcs_rstyd.addElement(rs_frt.getString ("RSTYD"));
							 bpcs_rsoup.addElement(rs_frt.getString ("RSUOP"));
							 bpcs_rtrtem.addElement(rs_frt.getString ("RTRTEM"));
							 bpcs_rtoflg.addElement(rs_frt.getString ("RTOFLG"));
							 bpcs_rsbas.addElement(rs_frt.getString ("RSBAS"));
							 bpcs_rcold.addElement(rs_frt.getString ("RCOLD"));
							 bpcs_rtoutc.addElement(rs_frt.getString ("RTOUTC"));


					   }
					   }
					   rs_frt.close();
					    for(int im=0;im<bpcs_rou_parent.size();im++){
							 //final count
								    String final_count=im+1+"";
								    if(final_count.length()<3){
										  String tv="";
										  for(int v=0;v<(3-final_count.length());v++){
										  tv=tv+"0";
									   }
										  final_count=tv+final_count;
								    }
							 //parent item
							  String parent=bpcs_rou_parent.elementAt(im).toString();
								    if(parent.length()<15){
										  String tv="";
										  for(int v=0;v<(15-parent.length());v++){
										  tv=tv+" ";
									   }
										  parent=parent+tv;
								    }
								    //op.no
								    String op_no=bpcs_rou_op_no.elementAt(im).toString().trim();
								    if(op_no.length()<3){
										  String tv="";
										  for(int v=0;v<(3-op_no.length());v++){
										  tv="0"+tv;
									   }
										  op_no=tv+op_no;
								    }
								    //op.desc
								    String op_desc=bpcs_rou_op_desc.elementAt(im).toString().trim();
								    if(op_desc.length()<30){
										  String tv="";
										  for(int v=0;v<(30-op_desc.length());v++){
										  tv=tv+" ";
									   }
										  op_desc=op_desc+tv;
								    }
								    //work center
								    String work_ctr=bpcs_rou_work_ctr.elementAt(im).toString().trim();
								    if(work_ctr.length()<6){
										  String tv="";
										  for(int v=0;v<(6-work_ctr.length());v++){
										  tv="0"+tv;
									   }
										  work_ctr=tv+work_ctr;
								    }
								    //basis code
								    String bcode=bpcs_rou_bcode.elementAt(im).toString().trim();
								    if(bcode.trim().length()<=0){bcode=" ";}
							 //run hrs
								    String run_hrs=bpcs_rou_rlab.elementAt(im).toString();
								    r="";
								    for (int ii = 0; ii < run_hrs.length(); ii ++) {
										  if (run_hrs.charAt(ii) != '.' && run_hrs.charAt(ii) != ',') r += run_hrs.charAt(ii);
								    }
								    run_hrs=r;
								    if(run_hrs.length()<8){
										  String tv="";
										  for(int v=0;v<(8-run_hrs.length());v++){
										  tv="0"+tv;
										  }
										  run_hrs=tv+run_hrs;
								    }
							 //setup hrs
								    String set_hrs=bpcs_rou_rset.elementAt(im).toString();
								    r="";
								    for (int ii = 0; ii < set_hrs.length(); ii ++) {
										  if (set_hrs.charAt(ii) != '.' && set_hrs.charAt(ii) != ',') r += set_hrs.charAt(ii);
								    }
								    set_hrs=r;
								    if(set_hrs.length()<8){
										  String tv="";
										  for(int v=0;v<(8-set_hrs.length());v++){
										  tv="0"+tv;
										  }
										  set_hrs=tv+set_hrs;
								    }
							 // ware house
								    String whs=bpcs_rou_whs.elementAt(im).toString().trim();
								    if(whs.trim().length()<=0){whs="  ";}
							 //line_no
								    String erapid_line_no=erapid_rou_quote_line.elementAt(im).toString();
								    if(erapid_line_no.length()<3){
										  String tv="";
										  for(int v=0;v<(3-erapid_line_no.length());v++){
										  tv=tv+"0";
									   }
										  erapid_line_no=tv+erapid_line_no;
								    }
							 //machine hrs
								    String mach_hrs=bpcs_rou_mhrs.elementAt(im).toString();
								    r="";
								    for (int ii = 0; ii < mach_hrs.length(); ii ++) {
										  if (mach_hrs.charAt(ii) != '.' && mach_hrs.charAt(ii) != ',') r += mach_hrs.charAt(ii);
								    }
								    mach_hrs=r;
								    if(mach_hrs.length()<8){
										  String tv="";
										  for(int v=0;v<(8-mach_hrs.length());v++){
										  tv="0"+tv;
										  }
										  mach_hrs=tv+mach_hrs;
								    }
							 //run ops
								    String run_ops=bpcs_run_ops.elementAt(im).toString();
								    if(run_ops.length()<3){
										  String tv="";
										  for(int v=0;v<(3-run_ops.length());v++){
												tv="0"+tv;
									   }
										  run_ops=tv+run_ops;
								    }
								    //move time
							 String move_time=bpcs_rmove.elementAt(im).toString();
							 r="";
							 for (int ii = 0; ii < move_time.length(); ii ++) {
								    if (move_time.charAt(ii) != '.' && move_time.charAt(ii) != ',') r += move_time.charAt(ii);
							 }
							 move_time=r;
							 if(move_time.length()<6){
								    String tv="";
								    for(int v=0;v<(6-move_time.length());v++){
								    tv="0"+tv;
								    }
								    move_time=tv+move_time;
							 }
							 //queue time
							 String que_time=bpcs_rque.elementAt(im).toString();
							 r="";
							 for (int ii = 0; ii < que_time.length(); ii ++) {
								    if (que_time.charAt(ii) != '.' && que_time.charAt(ii) != ',') r += que_time.charAt(ii);
							 }
							 que_time=r;
							 if(que_time.length()<6){
								    String tv="";
								    for(int v=0;v<(6-que_time.length());v++){
								    tv="0"+tv;
								    }
								    que_time=tv+que_time;
							 }
				//yield
							 String yield=bpcs_rstyd.elementAt(im).toString();
							 r="";
							 for (int ii = 0; ii < yield.length(); ii ++) {
								    if (yield.charAt(ii) != '.' && yield.charAt(ii) != ',') r += yield.charAt(ii);
							 }
							 yield=r;
							 if(yield.length()<7){
								    String tv="";
								    for(int v=0;v<(7-yield.length());v++){
								    tv="0"+tv;
								    }
								    yield=tv+yield;
							 }
				//setup operts
							 String setup_ops=bpcs_rsoup.elementAt(im).toString();
							 if(setup_ops.length()<3){
								    String tv="";
								    for(int v=0;v<(3-setup_ops.length());v++){
								    tv="0"+tv;
								}
								    setup_ops=tv+setup_ops;
							 }
				//mfg.mtd.routing code
							 String routing_code=bpcs_rtrtem.elementAt(im).toString();
							 if(routing_code.length()<2){
								    String tv="";
								    for(int v=0;v<(2-routing_code.length());v++){
								    tv=tv+" ";
								}
								    routing_code=tv+routing_code;
							 }
				//inside/outside flag
							 String is_os_flag=bpcs_rtoflg.elementAt(im).toString().trim();
							 if(is_os_flag.trim().length()<=0){is_os_flag=" ";}
				//setup basis code
							 String sp_bcode=bpcs_rsbas.elementAt(im).toString().trim();
							 if(sp_bcode.trim().length()<=0){sp_bcode=" ";}
				//collect data this oper.
							 String rcold=bpcs_rcold.elementAt(im).toString().trim();
							 if(rcold.trim().length()<=0){rcold=" ";}
				//outside cost
							 String os_cost=bpcs_rtoutc.elementAt(im).toString();
							 r="";
							 for (int ii = 0; ii < os_cost.length(); ii ++) {
								    if (os_cost.charAt(ii) != '.' && os_cost.charAt(ii) != ',') r += os_cost.charAt(ii);
							 }
							 os_cost=r;
							 if(os_cost.length()<15){
								    String tv="";
								    for(int v=0;v<(15-os_cost.length());v++){
								    tv="0"+tv;
								    }
								    os_cost=tv+os_cost;
							 }
				//done with the vars

					    final_rou_out=final_rou_out+"R"+parent+final_count+"000000"+op_no+op_desc+work_ctr+bcode+run_hrs+set_hrs+whs+"   "+order_no.trim()+erapid_line_no+mach_hrs+run_ops+move_time+que_time+yield+setup_ops+routing_code+is_os_flag+sp_bcode+rcold+os_cost+"\r\n";
					    }//for loop ends
					   //ROU out put to text files
					    BufferedWriter out_rou = new BufferedWriter(new FileWriter(dir_path+"\\"+"R"+order_no.trim()+".txt"));
					    out_rou.write(final_rou_out);
					    out.println("ROU transfer done "+"<br>");
					    out.flush();
					    out_rou.flush();
					    out_rou.close();
					   //outputting to second folder
					    BufferedWriter out_rou1 = new BufferedWriter(new FileWriter(dir_path1+"\\"+"R"+order_no+".txt"));
							  out_rou1.write(final_rou_out);
							  out_rou1.flush();
							  out_rou1.close();

							//HttpSession UserSession1 = request.getSession();
							//String name=UserSession1.getAttribute("username").toString();



		String name=request.getParameter("userId");

							String to="";
																    ResultSet rs_rep=stmt.executeQuery("select  TOP 1 email from cs_reps where rep_no='"+thisRep+"' and user_id in('"+name+"','') ORDER BY user_id DESC");
																  // out.println("select  TOP 1 email from cs_reps where rep_no='"+thisRep+"' and user_id in('"+name+"','') ORDER BY user_id DESC<BR>");
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
		if(to==null){
			to="";
		}
		to="hmushyam@c-sgroup.com";
																    String message="Thank you for the order.";
								    //getting the customer service contact info.
								    String cust_serv_cont="";
								    if(market.equals("DL")){product_id="DECOLINK";}
								    ResultSet rs_emails=stmt.executeQuery("Select contact_name from cs_sbu_contacts where product_id ='"+product_id+"' and optio_email = '"+email_to.trim()+"' order by rep_no");
								    if(rs_emails != null){
										  while(rs_emails.next()){
												cust_serv_cont=rs_emails.getString("contact_name");
										  }
								    }
								    rs_emails.close();
								    //getting the customer service contact done.
									String messageForMail="";
		%>

<form name='selectform' method='post'>
			<input type="hidden" name="order_no" value="<%=order_no%>">
			<input type="hidden" name="rep_no" value="<%=thisRep%>">
			<input type="hidden" name="to" value="<%=to%>">
			<input type="hidden" name="userId" value="<%=userId%>">
			<input type="hidden" name="from" value="Erapid_Order_<%=order_no%>_confirmation@c-sgroup.com">
			<input type="hidden" name="cc" value="">
			<% if(email_to.trim().length()<=0){
				messageForMail="Thank you for your order. Your Erapid Order:"+order_no+" successfully transferred. A Construction Specialties, Inc. Customer service representative will contact you with further details.";
				%>
			<input type="hidden" name="message" value="Thank you for your order. Your Erapid Order:<%=order_no%> successfully transferred. A Construction Specialties, Inc. Customer service representative will contact you with further details.">
			<input type="hidden" name="message1" value="A Construction Specialties, Inc Customer service representative will contact you with further details.">
			<%
									}else{
										messageForMail="Thank you for your order. Your Erapid Order:"+order_no+" successfully transferred. Your Construction Specialties, Inc. Customer service representative: "+cust_serv_cont+" ("+email_to.trim()+") will contact you with further details.";
										%>
			<input type="hidden" name="message" value="Thank you for your order. Your Erapid Order:<%=order_no%> successfully transferred. Your Construction Specialties, Inc. Customer service representative: <%=cust_serv_cont%> (<%=email_to.trim()%>) will contact you with further details.">
			<input type="hidden" name="message1" value="Your Construction Specialties, Inc Customer service representative:<b> <%=cust_serv_cont%></b> (<%=email_to.trim()%>) will contact you with further details.">
			<%}
			%>

		</form>

		<% if(!quote_origin.equals("sample")){%>
	<%@ include file="order_acknowledgement_email.jsp"%>
	<% 
	 //out.println("End of Transfer please close your browser window "+"<br>");
		} %>
<%@ include file="mail.delivery2.jsp"%>

		
		<%
					//email logging

				  //email logging done
				  //myConn.commit();
						
				  }
				  catch(Exception e){
							//Updating Sections to clear transfer added by praveen for exception handling on order transfers.

							String sectionGroup = "", sectionTransfer = "", sectionsChecked = "", sectionInfo = "";
							int sectionsDB = 0;
							ResultSet rs_sections = stmt.executeQuery(
									"Select sections,section_group,section_transfer,sections_checked,section_info from cs_quote_sections where order_no ='"
											+ order_no + "'");
							if (rs_sections != null) {
								while (rs_sections.next()) {
									sectionsDB = rs_sections.getInt("sections");
									sectionGroup = rs_sections.getString("section_group");
									sectionTransfer = rs_sections.getString("section_transfer");
									sectionsChecked = rs_sections.getString("sections_checked");
									sectionInfo = rs_sections.getString("section_info");
								}
							}
							rs_sections.close();
							//out.println(sectionsDB+" , "+sectionGroup+" , "+sectionTransfer+" , "+sectionsChecked+" , "+sectionInfo);
							String sectionsEx = request.getParameter("sections");
							if (sectionsDB < 2 && sectionsEx.equals("s1,")) {
								String updateSectionString = "update cs_quote_sections set section_transfer='',sections_checked='' where order_no='"
										+ order_no + "' ";
								java.sql.PreparedStatement updateStatForSections = myConn.prepareStatement(updateSectionString);

								int rocount = updateStatForSections.executeUpdate();
								updateStatForSections.close();

							} else {
								String sectionTransUpdate = sectionTransfer, sectionsCheckedUpdate = sectionsChecked;
								String[] sectTransfer = sectionTransfer.split(";");
								String[] sectionsFailed = sectionsEx.split(",");
								//using java foreach loop to print elements of string array 
								for (String s : sectionsFailed) {
									for (String t : sectTransfer) {
										if (t.startsWith(s)) {
											//out.println("<br>"+t); 
											//out.println("<br>"+s); 
											sectionTransUpdate = sectionTransUpdate.replace(t + ";", "");
											sectionsCheckedUpdate = sectionsCheckedUpdate.replace(s + ",", "");
										} else {
											//sectionTransUpdate=sectionTransUpdate+t+";";
										}
									}

								}
								//out.println("<br>"+sectionTransUpdate);
								//out.println("<br>"+sectionsCheckedUpdate);

								String updateSectionString = "update cs_quote_sections set section_transfer='"
										+ sectionTransUpdate + "',sections_checked='" + sectionsCheckedUpdate
										+ "' where order_no='" + order_no + "' ";
								java.sql.PreparedStatement updateStatForSections = myConn.prepareStatement(updateSectionString);

								int rocount = updateStatForSections.executeUpdate();
								updateStatForSections.close();

							}

							java.util.Date errorDate = new java.util.Date();
							String updateString = "INSERT INTO cs_bpcs_transfer_error_log (order_no,user_id,transfer_time,error_text)VALUES(?,?,?,?) ";
							java.sql.PreparedStatement updateError = myConn.prepareStatement(updateString);
							updateError.setString(1, order_no);
							updateError.setString(2, thisRep);
							updateError.setString(3, "" + errorDate);
							updateError.setString(4, "" + e);
							int rocount2 = updateError.executeUpdate();
							updateError.close();
							out.println("<font size='5' color='red'>TRANSFER ERROR.  Please contact factory for help.<BR>" + e);
							if (sectionsDB < 2 && sectionsEx.equals("s1,")) {
								out.println(
										"<script>alert('Order transfer failed. Please try again or contact factory for help')</script>");
							} else {
								out.println("<script>alert('Order transfer failed for sections " + sectionsEx
										+ ". Please try again or contact factory for help')</script>");
							}
							out.println("<script>document.getElementById('order_sheet').disabled = true;</script>");
						}
				%>

			

	</body>
</html>
<%
stmt.close();
  myConn.close();
}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>