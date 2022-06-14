<script language="JavaScript" >
function doThis(){
	var x=1;
	if(document.form1.order_no.length != undefined){
		x=document.form1.order_no.length
	}
	for(var i=0; i<x; i++){
		alert(document.form1.order_no[i].value+"::"+document.form1.notes[i].value);
	}
}
</script>
<HTML>
<HEAD>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<TITLE>Recap Notes</TITLE>
<link rel='stylesheet' href='style1.css' type='text/css' />
</HEAD>
<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.io.*" errorPage="error.jsp" %>
<%@ include file="db_con.jsp"%>
<%
String[] order_no=request.getParameterValues("order_no");
String[] notes=request.getParameterValues("notes");
String[] notes2=request.getParameterValues("notes2");
String line_no=request.getParameter("line_no");
String record_nox="";
String pid="";
ResultSet rspid=stmt.executeQuery("select product_id from cs_project where order_no='"+order_no[0]+"'");
if(rspid != null){
	while(rspid.next()){
		pid=rspid.getString(1);
	}
}
rspid.close();

ResultSet rsrecno=stmt.executeQuery("SELECT DISTINCT CAST(Record_no AS numeric) AS Expr1 FROM CSQUOTES WHERE     (Product_ID = '"+pid+"') AND (Block_ID = 'd_notes') and sequence_no='41'ORDER BY CAST(Record_no AS numeric)");
if(rsrecno != null){
	while(rsrecno.next()){
		record_nox=rsrecno.getString(1);
	}
}
rsrecno.close();
for(int i=0; i<order_no.length; i++){
	String configstring="";
	ResultSet rsconfigstring=stmt.executeQuery("select config_string from doc_line where doc_number='"+order_no[i]+"' and doc_line='"+line_no+"'");
	if(rsconfigstring != null){
		while(rsconfigstring.next()){
			configstring=rsconfigstring.getString(1);
		}
	}
	rsconfigstring.close();
	if(configstring !=null && configstring.trim().length()>0){
		int start=0;
		start=configstring.substring(0,8).indexOf("DRNOTES/");
		if(start<0){
			start=configstring.indexOf("&DRNOTES/");
		}
		int end=0;
		if(start>0){
			end=configstring.substring(start+1).indexOf("&");
			if(end<0){
				end=configstring.length();
			}
			else{
				end=end+start+1;
			}
			String temp=configstring.substring(start,end);
			configstring=configstring.substring(0,start)+configstring.substring(end);
			start=temp.indexOf("NOTE[");
			if(start>0){
				end=temp.substring(start+1).indexOf("]");
				if(notes[i].length()>0){
					temp=temp.substring(0,start+5)+notes[i]+temp.substring(end+start+1);
					configstring=configstring+temp;
				}
				else{
					temp=temp.substring(0,start)+temp.substring(end+start+2);
					temp=temp.replaceAll("/,","/");
					if(temp.indexOf("[")>0){
						configstring=configstring+temp;
					}
				}
			}
			else{
				if(notes[i].length()>0){
					temp=temp+",NOTE["+notes[i]+"]";
				}
				configstring=configstring+temp;
			}
		}
		else{
			if(notes[i].length()>0){
				configstring=configstring+"&DRNOTES/NOTE["+notes[i]+"]";
			}
		}
		try{
			String insert ="update doc_line set config_string=? where doc_number = ? and doc_line=? ";
			PreparedStatement update_insert = myConn.prepareStatement(insert);
	        update_insert.setString(1,configstring);
			update_insert.setString(2,order_no[i]);
			update_insert.setString(3,line_no);
			int rocount = update_insert.executeUpdate();
			update_insert.close();
		}
		catch (java.sql.SQLException e){
			out.println("Problem with update in doc_line TABLEs"+"<br>");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}
		//out.println(configstring+"<BR><BR><BR>");
		if(notes[i] !=null && notes[i].trim().length()>0){
			//out.println(line_no+"::"+order_no[i]+"::"+notes[i]+"::<BR>");
			int count=0;
			ResultSet rs0=stmt.executeQuery("select count(*) from csquotes where order_no = '"+order_no[i]+"' and line_no='"+line_no+"' and block_id='d_notes' and sequence_no='41' ");
			if(rs0 != null){
				while(rs0.next()){
					count=rs0.getInt(1);
				}
			}
			rs0.close();
			//out.println(count+"<BR><BR>");
			if(count>0){
				//update
				try{
					int rs1=stmt.executeUpdate("update csquotes set descript='"+notes[i]+"' where order_no = '"+order_no[i]+"' and line_no='"+line_no+"' and block_id='d_notes' and sequence_no='41'");
				}
				catch (java.sql.SQLException e){
					out.println("Problem with update in csquotes TABLEs"+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					myConn.rollback();
					out.println(e.toString());
					return;
				}
			}
			else{
				String order_type="";
				String product_id="";
				String description="";
				String record_type="";
				String extended_price="";
				String record_no="";
				String block_id="";
				String sequence_no="";
				String uom="";
				String sqmp="";
				String weight="";
				String run_cost="";
				String std_cost="";
				String setup_cost="";
				String price_flag="";
				String lgth="";
				String wdth="";
				String color="";
				String vender_no="";
				String prod_code="";
				String bpcs_gen="";
				String bpcs_tier="";
				String complete="";
				String unit_price_flag="";
				String bpcs_note="";
				//insert
				ResultSet rs1=stmt.executeQuery("select * from csquotes where order_no = '"+order_no[i]+"' and line_no='"+line_no+"' and block_id='a_aproduct'");
				if(rs1 !=null){
					while(rs1.next()){
						order_type=rs1.getString("order_type");
						product_id=rs1.getString("product_id");
						record_type=rs1.getString("record_type");
						uom=rs1.getString("uom");
						sqmp=rs1.getString("sqmp");
						weight=rs1.getString("weight");
						run_cost=rs1.getString("run_cost");
						std_cost=rs1.getString("std_cost");
						setup_cost=rs1.getString("setup_cost");
						price_flag=rs1.getString("price_flag");
						lgth=rs1.getString("lgth");
						wdth=rs1.getString("wdth");
						color=rs1.getString("color");
						vender_no=rs1.getString("vendor_no");
						prod_code=rs1.getString("prod_code");
						bpcs_gen=rs1.getString("bpcs_gen");
						bpcs_tier=rs1.getString("bpcs_tier");
						complete=rs1.getString("complete");
						unit_price_flag=rs1.getString("unit_price_flag");
						record_no=record_nox;
						sequence_no="41";
						block_id="D_NOTES";
						extended_price="0.00";
						description=notes[i];
						bpcs_note=notes[i];
					}

				}
				rs1.close();
				try{
					String insert="insert into csquotes(order_no,line_no,order_type,product_id,descript,record_type,extended_price,record_no,block_id,sequence_no,uom,sqmp,weight,run_cost,std_cost,setup_cost,price_flag,lgth,wdth,color,vendor_no,prod_code,bpcs_gen,bpcs_tier,complete,unit_price_flag,bpcs_note,sqm,qty,field16,field17,field18,field19,field20,stock,bpcs_qty,bpcs_um,fcperc,whse,deduct) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					//out.println(insert);
					PreparedStatement update_csquotes = myConn.prepareStatement(insert);
					update_csquotes.setString(1,order_no[i]);
					update_csquotes.setString(2,line_no);
					update_csquotes.setString(3,order_type);
					update_csquotes.setString(4,pid);
					update_csquotes.setString(5,description);
					update_csquotes.setString(6,record_type);
					update_csquotes.setString(7,extended_price);
					update_csquotes.setString(8,record_no);
					update_csquotes.setString(9,block_id);
					update_csquotes.setString(10,sequence_no);
					update_csquotes.setString(11,uom);
					update_csquotes.setString(12,sqmp);
					update_csquotes.setString(13,weight);
					update_csquotes.setString(14,run_cost);
					update_csquotes.setString(15,std_cost);
					update_csquotes.setString(16,setup_cost);
					update_csquotes.setString(17,price_flag);
					update_csquotes.setString(18,lgth);
					update_csquotes.setString(19,wdth);
					update_csquotes.setString(20,color);
					update_csquotes.setString(21,vender_no);
					update_csquotes.setString(22,prod_code);
					update_csquotes.setString(23,bpcs_gen);
					update_csquotes.setString(24,bpcs_tier);
					update_csquotes.setString(25,complete);
					update_csquotes.setString(26,unit_price_flag);
					update_csquotes.setString(27,bpcs_note);
					update_csquotes.setString(28,"");
					update_csquotes.setString(29,"");
					update_csquotes.setString(30,"");
					update_csquotes.setString(31,"");
					update_csquotes.setString(32,"");
					update_csquotes.setString(33,"");
					update_csquotes.setString(34,"");
					update_csquotes.setString(35,"");
					update_csquotes.setString(36,"");
					update_csquotes.setString(37,"");
					update_csquotes.setString(38,"");
					update_csquotes.setString(39,"");
					update_csquotes.setString(40,"");
					int rocount = update_csquotes.executeUpdate();
					update_csquotes.close();
				}
				catch (java.sql.SQLException e){
					out.println("Problem with InsertING data TO csquotes TABLEs"+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					myConn.rollback();
					out.println(e.toString());
					return;
				}

			}
		}
		else{
			String sqlDelete="delete from csquotes where order_no = '"+order_no[i]+"' and line_no='"+line_no+"' and block_id='d_notes' and sequence_no='41'";
			try{
				int rsDelete=stmt.executeUpdate(sqlDelete);
			}
			catch (java.sql.SQLException e){
				out.println("Problem with delete data from csquotes TABLEs"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
		}
	}
}





















ResultSet rs2recno=stmt.executeQuery("SELECT DISTINCT CAST(Record_no AS numeric) AS Expr1 FROM CSQUOTES WHERE     (Product_ID = '"+pid+"') AND (Block_ID = 'd_notes') and sequence_no='40' ORDER BY CAST(Record_no AS numeric)");
if(rs2recno != null){
	while(rs2recno.next()){
		record_nox=rs2recno.getString(1);
	}
}
rs2recno.close();
for(int i=0; i<order_no.length; i++){
	String configstring2="";
	ResultSet rs2configstring=stmt.executeQuery("select config_String from doc_line where doc_number='"+order_no[i]+"' and doc_line='"+line_no+"'");
	if(rs2configstring != null){
		while(rs2configstring.next()){
			configstring2=rs2configstring.getString(1);
		}
	}
	rs2configstring.close();
	if(configstring2 !=null && configstring2.trim().length()>0){
		out.println(configstring2+"<BR>");
		int start=0;
		start=configstring2.substring(0,8).indexOf("NOTES/");
		if(start<0){
			start=configstring2.indexOf("&NOTES/");
		}
		int end=0;
		if(start>0){
			end=configstring2.substring(start+1).indexOf("&");
			if(end<0){
				end=configstring2.length();
			}
			else{
				end=end+start+1;
			}
			String temp2=configstring2.substring(start,end);
			configstring2=configstring2.substring(0,start)+configstring2.substring(end);
			start=temp2.indexOf("BPCS[");
			if(start>0){
				end=temp2.substring(start+1).indexOf("]");
				if(notes2[i].length()>0){
					temp2=temp2.substring(0,start+5)+notes2[i]+temp2.substring(end+start+1);
					configstring2=configstring2+temp2;
				}
				else{
					temp2=temp2.substring(0,start)+temp2.substring(end+start+2);
					temp2=temp2.replaceAll("/,","/");
					if(temp2.indexOf("[")>0){
						configstring2=configstring2+temp2;
					}
				}
			}
			else{
				if(notes2[i].length()>0){
					temp2=temp2+",BPCS["+notes2[i]+"]";
				}
				configstring2=configstring2+temp2;
			}
		}
		else{
			if(notes2[i].length()>0){
				configstring2=configstring2+"&NOTES/BPCS["+notes2[i]+"]";
			}
		}
		out.println(configstring2+"<BR><BR>");
		try{
			String insert ="update doc_line set config_string=? where doc_number = ? and doc_line=? ";
			PreparedStatement update_insert2 = myConn.prepareStatement(insert);
	        	update_insert2.setString(1,configstring2);
			update_insert2.setString(2,order_no[i]);
			update_insert2.setString(3,line_no);
			int rocount2 = update_insert2.executeUpdate();
			update_insert2.close();
		}
		catch (java.sql.SQLException e){
			out.println("Problem with update in doc_line TABLEs"+"<br>");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}
		if(notes2[i] !=null && notes2[i].trim().length()>0){
			//out.println(line_no+"::"+order_no[i]+"::"+notes2[i]+"::<BR>");
			int count=0;
			ResultSet rs20=stmt.executeQuery("select count(*) from csquotes where order_no = '"+order_no[i]+"' and line_no='"+line_no+"' and block_id='d_notes' and sequence_no='40' ");
			if(rs20 != null){
				while(rs20.next()){
					count=rs20.getInt(1);
				}
			}
			rs20.close();
			//out.println(count+"<BR><BR>");
			if(count>0){
				//update
				try{
					int rs21=stmt.executeUpdate("update csquotes set descript='"+notes2[i]+"' where order_no = '"+order_no[i]+"' and line_no='"+line_no+"' and block_id='d_notes' and sequence_no='40'");
				}
				catch (java.sql.SQLException e){
					out.println("Problem with update in csquotes TABLEs"+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					myConn.rollback();
					out.println(e.toString());
					return;
				}
			}
			else{
				String order_type="";
				String product_id="";
				String description="";
				String record_type="";
				String extended_price="";
				String record_no="";
				String block_id="";
				String sequence_no="";
				String uom="";
				String sqmp="";
				String weight="";
				String run_cost="";
				String std_cost="";
				String setup_cost="";
				String price_flag="";
				String lgth="";
				String wdth="";
				String color="";
				String vender_no="";
				String prod_code="";
				String bpcs_gen="";
				String bpcs_tier="";
				String complete="";
				String unit_price_flag="";
				String bpcs_note="";
				//insert
				ResultSet rs21=stmt.executeQuery("select * from csquotes where order_no = '"+order_no[i]+"' and line_no='"+line_no+"' and block_id='a_aproduct'");
				if(rs21 !=null){
					while(rs21.next()){
						order_type=rs21.getString("order_type");
						product_id=rs21.getString("product_id");
						record_type=rs21.getString("record_type");
						uom=rs21.getString("uom");
						sqmp=rs21.getString("sqmp");
						weight=rs21.getString("weight");
						run_cost=rs21.getString("run_cost");
						std_cost=rs21.getString("std_cost");
						setup_cost=rs21.getString("setup_cost");
						price_flag=rs21.getString("price_flag");
						lgth=rs21.getString("lgth");
						wdth=rs21.getString("wdth");
						color=rs21.getString("color");
						vender_no=rs21.getString("vendor_no");
						prod_code=rs21.getString("prod_code");
						bpcs_gen=rs21.getString("bpcs_gen");
						bpcs_tier=rs21.getString("bpcs_tier");
						complete=rs21.getString("complete");
						unit_price_flag=rs21.getString("unit_price_flag");
						record_no=record_nox;
						sequence_no="40";
						block_id="D_NOTES";
						extended_price="0.00";
						description=notes2[i];
						bpcs_note=notes2[i];
					}

				}
				rs21.close();
				try{
					String insert="insert into csquotes(order_no,line_no,order_type,product_id,descript,record_type,extended_price,record_no,block_id,sequence_no,uom,sqmp,weight,run_cost,std_cost,setup_cost,price_flag,lgth,wdth,color,vendor_no,prod_code,bpcs_gen,bpcs_tier,complete,unit_price_flag,bpcs_note,sqm,qty,field16,field17,field18,field19,field20,stock,bpcs_qty,bpcs_um,fcperc,whse,deduct) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					//out.println(insert);
					PreparedStatement update_csquotes2 = myConn.prepareStatement(insert);
					update_csquotes2.setString(1,order_no[i]);
					update_csquotes2.setString(2,line_no);
					update_csquotes2.setString(3,order_type);
					update_csquotes2.setString(4,pid);
					update_csquotes2.setString(5,description);
					update_csquotes2.setString(6,record_type);
					update_csquotes2.setString(7,extended_price);
					update_csquotes2.setString(8,record_no);
					update_csquotes2.setString(9,block_id);
					update_csquotes2.setString(10,sequence_no);
					update_csquotes2.setString(11,uom);
					update_csquotes2.setString(12,sqmp);
					update_csquotes2.setString(13,weight);
					update_csquotes2.setString(14,run_cost);
					update_csquotes2.setString(15,std_cost);
					update_csquotes2.setString(16,setup_cost);
					update_csquotes2.setString(17,price_flag);
					update_csquotes2.setString(18,lgth);
					update_csquotes2.setString(19,wdth);
					update_csquotes2.setString(20,color);
					update_csquotes2.setString(21,vender_no);
					update_csquotes2.setString(22,prod_code);
					update_csquotes2.setString(23,bpcs_gen);
					update_csquotes2.setString(24,bpcs_tier);
					update_csquotes2.setString(25,complete);
					update_csquotes2.setString(26,unit_price_flag);
					update_csquotes2.setString(27,bpcs_note);
					update_csquotes2.setString(28,"");
					update_csquotes2.setString(29,"");
					update_csquotes2.setString(30,"");
					update_csquotes2.setString(31,"");
					update_csquotes2.setString(32,"");
					update_csquotes2.setString(33,"");
					update_csquotes2.setString(34,"");
					update_csquotes2.setString(35,"");
					update_csquotes2.setString(36,"");
					update_csquotes2.setString(37,"");
					update_csquotes2.setString(38,"");
					update_csquotes2.setString(39,"");
					update_csquotes2.setString(40,"");
					int rocount = update_csquotes2.executeUpdate();
					update_csquotes2.close();
				}
				catch (java.sql.SQLException e){
					out.println("Problem with InsertING data TO csquotes TABLEs"+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					myConn.rollback();
					out.println(e.toString());
					return;
				}

			}
		}
		else{
			String sqlDelete="delete from csquotes where order_no = '"+order_no[i]+"' and line_no='"+line_no+"' and block_id='d_notes' and sequence_no='40'";
			try{
				int rsDelete2=stmt.executeUpdate(sqlDelete);
			}
			catch (java.sql.SQLException e){
				out.println("Problem with delete data from csquotes TABLEs"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
		}
	}
}
stmt.close();
myConn.close();
%>
<body onload='history.go( -1 );return true;'>
</body>
</html>