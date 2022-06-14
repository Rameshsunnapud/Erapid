
function newXMLHttpRequest(){
	var xmlreq=false;
	if(window.XMLHttpRequest){
		xmlreq=new XMLHttpRequest();
	}
	else if(window.ActiveXObject){
		try{
			xmlreq=new ActiveXObject("Msxml2.XMLHTTP");
		}
		catch(e1){
			try{
				xmlreq=new ActiveXObject("Microsoft.XMLHTTP");
			}
			catch(e2){
				xmlreq=false;
			}
		}
	}
	return xmlreq;
}
function getReadyStateHandler(req,responseXmlHandler){
	//alert("H#$#'0;")
	return function(){
		if(req.readyState==4){
			if(req.status==200){
				responseXmlHandler(req.responseXML);
			}
			else{
				alert("HTTP error "+req.status+": "+req.statusText);
			}
		}
	}
}
function test(){
	alert("HREE");
	isNew();
	alert("2");
}