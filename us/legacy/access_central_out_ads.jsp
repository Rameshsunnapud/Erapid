<html>
<head>
<title>Access Central Output</title>
<SCRIPT language="JavaScript">

<!--
function m_window(theurl)
{
// set width and height
var the_width=800;
var the_height=625;
// set window position
var from_top=0;
var from_left=125;
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
	function forwardElogia(quote,product){
	//	document.location.href="sections.home.jsp?q_no="+quote+"&cmd=1&product="+product;
	}
</script>
<link rel='stylesheet' href='style1.css' type='text/css' />
</head>


</head>


<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" import="java.io.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="db_con.jsp"%>
<%
FileOutputStream p;
PrintStream out1;
Properties ht=new Properties();
String section=request.getParameter("section");
//String sectionLines=request.getParameter("sectionLines");
String sectionLines="";
boolean isNotSec=true;


//out.println(isNotSec+"::"+section+"::"+sectionLines+"<BR>");

HttpSession UserSession1 = request.getSession();
String name=UserSession1.getAttribute("username").toString();
int VI_MAX_SUBLINE=Integer.parseInt(request.getParameter("VI_MAX_SUBLINE"));
//out.println(name+":: name<br>");
String order_no = request.getParameter("order_no");
if(request.getParameter("isNotSec") != null && request.getParameter("isNotSec").equals("false")){

	isNotSec=false;
	//out.println(" is Section<BR>");
	String secTemp="";
	ResultSet rsIsSec=stmt.executeQuery("Select section_group from cs_quote_sections where order_no='"+order_no+"'");
	if(rsIsSec != null){
		while(rsIsSec.next()){
			secTemp=rsIsSec.getString(1);		
		}
	}
	//out.println(secTemp);
	for(int xt=0; xt<secTemp.length(); xt++){
		int testX=secTemp.indexOf(";");
		if(testX>0){
			int textX2=secTemp.indexOf("=s");
			if(textX2 >0){
				//out.println(secTemp.substring(textX2+2,testX)+" :: "+ section+"<BR>");
				if(secTemp.substring(textX2+2,testX).equals(section)){
					sectionLines=sectionLines+secTemp.substring(0,textX2)+",";
					//out.println(sectionLines+"<BR>");
				}
				secTemp=secTemp.substring(testX+1);
				//out.println(secTemp+" HERE<BR>");
				xt=0;
			}

			
		}
		
	}
	if(sectionLines.substring(sectionLines.length()-1).equals(",")){
		sectionLines=sectionLines.substring(0,sectionLines.length()-1);
	}
	//out.println(sectionLines+"::<BR>");
}
if(section == null || section.trim().length()<1){
	section="0";
}
String qtype = request.getParameter("qtype");

int[] subl_c=new int[VI_MAX_SUBLINE];
String[] product_c=new String[VI_MAX_SUBLINE];
String[] model_c=new String[VI_MAX_SUBLINE];
double[] weight_c=new double[VI_MAX_SUBLINE];
double[] cost_c=new double[VI_MAX_SUBLINE];
String[] qty_c=new String[VI_MAX_SUBLINE];
String[] opt_name=new String[5];
String[] finish_c=new String[VI_MAX_SUBLINE];
String[] screen_c=new String[VI_MAX_SUBLINE];
//String[] scheduleST=request.getParameterValues("schedule");
String[] scheduleMax=request.getParameterValues("sched_max");
String[] opts_c=new String[VI_MAX_SUBLINE];
String[] sched_qty=new String[VI_MAX_SUBLINE];
String[] sched_mark=new String[VI_MAX_SUBLINE];
String[] sched_size=new String[VI_MAX_SUBLINE];
String VS_ID=request.getParameter("VS_ID");
String setup_qty=request.getParameter("setup_qty");
int[] sched_max=new int[7];

String city=request.getParameter("city");
String state=request.getParameter("state");
String DESC= request.getParameter("desc");
String ADD= request.getParameter("add");
String SECT= request.getParameter("sect");
String DATE=request.getParameter("date");
if(DATE == null || DATE.equals("null")){
	DATE="";
}
String CSDECO= request.getParameter("csdeco");
String QTYPE= request.getParameter("qtype");
double VR_RATIO=0;

double pIndMATLESSFIN= (new Double(request.getParameter("pIndMATLESSFIN")).doubleValue());
double pIndYIELD= (new Double(request.getParameter("pIndYIELD")).doubleValue());
double pIndTOTWT= (new Double(request.getParameter("pIndTOTWT")).doubleValue());
double pIndDOLLARSF= (new Double(request.getParameter("pIndDOLLARSF")).doubleValue());
double pIndTOTSF= (new Double(request.getParameter("pIndTOTSF")).doubleValue());
double pIndTOTPERIM= (new Double(request.getParameter("pIndTOTPERIM")).doubleValue());
double pIndTOTPAINTSF= (new Double(request.getParameter("pIndTOTPAINTSF")).doubleValue());
double pIndUNITPRICE= (new Double(request.getParameter("pIndUNITPRICE")).doubleValue());
double pInfCOST= (new Double(request.getParameter("pInfCOST")).doubleValue());
double pInfDHOURS= (new Double(request.getParameter("pInfDHOURS")).doubleValue());
double pInfLHOURS= (new Double(request.getParameter("pInfLHOURS")).doubleValue());
double pInfEHOURS= (new Double(request.getParameter("pInfEHOURS")).doubleValue());
double pInfPMHOURS= (new Double(request.getParameter("pInfPMHOURS")).doubleValue());
double pInfTOTHOURS= (new Double(request.getParameter("pInfTOTHOURS")).doubleValue());
double pInfADMINDOLLARS= (new Double(request.getParameter("pInfADMINDOLLARS")).doubleValue());
double pInfFC= (new Double(request.getParameter("pInfFC")).doubleValue());
String catchallTemp=request.getParameter("pInfCATCHALL");
if(catchallTemp == null || catchallTemp.trim().length()<1){
	catchallTemp="0";
}
double pInfCATCHALL= (new Double(catchallTemp).doubleValue());
String catchallwtTemp=request.getParameter("pInfCATCHALLWT");
if(catchallwtTemp == null || catchallwtTemp.trim().length()<1){
	catchallwtTemp="0";
}
double pInfCATCHALLWT= (new Double(catchallwtTemp).doubleValue());
double pInfSUBTOTAL= (new Double(request.getParameter("pInfSUBTOTAL")).doubleValue());
double pInfCOMMDOLLARS= (new Double(request.getParameter("pInfCOMMDOLLARS")).doubleValue());
double pInfMARGDOLLARS= (new Double(request.getParameter("pInfMARGDOLLARS")).doubleValue());
double pInfSELLPRICE= (new Double(request.getParameter("pInfSELLPRICE")).doubleValue());
double pInfINSTALL= (new Double(request.getParameter("pInfINSTALL")).doubleValue());
double pInfTOTAL=(new Double(request.getParameter("pInfTOTAL")).doubleValue());
double pInfCOSTPERC= (new Double(request.getParameter("pInfCOSTPERC")).doubleValue());
double pInfD= (new Double(request.getParameter("pInfD")).doubleValue());
double pInfL= (new Double(request.getParameter("pInfL")).doubleValue());
double pInfE= (new Double(request.getParameter("pInfE")).doubleValue());
double pInfP= (new Double(request.getParameter("pInfP")).doubleValue());
String pInfALLHOURS= request.getParameter("pInfALLHOURS");
double pInfADMINPERC= (new Double(request.getParameter("pInfADMINPERC")).doubleValue());
double pInfFCPERC= (new Double(request.getParameter("pInfFCPERC")).doubleValue());
double pInfCATCHALLPERC= (new Double(request.getParameter("pInfCATCHALLPERC")).doubleValue());
String pInfCATCHALL_DESC= request.getParameter("pInfCATCHALL_DESC");
double pInfSUBTOTPERC= (new Double(request.getParameter("pInfSUBTOTPERC")).doubleValue());
double pInfCOMMPERC= (new Double(request.getParameter("pInfCOMMPERC")).doubleValue());
double pInfMARGPERC= (new Double(request.getParameter("pInfMARGPERC")).doubleValue());
double pInfSELLPERC= (new Double(request.getParameter("pInfSELLPERC")).doubleValue());
double pInfCOMMFCPERC= (new Double(request.getParameter("pInfCOMMFCPERC")).doubleValue());
String VR_WEIGHT=request.getParameter("VR_WEIGHT");
String pInfFREIGHT=request.getParameter("pInfFREIGHT");
String pInfCRATE=request.getParameter("pInfCRATE");

double crated_weight=(new Double(request.getParameter("crated_weight")).doubleValue());
double dh_rate=(new Double(request.getParameter("dh_rate")).doubleValue());
double eh_rate=(new Double(request.getParameter("eh_rate")).doubleValue());
double pm_rate=(new Double(request.getParameter("pm_rate")).doubleValue());

int rows=Integer.parseInt(request.getParameter("rows"));
//out.println("<BR>rows="+rows+", VI_MAX_SUBLINE="+VI_MAX_SUBLINE+",<BR>");
String sel="";
if(isNotSec){
	sel="SELECT * FROM cs_costing WHERE order_no='"+order_no+ "'";
}
else{
	sel="SELECT * FROM cs_costing WHERE order_no='"+order_no+ "' and item_no in("+sectionLines+")";
}

//out.println("Running query: "+sel);
int rowsx=0;
ResultSet rs00=stmt.executeQuery(sel);
if(rs00!=null){
	    while (rs00.next() ){

		cost_c[rowsx]=rs00.getDouble("std_cost")+rs00.getDouble("run_cost")+rs00.getDouble("setup_cost");
	        subl_c[rowsx]=rs00.getInt("item_no");
	    weight_c[rowsx]=rs00.getDouble("weight");
		    qty_c[rowsx]=String.valueOf((new Double(rs00.getString("qty")).intValue()));
//out.println("Qty="+qty_c[rowsx]+"<BR>");
		    product_c[rowsx]=rs00.getString("product_id");
			model_c[rowsx]=rs00.getString("model");
			finish_c[rowsx]=rs00.getString("finish");
			screen_c[rowsx]=rs00.getString("screen");
	        opts_c[rowsx]=rs00.getString("s_options");


	            	        sched_mark[rowsx]=rs00.getString("mark");

					        sched_qty[rowsx]= String.valueOf((new Double(rs00.getString("qty")).intValue()));

					        sched_size[rowsx]=rs00.getString("width") + " x " + rs00.getString("height");


		 rowsx++;

	}
}
rs00.close();

for(int y=0; y<7; y++){
	sched_max[y]=Integer.parseInt(scheduleMax[y]);
}

int[] schedule=new int[VI_MAX_SUBLINE];


String VS_DESC = "";
String DescBid = "";

//String pInfTOTAL=request.getParameter("pInfTOTAL");
String desc=request.getParameter("desc");
String date=request.getParameter("date");
String sect=request.getParameter("sect");
String add=request.getParameter("add");
String ordertype=request.getParameter("ordertype");

String[] model_long=new String[VI_MAX_SUBLINE];
String[] finish_long=new String[VI_MAX_SUBLINE];
String[] screen_long=new String[VI_MAX_SUBLINE];
String[] opt1_long=new String[VI_MAX_SUBLINE];
String[] opt2_long=new String[VI_MAX_SUBLINE];
String[] opt3_long=new String[VI_MAX_SUBLINE];
String[] opt4_long=new String[VI_MAX_SUBLINE];
String[] specs=new String[VI_MAX_SUBLINE];
String[] description=new String[VI_MAX_SUBLINE];

int VI_HAS_OPTIONS=Integer.parseInt(request.getParameter("VI_HAS_OPTIONS"));
int VI_TEST_TYPE=Integer.parseInt(request.getParameter("VI_TEST_TYPE"));
int desc_grp=Integer.parseInt(request.getParameter("desc_grp"));

String id4export="";

//out.println(" set id4export=LVR <BR>");
id4export="LVR";


String typeFull="";
if(ordertype.equals("Q")){
	typeFull="QUOTE";
}
else if(ordertype.equals("O")){
	typeFull="ORDER";
}

//out.println(ordertype+":::<BR>");
java.util.Date date2 = new java.util.Date();
try{

	File f = new File("d:/transfer/joblog.txt");
	if(! f.exists()){
		p=new FileOutputStream("d:/transfer/joblog.txt");
	}
	else{
		p=new FileOutputStream("d:/transfer/joblog.txt", true);
	}
	out1 = new PrintStream(p);


out1.println("Debug Message - "+typeFull+": "+order_no+" containing product "+ VS_ID +", was saved by "+name+" ["+date2+"]\r\n");
	out1.close();
}
catch (Exception e){
    out.println ("Error writing to file" + e);
}

if(VS_ID.equals("ADS")){
	//out.println("if product id is efs or ads set id4export=product_id <BR>");
	id4export=VS_ID;
}

myConn.setAutoCommit(false);
try{
	String del0="delete from cs_access_central where order_no='"+order_no+"' and section_no='s"+section+"' ";
	stmt.executeUpdate(del0);
}
catch (java.sql.SQLException e){
	out.println("Problem with deleting from cs_access_central table");
	out.println("Illegal Operation try again/Report Error"+"<br>");
	myConn.rollback();
	out.println(e.toString());
	return;
}

try{
	String updateString ="INSERT INTO cs_access_central (order_no,pIndMATLESSFIN,pIndYIELD,pIndTOTWT,pIndDOLLARSF,pIndTOTSF,pIndTOTPERIM,pIndTOTPAINTSF,pIndUNITPRICE,pInfCOST,pInfDHOURS,pInfLHOURS,pInfEHOURS,pInfPMHOURS,pInfTOTHOURS,pInfADMINDOLLARS,pInfFC,pInfCATCHALL,pInfCATCHALLWT,pInfSUBTOTAL,pInfCOMMDOLLARS,pInfMARGDOLLARS,pInfSELLPRICE,pInfINSTALL,pInfTOTAL,pInfCOSTPERC,pInfD,pInfL,pInfE,pInfP,pInfALLHOURS,pInfADMINPERC,pInfFCPERC,pInfCATCHALLPERC,pInfCATCHALL_DESC,pInfSUBTOTPERC,pInfCOMMPERC,pInfMARGPERC,pInfSELLPERC,pInfCOMMFCPERC,csdeco,qtype,sect,ac_desc,ac_add,ac_date,pInfFREIGHT,pInfCRATE,city,state,section_no)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
	java.sql.PreparedStatement updateAccess = myConn.prepareStatement(updateString);
	updateAccess.setString(1,order_no);
	updateAccess.setString(2,pIndMATLESSFIN+"");
	updateAccess.setString(3,pIndYIELD+"");
	updateAccess.setString(4,pIndTOTWT+"");
	updateAccess.setString(5,pIndDOLLARSF+"");
	updateAccess.setString(6,pIndTOTSF+"");
	updateAccess.setString(7,pIndTOTPERIM+"");
	updateAccess.setString(8,pIndTOTPAINTSF+"");
	updateAccess.setString(9,pIndUNITPRICE+"");
	updateAccess.setString(10,pInfCOST+"");
	updateAccess.setString(11,pInfDHOURS+"");
	updateAccess.setString(12,pInfLHOURS+"");
	updateAccess.setString(13,pInfEHOURS+"");
	updateAccess.setString(14,pInfPMHOURS+"");
	updateAccess.setString(15,pInfTOTHOURS+"");
	updateAccess.setString(16,pInfADMINDOLLARS+"");
	updateAccess.setString(17,pInfFC+"");
	updateAccess.setString(18,pInfCATCHALL+"");
	updateAccess.setString(19,pInfCATCHALLWT+"");
	updateAccess.setString(20,pInfSUBTOTAL+"");
	updateAccess.setString(21,pInfCOMMDOLLARS+"");
	updateAccess.setString(22,pInfMARGDOLLARS+"");
	updateAccess.setString(23,pInfSELLPRICE+"");
	updateAccess.setString(24,pInfINSTALL+"");
	updateAccess.setString(25,pInfTOTAL+"");
	updateAccess.setString(26,pInfCOSTPERC+"");
	updateAccess.setString(27,pInfD+"");
	updateAccess.setString(28,pInfL+"");
	updateAccess.setString(29,pInfE+"");
	updateAccess.setString(30,pInfP+"");
	updateAccess.setString(31,pInfALLHOURS+"");
	updateAccess.setString(32,pInfADMINPERC+"");
	updateAccess.setString(33,pInfFCPERC+"");
	updateAccess.setString(34,pInfCATCHALLPERC+"");
	updateAccess.setString(35,pInfCATCHALL_DESC+"");
	updateAccess.setString(36,pInfSUBTOTPERC+"");
	updateAccess.setString(37,pInfCOMMPERC+"");
	updateAccess.setString(38,pInfMARGPERC+"");
	updateAccess.setString(39,pInfSELLPERC+"");
	updateAccess.setString(40,pInfCOMMFCPERC+"");
	updateAccess.setString(41,CSDECO);
	updateAccess.setString(42,QTYPE);
	updateAccess.setString(43,SECT);
	updateAccess.setString(44,DESC);
	updateAccess.setString(45,ADD);
	updateAccess.setString(46,DATE);
	updateAccess.setString(47,pInfFREIGHT);
	updateAccess.setString(48,pInfCRATE);
	updateAccess.setString(49,city);
	updateAccess.setString(50,state);
	updateAccess.setString(51,"s"+section);
	int rocount = updateAccess.executeUpdate();
	updateAccess.close();
}
catch (java.sql.SQLException e){

out.println(""+order_no+"<BR>"+pIndMATLESSFIN+"<BR>"+pIndYIELD+"<BR>"+pIndTOTWT+"<BR>"+pIndDOLLARSF+"<BR>"+pIndTOTSF+"<BR>"+pIndTOTPERIM+"<BR>"+pIndTOTPAINTSF+"<BR>"+pIndUNITPRICE+"<BR>"+pInfCOST+"<BR>"+pInfDHOURS+"<BR>"+pInfLHOURS+"<BR>"+pInfEHOURS+"<BR>"+pInfPMHOURS+"<BR>"+pInfTOTHOURS+"<BR>"+pInfADMINDOLLARS+"<BR>"+pInfFC+"<BR>"+pInfCATCHALL+"<BR>"+pInfCATCHALLWT+"<BR>"+pInfSUBTOTAL+"<BR>"+pInfCOMMDOLLARS+"<BR>"+pInfMARGDOLLARS+"<BR>"+pInfSELLPRICE+"<BR>"+pInfINSTALL+"<BR>"+pInfTOTAL+"<BR>"+pInfCOSTPERC+"<BR>"+pInfD+"<BR>"+pInfL+"<BR>"+pInfE+"<BR>"+pInfP+"<BR>"+pInfALLHOURS+"<BR>"+pInfADMINPERC+"<BR>"+pInfFCPERC+"<BR>"+pInfCATCHALLPERC+"<BR>"+pInfCATCHALL_DESC+"<BR>"+pInfSUBTOTPERC+"<BR>"+pInfCOMMPERC+"<BR>"+pInfMARGPERC+"<BR>"+pInfSELLPERC+"<BR>"+pInfCOMMFCPERC+"<BR>"+CSDECO+"<BR>"+QTYPE+"<BR>"+SECT+"<BR>"+DESC+"<BR>"+ADD+"<BR>"+DATE+"<BR>"+pInfFREIGHT+"<BR>"+pInfCRATE+"<BR>"+city+"<BR>"+state+"<BR>"+"s"+section);
	out.println("Problem with entering into cs_access_central table");
	out.println("Illegal Operation try again/Report Error"+"<br>");
	myConn.rollback();
	out.println(e.toString());
	return;
}



// This code is part of the Summary formula - the protion that creates the description
// It could no longer be part of the access_central_calc.jsp file due to decription
// being too big to be passed down to the access_central_out,jsp page


if(ordertype.equals("Q")){
	String VS_SCHED = "";
	char spacer_tab = 9;
	String spacer="" + spacer_tab + spacer_tab;
	String crlf="\r\n";
	String linespec="";
	String sched_delim = ", ";
	if(VS_ID.equals("GRILLE")){

		sched_delim = "";
		spacer="" + spacer_tab;
		}

	try   {
	    if( VI_HAS_OPTIONS > 0  && VI_TEST_TYPE > 0){
	    	//out.println("Appending Options to Schedule");
	        boolean found_d=false;
	        sched_max[3]=0;
	        sched_max[4]=0;
	        sched_max[5]=0;
	        sched_max[6]=0;
	        for( int m=0;m<rows;m++){
	            String opt1=opts_c[m].substring(0,1);
	            String opt2=opts_c[m].substring(1,2);
	            String opt3=opts_c[m].substring(2,3);
	            String opt4=opts_c[m].substring(3,4);
	            String opt4par=opts_c[m].substring(4,opts_c[m].length());
				out.println("Options for line "+m+" are "+opt1+", "+opt2+", "+opt3+", "+opt4+", "+opt4par+"<br>");

	            String sel4 = "SELECT opt_name,opt_desc FROM CS_SCH_OPTS WHERE prod_id='"+VS_ID+"' AND opt_index='1' AND opt_code='"+opt1+"'";
				//out.println("Running query: "+sel4);
	            ResultSet rs4=stmt.executeQuery(sel4);
	            if (rs4.next() ){
	                 opt_name[1]=rs4.getString("opt_name");
	                 if (m<1){
	                     sched_max[3]=opt_name[1].length();
	                     }
	                 opt1_long[m]=rs4.getString("opt_desc");
	                 if(opt1_long[m].length() > sched_max[3]){
	                     sched_max[3]=opt1_long[m].length();
	                     }
	                 found_d=true;
	                 }
	            if (!found_d){
	                 out.println("Missing entry for option1="+opt1+". Please contact IT.");
	                 found_d=false;
	                 }
	            rs4.close();

	            sel4 = "SELECT opt_name,opt_desc FROM CS_SCH_OPTS WHERE prod_id='"+VS_ID+"' AND opt_index='2' AND opt_code='"+opt2+"'";
				//out.println("Running query: "+sel4);
	            rs4=stmt.executeQuery(sel4);
	            if (rs4.next() ){
	                 if(rs4.getString("opt_name") != null ){
						opt_name[2]=rs4.getString("opt_name");
					} else {
						opt_name[2]="";
				 	}
	                 if (m<1){
	                     sched_max[4]=opt_name[2].length();
	                     }
	                 if(rs4.getString("opt_desc") != null ){
						opt2_long[m] = rs4.getString("opt_desc");
					} else {
						opt2_long[m] = "";
				 	}
	                 if(opt2_long[m].length() > sched_max[4]){
	                     sched_max[4]=opt2_long[m].length();
	                     }
	                 found_d=true;
	                 }
	            if (!found_d){
	                 out.println("Missing entry for option1="+opt2+". Please contact IT.");
	                 found_d=false;
	                 }
	            rs4.close();

	            sel4 = "SELECT opt_name,opt_desc FROM CS_SCH_OPTS WHERE prod_id='"+VS_ID+"' AND opt_index='3' AND opt_code='"+opt3+"'";
				//out.println("Running query: "+sel4);
	            rs4=stmt.executeQuery(sel4);
	            if (rs4.next() ){
	                 if(rs4.getString("opt_name") != null ){
						opt_name[3]=rs4.getString("opt_name");
					} else {
						opt_name[3]="";
				 	}
	                 if (m<1){
	                     sched_max[5]=opt_name[3].length();
	                     }
	                 if(rs4.getString("opt_desc") != null ){
						opt3_long[m] = rs4.getString("opt_desc");
					} else {
						opt3_long[m] = "";
				 	}
	                 if(opt3_long[m].length() > sched_max[5]){
	                     sched_max[5]=opt3_long[m].length();
	                     }
	                 found_d=true;
	                 }
	            if (!found_d){
	                 out.println("Missing entry for option1="+opt3+". Please contact IT.");
	                 found_d=false;
	                 }
	            rs4.close();

	            if (VS_ID.equals("ADS")){
	                // Deal with nasty setup cost rules here - for option 3 = 3 or 4 add setup cost
	                if (opt3.equals("3") || opt3.equals("4") || opt3.equals("T") || opt3.equals("F")){
	                     setup_qty=setup_qty+Double.valueOf(sched_qty[m]).doubleValue();
	                     }
	                }

	            sel4 = "SELECT opt_name,opt_desc FROM CS_SCH_OPTS WHERE prod_id='"+VS_ID+"' AND opt_index='4' AND opt_code='"+opt4+"'";
				//out.println("Running query: "+sel4);
	            rs4=stmt.executeQuery(sel4);
	            if (rs4.next() ){
	                 if(rs4.getString("opt_name") != null ){
						opt_name[4]=rs4.getString("opt_name");
					} else {
						opt_name[4]="";
				 	}
	                 if (m<1){
	                     sched_max[6]=opt_name[4].length();
					 	}

		             if(rs4.getString("opt_desc") != null ){
						opt4_long[m] = rs4.getString("opt_desc") + sched_delim + opt4par;
					} else {
						opt4_long[m] = opt4par;
				 	}
	                 if(opt4_long[m].length() > sched_max[6]){
	                    sched_max[6]=opt4_long[m].length();
	                    }
	                  found_d=true;
	                 }
	            if (!found_d){
	                 out.println("Missing entry for option4="+opt4+". Please contact IT.");
	                 found_d=false;
	                 }
	            rs4.close();

	            }
	       }
	    }
	catch(Exception e1)
	{
	out.println("ERROR: While reading options... "+e1+"<BR>");
	}

	try   {
	    boolean found_d=false;
	    for( int m=0;m<rows;m++){
	        String sel10 = "SELECT description FROM CS_PROD_DESC WHERE code='"+model_c[m]+"'";
	        String sel11 = "SELECT description FROM CS_FINISH WHERE code='"+finish_c[m]+"'";
	        String sel12 = "SELECT description FROM CS_SCREEN WHERE code='"+screen_c[m]+"'";

			//out.println("Running query: "+sel10+"<br>");
	        ResultSet rs10=stmt.executeQuery(sel10);
	        if (rs10.next() ){
	             model_long[m]=rs10.getString("description");
	             found_d=true;
	             }
	        if (!found_d){
	             model_long[m]="Missing entry for product description. Please contact IT.";
	             found_d=false;
	             }
//out.println("Next: "+model_long[m]+"<br>");

			//out.println("Running query: "+sel11+"<br>");
	        ResultSet rs11=stmt.executeQuery(sel11);
	        if (rs11.next() ){
	             finish_long[m]=rs11.getString("description");
	             found_d=true;
	             }
	        if (!found_d){
	             finish_long[m]="Missing entry for finish description. Please contact IT.";
	             found_d=false;
	             }
//out.println("Next: "+finish_long[m]+"<br>");

			//out.println("Running query: "+sel12+"<br>");
	        ResultSet rs12=stmt.executeQuery(sel12);
	        if (rs12.next() ){
	             screen_long[m]=rs12.getString("description");
	             found_d=true;
	             }
	        if (!found_d){
	             screen_long[m]="Missing entry for screen description. Please contact IT.";
	             found_d=false;
	             }
//out.println("Next: "+screen_long[m]+"<br>");

	        rs10.close();
	        rs11.close();
	        rs12.close();
	       }
	    }
	catch(Exception e2)
	{
	out.println("ERROR: While reading descriptions... "+e2+"<BR>");
	}

	try   {


	    String blanks = "                    "; // 20 spaces
	    String mk = "Mark";
	    String qt = "Qty.";
	    String sz = "Size";
	    String options="";
	    //String linespec="";

		if( VI_HAS_OPTIONS > 0){
	        mk=mk + blanks.substring(0, sched_max[0] - 4);
	        qt=qt + blanks.substring(0, sched_max[1] - 4);
	        sz=sz + blanks.substring(0, sched_max[2] - 4);
	        String o1 = spacer + opt_name[1] + blanks.substring(0, sched_max[3] - opt_name[1].length());
	        String o2 = spacer + opt_name[2] + blanks.substring(0, sched_max[4] - opt_name[2].length());
	        if(opt_name[2].length()<2){o2 = "";}
	        String o3 = spacer + opt_name[3] + blanks.substring(0, sched_max[5] - opt_name[3].length());
	        if(opt_name[3].length()<2){o3 = "";}
	        String o4 = spacer + opt_name[4];
	        options = o1 + o2 + o3 + o4;
	        }
	    linespec = spacer+mk+spacer+qt+spacer+sz+options;
		//out.println("Line header: "+linespec);

//out.println("Rows="+rows+"<ROWS<BR>");
	    for( int m=0;m<rows;m++){
			// Create specs line
      String s1 = sched_mark[m] + blanks.substring(0, sched_max[0] - sched_mark[m].length());
	 String s2="";
	 if(sched_max[1]>=sched_qty[m].length()){
		s2 = sched_qty[m] + blanks.substring(0, sched_max[1] - sched_qty[m].length());
	 }
	 else{
		s2=sched_qty[m];
	 }
	       String s3 = sched_size[m] + blanks.substring(0, sched_max[2] - sched_size[m].length());

	        if( VI_HAS_OPTIONS > 0){
	            String s4 = spacer+opt1_long[m] + blanks.substring(0, sched_max[3] - opt1_long[m].length());
	            String s5 = "";
	            if(!(opts_c[m].substring(1,2).equals("0"))){
	            	s5 = spacer+opt2_long[m] + blanks.substring(0, sched_max[4] - opt2_long[m].length());
				}
	            String s6 = "";
	            if(!(opts_c[m].substring(2,3).equals("0"))){
	            	s6 = spacer+opt3_long[m] + blanks.substring(0, sched_max[5] - opt3_long[m].length());
				}
	            String s7 = spacer+opt4_long[m];
	            options = s4 + s5 + s6 + s7;
	            }
	        specs[m] = spacer+s1+spacer+s2+spacer+s3+options;

			// Test if description already exists
	        boolean present=false;
	        if (m>0) {
	            int j=0;
	            while (j<m) {
	                if (model_c[m].equals(model_c[j]) && finish_c[m].equals(finish_c[j]) && screen_c[m].equals(screen_c[j])) {
	                    present=true;
	                    }
	                 j++;
	                 }
	             }

	        if (!present) {
	             description[desc_grp]=model_long[m]+crlf+screen_long[m]+crlf+finish_long[m]+crlf+crlf;
//out.println("String: "+specs[m]+"<br>");
	             schedule[m]=desc_grp;
	             desc_grp++;
	            }
	        else {
	            boolean found=false;
	            int j=0;
	            while (j<m) {
	                if (!found && model_c[m].equals(model_c[j]) && finish_c[m].equals(finish_c[j]) && screen_c[m].equals(screen_c[j])) {
	                    found=true;
	                    schedule[m]=schedule[j];
	                    }
	                 j++;
	                }
             }
//out.println("Description for "+m+" is "+description[m]+"<br>");
//out.println("Schedule for "+m+" is "+schedule[m]+"<br>");
	        }

			// Create final description
	        VS_DESC="";
	        for (int m=0;m<desc_grp;m++) {
	            VS_SCHED = linespec +crlf;
//out.println("<BR>desc[m]="+description[m]+"<"+"<BR>");
	            VS_DESC = VS_DESC + description[m];
	            if (VI_TEST_TYPE > 0) {
	                int j=0;
	                while (j<rows) {
	                    if (schedule[j]==m) {
	                        VS_SCHED=VS_SCHED+specs[j]+crlf;
	                        }
	                    j++;
	                    }
	                VS_DESC=VS_DESC+VS_SCHED+crlf;
	                }

}

//out.println("<BR>DESCRIPTION="+VS_DESC+"<"+"<BR>");
	    }
	catch(Exception e3)
	{
	out.println("ERROR: While creating description... "+e3+"<BR>");
	}

	// Header formula - Create PSA header description based on quote type
//out.println("<font color='black'>run 'header' formula<BR>");

		String VS_CRLF = "\r\n";
		DescBid = "Addenda: " + add + VS_CRLF;
//out.println("<BR>qtype="+qtype+"<"+"<BR>");
//out.println("<BR>add="+add+"<"+"<BR>");
//out.println("<BR>desc="+desc+"<"+"<BR>");
//out.println("<BR>sect="+sect+"<"+"<BR>");
//out.println("<BR>date="+date+"<"+"<BR>");

		if(qtype.equals("TQ")){
    		DescBid = DescBid + "Proposal Based on Material Types and Quantities Listed Below:"  + VS_CRLF;
		}
		if(qtype.equals("SS")){
    		DescBid = DescBid + "Proposal Based on Material as Specified in Section "  + sect +VS_CRLF + "Quantities Listed Below:" + VS_CRLF;
		}
		if(qtype.equals("PD")){
    		DescBid = DescBid + "Proposal Based on Material as Described Below."  + VS_CRLF + "Quantities per Plans Dated: " + date + VS_CRLF;
		}
		if(qtype.equals("PS")){
    		DescBid = DescBid + "Proposal Based on Material as Specified in Section:"  + sect + VS_CRLF + "Quantities per Plans Dated:" + date + VS_CRLF;
		}
		VS_DESC = DescBid + VS_DESC;
out.println("<font color='blue'>Description for PSA = "+VS_DESC+"<BR>");

		// THIS IS THE END OF THE DESCRIPTION CREATION ROUTINE
		// end of Header formula

		// Reporting formula - Output pricing for reporting

		// clear csquotesY table
try{
	String del1="";
	if(isNotSec){
		del1="delete from cs_quotesy where quote_no='"+order_no+"' ";
	}
	else{
		del1="delete from cs_quotesy where quote_no='"+order_no+"' and line_no in("+sectionLines+")";
	}
	stmt.executeUpdate(del1);
}
catch (java.sql.SQLException e){
	out.println("Problem with deleting from cs_quotesy table");
	out.println("Illegal Operation try again/Report Error"+"<br>");
	myConn.rollback();
	out.println(e.toString());
	return;
}

		VR_RATIO = pInfSELLPRICE / pInfCOST;
//out.println("<font color='blue'>VR_RATIO = "+VR_RATIO+"<BR>");

		try {
		    String ins1 = "INSERT INTO CS_QUOTESY (quote_no, line_no, sequence_no, product_id, block_id, weight, qty, line_total) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
			   // out.println("Running query: "+ins1+"<br>");
		    PreparedStatement ps1=myConn.prepareStatement(ins1);
		    for(int i=0; i<rows; i++){
				ps1.setString(1, order_no);
		        ps1.setString(2, subl_c[i] + "");
		        ps1.setInt(3, (subl_c[i]) * 10);
		        ps1.setString(4, product_c[i]);
		        ps1.setString(5, model_c[i]);
		        ps1.setDouble(6, (new Double(weight_c[i]).doubleValue()));
		        ps1.setString(7, qty_c[i]);
		        ps1.setDouble(8, VR_RATIO * cost_c[i]);
				//out.println("1-"+order_no+"<br>");
		        //out.println("2-"+subl_c[i]+"<br>");
		        //out.println("3-"+(subl_c[i]) * 10+"<br>");
		        //out.println("4-"+product_c[i]+"<br>");
		        //out.println("5-"+model_c[i]+"<br>");
		        //out.println("6-"+weight_c[i]+"<br>");
		        //out.println("7-"+qty_c[i]+"<br>");
		        //out.println("8-"+VR_RATIO * cost_c[i]+"<br>");
		        ps1.executeUpdate();
		        }
		    ps1.close();
		    }
		catch(Exception e22)
		{
			myConn.rollback();
		out.println("ERROR inserting costing data... "+e22+"<br>");
		}

		// end of 'reporting' formula

		// beginning of DM record 'PSA Output'

		// clear csquotesZ table
try{
	String del2="";
	if(isNotSec){
		del2="delete from cs_quotesz where quote_no='"+order_no+"' ";
	}
	else{
		del2="delete from cs_quotesz where quote_no='"+order_no+"' and line_no ='"+section+"'";
	}
	stmt.executeUpdate(del2);
}
catch (java.sql.SQLException e){
	out.println("Problem with deleting from cs_quotesz table");
	out.println("Illegal Operation try again/Report Error"+"<br>");
	myConn.rollback();
	out.println(e.toString());
	return;
}

try{
	//out.println(order_no+"::"+VS_DESC+"::"+VR_WEIGHT+":: order no before cs_quotesz<BR>");
	String updateString ="INSERT INTO cs_quotesz (quote_no,line_no,product_id,description,line_total, block_id,sequence_no,units,currency_id,qty,weight,weight_unit,bid_type)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?) ";
	java.sql.PreparedStatement updateQuotesz = myConn.prepareStatement(updateString);
	updateQuotesz.setString(1,order_no);
	updateQuotesz.setString(2,section);
	updateQuotesz.setString(3,"ACCESS_CENTRAL");
		//out.println(VS_DESC+"<-- description <BR>");
	updateQuotesz.setString(4,VS_DESC);//vs_desc
	updateQuotesz.setString(5,pInfTOTAL+"");//pinftotal
	updateQuotesz.setString(6,id4export);//id4export
	updateQuotesz.setString(7,"10");
	updateQuotesz.setString(8,"EA");
	updateQuotesz.setString(9,"007");
	updateQuotesz.setString(10,"1");
	updateQuotesz.setString(11,VR_WEIGHT);//vr_weight
	updateQuotesz.setString(12,"LBS");

	updateQuotesz.setString(13,DESC);//desc



	int rocount=updateQuotesz.executeUpdate();
	//out.println(rocount+"::<BR>");
	updateQuotesz.close();
}
catch (java.sql.SQLException e){
	out.println("Problem with entering into cs_quotesz table");
	out.println("Illegal Operation try again/Report Error"+"<br>");
	myConn.rollback();
	out.println(e.toString());
	return;
}

		// end of DM record 'PSA Output'

} else if(ordertype.equals("O")){
	//replicate formula cleardmrecs_o
	// then replicate formula get_status
	//out.println("this is when cleardmrecs_o runs<BR>");
	//out.println("this is when get_status runs<BR>");
	}

myConn.commit();
stmt.close();
myConn.close();
if(!(VS_ID.equals("ADS"))){
%>
<body onLoad="javascript:document.location.href='sections.home.jsp?q_no=<%=order_no%>&cmd=1&product=<%=VS_ID%>'">
<form>
<%
}
else{
%>
<input type=button value="Close" onClick="javascript:document.location.href='sections.home.jsp?q_no=<%=order_no%>&cmd=1&product=<%=VS_ID%>'">
<%
}
%>
</form>
</body>
</html>