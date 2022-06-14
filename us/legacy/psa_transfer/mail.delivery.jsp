<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<html>
	<head>
		<title>Quote Mailing</title>
		<link rel='stylesheet' href='style1.css' type='text/css'/>
	</head>
	<body>
		<h1>EMail Notification::</h1>
		<%@ page language="java" import="javax.mail.*" import="java.io.*" import="java.awt.Insets" import="org.zefer.pd4ml.PD4ML" import="org.zefer.pd4ml.PD4Constants" import="java.util.*" import="java.math.*" import="java.sql.*" import="javax.mail.internet.*" import="javax.activation.*" import="java.net.*" import="java.text.*" errorPage="error.jsp" %>

		<%@ include file="../../../db_con.jsp"%>
		<%
			String host ="LEBHQ-SMTP01.c-sgroup.com";
			String server = application.getInitParameter("HOST");

				    String q_no = request.getParameter("q_no");

				 String from = request.getParameter("from") ;
				 String to = request.getParameter("to");
				 String cc = request.getParameter("cc");
				 String copy = request.getParameter("copy");
				 String useremail=request.getParameter("useremail");
				 String total=request.getParameter("total");
				 if(total == null){
					total="";
		}
				// out.println(copy+"::"+to+"::"+from+"::"+cc);
				 if(copy != null && copy.equals("on")){
					if(useremail.trim().length()>0){
						if(cc != null && cc.trim().length()>0){
							cc=cc+","+useremail;
						}
						else{
							cc=useremail;
						}
					}
				 }
				 String rep_message = request.getParameter("message");
				 String project_type = request.getParameter("project_type");
		//out.println(project_type+":: project type");
				 String product = request.getParameter("product_id");
				String o_cost = request.getParameter("overage");
				String handling_cost = request.getParameter("handling_cost");
				String freight_cost = request.getParameter("freight_cost");
				String project_name = request.getParameter("project_name");
				String tp = request.getParameter("tp");//tp
				String show=request.getParameter("show");//show commission %
				//Rep info
				String rep_account= request.getParameter("rep_account");
				String address1= request.getParameter("address1");
				String address2= request.getParameter("address2");
				String rep_city= request.getParameter("rep_city");
				String rep_state= request.getParameter("state");
				String rep_zip_code= request.getParameter("rep_zip_code");
				String rep_telephone= request.getParameter("rep_telephone");
				String rep_fax= request.getParameter("rep_fax");
				String rep_email= request.getParameter("rep_email");
				String rep_name = request.getParameter("rep_name");
				String tearsheet=request.getParameter("tearsheet");
				String credit=request.getParameter("credit");
				//Getting the rep name
				HttpSession UserSession_rep = request.getSession();
				String session_rep_name= "";
				if(UserSession_rep!=null){
		//				String name= UserSession1.getAttribute("username").toString();
						if(UserSession_rep.getAttribute("userNameRQS") != null){
							session_rep_name= UserSession_rep.getAttribute("userNameRQS").toString();
						}
				   }
			//Checking for nulls
		if(rep_account==null){rep_account="";}
		if(rep_city==null|rep_city.trim().startsWith("nu")|rep_city.trim().equals("")){rep_city="";}
		if(rep_state==null|rep_state.trim().startsWith("nu")|rep_state.trim().equals("")){rep_state="";}
		if(rep_zip_code==null|rep_zip_code.trim().startsWith("nu")|rep_zip_code.trim().equals("")){rep_zip_code="";}
		if(rep_telephone==null|rep_telephone.trim().startsWith("nu")|rep_telephone.trim().equals("")){rep_telephone="";}
		if(rep_fax==null|rep_fax.trim().startsWith("nu")|rep_fax.trim().equals("")){rep_fax="";}
		if(rep_email==null){rep_email="";}
		if(rep_name==null){rep_name="";}
		if(address1==null){address1="";}
		if(address2==null){address2="";}
		if (o_cost==null){o_cost="0";}
		if (handling_cost==null){handling_cost="0";	}
		if (freight_cost==null){freight_cost="0";}
		//For internal quotes
				String QuoteID = request.getParameter("QuoteID");//Login id
				String AcctID = request.getParameter("AcctID");//totals
				String UserID= request.getParameter("UserID");//totals
				String q_type= request.getParameter("q_type");//totals
				String group_id= request.getParameter("group_id");//totals
				String commission= request.getParameter("commission");//totals
		NumberFormat for12 = NumberFormat.getInstance();
		for12.setMaximumFractionDigits(1);

		//Getting the database connections
		String new_page="";int sections=0;String final_com_perc="";
		if(!(project_type==null||project_type.equals("null"))){
				ResultSet rs = stmt.executeQuery("SELECT section_page,sections FROM cs_quote_sections where order_no = '"+q_no+"'");
				if (rs !=null) {
				while (rs.next()) {
						new_page= rs.getString("section_page");
						sections= rs.getInt("sections");
					}
				}
				rs.close();
				// Getting data from csquotes table
			int tot_lines=0;double tot_sum=0;double totcomm_dol=0;double totprice_dis=0;
			Vector desc=new Vector();Vector line_item=new Vector();Vector price=new Vector();Vector setup_cost1=new Vector();
			Vector block_id=new Vector();Vector fact_per=new Vector();Vector std_cost=new Vector();Vector run_cost=new Vector();Vector discount=new Vector();
				ResultSet rs3 = stmt.executeQuery("SELECT * FROM csquotes WHERE order_no = '"+q_no+"' ORDER BY cast(Line_no as integer)");
			   while ( rs3.next() ) {
				line_item.addElement(rs3.getString ("Line_no"));
				desc.addElement(rs3.getString ("Descript"));
				price.addElement(rs3.getString ("Extended_Price"));
				tot_sum=tot_sum+new Double(rs3.getString("Extended_Price")).doubleValue();
				block_id.addElement(rs3.getString("Block_ID"));
				fact_per.addElement(rs3.getString("field16").trim());
				discount.addElement(rs3.getString("field19"));
				if(rs3.getString("run_cost") != null && rs3.getString("run_cost").trim().length()>0){run_cost.addElement(rs3.getString("run_cost"));}
				else{run_cost.addElement("0");}
				if(rs3.getString("std_cost") != null && rs3.getString("std_cost").trim().length()>0){std_cost.addElement(rs3.getString("std_cost"));}
				else{std_cost.addElement("0");}
				if(rs3.getString("setup_cost") != null && rs3.getString("setup_cost").trim().length()>0){setup_cost1.addElement(rs3.getString("setup_cost"));}
				else{setup_cost1.addElement("0");}
				tot_lines++;
				}
		// Checking the no of lines
				Vector items=new Vector();int line=0;
				ResultSet rs1 = stmt.executeQuery("SELECT doc_line FROM doc_line where doc_number like '"+q_no+"' order by cast(doc_line as integer)");
			   while ( rs1.next() ) {
				items.addElement(rs1.getString("doc_line"));
				line++;
				}
		// Checking the no of lines	done
		//Checking for the doc_header
				String prio="";
				ResultSet e_order = stmt.executeQuery("SELECT * FROM doc_header where doc_number like '"+q_no+"' ");
				if (e_order !=null) {
			   while (e_order.next()) {
				prio= e_order.getString("doc_priority");
										}
									}
		//Checking for the doc_header done
		 // Calculating the price.
						for(int k=0;k<line;k++){
						   for (int mn=0;mn<line_item.size();mn++){
								if ((line_item.elementAt(mn).toString()).equals((items.elementAt(k).toString()))){
									  String totwt=price.elementAt(mn).toString();//Extended_Price
									  String fact=fact_per.elementAt(mn).toString().trim();//FIELD16
									  if ((fact.equals(""))){fact="0.0"; }
									  BigDecimal d1 = new BigDecimal(totwt);
									 BigDecimal d2 = new BigDecimal(fact);
									  BigDecimal d3 = d1.multiply(d2);
									  totprice_dis=totprice_dis+d1.doubleValue();//Total material price for the job
									  totcomm_dol= totcomm_dol+d3.doubleValue();// final commission dollars for the job
								}
						   }
						}// for all the lines in the doc_line table
					if(product.equals("LVR")|product.equals("REP_LVR")|product.equals("BV")|product.equals("GCP")){
						final_com_perc=commission;
					}
					else if(product.equals("ADS")){
						ResultSet CS_ADS_PRICE_CALC = stmt.executeQuery("SELECT commission FROM CS_ADS_PRICE_CALC where order_no like '"+q_no+"' and model = 'GLOBAL'");
						if (CS_ADS_PRICE_CALC !=null) {
					   while (CS_ADS_PRICE_CALC.next()) {
					   final_com_perc=	 CS_ADS_PRICE_CALC.getString("commission");
												}
											}
						CS_ADS_PRICE_CALC.close();
					}
					else{
						//if (prio.equals("E")){
						 //final_com_perc=for12.format(((totcomm_dol/(totprice_dis))*100));
						//}
						//else{
						final_com_perc=for12.format(((totcomm_dol/(totprice_dis*0.91))*100));
						//}
					}
		//	out.println("Tot com"+final_com_perc+"com doller:: "+totcomm_dol+"did::"+totprice_dis);
			rs1.close();
		//	rs3.close();
			e_order.close();
			stmt.close();
			myConn.close();
		}
					try{
								//out.println(host);
		    //                    String from = "erapid@c-sgroup.com" ;
		    //                    String to ="vmodugula@c-sgroup.com";
						    String subject = "Do Not Reply - Construction Specialties Quotation "+q_no+" for \'"+project_name+"\' Project";
						    if(product.equals("ELM")){
							//subject = "Do Not Reply - Elementz Commercial Flooring Quotation "+q_no+" for \'"+project_name+"\' Project";
							subject = "Elementz Commercial Flooring Quotation "+q_no+" for \'"+project_name+"\' Project";
						    }
						    //if(from.indexOf("@c-sgroup.com")>0){
								else{
									subject = "Construction Specialties Quotation "+q_no+" for \'"+project_name+"\' Project";
									if(product.equals("ELM")){
										subject = "Elementz Commercial Flooring Quotation "+q_no+" for \'"+project_name+"\' Project";
									}

								}
						    String message = "";


						    if(from.indexOf("@c-sgroup.com")<0){
							  message = message+"PLEASE DO NOT REPLY TO THIS EMAIL.  CONTACT YOUR REPRESENTATIVE DIRECTLY.  \r\r ";
								}



								if(product.equals("ELM")){
										message = message+"Below is the Elementz Commercial Flooring quote::"+q_no+" for Project \'"+project_name+"\' attached.";
									}
									else{
									if(!(project_type==null||project_type.startsWith("nul"))){
										if (show!=null){
											message = message+"Below is the Construction Specialties quote::"+q_no+" attached.";
											message = message+"\r\nProject:: \'"+project_name+"\' ";
											message=message+"\rCommission(%):: "+final_com_perc;
										}
									}
									else{
										message = message+"Below is the Construction Specialties quote::"+q_no+" for Project \'"+project_name+"\' attached.";
									}
								}
								message=message+"\r\n\n";
								message=message+"For any additional information contact::";
								if(!product.equals("ELM")){
									if(!(rep_name==null||rep_name.trim().startsWith("nu")||rep_name.trim().equals(""))){message=message+"\r\t\t"+rep_name;}
								}
								if(!(rep_account==null||rep_account.trim().startsWith("nu")||rep_account.trim().equals(""))){message=message+"\r\t\t"+rep_account;}
								if(!(address1==null||address1.trim().startsWith("nu")||address1.trim().equals(""))){message=message+"\r\t\t"+address1;}
								if(!(address2==null||address2.trim().startsWith("nu")||address2.trim().equals(""))){message=message+"\r\t\t"+address2;}
								message=message+"\r\t\t"+rep_city+" "+rep_state+" "+rep_zip_code;
								message=message+"\r\t\t"+"Tel: "+rep_telephone+" Fax: "+rep_fax;
								if(!(rep_email==null||rep_email.trim().startsWith("nu")||rep_email.trim().equals(""))){message=message+"\r\t\t"+"Email: "+rep_email;}
								//adding the additional rep comments also
								message=message+"\r\n\n"+rep_message+"\r\n\n";
								message=message+"\r\n\n"+"This e-mail was sent by: "+session_rep_name+"\r\n\n";
								message=message.replaceAll("<br>","\n\t\t");
						    String localfile = "d:\\custom\\quotes\\images\\cs_logo.jpg";
						    String attachName = "quote no "+q_no+".pdf";
								 String url="";
								 String message_footer="\r\n";
								message_footer=message_footer+"\n\n\n[THIS MESSAGE WAS AUTOGENERATED BY THE CONSTRUCTION SPECIALTIES QUOTE SYSTEM]";
								message_footer=message_footer+"\n====================";
								message_footer=message_footer+"\nThis email message and any files transmitted with it is for the sole ";
								message_footer=message_footer+"\nuse of the intended recipient(s) and may contain confidential and privileged ";
								message_footer=message_footer+"\ninformation. Any unauthorized review, use, disclosure or distribution of this";
								message_footer=message_footer+"\nemail content is prohibited. If you are not the intended recipient, please";
								message_footer=message_footer+"\ndestroy all paper and electronic copies of the original message.";
								message_footer=message_footer+"\n====================";
								//Gettig the right URL based on the product and type of quote.
								if(project_type==null||project_type.equals("null")||project_type.trim().length()==0||product.equals("ELM")){
									if(product.equals("ELM")||product.equals("GE")){
										String tp1=tp;
										if(tp1 !=null && tp1.startsWith("$")){
											tp1=tp1.substring(1);
										}
										tp1=tp1.replaceAll(",","");
										url= ""+application.getInitParameter("HOST")+"/erapid/us/quotes/show_quotes_ge.jsp?orderNo="+q_no+"&type="+q_type+"&tp="+tp+"&total="+total+"&tp1="+tp1;
									}
									else{
										url= ""+application.getInitParameter("HOST")+"/erapid/us/quotes/show_quotes.jsp?orderNo="+q_no+"&type="+q_type+"&tp="+tp+"&total="+total;
									}

								}
								else{//if it's internal quote
								    if (q_type.equals("1")){////Types and quantities
								    /*
													if (product.equals("EFS")){
														 if ((new_page==null)||(new_page.equals("0"))||(sections<=0)){
															url= application.getInitParameter("HOST")+"/word_quotes/show_quotes_psa.asp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&type=1" ;
														}
														 else{
															url= application.getInitParameter("HOST")+"/word_quotes/show_quotes_psa_page.asp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&type=1" ;
														 }
													 }else{
													 */
														if (product.equals("LVR")|product.equals("BV")|product.equals("DADE_LVR")) {
															url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes1.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&type=1" ;
														  }
														  else if(product.equals("GRILLE")){
															 url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes_grille.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&type=1" ;
														  }
														    else if((product.equals("GE")|product.equals("GCP"))){
															url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes3.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&type=1" ;
														    }else if((product.equals("ADS"))){
															url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes4.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&type=1" ;
														    }
														    else if(group_id.toUpperCase().startsWith("CAN")){
																												 url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes_cdn.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&group_id="+group_id +"&type=1" ;
														 }
														    else if((product.equals("EFS"))){
																						    if(project_type != null && project_type.equals("SFDC")){
																							   url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_sfdc_quotes3.jsp?order_no="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&group_id="+group_id +"&type=1" ;

																						    }
																						    else{
																							   url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes_efs.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&group_id="+group_id +"&type=1" ;
																						    }
														    }
														    else{
															url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&group_id="+group_id +"&type=1" ;
														    }
													// }
									}
									else if (q_type.equals("2")){//Plans & Specs
									/*
													if (product.equals("EFS")){
														 if ((new_page==null)||(new_page.equals("0"))||(sections<=0)){
															url= application.getInitParameter("HOST")+"/word_quotes/show_quotes_psa.asp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&type=3" ;
														}
														 else{
															url= application.getInitParameter("HOST")+"/word_quotes/show_quotes_psa_page.asp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&type=3" ;
														 }
													 }else{
													 */
														if (product.equals("LVR")|product.equals("BV")|product.equals("DADE_LVR")) {
															url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes1.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&type=3" ;
														}
														else if(product.equals("GRILLE")){
															url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes_grille.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&type=3";
														  }
														else if((product.equals("GCP"))){
															url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes3.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&group_id="+group_id +"&type=3" ;
														}
														else if ((product.equals("ADS"))) {
															url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes4.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&type=3" ;
														}
														else if(group_id.toUpperCase().startsWith("CAN")){
																											url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes_cdn.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&group_id="+group_id +"&type=3" ;
														}
														else if((product.equals("EFS"))){
																						    if(project_type != null && project_type.equals("SFDC")){
																							   url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_sfdc_quotes3.jsp?order_no="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&group_id="+group_id +"&type=3" ;
																						    }
																						    else{
																							   url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes_efs.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&group_id="+group_id +"&type=3" ;
																							}


														}
														else{
															url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&group_id="+group_id +"&type=3" ;
														}
													 //}
									}
									else if (q_type.equals("3")){//Line & Item
												if((product.equals("GE")|product.equals("GCP"))){
													url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes3.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&group_id="+group_id +"&type=2" ;
												    }
												    else if((product.equals("ADS"))){
													url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes4.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&group_id="+group_id +"&type=2" ;
												    }
												    else if(group_id.toUpperCase().startsWith("CAN")){
														url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes_cdn.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&group_id="+group_id +"&type=2" ;
													}
												    else{
													url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&group_id="+group_id +"&type=2" ;
												    }
									}
									else if(q_type.equals("4")){
										url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&group_id="+group_id +"&type=4" ;
									}
									else if(q_type.equals("5")){
										url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&group_id="+group_id +"&type=5" ;
									}
									else if(q_type.equals("6")){
										url= application.getInitParameter("HOST")+"/erapid/us/quotes/show_psa_quotes.jsp?orderNo="+q_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&group_id="+group_id +"&type=6" ;
									}
								}

							   // out.println("Test"+url+" product"+product+"pt"+project_type+"TO"+to+"::<BR><BR>");
								//
						    Properties prop =System.getProperties();
						    prop.put("mail.smtp.host",host);
						    Session ses1  = Session.getDefaultInstance(prop,null);
						    MimeMessage msg = new MimeMessage(ses1);
						    //out.println("ID="+product+"<br>");
						    //msg.addFrom(new InternetAddress().parse(from)); //old way of sending email - SPAM!
						    String valid_from = "";
				if(from.indexOf("@")>0){
					 valid_from = from.substring(from.indexOf("@"));
						if(valid_from.equals("@c-sgroup.com")){
							msg.addFrom(new InternetAddress().parse(from));
						}else{
							msg.addFrom(new InternetAddress().parse("no_reply_"+product.toLowerCase()+"@c-sgroup.com"));
						}
					} else {
						msg.addFrom(new InternetAddress().parse("no_reply_"+product.toLowerCase()+"@c-sgroup.com"));
					}
						    msg.setReplyTo(new InternetAddress().parse(from));
						    msg.addRecipients(Message.RecipientType.TO,new InternetAddress().parse(to));
					msg.addRecipients(Message.RecipientType.CC,new InternetAddress().parse(cc));
						    msg.setSubject(subject);
						    // Create the message part
						    BodyPart messageBodyPart = new MimeBodyPart();
						    // Fill the message
						    messageBodyPart.setText(message);
						    Multipart multipart = new MimeMultipart();
						    multipart.addBodyPart(messageBodyPart);
						    // Part two is attachment
						    messageBodyPart = new MimeBodyPart();

						    /*
						DataSource source = new URLDataSource(new URL("http://"+url));
						messageBodyPart.setDataHandler(new DataHandler(source));
						messageBodyPart.setFileName(attachName);
						multipart.addBodyPart(messageBodyPart);
						msg.setContent(multipart);
						messageBodyPart = new MimeBodyPart();
							*/
						   // out.println("HERE");
					java.util.Date date1x=new java.util.Date();
					String fileNameAdderx=""+date1x.getTime()+"x";
					String fileNamex=q_no+fileNameAdderx+".pdf";
					File fxx = new File("D:/erapid/shared/"+fileNamex);
					java.io.FileOutputStream fosx = new java.io.FileOutputStream(fxx);
					java.net.URL targetURLx = new java.net.URL ("http://"+url) ;
					PD4ML htmlx = new PD4ML();

					//Insets insetx=new Insets(0,0,0,0);
					//htmlx.setPageInsets(insetx);
					htmlx.setPageSize(PD4Constants.LETTER);
					//htmlx.setHtmlWidth(1000);
					htmlx.render(targetURLx, fosx);

						    DataSource source = new URLDataSource(new URL("http://"+server+"/erapid/shared/"+fileNamex));
						    messageBodyPart.setDataHandler(new DataHandler(source));
						    messageBodyPart.setFileName(attachName);
						    multipart.addBodyPart(messageBodyPart);
						    msg.setContent(multipart);
						    messageBodyPart = new MimeBodyPart();







						   if(tearsheet != null && tearsheet.equals("on")){


						java.util.Date date1=new java.util.Date();
						String fileNameAdder=""+date1.getTime();
						String fileName=q_no+fileNameAdder+".pdf";

						String urlx="http://"+ application.getInitParameter("HOST")+"/erapid/us/reports/tear.home.jsp?orderNo="+q_no+"&pid=1";
						File fx = new File("D:/erapid/shared/"+fileName);
						java.io.FileOutputStream fos = new java.io.FileOutputStream(fx);
						java.net.URL targetURL = new java.net.URL (urlx) ;
						PD4ML html = new PD4ML();
						//html.setPageSize(html.changePageOrientation(PD4Constants.LETTER));
						//html.setHtmlWidth(1500);
						//html.fitPageVertically() ;


						Insets inset=new Insets(0,0,0,0);
						html.setPageInsets(inset);
						html.setPageSize(html.changePageOrientation(PD4Constants.LETTER));
						html.setHtmlWidth(1000);
						html.render(targetURL, fos);

							DataSource source2 = new URLDataSource(new URL("http://"+server+"/erapid/shared/"+fileName));
							 messageBodyPart.setDataHandler(new DataHandler(source2));
						    messageBodyPart.setFileName("tearsheet.pdf");
							 multipart.addBodyPart(messageBodyPart);
							 msg.setContent(multipart);
							 messageBodyPart = new MimeBodyPart();



						    }
					if(credit != null && credit.equals("on")){
						java.util.Date date1=new java.util.Date();
						String fileNameAdder=""+date1.getTime();
						String fileName=q_no+fileNameAdder+"credit.pdf";
						String urlx="http://"+ application.getInitParameter("HOST")+"/erapid/us/reports/credit_application.jsp?order_no="+q_no;
						File fx = new File("D:/erapid/shared/"+fileName);
						java.io.FileOutputStream fos = new java.io.FileOutputStream(fx);
						java.net.URL targetURL = new java.net.URL (urlx) ;
						PD4ML html = new PD4ML();
						html.setPageSize(PD4Constants.LETTER);
						html.render(targetURL, fos);
								DataSource source2 = new URLDataSource(new URL("http://"+server+"/erapid/shared/"+fileName));
								messageBodyPart.setDataHandler(new DataHandler(source2));
							messageBodyPart.setFileName("credit_application.pdf");
								multipart.addBodyPart(messageBodyPart);
								msg.setContent(multipart);
								messageBodyPart = new MimeBodyPart();
						    }















































							//adding the footer
							messageBodyPart = new MimeBodyPart();
							messageBodyPart.setText(message_footer);
						    multipart.addBodyPart(messageBodyPart);

		//                        msg.setSentDate(new Date());
						    Transport.send(msg);
							out.println(" An eMail will be sent<br>to the following recipients:<br><br><b>To: "+to+"<br>Cc: "+cc+"</b>");
						}
						catch(javax.mail.internet.AddressException ae){
						    ae.printStackTrace();
						    out.println(ae);
					 }
					 catch(javax.mail.MessagingException me){
						    me.printStackTrace();
						    out.println(me);
					 }
		%>
	</body>
</html>
<%
}
catch(Exception e){

	out.println(e);
}

%>