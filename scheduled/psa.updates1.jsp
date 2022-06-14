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
			<%@ include file="../db_con_psa.jsp"%>
			<%@ include file="../db_con_bpcs.jsp"%>
			<%@ include file="../db_con.jsp"%>
			<%


				java.util.Date uDate = new java.util.Date(); // Right now
				Format formatter = new SimpleDateFormat("yyyyMMdd");
				String tdate=formatter.format(uDate);
				//tdate="20110726";
				int count=0;String sql_bpcs="";Vector bpcs_order_no = new Vector();Vector bpcs_psa_no = new Vector();
				int psa_update_count=0;String sql_psa_update="";String final_out="";int psa_exec_count=0;String final_out_exec="";
				int erapid_update_count=0;

				    sql_bpcs="SELECT C.HOORD,C.HOQUT FROM BPCSUSRFFG.CEH AS C WHERE C.HOQOR = 'P' AND C.HOORD IN ( SELECT D.HORD FROM BPCSFFG.ECH AS D WHERE D.CHBOCL != 8 and D.HEDTE ='"+tdate+"' ) GROUP BY C.HOORD,C.HOQUT";
					ResultSet rs_bpcs2 = stmt_bpcs.executeQuery(sql_bpcs);
				    while ( rs_bpcs2.next() ) {
					   bpcs_order_no.addElement(rs_bpcs2.getString(1));
					   bpcs_psa_no.addElement(rs_bpcs2.getString(2));
					   count++;
					}
					rs_bpcs2.close();

			/*
				}
			}
			*/

			// Getting data from BPCS done
			// updating PSA database
			myConn_psa.setAutoCommit(false);
					sql_psa_update="UPDATE dba.QUOTATION SET BPCS_ORDER_NO = ?, BPCS_ORDER_DATE ='"+tdate+"',QUOTE_STATUS = 'W' WHERE QUOTE_ID = ?";
					java.sql.PreparedStatement ps_update = myConn_psa.prepareStatement(sql_psa_update);
			//select from PSA
					   String sql_psa = "SELECT ELOGIA_NO FROM dba.QUOTATION WHERE QUOTE_ID = ? ";
					   java.sql.PreparedStatement ps = myConn_psa.prepareStatement(sql_psa);

			//updating erapid tabels
			try{
					   // if the PSAno doesn't exist in the quotation table then insert into cs_exception table
					   String sql_erapid_cs_exception = "insert into cs_exception values ( ?,?, '"+tdate+"','N','P'  ) ";
					   java.sql.PreparedStatement ps_cs_exception = myConn.prepareStatement(sql_erapid_cs_exception);

						//	if it's notan order if doc_header has a Q THEN only do this
						
					   String sql_erapid_doc_header = "insert into doc_header select doc_number,doc_type='O',doc_revision,dp_number,doc_description,expires_date,doc_date,entry_date,due_date,promise_date,doc_status='CLOSE',doc_title,doc_customer,ship_to,doc_salesperson,doc_terms,plant_no,doc_so_num,doc_so_date,doc_so_user,doc_office,dcm_id,dcm_id2,dcm_id3,dcm_id4,dcm_id5,fob,ship_method,ship_carrier,ship_pmt_method,discount_factor,doc_priority,doc_probability,po_number,po_date,taxable,product_id,config_string,frozen_string,ec_status,comments,default_rec,freeze_rec,rev_history,created_by,rev_date,win_loss='CLOSE',win_loss_desc,group_owner,reason_code,header_directory,doc_download,doc_stage,dm_complete,submitted_state,speed_number,from_quote,ship_date,pv_status,mv_status from doc_header where doc_number= ? ";
					   java.sql.PreparedStatement ps_doc_header_update = myConn.prepareStatement(sql_erapid_doc_header);
					   String sql_erapid_doc_line = "UPDATE DOC_LINE SET DOC_TYPE = 'O' WHERE doc_number = ? ";
					   java.sql.PreparedStatement ps_doc_line_update = myConn.prepareStatement(sql_erapid_doc_line);
					   String sql_erapid_doc_header_del = "DELETE FROM DOC_HEADER WHERE DOC_TYPE = 'Q' and doc_number = ? ";
					   java.sql.PreparedStatement ps_doc_header_del= myConn.prepareStatement(sql_erapid_doc_header_del);

					   //if it's an order if doc_header has a O already then only do this
					   String sql_erapid_doc_header1 = "UPDATE DOC_HEADER SET doc_status='CLOSE',win_loss='CLOSE' WHERE doc_number = ? ";
					   java.sql.PreparedStatement ps_doc_header_update1 = myConn.prepareStatement(sql_erapid_doc_header1);

						//update this for both Q or O in doc_header
					   String sql_erapid_project = "update cs_project set BPCS_ORDER_NO = ?,quote_type='O', BPCS_ORDER_DATE = '"+tdate+"',bpcs_cust_no=?  WHERE order_no = ? ";
					   java.sql.PreparedStatement ps_project_update = myConn.prepareStatement(sql_erapid_project);
					   //Genercic erapid
					   String sql_erapid_order_check = "select count(*) FROM DOC_HEADER WHERE DOC_TYPE = 'O' and doc_number = ? ";
					   java.sql.PreparedStatement ps_erapid_order_check= myConn.prepareStatement(sql_erapid_order_check);

					   //to get cust_no from BPCS
					   String sql_ech_cust_no="SELECT D.HCUST FROM BPCSFFG.ECH AS D WHERE D.CHBOCL != 8 and D.HORD =? ";
					java.sql.PreparedStatement ps_sql_ech_cust_no= con_bpcs.prepareStatement(sql_ech_cust_no);

					int rocount=0;String elogia_no="";int rocount_check=0;String bpcs_cust_no="";
					for(int k=0;k<count;k++){ //s1
								ps_update.setString(1,bpcs_order_no.elementAt(k).toString().trim());
								ps_update.setString(2,bpcs_psa_no.elementAt(k).toString().trim());
								rocount= ps_update.executeUpdate();
								if(rocount<=0){
									if(bpcs_psa_no.elementAt(k).toString().trim().length()>0){
										int countrsx=0;
										ResultSet rsx=stmt.executeQuery("select count(*) from cs_exception where order_no='"+bpcs_psa_no.elementAt(k).toString().trim()+"' and bpcs_order_no='"+bpcs_order_no.elementAt(k).toString().trim()+"'");
										if(rsx != null){
											while(rsx.next()){
												countrsx=rsx.getInt(1);
											}
										}
										rsx.close();
										if(countrsx==0){
											ps_cs_exception.setString(1,bpcs_psa_no.elementAt(k).toString().trim());
											ps_cs_exception.setString(2,bpcs_order_no.elementAt(k).toString().trim());
											int rocount_excep= ps_cs_exception.executeUpdate();
											final_out_exec=final_out_exec+"insert into cs_exception values('"+bpcs_psa_no.elementAt(k).toString().trim()+"','"+bpcs_order_no.elementAt(k).toString().trim()+"','"+tdate+"','N','P')"+"\r\n";
											psa_exec_count++;
										}
									}
								}
								else{
									final_out=final_out+"UPDATE QUOTATION SET BPCS_ORDER_NO ='"+bpcs_order_no.elementAt(k).toString().trim()+"', BPCS_ORDER_DATE ='"+tdate+"',QUOTE_STATUS = 'W' WHERE QUOTE_ID = '"+bpcs_psa_no.elementAt(k).toString().trim()+"';"+"\r\n";
									//out.println("UPDATE QUOTATION SET BPCS_ORDER_NO ='"+bpcs_order_no.elementAt(k).toString().trim()+"', BPCS_ORDER_DATE ='"+tdate+"',QUOTE_STATUS = 'W' WHERE QUOTE_ID = '"+bpcs_psa_no.elementAt(k).toString().trim()+"';"+"<br>");
									psa_update_count++;
								}
								rocount=0;
								//getting data from quotation table done
								//getting the cust no from bpcs
								ps_sql_ech_cust_no.setString(1,bpcs_order_no.elementAt(k).toString().trim());
								ResultSet rs_check_cust	= ps_sql_ech_cust_no.executeQuery();
								if (rs_check_cust !=null) {
									while (rs_check_cust.next()){
										bpcs_cust_no=rs_check_cust.getString(1);
									}
								}else{bpcs_cust_no="";}
					//				out.println("BPCS cust no"+bpcs_cust_no+"<br>");
							//getting cust_no done from BPCS

								//updating erapid starts
								ps.setString(1,bpcs_psa_no.elementAt(k).toString().trim());
								ResultSet rs_psa= ps.executeQuery();
								if (rs_psa!=null){
								   while ( rs_psa.next() ) {
										elogia_no=rs_psa.getString(1);
										 if(elogia_no!=null){
						//						 out.println("Test"+elogia_no+"::");
												ps_erapid_order_check.setString(1,elogia_no.trim());
												ResultSet rs_check	= ps_erapid_order_check.executeQuery();
											    while ( rs_check.next() ) {rocount_check=rs_check.getInt(1);}
												if(rocount_check<=0){
				//								out.println("QUote<br>");
														try{
														ps_project_update.setString(1,bpcs_order_no.elementAt(k).toString().trim());
														ps_project_update.setString(2,bpcs_cust_no.trim());
														ps_project_update.setString(3,elogia_no.trim());
														int rocount_pro= ps_project_update.executeUpdate();
														ps_doc_header_update.setString(1,elogia_no.trim());
														int rocount1= ps_doc_header_update.executeUpdate();
														ps_doc_line_update.setString(1,elogia_no.trim());
														int rocount2= ps_doc_line_update.executeUpdate();
														ps_doc_header_del.setString(1,elogia_no.trim());
														int rocount3= ps_doc_header_del.executeUpdate();
															if(rocount_pro>0){
															//out.println("UPDATE CS_PROJECT SET BPCS_ORDER_NO ='"+bpcs_order_no.elementAt(k).toString().trim()+"',BPCS_ORDER_DATE = '"+tdate+"',bpcs_cust_no='"+bpcs_cust_no+"'  WHERE ORDER_NO = '"+elogia_no.trim()+"';"+"<br>");
															final_out=final_out+"UPDATE CS_PROJECT SET BPCS_ORDER_NO ='"+bpcs_order_no.elementAt(k).toString().trim()+"',BPCS_ORDER_DATE = '"+tdate+"',quote_type='O',bpcs_cust_no='"+bpcs_cust_no+"'  WHERE ORDER_NO = '"+elogia_no.trim()+"';"+"\r\n";
															final_out=final_out+"UPDATE DOC_HEADER SET WIN_LOSS = 'CLOSE',DOC_TYPE = 'O' WHERE doc_number = '"+elogia_no.trim()+"';"+"\r\n\r\n";
															}
			//											erapid_update_count++;
														}
														catch(java.sql.SQLException e){
														out.println("Problem with Inserting the ERAPID TABLES 1 "+"<br>");
														out.println("Illegal Operation try again/Report Error"+"<br>");
														out.println(e.toString());
														myConn.rollback();
														return;
														}

												}// if it's an quote in doc_header do the above
												else{
			//									out.println("Order<br>");
														try{
															ps_project_update.setString(1,bpcs_order_no.elementAt(k).toString().trim());
															ps_project_update.setString(2,bpcs_cust_no.trim());
														    ps_project_update.setString(3,elogia_no.trim());
															int rocount2= ps_project_update.executeUpdate();
															ps_doc_header_update1.setString(1,elogia_no.trim());
															int rocount1= ps_doc_header_update1.executeUpdate();
															if(rocount2>0){
															//out.println("UPDATE CS_PROJECT SET BPCS_ORDER_NO ='"+bpcs_order_no.elementAt(k).toString().trim()+"',BPCS_ORDER_DATE = '"+tdate+"',bpcs_cust_no='"+bpcs_cust_no+"'  WHERE ORDER_NO = '"+elogia_no.trim()+"';"+"<br>");
															final_out=final_out+"UPDATE CS_PROJECT SET BPCS_ORDER_NO ='"+bpcs_order_no.elementAt(k).toString().trim()+"',BPCS_ORDER_DATE = '"+tdate+"',quote_type='O',bpcs_cust_no='"+bpcs_cust_no+"'  WHERE ORDER_NO = '"+elogia_no.trim()+"';"+"\r\n";
															final_out=final_out+"UPDATE DOC_HEADER SET WIN_LOSS = 'CLOSE' WHERE doc_number = '"+elogia_no.trim()+"';"+"\r\n\r\n";
															}
														}
														catch(java.sql.SQLException e){
															out.println("Problem with UPDATING the ERAPID TABLES 11 "+"<br>");
															out.println("Illegal Operation try again/Report Error"+"<br>");
															out.println(e.toString());
														    myConn.rollback();
															return;
														}
												}// if it's an order in doc_header do this
											 erapid_update_count++;
										 }// if elogia_no is not null loop
								   }//while loop end
								elogia_no="";rocount_check=0;
								}//if there are no result sets.
								rs_psa.close();
								//getting data from quotation table done
								myConn_psa.commit();
					}// for loop
					ps_update.close();
					stmt_psa.close();
					 myConn_psa.close();
					 ps_erapid_order_check.close();
					 ps_cs_exception.close();
					 ps_project_update.close();
					 ps_doc_header_update.close();
					 ps_doc_header_del.close();
				 myConn.close();
			// updating PSA database done
			//closing BPCS connection
			stmt_bpcs.close();
			con_bpcs.close();
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
				    out.println("BPCS Total::"+count+"::PSA updated::"+psa_update_count+"::"+"::Erapid updated::"+erapid_update_count+"::PSA Exception::"+psa_exec_count+"::"+uDate+"::"+tdate+"<br>");
					final_out=final_out+"BPCS Total::"+count+"::PSA updated::"+psa_update_count+"::Erapid updated::"+erapid_update_count+"::PSA Exception::"+psa_exec_count+"::"+"::"+uDate+"::"+tdate+"\r\n";
					final_out=final_out+final_out_exec;
			// Updating the log file
			String dir_path="D:\\erapid\\scheduled\\log\\";
							 BufferedWriter out1 = new BufferedWriter(new FileWriter(dir_path+"\\"+tdate+"P.txt"));
							 out1.write(final_out);
							 out1.flush();
							 out1.close();

	}
	  catch(Exception e){
		out.println("ERROR::"+e);
	  }
			%>
			</body>
			</html>
