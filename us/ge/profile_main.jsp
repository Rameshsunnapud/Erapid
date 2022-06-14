<form name='repform' action="javascript:writerep();window.close();">
	<input type='hidden' name='q_no' value='<%= OrderNum%>'>
	<%
	// this is the main part of the ge profile setup
	// created May 2006
	// basically, this pulls customer info from psa, header and message info from cs_project, date info from doc_header
	// line item info from csquotes


	// number format to 2 decimals
	//NumberFormat for1 = NumberFormat.getInstance();
	//for1.setMaximumFractionDigits(2);
	//for1.setMinimumFractionDigits(2);
	DecimalFormat df0 = new DecimalFormat("####");
	 df0.setMaximumFractionDigits(0);
	df0.setMinimumFractionDigits(0);
	DecimalFormat for1 = new DecimalFormat("###.##");
	for1.setMaximumFractionDigits(2);
	for1.setMinimumFractionDigits(2);


	String instructions="";
	String lastUpdate="";
	String customerName="";
	String freeText="";
	String exclusionsFreeText="";
	String qualifyingNotesFreeText="";
	String exclusions="";
	String qualifying_notes="";
	String projectTypeId="";
	String projectName="";
	String groupCode="";
	String salesRegion="";
	String billCust="";
	String billCustNo="";
	String tax_exempt="";
	String[] ship = {"P","PD","PE","PF","PG","PH","Z"};
	String[] ship1 = {"HOUSE ACCOUNTS","NORTHEAST","SOUTHWEST","SOUTHEAST","MIDWEST","WEST","INTERCOMPANY"};
	String custName="";
	String contactId="";
	String contName="";
	String contEmail="";
	String contPhone="";
	String contFax="";
	String endUser="";
	Vector lineNo = new Vector();
	Vector geItem = new Vector();
	Vector description = new Vector();
	Vector color = new Vector();
	Vector size = new Vector();
	Vector uom = new Vector();
	Vector unitPrice = new Vector();
	Vector factory = new Vector();
	Vector vendorNum = new Vector();
	Vector unitCost = new Vector();
	Vector grossProfit = new Vector();
	Vector unitCostOld = new Vector();
	Vector grossProfitOld = new Vector();
	Vector qty =  new Vector();
	Vector bpcsNum = new Vector();
	Vector productId=new Vector();
	Vector blockId=new Vector();
	Vector totalPrice=new Vector();
	Vector bpcsQty=new Vector();
	Vector recordNo=new Vector();
	Vector isGood=new Vector();
	Vector field18=new Vector();
	int a=0;
	String lineNoOld="";
	String colorx="#FFFFFF";
	String product="";
	String re_no="";
	String rep_type="";
	String qtype="";
	String usergroup="";
	String ccode="";
	String namex="";
	String expiresDate="";

	boolean isExpired=false;
	int expireYear=0;
	int expireMonth=0;
	int expireDay=0;


	ResultSet rsCSReps=stmt.executeQuery("select rep_no,rep_type,country_code,group_id from cs_reps where user_id='"+name+"'");
	if(rsCSReps != null){
		while(rsCSReps.next()){
			re_no=rsCSReps.getString(1);
			rep_type=rsCSReps.getString(2);
			ccode=rsCSReps.getString(3);
			usergroup=rsCSReps.getString(4);
		}
	}
	rsCSReps.close();
	//out.println(re_no+"::"+rep_type+"::"+usergroup+"::"+ccode+"<BR>");

	ResultSet rsDocHeader=stmt.executeQuery("select doc_date,expires_date from doc_header where doc_number='"+OrderNum+"'");
	if(rsDocHeader != null){
		while(rsDocHeader.next()){
			lastUpdate=rsDocHeader.getString(1).substring(0,10);
			expiresDate=rsDocHeader.getString(2).substring(0,10);
		}
	}
	rsDocHeader.close();


	java.util.Date today=new java.util.Date();
	expireYear=Integer.parseInt(expiresDate.substring(0,expiresDate.indexOf("-")));
	expiresDate=expiresDate.substring(expiresDate.indexOf("-")+1);
	expireMonth=Integer.parseInt(expiresDate.substring(0,expiresDate.indexOf("-")));
	expiresDate=expiresDate.substring(expiresDate.indexOf("-")+1);
	expireDay=Integer.parseInt(expiresDate);
	//out.println((today.getYear()+1900)+"::"+(today.getMonth()+1)+"::"+today.getDate()+"<BR>");
	//out.println(expireYear+"::"+expireMonth+"::"+expireDay+"<BR>"+today+"::"+expiresDate+"<BR>");
	if(expireYear==(today.getYear()+1900)){
		if(expireMonth==(today.getMonth()+1)){
			if(expireDay<today.getDate()){
				isExpired=true;
			}

		}
		else if(expireMonth <(today.getMonth()+1)){
			isExpired=true;
		}

	}
	else if(expireYear<(today.getYear()+1900)){
		isExpired=true;
	}

	//out.println(isExpired);

	ResultSet rsProfile=stmt.executeQuery("select cust_name,free_text,exclusions_free_text,qualifying_notes_free_text, project_type_id,project_name,group_code,sales_region,arch_name,arch_loc,job_loc,product_id,ship_attention,internal_notes,end_user,agent_name,exclusions,qualifying_notes from cs_project where order_no='"+OrderNum+"'");
	if(rsProfile != null){
		while(rsProfile.next()){
			customerName=rsProfile.getString(1);
			freeText=rsProfile.getString(2);
			exclusionsFreeText=rsProfile.getString(3);
			qualifyingNotesFreeText=rsProfile.getString(4);
			projectTypeId=rsProfile.getString(5);
			projectName=rsProfile.getString(6);
			groupCode=rsProfile.getString(7);
			salesRegion=rsProfile.getString(8);
			billCust=rsProfile.getString(9);
			billCustNo=rsProfile.getString(10);
			tax_exempt=rsProfile.getString(11);
			product=rsProfile.getString(12);
			namex=rsProfile.getString(13);
			instructions=rsProfile.getString(14);
			endUser=rsProfile.getString(15);
			contName=rsProfile.getString(16);
			exclusions=rsProfile.getString("exclusions");
			qualifying_notes=rsProfile.getString("qualifying_notes");
		}
	}
	rsProfile.close();

	ResultSet rsUsers=stmt.executeQuery("Select rep_name from cs_reps where user_id='"+namex+"'");
	if(rsUsers != null){
		while(rsUsers.next()){
			namex=rsUsers.getString(1);
		}
	}
	rsUsers.close();
	if(billCust==null){ billCust="";}
	if(billCustNo==null){ billCustNo="";}
	if(endUser==null){	endUser="";}
	for(int q=0; q<ship.length; q++){
		//out.println(ship[q]+":::<BR>");
		if(ship[q].equals(salesRegion)){
			salesRegion=ship1[q];
		}
	}
	if(instructions == null){	instructions="";}
	for(int rr=0; rr<instructions.length(); rr++){
		if((int)instructions.charAt(rr)==10){
			instructions=instructions.substring(0,rr)+"<br>"+instructions.substring(rr);
			rr=rr+4;
		}
	}
	if(freeText == null){	freeText="";}
	for(int rr=0; rr<freeText.length(); rr++){
		if((int)freeText.charAt(rr)==10){
			freeText=freeText.substring(0,rr)+"<br>"+freeText.substring(rr);
			rr=rr+4;
		}
	}
	if(projectTypeId!=null && projectTypeId.trim().length()>0){
		//these three queries are combined to find info on the customer threw the mess of psa tables..
		//out.println(customerName+"::");
		/*ResultSet rsPsaAccount=stmt_psa.executeQuery("select acctname,tel,fax,emailorweb from dba.account where acct_id='"+customerName+"'");
		if(rsPsaAccount != null){
			while(rsPsaAccount.next()){
				custName=rsPsaAccount.getString(1);
				contPhone=rsPsaAccount.getString(2);
				contFax=rsPsaAccount.getString(3);
				contEmail=rsPsaAccount.getString(4);
				//out.println("CUSTOMER NAME FROM PSA"+custName+"<BR>");
			}
		}
		rsPsaAccount.close();
		//out.println(customerName+"::"+projectTypeId+":: HEREx<BR>");
		ResultSet rsPsaQuotesIssued=stmt_psa.executeQuery("select * from dba.quotes_issued where quote_id='"+projectTypeId+"' and acct_id='"+customerName+"'");
		if(rsPsaQuotesIssued != null){
			while(rsPsaQuotesIssued.next()){
				contactId=rsPsaQuotesIssued.getString(4);
				//out.println("contact Id from psa"+contactId+"<br>");
			}
		}
		rsPsaQuotesIssued.close();
		//out.println(contactId+":: HERE");
		ResultSet rsPsaContact=stmt_psa.executeQuery("select * from dba.contact where cont_id='"+contactId+"'");
		if(rsPsaContact != null){
			while(rsPsaContact.next()){
				contName=rsPsaContact.getString(4)+" "+rsPsaContact.getString(3);
				if(rsPsaContact.getString("e_mail")!=null && rsPsaContact.getString("e_mail").trim().length()>0){
					contEmail=rsPsaContact.getString("e_mail");
				}
				if(rsPsaContact.getString("tel_direct")!=null && rsPsaContact.getString("tel_direct").trim().length()>0){

					contPhone=rsPsaContact.getString("tel_direct");
				}
				if(rsPsaContact.getString("fax_work")!=null && rsPsaContact.getString("fax_work").trim().length()>0){

					contFax=rsPsaContact.getString("fax_work");
				}

			}
		}
		rsPsaContact.close();*/
	}
	else{
customerName=customerName.replaceAll("US","");
		ResultSet rsCust=stmt.executeQuery("Select * from cs_customers where cust_no='"+customerName+"'");
		if(rsCust != null){
			while(rsCust.next()){
				custName=rsCust.getString("cust_name1");
				//contName=rsCust.getString("contact_name");
				//contPhone=rsCust.getString("phone");
				//contFax=rsCust.getString("fax");
			}
		}
		rsCust.close();
		ResultSet rsCont=stmt.executeQuery("Select * from cs_customer_contact where cust_no='"+customerName+"' and contact_name='"+contName+"'");
		if(rsCont != null){
			while(rsCont.next()){
				contPhone=rsCont.getString("contact_phone");
				contFax=rsCont.getString("contact_fax");
				contEmail=rsCont.getString("contact_email");
			}
		}
		rsCont.close();
	}
	if(contName == null){ contName="";}
	if(contEmail == null){ contEmail="";}
	if(contPhone == null){ contPhone="";}
	if(contFax == null){contFax="";}

	//ResultSet rsCsquotes=stmt.executeQuery("select line_no,descript,extended_price,uom,qty,std_cost,bpcs_part_no,vendor_no,product_id,bpcs_qty,block_id,field19,record_no,field18 from csquotes where order_no='"+OrderNum+"' and not block_id in ('A_APRODUCT','E_DIM','E_DIM1','E_DIM2') order by cast(line_no as integer),block_id");
	//as per Courtney 05/03/2014
	ResultSet rsCsquotes=stmt.executeQuery("select line_no,descript,extended_price,bpcs_um,qty,std_cost,bpcs_part_no,vendor_no,product_id,bpcs_qty,block_id,field19,record_no,field18,whse from csquotes where order_no='"+OrderNum+"' and not block_id in ('A_APRODUCT','E_DIM','E_DIM1','E_DIM2','B_FRAMES') order by cast(line_no as integer),block_id");
	//out.println("select line_no,descript,extended_price,bpcs_um,qty,std_cost,bpcs_part_no,vendor_no,product_id,bpcs_qty,block_id,field19,record_no,field18,whse from csquotes where order_no='"+OrderNum+"' and not block_id in ('A_APRODUCT','E_DIM','E_DIM1','E_DIM2','B_FRAMES') order by cast(line_no as integer),block_id");
	Vector line_whse=new Vector();
	if(rsCsquotes != null){
		while(rsCsquotes.next()){
			if(rsCsquotes.getString("whse") != null && rsCsquotes.getString("whse").trim().length()>0){
				line_whse.addElement(rsCsquotes.getString("whse").trim());
			}else{line_whse.addElement("");	}
			productId.addElement(rsCsquotes.getString(9));
			lineNo.addElement(rsCsquotes.getString(1));
			bpcsQty.addElement(rsCsquotes.getString(10));

			uom.addElement(rsCsquotes.getString(4));
			if(rsCsquotes.getString(9).equals("EFS")){
		if(rsCsquotes.getString("bpcs_qty")!=null&&rsCsquotes.getString("bpcs_qty").trim().length()>0){
//out.println(rsCsquotes.getString("block_id")+"::"+rsCsquotes.getString("bpcs_qty")+"::<BR>");
qty.addElement(""+(new Double(rsCsquotes.getString(10)).doubleValue()*new Double(rsCsquotes.getString("qty")).doubleValue()));
}
else{
qty.addElement(rsCsquotes.getString(10));
}	}
			else{
				//qty.addElement(rsCsquotes.getString(5));
				// as per Courtney 05/03/2014
				qty.addElement(rsCsquotes.getString(10));
			}
			blockId.addElement(rsCsquotes.getString(11));
			
			if(blockId.elementAt(a).toString().equals("D_NOTES")||blockId.elementAt(a).toString().equals("B_NOTES")||blockId.elementAt(a).toString().equals("E_DIM2")){
				unitPrice.addElement("0");
				unitCost.addElement("0");
				totalPrice.addElement("0");
				String descTemp=rsCsquotes.getString(2);
				if(descTemp.toUpperCase().indexOf("NOTE:")>=0){
					int start=descTemp.toUpperCase().indexOf("NOTE:");
					out.println("<Br> Line 97 "+descTemp);
					descTemp=descTemp.substring(start+5);
					out.println("<Br> Line 99 "+descTemp);
				}
				description.addElement(descTemp);
				
			}
			else{
				String descTemp=rsCsquotes.getString(2);
				if(descTemp.toUpperCase().indexOf("NOTE:")>=0){
					int start=descTemp.toUpperCase().indexOf("NOTE:");
					out.println("<Br> Line 108 "+descTemp);
					descTemp=descTemp.substring(0,start)+"<BR><b>NOTE:</b>"+descTemp.substring(start+5);
					out.println("<Br> Line 110 "+descTemp);
				}
				description.addElement(descTemp);
				/*
				if(productId.elementAt(a).toString().equals("GE")){
					out.println(rsCsquotes.getString(3)+"/");
					out.println(rsCsquotes.getString(10)+"*");
					

					double field19=new Double(rsCsquotes.getString(12)).doubleValue();
					totalPrice.addElement(""+for1.format(((new Double(rsCsquotes.getString(3)).doubleValue())*field19)));
					//unitPrice.addElement("0");
					unitPrice.addElement(""+for1.format(((new Double(rsCsquotes.getString(3)).doubleValue()/new Double(qty.elementAt(a).toString()).doubleValue())*field19)));
				}
				else{
				*/

					totalPrice.addElement(""+for1.format((new Double(rsCsquotes.getString(3)).doubleValue())));
					
					unitPrice.addElement(""+for1.format((new Double(rsCsquotes.getString(3)).doubleValue()/new Double(qty.elementAt(a).toString()).doubleValue())));
					//out.println("<Br> Line 324 "+rsCsquotes.getString(2));
					//out.println("Unit Price: "+for1.format((new Double(rsCsquotes.getString(3)).doubleValue()/new Double(qty.elementAt(a).toString()).doubleValue()))+"::<BR>"+rsCsquotes.getString(10));
				//}
				if(rsCsquotes.getString(6) != null && rsCsquotes.getString(6).trim().length()>0){
					unitCost.addElement(""+for1.format(new Double(rsCsquotes.getString(6)).doubleValue()));
				}
				else{
					unitCost.addElement("0");
				}								
			}
			
			
			bpcsNum.addElement(rsCsquotes.getString(7));
			vendorNum.addElement(rsCsquotes.getString(8));
			recordNo.addElement(rsCsquotes.getString(13));
			field18.addElement(rsCsquotes.getString(14));
			
			geItem.addElement("");
			color.addElement("");
			size.addElement("");
			isGood.addElement("yes");
			a++;

		}
	}
	rsCsquotes.close();
				
	for(int y=0; y<bpcsNum.size(); y++){
		//out.println("(("+new Double(unitPrice.elementAt(y).toString()).doubleValue()+"-"+new Double(unitCost.elementAt(y).toString()).doubleValue()+")/("+new Double(unitPrice.elementAt(y).toString()).doubleValue()+"))*100)");
		grossProfit.addElement(""+ for1.format(((new Double(unitPrice.elementAt(y).toString()).doubleValue()-new Double(unitCost.elementAt(y).toString()).doubleValue())/(new Double(unitPrice.elementAt(y).toString()).doubleValue()))*100));
		if(productId.elementAt(y).toString().equals("EFS")||productId.elementAt(y).toString().equals("IWP")){
			factory.addElement("CS Muncy");
			//out.println(field18.elementAt(y).toString()+"::"+uni":<BR>");
			ResultSet rsCost=stmt.executeQuery("select model_cost,component_cost from cs_ge_costs where modelcontrol='"+field18.elementAt(y).toString()+"'");
			if(rsCost != null){
				while(rsCost.next()){
					if(!for1.format(rsCost.getDouble(1)).equals(unitCost.elementAt(y).toString()) &&! for1.format(rsCost.getDouble(2)).equals(unitCost.elementAt(y).toString())){
						//out.println(" cost mismatch<br>"+rsCost.getDouble(1)+"::"+unitCost.elementAt(y).toString());

						isGood.setElementAt("NO",y);
					}
				}
			}
			rsCost.close();
		}
		else{
		//out.println(bpcsNum.elementAt(y).toString()+": ge<BR>");
			// find factory info for ge line items.
			String factoryTemp="&nbsp;";
			ResultSet rsFactory=stmt.executeQuery("select vendor_name,part_cost from cs_ge_vendor_items where part_no = '"+bpcsNum.elementAt(y).toString()+"'");
			if(rsFactory != null){
				while(rsFactory.next()){
					factoryTemp=(rsFactory.getString(1));
					if(!for1.format(rsFactory.getDouble(2)).equals(unitCost.elementAt(y).toString())){
						//out.println(" cost mismatch<br>");
						isGood.setElementAt("NO",y);
					}


				}
			}
			rsFactory.close();
			if(factoryTemp == null){
				factoryTemp="";
			}
			factory.addElement(factoryTemp);
		}
	}

	if(isExpired){
		out.println("<FONT color='red' size='2'> PROFILE HAS EXPIRED.  PLEASE CHECK PROFILE INFO TO MAKE SURE IT IS CURRENT, AND THEN CHANGE THE EXPIRES DATE</FONT>");
	}else{

		out.println("<table border='0' width='95%'><tr><td bgcolor='#E9F2F7'>ACCOUNT PROFILE</td>");
		out.println("<td colspan=4>"+projectName+"</td>");
		out.println("<td bgcolor='#E9F2F7'>LAST UPDATE</td>");
		out.println("<td>"+lastUpdate+"</td></tr>");
		out.println("<tr><td colspan='5'>&nbsp;</td>");
		out.println("<td bgcolor='#E9F2F7'>LAST UPDATE BY</td>");
		out.println("<td>"+namex+"</td></tr>");
		out.println("<tr><td bgcolor='#E9F2F7'>CUSTOMER NAME:</td><td colspan='2'>"+custName+"</td><td colspan='4'>&nbsp;</td></tr>");
		out.println("<tr><td bgcolor='#E9F2F7'>CONTACT NAME:</td><td colspan='2'>"+contName+"</td><td colspan='4'>&nbsp;</td></tr>");
		out.println("<tr><td bgcolor='#E9F2F7'>EMAIL ADDRESS:</td><td colspan='2'>"+contEmail+"</td><td colspan='4'>&nbsp;</td></tr>");
		out.println("<tr><td bgcolor='#E9F2F7'>PHONE:</td><td colspan='2'>"+contPhone+"</td><td colspan='4'>&nbsp;</td></tr>");
		out.println("<tr><td bgcolor='#E9F2F7'>FAX:</td><td colspan='2'>"+contFax+"</td><td colspan='4'>&nbsp;</td></tr>");
		out.println("<tr><td colspan='7'>&nbsp;</td></tr>");
		out.println("<tr><td bgcolor='#E9F2F7'>END USER:</td><td colspan='2'>"+endUser+"</td><td colspan='2'>"+"</td><td colspan='2'>&nbsp;</td></tr>");
		out.println("<tr><td bgcolor='#E9F2F7'>BILLING CUSTOMER:</td><td colspan='2'>"+billCust+"</td><td colspan='2'>"+"</td><td colspan='2'>&nbsp;</td></tr>");
		out.println("<tr><td bgcolor='#E9F2F7'>GROUP CODE:</td><td colspan='2'>"+groupCode+"</td><td bgcolor='#E9F2F7'>CUSTOMER #</td><td>"+billCustNo+"</td><td colspan='2'>&nbsp;</td></tr>");
		out.println("<tr><td bgcolor='#E9F2F7'>SALES REGION:</td><td colspan='2'>"+salesRegion+"</td><td bgcolor='#E9F2F7'>TAX EXEMPT #</td><td>"+tax_exempt+"</td><td colspan='2'>&nbsp;</td></tr>");
		out.println("<tr><td colspan='7'>&nbsp;</td></tr>");
		out.println("</table>");
		out.println("<table border='0' width='95%'><tr><td colspan='9'>ORDER INFORMATION:</td><td align='right'><input type='button' name='create quote' value='Create Quote' onclick='createQuote()'></TD></TR>");
		out.println("<tr><td bgcolor='#E9F2F7'>GE ITEM #</TD><TD bgcolor='#E9F2F7'>DESCRIPTION</TD><TD bgcolor='#E9F2F7'>TOTAL PRICE</TD><TD bgcolor='#E9F2F7'>BPCS QTY</TD><TD bgcolor='#E9F2F7'>U/M</TD><TD bgcolor='#E9F2F7'>UNIT PRICE</TD><TD bgcolor='#E9F2F7'>WAREHOUSE</TD><TD bgcolor='#E9F2F7'>VENDOR #</TD><TD bgcolor='#E9F2F7'>UNIT COST</TD><TD bgcolor='#E9F2F7'>GROSS PROFIT</TD></TR>");

		for (int count=0; count<lineNo.size(); count++){
			
			if(!lineNo.elementAt(count).toString().equals(lineNoOld) && lineNoOld.trim().length()>0){
				if(colorx.equals("#FFFFFF")){
					colorx="#DDDDDD";
				}
				else{
					colorx="#FFFFFF";
				}
			}
			lineNoOld=lineNo.elementAt(count).toString();
			if(blockId.elementAt(count).toString().equals("D_NOTES")||blockId.elementAt(count).toString().equals("B_NOTES")||blockId.elementAt(count).toString().equals("E_DIM2")){
				out.println("<tr><td bgcolor='"+colorx+"'>&nbsp;</td><td bgcolor='"+colorx+"'> <b>NOTE:</b> "+description.elementAt(count).toString()+"</td><td bgcolor='"+colorx+"' colspan='8'>&nbsp;</td></tr>");
			}

			else{
				String colorxx="black";
				if(isGood.elementAt(count).equals("NO")){
					colorxx="red";
				}
				String urlxx="http://"+ application.getInitParameter("HOST")+"/cse/csoe?csc=true&revision=1&doc_type=Q&cmd=CUSTOM_INT&product_id="+productId.elementAt(count).toString()+"&order_no="+OrderNum+"&line_no="+lineNo.elementAt(count).toString()+"&readonly=false&username="+name+"&canurl=http://"+ application.getInitParameter("HOST")+"/custom/quotes/order_list.jsp?username="+name+"&returl=http://"+ application.getInitParameter("HOST")+"/custom/quotes/order_list.jsp";
				String fullServerName="http://"+ application.getInitParameter("HOST");
				urlxx=fullServerName+"/cse/cse?cmd=CI&csc=true&readonly=false&qt=L&revision=1&username="+name+"&pid="+productId.elementAt(count).toString()+"&orderno="+OrderNum+"&item_no="+lineNo.elementAt(count).toString()+"&doc_type=Q&canurl="+fullServerName+"/erapid/us/lineItem.jsp&returl="+fullServerName+"/erapid/us/lineItem.jsp";
//out.println(urlxx+"<BR><BR>");

//out.println("<input type='button' name='button1' value='Edit line "+lineNo.elementAt(count).toString()+"' onclick='javascript:editLine('"+urlxx+"')'");

	%>
	<input type='hidden' name='url<%=count%>' value='<%=urlxx%>'>

	<%
	if(isGood.elementAt(count).equals("NO")){
		out.println("<tr><td bgcolor='"+colorx+"'><font color='"+colorxx+"'>");
	%>
	<input type='button' name='button1' value='Edit Line <%= lineNo.elementAt(count).toString()%>' onclick='javascript:editLine(document.repform.url<%=count%>);
			window.close();'>
	<%
	out.println("&nbsp;&nbsp;&nbsp;"+bpcsNum.elementAt(count).toString()+"</td>");
}
else{
	out.println("<tr><td bgcolor='"+colorx+"'><font color='"+colorxx+"'>"+lineNo.elementAt(count).toString()+"&nbsp;&nbsp;&nbsp;"+bpcsNum.elementAt(count).toString()+"</td>");
}

out.println("<td bgcolor='"+colorx+"'><font color='"+colorxx+"'>"+description.elementAt(count).toString()+"</td>");
out.println("<td bgcolor='"+colorx+"'><font color='"+colorxx+"'>"+totalPrice.elementAt(count).toString()+"</td>");
out.println("<td bgcolor='"+colorx+"'><font color='"+colorxx+"'>"+bpcsQty.elementAt(count).toString()+"</td>");
out.println("<td bgcolor='"+colorx+"'><font color='"+colorxx+"'>"+uom.elementAt(count).toString()+"</td>");
out.println("<td bgcolor='"+colorx+"'><font color='"+colorxx+"'>"+unitPrice.elementAt(count).toString()+"</td>");
out.println("<td bgcolor='"+colorx+"'><font color='"+colorxx+"'>"+line_whse.elementAt(count).toString()+"</td>");
out.println("<td bgcolor='"+colorx+"'><font color='"+colorxx+"'>"+vendorNum.elementAt(count).toString()+"</td>");
out.println("<td bgcolor='"+colorx+"'><font color='"+colorxx+"'>"+unitCost.elementAt(count).toString()+"</td>");
out.println("<td bgcolor='"+colorx+"'><font color='"+colorxx+"'>"+grossProfit.elementAt(count).toString()+"</td></tr>");



}

}

out.println("<tr><td colspan='10'>&nbsp;</td></tr>");
out.println("<tr><td bgcolor='#E9F2F7'>FREIGHT CHARGES</td><TD >"+exclusionsFreeText+"</TD><TD COLSPAN='8'>&nbsp;</td></tr>");
out.println("<tr><td bgcolor='#E9F2F7'>LEAD TIMES</td><TD >"+qualifyingNotesFreeText+"</TD><TD COLSPAN='8'>&nbsp;</td></tr>");
//out.println("<tr><td>"+exclusionsFreeText+"</td><TD>"+qualifyingNotesFreeText+"</TD><TD COLSPAN='8'>&nbsp;</td></tr>");
out.println("<tr><td>"+exclusionsFreeText+"</td><TD>"+qualifyingNotesFreeText+"</TD><TD COLSPAN='8'>&nbsp;</td></tr>");

	//String exclusions="";
	//String qualifying_notes="";
//out.println("exclusions:::"+exclusions+"<BR>select description FROM cs_exc_notes where product_id='GE' and code in ("+exclusions+") order by code ");
if(exclusions != null && exclusions.trim().length()>0){
	int counter=0;
	ResultSet cs_exc_notes = stmt.executeQuery("select description FROM cs_exc_notes where product_id='GE' and code in ("+exclusions+") order by code ");
	if (cs_exc_notes !=null) {
		while (cs_exc_notes.next()) {
			if(counter==0){
				out.println("<tr><td bgcolor='#E9F2F7'>EXCLUSION NOTES</td>");
			}
			else{
				out.println("<tr><td bgcolor='#E9F2F7'></td>");
			}
			out.println("<td colspan='7'>"+cs_exc_notes.getString("description")+"</td></tr>");
			counter++;
		}
	}
	cs_exc_notes.close();
}
if(qualifying_notes != null && qualifying_notes.trim().length()>0){
	int counter=0;
ResultSet cs_qlf_notes = stmt.executeQuery("select description FROM cs_qlf_notes where product_id='GE' and code in ("+qualifying_notes+") order by code ");
if (cs_qlf_notes !=null) {
	while (cs_qlf_notes.next()) {
			if(counter==0){
				out.println("<tr><td bgcolor='#E9F2F7'>QUALIFYING NOTES</td>");
			}
			else{
				out.println("<tr><td bgcolor='#E9F2F7'></td>");
			}
		out.println("<td colspan='7'>"+cs_qlf_notes.getString("description")+"</td></tr>");
counter++;
	}
}
cs_qlf_notes.close();
}
out.println("<tr><td colspan='10'>&nbsp;</td></tr>");
out.println("<tr><td colspan='1' bgcolor='#E9F2F7'>Special Instructions</td><td colspan='9'>&nbsp;</td></tr>");
out.println("<tr><td colspan='10'>"+freeText+"</td></tr>");

}
String url="http://"+application.getInitParameter("HOST")+"/custom/quotes/product_transfer.jsp?product="+product+"&re_no="+re_no;
url=url+"&rep_type="+rep_type+"&qtype=cpy&cmd=cpy&q_no="+OrderNum+"&order_no="+OrderNum+"&usergroup="+usergroup+"&ccode="+ccode+"&psa_quote_no="+projectTypeId;
out.println("<input type='hidden' name='newQuote' value='"+url+"'>");
/*
	%>
	<tr><td colspan='10' align='center'><input type='submit' name='OK' value='EDIT THIS PROFILE' class='button'>
			<%
			if(!isExpired){
			%>
			<input type='button' name='runthis' value='CREATE QUOTE' class='button' onclick='createQuote();
					window.close();'></td></tr>
			<%
			}
*/
			%>
	<tr><TD COLsPAN='10'>Internal Notes</TD></TR>
	<tr><td colspan='10'><%=instructions%></td></td>
		</table>
</form>
</html>