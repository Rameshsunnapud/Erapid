<%@ page language="java" import="java.sql.*" import="java.text.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<SCRIPT language="JavaScript">

	function n_window(theurl){
		var the_width=450;
		var the_height=400;
		var from_top=180;
		var from_left=200;
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
		window.open(theurl,'myWindowxx',the_atts);
	}
	function checkWindow(){
		if(window.myWindow){
			if(myWindow&&typeof (myWindow.closed)!='unknown'&&!myWindow.closed){
				myWindow.form1.url.value=document.formRTF.url.value;
				myWindow.form1.order_no.value=document.formRTF.order_no.value;
				myWindow.form1.isHeader.value="TRUE";
				myWindow.form1.isFooter.value="TRUE";
				myWindow.form1.displaypage.value="Y";
				myWindow.form1.output.value="RTF";
			}
			else{
				setTimeout("checkWindow();",1000);
			}
		}
		else{
			setTimeout("checkWindow();",1000);
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
		myWindow=window.open(theurl,'myWindow',the_atts);
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
	}
</script>
<html>
	<header>
		<title>
			Shop paper
		</title>
	</header>
	<body>
		<%
		String order_no=request.getParameter("orderNo");

		%>
		<table><tr><td align='left'>
					<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='Packing List' value='Packing list edit' onclick='n_window("https://<%=application.getInitParameter("HOST")%>/erapid/us/orders/shoppaper/shoppaper_edit.jsp?order_no=<%=order_no%>")'>
					<%
					out.println("</tr><tr><td align='left'><form name='formRTF' action='https://"+ application.getInitParameter("HOST")+"/custom/quotes/convertor/convertor.jsp' method='post'>");
					out.println("<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='rtf' value='Packing List Word' onclick='goRtf()'>");
					out.println("<input type='hidden' name='output' value='RTF'>");
					out.println("<input type='hidden' name='order_no' value='"+order_no+"'>");
					out.println("<input type='hidden' name='isHeader' value=''>");
					out.println("<input type='hidden' name='url' value='https://"+application.getInitParameter("HOST")+"/erapid/us/orders/shoppaper/shoppaper_main.jsp?order_no="+order_no+"&type=word'>");
					out.println("</td>");
					out.println("</form>");
					%>
			<tr><td align='left'>
					<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='Packing List' value='Packing list' onclick='n_window("https://<%=application.getInitParameter("HOST")%>/erapid/us/orders/shoppaper/shoppaper_main.jsp?order_no=<%=order_no%>")'>
				</td></tr>




			<tr><td align='left'>
					NEW REPORTS<BR>
					<%
					if(application.getInitParameter("HOST").toUpperCase().indexOf("DEV")>=0){
					%>
					<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='Assembly Sheet' value='Assembly Sheet' onclick='n_window("http://reportsbak.c-sgroup.com/ReportServer_DEV/Pages/ReportViewer.aspx?/ShopPapers/AssemblySheet&QuoteNo=<%=order_no%>&rs:Format=excel")'><BR>
					<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='Cut List' value='Cut List' onclick='n_window("http://reportsbak.c-sgroup.com/ReportServer_DEV/Pages/ReportViewer.aspx?/ShopPapers/CutList&QuoteNo=<%=order_no%>&rs:Format=excel")'><BR>
					<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='Finishing Sheet' value='Finishing Sheet' onclick='n_window("http://reportsbak.c-sgroup.com/ReportServer_DEV/Pages/ReportViewer.aspx?/ShopPapers/FinishingSheet&QuoteNo=<%=order_no%>&rs:Format=excel")'><BR>
					<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='Routing' value='Routing' onclick='n_window("http://reportsbak.c-sgroup.com/ReportServer_DEV/Pages/ReportViewer.aspx?/ShopPapers/Routing&QuoteNo=<%=order_no%>&rs:Format=excel")'><BR>
					<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='Screen Sheet' value='Screen Sheet' onclick='n_window("http://reportsbak.c-sgroup.com/ReportServer_DEV/Pages/ReportViewer.aspx?/ShopPapers/ScreenSheet&QuoteNo=<%=order_no%>&rs:Format=excel")'><BR>
					<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='Shear' value='Shear' onclick='n_window("http://reportsbak.c-sgroup.com/ReportServer_DEV/Pages/ReportViewer.aspx?/ShopPapers/Shear&QuoteNo=<%=order_no%>&rs:Format=excel")'><BR>
					<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='All' value='All' onclick='n_window("http://reportsbak.c-sgroup.com/ReportServer_DEV/Pages/ReportViewer.aspx?/ShopPapers/AllReports&QuoteNo=<%=order_no%>&rs:Format=excel")'><BR>
					<%
				}
				else{
					%>
					<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='Assembly Sheet' value='Assembly Sheet' onclick='n_window("http://reports.c-sgroup.com/ReportServer/Pages/ReportViewer.aspx?/ShopPaper/AssemblySheet&QuoteNo=<%=order_no%>&rs:Format=excel")'><BR>
					<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='Cut List' value='Cut List' onclick='n_window("http://reports.c-sgroup.com/ReportServer/Pages/ReportViewer.aspx?/ShopPaper/CutList&QuoteNo=<%=order_no%>&rs:Format=excel")'><BR>
					<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='Finishing Sheet' value='Finishing Sheet' onclick='n_window("http://reports.c-sgroup.com/ReportServer/Pages/ReportViewer.aspx?/ShopPaper/FinishingSheet&QuoteNo=<%=order_no%>&rs:Format=excel")'><BR>
					<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='Routing' value='Routing' onclick='n_window("http://reports.c-sgroup.com/ReportServer/Pages/ReportViewer.aspx?/ShopPaper/Routing&QuoteNo=<%=order_no%>&rs:Format=excel")'><BR>
					<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='Screen Sheet' value='Screen Sheet' onclick='n_window("http://reports.c-sgroup.com/ReportServer/Pages/ReportViewer.aspx?/ShopPaper/ScreenSheet&QuoteNo=<%=order_no%>&rs:Format=excel")'><BR>
					<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='Shear' value='Shear' onclick='n_window("http://reports.c-sgroup.com/ReportServer/Pages/ReportViewer.aspx?/ShopPaper/Shear&QuoteNo=<%=order_no%>&rs:Format=excel")'><BR>
					<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='All' value='All' onclick='n_window("http://reports.c-sgroup.com/ReportServer/Pages/ReportViewer.aspx?/ShopPaper/AllReports&QuoteNo=<%=order_no%>&rs:Format=excel")'><BR>
					<%
				}
					%>
				</td></tr>