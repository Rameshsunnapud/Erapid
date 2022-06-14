try{
	if(window.addEventListener){
		window.addEventListener("message",function(event){
			var x=event.data;
			if(x=="architectClose"){
				architectDiv.style.visibility='hidden';
			}
			else if(x.indexOf("architect")>=0){
				x=x.substring(11);
				architectDiv.style.visibility='hidden';
				x=x.replace(/#/g," ");
				var y=x.indexOf("^^");
				document.headerForm.archName.value=x.substring(0,y);
				document.headerForm.archLoc.value=x.substring(y+2);
				document.headerForm.changeArch.value="YES";
			}
			else{
				cancelHeader();
				updateLines();
				if(event.data=="priceCalc"){
					if(document.form1.product.value=="LVR"||document.form1.product.value=="GRILLE"){
						editPrice();
					}
					else{
						savePriceCalc();
					}
				}
				else if(event.data=="OWS"){
					showOWS();
				}
				else if(event.data=="EMAIL"){

					lineItems.style.visibility='hidden';
					showMailDiv("");
				}
			}

		},false);
	}
	else{
		window.attachEvent("message",function(event){
			var x=event.data;
			if(x=="architectClose"){
				architectDiv.style.visibility='hidden';
			}
			else if(x.indexOf("architect")>=0){
				x=x.substring(11);
				architectDiv.style.visibility='hidden';
				x=x.replace(/#/g," ");
				var y=x.indexOf("^^");
				document.headerForm.archName.value=x.substring(0,y);
				document.headerForm.archLoc.value=x.substring(y+2);
			}
			else{

				cancelHeader();
				updateLines();
				if(event.data=="priceCalc"){
					if(document.form1.product.value=="LVR"||document.form1.product.value=="GRILLE"){
						editPrice();
					}
					else{
						savePriceCalc();
					}
				}
				else if(event.data=="OWS"){
					showOWS();
				}
				else if(event.data=="EMAIL"){

					lineItems.style.visibility='hidden';
					showMailDiv("");
				}
			}

		});
	}
	var exc;
	var qlf;
	var attemptCount=0;
	function isNew(){
		getPriceCalc();
		updateLines();
		document.form1.SFDCpage.value="";
	}
	function editPrice(){


		lineItems.style.visibility='hidden';
		header.style.visibility='hidden';
		pricecalc.style.visibility='visible';
		pricecalc2.style.visibility='hidden';
		buttonsDiv.style.visibility='hidden';
		mailDiv.style.visibility='hidden';
		owsDiv.style.visibility='hidden';
		secDiv.style.visibility='hidden';
		if((document.form1.product.value=="LVR"||document.form1.product.value=="GRILLE")&&document.form1.group.value.toUpperCase().indexOf("REP")<0&&document.form1.creatorGroup.value.toUpperCase().indexOf("REP")<0){
			document.getElementById('cranPriceCalcIframe').src=document.form1.cranPriceCalcUrl.value;
		}
		else if((document.form1.product.value=="LVR"||document.form1.product.value=="GRILLE")&&document.form1.group.value.toUpperCase().indexOf("REP")>=0&&document.form1.creatorGroup.value.toUpperCase().indexOf("REP")<0){
			document.getElementById('cranPriceCalcIframe').src=document.form1.cranPriceCalcRepUrl.value;
		}
		else{
			var params="";
			params="&orderNo="+document.form1.orderNo.value;
			var strURL=document.form1.url4.value;
			var req=new XMLHttpRequest();
			var handlerFunction=getReadyStateHandler(req,updatePriceCalc);
			req.onreadystatechange=handlerFunction;
			req.open("POST",strURL,true);
			req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			var form=document.forms['form1'];
			var orderno=escape(form.orderNo.value);
			req.send(params);
		}
	}
	function updatePriceCalc(searchXML){
		var count=searchXML.getElementsByTagName("orderNo").length;
		var strURL=document.form1.url12.value;
		var params="";
		for(var i=0;i<count;i++){
			var TEMPtotalCost=searchXML.getElementsByTagName("totalCost")[i].childNodes[0].nodeValue;
			TEMPtotalCost=TEMPtotalCost.replace("#","");
			document.priceCalcForm.totalCost.value=TEMPtotalCost;
			var TEMPsetupCost=searchXML.getElementsByTagName("setupCost")[i].childNodes[0].nodeValue;
			TEMPsetupCost=TEMPsetupCost.replace("#","");
			document.priceCalcForm.setupCost.value=TEMPsetupCost;
			var TEMPhandlingCost=searchXML.getElementsByTagName("handlingCost")[i].childNodes[0].nodeValue;
			TEMPhandlingCost=TEMPhandlingCost.replace("#","");
			document.priceCalcForm.handlingCost.value=TEMPhandlingCost;
			var TEMPfreightCost=searchXML.getElementsByTagName("freightCost")[i].childNodes[0].nodeValue;
			TEMPfreightCost=TEMPfreightCost.replace("#","");
			document.priceCalcForm.freightCost.value=TEMPfreightCost;
			var TEMPoverage=searchXML.getElementsByTagName("overage")[i].childNodes[0].nodeValue;
			TEMPoverage=TEMPoverage.replace("#","");
			document.priceCalcForm.overage.value=TEMPoverage;
			var TEMPoverageMax=searchXML.getElementsByTagName("overageMax")[i].childNodes[0].nodeValue;
			TEMPoverageMax=TEMPoverageMax.replace("#","");
			document.priceCalcForm.overageMax.value=TEMPoverageMax;
			var TEMPtaxZip=searchXML.getElementsByTagName("taxZip")[i].childNodes[0].nodeValue;
			TEMPtaxZip=TEMPtaxZip.replace("#","");
			document.priceCalcForm.shipZip.value=TEMPtaxZip;
			var TEMPcommission=searchXML.getElementsByTagName("commission")[i].childNodes[0].nodeValue;
			TEMPcommission=TEMPcommission.replace("#","");
			document.priceCalcForm.commission.value=TEMPcommission;
			var TEMPtaxExempt=searchXML.getElementsByTagName("taxExempt")[i].childNodes[0].nodeValue;
			TEMPtaxExempt=TEMPtaxExempt.replace("#","");
			if(TEMPtaxExempt=="Y"){
				document.priceCalcForm.taxExempt.checked=true;
			}
			if((document.form1.product.value=="IWP"||document.form1.product.value=="EJC"||document.form1.product.value=="EFS")&&document.form1.group.value.indexOf("REP")<0){
				var TEMPfreightOverride=searchXML.getElementsByTagName("freightOverride")[i].childNodes[0].nodeValue;
				TEMPfreightOverride=TEMPfreightOverride.replace("#","");
				if(TEMPfreightOverride=="Y"){
					document.priceCalcForm.freightOverride.checked=true;
					document.priceCalcForm.handlingCost.disabled=false;
				}
				else{

					if(document.form1.product.value=="EJC"){
						document.priceCalcForm.handlingCost.disabled=true;
						var req3=new XMLHttpRequest();
						params="&orderNo="+document.form1.orderNo.value;
						params=params+"&productId="+document.form1.product.value;
						params=params+"&total="+TEMPtotalCost;
						params=params+"&charge=freight";
						var handlerFunction=getReadyStateHandler(req3,priceCalcCharges1);
						req3.onreadystatechange=handlerFunction;
						req3.open("POST",strURL,true);
						req3.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
						req3.send(params);
					}
					else{
						document.priceCalcForm.handlingCost.disabled=true;
						var req3=new XMLHttpRequest();
						params="&orderNo="+document.form1.orderNo.value;
						params=params+"&productId="+document.form1.product.value;
						params=params+"&total="+TEMPtotalCost;
						params=params+"&charge=handling";
						var handlerFunction=getReadyStateHandler(req3,priceCalcCharges3);
						req3.onreadystatechange=handlerFunction;
						req3.open("POST",strURL,true);
						req3.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
						req3.send(params);
					}
				}
			}

			if(TEMPsetupCost.length<=0&&TEMPhandlingCost.length<=0&&TEMPfreightCost.length<=0&&TEMPoverage.length<=0){
				var req=new XMLHttpRequest();
				params="&orderNo="+document.form1.orderNo.value;
				params=params+"&productId="+document.form1.product.value;
				params=params+"&total="+TEMPtotalCost;
				params=params+"&charge=freight";
				var handlerFunction=getReadyStateHandler(req,priceCalcCharges1);
				req.onreadystatechange=handlerFunction;
				req.open("POST",strURL,true);
				req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				req.send(params);
				var req2=new XMLHttpRequest();
				params="&orderNo="+document.form1.orderNo.value;
				params=params+"&productId="+document.form1.product.value;
				params=params+"&total="+TEMPtotalCost;
				params=params+"&charge=overage";
				var handlerFunction2=getReadyStateHandler(req2,priceCalcCharges2);
				req2.onreadystatechange=handlerFunction2;
				req2.open("POST",strURL,true);
				req2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				req2.send(params);
				var req3=new XMLHttpRequest();
				params="&orderNo="+document.form1.orderNo.value;
				params=params+"&productId="+document.form1.product.value;
				params=params+"&total="+TEMPtotalCost;
				params=params+"&charge=handling";
				var handlerFunction=getReadyStateHandler(req3,priceCalcCharges3);
				req3.onreadystatechange=handlerFunction;
				req3.open("POST",strURL,true);
				req3.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				req3.send(params);
				var req4=new XMLHttpRequest();
				params="&orderNo="+document.form1.orderNo.value;
				params=params+"&productId="+document.form1.product.value;
				params=params+"&total="+TEMPtotalCost;
				params=params+"&charge=setup";
				var handlerFunction=getReadyStateHandler(req4,priceCalcCharges4);
				req4.onreadystatechange=handlerFunction;
				req4.open("POST",strURL,true);
				req4.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				req4.send(params);
			}
			else if(document.form1.product.value=="EFS"){
				var req4=new XMLHttpRequest();
				params="&orderNo="+document.form1.orderNo.value;
				params=params+"&productId="+document.form1.product.value;
				params=params+"&total="+TEMPtotalCost;
				params=params+"&charge=setup";
				var handlerFunction=getReadyStateHandler(req4,priceCalcCharges4);
				req4.onreadystatechange=handlerFunction;
				req4.open("POST",strURL,true);
				req4.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				req4.send(params);
			}

			var req3x=new XMLHttpRequest();
			params="&orderNo="+document.form1.orderNo.value;
			params=params+"&productId="+document.form1.product.value;
			params=params+"&total="+TEMPtotalCost;
			if(document.form1.product.value=="EJC"){
				params=params+"&charge=freight";
			}
			else{
				params=params+"&charge=handling";
			}
			var handlerFunctionx=getReadyStateHandler(req3x,priceCalcCharges5);
			req3x.onreadystatechange=handlerFunctionx;
			req3x.open("POST",strURL,true);
			req3x.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			req3x.send(params);
			var req3y=new XMLHttpRequest();
			params="&orderNo="+document.form1.orderNo.value;
			params=params+"&productId="+document.form1.product.value;
			params=params+"&total="+TEMPtotalCost;
			params=params+"&charge=freight";
		}
	}
	function freightOverrideChange(){
		if(document.form1.product.value=="EJC"){
			if(document.priceCalcForm.freightOverride.checked==true){
				document.priceCalcForm.freightCost.disabled=false;
			}
			else{
				document.priceCalcForm.freightCost.disabled=true;
				document.priceCalcForm.freightCost.value=document.priceCalcForm.calculatedFreight.value;
			}
		}
		else{
			if(document.priceCalcForm.freightOverride.checked==true){
				document.priceCalcForm.handlingCost.disabled=false;
			}
			else{
				document.priceCalcForm.handlingCost.disabled=true;
				document.priceCalcForm.handlingCost.value=document.priceCalcForm.calculatedFreight.value;
			}
		}
	}
	function priceCalcCharges1(searchXML){
		var count=searchXML.getElementsByTagName("chargex").length;
		for(var i=0;i<count;i++){
			var TEMPcharge=searchXML.getElementsByTagName("chargex")[i].childNodes[0].nodeValue;
			TEMPcharge=TEMPcharge.replace("#","");
			if(document.form1.projectType.value!="web"){
				if(TEMPcharge.length>0){
					document.priceCalcForm.freightCost.value=TEMPcharge;
				}
				else{
					document.priceCalcForm.freightCost.value=0;
				}
			}
		}
	}
	function priceCalcCharges2(searchXML){
		var count=searchXML.getElementsByTagName("chargex").length;
		for(var i=0;i<count;i++){
			var TEMPcharge=searchXML.getElementsByTagName("chargex")[i].childNodes[0].nodeValue;
			TEMPcharge=TEMPcharge.replace("#","");

			if(document.form1.projectType.value!="web"){
				if(TEMPcharge.length>0){
					document.priceCalcForm.overage.value=TEMPcharge;
				}
				else{
					document.priceCalcForm.overage.value=0;
				}
			}
		}
	}
	function priceCalcCharges3(searchXML){
		var count=searchXML.getElementsByTagName("chargex").length;
		for(var i=0;i<count;i++){
			var TEMPcharge=searchXML.getElementsByTagName("chargex")[i].childNodes[0].nodeValue;
			TEMPcharge=TEMPcharge.replace("#","");
			if(document.form1.projectType.value!="web"){
				if(TEMPcharge.length>0){
					document.priceCalcForm.handlingCost.value=TEMPcharge;
				}
				else{
					document.priceCalcForm.handlingCost.value=0;
				}
			}
		}
	}
	function priceCalcCharges4(searchXML){
		var count=searchXML.getElementsByTagName("chargex").length;
		for(var i=0;i<count;i++){
			var TEMPcharge=searchXML.getElementsByTagName("chargex")[i].childNodes[0].nodeValue;
			TEMPcharge=TEMPcharge.replace("#","");
			if(document.form1.projectType.value!="web"){
				if(TEMPcharge.length>0){
					document.priceCalcForm.setupCost.value=TEMPcharge;
				}
				else{
					document.priceCalcForm.setupCost.value=0;
				}
			}
		}
	}
	function priceCalcCharges5(searchXML){
		var count=searchXML.getElementsByTagName("chargex").length;
		for(var i=0;i<count;i++){
			var TEMPcharge=searchXML.getElementsByTagName("chargex")[i].childNodes[0].nodeValue;
			TEMPcharge=TEMPcharge.replace("#","");
			if(document.form1.projectType.value!="web"){
				if(TEMPcharge.length>0){
					document.priceCalcForm.calculatedFreight.value=TEMPcharge;
				}
				else{
					document.priceCalcForm.calculatedFreight.value=0;
				}
			}
		}
		if(document.form1.product.value == "LVR" || document.form1.product.value == "GRILLE"){
			getLVRRepPrice();
		}
	}
	function getPriceCalc(){
		var params="";
		params="&orderNo="+document.form1.orderNo.value;
		var strURL3=document.form1.url3.value;
		var req=new XMLHttpRequest();
		var handlerFunction=getReadyStateHandler(req,savePriceCalc2);
		req.onreadystatechange=handlerFunction;
		req.open("POST",strURL3,true);
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		req.send(params);
	}
	function savePriceCalc2(searchXML){
		var count=searchXML.getElementsByTagName("orderNo").length;
		for(var i=0;i<count;i++){
			document.getElementById('totalCostLabel').innerHTML=searchXML.getElementsByTagName("totalCost")[i].childNodes[0].nodeValue;
			var TEMPsetupCost=searchXML.getElementsByTagName("setupCost")[i].childNodes[0].nodeValue;
			TEMPsetupCost=TEMPsetupCost.replace("#","");
			document.getElementById('setupCostLabel').innerHTML=TEMPsetupCost;
			var TEMPhandlingCost=searchXML.getElementsByTagName("handlingCost")[i].childNodes[0].nodeValue;
			TEMPhandlingCost=TEMPhandlingCost.replace("#","");
			document.getElementById('handlingCostLabel').innerHTML=TEMPhandlingCost;
			var TEMPfreightCost=searchXML.getElementsByTagName("freightCost")[i].childNodes[0].nodeValue;
			TEMPfreightCost=TEMPfreightCost.replace("#","");
			document.getElementById('freightCostLabel').innerHTML=TEMPfreightCost;
			var TEMPoverage=searchXML.getElementsByTagName("overage")[i].childNodes[0].nodeValue;
			TEMPoverage=TEMPoverage.replace("#","");
			document.getElementById('overageLabel').innerHTML=TEMPoverage;
			var TEMPtotalCost=searchXML.getElementsByTagName("totalCost")[i].childNodes[0].nodeValue;
			TEMPtotalCost=TEMPtotalCost.replace("#","");
		}
		getTax();
	}
	function getTax(){
		var params="";
		params="&orderNo="+document.form1.orderNo.value;
		var strURL="getTax.jsp";
		var req=new XMLHttpRequest();
		var handlerFunction=getReadyStateHandler(req,getTax2);
		req.onreadystatechange=handlerFunction;
		req.open("POST",strURL,true);
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		req.send(params);
	}
	function getTax2(searchXML){
		var count=searchXML.getElementsByTagName("orderNo").length;
		for(var i=0;i<count;i++){
			var taxTotal=searchXML.getElementsByTagName("taxTotal")[i].childNodes[0].nodeValue*1;
			document.getElementById('totalTaxLabel').innerHTML=taxTotal.toFixed(2);
			document.getElementById('taxRateLabel').innerHTML=searchXML.getElementsByTagName("taxRate")[i].childNodes[0].nodeValue;
			var total=document.getElementById('totalCostLabel').innerHTML*1+document.getElementById('setupCostLabel').innerHTML*1+document.getElementById('handlingCostLabel').innerHTML*1+document.getElementById('freightCostLabel').innerHTML*1+document.getElementById('overageLabel').innerHTML*1+document.getElementById('totalTaxLabel').innerHTML*1;
			document.getElementById('totalLabel').innerHTML=total.toFixed(2);
		}
	}
	function getButtons2(){
//alert("get buttons2");
//alert("a");
		var params="";
		//alert("b");
		params="&orderNo="+document.form1.orderNo.value;
		//alert("c");
		params=params+"&product="+document.form1.product.value;
		//alert("d");
		params=params+"&group="+document.form1.group.value;
		//alert("e");
		params=params+"&page=header";
		//alert("f");
		params=params+"&country=US";
		//alert("g");
		var strURL5=document.form1.url5.value;
		//alert("h");
		var req=new XMLHttpRequest();
		//alert("i");
		var handlerFunction=getReadyStateHandler(req,showButtons2);
		//alert("j");
		req.onreadystatechange=handlerFunction;
		//alert("k");
		req.open("POST",strURL5,true);
		//alert("l");
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		//alert("m");
		//params=convertPL(params);
		req.send(params);
		//alert("n");
	}
	function showButtons2(searchXML){
		var params="";
		params="?orderNo="+document.form1.orderNo.value;
		var count=searchXML.getElementsByTagName("name").length;
		var buttons="";
		if(document.form1.userId.value.length<=0){
			alert("Username unknown.  Please contact eRapid team.");
		}
		else{
			for(var i=0;i<count;i++){
				params=params+"&urlx="+searchXML.getElementsByTagName("url")[i].childNodes[0].nodeValue;
				var params2="";
				params2="?orderNo="+document.form1.orderNo.value;
				var initUrl=searchXML.getElementsByTagName("url")[i].childNodes[0].nodeValue;
				if(initUrl.indexOf("global")<0){
					initUrl=initUrl+params2;
				}
				var actionx=searchXML.getElementsByTagName("action")[i].childNodes[0].nodeValue;
				if(actionx=="pu"){
					buttons=buttons+"<input type='button' name='"+searchXML.getElementsByTagName("name")[i].childNodes[0].nodeValue+"' value='"+searchXML.getElementsByTagName("name")[i].childNodes[0].nodeValue+"' onclick=n_window('"+initUrl+"') class='btn'>";
				}
				else if(actionx=="pugc"){
					buttons=buttons+"<input type='button' name='"+searchXML.getElementsByTagName("name")[i].childNodes[0].nodeValue+"' value='"+searchXML.getElementsByTagName("name")[i].childNodes[0].nodeValue+"' onclick=gcwindow('"+initUrl+"') class='btn>";
				}
				else if(actionx=="href"){
					buttons=buttons+"<input type='button' name='"+searchXML.getElementsByTagName("name")[i].childNodes[0].nodeValue+"' value='"+searchXML.getElementsByTagName("name")[i].childNodes[0].nodeValue+"' onclick=javascript:document.location.href='"+initUrl+"' class='btn'>";
				}
			}
		}
		buttons=buttons+"<input value='Edit Notes' class='btn' title='Edit Notes' name='Notes' type='button'>";
		var globalChanges=document.form1.fullServerName.value+"/cse/cse?cmd=CI&csc=true&readonly=true&revision=1&username="+document.form1.userId.value+"&pid=SYS_GCH&order_no="+document.form1.orderNo.value+"&item_no="+document.lineItemForm.newLineNo.value+"&subline_no=0&doc_type="+document.form1.qtype.value+"&detail1=DATA|ORDER|"+document.form1.orderNo.value+"&detail2=DATA|TYPE|"+document.form1.qtype.value+"&detail3=DATA|PID|"+document.form1.product.value+"&canurl="+document.form1.fullServerName.value+"/erapid/us/lineItemSFDC.jsp&returl="+document.form1.fullServerName.value+"/erapid/us/lineItemSFDC.jsp";
		var globalUpdate=document.form1.fullServerName.value+"/cse/cse?cmd=CI&csc=true&readonly=true&revision=1&username="+document.form1.userId.value+"&pid=SYS_GCH&order_no="+document.form1.orderNo.value+"&item_no="+document.lineItemForm.newLineNo.value+"&subline_no=0&doc_type="+document.form1.qtype.value+"&detail1=DATA|ORDER|"+document.form1.orderNo.value+"&detail2=DATA|TYPE|"+document.form1.qtype.value+"U&detail3=DATA|PID|"+document.form1.product.value+"&canurl="+document.form1.fullServerName.value+"/erapid/us/lineItemSFDC.jsp&returl="+document.form1.fullServerName.value+"/erapid/us/lineItemSFDC.jsp";
		buttons=buttons.replace("globalChangeUrl",globalChanges);
		buttons=buttons.replace("globalUpdateUrl",globalUpdate);
		document.getElementById("headerButtonsDiv").innerHTML="";
		var newdiv=document.createElement("div");
		newdiv.style.top=250;
		newdiv.innerHTML=buttons;
		var result=document.getElementById("headerButtonsDiv");
		result.appendChild(newdiv);
	}
	function updateLines(){
		//alert("update lines");
		var strURL=document.form1.url8.value;
		var req=new XMLHttpRequest();
		var handlerFunction=getReadyStateHandler(req,updateLinesResults);
		req.onreadystatechange=handlerFunction;
		req.open("POST",strURL,true);
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		var form=document.forms['form1'];
		var orderno=escape(form.orderNo.value);
		var values='&orderNo='+escape(orderno);
		//values=convertPL(values);
		req.send(values);
		//alert("send values"+values);
	}
	function updateLinesResults(searchXML){
		var count=searchXML.getElementsByTagName("orderNo").length;
		var htmlLines="<form name='lineItemForm'><table class='list' cellspacing='0' cellpadding='0' border='0' ><tbody><tr class='headerRow'><th scope='col'>Line No</th><th scope='col'>&nbsp;</th><th scope='col'>";
		if(count>0){
			if(document.form1.group.value.indexOf("Rep")>=0&&(document.form1.projectType.value=="SFDC"||document.form1.projectType.value=="PSA")){
			}
			else{
				htmlLines=htmlLines+"<input type='checkbox' name='deleteall' onclick='deleteSelectAll()'>";
			}
		}
		else{
			htmlLines=htmlLines+"&nbsp;";
		}
		if(document.form1.quoteOrigin.value=="change"){
			if(document.form1.group.value.indexOf("Rep")>=0&&(document.form1.projectType.value=="SFDC"||document.form1.projectType.value=="PSA")){
				htmlLines=htmlLines+"</th><th scope='col'>Product</th><th scope='col'>Description</th>";
			}
			else{
				htmlLines=htmlLines+"</th><th scope='col'>Product</th><th scope='col'>Description</th><th scope='col'>Qty</th><th scope='col'>Price</th><th scope='col'>Discount</th><th scope='col'>Status</th>";
			}

			htmlLines=htmlLines+"<th scope='col'>Add/Deduct</th>";
		}
		else{
			if(document.form1.group.value.indexOf("Rep")>=0&&(document.form1.projectType.value=="SFDC"||document.form1.projectType.value=="PSA")){
				htmlLines=htmlLines+"</th><th scope='col'>Product</th><th scope='col'>Description</th>";
			}
			else{
				htmlLines=htmlLines+"</th><th scope='col'>Product</th><th scope='col'>Description</th><th scope='col'>Qty</th><th scope='col'>Price</th><th scope='col'>Discount</th><th scope='col'>Status</th>";
			}
		}
		htmlLines=htmlLines+"</tr>";
		var cssClass="roweven";
		var lastLineNo="0";
		var cseUrl="";
		var fullServerName=document.form1.fullServerName.value;
		var userId=document.form1.userId.value;
		var quoteType=document.form1.qtype.value;
		var TEMPorderNo="";
		var TEMPlineNo="";
		var TEMPproductId="";
		var ii=0;
		for(var i=0;i<count;i++){
			TEMPorderNo=searchXML.getElementsByTagName("orderNo")[i].childNodes[0].nodeValue;
			TEMPorderNo=TEMPorderNo.replace("#","");
			var TEMPstatus=searchXML.getElementsByTagName("status")[i].childNodes[0].nodeValue;
			TEMPstatus=TEMPstatus.replace("#","");
			TEMPlineNo=searchXML.getElementsByTagName("lineNo")[i].childNodes[0].nodeValue;
			TEMPlineNo=TEMPlineNo.replace("#","");
			TEMPproductId=searchXML.getElementsByTagName("productId")[i].childNodes[0].nodeValue;
			TEMPproductId=TEMPproductId.replace("#","");
			var TEMPdescription=searchXML.getElementsByTagName("description")[i].childNodes[0].nodeValue;
			TEMPdescription=TEMPdescription.replace("#","");
			var TEMPextendedPrice=searchXML.getElementsByTagName("extendedPrice")[i].childNodes[0].nodeValue;
			TEMPextendedPrice=TEMPextendedPrice.replace("#","");
			var TEMPuom=searchXML.getElementsByTagName("uom")[i].childNodes[0].nodeValue;
			TEMPuom=TEMPuom.replace("#","");
			var TEMPqty=searchXML.getElementsByTagName("qty")[i].childNodes[0].nodeValue;
			TEMPqty=TEMPqty.replace("#","");
			var TEMPfield19=searchXML.getElementsByTagName("field19")[i].childNodes[0].nodeValue;
			TEMPfield19=TEMPfield19.replace("#","");
			var TEMPfield17=searchXML.getElementsByTagName("field17")[i].childNodes[0].nodeValue;
			TEMPfield17=TEMPfield17.replace("#","");
			var TEMPwdth=searchXML.getElementsByTagName("wdth")[i].childNodes[0].nodeValue;
			TEMPwdth=TEMPwdth.replace("#","");
			var TEMPlgth=searchXML.getElementsByTagName("lgth")[i].childNodes[0].nodeValue;
			TEMPlgth=TEMPlgth.replace("#","");
			var TEMPsqmp=searchXML.getElementsByTagName("sqmp")[i].childNodes[0].nodeValue;
			TEMPsqmp=TEMPsqmp.replace("#","");
			var TEMPsqm=searchXML.getElementsByTagName("sqm")[i].childNodes[0].nodeValue;
			TEMPsqm=TEMPsqm.replace("#","");
			var TEMPdeduct=searchXML.getElementsByTagName("deduct")[i].childNodes[0].nodeValue;
			TEMPdeduct=TEMPdeduct.replace("#","");
			if(TEMPproductId.length==0){
				TEMPproductId=document.form1.product.value;
			}
			var TEMPsqmm2="0.00";
			if(TEMPsqm.length==0){
				TEMPsqm="0";
			}
			else{
				TEMPsqmm2=(TEMPextendedPrice*1/TEMPsqm*1);
				TEMPsqmm2=TEMPsqmm2.toFixed(2);
			}
			if(TEMPsqmp.length==0){
				TEMPsqmp="0";
			}
			if(document.form1.group.value.indexOf("Rep")<0&&document.form1.creatorGroup.value.indexOf("Rep")>=0&&document.form1.qtype.value=="Q"){
				cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+document.form1.creatorUserName.value+"&pid="+TEMPproductId+"&orderno="+TEMPorderNo+"&item_no="+TEMPlineNo+"&subline_no=0&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItemSFDC.jsp&returl="+fullServerName+"/erapid/us/lineItemSFDC.jsp";
			}
			else{
				cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid="+TEMPproductId+"&orderno="+TEMPorderNo+"&item_no="+TEMPlineNo+"&subline_no=0&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItemSFDC.jsp&returl="+fullServerName+"/erapid/us/lineItemSFDC.jsp";
			}
			if(TEMPlineNo*1>lastLineNo*1){

				ii++;
				htmlLines=htmlLines+"<tr class='dataRow'>";
				if(TEMPstatus=="ABORT"){
					htmlLines=htmlLines+"<td class='datacell' align='center'><font color='red'>"+TEMPlineNo+"</font></td>";
				}
				else{
					htmlLines=htmlLines+"<td class='datacell' align='center'>"+TEMPlineNo+"</td>";
				}
				lastLineNo=TEMPlineNo;
				htmlLines=htmlLines+"<td><input type='button' name='Edit' value='Edit' class='btn' onclick=\"javascript:document.location.href='"+cseUrl+"' \">";
				if(document.form1.product.value=="LVR"||document.form1.product.value=="GRILLE"){
					htmlLines=htmlLines+" &nbsp;&nbsp; "+TEMPfield17;
				}
				htmlLines=htmlLines+"</td>";
				if(document.form1.group.value.indexOf("Rep")>=0&&(document.form1.projectType.value=="SFDC"||document.form1.projectType.value=="PSA")){
					htmlLines=htmlLines+"<td>&nbsp;</td>";
				}
				else{
					htmlLines=htmlLines+"<td class='datacell' ><input type='checkbox' name='deletex' value='"+TEMPlineNo+"'></td>";
				}
				if(TEMPstatus=="ABORT"){
					htmlLines=htmlLines+"<td><font color='red'>"+TEMPproductId+"&nbsp;</font></td>";
				}
				else{
					htmlLines=htmlLines+"<td>"+TEMPproductId+"&nbsp;</td>";
				}
				htmlLines=htmlLines+"<td>"+TEMPdescription+"&nbsp;</td>";
				if(document.form1.group.value.indexOf("Rep")>=0&&(document.form1.projectType.value=="SFDC"||document.form1.projectType.value=="PSA")){

				}
				else{
					if(TEMPstatus=="ABORT"){
						htmlLines=htmlLines+"<td class='datacell' align='right'><font color='red'>"+TEMPqty+"</font>&nbsp;</td>";
						if(TEMPdeduct=="DEDUCT"){
							htmlLines=htmlLines+"<td class='datacell' align='right'><font color='red'>("+TEMPextendedPrice+")</font>&nbsp;</td>";
						}
						else{
							htmlLines=htmlLines+"<td class='datacell' align='right'><font color='red'>"+TEMPextendedPrice+"</font>&nbsp;</td>";
						}
						htmlLines=htmlLines+"<td><font color='red'>"+TEMPfield19+"&nbsp;</font></td>";
						htmlLines=htmlLines+"<td><font color='red'>"+TEMPstatus+"&nbsp;</font></td>";
					}
					else{
						htmlLines=htmlLines+"<td class='datacell' align='right'>"+TEMPqty+"&nbsp;</td>";
						if(TEMPdeduct=="DEDUCT"){
							htmlLines=htmlLines+"<td class='datacell' align='right'>("+TEMPextendedPrice+")&nbsp;</td>";
						}
						else{
							htmlLines=htmlLines+"<td class='datacell' align='right'>"+TEMPextendedPrice+"&nbsp;</td>";
						}
						htmlLines=htmlLines+"<td>"+TEMPfield19+"&nbsp;</td>";
						htmlLines=htmlLines+"<td>"+TEMPstatus+"&nbsp;</td>";
					}
				}
				if(document.form1.quoteOrigin.value=="change"){
					htmlLines=htmlLines+"<td><select name='addDeduct' class='selectDeduct' id='testssss' onchange=updateDeduct('"+TEMPlineNo+"','"+i+"')>";
					htmlLines=htmlLines+"<option value=''></option>";
					var selected="";
					if(TEMPdeduct=="ADD"){
						selected="selected";
					}
					htmlLines=htmlLines+"<option value='ADD' "+selected+">Add</option>";
					selected="";
					if(TEMPdeduct=="DEDUCT"){
						selected="selected";
					}
					htmlLines=htmlLines+"<option value='DEDUCT' "+selected+">Deduct</option></select></td>";
				}
				htmlLines=htmlLines+"</tr>";
				if(i%2==0){
					cssClass="rowodd";
				}
				else{
					cssClass="roweven";
				}
			}
		}
		TEMPproductId=document.form1.product.value;
		TEMPorderNo=document.form1.orderNo.value;
		var newLineNo=""+((lastLineNo*1)+1);
		htmlLines=htmlLines+"<tr class='"+cssClass+"'>";
		htmlLines=htmlLines+"<td class='datacell' align='center'>&nbsp;</td>";
		if(quoteType=="Q"){
			if(!(TEMPproductId=="LVR"||TEMPproductId=="GRILLE"||TEMPproductId=="GE")||document.form1.group.value.toUpperCase().indexOf("REP-DLVR")>=0){
				if(document.form1.group.value.indexOf("Rep")<0&&document.form1.creatorGroup.value.indexOf("Rep")>=0&&document.form1.qtype.value=="Q"){
					cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+document.form1.creatorUserName.value+"&pid="+TEMPproductId+"&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&subline_no=0&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItemSFDC.jsp&returl="+fullServerName+"/erapid/us/lineItemSFDC.jsp";
				}
				else{
					cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid="+TEMPproductId+"&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&subline_no=0&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItemSFDC.jsp&returl="+fullServerName+"/erapid/us/lineItemSFDC.jsp";
				}
				if(document.form1.quoteOrigin.value=="sample"){
					cseUrl=cseUrl+"&detail2=FLAGS|SAMPLE|";
				}
				if(document.form1.group.value.indexOf("Rep")>=0&&((document.form1.projectType.value=="SFDC"||document.form1.projectType.value=="PSA")&&document.form1.creatorGroup.value.indexOf("Rep")<0)){
					htmlLines=htmlLines+"<td>&nbsp;</td>";
				}
				else{
					htmlLines=htmlLines+"<td><input type='button' name='New' value='New' class='btn' onclick=\"javascript:document.location.href='"+cseUrl+"' \"></td>";
				}
			}
			else{
				if(document.form1.group.value.indexOf("Rep")>=0&&(document.form1.projectType.value=="SFDC"||document.form1.projectType.value=="PSA")){
					htmlLines=htmlLines+"<td>&nbsp;</td>";
				}
				else{
					htmlLines=htmlLines+"<td><select name='PID' class='priceCalcSelect' onchange='pidPulldown()'><option value=''>Select Product</option>";
					if(TEMPproductId=="LVR"){
						cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=LVR&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&subline_no=0&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItemSFDC.jsp&returl="+fullServerName+"/erapid/us/lineItemSFDC.jsp";
						htmlLines=htmlLines+"<option value='"+cseUrl+"'>LVR</option>";
						cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=BV&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&subline_no=0&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItemSFDC.jsp&returl="+fullServerName+"/erapid/us/lineItemSFDC.jsp";
						htmlLines=htmlLines+"<option value='"+cseUrl+"'>BV</option>";
						if(document.form1.group.value.toUpperCase().indexOf("REP")<0){
							cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=GEN&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&subline_no=0&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItemSFDC.jsp&returl="+fullServerName+"/erapid/us/lineItemSFDC.jsp&detail3=FLAGS|PID|"+TEMPproductId;
							//alert(cseUrl);
							htmlLines=htmlLines+"<option value='"+cseUrl+"'>GEN</option>";
						}
					}
					else if(TEMPproductId=="GRILLE"){
						cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=GRILLE&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&subline_no=0&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItemSFDC.jsp&returl="+fullServerName+"/erapid/us/lineItemSFDC.jsp";
						htmlLines=htmlLines+"<option value='"+cseUrl+"'>GRILLE</option>";
						cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=SUN&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&subline_no=0&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItemSFDC.jsp&returl="+fullServerName+"/erapid/us/lineItemSFDC.jsp";
						htmlLines=htmlLines+"<option value='"+cseUrl+"'>SUN</option>";
						cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=LVR&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&subline_no=0&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItemSFDC.jsp&returl="+fullServerName+"/erapid/us/lineItemSFDC.jsp";
						htmlLines=htmlLines+"<option value='"+cseUrl+"'>LVR</option>";
						cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=GEN&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&subline_no=0&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItemSFDC.jsp&returl="+fullServerName+"/erapid/us/lineItemSFDC.jsp&detail3=FLAGS|PID|"+TEMPproductId;
						//alert(cseUrl);
						htmlLines=htmlLines+"<option value='"+cseUrl+"'>GEN</option>";
					}
					else{
						cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=GE&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&subline_no=0&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItemSFDC.jsp&returl="+fullServerName+"/erapid/us/lineItemSFDC.jsp";
						htmlLines=htmlLines+"<option value='"+cseUrl+"'>GE</option>";
						cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=IWP&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&subline_no=0&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItemSFDC.jsp&returl="+fullServerName+"/erapid/us/lineItemSFDC.jsp";
						htmlLines=htmlLines+"<option value='"+cseUrl+"'>IWP</option>";
						cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=EFS&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&subline_no=0&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItemSFDC.jsp&returl="+fullServerName+"/erapid/us/lineItemSFDC.jsp";
						htmlLines=htmlLines+"<option value='"+cseUrl+"'>EFS</option>";
					}
					htmlLines=htmlLines+"</select></td>";
				}
			}
		}

		if(document.form1.group.value.indexOf("Rep")>=0&&(document.form1.projectType.value=="SFDC"||document.form1.projectType.value=="PSA")){
			htmlLines=htmlLines+"<td>&nbsp;</td>";
		}
		else if(count>0){
			htmlLines=htmlLines+"<td><input type='button' name='deleteLinesTest' value='Delete'  class='btn' onclick='deleteLines()'></td>";
		}
		else{
			htmlLines=htmlLines+"<td>&nbsp;</td>";
		}
		if(document.form1.quoteOrigin.value=="change"){
			htmlLines=htmlLines+"<td class='datacell' colspan='7'>&nbsp;</td></tr>";
		}
		else{
			htmlLines=htmlLines+"<td class='datacell' colspan='6'>&nbsp;</td></tr>";
		}
		var sfdcUrl=document.form1.sfdcUrl.value;
		htmlLines=htmlLines+"</table>";
		htmlLines=htmlLines+"<input type='hidden' name='newLineNo' value='"+newLineNo+"'>";
		htmlLines=htmlLines+"<input type='hidden' name='count' value='"+count+"'></form>";
		document.getElementById("lineItems").innerHTML=htmlLines;

		getButtons2();

	}
	function pidPulldown(){
		document.location.href=document.lineItemForm.PID.value;
	}
	function n_window(theurl){
//alert("n windows");
		var the_width=1000;
		var the_height=1000;
		var from_top=60;
		var from_left=60;
		var has_toolbar='yes';
		var has_location='no';
		var has_directories='no';
		var has_status='yes';
		var has_menubar='yes';
		var has_scrollbars='yes';
		var is_resizable='yes';
		var the_atts='width='+the_width+',height='+the_height+',top='+from_top+',screenY='+from_top+',left='+from_left+',screenX='+from_left;
		the_atts+=',toolbar='+has_toolbar+',location='+has_location+',directories='+has_directories+',status='+has_status;
		the_atts+=',menubar='+has_menubar+',scrollbars='+has_scrollbars+',resizable='+is_resizable;
		window.open(theurl,'',the_atts);
	}
	function gcwindow(theurl){
//alert("gc window");
		var the_width=450;
		var the_height=400;
		var from_top=60;
		var from_left=560;
		var has_toolbar='no';
		var has_location='no';
		var has_directories='no';
		var has_status='yes';
		var has_menubar='yes';
		var has_scrollbars='yes';
		var is_resizable='yes';
		var the_atts='width='+the_width+',height='+the_height+',top='+from_top+',screenY='+from_top+',left='+from_left+',screenX='+from_left;
		the_atts+=',toolbar='+has_toolbar+',location='+has_location+',directories='+has_directories+',status='+has_status;
		the_atts+=',menubar='+has_menubar+',scrollbars='+has_scrollbars+',resizable='+is_resizable;
		myWindowx2=window.open(theurl,'myWindowx2',the_atts);
		setTimeout("checkWindow();",1000);
	}
	function checkWindow(){
//alert("check windows");
		if(window.myWindowx2){
			if(myWindowx2&&typeof (myWindowx2.closed)!='unknown'&&!myWindowx2.closed){

				setTimeout("checkWindow();",1000);
			}
			else{
//document.location.reload(true);
//return false;
				updateLines();
			}
		}
		else{
//document.location.reload(true);
//return false;
			updateLines();
		}
	}
	function LTrim(str){
//alert("ltrim");
		var whitespace=new String(" \t\n\r");
		var s=new String(str);
		if(whitespace.indexOf(s.charAt(0))!=-1){
			var j=0,i=s.length;
			while(j<i&&whitespace.indexOf(s.charAt(j))!=-1)
				j++;
			s=s.substring(j,i);
		}
		return s;
	}
	function RTrim(str){
//alert("rtrim");
		var whitespace=new String(" \t\n\r");
		var s=new String(str);
		if(whitespace.indexOf(s.charAt(s.length-1))!=-1){
			var i=s.length-1;
			while(i>=0&&whitespace.indexOf(s.charAt(i))!=-1)
				i--;
			s=s.substring(0,i+1);
		}
		return s;
	}
	function Trim(str){
//alert("trim");
		return RTrim(LTrim(str));
	}
	function deleteSelectAll(){
//alert("delete select all");
		var x=document.lineItemForm.deleteall.checked;
		if(document.lineItemForm.deletex){
			if(document.lineItemForm.deletex.checked==true||document.lineItemForm.deletex.checked==false){
				document.lineItemForm.deletex.checked=x;
			}
			else{
				for(var i=0;i<document.lineItemForm.deletex.length;i++){
					document.lineItemForm.deletex[i].checked=x;
				}
			}
		}
	}
	function deleteLines(){
//alert("delete lines");
		var agree=confirm("Are you sure you want to delete this line? ");
		if(agree){
			var deleteLines="";
			if(document.lineItemForm.deletex){
				if(document.lineItemForm.deletex.checked==true){
					deleteLines=deleteLines+"#"+document.lineItemForm.deletex.value+"#";
				}
				else{
					for(var i=0;i<document.lineItemForm.deletex.length;i++){
						if(document.lineItemForm.deletex[i].checked==true){
							deleteLines=deleteLines+"#"+document.lineItemForm.deletex[i].value+"#";
						}
					}
				}
			}
			var params="";
			params="&orderNo="+document.form1.orderNo.value+"&lines="+deleteLines+"&product="+document.form1.product.value+"&country="+document.form1.userCountryCode.value;
			//alert(params);
			var req=new XMLHttpRequest();
			var handlerFunction=getReadyStateHandler(req,deleteLinesComplete);
			req.onreadystatechange=handlerFunction;
			var strURL=document.form1.url9.value;
			req.open("POST",strURL,true);
			req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			//params=convertPL(params);
			req.send(params);
		}
	}
	function deleteLinesComplete(){
//alert("delete lines complete");
		updateLines();
	}
	function selectCurrency(){
		var x=document.headerForm.custName.value.length;
		var values="&custNo="+document.headerForm.custName.value;
		//alert(values+"::"+document.headerForm.custName.value.length);
		//alert("::"+x+"::");
		if(x<=0){
			if(attemptCount<10){
				selectCurrency();
				attempCount++;
			}
			else{
				alert("no customer number");
				attempCount=0;
			}
//exit();
		}
		else{
			var req=new XMLHttpRequest();
			var strURL="getCurrency.jsp";
			var handlerFunction=getReadyStateHandler(req,selectCurrency3);
			req.onreadystatechange=handlerFunction;
			req.open("POST",strURL,true);
			req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			//values=convertPL(values);
			req.send(values);
		}
//alert(strURL+"::"+values);
	}
	function selectCurrency3(searchXML){
//alert("selectCurrency3");
		attempCount=0;
		var count=searchXML.getElementsByTagName("exchName").length;
		for(var i=0;i<count;i++){
			var exchName=searchXML.getElementsByTagName("exchName")[i].childNodes[0].nodeValue;
			exchName=exchName.replace("#","");
			var exchRate=searchXML.getElementsByTagName("exchRate")[i].childNodes[0].nodeValue;
			exchRate=exchRate.replace("#","");
			var exchRateDate=searchXML.getElementsByTagName("exchRateDate")[i].childNodes[0].nodeValue;
			exchRateDate=exchRateDate.replace("#","");
			exchRateDate=exchRateDate.substring(0,10);
		}
		if(document.form1.orderNo.value==""){
			if(exchName=="CAD"){
				document.headerForm.exchName.value=exchName;
				document.headerForm.exchRate.value=exchRate;
				document.headerForm.exchDate.value=exchRateDate.substring(0,10);
			}
			else{
				document.headerForm.exchName.value="";
				document.headerForm.exchRate.value="";
				document.headerForm.exchDate.value="";
			}
		}
		else{
//alert(document.headerForm.exchName.value+"::"+exchName);
			if(document.headerForm.exchName.value=="CAD"||exchName=="CAD"){
				if(document.headerForm.exchName.value!=exchName){
					alert("YOU HAVE SELECTED A CUSTOMER FROM A DIFFERENT COUNTRY.  TODAYS EXCHANGE RATE WILL BE SUPPLIED");
					if(exchName=="CAD"){
						document.headerForm.exchName.value=exchName;
						document.headerForm.exchRate.value=exchRate;
						document.headerForm.exchDate.value=exchRateDate.substring(0,10);
					}
					else{
						document.headerForm.exchName.value="";
						document.headerForm.exchRate.value="";
						document.headerForm.exchDate.value="";
					}
				}
			}
		}
		if(exchName=="CAD"){
			document.getElementsByName("cdn1")[0].title=" Name:"+exchName+"\r\n Rate:"+exchRate+"\r\n Date:"+exchRateDate;
			document.getElementsByName("cdn2")[0].title=" Name:"+exchName+"\r\n Rate:"+exchRate+"\r\n Date:"+exchRateDate;
			document.getElementById("cdnFlag1").style.visibility='visible';
			document.getElementById("cdnFlag2").style.visibility='visible';
		}
		else{
			document.getElementsByName("cdn1")[0].title="";
			document.getElementsByName("cdn2")[0].title="";
			document.getElementById("cdnFlag1").style.visibility='hidden';
			document.getElementById("cdnFlag2").style.visibility='hidden';
		}

	}
	function getLVRRepPrice(){
		var strURL=document.form1.url14.value;
		var form=document.forms['form1'];
		if(document.priceCalcForm.commission.value==""){
			if(document.form1.group.value.toUpperCase()=="REP-DLVR"){
				document.priceCalcForm.commission.value="2";
			}
			else{
				document.priceCalcForm.commission.value="15";
			}
		}
		var values='&orderNo='+escape(form.orderNo.value);
		values=values+'&commission='+escape(document.priceCalcForm.commission.value);
		values=values+'&product='+escape(form.product.value);
		var req=new XMLHttpRequest();
		var handlerFunction=getReadyStateHandler(req,getLVRRepPrice2);
		req.onreadystatechange=handlerFunction;
		req.open("POST",strURL,true);
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		req.send(values);
	}
	function getLVRRepPrice2(searchXML){
		var count=searchXML.getElementsByTagName("price").length;
		for(var i=0;i<count;i++){
			var TEMPprice=searchXML.getElementsByTagName("price")[i].childNodes[0].nodeValue;
			TEMPprice=TEMPprice.replace("#","");
			document.priceCalcForm.totalCost.value=(TEMPprice*1).toFixed(2);
		}
	}
	function checkBpcs(){
		if(document.form1.bpcsNo.value.length>0){
			document.getElementById('bpcsClosedLabel').innerHTML="<font color='red'>CHECKING BPCS</font>";
			var strURL="checkBpcsNo.jsp";
			var form=document.forms['form1'];
			var values='&bpcsNo='+escape(document.form1.bpcsNo.value);
			var req=new XMLHttpRequest();
			var handlerFunction=getReadyStateHandler(req,checkBpcs2);
			req.onreadystatechange=handlerFunction;
			req.open("POST",strURL,true);
			req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			req.send(values);
		}

	}
	function checkBpcs2(searchXML){
		var count=searchXML.getElementsByTagName("closed").length;
		for(var i=0;i<count;i++){
			var TEMPclosed=searchXML.getElementsByTagName("closed")[i].childNodes[0].nodeValue;
			TEMPclosed=TEMPclosed.replace("#","");
			if(TEMPclosed.toUpperCase()=="TRUE"){
				var msg="<font color='red'>"+document.form1.bpcsNo.value+" CLOSED IN BPCS</font>";
				document.getElementById('bpcsClosedLabel').innerHTML=msg;
			}
			else{
				document.getElementById('bpcsClosedLabel').innerHTML="";
			}
		}
	}
	function sectionValidation(){
		var strURL="checkSections.jsp";
		var values='&orderNo='+escape(document.form1.orderNo.value);
		var req=new XMLHttpRequest();
		var handlerFunction=getReadyStateHandler(req,sectionValidation2);
		req.onreadystatechange=handlerFunction;
		req.open("POST",strURL,true);
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		req.send(values);
	}
	function sectionValidation2(searchXML){
		var count=searchXML.getElementsByTagName("sectionValidation").length;
		var TEMPvalidation="";
		for(var i=0;i<count;i++){
			TEMPvalidation=searchXML.getElementsByTagName("sectionValidation")[i].childNodes[0].nodeValue;
			TEMPvalidation=TEMPvalidation.replace("#","");
			TEMPvalidation=TEMPvalidation.replace("<BR>","\r\n");
		}

		if(TEMPvalidation.trim().length>0){
			alert(TEMPvalidation);
			buttonsDiv.style.visibility='hidden';
			showSEC("xurl");
		}
	}
	function isCanada(x,y,z){
//alert(x+"::"+y+"::"+z);
		document.form1.exchName.value=x;
		document.form1.exchRate.value=y;
		document.form1.exchRateDate.value=z;
		//alert("is canada");
		var strURL="checkCurrency.jsp";
		var values='&orderNo='+escape(document.form1.orderNo.value);
		var req=new XMLHttpRequest();
		var handlerFunction=getReadyStateHandler(req,isCanada2);
		req.onreadystatechange=handlerFunction;
		req.open("POST",strURL,true);
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		req.send(values);
		//alert("run function currency.updateExchange(orderNo,'CAD')");
	}
	function isCanada2(searchXML){
		var count=searchXML.getElementsByTagName("exchName").length;
		var nameNew="";
		var rateNew="";
		var dateNew="";
		var nameOld=document.form1.exchName.value;
		var rateOld=document.form1.exchRate.value;
		var dateOld=document.form1.exchRateDate.value;
		for(var i=0;i<count;i++){
			nameNew=searchXML.getElementsByTagName("exchName")[i].childNodes[0].nodeValue;
			rateNew=searchXML.getElementsByTagName("exchRate")[i].childNodes[0].nodeValue;
			dateNew=searchXML.getElementsByTagName("exchRateDate")[i].childNodes[0].nodeValue;
		}
		nameNew=nameNew.replace("#","");
		rateNew=rateNew.replace("#","");
		dateNew=dateNew.replace("#","");
		rateOld=rateOld*1;
		rateNew=rateNew*1;
		dateNew=dateNew.substring(0,4)+"-"+dateNew.substring(4,6)+"-"+dateNew.substring(6,8);
		var compare="Attention, click OK to update the exchange rate to the most current, or click Cancel to keep the old exchange rate! \r\n \r\n";
		compare=compare+"Old Name:"+nameOld+" \t\t New Name:"+nameNew+" \r\n";
		compare=compare+"Old Rate:$"+rateOld.toFixed(2)+" \t\t New Rate:$"+rateNew.toFixed(2)+" \r\n";
		compare=compare+"Old Date:"+dateOld+" \t New Date:"+dateNew+" \r\n";
		var r=confirm(compare);
		if(r==true){
			var r2=confirm("Are you sure you want to update the exchange?");
			if(r2==true){
//alert("Updating Currency");
				var strURL="updateCurrency.jsp";
				var values='&orderNo='+escape(document.form1.orderNo.value);
				var req=new XMLHttpRequest();
				var handlerFunction=getReadyStateHandler(req,isCanada3);
				req.onreadystatechange=handlerFunction;
				req.open("POST",strURL,true);
				req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				req.send(values);
			}
		}

	}
	function isCanada3(searchXML){
		alert("Currency Updated.  Browser must reload.");
		document.location.reload(true);
	}
}
catch(err){
	alert("CONTACT ERAPID TEAM:::JAVASCRIPT ERROR"+err.message);
}

