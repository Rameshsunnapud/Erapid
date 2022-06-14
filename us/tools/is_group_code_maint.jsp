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
		<title>IS Group Codes</title>
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
		out.println("<form name='searchForm' action='is_group_code_maint.jsp'>");
		out.println("<table><TR><td></td><TD><input type='text' name='cmd'></td>");
		out.println("<td><select name='type'>");
		out.println("<option value='CD'><font color='3333CC'>Description</option>");
		out.println("<option value='CO'><font color='3333CC'>Company</option>");
		out.println("<option value='RE'><font color='3333CC'>Region</option>");
		out.println("<option value='HQ'><font color='3333CC'>Headquarters</option>");
		out.println("<option value='CC'><font color='3333CC'>Code</option>");
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
		if(type.equals("CD")){
			columnName="CCDESC";
		}
		if(type.equals("CO")){
			columnName="COMPANIES";
		}
		if(type.equals("RE")){
			columnName="REGION";
		}
		if(type.equals("HQ")){
			columnName="HDQTS";
		}
		if(type.equals("CC")){
			columnName="CCODE";
		}

		out.println("<form name='editDelete'>");
		//out.println(search+"<-- search<BR>");
		//out.println(type+"<--type<bR>");
		out.println("<table border='1'><tr><td><font color='3333CC'>Description</font></td><td><font color='3333CC'>Companies</font></td><td><font color='3333CC'>Region</font></td><td><font color='3333CC'>Notes</font></td><td><font color='3333CC'>Headquarters</font></td><td><font color='3333CC'>Customer Number</font></td><td><font color='3333CC'>CCode</font></td></tr>");
		int a=0;
		if(!(type.equals("NA")) && columnName.trim().length()>0){
			ResultSet rs=stmt.executeQuery("Select CCDESC,COMPANIES,REGION,NOTES,HDQTS,CUST_SHIPPING_NO,CCODE from cs_ge_group_codes where "+columnName+" like '"+search+"' order by CCDESC,REGION");
			if(rs != null){
				while(rs.next()){
								out.println("<tr><td>"+rs.getString(1)+"</td>");
											out.println("<td>"+rs.getString(2)+"</td>");
					out.println("<td>"+rs.getString(3)+"</td>");
                                        out.println("<td>"+rs.getString(4)+"</td>");
					out.println("<td>"+rs.getString(5)+"</td>");
					out.println("<td>"+rs.getString(6)+"</td>");
					out.println("<td>"+rs.getString(7)+"</td>");
					String url1="is_group_code_maint_edit.jsp?cd="+rs.getString(1)+"&co="+rs.getString(2)+"&re="+rs.getString(3)+"&no="+rs.getString(4)+"&hq="+rs.getString(5)+"&cs="+rs.getString(6)+"&cc="+rs.getString(7)+"&type="+type+"&group1="+group1;
					String url2="is_group_code_maint_delete.jsp?cd="+rs.getString(1)+"&co="+rs.getString(2)+"&re="+rs.getString(3)+"&no="+rs.getString(4)+"&hq="+rs.getString(5)+"&cs="+rs.getString(6)+"&cc="+rs.getString(7)+"&type="+type+"&group1="+group1;
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
		out.println("<form name='addProduct'action='is_group_code_maint_add.jsp' onsubmit='return checkThis()'>");
		out.println("<input type='hidden' name='cmd' value='"+search+"'>");
		out.println("<input type='hidden' name='type' value='"+type+"'>");
		out.println("<input type='hidden' name='group1' value='"+group1+"'>");
		out.println("<tr><td><input type='text' name='CCDESC' size='30'></td>");
		out.println("<td><input type='text' name='COMPANIES' size='15'></td>");
		out.println("<td><input type='text' name='REGION' size='4'></td>");
		out.println("<td><input type='text' name='NOTES' size='30'></td>");
		out.println("<td><input type='text' name='HDQTS' size='4'></td>");
		out.println("<td><input type='text' name='CUST_SHIPPING_NO' size='12'></td>");
		out.println("<td><input type='text' name='CCODE' size='30'></td>");
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