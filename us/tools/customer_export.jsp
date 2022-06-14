<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<%
//if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
//        erapidBean.setServerName("server1");
//}
try{

%>
<%-- Set the content type header with the JSP directive --%>
<%@ page contentType="application/vnd.ms-excel" import="java.sql.*" %>

<%-- Set the content disposition header --%>
<% response.setHeader("Content-Disposition", "attachment; filename=\"mult-table.xls\""); %>
<%@ include file="../../../db_con.jsp"%>
<table>
	<tr><td>No</td><td>Customer name</td><td>Customer name2</td><td>Address</td><td>Address2</td><td>City</td><td>State</td><td>Zip_code</td><td>Country</td><td>Phone</td><td>Shipping City</td><td>fax</td><td>email</td><td>bill_cust</td><td>Contact name</td><td>CS customer_no</td></tr>
	<%
	//HttpSession UserSession_rep = request.getSession();
	//String rep_no= UserSession_rep.getAttribute("rep_no").toString();
String rep_no=userSession.getRepNo();
	ResultSet rs1=stmt.executeQuery("select cust_no,cust_name1,cust_name2,cust_addr1,cust_addr2,city,state,zip_code,country,phone,shipping_city,fax,email,bill_cust,contact_name,bpcs_cust_no from cs_customers where created_rep_no='"+rep_no+"' and (dormant is null or dormant not like 'Y') order by cust_name1,cust_no");
	if(rs1 != null){
		while(rs1.next()){

			out.println("<tr>");
			for(int i=1; i<17; i++){
				out.println("<td>");
				if(rs1.getString(i) != null){
					out.println(rs1.getString(i));
				}
				else{
					out.println("");
				}
				out.println("</td>");
			}
			out.println("</tr>");

		}
	}
	rs1.close();

	%>

</table>
<%
}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>