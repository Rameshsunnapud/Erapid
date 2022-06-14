
<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>

<%@ page language="java" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" errorPage="error.jsp" %>
<SCRIPT LANGUAGE="JavaScript">

	function goHere(){
		//alert("1");//
		//alert(document.form1.url.value);

		if(document.form1.close.value=="true"){
			window.close();
		}
		else{
			if(document.form1.url.value=="priceCalc"){
				window.parent.postMessage("priceCalc","*");
			}
			else{
				document.location.href=document.form1.url.value;
			}
		}
	}

</script>

<%
// REUQEST objects
		String close=request.getParameter("close");
		if(close == null || close.equals("null")){
			close="";
		}
		String order_no = request.getParameter("q_no");//
		String nfs = request.getParameter("test1");//
		String sect_count = request.getParameter("sect_count");//
		String access_central=request.getParameter("access_central");
		String product=request.getParameter("product");
		//out.println(access_central);
		if(access_central==null){
			access_central="";
		}
		if(product==null){
			product="";
		}


if(nfs == null||nfs.trim().length()==0 || nfs.equals("1")){
	nfs="0";
}
		String oldNum=request.getParameter("oldNum");
		boolean isDifferent=false;
//out.println("Test "+nfs+"::"+oldNum+"<BR>");
		if(oldNum != null & !(oldNum.trim().equals(nfs.trim()))){
			isDifferent=true;
		}

%>
<%@ include file="../../db_con.jsp"%>
<%
// Updating all the project and Billed customer tables
				myConn.setAutoCommit(false);
//out.println(nfs+";;;<br>");

if(isDifferent){
	try{
		String del2="delete from cs_access_central where order_no='"+order_no+"' ";
		stmt.executeUpdate(del2);
	}
	catch (java.sql.SQLException e){
		out.println("Problem with deleting from cs_access_sentral table");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}
}

//out.println("Test sect count "+sect_count+"::"+oldNum+"<BR>");
//Praveen added extra charges to below queries to fix GSOJS-234
if(Integer.parseInt(sect_count)==0){

try	{
	out.println("Testing Sections issues "+order_no);
	String insert ="INSERT INTO cs_quote_sections(order_no,sections,overage,setup_cost,handling_cost,freight_cost)VALUES(?,?,?,?,?,?) ";
			PreparedStatement update_cust = myConn.prepareStatement(insert);
			update_cust.setString(1,order_no);
//			update_cust.setString(2,null);
			update_cust.setInt(2,Integer.parseInt(nfs));
			update_cust.setString(3,"");
			update_cust.setString(4,"");
			update_cust.setString(5,"");
			update_cust.setString(6,"");
			int rocount = update_cust.executeUpdate();
			update_cust.close();
	}
	catch (java.sql.SQLException e)
	{
		out.println("Problem with ENTERING TO cs_sections TABLE"+"<br>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}

}

else{
	try
	{
			out.println("Testing Sections issues "+order_no);
		int nrow= stmt.executeUpdate("UPDATE cs_quote_sections SET sections="+Integer.parseInt(nfs)+",overage='',freight_cost='',handling_cost='',setup_cost='' WHERE order_no ='"+order_no+"'");
	}
	catch (java.sql.SQLException e)
	{
		out.println("Problem with Updating cs_quotes_sections"+"<br>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}
}

// Inserting into cs_billed_customers
myConn.commit();
stmt.close();
myConn.close();
// After saving the the first page
String urlTemp="sections.home.jsp?cmd=2&q_no="+order_no+"&access_central="+access_central+"&product="+product+"&close="+close+" ";
if(Integer.parseInt(nfs)<1){
	if(access_central.equals("y")){
		urlTemp="order_transfer_home.jsp?q_no="+order_no+"&cmd=1&product="+product;
	}
	else{
		urlTemp="priceCalc";
	}
}
out.println("urlTemp"+urlTemp);
out.println(close+"::");

if(Integer.parseInt(nfs)>1){
	//out.println("HERE1");
	out.println("<body onload='goHere()'>");
	out.println("<form name='form1'>");
	out.println("<input type='hidden' name='url' value='"+urlTemp+"'>");
	out.println("<input type='hidden' name='close' value=''>");
	out.println("</form>");
	/*
	URL url = new URL(urlTemp);
	BufferedReader in = new BufferedReader(	new InputStreamReader(url.openStream()));
	String inputLine;
	while ((inputLine = in.readLine()) != null)
	out.println(inputLine);
	in.close();
	*/
	//out.println("Updated billing info done");
}
else{
	//out.println("HERE2");
	//out.println(urlTemp);
	out.println("<body onload='goHere()'>");
	out.println("<form name='form1'>");
	out.println("<input type='hidden' name='url' value='"+urlTemp+"'>");
	out.println("<input type='hidden' name='close' value='"+close+"'>");
	out.println("</form>");
}

%>







<%
 }
  catch(Exception e){
	out.println("ERROR::"+e);
  }

%>