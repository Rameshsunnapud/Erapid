<%
					ResultSet rsSf0x=stmt_sfdc.executeQuery("select Addenda__c,Alternate__c,Spec_section__c from Quotes__c where name='"+salesForceNo+"'");
					if(rsSf0x != null){
						while(rsSf0x.next()){
							psa_addenda= rsSf0x.getString("Addenda__c");
							psa_alternate=rsSf0x.getString("Alternate__c");
							psa_spec_section=rsSf0x.getString("Spec_section__c");
						}
					}
					rsSf0x.close();

%>
<hr>
<table  width='100%' align='center' cellspacing='0' cellpadding='0' border='0'>
	<tr><td class='mainbody'>
			<%
			if ((product.equals("GCP"))){
				if(type.equals("3")){
					out.println("<BR>All as per plans and specifications, including any addenda referenced below, except that the following terms, conditions and products descriptions shall apply.");
				}
				else{
					out.println("<BR>Proposal based on types and quantities per Fax/Email dated: "+psa_req_date+"</td></tr>");
				}
			//out.println("We thank you for the opportunity given us to quote and hope we may have the pleasure of furnishing your requirements."+
			//"This quotation is based on the types, quantities, sizes and specification shown below. Any changes will alter the price shown. If you need additional information, please contact the person at the e-mail address and phone number shown above");
			}
			else if ((product.equals("GE"))){out.println("The following price is based on furnishing the types, quantities, and sizes listed herein. If ultimate quantities or types deviate from those listed, price is subject to increase or decrease proportionately. All PO's are to be made out to IMPACT SPECIALTIES, formerly Grand Entrance.");}
			else{

			 if(type.equals("1")|type.equals("2")|type.equals("5")|type.equals("6")){
				if(product.equals("ADS")){
					out.println("The following price is based on furnishing the types, quantities, and sizes listed herein. If ultimate quantities or types deviate from those listed, price is subject to increase or decrease proportionately. <b>All PO's are to be made out to Construction Specialties, Inc. without exception. </b> ");
				}
				else{
					out.println("The following price is based on furnishing the types, quantities, and sizes listed herein. If ultimate quantities or types deviate from those listed, price is subject to increase or decrease proportionately.<b> All PO's are to be made out to ");
					if(product.equals("APC")){
						out.println("Construction Specialties, Inc. c/o APC Dayliter.</b>");
					}
					else{
						if ( (doc_priority.equals("E")) ){
							out.println("Construction Specialties, Inc. without exception.</b>");
						}
						else{
							out.println("Construction Specialties, Inc. without exception.</b>");
						}
					}
				}
			 }
			 else{
				if(product.equals("ADS")|product.equals("LVR")){
					out.println(" All as per plans and specifications, including any addenda referenced below, except that the following terms, conditions, and product descriptions shall apply. <b> All PO's are to be made out to Construction Specialties, Inc. without exception.  <B>");

				}
				else{
					out.println(" All as per plans and specifications, including any addenda referenced below, except that the following terms, conditions, and product descriptions shall apply.");
				}
			 }
			}
			//out.println(product);
			if(!group_id.startsWith("Internatio")){
				if(!(product.equals("ADS")|product.equals("APC")|product.equals("GCP")|product.equals("GE"))){
					//out.println("HERE");
			%>

		</td></tr>
	<tr><td>&nbsp;</td></tr>
</table>
<%
if(product.equals("LVR")){
%>
<table border='0' width='100%' class='table_thin_borders' style='border-collapse: collapse;' cellspacing='0' cellpadding='3'>
	<%
	}
	else{
	%>
	<table border='1' width='100%' class='table_thin_borders' style='border-collapse: collapse;' cellspacing='0' cellpadding='3'>
		<%
		}
		if( !(product.equals("LVR")|product.equals("BV")|product.equals("GRILLE")|product.equals("GE")|group_id.startsWith("Decolink")|product.equals("ADS")|product.equals("REF") )){
			//out.println("HERE1");
			if( !group_id.startsWith("Internatio") || (group_id.startsWith("Internatio")&& (psa_spec_section!=null&&psa_spec_section.trim().length()>0))){
				out.println("<tr><td class='mainbody' width='20%'><b>Spec Section:</b></td>");
				if(! ((psa_spec_section==null)||((psa_spec_section.trim()).length()<0)) )  {
					out.println("<td class='mainbody' align='left'>"+psa_spec_section+"</td></tr>");
				}
				else{
					out.println("<td>&nbsp;</td></tr>");
				}
			}
			if(psa_alternate==null){
				psa_alternate="";
			}
			if(psa_addenda==null){
				psa_addenda="";
			}
			if(product.equals("EJC")&& (psa_alternate==null)||(psa_alternate.trim().length()<0)){
				psa_alternate="N/A";
			}
			if(product.equals("EJC")&& (psa_addenda==null)||(psa_addenda.trim().length()<0)){
				psa_addenda="N/A";
			}
			if(! ( (psa_alternate==null)||((psa_alternate.trim()).length()<0)) )  {
                            out.println("<tr><td class='mainbody' width='20%'><b>Alternate:</b></td><td class='mainbodyh' align='left'>"+ psa_alternate +"</td></tr>");
			}
			if( ! ((psa_addenda==null)||((psa_addenda.trim()).length()<0)) )  {
                            out.println("<tr><td class='mainbody' width='20%'><b>Addenda:</b></td><td class='mainbodyh' align='left'> "+  psa_addenda +"</td></tr>");
			}
		}
		else{
			//out.println("HERE2");
			//out.println("HERE2"+sections+"::"+type);
			if((sections<=0||product.equals("LVR")||product.equals("GRILLE")) && !product.equals("REF")){
				//if(type.equals("3")){
					out.println("<tr><td class='mainbody' width='50%'><b>Addenda:</b></td><td align='left' width='50%'> "+lvr_sec_add+"</td></tr>");
					out.println("<tr><td class='mainbody' width='50%'><b>Proposal Based on Material as Specified in Section:</b></td><td align='left' width='50%'>"+ lvr_spec_sec +"</td></tr>");
					out.println("<tr><td class='mainbody' width='50%'><b>Quantities per Plans Dated:</b></td><td align='left' width='50%'> "+  lvr_sec_date +"</td></tr>");
				// }
			 }
		}
	}
	else if(product.equals("LVR")||(product.equals("GCP")&&type.equals("3"))){
		//out.println("HERE3");
		%>
		</td></tr>
		<tr><td>&nbsp;</td></tr>
	</table>
	<table border='1' width='100%' cellspacing='0' cellpadding='3'>
		<%
		out.println("<tr><td class='mainbody' width='40%'><b>Addenda:</b></td>");
		if( ! ((psa_addenda==null)||((psa_addenda.trim()).length()<0)) )  {
			out.println("<td class='mainbodyh' align='left' width='60%'> "+  psa_addenda +"</td></tr>");
		}
		else{
			out.println("<td width='60%'>&nbsp;</td></tr>");
		}
		out.println("<tr><td class='mainbody'><b>Proposal Based on Material as  Specified in Section:</b></td>");
		if(! ((psa_spec_section==null)||((psa_spec_section.trim()).length()<0)) )  {
			out.println("<td class='mainbodyh' align='left'>&nbsp;"+psa_spec_section+"</td></tr>");
		}
		else{
			out.println("<td>&nbsp;</td></tr>");
		}
		out.println("<tr><td class='mainbody'><b>Quantities per Plans Dated:</b></td>");
		out.println("<td>&nbsp;"+psa_req_date+"</td></tr>");
		//out.println("</table>");
		//out.println("<table border='0' width='100%' cellspacing='0' cellpadding='3'><tr><td class='mainbodyh'>&nbsp;<BR>PROPOSAL BASED PER TYPES AND QUANTITIES PER FAX DATED:</td></tr></table>");
		//if(! ( (psa_alternate==null)||((psa_alternate.trim()).length()<0)) )  {
		//	out.println("<td class='mainbodyh' align='left'>"+ psa_alternate +"</td></tr>");
		//}
		//else{
			out.println("<td>&nbsp;</td></tr>");
		//}
	}
}
else{

	out.println("</td></tr>");
}
		%>


	</table>

	<%if(action.equals("rtf")){
	%>

	<%}
else{
	%>
	<BR>
	<%
}
	%>