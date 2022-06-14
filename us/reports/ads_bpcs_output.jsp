<%


if(order_no != null && order_no.trim().length()== 9){
	String username="";
	//NumberFormat for1 = NumberFormat.getInstance();
	for1.setMaximumFractionDigits(2);
	for1.setMinimumFractionDigits(2);
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
	int totalDoors2=0;
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
	double configured=0;
	double totalcost=0;
	double sellprice=0;
	ResultSet rs1x=stmt.executeQuery("select * from cs_ads_price_calc where order_no='"+order_no+"' and model='GLOBAL'");
	if(rs1x != null){
		while(rs1x.next()){
			DESC=rs1x.getString("DESCRIPTION");
			ADD=rs1x.getString("ADDENDA");
			SECT=rs1x.getString("SECT");
			DATE=rs1x.getString("PLANDATE");
			CSDECO=rs1x.getString("CSDECO");
		}
	}
	rs1x.close();
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
			//block_idx.addElement(rsCSQUOTES.getString(1));
			model.addElement(rsCSQUOTES.getString(1));
			qty.addElement(rsCSQUOTES.getString(2));
			cost.addElement(rsCSQUOTES.getString(3));
			String temp="";
			if(CSDECO.equals("D")){
				temp="DECO";
			}
			else{
				temp="CS";
			}
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
			//ast2x.addElement(rs11.getString("ast"));
			double tempModelCost=0;
			tempModelCost=tempModelCost+new Double(rs11.getString("cost")).doubleValue();
			tempModelCost=tempModelCost+new Double(rs11.getString("catchall")).doubleValue();
			tempModelCost=tempModelCost+new Double(rs11.getString("drafting")).doubleValue();
			tempModelCost=tempModelCost+new Double(rs11.getString("layout")).doubleValue();
			tempModelCost=tempModelCost+new Double(rs11.getString("projectMgmt")).doubleValue();
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











	Vector line_no4=new Vector();
	Vector qty4=new Vector();
	Vector baseCost4=new Vector();
	Vector mark4=new Vector();
	Vector unitCost4=new Vector();
	Vector totCost4=new Vector();
	Vector unitSell4=new Vector();
	Vector totSell4=new Vector();
	Vector bpcsNo4=new Vector();
	Vector ast4=new Vector();



	if(readValue){

		double perc=0;
		for(int x=0; x<model.size(); x++){
			double temp=new Double(cost.elementAt(x).toString()).doubleValue()/costTotal;
			costPerc.addElement(""+temp);

		}


		Vector block_id3=new Vector();
		Vector line_no3=new Vector();
		Vector model3=new Vector();
		Vector qty3=new Vector();
		Vector cost3=new Vector();
		Vector mark3=new Vector();
		Vector bpcsNo3=new Vector();
		Vector ast3=new Vector();
		ResultSet rsCSQUOTES2=stmt.executeQuery("select block_id,field18,cast(field19 as integer), cast(extended_price as float),line_no,field17,bpcs_part_no,prod_code from csquotes where order_no='"+order_no+"' and not block_id ='A_APRODUCT' order by cast(line_no as integer),sequence_no,bpcs_part_no,field18 desc");
		if(rsCSQUOTES2 != null){
			while(rsCSQUOTES2.next()){
				block_id3.addElement(rsCSQUOTES2.getString(1));
				model3.addElement(rsCSQUOTES2.getString(2));
				qty3.addElement(rsCSQUOTES2.getString(3));
				cost3.addElement(rsCSQUOTES2.getString(4));
				line_no3.addElement(rsCSQUOTES2.getString(5));
				//out.println(rsCSQUOTES2.getString(7)+"::<BR>");
				mark3.addElement(rsCSQUOTES2.getString(6));
				bpcsNo3.addElement(rsCSQUOTES2.getString(7));
				if(rsCSQUOTES2.getString("prod_code") != null){
					ast3.addElement(rsCSQUOTES2.getString("prod_code"));
				}
				else{
					ast3.addElement("");
				}
				//out.println(rsCSQUOTES2.getString(4)+"::");
				//out.println(rsCSQUOTES2.getString("line_no")+"::"+rsCSQUOTES2.getString("block_id")+"::"+rsCSQUOTES2.getString("prod_code")+"::<BR>");
			}
		}
		rsCSQUOTES2.close();
		String oldLineNo="";
		String oldMark="";
		String oldQty="";
		String oldBpcs="";
		double oldBaseCost=0;
		double oldUnitCost=0;
		double oldTotCost=0;
		double oldUnitSell=0;
		double oldTotSell=0;
		String oldAst="";


		for(int i=0; i<line_no3.size(); i++){
			double percent=0;
			double costTemp=0;
			double sellTemp=0;
			double unitCostTemp=0;
			double unitSellTemp=0;
			String astTemp="";
			for(int j=0; j<model2.size(); j++){
				if(model2.elementAt(j).toString().equals(model3.elementAt(i).toString())){
					percent=new Double(cost3.elementAt(i).toString()).doubleValue()/new Double(cost2.elementAt(j).toString()).doubleValue();
					costTemp=percent*new Double(modelCost.elementAt(j).toString()).doubleValue();
					sellTemp=percent*new Double(linePrice.elementAt(j).toString()).doubleValue();
					unitCostTemp=costTemp/new Double(qty3.elementAt(i).toString()).doubleValue();
					unitSellTemp=sellTemp/new Double(qty3.elementAt(i).toString()).doubleValue();
					astTemp=ast3.elementAt(i).toString();

					//out.println(unitSellTemp+"::"+linePrice.elementAt(j).toString()+"::"+model2.elementAt(j).toString()+"::<BR>");
					//out.println(percent+"::"+ast3.elementAt(i).toString()+"::"+sellTemp+"::"+line_no3.elementAt(i).toString()+"::"+"::aa<BR><br>");
					j=model2.size();
				}
			}

			//out.println(ast3.elementAt(i).toString()+"::"+sellTemp+"::"+line_no3.elementAt(i).toString()+"::"+"::aa<Br>");
			if(i==0||!oldLineNo.equals(line_no3.elementAt(i).toString())||!oldBpcs.equals(bpcsNo3.elementAt(i).toString())||!oldAst.equals(ast3.elementAt(i).toString())){

				if(i>0){
					//out.println(oldQty+"::"+oldAst+"::"+oldBpcs+"::"+oldLineNo+"::a<BR>");
					bpcsNo4.addElement(""+oldBpcs);
					line_no4.addElement(""+oldLineNo);
					qty4.addElement(""+oldQty);
					mark4.addElement(""+oldMark);
					baseCost4.addElement(""+oldBaseCost);
					unitCost4.addElement(""+oldUnitCost);
					totCost4.addElement(""+oldTotCost);
					unitSell4.addElement(""+oldUnitSell);
					totSell4.addElement(""+oldTotSell);
					ast4.addElement(""+oldAst);

				}

				oldQty="";
				if(block_id3.elementAt(i).toString().equals("A_CORE")||oldQty.trim().length()<1){
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
				oldAst=astTemp;
				//out.println(oldTotSell+"::"+oldLineNo+"::"+oldAst+"::bb<BR>");

			}

			else{

				if(block_id3.elementAt(i).toString().equals("A_CORE")||oldQty.trim().length()<1){
					if(oldQty.trim().length()<1 || oldLineNo.equals(line_no3.elementAt(i).toString())){
						oldQty=""+Integer.parseInt(qty3.elementAt(i).toString());
					}
					else{
						//out.println(block_id3.elementAt(i).toString()+"::HERE"+oldQty+"::"+qty3.elementAt(i).toString()+"::<BR>");
						oldQty=""+(Integer.parseInt(oldQty)+Integer.parseInt(qty3.elementAt(i).toString()));
					}
				}
				oldBaseCost=oldBaseCost+new Double(cost3.elementAt(i).toString()).doubleValue();
				oldUnitCost=oldUnitCost+unitCostTemp;
				oldTotCost=oldTotCost+costTemp;
				oldUnitSell=oldUnitSell+unitSellTemp;
				oldTotSell=oldTotSell+sellTemp;
				oldAst=oldAst+astTemp;
			}

			if(i==line_no3.size()-1){
				//out.println(oldQty+"::"+oldAst+"::"+oldBpcs+"::"+oldLineNo+"::"+oldTotSell+"::<BR>");
				if(oldQty.trim().length()>0){
					bpcsNo4.addElement(oldBpcs);
					line_no4.addElement(oldLineNo);
					qty4.addElement(oldQty);
					mark4.addElement(oldMark);
					baseCost4.addElement(""+oldBaseCost);
					unitCost4.addElement(""+oldUnitCost);
					totCost4.addElement(""+oldTotCost);
					unitSell4.addElement(""+oldUnitSell);
					totSell4.addElement(""+oldTotSell);
					ast4.addElement(""+oldAst);
					//out.println(oldAst+"::"+oldLineNo+"::"+oldBpcs+"::"+oldTotSell+"::b<BR>");
				}
			}



		}


		//out.println("<BR><BR>");

		for(int i=0; i<line_no4.size(); i++){
			//out.println("::"+qty4.elementAt(i).toString()+"::<BR>");
			totalDoors=totalDoors+Integer.parseInt(qty4.elementAt(i).toString());
			configured=configured+new Double(baseCost4.elementAt(i).toString()).doubleValue();
			totalcost=totalcost+new Double(totCost4.elementAt(i).toString()).doubleValue();
			sellprice=sellprice+new Double(totSell4.elementAt(i).toString()).doubleValue();
		}
		out.println("</table>");


	}
	else{
		out.println("Please rerun price calculator before viewing work copy");
	}

	String[] rating = { "NR","AF","SC","20","S2","45","60","90","LL","AL","SL","L2","2L" };
	Vector line_no=new Vector();
	Vector abpcs=new Vector();
	Vector acore=new Vector();
	Vector ahgt=new Vector();
	Vector awid=new Vector();
	Vector cvr=new Vector();
	Vector aglass=new Vector();
	Vector alead=new Vector();
	Vector akp=new Vector();
	Vector ast=new Vector();
	Vector door_no=new Vector();
	Vector aqty=new Vector();
	Vector line_no2=new Vector();
	Vector abpcs2=new Vector();
	Vector acore2=new Vector();
	Vector ahgt2=new Vector();
	Vector awid2=new Vector();
	Vector cvr2=new Vector();
	Vector aglass2=new Vector();
	Vector alead2=new Vector();
	Vector akp2=new Vector();
	Vector ast2=new Vector();
	Vector door_no2=new Vector();
	Vector aqty2=new Vector();
	Vector aprice=new Vector();
	Vector aunitPrice=new Vector();
	Vector active=new Vector();
	try{
		//ResultSet rs111=stmt.executeQuery("select * from cs_ads_order_entry where quote_no='"+order_no+"' order by acore,ahgt,awid,cvr,aglass,alead,akp,ast,line_no");
		ResultSet rs111=stmt.executeQuery("select * from cs_ads_order_entry where quote_no='"+order_no+"' and not abpcs is null and not abpcs = '' order by rating_level desc, color,replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(type,'NR','00'),'SC','01'),'AC','02'),'FL','03'),'20','04'),'A2','05'),'S2','06'),'2F','07'),'45','08'),'60','09'),'90','10'),'LL','11'),'SL','12'),'AL','13'),'FL','14'),'L2','15'),'S2','16'),'2F','17'),doorsize,ml,lk,kpn,acore,ahgt,awid,cvr,aglass,alead,akp,ast,line_no");
		if(rs111 != null){
			while(rs111.next()){
				line_no2.addElement(rs111.getString("line_no"));
				abpcs2.addElement(rs111.getString("abpcs"));
				boolean found=false;
				for(int i=0; i<13; i++){
					if(rs111.getString("acore").trim().substring(0,2).equals(rating[i])){
						acore2.addElement(""+(i+1)+rs111.getString("abpcs"));
						found=true;
					}
				}
				if(!found){
					acore2.addElement("1"+rs111.getString("acore")+rs111.getString("abpcs"));
				}
				ahgt2.addElement(rs111.getString("ahgt"));
				awid2.addElement(rs111.getString("awid"));
				cvr2.addElement(rs111.getString("cvr"));
				aglass2.addElement(rs111.getString("aglass"));
				alead2.addElement(rs111.getString("alead"));
				akp2.addElement(rs111.getString("akp"));
				ast2.addElement(rs111.getString("ast"));
				active.addElement(rs111.getString("active"));
				if(rs111.getString("door_no")!=null){
					door_no2.addElement(rs111.getString("door_no"));
				}
				else{
					door_no2.addElement("");
				}
				aqty2.addElement(rs111.getString("qty"));
				boolean priceFound=false;
				double tempUnit=0;
				double tempPrice=0;
				double tempQty=0;
				for(int h=0; h<line_no4.size(); h++){
					if(line_no4.elementAt(h).toString().trim().equals(rs111.getString("line_no"))){
						if(bpcsNo4.elementAt(h).toString().startsWith(rs111.getString("abpcs"))){
							if((ast4.elementAt(h).toString().trim().length()==rs111.getString("ast").trim().length())||(ast4.elementAt(h).toString().length()>0 &&rs111.getString("ast").trim().length()>0)){

								//out.println(bpcsNo4.elementAt(h).toString()+"::"+tempPrice+"::"+totSell4.elementAt(h).toString()+"::<BR>");
								tempPrice=new Double(totSell4.elementAt(h).toString()).doubleValue()+tempPrice;
								tempQty=tempQty+new Double(qty4.elementAt(h).toString()).doubleValue();
								priceFound=true;
							}
						}
					}
				}
				//out.println("END<BR><BR><BR>");
				if(priceFound){
					tempUnit=tempPrice/tempQty;
					aprice.addElement(""+tempPrice);
					aunitPrice.addElement(""+tempUnit);
					//out.println(rs111.getString("abpcs")+"::"+rs111.getString("line_no")+"::"+tempPrice+"::<BR>");
				}
				else{
					aprice.addElement("0");
					aunitPrice.addElement("0");
				}
			}
		}
		rs111.close();
		//out.println("<BR><BR><BR><BR>");
	}
	catch(Exception e){
		out.println("error pulling info from cs_ads_order_entry::<BR>"+e);
	}

	out.println("<table border='1' width='100%'>");
	out.println("<tr ><td bgcolor='#e9f2f7'>BPCS Line #</td><td bgcolor='#e9f2f7'>BPCS Item</td><td bgcolor='#e9f2f7'>Qty</td><td bgcolor='#e9f2f7'>Unit Sell</td>	<td bgcolor='red'>manual calc</td><td bgcolor='#e9f2f7'>Total Sell</td><td bgcolor='#e9f2f7'>Lead Line Thickness</td><td bgcolor='#e9f2f7'>CVR</td>	<td bgcolor='#e9f2f7'>Astragal by CS</td><td bgcolor='#e9f2f7'>Kick Plate</td><td bgcolor='#e9f2f7'>Glass by CS</td><td bgcolor='#e9f2f7'>Door Number(s)	</td><td bgcolor='#e9f2f7'>Erapid Line(s)</td></tr>");
	int bpcsLine=1;
	double sumx=0;
	for(int i=0; i<abpcs2.size(); i++){
		//out.println(abpcs2.elementAt(i).toString()+"::"+ast2.elementAt(i).toString()+aprice.elementAt(i).toString()+"<BR>");

		boolean view=true;
		if(i<abpcs2.size()-1){
			if(abpcs2.elementAt(i).toString().equals(abpcs2.elementAt(i+1).toString()) && ahgt2.elementAt(i).toString().equals(ahgt2.elementAt(i+1).toString()) && awid2.elementAt(i).toString().equals(awid2.elementAt(i+1).toString()) && cvr2.elementAt(i).toString().equals(cvr2.elementAt(i+1).toString()) && aglass2.elementAt(i).toString().equals(aglass2.elementAt(i+1).toString()) && alead2.elementAt(i).toString().equals(alead2.elementAt(i+1).toString()) && akp2.elementAt(i).toString().equals(akp2.elementAt(i+1).toString()) && ast2.elementAt(i).toString().equals(ast2.elementAt(i+1).toString())){
				//out.println(abpcs2.elementAt(i).toString()+"::"+ast2.elementAt(i).toString()+"<BR>");
				view=false;
				door_no2.setElementAt(door_no2.elementAt(i).toString()+door_no2.elementAt(i+1).toString(),i+1);
				aqty2.setElementAt(""+(Integer.parseInt(aqty2.elementAt(i).toString().trim())+Integer.parseInt(aqty2.elementAt(i+1).toString().trim())),i+1);
				if(!line_no2.elementAt(i).equals(line_no2.elementAt(i+1))&&!line_no2.elementAt(i).toString().endsWith(","+line_no2.elementAt(i+1).toString())){

					double temp1=new Double(aprice.elementAt(i).toString()).doubleValue()+new Double(aprice.elementAt(i+1).toString()).doubleValue();
					double tempUnit=temp1/(new Double(aqty2.elementAt(i+1).toString().trim()).doubleValue());
					aunitPrice.setElementAt(""+tempUnit,i+1);
					//out.println("herexx");
					aprice.setElementAt(""+temp1,i+1);
					//out.println((i+1)+"::"+temp1+"::1<BR>");
				}
				else{
					double temp1=new Double(aprice.elementAt(i).toString()).doubleValue();
					double tempUnit=temp1/(new Double(aqty2.elementAt(i+1).toString().trim()).doubleValue());
					aunitPrice.setElementAt(""+tempUnit,i+1);

					//out.println(abpcs2.elementAt(i).toString()+"HEREx");
					aprice.setElementAt(""+temp1,i+1);
					//out.println(temp1+"::2<BR>");
				}
				line_no2.setElementAt(line_no2.elementAt(i).toString().trim()+","+line_no2.elementAt(i+1).toString(),i+1);
			}
		}
		//out.println("<BR>");
		if(view){

			out.println("<tr>");
			out.println("<td width='5%'>"+bpcsLine+"</td>");

			totalDoors2=totalDoors2+Integer.parseInt(aqty2.elementAt(i).toString());


			out.println("<td width='10%' >"+abpcs2.elementAt(i).toString()+"&nbsp;</td>");
			out.println("<td width='5%' >"+aqty2.elementAt(i).toString()+"&nbsp;</td>");
			out.println("<td width='8%' >"+for1.format(new Double(aunitPrice.elementAt(i).toString()).doubleValue())+"&nbsp;</td>");
//out.println("1");
			String price1=for1.format(new Double(aprice.elementAt(i).toString()).doubleValue()).trim();
//out.println("2");
			String price2=for1.format(new Double(aunitPrice.elementAt(i).toString()).doubleValue()*new Double(aqty2.elementAt(i).toString()).doubleValue());
//out.println("3"+door_no2.elementAt(i).toString());
			//out.println(active.elementAt(i).toString()+"::<BR>");
			String doornametemp=door_no2.elementAt(i).toString();
//out.println("4");
			if(price1.equals(price2)){
				out.println("<td width='8%'>a"+for1.format(new Double(aunitPrice.elementAt(i).toString()).doubleValue()*new Double(aqty2.elementAt(i).toString()).doubleValue())+"</td>");
			}
			else{
				out.println("<td width='8%'><font color='red'>b"+for1.format(new Double(aunitPrice.elementAt(i).toString()).doubleValue()*new Double(aqty2.elementAt(i).toString()).doubleValue())+"</font></td>");
			}
			//out.println(alead2.elementAt(i).toString()+"::"+door_no2.elementAt(i).toString()+"::<BR>");
			//sumx=sumx+new Double(aunitPrice.elementAt(i).toString()).doubleValue()*new Double(aqty2.elementAt(i).toString()).doubleValue();
			out.println("<td width='8%' >"+for1.format(new Double(aprice.elementAt(i).toString()).doubleValue())+"&nbsp;</td>");
			out.println("<td width='8%' >"+alead2.elementAt(i).toString()+"&nbsp;</td>");
			out.println("<td width='8%' >"+cvr2.elementAt(i).toString()+"&nbsp;</td>");
			out.println("<td width='8%' >"+ast2.elementAt(i).toString()+"&nbsp;</td>");
			out.println("<td width='8%' >"+akp2.elementAt(i).toString()+"&nbsp;</td>");
			out.println("<td width='10%' >"+aglass2.elementAt(i).toString()+"&nbsp;</td>");
			out.println("<td width='12%' >"+doornametemp+"&nbsp;</td>");
			out.println("<td width='10%' >"+line_no2.elementAt(i).toString()+"&nbsp;</td>");
			out.println("</tr>");
			bpcsLine++;
		}

	}
	out.println("</table>");
	out.println("<table border='1' width='100%'><tr class='important'><td  colspan='5' align='center' bgcolor='#e9f2f7'>Total Summary</td></tr>");
	out.println("<tr><td class='noheader'>Configured</td><td class='noheader' align='right'>"+for1.format(configured)+"</td><td class='noheader'>&nbsp;</td><td class='noheader'>Total Cost</td><td class='noheader' align='right'>"+for1.format(totalcost)+"</td></tr>");
	out.println("<tr><td class='noheader'>Drafting</td><td class='noheader' align='right'>$"+globalDrafting+"</td><td class='noheader'>&nbsp;</td><td class='noheader'>&nbsp</td><td class='noheader'>&nbsp;</td></tr>");
	out.println("<tr><td class='noheader'>Layout</td><td class='noheader' align='right'>$"+globalLayout+"</td><td class='noheader'>&nbsp;</td><td class='noheader'>Sell Price</td><td class='noheader' align='right'>"+for1.format(sellprice)+"</td></tr>");
	out.println("<tr><td class='noheader'>Proj Mgmt</td><td class='noheader' align='right'>$"+globalProjectMgmt+"</td><td class='noheader'>&nbsp;</td><td class='noheader'>&nbsp</td><td class='noheader'>&nbsp;</td></tr>");
	out.println("<tr><td class='noheader'>Catchall</td><td class='noheader' align='right'>$"+globalCatchall+"</td><td class='noheader'>&nbsp;</td><td class='noheader'>Margin%</td><td class='noheader' align='right'>"+globalMargin+"%</td></tr>");
	out.println("<tr><td class='noheader'>F&C</td><td class='noheader' align='right'>$"+globalFreight+"</td><td class='noheader'>&nbsp;</td><td class='noheader'>&nbsp</td><td class='noheader'>&nbsp;</td></tr>");
	out.println("<tr><td class='noheader'>Comm</td><td class='noheader' align='right'>$"+globalCommissionDollar+"</td><td class='noheader'>&nbsp;</td><td class='noheader'>Comm%</td><td class='noheader' align='right'>"+globalCommission+"%</td></tr>");
	out.println("<tr><td class='noheader'>Coord</td><td class='noheader' align='right'>"+for1.format(globalCoordinationDollar)+"</td><td class='noheader'>&nbsp;</td><td class='noheader'>&nbsp</td><td class='noheader'>&nbsp;</td></tr>");
	out.println("<tr><td class='noheader'>Total Weight</td><td class='noheader' align='right'>"+tot_weight+"</td><td class='noheader'>&nbsp;</td><td class='noheader'>Total Doors</td><td class='noheader' align='right'>"+totalDoors2+"</td></tr>");
	out.println("</table>");

}
else{
	out.println("Invalid order number");
}

%>















<%




%>
</body>
</html>













