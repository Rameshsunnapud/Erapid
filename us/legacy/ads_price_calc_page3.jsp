<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<html>
	<head>
		<title>ADS</title>
		<link rel='stylesheet' href='styleAds.css' type='text/css' />
	</head>
	<SCRIPT LANGUAGE="JavaScript">
		<!-- Begin
		function goHere(){
			//alert(document.here.x.value);
			document.location.href=document.here.x.value;
		}
	</script>
	<%@ page language="java" import="java.sql.*" import="java.util.*" errorPage="error.jsp" %>
	<%@ include file="../../../db_con.jsp"%>
	<%
		String order_no=request.getParameter("order_no");
		String DESC=request.getParameter("DESC");
		String ADD=request.getParameter("ADD");
		String SECT=request.getParameter("SECT");
		String DATE=request.getParameter("DATE");
		String CSDECO=request.getParameter("CSDECO");
		String globalDrafting=request.getParameter("draftingHours");
		String globalDraftingDollars=request.getParameter("globalDrafting");
		String globalLayout=request.getParameter("layoutHours");
		String globalLayoutDollars=request.getParameter("globalLayout");
		String globalProjectMgmt=request.getParameter("projectMgmtHours");
		String globalProjectMgmtDollars=request.getParameter("globalProjectMgmt");
		String globalCatchall=request.getParameter("globalCatchall");
		String globalFreight=request.getParameter("globalFreight");
		String globalCommission=request.getParameter("globalCommission");
		String globalCommissionDollars=request.getParameter("globalCommissionDollar");
		String globalCoordination=request.getParameter("globalCoordination");
		String globalPrice=request.getParameter("globalPrice");
		String globalCanPrice=request.getParameter("globalCanPrice");
		String globalMargin=request.getParameter("globalMargin");
		String[] model=request.getParameterValues("model");
		String[] qty=request.getParameterValues("qty");
		String[] cost=request.getParameterValues("cost");
		String[] margin=request.getParameterValues("margin");
		String[] drafting=request.getParameterValues("drafting");
		String[] layout=request.getParameterValues("layout");
		String[] projectMgmt=request.getParameterValues("projectMgmt");
		String[] catchall=request.getParameterValues("catchall");
		String[] freight=request.getParameterValues("freight");
		String[] commission=request.getParameterValues("commission");
		String[] coordination=request.getParameterValues("coordination");
		String[] coordinationDollars=request.getParameterValues("coordinationDollar");
		String[] price=request.getParameterValues("price");

		myConn.setAutoCommit(false);

		try{
			String deleteADS="delete from cs_ads_price_calc where order_no='"+order_no+"'";
			stmt.executeUpdate(deleteADS);
		}
		catch (java.sql.SQLException e){
			out.println("Problem with deleting from cs_ads_price_calc table");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}
		String globalInsert="";
		try{
			globalInsert="insert into cs_ads_price_calc (order_no,model,catchall,drafting,layout,projectMgmt,coordination,margin,linePrice,canLinePrice,freight,qty,commission,description,addenda,sect,planDate,draftingDollars,layoutDollars,projectMgmtDollars,commissionDollars,CSDECO) values ('"+order_no+"','GLOBAL','"+globalCatchall+"','"+globalDrafting+"','"+globalLayout+"','"+globalProjectMgmt+"','"+globalCoordination+"','"+globalMargin+"','"+globalPrice+"','"+globalCanPrice+"','"+globalFreight+"','1','"+globalCommission+"','"+DESC+"','"+ADD+"','"+SECT+"','"+DATE+"','"+globalDraftingDollars+"','"+globalLayoutDollars+"','"+globalProjectMgmtDollars+"','"+globalCommissionDollars+"','"+CSDECO+"')";
			java.sql.PreparedStatement insertGlobal = myConn.prepareStatement(globalInsert);
			int rocount=insertGlobal.executeUpdate();
			insertGlobal.close();
			}
		catch (java.sql.SQLException e){
			out.println("Problem with entering into cs_ads_price_calc table1");
			out.println("Illegal Operation try again/Report Error"+"<br>"+globalInsert);
			myConn.rollback();
			out.println(e.toString());
			return;
		}
		String lineInsert="";
		try{
			for(int i=0; i<model.length; i++){
				double marginx=0;
				if(margin[i] != null && margin[i].trim().length()>0){
					marginx=new Double(margin[i]).doubleValue();
				}
				//out.println(marginx+"::<BR>");
				lineInsert="insert into cs_ads_price_calc (order_no,model,catchall,drafting,layout,projectMgmt,coordination,margin,linePrice,freight,qty,commission,description,addenda,sect,planDate,CSDECO,cost,coordinationDollars) values ('"+order_no+"','"+model[i]+"','"+catchall[i]+"','"+drafting[i]+"','"+layout[i]+"','"+projectMgmt[i]+"','"+coordination[i]+"','"+marginx+"','"+price[i]+"','"+freight[i]+"','"+qty[i]+"','"+commission[i]+"','"+DESC+"','"+ADD+"','"+SECT+"','"+DATE+"','"+CSDECO+"','"+cost[i]+"','"+coordinationDollars[i]+"')";
				java.sql.PreparedStatement insertLine = myConn.prepareStatement(lineInsert);
				int rocount2=insertLine.executeUpdate();
				insertLine.close();
			}
		}
		catch (java.sql.SQLException e){
			out.println("Problem with entering into cs_ads_price_calc table2");
			out.println("Illegal Operation try again/Report Error"+"<br>"+lineInsert);
			myConn.rollback();
			out.println(e.toString());
			return;
		}
		String x="order_transfer_home.jsp?q_no="+order_no+"&cmd=1&product=ADS'";
		out.println("<body onload='goHere()'>");
		out.println("<form name='here'>");

		out.println("<input type='hidden' name='x' value='"+x+"'>");
		out.println("</form>");
		myConn.commit();
		stmt.close();
		myConn.close();
		out.println("complete");
	%>
</bodY>
</html>
<%
}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>