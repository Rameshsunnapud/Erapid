
<%



%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
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
			closeTime+=4;  // This number is how long the window stays open
			// Timer();
			var url="mail.delivery2.jsp?order_no="+document.selectform.order_no.value+"&to="+document.selectform.to.value+"&from="+document.selectform.from.value+"&message="+document.selectform.message.value+"&cc=&sections=all&rep_no="+document.selectform.rep_no.value+"&name="+document.selectform.userId.value;
			var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=450,height=200';
			//my_window= window.open (url,"mywindow1",props);

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
	</SCRIPT>
	<body onload="poponload()">
		
		<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.lang.*" import="java.io.*" import="java.text.*" import="java.math.*" errorPage="error.jsp" %>
		<%@ include file="db_con.jsp"%>
		<%@ include file="dbcon1.jsp"%>
		<%@ include file="db_con_bpcsusrmm.jsp"%>
		<%
		int lineIncrease=0;
		String order_no = request.getParameter("order");
		String si = request.getParameter("sections");
		String userId=request.getParameter("userId");
		String thisRep=request.getParameter("rep_no");
		String doc_priority=request.getParameter("doc_priority");
		String bpcsTransferSheet = request.getParameter("bpcsTransferSheet");
		String order_sheet_url = request.getParameter("order_sheet_url");
		//out.println("order sheet url : "+order_sheet_url);
		//order_sheet_url = order_sheet_url + "&userId="+userId+ "&bpcsTransferSheet="+bpcsTransferSheet+ "&sections="+si+ "&rep_no="+thisRep;
								String environment = request.getParameter("environment");
								try{
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
		
		Vector bpcs_lines=new Vector();
		Vector erapid_bpcs_lines=new Vector();
		boolean isGood=true;
		%>
		<%//@ include file="../../../db_con_psa.jsp"%>
		<%
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
		DecimalFormat for13 = new DecimalFormat("###.###");
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
		String dir_path1="\\\\lebhq-erusdev\\TRANSFER\\BPCS_OE\\testing\\GE\\";
		String section_group="";Vector si_final = new Vector();Vector li_final = new Vector();String Project_name="";String product_id="";String lines_final = "";
		String overage="0";String freight_cost="0";String handling_cost="0";String setup_cost="0";double config_price=0;double total_sale_price=0;
		String rep_no="";String quote_type="";String psa_quote_id="";String bpcs_tier_order="";String free_text="";
		String tax_exempt="";
		//reteriving the lines from the sections
		out.println(".......Out put transfer to CS order system BPCS started....... <br><br><br>");
		ResultSet rs_find = stmt.executeQuery("SELECT * FROM cs_quote_sections where order_no like '"+order_no+"'");
		if (rs_find !=null) {
			while (rs_find.next()){
				section_group=rs_find.getString ("section_group");
			}
		}
		rs_find.close();
		// Project info
		String sales_tax_code="";
		ResultSet rs_project = stmt.executeQuery("SELECT * FROM cs_project where Order_no like '"+order_no+"' ");
		if (rs_project !=null) {
			while (rs_project.next()) {
				tax_exempt=rs_project.getString("tax_exempt");
				Project_name= rs_project.getString("Project_name");
				product_id= rs_project.getString("product_id");
				if(product_id.equals("EJC")){product_id="TPG";}
				rep_no=rs_project.getString("creator_id");
				overage= rs_project.getString("overage");
				if(rs_project.getString("freight_cost")!= null ){
					freight_cost=rs_project.getString("freight_cost");
				}
				if(rs_project.getString("handling_cost")!= null ){
					handling_cost= rs_project.getString("handling_cost");
				}
				if(rs_project.getString("setup_cost")!= null ){
					setup_cost= String.valueOf(for14.format(new Double(rs_project.getString("setup_cost")).doubleValue()));
				}
				quote_type=rs_project.getString("project_type");
				if(!(quote_type != null)){
					quote_type="";
				}
				sales_tax_code=rs_project.getString("tax_code");
				psa_quote_id=rs_project.getString("project_type_id");
				bpcs_tier_order=rs_project.getString("bpcs_tier");
				free_text=rs_project.getString("free_text");
			}
		}
		rs_project.close();

		if(tax_exempt==null){
			tax_exempt="";
		}
		if(bpcs_tier_order==null){bpcs_tier_order="0";}
		if(sales_tax_code==null){sales_tax_code="";}
		//Tokenizer for breaking the sECTIONS
		StringTokenizer st=new StringTokenizer(si,",");
		while (st.hasMoreTokens()){
			si_final.addElement(st.nextToken());
		}
		// Tokenizer for getting the line no's
		StringTokenizer st1=new StringTokenizer(section_group,";");
		while (st1.hasMoreTokens()){
			li_final.addElement(st1.nextToken());
		}
		//getting lines
		String km="";
		for(int k=0;k<si_final.size();k++){ //s1
			for(int kl=0;kl<li_final.size();kl++){//1=s1
				km=li_final.elementAt(kl).toString();
				if(km.endsWith(si_final.elementAt(k).toString())){
					if(lines_final.length()==0){
						lines_final=lines_final+km.substring(0,km.indexOf("="));
					}
					else{
						lines_final=lines_final+","+km.substring(0,km.indexOf("="));
					}
				}
			}
		}
		//doc_line
		// Checking the no of lines
		Vector items=new Vector();
		ResultSet rs1 = stmt.executeQuery("SELECT doc_line FROM doc_line where doc_number like '"+order_no+"' order by cast(doc_line as integer)");
		while ( rs1.next() ) {
			items.addElement(rs1.getString("doc_line"));
		}
		rs1.close();
		// Checking the no of lines	done
		//doc_line end
		//CS_QUOTES<br>
		double nonCommision=0.0;
		Vector QTY=new Vector();Vector price=new Vector();Vector line_item=new Vector();Vector desc=new Vector();
		Vector rec_no=new Vector();Vector fact_per=new Vector();Vector mark=new Vector();Vector block_id=new Vector();Vector bpcs_part_no=new Vector();
		Vector bpcs_qty=new Vector();Vector bpcs_tier_lines=new Vector();Vector line_product_id=new Vector();Vector line_whse=new Vector();
		String largestLine="";double largestPrice=0.0;int counterLarge=0;int indexLarge=-1;int diLineCounter=1;
Vector lineComm=new Vector();
		double nonCommission=0;String special_cut="N";String ge_prod_iwp="N";String ge_prod_efs="N";String ge_prod_ge="N";
		ResultSet rs3 = stmt.executeQuery("SELECT * FROM csquotes where order_no like '"+order_no+"' and line_no in ("+lines_final+") order by cast(Line_no as integer)");
		while ( rs3.next() ) {
			line_item.addElement(rs3.getString ("Line_no"));
			desc.addElement(rs3.getString ("Descript"));
			price.addElement(rs3.getString ("Extended_Price"));
			if(rs3.getString("wdth")!= null && rs3.getString("wdth").trim().length()>0 && (! rs3.getString("wdth").trim().equals("0"))){
				lineComm.addElement(rs3.getString("wdth"));
			}
			else{
				lineComm.addElement("0");
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
			if(rs3.getString("product_id").equals("IWP")){
				ge_prod_iwp="Y";
			}else if(rs3.getString("product_id").equals("EFS")){
				ge_prod_efs="Y";
			}else{
				ge_prod_ge="Y";
			}
			line_product_id.addElement(rs3.getString ("product_id"));
			if(rs3.getString("whse") != null && rs3.getString("whse").trim().length()>0){
				line_whse.addElement(rs3.getString("whse").trim());
			}else{line_whse.addElement("");	}
			counterLarge++;
		}
		rs3.close();
		total_sale_price=config_price+Double.parseDouble(overage)+Double.parseDouble(handling_cost)+Double.parseDouble(freight_cost)+Double.parseDouble(setup_cost);
		//billing customer
//out.println("1");
		String cust_name1="";String cust_addr1="";String cust_addr2="";String city="";String state="";String zip_code="";
		String phone="";String fax="";String contact_name="";String customer_po_no="";String payment_terms="";String bpcs_cust_no="";
		String invoice_info="";String cs_order_type="";String order_rep_no="";String sales_region="";String email_acknowledgement="";String bill_email="";String bill_alt_no="";
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
				bill_alt_no=rs_bill.getString("alt_no");
			}
		}
		rs_bill.close();
		if(sales_region==null){
			sales_region="";
		}
		if(email_acknowledgement==null){
			email_acknowledgement="";
		}
		if(bill_alt_no==null){
			bill_alt_no="";
		}
		if(bill_email==null){
			bill_email="";
		}
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
		//getting rep_no from cs_billed done
		//Shipping
		//Ship variables
		String ship_to_customer="000000";
		String invoice_customer="000000";
		String ship_name="";String ship_addr1="";String ship_addr2="";String ship_city="";String ship_state="";
		String ship_zip="";String ship_phone="";java.sql.Date ship_rdate=null;String ship_date="";String ship_attention="";
		String ship_prior_notice_name="";String ship_prior_notice_phone="";String ship_prior_notice="";String shipping_alt_no="";
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
				shipping_alt_no=rs_ship.getString("alt_no");
				ship_to_customer=rs_ship.getString("bpcs_cust_no");
			}
		}
		rs_ship.close();
		ResultSet rs_end_user=stmt.executeQuery("select bpcs_cust_no from cs_end_users where order_no='"+order_no+"'");
		if(rs_end_user != null){
			while(rs_end_user.next()){
				if(rs_end_user.getString(1) != null && rs_end_user.getString(1).trim().length()>0){
					ship_to_customer=rs_end_user.getString(1);
				}
			}
		}
		rs_end_user.close();
		ResultSet rs_invoice=stmt.executeQuery("select bpcs_cust_no from cs_invoice where order_no='"+order_no+"'");
		if(rs_invoice != null){
			while(rs_invoice.next()){
				if(rs_invoice.getString(1) != null && rs_invoice.getString(1).trim().length()>0){
					invoice_customer=rs_invoice.getString(1);
				}
			}
		}
		rs_invoice.close();
		//restting nulls
		if(ship_attention==null){ship_attention=" ";}if(ship_prior_notice_name==null){ship_prior_notice_name=" ";}if(ship_prior_notice_phone==null){ship_prior_notice_phone=" ";}
		if(ship_prior_notice==null){ship_prior_notice=" ";}
		// Getting the orderinfo
		String email_to="";String win_loss="";String submit_by="";String add_docs="";String special_notes="";String copies_requested="";String order_notes="";
		String cs_order_info_order_rep="";
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
				cs_order_info_order_rep=rs_order.getString("order_rep");
			}
		}
		rs_order.close();
		//eorders for the
		String prio="";
		ResultSet e_order = stmt.executeQuery("SELECT * FROM doc_header where doc_number like '"+order_no+"' ");
		if (e_order !=null) {
			while (e_order.next()) {
				prio= e_order.getString("doc_priority");
			}
		}
		e_order.close();
		//out.println("Line 373");
//out.println("2");
		//rep_no inti
		String source="";String psa_quote_type="";
		String spec_rep_acct_id="";String terr_rep_acct_id="";String arch_acct_id="";String order_rep_acct_id="";// for different accounts
		
		/* if(quote_type.equals("PSA")){
			String psa_pid="";
			ResultSet rs_psa_reps = stmt_psa.executeQuery("SELECT * FROM dba.quotation where quote_id like '"+psa_quote_id+"%"+"' order by 1 desc ");
			while ( rs_psa_reps.next() ) {
				psa_pid= rs_psa_reps.getString("project_id");
				psa_quote_type= rs_psa_reps.getString("quote_type");
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
					//out.println("Test: "+psa_quote_type+"<br>");
					if(psa_quote_type.equals("D")|psa_quote_type.endsWith("TQ")){
						source="TQ";
					}else{
						source="PS";
					}
				}
				else{
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
			String psa_account="";
			ResultSet psaAccount=stmt_psa.executeQuery("Select ACCT_ID FROM dba.cs_rep where rep_id='"+thisRep+"'");
			if(psaAccount != null){
				while(psaAccount.next()){
					psa_account=psaAccount.getString(1);
				}
			}
			psaAccount.close();
			ResultSet psaProj = stmt_psa.executeQuery("Select count(*) FROM dba.proj_ac_link where project_id like '"+psa_pid+"' and aclookup_id like '"+psa_account+"'");
			if(psaProj != null){
				while(psaProj.next()){
					if(new Double(psaProj.getString(1)).doubleValue() >0){
						rep_no=thisRep;
					}
					else{
						isGood=false;
					}
				}
			}
			psaProj.close();
		}
			else{ */
				
			source="TQ"; //for rep quotes always
// 		}
					if( bpcs_cust_no != null &&  bpcs_cust_no.trim().length()>0){
						String query="SELECT CMSTTP from bpcsffg/rcm where ccust = "+bpcs_cust_no+" ";
						ResultSet rs0=stmt_bpcsusrmm.executeQuery(query);
						if(rs0 != null){
							while(rs0.next()){
								if(rs0.getString(1)!= null && rs0.getString(1).trim().length()>0){
									source=rs0.getString(1);
		//out.println(source);
								}
							}
						}
						rs0.close();
					}
		stmt_bpcsusrmm.close();
		con_bpcsusrmm.close();
		if(cs_order_info_order_rep != null && cs_order_info_order_rep.trim().length()>0){
			rep_no=cs_order_info_order_rep;
		}
		//oh out
		if(bpcs_cust_no==null){bpcs_cust_no="000000";}if(cust_name1==null){cust_name1=" ";}if(cust_addr1==null){cust_addr1=" ";}if(cust_addr2==null){cust_addr2=" ";}
		if(city==null){city=" ";}if(state==null){state=" ";}if(zip_code==null){zip_code=" ";}if(phone==null){phone=" ";}if(fax==null){fax=" ";}if(contact_name==null){contact_name=" ";}
		if(customer_po_no==null){customer_po_no=" ";}if(payment_terms.startsWith("NET")){payment_terms=" ";}else{payment_terms="V";}if(Project_name==null){Project_name=" ";}
		if(customer_po_no==null){customer_po_no=" ";}if(email_to==null){email_to ="";}
		if(ship_rdate==null){ship_date ="00000000";}
		else{
			Format formatter = new SimpleDateFormat("yyyyMMdd");
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
		if(cust_name1.length()<30){
			String tv="";
			for(int v=0;v<(30-cust_name1.length());v++){
				tv=" "+tv;
			}
			cust_name1=cust_name1+tv;
		}
		else{
			cust_name1=cust_name1.substring(0,30);
		}
		cust_addr1=cust_addr1.replace("\n", "").replace("\r", "");
		if(cust_addr1.length()<30){
			String tv="";
			for(int v=0;v<(30-cust_addr1.length());v++){
				tv=" "+tv;
			}
			cust_addr1=cust_addr1+tv;
		}
		else{
			cust_addr1=cust_addr1.substring(0,30);
		}
		if(cust_addr2.length()<30){
			String tv="";
			for(int v=0;v<(30-cust_addr2.length());v++){
				tv=" "+tv;
			}
			cust_addr2=cust_addr2+tv;
		}
		else{
			cust_addr2=cust_addr2.substring(0,30);
		}
		if(city.length()<30){
			String tv="";
			for(int v=0;v<(30-city.length());v++){
				tv=" "+tv;
			}
			city=city+tv;
		}
		else{
			city=city.substring(0,30);
		}
		if(state.length()<3){
			String tv="";
			for(int v=0;v<(3-state.length());v++){
				tv=" "+tv;
			}
			state=state+tv;
		}
		else{
			state=state.substring(0,3);
		}
		if(zip_code.length()<9){
			String tv="";
			for(int v=0;v<(9-zip_code.length());v++){
				tv=" "+tv;
			}
			zip_code=zip_code+tv;
		}
		else{
			zip_code=zip_code.substring(0,9);
		}
		if(phone.length()<25){
			String tv="";
			for(int v=0;v<(25-phone.length());v++){
				tv=" "+tv;
			}
			phone=phone+tv;
		}
		else{
			phone=phone.substring(0,25);
		}
		if(fax.length()<25){
			String tv="";
			for(int v=0;v<(25-fax.length());v++){
				tv=" "+tv;
			}
			fax=fax+tv;
		}
		else{
			fax=fax.substring(0,25);
		}
		if(contact_name.length()<30){
			String tv="";
			for(int v=0;v<(30-contact_name.length());v++){
				tv=" "+tv;
			}
			contact_name=contact_name+tv;
		}
		else{
			contact_name=contact_name.substring(0,30);
		}
		if(customer_po_no.length()<15){
			String tv="";
			for(int v=0;v<(15-customer_po_no.length());v++){
				tv=" "+tv;
			}
			customer_po_no=customer_po_no+tv;
		}
		else{
			customer_po_no=customer_po_no.substring(0,15);
		}
		if(Project_name.length()<50){
			String tv="";
			for(int v=0;v<(50-Project_name.length());v++){
				tv=" "+tv;
			}
			Project_name=Project_name+tv;
		}
		else{
			Project_name=Project_name.substring(0,50);
		}
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
		}
		else{
			email_to=email_to.substring(0,30);
		}
		//out.println("Line 624");
		// phase -2 code starts here
		//1.market
		String market="";
		if(product_id.equals("EJC")|product_id.equals("TPG")){
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
		}
		else{
			market=market.substring(0,5);
		}
		//out.println("Line 649");
		//market ends
		//2.Region starts
		int na=sales_region.indexOf("--");
		if (na >=0 ){
			sales_region=sales_region.substring(0,na);
		}
		//out.println("Line 656");
		//formattting
		if(sales_region.length()<6){
			String tv="";
			for(int v=0;v<(6-sales_region.length());v++){
				tv=" "+tv;
			}
			sales_region=sales_region+tv;
		}
		else{
			sales_region=sales_region.substring(0,6);
		}
		//out.println("Line 668");
		if(shipping_alt_no==null){
			shipping_alt_no="";
		}
		if(shipping_alt_no.length()<4){
			String tv="";
			for(int v=0;v<(4-shipping_alt_no.length());v++){
				tv="0"+tv;
			}
			shipping_alt_no=tv+shipping_alt_no;
		}
		//out.println("Line 679");
		if(bill_alt_no.length()<4){
			String tv="";
			for(int v=0;v<(4-bill_alt_no.length());v++){
				tv="0"+tv;
			}
			bill_alt_no=tv+bill_alt_no;
		}
		//out.println("Line 684");
		//Region ends
		//3.Terms start
		String terms="";
		if(payment_terms.startsWith("CC")|payment_terms.startsWith("V")){
			terms="CC";
		}
		else{
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
		}
		else{
			source=source.substring(0,3);
		}
		//source ends
		//Ship to customer
//out.println("Line 707");

		//ware house on the header line
		String ware_house_header="";String ware_house_line="";
		if(win_loss.equals("RF")){
			ware_house_header="3 ";
		}
		else{
			ware_house_header="DR";
		}
		if(ware_house_header.length()<2){
			String tv="";
			for(int v=0;v<(2-ware_house_header.length());v++){
				tv=" "+tv;
			}
			ware_house_header=ware_house_header+tv;
		}
		else{
			ware_house_header=ware_house_header.substring(0,2);
		}
		if(ship_to_customer.length()<6){
			String tv="";
			for(int v=0;v<(6-ship_to_customer.length());v++){
				tv="0"+tv;
			}
			ship_to_customer=tv+ship_to_customer;
		}
		if(invoice_customer.length()<6){
			String tv="";
			for(int v=0;v<(6-invoice_customer.length());v++){
				tv="0"+tv;
			}
			invoice_customer=tv+invoice_customer;
		}
		// phase -2 ends starts here
		// shock wave addition starts here
//out.println("Line 742");
		String release_flag="";String user_hold="";
		if(win_loss.equals("RF")){release_flag="1";}else{release_flag=" ";}
		if(win_loss.equals("HA")){user_hold="01";}else{user_hold="00";}
		if(bpcs_tier_order == null && bpcs_tier_order.trim().length()<=0){
			bpcs_tier_order=" ";
		}
		String onlinespaces="                                            ";
		if(sales_tax_code.length()<5){
			String tv="";
			for(int v=0;v<(5-sales_tax_code.length());v++){
			tv=" "+tv;
		    }
			sales_tax_code=sales_tax_code+tv;
		}else{sales_tax_code=sales_tax_code.substring(0,5);}
		// shock wave addition ends here
		final_oh_out=final_oh_out+"HO"+order_no+bpcs_cust_no+cust_name1+cust_addr1+cust_addr2+city+state+zip_code+phone+fax+contact_name+customer_po_no+payment_terms+Project_name+ship_date+email_to+ware_house_header+market+"A6"+sales_region+terms+source+ship_to_customer+invoice_customer+sales_tax_code+release_flag+user_hold+bpcs_tier_order+onlinespaces+shipping_alt_no+bill_alt_no+"\r\n";
		//os out
		if(ship_name.length()<30){
			String tv="";
			for(int v=0;v<(30-ship_name.length());v++){
				tv=" "+tv;
			}
			ship_name=ship_name+tv;
		}
		else{
			ship_name=ship_name.substring(0,30);
		}
		ship_addr1 = ship_addr1.replace("\n", "").replace("\r", "");
		if(ship_addr1.length()<30){
			String tv="";
			for(int v=0;v<(30-ship_addr1.length());v++){
				tv=" "+tv;
			}
			ship_addr1=ship_addr1+tv;
		}
		else{
			ship_addr1=ship_addr1.substring(0,30);
		}
		if(ship_addr2.length()<30){
			String tv="";
			for(int v=0;v<(30-ship_addr2.length());v++){
				tv=" "+tv;
			}
			ship_addr2=ship_addr2+tv;
		}
		else{
			ship_addr2=ship_addr2.substring(0,30);
		}
		if(ship_city.length()<30){
			String tv="";
			for(int v=0;v<(30-ship_city.length());v++){
				tv=" "+tv;
			}
			ship_city=ship_city+tv;
		}
		else{
			ship_city=ship_city.substring(0,30);
		}
		if(ship_state.length()<3){
			String tv="";
			for(int v=0;v<(3-ship_state.length());v++){
				tv=" "+tv;
			}
			ship_state=ship_state+tv;
		}
		else{
			ship_state=ship_state.substring(0,3);
		}
		if(ship_zip.length()<9){
			String tv="";
			for(int v=0;v<(9-ship_zip.length());v++){
				tv=" "+tv;
			}
			ship_zip=ship_zip+tv;
		}
		else{
			ship_zip=ship_zip.substring(0,9);
		}
		if(ship_phone.length()<25){
			String tv="";
			for(int v=0;v<(25-ship_phone.length());v++){
				tv=" "+tv;
			}
			ship_phone=ship_phone+tv;
		}
		else{
			ship_phone=ship_phone.substring(0,25);
		}
		if(ship_attention.length()<30){
			String tv="";
			for(int v=0;v<(30-ship_attention.length());v++){
				tv=" "+tv;
			}
			ship_attention=ship_attention+tv;
		}
		else{
			ship_attention=ship_attention.substring(0,30);
		}
		final_os_out=final_os_out+"SO"+order_no+ship_name+ship_addr1+ship_addr2+ship_city+ship_state+ship_zip+ship_phone+ship_attention+"\r\n";
		//oi out
		//out.println("Line 842");
		String tot_price_string= String.valueOf(for13.format(total_sale_price));
		if(ge_prod_efs.equals("Y")){
			if(win_loss.equals("DR")|(special_cut.equals("Y")& win_loss.equals("RF"))){
				win_loss="DRAFTLOGEFS";
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
				final_oi_out=final_oi_out+"IO"+order_no+win_loss+tot_price_string+"00000000000000"+ware_house_line+bpcs_tier_order+"\r\n";
			}
		}
		if(ge_prod_iwp.equals("Y")){
			if(win_loss.equals("DR")){
				win_loss="DRAFTLOGIPG";
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
				final_oi_out=final_oi_out+"IO"+order_no+win_loss+tot_price_string+"00000000000000"+ware_house_line+bpcs_tier_order+"\r\n";
			}
		}
		if(win_loss.equals("HA")){
			win_loss="DRAFTLOGREP"+product_id;
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
			final_oi_out=final_oi_out+"IO"+order_no+win_loss+tot_price_string+"00000000000000"+ware_house_line+bpcs_tier_order+"\r\n";
		}
		//for getting ware house info for the lines
		ware_house_line="";
		// OI rules are different for products change them accordingly
		//vectors for fixing the linenote issue
		Vector di_erapid_line_nos=new Vector();Vector di_bpcs_line_nos=new Vector();
				//out.println("Line 939");
		//vectors for  fixing the linenote issue done
rep_no="000709";
		if(ge_prod_efs.equals("Y")){
			//Vars
			String line_no_text="";
			String blockId="";String bpcs_tier_line="";
			String efs_qty_mat_grid="";double efs_price_mat_grid=0.0;String efs_bpcs_item="";double efs_com_price_mat_grid=0.0;double efs_com_perc_mat_grid=0.0;
			int efs_qty_template_mat=0;double efs_price_template_mat=0.0;String efs_bpcs_item_template_mat="";double efs_com_price_template_mat=0.0;double efs_com_perc_template_mat=0.0;
			int efs_qty_template_grid=0;double efs_price_template_grid=0.0;String efs_bpcs_item_template_grid="";double efs_com_price_template_grid=0.0;double efs_com_perc_template_grid=0.0; double efs_qty_mat_grid_up=0.0;
			String ware_house_template_mat="";String ware_house_template_grid="";
			String temp_erapid_bpcs_line="";

			for(int ii=0;ii<items.size();ii++){

				for(int i=0;i<block_id.size();i++){
					if(line_product_id.elementAt(i).toString().equals("EFS")){
						if(line_item.elementAt(i).toString().equals(items.elementAt(ii).toString())){

							temp_erapid_bpcs_line=line_item.elementAt(i).toString();
							if( !(block_id.elementAt(i).toString().startsWith("E_DIM")|block_id.elementAt(i).toString().startsWith("A_APRODUCT")|block_id.elementAt(i).toString().startsWith("D_NOTES")) ){

								if(block_id.elementAt(i).toString().startsWith("A_")){//MAT/GRID PARTS
									blockId=block_id.elementAt(i).toString();
									efs_bpcs_item=bpcs_part_no.elementAt(i).toString();
									efs_qty_mat_grid=String.valueOf(for13.format((new Double(bpcs_qty.elementAt(i).toString()).doubleValue())*(new Double(QTY.elementAt(i).toString()).doubleValue()) ));
									efs_qty_mat_grid_up=(new Double(QTY.elementAt(i).toString()).doubleValue())*(new Double(bpcs_qty.elementAt(i).toString()).doubleValue());
									efs_price_mat_grid=efs_price_mat_grid+Double.parseDouble(price.elementAt(i).toString());
									efs_com_price_mat_grid=efs_com_price_mat_grid+Double.parseDouble(fact_per.elementAt(i).toString())*Double.parseDouble(price.elementAt(i).toString());
									ware_house_line=line_whse.elementAt(i).toString();//for each line ware house.
								}

								if(block_id.elementAt(i).toString().startsWith("C_FINISHES")){//ROLL TO MAT/GRID
									efs_price_mat_grid=efs_price_mat_grid+Double.parseDouble(price.elementAt(i).toString());
									efs_com_price_mat_grid=efs_com_price_mat_grid+Double.parseDouble(fact_per.elementAt(i).toString())*Double.parseDouble(price.elementAt(i).toString());
								}
								if(block_id.elementAt(i).toString().startsWith("D_MISC5")){// ROLL TO MAT/GRID
									efs_price_mat_grid=efs_price_mat_grid+Double.parseDouble(price.elementAt(i).toString());
									efs_com_price_mat_grid=efs_com_price_mat_grid+Double.parseDouble(fact_per.elementAt(i).toString())*Double.parseDouble(price.elementAt(i).toString());
								}
								if(block_id.elementAt(i).toString().startsWith("FACTORY")){// ROLL TO MAT/GRID
									efs_price_mat_grid=efs_price_mat_grid+Double.parseDouble(price.elementAt(i).toString());
									efs_com_price_mat_grid=efs_com_price_mat_grid+Double.parseDouble(fact_per.elementAt(i).toString())*Double.parseDouble(price.elementAt(i).toString());
								}
								if(block_id.elementAt(i).toString().startsWith("C_MISC")){// ROLL TO MAT/GRID EXCEPTION ARE TEMPLATE MAT/GRID
									if( !(bpcs_part_no.elementAt(i).toString().startsWith("TEMPLATEMAT")|bpcs_part_no.elementAt(i).toString().startsWith("TEMPLATEGRID"))){
										efs_price_mat_grid=efs_price_mat_grid+Double.parseDouble(price.elementAt(i).toString());
										efs_com_price_mat_grid=efs_com_price_mat_grid+Double.parseDouble(fact_per.elementAt(i).toString())*Double.parseDouble(price.elementAt(i).toString());
										ware_house_line=line_whse.elementAt(i).toString();
									}
									else if(bpcs_part_no.elementAt(i).toString().startsWith("TEMPLATEMAT")){
										efs_price_template_mat=efs_price_template_mat+Double.parseDouble(price.elementAt(i).toString());
										efs_qty_template_mat=efs_qty_template_mat+Integer.parseInt(bpcs_qty.elementAt(i).toString());
										efs_com_price_template_mat=efs_com_price_template_mat+Double.parseDouble(fact_per.elementAt(i).toString())*Double.parseDouble(price.elementAt(i).toString());
										ware_house_template_mat=line_whse.elementAt(i).toString();
									}
									else if(bpcs_part_no.elementAt(i).toString().startsWith("TEMPLATEGRID")){
										efs_price_template_grid=efs_price_template_grid+Double.parseDouble(price.elementAt(i).toString());
										efs_qty_template_grid=efs_qty_template_grid+Integer.parseInt(bpcs_qty.elementAt(i).toString());
										efs_com_price_template_grid=efs_com_price_template_grid+Double.parseDouble(fact_per.elementAt(i).toString())*Double.parseDouble(price.elementAt(i).toString());
										ware_house_template_grid=line_whse.elementAt(i).toString();
									}
								}

							}//inner if statment
						}//outer if statment
						bpcs_tier_line=bpcs_tier_lines.elementAt(i).toString();//tier line for shockwave changes
					}//do above only for EFS
				}//INNER for loop

				if (efs_price_mat_grid>0){
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
					String comPerc="";
					/*if (prio.equals("E")){
						comPerc=String.valueOf(for19.format(100*(efs_com_price_mat_grid/efs_price_mat_grid)));
					}
					else{*/
						comPerc=String.valueOf(for19.format(100*(efs_com_price_mat_grid/(efs_price_mat_grid*(0.91)))));
					//}
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
					double over_price=lineOver*(Double.parseDouble(overage)/(config_price-nonCommission));
					if(new Double(efs_com_price_mat_grid_string).doubleValue() <=0){
						over_price=0;
					}
					String over_price_string=for12.format(over_price);
					String overx=String.valueOf(over_price);
					int neg = over_price_string.indexOf("-");
					if(neg >= 0){
						over_price_string=over_price_string.substring(neg+1);
						String lastDigit=over_price_string.substring(over_price_string.length() -1);
						over_price_string=over_price_string.substring(0,over_price_string.length()-1)+charMap[Integer.parseInt(lastDigit)];
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
					fc_value="0";
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
					overageLine=overageLine+over_price;
					//ware house line
					if(ware_house_line.trim().length()<2){
						String tv="";
						for(int v=0;v<(2-ware_house_line.length());v++){
							tv=tv+" ";
						}
						ware_house_line=ware_house_line+tv;
					}
					final_oi_out=final_oi_out+"IO"+order_no+efs_bpcs_item+efs_qty_mat_grid+efs_price_mat_grid_string_up+ware_house_line+bpcs_tier_line+"\r\n";
					final_ic_out=final_ic_out+"DI"+order_no+line_no_text+efs_bpcs_item+efs_price_mat_grid_string_up+rep_no+"001"+comPerc+efs_com_price_mat_grid_string+"100000000000"+over_price_string+fc_value+"\r\n";
					bpcs_lines.addElement(line_no_text);
					erapid_bpcs_lines.addElement(items.elementAt(ii).toString());
				}
				efs_price_mat_grid=0;efs_bpcs_item="";efs_qty_mat_grid="";efs_com_price_mat_grid=0;

			}//outer for loop for eorder_item lines
			//frame
//out.println("3");
			//Template Mat Starts
			if(efs_qty_template_mat>0){

				efs_com_perc_template_mat=(efs_com_price_template_mat/efs_price_template_mat)*100;
				String efs_com_perc_template_mat_string=for19.format(efs_com_perc_template_mat);
				String efs_price_template_mat_string= String.valueOf(for14.format(efs_price_template_mat));
				String efs_price_template_mat_string_up= String.valueOf(for14.format(efs_price_template_mat/efs_qty_template_mat));
				lineOver=efs_price_template_mat;
				String efs_qty_template_mat_string= String.valueOf(for13.format(efs_qty_template_mat));
				String efs_com_price_template_mat_string= for12.format(efs_com_price_template_mat);
				String efs_bpcs_part_template="TEMPLATEMAT";
				String comPerc="";
				/*if (prio.equals("E")){
					comPerc=String.valueOf(for19.format(100*(efs_com_price_template_mat/efs_price_template_mat)));
				}
				else{*/
					comPerc=String.valueOf(for19.format(100*(efs_com_price_template_mat/(efs_price_template_mat*(0.91)))));
				//}
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
				if(efs_bpcs_part_template.length()<15){
					String tv="";
					for(int v=0;v<(15-efs_bpcs_part_template.length());v++){
						tv=" "+tv;
					}
					efs_bpcs_part_template=efs_bpcs_part_template+tv;
				}
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
				double over_price=lineOver*(Double.parseDouble(overage)/(config_price-nonCommission));
				if(new Double(efs_com_price_template_mat_string).doubleValue()<=0){
					over_price=0;
				}
				//over price
				String over_price_string=for12.format(over_price);
				String overx=String.valueOf(over_price);
				// as requested by ACosma
				// bpcs will do line overage automatically based on job overage
				// Sept 21/05
				int neg = over_price_string.indexOf("-");
				if(neg >= 0){
					over_price_string=over_price_string.substring(neg+1);
					String lastDigit=over_price_string.substring(over_price_string.length() -1);
					over_price_string=over_price_string.substring(0,over_price_string.length()-1)+charMap[Integer.parseInt(lastDigit)];
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
				fc_value="0";
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
				overageLine=overageLine+over_price;
				//ware house line
				if(ware_house_template_mat.trim().length()<2){
					String tv="";
					for(int v=0;v<(2-ware_house_template_mat.length());v++){
						tv=tv+" ";
					}
					ware_house_template_mat=tv+ware_house_template_mat;
				}
				final_oi_out=final_oi_out+"IO"+order_no+efs_bpcs_part_template+efs_qty_template_mat_string+efs_price_template_mat_string_up+ware_house_template_mat+bpcs_tier_line+"\r\n";
				final_ic_out=final_ic_out+"DI"+order_no+line_no_text+efs_bpcs_part_template+efs_price_template_mat_string_up+rep_no+"001"+comPerc+efs_com_price_template_mat_string+"100000000000"+over_price_string+fc_value+"\r\n";
				bpcs_lines.addElement(line_no_text);
				erapid_bpcs_lines.addElement(temp_erapid_bpcs_line);

			}
			// Template Mat ends

			//Template grid Starts
			if(efs_qty_template_grid>0){
				efs_com_perc_template_grid=(efs_com_price_template_grid/efs_price_template_mat)*100;
				String efs_com_perc_template_grid_string=for19.format(efs_com_perc_template_grid);
				String efs_price_template_grid_string= String.valueOf(for14.format(efs_price_template_grid));
				lineOver=efs_price_template_grid;
				String efs_price_template_grid_string_up= String.valueOf(for14.format(efs_price_template_grid/efs_qty_template_grid));
				String efs_qty_template_grid_string= String.valueOf(for13.format(efs_qty_template_grid));
				String efs_com_price_template_grid_string= for12.format(efs_com_price_template_grid);
				String efs_bpcs_part_template="TEMPLATEGRID";
				String comPerc="";
				/*if (prio.equals("E")){
					comPerc=String.valueOf(for19.format(100*(efs_com_price_template_grid/efs_price_template_grid)));
				}
				else{*/
					comPerc=String.valueOf(for19.format(100*(efs_com_price_template_grid/(efs_price_template_grid*(0.91)))));
				//}
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
				if(efs_com_price_template_grid_string.length()<15){
					String tv="";
					for(int v=0;v<(15-efs_com_price_template_grid_string.length());v++){
						tv="0"+tv;
					}
					efs_com_price_template_grid_string=tv+efs_com_price_template_grid_string;
				}
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
				double over_price=lineOver*(Double.parseDouble(overage)/(config_price-nonCommission));
				if(new Double(efs_com_price_template_grid_string).doubleValue()<=0){
					over_price=0;
				}
				//over price
				String over_price_string=for12.format(over_price);
				String overx=String.valueOf(over_price);
				int neg = over_price_string.indexOf("-");
				if(neg >= 0){
					over_price_string=over_price_string.substring(neg+1);
					String lastDigit=over_price_string.substring(over_price_string.length() -1);
					over_price_string=over_price_string.substring(0,over_price_string.length()-1)+charMap[Integer.parseInt(lastDigit)];
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
				fc_value="0";
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
				overageLine=overageLine+over_price;
				//ware house line
				if(ware_house_template_grid.trim().length()<2){
					String tv="";
					for(int v=0;v<(2-ware_house_template_grid.length());v++){
						tv=tv+" ";
					}
					ware_house_template_grid=tv+ware_house_template_grid;
				}
				final_oi_out=final_oi_out+"IO"+order_no+efs_bpcs_part_template+efs_qty_template_grid_string+efs_price_template_grid_string_up+ware_house_template_grid+bpcs_tier_line+bpcs_tier_line+"\r\n";
				final_ic_out=final_ic_out+"DI"+order_no+line_no_text+efs_bpcs_part_template+efs_price_template_grid_string_up+rep_no+"001"+comPerc+efs_com_price_template_grid_string+"100000000000"+over_price_string+fc_value+"\r\n";
				bpcs_lines.addElement(line_no_text);
				erapid_bpcs_lines.addElement(temp_erapid_bpcs_line);
			}
			// Template grid ends
			// Frames block start

			// getting the pan lines// added is on Aug'1 08 as per Jim and Charlie
			Vector pan_bpcs_part_no= new Vector();Vector pan_bpcs_qty= new Vector();int pan_count=0;//Vector frame_qty=new Vector();
			ResultSet rs_pan_group = stmt.executeQuery("SELECT bpcs_gen,sum( cast(bpcs_qty as decimal)),qty,block_id FROM CSQUOTES where order_no like '"+order_no+"' and line_no in ("+lines_final+") and (Block_ID LIKE '%pan%' OR Block_ID LIKE '%frames%')  and block_id not like '%A_APRODUCT%' group by bpcs_gen,qty,block_id ");
			if (rs_pan_group !=null) {
				while (rs_pan_group.next()) {
					pan_count++;
					pan_bpcs_part_no.addElement(rs_pan_group.getString(1));
					if(rs_pan_group.getString("block_id").equals("B_FRAMES")){
						pan_bpcs_qty.addElement(""+(for13.format(new Double(rs_pan_group.getString(2)).doubleValue()*new Double(rs_pan_group.getString(3)).doubleValue())));
						//out.println(rs_pan_group.getString(2)+"::"+rs_pan_group.getString(3)+"::<BR>");
					}
					else{
						pan_bpcs_qty.addElement(""+(for13.format(new Double(rs_pan_group.getString(2)).doubleValue())));
					}
				}
			}
			rs_pan_group.close();
			//pan block ends
			for(int g=0; g<pan_bpcs_qty.size(); g++){
				//out.println(pan_bpcs_qty.elementAt(g).toString()+"::<BR>");
			}

			ResultSet rs_frame_group = stmt.executeQuery("SELECT bpcs_gen,sum( cast(bpcs_qty as decimal)*cast(qty as decimal)),sum(cast(extended_price as decimal(10, 2))),sum(CAST(Extended_Price AS decimal(10, 2)) * CAST(field16 AS decimal(10, 5))),sum(cast(qty as decimal(10,2))) FROM CSQUOTES where order_no like '"+order_no+"' and line_no in ("+lines_final+") and (Block_ID LIKE '%pan%' OR Block_ID LIKE '%frames%')  and block_id not like '%A_APRODUCT%' group by bpcs_gen ");
			if (rs_frame_group !=null) {
				while (rs_frame_group.next()) {

					String frame_bpcs_part_no=rs_frame_group.getString(1);
					String frame_bpcs_qty="";
					if(pan_count<=0){
					}

					else{
						frame_bpcs_qty="0";
						for (int ii = 0; ii < pan_count; ii++) {
							//out.println(frame_bpcs_qty+"::1<BR>");
							//out.println(pan_bpcs_qty.elementAt(ii).toString()+"::2<BR>");
							//out.println(frame_bpcs_part_no+"::3<BR><BR>");
							if(frame_bpcs_part_no.equals(pan_bpcs_part_no.elementAt(ii).toString())){
								//frame_bpcs_qty=""+(new Double(frame_bpcs_qty).doubleValue()+new Double(pan_bpcs_qty.elementAt(ii).toString()).doubleValue());
							}
						}
						if(new Double(frame_bpcs_qty).doubleValue()==0){
							frame_bpcs_qty=String.valueOf(for13.format(new Double(rs_frame_group.getString(2)).doubleValue()));
						}
						//out.println(rs_frame_group.getString(5)+"::"+rs_frame_group.getString(2)+":::<BR>");
					}
					double frame_bpcs_price=rs_frame_group.getDouble(3);
					lineOver=frame_bpcs_price;
					double frame_bpcs_com_price=rs_frame_group.getDouble(4);
					double frame_com_perc=(frame_bpcs_com_price/frame_bpcs_price)*100;
					String frame_com_perc_string=for19.format(frame_com_perc);
					String frame_bpcs_com_price_string=for12.format(frame_bpcs_com_price);
					String frame_bpcs_price_string=for14.format(frame_bpcs_price);
					String frame_bpcs_price_string_up=for14.format(frame_bpcs_price/(new Double(frame_bpcs_qty).doubleValue()));
					//String frame_bpcs_price_string_up=for14.format(frame_bpcs_price/(new Double(rs_frame_group.getString(2)).doubleValue()));
					//String comPerc=for19.format(100*(frame_bpcs_com_price/frame_bpcs_price));
					String comPerc="";
					/*if (prio.equals("E")){
						comPerc=String.valueOf(for19.format(100*(frame_bpcs_com_price/frame_bpcs_price)));
					}
					else{*/
						comPerc=String.valueOf(for19.format(100*(frame_bpcs_com_price/(frame_bpcs_price*(0.91)))));
					//}
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
					r="";
					for (int i = 0; i < frame_com_perc_string.length(); i ++) {
						if (frame_com_perc_string.charAt(i) != '.' && frame_com_perc_string.charAt(i) != ',') r += frame_com_perc_string.charAt(i);
					}
					frame_com_perc_string=r;
					if(frame_com_perc_string.length()<12){
						String tv="";
						for(int v=0;v<(12-frame_com_perc_string.length());v++){
							tv="0"+tv;
						}
						frame_com_perc_string=tv+frame_com_perc_string;
					}
					//Overage calcs
					double over_price=lineOver*(Double.parseDouble(overage)/(config_price-nonCommission));
					if(new Double(frame_bpcs_com_price_string).doubleValue()<=0){
						over_price=0;
					}
					String over_price_string=for12.format(over_price);
					String overx=String.valueOf(over_price);
					// as requested by ACosma
					// bpcs will do line overage automatically based on job overage
					// Sept 21/05
					int neg = over_price_string.indexOf("-");
					if(neg >= 0){
						over_price_string=over_price_string.substring(neg+1);
						String lastDigit=over_price_string.substring(over_price_string.length() -1);
						over_price_string=over_price_string.substring(0,over_price_string.length()-1)+charMap[Integer.parseInt(lastDigit)];
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
					fc_value="0";
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
					overageLine=overageLine+over_price;
					final_oi_out=final_oi_out+"IO"+order_no+frame_bpcs_part_no+frame_bpcs_qty+frame_bpcs_price_string_up+ware_house_line+bpcs_tier_line+"\r\n";
					final_ic_out=final_ic_out+"DI"+order_no+line_no_text+frame_bpcs_part_no+frame_bpcs_price_string_up+rep_no+"001"+comPerc+frame_bpcs_com_price_string+"100000000000"+over_price_string+fc_value+"\r\n";
					bpcs_lines.addElement(line_no_text);
					//erapid_bpcs_lines.addElement(items.elementAt(ii).toString());
					erapid_bpcs_lines.addElement("????");

				}
			}
			rs_frame_group.close();


			// Frames block	end
		}// product is EFS				done
		//out.println("4");
		if(ge_prod_iwp.equals("Y")|ge_prod_ge.equals("Y")){//product is iwp or ge same rules
			String line_no_text="";String blockId="";String iwp_bpcs_item="";String iwp_qty="";double iwp_qty_up=0; double iwp_price=0;double iwp_com_price=0;
			for(int ii=0;ii<items.size();ii++){
				for(int i=0;i<block_id.size();i++){
					if(line_product_id.elementAt(i).toString().equals("IWP")|line_product_id.elementAt(i).toString().equals("GE")){
						if(line_item.elementAt(i).toString().equals(items.elementAt(ii).toString())){
							if( !(block_id.elementAt(i).toString().startsWith("E_DIM")|block_id.elementAt(i).toString().startsWith("A_APRODUCT")|block_id.elementAt(i).toString().startsWith("D_NOTES")) ){
								if(block_id.elementAt(i).toString().startsWith("A_")|block_id.elementAt(i).toString().startsWith("B_")|(bpcs_part_no.elementAt(i).toString()!=null&&bpcs_part_no.elementAt(i).toString().trim().length()>0)){//MAT/GRID PARTS
									blockId=block_id.elementAt(i).toString();
									iwp_bpcs_item=bpcs_part_no.elementAt(i).toString();
									iwp_qty=String.valueOf(for13.format(new Double(bpcs_qty.elementAt(i).toString()).doubleValue()));
									iwp_qty_up=new Double(bpcs_qty.elementAt(i).toString()).doubleValue();
									iwp_price=iwp_price+Double.parseDouble(price.elementAt(i).toString());
									iwp_com_price=iwp_com_price+Double.parseDouble(fact_per.elementAt(i).toString())*Double.parseDouble(price.elementAt(i).toString());
								}
								else{
									iwp_price=iwp_price+Double.parseDouble(price.elementAt(i).toString());
									iwp_com_price=iwp_com_price+Double.parseDouble(fact_per.elementAt(i).toString())*Double.parseDouble(price.elementAt(i).toString());
								}
								if (iwp_price>=0){
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
									double over_price=lineOver*(Double.parseDouble(overage)/(config_price-nonCommission));
									//over price
									if(new Double(iwp_com_price_string).doubleValue() <=0){
										over_price=0;
									}
									String over_price_string=for12.format(over_price);
									String overx=String.valueOf(over_price);
									// as requested by ACosma
									// bpcs will do line overage automatically based on job overage
									// Sept 21/05
									int neg = over_price_string.indexOf("-");
									if(neg >= 0){
										over_price_string=over_price_string.substring(neg+1);
										String lastDigit=over_price_string.substring(over_price_string.length() -1);
										over_price_string=over_price_string.substring(0,over_price_string.length()-1)+charMap[Integer.parseInt(lastDigit)];
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
									fc_value="0";
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
									overageLine=overageLine+over_price;
									//for shock wave getting the tier levels
									String bpcs_tier_line=bpcs_tier_lines.elementAt(i).toString();
									ware_house_line=line_whse.elementAt(i).toString();
									if(ware_house_line.trim().length()<2){
										String tv="";
										for(int v=0;v<(2-ware_house_line.length());v++){
											tv=tv+" ";
										  }
										ware_house_line=ware_house_line+tv;
									}
									//for shock wave getting the tier levels done
									final_oi_out=final_oi_out+"IO"+order_no+iwp_bpcs_item+iwp_qty+iwp_price_string_up+ware_house_line+bpcs_tier_line+"\r\n";
									final_ic_out=final_ic_out+"DI"+order_no+line_no_text+iwp_bpcs_item+iwp_price_string_up+rep_no+"001"+comPerc+iwp_com_price_string+"100000000000"+over_price_string+fc_value+"\r\n";
									bpcs_lines.addElement(line_no_text);
									erapid_bpcs_lines.addElement(items.elementAt(ii).toString());
								}
							}//inner if statment
						}//outer if statment
						iwp_price=0;iwp_bpcs_item="";iwp_qty="";iwp_com_price=0;
					}//only for IWP product lines
				}//INNER for loop// BLOCK_ID.SIZE()
			}//outer for ii<items.size()
		}// product is IWP
		if(ge_prod_ge.equals("Y")){//for GE products only
		}// product is GE
		// Getting the setup_cost
		//out.println("Line 2018");
		if(Double.parseDouble(setup_cost)>0){
			String setup_part=product_id+"MINOR";
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
			final_oi_out=final_oi_out+"IO"+order_no+setup_part+setup_bpcs_qty+setup_cost+ware_house_line+bpcs_tier_order+"\r\n";
		}//setup cost
		//String[] taxable_freight_state = {"AR","CT","GA","IN","KS","MI","MN","MS","NE","NJ","NM","NY","NC","ND","OH","PA","RI","SD","TN","TX","WA","WV","WI"};
		Vector taxable_freight_state=new Vector();
		ResultSet rsFreightTax=stmt.executeQuery("select state_code from cs_state_codes where country_code='US' and taxable_freight='1'");
		if(rsFreightTax != null){
		    while(rsFreightTax.next()){
			   taxable_freight_state.addElement(rsFreightTax.getString(1));
			  // out.println(ship_state.trim()+"::"+rsFreightTax.getString(1)+"::<BR>");
		    }
		}
		rsFreightTax.close();
		//out.println("5");

		//out.println(freight_cost+"::<BR>");
		//for (int i = 0; i < taxable_freight_state.size(); i++) {
		//	if(taxable_freight_state.elementAt(i).toString().startsWith(ship_state.trim())&&!tax_exempt.equals("Y")){
		//if(Double.parseDouble(freight_cost)>0){
				String freight_part=product_id+"FREIGHT";
				if(Double.parseDouble(freight_cost)<=0){
					freight_cost="0";
				}
				//freight_part=freight_part+"TAX";
				String freight_bpcs_qty="1.000";
				r="";
				for (int ii = 0; ii < freight_bpcs_qty.length(); ii ++) {
					if (freight_bpcs_qty.charAt(ii) != '.' && freight_bpcs_qty.charAt(ii) != ',') r += freight_bpcs_qty.charAt(ii);
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
				for (int ii = 0; ii < freight_cost.length(); ii ++) {
					if (freight_cost.charAt(ii) != '.' && freight_cost.charAt(ii) != ',') r += freight_cost.charAt(ii);
				}
				freight_cost=r;
				if(freight_cost.length()<14){
					String tv="";
					for(int v=0;v<(14-freight_cost.length());v++){
						tv="0"+tv;
					}
					freight_cost=tv+freight_cost;
				}
				final_oi_out=final_oi_out+"IO"+order_no+freight_part+freight_bpcs_qty+freight_cost+"3 "+bpcs_tier_order+"\r\n";
		//}
		//	}
		//}

		//  order notes
		//email acknowledgement
		if(email_acknowledgement != null && email_acknowledgement.equals("on")){
			String acknowledgenote="CUST ACK TO: "+bill_email;
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
		//SUBMITTALS
		//out.println("6");
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
			final_on_out=final_on_out+"NO"+order_no+"000"+isti+cust_oo+"\r\n";
			notesCounter++;
		}//copies requested done
		// Additional documents
		// Tokenizer for getting the add doc's
		//out.println("Line 2268");
		Vector docs_final=new Vector();String doc_type="";
		if(add_docs!=null){
		StringTokenizer stdoc=new StringTokenizer(add_docs,";");
		out.println("Line 2272");
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
		}
		//out.println("Line 2308");
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
		//out.println("Line 2333");
		// new customer 000
		// for shipping notice info added on Sep'10'2008
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
		}
		//out.println("Line 2382");
		///for shipping notice info ended
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
			String cust_oo=order_notes;
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
		//out.println("Line 2493");
		//free notes to BPCS order notes
		if(free_text != null && free_text.trim().length()>0 ){
			String cust_oo=""+free_text;
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
		int lineCounter=0;
		// architect is not BPCS
		// Sections Y or N
		// Line notes
		String dimension="";String cuts_notches="";String logo="";String template_art="";String texture_color="";
		String d_notes="";int lc_count=1;String qty_line="";String line_no_note="";int lp1=0;String isti="";String marks="";



		for(int u=0; u<bpcs_lines.size(); u++){
			//out.println(bpcs_lines.elementAt(u).toString()+"::");
			//out.println(erapid_bpcs_lines.elementAt(u).toString()+"::<BR><BR>");
		}




		//out.println("7");

		for(int er=0; er<bpcs_lines.size(); er++){
			for(int ii=0;ii<items.size();ii++){//line_items from eorderitems
				if(erapid_bpcs_lines.elementAt(er).toString().equals(items.elementAt(ii).toString())){
					line_no_note=bpcs_lines.elementAt(er).toString();
					//line_no_note=String.valueOf(ii+1+lineIncrease);
					//	line_no_note=String.valueOf(Integer.parseInt(items.elementAt(ii).toString().trim())+lineIncrease);
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
								marks=mark.elementAt(i).toString().trim();
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
								//mark no
								if(marks.trim().length()>0){
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
							}//e_dim
							if( block_id.elementAt(i).toString().startsWith("D_NOTES")){
								d_notes=desc.elementAt(i).toString().trim();
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
								// 						final_on_out=final_on_out+"NO"+order_no+"000"+isti+cust_oo+"\r\n";
							}//d_notes
						}//if checking the if they are same line items.
						isti="";
					}//for csquotes
					isti=String.valueOf(lc_count);
					String tv1="";
					for(int v=0;v<(4-isti.length());v++){tv1="0"+tv1; }
					isti=tv1+isti;
					//final_on_out=final_on_out+"NO"+order_no+line_no_note+isti+"PENDING APPROVAL\r\n";
					lineCounter=Integer.parseInt(line_no_note)+1;
					lc_count=1;
					dimension="";cuts_notches="";logo="";template_art="";texture_color="";d_notes="";line_no_note="";
				}//for eorder items
			}
		}
//t.println("a");
		for(int y=lineCounter; y<diLineCounter; y++){
			String line_no=String.valueOf(y);
			String tv1="";
			for(int v=0; v<(3-line_no.length()); v++){ tv1="0"+tv1;}
			line_no=tv1+line_no;
		}
		// Line Item NOtes done
		//oc out
//out.println("b");
String lineCommTemp="";
		double totprice=0;double factor=0;double totprice_dis=0;double totcomm_dol=0;String com_perc="";String tot_com_dol_str="";
		String fc_value="";String fc_perc="";
		for(int ii=0;ii<items.size();ii++){
			for(int i=0;i<block_id.size();i++){
				if(line_item.elementAt(i).toString().equals(items.elementAt(ii).toString())){
//out.println("c");
					String totwt=price.elementAt(i).toString();//Extended_Price
					String fact=fact_per.elementAt(i).toString().trim();//FIELD16
//out.println("d");
					if ((fact.equals(""))){fact="0.0"; }
					BigDecimal d1 = new BigDecimal(totwt);
					BigDecimal d2 = new BigDecimal(fact);
					BigDecimal d3 = d1.multiply(d2);
					factor = factor+d3.doubleValue();// Line comission dollars for the line
					totprice=totprice+d1.doubleValue();//Line materail price no comission for the line
					totprice_dis=totprice_dis+d1.doubleValue();//Total material price for the job
					totcomm_dol= totcomm_dol+d3.doubleValue();// Total commission dollars for the job
//out.println("e");
lineCommTemp=lineComm.elementAt(i).toString();
///out.println("f");
				}
			}
			factor=0;totprice=0;
		}
//out.println("8");
		// Global commission %
		fc_value="0";String t="";double t1=0.0; double t2=totcomm_dol;
		/*if (prio.equals("E")){//deco
			if(nonCommision>0){
				com_perc=for19.format(((totcomm_dol/((totprice_dis-nonCommission)))*100));
			}
			else{
				for(int z=0;z<price.size();z++){
					if( (Double.parseDouble(bpcs_qty.elementAt(z).toString().trim())>0)&(Double.parseDouble(price.elementAt(z).toString().trim())>0) ){
						t1=t1+ (Double.parseDouble(price.elementAt(z).toString()))*0.91;
					}
				}
				com_perc=for19.format((t2/t1)*100);
			}
			fc_perc="00.000";
		}
		else{//cs*/
			if(nonCommision>0){
				com_perc=for19.format(((totcomm_dol/((totprice_dis-nonCommision)*0.91))*100));
			}
			else{
				for(int z=0;z<price.size();z++){
					if( (Double.parseDouble(bpcs_qty.elementAt(z).toString())>0)&(Double.parseDouble(price.elementAt(z).toString())>0) ){
						t1=t1+(Double.parseDouble(price.elementAt(z).toString()))*0.91;
					}
				}
				com_perc=for19.format((t2/t1)*100);
			}
			fc_perc="09.000";
		//}
		if(totcomm_dol==0){
			fc_perc="00.000";
			com_perc="0";
		}
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
			overage_str=overage_str.substring(neg+1);
			String lastDigit=overage_str.substring(overage_str.length() -1);
			overage_str=overage_str.substring(0,overage_str.length()-1)+charMap[Integer.parseInt(lastDigit)];
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
		if(cs_order_type.startsWith("BUY")){
			cs_order_type="B";
			overage_perc="100000000000"; // changed as per Charlie on Aug 14 2008
		}
		else{
			cs_order_type="R";
			overage_perc="000000000000";
		}
String commx="100000000000";
if(lineCommTemp==null || lineCommTemp.equals("")||lineCommTemp.equals("0")){
	commx="000000000000";
}
	//out.println("9");
	//final_oc_out=final_oc_out+"CO"+order_no+com_perc+tot_com_dol_str+overage_str+fc_perc+fc_value+rep_no+"001"+"100000000000"+tot_com_dol_str+overage_perc+overage_str+order_no+" "+quote_type+"000000"+cs_order_type+"100"+"\r\n";
		final_oc_out=final_oc_out+"CO"+order_no+com_perc+tot_com_dol_str+overage_str+fc_perc+fc_value+"000709"+"001"+commx+tot_com_dol_str+overage_perc+overage_str+order_no+" "+quote_type+"000000"+cs_order_type+"100"+"\r\n";
		
		%>
		<%@ include file="order_transfer_bpcs_ds.jsp"%>
		<%
		
		//String url="WS"+order_no+"http://"+application.getInitParameter("HOST")+"/erapid/us/orders/ows/order_sheet.jsp?sections="+si+"&orderNo="+order_no+"&rep_no="+thisRep;
		String url="WS"+order_no+"http://ims.c-sgroup.com/go.asp?APPA=TESTCS&SUBJ=NEWORDERS&KEY="+product_id+order_no;
		final_out=final_oh_out+final_os_out+final_oi_out+final_on_out+final_oc_out+final_ic_out+final_ds_out;
		final_out=final_out.toUpperCase()+url;
		BufferedWriter out1 = new BufferedWriter(new FileWriter(dir_path+"\\"+"O"+order_no+".txt"));
		out1.write(final_out);
		out.flush();
		out1.flush();
		out1.close();
		//writing the output to second folder also
		BufferedWriter out2 = new BufferedWriter(new FileWriter(dir_path1+"\\"+"O"+order_no+".txt"));
		out2.write(final_out);
		out2.flush();
		out2.close();
		out.println("Output file created succesfully for eRapid Order... "+order_no+"<br><br><br>");
String name=request.getParameter("userId");

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
		to="hmushyam@c-sgroup.com";
		String message="Thank you for the order.";
		String messageForMail="Thank you for your order. Your Erapid Order successfully transferred. A Construction Specialties, Inc. Customer service representative will contact you with further details.";
		%>
		<form name='selectform' method='post'>
			<input type="hidden" name="order_no" value="<%=order_no%>">
			<input type="hidden" name="rep_no" value="<%=thisRep%>">
			<input type="hidden" name="userId" value="<%=userId%>">
			<input type="hidden" name="to" value="<%=to%>">
			<input type="hidden" name="from" value="Erapid_Order_<%=order_no%>_confirmation@c-sgroup.com">
			<input type="hidden" name="cc" value="">
			<input type="hidden" name="message" value="Thank you for your order. Your Erapid Order:<%=order_no%> successfully transferred. A Construction Specialties, Inc. Customer service representative will contact you with further details.">
		</form>
			
<%@ include file="mail.delivery2.jsp"%>		

		<%
		
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
//db closing
stmt.close();
//myConn.commit();
myConn.close();
//stmt_psa.close();
//myConn_psa.close();
stmts.close();
myConns.close();
%>
