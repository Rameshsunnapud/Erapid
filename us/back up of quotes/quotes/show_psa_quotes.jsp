<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

//out.println("HERE<BR>");

		String order_no = request.getParameter("orderNo");//Login id
		String type= request.getParameter("type");//type


		String QuoteID = "";//Login id
		String AcctID = "";//totals



		String UserID= request.getParameter("UserID");//totals
		String group_id= request.getParameter("group_id");
		//out.println(UserID+"::"+group_id);
		String output="";
		if(output==null){
			output="";
		}
%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.text.*" import="java.sql.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="../../db_con.jsp"%>
<%@ include file="../../db_con_psa.jsp"%>
<%
			String creatorId="";
			if(AcctID==null || AcctID.trim().length()==0){
			ResultSet r1=stmt.executeQuery("Select project_type_id, cust_name, creator_id FROM cs_project where order_no='"+order_no+"' and project_type ='psa'");
			if(r1 != null){
				while(r1.next()){
					if(r1.getString(1) != null){

						QuoteID=r1.getString(1);
						//out.println(QuoteID+"::<BR>");
						AcctID=r1.getString(2);
						creatorId=r1.getString(3);
					}
				}
			}
			r1.close();
			ResultSet rsx=stmt_psa.executeQuery("select acct_id from DBA.QUOTED_ACCOUNTS where quote_id='"+QuoteID+"'");
			if(rsx != null){
				while(rsx.next()){
					AcctID=rsx.getString(1);
				}
			}
			rsx.close();
			//out.println(QuoteID+"::"+AcctID+"::"+creatorId);
//AcctID="0000000084";
			ResultSet r2=stmt.executeQuery("select user_id from cs_reps where rep_no='"+creatorId+"'");
			if(r2 != null){
				while(r2.next()){
					UserID=r2.getString(1);
				}
			}
			r2.close();

			ResultSet r3=stmt_psa.executeQuery("Select Quote_id from DBA.QUOTATION where elogia_no='"+order_no+"'");
			if(r3 != null){
				while(r3.next()){
					QuoteID=r3.getString(1);
				}
			}
			r3.close();




}

String quote_region="";
	String pricing_options="";
	String pricing_options_free_text="";
String secLines="";
NumberFormat for0 = NumberFormat.getCurrencyInstance();
for0.setMaximumFractionDigits(0);
//HttpSession UserSession_rep = request.getSession();String session_group_id="";
String session_rep_no="";
if(group_id==null)	{group_id="";}
			//if(UserSession_rep!=null){
//				String name= UserSession1.getAttribute("username").toString();
				//if(UserSession_rep.getAttribute("rep_no") != null){
				//	session_rep_no= UserSession_rep.getAttribute("rep_no").toString();
				//}
				//if(UserSession_rep.getAttribute("usergroup") != null){
				//	session_group_id= UserSession_rep.getAttribute("usergroup").toString();
				//}
		  // }
		   //out.println(session_group_id+"::");
if(group_id==null||group_id.trim().length()<1){
	//group_id=session_group_id;
}
//out.println(order_no);
if (!(order_no==null)){
//out.println("Testing");
//Project data
String edate="";
String product="";String Project_name="";String Arch_name="";String Arch_loc="";String section="";String division="";
String free_text="";String exclusions="";String exclusions_free_text="";String qualifying_notes="";String qualifying_notes_free_text="";
String rep_no="";String cust_no="";int exc_count=0;int qual_count=0;String section_desc="";String project_city="";String project_state="";String agent_name="";
String freight_cost="";String projCur="";String overage="";String handling_cost="";String project_type="";String Arch_state="";
String price1="";String price="";String rep_notes=""; String tax_perc="";
// for formatting
String psa_quote_desc="";
String psa_req_date="";
NumberFormat for1 = NumberFormat.getCurrencyInstance();
NumberFormat for2 = NumberFormat.getCurrencyInstance();
for2.setMinimumFractionDigits(0);
for2.setMaximumFractionDigits(0);
 for1.setMaximumFractionDigits(2);
 for1.setMinimumFractionDigits(2);
 String setup_cost="";

	ResultSet rs_project = stmt.executeQuery("SELECT Project_name,currency,Job_loc,project_state,Arch_name,Arch_loc,Agent_name,Cust_name,product_id,section,division,free_text,overage,handling_cost,freight_cost,exclusions,len(exclusions)as v1,creator_id,exclusions_free_text,qualifying_notes,len(qualifying_notes) as v2,qualifying_notes_free_text,section_desc,project_type,rep_notes,tax_perc,setup_cost FROM cs_project where Order_no like '"+order_no+"'");
		if (rs_project !=null) {
        while (rs_project.next()) {

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
		setup_cost=rs_project.getString("setup_cost");
		if(rs_project.getString("freight_cost") == null || rs_project.getString("freight_cost").trim().length()<1){
			freight_cost="0";
		}
		else{
			freight_cost=rs_project.getString("freight_cost");
			}
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
		//out.println(projCur);
		rep_notes=rs_project.getString("rep_notes");
		tax_perc=rs_project.getString("tax_perc");

								}
							    }
							    //out.println(product+"::HERE");
if(overage == null || overage.equals("null")||overage.trim().length()==0){
	overage="0";
}
if(handling_cost == null || handling_cost.equals("null")||handling_cost.trim().length()==0){
	handling_cost="0";
}
if(freight_cost == null || freight_cost.equals("null")||freight_cost.trim().length()==0){
	freight_cost="0";
}
if(setup_cost == null || setup_cost.equals("null")||setup_cost.trim().length()==0){
	setup_cost="0";
}


%>
<html>
	<head>
		<title><%= Project_name %> --- Quote:: <%= order_no %></title>
		<!--<link rel='stylesheet' href='quotes.css' type='text/css' />-->


		<style type="text/css">

			.maintitle { color:#333333; font-size:12pt; font-family:arial, helvetica; }
			.maintitle2 { color:#333333; font-size:6pt;font-family:arial, helvetica; }
			.subtitle { color:#333333; font-size:9pt; font-family:arial, helvetica; }
			.mainfooter { color:#666666; font-size:8pt; font-family:tahoma, arial, helvetica; }
			.mainbody { color:#333333; font-size:10pt; font-family:arial, verdana, helvetica; text-decoration:none; }
			.mainbodyh { color:#333333; font-size:8.5pt;font-family:verdana, arial, helvetica; text-decoration:none; }
			.maindesc { color:#333333; font-size:9pt; font-family:arial, verdana, helvetica; text-decoration:none; }
			.schedule { color:#ffffff; font-size:9pt; font-family:arial, verdana, helvetica; text-decoration:none; }
			.totprice { color:#000000; font-size:12pt; font-family:arial, helvetica; text-decoration:none; }
			.tableline { border-right: #B4DC61 1px solid; border-top: #B4DC61 1px solid; border-left: #B4DC61 1px solid; border-bottom: #B4DC61 1px solid; }
			.tableline_ejc { border-right: #B4DC61 1px solid; border-top: #B4DC61 1px solid; border-left: #B4DC61 1px solid; border-bottom: #B4DC61 1px solid; }
			.tableline_iwp { border-right: #cc9966 1px solid; border-top: #cc9966 1px solid; border-left: #cc9966 1px solid; border-bottom: #cc9966 1px solid; }
			.tableline_row { padding-right: 5px; padding-left: 5px; padding-bottom: 3px; padding-top: 3px; }
			<!-- alternate colors blue=#6699cc  borders @ the bottom=#99CCFF the grey=#F1F1F1-->
			<!-- alternate colors green=#006600  borders @ the bottom=#CCCC99 the ash=#e4e4e4 the alternate to ash=#EFEFDE-->
			.table_thin_borders{border : thin groove;}


		</style>





	</head>
	<%







/*
ResultSet cs_exc_notes1x = stmt.executeQuery("select code FROM cs_exc_notes where product_id='"+product+"' and set_default='y'");
if (cs_exc_notes1x !=null) {
	while (cs_exc_notes1x.next()) {
		exclusions=exclusions+cs_exc_notes1x.getString("code")+",";
		exc_count++;
	}
}
cs_exc_notes1x.close();
//out.println(qualifying_notes+"::b4<br>");
ResultSet cs_qlf_notes1x = stmt.executeQuery("select code FROM cs_qlf_notes where product_id='"+product+"' and set_default='y'");
if (cs_qlf_notes1x !=null) {
	while (cs_qlf_notes1x.next()) {
		qualifying_notes=qualifying_notes+cs_qlf_notes1x.getString("code")+",";
		qual_count++;
	}
}
cs_qlf_notes1x.close();


*/









if(qualifying_notes != null&&qualifying_notes.trim().length()>1 && qualifying_notes.substring(qualifying_notes.length()-1).equals(",")){
	qualifying_notes=qualifying_notes.substring(0,qualifying_notes.length()-1);
}

//out.println(qualifying_notes+"::after<BR>");
//qualifying_notes="";
//qual_count=0;
//getting stuff from PSA table quotataion
String psa_spec_section="";String psa_alternate="";String psa_addenda="";String psa_estimator="";String psa_rsm="";String bid_rsm="";
//java.sql.Date edatex=null;
String edatex="";
String project_id="";String psa_quote_type="";String psa_quote_notes="";String psa_type_of_quote="";String spec_level="";

		ResultSet rs_psa_quotes = stmt_psa.executeQuery("SELECT * FROM dba.quotation where quote_id='"+QuoteID+"'");
		if (rs_psa_quotes !=null) {
         while (rs_psa_quotes.next()) {
		project_id=rs_psa_quotes.getString("project_id");
		psa_quote_notes=rs_psa_quotes.getString("notes");
		psa_type_of_quote=rs_psa_quotes.getString("type_of_quote");
		psa_spec_section=rs_psa_quotes.getString("spec_section_m");
		psa_alternate=rs_psa_quotes.getString("alternate_t");
		psa_addenda=rs_psa_quotes.getString("addenda");
		psa_estimator= rs_psa_quotes.getString("creator_id");
		//out.println(psa_estimator+"::<BR>");
		psa_quote_type= rs_psa_quotes.getString("quote_type");
		psa_rsm= rs_psa_quotes.getString("RSM");
		edatex= rs_psa_quotes.getString("mbid_date");
		spec_level= rs_psa_quotes.getString("spec_level");
			 }
		}
rs_psa_quotes.close();

if(exclusions_free_text != null){
exclusions_free_text="<BR>"+exclusions_free_text;
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
				psa_spec_section=psa_spec_section.substring(0,rr)+"<br>"+psa_spec_section.substring(rr);
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
//out.println("psa"+psa_quote_notes+"era"+free_text);
}

if(!(psa_rsm==null)){
	if(psa_rsm.trim().length()>0){
		ResultSet rs_psa_lookup = stmt_psa.executeQuery("SELECT * FROM dba.user_lookup where lookup_id like '"+psa_rsm.trim()+"'");
			if (rs_psa_lookup !=null) {
			while (rs_psa_lookup.next()) {
						psa_rsm= rs_psa_lookup.getString(3);
				}
			}
		rs_psa_lookup.close();
	}
}else{psa_rsm="";}

double tot_sum1=0;double grand_total=0.0;String lvr_sec_desc="";String lvr_sec_add="";String lvr_spec_sec="";String lvr_sec_date="";
		ResultSet rs_csquotes_sum1 = stmt.executeQuery("SELECT line_no, sum(cast(extended_price as float)) FROM CSQUOTES where order_no='"+order_no+"' group by line_no order by cast(Line_no as integer)");
		if (rs_csquotes_sum1 !=null) {
         while (rs_csquotes_sum1.next()) {
		 tot_sum1=tot_sum1+new Double(rs_csquotes_sum1.getString(2)).doubleValue();
		// out.println(tot_sum1+":: <BR>");
			 }
		}
double extra_charges=0;
double taxtotal=0;
//out.println(overage+"::"+handling_cost+"::"+freight_cost);
if (!(product.equals("LVR")|product.equals("BV")|product.equals("GRILLE")|product.equals("ADS"))) {
	extra_charges=new Double(overage).doubleValue()+new Double(handling_cost).doubleValue()+new Double(freight_cost).doubleValue()+new Double(setup_cost).doubleValue();
	grand_total=tot_sum1+extra_charges;
	taxtotal=grand_total;
}else{

		ResultSet rs_ac = stmt.executeQuery("SELECT * FROM cs_access_central where order_no like '"+order_no+"'");
		if (rs_ac !=null) {
        while (rs_ac.next()) {
		lvr_sec_desc=rs_ac.getString("ac_desc");
		lvr_sec_add=rs_ac.getString("ac_add");
		lvr_spec_sec=rs_ac.getString("sect");
		lvr_sec_date=rs_ac.getString("ac_date");
		grand_total=new Double(rs_ac.getString("pinfsellprice")).doubleValue();
		}
		}
	rs_ac.close();
}

//out.println("<br>"+grand_total+"xxxxxx<br>");
 for1.setMaximumFractionDigits(0);
price=for1.format(grand_total);
//out.println(price+ "HERE");
for1.setMaximumFractionDigits(2);
if(agent_name==null){agent_name="";}
String cust_name1="";String cust_addr1="";String cust_addr2="";String city="";String state="";String zip_code="";String ccode="";String cust_contact_name="";
String cust_fax="";String cust_phone="";String country="";
String rep_account="";String address1="";String address2="";String rep_city="";String rep_state="";String rep_zip_code="";
String rep_telephone="";String rep_fax="";String rep_email=""; String rep_name="";String rep_email2="";

;

ResultSet rs_reps = stmt.executeQuery("SELECT * FROM cs_reps where rep_no like '"+rep_no+"' and (user_id is null or user_id='' or user_id='"+psa_estimator+"') order by user_id desc");
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
		rep_email2= rs_reps.getString("email");
		rep_name = rs_reps.getString("rep_name");
								  }
								  }
if(rep_name==null||rep_name.equals("null")){
	rep_name="";
}
if(rep_fax==null||rep_fax.equals("null")){
	rep_fax="";
}
if(rep_telephone==null||rep_telephone.equals("null")){
	rep_telephone="";
}
boolean isSecOverage=false;
boolean isSecFreight=false;
boolean isSecSetup=false;
boolean isSecHandling=false;
//dates
String odate="";String doc_priority="";
	ResultSet rs_eorders = stmt.executeQuery("SELECT doc_date,entry_date,doc_priority FROM doc_header where doc_number like '"+order_no+"'");
		if (rs_eorders !=null) {
        while (rs_eorders.next()) {
		odate= rs_eorders.getString(1).substring(0,10);
		if(product.equals("LVR")|product.equals("LVR")|product.equals("LVR")){edatex= rs_eorders.getString(2).substring(0,10);}
		doc_priority= rs_eorders.getString(3);
									}
								}

//cs_quote_Sections
int sections=0;String section_info="";String section_group="";int count_line=0;Vector items=new Vector();
String section_exc="";String section_qual="";String section_notes="";String section_page="0";
String secOverage="";String secHandling="";String secFreight="";String secSetup="";
try
	{
		String cs_quote_sect="SELECT * FROM cs_quote_sections where ORDER_NO ='"+order_no+"'";
		java.sql.ResultSet rs = stmt.executeQuery(cs_quote_sect);
		while(rs.next()){
		section_info =  rs.getString(2);
		sections =  rs.getInt(3);
		section_group =  rs.getString(4);
		section_qual =  rs.getString("section_qual");
		section_exc =  rs.getString("section_excl");
		section_notes=  rs.getString("section_notes");
		section_page =  rs.getString("section_page");
		//out.println(section_qual+" section qual<BR>");
		//out.println(section_exc+" section exc<BR>");
		//out.println(section_notes+" section notes<BR>");
		secOverage=rs.getString("overage");
		//out.println(secOverage);
		secHandling=rs.getString("handling_cost");
		secFreight=rs.getString("freight_cost");
		secSetup=rs.getString("setup_cost");
		}
	}
 catch (java.sql.SQLException e)
	{
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
int desc_count=0;String desc_value="";String var="";String desc_value1="";String desc_value2="";String desc_value3="";
Vector sect_name=new Vector();Vector sect_value=new Vector();Vector sect_qual=new Vector();Vector sect_exec=new Vector();
Vector sect_group=new Vector();Vector sect_group_lines=new Vector();Vector sect_notes=new Vector();//final description
Vector overageSec=new Vector();Vector handlingSec=new Vector();Vector freightSec=new Vector();Vector setupSec=new Vector();
	if(sections>1){
		// line groups
		for(int i=0;i<sections;i++){
			desc_count=i+1;
			var="s"+desc_count+"=";
			//out.println(var+"  HERE<BR>");
			int config_s1= section_info.indexOf(var);
			if(config_s1>=0){
			int config_s2=section_info.indexOf(";",config_s1+1);
			desc_value=section_info.substring(config_s1+var.length(),config_s2);
			}else{desc_value="";}
			sect_name.addElement("s"+desc_count);sect_value.addElement(desc_value);
			//qual and exclusions and notes
//			out.println("var"+var+"<br>");
				if(section_qual!=null){
			int config_s3= section_qual.indexOf(var);
			if(config_s3>=0){
			int config_s2=section_qual.indexOf(";",config_s3+1);
			desc_value1=section_qual.substring(config_s3+var.length(),config_s2);
//			out.println("v "+desc_value1+"<br>");
			}else{desc_value1="";}
			 sect_qual.addElement(desc_value1.trim());//qual ending
			 //out.println(desc_value1.trim()+" HERE<BR>");
			 }
			if(section_exc!=null){
			int config_s4= section_exc.indexOf(var);
			if(config_s4>=0){
			int config_s2=section_exc.indexOf(";",config_s4+1);
			desc_value2=section_exc.substring(config_s4+var.length(),config_s2);
	//		out.println("v "+desc_value2+"<br>");
			}else{desc_value2="";}
			 sect_exec.addElement(desc_value2.trim());//exclusions ending
			}
			if(section_notes!=null){
			int config_s5= section_notes.indexOf(var);
			if(config_s5>=0){
			int config_s2=section_notes.indexOf(";",config_s5+1);
			desc_value3=section_notes.substring(config_s5+var.length(),config_s2);
		//	out.println("v "+desc_value3.trim()+"<br>");
			}else{desc_value3="";}
			 sect_notes.addElement(desc_value3.trim());//notes ending
			}
			//out.println(secOverage);
			if(secOverage != null && secOverage.trim().length()>0){
				int startx=secOverage.indexOf(var);
				String tempx="";
				if(startx>=0){
					startx=startx+var.length();
					int endx=secOverage.substring(startx).indexOf(";");
					tempx=secOverage.substring(startx,startx+endx);
				}
				if(startx<0 || (tempx == null && tempx.trim().length()<1)){
					overageSec.addElement("0");
				}
				else{
					if(tempx.trim().length()>0){
						isSecOverage=true;
					}
					overageSec.addElement(tempx);
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
				if(startx<0 || (tempx == null && tempx.trim().length()<1)){
					handlingSec.addElement("0");
				}
				else{
					handlingSec.addElement(tempx);
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
				if(startx<0 || (tempx == null && tempx.trim().length()<1)){
					setupSec.addElement("0");
				}
				else{
					if(tempx.trim().length()>0){
						isSecSetup=true;
					}
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
				if(startx<0 || (tempx == null && tempx.trim().length()<1)){
					freightSec.addElement("0");
				}
				else{
					if(tempx.trim().length()>0){
						isSecFreight=true;
					}
					freightSec.addElement(tempx);
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
					}else{desc_value="";}
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
	}//if sections not 0 s
	String border_color="";
			if(edatex== null){edate=""; }else{edate=edatex+"";}

	if(section_page==null||section_page.equals("0")||sections<=0){//cheking to print different pages

	%>
	<%@ include file="quote_template_header_psa.jsp"%>
	<%@ include file="quote_template_top_psa.jsp"%>
	<%

		}
		//out.println(product+":::");
		if(product.equals("EJC")){
			border_color="tableline_ejc";
			int k=0;Vector mark=new Vector();Vector desc=new Vector();Vector qty=new Vector();Vector rec_no=new Vector();
			Vector line_no=new Vector();String color="NONE";ResultSet rs_csquotes;String bgcolor="";int bcount=0;
			//out.println(price+ "HERExx");
	%>
	<%//@ include file="quote_template_body_liprice_psa_ejc.jsp"%>
	<%
}
else if(product.equals("IWP")){
	border_color="tableline_iwp";
	//out.println("HERE");
	%>
	<%@ include file="iwp_template_liprice_psa.jsp"%>
	<%
}



//if((section_page==null||section_page.equals("0"))&&new Double(sections).doubleValue()<=0){	//cheking to print different pages
//out.println(section_page+"::"+sections+" HERE<BR>");
//&&new Double(sections).doubleValue()<=1
if((product.equals("IWP")||product.equals("EJC")||product.equals("EFS"))&&(section_page==null||((section_page.equals("0")&&!product.equals("EJC"))||new Double(sections).doubleValue()==0))){
//out.println("HERE");
	%>
	<%@ include file="quote_template_foot_psa.jsp"%>
	<%@ include file="quote_template_footer_psa.jsp"%>
	<%
	}
rs_project.close();
rs_reps.close();
rs_eorders.close();

}
else{
out.println("A Erapid quote no is not attached to this PSA quote");
}
stmt.close();
myConn.close();

}
  catch(Exception e){
  out.println(e);
  }
	%>

</body>
</html>










































































