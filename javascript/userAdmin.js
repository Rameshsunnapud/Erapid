function setPullDowns(){
	var temp=document.form1.tempStyleSheet.value;
	//alert(temp);
	if(temp==null||temp.length==0){
		temp="styleMain.css";
	}
	//alert(temp);
	document.form1.styleSheet.value=temp;
	document.form1.state.value=document.form1.tempState.value;
	//alert("done");
}
function saveUser(){
	var params="";
	params="&repNo="+document.form1.repNo.value;
	params=params+"&repName="+document.form1.repName.value;
	params=params+"&repId="+document.form1.repId.value;
	params=params+"&repAccount="+document.form1.repAccount.value;
	params=params+"&styleSheet="+document.form1.styleSheet.value;
	params=params+"&address1="+document.form1.address1.value;
	params=params+"&address2="+document.form1.address2.value;
	params=params+"&city="+document.form1.city.value;
	params=params+"&state="+document.form1.state.value;
	params=params+"&telephone="+document.form1.telephone.value;
	params=params+"&fax="+document.form1.fax.value;
	params=params+"&email="+document.form1.email.value;
	params=params+"&zip="+document.form1.zip.value;
	//alert(params);
	var strURL="userAdminSave.jsp";
	var req=new XMLHttpRequest();
	var handlerFunction=getReadyStateHandler(req,saveUser2);
	req.onreadystatechange=handlerFunction;
	req.open("POST",strURL,true);
	req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	req.send(params);
}
function saveUser2(searchXML){
	opener.location.reload(true);
	location.reload();
}
function cancel(){
	//alert("cancel");
	window.close();
}