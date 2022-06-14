<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<%
//if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
//        erapidBean.setServerName("server1");
//}
try{

%>
<html>
	<head>
		<title>SBU Contacts</title>
		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>
	<body>
		<SCRIPT LANGUAGE="JavaScript">
			function checkThis(){
				var emptyValues="";
				//alert(document.addProduct.vendName.value.length);
				if(document.addProduct.vendName.value.length==0){
					emptyValues=emptyValues+"Vendor Name\n";
				}
				if(document.addProduct.itemName.value.length==0){
					emptyValues=emptyValues+"Item Name\n";
				}

				if(document.addProduct.partCost.value.length==0){
					emptyValues=emptyValues+"Part Cost\n";
				}
				if(document.addProduct.partUm.value.length==0){
					emptyValues=emptyValues+"Part Unit of Measure\n";
				}
				if(document.addProduct.partNo.value.length==0){
					emptyValues=emptyValues+"Part Number\n";
				}



				if(emptyValues.length==0){
					return true;
				}
				else{
					alert("Please enter :\n"+emptyValues);
					return false;
				}
			}
			function editThis(a){
				document.location.href=a;
			}
			function deleteThis(a){
				var fRet;
				fRet=confirm('Are you sure?');
				//alert(fRet);
				//alert(a);
				if(fRet){
					document.location.href=a;
				}
			}
		</script>
		<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con.jsp"%>
		<%
		//out.println("<img src='/web/images/grande.gif' width='50' height='50' align='right'>");
		out.println("<form name='searchForm' action='sbu_contact_maint.jsp'>");
		out.println("<table><TR><td></td><TD><input type='text' name='cmd'></td>");
		out.println("<td><select name='type'>");
		out.println("<option value='RN'><font color='3333CC'>Rep_no</option>");
		out.println("<option value='CN'><font color='3333CC'>Contact Name</option>");
		out.println("<option value='CE'><font color='3333CC'>Contact Email</option>");
		out.println("<option value='SE'><font color='3333CC'>Sales Email</option>");
		out.println("<option value='PI'><font color='3333CC'>Product Id</option>");
		out.println("</select></td>");
		out.println("<td><input type='radio' name='group1' value='startsWith' checked><font color='3333CC'>Starts With");
		out.println("<input type='radio' name='group1' value='contains'><font color='3333CC'>Contains</td>");
		out.println("<td><input type='submit' value='submit' class='button'></td>");
		out.println("</tr></table>");
		out.println("</form><BR><BR>");


		String search=request.getParameter("cmd");
		String type=request.getParameter("type");
		String group1=request.getParameter("group1");
		//out.println(search+"<-->"+type+"<-->"+group1+"<BR>");
		if(!(search != null)){
			search="";
		}
		if(!(type != null)){
			type="";
		}
		if(!(group1 != null)){
			group1="";
		}
		//out.println(search+"<-->"+type+"<-->"+group1);

		if(group1.equals("startsWith")){
			if(search.indexOf("%")<=0){
				search=search+"%";
			}
		}
		else if(group1.equals("contains")){
			search="%"+search+"%";
		}
		String columnName="";
		if(type.equals("RN")){
			columnName="Rep_no";
		}
		if(type.equals("CN")){
			columnName="contact_name";
		}
		if(type.equals("CE")){
			columnName="contact_email";
		}
		//if(type.equals("SE")){
		//	columnName="sales_email";
		//}
		if(type.equals("PI")){
			columnName="Product_id";
		}

		out.println("<form name='editDelete'>");
		//out.println(search+"<-- search<BR>");
		//out.println(type+"<--type<bR>");
		out.println("<table border='1'><tr><td><font color='3333CC'>Rep #</font></td><td><font color='3333CC'>Product Id</font></td><td><font color='3333CC'>Contact Name</font></td><td><font color='3333CC'>Contact Email</font></td><td><font color='3333CC'>Optio Email</font></td><td><font color='3333CC'>Sample Email</font></td></tr>");
		int a=0;
		if(!(type.equals("NA")) && columnName.trim().length()>0){
			ResultSet rs=stmt.executeQuery("Select rep_no,contact_name,contact_email,product_id,optio_email,prod_sample_contact from cs_sbu_contacts where "+columnName+" like '"+search+"' order by rep_no,product_id");
			if(rs != null){
				while(rs.next()){
								out.println("<tr><td>"+rs.getString(1)+"</td>");
											out.println("<td>"+rs.getString(4)+"</td>");
					out.println("<td>"+rs.getString(2)+"</td>");
					out.println("<td>"+rs.getString(3)+"</td>");
					out.println("<td>"+rs.getString(5)+"</td>");
					out.println("<td>"+rs.getString(6)+"</td>");
					//out.println("<td>"+rs.getString(7)+"</td>");
					String url1="sbu_contact_maint_edit.jsp?rn="+rs.getString(1)+"&cn="+rs.getString(2)+"&ce="+rs.getString(3)+"&pi="+rs.getString(4)+"&oe="+rs.getString(5)+"&sample="+rs.getString(6)+"&cmd="+search+"&type="+type+"&group1="+group1;
					String url2="sbu_contact_maint_delete.jsp?rn="+rs.getString(1)+"&cn="+rs.getString(2)+"&ce="+rs.getString(3)+"&pi="+rs.getString(4)+"&cmd="+search+"&type="+type+"&group1="+group1;
					out.println("<input type='hidden' name='url1"+a+"' value='"+url1+"'>");
					out.println("<input type='hidden' name='url2"+a+"' value='"+url2+"'>");
		%>
	<td><input type='button' value='Edit' onclick="javascript:editThis(document.editDelete.url1<%= a%>.value)" class='button'></td>
		<%
					out.println("<td><input type='button' value='Delete' onclick='javascript:deleteThis(document.editDelete.url2"+a+".value)' class='button'></td>");
					out.println("</tr>");
					a++;
				}
			}
			rs.close();
		}
		out.println("</form>");
		out.println("<form name='addProduct'action='sbu_contact_maint_add.jsp' onsubmit='return checkThis()'>");
		out.println("<input type='hidden' name='cmd' value='"+search+"'>");
		out.println("<input type='hidden' name='type' value='"+type+"'>");
		out.println("<input type='hidden' name='group1' value='"+group1+"'>");
		out.println("<tr><td><input type='text' name='repNo' size='20'></td>");
		out.println("<td><input type='text' name='productId' size='3'></td>");
		out.println("<td><input type='text' name='contactName' size='3'></td>");
		out.println("<td><input type='text' name='contactEmail' size='40'></td>");
		out.println("<td><input type='text' name='optio_email' size='40'></td>");
		//out.println("<td><input type='text' name='sales_email' size='40'></td>");
		out.println("<td><input type='text' name='sample_email' size='40'></td>");
		out.println("<td><input type='submit' value='Add' class='button'></td></tr>");
		out.println("</table>");
		out.println("</form>");
		stmt.close();
		myConn.close();
		%>
</body>
</html>
<%
}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>