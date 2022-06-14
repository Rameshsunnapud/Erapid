
<%

String tempseclines="";
String foot_handling_cost=handling_cost;
String foot_overage=overage;
String foot_setup_cost=setup_cost;
String foot_freight_cost=freight_cost;
							    handling_cost="0";
							    overage="0";
							    setup_cost="0";
							    freight_cost="0";

// this is used to populate a list to query csquote for the sum of the extended price column for all the lines that
// are used in the summary
String itemsLines="";
for(int n=0; n<items.size(); n++){
	itemsLines=itemsLines+items.elementAt(n).toString()+",";
}
itemsLines=itemsLines.substring(0,itemsLines.length()-1);
sec_lines=itemsLines;
//out.println(itemsLines);

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
quoteSizeRs.close();
double priceFromLine=0;
double totalpricex=0;
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
int xgs=0;
//out.println(isSections);
// if sections are used then it will query the db and get the values from the table based on that quote
if(isSections){
	ResultSet quoteRs=stmt.executeQuery("Select * from cs_quote_sections where order_no='"+order_no+"'");
	if(quoteRs != null){
		while(quoteRs.next()){
			if(quoteRs.getInt("sections")>0){
			//out.println(quoteRs.getString("section_info")+"<br>");
			//out.println(quoteRs.getString("section_group")+"<br>");
			sections=quoteRs.getString("section_group");
			secOverage=quoteRs.getString("overage");
			secHandling=quoteRs.getString("handling_cost");
			secSetup=quoteRs.getString("setup_cost");
			secFreight=quoteRs.getString("freight_cost");
			sectionsForBadder=quoteRs.getString("section_group");
			numSections=(int)(new Double(quoteRs.getString("sections")).doubleValue());
			nameSection=quoteRs.getString("section_info");
			freeText=quoteRs.getString("section_notes");
			qualNotes=quoteRs.getString("section_qual");
			exclNotes=quoteRs.getString("section_excl");
			xgs++;
			//out.println(numSections+"number of sections <br>");
			}
		}
	}
	quoteRs.close();
	//checking for nulls
	if(freeText==null){freeText="";}if(qualNotes==null){qualNotes="";}if(exclNotes==null){exclNotes="";}
	//null check done
	if(numSections<1){
		numSections=1;
		nameSection="";
		sections="";
		for(int y=0; y<line; y++){
			//actually recreating the string that is pulled from the sections table
			sections=sections+items.elementAt(y).toString().trim()+"=s1;";
			//out.println(sections);
		}
	}
}
// if sections aren't used then we will recreate the sections_group details using the line numbers from eorder items
// this is done, to make the program work the same the rest of the way in
else if(xgs <1 || numSections <1){
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
boolean isSecOverage=false;boolean isSecSetup=false; boolean isSecHandling=false; boolean isSecFreight=false;
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
for(int j=0; j<numSections; j++){
	sectionsArray[j]="";
	sectionsCountArray[j]=0;
	sectionsNameArray[j]="";
	//out.println(j);
}
int start=0;
int end=0;
// used sectioncount as a counter, used 100 just as a precaution (no infinite loops then)
while(sectionCount < 1000){
	// look for the next occurance of semi colon as this is the delimiter between feilds
	semiIndex=sections.indexOf(";");
	if(semiIndex > 0){
		// cuts the sections apart first part is the one we are going to work with
		// the second part is what remains of the string when we cut the first event out of it
		sectionx=sections.substring(0,semiIndex);
		//out.println(sectionx+" sectionx<br>");
		sections=sections.substring(semiIndex+1);
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
		}
	}
	else{
		// if the string is now empty then just set sectioncount to zero to exit while loop
		sectionCount=1000;
	}
	sectionCount++;
	semiIndex=0;
}
/*
for(int q=0; q<numSections; q++){
	out.println(" this is section"+q+" "+sectionsArray[q]);
}
*/
// used to cut the name sections apart
int startx=0;
int endx=0;
sectionCount=0;
while(sectionCount <100){

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
while(sectionCount <100){

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
while(sectionCount <100){

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
while(sectionCount <100){

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
for(int w=0; w<numSections; w++){
	double h=0;
	totprice_dis=0;
	factor=0;//totprice=0;
discount_show=""; cost_line="0";
totprice=0;
totcomm_dol=0;
tot_cost=0;
//overage="0";
//handling_cost="0";
//setup_cost="0";
tot_weight=0;
	//out.println("it gets here1");

if(sectionsArray[w].trim().length()>0){


%>
<font class='mainbodyh'><B>QUOTE SUMMARY FOR SECTION <%= sectionsNameArray[w] %>::</B><br><br></font>
<table width='100%' align='center' cellspacing='1' cellpadding='2' border='0'>
<tr height='20'>
<td width='4%' bgcolor='#006600'><font class='schedule'></font></td>
<td width='24%' bgcolor='#006600'><font class='schedule'><b>Model</b></font></td>
<td width='5%' bgcolor='#006600'><font class='schedule'><b>Qty</b></font></td>
<td width='4%' bgcolor='#006600'><font class='schedule'><b>UOM</b></font></td>
<td width='5%' bgcolor='#006600'><font class='schedule'><b>Discount/Pricing Level</b></font></td>
<td width='5%' bgcolor='#006600'><font class='schedule'><b>Mark-up</b></font></td>
<td width='5%' bgcolor='#006600'><font class='schedule'><b>Comm(%)</b></font></td>
<td width='5%' bgcolor='#006600'><font class='schedule'><b>Esc</b></font></td>
<td width='5%' bgcolor='#006600'><font class='schedule'><b>Unit Sell</b></font></td>
<td width='5%' bgcolor='#006600'><font class='schedule'><b>Total Sell</b></font></td>
<td width='5%' bgcolor='#006600'><font class='schedule'><b>Unit Cost</b></font></td>
<td width='5%' bgcolor='#006600'><font class='schedule'><b>Total Cost</b></font></td>
<td width='8%' bgcolor='#006600'><font class='schedule'><b>BPCS Part</b></font></td>
<td width='5%' bgcolor='#006600'><font class='schedule'><b>Weight</b></font></td>
<td width='5%' bgcolor='#006600'><font class='schedule'><b>GM$</b></font></td>
<td width='5%' bgcolor='#006600'><font class='schedule'><b>GM%</b></font></td>
</tr>
<%

	boolean isBadd=false;
	int bAddLine=0;
	int y=0;

	String bAdderString="";
	// to loop threw for each section in array

	for(int s=0; s<sectionsCountArray[w]; s++){
		// pulls out the first element in the sections string
		String comparedElement=sectionsArray[w];
		//out.println("comparedElement :: "+comparedElement+"<BR>");
		int f=comparedElement.indexOf(",");
		comparedElement=sectionsArray[w].substring(0,f);
		//out.println("comparedElement :: "+comparedElement+"<BR><BR>");

		sectionsArray[w]=sectionsArray[w].substring(f+1);

		for(int k=0;k<line;k++){
			boolean isDeduct=false;
			String pricing2line="";
			String bgcolor="";
			String line_no="";
			if ((k%2)==1){bgcolor="#e4e4e4";}else {bgcolor="#EFEFDE";}
			String config_s0 = config_string.elementAt(k).toString();//CONFIG STRING
			//Getting the Weight
			int config_s1= config_s0.indexOf("WEIGHT[");
			if(config_s1>0){
				int config_s2=config_s0.indexOf("]",config_s1+1);
				weight=config_s0.substring(config_s1+7,config_s2);
			}
			else{weight="0";}
			// if the element in items vector equals the element we are looking for from the sections string
			// then process the code.

			if(items.elementAt(k).toString().equals(comparedElement)){
				//Getting the weight done

				for (int mn=0;mn<line_item.size();mn++){
					y=mn;
					//out.println(line_item.elementAt(mn).toString()+"::"+mn+"<BR>");


						if ((line_item.elementAt(mn).toString()).equals((items.elementAt(k).toString()))){
							if(deduct.elementAt(mn).toString().equals("deduct")){
								isDeduct=true;
							}
							else{
								isDeduct=false;
							}
							//out.println(b
							if ((block_id.elementAt(mn).toString()).equals("A_APRODUCT")){
								tempseclines=tempseclines+items.elementAt(k).toString()+",";
								line_no=line_item.elementAt(mn).toString();
								description=(desc.elementAt(mn)).toString();
								mark=(mark_no.elementAt(mn)).toString();
								if (!(discount.elementAt(mn)==null)){
									discount_show=discount.elementAt(mn).toString().trim();//FIELD19
									if (discount.elementAt(mn).toString().trim().length()>0){
										discount_show=discount.elementAt(mn).toString().trim();
										}
									else{discount_show="BOOK";}
								}
								else{
								discount_show="";
								}
								// Mark up
								if (lgth.elementAt(mn)==null){mark_up="";}else{mark_up=lgth.elementAt(mn).toString();}
								if (field20.elementAt(mn)==null){comm_perct="";}else{comm_perct=field20.elementAt(mn).toString();}
								if (price_flag.elementAt(mn)==null){esc="";}else{esc=price_flag.elementAt(mn).toString();}
								if (bpcs_part_no.elementAt(mn)==null){part_no="";}else{part_no=bpcs_part_no.elementAt(mn).toString();}
								if (bpcs_part_no2.elementAt(mn)==null){part_no2="";}else{part_no2=bpcs_part_no2.elementAt(mn).toString();}
							}//if it is a a_aproduct
							else if(block_id.elementAt(mn).toString().equals("PRICING2")){
								pricing2line="<tr><td>"+line_item.elementAt(mn).toString()+"</td>";
								pricing2line=pricing2line+"<td>"+desc.elementAt(mn).toString()+"</td>";
								pricing2line=pricing2line+"<td>"+bpcs_qty.elementAt(mn).toString()+"</td>";
								pricing2line=pricing2line+"<td>"+bpcs_um.elementAt(mn).toString()+"</td>";
								pricing2line=pricing2line+"<td>&nbsp;</td>";
								pricing2line=pricing2line+"<td>"+lgth.elementAt(mn).toString()+"</td>";
								pricing2line=pricing2line+"<td>"+field20.elementAt(mn).toString()+"</td>";
								pricing2line=pricing2line+"<td>"+price_flag.elementAt(mn).toString()+"</td>";
								pricing2line=pricing2line+"<td>&nbsp;</td>";
								pricing2line=pricing2line+"<td>"+price.elementAt(mn).toString()+"</td>";
								pricing2line=pricing2line+"<td>"+std_cost.elementAt(mn).toString()+"</td>";
								pricing2line=pricing2line+"<td>&nbsp;</td>";
								pricing2line=pricing2line+"<td>"+bpcs_part_no.elementAt(mn).toString()+"</td>";
								pricing2line=pricing2line+"<td>&nbsp;</td>";
								pricing2line=pricing2line+"<td>&nbsp;</td>";
								pricing2line=pricing2line+"<td>&nbsp;</td>";
								pricing2line=pricing2line+"</tr>";
							}
							else{
								//if( !((block_id.elementAt(mn).toString()).equals("A_APRODUCT")))	{

								String totwt=price.elementAt(mn).toString();//Extended_Price
								String fact=fact_per.elementAt(mn).toString().trim();//FIELD16
								if(block_id.elementAt(mn).toString().equals("B_ADDERS")){
									isBadd=true;
									bAddLine=mn;
									bAdderString=desc.elementAt(mn).toString();
								}
								if( (bpcs_qty.elementAt(mn)==null)){quan="1";}else{quan=bpcs_qty.elementAt(mn).toString();}
								if (std_cost.elementAt(mn)==null){cost_line="0.0";}else{cost_line=std_cost.elementAt(mn).toString();}
							//	priceFromLine=priceFromLine+(new Double(price.elementAt(mn).toString()).doubleValue());
									if(isDeduct){
										priceFromLine=priceFromLine-(new Double(price.elementAt(mn).toString()).doubleValue());
									}
									else{
										priceFromLine=priceFromLine+(new Double(price.elementAt(mn).toString()).doubleValue());
									}
								if(block_id.elementAt(mn).toString().startsWith("PRICING")){
									if(isDeduct){
										tot_cost=tot_cost-(new Double(cost_line).doubleValue()*new Double(quan).doubleValue());
									}
									else{
										tot_cost=tot_cost+(new Double(cost_line).doubleValue()*new Double(quan).doubleValue());
									}
								}
								if(xLine.equals(line_item.elementAt(mn))){
								}
								else{
									if(isDeduct){
										tot_cost=tot_cost-(new Double(cost_line).doubleValue()*new Double(quan).doubleValue());
										tot_weight=tot_weight-(new Double(weight).doubleValue()*new Double(quan).doubleValue());
									}
									else{
										tot_cost=tot_cost+(new Double(cost_line).doubleValue()*new Double(quan).doubleValue());
										tot_weight=tot_weight+(new Double(weight).doubleValue()*new Double(quan).doubleValue());
									}

									xLine=line_item.elementAt(mn).toString();
								}
								if( (quan==null) |(quan.trim().length()<=0) ){quan="1";}
				//				um=bpcs_um.elementAt(mn).toString();
								if( (bpcs_um.elementAt(mn)==null)){um="";}
								else{um=bpcs_um.elementAt(mn).toString();}
								if ((fact.equals(""))){fact="0.0"; }
								BigDecimal d1 = new BigDecimal(totwt);
							    BigDecimal d2 = new BigDecimal(fact);
								BigDecimal d3 = d1.multiply(d2);
							    factor = factor+d3.doubleValue();// total comission dollars for the line
								totprice=totprice+d1.doubleValue();//just the materail price no comission for the line
								//out.println(totprice_dis + "this is the total price"+ d1.doubleValue()+"this is d1<br>");
								if(isDeduct){
									totprice_dis=totprice_dis-d1.doubleValue();//Total material price for the job
								}
								else{
									totprice_dis=totprice_dis+d1.doubleValue();//Total material price for the job
								}
			    				//otprice_dis=d1.doubleValue();
								if(isDeduct){
									totcomm_dol= totcomm_dol-d3.doubleValue();// final commission dollars for the job
								}
								else{
										totcomm_dol= totcomm_dol+d3.doubleValue();// final commission dollars for the job
								}
							}//if it is not a a_aproduct

				   		}// the main if loop

					}// the inner for loop
					double tempcomdoll=0.91*new Double(totprice).doubleValue()*(new Double(comm_perct).doubleValue()/100);
					double tempgmdoll=totprice-tempcomdoll-(new Double(cost_line).doubleValue()*new Double(quan).doubleValue());
					//out.println(totgmdoll
					double tempgmperc=tempgmdoll/new Double(totprice).doubleValue();

					out.println("<tr><td valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+line_no+"</td>");
					out.println("<td valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+description+"</td>");
					out.println("<td valign='top' align='right'  bgcolor='"+bgcolor+"' class='maindesc'>"+quan+"</td>");
					out.println("<td valign='top' align='right'  bgcolor='"+bgcolor+"' class='maindesc'>"+um+"</td>");
					out.println("<td valign='top' align='center' bgcolor='"+bgcolor+"' class='maindesc'>"+discount_show+"</td>");
					out.println("<td valign='top' align='right'  bgcolor='"+bgcolor+"' class='maindesc'>"+mark_up+"</td>");
    				out.println("<td valign='top' align='right'  bgcolor='"+bgcolor+"' class='maindesc'>"+comm_perct+"</td>");
    				out.println("<td valign='top' align='right'  bgcolor='"+bgcolor+"' class='maindesc'>"+esc+"</td>");
    				if(isDeduct){
   						out.println("<td valign='top' align='right'  bgcolor='"+bgcolor+"' class='maindesc'>("+for1.format( totprice/new Double(quan).doubleValue() )+")</td>");
						out.println("<td valign='top' align='right'  bgcolor='"+bgcolor+"' class='maindesc'>("+for123.format(totprice)+")</td>");
						out.println("<td valign='top' align='right'  bgcolor='"+bgcolor+"' class='maindesc'>("+cost_line+")</td>");
    					out.println("<td valign='top' align='right'  bgcolor='"+bgcolor+"' class='maindesc'>("+for123.format(new Double(cost_line).doubleValue()*new Double(quan).doubleValue())+")</td>");
					}
					else{
   						out.println("<td valign='top' align='right'  bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format( totprice/new Double(quan).doubleValue() )+"</td>");
						out.println("<td valign='top' align='right'  bgcolor='"+bgcolor+"' class='maindesc'>"+for123.format(totprice)+"</td>");
						out.println("<td valign='top' align='right'  bgcolor='"+bgcolor+"' class='maindesc'>"+cost_line+"</td>");
    					out.println("<td valign='top' align='right'  bgcolor='"+bgcolor+"' class='maindesc'>"+for123.format(new Double(cost_line).doubleValue()*new Double(quan).doubleValue())+"</td>");
					}

					out.println("<td valign='top' align='right'  bgcolor='"+bgcolor+"' class='maindesc'>"+part_no+" "+part_no2+"</td>");
					out.println("<td valign='top' align='right'  bgcolor='"+bgcolor+"' class='maindesc'>"+for12.format(new Double(weight).doubleValue()*new Double(quan).doubleValue())+"</td>");
					if(isDeduct){
						out.println("<td valign='top' align='right'  bgcolor='"+bgcolor+"' class='maindesc'>("+for12.format(tempgmdoll)+")</td>");
					}
					else{
						out.println("<td valign='top' align='right'  bgcolor='"+bgcolor+"' class='maindesc'>"+for12.format(tempgmdoll)+"</td>");
					}
					out.println("<td valign='top' align='right'  bgcolor='"+bgcolor+"' class='maindesc'>"+for12.format(tempgmperc*100)+"</td>");
					out.println("</tr>");
					out.println(pricing2line);
					pricing2line="";
					totprice=0;
					if (isBadd){
						out.println("<tr><td width='17%' valign='top' bgcolor='"+bgcolor+"' align='center' class='maindesc' colspan='16'><b>"+bAdderString+"</b></td></tr>");
						isBadd=false;
					}

			}// if the if for sections

		}// The outer for loop
	}//number of lines
	freightTemp=freight_cost;
	setupTemp=setup_cost;
	handlingTemp=handling_cost;
	overageTemp=overage;
	freight_cost=""+(new Double(freight_cost).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));
	setup_cost=""+(new Double(setup_cost).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));
	handling_cost=""+(new Double(handling_cost).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));
	overage=""+(new Double(overage).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));
if(overageSec[w] != null && overageSec[w].trim().length()>0){
	overage=overageSec[w];
}
else if(isSecOverage){
	overage="0";
}
if(setupSec[w] != null && setupSec[w].trim().length()>0){
	setup_cost=setupSec[w];
}
else if(isSecSetup){
	setup_cost="0";
}
if(handlingSec[w] != null && handlingSec[w].trim().length()>0){
	handling_cost=handlingSec[w];
}
else if(isSecHandling){
	handling_cost="0";
}
if(freightSec[w] != null && freightSec[w].trim().length()>0){
	freight_cost=freightSec[w];
}
else if(isSecFreight){
	freight_cost="0";
}
if(freeSections[w] != null && freeSections[w].trim().length()>0){
%>
<tr><td colspan='13'>
<%= freeSections[w]%></td></tr>
<%
}

if(qualSections[w] != null && qualSections[w].trim().length()>0){
%>
<tr><td colspan='13'>
<b>Qualifying Notes:<BR></b> <%= qualSections[w]%></td></tr>
<%
}

if(exclSections[w] != null && exclSections[w].trim().length()>0){
%>
<tr><td colspan='13'>
<B>Exclusion Notes:<BR> </b><%= exclSections[w]%></td></tr>
<%
}




out.println("</table><BR><BR>");
if(new Double(xPriceTot).doubleValue()>0){
	handling_cost=""+(new Double(foot_handling_cost).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));
	overage=""+(new Double(foot_overage).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));
	setup_cost=""+(new Double(foot_setup_cost).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));
	freight_cost=""+(new Double(foot_freight_cost).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));
}
if(overageSec[w] != null && overageSec[w].trim().length()>0){
	overage=overageSec[w];
}
else if(isSecOverage){
	overage="0";
}
if(setupSec[w] != null && setupSec[w].trim().length()>0){
	setup_cost=setupSec[w];
}
else if(isSecSetup){
	setup_cost="0";
}
if(handlingSec[w] != null && handlingSec[w].trim().length()>0){
	handling_cost=handlingSec[w];
}
else if(isSecHandling){
	handling_cost="0";
}
if(freightSec[w] != null && freightSec[w].trim().length()>0){
	freight_cost=freightSec[w];
}
else if(isSecFreight){
	freight_cost="0";
}
if(tempseclines != null && tempseclines.trim().length()>0 &&numSections>1){
	sec_lines=tempseclines.substring(0,tempseclines.length()-1);
}
%>
<%@ include file="show_summary_foot.jsp"%>
<%
tempseclines="";
sec_lines="";
totalpricex=totalpricex+totprice_dis;
	freight_cost=freightTemp;
	setup_cost=setupTemp;
	handling_cost=handlingTemp;
	overage=overageTemp;
	}//numSections for loop
}//sections if
if(numSections>1){
%>
<table class='tableline' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'>
<tr>
	<td class='tableline_row mainbody' width='50%' valign='middle'><b>MATERIAL TOTAL</b></td>
	<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= for123.format(totalpricex) %> </font></b></td>
</tr>
</table>
<%
if (!(tax_perc==null||tax_perc.equals("0"))){
%>
<table class='tableline' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'>
<tr>
	<td class='tableline_row mainbody' width='50%' valign='middle'><b>TAX ONLY</b></td>
	<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= for123.format((totalpricex)*(Double.parseDouble(tax_perc)/100)) %> </font></b></td>
</tr>
</table>
<table class='tableline' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'>
<tr>
	<td class='tableline_row mainbody' width='50%' valign='middle'><b>GRAND TOTAL</b></td>
	<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= for123.format((totalpricex)*(1+(Double.parseDouble(tax_perc)/100))) %> </font></b></td>
</tr>
</table>

<%
}
%>

<%
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
<br><br>
