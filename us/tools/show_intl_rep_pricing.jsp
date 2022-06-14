<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<%
//if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
//        erapidBean.setServerName("server1");
//}
try{

%>
<html>
	<head>
		<title>Show International Rep Pricing</title>
		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>
	<body >
		<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con.jsp"%>
		<%
		DecimalFormat for1 = new DecimalFormat("###.##");
		for1.setMaximumFractionDigits(4);
		for1.setMinimumFractionDigits(4);
		out.println("<TABLE cellspacing=0 cellpadding=2 border='1'><tr><td width=30 bgcolor='lightgrey'>SBU</td><td width=75 bgcolor='lightgrey'>MODEL</td><td width=75 bgcolor='lightgrey'>BPCS</td><td width=700 bgcolor='lightgrey'>DESC</td><td width=20 bgcolor='lightgrey'>UM</td><td width=50 bgcolor='lightgrey'>UNIT WEIGHT</td><td width=50 bgcolor='lightgrey'>PRICE</td><td width=50 bgcolor='lightgrey'>EFFECTIVE DATE</td></tr>");
		try{
			String query="Select * from cs_ic_price where cast(int_book as float)>0 and not type='ge' order by sbu,model ";
			ResultSet rs1=stmt.executeQuery(query);
			if (rs1 !=null) {
				while(rs1.next()){
					String sbu="&nbsp;";
					if(rs1.getString("sbu") != null){
						sbu=rs1.getString("sbu");
					}
					String type="&nbsp;";
					if(rs1.getString("type") != null){
						type=rs1.getString("type");
					}
					String model="&nbsp;";
					if(rs1.getString("model") != null){
						model=rs1.getString("model");
					}
					String bpcs="&nbsp;";
					if(rs1.getString("bpcs") != null){
						bpcs=rs1.getString("bpcs");
					}
					String description="&nbsp;";
					if(rs1.getString("description") != null){
						description=rs1.getString("description");
					}
					String code="&nbsp;";
					if(rs1.getString("code") != null){
						code=rs1.getString("code");
					}
					String um="&nbsp;";
					if(rs1.getString("um") != null){
						um=rs1.getString("um");
					}
					String unit_weight="0";
					if(rs1.getString("unit_weight") != null){
						unit_weight=rs1.getString("unit_weight");
					}
					String int_book="0";
					if(rs1.getString("int_book") != null){
						int_book=rs1.getString("int_book");
					}
					String effective_date="";
					if(rs1.getString("effective_date") != null){
						effective_date=rs1.getString("effective_date").substring(0,10);
					}
					out.println("<tr><td>"+sbu+"</td>");
					out.println("<td>"+model+"</td>");
					out.println("<td>"+bpcs+"</td>");
					out.println("<td>"+description+"</td>");
					out.println("<td>"+um+"</td>");
					out.println("<td align='right'>"+for1.format(new Double(unit_weight).doubleValue())+"</td>");
					out.println("<td align='right'>"+for1.format(new Double(int_book).doubleValue())+"</td>");
					out.println("<td>"+effective_date+"</td>");
					out.println("</tr>");

				}

			}
			rs1.close();
		}
		catch (Exception e){
			out.println ("Error connecting to Database  ::  " + e);
		}
		%>
	</table>
	<%
	stmt.close();
	myConn.close();
	%>
</body>
</html>
<%
}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>
