<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<%@ page language="java" import="java.sql.*" import="java.text.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="../../../db_con.jsp"%>
<%
NumberFormat for1 = NumberFormat.getCurrencyInstance();
String order_no=request.getParameter("order_no");
String tax_exempt="";
String customer_po_no="";
String cs_company="";
String sales_region="";
String project_name="";
String job_location="";
String project_state="";
String email="";
String phone="";
String contact_name="";
String linePrice="";
String commission="";
String noDoors="";
String name1="";
String margin="";
String arch_city="";
String arch_state="";
String request_date="";
String extra_order_notes="";
String extra_notes="";
String administrationnotes="";
String productionnotes="";
String optionsnotes="";
String holdsnotes="";
String adsorderrep="";
String adsorderrepcommperc="";
String adsdesignspecrep="";
String adsdesignspecrepcommperc="";
String adsterritoryrep="";
String adsterritoryrepcommperc="";
String adsownerspecrep="";
String adsownerspecrepcommperc="";
String production_approved_date="";
String overage="";
String color="";
int tempqty=0;

java.util.Date date = new java.util.Date();

ResultSet rs0=stmt.executeQuery("select * from cs_project where order_no='"+order_no+"'");
if(rs0 != null){
	while(rs0.next()){
		tax_exempt=rs0.getString("tax_exempt");
		project_name=rs0.getString("project_name");
		job_location=rs0.getString("job_loc");
		project_state=rs0.getString("project_state");
		overage=rs0.getString("overage");
	}
}
rs0.close();
ResultSet rs1=stmt.executeQuery("select customer_po_no,cs_company,sales_region,contact_name,phone,email from cs_billed_customers where order_no='"+order_no+"'");
if(rs1 != null){
	while(rs1.next()){
		customer_po_no=rs1.getString("customer_po_no");
		cs_company=rs1.getString("cs_company");
		sales_region=rs1.getString("sales_region");
		contact_name=rs1.getString("contact_name");
		phone=rs1.getString("phone");
		email=rs1.getString("email");
	}
}
rs1.close();
ResultSet rs2=stmt.executeQuery("select linePrice,commission,margin from cs_ads_price_calc where model='global' and order_no='"+order_no+"'");
if(rs2 != null){
	while(rs2.next()){
		linePrice=rs2.getString("lineprice");
		commission=rs2.getString("commission");
		margin=rs2.getString("margin");
	}
}
rs2.close();
ResultSet rs3=stmt.executeQuery("select name1,city,state from cs_order_architects where order_no='"+order_no+"'");
if(rs3 != null){
	while(rs3.next()){
		name1=rs3.getString("name1");
		arch_city=rs3.getString("city");
		arch_state=rs3.getString("state");
	}
}
rs3.close();
ResultSet rs4=stmt.executeQuery("select request_date from shipping where order_no='"+order_no+"'");
if(rs4 != null){
	while(rs4.next()){
		request_date=rs4.getString(1);
	}
}
rs4.close();
ResultSet rs5=stmt.executeQuery("select extra_order_notes,extra_notes,production_approved_date from cs_order_info where order_no='"+order_no+"'");
if(rs5 != null){
	while(rs5.next()){
		extra_order_notes=rs5.getString("extra_order_notes");
		extra_notes=rs5.getString("extra_notes");
		production_approved_date=rs5.getString("production_approved_date");

	}
}
rs5.close();
if(extra_notes != null && extra_notes.trim().length()>0){
	ResultSet rs6=stmt.executeQuery("select description from cs_order_notes where product_id='ads' and note_group='administration' and code in ("+extra_notes+")");
	if(rs6 != null){
		while(rs6.next()){
			administrationnotes=administrationnotes+"<tr><td style='font-size:8pt;'>&nbsp;</td><td style='font-size:8pt;' colspan='5'>"+rs6.getString(1)+"</td></tr>";
		}
	}
	rs6.close();

	ResultSet rs7=stmt.executeQuery("select description from cs_order_notes where product_id='ads' and note_group='production' and code in ("+extra_notes+")");
	if(rs7 != null){
		while(rs7.next()){
			productionnotes=productionnotes+"<tr><td style='font-size:8pt;'>&nbsp;</td><td style='font-size:8pt;' colspan='5'>"+rs7.getString(1)+"</td></tr>";
		}
	}
	rs7.close();

	ResultSet rs8=stmt.executeQuery("select description from cs_order_notes where product_id='ads' and note_group='options' and code in ("+extra_notes+")");
	if(rs8 != null){
		while(rs8.next()){
			optionsnotes=optionsnotes+"<tr><td style='font-size:8pt;'>&nbsp;</td><td style='font-size:8pt;' colspan='5'>"+rs8.getString(1)+"</td></tr>";
		}
	}
	rs8.close();
	ResultSet rs9=stmt.executeQuery("select description from cs_order_notes where product_id='ads' and note_group='holds' and code in ("+extra_notes+")");
	if(rs9 != null){
		while(rs9.next()){
			holdsnotes=holdsnotes+"<tr><td style='font-size:8pt;'>&nbsp;</td><td style='font-size:8pt;' colspan='5'>"+rs9.getString(1)+"</td></tr>";
		}
	}
	rs9.close();
}
ResultSet rs10=stmt.executeQuery("select * from cs_order_rep_info where order_no='"+order_no+"'");
if(rs10 != null){
	while(rs10.next()){
		adsorderrep=rs10.getString("order_rep_no");
		adsorderrepcommperc=rs10.getString("order_rep_comm_perc");
		adsdesignspecrep=rs10.getString("design_rep_no");
		adsdesignspecrepcommperc=rs10.getString("design_rep_no_comm_perc");
		adsterritoryrep=rs10.getString("territory_rep_no");
		adsterritoryrepcommperc=rs10.getString("territory_rep_no_comm_perc");
		adsownerspecrep=rs10.getString("owner_spec_rep_no");
		adsownerspecrepcommperc=rs10.getString("owner_spec_rep_no_comm_perc");
		color=rs10.getString("color");
	}
}
rs10.close();
ResultSet rs11=stmt.executeQuery("select qty from cs_ads_order_entry where quote_no='"+order_no+"' and not abpcs is null and not abpcs = '' ");
if(rs11 != null){
	while(rs11.next()){
		tempqty=tempqty+rs11.getInt(1);
	}
}
rs11.close();
noDoors=""+tempqty;

if(adsorderrep==null){
	adsorderrep="";
}
if(adsorderrepcommperc==null){
	adsorderrepcommperc="";
}
if(adsdesignspecrep==null){
	adsdesignspecrep="";
}
if(adsdesignspecrepcommperc==null){
	adsdesignspecrepcommperc="";
}
if(adsterritoryrep==null){
	adsterritoryrep="";
}
if(adsterritoryrepcommperc==null){
	adsterritoryrepcommperc="";
}
if(adsownerspecrep==null){
	adsownerspecrep="";
}
if(adsownerspecrepcommperc==null){
	adsownerspecrepcommperc="";
}
if(tax_exempt==null){
	tax_exempt="";
}
if(production_approved_date==null){
	production_approved_date="";
}
if(overage==null){
	overage="";
}
if(color==null){
	color="";
}


out.println("<table width='100%' border='0'>");
out.println("<tr>");
out.println("<td align='left' valign='top' width='10%'>&nbsp;</td>");
out.println("<td valign='top' width='15%'> Acrovyn Doors</td>");
out.println("<td style='font-size:8pt;' width='10%'>&nbsp;</td>");
out.println("<td style='font-size:8pt;' width='15%'>&nbsp;</td>");
out.println("<td style='font-size:8pt;' width='25%'>&nbsp;</td>");
out.println("<td style='font-size:8pt;' width='25%'>&nbsp;</td>");
out.println("</tr>");
out.println("</table><BR>");

out.println("<table width='100%' border='0'>");
out.println("<tr>");
out.println("<td align='left' width='15%'>Quote Number</td>");
out.println("<td style='font-size:8pt;' align='left' width='85%'>"+order_no+"</td>");
out.println("</tr>");
out.println("</table><BR>");

out.println("<table width='100%' border='0'>");
out.println("<tr>");
out.println("<td align='left' width='15%'>PO#</td>");
out.println("<td style='font-size:8pt;' align='left' >"+customer_po_no+"</td>");
out.println("<td style='font-size:8pt;' colspan='2'>&nbsp;</td>");
if(tax_exempt == null || tax_exempt.trim().length()==0 || tax_exempt.trim().toUpperCase().startsWith("N")){
	out.println("<td style='font-size:8pt;' colspan='2'>&nbsp;</td></tr>");
}
else{
	out.println("<td >Tax Exempt</td>");
	out.println("<td style='font-size:8pt;'>"+tax_exempt+"</td>");
}
out.println("</tr>");
out.println("</table><BR>");

out.println("<table width='100%' border='1'>");
out.println("<tr>");
out.println("<td style='font-size:8pt;' colspan='1' width='30%'>Customer Requested Ship Date:</td>");
out.println("<td style='font-size:8pt;' colspan='1'>"+request_date+"</td>");
out.println("<td style='font-size:8pt;' colspan='1' width='30%'>Production approved Ship Date:</td>");
out.println("<td style='font-size:8pt;' colspan='2'>"+production_approved_date+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td style='font-size:8pt;' colspan='1'>Market</td>");
out.println("<td style='font-size:8pt;' colspan='5'>"+cs_company+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td style='font-size:8pt;' colspan='1'>Region</td>");
out.println("<td style='font-size:8pt;' colspan='5'>"+sales_region+"</td>");
out.println("</tr>");
out.println("</table><BR>");

out.println("<table width='100%' border='1'>");
out.println("<tr>");
out.println("<td style='font-size:8pt;' colspan='1' width='15%'>Project Name</td>");
out.println("<td style='font-size:8pt;' colspan='5'>"+project_name+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td style='font-size:8pt;' colspan='1'>Project Location</td>");
out.println("<td style='font-size:8pt;' colspan='5'>"+job_location+", "+project_state+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td style='font-size:8pt;' width='15%'>Order Contact</td>");
out.println("<td style='font-size:8pt;' width='22%'>"+contact_name+"</td>");
out.println("<td style='font-size:8pt;' width='8%'>Tel:</td>");
out.println("<td style='font-size:8pt;' width='15%'>"+phone+"</td>");
out.println("<td style='font-size:8pt;' width='10%'>Email:</td>");
out.println("<td style='font-size:8pt;' width='30%'>"+email+"</td>");
out.println("</td>");
out.println("</tr>");
out.println("</table><BR>");

out.println("<table width='100%' border='0'>");
out.println("<tr>");
out.println("<td style='font-size:8pt;' width='15%'>Administration</td>");
out.println("<td style='font-size:8pt;' colspan='5'>&nbsp;</td>");
out.println("</tr>");
out.println(administrationnotes);

out.println("</table><BR>");
out.println("<table width='100%' border='0'>");
out.println("<tr>");
out.println("<td style='font-size:8pt;' width='15%'>Production Notes</td>");
out.println("<td style='font-size:8pt;' colspan='5'>&nbsp;</td>");
out.println("</tr>");
out.println(productionnotes);
out.println("</table><BR>");

out.println("<table width='100%' border='0'>");
out.println("<tr>");
out.println("<td style='font-size:8pt;' width='15%'>Important Door Options</td>");
out.println("<td style='font-size:8pt;' colspan='5'>&nbsp;</td>");
out.println("</tr>");
out.println(optionsnotes);
out.println("</table><BR>");

out.println("<table width='100%' border='0'>");
out.println("<tr>");
out.println("<td style='font-size:8pt;' width='15%'>User Holds</td>");
out.println("<td style='font-size:8pt;' colspan='5'>&nbsp;</td>");
out.println("</tr>");
out.println(holdsnotes);
out.println("</table><BR>");

out.println("<table width='100%' border='1'>");
out.println("<tr>");
out.println("<td style='font-size:8pt;'>Color:"+color+"</td>");
out.println("</tr>");

out.println("<tr>");
out.println("<td style='font-size:8pt;'>Notes:</td>");
out.println("</tr>");
out.println("<Tr>");
out.println("<td style='font-size:8pt;'>"+extra_order_notes+"&nbsp;</td>");
out.println("</tr>");
out.println("</table><BR>");

out.println("<table width='100%' border='1'>");
out.println("<tr>");
out.println("<td style='font-size:8pt;'>Contract Value $</td>");
out.println("<td style='font-size:8pt;'>"+for1.format(new Double(linePrice).doubleValue())+"</td>");
out.println("<td style='font-size:8pt;' colspan='2'>&nbsp;</td>");
out.println("<td style='font-size:8pt;'>Door Total</td>");
out.println("<td style='font-size:8pt;'>"+noDoors+"&nbsp;</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td style='font-size:8pt;'>Overage $</td>");
out.println("<td style='font-size:8pt;'>"+overage+"</td>");
out.println("<td style='font-size:8pt;' colspan='2'>&nbsp;</td>");
out.println("<td style='font-size:8pt;'>&nbsp;</td>");
out.println("<td style='font-size:8pt;'>&nbsp;</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td style='font-size:8pt;'>Commission %</td>");
out.println("<td style='font-size:8pt;'>"+commission+"</td>");
out.println("<td style='font-size:8pt;' colspan='2'>&nbsp;</td>");
out.println("<td style='font-size:8pt;'>GM%</td>");
out.println("<td style='font-size:8pt;'>"+margin+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td style='font-size:8pt;'>Architect</td>");
out.println("<td style='font-size:8pt;'>"+name1+"</td>");
out.println("<td style='font-size:8pt;' colspan='2'>&nbsp;</td>");
out.println("<td style='font-size:8pt;'>Arch. Location</td>");
out.println("<td style='font-size:8pt;'>"+arch_city+","+arch_state+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td style='font-size:8pt;' colspan='4'>");

out.println("<table border='1' width='100%' >");
out.println("<TR>");
out.println("<td style='font-size:8pt;'>Rep</td>");
out.println("<td style='font-size:8pt;'>Rep#</td>");
out.println("<td style='font-size:8pt;'>&nbsp;</td>");
out.println("<td style='font-size:8pt;'>Percent</td>");
out.println("<td style='font-size:8pt;'>&nbsp;</td>");
out.println("</tr>");
out.println("<TR>");
out.println("<td style='font-size:8pt;'>Order Rep</td>");
out.println("<td style='font-size:8pt;'>"+adsorderrep+"&nbsp; </td>");
out.println("<td style='font-size:8pt;'>@</td>");
out.println("<td style='font-size:8pt;'>"+adsorderrepcommperc+"&nbsp; </td>");
out.println("<td style='font-size:8pt;'>%</td>");
out.println("</tr>");
out.println("<TR>");
out.println("<td style='font-size:8pt;'>Design Spec</td>");
out.println("<td style='font-size:8pt;'>"+adsdesignspecrep+"&nbsp; </td>");
out.println("<td style='font-size:8pt;'>@</td>");
out.println("<td style='font-size:8pt;'>"+adsdesignspecrepcommperc+"&nbsp; </td>");
out.println("<td style='font-size:8pt;'>%</td>");
out.println("</tr>");
out.println("<TR>");
out.println("<td style='font-size:8pt;'>Territory Rep</td>");
out.println("<td style='font-size:8pt;'>"+adsterritoryrep+"&nbsp; </td>");
out.println("<td style='font-size:8pt;'>@</td>");
out.println("<td style='font-size:8pt;'>"+adsterritoryrepcommperc+"&nbsp; </td>");
out.println("<td style='font-size:8pt;'>%</td>");
out.println("</tr>");
out.println("<TR>");
out.println("<td style='font-size:8pt;'>Ownder Spec</td>");
out.println("<td style='font-size:8pt;'>"+adsownerspecrep+"&nbsp; </td>");
out.println("<td style='font-size:8pt;'>@</td>");
out.println("<td style='font-size:8pt;'>"+adsownerspecrepcommperc+"&nbsp; </td>");
out.println("<td style='font-size:8pt;'>%</td>");
out.println("</tr>");
out.println("</table>");

out.println("</td>");
out.println("<td style='font-size:8pt;' valign='top'>Date</td>");
out.println("<td style='font-size:8pt;' valign='top'>"+date+"</td>");
out.println("</tr>");
out.println("</table><BR>");












stmt.close();
myConn.close();
%>
<%
}
catch(Exception e){
out.println(e);
}
%>