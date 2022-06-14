<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.math.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%
try{
%>
<%@ include file="../../db_con.jsp"%>
<%@ include file="../../db_con_rep_data.jsp"%>
<%


DecimalFormat df4 = new DecimalFormat("####.####");
df4.setMaximumFractionDigits(4);
df4.setMinimumFractionDigits(4);
DecimalFormat df2 = new DecimalFormat("####.##");
df2.setMaximumFractionDigits(2);
df2.setMinimumFractionDigits(2);
DecimalFormat df0 = new DecimalFormat("####");
df0.setMaximumFractionDigits(0);
df0.setMinimumFractionDigits(0);
DecimalFormat df3 = new DecimalFormat("####.###");
df3.setMaximumFractionDigits(3);
df3.setMinimumFractionDigits(3);
String order_no=request.getParameter("order_no");
String tax_perc=request.getParameter("tax_perc");
String overage=request.getParameter("overage");
String handling_cost=request.getParameter("handling_cost");
String freight_cost=request.getParameter("freight_cost");
//out.println(freight_cost+"::<BR>");
String setup_cost1=request.getParameter("setup_cost1");
String setup_cost=request.getParameter("setup_cost");
String totprice_dis=request.getParameter("totprice_dis");
//out.println(totprice_dis+"::1");
//out.println(totprice_dis);
String product_id=request.getParameter("product_id");
String isquote=request.getParameter("isquote");
String grandtotalforsec=request.getParameter("grandtotalforsec");
String secLines=request.getParameter("secLines");
String currencyName=request.getParameter("currencyName");
if (currencyName == null) {
	currencyName = "";
}
//out.println(grandtotalforsec+"::"+secLines);
boolean istaxstate=false;
String tax_zip="";
if(product_id==null){
	product_id="";
}
String project_type="";
//out.println(totprice_dis+"::"+freight_cost+"::"+overage+"::"+grandtotalforsec);
ResultSet rstaxproject=stmt.executeQuery("select tax_zip,project_type,sfdc_country from cs_project where order_no='"+order_no+"'");
if(rstaxproject != null){
	while(rstaxproject.next()){
		tax_zip=rstaxproject.getString(1);
		project_type=rstaxproject.getString(2);
	}
}
rstaxproject.close();
//out.println(tax_zip);
if(project_type==null){
	project_type="";
}

String state="";


ResultSet rsTaxPerc=stmtRepData.executeQuery("select stateabbrev from tax_rep2 where zip='"+tax_zip+"'");
if(rsTaxPerc != null){
	while(rsTaxPerc.next()){
		state=rsTaxPerc.getString("stateabbrev");
	}
}
rsTaxPerc.close();

ResultSet rstaxstate=stmtRepData.executeQuery("select state from cs_freight_tax_state where state='"+state+"'");
if(rstaxstate != null){
	while(rstaxstate.next()){
		istaxstate=true;
	}
}
rstaxstate.close();

if(grandtotalforsec == null || grandtotalforsec.equals("null")){
	grandtotalforsec="";
}

if(totprice_dis == null || totprice_dis.equals("null")){
	totprice_dis="";
}

else{
	if(!(product_id.equals("GE")||product_id.equals("ELM")||product_id.equals("IWP"))){
		//out.println(totprice_dis+"::1");
		if(!project_type.equals("web")){
			totprice_dis=df0.format(new Double(totprice_dis).doubleValue());
		}
		//out.println(totprice_dis+"::2");

	}
}

if(isquote==null){
	isquote="";
}
if( overage== null || overage.equals("null")){
	overage="0";
}
if( handling_cost== null || handling_cost.equals("null")){
	handling_cost="0";
}
if( freight_cost== null || freight_cost.equals("null")){
	freight_cost="0";
}
if( setup_cost1== null || setup_cost1.equals("null")||setup_cost1.trim().length()==0){
	setup_cost1="0";
}
if( setup_cost== null || setup_cost.equals("null")||setup_cost.trim().length()==0){
	setup_cost="0";
}
if(product_id == null || product_id.equals("null")){
	product_id="";
}
String isRepQuote=request.getParameter("isRepQuote");
if(isRepQuote==null){
	isRepQuote="";
}

float grand_total=0;
float tax_dollar=0;
NumberFormat for1 = NumberFormat.getCurrencyInstance();
for1.setMaximumFractionDigits(2);
for1.setMinimumFractionDigits(2);
NumberFormat for1ads = NumberFormat.getCurrencyInstance();
for1ads.setMaximumFractionDigits(0);
for1ads.setMinimumFractionDigits(0);
if(tax_perc != null && tax_perc.trim().length()>0 && !tax_perc.toUpperCase().equals("NULL")&& new Double(tax_perc).doubleValue()>0){

	Vector tax_qty=new Vector();
	Vector tax_extended_price=new Vector();
	Vector isTaxable=new Vector();
	Vector tax_unit_price=new Vector();
	Vector tax_overage_line=new Vector();
	Vector tax_setup_line=new Vector();
	Vector tax_handling_line=new Vector();
	Vector tax_freight_line=new Vector();
	Vector tax_overage_line2=new Vector();
	Vector tax_setup_line2=new Vector();
	Vector tax_handling_line2=new Vector();
	Vector tax_freight_line2=new Vector();
	String tax_overage="0";
	String tax_handling="0";
	String tax_freight="0";
	String tax_setup="0";
	double taxtotalprice=0;
	double temp_tax_total=0;
	double temp_total=0;
	double difference=0;
	if(request.getParameter("overage") != null && request.getParameter("overage").trim().length()>0 && !request.getParameter("overage").toLowerCase().equals("null")){
		tax_overage=request.getParameter("overage");
	}
	if(request.getParameter("handling_cost") != null && request.getParameter("handling_cost").trim().length()>0 && !request.getParameter("handling_cost").toLowerCase().equals("null")){
		tax_handling=request.getParameter("handling_cost");
	}
	if(request.getParameter("freight_cost") != null && request.getParameter("freight_cost").trim().length()>0 && !request.getParameter("freight_cost").toLowerCase().equals("null")){
		tax_freight=request.getParameter("freight_cost");
	}
	if(request.getParameter("setup_cost1") != null && request.getParameter("setup_cost1").trim().length()>0 && !request.getParameter("setup_cost1").toLowerCase().equals("null")){
		tax_setup=request.getParameter("setup_cost1");
	}
	if(request.getParameter("setup_cost") != null && request.getParameter("setup_cost").trim().length()>0 && !request.getParameter("setup_cost").toLowerCase().equals("null")){
		tax_setup=request.getParameter("setup_cost");
	}
	String query1="select * from csquotes where order_no='"+order_no+"' and not extended_price is null and not extended_price='' and cast(extended_price as float)>0 AND (NOT EXISTS (SELECT NULL AS Expr1 FROM cs_no_tax_parts WHERE (part_no = CSQUOTES.field18)))";
	if(secLines != null &&  secLines.trim().length()>0){
		query1="select * from csquotes where order_no='"+order_no+"' and not extended_price is null and not extended_price='' and cast(extended_price as float)>0 and line_no in ("+secLines+") AND (NOT EXISTS (SELECT NULL AS Expr1 FROM cs_no_tax_parts WHERE (part_no = CSQUOTES.field18)))";
	}
	ResultSet rstax=stmt.executeQuery(query1);
	if(rstax != null){
		while(rstax.next()){
			if(product_id.equals("GCP")||product_id.equals("ADS")||product_id.equals("LVR")){
				tax_qty.addElement(""+new Double(df3.format(rstax.getDouble("qty"))));
			}
			else{				
				//Fix #INT-15: summary tax.jsp:: error:::java.sql.SQLException: The value supplied cannot be converted to DOUBLE.
				//rstax.getDouble("bpcs_qty") gives an issue when value is blank in database
				Object bpcsQtyObj=  rstax.getObject("bpcs_qty");			    
			    if(null==bpcsQtyObj || bpcsQtyObj.toString().trim().isEmpty() || bpcsQtyObj.toString().trim().equalsIgnoreCase("null")){
					
			    	double defaultBpcsQty = 0d;
			    	tax_qty.addElement(""+new Double(df3.format(defaultBpcsQty)));
			    }
			    else{
			   		 tax_qty.addElement(""+new Double(df3.format(rstax.getDouble("bpcs_qty"))));
			    }			  
				//tax_qty.addElement(""+new Double(df3.format(rstax.getDouble("bpcs_qty"))));
			}
			//out.println(rstax.getDouble("extended_price")+"::<BR>");
			boolean isDeductx=false;
			if(rstax.getString("deduct") !=null && rstax.getString("deduct").equals("deduct")){
				tax_extended_price.addElement(""+new Double(df4.format(0-rstax.getDouble("extended_price"))).doubleValue());
			}
			else{
				tax_extended_price.addElement(""+new Double(df4.format(rstax.getDouble("extended_price"))).doubleValue());
			}
			temp_total=temp_total+rstax.getDouble("extended_price");
			if(product_id.equals("GCP")){
				//taxtotalprice=taxtotalprice+rstax.getDouble("extended_price");
			}
			isTaxable.addElement("true");
		}
	}
	rstax.close();
	difference=new Double(df0.format(temp_total)).doubleValue()-temp_total;
	if(product_id.equals("GE")){
		difference=0;
	}
	int indexOfMax=0;
	for(int r=0; r<tax_extended_price.size(); r++){
		for(int e=0; e<tax_extended_price.size(); e++){
			if(new Double(tax_extended_price.elementAt(e).toString()).doubleValue()>new Double(tax_extended_price.elementAt(indexOfMax).toString()).doubleValue()){
				indexOfMax=e;
				if(r<e){
					r=e;
				}
				e=tax_extended_price.size();
			}
		}
	}
	tax_extended_price.setElementAt(""+(new Double(tax_extended_price.elementAt(indexOfMax).toString()).doubleValue()+difference),indexOfMax);
	if(new Double(tax_setup).doubleValue()>0){
		tax_qty.addElement("1");
		tax_extended_price.addElement(""+new Double(tax_setup).doubleValue());
		temp_total=temp_total+new Double(tax_setup).doubleValue();
		isTaxable.addElement("true");
	}
	if(new Double(tax_freight).doubleValue()>0){
		tax_qty.addElement("1");
		tax_extended_price.addElement(""+new Double(tax_freight).doubleValue());
		temp_total=temp_total+new Double(tax_freight).doubleValue();
		if(!istaxstate && (product_id.equals("GCP")||product_id.equals("GE")||product_id.equals("ELM"))){
			isTaxable.addElement("false");
			//if(product_id.equals("GCP"){
			//out.println("Freight is not taxable<BR>");
		}
		else{
			//out.println("Freight is taxable<BR>");
			isTaxable.addElement("true");
		}
	}

	if(new Double(tax_handling).doubleValue()>0){
		tax_qty.addElement("1");
		tax_extended_price.addElement(""+new Double(tax_handling).doubleValue());
		temp_total=temp_total+new Double(tax_handling).doubleValue();
		if(!istaxstate && product_id.equals("IWP")){
			//out.println("Handling is not taxable<BR>");
			isTaxable.addElement("false");
		}
		else{
			//out.println("Handling is taxable<BR>");
			isTaxable.addElement("true");

		}

	}
	for(int www=0; www<tax_extended_price.size(); www++){
		tax_unit_price.addElement(""+new Double(tax_extended_price.elementAt(www).toString()).doubleValue()/new Double(tax_qty.elementAt(www).toString()).doubleValue());
		//out.println(tax_extended_price.elementAt(www).toString()+"::"+tax_qty.elementAt(www).toString()+"::<BR>");
		taxtotalprice=taxtotalprice+new Double(tax_unit_price.elementAt(www).toString()).doubleValue()*new Double(tax_qty.elementAt(www).toString()).doubleValue();
	}
	for(int q=0;q<tax_extended_price.size(); q++){
		String tempoverage="";
		String tempsetup="";
		String temphandling="";
		String tempfreight="";

		if(new Double(tax_overage).doubleValue()>0){
			//out.println(tax_overage+"::"+tax_extended_price.elementAt(q).toString()+"::"+taxtotalprice+":::"+(new Double(tax_extended_price.elementAt(q).toString()).doubleValue()/taxtotalprice)+"::<BR>");
			tempoverage=""+new Double(tax_overage).doubleValue()*(new Double(tax_extended_price.elementAt(q).toString()).doubleValue()/taxtotalprice);
			//out.println(tempoverage+"::<BR>");
			tax_overage_line.addElement(""+df2.format(new Double(tempoverage).doubleValue()));
		}
		else{
			tax_overage_line.addElement("0");
		}



	}

	double temp1=0;
	double temp2=0;
	double temp3=0;
	double temp4=0;
	double temp5=0;
	double testgreg=0;
	//out.println(temp_tax_total+"::<BR>");
	for(int e=0; e<tax_unit_price.size();e++){
		//out.println(tax_extended_price.elementAt(e).toString()+":::"+tax_overage_line.elementAt(e).toString()+":::"+tax_perc+"::<BR>");
		double temptotal=(new Double(tax_extended_price.elementAt(e).toString()).doubleValue()+new Double(tax_overage_line.elementAt(e).toString()).doubleValue())*(new Double(tax_perc).doubleValue()/100);
		//out.println(temptotal+":::<BR>");
		//out.println(isTaxable.elementAt(e).toString()+":::<BR>");
		//out.println("wait "+temp_tax_total);
		if(isTaxable.elementAt(e).toString().equals("true")){
			//out.println(tax_extended_price.elementAt(e).toString()+"::"+tax_overage_line.elementAt(e).toString()+"::"+tax_perc+"::<BR>");
			//out.println(df4.format(temptotal)+"::<BR>");
			String temptotal2=""+(temptotal*10000);
			testgreg=testgreg+new Double(df4.format(temptotal)).doubleValue();
			//out.println(testgreg+"<BR>");
			temptotal=new Double(temptotal2).doubleValue()/10000;
			temp_tax_total=temp_tax_total+new Double(temptotal).doubleValue();
		}
		else{
			
			temptotal=(new Double(tax_overage_line.elementAt(e).toString()).doubleValue())*(new Double(tax_perc).doubleValue()/100);
			String temptotal2=""+(temptotal*10000);
			testgreg=testgreg+new Double(df4.format(temptotal)).doubleValue();
			//out.println(testgreg+"<BR>");
			temptotal=new Double(temptotal2).doubleValue()/10000;
			temp_tax_total=temp_tax_total+new Double(temptotal).doubleValue();
			
		}


	}

	//out.println(temp_tax_total+"::<BR>");
	String temptotal3=""+(temp_tax_total*100);
	temp_tax_total=new Double(temptotal3).doubleValue()/100;
	tax_dollar=Float.parseFloat(df2.format(temp_tax_total));

	if(product_id.equals("LVR"))
	{
		tax_dollar = Float.parseFloat(df2.format(new Double(totprice_dis).doubleValue()*new Double(tax_perc).doubleValue()/100));
	}
	
	double tempxxx=0;
	if(product_id.equals("GCP")||product_id.equals("ELM")){
		//out.println(totprice_dis+"::"+overage+"::"+handling_cost+"::"+freight_cost+"::"+setup_cost+"::<BR>");
		//out.println(totprice_dis+"::<BR>");
		tempxxx=new Double(totprice_dis).doubleValue()+new Double(overage).doubleValue()+new Double(handling_cost).doubleValue()+new Double(freight_cost).doubleValue()+new Double(setup_cost).doubleValue();
		out.println("         tempxxx          "+tempxxx);
	}
	else if(product_id.equals("GE")){
		//out.println(tempxxx+"::aa1"+totprice_dis+"::"+handling_cost+"::<BR>");

		if(project_type==null){
			project_type="";
		}
		//out.println(totprice_dis+"::<BR>");
		if(project_type.equals("PSA")){
			tempxxx=new Double(totprice_dis).doubleValue();
		}
		else{
			tempxxx=new Double(totprice_dis).doubleValue()+new Double(overage).doubleValue()+new Double(freight_cost).doubleValue()+new Double(handling_cost).doubleValue();
			//Following line added by Srinivas for TAC# 71788
			//tempxxx=new Double(totprice_dis).doubleValue();
		}
		//out.println(tempxxx+":------>>>:aa2");
	}
	else{
//out.println(product_id+":::<BR>");
		if(product_id.equals("EFS")){
			// below changed by AC 3/11/2013 as the overage was missing for EFS rep quotes
			//tempxxx=new Double(totprice_dis).doubleValue()+new Double(setup_cost1).doubleValue()+new Double(overage).doubleValue();
			//tempxxx=new Double(totprice_dis).doubleValue()+new Double(setup_cost1).doubleValue();
			//+new Double(overage).doubleValue()+new Double(handling_cost).doubleValue()+new Double(freight_cost).doubleValue()+new Double(setup_cost).doubleValue()+new Double(setup_cost1).doubleValue();
			//changed by greg 3/14/2013
			if(isRepQuote.toLowerCase().equals("yes")){
				tempxxx=new Double(totprice_dis).doubleValue()+new Double(setup_cost1).doubleValue()+new Double(overage).doubleValue()+new Double(freight_cost).doubleValue()+new Double(handling_cost).doubleValue();
			}
			else{
				tempxxx=new Double(totprice_dis).doubleValue()+new Double(setup_cost1).doubleValue();
			}
			//end by greg
		}
		else{
			if(isRepQuote.toLowerCase().equals("yes")){
				//out.println("is rep quote <BR>");
				if(product_id.equals("IWP")){

					//out.println(totprice_dis);
					//out.println("a");
					if(secLines != null && secLines.trim().length()>0){
						//tempxxx=new Double(totprice_dis).doubleValue()+new Double(overage).doubleValue()+new Double(freight_cost).doubleValue()+new Double(setup_cost).doubleValue()+new Double(setup_cost1).doubleValue();
						tempxxx=new Double(totprice_dis).doubleValue();
					}
					else{
						tempxxx=new Double(totprice_dis).doubleValue()+new Double(handling_cost).doubleValue()+new Double(overage).doubleValue()+new Double(freight_cost).doubleValue()+new Double(setup_cost).doubleValue()+new Double(setup_cost1).doubleValue();
					}
					//out.println("TEST 222 "+tempxxx);
				}

				else{
					//out.println("TEST");
					tempxxx=new Double(totprice_dis).doubleValue();
					//+new Double(overage).doubleValue()+new Double(handling_cost).doubleValue()+new Double(freight_cost).doubleValue()+new Double(setup_cost).doubleValue()+new Double(setup_cost1).doubleValue();
				}
			}
			else{
//out.println("HERE");
				if(product_id.equals("IWP")&&!isquote.toLowerCase().equals("yes")){
					tempxxx=new Double(totprice_dis).doubleValue()+new Double(overage).doubleValue()+new Double(handling_cost).doubleValue()+new Double(setup_cost).doubleValue()+new Double(setup_cost1).doubleValue();
				}
				else if(product_id.equals("ADS")){
					tempxxx=new Double(overage).doubleValue()+new Double(handling_cost).doubleValue()+new Double(freight_cost).doubleValue()+new Double(setup_cost).doubleValue()+new Double(setup_cost1).doubleValue();


				}
				else if(product_id.equals("LVR")){
					
					tempxxx=new Double(totprice_dis).doubleValue();
				}
				else{
					tempxxx=new Double(totprice_dis).doubleValue()+new Double(overage).doubleValue()+new Double(handling_cost).doubleValue()+new Double(freight_cost).doubleValue()+new Double(setup_cost).doubleValue()+new Double(setup_cost1).doubleValue();
				//out.println("<BR> HERE in if "+totprice_dis+"<BR>");
				
				}
			}
		}
	}
	//out.println(tempxxx+"::Dilip1<BR>");

	//if((product_id.equals("IWP")||product_id.equals("EJC"))&&!isRepQuote.toLowerCase().equals("yes")){
	if((product_id.equals("EJC"))&&!isRepQuote.toLowerCase().equals("yes")){
		tempxxx=new Double(totprice_dis).doubleValue();
	}
	//out.println(tempxxx+"::2<BR>");
	//out.println(product_id+"::here<BR>");
/*
	if(product_id.equals("ADS")){
		String tempprice="";
		ResultSet rsb2 = stmt.executeQuery("SELECT linePrice FROM cs_ads_price_calc WHERE order_no='"+ order_no +"' and model='GLOBAL'");
		if(rsb2 != null){
			while(rsb2.next()){
				tempprice=rsb2.getString(1);
			}
		}
		rsb2.close();
		if(tempprice != null && tempprice.trim().length()>0){
			tempxxx=tempxxx+new Double(tempprice).doubleValue();
		}
		
		
		String temptotal3x=""+((new Double(tax_perc).doubleValue()/100)*tempxxx);
		temp_tax_total=new Double(temptotal3x).doubleValue();
		tax_dollar=Float.parseFloat(df2.format(temp_tax_total));
	}
*/

	if (grandtotalforsec.trim().length()>0 && new Double(grandtotalforsec).doubleValue()>0&& !grandtotalforsec.equals(totprice_dis)){
		for(int q=0;q<tax_extended_price.size(); q++){
			String tempoverage="";
			String tempsetup="";
			String temphandling="";
			String tempfreight="";
			if(new Double(tax_overage).doubleValue()>0){
				tempoverage=""+new Double(tax_overage).doubleValue()*(new Double(tax_extended_price.elementAt(q).toString()).doubleValue()/new Double(grandtotalforsec).doubleValue());
				tax_overage_line2.addElement(""+df2.format(new Double(tempoverage).doubleValue()));
			}
			else{
				tax_overage_line2.addElement("0");
			}
			if(new Double(tax_setup).doubleValue()>0){
				tempsetup=""+new Double(tax_setup).doubleValue()*(new Double(tax_extended_price.elementAt(q).toString()).doubleValue()/new Double(grandtotalforsec).doubleValue());
				tax_setup_line2.addElement(""+df2.format(new Double(tempsetup).doubleValue()));
			}
			else{
				tax_setup_line2.addElement("0");
			}
			if(new Double(tax_freight).doubleValue()>0){
				tempfreight=""+new Double(tax_freight).doubleValue()*(new Double(tax_extended_price.elementAt(q).toString()).doubleValue()/new Double(grandtotalforsec).doubleValue());
				tax_freight_line2.addElement(""+df2.format(new Double(tempfreight).doubleValue()));
			}
			else{
				tax_freight_line2.addElement("0");
			}
			if(new Double(tax_handling).doubleValue()>0){
				temphandling=""+new Double(tax_handling).doubleValue()*(new Double(tax_extended_price.elementAt(q).toString()).doubleValue()/new Double(grandtotalforsec).doubleValue());
				tax_handling_line2.addElement(""+df2.format(new Double(temphandling).doubleValue()));
			}
			else{
				tax_handling_line2.addElement("0");
			}
		}

		for(int e=0; e<tax_unit_price.size();e++){

			double temptotal=(new Double(tax_extended_price.elementAt(e).toString()).doubleValue()+new Double(tax_overage_line2.elementAt(e).toString()).doubleValue()+new Double(tax_setup_line2.elementAt(e).toString()).doubleValue()+new Double(tax_freight_line2.elementAt(e).toString()).doubleValue()+new Double(tax_handling_line2.elementAt(e).toString()).doubleValue())*(new Double(tax_perc).doubleValue()/100);
			String temptotal2=""+(temptotal*10000);
			temptotal=new Double(temptotal2).doubleValue()/10000;
			temp_tax_total=temp_tax_total+new Double(temptotal).doubleValue();

		}

		String temptotal3x=""+(temp_tax_total*100);
		temp_tax_total=new Double(temptotal3x).doubleValue()/100;
		if(!((product_id.equals("IWP")||product_id.equals("EFS"))&&isRepQuote.toLowerCase().equals("yes"))){
			tempxxx=new Double(totprice_dis).doubleValue();
		}
		//out.println(tempxxx+"::3<BR>");



	}
	float f;

	//if(product_id.equals("ADS")){
	//	f = Float.parseFloat(""+df0.format(tempxxx));
	//	String taxtemp=""+tax_dollar;
	//	tax_dollar=Float.parseFloat(df0.format(new Double (taxtemp).doubleValue()));
	//}
	//else
if(product_id.equals("IWP")){
	//out.println(tempxxx+"::tempxxxx<BR>");
		if(project_type.equals("SFDC")){
		//	f = Float.parseFloat(""+df0.format(tempxxx+new Double(tax_handling).doubleValue()));
//changed Oct 28 2015 as per Jim.  Freight was getting double added to quote number a22498_00
			//f = Float.parseFloat(""+df0.format(tempxxx+new Double(tax_handling).doubleValue()+new Double(tax_freight).doubleValue()));
f = Float.parseFloat(""+df0.format(tempxxx));
// end changed
}
		else{
			f = Float.parseFloat(""+df0.format(tempxxx));
		}
	}
	else if(product_id.equals("ADS")){
		f=Float.parseFloat(""+totprice_dis);
	}
	else if(product_id.equals("GE")){
		//f = Float.parseFloat(""+(tempxxx+new Double(tax_freight).doubleValue()+new Double(tax_overage)));
		f = Float.parseFloat(""+tempxxx);
	}
	else{
		f = Float.parseFloat(""+tempxxx);
		//out.println(tempxxx+"::");
	}

	//out.println(f+"::"+tax_dollar);
	grand_total=f+tax_dollar;
//out.println("HERE2 ------>>   "+f);
}

else if(product_id.equals("ADS")){
	//out.println("HERE2");
	//grand_total=Float.parseFloat(""+(totprice_dis+tax_dollar));
}
//out.println(tax_dollar+":------>>> :"+totprice_dis+"::3");
//if (!(tax_perc==null||tax_perc.equals("0"))){
//out.println(tax_perc+"::<BR>");
if (!(tax_perc==null||tax_perc.equals("0")||new Double(tax_perc).doubleValue()<=0)){
	//out.println(grand_total+" grand::<BR>");
	if(isquote.toLowerCase().equals("yes")){
		//out.println("HERE1");
		if(product_id.equals("ADS")){
			out.println("<table cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
			out.println("<td class='maindesc' width='50%' valign='middle'><b>Tax Only:(Tax %: "+tax_perc+")</b></td>");
			out.println("<td class='maindesc' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>"+for1.format(tax_dollar)+"</font>&nbsp;"+currencyName+"</b></td>");
			out.println("</tr>");
			out.println("</table>");
			out.println("<table cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
			out.println("<td class='maindesc' width='50%' valign='middle'><b>Material and Tax Only </b></td>");
			out.println("<td class='maindesc' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(grand_total)+"</font>&nbsp;"+currencyName+"</b></td>");
			out.println("</tr>");
			out.println("<tr><td class='maindesc' colspan='2' valign='middle'>Price is FOB plant, freight prepaid (to jobsite) within continental U.S. or FAS dock export point.</td></tr>");

		} else{


			out.println("<table class='tableline_iwp' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
			out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Tax Only:(Tax %: "+tax_perc+")</b></td>");
			out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>"+for1.format(tax_dollar)+"</font>&nbsp;"+currencyName+"</b></td>");
			out.println("</tr>");
			out.println("</table>");
			out.println("<table class='tableline_iwp' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
			if(product_id.equals("IWP")){
				out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Total test: </b></td>");
			}
			else if(!product_id.equals("GE")){
				out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material and Tax Only </b></td>");
			}
			else{
				//out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material, Freight and Tax Only </b></td>");
				out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Quote Total test: </b></td>");
			}
			out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(grand_total)+"</font>&nbsp;"+currencyName+"</b></td>");
			out.println("</tr>");
			if(!product_id.equals("GE")){
				if(product_id.equals("ELM")){
					out.println("<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB plant.</td></tr>");
				}
				else if(product_id.equals("GCP")){
					out.println("<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB plant. Freight not included. Tax not included. </td></tr>");
				}
				else{
					out.println("<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB plant, freight prepaid (to jobsite) within continental U.S. or FAS dock export point.</td></tr>");
				}
			}
			out.println("</table>");
		}
	}
	else if(isRepQuote.toLowerCase().equals("yes")){
		out.println("<table class='tableline_iwp' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
		out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Tax Only:(Tax %: "+tax_perc+")</b></td>");
		out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>"+for1.format(tax_dollar)+"</font>&nbsp;"+currencyName+"</b></td>");
		out.println("</tr>");
		out.println("</table>");
		out.println("<table class='tableline_iwp' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");

		if(product_id.equals("GE")){
			out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Quote Total: </b></td>");
		}
		else if(product_id.equals("IWP")){
			out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Total: </b></td>");
		}
		else{
			out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material and Tax Only </b></td>");
		}
		out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(grand_total)+"</font>&nbsp;"+currencyName+"</b></td>");
		out.println("</tr>");
		if(!product_id.equals("GE")){
			if(product_id.equals("ELM")){
				out.println("<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB plant.</td></tr>");
			}
			else if(product_id.equals("GCP")){
				out.println("<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB plant. Freight not included. Tax not included. </td></tr>");
			}
			else{
				out.println("<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB plant, freight prepaid (to jobsite) within continental U.S. or FAS dock export point.</td></tr>");
			}
		}
		out.println("</table>");
	}
	else{


		if(product_id.equals("EFS")){

			out.println("<table class='tableline' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
			out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Tax Only:(Tax %: "+tax_perc+")</b></td>");
			out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>$"+df0.format(tax_dollar)+"</font>&nbsp;"+currencyName+"</b></td>");
			out.println("</tr>");
			out.println("</table>");
			out.println("<table class='tableline' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
			if(product_id.equals("IWP")){
				out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Total: </b></td>");
			}
			else{
				out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material and Tax Only </b></td>");
			}
			out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>$"+df0.format(grand_total)+"</font>&nbsp;"+currencyName+"</b></td>");
			out.println("</tr>");

		}
		else{
			//out.println("HERE2>");
			out.println("<table class='tableline' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
			out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Tax Only:(Tax %: "+tax_perc+")</b></td>");
			out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b><font class='totprice'>"+for1.format(tax_dollar)+"</font>&nbsp;"+currencyName+"</b></td>");
			out.println("</tr>");
			out.println("</table>");
			out.println("<table class='tableline' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
			if(product_id.equals("IWP")){
				out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Total : </b></td>");
			}
			else{
				out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material and Tax Only </b></td>");
			}
			out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(grand_total)+"</font>&nbsp;"+currencyName+"</b></td>");
			out.println("</tr>");
		}
		if(!product_id.equals("GE")){
			if(product_id.equals("ELM")){
				out.println("<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB plant.</td></tr>");
			}
			else{
				out.println("<tr><td class='tableline_row mainbody' colspan='2' valign='middle'>Price is FOB plant, freight prepaid (to jobsite) within continental U.S. or FAS dock export point.</td></tr>");
			}
		}
		out.println("</table>");
	}
}

stmt.close();
myConn.close();
stmtRepData.close();
myConnRepData.close();
}
catch(Exception e){
	out.println("summary tax.jsp:: error:::"+e);
}
%>