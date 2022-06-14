function getContacts(custNo,countryCode){

	document.getElementById("contacts").innerHTML="";
	var newdiv=document.createElement("div");
	newdiv.innerHTML="";
	var result=document.getElementById("contacts");
	result.appendChild(newdiv);
	contactEdit.style.visibility='hidden';
	selectContact.style.visibility='hidden';
	var params="";
	params=params+"&custNo="+custNo;
	params=params+"&countryCode="+countryCode;
	var strURL="getContact.jsp";
	var req=new XMLHttpRequest();
	var handlerFunction=getReadyStateHandler(req,contactsResults);
	req.onreadystatechange=handlerFunction;
	req.open("POST",strURL,true);
	req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	params=convertPL(params);
	req.send(params);
}
function contactsResults(searchXML){
	//alert("HERE");
	var count=searchXML.getElementsByTagName("searchresult").length;
	//var results=" <table border='0' width='1180px;'><tr class='header1'><td width='25%'>Contact Name</td><td width='25%'>Contact Phone</td><td width='25%'>Contact Fax</td><td width='25%'>Contact Email</td></tr>";

	var results=" <table border='0' width='1180px;'><tr class='header1'><td width='25%'>Contact Name</td><td width='25%'>Phone</td><td width='25%'>Fax</td><td width='25%'>Email</td></tr>";
	for(var i=0;i<count;i++){
		var contactName=searchXML.getElementsByTagName("contactName")[i].childNodes[0].nodeValue;
		var contactPhone=searchXML.getElementsByTagName("contactPhone")[i].childNodes[0].nodeValue;
		var contactFax=searchXML.getElementsByTagName("contactFax")[i].childNodes[0].nodeValue;
		var contactEmail=searchXML.getElementsByTagName("contactEmail")[i].childNodes[0].nodeValue;
		var custNo=searchXML.getElementsByTagName("custNo")[i].childNodes[0].nodeValue;
		var contactNo=searchXML.getElementsByTagName("contactNo")[i].childNodes[0].nodeValue;
		var countryCode=searchXML.getElementsByTagName("countryCode")[i].childNodes[0].nodeValue;
		var contactDormant=searchXML.getElementsByTagName("contactDormant")[i].childNodes[0].nodeValue;
		contactName=contactName.replace("#","");
		contactPhone=contactPhone.replace("#","");
		contactFax=contactFax.replace("#","");
		contactEmail=contactEmail.replace("#","");
		custNo=custNo.replace("#","");
		contactNo=contactNo.replace("#","");
		countryCode=countryCode.replace("#","");
		contactDormant=contactDormant.replace("#","");
		results=results+"<tr >";
		results=results+"<td><input type='button' name='edit' value='"+contactName+"' class='button'  onclick=editContacts('"+custNo+"','"+countryCode+"','"+contactName.replace(/ /g,"xspacex")+"','"+contactPhone.replace(/ /g,"xspacex")+"','"+contactFax.replace(/ /g,"xspacex")+"','"+contactEmail.replace(/ /g,"xspacex")+"','"+contactDormant+"','"+contactNo+"')></td>";
		results=results+"<td>"+contactPhone+"</td>";
		results=results+"<td>"+contactFax+"</td>";
		results=results+"<td>"+contactEmail+"</td>";
		results=results+"</tr>";
	}
	results=results+"<tr><td colspan'5' align='left'><input type='button' name='edit' value='New Contact' class='button'  onclick=editContacts('','','','','','','','')></td>";
	results=results+"</table>";
	document.getElementById("contacts").innerHTML="";
	var newdiv=document.createElement("div");
	newdiv.innerHTML=results;
	var result=document.getElementById("contacts");
	result.appendChild(newdiv);
}
function editContacts(var1,var2,var3,var4,var5,var6,var7,var8){
	var3=var3.replace(/xspacex/g," ");
	var4=var4.replace(/xspacex/g," ");
	var5=var5.replace(/xspacex/g," ");
	var6=var6.replace(/xspacex/g," ");
	var7=var7.replace(/xspacex/g," ");
	document.editContact.custNo.value=var1;
	document.editContact.countryCode.value=var2;
	document.editContact.contactName.value=var3;
	document.editContact.contactPhone.value=var4;
	document.editContact.contactFax.value=var5;
	document.editContact.contactEmail.value=var6;
	document.editContact.contactDormant.value=var7;
	document.editContact.contactNo.value=var8;
	contactEdit.style.visibility='visible';
}
function saveContacts(){
	//alert("HERE"+contactEdit.style.visibility);
	var custNo=document.editCustomer.custNo.value;
	var contactNo=document.editContact.contactNo.value;
	var countryCode=document.editCustomer.countryCode.value;
	var contactName=document.editContact.contactName.value;
	var contactPhone=document.editContact.contactPhone.value;
	var contactFax=document.editContact.contactFax.value;
	var contactEmail=document.editContact.contactEmail.value;
	var contactDormant=document.editContact.contactDormant.checked;



	//contactPhone=contactPhone.replace(/[^\0-9]/ig,"");
	//contactPhone=contactPhone.replace(/\s/g,"");
	//var tempPhone2="";
	//for(var i=0;i<contactPhone.length;i++){
	//	tempPhone2=tempPhone2+contactPhone.substring(i,i+1);
	//	if(i%2==1&&i<contactPhone.length-1){
	//		tempPhone2=tempPhone2+" ";
	//	}
	//}
	//contactPhone=tempPhone2;
	//contactFax=contactFax.replace(/[^\0-9]/ig,"");
	//ÍcontactFax=contactFax.replace(/\s/g,"");
	//var tempFax2="";
	//for(var i=0;i<contactFax.length;i++){
	//	tempFax2=tempFax2+contactFax.substring(i,i+1);
	//	if(i%2==1&&i<contactFax.length-1){
	///		tempFax2=tempFax2+" ";
	//	}
	//}
	//contactFax=tempFax2;


	if(custNo.length==0){
		document.editCustomer.saveContactNewCustomer.value="YES";
		//saveCustomerx("");
		//alert("CHECK CUSTOMER");
		checkCustomer();
	}
	else{
		if(contactName.length>0){
			var values="&custNo="+custNo+"&countryCode="+countryCode+"&contactName="+contactName+"&contactPhone="+contactPhone+"&contactFax="+contactFax+"&contactEmail="+contactEmail+"&contactDormant="+contactDormant+"&contactNo="+contactNo;
			//alert(values);
			var req=new XMLHttpRequest();
			var handlerFunction=getReadyStateHandler(req,saveContacts2);
			req.onreadystatechange=handlerFunction;
			var strURL="saveContact.jsp";
			req.open("POST",strURL,true);
			req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			//alert(values);
			req.send(values);
		}
		else{
			alert("PLEASE ENTER CONTACT NAME");
		}
	}
}
function saveContactNewCustomer(){
	var custNo=document.editCustomer.custNo.value;
	var contactNo=document.editContact.contactNo.value;
	var countryCode=document.editCustomer.countryCode.value;
	var contactName=document.editContact.contactName.value;
	var contactPhone=document.editContact.contactPhone.value;
	var contactFax=document.editContact.contactFax.value;
	var contactEmail=document.editContact.contactEmail.value;
	var contactDormant=document.editContact.contactDormant.checked;
	if(custNo.length>0){
		editCustomerx(custNo,countryCode);
		document.editContact.contactNo.value=contactNo;
		document.editContact.contactName.value=contactName;
		document.editContact.contactPhone.value=contactPhone;
		document.editContact.contactFax.value=contactFax;
		document.editContact.contactEmail.value=contactEmail;
		contactEdit.style.visibility='visible';
		saveContacts();
	}
	else{
		alert("cust number is messed up::"+document.editCustomer.custNo.value+"::");
		saveContacts();
		//setTimeout("saveContacts();",1000);

	}
}
function saveContacts2(searchXML){
	var count=searchXML.getElementsByTagName("search").length;
	for(var i=0;i<count;i++){
		var result=searchXML.getElementsByTagName("contactResult")[i].childNodes[0].nodeValue;
		result=result.replace("#","");
		//alert(result);
	}
	var custNo=document.editCustomer.custNo.value;
	var countryCode=document.editCustomer.countryCode.value;
	getContacts(custNo,countryCode);
	contactEdit.style.visibility='hidden';
	document.editCustomer.saveContactNewCustomer.value="";

}
function closeContactEdit(){
	//alert("close contact edit");
	contactEdit.style.visibility='hidden';

}
function selectContactHeader(x){
	//alert("select contact header");
	setTimeout("selectContactHeaderInit();",1000);
	//alert("after");
}
function selectContactHeaderInit(){
	//alert("HERE");
	x=document.headerForm.custName.value;
	//alert(x);
	var custNo=x;
	var countryCode="US";
	contactEdit.style.visibility='hidden';
	selectContact.style.visibility='hidden';
	var params="";
	params=params+"&custNo="+custNo;
	params=params+"&countryCode="+countryCode;
	var strURL="getContact.jsp";
	var req=new XMLHttpRequest();
	var handlerFunction=getReadyStateHandler(req,selectCustomerHeader2);
	req.onreadystatechange=handlerFunction;
	req.open("POST",strURL,true);
	req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	params=convertPL(params);
	//alert("pause");
	req.send(params);
}
function selectCustomerHeader2(searchXML){
	//alert("selectCustomerHeader2");
	var tempContactName="";
	var tempContactPhone="";
	var tempContactEmail="";
	var tempContactNo="";
	var count=searchXML.getElementsByTagName("searchresult").length;
	//alert(count);
	var results="<table border='0' width='1180px;'><tr class='header1' ><td colspan='5'> <h3>Select a customer</h3></td></tr>";
	results=results+"<tr class='header1'><td width='25%'>Contact name</td><td width='25%'>Phone</td><td width='25%'>Fax</td><td width='25%'>Email/td></tr>";
	for(var i=0;i<count;i++){
		var contactName=searchXML.getElementsByTagName("contactName")[i].childNodes[0].nodeValue;
		tempContactName=contactName;
		var contactPhone=searchXML.getElementsByTagName("contactPhone")[i].childNodes[0].nodeValue;
		tempContactPhone=contactPhone
		var contactFax=searchXML.getElementsByTagName("contactFax")[i].childNodes[0].nodeValue;
		var contactEmail=searchXML.getElementsByTagName("contactEmail")[i].childNodes[0].nodeValue;
		tempContactEmail=contactEmail
		var custNo=searchXML.getElementsByTagName("custNo")[i].childNodes[0].nodeValue;
		var contactNo=searchXML.getElementsByTagName("contactNo")[i].childNodes[0].nodeValue;
		tempContactNo=contactNo;
		var countryCode=searchXML.getElementsByTagName("countryCode")[i].childNodes[0].nodeValue;
		var contactDormant=searchXML.getElementsByTagName("contactDormant")[i].childNodes[0].nodeValue;
		contactName=contactName.replace("#","");
		//alert("B");
		contactPhone=contactPhone.replace("#","");
		contactFax=contactFax.replace("#","");
		contactEmail=contactEmail.replace("#","");
		custNo=custNo.replace("#","");
		contactNo=contactNo.replace("#","");
		countryCode=countryCode.replace("#","");
		contactDormant=contactDormant.replace("#","");
		results=results+"<tr >";
		results=results+"<td><input type='button' name='edit' value='"+contactName+"' class='button'  onclick=selectCustomerHeader3('"+contactNo.replace(/ /g,"xspacex")+"','"+contactName.replace(/ /g,"xspacex")+"','"+contactPhone.replace(/ /g,"xspacex")+"','"+contactEmail.replace(/ /g,"xspacex")+"')></td>";
		results=results+"<td>"+contactPhone+"</td>";
		results=results+"<td>"+contactFax+"</td>";
		results=results+"<td>"+contactEmail+"</td>";
		results=results+"</tr>";
	}
	results=results+"</table>";
	//alert("after"+count);
	if(count<=1){
		//alert("HERE1");
		selectCustomerHeader3(tempContactNo,tempContactName,tempContactPhone,tempContactEmail);
		//alert("Here2");
	}
	else{
		//alert("HEREx");
		document.getElementById("customerSearchResultsHeader").innerHTML="";
		//alert("1");
		var newdiv=document.createElement("div");
		//alert("2");
		newdiv.innerHTML=results;
		//alert("3");
		var result=document.getElementById("customerSearchResultsHeader");
		//alert("4");
		result.appendChild(newdiv);
		//alert("5");
		customerTEST.style.visibility='hidden';
		//alert("6");
		customerx.style.visibility='visible';
		//alert("7");
		customerSearchResultsHeader.style.visibility='visible';
		//alert("done");
	}
	//alert("done");
}
function selectCustomerHeader3(w,x,y,z){
	//alert("select customer header3");
	customerTEST.style.visibility='visible';
	//alert(x);
	w=w.replace(/xspacex/g," ");
	w=w.replace("#","");
	x=x.replace(/xspacex/g," ");
	x=x.replace("#","");
	y=y.replace(/xspacex/g," ");
	y=y.replace("#","");
	z=z.replace(/xspacex/g," ");
	z=z.replace("#","");
	//alert("2");
	//document.headerForm.shipAttention.value=w;
	//alert("3");
	document.headerForm.agentName.value=x;
	//alert("4");
	document.headerForm.shipPhone.value=y;
	//alert("5");
	if(z.length>0){
		document.headerForm.shipName1.value=z;
	}
	//alert("6");
	customerx.style.visibility='hidden';
	//alert("7");
	customerTEST.style.visibility='hidden';
	customerSearchResultsHeader.style.visibility='hidden';
	closeCustomer();
	goHome();
}
function pause(){
	var i=0;
	for(var i=0;i<100;i++){
		i=i+1;
	}
}