<%!

/**
	 * Checks given a group is duplicated or not and returns flag accordingly.
	 * Same Index in all Vectors forms a group.
	 * Group ==> All Vectors : sskp_code_group, model_group, finish_group, sshCode_group, sTile_group, coreCode_group, ssedgeCode_group, actuatorGroup
	 
	 * @param index : current Index of all Vector group record
	 * @param rs_cscosting_group: ResultSet for currrent field values.
	 * @param sskp_code_group
	 * @param model_group
	 * @param finish_group
	 * @param sshCode_group
	 * @param sTile_group
	 * @param coreCode_group
	 * @param ssedgeCode_group
	 * @param actuatorGroup
	 * @return : Boolean flag indicating current Group is duplicated or not.
	 * @throws SQLException
	 */
	private boolean isDuplicateGroup(int index, ResultSet rs_cscosting_group, Vector sskp_code_group,
			Vector model_group, Vector finish_group, Vector sshCode_group, Vector sTile_group, Vector coreCode_group,
			Vector ssedgeCode_group, Vector actuatorGroup) throws SQLException {

		boolean isDuplicate = false;
		try {

			for (int currentIndex = index; currentIndex >= 0; currentIndex--) {

				String tempActuator = rs_cscosting_group.getString("actuator");
				String sskpCode = rs_cscosting_group.getString("sskp_code");				
				String sshCode = rs_cscosting_group.getString("ssh_code");
				String stileCode = rs_cscosting_group.getString("stile_code");
				String coreCode = rs_cscosting_group.getString("core_code");
				String ssedgeCode = rs_cscosting_group.getString("ssedge_code");
				if (tempActuator == null) {
					tempActuator = "";
				}	
				if (sskpCode == null) {
					sskpCode = "";
				}	
				if (sshCode == null) {
					sshCode = "";
				}	
				if (stileCode == null) {
					stileCode = "";
				}	
				if (coreCode == null) {
					coreCode = "";
				}	
				if (ssedgeCode == null) {
					ssedgeCode = "";
				}	
				if (!(sskp_code_group.elementAt(currentIndex).equals(sskpCode)
						&& model_group.elementAt(currentIndex).equals(rs_cscosting_group.getString("model"))
						&& finish_group.elementAt(currentIndex).equals(rs_cscosting_group.getString("finish"))
						&& sshCode_group.elementAt(currentIndex).equals(sshCode)
						&& sTile_group.elementAt(currentIndex).equals(stileCode)
						&& coreCode_group.elementAt(currentIndex).equals(coreCode)
						&& ssedgeCode_group.elementAt(currentIndex).equals(ssedgeCode)
						&& actuatorGroup.elementAt(currentIndex).equals(tempActuator))) {
					continue;
				} else {
					isDuplicate = true;
					break;
				}
			}
		} catch (SQLException sqEx) {
			throw sqEx;
		}
		return isDuplicate;
	}
%>

<%
	Vector configString=new Vector();
	Vector configLineNo=new Vector();
	Vector configProductId=new Vector();
	ResultSet rsDocLine=stmt.executeQuery("select doc_line, config_string,product_id from doc_line where doc_number='"+order_no+"'");
	if(rsDocLine != null){
		while(rsDocLine.next()){
			configString.addElement(rsDocLine.getString("config_string"));
			configLineNo.addElement(rsDocLine.getString("doc_line"));
			configProductId.addElement(rsDocLine.getString("product_id"));
		}
	}
	rsDocLine.close();
	
	NumberFormat for12 = NumberFormat.getInstance();
	for12.setMaximumFractionDigits(1);
	int k=0;String bgcolor="";Vector mark=new Vector();Vector desc=new Vector();Vector qty=new Vector();Vector rec_no=new Vector();int bcount=0;
	Vector line_no=new Vector();Vector block_id=new Vector();Vector field20=new Vector();Vector width=new Vector();Vector height=new Vector();Vector screen=new Vector();Vector finish=new Vector();
	Vector model=new Vector();Vector model_group=new Vector();Vector screen_group=new Vector();Vector finish_group=new Vector();Vector group_count=new Vector();Vector item_all=new Vector();Vector wind_load=new Vector();
	Vector numMullions=new Vector();Vector secWide=new Vector(); Vector secHigh=new Vector(); Vector sskp_code=new Vector(); Vector sskp_code_group=new Vector();
	Vector field18=new Vector();Vector pidCsquotes=new Vector();Vector line_product_id=new Vector();
	Vector pidCsCosting=new Vector();Vector sch=new Vector();
	Vector actuator=new Vector();
	Vector actuatorGroup=new Vector();
	Vector mount=new Vector();
    Vector outrigger=new Vector();
    Vector blades=new Vector();
    Vector frontFascia=new Vector();
    Vector rearFascia=new Vector();
    
    Vector sshCode_group=new Vector(); Vector sTile_group=new Vector();Vector coreCode_group=new Vector(); Vector ssedgeCode_group=new Vector();
    
	ResultSet rs_csquotes = stmt.executeQuery("select * from csquotes where order_no='"+order_no+"' order by cast(Line_no as integer)");
	if (rs_csquotes !=null) {
		while (rs_csquotes.next()) {
			line_no.addElement(rs_csquotes.getString("Line_no"));
			desc.addElement(rs_csquotes.getString("Descript"));
			block_id.addElement(rs_csquotes.getString("block_id"));
			rec_no.addElement(rs_csquotes.getString("Record_no"));
			field20.addElement(rs_csquotes.getString("field20"));
			numMullions.addElement(rs_csquotes.getString("stock"));
			secWide.addElement(rs_csquotes.getString("field16"));
			secHigh.addElement(rs_csquotes.getString("field19"));
			field18.addElement(rs_csquotes.getString("field18"));
			pidCsquotes.addElement(rs_csquotes.getString("product_id"));
			line_product_id.addElement(rs_csquotes.getString("product_id"));
			
			k++;
		}
	}
	rs_csquotes.close();
	
	int t_costing=0;
	ResultSet rs_cscosting = stmt.executeQuery("select * from cs_costing where order_no='"+order_no+"' and model not in ('8615F') order by cast(item_no as integer)");
	if (rs_cscosting !=null) {
		while (rs_cscosting.next()) {
			item_all.addElement(rs_cscosting.getString("item_no"));
			pidCsCosting.addElement(rs_cscosting.getString("product_id"));
			model.addElement(rs_cscosting.getString("model"));
			width.addElement(rs_cscosting.getString("width"));
			height.addElement(rs_cscosting.getString("height"));
			finish.addElement(rs_cscosting.getString("finish"));
			screen.addElement(rs_cscosting.getString("screen"));
			qty.addElement(rs_cscosting.getString("qty"));
			mark.addElement(rs_cscosting.getString("mark"));
			if(rs_cscosting.getString("s_options")!= null){
				sch.addElement(rs_cscosting.getString("s_options"));
			}
			else{
				sch.addElement("");
			}
			if(rs_cscosting.getString("actuator")!=null){
				actuator.addElement(rs_cscosting.getString("actuator"));
			}
			else{
				actuator.addElement("");
			}
			if(rs_cscosting.getString("sskp_code")!=null){
				sskp_code.addElement(rs_cscosting.getString("sskp_code"));
			}
			else{
				sskp_code.addElement("");
			}		
			
			String strMount = rs_cscosting.getString("core_code");
			String strSsedgeCcode = rs_cscosting.getString("ssedge_code");
			String strSkipCode = rs_cscosting.getString("sskp_code");
			String strSshCode = rs_cscosting.getString("ssh_code");
			String strStileCode = rs_cscosting.getString("stile_code");			
			if(null== strMount){
				strMount = "";
			}
			if(null== strSsedgeCcode){
				strSsedgeCcode = "";
			}
			if(null== strSkipCode){
				strSkipCode = "";
			}
			if(null== strSshCode){
				strSshCode = "";
			}
			if(null== strStileCode){
				strStileCode = "";
			}			
			
            mount.addElement(strMount);
            outrigger.addElement(strSsedgeCcode);
            blades.addElement(strSkipCode);
            frontFascia.addElement(strSshCode);
            rearFascia.addElement(strStileCode);
            
			t_costing++;
		}
	}
	rs_cscosting.close();
	
	int t_group=0;
	
	ResultSet rs_cscosting_group = stmt.executeQuery("SELECT MODEL,FINISH,screen,actuator,sskp_code,ssh_code, stile_code, core_code, ssedge_code, item_no,  COUNT(*)as v from cs_costing where order_no='"+order_no+"' and model not in ('8615F') GROUP BY MODEL,FINISH,screen,actuator,sskp_code,ssh_code, stile_code, core_code, ssedge_code, item_no ORDER BY item_no");
	if (rs_cscosting_group !=null) {
		while (rs_cscosting_group.next()) {
			if(t_group==0){
				model_group.addElement(rs_cscosting_group.getString("model"));
				finish_group.addElement(rs_cscosting_group.getString("finish"));
				screen_group.addElement(rs_cscosting_group.getString("screen"));
				//#GJM-462: newly added fields ssh_code, stile_code, core_code, ssedge_code
				group_count.addElement(rs_cscosting_group.getString("v"));
				if(rs_cscosting_group.getString("actuator")!=null){
					actuatorGroup.addElement(rs_cscosting_group.getString("actuator"));
				}
				else{
					actuatorGroup.addElement("");
				}
				if(rs_cscosting_group.getString("sskp_code")!=null){
					sskp_code_group.addElement(rs_cscosting_group.getString("sskp_code"));
				}
				else{
					sskp_code_group.addElement("");
				}
				
                //Add values in to Vector based on null check
                //SShCode
				if(rs_cscosting_group.getString("ssh_code")!=null){
					sshCode_group.addElement(rs_cscosting_group.getString("ssh_code"));
				}
				else{
					sshCode_group.addElement("");
				}
				
				//sTileCode
				if(rs_cscosting_group.getString("stile_code")!=null){
					sTile_group.addElement(rs_cscosting_group.getString("stile_code"));
				}
				else{
					sTile_group.addElement("");
				}
				
				//coreCode
				if(rs_cscosting_group.getString("core_code")!=null){
					coreCode_group.addElement(rs_cscosting_group.getString("core_code"));
				}
				else{
					coreCode_group.addElement("");
				}
				
				//ssedge_code
				if(rs_cscosting_group.getString("ssedge_code")!=null){
					ssedgeCode_group.addElement(rs_cscosting_group.getString("ssedge_code"));
				}
				else{
					ssedgeCode_group.addElement("");
				}
				
				t_group++;			
			}
			else {				
				boolean isDuplicate = false;				
				try{				
					
					isDuplicate = isDuplicateGroup(t_group-1, rs_cscosting_group,  sskp_code_group, model_group, finish_group, sshCode_group, 
			    		 sTile_group,  coreCode_group, ssedgeCode_group, actuatorGroup);
				}
				catch(SQLException sqEx){
					out.println("<h1> SQLExceptiont = "+sqEx.getMessage()+"</h1>"); 		
				}
				catch(Exception ex){					
					out.println("<h1> Exceptiont = "+ex.getMessage()+"</h1>"); 	
				}
					
				if(!isDuplicate){

					model_group.addElement(rs_cscosting_group.getString("model"));
					finish_group.addElement(rs_cscosting_group.getString("finish"));
					screen_group.addElement(rs_cscosting_group.getString("screen"));
					group_count.addElement(rs_cscosting_group.getString("v"));
					if(rs_cscosting_group.getString("actuator")!=null){
						actuatorGroup.addElement(rs_cscosting_group.getString("actuator"));
					}
					else{
						actuatorGroup.addElement("");
					}
					if(rs_cscosting_group.getString("sskp_code")!=null){
						sskp_code_group.addElement(rs_cscosting_group.getString("sskp_code"));
					}
					else{
						sskp_code_group.addElement("");
					}
					
					//Add values in to Vector based on null check
	                //SShCode
					if(rs_cscosting_group.getString("ssh_code")!=null){
						sshCode_group.addElement(rs_cscosting_group.getString("ssh_code"));
					}
					else{
						sshCode_group.addElement("");
					}
					
					//sTileCode
					if(rs_cscosting_group.getString("stile_code")!=null){
						sTile_group.addElement(rs_cscosting_group.getString("stile_code"));
					}
					else{
						sTile_group.addElement("");
					}
					
					//coreCode
					if(rs_cscosting_group.getString("core_code")!=null){
						coreCode_group.addElement(rs_cscosting_group.getString("core_code"));
					}
					else{
						coreCode_group.addElement("");
					}
					
					//ssedge_code
					if(rs_cscosting_group.getString("ssedge_code")!=null){
						ssedgeCode_group.addElement(rs_cscosting_group.getString("ssedge_code"));
					}
					else{
						ssedgeCode_group.addElement("");
					}

					t_group++;
				}
			}
		}
	}
	rs_cscosting_group.close();
	
	String blank_off="";String sills="";String snap_ons="";String shape="";
	String numMullionsTemp="";
	String secSize="";
	String tempmodel="";
	String lvr_sec_desc="";
	String lvr_sec_add="";
	String lvr_spec_sec="";
	String lvr_sec_date="";
	
	if (t_group>0){
		for(int mn=0;mn<t_group;mn++){
			for (int n=0;n<t_costing;n++){
				if((model_group.elementAt(mn).toString().equals(model.elementAt(n).toString()))&(finish_group.elementAt(mn).toString().equals(finish.elementAt(n).toString()))&(screen_group.elementAt(mn).toString().equals(screen.elementAt(n).toString()))){
					boolean isMod=false;
					boolean isMyr=false;
					String cellsize="";
					String grilldepth="";
					String thickness="";
					String angle="";
					
					String looseBlades="";  
                    String queryx="select descript from csquotes where order_no='"+order_no+"' and block_id='d_notes' and line_no in (SELECT  item_no from cs_costing where order_no='"+order_no+"' and model not in ('8615F')  and MODEL = '"+model_group.elementAt(mn).toString()+"' and FINISH= '"+finish_group.elementAt(mn).toString()+"' and  actuator= '"+actuatorGroup.elementAt(mn).toString()+"' and sskp_code= '"+sskp_code_group.elementAt(mn).toString()+"')";
                    queryx=queryx.replaceAll("= ''"," is null");
                    ResultSet rsLoose = stmt.executeQuery( queryx);
                    if(rsLoose != null){
                        while(rsLoose.next()){
                          looseBlades=looseBlades+rsLoose.getString(1)+",";
                        }
                    }
                    rsLoose.close();
                    
					if ((n%2)==1){bgcolor="#EFEFDE";}else {bgcolor="#e4e4e4";}
					
					if(bcount==0){
						out.println("<table width='100%' class='table_thin_borders' cellspacing='0' cellpadding='0' border='1'>");
						
						boolean isGen=false;
						Vector f1=new Vector();
						Vector f2=new Vector();
						Vector f3=new Vector();
						Vector f4=new Vector();
						Vector f5=new Vector();
						Vector f6=new Vector();
							
						for (int v=0;v<k;v++){
							if(line_product_id.elementAt(v).toString().equals("GEN")&&line_no.elementAt(v).toString().equals(item_all.elementAt(n).toString())&&block_id.elementAt(v).toString().equals("A_APRODUCT")){
								isGen=true;
								ResultSet rsGen=stmt.executeQuery("select feature1,feature2,feature3,feature4,feature5,feature6 from cs_gen_data where order_no='"+order_no+"' and line_no ='"+line_no.elementAt(v).toString()+"' order by sequence_no");
								if(rsGen != null){
									while(rsGen.next()){
										f1.addElement(rsGen.getString(1));
										f2.addElement(rsGen.getString(2));
										f3.addElement(rsGen.getString(3));
										f4.addElement(rsGen.getString(4));
										f5.addElement(rsGen.getString(5));
										f6.addElement(rsGen.getString(6));
									}
								}
								rsGen.close();
							}
								
							if ((line_no.elementAt(v).toString()).equals((item_all.elementAt(n).toString()))){
								if ((block_id.elementAt(v).toString()).equals("A_PRICING")&&desc.elementAt(v)!= null&&desc.elementAt(v).toString().trim().length()>0){
									String tempDescript=desc.elementAt(v).toString();
	
									tempmodel=field18.elementAt(v).toString();
									int start1=tempDescript.indexOf(",");

									int start2=tempDescript.indexOf(".",start1+1);
									start1=tempDescript.indexOf(",",start1+1);
									if(start2 >0 && start2<start1){
										start1=start2;
									}

                                    if(pidCsCosting.elementAt(n).toString().equals("SUN")){  
                                        int starts=tempDescript.indexOf(".");
                                        if(starts>0){
                                            tempDescript="<B>"+tempDescript.substring(0,starts)+"</b>"+tempDescript.substring(starts);
                                        }
                                    }
                                    else{
                                        if(start1>0){
                                                tempDescript="<B>"+tempDescript.substring(0,start1)+"</b>"+tempDescript.substring(start1+1);
                                        }                                                                           
                                    }
									out.println("<tr width='100%'><td colspan='7' class='mainbody'>"+tempDescript+""+looseBlades+"</td></tr>");
								}
								else if (!pidCsCosting.elementAt(n).toString().equals("GRILLE")&&(block_id.elementAt(v).toString()).equals("D_NOTES")){
                                  	out.println("<tr width='100%'><td colspan='7' class='mainbody'>"+desc.elementAt(v).toString()+"</td></tr>");
                                }
                                else if ((block_id.elementAt(v).toString()).equals("A_APRODUCT")){
									if(desc.elementAt(v).toString().indexOf("MODULAR")>=0){
										isMod=true;
									}
									if(desc.elementAt(v).toString().indexOf("MYR")>=0){
										isMyr=true;
									}
								}
								
								if ((block_id.elementAt(v).toString()).equals("E_DIM")){
									String dim=(desc.elementAt(v)).toString();
									if(field20.elementAt(v)==null){
										shape="";
									}
									else{
										shape=(field20.elementAt(v)).toString();
									}
									int n_s=dim.indexOf("@");
									int n_s1=dim.indexOf("@",n_s+1);
									int n_s2=dim.indexOf("@",n_s1+1);
									int n_s3=dim.indexOf("@",n_s2+1);
									int n_s4=dim.indexOf("@",n_s3+1);
									blank_off=dim.substring(n_s2+1,n_s3);
									sills=dim.substring(n_s3+1,n_s4);
									snap_ons=dim.substring(n_s4+1,dim.length());
									if(isMod || isMyr){
										String tempdesc=desc.elementAt(v).toString().substring(desc.elementAt(v).toString().indexOf("@")+1);
											
										tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@"));
										tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
										tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);

										tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
										tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
										tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);

										cellsize=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
										tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
										grilldepth=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
										tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
										thickness=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
										tempdesc=tempdesc.substring(tempdesc.toString().indexOf("@")+1);
										angle=tempdesc.substring(0,tempdesc.toString().indexOf("@"));
									}
								}
								if(numMullions.elementAt(v)!= null){
									numMullionsTemp=numMullions.elementAt(v).toString();
								}
								if(secWide.elementAt(v)!=null && secHigh.elementAt(v)!=null){
									secSize=secWide.elementAt(v).toString()+" x "+secHigh.elementAt(v).toString();
								}
							}
						}
						
						String finish_desc="";String screen_desc="";
						ResultSet rs_csfinish = stmt.executeQuery("select description from cs_finish where code='"+finish.elementAt(n).toString()+"'");
						if (rs_csfinish !=null) {
						   while (rs_csfinish.next()) {
								finish_desc= rs_csfinish.getString("description");
							}
						}
						rs_csfinish.close();
								
						String tempScreen=screen.elementAt(n).toString();
					
						if(tempScreen.indexOf("&")>0){
							ResultSet rs_csscreen1 = stmt.executeQuery("select description from cs_screen where code='"+tempScreen.substring(0,tempScreen.indexOf("&"))+"'");
							if (rs_csscreen1 !=null) {
								while (rs_csscreen1.next()) {
									screen_desc= rs_csscreen1.getString("description")+"&nbsp;";
								}
							}
							rs_csscreen1.close();
							tempScreen=tempScreen.substring(tempScreen.indexOf("&"));
							
							tempScreen=tempScreen.replaceAll("&","','");
							ResultSet rs_csscreen = stmt.executeQuery("select description from cs_screen where code in('"+tempScreen+"')");
							if (rs_csscreen !=null) {
								while (rs_csscreen.next()) {
									if(screen_desc.trim().length()>0){
										screen_desc=screen_desc+ rs_csscreen.getString("description").replaceAll("SCREEN:","")+"&nbsp;";
									}
									else{
										screen_desc=screen_desc+ rs_csscreen.getString("description")+"&nbsp;";
									}
								}
							}
							rs_csscreen.close();
						}
						else{
							ResultSet rs_csscreen = stmt.executeQuery("select description from cs_screen where code='"+tempScreen+"'");
							if (rs_csscreen !=null) {
								while (rs_csscreen.next()) {
									screen_desc= rs_csscreen.getString("description");
								}
							}
							rs_csscreen.close();
						}

						finish_desc=finish_desc.replaceAll("FINISH","<B>FINISH</b>");
						screen_desc=screen_desc.replaceAll("SCREEN","<B>SCREEN</b>");
						out.println("<tr width='100%'><td colspan='9' class='mainbody'>"+screen_desc+"</td></tr>");
						out.println("<tr width='100%'><td colspan='9' class='mainbody'>"+finish_desc+"</td></tr>");
								
						out.println("<tr valign='top'>");
						out.println("<td width='5%' bgcolor='#006600' class='schedule' align='center'><b><u>Mark</u></b></td>");
						out.println("<td width='5%' bgcolor='#006600' class='schedule' align='center'><b><u>Qty</u></b></td>");
						out.println("<td width='9%' bgcolor='#006600' class='schedule' align='center'><b><u>Width x Height</u></b></td>");
						
						Vector a1=new Vector();String a3="";Vector optName=new Vector();Vector optDesc=new Vector();
								
						if(isMod || isMyr){
							out.println("<td width='9%' bgcolor='#006600' class='schedule' align='center'><b><u>Cell Size</u></b></td>");
							out.println("<td width='9%' bgcolor='#006600' class='schedule' align='center'><b><u>Grille Depth</u></b></td>");
							out.println("<td width='9%' bgcolor='#006600' class='schedule' align='center'><b><u>Thickness</u></b></td>");
							out.println("<td width='9%' bgcolor='#006600' class='schedule' align='center'><b><u>Angle</u></b></td>");
							out.println("</tr>");
						}
						else if(isGen){
							out.println("<td width='9%' bgcolor='#006600' class='schedule' align='center'><b><u>Sections</u></b></td>");
							out.println("<td width='9%' bgcolor='#006600' class='schedule' align='center'><b><u>Corners</u></b></td>");
							out.println("</tr>");
						}
						else{
							if(!isGen){
								String schedule="";
								if(sch.elementAt(n).toString() != null){
									schedule=sch.elementAt(n).toString();
								}
								else{
									schedule="0000";
								}
								if(schedule.trim().length()>=4){
									for(int a2=0; a2<4; a2++){
										a1.addElement(schedule.substring(a2,a2+1));
									}
								}
								if(schedule.length()>4){
									a3=schedule.substring(4);
								}
										
								for(int a4=0; a4<a1.size(); a4++){
									ResultSet rsSch=stmt.executeQuery("Select opt_name,opt_desc from cs_sch_opts where opt_index='"+(a4+1)+"' and opt_code='"+a1.elementAt(a4).toString()+"' and prod_id='GRILLE'");
											
									if(rsSch != null){
										int test=0;
										while(rsSch.next()){
											test++;
											
											if(rsSch.getString(1) != null){
												optName.addElement(rsSch.getString(1));
											}
											else{
												optName.addElement("");
											}
											if(rsSch.getString(2) != null){
												optDesc.addElement(rsSch.getString(2));
											}
											else{
												optDesc.addElement("");
											}
										}
										if(test==0){
											optName.addElement("");
											optDesc.addElement("");
										}
									}
									else{
										optName.addElement("");
										optDesc.addElement("");
									}
											
									rsSch.close();
								}
								out.println("<td width='9%' bgcolor='#006600' class='schedule' align='center'><b><u>"+optName.elementAt(0).toString()+"</u></b></td>");
								out.println("<td width='9%' bgcolor='#006600' class='schedule' align='center'><b><u>"+optName.elementAt(3).toString()+"</u></b></td>");
								out.println("<td width='9%' bgcolor='#006600' class='schedule' align='center'><b><u>"+optName.elementAt(1).toString()+"</u></b></td>");
								out.println("<td width='9%' bgcolor='#006600' class='schedule' align='center'><b><u>"+optName.elementAt(2).toString()+"</u></b></td>");
							}
						}
						out.println("</tr>");
						if(!isGen){
							out.println("<tr>");
							out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'  align='center'>"+mark.elementAt(n).toString()+"</td>");
							out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+for12.format(new Double(qty.elementAt(n).toString()).doubleValue())+"</td>");
							out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+width.elementAt(n).toString()+"' x "+height.elementAt(n).toString()+"'</td>");
							
							if(blank_off.trim().length()<=0){blank_off="NONE";}
							if(sills.trim().length()<=0){sills="NONE";}
							if(snap_ons.trim().length()<=0){snap_ons="NONE";}
								
							if(!isGen){
								if(isMod || isMyr){
									out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+cellsize+"</td>");
									out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+grilldepth+"</td>");
									out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+thickness+"</td>");
									out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+angle+" degrees</td>");
								}
								else{
									out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+optDesc.elementAt(0).toString()+"</td>");
									out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+a3.toString()+"</td>");
									out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+optDesc.elementAt(1).toString()+"</td>");
									out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+optDesc.elementAt(2).toString()+"</td>");
								}
							}
							out.println("</tr>");
						}
						else{
							for(int genLine=0; genLine<f1.size(); genLine++){
								String tempF1="";
								String tempF2="";
								String tempF3="";
								String tempF4="";
								String tempF5="";
								String tempF6="";
								
								if(f1.elementAt(genLine).toString()!=null){
									tempF1=f1.elementAt(genLine).toString();
								}
								if(f2.elementAt(genLine).toString()!=null){
									tempF2=f2.elementAt(genLine).toString();
								}
								if(f3.elementAt(genLine).toString()!=null){
									tempF3=f3.elementAt(genLine).toString();
								}
								if(f4.elementAt(genLine).toString()!=null){
									tempF4=f4.elementAt(genLine).toString();
								}
								if(f5.elementAt(genLine).toString()!=null){
									tempF5=f5.elementAt(genLine).toString();
								}
								if(f6.elementAt(genLine).toString()!=null){
									tempF6=f6.elementAt(genLine).toString();
								}
								
								out.println("<tr>");
								out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+tempF1+"</td>");
								out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+tempF2+"</td>");
								out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+tempF3+"' x "+tempF4+"'</td>");
								out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+tempF5+"</td>");
								out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+tempF6+"</td>");
								out.println("</tr>");
							}
						}
						bcount++;finish_desc="";screen_desc="";
					}
					else{
							for (int v=0;v<k;v++){
								if ((line_no.elementAt(v).toString()).equals((item_all.elementAt(n).toString()))){
									if ((block_id.elementAt(v).toString()).equals("E_DIM")){
										String dim=(desc.elementAt(v)).toString();
										if(field20.elementAt(v)==null){
											shape="";
										}
										else{
											shape=(field20.elementAt(v)).toString();
										}
										int n_s=dim.indexOf("@");
										int n_s1=dim.indexOf("@",n_s+1);
										int n_s2=dim.indexOf("@",n_s1+1);
										int n_s3=dim.indexOf("@",n_s2+1);
										int n_s4=dim.indexOf("@",n_s3+1);
										blank_off=dim.substring(n_s2+1,n_s3);
										sills=dim.substring(n_s3+1,n_s4);
										snap_ons=dim.substring(n_s4+1,dim.length());
									}
								}
							}
							
							if(blank_off.trim().length()<=0){blank_off="NONE";}
							if(sills.trim().length()<=0){sills="NONE";}
							if(snap_ons.trim().length()<=0){snap_ons="NONE";}
							String sysdepth="0";
							
							for(int aa=0; aa<configString.size(); aa++){
								if(item_all.elementAt(n).toString().equals(configLineNo.elementAt(aa).toString())){
									int starta=configString.elementAt(aa).toString().indexOf("SYSDEPTH[");
									int enda=0;
									if(starta>0){
										starta=starta+9;
										enda=starta+configString.elementAt(aa).toString().substring(starta).indexOf("]");
										if(enda>0){
											sysdepth=configString.elementAt(aa).toString().substring(starta,enda);
										}
									}
								}
							}
									
							for (int v=0;v<k;v++){
								if ((line_no.elementAt(v).toString()).equals(item_all.elementAt(n).toString())){
									if(numMullions.elementAt(v)!= null){
										numMullionsTemp=numMullions.elementAt(v).toString();
									}
									if(secWide.elementAt(v)!=null && secHigh.elementAt(v)!=null){
										secSize=secWide.elementAt(v).toString()+" x "+secHigh.elementAt(v).toString();
									}
								}
							}
									
							if(pidCsCosting.elementAt(n).toString().equals("LVR")){
								out.println("<tr>");
								out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+mark.elementAt(n).toString()+"</td>");
								out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+for12.format(new Double(qty.elementAt(n).toString()).doubleValue())+"</td>");
								out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+width.elementAt(n).toString()+" x "+height.elementAt(n).toString()+"</td>");
								out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+numMullionsTemp+"</td>");
								out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+secSize+"</td>");
								out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+shape+"</td>");
								out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+new Double(sysdepth).doubleValue()+"&#34;</td>");
								out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+blank_off+"</td>");
								out.println("<td valign='top' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+sills+"</td>");
								out.println("</tr>");
							}
							else{
								Vector a1=new Vector();String a3="";Vector optName=new Vector();Vector optDesc=new Vector();
								
								if(!isGen){
									String schedule="";
									if(sch.elementAt(n).toString() != null){
										schedule=sch.elementAt(n).toString();
									}
									else{
										schedule="0000";
									}
									
									if(schedule.trim().length()>=4){
										for(int a2=0; a2<4; a2++){
											a1.addElement(schedule.substring(a2,a2+1));
										}
									}
								
									if(schedule.length()>4){
										a3=schedule.substring(4);
									}
											
									for(int a4=0; a4<a1.size(); a4++){
										ResultSet rsSch=stmt.executeQuery("Select opt_name,opt_desc from cs_sch_opts where opt_index='"+(a4+1)+"' and opt_code='"+a1.elementAt(a4).toString()+"' and prod_id='GRILLE'");
												
										if(rsSch != null){
											int test=0;
											
											while(rsSch.next()){
												test++;
												
												if(rsSch.getString(1) != null){
													optName.addElement(rsSch.getString(1));
												}
												else{
													optName.addElement("");
												}
												
												if(rsSch.getString(2) != null){
													optDesc.addElement(rsSch.getString(2));
												}
												else{
													optDesc.addElement("");
												}
											}
											
											if(test==0){
												optName.addElement("");
												optDesc.addElement("");
											}
										}
										else{
											optName.addElement("");
											optDesc.addElement("");
										}
												
										rsSch.close();
									}
											
									out.println("<tr>");
									out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'  align='center'>"+mark.elementAt(n).toString()+"</td>");
									out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+for12.format(new Double(qty.elementAt(n).toString()).doubleValue())+"</td>");
									out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+width.elementAt(n).toString()+"' x "+height.elementAt(n).toString()+"'</td>");
									if(blank_off.trim().length()<=0){blank_off="NONE";}
									if(sills.trim().length()<=0){sills="NONE";}
									if(snap_ons.trim().length()<=0){snap_ons="NONE";}
									
									if(isMod || isMyr){
										out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+cellsize+"</td>");
										out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+grilldepth+"</td>");
										out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+thickness+"</td>");
										out.println("<td valign='top' nowrap width='5%' bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+angle+" degrees</td>");
									}
									else{
										out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+optDesc.elementAt(0).toString()+"</td>");
										out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+a3.toString()+"</td>");
										out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+optDesc.elementAt(1).toString()+"</td>");
										out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+optDesc.elementAt(2).toString()+"</td>");
									}
									out.println("</tr>");
								}
								else{
									for(int genLine=0; genLine<f1.size(); genLine++){
										String tempF1="";
										String tempF2="";
										String tempF3="";
										String tempF4="";
										String tempF5="";
										String tempF6="";
										
										if(f1.elementAt(genLine).toString()!=null){
											tempF1=f1.elementAt(genLine).toString();
										}
										if(f2.elementAt(genLine).toString()!=null){
											tempF2=f2.elementAt(genLine).toString();
										}
										if(f3.elementAt(genLine).toString()!=null){
											tempF3=f3.elementAt(genLine).toString();
										}
										if(f4.elementAt(genLine).toString()!=null){
											tempF4=f4.elementAt(genLine).toString();
										}
										if(f5.elementAt(genLine).toString()!=null){
											tempF5=f5.elementAt(genLine).toString();
										}
										if(f6.elementAt(genLine).toString()!=null){
											tempF6=f6.elementAt(genLine).toString();
										}
										out.println("<tr>");
										out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+tempF1+"</td>");
										out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+tempF2+"</td>");
										out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+tempF3+"' x "+tempF4+"'</td>");
										out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+tempF5+"</td>");
										out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+tempF6+"</td>");
										out.println("</tr>");
									}
								}
							}
						}
						
						blank_off="";sills="";snap_ons="";
					} //end if
				} //end for
	 			bcount=0;
				
				out.println("</table><br>");
			} //end for
		} //end if
		
%>
