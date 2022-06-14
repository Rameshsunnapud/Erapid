<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="validation" 		class="com.csgroup.general.ValidationBean" 		scope="page"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
boolean sectionsGood=true;

%>
<%@ page language="java" import="java.sql.*" import="java.text.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="../../../db_con.jsp"%>

<%@ include file="../../../db_con_psa.jsp"%>
<%@ include file="../../../db_con_bpcs.jsp"%>
<%@ include file="../../../db_con_bpcsusrmm.jsp"%>
<%

	//String name=userSession.getUserId();
	//String group=userSession.getGroup();

String order_no = request.getParameter("order_no");//
//out.println(order_no+"in order transfer page::HERE");
String cmd = request.getParameter("cmd");//what page
String rep_no = request.getParameter("id");//rep_no
//out.println(rep_no);
String group_id="";
String usession_rep_no="";
String usession_user_id="";
String fpx="";
group_id=userSession.getGroup();
usession_rep_no=userSession.getRepNo();
usession_user_id=userSession.getUserId();
rep_no=userSession.getRepNo();
//out.println(rep_no+"::"+group_id+"::"+usession_rep_no+"::"+usession_user_id);







boolean isGood=true;
String resendlinks="";

   String rep_no_end="";
   ResultSet rsEndUser=stmt.executeQuery("select created_rep_no from cs_billed_customers where order_no='"+order_no+"'");
   if(rsEndUser != null){
		 while(rsEndUser.next()){
			    rep_no_end=rsEndUser.getString(1);
		 }
   }
   //out.println(rep_no+"< -- >"+rep_no_end+"<BR>");
   if(rep_no_end != null && rep_no_end.trim().length()>0 && !rep_no_end.equals("null")){
		 rep_no=rep_no_end;
   }
   //out.println(rep_no);
   // Getting current Date
   java.util.Date uDate = new java.util.Date(); // Right now
//	uDate
   java.sql.Date sDate = new java.sql.Date(uDate.getTime());
%>

<%
Vector countryCodes=new Vector();Vector countrydesc=new Vector();
ResultSet rsCountryCodes=stmt.executeQuery("select * from cs_state_codes order by country_code desc,state_name ");
if(rsCountryCodes != null){
        while(rsCountryCodes.next()){
                countryCodes.addElement(rsCountryCodes.getString(1));
                countrydesc.addElement(rsCountryCodes.getString(2));
                //out.println(rsCountryCodes.getString(1));
        }
}
rsCountryCodes.close();
//country codes

Vector ccodes=new Vector();Vector cdesc=new Vector();
ResultSet rsCountry=stmt.executeQuery("select * from cs_country_codes order by 2 ");
if(rsCountry != null){
        while(rsCountry.next()){
                ccodes.addElement(rsCountry.getString(1));
                cdesc.addElement(rsCountry.getString(2));
                //out.println(rsCountryCodes.getString(1));
        }
}
rsCountry.close();
if(group_id.toUpperCase().startsWith("CAN")){
        ResultSet rsCountryCodes2=stmt.executeQuery("select * from cs_state_codes where country_code='CA'");
        if(rsCountryCodes2 != null){
                while(rsCountryCodes2.next()){
                        countryCodes.addElement(rsCountryCodes2.getString(1));
                        countrydesc.addElement(rsCountryCodes2.getString(2));
                }
        }
        rsCountryCodes2.close();
}

String user_group=group_id;
/*
ResultSet rs_logia_group = stmts.executeQuery("SELECT * FROM logia_group where group_id = '"+group_id+"'");
        if (rs_logia_group != null){
                while (rs_logia_group.next()){
                        user_group= rs_logia_group.getString("group_id");
                 }
        }
        rs_logia_group.close();
*/


//global
String Project_name="";String Job_loc="";String Arch_name="";String Arch_loc="";String Arch_city="";
String overage="";String commPerc="";String commDollar="";String freight_cost="";String handling_cost="";String setup_cost="";String project_state="";String product="";
String config_price="";String quote_type="";String quote_type2="";String Cust_name="";String commission="";String project_type="";String project_rep_no="";String project_group_id="";String project_order_rep_no="";
Vector items=new Vector();int line=0;String agent_name="";String psa_quote_id="";String tax_zip="";String georder=""; String group_code="";String quote_origin="";
String nonconfigDesc="";
boolean isBpcsClosed=false;

String spec_rep_acct_id="";String terr_rep_acct_id="";String order_rep_acct_id="";// for different account types from PSA
//Project information
String bpcs_order_no="";
                ResultSet rs_project = stmt.executeQuery("SELECT * FROM cs_project where Order_no like '"+order_no+"' ");
                if (rs_project !=null) {
        while (rs_project.next()) {
                Project_name= rs_project.getString("Project_name");
			 bpcs_order_no=rs_project.getString("bpcs_order_no");
                Job_loc= rs_project.getString("Job_loc");
                Arch_name= rs_project.getString("Arch_name");
                Arch_loc= rs_project.getString("Arch_loc");
                if(rs_project.getString("overage") != null && rs_project.getString("overage").trim().length()>0){
                        overage= rs_project.getString("overage");}
                else{
                        overage="0";
                }
                if(rs_project.getString("freight_cost") != null && rs_project.getString("freight_cost").trim().length()>0){
                        freight_cost= rs_project.getString("freight_cost");
                }
                else{
                        freight_cost="0";
                }
                if(rs_project.getString("handling_cost") != null && rs_project.getString("handling_cost").trim().length()>0){
                        handling_cost = rs_project.getString("handling_cost");
                }
                else{
                        handling_cost = "0";
                }
                if(rs_project.getString("setup_cost") != null && rs_project.getString("setup_cost").trim().length()>0){
                        setup_cost= rs_project.getString("setup_cost");
                }
                else{
                        setup_cost="0";
                }
                if(rs_project.getString("configured_price") != null && rs_project.getString("configured_price").trim().length()>0){
                        config_price= rs_project.getString("configured_price");
                }
                else{
                        config_price="0";
                }
                project_state= rs_project.getString("project_state");
                product= rs_project.getString("product_id");
                Cust_name= rs_project.getString("Cust_name");
                commission= rs_project.getString("commission");
                commDollar=rs_project.getString("comm_dollars");
                project_type= rs_project.getString("project_type");
			 if(project_type !=null && project_type.equals("RP")){
				fpx="rp";
			}
                psa_quote_id=rs_project.getString("project_type_id");
                nonconfigDesc=rs_project.getString("non_config_desc");
                agent_name=rs_project.getString("agent_name");
                project_rep_no=rs_project.getString("creator_id");
			//out.println(project_rep_no+":: project rep no");
                project_order_rep_no=rs_project.getString("order_rep");
                tax_zip=rs_project.getString("tax_zip");
                georder=rs_project.getString("doc_type_alt");
                group_code=rs_project.getString("group_code");
                quote_origin=rs_project.getString("quote_origin");
                                                    }
                                                   }
                                                   rs_project.close();

                if(nonconfigDesc==null){nonconfigDesc="";}
        if(setup_cost==null|setup_cost.trim().equals("")){setup_cost="0";}
        if(handling_cost==null|handling_cost.trim().equals("")){handling_cost="0";}
        if(freight_cost==null|freight_cost.trim().equals("")){freight_cost="0";}
        if(overage==null|overage.trim().equals("")){overage="0";}
        if(config_price==null|config_price.trim().equals("")){config_price="0";}
        if(commission==null){commission="0";}
        if(commDollar==null){commDollar ="0";}
        if(agent_name==null){agent_name="";}
        if(project_type==null){project_type="";}
        if(georder==null){georder="";}
        if(quote_origin==null){
                quote_origin="";
        }
	   if(bpcs_order_no==null){
		bpcs_order_no="";
		}

		if(bpcs_order_no!=null && bpcs_order_no.trim().length()>0){
			isBpcsClosed=validation.checkBpcsOrderClose(bpcs_order_no);
		}
if(project_rep_no == null || project_rep_no.length()==0 || project_rep_no.equals("null")){
	project_rep_no=userSession.getRepNo();
}

	if(isBpcsClosed){
		ResultSet rs_billed=stmt.executeQuery("select order_type from cs_billed_customers where order_no='"+order_no+"'");
		if(rs_billed != null){
			while(rs_billed.next()){
				if(rs_billed.getString(1).toUpperCase().startsWith("ADD")){
					isGood=false;
				}
			}
		}
		rs_billed.close();
	}


        if(Job_loc==null){
                Job_loc="";
        }

        Job_loc=Job_loc.replaceAll("'","");
        //out.println("GROUP CODE::"+group_code+"::");
ResultSet rsprojectgroup=stmt.executeQuery("select group_id from cs_reps where rep_no='"+project_rep_no+"'");
if(rsprojectgroup != null){
        while(rsprojectgroup.next()){
                project_group_id=rsprojectgroup.getString(1);
user_group=rsprojectgroup.getString(1);
        }
}
rsprojectgroup.close();

                ResultSet rs_eorders = stmt.executeQuery("SELECT doc_priority FROM doc_header where doc_number like '"+order_no+"' ");
                if (rs_eorders !=null) {
        while (rs_eorders.next()) {
                quote_type=rs_eorders.getString("doc_priority");
//out.println(quote_type+"::<BR>");
                                                                  }
                                                           }
                                                          rs_eorders.close();
//out.println(quote_type+":: quote type"+order_no);
                quote_type2=quote_type;

                if(quote_type.equals("C")){quote_type="CS";}
                else if(quote_type.equals("E")){ quote_type="DECOGARD";}
                else{quote_type="DECOLINK";}



double totmat_price=0;
                totmat_price=(new Double(config_price).doubleValue())+(new Double(overage).doubleValue())+(new Double(setup_cost).doubleValue())+(new Double(handling_cost).doubleValue())+(new Double(freight_cost).doubleValue());
                if ((Arch_name.equals(" "))|(Arch_name==null)|(Arch_name.equals(""))){Arch_name="@";}
        //Tokens of the string
if(Arch_loc.trim().length()>0){
StringTokenizer	acity=new StringTokenizer(Arch_loc,",");
Arch_city=acity.nextToken().toString();
}else {Arch_city="";}
// Checking the no of lines
                ResultSet rs1 = stmt.executeQuery("SELECT doc_line FROM doc_line where doc_number like '"+order_no+"' order by cast(doc_line as integer)");
        while ( rs1.next() ) {
		items.addElement(rs1.getString("doc_line"));
                line++;
                                                 }
                                                 rs1.close();
  String isSections=""; String isZeroSections="";String ow_sent="";
  ResultSet rsSections=stmt.executeQuery("Select section_group,sections,owssent from cs_quote_sections where order_no like '"+order_no+"'");
  if(rsSections != null){
          while(rsSections.next()){
                  isSections=rsSections.getString(1);
                  isZeroSections=rsSections.getString(2);
                  ow_sent=rsSections.getString(3);
          }
  }
  rsSections.close();
  if(isSections != null && isSections.length()>0 && !isZeroSections.equals("0")){
          //out.println("nothing needed<BR>");
  }
  else{
        //  out.println("sections not available<BR>");
          isSections="NO";
  }
  if(ow_sent==null){ow_sent="N";}
int sectionCount=0;

if(isSections.equals("NO")){
        String section_infoX="s1=ALL;";
        String sections="0";
        String section_groupx="";
        for(int rp=0; rp<items.size(); rp++){
                section_groupx += items.elementAt(rp).toString()+"=s1;";
        }
        //out.println(section_groupx+"< here<Br>");

        ResultSet rsSectionCount=stmt.executeQuery("Select count(*) from cs_quote_sections where order_no like '"+order_no+"'");
        while(rsSectionCount.next()){
                sectionCount=rsSectionCount.getInt(1);
        }
        rsSectionCount.close();
        myConn.setAutoCommit(false);
        if(sectionCount<=0){
                //insert
                try{
                        String insert ="INSERT INTO cs_quote_sections(order_no,section_info,sections,section_group)VALUES(?,?,?,?) ";
                        PreparedStatement update_sections = myConn.prepareStatement(insert);
                                update_sections.setString(1,order_no);
                                update_sections.setString(2,section_infoX);
                                update_sections.setString(3,sections);
                                update_sections.setString(4,section_groupx);
                                int rocount = update_sections.executeUpdate();
                                update_sections.close();
                }
                catch(java.sql.SQLException e){
                        out.println("Problem with entering saved sections"+"<br>");
                        out.println("Illegal Operation try again/Report Error"+"<br>");
                        myConn.rollback();
                        out.println(e.toString());
                        return;
                }

        }
        else{
                //update
                try{
                        int nrow= stmt.executeUpdate("UPDATE cs_quote_sections SET section_info='"+section_infoX+"', sections='"+sections+"',section_group='"+ section_groupx +"' WHERE order_no ='"+order_no+"'");
                }
                catch(java.sql.SQLException e){
                        out.println("Problem with updating saved sections"+"<br>");
                        out.println("Illegal Operation try again/Report Error"+"<br>");
                        myConn.rollback();
                        out.println(e.toString());
                        return;
                }
        }
        myConn.commit();
}
// Checking the no of lines	done
// Global cs_billed_customer
int cust_bill=0;
if(project_type != null && project_type.equals("NCP")){
String message=""+order_no;
out.println("<h1>"+message+"</h1>");
}
// ************Code added for the shock wave tiers on May12'09************
//IWP tiers
                        if(product.equals("IWP")){
                        String bpcs_tier="";boolean iwp_tier1=false;boolean iwp_tier2=false;boolean iwp_tier3=false;
                        ResultSet rs_discount = stmt.executeQuery("Select bpcs_tier from csquotes where order_no like '"+ order_no +"'");
                        if(rs_discount != null){
                                while(rs_discount.next()){
                                        bpcs_tier=rs_discount.getString(1);
                                        if(bpcs_tier != null && bpcs_tier.trim().length()>0){
                                                //Start for IWP
                                                if(product.equals("IWP")){
                                                   if(bpcs_tier.equals("1")&& !iwp_tier1){
                                                           iwp_tier1=true;
                                                         //  out.println("tier1");
                                                   }else if	(bpcs_tier.equals("2")&& !iwp_tier2){
                                                           iwp_tier2=true;
                                                        //   out.println("tier2");
                                                   }else if (bpcs_tier.equals("3")&& !iwp_tier3){
                                                           iwp_tier3=true;
                                                         //  out.println("tier3");
                                                   }
                                                }//End for IWP
                                        }
                                }
                        }
                        rs_discount.close();
                        if(iwp_tier3){bpcs_tier="3";}else if(iwp_tier2){bpcs_tier="2";}else if(iwp_tier1){bpcs_tier="1";}
                        //out.println("the final"+bpcs_tier);
                        //updating the tier to cs_project table
                                myConn.setAutoCommit(false);
                                try
                                {
                                java.sql.PreparedStatement ps=myConn.prepareStatement("UPDATE cs_project SET bpcs_tier =? WHERE Order_no =? ");
                                ps.setString(1,bpcs_tier);
                                ps.setString(2,order_no);
                                int re=ps.executeUpdate();
                                ps.close();
                                }
                                catch (java.sql.SQLException e)
                                {
                                        out.println("Problem with ENTERING Projects table to update tier info"+"<br>");
                                        out.println("Illegal Operation try again/Report Error"+"<br>");
                                        myConn.rollback();
                                        out.println(e.toString());
                                        return;
                                }
                                myConn.commit();
                        }//updating tier info to cs_project table done
// ************Code added for the shock wave tiers on May12'09************done

// *****************for getting order reps***************
// Getting all the rep accounts
 Vector psa_reps=new Vector(); Vector psa_rep_names=new Vector();
 if(project_type.equals("PSA")|!group_id.toUpperCase().equals("REP")|project_rep_no.equals("999")){//for any non rep quotes
                ResultSet psaAccount=stmt_psa.executeQuery("Select * FROM dba.cs_rep order by 1");
                if(psaAccount != null){
                        while(psaAccount.next()){
                                //if(psaAccount.getString(1).length()==3){
                                try{
                                        int tempint=Integer.parseInt(psaAccount.getString(1));
                                        psa_reps.addElement(psaAccount.getString(1));
                                        psa_rep_names.addElement(psaAccount.getString(2));
                                }
                                catch(Exception e){

                                }
                                //}
                                //out.println(psaAccount.getString(1)+":::"+psaAccount.getString(2)+"::<BR>");
                        }
                }
        if(project_order_rep_no==null){
                if(project_type.equals("PSA")){//only for PSA quotes
                String psa_pid="";
                   ResultSet rs_psa_reps = stmt_psa.executeQuery("SELECT * FROM dba.quotation where quote_id like '"+psa_quote_id+"%"+"' order by 1 desc ");
               while ( rs_psa_reps.next() ) {
                   psa_pid= rs_psa_reps.getString("project_id");
                }
               rs_psa_reps.close();
                        ResultSet rs_psa_proj_ac_link = stmt_psa.executeQuery("SELECT * FROM dba.proj_ac_link where project_id like '"+psa_pid+"' order by link_id");
                        if (rs_psa_proj_ac_link !=null) {
                        while (rs_psa_proj_ac_link.next()) {
                                                if(rs_psa_proj_ac_link.getString("role_type_id").equals("8")){terr_rep_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");}
                                                if(rs_psa_proj_ac_link.getString("role_type_id").equals("7")){spec_rep_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");}
                                                if(rs_psa_proj_ac_link.getString("role_type_id").equals("10")){order_rep_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");}
                                }
                        }
                        rs_psa_proj_ac_link.close();
//out.println(rep_no);
                        ResultSet psaAccount1=stmt_psa.executeQuery("Select rep_ID FROM dba.cs_rep where acct_id='"+order_rep_acct_id+"'");
                        if(psaAccount1 != null){
                                while(psaAccount1.next()){
                                        order_rep_acct_id=psaAccount1.getString(1);
                                //assigning the rep no to rep_no variable also
                                        rep_no=psaAccount1.getString(1);
                                        //out.println(rep_no);
                                        //out.println(order_rep_acct_id);
                                }
                        }
                        //out.println(rep_no);
                }	//only for  PSA quotes
         }else{
                 order_rep_acct_id=project_order_rep_no;
         }
        }		//for any non rep quotes

// *****************for getting order reps done***************

if(cmd.equals("1")){

                //out.println("HERE");
                String cust_name1="";String cust_addr1="";String cust_addr2="";String city="";String state="";String zip_code="";String Country_Code="";
                String phone="";String fax="";String contact_name="";String customer_po_no="";String sales_exempt_no="";
                String customer_type="";String market_type="";String cs_company="";String doc_type="";String add_deduct_job="";String payment_terms="";
                int cou=0;String type_of_cust="old";String market_type1="";String sales_region="";String show="";String cust_ship_info="";String cust_invoice_info="";String end_user_info="";
                //cs_enduser table
                String billed_email="";String email_acknowledgement="";
                String eu_cust_name1="";String eu_bpcs_cust_no="";String eu_bpcs_cust_no_alt="";String eu_cust_addr1="";String eu_cust_addr2="";String eu_city="";String eu_state="";String eu_zip_code="";
                String eu_phone="";String eu_fax="";
                //cs_customers table
                String cust_name11="";String cust_addr11="";String cust_addr21="";String cust_city1="";String cust_state1="";
                String cust_zip_code1="";String cust_phone1="";String cust_fax1="";String cust_country="";
                String bpcs_cust_no="";String bpcs_cust_no_alt="";
                 Country_Code = Cust_name.substring(0,2);
        if ((Country_Code.equals("GB")) | (Country_Code.equals("US"))){	Cust_name=Cust_name.substring(2);}
boolean repIsNumeric=false;
try{
	double d = Double.parseDouble(Cust_name);
	repIsNumeric=true;
}
catch(Exception e){
	repIsNumeric=false;
}
        if(project_type.equals("SFDC")||project_type.equals("RP")){
%>
<%@ include file="../../../db_con_sfdc.jsp"%>
<%
ResultSet rsSf=stmt_sfdc.executeQuery("select * from contact where id='"+Cust_name+"'");
if(rsSf != null){
        while(rsSf.next()){
                if(rsSf.getString("name")!=null && !rsSf.getString("name").equals("null") && rsSf.getString("name").trim().length()>0){
                        cust_name11=rsSf.getString("name");
                }
                if(rsSf.getString("Street_Name__c")!=null && !rsSf.getString("Street_Name__c").equals("null") && rsSf.getString("Street_Name__c").trim().length()>0){
                        cust_addr11=rsSf.getString("Street_Name__c");
                }
                if(rsSf.getString("City_or_Town__c")!=null && !rsSf.getString("City_or_Town__c").equals("null") && rsSf.getString("City_or_Town__c").trim().length()>0){
                        cust_city1=rsSf.getString("City_or_Town__c");
                }
                if(rsSf.getString("State_or_Province__c")!=null && !rsSf.getString("State_or_Province__c").equals("null") && rsSf.getString("State_or_Province__c").trim().length()>0){
                        cust_state1=rsSf.getString("State_or_Province__c");
                }
                if(rsSf.getString("Postal_Code_or_Zip_Code__c")!=null && !rsSf.getString("Postal_Code_or_Zip_Code__c").equals("null") && rsSf.getString("Postal_Code_or_Zip_Code__c").trim().length()>0){
                        cust_zip_code1=rsSf.getString("Postal_Code_or_Zip_Code__c");
                }
                if(rsSf.getString("Phone")!=null && !rsSf.getString("Phone").equals("null") && rsSf.getString("Phone").trim().length()>0){
                        cust_phone1=rsSf.getString("Phone");
                }
                if(rsSf.getString("Fax")!=null && !rsSf.getString("Fax").equals("null") && rsSf.getString("Fax").trim().length()>0){
                        cust_fax1=rsSf.getString("Fax");
                }
        }
}
rsSf.close();
stmt_sfdc.close();
myConn_sfdc.close();

}
if(!(project_type.equals("SFDC")||project_type.equals("RP"))||(project_type.equals("SFDC")&&group_id.toUpperCase().indexOf("REP")>=0&&repIsNumeric)){
       ResultSet rs_customer1 = stmt.executeQuery("SELECT * FROM cs_customers where cust_no='"+Cust_name+"' and country_code <>'GB' ");
        if (rs_customer1 !=null) {
                while ( rs_customer1.next() ) {
                        cust_name11= rs_customer1.getString("cust_name1");
                        cust_addr11= rs_customer1.getString("cust_addr1");
                        cust_addr21= rs_customer1.getString("cust_addr2");
                        cust_city1= rs_customer1.getString("city");
                        cust_state1= rs_customer1.getString("state");
                        cust_zip_code1= rs_customer1.getString("zip_code");
                        cust_phone1= rs_customer1.getString("phone");
                        cust_fax1= rs_customer1.getString("fax");
                        //out.println(rs_customer1.getString("bill_cust")+"::HERE");
                        show= rs_customer1.getString("bill_cust");

                }
        }
        rs_customer1.close();
}
if(show==null){
        show="N";
}

//}


// The cs_customers data done

ResultSet rs_bill = stmt.executeQuery("SELECT * FROM cs_billed_customers where order_no like '"+order_no+"'");
//out.println(order_no+"::<BR>");
if (rs_bill !=null) {
while (rs_bill.next()) {
//out.println(rs_bill.getInt("cust_no")+"::<BR>");
cust_bill= rs_bill.getInt("cust_no");
cust_name1= rs_bill.getString("cust_name1");
cust_addr1= rs_bill.getString("cust_addr1");
cust_addr2= rs_bill.getString("cust_addr2");
city= rs_bill.getString("city");
state= rs_bill.getString("state");
zip_code= rs_bill.getString("zip_code");
cust_country=rs_bill.getString("country_code");
phone= rs_bill.getString("phone");
fax= rs_bill.getString("fax");
contact_name= rs_bill.getString("contact_name");
customer_po_no= rs_bill.getString("customer_po_no");
sales_exempt_no= rs_bill.getString("sales_exempt_no");
market_type= rs_bill.getString("market_type");
cs_company= rs_bill.getString("cs_company");
doc_type= rs_bill.getString("order_type");
add_deduct_job= rs_bill.getString("add_deduct_job");
payment_terms= rs_bill.getString("payment_terms");
sales_region= rs_bill.getString("sales_region");
customer_type= rs_bill.getString("customer_type");
cust_ship_info= rs_bill.getString("ship_info");
end_user_info=rs_bill.getString("end_user_info");
cust_invoice_info= rs_bill.getString("invoice_info");
bpcs_cust_no=rs_bill.getString("bpcs_cust_no");
bpcs_cust_no_alt=rs_bill.getString("alt_no");
billed_email=rs_bill.getString("email");
email_acknowledgement=rs_bill.getString("email_acknowledgement");
cou++;
                                    }
                }
                rs_bill.close();
//out.println(doc_type+"::"+quote_origin);
if(doc_type == null || doc_type.trim().length()==0){
	//out.println("EMPTY DOC TYPE"+quote_origin);
	if(quote_origin.equals("build")){
		bpcs_order_no="";
	}
	else if(quote_origin.equals("release")||quote_origin.equals("change")||quote_origin.equals("submittal")||quote_origin.equals("revision")){
		doc_type="ADD";
	}
}
if(email_acknowledgement==null){
email_acknowledgement="";
}
//out.println(bpcs_cust_no_alt+"::<BR>");
if(bpcs_cust_no_alt==null){
bpcs_cust_no_alt="";
}
//

if(!(product.equals("GE"))){
//sales_region="";
if(sales_region == null || sales_region.equals("null")||sales_region.trim().length()==0){
try{
%>
<%@ include file="../../../db_con_rep_data.jsp"%>
<%
String regionQuery="";
String tempProduct=product;
if(product.equals("EJC")){
        tempProduct="TPG";
}
else if(product.equals("GE")){
        tempProduct="PRKGEJ";
}
else if(product.equals("GRILLE")){
        tempProduct="GRL";
}
else if(product.equals("GCP")){
        tempProduct="GC";
}
String tempType=quote_type;
if((product.equals("IWP")||product.equals("EFS")||product.equals("GCP")||product.equals("ADS"))){
        if(quote_type.startsWith("C")){tempType="CS";}
        else { tempType="DECO";}
}
else{
        tempType="";
}

//out.println("select dba.lookup_text from user_lookup where lookup_id = (select quote_region from dba.quotation where elogia_no='"+order_no+"'");

ResultSet rs_psa_region=stmt_psa.executeQuery("select lookup_text from dba.user_lookup where lookup_id = (select quote_region from dba.quotation where elogia_no='"+order_no+"')");
if(rs_psa_region != null){
        while(rs_psa_region.next()){
                if(rs_psa_region.getString(1) != null && rs_psa_region.getString(1).trim().length()>0){
                        //out.println(rs_psa_region.getString(1)+product+"::<BR>");
                        if(product.equals("ADS")){
                                //out.println("HERE");
                                sales_region=rs_psa_region.getString(1).substring(0,2)+" - "+product;
                        }
                        else{
                                sales_region=rs_psa_region.getString(1).substring(0,1)+"--"+product;
                                //out.println(product+":::"+sales_region+"<--from psa::1<BR>");
                        }
                }
        }
}
rs_psa_region.close();

//out.println(sales_region);
regionQuery="select distinct "+tempProduct+"REGION from tax_rep2 where "+tempProduct+tempType+"REP ='"+rep_no+"'";
if(rep_no != null && (rep_no.trim().equals("291") || rep_no.trim().equals("401"))){
        regionQuery="select distinct "+tempProduct+"REGION from tax_rep2 where "+tempProduct+tempType+"REP in ('401','291')";
}
else if(group_id.toUpperCase().startsWith("REP")){
        regionQuery="select distinct "+tempProduct+"REGION from tax_rep2 where "+tempProduct+tempType+"REP ='"+usession_rep_no+"'";
}
//	out.println(regionQuery+":::<BR>");
if(sales_region == null || sales_region.equals("null")||sales_region.trim().length()==0){
        ResultSet rsRepData=stmtRepData.executeQuery(regionQuery);
        if(rsRepData != null){
                while(rsRepData.next()){
                        sales_region=rsRepData.getString(1)+"--"+product;
                }
        }
        rsRepData.close();
}

stmtRepData.close();
myConnRepData.close();
}
catch(Exception e){
//out.println("HERE");
out.println(e);
}
}
}

else{//for ge go to BPCS to get the region
if(sales_region == null || sales_region.equals("null")||sales_region.trim().length()==0){
ResultSet rs=stmt_bpcs.executeQuery("Select CCNOT1 from zcc where CCTABL = 'CUSTGRP' and CCSDSC='GE' and CCCODE='"+group_code+"' ");
if(rs !=null){
while(rs.next()){
        sales_region=rs.getString(1).trim();
        //out.println("<Td>"+rs.getString(1)+"</td></tr>");
}
}
rs.close();
}
}

if(group_id.toUpperCase().startsWith("REP")&&georder.equals("GE")){
sales_region="PD";
}


if(billed_email==null){billed_email="";}
if(payment_terms==null){payment_terms="";}
if(cust_ship_info==null){cust_ship_info="";}
if(end_user_info==null){end_user_info="";}
if(cust_invoice_info==null){cust_invoice_info="";}
if(cust_name1==null||cust_name1.trim().startsWith("nu")){cust_name1="";}
if(bpcs_cust_no==null||bpcs_cust_no.trim().startsWith("nu")){bpcs_cust_no="";}
if(cust_addr1==null||cust_addr1.trim().startsWith("nu")){cust_addr1="";}
if(cust_addr2==null||cust_addr2.trim().startsWith("nu")){cust_addr2="";}
if(city==null||city.trim().startsWith("nu")){city="";}
if(state==null||state.trim().startsWith("nu")){state="";}
if(cust_country==null||cust_country.trim().startsWith("nu")){cust_country="US";}
if(zip_code==null||zip_code.trim().startsWith("nu")){zip_code="";}
if(phone==null||phone.trim().startsWith("nu")){phone="";}
if(customer_po_no==null||customer_po_no.trim().startsWith("nu")){customer_po_no="";}
if(fax==null||fax.trim().startsWith("nu")){fax="";}
if(contact_name==null||contact_name.trim().startsWith("nul")||contact_name.trim().length()<=0){contact_name=agent_name;}
if(sales_exempt_no==null||sales_exempt_no.trim().startsWith("nu")){sales_exempt_no="";}
//out.println("Testing:"+contact_name+":"+agent_name);





//out.println(quote_type2+":: quote type 2");

if(cs_company==null||cs_company.trim().startsWith("nul")||cs_company.trim().length()<=0){
if(product.equals("LVR")||product.equals("BV")||product.equals("GRILLE")||product.equals("GCP")||product.equals("SUNSHADE")){
cs_company="CS-CRANFORD";
}
else if(product.equals("GE")){
cs_company="GRAND ENTRANCE";
}
else if(product.equals("EJC")){
cs_company="CS-MUNCY";
}
else{
if(georder.equals("GE")){
cs_company="GRAND ENTRANCE";
}
else if(quote_type2.equals("E") && georder.trim().length()==0){
cs_company="DG - CS Facility Sales (decogard)";
}
else if(quote_type2.equals("D")||quote_type2.equals("E") && georder.equals("dl")){
cs_company="DL - CS Eldercare (decolink)";
}
else if(quote_type2.equals("C")){
if(product.equals("ADS")){
        cs_company="TR - CS Trade";
}
else{
        cs_company="CS-MUNCY";
}
}
}
if(group_id.startsWith("Decolink")){
cs_company="DL - CS Eldercare (decolink)";
}
if(group_id.startsWith("Internatio")){
cs_company="CS-INTERNATIONAL";
}
}








//special deaults to decolink user group
if(user_group.toUpperCase().equals("DECOLINK")){
if(customer_type==null||customer_type.trim().startsWith("nul")||customer_type.trim().length()<=0){customer_type="EU-END USER";}
}
//special deaults to decolink user group done
if(cou<=0){
// getting the customer FROM cs_project if the billed customer doesn't exist
ResultSet rs_customer = stmt.executeQuery("SELECT * FROM cs_end_users where order_no like '"+order_no+"'");
int coun=0;
if (rs_customer !=null) {
while ( rs_customer.next() ) {
eu_cust_name1= rs_customer.getString("cust_name1");
eu_cust_addr1= rs_customer.getString("cust_addr1");
eu_cust_addr2= rs_customer.getString("cust_addr2");
eu_city= rs_customer.getString("city");
eu_state= rs_customer.getString("state");
eu_zip_code= rs_customer.getString("zip_code");
eu_phone= rs_customer.getString("phone");
eu_fax= rs_customer.getString("fax");
market_type1= rs_customer.getString("market_type");
eu_bpcs_cust_no=rs_customer.getString("bpcs_cust_no");
eu_bpcs_cust_no_alt=rs_customer.getString("alt_no");
coun++;
                                         }
                                        }
                                        rs_customer.close();
type_of_cust="new";
}
else{
ResultSet rs_customer = stmt.executeQuery("SELECT * FROM cs_end_users where order_no like '"+order_no+"'");
int coun=0;
if (rs_customer !=null) {
while ( rs_customer.next() ) {
eu_cust_name1= rs_customer.getString("cust_name1");
eu_cust_addr1= rs_customer.getString("cust_addr1");
eu_cust_addr2= rs_customer.getString("cust_addr2");
eu_city= rs_customer.getString("city");
eu_state= rs_customer.getString("state");
eu_zip_code= rs_customer.getString("zip_code");
eu_phone= rs_customer.getString("phone");
eu_fax= rs_customer.getString("fax");
market_type1= rs_customer.getString("market_type");
eu_bpcs_cust_no=rs_customer.getString("bpcs_cust_no");
eu_bpcs_cust_no_alt=rs_customer.getString("alt_no");
coun++;
                                         }
                                        }
if(eu_bpcs_cust_no== null  || eu_bpcs_cust_no.equals("null")){
eu_bpcs_cust_no="";
}								rs_customer.close();
}
if(eu_bpcs_cust_no_alt ==null){
eu_bpcs_cust_no_alt="";
}


%>
<%@ include file="order_page1.jsp"%>
<%
        }
else if(cmd.equals("2")){

//  Getting to see if the credit card is needed or not
// CHecking the type of payment
               int count_cust=0;String payment_terms="";String bpcs_cust_no="";
               String cust_name1="";String cust_addr1="";String cust_addr2="";String cust_city="";String cust_state="";String cust_zip_code="";String cust_ship_info="";String cust_invoice_info="";String end_user_info="";
               String cust_phone="";String cust_fax="";
               ResultSet rs_bill1 = stmt.executeQuery("SELECT * FROM cs_billed_customers where order_no like '"+order_no+"' ");
               if (rs_bill1 !=null) {
       while (rs_bill1.next()) {
               cust_name1= rs_bill1.getString("cust_name1");
               cust_addr1= rs_bill1.getString("cust_addr1");
               cust_addr2= rs_bill1.getString("cust_addr2");
               cust_city= rs_bill1.getString("city");
               cust_state= rs_bill1.getString("state");
               cust_zip_code= rs_bill1.getString("zip_code");
               cust_phone= rs_bill1.getString("phone");
               cust_fax= rs_bill1.getString("fax");
               payment_terms= rs_bill1.getString("payment_terms");
               cust_ship_info= rs_bill1.getString("ship_info");
               end_user_info= rs_bill1.getString("end_user_info");
               cust_invoice_info= rs_bill1.getString("invoice_info");
               bpcs_cust_no=rs_bill1.getString("bpcs_cust_no");
               count_cust++;
                                                          }
                                                  }
                                                  rs_bill1.close();
if(cust_name1==null||cust_name1.trim().startsWith("nu")){cust_name1="";}
if(cust_addr1==null||cust_addr1.trim().startsWith("nu")){cust_addr1="";}
if(cust_addr2==null||cust_addr2.trim().startsWith("nu")){cust_addr2="";}
if(cust_city==null||cust_city.trim().startsWith("nu")){cust_city="";}
if(cust_state==null||cust_state.trim().startsWith("nu")){cust_state="";}
if(cust_zip_code==null||cust_zip_code.trim().startsWith("nu")){cust_zip_code="";}
if(cust_phone==null||cust_phone.trim().startsWith("nu")){cust_phone="";}
if(cust_fax==null||cust_fax.trim().startsWith("nu")){cust_fax="";}
if(payment_terms==null){payment_terms="";}
if(cust_ship_info==null){cust_ship_info="";}
if(end_user_info==null){end_user_info="";}
if(cust_invoice_info==null){cust_invoice_info="";}
//Ship variables
String ship_name="";String ship_addr1="";String ship_addr2="";String city="";String state="";
String zip="";String ship_phone="";String ship_fax="";String ship_email="";String ship_method="";
String ship_tax_exempt="";String ship_terms="";String ship_cust_bpcs_no="";String ship_cust_bpcs_no_alt="";
String ship_rdate="";String ship_edate="";String ship_fdate="";
String attention_ship="";
String notice_ship="";
String name_ship="";
String phone_ship="";
String attention_invoice="";
// Getting the shipping info
               ResultSet rs_ship = stmt.executeQuery("SELECT * FROM SHIPPING where Order_no like '"+order_no+"' ");
               if (rs_ship !=null) {
       while (rs_ship.next()) {
               ship_name= rs_ship.getString("Name_1");
               ship_addr1= rs_ship.getString("Address_1");
               ship_addr2= rs_ship.getString("Address_2");
               city= rs_ship.getString("City");
               state= rs_ship.getString("State");
               zip= rs_ship.getString("Zip_code");
               ship_phone= rs_ship.getString("Phone");
               ship_fax= rs_ship.getString("fax");
               ship_email= rs_ship.getString("email");
               ship_method= rs_ship.getString("ship_method");
               ship_tax_exempt= rs_ship.getString("sales_exempt_number");
               ship_terms= rs_ship.getString("ship_terms");
               ship_rdate= rs_ship.getString("request_date");
               ship_edate= rs_ship.getString("estimated_date");
               ship_fdate= rs_ship.getString("firm_date");
               attention_ship=rs_ship.getString("attention");
               notice_ship=rs_ship.getString("prior_notice");
               name_ship=rs_ship.getString("prior_notice_name");
               phone_ship=rs_ship.getString("prior_notice_phone");
               ship_cust_bpcs_no=rs_ship.getString("bpcs_cust_no");
               ship_cust_bpcs_no_alt=rs_ship.getString("alt_no");
                                                          }
                                                  }
                                                  rs_ship.close();
                                                  if(ship_name==null){ship_name="";}
if(ship_cust_bpcs_no==null){ship_cust_bpcs_no="";}
if(ship_addr1==null){ship_addr1="";}
if(ship_addr2==null){ship_addr2="";}
if(city==null){city="";}
if(state==null){state="";}
if(zip==null){zip="";}
if(ship_phone==null){ship_phone="";}
if(ship_fax==null){ship_fax="";}
if(ship_email==null){ship_email="";}

if(notice_ship== null){ notice_ship="";}
if(name_ship==null){ name_ship="";}
if(phone_ship==null){ phone_ship="";}
if(attention_ship==null){ attention_ship="";}
if(ship_rdate==null){ship_rdate="";}
if(ship_edate==null){ship_edate="";}
if(ship_fdate==null){ship_fdate="";}
if(ship_fax==null||ship_fax.trim().startsWith("nu")){ship_fax="";}
if(ship_email==null||ship_email.trim().startsWith("nu")){ship_email="";}
if(ship_tax_exempt==null||ship_tax_exempt.trim().startsWith("nu")){ship_tax_exempt="";}
if(zip==null){zip=tax_zip;}

// Getting the Invoice info	end
//Invoice variables
String invoice_name="";String invoice_addr1="";String invoice_addr2="";String invoice_city="";String invoice_state="";
String invoice_zip="";String invoice_phone="";String invoice_fax="";String invoice_email="";String invoice_cust_bpcs_no="";String invoice_cust_bpcs_no_alt="";

// Getting the Invoice info
               ResultSet rs_invoice = stmt.executeQuery("SELECT * FROM cs_invoice where Order_no like '"+order_no+"' ");
               if (rs_invoice !=null) {
       while (rs_invoice.next()) {
               invoice_name= rs_invoice.getString("name1");
               invoice_addr1= rs_invoice.getString("address1");
               invoice_addr2= rs_invoice.getString("address2");
               invoice_city= rs_invoice.getString("City");
               invoice_state= rs_invoice.getString("State");
               invoice_zip= rs_invoice.getString("Zip_code");
               invoice_phone= rs_invoice.getString("Phone");
               invoice_fax= rs_invoice.getString("fax");
               invoice_email= rs_invoice.getString("email");
               attention_invoice=rs_invoice.getString("attention");
               invoice_cust_bpcs_no=rs_invoice.getString("bpcs_cust_no");
               invoice_cust_bpcs_no_alt=rs_invoice.getString("alt_no");
                                                          }
                                                  }
                                                  rs_invoice.close();

if(attention_invoice==null){
       attention_invoice="";
}
if(invoice_cust_bpcs_no== null  || invoice_cust_bpcs_no.equals("null")){
       invoice_cust_bpcs_no="";
}
if(ship_cust_bpcs_no== null  || ship_cust_bpcs_no.equals("null")){
       ship_cust_bpcs_no="";
}
if(invoice_cust_bpcs_no_alt== null  || invoice_cust_bpcs_no_alt.equals("null")){
       invoice_cust_bpcs_no_alt="";
}
if(ship_cust_bpcs_no_alt== null  || ship_cust_bpcs_no_alt.equals("null")){
       ship_cust_bpcs_no_alt="";
}
// Getting the Invoice info	end
//Credit card information
String payment_method="";String payment_name="";String payment_address1="";
String payment_address2="";String payment_city="";String payment_state="";String payment_zip="";
String payment_credit_type="";String payment_credit_no="";String payment_exp_date="";
String payment_material_sales="";String payment_tax="";String payment_total_charged="";int ship_count=0;String payment_cvc="";
String payment_phone="";String payment_email="";

               ResultSet rs_payment = stmt.executeQuery("SELECT * FROM cs_payment_details where order_no like '"+order_no+"' ");
               if (rs_payment !=null) {
       while (rs_payment.next()) {
               payment_name= rs_payment.getString("name");
               payment_address1= rs_payment.getString("address1");
               payment_address2= rs_payment.getString("address2");
               payment_city= rs_payment.getString("city");
               payment_state= rs_payment.getString("state");
               payment_zip= rs_payment.getString("zip_code");
               payment_credit_type= rs_payment.getString("credit_card_type");
               payment_credit_no= rs_payment.getString("credit_card_no");
               payment_exp_date= rs_payment.getString("exp_date");
               payment_material_sales= rs_payment.getString("total_material_sales");
               payment_tax= rs_payment.getString("tax");
               payment_total_charged= rs_payment.getString("total_charged");
               ship_count++;
                                                                 }
                                      }
                                      rs_payment.close();
               if(payment_tax == null || payment_tax.trim().length()==0){payment_tax="0";	}
               //out.println(payment_tax+"::<BR>");
               ///for breaking down the credit card year and month
               String creditMonth="";String creditYear="";
               if ((payment_exp_date==null)|(payment_exp_date.equals(""))){
                       payment_exp_date="0000-00-00";
               }
               //out.println(payment_exp_date+"<BR>");

               int ind=payment_exp_date.indexOf("-");
               if(ind >0){
                       creditYear=payment_exp_date.substring(2,ind);
                       payment_exp_date=payment_exp_date.substring(ind+1);
                       //out.println("<BR>:::"+payment_exp_date);

                       //out.println(creditYear+"::"+payment_exp_date.indexOf("-", ind)+"::");
                       int ind2=payment_exp_date.indexOf("-");
                       if(ind2 >0){
                               creditMonth=payment_exp_date.substring(0,2);
                       }
                       else{
                               creditMonth="0";
                       }

               }
               // for breaking down the credit card year and month down


//Credit card information end

if (count_cust<=0){
// out.println("There are no customers billed: "+count_cust+"sds"+order_no+"rep_no"+rep_no) ;
%>
<%@ include file="order_page2_ship.jsp"%>
<%
}
else{
        //out.println("There are customers billed: "+count_cust+"sds"+order_no) ;

                if ((payment_terms.equals("CC"))|(payment_terms.equals("CC1"))){

// out.println(payment_tax+"::: 3");
%>
<%@ include file="order_page2_ship.jsp"%>
<%}
else{
        //out.println("HERE2");
%>
<%@ include file="order_page2_ship.jsp"%>
<%
}
}//
}// cmd else if end
else if (cmd.equals("3")) {
// vars for orders
String date_required="";String submit_prep="";String email_to="";String submit_by="";String special_notes="";
String copies_requested="";String type_of_quote="";String order_notes="";String customer_notes="";String extra_order_notes="";String extra_notes="";
// vars for arch
String arch_name="";String arch_addr1="";String arch_addr2="";String arch_city="";String arch_state="";
String arch_zip="";String arch_phone="";String arch_fax="";String arch_email="";String psa_id="";int arch_count=0;
String arch_required="Y";String add_docs="";
Vector emailAdd = new Vector();
Vector docsAdd=new Vector();
String orderStatus="";
String emailList="";
String emailName="";
String order_rep="";
String terr_rep="";
String spec_rep="";
String drafting_email="";
String production_approved_date="";
ResultSet rs_order = stmt.executeQuery("SELECT * FROM cs_order_info where order_no like '"+order_no+"' ");
if (rs_order !=null) {
while (rs_order.next()) {
date_required= rs_order.getString("date_required");
type_of_quote= rs_order.getString("type_of_quote");
email_to= rs_order.getString("email_to");
submit_by= rs_order.getString("submit_by");
special_notes= rs_order.getString("special_notes");
copies_requested= rs_order.getString("copies_requested");
order_notes= rs_order.getString("order_notes");
add_docs=rs_order.getString("add_docs");
orderStatus=rs_order.getString("order_status");
customer_notes=rs_order.getString("customer_notes");
order_rep=rs_order.getString("order_rep");
terr_rep=rs_order.getString("terr_rep");
spec_rep=rs_order.getString("spec_rep");
extra_order_notes=rs_order.getString("extra_order_notes");
extra_notes=rs_order.getString("extra_notes");
production_approved_date=rs_order.getString("production_approved_date");
drafting_email=rs_order.getString("drafting_email");
}
}
rs_order.close();

String billedEmail2="";
String invoiceEmail2="";


ResultSet rsx=stmt.executeQuery("select email from cs_billed_customers where order_no='"+order_no+"'");
if(rsx != null){
while(rsx.next()){
billedEmail2=rsx.getString(1);
}
}
rsx.close();
ResultSet rsx2=stmt.executeQuery("select email from cs_invoice where order_no='"+order_no+"'");
if(rsx2 != null){
while(rsx2.next()){
invoiceEmail2=rsx2.getString(1);
}
}
rsx2.close();






if(extra_order_notes==null||extra_order_notes.trim().startsWith("nu")){extra_order_notes="";}
if(extra_notes==null||extra_notes.trim().startsWith("nu")){extra_notes="";}
if(email_to==null||email_to.trim().startsWith("nu")){email_to="";}
if(add_docs==null||add_docs.trim().startsWith("nu")){add_docs="";}
if(special_notes==null||special_notes.trim().startsWith("nu")){special_notes="";}
if(copies_requested==null||copies_requested.trim().startsWith("nu")){copies_requested="";}
if(customer_notes==null||customer_notes.trim().startsWith("nul")){customer_notes="";}
if(order_rep==null||order_rep.trim().equals("null")){
order_rep=order_rep_acct_id;
}
if(terr_rep==null||terr_rep.trim().equals("null")){
terr_rep="";
}
if(spec_rep==null||spec_rep.trim().equals("null")){
spec_rep="";
}
if(drafting_email==null || drafting_email.trim().equals("null")){
drafting_email="";
}
//submit by special for IWP only
//out.println(orderStatus);
//out.println(rep_no);
if(product.equals("IWP")){
//special deaults to decolink user group
if(user_group.toUpperCase().equals("DECOLINK")||georder.equals("GE")){
if(submit_by==null||submit_by.trim().startsWith("nul")||submit_by.trim().length()<=0){submit_by="NOT REQUIRED";}
}else{

if(orderStatus.equals("HA")){submit_by="REP-(Hold for Approval)";
}else if(orderStatus.equals("DR")){submit_by="FACTORY";
}
}
//special deaults to decolink user group done
}//submit by special for IWP only done
else if(product.equals("GCP")){
if(submit_by==null||submit_by.trim().startsWith("nul")||submit_by.trim().length()<=0){submit_by="NOT REQUIRED";}
}
ResultSet rs_emails=null;
out.println("Email To values check ---> rep_no="+rep_no+",user_group="+user_group+",quote_type2="+quote_type2+",georder="+georder);
if(quote_origin != null && quote_origin.equals("sample")){
rs_emails=stmt.executeQuery("Select contact_name,prod_sample_contact from cs_sbu_contacts where product_id ='"+product+"' and rep_no in ('"+rep_no+"',0) order by rep_no");
}
else{
if(user_group.toUpperCase().equals("DECOLINK")||quote_type2.equals("D")||(quote_type2.equals("E") && georder.equals("dl"))){
rs_emails=stmt.executeQuery("Select contact_name,optio_email from cs_sbu_contacts where product_id ='DECOLINK' and rep_no in ('"+rep_no+"',0) order by rep_no");
}
else if(georder.toUpperCase().equals("GE")){
rs_emails=stmt.executeQuery("Select contact_name,optio_email from cs_sbu_contacts where product_id ='GE' and rep_no in ('"+rep_no+"',0) order by rep_no");
}
else if(product.equals("EJC")){
if(orderStatus.equals("DR")){
rs_emails=stmt.executeQuery("Select contact_name,contact_email from cs_sbu_contacts where product_id ='"+product+"' and rep_no in ('"+rep_no+"',0) order by rep_no");
}
else{
rs_emails=stmt.executeQuery("Select contact_name,optio_email from cs_sbu_contacts where product_id ='"+product+"' and rep_no in ('"+rep_no+"',0) order by rep_no");
}
}
else{
//out.println("Select contact_name,optio_email from cs_sbu_contacts where product_id ='"+product+"' and rep_no in ('"+rep_no+"',0) order by rep_noHErE");
rs_emails=stmt.executeQuery("Select contact_name,optio_email from cs_sbu_contacts where product_id ='"+product+"' and rep_no in ('"+rep_no+"',0) order by rep_no");
}
}
if(rs_emails != null){
while(rs_emails.next()){
emailList=(rs_emails.getString(2));
emailName=(rs_emails.getString(1));
}
}
rs_emails.close();
int start=0;
int end=0;
int x=0;
end=email_to.indexOf(";");
while(end>0 && x<10){
if(end > start){
emailAdd.addElement(email_to.substring(start,end));
}
email_to=email_to.substring(end+1);
end=email_to.indexOf(";");
x++;
}
start=0;
end=0;
end=add_docs.indexOf(";");
while(end>0 && x<10){
if(end > start){
docsAdd.addElement(add_docs.substring(start,end));
}
add_docs=add_docs.substring(end+1);
end=add_docs.indexOf(";");
x++;
}

if((type_of_quote==null)||(type_of_quote.equals(""))){
type_of_quote=quote_type;
}
// Checking if the arch exists
ResultSet rs_arch1 = stmt.executeQuery("select * from cs_order_architects where order_no= '"+order_no+"' ");
if (rs_arch1 !=null) {
while (rs_arch1.next()) {
arch_name= rs_arch1.getString("name1");
arch_addr1= rs_arch1.getString("address1");
arch_addr2= rs_arch1.getString("address2");
arch_city= rs_arch1.getString("city");
arch_state= rs_arch1.getString("state");
arch_zip= rs_arch1.getString("zip_code");
arch_phone= rs_arch1.getString("phone");
arch_fax= rs_arch1.getString("fax");
arch_email= rs_arch1.getString("email");
arch_required= rs_arch1.getString("required");
arch_count++;
}
}
rs_arch1.close();
if (arch_count<=0){

//		ResultSet rs_arch = stmt_psa.executeQuery("	select * FROM dba.account where sic_code_id='ARCH' and acctname like '"+Arch_name.trim()+"%' and country='US' and town like '"+Arch_city.trim()+"%' ");
PreparedStatement query_customer = myConn_psa.prepareStatement("select * from dba.account where sic_code_id='ARCH' and acctname like ? and country='US' and town like ? ");
query_customer.setString(1,Arch_name.trim()+"%");
query_customer.setString(2,Arch_city.trim()+"%");
ResultSet rs_arch = query_customer.executeQuery();
if (rs_arch !=null) {
while (rs_arch.next()) {
arch_name= rs_arch.getString("acctname");
arch_addr1= rs_arch.getString("addr1");
arch_addr2= rs_arch.getString("addr2");
arch_city= rs_arch.getString("town");
arch_state= rs_arch.getString("county");
arch_zip= rs_arch.getString("postcode");
arch_phone= rs_arch.getString("tel");
arch_fax= rs_arch.getString("fax");
arch_email= rs_arch.getString("emailorweb");
psa_id= rs_arch.getString("acct_id");
}
}
rs_arch.close();
if(user_group.toUpperCase().equals("DECOLINK")){arch_required="N";}
else{
if(product.equals("GE")){
        arch_required="N";
}
else{
        arch_required="Y";
}
}
//out.println("The PSA:"+psa_id);
stmt_psa.close();
myConn_psa.close();
}


%>
<%@ include file="order_page3.jsp"%>
<%
       }

else if (cmd.equals("5")) {
//Greg's  code starts here\
      String section_transfer=""; String section_info="";String sections="";
      int numSections=0; Vector section=new Vector(); Vector sectionName=new Vector();Vector sectionTransfer=new Vector();
      Vector sectionTransferName=new Vector();
      String webLinks="";
      String sections_checked="";
      Vector checkedSec=new Vector();
      int counter=0;
      ResultSet rs_count=stmt.executeQuery("select count(*)from cs_quote_sections where order_no='"+order_no+"'");
      if(rs_count !=null){
              while(rs_count.next()){
                      counter=rs_count.getInt(1);
              }
      }
      rs_count.close();
                      String selected="";


              ResultSet rs_cmd5=stmt.executeQuery("select * from cs_quote_sections where order_no='"+order_no+"'");
              if(rs_cmd5 != null){
                      while(rs_cmd5.next()){
                              section_transfer=rs_cmd5.getString("section_transfer");
                              section_info=rs_cmd5.getString("section_info");
                              sections=rs_cmd5.getString("sections");
                              sections_checked=rs_cmd5.getString("sections_checked");
                      }
              }
              rs_cmd5.close();
              //out.println(section_transfer+"::<BR>");
              //out.println(section_info+"::<BR>");
              //out.println(sections+"::<BR>");
              //out.println(sections_checked+"::<BR>");
//out.println("::"+sections+":: HERE<BR>");
              if(sections_checked != null && sections_checked.trim().length()>0 && !sections.trim().equals("0")){
                      int ttt=0;
                      while(sections_checked.length()>0 && ttt<100){
                              int a=0;
                              //int b=0;
                              a=sections_checked.indexOf(",");
                              checkedSec.addElement(sections_checked.substring(0,a));
                              sections_checked=sections_checked.substring(a+1);
                              //out.println(checkedSec.elementAt(ttt));
                              ttt++;
                      }

              }

              if(sections != null && sections.trim().length()>0 && !sections.trim().equals("0")){
                      numSections=Integer.parseInt(sections);
              }
              else{
                      numSections=1;
              }

              if(numSections >0){
                      if(section_info !=null && section_info.trim().length()>0){
                              int equal=0;
                              int comma=0;
                              int x=0;
                              while(section_info.trim().length()>1 && x<10){
                                      equal=section_info.indexOf("=");
                                      if(equal >0){
                                              comma=section_info.indexOf(";");
                                      }
                                      if(equal>0 && comma > equal){
                                              section.addElement(section_info.substring(0,equal));
                                              sectionName.addElement(section_info.substring(equal+1,comma));
                                              //out.println(section_info.substring(equal+1,comma)+"::<BR>");
                                      }
                                      section_info=section_info.substring(comma+1);
                              }
                              if(section_transfer != null && section_transfer.trim().length()>0){
                                      x=0;
                                      while(section_transfer.length()>1 && x<20){
                                              equal=0;
                                              comma=0;
                                              equal=section_transfer.indexOf("=");
                                              if(equal>0){
                                                      comma=section_transfer.indexOf(";");
                                                      if(comma>equal){
                                                              sectionTransfer.addElement(section_transfer.substring(0,equal));
                                                              //out.println(section_transfer.substring(0,equal)+"::HERE<BR>");
                                                              sectionTransferName.addElement(section_transfer.substring(equal+1,comma));
                                                              section_transfer=section_transfer.substring(comma+1);
                                                      }
                                              }
                                              x++;
                                      }
                              }
                              else{
                                      section_transfer="";
                              }
                      }
              }
              //out.println(sectionName.size()+"::<BR>");
      for(int n=0; n<sectionTransferName.size(); n++){
              String dateStamp=sectionTransferName.elementAt(n).toString();
              boolean isNew=true;
              String result="";
              String button1="";
              String button2="";
              String button3="";
              if(n>0){
                      for(int t=n-1; t>=0; t--){
                              if(dateStamp.equals(sectionTransferName.elementAt(t).toString())){
                                      isNew=false;
                              }
                      }
              }
              //out.println(sectionName.elementAt(n).toString()+"::"+isNew);
              if(isNew){
                      result=sectionTransfer.elementAt(n).toString()+",";
                      button1=sectionTransferName.elementAt(n).toString()+",";
                      button2=sectionName.elementAt(n).toString()+",";
                      button3=sectionTransfer.elementAt(n).toString()+",";

                      //secnames="<input type='button' name='"+sectionTransferName.elementAt(n).toString()+"' value='"+sectionName.elementAt(n).toString()+"::"+sectionTransferName.elementAt(n).toString()+"'>";
                              if(n<sectionTransferName.size()-1){
                                      for(int b=n+1; b<sectionTransferName.size(); b++){
                                              if(sectionTransferName.elementAt(b).toString().equals(dateStamp)){
                                                      result=result+sectionTransfer.elementAt(b).toString()+",";
                                                      button1=sectionTransferName.elementAt(b).toString();
                                                      if(sectionName.size()<2){
                                                              button2="ALL";
                                                      }
                                                      else{
                                                              button2=button2+" "+sectionName.elementAt(b).toString();
                                                      }
                                                      button3=button3+sectionTransfer.elementAt(b).toString()+",";
                                              }
                                      }
                              }

              }
              if(button3 != null && button3.trim().endsWith(",")){
                      button3=button3.substring(0,button3.length()-1);
              }
              if(result.trim().length()>0){
                      webLinks=webLinks+"<td COLSPAN='3' align='left'><a href='order_sheet.jsp?orderNo="+ order_no +"&rep_no="+ rep_no+"&product="+ product+"&Project_name="+ Project_name+"&Job_loc="+Job_loc+"&project_state="+project_state+"&line="+ line+"&handling_cost="+handling_cost+"&setup_cost="+setup_cost+"&freight_cost="+freight_cost+"&overage="+overage+"totmat_price="+totmat_price+"&commission="+commission+"&sections="+result+"'>View Order Sheet for section "+ result +"</a></td></tr>";
                      resendlinks=resendlinks+"<tr><td colspan='3'><input type='button' name='owsbutton' value='Resend "+button2+" @ "+button1+"' onclick=resendnew('"+button3+"','"+button3.replaceAll(",","")+"')></td></tr>";
              }
      }


      //Greg's  code ends here


%>
<%@ include file="order_page4.jsp"%>
<%
stmt.close();
myConn.close();
}

stmt_bpcsusrmm.close();
con_bpcsusrmm.close();

 }
  catch(Exception e){
  out.println(e);
  }



//(quoteHeader.getProjectType()!=null && quoteHeader.getProjectType().trim().equals("SFDC")

%>