<% request.setCharacterEncoding( response.getCharacterEncoding() ); %>
<%@ page language="java" import="java.text.*" import="java.util.*" import="java.io.*"  contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="error.jsp" %>
<%@ include file="header.jsp"%>
<div class="mainbody">
<script language="JavaScript" src="../javascript/ajax.js"></script>
<script language="Javascript">
function xmlhttpPost(strURL) {
///	alert("HERE1");
	var xmlHttpReq = false;
	var self = this;
	// Mozilla/Safari
	if (window.XMLHttpRequest) {
		self.xmlHttpReq = new XMLHttpRequest();
	}
	// IE
	else if (window.ActiveXObject) {
		self.xmlHttpReq = new ActiveXObject("Microsoft.XMLHTTP");
	}
	self.xmlHttpReq.open('POST', strURL, true);
	self.xmlHttpReq.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
	//alert("HERE2");
	self.xmlHttpReq.onreadystatechange = function() {
		if (self.xmlHttpReq.readyState == 4) {
			//alert("HERE3");
			updatepage(self.xmlHttpReq.responseText);			
		}
	}
	//alert("HERE5");
	self.xmlHttpReq.send(getquerystring());
	//alert("HERE6");
}

function getquerystring() {
	var form = document.forms['form1'];
	//alert("1");
	qstr = 'product='+escape(form.product_id.value)+'&repNo='+escape(form.repNo.value)+'&orderNo='+escape(form.orderNo.value)+'&archName='+escape(form.archName.value)+'&orderDate='+escape(form.orderDate.value)+'&custLoc='+escape(form.custLoc.value)+'&projectName='+escape(form.projectName.value)+'&quoteType='+escape(form.quoteType.value); 
	//alert("2");
	return qstr;
}
function updatepage(str){
	document.getElementById("result").innerHTML = str;
}
</script>
<body onload=JavaScript:xmlhttpPost('searchBean.jsp')>
<form name='form1'>
<%
String[] products=userSession.getProducts();
String[] productsDescription=userSession.getProductsDescription();
String[] reps=userSession.getReps();
String[] repsNames=userSession.getRepsNames();
String byType[]={"quotes","orders","budget","lost","all"};
String byName[]={"Aktywne","Zam&#243;wienia","Bud&#380;etowe","Niezrealizowane","Wszystkie"};
String product=request.getParameter("product");
String by=request.getParameter("by");
String how=request.getParameter("how");
String orderNo="";
String orderDate="";
String custLoc="";
String projectName="";
String archName="";
String repNo=request.getParameter("repNum");
String search=request.getParameter("search");
if(how.equals("orderNo")){
	orderNo=search;
}
else if(how.equals("archName")){
	archName=search;
}
else if(how.equals("date")){
	orderDate=search;
}
else if(how.equals("projectName")){
	projectName=search;
}
else if(how.equals("custLoc")){
	custLoc=search;
}
String select="";
out.println("<table width='100%'>");
out.println("<tr><td>Product</td>");
out.println("<td><select name='product_id' onchange=JavaScript:xmlhttpPost('searchBean.jsp')>");
out.println("<option value=''></option>");
for (int ik=0; ik<products.length;ik++){
	if(products[ik].equals(product)){
		select="selected";
	}
	out.println("<option value='"+products[ik]+"' "+select+">"+productsDescription[ik]+" </option>");
	select="";
}
out.println("</select></td>");
%>
<td>Order No</td><td><input type='text' name='orderNo' value='<%=orderNo%>' onkeyup='JavaScript:xmlhttpPost("searchBean.jsp")'></td>
<td>Order Date</td><td><input type='text' name='orderDate' value='<%=orderDate%>' onkeyup='JavaScript:xmlhttpPost("searchBean.jsp")'></td>
<td>Customer Location</td><td><input type='text' name='custLoc' value='<%=custLoc%>' onkeyup='JavaScript:xmlhttpPost("searchBean.jsp")'></td>
</tr>
<tr>
<td>Project Name</td><td><input type='text' name='projectName' value='<%=projectName%>' onkeyup='JavaScript:xmlhttpPost("searchBean.jsp")'></td>
<td>Architect Location</td><td><input type='text' name='archName' value='<%=archName%>' onkeyup='JavaScript:xmlhttpPost("searchBean.jsp")'></td>
<td>Rep No</td>
<%
out.println("<td><select name='repNo' onchange=JavaScript:xmlhttpPost('searchBean.jsp')>");
out.println("<option value=''></option>");
for(int i=0; i<reps.length; i++){
	if(reps[i].equals(repNo)){
		select="selected";
	}
	out.println("<option value='"+reps[i]+"' "+select+">"+repsNames[i]+"--"+reps[i]+"</option>");
}
out.println("</select></td>");
out.println("<td>Order Type</td>");
out.println("<td><select name='quoteType' onchange=JavaScript:xmlhttpPost('searchBean.jsp')>");
out.println("<option value=''></option>");
for(int i=0; i<byType.length; i++){
	if(byType[i].equals(by)){
		select="selected"; 
	}
	out.println("<option value='"+byType[i]+"' "+select+">"+byName[i]+"</option>");
}
out.println("</select></td></tr>");
%>
</form>
</div>
<BR><BR><BR><BR><BR>
<div id="result"></div>
</body>
</html>