<%
if(group_id.startsWith("Internatio")) {
	out.println("<br>");
}
out.println("<table cellspacing='0' align='center' cellpadding='1' border='0' width='100%'>");

if((product.equals("LVR")||product.equals("GRILLE")||product.equals("GCP")||product.equals("FSM"))&&(pricing_options.trim().length()>0 ||pricing_options_free_text.trim().length()>0)){
	out.println("<tr><td class='mainbody'><b>PRICING OPTIONS:</b></td></tr><tr><td class='mainbody'> ");
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

if(qualifying_notes_free_text == null || qualifying_notes_free_text.trim().equals("null")){
	qualifying_notes_free_text="";
}

if((sections<=1)||((product.equals("LVR")|product.endsWith("IWP")|product.endsWith("REF")|product.equals("EFS")|product.equals("GRILLE")|product.equals("GCP") )) ){

	if (product.endsWith("EXP")||((qualifying_notes_free_text.trim()).length()>0)|(qual_count>0)){out.println("<tr><td class='mainbody'><b>QUALIFYING NOTES:</b></td></tr><tr><td class='mainbody'>");}
	if(product.endsWith("EXP")){
		out.println("<tr><td class='mainbody'><b>QUALIFYING NOTES:</b></td></tr><tr><td class='mainbody'>Installations, verification of field dimensions, engineering calculations, miscellaneous steel, field-testing, <B>piping and hookups.  Structural supports required at intermediate stack joints - those structurals are excluded.</b> ");
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
		
		String qualyfyingNotesQuery = "";
		if("IWP".equals(product) && (exchName.equals("CAD") || group_id.contains("can"))){
			qualyfyingNotesQuery = "select description FROM cs_qlf_notes where product_id='"+product+"' and code in ("+qualifying_notes+") and code != '74' order by code ";
		}else{
			qualyfyingNotesQuery = "select description FROM cs_qlf_notes where product_id='"+product+"' and code in ("+qualifying_notes+") order by code ";
		}
		//out.println("Query for notes: "+qualyfyingNotesQuery);
		ResultSet cs_exc_notes = stmt.executeQuery(qualyfyingNotesQuery);
		
		if (cs_exc_notes !=null) {
			while (cs_exc_notes.next()) {
				out.println(""+cs_exc_notes.getString("description")+"<br>");
			}
		}
		cs_exc_notes.close();
	}

	if(group_id.startsWith("Internatio")||type.equals("5")||type.equals("6")) {
		if(product.equals("IWP")){
			out.println("<br>This quote supersedes all previous quotes that have been issued for this project and all verbal offers that may have been given.<BR>");
		}
		out.println("<br>Material Prices are in U.S. Dollars  - FCA your forwarder, Continental US Port, domestic packed in corrugated cardboard.  For ocean crating add 6.8% to material value.");
	}
		//out.println("<tr><td class='mainbody'>&nbsp;</td></tr>");
		out.println(""+qualifying_notes_free_text+"</td></tr>");
	}
if(exclusions_free_text == null || exclusions_free_text.trim().equals("null")){
	exclusions_free_text="";
}

	if((sections<=1)||((product.equals("LVR")|product.endsWith("IWP")|product.equals("EFS")|product.equals("GRILLE")|product.equals("GCP") )) ){
		if (((exclusions_free_text.trim()).length()>0)|(exc_count>0)|(product.endsWith("LVR")|product.equals("BV"))){out.println("");}
		if (exc_count>0){
			out.println("<tr><td class='mainbody'><BR><b>EXCLUSION NOTES:</b></td></tr>");
//out.println("select description FROM cs_exc_notes where product_id='"+product+"' and code in ("+exclusions+") order by code");
			ResultSet cs_qlf_notes = stmt.executeQuery("select description FROM cs_exc_notes where product_id='"+product+"' and code in ("+exclusions+") order by code ");
			if(product.endsWith("LVR")|product.equals("BV")){
				product="LVR";
				out.println("<tr><td class='mainbody'>"+"Installation, Miscellaneous steel, Verification of field dimensions, Caulking & flashing, Bonds, Sealant and backer rod");
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
				out.println("<tr><td class='mainbody'>");
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
			out.println("<tr><td class='mainbody'><BR><b>EXCLUSION NOTES:</b></td></tr>");
			out.println("<tr><td class='mainbody'>"+"Installation, Miscellaneous steel, Verification of field dimensions, Caulking & flashing, Bonds, Sealant and backer rod.");
			out.println("</td></tr>");
		}
	}

	if(exclusions_free_text.trim().length()>0){
		if(exc_count<=0&&!(product.endsWith("LVR")|product.equals("BV"))){
			out.println("<tr><td class='mainbody'><BR><b>EXCLUSION NOTES:</b></td></tr>");
		}
		out.println("<tr><td class='mainbody'>"+exclusions_free_text+"</td></tr>");
	}
	if(free_text.trim().startsWith("nu")){free_text="";}
	if(free_text.trim().length()>0){
out.println("<tr><td class='mainbody'></td></tr>");
		out.println("<tr><td class='mainbody'>"+free_text+"</font></td></tr>");
	}


}

if((group_id.toUpperCase().startsWith("REP") && project_type!= null && project_type.equals("PSA"))){
	out.println("<tr><td class='mainbody'>");
	if(rep_notes !=null&&rep_notes.trim().length()>0){out.println("<b>Notes:</b> "+rep_notes);}
	out.println("</td></tr>");
}

//out.println(product+"::"+addSFDC+"::"+deductSFDC+"::<BR>");
if(product.equals("EJC")){
	if(addSFDC != null && addSFDC.trim().length()>0){
		out.println("<tr><td class='mainbody'><BR><b>ADD OPTIONS:</b></td></tr>");
		out.println("<tr><td class='mainbody'>"+addSFDC);
		out.println("</td></tr>");
	}
	if(deductSFDC != null && deductSFDC.trim().length()>0){
		out.println("<tr><td class='mainbody'><BR><b>DEDUCT OPTIONS:</b></td></tr>");
		out.println("<tr><td class='mainbody'>"+deductSFDC);
		out.println("</td></tr>");
	}
}

if(sfdcNotes != null && sfdcNotes.trim().length()>0){
	out.println("<tr><td class='mainbody'>");
	out.println("<b>Notes:</b> "+sfdcNotes);
	out.println("</td></tr>");
}

%>
</table>

