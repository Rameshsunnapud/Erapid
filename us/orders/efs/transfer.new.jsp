<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
	<title>Transferring files to BPCS</title>
</head>
<body>
<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.io.*" errorPage="error.jsp" %>
<%
String order_no = request.getParameter("sp-q");
%>	
<%@ include file="db_con.jsp"%>
<%
			//
			Vector transfer=new Vector();Vector shop_order_no=new Vector();int counter=0;Vector part_sub=new Vector();Vector product_desc=new Vector();
			Vector qty=new Vector();Vector shop_item_no=new Vector();			
			//
			Vector qty1=new Vector();Vector text_identifier=new Vector();Vector bpcs_part_main=new Vector();Vector bpcs_part_sub=new Vector();
			Vector part_no=new Vector();int counter1=0;Vector item_no=new Vector();	
			//routings store
			Vector bpcs_part_main_rout=new Vector();Vector bpcs_part_sub_rout=new Vector();int counter_rout=0;Vector item_no_rout=new Vector();					
			Vector block_code_rout=new Vector();Vector setup_time_rout=new Vector();Vector routing_time_rout=new Vector();Vector seq_no=new Vector();Vector op_no_rout=new Vector();Vector work_center_rout=new Vector();	
			Vector op_name_rout=new Vector();					
			//					
			String dir_path="D:\\TRANSFER\\BPCS_BOM\\test\\";String final_out="";String final_notes_out="";
			out.println("Let's see....OK.................<br>"+"Check the out put in"+dir_path+" for the BOM upload files"+"<br><br><br>");			
			ResultSet rs_find = stmt.executeQuery("SELECT * FROM cs_bpcs_mat_shop_orders where cse_order_no like '"+order_no+"' and len(bpcs_shop_order_no)=6 and transfer='Y' order by prod_desc desc ");
			if (rs_find !=null) {
			while (rs_find.next()){
			shop_order_no.addElement(rs_find.getString ("bpcs_shop_order_no"));
			product_desc.addElement(rs_find.getString ("prod_desc"));
			part_sub.addElement(rs_find.getString ("bpcs_part_sub"));
			qty.addElement(rs_find.getString ("qty"));
			shop_item_no.addElement(rs_find.getString ("item_no"));
			counter++;
			}
			}
			
			ResultSet rs_cs_materials_output1 = stmt.executeQuery("SELECT * FROM cs_materials_output where order_no like '"+order_no+"' order by item_no");
	  		if (rs_cs_materials_output1 !=null) {
			while (rs_cs_materials_output1.next()){
			item_no.addElement(rs_cs_materials_output1.getString ("item_no"));
			part_no.addElement(rs_cs_materials_output1.getString ("part_no"));
			qty1.addElement(rs_cs_materials_output1.getString ("qty"));
			text_identifier.addElement(rs_cs_materials_output1.getString ("text_identifier"));
			bpcs_part_main.addElement(rs_cs_materials_output1.getString ("bpcs_part_main"));
			bpcs_part_sub.addElement(rs_cs_materials_output1.getString ("bpcs_part_sub"));
			counter1++;	
			}
			}
//routings tables
			ResultSet rs_cs_routings_output1 = stmt.executeQuery("SELECT item_no,work_center,op_no,op_name,type_id,bpcs_part_main,bpcs_part_sub, sum(setup_time),sum(routing_time) FROM cs_routings_output where order_no like '"+order_no+"' and len(work_center)>0 group by item_no,work_center,op_no,op_name,type_id,bpcs_part_main,bpcs_part_sub order by item_no");
	  		if (rs_cs_routings_output1 !=null) {
			while (rs_cs_routings_output1.next()){
			item_no_rout.addElement(rs_cs_routings_output1.getString ("item_no"));
			block_code_rout.addElement(rs_cs_routings_output1.getString ("type_id"));
			op_no_rout.addElement(rs_cs_routings_output1.getString ("op_no"));
			op_name_rout.addElement(rs_cs_routings_output1.getString ("op_name"));
			work_center_rout.addElement(rs_cs_routings_output1.getString ("work_center"));
			bpcs_part_main_rout.addElement(rs_cs_routings_output1.getString ("bpcs_part_main"));
			bpcs_part_sub_rout.addElement(rs_cs_routings_output1.getString ("bpcs_part_sub"));
			setup_time_rout.addElement(rs_cs_routings_output1.getString (8));
			routing_time_rout.addElement(rs_cs_routings_output1.getString (9));
			counter_rout++;
			}
			}
//			out.println("counter_rout"+counter_rout);
      //routings table done
	  Vector bpcs_part_main_sum=new Vector();Vector bpcs_part_sub_sum=new Vector();Vector op_no_sum=new Vector();Vector op_name_sum=new Vector();	  
	Vector work_center_sum=new Vector();Vector setup_time_sum=new Vector();Vector routing_time_sum=new Vector();
			ResultSet rs_cs_routings_sum = stmt.executeQuery("SELECT bpcs_part_main,bpcs_part_sub,op_no,op_name,work_center,sum(setup_time),sum(routing_time) FROM cs_routings_output where order_no='"+order_no+"' and block_code like 'frame%' group by bpcs_part_main,bpcs_part_sub,op_no,work_center,op_name");
	  		if (rs_cs_routings_sum !=null) {
			while (rs_cs_routings_sum.next()){
			bpcs_part_main_sum.addElement(rs_cs_routings_sum.getString (1));
			bpcs_part_sub_sum.addElement(rs_cs_routings_sum.getString (2));
			op_no_sum.addElement(rs_cs_routings_sum.getString (3));
			op_name_sum.addElement(rs_cs_routings_sum.getString (4));
			work_center_sum.addElement(rs_cs_routings_sum.getString (5));
			setup_time_sum.addElement(rs_cs_routings_sum.getString (6));
			routing_time_sum.addElement(rs_cs_routings_sum.getString (7));
		    }
			}
			
			if(counter<=0){
			out.println("There are no Shop orders ready for BPCS/BOM Export<br>");
			}
			else{
			String r="";
			int count_shop=1;String county="";
				for(int i=0;i<counter;i++){
				  // If it is product only				
				  if( (product_desc.elementAt(i).toString().equals("product")) ){
						ResultSet rs_efs_shop_paper1 = stmt.executeQuery("SELECT part_no,cast(detail_desc as varchar(600)),bpcs_part_main,sum(qty) FROM cs_materials_output where order_no like '"+order_no+"' and item_no='"+shop_item_no.elementAt(i)+"' and (text_identifier not like 'FRAME%' AND text_identifier not like 'PAN%') group by part_no,cast(detail_desc as varchar(600)),bpcs_part_main ");
							if (rs_efs_shop_paper1 !=null) {
								while (rs_efs_shop_paper1.next()){
								String t1=rs_efs_shop_paper1.getString(1);																
								String t2=rs_efs_shop_paper1.getString(2);
								String t3=rs_efs_shop_paper1.getString(3);
								String t4=rs_efs_shop_paper1.getString(4);
								//counter
								if(count_shop>9){county="0"+count_shop;}else{county="00"+count_shop;}
								if(t3.length()<15){
										String tv="";								
									for(int v=0;v<(15-t3.length());v++){								
									tv=" "+tv;	
//									out.println("the T3 value: "+t3.length()+"vb"+v+"***"+tv+"<br>");
								    }
									t3=t3+tv;
								}
								if(t1.length()<15){
									String tv="";																
									for(int v=0;v<(15-t1.length());v++){
									tv=" "+tv;
									}
									t1=t1+tv;
//									t3=t3+tv;									
								}
								r="";
								for (int ii = 0; ii < t4.length(); ii ++) {
									if (t4.charAt(ii) != '.' && t4.charAt(ii) != ',') r += t4.charAt(ii);
								}
								t4=r;
								if(t4.length()<11){
									String tv="";	
									for(int v=0;v<(11-t4.length());v++){
									tv="0"+tv;
									}
									t4=tv+t4;
								}	
								//erapid line_no
								String erapid_line_no=shop_item_no.elementAt(i).toString();
								if(erapid_line_no.length()<3){
									String tv="";								
									for(int v=0;v<(3-erapid_line_no.length());v++){								
									tv=tv+"0";
								    }
									erapid_line_no=tv+erapid_line_no;									
								}
								//
//								final_out="";
								final_out=final_out+county+"MU"+t3+t1+t4+"0000"+"  "+"N"+"2 "+shop_order_no.elementAt(i)+order_no+erapid_line_no+"00000"+"000"+" "+"00000000000"+"\r\n";
//the real debebug		out.println("order "+i+"The PRODUCT "+shop_item_no.elementAt(i)+" "+"<br>");								
//								out.println("The PRODUCT "+shop_item_no.elementAt(i)+"<br>");
							count_shop++;
								}//the result set while
							}//the result set if
							
								//out put to text files		
								 BufferedWriter out1 = new BufferedWriter(new FileWriter(dir_path+"\\"+"B"+shop_order_no.elementAt(i)+"01_"+".txt"));
								 out1.write(final_out);
//								 out.write("out put done "+"<br>");
		 						 out.flush();
								 out1.flush();
								 out1.close();						
								//out put to text files done
					count_shop=1;final_out="";county="";rs_efs_shop_paper1.close();
							out.println("Shop Order "+shop_order_no.elementAt(i)+" sent to BPCS successfully......."+"<br>");					
				  }// If it is product only
				  //iF IT IS A PAN ONLY - in the query below we used to cast(sum(qty)as integer)
				  if( (product_desc.elementAt(i).toString().equals("pan")) ){
						ResultSet rs_efs_shop_paper1 = stmt.executeQuery("SELECT part_no,cast(detail_desc as varchar(600)),bpcs_part_sub,sum(qty) FROM cs_materials_output where order_no like '"+order_no+"' and item_no='"+shop_item_no.elementAt(i)+"' and text_identifier like 'PAN%' group by part_no,cast(detail_desc as varchar(600)),bpcs_part_sub");
							if (rs_efs_shop_paper1 !=null) {
								while (rs_efs_shop_paper1.next()){
								String t1=rs_efs_shop_paper1.getString(1);																
								String t2=rs_efs_shop_paper1.getString(2);
								String t3=rs_efs_shop_paper1.getString(3);
								String t4=rs_efs_shop_paper1.getString(4);
								//counter code
								if(count_shop>9){county="0"+count_shop;}else{county="00"+count_shop;}
								if(t3.length()<15){
										String tv="";								
									for(int v=0;v<(15-t3.length());v++){								
									tv=" "+tv;	
//									out.println("the T3 value: "+t3.length()+"vb"+v+"***"+tv+"<br>");
								    }
	//								t3=tv+t3;
 									t3=t3+tv;
								}
								if(t1.length()<15){
									String tv="";																
									for(int v=0;v<(15-t1.length());v++){
									tv=" "+tv;
									}
//									t1=tv+t1;
									t1=t1+tv;
								}
								r="";
								for (int ii = 0; ii < t4.length(); ii ++) {
									if (t4.charAt(ii) != '.' && t4.charAt(ii) != ',') r += t4.charAt(ii);
								}
								t4=r;								
								if(t4.length()<11){
									String tv="";	
									for(int v=0;v<(11-t4.length());v++){
									tv="0"+tv;
									}
									t4=tv+t4;
								}								
								//counter code
								String erapid_line_no=shop_item_no.elementAt(i).toString();
								if(erapid_line_no.length()<3){
									String tv="";								
									for(int v=0;v<(3-erapid_line_no.length());v++){								
									tv=tv+"0";
								    }
									erapid_line_no=tv+erapid_line_no;									
								}
//								final_out="";
								final_out=final_out+county+"MU"+t3+t1+t4+"0000"+"  "+"N"+"2 "+shop_order_no.elementAt(i)+order_no+erapid_line_no+"00000"+"000"+" "+"00000000000"+"\r\n";
//the real debebug				out.println("order "+(i)+"The PAN "+shop_item_no.elementAt(i)+" "+"<br>");																								
//								out.println("The PAN "+shop_item_no.elementAt(i)+"<br>");
							count_shop++;
								}//the result set while
							}//the result set if
														
								//out put to text files		
								 BufferedWriter out1 = new BufferedWriter(new FileWriter(dir_path+"\\"+"B"+shop_order_no.elementAt(i)+"01_"+".txt"));
								 out1.write(final_out);
//								 out.write("out put done "+"<br>");
		 						 out.flush();
								 out1.flush();
								 out1.close();						
								//out put to text files done																							
					count_shop=1;final_out="";county="";rs_efs_shop_paper1.close();				
							out.println("Shop Order "+shop_order_no.elementAt(i)+" sent to BPCS successfully......."+"<br>");					
				  }// If it is A PAN ONLY
				  //iF IT IS A frame ONLY - in the query below we used to cast(sum(qty)as integer)
				  if( (product_desc.elementAt(i).toString().equals("frame")) ){
						ResultSet rs_efs_shop_paper1 = stmt.executeQuery("SELECT bpcs_part_sub,PART_NO,sum(qty) FROM cs_materials_output where order_no like '"+order_no+"' and text_identifier like 'FRAME%' AND bpcs_part_sub='"+part_sub.elementAt(i)+"' group by bpcs_part_sub,part_no ");
							if (rs_efs_shop_paper1 !=null) {
								while (rs_efs_shop_paper1.next()){
								String t3=rs_efs_shop_paper1.getString(1);
								String t1=rs_efs_shop_paper1.getString(2);																
								String t4=rs_efs_shop_paper1.getString(3);								
								//counter code
								if(count_shop>9){county="0"+count_shop;}else{county="00"+count_shop;}
								if(t3.length()<15){
										String tv="";								
									for(int v=0;v<(15-t3.length());v++){								
									tv=" "+tv;	
//									out.println("the T3 value: "+t3.length()+"vb"+v+"***"+tv+"<br>");
								    }
//									t3=tv+t3;
									t3=t3+tv;									
								}
								if(t1.length()<15){
									String tv="";																
									for(int v=0;v<(15-t1.length());v++){
									tv=" "+tv;
									}
//									t1=tv+t1;
									t1=t1+tv;									
								}
								r="";
								for (int ii = 0; ii < t4.length(); ii ++) {
									if (t4.charAt(ii) != '.' && t4.charAt(ii) != ',') r += t4.charAt(ii);
								}
								t4=r;								
								if(t4.length()<11){
									String tv="";	
									for(int v=0;v<(11-t4.length());v++){
									tv="0"+tv;
									}
									t4=tv+t4;
								}								
								//counter code
								String erapid_line_no=shop_item_no.elementAt(i).toString();
								if(erapid_line_no.length()<3){
									String tv="";								
									for(int v=0;v<(3-erapid_line_no.length());v++){								
									tv=tv+"0";
								    }
									erapid_line_no=tv+erapid_line_no;									
								}
//								final_out="";
								final_out=final_out+county+"MU"+t3+t1+t4+"0000"+"  "+"N"+"2 "+shop_order_no.elementAt(i)+order_no+erapid_line_no+"00000"+"000"+" "+"00000000000"+"\r\n";
//the real debebug				out.println("order "+(i)+"The FRAME "+shop_item_no.elementAt(i)+" "+"<br>");																
//								out.println("The FRAME "+shop_item_no.elementAt(i)+"<br>");
							count_shop++;
								}//the result set while
							}//the result set if
							//out put to text files		
								 BufferedWriter out1 = new BufferedWriter(new FileWriter(dir_path+"\\"+"B"+shop_order_no.elementAt(i)+"01_"+".txt"));
								 out1.write(final_out);
//								 out.write("out put done "+"<br>");
		 						 out.flush();
								 out1.flush();
								 out1.close();						
								//out put to text files done																
					count_shop=1;final_out="";county="";rs_efs_shop_paper1.close();				
							out.println("Shop Order "+shop_order_no.elementAt(i)+" sent to BPCS successfully......."+"<br>");					
				  }// If it is A FRAME ONLY
				}//outer for
			}// the else close 
// updating the bpcs_transfered table about this 
int ikea=0;int counter12=0;
			for(int f=0;f<counter;f++){	
//    			out.println("counter testing1s2345" +counter+"."+shop_order_no.elementAt(f));	
				ResultSet rs_efs_shop_paper1 = stmt.executeQuery("SELECT * FROM cs_bpcs_mat_transfered_jobs where cse_order_no like '"+order_no+"' and bpcs_shop_order_no='"+shop_order_no.elementAt(f)+"' ");
				if (rs_efs_shop_paper1 !=null) {
				while (rs_efs_shop_paper1.next()){
				counter12=rs_efs_shop_paper1.getInt ("counter");
				ikea++;
				}	
				}
//    			out.println("counter testing12345" +counter+"ikea"+ikea);	
						myConn.setAutoCommit(false);						
				if(ikea>0){
//						myConn.setAutoCommit(false);						
//	    			 out.println("Updating" +ikea+"<br>");				
					//Updating  
					try	{
	//				out.println("step 1"+counter12+"<br>");
					counter12++;
					String insert1 ="update cs_bpcs_mat_transfered_jobs set counter=? where bpcs_shop_order_no=? and cse_order_no=? ";	
			        PreparedStatement update_mat_shop_orders1 = myConn.prepareStatement(insert1);	
		          	update_mat_shop_orders1.setInt(1,counter12);
		          	update_mat_shop_orders1.setString(2,shop_order_no.elementAt(f).toString());
		          	update_mat_shop_orders1.setString(3,order_no);					
					int rocount1 = update_mat_shop_orders1.executeUpdate();
					update_mat_shop_orders1.close();
		//			out.println("step 2"+counter12+"<br>"+insert1);
					}
					catch (java.sql.SQLException e)
					{
					out.println("Problem with updating the transfered jobs"+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					myConn.rollback();
					out.println(e.toString());
					return;					
					}
					 
				}//IF LOOP
				else{
//						myConn.setAutoCommit(false);												
//s	    			out.println("INsertig" +ikea);
					// Inserting
					try	{
					String insert ="INSERT INTO cs_bpcs_mat_transfered_jobs(cse_order_no,bpcs_shop_order_no,transfer,counter)VALUES(?,?,?,?) ";	
			        PreparedStatement update_mat_shop_orders = myConn.prepareStatement(insert);	
		          	update_mat_shop_orders.setString(1,order_no);
		          	update_mat_shop_orders.setString(2,shop_order_no.elementAt(f).toString());
		          	update_mat_shop_orders.setString(3,"Y");
		          	update_mat_shop_orders.setInt(4,1);										
					int rocount = update_mat_shop_orders.executeUpdate();
					update_mat_shop_orders.close();
					}
					catch (java.sql.SQLException e)
					{
					out.println("Problem with inserting into trasfered jobs"+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					myConn.rollback();
					out.println(e.toString());
					return;					
					}
					// Inserting Done
				}//ELSE LOOP
				ikea=0;counter12=0;//RESETTING THE COUNTER				
				//updating mat shop order tables
					try	{
					String insert12 ="update cs_bpcs_mat_shop_orders set transfer=? where bpcs_shop_order_no=? and cse_order_no=? ";	
			        PreparedStatement update_mat_shop_orders12 = myConn.prepareStatement(insert12);	
		          	update_mat_shop_orders12.setString(1,"N");
		          	update_mat_shop_orders12.setString(2,shop_order_no.elementAt(f).toString());
		          	update_mat_shop_orders12.setString(3,order_no);	 				
					int rocount12 = update_mat_shop_orders12.executeUpdate();
					update_mat_shop_orders12.close();
					}
					catch (java.sql.SQLException e)
					{
					out.println("Problem with updating the mat job status jobs"+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					myConn.rollback();
					out.println(e.toString());
					return;					
					}
				//updating mat shop order tables done
				
			rs_efs_shop_paper1.close();	
				
			}// THE FOR LOOP
// updating the bpcs_transfered table about this Done
			//routings data exports
			
			
			dir_path="D:\\TRANSFER\\BPCS_ROU\\test\\";//final_out="";
			out.println("<BR>Let's see.... OK.................<br>"+"Check the out put in "+dir_path+" for the ROU upload files"+"<br><br><br>");						
			if (counter>0){
			String k1="";int count_rout_rows=0;String k2="";String k3="";String k4="";String k5="";String k6="";String k7="";
			String k8="";String tv="";int counter_frame_sum=0;
			//notes vars
			int notes_prod_count=1;String k1_notes="";String k2_notes="";String k3_notes="";String k4_notes="";String k5_notes="";String k6_notes="";String k7_notes="";
			String k8_notes="";String op_code="";
				for(int ot=0;ot<counter;ot++){
					count_rout_rows=1;counter_frame_sum=1;notes_prod_count=1;
					for(int in=0;in<counter_rout;in++){
					   if( (product_desc.elementAt(ot).toString().equals("product"))&(shop_item_no.elementAt(ot).toString().equals(item_no_rout.elementAt(in).toString()))&(!(block_code_rout.elementAt(in).toString().startsWith("FRAME")))&(!(block_code_rout.elementAt(in).toString().startsWith("PANS"))) ){
//					    out.println("The product"+item_no_rout.elementAt(in).toString());
					    k1=bpcs_part_main_rout.elementAt(in).toString();
					    k3=shop_order_no.elementAt(ot).toString();
						k4=op_no_rout.elementAt(in).toString();
						k5=op_name_rout.elementAt(in).toString();
						k6=work_center_rout.elementAt(in).toString();
						k7=routing_time_rout.elementAt(in).toString();
						k8=setup_time_rout.elementAt(in).toString();
						if(k1.length()<15){	//Begin the part main for the product
						tv="";
						for(int v=0;v<(15-k1.length());v++){
						tv=" "+tv;
						}
						k1=k1+tv;
						}// the part main for the product done
						if(count_rout_rows>9){k2="0"+count_rout_rows;}else{k2="00"+count_rout_rows;}//the couner variable
						k4=k4.substring(0,(k4.length())-3 );//the op_no
//						out.println("the opno"+k4+"<br>");
						if(k4.length()>1){k4="0"+k4;}else{k4="00"+k4;}//the op_no										
						if(k5.length()<30){// the op_name																						
						tv="";
						for(int v=0;v<(30-k5.length());v++){
						tv=" "+tv;
						}
						k5=k5+tv;
						}// the op_name						
						if(k6.length()<6){// the work_center																						
						tv="";
						for(int v=0;v<(6-k6.length());v++){
						tv="0"+tv;
						}
						k6=tv+k6;
						}// the  work_center
						String r="";
						    for (int i = 0; i < k7.length(); i ++) {
							    if (k7.charAt(i) != '.') r += k7.charAt(i);
					    	}	    						
						k7=r;	
						k7=k7+"0";
//						out.println("The print"+k7+"br");
						if(k7.length()<8){// the the  routings time
						tv="";
						for(int v=0;v<(8-k7.length());v++){
						tv="0"+tv;
						}
						k7=tv+k7;
						}// the  routings time
						String r1="";
						    for (int i = 0; i < k8.length(); i ++) {
							    if (k8.charAt(i) != '.') r1 += k8.charAt(i);
					    	}	    						
						k8=r1;							
						k8=k8+"0";						
						if(k8.length()<8){// the  setup time						
						tv="";
						for(int v=0;v<(8-k8.length());v++){
						tv="0"+tv;
						}
						k8=tv+k8;
						}// the setup time
						String erapid_line_no=item_no_rout.elementAt(in).toString();
						//line no's						
						if(erapid_line_no.length()<3){
							String tv1="";								
							for(int v=0;v<(3-erapid_line_no.length());v++){								
							tv1=tv1+"0";
						    }
							erapid_line_no=tv1+erapid_line_no;									
						}
						
						try {// try block starts
						op_code=op_no_rout.elementAt(in).toString();
						op_code=op_code.substring(0,(op_code.length())-3 );						
						ResultSet rs_routing_notes = stmt.executeQuery("SELECT * FROM cs_routing_notes where category = 'PROD' and op_code='"+op_code+"'  ");
							if (rs_routing_notes !=null) {
								while (rs_routing_notes.next()){
								if(notes_prod_count>9){k2_notes="0"+notes_prod_count;}else{k2_notes="00"+notes_prod_count;}	
								String notes_3=rs_routing_notes.getString(3);
								String notes_4=rs_routing_notes.getString(4);
								if(notes_4.length()<4){// the seq_no for the notes																					
								tv="";
								for(int v=0;v<(4-notes_4.length());v++){
								tv="0"+tv;
								}
								notes_4=tv+notes_4;
								}//the seq_no for the notes								
								String notes_5=rs_routing_notes.getString(5);
								if(notes_5.length()<50){// the notes	desc																				
								tv="";
								for(int v=0;v<(50-notes_5.length());v++){
								tv=" "+tv;
								}
								notes_5=notes_5+tv;
								}// the notes	desc								
								String notes_6=rs_routing_notes.getString(6);
								String notes_7=rs_routing_notes.getString(7);
//								out.println("th value"+k4+"::"+notes_3+"<br>");
								StringTokenizer st = new StringTokenizer(notes_3,",");
									while (st.hasMoreTokens()) {
										String tss=st.nextToken();
										 if(bpcs_part_main_rout.elementAt(in).toString().startsWith(tss)){
			 								notes_prod_count++;
//									        out.println("N"+k1+k2_notes+k3+k4+notes_4+notes_5+notes_6+notes_7+"MU   "+"<br>");
											final_notes_out=final_notes_out+"N"+k1+k2_notes+k3+k4+notes_4+notes_5+notes_6+notes_7+"MU"+order_no+erapid_line_no+"  "+"\r\n";
										 }												
									}//while
								notes_6="";notes_7="";k2_notes="";notes_4="";	
								}
							}
						rs_routing_notes.close();
						}// try block ends
						catch(java.sql.SQLException e){
						out.println("Problem with inserting into traNsfered jobs"+"<br>");
						out.println("Illegal Operation try again/Report Error"+"<br>");
						myConn.rollback();
						out.println(e.toString());
						return;
						}//catch block
						
					   final_out=final_out+"R"+k1+k2+k3+k4+k5+k6+" "+k7+k8+"MU"+"   "+order_no+erapid_line_no+"00000000"+"000"+"000000"+"000000"+"0000000"+"000"+"  "+"   "+"000000000000000"+"\r\n";
					   count_rout_rows++;
					   }// if looop FOR THE PRODUCT
					   if( (product_desc.elementAt(ot).toString().equals("pan"))&(shop_item_no.elementAt(ot).toString().equals(item_no_rout.elementAt(in).toString()))&((block_code_rout.elementAt(in).toString().startsWith("PANS"))) ){
//					   out.println("The pan");
						// PAN SECTION 
					    k1=bpcs_part_sub_rout.elementAt(in).toString();
					    k3=shop_order_no.elementAt(ot).toString();
						k4=op_no_rout.elementAt(in).toString();
						k5=op_name_rout.elementAt(in).toString();
						k6=work_center_rout.elementAt(in).toString();
						k7=routing_time_rout.elementAt(in).toString();
						k8=setup_time_rout.elementAt(in).toString();
						if(k1.length()<15){	//Begin the part main for the product
						tv="";
						for(int v=0;v<(15-k1.length());v++){
						tv=" "+tv;
						}
						k1=k1+tv;
						}// the part main for the product done
						if(count_rout_rows>9){k2="0"+count_rout_rows;}else{k2="00"+count_rout_rows;}//the couner variable												
						k4=k4.substring(0,(k4.length())-3 );//the op_no
						if(k4.length()>1){k4="0"+k4;}else{k4="00"+k4;}//the op_no										
						if(k5.length()<30){// the op_name																						
						tv="";
						for(int v=0;v<(30-k5.length());v++){
						tv=" "+tv;
						}
						k5=k5+tv;
						}// the op_name						
						if(k6.length()<6){// the work_center																						
						tv="";
						for(int v=0;v<(6-k6.length());v++){
						tv="0"+tv;
						}
						k6=tv+k6;
						}// the  work_center
						String r="";
						    for (int i = 0; i < k7.length(); i ++) {
							    if (k7.charAt(i) != '.') r += k7.charAt(i);
					    	}	    						
						k7=r;	
						k7=k7+"0";
//						out.println("The print"+k7+"br");
						if(k7.length()<8){// the the  routings time
						tv="";
						for(int v=0;v<(8-k7.length());v++){
						tv="0"+tv;
						}
						k7=tv+k7;
						}// the  routings time
						String r1="";
						    for (int i = 0; i < k8.length(); i ++) {
							    if (k8.charAt(i) != '.') r1 += k8.charAt(i);
					    	}	    						
						k8=r1;							
						k8=k8+"0";						
						if(k8.length()<8){// the  setup time						
						tv="";
						for(int v=0;v<(8-k8.length());v++){
						tv="0"+tv;
						}
						k8=tv+k8;
						}// the setup time
						//line no's
						String erapid_line_no=item_no_rout.elementAt(in).toString();
						if(erapid_line_no.length()<3){
							String tv2="";								
							for(int v=0;v<(3-erapid_line_no.length());v++){								
							tv2=tv2+"0";
						    }
							erapid_line_no=tv2+erapid_line_no;									
						}
									try {// try block starts
									op_code=op_no_rout.elementAt(in).toString();
									op_code=op_code.substring(0,(op_code.length())-3 );						
									ResultSet rs_routing_notes = stmt.executeQuery("SELECT * FROM cs_routing_notes where category = 'PAN' and op_code='"+op_code+"'  ");
										if (rs_routing_notes !=null) {
											while (rs_routing_notes.next()){
											if(notes_prod_count>9){k2_notes="0"+notes_prod_count;}else{k2_notes="00"+notes_prod_count;}	
											String notes_3=rs_routing_notes.getString(3);
											String notes_4=rs_routing_notes.getString(4);
											if(notes_4.length()<4){// the seq_no for the notes																					
											tv="";
											for(int v=0;v<(4-notes_4.length());v++){
											tv="0"+tv;
											}
											notes_4=tv+notes_4;
											}//the seq_no for the notes								
											String notes_5=rs_routing_notes.getString(5);
											if(notes_5.length()<50){// the notes	desc																				
											tv="";
											for(int v=0;v<(50-notes_5.length());v++){
											tv=" "+tv;
											}
											notes_5=notes_5+tv;
											}// the notes	desc								
											String notes_6=rs_routing_notes.getString(6);
											String notes_7=rs_routing_notes.getString(7);
			//								out.println("th value"+k4+"::"+notes_3+"<br>");
											StringTokenizer st = new StringTokenizer(notes_3,",");
												while (st.hasMoreTokens()) {
													String tss=st.nextToken();
													 if(bpcs_part_sub_rout.elementAt(in).toString().startsWith(tss)){
						 								notes_prod_count++;
//												        out.println("N"+k1+k2_notes+k3+k4+notes_4+notes_5+notes_6+notes_7+"MU   "+"<br>");
														final_notes_out=final_notes_out+"N"+k1+k2_notes+k3+k4+notes_4+notes_5+notes_6+notes_7+"MU"+order_no+erapid_line_no+"  "+"\r\n";
													 }												
												}//while
											notes_6="";notes_7="";k2_notes="";notes_4="";	
											}
										}
									rs_routing_notes.close();
									}// try block ends
									catch(java.sql.SQLException e){
									out.println("Problem with inserting into traNsfered jobs"+"<br>");
									out.println("Illegal Operation try again/Report Error"+"<br>");
									myConn.rollback();
									out.println(e.toString());
									return;
									}//catch block
					   final_out=final_out+"R"+k1+k2+k3+k4+k5+k6+" "+k7+k8+"MU"+"   "+order_no+erapid_line_no+"00000000"+"000"+"000000"+"000000"+"0000000"+"000"+"  "+"   "+"000000000000000"+"\r\n";
					   count_rout_rows++;
						//PAN SECTION END
					   }// if looop FOR THE PAN
					  k1="";k2="";k3="";k4="";k5="";k6="";k7="";k8="";tv="";
					}// the inner loop
//frames special section grouping
					   if( (product_desc.elementAt(ot).toString().equals("frame")) ){
					     for(int im=0;im<bpcs_part_sub_sum.size();im++){
							  if ((bpcs_part_sub_sum.elementAt(im).toString().equals(part_sub.elementAt(ot).toString()))){//inner if loop
							    k1=bpcs_part_sub_sum.elementAt(im).toString();
							    k3=shop_order_no.elementAt(ot).toString();
								k4=op_no_sum.elementAt(im).toString();
								k5=op_name_sum.elementAt(im).toString();
								k6=work_center_sum.elementAt(im).toString();
								k7=routing_time_sum.elementAt(im).toString();
								k8=setup_time_sum.elementAt(im).toString();						  
//								out.println("THe values"+k1+":"+k2+":"+k3+":"+k4+":"+k5+":"+k6+":"+k7+":"+k8+":");							  
// 							      out.println(i+"The frame"+bpcs_part_sub_sum.size()+" ipartsub:"+part_sub.elementAt(ot).toString()+":part group"+bpcs_part_sub_sum.elementAt(i).toString()+"<br>");
								//the function code
									if(k1.length()<15){	//Begin the part main for the product
									tv="";
									for(int v=0;v<(15-k1.length());v++){
									tv=" "+tv;
									}
									k1=k1+tv;
									}// the part main for the product done
									if(counter_frame_sum>9){k2="0"+counter_frame_sum;}else{k2="00"+counter_frame_sum;}//the couner variable												
									k4=k4.substring(0,(k4.length())-3 );//the op_no
									if(k4.length()>1){k4="0"+k4;}else{k4="00"+k4;}//the op_no										
									if(k5.length()<30){// the op_name																						
									tv="";
									for(int v=0;v<(30-k5.length());v++){
									tv=" "+tv;
									}
									k5=k5+tv;
									}// the op_name						
									if(k6.length()<6){// the work_center																						
									tv="";
									for(int v=0;v<(6-k6.length());v++){
									tv="0"+tv;
									}
									k6=tv+k6;
									}// the  work_center
									String r="";
									    for (int i = 0; i < k7.length(); i ++) {
										    if (k7.charAt(i) != '.') r += k7.charAt(i);
								    	}	    						
									k7=r;	
									k7=k7+"0";
			//						out.println("The print"+k7+"br");
									if(k7.length()<8){// the the  routings time
									tv="";
									for(int v=0;v<(8-k7.length());v++){
									tv="0"+tv;
									}
									k7=tv+k7;
									}// the  routings time
									String r1="";
									    for (int i = 0; i < k8.length(); i ++) {
										    if (k8.charAt(i) != '.') r1 += k8.charAt(i);
								    	}	    						
									k8=r1;							
									k8=k8+"0";						
									if(k8.length()<8){// the  setup time						
									tv="";
									for(int v=0;v<(8-k8.length());v++){
									tv="0"+tv;
									}
									k8=tv+k8;
									}// the setup time
									String erapid_line_no=item_no_rout.elementAt(ot).toString();
									if(erapid_line_no.length()<3){
										String tv3="";								
										for(int v=0;v<(3-erapid_line_no.length());v++){								
										tv3=tv3+"0";
									    }
										erapid_line_no=tv3+erapid_line_no;									
									}
									// getting notes 
											try {// try block starts
											op_code=op_no_sum.elementAt(im).toString();
											op_code=op_code.substring(0,(op_code.length())-3 );						
											ResultSet rs_routing_notes = stmt.executeQuery("SELECT * FROM cs_routing_notes where category = 'FRAME' and op_code='"+op_code+"'  ");
												if (rs_routing_notes !=null) {
													while (rs_routing_notes.next()){
													if(notes_prod_count>9){k2_notes="0"+notes_prod_count;}else{k2_notes="00"+notes_prod_count;}	
													String notes_3=rs_routing_notes.getString(3);
													String notes_4=rs_routing_notes.getString(4);
													if(notes_4.length()<4){// the seq_no for the notes																					
													tv="";
													for(int v=0;v<(4-notes_4.length());v++){
													tv="0"+tv;
													}
													notes_4=tv+notes_4;
													}//the seq_no for the notes								
													String notes_5=rs_routing_notes.getString(5);
													if(notes_5.length()<50){// the notes	desc																				
													tv="";
													for(int v=0;v<(50-notes_5.length());v++){
													tv=" "+tv;
													}
													notes_5=notes_5+tv;
													}// the notes	desc								
													String notes_6=rs_routing_notes.getString(6);
													String notes_7=rs_routing_notes.getString(7);
					//								out.println("th value"+k4+"::"+notes_3+"<br>");
													StringTokenizer st = new StringTokenizer(notes_3,",");
														while (st.hasMoreTokens()) {
															String tss=st.nextToken();
															 if(bpcs_part_sub_sum.elementAt(im).toString().startsWith(tss)){
								 								notes_prod_count++;
//														        out.println("N"+k1+k2_notes+k3+k4+notes_4+notes_5+notes_6+notes_7+"MU   "+"<br>");
																final_notes_out=final_notes_out+"N"+k1+k2_notes+k3+k4+notes_4+notes_5+notes_6+notes_7+"MU"+order_no+erapid_line_no+"  "+"\r\n";
															 }												
														}//while
													notes_6="";notes_7="";k2_notes="";notes_4="";	
													}
												}
											rs_routing_notes.close();
											}// try block ends
											catch(java.sql.SQLException e){
											out.println("Problem with inserting into trasfered jobs"+"<br>");
											out.println("Illegal Operation try again/Report Error"+"<br>");
											myConn.rollback();
											out.println(e.toString());
											return;
											}//catch block
									//getting notes done									
								   final_out=final_out+"R"+k1+k2+k3+k4+k5+k6+" "+k7+k8+"MU"+"   "+order_no+erapid_line_no+"00000000"+"000"+"000000"+"000000"+"0000000"+"000"+"  "+"   "+"000000000000000"+"\r\n";
								// the function code ends								  
							  }// inner if loops ends
							  k1="";k2="";k3="";k4="";k5="";k6="";k7="";k8="";counter_frame_sum++;tv="";							  
						 }
					   }//frames special section grouping ends										
					   //writing to the text
						BufferedWriter out1 = new BufferedWriter(new FileWriter(dir_path+"\\"+"R"+shop_order_no.elementAt(ot)+"01_"+".txt"));
						out1.write(final_out);
						out1.write(final_notes_out);
						// out.write("out put done "+"<br>");
						out.flush();
						out1.flush();
						out1.close();
					   //writing to the textf file done
					 final_out="";final_notes_out="";
				}// the outer loop
			}// the if loop
			else{
			out.println("There are no Shop orders ready for BPCS/ROU Export<br>");
			}// the else loop
			
			//routings data exports done
			//closing the connection
			stmt.close();
			rs_find.close();
			rs_cs_materials_output1.close();
			rs_cs_routings_output1.close();
			rs_cs_routings_sum.close();
			myConn.commit();
			myConn.close();

%>
	
</body>
</html>

