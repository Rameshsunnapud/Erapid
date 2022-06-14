<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<%@ page language="java" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" errorPage="error.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
	function popUpx(){
		// alert("2");
		document.form1x.submit();
	}
	function popUpx2(){
		//alert("HERE");
		goPDF();
		//document.form1x.submit();
	}
	function goPDF(){
		var theurl;
		var theurl="pdfInitOWS.jsp";
		//alert(theurl+document.form1x.product.value);
		var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=50,height=50';
		myWindow=window.open(theurl,'myWindow',props);
		//alert("a");
		if(window.myWindow){
			//alert("1");
			if(myWindow&&typeof (myWindow.closed)!='unknown'&&!myWindow.closed){
				setTimeout("checkWindow();",1000);
			}
			else{
				setTimeout("checkWindow();",1000);
			}
		}
		else{
			//alert("2");
			setTimeout("checkWindow();",1000);
		}
	}
	function checkWindow(){
		//alert("HERE");
		if(window.myWindow){
			if(myWindow&&typeof (myWindow.closed)!='unknown'&&!myWindow.closed){
				if((document.form1x.product.value=="IWP"||document.form1x.product.value=="EFS"||document.form1x.product.value=="EJC"||document.form1x.product.value=="GCP"||document.form1x.product.value=="ADS")){
					//alert(document.form1x.workcopylink.value+"::::::::"+document.form1x.repworkcopylink.value);
					myWindow.form1.url1.value=document.form1x.workcopylink.value;
					myWindow.form1.url2.value=document.form1x.repworkcopylink.value;
					myWindow.form1.order_no.value=document.form1x.order_no.value;
				}
				else{
					//alert("HERE");
					myWindow.close();
					//document.form1x.submit();
				}
				//m
				myWindow.form1.url3.value=document.form1x.owslink.value;

				document.form1x.submit();
			}
			else{
				setTimeout("checkWindow();",1000);
			}
		}
		else{
			setTimeout("checkWindow();",1000);
		}
	}
</script>
<%
// REUQEST objects
boolean isSent=false;
String order_no = request.getParameter("order_no");//
String rep_no = request.getParameter("rep_no");//	new or old
String product = request.getParameter("product");//	new or old
String adsorderrep=request.getParameter("adsorderrep");
String adsorderrepcommperc=request.getParameter("adsorderrepcommperc");
String adsdesignspecrep=request.getParameter("adsdesignspecrep");
String adsdesignspecrepcommperc=request.getParameter("adsdesignspecrepcommperc");
String adsterritoryrep=request.getParameter("adsterritoryrep");
String adsterritoryrepcommperc=request.getParameter("adsterritoryrepcommperc");
String adsownerspecrep=request.getParameter("adsownerspecrep");
String adsownerspecrepcommperc=request.getParameter("adsownerspecrepcommperc");
String ads_color=request.getParameter("ads_color");
String[] adsnotes=request.getParameterValues("adsnote");
String[] adsnotes2=request.getParameterValues("adsnote2");
String extra_order_notes=request.getParameter("extra_order_notes");
String extra_notes="";
if(adsnotes != null){
	for(int i=0; i<adsnotes.length; i++){
		//if(i<adsnotes.length-1){
			extra_notes=extra_notes+adsnotes[i]+",";
		//}
		//else{
		//	extra_notes=extra_notes+adsnotes[i];
		//}
	}
}
if(adsnotes2 != null){
	for(int i=0; i<adsnotes2.length; i++){
		if(i<adsnotes2.length-1){
			extra_notes=extra_notes+adsnotes2[i]+",";
		}
		else{
			extra_notes=extra_notes+adsnotes2[i];
		}
	}
}
out.println(extra_notes+"<BR>");
if(extra_notes.endsWith(",")){
	extra_notes=extra_notes.substring(0,extra_notes.trim().length()-1);
}
out.println(extra_notes+"<BR>");
//	out.println("Product"+product);
//Order Info
String date_require = request.getParameter("date_require");//
//		String sub_prep = request.getParameter("sub_prep");//
String type_of_quote = request.getParameter("type_of_quote");//
String email=request.getParameter("email");//
String submittals_by = request.getParameter("submittals_by");//
String submittals_by1 = request.getParameter("submittals_by1");//
if(submittals_by==null){submittals_by=submittals_by1;}
String order_rep=request.getParameter("order_rep");
String terr_rep=request.getParameter("terr_rep");
String spec_rep=request.getParameter("spec_rep");
String special_notes = request.getParameter("special_notes");//
String copy_req = request.getParameter("copy_req");//
// Architect info
String arch_name = request.getParameter("arch_name");//
String arch_addr1 = request.getParameter("arch_addr1");//
String arch_addr2 = request.getParameter("arch_addr2");//
String arch_city = request.getParameter("arch_city");//
String arch_state = request.getParameter("arch_state");//
String arch_zip = request.getParameter("arch_zip");//
String arch_phone  = request.getParameter("arch_phone");//
String arch_fax = request.getParameter("arch_fax");//
String arch_email = request.getParameter("arch_email");//
//		String arch_required = request.getParameter("arch_required");//
String arch_detect= request.getParameter("arch_detect");//
String order_notes= request.getParameter("order_notes");//
String production_approved_date=request.getParameter("production_approved_date");
String customer_notes= request.getParameter("customer_notes");//
String ot=request.getParameter("OT1");
String nonconfig_notes=request.getParameter("nonconfig_notes");
String nonconfigPrice=request.getParameter("nonconfigPrice");
String overage=request.getParameter("overage");
String commission=request.getParameter("commission");
String commDollar=request.getParameter("commDollar");
String drafting_email=request.getParameter("drafting_email");
//out.println(overage+"::"+commission+"::"+commDollar);
//out.println(ot+"test");
boolean isNonconfig=false;
if(nonconfigPrice==null){
	nonconfigPrice="";
}
if(nonconfig_notes==null){
	nonconfig_notes="";
}
if(nonconfigPrice.trim().length()>0 || nonconfig_notes.trim().length()>0){
	isNonconfig=true;
}
if(ads_color==null){
	ads_color="";
}
if(drafting_email==null){
	drafting_email="";
}
String[] docs=request.getParameterValues("DOCS");
//String overage=request.getParameter("overage");
String DOCS="";
if(docs != null){
	for(int u=0; u<docs.length; u++){
		DOCS=DOCS+docs[u]+";";
	}
}
/*
if(emailx != null){
		for(int u=0; u<emailx.length; u++){
			email=email+emailx[u]+"";
		}
}
*/
/*if (arch_required==null){
arch_required="Y";
}
else {
arch_required="N";
}
*/
//out.println("Updated Shipping info +1");
%>
<%@ include file="../../../db_con.jsp"%>
<%
myConn.setAutoCommit(false);
/*
try{
	if(! isNonconfig){
	out.println("HERE2");
		String insert="update project set overage=? where order_no=?";
		PreparedStatement update_project=myConn.prepareStatement(insert);
			update_project.setString(1,overage);
			update_project.setString(2,order_no);
		int c=update_project.executeUpdate();
		update_project.close();
	}
	else{
	out.println("HERE");
		String insert="update project set overage=?,config_price=?,non_config_desc=? where order_no=?";
		PreparedStatement update_project=myConn.prepareStatement(insert);
			update_project.setString(1,overage);
			update_project.setString(2,nonconfigPrice);
					update_project.setString(3,nonconfig_notes);
					update_project.setString(4,order_no);
				int c=update_project.executeUpdate();
		update_project.close();
	}


}
catch(java.sql.SQLException e)
{
	out.println("Problem updating the projects table<BR>");
	out.println("Illegal Operation try again/Report Error"+"<br>");
	myConn.rollback();
	out.println(e.toString());
	return;

}
*/
try{
	if( isNonconfig){

	//out.println("HERE");
		String insert="update cs_project set configured_price=?,non_config_desc=?,commission=?,comm_dollars=?,overage=? where order_no=?";
		PreparedStatement update_project=myConn.prepareStatement(insert);

			update_project.setString(1,nonconfigPrice);
					update_project.setString(2,nonconfig_notes);
					update_project.setString(3,commission);
					update_project.setString(4,commDollar);
					update_project.setString(5,overage);
					update_project.setString(6,order_no);
				int c=update_project.executeUpdate();
		update_project.close();
	}


}
catch(java.sql.SQLException e)
{
	out.println("Problem updating the projects table<BR>");
	out.println("Illegal Operation try again/Report Error"+"<br>");
	myConn.rollback();
	out.println(e.toString());
	return;

}

		try
			{
				int nrow= stmt.executeUpdate("delete from cs_order_info WHERE order_no like '"+order_no+"'");
				int nrow1= stmt.executeUpdate("delete from cs_order_architects WHERE order_no like '"+order_no+"'");
				if(product.equals("ADS")){
					int nrow2= stmt.executeUpdate("delete from cs_order_rep_info WHERE order_no like '"+order_no+"'");
				}
			}
			catch (java.sql.SQLException e)
			{
				out.println("Problem with emptying the order info & architects info"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
try	{
//out.println(ot+":: TYPE OF QUOTE<BR>");
	String insert ="INSERT INTO cs_order_info(order_no,date_required,email_to,submit_by,special_notes,copies_requested,type_of_quote,order_notes, order_status,add_docs,customer_notes,order_rep,terr_rep,spec_rep,extra_notes,extra_order_notes,production_approved_date,drafting_email)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
	PreparedStatement update_customer = myConn.prepareStatement(insert);
			update_customer.setString(1,order_no);
			update_customer.setString(2,date_require);
			update_customer.setString(3,email);
			update_customer.setString(4,submittals_by);
			update_customer.setString(5,special_notes);
			update_customer.setString(6,copy_req);
			update_customer.setString(7,type_of_quote);
			update_customer.setString(8,order_notes);
			update_customer.setString(9,ot);
			update_customer.setString(10,DOCS);
			update_customer.setString(11,customer_notes);
			update_customer.setString(12,order_rep);
			update_customer.setString(13,terr_rep);
			update_customer.setString(14,spec_rep);
			update_customer.setString(15,extra_notes);
			update_customer.setString(16,extra_order_notes);
			update_customer.setString(17,production_approved_date);
			update_customer.setString(18,drafting_email);
			int rocount = update_customer.executeUpdate();
			update_customer.close();
	}
	catch (java.sql.SQLException e)
	{
		out.println("Problem with ENTERING data TO order info TABLEs"+"<br>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}
// Updating the architect table
try{
	String insert ="INSERT INTO cs_order_architects(order_no,name1,address1,address2,city,state,zip_code,phone,fax,email,required)VALUES(?,?,?,?,?,?,?,?,?,?,?) ";
	PreparedStatement update_payment = myConn.prepareStatement(insert);
			update_payment.setString(1,order_no);
			update_payment.setString(2,arch_name);
			update_payment.setString(3,arch_addr1);
			update_payment.setString(4,arch_addr2);
			update_payment.setString(5,arch_city);
			update_payment.setString(6,arch_state);
			update_payment.setString(7,arch_zip);
			update_payment.setString(8,arch_phone.trim());
			update_payment.setString(9,arch_fax);
			update_payment.setString(10,arch_email);
			update_payment.setString(11,arch_detect);
			int rocount = update_payment.executeUpdate();
			update_payment.close();
}
catch (java.sql.SQLException e){
	out.println("Problem with ENTERING data to architect information TABLEs"+"<br>");
	out.println("Illegal Operation try again/Report Error"+"<br>");
	myConn.rollback();
	out.println(e.toString());
	return;
}






if(product.equals("ADS")){
	try{
		String insert ="INSERT INTO cs_order_rep_info(order_no,order_rep_no,order_rep_comm_perc,design_rep_no,design_rep_no_comm_perc,territory_rep_no,territory_rep_no_comm_perc,owner_spec_rep_no,owner_spec_rep_no_comm_perc,color)VALUES(?,?,?,?,?,?,?,?,?,?) ";
		PreparedStatement update_payment = myConn.prepareStatement(insert);
				update_payment.setString(1,order_no);
				update_payment.setString(2,adsorderrep);
				update_payment.setString(3,adsorderrepcommperc);
				update_payment.setString(4,adsdesignspecrep);
				update_payment.setString(5,adsdesignspecrepcommperc);
				update_payment.setString(6,adsterritoryrep);
				update_payment.setString(7,adsterritoryrepcommperc);
				update_payment.setString(8,adsownerspecrep);
				update_payment.setString(9,adsownerspecrepcommperc);
				update_payment.setString(10,ads_color);
				int rocount = update_payment.executeUpdate();
				update_payment.close();
	}
	catch (java.sql.SQLException e){
		out.println("Problem with ENTERING data to architect information TABLEs"+"<br>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}
}





try{
	String owssent="";
	int countows=0;
	ResultSet rs_ows=stmt.executeQuery("select owssent from cs_quote_sections where order_no='"+order_no+"'");
	if(rs_ows != null){
		while(rs_ows.next()){
			owssent=rs_ows.getString(1);
			countows++;
		}
	}
	rs_ows.close();
	if(owssent == null){
		owssent="";
	}
	if(owssent.equals("Y")){
		//isSent=true;
	}
	if(!isSent){
		String insert2="update cs_quote_sections set owssent=? where order_no=?";
		PreparedStatement update_quote_sections=myConn.prepareStatement(insert2);
		update_quote_sections.setString(1,"Y");
		update_quote_sections.setString(2,order_no);
		int cc=update_quote_sections.executeUpdate();
		update_quote_sections.close();
	}

}
catch(Exception e){
	out.println("Problem with cs_quote_sections tables"+"<br>");
	out.println("Illegal Operation try again/Report Error"+"<br>");
	myConn.rollback();
	out.println(e.toString());
	return;
}

String project_type="";
ResultSet rs1=stmt.executeQuery("select project_type from cs_project where order_no='"+order_no+"'");
if(rs1 != null){
	while(rs1.next()){
		project_type=rs1.getString(1);
	}
}
rs1.close();
myConn.commit();
stmt.close();
myConn.close();
if(!isSent){
	out.println("<body onload='popUpx2()'>");
}
else{
	out.println("<body onload='popUpx()'>");
}

out.println("<form name='form1x' action='order_transfer.jsp' method='post'>");
out.println("<input type='hidden' name='order_no' value='"+order_no+"'>");
if(product.equals("IWP")||product.equals("EJC")||product.equals("EFS")||product.equals("ADS")||product.equals("GE")||product.equals("GCP")){
	out.println("<input type='hidden' name='cmd' value='5'>");
out.println("<input type='hidden' name='id' value='"+rep_no+"'>");
}else{
	out.println("<input type='hidden' name='cmd' value='3'>");
}
out.println("<input type='text' name='product' value='"+product+"'>");

if((project_type != null && (project_type.equals("PSA")||project_type.equals("SFDC")))||product.equals("GCP")||product.equals("ADS")){
	if(product.equals("ADS")){
%>
<input type='hidden' name='workcopylink' value='https://<%=application.getInitParameter("HOST")%>/erapid/us/quotes/show_summary2.jsp?orderNo=<%=order_no%>'&pid=1>
<%
}
else if (product.equals("GCP")){
%>
<input type='hidden' name='workcopylink' value='https://<%=application.getInitParameter("HOST")%>/erapid/us/reports/show_summary2.jsp?orderNo=<%=order_no%>'&pid=1>
<%
}
else{
%>
<input type='hidden' name='workcopylink' value='https://<%=application.getInitParameter("HOST")%>/erapid/us/reports/work_copy_home_psa.jsp?orderNo=<%=order_no%>'>
<%
}
}
else{
%>
<input type='hidden' name='workcopylink' value=''>
<%
}
%>
<input type='hidden' name='repworkcopylink' value='https://<%=application.getInitParameter("HOST")%>/erapid/us/reports/work_copy_home.jsp?orderNo=<%=order_no%>'>

<input type='hidden' name='owslink' value='https://<%= application.getInitParameter("HOST")%>/erapid/us/orders/ows/order_sheet.jsp?sections=all&orderNo=<%= order_no %>&rep_no=<%= rep_no %>'>
<%


out.println("</form>");

out.println("</body>");
/*
// The out put for the page 4 for the order sheet
URL yahoo = new URL("http://"+ application.getInitParameter("HOST")+"/erapid/us/orders/ows/order_transfer.jsp?cmd=5&order_no="+order_no+"&id="+rep_no+" ");
BufferedReader in = new BufferedReader(	new InputStreamReader(yahoo.openStream()));
	String inputLine;
	while ((inputLine = in.readLine()) != null)
out.println(inputLine);
in.close();
*/

// The out put for the page 4 for the order sheet done
}
catch(Exception e){
out.println(e);
}
%>

