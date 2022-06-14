

<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<SCRIPT LANGUAGE="JavaScript">

	function goHere(){
	//alert("gohere3");
		//alert(document.form1.url.value);
		if(document.form1.close.value=="true"){
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
		String section_group_old=request.getParameter("section_group_old");
		String access_central=request.getParameter("access_central");
		String productx=request.getParameter("product");
		if(access_central==null){
			access_central="";
		}
		if(productx==null){
			productx="";
		}
%>
<%@ include file="../../db_con.jsp"%>
<%
// Updating all the project and Billed customer tables
myConn.setAutoCommit(false);
String section_info="";int section_count=0;String section_group="";Vector items=new Vector();int count_line=0;
 for (int i=0;i<Integer.parseInt(sections);i++){
 section_count=i+1;
 section_info=section_info+"s"+section_count+"="+request.getParameter("s"+section_count)+";" ;
 }
// out.println("sections "+section_info+"<br>");
      ResultSet rs5 = stmt.executeQuery("SELECT * FROM doc_line where doc_number like '"+order_no+"' order by cast(doc_line as integer)");
		if (rs5!=null){
		while(rs5.next()){
		items.addElement(rs5.getString("doc_line"));
		count_line++;
         }
		}
 for (int ij=0;ij<count_line;ij++){
 section_count=ij+1;
 section_group=section_group+items.elementAt(ij).toString()+"="+request.getParameter(items.elementAt(ij).toString())+";" ;
 }
 //out.println(section_group+"new old"+section_group_old+"<BR>");
if(section_group_old != null && !(section_group_old.trim().equals(section_group.trim()))){
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

if(Integer.parseInt(sect_count)==0){
// }
// out.println("sections "+section_info+"<br>");
try	{
	String insert ="INSERT INTO cs_quote_sections(order_no,section_info,sections,section_group)VALUES(?,?,?,?) ";
			PreparedStatement update_cust = myConn.prepareStatement(insert);
			update_cust.setString(1,order_no);
			update_cust.setString(2,section_info);
			update_cust.setInt(3,Integer.parseInt(sections));
			update_cust.setString(4,section_group);
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
	String insert ="UPDATE cs_quote_sections SET section_group=?  WHERE order_no =?";
	PreparedStatement update_customer = myConn.prepareStatement(insert);
//	update_customer.setString(1,section_info);
//	update_customer.setInt(2,Integer.parseInt(sections));
	update_customer.setString(1,section_group);
	update_customer.setString(2,order_no);
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
	//out.println("HERE1");
	out.println("<body onload='goHere()'>");
	out.println("<form name='form1'>");
	out.println("<input type='hidden' name='url' value='sections.home.jsp?cmd=5&q_no="+order_no+"&access_central="+access_central+"&product="+productx+"&close="+close+"'>");
	out.println("<input type='hidden' name='close' value=''>");
	out.println("</form>");


//stmt.close();
//myConn.close();
//out.println("Updated billing info done");

%>







<%
 }
  catch(Exception e){
	out.println("ERROR::"+e);
  }

%>