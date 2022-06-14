<%

String bgcolor="";int bcount=0;
String bodyString="";
//out.println(bgcolor+"::");
if(bgcolor != null && bgcolor.trim().length()>0){
	bodyString="'"+bgcolor+"' class='mainbody'";
}
else{
	bodyString="class='mainbody'";
}
if(sections<=0){
	out.println("<table width='100%' cellspacing='0' cellpadding='1' border='0'>");
	//int k=0;
	Vector desc=new Vector();
	String color="NONE";
	Vector line_no=new Vector();
        Vector field20=new Vector();
	//String line_no="";
	String query_init="SELECT  cast(descript as varchar(700)) as a1, line_no,field20 FROM CSQUOTES WHERE order_no = '"+order_no+"' AND block_id NOT IN('E_DIM','E_DIM1', 'A_APRODUCT', 'C_MISC', 'D_MISC5','FACTORY') and block_id like'A_%' ORDER BY field20,cast(descript as varchar(700)),line_no, block_id, sequence_no";
	//out.println(query_init);
	ResultSet rsquotesinit=stmt.executeQuery(query_init);
	if(rsquotesinit != null){
		while(rsquotesinit.next()){
			desc.addElement(rsquotesinit.getString("a1"));
			line_no.addElement(rsquotesinit.getString("line_no"));
                        field20.addElement(rsquotesinit.getString("field20"));
		}
	}
	rsquotesinit.close();
	String tempHeader="";
        String tempdesc2="";
	for(int i=0; i<desc.size(); i++){
		if(!field20.elementAt(i).toString().equals(tempHeader)){
                        if(i>0){
                            out.println("<tr><td>&nbsp;</td></tr>");
                        }
			out.println("<tr><td "+bodyString+"><b>"+desc.elementAt(i).toString()+"</b></td></tr>");
                        tempdesc2="";
		}
                
		ResultSet rscsquotes=stmt.executeQuery("select cast(descript as varchar(700)) as a1,block_id from csquotes where order_no='"+order_no+"' and line_no ='"+line_no.elementAt(i).toString()+"' AND block_id NOT IN('E_DIM','E_DIM1', 'A_APRODUCT', 'C_MISC', 'D_MISC5','FACTORY') and not block_id like 'a_%'  GROUP BY cast(descript as varchar(700)), line_no, block_id, sequence_no ORDER BY line_no, block_id, sequence_no");
		if(rscsquotes != null){
			while(rscsquotes.next()){
				String tempdesc=rscsquotes.getString("a1").trim();
                                if(tempdesc2.indexOf(tempdesc)>=0){
                                    tempdesc="";
                                }
				//+"::"+rscsquotes.getString("block_id")+"<br>";
				for(int rr=0; rr<tempdesc.length(); rr++){
					if((int)tempdesc.charAt(rr)==13){
                                                if(tempdesc2.indexOf(tempdesc.substring(0,rr))>=0){
                                                    tempdesc=tempdesc.substring(rr);
                                                }
                                                else{
                                                    tempdesc=tempdesc.substring(0,rr)+"<br>"+tempdesc.substring(rr);
                                                }
						rr=rr+4;
					}
                                        else{
                                            if(tempdesc2.indexOf(tempdesc)>=0){
                                                    tempdesc="";
                                                }
                                        }
				}
				if(tempdesc.endsWith("<br>")){
					tempdesc=tempdesc.substring(0,tempdesc.length()-4);
				}
                                if(tempdesc.length()>0){
                                    out.println("<tr><td "+bodyString+">"+tempdesc+"</td></tr>");
                                }
                                tempdesc2=tempdesc2+"<BR>"+tempdesc;
                               // out.println("<BR><BR><BR>::"+tempdesc2+"::<BR><BR><BR>");
			}
		}
		rscsquotes.close();
		tempHeader=field20.elementAt(i).toString();
	}
        out.println("<tr><td>&nbsp;</td></tr>");
	String config_price="";Vector line_item_group=new Vector();Vector line_sum_group=new Vector();double tot_sum=0;
	ResultSet rs_csquotes_sum = stmt.executeQuery("SELECT line_no, sum(cast(extended_price as decimal)) FROM CSQUOTES where order_no='"+order_no+"' group by line_no order by cast(Line_no as integer)");
	if (rs_csquotes_sum !=null) {
		while (rs_csquotes_sum.next()) {
			//config_price=rs_csquotes_sum.getString(1);
			line_item_group.addElement(rs_csquotes_sum.getString(1));
			line_sum_group.addElement(rs_csquotes_sum.getString(2));
			tot_sum=tot_sum+new Double(rs_csquotes_sum.getString(2)).doubleValue();
		}
	}
	double totprice=0;String line_cost="";
        %>
        </table>
        </font>
        <table>
	<%
	rs_csquotes_sum.close();


}
else {// if sections are there

	double grand_total1x=0.0;
	for1.setMinimumFractionDigits(2);
	for1.setMaximumFractionDigits(2);
	double sumTotal=0;double freightX=0;double handlingX=0;double setupX=0;
double sumX=0;
	ResultSet rsSumTot=stmt.executeQuery("Select sum(cast(extended_price as decimal)) from csquotes where order_no='"+order_no+"' ");
	if(rsSumTot != null){
		while(rsSumTot.next()){
			sumTotal=new Double(rsSumTot.getString(1)).doubleValue();

		}
	}
	rsSumTot.close();
	double totprice=0;String line_cost="";double line_price=0;String qual_sect="";String exec_sect="";
	for(int ye=0;ye<sect_group.size();ye++){
		
		ResultSet rsSum=stmt.executeQuery("select sum(cast(extended_price as decimal)) from csquotes where order_no='"+order_no+"' and line_no in("+sect_group_lines.elementAt(ye).toString()+")");
		if(rsSum != null){
			while(rsSum.next()){
				sumX=new Double(rsSum.getString(1)).doubleValue();
				//out.println(sumX);
			}
		}
		rsSum.close();
		double overageX=0;
		if(isSecOverage && overageSec.size()>0){
			if((overageSec.elementAt(ye) != null && overageSec.elementAt(ye).toString().trim().length()>0)){
				overageX=new Double(overageSec.elementAt(ye).toString()).doubleValue();
			}
		}
		else{
			overageX=new Double(overage).doubleValue()*(sumX/sumTotal);
		}
		if(isSecFreight && freightSec.size()>0){
			if(freightSec.elementAt(ye) != null && freightSec.elementAt(ye).toString().trim().length()>0){
				freightX=new Double(freightSec.elementAt(ye).toString()).doubleValue();
			}
		}
		else{
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
		else{
			setupX=new Double(setup_cost).doubleValue()*(sumX/sumTotal);
		}
		totprice=sumX+overageX+freightX+handlingX+setupX;
		//header for new pages

               // out.println("<p "+bodyString+"><b>Section: "+(String)sect_group.elementAt(ye)+"</b>" );

        // new by Greg March 26 2019.
        // Grouping of lines for EFS
        // Using code to match above for no sections that already works.
        Vector desc=new Vector();
	String color="NONE";
	Vector line_no=new Vector();
Vector field20=new Vector();
	//String line_no="";
	String query_init="SELECT  cast(descript as varchar(700)) as a1, line_no,field20 FROM CSQUOTES WHERE order_no = '"+order_no+"'  and line_no in("+sect_group_lines.elementAt(ye).toString()+") AND block_id NOT IN('E_DIM','E_DIM1', 'A_APRODUCT', 'C_MISC', 'D_MISC5','FACTORY') and block_id like'A_%' ORDER BY field20,cast(descript as varchar(700)),line_no, block_id, sequence_no";
	//out.println(query_init);
	ResultSet rsquotesinit=stmt.executeQuery(query_init);
	if(rsquotesinit != null){
		while(rsquotesinit.next()){
			desc.addElement(rsquotesinit.getString("a1"));
			line_no.addElement(rsquotesinit.getString("line_no"));
field20.addElement(rsquotesinit.getString("field20"));
		}
	}
	rsquotesinit.close();
	String tempHeader="";
String tempdesc2="";
	for(int i=0; i<desc.size(); i++){
		if(!field20.elementAt(i).toString().equals(tempHeader)){
                        if(i==0){
                            out.println("<BR><table width='100%' cellspacing='0' cellpadding='1' border='0'>");
 out.println("<tr><td "+bodyString+"><b>Section: "+(String)sect_group.elementAt(ye)+"</b></td></tr>");
                        }
                        else{
                            out.println("<tr><td>&nbsp;</td></tr>");
                        }
			out.println("<tr><td "+bodyString+"><b>"+desc.elementAt(i).toString()+"</b></td></tr>");
                        tempdesc2="";
		}
		ResultSet rscsquotes=stmt.executeQuery("select cast(descript as varchar(700)) as a1,block_id from csquotes where order_no='"+order_no+"' and line_no ='"+line_no.elementAt(i).toString()+"' AND block_id NOT IN('E_DIM','E_DIM1', 'A_APRODUCT', 'C_MISC', 'D_MISC5','FACTORY') and not block_id like 'a_%'  GROUP BY cast(descript as varchar(700)), line_no, block_id, sequence_no ORDER BY line_no, block_id, sequence_no");
		if(rscsquotes != null){
			while(rscsquotes.next()){
				String tempdesc=rscsquotes.getString("a1").trim();
				//+"::"+rscsquotes.getString("block_id")+"<br>";
				for(int rr=0; rr<tempdesc.length(); rr++){
                                        if((int)tempdesc.charAt(rr)==13){
                                                if(tempdesc2.indexOf(tempdesc.substring(0,rr))>=0){
                                                    tempdesc=tempdesc.substring(rr);
                                                }
                                                else{
                                                    tempdesc=tempdesc.substring(0,rr)+"<br>"+tempdesc.substring(rr);
                                                }
						rr=rr+4;
					}
else{
                                            if(tempdesc2.indexOf(tempdesc)>=0){
                                                    tempdesc="";
                                                }
                                        }
				}
				if(tempdesc.endsWith("<br>")){
                                    tempdesc=tempdesc.substring(0,tempdesc.length()-4);
				}
				if(tempdesc.length()>0){
                                    out.println("<tr><td "+bodyString+">"+tempdesc+"</td></tr>");
                                }
                                tempdesc2=tempdesc2+"<BR>"+tempdesc;
			}
		}
		rscsquotes.close();
		tempHeader=field20.elementAt(i).toString();
	}
        //out.println("<tr><td>&nbsp;</td></tr>");
/*
                Vector line_no_temp=new Vector();
                Vector description_temp=new Vector();
                Vector line_no=new Vector();
                Vector description=new Vector();
                String oldDescription="";
                ResultSet rs_csquotes = stmt.executeQuery(" select cast(descript as varchar(700)) as a1, line_no from csquotes where order_no='"+order_no+"' and line_no in("+sect_group_lines.elementAt(ye).toString()+") AND block_id NOT IN('E_DIM','E_DIM1', 'A_APRODUCT', 'C_MISC', 'D_MISC5','FACTORY') order by field20, line_no,block_id");
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
                            String tempdesc=temp1;
                            for(int rr=0; rr<tempdesc.length(); rr++){
                                    if((int)tempdesc.charAt(rr)==13){
                                            tempdesc=tempdesc.substring(0,rr)+"<br>"+tempdesc.substring(rr);
                                            rr=rr+4;
                                    }
                            }
                            description.addElement(tempdesc);
                            line_no.addElement(line_no_temp.elementAt(i).toString());
                    }
                }
                for(int c=0;c<line_no.size(); c++){
                    String qty="";
                    String mark="";
                    String edim="";
                    if((oldDescription.trim().length()==0 || !oldDescription.equals(description.elementAt(c).toString()))){
                            out.println("<BR>"+description.elementAt(c).toString()+"</p>");
                    }
                    oldDescription=description.elementAt(c).toString();

                }

*/
out.println("<tr><td>&nbsp;</td></tr></table>");
out.println("<table width='100%' cellspacing='0' cellpadding='1' border='0'>");
              //  out.println("<table width='100%' cellspacing='0' cellpadding='1' border='0'>");
                if(sect_notes.elementAt(ye).toString()!=null &&sect_notes.elementAt(ye).toString().trim().length()>0 && ! (sect_notes.elementAt(ye).toString().equals("null"))){
                    out.println("<tr height='20'>");
                    out.println("<td class='mainbodyh' colspan='5' align='left'>");out.println(sect_notes.elementAt(ye));	out.println("</td>");
                    out.println("</tr>");//free notes end
                }
                if(!(""+ye).equals(""+(sect_group.size()-1))){
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
                if(exclusions_free_text !=null && exclusions_free_text.trim().length()>0){
                     out.println("<tr><td colspan='6' class='mainbodyh'>"+exclusions_free_text+"</td></tr>");
                }
                if(free_text!=null && free_text.trim().length()>0){
                    out.println("<tr><td colspan='6'><font class='mainbodyh'>"+free_text+"</font></td></tr>");
                }
out.println("</table>");
                for1.setMaximumFractionDigits(0);for1.setMinimumFractionDigits(0);
                price=for1.format(totprice);

                grand_total1x=totprice;
                //out.println(totprice+"::"+grand_total1x);
                if(section_page==null||section_page.equals("1")){
                    if(group_id.startsWith("Decolink")){for1.setMinimumFractionDigits(2);}else{for1.setMaximumFractionDigits(0);}
                        price=for1.format(totprice);
                        if(sect_group.size()-ye>1){out.println("<p style='page-break-after : always;' >&nbsp;</p>");}
                        for1.setMaximumFractionDigits(2);
                }
                else{

                        if((""+ye).equals(""+(sect_group.size()-1))){
                                configuredPriceDB=""+sumX;
                                double tax_dollar=0;
                                grand_total=grand_total1x;
                                tax_dollar=(grand_total1x*Double.parseDouble(tax_perc))/100;
                                grand_total1x=grand_total1x+tax_dollar;
                                for1.setMaximumFractionDigits(0);
                                overage=""+overageX;
                                freight_cost=""+freightX;
                                handling_cost=""+handlingX;
                                setup_cost=""+setupX;
                        }
                        else{
                                double tax_dollar=0;
                                tax_dollar=(grand_total1x*Double.parseDouble(tax_perc))/100;
                                grand_total1x=grand_total1x+tax_dollar;
                                for1.setMaximumFractionDigits(0);
                            %>
                           <!-- </table>-->
                            <table class='<%= border_color %>' cellspacing='0' cellpadding='0' border='0' width='100%' height='25'><tr>
                            		<td class='tableline_row mainbody' width='50%' valign='middle'><b>Material Furnished Only </b></td>
                            <!--  GCP-498 -->
                            <td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Sub Total: <font class='totprice'><%=price%></font>&nbsp;<%=currencyName%></b></td>
                            </tr>
                            <tr>	
                            <td class='tableline_row mainbody' width='50%' valign='middle'><b> </b></td>
                            <td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Freight: <font class='totprice'><%=for1.format(0)%></font>&nbsp;<%=currencyName%></b></td>
                            </tr>
                            <tr>
                            <td class='tableline_row mainbody' width='50%' valign='middle'><b> </b></td>
                            <td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Tax: <font class='totprice'><%=for0.format(tax_dollar)%></font>&nbsp;<%=currencyName%></b></td>
                            </tr>
                            <tr>
                            <td class='tableline_row mainbody' width='50%' valign='middle'><b> </b></td>
                            <td class='tableline_row mainbody' width='50%' align='right' valign='middle' nowrap><b>Grand Total: <font class='totprice'><%=for1.format(grand_total1x)%></font>&nbsp;<%=currencyName%></b></td>
                            </tr>
                
                
                            									<%
         
                                     out.println("</table>");
                                  //  out.println("<BR><BR><BR>");
                            for1.setMaximumFractionDigits(2);
                            for1.setMinimumFractionDigits(2);
                    }
                }

                totprice=0;qual_sect=""; freightX=0;handlingX=0;overageX=0;setupX=0;sumX=0;

        }//for loop
//out.println(setup_cost+"::");

}// if sections are there













%>





