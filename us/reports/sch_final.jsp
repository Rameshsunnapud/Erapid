<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
	<head>
		<title>SCHEDULE OF VALUES:Quote no# <%= request.getParameter("choice") %> </title>
		<link rel='stylesheet' href='time.css' type='text/css' />
		<SCRIPT language="JavaScript">
			<!--
		function n_window(theurl)
			{
				// set width and height
				var the_width=750;
				var the_height=400;
				// set window position
				var from_top=70;
				var from_left=100;
				// set other attributes
				var has_toolbar='no';
				var has_location='no';
				var has_directories='no';
				var has_status='yes';
				var has_menubar='yes';
				var has_scrollbars='yes';
				var is_resizable='yes';
				// atrributes put together
				var the_atts='width='+the_width+',height='+the_height+',top='+from_top+',screenY='+from_top+',left='+from_left+',screenX='+from_left;
				the_atts+=',toolbar='+has_toolbar+',location='+has_location+',directories='+has_directories+',status='+has_status;
				the_atts+=',menubar='+has_menubar+',scrollbars='+has_scrollbars+',resizable='+is_resizable;
				// open the window
				window.open(theurl,'',the_atts);
			}
			//-->
		</SCRIPT>

	</head>
	<body>

		<%@ page language="java" import="java.sql.*" import="java.math.*" import="java.text.*" import="java.util.*" errorPage="error.jsp" %>
		<%@ include file="../../db_con.jsp"%>
		<%
		double greg=0;
		double numSec=0;
		String onumber = request.getParameter("choice");
		myConn.setAutoCommit(false);
		Vector std_cost=new Vector();
		Vector run_cost=new Vector();
		Vector setup_cost=new Vector();
		Vector qty=new Vector();
		Vector mark=new Vector();
		Vector model=new Vector();
		Vector items=new Vector();
		Vector sqft=new Vector();

		Vector modelWeight=new Vector();

		//
		String[] order1=new String[555];
		String[] order2=new String[555];
		String[] order3=new String[555];
		String[] order4=new String[555];

		 NumberFormat for1 = NumberFormat.getCurrencyInstance();
			 for1.setMaximumFractionDigits(0);

		// counter values
		int rows_c=0;int rows=0;int rows_a=0;int rows_m=0;

		//LINE LEVEL VARIBALES
		float sp=0;float tcg=0;double catchall=0.0;

		// totals
		double total_lvr_value=0.0;String bgcolor="";

		// Getting the CS_COSTING data like run cost, setup cost, std cost
		java.sql.ResultSet myResult2=stmt.executeQuery("select * from CS_COSTING where order_no= '"+onumber+"' order by cast(item_no as integer),subline_no " );
		if (myResult2 !=null){
		while (myResult2.next()){
		items.addElement(myResult2.getString("item_no"));
		std_cost.addElement(myResult2.getString("std_cost"));
		run_cost.addElement(myResult2.getString("run_cost"));
		setup_cost.addElement(myResult2.getString("setup_cost"));
		qty.addElement(myResult2.getString("qty"));
		mark.addElement(myResult2.getString("mark"));
		model.addElement(myResult2.getString("model"));
		sqft.addElement(myResult2.getString("sqft"));
		modelWeight.addElement(myResult2.getString("weight"));
		//out.print("std "+std_cost.elementAt(rows_c)+"run "+run_cost.elementAt(rows_c)+"setup "+setup_cost.elementAt(rows_c)+"<br>");
		rows_c++;
		  }
		}
		String[] isUsed=new String[rows_c];
		for(int a=0; a<rows_c; a++){
			isUsed[a]="";
		}
		ResultSet rsNumSec=stmt.executeQuery("select count(*) from doc_line where doc_number='"+onumber+"'");
		if(rsNumSec != null){
			while(rsNumSec.next()){
				numSec=rsNumSec.getInt(1);
			}
		}
		myResult2.close();
		rsNumSec.close();
		//out.println("number of sections"+numSec);

		java.sql.ResultSet myResult=stmt.executeQuery("select * from doc_line where doc_number= '"+onumber+"' order by cast(doc_line as integer)" );
		if (myResult !=null){
		while (myResult.next()){
		order1[rows] = myResult.getString("config_string");
		order2[rows] = myResult.getString("doc_line");
		rows++;
						  }
						}
		myResult.close();
		// Getting the total lines for each
		java.sql.ResultSet myResult1=stmt.executeQuery("select item_no,sum(qty) from cs_costing where order_no= '"+onumber+"' group by item_no order by cast(item_no as integer)" );
		if (myResult1 !=null){
		while (myResult1.next()){
		order3[rows_a] = myResult1.getString(1);
		order4[rows_a] = myResult1.getString(2);
		//out.println(order4[rows_a]+"::HERE<BR>");
		rows_a++;
						  }
						}
						myResult1.close();
						sp=0;
						tcg=0;
						catchall=0;
		ResultSet rsAc = stmt.executeQuery("select pinfsellprice, pinfcost, pinfcatchall from cs_access_central where order_no like '"+onumber+"'");
		//out.println("select pinfsellprice, pinfcost, pinfcatchall from cs_access_central where order_no like '"+onumber+"'");
		if(rsAc != null){
			while(rsAc.next()){
				sp=sp+Float.valueOf(rsAc.getString(1)).floatValue();
				tcg=tcg+Float.valueOf(rsAc.getString(2)).floatValue();
				catchall=catchall+(new Double(rsAc.getString(3)).doubleValue());
			}
		}
		rsAc.close();

		//out.println("The no of rows"+ rows_a);
		double total_model_group=0.0;
		double total_model_sqf=0.0;
		double total_model_weight=0.0;
		if (rows>0){
										out.println("<TABLE align='center' cellSpacing=2 cellPadding=2 width='100%' border=0>");
										out.println("<TBODY><tr>");
										out.println("<td vAlign='center' align='middle' width='30%'><font COLOR='RED' size=3><B>CONFIDENTIAL</B><FONT></td>");
										out.println("</tr>");
										out.println("<tr>");
										out.println("<TD class='tdt1' vAlign='center' align='middle' width='100%' colspan='5'><B><a href=\"javascript:n_window('new_sch_final.jsp?choice="+onumber+"&sp="+sp+"&tcg="+tcg+"&catchall="+catchall+"')\"><font size=2>INTERNAL SCHEDULE OF VALUES</font></a><br><font size=-5>(for accounting purposes only)</font></B></TD>");
										out.println("</tr>");
										out.println("<tr>");
										out.println("<TD class='tdt1' vAlign='center' align='middle' width='100%' colspan='5'><B><a href=\"javascript:n_window('new_sch_final_excel.jsp?choice="+onumber+"&sp="+sp+"&tcg="+tcg+"&catchall="+catchall+"')\"><font size=2>INTERNAL SCHEDULE OF VALUES EXCEL</font></a><br><font size=-5>(for accounting purposes only)</font></B></TD>");
										out.println("</tr></TBODY>");
									out.println("</TABLE>");
			    for (int m1=0;m1<rows;m1++){ //OUTer for loop bEGIN
		boolean isGood=true;
		for(int aa=0; aa<rows_c; aa++){
			if(order2[m1].equals(isUsed[aa])){
				isGood=false;
			}
		}
		if(isGood){

									out.println("<TABLE align=center cellSpacing=2 cellPadding=2 width='100%' border=0>");
									out.println("<tr>");
									out.println("<td align='left' colspan='2' >");
									out.println("<font size=1 >");
									out.println("<b>"+"&nbsp;&nbsp;<i> Item no </i>"+(m1+1)+"of "+rows+"</b></font></td>");
									out.println("<td align='right' colspan='3'>");
									out.println("<font size=1 >");
									out.println("<b>Order Number # </b>"+"<b>"+onumber+"</b></font></td>");
									out.println("</tr>");
									out.println("</TABLE>");
									out.println("<TABLE align=center cellSpacing=2 cellPadding=2 width='100%' border=0>");
									out.println("<tr>");
									out.println("<TD align='center' class=darktr >Mark</td>");
									out.println("<TD align='center' class=darktr >Model</td>");
									out.println("<TD align='center' class=darktr >Qty</td>");
									out.println("<TD align='center' class=darktr >Total LVR Sqft.</td>");
									out.println("<TD align='center' class=darktr >Total Mark Sale Price</td>");
									out.println("<TD align='center' class=darktr >Sale Price for <strong>Each</strong> Louver</td>");
									out.println("</tr>");
		//							out.println("</TABLE>");
										String modelx="";
										for (int m=0;m<rows_c;m++){ //inner for loop bEGIN
										//out.println(modelx+"::"+order2[m1]+"::"+items.elementAt(m).toString()+"<BR>");
												    if  (!isUsed[m].equals("yes")&&(order2[m1].equals(items.elementAt(m).toString()))||modelx.equals(model.elementAt(m).toString())){//If loop bEGIN
												if ((m%2)==1){bgcolor="tdt";}else {bgcolor="battr";}
												modelx=model.elementAt(m).toString();
												isUsed[m]=items.elementAt(m).toString();
										//Sale price

		double costs=0.0;double catch_all_lvr=0.0;double mark_up=0.0;double catch_factor=0.0;
		costs=(new Double(setup_cost.elementAt(m).toString()).doubleValue())+(new Double(run_cost.elementAt(m).toString()).doubleValue())+(new Double(std_cost.elementAt(m).toString()).doubleValue());
		catch_all_lvr=(catchall/(new Double(order4[m]).doubleValue()))/numSec;
		catch_factor=(catch_all_lvr*(new Double(qty.elementAt(m).toString()).doubleValue()));
		//out.println(catchall+"<- catchall  order4 -->"+"::"+m1+"::"+order4[m]+"<BR>");
		//out.println(catch_all_lvr+" ca lvr<BR>");
		//out.println(catch_factor+" c fact<BR>");
		//out.println(tcg+" cost<BR>");
		mark_up=sp/(tcg+catchall);
		//out.println(mark_up+" markup<BR>");
		total_lvr_value=total_lvr_value+((catch_factor+costs)*mark_up);
		//out.println(total_lvr_value+" total value");
		// Code for generating the report table goes here
		total_model_sqf=total_model_sqf+new Double(sqft.elementAt(m).toString()).doubleValue();
		total_model_group=(catch_factor+costs)*mark_up+total_model_group;
		total_model_weight=total_model_weight+new Double(modelWeight.elementAt(m).toString()).doubleValue();
		//						    out.println("<TABLE align=center cellSpacing=2 cellPadding=2 width='100%' border=0>");
									out.println("<tr>");
									out.println("<TD align='center' class='"+bgcolor+"'>"+mark.elementAt(m)+"</td>");
									out.println("<TD align='center' class='"+bgcolor+"'>"+model.elementAt(m)+"</td>");
									out.println("<TD align='center' class='"+bgcolor+"'>"+qty.elementAt(m)+"</td>");
									out.println("<TD align='center' class='"+bgcolor+"'>"+sqft.elementAt(m)+"</td>");
		//							out.println("<TD align='center' class='"+bgcolor+"'>"+for1.format((catch_factor+costs)*mark_up)+"markup:"+mark_up+"catchfactor:"+catch_factor+"catch_all_lvr:"+catch_all_lvr+"costs:"+costs+"</td>");
									out.println("<TD align='center' class='"+bgcolor+"'>"+for1.format((catch_factor+costs)*mark_up)+"</td>");
									out.println("<TD align='center' class='"+bgcolor+"'>"+for1.format(((catch_factor+costs)*mark_up)/(new Double(qty.elementAt(m).toString()).doubleValue()))+"</td>");
									out.println("</tr>");
		//							out.println("</TABLE>");

		// Code for generating the report table goes here done
																										    }//If loop END
		// intializing all the variables

																 }//inner for loop END



























		//						    out.println("<TABLE align=center cellSpacing=2 cellPadding=2 width='100%' border=0>");
									out.println("<tr>");
									out.println("<TD align='right' class='darktr' colspan=3>"+"&nbsp;"+"</td>");
									out.println("<TD align='right' class='darktr' >"+"Total LVR Sale Price($):"+"</td>");
									out.println("<TD align='left' class='darktr' >"+for1.format(total_lvr_value)+"</td>");
									out.println("<TD align='right' class='darktr' colspan=1>"+"&nbsp;"+"</td>");
									out.println("</tr>");
		total_lvr_value=0.0;
									//adding the new feature's

									//New new vectors for grouping by models
										Vector model_group=new Vector();
										Vector sqft_group=new Vector();
										Vector item_group=new Vector();
										Vector weight_group=new Vector();
									//Getting the group of all models
									PreparedStatement myResult_g1=myConn.prepareStatement("select model,item_no,sum(sqft),sum(weight) from cs_costing where order_no= ? and item_no= ? group by model,item_no" );
									myResult_g1.setString(1,onumber);
									myResult_g1.setString(2,order3[m1]);
									//out.println(order3[m1]+" item no<BR>");
								 ResultSet myResult_g = myResult_g1.executeQuery();
									if (myResult_g !=null){
									while (myResult_g.next()){
									model_group.addElement(myResult_g.getString("model"));
									item_group.addElement(myResult_g.getString("item_no"));
									sqft_group.addElement(myResult_g.getString(3));
									weight_group.addElement(myResult_g.getString(4));
									//out.println(myResult_g.getString(3)+" weightgroup<BR>");
		//			out.print("std "+model_group.elementAt(rows_m)+"run "+sqft_group.elementAt(rows_m)+"<br>");
									rows_m++;
													  }
													}
													myResult_g.close();
		//			out.println("Testing rows_m "+rows_m+"<br>");
									float tcg_group=0;double catchall_group=0.0;float sp_group=0;

										//String sp1=null;
										//int nt1=order1[m1].indexOf("]",sp_r);
										//sp1=order1[m1].substring(sp_r+11,nt1);
										sp_group=sp;
		//								out.println("Testing SP hours"+sp+"<br>");
												//	}
									   //sp price
											// Total cost group

											tcg_group=tcg;
		//									out.println("Testing"+tcg+"<br>");


											catchall_group=catchall;
		//									out.println("Testing CATCHALL"+catchall+"the fact"+catchall/(new Double(order4[m1]).doubleValue())+"<br>");


									//Getting the group of all models done
									for (int mn=0;mn<rows_m;mn++){
		//						out.println("mn value:"+mn+"rows_m value"+rows_m+"<br>");
									out.println("<tr>");
									out.println("<TD align='right' nowrap class='darktr' colspan=3>"+"&nbsp;Total SQ.FT for "+model_group.elementAt(mn)+":"+total_model_sqf+"</td>");
									for (int mn1=0;mn1<rows_c;mn1++){
									if((model_group.elementAt(mn).equals(model.elementAt(mn1)))&(item_group.elementAt(mn).equals(items.elementAt(mn1)))){
		//						out.println("fd"+model.elementAt(mn1)+"mn value:"+mn1+"rows_c value"+rows_c+"<br>");
									// Intializing varibles
									double costs_group=0.0;double catch_all_lvr_group=0.0;double mark_up_group=0.0;double catch_factor_group=0.0;
									costs_group=(new Double(setup_cost.elementAt(mn1).toString()).doubleValue())+(new Double(run_cost.elementAt(mn1).toString()).doubleValue())+(new Double(std_cost.elementAt(mn1).toString()).doubleValue());
									catch_all_lvr_group=catchall_group/(new Double(order4[m1]).doubleValue());
									catch_factor_group=catch_all_lvr_group*(new Double(qty.elementAt(mn1).toString()).doubleValue())/numSec;
									mark_up_group=sp_group/(tcg_group+catchall_group);
		//out.println(sp_group+"::"+tcg_group+"::"+catchall_group+"<BR>");
									//total_model_group=total_model_group+((catch_factor_group+costs_group)*mark_up_group);
		//							out.println("Testing sp"+std_cost.elementAt(mn1).toString());
									// Intializing varibles
		//						out.println("TMG"+total_model_group+"markup:"+mark_up_group+"catchfactor:"+catch_factor_group+"catch_all_lvr:"+catch_all_lvr_group+"costs:"+costs_group+"<br>");
		//out.println("<TD align='center' class='"+bgcolor+"'>"+for1.format((catch_factor+costs)*mark_up)+"markup:"+mark_up+"catchfactor:"+catch_factor+"catch_all_lvr:"+catch_all_lvr+"costs:"+costs+"</td>");
																							  }
																	}
									for1.setMaximumFractionDigits(2);
									greg=greg+total_model_group;
									//out.println(greg+"::"+total_model_group);
									out.println("<TD align='right' nowrap class='darktr' >"+"&nbsp;Total sell price for "+model_group.elementAt(mn)+": "+for1.format(total_model_group)+"</td>");
									out.println("<TD align='right' nowrap class='darktr' >"+"&nbsp;Sell price per SQ.FT of "+model_group.elementAt(mn)+": "+for1.format(total_model_group/total_model_sqf)+"</td>");
									out.println("<TD align='right' nowrap class='darktr' >"+"&nbsp;Yield for "+model_group.elementAt(mn)+": "+for1.format(total_model_group/(total_model_weight*1.2))+"</td>");
		//out.println(weight_group.elementAt(mn).toString()+"::"+total_model_group+"<BR>");
									for1.setMaximumFractionDigits(0);
									out.println("</tr>");
									total_model_weight=0.0;
									total_model_group=0.0;
		total_model_sqf=0.0;
																}
		//									sqft_group.removeAllElements();model_group.removeAllElements();
		//							out.println("<b>"+"test"+"</b>");
								////adding the new feature's done
										out.println("</TABLE>");

											sp_group=0;tcg_group=0;catchall_group=0.0;

											sqft_group.removeAllElements();model_group.removeAllElements();rows_m=0;

		if ((rows-m1)>1){//out.println("<P class='pbr'>"+"&nbsp;"+"</p>");
		}//page breaker
		}
											}	//OUTer for loop end
				   }

		else       {
		out.println("No line items exist for this quote");
				 }

		myConn.commit();
		stmt.close();
		myConn.close();


		%>
	</body>
</html>

<%
 }
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>
