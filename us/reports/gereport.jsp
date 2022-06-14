<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>GE ORDER ENTRY</title>
		<link rel='stylesheet' href='rqs.css' type='text/css' />

	</head>
	<body>
		<B>GRAND ENTRANCE CUSTOMER<br>ORDER ENTRY SHEET<b>
				<%@ page language="java" import="java.sql.*" import="java.math.*" import="java.text.*" import="java.util.*" errorPage="error.jsp" %>
				<%@ include file="../../db_con.jsp"%>
				<%@ include file="../../db_con_bpcs.jsp"%>
				<%@ include file="../../db_con_sfdc.jsp"%>
				<%

				NumberFormat for1 = NumberFormat.getCurrencyInstance();
				for1.setMaximumFractionDigits(2);
				NumberFormat for12 = NumberFormat.getInstance();
				for12.setMaximumFractionDigits(2);
				String creator_id="";
				String orderNum=request.getParameter("orderNo");
				String customer="";
				String billing="";
				String contact="";
				String street="";
				String phone="";
				String cityZip="";
				String fax="";
				String region="";
				String job="";
				String notes="";
				double total_price=0;
				double freight=0;
				double mlcost=0;
				double freight_cost=0;
				double overage=0;
				double comm=0;
				double mlperc=0;
				double freightperc=0;
				double comperc=0;
				double netPrice=0;
				double profit=0;
				String overageString="";
				String custname="";
				String project_type="";
				String project_type_id="";
				String qualifying="";
				String qualifying_free="";
				String exclusions="";
				String exclusions_free="";
				String free_text="";
				java.util.Date now=new java.util.Date();
				DateFormat df = DateFormat.getDateInstance();
				out.println("<br><b>Report Print Date : " + df.format(now)+"<b>");
				ResultSet rs1=stmt.executeQuery("SELECT * FROM cs_project p WHERE p.Order_no='"+ orderNum +"'");

				if(rs1 != null){
					while(rs1.next()){
						creator_id=rs1.getString("creator_id");
						custname=rs1.getString("cust_name");
						qualifying=rs1.getString("qualifying_notes");
						qualifying_free=rs1.getString("qualifying_notes_free_text");
						exclusions=rs1.getString("exclusions");
						exclusions_free=rs1.getString("exclusions_free_text");
						free_text=rs1.getString("free_text");
						region=rs1.getString("sales_region");
						job=rs1.getString("project_name");
						notes=rs1.getString("internal_notes");
						project_type_id=rs1.getString("project_type_id");
						if(rs1.getString("overage")==null || rs1.getString("overage").trim().length()<=0){
							overage=0;
						}
						else{
							overage=(new Double(rs1.getString("overage")).doubleValue());
						}
						if(rs1.getString("freight_cost")==null || rs1.getString("freight_cost").trim().length()<=0){
							freight_cost=0;
						}
						else{
							freight_cost = new Double(rs1.getString("freight_cost")).doubleValue();
						}
						project_type=rs1.getString("project_type");
					}
				}
				rs1.close();


				String group_id="";
				ResultSet rsgroup = stmt.executeQuery("SELECT * FROM cs_reps where rep_no like '"+creator_id+"'");
				while ( rsgroup.next() ) {
					group_id=rsgroup.getString("group_id");
				}
				rsgroup.close();








				//out.println(custname.substring(3));
				if(project_type != null && project_type.equals("PSA")){
				%>

				<%@ include file="../../db_con_psa.jsp" %>
				<%

				String cont_id="";


				ResultSet rs_psa_account = stmt_psa.executeQuery("SELECT acctname,addr1,addr2,town,county,postcode,tel,fax,bpcs_cust_no FROM dba.account where acct_id like '"+custname+"'");
					if (rs_psa_account !=null) {
					while (rs_psa_account.next()) {
								billing= rs_psa_account.getString(1);
								street= rs_psa_account.getString(2);
								//cust_addr2= rs_psa_account.getString(3);
								cityZip= rs_psa_account.getString(4)+","+ rs_psa_account.getString(6);
								//state= rs_psa_account.getString(5);
								phone= rs_psa_account.getString(7);
								fax= rs_psa_account.getString(8);
								customer= rs_psa_account.getString(9);
						}
					}
					if(phone==null){phone="";}if(fax==null){fax="";}if(customer==null){customer="";}
					ResultSet rs_psa_quotes_issued = stmt_psa.executeQuery("SELECT * FROM dba.quotes_issued where quote_id like '"+project_type_id+"' and acct_id like '"+custname+"' ");
					if (rs_psa_quotes_issued !=null) {
					while (rs_psa_quotes_issued.next()) {
								cont_id= rs_psa_quotes_issued.getString(4);
						}
					}
					if (cont_id!=null){
						if(cont_id.trim().length()>0){
							ResultSet rs_psa_contact = stmt_psa.executeQuery("SELECT * FROM dba.contact where cont_id like '"+cont_id+"'");
							if (rs_psa_contact !=null) {
							while (rs_psa_contact.next()) {
										contact= rs_psa_contact.getString(4);
										contact=contact+" "+rs_psa_contact.getString(3);
								}
							}
							rs_psa_contact.close();
						}
					}
				rs_psa_account.close();
				rs_psa_quotes_issued.close();
				stmt_psa.close();
				myConn_psa.close();
			}
else if(project_type != null && (project_type.equals("RP")||project_type.equals("SFDC"))){
	ResultSet rsSf=stmt_sfdc.executeQuery("select * from contact where id='"+custname+"'");
	if(rsSf != null){
		while(rsSf.next()){

			if(rsSf.getString("name")!=null && !rsSf.getString("name").equals("null") && rsSf.getString("name").trim().length()>0){
				billing=rsSf.getString("name");
			}
			if(rsSf.getString("Street_Name__c")!=null && !rsSf.getString("Street_Name__c").equals("null") && rsSf.getString("Street_Name__c").trim().length()>0){
				street=rsSf.getString("Street_Name__c")+"<BR>";
			}
			if(rsSf.getString("City_or_Town__c")!=null && !rsSf.getString("City_or_Town__c").equals("null") && rsSf.getString("City_or_Town__c").trim().length()>0){
				cityZip=rsSf.getString("City_or_Town__c")+", ";
			}
			//if(rsSf.getString("State_or_Province__c")!=null && !rsSf.getString("State_or_Province__c").equals("null") && rsSf.getString("State_or_Province__c").trim().length()>0){
			//	repAddress=repAddress+rsSf.getString("State_or_Province__c")+" ";
			//}
			if(rsSf.getString("Postal_Code_or_Zip_Code__c")!=null && !rsSf.getString("Postal_Code_or_Zip_Code__c").equals("null") && rsSf.getString("Postal_Code_or_Zip_Code__c").trim().length()>0){
				cityZip=cityZip+","+rsSf.getString("Postal_Code_or_Zip_Code__c")+" ";
			}
			//if(rsSf.getString("Country__c")!=null && !rsSf.getString("Country__c").equals("null") && rsSf.getString("Country__c").trim().length()>0){
			//	repAddress=repAddress+rsSf.getString("Country__c")+" ";
			//}
			//repAddress=repAddress+"<BR>";
			if(rsSf.getString("Phone")!=null && !rsSf.getString("Phone").equals("null") && rsSf.getString("Phone").trim().length()>0){
				phone=rsSf.getString("Phone")+"<BR>";
			}
			if(rsSf.getString("Fax")!=null && !rsSf.getString("Fax").equals("null") && rsSf.getString("Fax").trim().length()>0){
				fax=rsSf.getString("Fax")+"<BR>";
			}

		}
	}
	rsSf.close();
}
			else{
				ResultSet rsCust=stmt.executeQuery("Select * from cs_customers where cust_no='"+custname.substring(3)+"'");
				if(rsCust != null){
					while(rsCust.next()){
						customer=rsCust.getString("bpcs_cust_no");
						billing=rsCust.getString("cust_name1");
						contact=rsCust.getString("contact_name");
						street=rsCust.getString("cust_addr1");
						phone=rsCust.getString("phone");
						fax=rsCust.getString("fax");
						cityZip=rsCust.getString("city")+","+rsCust.getString("zip_code");
					}
				}
				rsCust.close();

			}

			if((qualifying != null && qualifying.trim().length()>0)||(qualifying_free != null && qualifying_free.trim().length()>0)){
				notes=notes+"<BR>Qualifying notes:<BR>";
				if(qualifying != null && qualifying.trim().length()>0){
					ResultSet rsQual=stmt.executeQuery("select description FROM cs_qlf_notes where product_id='GE' and code in ("+qualifying+")");
					if(rsQual != null){
						while(rsQual.next()){
							notes=notes+rsQual.getString(1)+"<BR>";
						}
					}
					rsQual.close();
				}
				if(qualifying_free != null && qualifying_free.trim().length()>0){
					notes=notes+qualifying_free.trim()+"";
				}
				//out.println("<BR>");
			}

			if((exclusions != null && exclusions.trim().length()>0)||(exclusions_free != null && exclusions_free.trim().length()>0)){
				notes=notes+"<BR>Exclusion notes:<BR>";
				if(exclusions != null && exclusions.trim().length()>0){
					ResultSet rsExcl=stmt.executeQuery("select description FROM cs_exc_notes where product_id='GE' and code in ("+exclusions+")");
					if(rsExcl != null){
						while(rsExcl.next()){
							notes=notes+rsExcl.getString(1)+"<BR>";
						}
					}
					rsExcl.close();

				}
				if(exclusions_free != null && exclusions_free.trim().length()>0){
					notes=notes+exclusions_free.trim()+"";
				}
				//out.println("<BR>");
			}

			if((free_text != null && free_text.trim().length()>0)){
				notes=notes+"<BR>"+free_text.trim();
			}
			out.println("<br><br><table width='80%' align='left' cellspacing='1' cellpadding='2' border='1'><tr><td width='15%' bgcolor='99CCFF'><font class='schedule'><b>Quote No</b></font></td><td bgcolor='#c0c0c0' width='35%'>"+orderNum+"</td><td width='15%' bgcolor='99CCFF'><font class='schedule'><b>Customer #</b></font></td><td bgcolor='#c0c0c0' width='35%'>"+customer+"</td></tr>");
			out.println("<tr><td width='15%' bgcolor='99CCFF'><font class='schedule'><b>Billing Customer </td><td>"+billing+"</td><td width='15%' bgcolor='99CCFF'><font class='schedule'><b>Contact Name</td><td width='35%'>"+contact+"</td></tr>");
			out.println("<tr><td width='15%' bgcolor='99CCFF'><font class='schedule'><b>Address</td><td bgcolor='#c0c0c0' width='25%'>"+street+"</td><td width='15%' bgcolor='99CCFF'><font class='schedule'><b>Phone</td><td bgcolor='#c0c0c0' width='35%'>"+phone+"</td></tr>");
			out.println("<tr><td width='15%' bgcolor='99CCFF'></td><td width='35%'>"+cityZip+"</td><td width='15%' bgcolor='99CCFF'><font class='schedule'><b>Fax</td><td width='35%'> "+fax+"</td></tr></table><br><br><br><br><br><br>");

			out.println("<table width='40%' align='left' cellspacing='1' cellpadding='2' border='0'><tr><td width='30%' bgcolor='99CCFF'><font class='schedule'><b>Sales Region</td><td bgcolor='#c0c0c0'>"+region+"</td></tr>");
			out.println("<tr><td width='30%' bgcolor='99CCFF'><font class='schedule'><b>Job Name</td><td>"+job+"</td></tr></table><br><br><br>");

			ResultSet rs2=stmt.executeQuery("Select product_id, order_no, line_no, block_id, record_no, Descript, vendor_no, field19, extended_price, std_cost, bpcs_part_no,bpcs_qty, qty, bpcs_um, field16, fcperc,field18,field20,bpcs_confirm from csquotes where order_no='"+orderNum+"' and not block_id in ('A_APRODUCT','e_dim1','e_dim2','e_dim') order by cast(line_no as integer), block_id, record_no");
			out.println("<b>Order Information:</b><br>");
			out.println("<table width='100%' align='center' cellspacing='1' cellpadding='2' border='0'><tr><td width='5%' bgcolor='99CCFF'><font class='schedule'><b>Line #</td><td width='15%' bgcolor='99CCFF'><font class='schedule'><b>BPCS Part #</td><td width='4%' bgcolor='99CCFF'><font class='schedule'><b>Qty</td><td width='12%' bgcolor='99CCFF'><font class='schedule'><b>Product Description</td><td width='4%' bgcolor='99CCFF'><font class='schedule'><b>UOM</td><td width='8%' bgcolor='99CCFF'><font class='schedule'><b>Unit Price</td><td width='8%' bgcolor='99CCFF'><font class='schedule'><b>Ext Price</td><td width='20%' bgcolor='99CCFF'><font class='schedule'><b>Vendor Name</td><td width='8%' bgcolor='99CCFF'><font class='schedule'><b>V#</td><td width='8%' bgcolor='99CCFF'><font class='schedule'><b>Unit Cost</td><td width='8%' bgcolor='99CCFF'><font class='schedule'><b>Ext Cost</td></tr>");
			String qty="0";
			String std_cost="0";
			String vend="0";
			String vendName="0";
			double price;
			double field19=0;
			String backCol="";
			String line_old="";
			int i=0;

			Vector productIds=new Vector();
			if(rs2 != null){
				while (rs2.next()){

					price=0;
					if(i%2==0){
						backCol = "#ffffff";
					}
					else{
						backCol="#c0c0c0";
					}

					if((rs2.getString("qty")==null || rs2.getString("qty").trim().length()<=0) &&( rs2.getString("bpcs_qty")==null || rs2.getString("bpcs_qty").trim().length()<=0)){
						qty="0";
					}

					else{
					    if(rs2.getString("product_id").equals("IWP")){
							qty=rs2.getString("bpcs_qty");
							//out.println(rs2.getString("qty")+"::<BR>");
						}
						else if(rs2.getString("product_id").equals("GE")){
							// if(rs2.getString("qty").trim().length()>0){
								// qty=""+(new Double(rs2.getString("qty")).doubleValue())*(new Double(rs2.getString("bpcs_qty")).doubleValue());
							 //}
							 //else{
								qty=rs2.getString("bpcs_qty");
							// }
						}
						else if(rs2.getString("product_id").equals("ELM")){
							qty=rs2.getString("bpcs_qty");
						}
						else if(rs2.getString("bpcs_qty").trim().length()>0){
							qty=""+(new Double(rs2.getString("qty")).doubleValue())*(new Double(rs2.getString("bpcs_qty")).doubleValue());
						}
						else{
							qty=rs2.getString("qty");
						}

					}
					//out.println(group_id+"::"+std_cost+"::1<br>");
					//if(!group_id.toUpperCase().startsWith("REP")){
						//out.println("a");
						if(rs2.getString("std_cost")==null|| rs2.getString("std_cost").trim().length() <=0){
							std_cost="0";
						}
						else{
							std_cost=rs2.getString("std_cost");
						}

					//out.println(std_cost+"::2<br>");
					//total_price=total_price+(new Double(rs2.getString("extended_price")).doubleValue());
					mlcost=mlcost+((new Double(qty).doubleValue()*new Double(std_cost).doubleValue()*100)+0.5)/100;
					if(rs2.getString("field16")==null || rs2.getString("field16").trim().length()<=0 || rs2.getString("field16").equals("0")){
					}
					else{
						comm=comm+((new Double(rs2.getString("field16")).doubleValue())*(new Double(rs2.getString("extended_price")).doubleValue())*100+0.5)/100;
					}

					if(rs2.getString("fcperc")==null || rs2.getString("fcperc").trim().length()<=0 || rs2.getString("fcperc").equals("0")){
					}
					else{
			//
			//out.println(rs2.getString("extended_price")+"<--exprice<BR>");

						freight=freight+((new Double(rs2.getString("fcperc")).doubleValue())/100*(new Double(rs2.getString("extended_price")).doubleValue())*100+0.5)/100;
			//out.println(freight+"<--freight<BR>");
					}

					if(rs2.getString("product_id").equals("GE")){
						if(rs2.getString("field19") == null || rs2.getString("field19").trim().length()<=0 || rs2.getString("field19").equals("0")){
							field19=1;
						}
						else{
							//out.println(
							field19=(new Double(rs2.getString("field19")).doubleValue());
						}
					}
					else{
						field19=1;
					}

					price=(new Double(rs2.getString("extended_price")).doubleValue());
					if(rs2.getString("product_id").equals("GE")){
						//price=((price*field19*100)+0.5)/100;
					}
					total_price = total_price+price;
					if(!(rs2.getString("line_no").equals(line_old))){
						vend="";
						vendName="";
					}

					out.println("<tr><td width = '5%' bgcolor='"+backCol+"'>"+rs2.getString("line_no")+"</td>");
					out.println("<td width = '15%' bgcolor='"+backCol+"'>"+rs2.getString("bpcs_part_no")+"</td>");
					out.println("<td width = '4%' bgcolor='"+backCol+"' align='right'>"+for12.format(new Double(qty).doubleValue())+"</td>");
					out.println("<td width = '12%' bgcolor='"+backCol+"'>"+rs2.getString("Descript")+"</td>");
					out.println("<td width = '4%' bgcolor='"+backCol+"'>"+rs2.getString("bpcs_um")+"</td>");
					out.println("<td width = '8%' bgcolor='"+backCol+"' align='right'>"+for1.format(price/(new Double(qty).doubleValue()))+"</td>");
					out.println("<td width = '8%' bgcolor='"+backCol+"' align='right'>"+for1.format(price)+"</td>");
					vendName="";

					vend=rs2.getString("vendor_no");
					if(vend != null && vend.trim().length()>0){
						try{
							ResultSet rs3=stmt_bpcs.executeQuery("Select vndnam from avml01 where vendor = '"+vend+"'");

							if(rs3 != null){
								while(rs3.next()){
									vendName=rs3.getString("vndnam");
								}
							}
							rs3.close();
						}
						catch(Exception e){
							out.println(e+"::<BR>"+"Select vndnam from avml01 where vendor = '"+vend+"'");
						}
					}
				i++;

					out.println("<td width = '20%' bgcolor='"+backCol+"'>"+vendName+"</td>");
					out.println("<td width = '8%' bgcolor='"+backCol+"'>"+rs2.getString("vendor_no")+"</td>");
						//out.println(std_cost);
					out.println("<td width = '8%' bgcolor='"+backCol+"' align='right'>"+for1.format(new Double(std_cost).doubleValue())+"</td>");
					out.println("<td width = '8%' bgcolor='"+backCol+"' align='right'>"+for1.format((new Double (qty).doubleValue()* new Double (std_cost).doubleValue()))+"</td></tr>");
					line_old=rs2.getString("line_no");

				}

			}
			out.println("</table><br>");
			//out.println(freight+"<--freight<BR>");
			//out.println(freight_cost+"<--freight cost<BR>");
			freight=freight+freight_cost;

			total_price=overage+freight_cost+total_price;
			netPrice=total_price-freight-comm+freight_cost;
			profit=total_price+overage+freight_cost-mlcost;
			mlperc=(mlcost/total_price+freight_cost+overage)*100;
			freightperc=(freight/(total_price+freight_cost+overage))*100;
			comperc=(comm/(total_price+freight_cost+overage))*100;
/*
			out.println("<b>Job Profitablility Calculations</b><br>");
			out.println("<table width='35%' align='left' cellspacing='1' cellpadding='2' border='0'><tr><td width='20%' bgcolor='99CCFF'><font class='schedule'><b>Material and Labor Costs</td><td align='right'>"+for1.format(mlcost)+"</td><td align='right'>"+for12.format(mlperc)+"%</td></tr>");
			out.println("<tr><td width='20%' bgcolor='99CCFF'><font class='schedule'><b>Total Price</td><td width = '10%' bgcolor='#c0c0c0' align='right'>"+for1.format(total_price)+"</td><td width = '10%' bgcolor='#c0c0c0' align='right'></td></tr>");
			out.println("<tr><td width='20%' bgcolor='99CCFF'><font class='schedule'><b>Freight Incl. Price</td><td align='right'>"+for1.format(freight)+"</td><td align='right'>"+for12.format(freightperc)+"%</td></tr>");
			out.println("<tr><td width='20%' bgcolor='99CCFF'><font class='schedule'><b>Comminssion Incl. Price</td><td width = '10%' bgcolor='#c0c0c0' align='right'>"+for1.format(comm)+"</td><td width = '10%' bgcolor='#c0c0c0' align='right'>"+for12.format(comperc)+"%</td></tr>");
			out.println("<tr><td width='20%' bgcolor='99CCFF'><font class='schedule'><b>Rep Overage Incl. Price</td><td align='right'>"+for1.format(overage)+"</td><td></td></tr>");
			out.println("<tr><td width='20%' bgcolor='99CCFF'><font class='schedule'><b>Sub Total Price</td><td width = '10%' bgcolor='#c0c0c0' align='right'>"+for1.format(netPrice)+"</td><td width = '10%' bgcolor='#c0c0c0'></td></tr>");
			out.println("<tr><td width='20%' bgcolor='99CCFF'><font class='schedule'><b>Gross Profit</td><td width = '10%' align='right' >"+for1.format(profit)+"</td><td width = '10%' align='right'></td></tr></table>");

			double profitperc=((total_price - freight - mlcost + freight_cost)*100)/(total_price + overage-freight_cost);
			double marginperc=((total_price - freight - mlcost - overage - comm + freight_cost)*100)/(total_price + freight_cost + overage);
			out.println("<table width='20%' align='left' cellspacing='1' cellpadding='2' border='0'><tr><td width='5%' bgcolor='99CCFF'><font class='schedule' size=9><b>Profit%</td><td><font size=9>"+for12.format(profitperc)+"%</td></tr>");
			out.println("<tr><td width='5%' bgcolor='99CCFF'><font class='schedule' size=9><b>Margin%</font></td><td width = '10%' bgcolor='#c0c0c0'><font size=9>"+for12.format(marginperc)+"%</td></tr></table>");
			out.println("</table><BR><BR><BR><BR><BR><BR><BR><br><BR><BR><BR><BR><BR>");
*/
			out.println("<table width='100%' align='left' cellspacing='1' cellpadding='2' border='0'><tr><td width='1%' bgcolor='99CCFF'><font class='schedule'><b>Notes:</td><td width = '10%'>"+notes+"</td></td>");
			//out.println(vendName);


			//myConn.commit();

			stmt.close();
			myConn.close();
stmt_sfdc.close();
myConn_sfdc.close();
			}
			catch(Exception e){
			out.println(e);
			}
				%>
				</body>
				</html>