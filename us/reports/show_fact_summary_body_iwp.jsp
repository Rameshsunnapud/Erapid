
<%
//out.println("HERE");
boolean isSecOverage=false;boolean isSecSetup=false; boolean isSecHandling=false; boolean isSecFreight=false;
String tempseclines="";
String foot_handling_cost=handling_cost;

String foot_overage=overage;
String foot_setup_cost=setup_cost;
String foot_freight_cost=freight_cost;
handling_cost="0";

overage="0";
setup_cost="0";
freight_cost="0";
String itemsLines="";
for(int n=0; n<items.size(); n++){
	itemsLines=itemsLines+items.elementAt(n).toString()+",";
}
itemsLines=itemsLines.substring(0,itemsLines.length()-1);
sec_lines=itemsLines;
String xPriceTot="0";
//out.println("select sum(cast(extended_price as decimal)) from csquotes where order_no'"+order_no+"' and line_no in ("+itemsLines+")");
// used to get the total extended price of lines used
ResultSet xPrice=stmt.executeQuery("select extended_price as numeric from csquotes where order_no='"+order_no+"' and line_no in ("+itemsLines+") and (deduct is null or deduct='add' or deduct='') ");
if(xPrice != null){
		while(xPrice.next()){
			xPriceTot=""+(new Double(xPriceTot).doubleValue()+new Double(xPrice.getString(1)).doubleValue());
			//out.println(xPriceTot+"<br>");
		}
}
xPrice.close();
ResultSet xPrice2=stmt.executeQuery("select extended_price as numeric from csquotes where order_no='"+order_no+"' and line_no in ("+itemsLines+") and (  deduct='deduct') ");
if(xPrice2 != null){
		while(xPrice2.next()){
			xPriceTot=""+(new Double(xPriceTot).doubleValue()-new Double(xPrice2.getString(1)).doubleValue());
			//out.println(xPriceTot+"<br>");
		}
}
xPrice2.close();
//out.println(xPriceTot+"::<BR>");
//xPriceTot=""+Math.ceil(new Double(xPriceTot).doubleValue());
//out.println(xPriceTot+"::<BR>");
boolean isSections=false;
// sets a boolean to true if sections are used
ResultSet quoteSizeRs=stmt.executeQuery("select count(*) from cs_quote_sections where order_no='"+order_no+"' and (not sections is null and not sections='1' and not sections='0')");
if(quoteSizeRs != null){
	while(quoteSizeRs.next()){
		//out.println(quoteSizeRs.getString(1));
		if((new Double(quoteSizeRs.getString(1)).doubleValue())>0){
			isSections=true;
		}
	}
}
//out.println(isSections+"::<BR>");
quoteSizeRs.close();
double priceFromLine=0;
double totalpricex=0;
double totalOverage=0;
int numSections=0;
String sections="";
String sectionNames[];
String nameSection="";
String sectionsForBadder="";
String freeText="";
String qualNotes="";
String exclNotes="";
String secOverage="";
String secHandling="";
String secSetup="";
String secFreight="";

//out.println(isSections);
// if sections are used then it will query the db and get the values from the table based on that quote
if(isSections){
	ResultSet quoteRs=stmt.executeQuery("Select * from cs_quote_sections where order_no='"+order_no+"'  and (not sections is null and not sections='1' and not sections='0')");
	if(quoteRs != null){
		while(quoteRs.next()){
			//out.println(quoteRs.getString("section_info")+"<br>");
			//out.println(quoteRs.getString("section_group")+"<br>");
			secOverage=quoteRs.getString("overage");
			secHandling=quoteRs.getString("handling_cost");
			secSetup=quoteRs.getString("setup_cost");
			secFreight=quoteRs.getString("freight_cost");
			sections=quoteRs.getString("section_group");
			sectionsForBadder=quoteRs.getString("section_group");
//out.println("::"+quoteRs.getInt("sections")+"::<BR>");
			numSections=quoteRs.getInt("sections");
			//numSections=0;
			//numSections=quoteRs.getInt("sections");
//			numSections=(int)(new Double(quoteRs.getString("sections").trim()).doubleValue());

			nameSection=quoteRs.getString("section_info");
			if(quoteRs.getString("section_notes") != null && quoteRs.getString("section_notes").trim().length() > 0){
				freeText=quoteRs.getString("section_notes");
			}
			if(quoteRs.getString("section_qual") != null && quoteRs.getString("section_qual").trim().length() > 0){
				qualNotes=quoteRs.getString("section_qual");
			}
			if(quoteRs.getString("section_excl") != null && quoteRs.getString("section_excl").trim().length() > 0){
				exclNotes=quoteRs.getString("section_excl");
			}

			//out.println(numSections+"number of sections <br>");
		}
	}
	quoteRs.close();
	if(numSections <1){
		numSections=1;
		nameSection="";
		sections="";
		for(int y=0; y<line; y++){
			sections=sections+items.elementAt(y).toString().trim()+"=s1;";
		}
	}
}

// if sections aren't used then we will recreate the sections_group details using the line numbers from eorder items
// this is done, to make the program work the same the rest of the way in

else{
	numSections=1;
	nameSection="";
	sections="";
	for(int y=0; y<line; y++){
		//actually recreating the string that is pulled from the sections table
		sections=sections+items.elementAt(y).toString().trim()+"=s1;";
		//out.println(sections);
	}
}
//out.println(freeText+"::"+qualNotes+"::"+exclNotes+"<BR>");

Vector section = new Vector();
int sectionCount=0;
String sectionx="";
int semiIndex=0;
String sectionsArray[] = new String[numSections];
int sectionsCountArray[]=new int[numSections];
String sectionsNameArray[] = new String[numSections];
String freeSections[] = new String[numSections];
String qualSections[] = new String[numSections];
String exclSections[] = new String[numSections];
String overageSec[] =  new String[numSections];
String setupSec[]=  new String[numSections];
String handlingSec[]=  new String[numSections];
String freightSec[]=  new String[numSections];
// sets the arrays to blank (just removing the null)
int start=0;
int end=0;

for(int j=0; j<numSections; j++){
	sectionsArray[j]="";
	sectionsCountArray[j]=0;
	sectionsNameArray[j]="";
	//out.println(j);
}

// used sectioncount as a counter, used 100 just as a precaution (no infinite loops then)
while(sectionCount < 500){
	// look for the next occurance of semi colon as this is the delimiter between feilds
	semiIndex=sections.indexOf(";");
	if(semiIndex > 0){
		// cuts the sections apart first part is the one we are going to work with
		// the second part is what remains of the string when we cut the first event out of it
		sectionx=sections.substring(0,semiIndex);
		//out.println(sectionx+" sectionx<br>");
		sections=sections.substring(semiIndex+1);
		//out.println(sections);
		semiIndex=sectionx.indexOf("=");

		if(semiIndex>0){
			// pulling the line value out of the event we cut out of string (reduced by one to match
			// array index
			int r=(int)(new Double(sectionx.substring(semiIndex+2)).doubleValue());
			r=r-1;
			//out.println(r);
			// creating a string for all the elements in this section
			sectionsArray[r]=""+sectionsArray[r]+sectionx.substring(0,semiIndex)+",";

			sectionsCountArray[r]=sectionsCountArray[r]+1;
			//out.println(sectionsArray[r]+"::"+r+"::"+sectionsCountArray[r]+":<BR>");
		}
	}
	else{
		// if the string is now empty then just set sectioncount to zero to exit while loop
		sectionCount=500;
	}
	sectionCount++;
	semiIndex=0;
}


// used to cut the name sections apart
int startx=0;
int endx=0;
sectionCount=0;
while(sectionCount <1000){

	startx=nameSection.indexOf("=");
	endx=nameSection.indexOf(";");
	if(startx>0 && endx>startx){
		int v=(int)(new Double(nameSection.substring(1,startx)).doubleValue())-1;

		sectionsNameArray[v]=nameSection.substring(startx+1,endx);
		if(nameSection.length()>endx+1){
			nameSection=nameSection.substring(endx+1);
		}
		else{
			sectionCount=1000;
		}

	}
	else{
		sectionCount=1000;
	}

	startx=0;
	endx=0;

	sectionCount++;

}

startx=0;
endx=0;
sectionCount=0;

while(numSections>1 && sectionCount <1000){

	startx=freeText.indexOf("=");
	endx=freeText.indexOf(";");

	if(startx>0 && endx>startx){
		int v=(int)(new Double(freeText.substring(1,startx)).doubleValue())-1;

				freeSections[v]=freeText.substring(startx+1,endx);
		if(freeText.length()>endx+1){
			freeText=freeText.substring(endx+1);
		}
		else{
			sectionCount=1000;
		}

	}
	else{
		sectionCount=1000;
	}


	startx=0;
	endx=0;

	sectionCount++;


}


startx=0;
endx=0;
sectionCount=0;
while(numSections>1&&sectionCount <1000){

	startx=qualNotes.indexOf("=");
	endx=qualNotes.indexOf(";");
	if(startx>0 && endx>startx){
		int v=(int)(new Double(qualNotes.substring(1,startx)).doubleValue())-1;

				qualSections[v]=qualNotes.substring(startx+1,endx);
		if(qualNotes.length()>endx+1){
			qualNotes=qualNotes.substring(endx+1);
		}
		else{
			sectionCount=1000;
		}
		if(qualSections[v].trim().length() > 0){
			ResultSet rsQual=stmt.executeQuery("select description FROM cs_qlf_notes where product_id ='"+product+"' and code in ("+qualSections[v]+")");
			qualSections[v]="";
			//out.println("here<BR>");
			if(rsQual != null){
				while(rsQual.next()){
					//out.println(rsQual.getString(1)+" inside<BR>");
					qualSections[v]=qualSections[v]+rsQual.getString(1)+"<BR>";
				}
			}
			rsQual.close();
		}

	}
	else{
		sectionCount=1000;
	}

	startx=0;
	endx=0;

	sectionCount++;

}

startx=0;
endx=0;
sectionCount=0;
while(numSections>1&&sectionCount <1000){

	startx=exclNotes.indexOf("=");
	endx=exclNotes.indexOf(";");
	if(startx>0 && endx>startx){
		int v=(int)(new Double(exclNotes.substring(1,startx)).doubleValue())-1;

		exclSections[v]=exclNotes.substring(startx+1,endx);
		if(exclNotes.length()>endx+1){
			exclNotes=exclNotes.substring(endx+1);
		}
		else{
			sectionCount=1000;
		}
		if(exclSections[v].trim().length() > 0){
			ResultSet rsExcl=stmt.executeQuery("select description FROM cs_exc_notes where product_id ='"+product+"' and code in ("+exclSections[v]+")");
			exclSections[v]="";
			if(rsExcl != null){
				while(rsExcl.next()){
					exclSections[v]=exclSections[v]+rsExcl.getString(1)+"<BR>";
				}
			}
			rsExcl.close();
		}
	}
	else{
		sectionCount=1000;
	}

	startx=0;
	endx=0;

	sectionCount++;

}

if(secOverage == null){
	secOverage="";
}
if(secHandling == null){
	secHandling="";
}
if(secSetup == null){
	secSetup="";
}
if(secFreight == null){
	secFreight="";
}

//out.println(numSections+ ":: <BR>");
for(int test=1; test<=numSections; test++){
	String secTemp="s"+test+"=";
	int startSec=secOverage.indexOf(secTemp);
	String overTemp="";
	if(startSec>=0){
		int endSec=secOverage.substring(startSec).indexOf(";");
		if(endSec>=0){
			overTemp=secOverage.substring(startSec+secTemp.length(),endSec+startSec);
		}
	}
	if(overTemp != null && overTemp.trim().length()>0){
		overageSec[test-1]=overTemp;
		isSecOverage=true;
	}
	else{
		overageSec[test-1]="";
	}
	startSec=secHandling.indexOf(secTemp);
	overTemp="";
	if(startSec>=0){
		int endSec=secHandling.substring(startSec).indexOf(";");
		if(endSec>=0){
			overTemp=secHandling.substring(startSec+secTemp.length(),endSec+startSec);
		}
	}
	if(overTemp != null && overTemp.trim().length()>0){
		handlingSec[test-1]=overTemp;
		isSecHandling=true;
	}
	else{
		handlingSec[test-1]="";
	}
	startSec=secSetup.indexOf(secTemp);
	overTemp="";
	if(startSec>=0){
		int endSec=secSetup.substring(startSec).indexOf(";");
		if(endSec>=0){
			overTemp=secSetup.substring(startSec+secTemp.length(),endSec+startSec);
		}
	}
	if(overTemp != null && overTemp.trim().length()>0){
		setupSec[test-1]=overTemp;
		isSecSetup=true;
	}
	else{
		setupSec[test-1]="";
	}
	startSec=secFreight.indexOf(secTemp);
	overTemp="";
	if(startSec>=0){
		int endSec=secFreight.substring(startSec).indexOf(";");
		if(endSec>=0){
			overTemp=secFreight.substring(startSec+secTemp.length(),endSec+startSec);
		}
	}
	if(overTemp != null && overTemp.trim().length()>0){
		freightSec[test-1]=overTemp;
		isSecFreight=true;
		//out.println(isSecFreight+"::");
	}
	else{
		freightSec[test-1]="";
	}
	//out.println(overageSec[test-1]+"::"+handlingSec[test-1]+"::"+setupSec[test-1]+"::"+freightSec[test-1]+"<BR>");
}


	String freightTemp="";
	String setupTemp="";
	String handlingTemp="";
	String overageTemp="";

String discount_show="";
String xLine="";
double freightx=0;
String line_no="";
for(int ww=0; ww<numSections; ww++){
	double h=0;
	totprice_dis=0;
	factor=0;//totprice=0;
	discount_show=""; cost_line="0";
	totprice=0;
	totcomm_dol=0;
	tot_cost=0;
	tot_weight=0;
	//out.println("it gets here1");

	if(sectionsArray[ww] != null && sectionsArray[ww].trim().length()>0){
		//out.println(sectionsArray[ww]+"::<BR>":);

%>
<font class='mainbodyh'><B>QUOTE SUMMARY FOR SECTION <%= sectionsNameArray[ww] %>::</B><br><br></font>
<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'>
	<tr height='20'>
		<td width='4%' bgcolor='#006600'><font class='schedule'></font></td>
		<td width='13%' bgcolor='#006600'><font class='schedule'><b>Model</b></font></td>
		<td width='6%' bgcolor='#006600'><font class='schedule'><b>Code</b></font></td>
		<td width='4%' bgcolor='#006600' align='right'><font class='schedule'><b>Qty</b></font></td>
		<td width='4%' bgcolor='#006600'><font class='schedule'><b>UOM</b></font></td>
		<td width='10%' bgcolor='#006600' align='center'><font class='schedule'><b>LVL/DISC</b></font></td>
		<td width='7%' bgcolor='#006600'><font class='schedule'><b>Mark-up</b></font></td>
		<td width='6%' bgcolor='#006600' align='right'><font class='schedule'><b>Comm(%)</b></font></td>
		<td width='3%' bgcolor='#006600' align='right'><font class='schedule'><b>Esc</b></font></td>
		<td width='8%' bgcolor='#006600' align='right'><font class='schedule'><b>Unit Sell</b></font></td>
		<td width='8%' bgcolor='#006600' align='right'><font class='schedule'><b>Total Sell</b></font></td>
		<td width='8%' bgcolor='#006600' align='right'><font class='schedule'><b>Unit Cost</b></font></td>
		<td width='8%' bgcolor='#006600' align='right'><font class='schedule'><b>Total Cost</b></font></td>
		<td width='10%' bgcolor='#006600' align='center'><font class='schedule'><b>BPCS Part</b></font></td>
		<td width='8%' bgcolor='#006600' align='right'><font class='schedule'><b>Weight</b></font></td>
		<td width='8%' bgcolor='#006600' align='right'><font class='schedule'><b>Tier</b></font></td>
	</tr>
	<%
	int newIndex=0;

	//out.println(query_string);
	int numCode=4;
	//String discount_show="";
	String prod_code;
	double costFromString=0;
	String prodCode[]=new String[1000];
	double prodCost[]=new double[1000];
	double prodSell[]=new double[1000];
	double prodProfit[]=new double[1000];
	double prodGp[]=new double[1000];
	double prodComm[]=new double[1000];
	double qType=0;
	for(int g=0; g<1000; g++){
		prodCode[g]="";
		prodCost[g]=0;
		prodSell[g]=0;
		prodProfit[g]=0;
		prodGp[g]=0;
		prodComm[g]=0;
	}

	// this is used to populate a vector for iwp.  This vector is used to print the line items in the correct order based on prod_code
	Vector sorted =  new Vector();
	int w=0;
	while(w<line_item.size()){
		if(w==0){
			sorted.addElement(line_item.elementAt(w).toString());
		}
		else{
			if(line_item.elementAt(w).toString().equals(sorted.elementAt(sorted.size()-1).toString())){
			}
			else{
				sorted.addElement(line_item.elementAt(w));
			}
		}
	w++;
	}
	//out.println("P :: " + prio+"<br><br>");

	if(prio.equals("C")){
		qType=0.91;
	}
	else{
		qType=1;
	}

	int codeCount=1;
	int a=0;
	int greg=0;
	double moldCost=0;
	double moldPrice=0;
	String bpcs_tier="";
	for(int k=0;k<line;k++){
		boolean isGood=false;

		String sectionTemp=sectionsArray[ww];
		//out.println(sectionTemp+" sectiontemp<BR>");

		int testing=0;
		while(!isGood && testing < 1000){
			int hg=sectionTemp.indexOf(",");
			if(hg>0){
				if(sectionTemp.substring(0,hg).equals(sorted.elementAt(k).toString())){
					isGood=true;
				}
				//out.println(sectionTemp.substring(0,hg)+"::"+hg+"<BR>");
				//out.println(sectionTemp.substring(hg+1)+" after<BR>");
				sectionTemp=sectionTemp.substring(hg+1);
			}
			testing++;
		}
		if(!isGood){
			prodProfit[codeCount]=prodSell[codeCount]-prodCost[codeCount];
			//out.println(prodProfit+" product profit<BR>");
			if(prodSell[codeCount]>0){
				prodGp[codeCount]=(prodProfit[codeCount]/prodSell[codeCount])*100;
				BigDecimal bd=new BigDecimal(prodGp[codeCount]);
				bd=bd.setScale(2,BigDecimal.ROUND_UP);
				prodGp[codeCount]=bd.doubleValue();
			}
		}
		if(isGood){
			int k1=Integer.parseInt(sorted.elementAt(k).toString())-1;
			for(int p=0; p<items.size();p++){
				if(items.elementAt(p).toString().trim().equals(sorted.elementAt(k).toString().trim())){
					newIndex=p;
				}
			}
			prod_code="";
			String bgcolor="";
			boolean isDeduct=false;
			if ((k%2)==1){bgcolor="#e4e4e4";}else {bgcolor="#EFEFDE";}

			String config_s0 = config_string.elementAt(newIndex).toString();//CONFIG STRING
			//Getting the Weight
			 start=0;
			int start2=0;
			end=0;
			int end2=0;
			//int fp=config_s0.indexOf("fp");
			start=config_s0.indexOf("CALC/");
			int fpcalc=config_s0.indexOf("FPCALC/");
			if(start==fpcalc+2){
				start=config_s0.indexOf("CALC/",start+2);
			}
			end=config_s0.indexOf("&",start);
			if(start>0 && end>start){
				costFromString=0;
			}
			else{
				costFromString=100;
			}


			weight="0";

			for (int mn=0;mn<line_item.size();mn++){


				if ((line_item.elementAt(mn).toString()).equals((items.elementAt(newIndex).toString()))){
					if(deduct.elementAt(mn).toString().equals("deduct")){
						isDeduct=true;
					}
					else{
						isDeduct=false;
					}

					if ((block_id.elementAt(mn).toString()).equals("A_APRODUCT")){
						//out.println(items.elementAt(newIndex).toString()+":<BR>");
						tempseclines=tempseclines+items.elementAt(newIndex).toString()+",";
						line_no=line_item.elementAt(mn).toString();
						description=(desc.elementAt(mn)).toString();
						mark=(mark_no.elementAt(mn)).toString();
						if (!(discount.elementAt(mn)==null)){
							discount_show="B"+discount.elementAt(mn).toString().trim();//FIELD19
						}
						else{
							discount_show="";
						}
						// Mark up
						if (lgth.elementAt(mn)==null){mark_up="";}else{mark_up=lgth.elementAt(mn).toString();}
						if (wdth.elementAt(mn)==null){comm_perct="";}else{comm_perct=wdth.elementAt(mn).toString();}
						if (color.elementAt(mn)==null){esc="";}else{esc=color.elementAt(mn).toString();}
						if (bpcs_part_no.elementAt(mn)==null){part_no="";}else{part_no=bpcs_part_no.elementAt(mn).toString();}
						bpcs_tier=tiercsquotes.elementAt(mn).toString();

					}//if it is a a_aproduct





					if( !((block_id.elementAt(mn).toString()).equals("A_APRODUCT")))	{

						//out.println(block_id.elementAt(mn).toString()+"< blockid<Br>");
						if((block_id.elementAt(mn).toString()).equals("B_CHARGES_HR")||(block_id.elementAt(mn).toString()).equals("B_CHARGES_CR")||(block_id.elementAt(mn).toString()).equals("B_CHARGES_BG")||(block_id.elementAt(mn).toString()).equals("B_CHARGES")||(block_id.elementAt(mn).toString()).equals("B_CHARGES_DP")){
							if((new Double(price.elementAt(mn).toString()).doubleValue())>0){

								String qtyMold="0";
								if(field20.elementAt(mn)==null||field20.elementAt(mn).toString().trim().length()<1){
									qtyMold="1";
								}
								else{
									qtyMold=field20.elementAt(mn).toString();
								}
								out.println("1<BR>");
								if(isDeduct){
									prodCost[codeCount]=prodCost[codeCount]-(new Double(price.elementAt(mn).toString()).doubleValue());
								}
								else{
									prodCost[codeCount]=prodCost[codeCount]+(new Double(price.elementAt(mn).toString()).doubleValue());
								}
								out.println("<TR>");
								out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+line_item.elementAt(mn).toString()+"</TD>");
								out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+desc.elementAt(mn).toString()+"</TD>");
								if(codes.elementAt(mn)==null){prod_code="0";}else{prod_code=codes.elementAt(mn).toString();}
								start=0;
								end=0;
								end=prod_code.indexOf(".",start);
								if(end>start){
									prod_code=prod_code.substring(start,end);
								}
								out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+prod_code+"</TD>");
								out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+qtyMold+"</TD>");
								out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+bpcs_um.elementAt(mn).toString()+"</TD>");
								out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+discount.elementAt(mn).toString()+"</TD>");
								out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+lgth.elementAt(mn).toString()+"</TD>");
								out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc' align='right'>0</TD>");
								out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+color.elementAt(mn).toString()+"</TD>");
								out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+for1.format((new Double(price.elementAt(mn).toString()).doubleValue())/(new Double(qtyMold).doubleValue()))+"</TD>");
								out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+for123.format((new Double(price.elementAt(mn).toString()).doubleValue()))+"</TD>");
								if(block_id.elementAt(mn).toString().equals("B_CHARGES_DP")){
									out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+for1.format(((new Double(price.elementAt(mn).toString()).doubleValue())*0.5)/(new Double(qtyMold).doubleValue()))+"</TD>");
									out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+for123.format((new Double(price.elementAt(mn).toString()).doubleValue())*0.5)+"</TD>");

								}
								else{
									out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+for1.format(((new Double(price.elementAt(mn).toString()).doubleValue()))/(new Double(qtyMold).doubleValue()))+"</TD>");
									out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+for1.format(((new Double(price.elementAt(mn).toString()).doubleValue())))+"</TD>");

								}
								out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc' align='center'>"+bpcs_part_no.elementAt(mn).toString()+"</TD>");
								out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc' align='right'>0</TD>");
								out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc' align='right'>"+tiercsquotes.elementAt(mn).toString()+"</TD></tr>");
								if(block_id.elementAt(mn).toString().equals("B_CHARGES_DP")){
									moldPrice=moldPrice+new Double(price.elementAt(mn).toString()).doubleValue();
									moldCost=moldCost+(new Double(price.elementAt(mn).toString()).doubleValue()*0.5);
									if(isDeduct){
										tot_cost=tot_cost-moldCost;
									}
									else{
										tot_cost=tot_cost+moldCost;
									}
								}
								else{
									moldPrice=moldPrice+new Double(price.elementAt(mn).toString()).doubleValue();
									moldCost=moldCost+(new Double(price.elementAt(mn).toString()).doubleValue());
									if(isDeduct){
										tot_cost=tot_cost-moldCost;
									}
									else{
										tot_cost=tot_cost+moldCost;
									}
								}
							}
						}
						if (wdth.elementAt(mn)==null){comm_perct="";}else{comm_perct=wdth.elementAt(mn).toString();}
						if(comm_perct== null || comm_perct.trim().length()<1){ comm_perct="0";}
						String totwt=price.elementAt(mn).toString();//Extended_Price
						bpcs_tier=tiercsquotes.elementAt(mn).toString();
						String fact=fact_per.elementAt(mn).toString().trim();//FIELD16
						if((block_id.elementAt(mn).toString()).equals("B_CHARGES_WC")||(block_id.elementAt(mn).toString()).equals("B_CHARGES_HR")||(block_id.elementAt(mn).toString()).equals("B_CHARGES_CR")||(block_id.elementAt(mn).toString()).equals("B_CHARGES_BG")||(block_id.elementAt(mn).toString()).equals("B_CHARGES")||(block_id.elementAt(mn).toString()).equals("B_CHARGES_DP")){
							//out.println("here<BR>");
							if(quan==null||quan.trim().length()==0){
								if( (bpcs_qty.elementAt(mn)==null)){
									quan="1";
								}
								else{
									quan=bpcs_qty.elementAt(mn).toString().trim();
								}
							}
							if(um == null || um.trim().length()==0){
								um=bpcs_um.elementAt(mn).toString();
							}
						}
						else{
							if( (bpcs_qty.elementAt(mn)==null)){
								quan="1";
							}
							else{
								quan=bpcs_qty.elementAt(mn).toString().trim();
							}
							um=bpcs_um.elementAt(mn).toString();
						}
						if (std_cost.elementAt(mn)==null){cost_line="0.0";}else{cost_line=std_cost.elementAt(mn).toString();}
						if( (quan==null) |(quan.trim().length()<=0) ){quan="1";}
						costFromString=(new Double(cost_line).doubleValue())*(new Double(quan).doubleValue());
						cost_line=""+(new Double(cost_line).doubleValue());
						tot_weight=tot_weight+(new Double(weight).doubleValue()*new Double(quan).doubleValue());
						if(!block_id.elementAt(mn).toString().startsWith("B_CHARGES")&&!block_id.elementAt(mn).toString().equals("B_CHARGES_WP")&&!((block_id.elementAt(mn).toString()).equals("C_OPTIONS")) &&  !(block_id.elementAt(mn).toString().equals("B_CHARGES_DP")) && !(block_id.elementAt(mn).toString().equals("B_CHARGES_HR")||block_id.elementAt(mn).toString().equals("B_CHARGES_CR"))){
							if(isDeduct){
								tot_cost=tot_cost-(new Double(cost_line).doubleValue()*new Double(quan).doubleValue());
							}
							else{
								tot_cost=tot_cost+(new Double(cost_line).doubleValue()*new Double(quan).doubleValue());
							}
						}
						if ((fact.equals(""))){fact="0.0"; }
						BigDecimal d1 = new BigDecimal(totwt);
							  BigDecimal d2 = new BigDecimal(fact);
						BigDecimal d3 = d1.multiply(d2);
							  factor = factor+d3.doubleValue();// total comission dollars for the line
						totprice=totprice+d1.doubleValue();//just the materail price no comission for the line
						if(isDeduct){
							totprice_dis=totprice_dis-d1.doubleValue();//Total material price for the job
						}
						else{
							totprice_dis=totprice_dis+d1.doubleValue();//Total material price for the job
						}
						if(isDeduct){
							totcomm_dol= totcomm_dol-d3.doubleValue();// final commission dollars for the job
						}
						else{
							totcomm_dol= totcomm_dol+d3.doubleValue();// final commission dollars for the job
						}
						if ((!(((fact_per.elementAt(mn)).toString()).equals("")))){
							String field_16=(fact_per.elementAt(mn)).toString().trim();
							/*if (prio.equals("E")){
								BigDecimal d4 = new BigDecimal(field_16);
								com_perc=((d4.doubleValue()*100));
							}
							else{*/
								BigDecimal d4 = new BigDecimal(field_16);
								BigDecimal d6 = new BigDecimal("0.91");
								BigDecimal d5 = d4.divide(d6,0);
								com_perc=((d5.doubleValue()*100));
							//}
								}
						if(codes.elementAt(mn)==null){prod_code="0";}else{prod_code=codes.elementAt(mn).toString();}
						start=0;
						end=0;
						end=prod_code.indexOf(".",start);
						if(end>start){
							prod_code=prod_code.substring(start,end);
						}
						if(prod_code.equals(prodCode[codeCount])){
							//codeCount=codeCount;
							a=a+1;
						}
						else{
							if(codeCount>1){
								prodProfit[codeCount]=prodSell[codeCount]-prodCost[codeCount];
								if(prodSell[codeCount]>0){
									prodGp[codeCount]=(prodProfit[codeCount]/prodSell[codeCount])*100;
									BigDecimal bd=new BigDecimal(prodGp[codeCount]);
									bd=bd.setScale(2,BigDecimal.ROUND_UP);
									prodGp[codeCount]=bd.doubleValue();
								}
							}
							codeCount=codeCount+1;
							prodCode[codeCount]=prod_code;
						}
						if(block_id.elementAt(mn).toString().equals("C_OPTIONS")){
							//out.println("here"+price.elementAt(mn).toString());
							prodSell[codeCount]=prodSell[codeCount]+(new Double(price.elementAt(mn).toString()).doubleValue());
						}
						if(!((block_id.elementAt(mn).toString()).equals("C_OPTIONS"))&&!((block_id.elementAt(mn).toString()).equals("D_NOTES"))&&!(block_id.elementAt(mn).toString().trim().equals("A_DP")) && !(block_id.elementAt(mn).toString().trim().equals("A_WP"))){
							if(!(block_id.elementAt(mn).toString().startsWith("B_CHARGES"))){
								if(isDeduct){
									prodCost[codeCount]=prodCost[codeCount]-costFromString;
								}
								else{
									prodCost[codeCount]=prodCost[codeCount]+costFromString;
								}
								if(tot_sum>0){
									prodComm[codeCount]=prodComm[codeCount]+(totprice+((totprice/tot_sum)*new Double(overage).doubleValue()))*((new Double(comm_perct).doubleValue())/100)*qType;
								}
								else{
									prodComm[codeCount]=0;
								}
							}
							if(isDeduct){
								if(tot_sum>0){
									prodSell[codeCount]=prodSell[codeCount]-(new Double(price.elementAt(mn).toString()).doubleValue())-(totprice/tot_sum)*new Double(overage).doubleValue();
								}
								else{
									prodSell[codeCount]=0;
								}
							}
							else{
								if(tot_sum>0){
									prodSell[codeCount]=prodSell[codeCount]+(new Double(price.elementAt(mn).toString()).doubleValue())+(totprice/tot_sum)*new Double(overage).doubleValue();
								}
								else{
									prodSell[codeCount]=0;
								}
							}
						}
						else if(block_id.elementAt(mn).toString().equals("A_DP") || block_id.elementAt(mn).toString().equals("A_WP")){
							//out.println("3<BR>");
							if(isDeduct){
								prodCost[codeCount]=prodCost[codeCount]-costFromString;
								prodSell[codeCount]=prodSell[codeCount]-(new Double(price.elementAt(mn).toString()).doubleValue());
							}
							else{
								prodCost[codeCount]=prodCost[codeCount]+costFromString;
								prodSell[codeCount]=prodSell[codeCount]+(new Double(price.elementAt(mn).toString()).doubleValue());
							}
							totprice=(new Double(price.elementAt(mn).toString()).doubleValue());
							if(tot_sum>0){
								prodComm[codeCount]=prodComm[codeCount]+(totprice+((totprice/tot_sum)*new Double(overage).doubleValue()))*((new Double(comm_perct).doubleValue())/100)*qType;
							}
							else{
								prodComm[codeCount]=0;
							}
						}
						if(k==sorted.size()-1){
							prodProfit[codeCount]=prodSell[codeCount]-prodCost[codeCount];
							if(prodSell[codeCount]>0){
								prodGp[codeCount]=(prodProfit[codeCount]/prodSell[codeCount])*100;
								BigDecimal bd=new BigDecimal(prodGp[codeCount]);
								bd=bd.setScale(2,BigDecimal.ROUND_UP);
								prodGp[codeCount]=bd.doubleValue();
							}
						}
					}//if it is not a a_aproduct
				}// the main if loop
			}// the inner for loop
			//out.println("The total:: "+totprice_dis);
			totprice=totprice-moldPrice;
			//ut.println(moldPrice+"::");
			String bolditalicred="";
String bolditalicredend="";
			if(((totprice+((totprice/tot_sum)*new Double(overage).doubleValue())))/new Double(quan).doubleValue()<(costFromString)/(new Double(quan).doubleValue())){
				bolditalicred="<b><i><font color='red'>";
				bolditalicredend="</b></i></font>";
			}

			if(isDeduct){
				out.println("<tr><td width='4%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+line_no+bolditalicredend+"</td>");
				out.println("<td width='13%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+description+bolditalicredend+"</td>");
				out.println("<td width='8%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+prod_code+bolditalicredend+"</td>");
				out.println("<td width='4%' valign='top' align='right' bgcolor='"+bgcolor+"' class='maindesc'>("+bolditalicred+quan+bolditalicredend+")</td>");
				out.println("<td valign='top' align='right' width='4%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+um+bolditalicredend+"</td>");
				out.println("<td valign='top' align='center' width='12%' bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+discount_show+bolditalicredend+"</td>");
				out.println("<td valign='top' align='right' width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+mark_up+bolditalicredend+"</td>");
				out.println("<td valign='top' align='right' width='6%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+comm_perct+bolditalicredend+"</td>");
				out.println("<td valign='top' align='right' width='3%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+esc+bolditalicredend+"</td>");
				//out.println(totprice+"< price descript>"+description+block_id.elementAt(mn).toString+"<BR>");
				if(tot_sum>0){
					out.println("<td valign='top' align='right' width='8%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>("+bolditalicred+for4.format( ((totprice+((totprice/tot_sum)*new Double(overage).doubleValue())))/new Double(quan).doubleValue() )+bolditalicredend+")</td>");
					out.println("<td valign='top' align='right' width='8%'bgcolor='"+bgcolor+"' class='maindesc'>("+bolditalicred+for1.format((totprice+((totprice/tot_sum)*new Double(overage).doubleValue())))+bolditalicredend+")</td>");

				}
				else{
					out.println("<td valign='top' align='right' width='8%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+"0"+bolditalicredend+"</td>");
					out.println("<td valign='top' align='right' width='8%'bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+"0"+bolditalicredend+"</td>");
				}
				out.println("<td valign='top' align='right' width='8%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>("+bolditalicred+for1.format((costFromString)/(new Double(quan).doubleValue()))+bolditalicredend+")</td>");
				out.println("<td valign='top' align='right' width='8%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>("+bolditalicred+for123.format(costFromString)+bolditalicredend+")</td>");
				out.println("<td valign='top' align='center' width='12%'bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+part_no+bolditalicredend+"</td>");
				out.println("<td valign='top' align='right' width='10%'bgcolor='"+bgcolor+"' class='maindesc'>("+bolditalicred+for12.format(new Double(weight).doubleValue()*new Double(quan).doubleValue())+bolditalicredend+")</td>");
				out.println("<td valign='top' align='right' width='10%'bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+bpcs_tier+bolditalicredend+"</td>");
				out.println("</tr>");

			}
			else{
				out.println("<tr><td width='4%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+line_no+bolditalicredend+"</td>");
				out.println("<td width='13%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+description+bolditalicredend+"</td>");
				out.println("<td width='8%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+prod_code+bolditalicredend+"</td>");
				out.println("<td width='4%' valign='top' align='right' bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+quan+bolditalicredend+"</td>");
				out.println("<td valign='top' align='right' width='4%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+um+bolditalicredend+"</td>");
				out.println("<td valign='top' align='center' width='12%' bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+discount_show+bolditalicredend+"</td>");
				out.println("<td valign='top' align='right' width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+mark_up+bolditalicredend+"</td>");
				out.println("<td valign='top' align='right' width='6%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+comm_perct+bolditalicredend+"</td>");
				out.println("<td valign='top' align='right' width='3%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+esc+bolditalicredend+"</td>");
				//out.println(totprice+"< price descript>"+description+block_id.elementAt(mn).toString+"<BR>");
				if(tot_sum>0){
					out.println("<td valign='top' align='right' width='8%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+for4.format( ((totprice+((totprice/tot_sum)*new Double(overage).doubleValue())))/new Double(quan).doubleValue() )+bolditalicredend+"</td>");
					out.println("<td valign='top' align='right' width='8%'bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+for1.format((totprice+((totprice/tot_sum)*new Double(overage).doubleValue())))+bolditalicredend+"</td>");

				}
				else{
					out.println("<td valign='top' align='right' width='8%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>+bolditalicred0</td>");
					out.println("<td valign='top' align='right' width='8%'bgcolor='"+bgcolor+"' class='maindesc'>+bolditalicred0</td>");
				}
				out.println("<td valign='top' align='right' width='8%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+for1.format((costFromString)/(new Double(quan).doubleValue()))+bolditalicredend+"</td>");
				out.println("<td valign='top' align='right' width='8%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+for123.format(costFromString)+bolditalicredend+"</td>");
				out.println("<td valign='top' align='center' width='12%'bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+part_no+bolditalicredend+"</td>");
				out.println("<td valign='top' align='right' width='10%'bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+for12.format(new Double(weight).doubleValue()*new Double(quan).doubleValue())+bolditalicredend+"</td>");
				out.println("<td valign='top' align='right' width='10%'bgcolor='"+bgcolor+"' class='maindesc'>"+bolditalicred+bpcs_tier+bolditalicredend+"</td>");
				out.println("</tr>");
			}
			bolditalicred="";
			factor=0;totprice=0;discount_show=""; comm_perct="0";moldCost=0;moldPrice=0;bpcs_tier="";
	}// The outer for loop
}
	%>
</table>
<br><br>
<%
double divider=0;
String bgcolor="#EFEFDE";
out.println("<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'>");
out.println("<tr height='20'>");
out.println("<td width='17%' bgcolor='#006600'colspan='6' align='center'><font class='schedule'><b>Product Summary</b></font></td></tr>");
out.println("<tr><td width='20%' valign='top' bgcolor='#006600' class='maindesc'><font class='schedule'>"+"CODE"+"</font></td>");
out.println("<td width='20%' valign='top' bgcolor='#006600' class='maindesc'  align='right'><font class='schedule'>"+"COST"+"</font></td>");
out.println("<td width='20%' valign='top' bgcolor='#006600' class='maindesc'  align='right'><font class='schedule'>"+"SELL"+"</font></td>");
out.println("<td width='20%' valign='top' bgcolor='#006600' class='maindesc'  align='right'><font class='schedule'>"+"GROSS PROFIT"+"</font></td>");
out.println("<td width='20%' valign='top' bgcolor='#006600' class='maindesc'  align='right'><font class='schedule'>"+"GP%"+"</font></td>");
out.println("<td width='20%' valign='top' bgcolor='#006600' class='maindesc'  align='right'><font class='schedule'>"+"COMM%"+"</font></td></tr>");
for(int count=2; count<=codeCount; count++){
	divider=prodSell[count]*qType;
	//out.println(prodComm[count]+"qType"+qType);
	if(divider!=0){
		divider=prodComm[count]/divider;
	}
	//out.println("   " + divider + "<br>");
	if ((count%2)==1){bgcolor="#e4e4e4";}else {bgcolor="#EFEFDE";}
	out.println("<tr><td width='20%' align='left' bgcolor='"+bgcolor+"' class='maindesc'>"+prodCode[count]+"  "+"</td>");
	out.println("<td width='20%' align='right' bgcolor='"+bgcolor+"' class='maindesc'>"+for123.format(prodCost[count])+"</td>");
	out.println("<td width='20%' align='right' bgcolor='"+bgcolor+"' class='maindesc'>"+for123.format(prodSell[count])+"</td>");
	out.println("<td width='20%' align='right' bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(prodProfit[count])+"</td>");
	out.println("<td width='20%' align='right' bgcolor='"+bgcolor+"' class='maindesc'>"+prodGp[count]+"%</td>");
	out.println("<td width='20%' align='right' bgcolor='"+bgcolor+"' class='maindesc'>"+for12.format(divider*100)+"%</td></tr>");
}



	freightTemp=freight_cost;
	setupTemp=setup_cost;
	handlingTemp=handling_cost;
	overageTemp=overage;
	// these statements are used to divide the total xtra costs for each section based on the
	// price of that section.  Basically a ratio (price of section/total price) * the xtra cost
	//out.println(xPriceTot);
//	freight_cost=""+(new Double(freight_cost).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));
	//freight_cost="0";
	if(new Double(xPriceTot).doubleValue()>0){

		setup_cost=""+(new Double(setup_cost).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));
		handling_cost=""+(new Double(handling_cost).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));

	}
	//overage="0";
//	overage=""+(new Double(overage).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));

	//freightx=freightx+(new Double(freight_cost).doubleValue());
	//out.println(freightx+" freightx<br>");

	//out.println(totalpricex+ " totalpricex<br>");
if(freeSections[ww] != null && freeSections[ww].trim().length()>0){
%>
<tr><td colspan='13'>
		<%= freeSections[ww]%><BR></td></tr>
		<%
		}
		if(qualSections[ww] != null && qualSections[ww].trim().length()>0){
		%>
<tr><td colspan='13'>
		<b>Qualifying Notes:<BR></b> <%= qualSections[ww]%></td></tr>
			<%
			}
			if(exclSections[ww] != null && exclSections[ww].trim().length()>0){
			%>
<tr><td colspan='13'>
		<B>Exclusion Notes:<BR> </b><%= exclSections[ww]%></td></tr>
			<%
			}
			//out.println(overage+"::"+totprice_dis+"::"+xPriceTot+": 1<BR>");
			out.println("</table><BR><BR>");
			//out.println(overage+":: 1 overage<BR>");
			double Xtra=0;
			if(new Double(xPriceTot).doubleValue()!=0){
				handling_cost=""+(new Double(foot_handling_cost).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));
				//out.println(totprice_dis+"::"+xPriceTot+"::<BR>");
				//out.println(handling_cost+"::::6<BR>");
				overage=""+(new Double(foot_overage).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));
				setup_cost=""+(new Double(foot_setup_cost).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));
				freight_cost=""+(new Double(foot_freight_cost).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));
			}
			//out.println(overage+": 2<BR>");

			if(overageSec[ww] != null && overageSec[ww].trim().length()>0){
				overage=overageSec[ww];
			}
			else if(isSecOverage){
				overage="0";
			}
			//out.println(overage+":: 3overage<BR>");
			if(setupSec[ww] != null && setupSec[ww].trim().length()>0){
				setup_cost=setupSec[ww];
			}
			else if(isSecSetup){
				setup_cost="0";
			}
			if(handlingSec[ww] != null && handlingSec[ww].trim().length()>0){
				handling_cost=handlingSec[ww];

			}
			else if(isSecHandling){
				handling_cost="0";

			}
			if(freightSec[ww] != null && freightSec[ww].trim().length()>0){
				freight_cost=freightSec[ww];
			}
			else if(isSecFreight){
				freight_cost="0";
			}
			//out.println(overage+": 3<BR>");
			if(tempseclines != null && tempseclines.trim().length()>0 &&numSections>1){
				sec_lines=tempseclines.substring(0,tempseclines.length()-1);
			}

//out.println(freight_cost+"::"+freightTemp+"<BR>");
//out.println(setup_cost+"::"+setupTemp+"<BR>");
//out.println(handling_cost+"::"+handlingTemp+"<BR>");
//out.println(overage+"::"+overageTemp+"<BR>");
Xtra=Xtra+new Double(freight_cost).doubleValue()+new Double(setup_cost).doubleValue()+new Double(handling_cost).doubleValue()+new Double(overage).doubleValue();
//out.println(Xtra+":: extra");
			%>

<%@ include file="show_summary_foot.jsp"%>
<%
tempseclines="";
sec_lines="";
	//out.println(totprice_dis+"::"+totalpricex+"::<BR>");
	totalpricex=totalpricex+totprice_dis;
//+Xtra;
//out.println(totprice_dis+"::"+totalpricex+"::<BR><BR><BR>");

	freight_cost=freightTemp;
	setup_cost=setupTemp;
	handling_cost=handlingTemp;
	overage=overageTemp;




%>






<BR><BR>
<%

}
}

if(numSections>1){
//;out.println(totalpricex+"::<BR><BR><BR>");
%>
<table class='tableline' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b>GRAND TOTAL</b></td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= for1.format(totalpricex) %> </font></b></td>
	</tr>

	<%
if(tax_perc!=null && new Double(tax_perc).doubleValue()>0){
	%>
	<tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b></b></td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Tax: <font class='totprice'><%= for1.format(totalpricex*(new Double(tax_perc).doubleValue()/100)) %> </font></b></td>
	</tr>
	<tr>
		<td class='tableline_row mainbody' width='50%' valign='middle'><b></b></td>
		<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total with Tax: <font class='totprice'><%= for1.format(totalpricex*(1+new Double(tax_perc).doubleValue()/100)) %> </font></b></td>
	</tr>
	<%
}
	}

	%>
	<%
	String user="";
	String uId="";
	HttpSession UserSession = request.getSession();
	if(UserSession.getAttribute("username")!=null){

		uId=UserSession.getAttribute("username").toString().trim();
		//out.println(uId);
	}
	if(uId != null&&uId.trim().length()>0){
		ResultSet rsx=stmt.executeQuery("select user_name from cs_reps where user_id like '"+uId+"'");
		if(rsx != null){
			while(rsx.next()){
				//out.println("HERE<BR>");
				if(rsx.getString(1) != null){
					user=rsx.getString(1);
				}
			}
		}
		rsx.close();
	}


	if(user != null && user.length()>0){
	%>
	<table width='100%'>
		<tr><td align='right'>
				<%
					out.println("Printed by "+user);
				%>
			</td></tr></table>
			<%
			}

			%>
</table>