
<script type="text/javascript">
	function n_window2(theurl){
		// set width and height
		var the_width=450;
		var the_height=400;
		// set window position
		var from_top=180;
		var from_left=200;
		// set other attributes
		var has_toolbar='no';
		var has_location='no';
		var has_directories='no';
		var has_status='yes';
		var has_menubar='no';
		var has_scrollbars='yes';
		var is_resizable='yes';
		// atrributes put together
		var the_atts='width='+the_width+',height='+the_height+',top='+from_top+',screenY='+from_top+',left='+from_left+',screenX='+from_left;
		the_atts+=',toolbar='+has_toolbar+',location='+has_location+',directories='+has_directories+',status='+has_status;
		the_atts+=',menubar='+has_menubar+',scrollbars='+has_scrollbars+',resizable='+is_resizable;
		// open the window
		myWindowx2=window.open(theurl,'myWindowx2',the_atts);
		setTimeout("checkWindow();",1000);
	}
	function n_window(theurl){
		//alert("n windows");
		var the_width=1000;
		var the_height=1000;
		var from_top=60;
		var from_left=60;
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
	function checkWindow(){
		//alert("HERE");
		if(window.myWindowx2){
			if(myWindowx2&&typeof (myWindowx2.closed)!='unknown'&&!myWindowx2.closed){
				setTimeout("checkWindow();",1000);
				//alert("window exists");
			}
			else{
				//alert("window doesnt exists");
				document.location.reload();
			}
		}
		else{
			//alert("window doesnt exists");
			document.location.reload();
		}
	}
	function mysubmit(){
		//alert("HELLO");
		document.selectform.submit();

	}
	function mysubmit1(){
		//alert("HELLO")
		selectform_1.submit();
	}
	function pdf(type){
		//this.type=type;
		//var the_width=1024;
		//var the_height=768;
		//var from_top=0;
		//var from_left=0;
		//var has_toolbar='no';
		//var has_location='no';
		//var has_directories='no';
		//var has_status='yes';
		//var has_menubar='no';
		//var has_scrollbars='yes';
		//var is_resizable='yes';
		//var the_atts='width='+the_width+',height='+the_height+',top='+from_top+',screenY='+from_top+',left='+from_left+',screenX='+from_left;
		//the_atts+=',toolbar='+has_toolbar+',location='+has_location+',directories='+has_directories+',status='+has_status;
		//the_atts+=',menubar='+has_menubar+',scrollbars='+has_scrollbars+',resizable='+is_resizable;
		//alert("1");
		var theurl="pdfInit.jsp";
		var url
		//alert("2");
		if(type=="1"){
			url=document.quoteform.urltq.value;
		}
		else if(type=="3"){
			url=document.quoteform.urlps.value;
		}
		else if(type=="2"){
			url=document.quoteform.urlli.value;
		}
		else if(type=="4"){
			url=document.quoteform.urlpsq.value;
		}
		else if(type=="5"){
			url=document.quoteform.urlliint.value;
		}
		else if(type=="6"){
			url=document.quoteform.urltqint.value;
		}
		else if(type=="7"){
			url=document.quoteform.urlmixtq.value;
			type="1";
		}
		else if(type=="8"){
			url=document.quoteform.urlmixps.value;
			type="3";
		}
		else if(type=="9"){
			url=document.quoteform.urlmixtqint.value;
			type="6";
		}

		//alert("3");
		//alert(url);

		n_window('../documentGenerator.jsp?orderNo='+document.quoteform.order_no.value+'&urlx='+url+'&urlAddx=!type@'+type+'&action=pdf');
		//alert("4");

		//myWindowPdf=window.open(theurl,'myWindowPdf',the_atts);
		//if(window.myWindowPdf){
		//	if (myWindowPdf&& typeof(myWindowPdf.closed)!='unknown'&& !myWindowPdf.closed){
		//		setTimeout("checkWindowPdf("+type+");",1000);
		//	}
		//	else{
		//		setTimeout("checkWindowPdf("+type+");",1000);
		//	}
		//}
		//else{
		//	setTimeout("checkWindowPdf("+type+");",1000);
		//}
	}

	function rtf(type){



		var theurl="pdfInit.jsp";
		var url
		//alert("2");
		if(type=="1"){
			url=document.quoteform.urltq.value;
		}
		else if(type=="3"){
			url=document.quoteform.urlps.value;
		}
		else if(type=="2"){
			url=document.quoteform.urlli.value;
		}
		else if(type=="4"){
			url=document.quoteform.urlpsq.value;
		}
		else if(type=="5"){
			url=document.quoteform.urlliint.value;
		}
		else if(type=="6"){
			url=document.quoteform.urltqint.value;
		}
		else if(type=="7"){
			url=document.quoteform.urlmixtq.value;
			type="1";
		}
		else if(type=="8"){
			url=document.quoteform.urlmixps.value;
			type="3";
		}
		else if(type=="9"){
			url=document.quoteform.urlmixtqint.value;
			type="6";
		}

		//alert("3");

		n_window('../documentGenerator.jsp?orderNo='+document.quoteform.order_no.value+'&urlx='+url+'&urlAddx=!type@'+type+'&action=rtf');




		//this.type=type;
		//var the_width=1024;
		//var the_height=768;
		//var from_top=0;
		//var from_left=0;
		//var has_toolbar='no';
		//var has_location='no';
		//var has_directories='no';
		//var has_status='yes';
		//var has_menubar='no';
		//var has_scrollbars='yes';
		//var is_resizable='yes';
		//var the_atts='width='+the_width+',height='+the_height+',top='+from_top+',screenY='+from_top+',left='+from_left+',screenX='+from_left;
		//the_atts+=',toolbar='+has_toolbar+',location='+has_location+',directories='+has_directories+',status='+has_status;
		//the_atts+=',menubar='+has_menubar+',scrollbars='+has_scrollbars+',resizable='+is_resizable;
		//var theurl="rtfInit.jsp";
		//myWindowRtf=window.open(theurl,'myWindowRtf',the_atts);
		//if(window.myWindowRtf){
		//	if(myWindowRtf&&typeof (myWindowRtf.closed)!='unknown'&&!myWindowRtf.closed){
		//		setTimeout("checkWindowRtf("+type+");",1000);
		//	}
		//	else{
		//		setTimeout("checkWindowRtf("+type+");",1000);
		//	}
		//}
		//else{
		//	setTimeout("checkWindowRtf("+type+");",1000);
		//}
	}
	function html(type){
		this.type=type;
		//alert(type);
		var url="";
		if(type=="1"){
			url=document.quoteform.urltq.value;
		}
		else if(type=="3"){
			url=document.quoteform.urlps.value;
		}
		else if(type=="2"){
			url=document.quoteform.urlli.value;
		}
		else if(type=="4"){
			url=document.quoteform.urlpsq.value;
		}
		else if(type=="5"){
			url=document.quoteform.urlliint.value;
		}
		else if(type=="6"){
			url=document.quoteform.urltqint.value;
		}
		else if(type=="7"){
			url=document.quoteform.urlmixtq.value;
			type="1";
		}
		else if(type=="8"){
			url=document.quoteform.urlmixps.value;
			type="3";
		}
		else if(type=="9"){
			url=document.quoteform.urlmixtqint.value;
			type="6";
		}
		url="../"+url;
		var the_width=1024;
		var the_height=768;
		var from_top=0;
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
		myWindowHtml=window.open(url,'myWindowHtml',the_atts);
	}

	function ims(type){
		//alert("HERE");
		var theurl;
		var theurl="pdfInitIMS.jsp";
		var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=no,directories=no,width=400,height=400';
		myWindow=window.open(theurl,'myWindow',props);
		var url="";
		if(type=="1"){
			url=document.quoteform.urltq.value;
		}
		else if(type=="3"){
			url=document.quoteform.urlps.value;
		}
		else if(type=="2"){
			url=document.quoteform.urlli.value;
		}
		else if(type=="4"){
			url=document.quoteform.urlpsq.value;
		}
		else if(type=="5"){
			url=document.quoteform.urlliint.value;
		}
		else if(type=="6"){
			url=document.quoteform.urltqint.value;
		}
		else if(type=="7"){
			url=document.quoteform.urlmixtq.value;
			type="1";
		}
		else if(type=="8"){
			url=document.quoteform.urlmixps.value;
			type="3";
		}
		else if(type=="9"){
			url=document.quoteform.urlmixtqint.value;
			type="6";
		}
		else{
			url=type;
		}
		document.quoteform.imstype.value=type;
		document.quoteform.imsurl.value=url;
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
				myWindow.form1.order_no.value=document.quoteform.order_no.value;
				myWindow.form1.type.value=document.quoteform.imstype.value;
				myWindow.form1.url3.value=document.quoteform.imsurl.value;
			}
			else{
				setTimeout("checkWindow(type);",1000);
			}
		}
		else{
			setTimeout("checkWindow(type);",1000);
		}
	}
	function checkWindowPdf(type){
		this.type=type
		//alert(type+":::");
		var url="";
		//alert("HERE1");
		if(!type==""){
			//alert("HERE2");
			if(type=="1"){
				url=document.quoteform.urltq.value;
			}
			else if(type=="2"){
				url=document.quoteform.urlps.value;
			}
			else if(type=="3"){
				url=document.quoteform.urlli.value;
			}
			else if(type=="4"){
				url=document.quoteform.urlpsq.value;
			}
			else if(type=="5"){
				url=document.quoteform.urlliint.value;
			}
			else if(type=="6"){
				url=document.quoteform.urltqint.value;
			}
			else if(type=="7"){
				url=document.quoteform.urlmixtq.value;
			}
			else if(type=="8"){
				url=document.quoteform.urlmixps.value;
			}
			else if(type=="9"){
				url=document.quoteform.urlmixtqint.value;
			}
			if(window.myWindowPdf){
				if(myWindowPdf&&typeof (myWindowPdf.closed)!='unknown'&&!myWindowPdf.closed){
					if(type==5||type==6){
						myWindowPdf.form1.intl.value="yes";
					}
					myWindowPdf.form1.url.value=url;
					myWindowPdf.form1.order_no.value=document.quoteform.order_no.value;
				}
				else{
					setTimeout("checkWindowPdf();",1000);
				}
			}
			else{
				setTimeout("checkWindowPdf();",1000);
			}
		}
	}
	function checkWindowRtf(type){
		this.type=type
		//alert(type+":::");
		var url="";
		//alert("HERE1");
		if(!type==""){
			//alert("HERE2");
			if(type=="1"){
				url=document.quoteform.urltq.value;
			}
			else if(type=="2"){
				url=document.quoteform.urlps.value;
			}
			else if(type=="3"){
				url=document.quoteform.urlli.value;
			}
			else if(type=="4"){
				url=document.quoteform.urlpsq.value;
			}
			else if(type=="5"){
				url=document.quoteform.urlliint.value;
			}
			else if(type=="6"){
				url=document.quoteform.urltqint.value;
			}
			else if(type=="7"){
				url=document.quoteform.urlmixtq.value;
			}
			else if(type=="8"){
				url=document.quoteform.urlmixps.value;
			}
			else if(type=="9"){
				url=document.quoteform.urlmixtqint.value;
			}
			//alert(url);
			if(window.myWindowRtf){
				if(myWindowRtf&&typeof (myWindowRtf.closed)!='unknown'&&!myWindowRtf.closed){
					myWindowRtf.form1.isHeader.value=document.quoteform.isHeader.value;
					myWindowRtf.form1.isFooter.value=document.quoteform.isFooter.value;
					myWindowRtf.form1.url.value=url;
					if(type==5||type==6){
						myWindowRtf.form1.intl.value="yes";
					}
					myWindowRtf.form1.order_no.value=document.quoteform.order_no.value;

					//alert("HERE");

				}
				else{
					setTimeout("checkWindowRtf();",1000);
				}
			}
			else{
				setTimeout("checkWindowRtf();",1000);
			}
		}
	}
</script>
<%

String new_page="";
String productx2="";String quote_type_id="";String rep_quote="";String quote_type="";String rep_tear_sheet="";

String UserID2="";
//String project_type="";

%>
<%//@ include file="sections_validation.jsp"%>
<%
String urlps="";
String urlpsq="";
String urlli="";
String urltq="";
String urlliint="";
String urltqint="";
String urlmixtq="";
String urlmixtqint="";
String urlmixps="";
//String group_id="";
if(order_no == null || order_no.equals("null")){sectionsGood=true;order_no="";}

if(sectionsGood){
	if(quote_type_id==null){quote_type_id="";}
	if (!(order_no==null | order_no.trim().length()<=0)){

		ResultSet rsGe=stmt.executeQuery("select product_id,rep_quote from cs_project where order_no='"+order_no+"'");
		if(rsGe != null){
			while(rsGe.next()){
				//out.println(rsGe.getString("product_id")+"::<BR>");
				if(rsGe.getString("product_id").equals("GE")){
					productx2="GE";
				}
				if(productx2.trim().length()<1){
					productx2=	rsGe.getString("product_id");
				}
                                rep_quote=rsGe.getString("rep_quote");
			}
		}
		rsGe.next();
		if(quote_type_id.equals("GE")){productx2="GE";}
		if ((productx2.equals("LVR")|productx2.equals("BV")|productx2.equals("GRILLE")|productx2.equals("DADE_LVR"))) {
			//Checking if the quote exist in project
			int project_count=0;
			ResultSet rs_project_count = stmt.executeQuery("SELECT count(*) FROM cs_project where order_no = '"+order_no+"'");
			if (rs_project_count !=null) {
			while (rs_project_count.next()) {
				project_count = rs_project_count.getInt(1);
				}
			}
			rs_project_count.close();
			// Checking the quote no count it should be always less than 90000 on the production.

}// only for Cranford products this should be run
if ((productx2.equals("LVR"))) {
urltq="quotes/show_sfdc_quotes1.jsp?orderNo="+ order_no +"&type=1";
urltqint="quotes/show_sfdc_quotes1.jsp?orderNo="+ order_no +"&type=5&int=yes";
urlps="quotes/show_sfdc_quotes1.jsp?orderNo="+ order_no +"&type=3";
}
else if ((productx2.equals("FSM"))) {
urltq="quotes/show_sfdc_quotes_fsm.jsp?orderNo="+ order_no +"&type=1";
urltqint="quotes/show_sfdc_quotes_fsm.jsp?orderNo="+ order_no +"&type=5&int=yes";
urlps="quotes/show_sfdc_quotes_fsm.jsp?orderNo="+ order_no +"&type=3";
}
else if(productx2.equals("GRILLE")){
//urlmix="quotes/show_sfdc_cran_quotes.jsp?order_no="+ order_no +"&type=1";
urlmixtq="quotes/show_sfdc_cran_quotes.jsp?orderNo="+ order_no +"&type=1";
urlmixtqint="quotes/show_sfdc_cran_quotes.jsp?orderNo="+ order_no +"&type=5";
urlmixps="quotes/show_sfdc_cran_quotes.jsp?orderNo="+ order_no +"&type=3";
}
else if(productx2.equals("ADS")){
urltq="quotes/show_sfdc_quotes2.jsp?orderNo="+ order_no +"&type=1";
urlps="quotes/show_sfdc_quotes2.jsp?orderNo="+ order_no +"&type=3";
urlli="quotes/show_sfdc_quotes2.jsp?orderNo="+ order_no +"&type=2";
}
else if(productx2.equals("EFS")||productx2.equals("EJC")){
urltq="quotes/show_sfdc_quotes3.jsp?orderNo="+ order_no +"&type=1";
urltqint="quotes/show_sfdc_quotes3.jsp?orderNo="+ order_no +"&type=6&int=yes";
urlps="quotes/show_sfdc_quotes3.jsp?orderNo="+ order_no +"&type=3";
if(productx2.equals("EJC")){
urlpsq="quotes/show_sfdc_quotes3.jsp?orderNo="+ order_no +"&type=4";
}
urlli="quotes/show_sfdc_quotes3.jsp?orderNo="+ order_no +"&type=2";
urlliint="quotes/show_sfdc_quotes3.jsp?orderNo="+ order_no +"&type=5&int=yes";
}
%>
<tr><td colspan='2' align='left'>
		<form name='quoteform'>
			<table border=0 align='center'>
				<%
				out.println("<input type='hidden' name='urltq' value='"+urltq+"'>");
				out.println("<input type='hidden' name='urlps' value='"+urlps+"'>");
				out.println("<input type='hidden' name='urlpsq' value='"+urlpsq+"'>");
				out.println("<input type='hidden' name='urlli' value='"+urlli+"'>");
				out.println("<input type='hidden' name='urlliint' value='"+urlliint+"'>");
				out.println("<input type='hidden' name='urltqint' value='"+urltqint+"'>");
				out.println("<input type='hidden' name='urlmixtq' value='"+urlmixtq+"'>");
				out.println("<input type='hidden' name='urlmixtqint' value='"+urlmixtqint+"'>");
				out.println("<input type='hidden' name='urlmixps' value='"+urlmixps+"'>");
				out.println("<input type='hidden' name='order_no' value='"+order_no+"'>");
				out.println("<input type='hidden' name='imstype' value=''>");
				out.println("<input type='hidden' name='imsurl' value=''>");

				out.println("<input type='hidden' name='isHeader' value='TRUE'>");
				out.println("<input type='hidden' name='isFooter' value=''>");


				if(urltq != null && urltq.trim().length()>0){
					out.println("<tr class='important1' align='center' valign='middle'><td align='left' class='important1' valign='center'><font face='arial'   SIZE='2'><b>Types & Quantities::</td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='PDF' value='PDF' onclick=\"pdf('1')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='WORD' value='WORD' onclick=\"rtf('1')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='HTML' value='HTML' onclick=\"html('1')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='SEND PDF TO IMS' value='SEND PDF TO IMS' onclick=\"ims('1')\"></td>");
					out.println("</tr>");
				}
				if(urlps != null && urlps.trim().length()>0){
					out.println("<tr class='important1' align='center' valign='middle'><td align='left' valign='center' class='important1'><font face='arial'   SIZE='2'><b>Plans & Specs::</td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='PDF' value='PDF' onclick=\"pdf('3')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='WORD' value='WORD' onclick=\"rtf('3')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='HTML' value='HTML' onclick=\"html('3')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='SEND PDF TO IMS' value='SEND PDF TO IMS' onclick=\"ims('2')\"></td>");
					out.println("</tr>");
				}
				if(urlpsq != null && urlpsq.trim().length()>0){
					out.println("<tr class='important1' align='center' valign='middle'><td align='left' valign='center' class='important1'><font face='arial'   SIZE='2'><b>Plans & Specs with Quantities::</td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='PDF' value='PDF' onclick=\"pdf('4')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='WORD' value='WORD' onclick=\"rtf('4')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='HTML' value='HTML' onclick=\"html('4')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='SEND PDF TO IMS' value='SEND PDF TO IMS' onclick=\"ims('4')\"></td>");
					out.println("</tr>");
				}
				if(urlli != null && urlli.trim().length()>0){
					out.println("<tr class='important1' align='center' valign='middle'><td align='left' valign='center' class='important1'><font face='arial'   SIZE='2'><b>Line & Item::</td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='PDF' value='PDF' onclick=\"pdf('2')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='WORD' value='WORD' onclick=\"rtf('2')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='HTML' value='HTML' onclick=\"html('2')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='SEND PDF TO IMS' value='SEND PDF TO IMS' onclick=\"ims('3')\"></td>");
					out.println("</tr>");
				}
				if(urlliint != null && urlliint.trim().length()>0){
					out.println("<tr class='important1' align='center' valign='middle'><td align='left' valign='center' class='important1'><font face='arial'   SIZE='2'><b>Line & Item International::</td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='PDF' value='PDF' onclick=\"pdf('5')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='WORD' value='WORD' onclick=\"rtf('5')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='HTML' value='HTML' onclick=\"html('5')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='SEND PDF TO IMS' value='SEND PDF TO IMS' onclick=\"ims('5')\"></td>");
					out.println("</tr>");
				}
				if(urltqint != null && urltqint.trim().length()>0){
					out.println("<tr class='important1' align='center' valign='middle'><td align='left' valign='center' class='important1'><font face='arial'   SIZE='2'><b>Types & Quantities International::</td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='PDF' value='PDF' onclick=\"pdf('6')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='WORD' value='WORD' onclick=\"rtf('6')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='HTML' value='HTML' onclick=\"html('6')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='SEND PDF TO IMS' value='SEND PDF TO IMS' onclick=\"ims('6')\"></td>");
					out.println("</tr>");
				}
				if(urlmixtq != null && urlmixtq.trim().length()>0){
					out.println("<tr class='important1' align='center' valign='middle'><td align='left' valign='center' class='important1'><font face='arial'   SIZE='2'><b>Types & Quantities::</td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='PDF' value='PDF' onclick=\"pdf('7')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='WORD' value='WORD' onclick=\"rtf('7')\"></td>");
				out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='HTML' value='HTML' onclick=\"html('7')\"></td>");
				out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='SEND PDF TO IMS' value='SEND PDF TO IMS' onclick=\"ims('7')\"></td>");
					out.println("</tr>");
				}

				if(urlmixps != null && urlmixps.trim().length()>0){
					out.println("<tr class='important1' align='center' valign='middle'><td align='left' valign='center' class='important1'><font face='arial'   SIZE='2'><b>Plans & Specs::</td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='PDF' value='PDF' onclick=\"pdf('8')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='WORD' value='WORD' onclick=\"rtf('8')\"></td>");
				out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='HTML' value='HTML' onclick=\"html('8')\"></td>");
				out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='SEND PDF TO IMS' value='SEND PDF TO IMS' onclick=\"ims('7')\"></td>");
					out.println("</tr>");
				}
				if(urlmixtqint != null && urlmixtqint.trim().length()>0){
					out.println("<tr class='important1' align='center' valign='middle'><td align='left' valign='center' class='important1'><font face='arial'   SIZE='2'><b>Types & Quantities International::</td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='PDF' value='PDF' onclick=\"pdf('9')\"></td>");
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='WORD' value='WORD' onclick=\"rtf('9')\"></td>");
				out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='HTML' value='HTML' onclick=\"html('9')\"></td>");
				out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='SEND PDF TO IMS' value='SEND PDF TO IMS' onclick=\"ims('7')\"></td>");
					out.println("</tr>");
				}

				%>
		</form>
		<%

	//}

		%>
<tr class='important1' align="center" valign="middle">
	<td align="left" valign="center" class='important1'><font face='arial'   SIZE='2'><b>Rep Quote::</td>
	<td align="center" valign="top" colspan='3'>
		<%

		String selected="";String selected1="";String selected2="";
		if(rep_quote!=null&&rep_quote.equals("1")){
			selected="selected";
		}
		else if(rep_quote!=null&&rep_quote.equals("2")){
			selected1="selected";
		}
		else if(rep_quote!=null&&rep_quote.equals("4")){
				selected2="selected";
		}
		//out.println(rep_quote);

		%>
		<form name="selectform" action="rep.quote_type.jsp" method="post">
			<select name='q_type' onchange="mysubmit()">
				<option value=''></option>
				<option value='1' <%= selected %> >Types & Quantities</option>

				%>
			</select>
			<input type='hidden' name='q_no' value=<%= order_no %> >
		</form>
	</td>
</tr>
<%

if(rep_quote != null && rep_quote.trim().length()>0){
%>
<tr class='important1' align="center" valign="middle">
	<td align="left" valign="center" class='important1'><font face='arial'   SIZE='2'><b>Email Quote::</td>
	<td align="center" valign="top" colspan='3'>
		<input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='Email Quote' value='Email Quote' onclick="javascript:n_window2('mail.home.jsp?q_no=<%= order_no %>')">
	</td>
</tr>
<%
}

%>
</table>
<%
//out.println(product);
}
}
else{
out.println("<table border='0' align='center' width='100%'>");
out.println("<tr class='important'>");
out.println("<td align='center'>");

%>
<a href="javascript:n_window2('http://<%=application.getInitParameter("HOST")%>/erapid/us/quotes/sections.home.jsp?q_no=<%=q_no%>&cmd=1&close=true')"><FONT SIZE='2'><b>Quote Sections</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	<%
	//out.println("<a href='quotes/sections.home.jsp?q_no="+ q_no+"&cmd=1'>Quote Sections"+"<a>");
	out.println("</td>");
	out.println("</tr>");
	out.println("</table>");
}

	%>
</form>
</td>
</tr>
