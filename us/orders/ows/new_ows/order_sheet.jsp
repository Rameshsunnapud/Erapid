
<%
try{


%>
<%@ page language="java" import="java.sql.*" import="java.text.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>

<%@ include file="db_con.jsp"%>

<%


String orderNo=request.getParameter("orderNo");
String userId=request.getParameter("userId");
String productIdValue=request.getParameter("product");
String environment=request.getParameter("environment");
String order_sheet_url = request.getParameter("order_sheet_url");


%>

<script type="text/javascript"> 
			
			function closeOrdersheet(url)
			{
				alert('Order transfer is successfully. We are opening order document for you.'+url);
				 window.location.href=url;
			}
</script>
<%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
logger.debug("1");
//out.println(userSession.getUserId());
String name="";
String numSec="";
String  siValue = "";
String sectionString = "";
String extra_order_notes="";
double sectionTotal=0;
String rep_no=request.getParameter("rep_no");
	name=request.getParameter("currentUser");	
	siValue = request.getParameter("si");
	sectionString = request.getParameter("sections");
	Character lastChar = sectionString.charAt(sectionString.length() - 1);	
	if(",".equals(lastChar.toString())){
		logger.debug("sections value constains comma ");
	}else{
		sectionString = sectionString+",";
	}
	String bpcsTransferSheet = request.getParameter("bpcsTransferSheet"); 	
	
 String order_rep="";
 String terr_rep="";
 String spec_rep="";


String userName="";
String userGroup="";

//out.println("rep_no value is : "+rep_no+"userId value is : "+userId);

if(rep_no != null && rep_no.trim().length()>0 && userId != null && userId.trim().length()>0){

	ResultSet rsUserName=stmt.executeQuery("select rep_name,group_id from cs_reps where rep_no='"+rep_no+"' and user_id='"+userId+"'");
	if(rsUserName != null){
		while(rsUserName.next()){
			if(rsUserName.getString(1) != null){
				userName=rsUserName.getString(1);
				userGroup=rsUserName.getString(2);
			}
		}

	}

}
else if(name != null && name.trim().length()>0){
	ResultSet rsUserName=stmt.executeQuery("select rep_name,group_id from cs_reps where user_id='"+name+"'");
	if(rsUserName != null){
		while(rsUserName.next()){
			if(rsUserName.getString(1) != null){
				userName=rsUserName.getString(1);
				userGroup=rsUserName.getString(2);
			}
		}

	}
}
if((userName == null || userName.trim().length()<1) && rep_no != null && rep_no.trim().length()>0 ){
	ResultSet rsUserName=stmt.executeQuery("select rep_name,group_id from cs_reps where rep_no='"+rep_no+"'");
	if(rsUserName != null){
		while(rsUserName.next()){
			if(rsUserName.getString(1) != null){
				userName=rsUserName.getString(1);
				userGroup=rsUserName.getString(2);
			}
		}

	}
}
String nonconfigDesc="";
String nonconfigPRICE="";
String sections=request.getParameter("sections");
Character lastCharecter = sections.charAt(sections.length() - 1);	
if(",".equals(lastCharecter.toString())){
	logger.debug("sections value constains comma ");
}else{
	sections = sections+",";
}
String[] sectionsRequested={};

String sections2=sections;
if(sections2 != null && sections2.trim().length()>0){
	if(sections2.contains(","))
	{
	sectionsRequested=sections2.split(",");
	}
	if(sections2.endsWith(",")){
		sections2=sections2.substring(0,sections2.length()-1);
	}
}
String product="";
String order_no=request.getParameter("orderNo");


String Project_name="";
String Job_loc="";
String project_state="";
int line=0;
String handling_cost="";
String setup_cost="";
String freight_cost="";
String overage="";
String totmat_price="";
String commission="";
String gross_margin="";
Vector items= new Vector();
int v=0;
String project_type="";
boolean isGood=true;
Vector sectionLine=new Vector();
String secGroup="";
String queryLines="";
String secOverage="";
String secSetup="";
String secHandling="";
String secFreight="";
String quote_origin="";String tax_perc = "";
		double totmatsales=0;
		double confCurrentLine=0.0;
		double confAllLines=0.0;

		ResultSet rs_project = stmt.executeQuery("SELECT * FROM cs_project where Order_no like '"+order_no+"' ");
		if (rs_project !=null) {
			while (rs_project.next()) {
				product=rs_project.getString("product_id");
				if(rep_no==null || rep_no.trim().length()==0 || rep_no.equals("null")){
					rep_no=rs_project.getString("creator_id");
				}

quote_origin= rs_project.getString("quote_origin");
				totmat_price=rs_project.getString("configured_price");
				// out.println(totmat_price+" TOTAL PRICE");
				Project_name= rs_project.getString("Project_name");
				Job_loc= rs_project.getString("Job_loc");
				overage= rs_project.getString("overage");
				freight_cost= rs_project.getString("freight_cost");
				handling_cost= rs_project.getString("handling_cost");
				nonconfigDesc=rs_project.getString("non_config_desc");
				nonconfigPRICE=rs_project.getString("configured_price");
				//out.println(nonconfigPRICE);
				setup_cost= rs_project.getString("setup_cost");
				project_state= rs_project.getString("project_state");
				commission= rs_project.getString("commission");
				project_type=rs_project.getString("project_type");
				gross_margin=rs_project.getString("gross_margin");
				tax_perc=rs_project.getString("tax_perc");
			}
						   //}
		}
		rs_project.close();
if(tax_perc==null || tax_perc.trim().length()<1){
	tax_perc="0";
}

//Vikas
String roundingQuery = "select numDecimals from cs_rounding where product_id='"+product+"' and project_type='"+project_type+"'";
int numDecimals = 0;
ResultSet csRoundingRS=stmt.executeQuery(roundingQuery);
if(csRoundingRS != null){
	while(csRoundingRS.next()){
		numDecimals = csRoundingRS.getInt("numDecimals");
	}
}
csRoundingRS.close();


String email_rep_group="";
ResultSet rsLogiaUsers=stmt.executeQuery("select group_id from cs_reps where rep_no='"+rep_no+"'");
if(rsLogiaUsers != null){
	while(rsLogiaUsers.next()){
		email_rep_group=rsLogiaUsers.getString(1);
	}
}
rsLogiaUsers.close();
if(userGroup==null || userGroup.trim().length()==0){
	userGroup=email_rep_group;
}
		if(product.equals("ADS")&&(totmat_price==null || totmat_price.trim().length()==0)){
			ResultSet rsADSprice=stmt.executeQuery("select lineprice from cs_ads_price_calc where order_no='"+order_no+"' and model='global'");
			if(rsADSprice != null){
				while(rsADSprice.next()){
					totmat_price=rsADSprice.getString(1);
				}
			}
			rsADSprice.close();
		}


		// out.println(totmat_price);
		if(project_type == null || project_type.trim().length()<=0){
			project_type="";
		}
		if(totmat_price == null || totmat_price.trim().length()<1){
			totmat_price="0";
		}
		if(overage == null || overage.trim().length()<1){
			overage="0";
		}
		if(freight_cost == null || freight_cost.trim().length()<1){
			freight_cost="0";
		}
		if(handling_cost == null || handling_cost.trim().length()<1){
			handling_cost="0";
		}
		if(setup_cost == null || setup_cost.trim().length()<1){
			setup_cost="0";
		}

		totmatsales=new Double(overage).doubleValue()+new Double(freight_cost).doubleValue()+new Double(handling_cost).doubleValue()+new Double(setup_cost).doubleValue();

		if(totmatsales!=0){
			totmat_price=""+(new Double(totmat_price).doubleValue()+totmatsales);

		}


if(sections != null && sections.equals("all")){
     String secGroup2="";
     String secTransfer="";

     ResultSet rsSection=stmt.executeQuery("select * from cs_quote_sections where order_no like '"+order_no+"'");
     if(rsSection != null){
		 while(rsSection.next()){
			secGroup2=rsSection.getString("section_group");			
			secTransfer=rsSection.getString("section_transfer");
			secOverage=rsSection.getString("overage");
			secSetup=rsSection.getString("setup_cost");
			secHandling=rsSection.getString("handling_cost");
			secFreight=rsSection.getString("freight_cost");
			//out.println(secGroup+"<BR>");
			numSec=rsSection.getString("sections");
			//out.println(numSec+" HERE XX");
		 }
	 }
	 rsSection.close();
	
	 Vector sectionTransfered=new Vector();
	if(secTransfer == null){
		isGood=false;
		secTransfer="";
	}



	 if(secTransfer != null || secTransfer.trim().length()<=0){
		 
		 int g=0;
		while(secTransfer.length()>0 && g<1000){
			int start=secTransfer.indexOf(";");
			 if(start>=0){
				String sec=secTransfer.substring(0,start);
				secTransfer=secTransfer.substring(start+1);
				int start2=sec.indexOf("=");
				if(start2>=0){
					sec=sec.substring(0,start2);
					sectionTransfered.addElement(sec);
				}
			 }
			 g++;
		 }

	 }
	 else{
		 isGood=false;
	 }

	 if(secGroup2 != null){
		
		 int g=0;
		 while(secGroup2.length()>0 && g<1000){
			// out.println(secGroup2+"<BR>");
			 int start=secGroup2.indexOf(";");
			 if(start>=0){
					String group=secGroup2.substring(0,start);
					secGroup2=secGroup2.substring(start+1);
					int start2=group.indexOf("=");
					if(start2>=0){
						for(int r=0; r<sectionTransfered.size(); r++){
							//out.println(group.substring(start2+1)+"::"+sectionTransfered.elementAt(r).toString()+"::<BR>");
							//if(group.substring(start2+1).equals(sectionTransfered.elementAt(r).toString())){
								queryLines=queryLines+group.substring(0,start2)+",";
							//}
						}
					}
			 }
			 g++;
		 }
	 }
	 else{
		 isGood=false;
	 }

	 
}
else if(sections != null && sections.trim().length()>0){
	
	ResultSet rsSections=stmt.executeQuery("Select * from cs_quote_sections where order_no like '"+order_no+"'");
	if(rsSections != null){
		while(rsSections.next()){
			secGroup=rsSections.getString("section_group");
			secOverage=rsSections.getString("overage");
			secSetup=rsSections.getString("setup_cost");
			secHandling=rsSections.getString("handling_cost");
			secFreight=rsSections.getString("freight_cost");
			//out.println(secGroup+"<BR>");
			numSec=rsSections.getString("sections");
			//out.println(numSec+" HERE XXx");
		}
	}
	rsSections.close();
	if(sections != null & sections.trim().length()>0){
		while(sections.trim().length()>0 && v<1000){
			int start=sections.indexOf(",");
			if(start>=0){
				sectionLine.addElement(sections.substring(0,start));
				//out.println(sections+"xx<BR>");
				sections=sections.substring(start+1);
				//out.println(sections+"xx<BR>");
			}
			v++;
		}
	}
	else{
		isGood=false;
	}
	int vv=0;

	if(secGroup != null & secGroup.trim().length()>0){
		while(secGroup.trim().length()>0 && vv<1000){
			int semi=secGroup.indexOf(";");
			if(semi >=0){
			String test=secGroup.substring(0,semi);
			secGroup=secGroup.substring(semi+1);
				//out.println(test+"test<BR>");
				for(int h=0; h<sectionLine.size();h++){
					int test2=test.indexOf("=");

					if(test2>=0){
						String test3=test.substring(test2+1);
						//out.println(sectionLine.elementAt(h).toString()+"::"+test3+"here::<BR>");
						if(test3.equals(sectionLine.elementAt(h).toString())){
							
							queryLines=queryLines+test.substring(0,test2)+",";
						}
					}
				}
			}
		vv++;
		}
	}
	else{
		isGood=false;
	}



}


if(sections2 == null || !isGood || sections2.trim().length()<=0){
	ResultSet rsLines=stmt.executeQuery("Select doc_line FROM doc_line where doc_number like '"+order_no+"'");
	if(rsLines != null){
		while(rsLines.next()){
			queryLines=queryLines+rsLines.getString(1)+",";
		}
	}
}
try{
if(queryLines.trim().length()>1){
	queryLines=queryLines.substring(0,queryLines.length()-1);
//	out.println(queryLines+"query lines<BR>");

	ResultSet rs1 = stmt.executeQuery("SELECT doc_line FROM doc_line where doc_number like '"+order_no+"' and doc_line in("+queryLines+") order by cast(doc_line as integer)");
	while ( rs1.next() ) {
			items.addElement(rs1.getString("doc_line"));
		line++;
		
	}
	//ResultSet rsCSQUOTES=stmt.executeQuery("select cast(extended_price as numeric) as a1,field16 from csquotes where order_no='"+order_no+"' and line_no in ("+queryLines+")");
	
	ResultSet rsCSQUOTES=stmt.executeQuery("select extended_price,field16 from csquotes where order_no='"+order_no+"' and line_no in ("+queryLines+")");
	if(rsCSQUOTES != null){
		while(rsCSQUOTES.next()){
			if(rsCSQUOTES.getString(1) != null && rsCSQUOTES.getString(1).trim().length()>0  && rsCSQUOTES.getString(2) != null && rsCSQUOTES.getString(2).trim().length()>0){
				sectionTotal=sectionTotal+new Double(rsCSQUOTES.getString(1)).doubleValue();
				confCurrentLine=confCurrentLine+new Double(rsCSQUOTES.getString(1)).doubleValue();
				//out.println(rsCSQUOTES.getString(1)+"<BR>");
			}
		}
	}
	rsCSQUOTES.close();
	
	
	//Getting whole lines configured price to calculate section charges when they are not entered in UI
	
	ResultSet rsCSQUOTESAllLines=stmt.executeQuery("select extended_price,field16 from csquotes where order_no='"+order_no+"'");
	if(rsCSQUOTESAllLines != null){
		while(rsCSQUOTESAllLines.next()){
			if(rsCSQUOTESAllLines.getString(1) != null && rsCSQUOTESAllLines.getString(1).trim().length()>0  && rsCSQUOTESAllLines.getString(2) != null && rsCSQUOTESAllLines.getString(2).trim().length()>0){
				confAllLines=confAllLines+new Double(rsCSQUOTESAllLines.getString(1)).doubleValue();
				//out.println(rsCSQUOTESAllLines.getString(1)+"<BR>");
			}
		}
	}
	rsCSQUOTESAllLines.close();


 }
}
catch(Exception e){
	out.println("HERE "+e);
}

		//out.println("1::"+totmatsales+"::HERE::"+totmat_price+"<BR>");
		//out.println(sectionTotal+"::HERE<BR>");
//out.println(product+"::"+sections2);

double secAdder=0;
boolean isGood2=false;
if(!(product.equals("GE")||product.equals("ADS")) ){
if(sections2 != null && sections2.trim().length()>0 && ! sections2.equals("all")){
	//out.println("Test"+sections2+"::"+"Yes");
	double tempOverage=0;
	double tempSetup=0;
	double tempHandling=0;
	double tempFreight=0;
	//overage
	isGood2=false;
	if(secOverage !=null && secOverage.trim().length()>0){
		double secTotal=0;
		double totalOverage=0;
		//out.println(secOverage+":::<BR>");
		//out.println(numSec+"<BR>");
		//out.println("<BR>BEFORE</br>");
		for(int i=0; i<sectionsRequested.length; i++){
			secOverage=secOverage.substring(secOverage.indexOf(sectionsRequested[i]));
			String temp=secOverage.substring(0,secOverage.indexOf(";"));
			sectionsRequested=sections2.split(",");
			//out.println(temp.indexOf("=")+":::<BR>"+temp.length());
			if(temp.indexOf("=")<temp.length()-1){
				if(temp.startsWith(sectionsRequested[i]+"=")){
					//out.println(temp+":::<BR> 2 : "+new Double(temp.substring(temp.indexOf("=")+1)).doubleValue());
					secTotal=secTotal+new Double(temp.substring(temp.indexOf("=")+1)).doubleValue();
					tempOverage=new Double(temp.substring(temp.indexOf("=")+1)).doubleValue();
				}
				totalOverage=totalOverage+new Double(temp.substring(temp.indexOf("=")+1)).doubleValue();

			}
			else{
				secTotal=(new Double(overage).doubleValue()*(confCurrentLine/confAllLines));
				//out.println(secTotal+"::HERE<BR>");
			}
			secOverage=secOverage.substring(secOverage.indexOf(";")+1);
			//out.println(temp+":::<BR>");
			//temp=temp.substring(secOverage.indexOf(";")+1);

		}
		if(totalOverage==new Double(overage).doubleValue()){
			isGood2=true;
			secAdder=secAdder+secTotal;
		}
		//out.println("<BR>after</br>");
		//out.println(tempOverage+"<BR>");
overage=String.valueOf(secTotal);
sectionTotal=sectionTotal+secTotal;
out.println(sectionTotal+"::HERE overage addition <BR>"+overage);
	}
	
	
	//out.println("OWS-860 Tests "+secOverage);
	if(!isGood2){
		//out.println("<BR><BR><BR> DAMN<Br><BR>");
		if(overage !=null && overage.trim().length()>0){
			secAdder=secAdder+(sectionTotal/(new Double(totmat_price).doubleValue()-totmatsales))*new Double(overage).doubleValue();
			tempOverage=(sectionTotal/(new Double(totmat_price).doubleValue()-totmatsales))*new Double(overage).doubleValue();
		}
	}
	//Below line commented for GJM-227, where calculated overage is not required just price calculator overage will be considered now.
	//overage=""+tempOverage;
	//out.println(overage+"<BR>"+secAdder+"secAdder:::<BR>");
	//end overage


		//setup
		isGood2=false;
		if(secSetup !=null && secSetup.trim().length()>0){
			double secTotal=0;
			double totalSetup=0;
			for(int i=0; i<sectionsRequested.length; i++){
				secSetup=secSetup.substring(secSetup.indexOf(sectionsRequested[i]));
				String temp=secSetup.substring(0,secSetup.indexOf(";"));
				if(temp.indexOf("=")<temp.length()-1){
					if(temp.startsWith(sectionsRequested[i]+"=")){
						secTotal=secTotal+new Double(temp.substring(temp.indexOf("=")+1)).doubleValue();
						tempSetup=new Double(temp.substring(temp.indexOf("=")+1)).doubleValue();
					}
					totalSetup=totalSetup+new Double(temp.substring(temp.indexOf("=")+1)).doubleValue();

				}
					else{
				secTotal=(new Double(setup_cost).doubleValue()*(confCurrentLine/confAllLines));
				//out.println(secTotal+"::HERE<BR>");
			}
				secSetup=secSetup.substring(secSetup.indexOf(";")+1);

			}
			if(totalSetup==new Double(setup_cost).doubleValue()){
				isGood2=true;
				secAdder=secAdder+secTotal;
			}
		setup_cost=String.valueOf(secTotal);
		sectionTotal=sectionTotal+secTotal;
		out.println(secTotal+" setup addition::HERE<BR>"+setup_cost);
		}
		if(!isGood2){
			if(setup_cost !=null && setup_cost.trim().length()>0){
				secAdder=secAdder+(sectionTotal/(new Double(totmat_price).doubleValue()-totmatsales))*new Double(setup_cost).doubleValue();
				tempSetup=(sectionTotal/(new Double(totmat_price).doubleValue()-totmatsales))*new Double(setup_cost).doubleValue();
			}
		}
		
		//Below line commented for OWS-650, where calculated setup is not required just price calculator setup will be considered now.
		//setup_cost=""+tempSetup;
		//out.println(setup_cost+"<BR>"+secAdder+"secAdder:::<BR>");
		//end setup


	//handling_cost
	isGood2=false;
	out.println(confAllLines+" test 123");
	if(secHandling !=null && secHandling.trim().length()>0){
		double secTotal=0;
		double totalHanding=0;
		for(int i=0; i<sectionsRequested.length; i++){
			secHandling=secHandling.substring(secHandling.indexOf(sectionsRequested[i]));
			String temp=secHandling.substring(0,secHandling.indexOf(";"));
			if(temp.indexOf("=")<temp.length()-1){
				if(temp.startsWith(sectionsRequested[i]+"=")){
					secTotal=secTotal+new Double(temp.substring(temp.indexOf("=")+1)).doubleValue();
					tempHandling=new Double(temp.substring(temp.indexOf("=")+1)).doubleValue();
				}
				totalHanding=totalHanding+new Double(temp.substring(temp.indexOf("=")+1)).doubleValue();

			}
				else{
				secTotal=(new Double(handling_cost).doubleValue()*(confCurrentLine/confAllLines));
				//out.println(secTotal+"::HERE<BR>");
			}
			secHandling=secHandling.substring(secHandling.indexOf(";")+1);

		}
		if(totalHanding==new Double(handling_cost).doubleValue()){
			isGood2=true;
			secAdder=secAdder+secTotal;
		}
	handling_cost=String.valueOf(secTotal);
	sectionTotal=sectionTotal+secTotal;
	out.println(sectionTotal+"handling_cost addition::HERE<BR>"+handling_cost);
	}
	if(product.equals("EFS") && confAllLines>0)
	{
		double secTotal=(new Double(handling_cost).doubleValue()*(confCurrentLine/confAllLines));
		handling_cost=String.valueOf(secTotal);
	sectionTotal=sectionTotal+secTotal;
	}
	if(!isGood2){
		if(handling_cost !=null && handling_cost.trim().length()>0){
			secAdder=secAdder+(sectionTotal/(new Double(totmat_price).doubleValue()-totmatsales))*new Double(handling_cost).doubleValue();
			tempHandling=(sectionTotal/(new Double(totmat_price).doubleValue()-totmatsales))*new Double(handling_cost).doubleValue();
		}
	}
	
	//Below line commented for GJM-227, where calculated handling_cost is not required just price calculator handling_cost will be considered now.
	//handling_cost=""+tempHandling;
	//out.println(handling_cost+"<BR>"+secAdder+"secAdder:::<BR>");
	//end handling_cost
	//freight_cost
	isGood2=false;
	if(secFreight !=null && secFreight.trim().length()>0){
		double secTotal=0;
		double totalFreight=0;
		for(int i=0; i<sectionsRequested.length; i++){
			secFreight=secFreight.substring(secFreight.indexOf(sectionsRequested[i]));
			String temp=secFreight.substring(0,secFreight.indexOf(";"));
			if(temp.indexOf("=")<temp.length()-1){
				if(temp.startsWith(sectionsRequested[i]+"=")){
					secTotal=secTotal+new Double(temp.substring(temp.indexOf("=")+1)).doubleValue();
					tempFreight=new Double(temp.substring(temp.indexOf("=")+1)).doubleValue();
				}
				totalFreight=totalFreight+new Double(temp.substring(temp.indexOf("=")+1)).doubleValue();

			}
				else{
				secTotal=(new Double(freight_cost).doubleValue()*(confCurrentLine/confAllLines));
				//out.println(secTotal+"::HERE<BR>");
			}
			secFreight=secFreight.substring(secFreight.indexOf(";")+1);

		}
		if(totalFreight==new Double(freight_cost).doubleValue()){
			isGood2=true;
			secAdder=secAdder+secTotal;
		}
		freight_cost=String.valueOf(secTotal);
		sectionTotal=sectionTotal+secTotal;
		out.println(sectionTotal+"::freight addition HERE<BR>"+freight_cost);
	}
	if(!isGood2){
		if(freight_cost !=null && freight_cost.trim().length()>0){
			secAdder=secAdder+(sectionTotal/(new Double(totmat_price).doubleValue()-totmatsales))*new Double(freight_cost).doubleValue();
			tempFreight=(sectionTotal/(new Double(totmat_price).doubleValue()-totmatsales))*new Double(freight_cost).doubleValue();
		}
	}
	//Below line commented for GJM-227, where calculated freight-cost/Extra-charge is not required just price calculator extra-charge/freight-cost will be considered now.
	//freight_cost=""+tempFreight;
	//out.println(freight_cost+"<BR>"+secAdder+"secAdder:::<BR>"+sectionTotal+"<BR>");
	//sectionTotal=sectionTotal+secAdder;
			NumberFormat for13 = NumberFormat.getInstance();
		for13.setMaximumFractionDigits(0);
			
			String tempTotal=for13.format(sectionTotal);
			if(tempTotal.contains(","))
			{
				tempTotal=tempTotal.replace(",","");
			}
			//int tempTotalDouble=Integer.parseInt(tempTotal);
	totmat_price=""+for13.format(new Double(totmat_price).doubleValue());
	
	if(product.equals("EFS"))
	{
		totmat_price=""+tempTotal;
	}
	else
	{
		totmat_price=""+sectionTotal;
	}
	out.println(sectionTotal+" final total::HERE<BR>");
//out.println(sectionTotal+"::HERE<BR>");
	if(product.equals("IWP")) //removed for Production  || product.equals("EJC")
	{
		NumberFormat forIWP = NumberFormat.getInstance();
		forIWP.setMaximumFractionDigits(2);
		double tempRounding=Double.parseDouble(totmat_price)/100.0;
		String tempFormat=forIWP.format(tempRounding);
		tempRounding=Double.parseDouble(tempFormat)*100;
	totmat_price=""+forIWP.format(tempRounding);
	totmat_price=totmat_price.replace(",","");
	//out.println(totmat_price+":: test HERE<BR>");
	}

}
else{
	
	if(product.equals("EJC"))
	{
		NumberFormat forIWP = NumberFormat.getInstance();
		forIWP.setMaximumFractionDigits(2);
		sectionTotal=sectionTotal+Double.parseDouble(overage)+Double.parseDouble(freight_cost)+Double.parseDouble(handling_cost)+Double.parseDouble(setup_cost);
		String tempReplace=""+sectionTotal;
		double tempRounding=Double.parseDouble(tempReplace)/100.0;
		String tempFormat=forIWP.format(tempRounding);
		tempRounding=Double.parseDouble(tempFormat)*100;
	totmat_price=""+forIWP.format(tempRounding);
	totmat_price=totmat_price.replace(",","");
	//out.println(totmat_price+":: test HERE<BR>");
	}
	else if(product.equals("EFS"))
	{
		NumberFormat forIWP = NumberFormat.getInstance();
		forIWP.setMaximumFractionDigits(2);
		sectionTotal=sectionTotal+Double.parseDouble(overage)+Double.parseDouble(freight_cost)+Double.parseDouble(handling_cost)+Double.parseDouble(setup_cost);
		String tempReplace=""+sectionTotal;
		double tempRounding=Double.parseDouble(tempReplace)/100.0;
		String tempFormat=forIWP.format(tempRounding);
		tempRounding=Double.parseDouble(tempFormat)*100;
	totmat_price=""+forIWP.format(tempRounding);
	totmat_price=totmat_price.replace(",","");
	//out.println(totmat_price+":: test HERE<BR>");
	}
	else{
		if(!product.equals("ADS"))
		{
			if(!product.equals("GCP"))
			{
	NumberFormat for13 = NumberFormat.getInstance();
		for13.setMaximumFractionDigits(2);
		sectionTotal=sectionTotal+Double.parseDouble(overage)+Double.parseDouble(freight_cost)+Double.parseDouble(handling_cost)+Double.parseDouble(setup_cost);
	//totmat_price=""+for13.format(new Double(sectionTotal).doubleValue());
	totmat_price=""+sectionTotal;
			}
		}	
		else{
			totmat_price=totmat_price.replace(",","");
		}
	}
	//out.println(totmat_price+":: test 2 HERE<BR>");
}
}//not for GE

		//out.println("2::"+totmatsales+"::HERE"+totmat_price);
		//out.println("QueryLines--------------------------------- "+queryLines+":: number of line count: =============================== "+line);

//out.println(overage+"::");
%>
<%@ include file="order_sheet_header.jsp"%>
<%
if(product.equals("EFS")|product.equals("GE")){
%>
<%@ include file="order_sheet_efs.jsp"%>
<%
						}

if (product.equals("LVR")|product.equals("BV")){
//out.println("HER");
			double sp_factor=0;double l_cost=0;
			ResultSet myResult_factor=stmt.executeQuery("select * from cs_lvr_sp_factor where com_percent='"+commission+"' and product_id='"+product+"' ");
			if (myResult_factor !=null) {
				while (myResult_factor.next()){
				sp_factor=myResult_factor.getDouble(2);
				l_cost=myResult_factor.getDouble(3);
				out.println("spfactor : "+sp_factor);
				out.println("spfactor : "+l_cost);
				out.println("commission : "+commission);
		}
		}
		myResult_factor.close();
%>
<%@ include file="order_sheet_lvr.jsp"%>
<%
						}
if(product.equals("EJC")|product.equals("IWP")|product.equals("GE")){
%>
<%@ include file="order_sheet_iwp.jsp"%>
<%
						}
if(product.equals("GE")){
%>
<%@ include file="order_sheet_ge.jsp"%>
<%
}
if(product.equals("GCP")){
%>
<%@ include file="order_sheet_gcp.jsp"%>
<%
}
%>
<%@ include file="order_sheet_footer.jsp"%>
<%
//myConn.commit();
stmt.close();
myConn.close();
 }
  catch(Exception e){
  out.println(e);
  }
%>



























