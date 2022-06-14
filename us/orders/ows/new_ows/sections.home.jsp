<jsp:useBean id="quoteHeader" class="com.csgroup.general.QuoteHeaderBean"		scope="page"/>
<jsp:useBean id="validationBean" class="com.csgroup.general.ValidationBean"		scope="page"/>
<%

try{

%>
<html>

	<HEAD><title>Quote Sections</title>

		<link rel='stylesheet' href='styleMain.css' type='text/css' />

		<SCRIPT LANGUAGE="JavaScript">
<!-- Begin






			function validate(field){
				//alert("HERE");

				var valid="0123456789"
				var ok="yes";
				var temp;
				if(field!=undefined){
					//alert(document.form);
					for(var i=0;i<field.value.length;i++){
						temp=""+field.value.substring(i,i+1);
						//alert(temp);
						if(valid.indexOf(temp)=="-1")
							ok="no";
					}
					if(ok=="no"){
						alert("Only Numbers are allowed in this field!");
						//field.focus();
						return;
						//field.select();
					}

				}
			}
			//  End -->
			//





			function validate2(field){
				/*

				 var x=document.selectform.count_line.value
				 //alert(x+" one of the sections has no lines assigned to it.");
				 for (var i=1; i<=x; i++) {
				 var temp="document.selectform.1.options[0].value";
				 alert(temp+document.selectform.1.value);
				 }
				 //return;
				 //return true;

				 */
			}











			function validate1(field){
				var valid="0123456789"
				var ok="yes";
				var message="";
				var temp;

				var total=0;
				var temp=0;
				var test="";
				var totalO=document.scr_form.tot_overage.value*1;
				var totalS=document.scr_form.tot_setup.value*1;
				var totalH=document.scr_form.tot_handling.value*1;
				var totalF=document.scr_form.tot_freight.value*1;
				//alert(totalF);
				if(document.scr_form.numSections.value>1){
					var isGoodx=false;
					for(var y=0;y<document.scr_form.numSections.value;y++){
						if(document.scr_form.o[y].value.length>0){
							isGoodx=true;
						}
					}
					for(var x=0;x<document.scr_form.numSections.value;x++){
						if(document.scr_form.o[x].value.length>0){
							temp=document.scr_form.o[x].value*1;
							test=test+document.scr_form.o[x].value;
						}
						else{
							temp=0*1;
							if(isGoodx){
								document.scr_form.o[x].value=0;
							}
						}
						total=total*1+temp*1;
					}
				}
				else{
					if(document.scr_form.o.value.length>0){
						temp=document.scr_form.o.value*1;
						test=test+document.scr_form.o.value;
					}
					else{
						temp=0*1;
					}
					total=total*1+temp*1;
				}
				var result=total*1-totalO*1;
				//alert(":::"+test.replace(/^\s*|\s*$/g,"")+"::");
				if(test.replace(/^\s*|\s*$/g,"").length<1){

				}
				else if(result>0){
					message=message+"$"+result+" off the total overage ";
				}
				else if(result<0){
					message=message+"$"+result+" off the total overage ";
				}
				test="";
				total=0;
				temp=0;
				if(document.scr_form.productX.value=="EFS"){
					if(document.scr_form.numSections.value>1){
						var isGoodxx=false;
						for(var yy=0;yy<document.scr_form.numSections.value;yy++){
							if(document.scr_form.sc[yy].value.length>0){
								isGoodxx=true;
							}
						}
						for(var x1=0;x1<document.scr_form.numSections.value;x1++){
							if(document.scr_form.sc[x1].value.length>0){
								temp=document.scr_form.sc[x1].value*1;
								test=test+document.scr_form.sc[x1].value;
							}
							else{
								temp=0*1;
								if(isGoodxx){
									document.scr_form.sc[x1].value=0;
								}
							}
							total=total*1+temp*1;
						}
					}
					else{
						if(document.scr_form.sc.value.length>0){
							temp=document.scr_form.sc.value*1;
							test=test+document.scr_form.sc.value;
						}
						else{
							temp=0*1;
						}
						total=total*1+temp*1;
					}
					result=total*1-totalS*1;
					//alert(":::"+test.replace(/^\s*|\s*$/g,"")+"::");
					if(test.replace(/^\s*|\s*$/g,"").length<1){

					}
					else if(result>0){
						message=message+"$"+result+" off the total Setup Cost ";
					}
					else if(result<0){
						message=message+"$"+result+" off the total Setup Cost ";
					}
					test="";
					total=0;
					temp=0;
					//alert("HEREx2");
					//alert(document.scr_form.productX.value);

				}
				else{
					//alert("HEREx3");

					if(document.scr_form.numSections.value>1){
						var isGoodxxx=false;
						for(var yyy=0;yyy<document.scr_form.numSections.value;yyy++){
							if(document.scr_form.hc[yyy].value.length>0){
								isGoodxxx=true;
							}
						}
						for(var x2=0;x2<document.scr_form.numSections.value;x2++){
							if(document.scr_form.hc[x2].value.length>0){
								temp=document.scr_form.hc[x2].value*1;
								test=test+document.scr_form.hc[x2].value;
							}
							else{
								temp=0*1;
								if(isGoodxxx){
									document.scr_form.hc[x2].value=0;
								}
							}
							total=total*1+temp*1;
						}
					}
					else{
						if(document.scr_form.hc.value.length>0){
							temp=document.scr_form.hc.value*1;
							test=test+document.scr_form.hc.value;
						}
						else{
							temp=0*1;
						}
						total=total*1+temp*1;
					}

					result=total*1-totalH*1;
					if(test.replace(/^\s*|\s*$/g,"").length<1){

					}
					else if(result>0){
						message=message+"$"+result+" off the total Hanlding Cost ";
					}
					else if(result<0){
						message=message+"$"+result+" off the total Hanlding Cost ";
					}




				}
				//alert("HEREx1");










				//alert("HEREx");


				test="";
				total=0;
				temp=0;
				if(document.scr_form.numSections.value>1){

					var isGoodxxxx=false;
					for(var yyyy=0;yyyy<document.scr_form.numSections.value;yyyy++){
						if(document.scr_form.fc[yyyy].value.length>0){
							isGoodxxxx=true;
						}
					}
					for(var x2=0;x2<document.scr_form.numSections.value;x2++){

						if(document.scr_form.fc[x2].value.length>0){
							temp=document.scr_form.fc[x2].value*1;

							test=test+document.scr_form.fc[x2].value;
						}
						else{
							if(isGoodxxxx){
								document.scr_form.fc[x2].value=0;
							}
							temp=0*1;
						}
						total=total*1+temp*1;
					}
				}
				else{

					if(document.scr_form.fc.value.length>0){
						temp=document.scr_form.fc.value*1;
						test=test+document.scr_form.fc.value;
					}
					else{
						temp=0*1;
					}
					total=total*1+temp*1;
				}

				result=total*1-totalF*1;
				if(test.replace(/^\s*|\s*$/g,"").length<1){
					if(document.scr_form.product.value="GCP"&totalF>0){
						message=message+"You must allocate Freight ";
					}
				}
				else if(result>0){
					message=message+"$"+result+" off the total Freight Cost ";
				}
				else if(result<0){
					message=message+"$"+result+" off the total Freight Cost ";
				}




				if(message.length>1){
					alert(message);
					return false;
				}
				else{
					return true;
				}
			}



			//

			function showPopup1(myurl){
				var newWindowx2;
				//alert(myurl);
				var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=400,height=300';
				newWindowx2=window.open(myurl,'popupx',props);
			}

			function explain1(name,output,msg,plno){
				newwin=window.open('','','top=150,left=150,width=400%,height=400%');
				if(!newwin.opener)
					newwin.opener=self;
				with(newwin.document)
				{
					open();
					write('<html>');
					write('<head>');
					write('<link rel="stylesheet" href="style1.css" type="text/css"/>');
					write('<body onLoad="document.form.box.focus()"><form name=form><h1>'+msg+'</h1><br>');
					write('<p>Enter '+name+' here and it will be copied to the Quote for you.');
					write('<p><center>'+name+':  <textarea name=box cols=30 rows=6 onKeyUp='+output+'=this.value>'+window.document.selectform_pl.n[plno].value+'</textarea>');
					write('<p><input type=button value="Done" class="button" onClick=window.close()>');
					write('</center></form></body></html>');
					close();
					close();
				}
			}

			function addNotesToParent1(src){
				alert("z");
				var iSize=src.tb.value;
				var plh=src.pl_hold.value;
				plh=plh-1;
				var textb=src.tl.value;

				//alert(plh);
				//alert(iSize);
				//alert(textb);
				//alert(window.document.selectform_pl.e.length);

				if(textb=='q'){
					window.document.selectform_pl.q[plh].value="";
				}
				if(textb=='e'){
					window.document.selectform_pl.e[plh].value="";
				}
				var szIDs="";

				if(iSize>1){
					for(var i=0;i<iSize;i++){

						if(src.C1[i].checked==true){
							//alert(src.C1[i].value);
							//dest.options[iIndex] = new Option(src.C1[i].value, i);
							//iIndex++;

							// as requested by Ven

							if(szIDs==""){
								szIDs=src.C1[i].value;
							}else{
								szIDs=szIDs+", "+src.C1[i].value;
							}

						}
					}
				}
				else{
					if(src.C1.checked==true){
						szIDs=src.C1.value;
						//alert(src.C1.value);
					}
				}

				if(szIDs!=""){
					if(textb=='q'){
						window.document.selectform_pl.q[plh].value=szIDs;
					}
					if(textb=='e'){
						window.document.selectform_pl.e[plh].value=szIDs;
					}
				}
			}


			function m_window(theurl)
			{
				//alert("HERE");
				// set width and height
				var the_width=800;
				var the_height=625;
				// set window position
				var from_top=200;
				var from_left=125;
				// set other attributes
				var has_toolbar='no';
				var has_location='no';
				var has_directories='no';
				var has_status='yes';
				var has_menubar='yes';
				var has_scrollbars='yes';
				var is_resizable='yes';
				// atrributes put together
				var the_atts='width='+the_width+',height='+the_height+',top='+from_top+',screenY='+from_top+',left='+from_left+',screenX='+from_left;
				the_atts+=',toolbar='+has_toolbar+',location='+has_location+',directories='+has_directories+',status='+has_status;
				the_atts+=',menubar='+has_menubar+',scrollbars='+has_scrollbars+',resizable='+is_resizable;
				// open the window
				window.location=theurl;
				//window.open(theurl,'',the_atts);
			}
			function m_window2(theurl)
			{
				// set width and height
				var the_width=800;
				var the_height=625;
				// set window position
				var from_top=200;
				var from_left=125;
				// set other attributes
				var has_toolbar='no';
				var has_location='no';
				var has_directories='no';
				var has_status='yes';
				var has_menubar='yes';
				var has_scrollbars='yes';
				var is_resizable='yes';
				// atrributes put together
				var the_atts='width='+the_width+',height='+the_height+',top='+from_top+',screenY='+from_top+',left='+from_left+',screenX='+from_left;
				the_atts+=',toolbar='+has_toolbar+',location='+has_location+',directories='+has_directories+',status='+has_status;
				the_atts+=',menubar='+has_menubar+',scrollbars='+has_scrollbars+',resizable='+is_resizable;
				// open the window
				//window.location=theurl;
				window.open(theurl,'',the_atts);
			}
			function m_window2x(theurl)
			{
				m_window2(theurl);
				var agree=confirm("Final pricing?");
				if(agree){
					//alert("send email");

					var the_width=100;
					var the_height=100;
					// set window position
					var from_top=200;
					var from_left=125;
					// set other attributes
					var has_toolbar='no';
					var has_location='no';
					var has_directories='no';
					var has_status='yes';
					var has_menubar='yes';
					var has_scrollbars='yes';
					var is_resizable='yes';
					// atrributes put together
					var the_atts='width='+the_width+',height='+the_height+',top='+from_top+',screenY='+from_top+',left='+from_left+',screenX='+from_left;
					the_atts+=',toolbar='+has_toolbar+',location='+has_location+',directories='+has_directories+',status='+has_status;
					the_atts+=',menubar='+has_menubar+',scrollbars='+has_scrollbars+',resizable='+is_resizable;
					// open the window
					//window.location=theurl;
					var emailurl="ads_final_pricing_send.jsp?order_no="+document.adsform.order_no.value;
					window.open(emailurl,'xx',the_atts);
				}
			}
			function m_window3(theurl){
				var theurlx=theurl+"&base="+document.adsform.orderpull.value;
				//alert(theurlx);
				var the_width=800;
				var the_height=625;
				var from_top=200;
				var from_left=125;
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
				window.open(theurlx,'',the_atts);
			}
			function checkWindow2(){

				if(window.myWindowx3){
					if(myWindowx3&&typeof (myWindowx3.closed)!='unknown'&&!myWindowx3.closed){
						myWindowx3.form1.url.value=document.formPDF.url.value;
						myWindowx3.form1.isLandscape.value="YES";
						myWindowx3.form1.isLVRSummary.value="YES";

						myWindowx3.form1.order_no.value=document.formPDF.order_no.value;
						//myWindowx3.form1.paper.value="A4";

						//myWindowx3.form1.country.value="Poland";
					}
					else{

						setTimeout("checkWindow2();",1000);
					}
				}
				else{
					setTimeout("checkWindow2();",1000);
				}
			}
			function goPdf(urlx){
				var the_width=1024;
				var the_height=768;
				var from_top=200;
				var from_left=0;
				var has_toolbar='no';
				var has_location='no';
				var has_directories='no';
				var has_status='yes';
				var has_menubar='no';
				var has_scrollbars='yes';
				var is_resizable='yes';
				var the_atts='width='+the_width+',height='+the_height+',top='+from_top+',screenY='+from_top+',left='+from_left+',screenX='+from_left;
				the_atts+=',toolbar='+has_toolbar+',location='+has_location+',directories='+has_directories+',status='+has_status;
				the_atts+=',menubar='+has_menubar+',scrollbars='+has_scrollbars+',resizable='+is_resizable;
				var theurl="pdfInit.jsp";
				myWindowx3=window.open(theurl,'myWindowx3',the_atts);
				if(window.myWindowx3){
					if(myWindowx3&&typeof (myWindowx3.closed)!='unknown'&&!myWindowx3.closed){
						setTimeout("checkWindow2();",1000);
					}
					else{
						setTimeout("checkWindow2();",1000);
					}
				}
				else{
					setTimeout("checkWindow2();",1000);
				}
			}





			function ims(urlx){
				var theurl;
				var theurl="pdfInitIMS.jsp";
				var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=400,height=400';
				myWindow=window.open(theurl,'myWindow',props);
				document.adsform.imsurl.value=urlx;
				if(window.myWindow){
					if(myWindow&&typeof (myWindow.closed)!='unknown'&&!myWindow.closed){
						setTimeout("checkWindowIms();",1000);
					}
					else{
						setTimeout("checkWindowIms();",1000);
					}
				}
				else{
					setTimeout("checkWindowIms();",1000);
				}
			}
			function checkWindowIms(type){
				if(window.myWindow){
					if(myWindow&&typeof (myWindow.closed)!='unknown'&&!myWindow.closed){
						myWindow.form1.order_no.value=document.adsform.order_no.value;
						myWindow.form1.type.value="workcopy";
						myWindow.form1.url3.value=document.adsform.imsurl.value;
					}
					else{
						setTimeout("checkWindow(type);",1000);
					}
				}
				else{
					setTimeout("checkWindow(type);",1000);
				}
			}



			function lineItem(){
				alert("lineItem");
				parent.postMessage("test2","*");
				alert("HERE");
				window.parent.postMessage("test2","*");
				alert("2");
				//alert("after post");
			}
			function showOWS(){
				window.parent.postMessage("OWS","*");
			}
			function notes(s1){
				//alert("notes");
				notesDiv2.style.visibility='visible';
				//alert("2");
				loadNotes(s1);
			}
			function cancelNotes(){
				//alert("cancel notes");
				notesDiv2.style.visibility='hidden';
				clearNotes();
			}
			function saveNotes(){
				//alert("save notes");
				var s1=document.notesForm.secNo.value;
				//alert(s1+":::2"+document.notesForm.freeTextNotesForm.value);
				document.selectform_pl.n[s1-1].value=document.notesForm.freeTextNotesForm.value;
				//alert("3");
				var tempqlf="";
				var tempexc="";
				//alert("b");
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
				//alert("c");
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
				//alert("d");
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
				//alert("E");
				document.selectform_pl.q[s1-1].value=tempqlf;
				document.selectform_pl.e[s1-1].value=tempexc;
				notesDiv2.style.visibility='hidden';
				clearNotes();
			}
			function loadNotes(s1){

				document.notesForm.secNo.value=s1;
				document.notesForm.freeTextNotesForm.value=Trim(document.selectform_pl.n[s1-1].value);

				var tempexclusions=document.selectform_pl.e[s1-1].value;
				if(tempexclusions.length>0&&tempexclusions.slice(tempexclusions.length,1)!=","){
					tempexclusions+=","
				}
				//alert("b");
				var iLoc=1;
				var iIndex="";
				//alert("1");
				do{
					iLoc=tempexclusions.indexOf(",");
					if(iLoc>=0){
						//alert("2");
						iIndex=tempexclusions.slice(0,iLoc);
						//alert("a"+tempexclusions.length+":::"+iLoc+":::"+tempexclusions.slice(iLoc+1,tempexclusions.length));
						tempexclusions=Trim(tempexclusions.slice(iLoc+1,tempexclusions.length));
						//alert("b");
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
						//alert("3");
					}
				}while(iLoc>=0);
				//alert("4");
				var tempqualifying=document.selectform_pl.q[s1-1].value;
				//alert("5");
				if(tempqualifying.length>0&&tempqualifying.slice(tempqualifying.length,1)!=","){
					tempqualifying+=",";
				}
				iLoc=1;
				iIndex="";
				//alert("c");
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
				//alert("d");
			}
			function clearNotes(){
				//alert("clear notes");
				document.notesForm.secNo.value="";
				document.notesForm.freeTextNotesForm.value="";
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






		</script>
	</HEAD>
	<!--<h1>Quote Sections</h1>-->
	<%@ page language="java" import="java.sql.*" import="java.text.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
	<%@ include file="db_con.jsp"%>
	<div name='main'>
		<%
		
		boolean sectionsGood=true;

		String order_no = request.getParameter("orderNo");//

		String q_no=request.getParameter("q_no");

		if(order_no == null || order_no.trim().length()==0){
			order_no=q_no;
		}
		if(q_no == null || q_no.trim().length()==0){
				q_no=order_no;
		}
		out.println(order_no+":: order number");
//quoteHeader.setOrderNo(order_no);
out.println("after");
		String message="<font color='blue'>Pricing For Job No "+q_no+"<font>";
		//HttpSession UserSession1 = request.getSession();

//		String name=userSession.getUserId();
//		String group=userSession.getGroup();
//		String rep_no=userSession.getRepNo();
String name="";
String group="";
String rep_no="";





		String doc_type="";
		ResultSet rs_projectx = stmt.executeQuery("SELECT doc_type FROM doc_header where doc_number like '"+order_no+"'");
		if (rs_projectx !=null) {
			while (rs_projectx.next()) {
				doc_type= rs_projectx.getString("doc_type");
			}
		}
		rs_projectx.close();
		%>
		<%//@ include file="rqs_head.jsp"%>

		<BODY bgcolor="whitesmoke" >
		<center>

			<%
					String close=request.getParameter("close");
					if(close == null || close.equals("null")){
						close="";
					}
					String access_central=request.getParameter("access_central");
					String productx=request.getParameter("product");
					if(access_central==null){
						access_central="";
					}
					if(productx==null){
						productx="";
					}

					String pg = request.getParameter("cmd");//what page
					if(pg==null){
						pg="1";
					}
					//out.println(order_no+"::"+pg+"::");
					boolean isEqualSec=true;
					String leftOver="";

			//****************************** ATTENTION ******************************
			//**************** this is where the new page for section overage/ discount etc is by passed********
			//if(pg.equals("5")){
			//	pg="1";
			//}
			//***************** end of bypass*******************


			//product info
					String product_name="";String tot_overage="";String tot_setup_cost="";String tot_handling_cost="";String tot_freight_cost="";String project_typex="";
					ResultSet rs_project = stmt.executeQuery("SELECT product_id,overage,setup_cost,handling_cost,freight_cost,project_type FROM cs_project where Order_no like '"+order_no+"'");
					if (rs_project !=null) {
				   while (rs_project.next()) {
					product_name= rs_project.getString("product_id");
					if(rs_project.getString("overage") == null || rs_project.getString("overage").trim().length()<1){
						tot_overage="0";
					}
					else{
						tot_overage= rs_project.getString("overage");
					}
					if(rs_project.getString("setup_cost") == null || rs_project.getString("setup_cost").trim().length()<1){
						tot_setup_cost="0";
					}
					else{
						tot_setup_cost= rs_project.getString("setup_cost");
					}
					if(rs_project.getString("handling_cost") == null || rs_project.getString("handling_cost").trim().length()<1){
						tot_handling_cost="0";
					}
					else{
						tot_handling_cost= rs_project.getString("handling_cost");
					}
					if(rs_project.getString("freight_cost") == null || rs_project.getString("freight_cost").trim().length()<1){
						tot_freight_cost="0";
					}
					else{
						tot_freight_cost= rs_project.getString("freight_cost");
					}
					//out.println(rs_project.getString("project_type")+"::<BR>");
					project_typex=rs_project.getString("project_type");
											  }
									   }
			rs_project.close();
			//out.println(product_name+" product_id<BR>");
			if(project_typex==null){
				project_typex="";
			}
String qlfNotes="";
String excNotes="";
			
			String table_name="cs_qlf_notes";
			String div="";
			//out.println("select * from " + table_name + " where product_id='" + product_name + "' order by code");
			ResultSet rs1 = stmt.executeQuery("select * from " + table_name + " where product_id='" + product_name + "' order by code");
			if(rs1 != null){
				while(rs1.next()){

						if(product_name.equals("ADS")){
							div = div + "<input type='checkbox' name='" + table_name + "1' id='" + table_name + "1' value='" + rs1.getString("code") + "'>" + rs1.getString("code") + ". " + rs1.getString("description") + " <font color='red'>" + rs1.getString("type") + "</font><BR>";
						}
						else{
							div = div + "<input type='checkbox' name='" + table_name + "1' id='" + table_name + "1' value='" + rs1.getString("code") + "'>" + rs1.getString("code") + ". " + rs1.getString("description") + " <font color='red'>" + rs1.getString("model") + "</font><BR>";
							//out.println(div);
						}
					
				}
				rs1.close();
			}			
			qlfNotes=div;
			div="";
			table_name="cs_exc_notes";
			ResultSet rs2 = stmt.executeQuery("select * from " + table_name + " where product_id='" + product_name + "' order by code");
			if(rs2 != null){
				while(rs2.next()){

						if(product_name.equals("ADS")){
							div = div + "<input type='checkbox' name='" + table_name + "1' id='" + table_name + "1' value='" + rs2.getString("code") + "'>" + rs2.getString("code") + ". " + rs2.getString("description") + "<font color='red'>" + rs2.getString("type") + "</font><BR>";

						}
						else{
							div = div + "<input type='checkbox' name='" + table_name + "1' id='" + table_name + "1' value='" + rs2.getString("code") + "'>" + rs2.getString("code") + ". " + rs2.getString("description") + "<BR>";
						}
					
				}
				rs2.close();
			}							
excNotes=div;

			int sections=0;String section_info="";int sect_count=0;String section_group="";String section_qual="";String section_excl="";String section_notes="";
			String section_overage="";String section_setup_cost="";String section_handling_cost="";String section_freight_cost="";
			String section_page="";
			ResultSet rs = stmt.executeQuery("select * from cs_quote_sections where order_no='"+order_no+"' ");
			while(rs.next()){
				section_info = rs.getString(2);
				sections=rs.getInt(3);
					section_group = rs.getString(4);
				section_qual=rs.getString(5);
				section_excl=rs.getString(6);
				section_notes=rs.getString(7);
				section_page=rs.getString("section_page");
				section_overage=rs.getString("overage");
				section_handling_cost=rs.getString("handling_cost");
				section_freight_cost=rs.getString("freight_cost");
				section_setup_cost=rs.getString("setup_cost");
				sect_count++;
			}
			rs.close();
		//out.println("a"+pg);
			if(pg.equals("1")){

			%>
			<%//@ include file="sections_validation.jsp"%>
			<% if(! product_name.equals("ADS")){
			%>
			<table border='0' width='100%'><tr class='header1'>
					<td width='100%' align='left'><h3>TOTAL SECTIONS:</h3></td>
				</tr></table>
				<%
			}

		//out.println("b");
			String session_rep_no1= rep_no;

			out.println("<form name='selectform' method='post' action='sections1_save.jsp' onsubmit=\"validate(document.selectform.test1);\">");
			out.println("<input type='hidden' name='close' value='"+close+"'>");

			if(!product_name.equals("ADS")){
			//out.println("<tr><td COLSPAN='1'><h1>Total Sections ::</h1></td></tr>");

			out.println("<tr><td align='right' width='50%'><b>No of Sections:</b></td>");
			out.println("<td width='50%'><input type='text' name='test1' value='"+sections+"' ></td>");
			out.println("</tr>");
			out.println("<tr><td COLSPAN='2' align='center'>&nbsp;&nbsp;</td></tr>");
			out.println("<tr><td COLSPAN='2' align='center'>");
			out.println("<input type='hidden' name='sect_count' value='"+sect_count+"' class='button' >");
			out.println("<input type='hidden' name='q_no' value='"+order_no+"' class='button' >");

			out.println("<input type='hidden' name='product' value='"+product_name+"'  >");
			out.println("<input type='submit' name='enter' value='Continue' class='button' >");
			out.println("</td>");
			out.println("</tr>");
			}
		//out.println("c");
			String oldNum=String.valueOf(sections);
			out.println("<input type='hidden' name='oldNum' value='"+oldNum+"'>");
			out.println("</form>");
			//out.println("HERE1"+product_name+"::");

					boolean goodToGo=false;
							//out.println("d");
			if(product_name.equals("FSM")|product_name.equals("LVR")|product_name.equals("GRILLE")|product_name.equals("SUNSHADE")|product_name.equals("ADS")|product_name.equals("DADE_LVR")|product_name.equals("BV")){
			//out.println("HERE12");
				//boolean goodToGo=false;
				out.println("<tr><Td colspan='2'>");
				int numberOfSections=0;
				String sectionInfo="";
				String sectionGroup="";
				//out.println("HERE4");
				ResultSet rsIsSections=stmt.executeQuery("Select section_info,sections,section_group from cs_quote_sections where order_no = '"+order_no+"'");
				if(rsIsSections != null){
					while(rsIsSections.next()){
						numberOfSections=rsIsSections.getInt("sections");
						sectionInfo=rsIsSections.getString("section_info");
						sectionGroup=rsIsSections.getString("section_group");
					}
				}
				rsIsSections.close();
				//out.println("HERE3x");
				//out.println(numberOfSections+"::"+sectionInfo+"::"+sectionGroup+"<BR>");
		if(sectionsGood){
				//out.println("HERE1x");
				//session_rep_no1="123";
				//out.println("HERE1");
				if(numberOfSections == 0||sectionInfo == null ||sectionInfo.trim().length()<1){
					if((sectionInfo == null || sectionInfo.trim().length()<1)&&numberOfSections>0){
						out.println("Please complete section information<BR>");
					}
					if(product_name.equals("ADS")){

						out.println("<input type='button' class='button' name='Price Calculator' value='Price Calculator' onclick=m_window('http://"+ application.getInitParameter("HOST")+"/erapid/us/legacy/ads_price_calc.jsp?q_no="+ order_no+"&product="+ product_name+"')>");
				%>
				<!--<font face="Arial" color="#003000"><B><a href="javascript:m_window('http://<%= application.getInitParameter("HOST")%>/erapid/us/legacy/ads_price_calc.jsp?q_no=<%= order_no%>&product=<%= product_name%>')">Price Calculator</a> <font face="Arial" color="navy"></font>-->
			<%
		}
		else{


		}

		//out.println("d");
		//out.println("HERE2");
	}

	else{
				//out.println("e");
				//out.println("e");
		//out.println("HERE3");
		String sectionNames[]=new String[numberOfSections];
		for(int e=0; e<numberOfSections; e++){
			int start=0;
			int end=0;
			start=sectionInfo.indexOf(";");
			if(start>0){
				end=sectionInfo.indexOf("=");
				sectionNames[e]=sectionInfo.substring(end+1,start);
				sectionInfo=sectionInfo.substring(start+1);
				//out.println(sectionInfo+"::<BR>");
				leftOver=sectionInfo;
			}
		}
		if(leftOver.length()>1){
			isEqualSec=false;
			out.println("<font color='red' size='2'>Error in Section Information.  Please resubmit Section Information.</font><BR>");
		}



		for(int y=0; y<numberOfSections; y++){
			//out.println(sectionNames[y]+"::"+sectionLines[y]+"<BR>");
			if(product_name.equals("ADS")){
				out.println("<input type='button' class='button' name='Price Calculator' value='Price Calculator' onclick=m_window('http://"+application.getInitParameter("HOST")+"/erapid/us/legacy/ads_price_calc.jsp?q_no="+ order_no+"&product="+ product_name+"&section="+(y+1)+"')><BR>");
			%>
			<!--<font face="Arial" color="#003000"><B><a href="javascript:m_window('http://<%= application.getInitParameter("HOST")%>/erapid/us/legacy/ads_price_calc.jsp?q_no=<%= order_no%>&product=<%= product_name%>&section=<%=y+1%>')">3Price Calculator</a> for section "<%=sectionNames[y]%>" <font face="Arial" color="navy"></font> <BR>-->
			<%
		}
		else{

		}
	}
	}
	//out.println("HERE4");

	out.println("</td></tr>");
	if(product_name.equals("ADS")){
	ResultSet rsADS=stmt.executeQuery("select count(*) from cs_ads_price_calc where order_no='"+order_no+"'");
	if(rsADS != null){
		while(rsADS.next()){
			if(rsADS.getInt(1)>0){
				goodToGo=true;
			}
		}
	}
	rsADS.close();
	}
	else{
	ResultSet rsAcCount=stmt.executeQuery("select count(*) from cs_access_central where order_no ='"+order_no+"'");
	if(rsAcCount != null){
		while(rsAcCount.next()){
			if(rsAcCount.getInt(1)>=numberOfSections && rsAcCount.getInt(1)> 0){
				goodToGo=true;
			}
		}
	}
	rsAcCount.close();
	}
	out.println("before");
	if(validationBean.checkSections2(order_no).trim().length()>0){
		out.println("<font size='4' color='red'>"+validationBean.checkSections2(order_no)+"</font>");
		goodToGo=false;
	}
	out.println("after");
	if(goodToGo && ((sectionGroup != null && sectionGroup.trim().length()>0) || numberOfSections <1)){
	if(product_name.equals("ADS")){
		out.println("<form name='adsform'>");
		out.println("<input type='hidden' name='order_no' value='"+order_no+"'>");
		out.println("<tr><td colspan='2'>");
		out.println("<input type='button' class='button' name='Work Copy' value='Work Copy' onclick=m_window2('../reports/work_copy_home_ads.jsp?orderNo="+order_no+"&pid=3&tp=0')><BR>");
		out.println("</td></tr>");
		out.println("<tr><td colspan='2'>");
			%>
			<input type='button' class='button' name='SEND WORK COPY TO IMS' value='SEND WORK COPY TO IMS' 				onclick="ims('http://<%=application.getInitParameter("HOST")%>/erapid/us/legacy/work_copy_home_ads.jsp?q_no=<%=order_no%>&pid=3&tp=0')">
			<input type='hidden' name='imsurl' value='http://<%=application.getInitParameter("HOST")%>/erapid/us/reports/work_copy_home_ads.jsp?orderNo=<%=order_no%>&pid=3&tp=0'>
			<input type='hidden' name='imstype' value=''>

			<%
			if(project_typex==null || !project_typex.equals("SFDC")){
				//out.println("</td></tr>");
				//out.println("<tr><td colspan='2'>");
				//out.println("<input type='button' class='button' name='Send to PSA' value='Send to PSA' onclick=m_window2('psaADS.jsp?order_no="+order_no+"')><BR>");
			//out.println("</td></tr>");
			}
		out.println("<tr><td colspan='2'>");
		out.println("<input type='button' class='button' name='Tear Sheets' value='Tear Sheets' onclick=m_window2('../reports/ads_tear_sheet.jsp?orderNo="+order_no+"&username="+name+"')><BR>");
			%>
			<%
			out.println("</td></tr>");
			out.println("<tr><td colspan='2'>");
			out.println("<input type='button' class='button' name='Output to CAD' value='Output to CAD' onclick=m_window2x('../reports/ads_cad_output.jsp?orderNo="+order_no+"')>");
			%>
			<Font color='red'>* Please remember to rerun CAD<BR></font>
			<%
			out.println("</td></tr>");
			out.println("<tr><td colspan='2'>");
			out.println("<input type='button' class='button' name='Output for BPCS' value='Output for BPCS' onclick=m_window2('../reports/ads_cad_output.jsp?orderNo="+order_no+"');m_window2('../reports/show_summary2.jsp?orderNo="+order_no+"&pid=3&nowc=2');><BR>");
			%>
			<%
			out.println("</td></tr>");
			out.println("<tr><td colspan='2'>");
			out.println("<input type='button' class='button' name='Change order' value='Change Order' onclick=m_window2('../reports/ads_change_order_init.jsp?order_no="+order_no+"')><BR>");
			out.println("</td></tr>");


			if(doc_type.equals("O")){
				out.println("<tr><td colspan='2'>");
				//out.println("<td align='center' >");
				out.println("<input type='button' class='button' name='Order Write-up Sheet' value='Order Write-up' onclick='showOWS()'>");
				//javascript:document.location.href='http://"+ application.getInitParameter("HOST")+"/erapid/us/orders/ows/order_entry_transfer_home.jsp?cmd=1&id="+session_rep_no1+"&order_no="+order_no+"'>");
				out.println("</td></tr>");
			}
			if(!order_no.endsWith("_00")){
				out.println("<tr><td colspan='2'>");
				out.println("<input type='button' class='button' name='ADS Pricing Summary' value='ADS Pricing Summary' onclick=m_window3('../reports/ads_pricing_summary.jsp?orderNo="+order_no+"')>");
				out.println("<select name='orderpull'>");
				ResultSet rsorderno=stmt.executeQuery("select order_no from cs_project where order_no like '"+order_no.substring(0,6)+"%' and not order_no='"+order_no+"' order by order_no ");
				if(rsorderno != null){
					while(rsorderno.next()){
						out.println("<option value='"+rsorderno.getString(1)+"'>"+rsorderno.getString(1)+"</option>");
					}
				}
				rsorderno.close();
				out.println("</select><BR>");




				out.println("</td></tr>");
			}
			out.println("</form>");
		}
		else{

			if(doc_type.equals("O")){
				out.println("<tr><td colspan='2'>");
				//out.println("<td align='center' >");
				out.println("<input type='button' class='button' name='Order Write-up Sheet' value='Order Write-up' onclick='showOWS()'>");
				//javascript:document.location.href='http://"+ application.getInitParameter("HOST")+"/erapid/us/orders/ows/order_entry_transfer_home.jsp?cmd=1&id="+session_rep_no1+"&order_no="+order_no+"'>");
				out.println("</td></tr>");
			}
		}
	}
	else{
		//out.println("not good");
	}
	}
	else{

	}


	}
	//if(product_name.equals("LVR")|product_name.equals("GRILLE")|product_name.equals("ADS")|product_name.equals("DADE_LVR")|product_name.equals("SUNSHADE")|product_name.equals("BV")){
	//out.println("<tr><td><font size='1'>&nbsp;<br></font><input type='button' class='button' name='Line Item List' value='Line Item List' onclick='lineItem()'>");
	 //"javascript:document.location.href='http://"+ application.getInitParameter("HOST")+"/erapid/us/legacy/order_list.jsp?order_no="+ q_no+"'>");
	//}
	//out.println("TEST THIS::"+project_typex+"::"+goodToGo+"::");
	if(project_typex.equals("SFDC")&&goodToGo){
				%>
				<%@ include file="sfdc_quote_home.jsp"%>
				<%
					if(application.getInitParameter("HOST").toUpperCase().indexOf("DEV")>0){
		out.println("<tr><td align='left'><a href='https://c.cs3.visual.force.com/apex/TestLink?quoteNO="+q_no+"1' target='_top' ><img border='0' src='../../images/sfdc_image1.jpg'></a>	</tr>");
	}
	else{
		out.println("<tr><td align='left'><a href='https://na44.salesforce.com/apex/TestLink?quoteNO="+q_no+"1' target='_top' ><img border='0' src='../../images/sfdc_image1.jpg'></a></tr>");
	}
out.println("</table");
			}





		}
		else if(pg.equals("2")){
			out.println("<link rel='stylesheet' href='style1.css' type='text/css' /><table border='1' width='100%'>");
			out.println("<form name='selectform' method='post' action='sections2_save.jsp' onsubmit=\"validate(document.selectform.test1);\">");
			out.println("<input type='hidden' name='close' id='close' value='"+close+"'>");
			out.println("<tr class='header1'><td COLSPAN='2'><h3>Section Descriptions ::</h3></td></tr>");
			int desc_count=0;String desc_value="";String var="";
			//out.println("1");
			//out.println(sections+":: sections");
			for(int i=0;i<sections;i++){
				//out.println("2");
				//out.println(i+"::"+sections);
				desc_count=i+1;
				var="s"+desc_count+"=";
				//out.println("a--"+section_info);
				//out.println("Test "+var);
				if(section_info!=null){
					//out.println("b--");
					int config_s1= section_info.indexOf(var);
					if(config_s1>=0){
						//out.println("c");
						int config_s2=section_info.indexOf(";",config_s1+1);
						//out.println("d");
						desc_value=section_info.substring(config_s1+var.length(),config_s2);
						//out.println("e");
						//						out.println(var+"/"+desc_value+":"+config_s1+":"+var.length()+":");
					}
					else{desc_value="";}
				}else{section_info="";}
				//out.println("xx");
				out.println("<tr><td align='right' ><b>Section Description "+desc_count+":</b></td>");
				//out.println("a");
				out.println("<td ><input type='text' name='s"+desc_count+"' value='"+desc_value+"' class='text1'></td>");
				out.println("</tr>");
				//out.println("3");
				//var="";
			}
			out.println("<tr>");
			out.println("<td COLSPAN='2' align='center' >");
			//	out.println("4");
			if(section_page!=null){
			if(section_page.equals("0")){
			out.println("<input type='checkbox' name='section_page' >");
			}else{out.println("<input type='checkbox' name='section_page' checked>");}
			}else{out.println("<input type='checkbox' name='section_page' >");}
			out.println("<b>Section per page</b>");
			out.println("</td></tr>");
			out.println("<tr><td COLSPAN='1' align='left'>");
			out.println("<input type='hidden' name='sect_count' value='"+sect_count+"' class='button' >");
			out.println("<input type='hidden' name='q_no' value='"+order_no+"' class='button' >");
			out.println("<input type='hidden' name='sections' value='"+sections+"' class='button' >");
			out.println("<input type='hidden' name='access_central' value='"+access_central+"'  >");
			out.println("<input type='hidden' name='product' value='"+product_name+"'  >");
			out.println("<input type='button'  class='button'  value='Go Back' OnClick='history.go( -2 );return true;'><!--<a href = 'javascript:history.back()'>  Go back  </a>--></td><td align='left'>");
			out.println("<input type='submit' name='enter' value='Continue' class='button' >");
			//out.println("test"+section_page);
			out.println("</td>");
			out.println("</tr>");
			out.println("</form>");
			out.println("</table");
		}

		// CODE EDITED BY GREG
		// Started Jun 21/05
		//
		else if(pg.equals("4")){
		out.println("<table border='1' width='100%'>");
		out.println("<form name='selectform_pl' method='post' action='sections4_save.jsp' onsubmit=\"validate(document.selectform.test1);\">");
		out.println("<input type='hidden' name='close' value='"+close+"'>");
		out.println("<tr class='header1'><td COLSPAN='2'><h3>Section Notes ::</h3></td></tr>");
		int desc_count=0;int loop_count=0;String desc_value="";String var="";String qual_value="";String excl_value="";String notes_value="";
		for(int j=0;j<sections;j++){
		loop_count = j+1;
		}
		//out.println("<td class='header'><input type='text' name='de_sc' value='"+loop_count+"' class='text'></td>");
		for(int i=0;i<sections;i++){
		desc_count=i+1;
		var="s"+desc_count+"=";
		//out.println("Test "+var);
				if(section_qual!=null&&section_qual.trim().length()>0){
							int config_s1= section_qual.indexOf(var);
							if(config_s1>=0){
								int config_s2=section_qual.indexOf(";",config_s1+1);
								qual_value=section_qual.substring(config_s1+var.length(),config_s2);
		//						out.println(var+"/"+desc_value+":"+config_s1+":"+var.length()+":");
							}
							//out.println(qual_value+"<BR>");
							else{qual_value="";}
				}else{section_qual="";}
				if(section_excl!=null&&section_excl.trim().length()>0){
							int config_s1= section_excl.indexOf(var);
							if(config_s1>=0){
								int config_s2=section_excl.indexOf(";",config_s1+1);
								excl_value=section_excl.substring(config_s1+var.length(),config_s2);
		//						out.println(var+"/"+desc_value+":"+config_s1+":"+var.length()+":");
							}
							else{excl_value="";}
				}else{section_excl="";}
				if(section_notes!=null&&section_notes.trim().length()>0){
							int config_s1= section_notes.indexOf(var);
							if(config_s1>=0){
								int config_s2=section_notes.indexOf(";",config_s1+1);
								notes_value=section_notes.substring(config_s1+var.length(),config_s2);
		//						out.println(var+"/"+desc_value+":"+config_s1+":"+var.length()+":");
							}
							else{notes_value="";}
				}else{section_notes="";}
		out.println("<tr class='header1'><td COLSPAN='2'><h3>Section "+desc_count+" ::</h3></td></tr>");

				%>

			<tr><td  align='right' ><b><!--<a href="javascript:showPopup1('http://<%= application.getInitParameter("HOST")%>/erapid/us/legacy/exc.master_sections.jsp?pid=<%= product_name %>&tbox=q&place=<%= desc_count %>')" color="navy" face="Arial">-->
						<a href='javascript:notes("<%=desc_count%>")'>Section Qualifying<%= desc_count%></a></b></td>
				<td ><input type='text' name='q' onclick='notes("<%=desc_count %>")' onkeyup="this.value=this.value.replace(/[^0-9,\ ]/,'')" value='<%=qual_value%>' class='text'></td>
					<%
					out.println("</tr>");

					%>
			<tr><td  align='right' ><b><!--<a href="javascript:showPopup1('http://<%= application.getInitParameter("HOST")%>/erapid/us/legacy/qual.master_sections.jsp?pid=<%= product_name %>&tbox=e&place=<%= desc_count %>')" color="navy" face="Arial">-->
						<a href='javascript:notes("<%=desc_count%>")'>Section Exclusions<%= desc_count%></a></b></td>
						<%
						//out.println(excl_value+":::<BR>");
						%>
				<td ><input type='text' name='e' onclick='notes("<%=desc_count %>")' onkeyup="this.value=this.value.replace(/[^0-9,\ ]/,'')" value='<%=excl_value%>' class='text'></td>
					<%
					out.println("</tr>");
					out.println("<tr>");
					%>
				<td  align='right' ><a href='javascript:notes("<%=desc_count%>")'>
						<!--

explain1('Free Text', 'opener.document.selectform_pl.n[<%= desc_count%>].value', 'Free Text','<%= desc_count-1 %>');" onMouseOver="window.status='Click for Entering Free Text area...';
return true;" onMouseOut="window.status='';
return true;">--><b>Section Free Notes <%=desc_count%>:</b></A></td>
						<%
						//out.println(desc_count+" descount::<BR>");
						out.println("<td ><textarea name='n' cols='20' rows='1' > "+ notes_value.trim() +"</textarea></td>");
						//input type='text' name='n' value='"+notes_value+"' class='text'></td>");
						out.println("</tr>");
						}
						out.println("<tr><td COLSPAN='2' align='center'>&nbsp;&nbsp;</td></tr>");
						out.println("<tr><td COLSPAN='1' align='left'>");
						out.println("<input type='hidden' name='sect_count' value='"+sect_count+"' class='button' >");
						out.println("<input type='hidden' name='q_no' value='"+order_no+"' class='button' >");
						out.println("<input type='hidden' name='sections' value='"+sections+"' class='button' >");
						out.println("<input type='button'  class='button'  value='Go Back' OnClick='history.go( -2 );return true;'></td><td align='left'>");
						out.println("<input type='submit' name='enter' value='Continue' class='button' >");
						out.println("</td>");
						out.println("</tr>");
						out.println("</form>");
						out.println("</table");
						}
						//  END OF CODE EDITED BY GREG
						else if(pg.equals("5")){//for the extra charges


							int desc_count=0;String var="";String overage_value="";String handling_cost_value="";String setup_cost_value="";String freight_cost_value="";
							out.println("<table border='1' width='100%'>");
							out.println("<form name='scr_form' method='post' action='sections5_save.jsp' onsubmit='return validate1(document.scr_form);'>");
							out.println("<input type='hidden' name='close' value='"+close+"'>");
							out.println("<tr class='header1'><td COLSPAN='2'><h3>Section Charges ::</h3></td></tr>");
							out.println("<input type='hidden' name='numSections' value='"+sections+"'>");
							out.println("<input type='hidden' name='tot_overage' value='"+tot_overage+"'>");
							out.println("<input type='hidden' name='tot_handling' value='"+tot_handling_cost+"'>");
							out.println("<input type='hidden' name='tot_freight' value='"+tot_freight_cost+"'>");
							out.println("<input type='hidden' name='tot_setup' value='"+tot_setup_cost+"'>");
							out.println("<input type='hidden' name='productX' value='"+product_name+"'>");
							out.println("<input type='hidden' name='access_central' value='"+access_central+"'  >");
							out.println("<input type='hidden' name='product' value='"+product_name+"'  >");
							for(int i=0;i<sections;i++){
								desc_count=i+1;
								var="s"+desc_count+"=";
								if(i==0){out.println("<tr class='header1'><td COLSPAN='1'><h3>OVERAGE :: "+tot_overage+"</h3></td>");
										 out.println("<td ><input type='hidden' name='tot_o' value='"+overage_value+"' class='text'>&nbsp;</td></tr>");
										}
								if(section_overage!=null&&section_overage.trim().length()>0){
												int config_s1= section_overage.indexOf(var);
												if(config_s1>=0){
													int config_s2=section_overage.indexOf(";",config_s1+1);
													overage_value=section_overage.substring(config_s1+var.length(),config_s2);
												}
												else{overage_value="";}
								}else{overage_value="";}
									out.println("<tr>");
									out.println("<td  align='right'><b>Section "+desc_count+"</b></td>");
									out.println("<td ><input type='text' name='o' value='"+overage_value+"' class='text'></td>");
									out.println("</tr>");

							}
							if(product_name.equals("EFS")){
								desc_count=0;var="";
								for(int i=0;i<sections;i++){
									desc_count=i+1;
									var="s"+desc_count+"=";
									if(i==0){out.println("<tr class='header1' ><td COLSPAN='1'><h3>SET-UP COST:: "+tot_setup_cost+"</h3></td><td>&nbsp;</td></tr>");}
									if(section_setup_cost!=null&&section_setup_cost.trim().length()>0){
													int config_s1= section_setup_cost.indexOf(var);
													if(config_s1>=0){
														int config_s2=section_setup_cost.indexOf(";",config_s1+1);
														setup_cost_value=section_setup_cost.substring(config_s1+var.length(),config_s2);
													}
													else{setup_cost_value="";}
									}else{setup_cost_value="";}
										out.println("<tr>");
										out.println("<td align='right'><b>Section "+desc_count+"</b></td>");
										out.println("<td ><input type='text' name='sc' value='"+setup_cost_value+"' class='text'></td>");
										out.println("</tr>");
								}
							}
							desc_count=0;var="";
							if(!product_name.equals("EFS")){
								for(int i=0;i<sections;i++){
									desc_count=i+1;
									var="s"+desc_count+"=";
									if(i==0){out.println("<tr class='header1'><td COLSPAN='1'><h3>HANDLING COST:: "+tot_handling_cost+"</h3></td><td>&nbsp;</td></tr>");}
									if(section_handling_cost!=null&&section_handling_cost.trim().length()>0){
													int config_s1= section_handling_cost.indexOf(var);
													if(config_s1>=0){
														int config_s2=section_handling_cost.indexOf(";",config_s1+1);
														handling_cost_value=section_handling_cost.substring(config_s1+var.length(),config_s2);
													}
													else{handling_cost_value="";}
									}else{handling_cost_value="";}
										out.println("<tr>");
										out.println("<td  align='right'><b>Section "+desc_count+"</b></td>");
										out.println("<td ><input type='text' name='hc' value='"+handling_cost_value+"' class='text'></td>");
										out.println("</tr>");
								}
							}
							desc_count=0;var="";
							for(int i=0;i<sections;i++){
								desc_count=i+1;
								var="s"+desc_count+"=";
								if(i==0){
									out.println("<tr class='header1'><td COLSPAN='1'><h3>FREIGHT COST:: "+tot_freight_cost+"</h3></td><td>&nbsp;</td></tr>");
								}
								if(section_freight_cost!=null&&section_freight_cost.trim().length()>0){
												int config_s1= section_freight_cost.indexOf(var);
												if(config_s1>=0){
													int config_s2=section_freight_cost.indexOf(";",config_s1+1);
													freight_cost_value=section_freight_cost.substring(config_s1+var.length(),config_s2);
												}
												else{
													handling_cost_value="";
												}
								}
								else{
									freight_cost_value="";
								}
									out.println("<tr>");
									out.println("<td align='right'><b>Section "+desc_count+"</b></td>");
									out.println("<td ><input type='text' name='fc' value='"+freight_cost_value+"' class='text'></td>");
									out.println("</tr>");
							}


							out.println("<tr><td COLSPAN='2' align='center'>&nbsp;&nbsp;</td></tr>");
							out.println("<tr><td COLSPAN='1' align='left'>");
							out.println("<input type='hidden' name='sect_count' value='"+sect_count+"' class='button' >");
							out.println("<input type='hidden' name='q_no' value='"+order_no+"' class='button' >");
							out.println("<input type='hidden' name='sections' value='"+sections+"' class='button' >");
							out.println("<input type='button'  class='button'  value='Go Back' OnClick='history.go( -2 );return true;'></td><td align='left'>");
							out.println("<input type='submit' name='enter' value='Continue' class='button' >");
							out.println("</td>");
							out.println("</tr>");
							out.println("</form>");
							out.println("</table");
						}
						else if(pg.equals("3")){
							int count_line=0;int dm_lines=0;
								Vector markV=new Vector();
								Vector items=new Vector();Vector qty=new Vector();Vector price=new Vector();Vector line_item=new Vector();
								Vector desc=new Vector();Vector seq_no=new Vector();Vector block_id=new Vector();Vector fact_per=new Vector();Vector ec_status=new Vector();
								Vector product_desc=new Vector();Vector price_band=new Vector();Vector product=new Vector();
							   ResultSet rs5 = stmt.executeQuery("SELECT * FROM doc_line where doc_number like '"+order_no+"' order by cast(doc_line as integer)");
								if (rs5!=null){
								while(rs5.next()){
									items.addElement(rs5.getString("doc_line"));
								product.addElement(rs5.getString("product_id"));
								ec_status.addElement(rs5.getString("ec_status"));
								count_line++;
								//out.println(rs5.getString("doc_line")+"<BR>");
											 }
												}
								ResultSet rs3 = stmt.executeQuery("SELECT * FROM csquotes where order_no like '"+order_no+"' order by cast(Line_no as integer)");
							   while ( rs3.next() ) {
								line_item.addElement(rs3.getString ("Line_no"));
								desc.addElement(rs3.getString ("Descript"));
								price.addElement(rs3.getString ("Extended_Price"));
								qty.addElement(rs3.getString("QTY"));
								seq_no.addElement(rs3.getString("Sequence_no"));
								block_id.addElement(rs3.getString("Block_ID"));
								fact_per.addElement(rs3.getString("field16"));
								product_desc.addElement(rs3.getString("field18"));
								price_band.addElement(rs3.getString("field19"));
								markV.addElement(rs3.getString("field17"));
								//out.println(rs3.getString ("Line_no")+"::"+rs3.getString("field17")+"<BR>");
													 }
													 rs3.close();
							    NumberFormat for1 = NumberFormat.getCurrencyInstance();
							   for1.setMaximumFractionDigits(0);
						out.println("<table border='1' width='100%'>");
						out.println("<form name='selectform' method='post' action='sections3_save.jsp' onsubmit=\"validate2(document.selectform.test1);\">");
						out.println("<input type='hidden' name='close' value='"+close+"'>");
						out.println("<input type='hidden' name='count_line' value='"+count_line+"'>");
						out.println("<input type='hidden' name='access_central' value='"+access_central+"'  >");
							out.println("<input type='hidden' name='product' value='"+product_name+"'  >");
						out.println("<tr class='header1'><td COLSPAN='2'><h3>Section Groups ::</h3></td></tr>");
						out.println("<tr><td COLSPAN='2'>");
							out.println("<table border='1' align='CENTER' width='100%' cellspacing='0' >");
							out.println("<tr class='header1'>");
						    out.println("<td width='4%%'><b>Item #</b></font>");
						    out.println("<td width='5%%'><b>Product</b></font>");
						    if(product_name.equals("LVR")||product_name.equals("BV")||product_name.equals("GRILLE")){
								out.println("<td width='5%%'><b>MARK</b></font>");
						    }
						//    out.println("<td width='5%%'><b>Product</b></font>");
						    out.println("<td width='5%%'><b>Description</b></font>");
						    out.println("<td width='5%%'><b>Price</b></font>");
						    out.println("<td width='5%%'><b>Qty</b></font>");
						    out.println("<td width='5%%'><b>Section</b></font>");
							out.println("<input type='hidden' name='section_group_old' value='"+section_group+"'>");
						    out.println("</tr>");

							String cssClass="roweven";
							if(count_line>0){
										String bgcolor="";double totprice=0;String description="";String product_id="";String section_desc="";String markX="";String qtyx="";
											for(int k=0;k<count_line;k++){
													if ((k%2)==1){bgcolor="#E9F2F7";}else{bgcolor="white";}
													product_id=product.elementAt(k).toString();
						//out.println("HERE1<BR>");
												for (int mn=0;mn<line_item.size();mn++){
													//out.println("HERE2<BR>");
													if ((line_item.elementAt(mn).toString()).equals((items.elementAt(k).toString()))){
														//out.println("HERE3<BR>");
														String totwt=price.elementAt(mn).toString();
														BigDecimal d1 = new BigDecimal(totwt);
														totprice=totprice+d1.doubleValue();// tot price of the line
														//out.println("HERE3.25<BR>");
														if ((block_id.elementAt(mn).toString()).equals("A_APRODUCT")){
															description=(desc.elementAt(mn)).toString();
														}
														//out.println("HERE3.5<BR>");
														if(!product_name.equals("APC")){
															markX=markV.elementAt(mn).toString();
														}
														//out.println("HERE3.6<BR>");
														if(markX==null){
															markX="";
														}
														//out.println("HERE3.75<BR>");
														if(qty.elementAt(mn).toString()!= null && qty.elementAt(mn).toString().trim().length()>0){
															qtyx=qty.elementAt(mn).toString();
														}
														//out.println("HERE4<BR>");
													}
												}
												//out.println("after4<BR>");
											if(k%2==0){
												cssClass="roweven";
											}
											else{
												cssClass="rowodd";
											}
											out.println("<tr class='"+cssClass+"'>");
											out.println("<td width='4%%' ><font color='#000000' face='Arial' size='2'>"+items.elementAt(k)+"</td>");
											out.println("<td align='center' width='8%%'><font color='black' face='verdana' size='-6'>"+product_id+"</font>&nbsp;&nbsp;&nbsp;</td>");
											if(product_name.equals("LVR")||product_name.equals("BV")||product_name.equals("GRILLE")){
												out.println("<td align='center' width='8%%'><font color='black' face='verdana' size='-6'>"+markX+"</font>&nbsp;&nbsp;&nbsp;</td>");
											}
											out.println("<td align='left' width='26%%' align='left'><font color='black' face='verdana' size='-6'>"+description+"</font>&nbsp;&nbsp;&nbsp;</td>");
											out.println("<td align='center' width='4%%'><font color='black' face='verdana' size='-6'>"+for1.format(totprice)+"</font></td>");
											out.println("<td align='center' width='4%%'><font color='black' face='verdana' size='-6'>"+qtyx+"</font></td>");
											out.println("<td align='left' width='4%%' colspan='8'><font color='black' face='verdana' size='-6'>");
											out.println("<select name='"+items.elementAt(k)+"' class='big'>");
											int desc_count=0;String desc_value="";String var="";
														if(section_group==null){
																for(int i=0;i<sections;i++){
																desc_count=i+1;
																var="s"+desc_count+"=";
																		if(section_info!=null){
																					int config_s1= section_info.indexOf(var);
																					if(config_s1>=0){
																						int config_s2=section_info.indexOf(";",config_s1+1);
																						desc_value=section_info.substring(config_s1+var.length(),config_s2);
						//																out.println("<input type='hidden' name='s"+desc_count+"' value='"+desc_value+"' class='button' >");
																						out.println("<option value='s"+desc_count+"'>"+desc_value+"</option>");
																					}
																					else{desc_value="";}
																		}else{desc_value="";}
																}
														}
														else{
														Vector sect=new Vector();Vector sect_value=new Vector();
															for(int i=0;i<sections;i++){
															desc_count=i+1;var="s"+desc_count+"=";
																int config_s1= section_info.indexOf(var);
																if(config_s1>=0){
																	int config_s2=section_info.indexOf(";",config_s1+1);
																	desc_value=section_info.substring(config_s1+var.length(),config_s2);
																	sect.addElement("s"+desc_count);sect_value.addElement(desc_value);
						//											out.println("<option value='s"+desc_count+"'>"+desc_value+"</option>");
																}else{desc_value="";sect.addElement("s"+desc_count);sect_value.addElement(desc_value);}
															}//for sections

															for(int km = 0; km < sect.size(); km++){
																for(int kl=0;kl<count_line;kl++){
																var=items.elementAt(kl).toString()+"=";
																int config_s1= section_group.indexOf(var);
																	if(config_s1>=0){
																		int config_s2=section_group.indexOf(";",config_s1+1);
																		desc_value=section_group.substring(config_s1+var.length(),config_s2);
																		out.println(sect.size()+"::"+var+"::"+items.elementAt(k).toString()+"test"+count_line+"desc"+desc_value+"<br>");
																	}else{desc_value="";}
																if(items.elementAt(kl).toString().equals(items.elementAt(k).toString())){
																String selected = (sect.elementAt(km).toString().equals(desc_value)) ? "selected" : "";
							//									out.println("Test "+desc_value+":"+sect.elementAt(km).toString()+":");
															   out.println(" <option value='"+sect.elementAt(km).toString()+"' "+selected+">"+sect_value.elementAt(km).toString()+"</option>");
															   }
															}
															}

														}
											out.println("</select>");
											out.println("</font></td>");
											out.println("</tr>");
											totprice=0;
											}
							}
							else{
							}
						out.println("</table");
						out.println("</td>");
						out.println("</tr>");//out side table
						out.println("<tr><td COLSPAN='2' align='center'>&nbsp;&nbsp;</td></tr>");
						out.println("<tr><td COLSPAN='1' align='left'>");
						out.println("<input type='hidden' name='sect_count' value='"+sect_count+"' class='button' >");
						out.println("<input type='hidden' name='q_no' value='"+order_no+"' class='button' >");
						out.println("<input type='hidden' name='sections' value='"+sections+"' class='button' >");
						out.println("<input type='button'  class='button'  value='Go Back' OnClick='history.go( -2 );return true;'></td><td align='left'>");
						out.println("<input type='submit' name='enter' value='Continue' class='button' >");
						out.println("</td>");
						out.println("</tr>");
						out.println("</form>");
						out.println("</table");
						}
						else{

						}
						

						
						//rs.close();
						stmt.close();
						myConn.close();


						%>
		</center>
	</div>
	<div class='notes' id='notesDiv2'>
		<div id='topnotes' class='topnotesx'>
			<table width='100%'><tr><td align='right'>
						<input type='button' name='save' value='Save' onclick='saveNotes()' class='button'><input type='button' name='cancel' value='Cancel' onclick='cancelNotes()' class='button'>
					</td></tr></table>
		</div>
		<div id='bottomnotes' class='bottomnotesx'>
			<form name='notesForm'><input type='hidden' name='secNo'>
				<table width='90%'>
					<tr>
						<td valign='top'>Exclusions</td>
						<td  valign='top'><%=excNotes %></td>
					</tr>
					<tr><td colspan='3'>&nbsp;</td></tr>
					<tr>
						<td valign='top'>Qualifying</td>
						<td valign='top'><%=qlfNotes %></td>
					</tr>
					<tr><td colspan='3'>&nbsp;</td></tr>

					<tr>
						<td valign='top'>Section Free Notes</td>
						<td colspan='3'><textarea name='freeTextNotesForm' class='headerTextArea'></textarea></td>
					</tr>

				</table>
			</form>
		</div>
	</div>



</body>
</html>
<%
 }
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>