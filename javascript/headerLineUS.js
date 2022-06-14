try{
	function custMaint(){
		//document.getElementById("result").innerHTML = "";
		//document.getElementById("mainbody").innerHTML = "";
		//displayHeader.style.visibility='hidden';
		//header.style.visibility='hidden';
		//pricecalc.style.visibility='hidden';
		//pricecalc2.style.visibility='hidden';
		cancelHeader();
		openCustomer('no');
		customerSearchResultsHeader.style.visibility='visible';
		customerEditHeader.style.visibility='hidden';
		customerx.style.visibility='visible';
		document.custSearchHeader.searchCustomerCustomerName.value="";
		document.custSearchHeader.searchCustomerCity.value="";
		document.custSearchHeader.searchCustomerTaxNo.value="";
		changeCustomerSearchHeader("customerSearchBean.jsp")
		//customerSearchResults.style.visibility='visible';
		//changeCustomerSearch("customerSearchBean.jsp");
	}
	function goHome(){
		//alert("HERE");
		closeCustomer();
		customerx.style.visibility='hidden';
		customerTEST.style.visibility='hidden';
		customerSearchResultsHeader.style.visibility='hidden';
		customerEditHeader.style.visibility='hidden';
	}

	function changeCustomerSearch(strURL){

		var temp1=strURL;

		var form=document.forms['custSearch'];
		var values='repNo='+escape(form.searchCustomerRepNo.value)+'&repGroup='+escape(form.searchCustomerRepGroup.value)+'&repCountry='+escape(form.searchCustomerRepCountry.value)+'&customerName='+escape(form.searchCustomerCustomerName.value)+'&customerCity='+escape(form.searchCustomerCity.value)+'&customerTaxNo='+escape(form.searchCustomerTaxNo.value);

		setTimeout(function(){
			changeCustomerSearch2(temp1,values);
		},1000);
	}








	function changeCustomerSearch2(strURL,oldValues){

		//alert("change1");
		var req=new XMLHttpRequest();
		//alert("change1.3");
		var handlerFunction=getReadyStateHandler(req,updateCustomersSearch);
		//alert("change1.6");
		req.onreadystatechange=handlerFunction;
		//alert("change2");
		req.open("POST",strURL,true);
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		var form=document.forms['custSearch'];
		//alert("change3");
		var values='repNo='+escape(form.searchCustomerRepNo.value)+'&repGroup='+escape(form.searchCustomerRepGroup.value)+'&repCountry='+escape(form.searchCustomerRepCountry.value)+'&customerName='+escape(form.searchCustomerCustomerName.value)+'&customerCity='+escape(form.searchCustomerCity.value)+'&customerTaxNo='+escape(form.searchCustomerTaxNo.value);
		//alert("change3.5");
		if(values==oldValues){
			req.send(values);
		}
		//alert("change4");
		//alert(values);
	}
	function updateCustomersSearch(searchXML){

		var results=" <table border='0' width='1080px;'><tr class='header1'><td  width='10%'>&nbsp;</td><td  width='35%'>Name</td>"+
			   "<td  width='20%'>Address</td><td  width='10%'>City</td>"+
			   "<td  width='10%'>State</td><td  width='10%'>Zip</td>"+
			   "<td  width='5%'>Tax</td>"+
			   "</tr>";
		//alert(results);
		var count=searchXML.getElementsByTagName("custNo").length;
		var firstCustNo="";
		var lastCustNo="";
		var rowCount=count;
		for(var i=0;i<count;i++){
			if(i==0){
				firstCustNo=searchXML.getElementsByTagName("custNo")[i].childNodes[0].nodeValue.replace("#","");
			}
			lastCustNo=searchXML.getElementsByTagName("custNo")[i].childNodes[0].nodeValue.replace("#","");
			;
			var custNo=searchXML.getElementsByTagName("custNo")[i].childNodes[0].nodeValue;
			var custName1=searchXML.getElementsByTagName("custName1")[i].childNodes[0].nodeValue;
			var custName2=searchXML.getElementsByTagName("custName2")[i].childNodes[0].nodeValue;
			var custAddr1=searchXML.getElementsByTagName("custAddr1")[i].childNodes[0].nodeValue;
			var custAddr2=searchXML.getElementsByTagName("custAddr2")[i].childNodes[0].nodeValue;
			var city=searchXML.getElementsByTagName("city")[i].childNodes[0].nodeValue;
			var state=searchXML.getElementsByTagName("state")[i].childNodes[0].nodeValue;
			var zipCode=searchXML.getElementsByTagName("zipCode")[i].childNodes[0].nodeValue;
			var country=searchXML.getElementsByTagName("country")[i].childNodes[0].nodeValue;
			var countryCode=searchXML.getElementsByTagName("countryCode")[i].childNodes[0].nodeValue;
			var bpcsCustNo=searchXML.getElementsByTagName("bpcsCustNo")[i].childNodes[0].nodeValue;
			var taxNo=searchXML.getElementsByTagName("taxNo")[i].childNodes[0].nodeValue;
			custNo=custNo.replace("#","");
			custName1=custName1.replace("#","");
			custName2=custName2.replace("#","");
			custAddr1=custAddr1.replace("#","");
			custAddr2=custAddr2.replace("#","");
			city=city.replace("#","");
			state=state.replace("#","");
			zipCode=zipCode.replace("#","");
			country=country.replace("#","");
			countryCode=countryCode.replace("#","");
			bpcsCustNo=bpcsCustNo.replace("#","");
			taxNo=taxNo.replace("#","");
			if(custName1.length>40){
				custName1=custName1.substring(0,40)+"<font color='red'>...</font>";
			}
			if(custName2.length>40){
				custName2=custName2.substring(0,40)+"<font color='red'>...</font>";
			}
			if(custAddr1.length>40){
				custAddr1=custAddr1.substring(0,40)+"<font color='red'>...</font>";
			}
			if(custAddr2.length>40){
				custAddr2=custAddr2.substring(0,40)+"<font color='red'>...</font>";
			}

			var cssClass="rowodd";
			if(i%2==0){
				cssClass="roweven";
			}
			results=results+"<tr class='"+cssClass+"'><td><input type='button' name='custNo' value='"+custNo+"' class='button' onclick=editCustomerx('"+custNo+"','"+countryCode+"')></td>"+"<td>"+custName1+"</td><td>"+custAddr1+"</td><td>"+city+"</td><td>"+state+"</td><td>"+zipCode+"</td><td>"+taxNo+"</td></tr>";

		}
		//alert("HERE2");
		results=results+"</table>";

		//alert("1");
		document.getElementById("customerSearchResultsHeader").innerHTML="";
		//alert("2");
		var newdiv=document.createElement("div");
		//alert("3");
		newdiv.style.top=250;
		//alert("4");
		newdiv.innerHTML=results;
		//alert("5");
		var result=document.getElementById("customerSearchResultsHeader");
		//alert("6");
		result.appendChild(newdiv);
		//alert("7");
	}
	function editCustomerx(custNo,countryCode){
		//alert("heRE");
		var strURL="editCustomer.jsp";
		//result.style.visibility='hidden';
		//mainbody.style.visibility='hidden';
		customerx.style.visibility='hidden';
		customerSearchResultsHeader.style.visibility='hidden';
		customerEditHeader.style.visibility='visible';
		var req=new XMLHttpRequest();
		var handlerFunction=getReadyStateHandler(req,editCustomerResults);
		req.onreadystatechange=handlerFunction;
		req.open("POST",strURL,true);
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		var values='custNo='+escape(custNo)+'&countryCode='+escape(countryCode);
		req.send(values);
	}
	function editCustomerResults(searchXML){
		//alert("results ");
		var count=searchXML.getElementsByTagName("custNo").length;
		var rowCount=count;
		for(var i=0;i<count;i++){
			if(i==0){
				firstCustNo=searchXML.getElementsByTagName("custNo")[i].childNodes[0].nodeValue.replace("#","");
			}
			lastCustNo=searchXML.getElementsByTagName("custNo")[i].childNodes[0].nodeValue.replace("#","");
			var custNo=searchXML.getElementsByTagName("custNo")[i].childNodes[0].nodeValue;
			var custName1=searchXML.getElementsByTagName("custName1")[i].childNodes[0].nodeValue;
			var custName2=searchXML.getElementsByTagName("custName2")[i].childNodes[0].nodeValue;
			var custAddr1=searchXML.getElementsByTagName("custAddr1")[i].childNodes[0].nodeValue;
			var custAddr2=searchXML.getElementsByTagName("custAddr2")[i].childNodes[0].nodeValue;
			var city=searchXML.getElementsByTagName("city")[i].childNodes[0].nodeValue;
			var state=searchXML.getElementsByTagName("state")[i].childNodes[0].nodeValue;
			var zipCode=searchXML.getElementsByTagName("zipCode")[i].childNodes[0].nodeValue;
			var country=searchXML.getElementsByTagName("country")[i].childNodes[0].nodeValue;
			var countryCode=searchXML.getElementsByTagName("countryCode")[i].childNodes[0].nodeValue;
			var bpcsCustNo=searchXML.getElementsByTagName("bpcsCustNo")[i].childNodes[0].nodeValue;
			var attention=searchXML.getElementsByTagName("attention")[i].childNodes[0].nodeValue;
			var salutation=searchXML.getElementsByTagName("salutation")[i].childNodes[0].nodeValue;
			var phone=searchXML.getElementsByTagName("phone")[i].childNodes[0].nodeValue;
			var currency=searchXML.getElementsByTagName("currency")[i].childNodes[0].nodeValue;
			var shippingCity=searchXML.getElementsByTagName("shippingCity")[i].childNodes[0].nodeValue;
			var fax=searchXML.getElementsByTagName("fax")[i].childNodes[0].nodeValue;
			var email=searchXML.getElementsByTagName("email")[i].childNodes[0].nodeValue;
			var custNoText=searchXML.getElementsByTagName("custNoText")[i].childNodes[0].nodeValue;
			var createdRepNo=searchXML.getElementsByTagName("createdRepNo")[i].childNodes[0].nodeValue;
			var billCust=searchXML.getElementsByTagName("billingCust")[i].childNodes[0].nodeValue;
			var marketType=searchXML.getElementsByTagName("marketType")[i].childNodes[0].nodeValue;
			var contactName=searchXML.getElementsByTagName("contactName")[i].childNodes[0].nodeValue;
			var dormant=searchXML.getElementsByTagName("dormant")[i].childNodes[0].nodeValue;
			//var taxNo= searchXML.getElementsByTagName("taxNo")[i].childNodes[0].nodeValue;
			custNo=custNo.replace("#","");
			custName1=custName1.replace("#","");
			custName2=custName2.replace("#","");
			custAddr1=custAddr1.replace("#","");
			custAddr2=custAddr2.replace("#","");
			city=city.replace("#","");
			state=state.replace("#","");
			zipCode=zipCode.replace("#","");
			country=country.replace("#","");
			countryCode=countryCode.replace("#","");
			bpcsCustNo=bpcsCustNo.replace("#","");
			attention=attention.replace("#","");
			salutation=salutation.replace("#","");
			phone=phone.replace("#","");
			currency=currency.replace("#","");
			shippingCity=shippingCity.replace("#","");
			fax=fax.replace("#","");
			email=email.replace("#","");
			custNoText=custNoText.replace("#","");
			createdRepNo=createdRepNo.replace("#","");
			billCust=billCust.replace("#","");
			marketType=marketType.replace("#","");
			contactName=contactName.replace("#","");
			//taxNo=taxNo.replace("#","");
			document.editCustomer.custNo.value=custNo;
			document.editCustomer.custName1.value=custName1;
			document.editCustomer.custName2.value=custName2;
			document.editCustomer.custAddr1.value=custAddr1;
			document.editCustomer.custAddr2.value=custAddr2;
			document.editCustomer.city.value=city;
			document.editCustomer.state.value=state;
			document.editCustomer.zipCode.value=zipCode;
			document.editCustomer.country.value=country;
			document.editCustomer.countryCode.value=countryCode;
			document.editCustomer.bpcsCustNo.value=bpcsCustNo;
			document.editCustomer.attention.value=attention;
			document.editCustomer.salutation.value=salutation;
			document.editCustomer.phone.value=phone;
			document.editCustomer.currency.value=currency;
			document.editCustomer.shippingCity.value=shippingCity;
			document.editCustomer.fax.value=fax;
			document.editCustomer.email.value=email;
			document.editCustomer.custNoText.value=custNoText;
			document.editCustomer.createdRepNo.value=createdRepNo;
			//document.editCustomer.billCust.value=billCust;
			//alert(billCust);
			if(billCust=="Y"){
				//alert(billCust+"2");
				document.editCustomer.billCust.checked=true;
			}
			else{
				document.editCustomer.billCust.checked=false;
			}
			//alert("3");
			document.editCustomer.marketType.value=marketType;
			document.editCustomer.contactName.value=contactName;
			document.editCustomer.dormant.value=dormant;
			//document.editCustomer.taxNo.value=taxNo;
		}
		getContacts(custNo,countryCode);
		//alert("HERE");
		if(document.custSearchHeader.selectx.value=="select"){
			//document.getElementById("saveUseCustomer").style.visibility="visible";
			saveUserCustomerDiv.style.visibility="visible";
		}
		else{
			//document.getElementById("saveUseCustomer").style.visibility="hidden";
			saveUserCustomerDiv.style.visibility="hidden";
		}
		//alert("DONE");
	}
	function saveUseCustomerx(){

		document.editCustomer.isStop.value="";
		var temp1=document.editCustomer.custName1.value;
		var temp2=document.editCustomer.custNo.value;
		var temp3=document.editCustomer.phone.value;
		var temp4=document.editCustomer.contactName.value;
		var temp5=document.editCustomer.state.value;
		var temp6=document.editCustomer.email.value;
		var temp7=document.editCustomer.custNoText.value;
		document.editCustomer.isUse.value="true";
		//alert("HERE");
		checkCustomer("true");
		//alert(document.editCustomer.isStop.value);

		//if(document.editCustomer.isStop.value=="YES"){
		//	alert("ERROR");
		//}
		//else{
		//	selectCustomer(temp1,temp2,temp3,temp4,temp5,temp6,temp7);
		//}
		//document.editCustomer.isStop.value="";
	}
	function checkCustomer(isUse){

		var custAddr1=document.editCustomer.custAddr1.value;
		var city=document.editCustomer.city.value;
		var custNoText=document.editCustomer.custNoText.value;
		var createdRepNo=document.editCustomer.createdRepNo.value;
		document.editCustomer.isDup.value="";
		//alert("::"+createdRepNo);
		if(custNoText.length==0){
			//document.editCustomer.isUse.value=isUse;
			//alert("new");
			var strURL="checkCustomer.jsp";
			var req=new XMLHttpRequest();
			var handlerFunction=getReadyStateHandler(req,saveCustomerCheck);
			req.onreadystatechange=handlerFunction;
			req.open("POST",strURL,true);
			req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			var values='&custAddr1='+escape(custAddr1)+'&city='+escape(city)+'&createdRepNo='+escape(createdRepNo);
			values=convertPL(values);
			req.send(values);

		}
		else{
			//alert("edit");
			saveCustomerx(isUse);
		}
	}
	function saveCustomerCheck(searchXML){
		//alert("saveCustomerCheck");
		var isDup="";
		var isUse=document.editCustomer.isUse.value;
		//document.editCustomer.isUse.value="";
		var count=searchXML.getElementsByTagName("isDup").length;
		for(var i=0;i<count;i++){
			isDup=searchXML.getElementsByTagName("isDup")[i].childNodes[0].nodeValue;
		}
		//alert("before popup");
		isDup=isDup.replace("#","");
		if(isDup.length>0){
			document.editCustomer.isDup.value="YES";
			var answer=confirm("Warning potential duplicate. Customer: \n\r"+isDup+" Do you still want to add?");

			if(answer){
				//alert("Match found");
				saveCustomerx(isUse);
			}
			else{
				document.editCustomer.isStop.value="YES";
			}
		}
		else{
			saveCustomerx(isUse);
		}
	}
	function saveCustomerx(isUse){
alert("Enter GSO ")
		//alert(isUse);
//alert("1");
		var formobj=document.editCustomer;
		var fieldRequired=Array("custName1","custAddr1","zipCode","city");
		var fieldDescription=Array("Customer","Address1","Zip","City");
		var alertMsg="Required Fields:\n";
		var l_Msg=alertMsg.length;
		if(!document.editCustomer.dormant.checked){
			for(var i=0;i<fieldRequired.length;i++){
				var obj=formobj.elements[fieldRequired[i]];
				//alert(i+"::"+obj.type);
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
		}



		//alert("2");
		if(alertMsg.length==l_Msg){
			//alert("2.0");
			var custNo=document.editCustomer.custNo.value;
			var custName1=document.editCustomer.custName1.value;
			var custName2=document.editCustomer.custName2.value;
			var custAddr1=document.editCustomer.custAddr1.value;
			var custAddr2=document.editCustomer.custAddr2.value;
			var city=document.editCustomer.city.value;
			var state=document.editCustomer.state.value;

			var zipCode=document.editCustomer.zipCode.value;
			var country=document.editCustomer.country.value;
			var countryCode=document.editCustomer.countryCode.value;
			var bpcsCustNo=document.editCustomer.bpcsCustNo.value;
			var attention=document.editCustomer.attention.value;
			var salutation=document.editCustomer.salutation.value;
			var phone=document.editCustomer.phone.value;
			var currency=document.editCustomer.currency.value;

			var shippingCity=document.editCustomer.shippingCity.value;
			var fax=document.editCustomer.fax.value;
			var email=document.editCustomer.email.value;
			var custNoText=document.editCustomer.custNoText.value;
			var createdRepNo=document.editCustomer.createdRepNo.value;
			var billCust=document.editCustomer.billCust.checked;
			//alert(billCust);
			if(billCust==true){
				billCust="Y";
			}

			var marketType=document.editCustomer.marketType.value;
			var contactName=document.editCustomer.contactName.value;
			var dormant=document.editCustomer.dormant.checked;
			//var taxNo=document.editCustomer.taxNo.value;
			var strURL="saveCustomer.jsp";

			var req=new XMLHttpRequest();
			var handlerFunction=getReadyStateHandler(req,saveCustomerConfirm);
			req.onreadystatechange=handlerFunction;
			req.open("POST",strURL,true);
//alert("3");
			req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			var values='custNo='+escape(custNo)+'&custName1='+escape(custName1)+'&custName2='+escape(custName2)+'&custAddr1='+escape(custAddr1)+'&custAddr2='+escape(custAddr2)+'&city='+escape(city)+'&state='+escape(state)+'&zipCode='+escape(zipCode)+'&country='+escape(country)+'&countryCode='+escape(countryCode)+'&bpcsCustNo='+escape(bpcsCustNo)+'&attention='+escape(attention)+'&salutation='+escape(salutation)+'&phone='+escape(phone)+'&currency='+escape(currency)+'&shippingCity='+escape(shippingCity)+'&fax='+escape(fax)+'&email='+escape(email)+'&custNoText='+escape(custNoText)+'&createdRepNo='+escape(createdRepNo)+'&billCust='+escape(billCust)+'&marketType='+escape(marketType)+'&contactName='+escape(contactName)+'&dormant='+escape(dormant)+'&taxNo=';
			values=convertPL(values);
			req.send(values);



			//alert(document.editCustomer.isUse.value);
			if(isUse=="true"){
				if(document.editCustomer.isStop.value=="YES"){
					alert("ERROR");
				}
				else{
					//alert("selectCustomer");
					var temp1=document.editCustomer.custName1.value;
					var temp2=document.editCustomer.custNo.value;
					var temp3=document.editCustomer.phone.value;
					var temp4=document.editCustomer.contactName.value;
					var temp5=document.editCustomer.state.value;
					var temp6=document.editCustomer.email.value;
					var temp7=document.editCustomer.custNoText.value;
					selectCustomer(temp1,temp2,temp3,temp4,temp5,temp6,temp7);
				}
				document.editCustomer.isStop.value="";
			}
			else{
				clearCustomerForm();
				document.editCustomer.isUse.value="";
			}

			return "go";
		}
		else{

			alert(alertMsg);
			//document.editCustomer.isStop.value="YES";
			if(isUse=="true"){
				return "stop";
			}
		}




	}
	function clearCustomerForm(){
		//alert("1");
		document.editCustomer.custNo.value="";
		document.editCustomer.custName1.value="";
		document.editCustomer.custName2.value="";
		document.editCustomer.custAddr1.value="";
		document.editCustomer.custAddr2.value="";
		document.editCustomer.city.value="";
		document.editCustomer.state.value="";
		document.editCustomer.zipCode.value="";
		document.editCustomer.country.value="";
		document.editCustomer.countryCode.value="";
		//alert("2");
		document.editCustomer.bpcsCustNo.value="";
		document.editCustomer.attention.value="";
		document.editCustomer.salutation.value="";
		document.editCustomer.phone.value="";
		document.editCustomer.currency.value="";
		document.editCustomer.shippingCity.value="";
		document.editCustomer.fax.value="";
		document.editCustomer.email.value="";
		document.editCustomer.custNoText.value="";
		//alert("3");
		document.editCustomer.createdRepNo.value="";
		document.editCustomer.billCust.value="";
		document.editCustomer.marketType.value="";
		document.editCustomer.contactName.value="";
		document.editCustomer.dormant.checked=false;
		//document.editCustomer.taxNo.value="";
		document.custSearchHeader.searchCustomerCustomerName.value="";
		document.custSearchHeader.searchCustomerCity.value="";
		document.custSearchHeader.searchCustomerTaxNo.value="";
		//alert("4");
		document.getElementById("customerSearchResultsHeader").innerHTML="";
	}
	function saveCustomerConfirm(searchXML){
		//alert("saved");
		//alert(document.editCustomer.isUse.value);
		var custNoText="";
		if(document.editCustomer.isUse.value=true){
			var count=searchXML.getElementsByTagName("custNo").length;
			//alert(count);
			for(var i=0;i<count;i++){
				// alert(searchXML.getElementsByTagName("custNoText")[i].childNodes[0].nodeValue.replace("#",""));
				custNoText=searchXML.getElementsByTagName("custNoText")[i].childNodes[0].nodeValue.replace("#","");
				document.headerForm.custName.value=searchXML.getElementsByTagName("custNoText")[i].childNodes[0].nodeValue.replace("#","");
			}
		}
		//alert("HERE");

		selectContactHeader(custNoText);
		selectCurrency();


		clearCustomerForm();
		document.editCustomer.isUse.value="";
		goHome();
	}
	function addCustomer(){
		clearCustomerForm();
		customerSearchResultsHeader.style.visibility='visible';
		customerEditHeader.style.visibility='hidden';
		customerx.style.visibility='hidden';
		customerEditHeader.style.visibility='visible';
		//alert("HERE");
		document.editCustomer.countryCode.value=document.custSearch.searchCustomerRepCountry.value;
		document.editCustomer.createdRepNo.value=document.custSearch.searchCustomerRepNo.value;
		//alert(document)
		//alert("2");
	}
	function userSessionEmpty(){
		alert("Session Error...  Shutting down...");
		//document.location.target='_blank';
		//document.location.href='../login.html';
		window.open('../login.html','_blank');
	}
}
catch(err){
	alert("CONTACT ERAPID TEAM:::JAVASCRIPT ERROR"+err.message);
}