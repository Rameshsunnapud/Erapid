<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/>
<jsp:useBean id="quoteHeader" 	class="com.csgroup.general.QuoteHeaderBean"		scope="page"/>

<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
	   erapidBean.setServerName("server1");
}
try{

%>
<html>
	<head>
		<title>Price Build up Screen</title>
		<link rel='stylesheet' href='../../css/<%=userSession.getStyleSheet()%>' type='text/css' />
	</head>
	<script language="JavaScript" src="../../javascript/ajax.js"		></script>
	<SCRIPT language="JavaScript">
		function doThis2(){
			alert("There is a minimum charge of $300 required for this product line.  Please add the difference on to the miscellaneous charge box.");
			document.location.href="quotes_main.jsp?q_no="+document.selectform.q_no.value
			getButtons();
		}
		function n_window(theurl){
			var the_width=450;
			var the_height=400;
			var from_top=180;
			var from_left=460;
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

		function checkWindow3(){
			if(window.myWindowx4){
				if(myWindowx4&&typeof (myWindowx4.closed)!='unknown'&&!myWindowx4.closed){
					myWindowx4.form1.url.value=document.formRTF.url.value;
					myWindowx4.form1.order_no.value=document.formRTF.order_no.value;
					myWindowx4.form1.isHeader.value="TRUE";
					myWindowx4.form1.output.value="RTF";
				}
				else{
					setTimeout("checkWindow3();",1000);
				}
			}
			else{
				setTimeout("checkWindow3();",1000);
			}
		}
		function goRtf(urlx){

			var the_width=250;
			var the_height=100;
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
			var theurl="rtfInit.jsp";
			myWindowx4=window.open(theurl,'myWindowx4',the_atts);
			if(window.myWindowx4){
				if(myWindowx4&&typeof (myWindowx4.closed)!='unknown'&&!myWindowx4.closed){
					setTimeout("checkWindow3();",1000);
				}
				else{
					setTimeout("checkWindow3();",1000);
				}
			}
			else{
				setTimeout("checkWindow3();",1000);
			}
		}

		function checkWindow2(){

			if(window.myWindowx3){
				if(myWindowx3&&typeof (myWindowx3.closed)!='unknown'&&!myWindowx3.closed){
					myWindowx3.form1.url.value=document.formPDF.url.value;
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



		function getButtons(){
			//alert("get buttons");
			mailDiv.style.visibility='hidden';
			var params="";
			params="&orderNo="+document.form1.orderNo.value;
			params=params+"&product="+document.form1.product.value;
			params=params+"&group="+document.form1.group.value;
			params=params+"&page=pricecalc2";
			params=params+"&country=US";
			//alert("1");
			var strURL5=document.form1.url5.value;
			//alert("a");
			var req=new XMLHttpRequest();
			//alert("b");
			var handlerFunction=getReadyStateHandler(req,showButtons);
			//alert("c");
			req.onreadystatechange=handlerFunction;
			req.open("POST",strURL5,true);
			//alert("e");
			req.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			//params=convertPL(params);
			//alert(params);
			req.send(params);
			//alert("2");
		}
		function showButtons(searchXML){
			//alert("3");
			var params="";
			var isSFDC="";
			params="?orderNo="+document.form1.orderNo.value;
			var paramsInit=params;
			var count=searchXML.getElementsByTagName("name").length;
			var buttons="";
			var countx=0;
			//alert(count);
			for(var i=0;i<count;i++){
				//alert(i);
				var initUrl=searchXML.getElementsByTagName("url")[i].childNodes[0].nodeValue+params;
				var initUrlAdd=searchXML.getElementsByTagName("urlAdd")[i].childNodes[0].nodeValue;
				var seq=searchXML.getElementsByTagName("seq")[i].childNodes[0].nodeValue;
				seq=seq.replace("#","");
				if(seq>1000&&isSFDC.length==0){
					isSFDC="true";
					buttons=buttons+"<center><table width='40%' border='0'>";
					buttons=buttons+"<TR>";
				}
				if(isSFDC.length>0){
					buttons=buttons+"<TD>";
					countx++;
				}
				//alert("a");
				initUrlAdd=initUrlAdd.replace("#bpcsNo#",document.form1.bpcsNo.value);
				initUrlAdd=initUrlAdd.replace("#username#",document.form1.userId.value);
				initUrlAdd=initUrlAdd.replace("#repQuote#",document.form1.repQuote.value);
				initUrlAdd=initUrlAdd.replace("#group#",document.form1.group.value);
				initUrlAdd=initUrlAdd.replace("#","");
				if(initUrlAdd=="null"){
					initUrlAdd="";
				}
				if(initUrlAdd.length>0){
					initUrl=initUrl+initUrlAdd;
					initUrlAdd=initUrlAdd.replace(/&/g,"!");
					initUrlAdd=initUrlAdd.replace(/=/g,"@");
				}
				//alert("b");
				if(searchXML.getElementsByTagName("action")[i].childNodes[0].nodeValue!="pu"){
					params=params+"&urlx="+searchXML.getElementsByTagName("url")[i].childNodes[0].nodeValue+"&urlAddx="+initUrlAdd+"&action="+searchXML.getElementsByTagName("action")[i].childNodes[0].nodeValue+"&imstype="+searchXML.getElementsByTagName("imstype")[i].childNodes[0].nodeValue;
					initUrl="documentGenerator.jsp"+params;
				}
				if(initUrl.indexOf("lebhq")<0){
					initUrl="../"+initUrl;
				}
				//alert("c");
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
				//alert("d");
				if(isSFDC.length>0){
					buttons=buttons+"</TD>";
					if(countx%3==0){
						buttons=buttons+"</tr><TR>";
					}
				}
				params=paramsInit;
				//alert("done");
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
			window.parent.postMessage("OWS","*");
		}



		function showMailDiv(xurl){
			window.parent.postMessage("EMAIL","*");
		}



	</script>
	<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" import="java.io.*" import="java.math.*"  contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="error.jsp" %>

	<%
	String q_no = request.getParameter("q_no");
	String message="<font color='blue'>Actions For Job No "+q_no+"<font>";
	//HttpSession UserSession1 = request.getSession();
	String name=userSession.getUserId();
	quoteHeader.setOrderNo(q_no);
	String group="";
	String repQuote=quoteHeader.getRepQuote();
	String bpcsOrderNo=quoteHeader.getBpcsOrderNo();
		java.util.Date date=new java.util.Date();
		String tempdate=""+date.getTime();
		String dirname="d:/erapid/shared/email/"+tempdate;
String repEmail="";
String projectType="";
projectType=quoteHeader.getProjectType();
repEmail=quoteHeader.getRepEmail();

	%>
	<%//@ include file="rqs_head.jsp"%>
	<%//@ include file="db_con_sys.jsp"%>
	<%@ include file="../../../db_con.jsp"%>

	<%
String quoteOrigin="";
	String o_cost = request.getParameter("overage");
	String handling_cost = request.getParameter("handling_cost");
	String freight_cost = request.getParameter("freight_cost");
	String pid =quoteHeader.getProductId();
String product=pid;
	String commission = request.getParameter("commission");
	String t_cost = request.getParameter("t_cost");
	//out.println(t_cost);
	String creator_id = request.getParameter("creator_id");
	String project_type = request.getParameter("project_type");
	if (o_cost==null){o_cost="0.0";}
	if (handling_cost==null){ handling_cost="0.0";}
	if (freight_cost==null||freight_cost.trim().length()==0){freight_cost="0.0";}
	if (commission==null){commission="15";}
	if (t_cost==null){t_cost="0.0";}
	DecimalFormat for12=new DecimalFormat("#.##");
	DecimalFormat for0=new DecimalFormat("#");
	String t = request.getParameter("t");
	double grand_total=0;double sellprice_factor=0;
	double tax_dollar=0;
	//HttpSession UserSession_rep = request.getSession();
	String session_rep_no= userSession.getRepNo();
	String UserID= userSession.getUserId();
	String tax_perc = request.getParameter("tax_perc");
	if (tax_perc==null||tax_perc.trim().length()<1){tax_perc="0";}
	String order_no=q_no;
	String group_id="";
	ResultSet rs1 = stmt.executeQuery("SELECT * FROM cs_reps where rep_no like '"+session_rep_no.trim()+"'");
	while ( rs1.next() ) {
		group_id=rs1.getString("group_id");
	}
	rs1.close();

	%>
	<%//@ include file="db_con.jsp"%>
	<%@ include file="lvr_sill_note.jsp"%>
	<%

	String doc_type="";
	ResultSet rsDocType=stmt.executeQuery("select doc_type from doc_header where doc_number='"+q_no+"'");
	if(rsDocType != null){
		while(rsDocType.next()){
			doc_type=rsDocType.getString(1);
		}
	}
	rsDocType.close();
	myConn.setAutoCommit(false);
	Vector products=new Vector();
	String pro_temp="";
	ResultSet rsProduct=stmt.executeQuery("select distinct product_id from cs_costing where order_no ='"+q_no+"'");
	if(rsProduct != null){
		while(rsProduct.next()){
			products.addElement(rsProduct.getString(1));
		}
	}
	rsProduct.close();
	if(products.size()==1){
		pro_temp=products.elementAt(0).toString();
	}
	else{
		pro_temp="LVR";
	}
	String query="";
	commission=for0.format(new Double(commission).doubleValue());
	query="select * from cs_lvr_sp_factor where product_id='LVR' and com_percent='"+commission+"' ";
	//out.println(query);
	ResultSet myResult2=stmt.executeQuery(query);
	if (myResult2 !=null) {
		while (myResult2.next()){
			sellprice_factor=myResult2.getDouble(2);
		}
	}
myResult2.close();
	BigDecimal d12 = new BigDecimal(t_cost);
	double t1=(d12.doubleValue()/sellprice_factor);

	if((group_id.toUpperCase().startsWith("REP") && project_type!= null && (project_type.equals("PSA") || project_type.equals("SFDC")))){
		//t=100;
		//out.println("<BR>HERE<BR>");
		t1=new Double(t_cost).doubleValue();
		t=""+t1;
	}

	if(!((commission==null)|(commission.equals("15")))){
		if((Double.parseDouble(o_cost))>0){
			out.println("<font color='blue'>Overage can be applied only for a 15 % comission</font>");
		}
		o_cost="0";
	}

	if (creator_id.equals("147")||creator_id.equals("351")){
		t1=t1*1.20;			// add extra 15% to the cost price.
		//			out.println("Hawai"+t);
	}
	grand_total=Double.parseDouble(o_cost)+Double.parseDouble(handling_cost)+Double.parseDouble(freight_cost)+t1;
	double grand_totalx=grand_total;
	tax_dollar=(grand_total*Float.parseFloat(tax_perc))/100;

	grand_total=grand_total+tax_dollar;
	BigDecimal d1=new BigDecimal("0");
	BigDecimal d2=new BigDecimal("0");
	NumberFormat for1 = NumberFormat.getCurrencyInstance();
	for1.setMaximumFractionDigits(0);
	if(grand_totalx<300&&group_id.toUpperCase().startsWith("REP")){
		out.println("<body onload='doThis2()'>");
		out.println("<form name='selectform'>");
		out.println("<input type='hidden' name='q_no' value='"+q_no+"'>");
		out.println("</form>");
	}

	else{
out.println("<body onload='getButtons()'>");
		try{
			//out.println("<p>Testing LVR's for RepPortal "+t+"</p>");
			java.sql.PreparedStatement ps=myConn.prepareStatement("UPDATE cs_project SET overage =?,handling_cost =?,freight_cost =?,configured_price =?,commission =?,tax_perc=? WHERE Order_no =? ");
			ps.setString(1,o_cost);
			ps.setString(2,handling_cost);
			ps.setString(3,freight_cost);
			ps.setString(4,t);
			ps.setString(5,commission);
			ps.setString(6,tax_perc);
			ps.setString(7,q_no);
			int re=ps.executeUpdate();
			ps.close();
		}
		catch (java.sql.SQLException e){
			out.println("Problem with ENTERING TO Projects"+"<br>");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}
		out.println("<table width='100%' border='0'> ");
		out.println("<tr class='header1'>");
		out.println("<td colspan='3' align='center'><h3>Price Calculator</h3> </td>");
		out.println("</tr>");
		out.println("<tr class='important'>");
		out.println("<td align='left' width='34%'>");
if(group_id.equals("Rep-DLvr")){
out.println("Configured Price: ");
}
else{
out.println("Configured Price ( @ "+commission+" % Commission ): ");
}
out.println("</td>");
		out.println("<td width='23%' align='right'>");out.println(for12.format(t1));	out.println("</td>");
		out.println("<td width='43%' >&nbsp;</td>");
		out.println("</tr>");
		if(!((commission==null)|(commission.equals("15")))){
			out.println("<input type='hidden' name='overage' value='0'>");
			o_cost="0";
		}
		else{
			out.println("<tr class='important'>");
			out.println("<td align='left'>");out.println("Overage:");out.println("</td>");
			out.println("<td align='right'>");out.println(o_cost);out.println("</td>");
			out.println("<td>&nbsp;</td>");
			out.println("</tr>");
		}
		out.println("<tr class='important'>");
		out.println("<td align='left'>");out.println("Custom Color Charge/Misc.:");out.println("</td>");
		out.println("<td align='right'>");out.println(freight_cost);out.println("</td>");
out.println("<td>&nbsp;</td>");
if(!group_id.equals("Rep-DLvr")){
		out.println("</tr>");
		out.println("<tr class='important'>");
		out.println("<td align='left'>");out.println("Commission(%):");out.println("</td>");
		out.println("<td align='right'>");out.println(commission);out.println("</td>");
		out.println("<td>&nbsp;</td>");
		out.println("</tr>");
}

		NumberFormat for2 = NumberFormat.getInstance();
		for2.setMaximumFractionDigits(2);
		//for2.setMinimumFractionDigits(2);

		out.println("<tr class='important'>");
		out.println("<td align='left'>");out.println("Total Tax(" +tax_perc+"%):");out.println("</td>");
		out.println("<td align='right'>");out.println(for2.format(new Double(tax_dollar).doubleValue()));out.println("</td>");
out.println("<td>&nbsp;</td>");
		out.println("</tr>");

		out.println("<tr class='important'>");
		out.println("<td align='left'>");out.println("Total:");out.println("</td>");
		d1 = new BigDecimal(((new Float(grand_total)).toString()));
		d1.setScale(0,BigDecimal.ROUND_HALF_UP);
		d2 = new BigDecimal(((new Float(grand_totalx)).toString()));
		d2.setScale(0,BigDecimal.ROUND_HALF_UP);
		out.println("<td align='right'>");out.println(""+for1.format(d1.doubleValue()));out.println("</td>");
out.println("<td>&nbsp;</td>");
		out.println("</tr>");
		out.println("</table>");
		if(!((grand_total<20000)|(grand_total>300))){
			out.println("<p align='center'><font color='red' size=4> Budget Only! Call factory for pricing.</font></p>");
		}
}
myConn.commit();
myConn.close();


      group=userSession.getGroup();


	%>
	<form name='form1'>
		<input type='hidden' name='product' value='<%=pid%>'>
		<input type='hidden' name='group' value='<%=group%>'>
		<input type='hidden' name='orderNo' value='<%=q_no%>'>
		<input type='hidden' name='repQuote' value='<%=repQuote%>'>
		<input type='hidden' name='userId' value='<%=userSession.getUserId()%>'>
		<input type='hidden' name='bpcsNo' value='<%=bpcsOrderNo%>'>
		<input type='hidden' name='url5' value='../getButtons.jsp'>
	</form>
	<div id='buttonsDiv' >





	</div>
	<div id='mailDiv' ><%@ include file="../email.jsp"%>    </div>
</html>
<%

	}
	  catch(Exception e){
		out.println("ERROR::"+e);
	  }
%>