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
		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>
	<body>
	<center>
		<table>
			<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" import="java.math.*" import="java.io.*" errorPage="error.jsp" %>

			<%@ include file="../db_con.jsp"%>
			<%@ include file="../db_con_bpcs.jsp"%>
			<%

				java.util.Date uDate = new java.util.Date(); // Right now
				Format formatter = new SimpleDateFormat("yyyyMMdd");
				String tdate=formatter.format(uDate);

				//tdate="20130120";
				//tdate="20130228";
				int count=0;String sql_bpcs="";Vector bpcs_order_no = new Vector();Vector bpcs_erapid_no = new Vector();
				int psa_update_count=0;String final_out="";int erapid_update_count=0;String final_out_exec="";int erapid_exec_count=0;
			// Getting data from BPCS





					//out.println(tdate+"::<BR>");

					sql_bpcs="SELECT D.HORD,d.chad6 FROM BPCSFFG.ECH AS D WHERE D.CHBOCL != 8 and D.HEDTE ='"+tdate+"'";
				    // sql_bpcs="SELECT C.HOORD,C.HOQUT FROM BPCSUSRFFG.CEH AS C WHERE C.HOQOR = 'E' AND C.HOORD IN ( SELECT D.HORD FROM BPCSFFG.ECH AS D WHERE D.CHBOCL != 8 and D.HEDTE ='"+tdate+"' ) GROUP BY C.HOORD,C.HOQUT";
					   ResultSet rs_bpcs = stmt_bpcs.executeQuery(sql_bpcs);
					  while ( rs_bpcs.next() ) {
						    if(rs_bpcs.getString(2).trim().length()>0&&rs_bpcs.getString(2).indexOf("_")>0){
							   bpcs_order_no.addElement(rs_bpcs.getString(1).trim());
							   bpcs_erapid_no.addElement(rs_bpcs.getString(2).trim());
							 // out.println("::"+rs_bpcs.getString(1)+"::"+rs_bpcs.getString(2).trim()+"::<BR>");
							   count++;
						   }
					}
					rs_bpcs.close();
					 sql_bpcs="SELECT C.HOORD,C.HOQUT FROM BPCSUSRFFG.CEH AS C WHERE C.HOQOR = 'E' AND C.HOORD IN ( SELECT D.HORD FROM BPCSFFG.ECH AS D WHERE D.CHBOCL != 8 and D.HEDTE ='"+tdate+"' ) GROUP BY C.HOORD,C.HOQUT";
					   ResultSet rs_bpcs2 = stmt_bpcs.executeQuery(sql_bpcs);
					  while ( rs_bpcs2.next() ) {
						   if(rs_bpcs2.getString(2).trim().length()>0&&rs_bpcs2.getString(2).indexOf("_")>0){
							   bpcs_order_no.addElement(rs_bpcs2.getString(1).trim());
							   bpcs_erapid_no.addElement(rs_bpcs2.getString(2).trim());
							 // out.println("::"+rs_bpcs2.getString(1)+"::"+rs_bpcs2.getString(2).trim()+"::<BR>");
							   count++;
						   }
											   }
					rs_bpcs2.close();
					//out.println(count+"::<BR>");




			// Getting data from BPCS done
			// Updating Eapid
			String erapid_quote_id="";String erapid_bpcs_id="";String sql_erapid_update="";
						//	if it's notan order if doc_header has a Q THEN only do this
							try{
					String sql_erapid_doc_header = "insert into doc_header select doc_number,doc_type='O',doc_revision,dp_number,doc_description,expires_date,doc_date,entry_date,due_date,promise_date,doc_status='CLOSE',doc_title,doc_customer,ship_to,doc_salesperson,doc_terms,plant_no,doc_so_num,doc_so_date,doc_so_user,doc_office,dcm_id,dcm_id2,dcm_id3,dcm_id4,dcm_id5,fob,ship_method,ship_carrier,ship_pmt_method,discount_factor,doc_priority,doc_probability,po_number,po_date,taxable,product_id,config_string,frozen_string,ec_status,comments,default_rec,freeze_rec,rev_history,created_by,rev_date,win_loss='CLOSE',win_loss_desc,group_owner,reason_code,header_directory,doc_download,doc_stage,dm_complete,submitted_state,speed_number,from_quote,ship_date,pv_status,mv_status, copied_doc_number, copied_to, grid_key, ship_complete, atp_hold, last_modified, last_modified_by from doc_header where doc_number= ?";
					//out.println(sql_erapid_doc_header);
					java.sql.PreparedStatement ps_doc_header_update = myConn.prepareStatement(sql_erapid_doc_header);
					String sql_erapid_doc_line = "UPDATE DOC_LINE SET DOC_TYPE = 'O' WHERE doc_number = ? ";
					java.sql.PreparedStatement ps_doc_line_update = myConn.prepareStatement(sql_erapid_doc_line);
					String sql_erapid_doc_header_del = "DELETE FROM DOC_HEADER WHERE DOC_TYPE = 'Q' and doc_number = ? ";
					java.sql.PreparedStatement ps_doc_header_del= myConn.prepareStatement(sql_erapid_doc_header_del);

					//if it's an order if doc_header has a O already then only do this
					String sql_erapid_doc_header1 = "UPDATE DOC_HEADER SET doc_status='CLOSE',win_loss='CLOSE' WHERE doc_number = ? ";
					java.sql.PreparedStatement ps_doc_header_update1 = myConn.prepareStatement(sql_erapid_doc_header1);

					//Generic   query for both Q or O in doc_headers
					String sql_erapid_order_check = "select count(*) FROM DOC_HEADER WHERE DOC_TYPE = 'O' and doc_number = ? ";
					java.sql.PreparedStatement ps_erapid_order_check= myConn.prepareStatement(sql_erapid_order_check);
					String sql_erapid_project = "update cs_project set BPCS_ORDER_NO = ?,quote_type='O', BPCS_ORDER_DATE = '"+tdate+"',bpcs_cust_no=?  WHERE order_no = ? ";
					java.sql.PreparedStatement ps_project_update = myConn.prepareStatement(sql_erapid_project);

					   // if the erapid order_no doesn't exist in the cs_project table then insert into cs_exception table
					   String sql_erapid_cs_exception = "insert into cs_exception values ( ?,?, '"+tdate+"','N','E'  ) ";
					   java.sql.PreparedStatement ps_cs_exception = myConn.prepareStatement(sql_erapid_cs_exception);

					   //to get cust_no from BPCS
					   String sql_ech_cust_no="SELECT D.HCUST FROM BPCSFFG.ECH AS D WHERE D.CHBOCL != 8 and D.HORD =? ";
					java.sql.PreparedStatement ps_sql_ech_cust_no= con_bpcs.prepareStatement(sql_ech_cust_no);

					   int rocount_check=0;String bpcs_cust_no="";
						for(int k=0;k<bpcs_order_no.size();k++){ //
								myConn.setAutoCommit(false);
			//					//out.println("0"+bpcs_erapid_no.elementAt(k).toString().trim()+"<br>");
								ps_erapid_order_check.setString(1,bpcs_erapid_no.elementAt(k).toString().trim());
								ResultSet rs_check	= ps_erapid_order_check.executeQuery();
			//					out.println("1<br>");
			//getting the cust no from bpcs
								ps_sql_ech_cust_no.setString(1,bpcs_order_no.elementAt(k).toString().trim());
								ResultSet rs_check_cust	= ps_sql_ech_cust_no.executeQuery();
								if (rs_check_cust !=null) {
									while (rs_check_cust.next()){
										bpcs_cust_no=rs_check_cust.getString(1);
									}
								}else{bpcs_cust_no="";}
						//		out.println("BPCS cust no"+bpcs_cust_no+"<br>");
			//getting cust_no done from BPCS
							    while ( rs_check.next() ) {rocount_check=rs_check.getInt(1);}
			//					out.println("2<br>");
							if(rocount_check<=0){
			//					out.println("3<br>");
									try{
			//							out.println("4<br>");
										ps_project_update.setString(1,bpcs_order_no.elementAt(k).toString().trim());
										ps_project_update.setString(2,bpcs_cust_no.trim());
									    ps_project_update.setString(3,bpcs_erapid_no.elementAt(k).toString().trim());

										int rocount= ps_project_update.executeUpdate();

										ps_doc_header_update.setString(1,bpcs_erapid_no.elementAt(k).toString().trim());
										int rocount1= ps_doc_header_update.executeUpdate();

/*

										ps_doc_line_update.setString(1,bpcs_erapid_no.elementAt(k).toString().trim());
										int rocount2= ps_doc_line_update.executeUpdate();
			//							out.println("7<br>");
										ps_doc_header_del.setString(1,bpcs_erapid_no.elementAt(k).toString().trim());
										int rocount3= ps_doc_header_del.executeUpdate();
				//						out.println("8<br>");

										if(rocount>0){
										//out.println("a");
											//out.println("UPDATE CS_PROJECT SET BPCS_ORDER_NO ='"+bpcs_order_no.elementAt(k).toString().trim()+"',BPCS_ORDER_DATE = '"+tdate+"',bpcs_cust_no='"+bpcs_cust_no+"'  WHERE ORDER_NO = '"+bpcs_erapid_no.elementAt(k).toString().trim()+"';"+"<br>");
											final_out=final_out+"UPDATE CS_PROJECT SET BPCS_ORDER_NO ='"+bpcs_order_no.elementAt(k).toString().trim()+"',BPCS_ORDER_DATE = '"+tdate+"',quote_type='O',bpcs_cust_no='"+bpcs_cust_no+"'  WHERE ORDER_NO = '"+bpcs_erapid_no.elementAt(k).toString().trim()+"';"+"\r\n";
											final_out=final_out+"UPDATE DOC_HEADER SET WIN_LOSS = 'CLOSE',DOC_TYPE = 'O' WHERE doc_number = '"+bpcs_erapid_no.elementAt(k).toString().trim()+"';"+"\r\n\r\n";
										}else{
											//out.println("b");
											if(bpcs_erapid_no.elementAt(k).toString().trim().length()>0){
												int countrsx=0;

												ResultSet rsx=stmt.executeQuery("select count(*) from cs_exception where order_no='"+ bpcs_erapid_no.elementAt(k).toString().trim()+"' and bpcs_order_no='"+bpcs_order_no.elementAt(k).toString().trim()+"'");
												if(rsx != null){
													while(rsx.next()){
														countrsx=rsx.getInt(1);
													}
												}
												rsx.close();
												if(countrsx==0){
													ps_cs_exception.setString(1,bpcs_erapid_no.elementAt(k).toString().trim());
													ps_cs_exception.setString(2,bpcs_order_no.elementAt(k).toString().trim());
													int rocount_excep= ps_cs_exception.executeUpdate();
													final_out_exec=final_out_exec+"insert into cs_exception values('"+bpcs_erapid_no.elementAt(k).toString().trim()+"','"+bpcs_order_no.elementAt(k).toString().trim()+"','"+tdate+"','N','E')"+"\r\n";
													erapid_exec_count++;
												}

											}
										}
*/
										erapid_update_count++;
									}
									catch(java.sql.SQLException e){
										out.println("Problem with Inserting the ERAPID TABLES 1 "+"<br>");
										out.println("Illegal Operation try again/Report Error"+"<br>");
										out.println(e.toString());
									    myConn.rollback();
										return;
									}
							}else{
				 //   				out.println("hello i got u<br>");
									try{
				//					out.println("hello i got u 0<br>");
										ps_project_update.setString(1,bpcs_order_no.elementAt(k).toString().trim());
										ps_project_update.setString(2,bpcs_cust_no.trim());
									    ps_project_update.setString(3,bpcs_erapid_no.elementAt(k).toString().trim());
										int rocount= ps_project_update.executeUpdate();
										ps_doc_header_update1.setString(1,bpcs_erapid_no.elementAt(k).toString().trim());
										int rocount1= ps_doc_header_update1.executeUpdate();
										if(rocount>0){
											//out.println("UPDATE CS_PROJECT SET BPCS_ORDER_NO ='"+bpcs_order_no.elementAt(k).toString().trim()+"',BPCS_ORDER_DATE = '"+tdate+"',bpcs_cust_no='"+bpcs_cust_no+"'  WHERE ORDER_NO = '"+bpcs_erapid_no.elementAt(k).toString().trim()+"';"+"<br>");
											final_out=final_out+"UPDATE CS_PROJECT SET BPCS_ORDER_NO ='"+bpcs_order_no.elementAt(k).toString().trim()+"',BPCS_ORDER_DATE = '"+tdate+"',quote_type='O',bpcs_cust_no='"+bpcs_cust_no+"'  WHERE ORDER_NO = '"+bpcs_erapid_no.elementAt(k).toString().trim()+"';"+"\r\n";
											final_out=final_out+"UPDATE DOC_HEADER SET WIN_LOSS = 'CLOSE' WHERE doc_number = '"+bpcs_erapid_no.elementAt(k).toString().trim()+"';"+"\r\n\r\n";
						//					out.println("hello i got u 1<br>");
										}else{
											if(bpcs_erapid_no.elementAt(k).toString().trim().length()>0){
												int countrsx=0;
												ResultSet rsx=stmt.executeQuery("select count(*) from cs_exception where order_no='"+ bpcs_erapid_no.elementAt(k).toString().trim()+"' and bpcs_order_no='"+bpcs_order_no.elementAt(k).toString().trim()+"'");
												if(rsx != null){
													while(rsx.next()){
														countrsx=rsx.getInt(1);
													}
												}
												rsx.close();
												if(countrsx==0){
													ps_cs_exception.setString(1,bpcs_erapid_no.elementAt(k).toString().trim());
													ps_cs_exception.setString(2,bpcs_order_no.elementAt(k).toString().trim());
													int rocount_excep= ps_cs_exception.executeUpdate();
													final_out_exec=final_out_exec+"insert into cs_exception values('"+bpcs_erapid_no.elementAt(k).toString().trim()+"','"+bpcs_order_no.elementAt(k).toString().trim()+"','"+tdate+"','N','E')"+"\r\n";
													erapid_exec_count++;
												}
											}
										}
			//							out.println("hello i got u 2<br>");
										erapid_update_count++;
									}
									catch(java.sql.SQLException e){
										out.println("Problem with UPDATING the ERAPID TABLES 11 "+"<br>");
										out.println("Illegal Operation try again/Report Error"+"<br>");
										out.println(e.toString());
									    myConn.rollback();
										return;
									}
							}
						 myConn.commit();
						 rocount_check=0;
						}//for loop
			 ps_erapid_order_check.close();
			 ps_cs_exception.close();
			 ps_project_update.close();
			 ps_doc_header_update.close();
			 ps_doc_header_del.close();
			 myConn.close();
			 }
			 			catch (java.sql.SQLException e)
			 			{
			 				out.println("Problem with deleting from doc_header"+"<br>");
			 				out.println("Illegal Operation try again/Report Error"+"<br>");
			 				myConn.rollback();
			 				out.println(e.toString());
			 				System.exit(0);
			 				return;
		}
			//closing BPCS connections done
			%>
			<%@ include file="../db_con_psa.jsp"%>
			<%
			//Checking with PSA
			try{
				myConn_psa.setAutoCommit(false);
				String psa_quote_id="";String psa_bpcs_id="";String sql_psa_update="";
					   String sql_psa = "SELECT QUOTE_ID,BPCS_ORDER_NO FROM dba.QUOTATION WHERE ELOGIA_NO = ? ";

					   java.sql.PreparedStatement ps = myConn_psa.prepareStatement(sql_psa);
					sql_psa_update="UPDATE dba.QUOTATION SET BPCS_ORDER_NO = ?, BPCS_ORDER_DATE ='"+tdate+"',QUOTE_STATUS = 'W' WHERE QUOTE_ID = ?";
					out.println(sql_psa_update+"::<BR>");
					java.sql.PreparedStatement ps_update = myConn_psa.prepareStatement(sql_psa_update);
					   int psacounter=0;
					for(int k=0;k<count;k++){ //s1
						if(bpcs_erapid_no.elementAt(k).toString().trim().length()>0){

							out.println(bpcs_erapid_no.elementAt(k).toString()+"::<BR>");
							ps.setString(1,bpcs_erapid_no.elementAt(k).toString().trim());
							ResultSet rs_psa= ps.executeQuery();
				//			out.println("Before1::");
							if (rs_psa!=null){
								while ( rs_psa.next() ) {
									//out.println("<BR><BR>::Before1::<BR><BR>");
									psacounter++;
									psa_quote_id=rs_psa.getString(1);
									psa_bpcs_id=rs_psa.getString(2);
				//				    if(psa_bpcs_id==null){
				//				  	out.println("After:"+psa_quote_id+"::"+psa_bpcs_id+":<br>");
									ps_update.setString(1,bpcs_order_no.elementAt(k).toString().trim());
									ps_update.setString(2,psa_quote_id);
									//out.println("Before::"+psacounter+"::"+bpcs_erapid_no.elementAt(k).toString()+"::");
									//out.println(bpcs_order_no.elementAt(k).toString().trim()+"::"+psa_quote_id+"::<BR>");
			//out.println("UPDATE QUOTATION SET BPCS_ORDER_NO ='"+bpcs_order_no.elementAt(k).toString().trim()+"', BPCS_ORDER_DATE ='"+tdate+"',QUOTE_STATUS = 'W' WHERE QUOTE_ID = '"+psa_quote_id+"';"+"<br>");

									int rocount= ps_update.executeUpdate();
									final_out=final_out+"UPDATE QUOTATION SET BPCS_ORDER_NO ='"+bpcs_order_no.elementAt(k).toString().trim()+"', BPCS_ORDER_DATE ='"+tdate+"',QUOTE_STATUS = 'W' WHERE QUOTE_ID = '"+psa_quote_id+"';"+"\r\n";
									psa_update_count++;
									//myConn_psa.commit();
									//
					//			  	}
								}
							}
							rs_psa.close();
							myConn_psa.commit();
							//out.println("<BR><BR>");
						}
					}
			myConn_psa.commit();
			//Checking with PSA Done

				    out.println("BPCS Total::"+count+"::PSA updated::"+psa_update_count+"::Eapid updated::"+erapid_update_count+"::"+uDate+"::"+tdate+"<br>");
					final_out=final_out+"BPCS Total::"+count+"::PSA updated::"+psa_update_count+"::Eapid updated::"+erapid_update_count+"::"+"::Eapid Exception::"+erapid_exec_count+"::"+uDate+"::"+tdate+"\r\n";
					final_out=final_out+final_out_exec;
			// Updating the log file
			String dir_path="D:\\erapid\\scheduled\\log\\";
							 BufferedWriter out1 = new BufferedWriter(new FileWriter(dir_path+"\\"+tdate+"E.txt"));
							 out1.write(final_out);
							 out1.flush();
							 out1.close();
					ps.close();
					ps_update.close();
			}catch(Exception e){
				out.println(e);
			}
				//}
			//}
					stmt_psa.close();

					// Updating Eapid Done
					//closing BPCS connections
					stmt_bpcs.close();
			con_bpcs.close();

	}
	  catch(Exception e){
		out.println("ERROR::"+e);
	  }
			%>
			</body>
			</html>
