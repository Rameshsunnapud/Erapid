<html>
<head>
	<title><%= titl %></title>
	<link rel='stylesheet' href='craft.css' type='text/css' />
<SCRIPT language="JavaScript">
<!--
function n_window(theurl)
{
// set width and height
var the_width=900;
var the_height=400;
// set window position
var from_top=250;
var from_left=20;
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
window.open(theurl,'',the_atts);
}
//-->
</SCRIPT> 

</head>
<body>
<%

HttpSession UserSession = request.getSession();
//out.println(UserSession.isNew()):
String usergroup="";

if(UserSession.getValue("usergroup") != null){
	usergroup=UserSession.getValue("usergroup").toString();
}
//out.println(usergroup+":: USER GROUP");
if(usergroup==null){
	usergroup="";
}	
%>
<TABLE bgColor=#f1f1f1 cellSpacing=0 cellPadding=0 class='nob' width="100%" border=0>
  <tr>
	    <td valign="top" height='60' bgcolor="#330099"><img src="images/img_logo.jpg" border="0" alt="" width="797" height="68">&nbsp;</td>
		<td height="60" valign="top" bgcolor="#330099"><IMG height=1 src="" width=175>&nbsp;</td>
 </TR>
 <TR>
		 <TD colspan='2' class='test'>&nbsp;</TD>
 </TR>
 <TR><td valign="top" colspan='2'>
		 <table border='0' bgColor=#f1f1f1 cellSpacing=0 cellPadding=0 class='nob1' width="100%">
			<tr> 
<!--				<TD vAlign=bottom bgColor='#999999'  class='testb' noWrap align=middle>&nbsp;&nbsp;<a href="search1.html">Search</a>&nbsp;&nbsp;</TD>
				<TD noWrap width=1 bgColor=#e1e1e1><IMG height=1 src="" width=1></TD>-->
<% 			//	if (!usergroup.startsWith("EFS")){%>
				<TD vAlign=bottom bgColor='#999999'  class='testb' noWrap align=middle>&nbsp;&nbsp;<a href="/custom/orders/efs/shop.home.jsp?sp-q=<%= order_no %>&eh-q=2">Shop Header</a>&nbsp;&nbsp;</TD>
				<TD noWrap width=1 bgColor=#e1e1e1><IMG height=1 src="" width=3></TD>
<%
			//	}
String pager="";
			if(cmd.equals("1")){
				out.println("<TD vAlign=bottom noWrap align=middle>&nbsp;&nbsp;"+ titl+"&nbsp;&nbsp;</TD>");
				}
			else	{
			out.println("<TD bgColor='#999999' class='testb' vAlign=bottom noWrap align=middle>&nbsp;&nbsp;<a href='shop.transfer.jsp?sp-q="+order_no+"&cmd=1&t-s=hed"+"'>Hardware List Summary </a>&nbsp;&nbsp;</TD>");
					}
					
				 %>

				<TD noWrap width=1 bgColor=#e1e1e1><IMG height=1 src="" width=3></TD>
	<%			if(cmd.equals("2")){
				out.println("<TD vAlign=bottom noWrap align=middle>&nbsp;&nbsp;"+ titl+"&nbsp;&nbsp;</TD>");

				}
			else	{
			out.println("<TD bgColor='#999999' class='testb' vAlign=bottom noWrap align=middle>&nbsp;&nbsp;<a href='shop.transfer.jsp?sp-q="+order_no+"&cmd=2&t-s=hed"+"'>Inventory Relief Summary</a>&nbsp;&nbsp;</TD>");
					}
					
				 %>

				<TD noWrap width=1 bgColor=#e1e1e1><IMG height=1 src="" width=3></TD>				
	<%			if(cmd.equals("3")){
				out.println("<TD vAlign=bottom noWrap align=middle>&nbsp;&nbsp;"+ titl+"&nbsp;&nbsp;</TD>");

				}
			else	{
			out.println("<TD bgColor='#999999' class='testb' vAlign=bottom noWrap align=middle>&nbsp;&nbsp;<a href='shop.transfer.jsp?sp-q="+order_no+"&cmd=3&t-s=hed"+"'>Cut Sheet/Assembly Sheet</a>&nbsp;&nbsp;</TD>");
					}
					
				 %>
				<TD noWrap width=1 bgColor=#e1e1e1><IMG height=1 src="" width=3></TD>				
	<%			if(cmd.equals("10")){
				out.println("<TD vAlign=bottom noWrap align=middle>&nbsp;&nbsp;"+ titl+"&nbsp;&nbsp;</TD>");
				}
			else	{
			out.println("<TD bgColor='#999999' class='testb' vAlign=bottom noWrap align=middle>&nbsp;&nbsp;<a href='shop.transfer.jsp?sp-q="+order_no+"&cmd=10&t-s=hed"+"'>Operations Summary</a>&nbsp;&nbsp;</TD>");
					}
					
				 %>
				 
				 <TD noWrap width=1 bgColor=#e1e1e1><IMG height=1 src="" width=3></TD>
	<%			if(cmd.equals("4")){
				out.println("<TD vAlign=bottom noWrap align=middle>&nbsp;&nbsp;"+ titl+"&nbsp;&nbsp;</TD>");
				}
			else	{
			out.println("<TD bgColor='#999999' class='testb' vAlign=bottom noWrap align=middle>&nbsp;&nbsp;<a href='shop.transfer.jsp?sp-q="+order_no+"&cmd=4&t-s=hed"+"'>Packing List</a>&nbsp;&nbsp;</TD>");
					}
					
				 %>				 
				 <TD noWrap width=1 bgColor=#e1e1e1><IMG height=1 src="" width=3></TD>	
				 
	<%	
	
	if(usergroup.equals("admins") ||usergroup.equals("CanLayout") ||usergroup.equals("CanDev")){
		if(cmd.equals("40")){
			out.println("<TD vAlign=bottom noWrap align=middle>&nbsp;&nbsp;"+ titl+"&nbsp;&nbsp;</TD>");
		}
		else{
			out.println("<TD bgColor='#999999' class='testb' vAlign=bottom noWrap align=middle>&nbsp;&nbsp;<a href='shop.transfer.jsp?sp-q="+order_no+"&cmd=40&t-s=hed"+"'>Canadian Packing List</a>&nbsp;&nbsp;</TD>");
		}
		if(cmd.equals("41")){
			out.println("<TD vAlign=bottom noWrap align=middle>&nbsp;&nbsp;"+ titl+"&nbsp;&nbsp;</TD>");
		}
		else{
			out.println("<TD bgColor='#999999' class='testb' vAlign=bottom noWrap align=middle>&nbsp;&nbsp;<a href='shop.transfer.jsp?sp-q="+order_no+"&cmd=41&t-s=hed"+"'>Canadian Packing List Back Order</a>&nbsp;&nbsp;</TD>");
		}		
	}	
	
				 %>				 
				 <TD noWrap width=1 bgColor=#e1e1e1><IMG height=1 src="" width=3></TD>					 
				<TD width="42%" bgColor='#999999' align='right'><IMG height=1 src="" width=1><a href="javascript:n_window('https://<%= application.getInitParameter("HOST")%>/custom/orders/efs/shop.transfer.jsp?sp-q=<%= order_no %>&cmd=5')" >All Reports</a></TD>				 
				<TD width="58%" bgColor='#999999' align='right'><IMG height=1 src="" width=1><a href="javascript:n_window('https://<%= application.getInitParameter("HOST")%>/custom/orders/efs/shop.transfer.jsp?sp-q=<%= order_no %>&cmd=<%= cmd %>')" >Printable version</a></TD>
			</tr>					
		 </table>
	 </td>					
</TR>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td align='center'>CONSTRUCTION SPECIALTIES, INC.<br>6696 ROUTE 405 HWY.<br>MUNCY, PA 17756</td>
</tr>
<tr>
	<td align='center'>&nbsp;</td>
</tr>

<tr>
	<td align="left" valign="top" >
		<table width='20%' border='0' cellspacing="0" cellpadding="0">
			<tr><td nowrap><h1><%= titl %></h1></td></tr>
		</table>
	</td>
</tr>
<tr>
	<td align="center" valign="top">&nbsp;</td>
</tr>

<tr>
<td align='center'>		
			<table width="95%" border="0" cellspacing="0" cellpadding="0" align="center">
						<tr>
							<td width='15%' align='right'><b>Job no#&nbsp;&nbsp;</b></td>
							<td width='55%' align='left'><%= bpcs_no %></td>
							<td width='15%' align='right'><b>Date:&nbsp;&nbsp;</b></td>
							<td width='15%' align='left'><%= sDate %></td>
						</tr>
						<tr>
							<td align='right'><b>Job Name:&nbsp;&nbsp;</b></td>
							<td align='left'><%= project_name %></td>							
							<td align='right'><b>Date Due:&nbsp;&nbsp;</b></td>
							<td align='left'><%= due_date %></td>							
						</tr>
						<tr>
							<td align='right'><b>Planner:</b>&nbsp;&nbsp;</td>
							<td align='left'><%= planner %></td>							
							<td align='right'><b>CSE Order no:&nbsp;&nbsp;</b></td>
							<td align='left'><%= order_no %></td>							
						</tr>
						
			</table>
</td>
</tr>
<tr>
	<td>&nbsp;<hr></td>
</tr>

