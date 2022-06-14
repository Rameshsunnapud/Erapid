<html>
<head>
<title>Access Central</title>
<script language="JavaScript" src="date-picker.js"></script>
<link rel='stylesheet' href='style1.css' type='text/css' />
</head>
<body>
<%@ page language="java" import="java.sql.*" import="java.util.*" errorPage="error.jsp" %>
<%@ include file="db_con.jsp"%>
<% 

	String ordertype= request.getParameter("type");//type
	String order_no = request.getParameter("q_no");
	String reset=request.getParameter("reset");
	int section=0;
	if(request.getParameter("section") != null){
		section=Integer.parseInt(request.getParameter("section"));
	}
	//out.println(section+" HERE IS THE SECTION"+order_no);

int numberOfSections=0;
String sectionGroup=""; 

ResultSet rsIsSections=stmt.executeQuery("Select sections,section_group from cs_quote_sections where order_no = '"+order_no+"'");
if(rsIsSections != null){
	while(rsIsSections.next()){
		numberOfSections=rsIsSections.getInt("sections");
		sectionGroup=rsIsSections.getString("section_group");
	}
}
rsIsSections.close();
if(sectionGroup != null && sectionGroup.trim().length()>0 || numberOfSections < 1 ){
//out.println(numberOfSections+" number of section<BR>");

boolean isNotSec=false;
if(numberOfSections<1){
	numberOfSections=1;
	isNotSec=true;
}
String sectionLines[]=new String[numberOfSections];

for(int t=0; t<numberOfSections; t++){
	sectionLines[t]="";
}
if(isNotSec){
	numberOfSections=0;

}
//out.println("Is Not Sections="+isNotSec+"<br>");
if(!isNotSec){


	for(int f=0; f<sectionGroup.length(); f++){
		int startx=0;
		int endx=0;
		endx=sectionGroup.indexOf(";");
		if(endx>0){
			startx=sectionGroup.indexOf("=");
			sectionLines[Integer.parseInt(sectionGroup.substring(startx+2,endx))-1]=sectionLines[Integer.parseInt(sectionGroup.substring(startx+2,endx))-1]+sectionGroup.substring(0,startx)+",";
			sectionGroup=sectionGroup.substring(endx+1);
			//out.println(sectionGroup+":<BR>");
			f=sectionGroup.length()-2;
		}
		else{
			f=sectionGroup.length();
		}
	}
	for(int tt=0; tt<numberOfSections; tt++){
			if(sectionLines[tt].indexOf(",")>0){
				sectionLines[tt]=sectionLines[tt].substring(0,sectionLines[tt].length()-1);
			}
	}

}

			String cityx="";
			String statex="";
			String DESC="";
			String ADD="";
			String SECT="";
			String DATE="";
			String CSDECO="";
			String QTYPE="";
			double pIndMATLESSFIN=0;
			double pIndYIELD=0;
			double pIndTOTWT=0;
			double pIndDOLLARSF=0;
			double pIndTOTSF=0;
			double pIndTOTPERIM=0;
			double pIndTOTPAINTSF=0;
			double pIndUNITPRICE=0;
			double pInfCOST=0;
			double pInfDHOURS=0;
			double pInfLHOURS=0;
			double pInfEHOURS=0;
			double pInfPMHOURS=0;
			double pInfTOTHOURS=0;
			double pInfADMINDOLLARS=0;
			double pInfFC=0;
			double pInfCATCHALL=0;
			double pInfCATCHALLWT=0;
			double pInfSUBTOTAL=0;
			double pInfCOMMDOLLARS=0;
			double pInfMARGDOLLARS=0;
			double pInfSELLPRICE=0;
			double pInfINSTALL=0;
			double pInfTOTAL=0;
			double pInfCOSTPERC=0;
			double pInfD=0;
			double pInfL=0;
			double pInfE=0;
			double pInfP=0;
			String pInfALLHOURS="";
			double pInfADMINPERC=0;
			double pInfFCPERC=0;
			double pInfCATCHALLPERC=0;
			String pInfCATCHALL_DESC="";
			double pInfSUBTOTPERC=0;
			double pInfCOMMPERC=0;
			double pInfMARGPERC=0;
			double pInfSELLPERC=0;
			double pInfCOMMFCPERC=0;
			double pInfFREIGHT=0;
			double pInfCRATE=0;
			int countRows=0;

			String product="";

			if(!(reset != null)){
				reset="";
			}
			//out.println(reset+"<---reset<BR>");


String query1="";
if(isNotSec){
//out.println(" this is not a sections query<BR>");
	query1="select count(*) from cs_access_central where order_no='"+order_no+"'";
}
else{
//out.println(section+" this is a sections query<BR>");
	query1="select count(*) from cs_access_central where order_no='"+order_no+"' and section_no ='s"+section+"'";
}
    ResultSet rs0=stmt.executeQuery(query1);
    if(rs0 != null){
		while(rs0.next()){
			countRows=rs0.getInt(1);
			//out.println(countRows+" ac<BR>");
		}
	}

	//out.println(countRows+"::1"+order_no+"::"+ordertype+"<BR>");
	rs0.close();
	String costx = request.getParameter("cost");
	//out.println(costx);
	if(costx != null && costx.equals("no")){
		//out.println("INVALID COST<BR>");
		countRows=0;
		order_no=request.getParameter("order_no");
		ordertype=request.getParameter("ordertype");
		ADD=request.getParameter("add");
		SECT=request.getParameter("sect");
		DATE=request.getParameter("date");
		QTYPE=request.getParameter("qtype");
		CSDECO=request.getParameter("csdeco");
		DESC=request.getParameter("desc");
	}
//out.println(ordertype+" this is the order type<BR>");
if(!(ordertype != null) || ordertype.equals("null")|| ordertype.trim().length()<1){
	//out.println("order type is null<BR>");

	ResultSet rsQtype=stmt.executeQuery("select doc_type from doc_header where doc_number='"+order_no+"'");
	if(rsQtype !=null){
		while(rsQtype.next()){
			ordertype=rsQtype.getString(1);
		}
	}
	rsQtype.close();
}
	ResultSet rs00=stmt.executeQuery("Select product_id FROM cs_project where order_no='"+order_no+"'");
	if(rs00 != null){
		while(rs00.next()){
			product=rs00.getString(1);
		}
	}
	rs00.close();
	//out.println(product+"<--<BR>");
//out.println(ordertype+" this is the order type<BR>");
//out.println(countRows+"2<BR>");
if(countRows>0){
	String query2="";
	if(isNotSec){
		query2="Select * from cs_access_central where order_no='"+order_no+"'";
	}
	else{
		query2="Select * from cs_access_central where order_no='"+order_no+"' and section_no='s"+section+"'";
	}
	ResultSet rs1=stmt.executeQuery(query2);
	if(rs1 != null){
		while(rs1.next()){

			DESC=rs1.getString("AC_DESC");
			if(DESC != null){
			}
			else{
				DESC="";
			}
			ADD=rs1.getString("AC_ADD");
			if(ADD != null){
			}
			else{
				ADD="";
			}
			SECT=rs1.getString("sect");
			if(SECT!= null){
			}
			else{
				SECT="";
			}

			DATE=rs1.getString("ac_date");
			if(DATE != null){
			}
			else{
				DATE="";
			}

			CSDECO=rs1.getString("csdeco");
			if(CSDECO != null){
			}
			else{
				CSDECO="";
			}

			QTYPE=rs1.getString("qtype");
			if(QTYPE !=null){

			}
			else{
				QTYPE="Q";
			}
			if(rs1.getString("pinffreight") != null && rs1.getString("pinffreight").trim().length()>0){
				pInfFREIGHT=(new Double(rs1.getString("pinffreight")).doubleValue());
			}
			if(rs1.getString("pinfcrate") != null && rs1.getString("pinfcrate").trim().length()>0){
				pInfCRATE=(new Double(rs1.getString("pinfCRATE")).doubleValue());
			}
			pIndMATLESSFIN=(new Double(rs1.getString("pindmatlessfin")).doubleValue());
			pIndYIELD=(new Double(rs1.getString("pindyield")).doubleValue());
			pIndTOTWT=(new Double(rs1.getString("pindtotwt")).doubleValue());
			pIndDOLLARSF=(new Double(rs1.getString("pinddollarsf")).doubleValue());
			pIndTOTSF=(new Double(rs1.getString("pindtotsf")).doubleValue());
			pIndTOTPERIM=(new Double(rs1.getString("pIndTOTPERIM")).doubleValue());
			pIndTOTPAINTSF=(new Double(rs1.getString("pIndTOTPAINTSF")).doubleValue());
			pIndUNITPRICE=(new Double(rs1.getString("pIndUNITPRICE")).doubleValue());
			pInfCOST=(new Double(rs1.getString("pInfCOST")).doubleValue());
			pInfDHOURS=(new Double(rs1.getString("pinfdhours")).doubleValue());
			pInfLHOURS=(new Double(rs1.getString("pinflhours")).doubleValue());
			pInfEHOURS=(new Double(rs1.getString("pinfehours")).doubleValue());
			pInfPMHOURS=(new Double(rs1.getString("pinfpmhours")).doubleValue());
			pInfTOTHOURS=(new Double(rs1.getString("pinftothours")).doubleValue());
			pInfADMINDOLLARS=(new Double(rs1.getString("pinfadmindollars")).doubleValue());
			pInfFC=(new Double(rs1.getString("pinffc")).doubleValue());
			pInfCATCHALLWT=(new Double(rs1.getString("pinfcatchallwt")).doubleValue());
			pInfCATCHALL=(new Double(rs1.getString("pinfcatchall")).doubleValue());
			pInfSUBTOTAL=(new Double(rs1.getString("pinfsubtotal")).doubleValue());
			pInfCOMMDOLLARS=(new Double(rs1.getString("pinfcommdollars")).doubleValue());
			pInfMARGDOLLARS=(new Double(rs1.getString("pinfmargdollars")).doubleValue());
			pInfSELLPRICE=(new Double(rs1.getString("pInfsellprice")).doubleValue());
//out.println(pInfSELLPRICE+"<BR>");
			pInfINSTALL=(new Double(rs1.getString("pInfinstall")).doubleValue());
			pInfTOTAL=(new Double(rs1.getString("pinftotal")).doubleValue());
			pInfCOSTPERC=(new Double(rs1.getString("pInfCOSTPERC")).doubleValue());
			pInfD=(new Double(rs1.getString("pinfd")).doubleValue());
			pInfL=(new Double(rs1.getString("pinfl")).doubleValue());
			pInfE=(new Double(rs1.getString("pinfe")).doubleValue());
			pInfP=(new Double(rs1.getString("pinfp")).doubleValue());
			pInfALLHOURS=rs1.getString("pInfallhours");
			pInfADMINPERC=(new Double(rs1.getString("pinfadminperc")).doubleValue());
			pInfFCPERC=(new Double(rs1.getString("pInffcperc")).doubleValue());
			pInfCATCHALLPERC=(new Double(rs1.getString("pInfcatchallperc")).doubleValue());
			pInfCATCHALL_DESC=rs1.getString("pinfcatchall_desc");
			pInfSUBTOTPERC=(new Double(rs1.getString("pInfSUBTOTPERC")).doubleValue());
			pInfCOMMPERC=(new Double(rs1.getString("pInfcommperc")).doubleValue());
			pInfMARGPERC=(new Double(rs1.getString("pinfmargperc")).doubleValue());
			pInfSELLPERC=(new Double(rs1.getString("pinfsellperc")).doubleValue());
			pInfCOMMFCPERC=(new Double(rs1.getString("pinfcommfcperc")).doubleValue());
			if(rs1.getString("city") != null){
				cityx=rs1.getString("city");
			}
			else{
				cityx="";
			}
			if(rs1.getString("state") != null){
				statex=rs1.getString("state");
			}
			else{
				statex="";
			}
		}
	}
	rs1.close();
}
//out.println(reset+"x<BR>");
if(reset.equals("yes")){
	countRows=0;
}
Vector city=new Vector();
Vector state=new Vector();
ResultSet rs2=stmt.executeQuery("Select city,state from cs_grille_ltl order by state");
if(rs2 != null){
	while(rs2.next()){
		city.addElement(rs2.getString(1));
		state.addElement(rs2.getString(2));
	}
}
rs2.close();
%>
   <div align="center">
<form name='accessForm' action='access_central_calc_ads.jsp'>
<input type='hidden' name='q_no' value='<%= order_no %>'>
<input type='hidden' name='type' value='<%= ordertype %>'>
<input type='hidden' name='countRows' value='<%= countRows %>'>
<input type='hidden' name='cityx' value='<%= cityx %>'>
<input type='hidden' name='statex' value='<%= statex %>'>
<input type='hidden' name='pIndMATLESSFIN' value='<%=pIndMATLESSFIN%>'>
<input type='hidden' name='pIndYIELD' value='<%= pIndYIELD%>'>
<input type='hidden' name='pIndTOTWT' value='<%= pIndTOTWT%>'>
<input type='hidden' name='pIndDOLLARSF' value='<%= pIndDOLLARSF%>'>
<input type='hidden' name='pIndTOTSF' value='<%= pIndTOTSF%>'>
<input type='hidden' name='pIndTOTPERIM' value='<%= pIndTOTPERIM%>'>
<input type='hidden' name='pIndTOTPAINTSF' value='<%= pIndTOTPAINTSF%>'>
<input type='hidden' name='pIndUNITPRICE' value='<%= pIndUNITPRICE%>'>
<input type='hidden' name='pInfCOST' value='<%= pInfCOST%>'>
<input type='hidden' name='pInfDHOURS' value='<%= pInfDHOURS%>'>
<input type='hidden' name='pInfLHOURS' value='<%= pInfLHOURS%>'>
<input type='hidden' name='pInfEHOURS' value='<%= pInfEHOURS%>'>
<input type='hidden' name='pInfPMHOURS' value='<%= pInfPMHOURS%>'>
<input type='hidden' name='pInfTOTHOURS' value='<%= pInfTOTHOURS%>'>
<input type='hidden' name='pInfADMINDOLLARS' value='<%=pInfADMINDOLLARS%>'>
<input type='hidden' name='pInfFC' value='<%= pInfFC%>'>
<input type='hidden' name='pInfCATCHALL' value='<%= pInfCATCHALL%>'>
<input type='hidden' name='pInfCATCHALLWT' value='<%= pInfCATCHALLWT%>'>
<input type='hidden' name='pInfSUBTOTAL' value='<%= pInfSUBTOTAL%>'>
<input type='hidden' name='pInfCOMMDOLLARS' value='<%= pInfCOMMDOLLARS%>'>
<input type='hidden' name='pInfMARGDOLLARS' value='<%= pInfMARGDOLLARS%>'>
<input type='hidden' name='pInfSELLPRICE' value='<%= pInfSELLPRICE%>'>
<input type='hidden' name='pInfINSTALL' value='<%= pInfINSTALL%>'>
<input type='hidden' name='pInfTOTAL' value='<%= pInfTOTAL%>'>
<input type='hidden' name='pInfCOSTPERC' value='<%= pInfCOSTPERC%>'>
<input type='hidden' name='pInfD' value='<%= pInfD%>'>
<input type='hidden' name='pInfL' value='<%= pInfL%>'>
<input type='hidden' name='pInfE' value='<%= pInfE%>'>
<input type='hidden' name='pInfP' value='<%= pInfP%>'>
<input type='hidden' name='pInfALLHOURS' value='<%= pInfALLHOURS%>'>
<input type='hidden' name='pInfADMINPERC' value='<%= pInfADMINPERC%>'>
<input type='hidden' name='pInfFCPERC' value='<%= pInfFCPERC%>'>
<input type='hidden' name='pInfCATCHALLPERC' value='<%=pInfCATCHALLPERC%>'>
<input type='hidden' name='pInfCATCHALL_DESC' value='<%= pInfCATCHALL_DESC%>'>
<input type='hidden' name='pInfSUBTOTPERC' value='<%= pInfSUBTOTPERC%>'>
<input type='hidden' name='pInfCOMMPERC' value='<%= pInfCOMMPERC%>'>
<input type='hidden' name='pInfMARGPERC' value='<%= pInfMARGPERC%>'>
<input type='hidden' name='pInfSELLPERC' value='<%= pInfSELLPERC%>'>
<input type='hidden' name='pInfCOMMFCPERC' value='<%= pInfCOMMFCPERC%>'>
<input type='hidden' name='pInfFREIGHT' value='<%= pInfFREIGHT%>'>
<input type='hidden' name='pInfCRATE' value='<%= pInfCRATE%>'>
<table>
<tr><td>QUOTE TYPE</td><td><Select name='qtype'>
<%
String selected="";
if(QTYPE.equals("TQ")){
	selected="selected";
}
%>
<option value='TQ' <%= selected%>>Types and Quantities</option>
<%
selected="";
if(QTYPE.equals("SS")){
	selected="selected";
}
%>
<option value='SS' <%= selected%>>Specification Section</option>
<%
selected="";
if(QTYPE.equals("PD")){
	selected="selected";
}
%>
<option value='PD' <%= selected%>>Per Plans Dated</option>
<%
selected="";
if(QTYPE.equals("PS")){
	selected="selected";
}
%>
<option value='PS' <%= selected%>>Plans and Specs</option>
</select></td></tr>
<tr><td>Sect. Desc.:</TD><TD><input type='text' name='DESC' value='<%=DESC%>'></td></tr>
<tr><td>Addenda:</TD><TD><input type='text' name='ADD' value='<%= ADD %>'></td></tr>
<tr><td>Spec Section:</TD><TD><input type='text' name='SECT' value='<%= SECT%>'></td></tr>
<tr><td>Plan Date:</TD><TD><input type='text' name='DATE' value='<%= DATE %>'>
	 <a href="javascript:show_calendar('accessForm.DATE');" onmouseover="window.status='Date Picker';return true;" onmouseout="window.status='';return true;">
	      <img src="images/show-calendar.gif" id="imgCalendar2" name="imgCalendar2" width=24 height=22 border=0></a>
</td></tr>
<tr><td>CS - DECO</TD><TD><Select name='CSDECO'>
<%
selected="";
	if(CSDECO.equals("C")){
		selected="selected";
	}
%>
<option value='C' <%= selected %>>CS</option>
<%
	selected="";
	if(CSDECO.equals("D")){
		selected="selected";
	}
	%>
<option value='D' <%= selected%>>Deco</option>
</select></td></tr><br>
<%

if(product.equals("GRILLE")){
	%>
<tr><td>Destination City:</td><td><Select name='cityState'>
<option value''></option>
<%

for(int a=0; a<city.size(); a++){
	selected="";
	if(cityx.equals(city.elementAt(a).toString()) && statex.equals(state.elementAt(a).toString())){
		selected="selected";
	}
	out.println("<option value='"+city.elementAt(a).toString()+"@"+state.elementAt(a).toString()+"' "+selected+">"+city.elementAt(a).toString()+","+state.elementAt(a).toString()+"</option>");
}
%>
</select>
<%
}
else{
	out.println("<input type='hidden' name='cityState' value=''>");
}

if(!isNotSec){
out.println("<input type='hidden' name='sectionLines' value='"+sectionLines[section-1]+"'>");
}
out.println("<input type='hidden' name='section' value='"+section+"'>");
out.println("<input type='hidden' name='isNotSec' value='"+isNotSec+"'>");
//stmt.close();


%>
<!--
<tr><td > Intercompany Pricing</td><td><input type='checkbox' name='interco'> </td></tr>-->
<tr><td colspan='2'><hr></td></tr><br>
<tr><td align='center' colspan='2'><input type='submit' value='Submit' class='button' ></td></tr>
</table>
</table>
</form>
<%
}
else{
   out.println("<table width='100%'><tr><td align='center'><font size='2' color='red'>Please assign lines to sections or change the number of sections to 0</font><br><BR></tr></td>");
out.println("<tr><Td align='center'><input type='button' value='Go Back' OnClick='history.go( -1 );return true;'></td></tr></table>");

}
stmt.close();
myConn.close();
%>
</body>
</html>