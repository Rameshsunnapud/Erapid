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
    //out.println("1<BR>");

	NumberFormat for11x = NumberFormat.getCurrencyInstance();
	for11x.setMaximumFractionDigits(0);
		String order_no=request.getParameter("order_no");
		String canType="";
		quoteHeader.setOrderNo(order_no);
                boolean isSun=true;
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
//out.println(secLines+":::"+sectotalname+"<BR>");
		DecimalFormat for12=new DecimalFormat("#.##");
		for12.setMaximumFractionDigits(0);
		for12.setMinimumFractionDigits(0);
		String exchRate="";
		String exchRateDate="";
		String exchName=quoteHeader.getExchName();
		double qty=0;
		double qtySec=0;
		String windload="";
		String currency="USD";
		if(exchName.equals("CAD")){
			currency="CAD";
		}
        
                // out.println("2<BR>");
	ResultSet rsCan=stmt.executeQuery("select exch_name,exch_rate,exch_rate_date from cs_project where order_no='"+order_no+"'");
	if(rsCan != null){
		while(rsCan.next()){
			//exchName=rsCan.getString("exch_name");
			exchRate=rsCan.getString("exch_rate");
			exchRateDate=rsCan.getString("exch_rate_date");
		}
	}
	rsCan.close();

String query="select qty,clad_code,stile_code,cost_flag,product_id from cs_costing where order_no='"+order_no+"'";
if(secLines != null && secLines.trim().length()>0){
	query="select qty,clad_code,stile_code,cost_flag,proudct_id from cs_costing where order_no='"+order_no+"'and item_no in("+secLines+")";
}
	String tempQty="";
          ///out.println("a");
if(!product.endsWith("FSM")){
	ResultSet rsCosting=stmt.executeQuery(query);
	if(rsCosting != null){
		while(rsCosting.next()){
                        if(!rsCosting.getString("product_id").equals("SUN")){
                            isSun=false;
                        }
			qty=qty+rsCosting.getDouble("qty");

			tempQty=rsCosting.getString("cost_flag");
			if(tempQty==null || tempQty.trim().length()==0 || tempQty.equals("null")){
				tempQty="1";
			}
                      //out.println(rsCosting.getString("qty")+"::"+rsCosting.getString("stile_code")+"::"+tempQty);
                        try{
			qtySec=qtySec+rsCosting.getDouble("qty")*rsCosting.getDouble("stile_code")*new Double(tempQty).doubleValue();
                        }
                        catch(Exception ex){
                            qtySec=1;
                        }
//out.println(rsCosting.getString("clad_code")+"<BR>");
			if(windload.indexOf("#"+rsCosting.getString("clad_code")+"#")<0){
				windload=windload+"#"+rsCosting.getString("clad_code")+"#";
			}

		}
	}
	rsCosting.close();
}
else{
    isSun=false;
}

 //out.println("3<BR>");
		//qtySec=qtySec*new Double(tempQty).doubleValue();

	windload=windload.replaceAll("##",",");
	windload=windload.replaceAll("#","");
	if(exchRate==null || exchRate.trim().length()==0){
	exchRate="0";
	}
	if(exchName!= null && exchName.equals("CAD")){
		price=price.replaceAll(",","");
		price=price.replaceAll("$","");

		price=for11x.format(new Double(price).doubleValue()*new Double(exchRate).doubleValue());
	}
	else{
		price=for11x.format(new Double(price).doubleValue());
	}

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
		<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only</b><BR><b>Total SQFT: <%=sqft2%></b>
			<%
                            if(isSun){
                               %>

                                <BR>
                                <b>Design load PSF: <%=windload%></b><BR>
                                <b>Number of Sunshades: <%=qty%></b><BR>
                                <b>Number of Sections: <%=qtySec%></b><BR>
                                <b>Number of Corners: <%=tempQty%></b><BR>
                                <%
                            }
                            else if(!(product.endsWith("GCP")||product.equals("FSM"))){
			%>

			<BR>
			<b>Wind load PSF: <%=windload%></b><BR>
			<%
			if(product.endsWith("GRILLE")){
			%>
			<b>Number of Screens: <%=for12.format(qty)%></b><BR>
			<%
			}
			else{
			%>
			<b>Number of Louvers: <%=for12.format(qty)%></b><BR>
			<b>Number of Sections: <%=for12.format(qtySec)%></b>
			<%}}%>

		</td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='top' nowrap><b>Total: <font class='totprice'><%= price %> <%=currency%></font></b>
			<br>
			<FONT class='mainbody'>F.O.B PLANT, FREIGHT ALLOWED EXCLUDING TAX.</FONT>
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