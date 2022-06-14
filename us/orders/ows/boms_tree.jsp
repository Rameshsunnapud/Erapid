<html>
<HEAD>
<title>BOM/ROU product MAP</title>
<link rel='stylesheet' href='style1.css' type='text/css' />
</HEAD>
<BODY bgcolor="whitesmoke" >
<center>
<%@ page language="java" import="java.sql.*" import="java.text.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="../../../db_con_bpcs_proto.jsp"%>
<%
String prod = request.getParameter("prod_code");
String erapid_quant = request.getParameter("prod_quant");
out.println("<h1>BOM/ROU product tree MAP for "+prod+" with a quantity of "+erapid_quant+"</h1>");
//String prod="4C102";double erapid_quant=100.00;
int count=0;String bgcolor="";
//vectors to save the outputs
Vector no_final=new Vector();Vector parent_part_final=new Vector();Vector child_part_final=new Vector();Vector part_quantity_final=new Vector();
Vector seq_no_final=new Vector();Vector ucode_final=new Vector();Vector child_raw_quantity_final=new Vector();Vector tree_level_final=new Vector();
Vector scrap_final=new Vector();Vector op_no_final=new Vector();Vector override_final=new Vector();
Vector parent_part_final_group=new Vector();
//bills begin
out.println("<table border='0' bordercolor='#e9f2f7' width='95%' cellspacing='0' cellpadding='0' >");
out.println("<tr><td colspan='2' align='left' class='important'><h1>Bill's #</h1></td></tr>");
out.println("<tr>");
out.println("<td width='5%%' class='important'><b>#</b></td>");
out.println("<td width='10%%' class='important'><b>Part no</b></td>");
out.println("<td width='10%%' class='important'><b>Parent part</b></td>");
out.println("<td width='3%%' class='important' align='left'><b>Seq.no</b></td>");
out.println("<td width='3%%' class='important' align='right'><b>U/C<sup>*</sup></b></td>");
out.println("<td width='10%%' class='important' align='right'><b>Quantity</b></td>");
out.println("<td width='5%%' class='important' align='right'><b>Tree level</b></td>");
out.println("<td width='7%%' class='important' align='right'><b>Scrap factor</b></td>");
out.println("<td width='7%%' class='important' align='right'><b>Operation no.</b></td>");
out.println("<td width='7%%' class='important' align='right'><b>Must Issue override.</b></td>");
//out.println("<td width='10%%' class='important' align='right'><b>Raw Quantity</b></td>");
out.println("</tr>");
//
//add this for looking up child parts and changing them 1/27/11
String var="24I989"; String var2="24I989372S";
String var3="24I999"; String var4="24I989373S";
//case when substring(BCHLD,locate('"+var+"',BCHLD),6) = '"+var+"' then '"+var2+"' when substring(BCHLD,locate('"+var3+"',BCHLD),6) = '"+var3+"' then '"+var4+"' else BCHLD END
//case when substring(BCHLD,locate('"+var+"',BCHLD),6) = '"+var+"' then '"+var2+"' else BCHLD END

				try {
				String sql1=" WITH temp_mbm (parent_part,child_part,qty,seq_no, iteration,usc_code,raw_qty,scrap_factor,op_no,override) AS "+
				        "(SELECT BPROD,case when substring(BCHLD,locate('"+var+"',BCHLD),6) = '"+var+"' then '"+var2+"' when substring(BCHLD,locate('"+var3+"',BCHLD),6) = '"+var3+"' then '"+var4+"' else BCHLD END,case when substring(BCHLD,locate('KIT',BCHLD),3) = 'KIT' then BQREQ*"+erapid_quant+" else cast(round(BQREQ*"+erapid_quant+",3) as decimal(10,3)) END ,BSEQ,1,BUSC,cast(BQREQ as decimal(10,3)),BMSCP,BOPNO,BMISS FROM mbm WHERE bprod = '"+prod.trim()+"' and BMWHS='MU' and BMBOMM='' UNION ALL"+
		        		" SELECT temp_mbm.child_part,mbm.BCHLD,cast(round(mbm.BQREQ*temp_mbm.qty,3)as decimal(10,3)),mbm.BSEQ, temp_mbm.iteration+1,mbm.BUSC,cast(mbm.BQREQ as decimal(10,3)),mbm.BMSCP,mbm.BOPNO,mbm.BMISS"+
				       " FROM temp_mbm ,mbm "+
				       "WHERE temp_mbm.child_part = mbm.BPROD and mbm.BMWHS='MU' and mbm.BMBOMM=''"+
				        ") SELECT  * FROM temp_mbm  order by iteration,parent_part,seq_no,child_part";
//					out.println(sql1+"<br><br>");//sql statement
					ResultSet rs1 = stmt_bpcs.executeQuery(sql1);
					while (rs1.next())  {
						count++;
					if ((count%2)==1){bgcolor="#E9F2F7";}else{bgcolor="white";}
					out.println("<tr bgcolor='"+ bgcolor +"'>");
					out.println("<td>"+count+"</td>");	no_final.addElement(count+"");
					out.println("<td align='left'>"+rs1.getString (2)+"</td>");child_part_final.addElement(rs1.getString (2));
					out.println("<td align='left'>"+rs1.getString (1)+"</td>");parent_part_final.addElement(rs1.getString (1));
					out.println("<td align='left'>"+rs1.getString (4)+"</td>");seq_no_final.addElement(rs1.getString (4));
					out.println("<td align='right'>"+rs1.getString (6)+"</td>");ucode_final.addElement(rs1.getString (6));


					if(rs1.getString (6).equals("0")){
						//out.println("I was here0");
						out.println("<td align='right'>"+Math.ceil(Double.valueOf(rs1.getString (7).trim()).doubleValue())+"</td>");part_quantity_final.addElement(new Double( Math.ceil( Double.valueOf(rs1.getString (7).trim()).doubleValue() ) ));
					}
					else{
						if(rs1.getString (2).trim().indexOf("KIT")>=0 & rs1.getString (5).equals("1")){//added to capture kits and not round it....
						//	out.println("I was here 1:: Kit");
							out.println("<td align='right'>"+rs1.getString (3).trim()+"</td>");part_quantity_final.addElement(rs1.getString (3).trim());
						}
						else if(rs1.getString (2).trim().equals("90M014001")|rs1.getString (2).trim().equals("90M055001")){//added to capture gallonaze and not round it
						//	out.println("I was here2:: gallon");
							out.println("<td align='right'>"+rs1.getString (3).trim()+"</td>");part_quantity_final.addElement(rs1.getString (3).trim());
						}
						else if(rs1.getString (2).trim().equals("90M039001")|rs1.getString (2).trim().equals("90M040001")|rs1.getString (2).trim().equals("90M105001")|rs1.getString (2).trim().equals("12M076000")|rs1.getString (2).trim().equals("12M016000")){//added as per Andy to capture and not round them on Dec'12 09
							//	out.println("I was here3:: exclude");
								out.println("<td align='right'>"+rs1.getString (3).trim()+"</td>");part_quantity_final.addElement(rs1.getString (3).trim());
						}
						else{
						out.println("<td align='right'>"+Math.ceil(Double.valueOf(rs1.getString (3).trim()).doubleValue())+"</td>");part_quantity_final.addElement( new Double( Math.ceil( Double.valueOf(rs1.getString (3).trim()).doubleValue() ) ));
						}

						//out.println("I was hereM"+rs1.getString (2));
					}


					out.println("<td align='right'>"+rs1.getString (5)+"</td>");tree_level_final.addElement(rs1.getString (5));
					out.println("<td align='right'>"+rs1.getString (8)+"</td>");scrap_final.addElement(rs1.getString (8));
					out.println("<td align='right'>"+rs1.getString (9)+"</td>");op_no_final.addElement(rs1.getString (9));
					out.println("<td align='right'>"+rs1.getString (10)+"</td>");override_final.addElement(rs1.getString (10));
				//	out.println("<td align='right'>"+rs1.getString (7)+":::"+rs1.getString (3)+"</td>");//raw quantity
					out.println("</tr>");
					}
				rs1.close();
				} catch (SQLException e) {
					out.println("Problem with ENTERING TO MBM table in BPCS"+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					out.println(e.toString());
					return;
				}

	//GOing back for grouping
				String sql2=" WITH temp_mbm1 (parent_part,child_part,qty,seq_no, iteration,usc_code,raw_qty,scrap_factor,op_no,override) AS "+
		        "(SELECT BPROD,case when substring(BCHLD,locate('"+var+"',BCHLD),6) = '"+var+"' then '"+var2+"' when substring(BCHLD,locate('"+var3+"',BCHLD),6) = '"+var3+"' then '"+var4+"' else BCHLD END,cast(round(BQREQ*"+erapid_quant+",3) as decimal(10,3)),BSEQ,1,BUSC,cast(BQREQ as decimal(10,3)),BMSCP,BOPNO,BMISS FROM mbm WHERE bprod = '"+prod.trim()+"' and BMWHS='MU' and BMBOMM='' UNION ALL"+
        		" SELECT temp_mbm1.child_part,mbm.BCHLD,cast(round(mbm.BQREQ*temp_mbm1.qty,3)as decimal(10,3)),mbm.BSEQ, temp_mbm1.iteration+1,mbm.BUSC,cast(mbm.BQREQ as decimal(10,3)),mbm.BMSCP,mbm.BOPNO,mbm.BMISS"+
		       " FROM temp_mbm1 ,mbm "+
		       "WHERE temp_mbm1.child_part = mbm.BPROD and mbm.BMWHS='MU' and mbm.BMBOMM=''"+
		        ") SELECT  parent_part,iteration FROM temp_mbm1  group by parent_part,iteration order by parent_part,iteration";

		//	out.println(sql1+"<br><br>");//sql statement
			ResultSet rs2 = stmt_bpcs.executeQuery(sql2);
			try {
			while (rs2.next())  {
				parent_part_final_group.addElement(rs2.getString (1));
//				out.println("Group"+rs2.getString (1)+"<br>");
			}
			rs2.close();
			} catch (SQLException e) {
				out.println("Problem with ENTERING TO MBM table in BPCS"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				out.println(e.toString());
				return;
			}



			stmt_bpcs.close();//closing Bills

out.println("<tr><td colspan='4' class='important'>&nbsp;</td></tr>");
out.println("<tr><td colspan='4' class='important'>Total parts :: "+count+"</td><td colspan='3' class='important'>*--Component Usuage Code</td></tr>");
out.println("<tr><td colspan='4' class='important'>&nbsp;</td></tr>");
out.println("</table>");
//bills end
//routings begin
out.println("<table border='0' bordercolor='#e9f2f7' width='95%' cellspacing='0' cellpadding='0' >");
out.println("<tr><td colspan='2' align='left' class='important'><h1>Routing's #</h1></td></tr>");
out.println("<tr>");
out.println("<td width='2%%' class='important'><b>#</b></td>");
out.println("<td width='12%%' class='important'><b>Part no</b></td>");
out.println("<td width='3%%' class='important'><b>Op. no</b></td>");
out.println("<td width='5%%' class='important' align='left'><b>Work ctr no</b></td>");
out.println("<td width='10%%' class='important' align='LEFT'><b>Op.description</sup></b></td>");
out.println("<td width='5%%' class='important' align='left'><b>Basis code</b></td>");
out.println("<td width='6%%' class='important' align='left'><b>Run lab hrs</b></td>");
out.println("<td width='6%%' class='important' align='left'><b>Setup lab hrs</b></td>");
out.println("<td width='5%%' class='important' align='left'><b>Machine hrs</b></td>");
out.println("<td width='5%%' class='important' align='left'><b>No of Operators</b></td>");
out.println("<td width='5%%' class='important' align='left'><b>Std.move time</b></td>");
out.println("<td width='5%%' class='important' align='left'><b>Std.queue time</b></td>");
out.println("<td width='5%%' class='important' align='left'><b>Std Op.yield</b></td>");
out.println("<td width='5%%' class='important' align='left'><b>Inside/Outside flag</b></td>");
out.println("<td width='5%%' class='important' align='left'><b>Setup basis code</b></td>");
out.println("<td width='5%%' class='important' align='left'><b>Collect date</b></td>");
out.println("<td width='5%%' class='important' align='left'><b>Outside cost</b></td>");


out.println("</tr>");
count=0;
java.sql.PreparedStatement query_routing=null;
ResultSet rs = null;

for(int i=0;i<parent_part_final_group.size();i++){
	//getting the parent routings also	//
//	if(seq_no_final.elementAt(i).equals("1")){
		try{
		query_routing = con_bpcs.prepareStatement("SELECT * FROM FRT where RPROD = ? and RTWHS='MU' and RID='RT' and RTRTEM='' order by ROPNO,RSTAT,RWRKC,RPROD");
		query_routing.setString(1,parent_part_final_group.elementAt(i).toString().trim());
		rs = query_routing.executeQuery();
			while (rs.next()) {
			count++;
			if ((count%2)==1){bgcolor="#E9F2F7";}else{bgcolor="white";}
			out.println("<tr bgcolor='"+ bgcolor +"'>");
			out.println("<td>"+count+"</td>");
			out.println("<td>"+parent_part_final_group.elementAt(i).toString().trim()+"</td>");
			out.println("<td>"+rs.getString("ROPNO")+"</td>");//op.no
			out.println("<td>"+rs.getString("RWRKC")+"</td>");//work ctr.no
			out.println("<td>"+rs.getString("ROPDS")+"</td>");//op.desc
			out.println("<td>"+rs.getString("RBAS")+"</td>");//basis code
			out.println("<td>"+rs.getString("RLAB")+"</td>");//RUN LAB HRS
			out.println("<td>"+rs.getString("RSET")+"</td>");//SETUP LAB HRS
			out.println("<td>"+rs.getString("RMAC")+"</td>");//Machine hrs
			out.println("<td>"+rs.getString("ROPER")+"</td>");//no of operators
			out.println("<td>"+rs.getString("RMOVE")+"</td>");//std.move time
			out.println("<td>"+rs.getString("RQUE")+"</td>");//std.que time
			out.println("<td>"+rs.getString("RSTYD")+"</td>");//std.op.yield
			out.println("<td>"+rs.getString("RTOFLG")+"</td>");//in.outside flag
			out.println("<td>"+rs.getString("RSBAS")+"</td>");//SETUP BASIS CODE
			out.println("<td>"+rs.getString("RCOLD")+"</td>");//COLLECT DATE THIS OPERATION.
			out.println("<td>"+rs.getString("RTOUTC")+"</td>");//OUTSIDE COST
			out.println("</tr>");
			}
	  }
	   catch (java.sql.SQLException e){
		out.println("Problem with ENTERING TO FRT table in BPCS the last time"+"<br>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		//myConn.rollback();
		out.println(e.toString());
		return;
	  }
//  }//checking for seq 1
}//for
//database closing
//rs.close();
rs.close();
query_routing.close();
//stmt_bpcs.close();
con_bpcs.close();
out.println("<tr><td colspan='4' class='important'>&nbsp;</td></tr>");
out.println("<tr><td colspan='4' class='important'>Total Operations :: "+count+"</td></tr>");
out.println("<tr><td colspan='4' class='important'>&nbsp;</td></tr>");
//final_quant=(new Double(rs.getString(7)).doubleValue()*new Double(erapid_quant).doubleValue());
//part_quantity1.addElement(Double.toString(final_quant));
//adding integer values to a vector
//vctr.addElement(new Integer(5));To get the value back, you would have to use the line:
// int something = ((Integer) vctr.get(index)).intValue();


 %>
 </table>
 </center>
</body>
</html>
