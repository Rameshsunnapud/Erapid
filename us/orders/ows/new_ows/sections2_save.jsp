
<%

try{

%>

<SCRIPT LANGUAGE="JavaScript">

	function goHere(){
		//alert("2");
		//alert(document.form1.url.value);
		if(document.form1.close.value=="true"){
			window.close();
		}
		else{
			document.location.href=document.form1.url.value;
		}
	}

</script>
<%@ page language="java" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" errorPage="error.jsp" %>
<%
// REUQEST objects
		String close=request.getParameter("close");
		if(close == null || close.equals("null")){
			close="";
		}
		String order_no = request.getParameter("q_no");//
		String sections = request.getParameter("sections");//
		String sect_count = request.getParameter("sect_count");//
		String section_page = request.getParameter("section_page");//
		if(section_page==null){section_page="0";}else{section_page="1";}
//		out.println("test"+section_page);
		String access_central=request.getParameter("access_central");
		String productx=request.getParameter("product");
		if(access_central==null){
			access_central="";
		}
		if(productx==null){
			productx="";
		}
%>
<%@ include file="db_con.jsp"%>
<%
// Updating all the project and Billed customer tables
				myConn.setAutoCommit(false);
String section_info="";int section_count=0;
 for (int i=0;i<Integer.parseInt(sections);i++){
 section_count=i+1;
 section_info=section_info+"s"+section_count+"="+request.getParameter("s"+section_count)+";" ;
 }
if(Integer.parseInt(sect_count)==0){
// }
// out.println("sections "+section_info+"<br>");
try	{
	String insert ="INSERT INTO cs_quote_sections(order_no,section_info,sections,section_page)VALUES(?,?,?,?) ";
			PreparedStatement update_cust = myConn.prepareStatement(insert);
			update_cust.setString(1,order_no);
			update_cust.setString(2,section_info);
			update_cust.setInt(3,Integer.parseInt(sections));
			update_cust.setString(4,section_page);
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
	String insert ="UPDATE cs_quote_sections SET section_info=?,sections=?,section_page=?  WHERE order_no =?";
	PreparedStatement update_customer = myConn.prepareStatement(insert);
	update_customer.setString(1,section_info);
	update_customer.setInt(2,Integer.parseInt(sections));
	update_customer.setString(3,section_page);
	update_customer.setString(4,order_no);
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
// After saving the the first page
String product="";
ResultSet rs_project = stmt.executeQuery("SELECT product_id FROM cs_project where Order_no like '"+order_no+"'");
		if (rs_project !=null) {
        while (rs_project.next()) {
		product= rs_project.getString("product_id");
		}
		}
rs_project.close();
myConn.commit();
stmt.close();
myConn.close();

if( !(product.equals("LVR")|product.equals("BV")|product.equals("GRILLE")|product.equals("ADS") )){

	out.println("<body onload='goHere()'>");
	out.println("<form name='form1'>");
	out.println("<input type='hidden' name='url' value='sections.home.jsp?cmd=4&q_no="+order_no+"&access_central="+access_central+"&product="+productx+"&close="+close+"'>");
	out.println("<input type='hidden' name='close' value=''>");
	out.println("</form>");


}else{
	//out.println("HERE1");
	out.println("<body onload='goHere()'>");
	out.println("<form name='form1'>");
	out.println("<input type='hidden' name='url' value='sections.home.jsp?cmd=3&q_no="+order_no+"&access_central="+access_central+"&product="+productx+"&close="+close+"'>");
	out.println("<input type='hidden' name='close' value=''>");
	out.println("</form>");

}

//out.println("Updated billing info done");
%>







<%
 }
  catch(Exception e){
	out.println("ERROR::"+e);
  }

%>