<%								
Vector erapid_quote_line=new Vector();Vector bpcs_parent=new Vector();Vector bpcs_child=new Vector();Vector bpcs_child_qty=new Vector();
Vector bpcs_over_ride=new Vector();Vector bpcs_scrap_factor=new Vector();Vector bpcs_op_no=new Vector();Vector bpcs_comp_ucode=new Vector();
Vector bpcs_parent_qty=new Vector();Vector bpcs_seq=new Vector();
dir_path="D:\\TRANSFER\\BPCS_BOM\\";String final_bom_out="";String final_rou_out="";dir_path1="D:\\TRANSFER\\BPCS_BOM\\test\\GE\\";
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
String final_count=im+1+"";
if(final_count.length()<3){
String tv="";
for(int v=0;v<(3-final_count.length());v++){
tv=tv+"0";
}
final_count=tv+final_count;
}
String seq=bpcs_seq.elementAt(im).toString();
if(seq.length()<3){
String tv="";
for(int v=0;v<(3-seq.length());v++){
tv=tv+"0";
}
seq=tv+seq;
}
String parent=bpcs_parent.elementAt(im).toString();
if(parent.length()<15){
String tv="";
for(int v=0;v<(15-parent.length());v++){
tv=tv+" ";
}
parent=parent+tv;
}
String child=bpcs_child.elementAt(im).toString();
if(child.length()<15){
String tv="";
for(int v=0;v<(15-child.length());v++){
tv=tv+" ";
}
child=child+tv;
}
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
String over_ride=bpcs_over_ride.elementAt(im).toString().trim();
if(over_ride.trim().length()<=0){over_ride=" ";}
String erapid_line_no=erapid_quote_line.elementAt(im).toString();
if(erapid_line_no.length()<3){
String tv="";
for(int v=0;v<(3-erapid_line_no.length());v++){
tv=tv+"0";
}
erapid_line_no=tv+erapid_line_no;
}
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
String op_no=bpcs_op_no.elementAt(im).toString().trim();
if(op_no.length()<3){
String tv="";
for(int v=0;v<(3-op_no.length());v++){
tv="0"+tv;
}
op_no=tv+op_no;
}
String comp_ucode=bpcs_comp_ucode.elementAt(im).toString().trim();
if(comp_ucode.trim().length()<=0){comp_ucode=" ";}
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

final_out="";

					Vector transfer=new Vector();Vector shop_order_no=new Vector();int counter=0;Vector part_sub=new Vector();Vector product_desc=new Vector();
					Vector qty=new Vector();Vector shop_item_no=new Vector();Vector seq_no=new Vector();
					//
					Vector qty1=new Vector();Vector text_identifier=new Vector();Vector bpcs_part_main=new Vector();Vector bpcs_part_sub=new Vector();
					Vector part_no=new Vector();int counter1=0;Vector item_no=new Vector();
					//routings store
					Vector bpcs_part_main_rout=new Vector();Vector bpcs_part_sub_rout=new Vector();int counter_rout=0;Vector item_no_rout=new Vector();
					Vector block_code_rout=new Vector();Vector setup_time_rout=new Vector();Vector routing_time_rout=new Vector();Vector op_no_rout=new Vector();Vector work_center_rout=new Vector();
					Vector op_name_rout=new Vector();

					//NumberFormat for13 = NumberFormat.getInstance();
					for13.setMaximumFractionDigits(3);
					for13.setMinimumFractionDigits(3);

					////
					//String dir_path="D:\\TRANSFER\\BPCS_BOM\\";String final_out="";
                                        String final_notes_out="";
					//String dir_path1="D:\\TRANSFER\\BPCS_BOM\\test\\GE";
		//			out.println("Let's see....OK.................<br>"+"Check the out put in"+dir_path+" for the BOM upload files"+"<br><br><br>");
					//rs_find = stmt.executeQuery("SELECT * FROM cs_bpcs_mat_shop_orders where cse_order_no like '"+order_no+"' and transfer='Y' and prod_desc <> 'misc' order by bpcs_shop_order_no ");
					//if (rs_find !=null) {
					//while (rs_find.next()){
					shop_order_no.addElement("000000");
					product_desc.addElement("product");
					part_sub.addElement("product");
					qty.addElement("1");
					shop_item_no.addElement("1");
					seq_no.addElement("1");
					counter++;
					///}
					//}


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
		Vector rmove=new Vector();
		Vector rque=new Vector();
					ResultSet rs_cs_routings_output1 = stmt.executeQuery("SELECT item_no,work_center,op_no,op_name,type_id,bpcs_part_main,bpcs_part_sub, sum(setup_time),sum(routing_time),sum(rmove),sum(rque) FROM cs_routings_output where order_no like '"+order_no+"' and len(work_center)>0 group by item_no,work_center,op_no,op_name,type_id,bpcs_part_main,bpcs_part_sub order by item_no");
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
					rmove.addElement(rs_cs_routings_output1.getString (10));
					rque.addElement(rs_cs_routings_output1.getString (11));
					counter_rout++;
					}
					}
		//			out.println("counter_rout"+counter_rout);
			 //routings table done
		Vector rmove_sum=new Vector();
		Vector rque_sum=new Vector();
			  Vector bpcs_part_main_sum=new Vector();Vector bpcs_part_sub_sum=new Vector();Vector op_no_sum=new Vector();Vector op_name_sum=new Vector();
			Vector work_center_sum=new Vector();Vector setup_time_sum=new Vector();Vector routing_time_sum=new Vector();
					ResultSet rs_cs_routings_sum = stmt.executeQuery("SELECT bpcs_part_main,bpcs_part_sub,op_no,op_name,work_center,sum(setup_time),sum(routing_time),sum(rmove),sum(rque) FROM cs_routings_output where order_no='"+order_no+"' and block_code like 'frame%' group by bpcs_part_main,bpcs_part_sub,op_no,work_center,op_name");
					if (rs_cs_routings_sum !=null) {
					while (rs_cs_routings_sum.next()){
					bpcs_part_main_sum.addElement(rs_cs_routings_sum.getString (1));
					bpcs_part_sub_sum.addElement(rs_cs_routings_sum.getString (2));
					op_no_sum.addElement(rs_cs_routings_sum.getString (3));
					op_name_sum.addElement(rs_cs_routings_sum.getString (4));
					work_center_sum.addElement(rs_cs_routings_sum.getString (5));
					setup_time_sum.addElement(rs_cs_routings_sum.getString (6));
					routing_time_sum.addElement(rs_cs_routings_sum.getString (7));
					rmove_sum.addElement(rs_cs_routings_sum.getString (8));
					rque_sum.addElement(rs_cs_routings_sum.getString (9));
				    }
					}
counter=1;
					if(counter<=0){
					out.println("There are no Shop orders ready for BPCS/BOM Export<br>");
					}
					else{
					r="";
					int count_shop=1;String county="";String parent_qty="";
                                        
						for(int i=0;i<counter;i++){
						  // If it is product only
                                                  //out.println("a"+product_desc.elementAt(i).toString());
						  if( (product_desc.elementAt(i).toString().equals("product")) ){
                                                      //out.println("1x");
								ResultSet rs_efs_shop_paper1 = stmt.executeQuery("SELECT part_no,cast(detail_desc as varchar(600)),bpcs_part_main,sum(qty) FROM cs_materials_output where order_no like '"+order_no+"' and product_id='efs' and (text_identifier not like 'FRAME%' AND text_identifier not like 'PAN%') group by part_no,cast(detail_desc as varchar(600)),bpcs_part_main ");
									if (rs_efs_shop_paper1 !=null) {
										while (rs_efs_shop_paper1.next()){
                                                                                    out.println("1");
										String t1x=rs_efs_shop_paper1.getString(1);
										String t2x=rs_efs_shop_paper1.getString(2);
										String t3=rs_efs_shop_paper1.getString(3);
										String t4=rs_efs_shop_paper1.getString(4);
										//counter
                                                                                //out.println("2");
										if(count_shop>9){county="0"+count_shop;}else{county="00"+count_shop;}
										if(t3.length()<15){
												String tv="";
											for(int v=0;v<(15-t3.length());v++){
											tv=" "+tv;
		//									out.println("the T3 value: "+t3.length()+"vb"+v+"***"+tv+"<br>");
										    }
											t3=t3+tv;
										}
                                                                                out.println("3"+t1x);
										if(t1x.length()<15){
											String tv="";
											for(int v=0;v<(15-t1x.length());v++){
											tv=" "+tv;
											}
											t1x=t1x+tv;
		//									t3=t3+tv;
										}
										r="";
                                                                                out.println("4");
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
										String erapid_line_no=seq_no.elementAt(i).toString();
										if(erapid_line_no.length()<3){
											String tv="";
											for(int v=0;v<(3-erapid_line_no.length());v++){
											tv=tv+"0";
										    }
											erapid_line_no=tv+erapid_line_no;
										}
										//quantity of parent
                                                                            
										r="";
										parent_qty=qty.elementAt(i).toString();
										for (int it = 0; it < parent_qty.length(); it ++) {
											if (parent_qty.charAt(it) != '.' && parent_qty.charAt(it) != ',') r += parent_qty.charAt(it);
										}
										parent_qty=r;
										if(parent_qty.length()<11){
												String tv="";
												for(int v=0;v<(11-parent_qty.length());v++){
												tv="0"+tv;
												}
												parent_qty=tv+parent_qty;
										}
		//								final_out="";
										final_bom_out=final_bom_out+county+"MU"+t3+t1x+t4+"0000"+"  "+"N"+"2 "+"000000"+order_no+erapid_line_no+"00000"+"000"+" "+parent_qty+"\r\n";
		//the real debebug		out.println("order "+i+"The PRODUCT "+shop_item_no.elementAt(i)+" "+"<br>");
		//								out.println("The PRODUCT "+shop_item_no.elementAt(i)+"<br>");
									count_shop++;
										}//the result set while
									}//the result set if


							count_shop=1;county="";rs_efs_shop_paper1.close();
									out.println("Shop Order "+shop_order_no.elementAt(i)+" sent to BPCS successfully......."+"<br>");
						  }// If it is product only
                                              
						  //iF IT IS A PAN ONLY - in the query below we used to cast(sum(qty)as integer)
						  if( (product_desc.elementAt(i).toString().equals("pan")) ){
								ResultSet rs_efs_shop_paper1 = stmt.executeQuery("SELECT part_no,cast(detail_desc as varchar(600)),bpcs_part_sub,sum(qty) FROM cs_materials_output where order_no like '"+order_no+"' and item_no='"+shop_item_no.elementAt(i)+"' and text_identifier like 'PAN%' group by part_no,cast(detail_desc as varchar(600)),bpcs_part_sub");
									if (rs_efs_shop_paper1 !=null) {
										while (rs_efs_shop_paper1.next()){
										String t1x=rs_efs_shop_paper1.getString(1);
										String t2x=rs_efs_shop_paper1.getString(2);
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
										if(t1x.length()<15){
											String tv="";
											for(int v=0;v<(15-t1x.length());v++){
											tv=" "+tv;
											}
		//									t1x=tv+t1;
											t1x=t1x+tv;
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
										String erapid_line_no=seq_no.elementAt(i).toString();
										if(erapid_line_no.length()<3){
											String tv="";
											for(int v=0;v<(3-erapid_line_no.length());v++){
											tv=tv+"0";
										    }
											erapid_line_no=tv+erapid_line_no;
										}
										//quantity of parent
										r="";
										parent_qty=qty.elementAt(i).toString();
										for (int it = 0; it < parent_qty.length(); it ++) {
											if (parent_qty.charAt(it) != '.' && parent_qty.charAt(it) != ',') r += parent_qty.charAt(it);
										}
										parent_qty=r;
										if(parent_qty.length()<11){
												String tv="";
												for(int v=0;v<(11-parent_qty.length());v++){
												tv="0"+tv;
												}
												parent_qty=tv+parent_qty;
										}
		//								final_out="";
										final_bom_out=final_bom_out+county+"MU"+t3+t1x+t4+"0000"+"  "+"N"+"2 "+"000000"+order_no+erapid_line_no+"00000"+"000"+" "+parent_qty+"\r\n";
		//the real debebug				out.println("order "+(i)+"The PAN "+shop_item_no.elementAt(i)+" "+"<br>");
		//								out.println("The PAN "+shop_item_no.elementAt(i)+"<br>");
									count_shop++;
										}//the result set while
									}//the result set if

										//out put to text files
									//	 BufferedWriter out1BOMEFS  = new BufferedWriter(new FileWriter(dir_path+"\\"+"B"+shop_order_no.elementAt(i)+"01_"+".txt"));
								//		 out1BOMEFS .write(final_out);
		//								 out.write("out put done "+"<br>");
								//		 out.flush();
								//		 out1BOMEFS .flush();
								//		 out1BOMEFS .close();
										//out put to text files done
							count_shop=1;county="";rs_efs_shop_paper1.close();
								//	out.println("Shop Order "+shop_order_no.elementAt(i)+" sent to BPCS successfully......."+"<br>");
						  }// If it is A PAN ONLY
                                                  out.println("c");
						  //iF IT IS A frame ONLY - in the query below we used to cast(sum(qty)as integer)
						  if( (product_desc.elementAt(i).toString().equals("frame")) ){
								ResultSet rs_efs_shop_paper1 = stmt.executeQuery("SELECT bpcs_part_sub,PART_NO,sum(qty) FROM cs_materials_output where order_no like '"+order_no+"' and text_identifier like 'FRAME%' AND bpcs_part_sub='"+part_sub.elementAt(i)+"' group by bpcs_part_sub,part_no ");
									if (rs_efs_shop_paper1 !=null) {
										while (rs_efs_shop_paper1.next()){
										String t3=rs_efs_shop_paper1.getString(1);
										String t1x=rs_efs_shop_paper1.getString(2);
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
										if(t1x.length()<15){
											String tv="";
											for(int v=0;v<(15-t1x.length());v++){
											tv=" "+tv;
											}
		//									t1x=tv+t1;
											t1x=t1x+tv;
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
										String erapid_line_no=seq_no.elementAt(i).toString();
										if(erapid_line_no.length()<3){
											String tv="";
											for(int v=0;v<(3-erapid_line_no.length());v++){
											tv=tv+"0";
										    }
											erapid_line_no=tv+erapid_line_no;
										}
										//quantity of parent
										r="";
										parent_qty=qty.elementAt(i).toString();
										for (int it = 0; it < parent_qty.length(); it ++) {
											if (parent_qty.charAt(it) != '.' && parent_qty.charAt(it) != ',') r += parent_qty.charAt(it);
										}
										parent_qty=r;
										if(parent_qty.length()<11){
												String tv="";
												for(int v=0;v<(11-parent_qty.length());v++){
												tv="0"+tv;
												}
												parent_qty=tv+parent_qty;
										}
		//								final_out="";
										final_bom_out=final_bom_out+county+"MU"+t3+t1x+t4+"0000"+"  "+"N"+"2 "+"000000"+order_no+erapid_line_no+"00000"+"000"+" "+parent_qty+"\r\n";
		//the real debebug				out.println("order "+(i)+"The FRAME "+shop_item_no.elementAt(i)+" "+"<br>");
		//								out.println("The FRAME "+shop_item_no.elementAt(i)+"<br>");
									count_shop++;
										}//the result set while
									}//the result set if
									//out put to text files
		//								 BufferedWriter out1BOMEFS  = new BufferedWriter(new FileWriter(dir_path+"\\"+"B"+shop_order_no.elementAt(i)+"01_"+".txt"));
		//								 out1BOMEFS .write(final_out);
		//								 out.write("out put done "+"<br>");
			//	 						 out.flush();
				//						 out1BOMEFS .flush();
					//					 out1BOMEFS .close();
										//out put to text files done
							count_shop=1;county="";rs_efs_shop_paper1.close();
								//	out.println("Shop Order "+shop_order_no.elementAt(i)+" sent to BPCS successfully......."+"<br>");
						  }// If it is A FRAME ONLY
                                                  out.println("d");
						}//outer for
					}// the else close

                                        BufferedWriter out_bom = new BufferedWriter(new FileWriter(dir_path+"\\"+"B"+order_no.trim()+".txt"));
out_bom.write(final_bom_out);
out.println("BOM transfer done "+"<br>");
out.flush();
out_bom.flush();
out_bom.close();
BufferedWriter out_bom1 = new BufferedWriter(new FileWriter(dir_path1+"\\"+"B"+order_no+".txt"));
out_bom1.write(final_bom_out);
out_bom1.flush();
out_bom1.close();


				//Transfering Bills as on file starts
				BufferedWriter out1BOMEFS  = new BufferedWriter(new FileWriter(dir_path+"\\"+"B"+order_no+"x.txt"));
										 out1BOMEFS .write(final_out);
		//								 out.write("out put done "+"<br>");
										 out.flush();
										 out1BOMEFS .flush();
										 out1BOMEFS .close();
										 /*
									 BufferedWriter out3 = new BufferedWriter(new FileWriter(dir_path1+"\\"+"B"+order_no+"x.txt"));
									 out3.write(final_out);
									 out3.flush();
									 out3.close();
									 */




				//Routings out put start
					   dir_path="D:\\TRANSFER\\BPCS_ROU\\";dir_path1="D:\\TRANSFER\\BPCS_ROU\\test\\GE\\";
					   out.println("ROU's transfer start......<br>");
					   Vector bpcs_rou_parent=new Vector();Vector bpcs_rou_op_no=new Vector();Vector bpcs_rou_op_desc=new Vector();Vector bpcs_rou_work_ctr=new Vector();
					   Vector bpcs_rou_bcode=new Vector();Vector bpcs_rou_rlab=new Vector();Vector bpcs_rou_rset=new Vector();	Vector bpcs_rou_whs=new Vector();
					   Vector erapid_rou_quote_line=new Vector();Vector bpcs_rou_mhrs=new Vector();Vector bpcs_run_ops=new Vector();
					   Vector bpcs_rmove=new Vector();Vector bpcs_rque=new Vector();Vector bpcs_rstyd=new Vector();
					   Vector bpcs_rsoup=new Vector();Vector bpcs_rtrtem=new Vector();Vector bpcs_rtoflg=new Vector();
					   Vector bpcs_rsbas=new Vector();Vector bpcs_rcold=new Vector();Vector bpcs_rtoutc=new Vector();
		//logger.debug("o");
		//out.println("SELECT * FROM cs_bpcs_frt where doc_number like '"+order_no+"' and doc_line in ("+lines_final+") order by cast(doc_line as integer)");
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
		//out.println(rs_frt.getString("doc_line")+"::<BR>");


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
                                                             final_rou_out=final_rou_out+"R"+parent+final_count+"000000"+op_no+op_desc+work_ctr+bcode+run_hrs+set_hrs+whs+"   "+order_no.trim()+erapid_line_no+mach_hrs+run_ops+move_time+que_time+yield+setup_ops+routing_code+is_os_flag+sp_bcode+rcold+os_cost+"\r\n";
					    }//for loop ends
				   //ROU out put to text files
                                   
                                   
       if (counter>0){
					String k1="";int count_rout_rows=0;String k2="";String k3="";String k4="";String k5="";String k6="";String k7="";
					String k8="";String tv="";int counter_frame_sum=0;
					String k9="";
					String k10="";
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
								k9=rmove.elementAt(in).toString();
								k10=rque.elementAt(in).toString();
								if(k1.length()<15){	//Begin the part main for the product
								tv="";
								for(int v=0;v<(15-k1.length());v++){
								tv=" "+tv;
								}
								k1=k1+tv;
								}// the part main for the product done
								if(k3.length()<6){	//Begin the shop order no
									tv="";
									for(int v=0;v<(6-k3.length());v++){
									tv="0"+tv;
									}
									k3=k3+tv;
								}// Shop order no done
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

								if(new Double(k7).doubleValue()>0){
		//							out.println("The product"+k7+"::"+qty.elementAt(ot).toString());
								k7=for13.format((new Double(qty.elementAt(ot).toString()).doubleValue())/(new Double(k7).doubleValue()));
								}else{
									k7=k7+"0";
								}
								r="";
								    for (int i = 0; i < k7.length(); i ++) {
									    //if (k7.charAt(i) != '.') r += k7.charAt(i);
									    if (k7.charAt(i) != '.' && k7.charAt(i) != ',') r += k7.charAt(i);
								}
		//							out.println("The product"+k7+"::"+qty.elementAt(ot).toString()+"<br>");
								k7=r;
						//		k7=k7+"0";
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


								r1="";
								for (int i = 0; i < k9.length(); i ++) {
									if (k9.charAt(i) != '.') r1 += k9.charAt(i);
								}
								k9=r1;
								//k9=k9+"0";
								if(k9.length()<6){// the  setup time
									tv="";
									for(int v=0;v<(6-k9.length());v++){
										tv="0"+tv;
									}
									k9=tv+k9;
								}
								r1="";
//out.println(k10+"<BR>");
								for (int i = 0; i < k10.length(); i ++) {
									if (k10.charAt(i) != '.') r1 += k10.charAt(i);
								}
								k10=r1;
//out.println(k10+"<BR>");
								//k9=k9+"0";
								if(k10.length()<6){// the  setup time
									tv="";
									for(int v=0;v<(6-k10.length());v++){
										tv="0"+tv;
									}
									k10=tv+k10;
								}

//out.println(k10+"<BR><BR>");







								String erapid_line_no=seq_no.elementAt(ot).toString();
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
										StringTokenizer stx = new StringTokenizer(notes_3,",");
											while (stx.hasMoreTokens()) {
												String tss=stx.nextToken();
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
								//final_out=final_out+"R"+k1+k2+k3+k4+k5+k6+"P"+k7+k8+"MU"+"   "+order_no+erapid_line_no+"00000000"+"000"+"000000"+"000000"+"0000000"+"000"+"  "+"  1"+"000000000000000"+"\r\n";
							   final_out=final_out+"R"+k1+k2+k3+k4+k5+k6+"P"+k7+k8+"MU"+"   "+order_no+erapid_line_no+"00000000"+"000"+k9+k10+"0000000"+"000"+"  "+"  1"+"000000000000000"+"\r\n";
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
k9=rmove.elementAt(in).toString();
								k10=rque.elementAt(in).toString();
								if(k1.length()<15){	//Begin the part main for the product
								tv="";
								for(int v=0;v<(15-k1.length());v++){
								tv=" "+tv;
								}
								k1=k1+tv;
								}// the part main for the product done
								if(k3.length()<6){	//Begin the shop order no
									tv="";
									for(int v=0;v<(6-k3.length());v++){
									tv="0"+tv;
									}
									k3=k3+tv;
								}// Shop order no done
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
								//k7=for13.format((new Double(k7).doubleValue())/(new Double(qty.elementAt(ot).toString()).doubleValue()));
						//		k7=for13.format((new Double(qty.elementAt(ot).toString()).doubleValue())/(new Double(k7).doubleValue()));
								if(new Double(k7).doubleValue()>0){
								k7=for13.format((new Double(qty.elementAt(ot).toString()).doubleValue())/(new Double(k7).doubleValue()));
								}else{
									k7=k7+"0";
								}
								r="";
								    for (int i = 0; i < k7.length(); i ++) {
									    //if (k7.charAt(i) != '.') r += k7.charAt(i);
									    if (k7.charAt(i) != '.' && k7.charAt(i) != ',') r += k7.charAt(i);
								}
								k7=r;
							//	k7=k7+"0";
		//						out.println("The pan"+k7+"<br>");
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


								r1="";
								for (int i = 0; i < k9.length(); i ++) {
									if (k9.charAt(i) != '.') r1 += k9.charAt(i);
								}
								k9=r1;
								//k9=k9+"0";
								if(k9.length()<6){// the  setup time
									tv="";
									for(int v=0;v<(6-k9.length());v++){
										tv="0"+tv;
									}
									k9=tv+k9;
								}
								r1="";
								for (int i = 0; i < k10.length(); i ++) {
									if (k10.charAt(i) != '.') r1 += k10.charAt(i);
								}
								k10=r1;
								//k9=k9+"0";
								if(k10.length()<6){// the  setup time
									tv="";
									for(int v=0;v<(6-k10.length());v++){
										tv="0"+tv;
									}
									k10=tv+k10;
								}


								String erapid_line_no=seq_no.elementAt(ot).toString();
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
													StringTokenizer stx = new StringTokenizer(notes_3,",");
														while (stx.hasMoreTokens()) {
															String tss=stx.nextToken();
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
							   //final_out=final_out+"R"+k1+k2+k3+k4+k5+k6+"P"+k7+k8+"MU"+"   "+order_no+erapid_line_no+"00000000"+"000"+"000000"+"000000"+"0000000"+"000"+"  "+"  1"+"000000000000000"+"\r\n";
							   final_out=final_out+"R"+k1+k2+k3+k4+k5+k6+"P"+k7+k8+"MU"+"   "+order_no+erapid_line_no+"00000000"+"000"+k9+k10+"0000000"+"000"+"  "+"  1"+"000000000000000"+"\r\n";
							   count_rout_rows++;
								//PAN SECTION END
							   }// if looop FOR THE PAN
							  k1="";k2="";k3="";k4="";k5="";k6="";k7="";k8="";k9="";k10="";tv="";
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
										k9=rmove_sum.elementAt(im).toString();
										k10=rque_sum.elementAt(im).toString();
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
											if(k3.length()<6){	//Begin the shop order no
												tv="";
												for(int v=0;v<(6-k3.length());v++){
												tv="0"+tv;
												}
												k3=k3+tv;
											}// Shop order no done
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
		//									k7=for13.format((new Double(k7).doubleValue())/(new Double(qty.elementAt(ot).toString()).doubleValue()));
		//									k7=for13.format((new Double(qty.elementAt(ot).toString()).doubleValue())/(new Double(k7).doubleValue()));
											if(new Double(k7).doubleValue()>0){
											k7=for13.format((new Double(qty.elementAt(ot).toString()).doubleValue())/(new Double(k7).doubleValue()));
											}else{
												k7=k7+"0";
											}
											r="";
											    for (int i = 0; i < k7.length(); i ++) {
		//										    if (k7.charAt(i) != '.') r += k7.charAt(i);
												    if (k7.charAt(i) != '.' && k7.charAt(i) != ',') r += k7.charAt(i);
											}
											k7=r;
										//	k7=k7+"0";
		//									out.println("The frame"+k7+"<br>");
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
											String erapid_line_no=seq_no.elementAt(ot).toString();
											if(erapid_line_no.length()<3){
												String tv3="";
												for(int v=0;v<(3-erapid_line_no.length());v++){
												tv3=tv3+"0";
											    }
												erapid_line_no=tv3+erapid_line_no;
											}

											r1="";
											for (int i = 0; i < k9.length(); i ++) {
												if (k9.charAt(i) != '.') r1 += k9.charAt(i);
											}
											k9=r1;
											//k9=k9+"0";
											if(k9.length()<6){// the  setup time
												tv="";
												for(int v=0;v<(6-k9.length());v++){
													tv="0"+tv;
												}
												k9=tv+k9;
											}
											r1="";
											for (int i = 0; i < k10.length(); i ++) {
												if (k10.charAt(i) != '.') r1 += k10.charAt(i);
											}
											k10=r1;
											//k9=k9+"0";
											if(k10.length()<6){// the  setup time
												tv="";
												for(int v=0;v<(6-k10.length());v++){
													tv="0"+tv;
												}
												k10=tv+k10;
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
															StringTokenizer stx = new StringTokenizer(notes_3,",");
																while (stx.hasMoreTokens()) {
																	String tss=stx.nextToken();
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
										   //final_out=final_out+"R"+k1+k2+k3+k4+k5+k6+"P"+k7+k8+"MU"+"   "+order_no+erapid_line_no+"00000000"+"000"+"000000"+"000000"+"0000000"+"000"+"  "+"  1"+"000000000000000"+"\r\n";
										   final_out=final_out+"R"+k1+k2+k3+k4+k5+k6+"P"+k7+k8+"MU"+"   "+order_no+erapid_line_no+"00000000"+"000"+k9+k10+"0000000"+"000"+"  "+"  1"+"000000000000000"+"\r\n";
										// the function code ends
									  }// inner if loops ends
									  k1="";k2="";k3="";k4="";k5="";k6="";k7="";k8="";k9="";k10="";counter_frame_sum++;tv="";
								 }
							   }//frames special section grouping ends

						}// the outer loop
						//Routing text file transfer for the order
                                                final_rou_out=final_rou_out+final_out+final_notes_out;
                                                /*
								BufferedWriter out2 = new BufferedWriter(new FileWriter(dir_path+"\\"+"R"+order_no+".txt"));
								out2.write(final_out);
								out2.write(final_notes_out);
								// out.write("out put done "+"<br>");
								out.flush();
								out2.flush();
								out2.close();
												 BufferedWriter out4 = new BufferedWriter(new FileWriter(dir_path1+"\\"+"R"+order_no+".txt"));
												 out4.write(final_out);
												 out4.flush();
												 out4.close();
*/

						//Routing text file transfer for the order done

					}                            
                                   
                                   
                                   
					    BufferedWriter out_rou = new BufferedWriter(new FileWriter(dir_path+"\\"+"R"+order_no.trim()+".txt"));
					    out_rou.write(final_rou_out);
					    out.println("ROU transfer done "+"<br>");
					    out.flush();
					    out_rou.flush();
					    out_rou.close();
		//logger.debug("1");
					   //outputting to second folder
					    BufferedWriter out_rou1 = new BufferedWriter(new FileWriter(dir_path1+"\\"+"R"+order_no+".txt"));
							  out_rou1.write(final_rou_out);
							  out_rou1.flush();
							  out_rou1.close();
%>