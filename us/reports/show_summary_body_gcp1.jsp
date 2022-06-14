<%
DecimalFormat df2 = new DecimalFormat("####.##");
df2.setMaximumFractionDigits(2);
df2.setMinimumFractionDigits(2);
for12.setMaximumFractionDigits(2);

String bgcolor="";
String html_ct="";
String html_cwa="";
String html_comp="";
String html_cta="";
String html_ctc="";
String html_install="";
int html_ct_count=0;
int html_cwa_count=0;
int html_comp_count=0;
int html_cta_count=0;
int html_ctc_count=0;
int html_install_count=0;
String html_ct_color="";
String html_cwa_color="";
String html_comp_color="";
String html_cta_color="";
String mesh_drop="";
String cur_height="";
String cur_width="";
String cur_qty="";
String cur_full="";
String cur_ftb="";
String cur_pan="";
String curtain_options="";
String cur_cst="";
String iv_cl="";
String iv_sl="";
String iv_acc="";
String cwa_color="";
String cwa_mount="";
String cwa_carrier="";
String cwa_ceiling="";
String cwa_track_length="";
String cwa_units="";
String cta_1="";
String cta_2="";
String cta_3="";
String totsf="";
String linyd="";
String meshyd="";
String pancurt="";
String curpan="";
String freight="";
String labcost="";
String fabcost="";
String meshcost="";
String customs="";
String commperc="";
String commdoll="";
String margperc="";
String margdoll="";
String cost_per="";
String above_floor="";
double curt_sell=0;
double track_sell=0;
double sum_sqft=0.00;
double sum_curp=0.00;
double sum_lnyd=0.00;
double sum_msyd=0.00;
double sum_cust=0.00;
double sum_frt=0.00;
double sum_fab=0.00;
double sum_mesh=0.00;
double sum_lab=0.00;
double totsqftcurt=0;
double totlfcurt=0;
double totlftrack=0;
double sumcommdoll=0;
double sumcommperc=0;
double summargdoll=0;
double summargperc=0;
Vector model=new Vector();
Vector lf=new Vector();

//sessions to hide certain rep fields on the report

//HttpSession UserSession_rep = request.getSession();

for(int k=0;k<line;k++){//doc_line

    String config_s0 = config_string.elementAt(k).toString();
    for (int mn=0;mn<line_item.size();mn++){
	    if ((line_item.elementAt(mn).toString()).equals((items.elementAt(k).toString()))){
		    String totwt=price.elementAt(mn).toString();//Extended_Price
		    BigDecimal d1 = new BigDecimal(totwt);
		    totprice=totprice+d1.doubleValue();//just the materail price no comission for the line
		    totprice_dis=totprice_dis+d1.doubleValue();
		    if ((block_id.elementAt(mn).toString()).equals("A_APRODUCT")){
			    description=(desc.elementAt(mn)).toString();//Description
		    }
	    }
    }
    int nscstx=config_s0.indexOf("TOTCOST[");
    if (nscstx >=0 ){
	    int ns1x=config_s0.indexOf("]",nscstx);
	    //out.println(config_s0.substring(nscstx+8,ns1x)+"::<BR>");
    }
    String[] trackblock = {"IVTRACK","IVTRACK","TRACKLEN","TRACKBEND","TRACKBEND"};
    String[] trackdetail={"CTRACK","STTRACK","TLENGTH","WS","AS"};
    for(int y=0; y<trackblock.length; y++){
	    String temptrack=config_s0;
	    int tempindex=temptrack.indexOf(trackblock[y]);
	    if(tempindex>=0){
		    temptrack=temptrack.substring(tempindex);
		    tempindex=temptrack.indexOf("&");
		    if(tempindex>0){
			    temptrack=temptrack.substring(0,tempindex);
		    }
		    tempindex=temptrack.indexOf(trackdetail[y]+"[");
		    if(tempindex>0){
			    temptrack=temptrack.substring(tempindex+trackdetail[y].length()+1);
			    tempindex=temptrack.indexOf("]");
			    if(tempindex>0){
				    temptrack=temptrack.substring(0,tempindex);
			    }
			    //out.println(temptrack+"::<BR><BR>");
			    totlftrack=totlftrack+new Double(temptrack).doubleValue();
		    }

	    }
    }

    if(description.endsWith("Curtain")){
	    if(html_ct_count==0){
		    html_ct=html_ct+"<font class='mainbodyh'><B>Curtain Summary :</B><br><br></font>";
		    html_ct=html_ct+"<table width='100%' align='center' cellspacing='1' cellpadding='2' border='0'>";
		    html_ct=html_ct+"<tr height='20'>";



		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-top: 1px solid; border-left: 1px solid; '><font class='schedule'><b>Item #</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-top: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Model</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-top: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Qty</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-top: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Curtain Width</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-top: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Ceiling Height</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-top: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Mesh/Drop</b></font></td>";
		    //html_ct=html_ct+"<td bgcolor='#006600' align='right'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Panels</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-top: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Curtain Options</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-top: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Pan/curt.</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-top: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Fullness</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-top: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Linear Yd</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-top: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Mesh Yd</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-top: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Total sq.ft</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-top: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Cost Per Yard</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-top: 1px solid; border-right: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Above Floor Finish</b></font></td>";
		    html_ct=html_ct+"</tr>";
		    html_ct=html_ct+"<tr height='20'>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-left: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;</font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;</font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Fabric cost</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Mesh cost</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Lab. cost</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Freight</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Accessories</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Customs</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Cost</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Price</b></font></td>";
		    if( !( usergroup.toUpperCase().startsWith("REP")) || usergroup.equals("Rep-Fact")){
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Comm%</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Comm$</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; '><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Margin%</b></font></td>";
		    html_ct=html_ct+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-right: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Margin$</b></font></td>";
		    }
		    html_ct=html_ct+"</tr>";
	    }
	    // The config string manipulations
	    if ((html_ct_count%2)==1){bgcolor="#e4e4e4";}else {bgcolor="#EFEFDE";}
	    //Getting the Mesh Drop
	    int recCount=0;
	    //items.elementAt(k).toString()
	    ResultSet rsDm=stmt.executeQuery("select * from cs_gcp_summary_report where order_no='"+order_no+"' and line_no='"+items.elementAt(k).toString()+"'");
	    if(rsDm != null){
		    while(rsDm.next()){
			    recCount++;
			    description=rsDm.getString("model");
			    cur_qty=rsDm.getString("qty");
			    cur_width=rsDm.getString("curt_width");
			    cur_height=rsDm.getString("ceiling_height");
			    mesh_drop=rsDm.getString("mesh_drop");
			    curtain_options=rsDm.getString("curt_options");
			    pancurt=rsDm.getString("pan_curt");
			    cur_full=rsDm.getString("fullness");
			    linyd=rsDm.getString("lin_yard");
			    meshyd=rsDm.getString("mesh_yard");
			    totsf=rsDm.getString("total_sqft");
			    cost_per=rsDm.getString("cost_per_yard");
			    above_floor=rsDm.getString("above_floor_finish");
			    fabcost=rsDm.getString("fabric_cost");
			    meshcost=rsDm.getString("mesh_cost");
			    labcost=rsDm.getString("lab_cost");
			    freight=rsDm.getString("freight");
			    cur_ftb=rsDm.getString("accessories");
			    customs=rsDm.getString("customs");
			    cur_cst=rsDm.getString("cost");
			    totprice=rsDm.getDouble("price");
			    commperc=rsDm.getString("comm_perc");
			    commdoll=rsDm.getString("comm_cost");
			    margperc=rsDm.getString("margin_perc");
			    margdoll=rsDm.getString("margin");
		    }
	    }
	    rsDm.close();


	    if(recCount<=0){
		    int nsdep=config_s0.indexOf("MESHDROP/");
		    if (nsdep >=0 ){
			    int ns1=config_s0.indexOf("&",nsdep);
			    // following added by AC if meshdrop is at the end of the string there is no '&' symbol to follow
			    if (ns1<0){ns1=config_s0.length();}
			    mesh_drop=config_s0.substring(nsdep+9,ns1);
			    if(mesh_drop.equals("STD")){mesh_drop="Standard 21\" mesh ";}
			    else if(mesh_drop.equals("BC16")){mesh_drop="16\" beadchain drop";}
			    else if(mesh_drop.equals("PVC16")){mesh_drop="16\" PVC Drop";}
			    else if(mesh_drop.startsWith("MESH[")){
				    int ns2=mesh_drop.indexOf("]");
				    mesh_drop=mesh_drop.substring(5,ns2);;
			    }
			    else {mesh_drop="NONE";}
		    }
		    else{
			    mesh_drop="N/A";
		    }

		    //Getting the Actual width
		    int nswidth=config_s0.indexOf("CURWIDTH[");
		    if (nswidth >=0 ){
			    int ns1=config_s0.indexOf("]",nswidth);
			    cur_width=config_s0.substring(nswidth+9,ns1);
		    }
		    else{
			    cur_width="NONE";
		    }

				    //Getting the Actual width
		    int nswidthx=config_s0.indexOf("CURDIM");
		    //out.println(nswidth);
		    if (nswidthx >=0 ){
			    int ns1=config_s0.indexOf("TRHT[",nswidthx);
			    int ns2=config_s0.indexOf("]",ns1);
			    if(ns1>=0){cur_height=config_s0.substring(ns1+5,ns2);}
			    else{
				    cur_height="NONE";
			    }
			    //out.println(config_s0.substring(nswidthx));
			    int nsabovefloor=config_s0.indexOf("FLFIN[",nswidthx);
			    int nsabovefloor2=config_s0.indexOf("]", nsabovefloor);
			    if(nsabovefloor>=0){above_floor=config_s0.substring(nsabovefloor+6,nsabovefloor2);}










		    }
		    else{
			    cur_height="NONE";
		    }
	    //Getting the Quantity
		    int nsqty=config_s0.indexOf("/QTY[");
		    if (nsqty >=0 ){
			    int ns1=config_s0.indexOf("]",nsqty);
			    cur_qty=config_s0.substring(nsqty+5,ns1);
		    }
		    else{
			    cur_qty="NONE";
		    }


		    int nsfull=config_s0.indexOf("CURTFULL/");
		    if(nsfull>0){
			    int ns1=config_s0.indexOf("&",nsfull);
			    if (ns1<0){ns1=config_s0.length();}
			    cur_full=config_s0.substring(nsfull+9,ns1);
			    //out.println(cur_full);
			    int ns2=cur_full.indexOf("[");
			    if(ns2>0){
				    int ns3=cur_full.indexOf("]");
				    cur_full=cur_full.substring(ns2,ns3);
			    }
		    }





		    //Getting the Misc
		    int nsftb=config_s0.indexOf("FTB[");
		    if (nsftb >=0 ){
			    int ns1=config_s0.indexOf("]",nsftb);
			    cur_ftb=config_s0.substring(nsftb+4,ns1);
		    }
		    else{
			    cur_ftb="NONE";
		    }


		    //Getting the cost
		    int nscst=config_s0.indexOf("TOTCOST[");
		    if (nscst >=0 ){
			    int ns1=config_s0.indexOf("]",nscst);
			    cur_cst=config_s0.substring(nscst+8,ns1);
		    }
		    else{
			    cur_cst="NONE";
		    }
		    int nscostper=config_s0.indexOf("GENCURT/PRICE[");
		    if (nscostper >=0 ){
			    int ns1=config_s0.indexOf("]",nscostper);
			    cost_per=config_s0.substring(nscostper+14,ns1);
		    }
		    else{
			    cost_per="NONE";
		    }

		    int nsdep1=config_s0.indexOf("REPORTS/");
		    if (nsdep1 >=0 ){
			    int ns1=config_s0.indexOf("FRTCOST[",nsdep1);
			    int ns2=config_s0.indexOf("]",ns1);
			    if(ns1>=0){freight=config_s0.substring(ns1+8,ns2);}
			    ns1=config_s0.indexOf("TOTSF[",nsdep1);
			    ns2=config_s0.indexOf("]",ns1);
			    if(ns1>=0){totsf=config_s0.substring(ns1+6,ns2);}
			    ns1=config_s0.indexOf("LINYD[",nsdep1);
			    ns2=config_s0.indexOf("]",ns1);
			    if(ns1>=0){linyd=config_s0.substring(ns1+6,ns2);}
			    ns1=config_s0.indexOf("MESHYD[",nsdep1);
			    ns2=config_s0.indexOf("]",ns1);
			    if(ns1>=0){meshyd=config_s0.substring(ns1+7,ns2);}
			    ns1=config_s0.indexOf("SGPAN[",nsdep1);
			    ns2=config_s0.indexOf("]",ns1);
			    if(ns1>=0){pancurt=config_s0.substring(ns1+6,ns2);}
			    ns1=config_s0.indexOf("CURTCOST[",nsdep1);
			    ns2=config_s0.indexOf("]",ns1);
			    if(ns1>=0){fabcost=config_s0.substring(ns1+9,ns2);}
			    ns1=config_s0.indexOf("MESHCOST[",nsdep1);
			    ns2=config_s0.indexOf("]",ns1);
			    if(ns1>=0){meshcost=config_s0.substring(ns1+9,ns2);}
			    ns1=config_s0.indexOf("LABCOST[",nsdep1);
			    ns2=config_s0.indexOf("]",ns1);
			    if(ns1>=0){labcost=config_s0.substring(ns1+8,ns2);}
			    ns1=config_s0.indexOf("CUSTOMS[",nsdep1);
			    ns2=config_s0.indexOf("]",ns1);
			    if(ns1>=0){customs=config_s0.substring(ns1+8,ns2);}
		    }
		    else{
			    nsdep1=config_s0.indexOf("CURTRPT/");
			    if (nsdep1 >=0 ){
				    //out.println(config_s0.substring(nsdep1)+"<BR><BR>");
				    int ns1=config_s0.indexOf("FRT[",nsdep1);
				    int ns2=config_s0.indexOf("]",ns1);
				    if(ns1>=0){freight=config_s0.substring(ns1+4,ns2);}
				    ns1=config_s0.indexOf("TOTSQFT[",nsdep1);
				    ns2=config_s0.indexOf("]",ns1);
				    if(ns1>=0){totsf=config_s0.substring(ns1+8,ns2);}
				    ns1=config_s0.indexOf("FABLNYD[",nsdep1);
				    ns2=config_s0.indexOf("]",ns1);
				    if(ns1>=0){linyd=config_s0.substring(ns1+8,ns2);}
				    ns1=config_s0.indexOf("MESHLNYD[",nsdep1);
				    ns2=config_s0.indexOf("]",ns1);
				    if(ns1>=0){meshyd=config_s0.substring(ns1+9,ns2);}
				    ns1=config_s0.indexOf("PANELS[",nsdep1);
				    ns2=config_s0.indexOf("]",ns1);
				    if(ns1>=0){pancurt=config_s0.substring(ns1+7,ns2);}
				    ns1=config_s0.indexOf("FABCOST[",nsdep1);
				    ns2=config_s0.indexOf("]",ns1);
				    if(ns1>=0){fabcost=config_s0.substring(ns1+8,ns2);}
				    ns1=config_s0.indexOf("MESHCOST[",nsdep1);
				    ns2=config_s0.indexOf("]",ns1);
				    if(ns1>=0){meshcost=config_s0.substring(ns1+9,ns2);}
				    ns1=config_s0.indexOf("LABOR[",nsdep1);
				    ns2=config_s0.indexOf("]",ns1);
				    if(ns1>=0){labcost=config_s0.substring(ns1+6,ns2);}
				    ns1=config_s0.indexOf("CUSTCH[",nsdep1);
				    ns2=config_s0.indexOf("]",ns1);
				    if(ns1>=0){customs=config_s0.substring(ns1+7,ns2);}

				    ns1=config_s0.indexOf("TOTCOST[",nsdep1);
				    ns2=config_s0.indexOf("]",ns1);
				    if(ns1>=0){cur_cst=config_s0.substring(ns1+8,ns2);}
			    }
		    }

		    int calcindex=config_s0.indexOf("CALC/");
		    //out.println(calcindex);
		    if(calcindex>0){
			    int endindex=config_s0.substring(calcindex).indexOf("]&");
			    if(endindex>=0){
				    endindex=endindex+1;
			    }
			    else{
				    endindex=config_s0.substring(calcindex).length();
			    }
			    //out.println(calcindex+"::"+endindex+"::INDexes<BR>");

			    //out.println(config_s0.substring(calcindex,(calcindex+endindex))+"::<BR><BR>");

			    String tempsubstring=config_s0.substring(calcindex,(calcindex+endindex));
			    int cs1=tempsubstring.indexOf("MARGINPERC[");
			    int cs2=0;
			    if(cs1>0){
				    cs2=tempsubstring.indexOf("]",cs1);
				    margperc=tempsubstring.substring(cs1+11,cs2);
			    }

			    cs1=tempsubstring.indexOf("COMMDOL[");
			    cs2=0;

			    if(cs1>0){
				    cs2=tempsubstring.indexOf("]",cs1);
				    //out.println(tempsubstring.substring(cs1,cs2)+"::<BR>");
				    commdoll=tempsubstring.substring(cs1+8,cs2);
				    //out.println(commdoll+"::"+sumcommdoll+"::<BR><BR>");
			    }

			    cs1=tempsubstring.indexOf("COMMPERCENT[");
			    cs2=0;
			    if(cs1>0){
				    cs2=tempsubstring.indexOf("]",cs1);
				    commperc=tempsubstring.substring(cs1+12,cs2);
			    }

		    }

		    int indexoption=config_s0.indexOf("CUROP/");
		    //out.println(indexoption+"::<BR>");
		    if(indexoption>0){
			    curtain_options="";
			    int endindexoption=config_s0.substring(indexoption).indexOf("&");
			    if(endindexoption>=0){
				    endindexoption=endindexoption;
			    }
			    else{
				    endindexoption=config_s0.substring(indexoption).length();
			    }
			    //out.println(config_s0.substring(indexoption+6,endindexoption+indexoption)+"::<BR>");
			    String tempoptions=","+config_s0.substring(indexoption+6,endindexoption+indexoption)+",";
			    if(tempoptions.indexOf("RR")>=0){
				    curtain_options="RR";
			    }
			    if(tempoptions.indexOf("REPEAT[")>=0){
				    if(curtain_options.length()>0){
					    curtain_options=curtain_options+", Seam";
				    }else{
					    curtain_options="Seam";
				    }
			    }
			    if(tempoptions.indexOf("WHEM")>=0){
				    if(curtain_options.length()>0){
					    curtain_options=curtain_options+", Weighted Hem";
				    }else{
					    curtain_options="Weighted Hem";
				    }
			    }
		    }

		    if(margperc.length()>0){
			    margdoll=""+(new Double(margperc).doubleValue()/100)*totprice;
		    }
	    }
	    // Cost summary table

	    sum_sqft=sum_sqft+ new Double(totsf).doubleValue();
	    sum_lnyd=sum_lnyd+ new Double(linyd).doubleValue();
	    sum_msyd=sum_msyd + new Double(meshyd).doubleValue();
	    sum_cust=sum_cust+ new Double(customs).doubleValue();
	    sum_frt=sum_frt+ new Double(freight).doubleValue();
	    sum_fab=sum_fab+ new Double(fabcost).doubleValue();
	    sum_mesh=sum_mesh+ new Double(meshcost).doubleValue();
	    sum_lab=sum_lab+ new Double(labcost).doubleValue();
	    if(commdoll.trim().length()==0){
		    commdoll="0";
	    }
	    sumcommdoll=sumcommdoll+new Double(commdoll).doubleValue();
	    summargdoll=summargdoll+new Double(margdoll).doubleValue();
	    curt_sell=curt_sell+totprice;
	    html_ct=html_ct+"<tr>";
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right' style='border-left: 1px solid; '><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+items.elementAt(k).toString()+"</p></td>";//line no
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+description+"</p></td>";//model
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+cur_qty+"</p></td>";//qty
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+cur_width+"</p></td>";//curtain width
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+cur_height+"</p></td>";//track height
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'> "+mesh_drop+"</p></td>";//mesh/drop
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+curtain_options+"</p></td>";//curtain options
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+pancurt+"</p></td>";//pan/curt
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+cur_full+"</p></td>";//fullness
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+linyd+"</p></td>";//linear yd
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+meshyd+"</p></td>";//mesh yd
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+totsf+"</p></td>";//totsqft
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+cost_per+"</p></td>";
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right' style=' border-right:1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+above_floor+"</p></td>";
	    html_ct=html_ct+"</tr>";
	    html_ct=html_ct+"<tr>";
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right' style='border-left: 1px solid; border-bottom: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;</p></td>";
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right' style='border-bottom: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;</p></td>";
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right' style='border-bottom: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>$"+fabcost+"</p></td>";//fabric cost
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right' style='border-bottom: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>$"+meshcost+"</p></td>";//mesh cost
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right' style='border-bottom: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>$"+labcost+"</p></td>";//lab cost
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right' style='border-bottom: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>$"+freight+"</p></td>";//frieght
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right' style='border-bottom: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+"Tieback: "+cur_ftb+"</p></td>";//accessories
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right' style='border-bottom: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>$"+customs+"</p></td>";//customs
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right' style='border-bottom: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+cur_cst+"</p></td>";//cost
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right' style='border-bottom: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+for1.format(totprice)+"</p></td>";//price
	    if( !(usergroup.toUpperCase().startsWith("REP")) || usergroup.equals("Rep-Fact")){
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right' style='border-bottom: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+commperc+" %</p></td>";
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right' style='border-bottom: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+for1.format(new Double(commdoll).doubleValue())+"</p></td>";
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right' style='border-bottom: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+margperc+" %</p></td>";
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right' style='border-bottom: 1px solid; border-right:1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+for1.format(new Double(margdoll).doubleValue())+"</p></td>";
	    }
	    html_ct=html_ct+"</tr>";

	    totsqftcurt=totsqftcurt+new Double(totsf).doubleValue();
	    totlfcurt=totlfcurt+new Double(linyd).doubleValue();
	    boolean ismatch=false;
	    int index=0;
	    for(int i=0;i<model.size(); i++){
		    if(model.elementAt(i).toString().equals(description)){
			    index=i;
			    ismatch=true;
			    double tempyd=new Double(lf.elementAt(i).toString()).doubleValue()+new Double(linyd).doubleValue();
			    lf.setElementAt(""+tempyd,i);
		    }
	    }
	    if(!ismatch){
		    model.addElement(description);
		    lf.addElement(linyd);
	    }
	    html_ct_count++;
    }
    else if (description.startsWith("IV Components")){
	    if(html_comp_count==0){
		    html_comp=html_comp+"<font class='mainbodyh'><B>IV Components :</B><br><br></font>";
		    html_comp=html_comp+"<table width='100%' align='center' cellspacing='1' cellpadding='2' border='0'>";
		    html_comp=html_comp+"<tr height='20'>";
		    html_comp=html_comp+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid; border-left: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Item #</b></font></p></td>";
		    html_comp=html_comp+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Curved Track(L)</b></font></p></td>";
		    html_comp=html_comp+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Straight Track(L)</b></font></p></td>";
		    html_comp=html_comp+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Accessories</b></font></p></td>";
		    html_comp=html_comp+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Price</b></font></p></td>";
		    if( !(usergroup.toUpperCase().startsWith("REP")) || usergroup.equals("Rep-Fact")){
		    html_comp=html_comp+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Comm%</b></font></p></td>";
		    html_comp=html_comp+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Comm$</b></font></p></td>";
		    html_comp=html_comp+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Margin%</b></font></p></td>";
		    html_comp=html_comp+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid; border-right: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Margin$</b></font></p></td>";
		    }
		    html_comp=html_comp+"</tr>";
	    }
	    if ((html_comp_count%2)==1){bgcolor="#e4e4e4";}else {bgcolor="#EFEFDE";}
	    //Getting the Curved Track and Straight track
	    int nsdep=config_s0.indexOf("IVTRACK/");
	    if (nsdep >=0 ){
		    int ns1=config_s0.indexOf("CTRACK[",nsdep);
		    int ns2=config_s0.indexOf("]",ns1);
		    if(ns1>0){iv_cl=config_s0.substring(ns1+7,ns2);}
	    }
	    else{
		    iv_cl="NONE";
	    }
	    //int nsdep1=config_s0.indexOf("IVTRACK/");
	    if (nsdep >=0 ){
		    int ns1=config_s0.indexOf("STTRACK[",nsdep);
		    int ns2=config_s0.indexOf("]",ns1);
		    if(ns1>0){iv_sl=config_s0.substring(ns1+8,ns2);}
	    }
	    else{
		    iv_sl="NONE";
	    }
	    //Accessories begin
	    int ivacc=config_s0.indexOf("IVACC/");
	    int ivacc_and=config_s0.indexOf("&",ivacc);
	    int ns1_24PEN=config_s0.indexOf("24PEN[",ivacc);
	    if ((ns1_24PEN > 0 )&(ns1_24PEN < ivacc_and )){
		    int ns2=config_s0.indexOf("]",ns1_24PEN);
		    iv_acc=" 24\" ss adjustable pendant: "+config_s0.substring(ns1_24PEN+6,ns2)+"<br>";
		    //out.println("1 "+ivacc+" 2 "+ivacc_and+" 3 "+ns1_24PEN);
	    }
	    int ns1_8BOT=config_s0.indexOf("8BOT[",ivacc);
	    if ((ns1_8BOT > 0 )&(ns1_8BOT < ivacc_and )){
		    int ns2=config_s0.indexOf("]",ns1_8BOT);
		    iv_acc=iv_acc+" 8 bottle pendant: "+config_s0.substring(ns1_8BOT+5,ns2)+"<br>";
	    }
	    int ns1_30PEN=config_s0.indexOf("30PEN[",ivacc);
	    if ((ns1_30PEN > 0 )&(ns1_30PEN < ivacc_and) ){
		    int ns2=config_s0.indexOf("]",ns1_30PEN);
		    iv_acc=iv_acc+" 30\" ss adjustable pendant: "+config_s0.substring(ns1_30PEN+6,ns2)+"<br>";
	    }
	    int ns1_36PEN=config_s0.indexOf("36PEN[",ivacc);
	    if ((ns1_36PEN > 0 )&(ns1_36PEN < ivacc_and)){
		    int ns2=config_s0.indexOf("]",ns1_36PEN);
		    iv_acc=iv_acc+" 36\" ss adjustable pendant: "+config_s0.substring(ns1_36PEN+6,ns2)+"<br>";
	    }
	    int ns1_6HANG=config_s0.indexOf("6HANG[",ivacc);
	    if ((ns1_6HANG > 0 )&(ns1_6HANG < ivacc_and) ){
		    int ns2=config_s0.indexOf("]",ns1_6HANG);
		    iv_acc=iv_acc+" 6\" stationary IV hangar: "+config_s0.substring(ns1_6HANG+6,ns2)+"<br>";
	    }
	    int ns1_IVEND=config_s0.indexOf("IVEND[",ivacc);
	    if ((ns1_IVEND > 0 )&(ns1_IVEND < ivacc_and )){
		    int ns2=config_s0.indexOf("]",ns1_IVEND);
		    iv_acc=iv_acc+" IV END: "+config_s0.substring(ns1_IVEND+6,ns2)+"<br>";
	    }
	    int ns1_TWLOCK=config_s0.indexOf("TWLOCK[",ivacc);
	    if ((ns1_TWLOCK > 0 )&(ns1_TWLOCK < ivacc_and )){
		    int ns2=config_s0.indexOf("]",ns1_TWLOCK);
		    iv_acc=iv_acc+" Twist Lock IV carrier: "+config_s0.substring(ns1_TWLOCK+7,ns2)+"<br>";
	    }
	    int ns1_IVSPLICE=config_s0.indexOf("IVSPLICE[",ivacc);
	    if ((ns1_IVSPLICE > 0 )&(ns1_IVSPLICE < ivacc_and) ){
		    int ns2=config_s0.indexOf("]",ns1_IVSPLICE);
		    iv_acc=iv_acc+" IV SPLICE: "+config_s0.substring(ns1_IVSPLICE+9,ns2)+"<br>";
	    }
	    int calcindex=config_s0.indexOf("CALC/");
	    if(calcindex>0){
		    int endindex=config_s0.substring(calcindex).indexOf("]&");
		    if(endindex<0){
			    endindex=config_s0.substring(calcindex).length();
		    }
		    else{
			    endindex++;
		    }
		    //out.println(config_s0.substring(calcindex,(calcindex+endindex))+"::<BR><BR>");
		    String tempsubstring=config_s0.substring(calcindex,(calcindex+endindex));
		    int cs1=tempsubstring.indexOf("MARGINPERC[");
		    int cs2=0;
		    if(cs1>0){
			    cs2=tempsubstring.indexOf("]",cs1);
			    margperc=tempsubstring.substring(cs1+11,cs2);
		    }
		    cs1=tempsubstring.indexOf("COMMDOL[");
		    cs2=0;
		    if(cs1>0){
			    cs2=tempsubstring.indexOf("]",cs1);
			    commdoll=tempsubstring.substring(cs1+8,cs2);
		    }
		    cs1=tempsubstring.indexOf("COMMPERCENT[");
		    cs2=0;
		    if(cs1>0){
			    cs2=tempsubstring.indexOf("]",cs1);
			    commperc=tempsubstring.substring(cs1+12,cs2);
		    }
	    }
	    if(margperc.length()>0){
		    margdoll=""+(new Double(margperc).doubleValue()/100)*totprice;
	    }
	    sumcommdoll=sumcommdoll+new Double(commdoll).doubleValue();
	    summargdoll=summargdoll+new Double(margdoll).doubleValue();
	    //accessories end
	    //out.println("THe curved track"+iv_cl);
	    html_comp=html_comp+"<tr height='20'>";
	    html_comp=html_comp+"<td valign='top' width='7%' nowrap bgcolor='"+bgcolor+"'  align='center'  style='border-bottom: 1px solid; border-top: 1px solid; border-left: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+items.elementAt(k).toString()+"</p></td>";
	    html_comp=html_comp+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+iv_cl+"</p></td>";
	    html_comp=html_comp+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+iv_sl+"</p></td>";
	    html_comp=html_comp+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+iv_acc+"</p></td>";
	    html_comp=html_comp+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+for1.format(totprice)+"</p></td>";
	    if( !(usergroup.toUpperCase().startsWith("REP")) || usergroup.equals("Rep-Fact")){
	    html_comp=html_comp+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+commperc+" %</p></td>";
	    html_comp=html_comp+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+for1.format(new Double(commdoll).doubleValue())+"</p></td>";
	    html_comp=html_comp+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+margperc+" %</p></td>";
	    html_comp=html_comp+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid; border-right: 1ps solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+for1.format(new Double(margdoll).doubleValue())+"</p></td>";
	    }
	    html_comp=html_comp+"</tr>";
	    html_comp_count++;
    }

    else if (description.startsWith("Curtain Track")){

	    if(html_cwa_count==0){
		    html_cwa=html_cwa+"<font class='mainbodyh'><B>Curtain Track W/Accessories :</B><br><br></font>";
		    html_cwa=html_cwa+"<table width='100%' align='center' cellspacing='1' cellpadding='2' border='0'>";
		    html_cwa=html_cwa+"<tr height='20'>";
		    html_cwa=html_cwa+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid; border-left: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Item #</b></font></p></td>";
		    html_cwa=html_cwa+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Color</b></font></p></td>";
		    html_cwa=html_cwa+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Mounting</b></font></p></td>";
		    html_cwa=html_cwa+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Ceiling</b></font></p></td>";
		    html_cwa=html_cwa+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Carrier</b></font></p></td>";
		    html_cwa=html_cwa+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Track Length</b></font></p></td>";
		    html_cwa=html_cwa+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Units</b></font></p></td>";
		    html_cwa=html_cwa+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Price</b></font></p></td>";
		    if( !(usergroup.toUpperCase().startsWith("REP")) || usergroup.equals("Rep-Fact")){
		    html_cwa=html_cwa+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Comm%</b></font></p></td>";
		    html_cwa=html_cwa+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Comm$</b></font></p></td>";
		    html_cwa=html_cwa+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Margin%</b></font></p></td>";
		    html_cwa=html_cwa+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid; border-right: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Margin$</b></font></p></td>";
		    }

		    html_cwa=html_cwa+"</tr>";
	    }

	    if ((html_cwa_count%2)==1){bgcolor="#e4e4e4";}else {bgcolor="#EFEFDE";}
	    // Getting the Color
	    int nsdep=config_s0.indexOf("COLOR/");
	    if (nsdep >=0 ){
		    int ns1=config_s0.indexOf("&",nsdep);
		    cwa_color=config_s0.substring(nsdep+6,ns1);
		    if(cwa_color.equals("ANO")){cwa_color="Anodized (grey)";}
		    else if(cwa_color.equals("WHITE")){cwa_color="White powder coating";}
		    else{cwa_color="NONE";}
	    }
	    else{
		    cwa_color="NONE";
	    }

	    //Getting the Mount Done
	    int nsdep_mount=config_s0.indexOf("MOUNT/");
	    if (nsdep_mount >=0 ){
		    //int ns1=config_s0.indexOf("&",nsdep_mount);
		    cwa_mount=config_s0.substring(nsdep_mount+6,nsdep_mount+10);
		    if(cwa_mount.equals("SURF")){cwa_mount="Surface";}
		    else if(cwa_mount.equals("SUSP")){cwa_mount="Suspended";}
		    else{cwa_mount="NONE";}
	    }
	    else{
		    cwa_mount="NONE";
	    }
	    //Getting the Carrier Done
	    int nsdep_carr=config_s0.indexOf("CARR/");
	    if (nsdep_carr >=0 ){
		    int ns1=config_s0.indexOf("&",nsdep_carr);

		    if(ns1<0){
				ns1=config_s0.length();
			}

		    cwa_carrier=config_s0.substring(nsdep_carr+5,ns1);

			if(cwa_carrier.trim().equals("1062N")){cwa_carrier="1062N";}
			else if(cwa_carrier.trim().equals("1075P")){cwa_carrier="1075P Breakaway Carrier";}
			else if(cwa_carrier.equals("975")){cwa_carrier="975 all Nylon";}
			else if(cwa_carrier.equals("975P")){cwa_carrier="975P nylon pop out";}
			else if(cwa_carrier.equals("ARN11")){cwa_carrier="ARN# 11 spool carrier";}
			else if(cwa_carrier.equals("SPV062")){cwa_carrier="Spool white Velcro break away (carrier)";}
else if(cwa_carrier.equals("SP062")){cwa_carrier="New spool carrier";}
			else{cwa_carrier="NONE";}
	    }
	    else{
		    cwa_carrier="NONE";
	    }

	    //Getting the Ceiling Done
	    int nsdep_ceiling=config_s0.indexOf("CEILING/");
	    if (nsdep_ceiling >=0 ){
		    int ns1=config_s0.indexOf("&",nsdep_ceiling);
			if(ns1<nsdep_ceiling){
			 cwa_ceiling=config_s0.substring(nsdep_ceiling+8);
}
else{
		    cwa_ceiling=config_s0.substring(nsdep_ceiling+8,ns1);
}
		    if(cwa_ceiling.equals("AC")){cwa_ceiling="Acoustic tile";}
		    else if(cwa_ceiling.equals("TE")){cwa_ceiling="Tegular tile";}
		    else{cwa_ceiling="NONE";}
	    }
	    else{
		    cwa_ceiling="NONE";
	    }
	    // Track Length and no of units

	    int track_length=config_s0.indexOf("TRACKLEN/");
//out.println(config_s0.substring(track_length)+"<BR>");
	    int ns1_TLEN=config_s0.indexOf("TLENGTH[",track_length);
//out.println(config_s0.substring(ns1_TLEN)+"<BR><BR>");
	    if (ns1_TLEN >0 ){
		    int ns2=config_s0.indexOf("]",ns1_TLEN);
		   // out.println(config_s0.substring(0,ns2)+"<BR><BR>");
		    //out.println(config_s0.substring(ns1_TLEN)+"<BR>");
		    cwa_track_length=config_s0.substring(ns1_TLEN+8,ns2);
	    }
	    int ns1_TUNITS=config_s0.indexOf("UNITS[",track_length);
	    if (ns1_TUNITS >0 ){
		    int ns2=config_s0.indexOf("]",ns1_TUNITS);
		    cwa_units=config_s0.substring(ns1_TUNITS+6,ns2);
	    }
	    int calcindex=config_s0.indexOf("CALC/");
	    if(calcindex>0){
		    int endindex=config_s0.substring(calcindex).indexOf("&");
		    if(endindex<0){
			    endindex=config_s0.substring(calcindex).length();
		    }
		    //out.println(config_s0.substring(calcindex,(calcindex+endindex))+"::<BR><BR>");
		    String tempsubstring=config_s0.substring(calcindex,(calcindex+endindex));
		    int cs1=tempsubstring.indexOf("MARGINPERC[");
		    int cs2=0;
		    if(cs1>0){
			    cs2=tempsubstring.indexOf("]",cs1);
			    margperc=tempsubstring.substring(cs1+11,cs2);
		    }
		    cs1=tempsubstring.indexOf("COMMDOL[");
		    cs2=0;
		    if(cs1>0){
			    cs2=tempsubstring.indexOf("]",cs1);
			    commdoll=tempsubstring.substring(cs1+8,cs2);
		    }
		    cs1=tempsubstring.indexOf("COMMPERCENT[");
		    cs2=0;
		    if(cs1>0){
			    cs2=tempsubstring.indexOf("]",cs1);
			    commperc=tempsubstring.substring(cs1+12,cs2);
		    }
	    }
	    if(margperc.length()>0){
		    margdoll=""+(new Double(margperc).doubleValue()/100)*totprice;
	    }

	    sumcommdoll=sumcommdoll+new Double(commdoll).doubleValue();
	    summargdoll=summargdoll+new Double(margdoll).doubleValue();
	    track_sell=track_sell+totprice;
	    html_cwa=html_cwa+"<tr height='20'>";
	    html_cwa=html_cwa+"<td valign='top' width='8%' nowrap bgcolor='"+bgcolor+"'  align='center' style='border-bottom: 1px solid; border-top: 1px solid; border-left: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+items.elementAt(k).toString()+"</p></td>";
	    html_cwa=html_cwa+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+cwa_color+"</p></td>";
	    html_cwa=html_cwa+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+cwa_mount+"</p></td>";
	    html_cwa=html_cwa+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+cwa_ceiling+"</p></td>";
	    html_cwa=html_cwa+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+cwa_carrier+"</p></td>";
	    html_cwa=html_cwa+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+cwa_track_length+"</p></td>";
	    html_cwa=html_cwa+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+cwa_units+"</p></td>";
	    html_cwa=html_cwa+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+for1.format(totprice)+"</p></td>";
	    if( !(usergroup.toUpperCase().startsWith("REP")) || usergroup.equals("Rep-Fact")){
	    html_cwa=html_cwa+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+commperc+" %</p></td>";
	    html_cwa=html_cwa+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+for1.format(new Double(commdoll).doubleValue())+"</p></td>";
	    html_cwa=html_cwa+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+margperc+" %</p></td>";
	    html_cwa=html_cwa+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid; border-right: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+for1.format(new Double(margdoll).doubleValue())+"</p></td>";
	    }
	    html_cwa=html_cwa+"</tr>";
	    html_cwa_count++;
    }

    else if (description.startsWith("Custom")){
	    if(html_ctc_count==0){
		    html_ctc=html_ctc+"<font class='mainbodyh'><B>Custom Components :</B><br><br></font>";
		    html_ctc=html_ctc+"<table width='100%' align='center' cellspacing='1' cellpadding='2' border='0'>";
		    html_ctc=html_ctc+"<tr height='20'>";
		    html_ctc=html_ctc+"<td bgcolor='#006600' align='right'><font class='schedule' style='border-bottom: 1px solid; border-top: 1px solid; border-left: 1px solid;'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Item #</b></font></td>";
		    html_ctc=html_ctc+"<td bgcolor='#006600' align='right'><font class='schedule' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Component Description</b></font></td>";
		    html_ctc=html_ctc+"<td bgcolor='#006600' align='right'><font class='schedule' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Quantity</b></font></td>";
		    html_ctc=html_ctc+"<td bgcolor='#006600' align='right'><font class='schedule' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Unit Price</b></font></td>";
		    html_ctc=html_ctc+"<td bgcolor='#006600' align='right'><font class='schedule' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Price</b></font></td>";
		    if( !(usergroup.toUpperCase().startsWith("REP")) || usergroup.equals("Rep-Fact")){
		    html_ctc=html_ctc+"<td bgcolor='#006600' align='right'><font class='schedule' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Comm%</b></font></td>";
		    html_ctc=html_ctc+"<td bgcolor='#006600' align='right'><font class='schedule' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Comm$</b></font></td>";
		    html_ctc=html_ctc+"<td bgcolor='#006600' align='right'><font class='schedule' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Margin%</b></font></td>";
		    html_ctc=html_ctc+"<td bgcolor='#006600' align='right'><font class='schedule' style='border-bottom: 1px solid; border-top: 1px solid; border-right: 1px solid;'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Margin$</b></font></td>";
		    }
		    html_ctc=html_ctc+"</tr>";

	    }

	    String q1="";String p1="";String d1="";
	    String q2="";String p2="";String d2="";
	    String q3="";String p3="";String d3="";
	    String q4="";String p4="";String d4="";
	    String q5="";String p5="";String d5="";
	    String qty="";String prc="";String dsc="";
	    int nsdep1=config_s0.indexOf("CUSTOM/");
	    if (nsdep1 >=0 ){
		    int ns1=config_s0.indexOf("QTY1[",nsdep1);
		    int ns2=config_s0.indexOf("]",ns1);
		    q1=config_s0.substring(ns1+5,ns2);
		    ns1=config_s0.indexOf("PRICE1[",nsdep1);
		    ns2=config_s0.indexOf("]",ns1);
		    p1="$"+config_s0.substring(ns1+7,ns2);

		    ns1=config_s0.indexOf("QTY2[",nsdep1);
		    if (ns1>0){
			    ns2=config_s0.indexOf("]",ns1);
			    q2="<br>"+config_s0.substring(ns1+5,ns2);
		    }
		    ns1=config_s0.indexOf("PRICE2[",nsdep1);
		    if (ns1>0){
			    ns2=config_s0.indexOf("]",ns1);
			    p2="<br>$"+config_s0.substring(ns1+7,ns2);
		    }

		    ns1=config_s0.indexOf("QTY3[",nsdep1);
		    if (ns1>0){
			    ns2=config_s0.indexOf("]",ns1);
			    q3="<br>"+config_s0.substring(ns1+5,ns2);
		    }
		    ns1=config_s0.indexOf("PRICE3[",nsdep1);
		    if (ns1>0){
			    ns2=config_s0.indexOf("]",ns1);
			    p3="<br>$"+config_s0.substring(ns1+7,ns2);
		    }

		    ns1=config_s0.indexOf("QTY4[",nsdep1);
		    if (ns1>0){
			    ns2=config_s0.indexOf("]",ns1);
			    q4="<br>"+config_s0.substring(ns1+5,ns2);
		    }
		    ns1=config_s0.indexOf("PRICE4[",nsdep1);
		    if (ns1>0){
			    ns2=config_s0.indexOf("]",ns1);
			    p4="<br>$"+config_s0.substring(ns1+7,ns2);
		    }

		    ns1=config_s0.indexOf("QTY5[",nsdep1);
		    if (ns1>0){
			    ns2=config_s0.indexOf("]",ns1);
			    q5="<br>"+config_s0.substring(ns1+5,ns2);
		    }
		    ns1=config_s0.indexOf("PRICE5[",nsdep1);
		    if (ns1>0){
			    ns2=config_s0.indexOf("]",ns1);
			    p5="<br>$"+config_s0.substring(ns1+7,ns2);
		    }

		    qty=q1+q2+q3+q4+q5;
		    prc=p1+p2+p3+p4+p5;
	    }
	    nsdep1=config_s0.indexOf("CUSTDESC/");

	    if (nsdep1 >=0 ){
		    int ns1=config_s0.indexOf("DESC1[",nsdep1);
		    int ns2=config_s0.indexOf("]",ns1);
		    d1=config_s0.substring(ns1+6,ns2);

		    ns1=config_s0.indexOf("DESC2[",nsdep1);
		    if (ns1>0){
			    ns2=config_s0.indexOf("]",ns1);
			    d2="<br>"+config_s0.substring(ns1+6,ns2);
		    }

		    ns1=config_s0.indexOf("DESC3[",nsdep1);
		    if (ns1>0){
			    ns2=config_s0.indexOf("]",ns1);
			    d3="<br>"+config_s0.substring(ns1+6,ns2);
		    }

		    ns1=config_s0.indexOf("DESC4[",nsdep1);
		    if (ns1>0){
			    ns2=config_s0.indexOf("]",ns1);
			    d4="<br>"+config_s0.substring(ns1+6,ns2);
		    }

		    ns1=config_s0.indexOf("DESC5[",nsdep1);
		    if (ns1>0){
			    ns2=config_s0.indexOf("]",ns1);
			    d5="<br>"+config_s0.substring(ns1+6,ns2);
		    }
		    dsc=d1+d2+d3+d4+d5;
	    }
	    int calcindex=config_s0.indexOf("CALC/");

	    if(calcindex>0){
		    int endindex=config_s0.substring(calcindex).indexOf("&");
		    if(endindex<0){
			    endindex=config_s0.substring(calcindex).length();
		    }
		    //out.println(config_s0.substring(calcindex,(calcindex+endindex))+"::<BR><BR>");
		    String tempsubstring=config_s0.substring(calcindex,(calcindex+endindex));
		    int cs1=tempsubstring.indexOf("MARGINPERC[");
		    int cs2=0;
		    if(cs1>0){
			    cs2=tempsubstring.indexOf("]",cs1);
			    margperc=tempsubstring.substring(cs1+11,cs2);
		    }
		    cs1=tempsubstring.indexOf("COMMDOL[");
		    cs2=0;
		    if(cs1>0){
			    cs2=tempsubstring.indexOf("]",cs1);
			    commdoll=tempsubstring.substring(cs1+8,cs2);
		    }
		    cs1=tempsubstring.indexOf("COMMPERCENT[");
		    cs2=0;
		    if(cs1>0){
			    cs2=tempsubstring.indexOf("]",cs1);
			    commperc=tempsubstring.substring(cs1+12,cs2);
		    }
	    }
	    if(margperc.length()>0){
		    margdoll=""+(new Double(margperc).doubleValue()/100)*totprice;
	    }
	    if(commdoll ==null || commdoll.trim().length()==0){
		    commdoll="0";
	    }
	    if(margdoll ==null || margdoll.trim().length()==0){
		    margdoll="0";
	    }
	    sumcommdoll=sumcommdoll+new Double(commdoll).doubleValue();
	    summargdoll=summargdoll+new Double(margdoll).doubleValue();

	    html_ctc=html_ctc+"<tr height='20'>";

	    html_ctc=html_ctc+"<td valign='top' width='8%' nowrap bgcolor='"+bgcolor+"'  align='center' style='border-bottom: 1px solid; border-top: 1px solid; border-left: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+items.elementAt(k).toString()+"</p></td>";
	    html_ctc=html_ctc+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+dsc+"</p></td>";
	    html_ctc=html_ctc+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+qty+"</p></td>";
	    html_ctc=html_ctc+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+prc+"</p></td>";
	    html_ctc=html_ctc+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+for1.format(totprice)+"</p></td>";
	    if( !( usergroup.toUpperCase().startsWith("REP")) || usergroup.equals("Rep-Fact")){
	    html_ctc=html_ctc+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+commperc+" %</p></td>";
	    html_ctc=html_ctc+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+for1.format(new Double(commdoll).doubleValue())+"</p></td>";
	    html_ctc=html_ctc+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+margperc+" %</p></td>";
	    html_ctc=html_ctc+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid; border-right: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+for1.format(new Double(margdoll).doubleValue())+"</p></td>";
	    }
	    html_ctc=html_ctc+"</tr>";
	    html_ctc_count++;

    }

    else if (description.startsWith("Install")){
	    if(html_install_count==0){
		    html_install=html_install+"<font class='mainbodyh'><B>Install :</B><br><br></font>";
		    html_install=html_install+"<table width='100%' align='center' cellspacing='1' cellpadding='2' border='0'>";
		    html_install=html_install+"<tr height='20'>";
		    html_install=html_install+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid; border-left: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Item #</b></font></td>";
		    html_install=html_install+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Description</b></font></td>";
		    html_install=html_install+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Price</b></font></td>";
		    if( !(usergroup.toUpperCase().startsWith("REP")) || usergroup.equals("Rep-Fact")){
		    html_install=html_install+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Comm%</b></font></td>";
		    html_install=html_install+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Comm$</b></font></td>";
		    html_install=html_install+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Margin%</b></font></td>";
		    html_install=html_install+"<td bgcolor='#006600' align='right' style='border-bottom: 1px solid; border-top: 1px solid; border-right: 1px solid;'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Margin$</b></font></td>";
		    }
		    html_install=html_install+"</tr>";

	    }
	    int calcindex=config_s0.indexOf("CALC/");
	    if(calcindex>-1){
		    int endindex=config_s0.substring(calcindex).indexOf("&");
		    if(endindex<0){
			    endindex=config_s0.substring(calcindex).length();
		    }
		    //out.println(config_s0.substring(calcindex,(calcindex+endindex))+"::<BR><BR>");
		    String tempsubstring=config_s0.substring(calcindex,(calcindex+endindex));
		    int cs1=tempsubstring.indexOf("MARGINPERC[");
		    int cs2=0;
		    if(cs1>0){
			    cs2=tempsubstring.indexOf("]",cs1);
			    margperc=tempsubstring.substring(cs1+11,cs2);
		    }
		    cs1=tempsubstring.indexOf("COMMDOL[");
		    cs2=0;
		    if(cs1>0){
			    cs2=tempsubstring.indexOf("]",cs1);
			    commdoll=tempsubstring.substring(cs1+8,cs2);
		    }
		    cs1=tempsubstring.indexOf("COMMPERCENT[");
		    cs2=0;
		    if(cs1>0){
			    cs2=tempsubstring.indexOf("]",cs1);
			    commperc=tempsubstring.substring(cs1+12,cs2);
		    }
	    }
	    if(margperc.length()>0){
		    margdoll=""+(new Double(margperc).doubleValue()/100)*totprice;
	    }
	    sumcommdoll=sumcommdoll+new Double(commdoll).doubleValue();
	    summargdoll=summargdoll+new Double(margdoll).doubleValue();
	    html_install=html_install+"<tr height='20'>";
	    html_install=html_install+"<td valign='top' nowrap bgcolor='"+bgcolor+"'  align='center' style='border-bottom: 1px solid; border-top: 1px solid; border-left: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+items.elementAt(k).toString()+"</p></td>";
	    html_install=html_install+"<td bgcolor='"+bgcolor+"'  align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>Installation</p></td>";
	    html_install=html_install+"<td bgcolor='"+bgcolor+"'  align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+for1.format(totprice)+"</p></td>";
	    if( !(usergroup.toUpperCase().startsWith("REP")) || usergroup.equals("Rep-Fact")){
	    html_install=html_install+"<td bgcolor='"+bgcolor+"'  align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+commperc+" %</p></td>";
	    html_install=html_install+"<td bgcolor='"+bgcolor+"'  align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+for1.format(new Double(commdoll).doubleValue())+"</p></td>";
	    html_install=html_install+"<td bgcolor='"+bgcolor+"'  align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+margperc+" %</p></td>";
	    html_install=html_install+"<td bgcolor='"+bgcolor+"'  align='right' style='border-bottom: 1px solid; border-top: 1px solid; border-right: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+for1.format(new Double(margdoll).doubleValue())+"</p></td>";
	    }
	    html_install=html_install+"</tr>";
	    html_install_count++;
    }
    else {
	    if(html_cta_count==0){
		    html_cta=html_cta+"<font class='mainbodyh'><B>Curtain Track Accessories :</B><br><br></font>";
		    html_cta=html_cta+"<table width='100%' align='center' cellspacing='1' cellpadding='2' border='0'>";
		    html_cta=html_cta+"<tr height='20'>";
		    html_cta=html_cta+"<td bgcolor='#006600' align='right'><font class='schedule' style='border-bottom: 1px solid; border-top: 1px solid; border-left: 1px solid;'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Item #</b></font></td>";
		    html_cta=html_cta+"<td bgcolor='#006600' align='right'><font class='schedule' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Curtain Track Without Accessories</b></font></td>";
		    html_cta=html_cta+"<td bgcolor='#006600' align='right'><font class='schedule' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Track Accessories</b></font></td>";
		    html_cta=html_cta+"<td bgcolor='#006600' align='right'><font class='schedule' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Carriers</b></font></td>";
		    html_cta=html_cta+"<td bgcolor='#006600' align='right'><font class='schedule' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Price</b></font></td>";
		    if( !(usergroup.toUpperCase().startsWith("REP")) || usergroup.equals("Rep-Fact")){
		    html_cta=html_cta+"<td bgcolor='#006600' align='right'><font class='schedule' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Comm%</b></font></td>";
		    html_cta=html_cta+"<td bgcolor='#006600' align='right'><font class='schedule' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Comm$</b></font></td>";
		    html_cta=html_cta+"<td bgcolor='#006600' align='right'><font class='schedule' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Margin%</b></font></td>";
		    html_cta=html_cta+"<td bgcolor='#006600' align='right'><font class='schedule' style='border-bottom: 1px solid; border-top: 1px solid; border-right: 1px solid;'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Margin$</b></font></td>";
		    }
		    html_cta=html_cta+"</tr>";
	    }
	    if ((html_cta_count%2)==1){bgcolor="#e4e4e4";}else {bgcolor="#EFEFDE";}
	    int cta_begin=config_s0.indexOf("TRACKBEND/");
	    int cta_end=config_s0.indexOf("&",cta_begin);
	    if(cta_begin>=0){
		    int ns1_WS=config_s0.indexOf("WS[",cta_begin);
		    //out.println("1 "+cta_begin+" 2 "+ns1_WS);
		    if ((ns1_WS >0 )&(ns1_WS< cta_end )){
			    int ns2=config_s0.indexOf("]",ns1_WS);
			    cta_1=" Straight track set- white(ft): "+config_s0.substring(ns1_WS+3,ns2)+"<br>";
		    }
		    int ns1_WSUNITS=config_s0.indexOf("WSUNITS[",cta_begin);
		    if ((ns1_WSUNITS >0 )&(ns1_WSUNITS< cta_end )){
			    int ns2=config_s0.indexOf("]",ns1_WSUNITS);
			    cta_1=cta_1+" Straight WHITE track sect units: "+config_s0.substring(ns1_WSUNITS+8,ns2)+"<br>";
		    }
		    int ns1_AS=config_s0.indexOf("AS[",cta_begin);
		    if ((ns1_AS >0 )&(ns1_AS< cta_end )){
			    int ns2=config_s0.indexOf("]",ns1_AS);
			    cta_1=cta_1+" Straight track set- anodized(ft):"+config_s0.substring(ns1_AS+3,ns2)+"<br>";
		    }
		    int ns1_ASUNITS=config_s0.indexOf("ASUNITS[",cta_begin);
		    if ((ns1_ASUNITS >0 )&(ns1_ASUNITS< cta_end )){
			    int ns2=config_s0.indexOf("]",ns1_ASUNITS);
			    cta_1=cta_1+" Straight ano. track sect units: "+config_s0.substring(ns1_ASUNITS+8,ns2)+"<br>";
		    }
		    int ns1_WLB=config_s0.indexOf("WLB[",cta_begin);
		    if ((ns1_WLB >0 )&(ns1_WLB< cta_end )){
			    int ns2=config_s0.indexOf("]",ns1_WLB);
			    cta_1=cta_1+" Large bend-white (ea. ): "+config_s0.substring(ns1_WLB+4,ns2)+"<br>";
		    }
		    int ns1_ALB=config_s0.indexOf("ALB[",cta_begin);
		    if ((ns1_ALB >0 )&(ns1_ALB< cta_end )){
			    int ns2=config_s0.indexOf("]",ns1_ALB);
			    cta_1=cta_1+" Large  bend-anodized(ea.): "+config_s0.substring(ns1_ALB+4,ns2)+"<br>";
		    }
		    int ns1_WSB=config_s0.indexOf("WSB[",cta_begin);
		    if ((ns1_WSB >0 )&(ns1_WSB< cta_end )){
			    int ns2=config_s0.indexOf("]",ns1_WSB);
			    cta_1=cta_1+" Small bend-white (ea. ): "+config_s0.substring(ns1_WSB+4,ns2)+"<br>";
		    }
		    int ns1_ASB=config_s0.indexOf("ASB[",cta_begin);
		    if ((ns1_ASB >0 )&(ns1_ASB< cta_end )){
			    int ns2=config_s0.indexOf("]",ns1_ASB);
			    cta_1=cta_1+" Small  bend-anodized(ea.): "+config_s0.substring(ns1_ASB+4,ns2)+"<br>";
		    }
		    int ns1_W45=config_s0.indexOf("W45[",cta_begin);
		    if ((ns1_W45 >0 )&(ns1_W45< cta_end )){
			    int ns2=config_s0.indexOf("]",ns1_W45);
			    cta_1=cta_1+" 45 degree-white (ea. ): "+config_s0.substring(ns1_W45+4,ns2)+"<br>";
		    }
		    int ns1_A45=config_s0.indexOf("A45[",cta_begin);
		    if ((ns1_A45 >0 )&(ns1_A45< cta_end )){
			    int ns2=config_s0.indexOf("]",ns1_A45);
			    cta_1=cta_1+" 45  degree-anodized(ea.): "+config_s0.substring(ns1_A45+4,ns2)+"<br>";
		    }
		    int ns1_WLO=config_s0.indexOf("WLO18[",cta_begin);
		    if ((ns1_WLO >0 )&(ns1_WLO< cta_end )){
			    int ns2=config_s0.indexOf("]",ns1_WLO);
			    cta_1=cta_1+" 18\" left offset-white (ea. ): "+config_s0.substring(ns1_WLO+6,ns2)+"<br>";
		    }
		    int ns1_WRO=config_s0.indexOf("WRO18[",cta_begin);
		    if ((ns1_WRO >0 )&(ns1_WRO< cta_end )){
			    int ns2=config_s0.indexOf("]",ns1_WRO);
			    cta_1=cta_1+" 18\" right offset-white (ea.): "+config_s0.substring(ns1_WRO+6,ns2)+"<br>";
		    }
		    int ns1_ALO=config_s0.indexOf("ALO18[",cta_begin);
		    if ((ns1_ALO >0 )&(ns1_ALO< cta_end )){
			    int ns2=config_s0.indexOf("]",ns1_ALO);
			    cta_1=cta_1+" 18\" left offset-anodized (ea. ): "+config_s0.substring(ns1_ALO+6,ns2)+"<br>";
		    }
		    int ns1_ARO=config_s0.indexOf("ARO18[",cta_begin);
		    if ((ns1_ARO >0 )&(ns1_ARO< cta_end )){
			    int ns2=config_s0.indexOf("]",ns1_ARO);
			    cta_1=cta_1+" 18\" right offset-anodized (ea.): "+config_s0.substring(ns1_ARO+6,ns2)+"<br>";
		    }
		    int ns1_WLO24=config_s0.indexOf("WLO24[",cta_begin);
		    if ((ns1_WLO24 >0 )&(ns1_WLO24< cta_end )){
			    int ns2=config_s0.indexOf("]",ns1_WLO24);
			    cta_1=cta_1+" 24\" left offset-white (ea. ): "+config_s0.substring(ns1_WLO24+6,ns2)+"<br>";
		    }
		    int ns1_WRO24=config_s0.indexOf("WRO24[",cta_begin);
		    if ((ns1_WRO24 >0 )&(ns1_WRO24< cta_end )){
			    int ns2=config_s0.indexOf("]",ns1_WRO24);
			    cta_1=cta_1+" 24\" right offset-white (ea.): "+config_s0.substring(ns1_WRO24+6,ns2)+"<br>";
		    }
		    int ns1_ALO24=config_s0.indexOf("ALO24[",cta_begin);
		    if ((ns1_ALO24 >0 )&(ns1_ALO24< cta_end )){
			    int ns2=config_s0.indexOf("]",ns1_ALO24);
			    cta_1=cta_1+" 24\" left offset-anodized (ea. ): "+config_s0.substring(ns1_ALO24+6,ns2)+"<br>";
		    }
		    int ns1_ARO24=config_s0.indexOf("ARO24[",cta_begin);
		    if ((ns1_ARO24 >0 )&(ns1_ARO24< cta_end )){
			    int ns2=config_s0.indexOf("]",ns1_ARO24);
			    cta_1=cta_1+" 24\" right offset-anodized (ea.): "+config_s0.substring(ns1_ARO24+6,ns2)+"<br>";
		    }
	    }
	    //Track accessiores begin
	    int cta_begin_acc=config_s0.indexOf("TRACKACC/");
//out.println(config_s0.substring(cta_begin_acc));
	    //int cta_end_acc=config_s0.indexOf("&",cta_begin_acc);
	    if(cta_begin_acc>=0){
			int endX=config_s0.indexOf("&",cta_begin_acc);
		    int ns1_90CON=config_s0.indexOf("90CON[",cta_begin_acc);
		    if (ns1_90CON > 0 && endX>ns1_90CON){
			    int ns2=config_s0.indexOf("]",ns1_90CON);
			    cta_2=cta_2+" 90 degree connector: "+config_s0.substring(ns1_90CON+6,ns2)+"<br>";
		    }

		    int ns1_WSPL=config_s0.indexOf("WSPL[",cta_begin_acc);
		    if (ns1_WSPL > 0 && endX>ns1_WSPL){
			    int ns2=config_s0.indexOf("]",ns1_WSPL);
			    cta_2=cta_2+" Splice (White): "+config_s0.substring(ns1_WSPL+5,ns2)+"<br>";
		    }
		    int ns1_GSPL=config_s0.indexOf("GSPL[",cta_begin_acc);
		    if (ns1_GSPL > 0 && endX>ns1_GSPL){
			    int ns2=config_s0.indexOf("]",ns1_GSPL);
			    cta_2=cta_2+" Splice (Grey): "+config_s0.substring(ns1_GSPL+5,ns2)+"<br>";
		    }
		    int ns1_BC=config_s0.indexOf("BC[",cta_begin_acc);
		    if (ns1_BC> 0 && endX>ns1_BC){
			    int ns2=config_s0.indexOf("]",ns1_BC);
			    cta_2=cta_2+" Beadchain(ea): "+config_s0.substring(ns1_BC+3,ns2)+"<br>";
		    }

		    int ns1_BTB=config_s0.indexOf("BTB[",cta_begin_acc);
		    if (ns1_BTB> 0 && endX>ns1_BTB){
			    int ns2=config_s0.indexOf("]",ns1_BTB);
			    cta_2=cta_2+" Beadchain tieback: "+config_s0.substring(ns1_BTB+4,ns2)+"<br>";
		    }
		    int ns1_GCLS=config_s0.indexOf("GCLS[",cta_begin_acc);
		    if (ns1_GCLS> 0 && endX>ns1_GCLS){
			    int ns2=config_s0.indexOf("]",ns1_GCLS);
			    cta_2=cta_2+" Grey ceiling socket: "+config_s0.substring(ns1_GCLS+5,ns2)+"<br>";
		    }

		    int ns1_GGT=config_s0.indexOf("GGT[",cta_begin_acc);
		    if (ns1_GGT> 0 && endX>ns1_GGT){
			    int ns2=config_s0.indexOf("]",ns1_GGT);
			    cta_2=cta_2+" Grey gate: "+config_s0.substring(ns1_GGT+4,ns2)+"<br>";
		    }
		    int ns1_GRS=config_s0.indexOf("GRS[",cta_begin_acc);
		    if (ns1_GRS> 0 && endX>ns1_GRS){
			    int ns2=config_s0.indexOf("]",ns1_GRS);
			    cta_2=cta_2+" Grey raiser shaft(per foor) : "+config_s0.substring(ns1_GRS+4,ns2)+"<br>";
		    }
		    int ns1_GRTA=config_s0.indexOf("GRTA[",cta_begin_acc);
		    if (ns1_GRTA> 0 && endX>ns1_GRTA){
			    int ns2=config_s0.indexOf("]",ns1_GRTA);
			    cta_2=cta_2+" Grey radius tie Assembly : "+config_s0.substring(ns1_GRTA+5,ns2)+"<br>";
		    }
		    int ns1_GSTA=config_s0.indexOf("GSTA[",cta_begin_acc);
		    if (ns1_GSTA> 0 && endX>ns1_GSTA){
			    int ns2=config_s0.indexOf("]",ns1_GSTA);
			    cta_2=cta_2+" Grey spilce tie Assembly : "+config_s0.substring(ns1_GSTA+5,ns2)+"<br>";
		    }
		    int ns1_GSTP=config_s0.indexOf("GSTP[",cta_begin_acc);
		    if (ns1_GSTP> 0 && endX>ns1_GSTP){
			    int ns2=config_s0.indexOf("]",ns1_GSTP);
			    cta_2=cta_2+" Grey stop : "+config_s0.substring(ns1_GSTP+5,ns2)+"<br>";
		    }
		    int ns1_GTRS=config_s0.indexOf("GTRS[",cta_begin_acc);
		    if (ns1_GTRS> 0 && endX>ns1_GTRS){
			    int ns2=config_s0.indexOf("]",ns1_GTRS);
			    cta_2=cta_2+" Grey track socket : "+config_s0.substring(ns1_GTRS+5,ns2)+"<br>";
		    }
		    int ns1_GWLS=config_s0.indexOf("GWLS[",cta_begin_acc);
		    if (ns1_GWLS> 0 && endX>ns1_GWLS){
			    int ns2=config_s0.indexOf("]",ns1_GWLS);
			    cta_2=cta_2+" Grey wall socket : "+config_s0.substring(ns1_GWLS+5,ns2)+"<br>";
		    }
		    int ns1_WCLS=config_s0.indexOf("WCLS[",cta_begin_acc);
		    if (ns1_WCLS> 0 && endX>ns1_WCLS){
			    int ns2=config_s0.indexOf("]",ns1_WCLS);
			    cta_2=cta_2+" White ceiling socket : "+config_s0.substring(ns1_WCLS+5,ns2)+"<br>";
		    }
		    int ns1_WD30=config_s0.indexOf("WD30[",cta_begin_acc);
		    if (ns1_WD30> 0 && endX>ns1_WD30){
			    int ns2=config_s0.indexOf("]",ns1_WD30);
			    cta_2=cta_2+" Wand 1/4\" x 30\" : "+config_s0.substring(ns1_WD30+5,ns2)+"<br>";
		    }
		    int ns1_WD36=config_s0.indexOf("WD36[",cta_begin_acc);
		    if (ns1_WD36> 0 && endX>ns1_WD36){
			    int ns2=config_s0.indexOf("]",ns1_WD36);
			    cta_2=cta_2+" Wand 3/8\" x 36\" : "+config_s0.substring(ns1_WD36+5,ns2)+"<br>";
		    }
		    int ns1_WD48=config_s0.indexOf("WD48[",cta_begin_acc);
		    if (ns1_WD48> 0 && endX>ns1_WD48){
			    int ns2=config_s0.indexOf("]",ns1_WD48);
			    cta_2=cta_2+" Wand 3/8\" x 48\" : "+config_s0.substring(ns1_WD48+5,ns2)+"<br>";
		    }
		    int ns1_WGT=config_s0.indexOf("WGT[",cta_begin_acc);
		    if (ns1_WGT> 0 && endX>ns1_WGT){
			    int ns2=config_s0.indexOf("]",ns1_WGT);
			    cta_2=cta_2+" White gate : "+config_s0.substring(ns1_WGT+4,ns2)+"<br>";
		    }
		    int ns1_WRS=config_s0.indexOf("WRS[",cta_begin_acc);
		    if (ns1_WRS> 0 && endX>ns1_WRS){
			    int ns2=config_s0.indexOf("]",ns1_WRS);
			    cta_2=cta_2+" White riser shaft (per foot) : "+config_s0.substring(ns1_WRS+4,ns2)+"<br>";
		    }
		    int ns1_WRTA=config_s0.indexOf("WRTA[",cta_begin_acc);
		    if (ns1_WRTA> 0 && endX>ns1_WRTA){
			    int ns2=config_s0.indexOf("]",ns1_WRTA);
			    cta_2=cta_2+" White radius tie assembly : "+config_s0.substring(ns1_WRTA+5,ns2)+"<br>";
		    }
		    int ns1_WSTA=config_s0.indexOf("WSTA[",cta_begin_acc);
		    if (ns1_WSTA> 0 && endX>ns1_WSTA){
			    int ns2=config_s0.indexOf("]",ns1_WSTA);
			    cta_2=cta_2+" White splice tie assembly : "+config_s0.substring(ns1_WSTA+5,ns2)+"<br>";
		    }
		    int ns1_WSTP=config_s0.indexOf("WSTP[",cta_begin_acc);
		    if (ns1_WSTP> 0 && endX>ns1_WSTP){
			    int ns2=config_s0.indexOf("]",ns1_WSTP);
			    cta_2=cta_2+" White stop : "+config_s0.substring(ns1_WSTP+5,ns2)+"<br>";
		    }
		    int ns1_WTRS=config_s0.indexOf("WTRS[",cta_begin_acc);
		    if (ns1_WTRS> 0 && endX>ns1_WTRS){
			    int ns2=config_s0.indexOf("]",ns1_WTRS);
			    cta_2=cta_2+" White track socket : "+config_s0.substring(ns1_WTRS+5,ns2)+"<br>";
		    }
		    int ns1_WWLS=config_s0.indexOf("WWLS[",cta_begin_acc);
		    if (ns1_WWLS> 0 && endX>ns1_WWLS){
			    int ns2=config_s0.indexOf("]",ns1_WWLS);
			    cta_2=cta_2+" White wall socket : "+config_s0.substring(ns1_WWLS+5,ns2)+"<br>";
		    }
		    int ns1_QSWITCH=config_s0.indexOf("QSWITCH[",cta_begin_acc);
		    if (ns1_QSWITCH> 0 && endX>ns1_QSWITCH){
			    int ns2=config_s0.indexOf("]",ns1_QSWITCH);
			    cta_2=cta_2+" Quick Switch : "+config_s0.substring(ns1_QSWITCH+8,ns2)+"<br>";
		    }
		    int ns1_TS=config_s0.indexOf("TS[",cta_begin_acc);
		    if (ns1_TS> 0 && endX>ns1_TS){
			    int ns2=config_s0.indexOf("]",ns1_TS);
			    cta_2=cta_2+" Tegular Tile Spacer : "+config_s0.substring(ns1_TS+3,ns2)+"<br>";
		    }

	    }
//out.println(config_s0);
	    // Track carriers begin
	    int cta_begin_accar=config_s0.indexOf("TRACKACCAR/");
	    int cta_end_accar=config_s0.indexOf("&",cta_begin_accar);
	    if (cta_begin_accar>=0 && cta_end_accar<0){
			cta_end_accar=config_s0.length();
		}
	    if(cta_begin_accar>=0){
		    //out.println("Testing0"+"::");
		    int ns1_1062N=config_s0.indexOf("1062N[",cta_begin_accar);
	    //	out.println("Testing1"+ns1_1062N+"::");
		    if ((ns1_1062N >0 )&(ns1_1062N < cta_end_accar) ){
			    int ns2=config_s0.indexOf("]",ns1_1062N);
			    cta_3=cta_3+" 1062N: "+config_s0.substring(ns1_1062N+6,ns2)+"<br>";
	    //		out.println("Testing2"+ns1_1062N+"::"+ns2);
		    }

		    int ns1_1075P=config_s0.indexOf("1075P[",cta_begin_accar);
	    //	out.println("Testing1"+ns1_1062N+"::");
		    if ((ns1_1075P >0 )&(ns1_1075P < cta_end_accar) ){
			    int ns2=config_s0.indexOf("]",ns1_1075P);
			    cta_3=cta_3+" 1075P: "+config_s0.substring(ns1_1075P+6,ns2)+"<br>";
	    //		out.println("Testing2"+ns1_1062N+"::"+ns2);
		    }


		    int ns1_975=config_s0.indexOf("975[",cta_begin_accar);
		    if ((ns1_975 >0 )&(ns1_975 < cta_end_accar )){
			    int ns2=config_s0.indexOf("]",ns1_975);
			    cta_3=cta_3+" 1075: "+config_s0.substring(ns1_975+4,ns2)+"<br>";
		    }
		    int ns1_975P=config_s0.indexOf("975P[",cta_begin_accar);
		    if ((ns1_975P >0 )&(ns1_975P < cta_end_accar) ){
			    int ns2=config_s0.indexOf("]",ns1_975P);
			    cta_3=cta_3+" 975P: "+config_s0.substring(ns1_975P+5,ns2)+"<br>";
		    }
		    int ns1_SP062=config_s0.indexOf("SP062[",cta_begin_accar);
		    if ((ns1_SP062 >0 )&(ns1_SP062 < cta_end_accar) ){
			    int ns2=config_s0.indexOf("]",ns1_SP062);
			    cta_3=cta_3+" SP062: "+config_s0.substring(ns1_SP062+6,ns2)+"<br>";
		    }
		    int ns1_SPV062=config_s0.indexOf("SPV062[",cta_begin_accar);
		    if ((ns1_SPV062 >0 )&(ns1_SPV062 < cta_end_accar) ){
			    int ns2=config_s0.indexOf("]",ns1_SPV062);
			    cta_3=cta_3+" SPV062: "+config_s0.substring(ns1_SPV062+7,ns2)+"<br>";
		    }
		    int ns1_ARN11=config_s0.indexOf("ARN11[",cta_begin_accar);
		    if ((ns1_ARN11 >0 )&(ns1_ARN11 < cta_end_accar )){
			    int ns2=config_s0.indexOf("]",ns1_ARN11);
			    cta_3=cta_3+" ARN11: "+config_s0.substring(ns1_ARN11+6,ns2)+"<br>";
		    }
		    int ns1_ARN12=config_s0.indexOf("ARN12[",cta_begin_accar);
		    if ((ns1_ARN12 >0 )&(ns1_ARN12 < cta_end_accar )){
			    int ns2=config_s0.indexOf("]",ns1_ARN12);
			    cta_3=cta_3+" ARN12: "+config_s0.substring(ns1_ARN12+6,ns2)+"<br>";
		    }
		    int ns1_GRANT=config_s0.indexOf("GRANT[",cta_begin_accar);
		    if ((ns1_GRANT >0 )&(ns1_GRANT < cta_end_accar )){
			    int ns2=config_s0.indexOf("]",ns1_GRANT);
			    cta_3=cta_3+" GRANT: "+config_s0.substring(ns1_GRANT+6,ns2)+"<br>";
		    }
		    int ns1_IB=config_s0.indexOf("IB[",cta_begin_accar);
		    if ((ns1_IB >0 )&(ns1_IB < cta_end_accar )){
			    int ns2=config_s0.indexOf("]",ns1_IB);
			    cta_3=cta_3+" I-bean: "+config_s0.substring(ns1_IB+6,ns2)+"<br>";
		    }
		    int ns1_IBP=config_s0.indexOf("IBP[",cta_begin_accar);
		    if ((ns1_IBP >0 )&(ns1_IBP < cta_end_accar) ){
			    int ns2=config_s0.indexOf("]",ns1_IBP);
			    cta_3=cta_3+" IBP: "+config_s0.substring(ns1_IBP+6,ns2)+"<br>";
		    }
		    int ns1_IFC100=config_s0.indexOf("IFC100[",cta_begin_accar);
		    if ((ns1_IFC100 >0 )&(ns1_IFC100 < cta_end_accar) ){
			    int ns2=config_s0.indexOf("]",ns1_IFC100);
			    cta_3=cta_3+" IFC 100: "+config_s0.substring(ns1_IFC100+7,ns2)+"<br>";
		    }
		    int ns1_IPCANT=config_s0.indexOf("IPCANT[",cta_begin_accar);
		    if ((ns1_IPCANT >0 )&(ns1_IPCANT < cta_end_accar) ){
			    int ns2=config_s0.indexOf("]",ns1_IPCANT);
			    cta_3=cta_3+" IPC canted wheel: "+config_s0.substring(ns1_IPCANT+7,ns2)+"<br>";
		    }
		    int ns1_GRANTB=config_s0.indexOf("GRANTB[",cta_begin_accar);
		    if ((ns1_GRANTB >0 )&(ns1_GRANTB < cta_end_accar) ){
			    int ns2=config_s0.indexOf("]",ns1_GRANTB);
			    cta_3=cta_3+" Grant bumper: "+config_s0.substring(ns1_GRANTB+7,ns2)+"<br>";
		    }
	    }
	    int calcindex=config_s0.indexOf("CALC/");
		//out.println("Test 1415: "+calcindex);
	    if(calcindex>=0){
		    int endindex=config_s0.substring(calcindex).indexOf("&");
		    if(endindex<0){
			    endindex=config_s0.substring(calcindex).length();
		    }
		    //out.println(config_s0.substring(calcindex,(calcindex+endindex))+"::<BR><BR>");
		    String tempsubstring=config_s0.substring(calcindex,(calcindex+endindex));
		    int cs1=tempsubstring.indexOf("MARGINPERC[");
		    int cs2=0;
		    if(cs1>0){
			    cs2=tempsubstring.indexOf("]",cs1);
			    margperc=tempsubstring.substring(cs1+11,cs2);
		    }
		    cs1=tempsubstring.indexOf("COMMDOL[");
		    cs2=0;
		    if(cs1>0){
			    cs2=tempsubstring.indexOf("]",cs1);
			    commdoll=tempsubstring.substring(cs1+8,cs2);
		    }
		    cs1=tempsubstring.indexOf("COMMPERCENT[");
		    cs2=0;
		    if(cs1>0){
			    cs2=tempsubstring.indexOf("]",cs1);
			    commperc=tempsubstring.substring(cs1+12,cs2);
		    }
	    }
	    if(margperc.length()>0){
		    margdoll=""+(new Double(margperc).doubleValue()/100)*totprice;
	    }
	    sumcommdoll=sumcommdoll+new Double(commdoll).doubleValue();
	    summargdoll=summargdoll+new Double(margdoll).doubleValue();
	    if(cta_1.trim().length()>0){
		    track_sell=track_sell+totprice;
	    }
	    html_cta=html_cta+"<tr height='20'>";
	    html_cta=html_cta+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid; border-left: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+items.elementAt(k).toString()+"</td>";
	    html_cta=html_cta+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+cta_1+"</td>";
	    html_cta=html_cta+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+cta_2+"</td>";
	    html_cta=html_cta+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+cta_3+"</td>";
	    html_cta=html_cta+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+for1.format(totprice)+"</td>";
	    if( !(usergroup.toUpperCase().startsWith("REP")) || usergroup.equals("Rep-Fact")){
	    html_cta=html_cta+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+commperc+" %</td>";
	    html_cta=html_cta+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+for1.format(new Double(commdoll).doubleValue())+"</td>";
	    html_cta=html_cta+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+margperc+" %</td>";
	    html_cta=html_cta+"<td bgcolor='"+bgcolor+"' align='right' style='border-bottom: 1px solid; border-top: 1px solid; border-right: 1px solid;'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;"+for1.format(new Double(margdoll).doubleValue())+"</td>";
	    }
	    html_cta=html_cta+"</tr>";
	    html_cta_count++;
	    cta_1="";cta_2="";cta_3="";
    }
    totprice=0;
}

if( !( usergroup.toUpperCase().startsWith("REP")) || usergroup.equals("Rep-Fact")){
if(!(sum_sqft==0 && sum_lnyd==0 && sum_msyd==0 && sum_cust==0 && sum_frt==0 && sum_fab==0 && sum_mesh==0 && sum_lab==0)){
    html_ct=html_ct+"<tr height='20'>";
    html_ct=html_ct+"<td bgcolor='#006600' colspan='2' align='right'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Summary:</b></font></td>";
    html_ct=html_ct+"<td bgcolor='#006600' align='left'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Total sq.ft</b></font></td>";
    html_ct=html_ct+"<td bgcolor='#006600' align='right'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;</font></td>";
    html_ct=html_ct+"<td bgcolor='#006600' align='right'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Linear Yd</b></font></td>";
    html_ct=html_ct+"<td bgcolor='#006600' align='right'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Mesh Yd</b></font></td>";
    html_ct=html_ct+"<td bgcolor='#006600' align='right'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Customs</b></font></td>";
    html_ct=html_ct+"<td bgcolor='#006600' align='right'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Freight</b></font></td>";
    html_ct=html_ct+"<td bgcolor='#006600' align='right'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Fabric cost</b></font></td>";
    html_ct=html_ct+"<td bgcolor='#006600' align='right'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Mesh cost</b></font></td>";
    html_ct=html_ct+"<td bgcolor='#006600' align='right'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Lab. cost</b></font></td>";
    html_ct=html_ct+"<td bgcolor='#006600' align='right' colspan='3'>&nbsp;</td>";
    html_ct=html_ct+"</tr>";
    html_ct=html_ct+"<tr>";
    html_ct=html_ct+"<td valign='top' nowrap bgcolor='"+bgcolor+"'  align='center'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;</p></td>";
    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  ><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;</p></td>";
    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"' align='left'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+df2.format(sum_sqft)+"</p></td>";
    html_ct=html_ct+"<td valign='top' nowrap bgcolor='"+bgcolor+"' ><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+"&nbsp;</p></td>";
    html_ct=html_ct+"<td valign='top' nowrap bgcolor='"+bgcolor+"'  align='right'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+sum_lnyd+"</p></td>";
    html_ct=html_ct+"<td valign='top' nowrap bgcolor='"+bgcolor+"'  align='right'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+sum_msyd+"</p></td>";
    html_ct=html_ct+"<td valign='top' nowrap bgcolor='"+bgcolor+"'  align='center'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>$"+sum_cust+"</p></td>";
    html_ct=html_ct+"<td valign='top' nowrap bgcolor='"+bgcolor+"'  align='center'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>$"+df2.format(sum_frt)+"</p></td>";
    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>$"+sum_fab+"</p></td>";
    html_ct=html_ct+"<td valign='top' nowrap bgcolor='"+bgcolor+"'  align='right'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>$"+sum_mesh+"</p></td>";
    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  align='right'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>$"+df2.format(sum_lab)+"</p></td>";
    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  colspan='3'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;</p></td>";
    html_ct=html_ct+"</tr>";
    html_ct=html_ct+"<tr height='20'>";
    html_ct=html_ct+"<td bgcolor='#006600' colspan='2' align='right'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Yardage Summary:</b></font></td>";
    html_ct=html_ct+"<td bgcolor='#006600' align='left'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'><b>Model</b></font></td>";
    html_ct=html_ct+"<td bgcolor='#006600' align='right'><font class='schedule'><p style=' color:#ffffff; font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>Linear Yd</font></td>";
    html_ct=html_ct+"<td bgcolor='#006600' colspan='10' align='right'>&nbsp;</td>";
    html_ct=html_ct+"</tr>";
    for(int i=0; i<model.size();i++){
	    if ((i%2)==1){bgcolor="#e4e4e4";}else {bgcolor="#EFEFDE";}
	    html_ct=html_ct+"<tr>";
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  colspan='2'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;</p></td>";
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"' align='left'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+model.elementAt(i).toString()+"</p></td>";
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"' align='right'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>"+lf.elementAt(i).toString()+"</p></td>";
	    html_ct=html_ct+"<td valign='top' bgcolor='"+bgcolor+"'  colspan='10'><p style=' font-size:7pt; font-family:arial, verdana, helvetica; text-decoration:none;'>&nbsp;</p></td>";
	    html_ct=html_ct+"</tr>";
    }
}
}

//closing tags for the output
html_ct=html_ct+"</table>";
html_cta=html_cta+"</table>";
html_cwa=html_cwa+"</table>";
html_comp=html_comp+"</table>";
html_ctc=html_ctc+"</table>";
html_install=html_install+"</table>";
out.println(html_ct+"<br>"+html_cta+"<br>"+html_cwa+"<br>"+html_comp+"<br>"+html_ctc+"<BR>"+html_install);
%>
<br><br>
<br><br>
<%
for12.setMaximumFractionDigits(1);
DecimalFormat df0x = new DecimalFormat("####");
df0x.setMaximumFractionDigits(0);
df0x.setMinimumFractionDigits(0);
double markup=0;

totprice_dis=new Double(df0x.format(totprice_dis)).doubleValue();
sumcommperc=(sumcommdoll/(totprice_dis*0.91))*100;
summargperc=(summargdoll/(totprice_dis*0.91))*100;
%>
<font class='mainbodyh'><B>PRICE SUMMARY :</B><br><br></font>
<table cellspacing='0' align='center' cellpadding='1' border='0' width='75%' class='tableline'>
	<tr><td class='schedule1'>Configured Price:<b>&nbsp;<%= for123.format(totprice_dis) %></b></td>
		<td class='schedule1'>Commission (%):<b>
				<%
				out.println(df2.format(sumcommperc));
				%>
			</b></td>
		<td class='schedule1'>Commission ($):<b>
				<%
				out.println(df2.format(sumcommdoll));
				%>
			</b></td>
	</tr>
	<tr>
		<td class='schedule1'>Overage:<b><%= for1.format(new Double(overage).doubleValue()) %></b></td>
		<% if( !( usergroup.toUpperCase().startsWith("REP")) || usergroup.equals("Rep-Fact")){
		%>
		<td class='schedule1'>Margin (%):<b>
				<%
				out.println(df2.format(summargperc));
				%>
			</b></td>
		<td class='schedule1'>Margin ($):<b>
				<%
				out.println(df2.format(summargdoll));
				%>
			</b></td>
	</tr>
	<tr>
		<td class='schedule1'>Freight Charges:<b><%= for1.format(new Double(freight_cost).doubleValue()) %></b></td>
		<td class='schedule1'>Extra Freight Charges:<b><%= for1.format(new Double(setup_cost).doubleValue()) %></b></td>
		<td class='schedule1'>Mark Up:<b><%=markup%></b></td>

	</tr>
	<tr>
		<td class='schedule1'>SQFT Curt:<b><%=df2.format(totsqftcurt)%></b></td>
		<td class='schedule1'>Sell/SQFT Curt:<b><%=for1.format(curt_sell/(totsqftcurt))%></b></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class='schedule1'>LF Curt:<b><%=totlfcurt*3%></b></td>
		<td class='schedule1'>Sell/LF Curt:<b><%=for1.format(curt_sell/(totlfcurt*3))%></b></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td class='schedule1'>LF Track:<b><%=totlftrack%></b></td>
		<td class='schedule1'>Sell/LF Track:<b><%=for1.format(track_sell/(totlftrack))%></b></td>
		<td>&nbsp;</td>
	</tr>
	<%} %>
</table>
<br>
<%
double adderGCP=totprice_dis;
double taxtotalprice=totprice_dis;
totprice_dis=totprice_dis+(new Double(overage).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(setup_cost).doubleValue())+(new Double(freight_cost).doubleValue());
if(commission == null || commission.trim().equals("null") || commission.trim().length()==0){
	commission="0";
}
BigDecimal d2 = new BigDecimal(commission);
//totprice_dis=totprice_dis+((adderGCP*d2.doubleValue())/100);
%>
<table class='tableline' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only</b></td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= for123.format(totprice_dis) %> </font></b></td>
	</tr>
	<%
	totcomm_dol=0;
	double tax_dollar=0;
	double grand_total=0;
	if(tax_perc.equals("null")||tax_perc==null){
		tax_perc="0";
	}
	totprice_dis=taxtotalprice;

	%>
	<jsp:include page="../quotes/summary_tax.jsp" flush="true">
		<jsp:param name="order_no" value="<%= order_no%>"/>
		<jsp:param name="tax_perc" value="<%= tax_perc%>"/>
		<jsp:param name="overage" value="<%=overage %>"/>
		<jsp:param name="handling_cost" value="<%=handling_cost %>"/>
		<jsp:param name="freight_cost" value="<%=freight_cost %>"/>
		<jsp:param name="setup_cost1" value="<%=setup_cost1 %>"/>
		<jsp:param name="setup_cost" value="<%= setup_cost%>"/>
		<jsp:param name="totprice_dis" value="<%= df0.format(totprice_dis)%>"/>
		<jsp:param name="secLines" value="<%= sec_lines%>"/>
		<jsp:param name="product_id" value="<%= pid%>"/>
	</jsp:include>
</table>


<%

%>