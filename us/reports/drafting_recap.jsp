<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<link rel='stylesheet' href='style1.css' type='text/css' />
<script language="JavaScript" >
function shownotes(a,b){
	//alert(a+"::"+b);
	var myurl="drafting_recap_notes.jsp?order_no="+a+"&line_no="+b;
	//alert(myurl);
	var newWindow;
	var props = 'scrollBars=yes,resizable=yes,toolbar=no,menubar=no,location=mo,directories=no,width=1100,height=450';
	newWindow = window.open(myurl, "Add_from_Src_to_Dest", props);
}
</script>
<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.math.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="../../db_con.jsp"%>
<%
DecimalFormat df2 = new DecimalFormat("####.##");
df2.setMaximumFractionDigits(2);
df2.setMinimumFractionDigits(2);
DecimalFormat df4 = new DecimalFormat("####.####");
df4.setMaximumFractionDigits(4);
//df4.setMinimumFractionDigits(4);
String ordernos=request.getParameter("ordernos");
String order_no="";
String bpcs_order_no="";
String project_name="";
String drawing_size="";
String creator_id="";
String product_id="";
Vector order_nos=new Vector();
Vector date=new Vector();
Vector quote_type=new Vector();
Vector quote_origin=new Vector();
Vector release_no=new Vector();
Vector model=new Vector();
Vector line_no=new Vector();
Vector lineprice=new Vector();
Vector totalprice=new Vector();
Vector totalcost=new Vector();
Vector overage=new Vector();
Vector setup_cost=new Vector();
Vector handling_cost=new Vector();
Vector freight_cost=new Vector();
Vector exclusions=new Vector();
Vector qualifying_notes=new Vector();
Vector free_text=new Vector();
Vector exclusions_free_text=new Vector();
Vector qualifying_notes_free_text=new Vector();
int columncount=0;
ResultSet rs0=stmt.executeQuery("select bpcs_order_no,project_name,drawing_size,creator_id,product_id,order_no from cs_project where order_no in ("+ordernos+") order by order_no desc");
if(rs0 != null){
	while(rs0.next()){
		if(rs0.getString("bpcs_order_no") != null){
			bpcs_order_no=rs0.getString("bpcs_order_no");
		}
		if(rs0.getString("project_name") != null){
			project_name=rs0.getString("project_name");
		}
		if(rs0.getString("drawing_size") != null){
			drawing_size=rs0.getString("drawing_size");
		}
		if(rs0.getString("creator_id") != null){
			creator_id=rs0.getString("creator_id");
		}
		if(rs0.getString("product_id") != null){
			product_id=rs0.getString("product_id");
		}
		order_no=rs0.getString("order_no");
	}
}
rs0.close();
ResultSet rs1=stmt.executeQuery("select order_no,quote_origin,created_on,quote_type_date,quote_type,overage,setup_cost,handling_cost,freight_cost,exclusions,qualifying_notes,free_text,exclusions_free_text, qualifying_notes_free_text from cs_project where order_no in ("+ordernos+") order by order_no");
if(rs1 != null){
	while(rs1.next()){
		order_nos.addElement(rs1.getString(1));
		quote_type.addElement(rs1.getString("quote_type"));
		if(rs1.getString(2) != null){
			quote_origin.addElement(rs1.getString(2));
		}
		else{
			quote_origin.addElement("");
		}
		if(rs1.getString(2) != null && rs1.getString(2).trim().equals("change") && rs1.getString("quote_type").equals("O") && rs1.getString(4)!=null && rs1.getString(4).trim().length()>0 && !rs1.getString(4).trim().equals("null")){
			date.addElement(rs1.getString(4).substring(0,10));
		}
		else{
			date.addElement(rs1.getString(3).substring(0,10));
		}
		if(rs1.getString("setup_cost") != null && rs1.getString("setup_cost").trim().length()>0){
			setup_cost.addElement(rs1.getString("setup_cost"));
		}
		else{
			setup_cost.addElement("0");
		}
		if(rs1.getString("overage") != null && rs1.getString("overage").trim().length()>0){
			overage.addElement(rs1.getString("overage"));
		}
		else{
			overage.addElement("0");
		}
		if(rs1.getString("handling_cost") != null && rs1.getString("handling_cost").trim().length()>0){
			handling_cost.addElement(rs1.getString("handling_cost"));
		}
		else{
			handling_cost.addElement("0");
		}
		if(rs1.getString("freight_cost") != null && rs1.getString("freight_cost").trim().length()>0){
			freight_cost.addElement(rs1.getString("freight_cost"));
		}
		else{
			freight_cost.addElement("0");
		}
		if(rs1.getString("exclusions") != null && rs1.getString("exclusions").trim().length()>0){
			exclusions.addElement(rs1.getString("exclusions"));
		}
		else{
			exclusions.addElement("");
		}
		if(rs1.getString("qualifying_notes") != null && rs1.getString("qualifying_notes").trim().length()>0){
			qualifying_notes.addElement(rs1.getString("qualifying_notes"));
		}
		else{
			qualifying_notes.addElement("");
		}
		if(rs1.getString("free_text") != null && rs1.getString("free_text").trim().length()>0){
			free_text.addElement(rs1.getString("free_text"));
		}
		else{
			free_text.addElement("");
		}
		if(rs1.getString("exclusions_free_text") != null && rs1.getString("exclusions_free_text").trim().length()>0){
			exclusions_free_text.addElement(rs1.getString("exclusions_free_text"));
		}
		else{
			exclusions_free_text.addElement("");
		}
		if(rs1.getString("qualifying_notes_free_text") != null && rs1.getString("qualifying_notes_free_text").trim().length()>0){
			qualifying_notes_free_text.addElement(rs1.getString("qualifying_notes_free_text"));
		}
		else{
			qualifying_notes_free_text.addElement("");
		}
	}
}
rs1.close();
out.println("<table width='100%' border='0'>");
out.println("<tr><td width='10%' bgcolor='#EFEFDE'>JOB NUMBER:</TD><TD WIDTH='90%'>"+bpcs_order_no+"&nbsp;</td></tr>");
out.println("<tr><td width='10%' bgcolor='#EFEFDE'>JOB NAME:</TD><TD WIDTH='90%'>"+project_name+"&nbsp;</td></tr>");
out.println("<tr><td width='10%' bgcolor='#EFEFDE'>&nbsp;</TD><TD WIDTH='90%'>&nbsp;</td></tr>");
out.println("<tr><td width='10%' bgcolor='#EFEFDE'>ERAPID NUMBER:</TD><TD WIDTH='90%'>"+order_no+"&nbsp;</td></tr>");
out.println("<tr><td width='10%' bgcolor='#EFEFDE'>&nbsp;</TD><TD WIDTH='90%'>&nbsp;</td></tr>");
out.println("<tr><td width='10%' bgcolor='#EFEFDE'>DWG SIZE:</TD><TD WIDTH='90%'>"+drawing_size+"&nbsp;</td></tr>");
out.println("<tr><td width='10%' bgcolor='#EFEFDE'>&nbsp;</TD><TD WIDTH='90%'>&nbsp;</td></tr>");
out.println("<tr><td width='10%' bgcolor='#EFEFDE'>ORDER REP:</TD><TD WIDTH='90%'>"+creator_id+"&nbsp;</td></tr>");
out.println("</table>");
out.println("<br>");
out.println("<table border='0' width='100%'>");
out.println("<tr>");
out.println("<td bgcolor='#EFEFDE'>#</td>");
out.println("<td bgcolor='#EFEFDE'>Model</td>");
out.println("<td bgcolor='#EFEFDE'>Bpcs Model</td>");
columncount=columncount+3;
for(int y=0; y<order_nos.size(); y++){
	if(y==0){
		out.println("<td bgcolor='#EFEFDE'>"+"as sold qty"+"</td>");
		out.println("<td bgcolor='#EFEFDE'>"+"as sold price"+"</td>");
		out.println("<td bgcolor='#EFEFDE'>"+"revised price"+"</td>");
		columncount=columncount+3;
	}
	else{
		String tempreleaseno="";
		if(quote_origin.elementAt(y)!=null && quote_origin.elementAt(y).toString().equals("release")){
			ResultSet rsreleaseno=stmt.executeQuery("select setup_cost from csquotes where order_no='"+order_nos.elementAt(y).toString()+"' ");
			if(rsreleaseno != null){
				while(rsreleaseno.next()){
					if(rsreleaseno.getString(1)!=null && rsreleaseno.getString(1).trim().length()>0){
						tempreleaseno=rsreleaseno.getString(1);
					}
				}
			}
			rsreleaseno.close();
		}
		if(tempreleaseno.trim().length()>0){
			tempreleaseno="&nbsp;&nbsp;"+tempreleaseno;
		}
		out.println("<td bgcolor='#EFEFDE'>"+date.elementAt(y).toString()+"<br>"+quote_type.elementAt(y).toString()+"<BR>"+quote_origin.elementAt(y).toString()+tempreleaseno+"<BR>"+order_nos.elementAt(y).toString()+"</td>");
		columncount++;
	}
	double tempprice=0;
	double tempcost=0;
	ResultSet rs2=stmt.executeQuery("select extended_price,deduct,std_cost,bpcs_qty from csquotes where order_no='"+order_nos.elementAt(y).toString()+"' and not field18='' and not bpcs_qty='0' and not bpcs_part_no='' and not block_id ='a_aproduct' order by order_no");
	if(rs2 != null){
		while(rs2.next()){
			//out.println(rs2.getString("bpcs_qty")+"::<BR>");
			if(rs2.getString("deduct") != null && rs2.getString("deduct") .equals("deduct")){
				tempprice=tempprice-new Double(rs2.getString("extended_price")).doubleValue();
				tempcost=tempcost-(new Double(rs2.getString("std_cost")).doubleValue()*new Double(rs2.getString("bpcs_qty")).doubleValue());
			}
			else{
				tempprice=tempprice+new Double(rs2.getString("extended_price")).doubleValue();
				tempcost=tempcost+(new Double(rs2.getString("std_cost")).doubleValue()*new Double(rs2.getString("bpcs_qty")).doubleValue());
			}
		}
	}
	lineprice.addElement(""+tempprice);
	double temptotalprice=new Double(lineprice.elementAt(y).toString()).doubleValue()+new Double(overage.elementAt(y).toString()).doubleValue()+new Double(setup_cost.elementAt(y).toString()).doubleValue()+new Double(handling_cost.elementAt(y).toString()).doubleValue()+new Double(freight_cost.elementAt(y).toString()).doubleValue();
	totalprice.addElement(""+temptotalprice);
	totalcost.addElement(""+tempcost);
}
out.println("<td bgcolor='#EFEFDE'>final qty</td><td bgcolor='#EFEFDE'>Release</td><td bgcolor='#EFEFDE'>Remaining</td><td bgcolor='#EFEFDE'>Open C/O</td>");
columncount=columncount+4;
out.println("</tr>");
ResultSet rs2=stmt.executeQuery("select field18,line_no from csquotes where order_no in ("+ordernos+") and not field18 ='' order by cast(line_no as numeric),field18");
if(rs2 != null){
	while(rs2.next()){
		//out.println(rs2.getString("field18")+"::"+rs2.getString("line_no")+"::<BR>");
		boolean ismatch=false;
		for(int i=0; i<model.size(); i++){
			if(model.elementAt(i).toString().equals(rs2.getString("field18")) && line_no.elementAt(i).toString().equals(rs2.getString("line_no"))){
				ismatch=true;
				i=model.size();
			}
		}
		if(!ismatch){
			model.addElement(rs2.getString("field18"));
			line_no.addElement(rs2.getString("line_no"));
		}
	}
}
rs2.close();
Vector order_nox[]=new Vector[line_no.size()];
Vector line_nox[]=new Vector[line_no.size()];
Vector qty[]=new Vector[line_no.size()];
Vector bpcs_part_no[]=new Vector[line_no.size()];
Vector modelx[]=new Vector[line_no.size()];
Vector deduct[]=new Vector[line_no.size()];
Vector price[]=new Vector[line_no.size()];
Vector isdisplayed[]=new Vector[line_no.size()];
Vector cost[]=new Vector[line_no.size()];
Vector complete[]=new Vector[line_no.size()];
int counter[] = new int[line_no.size()];
int noRecs[] = new int[line_no.size()];
for(int i=0; i<line_no.size(); i++){
	order_nox[i]=new Vector();
	line_nox[i]=new Vector();
	qty[i]=new Vector();
	bpcs_part_no[i]=new Vector();
	modelx[i]=new Vector();
	deduct[i]=new Vector();
	price[i]=new Vector();
	isdisplayed[i]=new Vector();
	cost[i]=new Vector();
	complete[i]=new Vector();
}
for(int i=0; i<line_no.size(); i++){
	ResultSet rs3=stmt.executeQuery("select bpcs_qty,bpcs_part_no, field18, line_no,deduct,extended_price,order_no,std_cost,complete from csquotes where order_no in ("+ordernos+") and field18='"+model.elementAt(i).toString()+"' and line_no='"+line_no.elementAt(i).toString()+"' and not field18='' and not bpcs_part_no='' and not block_id ='a_aproduct' order by cast(line_no as numeric), field18,order_no,bpcs_part_no");
	if(rs3 != null){
		while(rs3.next()){
			order_nox[i].addElement(rs3.getString("order_no"));
			price[i].addElement(rs3.getString("extended_price"));
			if(rs3.getString("deduct")!= null){
				deduct[i].addElement(rs3.getString("deduct"));
			}
			else{
				deduct[i].addElement("");
			}
			line_nox[i].addElement(rs3.getString("line_no"));
			modelx[i].addElement(rs3.getString("field18"));
			bpcs_part_no[i].addElement(rs3.getString("bpcs_part_no"));
			qty[i].addElement(rs3.getString("bpcs_qty"));
			cost[i].addElement(rs3.getString("std_cost"));
			if(rs3.getString("complete")!= null){
				//out.println(rs3.getString("complete")+"HEre"+rs3.getString("bpcs_part_no")+"::"+rs3.getString("bpcs_qty")+"::<BR>");
				complete[i].addElement(rs3.getString("complete"));
			}
			else{
				complete[i].addElement("");
			}
			isdisplayed[i].addElement("");
			//out.println(rs3.getString("complete")+":<BR>");
			//out.println(rs3.getString("order_no")+"::"+rs3.getString("line_no")+"::"+rs3.getString("deduct")+"::<BR>");
		}
	}
	rs3.next();
}
String row1="";
String row2="";
String bgcolor="white";
double finalprice=0;
double releaseprice=0;
double releasepricetotal=0;
double remainingprice=0;
double openCOprice=0;
double closedCOprice=0;
double finaloverage=0;
double releaseoverage=0;
double remainingoverage=0;
double opencooverage=0;
double finalsetup=0;
double releasesetup=0;
double remainingsetup=0;
double opencosetup=0;
double finalhandling=0;
double releasehandling=0;
double remaininghandling=0;
double opencohandling=0;
double finalfreight=0;
double releasefreight=0;
double remainingfreight=0;
double opencofreight=0;
double finaltotal=0;
double releasetotal=0;
double remainingtotal=0;
double opencototal=0;
double finalcost=0;
double releasecost=0;
double remainingcost=0;
double opencocost=0;
double finalmargin=0;
double releasemargin=0;
double remainingmargin=0;
double opencomargin=0;

for(int i=0; i<line_no.size(); i++){
	if(i%2==0){
		bgcolor="white";
	}
	else{
		bgcolor="#e0e0e0";
	}
	int columnnum=4+order_nos.size();
	String sellqty="";
	double finalqty=0;
	double release=0;
	double remaining=0;
	double openCO=0;
	double closedCO=0;





















	String row="";
	String revisedprice="";
	row1=row1+"<tr><td bgcolor='"+bgcolor+"'><font color='blue' >"+line_no.elementAt(i).toString()+"</td><td align='left' bgcolor='"+bgcolor+"'><font color='blue'>"+model.elementAt(i).toString()+"</td>";
	//out.println(ordernos);
	//ResultSet rsNoteCount=stmt.executeQuery("select count(*) from csquotes where order_no in ("+ordernos+") and line_no='"+line_no.elementAt(i).toString()+"' and block_id='d_notes' ");
	//if(rsNoteCount!=null){
	//	while(rsNoteCount.next()){
			//if( rsNoteCount.getInt(1)>0){
				row1=row1+"<td bgcolor='"+bgcolor+"'><input type='button' name='notes' value='notes' onclick=shownotes('"+ordernos.replaceAll("'","")+"','"+line_no.elementAt(i).toString()+"')></td>";
			//}
			//else{
			//	row1=row1+"<td bgcolor='"+bgcolor+"'><input type='button' name='notes' value='notes' onclick=shownotes('"+ordernos.replaceAll("'","")+"','"+line_no.elementAt(i).toString()+"')></td>";
			//}
	//	}
	//}
	//rsNoteCount.close();
	for(int y=0; y<order_nox[i].size(); y++){

		if(y==0 ){
			if(order_nox[i].elementAt(y).toString().equals(order_no)){

			//out.println(order_nox[i].elementAt(y).toString()+"::"+qty[i].elementAt(y).toString()+"::"+cost[i].elementAt(y).toString()+"::<BR>");
				if(!complete[i].elementAt(y).toString().equals("Y")){
					row1=row1+"<td align='right' bgcolor='"+bgcolor+"'><font color='blue'>"+qty[i].elementAt(y).toString()+"</td>";
				}
				else{
					row1=row1+"<td align='right' bgcolor='"+bgcolor+"'><font color='blue'>"+qty[i].elementAt(y).toString()+" Complete</td>";
				}
				row1=row1+"<td align='right' bgcolor='"+bgcolor+"'><font color='blue'>"+price[i].elementAt(y).toString()+"</td>";
				row1=row1+"<td align='right' bgcolor='"+bgcolor+"'><font color='blue'>#revisedprice#</td>";
				for(int j=1; j<order_nos.size();j++){
					row1=row1+"<td bgcolor='"+bgcolor+"'>&nbsp;</td>";
				}
			}
			else{
				row1=row1+"<td bgcolor='"+bgcolor+"'>&nbsp;</td>";
				row1=row1+"<td bgcolor='"+bgcolor+"'>&nbsp;</td>";
				//row1=row1+"<td bgcolor='"+bgcolor+"'>&nbsp;</td>";
				row1=row1+"<td align='right' bgcolor='"+bgcolor+"'><font color='blue'>#revisedprice#</td>";
				for(int j=1; j<order_nos.size();j++){
					row1=row1+"<td bgcolor='"+bgcolor+"'>&nbsp;</td>";
				}
			}

		}
		String temporigin="";
		for(int v=0; v<order_nos.size(); v++){
			if(order_nos.elementAt(v).toString().equals(order_nox[i].elementAt(y).toString())){
				if(quote_origin.elementAt(v)!=null && quote_origin.elementAt(v).toString().trim().equals("release")){
					release=release+new Double(qty[i].elementAt(y).toString()).doubleValue();
					//releaseprice=new Double(price[i].elementAt(y).toString()).doubleValue();
				}
				if(quote_origin.elementAt(v)!=null &&quote_origin.elementAt(v).toString().trim().equals("change")&&quote_type.elementAt(v).toString().toUpperCase().equals("Q")){
					if(deduct[i].elementAt(y).toString() != null && deduct[i].elementAt(y).toString().equals("deduct")){
						openCO=openCO-new Double(qty[i].elementAt(y).toString()).doubleValue();
						//openCOprice=openCOprice-new Double(price[i].elementAt(y).toString()).doubleValue();
					}
					else{
						openCO=openCO+new Double(qty[i].elementAt(y).toString()).doubleValue();
						//openCOprice=openCOprice+new Double(price[i].elementAt(y).toString()).doubleValue();
					}
				}
				if(quote_origin.elementAt(v)!=null &&quote_origin.elementAt(v).toString().trim().equals("change")&&quote_type.elementAt(v).toString().toUpperCase().equals("O")){
					if(deduct[i].elementAt(y).toString() != null && deduct[i].elementAt(y).toString().equals("deduct")){
						closedCO=closedCO-new Double(qty[i].elementAt(y).toString()).doubleValue();
						//closedCOprice=closedCOprice-new Double(price[i].elementAt(y).toString()).doubleValue();
					}
					else{
						closedCO=closedCO+new Double(qty[i].elementAt(y).toString()).doubleValue();
						//closedCOprice=closedCOprice+new Double(price[i].elementAt(y).toString()).doubleValue();

					}
				}

				if(order_nos.elementAt(v).toString().equals(order_no)){
					//finalprice=finalprice+new Double(price[i].elementAt(y).toString()).doubleValue();
					//out.println(price[i].elementAt(y).toString()+"::<BR>");
				}
				if(quote_origin.elementAt(v)!=null && (quote_origin.elementAt(v).toString().trim().equals("revision")||quote_origin.elementAt(v).toString().trim().equals("submittal"))){
					finalqty=new Double(qty[i].elementAt(y).toString()).doubleValue();

				}
				revisedprice=price[i].elementAt(y).toString();


			}

		}
		if(!isdisplayed[i].elementAt(y).equals("y")){
			String completed="";
			row2=row2+"<tr><td bgcolor='"+bgcolor+"'>&nbsp;</td><td bgcolor='"+bgcolor+"'>&nbsp;</td><td bgcolor='"+bgcolor+"'>"+bpcs_part_no[i].elementAt(y).toString()+"</td>";
			if(order_nox[i].elementAt(y).toString().equals(order_no)){
				if(y==0){
					if(!complete[i].elementAt(y).toString().equals("Y")){
						row2=row2+"<td align='right' bgcolor='"+bgcolor+"'>"+qty[i].elementAt(y).toString()+"</td>";
					}
					else{
						completed="Complete";
						row2=row2+"<td align='right' bgcolor='"+bgcolor+"'>"+qty[i].elementAt(y).toString()+"</td>";
					}
					row2=row2+"<td align='right' bgcolor='"+bgcolor+"'>&nbsp;</td>";
					row2=row2+"<td bgcolor='"+bgcolor+"'>&nbsp;</td>";
					isdisplayed[i].setElementAt("y",y);
				}
				else{
					row2=row2+"<td bgcolor='"+bgcolor+"'>&nbsp;</td>";
					row2=row2+"<td bgcolor='"+bgcolor+"'>&nbsp;</td>";
					row2=row2+"<td align='right' bgcolor='"+bgcolor+"'>&nbsp;</td>";
					isdisplayed[i].setElementAt("y",y);
				}
			}
			else{
					row2=row2+"<td bgcolor='"+bgcolor+"'>&nbsp;</td>";
					row2=row2+"<td bgcolor='"+bgcolor+"'>&nbsp;</td>";
					row2=row2+"<td align='right' bgcolor='"+bgcolor+"'>&nbsp;</td>";
					isdisplayed[i].setElementAt("y",y);
			}
			int lastcolumn=0;
			for(int v=0; v<order_nos.size(); v++){
				if(!order_nos.elementAt(v).toString().endsWith("_00")&&!order_nox[i].elementAt(y).toString().endsWith("_00")){
					if(order_nos.elementAt(v).toString().equals(order_nox[i].elementAt(y).toString())){
						if(!complete[i].elementAt(y).toString().equals("Y")){
							if(deduct[i].elementAt(y).toString() != null && deduct[i].elementAt(y).toString().equals("deduct")){
								row2=row2+"<td align='right' bgcolor='"+bgcolor+"'>-"+qty[i].elementAt(y).toString()+"</td>";
							}
							else{
								row2=row2+"<td align='right' bgcolor='"+bgcolor+"'>"+qty[i].elementAt(y).toString()+"</td>";
							}
						}
						else{
							completed="Complete";
							if(deduct[i].elementAt(y).toString() != null && deduct[i].elementAt(y).toString().equals("deduct")){
								row2=row2+"<td align='right' bgcolor='"+bgcolor+"'>-"+qty[i].elementAt(y).toString()+"</td>";
							}
							else{
								row2=row2+"<td align='right' bgcolor='"+bgcolor+"'>"+qty[i].elementAt(y).toString()+"</td>";
							}
						}
						lastcolumn=v;
						v=order_nos.size();
					}
					else{
						row2=row2+"<td bgcolor='"+bgcolor+"'>&nbsp;</td>";
					}
				}
			}

			String tempbpcs=bpcs_part_no[i].elementAt(y).toString();
			for(int e=0; e<order_nox[i].size(); e++){
				if(!isdisplayed[i].elementAt(e).equals("y")&&line_nox[i].elementAt(e).toString().equals(line_no.elementAt(i).toString())&&modelx[i].elementAt(e).toString().equals(model.elementAt(i).toString())&&bpcs_part_no[i].elementAt(e).toString().equals(tempbpcs)){
					for(int v=lastcolumn+1; v<order_nos.size(); v++){
						if(order_nos.elementAt(v).toString().equals(order_nox[i].elementAt(e).toString())){
							if(!complete[i].elementAt(e).toString().equals("Y")){
								if(deduct[i].elementAt(e).toString() != null && deduct[i].elementAt(e).toString().equals("deduct")){
									row2=row2+"<td align='right' bgcolor='"+bgcolor+"'>-"+qty[i].elementAt(e).toString()+"</td>";
								}
								else{
									row2=row2+"<td align='right' bgcolor='"+bgcolor+"'>"+qty[i].elementAt(e).toString()+"</td>";
								}
							}
							else{
								completed="Complete";
								if(deduct[i].elementAt(e).toString() != null && deduct[i].elementAt(e).toString().equals("deduct")){
									row2=row2+"<td align='right' bgcolor='"+bgcolor+"'>-"+qty[i].elementAt(e).toString()+"</td>";
								}
								else{
									row2=row2+"<td align='right' bgcolor='"+bgcolor+"'>"+qty[i].elementAt(e).toString()+"</td>";
								}

							}
							lastcolumn++;
							v=order_nos.size();
							isdisplayed[i].setElementAt("y",e);
						}
						else{
							boolean ismatchorder=false;
							for(int z=0; z<order_nox[i].size(); z++){
								if(order_nox[i].elementAt(z).toString().equals(order_nos.elementAt(v).toString())){
									ismatchorder=true;
								}
							}
							if(!ismatchorder||Integer.parseInt(order_nox[i].elementAt(e).toString().substring(7))<Integer.parseInt(order_nos.elementAt(v).toString().substring(7))){
								row2=row2+"<td bgcolor='"+bgcolor+"'>&nbsp;</td>";
								lastcolumn++;
							}
						}
					}
				}
			}
			while(lastcolumn<order_nos.size()){
				row2=row2+"<td bgcolor='"+bgcolor+"'>&nbsp;</td>";
				lastcolumn++;
			}
			row2=row2+"<td bgcolor='"+bgcolor+"'>&nbsp;</td><td align='right' bgcolor='"+bgcolor+"'>&nbsp;"+completed+"</td><td bgcolor='"+bgcolor+"'>&nbsp;</td></tr>";
		}
	}
	row1=row1.replaceAll("#revisedprice#",revisedprice);
	//out.println(finalqty+"::"+closedCO+"<BR><BR>");
	finalqty=finalqty+closedCO;


	//for(int




	//out.println(finalqty+"::"+release+":::"+releaseprice);
	releasepricetotal=releasepricetotal+releaseprice*(release/finalqty);





	remaining=finalqty-release;
	row1=row1+"<td align='right' bgcolor='"+bgcolor+"'><font color='blue'>"+finalqty+"</td>";
	row1=row1+"<td align='right' bgcolor='"+bgcolor+"'><font color='blue'>"+release+"</td>";
	if(remaining>-.01&&remaining<.01){
		remaining=0;
	}
	if(remaining>=0){
		row1=row1+"<td align='right' bgcolor='"+bgcolor+"'><font color='blue'>"+df4.format(remaining)+"</td>";
	}
	else{
		row1=row1+"<td align='right' bgcolor='"+bgcolor+"'><font color='red'>"+df4.format(remaining)+"</td>";
	}
	row1=row1+"<td align='right' bgcolor='"+bgcolor+"'><font color='blue'>"+openCO+"</td>";
	row1=row1+"</tr>";
	out.println(row1+row2);
	out.println("<tr><td colspan='"+columncount+"'><hr></td></tr>");
	row1="";
	row2="";

}
String linetotalrow="<tr><td colspan='4' bgcolor='#EFEFDE'>Subtotal</td>";
String overagetotalrow="<tr><td colspan='4' bgcolor='#EFEFDE'>Overage</td>";
String setuptotalrow="<tr><td colspan='4' bgcolor='#EFEFDE'>Setup</td>";
String handlingtotalrow="<tr><td colspan='4' bgcolor='#EFEFDE'>Handling</td>";
String freighttotalrow="<tr><td colspan='4' bgcolor='#EFEFDE'>Freight</td>";
String totalrow="<tr><td colspan='4' bgcolor='#EFEFDE'>Total</td>";
String totalcostx="<tr><td colspan='4' bgcolor='#EFEFDE'>Total Cost</td>";
String marginperc="<tr><td colspan='4' bgcolor='#EFEFDE'>Margin Percentage</td>";

String notes="<table border='0' width='100%'><tr><td colspan='2' bgcolor='#EFEFDE'>NOTES:</td></tr>";
for(int y=0; y<order_nos.size(); y++){
	String temprow="";
	boolean hasnotes=false;
	temprow=temprow+"<tr><td width='15%' valign='top' bgcolor='#EFEFDE'>"+order_nos.elementAt(y).toString();
	if(quote_origin.elementAt(y) != null && quote_origin.elementAt(y).toString().trim().length()>0){
		temprow=temprow+"::"+quote_origin.elementAt(y).toString()+"</td><td>";
	}
	else{
		temprow=temprow+"</td><td width='85%'>";
	}
	if(y==0){
		if(exclusions.elementAt(y) != null && exclusions.elementAt(y).toString().trim().length()>0){
			ResultSet rs4= stmt.executeQuery("select description FROM cs_exc_notes where product_id='"+product_id+"' and code in ("+exclusions.elementAt(y).toString()+") order by code ");
			if(rs4 != null){
				while(rs4.next()){
					temprow=temprow+rs4.getString("description")+"<BR>";
					//exclusions.elementAt(y).toString()+"<br>";
				}
			}
			rs4.close();
			hasnotes=true;
		}
		if(qualifying_notes.elementAt(y) != null && qualifying_notes.elementAt(y).toString().trim().length()>0){
			ResultSet rs5= stmt.executeQuery("select description FROM cs_qlf_notes where product_id like '"+product_id+"' and code in ("+qualifying_notes.elementAt(y).toString()+") order by code ");
			if(rs5 != null){
				while(rs5.next()){
					temprow=temprow+rs5.getString("description")+"<BR>";
				}
			}
			rs5.close();
			hasnotes=true;
		}
		if(exclusions_free_text.elementAt(y) != null && exclusions_free_text.elementAt(y).toString().trim().length()>0){
			temprow=temprow+exclusions_free_text.elementAt(y).toString()+"<br>";
			hasnotes=true;
		}
		if(qualifying_notes_free_text.elementAt(y) != null && qualifying_notes_free_text.elementAt(y).toString().trim().length()>0){
			temprow=temprow+qualifying_notes_free_text.elementAt(y).toString()+"<br>";
			hasnotes=true;
		}
	}
	if(free_text.elementAt(y) != null && free_text.elementAt(y).toString().trim().length()>0){
		temprow=temprow+free_text.elementAt(y).toString()+"<br>";
		hasnotes=true;
	}
	temprow=temprow+"</td></tr>";
	if(hasnotes){
		notes=notes+temprow;
	}

	double tempgm=0;
	if(new Double(totalprice.elementAt(y).toString()).doubleValue()!=0){
		tempgm=((new Double(totalprice.elementAt(y).toString()).doubleValue()-new Double(totalcost.elementAt(y).toString()).doubleValue())/new Double(totalprice.elementAt(y).toString()).doubleValue())*100;
	}

	linetotalrow=linetotalrow+"<td align='right'>"+df2.format(new Double(lineprice.elementAt(y).toString()).doubleValue())+"</td>";



	if(quote_origin.elementAt(y).toString().trim().length()==0 || quote_origin.elementAt(y).toString().equals("submittal")){
		finalprice=new Double(lineprice.elementAt(y).toString()).doubleValue();
		finaloverage=new Double(overage.elementAt(y).toString()).doubleValue();
		finalsetup=new Double(setup_cost.elementAt(y).toString()).doubleValue();
		finalhandling=new Double(handling_cost.elementAt(y).toString()).doubleValue();
		finalfreight=new Double(freight_cost.elementAt(y).toString()).doubleValue();
		finalcost=new Double(totalcost.elementAt(y).toString()).doubleValue();
	}
	else if(quote_origin.elementAt(y).toString().equals("change")){
		if(	quote_type.elementAt(y).toString().toUpperCase().equals("O")){
			finalprice=finalprice+new Double(lineprice.elementAt(y).toString()).doubleValue();
			finaloverage=finaloverage+new Double(overage.elementAt(y).toString()).doubleValue();
			finalsetup=finalsetup+new Double(setup_cost.elementAt(y).toString()).doubleValue();
			finalhandling=finalhandling+new Double(handling_cost.elementAt(y).toString()).doubleValue();
			finalfreight=finalfreight+new Double(freight_cost.elementAt(y).toString()).doubleValue();
			finalcost=finalcost+new Double(totalcost.elementAt(y).toString()).doubleValue();



		}
		else{
			openCOprice=openCOprice+new Double(lineprice.elementAt(y).toString()).doubleValue();
			opencooverage=opencooverage+new Double(overage.elementAt(y).toString()).doubleValue();
			opencosetup=opencosetup+new Double(setup_cost.elementAt(y).toString()).doubleValue();
			opencohandling=opencohandling+new Double(handling_cost.elementAt(y).toString()).doubleValue();
			opencofreight=opencofreight+new Double(freight_cost.elementAt(y).toString()).doubleValue();
			opencocost=opencocost+new Double(totalcost.elementAt(y).toString()).doubleValue();
		}
	}
	else if(quote_origin.elementAt(y).toString().equals("release")){
		releasepricetotal=releasepricetotal+new Double(lineprice.elementAt(y).toString()).doubleValue();
		releaseoverage=releaseprice+new Double(overage.elementAt(y).toString()).doubleValue();
		releasesetup=releasesetup+new Double(setup_cost.elementAt(y).toString()).doubleValue();
		releasehandling=releasehandling+new Double(handling_cost.elementAt(y).toString()).doubleValue();
		releasefreight=releasefreight+new Double(freight_cost.elementAt(y).toString()).doubleValue();
		releasecost=releasecost+new Double(totalcost.elementAt(y).toString()).doubleValue();
	}







	overagetotalrow=overagetotalrow+"<td align='right'>"+overage.elementAt(y).toString()+"</td>";
	setuptotalrow=setuptotalrow+"<td align='right'>"+setup_cost.elementAt(y).toString()+"</td>";
	handlingtotalrow=handlingtotalrow+"<td align='right'>"+handling_cost.elementAt(y).toString()+"</td>";
	freighttotalrow=freighttotalrow+"<td align='right'>"+freight_cost.elementAt(y).toString()+"</td>";
	totalrow=totalrow+"<td align='right'>"+df2.format(new Double(totalprice.elementAt(y).toString()).doubleValue())+"</td>";
	totalcostx=totalcostx+"<td align='right'>"+df2.format(new Double(totalcost.elementAt(y).toString()).doubleValue())+"</td>";
	marginperc=marginperc+"<td align='right'>"+df2.format(tempgm)+"</td>";
	if(y==0){
		linetotalrow=linetotalrow+"<td>&nbsp;</td>";
		overagetotalrow=overagetotalrow+"<td>&nbsp;</td>";
		setuptotalrow=setuptotalrow+"<td>&nbsp;</td>";
		handlingtotalrow=handlingtotalrow+"<td>&nbsp;</td>";
		freighttotalrow=freighttotalrow+"<td>&nbsp;</td>";
		totalrow=totalrow+"<td>&nbsp;</td>";
		totalcostx=totalcostx+"<td>&nbsp;</td>";
		marginperc=marginperc+"<td>&nbsp;</td>";
	}
}

remainingtotal=remainingsetup+remaininghandling+remainingoverage+remainingfreight+remainingprice;
opencototal=opencosetup+opencohandling+opencooverage+opencofreight+openCOprice;
finaltotal=finalsetup+finalhandling+finaloverage+finalfreight+finalprice;
releasetotal=finaltotal-remainingtotal;

remainingprice=finalprice-releasepricetotal;
remainingsetup=finalsetup-releasesetup;
remainingoverage=finaloverage-releaseoverage;
remaininghandling=finalhandling-releasehandling;
remainingfreight=finalfreight-releasefreight;
remainingcost=finalcost-releasecost;



if(finalprice>0){
	finalmargin=((finalprice-finalcost)/finalprice)*100;
}
if(remainingprice>0){
	remainingmargin=((remainingprice-remainingcost)/remainingprice)*100;
}
if(releaseprice>0){
	releasemargin=((releaseprice-releasecost)/releaseprice)*100;
}
if(openCOprice>0){
	opencomargin=((openCOprice-opencocost)/openCOprice)*100;
}




out.println(linetotalrow+"<td align='right'>"+df2.format(finalprice)+"</td><td align='right'>"+df2.format(releasepricetotal)+"</td><td align='right'>"+df2.format(remainingprice)+"</td><td align='right'>"+df2.format(openCOprice)+"</td></tr>");
out.println(overagetotalrow+"<td align='right'>"+df2.format(finaloverage)+"</td><td align='right'>"+df2.format(releaseoverage)+"</td><td align='right'>"+df2.format(remainingoverage)+"</td><td align='right'>"+df2.format(opencooverage)+"</td></tr>");
out.println(setuptotalrow+"<td align='right'>"+df2.format(finalsetup)+"</td><td align='right'>"+df2.format(releasesetup)+"</td><td align='right'>"+df2.format(remainingsetup)+"</td><td align='right'>"+df2.format(opencosetup)+"</td></tr>");
out.println(handlingtotalrow+"<td align='right'>"+df2.format(finalhandling)+"</td><td align='right'>"+df2.format(releasehandling)+"</td><td align='right'>"+df2.format(remaininghandling)+"</td><td align='right'>"+df2.format(opencohandling)+"</td></tr>");
out.println(freighttotalrow+"<td align='right'>"+df2.format(finalfreight)+"</td><td align='right'>"+df2.format(releasefreight)+"</td><td align='right'>"+df2.format(remainingfreight)+"</td><td align='right'>"+df2.format(opencofreight)+"</td></tr>");
out.println(totalrow+"<td align='right'>"+df2.format(finaltotal)+"</td><td align='right'>"+df2.format(releasetotal)+"</td><td align='right'>"+df2.format(remainingtotal)+"</td><td align='right'>"+df2.format(opencototal)+"</td></tr>");
out.println(totalcostx+"<td align='right'>"+df2.format(finalcost)+"</td><td align='right'>"+df2.format(releasecost)+"</td><td align='right'>"+df2.format(remainingcost)+"</td><td align='right'>"+df2.format(opencocost)+"</td></tr>");
out.println(marginperc+"<td align='right'>"+df2.format(finalmargin)+"</td><td align='right'>"+df2.format(releasemargin)+"</td><td align='right'>"+df2.format(remainingmargin)+"</td><td align='right'>"+df2.format(opencomargin)+"</td></tr>");
out.println("</table>");
out.println(notes+"</table>");
stmt.close();
myConn.close();
}
catch(Exception e){
out.println(e);
}
%>