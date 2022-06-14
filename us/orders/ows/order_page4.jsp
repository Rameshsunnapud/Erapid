<html>
	<HEAD>
		<title>
			Order Write-up sheet <%=order_no%>
		</title>
		<link rel='stylesheet' href='../../../css/styleMain.css' type='text/css'/>
		<SCRIPT LANGUAGE="JavaScript">
			<!-- Begin
			function resendnew(x,y){
				//alert("x value is : "+x+" y value is : "+y);
				document.selectform.button1.value="9";
				var order=document.selectform.order_no.value;
				var sections2="";
				var sections="";
				var numChecked=0;
				var isGood=true;
				sections2=x;
				sections=y;
				numChecked++;

				if(isGood){
					var fRet;
					var url2;
					if(numChecked>0){
						fRet=confirm('Are you ready to transfer the order ?');
					}
					else{
						alert(" PLEASE SELECT A SECTION");
						fRet=false;
					}
					if(fRet){
						url2=document.selectform.owsurl.value+sections2;
						document.selectform.owsurl.value=url2;
						if(document.selectform.product.value=="GE"||document.selectform.product.value=="ADS"){
							if(sections.length>0){
								var newWindow;
								var url="order_transfer_bpcs_home.jsp?order="+order+"&sections="+sections2+"&rep_no="+document.selectform.rep_no.value+"&userSessionId="+document.selectform.sessionUserId.value+"&userId="+document.selectform.sessionUserId.value;
								var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=700,height=450';
								newWindow=window.open(url,"Add_from_Src_to_Dest",props);
							}
							selectform.submit();
						}
						else{

							var theurl;
							var theurl="pdfInitOWS.jsp";
							var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=50,height=50';
							alert('opening '+theurl);
							myWindow=window.open(theurl,'myWindow',props);
							if(window.myWindow){
								if(myWindow&&typeof (myWindow.closed)!='unknown'&&!myWindow.closed){
									setTimeout("checkWindow();",1000);
								}
								else{
									setTimeout("checkWindow();",1000);
								}
							}
							else{
								setTimeout("checkWindow();",1000);
							}
							if(sections.length>0){
								var newWindow;
								var url="order_transfer_bpcs_home.jsp?order="+order+"&sections="+sections2+"&rep_no="+document.selectform.rep_no.value+"&userSessionId="+document.selectform.sessionUserId.value+"&userId="+document.selectform.sessionUserId.value;
								var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=700,height=450';
								newWindow=window.open(url,"Add_from_Src_to_Dest",props);
							}
						}
					}
				}
			}
			function lineItem(){
				//alert("lineItem");
				//parent.postMessage("test","*");
				window.parent.postMessage("test2","*");
				//alert("after post");
			}
			function closeThis(x){
				//alert("CLOSE THIS"+x);
				window.location=x;
			}
			function MsgOkCancel(order){
				//alert("HERE");
				document.selectform.button1.value="1";
				var order=document.selectform.order_no.value;
				var sections="";
				var sections2="";
				var numChecked=0;
				var isGood=true;
				if(typeof document.selectform.sss=='undefined'){
					alert("Order already transferred, no sections to transfer.");
					isGood=false;
				}
				else{

					if(document.selectform.sss.length>=0){
						//alert("nope");
						for(count=0;count<document.selectform.sss.length;count++){
							//alert(document.selectform.sss[count].value);
							if(document.selectform.sss[count].checked){
								sections=sections+document.selectform.sss[count].value;
								sections2=sections2+document.selectform.sss[count].value+",";
								numChecked++;
							}
						}
					}
					else{
						//alert("here");
						if(document.selectform.sss.checked){
							sections=sections+document.selectform.sss.value;
							sections2=sections2+document.selectform.sss.value+",";
							numChecked++;
						}

					}
				}
				//alert(document.selectform.product.value+":::"+document.selectform.order_no.value);

				if(isGood){
					//alert(sections);

					var fRet;
					var url2;
					if(numChecked>0){
						fRet=confirm('Are you ready to transfer the order ?');
					}
					else{
						alert(" PLEASE SELECT A SECTION");
						fRet=false;
					}
					//alert(fRet);
					if(fRet){

						//goPDF4();
						//goPDF5();
						//goPDF();
						url2=document.selectform.owsurl.value+sections2;
						document.selectform.owsurl.value=url2;
						if(document.selectform.product.value=="ADS"){
							myWindowADS=window.open('adsnewtransfer.jsp?order_no='+document.selectform.order_no.value,'myWindowADS',props);
							//alert("HERE");
						}
						if(document.selectform.product.value=="GE"){
							//alert("GE");
							if(sections.length>0){
								var newWindow;
								var url="order_transfer_bpcs_home.jsp?order="+order+"&sections="+sections2+"&rep_no="+document.selectform.rep_no.value+"&userSessionId="+document.selectform.sessionUserId.value+"&userId="+document.selectform.sessionUserId.value;
								;
								var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=700,height=450';
								newWindow=window.open(url,"Add_from_Src_to_Dest",props);
							}
							selectform.submit();
						}
						else{
							//alert("other");
							var theurl;
							//alert(document.selectform.owsurl.value);
							var theurl="pdfInitOWS.jsp";
							var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=50,height=50';
							myWindow=window.open(theurl,'myWindow',props);
							if(window.myWindow){
								if(myWindow&&typeof (myWindow.closed)!='unknown'&&!myWindow.closed){
									setTimeout("checkWindow();",1000);
								}
								else{
									setTimeout("checkWindow();",1000);
								}
							}
							else{
								setTimeout("checkWindow();",1000);
							}
							if(sections.length>0){
								var newWindow;
								var url="order_transfer_bpcs_home.jsp?order="+order+"&sections="+sections2+"&rep_no="+document.selectform.rep_no.value+"&userSessionId="+document.selectform.sessionUserId.value+"&userId="+document.selectform.sessionUserId.value;
								;
								var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=700,height=450';
								newWindow=window.open(url,"Add_from_Src_to_Dest",props);
							}
						}
					}
				}
			}

			function checkWindow(){
				//alert("HERE");
				if(window.myWindow){
					if(myWindow&&typeof (myWindow.closed)!='unknown'&&!myWindow.closed){
						//alert("HERE"+document.selectform.owsurl.value);
						myWindow.form1.url3.value=document.selectform.owsurl.value;
						myWindow.form1.order_no.value=document.selectform.order_nox.value;
						selectform.submit();
					}
					else{
						//alert("nope");
						setTimeout("checkWindow();",1000);
					}
				}
				else{
					//alert("nope2");
					setTimeout("checkWindow();",1000);
				}
			}

			function checkWindow2(){
				if(window.myWindowx3){
					if(myWindowx3&&typeof (myWindowx3.closed)!='unknown'&&!myWindowx3.closed){
						//alert("open???");
						setTimeout("checkWindow2();",1000);
					}
					else{
						//alert("open2???");
						//setTimeout("checkWindow2();",1000);
						document.location.reload();

					}

				}
				else{
					//alert("closed");
					//setTimeout("checkWindow2();",1000);
					document.location.reload();

				}
			}
			function n_window(theurl){
				// set width and height
				var the_width=600;
				var the_height=600;
				// set window position
				var from_top=180;
				var from_left=460;
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
				myWindowx3=window.open(theurl,'myWindowx3',the_atts);
				setTimeout("checkWindow2();",1000);

			}

			function MsgOkCancel2(order){
				document.selectform.button1.value="2";
				var order=document.selectform.order_no.value;
				var sections="";
				var sections2="";
				var numChecked=0;
				var isGood=true;
				if(typeof document.selectform.sss=='undefined'){
					alert("Order already transferred, no sections to transfer.");
					isGood=false;
				}
				else{

					if(document.selectform.sss.length>=0){
						//alert("nope");
						for(count=0;count<document.selectform.sss.length;count++){
							//alert(document.selectform.sss[count].value);
							if(document.selectform.sss[count].checked){
								sections=sections+document.selectform.sss[count].value;
								sections2=sections2+document.selectform.sss[count].value+",";
								numChecked++;
							}
						}
					}
					else{
						//alert("here");
						if(document.selectform.sss.checked){
							sections=sections+document.selectform.sss.value;
							sections2=sections2+document.selectform.sss.value+",";
							numChecked++;
						}

					}
				}


				if(isGood){
					//alert(sections);
					var fRet;
					if(numChecked>0){
						fRet=confirm('Are you ready to transfer the order ?');
					}
					else{
						alert(" PLEASE SELECT A SECTION");
						fRet=false;
					}
					//alert(fRet);
					if(fRet){
						selectform.submit();
						//			window.opener="order_page4_save.jsp";

					}
				}
			}


			function explain(name,output,msg){
				newwin=window.open('','','top=150,left=150,width=400%,height=400%');
				if(!newwin.opener)
					newwin.opener=self;
				with(newwin.document)
				{
					open();
					write('<html>');
					write('<head>');
					write('<link rel="stylesheet" href="style1.css" type="text/css"/>');
					write('</head>');
					write('<body onLoad="document.form.box.focus()"><form name=form><h3>'+msg+'</h3><br>');
					write('<p>Enter '+name+' here and it will be copied to the Quote for you.');
					write('<p><center>'+name+':  <textarea name=box cols=30 rows=6 onKeyUp='+output+'=this.value>'+window.document.selectform.special_notes.value+'</textarea>');
					write('<p><input type=button value="Done" class="button" onClick=window.close()>');
					write('</center></form></body></html>');
					close();
				}
			}
			//  End -->
			<!-- begin
				   function selectAll(field){

					   if(field.length>0){
						   for(i=0;i<field.length;i++)
							   field[i].checked=true;

					   }
					   else{

						   field.checked=true;
					   }
				   }


			// end -->

			<!-- Begin
				   function explain1(name,output,msg){
					   newwin=window.open('','','top=150,left=150,width=400%,height=400%');
					   if(!newwin.opener)
						   newwin.opener=self;
					   with(newwin.document)
					   {
						   open();
						   write('<html>');
						   write('<head>');
						   write('<link rel="stylesheet" href="style1.css" type="text/css"/>');
						   write('</head>');
						   write('<body onLoad="document.form.box.focus()"><form name=form><h3>'+msg+'</h3><br>');
						   write('<p>Enter '+name+' here and it will be copied to the Quote for you.');
						   write('<p><center>'+name+':  <textarea name=box cols=30 rows=6 onKeyUp='+output+'=this.value>'+window.document.selectform.order_notes.value+'</textarea>');
						   write('<p><input type=button value="Done" class="button" onClick=window.close()>');
						   write('</center></form></body></html>');
						   close();
					   }
				   }
			//  End -->
			function showPopup2(myurl){
				var newWindow;
				var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=yes,location=no,directories=no,width=450,height=350';
				newWindow=window.open(myurl,"Add_from_Src_to_Dest",props);
			}
			function showPopup3(myurl){

				var newWindow;
				var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=yes,location=no,directories=no,width=450,height=350';
				newWindow=window.open(myurl,"Add_from_Src_to_Dest",props);
				alert("a) Please enter this order on the ADS order logs before closing this box \n b) Did you verify commission and Trade/facility sales match up on your order sheet? \n c) Is color on all Erapid lines if you know it? Did you hit resend all if this was just added?");
			}
			function checkWindow4(){
				if(window.myWindowx4){
					if(myWindowx4&&typeof (myWindowx4.closed)!='unknown'&&!myWindowx4.closed){
						myWindowx4.form1.url.value=document.selectform.owslink.value;
						myWindowx4.form1.order_no.value=document.selectform.order_no.value;
					}
					else{
						setTimeout("checkWindow4();",1000);
					}
				}
				else{
					setTimeout("checkWindow4();",1000);
				}
				selectform.submit();
			}
			function goPDF(){
				//alert(document.selectform.owslink.value);
				//alert(document.selectform.order_no.value);
				var theurl="pdfInit.jsp";
				if(document.selectform.product.value=="IWP"||document.selectform.product.value=="EFS"||document.selectform.product.value=="EJC"){
					var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=50,height=50';
					myWindowx4=window.open(theurl,'myWindowx4',props);
					if(window.myWindowx4){
						if(myWindowx4&&typeof (myWindowx4.closed)!='unknown'&&!myWindowx4.closed){
							setTimeout("checkWindow4();",1000);
						}
						else{
							setTimeout("checkWindow4();",1000);
						}
					}
					else{
						setTimeout("checkWindow4();",1000);
					}
				}
				else{
					selectform.submit();
				}
			}


			function goPDF3(){
				//alert(document.selectform.owslink.value);
				//alert(document.selectform.order_no.value);
				var theurl="pdfInit.jsp";
				if(document.selectform.product.value=="IWP"||document.selectform.product.value=="EFS"||document.selectform.product.value=="EJC"){
					var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=50,height=50';
					myWindowx5x=window.open(theurl,'myWindowx5x',props);
					if(window.myWindowx5x){
						if(myWindowx5x&&typeof (myWindowx5x.closed)!='unknown'&&!myWindowx5x.closed){
							setTimeout("checkWindow5x();",1000);
						}
						else{
							setTimeout("checkWindow5x();",1000);
						}
					}
					else{
						setTimeout("checkWindow5x();",1000);
					}
				}

			}


			function checkWindow5x(){
				if(window.myWindowx5x){
					if(myWindowx5x&&typeof (myWindowx5x.closed)!='unknown'&&!myWindowx5x.closed){
						myWindowx5x.form1.url.value=document.selectform.owslink.value;
						myWindowx5x.form1.order_no.value=document.selectform.order_no.value;
					}
					else{
						setTimeout("checkWindow5x();",1000);
					}
				}
				else{
					setTimeout("checkWindow5x();",1000);
				}
			}


			function pdf2(){

				var theurl="pdfInit2.jsp";
				var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=50,height=50';
				myWindowx4x=window.open(theurl,'myWindowx4x',props);
				if(window.myWindowx4x){
					if(myWindowx4x&&typeof (myWindowx4x.closed)!='unknown'&&!myWindowx4x.closed){
						setTimeout("checkWindow4x();",1000);
					}
					else{
						setTimeout("checkWindow4x();",1000);
					}
				}
				else{
					setTimeout("checkWindow4x();",1000);
				}
			}




			function resend(x){
				//alert(x);
				document.selectform.isResend.value=x;
				document.selectform.button1.value="9";
				var order=document.selectform.order_no.value;
				var sections="";
				var sections2="";
				var numChecked=0;
				var isGood=true;
				//if(typeof document.selectform.sss == 'undefined'){
				sections=x;
				sections2=x+",";
				numChecked++;
				//}
				if(isGood){
					//alert(sections);
					var fRet;
					if(numChecked>0){
						fRet=confirm('Are you sure you wish to transfer this section again ?');
					}
					if(fRet){
						goPDF();
						if(sections.length>0){
							var newWindow;
							var url="order_transfer_bpcs_home.jsp?order="+order+"&sections="+sections2+"&rep_no="+document.selectform.rep_no.value+"&userSessionId="+document.selectform.sessionUserId.value+"&userId="+document.selectform.sessionUserId.value;
							;
							var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=700,height=450';
							newWindow=window.open(url,"Add_from_Src_to_Dest",props);
						}
					}
				}
			}

			function goPDF4(){
				var theurl;
				var theurl="pdfInit3.jsp";
				//alert(theurl);
				if((document.selectform.product.value=="IWP"||document.selectform.product.value=="EFS"||document.selectform.product.value=="EJC")&&(document.selectform.workcopylink.value!="")){
					//alert("PSA WORK COPY");
					var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=50,height=50';
					myWindowx6x=window.open(theurl,'myWindowx6x',props);
					if(window.myWindowx6x){
						//alert("1");
						if(myWindowx6x&&typeof (myWindowx6x.closed)!='unknown'&&!myWindowx6x.closed){
							setTimeout("checkWindow6x();",1000);
						}
						else{
							setTimeout("checkWindow6x();",1000);
						}
					}
					else{
						//alert("2");
						setTimeout("checkWindow6x();",1000);
					}
				}

			}


			function checkWindow6x(){
				//alert("HERE");
				if(window.myWindowx6x){
					if(myWindowx6x&&typeof (myWindowx6x.closed)!='unknown'&&!myWindowx6x.closed){
						myWindowx6x.form1.url.value=document.selectform.workcopylink.value;
						myWindowx6x.form1.order_no.value=document.selectform.order_no.value;
					}
					else{
						setTimeout("checkWindow6x();",1000);
					}
				}
				else{
					setTimeout("checkWindow6x();",1000);
				}
			}
			function goPDF5(){
				//alert("psa work copy");
				var theurl;
				var theurl="pdfInit4.jsp";
				//alert(theurl);
				if(document.selectform.product.value=="IWP"||document.selectform.product.value=="EFS"||document.selectform.product.value=="EJC"){
					//alert("REP WORK COPY");
					var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=50,height=50';
					myWindowx7x=window.open(theurl,'myWindowx7x',props);
					if(window.myWindowx7x){
						//alert("1");
						if(myWindowx7x&&typeof (myWindowx7x.closed)!='unknown'&&!myWindowx7x.closed){
							setTimeout("checkWindow7x();",1000);
						}
						else{
							setTimeout("checkWindow7x();",1000);
						}
					}
					else{
						//alert("2");
						setTimeout("checkWindow7x();",1000);
					}
				}

			}


			function checkWindow7x(){
				//alert("HERE");
				if(window.myWindowx7x){
					if(myWindowx7x&&typeof (myWindowx7x.closed)!='unknown'&&!myWindowx7x.closed){
						myWindowx7x.form1.url.value=document.selectform.repworkcopylink.value;
						myWindowx7x.form1.order_no.value=document.selectform.order_no.value;
					}
					else{
						setTimeout("checkWindow7x();",1000);
					}
				}
				else{
					setTimeout("checkWindow7x();",1000);
				}
			}



		</script>
	</HEAD>
	<BODY bgcolor="whitesmoke">
		<%
		String message="<font color='blue'>"+"Order Write-up sheet::"+order_no+"</font>";
		HttpSession UserSession1 = request.getSession();
		String name="";
		if(UserSession1.getAttribute("username")==null){
		name="";
		}
		else{
			name=UserSession1.getAttribute("username").toString();
		}
		%>
		<%//@ include file="../../../rqs_head.jsp"%>
		<%@ include file="sections_validation.jsp"%>
		<%

		if(sectionsGood){
		%>
		<table width='100%'>
			<tr class='header1'><td>
					<h3>Order Write-up Sheet  <%=order_no%></h3></td></tr></table>
		<form name="selectform" action="order_page4_save.jsp" >
			<input type='hidden' name="order_no" value='<%= order_no %>'>
			<input type='hidden' name="rep_no" value='<%= rep_no %>'>
			<input type='hidden' name='sessionUserId' value='<%=usession_user_id%>'>
			<input type='hidden' name='isResend' value=''>
			<input type='hidden' name='product_id' value='<%=product%>'>
			<table border='0' width='100%'>
				<tr class='header1'><td COLSPAN='2'><h3>SECTION DETAILS::</h3></td></tr>
				<!--Greg's code starts here-->
				<input type=hidden name=numSections value=<%= numSections%>>
				<input type=hidden name=submitted value=<%= section_transfer%>>
				<%
				boolean done=false;
				String timeSubmitted="";
				if(counter == 0){
					out.println("<TR><TD COLSPAN='3'>NO SECTIONS INFO FOR THIS QUOTE</td></tr>");
					webLinks="<td COLSPAN='3' align='left'><a href='somePage.jsp?cmd=1&order_no="+ order_no +"&sections=ALL'>View ALL</a></td></tr>";
				}
				else{
					//String alreadysent="";
					for(int count=0; count<numSections; count++){
						for(int b=0; b<sectionTransfer.size(); b++){
							if(section.elementAt(count).toString().equals(sectionTransfer.elementAt(b).toString())){
								done=true;
								timeSubmitted=sectionTransferName.elementAt(b).toString();
							}
						}
						if(done&&!group_id.toUpperCase().startsWith("REP")){
							//alreadysent=alreadysent+"<tr><td><INPUT TYPE='CHECKBOX' NAME='sss' value='"+ section.elementAt(count).toString() +"' >"+timeSubmitted +"</td>";
							done=false;

							//alreadysent=alreadysent+"<td>"+ section.elementAt(count).toString() +"</td><td>"+ sectionName.elementAt(count).toString()+"</td></tr>";

						}
						else if(done){
				%>
				<tr><td><%= timeSubmitted %> </td>
					<%
					done=false;
					%>
					<td><%= section.elementAt(count).toString() %></td><td><%= sectionName.elementAt(count).toString()%></td></tr>
					<%
				}
				else{
					if(isGood){
						String check="";
						selected=selected+section.elementAt(count).toString()+",";
						for(int y=0; y<checkedSec.size(); y++){
							if(section.elementAt(count).toString().equals(checkedSec.elementAt(y).toString())){
								check="checked";
							}
						}
					%>
				<tr><td><INPUT TYPE="CHECKBOX" NAME="sss" value="<%= section.elementAt(count).toString() %>" <%= check %>></td>
						<%
						check="";
						%>
					<td><%= section.elementAt(count).toString() %></td><td><%= sectionName.elementAt(count).toString()%></td></tr>
					<%
				}
				else{
					out.println("<tr><td colspan='3'><Font color='red'>BPCS ORDER IS CLOSED.  Your can not add to this order.  You must change the order type on page1 of the ows and try again.</font></td></tr>");

				}
			}

		}
//out.println("<tr><td colspan='3'>Already Sent</td></tr>"+alreadysent);
if(!group_id.toUpperCase().startsWith("REP")){
	if(resendlinks.trim().length()>0&&isGood){
		out.println("<tr><td colspan='3'>Already Sent (below)</td></tr>"+resendlinks);

		if(product.equals("ADS")){
					%>
				<tr><td colspan='3'><input type='button' name='adstransfer' value='SEND ADS ORDER SHEET TO IMS' onclick="javascript:showPopup3('https://<%= application.getInitParameter("HOST")%>/erapid/us/orders/ows/ads_order_send.jsp?order_no=<%= order_no %>')"></td></tr>
						<%
					}



				}
				else if(resendlinks.trim().length()>0){
					out.println("<tr><td colspan='3'><Font color='red'>BPCS ORDER IS CLOSED.  Your can not add to this order.  You must change the order type on page1 of the ows and try again.</font></td></tr>");
				}
			}

		}
		String urlLink="order_sheet.jsp?orderNo="+order_no+"&rep_no="+ rep_no +"&userId="+usession_user_id+"&product="+ product+"&totmat_price="+totmat_price;

		if(counter >0){
						%>
				<tr><td><INPUT TYPE=BUTTON class='button' OnClick="selectAll(document.selectform.sss);" VALUE="Select All"></td><tr>
						<%
	} %>
							<%= webLinks %><!--<TR><td COLSPAN='3' align='left'><input type='button' name='resend ows' value='Resend Order Write-up' onclick='goPDF3()' CLASS='BUTTON'></td></tr>-->
				<tr><Td colspan=3><hr></td></tr>
			</table>

			<table border='0' align='right'>
				<tr>
					<td COLSPAN='3' align='right'><a href="order_transfer.jsp?cmd=1&order_no=<%= order_no %>&id=<%= rep_no %>">View Page 1</a></td>
					<td COLSPAN='3' align='right'>| <a href="order_transfer.jsp?cmd=2&order_no=<%= order_no %>&id=<%= rep_no %>">View  Page 2</a></td>
					<td COLSPAN='3' align='right'>| <a href="order_transfer.jsp?cmd=3&order_no=<%= order_no %>&id=<%= rep_no %>">View Page 3</a></td>
					<td COLSPAN='3' align='right'>| Page 4</td>
					<td COLSPAN='3' align='right'>| <a href="javascript:showPopup2('https://<%= application.getInitParameter("HOST")%>/erapid/us/orders/ows/email_order_sheet.jsp?sections=all&order_no=<%= order_no %>&rep_no=<%= rep_no %>&userId=<%=usession_user_id%>&product=<%= product%>&Job_loc=<%=Job_loc%>&project_state=<%=project_state%>&line=<%= line%>&handling_cost=<%=handling_cost%>&setup_cost=<%=setup_cost%>&freight_cost=<%=freight_cost%>&overage=<%=overage%>&totmat_price=<%=totmat_price%>&commission=<%=commission%>')">Email Order Sheet</a></td>
					<td COLSPAN='3' align='right'>| <a href="javascript:showPopup2('https://<%= application.getInitParameter("HOST")%>/erapid/us/orders/ows/order_sheet.jsp?sections=all&orderNo=<%= order_no %>&rep_no=<%= rep_no %>&userId=<%=usession_user_id%>&product=<%= product%>&Job_loc=<%=Job_loc%>&project_state=<%=project_state%>&line=<%= line%>&handling_cost=<%=handling_cost%>&setup_cost=<%=setup_cost%>&freight_cost=<%=freight_cost%>&overage=<%=overage%>&totmat_price=<%=totmat_price%>&commission=<%=commission%>')">Order Sheet</a></td>
					<td COLSPAN='3' align='right'>| <a href="javascript:showPopup2('https://<%= application.getInitParameter("HOST")%>/erapid/us/orders/ows/credit_card_form.jsp?order_no=<%= order_no %>')">Credit Card Form</a></td>

				</tr>
			</table>
			<br><br>
			<%
			if(project_type != null && project_type.equals("PSA")){
			%>
			<input type='hidden' name='workcopylink' value='https://<%=application.getInitParameter("HOST")%>/erapid/us/reports/work_copy_home_psa.jsp?q_no=<%=order_no%>'>
			<%
		}
		else{
			%>
			<input type='hidden' name='workcopylink' value=''>
			<%
		}
			%>
			<input type='hidden' name='repworkcopylink' value='https://<%=application.getInitParameter("HOST")%>/erapid/us/reports/work_copy_home.jsp?q_no=<%=order_no%>'>
			<input type='hidden' name='owslink' value='https://<%= application.getInitParameter("HOST")%>/erapid/us/orders/ows/order_sheet.jsp?sections=all&orderNo=<%= order_no %>&rep_no=<%= rep_no %>&userId=<%=usession_user_id%>&product=<%= product%>&Job_loc=<%=Job_loc%>&project_state=<%=project_state%>&line=<%= line%>&handling_cost=<%=handling_cost%>&setup_cost=<%=setup_cost%>&freight_cost=<%=freight_cost%>&overage=<%=overage%>&totmat_price=<%=totmat_price%>&commission=<%=commission%>'>
			<input type='hidden' name='owsurl' value='https://<%= application.getInitParameter("HOST")%>/erapid/us/orders/ows/order_sheet.jsp?orderNo=<%= order_no %>&rep_no=<%= rep_no %>&userId=<%=usession_user_id%>&product=<%= product%>&Job_loc=<%=Job_loc%>&project_state=<%=project_state%>&line=<%= line%>&handling_cost=<%=handling_cost%>&setup_cost=<%=setup_cost%>&freight_cost=<%=freight_cost%>&overage=<%=overage%>&totmat_price=<%=totmat_price%>&commission=<%=commission%>&sections='>
			<input type='hidden' name='urlLink' value='<%= urlLink %>'>
			<input type='hidden' name="button1" value="">
			<input type='hidden' name="order_nox" value="<%=order_no%>">
			<input type='hidden' name='product' value='<%=product%>'>
			<input type=button value="Save" onClick="MsgOkCancel2()" class='button'>
			<input type=button value="Save & Transfer to BPCS" onClick="MsgOkCancel()" class='button'>


			<%
	String repPortalUsersList="'128', '331', '347', '329', '112', '381', '180', '133', '289', '1832', '1750', '150', '111', '85', '108', '102','104','275','9093'";
if((fpx.equals("rp") || project_type.equals("SFDC") || project_type.equals("RP")) && (repPortalUsersList.contains("'"+assigned_rep_no+"'") || repPortalUsersList.contains("'"+project_rep_no+"'"))){
	
	// sfdc_QuoteId
	
	String urlTemp="https://na1.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"0";

	if(application.getInitParameter("HOST").toUpperCase().indexOf("DEV")>0){
		urlTemp="https://maya-cscrm.cs67.force.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"0";
	}

			%>

			<input type='button' class='button' name='CLOSE' value='Return to Portal'   onclick='closeThis("<%=urlTemp%>")'>
			<%
			}
			else{
			%>

			<input type='button' class='button' name='LineItem' value='Line Item'   onclick='lineItem()'>
			<%
			}
			%>
			<!--<input type=button value="gregs test" onClick="goPDF4()" class='text'>-->
		</form>
	</center>
	<%
	}
	else{
	out.println("<table border='0' align='center' width='100%'>");
	out.println("<tr class='important'>");
	out.println("<td align='center'>");
	out.println("<a href=\"javascript:n_window('https://"+ application.getInitParameter("HOST")+"/erapid/us/legacy/sections.home.jsp?q_no="+ order_no+"&cmd=1&close=true')\">Quote Sections"+"<a>");
	out.println("</td>");
	out.println("</tr>");
	out.println("</table>");
	}
if(project_type.equals("SFDC")){

// sfdc_QuoteId

	if(application.getInitParameter("HOST").toUpperCase().indexOf("DEV")>0){
		out.println("<a href='https://c.cs3.visual.force.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../../../images/sfdc_image1.jpg'></a>");
	}
	else{
		out.println("<a href='https://na1.salesforce.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../../../images/sfdc_image1.jpg'></a>");
	}
	}
	//else if(project_type.equals("RP")){
	//	out.println("<a href='https://maya-cscrm.cs67.force.com/apex/CSQuoteLineProcessing?sfQuoteId="+sfdc_QuoteId+"1' target='_top' ><img border='0' src='../../../images/sfdc_image1.jpg'></a>");

	//}
	%>
	<%
	if(product.equals("ADS")){
String urlAds="https://"+ application.getInitParameter("HOST")+"/erapid/us/reports/work_copy_home_ads.jsp?q_no="+order_no+"&pid=3&tp=1&close=yes";
//out.println(urlAds);

}
	%>
	<br><br><br><br><br>
	<%//@ include file="../../../rqs_footer.jsp"%>
</body>
</html>
