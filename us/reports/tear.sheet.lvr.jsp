<html>
	<head>
		<title>CS GROUP--TEAR SHEET</title>
		<link rel='stylesheet' href='../../css/style.tear.css' type='text/css' />
	</head>
	<body>
		<%
		// Var vect defition CS_TEAR_SHEETS
		Vector item_no=new Vector();Vector ins_style=new Vector();Vector ins_col=new Vector();Vector cat_no=new Vector();
		Vector description=new Vector();Vector part_no=new Vector();Vector qty=new Vector();Vector mark=new Vector();
		Vector location=new Vector();Vector width=new Vector();Vector length=new Vector();Vector finish=new Vector();
		Vector notes=new Vector();Vector model=new Vector();
		int count_line=0;String str_qry1="";String str_qry2="";
		if( pid.equals("1")) {
		//out.println("The page  is "+pid);
		str_qry1="SELECT * FROM CS_TEAR_SHEETS where order_no like '"+order_no+"%' order by cast(item_no as integer)";
		}
		else{
		str_qry1="SELECT * FROM CS_TEAR_SHEETS where order_no like '"+order_no+"%' and item_no='"+line_no+"' order by cast(item_no as integer)";
		}
				ResultSet efs_ts = stmt.executeQuery(str_qry1);
				if (efs_ts !=null) {
			   while (efs_ts.next()) {
				item_no.addElement(efs_ts.getString("item_no"));
				ins_style.addElement(efs_ts.getString("ins_style"));
				ins_col.addElement(efs_ts.getString("ins_col"));
				cat_no.addElement(efs_ts.getString("cat_no"));
				description.addElement(efs_ts.getString("description"));
				part_no.addElement(efs_ts.getString("part_no"));
				qty.addElement(efs_ts.getString("qty"));
				mark.addElement(efs_ts.getString("mark"));
				location.addElement(efs_ts.getString("location"));
				model.addElement(efs_ts.getString("model"));
				width.addElement(efs_ts.getString("width"));
				length.addElement(efs_ts.getString("td_dir"));
				finish.addElement(efs_ts.getString("finish"));
				notes.addElement(efs_ts.getString("notes"));
				count_line++;
									  }
								   }
				efs_ts.close();

		//var's for the group functions
		Vector description_group=new Vector();Vector ins_style_group=new Vector();Vector ins_col_group=new Vector();Vector sum_group=new Vector();
		Vector cat_no_group=new Vector();Vector part_no_group=new Vector();
		int count_group=0;
		// Getting the total lines for each
		if( pid.equals("1")) {
		str_qry2="SELECT description,ins_style,ins_col,cat_no,part_no,count(*) FROM CS_TEAR_SHEETS where order_no ='"+order_no+"' group by description,ins_style,ins_col,cat_no,part_no order by description";
						 }
		else{
		str_qry2="SELECT description,ins_style,ins_col,cat_no,part_no,count(*) FROM CS_TEAR_SHEETS where order_no ='"+order_no+"' and item_no='"+line_no+"' group by description,ins_style,ins_col,cat_no,part_no order by description";
		}
				java.sql.ResultSet myResult1=stmt.executeQuery(str_qry2);
				if (myResult1 !=null){
				while (myResult1.next()){
				description_group.addElement(myResult1.getString("description"));
				ins_style_group.addElement(myResult1.getString("ins_style"));
				ins_col_group.addElement(myResult1.getString("ins_col"));
				cat_no_group.addElement(myResult1.getString("cat_no"));
				part_no_group.addElement(myResult1.getString("part_no"));
				sum_group.addElement(myResult1.getString(6));
				count_group++;
								  }
								}
								myResult1.close();
		//	out.println("The line tot:"+count_line);
		//	out.println("The group tot:"+count_group);
		// Checking the validite
		//
		String pname="";String ploc="";String pcontr="";String pagent="";String pstate="";
		//Getting the data for the project
				java.sql.ResultSet myResultp=stmt.executeQuery("SELECT * FROM cs_project where Order_no ='"+order_no+"' " );
				if (myResultp !=null){
				while (myResultp.next()){
				pname=myResultp.getString("Project_name");
				ploc=myResultp.getString("Job_loc");
				pcontr=myResultp.getString("Cust_loc");
				pstate=myResultp.getString("project_state");
				pagent=myResultp.getString("Creator_id");
								  }
								}
				myResultp.close();
		// Getting current Date
			java.util.Date uDate = new java.util.Date(); // Right now
		//	uDate
			java.sql.Date sDate = new java.sql.Date(uDate.getTime());

		//Getting the data for the project done
		double count_no_page=0.0;
		//
		if (count_line>0){
			    for (int m=0;m<count_group;m++){ //OUTer for loop bEGIN
												count_no_page=0.0;
					for (int n=0;n<count_line;n++){ //inner for loop bEGIN
							if((description_group.elementAt(m).equals(description.elementAt(n)))&(ins_style_group.elementAt(m).equals(ins_style.elementAt(n)))&(ins_col_group.elementAt(m).equals(ins_col.elementAt(n)))){//If loop bEGIN
				 if (count_no_page<=0) {
										count_no_page++;
		%>
		<%@ include file="tear.head.lvr.jsp"%>
		<%@ include file="tear.footer.lvr.jsp"%>
		<%
//		 out.println("The quantity"+new Double(qty.elementAt(n).toString()).intValue());
				    //four line loop
						    out.println("<tr>");
						    out.println("<td align='center' valign='middle' width='5%' class='boxlt'>"+new Double(qty.elementAt(n).toString()).intValue()+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' width='5%' class='boxlt'>"+mark.elementAt(n)+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' width='9%' class='boxltc'>"+location.elementAt(n)+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' width='9%' class='boxlt'>"+model.elementAt(n)+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' nowrap width='8%' class='boxlt'>"+width.elementAt(n)+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' nowrap width='8%' class='boxlt'>"+length.elementAt(n)+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' width='19%' class='boxltc'>"+finish.elementAt(n)+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' width='13%' class='boxltc'>"+notes.elementAt(n)+"&nbsp;</td>");
						    out.println("</tr>");
				    //four line loop end
								 }	// count.no.page
	    else{
						    count_no_page++;
						    if (count_no_page>4){
									    count_no_page=0.0;
					    out.println("</table></td></tr></table> </table></table></table>");
		    out.println("<p class='p1breaker'>&nbsp;</p><table border='1'><table border='1'>");
		%>
		<%@ include file="tear.head.lvr.jsp"%>
		<%@ include file="tear.footer.lvr.jsp"%>
		<%
				    //four line loop
						    out.println("<tr>");
						    out.println("<td align='center' valign='middle' width='5%' class='boxlt'>"+new Double(qty.elementAt(n).toString()).intValue()+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' width='5%' class='boxlt'>"+mark.elementAt(n)+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' width='9%' class='boxltc'>"+location.elementAt(n)+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' width='9%' class='boxlt'>"+model.elementAt(n)+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' width='8%' class='boxlt'>"+width.elementAt(n)+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' width='8%' class='boxlt'>"+length.elementAt(n)+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' width='19%' class='boxltc'>"+finish.elementAt(n)+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' width='13%' class='boxltc'>"+notes.elementAt(n)+"&nbsp;</td>");
						    out.println("</tr>");
				    //four line loop end
				    count_no_page++;
												}
					    else{
						    out.println("<tr>");
						    out.println("<td align='center' valign='middle' width='5%' class='boxlt'>"+new Double(qty.elementAt(n).toString()).intValue()+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' width='5%' class='boxlt'>"+mark.elementAt(n)+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' width='9%' class='boxltc'>"+location.elementAt(n)+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' width='9%' class='boxlt'>"+model.elementAt(n)+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' width='8%' class='boxlt'>"+width.elementAt(n)+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' width='8%' class='boxlt'>"+length.elementAt(n)+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' width='19%' class='boxltc'>"+finish.elementAt(n)+"&nbsp;</td>");
						    out.println("<td align='center' valign='middle' width='13%' class='boxltc'>"+notes.elementAt(n)+"&nbsp;</td>");
						    out.println("</tr>");
						    }
		    }
										 } //If loop end
								    }//Inner for loop END
//out.println("The count"+count_no_page);
						    if((4-count_no_page)>0) {
						    for(int v=0;v<(4-count_no_page);v++){
						    out.println("<tr>");
						    out.println("<td align='center' valign='middle' width='5%' class='boxlt'>"+"&nbsp;"+"</td>");
						    out.println("<td align='center' valign='middle' width='5%' class='boxlt'>"+"&nbsp;"+"</td>");
						    out.println("<td align='center' valign='middle' width='9%' class='boxlt'>"+"&nbsp;"+"</td>");
						    out.println("<td align='center' valign='middle' width='9%' class='boxlt'>"+"&nbsp;"+"</td>");
						    out.println("<td align='center' valign='middle' width='8%' class='boxlt'>"+"&nbsp;"+"</td>");
						    out.println("<td align='center' valign='middle' width='8%' class='boxlt'>"+"&nbsp;"+"</td>");
						    out.println("<td align='center' valign='middle' width='19%' class='boxlt'>"+"&nbsp;"+"</td>");
						    out.println("<td align='center' valign='middle' width='13%' class='boxlt'>"+"&nbsp;"+"</td>");
						    out.println("</tr>");
															    }
										    }
							    out.println("</table></td></tr></table>");
    if ((count_group-m)>1){
		    out.println("</table>");
		    out.println("<p class='p1breaker'>&nbsp;</p>");
		    out.println("<table border='1'>");
						  }
				}//OUTer for loop END

				}// Main If loop  end
else{
out.println("No tear sheets for this order...");
   }

//myConn.commit();
stmt.close();
myConn.close();
		%>
	</body>
</html>








