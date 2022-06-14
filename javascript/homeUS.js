try{
	function pausex(millis){
		var date=new Date();
		var curDate=null;
		do{
			curDate=new Date();
		}
		while(curDate-date<millis);
	}
	function check(){
//alert(document.formNew.qtype.value+":::"+document.formNew.product.value+":::"+document.formNew.repNum.value);
//alert(document.formNew.product.value+"::HERE<BR>");
		if(document.formNew.product.value.length>0){
			if(document.formNew.qtype.value=="alt"){
//alert(document.formNew.altCpyNo.value);
				var values='orderNo='+escape(document.formNew.altCpyNo.value)
				var req=new XMLHttpRequest();
				var handlerFunction=getReadyStateHandler(req,checkAlternates);
				req.onreadystatechange=handlerFunction;
				req.open("post","checkAlternate.jsp",true);
				req.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=utf-8");
				//alert(values);
				req.send(values);
			}

			else{
				if(document.form1.searchGroup.value.toUpperCase().indexOf("CAN")>=0&&document.formNew.product.value=="IWP"){
					alert("You must use Salesforce to create a new IWP quote.  ");
				}
				else{
					//alert("1");
					//alert("HERE"+document.formNew.qtype.value);
					if(document.formNew.qtype.value=="sample"&&!(document.formNew.product.value=="EJC"||document.formNew.product.value=="IWP"||document.formNew.product.value=="EFS"||document.formNew.product.value=="ADS")){
						alert("Samples can only be done for ADS,IWP,EJC and EFS");
					}
					else{
						document.formNew.submit();
					}
				}
			}
		}
		else{

			alert("Please select product");
		}
	}
	function checkAlternates(searchXML){
		var count=searchXML.getElementsByTagName("value").length;
		for(var i=0;i<count;i++){
//alert(searchXML.getElementsByTagName("value")[i].childNodes[0].nodeValue.replace("#",""));
			if(searchXML.getElementsByTagName("value")[i].childNodes[0].nodeValue.replace("#","")*1<100){
				document.formNew.submit();
			}
			else{
				alert("You have reached the maximum alternates for this quote.");
			}
		}

	}
	function profileNew(x){
		//alert(x);
		document.formNew.product.value="GE";
		document.formNew.altCpyNox.value=x;
		check();
	}
	function SelectOrderNo(){

		if(document.formNew.qtype.value=="alt"||document.formNew.qtype.value=="cpy"||document.formNew.qtype.value=="build"||document.formNew.qtype.value=="change"||document.formNew.qtype.value=="release"||document.formNew.qtype.value=="revision"||document.formNew.qtype.value=="submittal"){
//alert("COPY OR ALT");
			document.getElementById("sbmt").disabled=true;
			//alert("a");
			document.getElementById("divSubcat").style.display='none';
			//alert("1");
			document.getElementById("productPullDown").style.display="none";
			//alert("b"+document.form1.searchGroup.value.indexOf("REP")+document.form1.searchGroup.value);
			if(document.form1.searchGroup.value.toUpperCase().indexOf("REP")<0){
				document.getElementById("divSubcat2").style.display='none';
			}
//alert("2");
			changeSearch('searchBean.jsp');
		}
		else if(document.formNew.qtype.value=="PSA"){
			document.getElementById("sbmt").disabled=true;
			document.getElementById("divSubcat").style.display='none';
			document.getElementById("productPullDown").style.display="none";
			if(document.form1.searchGroup.value.toUpperCase().indexOf("REP")<0){
				document.getElementById("divSubcat2").style.display='none';
			}
			document.getElementById("searchDiv1").style.display='none';
			searchDiv2.style.visibility='visible';
			//alert("DONE");
			document.getElementById("result").innerHTML="";
			var newdiv=document.createElement("div");
			newdiv.style.top=250;
			newdiv.innerHTML="PLEASE WAIT";
			changeSearch('psaSearchBean.jsp');
		}
		else if(document.formNew.qtype.value=="pfl"){
//alert("NEW PROFILE");
			document.formNew.product.value="GE";
			check();
		}
		else{
//alert("HERE");
			document.getElementById("sbmt").disabled=false;
			document.getElementById("divSubcat").style.display='none';
			if(document.form1.searchGroup.value.toUpperCase().indexOf("REP")<0){
				document.getElementById("divSubcat2").style.display='block';
			}
			document.formNew.sbmt.disabled=false;
			document.getElementById("productPullDown").style.display="";
			document.form1.orderNo.value="";
			document.formNew.altCpyNo.value="";
			document.formNew.altCpyNox.value="";
			changeSearch('searchBean.jsp');
		}
	}
	function changeSearch(strURL){
   		var temp1=strURL;

		var form=document.forms['form1'];
		var orderDate1=document.form1.orderDate1.value
		var orderDate2=form.orderDate2.value
		if(orderDate1=="start"){
			orderDate1="";
		}
		if(orderDate2=="end"){
			orderDate2="";
		}
		var values='product='+escape(form.product_id.value)+'&userId='+escape(form.currentUserId.value)+'&repNo='+escape(form.repNo.value)+'&orderNo='+escape(form.orderNo.value)+'&archName='+escape(form.archName.value)+'&orderDate1='+escape(orderDate1)+'&orderDate2='+escape(orderDate2)+'&custLoc='+escape(form.custLoc.value)+'&projectName='+escape(form.projectName.value)+'&quoteType='+escape(form.quoteType.value)+'&bpcsNo='+escape(form.bpcsNo.value);

		if((form.product_id.value==""||form.product_id.value==null)&(form.repNo.value==""||form.repNo.value==null)&(form.orderNo.value==""||form.orderNo.value==null)&(form.archName.value==""||form.archName.value==null)&(orderDate1==""||orderDate1==null)&(orderDate2==""||orderDate2==null)&(form.custLoc.value==""||form.custLoc.value==null)&(form.projectName.value==""||form.projectName.value==null)&(form.quoteType.value==""||form.quoteType.value==null)){
			values='product='+escape(form.product_id.value)+'&userId='+escape(form.currentUserId.value)+'&repNo='+escape(form.currentRepNo.value)+'&orderNo='+escape(form.orderNo.value)+'&archName='+escape(form.archName.value)+'&orderDate1='+escape(orderDate1)+'&orderDate2='+escape(orderDate2)+'&custLoc='+escape(form.custLoc.value)+'&projectName='+escape(form.projectName.value)+'&quoteType='+escape(form.quoteType.value)+'&bpcsNo='+escape(form.bpcsNo.value);
		}
		if(document.formNew.qtype.value=="PSA"||document.formNew.qtype.value=="pfl"){
			values='psaProjectName='+escape(form.psaProjectName.value)+'&userName='+escape(form.currentUserId.value);
		}
		values=values+'&countryCode='+escape(form.countryCode.value)+'&firstOrderNo='+escape(form.firstOrderNo.value)+'&lastOrderNo='+escape(form.lastOrderNo.value)+'&functionName='+escape(form.functionName.value)+'&webNum='+escape(form.webNum.value);
		setTimeout(function(){
			changeSearch2(temp1,values);
		},1000);
	}
	function changeSearch2(strURL,oldValues){
		//alert("2");

		document.getElementById("result").innerHTML="<center><font color='red' size='4'>LOADING....</font></center>";
		var searchNote="Search Results";
		var req=new XMLHttpRequest();
		var handlerFunction=getReadyStateHandler(req,updateSearch);
		req.onreadystatechange=handlerFunction;
		req.open("post",strURL,true);
		req.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=utf-8");
		var form=document.forms['form1'];
		var orderDate1=document.form1.orderDate1.value
		var orderDate2=form.orderDate2.value
		if(orderDate1=="start"){
			orderDate1="";
		}
		if(orderDate2=="end"){
			orderDate2="";
		}
//alert("a");
		var values='product='+escape(form.product_id.value)+'&userId='+escape(form.currentUserId.value)+'&repNo='+escape(form.repNo.value)+'&orderNo='+escape(form.orderNo.value)+'&archName='+escape(form.archName.value)+'&orderDate1='+escape(orderDate1)+'&orderDate2='+escape(orderDate2)+'&custLoc='+escape(form.custLoc.value)+'&projectName='+escape(form.projectName.value)+'&quoteType='+escape(form.quoteType.value)+'&bpcsNo='+escape(form.bpcsNo.value);
		if((form.product_id.value==""||form.product_id.value==null)&(form.repNo.value==""||form.repNo.value==null)&(form.orderNo.value==""||form.orderNo.value==null)&(form.archName.value==""||form.archName.value==null)&(orderDate1==""||orderDate1==null)&(orderDate2==""||orderDate2==null)&(form.custLoc.value==""||form.custLoc.value==null)&(form.projectName.value==""||form.projectName.value==null)&(form.quoteType.value==""||form.quoteType.value==null)){
			values='product='+escape(form.product_id.value)+'&userId='+escape(form.currentUserId.value)+'&repNo='+escape(form.currentRepNo.value)+'&orderNo='+escape(form.orderNo.value)+'&archName='+escape(form.archName.value)+'&orderDate1='+escape(orderDate1)+'&orderDate2='+escape(orderDate2)+'&custLoc='+escape(form.custLoc.value)+'&projectName='+escape(form.projectName.value)+'&quoteType='+escape(form.quoteType.value)+'&bpcsNo='+escape(form.bpcsNo.value);
			searchNote="Top 20";
		}
		if(document.formNew.qtype.value=="alt"){
			searchNote="Alternate Results";
		}
		if(document.formNew.qtype.value=="cpy"){
			searchNote="Copy Results";
		}
//alert("HERE"+document.formNew.qtype.value);
		if(document.formNew.qtype.value=="PSA"||document.formNew.qtype.value=="pfl"){
//alert("PSA");
			document.getElementById("result").innerHTML="";
			var newdiv=document.createElement("div");
			//alert("2");
			newdiv.style.top=250;
			newdiv.innerHTML="PLEASE WAIT";
			//alert("3");
			values='psaProjectName='+escape(form.psaProjectName.value)+'&userName='+escape(form.currentUserId.value);
		}
		values=values+'&countryCode='+escape(form.countryCode.value)+'&firstOrderNo='+escape(form.firstOrderNo.value)+'&lastOrderNo='+escape(form.lastOrderNo.value)+'&functionName='+escape(form.functionName.value)+'&webNum='+escape(form.webNum.value);
		var tempCount2=document.form1.searchCount.value*1;
		if(values==oldValues){
			document.getElementById("searchNote").innerHTML=searchNote;
			req.send(values);
		}


	}
	function updateSearch(searchXML){
		if(document.form1.functionName.value.length==0){
			document.form1.rangeEnd.value="0";
			document.form1.firstOrderNo.value=projectName
			document.form1.lastOrderNo.value="";
			document.form1.numberOfRecords.value="";
			document.form1.rangeStart.value="0";
		}
		if(document.formNew.qtype.value=="PSA"){
			var results=" <table border='0' width='1180px;'><tr class='header1'><td width='25%'>PSA Project Name</td><td width='25%'>PSA Project Number</td><td width='25%'>Price</td><td width='25%'>Product</td></tr>";
			var count=searchXML.getElementsByTagName("el1").length;
			for(var i=0;i<count;i++){
				var el1=searchXML.getElementsByTagName("el1")[i].childNodes[0].nodeValue;
				var el2=searchXML.getElementsByTagName("el2")[i].childNodes[0].nodeValue;
				var el3=searchXML.getElementsByTagName("el3")[i].childNodes[0].nodeValue;
				var el4=searchXML.getElementsByTagName("el4")[i].childNodes[0].nodeValue;
				el1=el1.replace("#","");
				el2=el2.replace("#","");
				el3=el3.replace("#","");
				el4=el4.replace("#","");
				var cssClass="rowodd";
				if(i%2==0){
					cssClass="roweven";
				}
				results=results+"<tr class='"+cssClass+"'><td><Input type='button' name='psaQuote' value='"+el1+"' class='psaButton' onclick=doPSA('"+el2+"','"+el4+"')></td><td><font color='purple'>"+el2+"</font></td><td><font color='purple'>"+el3+"</font></td><td><font color='purple'>"+el4+"</font></td></tr>"
			}
			results=results+"</table>";
		}
		else{
			var results=" <table border='0' width='1180px;'><tr class='header1'><td width='10%'>QUOTE NO</td><td width='30%'>PROJECT NAME</td><td width='8%'>PRODUCT</td><td width='18%'>CUSTOMER</td><td width='13%'>ARCHITECT</td><td width='7%'>BPCS NO</td><td width='7%'>PRICE</td><td width='7%'>CREATED</td></tr>";
			var count=searchXML.getElementsByTagName("orderNo").length;
			var firstOrderNo="";
			var lastOrderNo="";
			var rowCount=count;
			var numberOfRecords=searchXML.getElementsByTagName("rowcount")[0].childNodes[0].nodeValue.replace("#","");
			//alert(document.form1.searchGroup.value);
			for(var i=0;i<count;i++){
				if(i==0){
					firstOrderNo=searchXML.getElementsByTagName("orderNo")[i].childNodes[0].nodeValue.replace("#","");
				}
				lastOrderNo=searchXML.getElementsByTagName("orderNo")[i].childNodes[0].nodeValue.replace("#","");
				var orderNo=searchXML.getElementsByTagName("orderNo")[i].childNodes[0].nodeValue;
				var projectName=searchXML.getElementsByTagName("projectName")[i].childNodes[0].nodeValue;
				var custName=searchXML.getElementsByTagName("custName")[i].childNodes[0].nodeValue;
				var creatorId=searchXML.getElementsByTagName("creatorId")[i].childNodes[0].nodeValue;
				var productId=searchXML.getElementsByTagName("productId")[i].childNodes[0].nodeValue;
				var configuredPrice=searchXML.getElementsByTagName("configuredPrice")[i].childNodes[0].nodeValue;
				var createdOn=searchXML.getElementsByTagName("createdOn")[i].childNodes[0].nodeValue;
				var archName=searchXML.getElementsByTagName("archName")[i].childNodes[0].nodeValue;
				var status=searchXML.getElementsByTagName("status")[i].childNodes[0].nodeValue;
				var docType=searchXML.getElementsByTagName("docType")[i].childNodes[0].nodeValue;
				var docDate=searchXML.getElementsByTagName("docDate")[i].childNodes[0].nodeValue;
				var gpa=searchXML.getElementsByTagName("gpa")[i].childNodes[0].nodeValue;
				var archName=searchXML.getElementsByTagName("archName")[i].childNodes[0].nodeValue;
				var bpcsOrderNo=searchXML.getElementsByTagName("bpcsOrderNo")[i].childNodes[0].nodeValue;
				var template=searchXML.getElementsByTagName("template")[i].childNodes[0].nodeValue;
				var projectType=searchXML.getElementsByTagName("projectType")[i].childNodes[0].nodeValue;
				var docPriority=searchXML.getElementsByTagName("docPriority")[i].childNodes[0].nodeValue;
				orderNo=orderNo.replace("#","");
				//projectName=projectName.replace("#","");
				var ax=projectName.lastIndexOf('#');
				if(ax!=-1){
					projectName=projectName.substring(0,ax);
				}
				custName=custName.replace("#","");
				archName=archName.replace("#","");
				creatorId=creatorId.replace("#","");
				productId=productId.replace("#","");
				configuredPrice=configuredPrice.replace("#","");
				createdOn=createdOn.replace("#","");
				status=status.replace("#","");
				docType=docType.replace("#","");
				docDate=docDate.replace("#","");
				gpa=gpa.replace("#","");
				archName=archName.replace("#","");
				bpcsOrderNo=bpcsOrderNo.replace("#","");
				template=template.replace("#","");
				projectType=projectType.replace("#","");
				docPriority=docPriority.replace("#","");
				if(template=="PFL"&&i==0){
					results=" <table border='0' width='1180px;'><tr class='header1'><td width='10%'>QUOTE NO</td><td width='10%'>&nbsp;</td><td width='33%'>PROJECT NAME</td><td width='8%'>PRODUCT</td><td width='18%'>CUSTOMER</td><td width='7%'>PRICE</td><td width='7%'>VIEW</td><td width='7%'>EDIT</td></tr>";
				}
				if(createdOn==null){
					createdOn="";
				}
//alert(creatdOn.length);
//createdOn=createdOn.length;
				if(createdOn.length>10){
//createdOn=createdOn.length;
					createdOn=createdOn.substring(0,10);
				}
				var projectNamex=projectName;
				var custNamex=custName;
				var archNamex=archName;
				projectNamex="PROJECT NAME:"+projectNamex+"\r\n"+"CUSTOMER NAME:"+custName+"\r\n"+"ARCHITECT NAME:"+archName+"\r\n"+"CREATOR ID:"+creatorId+"\r\n"+"CREATED ON:"+createdOn+"\r\n"+"STATUS:"+status+"\r\n"+"TYPE:"+docType+"\r\n"+"BPCS NUMBER:"+bpcsOrderNo+"\r\n"+"TYPE:"+docPriority;
				if(custName.length>20){
					custName=custName.substring(0,20)+"<font color='red'>...</font>";
				}
				if(archName.length>20){
					archName=archName.substring(0,15)+"<font color='red'>...</font>";
				}
				if(projectName.length>40){
					projectName=projectName.substring(0,40)+"<font color='red'>...</font>";
				}
				var cssClass="rowodd";
				if(i%2==0){
					cssClass="roweven";
				}
				var fontColor="black";
				var buttonClass="button";
				if(projectType=="web"){
					fontColor="ORANGE";
					buttonClass="button";
				}
				else if(document.form1.searchGroup.value.toUpperCase().indexOf("REP")>=0){
					if(projectType=="PSA"||projectType=="SFDC"){
						fontColor="purple";
						buttonClass="button";
					}
				}
				else{
					if(projectType=="PSA"){
						fontColor="purple";
						buttonClass="button";
					}
					else if(projectType=="SFDC"){
						fontColor="#00DDDD";
						buttonClass="button";
					}
				}





				if(docType=="O"){
					fontColor="#3ea5ea";
					fontColor="#0000EE";
					buttonClass="button";
				}
				if(template=="PFL"){
					fontColor="#GGDD00";
					buttonClass="button";
				}
//alert(template);
				if(document.formNew.qtype.value=="alt"||document.formNew.qtype.value=="cpy"||document.formNew.qtype.value=="build"||document.formNew.qtype.value=="change"||document.formNew.qtype.value=="release"||document.formNew.qtype.value=="revision"||document.formNew.qtype.value=="submittal"){
					results=results+"<tr class='"+cssClass+"'><td>";
					if(document.form1.searchGroup.value.toUpperCase().indexOf("REP")>=0&&(projectType=="PSA"||projectType=="SFDC")){

						results=results+"factory</td><td>";
					}

					else{
						results=results+"<input type='button' name='orderNo' value='"+orderNo+"' class='buttonAlt' onclick=doAlt('"+orderNo+"','"+productId+"','"+creatorId+"')></td><td>";
					}
					results=results+"<font color='"+fontColor+"'><a title='"+projectNamex+"'>"+projectName+"</a></font>";
					results=results+"</td><td><font color='"+fontColor+"'>"+productId+"</font></td><td><font color='"+fontColor+"'><a title='"+custNamex+"'>"+custName+"</a></font></td><td><font color='"+fontColor+"'><a title='"+archNamex+"'>"+archName+"</a></font></td><td><font color='"+fontColor+"'>"+bpcsOrderNo+"</font></td><td><font color='"+fontColor+"'>"+configuredPrice+"</font></td><td><font color='"+fontColor+"'>"+createdOn+"</td></tr>";
				}
				else if(template=="PFL"){
					results=results+"<tr class='"+cssClass+"'>";
					results=results+"<td>"+orderNo+"</td><td><input type='button' name='orderNo' value='Create Quote' class='buttonAlt' onclick=profileNew('"+orderNo+"')></td><td>";
					results=results+"<font color='"+fontColor+"'><a title='"+projectNamex+"'>"+projectName+"</a></font>";
					results=results+"</td><td><font color='"+fontColor+"'>"+productId+"</font></td><td><font color='"+fontColor+"'><a title='"+custNamex+"'>"+custName+"</a></font></td>";
					results=results+"<td><font color='"+fontColor+"'>"+configuredPrice+"</font></td>";
					results=results+"<td><input type='button' name='orderNo' value='View Profile' class='buttonAlt' onclick=n_window('/erapid/us/ge/profile_header.jsp?orderNo="+orderNo+"&name="+document.formNew.username.value+"')></td>";
					results=results+"<td><input type='button' name='orderNo' value='Edit Profile' class='buttonAlt' onclick=doThis('"+orderNo+"')></td>";
					results=results+"</tr>";
				}
				else{
					results=results+"<tr class='"+cssClass+"'><td><input type='button' name='orderNo' value='"+orderNo+"' class='button' onclick=doThis('"+orderNo+"')></td><td>";
					results=results+"<font color='"+fontColor+"'><a title='"+projectNamex+"'>"+projectName+"</a></font>";
					results=results+"</td><td><font color='"+fontColor+"'>"+productId+"</font></td><td><font color='"+fontColor+"'><a title='"+custNamex+"'>"+custName+"</a></font></td><td><font color='"+fontColor+"'><a title='"+archNamex+"'>"+archName+"</font></td><td><font color='"+fontColor+"'>"+bpcsOrderNo+"</font></td><td><font color='"+fontColor+"'>"+configuredPrice+"</font></td><td><font color='"+fontColor+"'>"+createdOn+"</td></tr>";
				}
			}
			results=results+"</table>";
		}
		document.getElementById("result").innerHTML="";
		var newdiv=document.createElement("div");
		newdiv.style.top=250;
		newdiv.innerHTML=results;
		var result=document.getElementById("result");
		result.appendChild(newdiv);
		document.form1.firstOrderNo.value=firstOrderNo;
		document.form1.lastOrderNo.value=lastOrderNo;
		document.form1.numberOfRecords.value=numberOfRecords;
		if(document.form1.functionName.value=="start"){
			document.form1.rangeStart.value=0;
			document.form1.rangeEnd.value=(rowCount);
			document.form1.rangeStart.value=document.form1.rangeStart.value*1+1;
			document.form1.functionName.value="";
			document.getElementById('rangeStartx').innerHTML=document.form1.rangeStart.value;
			document.getElementById('rangeEndx').innerHTML=document.form1.rangeEnd.value;
		}
		else if(document.form1.functionName.value=="end"){
			document.form1.rangeEnd.value=document.form1.numberOfRecords.value;
			document.form1.rangeStart.value=(document.form1.rangeEnd.value*1-rowCount);
			document.form1.functionName.value="";
			document.getElementById('rangeStartx').innerHTML=document.form1.rangeStart.value;
			document.getElementById('rangeEndx').innerHTML=document.form1.rangeEnd.value;
		}
		else if(document.form1.functionName.value=="forward"){
			document.form1.rangeStart.value=document.form1.rangeEnd.value;
			document.form1.rangeEnd.value=(document.form1.rangeStart.value*1+rowCount);
			document.form1.rangeStart.value=document.form1.rangeStart.value*1+1;
			if(document.form1.rangeStart.value*1>document.form1.numberOfRecords.value*1||document.form1.rangeEnd.value*1>document.form1.numberOfRecords.value*1){
				goToEnd();
			}
			else{
				document.form1.functionName.value="";
				document.getElementById('rangeStartx').innerHTML=document.form1.rangeStart.value;
				document.getElementById('rangeEndx').innerHTML=document.form1.rangeEnd.value;
			}
		}
		else if(document.form1.functionName.value=="back"){
			document.form1.rangeEnd.value=document.form1.rangeStart.value;
			document.form1.rangeStart.value=(document.form1.rangeStart.value*1-rowCount);
			document.form1.rangeEnd.value=document.form1.rangeEnd.value*1-1;
			if(document.form1.rangeStart.value*1<1||document.form1.rangeEnd.value*1<1){
				document.form1.functionName.value="";
				changeSearch('searchBean.jsp');
			}
			else{
				document.form1.functionName.value="";
				document.getElementById('rangeStartx').innerHTML=document.form1.rangeStart.value;
				document.getElementById('rangeEndx').innerHTML=document.form1.rangeEnd.value;
			}
		}
		else{
			document.form1.rangeStart.value=0;
			document.form1.rangeEnd.value=(rowCount);
			document.form1.rangeStart.value=document.form1.rangeStart.value*1+1;
			document.form1.functionName.value="";
			document.getElementById('rangeStartx').innerHTML=document.form1.rangeStart.value;
			document.getElementById('rangeEndx').innerHTML=document.form1.rangeEnd.value;
		}
		document.getElementById("goToEnd").disabled=false;
		document.getElementById("goForward").disabled=false;
		document.getElementById("goToStart").disabled=false;
		document.getElementById("goBack").disabled=false;
		document.getElementById('numberOfRecordx').innerHTML=document.form1.numberOfRecords.value;
		if(document.form1.rangeEnd.value*1==document.form1.numberOfRecords.value*1||document.form1.rangeEnd.value*1>document.form1.numberOfRecords.value*1){
			document.getElementById("goToEnd").disabled=true;
			document.getElementById("goForward").disabled=true;
		}
		else if(document.form1.rangeStart.value==1){
			document.getElementById("goToStart").disabled=true;
			document.getElementById("goBack").disabled=true;
		}
	}
	function doThis(x){
		document.form1.orderNox.value=x;
		document.form1.submit();
	}
	function doAlt(x,y,z){
		document.form1.orderNo.value=x;
		document.formNew.altCpyNo.disabled=false;
		document.formNew.altCpyNo.value=x;
		document.formNew.product.value=y;
		document.formNew.altCpyNo.disabled=true;
		document.formNew.sbmt.disabled=false;
		document.formNew.altCpyNox.value=x;
		document.formNew.altRep.value=z;
		changeSearch('searchBean.jsp');
	}
	function doPSA(psaNo,pid){
		document.formNew.psaNo.value=psaNo;
		document.formNew.product.value=pid;
		if(psaNo.length>0){
//alert(" go psa");
			document.formNew.submit();
		}
	}
	function goToStart(){
		document.form1.functionName.value="start";
		changeSearch('searchBean.jsp');
	}
	function goToEnd(){
		document.form1.functionName.value="end";
		//alert("GO TO END");
		changeSearch('searchBean.jsp');
	}
	function goBack(){
		document.form1.functionName.value="back";
		changeSearch('searchBean.jsp');
	}
	function goForward(){
		document.form1.functionName.value="forward";
		changeSearch('searchBean.jsp');
	}
	function gregx(){
//alert("HERE");
		new DatePicker('.demo',{positionOffset:{x:0,y:5}});
	}
	function showFullContent(inp,n,t){
		obj=document.getElementById('container');
		val=document.forms[0][n].value
		spn=document.createElement('span');
		spn.setAttribute('id','tooltip');
		spn.style.top=t+'px';
		con=document.createTextNode(val);
		spn.appendChild(con);
		obj.appendChild(spn);
		inp.onmouseout=function(){
			obj.removeChild(spn);
		}
	}
	function changeSearchx(){

//alert("HERE");
	}
	function n_window(theurl){
//alert("n windows");
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
		window.open(theurl,'',the_atts);
	}
}
catch(err){
	alert("CONTACT ERAPID TEAM:::JAVASCRIPT ERROR"+err.message);
}