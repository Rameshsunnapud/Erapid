
<%

try{

%>

<SCRIPT LANGUAGE="JavaScript">

	function goHere(){
		//alert("go here4");
		if(document.form1.close.value=="true"){
			//window.close();
			//alert("1");
			window.parent.postMessage("priceCalc","*");
			//alert("2");
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
		String section_qual="";
		String section_excl="";
		String section_notes="";

		String namesq[] = request.getParameterValues("q");
if(namesq != null){
		for (int iq=1; iq <= namesq.length; iq++)
		 {
		//out.println(namesq[iq-1]);
		section_qual=section_qual+"s"+iq+"="+namesq[iq-1]+";";
		}
		String namese[] = request.getParameterValues("e");
		for (int ie=1; ie <= namese.length; ie++)
		 {
		//out.println(namese[ie-1]);
		section_excl=section_excl+"s"+ie+"="+namese[ie-1]+";";
		}
		String namesn[] = request.getParameterValues("n");
		for (int in=1; in <= namesn.length; in++)
		 {
		//out.println(namesn[in-1]);
		section_notes=section_notes+"s"+in+"="+namesn[in-1]+";";
		}
}
//out.println(order_no+"::"+sections+"::"+sect_count+"<BR>");
%>
<%@ include file="db_con.jsp"%>
<%
// Updating all the project and Billed customer tables
				myConn.setAutoCommit(false);
String section_info="";int section_count=0;
 for (int i=0;i<Integer.parseInt(sections);i++){
 section_count=i+1;
 section_info=section_info+"s"+section_count+"="+request.getParameter("s+section_count+")+";";



	//out.println(section_info+"<br>:::"+section_qual+"::::"+section_excl+"::::"+section_notes+"<BR>");
 }
if(Integer.parseInt(sect_count)==0){
// }
// out.println("sections "+section_info+"<br>");
try	{
	String insert ="INSERT INTO cs_quote_sections(order_no,section_info,sections,section_qual,section_excl,section_notes)VALUES(?,?,?,?,?,?) ";
			PreparedStatement update_cust = myConn.prepareStatement(insert);
			update_cust.setString(1,order_no);
			update_cust.setString(2,section_info);
			update_cust.setInt(3,Integer.parseInt(sections));
			update_cust.setString(4,section_qual);
			update_cust.setString(5,section_excl);
			update_cust.setString(6,section_notes);
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

	String insert ="UPDATE cs_quote_sections SET section_qual=?,section_excl=?,section_notes=?  WHERE order_no =?";
	PreparedStatement update_customer = myConn.prepareStatement(insert);
	update_customer.setString(1,section_qual);
	update_customer.setString(2,section_excl);
	update_customer.setString(3,section_notes);
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
myConn.commit();
stmt.close();
myConn.close();
// After saving the the first page
//out.println(close+"::");
out.println("<body onload='goHere()'>");
out.println("<form name='form1'>");
out.println("<input type='hidden' name='url' value='sections.home.jsp?cmd=3&q_no="+order_no+"&close="+close+"'>");
out.println("<input type='hidden' name='close' value=''>");
out.println("</form>");


//out.println("Updated billing info done");

%>







<%
 }
  catch(Exception e){
	out.println("ERROR::"+e);
  }

%>