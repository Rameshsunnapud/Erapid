function setTypes(){

	var messageTypeUSTemp=document.form1.messageTypeUSTemp.value;

	document.form1.messageTypeUS.value=messageTypeUSTemp;
}
function saveMessage2(){
	var params="";
	var strURL=document.form1.urlErapidBean.value;
	var req=new XMLHttpRequest();
	var handlerFunction=getReadyStateHandler(req,saveMessage3);
	req.onreadystatechange=handlerFunction;
	req.open("POST",strURL,true);
	req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	req.send(params);
}
function saveMessage3(){
	alert("saved");
}
function saveMessage(){
	var params="";
	params=params+"&messageUS="+document.form1.messageUS.value
	params=params+"&messageTypeUS="+document.form1.messageTypeUS.value
	var strURL=document.form1.urlSaveMessage.value;
	var req=new XMLHttpRequest();
	var handlerFunction=getReadyStateHandler(req,saveMessage2);
	req.onreadystatechange=handlerFunction;
	req.open("POST",strURL,true);
	req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	params=convertPL(params);
	req.send(params);
	//alert(strURL);
}
