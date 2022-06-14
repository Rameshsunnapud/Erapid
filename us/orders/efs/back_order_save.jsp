<%@ page language="java" import="java.sql.*" import="java.text.*" import="java.util.*" import="java.net.*" import="java.io.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="db_con.jsp"%>
<SCRIPT language="JavaScript">

function goback(){
	document.location.href="shop.transfer.jsp?sp-q="+document.form1.order_no.value+"&t-s=hed&cmd=1";
}
</script>
<%
	String order_no=request.getParameter("order_no");
	String[] item_no=request.getParameterValues("item_no");
	String[] part_no=request.getParameterValues("part_no");
	String[] desc=request.getParameterValues("desc");
	String[] qty=request.getParameterValues("qty");
	String[] uom=request.getParameterValues("uom");
	String[] back_order=request.getParameterValues("back_order");
	out.println(order_no+"<BR>");
	myConn.setAutoCommit(false);
	try{
		stmt.executeUpdate("delete from cs_back_order where order_no='"+order_no+"'");
	}
	catch (java.sql.SQLException e){
		out.println("Problem with deleting from cs_back_order table");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}
	for(int i=0; i<item_no.length; i++){
		out.println(item_no[i]+"::"+part_no[i]+"::"+desc[i]);
		out.println(qty[i]+"::"+uom[i]+"::"+back_order[i]+"<BR>");
		String sqlInsert="insert into cs_back_order(order_no, item_no, part_no, description, qty_ordered, uom, qty_back_ordered) values (?,?,?,?,?,?,?)";
		try{
			java.sql.PreparedStatement update_back_order = myConn.prepareStatement(sqlInsert);
			update_back_order.setString(1,order_no);
			update_back_order.setString(2,item_no[i]);
			update_back_order.setString(3,part_no[i]);
			update_back_order.setString(4,desc[i]);
			update_back_order.setString(5,qty[i]);
			update_back_order.setString(6,uom[i]);
			update_back_order.setString(7,back_order[i]);

			int roCount=update_back_order.executeUpdate();
		}
		catch (java.sql.SQLException e)
		{
			out.println("Problem with insert into CS_BACK_ORDER TABLE <br>");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}		
	}
	myConn.commit();
	myConn.close();
	stmt.close();
	
%>
<html>
<body onload='goback()'>
<form name='form1'>
<input type='hidden' name='order_no' value='<%= order_no%>'>
</form>
</body>
</html>