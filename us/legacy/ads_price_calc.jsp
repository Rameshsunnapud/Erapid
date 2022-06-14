<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<html>
	<head>
		<title>ADS</title>
		<script language="JavaScript" src="date-picker.js"></script>
		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>
	<body>
		<%@ page language="java" import="java.sql.*" import="java.util.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con.jsp"%>
		<%

			String order_no = request.getParameter("q_no");
			String DESC="";
			String ADD="";
			String SECT="";
			String DATE="";
			String CSDECO="";
			String product="";

			ResultSet rs00=stmt.executeQuery("Select product_id FROM cs_project where order_no='"+order_no+"'");
			if(rs00 != null){
				while(rs00.next()){
					product=rs00.getString(1);
				}
			}
			rs00.close();
			ResultSet rs1=stmt.executeQuery("select * from cs_ads_price_calc where order_no='"+order_no+"' and model='GLOBAL'");
			if(rs1 != null){
				while(rs1.next()){
					DESC=rs1.getString("DESCRIPTION");
					ADD=rs1.getString("ADDENDA");
					SECT=rs1.getString("SECT");
					DATE=rs1.getString("PLANDATE");
					CSDECO=rs1.getString("CSDECO");
				}
			}
			rs1.close();

		String q_no=order_no;
		String message="<font color='blue'>Pricing For Job No "+q_no+"<font>";
		//HttpSession UserSession1 = request.getSession();
		//String name=UserSession1.getAttribute("username").toString();
String name=userSession.getUserId();
		%>
		<%//@ include file="rqs_head.jsp"%>
		<div align="center">
			<form name='accessForm' action='ads_price_calc_page2.jsp'>
				<input type='hidden' name='q_no' value='<%= order_no %>'>
				<table>
					<tr><td>Desc.:</TD><TD><input type='text' name='DESC' value='<%=DESC%>'></td></tr>
					<tr><td>Addenda:</TD><TD><input type='text' name='ADD' value='<%= ADD %>'></td></tr>
					<tr><td>Spec Section:</TD><TD><input type='text' name='SECT' value='<%= SECT%>'></td></tr>
					<tr><td>Plan Date:</TD><TD><input type='text' name='DATE' value='<%= DATE %>'>
							<a href="javascript:show_calendar('accessForm.DATE');" onmouseover="window.status='Date Picker';
									return true;" onmouseout="window.status='';
											return true;">
								<img src="images/show-calendar.gif" id="imgCalendar2" name="imgCalendar2" width=24 height=22 border=0></a>
						</td></tr>
					<tr><td>CS - DECO</TD><TD><Select name='CSDECO'>
							<%
							String selected="";
							selected="";
								if(CSDECO.equals("C")){
									selected="selected";
								}
							%>
								<option value='C' <%= selected %>>CS</option>
								<%
									selected="";
									if(CSDECO.equals("D")){
										selected="selected";
									}
								%>
								<option value='D' <%= selected%>>Deco</option>
								<%
									selected="";
									if(CSDECO.equals("I")){
										selected="selected";
									}
								%>
								<option value='I' <%= selected%>>IC</option>
							</select></td></tr><br>
					<tr><td colspan='2'><hr></td></tr><br>
					<tr><td align='center' colspan='2'><input type='submit' value='Submit' class='button' ></td></tr>
				</table>
				</table>
			</form>
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