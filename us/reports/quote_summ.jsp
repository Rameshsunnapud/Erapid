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
	<title>CS GROUP CONFIGURATION REPORT</title>
<link rel='stylesheet' href='time.css' type='text/css' />		

</head>
<body>
<TABLE align=center cellSpacing=2 cellPadding=2 width="100%" border=0>        
<TBODY> <TR>
		<TD class='tdt1' vAlign='center' align='middle' width='100%' colspan='10'>
		<B>QUOTATION SUMMARY</B></TD>
		</TR>
</TBODY>
</table>		
<%@ page language="java" import="java.sql.*" import="java.math.*" import="java.text.*" import="java.util.*" errorPage="error.jsp" %>
<%@ include file="../../db_con.jsp"%>
<%
// The ols file on the Production Server to restore is "display_test_new_old.jsp"
String onumber = request.getParameter("choice");

String product_id="";
ResultSet rsProject=stmt.executeQuery("select product_id FROM cs_project where order_no like '"+onumber+"'");
if(rsProject != null){
	while(rsProject.next()){
		product_id=rsProject.getString(1);
	}
}
rsProject.close();

Vector sectionLines=new Vector();
Vector sectionDescription=new Vector();
int numberOfSections=0;
String sectionInfo="";
String sectionGroup="";
ResultSet rsIsSections=stmt.executeQuery("Select section_info,sections,section_group from cs_quote_sections where order_no = '"+onumber+"'");
if(rsIsSections != null){
	while(rsIsSections.next()){
		numberOfSections=rsIsSections.getInt("sections");
		sectionInfo=rsIsSections.getString("section_info");
		sectionGroup=rsIsSections.getString("section_group");
	}
}
rsIsSections.close();
	
//out.println(numberOfSections+"::<BR>"+sectionInfo+"::<BR>"+sectionGroup+"::<BR>");	
if(numberOfSections>1){
	for(int xx=1; xx<= numberOfSections; xx++){
		sectionLines.addElement("");
		int startx=sectionInfo.indexOf("s"+xx+"=");
		int endx=sectionInfo.indexOf(";",startx);
		//out.println(startx+","+endx+"<BR>");
		//out.println(sectionInfo.substring((startx+("s"+xx+"=").length()),endx)+" xx<BR>");
		sectionDescription.addElement(sectionInfo.substring((startx+("s"+xx+"=").length()),endx));
	}
	while(sectionGroup.length()>1){
		int endx=sectionGroup.indexOf(";");
		String tempSec=sectionGroup.substring(0,endx);
		//out.println(tempSec+"<BR>");
		String tempLine=tempSec.substring(0,tempSec.indexOf("="));
		tempSec=tempSec.substring(tempSec.indexOf("=s")+2);
		//out.println(tempLine+"::"+tempSec+"<BR>");
		int secNum=Integer.parseInt(tempSec)-1;
		if(sectionLines.elementAt(secNum).toString().trim().length()>0){
			sectionLines.setElementAt(sectionLines.elementAt(secNum).toString()+","+tempLine,secNum);
		}
		else{
			sectionLines.setElementAt(tempLine,secNum);
		}
		sectionGroup=sectionGroup.substring(endx+1);
	}

	
}
else{
	//out.println("HERE");
	ResultSet rsQuotesLines=stmt.executeQuery("select doc_line from doc_line where doc_number='"+onumber+"'");
	String linex ="";
	if(rsQuotesLines != null){
		while(rsQuotesLines.next()){
			if(linex.trim().length()>0){
				linex=linex+","+rsQuotesLines.getString(1);
			}
			else{
				linex=rsQuotesLines.getString(1);
			}
				
			
		}
	}
	rsQuotesLines.close();
	sectionLines.addElement(linex);
	sectionDescription.addElement("");
}
	
	
	
for(int count=0; count<sectionLines.size(); count++){	
	
	
out.println("<B>"+sectionDescription.elementAt(count).toString()+"</b><br>");
	
	
	
	
	
	
	
	
	
java.sql.Statement stmt1=myConn.createStatement();
java.sql.ResultSet myResult=stmt.executeQuery("select * FROM doc_line where doc_number= '"+onumber+"' and doc_line in ("+sectionLines.elementAt(count).toString()+") order by cast(doc_line as decimal),subline_no" );
java.sql.ResultSet myResult1=stmt1.executeQuery("select doc_line FROM doc_line where doc_number= '"+onumber+"' and doc_line in ("+sectionLines.elementAt(count).toString()+") group by doc_line order by cast(doc_line as decimal)" );

//Db Variables
int rows=0;
int row_n=0;

// Subline Varibales
String model=null;String mk=null;String qty=null;String width=null;String height=null;
String totwt=null;String sec=null;String lvrfin=null;String shape=null;String screens=null;
String sys_depth=" ";String win_load="";String deflection="";
float tLinFt=0;
//Totals
int ttotwt=0;int qtotal=0;int stotal=0;float tperim=0;float tarea=0;float tsarea=0;

//LIne level Variables
String spec_section=" ";String addenda=" ";String line_item_desc=" ";


String[] order1=new String[150];
String[] order2=new String[150];
String[] order3=new String[150];
String[] order4=new String[150];
String[] ic=new String[100];

if (myResult !=null){														
while (myResult.next()){
order1[rows] = myResult.getString("product_id");
order2[rows] = myResult.getString("config_string");
order3[rows] = myResult.getString("speed_number");
order4[rows] = myResult.getString("doc_line");
rows++;
  }
}


if (myResult1 !=null){														
while (myResult1.next()){
ic[row_n] = myResult1.getString("doc_line");
//out.print(ic[row_n]+"<br>");	 		
row_n++;
  }
}
 
if (rows>0){

						if(product_id.equals("GRILLE")){
								%>

							<%@ include file="quote_summary_header_grille.html"%>										
							<%								
						}
						else{
							%>

							<%@ include file="quote_summary_header.html"%>										
							<%
						}
	for (int m1=0;m1<row_n;m1++){
		for (int m=0;m<rows;m++){ //inner for loop bEGIN 

			if  ((order4[m].equals(ic[m1]))){//If loop bEGIN FOR lINE iTEM 
				//iF IT IS A aCCESS cENTRAL 								
				if(order1[m].equals("ACCESS_CENTRAL")){
					int item_n1=order2[m].indexOf("QUOTE_DATA/DESC");
					if (item_n1 >=0 ){
						int n2=order2[m].indexOf("]",item_n1);														
						line_item_desc=order2[m].substring(item_n1+16,n2);
					}
					else{
						line_item_desc=" ";
					}				
								
					out.println("<TABLE align=center cellSpacing=2 cellPadding=2 width='100%' border=0>");        		
					out.println("<tr>");	
					out.println("<td align='left' colspan='5' >");
					out.println("<font size=1 >");
					out.println("<b>"+line_item_desc+"&nbsp;&nbsp;<i> Item no </i>"+(m1+1)+"of "+row_n+"</b></font></td>");
					out.println("<td align='right' colspan='5'>");
					out.println("<font size=1 >");
					out.println("<b>Order Number # </b>"+"<b>"+onumber+"</b></font></td>");
					out.println("</tr>");
					out.println("</TABLE>");	
					//Spec Section
					int n1=order2[m].indexOf("SECT");
					if (n1 >=0 ){
						int n2=order2[m].indexOf("]",n1);														
						spec_section=order2[m].substring(n1+5,n2);
					}
					else{
						spec_section=" ";
					}
					//Addenda
					int adde=order2[m].indexOf("ADD");
					if (adde >=0 ){
						int n2=order2[m].indexOf("]",adde);														
						addenda=order2[m].substring(adde+4,n2);
					}
					else{
						addenda=" ";
					}	

					// end of if it is Access Central Group																								
																		}
																		
																		
					// else if it is BV
					else if(order1[m].equals("BV")){
						if(product_id.equals("GRILLE")){
							%>

							<%@ include file="quote_summary_header_grille.html"%>										
							<%								
						}
						else{
							%>

							<%@ include file="quote_summary_header.html"%>										
							<%	
						}
						//New Row for BV
						out.println("<TABLE align=center cellSpacing=2 cellPadding=2 width='100%' border=0>");        		
						out.println("<tr>");								
						//Model
						int n1=order2[m].indexOf("BVMODEL");
						if (n1 >=0 ){
							int n2=order2[m].indexOf("]",n1);														
							model=order2[m].substring(n1+8,n2);
							out.println("<td align='center' width='9%' class='tdt'>"+model+"</td>"); 
						}
						else{
							model="NONE";
							out.println("<td align='center' width='9%' class='tdt'>"+model+"</td>"); 
					    	}
						// Mark
						// Mark	Design	
						int na=order2[m].indexOf("BVMK");
						if (na >=0 ){
							int nb=order2[m].indexOf("]",na);														
							mk=order2[m].substring(na+5,nb);
		//					out.println("The make "+"yes "+mk+"<br>");						
							out.println("<td align='center' width='9%' class='tdt'>"+mk+"</td>"); 
						}
						else{
							mk="NONE";
		//					out.println("The mkaeno "+"nos"+mk+"<br>");
							out.println("<td align='center' width='9%' class='tdt' >"+mk+"</td>"); 
						}							
						// Width
						int nw=order2[m].indexOf("BVWIDTH");
						if (nw >=0 ){
							int nw1=order2[m].indexOf("]",nw);														
							width=order2[m].substring(nw+8,nw1);
							out.println("<td align='center' width='9%' class='tdt' >"+width+"</td>"); 
						}
						else{
							width="0";
							out.println("<td align='center' width='9%' class='tdt' >"+width+"</td>"); 
						}							
						//	Height
						int nh=order2[m].indexOf("BVHEIGHT");
						if (nh >=0 ){
							int nh1=order2[m].indexOf("]",nh);														
							height=order2[m].substring(nh+9,nh1);
							out.println("<td align='center' width='9%' class='tdt' >"+height+"</td>"); 
						}
						else{
							height="0";
							out.println("<td align='center' width='9%' class='tdt' >"+height+"</td>"); 
						}							
						// QTY	
						int nq=order2[m].indexOf("QUANTITY");
						if (nq >=0 ){
							int nq1=order2[m].indexOf("]",nq);														
							qty=order2[m].substring(nq+9,nq1);
							out.println("<td align='center' width='9%' class='tdt' >"+((new Float(qty)).intValue())+"</td>"); 
						}
						else{
							qty="0";
							out.println("<td align='center' width='9%' class='tdt' >"+qty+"</td>"); 
						}						
												
						// finish
						int nf=order2[m].indexOf("BVFINISH");
						if (nf >=0 ){
							int nf1=order2[m].indexOf("&",nf);														
							lvrfin=order2[m].substring(nf+9,nf1);
							out.println("<td align='center' width='9%' class='tdt' >"+lvrfin+"</td>"); 
						}
						else{
							lvrfin="NONE";
							out.println("<td align='center' width='9%' class='tdt' >"+lvrfin+"</td>"); 
						}							
						//SILLACC
						out.println("<td align='center' width='9%' class='tdt' >"+"--"+"</td>"); 										
						// Sections												
						sec="1.0";
						out.println("<td align='center' width='9%' class='tdt' >"+((new Float(sec)).intValue())+"</td>"); 







						//TOTWEIGHT								
		  				int nt=order2[m].indexOf("TOTBVWT");
						if (nt >=0 ){
							int nt1=order2[m].indexOf("]",nt);														
							totwt=order2[m].substring(nt+8,nt1);
							ttotwt=ttotwt+((new Float(totwt)).intValue());
							out.println("<td align='center' width='9%' class='tdt' >"+((new Float(totwt)).intValue())+"</td>"); 
						}
						
						if( !sec.equals("0")){
							out.println("<td align='center' class='tdt' width='9%'>"+new Float(""+((new Double(totwt).doubleValue()/new Double(sec).doubleValue()))/new Double(qty).doubleValue()).intValue()+"</td>");
						}
						else{
							out.println("<td align='center' class='tdt' width='9%'>&nbsp;</td>");
						}
									
									
						// System Depth	 			
						int nsdep=order2[m].indexOf("SYSDEPTH");
						if (nsdep >=0 ){
							int ns1=order2[m].indexOf("]",nsdep);														
							sys_depth=order2[m].substring(nsdep+9,ns1);
							out.println("<td align='center' class='tdt' width='9%'>"+((new Float(sys_depth)).intValue())+"</td>"); 
						}
						else{
							sys_depth="--";
							out.println("<td align='center' class='tdt' width='9%'>"+sys_depth+"</td>"); 
						}		
																
						out.println("</tr>");out.println("</table>");	
						out.println("<TABLE align=center width='100%' border=0>");	
						out.println("<tr>");												
						out.println("<td align='left' width='70%' class='battr'>&nbsp;&nbsp;&nbsp;<b>SCREEN/BO:</b><i> 7X7 MESH</i></td>");
						out.println("<td align='left' width='30%' class='battr'><b>SHAPE:</b>RECT</td>");
						out.println("</tr>");
						out.println("</table>");
						// Adding the Totals for Quantity and Sections
						qtotal=qtotal+((new Float(qty)).intValue());
						stotal=stotal+(((new Float(sec)).intValue())*(new Float(qty)).intValue());																															
						// New Row End for the BV				
						out.println("</tr>");																						
					}// Else IF end if it is BV
					//If it is a LVR
					else{

						out.println("<TABLE align=center cellSpacing=2 cellPadding=2 width='100%' border=0>");        										
						//New row
						out.println("<tr>");								
						//Model
									int n1=order2[m].indexOf("MODEL1");
									if (n1 >=0 ){
									int n2=order2[m].indexOf("]",n1);														
									model=order2[m].substring(n1+7,n2);
		//							out.println("The first "+"yes"+n1+":"+n2+": : "+model+"<br>");
									out.println("<td align='center' class='tdt' width='9%'>"+model+"</td>"); 
												}
									else{
									model="NONE";
		//							out.println("The first "+"nos"+model+"<br>");
									out.println("<td align='center' class='tdt' width='9%'>"+model+"</td>"); 
									    }							
		// Mark	Design	 
									int na=order2[m].indexOf("MK[");
									if (na >=0 ){
									int nb=order2[m].indexOf("]",na);														
									mk=order2[m].substring(na+3,nb);
		//							out.println("The make "+"yes "+mk+"<br>");
									out.println("<td align='center' class='tdt' width='9%'>"+mk+"</td>"); 
												}
									else{
									mk="NONE";
		//							out.println("The mkaeno "+"nos"+mk+"<br>");
									out.println("<td align='center' class='tdt' width='9%'>"+mk+"</td>"); 
									    }							
		// Item no                 
		//					out.println("<td align='center' width='9%' class='tdt' >"+order4[m].toString()+"</td>"); 							
				
		// Width
									int nw=order2[m].indexOf("OW_FRAC");
									if (nw >=0 ){
									int nw1=order2[m].indexOf("]",nw);														
									width=order2[m].substring(nw+8,nw1);
									out.println("<td align='center' class='tdt' width='9%'>"+width+"</td>"); 
												}
									else{
									width="0";
									out.println("<td align='center' class='tdt' width='9%'>"+width+"</td>"); 
									    }							
		//	Height
									int nh=order2[m].indexOf("OH_FRAC");
									if (nh >=0 ){
									int nh1=order2[m].indexOf("]",nh);														
									height=order2[m].substring(nh+8,nh1);
									out.println("<td align='center' class='tdt' width='10%'>"+height+"</td>"); 
												}
									else{
									height="0";
									out.println("<td align='center' class='tdt' width='10%'>"+height+"</td>"); 
									    }							
		// QTY	
									int nq=order2[m].indexOf(",QTY[");
									if (nq >=0 ){
									int nq1=order2[m].indexOf("]",nq);														
									qty=order2[m].substring(nq+5,nq1);
									out.println("<td align='center' class='tdt' width='9%'>"+((new Float(qty)).intValue())+"</td>"); 
												}
									else{
									qty="0";
									out.println("<td align='center' class='tdt' width='9%'>"+qty+"</td>"); 
									    }							
										
		// finish
									int nf=order2[m].indexOf("LVRFIN");
									if (nf >=0 ){
									int nf1=order2[m].indexOf("]",nf);														
									lvrfin=order2[m].substring(nf+7,nf1);
									out.println("<td align='center' class='tdt' width='9%'>"+lvrfin+"</td>"); 
												}
									else{
									lvrfin="NONE";
									out.println("<td align='center' class='tdt' width='9%'>"+lvrfin+"</td>"); 
									    }
								   
		//SILLACC
											if(product_id.equals("GRILLE")){
												int bs=order2[m].indexOf("BLDSPC");
												String bldspc="";
												if(bs >=0){
													int bs2=order2[m].indexOf("]",bs);
													bldspc=order2[m].substring(bs+7,bs2);
												}
												else{
													bldspc="0";
												}
												out.println("<td align='center' class='tdt' width='9%'>"+bldspc+"</td>");
											}
									else{
		  						   	int sill=order2[m].indexOf("SILLACC");
									if (sill >=0 ){
									out.println("<td align='center' class='tdt' width='9%'>"+"Yes"+"</td>"); 
												  }
									else{
									out.println("<td align='center' class='tdt' width='9%'>"+"NO"+"</td>"); 
									    }	
										
									}
		// Sections					
									if(product_id.equals("GRILLE")){
										int ns=order2[m].indexOf("RUN1SIDES");
										if (ns >=0 ){
											int ns1=order2[m].indexOf("]",ns);														
											sec=order2[m].substring(ns+10,ns1);
											out.println("<td align='center' class='tdt' width='9%'>"+((new Float(sec)).intValue())+"</td>"); 
										}
										else{
											sec="0";
											out.println("<td align='center' class='tdt' width='9%'>"+sec+"</td>"); 
									    	}			
									}
									else{
										int ns=order2[m].indexOf("SECTS[");
										if (ns >=0 ){
											int ns1=order2[m].indexOf("]",ns);														
											sec=order2[m].substring(ns+6,ns1);
											out.println("<td align='center' class='tdt' width='9%'>"+((new Float(sec)).intValue())+"</td>"); 
											//out.println("<td align='center' class='tdt' width='9%'>"+sec+"</td>");
										}
										else{
											sec="0";
											out.println("<td align='center' class='tdt' width='9%'>"+sec+"</td>"); 
											//out.println("<td align='center' class='tdt' width='10%'>"+sec+"</td>");
									    }
									}
		//TOTWEIGHT								
		  							int nt=order2[m].indexOf("TOTWT");
									if (nt >=0 ){
										int nt1=order2[m].indexOf("]",nt);														
										totwt=order2[m].substring(nt+6,nt1);
										ttotwt=ttotwt+((new Float(totwt)).intValue());
										out.println("<td align='center' class='tdt' width='9%'>"+((new Float(totwt)).intValue())+"</td>"); 
									}
		// System Depth						
									if( !sec.equals("0")){
										out.println("<td align='center' class='tdt' width='9%'>"+new Float(""+((new Double(totwt).doubleValue()/new Double(sec).doubleValue()))/new Double(qty).doubleValue()).intValue()+"</td>");
									}
									else{
										out.println("<td align='center' class='tdt' width='9%'>&nbsp;</td>");
									}
									int nsdep=order2[m].indexOf("SYSDEPTH");
									if (nsdep >=0 ){
									int ns1=order2[m].indexOf("]",nsdep);														
									sys_depth=order2[m].substring(nsdep+9,ns1);
									out.println("<td align='center' class='tdt' width='9%'>"+((new Float(sys_depth)).intValue())+"</td>"); 
												}
									else{
									sys_depth=" ";
									out.println("<td align='center' class='tdt' width='9%'>"+sys_depth+"</td>"); 
									    }		
		// Winload				
									int win=order2[m].indexOf("EWLOAD");
									if (win >=0 ){
									int ns1=order2[m].indexOf("]",win);														
									win_load=order2[m].substring(win+7,ns1);
//									out.println("<td align='center' class='tdt' width='9%'>"+((new Float(sys_depth)).intValue())+"</td>"); 
												}
									else{
									win_load="0";
//									out.println("<td align='center' class='tdt' width='9%'>"+sys_depth+"</td>"); 
									    }		
		// Deflection				
									int defl=order2[m].indexOf(",DEFL[");
									if (defl >=0 ){
									int ns1=order2[m].indexOf("]",defl);														
									deflection=order2[m].substring(defl+6,ns1);
//									out.println("<td align='center' class='tdt' width='9%'>"+((new Float(sys_depth)).intValue())+"</td>"); 
												}
									else{
									deflection="0";
//									out.println("<td align='center' class='tdt' width='9%'>"+sys_depth+"</td>"); 
									    }					
												
		//SHAPE						   
								   	int n_sp=order2[m].indexOf("SHAPE/");
									if (n_sp >=0 ){
									int n_sp1=order2[m].indexOf("&",n_sp);														
									shape=order2[m].substring(n_sp+6,n_sp1);
								//	out.println("<td align='center' width='9%' class='tdt' >"+shape+"</td>"); 
												}
									else{
									shape="NONE";
								//	out.println("<td align='center' width='9%' class='tdt' >"+shape+"</td>"); 
									    }	
		// Screens
out.println("</tr>");
out.println("</table>");
out.println("<TABLE align=center width='100%' border=0>");        																				
								out.println("<tr>");
		                        int scri=order2[m].indexOf("SCRN_BO");
								if (scri >=0 ){
												int scriu=order2[m].indexOf("]",scri);														
												screens=order2[m].substring(scri+8,scriu);
												if(screens.startsWith("SSINSECT"))
												out.println("<td align='left' colspan='5' class='battr'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN/BO:</b>"+"<i>  Stainless Steel Insect Screen</i>"+"</td>");
												else if(screens.startsWith("BIRDINSECT"))
												out.println("<td align='left' colspan='5' class='battr'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN/BO:</b>"+"<i>  5/8 Exp. Mesh and 18 x 16 Alum Insect Screen</i>"+"</td>");
												else if(screens.startsWith("ALINSECT"))
												out.println("<td align='left' colspan='5' class='battr'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN/BO:</b>"+"<i>  18 x 16 .011 Dia. Insect Screen</i>"+"</td>");
												else if (screens.startsWith("FGINSECT"))
												out.println("<td align='left' colspan='5' class='battr'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN:</b>"+"<i>  Fiberglass Insect Screen</i>"+"</td>");
												else if(screens.startsWith("050ALEXP58"))
												out.println("<td align='left' colspan='5' class='battr'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN/BO:</b>"+"<i>  5/8 Exp. Mesh .050 Thk Birdscreen</i>"+"</td>");
												else if(screens.startsWith("050ALEXP34"))
												out.println("<td align='left' colspan='5' class='battr'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN/BO:</b>"+"<i>  3/4 Exp. Mesh .050 Thk Birdscreen</i>"+"</td>");
												else if(screens.startsWith("047ALINT14"))
												out.println("<td align='left' colspan='5' class='battr'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN/BO:</b>"+"<i>  1/4 Intercrimp .047 Dia. Birdscreen</i>"+"</td>");
												else if(screens.startsWith("063ALINT12"))
												out.println("<td align='left' colspan='5' class='battr'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN/BO:</b>"+"<i>  1/2 Intercrimp .063 Dia. Birdscreen</i>"+"</td>");
												else if(screens.startsWith("063SSINT12"))
												out.println("<td align='left' colspan='5' class='battr'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN/BO:</b>"+"<i>  1/2 Intercrimp SS .063 Dia. Birdscreen</i>"+"</td>");
												else if(screens.startsWith("050SHTBO"))
												out.println("<td colspan='5' align='left' class='battr'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN/BO:</b>"+"<i>  .050\" Aluminum sheet blankoff</i>"+"</td>");
												else if(screens.startsWith("080SHTBO"))
												out.println("<td colspan='5' align='left' class='battr'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN/BO:</b>"+"<i>  .080\" Aluminum sheet blankoff</i>"+"</td>");
												else if(screens.startsWith("125SHTBO"))
												out.println("<td colspan='5' align='left' class='battr'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN/BO:</b>"+"<i>  .125\" Aluminum sheet blankoff</i>"+"</td>");
												else if(screens.startsWith("1INSBO"))
												out.println("<td colspan='5' align='left' class='battr'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN/BO:</b>"+"<i>  1\" Insulated blankoff</i>"+"</td>");
												else if(screens.startsWith("15INSBO"))
												out.println("<td colspan='5' align='left' class='battr'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN/BO:</b>"+"<i>  1 1/2\" Insulated blankoff</i>"+"</td>");
												else if(screens.startsWith("2INSBO"))
												out.println("<td colspan='5' align='left' class='battr'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN/BO:</b>"+"<i>  2\" Insulated blankoff</i>"+"</td>");
												else if(screens.startsWith("25INSBO"))
												out.println("<td colspan='5' align='left' class='battr'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN/BO:</b>"+"<i>  2 1/2\" Insulated blankoff</i>"+"</td>");
												else if(screens.startsWith("3INSBO"))
												out.println("<td colspan='5' align='left' class='battr'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN/BO:</b>"+"<i>  3\" Insulated blankoff</i>"+"</td>");																					
												else{
												out.println("<td align='left' colspan='5' class='battr'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN/BO: </b>"+"<i>"+"NONE"+"</i>"+"</td>");				
												}
											  }
								else{
								screens="NONE";
								out.println("<td align='left' colspan='5' class='battr'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN/BO: </b>"+"<i>"+screens+"</i>"+"</td>"); 
								    }	
								out.println("<td align='left' colspan='2' width='30%' class='battr'><b>WINDLOAD: </b>"+win_load+"</td>"); 		
								out.println("<td align='left' width='30%' class='battr'><b>SHAPE: </b>"+shape+"</td>"); 	
out.println("</tr>");
out.println("</table>");																													

		// Perim
								   	int sperim=order2[m].indexOf("TOTPERIM");
									if (sperim >=0 ){
									int perimi=order2[m].indexOf("]",sperim);														
									String perim=order2[m].substring(sperim+9,perimi);
									tperim=tperim+((new Float(perim)).floatValue());
//									out.println(tperim+"<br>"); 
												}
									else{
									String perim="0";
									tperim=tperim+((new Float(perim)).floatValue());
//									out.println(tperim+"</br>"); 
									    }	
								   	int sLinFt=order2[m].indexOf("TOTLINFT");
									if (sLinFt >=0 ){
										int perimi=order2[m].indexOf("]",sLinFt);
										String perim=order2[m].substring(sLinFt+9,perimi);
										tLinFt=tLinFt+((new Float(perim)).floatValue());
										//out.println(tLinFt+" :: total lineal feet<BR>");
									}									    
		// Surf Area								
								   	int sim=order2[m].indexOf("TOTSURF");
									if (sim >=0 ){
									int simi=order2[m].indexOf("]",sim);														
									String area=order2[m].substring(sim+8,simi);
									tarea=tarea+((new Float(area)).floatValue());
//									out.println(tarea+"<br>"); 
												}
									else{
									String area="0";
									tarea=tarea+((new Float(area)).floatValue());							
//									out.println(tarea+"</br>"); 
									    }	
		// Area	   v
								   	int lvr=order2[m].indexOf("TOTLVRSF");
									if (lvr >=0 ){
									int lvri=order2[m].indexOf("]",lvr);														
									String vt=order2[m].substring(lvr+9,lvri);
									tsarea=tsarea+((new Float(vt)).floatValue());
//									out.println(tsarea+"<br>"); 
												}
									else{
									String vt="0";
		       						tsarea=tsarea+((new Float(vt)).floatValue());							
//									out.println(tsarea+"</br>"); 
									    }					   
								   qtotal=qtotal+((new Float(qty)).intValue());
								   stotal=stotal+(((new Float(sec)).intValue())*(new Float(qty)).intValue());
								    }// else loop
//If it is a LVR end	 																	
																		
																} //If loop end FOR lINE iTEM 
                                                        }// Inner For Loop eND
                                                        }
                                                        }
                           	if(product_id.equals("GRILLE")){    
					out.println("<TABLE align=center cellSpacing=2 cellPadding=2 width='100%' border=0>");
					out.println("<tr><td align='center' class=darktr width='10%'>"+"<b>TOTALS:</b>"+"</td>");
					out.println("<td width='30%' align='left' class=darktr >"+"Area = "+((new Float(tsarea)).intValue())+" Sq.Ft."+"</td>");
					out.println("<td width='10%' align='center' class=darktr nowrap>"+qtotal+"</td>");
					if(product_id.equals("GRILLE")){
						out.println("<td width='20%' align='left' class=darktr >"+"Perimeter = "+((new Float(tLinFt)).intValue())+" Ft."+"</td>");
					}
					else{
						out.println("<td width='20%' align='left' class=darktr >"+"Perimeter = "+((new Float(tperim)).intValue())+" Ft."+"</td>");
					}
					out.println("<td width='10%' align='center' class=darktr nowrap>"+stotal+"</td>");
					out.println("<td width='10%' align='center' class=darktr nowrap>"+ttotwt+"</td>");
					out.println("<td width='20%' align='left' class=darktr nowrap>"+"&nbsp;"+"</td>");
					out.println("</tr>");
					out.println("</table>");
				}
				else{
					out.println("<TABLE align=center cellSpacing=2 cellPadding=2 width='100%' border=0>");
					out.println("<tr><td align='center' class=darktr width='9%'>"+"<b>TOTALS:</b>"+"</td>");
					out.println("<td width='28%' align='left' class=darktr >"+"Area = "+((new Float(tsarea)).intValue())+" Sq.Ft."+"</td>");
					out.println("<td width='9%' align='center' class=darktr nowrap>"+qtotal+"</td>");
					if(product_id.equals("GRILLE")){
						out.println("<td width='18%' align='left' class=darktr >"+"Perimeter = "+((new Float(tLinFt)).intValue())+" Ft."+"</td>");
					}
					else{
						out.println("<td width='18%' align='left' class=darktr >"+"Perimeter = "+((new Float(tperim)).intValue())+" Ft."+"</td>");
					}
					out.println("<td width='9%' align='center' class=darktr nowrap>"+stotal+"</td>");
					out.println("<td width='9%' align='center' class=darktr nowrap>"+ttotwt+"</td>");
					out.println("<td width='28%' align='left' class=darktr nowrap>"+"&nbsp;"+"</td>");
					out.println("</tr>");
					out.println("</table>");				
				
				}
					
					
					out.println("<br>");																				
					out.println("<TABLE align=LEFT cellSpacing=2 cellPadding=2 width='40%' border=0>");
					out.println("<tr>");
					out.println("<td align='left' NOWRAP class='tdt' width='10%'>"+"<b>DEFLECTION(L): "+deflection+"</b>"+"</td>");
					out.println("<td align='left' NOWRAP class='tdt' width='10%'>"+"<b>SPEC SECTION: "+spec_section+"</b>"+"</td>");
					out.println("<td align='left' NOWRAP class='tdt' width='10%'>"+"<b>ADDENDA: "+addenda+"</b>"+"</td>");
					out.println("</tr>");
					out.println("</table>");
					out.println("<br><br><br>");
ttotwt=0;qtotal=0;stotal=0;tsarea=0;tperim=0;tLinFt=0;





}// sections for loop

 %>
 
<%
myConn.commit();
stmt.close();
myConn.close();			

//stmt1.close();
}
catch(Exception e){
out.println(e);
}
		%>
 %> 
</body>
</html>
