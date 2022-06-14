<html>
<head>
<title>Access Central</title>

<link rel='stylesheet' href='style1.css' type='text/css' />
</head>
   
<SCRIPT LANGUAGE="JavaScript">
<!-- Begin
function checkCanada(hrrate,enghrrate,pmhrrate){ 

	if(document.displayForm.group.value=="CanEstim" && document.displayForm.countRows.value<1){
		var newValue=document.displayForm.pIndTOTWT.value*0.1;
		var newValue2=Math.round(document.displayForm.pIndTOTWT.value*0.65);
		newValue=newValue+newValue2;
		alert("Bonjour Canada!!!"); 
		document.displayForm.pInfFC.value=newValue.toFixed(2); 
		hoursChange(hrrate,enghrrate,pmhrrate);
	}
	if(document.displayForm.interco.value=="on"){ 
		//alert("::"+document.displayForm.pIndTOTWT.value+"::");
		document.displayForm.pInfFC.value=(0.1*document.displayForm.pIndTOTWT.value).toFixed(2);
		hoursChange(document.displayForm.dh_rate.value, document.displayForm.eh_rate.value, document.displayForm.pm_rate.value);
		//alert("HERE");  
		document.displayForm.pInfCOMMPERC.value="0";
		commChange();
		//alert("HERE"); 
		document.displayForm.pInfMARGPERC.value="20";
		margChange();
		//alert("done");  
	}
}
function resetForm(){
	window.location=document.displayForm.urlReset.value;
	//window.location ="access_central_calc.jsp?q_no="+document.displayForm.order_no.value+"&type="+document.displayForm.ordertype.value+"&reset=yes";
}
function freightChange(hrrate,enghrrate,pmhrrate){
	document.displayForm.pInfFC.value=document.displayForm.pInfFREIGHT.value*1+document.displayForm.pInfCRATE.value*1;
	hoursChange(hrrate,enghrrate,pmhrrate);
}
function startScript(){
		var pInfALLHOURS = document.displayForm.pInfDHOURS.value + ", " + document.displayForm.pInfLHOURS.value + ", " + document.displayForm.pInfEHOURS.value + ", " + document.displayForm.pInfPMHOURS.value;
		document.displayForm.pInfALLHOURS.value=pInfALLHOURS;
		var pInfFCPERC = (document.displayForm.pInfFC.value / document.displayForm.pInfSELLPRICE.value * 100 * 100.0) / 100;
		document.displayForm.pInfFCPERC.value=pInfFCPERC.toFixed(2);
		//alert(document.displayForm.pInfCost.value+"::"
		//alert(document.displayForm.pInfSUBTOTAL.value);
		var pInfSUBTOTAL = (document.displayForm.pInfCOST.value)*1 + document.displayForm.pInfADMINDOLLARS.value*1+ document.displayForm.pInfFC.value*1 + document.displayForm.pInfCATCHALL.value*1;// * 100.0) / 100;
		document.displayForm.pInfSUBTOTAL.value=pInfSUBTOTAL.toFixed(2);
		//alert(document.displayForm.pInfSUBTOTAL.value);
		var pInfCOMMFCPERC = (document.displayForm.pInfCOMMDOLLARS.value*1 / document.displayForm.pInfSELLPRICE.value*1 * 100 * 100.0) / 100;
		document.displayForm.pInfCOMMFCPERC.value=pInfCOMMFCPERC.toFixed(2);

}
//--> end
<!-- Begin
function endScript(){

		var pInfADMINPERC = (document.displayForm.pInfADMINDOLLARS.value*1 / document.displayForm.pInfSELLPRICE.value*1 * 100 * 100.0) / 100;
		document.displayForm.pInfADMINPERC.value=pInfADMINPERC.toFixed(2);
		var pInfCATCHALLPERC = (document.displayForm.pInfCATCHALL.value*1/ document.displayForm.pInfSELLPRICE.value*1 * 100 * 100.0) / 100;
		document.displayForm.pInfCATCHALLPERC.value=pInfCATCHALLPERC.toFixed(2);
		var pInfSUBTOTPERC = (document.displayForm.pInfSUBTOTAL.value*1 / document.displayForm.pInfSELLPRICE.value*1 * 100 * 100.0) / 100.0;

		document.displayForm.pInfSUBTOTPERC.value=pInfSUBTOTPERC.toFixed(2);
		var pInfCOSTPERC = (document.displayForm.pInfCOST.value*1 / document.displayForm.pInfSELLPRICE.value*1 * 100 * 100.0) / 100;
		document.displayForm.pInfCOSTPERC.value=pInfCOSTPERC.toFixed(2);
		var pInfTOTAL = document.displayForm.pInfSELLPRICE.value*1 + document.displayForm.pInfINSTALL.value*1;
		document.displayForm.pInfTOTAL.value=pInfTOTAL.toFixed(2);

		var pIndYIELD="";
		if(document.displayForm.pIndTOTWT.value == 0){
			pIndYIELD = 0;
		}
		else {
			pIndYIELD = (document.displayForm.pInfSELLPRICE.value*1/ (document.displayForm.pIndTOTWT.value*1 + document.displayForm.pInfCATCHALLWT.value * 1.2) * 100.0) / 100.0;
		}
		document.displayForm.pIndYIELD.value=pIndYIELD.toFixed(2);
		var pIndTOTSF = document.displayForm.VR_SQFT.value*1;
		document.displayForm.pIndTOTSF.value=pIndTOTSF.toFixed(2);

		var pIndDOLLARSF="";
		if(pIndTOTSF == 0){
			pIndDOLLARSF = 0.0;
		}
		else {
			pIndDOLLARSF = (document.displayForm.pInfSELLPRICE.value / pIndTOTSF * 100.0) / 100.0;
		}
		document.displayForm.pIndDOLLARSF.value=pIndDOLLARSF.toFixed(2);
		var pIndUNITPRICE = (document.displayForm.pInfSELLPRICE.value*1 / document.displayForm.VR_TOTQTY.value*1 * 100.0) / 100.0;
		document.displayForm.pIndUNITPRICE.value=pIndUNITPRICE.toFixed(2);
//		if(document.displayForm.pInfCATCHALL.value >0){
//			if(document.displayForm.pInfCATCHALLWT.value <= 0){
//				alert("Please enter a Catchall Weight!");
//				document.displayForm.pInfCATCHALLWT.focus();
//			}
//
//		}

}
//--> end
<!--
function hoursChange(hrrate,enghrrate,pmhrrate) {
		startScript();
		//alert(document.displayForm.pInfSUBTOTAL.value+"::"+document.displayForm.pInfCOST.value+"::"+document.displayForm.pInfADMINDOLLARS.value+"::"+document.displayForm.pInfFC.value+"::"+document.displayForm.pInfCATCHALL.value+ " HERE");
		//alert (hrrate);
		var pInfALLHOURS = document.displayForm.pInfDHOURS.value + ", " + document.displayForm.pInfLHOURS.value + ", " + document.displayForm.pInfEHOURS.value + ", " + document.displayForm.pInfPMHOURS.value;
		//pInfDHOURS=document.displayForm.pInfDHOURS.value;
		document.displayForm.pInfALLHOURS.value=pInfALLHOURS;
		var pInfD = document.displayForm.pInfDHOURS.value*1 * hrrate*1;
		document.displayForm.pInfD.value=pInfD.toFixed(2);
		var pInfL = document.displayForm.pInfLHOURS.value*1 * hrrate*1;
		document.displayForm.pInfL.value=pInfL.toFixed(2);
		var pInfE = document.displayForm.pInfEHOURS.value*1 * enghrrate*1;
		document.displayForm.pInfE.value=pInfE.toFixed(2);
		var pInfP = document.displayForm.pInfPMHOURS.value*1 * pmhrrate*1;
		document.displayForm.pInfP.value=pInfP.toFixed(2);
		var pInfTOTHOURS =(document.displayForm.pInfDHOURS.value*1+document.displayForm.pInfLHOURS.value*1+document.displayForm.pInfEHOURS.value*1+document.displayForm.pInfPMHOURS.value*1);
		document.displayForm.pInfTOTHOURS.value=pInfTOTHOURS.toFixed(2);
		var pInfADMINDOLLARS = pInfD*1 + pInfE*1 + pInfL*1 + pInfP*1;
		document.displayForm.pInfADMINDOLLARS.value=pInfADMINDOLLARS.toFixed(2);

		var pInfSUBTOTAL = (document.displayForm.pInfCOST.value*1)+(document.displayForm.pInfADMINDOLLARS.value*1)+(document.displayForm.pInfFC.value*1)+(document.displayForm.pInfCATCHALL.value*1);
		document.displayForm.pInfSUBTOTAL.value=pInfSUBTOTAL.toFixed(2);
		//alert(document.displayForm.pInfSUBTOTAL.value+"::"+document.displayForm.pInfCOST.value+"::"+document.displayForm.pInfADMINDOLLARS.value+"::"+document.displayForm.pInfFC.value+"::"+document.displayForm.pInfCATCHALL.value+ " HERE");
	var pInfSELLPRICE = ((100 * (pInfSUBTOTAL*1 - document.displayForm.pInfFC.value*1 * document.displayForm.pInfCOMMPERC.value*1 / 100.0)) / (100.0 - document.displayForm.pInfMARGPERC.value*1 - document.displayForm.pInfCOMMPERC.value*1));
		document.displayForm.pInfSELLPRICE.value=pInfSELLPRICE.toFixed(2);
		var pInfCOMMDOLLARS = (pInfSELLPRICE*1* 0.91 * document.displayForm.pInfCOMMPERC.value*1 / 100 * 100.0) / 100;
		document.displayForm.pInfCOMMDOLLARS.value=pInfCOMMDOLLARS.toFixed(2);
		var pInfMARGDOLLARS = (pInfSELLPRICE * document.displayForm.pInfMARGPERC.value / 100 * 100.0) / 100;
		document.displayForm.pInfMARGDOLLARS.value=pInfMARGDOLLARS.toFixed(2);
		var pInfCOMMFCPERC = (pInfCOMMDOLLARS / pInfSELLPRICE * 100 * 100.0) / 100;
		document.displayForm.pInfCOMMFCPERC.value=pInfCOMMFCPERC.toFixed(2);
		//alert(pInfALLHOURS +" drafting ");

		//status = status + "A";
		endScript();
}
//end -->
<!-- Begin
function dollarChange() {
		startScript();
		//alert(document.displayForm.pInfSUBTOTAL.value);
		var pInfSELLPRICE = document.displayForm.pInfSUBTOTAL.value*1 + document.displayForm.pInfCOMMDOLLARS.value*1 + document.displayForm.pInfMARGDOLLARS.value*1;
		document.displayForm.pInfSELLPRICE.value=pInfSELLPRICE.toFixed(2);
		var pInfMARGPERC = (document.displayForm.pInfMARGDOLLARS.value*1 / pInfSELLPRICE * 100 * 100.0) / 100;
		document.displayForm.pInfMARGPERC.value=pInfMARGPERC.toFixed(2);
		var pInfCOMMPERC = (100 * document.displayForm.pInfCOMMDOLLARS.value*1 / (pInfSELLPRICE * 0.91) * 100.0) / 100;
		document.displayForm.pInfCOMMPERC.value=pInfCOMMPERC.toFixed(2);
		var pInfCOMMFCPERC = (document.displayForm.pInfCOMMDOLLARS.value*1 / pInfSELLPRICE * 100 * 100.0) / 100;
	   	//status = status + "C";
		//alert(pInfSELLPRICE+" sellprice");
		document.displayForm.pInfCOMMFCPERC.value=pInfCOMMFCPERC.toFixed(2);
		endScript();
}
//end -->
<!-- Begin
function margChange() {
		startScript();
		var pInfCOMMDOLLARS=0;
		var pInfSELLPRICE=0;
		var pInfMARGDOLLARS=0;
		var pInfCOMMFCPERC=0;
		var pInfSELLPRICE = ((100 * document.displayForm.pInfSUBTOTAL.value - document.displayForm.pInfFC.value *  document.displayForm.pInfCOMMPERC.value) / (100.0 - document.displayForm.pInfCOMMPERC.value - document.displayForm.pInfMARGPERC.value));
		document.displayForm.pInfSELLPRICE.value=pInfSELLPRICE.toFixed(2);
		var pInfMARGDOLLARS = (pInfSELLPRICE * document.displayForm.pInfMARGPERC.value / 100 * 100.0) / 100;
		document.displayForm.pInfMARGDOLLARS.value=pInfMARGDOLLARS.toFixed(2);
		var pInfCOMMDOLLARS = (pInfSELLPRICE * 0.91 * document.displayForm.pInfCOMMPERC.value / 100 * 100.0) / 100;
		document.displayForm.pInfCOMMDOLLARS.value=pInfCOMMDOLLARS.toFixed(2);
		var pInfCOMMFCPERC = (pInfCOMMDOLLARS / pInfSELLPRICE * 100 * 100.0) / 100;
		//status = status + "D";
		//alert(pInfSELLPRICE+" sellprice");
		document.displayForm.pInfCOMMFCPERC.value=pInfCOMMFCPERC.toFixed(2);
		endScript();
}
//end -->
<!-- Begin
function commChange(){
		startScript();
		var pInfSELLPRICE = ((100 * document.displayForm.pInfSUBTOTAL.value - document.displayForm.pInfFC.value *  document.displayForm.pInfCOMMPERC.value) / (100.0 - document.displayForm.pInfCOMMPERC.value - document.displayForm.pInfMARGPERC.value) * 100.0) / 100;
		document.displayForm.pInfSELLPRICE.value=pInfSELLPRICE.toFixed(2);
		var pInfMARGDOLLARS = (pInfSELLPRICE * document.displayForm.pInfMARGPERC.value / 100.0);
		document.displayForm.pInfMARGDOLLARS.value=pInfMARGDOLLARS.toFixed(2);
		var pInfCOMMDOLLARS = (pInfSELLPRICE * 0.91 * document.displayForm.pInfCOMMPERC.value / 100 * 100.0) / 100;
		document.displayForm.pInfCOMMDOLLARS.value=pInfCOMMDOLLARS.toFixed(2);
		var pInfCOMMFCPERC = (pInfCOMMDOLLARS / pInfSELLPRICE * 100 * 100.0) / 100;
		//status = status + "E";
		//alert("sellprice");
		document.displayForm.pInfCOMMFCPERC.value=pInfCOMMFCPERC.toFixed(2);
		endScript();
}
//end -->
<!-- Begin
function sellChange(){
		startScript();
		var pInfCOMMDOLLARS = (document.displayForm.pInfSELLPRICE.value * 0.91 * document.displayForm.pInfCOMMPERC.value / 100 * 100.0) / 100;
		document.displayForm.pInfCOMMDOLLARS.value=pInfCOMMDOLLARS.toFixed(2);
		var pInfMARGDOLLARS = (document.displayForm.pInfSELLPRICE.value-pInfCOMMDOLLARS-document.displayForm.pInfSUBTOTAL.value);
		document.displayForm.pInfMARGDOLLARS.value=pInfMARGDOLLARS.toFixed(2);
		var pInfMARGPERC = (pInfMARGDOLLARS / document.displayForm.pInfSELLPRICE.value * 100 * 100.0) / 100;
		document.displayForm.pInfMARGPERC.value=pInfMARGPERC.toFixed(2);
		var pInfCOMMFCPERC = (pInfCOMMDOLLARS / document.displayForm.pInfSELLPRICE.value * 100 * 100.0) / 100;
		//status = status + "F";
		//.alert(pInfMARGDOLLARS+" bbb "+pInfCOMMDOLLARS);
		document.displayForm.pInfCOMMFCPERC.value=pInfCOMMFCPERC.toFixed(2);
		endScript();

}
//end -->
function installChange(){
	startScript();
	endScript();
}
function catchAllCheck(){
//alert("HERE");
var yeild=0;
yeild=document.displayForm.pInfSELLPRICE.value/(document.displayForm.pIndTOTWT.value*1+document.displayForm.pInfCATCHALLWT.value*1.2);
//alert(yeild);
document.displayForm.pIndYIELD.value=yeild.toFixed(2);



}
</script>


<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>

<%@ include file="db_con.jsp"%>

<%

// Code by Greg and Arthur
// Started June 28/05
// Will replace access central on configurator
String interco=request.getParameter("interco");
//out.println(interco);
if(interco==null){
	interco="off";
}
String sectionLines=request.getParameter("sectionLines");
String section=request.getParameter("section");
//out.println(sectionLines+"::"+section+"::"+request.getParameter("isNotSec")+"<BR>");
boolean  isNotSec=true;
if(request.getParameter("isNotSec") != null && request.getParameter("isNotSec").equals("false")){
	isNotSec=false;
}
String cityState=request.getParameter("cityState");
if(!(cityState != null)){
	cityState="";
}
boolean costCompare=true;
int countRows=Integer.parseInt(request.getParameter("countRows"));
int VI_MIN_SUBLINE=0;
int VI_MAX_SUBLINE=0;
int VI_N_OF_SUBL=0;
int VI_N_OF_COST=0;
String VS_ID="";
String order_no = request.getParameter("q_no");//Login id
String ordertype= request.getParameter("type");//type
//out.println(order_no+":::"+ordertype+"<BR>");
double dlspeed=0.0;
double hrrate=0.0;
double enghrrate=0.0;
double pmhrrate=0.0;
double defcommperc=0.0;
double fcperc=0.0;
double defmargperc=0.0;
double commfcperc=0.0;
double spfactor=0.0;

String cityx=request.getParameter("cityx");
String statex=request.getParameter("statex");
String qtype=request.getParameter("qtype"); //quote type = TQ, SS, PD, PS
String CSDECO=request.getParameter("CSDECO"); //cs or deco = C or D
String desc=request.getParameter("DESC");
String add=request.getParameter("ADD");
String sect=request.getParameter("SECT");
String date=request.getParameter("DATE");
String status="";
String urlReset="access_central_calc.jsp?q_no="+order_no+"&type="+ordertype+"&countRows=0&qtype="+qtype+"&CSDECO="+CSDECO+"&DESC="+desc+"&ADD="+add+"&SECT="+sect+"&DATE"+date+"&cityState="+cityState+"&cityx=no&statex=no&section="+section+"&isNotSec="+isNotSec+"&sectionLines="+sectionLines;

if(urlReset.length()>400){
urlReset=urlReset.substring(0,400);
}
//out.println(CSDECO+"x"+desc+"x"+add+"x"+sect+"x"+date+"<br>");

double VR_STDCOST=0.0;
double VR_RUNCOST=0.0;
double VR_SETUPCOST=0.0;

double VR_TOTFINCOST=0.0;
double VR_TOTSF=0.0;
double VR_TOTQTY=0.0;
double VR_SQFT=0.0;
double VR_ADJWEIGHT=0.0;

double pInfFREIGHT=0.0;
double pInfCRATE=0.0;
double pIndDOLLARSF=0.0;
double pIndMATLESSFIN=0.0;
double pIndTOTPAINTSF=0.0;
double pIndTOTPERIM=0.0;
double pIndTOTSF=0.0;
double pIndTOTWT=0.0;
double pIndUNITPRICE=0.0;
double pIndYIELD=0.0;
String pInfCATCHALL_DESC="";
double pInfADMINDOLLARS=0.0;
double pInfADMINPERC=0.0;
String pInfALLHOURS="";
double pInfCATCHALL=0.0;
double pInfCATCHALLPERC=0.0;
double pInfCATCHALLWT=0.0;
double pInfCOMMDOLLARS=0.0;
double pInfCOMMFCPERC=0.0;
double pInfCOMMPERC=0.0;
double pInfCOST=0.0;
double pInfCOSTPERC=0.0;
double pInfD=0.0;
double pInfDHOURS=0.0;
double pInfE=0.0;
double pInfEHOURS=0.0;
double pInfFC=0.0;
double pInfFCPERC=0.0;
double pInfINSTALL=0.0;
double pInfL=0.0;
double pInfLHOURS=0.0;
double pInfMARGDOLLARS=0.0;
double pInfMARGPERC=0.0;
double pInfP=0.0;
double pInfPMHOURS=0.0;
double pInfSELLPERC=0.0;
double pInfSELLPRICE=0.0;
double pInfSUBTOTAL=0.0;
double pInfSUBTOTPERC=0.0;
double pInfTOTAL=0.0;
double pInfTOTHOURS=0.0;
HttpSession userSession = request.getSession();
String group=userSession.getValue("usergroup").toString();

// get max and min subline values
ResultSet rs=stmt.executeQuery("Select doc_line,product_id from doc_line where doc_number='"+order_no+"' and (doc_line =(select min(cast(doc_line as int)) from doc_line where doc_number='"+order_no+"') or doc_line=(select max(cast(doc_line as int)) from doc_line where doc_number='"+order_no+"'))");
if(rs != null){
	while(rs.next()){
		VI_MIN_SUBLINE=rs.getInt(1);
		if(VI_MAX_SUBLINE==0){
			VS_ID=rs.getString(2);
		}
		if(VI_MIN_SUBLINE>VI_MAX_SUBLINE){
			int x=VI_MAX_SUBLINE;
			VI_MAX_SUBLINE=VI_MIN_SUBLINE;
			VI_MIN_SUBLINE=x;
		}
		else{
			VS_ID=rs.getString(2);
// Change VS_ID to be read from the PROJECT table instead of the first subline
// This way we can delete all references to VI_MIN_SUBLINE
		}
	}
}
rs.close();

String city="";
String state="";   


String VS_RES_STRING = "";
String VS_CONFIG_STRING = "";
String VS_MISMATCH = "";

int n_of_sublines=0; 
String keyword=",MK[";  
int[] subline=new int[VI_MAX_SUBLINE];
String[] mark_c=new String[VI_MAX_SUBLINE];
String[] product_c=new String[VI_MAX_SUBLINE];
int[] subl_c=new int[VI_MAX_SUBLINE]; 
//double[] cost_c=new double[VI_MAX_SUBLINE];
double[] weight_c=new double[VI_MAX_SUBLINE];
String[] qty_c=new String[VI_MAX_SUBLINE];
String[] model_c=new String[VI_MAX_SUBLINE];
String[] finish_c=new String[VI_MAX_SUBLINE];
String[] screen_c=new String[VI_MAX_SUBLINE];
String[] sched_mark=new String[VI_MAX_SUBLINE];
String[] sched_qty=new String[VI_MAX_SUBLINE];
String[] sched_size=new String[VI_MAX_SUBLINE];
//int[] schedule=new int[VI_MAX_SUBLINE];
String[] opts_c=new String[VI_MAX_SUBLINE];
int[] sched_max=new int[7];
String VS_DESC = "";
double setup_qty=0;
double VR_WEIGHT=0.0;
int VI_HAS_OPTIONS = 0;
int VI_TEST_TYPE = 0;
int desc_grp=0;
int rows=0;



// Find the sublines in the doc_line table.
try{
	String sel="";
	if(isNotSec){
		sel = "SELECT config_string,doc_line FROM doc_line WHERE doc_number='"+order_no+"'";
	}
	else{
		sel = "SELECT config_string,doc_line FROM doc_line WHERE doc_number='"+order_no+"' and doc_line in("+sectionLines+")";
	}

	//out.println("Running: "+sel);
    ResultSet rs01=stmt.executeQuery(sel);
    int k=0;
    while (rs01.next() ){

       VS_CONFIG_STRING=rs01.getString("config_string");
       subline[k]=rs01.getInt("doc_line");
       int foundat=VS_CONFIG_STRING.indexOf(keyword);
       int maxpos=VS_CONFIG_STRING.length();
       int string2=foundat+25;
       if (string2 > maxpos){
           string2 = maxpos;
       }
       String mark=VS_CONFIG_STRING.substring(foundat+4, string2);
       foundat=mark.indexOf("]");
       if(foundat >0){
       		mark_c[k]="Mark: "+mark.substring(0,foundat);
		}
       n_of_sublines++;


       int subl=rs01.getInt("doc_line");
       if(subl != subline[k]){
           out.println("ERROR in order #: "+order_no+" Mismatch - Line: "+subline[k]+" has {LOGIA/SUBLINENO} in the string as: "+subl);
           VS_MISMATCH=VS_MISMATCH+subline[k]+",";
           }

       k++;
       VI_N_OF_SUBL=k;
    }
    rs01.close();
}
catch(Exception e){
   out.println("ERROR While processing String..."+e);
}
try{
	for (int k=0; k<n_of_sublines; k++){
    	int s=k+1;
        String sel = "UPDATE doc_line SET item_desc = '"+mark_c[k]+"' WHERE doc_number='"+order_no+"' AND doc_line='"+subline[k]+"'";
        int rs02=stmt.executeUpdate(sel);
		//out.println("<font color='blue'>While running: "+sel+", "+rs02+" records found.<BR>");
    }
}
catch(Exception e00){
   out.println("ERROR: While performing UPDATE... "+e00);
}

if (!VS_MISMATCH.equals("")){
      out.println("ERROR: Open and re-save the following lines: "+VS_MISMATCH+" or call IT for help.");
}
// end of Updatedesc formula

if(ordertype.equals("Q")){

	//Summary formula - Retrieve and summarize costs for all sublines
	//out.println("<font color='black'> order type = q<BR>");
	//out.println("<font color='black'> run formula 'summary'<BR>");

	double VR_PERIM=0.0;
	double VR_TOTSURF=0.0;
	double VR_TOTCOMM=0.0;
	double VR_TOTPRICE=0.0;

	String VS_ORDERNO = order_no;

	// Options added to schedule for ADS
	if(VS_ID.equals("ADS")||VS_ID.equals("GRILLE")){
	    VI_HAS_OPTIONS = 1;
	}
	else {
	    VI_HAS_OPTIONS = 0;
	}

	if(qtype.equals("TQ") || qtype.equals("SS")){
	   VI_TEST_TYPE = 1;
	}
	else {
	   VI_TEST_TYPE = 0;
	}

	double[] nasty_setup=new double[VI_MAX_SUBLINE];

	setup_qty=0.0;

	char spacer_tab = 9;
	String spacer="" + spacer_tab + spacer_tab;
	String crlf="\r\n";


	if(VI_HAS_OPTIONS > 0){
	    spacer="   ";
	    }

	// part of Reporting formula - Output pricing for reporting

	double VR_RATIO = 0.0;

	// end of part of Reporting formula

// THIS IS WHERE CLEARDMRECS WAS

	try
	   {
	    VR_STDCOST=0.0;
	    VR_RUNCOST=0.0;
	    VR_SETUPCOST=0.0;
	    VR_WEIGHT=0.0;
	    VR_SQFT=0.0;
	    VR_PERIM=0.0;
	    VR_TOTFINCOST=0.0;
	    VR_TOTSURF=0.0;
	    VR_TOTCOMM=0.0;
	    VR_TOTPRICE=0.0;
	    VR_TOTQTY=0.0;
		String sel="";
		if(isNotSec){
	    	sel = "SELECT * FROM cs_costing WHERE order_no='"+VS_ORDERNO+ "'";
	    	//out.println("Query: "+sel+"<BR>");
		}
		else{
			sel = "SELECT * FROM cs_costing WHERE order_no='"+VS_ORDERNO+ "' and item_no in("+sectionLines+")";
			//out.println("Query: "+sel+"<BR>");
		}
	    //out.println("Running query: "+sel);
	    ResultSet rs00=stmt.executeQuery(sel);
	    sched_max[0]=4; // Mark
	    sched_max[1]=4; // Qty.
	    sched_max[2]=4; // Size
	    rows=0;
	    while (rs00.next() ){
//out.println("There is rs00.next<br>");
			// following from Reporting formula
	        subl_c[rows]=rs00.getInt("item_no");
		    //cost_c[rows]=rs00.getDouble("std_cost")+rs00.getDouble("run_cost");
		   // weight_c[rows]=rs00.getDouble("weight");
		    //qty_c[rows]=rs00.getString("qty");

		    // end of stuff from Reporting formula

		product_c[rows]=rs00.getString("product_id");
		model_c[rows]=rs00.getString("model");
	        ////finish_c[rows]=rs00.getString("finish");
	        //screen_c[rows]=rs00.getString("screen");
	       // opts_c[rows]=rs00.getString("s_options");
	        VR_STDCOST=VR_STDCOST+rs00.getDouble("std_cost");
	        VR_RUNCOST=VR_RUNCOST+rs00.getDouble("run_cost");
	        double cur_cost=rs00.getDouble("setup_cost");
	        nasty_setup[rows]=cur_cost;
// Added by AC based on old ACCESS_CENTRAL
		if (product_c[rows].equals("GRILLE")){
			if (rows!=0){
				for (int p=0;p<rows;p++){
					if (model_c[p].equals(model_c[rows])){
						cur_cost=0;
					}
				}
			}
			// out.println("Setup cost for line #"+rows+" model "+model_c[rows]+" is "+cur_cost+"<br>");
		}
// End of addition

	    //cost_c[rows]=cost_c[rows]+cur_cost;   // from Reporting formula
	        VR_SETUPCOST= VR_SETUPCOST+cur_cost;  // nasty setup cost will override this later
			// out.println("Setup cost "+VR_SETUPCOST+"<br>");
	        VR_WEIGHT= VR_WEIGHT+rs00.getDouble("weight");
	        VR_SQFT= VR_SQFT+rs00.getDouble("sqft");
	        VR_PERIM= VR_PERIM+rs00.getDouble("perim");
	        VR_TOTFINCOST= VR_TOTFINCOST+rs00.getDouble("fin_cost");
	        VR_TOTSURF= VR_TOTSURF+rs00.getDouble("totsurf");
	        VR_TOTCOMM=VR_TOTCOMM+rs00.getDouble("commission");
	        VR_TOTPRICE=VR_TOTPRICE+rs00.getDouble("price");
	        String tmp_qty=rs00.getString("qty");
	        VR_TOTQTY=VR_TOTQTY+Double.valueOf(tmp_qty).doubleValue();
	        tmp_qty=tmp_qty.substring(0,tmp_qty.length()-3);

	        sched_mark[rows]=rs00.getString("mark");
	        if(sched_mark[rows].length() > sched_max[0]){
	             sched_max[0]=sched_mark[rows].length();
	             }
	        sched_qty[rows]= tmp_qty;
	        if(sched_qty[rows].length() > sched_max[1]){
	             sched_max[1]=sched_qty[rows].length();
	             }
	        sched_size[rows]=rs00.getString("width") + " x " + rs00.getString("height");
	        if(sched_size[rows].length() > sched_max[2]){
	             sched_max[2]=sched_size[rows].length();
	             }
	       //out.println("<Br>"+rows+"<--<BR>");

	        rows++;
	        }
	    VI_N_OF_COST=rows;















// new ads shtuff by Greg
// we need to sum the stuff in csquotes up
Vector block_id = new Vector();
Vector model = new Vector();
Vector qty = new Vector();
Vector cost = new Vector();
Vector field = new Vector();
Vector margin = new Vector();
out.println("<table border='1' width='100%'><tr><td>Block_id</td><td>model</td><td>qty</td><td>Cost</td></tr>");
try{
ResultSet rsCSQUOTES=stmt.executeQuery("select block_id,field18,sum(cast(field19 as integer)), sum(cast(extended_price as float)) from csquotes where order_no='"+VS_ORDERNO+"' and not block_id ='A_APRODUCT' group by block_id,field18");
if(rsCSQUOTES != null){
	while(rsCSQUOTES.next()){
		block_id.addElement(rsCSQUOTES.getString(1));
		model.addElement(rsCSQUOTES.getString(2));
		qty.addElement(rsCSQUOTES.getString(3));
		cost.addElement(rsCSQUOTES.getString(4));
		String temp="";
		if(CSDECO.equals("D")){
			temp="DEC";
		}
		else{
			temp="CS";
		}
		if(new Double(rsCSQUOTES.getString(3)).doubleValue()<=30){
			temp=temp+"30";
		}
		else if(new Double(rsCSQUOTES.getString(3)).doubleValue()< 100){
			temp=temp+"99";
		}
		else{
			temp=temp+"100";
		}
		//field.addElement(temp);
	}
}
rsCSQUOTES.close();
out.println("</table>");

}
catch(Exception e){
	out.println(e);
}










	        
		// Find the number of sublines and subline numbers in the cs_costing table.
		if(VI_N_OF_COST > VI_N_OF_SUBL){
		    out.println("Mismatch: found "+VI_N_OF_COST+" entries in 'cs_ costing' for "+VI_N_OF_SUBL+" sublines - they will be deleted.");
		    }
	    rs00.close();
	    }
	catch(Exception e0)
	   {
	   //out.println("ERROR: While reading costs..."+e0+"<BR>");
	   }

// START of Cleardmrecs formula - Delete records in CS tables populated by Data Manager

		// This code was updated to delete orphaned entries in the cs_costing table when lines are deleted.

		String VS_MARKS = " ";

		// Find the orphans and delete them in the cs_costing table or warn about missing cost entries
		try
		    {
		// out.println("Found "+VI_N_OF_COST+" entries in 'cs_ costing' for "+VI_N_OF_SUBL+" sublines.");

		    for(int i=0; i<VI_N_OF_COST; i++){
		       int cur_cost=subline[i];
		       int mismatch=0;
		       boolean match=false;
		       for(int j=0; j<VI_N_OF_SUBL; j++){
		            if(cur_cost == subline[j]){
		                match=true;
		                }
		            }
		        if(!match){
		            String sel1 = "DELETE FROM cs_costing WHERE order_no ='"+VS_ORDERNO+"' AND item_no='"+cur_cost+"'";
		            int rs1=stmt.executeUpdate(sel1);
		            out.println("Delete orphaned entry for line "+cur_cost+" from 'cs_costing' result: "+rs1);
		            }
		       }

		    for (int m=0;m<VI_N_OF_SUBL;m++){
		       boolean got_match=false;
		       int n=0;
		       //if(VI_N_OF_COST >1){
		           	// out.println( subl_c[n]+"::"+subline[m]+"<BR>");
		       for (n=0;n<VI_N_OF_COST;n++){
				   
		           if ( subl_c[n]==subline[m]){
		           	// out.println( subl_c[n]+"::"+subline[m]+"<BR>");
		               got_match=true;
		              }
		           }
			  // }
		        if (!got_match) {
		           VS_MARKS=VS_MARKS+subline[m]+", ";
		           out.println("No entry for line "+subline[m]+" in the cs_costing table!");
		           }
		        }
		    }
		catch(Exception e2)
		   {
			myConn.rollback();
		    out.println("ERROR deleting cs_costing table: "+e2);
		   }
//out.println(VI_N_OF_SUBL+"::"+VI_N_OF_COST+"<BR>");
		if(VI_N_OF_SUBL > VI_N_OF_COST){
		     out.println("ERROR: Re-submit lines: "+VS_MARKS);
			}

// end of Cleardmrecs formula
// try block e1
	if (VS_ID.equals("ADS")){
		VR_SETUPCOST = setup_qty * 2;
		if (VR_SETUPCOST < 34.0 && setup_qty > 0) {
			VR_SETUPCOST=34.0;
			}
		}



	// end of Summary formula

	// run database query of cs_defaults
	//out.println("<font color='black'> query db cs_defaults table<BR>");
	ResultSet rs2=stmt.executeQuery("select * from cs_defaults where product_id ='"+VS_ID+"' and warhse='2'");
	if(rs2 != null){
		while(rs2.next()){
			dlspeed=rs2.getDouble("dlspeed");
			hrrate=rs2.getDouble("hrrate");
			enghrrate=rs2.getDouble("enghrrate");
			pmhrrate=rs2.getDouble("pmhrrate");
			defcommperc=rs2.getDouble("defcommperc");
			fcperc=rs2.getDouble("fcperc");
			defmargperc=rs2.getDouble("defmargperc");
			commfcperc=rs2.getDouble("commfcperc");
			spfactor=rs2.getDouble("spfactor");
	    //out.println("<font color='blue'>{defmargperc} = "+defmargperc+"<BR>");
	    //out.println("<font color='blue'>{commfcperc} = "+commfcperc+"<BR>");
		}
	}
	rs2.close();
	//out.println("<font color='blue'>results of query dlspeed="+dlspeed+" spfactor="+spfactor+" etc....<BR>");


	//Initreset formula - Initialization and reset of the SPC
	//out.println("<font color='black'> run initreset formula<BR>");
//out.println(" p inf cost "+pInfCOST+"<BR>");
	pInfCOST = VR_STDCOST + VR_RUNCOST + VR_SETUPCOST;
			// out.println("Setup cost "+VR_SETUPCOST+"<br>");
			// out.println("pInf cost "+pInfCOST+"<br>");
	pIndTOTPERIM = VR_PERIM;
	pIndMATLESSFIN = VR_STDCOST - VR_TOTFINCOST;


		pInfFCPERC = 9.0;

		if(CSDECO.equals("D")){
    		defcommperc = 15.0;
    		commfcperc = 13.65;
    		}


		pInfCATCHALL = 0.0;
		pInfINSTALL = 0.0;
		pInfCOMMPERC = defcommperc;

		pInfMARGPERC = defmargperc;
		//pInfDHOURS = Math.round(pInfCOST / dlspeed / 2 * 100.0) / 100.0;
		//pInfLHOURS = Math.round(pInfCOST / dlspeed / 2 * 100.0) / 100.0;
		pInfDHOURS = Math.round(pInfCOST / dlspeed);
		pInfLHOURS = Math.round(pInfCOST / dlspeed / 2);
		
		pInfEHOURS = 0.0;
		pInfPMHOURS = 0.0;
		pInfTOTHOURS = pInfDHOURS + pInfLHOURS + pInfEHOURS + pInfPMHOURS;
		pInfD = pInfDHOURS * hrrate;
		pInfL = pInfLHOURS * hrrate;
		pInfE = pInfEHOURS * enghrrate;
		pInfP = pInfPMHOURS * pmhrrate;
		pInfADMINDOLLARS = pInfD + pInfE + pInfL + pInfP;
		spfactor = Math.round((((100 - defmargperc - commfcperc) / 100) - pInfFCPERC / 100) * 10000.0) / 10000.0;
		pInfSELLPRICE = Math.round((pInfCATCHALL + pInfADMINDOLLARS + pInfCOST) / spfactor) + 0.0;
		pInfCOSTPERC = Math.round(pInfCOST / pInfSELLPRICE * 100 * 100.0) / 100.0;
		pInfADMINPERC = Math.round(pInfADMINDOLLARS / pInfSELLPRICE * 100 * 100.0) / 100.0;
		pInfCATCHALLPERC = pInfCATCHALL / pInfSELLPRICE * 100.0;
		// pInfCATCHALLWT = 0;
		pInfSUBTOTPERC = pInfSUBTOTAL / pInfSELLPRICE * 100.0;

		pInfFC = Math.round(pInfFCPERC / 100 * pInfSELLPRICE * 100.0) / 100.0;

// this is where pInfFC is initialized

		pInfSUBTOTAL = Math.round((pInfCOST + pInfADMINDOLLARS + pInfFC + pInfCATCHALL) * 100.0) / 100.0;
		pInfMARGDOLLARS = Math.round(pInfSELLPRICE * pInfMARGPERC / 100 * 100.0) / 100.0;
		pInfCOMMDOLLARS = Math.round(commfcperc / 100 * pInfSELLPRICE * 100.0) / 100.0;

		pInfTOTAL = Math.round(pInfSELLPRICE + pInfINSTALL);
		pInfCOMMFCPERC = Math.round(pInfCOMMDOLLARS / pInfSELLPRICE * 100 * 100.0) / 100.0;
		pIndTOTSF = VR_TOTSF;
		pIndTOTWT = VR_WEIGHT * 1.2;
		
// pIndTOTWT is set here
// following is code for correcting freight for grilles

	int v=cityState.indexOf("@");
	if(v>0){
		city=cityState.substring(0,v);
		if(v<cityState.length()){
			state=cityState.substring(v+1);
		}
	}

		pIndYIELD = Math.round(pInfSELLPRICE / pIndTOTWT * 100.0) / 100.0;
		//out.println("HERE1"+pIndYIELD+"<BR>");
		pIndDOLLARSF = Math.round(pInfSELLPRICE / VR_TOTSF * 100.0) / 100.0;
		pIndUNITPRICE = Math.round(pInfSELLPRICE / VR_TOTQTY * 100.0) / 100.0;
		pInfSELLPERC = 100.0;
		//{FLAGS/INIT} = 1

		VR_ADJWEIGHT = pIndTOTWT + pInfCATCHALLWT * 1.2;


	// Restore information from subline
	pIndTOTPAINTSF = VR_TOTSURF;
	pInfALLHOURS = pInfDHOURS + ", " + pInfLHOURS + ", " + pInfEHOURS + ", " + pInfPMHOURS;

	pInfSUBTOTPERC = Math.round(pInfSUBTOTAL / pInfSELLPRICE * 100 * 100.0) / 100.0;

	if(pIndTOTWT == 0){
		pIndYIELD = 0.0;
		//out.println("HERE2"+pIndYIELD+"<BR>");
	}
	else {
		pIndYIELD = Math.round(pInfSELLPRICE / (pIndTOTWT + pInfCATCHALLWT * 1.2) * 100.0) / 100.0;
		//out.println("HERE3"+pIndYIELD+"<BR>");
	}
	pIndTOTSF = VR_SQFT;
	if(pIndTOTSF == 0){
		pIndDOLLARSF = 0.0;
	}
	else {
		pIndDOLLARSF = Math.round(pInfSELLPRICE / pIndTOTSF * 100.0) / 100.0;
	}
	pIndUNITPRICE = Math.round(pInfSELLPRICE / VR_TOTQTY * 100.0) / 100.0;

	VR_ADJWEIGHT = pIndTOTWT + pInfCATCHALLWT * 1.2;

	// end of modify formula

} // end of if ordertype = q
//out.println(countRows+"<BR>");
	DecimalFormat for1 = new DecimalFormat("###.##");
	for1.setMaximumFractionDigits(2);
	for1.setMinimumFractionDigits(2);


if(countRows>0){
//out.println("HERE<BR>"); 
	pInfFREIGHT=(new Double(request.getParameter("pInfFREIGHT")).doubleValue());
	pInfCRATE=(new Double(request.getParameter("pInfCRATE")).doubleValue());
	pIndDOLLARSF=(new Double(request.getParameter("pIndDOLLARSF")).doubleValue());
	pIndMATLESSFIN=(new Double(request.getParameter("pIndMATLESSFIN")).doubleValue());
	pIndTOTPAINTSF=(new Double(request.getParameter("pIndTOTPAINTSF")).doubleValue());
	pIndTOTPERIM=(new Double(request.getParameter("pIndTOTPERIM")).doubleValue());
	pIndTOTSF=(new Double(request.getParameter("pIndTOTSF")).doubleValue());
	pIndTOTWT=(new Double(request.getParameter("pIndTOTWT")).doubleValue());
	pIndUNITPRICE=(new Double(request.getParameter("pIndUNITPRICE")).doubleValue());
	pIndYIELD=(new Double(request.getParameter("pIndYIELD")).doubleValue());
	//out.println("HERE4"+pIndYIELD+"<BR>");
	pInfCATCHALL_DESC=((request.getParameter("pInfCATCHALL_DESC")));
	pInfADMINDOLLARS=(new Double(request.getParameter("pInfADMINDOLLARS")).doubleValue());
	pInfADMINPERC=(new Double(request.getParameter("pInfADMINPERC")).doubleValue());
	pInfALLHOURS=((request.getParameter("pInfALLHOURS")));
	pInfCATCHALL=(new Double(request.getParameter("pInfCATCHALL")).doubleValue());
	pInfCATCHALLPERC=(new Double(request.getParameter("pInfCATCHALLPERC")).doubleValue());
	pInfCATCHALLWT=(new Double(request.getParameter("pInfCATCHALLWT")).doubleValue());
	pInfCOMMDOLLARS=(new Double(request.getParameter("pInfCOMMDOLLARS")).doubleValue());
	pInfCOMMFCPERC=(new Double(request.getParameter("pInfCOMMFCPERC")).doubleValue());
	pInfCOMMPERC=(new Double(request.getParameter("pInfCOMMPERC")).doubleValue());
	double pInfCOSTOld=(new Double(for1.format(pInfCOST)).doubleValue());
	pInfCOST=(new Double(request.getParameter("pInfCOST")).doubleValue());
	if(!(pInfCOSTOld==pInfCOST)){
		costCompare=false;
	}
	//out.println(pInfCOSTOld+" old "+pInfCOST+" new<BR>");
	pInfCOSTPERC=(new Double(request.getParameter("pInfCOSTPERC")).doubleValue());
	pInfD=(new Double(request.getParameter("pInfD")).doubleValue());
	pInfDHOURS=(new Double(request.getParameter("pInfDHOURS")).doubleValue());
	pInfE=(new Double(request.getParameter("pInfE")).doubleValue());
	pInfEHOURS=(new Double(request.getParameter("pInfEHOURS")).doubleValue());
	pInfFC=(new Double(request.getParameter("pInfFC")).doubleValue());
	pInfFCPERC=(new Double(request.getParameter("pInfFCPERC")).doubleValue());
	pInfINSTALL=(new Double(request.getParameter("pInfINSTALL")).doubleValue());
	pInfL=(new Double(request.getParameter("pInfL")).doubleValue());
	pInfLHOURS=(new Double(request.getParameter("pInfLHOURS")).doubleValue());
	pInfMARGDOLLARS=(new Double(request.getParameter("pInfMARGDOLLARS")).doubleValue());
	pInfMARGPERC=(new Double(request.getParameter("pInfMARGPERC")).doubleValue());
	pInfP=(new Double(request.getParameter("pInfP")).doubleValue());
	pInfPMHOURS=(new Double(request.getParameter("pInfPMHOURS")).doubleValue());
	pInfSELLPERC=(new Double(request.getParameter("pInfSELLPERC")).doubleValue());

	pInfSELLPRICE=(new Double(request.getParameter("pInfSELLPRICE")).doubleValue());
	pInfSUBTOTAL=(new Double(request.getParameter("pInfSUBTOTAL")).doubleValue());
	pInfSUBTOTPERC=(new Double(request.getParameter("pInfSUBTOTPERC")).doubleValue());
	pInfTOTAL=(new Double(request.getParameter("pInfTOTAL")).doubleValue());
	pInfTOTHOURS=(new Double(request.getParameter("pInfTOTHOURS")).doubleValue());
}


%>
<%@ include file="access_central_display_ads.jsp"%>
<%
stmt.close();
myConn.close();

%>