<%

String itemsLines="";
for(int n=0; n<items.size(); n++){
	itemsLines=itemsLines+items.elementAt(n).toString()+",";
}
itemsLines=itemsLines.substring(0,itemsLines.length()-1);
String xPriceTot="";
//out.println("select sum(cast(extended_price as decimal)) from csquotes where order_no'"+order_no+"' and line_no in ("+itemsLines+")");
// used to get the total extended price of lines used

ResultSet xPrice=stmt.executeQuery("select sum(cast(extended_price as decimal)) from csquotes where order_no='"+order_no+"' and line_no in ("+itemsLines+")");
if(xPrice != null){
		while(xPrice.next()){
			if(group.startsWith("Can")){
				double temptotalcan=new Double(xPrice.getString(1)).doubleValue()*((100-new Double(candiscount).doubleValue())/100);
				xPriceTot=""+temptotalcan;
			}
			else{
				xPriceTot=xPrice.getString(1);
			}
			//out.println(xPriceTot+"<br>");
		}
}
xPrice.close();
boolean isSections=false;
// sets a boolean to true if sections are used
ResultSet quoteSizeRs=stmt.executeQuery("select count(*) from cs_quote_sections where order_no='"+order_no+"' and not sections='1'");
if(quoteSizeRs != null){
	while(quoteSizeRs.next()){
		//out.println(quoteSizeRs.getString(1));
		if((new Double(quoteSizeRs.getString(1)).doubleValue())>0){
			isSections=true;
		}
	}
	quoteSizeRs.close();
}
boolean isSecOverage=false;boolean isSecSetup=false; boolean isSecHandling=false; boolean isSecFreight=false;

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
			//out.println(numSections+"number of sections <br>");
			}
			else{
				numSections=0;
			}
		}
	}
	quoteRs.close();
}

if(freeText == null || freeText.equals("null")){
	freeText="";
}
if(qualNotes == null || qualNotes.equals("null")){
	qualNotes="";
}

if(exclNotes == null || exclNotes.equals("null")){
	exclNotes="";
}

// if sections aren't used then we will recreate the sections_group details using the line numbers from eorder items
// this is done, to make the program work the same the rest of the way in
if(numSections <1){
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
for(int j=0; j<numSections; j++){
	sectionsArray[j]="";
	sectionsCountArray[j]=0;
	sectionsNameArray[j]="";
	//out.println(j);
}
int start=0;
int end=0;
// used sectioncount as a counter, used 100 just as a precaution (no infinite loops then)
while(sectionCount < 100){
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
		sectionCount=100;
	}
	sectionCount++;
	semiIndex=0;
}

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
for(int ww=0; ww<numSections; ww++){
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

if(sectionsArray[ww].trim().length()>0){
%>

<font class='mainbodyh'><B>QUOTE SUMMARY ::</B><br><br></font>
<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'>
	<tr height='20'>
		<td width='17%' bgcolor='#006600'><font class='schedule'><b>Model</b></font></td>
		<td width='4%' bgcolor='#006600'><font class='schedule'><b>Qty</b></font></td>
		<td width='4%' bgcolor='#006600'><font class='schedule'><b>UOM</b></font></td>
		<td width='10%' bgcolor='#006600'><font class='schedule'><b>Level</b></font></td>
		<td width='7%' bgcolor='#006600'><font class='schedule'><b>Mark-up</b></font></td>
		<td width='6%' bgcolor='#006600'><font class='schedule'><b>Comm(%)</b></font></td>
		<td width='3%' bgcolor='#006600'><font class='schedule'><b>Esc</b></font></td>
		<td width='8%' bgcolor='#006600'><font class='schedule'><b>Unit Sell</b></font></td>
		<td width='8%' bgcolor='#006600'><font class='schedule'><b>Total Sell</b></font></td>
		<td width='8%' bgcolor='#006600'><font class='schedule'><b>Unit Cost</b></font></td>
		<td width='8%' bgcolor='#006600'><font class='schedule'><b>Total Cost</b></font></td>
		<td width='12%' bgcolor='#006600'><font class='schedule'><b>BPCS Part</b></font></td>
		<td width='10%' bgcolor='#006600'><font class='schedule'><b>Weight</b></font></td>
	</tr>
	<%

	double totalCost = 0;
	double q=1;
	String totQuan;
	//double safetyDollars=0;
	//boolean isSafetyDollars=false;


		description="";
		for(int k=0;k<line;k++){

							String sectionTemp=sectionsArray[ww];
							//out.println(sectionTemp+"::"+items.elementAt(k).toString()+" sectiontemp<BR>");
							boolean isGood=false;
							int testing=0;
							while(!isGood && testing < 100){
								int hg=sectionTemp.indexOf(",");
								if(hg>0){
									//out.println(sectionTemp.substring(0,hg)+"::"+items.elementAt(k).toString()+"<BR>");
									if(sectionTemp.substring(0,hg).equals(items.elementAt(k).toString())){
										isGood=true;
										//out.println(items.elementAt(k).toString()+" :: its good!!!<BR>");
										//sec_lines=items.elementAt(k).toString();
										sec_lines=sec_lines+items.elementAt(k).toString()+",";
									}
									//out.println(sectionTemp.substring(0,hg)+"::"+hg+"<BR>");
									//out.println(sectionTemp.substring(hg+1)+" after<BR>");
									sectionTemp=sectionTemp.substring(hg+1);

								}
								testing++;
							}
												//out.println(" break<BR><BR>");
					if(isGood){

			double totalUnitCost = 0;
			String bgcolor="";
			//get description
			//totQuan=QTY.elementAt(1).toString();
			for (int mn=0;mn<line_item.size();mn++){
				//out.println(items.elementAt(k).toString()+ ":: line number<BR>");

				if(lgth.elementAt(mn)==null){
					mark_up="";
				}
				else{
					mark_up=lgth.elementAt(mn).toString();
				}
				if ((line_item.elementAt(mn).toString()).equals((items.elementAt(k).toString()))){
					if ((block_id.elementAt(mn).toString()).equals("A_APRODUCT")){
							description=(desc.elementAt(mn)).toString();
					}

				}//if it is a a_aproduct
			}
			if ((k%2)==1){bgcolor="#e4e4e4";}else {bgcolor="#EFEFDE";}
				String config_s0 = config_string.elementAt(k).toString();//CONFIG STRING
				//Getting the Weight
				int config_s1= config_s0.indexOf("WEIGHT[");
				if(config_s1>0){
					int config_s2=config_s0.indexOf("]",config_s1+1);
					weight=config_s0.substring(config_s1+7,config_s2);
				}
				else{weight="0";}


				//Getting the weight done

			for (int mn=0;mn<line_item.size();mn++){

				if(lgth.elementAt(mn)==null){
					mark_up="";
				}
				else{
					mark_up=lgth.elementAt(mn).toString();
				}
				if ((line_item.elementAt(mn).toString()).equals((items.elementAt(k).toString()))){
				if ((block_id.elementAt(mn).toString()).equals("A_APRODUCT")){
					    //description=(desc.elementAt(mn)).toString();
					 mark=(mark_no.elementAt(mn)).toString();
					 // Mark up & pricing level
					 double d;
				totQuan=QTY.elementAt(mn).toString().trim();

				//out.println(totQuan);


				if (lgth.elementAt(mn)==null){mark_up=""; d=0;}
				else{
					mark_up=lgth.elementAt(mn).toString().trim();
					if(mark_up.trim().length()>0){
						d=Double.valueOf(mark_up.trim()).doubleValue();
					}
					else{
						d=0;
					}
				}
				if (!(discount.elementAt(mn)==null) && d<=0){
						discount_show=discount.elementAt(mn).toString().trim().replace('L','B');//FIELD19
					 }
					 else{
						discount_show="";
					 }
				}//if it is a a_aproduct

				if( !( ((block_id.elementAt(mn).toString()).equals("A_APRODUCT"))|((block_id.elementAt(mn).toString()).equals("E_DIM"))|((block_id.elementAt(mn).toString()).equals("D_NOTES"))|block_id.elementAt(mn).toString().equals("E_DIM2")|((block_id.elementAt(mn).toString()).equals("E_DIM1")) ) )	{
					String totwt=price.elementAt(mn).toString();//Extended_Price
					String fact=fact_per.elementAt(mn).toString().trim();//FIELD16
					if(group.startsWith("Can")){
						//fact=""+(new Double(commission).doubleValue()/100);
					}



					totQuan=QTY.elementAt(mn).toString().trim();

				//out.println(totQuan);



				if (std_cost.elementAt(mn)==null){
					cost_line="0.0";
				}
				else{
					if(std_cost.elementAt(mn).toString().trim().length()>0){
						cost_line=std_cost.elementAt(mn).toString().trim();
					}
					else{
						cost_line="0";
					}
				}

				if( (bpcs_qty.elementAt(mn)==null)){quan="1";}
				else{
					if(bpcs_qty.elementAt(mn).toString().trim().length()>0){
						quan=bpcs_qty.elementAt(mn).toString();
						//quan=""+q;
						//out.println("HERE");

					}
						else{quan="1";
					}
				}


						//if(totQuan.length()<1){
						//	totQuan="1x";
						//}

				//get the safety dollars value out of the config string
				String block1 ="";
				String safety = "";
				start = 0;
				int index1=0;
				int nextSlash = 0;
				int start2 = 0;
				int start3=0;
				if (wdth.elementAt(mn)==null){comm_perct="";}else{comm_perct=wdth.elementAt(mn).toString();}
				if (bpcs_part_no.elementAt(mn)==null){part_no="";}else{part_no=bpcs_part_no.elementAt(mn).toString();}
				while(index1 < config_s0.length()){
					start=config_s0.indexOf("FP/",start);
					if(start< config_s0.length()-3 || start <=0){
						nextSlash=config_s0.indexOf("/",start+3);
						start2=config_s0.indexOf("SD[",start);
						if(start2 > 0 && start2<nextSlash){
							start3=config_s0.indexOf("]",start2);
							if(start3 > 0){
								safety = config_s0.substring(start2+3, start3);
								if(bpcs_part_no.elementAt(mn).toString().trim().equals("") && bpcs_um.elementAt(mn).toString().trim().length() <=0){
									//cost_line=safety;
									cost_line="0";
									mark_up="";
									comm_perct="";
									part_no="SAFETY";
									totQuan="1";
								}

							}
							else{
								safety = "0";
							}
							index1=config_s0.length();
							block1="in if";
						}
						else{
							if(start2<=0){
								index1=config_s0.length();
							}
							else{
								index1=config_s0.length();
							}
							start=index1;
							block1="in else";
							safety="0";
						}
					}
					else{
						index1=config_s0.length();
						block1="in 2nd else";
						safety="0";
					}
				}

						String helQuan=quan;
						//out.println(quan+"::"+totQuan+"<BR>");
						q=(new Double(quan).doubleValue()*new Double(totQuan).doubleValue());
						quan=""+q;


						if( (bpcs_um.elementAt(mn)==null)){um="";}else{um=bpcs_um.elementAt(mn).toString();}

						String block = block_id.elementAt(mn).toString();
						String isMatScrap ="";
						isMatScrap = desc.elementAt(mn).toString();

						if (bpcs_part_no2.elementAt(mn)==null){part_no2="";}else{part_no2=bpcs_part_no2.elementAt(mn).toString();}
						if(part_no.trim().equals("")){
							part_no=part_no2;
						}

						//out.println(part_no.substring(0,3));
						/*
						if(part_no != null && part_no.trim().length() >0){
							if(part_no.substring(0,3).equals("HXZ")){
								//out.println(helQuan);
								quan=helQuan;
							}
						}
						*/






						if(block.equals("D_MISC5") || (block.equals("C_MISC") && !(isMatScrap.equals("Mat Scrap")))){
							mark_up="";
						   if(block.equals("D_MISC5")){
							//comm_perct="5";
						   }
						   else if(part_no.equals("TEMPLATEMAT") || part_no.equals("TEMPLATEGRID")){
							comm_perct="";
						   }
						}

							if (color.elementAt(mn)==null){esc="";}else{esc=color.elementAt(mn).toString();}


						if ((fact.equals(""))){fact="0.0"; }


						BigDecimal d1 = new BigDecimal(totwt);
						BigDecimal d2 = new BigDecimal(fact);
						BigDecimal d3 = d1.multiply(d2);
						factor = factor+d3.doubleValue();// total comission dollars for the line
						   double oldTotPrice=totprice;



						totprice=totprice+d1.doubleValue();//just the materail price no comission for the line
						totprice_dis=totprice_dis+d1.doubleValue();//Total material price for the job
						//out.println(totprice_dis+"::<BR>");
						totcomm_dol= totcomm_dol+d3.doubleValue();// final commission dollars for the job
						double newTotPrice=totprice-oldTotPrice;

						double unitSell = (totprice-oldTotPrice)/(new Double(quan).doubleValue());






						//q=(new Double(quan).doubleValue()*new Double(totQuan).doubleValue());
						//quan=""+q;


						if(part_no.equals("RECTNOTCH") || part_no.equals("CORNERNOTCH")|| part_no.equals("DIAGONALGRID")|| part_no.equals("DIAGONALMAT")|| part_no.equals("RADIUSMAT")|| part_no.equals("TEMPLATEGRID")|| part_no.equals("TEMPLATEMAT")||part_no.equals("LOGOGRID")){
							cost_line=unitSell+"";
							totalUnitCost=newTotPrice;
							description=description;
						}
						totalUnitCost = (new Double(cost_line.trim()).doubleValue()*new Double(quan.trim()).doubleValue());

						totalCost = totalCost + totalUnitCost;

						//totQuan="2";

						//q=(new Double(quan).doubleValue()*new Double(totQuan).doubleValue());
						//quan=""+q;


						tot_weight=tot_weight+(new Double(weight).doubleValue()*new Double(quan).doubleValue());
						tot_cost=tot_cost+(new Double(cost_line).doubleValue()*new Double(quan).doubleValue());

						if(part_no.equals("SAFETY")){
							safetyDollars=safetyDollars+newTotPrice;
							isSafetyDollars=true;
						}



						out.println("<tr><td width='17%' valign='top' bgcolor='"+bgcolor+"' class='maindesc'>"+description+"</td>");
						out.println("<td width='4%' valign='top' align='right' bgcolor='"+bgcolor+"' class='maindesc'>"+quan+"</td>");
						out.println("<td valign='top' align='right' width='4%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+um+"</td>");
						out.println("<td valign='top' align='center' width='10%' bgcolor='"+bgcolor+"' class='maindesc'>"+discount_show+"</td>");
						out.println("<td valign='top' align='right' width='7%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+mark_up+"</td>");
						   out.println("<td valign='top' align='right' width='6%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+comm_perct+"</td>");
						out.println("<td valign='top' align='right' width='3%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+esc+"</td>");
							out.println("<td valign='top' align='right' width='8%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for4.format(unitSell)+"</td>");
						out.println("<td valign='top' align='right' width='8%'bgcolor='"+bgcolor+"' class='maindesc'>"+for123.format(newTotPrice)+"</td>");
						out.println("<td valign='top' align='right' width='8%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for1.format(new Double(cost_line).doubleValue())+"</td>");
						out.println("<td valign='top' align='right' width='8%' nowrap bgcolor='"+bgcolor+"' class='maindesc'>"+for123.format(totalUnitCost)+"</td>");
						out.println("<td valign='top' align='right' width='12%'bgcolor='"+bgcolor+"' class='maindesc'>"+part_no+"</td>");
						out.println("<td valign='top' align='right' width='10%'bgcolor='"+bgcolor+"' class='maindesc'>"+for12.format(new Double(weight).doubleValue()*new Double(quan).doubleValue())+"</td>");
						//out.println("<td valign='top' align='right' width='10%'bgcolor='"+bgcolor+"' class='maindesc'>"+cost_line+"  "+totalUnitCost +"</td>");
						out.println("</tr>");
						//q=1;

				}//if it is not a a_aproduct
				   }// the main if loop
			}// the inner for loop

		factor=0;totprice=0;discount_show="";
		}// The outer for loop

	}}

		freightTemp=freight_cost;
		setupTemp=setup_cost;
		handlingTemp=handling_cost;
		overageTemp=overage;
		// these statements are used to divide the total xtra costs for each section based on the
		// price of that section.  Basically a ratio (price of section/total price) * the xtra cost
		freight_cost=""+(new Double(freight_cost).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));
		setup_cost=""+(new Double(setup_cost).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));
		handling_cost=""+(new Double(handling_cost).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));
		overage=""+(new Double(overage).doubleValue())*((totprice_dis)/(new Double(xPriceTot).doubleValue()));
		//freightx=freightx+(new Double(freight_cost).doubleValue());
		//out.println(freightx+" freightx<br>");
	if(overageSec[ww] != null && overageSec[ww].trim().length()>0){
		overage=overageSec[ww];
	}
	else if(isSecOverage){
		overage="0";
	}
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

				out.println("</table><BR><BR>");
				%>
				<%@ include file="show_summary_foot.jsp"%>
				<%

						totalpricex=totalpricex+totprice_dis;
					freight_cost=freightTemp;
					setup_cost=setupTemp;
					handling_cost=handlingTemp;
					overage=overageTemp;





				%>






	<BR><BR>
	<%

	}

	if(numSections>1){
	%>
	<table class='tableline' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
			<td class='tableline_row mainbody' width='50%' valign='middle'><b>GRAND TOTAL</b></td>
			<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= for123.format(totalpricex) %> </font></b></td>
		</tr>
	</table>
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
