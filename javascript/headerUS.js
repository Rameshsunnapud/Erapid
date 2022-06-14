try{
	function custMaint(){
		//document.getElementById("result").innerHTML = "";
		//document.getElementById("mainbody").innerHTML = "";
		result.style.visibility='hidden';
		mainbody.style.visibility='hidden';
		customerEdit.style.visibility='hidden';
		customerSearch.style.visibility='visible';
		customerSearchResults.style.visibility='visible';
		changeCustomerSearch("customerSearchBean.jsp");
	}
	function goHome(){
		//alert("GOHOME");
		clearCustomerForm();
		result.style.visibility='visible';
		mainbody.style.visibility='visible';
		customerEdit.style.visibility='hidden';
		customerSearch.style.visibility='hidden';
		customerSearchResults.style.visibility='hidden';

	}



	function changeCustomerSearch(strURL){
		var temp1=strURL;

		var form=document.forms['custSearch'];
		var values='repNo='+escape(form.searchCustomerRepNo.value)+'&repGroup='+escape(form.searchCustomerRepGroup.value)+'&repCountry='+escape(form.searchCustomerRepCountry.value)+'&customerName='+escape(form.searchCustomerCustomerName.value)+'&customerCity='+escape(form.searchCustomerCity.value)+'&customerTaxNo=';
		values=convertPL(values);

		setTimeout(function(){
			changeCustomerSearch2(temp1,values);
		},1000);
	}








	function changeCustomerSearch2(strURL,oldValues){
		var req=new XMLHttpRequest();
		var handlerFunction=getReadyStateHandler(req,updateCustomersSearch);
		req.onreadystatechange=handlerFunction;
		req.open("POST",strURL,true);
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		var form=document.forms['custSearch'];
		var values='repNo='+escape(form.searchCustomerRepNo.value)+'&repGroup='+escape(form.searchCustomerRepGroup.value)+'&repCountry='+escape(form.searchCustomerRepCountry.value)+'&customerName='+escape(form.searchCustomerCustomerName.value)+'&customerCity='+escape(form.searchCustomerCity.value)+'&customerTaxNo=';
		values=convertPL(values);
		if(values==oldValues){
			req.send(values);
		}
	}
	function updateCustomersSearch(searchXML){
		var results=" <table border='0' width='1080px;'><tr class='header1'><td  width='10%'>&nbsp;</td><td  width='35%'>Name</td>"+
			   "<td  width='20%'>Address</td><td  width='10%'>City</td>"+
			   "<td  width='10%'>State</td><td  width='10%'>Zip</td>"+
			   "<td  width='5%'>Tax</td>"+
			   "</tr>";
		var count=searchXML.getElementsByTagName("custNo").length;
		var firstCustNo="";
		var lastCustNo="";
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
			var custName1x=custName1;
			var custName2x=custName2;
			var custAddr1x=custAddr1;
			var custAddr2x=custAddr2;
			if(custName1.length>40){
				custName1=custName1.substring(0,40)+"<font color='red'>...</font>";
			}
			if(custName2.length>20){
				custName2=custName2.substring(0,20)+"<font color='red'>...</font>";
			}
			if(custAddr1.length>20){
				custAddr1=custAddr1.substring(0,20)+"<font color='red'>...</font>";
			}
			if(custAddr2.length>20){
				custAddr2=custAddr2.substring(0,20)+"<font color='red'>...</font>";
			}
			custNo=custNo.replace(/ /g,"&nbsp;");
			custName1=custName1.replace(/ /g,"&nbsp;");
			custName2=custName2.replace(/ /g,"&nbsp;");
			custAddr1=custAddr1.replace(/ /g,"&nbsp;");
			custAddr2=custAddr2.replace(/ /g,"&nbsp;");
			city=city.replace(/ /g,"&nbsp;");
			state=state.replace(/ /g,"&nbsp;");
			zipCode=zipCode.replace(/ /g,"&nbsp;");
			country=country.replace(/ /g,"&nbsp;");
			countryCode=countryCode.replace(/ /g,"&nbsp;");
			bpcsCustNo=bpcsCustNo.replace(/ /g,"&nbsp;");


			var cssClass="rowodd";
			if(i%2==0){
				cssClass="roweven";
			}
			results=results+"<tr class='"+cssClass+"'><td><input type='button' name='custNo' value='Edit' class='button' onclick=editCustomerx('"+custNo+"','"+countryCode+"')></td><td><a title='"+custName1x+"'>"+custName1+"</a></td><td><a title='"+custAddr1x+"'>"+custAddr1+"</a></td></td><td>"+city+"</td><td>"+state+"</td><td>"+zipCode+"</td></tr>";
			//alert(results);
		}
		results=results+"</table>";
		document.getElementById("customerSearchResults").innerHTML="";
		var newdiv=document.createElement("div");
		newdiv.style.top=250;
		newdiv.innerHTML=results;
		var result=document.getElementById("customerSearchResults");
		result.appendChild(newdiv);
	}
	function editCustomerx(custNo,countryCode){
		//alert("HERE");
		var strURL="editCustomer.jsp";
		result.style.visibility='hidden';
		mainbody.style.visibility='hidden';
		customerSearch.style.visibility='hidden';
		customerSearchResults.style.visibility='hidden';
		customerEdit.style.visibility='visible';
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
			dormant=dormant.replace("#","");

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
			if(billCust=="Y"){
				document.editCustomer.billCust.checked=true;
			}
			else{
				document.editCustomer.billCust.checked=false;
			}
			document.editCustomer.marketType.value=marketType;
			document.editCustomer.contactName.value=contactName;
			document.editCustomer.dormant.value=dormant;


		}
		getContacts(custNo,countryCode);
		document.getElementById("saveUseCustomer").style.visibility="hidden";
	}

	function saveCustomerx(){
		//alert("1");
		var formobj=document.editCustomer;
		var fieldRequired=Array("custName1","custAddr1","city");
		var fieldDescription=Array("Customer name","customer address","city ");
		var alertMsg="You must select:\n";

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

			//if(isNaN(document.editCustomer.taxNo.value)){
			//	alertMsg+= " - Proszę wpisz numer NIP jako ciąg znaków, bez spacji oraz kresek. \n";
			//}
		}

		if(alertMsg.length==l_Msg){
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
			//alert(billCust);
			var marketType=document.editCustomer.marketType.value;
			var contactName=document.editCustomer.contactName.value;
			var dormant=document.editCustomer.dormant.checked;
			//var taxNo=document.editCustomer.taxNo.value;
			var strURL="saveCustomer.jsp";
			///alert("2");
			var req=new XMLHttpRequest();
			var handlerFunction=getReadyStateHandler(req,saveCustomerConfirm);
			req.onreadystatechange=handlerFunction;
			req.open("POST",strURL,true);
			req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			var values='custNo='+escape(custNo)+'&custName1='+escape(custName1)+'&custName2='+escape(custName2)+'&custAddr1='+escape(custAddr1)+'&custAddr2='+escape(custAddr2)+'&city='+escape(city)+'&state='+escape(state)+'&zipCode='+escape(zipCode)+'&country='+escape(country)+'&countryCode='+escape(countryCode)+'&bpcsCustNo='+escape(bpcsCustNo)+'&attention='+escape(attention)+'&salutation='+escape(salutation)+'&phone='+escape(phone)+'&currency='+escape(currency)+'&shippingCity='+escape(shippingCity)+'&fax='+escape(fax)+'&email='+escape(email)+'&custNoText='+escape(custNoText)+'&createdRepNo='+escape(createdRepNo)+'&billCust='+escape(billCust)+'&marketType='+escape(marketType)+'&contactName='+escape(contactName)+'&dormant='+escape(dormant)+'&taxNo=';
			values=convertPL(values);
			req.send(values);
		}
		else{
			alert(alertMsg);
		}


	}

	function checkCustomer(){
		var custAddr1=document.editCustomer.custAddr1.value;
		var city=document.editCustomer.city.value;
		var custNoText=document.editCustomer.custNoText.value;
		var createdRepNo=document.editCustomer.createdRepNo.value;
		document.editCustomer.isDup.value="";
		if(custNoText.length==0){
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
			saveCustomerx();
		}
	}
	function saveCustomerCheck(searchXML){
		var isDup="";

		var count=searchXML.getElementsByTagName("isDup").length;
		for(var i=0;i<count;i++){
			isDup=searchXML.getElementsByTagName("isDup")[i].childNodes[0].nodeValue;
		}
		isDup=isDup.replace("#","");
		if(isDup.length>0){
			document.editCustomer.isDup.value="YES";
			//var answer=confirm("UWAGA! Pod podanym adresem istnieje już klient w bazie. Klient: \n\r"+isDup+"Czy nadal chcesz go dodać?");
			var answer=confirm("Warning potential duplicate. Customer: \n\r"+isDup+" Do you still want to add?");
			if(answer){
				document.editCustomer.isDup.value="YES";
				saveCustomerx();
			}
		}
		else{
			saveCustomerx();
		}
	}
	function clearCustomerForm(){
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
		document.editCustomer.bpcsCustNo.value="";
		document.editCustomer.attention.value="";
		document.editCustomer.salutation.value="";
		document.editCustomer.phone.value="";
		document.editCustomer.currency.value="";
		document.editCustomer.shippingCity.value="";
		document.editCustomer.fax.value="";
		document.editCustomer.email.value="";
		document.editCustomer.custNoText.value="";
		document.editCustomer.createdRepNo.value="";
		document.editCustomer.billCust.value="";
		document.editCustomer.marketType.value="";
		document.editCustomer.contactName.value="";
		document.editCustomer.dormant.checked=false;
		//document.editCustomer.taxNo.value="";
		document.custSearch.searchCustomerCustomerName.value="";
		document.custSearch.searchCustomerCity.value="";
		document.custSearch.searchCustomerTaxNo.value="";
		document.getElementById("customerSearchResults").innerHTML="";
	}
	function saveCustomerConfirm(searchXML){
		//ert("saved");
		//alert(searchXML);

		goHome();
	}
	function addCustomer(){
		clearCustomerForm();
		result.style.visibility='hidden';
		mainbody.style.visibility='hidden';
		customerSearch.style.visibility='hidden';
		customerSearchResults.style.visibility='hidden';
		customerEdit.style.visibility='visible';
		//alert("HERE");
		document.editCustomer.country.value="UNITED STATES";
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