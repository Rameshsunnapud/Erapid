<tr><td class='tableline_row mainbody'>
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
		DecimalFormat for12=new DecimalFormat("#.##");
		for12.setMaximumFractionDigits(0);
		for12.setMinimumFractionDigits(0);
		String order_no=request.getParameter("order_no");
		String tax=request.getParameter("tax");
		double qty=0;
		double qtySec=0;
		double sqft=0;
		String windload="";
		ResultSet rsCosting=stmt.executeQuery("select qty,clad_code,stile_code,sqft from cs_costing where order_no='"+order_no+"'");
		if(rsCosting != null){
			while(rsCosting.next()){
				qty=qty+rsCosting.getDouble("qty");
				qtySec=qtySec+rsCosting.getDouble("qty")*rsCosting.getDouble("stile_code");
				if(windload.indexOf("#"+rsCosting.getString("clad_code")+"#")<0){
					windload=windload+"#"+rsCosting.getString("clad_code")+"#";
				}
				sqft=sqft+rsCosting.getDouble("sqft");
			}
		}
		rsCosting.close();
		windload=windload.replaceAll("##",",");
		windload=windload.replaceAll("#","");

		%>
		<b>Total SQFT: <%=sqft%></b><BR>
		<b>Wind load PSF: <%=windload%></b><BR>
		<b>Number of Louvers: <%=for12.format(qty)%></b><BR>
		<b>Number of Sections: <%=for12.format(qtySec)%></b>







	</td><td class='tableline_row mainbody'  align='right' valign='top'>
		<%
		if(tax!= null && tax.toUpperCase().equals("YES")){
		%>
		Price is FOB plant, freight prepaid (to jobsite) within  continental U.S. or FAS dock export point.
		<%
}
else{
		%>
		Price is FOB plant, freight prepaid (to jobsite) within continental U.S. or FAS dock export point. Tax not included.
		<%
}
		%>

	</td></tr>
<%}
catch(Exception e){
out.println(e);
}%>