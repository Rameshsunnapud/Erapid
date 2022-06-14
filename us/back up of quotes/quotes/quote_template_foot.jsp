
<%
//out.println("HERE");
if(sections<=1 || (product.equals("IWP")&&section_page.equals("0"))){
//out.println("HERE<BR>");
	for(int rr=0; rr<qualifying_notes_free_text.length(); rr++){
		//out.println((int)qualifying_notes_free_text.charAt(rr)+"#"+qualifying_notes_free_text.charAt(rr)+"::");
		if((int)qualifying_notes_free_text.charAt(rr)==10){
			qualifying_notes_free_text=qualifying_notes_free_text.substring(0,rr)+"<br>"+qualifying_notes_free_text.substring(rr);
			rr=rr+4;
		}
	}
	for(int rr=0; rr<exclusions_free_text.length(); rr++){
		if((int)exclusions_free_text.charAt(rr)==10){
			exclusions_free_text=exclusions_free_text.substring(0,rr)+"<br>"+exclusions_free_text.substring(rr);
			rr=rr+4;
		}
	}
	for(int rr=0; rr<free_text.length(); rr++){
		//out.println((int)qualifying_notes_free_text.charAt(rr)+"#"+qualifying_notes_free_text.charAt(rr)+"::");
		if((int)free_text.charAt(rr)==10){
			free_text=free_text.substring(0,rr)+"<br>"+free_text.substring(rr);
			rr=rr+4;
		}
	}

		if (((free_text.trim()).length()>0)){
			out.println("<table cellspacing='0' align='center' cellpadding='1' border='0' width='100%'>");
			out.println("<tr><td class='mainbodyh'>");
			out.println("<font class='mainbodyh'>"+free_text+"<br></font>");
			out.println("</td></tr>");
			out.println("</table>");
		}

%>
<table cellspacing='0' align='center' cellpadding='1' border='0' width='100%'>
	<%
	if (((qualifying_notes_free_text.trim()).length()>0)|(qual_count>0)|(product.endsWith("LVR")|product.equals("BV")|product.equals("GCP"))){
		out.println("<tr><td class='mainbodyh'><b>QUALIFYING NOTES:</b></td></tr>");
	}
	if (qual_count>0){
		if(product.endsWith("LVR")){

			product="LVR";
			out.println("<tr><td class='mainbodyh'>"+"All fasteners to structure are to be by others."+"</td></tr>");
			out.println("<tr><td class='mainbodyh'>"+"Price is based on tear sheet Type shop drawing submittal and approval."+"</td></tr>");
			out.println("<tr><td class='mainbodyh'>"+"Job is based on wind load specified, and has not been reviewed for code compliance."+"</td></tr>");
			out.println("<tr><td class='mainbodyh'>"+"This quotation is based upon material types, quantities, sizes, and accessories as stated above. ALL ITEMS NOT SPECIFICALLY LISTED ARE EXPRESSLY EXCLUDED."+"</td></tr>");
		}
		else if(product.equals("BV")){
			product="LVR%";
			out.println("<tr><td class='mainbodyh'>"+"Price is based on tear sheet Type shop drawing submittal and approval."+"</td></tr>");
			out.println("<tr><td class='mainbodyh'>"+"This quotation is based upon material types, quantities, sizes, and accessories as stated above. ALL ITEMS NOT SPECIFICALLY LISTED ARE EXPRESSLY EXCLUDED."+"</td></tr>");
		}
		else if(product.equals("GCP")){
			out.println("<tr><td class='mainbodyh'>"+"Track lead-time is approximately 2 to 3 weeks after receipt of order and approvals."+"</td></tr>");
			out.println("<tr><td class='mainbodyh'>"+"Cubicle Curtain track includes all standard bends (12\" radius), 2.2 carriers per ft, splices, end stops & gates as required unless otherwise noted."+"</td></tr>");
		}
		//out.println(product+"::"+qualifying_notes+"<BR>");
			ResultSet cs_exc_notes = stmt.executeQuery("select description FROM cs_qlf_notes where product_id like '"+product+"' and code in ("+qualifying_notes+") order by code ");
			if (cs_exc_notes !=null) {
		   while (cs_exc_notes.next()) {
			out.println("<tr><td class='mainbodyh'>"+cs_exc_notes.getString("description")+"</td></tr>");
										}
									}
			cs_exc_notes.close();
			//out.println("<tr><td class='mainbodyh'>&nbsp;</td></tr>");
	}
	else{
		if(product.endsWith("LVR")){
			out.println("<tr><td class='mainbodyh'>"+"All fasteners to structure are to be by others."+"</td></tr>");
			out.println("<tr><td class='mainbodyh'>"+"Price is based on tear sheet Type shop drawing submittal and approval."+"</td></tr>");
			out.println("<tr><td class='mainbodyh'>"+"Job is based on wind load specified, and has not been reviewed for code compliance."+"</td></tr>");
			out.println("<tr><td class='mainbodyh'>"+"This quotation is based upon material types, quantities, sizes, and accessories as stated above. ALL ITEMS NOT SPECIFICALLY LISTED ARE EXPRESSLY EXCLUDED."+"</td></tr>");
			out.println("<tr><td class='mainbodyh'>&nbsp;</td></tr>");
		}
		else if(product.equals("BV")){
			out.println("<tr><td class='mainbodyh'>"+"Price is based on tear sheet Type shop drawing submittal and approval."+"</td></tr>");
			out.println("<tr><td class='mainbodyh'>"+"This quotation is based upon material types, quantities, sizes, and accessories as stated above. ALL ITEMS NOT SPECIFICALLY LISTED ARE EXPRESSLY EXCLUDED."+"</td></tr>");
			out.println("<tr><td class='mainbodyh'>&nbsp;</td></tr>");
		}
		else if(product.equals("GCP")){
			out.println("<tr><td class='mainbodyh'>"+"Track lead-time is approximately 2 to 3 weeks after receipt of order and approvals."+"</td></tr>");
			out.println("<tr><td class='mainbodyh'>"+"Cubicle Curtain track includes all standard bends (12\" radius), 2.2 carriers per ft, splices, end stops & gates as required unless otherwise noted."+"</td></tr>");
		}
	}

		if (((qualifying_notes_free_text.trim()).length()>0)){
			out.println("<tr><td class='mainbodyh'>"+qualifying_notes_free_text+"</td></tr>");
		}

	if (((exclusions_free_text.trim()).length()>0)|(exc_count>0)|(product.endsWith("LVR")|product.equals("BV")|product.equals("GCP"))){out.println("<tr><td class='mainbodyh'><b>EXCLUSION NOTES:</b></td></tr>");}
	if (exc_count>0){
		ResultSet cs_qlf_notes = stmt.executeQuery("select description FROM cs_exc_notes where product_id='"+product+"' and code in ("+exclusions+") order by code ");
		if(product.endsWith("LVR")|product.equals("BV")){
		product="LVR";
		out.println("<tr><td class='mainbodyh'>"+"Installation, Miscellaneous steel, Verification of field dimensions, Caulking & flashing, Bonds, Sealant and backer rod");
				if (cs_qlf_notes !=null) {
				while (cs_qlf_notes.next()) {
					out.println(", "+cs_qlf_notes.getString("description"));
					}
				}
		out.println(".");
		out.println("</td></tr>");
		}
		else if(product.equals("GCP")){
			out.println("<tr><td class='mainbodyh'>"+"ALL ITEMS NOT SPECIFICALLY LISTED ARE EXPRESSLY EXCLUDED."+"</td></tr>");
			out.println("<tr><td class='mainbodyh'>"+"Excludes mounting hardware, wood blocking, above ceiling supports, Tee's, Y's and switches."+"</td></tr>");
			out.println("<tr><td class='mainbodyh'>"+"Excludes CURTAINS. "+"</td></tr>");
		}
		else{
				if (cs_qlf_notes !=null) {
				   while (cs_qlf_notes.next()) {
					out.println("<tr><td class='mainbodyh'>"+cs_qlf_notes.getString("description")+"</td></tr>");
					}
				}
		}
		cs_qlf_notes.close();
		out.println("<tr><td class='mainbodyh'>&nbsp;</td></tr>");
	}
	else{
		if(product.endsWith("LVR")|product.equals("BV")){
		out.println("<tr><td class='mainbodyh'>"+"Installation, Miscellaneous steel, Verification of field dimensions, Caulking & flashing, Bonds, Sealant and backer rod.");
		out.println("</td></tr>");
		out.println("<tr><td class='mainbodyh'>&nbsp;</td></tr>");
		}
		else if(product.equals("GCP")){
			out.println("<tr><td class='mainbodyh'>"+"ALL ITEMS NOT SPECIFICALLY LISTED ARE EXPRESSLY EXCLUDED."+"</td></tr>");
			out.println("<tr><td class='mainbodyh'>"+"Excludes mounting hardware, wood blocking, above ceiling supports, Tee's, Y's and switches."+"</td></tr>");
			out.println("<tr><td class='mainbodyh'>"+"Excludes CURTAINS. "+"</td></tr>");
		}
	}
	%>
	<tr><td class='mainbodyh'><%= exclusions_free_text %></td></tr>
		<%if((session_group_id.toUpperCase().startsWith("REP") && project_type!= null && project_type.equals("PSA"))){ %>
	<tr><td class='mainbodyh'><% if(rep_notes !=null){out.println("<b>Notes:</b> "+rep_notes);} %></td></tr>
		<%}
	}//for sections is zero
		%>
</table>
<br>