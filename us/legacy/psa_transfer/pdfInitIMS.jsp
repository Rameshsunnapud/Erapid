<SCRIPT language="JavaScript">
	function doThis(){

		if(document.form1.url3.value.length>0&&document.form1.order_no.value.length>0){
			alert(document.form1.url3.value+"::"+document.form1.type.value);
			document.form1.submit();
		}
		else{
			setTimeout("doThis();",1000);
		}
	}


</script>


<html>
	<body onload='doThis()'>
		<font size='2' color='red'>Please do not close this window.  It will close itself when it is finished.</font><BR>
		<form name='form1' action='pdfIMS.jsp' method='post'>
			<input type='text' name='order_no' value=''>
			<input type='text' name='type' value=''>
			<input type='text' name='url3' value=''>
			<input type='text' name='isLandscape' value=''>

		</form>

</html>