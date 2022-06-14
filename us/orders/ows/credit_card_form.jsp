<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>

<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<%@ page language="java" import="java.sql.*" import="java.text.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="../../../db_con.jsp"%>
<%
String order_no = request.getParameter("order_no");
String name="";
String address1="";
String address2="";
String city="";
String state="";
String zip_code="";
String credit_card_type="";
String credit_card_no="";
String exp_date="";
String total_material_sales="";
String tax="";
String total_charged="";
ResultSet rs0=stmt.executeQuery("select * from cs_payment_details where order_no='"+order_no+"'");
if(rs0 != null){
	while(rs0.next()){
		name=rs0.getString("name");
		address1=rs0.getString("address1");
		address2=rs0.getString("address2");
		city=rs0.getString("city");
		state=rs0.getString("state");
		zip_code=rs0.getString("zip_code");
		credit_card_type=rs0.getString("credit_card_type");
		credit_card_no=rs0.getString("credit_card_no");
		exp_date=rs0.getString("exp_date");
		total_material_sales=rs0.getString("total_material_sales");
		tax=rs0.getString("tax");
		total_charged=rs0.getString("total_charged");
	}
}
rs0.close();
if(name==null){name="&nbsp;";}
if(address1==null){address1="&nbsp;";}
if(address2==null||address2.trim().length()==0){address2="";}else{address2=address2+"<BR>";}
if(city==null){city="&nbsp;";}
if(state==null){state="&nbsp;";}
if(zip_code==null){zip_code="&nbsp;";}
if(credit_card_type==null){credit_card_type="&nbsp;";}
if(credit_card_no==null){credit_card_no="&nbsp;";}
if(exp_date==null){exp_date="&nbsp;";}
if(total_material_sales==null){total_material_sales="&nbsp;";}
if(tax==null){tax="&nbsp;";}
if(total_charged==null){total_charged="&nbsp;";}
java.util.Date date = new java.util.Date();
//DateFormat dfm = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
//out.println(expire_date);

//java.util.Date datea=dfm.parse(exp_date);
String exp_datea="";
//+(1+datea.getMonth());
String exp_dateb="";
//+(1900+datea.getYear());
//if(exp_datea.trim().length()==1){
//	exp_datea="0"+exp_datea;
//}
//if(exp_dateb.trim().length()==4){
//	exp_dateb=exp_dateb.substring(2);
//}
//exp_date=exp_datea+"/"+exp_dateb;
out.println("<html><body>");
out.println("<center><B><FONT SIZE='5'>THE CS GROUP<BR>CREDIT CARD FORM</FONT></B><BR><BR><B><font size='4'>AMERICAN EXPRESS/MASTERCARD/VISA</font></B><BR><br><br>");
out.println("<table width='80%' border='0'>");
out.println("<tr>");
out.println("<td width='20%'>DATE:</TD>");
out.println("<td width='20%'>"+date.getDate()+"/"+(1+date.getMonth())+"/"+(1900+date.getYear())+"</td>");
out.println("<td width='20%'>&nbsp;</td>");
out.println("<td width='20%'>ORDER #:</TD>");
out.println("<td width='20%'>"+order_no+"</TD>");
out.println("</tr>");
out.println("<tr><td colspan='5'>&nbsp;</td></tr>");
out.println("<tr>");
out.println("<td colspan='2'>NAME(AS IT APPEARS ON CREDIT CARD):</TD>");
out.println("<td colspan='3'>&nbsp;"+name+"</td>");
out.println("</tr>");
/*
out.println("<tr>");
out.println("<td colspan='2'>BUSINESS NAME:</TD>");
out.println("<td colspan='3'>????</td>");
out.println("</tr>");
*/
out.println("<tr><td colspan='5'>&nbsp;</td></tr>");
out.println("<td>&nbsp;</td>");
out.println("<td VALIGN='TOP' colspan='2'>ADDRESS:</td>");
out.println("<td colspan='3'>"+address1+"<BR>"+address2.trim()+city.trim()+","+state+","+zip_code+"</td>");
out.println("</tr>");
out.println("<Tr>");
out.println("<td>&nbsp;</td>");
out.println("<td colspan='2'>CREDIT CARD NUMBER:</TD>");
out.println("<td colspan='2'>"+credit_card_no+"</td>");
out.println("</tr>");
out.println("<Tr>");
out.println("<td>&nbsp;</td>");
out.println("<td colspan='2'>EXPIRATION DATE:</TD>");
out.println("<td colspan='2'>"+exp_date+"</td>");
out.println("</tr>");
out.println("<Tr>");
out.println("<td>&nbsp;</td>");
out.println("<td colspan='2'>TOTAL MATERIAL SALE:</TD>");
out.println("<td colspan='2'>"+total_material_sales+"</td>");
out.println("</tr>");
/*
out.println("<Tr>");
out.println("<td>&nbsp;</td>");
out.println("<td colspan='2'>FREIGHT:</TD>");
out.println("<td colspan='2'>"+"????"+"</td>");
out.println("</tr>");
*/
out.println("<Tr>");
out.println("<td>&nbsp;</td>");
out.println("<td colspan='2'>TAX(IF APPLICABLE):</TD>");
out.println("<td colspan='2'>"+tax+"</td>");
out.println("</tr>");
out.println("<Tr>");
out.println("<td>&nbsp;</td>");
out.println("<td colspan='2'>TOTAL SALE PRICE CHARGED TO CARD:</TD>");
out.println("<td colspan='2'>"+total_charged+"</td>");
out.println("</tr>");
/*
out.println("<tr>");
out.println("<td>CUSTOMER #:</TD>");
out.println("<td colspan='2'>"+"????"+"</td>");
out.println("<td colspan='2'>&nbsp;</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td>INVOICE #:</TD>");
out.println("<td colspan='2'>"+"????"+"</td>");
out.println("<td colspan='2'>&nbsp;</td>");
out.println("</tr>");
*/
out.println("</table>");
out.println("</center></body></html>");
stmt.close();
myConn.close();
%>
<%
}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>