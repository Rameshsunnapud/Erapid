<SCRIPT language="JavaScript">
function doThis(){

	if(document.form1.url.value.length>0){
		//alert("here");
		//alert("HERE");
		document.form1.submit();
	}
	else{
		//alert("nope");
		setTimeout("doThis();",1000);
	}
}


</script>


<html>
<body onload='doThis()'>
<form name='form1' action='https://<%= application.getInitParameter("HOST")%>/custom/quotes/convertor/convertor.jsp' method='post'>
<input type='text' name='order_no' value=''>
<input type='text' name='url' value=''>
<input type='text' name='output' value='RTF'>
<input type='text' name='isHeader' value=''>
<input type='text' name='isFooter' value=''>
<input type='text' name='country' value=''>
<input type='text' name='displaypage' value='n'>
</form>

</html>   