<%
String bgcolor="";int bcount=0;
if(sections<=1){
	Vector line_no_temp=new Vector();
	Vector description_temp=new Vector();
	Vector line_no=new Vector();
	Vector description=new Vector();
	String oldDescription="";
	ResultSet rs_csquotes = stmt.executeQuery(" select cast(descript as varchar(700)) as a1, line_no from csquotes where order_no='"+order_no+"'  AND block_id NOT IN('E_DIM','E_DIM1','E_DIM2', 'A_APRODUCT', 'C_MISC', 'D_MISC5','FACTORY') order by field20, line_no,block_id");
	if (rs_csquotes !=null) {
        	while (rs_csquotes.next()) {
			line_no_temp.addElement(rs_csquotes.getString(2));
			description_temp.addElement(rs_csquotes.getString(1));
		}
	}
	rs_csquotes.close();
	for(int i=0; i<line_no_temp.size(); i++){
		String temp1="";
		String temp2="";
		for(int e=0; e<line_no_temp.size(); e++){
			if(line_no_temp.elementAt(e).toString().equals(line_no_temp.elementAt(i).toString())){
				if(temp1.trim().length()<=0||description_temp.elementAt(e).toString().trim().length()<=0){
					temp1=temp1+description_temp.elementAt(e).toString();
				}
				else{
					temp1=temp1+"<BR>"+description_temp.elementAt(e).toString();
				}
			}
		}
		boolean isMatch=false;
		for(int t=0;t<line_no.size();t++){
			if(line_no.elementAt(t).toString().equals(line_no_temp.elementAt(i).toString())){
				isMatch=true;
			}

		}
		if(!isMatch){
			description.addElement(temp1);
			line_no.addElement(line_no_temp.elementAt(i).toString());
			//out.println(line_no_temp.elementAt(i).toString()+"::"+temp1+"::<BR>");
		}
	}
	for(int c=0;c<line_no.size(); c++){
		String qty="";
		String mark="";
		String edim="";
		double tempPrice=0;
		if((oldDescription.trim().length()==0 || !oldDescription.equals(description.elementAt(c).toString()))){
			out.println(description.elementAt(c).toString()+"<BR><BR>");
			out.println("<table width='100%' cellspacing='1' cellpadding='2' border='0'><tr height='20'><td width='8%' bgcolor='white'><font class='maindesc'><b><u>Mark</u></b></font></td><td width='10%' bgcolor='white'><font class='maindesc'><b><u>Qty</u></b></font></td><td width='19%' bgcolor='white'><font class='maindesc'><b><u>Size (w x l)</u></b></font></td><td width='12%' bgcolor='white'><font class='maindesc'><b><u>Cuts/Notches</u></b></font></td><td width='8%' bgcolor='white'><font class='maindesc'><b><u>Logo</u></b></font></td><td width='30%' bgcolor='white'><font class='maindesc'><b><u>Template/Art Work</u></b></font></td><td width='13%' bgcolor='white'><font class='maindesc'><b><u>Texture/Color</u></b></font></td>");
			if((type.equals("2"))){
				out.println("<td width='13%' bgcolor='white'><font class='maindesc'><b><u>Price</u></b></font></td>");				
			}
			
			out.println("</tr>");
		}
		ResultSet csLine=stmt.executeQuery("select *,cast(descript as varchar(700)) as a1,extended_price from csquotes where order_no='"+order_no+"' and line_no='"+line_no.elementAt(c).toString()+"' and block_id='e_dim'");
		if(csLine != null){
			while(csLine.next()){
				qty=csLine.getString("qty");
				mark=csLine.getString("field17");
				edim=csLine.getString("a1");
				//tempPrice=tempPrice+new Double(csLine.getString("extended_price")).doubleValue();
			}
		}
		csLine.close();
		ResultSet csLine2=stmt.executeQuery("select extended_price from csquotes where order_no='"+order_no+"' and line_no='"+line_no.elementAt(c).toString()+"'");
		if(csLine2 != null){
			while(csLine2.next()){
				tempPrice=tempPrice+new Double(csLine2.getString("extended_price")).doubleValue();
			}
		}
		csLine2.close();
		String size="";
		String cuts="";
		String logo="";
		String template="";
		String texture="";
		//out.println(edim+"::<BR>");
		//out.println(edim.indexOf("@")+"::<BR>");


		if(edim.length()>0){
			size=edim.substring(0,edim.indexOf("@"));
			edim=edim.substring(edim.indexOf("@")+1);
			//out.println(edim+"::size<BR>");

			cuts=edim.substring(0,edim.indexOf("@"));
			edim=edim.substring(edim.indexOf("@")+1);
			//out.println(edim+"::cuts<BR>");
			logo=edim.substring(0,edim.indexOf("@"));
			edim=edim.substring(edim.indexOf("@")+1);
			//out.println(edim+"::logo<BR>");
			template=edim.substring(0,edim.indexOf("@"));
			edim=edim.substring(edim.indexOf("@")+1);
			//out.println(edim+"::template<BR>");
			texture=edim;
		}

		if(size.trim().length()==0){
			size="-NONE-";
		}
		if(cuts.trim().length()==0){
			cuts="-NONE-";
		}
		if(logo.trim().length()==0){
			logo="-NONE-";
		}
		if(template.trim().length()==0){
			template="-NONE-";
		}
		if(texture.trim().length()==0){
			texture="-NONE-";
		}
		out.println("<tr><td class='maindesc'>&nbsp;"+mark+"</td><td class='maindesc'>"+qty+"</td><td class='maindesc'>"+size+"</td><td class='maindesc'>"+cuts+"</td><td class='maindesc'>"+logo+"</td><td class='maindesc'>"+template+"</td><td class='maindesc'>"+texture+"</td>");
		if((type.equals("2"))){
			out.println("<Td class='maindesc'>");
			out.println(tempPrice+"");
			out.println("</td>");
		}
		
		
		out.println("</tr>");

		if(c==(line_no.size()-1)||!description.elementAt(c).equals(description.elementAt(c+1))){
			out.println("</table><BR>");
		}
		oldDescription=description.elementAt(c).toString();
	}



	grandtotalforsec=df0.format(grand_total3);

	//out.println(grand_total1+"::"+grand_total3);











}// if no sections
else {// if sections are there
	for1.setMinimumFractionDigits(2);
	for1.setMaximumFractionDigits(2);
	double sumTotal=0;
	ResultSet rsSumTot=stmt.executeQuery("Select sum(cast(extended_price as decimal)) from csquotes where order_no='"+order_no+"' ");
	if(rsSumTot != null){
		while(rsSumTot.next()){
			sumTotal=new Double(rsSumTot.getString(1)).doubleValue();

		}
	}
	rsSumTot.close();
	double totprice=0;String line_cost="";double line_price=0;String qual_sect="";String exec_sect="";
	for(int ye=0;ye<sect_group.size();ye++){

		double sumX=0;
		ResultSet rsSum=stmt.executeQuery("select sum(cast(extended_price as decimal)) from csquotes where order_no='"+order_no+"' and line_no in("+sect_group_lines.elementAt(ye).toString()+")");
		if(rsSum != null){
			while(rsSum.next()){
				sumX=new Double(rsSum.getString(1)).doubleValue();
				//out.println(sumX);
			}
		}

		rsSum.close();

		//double overageX=0;
		//			out.println("freightb:"+freight_cost+"sumx"+sumX+":::::"+sumTotal);
		//out.println(isSecOverage + "::" + overageSec.size()+"<BR>");
		if(isSecOverage && overageSec.size()>0){

			if((overageSec.elementAt(ye) != null && overageSec.elementAt(ye).toString().trim().length()>0)){
				overageX=new Double(overageSec.elementAt(ye).toString()).doubleValue();
			}
		}
		else{
			overageX=new Double(overage).doubleValue()*(sumX/sumTotal);
		}
		//out.println(freight_cost+"::FREIGHT");


		if(isSecFreight && freightSec.size()>0){
			//out.println("HERE1::"+freightSec.elementAt(ye).toString()+"::");
			if(freightSec.elementAt(ye) != null && freightSec.elementAt(ye).toString().trim().length()>0){
				freightX=new Double(freightSec.elementAt(ye).toString()).doubleValue();
				//					out.println("<br>hello"+freightX+"<br>");
			}
		}
		else{
			//out.println("HERE2");
			freightX=new Double(freight_cost).doubleValue()*(sumX/sumTotal);
		}


		if(isSecHandling&&handlingSec.size()>0){
			if(handlingSec.elementAt(ye) != null && handlingSec.elementAt(ye).toString().trim().length()>0){
				handlingX=new Double(handlingSec.elementAt(ye).toString()).doubleValue();
			}
		}
		else{handlingX=new Double(handling_cost).doubleValue()*(sumX/sumTotal);}


		if(isSecSetup&&setupSec.size()>0){
			if(setupSec.elementAt(ye) != null && setupSec.elementAt(ye).toString().trim().length()>0){
				setupX=new Double(setupSec.elementAt(ye).toString()).doubleValue();
			}
		}
		else{setupX=new Double(setup_cost).doubleValue()*(sumX/sumTotal);}
		//			out.println("freight:"+freightX);
		//out.println(freightX);
		totprice=sumX+overageX+freightX+handlingX+setupX;
		//header for new pages
		if(section_page==null||section_page.equals("1")){
			%>
			<%@ include file="quote_template_header.jsp"%>
			<%@ include file="quote_template_top.jsp"%>
			<%
		}
		out.println("<p class='maindesc'><b>Section: "+(String)sect_group.elementAt(ye)+"</b>" );
		Vector line_no_temp=new Vector();
		Vector description_temp=new Vector();
		Vector line_no=new Vector();
		Vector description=new Vector();
		String oldDescription="";
		ResultSet rs_csquotes = stmt.executeQuery(" select cast(descript as varchar(700)) as a1, line_no from csquotes where order_no='"+order_no+"' and line_no in("+sect_group_lines.elementAt(ye).toString()+") AND block_id NOT IN('E_DIM','E_DIM1','E_DIM2', 'A_APRODUCT', 'C_MISC', 'D_MISC5','FACTORY') order by field20, line_no,block_id");
		if (rs_csquotes !=null) {
			while (rs_csquotes.next()) {
				line_no_temp.addElement(rs_csquotes.getString(2));
				description_temp.addElement(rs_csquotes.getString(1));
			}
		}
		rs_csquotes.close();
		for(int i=0; i<line_no_temp.size(); i++){
			String temp1="";
			String temp2="";
			for(int e=0; e<line_no_temp.size(); e++){
				if(line_no_temp.elementAt(e).toString().equals(line_no_temp.elementAt(i).toString())){
					if(temp1.trim().length()<=0){
						temp1=temp1+description_temp.elementAt(e).toString();
					}
					else{
						temp1=temp1+"<BR>"+description_temp.elementAt(e).toString();
					}
				}
			}
			boolean isMatch=false;
			for(int t=0;t<line_no.size();t++){
				if(line_no.elementAt(t).toString().equals(line_no_temp.elementAt(i).toString())){
					isMatch=true;
				}

			}
			if(!isMatch){
				description.addElement(temp1);
				line_no.addElement(line_no_temp.elementAt(i).toString());
				//out.println(line_no_temp.elementAt(i).toString()+"::"+temp1+"::<BR>");
			}
		}

		for(int c=0;c<line_no.size(); c++){

			String qty="";
			String mark="";
			String edim="";
			if((oldDescription.trim().length()==0 || !oldDescription.equals(description.elementAt(c).toString()))){
				out.println("<BR>"+description.elementAt(c).toString()+"</p>");
				out.println("<table width='100%' cellspacing='1' cellpadding='2' border='0'><tr height='20'><td width='8%' bgcolor='white'><font class='maindesc'><b><u>Mark</u></b></font></td><td width='10%' bgcolor='white'><font class='maindesc'><b><u>Qty</u></b></font></td><td width='19%' bgcolor='white'><font class='maindesc'><b><u>Size (w x l)</u></b></font></td><td width='12%' bgcolor='white'><font class='maindesc'><b><u>Cuts/Notches</u></b></font></td><td width='8%' bgcolor='white'><font class='maindesc'><b><u>Logo</u></b></font></td><td width='30%' bgcolor='white'><font class='maindesc'><b><u>Template/Art Work</u></b></font></td><td width='13%' bgcolor='white'><font class='maindesc'><b><u>Texture/Color</u></b></font></td></tr>");
			}
			ResultSet csLine=stmt.executeQuery("select *,cast(descript as varchar(700)) as a1 from csquotes where order_no='"+order_no+"' and line_no='"+line_no.elementAt(c).toString()+"' and block_id='e_dim'");
			if(csLine != null){
				while(csLine.next()){
					qty=csLine.getString("qty");
					mark=csLine.getString("field17");
					edim=csLine.getString("a1");
				}
			}
			csLine.close();

			String size="";
			String cuts="";
			String logo="";
			String template="";
			String texture="";
			//out.println(edim+"<BR>");
			if(edim.trim().length()>0){
				//out.println(edim+"<BR>")
				size=edim.substring(0,edim.indexOf("@"));
				edim=edim.substring(edim.indexOf("@")+1);
				//out.println(edim+"::size<BR>");
				cuts=edim.substring(0,edim.indexOf("@"));
				edim=edim.substring(edim.indexOf("@")+1);
				//out.println(edim+"::cuts<BR>");
				logo=edim.substring(0,edim.indexOf("@"));
				edim=edim.substring(edim.indexOf("@")+1);
				//out.println(edim+"::logo<BR>");
				template=edim.substring(0,edim.indexOf("@"));
				edim=edim.substring(edim.indexOf("@")+1);
				//out.println(edim+"::template<BR>");
				texture=edim;
			}

			if(size.trim().length()==0){
				size="-NONE-";
			}
			if(cuts.trim().length()==0){
				cuts="-NONE-";
			}
			if(logo.trim().length()==0){
				logo="-NONE-";
			}
			if(template.trim().length()==0){
				template="-NONE-";
			}
			if(texture.trim().length()==0){
				texture="-NONE-";
			}
			out.println("<tr><td class='maindesc'>&nbsp;"+mark+"</td><td class='maindesc'>"+qty+"</td><td class='maindesc'>"+size+"</td><td class='maindesc'>"+cuts+"</td><td class='maindesc'>"+logo+"</td><td class='maindesc'>"+template+"</td><td class='maindesc'>"+texture+"</td></tr>");

			if(c==(line_no.size()-1)||!description.elementAt(c).equals(description.elementAt(c+1))){
				out.println("</table><BR>");
			}
			oldDescription=description.elementAt(c).toString();

		}

		out.println("<table width='100%' cellspacing='0' cellpadding='1' border='0'>");
		if(section_notes!=null &&section_notes.trim().length()>0 && ! (section_notes.equals("null"))){
			out.println("<tr height='20'>");
			out.println("<td class='mainbodyh' colspan='5' align='left'>");out.println(sect_notes.elementAt(ye));	out.println("</td>");
			out.println("</tr>");//free notes end
		}
		if( !(section_qual==null||section_qual.trim().equals("")||sect_qual.elementAt(ye).toString().trim().equals("")) ){
			out.println("<tr><td class='mainbodyh' colspan='5' ><b>QUALIFYING NOTES:</b></td></tr>");
			if((""+ye).equals(""+(sect_group.size()-1))||(section_page==null||section_page.equals("1"))){
				if (qual_count>0){qual_sect=qualifying_notes+","+sect_qual.elementAt(ye).toString();}
				else{qual_sect=sect_qual.elementAt(ye).toString();}//
			}
			else{
				qual_sect=sect_qual.elementAt(ye).toString();
			}

		}
		else if((qual_sect != null && qual_sect.trim().length()>0)||(qualifying_notes_free_text != null && qualifying_notes_free_text.trim().length()>0) || (free_text != null && free_text.trim().length()>0)){
			if((""+ye).equals(""+(sect_group.size()-1))){
				out.println("<tr><td class='mainbodyh' colspan='6' ><b>QUALIFYING NOTES:</b></td></tr>");
				qual_sect=qualifying_notes;
			}
		}
		//all in qualifying notes
		if(qual_sect!=null&&qual_sect.trim().length()>0){
			ResultSet cs_exc_notes1 = stmt.executeQuery("select description FROM cs_qlf_notes where product_id='"+product+"' and code in ("+qual_sect+") order by code ");
	  		if (cs_exc_notes1 !=null) {
	        		while (cs_exc_notes1.next()) {
					out.println("<tr><td class='mainbodyh' colspan='3'>"+cs_exc_notes1.getString("description")+"</td></tr>");
				}
			}
			cs_exc_notes1.close();
		}
		if((""+ye).equals(""+(sect_group.size()-1))||(section_page==null||section_page.equals("1"))){
			out.println("<tr><td colspan='6' class='mainbodyh'>"+qualifying_notes_free_text+"</td></tr>");
		}
		//qualifying notes end
		if( !(section_exc==null||section_exc.trim().equals("")||sect_exec.elementAt(ye).toString().trim().equals("")) ){
			if((""+ye).equals(""+(sect_group.size()-1))){
				if (exc_count>0){exec_sect=exclusions+","+sect_exec.elementAt(ye);}
				else{exec_sect=sect_exec.elementAt(ye).toString();}
			}
			else{
				exec_sect=sect_exec.elementAt(ye).toString();
			}
			out.println("<tr><td class='mainbodyh' colspan='6' ><b>EXCLUSIONS/NOTES:</b></td></tr>");
		}

		else if ( ((exclusions_free_text.trim()).length()>0)|(exc_count>0)){
			if((""+ye).equals(""+(sect_group.size()-1))||(section_page==null||section_page.equals("1"))){
				out.println("<tr><td class='mainbodyh' colspan='6' ><b>EXCLUSIONS/NOTES:</b></td></tr>");
				exec_sect=exclusions;
			}

		}

		//exclusions
		if(exec_sect!=null&&exec_sect.trim().length()>0){
			ResultSet cs_qlf_notes1 = stmt.executeQuery("select description FROM cs_exc_notes where product_id='"+product+"' and code in ("+exec_sect+") order by code ");
	  		if (cs_qlf_notes1 !=null) {
		    		while (cs_qlf_notes1.next()) {

					out.println("<tr><td class='mainbodyh' colspan='6' >"+cs_qlf_notes1.getString("description")+"</td></tr>");
				}
			}
			cs_qlf_notes1.close();
		}
		out.println("<tr><td colspan='6' class='mainbodyh'>"+exclusions_free_text+"</td></tr>");
		if(free_text!=null){
			out.println("<tr><td colspan='6'><font class='mainbodyh'>"+free_text+"</font></td></tr>");
		}

		for1.setMaximumFractionDigits(0);for1.setMinimumFractionDigits(0);
		DecimalFormat df0efs = new DecimalFormat("####");
		price=df0efs.format(totprice);

		grand_total1=totprice;
		if(section_page==null||section_page.equals("1")){

			%>
			<%@ include file="quote_template_foot.jsp"%>
			<%@ include file="quote_template_footer.jsp"%>
			<%
			if(sect_group.size()-ye>1){
				out.println("<p style='page-break-after : always;' >&nbsp;</p>");
			}
			for1.setMaximumFractionDigits(2);
		}
		else{

			if((""+ye).equals(""+(sect_group.size()-1))){

			}
			else{

				%>
				</table>
				<table class='<%= border_color %>' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
					<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only</b></td>
					<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'><%= price %></font></b></td>
				</tr>
				</table>
				<%
				double tax_dollar=0;
				tax_dollar=(grand_total1*Double.parseDouble(tax_perc))/100;
				grand_total1=grand_total1+tax_dollar;
				for1.setMaximumFractionDigits(0);
				if (!(tax_perc==null||tax_perc.equals("0"))){
					out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
					out.println("<tr>");
					out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Tax Only</b></td>");
					out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(tax_dollar)+"</font></b></td>");
					out.println("</tr>");
					out.println("</table>");
					out.println("<table class='"+border_color+"' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>");
					out.println("<tr>");
					out.println("<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material and Tax Only </b></td>");
					out.println("<td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Total: <font class='totprice'>"+for1.format(grand_total1)+"</font></b></td>");
					out.println("</tr>");
					out.println("</table>");
					out.println("<BR><BR><BR>");
				}
				for1.setMaximumFractionDigits(2);
				for1.setMinimumFractionDigits(2);

			}
		}

		totprice=0;qual_sect=""; freightX=0;handlingX=0;overageX=0;setupX=0;

	}//for loop



}// if sections are there
%>
</table>
