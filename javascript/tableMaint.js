function selectTable(){
	var strURL="selectRows.jsp";
	var req=new XMLHttpRequest();
	var handlerFunction=getReadyStateHandler(req,updateRows);
	req.onreadystatechange=handlerFunction;
	req.open("POST",strURL,true);
	req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	var form=document.forms['form1'];
	var values='&tableName='+escape(document.form1.tableName.value);
	req.send(values);
}
function updateRows(searchXML){
	tableResults.style.visibility='hidden';
	loadingResults.style.visibility='visible';
	var count=searchXML.getElementsByTagName("columnNames").length;
	document.form1.rowcount.value=count;
	var html="<form name='form2'><table border='1' width='100%'>";
	html=html+"<tr><td><input type='button' class='button' value='submit' onclick='getValues()'></td>";
	for(var i=0;i<count;i++){
		html=html+"<td>";
		var temp="f"+i;
		var tempFilter="";
		html=html+"<input type='text' class='shortText' name='searchParam' value=''>";
		html=html+"</td>";
	}
	html=html+"</tr>";
	html=html+"<tr><td>&nbsp;</td>";
	for(var i=0;i<count;i++){
		html=html+"<td>";
		html=html+searchXML.getElementsByTagName("columnNames")[i].childNodes[0].nodeValue;
		html=html+"<BR><font size='1'>Is nullable:"+searchXML.getElementsByTagName("isNullable")[i].childNodes[0].nodeValue;
		html=html+"<BR>Datatype:"+searchXML.getElementsByTagName("dataType")[i].childNodes[0].nodeValue;
		html=html+"</font></td>";
	}
	html=html+"</tr>";
	document.form1.html.value=html;
	getValues();
}
function getValues(){
	tableResults.style.visibility='hidden';
	loadingResults.style.visibility='visible';
	var strURL="getRows.jsp";
	var req=new XMLHttpRequest();
	var handlerFunction=getReadyStateHandler(req,getRows);
	req.onreadystatechange=handlerFunction;
	req.open("POST",strURL,true);
	req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	var values='&tableName='+escape(document.form1.tableName.value);
	if(document.form1.rowcount.value.length>0){
		var count=document.form1.rowcount.value;
		//alert(count);
		values=values+"&count="+count;
		if(count>1){
			for(var i=0;i<count;i++){
				if(document.form2.searchParam!=undefined&&document.form2.searchParam[i].value!=null){
					values=values+"&value"+i+"="+escape(document.form2.searchParam[i].value);
				}
			}
		}
	}
	req.send(values);
}
function getRows(searchXML){
	//alert("a");
	var count=searchXML.getElementsByTagName("searchresult").length;
	var count2=searchXML.getElementsByTagName("f0").length;
	//alert(count2);
	var rowcount=document.form1.rowcount.value;
	var html=document.form1.html.value;
	for(var i=0;i<count;i++){

		html=html+"<tr><td><input type='button' class='button' name='edit' value='edit' onclick='editRow("+i+")'><BR><input type='button' class='button' name='delete' value='delete' onclick='deleteRow("+i+")'>";
		for(var y=0;y<rowcount;y++){
			var temp="resultvalue"+y;
			html=html+"<td><input type='text' name='val"+y+"'' id='"+i+"val"+y+"' value='"+searchXML.getElementsByTagName(temp)[i].childNodes[0].nodeValue.replace("#","")+"'>"+"</td>";
		}
		html=html+"</tr>";
	}
	//alert("g");
	document.getElementById("tableResults").innerHTML="";
	var newdiv=document.createElement("div");
	newdiv.innerHTML=html;
	var result=document.getElementById("tableResults");
	result.appendChild(newdiv);
	//alert(rowcount);
	for(var i=0;i<rowcount;i++){
		if(document.form2.searchParam!=undefined){
			var temp="f"+i;
			var tempFilter=searchXML.getElementsByTagName(temp)[0].childNodes[0].nodeValue.replace("#","");
			document.form2.searchParam[i].value=tempFilter;
		}
	}
	tableResults.style.visibility='visible';
	loadingResults.style.visibility='hidden';
	//alert("z");
}
function editRow(rowNo){
	var rowcount=document.form1.rowcount.value;
	//alert(rowNo+":::"+rowcount);
	var strURL="editRow.jsp";
	var req=new XMLHttpRequest();
	var handlerFunction=getReadyStateHandler(req,editRow2);
	req.onreadystatechange=handlerFunction;
	req.open("POST",strURL,true);
	req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
	var values="&tableName="+escape(document.form1.tableName.value);
	var tempValues=new Array();
	for(var i=0;i<rowcount;i++){
		var tempId=rowNo+"val"+i;
		//alert(tempId);
		//alert(document.getElementById(tempId).value);
		//values=values+"&val="+document.getElementById(tempId).value;
		tempValues[i]=document.getElementById(tempId).value;
	}

	values=values+"&val="+tempValues;
	alert(values);
	req.send(values);
}
function editRow2(searchXML){

}
