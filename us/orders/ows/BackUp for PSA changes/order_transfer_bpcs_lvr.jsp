<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<SCRIPT LANGUAGE="JavaScript">
		<!-- Begin
		function goHere(){
			//window.close();
		}
	</script>
	<head>
		<title>Transfer to BPCS</title>
	</head>
	<body onload="goHere()">
		<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.lang.*" import="java.io.*" import="java.text.*" import="java.math.*" errorPage="error.jsp" %>
		<%@ include file="db_con.jsp"%>
		<%
		int lineIncrease=0;
		String order_no = request.getParameter("order");
		String si = request.getParameter("sections");
		String thisRep=request.getParameter("rep_no");
		boolean isGood=true;

		//myConn.close();
		String url="WShttp://"+application.getInitParameter("HOST")+"/erapid/us/orders/ows/order_sheet.jsp?sections="+si+"&orderNo="+order_no+"&rep_no="+thisRep;
		//out.println(url+"<BR>");
		//out.println(si+":"+order_no);
		%>
		<%@ include file="../../../db_con_psa.jsp"%>
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
					String dir_path="D:\\TRANSFER\\BPCS_OE\\";String final_out="";String final_oh_out="";String final_os_out="";String final_oi_out="";
					String final_on_out="";String final_oc_out="";String final_ic_out="";
		//
		String section_group="";Vector si_final = new Vector();Vector li_final = new Vector();String Project_name="";String product_id="";String lines_final = "";
		String overage="";String freight_cost="";String handling_cost="";String setup_cost="";double config_price=0;double total_sale_price=0;
		String rep_no="";String quote_type="";String psa_quote_id="";String commission ="";
		//reteriving the lines from the sections
					out.println("<br>Out put Transfer Started....... "+"to "+dir_path+ " folder for upload to BPCS"+"<br><br><br>");
					ResultSet rs_find = stmt.executeQuery("SELECT * FROM cs_quote_sections where order_no like '"+order_no+"'");
					if (rs_find !=null) {
					while (rs_find.next()){
					section_group=rs_find.getString ("section_group");
		//			out.println("Testing"+section_group);
					 }
					}
					rs_find.close();
		// Project info
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
							}else{freight_cost=String.valueOf(for14.format(0.0));}
							if(rs_project.getString("handling_cost")!= null && rs_project.getString("handling_cost").trim().length()>0){
								handling_cost= rs_project.getString("handling_cost");
							}else{handling_cost="0";}
							if(rs_project.getString("setup_cost")!= null && rs_project.getString("setup_cost").trim().length()>0){
								setup_cost= String.valueOf(for14.format(new Double(rs_project.getString("setup_cost")).doubleValue()));
							}else{setup_cost=String.valueOf(for14.format(0.0));}
							quote_type=rs_project.getString("project_type");
							if(!(quote_type != null)){quote_type="";}
							psa_quote_id=rs_project.getString("project_type_id");
							commission = rs_project.getString("commission");
		//					config_price= rs_project.getString("configured_price");
						}
					}
					rs_project.close();

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
		double c_cost=0.0;double sellprice_factor=0;double lcost_factor=0;
		// Getting the costs
				ResultSet rs3 = stmt.executeQuery("SELECT (sum(RUN_COST)+sum(SETUP_COST)+sum(STD_COST)) AS C_COST FROM cs_costing where order_no like '"+order_no+"' and item_no in ("+lines_final+") ");
			   while ( rs3.next() ) {c_cost = rs3.getDouble(1); }
			 rs3.close();

				String query="select * from cs_lvr_sp_factor where product_id='"+product_id+"' and com_percent='"+commission+"'";
					ResultSet myResult2=stmt.executeQuery(query);
		//			out.println("test"+query);
					if (myResult2 !=null) {
						while (myResult2.next()){
						sellprice_factor=myResult2.getDouble(2);
						lcost_factor=myResult2.getDouble(3);
						}
					}
					double d2=c_cost+lcost_factor;
		  //      	out.println("test1 cost:"+c_cost+"lcost factor::"+lcost_factor+"sell price factor::"+sellprice_factor+"commission::"+commission+"<br>");
					if (rep_no.equals("147")||rep_no.equals("351")){
					config_price=((d2/sellprice_factor)*1.15);			// add extra 15% to the cost price.
					}
					else {
					config_price=(d2/sellprice_factor);
					}

		total_sale_price=config_price+Double.parseDouble(overage)+Double.parseDouble(handling_cost)+Double.parseDouble(freight_cost)+Double.parseDouble(setup_cost);
		//out.println("config price"+config_price+"Test sale price:"+total_sale_price+"<br>");
		// commission dollars
		double comm_dollar=0;
		comm_dollar=((config_price*0.91)*new Double(commission).doubleValue())/100;
		//out.println("config price"+config_price+"Test sale price:"+total_sale_price+"comm_dollar"+comm_dollar+"<br>");

		//getting the last 4 digits for the bpcs
		//		out.println("config_price before"+config_price+"<br>");
				  double cents=Math.round(config_price)-config_price;
		 //       	out.println(cents+"cents<BR>");
				config_price=config_price+cents;
		//		out.println("config_price sfter"+config_price+"<br>");

		//db connectons
		 //billing customer
				String cust_name1="";String cust_addr1="";String cust_addr2="";String city="";String state="";String zip_code="";
				String phone="";String fax="";String contact_name="";String customer_po_no="";String payment_terms="";String bpcs_cust_no="";
				String invoice_info="";	String cs_order_type="";String email_acknowledgement="";String bill_email="";
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
				bill_email=rs_bill.getString("email");
				email_acknowledgement=rs_bill.getString("email_acknowledgement");
											    }
							 }
		if(email_acknowledgement==null){
			email_acknowledgement="";
		}
		if(bill_email==null){
			bill_email="";
		}
		//Shipping
		//Ship variables
		String ship_name="";String ship_addr1="";String ship_addr2="";String ship_city="";String ship_state="";
		String ship_zip="";String ship_phone="";java.sql.Date ship_rdate=null;String ship_date="";
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
				//if(!(ship_rdate != null)){
					//ship_rdate="";
				//}
									   }
								   }

		// Getting the orderinfo
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
												}
											}
		//eorders for the
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

				//rep_no inti
		String spec_rep_acct_id="";String terr_rep_acct_id="";String arch_acct_id="";String order_rep_acct_id="";// for different accounts
		//out.println(quote_type+"<--<BR>");

			if(quote_type.equals("PSA")){
				String psa_pid="";
			   ResultSet rs_psa_reps = stmt_psa.executeQuery("SELECT * FROM dba.quotation where quote_id like '"+psa_quote_id+"%"+"' order by 1 desc ");
			  while ( rs_psa_reps.next() ) {
					 psa_pid= rs_psa_reps.getString("project_id");
				   //out.println(psa_pid+" this is the psa product type");
			   }
			   rs_psa_reps.close();
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
					if(new Double(psaProj.getString(1)).doubleValue() >0){rep_no=thisRep;}
					else{isGood=false;}
				}
			}
			psaProj.close();
		}
				// out put to text files started
				//oh out
				if(bpcs_cust_no==null){bpcs_cust_no="000000";}if(cust_name1==null){cust_name1=" ";}if(cust_addr1==null){cust_addr1=" ";}if(cust_addr2==null){cust_addr2=" ";}
				if(city==null){city=" ";}if(state==null){state=" ";}if(zip_code==null){zip_code=" ";}if(phone==null){phone=" ";}if(fax==null){fax=" ";}if(contact_name==null){contact_name=" ";}
				if(customer_po_no==null){customer_po_no=" ";}if(payment_terms.startsWith("NET")){payment_terms=" ";}else{payment_terms="V";}if(Project_name==null){Project_name=" ";}
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
		//									out.println("the T3 value: "+t3.length()+"vb"+v+"***"+tv+"<br>");
										    }
											bpcs_cust_no=tv+bpcs_cust_no;
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
		final_oh_out=final_oh_out+"HO"+order_no+bpcs_cust_no+cust_name1+cust_addr1+cust_addr2+city+state+zip_code+phone+fax+contact_name+customer_po_no+payment_terms+Project_name+ship_date+email_to+"\r\n";
			  // oh out done
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
									final_os_out=final_os_out+"SO"+order_no+ship_name+ship_addr1+ship_addr2+ship_city+ship_state+ship_zip+ship_phone+contact_name+"\r\n";
			//so out done
		// IO rules are different for products change them accordingly
		    //IO out begins
						String lvr_bpcs_item="LVR";String lvr_qty="1.000";String config_price_st=String.valueOf(for14.format(config_price));
						String line_no_text="";String comm_dollar_st=String.valueOf(for12.format(comm_dollar));String comperc=for19.format(new Double(commission).doubleValue());
						String over_price_string=for12.format(new Double(overage).doubleValue());String fc_value="0.00";
						if(product_id.equals("LVR")){
						if(lvr_bpcs_item.length()<15){
						String tv="";
						for(int v=0;v<(15-lvr_bpcs_item.length());v++){
						tv=" "+tv;
						   }
						lvr_bpcs_item=lvr_bpcs_item+tv;
						}
						r="";
						for (int i = 0; i < lvr_qty.length(); i ++) {
							if (lvr_qty.charAt(i) != '.' && lvr_qty.charAt(i) != ',') r +=lvr_qty.charAt(i);
						}
						lvr_qty=r;
						if(lvr_qty.length()<11){
						String tv="";
						for(int v=0;v<(11-lvr_qty.length());v++){
						tv="0"+tv;
						   }
						lvr_qty=tv+lvr_qty;
						}
						r="";
						for (int i = 0; i < config_price_st.length(); i ++) {
							if (config_price_st.charAt(i) != '.' && config_price_st.charAt(i) != ',') r += config_price_st.charAt(i);
						}
						config_price_st=r;
						if(config_price_st.length()<14){
							String tv="";
							for(int v=0;v<(14-config_price_st.length());v++){
								tv="0"+tv;
							}
							config_price_st=tv+config_price_st;
						}
						if(line_no_text.length()<3){
							String tv="";
							for(int v=0;v<(3-line_no_text.length());v++){
								tv="0"+tv;
							  }
							line_no_text=tv+line_no_text;
						}
						r="";
						for (int i = 0; i < comperc.length(); i ++) {
							if (comperc.charAt(i) != '.' && comperc.charAt(i) != ',') r += comperc.charAt(i);
						}
						comperc=r;
						if(comperc.length()<12){
						String tv="";
						for(int v=0;v<(12-comperc.length());v++){
						tv="0"+tv;
						   }
						comperc=tv+comperc;
						}
						r="";
						for (int i = 0; i < comm_dollar_st.length(); i ++) {
							if (comm_dollar_st.charAt(i) != '.' && comm_dollar_st.charAt(i) != ',') r += comm_dollar_st.charAt(i);
						}
						comm_dollar_st=r;
						if(comm_dollar_st.length()<15){
						String tv="";
						for(int v=0;v<(15-comm_dollar_st.length());v++){
						tv="0"+tv;
						   }
						comm_dollar_st=tv+comm_dollar_st;
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
						final_oi_out=final_oi_out+"IO"+order_no+lvr_bpcs_item+lvr_qty+config_price_st+"\r\n";
						final_ic_out=final_ic_out+"DI"+order_no+line_no_text+lvr_bpcs_item+config_price_st+rep_no+"001"+comperc+comm_dollar_st+"100000000000"+over_price_string+fc_value+"\r\n";
						out.println("configured price: "+config_price_st+"<br>");
						out.println("commission dollars: "+comm_dollar_st+"<br>");
						out.println("commission %: "+comperc+"<br>");
						}// product is LVR
						else if(product_id.equals("GRL")){
						}// product is GRL
		// getting other IO outs

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
							final_oi_out=final_oi_out+"IO"+order_no+setup_part+setup_bpcs_qty+setup_cost+"\r\n";
						}//setup cost
						// Getting the freight_cost
						if(Double.parseDouble(freight_cost)>0){
						String freight_part="FREIGHT"+product_id;
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
							final_oi_out=final_oi_out+"IO"+order_no+freight_part+freight_bpcs_qty+freight_cost+"\r\n";
						}//freight cost
		// IO out ends

		// ORder notes begin


		  //email acknowledgement
		  //out.println("HERE"+email_acknowledgement+"::<BR>");
		 if(email_acknowledgement != null && email_acknowledgement.equals("on")){
			String acknowledgenote="EMAIL CUSTOMER ACKNOWLEDGEMENT TO: "+bill_email;
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





			//no out begins
			 //SUBMITTALS
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
				//submitas done
				//additonal docs begin
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
				//additional docs done
					// Invoice info start
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
				// Invoice info done
				//New customer begin
		// new customer 000
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
					// New customer end
		// Special Notes start

		    if(special_notes != null && special_notes.trim().length()>0 ){
				String cust_oo="Special notes: "+special_notes;
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
		// special Notes end
			    if(copies_requested != null && copies_requested.trim().length()>0 ){
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
			 }


		    if(order_notes != null && order_notes.trim().length()>0 ){
				String cust_oo="Order notes: "+order_notes;
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
					//out.println("no6<BR>");
				 //out.println("Test"+bpcs_cust_no);
			 }
		    //no out ends
		//order notes end no record
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
							}
							//if(cs_order_type.startsWith("BUY")){cs_order_type="B";}else{cs_order_type="R";}
					// fact_per formatting
							String fc_perc="09.000";;
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
		//fact per


				//co out starts
				final_oc_out=final_oc_out+"CO"+order_no+comperc+comm_dollar_st+over_price_string+fc_perc+fc_value+rep_no+"001"+"100000000000"+comm_dollar_st+"000000000000"+over_price_string+order_no+" "+quote_type+"000000"+cs_order_type+"\r\n";
				//co out ends


		// final writing to the folder
						 final_out=final_oh_out+final_os_out+final_oi_out+final_on_out+final_oc_out+final_ic_out+url;
						  final_out=final_out.toUpperCase();
						 //;
						 BufferedWriter out1 = new BufferedWriter(new FileWriter(dir_path+"\\"+"O"+order_no+".txt"));
						 out1.write(final_out);
						 out.flush();
						 out1.flush();
						 out1.close();
						out.println("Output file created succesfully for eRapid Order... "+order_no+"<br><br><br>");
		//}
		//else{

		//	out.println("We have encountered an error matching up to PSA please contact CS Group to resolve issue<BR>");
		//}
		stmt.close();
			myConn.commit();
			myConn.close();
		stmt_psa.close();
		myConn_psa.close();


		%>


