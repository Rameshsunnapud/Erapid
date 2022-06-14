<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/>
<jsp:useBean id="quoteHeader" 	class="com.csgroup.general.QuoteHeaderBean"		scope="page"/>
<SCRIPT LANGUAGE="JavaScript">

	function lineItem(fp,order_no,repNo,sfdc_QuoteId){
		//alert("lineItem GSO "+sfdc_QuoteId);
		//parent.postMessage("test","*");
		alert("Please return to the line item list and correct errors for all line items that show an ABORT status");
		//if(fp=="RP" || fp=="SFDC"){
		if(fp=="RP"||fp=="SFDC"&&(repNo=="128"||repNo=="331"||repNo=="347"||repNo=="329"||repNo=="112"
		||repNo=="381"||repNo=="180"||repNo=="133"||repNo=="289"||repNo=="1832"||repNo=="1750"||repNo=="150"||
		repNo=="111"||repNo=="85"||repNo=="108"||repNo=="102"||repNo=="104"||repNo=="275"||repNo=="9093")){


		//alert("Have to got Salesforce Quote detail page");
		window.top.location.href='https://maya-cscrm.cs67.force.com/apex/CSQuoteLineProcessing?sfQuoteId='+sfdc_QuoteId+'1';
		}
		else
		{
			//alert("Go to erapid lines");
			window.parent.postMessage("test2","*");

		}
		//alert("after post");
	}
</script>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page language="java" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" errorPage="error.jsp" %>

<%
// REUQEST objects
		String order_no = request.getParameter("order_no");//
		if(order_no == null || order_no.trim().length()==0){
			order_no = request.getParameter("doc_number");
		}
%>
<%@ include file="../../../db_con.jsp"%>
<%
	Vector ec_status=new Vector(); int line=0;
	ResultSet rs1 = stmt.executeQuery("SELECT * FROM doc_line where doc_number like '"+order_no+"' AND (ec_status IN ('ABORT', '') OR ec_status IS NULL) order by cast(doc_line as integer)");
	while ( rs1.next() ) {
	ec_status.addElement(rs1.getString("ec_status"));
	line++;
	}
	String order_status="";
	ResultSet rs = stmt.executeQuery("SELECT * FROM cs_order_info where order_no = '"+order_no+"'");
	if (rs !=null) {
    	while (rs.next()) {
		order_status= rs.getString("order_status");
		}
	}
	String fp="";

	String rep_no="";String name="";String quote_origin="";String BPCS_order_no="";
	String tempProduct_ID="",project_type="";
	ResultSet rs2 = stmt.executeQuery("SELECT * FROM cs_project where order_no = '"+order_no+"'");
	if (rs2 !=null) {
		while (rs2.next()) {
			rep_no= rs2.getString("creator_id");
			name= rs2.getString("user_id");
			quote_origin= rs2.getString("quote_origin");
			tempProduct_ID=rs2.getString("product_id");
			project_type=rs2.getString("project_type");
			if(rs2.getString("project_type").equals("RP")){
				fp="rp";
			}
		}
	}
//out.println(rep_no+"::"+userSession.getRepNo()+":: In order_navigator page<BR>");
if(rep_no == null || rep_no.length()==0 || rep_no.equals("null")){
	rep_no=userSession.getRepNo();
}
//out.println(rep_no+"::"+userSession.getRepNo()+"::<BR>");

	//added to release/change orders
	int order_count=0;int order_no_count=0;String base_order_no="";
	if(quote_origin!=null){
		if(quote_origin.startsWith("release")||quote_origin.startsWith("change")){
//||(tempProduct_ID.equals("ADS")&&(quote_origin.startsWith("Alternate")||quote_origin.toUpperCase().startsWith("ALT")||quote_origin.startsWith("As Build")))
//}){
			//checking to see if there was a BASE order for this job
			ResultSet rs2_0 = stmt.executeQuery("SELECT Top 1 order_no FROM cs_billed_customers where order_no like '%"+order_no.substring(0,6)+"%' order by 1");
			if (rs2_0 !=null) {
				while (rs2_0.next()) {
					if( order_no.equals(rs2_0.getString("order_no"))){//checking to see if this order_no exists.
						order_no_count++;
					}else{
						base_order_no=rs2_0.getString("order_no");
						order_count++;
					}
				}
			}
			rs2_0.close();

		}//for release jobs
	}

	if(order_count>0){
		String contact_email="";
		String contact_name="";
		ResultSet rsContact=stmt.executeQuery("select contact_name,contact_email from cs_order_info where order_no='"+order_no+"'");
		if(rsContact != null){
			while(rsContact.next()){
				contact_email=rsContact.getString("contact_email");
				contact_name=rsContact.getString("contact_name");
			}
		}
		rsContact.close();
		out.println(contact_email+"::"+contact_name);
		try {
			CallableStatement cs = myConn.prepareCall("{call dbo.cs_orderdata_copy(?,?)}");
			 cs.setString(1,base_order_no.trim());
			 cs.setString(2,order_no.trim());
			 cs.execute();
			 cs.close();
		}
		catch (java.sql.SQLException e) {
			out.println("Problem with Copying order data from the base order"+"<br>");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			out.println(e.toString());
			return;
		}



		try{
			String insert="update cs_order_info set contact_name=?, contact_email=? where order_no=?";
			PreparedStatement update_order_info=myConn.prepareStatement(insert);
			update_order_info.setString(1,contact_name);
			update_order_info.setString(2,contact_email);
			update_order_info.setString(3,order_no);
			int c=update_order_info.executeUpdate();
			update_order_info.close();
			//myConn.commit();
		}
		catch(java.sql.SQLException e)
		{
			out.println("Problem updating the order_info table<BR>");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			//myConn.rollback();
			out.println(e.toString());
			return;

		}















	}
	//change for release/change order done.

	stmt.close();
	myConn.close();
//out.println("came back"+line);
/* HttpSession UserSession1 = request.getSession();
String name=UserSession1.getAttribute("username").toString();
String rep_no=UserSession1.getAttribute("rep_no").toString();*/
String sfdc_QuoteId = quoteHeader.getSFDC_QuoteId();
//out.println(line+"::"+order_count+"::"+order_no+"::"+rep_no+"::"+sfdc_QuoteId);

if(line>0){//

%><body onload="lineItem('<%=  project_type %>','<%= order_no %>','<%=  rep_no %>','<%=  sfdc_QuoteId %>')">

</bodY>
<%

}else{// for HA & DR  forward to orderwrite up sheet

	if(order_count>0){

%>
<jsp:forward page="order_transfer.jsp">
	<jsp:param name="order_no" value="<%= order_no %>" />
	<jsp:param name="cmd" value="1" />
	<jsp:param name="id" value="<%=  rep_no %>" />
	<jsp:param name="fp" value="<%=  fp %>" />
</jsp:forward>
<%
	}
	else{
//out.println("HERE"+order_no+"::"+rep_no);

%>
<jsp:forward page="order_transfer.jsp">
	<jsp:param name="order_no" value="<%= order_no %>" />
	<jsp:param name="cmd" value="1" />
	<jsp:param name="id" value="<%=  rep_no %>" />
	<jsp:param name="fp" value="<%=  fp %>" />
</jsp:forward>
<%


}

}

}
catch(Exception e){
out.println(e);
}
%>
