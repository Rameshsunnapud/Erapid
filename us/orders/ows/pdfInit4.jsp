<SCRIPT language="JavaScript">
function doThis(){

	if(document.form1.url.value.length>0){
		document.form1.submit();
	}
	else{
		setTimeout("doThis();",1000);
	}
}


</script>
 

<html>
<body onload='doThis()'>
<form name='form1' action='pdf4.jsp' method='post'>
<input type='text' name='order_no' value=''>
<input type='text' name='url' value=''>

</form>

</html>   