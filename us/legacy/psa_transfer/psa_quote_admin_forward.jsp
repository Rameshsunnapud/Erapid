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
		<title>PSA Quote Admin</title>
		<script language="JavaScript" src="date-picker.js"></script>
		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>
	<script language="Javascript">
		function forwardElogia(){
			document.location.href=document.selectForm.LINK.value;
		}
	</script>
	<body onLoad="javascript:forwardElogia();">
		<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.io.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con_psa.jsp"%>
		<%@ include file="../../../db_con.jsp"%>
		<%@ include file="../../../dbcon1.jsp"%>
		<form name='selectForm' action='psa_quote_admin_forward.jsp'>

			<%

	String name=userSession.getUserId();
	String usergroup=userSession.getGroup();
String order_no=request.getParameter("quote_no");
			//out.println(order_no);
			String QuoteID="";
			String AcctID="";
			String UserID="";
			String creatorId="";

			ResultSet rs1=stmt.executeQuery("Select project_type_id, cust_name, creator_id FROM cs_project where order_no='"+order_no+"' and project_type ='psa'");
			if(rs1 != null){
				while(rs1.next()){
					if(rs1.getString(1) != null){

						QuoteID=rs1.getString(1);
						//out.println(QuoteID+"::<BR>");
						AcctID=rs1.getString(2);
						creatorId=rs1.getString(3);
					}
				}
			}
			rs1.close();
			//out.println(QuoteID+"::"+AcctID+"::"+creatorId);

			ResultSet rs2=stmt.executeQuery("select user_id from cs_reps where rep_no='"+creatorId+"'");
			if(rs2 != null){
				while(rs2.next()){
					UserID=rs2.getString(1);
				}
			}
			rs2.close();
			ResultSet rs3=stmt_psa.executeQuery("Select Quote_id from DBA.QUOTATION where elogia_no='"+order_no+"'");
			if(rs3 != null){
				while(rs3.next()){
					QuoteID=rs3.getString(1);
				}
			}
			rs3.close();
			String x="psa_quote_home.jsp?QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID.toUpperCase();
			out.println("<input type='hidden' name='LINK' value='"+x+"'>");

			if(!(usergroup.equals("Admins") || usergroup.equals("super") || usergroup.equals("Develop") || usergroup.equals("admins"))){
				FileOutputStream p;
				PrintStream out1;
				Properties ht=new Properties();
				String userId=request.getParameter("login");
				String trueUser=request.getParameter("user");
				java.util.Date date = new java.util.Date();
				try{

					File f = new File("d:/transfer/psaAdminLog.log");
					if(! f.exists()){
						p=new FileOutputStream("d:/transfer/psaAdminLog.log");
					}
					else{
						p=new FileOutputStream("d:/transfer/psaAdminLog.log", true);
					}
					out1 = new PrintStream(p);


				out1.println("Quote Number :: "+order_no+ "  Issued by  :: "+name +" on [" + date+"]");
					out1.close();
				}
				catch (Exception e){
				    out.println ("Error writing to file" + e);
				}


			}












			stmt.close();
			myConn.close();
			stmts.close();
			myConns.close();
			stmt_psa.close();
			myConn_psa.close();

			%>
		</form>
	</form>
</body>
</html>
<%
}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>