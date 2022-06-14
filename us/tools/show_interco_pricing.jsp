<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<%
//if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
//        erapidBean.setServerName("server1");
//}
try{

%>
<html>
	<head>
		<title>Show Inter Company Pricing</title>
		<script language="JavaScript">
			function initSelectedNotes( ){
				this.moveTo(0,0);
				this.resizeTo(screen.width,screen.height);
			}
			function saveThis(varx){
				document.form1.usedModels.value=document.form1.usedModels.value+""+document.form2.model[varx].value+"#";
				document.form1.submit();
			}
			function saveThis2(varx){
				document.form1.usedItems.value=document.form1.usedItems.value+""+document.form2.item[varx].value+"#";
				document.form1.submit();
			}
			function saveAll(){
				document.form1.usedModels.value=document.form1.usedModels.value+""+document.form2.tempmodels.value+"";
				document.form1.submit();
			}
			function saveAll2(){
				document.form1.usedItems.value=document.form1.usedItems.value+""+document.form2.tempitems.value+"";
				document.form1.submit();
			}
			function print(){
				var divs=document.getElementsByTagName("DIV");
				for(i=0;i<divs.length;i++){
					if(divs[i].id!="print"){
						divs[i].style.display="none";
					}
				}
				alert("Remember to print to Landscape.");
			}
			function toExcel(){
				var myurl="interco_pricing_excel.jsp?usedItems="+document.form1.usedItems.value+"&usedModels="+document.form1.usedModels.value;
				myurl=myurl.replace(/#/g,"-");
				var newWindowExcel;
				var props='scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=mo,directories=no,width=700,height=450';
				//alert(myurl);
				myWindowx4=window.open(myurl,'myWindowx4',props);
			}
			function pdf(){
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
				myWindowPdf=window.open(theurl,'myWindowPdf',the_atts);
				if(window.myWindowPdf){
					if(myWindowPdf&&typeof (myWindowPdf.closed)!='unknown'&&!myWindowPdf.closed){
						setTimeout("checkWindowPdf();",1000);
					}
					else{
						setTimeout("checkWindowPdf();",1000);
					}
				}
				else{
					setTimeout("checkWindowPdf();",1000);
				}
			}
			function checkWindowPdf(){
				var url="https://lebhq-erusdev.c-sgroup.com/erapid/us/tools/interco_pricing_pdf.jsp?usedModels=all";
				if(window.myWindowPdf){
					if(myWindowPdf&&typeof (myWindowPdf.closed)!='unknown'&&!myWindowPdf.closed){
						myWindowPdf.form1.url.value=url;
						myWindowPdf.form1.order_no.value="000000";
						myWindowPdf.form1.paper.value="LETTER";
						myWindowPdf.form1.isLandscape.value="YES";
					}
					else{
						setTimeout("checkWindowPdf();",1000);
					}
				}
				else{
					setTimeout("checkWindowPdf();",1000);
				}
			}
			function pdf2(){
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
				myWindowPdf2=window.open(theurl,'myWindowPdf2',the_atts);
				if(window.myWindowPdf2){
					if(myWindowPdf2&&typeof (myWindowPdf2.closed)!='unknown'&&!myWindowPdf2.closed){
						setTimeout("checkWindowPdf2();",1000);
					}
					else{
						setTimeout("checkWindowPdf2();",1000);
					}
				}
				else{
					setTimeout("checkWindowPdf2();",1000);
				}
			}
			function checkWindowPdf2(){
				var url="https://lebhq-erusdev.c-sgroup.com/erapid/us/tools/interco_pricing_pdf.jsp?usedItems=all";
				if(window.myWindowPdf2){
					if(myWindowPdf2&&typeof (myWindowPdf2.closed)!='unknown'&&!myWindowPdf2.closed){
						myWindowPdf2.form1.url.value=url;
						myWindowPdf2.form1.order_no.value="000000";
						myWindowPdf2.form1.paper.value="LETTER";
						myWindowPdf2.form1.isLandscape.value="YES";
					}
					else{
						setTimeout("checkWindowPdf2();",1000);
					}
				}
				else{
					setTimeout("checkWindowPdf2();",1000);
				}
			}
			function excel1(){
				var url="https://lebhq-erusdev.c-sgroup.com/erapid/us/tools/interco_pricing_excel_all.jsp?usedModels=all";
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
				myWindowPdf2=window.open(url,'myWindowExcel2',the_atts);
			}
			function excel2(){
				var url="https://lebhq-erusdev.c-sgroup.com/erapid/us/tools/interco_pricing_excel_all.jsp?usedItems=all";
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
				myWindowPdf2=window.open(url,'myWindowExcel2',the_atts);
			}
		</script>
		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>
	<body onLoad="initSelectedNotes()">
		<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" import="java.io.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con.jsp"%>
		<%//@ include file="db_con_bpcsusr.jsp"%>
		<%
		//if ((request.getSession()!=null)){
			boolean isIntl=false;
			String country=request.getParameter("country");
			if(country == null){
				country="";
			}
			HttpSession usersession=request.getSession();
			String group="";
			String sessionId=usersession.getId();
//out.println(sessionId);
			//if(usersession != null&&usersession.getValue("usergroup") != null){
			//	group=usersession.getValue("usergroup").toString();
			//}
			//if(group != null &&group.equals("Internatio")){
			//		isIntl=true;
			//}
			//if((group != null && group.trim().length()>0)||(country.equals("Poland")||country.equals("Germany")||country.equals("UK")||country.equals("France")||country.equals("Asia"))){
				java.util.Date date = new java.util.Date();
				int hours=date.getHours();
				int mins=date.getMinutes();
				int total=hours*60+mins;
				//if( (total>=60&&total<=90) ||(date.getDay()==1&&total>=180&&total<=225)){
				//	out.println("Intercompany Pricing is down between 1am and 1:30 am EST everyday.  In addition, it will be down between 3am and 3:45 am on Mondays.");
				//}
				//else{
					String param = request.getParameter("param");
					String mode=request.getParameter("mode");
					String method=request.getParameter("method");
					String group1=request.getParameter("group1");
					String usedModels=request.getParameter("usedModels");
					String sbuSearch=request.getParameter("sbu");
					String usedModelsString=usedModels;
					//out.println(usedModels);
					String usedItems=request.getParameter("usedItems");
					//out.println(usedItems+"::"+usedModels);
					String usedItemsString=usedItems;
					String andChecked="";
					String orChecked="";
					String paramQuery="";
					if(group1 != null){
						if(group1.equals("or")){
							orChecked="checked";
							if(!mode.equals("PART")){
								if(method.equals("DESC")){
									paramQuery="description like '%"+param.trim().replaceAll(" ","%' or description like '%")+"%'";

								}
								else{
									paramQuery="model like '"+param.trim().replaceAll(" ","%' or model like '")+"%'";
								}
								//out.println(param);
							}
							else{
								if(method.equals("DESC")){
									paramQuery="PRCDSC like '%"+param.trim().replaceAll(" ","%' or PRCDSC like '%")+"%'";
								}
								else{
									paramQuery="PRCITM like '"+param.trim().replaceAll(" ","%' or PRCITM like '")+"%'";
								}

							}
							if(sbuSearch.trim().length()>0){
								if(mode.equals("PART")){
									if(sbuSearch.equals("EJC")){
										paramQuery=paramQuery+" and PRCSBU='TPG'";
									}
									else{
										paramQuery=paramQuery+" and PRCSBU='"+sbuSearch+"'";
									}
								}
								else{
									paramQuery=paramQuery+" and SBU='"+sbuSearch+"'";
								}
							}

						}
						else{
							andChecked="checked";
							if(!mode.equals("PART")){
								if(method.equals("DESC")){
									paramQuery="description like '%"+param.trim().replaceAll(" ","%")+"%'";
								}
								else{
									paramQuery=" model like '"+param.trim().replaceAll(" ","%")+"%'";
								}
							}
							else{
								if(method.equals("DESC")){
									paramQuery="PRCDSC like '%"+param.trim().replaceAll(" ","%").toUpperCase()+"%'";
								}
								else{
									paramQuery="PRCITM like '"+param.trim().replaceAll(" ","%").toUpperCase()+"%'";
								}
							}
							if(sbuSearch.trim().length()>0){
								if(mode.equals("PART")){
									if(sbuSearch.equals("EJC")){
										paramQuery=paramQuery+" and PRCSBU='TPG'";
									}
									else{
										paramQuery=paramQuery+" and PRCSBU='"+sbuSearch+"'";
									}
								}
								else{
									paramQuery=paramQuery+" and SBU='"+sbuSearch+"'";
								}
							}
						}
						//out.println(paramQuery);
					}
					else{
						andChecked="checked";
					}

					if(mode == null){
						mode="";
					}
					if(usedModels==null){
						usedModels="";
					}
					if(usedModelsString==null){
						usedModelsString="";
					}
					if(usedItems==null){
						usedItems="";
					}
					if(usedItemsString==null){
						usedItemsString="";
					}
					if(sbuSearch==null){
						sbuSearch="";
					}
					out.println("<form name='form1' action='show_interco_pricing.jsp' method='post' >");

					DecimalFormat for1 = new DecimalFormat("###.##");
					for1.setMaximumFractionDigits(4);
					for1.setMinimumFractionDigits(4);
					DecimalFormat for0 = new DecimalFormat("###");
					for0.setMaximumFractionDigits(0);
					for0.setMinimumFractionDigits(0);

					out.println("<div id='print'>");
					java.util.Date myDate = new java.util.Date();
					String x1=""+(myDate.getYear()+1900);
					String x2=""+(myDate.getMonth()+1);
					String x3=""+myDate.getDate();
					if(x2.trim().length()<2){
						x2="0"+x2;
					}
					if(x3.trim().length()<2){
						x3="0"+x3;
					}
					String x4=x2+"/"+x3+"/"+x1;
					//out.println(x4);
					out.println("<table aign='center' border='0' width='100%'><tr><td width='25%' align='left' valign='top'>DATE: "+x4+"</td><td width='50%' align='center' valign='top'><font size='3'>CONFIDENTIAL PROPERTY OF CS</font></td><td width='25%' align='right'>&nbsp;</td></tr></table>");

					if(usedModels.trim().length()>0){
		%>
		<TABLE cellspacing=0 cellpadding=2 id=header width='1250px' border='1'>
			<tr>
				<td width='5%'  bgcolor='lightgrey'>SBU</td>
				<td width='13%'  bgcolor='lightgrey'>MODEL</td>
				<td width='12%'  bgcolor='lightgrey'>BPCS</td>
				<td width='37%' bgcolor='lightgrey'>DESC</td>
				<td width='5%'  bgcolor='lightgrey'>UM</td>
				<td width='6%'  bgcolor='lightgrey'>UNIT WEIGHT</td>
				<td width='6%'  bgcolor='lightgrey'>IC PRICE</td>
				<td width='6%'  bgcolor='lightgrey'>SAMPLE PRICE</td>
				<td width='6%' bgcolor='lightgrey'>METRIC</td>
				<td width='6%' bgcolor='lightgrey'>UM METRIC</td>
				<td width='6%' bgcolor='lightgrey'>UNIT WEIGHT METRIC</td>
				<td width='10%' bgcolor='lightgrey'>EFFECTIVE DATE</td>
			</tr>
			<%
			if(usedModels.endsWith("#")){
				usedModels=usedModels.substring(0,usedModels.length()-1);
			}
			usedModels=usedModels.replaceAll("#","','");
			ResultSet rsUsedModels=stmt.executeQuery("Select * from cs_ic_price where model in ('"+usedModels+"') order by sbu,model");
			if(rsUsedModels != null){
				while(rsUsedModels.next()){
					String sbux="&nbsp;";
					if(rsUsedModels.getString("sbu") != null){
						sbux=rsUsedModels.getString("sbu");
					}
					String typex="&nbsp;";
					if(rsUsedModels.getString("type") != null){
						typex=rsUsedModels.getString("type");
					}
					String modelx="&nbsp;";
					if(rsUsedModels.getString("model") != null){
						modelx=rsUsedModels.getString("model");
					}
					String bpcsx="&nbsp;";
					if(rsUsedModels.getString("bpcs") != null){
						bpcsx=rsUsedModels.getString("bpcs");
					}
					String descriptionx="&nbsp;";
					if(rsUsedModels.getString("description") != null){
						descriptionx=rsUsedModels.getString("description");
					}
					String codex="&nbsp;";
					if(rsUsedModels.getString("code") != null){
						codex=rsUsedModels.getString("code");
					}
					String umx="&nbsp;";
					if(rsUsedModels.getString("um") != null){
						umx=rsUsedModels.getString("um");
					}
					String unit_weightx="0";
					if(rsUsedModels.getString("unit_weight") != null){
						unit_weightx=rsUsedModels.getString("unit_weight");
					}
					String muncyx="0";
					if(rsUsedModels.getString("muncy") != null){
						muncyx=rsUsedModels.getString("muncy");
					}
					String muncy_slx="0";
					if(rsUsedModels.getString("muncy_sl") != null){
						muncy_slx=rsUsedModels.getString("muncy_sl");
					}
					String int_bookx="0";
					if(rsUsedModels.getString("int_book") != null){
						int_bookx=rsUsedModels.getString("int_book");
					}
					String effective_datex="";
					if(rsUsedModels.getString("effective_date") != null){
						effective_datex=rsUsedModels.getString("effective_date").substring(0,10);
					}
					String metricx="0";
					if(rsUsedModels.getString("Metric") != null){
						metricx=rsUsedModels.getString("Metric");
					}
					String um_metricx="";
					if(rsUsedModels.getString("UM_Metric") != null){
						um_metricx=rsUsedModels.getString("UM_Metric");
					}
					String um_wgt_metricx="0";
					if(rsUsedModels.getString("UM_Wgt_Metric") != null){
						um_wgt_metricx=rsUsedModels.getString("UM_Wgt_Metric");
					}
					out.println("<tr>");
					out.println("<td width='5%'  >"+sbux+"</td>");
					out.println("<td width='13%'  >"+modelx+"</td>");
					out.println("<td width='12%'  >"+bpcsx+"</td>");
					out.println("<td width='37%' >"+descriptionx+"</td>");
					out.println("<td width='5%'  >"+umx+"</td>");
					out.println("<td width='6%'  align='right'>"+for1.format(new Double(unit_weightx).doubleValue())+"</td>");
					out.println("<td width='6%'  align='right'>"+for1.format(new Double(muncyx).doubleValue())+"</td>");
					out.println("<td width='6%'  align='right'>"+for1.format(new Double(muncy_slx).doubleValue())+"</td>");
					out.println("<td width='6%'  align='right'>"+for1.format(new Double(metricx).doubleValue())+"</td>");
					out.println("<td width='6%'  align='right'>"+um_metricx+"</td>");
					out.println("<td width='6%'  align='right'>"+for1.format(new Double(um_wgt_metricx).doubleValue())+"</td>");
					out.println("<td width='10%' >"+effective_datex+"</td>");
					out.println("</tr>");
				}
			}
			rsUsedModels.close();
			out.println("</table>");
			usedModels=usedModels+"#";
		}
		if(usedItems.trim().length()>0){
			%>
			<TABLE cellspacing=0 cellpadding=2 id=header width='1250px' border='1'>
				<tr>
					<td width='10%' bgcolor='lightgrey'>ITEM<BR>NUMBER</td>
					<td width='10%' bgcolor='lightgrey'>STOCK COST</td>
					<td width='10%' bgcolor='lightgrey'>BUSINESS UNIT</td>
					<td width='10%' bgcolor='lightgrey'>STOCK UOM</td>
					<td width='10%' bgcolor='lightgrey'>WEIGHT</td>
					<td width='10%' bgcolor='lightgrey'>INVENTORY QTY</td>
					<td width='20%' bgcolor='lightgrey'>ITEM DESCRIPTION</td>
					<td width='20%' bgcolor='lightgrey'>ITEM DESCRIPTION 2</td>

				</tr>
				<%
				if(usedItems.endsWith("#")){
					usedItems=usedItems.substring(0,usedItems.length()-1);
				}
				usedItems=usedItems.replaceAll("#","','");
				Vector sbux=new Vector();
				Vector codex=new Vector();
				Vector multix=new Vector();
				Vector intlMultix=new Vector();
				ResultSet rs0x=stmt.executeQuery("select sbu,code,muncy,east from cs_ic_multiplier where type='p' order by cast(code as integer)");
				if(rs0x != null){
					while(rs0x.next()){
						if(rs0x.getString(1).equals("EJC")){
							sbux.addElement("TPG");
						}
						else{
							sbux.addElement(rs0x.getString(1));
						}
						codex.addElement(rs0x.getString(2).substring(0,2));
						multix.addElement(rs0x.getString(3));
						if(rs0x.getString(4) != null && rs0x.getString(4).trim().length()>0){
							intlMultix.addElement(rs0x.getString(4));
						}
						else{
							intlMultix.addElement("0");
						}
					}
				}
				rs0x.close();
				String query2x="Select PRCITM,PRCCST,PRCSBU,PRCSUM,PRCWGT,PRCBAL,PRCDSC,PRCDS2 from CS_PRC001PF where PRCITM in ('"+usedItems+"') order by PRCSBU,PRCITM";
				//out.println(query2x);
				int count2=0;
				ResultSet rsUsedItems=stmt.executeQuery(query2x);
				if(rsUsedItems != null){
					//out.println("<tr>");
					while(rsUsedItems.next()){
						boolean isGood=false;
						String multiplier="";
						String intlMultiplier="";
						if(rsUsedItems.getString(3) != null &&(rsUsedItems.getString(3).equals("EFS")|rsUsedItems.getString(3).equals("IWP")|rsUsedItems.getString(3).equals("TPG"))|rsUsedItems.getString(3).equals("MS0")){
							for(int count=0; count<sbux.size(); count++){
								if(rsUsedItems.getString(3).equals(sbux.elementAt(count).toString()) && rsUsedItems.getString(1).substring(0,2).equals(codex.elementAt(count).toString())&& !isGood){
									multiplier=multix.elementAt(count).toString();
									intlMultiplier=intlMultix.elementAt(count).toString();
									isGood=true;
								}
								else if(!isGood && rsUsedItems.getString(3).equals(sbux.elementAt(count).toString())){
									multiplier=multix.elementAt(count).toString();
									intlMultiplier=intlMultix.elementAt(count).toString();
								}
							}
						}
						else{
							multiplier=multix.elementAt(1).toString();
							intlMultiplier=intlMultix.elementAt(1).toString();
						}
						count2++;
						for(int a=1; a<=8; a++){
							String align="";
							//count2++;
							if(a==2 | a==6 ){
								align="align='right'";
							}
							else{
								align="align='left'";
							}
							if(rsUsedItems.getString(a) != null && rsUsedItems.getString(a).trim().length()>0){
								String wth=" width='10%'";
								if(a==1){
									out.println("<input type='hidden' name='item' value='"+rsUsedItems.getString(a).trim()+"'>");
								}
								if(a==7 || a==8){
									wth=" width='20%'";
								}
								if(a==2){
									out.println("<td "+align+" "+wth+">"+for1.format(new Double(rsUsedItems.getString(a)).doubleValue() * new Double(multiplier).doubleValue())+"</td>");
								}
								else if(a==6){
									out.println("<td "+align+" "+wth+">"+for0.format(new Double(rsUsedItems.getString(a)).doubleValue())+"</td>");
								}
								else{
									out.println("<td "+align+" "+wth+">"+rsUsedItems.getString(a)+"</td>");
								}
							}
							else{
								out.println("<td>&nbsp;</td>");
							}
						}
						out.println("</tr>");
					}
					out.println("</table>");
				}
				rsUsedItems.close();
				//stmt_bpcsusr.close();
				out.println("</table>");
				usedItems=usedItems+"#";
			}
			if(usedItems.trim().length()>0 || usedModels.trim().length()>0){
				out.println("<input type='button' name='print_saved' value='Save table to print' onclick='print()'>");
				out.println("<input type='button' name='Export to Excel' value='Export to Excel' onclick='toExcel()'>");
			}
			//out.println("<input type='button' name='export to PDF' value='Export Models to PDF' onclick='pdf()'>");
			//out.println("<input type='button' name='export to PDF' value='Export Parts to PDF' onclick='pdf2()'>");
			out.println("<input type='button' name='export to Excel' value='Export All Models to Excel' onclick='excel1()'>");
			out.println("<input type='button' name='export to Excel' value='Export All Parts to Excel' onclick='excel2()'>");
			out.println("</div>");
			out.println("<div id='0'>");
			out.println("<table align=center border=0 cellspacing='1' cellpadding='2'><tr><td>&nbsp;<BR><select name='mode' size =1>");
			String selected="";
			if(mode.equals("MODEL")){
				selected="selected";
			}
			out.println("<option value='MODEL' "+selected+">MODEL</OPTION>");
			selected="";
			if(mode.equals("PART")){
				selected="selected";
			}
			out.println("<OPTION VALUE='PART' "+selected+">PART</OPTION>");
			if(param == null || param.equals("null")){
				param="";
			}
			out.println("</select>");
			selected="";
			if(method==null){
				method="";
			}
			out.println("</td><td>&nbsp;<BR><select name='method' size =1>");
			if(method.equals("NUMBER")){
				selected="selected";
			}
			out.println("<option value='NUMBER' "+selected+">NUMBER</Option>");
			selected="";
			if(method.equals("DESC")){
				selected="selected";
			}
			out.println("<option value='DESC' "+selected+">DESCRIPTION</option");
			out.println("</select>");
			out.println("<input type='hidden' name='country' value='"+country+"'>");
			out.println("</TD>");
			selected="";
			out.println("<td>SBU:</td>");
			out.println("<td>&nbsp;<BR><select name='sbu' size =1>");

			if(sbuSearch.trim().length()==0){
				selected="selected";
			}
			out.println("<option value='' "+selected+">ALL</option>");
			selected="";
			if(sbuSearch.equals("EFS")){
				selected="selected";
			}
			out.println("<option value='EFS' "+selected+">EFS</option>");
			selected="";
			if(sbuSearch.equals("EJC")){
				selected="selected";
			}
			out.println("<option value='EJC' "+selected+">EJC</option>");
			selected="";
			if(sbuSearch.equals("IWP")){
				selected="selected";
			}
			out.println("<option value='IWP' "+selected+">IWP</option>");
			selected="";
			if(sbuSearch.equals("LVR")){
				selected="selected";
			}
			if(country.equals("Asia")){
				out.println("<option value='LVR' "+selected+">LVR</option>");
			}
			selected="";
			out.println("</select>");
			out.println("</TD>");
			out.println("<td>Search for:</td>");
			out.println("<td width='15%'><input type='radio' name='group1' value='and' "+andChecked+">AND<input type='radio' name='group1' value='or' "+orChecked+">OR<BR><input type=text name='param' size=15 value='"+param+"'></td>");
			out.println("<td width='15%'>&nbsp;<BR><input type=submit value='SUBMIT'></td>");
			out.println("</tr></table>");
			out.println("<input type='hidden' name='usedModels' value='"+usedModelsString+"'>");
			out.println("<input type='hidden' name='usedItems' value='"+usedItemsString+"'>");
			if(usedModelsString != null && usedModelsString.trim().length()>0){
				BufferedWriter out1 = new BufferedWriter(new FileWriter("D:\\erapid\\shared\\\\usedModelsString"+sessionId+".txt"));
				out1.write(usedModelsString);
				out1.flush();
				out1.close();
			}
			if(usedItemsString != null && usedItemsString.trim().length()>0){
				BufferedWriter out1 = new BufferedWriter(new FileWriter("D:\\erapid\\shared\\\\usedItemsString"+sessionId+".txt"));
				out1.write(usedItemsString);
				out1.flush();
				out1.close();
			}
			out.println("</form>");
			out.println("<form name='form2'>");
			out.println("</div>");
			//Greg Suisham - CS Group
			//mode which is a number for the table is passed in threw the url, as well as the string we are searching the table for
			//this is page check the url mode attribute and given the results runs a specific query with a specific table header
			//get variables for url
			if(!mode.equals("PART")){
				out.println("<input type='hidden' name='model' value=''>");
				String tempmodels="";
				%>

				<DIV STYLE="overflow: auto; height: 700;border-left: 0px gray solid; border-bottom: 0px gray solid;padding:0px; margin: 0px" id='1'>
					<TABLE cellspacing=0 cellpadding=2 id=header width='1250px' border='1'>
						<tr>
							<td width='5%'  bgcolor='lightgrey'>SBU</td>
							<td width='13%'  bgcolor='lightgrey'>MODEL</td>
							<td width='12%'  bgcolor='lightgrey'>BPCS</td>
							<td width='37%' bgcolor='lightgrey'>DESC</td>
							<td width='5%'  bgcolor='lightgrey'>UM</td>
							<td width='6%'  bgcolor='lightgrey'>UNIT WEIGHT</td>
							<td width='6%'  bgcolor='lightgrey'>IC PRICE</td>
							<td width='6%'  bgcolor='lightgrey'>SAMPLE PRICE</td>
							<td width='6%' bgcolor='lightgrey'>METRIC</td>
							<td width='6%' bgcolor='lightgrey'>UM METRIC</td>
							<td width='6%' bgcolor='lightgrey'>UNIT WEIGHT METRIC</td>
							<td width='10%' bgcolor='lightgrey'>EFFECTIVE DATE<BR><input type='button' name='save all' value='save all' onclick='saveAll()'></td>
						</tr>
						<%
						try{
							if(param.trim().length() > 0){
								String query="";

								if(method.equals("DESC")){
									query="Select * from cs_ic_price where "+paramQuery+" order by sbu,model";
								}
								else{
									query="Select * from cs_ic_price where "+paramQuery+" order by sbu,model";
								}
								
								int count=0;
								ResultSet rs1=stmt.executeQuery(query);
								if (rs1 !=null) {
									while(rs1.next()){
										String sbu="&nbsp;";
										if(rs1.getString("sbu") != null){
											sbu=rs1.getString("sbu");
										}
										String type="&nbsp;";
										if(rs1.getString("type") != null){
											type=rs1.getString("type");
										}
										String model="&nbsp;";
										if(rs1.getString("model") != null){
											model=rs1.getString("model");
										}
										String bpcs="&nbsp;";
										if(rs1.getString("bpcs") != null){
											bpcs=rs1.getString("bpcs");
										}
										String description="&nbsp;";
										if(rs1.getString("description") != null){
											description=rs1.getString("description");
										}
										String code="&nbsp;";
										if(rs1.getString("code") != null){
											code=rs1.getString("code");
										}
										String um="&nbsp;";
										if(rs1.getString("um") != null){
											um=rs1.getString("um");
										}
										String unit_weight="0";
										if(rs1.getString("unit_weight") != null){
											unit_weight=rs1.getString("unit_weight");
										}
										String muncy="0";
										if(rs1.getString("muncy") != null){
											muncy=rs1.getString("muncy");
										}
										String muncy_sl="0";
										if(rs1.getString("muncy_sl") != null){
											muncy_sl=rs1.getString("muncy_sl");
										}
										String int_book="0";
										//out.println(rs1.getString("int_book")+"::HERE");
										if(rs1.getString("int_book") != null){
											int_book=rs1.getString("int_book");
										}
										String effective_date="";
										if(rs1.getString("effective_date") != null){
											effective_date=rs1.getString("effective_date").substring(0,10);
										}
										String metric="0";
										if(rs1.getString("Metric") != null){
											metric=rs1.getString("Metric");
										}
										String um_metric="";
										if(rs1.getString("UM_Metric") != null){
											um_metric=rs1.getString("UM_Metric");
										}
										String um_wgt_metric="0";
										if(rs1.getString("UM_Wgt_Metric") != null){
											um_wgt_metric=rs1.getString("UM_Wgt_Metric");
										}
										out.println("<tr>");
										out.println("<td width='5%'  >"+sbu+"</td>");
										out.println("<td width='13%'  >"+model+"</td>");
										tempmodels=tempmodels+model+"#";
										out.println("<input type='hidden' name='model' value='"+model+"'>");
										out.println("<td width='12%'  >"+bpcs+"</td>");
										out.println("<td width='37%' >"+description+"</td>");
										out.println("<td width='5%'  >"+um+"</td>");
										out.println("<td width='6%'  align='right'>"+for1.format(new Double(unit_weight).doubleValue())+"</td>");
										out.println("<td width='6%'  align='right'>"+for1.format(new Double(muncy).doubleValue())+"</td>");
										out.println("<td width='6%'  align='right'>"+for1.format(new Double(muncy_sl).doubleValue())+"</td>");
										out.println("<td width='6%'  align='right'>"+for1.format(new Double(metric).doubleValue())+"</td>");
										out.println("<td width='6%'  align='right'>"+um_metric+"</td>");
										out.println("<td width='6%'  align='right'>"+for1.format(new Double(um_wgt_metric).doubleValue())+"</td>");
										count++;
										out.println("<td width='10%' >"+effective_date+"<input type='button' name='save' value='save' onclick=\"saveThis('"+count+"')\"></td>");
										out.println("</tr>");
									}
								}
								rs1.close();


							}
						}
						catch (Exception e){
							out.println ("Error connecting to Database  ::  " + e);
						}
						%>
					</table></div>
					<%
					out.println("<input type='hidden' name='tempmodels' value='"+tempmodels+"'>");

				}
				else{
					out.println("<input type='hidden' name='item' value=''>");
					Vector sbu=new Vector();
					Vector code=new Vector();
					Vector multi=new Vector();
					Vector intlMulti=new Vector();
					String tempitems="";
					ResultSet rs0=stmt.executeQuery("select sbu,code,muncy,east from cs_ic_multiplier where type='p' order by cast(code as integer)");
					if(rs0 != null){
						while(rs0.next()){
							if(rs0.getString(1).equals("EJC")){
								sbu.addElement("TPG");
							}
							else{
								sbu.addElement(rs0.getString(1));
							}
							code.addElement(rs0.getString(2).substring(0,2));
							multi.addElement(rs0.getString(3));
							if(rs0.getString(4) != null && rs0.getString(4).trim().length()>0){
								intlMulti.addElement(rs0.getString(4));
							}
							else{
								intlMulti.addElement("0");
							}
						}
					}
					rs0.close();
					//stmt.close();
					%>
				<DIV STYLE=" border-left: 0px gray solid; border-bottom: 0px gray solid;padding:0px; margin: 0px" id='2'>
					<TABLE cellspacing=0 cellpadding=2 id=header width='1250px' border='0'>
						<tr>
							<td width='10%' bgcolor='lightgrey'>ITEM<BR>NUMBER</td>
							<td width='8%' bgcolor='lightgrey'>STOCK COST</td>
							<td width='8%' bgcolor='lightgrey'>BUSINESS UNIT</td>
							<td width='8%' bgcolor='lightgrey'>STOCK UOM</td>
							<td width='10%' bgcolor='lightgrey'>WEIGHT</td>
							<td width='10%' bgcolor='lightgrey'>INVENTORY QTY</td>
							<td width='20%' bgcolor='lightgrey'>ITEM DESCRIPTION</td>
							<td width='20%' bgcolor='lightgrey'>ITEM DESCRIPTION 2</td>
							<td width='6%' bgcolor='lightgrey'><input type='button' name='save all' value='save all' onclick='saveAll2()'></td>
						</tr>
					</TABLE>
				</div>
				<DIV STYLE="overflow: auto; height: 700;border-left: 0px gray solid; border-bottom: 0px gray solid;padding:0px; margin: 0px" id='3'>
					<TABLE cellspacing=0 cellpadding=2 BORDER='1'  width='1250px'>
						<%
						String query2="";

						try{
							if(param.trim().length() >= 3){
								query2="";
								if(method.equals("DESC")){
									query2="Select PRCITM,PRCCST,PRCSBU,PRCSUM,PRCWGT,PRCBAL,PRCDSC,PRCDS2 from CS_PRC001PF where "+paramQuery.toUpperCase()+" order by PRCSBU,PRCITM";
								}
								else{
									query2="Select PRCITM,PRCCST,PRCSBU,PRCSUM,PRCWGT,PRCBAL,PRCDSC,PRCDS2 from CS_PRC001PF where "+paramQuery.toUpperCase()+" order by PRCSBU,PRCITM";
								}
								int count2=0;
								ResultSet rs1=stmt.executeQuery(query2);
								if(rs1 != null){
									out.println("<tr>");
									while(rs1.next()){
										boolean isGood=false;
										String multiplier="";
										String intlMultiplier="";
										if(rs1.getString(3) != null &&(rs1.getString(3).equals("EFS")|rs1.getString(3).equals("IWP")|rs1.getString(3).equals("TPG"))|rs1.getString(3).equals("MS0")){
											for(int count=0; count<sbu.size(); count++){
												if(rs1.getString(3).equals(sbu.elementAt(count).toString()) && rs1.getString(1).substring(0,2).equals(code.elementAt(count).toString())&& !isGood){
													multiplier=multi.elementAt(count).toString();
													intlMultiplier=intlMulti.elementAt(count).toString();
													isGood=true;
												}
												else if(!isGood && rs1.getString(3).equals(sbu.elementAt(count).toString())){
													multiplier=multi.elementAt(count).toString();
													intlMultiplier=intlMulti.elementAt(count).toString();
												}
												//out.println(sbu.elementAt(count).toString()+"::<BR>");
											}
										}
										else{
											//multiplier=multi.elementAt(1).toString();
											intlMultiplier=intlMulti.elementAt(1).toString();
											//out.println(multiplier+"::"+intlMultiplier+"::<BR>");
											multiplier="1.2";

										}
										count2++;
										for(int a=1; a<=8; a++){
											String align="";
											//count2++;
											if(a==2 | a==6 ){
												align="align='right'";
											}
											else{
												align="align='left'";
											}
											if(rs1.getString(a) != null && rs1.getString(a).trim().length()>0){
												String wth=" width='10%'";
												if(a==1){
													out.println("<input type='hidden' name='item' value='"+rs1.getString(a).trim()+"'>");
													tempitems=tempitems+rs1.getString(a).trim()+"#";
												}
												if(a==7 || a==8){
													wth=" width='20%'";
												}
												if(a==2||a==3||a==4){
													wth=" width='8%'";
												}
												if(a==2){
													out.println("<td "+align+" "+wth+">"+for1.format(new Double(rs1.getString(a)).doubleValue() * new Double(multiplier).doubleValue())+"</td>");
												}
												else if(a==6){
													out.println("<td "+align+" "+wth+">"+for0.format(new Double(rs1.getString(a)).doubleValue())+"</td>");
												}
												else{
													out.println("<td "+align+" "+wth+">"+rs1.getString(a)+"</td>");
												}
											}
											else{
												out.println("<td>&nbsp;</td>");
											}
										}
										out.println("<td width='6%'><input type='button' name='save' value='save' onclick=\"saveThis2('"+count2+"')\"></td>");
										out.println("</tr>");
									}
									out.println("</table>");
								}
								rs1.close();
								//stmt_bpcsusr.close();
							}
							else{
								out.println("please enter at least 3 characters!");
							}
							//con_bpcsusr.close();

						}
						catch (Exception e){
							out.println ("Error connecting to Database  ::  " + e+"<BR>"+query2);
						}
						out.println("</div>");
						out.println("<input type='hidden' name='tempitems' value='"+tempitems+"'>");
					}

				//}
			//}
			//else{
			//	out.println("<font color='red' size='6'>Access this page through Erapid only</font>");
			//}

		//}
		//else{
		//	out.println("<font color='red' size='6'>Access this page through Erapid only</font>");
		//}
		stmt.close();
		myConn.close();
						%>
						</form>
						</body>
						</html>
						<%
						}
						  catch(Exception e){
							out.println("ERROR::"+e);
						  }
						%>