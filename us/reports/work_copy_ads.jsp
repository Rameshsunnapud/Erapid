
<%


//NumberFormat for1 = NumberFormat.getInstance();
for1.setMaximumFractionDigits(2);
for1.setMinimumFractionDigits(2);
NumberFormat for1x= NumberFormat.getInstance();
for1x.setMaximumFractionDigits(2);
for1x.setMinimumFractionDigits(0);
NumberFormat for2 = NumberFormat.getInstance();
for2.setMaximumFractionDigits(0);
for2.setMinimumFractionDigits(0);
String ordertype= request.getParameter("type");//type
//String order_no = request.getParameter("order_no");
String DESC=request.getParameter("DESC");
String ADD=request.getParameter("ADD");
String SECT=request.getParameter("SECT");
String DATE=request.getParameter("DATE");
String CSDECO=request.getParameter("CSDECO");
if(CSDECO==null){CSDECO="";};
String layoutRate="";
String draftingRate="";
String projectMgmtRate="";
String globalCatchall="";
String globalDrafting="";
String globalLayout="";
String globalProjectMgmt="";
String globalCoordination="";
String globalFreight="";
String globalMargin="";
String globalPrice="";
String globalCost="";
String globalCommissionDollar="";
String draftingHours="";
String layoutHours="";
String projectMgmtHours="";
String message="";
String globalCommission="";
String selected="";
String defaultCommission="";
String freightCommFactor="";
double fcperc=0;
double costTotal=0;
double globalCoordinationDollar=0;
int totalDoors=0;

int csquoteCount=0;
int csadsCount=0;

boolean readValue=false;
//coordination
Vector coordinationLevel=new Vector();
Vector charge=new Vector();

//csquotes
Vector costPerc = new Vector();
Vector block_idx = new Vector();
Vector model=new Vector();
Vector qty=new Vector();
Vector cost = new Vector();
Vector field = new Vector();

//cs_ads_price_calc
Vector model2=new Vector();
Vector qty2=new Vector();
Vector cost2=new Vector();
Vector catchall=new Vector();
Vector drafting=new Vector();
Vector layout=new Vector();
Vector projectMgmt=new Vector();
Vector coordination=new Vector();
Vector coordinationDollar=new Vector();
Vector defaultMargin=new Vector();
Vector margin = new Vector();
Vector linePrice=new Vector();
Vector freight=new Vector();
Vector commissionx=new Vector();
Vector modelCost=new Vector();
//out.println(CSDECO);

ResultSet rs1x=stmt.executeQuery("select * from cs_ads_price_calc where order_no='"+order_no+"' and model='GLOBAL'");
if(rs1x != null){
//out.println("select * from cs_ads_price_calc where order_no='"+order_no+"' and model='GLOBAL'");
	while(rs1x.next()){
		DESC=rs1x.getString("DESCRIPTION");
		ADD=rs1x.getString("ADDENDA");
		SECT=rs1x.getString("SECT");
		DATE=rs1x.getString("PLANDATE");
		CSDECO=rs1x.getString("CSDECO");
		//out.println("HER");
	}
}
rs1x.close();
//out.println(CSDECO+" @94");

ResultSet rsCo=stmt.executeQuery("select * from cs_ads_coordination order by coordination");
if(rsCo != null){
	while(rsCo.next()){
		coordinationLevel.addElement(rsCo.getString("coordination"));
		charge.addElement(rsCo.getString("charge"));
	}
}
rsCo.close();
ResultSet rs0=stmt.executeQuery("select * from cs_defaults where product_id='ADS'");
if(rs0 != null){
	while(rs0.next()){
		draftingRate=rs0.getString("enghrrate");
		layoutRate=rs0.getString("hrrate");
		projectMgmtRate=rs0.getString("pmhrrate");
		fcperc=new Double(rs0.getString("fcperc")).doubleValue();
	}
}
rs0.close();

ResultSet rsCSQUOTES=stmt.executeQuery("select field18,sum(cast(field19 as integer)), sum(cast(extended_price as float)) from csquotes where order_no='"+order_no+"' and not block_id ='A_APRODUCT' group by field18 order by field18");
if(rsCSQUOTES != null){
	while(rsCSQUOTES.next()){
		//out.println(" @118<BR>"+"select field18,sum(cast(field19 as integer)), sum(cast(extended_price as float)) from csquotes where order_no='"+order_no+"' and not block_id ='A_APRODUCT' group by field18 order by field18");
		//block_idx.addElement(rsCSQUOTES.getString(1));
		model.addElement(rsCSQUOTES.getString(1));
		qty.addElement(rsCSQUOTES.getString(2));
		cost.addElement(rsCSQUOTES.getString(3));
		String temp="";
		//out.println(" @124");
		if(CSDECO!=null && CSDECO.equals("D")){
			temp="DECO";
		}
		else{
			temp="CS";
		}
		//out.println(" @131");
		if(new Double(rsCSQUOTES.getString(2)).doubleValue()<=30){
			temp=temp+"30";
		}
		else if(new Double(rsCSQUOTES.getString(2)).doubleValue()< 100){
			temp=temp+"99";
		}
		else{
			temp=temp+"100";
		}
		field.addElement(temp);
		csquoteCount++;
		costTotal=costTotal+new Double(rsCSQUOTES.getString(3)).doubleValue();
	}
}
//out.println(" @143");
rsCSQUOTES.close();
ResultSet rs=stmt.executeQuery("select * from cs_ads_price_calc where order_no='"+order_no+"' and model='GLOBAL'");
if(rs != null){
	if(rs.next()){
		if(rs.getString("catchall") != null){
			globalCatchall=rs.getString("catchall");
		}
		if(rs.getString("draftingDollars") != null){
			globalDrafting=rs.getString("draftingDollars");
		}
		if(rs.getString("layoutDollars") != null){
			globalLayout=rs.getString("layoutDollars");
		}
		if(rs.getString("projectMgmtDollars") != null){
			globalProjectMgmt=rs.getString("projectMgmtDollars");
		}
		if(rs.getString("coordination") != null){
			globalCoordination=rs.getString("coordination");
		}

		if(rs.getString("freight") != null){
			globalFreight=rs.getString("freight");
		}
		if(rs.getString("margin") != null){
			globalMargin=rs.getString("margin");
		}
		if(rs.getString("linePrice") != null){
			globalPrice=rs.getString("linePrice");
		}
		if(rs.getString("cost") != null){
			globalCost=rs.getString("cost");
		}
		if(rs.getString("commissionDollars") != null){
			globalCommissionDollar=rs.getString("commissionDollars");
		}
		if(rs.getString("commission") != null){
			globalCommission=rs.getString("commission");
		}

		if(rs.getString("drafting") != null){
			draftingHours=rs.getString("drafting");
		}
		if(rs.getString("layout") != null){
			layoutHours=rs.getString("layout");
		}
		if(rs.getString("projectMgmt") != null){
			projectMgmtHours=rs.getString("projectMgmt");
		}
	}
}
rs.close();
//out.println(" @194");
if(globalCommission == null || globalCommission.trim().length()<1){
	if(CSDECO.startsWith("C")){
		globalCommission="10";

	}
	else{
		globalCommission="12";

	}
}
if(CSDECO.startsWith("C")){
	defaultCommission="10";
	freightCommFactor="0.091";
}
else{
	defaultCommission="12";
	freightCommFactor="0.12";
}

ResultSet rs11=stmt.executeQuery("select * from cs_ads_price_calc where order_no='"+order_no+"' and not model='GLOBAL' order by model");
if(rs11 != null){
	while(rs11.next()){
		globalCoordinationDollar=globalCoordinationDollar+new Double(rs11.getString("coordinationDollars")).doubleValue();
		model2.addElement(rs11.getString("model"));
		qty2.addElement(rs11.getString("qty"));
		cost2.addElement(rs11.getString("cost"));
		catchall.addElement(rs11.getString("catchall"));
		drafting.addElement(rs11.getString("drafting"));
		layout.addElement(rs11.getString("layout"));
		projectMgmt.addElement(rs11.getString("projectMgmt"));
		coordination.addElement(rs11.getString("coordination"));
		coordinationDollar.addElement(rs11.getString("coordinationDollars"));
		margin.addElement(""+new Double(rs11.getString("margin")).doubleValue()/100);
		linePrice.addElement(rs11.getString("linePrice"));
		freight.addElement(rs11.getString("freight"));
		commissionx.addElement(rs11.getString("commission"));
		double tempModelCost=0;
		tempModelCost=tempModelCost+new Double(rs11.getString("cost")).doubleValue();
		tempModelCost=tempModelCost+new Double(rs11.getString("catchall")).doubleValue();
		tempModelCost=tempModelCost+new Double(rs11.getString("drafting")).doubleValue();
		tempModelCost=tempModelCost+new Double(rs11.getString("layout")).doubleValue();
		tempModelCost=tempModelCost+new Double(rs11.getString("projectMgmt")).doubleValue();
		//tempModelCost=tempModelCost+new Double(rs11.getString("coordinationDollars")).doubleValue();
		tempModelCost=tempModelCost+new Double(rs11.getString("freight")).doubleValue();
		tempModelCost=tempModelCost+new Double(rs11.getString("commission")).doubleValue();
		modelCost.addElement(""+tempModelCost);
		csadsCount++;
		readValue=true;
	}
}
rs11.close();

if(readValue){
	if(csadsCount==csquoteCount){
		for(int i=0; i<model.size(); i++){
			if(model.elementAt(i).toString().equals(model2.elementAt(i).toString())){

				if(new Double(qty.elementAt(i).toString()).doubleValue()==new Double(qty2.elementAt(i).toString()).doubleValue()){
					//out.println(cost.elementAt(i).toString()+"::"+cost2.elementAt(i).toString()+"<BR>");
					if(for1.format(new Double(cost.elementAt(i).toString()).doubleValue()).equals(for1.format(new Double(cost2.elementAt(i).toString()).doubleValue()))){
						readValue=true;
					}
					else{
						readValue=false;
						message="cost has changed" ;
					}


				}
				else{
					readValue=false;
					message="qty's have changed";
				}

			}
			else{
				readValue=false;
				message="model has changed";
			}
		}
	}
	else{
		readValue=false;
		message="Number of models has changed.";
	}
}
else{
	message="";
}
out.println(message);
for(int yy=0; yy<model.size(); yy++){
	String sqlx="select "+field.elementAt(yy).toString()+" from cs_ads_margin where model='"+model.elementAt(yy).toString()+"'";
	ResultSet rsMarginx=stmt.executeQuery(sqlx);
	if(rsMarginx != null){
		while(rsMarginx.next()){
			defaultMargin.addElement(""+for2.format(new Double(rsMarginx.getString(1)).doubleValue()*100));
		}
	}
	rsMarginx.close();
}














if(readValue){

	out.println("<form name='form1' action='ads_price_calc_page3.jsp' method='post'>");
	for(int z=0; z<charge.size(); z++){
		out.println("<input type='hidden' name='charge' value='"+charge.elementAt(z).toString()+"'>");
	}

	out.println("<input type='hidden' name='fcperc' value='"+fcperc+"'>");
	out.println("<input type='hidden' name='order_no' value='"+order_no+"'>");
	out.println("<input type='hidden' name='defaultCommission' value='"+defaultCommission+"'>");
	out.println("<input type='hidden' name='DESC' value='"+DESC+"'>");
	out.println("<input type='hidden' name='ADD' value='"+ADD+"'>");
	out.println("<input type='hidden' name='SECT' value='"+SECT+"'>");
	out.println("<input type='hidden' name='DATE' value='"+DATE+"'>");
	out.println("<input type='hidden' name='CSDECO' value='"+CSDECO+"'>");
	out.println("<input type='hidden' name='layoutRate' value='"+layoutRate+"'>");
	out.println("<input type='hidden' name='draftingRate' value='"+draftingRate+"'>");
	out.println("<input type='hidden' name='projectMgmtRate' value='"+projectMgmtRate+"'>");
	out.println("<input type='hidden' name='countx' value='"+csquoteCount+"'>");
	out.println("<input type='hidden' name='csadsCount' value='"+csadsCount+"'>");
	out.println("<input type='hidden' name='freightCommFactor' value='"+freightCommFactor+"'>");
	out.println("<table border='1' width='100%'>");
	out.println("<tr class='important'><td style='font-size:8pt;background-color:#e9f2f7;' colspan='6' align='center'>Global</td></tr>");
	out.println("<tr><td style='font-size:8pt;'>Drafting</td><td style='font-size:8pt;'>hrs"+draftingHours+"$"+globalDrafting+"</td>");
	out.println("<td style='font-size:8pt;'>Layout</td><td style='font-size:8pt;'>hrs"+layoutHours+"$"+globalLayout+"</td>");
	out.println("<td style='font-size:8pt;'>Project Management</td><td style='font-size:8pt;'>hrs"+projectMgmtHours+"$"+globalProjectMgmt+"</td></tr>");
	out.println("<tr><td style='font-size:8pt;'>Catchall</td><td style='font-size:8pt;'>$"+globalCatchall+"</td>");
	out.println("<td style='font-size:8pt;'>Freight and Crate</td><td style='font-size:8pt;'>$"+globalFreight+"</td>");
	out.println("<td style='font-size:8pt;'>Commission</td><td style='font-size:8pt;'>%"+globalCommission+"$"+globalCommissionDollar+"</td></tr>");
	out.println("<tr><td style='font-size:8pt;'>Coordination</td><td style='font-size:8pt;'>");
	if(globalCoordination.equals("0.00")){
		out.println("By Others");
	}
	if(globalCoordination.equals("1.00")){
		out.println("No Frames");
	}
	if(globalCoordination.equals("2.00")){
		out.println("Existing Frames");
	}
	out.println("</td>");
	out.println("<td style='font-size:8pt;'>Price</td><td style='font-size:8pt;'>$"+globalPrice+"</td>");
	out.println("<td style='font-size:8pt;'>Margin</td><td style='font-size:8pt;'>%"+globalMargin+"</td></tr>");

	out.println("</table>");

double totalTemp=0;

	out.println("<table border='1' width='100%'>");
	out.println("<tr class='important'><td style='font-size:8pt;background-color:#e9f2f7;' colspan='13' align='center'>Model Specifics</td></tr>");
	out.println("<tr><td  style='font-size:7pt;background-color:#c2d7eb;'>Model</td><td style='font-size:7pt;background-color:#c2d7eb;'>Qty</td><td style='font-size:7pt;background-color:#c2d7eb;'>Cost($)</td><td style='font-size:7pt;background-color:#c2d7eb;'>Margin(%)</td><td style='font-size:7pt;background-color:#c2d7eb;'>Drafting($)</td><td style='font-size:7pt;background-color:#c2d7eb;'>Layout($)</td><td style='font-size:7pt;background-color:#c2d7eb;'>Project Mgmt($)</td><td style='font-size:7pt;background-color:#c2d7eb;'>Catchall($)</td><td style='font-size:7pt;background-color:#c2d7eb;'>F&C($)</td><td style='font-size:7pt;background-color:#c2d7eb;'>Comm($)</td><td style='font-size:7pt;background-color:#c2d7eb;'>Coord($)</td><td style='font-size:7pt;background-color:#c2d7eb;'>Tot Cost($)</td><td style='font-size:7pt;background-color:#c2d7eb;'>Price($)</td></tr>");
	double perc=0;
	for(int x=0; x<model.size(); x++){
		out.println("<input type='hidden' name='defaultMargin' value='"+defaultMargin.elementAt(x).toString()+"'>");
		double temp=new Double(cost.elementAt(x).toString()).doubleValue()/costTotal;
		costPerc.addElement(""+temp);
		out.println("<tr>");
		//out.println(margin.elementAt(x).toString()+"::HEREx<BR>");
		out.println("<td style='font-size:8pt;'>"+model.elementAt(x).toString()+"");
		out.println("<input type='hidden' name='costPerc' value='"+costPerc.elementAt(x).toString()+"' ></td>");
		out.println("<td style='font-size:8pt;'>"+qty.elementAt(x).toString()+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1.format(new Double(cost.elementAt(x).toString()).doubleValue())+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1x.format(new Double(margin.elementAt(x).toString()).doubleValue()*100)+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1.format(new Double(drafting.elementAt(x).toString()).doubleValue())+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1.format(new Double(layout.elementAt(x).toString()).doubleValue())+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1.format(new Double(projectMgmt.elementAt(x).toString()).doubleValue())+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1.format(new Double(catchall.elementAt(x).toString()).doubleValue())+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1.format(new Double(freight.elementAt(x).toString()).doubleValue())+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1.format(new Double(commissionx.elementAt(x).toString()).doubleValue())+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1.format(new Double(coordinationDollar.elementAt(x).toString()).doubleValue())+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1.format(new Double(modelCost.elementAt(x).toString()).doubleValue())+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1.format(new Double(linePrice.elementAt(x).toString()).doubleValue())+"</td>");
		//totalTemp=totalTemp+new Double(modelCost.elementAt(x).toString()).doubleValue();
		out.println("</tr>");
	}

	out.println("</table>");

	//out.println(totalTemp+"<BR>");
	totalTemp=0;

	Vector block_id3=new Vector();
	Vector line_no3=new Vector();
	Vector model3=new Vector();
	Vector qty3=new Vector();
	Vector cost3=new Vector();
	Vector mark3=new Vector();
	Vector bpcsNo3=new Vector();
	ResultSet rsCSQUOTES2=stmt.executeQuery("select block_id,field18,cast(field19 as integer), cast(extended_price as float),line_no,field17,bpcs_part_no from csquotes where order_no='"+order_no+"' and not block_id ='A_APRODUCT' order by cast(line_no as integer),sequence_no,bpcs_part_no,field18 desc");
	if(rsCSQUOTES2 != null){
		while(rsCSQUOTES2.next()){
			block_id3.addElement(rsCSQUOTES2.getString(1));
			model3.addElement(rsCSQUOTES2.getString(2));
			qty3.addElement(rsCSQUOTES2.getString(3));
			cost3.addElement(rsCSQUOTES2.getString(4));
			line_no3.addElement(rsCSQUOTES2.getString(5));
			//out.println(rsCSQUOTES2.getString(5)+"::<BR>");
			mark3.addElement(rsCSQUOTES2.getString(6));
			bpcsNo3.addElement(rsCSQUOTES2.getString(7));
			//out.println(rsCSQUOTES2.getString(7)+"::");
		}
	}
	rsCSQUOTES2.close();
	out.println("<table border='1' width='100%'><tr class='important'><td style='font-size:8pt;background-color:#e9f2f7;' colspan='9' align='center'>Line Detail</td></tr><tr><td style='font-size:7pt;background-color:#c2d7eb;' width='10%'>Line#</td><td style='font-size:7pt;background-color:#c2d7eb;' width='10%'>MK</td><td style='font-size:7pt;background-color:#c2d7eb;' width='20%'>Part</td><td style='font-size:7pt;background-color:#c2d7eb;' width='10%'>QTY</td><td style='font-size:7pt;background-color:#c2d7eb;' width='10%'>Base Tot Cost</td><td style='font-size:7pt;background-color:#c2d7eb;' width='10%'>Unit Cost</td><td style='font-size:7pt;background-color:#c2d7eb;' width='10%'>Tot Cost</td><td style='font-size:7pt;background-color:#c2d7eb;' width='10%'>Unit Sell</td><td style='font-size:7pt;background-color:#c2d7eb;' width='10%'>Total Sell</td></tr>");

	Vector line_no4=new Vector();
	Vector qty4=new Vector();
	Vector baseCost4=new Vector();
	Vector mark4=new Vector();
	Vector unitCost4=new Vector();
	Vector totCost4=new Vector();
	Vector unitSell4=new Vector();
	Vector totSell4=new Vector();
	Vector bpcsNo4=new Vector();
	String oldLineNo="";
	String oldMark="";
	String oldQty="";
	String oldBpcs="";
	double oldBaseCost=0;
	double oldUnitCost=0;
	double oldTotCost=0;
	double oldUnitSell=0;
	double oldTotSell=0;
	totalTemp=0;

	for(int i=0; i<line_no3.size(); i++){
		double percent=0;
		double costTemp=0;
		double sellTemp=0;
		double unitCostTemp=0;
		double unitSellTemp=0;
		for(int j=0; j<model2.size(); j++){
			if(model2.elementAt(j).toString().equals(model3.elementAt(i).toString())){
				percent=new Double(cost3.elementAt(i).toString()).doubleValue()/new Double(cost2.elementAt(j).toString()).doubleValue();
				//percent=1;
				costTemp=percent*new Double(modelCost.elementAt(j).toString()).doubleValue();
				if(model2.elementAt(j).toString().equals("EDGE")){
					totalTemp=totalTemp+costTemp;
					//out.println(costTemp+"::"+percent+"::"+totalTemp+"<BR>");
				}

				sellTemp=percent*new Double(linePrice.elementAt(j).toString()).doubleValue();
				unitCostTemp=costTemp/new Double(qty3.elementAt(i).toString()).doubleValue();
				unitSellTemp=sellTemp/new Double(qty3.elementAt(i).toString()).doubleValue();
				j=model2.size();
			}
		}
		out.println("<tr>");
		out.println("<td style='font-size:8pt;'>"+line_no3.elementAt(i).toString()+"</td>");
		out.println("<td style='font-size:8pt;'>"+mark3.elementAt(i).toString()+"</td>");
		out.println("<td style='font-size:8pt;'>"+model3.elementAt(i).toString()+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+qty3.elementAt(i).toString()+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>$"+cost3.elementAt(i).toString()+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1.format(unitCostTemp)+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1.format(costTemp)+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1.format(unitSellTemp)+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1.format(sellTemp)+"</td>");
		//totalTemp=totalTemp+new Double(costTemp).doubleValue();
		out.println("</tr>");
		if(i==0||!oldLineNo.equals(line_no3.elementAt(i).toString())||!oldBpcs.equals(bpcsNo3.elementAt(i).toString())){
			if(i>0){
				bpcsNo4.addElement(oldBpcs);
				line_no4.addElement(oldLineNo);
				qty4.addElement(oldQty);
				mark4.addElement(oldMark);
				baseCost4.addElement(""+oldBaseCost);
				unitCost4.addElement(""+oldUnitCost);
				totCost4.addElement(""+oldTotCost);
				unitSell4.addElement(""+oldUnitSell);
				totSell4.addElement(""+oldTotSell);
			}
			oldQty="";
			if(block_id3.elementAt(i).toString().equals("A_CORE")){
				oldQty=""+Integer.parseInt(qty3.elementAt(i).toString());
			}
			oldBpcs=bpcsNo3.elementAt(i).toString();
			oldLineNo=line_no3.elementAt(i).toString();
			oldMark=mark3.elementAt(i).toString();
			oldBaseCost=new Double(cost3.elementAt(i).toString()).doubleValue();
			oldUnitCost=unitCostTemp;
			oldTotCost=costTemp;
			oldUnitSell=unitSellTemp;
			oldTotSell=sellTemp;

		}

		else{
			if(block_id3.elementAt(i).toString().equals("A_CORE")){
				if(oldQty.trim().length()<1){
					oldQty=""+Integer.parseInt(qty3.elementAt(i).toString());
				}
				else{
					oldQty=""+(Integer.parseInt(oldQty)+Integer.parseInt(qty3.elementAt(i).toString()));
				}
			}
			oldBaseCost=oldBaseCost+new Double(cost3.elementAt(i).toString()).doubleValue();
			oldUnitCost=oldUnitCost+unitCostTemp;
			oldTotCost=oldTotCost+costTemp;
			oldUnitSell=oldUnitSell+unitSellTemp;
			oldTotSell=oldTotSell+sellTemp;
		}
		if(i==line_no3.size()-1){
			bpcsNo4.addElement(oldBpcs);
			line_no4.addElement(oldLineNo);
			qty4.addElement(oldQty);
			mark4.addElement(oldMark);
			baseCost4.addElement(""+oldBaseCost);
			unitCost4.addElement(""+oldUnitCost);
			totCost4.addElement(""+oldTotCost);
			unitSell4.addElement(""+oldUnitSell);
			totSell4.addElement(""+oldTotSell);
		}

	}
	double configured=0;
	double totalcost=0;
	double sellprice=0;
	out.println("</table>");
	out.println("<table border='1' width='100%'><tr class='important'><td style='font-size:8pt;background-color:#e9f2f7;' colspan='9' align='center'>Line Summary</td></tr><tr><td style='font-size:7pt;background-color:#c2d7eb;' width='10%'>Line#</td><td style='font-size:7pt;background-color:#c2d7eb;' width='10%'>MK</td><td style='font-size:7pt;background-color:#c2d7eb;' width='20%'>Part</td><td style='font-size:7pt;background-color:#c2d7eb;' width='10%'>QTY</td><td style='font-size:7pt;background-color:#c2d7eb;' width='10%'>Base Tot Cost</td><td style='font-size:7pt;background-color:#c2d7eb;' width='10%'>Unit Cost</td><td style='font-size:7pt;background-color:#c2d7eb;' width='10%'>Tot Cost</td><td style='font-size:7pt;background-color:#c2d7eb;' width='10%'>Unit Sell</td><td style='font-size:7pt;background-color:#c2d7eb;' width='10%'>Total Sell</td></tr>");
	myConn.setAutoCommit(false);
	try{
		stmt.executeUpdate("delete from cs_ads_pricing_output where order_no='"+order_no+"' ");
	}
	catch (java.sql.SQLException e){
		out.println("Problem with deleting from cs_ads_pricing_output table");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}
	for(int i=0; i<line_no4.size(); i++){
		totalDoors=totalDoors+Integer.parseInt(qty4.elementAt(i).toString());
		out.println("<tr>");
		out.println("<td style='font-size:8pt;'>"+line_no4.elementAt(i).toString()+"</td>");
		out.println("<td style='font-size:8pt;'>"+mark4.elementAt(i).toString()+"</td>");
		out.println("<td style='font-size:8pt;'>"+bpcsNo4.elementAt(i).toString()+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+qty4.elementAt(i).toString()+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1.format(new Double(baseCost4.elementAt(i).toString()).doubleValue())+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1.format(new Double(totCost4.elementAt(i).toString()).doubleValue()/new Double(qty4.elementAt(i).toString()).doubleValue())+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1.format(new Double(totCost4.elementAt(i).toString()).doubleValue())+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1.format(new Double(totSell4.elementAt(i).toString()).doubleValue()/new Double(qty4.elementAt(i).toString()).doubleValue())+"</td>");
		out.println("<td style='font-size:8pt;' align='right'>"+for1.format(new Double(totSell4.elementAt(i).toString()).doubleValue())+"</td>");
		out.println("</tr>");
		configured=configured+new Double(baseCost4.elementAt(i).toString()).doubleValue();
		totalcost=totalcost+new Double(totCost4.elementAt(i).toString()).doubleValue();
		sellprice=sellprice+new Double(totSell4.elementAt(i).toString()).doubleValue();

		String tempbpcsgen="";
		//out.println("select bpcs_gen from csquotes where order_no='"+order_no+"' and line_no='"+line_no4.elementAt(i).toString()+"'<BR>");
		ResultSet rsbpcsgen=stmt.executeQuery("select bpcs_gen from csquotes where order_no='"+order_no+"' and line_no='"+line_no4.elementAt(i).toString()+"' and not block_id='A_APRODUCT' and bpcs_part_no='"+bpcsNo4.elementAt(i).toString()+"'");
		if(rsbpcsgen != null){
			while(rsbpcsgen.next()){
				tempbpcsgen=rsbpcsgen.getString(1);
			}
		}
		rsbpcsgen.close();
		if(tempbpcsgen == null){
			tempbpcsgen="";
		}


		try{
			String updateString ="INSERT INTO cs_ads_pricing_output (order_no,line_no,mark,part_no,bpcs_gen,qty, base_cost,unit_cost,total_cost,unit_sell,total_sell)VALUES(?,?,?,?,?,?,?,?,?,?,?) ";
			java.sql.PreparedStatement update1 = myConn.prepareStatement(updateString);
			update1.setString(1,order_no);
			update1.setString(2,line_no4.elementAt(i).toString());
			update1.setString(3,mark4.elementAt(i).toString());
			update1.setString(4,bpcsNo4.elementAt(i).toString());
			update1.setString(5,tempbpcsgen);
			update1.setString(6,qty4.elementAt(i).toString());
			update1.setString(7,""+baseCost4.elementAt(i).toString());
			update1.setString(8,""+new Double(totCost4.elementAt(i).toString()).doubleValue()/new Double(qty4.elementAt(i).toString()).doubleValue());
			update1.setString(9,totCost4.elementAt(i).toString());
			update1.setString(10,""+new Double(totSell4.elementAt(i).toString()).doubleValue()/new Double(qty4.elementAt(i).toString()).doubleValue());
			update1.setString(11,totSell4.elementAt(i).toString());
			int rocount=update1.executeUpdate();
			update1.close();
		}
		catch (java.sql.SQLException e){
			out.println("Problem with entering into cs_ads_pricing_output table");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}













		/*
		try{
			java.sql.PreparedStatement ps=myConn.prepareStatement("UPDATE csquotes SET unit_price =? WHERE Order_no =? and line_no =? and bpcs_part_no=?");
			ps.setDouble(1,new Double(totSell4.elementAt(i).toString()).doubleValue());
			ps.setString(2,order_no);
			ps.setString(3,line_no4.elementAt(i).toString());
			ps.setString(4,bpcsNo4.elementAt(i).toString());
			int re=ps.executeUpdate();
			ps.close();
		}
		catch (java.sql.SQLException e){
			out.println("Problem with ENTERING TO CSQUOTES"+"<br>");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}
		*/

	}
	myConn.commit();
	out.println("</table>");
	out.println("<table border='1' width='100%'><tr class='important'><td style='font-size:8pt;background-color:#e9f2f7;' colspan='5' align='center'>Total Summary</td></tr>");
	out.println("<tr><td style='font-size:8pt;'>Configured</td><td style='font-size:8pt;' align='right'>"+for1.format(configured)+"</td><td style='font-size:8pt;'>&nbsp;</td><td style='font-size:8pt;'>Total Cost</td><td style='font-size:8pt;' align='right'>"+for1.format(totalcost)+"</td></tr>");
	out.println("<tr><td style='font-size:8pt;'>Drafting</td><td style='font-size:8pt;' align='right'>$"+globalDrafting+"</td><td style='font-size:8pt;'>&nbsp;</td><td style='font-size:8pt;'>&nbsp</td><td style='font-size:8pt;'>&nbsp;</td></tr>");
	out.println("<tr><td style='font-size:8pt;'>Layout</td><td style='font-size:8pt;' align='right'>$"+globalLayout+"</td><td style='font-size:8pt;'>&nbsp;</td><td style='font-size:8pt;'>Sell Price</td><td style='font-size:8pt;' align='right'>"+for1.format(sellprice)+"</td></tr>");
	out.println("<tr><td style='font-size:8pt;'>Proj Mgmt</td><td style='font-size:8pt;' align='right'>$"+globalProjectMgmt+"</td><td style='font-size:8pt;'>&nbsp;</td><td style='font-size:8pt;'>&nbsp</td><td style='font-size:8pt;'>&nbsp;</td></tr>");
	out.println("<tr><td style='font-size:8pt;'>Catchall</td><td style='font-size:8pt;' align='right'>$"+globalCatchall+"</td><td style='font-size:8pt;'>&nbsp;</td><td style='font-size:8pt;'>Margin%</td><td style='font-size:8pt;' align='right'>"+globalMargin+"%</td></tr>");
	out.println("<tr><td style='font-size:8pt;'>F&C</td><td style='font-size:8pt;' align='right'>$"+globalFreight+"</td><td style='font-size:8pt;'>&nbsp;</td><td style='font-size:8pt;'>&nbsp</td><td style='font-size:8pt;'>&nbsp;</td></tr>");
	out.println("<tr><td style='font-size:8pt;'>Comm</td><td style='font-size:8pt;' align='right'>$"+globalCommissionDollar+"</td><td style='font-size:8pt;'>&nbsp;</td><td style='font-size:8pt;'>Comm%</td><td style='font-size:8pt;' align='right'>"+globalCommission+"%</td></tr>");
	out.println("<tr><td style='font-size:8pt;'>Coord</td><td style='font-size:8pt;' align='right'>"+for1.format(globalCoordinationDollar)+"</td><td style='font-size:8pt;'>&nbsp;</td><td style='font-size:8pt;'>&nbsp</td><td style='font-size:8pt;'>&nbsp;</td></tr>");
	out.println("<tr><td style='font-size:8pt;'>Total Weight</td><td style='font-size:8pt;' align='right'>"+tot_weight+"</td><td style='font-size:8pt;'>&nbsp;</td><td style='font-size:8pt;'>Total Doors</td><td style='font-size:8pt;' align='right'>"+totalDoors+"</td></tr>");

	out.println("</table>");

}
else{
	out.println("Please rerun price calculator before viewing work copy");
}

String bpcs_tier="";
ResultSet rstier=stmt.executeQuery("select max(cast(bpcs_tier as numeric)) from csquotes where order_no='"+order_no+"' and not bpcs_tier is null");
if(rstier != null){
	while(rstier.next()){
		bpcs_tier=rstier.getString(1);
	}
}
rstier.close();
if(bpcs_tier==null){
	bpcs_tier="";
}
myConn.setAutoCommit(false);
try{
	java.sql.PreparedStatement ps=myConn.prepareStatement("UPDATE cs_project SET bpcs_tier =? WHERE Order_no =? ");
	ps.setString(1,bpcs_tier);
	ps.setString(2,order_no);
	int re=ps.executeUpdate();
	ps.close();
}
catch (java.sql.SQLException e){
	out.println("Problem with ENTERING Projects table to update tier info"+"<br>");
	out.println("Illegal Operation try again/Report Error"+"<br>");
	myConn.rollback();
	out.println(e.toString());
	return;
}
//}//updating tier info to cs_project table done
myConn.commit();


%>
</body>
</html>
