<%
if(group_id.startsWith("Internatio")) {
	out.println("<br>");
}
out.println("<table cellspacing='0' align='center' cellpadding='1' border='0' width='100%'>");

if((product.equals("LVR")||product.equals("GRILLE")||product.equals("GCP"))&&(pricing_options.trim().length()>0 ||pricing_options_free_text.trim().length()>0)){
	out.println("<tr><td class='mainbodyh'><b>PRICING OPTIONS:</b></td></tr><tr><td class='mainbodyh'> ");
	if(pricing_options.trim().length()>0){
		ResultSet rsPricingOptions=stmt.executeQuery("select description from cs_pricing_options where product_id='"+product+"' and code in ("+pricing_options+")");
		if(rsPricingOptions != null){
			while(rsPricingOptions.next()){
				out.println(rsPricingOptions.getString(1)+"<BR>");
			}
		}
		rsPricingOptions.close();
	}
	if(pricing_options_free_text.trim().length()>0){
		out.println(pricing_options_free_text+"<BR>");
	}
	out.println("&nbsp;</td></tr>");
}






if((sections<=1)||((product.equals("LVR")|product.endsWith("IWP")|product.equals("EFS")|product.equals("GRILLE")|product.equals("GCP") )) ){

	if (product.endsWith("EXP")||((qualifying_notes_free_text.trim()).length()>0)|(qual_count>0)){out.println("<tr><td class='mainbodyh'><b>QUALIFYING NOTES:</b></td></tr><tr><td class='mainbodyh'>");}
	if(product.endsWith("EXP")){
		out.println("<tr><td class='mainbodyh'><b>QUALIFYING NOTES:</b></td></tr><tr><td class='mainbodyh'>Installations, verification of field dimensions, engineering calculations, miscellaneous steel, field-testing, <B>piping and hookups.  Structural supports required at intermediate stack joints - those structurals are excluded.</b> ");
	}
	if (qual_count>0){
		if(product.endsWith("LVR")|product.equals("BV")){
			product="LVR";
		}
		if(product.equals("EJC")&&(type.equals("3")||type.equals("4"))){
			ResultSet cs_exc_notes0 = stmt.executeQuery("select description FROM cs_qlf_notes where product_id='"+product+"' and code ='102' order by code ");
			  if (cs_exc_notes0 !=null) {
			       	while (cs_exc_notes0.next()) {
					out.println(""+cs_exc_notes0.getString("description")+"<br>");
				}
			}
			cs_exc_notes0.close();
		}
		ResultSet cs_exc_notes = stmt.executeQuery("select description FROM cs_qlf_notes where product_id='"+product+"' and code in ("+qualifying_notes+") order by code ");
	  	if (cs_exc_notes !=null) {
	        	while (cs_exc_notes.next()) {
				out.println(""+cs_exc_notes.getString("description")+"<br>");
			}
		}
		cs_exc_notes.close();
	}
	else{
		int psa_qual=0;
		ResultSet rs_psa_stp = stmt_psa.executeQuery("select count(*) from dba.STANDARD_PARAS where para_id in (select entity_id from dba.quote_lines where quote_id='"+QuoteID+"'and line_type='P') and (auto_text!='QN1' and auto_text like '%Q%')");
        	while (rs_psa_stp.next()) {
			 psa_qual=rs_psa_stp.getInt(1);
			}
			rs_psa_stp.close();
			if(psa_qual>0 & !((qualifying_notes_free_text.trim()).length()>0)){out.println("<tr><td class='mainbodyh'><b>QUALIFYING NOTES:</b></td></tr>");}
			if(psa_qual>0){//out.println("quals from PSA");
			ResultSet cs_exc_notes = stmt_psa.executeQuery("select substring(note,CHARINDEX(':', note)+1) from dba.STANDARD_PARAS where para_id in (select entity_id from dba.quote_lines where quote_id='"+QuoteID+"'and line_type='P') and (auto_text!='QN1' and auto_text like '%Q%')");
		  	if (cs_exc_notes !=null) {
		        	while (cs_exc_notes.next()) {
					out.println(cs_exc_notes.getString(1)+"<BR>");
				}
			}
			cs_exc_notes.close();
		}
	}
	if(group_id.startsWith("Internatio")||type.equals("5")||type.equals("6")) {
		if(product.equals("IWP")){
			out.println("<br>This quote supersedes all previous quotes that have been issued for this project and all verbal offers that may have been given.<BR>");
		}
		out.println("<br>Material Prices are in U.S. Dollars  - FCA your forwarder, Continental US Port, domestic packed in corrugated cardboard.  For ocean crating add 6.8% to material value.");
	}
		//out.println("<tr><td class='mainbodyh'>&nbsp;</td></tr>");
		out.println(""+qualifying_notes_free_text+"</td></tr>");
	}

	if((sections<=1)||((product.equals("LVR")|product.endsWith("IWP")|product.equals("EFS")|product.equals("GRILLE")|product.equals("GCP") )) ){
		if (((exclusions_free_text.trim()).length()>0)|(exc_count>0)|(product.endsWith("LVR")|product.equals("BV"))){out.println("");}
		if (exc_count>0){
			out.println("<tr><td class='mainbodyh'><BR><b>EXCLUSION NOTES:</b></td></tr>");
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
			else{

		  		if (cs_qlf_notes !=null) {
		  		out.println("<tr><td class='mainbodyh'>");
			        while (cs_qlf_notes.next()) {
					out.println(""+cs_qlf_notes.getString("description")+"<br>");
				}
				out.println("</td></tr>");
			}
		}
		cs_qlf_notes.close();
	}
	else{
		if(product.endsWith("LVR")|product.equals("BV")){
			out.println("<tr><td class='mainbodyh'><BR><b>EXCLUSION NOTES:</b></td></tr>");
			out.println("<tr><td class='mainbodyh'>"+"Installation, Miscellaneous steel, Verification of field dimensions, Caulking & flashing, Bonds, Sealant and backer rod.");
			out.println("</td></tr>");
		}
	}
	if(exclusions_free_text.trim().length()>0){
		out.println("<tr><td class='mainbodyh'>"+exclusions_free_text+"</td></tr>");
	}
	if(free_text.trim().startsWith("nu")){free_text="";}
	if(free_text.trim().length()>0){

		out.println("<tr><td class='mainbodyh'>"+free_text+"</font></td></tr>");
	}
}
if((group_id.toUpperCase().startsWith("REP") && project_type!= null && project_type.equals("PSA"))){
	out.println("<tr><td class='mainbodyh'>");
	if(rep_notes !=null&&rep_notes.trim().length()>0){out.println("<b>Notes:</b> "+rep_notes);}
	out.println("</td></tr>");
}

 %>
</table>

