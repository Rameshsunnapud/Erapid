<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="quoteHeader" 	class="com.csgroup.general.QuoteHeaderBean"		scope="page"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.math.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="../../db_con.jsp"%>
<%


		String order_no=request.getParameter("order_no");
		String canType="";
		quoteHeader.setOrderNo(order_no);
		String exchName=quoteHeader.getExchName();
		String currency="USD";
		if(exchName.equals("CAD")){
			currency="CAD";
		} 
		String tax_perc=request.getParameter("tax_perc");
		String overage=request.getParameter("overage");
		String handling_cost=request.getParameter("handling_cost");
		String freight_cost=request.getParameter("freight_cost");
		String setup_cost1=request.getParameter("setup_cost1");
		String setup_cost=request.getParameter("setup_cost");
		String totprice_dis=request.getParameter("totprice_dis");
		String isquote=request.getParameter("isquote");
		String product=request.getParameter("product_id");
		String secLines=request.getParameter("secLines");
		String sectotalname=request.getParameter("sectotalname");
		String border_color=request.getParameter("border_color");
		String price=request.getParameter("price");
		String taxtotal=request.getParameter("taxtotal");
//out.println(sectotalname+"::"+order_no+":::"+tax_perc+"::<BR>AAAA");



String querySQFT="";
String sqft2="";
if(sectotalname != null&&sectotalname.trim().length()>0){
	querySQFT="select pindtotsf from cs_access_central where order_no='"+order_no+"' and section_no='"+sectotalname+"'";
}
else{
	querySQFT="select pindtotsf from cs_access_central where order_no='"+order_no+"'";
}
ResultSet rssqft=stmt.executeQuery(querySQFT);
//ut.println(querySQFT);
if(rssqft != null){
	while(rssqft.next()){
		sqft2=rssqft.getString(1);
	}
}
rssqft.close();

if(!product.endsWith("GCP")){
%>
<table class='<%= border_color %>' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'>
	<tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only</b><BR><b>Total SQFT: <%=sqft2%></b></td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= price %> <%=currency%></font></b>
			<br>
			<FONT class='mainbodyh'>F.O.B PLANT, FREIGHT ALLOWED EXCLUDING TAX.</FONT>
		</td>
	</tr>
</table>
<%
}
else{
%>
<table class='<%= border_color %>' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'>
	<tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only</b></td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= price %> <%=currency%></font></b>
		</td>
	</tr>
</table>
<%
if(tax_perc != null && !tax_perc.equals("0") && tax_perc.trim().length()>0){
%>
<jsp:include page="summary_tax.jsp" flush="true">
	<jsp:param name="order_no" value="<%= order_no%>"/>
	<jsp:param name="tax_perc" value="<%= tax_perc%>"/>
	<jsp:param name="overage" value="<%=overage %>"/>
	<jsp:param name="handling_cost" value="<%=handling_cost %>"/>
	<jsp:param name="freight_cost" value="<%=freight_cost %>"/>
	<jsp:param name="setup_cost1" value="0"/>
	<jsp:param name="setup_cost" value="<%= setup_cost%>"/>
	<jsp:param name="totprice_dis" value="<%= taxtotal%>"/>
	<jsp:param name="isquote" value="yes"/>
	<jsp:param name="product_id" value="<%= product%>"/>
	<jsp:param name="secLines" value="<%= secLines%>"/>
</jsp:include>
<%

}




}
}
catch(Exception e){
out.println(e);
}

%>
<br>