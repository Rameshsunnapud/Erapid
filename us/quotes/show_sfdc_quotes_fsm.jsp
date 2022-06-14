<jsp:useBean id="erapidBean"		class="com.csgroup.general.ErapidBean"			scope="application"/>
<jsp:useBean id="convertor"		class="com.csgroup.general.Convertor"			scope="application"/>
<jsp:useBean id="quoteHeader" 	class="com.csgroup.general.QuoteHeaderBean"		scope="page"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>

<%
String canType="";
String canCustomer="";
String sfdcCountry = "";
String currencyName="";
String order_no = request.getParameter("orderNo");//Login id
		quoteHeader.setOrderNo(order_no);
String configuredPriceDB = "";
String type= request.getParameter("type");//type
String QuoteID="";
String AcctID="";
String UserID="";
String decoRep="";
String contactId="";
String contactName="";
    String addSFDC="";
    String deductSFDC="";
String group_id="";
	String psa_req_date="";
%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.text.*" import="java.sql.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="../../db_con.jsp"%>
<%@ include file="../../db_con_sfdc.jsp"%>
<%@ include file="../../dbcon1.jsp"%>
<%
	String opportunityId="";
	String opportunityId2="";
String secLines="";
String exchName="";
String country="";
String sectotalname="";
String opportunityName="";
	String psa_spec_section="";
	String psa_alternate="";
	String psa_addenda="";
	String sfdc_estimator="";
	String psa_rsm="";
	String bid_rsm="";
	String edate="";
	String project_id="";
	String psa_quote_type="";
	String psa_quote_notes="";
	String psa_type_of_quote="";
	String spec_level="";
String sfdcNotes="";
NumberFormat for0 = NumberFormat.getCurrencyInstance();
for0.setMaximumFractionDigits(0);
String tax_perc="0";
double grand_total1=0;
double grand_total_for_summary_tax_input=0.0;
double taxtotal=0;
String configured_price="";
NumberFormat for1x = NumberFormat.getInstance();
HttpSession UserSession_rep = request.getSession();
String session_group_id="";
String session_rep_no="";
String repAddress="";
//String name= UserSession1.getAttribute("username").toString();
if(UserSession_rep!=null){
	//String name= UserSession1.getAttribute("username").toString();
	if(UserSession_rep.getAttribute("rep_no") != null){
		session_rep_no= UserSession_rep.getAttribute("rep_no").toString();
	}
	if(UserSession_rep.getAttribute("usergroup") != null){
		session_group_id= UserSession_rep.getAttribute("usergroup").toString();
	}
}
if(group_id==null){
	group_id="";
}
//out.println("Testing"+"Quote_id "+QuoteID+"Order no "+order_no);

if (!(order_no==null)){

	//out.println("Testing");
	//Project data
	String product="";
	String Project_name="";
	String Arch_name="";
	String Arch_loc="";
	String section="";
	String division="";
	String free_text="";
	String exclusions="";
	String exclusions_free_text="";
	String qualifying_notes="";
	String qualifying_notes_free_text="";
	String rep_no="";
	String cust_no="";
	int exc_count=0;
	int qual_count=0;
	String section_desc="";
	String project_city="";
	String project_state="";
	String agent_name="";
	String freight_cost="";
	String projCur="";
	String overage="";
	String handling_cost="";
	String project_type="";
String sfdcAccount="";
	String Arch_state="";
	String price1="";
	String price="";
	String priceNotFormatted="";
	String rep_notes="";
	String setup_cost="";
	String carriage="";
	String commission="";
	String gross_margin="";
	String isInstall="";
	String pricing_options="";
	String pricing_options_free_text="";
	String salesForceNo="";
	String quoteSource="";
	String providerId="";
	String projectId="";
	NumberFormat for1 = NumberFormat.getCurrencyInstance();
	for1.setMaximumFractionDigits(2);
	NumberFormat for11x = NumberFormat.getCurrencyInstance();
	for11x.setMaximumFractionDigits(0);
	ResultSet rs_project = stmt.executeQuery("SELECT tax_perc,configured_price,Project_name,setup_cost,currency,Job_loc,project_state,Arch_name,Arch_loc,Agent_name,Cust_name,product_id,section,division,free_text,overage,handling_cost,freight_cost,exclusions,len(exclusions)as v1,creator_id,exclusions_free_text,qualifying_notes,len(qualifying_notes) as v2,qualifying_notes_free_text,section_desc,project_type,rep_notes,carriage_charge,commission, gross_margin, isInstall,pricing_options,pricing_options_free_text,project_type_id,sfdc_notes,rsm,sfdc_opportunity_no,quote_source,sfdc_provider,addenda,alternate,spec_section,exch_name,accountId,sfdc_country FROM cs_project where Order_no like '"+order_no+"'");
	if (rs_project !=null) {
		   while (rs_project.next()) {
exchName=rs_project.getString("exch_name");
			tax_perc=rs_project.getString("tax_perc");
			configured_price=rs_project.getString("configured_price");
			setup_cost=rs_project.getString("setup_cost");
			Project_name= rs_project.getString("Project_name");
			project_city= rs_project.getString("job_loc");
			project_state= rs_project.getString("Project_state");
			cust_no= rs_project.getString("Cust_name");
			Arch_name= rs_project.getString("Arch_name");
			Arch_loc= rs_project.getString("Arch_loc");
			agent_name= rs_project.getString("Agent_name");
			product= rs_project.getString("product_id");
			rep_no= rs_project.getString("creator_id");
			section= rs_project.getString("section");
			division= rs_project.getString("division");
			free_text= rs_project.getString("free_text");
			overage=rs_project.getString("overage");
			handling_cost=rs_project.getString("handling_cost");
			freight_cost=rs_project.getString("freight_cost");
			exclusions= rs_project.getString("exclusions");
			if(rs_project.getString("v1") != null ){
				exc_count=rs_project.getInt("v1");
			}
			else{
				exc_count=0;
			}
			exclusions_free_text= rs_project.getString("exclusions_free_text");
			if(rs_project.getString("v2") != null ){
				qual_count=rs_project.getInt("v2");
			}
			else{
				qual_count=0;
			}
			qualifying_notes= rs_project.getString("qualifying_notes");
			qualifying_notes_free_text= rs_project.getString("qualifying_notes_free_text");
			section_desc= rs_project.getString("section_desc");
			project_type= rs_project.getString("project_type");
			projCur=rs_project.getString("currency");
			rep_notes=rs_project.getString("rep_notes");
			//out.println(projCur);
			carriage=rs_project.getString("carriage_charge");
			commission = rs_project.getString("commission");
			gross_margin=rs_project.getString("gross_margin");
			isInstall=rs_project.getString("isInstall");
			pricing_options=rs_project.getString("pricing_options");
			pricing_options_free_text=rs_project.getString("pricing_options_free_text");
			salesForceNo=rs_project.getString("project_type_id");
			sfdcNotes=rs_project.getString("sfdc_notes");
			psa_rsm=rs_project.getString("rsm");
			opportunityId=rs_project.getString("sfdc_opportunity_no");
			opportunityName=rs_project.getString("project_name");
			//sfdcAccount=rs_project.getString("Account_Customer__C");
			quoteSource=rs_project.getString("quote_source");
			//psa_req_date=rs_project.getString("Quote_Requested_Date__c");
			providerId=rs_project.getString("sfdc_provider");
			psa_addenda=rs_project.getString("addenda");
			psa_alternate=rs_project.getString("alternate");
			psa_spec_section=rs_project.getString("spec_section");
			sfdcAccount=rs_project.getString("accountId");
			
		}
	}
	
	ResultSet rs_pr_obj = stmt.executeQuery("select a.creator_id, a.user_id, a.sfdc_country from cs_project a, cs_reps b where a.order_no = '"+order_no+"' and a.sfdc_country = 'Canada' and a.user_id = b.user_id and b.group_id = 'GrandE'");
	if (rs_pr_obj != null) {
		while (rs_pr_obj.next()) {
			currencyName = "USD";
		}
		rs_pr_obj.close();
	}

	if(qualifying_notes_free_text==null){
		qualifying_notes_free_text="";
	}
	if(exclusions_free_text==null){
		exclusions_free_text="";
	}
/*
	ResultSet rsSf0=stmt_sfdc.executeQuery("select * from Quotes__c where name='"+salesForceNo+"'");
	if(rsSf0 != null){
		while(rsSf0.next()){
			//opportunityName=rsSf0.getString("Opportunity_Name__c");
			//sfdcNotes=rsSf0.getString("Notes__C");
			//sfdcAccount=rsSf0.getString("Account_Customer__C");
			//quoteSource=rsSf0.getString("Quote_Scource__c");
			//projectId=rsSf0.getString("Project__c");
			psa_req_date=rsSf0.getString("Quote_Requested_Date__c");
		}
	}
	rsSf0.close();
*/
	if(psa_req_date!=null && psa_req_date.trim().length()>10){
		psa_req_date=psa_req_date.substring(0,10);
	}
	if(sfdcNotes==null||sfdcNotes.equals("null")){
		sfdcNotes="";
	}
					if(sfdcNotes != null){
						for(int rr=0; rr<sfdcNotes.length(); rr++){
							if((int)sfdcNotes.charAt(rr)==10){
								sfdcNotes=sfdcNotes.substring(0,rr)+"<BR>"+sfdcNotes.substring(rr);
								rr=rr+4;
							}
						}
					}
	if(sfdcAccount==null || sfdcAccount.equals("null")){
		sfdcAccount="";
	}

	//out.println("select * from contact where id='"+cust_no+"'<BR>"+cust_no+"::<BR>");
	String sfdcAccountId="";
	ResultSet rsSf=stmt_sfdc.executeQuery("select * from contact where id='"+cust_no+"'");
	if(rsSf != null){
		while(rsSf.next()){
			sfdcAccountId=rsSf.getString("AccountId");
			if(rsSf.getString("name")!=null && !rsSf.getString("name").equals("null") && rsSf.getString("name").trim().length()>0){
				repAddress=repAddress+rsSf.getString("name")+"<BR>";
			}
			if(rsSf.getString("Street_Name__c")!=null && !rsSf.getString("Street_Name__c").equals("null") && rsSf.getString("Street_Name__c").trim().length()>0){
				repAddress=repAddress+rsSf.getString("Street_Name__c")+"<BR>";
			}
			if(rsSf.getString("City_or_Town__c")!=null && !rsSf.getString("City_or_Town__c").equals("null") && rsSf.getString("City_or_Town__c").trim().length()>0){
				repAddress=repAddress+rsSf.getString("City_or_Town__c")+", ";
			}
			if(rsSf.getString("State_or_Province__c")!=null && !rsSf.getString("State_or_Province__c").equals("null") && rsSf.getString("State_or_Province__c").trim().length()>0){
				repAddress=repAddress+rsSf.getString("State_or_Province__c")+" ";
			}
			if(rsSf.getString("Postal_Code_or_Zip_Code__c")!=null && !rsSf.getString("Postal_Code_or_Zip_Code__c").equals("null") && rsSf.getString("Postal_Code_or_Zip_Code__c").trim().length()>0){
				repAddress=repAddress+rsSf.getString("Postal_Code_or_Zip_Code__c")+" ";
			}
			if(rsSf.getString("Country__c")!=null && !rsSf.getString("Country__c").equals("null") && rsSf.getString("Country__c").trim().length()>0){
				repAddress=repAddress+rsSf.getString("Country__c")+" ";
			}
			repAddress=repAddress+"<BR>";
			if(rsSf.getString("Phone")!=null && !rsSf.getString("Phone").equals("null") && rsSf.getString("Phone").trim().length()>0){
				repAddress=repAddress+"Phone: "+rsSf.getString("Phone")+"<BR>";
			}
			if(rsSf.getString("Fax")!=null && !rsSf.getString("Fax").equals("null") && rsSf.getString("Fax").trim().length()>0){
				repAddress=repAddress+"Fax: "+rsSf.getString("Fax")+"<BR>";
			}
			if(rsSf.getString("Email")!=null && !rsSf.getString("Email").equals("null") && rsSf.getString("Email").trim().length()>0){
				repAddress=repAddress+"Email: "+rsSf.getString("Email")+"<BR>";
			}
		}
	}
	rsSf.close();
/*
	ResultSet rsSf2=stmt_sfdc.executeQuery("select Lead_Provider_id__c from Project__c where id='"+projectId+"'");
	if(rsSf2 != null){
		while(rsSf2.next()){
			providerId=rsSf2.getString("Lead_Provider_ID__c");
		}
	}
	rsSf2.close();
*/
	if(sfdcAccountId != null && sfdcAccountId.trim().length()>0){
		ResultSet rsSfAccount=stmt_sfdc.executeQuery("select name from account where id='"+sfdcAccountId+"'");
		if(rsSfAccount != null){
			while(rsSfAccount.next()){
				repAddress=rsSfAccount.getString(1)+"<BR>"+repAddress;
			}
		}
		rsSfAccount.close();
	}
	if(sfdcAccount != null && sfdcAccount.trim().length()>0){
		ResultSet rsSfAccount2=stmt_sfdc.executeQuery("select name,street_Name__c,City_or_Town__c,State_Province__c ,Postal_Code_or_Zip_Code__c,Country__c from account where id='"+sfdcAccount+"'");
		if(rsSfAccount2 != null){
			while(rsSfAccount2.next()){
				if(rsSfAccount2.getString(1) != null && rsSfAccount2.getString(1).trim().length()>0){
					if(exchName.equals("CAD")||exchName.equals("CAN")){
						canCustomer=rsSfAccount2.getString(1)+"<BR>";
						canCustomer=canCustomer+rsSfAccount2.getString(2)+"<BR>";
						canCustomer=canCustomer+rsSfAccount2.getString(3)+","+rsSfAccount2.getString(4)+" "+rsSfAccount2.getString(5)+" "+rsSfAccount2.getString(6);
					}
					else{
                                           if(!(type.equals("3")||type.equals("4"))){
						repAddress=repAddress+"<BR><b>Prepared for:</b><BR>"+rsSfAccount2.getString(1);
                                            }
					}
				}
			}
		}
		rsSfAccount2.close();
	}
	Vector distinctModels=new Vector();
	ResultSet rsDistinctModels=stmt.executeQuery("select distinct model from cs_costing where order_no='"+order_no+"'");
	if(rsDistinctModels != null){
		while(rsDistinctModels.next()){
			if(rsDistinctModels.getString(1)!= null && rsDistinctModels.getString(1).trim().length()>0){
				distinctModels.addElement(rsDistinctModels.getString(1));
			}
		}
	}
	rsDistinctModels.close();

	String note110="*PL4080*PL5700*";
	String note64="*4097AL*6097AL*4177AL*6177AL*DC4174AL*DC6174AL";
	String note28="*DC5304*DC5704H*DC6174*DC4174*DC5704V*DC6804*DC4174AL*DC6174AL";
    String note19="*4089*4179*5709H*5709V*6089*6179*";
	if(qualifying_notes==null){
		qualifying_notes="";
	}

	for(int i=0; i<distinctModels.size(); i++){

		if(!qualifying_notes.endsWith(",")&&qualifying_notes.trim().length()>0){
			qualifying_notes=qualifying_notes+",";
		}
		//out.println(distinctModels.elementAt(i).toString()+"::<BR>");
		if(note110.indexOf("*"+distinctModels.elementAt(i).toString().replaceAll("-","")+"*")>=0){
			qualifying_notes=qualifying_notes+"68,";
			qual_count++;
		}
		if(note64.indexOf("*"+distinctModels.elementAt(i).toString().replaceAll("-","")+"*")>=0){
			qualifying_notes=qualifying_notes+"33,";
			qual_count++;
		}
		if(note28.indexOf("*"+distinctModels.elementAt(i).toString().replaceAll("-","")+"*")>=0){
			qualifying_notes=qualifying_notes+"100,";
			qual_count++;
		}
		if(note19.indexOf("*"+distinctModels.elementAt(i).toString().replaceAll("-","")+"*")>=0){
			qualifying_notes=qualifying_notes+"19,";
			qual_count++;
		}
	}

	if(qualifying_notes.endsWith(",")){
		qualifying_notes=qualifying_notes.substring(0,qualifying_notes.length()-1);
	}
	if(qualifying_notes != null&&qualifying_notes.trim().length()>1 && qualifying_notes.substring(qualifying_notes.length()-1).equals(",")){
		qualifying_notes=qualifying_notes.substring(0,qualifying_notes.length()-1);
	}
	if(pricing_options==null){
		pricing_options="";
	}
	if(pricing_options_free_text==null){
		pricing_options_free_text="";
	}
	if(carriage == null || carriage.trim().length()<1){carriage="1";}
	if(handling_cost == null || handling_cost.trim().length()<1){handling_cost="0";}
	if(freight_cost == null || freight_cost.trim().length()<1){	freight_cost="0";}
	if(overage == null || overage.trim().length()<1){overage="0";}
	if(setup_cost == null || setup_cost.trim().length()<1){setup_cost="0";}
	if(commission == null || commission.trim().length()<1){	commission="0";}
	//getting stuff from PSA table quotataion


	String psa_quote_desc="";
	String quote_region="";
		String quote_source="";


	ResultSet rs_est=stmt.executeQuery("select rep_name,group_id from cs_reps where rep_no='"+rep_no+"'");
	if(rs_est != null){
		while(rs_est.next()){
			sfdc_estimator=rs_est.getString(1);
			group_id=rs_est.getString(2);
			
		}
	}
	rs_est.close();
	//out.println(rep_no+"::"+sfdc_estimator+"::<BR>");
	stmts.close();
	myConns.close();
	if(exclusions_free_text != null){
		for(int rr=0; rr<exclusions_free_text.length(); rr++){
			if((int)exclusions_free_text.charAt(rr)==10){
				exclusions_free_text=exclusions_free_text.substring(0,rr)+"<BR>"+exclusions_free_text.substring(rr);
				rr=rr+4;
			}
		}
	}
	if(qualifying_notes_free_text != null){
		for(int rr=0; rr<qualifying_notes_free_text.length(); rr++){
			if((int)qualifying_notes_free_text.charAt(rr)==10){
				qualifying_notes_free_text=qualifying_notes_free_text.substring(0,rr)+"<BR>"+qualifying_notes_free_text.substring(rr);
				rr=rr+4;
			}
		}
	}
	if(free_text != null){
		for(int rr=0; rr<free_text.length(); rr++){
			if((int)free_text.charAt(rr)==10){
				free_text=free_text.substring(0,rr)+"<BR>"+free_text.substring(rr);
				rr=rr+4;
			}
		}
	}
	if(!(psa_spec_section==null)){
		for(int rr=0; rr<psa_spec_section.length(); rr++){
			if((int)psa_spec_section.charAt(rr)==10){
				psa_spec_section=psa_spec_section.substring(0,rr)+"<BR>"+psa_spec_section.substring(rr);
				rr=rr+4;
			}
		}
	}
	if(!(psa_quote_notes==null)){
		for(int rr=0; rr<psa_quote_notes.length(); rr++){
			if((int)psa_quote_notes.charAt(rr)==10){
				psa_quote_notes=psa_quote_notes.substring(0,rr)+"<BR>"+psa_quote_notes.substring(rr);
				rr=rr+4;
			}
		}
	}
	if(!(psa_addenda==null)){
		for(int rr=0; rr<psa_addenda.length(); rr++){
			if((int)psa_addenda.charAt(rr)==10){
				psa_addenda=psa_addenda.substring(0,rr)+"<BR>"+psa_addenda.substring(rr);
				rr=rr+4;
			}
		}
	}
	// Free notes and psa notes grouping
	if((free_text==null)||(free_text.trim().length()<=0)||(free_text.trim().startsWith("nu"))){
		free_text=psa_quote_notes+"";

	}

	double tot_sum1=0;
	double grand_total=0.0;
	String lvr_sec_desc="";
	String lvr_sec_add="";
	String lvr_spec_sec="";
	String lvr_sec_date="";
	ResultSet rs_csquotes_sum1 = stmt.executeQuery("SELECT line_no, sum(cast(extended_price as decimal)) FROM CSQUOTES where order_no='"+order_no+"' group by line_no order by cast(Line_no as integer)");
	if (rs_csquotes_sum1 !=null) {
		while (rs_csquotes_sum1.next()) {
			tot_sum1=tot_sum1+new Double(rs_csquotes_sum1.getString(2)).doubleValue();
		}
	}
	double grand_total2=0;
	double tot_sum2=0;
	if (!(product.equals("LVR")|product.equals("FSM")|product.equals("BV")|product.equals("GRILLE"))) {
		if(product.equals("GCP")){tot_sum1=tot_sum1+((new Double(commission).doubleValue()*tot_sum1)/100);}
		double extra_charges=new Double(overage).doubleValue()+new Double(handling_cost).doubleValue()+new Double(freight_cost).doubleValue();
		grand_total=tot_sum1+extra_charges;
		//out.println(configured_price+"::"+commission+"::"+overage+"::"+handling_cost+"::"+freight_cost+"::<BR>");
		if(product.equals("GCP")){
			configured_price=""+(new Double(configured_price).doubleValue()+extra_charges);
		}
		else{
			configured_price=""+(new Double(configured_price).doubleValue()*(1+new Double(commission).doubleValue()/100)+extra_charges);
		}
		//out.println(configured_price+"::"+commission+"::"+overage+"::"+handling_cost+"::"+freight_cost+"::<BR>");
		double duty=0;
		if(tot_sum1>=3000){duty=50;}else{duty=25;}
		duty=duty+tot_sum1*.011;
		grand_total2=(duty+tot_sum1)*new Double(carriage).doubleValue()+new Double(overage).doubleValue()+new Double(setup_cost).doubleValue()+new Double(freight_cost).doubleValue();
		tot_sum2=grand_total2;
	}else{
		ResultSet rs_ac = stmt.executeQuery("SELECT * FROM cs_access_central where order_no like '"+order_no+"' order by section_no desc");
		if (rs_ac !=null) {
			while (rs_ac.next()) {
				if((rs_ac.getString("ac_add")!=null &&rs_ac.getString("ac_add").trim().length()>0)||(rs_ac.getString("sect")!=null &&rs_ac.getString("sect").trim().length()>0)||(rs_ac.getString("ac_date")!=null &&rs_ac.getString("ac_date").trim().length()>0)){

					lvr_sec_add=rs_ac.getString("ac_add");
					//out.println(lvr_sec_add+"::<BR>");
					lvr_spec_sec=rs_ac.getString("sect");
					lvr_sec_date=rs_ac.getString("ac_date");
				}
				lvr_sec_desc=rs_ac.getString("ac_desc");
				grand_total=new Double(rs_ac.getString("pinfsellprice")).doubleValue();
			}
		}
		rs_ac.close();
	}
	//out.println("<br>"+grand_total+"<br>");
	for1.setMaximumFractionDigits(0);
	price=for1.format(grand_total);
priceNotFormatted=""+grand_total;
	for1.setMaximumFractionDigits(2);
	for1.setMinimumFractionDigits(2);
	if(agent_name==null){agent_name="";}
	String cust_name1="";
	String cust_addr1="";
	String cust_addr2="";
	String city="";
	String state="";
	String zip_code="";
	String ccode="";
	String cust_contact_name="";
	String cust_fax="";
	String cust_phone="";
	String rep_account="";
	String address1="";
	String address2="";
	String rep_city="";
	String rep_state="";
	String rep_zip_code="";
	String rep_telephone="";
	String rep_fax="";
	String rep_email="";
	String rep_name="";
	String rep_email2="";
	ResultSet rs_reps = stmt.executeQuery("SELECT * FROM cs_reps where rep_no like '"+rep_no+"'");
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
			rep_email2= rs_reps.getString("email");
			rep_name = rs_reps.getString("rep_name");
		}
	}

	//dates
	String odate="";
	String doc_priority="";
	ResultSet rs_eorders = stmt.executeQuery("SELECT doc_date,entry_date,doc_priority FROM doc_header where doc_number like '"+order_no+"'");
	if (rs_eorders !=null) {
		while (rs_eorders.next()) {
			odate= rs_eorders.getString(2).substring(0,10);
			if(product.equals("LVR")|product.equals("GCP")){edate= rs_eorders.getString(2).substring(0,10);}
			doc_priority= rs_eorders.getString(3);
		}
	}

	//cs_quote_Sections
	int sections=0;
	String section_info="";
	String section_group="";
	int count_line=0;
	Vector items=new Vector();
	String section_exc="";
	String section_qual="";
	String section_notes="";
	String section_page="0";
	String secOverage="";
	String secHandling="";
	String secFreight="";
	String secSetup="";

	try{
		String cs_quote_sect="SELECT * FROM cs_quote_sections where ORDER_NO ='"+order_no+"' and not sections in ('0','1')";
		java.sql.ResultSet rs = stmt.executeQuery(cs_quote_sect);
		while(rs.next()){
			section_info =  rs.getString(2);
			sections =  rs.getInt(3);
			section_group =  rs.getString(4);
			section_qual =  rs.getString("section_qual");
			section_exc =  rs.getString("section_excl");
			section_notes=  rs.getString("section_notes");
			section_page =  rs.getString("section_page");
			secOverage=rs.getString("overage");
			secHandling=rs.getString("handling_cost");
			secFreight=rs.getString("freight_cost");
			secSetup=rs.getString("setup_cost");

		}
	}catch (java.sql.SQLException e){
		out.println("Problem with Getting from the quote sections table ");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		out.println(e.toString());
		return;
	}
		if(!(section_notes==null)){
				for(int rr=0; rr<section_notes.length(); rr++){
					if((int)section_notes.charAt(rr)==10){
						section_notes=section_notes.substring(0,rr)+"<BR>"+section_notes.substring(rr);
						rr=rr+4;
					}
				}
		}
	ResultSet rs5 = stmt.executeQuery("SELECT * FROM doc_line where doc_number like '"+order_no+"' order by cast(doc_line as integer)");
	if (rs5!=null){
		while(rs5.next()){
			items.addElement(rs5.getString("doc_line"));
			count_line++;
		}
	}

	//sections
	int desc_count=0;
	String desc_value="";
	String var="";
	String desc_value1="";
	String desc_value2="";
	String desc_value3="";
	Vector sect_name=new Vector();
	Vector sect_value=new Vector();
	Vector sect_qual=new Vector();
	Vector sect_exec=new Vector();
	Vector sect_group=new Vector();
	Vector sect_group_lines=new Vector();
	Vector sect_notes=new Vector();//final description
	Vector overageSec=new Vector();
	Vector handlingSec=new Vector();
	Vector freightSec=new Vector();
	Vector setupSec=new Vector();
	boolean isOverage=false;
	boolean isHandling=false;
	boolean isFreight=false;
	if(sections>1){
		// line groups
		for(int i=0;i<sections;i++){
			desc_count=i+1;
			var="s"+desc_count+"=";
			int config_s1= section_info.indexOf(var);
			if(config_s1>=0){
				int config_s2=section_info.indexOf(";",config_s1+1);
				desc_value=section_info.substring(config_s1+var.length(),config_s2);
			}
			else{
				desc_value="";
			}
			sect_name.addElement("s"+desc_count);sect_value.addElement(desc_value);
			//qual and exclusions and notes
			//out.println("var"+var+"<br>");
			if(section_qual!=null){
				int config_s3= section_qual.indexOf(var);
				if(config_s3>=0){
					int config_s2=section_qual.indexOf(";",config_s3+1);
					desc_value1=section_qual.substring(config_s3+var.length(),config_s2);
					//out.println("v "+desc_value1+"<br>");
				}
				else{
					desc_value1="";
				}
				sect_qual.addElement(desc_value1.trim());//qual ending
			}
			if(section_exc!=null){
				int config_s4= section_exc.indexOf(var);
				if(config_s4>=0){
					int config_s2=section_exc.indexOf(";",config_s4+1);
					desc_value2=section_exc.substring(config_s4+var.length(),config_s2);
					//out.println("v "+desc_value2+"<br>");
				}
				else{
					desc_value2="";
				}
				sect_exec.addElement(desc_value2.trim());//exclusions ending
			}
			if(section_notes!=null){
				int config_s5= section_notes.indexOf(var);
				if(config_s5>=0){
					int config_s2=section_notes.indexOf(";",config_s5+1);
					desc_value3=section_notes.substring(config_s5+var.length(),config_s2);
					//out.println("v "+desc_value3.trim()+"<br>");
				}
				else{
					desc_value3="";
				}
				sect_notes.addElement(desc_value3.trim());//notes ending
			}
			if(secOverage != null && secOverage.trim().length()>0){
				//out.println(secOverage);
				int startx=secOverage.indexOf(var);
				String tempx="";
				if(startx>=0){
					startx=startx+var.length();
					int endx=secOverage.substring(startx).indexOf(";");
					tempx=secOverage.substring(startx,startx+endx);
				}
				if(startx<0 || (tempx == null || tempx.trim().length()<1)){
					overageSec.addElement("");
				}
				else{
					overageSec.addElement(tempx);
					isOverage=true;
				}
			}
			else{
				overageSec.addElement("");
			}
			if(secHandling != null && secHandling.trim().length()>0){
				int startx=secHandling.indexOf(var);
				String tempx="";
				if(startx>=0){
					startx=startx+var.length();
					int endx=secHandling.substring(startx).indexOf(";");
					tempx=secHandling.substring(startx,startx+endx);
				}
				if(startx<0 || (tempx == null || tempx.trim().length()<1)){
					handlingSec.addElement("");
				}
				else{
					handlingSec.addElement(tempx);
					isHandling=true;
				}
			}
			else{
				handlingSec.addElement("");
			}
			if(secSetup != null && secSetup.trim().length()>0){
				int startx=secSetup.indexOf(var);
				String tempx="";
				if(startx>=0){
					startx=startx+var.length();
					int endx=secSetup.substring(startx).indexOf(";");
					tempx=secSetup.substring(startx,startx+endx);
				}
				if(startx<0 || (tempx == null || tempx.trim().length()<1)){
					setupSec.addElement("");
				}
				else{
					setupSec.addElement(tempx);
				}
			}
			else{
				setupSec.addElement("");
			}
			if(secFreight != null && secFreight.trim().length()>0){
				int startx=secFreight.indexOf(var);
				String tempx="";
				if(startx>=0){
					startx=startx+var.length();
					int endx=secFreight.substring(startx).indexOf(";");
					tempx=secFreight.substring(startx,startx+endx);
				}
				if(startx<0 || (tempx == null || tempx.trim().length()<1)){
					freightSec.addElement("");
				}
				else{
					//out.println(tempx+"::This is a manually allocated freight<BR>");
					freightSec.addElement(tempx);
					isFreight=true;
				}
			}
			else{
				freightSec.addElement("");
			}
		}
		desc_count=0;var="";desc_value="";desc_value1="";desc_value2="";desc_value3="";String group_sect="";String group_line="";
		for(int j=0;j<sections;j++){
			for(int kl=0;kl<count_line;kl++){
				var=items.elementAt(kl).toString()+"=";
				int config_s1= section_group.indexOf(var);
				if(config_s1>=0){
					int config_s2=section_group.indexOf(";",config_s1+1);
					desc_value=section_group.substring(config_s1+var.length(),config_s2);
				}else{
					desc_value="";
				}
				 if(desc_value.equals(sect_name.elementAt(j).toString())){
					if(group_line.trim().length()>0){
						group_line=group_line+","+items.elementAt(kl).toString();
					}
					else{
						group_line=group_line+items.elementAt(kl).toString();
					}
				}
			}
			sect_group.addElement(sect_value.elementAt(j).toString());sect_group_lines.addElement(group_line);
			group_line="";
		}
	}//if sections not 0
	 if(section_page.equals("1")){
		section_page="0";
	 }
%>
<html>
	<head>
		<title><%= Project_name %> --- Quote:: <%= order_no %></title>






	</head>
	<%

String border_color="";
if(section_page==null||section_page.equals("0")){//cheking to print different pages
	%>
	<%@ include file="quote_template_header_sfdc.jsp"%>
	<%@ include file="quote_template_top_sfdc.jsp"%>
	<%
}

if(product.endsWith("FSM")){
	border_color="tableline_ejc";
	%>
	<%@ include file="quote_template_body_fsm_sfdc.jsp"%>
	<%
}

if(section_page==null||section_page.equals("0")){	//checking to print different pages
//out.println(qualifying_notes+"::<BR>");
	%>
	<%@ include file="quote_template_foot_sfdc.jsp"%>
	<%@ include file="quote_template_footer_sfdc.jsp"%>
	<%
}

rs_project.close();
rs_reps.close();
rs_eorders.close();

}
else{
out.println("No eRapid quote # is attached to this SFDC quote");
}

stmt.close();
myConn.close();
stmt_sfdc.close();
myConn_sfdc.close();
}
catch(Exception e){
out.println(e);
}
	%>

</body>
</html>

