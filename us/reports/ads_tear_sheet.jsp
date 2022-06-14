<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<html>
	<head>
		<title>ADS</title>
		<script language="JavaScript" src="date-picker.js"></script>
		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>
	<body>
		<%@ page language="java" import="java.sql.*" import="java.net.*" import="java.io.*" import="java.util.*" errorPage="error.jsp" %>
		<%@ include file="../../db_con.jsp"%>
		<%
		String order_no=request.getParameter("orderNo");
		String doc_type="";
		//HttpSession UserSession1 = request.getSession();
		//String name=UserSession1.getAttribute("username").toString();
		String name=request.getParameter("username");
		String pname="";
		String ploc="";
		String pcontr="";
		String pagent="";
		String pstate="";

		ResultSet rs_docheader=stmt.executeQuery("select doc_type from doc_header where doc_number like '"+order_no+"'");
		if(rs_docheader != null){
			while(rs_docheader.next()){
				doc_type=rs_docheader.getString(1);
			}
		}
		rs_docheader.close();

		ResultSet myResultp=stmt.executeQuery("SELECT * FROM cs_project where Order_no ='"+order_no+"' " );
		if (myResultp !=null){
			while (myResultp.next()){
				pname=myResultp.getString("Project_name");
				ploc=myResultp.getString("Job_loc");
				pcontr=myResultp.getString("Cust_loc");
				pstate=myResultp.getString("project_state");
				pagent=myResultp.getString("Creator_id");
			}
		}
		myResultp.close();

		java.util.Date uDate = new java.util.Date();
		java.sql.Date sDate = new java.sql.Date(uDate.getTime());

		Vector line_no=new Vector();
		Vector mark=new Vector();
		Vector qty=new Vector();
		Vector door=new Vector();
		Vector kp=new Vector();
		Vector push=new Vector();
		Vector pull=new Vector();
		Vector he=new Vector();
		Vector le=new Vector();
		Vector th=new Vector();
		Vector opening=new Vector();
		Vector door_no=new Vector();
		Vector cvr=new Vector();
		Vector ast=new Vector();
		Vector aswing=new Vector();
		Vector ahmfr=new Vector();
		Vector ahmfrn=new Vector();
		Vector ahtemp=new Vector();
		Vector ahtype=new Vector();
		Vector ahhgt=new Vector();
		Vector ahthick=new Vector();
		Vector ahbs=new Vector();
		Vector ahqty=new Vector();
		Vector ahh1=new Vector();
		Vector ahh2=new Vector();
		Vector ahh3=new Vector();
		Vector ahh4=new Vector();
		Vector asize=new Vector();
		Vector aemfr=new Vector();
		Vector aemfrn=new Vector();
		Vector aetemp=new Vector();
		Vector aetype=new Vector();
		Vector aepw=new Vector();
		Vector aeph=new Vector();
		Vector aelpl=new Vector();
		Vector aedia=new Vector();
		Vector aebs=new Vector();
		Vector aeed=new Vector();
		Vector dbmfr=new Vector();
		Vector dbmfrn=new Vector();
		Vector dbtemp=new Vector();
		Vector dbpw=new Vector();
		Vector dbph=new Vector();
		Vector dbdb =new Vector();
		Vector dbdia=new Vector();
		Vector dbbs=new Vector();
		Vector ach=new Vector();
		Vector acw=new Vector();
		Vector act=new Vector();
		Vector ace=new Vector();
		Vector alfk=new Vector();
		Vector iswing=new Vector();
		Vector ihmfr=new Vector();
		Vector ihmfrn=new Vector();
		Vector ihtemp=new Vector();
		Vector ihtype=new Vector();
		Vector ihhgt=new Vector();
		Vector ihthick=new Vector();
		Vector ihbs=new Vector();
		Vector ihqty=new Vector();
		Vector ihh1=new Vector();
		Vector ihh2=new Vector();
		Vector ihh3=new Vector();
		Vector ihh4=new Vector();
		Vector isize=new Vector();
		Vector iemfr=new Vector();
		Vector iemfrn=new Vector();
		Vector ietemp=new Vector();
		Vector ietype=new Vector();
		Vector ielpw=new Vector();
		Vector ielph=new Vector();
		Vector ielpl=new Vector();
		Vector iedia=new Vector();
		Vector iebs=new Vector();
		Vector ieed=new Vector();
		Vector ich=new Vector();
		Vector icw=new Vector();
		Vector ict=new Vector();
		Vector ice=new Vector();
		Vector ilfk=new Vector();
		Vector image_path = new Vector();
		Vector stile = new Vector();

		ResultSet rs1=stmt.executeQuery("select * from cs_ads_output where order_no='"+order_no+"'");
		if(rs1 != null){
			while(rs1.next()){
				line_no.addElement(rs1.getString("line_no"));
				mark.addElement("&nbsp;"+rs1.getString("mark"));
				qty.addElement("&nbsp;"+rs1.getString("qty"));
				door.addElement("&nbsp;"+rs1.getString("door"));
				kp.addElement("&nbsp;"+rs1.getString("kp"));
				push.addElement("&nbsp;"+rs1.getString("push"));
				pull.addElement("&nbsp;"+rs1.getString("pull"));
				he.addElement("&nbsp;"+rs1.getString("he"));
				le.addElement("&nbsp;"+rs1.getString("le"));
				th.addElement("&nbsp;"+rs1.getString("th"));
				opening.addElement("&nbsp;"+rs1.getString("opening"));
				door_no.addElement("&nbsp;"+rs1.getString("door_no"));
				cvr.addElement("&nbsp;"+rs1.getString("cvr"));
				ast.addElement("&nbsp;"+rs1.getString("ast"));
				aswing.addElement("&nbsp;"+rs1.getString("aswing"));
				ahmfr.addElement("&nbsp;"+rs1.getString("ahmfr"));
				ahmfrn.addElement("&nbsp;"+rs1.getString("ahmfrn"));
				ahtemp.addElement("&nbsp;"+rs1.getString("ahtemp"));
				ahtype.addElement("&nbsp;"+rs1.getString("ahtype"));
				ahhgt.addElement("&nbsp;"+rs1.getString("ahhgt"));
				ahthick.addElement("&nbsp;"+rs1.getString("ahthick"));
				ahbs.addElement("&nbsp;"+rs1.getString("ahbs"));
				ahqty.addElement("&nbsp;"+rs1.getString("ahqty"));
				ahh1.addElement("&nbsp;"+rs1.getString("ahh1"));
				ahh2.addElement("&nbsp;"+rs1.getString("ahh2"));
				ahh3.addElement("&nbsp;"+rs1.getString("ahh3"));
				ahh4.addElement("&nbsp;"+rs1.getString("ahh4"));
				asize.addElement("&nbsp;"+rs1.getString("asize"));
				aemfr.addElement("&nbsp;"+rs1.getString("aemfr"));
				aemfrn.addElement("&nbsp;"+rs1.getString("aemfrn"));
				aetemp.addElement("&nbsp;"+rs1.getString("aetemp"));
				aetype.addElement("&nbsp;"+rs1.getString("aetype"));
				aepw.addElement("&nbsp;"+rs1.getString("aepw"));
				aeph.addElement("&nbsp;"+rs1.getString("aeph"));
				aelpl.addElement("&nbsp;"+rs1.getString("aelpl"));
				aedia.addElement("&nbsp;"+rs1.getString("aedia"));
				aebs.addElement("&nbsp;"+rs1.getString("aebs"));
				aeed.addElement("&nbsp;"+rs1.getString("aeed"));
				dbmfr.addElement("&nbsp;"+rs1.getString("dbmfr"));
				dbmfrn.addElement("&nbsp;"+rs1.getString("dbmfrn"));
				dbtemp.addElement("&nbsp;"+rs1.getString("dbtemp"));
				dbpw.addElement("&nbsp;"+rs1.getString("dbpw"));
				dbph.addElement("&nbsp;"+rs1.getString("dbph"));
				dbdb .addElement("&nbsp;"+rs1.getString("dbdb"));
				dbdia.addElement("&nbsp;"+rs1.getString("dbdia"));
				dbbs.addElement("&nbsp;"+rs1.getString("dbbs"));
				ach.addElement("&nbsp;"+rs1.getString("ach"));
				acw.addElement("&nbsp;"+rs1.getString("acw"));
				act.addElement("&nbsp;"+rs1.getString("act"));
				ace.addElement("&nbsp;"+rs1.getString("ace"));
				alfk.addElement("&nbsp;"+rs1.getString("alfk"));
				iswing.addElement("&nbsp;"+rs1.getString("iswing"));
				ihmfr.addElement("&nbsp;"+rs1.getString("ihmfr"));
				ihmfrn.addElement("&nbsp;"+rs1.getString("ihmfrn"));
				ihtemp.addElement("&nbsp;"+rs1.getString("ihtemp"));
				ihtype.addElement("&nbsp;"+rs1.getString("ihtype"));
				ihhgt.addElement("&nbsp;"+rs1.getString("ihhgt"));
				ihthick.addElement("&nbsp;"+rs1.getString("ihthick"));
				ihbs.addElement("&nbsp;"+rs1.getString("ihbs"));
				ihqty.addElement("&nbsp;"+rs1.getString("ihqty"));
				ihh1.addElement("&nbsp;"+rs1.getString("ihh1"));
				ihh2.addElement("&nbsp;"+rs1.getString("ihh2"));
				ihh3.addElement("&nbsp;"+rs1.getString("ihh3"));
				ihh4.addElement("&nbsp;"+rs1.getString("ihh4"));
				isize.addElement("&nbsp;"+rs1.getString("isize"));
				iemfr.addElement("&nbsp;"+rs1.getString("iemfr"));
				iemfrn.addElement("&nbsp;"+rs1.getString("iemfrn"));
				ietemp.addElement("&nbsp;"+rs1.getString("ietemp"));
				ietype.addElement("&nbsp;"+rs1.getString("ietype"));
				ielpw.addElement("&nbsp;"+rs1.getString("ielpw"));
				ielph.addElement("&nbsp;"+rs1.getString("ielph"));
				ielpl.addElement("&nbsp;"+rs1.getString("ielpl"));
				iedia.addElement("&nbsp;"+rs1.getString("iedia"));
				iebs.addElement("&nbsp;"+rs1.getString("iebs"));
				ieed.addElement("&nbsp;"+rs1.getString("ieed"));
				ich.addElement("&nbsp;"+rs1.getString("ich"));
				icw.addElement("&nbsp;"+rs1.getString("icw"));
				ict.addElement("&nbsp;"+rs1.getString("ict"));
				ice.addElement("&nbsp;"+rs1.getString("ice"));
				ilfk.addElement("&nbsp;"+rs1.getString("ilfk"));
				image_path.addElement(rs1.getString("image_path"));
				stile.addElement("&nbsp;"+rs1.getString("stile"));
			}
		}
		rs1.close();
//out.println("2::"+line_no.size());
		for(int x=0; x<line_no.size(); x++){
//out.println("3");
		%>
		<table width='100%' BORDER=1 bordercolor=black >
			<tr>
				<td class='noheader2' colspan='3'  >ACTIVE
				</td>
			</tr>
			<tr valign='top'>
				<td class='noheader2' valign='top' width='25%'>
					<table border='1' bordercolor=black  width='100%'>
						<tr>
							<td class='noheader2' colspan='2'  >
								SWING
							</td>
							<td class='noheader2' colspan='2'  >
								SIZE
							</td>
						</tr>
						<tr>
							<td class='noheader2' colspan='2'>
								<%= aswing.elementAt(x).toString() %>
							</td>
							<td class='noheader2' colspan='2'>
								<%= asize.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2' colspan='4'  >
								HINGES
							</td>
							</td>
						<tr>
							<td class='noheader2' width='35%'>
								MFG
							</td>
							<td class='noheader2' width='15%'>
								<%= ahmfr.elementAt(x).toString()%>
							</td>
							<td class='noheader2' width='35%'>
								NO OF HINGES
							</td>
							<td class='noheader2' width='15%'>
								<%= ahqty.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								MFR NO
							</td>
							<td class='noheader2'>
								<%= ahmfrn.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								H1
							</td>
							<td class='noheader2'>
								<%= ahh1.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								TEMP NO
							</td>
							<td class='noheader2'>
								<%= ahtemp.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								H2
							</td>
							<td class='noheader2'>
								<%= ahh2.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								HEIGHT
							</td>
							<td class='noheader2'>
								<%= ahhgt.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								H3
							</td>
							<td class='noheader2'>
								<%= ahh3.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								THICKNESS
							</td>
							<td class='noheader2'>
								<%= ahthick.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								H4
							</td>
							<td class='noheader2'>
								<%= ahh4.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								BACKSET
							</td>
							<td class='noheader2'>
								<%= ahbs.elementAt(x).toString()%>
							</td>
							<td class='noheader2' colspan='2'>
								&nbsp;
							</td>
						</tr>
					</table>
				</td>
				<td class='noheader2' valign='top' width='60%'>
					<table border='1' bordercolor=black  width='100%'>
						<tr>
							<td class='noheader2' colspan='4'  >
								EXIT DATA
							</td>
						</tr>
						<tr>
							<td class='noheader2' width='25%'>
								MFR
							</td>
							<td class='noheader2' width='25%'>
								<%= 	aemfr.elementAt(x).toString()%>
							</td>
							<td class='noheader2' width='25%'>
								LATCH PLATE HEIGHT
							</td>
							<td class='noheader2' width='25%'>
								<%= aeph.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								MFR NO
							</td>
							<td class='noheader2'>
								<%= aemfrn.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								LATCH PLATE LOCATION
							</td>
							<td class='noheader2'>
								<%= aelpl.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								TEMP NO
							</td>
							<td class='noheader2'>
								<%= aetemp.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								DIAMETER
							</td>
							<td class='noheader2'>
								<%= aedia.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								TYPE
							</td>
							<td class='noheader2'>
								<%= aetype.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								BACKSET
							</td>
							<td class='noheader2'>
								<%= aebs.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								LATCH PLATE WIDTH
							</td>
							<td class='noheader2'>
								<%= aepw.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								ED DIMENSTION
							</td>
							<td class='noheader2'>
								<%= aeed.elementAt(x).toString()%>
							</td>
						</tr>
					</table>

				</td>
				<td class='noheader2' valign='top' width='15%'>
					<table border='1' bordercolor=black  width='100%'>
						<tr>
							<td class='noheader2' colspan='2'  >
								CUTOUT DIMENSIONS
							</td>
						</tr>
						<tr>
							<td class='noheader2' width='50%'>
								HEIGHT
							</td>
							<td class='noheader2' width='50%'>
								<%= ach.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								WIDTH
							</td>
							<td class='noheader2'>
								<%= acw.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								CT DIMENSION
							</td>
							<td class='noheader2'>
								<%= act.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								CE DIMENSION
							</td>
							<td class='noheader2'>
								<%= ace.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								LITE FRAME KIT
							</td>
							<td class='noheader2'>
								<%= alfk.elementAt(x).toString()%>
							</td>
						</tr>
					</table>
					<table border='1' bordercolor=black>
						<tr>
							<td class='noheader2' colspan='4'  >
								DEADBOLT DATA
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								MANUF
							</td>
							<td class='noheader2'>
								<%= dbmfr.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								BACKSET
							</td>
							<td class='noheader2'>
								<%= dbbs.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								MANUF NO
							</td>
							<td class='noheader2'>
								<%= dbmfr.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								DB DIMENSION
							</td>
							<td class='noheader2'>
								<%= dbdb.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								TEMP NO
							</td>
							<td class='noheader2'>
								<%= dbtemp.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								PLATE WID
							</td>
							<td class='noheader2'>
								<%= dbpw.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								DIAMETER
							</td>
							<td class='noheader2'>
								<%= dbdia.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								PLATE HGT
							</td>
							<td class='noheader2'>
								<%= dbph.elementAt(x).toString()%>
							</td>
						</tr>
					</table>
				</td>

			</tr>
			<tr>
				<td class='noheader2' colspan='3' >INACTIVE
				</td>
			</tr>
			<tr>
				<td class='noheader2' valign='top' width='25%'>
					<table border='1' bordercolor=black  width='100%'>
						<tr>
							<td class='noheader2' colspan='2'  >
								SWING
							</td>
							<td class='noheader2' colspan='2'  >
								SIZE
							</td>
						</tr>
						<tr>
							<td class='noheader2' colspan='2'>
								<%= iswing.elementAt(x).toString() %>
							</td>
							<td class='noheader2' colspan='2'>
								<%= isize.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2' colspan='4'  >
								HINGES
							</td>
							</td>
						<tr>
							<td class='noheader2' width='35%'>
								MFG
							</td>
							<td class='noheader2' width='15%'>
								<%= ihmfr.elementAt(x).toString()%>
							</td>
							<td class='noheader2' width='35%'>
								NO OF HINGES
							</td>
							<td class='noheader2' width='15%'>
								<%= ihqty.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								MFR NO
							</td>
							<td class='noheader2'>
								<%= ihmfrn.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								H1
							</td>
							<td class='noheader2'>
								<%= ihh1.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								TEMP NO
							</td>
							<td class='noheader2'>
								<%= ihtemp.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								H2
							</td>
							<td class='noheader2'>
								<%= ihh2.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								HEIGHT
							</td>
							<td class='noheader2'>
								<%= ihhgt.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								H3
							</td>
							<td class='noheader2'>
								<%= ihh3.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								THICKNESS
							</td>
							<td class='noheader2'>
								<%= ihthick.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								H4
							</td>
							<td class='noheader2'>
								<%= ihh4.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								BACKSET
							</td>
							<td class='noheader2'>
								<%= ihbs.elementAt(x).toString()%>
							</td>
							<td class='noheader2' colspan='2'>
								&nbsp;
							</td>
						</tr>
					</table>
				</td>
				<td class='noheader2' valign='top' width='55%'>
					<table border='1' bordercolor=black  width='100%'>
						<tr>
							<td class='noheader2' colspan='4'  >
								EXIT DATA
							</td>
						</tr>
						<tr>
							<td class='noheader2' width='25%'>
								MFR
							</td>
							<td class='noheader2' width='25%'>
								<%= iemfr.elementAt(x).toString()%>
							</td>
							<td class='noheader2' width='25%'>
								LATCH PLATE HEIGHT
							</td>
							<td class='noheader2' width='25%'>
								<%= ielph.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								MFR NO
							</td>
							<td class='noheader2'>
								<%= iemfrn.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								LATCH PLATE LOCATION
							</td>
							<td class='noheader2'>
								<%= ielpl.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								TEMP NO
							</td>
							<td class='noheader2'>
								<%= ietemp.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								DIAMETER
							</td>
							<td class='noheader2'>
								<%= iedia.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								TYPE
							</td>
							<td class='noheader2'>
								<%= ietype.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								BACKSET
							</td>
							<td class='noheader2'>
								<%= iebs.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								LATCH PLATE WIDTH
							</td>
							<td class='noheader2'>
								<%= ielpw.elementAt(x).toString()%>
							</td>
							<td class='noheader2'>
								ED DIMENSTION
							</td>
							<td class='noheader2'>
								<%= ieed.elementAt(x).toString()%>
							</td>
						</tr>
					</table>
				</td>
				<td class='noheader2' valign='top' width='20%'>
					<table border='1' bordercolor=black  width='100%'>
						<tr>
							<td class='noheader2' colspan='2'  >
								CUTOUT DIMENSIONS
							</td>
						</tr>
						<tr>
							<td class='noheader2' width='50%'>
								HEIGHT
							</td>
							<td class='noheader2' width='50%'>
								<%= ich.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								WIDTH
							</td>
							<td class='noheader2'>
								<%= icw.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								CT DIMENSION
							</td>
							<td class='noheader2'>
								<%= ict.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								CE DIMENSION
							</td>
							<td class='noheader2'>
								<%= ice.elementAt(x).toString()%>
							</td>
						</tr>
						<tr>
							<td class='noheader2'>
								LITE FRAME KIT
							</td>
							<td class='noheader2'>
								<%= ilfk.elementAt(x).toString()%>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td class='noheader2' colspan='3'  >
					DOOR NUMBERS:<BR><%= door_no.elementAt(x).toString()%>
				</td>
			</tr>

			<tr>
				<td class='noheader2' colspan='3' >
					<img src='https://<%= application.getInitParameter("HOST")%>/cse/web/product_images/<%=image_path.elementAt(x).toString()%>' height='300' >
					<%
					/*
					try{
					%>
					<%
					//out.println("The image starting");
					URL yahoo = new URL("https://"+ application.getInitParameter("HOST")+"/cse/web/jsp/custom_interface/print_interface.jsp?environment=Development&username="+name+"&doc_number="+order_no+"&doc_line="+line_no.elementAt(x).toString().trim()+"&doc_revision=1&doc_type="+doc_type);
					//"/elo/elogiaoe?cmd=CI&action=PRINT&uid="+name+"&order_no="+order_no+"&item_no="+item_no.elementAt(n)+" ");
					BufferedReader in = new BufferedReader(	new InputStreamReader(yahoo.openStream()));
					String inputLine;
					while ((inputLine = in.readLine()) != null)
					out.println(inputLine);
					in.close();
					//out.println("The image done");

					}
					catch(IOException e){
						out.println(" problem with picture "+e);
					}
					*/
					%>

				</td>
			</tr>
			<tr>
				<td class='noheader2' colspan='3'>
					<table border='1' bordercolor=black  width='100%'>
						<tr>
							<td class='noheader2' WIDTH='66%'>
								<table border='1' bordercolor=black  WIDTH='100%'>
									<tr>
										<td class='noheader2' WIDTH='25%'>
											MK
										</td>
										<td class='noheader2' WIDTH='25%'>
											<%= mark.elementAt(x).toString()%>
										</td>
										<td class='noheader2'>
											PUSH COLOR
										</td>
										<td class='noheader2'>
											<%= push.elementAt(x).toString()%>
										</td>
									</tr>
									<tr>
										<td class='noheader2'>
											QTY
										</td>
										<td class='noheader2'>
											<%= qty.elementAt(x).toString()%>
										</td>
										<td class='noheader2'>
											PULL COLOR
										</td>
										<td class='noheader2'>
											<%= pull.elementAt(x).toString()%>
										</td>
									</tr>
									<tr>
										<td class='noheader2'>
											TYPE
										</td>
										<td class='noheader2'>
											<%= door.elementAt(x).toString()%>
										</td>
										<td class='noheader2'>
											HINGE COLOR
										</td>
										<td class='noheader2'>
											<%= he.elementAt(x).toString()%>
										</td>
									</tr>
									<tr>
										<td class='noheader2'>
											OPENING
										</td>
										<td class='noheader2'>
											<%= opening.elementAt(x).toString()%>
										</td>
										<td class='noheader2'>
											LATCH COLOR
										</td>
										<td class='noheader2'>
											<%= le.elementAt(x).toString()%>
										</td>
									</tr>
									<tr>
										<td class='noheader2'>
											STILE
										</td>
										<td class='noheader2'>
											<%= stile.elementAt(x).toString()%>
										</td>
										<td class='noheader2'>

										</td>
										<td class='noheader2'>

										</td>
									</tr>
									<tr>
										<td class='noheader2'>
											KP
										</td>
										<td class='noheader2' colspan='3'>
											<%= kp.elementAt(x).toString()%>
										</td>
									</tr>

								</table>
							</td>
							<td class='noheader2' WIDTH='33%'>
								<img src='http://lebhq-csedev.c-sgroup.com/web/product_images/ADS/logo.gif'>
								<table class='test' cellpadding='0' cellspacing='0' border='1' bordercolor=black ><tr><td class='noheader2' valign='top' width='8%' colspan='3' class='boxltr'>PROJECT: <%= pname %></td></tr>
									<tr><td class='noheader2' valign='top' colspan='3' width='8%' class='boxltr'>LOCATION:<%= ploc %> <%= pstate %></td></tr>
									<tr><td class='noheader2' valign='top' colspan='3' width='8%' class='boxltr'>CONTRACTOR: <%= pcontr %></td></tr>
									<tr><td class='noheader2' valign='top' colspan='2' width='4%' class='boxlt'>AGENT: <%= pagent %></td>
										<td class='noheader2' valign='top' colspan='1' width='4%' class='boxltr'>TEAR SHEET:<%= x+1 %> </td> </tr>
									<tr>
										<td class='noheader2' colspan='3'>
											<table class='test' cellpadding='0' cellspacing='0'>
												<tr>
													<td class='noheader2' width='2%' colspan='1' class='boxltb'>DWG. BY:<BR>&nbsp;</td>
													<td class='noheader2' width='2%' colspan='1' class='boxltb'>DATE:<BR><%= sDate %></td>
													<td class='noheader2' width='2%' colspan='1' >JOB NO:<BR><%= order_no %></td>
												</tr>
												<tr>
													<td class='noheader2' width='2%' colspan='1' class='boxltb'>&nbsp;</td>
													<td class='noheader2' width='2%' colspan='1' class='boxltb'>&nbsp;</td>
													<td class='noheader2' width='2%' colspan='1' >&nbsp;</td>
												</tr>
											</table>
										</td>
									</tr>

								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<p style='page-break-after : always;' >&nbsp;</p>


		<%
	}
	stmt.close();
	myConn.close();
	}
	catch(Exception e){
	out.println(e);
	}

		%>
	</body>
</html>