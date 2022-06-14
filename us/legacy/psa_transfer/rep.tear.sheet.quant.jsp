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
				document.location.href=document.webLoginFrm.forward.value;
			}
		</script>

	</head>

	<body onLoad="javascript:forwardElogia();">
		<%@ page language="java" import="java.lang.*" import="java.util.*" import="java.io.*" import="java.sql.*" %>
		<%@ include file="../../../db_con.jsp"%>
		<%
			String q_no = request.getParameter("orderNo");//win_loss
			//out.println(q_no);
			String QuoteID = request.getParameter("QuoteID");//Login id
			String AcctID = request.getParameter("AcctID");//totals
			String UserID= request.getParameter("UserID");//totals
			String tear_sheet_type= request.getParameter("tear_sheet");//totals
			String url="";
			try{
			java.sql.PreparedStatement ps=myConn.prepareStatement("UPDATE cs_project SET rep_tear_sheet =? WHERE Order_no =? ");
			ps.setString(1,tear_sheet_type);
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
		//myConn.commit();
		stmt.close();
		myConn.close();
					url="psa_quote_home.jsp?QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID;
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