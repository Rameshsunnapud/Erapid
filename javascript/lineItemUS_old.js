try{
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
		}
		else{
//alert("EVENT");
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
//alert("EMAIL");
				lineItems.style.visibility='hidden';
				showMailDiv("");
			}
		}

	},false);
	var exc;
	var qlf;
	var attemptCount=0;
	function lineItemScreen(){
		cancelHeader();
		updateLines();
	}
	function isNew(){
//alert("is new");
		if(document.form1.orderNo.value==""){
//alert("a");
			lineItems.style.visibility='hidden';
			mainbody.style.visibility='visible';
			pricecalc.style.visibility='hidden';
			header.style.visibility='visible';
			pricecalc2.style.visibility='hidden';
			mailDiv.style.visibility='hidden';
			owsDiv.style.visibility='hidden';
			secDiv.style.visibility='hidden';
			buttonsDiv.style.visibility='hidden';
			//alert(document.form1.qtype.value);
			//alert("b");
			updateAltHeader();
			//alert("c");
		}
		else{
			mailDiv.style.visibility='hidden';
			owsDiv.style.visibility='hidden';
			secDiv.style.visibility='hidden';
			updateLines();
			if(document.form1.SFDCpage.value=="header"){
//alert("Here1");
				editHeader();
				//alert("Here2");
			}
			else if(document.form1.SFDCpage.value=="priceCalc"){
				editPrice();
			}
			document.form1.SFDCpage.value="";
			//getButtons2();
		}
	}
	function headerDefaults(){
//alert("header defaults");

	}
	function newHeader(){
//alert("New header");
	}
	function updateAltHeader(){
//alert("update alt header");
		var strURL=document.form1.url7.value;
		var form=document.forms['form1'];
		var values='&altCpyNo='+escape(form.altCpyNo.value);
		values=values+'&qtype='+escape(form.qtype.value);
		values=values+'&product='+escape(form.product.value);
		//alert(values+":::"+document.form1.psaNo.value);
		if(document.form1.psaNo.value.length>0){
			values='&psaNo='+escape(form.psaNo.value);
			strURL=document.form1.url13.value;
		}
		var req=new XMLHttpRequest();
		var handlerFunction=getReadyStateHandler(req,updateSearch);
		req.onreadystatechange=handlerFunction;
		req.open("POST",strURL,true);
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		req.send(values);
	}
	function editPrice(){
//alert("edit price");

		lineItems.style.visibility='hidden';
		header.style.visibility='hidden';
		pricecalc.style.visibility='visible';
		pricecalc2.style.visibility='hidden';
		buttonsDiv.style.visibility='hidden';
		mailDiv.style.visibility='hidden';
		owsDiv.style.visibility='hidden';
		secDiv.style.visibility='hidden';
		//alert(document.form1.group.value+"::"+document.form1.creatorGroup.value);
		if((document.form1.product.value=="LVR"||document.form1.product.value=="GRILLE")&&document.form1.group.value.toUpperCase().indexOf("REP")<0){
//alert("factory");
			document.getElementById('cranPriceCalcIframe').src=document.form1.cranPriceCalcUrl.value;
		}
		else if((document.form1.product.value=="LVR"||document.form1.product.value=="GRILLE")&&document.form1.group.value.toUpperCase().indexOf("REP")>=0&&document.form1.creatorGroup.value.toUpperCase().indexOf("REP")<0){
//alert("FAcotry rep");
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
			//params=convertPL(params);
			req.send(params);
		}
	}
	function updatePriceCalc(searchXML){
		var count=searchXML.getElementsByTagName("orderNo").length;
		var strURL=document.form1.url12.value;
		var params="";
		//alert("HERE::"+count);
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
			//alert(TEMPhandlingCost);
			var TEMPfreightCost=searchXML.getElementsByTagName("freightCost")[i].childNodes[0].nodeValue;
			TEMPfreightCost=TEMPfreightCost.replace("#","");
			document.priceCalcForm.freightCost.value=TEMPfreightCost;
			var TEMPoverage=searchXML.getElementsByTagName("overage")[i].childNodes[0].nodeValue;
			TEMPoverage=TEMPoverage.replace("#","");
			document.priceCalcForm.overage.value=TEMPoverage;
			var TEMPtaxZip=searchXML.getElementsByTagName("taxZip")[i].childNodes[0].nodeValue;
			TEMPtaxZip=TEMPtaxZip.replace("#","");
			document.priceCalcForm.shipZip.value=TEMPtaxZip;
			//alert("a");
			var TEMPcommission=searchXML.getElementsByTagName("commission")[i].childNodes[0].nodeValue;
			//alert("B");
			TEMPcommission=TEMPcommission.replace("#","");
			//alert("C");
			//alert(TEMPcommission);
			document.priceCalcForm.commission.value=TEMPcommission;
			//alert("1");
			//alert("D");
			var TEMPtaxExempt=searchXML.getElementsByTagName("taxExempt")[i].childNodes[0].nodeValue;
			//alert("1.1");
			TEMPtaxExempt=TEMPtaxExempt.replace("#","");
			//alert("1.5"+TEMPtaxExempt);
			if(TEMPtaxExempt=="Y"){
//alert("CHECKED");
				document.priceCalcForm.taxExempt.checked=true;
			}
			if(document.form1.product.value=="IWP"&&document.form1.group.value.indexOf("REP")<0){
				var TEMPfreightOverride=searchXML.getElementsByTagName("freightOverride")[i].childNodes[0].nodeValue;
				TEMPfreightOverride=TEMPfreightOverride.replace("#","");
				//alert(TEMPfreightOverride);
				if(TEMPfreightOverride=="Y"){
//alert("CHECKED");
					document.priceCalcForm.freightOverride.checked=true;
					document.priceCalcForm.handlingCost.disabled=false;
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
					//params=convertPL(params);
					req3.send(params);
				}
			}
//document.priceCalcForm.taxExempt.value=TEMPtaxExempt;
//alert("2");



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
				//params=convertPL(params);
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
				//params=convertPL(params);
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
				//params=convertPL(params);
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
				//params=convertPL(params);
				req4.send(params);
			}
//alert("1");
			var req3x=new XMLHttpRequest();
			params="&orderNo="+document.form1.orderNo.value;
			params=params+"&productId="+document.form1.product.value;
			params=params+"&total="+TEMPtotalCost;
			params=params+"&charge=handling";
			//alert("2");
			var handlerFunctionx=getReadyStateHandler(req3x,priceCalcCharges5);
			req3x.onreadystatechange=handlerFunctionx;
			//alert("3"+params);
			req3x.open("POST",strURL,true);
			req3x.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			req3x.send(params);
			var req3y=new XMLHttpRequest();
			params="&orderNo="+document.form1.orderNo.value;
			params=params+"&productId="+document.form1.product.value;
			params=params+"&total="+TEMPtotalCost;
			params=params+"&charge=freight";
			//alert("2");
			var handlerFunctiony=getReadyStateHandler(req3y,priceCalcCharges1);
			req3y.onreadystatechange=handlerFunctiony;
			//alert("3"+params);
			req3y.open("POST",strURL,true);
			req3y.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			req3y.send(params);
			//alert("4");
		}
	}
	function freightOverrideChange(){
//alert("HERE");
		if(document.priceCalcForm.freightOverride.checked==true){
//alert("checked");
			document.priceCalcForm.handlingCost.disabled=false;
		}
		else{
//alert("not checked");
			document.priceCalcForm.handlingCost.disabled=true;
			document.priceCalcForm.handlingCost.value=document.priceCalcForm.calculatedFreight.value;
		}
	}
	function priceCalcCharges1(searchXML){
		var count=searchXML.getElementsByTagName("chargex").length;
		for(var i=0;i<count;i++){
			var TEMPcharge=searchXML.getElementsByTagName("chargex")[i].childNodes[0].nodeValue;
			TEMPcharge=TEMPcharge.replace("#","");
			if(TEMPcharge.length>0){
				document.priceCalcForm.freightCost.value=TEMPcharge;
			}
			else{
				document.priceCalcForm.freightCost.value=0;
			}
		}
//alert("freight");
	}
	function priceCalcCharges2(searchXML){
		var count=searchXML.getElementsByTagName("chargex").length;
		for(var i=0;i<count;i++){
			var TEMPcharge=searchXML.getElementsByTagName("chargex")[i].childNodes[0].nodeValue;
			TEMPcharge=TEMPcharge.replace("#","");
			if(TEMPcharge.length>0){
				document.priceCalcForm.overage.value=TEMPcharge;
			}
			else{
				document.priceCalcForm.overage.value=0;
			}
		}
//alert("overage");
//document.priceCalcForm.overage.value="2";
	}
	function priceCalcCharges3(searchXML){
		var count=searchXML.getElementsByTagName("chargex").length;
		for(var i=0;i<count;i++){
			var TEMPcharge=searchXML.getElementsByTagName("chargex")[i].childNodes[0].nodeValue;
			TEMPcharge=TEMPcharge.replace("#","");
			if(TEMPcharge.length>0){
				document.priceCalcForm.handlingCost.value=TEMPcharge;
			}
			else{
				document.priceCalcForm.handlingCost.value=0;
			}
		}
//alert("handling");
//document.priceCalcForm.handlingCost.value="3";
	}
	function priceCalcCharges4(searchXML){
		var count=searchXML.getElementsByTagName("chargex").length;
		for(var i=0;i<count;i++){
			var TEMPcharge=searchXML.getElementsByTagName("chargex")[i].childNodes[0].nodeValue;
			TEMPcharge=TEMPcharge.replace("#","");
			if(TEMPcharge.length>0){
				document.priceCalcForm.setupCost.value=TEMPcharge;
			}
			else{
				document.priceCalcForm.setupCost.value=0;
			}
		}
//alert("setup");
//document.priceCalcForm.setupCost.value="4";
	}
	function priceCalcCharges5(searchXML){
//alert("HEREpriceCalcCharges5");
		var count=searchXML.getElementsByTagName("chargex").length;
		//alert(count);
		for(var i=0;i<count;i++){
			var TEMPcharge=searchXML.getElementsByTagName("chargex")[i].childNodes[0].nodeValue;
			TEMPcharge=TEMPcharge.replace("#","");
			//alert("1");
			if(TEMPcharge.length>0){
				document.priceCalcForm.calculatedFreight.value=TEMPcharge;
			}
			else{
				document.priceCalcForm.calculatedFreight.value=0;
			}
			/*
			 //alert("2"+TEMPcharge);
			 var TEMPchargename=searchXML.getElementsByTagName("chargename")[i].childNodes[0].nodeValue;
			 TEMPchargename=TEMPchargename.replace("#","");
			 //alert("3"+TEMPchargename);
			 if(TEMPchargename=="handling"){
			 //alert("a");
			 document.priceCalcForm.handlingCost.value=TEMPcharge;
			 //alert("B");
			 }
			 if(TEMPchargename=="freight"){
			 document.priceCalcForm.freightCost.value=TEMPcharge;
			 }
			 */
//alert("4");
		}
		if(document.form1.product.value == "LVR" || document.form1.product.value == "GRILLE"){
			getLVRRepPrice();
		}
//alert("handling");
//document.priceCalcForm.handlingCost.value="3";
	}
	function editHeader(){
//alert("edit header");
		lineItems.style.visibility='hidden';
		mainbody.style.visibility='hidden';
		pricecalc.style.visibility='hidden';
		header.style.visibility='visible';
		pricecalc2.style.visibility='hidden';
		buttonsDiv.style.visibility='hidden';
		mailDiv.style.visibility='hidden';
		owsDiv.style.visibility='hidden';
		secDiv.style.visibility='hidden';
		updateHeader();
	}
	function cancelHeader(){
//alert("cancel header");
		if(document.form1.orderNo.value==""){
			document.location.href='home.jsp';
		}
		else{
			lineItems.style.visibility='visible';
			mainbody.style.visibility='visible';
			header.style.visibility='hidden';
			pricecalc.style.visibility='hidden';
			pricecalc2.style.visibility='hidden';
			buttonsDiv.style.visibility='hidden';
			mailDiv.style.visibility='hidden';
			owsDiv.style.visibility='hidden';
			secDiv.style.visibility='hidden';
		}
	}
	function savePriceCalc(){
		lineItems.style.visibility='hidden';
		mainbody.style.visibility='visible';
		pricecalc.style.visibility='hidden';
		header.style.visibility='hidden';
		pricecalc2.style.visibility='visible';
		buttonsDiv.style.visibility='hidden';
		mailDiv.style.visibility='hidden';
		owsDiv.style.visibility='hidden';
		secDiv.style.visibility='hidden';
		var params="";
		params="&orderNo="+document.form1.orderNo.value;
		params=params+"&totalCost="+document.priceCalcForm.totalCost.value;
		params=params+"&totalTax="+document.priceCalcForm.totalTax.value;
		params=params+"&total="+document.priceCalcForm.total.value;
		params=params+"&weightEst="+document.priceCalcForm.weightEst.value;
		params=params+"&weight="+document.priceCalcForm.weight.value;
		params=params+"&distance="+document.priceCalcForm.distance.value;
		params=params+"&transport="+document.priceCalcForm.transport.value;
		params=params+"&installDistance="+document.priceCalcForm.installDistance.value;
		params=params+"&installDiscount="+document.priceCalcForm.installDiscount.value;
		params=params+"&overage="+document.priceCalcForm.overage.value;
		params=params+"&setupCost="+document.priceCalcForm.setupCost.value;
		params=params+"&handlingCost="+document.priceCalcForm.handlingCost.value;
		params=params+"&freightCost="+document.priceCalcForm.freightCost.value;
		params=params+"&shipZip="+document.priceCalcForm.shipZip.value;
		params=params+"&taxExempt="+document.priceCalcForm.taxExempt.checked;
		params=params+"&freightOverride="+document.priceCalcForm.freightOverride.checked;
		params=params+"&commission="+document.priceCalcForm.commission.value;
		//alert(params);
		var strURL3=document.form1.url3.value;
		var tempZip=document.priceCalcForm.shipZip.value;
		if((tempZip.length==5&&document.form1.qtype.value=="O")||document.form1.qtype.value=="Q"){
			var req=new XMLHttpRequest();
			var handlerFunction=getReadyStateHandler(req,savePriceCalc2);
			req.onreadystatechange=handlerFunction;
			req.open("POST",strURL3,true);
			req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			//params=convertPL(params);
			req.send(params);
		}
		else{
			alert("You must enter a zip");
			editPrice();
		}
	}
	function savePriceCalc2(searchXML){
//alert("save price calc2");
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
			//alert("1");
			//document.getElementById('totalTaxLabel').innerHTML=searchXML.getElementsByTagName("totalTax")[i].childNodes[0].nodeValue;
			var TEMPtotalCost=searchXML.getElementsByTagName("totalCost")[i].childNodes[0].nodeValue;
			TEMPtotalCost=TEMPtotalCost.replace("#","");
			//var TEMPtotalTax=searchXML.getElementsByTagName("totalTax")[i].childNodes[0].nodeValue;
			//TEMPtotalTax=TEMPtotalTax.replace("#","");
			//alert("2");
			//document.priceCalcForm.totalTax.value=TEMPtotalTax;
			//var TEMPtotal =TEMPtotalCost*1+TEMPtotalTax*1;
			//document.getElementById('totalLabel').innerHTML=TEMPtotal.toFixed(2);;
			//document.getElementById('transportLabel').innerHTML=searchXML.getElementsByTagName("transCost")[i].childNodes[0].nodeValue;
			//var transportVat=searchXML.getElementsByTagName("transCost")[i].childNodes[0].nodeValue*(1*1+searchXML.getElementsByTagName("vat")[i].childNodes[0].nodeValue*1);
			//document.getElementById('transportTotalLabel').innerHTML=transportVat.toFixed(2);
			//alert("3");
			//var total=TEMPtotal+transportVat*1;
			//var TEMPinstall=searchXML.getElementsByTagName("installPrice")[i].childNodes[0].nodeValue;
			//var TEMPvat=searchXML.getElementsByTagName("vat")[i].childNodes[0].nodeValue;
			//alert("TEMPINSTALL:::"+TEMPinstall+"::"+TEMPvat);;

			//if(TEMPinstall>0){
			//	document.getElementById("installPriceLabel").innerHTML=(TEMPinstall*1).toFixed(2);
			//	document.getElementById("installTotalLabel").innerHTML=(TEMPinstall*1*(1+TEMPvat*1)).toFixed(2);
			//	total=total+TEMPinstall*1*(1+TEMPvat*1).toFixed(2);
			//}
			//document.getElementById('totalPriceLabel').innerHTML=total.toFixed(2);
			//alert("HEREx");
		}
		buttonsDiv.style.visibility='visible';
		//alert("HERE");
		getTax();
		getButtons();
	}
	function getTax(){
//alert("get tax");
		var params="";
		params="&orderNo="+document.form1.orderNo.value;
		var strURL="getTax.jsp";
		var req=new XMLHttpRequest();
		var handlerFunction=getReadyStateHandler(req,getTax2);
		req.onreadystatechange=handlerFunction;
		req.open("POST",strURL,true);
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		//params=convertPL(params);
		//alert(params);
		//alert("HERE");
		req.send(params);
	}
	function getTax2(searchXML){
		var count=searchXML.getElementsByTagName("orderNo").length;
		for(var i=0;i<count;i++){
			var taxTotal=searchXML.getElementsByTagName("taxTotal")[i].childNodes[0].nodeValue*1;
			document.getElementById('totalTaxLabel').innerHTML=taxTotal.toFixed(2);
			//document.getElementById('taxZipLabel').innerHTML=searchXML.getElementsByTagName("taxZip")[i].childNodes[0].nodeValue;
			document.getElementById('taxRateLabel').innerHTML=searchXML.getElementsByTagName("taxRate")[i].childNodes[0].nodeValue;
			//document.getElementById('isValidZipLabel').innerHTML=searchXML.getElementsByTagName("taxIsValidZip")[i].childNodes[0].nodeValue;
			//document.getElementById('isTaxStateLabel').innerHTML=searchXML.getElementsByTagName("taxIsTaxState")[i].childNodes[0].nodeValue;
			var total=document.getElementById('totalCostLabel').innerHTML*1+document.getElementById('setupCostLabel').innerHTML*1+document.getElementById('handlingCostLabel').innerHTML*1+document.getElementById('freightCostLabel').innerHTML*1+document.getElementById('overageLabel').innerHTML*1+document.getElementById('totalTaxLabel').innerHTML*1;
			document.getElementById('totalLabel').innerHTML=total.toFixed(2);
		}
	}
	function getButtons(){
		var params="";
		params="&orderNo="+document.form1.orderNo.value;
		params=params+"&product="+document.form1.product.value;
		params=params+"&group="+document.form1.group.value;
		params=params+"&page=pricecalc2";
		params=params+"&country=US";
		var strURL5=document.form1.url5.value;
		var req=new XMLHttpRequest();
		var handlerFunction=getReadyStateHandler(req,showButtons);
		req.onreadystatechange=handlerFunction;
		req.open("POST",strURL5,true);
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		//params=convertPL(params);
		//alert(params);
		req.send(params);
	}
	function showButtons(searchXML){
//alert("show buttons");
		var params="";
		var isSFDC="";
		params="?orderNo="+document.form1.orderNo.value;
		var paramsInit=params;
		var count=searchXML.getElementsByTagName("name").length;
		var buttons="";
		var countx=0;
		for(var i=0;i<count;i++){
			var initUrl=searchXML.getElementsByTagName("url")[i].childNodes[0].nodeValue+params;
			var initUrlAdd=searchXML.getElementsByTagName("urlAdd")[i].childNodes[0].nodeValue;
			var seq=searchXML.getElementsByTagName("seq")[i].childNodes[0].nodeValue;
			//alert(initUrlAdd);
			//alert(isSFDC.length+seq);
			//alert(seq);
			seq=seq.replace("#","");
			if(seq>1000&&isSFDC.length==0){
//alert("is sequence over 1000 and issfdc length==0");
				isSFDC="true";
				buttons=buttons+"<center><table width='40%' border='0'>";
				buttons=buttons+"<TR>";
			}
			if(isSFDC.length>0){
				buttons=buttons+"<TD>";
				countx++;
			}
			initUrlAdd=initUrlAdd.replace("#bpcsNo#",document.form1.bpcsNo.value);
			initUrlAdd=initUrlAdd.replace("#username#",document.form1.userId.value);
			initUrlAdd=initUrlAdd.replace("#repQuote#",document.form1.repQuote.value);
			initUrlAdd=initUrlAdd.replace("#group#",document.form1.group.value);
			//alert(initUrlAdd);
			initUrlAdd=initUrlAdd.replace("#","");
			if(initUrlAdd=="null"){
				initUrlAdd="";
			}
			if(initUrlAdd.length>0){
// alert(initUrlAdd);
				initUrl=initUrl+initUrlAdd;
				initUrlAdd=initUrlAdd.replace(/&/g,"!");
				initUrlAdd=initUrlAdd.replace(/=/g,"@");
			}
			if(searchXML.getElementsByTagName("action")[i].childNodes[0].nodeValue!="pu"){
				params=params+"&urlx="+searchXML.getElementsByTagName("url")[i].childNodes[0].nodeValue+"&urlAddx="+initUrlAdd+"&action="+searchXML.getElementsByTagName("action")[i].childNodes[0].nodeValue+"&imstype="+searchXML.getElementsByTagName("imstype")[i].childNodes[0].nodeValue;
				initUrl="documentGenerator.jsp"+params;
			}
			if(searchXML.getElementsByTagName("action")[i].childNodes[0].nodeValue=="QUOTE OVER PRICE LIMIT"){
				alert("QUOTE IS OVER THE PRICE LIMIT SET OUT BY FACTORY.  PLEASE CONTACT THE FACTORY TO CONTINUE WITH THIS QUOTE");
			}else if(searchXML.getElementsByTagName("action")[i].childNodes[0].nodeValue=="div"){
				initUrl=searchXML.getElementsByTagName("url")[i].childNodes[0].nodeValue;
				document.emailForm.url.value=initUrl;
				buttons=buttons+"<input type='button' name='"+searchXML.getElementsByTagName("name")[i].childNodes[0].nodeValue+"' value='"+searchXML.getElementsByTagName("name")[i].childNodes[0].nodeValue+"' onclick="+searchXML.getElementsByTagName("jsfunction")[i].childNodes[0].nodeValue+"('"+initUrl+"') class='button2'>";
			}
			else{
				buttons=buttons+"<input type='button' name='"+searchXML.getElementsByTagName("name")[i].childNodes[0].nodeValue+"' value='"+searchXML.getElementsByTagName("name")[i].childNodes[0].nodeValue+"' onclick=n_window('"+initUrl+"') class='button2'>";
			}
			if(isSFDC.length>0){
				buttons=buttons+"</TD>";
				if(countx%3==0){
					buttons=buttons+"</tr><TR>";
				}
			}
			params=paramsInit;
		}
		if(isSFDC.length>0){
			buttons=buttons+"</tr></table>";
		}
//alert(buttons);
		document.getElementById("buttonsDiv").innerHTML="";
		var newdiv=document.createElement("div");
		//newdiv.style.position="absolute";
		newdiv.style.top=250;
		newdiv.innerHTML=buttons;
		var result=document.getElementById("buttonsDiv");
		result.appendChild(newdiv);
	}
	function showOWS(xurl){
//alert("HERE");
		pricecalc2.style.visibility='hidden';
		buttonsDiv.style.visibility='hidden';
		mailDiv.style.visibility='hidden';
		lineItems.style.visibility='hidden';
		mainbody.style.visibility='hidden';
		pricecalc.style.visibility='hidden';
		header.style.visibility='hidden';
		pricecalc2.style.visibility='hidden';
		mailDiv.style.visibility='hidden';
		buttonsDiv.style.visibility='hidden';
		owsDiv.style.visibility='visible';
		secDiv.style.visibility='hidden';
		//alert(document.form1.owsUrl.value);
		//document.getElementById('owsIframe').src=document.getElementById('owsIframe').src;
		document.getElementById('owsIframe').src=document.form1.owsUrl.value;
	}
	function showSEC(xurl){
//alert("HERE");
		pricecalc2.style.visibility='hidden';
		buttonsDiv.style.visibility='hidden';
		mailDiv.style.visibility='hidden';
		lineItems.style.visibility='hidden';
		mainbody.style.visibility='hidden';
		pricecalc.style.visibility='hidden';
		header.style.visibility='hidden';
		pricecalc2.style.visibility='hidden';
		mailDiv.style.visibility='hidden';
		buttonsDiv.style.visibility='hidden';
		owsDiv.style.visibility='hidden';
		secDiv.style.visibility='visible';
		//alert("HERE"+document.getElementById('secDiv').src);
		document.getElementById('secIframe').src=document.getElementById('secIframe').src;
		//alert("after");
	}
	function showMailDiv(xurl){

		pricecalc2.style.visibility='hidden';
		buttonsDiv.style.visibility='hidden';
		mailDiv.style.visibility='visible';
		owsDiv.style.visibility='hidden';
		secDiv.style.visibility='hidden';
		document.getElementById('emailIframe').src=document.form1.emailUrl.value;
		var params="&productId="+document.form1.product.value;
		params=params+"&group="+document.form1.group.value;
		params=params+"&projectType="+document.form1.projectType.value;
		var strURL=document.form1.url11.value;
		var req=new XMLHttpRequest();
		var handlerFunction=getReadyStateHandler(req,showEmailCheckBoxes);
		req.onreadystatechange=handlerFunction;
		req.open("POST",strURL,true);
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		//alert(params);
		//params=convertPL(params);
		req.send(params);
	}
	function showEmailCheckBoxes(searchXML){
		var count=searchXML.getElementsByTagName("file_name").length;
		var checkboxes="";
		for(var i=0;i<count;i++){
			var TEMPfile_name=searchXML.getElementsByTagName("file_name")[i].childNodes[0].nodeValue;
			if(TEMPfile_name.indexOf("http:")<0){
				TEMPfile_name=document.form1.fullServerName.value+"/erapid"+TEMPfile_name;
			}
			if(TEMPfile_name.indexOf("#orderNo#")>0){
				TEMPfile_name=TEMPfile_name.replace("#orderNo#","orderNo="+document.form1.orderNo.value);
			}
			TEMPfile_name=TEMPfile_name.replace("#","");
			var TEMPdoc_name=searchXML.getElementsByTagName("doc_name")[i].childNodes[0].nodeValue;
			TEMPdoc_name=TEMPdoc_name.replace("#","");
			checkboxes=checkboxes+"<input type='checkbox' name='"+TEMPfile_name+"' value='"+TEMPfile_name+"' onclick=emailAttach('"+TEMPfile_name+"')>"+TEMPdoc_name+"<BR>";
		}
		document.getElementById("emailCheckBoxDiv").innerHTML="";
		var newdiv=document.createElement("div");
		newdiv.style.top=250;
		newdiv.innerHTML=checkboxes;
		var result=document.getElementById("emailCheckBoxDiv");
		result.appendChild(newdiv);
		//document.emailForm.to.value=document.headerForm.shipName1.value;
	}
	function emailAttach(x){
//alert(x);
		x=x.replace(/&/g,"bbb");
		x=x.replace(/=/g,"aaa");
		//if(document.emailForm.attachfiles.value.length==0){
		//	document.emailForm.attachfiles.value=document.emailForm.attachfiles.value+x+"#";
		//}
		//else{
		document.emailForm.attachfiles.value=document.emailForm.attachfiles.value+"#"+x+"#";
		//}
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
		params=params+"&country=PL";
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
				buttons=buttons+"<input type='button' name='"+searchXML.getElementsByTagName("name")[i].childNodes[0].nodeValue+"' value='"+searchXML.getElementsByTagName("name")[i].childNodes[0].nodeValue+"' onclick=n_window('"+initUrl+"') class='button2'><br>";
			}
			else if(actionx=="pugc"){
				buttons=buttons+"<input type='button' name='"+searchXML.getElementsByTagName("name")[i].childNodes[0].nodeValue+"' value='"+searchXML.getElementsByTagName("name")[i].childNodes[0].nodeValue+"' onclick=gcwindow('"+initUrl+"') class='button2'><br>";
			}
			else if(actionx=="href"){
				buttons=buttons+"<input type='button' name='"+searchXML.getElementsByTagName("name")[i].childNodes[0].nodeValue+"' value='"+searchXML.getElementsByTagName("name")[i].childNodes[0].nodeValue+"' onclick=javascript:document.location.href='"+initUrl+"' class='button2'><br>";
			}
		}
		var globalChanges=document.form1.fullServerName.value+"/cse/cse?cmd=CI&csc=true&readonly=true&revision=1&username="+document.form1.userId.value+"&pid=SYS_GCH&order_no="+document.form1.orderNo.value+"&item_no="+document.lineItemForm.newLineNo.value+"&doc_type="+document.form1.qtype.value+"&detail1=DATA|ORDER|"+document.form1.orderNo.value+"&detail2=DATA|TYPE|"+document.form1.qtype.value+"&detail3=DATA|PID|"+document.form1.product.value+"&canurl="+document.form1.fullServerName.value+"/erapid/us/lineItem.jsp&returl="+document.form1.fullServerName.value+"/erapid/us/lineItem.jsp";
		var globalUpdate=document.form1.fullServerName.value+"/cse/cse?cmd=CI&csc=true&readonly=true&revision=1&username="+document.form1.userId.value+"&pid=SYS_GCH&order_no="+document.form1.orderNo.value+"&item_no="+document.lineItemForm.newLineNo.value+"&doc_type="+document.form1.qtype.value+"&detail1=DATA|ORDER|"+document.form1.orderNo.value+"&detail2=DATA|TYPE|"+document.form1.qtype.value+"U&detail3=DATA|PID|"+document.form1.product.value+"&canurl="+document.form1.fullServerName.value+"/erapid/us/lineItem.jsp&returl="+document.form1.fullServerName.value+"/erapid/us/lineItem.jsp";
		buttons=buttons.replace("globalChangeUrl",globalChanges);
		buttons=buttons.replace("globalUpdateUrl",globalUpdate);
		document.getElementById("headerButtonsDiv").innerHTML="";
		var newdiv=document.createElement("div");
		newdiv.style.top=250;
		newdiv.innerHTML=buttons;
		var result=document.getElementById("headerButtonsDiv");
		result.appendChild(newdiv);
	}
	function saveHeader(){
		var formobj=document.headerForm;
		var fieldRequired=Array("projectName","docType","custLoc","custName","quoteType");
		var fieldDescription=Array("Project Name","Doc Type","Customer","Customer ERROR","Quote Type");
		if(document.form1.product.value=="GE"){
			fieldRequired.push("groupCodes");
			fieldDescription.push("Group Code");
			fieldRequired.push("salesRegion");
			fieldDescription.push("Sales Region");
		}
		var winLossDesc="";
		var alertMsg="Missing info :\n";
		var l_Msg=alertMsg.length;
		for(var i=0;i<fieldRequired.length;i++){
			if(!(fieldRequired[i]=="quoteSource"&&(document.form1.qtype.value=="alt"||(document.form1.orderNo.value.indexOf("_00")<1&&document.form1.orderNo.value.length>0)))){
				var obj=formobj.elements[fieldRequired[i]];
				if(obj){
					switch(obj.type){
						case "select-one":
							if(obj.selectedIndex==-1||obj.options[obj.selectedIndex].text==""){
								alertMsg+=" - "+fieldDescription[i]+"\n";
							}
							break;
						case "select-multiple":
							if(obj.selectedIndex==-1){
								alertMsg+=" - "+fieldDescription[i]+"\n";
							}
							break;
						case "text":
						case "textarea":
							if(obj.value==""||obj.value==null||obj.value==" "){
								alertMsg+=" - "+fieldDescription[i]+"\n";
							}
							break;
						default:
							if(obj.value==""||obj.value==null||obj.value==" "){
								alertMsg+=" - "+fieldDescription[i]+"\n";
							}
					}
				}
			}
			else{
			}

		}
		if(alertMsg.length==l_Msg&&winLossDesc.length==0){
			lineItems.style.visibility='visible';
			mainbody.style.visibility='visible';
			pricecalc.style.visibility='hidden';
			header.style.visibility='hidden';
			pricecalc2.style.visibility='hidden';
			buttonsDiv.style.visibility='hidden';
			mailDiv.style.visibility='hidden';
			owsDiv.style.visibility='hidden';
			secDiv.style.visibility='hidden';
			var params="";
			params="&orderNo="+document.form1.orderNo.value;
			params=params+"&projectName="+escape(document.headerForm.projectName.value);
			params=params+"&custName="+escape(document.headerForm.custLoc.value);
			params=params+"&agentName="+escape(document.headerForm.agentName.value);
			params=params+"&custNo="+document.headerForm.custName.value;
			params=params+"&custLoc="+escape(document.headerForm.custLoc.value);
			params=params+"&jobLoc="+escape(document.headerForm.jobLoc.value);
			params=params+"&projectState="+escape(document.headerForm.projectState.value);
			params=params+"&archName="+escape(document.headerForm.archName.value);
			params=params+"&archLoc="+escape(document.headerForm.archLoc.value);
			params=params+"&exclusions="+escape(document.headerForm.exclusions.value);
			params=params+"&qualifyingNotes="+escape(document.headerForm.qualifyingNotes.value);
			params=params+"&shipPhone="+escape(document.headerForm.shipPhone.value);
			params=params+"&terriRep="+escape(document.headerForm.terriRep.value);
			params=params+"&marketType="+escape(document.headerForm.marketType.value);
			params=params+"&projectState2="+escape(document.headerForm.projectState.value);
			params=params+"&shipCountry="+escape(document.headerForm.shipCountry.value);
			params=params+"&followUpDate="+escape(document.headerForm.followUpDate.value);
			params=params+"&shipName1="+escape(document.headerForm.shipName1.value);
			params=params+"&internalNo="+escape(document.headerForm.internalNo.value);
			params=params+"&marketing="+escape(document.headerForm.marketing.value);
			params=params+"&closeDate="+escape(document.headerForm.closeDate.value);
			params=params+"&closePerc="+escape(document.headerForm.closePerc.value);
			params=params+"&quoteSource="+escape(document.headerForm.quoteSource.value);
			params=params+"&winLoss="+escape(document.headerForm.winLoss.value);
			params=params+"&docType="+escape(document.headerForm.docType.value);
			params=params+"&quoteType="+escape(document.headerForm.quoteType.value);
			params=params+"&competition="+escape(document.headerForm.competition.value);
			params=params+"&docDate="+escape(document.headerForm.docDate.value);
			params=params+"&entryDate="+escape(document.headerForm.entryDate.value);
			params=params+"&expiresDate="+escape(document.headerForm.expiresDate.value);
			params=params+"&winLossDesc="+escape(document.headerForm.winLossDesc.value);
			params=params+"&exclusionsFreeText="+escape(document.headerForm.exclusionsFreeText.value);
			params=params+"&qualifyingNotesFreeText="+escape(document.headerForm.qualifyingNotesFreeText.value);
			params=params+"&freeText="+escape(document.headerForm.freeText.value);
			params=params+"&internalNotes2="+escape(document.headerForm.internalNotes2.value);
			params=params+"&internalNotes="+escape(document.headerForm.internalNotes.value);
			params=params+"&qtype="+escape(document.form1.qtype.value);
			//alert(document.form1.qtype.value);
			params=params+"&product="+escape(document.form1.product.value);
			params=params+"&repNum="+escape(document.form1.repNum.value);
			params=params+"&altCpyNo="+escape(document.form1.altCpyNo.value);
			params=params+"&userId="+escape(document.form1.userId.value);
			params=params+"&projectType="+escape(document.headerForm.projectType.value);
			params=params+"&projectTypeId="+escape(document.headerForm.projectTypeId.value);
			params=params+"&showRecap="+document.headerForm.showRecap.checked;
			params=params+"&exchRate="+escape(document.headerForm.exchRate.value);
			params=params+"&exchName="+escape(document.headerForm.exchName.value);
			params=params+"&exchDate="+escape(document.headerForm.exchDate.value);
			params=params+"&groupCodes="+escape(document.headerForm.groupCodes.value);
			params=params+"&salesRegion="+escape(document.headerForm.salesRegion.value);
			params=params+"&constructionType="+escape(document.headerForm.constructionType.value);
			params=params+"&endUser="+escape(document.headerForm.endUser.value);
			params=params+"&bpcsOrderNo="+escape(document.headerForm.bpcsOrderNo.value);
			document.form1.params.value=params;
			document.form1.bpcsNo.value=document.headerForm.bpcsOrderNo.value;
			checkBpcs();
			document.getElementById('quoteTypeLabel').innerHTML=document.headerForm.docType.value;
			document.getElementById('projectNameLabel').innerHTML=document.headerForm.projectName.value;
			document.getElementById('archNameLabel').innerHTML=document.headerForm.archName.value;
			document.getElementById('docSalesPersonLabel').innerHTML=document.form1.repNum.value;
			document.getElementById('docHeaderLabel').innerHTML=document.headerForm.docDate.value;
			var tempwinloss=document.headerForm.winLoss.value;
			document.getElementById('winLossLabel').innerHTML=tempwinloss;
			document.getElementById('entryDateLabel').innerHTML=document.headerForm.entryDate.value;
			var strURL2=document.form1.url2.value;
			var req=new XMLHttpRequest();
			var handlerFunction=getReadyStateHandler(req,updateSearch);
			req.onreadystatechange=handlerFunction;
			req.open("POST",strURL2,true);
			req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			//params=convertPL(params);
			req.send(params);
			var tempDocType=document.headerForm.docType.value;
			if(tempDocType=="B"){
				tempDocType="Q";
			}
			document.form1.qtype.value=tempDocType;
			document.emailForm.to.value=document.headerForm.shipName1.value;
		}
		else{
//alert(alertMsg);
			if(winLossDesc.length==0){
				alert(alertMsg);
			}
		}
		var x=document.form1.altCpyNo.value.length;
		var y=document.form1.orderNo.value.length;
		// alert("test"+x+"::"+document.form1.orderNo.value.length);
		if(x>0&&y==0){
//alert("RELOAD IS TRUE");
			document.form1.reload.value="yes";
		}

	}
	function updateHeader(){
//alert("update header");
		var strURL=document.form1.url.value;
		var req=new XMLHttpRequest();
		var handlerFunction=getReadyStateHandler(req,updateSearch);
		req.onreadystatechange=handlerFunction;
		req.open("POST",strURL,true);
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		var form=document.forms['form1'];
		var orderno=escape(form.orderNo.value);
		var values='&orderNo='+escape(form.orderNo.value);
		//values=convertPL(values);
		req.send(values);
	}
	function updateSearch(searchXML){

		updateLines();
		//alert(document.form1.qtype.value);
		var count=searchXML.getElementsByTagName("orderNo").length;
		for(var i=0;i<count;i++){
			var TEMPproductId=searchXML.getElementsByTagName("productId")[i].childNodes[0].nodeValue;
			var TEMPorderNo=searchXML.getElementsByTagName("orderNo")[i].childNodes[0].nodeValue;
			var TEMPprojectName=searchXML.getElementsByTagName("projectName")[i].childNodes[0].nodeValue;
			var TEMPcustName=searchXML.getElementsByTagName("custName")[i].childNodes[0].nodeValue;
			var TEMPagentName=searchXML.getElementsByTagName("agentName")[i].childNodes[0].nodeValue;
			var TEMPcustLoc=searchXML.getElementsByTagName("custLoc")[i].childNodes[0].nodeValue;
			var TEMPjobLoc=searchXML.getElementsByTagName("jobLoc")[i].childNodes[0].nodeValue;
			var TEMPprojectState=searchXML.getElementsByTagName("projectState")[i].childNodes[0].nodeValue;
			TEMPprojectState=TEMPprojectState.toUpperCase();
			var TEMParchName=searchXML.getElementsByTagName("archName")[i].childNodes[0].nodeValue;
			var TEMParchLoc=searchXML.getElementsByTagName("archLoc")[i].childNodes[0].nodeValue;
			var TEMPexclusions=searchXML.getElementsByTagName("exclusions")[i].childNodes[0].nodeValue;
			var TEMPqualifyingNotes=searchXML.getElementsByTagName("qualifyingNotes")[i].childNodes[0].nodeValue;
			var TEMPcreatorUserName=searchXML.getElementsByTagName("creatorUserName")[i].childNodes[0].nodeValue;
			//alert("a");
			var TEMPcreatorGroup=searchXML.getElementsByTagName("creatorGroup")[i].childNodes[0].nodeValue;
			//alert("b");
			var TEMPexchName=searchXML.getElementsByTagName("exchName")[i].childNodes[0].nodeValue;
			var TEMPexchRate=searchXML.getElementsByTagName("exchRate")[i].childNodes[0].nodeValue;
			var TEMPexchDate=searchXML.getElementsByTagName("exchDate")[i].childNodes[0].nodeValue;
			//alert("c");
			////alert("2");
			var TEMPshipPhone="";
			var TEMPterriRep="";
			var TEMPmarketType="";
			var TEMPprojectState2="";
			var TEMPshipCountry="";
			var TEMPfollowUpDate="";
			var TEMPshipName1="";
			var TEMPinternalNo="";
			var TEMPmarketing="";
			var TEMPcompetition="";
			var TEMPcloseDate="";
			var TEMPclosePerc="";
			var TEMPquoteSource="";
			var TEMPwinLoss=searchXML.getElementsByTagName("winLoss")[i].childNodes[0].nodeValue;
			var TEMPdocType=searchXML.getElementsByTagName("docType")[i].childNodes[0].nodeValue;
			var TEMPbudget="";
			var TEMPdocDate=searchXML.getElementsByTagName("docDate")[i].childNodes[0].nodeValue;
			var TEMPentryDate=searchXML.getElementsByTagName("entryDate")[i].childNodes[0].nodeValue;
			var TEMPexpiresDate=searchXML.getElementsByTagName("expiresDate2")[i].childNodes[0].nodeValue;
			var TEMPwinLossDesc=searchXML.getElementsByTagName("winLossDesc")[i].childNodes[0].nodeValue;
			var TEMPexclusionsFreeText=searchXML.getElementsByTagName("exclusionsFreeText")[i].childNodes[0].nodeValue;
			var TEMPqualifyingNotesFreeText=searchXML.getElementsByTagName("qualifyingNotesFreeText")[i].childNodes[0].nodeValue;
			var TEMPfreeText=searchXML.getElementsByTagName("freeText")[i].childNodes[0].nodeValue;
			var TEMPprojectType=searchXML.getElementsByTagName("projectType")[i].childNodes[0].nodeValue;
			var TEMPprojectTypeId=searchXML.getElementsByTagName("projectTypeId")[i].childNodes[0].nodeValue;
			//alert("2");
			var TEMPdocPriority=searchXML.getElementsByTagName("docPriority")[i].childNodes[0].nodeValue;
			var TEMPshowRecap=searchXML.getElementsByTagName("showRecap")[i].childNodes[0].nodeValue;
			//alert("a");
			var TEMPgroupCode=searchXML.getElementsByTagName("groupCode")[i].childNodes[0].nodeValue;
			var TEMPsalesRegion=searchXML.getElementsByTagName("salesRegion")[i].childNodes[0].nodeValue;
			var TEMPconstructionType=searchXML.getElementsByTagName("constructionType")[i].childNodes[0].nodeValue;
			var TEMPendUser=searchXML.getElementsByTagName("endUser")[i].childNodes[0].nodeValue;
			//alert("B");
			var TEMPbpcsOrderNo=searchXML.getElementsByTagName("bpcsOrderNo")[i].childNodes[0].nodeValue;
			//alert(TEMPbpcsOrderNo);
			var TEMPinternalNotes2="";
			var TEMPinternalNotes="";
			TEMPprojectName=TEMPprojectName.replace("#","");
			TEMPproductId=TEMPproductId.replace("#","");
			//alert(TEMPproductId);
			TEMPcustName=TEMPcustName.replace("#","");
			TEMPagentName=TEMPagentName.replace("#","");
			TEMPcustLoc=TEMPcustLoc.replace("#","");
			TEMPjobLoc=TEMPjobLoc.replace("#","");
			TEMPprojectState=TEMPprojectState.replace("#","");
			TEMParchName=TEMParchName.replace("#","");
			TEMParchLoc=TEMParchLoc.replace("#","");
			TEMPexclusions=TEMPexclusions.replace("#","");
			TEMPqualifyingNotes=TEMPqualifyingNotes.replace("#","");
			TEMPshipPhone=TEMPshipPhone.replace("#","");
			TEMPterriRep=TEMPterriRep.replace("#","");
			TEMPmarketType=TEMPmarketType.replace("#","");
			TEMPprojectState2=TEMPprojectState.replace("#","");
			TEMPshipCountry=TEMPshipCountry.replace("#","");
			TEMPfollowUpDate=TEMPfollowUpDate.replace("#","");
			TEMPshipName1=TEMPshipName1.replace("#","");
			TEMPinternalNo=TEMPinternalNo.replace("#","");
			TEMPmarketing=TEMPmarketing.replace("#","");
			TEMPcompetition=TEMPcompetition.replace("#","");
			TEMPcloseDate=TEMPcloseDate.replace("#","");
			TEMPclosePerc=TEMPclosePerc.replace("#","");
			TEMPquoteSource=TEMPquoteSource.replace("#","");
			TEMPwinLoss=TEMPwinLoss.replace("#","");
			TEMPbudget=TEMPbudget.replace("#","");
			TEMPdocType=TEMPdocType.replace("#","");
			TEMPdocDate=TEMPdocDate.replace("#","");
			TEMPentryDate=TEMPentryDate.replace("#","");
			TEMPexpiresDate=TEMPexpiresDate.replace("#","");
			TEMPwinLossDesc=TEMPwinLossDesc.replace("#","");
			TEMPexclusionsFreeText=TEMPexclusionsFreeText.replace("#","");
			TEMPqualifyingNotesFreeText=TEMPqualifyingNotesFreeText.replace("#","");
			TEMPfreeText=TEMPfreeText.replace("#","");
			TEMPinternalNotes2=TEMPinternalNotes2.replace("#","");
			TEMPinternalNotes=TEMPinternalNotes.replace("#","");
			TEMPorderNo=TEMPorderNo.replace("#","");
			TEMPprojectType=TEMPprojectType.replace("#","");
			TEMPprojectTypeId=TEMPprojectTypeId.replace("#","");
			TEMPcreatorUserName=TEMPcreatorUserName.replace("#","");
			TEMPcreatorGroup=TEMPcreatorGroup.replace("#","");
			TEMPdocPriority=TEMPdocPriority.replace("#","");
			TEMPshowRecap=TEMPshowRecap.replace("#","");
			TEMPexchName=TEMPexchName.replace("#","");
			TEMPexchRate=TEMPexchRate.replace("#","");
			TEMPexchDate=TEMPexchDate.replace("#","");
			//alert("1");
			TEMPgroupCode=TEMPgroupCode.replace("#","");
			//alert("a");
			TEMPsalesRegion=TEMPsalesRegion.replace("#","");
			//alert("b");
			TEMPconstructionType=TEMPconstructionType.replace("#","");
			//alert("C");
			TEMPendUser=TEMPendUser.replace("#","");
			TEMPbpcsOrderNo=TEMPbpcsOrderNo.replace("#","");
			//alert(TEMPbpcsOrderNo+"::2");
			//alert("2");
			if(TEMPorderNo.length>0){
				document.form1.orderNo.value=TEMPorderNo;
				document.getElementById('orderNoLabel').innerHTML=TEMPorderNo;
				updateLines();
			}
			else if(document.form1.qtype.value=="build"){
				TEMPbpcsOrderNo="";
			}

			if(TEMPdocDate.length>10){
				TEMPdocDate=TEMPdocDate.substring(0,10);
			}
			if(TEMPentryDate.length>10){
				TEMPentryDate=TEMPentryDate.substring(0,10);
			}
			if(TEMPexpiresDate.length>10){
				TEMPexpiresDate=TEMPexpiresDate.substring(0,10);
			}
			document.headerForm.projectName.value=TEMPprojectName;
			document.headerForm.custName.value=TEMPcustName;
			document.headerForm.agentName.value=TEMPagentName;
			document.headerForm.custLoc.value=TEMPcustLoc;
			document.headerForm.jobLoc.value=TEMPjobLoc;
			document.headerForm.projectState.value=TEMPprojectState;
			document.headerForm.archName.value=TEMParchName;
			document.headerForm.archLoc.value=TEMParchLoc;
			document.headerForm.exclusions.value=TEMPexclusions;
			document.headerForm.qualifyingNotes.value=TEMPqualifyingNotes;
			document.headerForm.shipPhone.value=TEMPshipPhone;
			document.headerForm.terriRep.value=TEMPterriRep;
			document.headerForm.marketType.value=TEMPmarketType;
			document.headerForm.projectState2.value=TEMPprojectState;
			TEMPshipCountry="US";
			document.headerForm.shipCountry.value=TEMPshipCountry;
			document.headerForm.followUpDate.value=TEMPfollowUpDate;
			document.headerForm.shipName1.value=TEMPshipName1;
			document.headerForm.internalNo.value=TEMPinternalNo;
			document.headerForm.marketing.value=TEMPmarketing;
			document.headerForm.competition.value=TEMPcompetition;
			document.headerForm.closeDate.value=TEMPcloseDate;
			document.headerForm.closePerc.value=TEMPclosePerc;
			document.headerForm.quoteSource.value=TEMPquoteSource;
			document.headerForm.winLoss.value=TEMPwinLoss;
			if(TEMPbudget=="B"){
				TEMPdocType="B";
			}
			document.headerForm.docType.value=TEMPdocType;
			document.headerForm.docDate.value=TEMPdocDate;
			document.headerForm.entryDate.value=TEMPentryDate;
			document.headerForm.expiresDate.value=TEMPexpiresDate;
			document.headerForm.winLossDesc.value=TEMPwinLossDesc;
			document.headerForm.exclusionsFreeText.value=TEMPexclusionsFreeText;
			document.headerForm.qualifyingNotesFreeText.value=TEMPqualifyingNotesFreeText;
			document.headerForm.freeText.value=TEMPfreeText;
			document.headerForm.internalNotes2.value=TEMPinternalNotes2;
			document.headerForm.internalNotes.value=TEMPinternalNotes;
			if(document.form1.product.value.length<2&&(TEMPproductId.length>0||document.form1.orderNo.value=="")){
				document.form1.product.value=TEMPproductId;
			}
			document.form1.creatorUserName.value=TEMPcreatorUserName;
			document.form1.creatorGroup.value=TEMPcreatorGroup;
			document.headerForm.projectType.value=TEMPprojectType;
			document.headerForm.projectTypeId.value=TEMPprojectTypeId;
			if(TEMPdocPriority.length>0&&TEMPorderNo.length>0){
//alert("Here");
				document.headerForm.quoteType.disabled=true;
			}
			if((TEMPproductId=="IWP"||TEMPproductId=="EJC")&&document.form1.group.value.indexOf("REP")<0){
				if(TEMPshowRecap=="on"){
					document.headerForm.showRecap.checked=true;
				}
			}
			document.headerForm.quoteType.value=TEMPdocPriority;
			document.headerForm.exchName.value=TEMPexchName;
			document.headerForm.exchDate.value=TEMPexchDate;
			document.headerForm.exchRate.value=TEMPexchRate;
			document.headerForm.groupCodes.value=TEMPgroupCode;
			document.headerForm.salesRegion.value=TEMPsalesRegion;
			document.headerForm.constructionType.value=TEMPconstructionType;
			document.headerForm.endUser.value=TEMPendUser;
			document.headerForm.bpcsOrderNo.value=TEMPbpcsOrderNo;

		}
		if(document.form1.reload.value=="yes"){
			document.location.href="lineItem.jsp?orderNox="+TEMPorderNo;
		}
		getButtons2();
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
	}
	function updateLinesResults(searchXML){
//("update line results");
//alert("1");
		var count=searchXML.getElementsByTagName("orderNo").length;
		var htmlLines="<form name='lineItemForm'><table table border='0' width='99%'><tr class='header1'><td width='5%'>Line No</td><td width='5%'>&nbsp;</td><td width='2%'>";
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
		if(document.form1.group.value.indexOf("Rep")>=0&&(document.form1.projectType.value=="SFDC"||document.form1.projectType.value=="PSA")){
			htmlLines=htmlLines+"</td><td width='7%'>Product</td><td width='72%'>Description</td></tr>";
		}
		else{
			htmlLines=htmlLines+"</td><td width='7%'>Product</td><td width='62%'>Description</td><td width='5%'>QTY</td><td width='5%'>Price</td><td width='6%'>Discount</td><td width='8%'>Status</td></tr>";
		}
//alert("2");
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
		//alert("3");
		for(var i=0;i<count;i++){
			TEMPorderNo=searchXML.getElementsByTagName("orderNo")[i].childNodes[0].nodeValue;
			TEMPorderNo=TEMPorderNo.replace("#","");
			var TEMPstatus=searchXML.getElementsByTagName("status")[i].childNodes[0].nodeValue;
			//alert(TEMPstatus);
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
			var TEMPwdth=searchXML.getElementsByTagName("wdth")[i].childNodes[0].nodeValue;
			TEMPwdth=TEMPwdth.replace("#","");
			var TEMPlgth=searchXML.getElementsByTagName("lgth")[i].childNodes[0].nodeValue;
			TEMPlgth=TEMPlgth.replace("#","");
			var TEMPsqmp=searchXML.getElementsByTagName("sqmp")[i].childNodes[0].nodeValue;
			TEMPsqmp=TEMPsqmp.replace("#","");
			var TEMPsqm=searchXML.getElementsByTagName("sqm")[i].childNodes[0].nodeValue;
			TEMPsqm=TEMPsqm.replace("#","");
			//alert(TEMPproductId+"1");
			if(TEMPproductId.length==0){
				TEMPproductId=document.form1.product.value;
			}
			var TEMPsqmm2="0.00";
			if(TEMPsqm.length==0){
				TEMPsqm="0";
			}
			else{
				TEMPsqmm2=(TEMPextendedPrice*1/TEMPsqm*1);
				//alert(TEMPsqmm2);
				TEMPsqmm2=TEMPsqmm2.toFixed(2);
				//alert(TEMPsqmm2);
			}
			if(TEMPsqmp.length==0){
				TEMPsqmp="0";
			}
//alert(TEMPproductId+"2");
//lert(document.form1.group.value+"::"+document.form1.qtype.value+"::"+document.form1.creatorUserName.value+"::"+document.form1.creatorGroup.value);

			if(document.form1.group.value.indexOf("Rep")<0&&document.form1.creatorGroup.value.indexOf("Rep")>=0&&document.form1.qtype.value=="Q"){
				cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+document.form1.creatorUserName.value+"&pid="+TEMPproductId+"&orderno="+TEMPorderNo+"&item_no="+TEMPlineNo+"&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItem.jsp&returl="+fullServerName+"/erapid/us/lineItem.jsp";
			}
			else{
				cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid="+TEMPproductId+"&orderno="+TEMPorderNo+"&item_no="+TEMPlineNo+"&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItem.jsp&returl="+fullServerName+"/erapid/us/lineItem.jsp";
			}
//htmlLines=htmlLines+cseUrl+"<BR><BR>";
			if(TEMPlineNo*1>lastLineNo*1){
				if(ii%2==0){
					cssClass="roweven";
				}
				else{
					cssClass="rowodd";
				}
				ii++;
				htmlLines=htmlLines+"<tr class='"+cssClass+"'>";
				htmlLines=htmlLines+"<td align='center'>"+TEMPlineNo+"</td>";
				lastLineNo=TEMPlineNo;
				if(document.form1.group.value.indexOf("Rep")>=0&&(document.form1.projectType.value=="SFDC"||document.form1.projectType.value=="PSA")&&quoteType=="Q"){
					htmlLines=htmlLines+"<td>&nbsp;</td>";
					htmlLines=htmlLines+"<td>&nbsp;</td>";
				}
				else{
					htmlLines=htmlLines+"<td><input type='button' name='Edit' value='Edit' class='button' onclick=\"javascript:document.location.href='"+cseUrl+"' \"></td>";
					if(document.form1.group.value.indexOf("Rep")>=0&&(document.form1.projectType.value=="SFDC"||document.form1.projectType.value=="PSA")){
						htmlLines=htmlLines+"<td>&nbsp;</td>";
					}
					else{
						htmlLines=htmlLines+"<td ><input type='checkbox' name='deletex' value='"+TEMPlineNo+"'></td>";
					}
				}
				htmlLines=htmlLines+"<td>"+TEMPproductId+"&nbsp;</td>";
				htmlLines=htmlLines+"<td>"+TEMPdescription+"&nbsp;</td>";
				//alert(document.form1.projectType.value);
				if(document.form1.group.value.indexOf("Rep")>=0&&(document.form1.projectType.value=="SFDC"||document.form1.projectType.value=="PSA")){

				}
				else{
					htmlLines=htmlLines+"<td align='right'>"+TEMPqty+"&nbsp;</td>";
					htmlLines=htmlLines+"<td align='right'>"+TEMPextendedPrice+"&nbsp;</td>";
					htmlLines=htmlLines+"<td>"+TEMPfield19+"&nbsp;</td>";
					htmlLines=htmlLines+"<td>"+TEMPstatus+"&nbsp;</td>";
				}
//alert("2");

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
		htmlLines=htmlLines+"<td align='center'>&nbsp;</td>";
		if(quoteType=="Q"){
			if(!(TEMPproductId=="LVR"||TEMPproductId=="GRILLE"||TEMPproductId=="GE")){
				if(document.form1.group.value.indexOf("Rep")<0&&document.form1.creatorGroup.value.indexOf("Rep")>=0&&document.form1.qtype.value=="Q"){
					cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+document.form1.creatorUserName.value+"&pid="+TEMPproductId+"&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItem.jsp&returl="+fullServerName+"/erapid/us/lineItem.jsp";
				}
				else{
					cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid="+TEMPproductId+"&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItem.jsp&returl="+fullServerName+"/erapid/us/lineItem.jsp";
				}
				if(document.form1.quoteOrigin.value=="sample"){
					cseUrl=cseUrl+"&detail2=FLAGS|SAMPLE|";
					//alert(cseUrl);
				}
				if(document.form1.group.value.indexOf("Rep")>=0&&(document.form1.projectType.value=="SFDC"||document.form1.projectType.value=="PSA")){
					htmlLines=htmlLines+"<td>&nbsp;</td>";
				}
				else{
					htmlLines=htmlLines+"<td><input type='button' name='New' value='New' class='button' onclick=\"javascript:document.location.href='"+cseUrl+"' \"></td>";
				}
			}
			else{
//alert("f");
				if(document.form1.group.value.indexOf("Rep")>=0&&(document.form1.projectType.value=="SFDC"||document.form1.projectType.value=="PSA")){
					htmlLines=htmlLines+"<td>&nbsp;</td>";
				}
				else{
					htmlLines=htmlLines+"<td><select name='PID' class='priceCalcSelect' onchange='pidPulldown()'><option value=''>Select Product</option>";
					if(TEMPproductId == "LVR"){
//cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=GRILLE&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItem.jsp&returl="+fullServerName+"/erapid/us/lineItem.jsp";
//htmlLines=htmlLines+"<option value='"+cseUrl+"'>GRILLE</option>";
						cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=LVR&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItem.jsp&returl="+fullServerName+"/erapid/us/lineItem.jsp";
						htmlLines=htmlLines+"<option value='"+cseUrl+"'>LVR</option>";
						cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=BV&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItem.jsp&returl="+fullServerName+"/erapid/us/lineItem.jsp";
						htmlLines=htmlLines+"<option value='"+cseUrl+"'>BV</option>";
						cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=GEN&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItem.jsp&returl="+fullServerName+"/erapid/us/lineItem.jsp&detail3=FLAGS|PID|"+TEMPproductId;
						//alert(cseUrl);
						htmlLines=htmlLines+"<option value='"+cseUrl+"'>GEN</option>";
					}
					else if(TEMPproductId=="GRILLE"){
						cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=GRILLE&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItem.jsp&returl="+fullServerName+"/erapid/us/lineItem.jsp";
						htmlLines=htmlLines+"<option value='"+cseUrl+"'>GRILLE</option>";
						cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=SUN&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItem.jsp&returl="+fullServerName+"/erapid/us/lineItem.jsp";
						htmlLines=htmlLines+"<option value='"+cseUrl+"'>SUN</option>";
						cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=LVR&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItem.jsp&returl="+fullServerName+"/erapid/us/lineItem.jsp";
						htmlLines=htmlLines+"<option value='"+cseUrl+"'>LVR</option>";
						cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=GEN&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItem.jsp&returl="+fullServerName+"/erapid/us/lineItem.jsp&detail3=FLAGS|PID|"+TEMPproductId;
						//alert(cseUrl);
						htmlLines=htmlLines+"<option value='"+cseUrl+"'>GEN</option>";
					}
					else{
						cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=GE&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItem.jsp&returl="+fullServerName+"/erapid/us/lineItem.jsp";
						htmlLines=htmlLines+"<option value='"+cseUrl+"'>GE</option>";
						cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=IWP&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItem.jsp&returl="+fullServerName+"/erapid/us/lineItem.jsp";
						htmlLines=htmlLines+"<option value='"+cseUrl+"'>IWP</option>";
						cseUrl=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+userId+"&pid=EFS&orderno="+TEMPorderNo+"&item_no="+newLineNo+"&doc_type="+quoteType+"&canurl="+fullServerName+"/erapid/us/lineItem.jsp&returl="+fullServerName+"/erapid/us/lineItem.jsp";
						htmlLines=htmlLines+"<option value='"+cseUrl+"'>EFS</option>";
					}
					htmlLines=htmlLines+"</select></td>";
				}
			}
		}
//alert("5");
		if(document.form1.group.value.indexOf("Rep")>=0&&(document.form1.projectType.value=="SFDC"||document.form1.projectType.value=="PSA")){
			htmlLines=htmlLines+"<td>&nbsp;</td>";
		}
		else if(count>0){
			htmlLines=htmlLines+"<td><input type='button' name='deleteLinesTest' value='Delete'  class='button' onclick='deleteLines()'></td>";
		}
		else{
			htmlLines=htmlLines+"<td>&nbsp;</td>";
		}
		htmlLines=htmlLines+"<td colspan='6'>&nbsp;</td></tr>";
		//alert(document.form1.sfdcUrl.value);
		var sfdcUrl=document.form1.sfdcUrl.value;
		if(sfdcUrl.length>0){
			htmlLines=htmlLines+"<tr><td colspan='5'><a href='"+document.form1.sfdcUrl.value+"' target='_top' ><img border='0' src='../images/sfdc_image1.jpg'></a></td></tr>";
		}
		htmlLines=htmlLines+"</table>";
		//alert("6");
		htmlLines=htmlLines+"<input type='hidden' name='newLineNo' value='"+newLineNo+"'></form>";
		document.getElementById("lineItems").innerHTML=htmlLines;
		//alert("7");
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
	function closeCustomer(){
//alert("close customer");
		customerSearchResultsHeader.style.visibility='hidden';
		customerx.style.visibility='hidden';
		document.headerForm.winLoss.disabled=false;
		document.headerForm.docType.disabled=false;
		document.headerForm.docDate.disabled=false;
		document.headerForm.entryDate.disabled=false;
		document.headerForm.expiresDate.disabled=false;
		document.headerForm.projectName.disabled=false;
		document.headerForm.jobLoc.disabled=false;
		document.headerForm.projectState.disabled=false;
		document.headerForm.archName.disabled=false;
		document.headerForm.archLoc.disabled=false;
		document.headerForm.exclusions.disabled=false;
		document.headerForm.qualifyingNotes.disabled=false;
		document.headerForm.exclusionsFreeText.disabled=false;
		document.headerForm.qualifyingNotesFreeText.disabled=false;
		document.headerForm.freeText.disabled=false;
		document.headerForm.custName.disabled=false;
		document.headerForm.custLoc.disabled=false;
		document.headerForm.shipPhone.disabled=false;
		document.headerForm.terriRep.disabled=false;
		document.headerForm.marketType.disabled=false;
		document.headerForm.projectState2.disabled=false;
		document.headerForm.shipCountry.disabled=false;
		document.headerForm.winLossDesc.disabled=false;
		document.headerForm.followUpDate.disabled=false;
		document.headerForm.shipName1.disabled=false;
		document.headerForm.internalNo.disabled=false;
		document.headerForm.internalNotes2.disabled=false;
		document.headerForm.internalNotes.disabled=false;
		document.headerForm.marketing.disabled=false;
		document.headerForm.closeDate.disabled=false;
		document.headerForm.closePerc.disabled=false;
		document.headerForm.quoteSource.disabled=false;
		document.headerForm.Save.disabled=false;
		document.headerForm.Cancel.disabled=false;
		document.custSearchHeader.selectx.value="no";
		saveUserCustomerDiv.style.visibility="hidden";
	}
	function openCustomer(select){
//alert("open customer");
		customerSearchResultsHeader.style.visibility='visible';
		customerEditHeader.style.visibility='hidden';
		customerx.style.visibility='visible';
		customerTEST.style.visibility='visible';
		document.custSearchHeader.searchCustomerCustomerName.value="";
		document.custSearchHeader.searchCustomerCity.value="";
		document.custSearchHeader.searchCustomerTaxNo.value="";
		document.custSearchHeader.searchCustomerBpcsNo.value="";
		document.custSearchHeader.selectx.value=select;
		changeCustomerSearchHeader("customerSearchBean.jsp");
		document.headerForm.winLoss.disabled=true;
		document.headerForm.docType.disabled=true;
		document.headerForm.docDate.disabled=true;
		document.headerForm.entryDate.disabled=true;
		document.headerForm.expiresDate.disabled=true;
		document.headerForm.projectName.disabled=true;
		document.headerForm.jobLoc.disabled=true;
		document.headerForm.projectState.disabled=true;
		document.headerForm.archName.disabled=true;
		document.headerForm.archLoc.disabled=true;
		document.headerForm.exclusions.disabled=true;
		document.headerForm.qualifyingNotes.disabled=true;
		document.headerForm.exclusionsFreeText.disabled=true;
		document.headerForm.qualifyingNotesFreeText.disabled=true;
		document.headerForm.freeText.disabled=true;
		document.headerForm.custName.disabled=true;
		document.headerForm.custLoc.disabled=true;
		document.headerForm.shipPhone.disabled=true;
		document.headerForm.terriRep.disabled=true;
		document.headerForm.marketType.disabled=true;
		document.headerForm.projectState2.disabled=true;
		document.headerForm.shipCountry.disabled=true;
		document.headerForm.note.disabled=true;
		document.headerForm.winLossDesc.disabled=true;
		document.headerForm.followUpDate.disabled=true;
		document.headerForm.shipName1.disabled=true;
		document.headerForm.internalNo.disabled=true;
		document.headerForm.internalNotes2.disabled=true;
		document.headerForm.internalNotes.disabled=true;
		document.headerForm.marketing.disabled=true;
		document.headerForm.closeDate.disabled=true;
		document.headerForm.closePerc.disabled=true;
		document.headerForm.quoteSource.disabled=true;
		document.headerForm.Save.disabled=true;
		document.headerForm.Cancel.disabled=true;
	}
	function changeCustomerSearchHeader(strURL){
//alert("change customer");
		document.getElementById("customerSearchResultsHeader").innerHTML="<center><font color='red' size='4'>LOADING....</font></center>";
		var req=new XMLHttpRequest();
		var handlerFunction=getReadyStateHandler(req,updateCustomersSearchHeader);
		req.onreadystatechange=handlerFunction;
		req.open("POST",strURL,true);
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		var form=document.forms['custSearchHeader'];
		var values='repNo='+escape(document.form1.userRepNo.value)+'&repGroup='+escape(form.searchCustomerRepGroup.value)+'&repCountry='+escape(form.searchCustomerRepCountry.value)+'&customerName='+escape(form.searchCustomerCustomerName.value)+'&customerCity='+escape(form.searchCustomerCity.value)+'&customerTaxNo='+escape(form.searchCustomerTaxNo.value)+'&customerBpcsNo='+escape(form.searchCustomerBpcsNo.value);
		if(document.custSearchHeader.selectx.value=="select"){
			values='repNo='+escape(document.form1.userRepNo.value)+'&repGroup='+escape(form.searchCustomerRepGroup.value)+'&repCountry='+escape(form.searchCustomerRepCountry.value)+'&customerName='+escape(form.searchCustomerCustomerName.value)+'&customerCity='+escape(form.searchCustomerCity.value)+'&customerTaxNo='+escape(form.searchCustomerTaxNo.value)+'&customerBpcsNo='+escape(form.searchCustomerBpcsNo.value);
		}
//values=convertPL(values);
//alert(values);
		req.send(values);
		//alert("2");
	}
	function updateCustomersSearchHeader(searchXML){
//alert("update customer search header");
//alert("3");
		saveUserCustomerDiv.style.visibility="hidden";
		var results=" <table border='0' width='1080px;'><tr class='header1'><td  width='10%'>&nbsp;</td><td  width='35%'>Name</td>"+
			   "<td  width='20%'>Address</td><td  width='10%'>City</td>"+
			   "<td  width='10%'>State</td><td  width='10%'>Zip</td>"+
			   "<td  width='5%'>Tax</td>"+
			   "</tr>";
		//alert("4");
		var count=searchXML.getElementsByTagName("custNo").length;
		var firstCustNo="";
		var lastCustNo="";
		var rowCount=count;
		//alert("5");
		for(var i=0;i<count;i++){
// alert("count::"+i);
			if(i==0){
				firstCustNo=searchXML.getElementsByTagName("custNo")[i].childNodes[0].nodeValue.replace("#","");
			}
			lastCustNo=searchXML.getElementsByTagName("custNo")[i].childNodes[0].nodeValue.replace("#","");
			//alert("a");
			var custNo=searchXML.getElementsByTagName("custNo")[i].childNodes[0].nodeValue;
			var custNoText=searchXML.getElementsByTagName("custNoText")[i].childNodes[0].nodeValue;
			var custName1=searchXML.getElementsByTagName("custName1")[i].childNodes[0].nodeValue;
			var custName2=searchXML.getElementsByTagName("custName2")[i].childNodes[0].nodeValue;
			var custAddr1=searchXML.getElementsByTagName("custAddr1")[i].childNodes[0].nodeValue;
			var custAddr2=searchXML.getElementsByTagName("custAddr2")[i].childNodes[0].nodeValue;
			var city=searchXML.getElementsByTagName("city")[i].childNodes[0].nodeValue;
			var state=searchXML.getElementsByTagName("state")[i].childNodes[0].nodeValue;
			var zipCode=searchXML.getElementsByTagName("zipCode")[i].childNodes[0].nodeValue;
			//alert("b");
			var country=searchXML.getElementsByTagName("country")[i].childNodes[0].nodeValue;
			//alert("1");
			var countryCode=searchXML.getElementsByTagName("countryCode")[i].childNodes[0].nodeValue;
			//alert("2");
			var bpcsCustNo=searchXML.getElementsByTagName("bpcsCustNo")[i].childNodes[0].nodeValue;
			//alert("3");
			var phone=searchXML.getElementsByTagName("phone")[i].childNodes[0].nodeValue;
			//alert("4");
			var contactName=searchXML.getElementsByTagName("contactName")[i].childNodes[0].nodeValue;
			//alert("5");
			var email=searchXML.getElementsByTagName("email")[i].childNodes[0].nodeValue;
			//alert("6");
			//var taxNo= searchXML.getElementsByTagName("taxNo")[i].childNodes[0].nodeValue;
			//alert("7");
			custNo=custNo.replace("#","");
			//alert("8");
			custNoText=custNoText.replace("#","");
			//alert("9");
			custName1=custName1.replace("#","");
			//alert("10");
			custName2=custName2.replace("#","");
			//alert("11");
			custAddr1=custAddr1.replace("#","");
			//alert("12");
			custAddr2=custAddr2.replace("#","");
			//alert("13");
			city=city.replace("#","");
			//alert("c");
			state=state.replace("#","");
			zipCode=zipCode.replace("#","");
			country=country.replace("#","");
			countryCode=countryCode.replace("#","");
			bpcsCustNo=bpcsCustNo.replace("#","");
			phone=phone.replace("#","");
			contactName=contactName.replace("#","");
			email=email.replace("#","");
			//taxNo= taxNo.replace("#","");
			var custName1x=custName1;
			var custName2x=custName2;
			var custAddr1x=custAddr1;
			var custAddr2x=custAddr2;
			//alert("d");
			if(custName1.length>40){
				custName1x=custName1.substring(0,40)+"<font color='red'>...</font>";
			}
			if(custName2.length>20){
				custName2x=custName2.substring(0,20)+"<font color='red'>...</font>";
			}
			if(custAddr1.length>20){
				custAddr1x=custAddr1.substring(0,20)+"<font color='red'>...</font>";
			}
			if(custAddr2.length>20){
				custAddr2x=custAddr2.substring(0,20)+"<font color='red'>...</font>";
			}
			custNo=custNo.replace(/ /g,"&nbsp;");
			custNoText=custNoText.replace(/ /g,"&nbsp;");
			custName1=custName1.replace(/'/g,"&#146");
			custName1=custName1.replace(/ /g,"&nbsp;");
			custName2=custName2.replace(/ /g,"&nbsp;");
			custAddr1=custAddr1.replace(/ /g,"&nbsp;");
			//alert("e");
			custAddr2=custAddr2.replace(/ /g,"&nbsp;");
			city=city.replace(/ /g,"&nbsp;");
			state=state.replace(/ /g,"&nbsp;");
			zipCode=zipCode.replace(/ /g,"&nbsp;");
			country=country.replace(/ /g,"&nbsp;");
			countryCode=countryCode.replace(/ /g,"&nbsp;");
			bpcsCustNo=bpcsCustNo.replace(/ /g,"&nbsp;");
			phone=phone.replace(/ /g,"&nbsp;");
			contactName=contactName.replace(/ /g,"&nbsp;");
			email=email.replace(/ /g,"&nbsp;");
			var cssClass="rowodd";
			if(i%2==0){
				cssClass="roweven";
			}
			if(document.custSearchHeader.selectx.value=="select"){
				results=results+"<tr class='"+cssClass+"'><td><input type='button' name='custNo' value='Use' class='button' onclick=selectCustomer('"+custName1+"','"+custNo+"','"+phone+"','"+contactName+"','"+state+"','"+email+"','"+custNoText+"')><input type='button' name='custNox' value='Edit' class='button' onclick=editCustomerx('"+custNo+"','"+countryCode+"')></td><td><a title='"+custName1+"'>"+custName1x+"</a></td><td><a title='"+custAddr1+"'>"+custAddr1x+"</a></td><td>"+city+"</td><td>"+state+"</td><td>"+zipCode+"</td><td>&nbsp;</td></tr>";
			}
			else{
				results=results+"<tr class='"+cssClass+"'><td><input type='button' name='custNox' value='Edit' class='button' onclick=editCustomerx('"+custNo+"','"+countryCode+"')></td>"+"<td><a title='"+custName1+"'>"+custName1x+"</a></td></td><td><a title='"+custAddr1+"'>"+custAddr1x+"</a></td><td>"+city+"</td><td>"+state+"</td><td>"+zipCode+"</td><td>&nbsp;</td></tr>";
			}
//alert("f");
		}
//alert("6");
		results=results+"</table>";
		document.getElementById("customerSearchResultsHeader").innerHTML="";
		var newdiv=document.createElement("div");
		newdiv.style.top=250;
		newdiv.innerHTML=results;
		var result=document.getElementById("customerSearchResultsHeader");
		result.appendChild(newdiv);
	}
	function addCustomer2(){
//alert("add customer2");
//alert("1");
		clearCustomerForm();
		//alert("2");
		customerSearchResultsHeader.style.visibility='visible';
		customerEditHeader.style.visibility='hidden';
		customerx.style.visibility='hidden';
		customerEditHeader.style.visibility='visible';
		document.editCustomer.countryCode.value=document.custSearchHeader.searchCustomerRepCountry.value;
		document.editCustomer.createdRepNo.value=document.custSearchHeader.searchCustomerRepNo.value;
		if(document.custSearchHeader.selectx.value=="select"){
			document.editCustomer.createdRepNo.value=document.form1.repNum.value;
		}
		document.editCustomer.country.value="UNITED STATES";
		if(document.custSearchHeader.selectx.value=="select"){
			saveUserCustomerDiv.style.visibility="visible";
		}
		else{
			saveUserCustomerDiv.style.visibility="hidden";
		}
//alert("3");
	}
	function selectCustomer(custName1,custNo,phone,contactName,state,email,custNoText){
//alert("a");
		if(document.editCustomer.isUse.value=="YES"){
			document.headerForm.custLoc.value=custName1;
			document.headerForm.custName.value=custNoText;
			document.headerForm.shipPhone.value=phone;
			document.headerForm.projectState.value=state;
			document.headerForm.shipName1.value=email;
			//alert("d");
			closeCustomer();
			goHome();
			//alert("is dup");
			//alert("b");
		}
		else{
//	alert("c");
			document.headerForm.custLoc.value=custName1;
			document.headerForm.custName.value=custNoText;
			document.headerForm.shipPhone.value=phone;
			document.headerForm.projectState.value=state;
			document.headerForm.shipName1.value=email;
			//alert("d");
			closeCustomer();
			goHome();
		}
//alert("HERE");

		selectContactHeader(custNoText);
		selectCurrency();
	}
	function notes(test){
//alert("notes");
		notesDiv.style.visibility='visible';
		loadNotes(test);
	}
	function cancelNotes(){
//alert("cancel notes");
		notesDiv.style.visibility='hidden';
		clearNotes();
	}
	function saveNotes(){
//alert("save notes");
		document.headerForm.exclusionsFreeText.value=document.notesForm.exclusionsFreeNotesForm.value;
		document.headerForm.qualifyingNotesFreeText.value=document.notesForm.qualifyingFreeNotesForm.value;
		document.headerForm.freeText.value=document.notesForm.freeTextNotesForm.value;
		document.headerForm.internalNotes.value=document.notesForm.internalNotesNotesForm.value;
		document.headerForm.internalNotes2.value=document.notesForm.internalNotes2NotesForm.value;
		var tempqlf="";
		var tempexc="";
		if(document.notesForm.cs_qlf_notes1){
			if(document.notesForm.cs_qlf_notes1.value=="undefined"){
			}
			else{
				if(document.notesForm.cs_qlf_notes1.checked==true){
					tempqlf=document.notesForm.cs_qlf_notes1.value;
				}
				else{
					for(var i=0;i<document.notesForm.cs_qlf_notes1.length;i++){
						if(document.notesForm.cs_qlf_notes1[i].checked==true){
							tempqlf=tempqlf+document.notesForm.cs_qlf_notes1[i].value+",";
						}
					}
				}
			}
		}
		if(document.notesForm.cs_exc_notes1){
			if(document.notesForm.cs_exc_notes1.value=="undefined"){
			}
			else{
				if(document.notesForm.cs_exc_notes1.checked==true){
					tempexc=document.notesForm.cs_exc_notes1.value;
				}
				else{
					for(var i=0;i<document.notesForm.cs_exc_notes1.length;i++){
						if(document.notesForm.cs_exc_notes1[i].checked==true){
							tempexc=tempexc+document.notesForm.cs_exc_notes1[i].value+",";
						}
					}
				}
			}
		}
		if(tempqlf.length>0){
			if(tempqlf.indexOf(",",tempqlf.length-1)>=0){
//alert(" qlf ends with ,");
				tempqlf=tempqlf.substring(0,tempqlf.length-1);
			}
		}
		if(tempexc.length>0){
			if(tempexc.indexOf(",",tempexc.length-1)>=0){
//alert(" exc ends with ,");
				tempexc=tempexc.substring(0,tempexc.length-1);
			}
		}
		document.headerForm.qualifyingNotes.value=tempqlf;
		document.headerForm.exclusions.value=tempexc;
		notesDiv.style.visibility='hidden';
		clearNotes();
	}
	function loadNotes(test){
//alert("load notes");

		document.notesForm.exclusionsFreeNotesForm.value=document.headerForm.exclusionsFreeText.value;
		document.notesForm.qualifyingFreeNotesForm.value=document.headerForm.qualifyingNotesFreeText.value;
		document.notesForm.freeTextNotesForm.value=document.headerForm.freeText.value;
		document.notesForm.internalNotesNotesForm.value=document.headerForm.internalNotes.value;
		document.notesForm.internalNotes2NotesForm.value=document.headerForm.internalNotes2.value;
		var tempexclusions=document.headerForm.exclusions.value;
		if(tempexclusions.length>0&&tempexclusions.slice(tempexclusions.length,1)!=","){
			tempexclusions+=","
		}
//alert("2");
		var iLoc=1;
		var iIndex="";
		do{
			iLoc=tempexclusions.search(",");
			if(iLoc>=0){
				iIndex=tempexclusions.slice(0,iLoc);
				tempexclusions=Trim(tempexclusions.slice(iLoc+1,tempexclusions.length));
				if(document.notesForm.cs_exc_notes1.checked==true||document.notesForm.cs_exc_notes1.checked==false){
					if(iIndex==document.notesForm.cs_exc_notes1.value){
						document.notesForm.cs_exc_notes1.checked=true;
					}
				}
				else{
					for(var i=0;i<document.notesForm.cs_exc_notes1.length;i++){
						if(iIndex==document.notesForm.cs_exc_notes1[i].value){
							document.notesForm.cs_exc_notes1[i].checked=true;
						}
					}
				}
			}
		}while(iLoc>=0);
		//alert("3");
		var tempqualifying=document.headerForm.qualifyingNotes.value;
		//alert("HERE");
		if(tempqualifying.length>0&&tempqualifying.slice(tempqualifying.length,1)!=","){
//alert("@");
			tempqualifying+=",";
			//alert("after");
			//alert(tempqualifying);
		}

		iLoc=1;
		iIndex="";
		do{
			iLoc=tempqualifying.search(",");
			if(iLoc>=0){
				iIndex=tempqualifying.slice(0,iLoc);
				tempqualifying=Trim(tempqualifying.slice(iLoc+1,tempqualifying.length));
				if(document.notesForm.cs_qlf_notes1.checked==true||document.notesForm.cs_qlf_notes1.checked==false){
					if(iIndex==document.notesForm.cs_qlf_notes1.value){
						document.notesForm.cs_qlf_notes1.checked=true;
					}
				}
				else{
					for(var i=0;i<document.notesForm.cs_qlf_notes1.length;i++){
						if(iIndex==document.notesForm.cs_qlf_notes1[i].value){
							document.notesForm.cs_qlf_notes1[i].checked=true;
						}
					}
				}
			}
		}while(iLoc>=0);
		if(test=="bottom"){
			var topPos=document.getElementById('testLabel').offsetTop;
			var x=document.getElementById('bottomnotes').offsetTop;
			x=document.getElementById('bottomnotes').scrollHeight;
			//alert(x);
			document.getElementById('bottomnotes').scrollTop=x;
		}
		else{
			document.getElementById('bottomnotes').scrollTop=0;
		}


	}
	function clearNotes(){
//alert("clear notes");
		document.notesForm.exclusionsFreeNotesForm.value="";
		document.notesForm.qualifyingFreeNotesForm.value="";
		document.notesForm.freeTextNotesForm.value="";
		document.notesForm.internalNotesNotesForm.value="";
		document.notesForm.internalNotes2NotesForm.value="";
		if(document.notesForm.cs_qlf_notes1){
			if(document.notesForm.cs_qlf_notes1.checked==true){
				tempqlf=document.notesForm.cs_qlf_notes1.checked=false;
			}
			else{
				for(var i=0;i<document.notesForm.cs_qlf_notes1.length;i++){
					document.notesForm.cs_qlf_notes1[i].checked=false;
				}
			}
		}
		if(document.notesForm.cs_exc_notes1){
			if(document.notesForm.cs_exc_notes1.checked==true){
				tempqlf=document.notesForm.cs_exc_notes1.checked=false;
			}
			else{
				for(var i=0;i<document.notesForm.cs_exc_notes1.length;i++){
					document.notesForm.cs_exc_notes1[i].checked=false;
				}
			}
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
	function saveUseCustomer(){
//alert("save use customer");
		saveCustomerx("true");
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
	function showCompetitor(x){
		if(document.headerForm.winLossDesc.value=="Konkurencja"){
			document.getElementById("div1").style.display='block';
		}
		else{
			document.getElementById("div1").style.display='none';
		}
//alert("here1");
		if(!document.headerForm.winLossDesc.value==""&&x!="x"){
//alert(x);
			if(document.headerForm.winLossDesc.value!="Puste"){
				document.headerForm.internalNotes.value=document.headerForm.winLossDesc.value+" : "+document.form1.today.value+" \n "+document.headerForm.internalNotes.value;
			}
		}
// alert("here2");
	}
	function closeOrder(){
//alert(document.headerForm.docType.value+"::"+document.headerForm.winLoss.value);
		if(document.headerForm.docType.value=="O"){
			document.headerForm.winLoss.value="CLOSE";
		}
	}
	function showArchitect(){
//alert("HERE");
		architectDiv.style.visibility='visible';
		document.getElementById('archIframe').src="architect.jsp";
	}
	function	selectCurrency(){
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
	function setRepQuote(){
//alert("HERE");
		var strURL="editRepQuote.jsp";
		var form=document.forms['form1'];
		var values='&orderNo='+escape(form.orderNo.value);
		values=values+'&repQuote='+escape(document.repQuoteForm.repQuote.value);
		//alert(values);
		var req=new XMLHttpRequest();
		var handlerFunction=getReadyStateHandler(req,setRepQuote2);
		req.onreadystatechange=handlerFunction;
		req.open("POST",strURL,true);
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		req.send(values);
	}
	function setRepQuote2(searchXML){
		alert("saved");
	}
	function getSalesRegion(){
//alert(document.headerForm.groupCodes.value);
		var strURL="setSalesRegion.jsp";
		//alert("1");
		var values='&groupCode='+escape(document.headerForm.groupCodes.value);
		var req=new XMLHttpRequest();
		//alert("2");
		var handlerFunction=getReadyStateHandler(req,getSalesRegion2);
		req.onreadystatechange=handlerFunction;
		//alert("3");
		req.open("POST",strURL,true);
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		//alert(values);
		req.send(values);
	}
	function getSalesRegion2(searchXML){
//alert("HERE");

		var count=searchXML.getElementsByTagName("region").length;
		//alert(count);

		for(var i=0;i<count;i++){
//alert("1");
			if(document.form1.qtype.value=="pfl"){
				var TEMPendUser=searchXML.getElementsByTagName("custNo")[i].childNodes[0].nodeValue;
				TEMPendUser=TEMPendUser.replace("#","");
				document.headerForm.endUser.value=TEMPendUser;
			}
//alert("2");
			var TEMPsalesRegion=searchXML.getElementsByTagName("region")[i].childNodes[0].nodeValue;
			//alert("3");
			TEMPsalesRegion=TEMPsalesRegion.replace("#","");
			//alert(TEMPsalesRegion);
			document.headerForm.salesRegion.value=TEMPsalesRegion;
		}
	}
	function getLVRRepPrice(){
		var strURL=document.form1.url14.value;
		var form=document.forms['form1'];
		if(document.priceCalcForm.commission.value==""){
			document.priceCalcForm.commission.value="15";
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
			//alert(TEMPclosed);
			if(TEMPclosed.toUpperCase()=="TRUE"){
				//alert("HERE1");
				var msg="<font color='red'>"+document.form1.bpcsNo.value+" CLOSED IN BPCS</font>";
				//alert(msg);
				document.getElementById('bpcsClosedLabel').innerHTML=msg;
			}
			else{
				//alert("HERE2");
				document.getElementById('bpcsClosedLabel').innerHTML="";
			}
		}
	}
}
catch(err){
	alert("CONTACT ERAPID TEAM:::JAVASCRIPT ERROR"+err.message);
}
