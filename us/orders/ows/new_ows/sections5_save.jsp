
<%

try{

%>
<%@ page language="java" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" errorPage="error.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin


	function goHere(){
		//alert("5");

		//parent.window.postMessage("test","*");
		//parent.window.cancelHeader();
		//window.parent.postMessage("test","*");
		//alert("after");
		if(document.form1.projectType.value=="rp"){
			window.close();
		}
		else if(document.form1.close.value=="true"){
			//window.close();
			//alert("1");
			window.parent.postMessage("priceCalc","*");
			//alert("3");
		}
		else{
			//alert("2");
			window.parent.postMessage("priceCalc","*");
			//alert("after post");
			//alert("4");
			//document.location.href=document.form1.url.value;
		}
	}
	function goHere2(){
		//parent.window.postMessage("test","*");
		//alert("BEFORE");
		//alert("2");
		//alert("a");
		window.parent.postMessage("priceCalc","*");
		//alert("middle");
		//top.cancelHeader();

		//alert("after");
		if(document.form2.projectType.value=="rp"){
		//alert("HERE");
			window.close();
		}
		else if(document.form2.close.value=="true"){
			window.close();
		}
		else{
			window.parent.postMessage("priceCalc","*");
			//document.location.href=document.form2.url.value;
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
		String sections = request.getParameter("sections");//
		String sect_count = request.getParameter("sect_count");//
		String section_overage="";
		String section_setup="";
		String section_handling="";
		String section_freight="";
		String access_central=request.getParameter("access_central");
		String productx=request.getParameter("product");
		if(access_central==null){
			access_central="";
		}
		if(productx==null){
			productx="";
		}
		//out.println(productx+"::"+access_central);
		String nameso[] = request.getParameterValues("o");
		String namess[] = request.getParameterValues("sc");
		String namesh[] = request.getParameterValues("hc");
		String namesf[] = request.getParameterValues("fc");
	if(nameso != null){
		for (int iq=1; iq <= nameso.length; iq++)
		 {
		//out.println(namesq[iq-1]);
		    section_overage=section_overage+"s"+iq+"="+nameso[iq-1]+";";
		}
	}
	if(namess != null){
		for (int ie=1; ie <= namess.length; ie++)
		 {
		//out.println(namese[ie-1]);
		section_setup=section_setup+"s"+ie+"="+namess[ie-1]+";";
		}
	}
	if(namesh != null){
		for (int in=1; in <= namesh.length; in++) 		 {
		//out.println(namesn[in-1]);
		section_handling=section_handling+"s"+in+"="+namesh[in-1]+";";
		}
	}
	if(namesf != null){
		for (int in=1; in <= namesf.length; in++) 		 {
    	//	//out.println(namesn[in-1]);
		section_freight=section_freight+"s"+in+"="+namesf[in-1]+";";
		}
	}
	//out.println(section_overage+"::<BR>"+section_setup+"::<BR>"+section_handling+"::<BR>"+section_freight+"::<BR>");
//out.println(order_no+"::"+sections+"::"+sect_count+"<BR>");
%>
<%@ include file="db_con.jsp"%>
<%
String productID="";
String projectType="";
ResultSet rsProduct=stmt.executeQuery("select product_id,project_type from cs_project where order_no='"+order_no+"'");
if(rsProduct != null){
	while(rsProduct.next()){
		productID=rsProduct.getString(1);
		projectType=rsProduct.getString(2);
	}
}
rsProduct.close();
//if(!productID.equals("EFS")){
//	section_handling=section_freight;
//}
myConn.setAutoCommit(false);
if(sect_count!=null){
if(Integer.parseInt(sect_count)==0){
try	{
	String insert ="INSERT INTO cs_quote_sections(order_no,sections,overage,setup_cost,handling_cost,freight_cost)VALUES(?,?,?,?,?,?) ";
			PreparedStatement update_cust = myConn.prepareStatement(insert);
			update_cust.setString(1,order_no);
			update_cust.setInt(2,Integer.parseInt(sections));
			update_cust.setString(3,section_overage);
			update_cust.setString(4,section_setup);
			update_cust.setString(5,section_handling);
			update_cust.setString(6,section_freight);
			int rocount = update_cust.executeUpdate();
			update_cust.close();
	}
	catch (java.sql.SQLException e)
	{
		out.println("Problem with INSERTING TO cs_sections TABLE"+"<br>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}
}
else{
	try
	{
	String insert ="UPDATE cs_quote_sections SET overage=?,setup_cost=?,handling_cost=?,freight_cost=? WHERE order_no =?";
	PreparedStatement update_customer = myConn.prepareStatement(insert);
	update_customer.setString(1,section_overage);
	update_customer.setString(2,section_setup);
	update_customer.setString(3,section_handling);
	update_customer.setString(4,section_freight);
	update_customer.setString(5,order_no);
	int rocount = update_customer.executeUpdate();
	update_customer.close();
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

}
myConn.commit();
stmt.close();
myConn.close();

if(projectType==null){
	projectType="";
}
else{
	projectType=projectType.toLowerCase();
}











String urlTemp="quotes_main.jsp?cmd=1&q_no="+order_no+"&close="+close+" ";
if(access_central.equals("y")){
	urlTemp="order_transfer_home.jsp?q_no="+order_no+"&cmd=1&product="+productx+"&close="+close+" ";
}

if(access_central.equals("y")||productx.equals("GCP")||close.equals("true")){
	//out.println(urlTemp);
	out.println("<body onload='goHere()'>");
	out.println("<form name='form1'>");
	out.println("<input type='hidden' name='url' value='"+urlTemp+"'>");
	out.println("<input type='hidden' name='close' value='"+close+"'>");
	out.println("<input type='hidden' name='projectType' value='"+projectType+"'>");
	out.println("</form>");
}
else{
out.println(urlTemp);

	out.println("<body onload='goHere2()'>");
	out.println("<form name='form2'>");
	out.println("<input type='hidden' name='url' value='"+urlTemp+"'>");
	out.println("<input type='hidden' name='close' value=''>");
	out.println("<input type='hidden' name='projectType' value='"+projectType+"'>");
	out.println("</form>");


	/*
	URL url = new URL(urlTemp);
	BufferedReader in = new BufferedReader(	new InputStreamReader(url.openStream()));
	String inputLine;
	while ((inputLine = in.readLine()) != null)
	out.println(inputLine);
	in.close();
	*/

	//out.println("Updated billing info done"+close+"::");
}





























%>







<%
 }
  catch(Exception e){
	out.println("ERROR::"+e);
  }

%>