<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>

<html><head>

		<script language="Javascript">
			function forwardElogia(){
				//document.location.href=document.webLoginFrm.forward.value;
			}
		</script>

	</head>

	<body onLoad="javascript:forwardElogia();">
		<%@ page language="java" import="java.lang.*" import="java.util.*" import="java.io.*" import="java.sql.*" %>
		<%@ include file="../../../db_con.jsp"%>
		<%
myConn.setAutoCommit(false);
			String q_no = request.getParameter("orderNo");//win_loss
			//out.println(q_no);
			String QuoteID = request.getParameter("QuoteID");//Login id
			String AcctID = request.getParameter("AcctID");//totals
			String UserID= request.getParameter("UserID");//totals
			String q_type= request.getParameter("q_type");//totals
			String url="";
			try{
//out.println("UPDATE cs_project SET rep_quote =? WHERE Order_no =?"+q_type+"::"+q_no);
			java.sql.PreparedStatement ps=myConn.prepareStatement("UPDATE cs_project SET rep_quote =? WHERE Order_no =? ");
			ps.setString(1,q_type);
			ps.setString(2,q_no);
			int re=ps.executeUpdate();
			ps.close();
			}
			catch (java.sql.SQLException e)
			{
				out.println("Problem with ENTERING TO Projects"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
			   String product_id="";
			   String project_type="";

			   ResultSet rs1=stmt.executeQuery("select product_id,project_Type from cs_project where order_no='"+q_no+"'");
			   if(rs1 != null){
				  while(rs1.next()){
					 product_id=rs1.getString("product_id");
					 project_type=rs1.getString("project_type");
				  }
			   }
			   rs1.close();
			   myConn.commit();
			   stmt.close();
			   myConn.close();
			   url="psa_quote_home.jsp?QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID;
if(project_type != null && project_type.equals("SFDC")){
				  url="quotes_main.jsp?q_no="+q_no;
if(project_type.equals("SFDC")){
url="order_transfer_home.jsp?orderNo="+q_no+"&cmd=1";
}
			   }

		%>
		<FORM method=GEt name=webLoginFrm>
			<input type='hidden' name='forward' value=<%= url %> >
			<input type='hidden' name='q_no' value=<%= q_no %> >
		</form>
	</body>
</html>
<%

 }
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>