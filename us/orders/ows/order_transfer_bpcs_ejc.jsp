
<%

try{

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>

	<head>
		<title>Transfer to BPCS</title>
		<link rel='stylesheet' href='style1.css' type='text/css'/>
	</head>
	<SCRIPT language="JavaScript">
		function poponload()
		{
			var time=new Date();
			hours=time.getHours();
			mins=time.getMinutes();
			secs=time.getSeconds();
			closeTime=hours*3600+mins*60+secs;
			closeTime+=4;  // This number is how long the window stays open
			//     Timer();

			var url="mail.delivery2.jsp?order_no="+document.selectform.order_no.value+"&to="+document.selectform.to.value+"&from="+document.selectform.from.value+"&message="+document.selectform.message.value+"&cc=&sections=all&rep_no="+document.selectform.rep_no.value+"&name="+document.selectform.userId.value;
			var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=450,height=200';
			//my_window=window.open(url,"mywindow1",props);

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
		<h1>CS Order Transfer System::</h1>
		<%@ page language="java"  import="java.sql.*" import="java.util.*" import="java.lang.*" import="java.io.*" import="java.text.*" import="javax.mail.internet.*" import="javax.activation.*" import="java.net.*" import="java.math.*" errorPage="error.jsp" %>
		<%@ include file="db_con.jsp"%>
		<%@ include file="dbcon1.jsp"%>
		<%//@ include file="../../../db_con_psa.jsp"%>
		<%@ include file="db_con_bpcsusrmm.jsp"%>
		<%
		int lineIncrease=0;
		String order_no = request.getParameter("order");
		String si = request.getParameter("sections");
		String thisRep=request.getParameter("rep_no");
		String doc_priority=request.getParameter("doc_priority");
		boolean isGood=true;
		String groupName="";
		//out.println(url+"<BR>");
		//myConn.close();

		//out.println(si+":"+order_no);
	String userId=request.getParameter("userId");

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
		//NumberFormat for14 = NumberFormat.getInstance();
		DecimalFormat for14 = new DecimalFormat("####.##");
		for14.setMaximumFractionDigits(4);
		for14.setMinimumFractionDigits(4);
		NumberFormat for19 = NumberFormat.getInstance();
		for19.setMaximumFractionDigits(9);
		for19.setMinimumFractionDigits(9);
		//vars for io to file
					String dir_path="\\\\lebhq-erusdev\\TRANSFER\\BPCS_OE\\";String final_out="";String final_oh_out="";String final_os_out="";String final_oi_out="";
					String final_on_out="";String final_oc_out="";String final_ic_out="";
					String dir_path1="\\\\lebhq-erusdev\\TRANSFER\\BPCS_OE\\testing\\ejc\\";
		//
//out.println("1");
		String section_group="";Vector si_final = new Vector();Vector li_final = new Vector();String Project_name="";String product_id="";String lines_final = "";
		String overage="";String freight_cost="";String handling_cost="";String setup_cost="";double config_price=0;double total_sale_price=0;
		String rep_no="";String quote_type="";String psa_quote_id="";String bpcs_tier_order="";String sales_tax_code="";String bpcs_order_no="";String quote_origin="";String base_quote_no="";String quote_no_origin="";
		//reteriving the lines from the sections
					//out.println(".......Out put transfer to CS order system started....... "+"to "+dir_path+ " folder for upload to BPCS"+"<br><br><br>");
			out.println(".......Output transfer to CS order system BPCS started for EJC....... <br><br><br>");
					ResultSet rs_find = stmt.executeQuery("SELECT * FROM cs_quote_sections where order_no like '"+order_no+"'");
					if (rs_find !=null) {
					while (rs_find.next()){
					section_group=rs_find.getString ("section_group");
		//			out.println("Testing"+section_group);
					 }
					}
					rs_find.close();
		// Project info
//out.println("a");
				ResultSet rs_project = stmt.executeQuery("SELECT * FROM cs_project where Order_no like '"+order_no+"' ");
					if (rs_project !=null) {
				while (rs_project.next()) {
							Project_name= rs_project.getString("Project_name");
							product_id= rs_project.getString("product_id");
							if(product_id.equals("EJC")){product_id="TPG";}
							rep_no=rs_project.getString("creator_id");
							overage= rs_project.getString("overage");
							if(rs_project.getString("freight_cost")!= null && rs_project.getString("freight_cost").trim().length()>0){
								freight_cost=String.valueOf(for14.format(new Double( rs_project.getString("freight_cost")).doubleValue()));
								}
							else{
								freight_cost=String.valueOf(for14.format(0.0));
							}
							if(rs_project.getString("handling_cost")!= null && rs_project.getString("handling_cost").trim().length()>0){
								handling_cost= rs_project.getString("handling_cost");
							}
							else{
								handling_cost="0";
							}
							if(rs_project.getString("setup_cost")!= null && rs_project.getString("setup_cost").trim().length()>0){
								setup_cost= String.valueOf(for14.format(new Double(rs_project.getString("setup_cost")).doubleValue()));
							}
							else{
								setup_cost=String.valueOf(for14.format(0.0));
							}
							quote_type=rs_project.getString("project_type");
							if((quote_type == null)){quote_type="";}
							psa_quote_id=rs_project.getString("project_type_id");
		//					config_price= rs_project.getString("configured_price");
							bpcs_tier_order=rs_project.getString("bpcs_tier");
							sales_tax_code=rs_project.getString("tax_code");

							quote_origin= rs_project.getString("quote_origin");
							bpcs_order_no= rs_project.getString("BPCS_order_no");
							if(rs_project.getString("base_quote_no") != null  && rs_project.getString("base_quote_no").trim().length()>0 && rs_project.getString("base_quote_no").trim().substring(0,6).startsWith(order_no.substring(0,6))){
								base_quote_no=rs_project.getString("base_quote_no");
							}
						}
					}
					rs_project.close();
//out.println("b");
					if(base_quote_no==null){
						base_quote_no="";
					}
					if(quote_origin==null){
						quote_origin="";
					}
					if(quote_origin.equals("Alternate")||quote_origin.equals("")||quote_origin.equals("Copy")){
						base_quote_no=order_no;
					}
//("2");
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
					//out.println("FALSE::"+tempbase_quote_no_old+":::"+tempquote_origin+"::<BR>");
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
									 rs1.close();

		// Checking the no of lines	done
		//doc_line end
		//CS_QUOTES<br>
		double nonCommision=0.0;
			Vector QTY=new Vector();Vector price=new Vector();Vector line_item=new Vector();Vector desc=new Vector();
				Vector rec_no=new Vector();Vector fact_per=new Vector();Vector mark=new Vector();Vector block_id=new Vector();Vector bpcs_part_no=new Vector();
				Vector bpcs_qty=new Vector();Vector bpcs_gen=new Vector();Vector bpcs_tier_lines=new Vector();Vector add_release_flag=new Vector();
		//		 if (si==nul
//out.println("3");
		String largestLine="";double largestPrice=0.0;int counterLarge=0;int indexLarge=-1;
		int diLineCounter=1;double nonCommission=0;
		String sql_one="";
				ResultSet rs3 = stmt.executeQuery("SELECT * FROM csquotes where order_no like '"+order_no+"' and line_no in ("+lines_final+") order by cast(Line_no as integer)");
			   while ( rs3.next() ) {
							//out.println(rs3.getString("block_id")+"::"+rs3.getString("extended_price")+"<BR>");
						line_item.addElement(rs3.getString ("Line_no"));
						desc.addElement(rs3.getString ("Descript"));
						price.addElement(rs3.getString ("Extended_Price"));
						if(new Double(rs3.getString("extended_price")).doubleValue() >largestPrice && !rs3.getString("block_id").startsWith("D_")){
							largestPrice=(new Double(rs3.getString("extended_price")).doubleValue());
							largestLine=rs3.getString("line_no");
							indexLarge=counterLarge;
						}
						config_price=config_price+new BigDecimal(rs3.getString ("Extended_Price")).doubleValue();
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
						bpcs_part_no.addElement(rs3.getString("bpcs_part_no"));
						if(rs3.getString("bpcs_qty") != null && rs3.getString("bpcs_qty").trim().length()>0){
							bpcs_qty.addElement(rs3.getString("bpcs_qty").trim());
						}
						else{
							bpcs_qty.addElement("0");
						}
						if(rs3.getString("bpcs_gen") != null){
							bpcs_gen.addElement(rs3.getString("bpcs_gen"));
						}
						else{
							bpcs_gen.addElement("");
						}
						if(quote_origin.startsWith("change")& rs3.getString("deduct").trim().equals("add")){
							 add_release_flag.addElement("A");
						}
						else if(quote_origin.startsWith("release")|quote_origin.startsWith("revision")|quote_origin.startsWith("submittal")){
							 add_release_flag.addElement("R");
						}else{
							 add_release_flag.addElement("");
						}
						//bpcs_line tiers
						if(rs3.getString("bpcs_tier") != null && rs3.getString("bpcs_tier").trim().length()>0){
							bpcs_tier_lines.addElement(rs3.getString("bpcs_tier").trim());
						}else{bpcs_tier_lines.addElement("0");	}
						counterLarge++;
									 }
				 rs3.close();
				//out.println("congifured price:"+for10.format(config_price)+"::"+config_price+"largest price:"+largestPrice+"rounded config price:"+Math.round(config_price)+"<br>");
				double cents=Math.round(config_price)-config_price;
				//out.println("cents to be added:"+cents+"::cents<BR>");
				if(quote_type!= null && quote_type.equals("web")){
					cents=0;
				}
				else{
					config_price=config_price+cents;
				}

			  //out.println(config_price+"config price :: largest Price"+largestPrice+"::largestLine"+largestLine+"::"+indexLarge+"index<BR>");


		//out.println(nonCommission+" here is the noncommissionable total<BR>");
		//out.println(price.elementAt(indexLarge).toString()+"::"+QTY.elementAt(indexLarge).toString()+"::"+fact_per.elementAt(indexLarge).toString()+"<-- here<BR>");
		double priceLarge=0.0;double comLarge=0.0;double newCom=0.0;
		if(indexLarge>=0){
		priceLarge=new Double(price.elementAt(indexLarge).toString()).doubleValue()+cents;
		comLarge=new Double(price.elementAt(indexLarge).toString()).doubleValue()*new Double(fact_per.elementAt(indexLarge).toString()).doubleValue();
		//if(priceLarge==0){newCom=0.0;}else{
		newCom=comLarge/priceLarge;//}
		price.setElementAt(String.valueOf(priceLarge),indexLarge);
		fact_per.setElementAt(String.valueOf(newCom),indexLarge);
		}
		//out.println(price.elementAt(indexLarge).toString()+"::"+QTY.elementAt(indexLarge).toString()+"::"+fact_per.elementAt(indexLarge).toString()+"<-- NEW here<BR>");

		//out.println(handling_cost+"::<BR>");
		total_sale_price=config_price+Double.parseDouble(overage)+Double.parseDouble(handling_cost)+Double.parseDouble(freight_cost)+Double.parseDouble(setup_cost);
		//out.println(total_sale_price+"::<BR>");
		//grand_total=(Float.parseFloat(o_cost)+Float.parseFloat(handling_cost)+Float.parseFloat(freight_cost)+Float.parseFloat(t));

		//db connectons
		 //billing customer
				String cust_name1="";String cust_addr1="";String cust_addr2="";String city="";String state="";String zip_code="";
				String phone="";String fax="";String contact_name="";String customer_po_no="";String payment_terms="";String bpcs_cust_no="";String order_type="";
				String invoice_info="";String cs_order_type="";String order_rep_no="";String sales_region="";String cs_company="";String email_acknowledgement="";String bill_email="";
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
order_type=rs_bill.getString("order_type");
				order_rep_no= rs_bill.getString ("created_rep_no");
				sales_region= rs_bill.getString ("sales_region");
				cs_company= rs_bill.getString("cs_company");
				bill_email=rs_bill.getString("email");
				email_acknowledgement=rs_bill.getString("email_acknowledgement");
											    }
							 }
if(order_type==null){
order_type="";
}
			//getting the rep_no from cs_billed
		if(sales_region==null){
			sales_region="";
		}
		if(cs_company==null){
			cs_company="";
		}
		if(email_acknowledgement==null){
			email_acknowledgement="";
		}
		if(bill_email==null){
			bill_email="";
		}
//out.println("4");
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
//out.println("a");
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
				//if(!(ship_rdate != null)){
					//ship_rdate="";
				//}
									   }
								   }
		//restting nulls
		if(ship_attention==null){ship_attention=" ";}if(ship_prior_notice_name==null){ship_prior_notice_name=" ";}if(ship_prior_notice_phone==null){ship_prior_notice_phone=" ";}
		if(ship_prior_notice==null){ship_prior_notice=" ";}

		// Getting the orderinfo
		String email_to="";String win_loss="";String submit_by="";String add_docs="";String special_notes="";String copies_requested="";String order_notes="";
		String customer_notes="";String drafting_email="";
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
//("5");
		String prio="";
				ResultSet e_order = stmt.executeQuery("SELECT * FROM doc_header where doc_number like '"+order_no+"' ");
				if (e_order !=null) {
			   while (e_order.next()) {
				prio= e_order.getString("doc_priority");
										}
									 }
									 e_order.close();
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
		//out.println(quote_type+"<--<BR>");

				//rep_no inti
		String psa_quote_type="";String source="";
		String spec_rep_acct_id="";String terr_rep_acct_id="";String arch_acct_id="";String order_rep_acct_id="";// for different accounts
		//out.println(quote_type+"<--<BR>");

				/* if(quote_type.equals("PSA")){
					String psa_pid="";
				   ResultSet rs_psa_reps = stmt_psa.executeQuery("SELECT * FROM dba.quotation where quote_id like '"+psa_quote_id+"%"+"' order by 1 desc ");
				  while ( rs_psa_reps.next() ) {
				   psa_pid= rs_psa_reps.getString("project_id");
				  psa_quote_type= rs_psa_reps.getString("quote_type");
			//		   out.println(psa_pid+" this is the psa product type"+psa_quote_type);
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
						//		out.println("Test: "+psa_quote_type+"<br>");
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
					rs_psa_proj_ac_link.close();

				//out.println("this rep = "+thisRep+"<BR>");
					String psa_account="";
					ResultSet psaAccount=stmt_psa.executeQuery("Select ACCT_ID FROM dba.cs_rep where rep_id='"+thisRep+"'");
					if(psaAccount != null){
						while(psaAccount.next()){
							psa_account=psaAccount.getString(1);
						}
					}
					psaAccount.close();

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
				psaProj.close();

		}else{ */

			source="TQ"; //for rep quotes always
		//}
//out.println("B");
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
				//oh out
				if(bpcs_cust_no==null){bpcs_cust_no="000000";}if(cust_name1==null){cust_name1=" ";}if(cust_addr1==null){cust_addr1=" ";}if(cust_addr2==null){cust_addr2=" ";}
				if(city==null){city=" ";}if(state==null){state=" ";}if(zip_code==null){zip_code=" ";}if(phone==null){phone=" ";}if(fax==null){fax=" ";}if(contact_name==null){contact_name=" ";}
				if(customer_po_no==null){customer_po_no=" ";}if(payment_terms.startsWith("NET")){payment_terms=" ";}else{payment_terms="V";}if(Project_name==null){Project_name=" ";}
				if(customer_po_no==null){customer_po_no=" ";}if(email_to==null){email_to ="";}
				if(ship_rdate==null){ship_date ="00000000";}
				else{Format formatter = new SimpleDateFormat("yyyyMMdd");
			    ship_date = formatter.format(ship_rdate);
				}

										//assinging a rep no 36 for all international orders
										if(cs_company.startsWith("CS-INTER")){
											rep_no="36";
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
									//2.Region starts


										if(product_id.equals("EJC")|product_id.equals("TPG")){
										market="TR";
											if(sales_region.substring(0,1).equals("R")){
												market="IC";
											}
											if(sales_region.substring(0,1).equals("G")){
												market="IN";
											}
											if(doc_priority.equals("E")){
												market="RT";
											 }
										}else{
											 if(doc_priority.equals("C")){
												market="TR";
											 }
											else if(doc_priority.equals("E")){
												market="RT";
											 }
											 else{
												market="DG";
											  }



											if(sales_region.substring(0,1).equals("R")){
												market="IC";
											}
											if(sales_region.substring(0,1).equals("G")){
												market="IN";
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
									if(groupName.toUpperCase().startsWith("CAN")&&sales_region.trim().length()>0 && sales_region.indexOf("-")>0){
											sales_region=sales_region.substring(0,sales_region.indexOf("-"));
									}
									else{
										if(sales_region.trim().length()>0){
																		//sales_region=sales_region.substring(0,1);
sales_region=sales_region.substring(0,sales_region.indexOf("-"));
										}
										if (sales_region.startsWith("M")){sales_region="MT";}
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
									if(win_loss.equals("RF")){
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
					if(bpcs_tier_order == null & bpcs_tier_order.trim().length()<=0){
						bpcs_tier_order="0";
					}
					String divison="A2";
					if(groupName.toUpperCase().startsWith("CAN")){
						divison="AE";
					}
					// shock wave addition ends here

		final_oh_out=final_oh_out+"HO"+order_no+bpcs_cust_no+cust_name1+cust_addr1+cust_addr2+city+state+zip_code+phone+fax+contact_name+customer_po_no+payment_terms+Project_name+ship_date+email_to+ware_house_header+market+divison+sales_region+terms+source+ship_to_customer+invoice_customer+sales_tax_code+release_flag+user_hold+bpcs_tier_order+"\r\n";
		//os out


//out.println("C");
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
										String tot_price_string= String.valueOf(for13.format(total_sale_price));
									//out.println(tot_price_string+"::<BR>");
										String add_release_bpcs="";
										if(quote_origin.startsWith("change")|quote_origin.startsWith("release")|quote_origin.startsWith("revision")|quote_origin.startsWith("submittal")){
											add_release_bpcs=" ";
										}else{
											ship_date="";
											add_release_bpcs=" ";
										}
										if(!(quote_origin.startsWith("change")|quote_origin.startsWith("release")|quote_origin.startsWith("revision")|quote_origin.startsWith("submittal"))){
											if(win_loss.equals("DR")){
													win_loss="DRAFTLOG"+product_id;
													if(product_id.equals("EJC")){win_loss="DRAFTLOGTPG";}
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
													final_oi_out=final_oi_out+"IO"+order_no+win_loss+tot_price_string+"00000000000000"+ware_house_line+bpcs_tier_order+add_release_bpcs+ship_date+"\r\n";
													//out.println("1"+final_oi_out+"::<BR>");
											}else if(win_loss.equals("HA")){
													win_loss="DRAFTLOGREP"+product_id;
													if(product_id.equals("EJC")){
														win_loss="DRAFTLOGREPTPG";
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
													final_oi_out=final_oi_out+"IO"+order_no+win_loss+tot_price_string+"00000000000000"+ware_house_line+bpcs_tier_order+add_release_bpcs+ship_date+"\r\n";
													//out.println("2"+final_oi_out+"::<BR>");
											}
										}
		// IO rules are different for products change them accordingly
		//variables for bank lines
		String bank_desc="";
		if(win_loss.equals("RF")){
			bank_desc="EJCINVOICE";
		}else{
			bank_desc="EXPANSIONJOINT";
		}
//out.println("D");
		String tot_price_string1="";
		//variables for bank lines end
						if(product_id.equals("EFS")){
						}// product is EFS
						else if(product_id.equals("EJC")|product_id.equals("TPG")){
							ware_house_line="1 ";
							// change made to group all the lines with a bank line with the total price in it.
							//qty of 1 and price for the total line

							//change done for the bank line

											String line_no_text="";String blockId="";String ejc_bpcs_item="";String ejc_qty="";double ejc_qty_up=0; double ejc_price=0;double ejc_com_price=0;
											String bpcs_tier_line="";
											//Vars
												for(int ii=0;ii<items.size();ii++){
												for(int i2=0;i2<block_id.size();i2++){
														if(line_item.elementAt(i2).toString().equals(items.elementAt(ii).toString())){
															if( !(block_id.elementAt(i2).toString().startsWith("E_DIM")|block_id.elementAt(i2).toString().startsWith("A_APRODUCT")|block_id.elementAt(i2).toString().startsWith("D_NOTES")) ){
																if(block_id.elementAt(i2).toString().startsWith("PRICING")){//MAT/GRID PARTS
																	blockId=block_id.elementAt(i2).toString();
																	out.println("<BR>"+bpcs_part_no.elementAt(i2).toString()+"::"+price.elementAt(i2).toString()+" here<BR>");
		//															if(win_loss.equals("RF")){//if
																		ejc_bpcs_item=bpcs_part_no.elementAt(i2).toString();
		//													  		}
		//													  		else{
		//													  			ejc_bpcs_item=bpcs_gen.elementAt(i2).toString();
		//													  		}
																	ejc_qty=String.valueOf(for13.format(new Double(bpcs_qty.elementAt(i2).toString()).doubleValue()));
																	ejc_qty_up=new Double(bpcs_qty.elementAt(i2).toString()).doubleValue();
																	//out.println("1:"+price.elementAt(i2).toString()+"<BR>");
																	ejc_price=ejc_price+Double.parseDouble(price.elementAt(i2).toString());
																	ejc_com_price=ejc_com_price+Double.parseDouble(fact_per.elementAt(i2).toString())*Double.parseDouble(price.elementAt(i2).toString());
																	//out.println(efs_price_mat_grid+" efs price mat<BR>");
																	add_release_bpcs=add_release_flag.elementAt(i2).toString();
																}
															}//inner if statment
														}//outer if statment
														bpcs_tier_line=bpcs_tier_lines.elementAt(i2).toString();
													
																    if (ejc_price>0){
																		//out.println(blockId+"< inside efs_price_mat_grid<BR>");
																			r="";
																			for (int i = 0; i < ejc_qty.length(); i ++) {
																				if (ejc_qty.charAt(i) != '.' && ejc_qty.charAt(i) != ',') r += ejc_qty.charAt(i);
																			}
																			ejc_qty=r;
																			if(ejc_qty.length()<11){
																			String tv="";
																			for(int v=0;v<(11-ejc_qty.length());v++){
																			tv="0"+tv;
																			   }
																			ejc_qty=tv+ejc_qty;
																			}
																			if(ejc_bpcs_item.length()<15){
																			String tv="";
																			for(int v=0;v<(15-ejc_bpcs_item.length());v++){
																			tv=" "+tv;
																			   }
																			ejc_bpcs_item=ejc_bpcs_item+tv;
																			}
																			double ejc_com_perc=(ejc_com_price/ejc_price)*100;
																			lineOver=ejc_price;
																			String ejc_price_string= String.valueOf(for14.format(ejc_price));
																			String ejc_com_price_string= for12.format(ejc_com_price);
																			String ejc_com_perc_string= for19.format(ejc_com_perc);
																			String ejc_price_string_up = String.valueOf(for14.format(ejc_price/ejc_qty_up));
																			//out.println("price::"+ejc_price+"QTY:"+ejc_qty_up+"Unit price::"+ejc_price_string_up+"<br>");
																			//String comPerc=String.valueOf(for19.format(100*(ejc_com_price/ejc_price)));
																			String comPerc="";
																			//if (prio.equals("E")){
																				//comPerc=String.valueOf(for19.format(100*(ejc_com_price/ejc_price)));
																			//}
																			//else{
																				comPerc=String.valueOf(for19.format(100*(ejc_com_price/(ejc_price*(0.91)))));
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
																			for (int i = 0; i < ejc_price_string.length(); i ++) {
																				if (ejc_price_string.charAt(i) != '.' && ejc_price_string.charAt(i) != ',') r += ejc_price_string.charAt(i);
																			}
																			ejc_price_string=r;
																			if(ejc_price_string.length()<14){
																			String tv="";
																			for(int v=0;v<(14-ejc_price_string.length());v++){
																			tv="0"+tv;
																			   }
																			ejc_price_string=tv+ejc_price_string;
																			}
																			r="";
																			for (int i = 0; i < ejc_price_string_up.length(); i ++) {
																				if (ejc_price_string_up.charAt(i) != '.' && ejc_price_string_up.charAt(i) != ',') r += ejc_price_string_up.charAt(i);
																			}
																			ejc_price_string_up=r;
																			if(ejc_price_string_up.length()<14){
																				String tv="";
																				for(int v=0;v<(14-ejc_price_string_up.length());v++){
																					tv="0"+tv;
																				}
																				ejc_price_string_up=tv+ejc_price_string_up;
																			}
																			r="";
																			for (int i = 0; i < ejc_com_price_string.length(); i ++) {
																				if (ejc_com_price_string.charAt(i) != '.' && ejc_com_price_string.charAt(i) != ',') r += ejc_com_price_string.charAt(i);
																			}
																			ejc_com_price_string=r;
																			if(ejc_com_price_string.length()<15){
																			String tv="";
																			for(int v=0;v<(15-ejc_com_price_string.length());v++){
																			tv="0"+tv;
																			   }
																			ejc_com_price_string=tv+ejc_com_price_string;
																			}
																			r="";
																			for (int i = 0; i < ejc_com_perc_string.length(); i ++) {
																				if (ejc_com_perc_string.charAt(i) != '.' && ejc_com_perc_string.charAt(i) != ',') r += ejc_com_perc_string.charAt(i);
																			}
																			ejc_com_perc_string=r;
																			if(ejc_com_perc_string.length()<12){
																			String tv="";
																			for(int v=0;v<(12-ejc_com_perc_string.length());v++){
																			tv="0"+tv;
																			   }
																			ejc_com_perc_string=tv+ejc_com_perc_string;
																			}
																			//Overage calcs\
																			//out.println(efs_com_price_mat_grid+"*("+overage+"/"+config_price+")<BR>");
																			//double over_price=efs_com_price_mat_grid*(Double.parseDouble(overage)/config_price);

																			double over_price=lineOver*(Double.parseDouble(overage)/(config_price-nonCommission));
																			//over price
																			if(new Double(ejc_com_price_string).doubleValue() <=0){
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
																			//fc_value=for12.format(ejc_com_price*0.09);
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

																		if(new Double(ejc_qty).doubleValue()>0){
																			final_oi_out=final_oi_out+"IO"+order_no+ejc_bpcs_item+ejc_qty+ejc_price_string_up+ware_house_line+bpcs_tier_line+add_release_bpcs+ship_date+"\r\n";;
																			final_ic_out=final_ic_out+"DI"+order_no+line_no_text+ejc_bpcs_item+ejc_price_string_up+rep_no+"001"+comPerc+ejc_com_price_string+"100000000000"+over_price_string+fc_value+"\r\n";
																		}
																	   }
																		ejc_price=0;ejc_bpcs_item="";ejc_qty="";ejc_com_price=0;
																		}//INNER for loop

												}//outer for ii<items.size()




						}// product is TPG
						else if(product_id.equals("IWP")){
						}// product is IWP
						else if(product_id.equals("LVR")){
						}// product is LVR

						//out.println("HERE");
// Getting the setup_cost
						if(Double.parseDouble(handling_cost)>0){
							String product_id2=product_id;
							if(product_id2.equals("TPG")){
								product_id2="EJC";
							}
							String setup_part="MINOR"+product_id2;
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
//out.println("HErex");
						if(Double.parseDouble(freight_cost)>0){
						String freight_part="MINOR"+"EJC";
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
							final_oi_out=final_oi_out+"IO"+order_no+freight_part+freight_bpcs_qty+freight_cost+ware_house_line+bpcs_tier_order+add_release_bpcs+ship_date+"\r\n";
						}//freight cost
		//on out
		    //  order notes
				   //SUBMITTALS




//out.println("HERE2");

			  //email acknowledgement
		  //out.println("HERE"+email_acknowledgement+"::<BR>");
		 if(email_acknowledgement != null && email_acknowledgement.equals("on")){
			//String acknowledgenote="EMAIL CUSTOMER ACKNOWLEDGEMENT TO: "+bill_email;
			//as per Alex Seitzinger and Mary Milhiem April 9 2014
			//String acknowledgenote="EMAIL CUSTOMER ACKNOWLEDGEMENT TO: "+bill_email;
			String acknowledgenote="EMAIL ACK TO: "+bill_email;
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


          //drafting email

         if(drafting_email != null && drafting_email.length()>0){
                        String acknowledgenote="SUBMITTAL INFO TO: "+drafting_email;
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
				}//submittals by done

		// moved to be the not right after the submittals by as per Jim 08/25/2008
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
//out.println("HERe3");
			// Additional documents
			// Tokenizer for getting the add doc's
			Vector docs_final=new Vector();String doc_type="";
			if(add_docs!=null){
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
					//commmented on June 27'08 as per Charlie and Keith

								//commmented on June 27'08 as per Charlie and Keith

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
									// order seq no
								//out.println("no6<BR>");

							//out.println("Test"+);
						 }

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
					//out.println("no6<BR>");
				 //out.println("Test"+bpcs_cust_no);
			 }


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

		if(customer_notes != null && customer_notes.trim().length()>0 ){
			String cust_oo=customer_notes;
			//checking for carrige returns and new lines characters
			r="";
		//	out.println(":"+cust_oo.length());
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
		// out.println("0");
if(bpcs_order_no==null || bpcs_order_no.equals("null")){
	bpcs_order_no="";
}
//out.println("1");
		if((quote_origin.equals("sample")&&base_quote_no.trim().length()==0&&bpcs_order_no.trim().equals(""))||(bpcs_order_no.trim().equals("")||bpcs_order_no==null)&&((quote_origin==null)||!(quote_origin.startsWith("change")|quote_origin.startsWith("release")|quote_origin.startsWith("revision")|quote_origin.startsWith("submittal")))){
			//out.println(final_on_out+"::NOTES<BR>");
		}
		else{
			final_on_out="";
			notesCounter=0;
		}
		//out.println("a");
			 int lineCounter=0;

					// architect is not BPCS
					// Sections Y or N
					// Line notes
					String dimension="";String cuts_notches="";String logo="";String template_art="";String texture_color="";
					String d_notes="";int lc_count=1;String qty_line="";String line_no_note="";int lp1=0;String isti="";String marks="";
						for(int ii=0;ii<items.size();ii++){//line_items from eorderitems
									line_no_note=String.valueOf(Integer.parseInt(items.elementAt(ii).toString().trim())+lineIncrease);
									if(line_no_note.length()<3){
									String tv="";
									for(int v=0;v<(3-line_no_note.length());v++){
									tv="0"+tv;
									   }
									line_no_note=tv+line_no_note;
									}

					    for(int i=0;i<block_id.size();i++){//from csquotes
					   // out.println("c"+i+"::"+line_item.elementAt(i).toString()+"::"+items.elementAt(ii).toString());
							  if(line_item.elementAt(i).toString().equals(items.elementAt(ii).toString())){
							  //out.println("e"+block_id.elementAt(i).toString());
								if( block_id.elementAt(i).toString().equals("E_DIM")){
								//("d");
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
								//bpcs number

								//
									//line_no_note
								}//e_dim
								if( block_id.elementAt(i).toString().startsWith("D_NOTES")){
								//out.println("1");

								d_notes=desc.elementAt(i).toString().trim();
								//lc_count=1;
								//notes
								 lp1=d_notes.length()/50;//di
								 //out.println("2"+d_notes);
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
						  // out.println("after");
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
//out.println("2");
		for(int y=lineCounter; y<diLineCounter; y++){
			String line_no=String.valueOf(y);
			String tv1="";
			for(int v=0; v<(3-line_no.length()); v++){ tv1="0"+tv1;}
			line_no=tv1+line_no;
			//final_on_out=final_on_out+"NO"+order_no+line_no+"0001PENDING APPROVAL\r\n";
		}
		//out.println(diLineCounter+"di line counter"+lineCounter+"<BR>");
					// Line Item NOtes done
		//oc out
		double totprice=0;double factor=0;double totprice_dis=0;double totcomm_dol=0;String com_perc="";String tot_com_dol_str="";
		String fc_value="";String fc_perc="";
						for(int ii=0;ii<items.size();ii++){
					    for(int i=0;i<block_id.size();i++){
							  if(line_item.elementAt(i).toString().equals(items.elementAt(ii).toString())){
									String totwt=price.elementAt(i).toString();//Extended_Price
									String fact=fact_per.elementAt(i).toString().trim();//FIELD16
									  if ((fact.equals(""))){fact="0.0"; }
									  BigDecimal d1 = new BigDecimal(totwt);
									  d1 = d1.setScale(0, BigDecimal.ROUND_HALF_UP);
									 BigDecimal d2 = new BigDecimal(fact);
									  BigDecimal d3 = d1.multiply(d2);
									  //d3 = d3.setScale(0, BigDecimal.ROUND_HALF_UP);
									 factor = factor+d3.doubleValue();// Line comission dollars for the line
									  totprice=totprice+d1.doubleValue();//Line materail price no comission for the line
									  totprice_dis=totprice_dis+d1.doubleValue();//Total material price for the job
								//	  out.println("Tot price::"+d1.doubleValue()+"comm %"+d2.doubleValue()+"Actual comm dollars::"+d3.doubleValue()+"<br>");
									  totcomm_dol= totcomm_dol+d3.doubleValue();// Total commission dollars for the job
							  }
						   }
						  factor=0;totprice=0;
						}

			//commission %
			fc_value="0";
		//out.println(totcomm_doll+"::"+config_price+"::"+nonCommission+"::<BR>");
			//if (prio.equals("E")){//deco
				//  com_perc=for19.format((((Math.rint(totcomm_dol* 100.0d)/ 100.0d)/((config_price-nonCommission))*100)));
				  //fc_perc="00.000";
			//}
			//else{//cs
				  com_perc=for19.format((((Math.rint(totcomm_dol* 100.0d)/ 100.0d)/((config_price-nonCommision)*0.91))*100));
				  fc_perc="09.000";
			//fc_value=for12.format(totcomm_dol*0.09);
			//}
			//out.println("Com_perc"+com_perc+"comm_dollars::"+(Math.rint(totcomm_dol* 100.0d)/ 100.0d)+"Actual dollars::"+totcomm_dol+"total dollars::"+(totprice_dis-nonCommission)+"Actual dollars::"+config_price+"<br>");
			//Math.rint(totcomm_dol* 100.0d)/ 100.0d this if for rounding totcomm_dol to 2 decimals
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
							// if(quote_type==null){quote_type="E";}else{quote_type="P";}
							//quote_type="E";
							if(quote_type==null||quote_type.trim().length()<=0){

									if(overage_str.equals("000000000000000")){overage_perc="000000000000";}
									else{overage_perc="000000000000";}
							}else{overage_perc="000000000000";}//changed to P as per charlie on Aug'5 08
							//	 String cs_doc_type="";
							if(cs_order_type.startsWith("BUY")){
								cs_order_type="B";
								overage_perc="100000000000"; // changed as per Charlie on Aug 14 2008

							}
							else{
								cs_order_type="R";
							}
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

		//if(isGood){
			//out.println("Total Com_perc"+com_perc+"Tot comm_dollars::"+tot_com_dol_str+"Commission Amount "+tot_com_dol_str);
			final_oc_out=final_oc_out+"CO"+order_no+com_perc+tot_com_dol_str+overage_str+fc_perc+fc_value+rep_no+"001"+"100000000000"+tot_com_dol_str+overage_perc+overage_str+order_no+" "+quote_type+"000000"+cs_order_type+"100"+"\r\n";
		//	final_ic_out="DI"+order_no+"001"+bank_desc+tot_price_string1+rep_no+"001"+com_perc+tot_com_dol_str+overage_perc+overage_str+fc_value+"\r\n"+final_ic_out;
			//ic out
			//url ws
		//	String url="WS"+order_no+"http://"+application.getInitParameter("HOST")+"/erapid/us/orders/ows/order_sheet.jsp?sections="+si+"&order_no="+order_no+"&rep_no="+thisRep;
			String url="WS"+order_no+"http://ims.c-sgroup.com/go.asp?APPA=TESTCS&SUBJ=NEWORDERS&KEY="+product_id+order_no+"&REPNO="+thisRep;
			//String url="WS"+order_no+"http://ims.c-sgroup.com/go.asp?APPA=TESTCS&SUBJ=NEWORDERS&KEY="+product_id+order_no;
			//change appa to cs for prod and testcs for dev
			//final out
		//out.println(overageLine+" from lines<BR>");
		//out.println( overage+" total<BR>");
		%>
		<%@ include file="order_transfer_bpcs_ds.jsp"%>
		<%

		if(bpcs_order_no == null){
			bpcs_order_no="";
		}
		if(quote_origin==null){
			quote_origin="";
		}

		//if(bpcs_order_no.trim().equals("")&&!(quote_origin.startsWith("change")|quote_origin.startsWith("release")|quote_origin.startsWith("revision")|quote_origin.startsWith("submittal"))){
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
/*
if(base_quote_no== null || base_quote_no.trim().length()==0){
	base_quote_no=order_no;
}
*/
String tempend2="";

		if(!(order_type.startsWith("ADD"))){
			base_quote_no=order_no;
			tempend2=order_no.substring(6,9);
		}
else{
	if(base_quote_no.trim().length()<=0){
		base_quote_no=order_no;
	}
tempend2=base_quote_no.substring(6,9);
}


						// out.println(final_out);
						 BufferedWriter out1 = new BufferedWriter(new FileWriter(dir_path+"\\"+"O"+order_no.substring(0,6)+tempend2+".txt"));
						 out1.write(final_out);
						 out.flush();
						 out1.flush();
						 out1.close();
						// out.println("<BR>about to write to cse<BR>");
						//writing the output to second folder also
						 BufferedWriter out2 = new BufferedWriter(new FileWriter(dir_path1+"\\"+"O"+order_no+".txt"));
						 out2.write(final_out);
						 out2.flush();
						 out2.close();

						out.println(".......Output file created successfully for eRapid Order::"+order_no+"<br><br><br>");
		//}
		//else{

		//	out.println("We have encountered an error matching up to PSA please contact CS Group to resolve issue<BR>");
		//}

						//sending the bills and routings added on July-26'11
						//1) bills transfer start here
									Vector erapid_quote_line=new Vector();Vector bpcs_parent=new Vector();Vector bpcs_child=new Vector();Vector bpcs_child_qty=new Vector();
									Vector bpcs_over_ride=new Vector();Vector bpcs_scrap_factor=new Vector();Vector bpcs_op_no=new Vector();Vector bpcs_comp_ucode=new Vector();
									Vector bpcs_parent_qty=new Vector();Vector bpcs_seq=new Vector();Vector bpcs_bmwhs=new Vector();
									dir_path="\\\\lebhq-erusdev\\TRANSFER\\BPCS_BOM\\";String final_bom_out="";String final_rou_out="";dir_path1="\\\\lebhq-erusdev\\TRANSFER\\BPCS_BOM\\test\\EJC\\";
									out.println("BOM's transfer start......<br>");
							//		if(quote_origin.equals("")|!(quote_origin.startsWith("change")|quote_origin.startsWith("release")|quote_origin.startsWith("revision")|quote_origin.startsWith("submittal"))){
										sql_one="SELECT * FROM cs_bpcs_mbm where doc_number like '"+order_no+"' and doc_line in ("+lines_final+") order by cast(doc_line as integer)";
								//	}else{
								//		sql_one="SELECT * FROM cs_bpcs_mbm where doc_number like '"+order_no+"' and doc_line in ("+lines_final+") order by cast(doc_line as integer)";
								//	}
									ResultSet rs_mbm = stmt.executeQuery(sql_one);
									if (rs_mbm !=null) {
									while (rs_mbm.next()){
									erapid_quote_line.addElement(rs_mbm.getString ("doc_line"));
									bpcs_seq.addElement(rs_mbm.getString ("BSEQ"));
									bpcs_bmwhs.addElement(rs_mbm.getString ("BMWHS"));
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
										 //bpcs WHS
										  String bmwhs=bpcs_bmwhs.elementAt(im).toString();
											if(bmwhs.length()<2){
												String tv="";
												for(int v=0;v<(2-bmwhs.length());v++){
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
									//		out.println("test before"+child_qty+"<br>");
											for (int ii = 0; ii < child_qty.length(); ii ++) {
												if (child_qty.charAt(ii) != '.' && child_qty.charAt(ii) != ',') r += child_qty.charAt(ii);
											}
											child_qty=r;
									//		out.println("test"+child_qty+"<br>");
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
								//	out.println(over_ride+"<br>");
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
										final_bom_out=final_bom_out+seq+bmwhs+parent+child+child_qty+"  "+over_ride+ware_house_header+"000000"+order_no.trim()+erapid_line_no+scrap_factor+op_no+comp_ucode+parent_qty+"\r\n";
									 }//for loop ends
									 if(bpcs_order_no.trim().equals("")&&!(quote_origin.startsWith("change")|quote_origin.startsWith("release")|quote_origin.startsWith("revision")|quote_origin.startsWith("submittal"))){
										 final_bom_out=final_bom_out.toUpperCase();
										}else{
											final_bom_out=final_bom_out.toUpperCase();
											int lastIndex = 0; int countv =0;
											while(lastIndex != -1){
												  lastIndex = final_bom_out.indexOf(order_no.substring(6,9),lastIndex+1);
												  if( lastIndex != -1){
														 countv ++;
														 final_bom_out=final_bom_out.substring(0,lastIndex)+"_00"+final_bom_out.substring(lastIndex+3,final_bom_out.length());
												  }
											}
										}
									//BOM out put to text files
									 BufferedWriter out_bom = new BufferedWriter(new FileWriter(dir_path+"\\"+"B"+order_no+".txt"));
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
							dir_path="\\\\lebhq-erusdev\\TRANSFER\\BPCS_ROU\\";dir_path1="\\\\lebhq-erusdev\\TRANSFER\\BPCS_ROU\\test\\EJC\\";
							out.println("ROU's transfer start......<br>");
							Vector bpcs_rou_parent=new Vector();Vector bpcs_rou_op_no=new Vector();Vector bpcs_rou_op_desc=new Vector();Vector bpcs_rou_work_ctr=new Vector();
							Vector bpcs_rou_bcode=new Vector();Vector bpcs_rou_rlab=new Vector();Vector bpcs_rou_rset=new Vector();	Vector bpcs_rou_whs=new Vector();
							Vector erapid_rou_quote_line=new Vector();Vector bpcs_rou_mhrs=new Vector();Vector bpcs_run_ops=new Vector();
							Vector bpcs_rmove=new Vector();Vector bpcs_rque=new Vector();Vector bpcs_rstyd=new Vector();
							Vector bpcs_rsoup=new Vector();Vector bpcs_rtrtem=new Vector();Vector bpcs_rtoflg=new Vector();
							Vector bpcs_rsbas=new Vector();Vector bpcs_rcold=new Vector();Vector bpcs_rtoutc=new Vector();


						//	if(quote_origin.equals("")| !(quote_origin.startsWith("change")|quote_origin.startsWith("release")|quote_origin.startsWith("revision")|quote_origin.startsWith("submittal"))){
								sql_one="SELECT * FROM cs_bpcs_frt where doc_number like '"+order_no+"' and doc_line in ("+lines_final+") order by cast(doc_line as integer)";
						//	}else{
						//		sql_one="SELECT * FROM cs_bpcs_frt where doc_number like '"+order_no+"' and doc_line in ("+lines_final+") order by cast(doc_line as integer)";
						//	}
							ResultSet rs_frt = stmt.executeQuery(sql_one);
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

			 if(bpcs_order_no.trim().equals("")&&!(quote_origin.startsWith("change")|quote_origin.startsWith("release")|quote_origin.startsWith("revision")|quote_origin.startsWith("submittal"))){
				 final_rou_out=final_rou_out.toUpperCase();
				}else{
					final_rou_out=final_rou_out.toUpperCase();
					int lastIndex = 0; int countv =0;
					while(lastIndex != -1){
						 lastIndex = final_rou_out.indexOf(order_no.substring(6,9),lastIndex+1);
						 if( lastIndex != -1){
							   countv ++;
							   final_rou_out=final_rou_out.substring(0,lastIndex)+"_00"+final_rou_out.substring(lastIndex+3,final_rou_out.length());
						 }
					}
				}
							//ROU out put to text files
							 BufferedWriter out_rou = new BufferedWriter(new FileWriter(dir_path+"\\"+"R"+order_no+".txt"));
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



						//the last step sending the mail to the rep.
String name=request.getParameter("userSessionId");

					String to="";
										    //out.println(thisRep+"::"+name+"::<BR>"+"select  TOP 1 email from cs_reps where rep_no='"+thisRep+"' and user_id in('"+name+"','') ORDER BY user_id DESC");
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
						String message="Thank you for the order.";
		//out.println("Test"+thisRep+"::"+rep_no+"Order rep"+order_rep_no);
		out.println(" Quote Origin value : "+quote_origin);
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
		<% if(!quote_origin.equals("sample")){%>
		<%@ include file="order_acknowledgement_email.jsp"%>
		<%
		} %>
		<%

		//email logging
/*				try	{
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
		}*/
//email logging done



//db closing
stmt.close();
//myConn.commit();
myConn.close();
//stmt_psa.close();
//myConn_psa.close();
stmts.close();
myConns.close();

		%>

		<!-- 			<script type="text/javascript"> -->
		// 			alert('Order transfer is successfully. We are closing window for you.');
		//     window.close();
		<!-- 	</script> -->

	</body>
</html>
<%
}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>