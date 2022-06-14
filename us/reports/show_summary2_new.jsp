<link rel='stylesheet' href='style1.css' type='text/css'/>
<%   
		String order_no = request.getParameter("order_no");//Login id
		String st = request.getParameter("pid");//Summary type
		String nowc = request.getParameter("nowc");//Summary type
%>
<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="db_con.jsp"%>
<%@ include file="dbcon1.jsp"%>                        

<%   
  DecimalFormat df0 = new DecimalFormat("####");

String section_infox=""; 
String sectionsx="";
String section_groupx="";
String secOveragex="";
String secSetupx=""; 
String secHandlingx="";
String secFreightx="";
Vector secNAMES=new Vector();
Vector secLINES=new Vector();
Vector sectionOVERAGE=new Vector();
Vector sectionHANDLING=new Vector();
Vector sectionSETUP=new Vector();
Vector sectionFREIGHT=new Vector();
boolean isOVERAGE=false; 
boolean isHANDLING=false;
boolean isSETUP=false; 
boolean isFREIGHT=false;
String quote_type_alt="";
String quote_typex="";  
String prio="";

//out.println("TEst::"+st);
if(st == null || st.equals("null") || (st.equals("2")|| st.equals("3"))){

	ResultSet rsQuoteSection= stmt.executeQuery(" select * from cs_quote_sections where order_no='"+order_no+"'");
	if(rsQuoteSection != null){
		while(rsQuoteSection.next()){
			section_infox=rsQuoteSection.getString("section_info");
			sectionsx=rsQuoteSection.getString("sections");
			section_groupx=rsQuoteSection.getString("section_group");
			secOveragex=rsQuoteSection.getString("overage");
			secSetupx=rsQuoteSection.getString("setup_cost");
			secHandlingx=rsQuoteSection.getString("handling_cost");
			secFreightx=rsQuoteSection.getString("freight_cost");
		}
	}
	rsQuoteSection.close();
	if(section_infox==null){section_infox="";}
	if(sectionsx==null){sectionsx="0";}
	if(section_groupx==null){section_groupx="";}
	if(secOveragex==null){secOveragex="";}
	if(secSetupx==null){secSetupx="";}
	if(secHandlingx==null){secHandlingx="";}
	if(secFreightx==null){secFreightx="";}
}
//out.println(section_infox+"<BR>:"+sectionsx+"<BR>"+section_groupx+"<BR>"+secOveragex+"::"+secSetupx+"::"+secHandlingx+"::"+secFreightx);

if(sectionsx.trim().length()>0){
	//out.println("<BR>");
//	out.println(sectionsx+":"+sectionsx.trim().length()+"<BR>");

	int numSections=Integer.parseInt(sectionsx);
	for(int r=1; r <= numSections; r++){
		String tempSecName="s"+r+"=";
		//out.println(tempSecName+"::<BR>");

		// this is where it gets section names
		int startSec=section_infox.indexOf(tempSecName);
		if(startSec>=0){
			startSec=startSec+tempSecName.length();
			int endSec=section_infox.substring(startSec).indexOf(";")+startSec;
			if(endSec>=0){
				secNAMES.addElement(section_infox.substring(startSec,endSec));
				//out.println("<BR>::"+section_infox.substring(startSec,endSec));
			}
			else{
				secNAMES.addElement("");
			}
		}
		else{
				secNAMES.addElement("");
		}

			//out.println(secOveragex);

		// this is where it breakes up all the costs (overage,setup,handling, and freight)
		startSec=secOveragex.indexOf(tempSecName);
		if(startSec>=0){

			startSec=startSec+tempSecName.length();
			int endSec=secOveragex.substring(startSec).indexOf(";")+startSec;
			if(endSec>=0){
				//out.println("HERE2");
				sectionOVERAGE.addElement(secOveragex.substring(startSec,endSec));
				//out.println(secOveragex+"<BR>::"+secOveragex.substring(startSec,endSec));
				if(secOveragex.substring(startSec,endSec).trim().length()>0){
					isOVERAGE=true;
				}
			}
			else{
			out.println("HERE3");
				sectionOVERAGE.addElement("");         
			}
		}
		else{
				//out.println("HERE0");  
				sectionOVERAGE.addElement(""); 
		}

		// this is where it breakes up all the costs (overage,setup,handling, and freight)
		startSec=secHandlingx.indexOf(tempSecName);
		if(startSec>=0){
			startSec=startSec+tempSecName.length();
			int endSec=secHandlingx.substring(startSec).indexOf(";")+startSec;
			if(endSec>=0){
				sectionHANDLING.addElement(secHandlingx.substring(startSec,endSec));
				//out.println("<BR>::"+secHandlingx.substring(startSec,endSec));
				isHANDLING=true;
			}
			else{ 
				sectionHANDLING.addElement("");
			}
		}
		else{
				sectionHANDLING.addElement("");
		}

		// this is where it breakes up all the costs (overage,setup,handling, and freight)
		startSec=secSetupx.indexOf(tempSecName);
		if(startSec>=0){
			startSec=startSec+tempSecName.length();
			int endSec=secSetupx.substring(startSec).indexOf(";")+startSec;
			if(endSec>=0){
				sectionSETUP.addElement(secSetupx.substring(startSec,endSec));
				//out.println("<BR>::x"+secSetupx.substring(startSec,endSec));
				isSETUP=true;
			}
			else{
				sectionSETUP.addElement("");
			}
		}
		else{ 
				sectionSETUP.addElement("");
		}

		// this is where it breakes up all the costs (overage,setup,handling, and freight)
		startSec=secFreightx.indexOf(tempSecName);
		if(startSec>=0){
			startSec=startSec+tempSecName.length();
			int endSec=secFreightx.substring(startSec).indexOf(";")+startSec;
			if(endSec>=0){
				sectionFREIGHT.addElement(secFreightx.substring(startSec,endSec));
				//out.println("<BR>::"+secFreightx.substring(startSec,endSec));
				isFREIGHT=true;
			}
			else{
				sectionFREIGHT.addElement("");
			}
		}
		else{
				sectionFREIGHT.addElement("");
		}



		// this is where it gets the section lines
		String tempLines=",";
		tempSecName="=s"+r+";";
		String tempSection_groupx=section_groupx;
		//out.println(tempSection_groupx+":: original");
		for(int e=0; e<tempSection_groupx.length(); e++){
			int startq=tempSection_groupx.indexOf(tempSecName);
			if(startq>=0){
				//out.println("<BR>start<BR>"+tempSection_groupx+" HERE<BR>");
				String tempq=tempSection_groupx.substring(0,startq+tempSecName.length()-1);
				//out.println("x"+tempq+"<BR>");
				for(int w=0; w<tempq.length(); w++){
					int d=tempq.lastIndexOf(";");
					if(d>=0){
						tempq=tempq.substring(d+1);
					}
				}
				//out.println("y"+tempq+"<BR>");
				int g=tempq.indexOf("=");
				if(g>=0){
					tempq=tempq.substring(0,g);
				}
				//out.println("z"+tempq+"<BR>");

				//out.println("1x:::"+tempSection_groupx+"<BR>");
				tempSection_groupx=tempSection_groupx.substring(startq+tempSecName.length());
				//out.println("2x:::"+tempSection_groupx+"<BR>");
				tempLines=tempLines+tempq+",";
				//out.println(e+"::"+tempSection_groupx.length()+"<BR>remains: "+tempSection_groupx+"<BR>end<BR><BR>");



				if(e>=tempSection_groupx.length()){
					e=tempSection_groupx.length()-2;
				}
				//out.println(e+"::"
				//out.println(tempLines+":<BR>");


			}
			else{
				tempSection_groupx="";
			}


		}
		secLINES.addElement(tempLines);
		//out.println(tempLines+"HERE<BR><BR><BR> new line<BR>");





	}
}


int numberOfSections=0;
if(sectionsx.trim().length()>0){
	numberOfSections=Integer.parseInt(sectionsx);
}

//Project data
double safetyDollars=0;
boolean isSafetyDollars=false;
String free_exc="";
String tax_perc="0";
String free_qual="";
String user_id="";
String product="";String Project_name="";String Arch_name="";String Arch_loc="";String pid="";String era_notes="";String exc="";String qual="";
String rep_no="";String cust_no="";String overage="";String freight_cost="";String handling_cost="";String setup_cost="";String commission="";String project_type_id="";
	 	ResultSet rs_project = stmt.executeQuery("SELECT * FROM cs_project where Order_no like '"+order_no+"'");
  		if (rs_project !=null) {
        while (rs_project.next()) {
		Project_name= rs_project.getString("Project_name");
		cust_no= rs_project.getString("Cust_name");
		Arch_name= rs_project.getString("Arch_name");
		Arch_loc= rs_project.getString("Arch_loc");
		product= rs_project.getString("product_id").trim();
		era_notes= rs_project.getString("free_text");
		exc= rs_project.getString("exclusions");
		qual= rs_project.getString("qualifying_notes");
		rep_no= rs_project.getString("creator_id");
		overage= rs_project.getString("overage");
		freight_cost= rs_project.getString("freight_cost");
		handling_cost= rs_project.getString("handling_cost");
		setup_cost= rs_project.getString("setup_cost");
		pid= rs_project.getString("product_id").trim();
		commission= rs_project.getString("commission");
		project_type_id= rs_project.getString("project_type_id");
		free_exc=rs_project.getString("exclusions_free_text");
		free_qual=rs_project.getString("qualifying_notes_free_text");
		tax_perc=rs_project.getString("tax_perc");
		user_id=rs_project.getString("user_id");
		quote_type_alt=rs_project.getString("doc_type_alt");
   						    		}
							    }
							    rs_project.close();
							    if(tax_perc==null){tax_perc="0";}
		if(user_id==null){ user_id="";}

	if(setup_cost==null){setup_cost="0";}
	if(handling_cost==null){handling_cost="0";}
	if(freight_cost==null){freight_cost="0";}
	if(overage==null){overage="0";}
	if(product.endsWith("LVR")|product.equals("BV"))  {
			if(commission==null){overage="0";commission="15";}
	}
if(free_exc != null){
for(int rr=0; rr<free_exc.length(); rr++){
	if((int)free_exc.charAt(rr)==10){
		free_exc=free_exc.substring(0,rr)+"<BR>"+free_exc.substring(rr);
		rr=rr+4;
	}
}
}
if(free_qual != null){
for(int rr=0; rr<free_qual.length(); rr++){
	if((int)free_qual.charAt(rr)==10){
		free_qual=free_qual.substring(0,rr)+"<BR>"+free_qual.substring(rr);
		rr=rr+4;
	}
}
}
if(era_notes != null){
for(int rr=0; rr<era_notes.length(); rr++){
	if((int)era_notes.charAt(rr)==10){
		era_notes=era_notes.substring(0,rr)+"<BR>"+era_notes.substring(rr);
		rr=rr+4;
	}
}
}
String cust_name1="";String cust_addr1="";String cust_addr2="";String city="";String state="";String zip_code="";String ccode="";
//Customer data
//if (cust_no.length()>4){cust_no=cust_no.substring(2);}
					ccode=cust_no.substring(0,2);
			        if ((ccode.equals("GB"))|(ccode.equals("US"))) {
					cust_no=cust_no.substring(2);
					}
					else {
					ccode="US";
					}


	 	ResultSet rs_customers = stmt.executeQuery("SELECT * FROM cs_customers where cust_no like '"+cust_no+"' and country_code='US' ");
  		if (rs_customers !=null) {
        while (rs_customers.next()) {
		cust_name1= rs_customers.getString("cust_name1");
		cust_addr1= rs_customers.getString("cust_addr1");
		cust_addr2= rs_customers.getString("cust_addr2");
		city= rs_customers.getString("city");
		state= rs_customers.getString("state");
		zip_code= rs_customers.getString("zip_code");
								  }
								  }
								  rs_customers.close();
//								  out.println("The Overage"+overage);
String rep_account="";String address1="";String address2="";String rep_city="";String rep_state="";String rep_zip_code="";
String rep_telephone="";String rep_fax="";String rep_email="";
//out.println(user_id);
	 	ResultSet rs_reps = stmt.executeQuery("SELECT * FROM cs_reps where rep_no like '"+rep_no+"' and (user_id is null or user_id='"+user_id+"') order by user_id");
  		if (rs_reps !=null) {
        while (rs_reps.next()) {
		rep_account= rs_reps.getString("rep_account");
		address1= rs_reps.getString("address1");
		address2= rs_reps.getString("address2");
		rep_city= rs_reps.getString("rep_city");
		rep_state= rs_reps.getString("state");
		rep_zip_code= rs_reps.getString("zip");
		rep_telephone= rs_reps.getString("telephone");
		rep_fax= rs_reps.getString("fax");
		rep_email= rs_reps.getString("email");
								  }
								  }
								  rs_reps.close();
//dates
String edate="";String odate="";
String priority="";
 	ResultSet rs_eorders = stmt.executeQuery("SELECT doc_date,entry_date,doc_priority,doc_type FROM doc_header where doc_number like '"+order_no+"'");
  		if (rs_eorders !=null) {
        while (rs_eorders.next()) {
		odate= rs_eorders.getString(1).substring(0,10);
		edate= rs_eorders.getString(2).substring(0,10);
		priority=rs_eorders.getString(3);
		//quote_typex=rs_eorders.getString(4);
								  }
								}
								quote_typex=priority;
								rs_eorders.close();
//the csquotes table        
 
		int tot_lines=0;double totprice=0;double factor=0;double totprice_dis=0;String description="";double tot_sum=0;
		double com_perc=0;int line=0;String quan="";String mark="";double totcomm_dol=0;String um="";String mark_up="";String comm_perct="";
		String esc="";String cost_line="";String part_no="";String weight="";String part_no2="";double tot_cost=0;double tot_weight=0;
		Vector items=new Vector();
		Vector codes=new Vector();//to get the prod_code
		Vector QTY=new Vector();
		Vector price=new Vector();
		Vector line_item=new Vector();   
		Vector desc=new Vector();Vector seq_no=new Vector();
		Vector block_id=new Vector();Vector rec_no=new Vector();
		Vector fact_per=new Vector();Vector mark_no=new Vector();Vector config_string=new Vector();
		String query_string="";Vector std_cost=new Vector();Vector run_cost=new Vector();
		Vector setup_cost1=new Vector();Vector discount=new Vector();Vector bpcs_qty=new Vector();Vector bpcs_um=new Vector();
		Vector lgth=new Vector();Vector wdth=new Vector();Vector color=new Vector();Vector bpcs_part_no=new Vector();Vector bpcs_part_no2=new Vector();
		Vector price_flag = new Vector();
		//Vector field20 = new Vector();
		Vector field18=new Vector(); Vector field20=new Vector();

		query_string="SELECT *,cast(extended_price as decimal) as x1 FROM csquotes WHERE order_no = '"+order_no+"' ORDER BY prod_code,cast(Line_no as integer),block_id";
		ResultSet rs3 = stmt.executeQuery(query_string);
        while ( rs3.next() ) {
        	if(rs3.getString("block_id").equals("A_APRODUCT")){
			if(!product.equals("GCP"))  {
				tot_weight=tot_weight+rs3.getDouble("weight");
			}
			//out.println(tot_weight+"::<BR>");
        	}
		line_item.addElement(rs3.getString ("Line_no").trim()); 
		desc.addElement(rs3.getString ("Descript"));
		if(product.equals("EJC")||product.equals("IWP")){
			price.addElement(rs3.getString ("x1").trim());
			//out.println(rs3.getString("x1")+"<BR>");
	    		tot_sum=tot_sum+new Double(rs3.getString("x1")).doubleValue();
	    		//out.println(tot_sum+"-::<BR>");
	    	}
	    	else{
			price.addElement(rs3.getString ("Extended_Price").trim());
	    		tot_sum=tot_sum+new Double(rs3.getString("Extended_Price")).doubleValue();
	    	}
		rec_no.addElement(rs3.getString("Record_no"));
		block_id.addElement(rs3.getString("Block_ID"));
		seq_no.addElement(rs3.getString("Sequence_no"));
		QTY.addElement(rs3.getString("QTY"));
		field18.addElement(rs3.getString("field18"));
		field20.addElement(rs3.getString("field20"));
		fact_per.addElement(rs3.getString("field16").trim());
		mark_no.addElement(rs3.getString("field17"));
		discount.addElement(rs3.getString("field19"));
		run_cost.addElement(rs3.getString("run_cost"));
		if(rs3.getString("std_cost") != null && rs3.getString("std_cost").trim().length()>0){
			std_cost.addElement(rs3.getString("std_cost").trim());
		} 
		else{
			std_cost.addElement("0");
		}
		setup_cost1.addElement(rs3.getString("setup_cost"));
		bpcs_part_no2.addElement(rs3.getString("stock"));
		if(rs3.getString("lgth") != null){
		lgth.addElement(rs3.getString("lgth"))		;
		}
		else{
			lgth.addElement("");
		}
		price_flag.addElement(rs3.getString("price_flag"));
		wdth.addElement(rs3.getString("wdth"));
		color.addElement(rs3.getString("color"));
		if(rs3.getString("bpcs_part_no") != null){
			bpcs_part_no.addElement(rs3.getString("bpcs_part_no"));       
		}
		else{
			bpcs_part_no.addElement("");
		}
		if(rs3.getString("bpcs_qty") != null && rs3.getString("bpcs_qty").trim().length()>0){
			bpcs_qty.addElement(rs3.getString("bpcs_qty"));
		}
		else{
			bpcs_qty.addElement("1");
		}
		if(rs3.getString("bpcs_um")!=null){
			bpcs_um.addElement(rs3.getString("bpcs_um"));
		}
		else{
			bpcs_um.addElement("");
		}
		if(rs3.getString("prod_code") != null){
			codes.addElement(rs3.getString("prod_code"));
		}
		else{
			codes.addElement("0");
		}
		tot_lines++;
       	}  

rs3.close();              
 
// Checking the no of lines
		ResultSet rs1 = stmt.executeQuery("SELECT doc_line,config_string FROM doc_line where doc_number like '"+order_no+"' order by cast(doc_line as integer)");
        while ( rs1.next() ) {
       		items.addElement(rs1.getString("doc_line").trim());
		config_string.addElement(rs1.getString("config_string"));
		//out.println("<br> 2nd query :: "+items.elementAt(line).toString());
		line++;

       	}
       	rs1.close();
//out.println(line + " HERE<br>");    
// Checking the no of lines	done           
   
//eorders for the           

ResultSet e_order = stmt.executeQuery("SELECT * FROM doc_header where doc_number like '"+order_no+"' ");
  if (e_order !=null) {
        while (e_order.next()) {
		prio= e_order.getString("doc_priority");
	}
} 
	e_order.close();                                              

NumberFormat for1 = NumberFormat.getCurrencyInstance(); 
for1.setMaximumFractionDigits(2);                
NumberFormat for4 = NumberFormat.getCurrencyInstance();     
for4.setMaximumFractionDigits(4);           
for4.setMinimumFractionDigits(4);            
NumberFormat for123 = NumberFormat.getCurrencyInstance();
for123.setMaximumFractionDigits(0);    
NumberFormat for12 = NumberFormat.getInstance();  
for12.setMaximumFractionDigits(1);
NumberFormat for12x = NumberFormat.getInstance();
for12x.setMaximumFractionDigits(0);             

	if(st.equals("3")){
		 if(nowc!=null){ 
	%>
	    <%@ include file="show_summary_header_psa_new.jsp"%> 
	<% 
		  }
		 else{    
	%>
	    <%@ include file="show_summary_header_psa.jsp"%>   
	<%
		 }      
	}    
	else{ 
		//out.println("HERE");
	%>	<%@ include file="show_summary_header.jsp"%><%
	}

if(product.equals("ADS")){  
	if( nowc != null && nowc.equals("2")){   
		%>
		<%@ include file="ads_bpcs_output_new.jsp"%>
		<%	
	}
	else{ 
	
		%>
		<%@ include file="work_copy_ads.jsp"%>
		<%  
	}
}
else if(product.equals("GCP"))  {
	%>
	<%@ include file="show_summary_body_gcp1.jsp"%>
	<%
}
else{
out.println("Summary sheet not available for "+product);
	}
if(numberOfSections<=1){
	if( (!((product.equals("ADS")| product.equals("EJC")|product.equals("IWP")|product.equals("EFS")) & (st.equals("2")|st.equals("3"))) )){%> 	  <%@ include file="show_summary_foot.jsp"%><%}
}

stmts.close();
myConns.close();
stmt.close();
//myConn.commit();
myConn.close();
%>

