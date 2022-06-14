<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>PSA Quote Home</title>
		<link rel='stylesheet' href='style1.css' type='text/css'/>
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
				var the_height=600;
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
				}
				else if(type=="8"){
					url=document.quoteform.urlmixps.value;
				}
				else if(type=="9"){
					url=document.quoteform.urlmixtqint.value;
				}

				//alert("3");
				//alert(url+"::"+type);
				var urlAdd=document.quoteform.urlAdd.value;
				urlAdd=urlAdd.replace(/&/g,"!");
				urlAdd=urlAdd.replace(/=/g,"@");
				//alert(urlAdd);
				n_window('../../documentGenerator.jsp?orderNo='+document.quoteform.order_no.value+'&urlx='+url+'&urlAddx=!type@'+type+urlAdd+'&action=pdf');
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
				}
				else if(type=="8"){
					url=document.quoteform.urlmixps.value;
				}
				else if(type=="9"){
					url=document.quoteform.urlmixtqint.value;
				}

				//alert("3");
				var urlAdd=document.quoteform.urlAdd.value;
				urlAdd=urlAdd.replace(/&/g,"!");
				urlAdd=urlAdd.replace(/=/g,"@");
				n_window('../../documentGenerator.jsp?orderNo='+document.quoteform.order_no.value+'&urlx='+url+'&urlAddx=!type@'+type+urlAdd+'&action=rtf');
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
				url="../../"+url;
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
				else{
					url=type;
				}


				//url="../../"+url;
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
	</head>
	<body>
		<h1>Erapid/PSA Quote Home::</h1>
		<%
		String QuoteID = request.getParameter("QuoteID");//Login id
		String AcctID = request.getParameter("AcctID");//totals
		String UserID= request.getParameter("UserID");//totals
		String order_no="";
		String new_page="";int sections=0;
		String product="";String quote_type_id="";String rep_quote="";String quote_type="";String rep_tear_sheet="";
		%>
		<%@ page language="java" import="java.sql.*" import="java.util.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con_psa.jsp"%>
		<%@ include file="../../../db_con.jsp"%>
		<%@ include file="../../../dbcon1.jsp"%>

		<%
		String UserID2="";
		String project_type="";
		ResultSet rs_psa_quotation = stmt_psa.executeQuery("SELECT * FROM dba.quotation where quote_id like '"+QuoteID+"'");
		if (rs_psa_quotation !=null) {
			while (rs_psa_quotation.next()) {
				order_no= rs_psa_quotation.getString("elogia_no");
				quote_type_id= rs_psa_quotation.getString("quote_type_id");
				quote_type= rs_psa_quotation.getString("quote_type");
			}
		}
		rs_psa_quotation.close();
		//out.println(order_no+"::<BR>");
		String orderNo=order_no;
		%><font color='red' size='4'>**** NOTE MISSING SECTION VALIDATION*****</font>
			<%//@ include file="sections_validation.jsp"%>
			<%
			// for sections **************
			boolean sectionsGood=true;
			String urlps="";
			String urlpsq="";
			String urlli="";
			String urltq="";
			String urlliint="";
			String urltqint="";
			String rep_no="";
			String group_id="";
			if(order_no == null || order_no.equals("null")){sectionsGood=true;order_no="";}
			if(sectionsGood){
			if(quote_type_id==null){quote_type_id="";}
			if (!(order_no==null | order_no.trim().length()<=0)){
				ResultSet rs = stmt.executeQuery("SELECT section_page,sections FROM cs_quote_sections where order_no = '"+order_no+"'");
				if (rs !=null) {
					while (rs.next()) {
						new_page= rs.getString("section_page");
						sections= rs.getInt("sections");
					}
				}
				rs.close();
				ResultSet rs_p = stmt.executeQuery("SELECT rep_quote,project_type,creator_id,rep_tear_sheet FROM cs_project where order_no = '"+order_no+"'");
				if (rs_p !=null) {
					while (rs_p.next()) {
						rep_quote= rs_p.getString("rep_quote");
						project_type=rs_p.getString("project_type");
						UserID2=rs_p.getString("creator_id");
						rep_tear_sheet= rs_p.getString("rep_tear_sheet");
					}
				}
				rs_p.close();

				ResultSet rs1 = stmt.executeQuery("SELECT * FROM cs_reps where rep_no like '"+UserID2+"'");
				while ( rs1.next() ) {
					rep_no=rs1.getString("rep_no");
					group_id=rs1.getString("group_id");
				}
				rs1.close();
				if(!(quote_type==null)){
					if(quote_type.trim().length()>0){
						ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT * FROM dba.user_lookup where lookup_id like '"+quote_type.trim()+"'");
						if (rs_psa_lookup !=null) {
							while (rs_psa_lookup.next()) {
								quote_type= rs_psa_lookup.getString(3);
							}
						}
						rs_psa_lookup.close();
					}
				}
				else{
					quote_type="";
				}
				//out.println(quote_type+"::HERE");
				int prod_count=0;
				ResultSet rs_product = stmt.executeQuery("SELECT product_id FROM csquotes where order_no = '"+order_no+"'");
				if (rs_product !=null) {
					while (rs_product.next()) {
						product = rs_product.getString("product_id");
						if(product.equals("GE")){prod_count++;}
					}
				}
				//out.println(product+"::<BR>");
				rs_product.close();
				ResultSet rsGe=stmt.executeQuery("select product_id from cs_project where order_no='"+order_no+"'");
				if(rsGe != null){
					while(rsGe.next()){
						//out.println(rsGe.getString("product_id")+"::<BR>");
						if(rsGe.getString("product_id").equals("GE")){
							product="GE";
						}
						if(product.trim().length()<1){
							product=	rsGe.getString("product_id");
						}
					}
				}
				rsGe.next();
				if(prod_count>0||quote_type_id.equals("GE")){product="GE";}
				//out.println("pr:::"+product+"::"+order_no);
				if ((product.equals("LVR")|product.equals("BV")|product.equals("GRILLE")|product.equals("DADE_LVR"))) {
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
String urlAdd="&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id ;
		if ((product.equals("LVR")|product.equals("BV")|product.equals("DADE_LVR")|product.equals("EXP")|product.equals("APC"))) {
			if(group_id.toUpperCase().startsWith("CAN")){
				urltq="quotes/show_psa_quotes_cdn.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=1";
			}
			else{
				urltq="quotes/show_psa_quotes1.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=1";
				urltqint="quotes/show_psa_quotes1.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=5&int=yes";
			}
		}
		else if(product.equals("GRILLE")){
			urltq="quotes/show_psa_quotes_grille.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=1";
			urltqint="quotes/show_psa_quotes_grille.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=5&int=yes";
		}
		else if((product.equals("GE"))||product.equals("GCP")){
			urltq="quotes/show_psa_quotes3.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=1";
		}
		else if((product.equals("ADS"))){
			urltq="quotes/show_psa_quotes4.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=1&int=yes";
		}
		else{
			if(group_id.toUpperCase().startsWith("CAN")){
				urltq="quotes/show_psa_quotes_cdn.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=1";
			}
			else{
				if(product.equals("EFS")){
					urltq="quotes/show_psa_quotes_efs.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=1";


				}
else if(product.equals("EJC")){

					urltq="quotes/show_psa_quotes5.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=1";



}
				else{
					urltq="quotes/show_psa_quotes.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=1";
				}
			}
		}
			%>

		<%
		if (!( product.equals("GE")|group_id.startsWith("Decolink") )){
			if ((product.equals("LVR")|product.equals("BV")|product.equals("DADE_LVR")|product.equals("EXP")|product.equals("APC"))) {
				if(group_id.toUpperCase().startsWith("CAN")){
					urlps="quotes/show_psa_quotes_cdn.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+UserID +"&group_id="+ group_id +"&type=3";
				}
				else{
					urlps="quotes/show_psa_quotes1.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=3";
				}
		}
			else if(product.equals("GRILLE")){
				urlps="quotes/show_psa_quotes_grille.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=3";
			}
			else if(product.equals("GCP")){
					urlps="quotes/show_psa_quotes3.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=3";
			}
			else if((product.equals("ADS"))){
				urlps="quotes/show_psa_quotes4.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=3&int=yes";
			}
			else{
				if(group_id.toUpperCase().startsWith("CAN")){
					urlps="quotes/show_psa_quotes_cdn.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+UserID +"&group_id="+ group_id +"&type=3";
				}
				else{
					if(product.equals("EFS")){
						urlps="quotes/show_psa_quotes_efs.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+UserID +"&group_id="+ group_id +"&type=3";
					}
else if(product.equals("EJC")){
						urlps="quotes/show_psa_quotes5.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+UserID +"&group_id="+ group_id +"&type=3";
					}
					else{
						urlps="quotes/show_psa_quotes.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+UserID +"&group_id="+ group_id +"&type=3";
					}
				}
			}
		}// if it not GE only show Plans and spces.
		// Plans & specs w/ qty-->
		if (!( product.equals("GE")|group_id.startsWith("Decolink") )){

				if ((product.equals("IWP"))) {
	urlpsq="quotes/show_psa_quotes.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+UserID +"&group_id="+ group_id +"&type=4";

}
				else if(product.equals("EJC")){
					urlpsq="quotes/show_psa_quotes5.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+UserID +"&group_id="+ group_id +"&type=4";
				}

		}// if it not GE only show Plans and spces.
		// Line & Item -->
		%>

		<%
		if (!(product.equals("LVR")|product.equals("BV")|product.equals("GRILLE")|product.equals("EFS")|product.equals("GCP")|product.equals("DADE_LVR"))) {
			if (product.equals("GE")) {
				urlli="quotes/show_psa_quotes3.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&type=2";
			}
			else if((product.equals("ADS"))){
				urlli="quotes/show_psa_quotes4.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=2&int=yes";
			}
			else {
				if(group_id.toUpperCase().startsWith("CAN")){
					urlli="quotes/show_psa_quotes_cdn.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=2";
				}
				else{
					//out.println(product+"::<BR>");
					if(product.equals("EFS")){
						urlli="quotes/show_psa_quotes_efs.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=2";
					}
else	if(product.equals("EJC")){
						urlli="quotes/show_psa_quotes5.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=2";
					}
					else{
						urlli="quotes/show_psa_quotes.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=2";
					}
				}
			}
		}
		if(product.equals("IWP")){
			urlliint="quotes/show_psa_quotes.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=5&int=yes";
			urltqint="quotes/show_psa_quotes.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=6&int=yes";

		}
else if(product.equals("EJC")){
			urlliint="quotes/show_psa_quotes5.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=5&int=yes";
			urltqint="quotes/show_psa_quotes5.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=6&int=yes";
		}
		else if(product.equals("EFS")){
			urlliint="quotes/show_psa_quotes_efs.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=5&int=yes";
			urltqint="quotes/show_psa_quotes_efs.jsp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=6&int=yes";
		}
		//out.println(urltq+"::<BR>"+urlps+"::<BR>"+urlli);
		%>
		<form name='quoteform'>
			<table border=0 align='center'>
				<%
				out.println("<input type='hidden' name='urltq' value='"+urltq+"'>");
				out.println("<input type='hidden' name='urlps' value='"+urlps+"'>");
				out.println("<input type='hidden' name='urlpsq' value='"+urlpsq+"'>");
				out.println("<input type='hidden' name='urlli' value='"+urlli+"'>");
				out.println("<input type='hidden' name='urlliint' value='"+urlliint+"'>");
				out.println("<input type='hidden' name='urltqint' value='"+urltqint+"'>");
				out.println("<input type='hidden' name='order_no' value='"+order_no+"'>");
				out.println("<input type='hidden' name='imstype' value=''>");
				out.println("<input type='hidden' name='imsurl' value=''>");
				out.println("<input type='hidden' name='urlAdd' value='"+urlAdd+"'>");
				//if(product.equals("LVR")||product.equals("GRILLE")||product.equals("BV")){
					out.println("<input type='hidden' name='isHeader' value='TRUE'>");
					out.println("<input type='hidden' name='isFooter' value=''>");
				//}
				//else{
				//	out.println("<input type='hidden' name='isHeader' value=''>");
				//	out.println("<input type='hidden' name='isFooter' value=''>");
				//}
			if(rep_quote != null && rep_quote.trim().length()>0){
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
					out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='SEND PDF TO IMS' value='SEND PDF TO IMS' onclick=\"ims('2')\"></td>");
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
				%>
		</form>
		<%
		//out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='test PDF' value='test PDF' onclick=\"pdf('7')\"></td>");
		//<!-- additional docs -->
		if ((product.equals("LVR")|product.equals("BV")|product.equals("GRILLE")|product.equals("DADE_LVR"))) {
		%>
	<tr class='important1' align="center" valign="middle">
		<td align="left" valign="center" class='important1'><b><font face='arial'   SIZE='2'><b>PSA Summary report::</b></td>
					<td align="center" valign="top" colspan="3"> <a href="display_test_new1.jsp?choice=<%= order_no %>&QuoteID=<%= QuoteID %>&AcctID=<%= AcctID %>&group_id=<%= group_id %>&UserID=<%= UserID %>&type=2" TARGET="_blank" name="Browser Quote"><img src="images/ie-icon.gif" border="0" alt="Browser Quotes" width="29" height="29"></a></td>
					</tr>
					<tr class='important1' align="center" valign="middle">
						<td align="left" valign="center" class='important1'><b><font face='arial'   SIZE='2'><b>Schedule of Values::</b></td>
									<td align="center" valign="top" colspan='3'> <a href="sch_final.jsp?choice=<%= order_no %>&QuoteID=<%= QuoteID %>&AcctID=<%= AcctID %>&group_id=<%= group_id %>&UserID=<%= UserID %>&type=2" TARGET="_blank" name="Browser Quote"><img src="images/ie-icon.gif" border="0" alt="Browser Quotes" width="29" height="29"></a></td>
									</tr>
									<%
								}
								if (!(product.equals("LVR")|product.equals("ADS")|product.equals("BV")|product.equals("GCP")|product.equals("GRILLE")|product.equals("GE")|product.equals("DADE_LVR")|product.equals("BV")|group_id.startsWith("Decolink"))) {
									%>
									<tr class='important1' align="center" valign="middle">
										<td align="left" valign="center" class='important1'><font face='arial'   SIZE='2'><b>Work Copy::</td>
													<td align="center" valign="top" colspan='4'>
														<input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='Work Copy' value='Work Copy' onclick="javascript:n_window2('../../reports/work_copy_home_psa.jsp?orderNo=<%= order_no %>&QuoteID=<%= QuoteID %>&AcctID=<%= AcctID %>&group_id=<%= group_id %>&UserID=<%= UserID %>&type=2')">
														<input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='SEND PDF TO IMS' value='SEND PDF TO IMS' onclick="ims('http://<%=application.getInitParameter("HOST")%>/erapid/us/reports/work_copy_home_psa.jsp?orderNo=<%= order_no %>&QuoteID=<%= QuoteID %>&AcctID=<%= AcctID %>&group_id=<%= group_id %>&UserID=<%= UserID %>&type=2')">
													</td>
													</tr>
													<%
												}
												else if(product.equals("ADS")){
													%>
													<tr class='important1' align="center" valign="middle">
														<td align="left" valign="center" class='important1'><font face='arial'   SIZE='2'><b>Work Copy::</td>
																	<td align="center" valign="top" colspan='4'>
																		<input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='Work Copy' value='Work Copy' onclick="javascript:n_window2('work_copy_home_ads.jsp?orderNo=<%= order_no %>&QuoteID=<%= QuoteID %>&AcctID=<%= AcctID %>&group_id=<%= group_id %>&UserID=<%= UserID %>&type=2')">
																		<input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='SEND PDF TO IMS' value='SEND PDF TO IMS' onclick="ims('http://<%=application.getInitParameter("HOST")%>/erapid/us/reports/work_copy_home_ads.jsp?orderNo=<%= order_no %>&QuoteID=<%= QuoteID %>&AcctID=<%= AcctID %>&group_id=<%= group_id %>&UserID=<%= UserID %>&type=2')">
																	</td>
																	</tr>
																	<%
																}

															}
															else{
																out.println("Please select rep quote type</form>");
															}
																	%>
																	<tr class='important1' align="center" valign="middle">
																		<td align="left" valign="center" class='important1'><font face='arial'   SIZE='2'><b>Rep Quote::</td>
																					<td align="center" valign="top" colspan='3'>
																						<%
																						/*
																						if(rep_quote==null ||rep_quote.trim().equals("")){
																							if(quote_type.endsWith("PS")){
																								rep_quote="2";
																							}
																							else{
																								rep_quote="1";
																							}
																						}
																						*/
																						String selected="";String selected1="";String selected2="";
																						if(rep_quote!=null&&rep_quote.equals("1")){
																							selected="selected";
																						}
																						else if(rep_quote!=null&&rep_quote.equals("3")){
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
																								<%
																								if (!(product.equals("GE")|group_id.startsWith("Decolink") )){
																								%>
																								<option value='3' <%= selected1 %>>Plans & Specs</option>
																								<%
																							}
																							if (!( product.equals("GE")|group_id.startsWith("Decolink") )){
																								if ((product.equals("IWP")|product.equals("EJC"))) {
																								%>
																								<option value='4' <%= selected2 %>>Plans & Specs with Quantities</option>
																								<%
																							}
																						}
																								%>
																							</select>
																							<input type='hidden' name='QuoteID' value=<%= QuoteID %> >
																							<input type='hidden' name='AcctID' value=<%= AcctID %> >
																							<input type='hidden' name='UserID' value=<%= UserID %> >
																							<input type='hidden' name='orderNo' value=<%= order_no %> >
																						</form>
																					</td>
																					</tr>
																					<%
																					if(rep_quote != null && rep_quote.trim().length()>0){
																					%>
																					<tr class='important1' align="center" valign="middle">
																						<td align="left" valign="center" class='important1'><font face='arial'   SIZE='2'><b>Email Quote::</td>
																									<td align="center" valign="top" colspan='3'>
																										<input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='Email Quote' value='Email Quote' onclick="javascript:n_window2('mail.home.jsp?orderNo=<%= order_no %>&QuoteID=<%= QuoteID %>&AcctID=<%= AcctID %>&UserID=<%= UserID %>')">
																										<!--
																										<a href="mail.home.jsp?orderNo=<%= order_no %>&QuoteID=<%= QuoteID %>&AcctID=<%= AcctID %>&UserID=<%= UserID %>" TARGET="_blank" name="Browser Quote"><img src="images/mail3.gif" border="0" alt="Browser Quotes" width="32" height="32"></a>
																										-->
																									</td>
																									</tr>
																									<%
																								}

																									%>


																									<!--	Tear sheer quantity hiding-->
																									<tr class='important1' align="center" valign="middle">
																										<td align="left" valign="center" class='important1'><b><font face='arial'   SIZE='2'><b>Rep Tear Sheet::</b></td>
																													<td align="center" valign="top" colspan='3'>
																														<%
																														if(rep_tear_sheet==null ||rep_tear_sheet.trim().equals("")){rep_tear_sheet="1";}
																														String selected_tr="";String selected_tr1="";
																														if(rep_tear_sheet==null||rep_tear_sheet.equals("1")){selected_tr="selected";}else{selected_tr1="selected";	}
																														%>
																														<form name="selectform_1" action="rep.tear.sheet.quant.jsp" method="post">
																															<select name='tear_sheet' onchange="mysubmit1()">
																																<option value='1' <%= selected_tr %> >With No Quantity</option>
																																<option value='2' <%= selected_tr1 %>>With Quantity</option>
																															</select>
																															<input type='hidden' name='QuoteID' value=<%= QuoteID %> >
																															<input type='hidden' name='AcctID' value=<%= AcctID %> >
																															<input type='hidden' name='UserID' value=<%= UserID %> >
																															<input type='hidden' name='orderNo' value=<%= order_no %> >
																														</form>
																													</td>
																													</tr>
																													<!--	Tear sheer quantity hiding done-->
																													<%if (product.equals("GE")) {%>
																													<tr class='important1' align="center" valign="middle">
																														<td align="left" valign="center" class='important1'><b><font face='arial'   SIZE='2'><b>GE Report::</b></td>
																																	<td align="center" valign="top" colspan='3'>
																																		<input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='GE Report' value='GE Report' onclick="javascript:n_window2('gereport.jsp?order_no=<%= order_no %>')">
																																		<!--
																																		<a href="gereport.jsp?order_no=<%= order_no %>" TARGET="_blank" name="Browser Quote"><img src="images/ie-icon.gif" border="0" alt="Browser Quotes" width="29" height="29"></a>
																																		-->
																																	</td>
																																	</tr>
																																	<%
																																	if(project_type == null){project_type="";}
																																	if(project_type.toUpperCase().equals("PFL")){
																																	%>
																																	<tr class='important1' align="center" valign="middle">
																																		<td align="left" valign="center" class='important1'><b><font face='arial'   SIZE='2'><b>GE PROFILE::</b></td>
																																					<td align="center" valign="top" colspan='3'> <a href="profile_header.jsp?selectmenu=<%= order_no %>&UserID=<%=UserID %>" TARGET="_blank" name="Browser Quote"><img src="images/ie-icon.gif" border="0" alt="Browser Quotes" width="29" height="29"></a></td>
																																					</tr>
																																					<%
																																				}
																																			}
																																					%>

																																					</table>


																																					<%

																																					//out.println(product);
																																					if(product.equals("ADS")){
																																					%>
																																					<a href="/word_quotes/xshow_quotes_ads_psa.asp?orderNo=<%= order_no %>&QuoteID=<%= QuoteID %>&AcctID=<%= AcctID %>&UserID=<%= UserID %>&group_id=<%= group_id %>&type=1" TARGET="_blank" name="Browser Quote"><img src="images/word-icon.gif" border="0" alt="Word Quote" width="29" height="29"></a>

																																					<%
																																					}

																																					}
																																					else if(quote_type_id.equals("GC")){//for non erapid PSA quotes only for GCP quotes
																																					//	out.println("Test"+quote_type_id+"::"+quote_type);
																																					out.println("<table border=0 align='center'>");
																																					out.println("<tr class='important1' align='center' valign='middle'>");
																																					out.println("<td align='left' class='important1' valign='center'><font face='arial'   SIZE='2'><b>Types & Quantities::</td>");
																																					out.println("<td align='center' valign='top'>&nbsp; <a href='show_psa_quotes1.jsp?orderNo="+order_no+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&type=1' TARGET='_blank' name='Browser Quote'><img src='images/ie-icon.gif' border='0' alt='Browser Quotes' width='29' height='29'></a> </td>");
																																					//getting the word quotes
																																					if ((new_page==null)||(new_page.equals("0"))||(sections<=0)){
																																					out.println("<td align='center' valign='top'> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/word_quotes/xshow_quotes_gcp_psa.asp?orderNo="+orderNo+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&type=1' TARGET='_blank' name='Browser Quote'><img src='images/word-icon.gif' border='0' alt='Word Quote' width='29' height='29'></a></td>");
																																					}
																																					else{
																																					out.println("<td align='center' valign='top'> &nbsp;&nbsp;&nbsp;&nbsp;<a href='/word_quotes/xshow_quotes_gcp_psa_page.asp?orderNo="+orderNo+"&QuoteID="+QuoteID+"&AcctID="+AcctID+"&UserID="+UserID+"&type=1' TARGET='_blank' name='Browser Quote'><img src='images/word-icon.gif' border='0' alt='Word Quote' width='29' height='29'></a></td>");
																																					}
																																					//getting the word quotes done
																																					out.println("</table>");
																																					}
																																					else{
																																					out.println("<table border=0 align='center'>");
																																					out.println("<tr class='important1' align='center' valign='middle'>");
																																					out.println("<td align='left' valign='center' class='important1'><font face='arial'   SIZE='2'><b>Issued PSA Quote ID:: </td>");
																																					out.println("<td align='center' valign='top' class='important1'>"+QuoteID+"</td>");
																																					out.println("</tr>");
																																					out.println("</table>");
																																					out.println("<br><br><br>");
																																					out.println("A Erapid quote no is not attached to this PSA quote.<br>Please import the erapid quote no from erapid to view a quote.");
																																					}
																																					}
																																					else{
																																					out.println("<table border='0' align='center' width='100%'>");
																																					out.println("<tr class='important'>");
																																					out.println("<td align='center'>");

																																					%>
																																					<a href="javascript:n_window2('http://<%=application.getInitParameter("HOST")%>/erapid/us/legacy/sections.home.jsp?orderNo=<%=orderNo%>&cmd=1&close=true')"><FONT SIZE='2'><b>Quote Sections</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
																																								<%
																																								//out.println("<a href='http://"+ application.getInitParameter("HOST")+"/erapid/us/legacy/sections.home.jsp?orderNo="+ orderNo+"&cmd=1'>Quote Sections"+"<a>");
																																								out.println("</td>");
																																								out.println("</tr>");
																																								out.println("</table>");
																																								}

																																								stmt.close();
																																								myConn.close();
																																								stmts.close();
																																								myConns.close();
																																								stmt_psa.close();
																																								myConn_psa.close();
																																								%>
																																								</body>
																																								</html>
																																								<%
																																								//out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='HTML OLD' value='HTML OLD' onclick=\"n_window2('http://"+ application.getInitParameter("HOST")+"/word_quotes/show_quotes_psa.asp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=1')\"></td>");
																																								//out.println("<td><input type='button' class='button' onmouseover=this.className='button5' onmouseout=this.className='button' name='HTML OLD' value='HTML OLD PAGE' onclick=\"n_window2('http://"+ application.getInitParameter("HOST")+"/word_quotes/show_quotes_psa_page.asp?orderNo="+ order_no +"&QuoteID="+ QuoteID +"&AcctID="+ AcctID +"&UserID="+ UserID +"&group_id="+ group_id +"&type=1')\"></td>");
																																								}
																				  catch(Exception e){
																					out.println("ERROR::"+e);
																				  }
																																								%>