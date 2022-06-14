function closex(){
	window.parent.postMessage("architectClose","*");
}
function getArchitects(){
	document.getElementById("resultx").innerHTML="";
	var newdiv=document.createElement("div");
	newdiv.style.top=250;
	newdiv.innerHTML="<center><font color='red' size='4'>LOADING....</font></center>";
	var result=document.getElementById("resultx");
	result.appendChild(newdiv);


	var strURL="getArchitects.jsp";
	var req=new XMLHttpRequest();
	var handlerFunction=getReadyStateHandler(req,updateArchitects);
	//alert("1");
	req.onreadystatechange=handlerFunction;
	req.open("POST",strURL,true);
	req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	//alert("2");
	var form=document.forms['form1'];
	var values='&name='+escape(form.name.value);
	values=values+'&city='+escape(form.city.value);
	values=values+'&state='+escape(form.state.value);
	req.send(values);
}
function updateArchitects(searchXML){
	//alert("done");
	var count=searchXML.getElementsByTagName("name").length;
	var buttons="<table width='100%' border='0' CELLPADDING='0' CELLSPACING='0'><tr class='header1'><td width='25%'>Name</td><td width='25%'>City</td><td width='25%'>State</td><td width='25%'>Zip</td></tr>";
	for(var i=0;i<count;i++){
		var TEMPname=searchXML.getElementsByTagName("name")[i].childNodes[0].nodeValue;
		TEMPname=TEMPname.replace("#","");
		var TEMPcity=searchXML.getElementsByTagName("city")[i].childNodes[0].nodeValue;
		TEMPcity=TEMPcity.replace("#","");
		var TEMPstate=searchXML.getElementsByTagName("state")[i].childNodes[0].nodeValue;
		TEMPstate=TEMPstate.replace("#","");
		var TEMPzip=searchXML.getElementsByTagName("zip")[i].childNodes[0].nodeValue;
		TEMPzip=TEMPzip.replace("#","");

		var TEMPnamex=TEMPname.replace(/ /g,"#")+"^^"+TEMPcity.replace(/ /g,"#");
		buttons=buttons+"<tr><td><input type='button' class='button' name='name' value='"+TEMPname+"' onclick=test('"+TEMPnamex+"')></td>";
		buttons=buttons+"<Td>"+TEMPcity+"</td>";
		buttons=buttons+"<Td>"+TEMPstate+"</td>";
		buttons=buttons+"<Td>"+TEMPzip+"</td>";
		buttons=buttons+"</tr>";
	}
	buttons=buttons+"</table>";
	//alert(buttons);
	document.getElementById("resultx").innerHTML="";
	var newdiv=document.createElement("div");
	newdiv.style.top=250;
	newdiv.innerHTML=buttons;
	var result=document.getElementById("resultx");
	result.appendChild(newdiv);
}
function test(x){
	//alert("hERE");
	var msg="architect--"+x;
	//alert(msg);
	window.parent.postMessage(msg,"*");
	//alert("done");
}

