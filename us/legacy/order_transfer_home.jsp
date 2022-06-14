<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

		String product = "";//Product
		String order_no = request.getParameter("orderNo");//order_no
				String q_no=request.getParameter("q_no");
				if(order_no == null || order_no.trim().length()==0){
					order_no=q_no;
		}
%>
<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="../../../db_con.jsp"%>
<%
String doc_type="";String win_loss="";

		ResultSet rs_project = stmt.executeQuery("SELECT doc_type,win_loss FROM doc_header where doc_number like '"+order_no+"'");
		if (rs_project !=null) {
        while (rs_project.next()) {
		doc_type= rs_project.getString("doc_type");
		win_loss= rs_project.getString("win_loss");
							    }
						   }
						   rs_project.close();
ResultSet rs1=stmt.executeQuery("select product_id from cs_project where order_no='"+order_no+"'");
if(rs1 != null){
	while(rs1.next()){
		product=rs1.getString(1);
	}
}
rs1.close();
//out.println("dc"+doc_type+"winopen CLOSED"+win_loss);
if(win_loss.equals("CLOSE")&doc_type.equals("O")&&!product.equals("ADS")){
%>
<jsp:forward page="access_central_order_header.jsp">
	<jsp:param name="order_no" value="<%= order_no %>" />
</jsp:forward>
<%
}
else {
out.println("HEREx");


%>
<jsp:forward page="sections.home.jsp">
	<jsp:param name="order_no" value="<%= order_no %>" />
	<jsp:param name="product" value="<%= product %>" />
	<jsp:param name="cmd" value="<%= 1 %>" />
</jsp:forward>
<%


						}
						stmt.close();
						myConn.close();

 }
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>