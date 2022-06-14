<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<link rel='stylesheet' href='../../css/newStyle.css' type='text/css' />
<style type="text/css" media="print">
	@page {
		size: landscape;
	}

</style>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<%@ page language="java" import="java.sql.*" import="java.math.*" import="java.text.*" import="java.util.*" errorPage="error.jsp" %>
<body>
	<%@ include file="../../db_con.jsp"%>
	<%
		DecimalFormat for2=new DecimalFormat("#.##");
		DecimalFormat for0=new DecimalFormat("#");
		for2.setMaximumFractionDigits(2);
		for2.setMinimumFractionDigits(2);
		for0.setMaximumFractionDigits(0);
		for0.setMinimumFractionDigits(0);
		String orderNo=request.getParameter("orderNo");
		String productId="";
		String projectName="";
		String exchRate="";
		String exchName="";
		String lvrTableHeader="<table width='100%' border='0px solid black' align='center' cellspacing='0' cellpadding='0'>";
		lvrTableHeader=lvrTableHeader+ "<tr><td colspan='12'><hr/></td></tr>";
		lvrTableHeader=lvrTableHeader+"<tr><td class='tdOrder' width='8%'><b>Model</b></td><td class='tdOrder' width='8%'><b>Mark</b></td><td class='tdOrder' width='8%'><b>Width</b></td><td class='tdOrder' width='8%'><b>Height</b></td><td class='tdOrder' width='8%'><b>Qty</b></td><td class='tdOrder' width='8%'><b>Finish</b></td><td class='tdOrder' width='8%'><b>Sill Ext</b></td><td class='tdOrder' width='8%'><b>Sections</b></td><td class='tdOrder' width='8%'><b>Weight</b></td><td class='tdOrder' width='8%'><b>Mullion<br>Cond | QTY</b></td><td class='tdOrder' width='8%'><b>Structural<br>Cond | QTY</b></td><td class='tdOrder' width='8%'><b>Splice<br>Cond | QTY</b></td></tr>";
		lvrTableHeader=lvrTableHeader+ "<tr><td colspan='12'><hr/></td></tr>";
		String modTableHeader="<table width='100%' border='0px solid black' align='center' cellspacing='0' cellpadding='0' class='tableCSS'>";
		modTableHeader=modTableHeader+ "<tr><td colspan='12'><hr/></td></tr>";
		modTableHeader=modTableHeader+"<tr><td class='tdOrder' width='8%'><b>Model</b></td><td class='tdOrder' width='8%'><b>Mark</b></td><td class='tdOrder' width='8%'><b>Width</b></td><td class='tdOrder' width='8%'><b>Height</b></td><td class='tdOrder' width='8%'><b>Qty</b></td><td class='tdOrder' width='8%'><b>Finish</b></td><td class='tdOrder' width='8%'><b>Cell Spacing</b></td><td class='tdOrder' width='8%'><b>Bar Thickness</b></td><td class='tdOrder' width='8%'><b>Depth</b></td><td class='tdOrder' width='8%'><b>Angle</b></td><td class='tdOrder' width='8%'><b>Frame</b></td><td class='tdOrder' width='16%'><b>Splice<br>V Splice| H Splice</b></td></tr>";
		modTableHeader=modTableHeader+ "<tr><td colspan='12'><hr/></td></tr>";
		String myrTableHeader="<table width='100%' border='0px solid black' align='center' cellspacing='0' cellpadding='0' class='tableCSS'>";
		myrTableHeader=myrTableHeader+ "<tr><td colspan='12'><hr/></td></tr>";
		myrTableHeader=myrTableHeader+"<tr><td class='tdOrder' width='8%'><b>Model</b></td><td class='tdOrder' width='8%'><b>Mark</b></td><td class='tdOrder' width='8%'><b>Width</b></td><td class='tdOrder' width='8%'><b>Height</b></td><td class='tdOrder' width='8%'><b>Qty</b></td><td class='tdOrder' width='8%'><b>Finish</b></td><td class='tdOrder' width='8%'><b>Cell Spacing</b></td><td class='tdOrder' width='8%'><b>Bar Thickness</b></td><td class='tdOrder' width='8%'><b>Depth</b></td><td class='tdOrder' width='8%'><b>Angle</b></td><td class='tdOrder' width='8%'><b>Frame</b></td><td class='tdOrder' width='16%'><b>Splice<br>V Splice| H Splice</b></td></tr>";
		myrTableHeader=myrTableHeader+ "<tr><td colspan='12'><hr/></td></tr>";
		String grilleTableHeader="<table width='100%' border='0px solid black' align='center' cellspacing='0' cellpadding='0' class='tableCSS'>";
		grilleTableHeader=grilleTableHeader+ "<tr><td colspan='12'><hr/></td></tr>";
		grilleTableHeader=grilleTableHeader+"<tr><td class='tdOrder' width='8%'><b>Model</b></td><td class='tdOrder' width='8%'><b>Mark</b></td><td class='tdOrder' width='8%'><b>Width</b></td><td class='tdOrder' width='8%'><b>Height</b></td><td class='tdOrder' width='8%'><b>Qty</b></td><td class='tdOrder' width='8%'><b>Finish</b></td><td class='tdOrder' width='8%'><b>Blade Spacing</b></td><td class='tdOrder' width='8%'><b>Corners</b></td><td class='tdOrder' width='8%'><b>Weight</b></td><td class='tdOrder' width='8%'><b>Mullion<br>Cond | QTY</b></td><td class='tdOrder' width='8%'><b>Structural<br>Cond | QTY</b></td><td class='tdOrder' width='8%'><b>Splice<br>Cond | QTY</b></td></tr>";
		grilleTableHeader=grilleTableHeader+ "<tr><td colspan='12'><hr/></td></tr>";
		String sunTableHeader="<table width='100%' border='0px solid black' align='center' cellspacing='0' cellpadding='0' class='tableCSS'>";
		sunTableHeader=sunTableHeader+ "<tr><td colspan='12'><hr/></td></tr>";
		sunTableHeader=sunTableHeader+"<tr><td class='tdOrder' width='8%'><b>SS Type</b></td><td class='tdOrder' width='8%'><b>Mark</b></td><td class='tdOrder' width='8%'><b>Qty</b></td><td class='tdOrder' width='8%'><b>Width</b></td><td class='tdOrder' width='8%'><b>Projection</b></td><td class='tdOrder' width='8%'><b>Depth</b></td><td class='tdOrder' width='8%'><b>Finish</b></td><td class='tdOrder' width='8%'><b>Blade Spacing</b></td><td class='tdOrder' width='8%'><b>Blade Qty</b></td><td class='tdOrder' width='8%'><b>Sections</b></td><td class='tdOrder' width='8%'><b>Corners</b></td><td class='tdOrder' width='8%'><b>Weight</b></td></tr>";
		sunTableHeader=sunTableHeader+ "<tr><td colspan='12'><hr/></td></tr>";
		String fsmTableHeader="<table width='100%' border='0px solid black' align='center' cellspacing='0' cellpadding='0'>";
		fsmTableHeader=fsmTableHeader+ "<tr><td colspan='12'><hr/></td></tr>";
		fsmTableHeader=fsmTableHeader+"<tr><td class='tdOrder' width='8%'><b>Model</b></td><td class='tdOrder' width='8%'><b>Mark</b></td><td class='tdOrder' width='8%'><b>Width</b></td><td class='tdOrder' width='8%'><b>Height</b></td><td class='tdOrder' width='8%'><b>Qty</b></td><td class='tdOrder' width='8%'><b>Finish</b></td><td class='tdOrder' width='8%'><b>Sections</b></td><td class='tdOrder' width='8%'><b>Weight</b></td><td class='tdOrder' width='8%'><b>Horiz Mullion</b></td><td class='tdOrder' width='8%'><b>Vert Mullion</b></td></tr>";
		fsmTableHeader=fsmTableHeader+ "<tr><td colspan='12'><hr/></td></tr>";
		int sections=0;
		String sectionGroup="";
		String sectionInfo="";
		ResultSet rs0=stmt.executeQuery("select sections,section_group,section_info from cs_quote_sections where order_no='"+orderNo+"'");
		if(rs0!=null){
			while(rs0.next()){
				sections=rs0.getInt("sections");
				sectionGroup=rs0.getString("section_group");
				sectionInfo=rs0.getString("section_Info");
			}
		}
		rs0.close();
		//out.println(sectionGroup+"::<BR><BR><Br>");
		ResultSet rsProject=stmt.executeQuery("select product_id,project_name,exch_name,exch_rate,exch_rate_date from cs_project where order_no='"+orderNo+"'");
		if(rsProject != null){
			while(rsProject.next()){
				productId=rsProject.getString("product_id");
				projectName=rsProject.getString("project_name");
				exchName=rsProject.getString("exch_name");
				exchRate=rsProject.getString("exch_rate");
			}
		}
		rsProject.close();
                if(exchRate==null || exchRate.trim().length()==0){
                   exchRate="0";
                }
		Vector sectionLineNumbers=new Vector();
		Vector sectionName=new Vector();
		if(sections>1){
			//sort out sections.  Lines for each section
			//sort section name first
			while(sectionInfo.length()>4){
				sectionName.addElement(sectionInfo.substring(sectionInfo.indexOf("=")+1,sectionInfo.indexOf(";")));
				sectionInfo=sectionInfo.substring(sectionInfo.indexOf(";")+1);
			}
			//now sort section lines
			for(int i=1; i<=sections; i++){
				//out.println("<BR><BR>section index=s"+i+"<BR>");
				String tempSectionIndex="s"+i+";";
				int index=0;
				int count=0;
				String sectionGroupx=sectionGroup;
				String tempLines="";
				while(index<sectionGroup.length()){
					//out.println(sectionGroupx+"::cut sectionsGroup<BR>");
					index=sectionGroupx.indexOf(tempSectionIndex);
					if(index>=0){
						index=index+tempSectionIndex.length();
						//out.println(index+"::index<BR>");
						String temp=sectionGroupx.substring(0,index-1);
						tempLines=tempLines+temp.substring(temp.lastIndexOf(";")+1,temp.lastIndexOf("="))+",";
						//out.println(sectionGroupx.substring(index)+"::<BR><BR>");
						sectionGroupx=sectionGroupx.substring(index);
						count++;
					}
					if(count>=1000 ||index<0){
						index=sectionGroup.length()+1;
					}
				}
				if(tempLines.endsWith(",")){
					tempLines=tempLines.substring(0,tempLines.length()-1);
				}
				//out.println(tempLines+"::"+tempSectionIndex+"::<BR><BR>");
				sectionLineNumbers.addElement(tempLines);
			}
		}
		else{
			// this is if it's one section or less.
			sectionName.addElement("ALL");
			String tempLines="";
			ResultSet rs2=stmt.executeQuery("select distinct line_no from cs_summary_report where order_no='"+orderNo+"'");
			if(rs2!=null){
				while(rs2.next()){
					tempLines=tempLines+rs2.getString(1)+",";
				}
			}
			rs2.close();
			if(tempLines.endsWith(",")){
				tempLines=tempLines.substring(0,tempLines.length()-1);
			}
			//sectionName.addElement("ALL");
			sectionLineNumbers.addElement(tempLines);
		}
                //out.println(sectionName.size()+"::<BR>");
		for(int i=0; i<sectionName.size(); i++){
                        Vector lineNoBO=new Vector();
                        Vector blankOff=new Vector();
			//out.println(sectionLineNumbers.elementAt(i).toString()+":: section lines<BR>");
			int lvrTotal=0;
			int secTotal=0;
			double materialTotal=0;
			double laborTotal=0;
			double laborHoursTotal=0;
			double weightTotal=0;
			double finishTotal=0;
			double areaTotal=0;
			double surfaceTotal=0;
			double perimeterTotal=0;
			double cubicTotal=0;
			double eRate=0;
			double dRate=0;
			double pmRate=0;
			double actualComm=0;
			String alumCost="";
			String galvCost="";
			String catchallDesc="";
			String pInfCatchallDesc1="";
			String pInfCatchallDesc2="";
			String pInfCatchallDesc3="";
			String pInfCatchallDesc4="";
			String pInfCatchallDesc5="";
			String city="";
			String state="";
			double totalPrice=0;
			double totalCostGroup=0;
			double install=0;
			double draftingHours=0;
			double layoutHours=0;
			double engineeringHours=0;
			double projectManagementHours=0;
			double drafting=0;
			double layout=0;
			double engineering=0;
			double projectManagement=0;
			double freightCrate=0;
			double crate=0;
			double freight=0;
			double commissiondollars=0;
			double stdComm=0;
			double spComm=0;
			double marginDollars=0;
			double sellPrice=0;
			double dollarsf=0;
			double yield=0;
			double catchall=0;
			double catchallwt=0;
			double crated_weight=0;
			double pInfCatchall1=0;
			double pInfCatchall2=0;
			double pInfCatchall3=0;
			double pInfCatchall4=0;
			double pInfCatchall5=0;
			double pInfCatchallWt1=0;
			double pInfCatchallWt2=0;
			double pInfCatchallWt3=0;
			double pInfCatchallWt4=0;
			double pInfCatchallWt5=0;
			double exportCrate=0;
			double totalCost=0;
			double markUp=0;
			double defaultLaborRate = 0;
			String acQ="";
			
			if(sections>1){
				acQ="Select * from cs_access_central where order_no like '"+orderNo +"' and section_no = 's"+(i+1)+"'";
			}
			else{
				acQ="Select * from cs_access_central where order_no like '"+orderNo+"'";
			}
			ResultSet rsAc=stmt.executeQuery(acQ);
			if(rsAc != null){
				while(rsAc.next()){
					city=rsAc.getString("city").toString();
					state=rsAc.getString("state").toString();
					totalPrice=rsAc.getDouble("pinftotal");
					totalCostGroup=rsAc.getDouble("pinfcost");
					install=rsAc.getDouble("pinfinstall");
					draftingHours=rsAc.getDouble("pinfdhours");
					layoutHours=rsAc.getDouble("pinflhours");
					engineeringHours=rsAc.getDouble("pinfehours");
					projectManagementHours=rsAc.getDouble("pinfpmhours");
					freightCrate=rsAc.getDouble("pinffc");
					freight=rsAc.getDouble("pinffreight");
					crate=freightCrate-freight;
					commissiondollars=rsAc.getDouble("pinfcommdollars");
					stdComm=rsAc.getDouble("pinfSTDcommPerc");
					spComm=rsAc.getDouble("pinfKACommPerc");
					marginDollars=rsAc.getDouble("pinfmargdollars");
					sellPrice=rsAc.getDouble("pinfsellprice");
					dollarsf=rsAc.getDouble("pinddollarsf");
					yield=rsAc.getDouble("pindyield");
					catchall=rsAc.getDouble("pinfcatchall");
					catchallwt=rsAc.getDouble("pinfcatchallwt");
					if(rsAc.getString("pinfcatchall_desc") != null){
						catchallDesc=rsAc.getString("pinfcatchall_desc");
					}
					crated_weight=rsAc.getDouble("pindtotwt");
					pInfCatchallDesc1=rsAc.getString("pinfCATCHALL_DESC1");
					pInfCatchallDesc2=rsAc.getString("pinfCATCHALL_DESC2");
					pInfCatchallDesc3=rsAc.getString("pinfCATCHALL_DESC3");
					pInfCatchallDesc4=rsAc.getString("pinfCATCHALL_DESC4");
					pInfCatchallDesc5=rsAc.getString("pinfCATCHALL_DESC5");
					if(rsAc.getString("pInfcatchall1")!= null){
						pInfCatchall1=rsAc.getDouble("pInfcatchall1");
					}
					if(rsAc.getString("pInfcatchall2")!= null){
						pInfCatchall2=rsAc.getDouble("pInfcatchall2");
					}
					if(rsAc.getString("pInfcatchall3")!= null){
						pInfCatchall3=rsAc.getDouble("pInfcatchall3");
					}
					if(rsAc.getString("pInfcatchall4")!= null){
						pInfCatchall4=rsAc.getDouble("pInfcatchall4");
					}
					if(rsAc.getString("pInfcatchall5")!= null){
						pInfCatchall5=rsAc.getDouble("pInfcatchall5");
					}
					if(rsAc.getString("pInfCatchallWt1")!= null){
						pInfCatchallWt1=rsAc.getDouble("pInfCatchallWt1");
					}
					if(rsAc.getString("pInfCatchallWt2")!= null){
						pInfCatchallWt2=rsAc.getDouble("pInfCatchallWt2");
					}
					if(rsAc.getString("pInfCatchallWt3")!= null){
						pInfCatchallWt3=rsAc.getDouble("pInfCatchallWt3");
					}
					if(rsAc.getString("pInfCatchallWt4")!= null){
						pInfCatchallWt4=rsAc.getDouble("pInfCatchallWt4");
					}
					if(rsAc.getString("pInfCatchallWt5")!= null){
						pInfCatchallWt5=rsAc.getDouble("pInfCatchallWt5");
					}
					if(rsAc.getString("export")!=null){
						exportCrate=rsAc.getDouble("pinfexportcrate");
					}
				}
			}
			rsAc.close();
			
			ResultSet rsMC = stmt.executeQuery("select product_id, extcostlb, SHOPLABOR from CS_MATCOSTLB where product_id like 'ALL'");
			if(rsMC != null){
				while(rsMC.next()){
					if(rsMC.getString("extCostlb") != null && rsMC.getString("extcostlb").trim().length() > 0) {
						alumCost = rsMC.getString("extcostlb");
					}
					
					defaultLaborRate = rsMC.getDouble("SHOPLABOR");
				}
			}
			rsMC.close();
                
			ResultSet rsDefault = stmt.executeQuery("select hrrate,enghrrate,pmhrrate from cs_defaults where product_id like '"+productId+"' and warhse = '2'");
			if(rsDefault != null){
				while(rsDefault.next()){
					eRate=rsDefault.getDouble("hrrate");
					dRate=rsDefault.getDouble("hrrate");
					pmRate=rsDefault.getDouble("pmhrrate");
				}
			}
			rsDefault.close();
			actualComm=((commissiondollars/(sellPrice*0.91))*100);
			drafting=draftingHours*dRate;
			layout=layoutHours*dRate;
			engineering=engineeringHours*eRate;
			projectManagement=projectManagementHours*pmRate;
			totalCost=totalCostGroup+drafting+layout+engineering+projectManagement+freightCrate+commissiondollars+catchall;
			markUp=sellPrice/(totalCostGroup+catchall);
			String tableAdder="<tr><td ></td><td colspan='10'><div id='Line2'></div></td><td ></td></tr>";
			tableAdder="<tr><td><td><td colspan='8'><hr style='color:#ecf0f1;' /></td><td></td></tr>";
			String lastTableHeader="";
			if(i==0){
				out.println("<table width='100%'><tr><td align='center' ><font size='5'><b>"+projectName+" </b></font></td>");
				out.println("<tr><td align='center'><font size='3'>"+orderNo+" </font></td></tr>");
				out.println("<tr><td align='center'><font size='3'>"+city+","+state+" </font></td></tr>");
				out.println("<tr><td align='left'><div id='sideHead'><p style='font-size:16px;color:black;margin-top:10px;font-stretch:expanded;'><b>Details </b></p></div></td>");
			}
			out.println("<tr><td align='left'><font size='3'><b>"+sectionName.elementAt(i).toString()+" <b></font></td></tr>");
                        String blankOffQuery="select a.line_no,c.mid_descript from cs_summary_report a LEFT OUTER JOIN CS_SCREEN AS c ON a.bo_desc = c.code WHERE     (a.order_no = '"+orderNo+"') order by cast(a.line_no as numeric)";
                        // out.println(blankOffQuery);
                        ResultSet rsBO=stmt.executeQuery(blankOffQuery);
                        if(rsBO != null){
                            while(rsBO.next()){                                
                                lineNoBO.addElement(rsBO.getString(1));
                                if(rsBO.getString(2)!=null){
                                    blankOff.addElement("<BR><B>BO:</b> "+rsBO.getString(2));
                                }
                                else{
                                    blankOff.addElement("");
                                }
                            }
                        }
                        rsBO.close();
            
			
			String querySummary="SELECT a.line_no as line_no,a.product_id as product_id,a.model , a.mark, a.width, a.height, a.qty, a.finish, a.acc, a.sects, a.totwt, a.mull_cond, a.expmulls, a.suppt_cond, a.supports, a.spl_cond, a.splices, a.scrn_bo, a.contang, a.ewload, a.actwload, a.totperim, a.totsurf, a.shape, a.splices AS Expr1, a.finlabcost, a.labor_rate, a.totfincost, a.finlabcost AS Expr2,a.bo_desc, b.cost_flag, b.qty AS csCostingQty, b.stile_code, b.std_cost, b.fin_cost, b.run_cost, b.setup_cost, b.model AS csCostingModel, c.mid_descript,a.horizcell,a.vertcell,a.thick,a.depth,a.angle,a.frame,a.blddir,a.bldspc,a.corners,a.type,a.totsqft,a.sysdepth,a.extcostlb,a.galvcost,a.STLCTR_FRAC,a.findisc FROM         CS_SUMMARY_REPORT AS a INNER JOIN CS_COSTING AS b ON a.order_no = b.order_no AND a.line_no = b.item_no LEFT OUTER JOIN CS_SCREEN AS c ON a.scrn_bo = c.code WHERE     (a.order_no = '"+orderNo+"') AND (a.line_no IN ("+sectionLineNumbers.elementAt(i).toString()+")) ORDER BY cast(a.line_no as numeric)";
			ResultSet rs1=stmt.executeQuery(querySummary);
			if(rs1 != null){
				while(rs1.next()){
                                   
					/*if(rs1.getString("extCostlb")!=null&&rs1.getString("extcostlb").trim().length()>0){
						alumCost=rs1.getString("extcostlb");
					}*/
					if(rs1.getString("galvcost")!=null&&rs1.getString("galvcost").trim().length()>0){
						galvCost=rs1.getString("galvCost");
					}
					String lineProductId=rs1.getString("product_id");
                                        //out.println("::"+lineProductId+"::"+lastTableHeader+"::<BR>");
                                        
					if((lineProductId.equals("LVR")||lineProductId.equals("BV"))&&!(lastTableHeader.equals("LVR")|lastTableHeader.equals("BV"))){
						out.println(lvrTableHeader);
						lastTableHeader="LVR";
					}
					else if(lineProductId.equals("GRILLE")&&rs1.getString("model").equals("MODULAR")&&!lastTableHeader.equals("MOD")){
						out.println(modTableHeader);
						lastTableHeader="MOD";
					}
					else if(lineProductId.equals("GRILLE")&&rs1.getString("model").startsWith("MYR")&&!lastTableHeader.equals("MYR")){
						out.println(myrTableHeader);
						lastTableHeader="MYR";
					}
					else if((lineProductId.equals("GRILLE"))&&!rs1.getString("model").equals("MODULAR")&&!rs1.getString("model").startsWith("MYR")&&!lastTableHeader.equals("GRILLE")){
						out.println(grilleTableHeader);
						lastTableHeader="GRILLE";
					}
					else if(lineProductId.equals("SUN")&&!lastTableHeader.equals("SUN")){
						out.println(sunTableHeader);
						lastTableHeader="SUN";
					}
					else if(lineProductId.equals("FSM")&&!lastTableHeader.equals("FSM")){
						out.println(fsmTableHeader);
						lastTableHeader="FSM";
					}
					else{
						out.println(tableAdder);
					}
					double materialCost=rs1.getDouble("std_cost")-rs1.getDouble("fin_cost");
					double laborCost=rs1.getDouble("run_cost")+rs1.getDouble("setup_cost")-rs1.getDouble("finlabcost");
					double laborRate=0;
					if(rs1.getString("labor_rate")!=null && rs1.getString("labor_rate").trim().length()>0){
						laborRate=rs1.getDouble("labor_rate");
					}
					else{
						laborRate = defaultLaborRate;
					}
					double laborHours=laborCost/laborRate;
					double finishCost=rs1.getDouble("totfincost")+rs1.getDouble("finLabCost");
					double totCost=materialCost+laborCost+finishCost;
					materialTotal=materialTotal+materialCost;
					laborTotal=laborTotal+laborCost;
					laborHoursTotal=laborHoursTotal+laborHours;
					weightTotal=weightTotal+rs1.getDouble("totwt");
					finishTotal=finishTotal+finishCost;
					if(rs1.getString("totsqft")!=null&&rs1.getString("totsqft").trim().length()>0){
                                            areaTotal=areaTotal+rs1.getDouble("totsqft");
					}
					if(rs1.getString("totsurf")!=null&&rs1.getString("totsurf").trim().length()>0){
                                            surfaceTotal=surfaceTotal+rs1.getDouble("totsurf");
					}
					if(rs1.getString("totperim")!=null&&rs1.getString("totperim").trim().length()>0){
                                            perimeterTotal=perimeterTotal+rs1.getDouble("totperim");
					}

					if(rs1.getString("sysdepth")!=null&&rs1.getString("sysdepth").trim().length()>0){
                                            cubicTotal=cubicTotal+((rs1.getDouble("sysdepth")+3)/12)*rs1.getDouble("totsqft");
					}
					String sillExt="NO";
					if(rs1.getString("acc").indexOf("ORIDESILLACC")<0&&rs1.getString("acc").indexOf("SILLACC")>=0){
						sillExt="YES";
					}
					String snapCover="N";
					if(rs1.getString("acc").indexOf("SNAPON")>=0){
						snapCover="Y";
					}
					String contAng="Y";
					if(rs1.getString("contang")==null||rs1.getString("contang").indexOf("NONECA")>=0||rs1.getString("contang").length()<=0){
						contAng="N";
					}
					String rwdi="";
					if(rs1.getString("actwload").indexOf("ALOB=")>=0){
						String tempWl=rs1.getString("actwload");
						rwdi=tempWl.substring(tempWl.indexOf("ALOB=")+5);
						if(rwdi.indexOf(",")>=0){
							rwdi=rwdi.substring(0,rwdi.indexOf(","));
						}
					}
					String hSplice="-NA-";
					if(rs1.getString("horizcell")!=null){
						hSplice=rs1.getString("horizcell");
					}
					String screen="NONE";
					if(rs1.getString("mid_descript") != null){
						screen=rs1.getString("mid_descript");
					}
                                       //out.println(rs1.getString("line_no")+"::<BR>");
                                       //lineNoBO.addElement(rsBO.getString(1));
                                //blankOff.addElement(rsBO.getString(2));
                                       for(int bo=0; bo<lineNoBO.size(); bo++){
                                           if(lineNoBO.elementAt(bo).toString().equals(rs1.getString("line_no"))){
                                               screen=screen+blankOff.elementAt(bo).toString();
                                           }
                                       }
					String mullCond="NONE";
					if(rs1.getString("mull_cond") !=null && !rs1.getString("mull_cond").equals("")){
						mullCond=rs1.getString("mull_cond");
					}
					if(lineProductId.equals("LVR")||lineProductId.equals("BV")){
						lvrTotal=lvrTotal+rs1.getInt("qty");
                                                 int sects=0;
                                            if(rs1.getString("sects")!=null&&rs1.getString("sects").trim().length()>0){
                                                sects=rs1.getInt("sects");
                                            }
						secTotal=secTotal+sects*rs1.getInt("qty");
						out.println("<tr>");
						out.println("<td class='tdOrder' >"+rs1.getString("model")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("mark")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("width")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("height")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("qty")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("finish")+"</td>");
						out.println("<td class='tdOrder' >"+sillExt+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("sects")+"</td>");
                                                
						out.println("<td class='tdOrder' >"+for0.format(rs1.getDouble("totwt"))+"</td>");
						out.println("<td class='tdOrder' >"+mullCond+"<b>|</b>");
						out.println(rs1.getString("expmulls")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("suppt_cond")+"<b>|</b>");
						out.println(rs1.getString("supports")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("spl_cond")+"<b>|</b>");
						out.println(rs1.getString("splices")+"</td>");
						out.println("</tr>");
                                                
						out.println("</tr>");
						out.println("<td class='tdOrder' colspan='2'><b>SCREEN:</b> "+screen+"</td>");
						out.println("<td class='tdOrder'><b>Snap Cov:</b> "+snapCover+"</td>");
						out.println("<td class='tdOrder' ><b>Cont Angles:</b> "+contAng+"</td>");
                                                double ewload=0;
                                                if(rs1.getString("ewload")!=null&&rs1.getString("ewload").trim().length()>0){
                                                    ewload=rs1.getDouble("ewload");
                                                }
						out.println("<td class='tdOrder'><b>PSF:</b> "+for0.format(ewload)+"</td>");
						out.println("<td class='tdOrder' ><b>RWDI-PSF:</b> "+rwdi+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Perimeter:</b> "+rs1.getString("totperim")+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>SF Area:</b> "+for2.format(rs1.getDouble("totsqft"))+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Shape:</b> "+rs1.getString("shape")+"</td>");
						out.println("</tr>");
                                                
						out.println("<tr>");
						out.println("<td class='tdOrder' colspan='2'><b>Material $</b> "+for2.format(materialCost)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Labor $</b> "+for2.format(laborCost)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Labor Hours:</b> "+for2.format(laborHours)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>H-Splice:</b> "+hSplice+"</td>");
						/* out.println("<td class='tdOrder' colspan='2'><b>Finishing $</b> "+for2.format(finishCost)+"</td>");*/
						out.println("<td class='tdOrder' colspan='1'><b>Finishing $</b> "+for2.format(finishCost)+"</td>");
						
						String findiscFD = "";
						if(rs1.getString("findisc")!=null&&rs1.getString("findisc").trim().length()>0)
						{
							findiscFD = rs1.getString("findisc");
						}
						out.println("<td class='tdOrder' colspan='1'><b>FD :</b> "+findiscFD+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Total Cost $</b> "+for2.format(totCost)+"</td>");
						out.println("</tr>");
                                                
					}  
					else if(lineProductId.equals("GRILLE")&&rs1.getString("model").equals("MODULAR")){
                                            int sects=0;
                                            if(rs1.getString("sects")!=null&&rs1.getString("sects").trim().length()>0){
                                                sects=rs1.getInt("sects");
                                            }
                                            secTotal=secTotal+sects*rs1.getInt("qty");
                                            lvrTotal=lvrTotal+rs1.getInt("qty");
						out.println("<tr>");
						out.println("<td class='tdOrder' >"+rs1.getString("model")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("mark")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("width")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("height")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("qty")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("finish")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("horizcell")+"&quot x "+rs1.getString("vertcell")+"&quot"+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("thick")+"&quot</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("depth")+"</td>");
						out.println("<td class='tdOrder'>"+rs1.getString("angle")+"</td>");
						out.println("<td class='tdOrder'>"+rs1.getString("frame")+"</td>");
						out.println("<td class='tdOrder'>"+rs1.getString("splices")+" <B>|</b> "+rs1.getString("spl_cond")+"</td>");
						out.println("</tr>");
						out.println("</tr>");
						out.println("<td class='tdOrder' >&nbsp;</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Snap Cov:</b> "+snapCover+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Cont Angles:</b> "+contAng+"</td>");
						out.println("<td class='tdOrder' colspan='2'>&nbsp;</td>");
						out.println("<td class='tdOrder'>&nbsp;</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Perimeter:</b> "+rs1.getString("totperim")+"</td>");
						out.println("<td class='tdOrder'><b>SF Area:</b> "+for0.format(rs1.getDouble("totsurf"))+"</td>");
						out.println("<td class='tdOrder'>&nbsp;</td>");
						out.println("</tr>");
						out.println("<tr>");
						out.println("<td class='tdOrder' colspan='2'><b>Material $</b> "+for2.format(materialCost)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Labor $</b> "+for2.format(laborCost)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Labor Hours:</b> "+for2.format(laborHours)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Weight:</b> "+rs1.getString("totwt")+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Finishing $</b> "+for2.format(finishCost)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Total Cost $</b> "+for2.format(totCost)+"</td>");
						out.println("</tr>");
					}
					else if(lineProductId.equals("GRILLE")&&rs1.getString("model").startsWith("MYR")){
                                            lvrTotal=lvrTotal+rs1.getInt("qty");
                                            secTotal=secTotal+rs1.getInt("sects")*rs1.getInt("qty");
						out.println("<tr>");
						out.println("<td class='tdOrder' >"+rs1.getString("model")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("mark")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("width")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("height")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("qty")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("finish")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("horizcell")+"&quot x "+rs1.getString("vertcell")+"&quot"+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("thick")+"&quot</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("depth")+"</td>");
						out.println("<td class='tdOrder'>"+rs1.getString("angle")+"</td>");
						out.println("<td class='tdOrder'>"+rs1.getString("frame")+"</td>");
						out.println("<td class='tdOrder'>"+rs1.getString("splices")+" <B>|</b> "+rs1.getString("spl_cond")+"</td>");
						out.println("</tr>");
						out.println("</tr>");
						out.println("<td class='tdOrder' >&nbsp;</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Snap Cov:</b> "+snapCover+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Cont Angles:</b> "+contAng+"</td>");
						out.println("<td class='tdOrder' colspan='2'>&nbsp;</td>");
						out.println("<td class='tdOrder' colspan='2'>&nbsp;</td>");
						out.println("<td class='tdOrder'><b>Perimeter:</b> "+rs1.getString("totperim")+"</td>");
						out.println("<td class='tdOrder'><b>SF Area:</b>"+for0.format(rs1.getDouble("totsurf"))+"</td>");
						out.println("<td class='tdOrder'>&nbsp;</td>");
						out.println("</tr>");
						out.println("<tr>");
						out.println("<td class='tdOrder' colspan='2'><b>Material $</b> "+for2.format(materialCost)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Labor $</b> "+for2.format(laborCost)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Labor Hours:</b> "+for2.format(laborHours)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Weight:</b> "+rs1.getString("totwt")+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Finishing $</b> "+for2.format(finishCost)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Total Cost $</b> "+for2.format(totCost)+"</td>");
						out.println("</tr>");
					}
					else if(lineProductId.equals("GRILLE")){
                                            secTotal=secTotal+rs1.getInt("sects")*rs1.getInt("qty");
                                            lvrTotal=lvrTotal+rs1.getInt("qty");
						String splCond=rs1.getString("spl_cond");
						if(splCond==null||splCond.trim().length()<=0||splCond.equals("0")){
							splCond="NONE";
						}
						if(rwdi==null||rwdi.trim().length()==0){
							rwdi="0";
						}
						out.println("<tr>");
						out.println("<td class='tdOrder' >"+rs1.getString("model")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("mark")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("width")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("height")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("qty")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("finish")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("bldspc")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("corners")+"</td>");
						out.println("<td class='tdOrder' >"+for0.format(rs1.getDouble("totwt"))+"</td>");
						out.println("<td class='tdOrder' >"+mullCond+" <b>|</b> "+rs1.getString("expmulls")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("suppt_cond")+" <b>|</b> "+rs1.getString("supports")+"</td>");
						out.println("<td class='tdOrder' >"+splCond+"<b> | </b>"+rs1.getString("splices")+"</font></td>");
						out.println("</tr>");
						out.println("</tr>");
						out.println("<td class='tdOrder' colspan='2'><b>STEEL CENTERS:</b> "+rs1.getString("STLCTR_FRAC")+"</td>");
						out.println("<td class='tdOrder'><b>Snap Cov:</b> "+snapCover+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Cont Angles:</b> "+contAng+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>PSF:</b> "+for0.format(rs1.getDouble("ewload"))+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>RWDI-PSF:</b> "+rwdi+"</td>");
						out.println("<td class='tdOrder'><b>Perimeter:</b> "+rs1.getString("totperim")+"</td>");
						out.println("<td class='tdOrder'><b>SF Area:</b> "+for0.format(rs1.getDouble("totsurf"))+"</td>");
						out.println("<td class='tdOrder'><b>Shape:</b> "+rs1.getString("shape")+"</td>");
						out.println("</tr>");
						out.println("<tr>");
						out.println("<td class='tdOrder' colspan='2'><b>Material $</b> "+for2.format(materialCost)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Labor $</b> "+for2.format(laborCost)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Labor Hours:</b> "+for2.format(laborHours)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Blade Direct:</b> "+rs1.getString("blddir")+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Finishing $</b> "+for2.format(finishCost)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Total Cost $</b> "+for2.format(totCost)+"</td>");
						out.println("</tr>");
					}
					else if(lineProductId.equals("SUN")){
                                            lvrTotal=lvrTotal+rs1.getInt("qty");
                                            secTotal=secTotal+rs1.getInt("sects")*rs1.getInt("qty");
						out.println("<tr>");
						out.println("<td class='tdOrder' >"+rs1.getString("type")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("mark")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("qty")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("width")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("depth")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("height")+"</td>");


						out.println("<td class='tdOrder' >"+rs1.getString("finish")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("bldspc")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("blddir")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("sects")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("corners")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("totwt")+"</td>");
						out.println("</tr>");
						out.println("</tr>");
						out.println("<td class='tdOrder' colspan='2'><b>Blade:</b> "+rs1.getString("Mull_cond")+"</td>");
						out.println("<td class='tdOrder' colspan='3'><b>Front Fascia:</b> "+rs1.getString("suppt_cond")+"</td>");
						out.println("<td class='tdOrder' colspan='3'><b>Rear Fascia:</b> "+rs1.getString("spl_cond")+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Outrigger Type:</b> "+rs1.getString("scrn_bo")+"</td>");
						//out.println("<td class='tdOrder' colspan='2'><b>Outrigger Height:</b> "+rs1.getString("height")+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Wind/Snowload:</b> "+rs1.getString("ewload")+"</td>");

						out.println("</tr>");
						out.println("<tr>");
						out.println("<td class='tdOrder' colspan='2'><b>Material $</b> "+for2.format(materialCost)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Labor $</b> "+for2.format(laborCost)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Labor Hours:</b> "+for2.format(laborHours)+"</td>");

						out.println("<td class='tdOrder' colspan='2'><b>Finishing $</b> "+for2.format(finishCost)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Total Cost $</b> "+for2.format(totCost)+"</td>");
						out.println("<td class='tdOrder'><b>SF: </b> "+rs1.getString("totsqft")+"</td>");
						out.println("</tr>");
					}
					else if(lineProductId.equals("FSM")){
						out.println("<tr>");
						out.println("<td class='tdOrder' >"+rs1.getString("model")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("mark")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("width")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("height")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("qty")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("finish")+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("sects")+"</td>");
						out.println("<td class='tdOrder' >"+for0.format(rs1.getDouble("totwt"))+"</td>");
						out.println("<td class='tdOrder' >"+rs1.getString("horizcell")+" </td>");
						out.println("<td class='tdOrder' >"+rs1.getString("vertcell")+" </td>");
						out.println("</tr>");
						out.println("</tr>");
						out.println("<td class='tdOrder' colspan='3'><b>PSF:</b> "+rs1.getString("ewload")+"</font></td>");

						out.println("<td class='tdOrder' colspan='3'><b>Perimeter:</b> <font color='red'>"+rs1.getString("totperim")+"perimeter</font></td>");
						out.println("<td class='tdOrder' colspan='3'><b>SF Area:</b>"+for0.format(rs1.getDouble("totsqft"))+"</td>");

						out.println("</tr>");
						out.println("<tr>");
						out.println("<td class='tdOrder' colspan='2'><b>Material $</b> "+for2.format(materialCost)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Labor $</b> "+for2.format(laborCost)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Labor Hours:</b> "+for2.format(laborHours)+"</td>");
						//out.println("<td class='tdOrder' colspan='2'><b>H-Splice:</b> "+hSplice+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Finishing $</b> "+for2.format(finishCost)+"</td>");
						out.println("<td class='tdOrder' colspan='2'><b>Total Cost $</b> "+for2.format(totCost)+"</td>");
						out.println("</tr>");
					}
				}
			}
			rs1.close();
			out.println("<tr><td colspan='12'><hr/></td></tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right'><b>TOTAL</b></td>");
			
			
                        if(productId.toUpperCase().equals("GRILLE")){
                           out.println("<td class='tdOrder' align='right'><b>Total Grilles:&nbsp;</b></td>"); 
                        }
                        else{
                            out.println("<td class='tdOrder' align='right' colspan='3'><b>Total Lvrs:&nbsp;</b></td>");
                        }
                        
			out.println("<td class='tdOrder' >"+lvrTotal+"</td>");
                        if(productId.toUpperCase().equals("GRILLE")){
                        out.println("<td class='tdOrder'></td>");
                        out.println("<td class='tdOrder'></td>");
                        
			out.println("<td class='tdOrder'></td>");
                        out.println("<td class='tdOrder'></td>");
                        }
                         //out.println("<td class='tdOrder'></td>");
                          
			out.println("<td class='tdOrder' colspan='2' align='right'><b>Total Sections:&nbsp;</td>");
                          out.println("<td class='tdOrder'>"+secTotal+"</td>");
			
			out.println("<td class='tdOrder'></td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' colspan='2'><b>Material $&nbsp;</b> "+for2.format(materialTotal)+"</td>");
			out.println("<td class='tdOrder' colspan='2'><b>Labor $&nbsp;</b> "+for2.format(laborTotal)+"</td>");
			out.println("<td class='tdOrder' colspan='2'><b>Labor Hours&nbsp;<b> "+for2.format(laborHoursTotal)+"</td>");
			
			out.println("<td class='tdOrder' colspan='2'><b>Finishing $&nbsp;</b> "+for2.format(finishTotal)+"</td>");
                        out.println("<td class='tdOrder' colspan='2'><b>Weight:</b> "+for2.format(weightTotal)+" Lbs.</td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right'><b>Totals:</b></td>");
			out.println("<td class='tdOrder' align='right'><b>Area =&nbsp;</b></td>");
			out.println("<td class='tdOrder' align='left'>"+for2.format(areaTotal));
                        if(exchName!= null && exchName.equals("CAD")){
                            out.println("("+(new Float((areaTotal+0.5)*.0929).intValue())+" Sq.M.)");
                        }
                        out.println("</td>");
			out.println("<td class='tdOrder' align='right' colspan='2'><b>Surface Area =&nbsp;</b></td>");
			out.println("<td class='tdOrder' align='left'>"+for2.format(surfaceTotal)+"</td>");
			out.println("<td class='tdOrder' align='right'><b>Perimeter =&nbsp;</b></td>");
			out.println("<td class='tdOrder' align='left'>"+for2.format(perimeterTotal)+"</td>");
                        if(productId.toUpperCase().equals("GRILLE")){
                            out.println("<td class='tdOrder' align='right' colspan='2'></td>");
                            out.println("<td class='tdOrder' align='left'></td>");   
                        }
                        else{
                            out.println("<td class='tdOrder' align='right' colspan='2'><b>Total Cubic Footage =&nbsp;</b> </td>");
                            out.println("<td class='tdOrder' align='left'>"+for2.format(cubicTotal)+"</td>");
                        }
			out.println("</tr>");

			out.println("<tr><td colspan='12'><hr/></td></tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right' colspan='2'><b>Total cost group</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(totalCostGroup)+"</td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(totalCostGroup/sellPrice*100)+"%</td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right' colspan='2'><b>Drafting</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(drafting)+"</td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(drafting/sellPrice*100)+" %</td>");
			out.println("<td class='tdOrder' align='right'>"+draftingHours+" HRS.</td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right' colspan='2'><b>Layout</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(layout)+"</td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(layout/sellPrice*100)+" %</td>");
			out.println("<td class='tdOrder' align='right'>"+layoutHours+" HRS.</td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right' colspan='2'><b>Engineering</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(engineering)+"</td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(engineering/sellPrice*100)+" %</td>");
			out.println("<td class='tdOrder' align='right'>"+engineeringHours+" HRS.</td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right' colspan='2'><b>Project Mgmt</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(projectManagement)+"</td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(projectManagement/sellPrice*100)+" %</td>");
			out.println("<td class='tdOrder' align='right'>"+projectManagementHours+" HRS.</td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right' colspan='2'><b>Freight/Crate</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(freightCrate)+"</td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(freightCrate/sellPrice*100)+" %</td>");
			out.println("<td class='tdOrder' align='right' colspan='2'><b>Freight</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(freight)+"</td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder' align='right'>Actual</td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(actualComm)+" %</td>");
			out.println("<td class='tdOrder' align='left' colspan='2'>&nbsp; of sell less F&C</td>");
			out.println("</tr>");
                        /*
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right' colspan='2'><b>Freight</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(freight)+"</td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(freight/sellPrice*100)+" %</td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right' colspan='2'><b>Crate</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(crate)+"</td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(crate/sellPrice*100)+" %</td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right' colspan='2'><b>Export Crate</b></td>");
			out.println("<td class='tdOrder' align='right'>"+exportCrate+"</td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(exportCrate/sellPrice*100)+" %</td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("</tr>");
                        */
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right' colspan='2'><b>Commission</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(commissiondollars)+"</td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(commissiondollars/sellPrice*100)+" %</td>");
                        out.println("<td class='tdOrder' align='right' colspan='2'><b>Crate</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(crate)+"</td>");
                        
                        out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder' align='right'>Std Comm</td>");
			out.println("<td class='tdOrder' align='right'>"+stdComm+" %</td>");
			out.println("<td class='tdOrder'></td>");
			

			out.println("</tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right' colspan='2'></td>");
			out.println("<td class='tdOrder' align='right'></td>");
			out.println("<td class='tdOrder' align='right'></td>");
                        out.println("<td class='tdOrder' align='right' colspan='2'><b>Export Crate</b></td>");
			out.println("<td class='tdOrder' align='right'>"+exportCrate+"</td>");
                        out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder' align='right'>Special Comm</td>");
			out.println("<td class='tdOrder' align='right'>"+spComm+" %</td>");
			out.println("<td class='tdOrder'></td>");
			

			out.println("</tr>");
                        /*
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right' colspan='2'></td>");
			out.println("<td class='tdOrder' align='right'></td>");
			out.println("<td class='tdOrder' align='right'></td>");
                        out.println("<td class='tdOrder' align='right'></td>");
                        out.println("<td class='tdOrder' align='right'></td>");
                        out.println("<td class='tdOrder' align='right'></td>");
			out.println("<td class='tdOrder' align='right'></td>");
			out.println("<td class='tdOrder' align='right'>Special Comm</td>");
			out.println("<td class='tdOrder' align='right'>"+spComm+" %</td>");
			out.println("<td class='tdOrder'></td>");
			

			out.println("</tr>");
                        */
			out.println("<tr><td></td><td colspan='6'><hr/></td><td></td></tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right' colspan='2'><b>Actual Cost of Sale</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(totalCost)+"</td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(totalCost/sellPrice*100)+" %</td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder' align='right'><b>Price</b></td>");
			out.println("<td class='tdOrder' align='right'><b>Weight</b></td>");
			out.println("<td class='tdOrder' align='center'><b>Description</b></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right' colspan='2'><b>Gross Profit Margin</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(marginDollars)+"</td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(marginDollars/sellPrice*100)+"%</td>");
			out.println("<td class='tdOrder'><b>&nbsp;&nbsp;Catchall1</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(pInfCatchall1)+"</td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(pInfCatchallWt1)+"</td>");
			out.println("<td class='tdOrder' align='right' colspan='3'>&nbsp;&nbsp;"+pInfCatchallDesc1+"</td>");
			out.println("<td class='tdOrder'></td>");
			
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right' colspan='2'><b>Sell Price</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(sellPrice)+"</td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(sellPrice/sellPrice*100)+"%</td>");
			out.println("<td class='tdOrder'><b>&nbsp;&nbsp;Catchall2</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(pInfCatchall2)+"</td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(pInfCatchallWt2)+"</td>");
			out.println("<td class='tdOrder' align='right' colspan='3'>&nbsp;&nbsp;"+pInfCatchallDesc2+"</td>");
			out.println("<td class='tdOrder'></td>");
			//out.println("<td class='tdOrder'><b>Labor cost</b></td>");
			//out.println("<td class='tdOrder'>23</td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right' colspan='2'><b>Total Price</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(totalPrice));                     
                        out.println("</td>");
			out.println("<td class='tdOrder' align='right'>");
                        if(exchName!= null && exchName.equals("CAD")){
                                out.println("("+for2.format(totalPrice*new Double(exchRate).doubleValue())+" "+exchName+")");
                        } 
                        out.println("</td>");
			out.println("<td class='tdOrder'><b>&nbsp;&nbsp;Catchall3</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(pInfCatchall3)+"</td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(pInfCatchallWt3)+"</td>");
			out.println("<td class='tdOrder' align='right' colspan='3'>&nbsp;&nbsp;"+pInfCatchallDesc3+"</td>");
			out.println("<td class='tdOrder'></td>");
			//out.println("<td class='tdOrder'><b>Crated Weight</b></td>");
			//out.println("<td class='tdOrder'>"+crated_weight+"</td>");
                        out.println("</tr>"); 
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right' colspan='2'><b>Price/Sq.Ft.</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(dollarsf)+"</td>");
			out.println("<td class='tdOrder' align='right'>");
                        if(exchName!= null && exchName.equals("CAD")){
                            out.println("("+for2.format(new Double(totalPrice).doubleValue()/new Float((areaTotal+0.5)*.0929).intValue())+" $/Sq.M)");  
                        }
                        out.println("</td>");
			out.println("<td class='tdOrder'><b>&nbsp;&nbsp;Catchall4</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(pInfCatchall4)+"</td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(pInfCatchallWt4)+"</td>");
			out.println("<td class='tdOrder' align='right' colspan='3'>&nbsp;&nbsp;"+pInfCatchallDesc4+"</td>");
			out.println("<td class='tdOrder'></td>");
			//out.println("<td class='tdOrder'><b>Alum Cost</b></td>");
			//out.println("<td class='tdOrder'>"+alumCost+"</td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right' colspan='2'><b>Yield</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(yield)+"</td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'><b>&nbsp;&nbsp;Catchall5</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(pInfCatchall5)+"</td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(pInfCatchallWt5)+"</td>");
			out.println("<td class='tdOrder' align='right' colspan='3'>&nbsp;&nbsp;"+pInfCatchallDesc5+"</td>");
			out.println("<td class='tdOrder'></td>");

			out.println("</tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' align='right' colspan='2'><b>Mark Up</b></td>");
			out.println("<td class='tdOrder' align='right'>"+for2.format(markUp)+"</td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("</tr>");
/*
			out.println("<tr>");
			out.println("<td class='tdOrder' colspan='2'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'>Crated Weight</td>");
			out.println("<td class='tdOrder'>"+crated_weight+"</td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' colspan='2'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'>Alum Cost</td>");
			out.println("<td class='tdOrder'>"+alumCost+"</td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' colspan='2'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'>Galv Cost</td>");
			out.println("<td class='tdOrder'>"+galvCost+"</td>");
			out.println("</tr>");
*/
			out.println("<tr>");
			out.println("<td class='tdOrder' colspan='2'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
                        if(productId.toUpperCase().equals("GRILLE")){
                            out.println("<td class='tdOrder' colspan='2'><b>Margin Target  @</b> 30-35%</td>");
                        }
                        else{
                            out.println("<td class='tdOrder' colspan='2'><b>Margin Target  @</b> 23-25%</td>");
                        }
			out.println("<td class='tdOrder' colspan='2'><b>Commission @</b> 8-12%</td>");
                        out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder' align='right'><b>Labor cost</b></td>");
			out.println("<td class='tdOrder'>26.25</td>");
			out.println("</tr>");
			out.println("<tr>");
			out.println("<td class='tdOrder' colspan='2'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
                        if(productId.toUpperCase().equals("GRILLE")){
                            out.println("<td class='tdOrder' colspan='4'><b>Price/LB Target:</b> $10.01</td>");
                        }
                        else{
                            out.println("<td class='tdOrder' colspan='4'><b>Price/LB Target:</b> $8.10</td>");
                        }
                      //  out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder' colspan='2' align='right'><b>Crated Weight</b></td>");
                        
			out.println("<td class='tdOrder'>"+crated_weight+"</td>");                      
                        out.println("</tr>");
                        out.println("<tr>");
			out.println("<td class='tdOrder' colspan='7'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
                        out.println("<td class='tdOrder' align='right'><b>Alum Cost</b></td>");
			out.println("<td class='tdOrder'>"+alumCost+"</td>");
                        out.println("</tr>");
                        out.println("<tr>");
			out.println("<td class='tdOrder' colspan='7'></td>");
			out.println("<td class='tdOrder'></td>");
			out.println("<td class='tdOrder'></td>");
  			if(galvCost!=null && galvCost.trim().length()>0 && !galvCost.trim().equals(".00")){
				out.println("<td class='tdOrder' align='right'><b>Galv Cost</b></td>");
				out.println("<td class='tdOrder'>"+galvCost+"</td>");
			}
			else{
				out.println("<td class='tdOrder'></td>");
				out.println("<td class='tdOrder'></td>");
			}                      
                        out.println("</tr>");
			
			out.println("<tr><td colspan='12'><hr/></td></tr>");
			out.println("</table>");
		}
	%>
</body>
<%
stmt.close();
myConn.close();
}
catch(SQLException ee){
out.println("SQL ERROR::"+ee);
}
catch(Exception e){
out.println("ERROR::"+e);
}
%>