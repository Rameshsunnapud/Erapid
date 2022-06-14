<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<%
//if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
//        erapidBean.setServerName("server1");
//}
try{

%>
<%@ page language="java" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" errorPage="error.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
	function popUpx2(){
		goPDF();
	}
	function goPDF(){
		if(document.form1x.count.value>0){
			//alert("match found");
			var theurl;
			var theurl="pdfInitOWS.jsp";
			var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=50,height=50';
			myWindow=window.open(theurl,'myWindow',props);
			if(window.myWindow){
				if(myWindow&&typeof (myWindow.closed)!='unknown'&&!myWindow.closed){
					setTimeout("checkWindow();",1000);
				}
				else{
					setTimeout("checkWindow();",1000);
				}
			}
			else{
				setTimeout("checkWindow();",1000);
			}
		}
		else{
			alert("there is no quote to match the entered number");
			window.close();
		}
	}
	function checkWindow(){
		if(window.myWindow){
			if(myWindow&&typeof (myWindow.closed)!='unknown'&&!myWindow.closed){
				if((document.form1x.product.value=="IWP"||document.form1x.product.value=="EFS"||document.form1x.product.value=="EJC")){
					myWindow.form1.url1.value=document.form1x.workcopylink.value;
					myWindow.form1.url2.value=document.form1x.repworkcopylink.value;
				}
				myWindow.form1.url3.value=document.form1x.owslink.value;
				myWindow.form1.order_no.value=document.form1x.order_no.value;
				//document.form1x.submit();
				window.close();
				//alert("DONE");
			}
			else{
				setTimeout("checkWindow();",1000);
			}
		}
		else{
			setTimeout("checkWindow();",1000);
		}
	}
</script>
<%@ include file="../../../db_con.jsp"%>
<%
String order_no = request.getParameter("order_no");
String rep_no = request.getParameter("rep_no");
//out.println(order_no+"::"+rep_no);
out.println("<body onload='popUpx2()'>");
out.println("<form name='form1x' action='order_transfer.jsp' method='post'>");
String project_type="";
String product="";
String quote_type="";
int count=0;
ResultSet rs1=stmt.executeQuery("select project_type,product_id,quote_type from cs_project where order_no='"+order_no+"'");
if(rs1 != null){
	while(rs1.next()){
		project_type=rs1.getString(1);
		product=rs1.getString(2);
		quote_type=rs1.getString("quote_type");
		count++;
	}
}
rs1.close();
stmt.close();
myConn.close();
out.println("<input type='text' name='order_no' value='"+order_no+"'>");
out.println("<input type='text' name='product' value='"+product+"'>");
out.println("<input type='text' name='count' value='"+count+"'>");
if(project_type != null && project_type.equals("PSA")){
%>
<input type='hidden' name='workcopylink' value='https://<%=application.getInitParameter("HOST")%>/erapid/us/reports/work_copy_home_psa.jsp?orderNo=<%=order_no%>'>
<%
}
else{
%>
<input type='hidden' name='workcopylink' value=''>
<%
}
%>
<input type='hidden' name='repworkcopylink' value='https://<%=application.getInitParameter("HOST")%>/erapid/us/reports/work_copy_home.jsp?orderNo=<%=order_no%>'>
<%
if(quote_type !=null && quote_type.toUpperCase().equals("O")){
%>
<input type='hidden' name='owslink' value='https://<%= application.getInitParameter("HOST")%>/erapid/us/orders/ows/order_sheet.jsp?sections=all&orderNo=<%= order_no %>&rep_no=<%= rep_no %>'>
<%
}
else{
%>
<input type='hidden' name='owslink' value=''>
<%
}
%>
</body>
<%
}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>
