<% request.setCharacterEncoding( response.getCharacterEncoding() ); %>
<%@ page language="java" import="java.text.*" import="java.util.*" import="java.io.*"  contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="error.jsp" %>

<%@ include file="header.jsp"%>
<div id='container' class='container'>
<div class="mainbody">  

<script language="JavaScript" src="../javascript/ajax.js"></script>
<script language="Javascript">

function changeSearch(strURL){    
	var req = new XMLHttpRequest();
	var handlerFunction=getReadyStateHandler(req,updateSearch); 
	req.onreadystatechange=handlerFunction; 
	req.open("POST",strURL,true);    
	req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	var form = document.forms['form1'];  
	var values= 'product='+escape(form.product_id.value)+'&repNo='+escape(form.repNo.value)+'&orderNo='+escape(form.orderNo.value)+'&archName='+escape(form.archName.value)+'&orderDate='+escape(form.orderDate.value)+'&custLoc='+escape(form.custLoc.value)+'&projectName='+escape(form.projectName.value)+'&quoteType='+escape(form.quoteType.value); 
	req.send(values);
}
function updateSearch(searchXML){
	var results=" <table border='0' width='1180px;'><tr class='header1'><td width='10%'>Order Number</td><td width='40%'>Project Name</td><td width='10%'>Customer Name</td><td width='10%'>Creator Id</td><td>Configured Price</td><td>Created By</td><td>Created On</td></tr>";
	var count=searchXML.getElementsByTagName("orderNo").length;
	for(var i=0; i<count; i++){  
		var orderNo= searchXML.getElementsByTagName("orderNo")[i].childNodes[0].nodeValue;		
		var projectName= searchXML.getElementsByTagName("projectName")[i].childNodes[0].nodeValue;
		var custName= searchXML.getElementsByTagName("custName")[i].childNodes[0].nodeValue;
		var creatorId= searchXML.getElementsByTagName("creatorId")[i].childNodes[0].nodeValue;
		var configuredPrice= searchXML.getElementsByTagName("configuredPrice")[i].childNodes[0].nodeValue;
		var createdBy= searchXML.getElementsByTagName("createdBy")[i].childNodes[0].nodeValue;
		var createdOn= searchXML.getElementsByTagName("createdOn")[i].childNodes[0].nodeValue;
		if(orderNo==null){
			orderNo="";  
		}
		if(projectName==null){
			projectName="";
		}	
		if(custName==null){
			custName=""; 
		}
		if(creatorId==null){
			creatorId="";
		}
		if(configuredPrice==null){
			configuredPrice="";
		}
		if(createdBy==null){
			createdBy="";
		}
		if(createdOn==null){
			createdOn=""; 
		}	
		var cssClass="rowodd";
		if(i%2==0){
			cssClass="roweven";
		}
		results=results+"<tr class='"+cssClass+"'><td><input type='button' name='orderNo' value='"+orderNo+"' class='button' onclick=doThis('"+orderNo+"')></td><td>"+projectName+"</td><td>"+custName+"</td><td>"+creatorId+"</td><td>"+configuredPrice+"</td><td>"+createdBy+"</td><td>"+createdOn+"</td></tr>";
	}
	results=results+"</table>";
	//alert(results);
	document.getElementById("result").innerHTML = "";
	var newdiv = document.createElement("div");
	//newdiv.style.position="absolute";
	newdiv.style.top=250;
	newdiv.innerHTML = results;
	var result = document.getElementById("result");
	result.appendChild(newdiv);
}
function doThis(x){
	document.form1.orderNox.value=x;
	document.form1.submit();
}
</script>
<body onload=JavaScript:changeSearch('searchBean.jsp')>
<!--<table border='1' width='100%'><tr><td>--> 
<!--onload=JavaScript:changeSearch('searchBean.jsp')>-->
<form name='form1' action='lineItem.jsp' method='post'>
<input type='hidden' name='orderNox'>   
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

if(how.equals("archName")){
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
else{
	orderNo=search;
}
String select="";
out.println("<BR><BR><table width='1180px;' border='0'>");
out.println("<tr><td>Product</td>");
out.println("<td><select name='product_id' onchange=JavaScript:changeSearch('searchBean.jsp')>");
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
<td>Order No</td><td><input type='text' name='orderNo' value='<%=orderNo%>' onkeyup='JavaScript:changeSearch("searchBean.jsp")' class='text'></td>
<td>Order Date</td><td><input type='text' name='orderDate' value='<%=orderDate%>' onkeyup='JavaScript:changeSearch("searchBean.jsp")' class='text'></td>
</tr>
<tr>
<td>Customer Location</td><td><input type='text' name='custLoc' value='<%=custLoc%>' onkeyup='JavaScript:changeSearch("searchBean.jsp")' class='text'></td>
<td>Project Name</td><td><input type='text' name='projectName' value='<%=projectName%>' onkeyup='JavaScript:changeSearch("searchBean.jsp")' class='text'></td>
<td>Architect Location</td><td><input type='text' name='archName' value='<%=archName%>' onkeyup='JavaScript:changeSearch("searchBean.jsp")' class='text'></td>
</tr>
<tr>
<%
if(userSession.getGroup().startsWith("Poland")||userSession.getGroup().startsWith("PL_FISAW")){
	out.println("<td>Rep No</td><td><select name='repNo' onchange=JavaScript:changeSearch('searchBean.jsp')>");
	out.println("<option value=''></option>");
	for(int i=0; i<reps.length; i++){
		if(reps[i].equals(repNo)){
			select="selected";
		}
		out.println("<option value='"+reps[i]+"' "+select+">"+repsNames[i]+"--"+reps[i]+"</option>");
	}
	out.println("</select></td>");
}
else{
	out.println("<input type='hidden' name='repNo' value='"+userSession.getRepNo()+"'>");
}
out.println("<td>Order Type</td>");
out.println("<td><select name='quoteType' onchange=JavaScript:changeSearch('searchBean.jsp')>");
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
<tr><td>&nbsp;<br><BR><BR></td></tr>
</div>
</table>
<div id="result"></div>
</div>
</body>
</html>