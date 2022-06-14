<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<style type="text/css">
	.maintitle { color:#333333; font-size:12pt; font-family:arial, helvetica; }
	.subtitle { color:#333333; font-size:9pt; font-family:arial, helvetica; }
	.mainfooter { color:#666666; font-size:8pt; font-family:tahoma, arial, helvetica; }
	.mainbody { color:#333333; font-size:10pt; font-family:arial, verdana, helvetica; text-decoration:none; }
	.mainbodyh { color:#333333; font-size:8.5pt;font-family:verdana, arial, helvetica; text-decoration:none; }
	.maindesc { color:#333333; font-size:9pt; font-family:arial, verdana, helvetica; text-decoration:none; }
	.desc_title{ color:#333333; font-size:9pt; font-family:arial, verdana, helvetica; text-decoration:none; }
	.schedule { color:#ffffff; font-size:9pt; font-family:arial, verdana, helvetica; text-decoration:none; }
	.totprice { color:#000000; font-size:12pt; font-family:arial, helvetica; text-decoration:none; }
	.tableline { border-right: #B4DC61 1px solid; border-top: #B4DC61 1px solid; border-left: #B4DC61 1px solid; border-bottom: #B4DC61 1px solid; }
	.tableline_ejc { border-right: #B4DC61 1px solid; border-top: #B4DC61 1px solid; border-left: #B4DC61 1px solid; border-bottom: #B4DC61 1px solid; }
	.tableline_iwp { border-right: #cc9966 1px solid; border-top: #cc9966 1px solid; border-left: #cc9966 1px solid; border-bottom: #cc9966 1px solid; }
	.tableline_row { padding-right: 5px; padding-left: 5px; padding-bottom: 3px; padding-top: 3px; }
	<!-- alternate colors blue=#6699cc  borders @ the bottom=#99CCFF the grey=#F1F1F1-->
	<!-- alternate colors green=#006600  borders @ the bottom=#CCCC99 the ash=#e4e4e4 the alternate to ash=#EFEFDE-->
	.table_thin_borders{border : thin groove;}
	p.after {page-break-after: always}
	p.before {page-break-before: always}
</style>
<%
String customerCountry="";
String ispdf="";
String order_no = request.getParameter("orderNo");//Login id
String price = request.getParameter("tp");//totals
String prepared_by="";
String prepared_by_email="";
String price1= request.getParameter("tp1");//totals
String pdf=request.getParameter("pdf");

if(price1==null){
	price1=price;
	if(price1 != null && price1.startsWith("$")){
		price1=price1.substring(1);
	}
}
String type= request.getParameter("type");//type
String lvrTaxSub=request.getParameter("total");
NumberFormat for11x = NumberFormat.getCurrencyInstance();
for11x.setMaximumFractionDigits(0);
%>
<%@ page language="java" pageEncoding="utf-8" import="java.text.*" import="java.sql.*" import="java.math.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="../../db_con.jsp"%>

<%

double taxtotal=0;
double freightX=0;double handlingX=0;double overageX=0;double setupX=0;
String sect_group_linesx="";
DecimalFormat df0 = new DecimalFormat("####");
//taxtotal=new Double(df0.format(new Double(price).doubleValue())).doubleValue();
String commission="";
String gross_margin="";
String secLines="";
String grandtotalforsec="";
boolean isSecOverage=false;
boolean isSecFreight=false;
boolean isSecSetup=false;
boolean isSecHandling=false;
boolean isOverage=false;
boolean isHandling=false;
boolean isFreight=false;
String isInstall="";
String configured_price="";
NumberFormat for0 = NumberFormat.getCurrencyInstance();
for0.setMaximumFractionDigits(0);
double grand_total=0;
String bpcs_cust_no="";
String carriage_type="";String carriage_loc="";String setup_cost="";String doc_type_alt="";
String product="";String Project_name="";String Arch_name="";String Arch_loc="";String section="";String division="";
String free_text="";String exclusions="";String exclusions_free_text="";String qualifying_notes="";String qualifying_notes_free_text="";
String rep_no="";String cust_no="";int exc_count=0;int qual_count=0;String section_desc="";String project_city="";String project_state="";String agent_name="";
String freight_cost="";String projCur="";String overage="";String handling_cost="";String project_type="";String carriage_charge="";String rep_notes=""; String tax_perc=""; String creator_user_id="";
		ResultSet rs_project = stmt.executeQuery("SELECT configured_price,Project_name,currency,Job_loc,project_state,Arch_name,Arch_loc,Agent_name,Cust_name,product_id,section,division,free_text,overage,handling_cost,freight_cost,exclusions,len(exclusions)as v1,creator_id,exclusions_free_text,qualifying_notes,len(qualifying_notes) as v2,qualifying_notes_free_text,section_desc,project_type,carriage_charge,rep_notes,tax_perc,user_id,carriage_type,internal_notes,setup_cost,doc_type_alt FROM cs_project where Order_no like '"+order_no+"'");
		if (rs_project !=null) {
        while (rs_project.next()) {
        configured_price=rs_project.getString("configured_price");
     //   out.println(configured_price);
		Project_name= rs_project.getString("Project_name");
		if(!(Project_name != null)){Project_name="";}
		project_city= rs_project.getString("job_loc");
		project_state= rs_project.getString("Project_state");
		cust_no= rs_project.getString("Cust_name");
		Arch_name= rs_project.getString("Arch_name");
		Arch_loc= rs_project.getString("Arch_loc");
		agent_name= rs_project.getString("Agent_name");
		product= rs_project.getString("product_id").trim();
		//ut.println(product+"HERE<BR>");
		rep_no= rs_project.getString("creator_id");
		section= rs_project.getString("section");
		division= rs_project.getString("division");
		free_text= rs_project.getString("free_text");
		overage=rs_project.getString("overage");
		handling_cost=rs_project.getString("handling_cost");
		freight_cost=rs_project.getString("freight_cost");
		exclusions= rs_project.getString("exclusions");
		if(rs_project.getString("v1")==null || rs_project.getString("v1").equals("null")){
			exc_count=0;
		}
		else{
			exc_count=rs_project.getInt("v1");
		}
		exclusions_free_text= rs_project.getString("exclusions_free_text");
		if(rs_project.getString("v2")==null || rs_project.getString("v2").equals("null")){
			qual_count=0;
		}
		else{
			qual_count=rs_project.getInt("v2");
		}
		qualifying_notes= rs_project.getString("qualifying_notes");
		qualifying_notes_free_text= rs_project.getString("qualifying_notes_free_text");
		section_desc= rs_project.getString("section_desc");
		project_type= rs_project.getString("project_type");
		projCur=rs_project.getString("currency");
		carriage_charge=rs_project.getString("carriage_charge");
		rep_notes=rs_project.getString("rep_notes");
		tax_perc=rs_project.getString("tax_perc");
		creator_user_id=rs_project.getString("user_id");
		setup_cost=rs_project.getString("setup_cost");
		//out.println(projCur);
		carriage_type=rs_project.getString("carriage_type");
		carriage_loc=rs_project.getString("internal_notes");
		doc_type_alt=rs_project.getString("doc_type_alt");
								}
							    }
		if(overage==null){ overage="0";}
		if(setup_cost==null){ setup_cost="0";}
		if(handling_cost==null){ handling_cost="0";}
		if(freight_cost==null){freight_cost="0";}
		if(doc_type_alt==null){doc_type_alt="";}
		if(tax_perc.trim().length()==0){
			tax_perc=null;
		}
	Vector distinctModels=new Vector();
	ResultSet rsDistinctModels=stmt.executeQuery("select distinct model from cs_costing where order_no='"+order_no+"'");
	if(rsDistinctModels != null){
		while(rsDistinctModels.next()){
			if(rsDistinctModels.getString(1)!= null && rsDistinctModels.getString(1).trim().length()>0){
				distinctModels.addElement(rsDistinctModels.getString(1));
			}
			//out.println(rsDistinctModels.getString(1)+"::<BR>");
		}
	}
	rsDistinctModels.close();
	String note110="*PL4080*PL5700*";
	String note64="*4097AL*6097AL*";
	String note28="*DC5304*DC5704H*DC6174*DC4174*DC5704V*";
	if(qualifying_notes==null){
		qualifying_notes="";
	}

	for(int i=0; i<distinctModels.size(); i++){
		if(!qualifying_notes.endsWith(",")){
			qualifying_notes=qualifying_notes+",";
		}
		//out.println(distinctModels.elementAt(i).toString()+"::<BR>");
		if(note110.indexOf("*"+distinctModels.elementAt(i).toString().replaceAll("-","")+"*")>=0){
			qualifying_notes=qualifying_notes+"110,";
			qual_count++;
		}
		if(note64.indexOf("*"+distinctModels.elementAt(i).toString().replaceAll("-","")+"*")>=0){
			qualifying_notes=qualifying_notes+"64,";
			qual_count++;
		}
		if(note28.indexOf("*"+distinctModels.elementAt(i).toString().replaceAll("-","")+"*")>=0){
			qualifying_notes=qualifying_notes+"28,";
			qual_count++;
		}
	}
	if(qualifying_notes.endsWith(",")){
		qualifying_notes=qualifying_notes.substring(0,qualifying_notes.length()-1);
	}
	if(qualifying_notes != null&&qualifying_notes.trim().length()>1 && qualifying_notes.substring(qualifying_notes.length()-1).equals(",")){
		qualifying_notes=qualifying_notes.substring(0,qualifying_notes.length()-1);
	}
	//out.println(qualifying_notes+"::<BR>");
String exc_notes="";
String qlf_notes="";
 taxtotal=new Double(configured_price).doubleValue();
ResultSet cs_exc_notes1x = stmt.executeQuery("select code FROM cs_exc_notes where product_id='"+product+"' and set_default='y'");
if (cs_exc_notes1x !=null) {
	while (cs_exc_notes1x.next()) {
		if(exclusions==null||exclusions.trim().length()<=0){
			exclusions=exclusions+cs_exc_notes1x.getString("code");
		}
		else{
			exclusions=exclusions+","+cs_exc_notes1x.getString("code");
		}
		exc_count++;
	}
}
cs_exc_notes1x.close();
ResultSet cs_qlf_notes1x = stmt.executeQuery("select code FROM cs_qlf_notes where product_id='"+product+"' and set_default='y'");
if (cs_qlf_notes1x !=null) {
	while (cs_qlf_notes1x.next()) {
		if(qualifying_notes==null||qualifying_notes.trim().length()<=0){
			qualifying_notes=qualifying_notes+cs_qlf_notes1x.getString("code");
		}
		else{
			qualifying_notes=qualifying_notes+","+cs_qlf_notes1x.getString("code");
		}
		qual_count++;
	}
}
cs_qlf_notes1x.close();

//out.println(qualifying_notes+"::after");
if(qualifying_notes != null && qualifying_notes.trim().length()>0){
	qualifying_notes=qualifying_notes.replaceAll(",,",",");
}


boolean isCanadian=false;
boolean isInternational=false;
String session_group_id="";
ResultSet rsUser=stmt.executeQuery("select group_id from cs_reps where user_id='"+creator_user_id+"'");
if(rsUser != null){
	while(rsUser.next()){

		if(rsUser.getString(1) != null){
		//out.println(rsUser.getString(1)+":::");
			session_group_id=rsUser.getString(1);
			if(rsUser.getString(1).toUpperCase().startsWith("CAN")){
				isCanadian=true;
			}
			if(rsUser.getString(1).startsWith("Internatio")){
				isInternational=true;
			}
		}
	}
}
//out.println(isInternational);
rsUser.close();
String session_rep_no="";
String session_rep_no1="";
if(!(product.endsWith("_UK"))){
	HttpSession UserSession_rep = request.getSession();
			if(UserSession_rep!=null){
				if(UserSession_rep.getAttribute("rep_no") != null){
					session_rep_no1= UserSession_rep.getAttribute("rep_no").toString();
				}
				if(UserSession_rep.getAttribute("usergroup") != null){
					session_group_id= UserSession_rep.getAttribute("usergroup").toString();
				}

		   }
}

if(qualifying_notes != null&&qualifying_notes.trim().length()>1 && qualifying_notes.substring(qualifying_notes.length()-1).equals(",")){
	qualifying_notes=qualifying_notes.substring(0,qualifying_notes.length()-1);
}
if(qualifying_notes != null && qualifying_notes.trim().length()>0 && qualifying_notes.startsWith(",")){
	qualifying_notes=qualifying_notes.substring(1);
}
//out.println(qualifying_notes+"<BR>");
String orderCurrency=""; String xChangeRate="1"; String cur_symbol="";

//Calculating the final totals and tax
double grand_total2=0;
	double tot_sum1=0;double grand_total1=0.0;
	float grand_total3=0;
		ResultSet rs_csquotes_sum1 = stmt.executeQuery("SELECT line_no, extended_price as decimal FROM CSQUOTES where order_no='"+order_no+"'");
		if (rs_csquotes_sum1 !=null) {
			while (rs_csquotes_sum1.next()) {
				tot_sum1=tot_sum1+new Double(rs_csquotes_sum1.getString(2)).doubleValue();
			}
		}

		//out.println(tot_sum1+"::HERE2<BR>");
			if((product.equals("LVR")||product.equals("BV"))&&lvrTaxSub !=null && !lvrTaxSub.equals("null")&&lvrTaxSub.trim().length()>0){

				tot_sum1=new Double(lvrTaxSub).doubleValue();
				grand_total1=tot_sum1;
				grand_total3=Float.parseFloat(""+tot_sum1);
				//out.println(grand_total1+"::HERE3<BR>");
			}
			else{
				grand_total1=tot_sum1+new Double(overage).doubleValue()+new Double(handling_cost).doubleValue()+new Double(setup_cost).doubleValue()+new Double(freight_cost).doubleValue();
				grand_total3=Float.parseFloat(""+tot_sum1)+Float.parseFloat(overage)+Float.parseFloat(handling_cost)+Float.parseFloat(freight_cost)+Float.parseFloat(setup_cost);
				//out.println(grand_total1+"::HERE4<BR>");
			}

			double duty=0;
			if(tot_sum1>=3000){
				duty=50;
			}
			else{
				duty=25;
			}
duty=duty+tot_sum1*.011;

grand_total2=duty+tot_sum1+new Double(overage).doubleValue()+new Double(setup_cost).doubleValue()+new Double(freight_cost).doubleValue();
double tot_sum2=grand_total2;
price=""+grand_total2;
//calculating the final totals and tax done

		//out.println(xChangeRate+"<br>"+cur_symbol+"<br>"+orderCurrency);
if(agent_name==null){agent_name="";}
String cust_name1="";String cust_addr1="";String cust_addr2="";String city="";String state="";String zip_code="";String ccode="";String cust_contact_name="";
String cust_fax="";String cust_phone="";
//out.println(cust_no+":: customer number");
				if ((project_type==null)||(project_type.startsWith("nul"))||project_type.trim().length()==0){
					//ccode=cust_no.substring(0,2);

	  if ((cust_no.startsWith("US"))) {cust_no=cust_no.substring(2);

	}
	    else {ccode="US";}

ccode="US";
					ResultSet rs_customers = stmt.executeQuery("SELECT * FROM cs_customers where cust_no like '"+cust_no+"' and country_code='"+ccode+"' ");
					if (rs_customers !=null) {
				   while (rs_customers.next()) {
					bpcs_cust_no=rs_customers.getString("bpcs_cust_no");
					cust_name1= rs_customers.getString("cust_name1");
					cust_addr1= rs_customers.getString("cust_addr1");
					cust_addr2= rs_customers.getString("cust_addr2");
					city= rs_customers.getString("city");
					state= rs_customers.getString("state");
					zip_code= rs_customers.getString("zip_code");
					cust_phone= rs_customers.getString("phone");
					cust_fax= rs_customers.getString("fax");
					cust_contact_name= rs_customers.getString("contact_name");
customerCountry=rs_customers.getString("country");
				    }
				    }
				   rs_customers.close();
				}
			else{
%>
<%//@ include file="db_con_psa.jsp"%>
<%

//	    ccode=cust_no.substring(0,2);

	  if ((cust_no.startsWith("US"))) {cust_no=cust_no.substring(2);

	}
	    else {ccode="US";}


ccode="US";
	    ResultSet rs_customers = stmt.executeQuery("SELECT * FROM cs_customers where cust_no like '"+cust_no+"' and country_code='"+ccode+"' ");
	    if (rs_customers !=null) {
	  while (rs_customers.next()) {
	    bpcs_cust_no=rs_customers.getString("bpcs_cust_no");
	    cust_name1= rs_customers.getString("cust_name1");
	    cust_addr1= rs_customers.getString("cust_addr1");
	    cust_addr2= rs_customers.getString("cust_addr2");
	    city= rs_customers.getString("city");
	    state= rs_customers.getString("state");
	    zip_code= rs_customers.getString("zip_code");
	    cust_phone= rs_customers.getString("phone");
	    cust_fax= rs_customers.getString("fax");
	    cust_contact_name= rs_customers.getString("contact_name");
	   }
	   }
	  rs_customers.close();

}

if(bpcs_cust_no==null){
bpcs_cust_no="";
}
String rep_account="";String address1="";String address2="";String rep_city="";String rep_state="";String rep_zip_code="";
String rep_telephone="";String rep_fax="";String rep_email=""; String rep_name="";String rccode="";
//out.println(rep_no);
if(rep_no.length()>2){
    rccode=rep_no.substring(0,2);

    }
//	out.println(rccode);
    if((session_group_id.toUpperCase().startsWith("REP") && project_type != null && project_type.equals("PSA"))){rep_no=session_rep_no;}
    String sql="";int rep_count=0;
    ResultSet rs_rep_check = stmt.executeQuery("SELECT count(*) FROM cs_reps where rep_no like '"+rep_no+"' and user_id like '"+creator_user_id+"%' ");
	    if (rs_rep_check  !=null) {
	   while (rs_rep_check.next()) {
		rep_count= rs_rep_check.getInt(1);
		}
	    }
    rs_rep_check.close();

    if(creator_user_id==null||rep_count==0){
    sql="SELECT * FROM cs_reps where rep_no like '"+rep_no+"' order by user_id desc";
    }else{
    sql="SELECT * FROM cs_reps where rep_no like '"+rep_no+"' and user_id like '"+creator_user_id+"%' order by user_id desc ";
    }
   //out.println(creator_user_id+"::ven<BR>"+sql);
ResultSet rs_reps = stmt.executeQuery(sql);
if (rs_reps !=null) {
while (rs_reps.next()) {
//			out.println("Test");
rep_account= rs_reps.getString("rep_account");
address1= rs_reps.getString("address1");
address2= rs_reps.getString("address2");
rep_city= rs_reps.getString("rep_city");
rep_state= rs_reps.getString("state");
rep_zip_code= rs_reps.getString("zip");
rep_telephone= rs_reps.getString("telephone");
rep_fax= rs_reps.getString("fax");
rep_email= rs_reps.getString("email");
rep_name = rs_reps.getString("rep_name");
					    }
				    }


//dates
String edate="";String odate="";String doc_priority="";
ResultSet rs_eorders = stmt.executeQuery("SELECT doc_date,entry_date,doc_priority FROM doc_header where doc_number like '"+order_no+"'");
if (rs_eorders !=null) {
while (rs_eorders.next()) {
odate= rs_eorders.getString(1).substring(0,10);
edate= rs_eorders.getString(2).substring(0,10);
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
//		out.println(section_qual+" section qual<BR>");
//		out.println(section_exc+" section exc<BR>");
//		out.println(section_notes+" section notes<BR>");
secOverage=rs.getString("overage");
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
    if(startx<0 || (tempx == null || tempx.trim().length()<1)){
	    overageSec.addElement("0");
    }
    else{
	    if(tempx.trim().length()>0){
		    isSecOverage=true;
	    }
	    overageSec.addElement(tempx);
	    //out.println(tempx+"::HERE");
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
	    if(tempx.trim().length()>0){
		    isSecHandling=true;
	    }
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
    if(startx<0 || (tempx == null || tempx.trim().length()<1)){
	    setupSec.addElement("0");
    }
    else{
	    if(tempx.trim().length()>0){
		    isSecSetup=true;
	    }
	    setupSec.addElement(tempx);
	    //out.println(tempx+"::HERE");
    }
}
else{
    setupSec.addElement("");
}
//out.println("EREH"+secFreight);
if(secFreight != null && secFreight.trim().length()>0){
    int startx=secFreight.indexOf(var);
    String tempx="";
    if(startx>=0){
	    startx=startx+var.length();
	    int endx=secFreight.substring(startx).indexOf(";");
	    tempx=secFreight.substring(startx,startx+endx);
    }
    if(startx<0 || (tempx == null || tempx.trim().length()<1)){
	    freightSec.addElement("0");
    }
    else{
	    if(tempx.trim().length()>0){
		    isSecFreight=true;
	    }
	    freightSec.addElement(tempx);
	    //out.println(tempx+"::HERE");
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

// for formatting
NumberFormat for1 = NumberFormat.getCurrencyInstance();
for1.setMaximumFractionDigits(2);
NumberFormat for12x = NumberFormat.getInstance();
for12x.setMaximumFractionDigits(2);
for12x.setMinimumFractionDigits(2);
NumberFormat for13x = NumberFormat.getInstance();
for13x.setMaximumFractionDigits(0);
for13x.setMinimumFractionDigits(0);
// Reorganized code by include vs by product ID
String border_color="";
//out.println(product+" <BR>");
if(false){
// this was all wallglaze stuff
}
else {
%>
<html>
	<head>
		<title>Quote No <%= order_no %></title>
		<link rel='stylesheet' href='quotes.css' type='text/css' /></head>
	<body bgcolor="white" topmargin="25" leftmargin="25" bgcolor="white" marginheight="0" marginwidth="0">
		<%
		//out.println("::::"+pdf+":::");
			if(section_page==null||section_page.equals("0")||sections<=0){//cheking to print different pages
				String headerFile="http://"+ application.getInitParameter("INTLHOST")+"/erapid/uk/quotes/uk_quote_header.jsp";
		%>

		<%@ include file="uk_quote_header.jsp" %>
		<%
	//}
}
if(product.equals("EJC")){
	border_color="tableline_ejc";
	int k=0;String bgcolor="";Vector mark=new Vector();Vector desc=new Vector();Vector qty=new Vector();Vector rec_no=new Vector();
	Vector line_no=new Vector();String color="NONE";int bcount=0;ResultSet rs_csquotes;
		%>
		<%@ include file="quote_template_body_liprice_sections.jsp"%>
		<%
	}
	else if(product.equals("IWP")){
	//out.println("<BR><BR>HEREx<BR><BR>");
		border_color="tableline_iwp";
		%>
		<%@ include file="iwp_template_liprice_sections.jsp"%>
		<%
			}
			else if(product.equals("EFS")){
			//out.println("<BR><BR>HEREx<BR><BR>");
				border_color="tableline_iwp";
		%>
		<%@ include file="efs_template_liprice_sections.jsp"%>
		<%
			}




			if(!(product.equals("IWP")&& sections>1)){
				//out.println("HERE");
				if(((section_page==null||section_page.equals("0")))||(section_page.equals("1")&&sections==0)){
		%>
		<%@ include file="uk_quote_template_footer.jsp"%>
		<%
	}
}
}
rs_project.close();
//rs_reps.close();
//rs_eorders.close();


stmt.close();
myConn.close();

}
catch(Exception e){
out.println(e);
}
		%>
	</body>
</html>




