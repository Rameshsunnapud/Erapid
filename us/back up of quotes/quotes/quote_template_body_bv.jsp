
<% 
NumberFormat for12 = NumberFormat.getInstance(); 
for12.setMaximumFractionDigits(1);

int k=0;String bgcolor="";Vector mark=new Vector();Vector desc=new Vector();Vector qty=new Vector();Vector rec_no=new Vector();int bcount=0;
Vector line_no=new Vector();Vector block_id=new Vector();Vector width=new Vector();Vector height=new Vector();Vector screen=new Vector();Vector finish=new Vector();
Vector model=new Vector();Vector model_group=new Vector();Vector screen_group=new Vector();Vector finish_group=new Vector();Vector group_count=new Vector();Vector item_all=new Vector();
 	ResultSet rs_csquotes = stmt.executeQuery("select * from csquotes where order_no='"+order_no+"' order by cast(Line_no as integer)");
  		if (rs_csquotes !=null) {
	        while (rs_csquotes.next()) {
			line_no.addElement(rs_csquotes.getString("Line_no"));
			desc.addElement(rs_csquotes.getString("Descript"));
			block_id.addElement(rs_csquotes.getString("block_id"));
			rec_no.addElement(rs_csquotes.getString("Record_no"));
			k++;
			}
		}
		rs_csquotes.close();
int t_costing=0;
 	ResultSet rs_cscosting = stmt.executeQuery("select * from cs_costing where order_no='"+order_no+"' order by cast(item_no as integer)");
  		if (rs_cscosting !=null) {
	        while (rs_cscosting.next()) {
			item_all.addElement(rs_cscosting.getString("item_no"));
			model.addElement(rs_cscosting.getString("model"));
			width.addElement(rs_cscosting.getString("width"));
			height.addElement(rs_cscosting.getString("height"));
			finish.addElement(rs_cscosting.getString("finish"));
			screen.addElement(rs_cscosting.getString("screen"));
			qty.addElement(rs_cscosting.getString("qty"));
			mark.addElement(rs_cscosting.getString("mark"));
			t_costing++;
			}
		}
		rs_cscosting.close();
int t_group=0;
 	ResultSet rs_cscosting_group = stmt.executeQuery("SELECT MODEL,FINISH,SCREEN,COUNT(*)as v from cs_costing where order_no='"+order_no+"' GROUP BY MODEL,FINISH,SCREEN");
//	SELECT MODEL,FINISH,SCREEN,COUNT(*) FROM "DBA"."CS_COSTING" where order_no='003894_00' GROUP BY MODEL,FINISH,SCREEN
  		if (rs_cscosting_group !=null) {
	        while (rs_cscosting_group.next()) {
			model_group.addElement(rs_cscosting_group.getString("model"));
			finish_group.addElement(rs_cscosting_group.getString("finish"));			
			screen_group.addElement(rs_cscosting_group.getString("screen"));
			group_count.addElement(rs_cscosting_group.getString("v"));						
			t_group++;
			}
		}
		rs_cscosting_group.close();
//out.println("the total"+t_group+"tHE Normal"+t_costing);
String blank_off="";String sills="";String snap_ons="";
if (t_group>0){
		for(int mn=0;mn<t_group;mn++){
			for (int n=0;n<t_costing;n++){
					if((model_group.elementAt(mn).toString().equals(model.elementAt(n).toString()))&(finish_group.elementAt(mn).toString().equals(finish.elementAt(n).toString()))&(screen_group.elementAt(mn).toString().equals(screen.elementAt(n).toString()))){
							if ((bcount%2)==1){bgcolor="#EFEFDE";}else {bgcolor="#e4e4e4";}
							if(bcount==0){
								out.println("<table width='100%' class='table_thin_borders' cellspacing='0' cellpadding='0' border='1'>");
								for (int v=0;v<k;v++){
									if ((line_no.elementAt(v).toString()).equals((item_all.elementAt(n).toString()))){
										if ((block_id.elementAt(v).toString()).equals("A_PRICING")){
										out.println("<tr width='100%'><td colspan='6' class='mainbody'>"+desc.elementAt(v).toString()+"</td></tr>");
										}
										if ((block_id.elementAt(v).toString()).equals("E_DIM")){
											String dim=(desc.elementAt(v)).toString();
										   	int n_s=dim.indexOf("@");
											int n_s1=dim.indexOf("@",n_s+1);
											int n_s2=dim.indexOf("@",n_s1+1);
											int n_s3=dim.indexOf("@",n_s2+1);
										    int n_s4=dim.indexOf("@",n_s3+1);
//											blank_off=dim.substring(0,n_s);
//											blank_off=dim.substring(n_s+1,n_s1);
//											logo=dim.substring(n_s1+1,n_s2);
											blank_off=dim.substring(n_s2+1,n_s3);
											sills=dim.substring(n_s3+1,n_s4);
											snap_ons=dim.substring(n_s4+1,dim.length());
										}
									}
								}
							//GETTING THE FINISH AND THE SIZE FROM THE TABLES
							String finish_desc="";String screen_desc="";							
						 	ResultSet rs_csfinish = stmt.executeQuery("select description from cs_finish where code='"+finish.elementAt(n).toString()+"'");
					  		if (rs_csfinish !=null) {
						        while (rs_csfinish.next()) {
								finish_desc= rs_csfinish.getString("description");
								}
							}
							rs_csfinish.close();
						 	ResultSet rs_csscreen = stmt.executeQuery("select description from cs_screen where code='"+screen.elementAt(n).toString()+"'");
					  		if (rs_csscreen !=null) {
						        while (rs_csscreen.next()) {
								screen_desc= rs_csscreen.getString("description");
								}
							}
							rs_csscreen.close();
//							out.println("<tr width='100%'><td colspan='6' class='mainbody'>"+screen_desc+"</td></tr>");							
							out.println("<tr width='100%'><td colspan='6' class='mainbody'>"+finish_desc+"</td></tr>");	
							out.println("<tr height='20'>");
							out.println("<td width='5%' bgcolor='#006600' class='schedule'><b><u>Mark</u></b></td>");
							out.println("<td width='5%' bgcolor='#006600' class='schedule'><b><u>Qty</u></b></td>");
							out.println("<td width=9%' bgcolor='#006600' class='schedule'><b><u>Size</u></b></td>");
//							out.println("<td width=9%' bgcolor='#006600' class='schedule'><b><u>Blank Off</u></b></td>");
//							out.println("<td width=9%' bgcolor='#006600' class='schedule'><b><u>Sills</u></b></td>");
//							out.println("<td width=9%' bgcolor='#006600' class='schedule'><b><u>Snap on Closure</u></b></td>");							
							out.println("</tr>");
							out.println("<tr>");
							out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+mark.elementAt(n).toString()+"</td>");
							out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+for12.format(new Double(qty.elementAt(n).toString()).doubleValue())+"</td>");
							out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+width.elementAt(n).toString()+" x "+height.elementAt(n).toString()+"</td>");
							if(blank_off.trim().length()<=0){blank_off="NONE";}
							if(sills.trim().length()<=0){sills="NONE";}
							if(snap_ons.trim().length()<=0){snap_ons="NONE";}
//							out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+blank_off+"</td>");							
//							out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+sills+"</td>");
//							out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+snap_ons+"</td>");														
							out.println("</tr>");
							bcount++;finish_desc="";screen_desc="";rs_csscreen.close();rs_csfinish.close();							
							}
							else{
						
								for (int v=0;v<k;v++){
									if ((line_no.elementAt(v).toString()).equals((item_all.elementAt(n).toString()))){
										if ((block_id.elementAt(v).toString()).equals("E_DIM")){
											String dim=(desc.elementAt(v)).toString();
										   	int n_s=dim.indexOf("@");
											int n_s1=dim.indexOf("@",n_s+1);
											int n_s2=dim.indexOf("@",n_s1+1);
											int n_s3=dim.indexOf("@",n_s2+1);
										    int n_s4=dim.indexOf("@",n_s3+1);
//											blank_off=dim.substring(0,n_s);
//											blank_off=dim.substring(n_s+1,n_s1);
//											logo=dim.substring(n_s1+1,n_s2);
											blank_off=dim.substring(n_s2+1,n_s3);
											sills=dim.substring(n_s3+1,n_s4);
											snap_ons=dim.substring(n_s4+1,dim.length());
										}
								   }
								}
							
							out.println("<tr>");
							out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+mark.elementAt(n).toString()+"</td>");
							out.println("<td valign='top' nowrap width='5%'bgcolor='"+bgcolor+"' class='maindesc'>"+for12.format(new Double(qty.elementAt(n).toString()).doubleValue())+"</td>");
							out.println("<td valign='top' nowrap width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+width.elementAt(n).toString()+" x "+height.elementAt(n).toString()+"</td>");
//							out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+blank_off+"</td>");							
//							out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+sills+"</td>");
//							out.println("<td valign='top' width='5%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+snap_ons+"</td>");							
							out.println("</tr>");
							}
						  blank_off="";sills="";snap_ons="";	 
						}
		    }
		 bcount=0;
		out.println("<tr><td>"+"&nbsp;"+"</td></tr>");		 
		out.println("</table>");
	     }
}
//							if ((block_id.elementAt(n).toString()).equals("A_PRICING")){
//							if(bcount==0){out.println(desc.elementAt(n).toString()+"<br>");}
%>	
