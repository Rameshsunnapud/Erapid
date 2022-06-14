function sendEmailx(){
	var params="";
	params=params+"&orderNo="+document.form1.orderNo.value;

	//alert(urlTemp);
	//alert(document.emailForm.url.length);
	if(document.emailForm.url.value==""){
		document.emailForm.url.selectedIndex=1;
	}
	var urlLength=document.emailForm.url.value;
	var urlTemp=document.form1.fullServerName.value+"/erapid/us/"+document.emailForm.url.value+"!action=pdf";
	//alert(urlTemp);
	urlTemp=urlTemp.replace("#bpcsNo#",document.form1.bpcsNo.value);
	urlTemp=urlTemp.replace("#username#",document.form1.userId.value);
	urlTemp=urlTemp.replace("#repQuote#",document.form1.repQuote.value);
	urlTemp=urlTemp.replace("#group#",document.form1.group.value);
	params=params+"&url="+urlTemp;
	params=params+"&from="+document.emailForm.from.value;
	params=params+"&to="+document.emailForm.to.value;
	params=params+"&cc="+document.emailForm.cc.value;
	params=params+"&bcc="+document.emailForm.bcc.value;
	params=params+"&bcc2="+document.emailForm.bcc2.value;
	params=params+"&message="+escape(document.emailForm.message.value);
	params=params+"&dirname="+document.emailForm.dirname.value;
	params=params+"&attachfiles="+document.emailForm.attachfiles.value;
	params=params+"&productId="+document.form1.product.value;
	params=params+"&repNum="+document.form1.userRepNo.value;
	params=params+"&userId="+document.form1.userId.value;
	//alert(urlTemp);
	if(document.emailForm.url.length>0){
		var strURL=document.form1.url10.value;
		var req=new XMLHttpRequest();
		var handlerFunction=getReadyStateHandler(req,emailResult);
		req.onreadystatechange=handlerFunction;
		req.open("POST",strURL,true);

		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		params=convertPL(params);
		req.send(params);
	}
	else{
		alert("You must select a quote to be attached");
	}
}
function emailResult(searchXML){
	var count=searchXML.getElementsByTagName("emailResult2").length;
	var buttons="";
	for(var i=0;i<count;i++){
		var TEMPresult=searchXML.getElementsByTagName("result")[i].childNodes[0].nodeValue;
		var TEMPresult=TEMPresult.replace("#","");
		if(TEMPresult=="EMAIL SENT"){
			alert("EMAIL SENT");
		}
		else{
			alert(TEMPresult);
		}
		if(TEMPresult=="EMAIL SENT"){
			mailDiv.style.visibility='hidden';
			if((document.form1.product.value=="LVR"||document.form1.product.value=="GRILLE")&&document.form1.group.value.toUpperCase().indexOf("REP")<0){
				editPrice();
			}
			else if((document.form1.product.value=="LVR"||document.form1.product.value=="GRILLE")&&document.form1.group.value.toUpperCase().indexOf("REP")>=0&&document.form1.creatorGroup.value.toUpperCase().indexOf("REP")<0){
				editPrice();
			}
			else{
				pricecalc2.style.visibility='visible';
				buttonsDiv.style.visibility='visible';
			}

		}
	}

}
function changeCopyMe(){
	//alert(document.emailForm.from.value);
	if(document.emailForm.copyMe.checked==true){
		document.emailForm.bcc2.value=document.emailForm.from.value;
	}
	else{
		document.emailForm.bcc2.value="";
	}
}