<%
if(UserID.equals("DBA")){
rep_no="7";
}
//out.println(rep_no);
//Getting data from the psa tables
int count_quotation=0;String  psa_quote_id="";String  psa_project_id="";String  psa_acct_id="";String  psa_acct_name="";
String  psa_cont_name="";String  psa_cont_id="";String  psa_project_name="";String  psa_project_town="";String  psa_project_state="";
String arch_acct_id="";String Arch_name="";String Arch_loc="";String Arch_state= "";String quote_notes="";
ResultSet rs_psa = stmt_psa.executeQuery("SELECT quote_id,project_id,notes FROM dba.quotation where quote_id  like '"+QuoteID+"%"+"' ");
      while ( rs_psa.next() ) {
		psa_quote_id= rs_psa.getString("quote_id");
		psa_project_id= rs_psa.getString("project_id");
		quote_notes= rs_psa.getString("notes");
//			out.println("PSA Quote"+ psa_quote_id);
		count_quotation++;
//			out.println(count_quotation+" here <BR>");
		}
rs_psa.close();
if(count_quotation>0){
	//getting data started
	ResultSet rs_psa_pt = stmt_psa.executeQuery("SELECT project_id,project_title,site_town,site_county FROM cs_project where project_id like '"+psa_project_id+"'");
       while ( rs_psa_pt.next() ) {
		psa_project_id= rs_psa_pt.getString(1);
		psa_project_name= rs_psa_pt.getString(2);
		psa_project_town= rs_psa_pt.getString(3);
		psa_project_state= rs_psa_pt.getString(4);
		//							out.println("PSA account"+ psa_project_name+" ID"+psa_project_id);
		}
		rs_psa_pt.close();
	ResultSet rs_psa_qa = stmt_psa.executeQuery("select * FROM dba.proj_ac_link where project_id= '"+psa_project_id+"' and aclookup_id in (select acct_id FROM dba.quoted_accounts where quote_id='"+QuoteID+"') ");
       while ( rs_psa_qa.next() ) {
		psa_acct_id= rs_psa_qa.getString(3);
		psa_acct_name= rs_psa_qa.getString(5);
		psa_cont_name= rs_psa_qa.getString(7);
		psa_cont_id= rs_psa_qa.getString(9);
		//							if(rs_psa_qa.getString("role_type_id").equals("2")){arch_acct_id=rs_psa_qa.getString("aclookup_id");}
							//		out.println("PSA account"+ psa_acct_name+"contact"+psa_cont_name);
		}
		rs_psa_qa.close();
	ResultSet rs_psa_proj_ac_link = stmt_psa.executeQuery("SELECT * FROM dba.proj_ac_link where project_id like '"+psa_project_id+"' order by link_id");
		if (rs_psa_proj_ac_link !=null) {
	      	while (rs_psa_proj_ac_link.next()) {
				if(rs_psa_proj_ac_link.getString("role_type_id").equals("2")){arch_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");}
			//								if(rs_psa_proj_ac_link.getString("role_type_id").equals("8")){terr_rep_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");}
			//								if(rs_psa_proj_ac_link.getString("role_type_id").equals("7")){spec_rep_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");}
			//								if(rs_psa_proj_ac_link.getString("role_type_id").equals("10")){order_rep_acct_id=rs_psa_proj_ac_link.getString("aclookup_id");}
			}
		}
		rs_psa_proj_ac_link.close();
	// Getting the architect account info
	if(arch_acct_id.trim().length()>0){
	 	ResultSet rs_psa_account = stmt_psa.executeQuery("SELECT acctname,addr2,town,county,postcode FROM dba.account where acct_id like '"+arch_acct_id+"'");
	  		if (rs_psa_account !=null) {
	        	while (rs_psa_account.next()) {
						Arch_name= rs_psa_account.getString(1);
						Arch_loc= rs_psa_account.getString(3);
						Arch_state= rs_psa_account.getString(4);
				}
			}
		rs_psa_account.close();
	}	
}// if there is one in quotation table

// Inserting into project table
  	try
	{				
	String insert ="INSERT INTO cs_project(Order_no,Project_name,Job_loc,project_state,Arch_name,Arch_loc,exclusions,qualifying_notes,free_text,Cust_name,Cust_loc,Agent_name,creator_id,product_id,section,division,exclusions_free_text,qualifying_notes_free_text,show_comission,quote_type,section_desc,project_type,project_type_id) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";	
	PreparedStatement update_customer = myConn.prepareStatement(insert);	
			update_customer.setString(1, order_no);
          	update_customer.setString(2, psa_project_name);
			update_customer.setString(3, psa_project_town);
			update_customer.setString(4, psa_project_state);
			update_customer.setString(5, Arch_name);
			update_customer.setString(6, Arch_loc);
			update_customer.setString(7, "");
			update_customer.setString(8, "");
          	update_customer.setString(9, "");
			update_customer.setString(10, psa_acct_id);
			update_customer.setString(11, psa_acct_name);
			update_customer.setString(12, psa_cont_name);
			update_customer.setString(13, rep_no);
			update_customer.setString(14, product);
			update_customer.setString(15, "");
			update_customer.setString(16, "");
			update_customer.setString(17, "");
			update_customer.setString(18, "");
			update_customer.setString(19, "N");
			update_customer.setString(20, "Q");
			update_customer.setString(21, "");
			update_customer.setString(22, "PSA");
			update_customer.setString(23, QuoteID);
			int rocount = update_customer.executeUpdate();
			update_customer.close();
	}
	catch (java.sql.SQLException e)
	{
		out.println("Problem with ENTERING TO project TABLEs"+"<br>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}
// INSERT INTO cs_project table done

//Inserting into cs_quote_sections started.
// Checking the no of sections from access_central;
String sect_names="";String sect_nos="";int sect_count=0;String sect_items="";
   ResultSet rs2 = stmt.executeQuery("SELECT * FROM cs_access_central where order_no like '"+order_no+"'");
       while ( rs2.next() ) {
   		sect_nos=rs2.getString("section_no");	   
	    sect_names=sect_names+sect_nos+"="+rs2.getString("ac_desc")+";";
//		out.println("::"+sect_nos+"::"+sect_names);
		sect_count++;
    	}
		rs2.close();
//out.println("sec"+sect_names+"::"+sect_count);
// doc_line
   ResultSet rs3 = stmt.executeQuery("SELECT 's'+item_no,subline_no FROM doc_line where doc_number like '"+order_no+"' and product_id!='ACCESS_CENTRAL'");
       while ( rs3.next() ) {
   		sect_items=sect_items+rs3.getString(2)+"=";
		sect_items=sect_items+rs3.getString(1)+";";			   
    	}
		rs3.close();
//out.println("secitems"+sect_items+"::"+sect_count);
//doc_line		
//section lines
//section lines
try	{
	String insert ="INSERT INTO cs_quote_sections(order_no,section_info,sections,section_group)VALUES(?,?,?,?) ";
			PreparedStatement update_cust = myConn.prepareStatement(insert);
			update_cust.setString(1,order_no);
			update_cust.setString(2,sect_names);
			update_cust.setInt(3,sect_count);
			update_cust.setString(4,sect_items);			
			int rocount = update_cust.executeUpdate();
			update_cust.close();
	}
	catch (java.sql.SQLException e)
	{
		out.println("Problem with ENTERING TO cs_sections TABLE"+"<br>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}	


//Inserting into cs_quote_sections done.


%>
