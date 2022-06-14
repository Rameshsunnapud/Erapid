<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<html>
	<head>
		<title>SHOP FLOOR REPORT::Quote no#  <%= request.getParameter("choice") %></title>
		<link rel='stylesheet' href='rqs.css' type='text/css' />
		<SCRIPT language="JavaScript">
			<!--
			function n_window(theurl){
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
	<%@ page language="java" import="java.sql.*" import="java.math.*" import="java.text.*" import="java.util.*" errorPage="error.jsp" %>
	<body>
		<%@ include file="../../db_con.jsp"%>
		<%

		String onumber=request.getParameter("choice");
		String project_name="";

		boolean isModular=false;
		boolean isMyriad=false;
		boolean wasModular=false;
		boolean wasMyriad=false;
		String grillecost="0";
		String vaccost="0";
		String rfcost="0";
		String econocost="0";
		String exchName="";
		String exchRate="";
		String exchRateDate="";
		String city="";
		String state="";
		//out.println(countType+"::"+isModular);
		String galCost="";
		ResultSet rsGal=stmt.executeQuery("select galvcostlb from cs_matcostlb");
		if(rsGal != null){
			while(rsGal.next()){
				galCost=rsGal.getString(1);
			}
		}
		rsGal.close();


		//for(int q=0; q<countType; q++){// this loops the entire code.  Creating a seperate report for modular.
			String product_id="";
			java.sql.Statement stmt1=myConn.createStatement();
			java.sql.Statement stmt2=myConn.createStatement();
			boolean exists=false;
			ResultSet rsProject=stmt.executeQuery("select product_id,project_name,exch_name,exch_rate,exch_rate_date FROM cs_project where order_no like '"+onumber+"'");
			if(rsProject != null){
				while(rsProject.next()){
					product_id=rsProject.getString(1);
					project_name=rsProject.getString("project_name");
					exchName=rsProject.getString("exch_name");
					exchRate=rsProject.getString("exch_rate");
					exchRateDate=rsProject.getString("exch_rate_date");
				}
			}
			rsProject.close();
if(exchRate==null || exchRate.trim().length()==0){
exchRate="0";
}
//out.println(exchName+"::"+exchRate+"::"+exchRateDate);
		%>
		<p align="center"><b><a href="javascript:n_window('quote_summ.jsp?choice=<%= request.getParameter("choice")%>')">CONFIGURATION SUMMARY</a></b></p>
		<p align="center"><b><%=project_name%></b></p>
				<%
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
					boolean temp=false;
					if(numberOfSections==0||numberOfSections==1){
						numberOfSections=1;
						temp=true;
					}
					String sectionNames[]=new String[numberOfSections];
					String sectionLines[]=new String[numberOfSections];
					if(temp){
						sectionNames[0]="";
						sectionLines[0]="";
						ResultSet rsLineNum=stmt.executeQuery("Select doc_line from doc_line where doc_number='"+onumber+"' order by cast(doc_line as decimal)");
						if(rsLineNum != null){
							while(rsLineNum.next()){
								sectionLines[0]=sectionLines[0]+rsLineNum.getString(1)+",";
							}
						}
						rsLineNum.close();
						if(sectionLines[0].indexOf(",")>0){
							sectionLines[0]=sectionLines[0].substring(0,sectionLines[0].length()-1);
						}
						//out.println(sectionLines[0]+"::<BR>");
						numberOfSections=0;
					}
					if(numberOfSections>0){
						for(int e=0; e<numberOfSections; e++){
							int start=0;
							int end=0;
							start=sectionInfo.indexOf(";");
							if(start>0){
								end=sectionInfo.indexOf("=");
								sectionNames[e]=sectionInfo.substring(end+1,start);
								sectionInfo=sectionInfo.substring(start+1);
							}
						}
						for(int g=0; g<numberOfSections; g++){
							sectionLines[g]="";
						}
						for(int f=0; f<sectionGroup.length(); f++){
							int startx=0;
							int endx=0;
							endx=sectionGroup.indexOf(";");
							if(endx>0){
								startx=sectionGroup.indexOf("=");
								sectionLines[Integer.parseInt(sectionGroup.substring(startx+2,endx))-1]=sectionLines[Integer.parseInt(sectionGroup.substring(startx+2,endx))-1]+sectionGroup.substring(0,startx)+",";
								sectionGroup=sectionGroup.substring(endx+1);
								f=sectionGroup.length()-2;
							}
							else{
								f=sectionGroup.length();
							}
						}
						for(int tt=0; tt<numberOfSections; tt++){
							//out.println(sectionLines[tt]+ "here<BR>");
							if(sectionLines[tt].indexOf(",")>0){
								sectionLines[tt]=sectionLines[tt].substring(0,sectionLines[tt].length()-1);
							}
						}
					}

					// this is to delete items from cs costing and eorder items where they do not have
					// an access central ine
					String thingsToDelete="";
					Vector costing=new Vector();
					try{
						//Statement stmt=new Statement
						String query1="";
							query1="select distinct item_no from cs_costing where order_no= '"+onumber+"' group by item_no";

						ResultSet distinctCosting=stmt.executeQuery("select distinct item_no from cs_costing where order_no= '"+onumber+"' group by item_no");
						if(distinctCosting != null){
							while(distinctCosting.next()){
								costing.addElement(distinctCosting.getString("item_no"));
								//out.println(distinctCosting.getString("item_no"));

							}
						}
						distinctCosting.close();
					}
					catch(java.sql.SQLException e){
						out.println("2"+e );
					}

					Vector orderItems=new Vector();
					try{
						ResultSet eOrder=stmt.executeQuery("select doc_line from doc_line where subline_no= '0' and doc_number= '"+onumber+"'");
						if(eOrder != null){
							while(eOrder.next()){
								orderItems.addElement(eOrder.getString("doc_line"));
								//out.println(eOrder.getString("item_no"));

							}
						}
					}
					catch(java.sql.SQLException e){
						out.println("1"+e);
					}
					// comares the two result sets and if different lines occur, then delete
					for(int g=0; g<costing.size(); g++){
						exists=false;
						for(int c=0; c<orderItems.size(); c++){
							if(costing.elementAt(g).toString().equals(orderItems.elementAt(c).toString().trim())){
								exists=true;
							}
						}
						if(!exists){
							thingsToDelete=thingsToDelete+",'"+costing.elementAt(g).toString()+"'";
							//out.println(thingsToDelete);
						}
					}
					if(thingsToDelete.length() > 0){
						thingsToDelete=thingsToDelete.substring(1,thingsToDelete.length());
						//out.println("<br>"+thingsToDelete);
					}
					// this is where the actual delete takes place
					//out.println(onumber);
					if(thingsToDelete.length()>0){
						String orderDelete="Delete from doc_line where doc_number='"+onumber+"' and doc_line in ("+thingsToDelete+")";
						String costingDelete="Delete from cs_costing where order_no='"+onumber+"' and item_no in ("+thingsToDelete+")";
						try{
							int result1=stmt.executeUpdate(orderDelete);
							int result2=stmt.executeUpdate(costingDelete);
						}
						catch(java.sql.SQLException e){
							out.println("Problem delete records from database :: "+e);
						}
					}
					// delete from cs costing and eorder items finished

					if(numberOfSections==0){
						numberOfSections=1;
					}
					// The ols file on the Production Server to restore is "display_test_new_old.jsp"
					//tring onumber = request.getParameter("choice");

					for(int counter=0; counter<numberOfSections; counter++){

						//out.println(sectionLines[counter]+" lines<BR>");
						String whereClause="";
						String whereClause2="";

						java.sql.ResultSet myResult=stmt.executeQuery("select * from doc_line where doc_number= '"+onumber+"' and doc_line in("+sectionLines[counter]+")"+whereClause+" order by cast(doc_line as decimal),subline_no" );



						java.sql.ResultSet myResult1=stmt1.executeQuery("select doc_line from doc_line where doc_number= '"+onumber+"' and doc_line in("+sectionLines[counter]+")"+whereClause+" group by doc_line order by cast(doc_line as decimal)" );
						java.sql.ResultSet myResult2=stmt2.executeQuery("select * from CS_COSTING where order_no= '"+onumber+"' and item_no in("+sectionLines[counter]+")"+whereClause2+" order by cast(item_no as decimal),subline_no" );
						String[] order1=new String[200];
						String[] order2=new String[200];
						String[] order3=new String[200];
						String[] order4=new String[200];
						Vector std_cost=new Vector();
						Vector fin_cost=new Vector();
						Vector run_cost=new Vector();
						Vector setup_cost=new Vector();
						Vector modelx=new Vector();
						String[] ic=new String[200];
						int rows=0;
						int hcount=0;int qtotal=0;int stotal=0;double ttotwt=0; String model=null;String pro=null;
						String mk=null;String qty=null;String width=null;String height=null;String sec=null;
						String lvrfin=null;String totwt=null;String shape=null;String suppt_cond=null;String supports=null;
						String spl_cond=null;String splices=null;String screens=null;String mullqty=null;
						String mull_cond=null;String mull_q=null;float finlib_cost=0;float totfin_cost=0;String win_load="";
						float tcg=0;float dh=0;float dh_rate=0;float ly=0;
						float eh=0;float eh_rate=0;float pm=0;float fc=0;float freight=0;
						float cd=0;float md=0;float sp=0;float pm_rate=0;
float stdComm=0;
float spComm=0;
						float tperim=0;float tarea=0;float tsarea=0;float dollarsf=0;float yield=0;	float tLinFt=0;
						double md_tot=0.0;double ld_tot=0.0;double lh_tot=0.0;double fd_tot=0.0;
						float mat_final_d=0;float lab_final_d=0;float fin_final_d=0;float labhr_final_d=0;double catchall=0.0;
						double catchallwt=0.0;String catchall_desc="_";	double crated_weight=0.0;
						String finlab_cost= null;String totfan_cost= null;
						String extcostlb=null;String line_item_desc="";double install=0.0;double total_price=0.0;
						String exportCrate="";
						String alob="";String alom="";String horizsplc="";
						String pInfCATCHALL_DESC1="";
						String pInfCATCHALL_DESC2="";
						String pInfCATCHALL_DESC3="";
						String pInfCATCHALL_DESC4="";
						String pInfCATCHALL_DESC5="";
						double pInfCATCHALL1=0.0;
						double pInfCATCHALL2=0.0;
						double pInfCATCHALL3=0.0;
						double pInfCATCHALL4=0.0;
						double pInfCATCHALL5=0.0;
						double pInfCATCHALLWT1=0.0;
						double pInfCATCHALLWT2=0.0;
						double pInfCATCHALLWT3=0.0;
						double pInfCATCHALLWT4=0.0;
						double pInfCATCHALLWT5=0.0;
						DecimalFormat for1=new DecimalFormat("#.##");
						DecimalFormat for12=new DecimalFormat("#.##");
						for12.setMaximumFractionDigits(2);
						for12.setMinimumFractionDigits(2);
						NumberFormat for0 = NumberFormat.getInstance();
						for0.setMaximumFractionDigits(0);
						DecimalFormat for3=new DecimalFormat("#.###");
						if (myResult !=null){
							while (myResult.next()){
								order1[rows] = myResult.getString("product_id");
								order2[rows] = myResult.getString("config_string");
								order3[rows] = myResult.getString("speed_number");
								order4[rows] = myResult.getString("doc_line");
								//	out.println(order4[rows]+"eorder items<BR>");
								rows++;
							}
						}
						int rows_c=0;
						if (myResult2 !=null){
							while (myResult2.next()){
								std_cost.addElement(myResult2.getString("std_cost"));
								fin_cost.addElement(myResult2.getString("fin_cost"));
								run_cost.addElement(myResult2.getString("run_cost"));
								setup_cost.addElement(myResult2.getString("setup_cost"));
								modelx.addElement(myResult2.getString("model"));
								//out.print("std "+std_cost.elementAt(rows_c)+"fin "+fin_cost.elementAt(rows_c)+" cs costing<br>");
								rows_c++;
							}
						}
						// out.print("the isze"+std_cost.size()+"<br>");
						int row_n=0;
						if (myResult1 !=null){
							while (myResult1.next()){
								ic[row_n] = myResult1.getString("doc_line");
								//out.print(ic[row_n]+" eorder Items 2<br>");
								row_n++;
							}
						}
						myResult.close();
						myResult1.close();
						myResult2.close();
						//out.println(tcg+" before<BR>");
						String acQ="";
						if(temp){
							//out.println("HERE1<BR>");
							acQ="Select * from cs_access_central where order_no like '"+onumber +"'";
						}
						else{
							acQ="Select * from cs_access_central where order_no like '"+onumber +"' and section_no = 's"+(counter+1)+"'";
						}
						ResultSet rsAc=stmt.executeQuery(acQ);
						if(rsAc != null){
							while(rsAc.next()){
								if(rsAc.getString("ac_desc") != null){
									line_item_desc=rsAc.getString("ac_desc");
								}
								//out.println(" inside query<br>");
								city=rsAc.getString("city").toString();
								state=rsAc.getString("state").toString();
out.println("<p align='center'><b>"+city+" "+state+"</b></p>");
								total_price=(new Double(rsAc.getString("pinftotal").toString()).doubleValue());
								tcg=Float.valueOf(rsAc.getString("pinfcost")).floatValue();
								install=(new Double(rsAc.getString("pinfinstall")).doubleValue());
								dh=Float.valueOf(rsAc.getString("pinfdhours")).floatValue();
								ly=Float.valueOf(rsAc.getString("pinflhours")).floatValue();
								eh=Float.valueOf(rsAc.getString("pinfehours")).floatValue();
								pm=Float.valueOf(rsAc.getString("pinfpmhours")).floatValue();
								fc=Float.valueOf(rsAc.getString("pinffc")).floatValue();
								freight=Float.valueOf(rsAc.getString("pinffreight")).floatValue();
								cd=Float.valueOf(rsAc.getString("pinfcommdollars")).floatValue();
stdComm=Float.valueOf(rsAc.getString("pinfSTDcommPerc")).floatValue();
spComm=Float.valueOf(rsAc.getString("pinfKACommPerc")).floatValue();
								md=Float.valueOf(rsAc.getString("pinfmargdollars")).floatValue();
								sp=Float.valueOf(rsAc.getString("pinfsellprice")).floatValue();
								dollarsf=Float.valueOf(rsAc.getString("pinddollarsf")).floatValue();
								yield=Float.valueOf(rsAc.getString("pindyield")).floatValue();
								catchall=(new Double(rsAc.getString("pinfcatchall")).doubleValue());
								catchallwt=(new Double(rsAc.getString("pinfcatchallwt")).doubleValue());
								if(rsAc.getString("pinfcatchall_desc") != null){
									catchall_desc=rsAc.getString("pinfcatchall_desc");
								}
								crated_weight=((new Double(rsAc.getString("pindtotwt")).doubleValue()));
//+(new Double(rsAc.getString("pinfcatchallwt")).doubleValue())*1.2);
								pInfCATCHALL_DESC1=rsAc.getString("pinfCATCHALL_DESC1");
								pInfCATCHALL_DESC2=rsAc.getString("pinfCATCHALL_DESC2");
								pInfCATCHALL_DESC3=rsAc.getString("pinfCATCHALL_DESC3");
								pInfCATCHALL_DESC4=rsAc.getString("pinfCATCHALL_DESC4");
								pInfCATCHALL_DESC5=rsAc.getString("pinfCATCHALL_DESC5");
								if(rsAc.getString("pInfcatchall1")!= null){
									pInfCATCHALL1=(new Double(rsAc.getString("pInfcatchall1")).doubleValue());
								}
								if(rsAc.getString("pInfcatchall2")!= null){
									pInfCATCHALL2=(new Double(rsAc.getString("pInfcatchall2")).doubleValue());
								}
								if(rsAc.getString("pInfcatchall3")!= null){
									pInfCATCHALL3=(new Double(rsAc.getString("pInfcatchall3")).doubleValue());
								}
								if(rsAc.getString("pInfcatchall4")!= null){
									pInfCATCHALL4=(new Double(rsAc.getString("pInfcatchall4")).doubleValue());
								}
								if(rsAc.getString("pInfcatchall5")!= null){
									pInfCATCHALL5=(new Double(rsAc.getString("pInfcatchall5")).doubleValue());
								}
								if(rsAc.getString("pInfCATCHALLWT1")!= null){
									pInfCATCHALLWT1=(new Double(rsAc.getString("pInfCATCHALLWT1")).doubleValue());
								}
								if(rsAc.getString("pInfCATCHALLWT2")!= null){
									pInfCATCHALLWT2=(new Double(rsAc.getString("pInfCATCHALLWT2")).doubleValue());
								}
								if(rsAc.getString("pInfCATCHALLWT3")!= null){
									pInfCATCHALLWT3=(new Double(rsAc.getString("pInfCATCHALLWT3")).doubleValue());
								}
								if(rsAc.getString("pInfCATCHALLWT4")!= null){
									pInfCATCHALLWT4=(new Double(rsAc.getString("pInfCATCHALLWT4")).doubleValue());
								}
								if(rsAc.getString("pInfCATCHALLWT5")!= null){
									pInfCATCHALLWT5=(new Double(rsAc.getString("pInfCATCHALLWT5")).doubleValue());
								}
								if(rsAc.getString("export")!=null){
									exportCrate=rsAc.getString("pinfexportcrate");
								}
							}
						}
						rsAc.close();
						//out.println(tcg+" after<BR>");
						ResultSet rsDefault = stmt.executeQuery("select hrrate,enghrrate,pmhrrate from cs_defaults where product_id like '"+product_id+"' and warhse = '2'");
						if(rsDefault != null){
							while(rsDefault.next()){
								eh_rate=Float.valueOf(rsDefault.getString("hrrate")).floatValue();
								dh_rate=Float.valueOf(rsDefault.getString("hrrate")).floatValue();
								pm_rate=Float.valueOf(rsDefault.getString("pmhrrate")).floatValue();
							}
						}
						rsDefault.close();

						if (rows>0){

							out.println("<tr><Td><b><font size=2> "+sectionNames[counter].trim()+"</font></b></td></tr>");
							if(product_id.equals("GRILLE")){
								out.println("<table border='0' align='center' width='100%'>");

							}
							else{
				%>
				<%@ include file="report_summary_header1.html"%>
				<%
			}

			for (int m1=0;m1<row_n;m1++){
				//mat_final_d=0;lab_final_d=0;labhr_final_d=0;fin_final_d=0;tsarea=0;tperim=0;tLinFt=0;mat_final_d=0;lab_final_d=0;fin_final_d=0;labhr_final_d=0;qtotal=0;stotal=0;
				//ttotwt=0;tarea=0;
				//outer for loop
				for (int m=0;m<rows;m++){ //inner for loop//
//out.println(m+"<BR>");
					if  ((order4[m].equals(ic[m1]))){
						//out.println(m1+"::<BR>");



						//out.println(order1[m]+"::"+order4[m]+"::"+modelx.elementAt(m1)+"HERE<br>");
						if(modelx.elementAt(m1).equals("MODULAR")){
							isModular=true;
							isMyriad=false;
						}
						else if(modelx.elementAt(m1).toString().startsWith("MYR")){
							isMyriad=true;
							isModular=false;
						}
						else{
							isModular=false;
							isMyriad=false;
						}

						if(product_id.equals("GRILLE")){
							//out.println("<BR><BR>here<B><BR>");
							if(isModular||isMyriad){
							//out.println("<BR><BR>here2<B><BR>");
								if(!wasModular||m1==0){
								//out.println("<BR><BR>here3<B><BR>");
				%>
				<%@ include file="report_summary_header1_grille_modular.html"%>
				<%
			}
			wasModular=true;
		}
		else{
		//out.println("<BR><BR>here4<B><BR>");
			if(wasModular||m1==0){
			//out.println("<BR><BR>here5<B><BR>");
				%>
				<%@ include file="report_summary_header1_grille.html"%>
				<%
			}
			wasModular=false;
		}
	}

	if(order1[m].equals("ACCESS_CENTRAL")){

	}// end of the product group if else loop

	else if(order1[m].equals("BV")){

			finlab_cost="0";
			totfan_cost="0";


//FINLIB_COST
			int finlin_c=order2[m].indexOf("FINLABCOST[");
			if (finlin_c >=0 ){
				int finlin_ci=order2[m].indexOf("]",finlin_c);
				finlab_cost=order2[m].substring(finlin_c+11,finlin_ci);
				finlib_cost=finlib_cost+((new Float(finlab_cost)).floatValue());
				//									out.println(tperim+"<br>");
			}
			else{
				finlab_cost="0";
				finlib_cost=finlib_cost+((new Float(finlab_cost)).floatValue());
				//									out.println(tperim+"</br>");
			}
			//TOTFINCOST
			int totfin_c=order2[m].indexOf("TOTFINCOST[");
			if (totfin_c >=0 ){
				int finlin_ci=order2[m].indexOf("]",totfin_c);
				totfan_cost=order2[m].substring(totfin_c+11,finlin_ci);
				totfin_cost=totfin_cost+((new Float(totfan_cost)).floatValue());
				//									out.println(tperim+"<br>");
			}
			else{
				totfan_cost="0";
				totfin_cost=totfin_cost+((new Float(totfan_cost)).floatValue());
				//									out.println(tperim+"</br>");
			}



			//out.println("1xx");
			//Model
			int n1=order2[m].indexOf("BVMODEL");
			if (n1 >=0 ){
				int n2=order2[m].indexOf("]",n1);
				model=order2[m].substring(n1+8,n2);
				//				out.println("The first "+"yes"+n1+":"+n2+": : "+model+"<br>");
				//out.println("<font face='Courier' size='-2'>");
				out.println("<tr><td width='6%' align='center'>"+model+"</td>");
				//out.println("</font>");
			}
			else{
				model="NONE";
				//							out.println("The first "+"nos"+model+"<br>");
				out.println("<tr><td width='6%' align='center'>"+model+"</td>");
			}

			// Mark	Design
			int na=order2[m].indexOf("BVMK[");

			if (na >=0 ){

				int nb=order2[m].indexOf("]",na);
				//out.println(na+"::"+nb);
				//out.println(order2[m].substring(na,nb)+"::<BR>");

				mk=order2[m].substring(na+5,nb);
				//							out.println("The make "+"yes "+mk+"<br>");
				//out.println("<font  size='-6' face='arial'>");
				out.println("<td width='6%' align='center'>"+mk+"</td>");
				//out.println("</font>");


			}
			else{
				mk="NONE";
				//							out.println("The mkaeno "+"nos"+mk+"<br>");
				out.println("<td width='6%' align='center'>"+mk+"</td>");
			}

			// Item no
			//					out.println("<td width='6%' align='center'>"+order4[m].toString()+"</td>");
			// Width
			int nw=order2[m].indexOf("BVWIDTH");
			if (nw >=0 ){
				int nw1=order2[m].indexOf("]",nw);
				width=order2[m].substring(nw+8,nw1);
				out.println("<td width='6%' align='center'>"+width+"</td>");
			}
			else{
				width="0";
				out.println("<td width='6%' align='center'>"+width+"</td>");
			}

			//	Height
			int nh=order2[m].indexOf("BVHEIGHT");
			if (nh >=0 ){
				int nh1=order2[m].indexOf("]",nh);
				height=order2[m].substring(nh+9,nh1);
				out.println("<td width='6%' align='center'>"+height+"</td>");
			}
			else{
				height="0";
				out.println("<td width='6%' align='center'>"+height+"</td>");
			}
			// QTY
			int nq=order2[m].indexOf("QUANTITY");
			if (nq >=0 ){
				int nq1=order2[m].indexOf("]",nq);
				qty=order2[m].substring(nq+9,nq1);
				out.println("<td width='6%' align='center'>"+((new Float(qty)).intValue())+"</td>");
			}
			else{
				qty="0";
				out.println("<td width='6%' align='center'>"+qty+"</td>");
			}
			// finish
			int nf=order2[m].indexOf("BVFINISH");
			if (nf >=0 ){
				int nf1=order2[m].indexOf("&",nf);
				lvrfin=order2[m].substring(nf+9,nf1);
				out.println("<td width='6%' align='center'>"+lvrfin+"</td>");
			}
			else{
				lvrfin="NONE";
				out.println("<td width='6%' align='center'>"+lvrfin+"</td>");
			}
			//SILLACC
			out.println("<td width='6%' align='center'>"+"--"+"</td>");
			// Sections
			sec="1.0";
			out.println("<td width='3%' align='center'>"+((new Float(sec)).intValue())+"</td>");
			//TOTWEIGHT
			int nt=order2[m].indexOf("TOTBVWT");
			if (nt >=0 ){
				int nt1=order2[m].indexOf("]",nt);
				totwt=order2[m].substring(nt+8,nt1);
				ttotwt=ttotwt+((new Float(totwt)).intValue());
				out.println("<td width='6%' align='center'>"+((new Float(totwt)).intValue())+"</td>");
			}
			else{
				//out.println("<td width='6%' align='center'>0.0</td>");
			}
			// Mullion condition
			out.println("<td width='6%' align='center'>"+"--"+"</td>");
			// Structural condition
			out.println("<td width='6%' align='center'>"+"--"+"</td>");
			//Splices cond
			out.println("<td width='6%' align='center'>"+"--"+"</td>");
			out.println("</tr>");
			// Screens
			out.println("<tr>");
			out.println("<td width='6%'  colspan='5' align='left'>&nbsp;&nbsp;&nbsp;<b> SCREEN: </b><i>7X7 MESH</i></font></td>");
			out.println("<td width='6%'  colspan='3' align='left'><b> SHAPE:</b>RECT</font></td>");
			out.println("</tr>");
			qtotal=qtotal+((new Float(qty)).intValue());
			stotal=stotal+(((new Float(sec)).intValue())*(new Float(qty)).intValue());
			int totcost_lb=order2[m].indexOf(",EXTCOSTLB[");
			if (totcost_lb >=0 ){
				int finlin_ci=order2[m].indexOf("]",totcost_lb);
				extcostlb=order2[m].substring(totcost_lb+11,finlin_ci);
				//									totfin_cost=totfin_cost+((new Float(totfan_cost)).floatValue());
				//									out.println(tperim+"<br>");
			}
			else{
				extcostlb="0";
				//			totfin_cost=in_cost+((new Float(totfan_cost)).floatValue());
				//									out.println(tperim+"</br>");
			}
			// Next row

			String tempcost="";
			int startcost=order2[m].indexOf(",DISPLAYCOST[");
			if(startcost<1){
				startcost=order2[m].indexOf("CALC/DISPLAYCOST[")+5;
			}
			if(startcost>=0){
				int endcost=order2[m].indexOf("]",startcost);
				tempcost=order2[m].substring(startcost+11,endcost);
				//out.println(tempcost+"::a display cost<BR>");
			}
			else{
				//out.println("a no display cost<BR>");
			}

			out.println("<tr>");
			float matd=(Float.parseFloat((std_cost.elementAt((m1)).toString()))-Float.parseFloat((fin_cost.elementAt((m1)).toString())));
			mat_final_d=mat_final_d+matd;
			out.println("<td width='6%' colspan='2' align='center' valign='CENTER'> "+"Material $ "+for1.format(matd)+"</font></td>");
			//out.println(run_cost.elementAt(m1).toString()+"::"+setup_cost.elementAt(m1).toString()+"::"+finlab_cost+":::<BR>");
			float labd=((Float.parseFloat((run_cost.elementAt((m1)).toString()))+Float.parseFloat((setup_cost.elementAt((m1)).toString())))-(Float.parseFloat(finlab_cost)));
			lab_final_d=lab_final_d+labd;
			double laborRate=0;
			int laborRate_c=order2[m].indexOf("LABOR_RATE[");
			if (laborRate_c >=0 ){
				int laborRate_ci=order2[m].indexOf("]",laborRate_c);
				laborRate=new Double(order2[m].substring(laborRate_c+11,laborRate_ci)).doubleValue();
			}
			else{
				laborRate=23;
			}
			labhr_final_d=(lab_final_d/(float) laborRate);
			out.println("<td width='6%' colspan='2' align='left' valign='CENTER'> "+"Labor $"+for1.format(labd)+"</font></td>");
			out.println("<td width='6%' colspan='2' align='left' valign='left'> "+"Labor Hours "+for1.format((labd/laborRate))+"</font></td>");
			//out.println(finlab_cost+"::"+totfan_cost+"::HERE<BR>");
			float totfind=((Float.parseFloat(finlab_cost))+(Float.parseFloat(totfan_cost)));
			fin_final_d=fin_final_d+totfind;
			//out.println("HERE<BR><bR><br>");
			float totlvrd=(matd+labd+totfind);
			if(isModular||isMyriad){
				String tempConfig=order2[m];
				int start1=tempConfig.indexOf("CALC/");
				if(start1>=0){
					int end1=tempConfig.indexOf("&",start1);
					if(end1>0){
						tempConfig=tempConfig.substring(start1+5,end1);
					}
					else{
						tempConfig=tempConfig.substring(start1+5);
					}
				}
				String TOTALWT="";
				int totWt=tempConfig.indexOf("TOTWT[");
				if(totWt>0){
					int endTotWt=tempConfig.indexOf("]",totWt);
					TOTALWT=tempConfig.substring(totWt+6,endTotWt);
					ttotwt=ttotwt+((new Float(TOTALWT)).floatValue());
					out.println("<td width='6%' colspan='2' align='center' valign='CENTER'>Weight "+for0.format(new Double(TOTALWT).doubleValue())+"</td>");
				}

			}
			else{
				if(product_id.equals("GRILLE")){
					String result="";
					int ntt=order2[m].indexOf("BLDDIR");
					if (ntt >=0 ){
						int nt1=order2[m].indexOf("]",ntt);
						result=order2[m].substring(ntt+7,nt1);
					}
					out.println("<td width='6%' colspan='2' align='center' valign='CENTER'>Blade Direct: "+result+"</td>");
				}
				else{
					out.println("<td width='6%' colspan='2' align='center' valign='CENTER'>"+"H-Splice:"+horizsplc+"</td>");
				}
			}
			out.println("<td width='6%' colspan='2' align='center' valign='CENTER' nowrap> "+"Finishing $ "+for1.format(totfind)+"</font></td>");
			out.println("<td width='6%' colspan='2' align='center' valign='CENTER'> "+"Total Cost $ "+for1.format(totlvrd)+"</font></td>");
			out.println("</tr>");
			out.println("<tr><td width='6%' colspan='14' align='center' valign='CENTER'>"+"________________________________________________________________________________________________________________________"+"</td></tr>");

		}// IF else loop

		else{



			//Model
			int n1=order2[m].indexOf("MODEL1");
			if (n1 >=0 ){
				int n2=order2[m].indexOf("]",n1);
				model=order2[m].substring(n1+7,n2);
				//							out.println("The first "+"yes"+n1+":"+n2+": : "+model+"<br>");
				//out.println("<font face='Courier' size='-6'>");
				out.println("<tr><td width='6%' align='center'>"+model+"</td>");
				//out.println("</font>");
			}
			else{
				model="NONE";
				//							out.println("The first "+"nos"+model+"<br>");
				out.println("<td width='6%' align='center'>"+model+"</td>");
			}
			// Mark	Design
			int na=order2[m].indexOf("MK[");
			if (na >=0 ){
				int nb=order2[m].indexOf("]",na);
				mk=order2[m].substring(na+3,nb);
				//							out.println("The make "+"yes "+mk+"<br>");
				//out.println("<font  size='-6' face='arial'>");
				out.println("<td width='6%' align='center'>"+mk+"</td>");
				//out.println("</font>");
			}
			else{
				mk="NONE";
				//							out.println("The mkaeno "+"nos"+mk+"<br>");
				out.println("<td width='6%' align='center'>"+mk+"</td>");
			}
			// Item no
			//					out.println("<td width='6%' align='center'>"+order4[m].toString()+"</td>");
			// Width
			int nw=order2[m].indexOf("OW_FRAC");
			if (nw >=0 ){
				int nw1=order2[m].indexOf("]",nw);
				width=order2[m].substring(nw+8,nw1);
				out.println("<td width='6%' align='center'>"+width+"</td>");
			}
			else{
				width="0";
				out.println("<td width='6%' align='center'>"+width+"</td>");
			}
			//	Height
			int nh=order2[m].indexOf("OH_FRAC");
			if (nh >=0 ){
				int nh1=order2[m].indexOf("]",nh);
				height=order2[m].substring(nh+8,nh1);
				out.println("<td width='6%' align='center'>"+height+"</td>");
			}
			else{
				height="0";
				out.println("<td width='6%' align='center'>"+height+"</td>");
			}
			// QTY
			//out.println(order1[m]+"::<BR>");
			if(order1[m].equals("GEN")){
				int nq=order2[m].indexOf(",QTYS[");
				if (nq >=0 ){
					int nq1=order2[m].indexOf("]",nq);
					qty=order2[m].substring(nq+6,nq1);
					out.println("<td width='6%' align='center'>"+((new Float(qty)).intValue())+"</td>");
				}
				else{
					qty="0";
					out.println("<td width='6%' align='center'>"+qty+"</td>");
				}
			}
			else{
				int nq=order2[m].indexOf(",QTY[");
				if (nq >=0 ){
					int nq1=order2[m].indexOf("]",nq);
					qty=order2[m].substring(nq+5,nq1);
					out.println("<td width='6%' align='center'>"+((new Float(qty)).intValue())+"</td>");
				}
				else{
					qty="0";
					out.println("<td width='6%' align='center'>"+qty+"</td>");
				}
			}

			// finish
			int nf=order2[m].indexOf("LVRFIN");
			if (nf >=0 ){
				int nf1=order2[m].indexOf("]",nf);
				lvrfin=order2[m].substring(nf+7,nf1);
				out.println("<td width='6%' align='center'>"+lvrfin+"</td>");
			}
			else{
				lvrfin="NONE";
				out.println("<td width='6%' align='center'>"+lvrfin+"</td>");
			}

			//SILLACC
			if(product_id.equals("GRILLE")){
				if(isModular){
					String horizcell="";
					String vertcell="";
					int ns2=order2[m].indexOf("HORIZCELL");
					if (ns2 >=0 ){
						int ns1=order2[m].indexOf("]",ns2);
						sec=order2[m].substring(ns2+10,ns1);
						horizcell=sec;
					}
					int ns=order2[m].indexOf("VERTCELL");
					if (ns >=0 ){
						int ns1=order2[m].indexOf("]",ns);
						sec=order2[m].substring(ns+9,ns1);
						vertcell=sec;
					}
					String result=""+new Double(horizcell).doubleValue()*new Double(vertcell).doubleValue();
					out.println("<td width='6%' align='center'>"+horizcell+"&quot;   x "+vertcell+"&quot;   </td>");
				}
				else if(isMyriad){
					String horizcell="";
					String vertcell="";
					int ns2=order2[m].indexOf("HORIZCELL");
					if (ns2 >=0 ){
						int ns1=order2[m].indexOf("]",ns2);
						sec=order2[m].substring(ns2+10,ns1);
						horizcell=sec;
					}
					int ns=order2[m].indexOf("VERTCELL");
					if (ns >=0 ){
						int ns1=order2[m].indexOf("]",ns);
						sec=order2[m].substring(ns+9,ns1);
						vertcell=sec;
					}
					String result=""+new Double(horizcell).doubleValue()*new Double(vertcell).doubleValue();
					out.println("<td width='6%' align='center'>"+horizcell+"&quot;   x "+vertcell+"&quot;   </td>");
				}
				else{
					int bs=order2[m].indexOf("BLDSPC");
					String bldspc="";
					if(bs >=0){
						int bs2=order2[m].indexOf("]",bs);
						bldspc=order2[m].substring(bs+7,bs2);
					}
					else{
						bldspc="0";
					}
					out.println("<td width='6%' align='center'>"+bldspc+"</td>");
				}
				int ns2=order2[m].indexOf("/SECTS");
				if(ns2<0){
					ns2=order2[m].indexOf(",SECTS");
				}

					if (ns2 >=0 ){
						int ns1x=order2[m].indexOf("]",ns2);
						sec=order2[m].substring(ns2+7,ns1x);
						//out.println("<td width='3%' align='center'>"+((new Float(sec)).intValue())+"</td>");
					}
			}
			else{
				int sill=order2[m].indexOf("/SILLACC");
				if (sill >=0 ){
					out.println("<td width='6%' align='center'>"+"Yes"+"</td>");
				}else{
					sill=order2[m].indexOf(",SILLACC");
					if (sill >=0 ){
						out.println("<td width='6%' align='center'>"+"Yes"+"</td>");
					}else{
						out.println("<td width='6%' align='center'>"+"NO"+"</td>");
					}
				}
			}
			// Sections

			if(product_id.equals("GRILLE")){
				if(isModular){
					int ns=order2[m].indexOf("HORIZTHICK");
					if (ns >=0 ){
						int ns1=order2[m].indexOf("]",ns);
						sec=order2[m].substring(ns+11,ns1);
						out.println("<td width='3%' align='center'>"+for3.format(new Double(sec).doubleValue())+"&quot; </td>");
					}
					else{
						sec="0";
						out.println("<td width='6%' align='center'>"+sec+" new setup</td>");
					}
				}
				else if(isMyriad){
					int ns=order2[m].indexOf("MYRBLDTHK/");
					if(ns >=0){
						int ns1=order2[m].indexOf("&",ns);
						String thick=order2[m].substring(ns+10,ns1);
						out.println("<td width='3%' align='center'>0."+thick+"&quot </td>");
					}
					else{
						out.println("<td width='6%' align='center'>&nbsp;</td>");
					}
				}
				else{
					int ns=order2[m].indexOf("RUN1SIDES");
					if (ns >=0 ){
						int ns1=order2[m].indexOf("]",ns);
						sec=order2[m].substring(ns+10,ns1);
						String hex = sec;
						int valuex = Integer.parseInt(hex, 16);
						sec=""+valuex;
						out.println("<td width='3%' align='center'>"+valuex+"</td>");
					}
					else{
						sec="0";
						out.println("<td width='6%' align='center'>"+sec+"</td>");
					}
				}
				int ns2=order2[m].indexOf("/SECTS");
				if(ns2<0){
					ns2=order2[m].indexOf(",SECTS");
				}

					if (ns2 >=0 ){
						int ns1x=order2[m].indexOf("]",ns2);
						sec=order2[m].substring(ns2+7,ns1x);
						//out.println("<td width='3%' align='center'>"+((new Float(sec)).intValue())+"</td>");
					}
			}
			else{

				int ns=order2[m].indexOf("/SECTS");
				if(ns<0){
					ns=order2[m].indexOf(",SECTS");
				}

					if (ns >=0 ){
						int ns1=order2[m].indexOf("]",ns);
						sec=order2[m].substring(ns+7,ns1);
						out.println("<td width='3%' align='center'>"+((new Float(sec)).intValue())+"</td>");
					}
					else{
						sec="0";
						out.println("<td width='6%' align='center'>"+sec+"</td>");
					}

			}

			//TOTWEIGHT
			if(isModular){
				int nt=order2[m].indexOf("HORIZDEPTH");
				if (nt >=0 ){
					int nt1=order2[m].indexOf("]",nt);
					totwt=order2[m].substring(nt+11,nt1);
					//ttotwt=ttotwt+((new Float(totwt)).intValue());
					out.println("<td width='6%' align='center'>"+((new Float(totwt)))+"</td>");
				}
			}
			else if(isMyriad){
				int nt=order2[m].indexOf("GDEPTH");
				if (nt >=0 ){
					int nt1=order2[m].indexOf("]",nt);
					totwt=order2[m].substring(nt+7,nt1);
					//ttotwt=ttotwt+((new Float(totwt)).intValue());
					out.println("<td width='6%' align='center'>"+((new Float(totwt)).intValue())+"</td>");
				}
			}
			else{
				int nt=order2[m].indexOf("TOTWT");
				if (nt >=0 ){
					int nt1=order2[m].indexOf("]",nt);
					totwt=order2[m].substring(nt+6,nt1);
					ttotwt=ttotwt+((new Float(totwt)).intValue());
					out.println("<td width='6%' align='center'>"+((new Float(totwt)).intValue())+"</td>");
				}
				else{
					//out.println("<td width='6%' align='center'>0.0</td>");
				}
			}
			//SHAPE

			int n_sp=order2[m].indexOf("SHAPE/");
			if (n_sp >=0 ){
				int n_sp1=order2[m].indexOf("&",n_sp);
				shape=order2[m].substring(n_sp+6,n_sp1);
				//	out.println("<td width='6%' align='center'>"+shape+"</td>");
			}
			else{
				shape="NONE";
				//	out.println("<td width='6%' align='center'>"+shape+"</td>");
			}
			//SPEED NO
			if (order3[m].length()!=0){
				//								out.println("<td width='6%' nowrap align='center'>"+order3[m]+"</td>");
			}
			else{
				//	   							out.println("<td width='6%' nowrap align='center'>"+"-"+"</td>");
			}



			if(isModular){
				int nt=order2[m].indexOf("HORIZANGLE");
				if (nt >=0 ){
					int nt1=order2[m].indexOf("]",nt);
					totwt=order2[m].substring(nt+11,nt1);
			//		ttotwt=ttotwt+((new Float(totwt)).intValue());
					out.println("<td width='6%' align='center'>"+((new Float(totwt)).intValue())+"</td>");
				}
			}
			else if(isMyriad){
				int nt=order2[m].indexOf("BLADEDEG");
				if (nt >=0 ){
					int nt1=order2[m].indexOf("]",nt);
					totwt=order2[m].substring(nt+9,nt1);
			//		ttotwt=ttotwt+((new Float(totwt)).intValue());
					out.println("<td width='6%' align='center'>"+((new Float(totwt)).intValue())+"</td>");
				}
			}

			else{
				// Mullion condition
				int mull=order2[m].indexOf("MULL_COND");
				if (mull >=0 ){
					double here=0;
					int lvrmull_qtyx=order2[m].indexOf(",EXPMULLS[");
					if (lvrmull_qtyx >=0 ){
						int struu_qtyx=order2[m].indexOf("]",lvrmull_qtyx);
						String mullqtyx=order2[m].substring(lvrmull_qtyx+10,struu_qtyx);
						if(mullqtyx.trim().length()>0){	here=new Double(mullqtyx).doubleValue();	}
					}
					if(here>0){
						int mullu=order2[m].indexOf("]",mull);
						mull_cond=order2[m].substring(mull+10,mullu);
						out.println("<td width='6%' align='center'>"+mull_cond+"|"+"");
					}
					else{
						mull_cond="NONE";
						out.println("<td width='6%' align='center'>"+mull_cond+"|"+"");
					}
				}
				else{
					mull_cond="NONE";
					out.println("<td width='6%' align='center'>"+mull_cond+"|"+"");
				}
				//old code taken out Dec 6 07 by Greg
				// to take care of mullion condition with not mullion qty.

				// Mullion Quantity is sections -1 from john
				// the above is wrong and it is now as
				// New mullion quantity definiton from johon may 19'03
				int startMull=order2[m].indexOf("CALC/");
				int lvrmull_qty=order2[m].substring(startMull).indexOf(",EXPMULLS[");
				if (lvrmull_qty >=0 ){
					lvrmull_qty=lvrmull_qty+startMull;
					int struu_qty=order2[m].indexOf("]",lvrmull_qty);
					mullqty=order2[m].substring(lvrmull_qty+10,struu_qty);
					out.println(""+((new Float(mullqty)).intValue())+"");
				}
				else if (lvrmull_qty == -1 ){
					out.println(""+"0"+"");
				}
				else{
					mullqty="0";
					out.println(""+mullqty+"");
				}
				out.println("</td>");
			}

			if(isModular){
				int nt=order2[m].indexOf("MODFRAMES");
				if (nt >=0 ){
					int nt1=order2[m].indexOf("&",nt);
					totwt=order2[m].substring(nt+10,nt1);
					//ttotwt=ttotwt+((new Float(totwt)).intValue());
					out.println("<td width='6%' align='center'>"+totwt+"");
				}
			}
			else if(isMyriad){
				int nt=order2[m].indexOf("MYRFRAMES");
				if (nt >=0 ){
					int nt1=order2[m].indexOf("&",nt);
					totwt=order2[m].substring(nt+10,nt1);
					//ttotwt=ttotwt+((new Float(totwt)).intValue());
					out.println("<td width='6%' align='center'>"+totwt+"");
				}								}
			else{

				// Structural condition
				int start1=order2[m].indexOf("CHANNEL/");
				int start2=order2[m].indexOf("ANGLE/");
				//out.println(start1+"::start1<BR>");
				if(start1 >=0){
					int end1=order2[m].substring(start1+6).indexOf("HAN");
					if(end1>=0){
						end1=end1+start1+6;
						//out.println(order2[m].substring(start1+10,end1)+"::HERE<BR>");
						suppt_cond=order2[m].substring(start1+10,end1);
						out.println("<td width='6%' align='center'>"+suppt_cond+"|"+"");
					}
					else{
						suppt_cond="NONE";
						out.println("<td width='6%' align='center'>"+suppt_cond+"|"+"");
					}
				}
				else if(start2>=0){
					int end2=order2[m].substring(start2+8).indexOf("&");
					//out.println(order2[m].substring(start2));
					String test="";
					if(end2 >=0){
						test=order2[m].substring(start2+8, end2+start2+8);
					}
					else{
						test=order2[m].substring(start2+8);
					}
					//out.println(test);
					if(test.trim().length()>0){
						suppt_cond=test;
						out.println("<td width='6%' align='center'>"+suppt_cond+"|"+"");

					}
					else{
						suppt_cond="NONE";
						out.println("<td width='6%' align='center'>"+suppt_cond+"|"+"");
					}
				}
				else{
					int stru=order2[m].indexOf("SUPPT_COND");
					if (stru >=0 ){
						int struu=order2[m].indexOf("]",stru);
							suppt_cond=order2[m].substring(stru+11,struu);
							out.println("<td width='6%' align='center'>"+suppt_cond+"|"+"");
					}
					else{
						suppt_cond="NONE";
						out.println("<td width='6%' align='center'>"+suppt_cond+"|"+"");
					}
					out.println("");
				}

				// Strucural Quantity
				///out.println(order2[m]+"<BR><BR>");
				int stru_qty=order2[m].indexOf(",SUPPORTS[");
				if(stru_qty<0){
					stru_qty=order2[m].indexOf("/SUPPORTS[");
				}
				//out.println(":::::<BR>:::::"+stru_qty+"::::");
				if (stru_qty >=0){
					int struu_qty=order2[m].indexOf("]",stru_qty);
					String test=order2[m].substring(stru_qty,struu_qty);
					if(test.indexOf("[")>=0){
						supports=order2[m].substring(stru_qty+10,struu_qty);
					}
					else{
						supports="0";
					}
					out.println(""+((new Float(supports)).intValue())+"");
				}
				else{
					supports="0";
					out.println(""+supports+"");
				}
			}

			out.println("</td>");

			//Splices cond
			if(isModular||isMyriad){
				String tempConfig=order2[m];
				int start1=tempConfig.indexOf("CALC/");
				if(start1>=0){
					int end1=tempConfig.indexOf("&",start1);
					//out.println(end1+":::<BR>");
					if(end1>0){
						//out.println("HERE");
						tempConfig=tempConfig.substring(start1+5,end1);
					}
					else{
						tempConfig=tempConfig.substring(start1+5);
					}
					//out.println(start1+"::"+end1+"::"+tempConfig);
				}
				int nt2=tempConfig.indexOf("VSPLICE");
				if (nt2 >=0 ){
					int nt1=tempConfig.indexOf("]",nt2);
					totwt=tempConfig.substring(nt2+8,nt1);

					out.println("<td width='6%' align='center'>"+totwt+"|");
				}

				int nt=tempConfig.indexOf("HSPLICE");
				if (nt >=0 ){
					int nt1=tempConfig.indexOf("]",nt);
					totwt=tempConfig.substring(nt+8,nt1);

					out.println(""+totwt+"");
				}
				out.println("</td>");
			}

			else{
				int spl=order2[m].indexOf("SPL_COND");
				if (spl >=0 ){
					int spl_condu=order2[m].indexOf("]",spl);
					spl_cond=order2[m].substring(spl+9,spl_condu);
					out.println("<td width='6%' align='center'>"+spl_cond+"|"+"");
				}
				else{
					spl_cond="NONE";
					out.println("<td width='6%' align='center'>"+spl_cond+"|"+"");
				}
				//out.println("</td>");
				// Splices QTY
				int spli=order2[m].indexOf(",SPLICES");
				if (spli >=0 ){
					int spliu=order2[m].indexOf("]",spli);
					splices=order2[m].substring(spli+9,spliu);
					out.println(""+((new Float(splices)).intValue())+"");
				}
				else if (spli == -1 ){
					splices="0";
					out.println(""+splices+"");
				}
				else{
					splices="0";
					out.println(""+splices+"");
				}
			}
			out.println("</td>");
			out.println("</tr>");



















			// Screens
			//CHANGED TO READING SCRN_BO INSTEAD OF READING SCRNTYPE BY JOHN ON JUN 16

			out.println("<tr>");
			int scri=order2[m].indexOf("SCRN_BO");
			int scri2=order2[m].indexOf("BO_DESC");
			String tempBlankOff="";

			if (scri >=0 ){

				int scriu=order2[m].indexOf("]",scri);
				int scriu2=order2[m].indexOf("]",scri2);
				screens=order2[m].substring(scri+8,scriu);
				tempBlankOff=order2[m].substring(scri2+8,scriu2);
				out.println("<td width='6%' colspan='3' align='left'>&nbsp;&nbsp;&nbsp; <b>SCREEN/BO:</b><i>");
				String tempScreenBo="";
				//out.println(screens+"::"+tempBlankOff);
				if(screens.indexOf("SSINSECT")>=0||tempBlankOff.indexOf("SSINSECT")>=0){
					if(tempScreenBo.trim().length()>0){
						tempScreenBo=tempScreenBo+"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					tempScreenBo=tempScreenBo+" <i> Stainless Steel Insect Screen</i></font>";
				}
				if(screens.indexOf("BIRDINSECT")>=0||tempBlankOff.indexOf("BIRDINSECT")>=0){
					if(tempScreenBo.trim().length()>0){
						tempScreenBo=tempScreenBo+"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					tempScreenBo=tempScreenBo+" <i>Bird & Insect Screen in a single frame</i>"+"</font>";
				}
				if(screens.indexOf("ALINSECT")>=0||tempBlankOff.indexOf("ALINSECT")>=0){
					if(tempScreenBo.trim().length()>0){
						tempScreenBo=tempScreenBo+"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					tempScreenBo=tempScreenBo+" <i> 18 x 16 .011 Dia. Insect Screen</i>"+"</font>";
				}
				if (screens.indexOf("FGINSECT")>=0||tempBlankOff.indexOf("FGINSECT")>=0){
					if(tempScreenBo.trim().length()>0){
						tempScreenBo=tempScreenBo+"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					tempScreenBo=tempScreenBo+" <i> Fiberglass Insect Screen</i>"+"</font></td>";
				}
				if(screens.indexOf("050ALEXP58")>=0||tempBlankOff.indexOf("050ALEXP58")>=0){
					if(tempScreenBo.trim().length()>0){
						tempScreenBo=tempScreenBo+"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					tempScreenBo=tempScreenBo+" <i> 5/8 Exp. Mesh .050 Thk Birdscreen</i>"+"</font>";
				}
				if(screens.indexOf("050ALEXP34")>=0||tempBlankOff.indexOf("050ALEXP34")>=0){
					if(tempScreenBo.trim().length()>0){
						tempScreenBo=tempScreenBo+"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					tempScreenBo=tempScreenBo+" <i> 3/4 Exp. Mesh .050 Thk Birdscreen</i>"+"</font>";
				}
				if(screens.indexOf("047ALINT14")>=0||tempBlankOff.indexOf("047ALINT14")>=0){
					if(tempScreenBo.trim().length()>0){
						tempScreenBo=tempScreenBo+"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					tempScreenBo=tempScreenBo+" <i> 1/4 Intercrimp .047 Dia. Birdscreen</i>"+"</font>";
				}
				if(screens.indexOf("063ALINT12")>=0||tempBlankOff.indexOf("063ALINT12")>=0){
					if(tempScreenBo.trim().length()>0){
						tempScreenBo=tempScreenBo+"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					tempScreenBo=tempScreenBo+" <i> 1/2 Intercrimp .063 Dia. Birdscreen</i>"+"</font>";
				}
				if(screens.indexOf("063SSINT12")>=0||tempBlankOff.indexOf("063SSINT12")>=0){
					if(tempScreenBo.trim().length()>0){
						tempScreenBo=tempScreenBo+"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					tempScreenBo=tempScreenBo+" <i> 1/2 Intercrimp SS .063 Dia. Birdscreen</i>"+"</font>";
				}
				if(screens.indexOf("050SHTBO")>=0||tempBlankOff.indexOf("050SHTBO")>=0){
					if(tempScreenBo.trim().length()>0){
						tempScreenBo=tempScreenBo+"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					tempScreenBo=tempScreenBo+" <i> .050\" Aluminum sheet blankoff</i>"+"</font>";
				}
				if(screens.indexOf("080SHTBO")>=0||tempBlankOff.indexOf("080SHTBO")>=0){
					if(tempScreenBo.trim().length()>0){
						tempScreenBo=tempScreenBo+"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					tempScreenBo=tempScreenBo+" <i> .080\" Aluminum sheet blankoff</i>"+"</font>";
				}
				if(screens.indexOf("125SHTBO")>=0||tempBlankOff.indexOf("125SHTBO")>=0){
					if(tempScreenBo.trim().length()>0){
						tempScreenBo=tempScreenBo+"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					tempScreenBo=tempScreenBo+" <i> .125\" Aluminum sheet blankoff</i>"+"</font>";
				}
				if(screens.indexOf("1INSBO")>=0||tempBlankOff.indexOf("1INSBO")>=0){
					if(tempScreenBo.trim().length()>0){
						tempScreenBo=tempScreenBo+"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					tempScreenBo=tempScreenBo+" <i> 1\" Insulated blankoff</i>"+"</font>";
				}
				if(screens.indexOf("15INSBO")>=0||tempBlankOff.indexOf("15INSBO")>=0){
					if(tempScreenBo.trim().length()>0){
						tempScreenBo=tempScreenBo+"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					tempScreenBo=tempScreenBo+" <i> 1 1/2\" Insulated blankoff</i>"+"</font>";
				}
				if(screens.indexOf("2INSBO")>=0||tempBlankOff.indexOf("2INSBO")>=0){
					if(tempScreenBo.trim().length()>0){
						tempScreenBo=tempScreenBo+"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					tempScreenBo=tempScreenBo+" <i> 2\" Insulated blankoff</i>"+"</font>";
				}
				if(screens.indexOf("25INSBO")>=0||tempBlankOff.indexOf("25INSBO")>=0){
					if(tempScreenBo.trim().length()>0){
						tempScreenBo=tempScreenBo+"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					tempScreenBo=tempScreenBo+" <i> 2 1/2\" Insulated blankoff</i>"+"</font>";
				}
				if(screens.indexOf("3INSBO")>=0||tempBlankOff.indexOf("3INSBO")>=0){
					if(tempScreenBo.trim().length()>0){
						tempScreenBo=tempScreenBo+"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					tempScreenBo=tempScreenBo+" <i> 3\" Insulated blankoff</i>"+"</font>";
				}
				if(screens.indexOf("18GAGALV12")>=0||tempBlankOff.indexOf("18GAGALV12")>=0){
					if(tempScreenBo.trim().length()>0){
						tempScreenBo=tempScreenBo+"<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;";
					}
					tempScreenBo=tempScreenBo+" <i> 1/2\" 18 Gauge Galvanized Intercrimp Mesh Removable Birdscreen</i>"+"</font>";
				}

				out.println(tempScreenBo+"</td>");

			}
			else if(product_id.equals("LVR")){
				out.println("<td width='6%' colspan='3' align='left'>"+"&nbsp;&nbsp;&nbsp;<b>SCREEN/BO: </b>"+"<i>"+"NONE"+"</i>"+"</font></td>");
			}
			else{
				int scri1=order2[m].indexOf("STLCTR_FRAC");
				//out.println("the test"+scri1);
				if(scri1>0){
					int scriu1=order2[m].indexOf("]",scri1);
					screens=order2[m].substring(scri1+12,scriu1);
				}
				else{
					screens="NONE";
				}
				if(!isModular&&!isMyriad){
					out.println("<td width='6%'  colspan='3' align='center'>"+"&nbsp;&nbsp;&nbsp; <b>STEEL CENTERS: </b>"+"<i>"+screens+"</i>"+"</font></td>");
				}
				else{
					out.println("<td width='6%'  colspan='3' align='center'>&nbsp;</td>");
				}
			}
			String contAngle="N";
			String snapCovers="N";

			int a1=order2[m].indexOf("CONTANG/");
			int a2x=order2[m].indexOf("NONECA");
			if(a1>=0  && a2x<0 ){
				contAngle="Y";
			}


			a1=-1;
			a1=order2[m].indexOf("ACC/");
			if(a1 >0){
				String tempConfigString=order2[m].substring(a1);
				int a2=tempConfigString.indexOf("&");
				if(a2>0){
					tempConfigString.substring(0,a2);
				}
				int a3=tempConfigString.indexOf("SNAPON");
				if(a3>=0){
					snapCovers="Y";
				}
			}

			//if(a1>0){
			//	contAngle="Y";
			//}
			out.println("<td>Snap Cov:"+snapCovers+"</td>");
			out.println("<td>Cont Angles:"+contAngle+"</td>");

			// WINLAOD ADDED FROM JOHN ON JUN16'03
			// has to be changed to read ewload on May27'05
			int win=order2[m].indexOf(",EWLOAD[");
			if(win<0){
				win=order2[m].indexOf("/EWLOAD[");
			}
			if (win >=0 ){
				int ns1=order2[m].indexOf("]",win);
				win_load=order2[m].substring(win+8,ns1);
				//								out.println("<td width='6%' align='center' class='tdt' width='10%'>"+((new Float(sys_depth)).intValue())+"</td>");
			}
			else{
				win_load="0";
				//									out.println("<td width='6%' align='center' class='tdt' width='10%'>"+sys_depth+"</td>");
			}

			// adding   ACTWLOAD/ALOB, ACTWLOAD/ALOMS		ADDED ON MAY16'05
			int alobs=order2[m].indexOf("ALOB");
			if (alobs >=0 ){
				int ns1=order2[m].indexOf("]",alobs);
				alob=order2[m].substring(alobs+5,ns1);
			}
			else{
				alob="0";
				//									out.println("<td width='6%' align='center' class='tdt' width='10%'>"+sys_depth+"</td>");
			}
			int aloms=order2[m].indexOf("ALOMS");
			if (aloms >=0 ){
				int ns1=order2[m].indexOf("]",aloms);
				alom=order2[m].substring(aloms+6,ns1);
			}
			else{
				alom="0";
				//									out.println("<td width='6%' align='center' class='tdt' width='10%'>"+sys_depth+"</td>");
			}





			String perimeter="0";
			String sfarea="0";
			int sperim=order2[m].indexOf("TOTPERIM");
			if (sperim >=0 ){
				int perimi=order2[m].indexOf("]",sperim);
				String perim=order2[m].substring(sperim+9,perimi);
				perimeter=perim;
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
				sfarea=area;
				//									out.println(tarea+"<br>");
			}
			else{
				String area="0";
				tarea=tarea+((new Float(area)).floatValue());
				//									out.println(tarea+"</br>");
			}

			// Area
			int lvr=order2[m].indexOf("TOTLVRSF");
			if (lvr >=0 ){
				int lvri=order2[m].indexOf("]",lvr);
				String vt=order2[m].substring(lvr+9,lvri);
				tsarea=tsarea+((new Float(vt)).floatValue());
				sfarea=vt;
				//									out.println(tsarea+"<br>");
			}
			else{
				String vt="0";
				tsarea=tsarea+((new Float(vt)).floatValue());
				//									out.println(tsarea+"</br>");
			}







			if(isModular||isMyriad){
				out.println("<td width='6%'  colspan='4' align='center'>&nbsp;</font>");
			}
			else{
				out.println("<td width='6%'  colspan='4' align='center'><b> PSF: </b>"+win_load+"</font>");
			}
			if(isModular||isMyriad){
				out.println("</td><td width='6%'  colspan='3.5' align='center'>&nbsp;");
			}
			else{
				out.println("&nbsp;&nbsp;&nbsp;<b> RWDI-PSF: </b>"+alob+"</font></td>");

				//out.println("<td width='6%'  colspan='3' align='center'><b> RWDISUPPT: </b>"+alom+"</font>");
//out.println("<td width='6%'  colspan='3' align='center'><b>  EMPTY SPACE: </b>"+"</font>");
			}
out.println("<td colspan='3' align='center'><b>Perimeter:</b>"+((new Float(new Double(perimeter).doubleValue()+0.5)).intValue())+"&nbsp;&nbsp;&nbsp;<b>SF Area:</b>"+((new Float(new Double(sfarea).doubleValue()+0.5)).intValue())+"");
			if(isModular||isMyriad){
				out.println("&nbsp;&nbsp;&nbsp;</td>");
			}
			else{
				out.println("&nbsp;&nbsp;&nbsp;<b> SHAPE: </b>"+shape+"</font></td>");
			}
			out.println("</tr>");

			//FINLIB_COST
			int finlin_c=order2[m].indexOf("FINLABCOST[");

			if (finlin_c >=0 ){
				int finlin_ci=order2[m].indexOf("]",finlin_c);
				finlab_cost=order2[m].substring(finlin_c+11,finlin_ci);
				finlib_cost=finlib_cost+((new Float(finlab_cost)).floatValue());
				//									out.println(tperim+"<br>");
				//out.println(finlab_cost+"::<BR>");
			}
			else{
				finlab_cost="0";
				finlib_cost=finlib_cost+((new Float(finlab_cost)).floatValue());
				//									out.println(tperim+"</br>");
			}
			//out.println(finlib_cost+"::<BR>");
			//TOTFINCOST
			//out.println(totfin_cost+"::<BR>");
			int totfin_c=order2[m].indexOf("TOTFINCOST[");
			if (totfin_c >=0 ){
				int finlin_ci=order2[m].indexOf("]",totfin_c);
				totfan_cost=order2[m].substring(totfin_c+11,finlin_ci);
				totfin_cost=totfin_cost+((new Float(totfan_cost)).floatValue());

				//									out.println(tperim+"<br>");
			}
			else{
				totfan_cost="0";
				totfin_cost=totfin_cost+((new Float(totfan_cost)).floatValue());
				//									out.println(tperim+"</br>");
			}

			//out.println(totfin_cost+":: running finish total<BR>");
			//EXTCOSTLB
			//out.println("aluminum cost "+extcostlb+"<BR>");
			int totcost_lb=order2[m].indexOf(",EXTCOSTLB[");
			if (totcost_lb >=0 ){
				int finlin_ci=order2[m].indexOf("]",totcost_lb);
				extcostlb=order2[m].substring(totcost_lb+11,finlin_ci);
				//									totfin_cost=totfin_cost+((new Float(totfan_cost)).floatValue());
				//									out.println(tperim+"<br>");
			}
			else{
				extcostlb="0";
				//			totfin_cost=in_cost+((new Float(totfan_cost)).floatValue());
				//									out.println(tperim+"</br>");
			}
			String tempcost="";
			int startcost=order2[m].indexOf(",DISPLAYCOST[");
			if(startcost<1){
				startcost=order2[m].indexOf("CALC/DISPLAYCOST[");
				if(startcost>=0){
					startcost=startcost+5;
				}
			}
			else{
				startcost=startcost+1;
			}

			if(startcost>=0){
				int endcost=order2[m].indexOf("]",startcost);
				tempcost=order2[m].substring(startcost+12,endcost);
				startcost=order2[m].indexOf("&CALC/");
				String tempconfig="";
				if(startcost<1){
					startcost=order2[m].substring(0,8).indexOf("CALC/TYPE[");
					if(startcost>=0){
						startcost=startcost;
					}
				}
				else{
					startcost=startcost+1;
				}

				if(startcost>=0){

					tempconfig=order2[m].substring(startcost);
//out.println(order2[m].substring(startcost));
					endcost=tempconfig.indexOf("&");
if(endcost<0){
	endcost=tempconfig.length();
}
					tempconfig=tempconfig.substring(0,endcost);
					startcost=tempconfig.indexOf(",TYPE[");

					if(startcost<0){
						startcost=tempconfig.indexOf("/TYPE[");
					}

					if(startcost>=0){
						tempconfig=tempconfig.substring(startcost+6);
						endcost=tempconfig.indexOf("]");
						tempconfig=tempconfig.substring(0,endcost);
						//out.println(tempconfig+"::"+tempcost+"::<Br>");
						if(tempconfig.equals("1")){
							grillecost=tempcost;
						}
						else if(tempconfig.equals("2")){
							vaccost=tempcost;
						}
						else if(tempconfig.equals("3")){
							rfcost=tempcost;
						}
						else if(tempconfig.equals("4")){
							//out.println(tempconfig+"::ECONOCOST<BR>");
							econocost=tempcost;
						}

					}

				}


			}

			// adding H-Splice as per Pete's request on Mar-4'08
			//HORIZSPLC
			int horizsplc_c=order2[m].indexOf(",HORIZSPLC[");
			if (horizsplc_c >=0 ){
				int horizsplc_ci=order2[m].indexOf("]",horizsplc_c);
				horizsplc=order2[m].substring(horizsplc_c+11,horizsplc_ci);
				//out.println(horizsplc_c+"::"+horizsplc_ci+"<br>");
			}
			else{
				horizsplc="-NA-";
				//									out.println(tperim+"</br>");
			}

			double laborRate=0;
			int laborRate_c=order2[m].indexOf("LABOR_RATE[");
			if (laborRate_c >=0 ){
				int laborRate_ci=order2[m].indexOf("]",laborRate_c);
				laborRate=new Double(order2[m].substring(laborRate_c+11,laborRate_ci)).doubleValue();
			}
			else{
				laborRate=23;
			}
			//out.println(laborRate+":: laborRate");
			out.println("<tr>");

			//out.println("<td width='6%' colspan='1' align='center' valign='CENTER'>"+"&nbsp;&nbsp;"+"</td>");
			float matd=(Float.parseFloat((std_cost.elementAt((m1)).toString()))-Float.parseFloat((fin_cost.elementAt((m1)).toString())));
			mat_final_d=mat_final_d+matd;
			out.println("<td width='6%' colspan='2' align='center' valign='CENTER'> "+"Material $ "+for1.format(matd)+"</font></td>");
			//out.println(run_cost.elementAt(m1).toString()+"::run cost<BR>");
			//out.println(setup_cost.elementAt(m1).toString()+"::setup cost<BR>");
			//out.println(finlab_cost+"::finishing cost<BR>");
			float labd=((Float.parseFloat((run_cost.elementAt((m1)).toString()))+Float.parseFloat((setup_cost.elementAt((m1)).toString())))-(Float.parseFloat(finlab_cost)));
			//out.println(labd+"::labor dollars<BR>>");
			lab_final_d=lab_final_d+labd;

			labhr_final_d=(lab_final_d/(float) laborRate);
			out.println("<td width='6%' colspan='2' align='left' valign='CENTER'> "+"Labor $"+for1.format(labd)+"</font></td>");
			//out.println("<td width='6%' colspan='1' align='center' valign='CENTER'>"+"&nbsp;&nbsp;"+"</td>");
			out.println("<td width='6%' colspan='2' align='left' valign='left'> "+"Labor Hours "+for1.format((labd/laborRate))+"</font></td>");









			float totfind=((Float.parseFloat(finlab_cost))+(Float.parseFloat(totfan_cost)));
			fin_final_d=fin_final_d+totfind;
			float totlvrd=(matd+labd+totfind);
			if(isModular||isMyriad){
				String tempConfig=order2[m];

				//out.println(tempConfig+"<BR><BR>");
				//}
				int start1=tempConfig.indexOf("CALC/");
				if(start1>=0){
					int end1=tempConfig.indexOf("&",start1);
				//	out.println(start1+"::"+end1+":::<BR>");
					if(end1>0){
						//out.println("HERE");
						tempConfig=tempConfig.substring(start1+5,end1);
					}
					else{
						tempConfig=tempConfig.substring(start1+5);
					}
					//out.println(start1+"::"+end1+"::"+tempConfig+"<BR>");
				}
				String TOTALWT="";
				int totWt=tempConfig.indexOf("TOTWT[");

				if(totWt>0){
					int endTotWt=tempConfig.indexOf("]",totWt);
					TOTALWT=tempConfig.substring(totWt+6,endTotWt);
					ttotwt=ttotwt+((new Float(TOTALWT)).floatValue());
			//		out.println(TOTALWT);
					out.println("<td width='6%' colspan='2' align='center' valign='CENTER'>Weight "+for0.format(new Double(TOTALWT).doubleValue())+"</td>");
				}
				else{
					out.println("<td width='6%' colspan='2' align='center' valign='CENTER'>Weight 0.0</td>");
				}

			}
			//else if(isMyriad){
			//	out.println("<td width='6%' align='center'>here5</td>");
			//}

			else{
				if(product_id.equals("GRILLE")){
					String result="";
					int nt=order2[m].indexOf("BLDDIR");
					if (nt >=0 ){
						int nt1=order2[m].indexOf("]",nt);
						result=order2[m].substring(nt+7,nt1);
						//ttotwt=ttotwt+((new Float(totwt)).intValue());
						//out.println("<td width='6%' align='center'>"+((new Float(totwt)).intValue())+"</td>");
					}
					out.println("<td width='6%' colspan='2' align='center' valign='CENTER'>Blade Direct: "+result+"</td>");
				}
				else{
					out.println("<td width='6%' colspan='2' align='center' valign='CENTER'>"+"H-Splice:"+horizsplc+"</td>");
				}
			}
			out.println("<td width='6%' colspan='2' align='center' valign='CENTER' nowrap> "+"Finishing $ "+for1.format(totfind)+"</font></td>");
			out.println("<td width='6%' colspan='2' align='center' valign='CENTER'> "+"Total Cost $ "+for1.format(totlvrd)+"</font></td>");
			out.println("</tr>");
			// Next row (Float.parseFloat((std_cost.elementAt(m-1).toString()))-Float.parseFloat((fin_cost.elementAt(m-1).toString())))
			out.println("<tr><td width='6%' colspan='12' align='center' valign='CENTER'>"+"________________________________________________________________________________________________________________________"+"</td></tr>");
			// totals
			//TOTSURF
			//TOTLVRSF
			// Perim

		qtotal=qtotal+((new Float(qty)).intValue());

		stotal=stotal+(((new Float(sec)).intValue())*(new Float(qty)).intValue());

		// Intialzinf of variables
		labd=0;matd=0;totfind=0;
		//out.println("HEREx<BR>");

	}// else loop


}// IF loop ending checking for the item_no

}//Inner for loop for item no

}

//Another row
out.println("<tr><td width='6%' align='center'>"+"<font face='Impact' size='1'>TOTAL</font>"+"</td>");
out.println("<td></td>");
out.println("<td></td>");
out.println("<td></td>");
out.println("<td colspan='1' align='center'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Total Lvrs: "+qtotal+"</td>");
out.println("<td align='center'>Total Sections: "+stotal+"</td>");
//					out.println("<td width='6%' align='center' colspan='1'>"+"&nbsp;"+"</td>");
out.println("<tr><td width='6%' colspan='2' align='center'>"+"Material $ "+for1.format(mat_final_d)+"</td>");
//					out.println("<td width='6%' COLSPAN='2' align='center' wordwrap='no'>"+"&nbsp;"+"</td>");
out.println("<td width='6%' colspan='2' align='left' >"+"Labor $"+for1.format(lab_final_d)+"</td>");
//out.println("&nbsp;&nbsp;&nbsp;"+qtotal+"</td>");
out.println("<td width='3%' colspan='2' align='left'>"+"Labor Hours "+for1.format(labhr_final_d)+"</td>");






out.println("<td width='3%' colspan='1' align='center'>&nbsp;</td>");





//				out.println("<td width='3%' COLSPAN='1' align='center'>"+"&nbsp;"+"</td>");
out.println("<td width='6%' colspan='1' align='center'>"+for0.format(new Double(ttotwt).doubleValue())+"Lbs."+"</td>");
out.println("<td width='6%' colspan='2' align='center'>"+"Finish $ "+for1.format(fin_final_d)+"</td>");
//					out.println("<td width='6%' COLSPAN='7' align='center'>"+"&nbsp;"+"</td>");
out.println("</tr>");
//Another row
out.println("<tr><td width='6%' colspan='12' align='center'>"+"&nbsp;"+"</td></tr>");
out.println("<tr><td width='6%' align='center'>"+"<font face='Impact' size='1'>Totals:</font>"+"</td>");
out.println("<td width='6%' colspan='2' align='left' NOWRAP >"+"Area = "+((new Float(tsarea+0.5)).intValue())+" Sq.Ft.");
if(exchName!= null && exchName.equals("CAD")){
	out.println("("+(new Float((tsarea+0.5)*.0929).intValue())+" Sq.M.)");

}
out.println("</td>");
out.println("<td width='6%' colspan='2' align='left' nowrap>"+"Surface Area = "+((new Float(tarea+0.5)).intValue())+" Sq.Ft."+"</td>");
if(product_id.equals("GRILLE")){
if(new Float(tLinFt).intValue()>0){
out.println("<td width='3%' colspan='2' align='left' nowrap>"+"Lineal Feet = "+((new Float(tLinFt)).intValue())+" Ft."+"</td>");
}
else{
out.println("<td width='3%' colspan='2' align='left' nowrap>&nbsp;</td>");
}
out.println("<td width='3%' colspan='2' align='left' nowrap>"+"Weight per Sq. Ft. = "+for1.format((new Double(ttotwt).doubleValue())/(new Double(tsarea).doubleValue()))+"</td>");
}
else{
out.println("<td width='3%' colspan='2' align='left' nowrap>"+"Perimeter = "+((new Float(tperim+0.5)).intValue())+" Ft."+"</td>");
}
//					out.println("<td width='6%' colspan='2' align='right' nowrap>"+"Material $ "+for1.format(mat_final_d)+"</td>");
//					out.println("<td width='6%' colspan='1' align='right' nowrap>"+"Labor $"+for1.format(lab_final_d)+"</td>");
//					out.println("<td width='6%' colspan='2' align='center' nowrap>"+"Finish $ "+for1.format(fin_final_d)+"</td>");
//					out.println("<td width='3%' colspan='2' align='left' nowrap>"+"Labor Hours "+for1.format(labhr_final_d)+"</td>");
//out.println("<td width='3%' colspan='7' align='center' NOWRAP>"+"&nbsp;"+"</td>");
out.println("</tr>");
out.println("<tr><td width='6%' colspan='12'><hr></td><tr>");
//BigDecimal big=new BigDecimal((tcg/sp)*100);
//out.println("test"+big.setScale(2,BigDecimal.ROUND_HALF_UP));
//DecimalFormat for1=new DecimalFormat("#.##");
//out.println("test"+for1.format(((tcg)/sp)*100));
//Another row
// Outer for loop closing



out.println("<tr><td width='6%' colspan='11' align='center'>"+"============================================================================================================="+"</td></tr>");
out.println("<tr>");
out.println("<td width='6%' colspan='2' align='right'>"+"Total cost group "+"</td>");
//					out.println("<td width='3%' COLSPAN='1' align='center'>"+"&nbsp;"+"</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+tcg+"</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+for1.format((tcg/sp)*100)+" %</td>");
//out.println("<td width='6%' COLSPAN='9' align='right'>"+"&nbsp;"+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td width='6%' colspan='2' align='right'>"+"Drafting"+"</td>");
//					out.println("<td width='6%' COLSPAN='1' align='center'>"+"&nbsp;"+"</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+for1.format(dh*dh_rate)+"</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+for1.format((dh*dh_rate)/sp*100)+" %</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+dh+" HRS.</td>");
//out.println("<td width='6%' COLSPAN='8' align='right'>"+"&nbsp;"+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td width='6%' colspan='2' align='right'>"+"Layout"+"</td>");
//					out.println("<td width='3%' COLSPAN='1' align='center'>"+"&nbsp;"+"</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+for1.format(ly*dh_rate)+"</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+for1.format(((ly*dh_rate)/sp)*100)+" %</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+ly+" HRS.</td>");
//out.println("<td width='6%' COLSPAN='8' align='right'>"+"&nbsp;"+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td width='6%' colspan='2' align='right'>"+"Engineering"+"</td>");
//					out.println("<td width='3%' COLSPAN='1' align='center'>"+"&nbsp;"+"</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+for1.format(eh*eh_rate)+"</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+for1.format(((eh*eh_rate)/sp)*100)+" %</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+eh+" HRS.</td>");
//out.println("<td width='6%' COLSPAN='8' align='right'>"+"&nbsp;"+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td width='6%' colspan='2' align='right'>"+"Project Mgmt"+"</td>");
//					out.println("<td width='6%' COLSPAN='1' align='center'>"+"&nbsp;"+"</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+for1.format(pm*pm_rate)+"</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+for1.format(((pm*pm_rate)/sp)*100)+" %</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+pm+" HRS.</td>");
//out.println("<td width='6%' COLSPAN='8' align='right'>"+"&nbsp;"+"</td>");
out.println("<td align='right' colspan='1' >&nbsp;</td>");

out.println("<td align='right' colspan='2'></td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td width='6%' colspan='2' align='right'>"+"Freight/Crate"+"</td>");
//					out.println("<td width='6%' COLSPAN='1' align='center'>"+"&nbsp;"+"</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+fc+"</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+for1.format((fc/sp)*100)+" %</td>");
//out.println("<td width='6%' COLSPAN='9' align='right'>"+"&nbsp;"+"</td>");
if(product_id.equals("LVR")){
out.println("<td align='right' colspan='1' >&nbsp;</td>");
out.println("<td align='right' colspan='2' >"+"Freight = $"+freight+"</td>");

out.println("<td align='right' colspan='2'>"+"Crate = $"+for1.format(fc-freight)+"</td>");
}
out.println("</tr>");
if(product_id.equals("GRILLE")){
out.println("<tr>");
out.println("<td align='right' colspan='1' >&nbsp;</td>");
out.println("<td width='6%' colspan='2' align='right'>"+"Freight"+"</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+freight+"</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+for1.format((freight/sp)*100)+" %</td>");
//out.println("<td width='6%' COLSPAN='9' align='right'>"+"&nbsp;"+"</td>");
out.println("</tr>");
}
out.println("<tr>");
out.println("<td width='6%' colspan='2' align='right'>"+"Commission"+"</td>");
//					out.println("<td width='6%' COLSPAN='1' align='center'>"+"&nbsp;"+"</td>");
out.println("<td width='6%' COLSPAN='1' align='right'>"+cd+"</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+for1.format((cd/sp)*100)+" %</td>");
out.println("<td width='3%' COLSPAN='1' align='right'>"+"Actual"+"</td>");
//					out.println("<td width='6%' COLSPAN='1' align='right'>"+for1.format((cd/(sp-fc)*100))+" %</td>");
out.println("<td width='3%' COLSPAN='2' align='right'>"+for1.format((cd/(sp*0.91)*100))+" % of sell less F&C</td>");
if(product_id.equals("LVR") && exportCrate != null && exportCrate.trim().length()>0){
	out.println("<td width='3%' COLSPAN='2' align='right'> Export Crate = $" +exportCrate+"</td>");
}
else{
	out.println("<td width='3%' COLSPAN='2' align='left'>"+""+"</td>");
}
//out.println("<td width='6%' COLSPAN='5' align='left'>"+"&nbsp;"+"</td>");
out.println("</tr>");
if(spComm>0){
	out.println("<tr>");
	out.println("<td colspan='5' align='right'>Std Comm</td>");
	out.println("<td COLSPAN='2' align='center'>"+stdComm+"%</td>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<td colspan='5' align='right'>Special Comm</td>");
	out.println("<td COLSPAN='2' align='center'>"+spComm+"%</td>");
	out.println("</tr>");
}
out.println("<tr><td width='6%' colspan='12' align='center'>"+"-------------------------------------------------------------------------------------------------------------------------"+"</td></tr>");
out.println("<tr>");
out.println("<td width='6%' COLSPAN='2' align='right'>"+"Actual Cost of Sale$"+"</td>");
//				out.println("<td width='6%' COLSPAN='1' align='center'>"+"&nbsp;"+"</td>");
float cs=(tcg+(dh*dh_rate)+(ly*dh_rate)+(eh*eh_rate)+(pm*pm_rate)+fc+cd+(float) catchall);
out.println("<td width='6%' COLSPAN='1' align='right'>"+for1.format(cs)+"</td>");
out.println("<td width='6%' COLSPAN='1' align='right'>"+for1.format(((cs/sp))*100)+" %</td>");
//out.println("<td width='6%'>&nbsp;</td>");
out.println("<td width='6%' COLSPAN='7' rowspan='5' align='right'>");
out.println("<table border='0' width='100%'>");
out.println("<tr><td width='10%'>&nbsp</td><td width='10%'>Price</td><td width='10%'>Weight</td><td width='70%'>Description</td></tr>");
out.println("<tr><td>Catchall1</td><td>"+pInfCATCHALL1+"</td><td>"+pInfCATCHALLWT1+"</td><td>"+pInfCATCHALL_DESC1+"</td></tr>");
out.println("<tr><td>Catchall2</td><td>"+pInfCATCHALL2+"</td><td>"+pInfCATCHALLWT2+"</td><td>"+pInfCATCHALL_DESC2+"</td></tr>");
out.println("<tr><td>Catchall3</td><td>"+pInfCATCHALL3+"</td><td>"+pInfCATCHALLWT3+"</td><td>"+pInfCATCHALL_DESC3+"</td></tr>");
out.println("<tr><td>Catchall4</td><td>"+pInfCATCHALL4+"</td><td>"+pInfCATCHALLWT4+"</td><td>"+pInfCATCHALL_DESC4+"</td></tr>");
out.println("<tr><td>Catchall5</td><td>"+pInfCATCHALL5+"</td><td>"+pInfCATCHALLWT5+"</td><td>"+pInfCATCHALL_DESC5+"</td></tr>");
out.println("</table>");




out.println("</td>");
//out.println("<td width='6%' colspan='3' align='left'>"+"Catchall $"+for1.format(catchall)+"</td>");
//out.println("<td width='6%' COLSPAN='3' align='right'>"+"&nbsp;"+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td width='6%' COLSPAN='2' align='right'>"+"Gross Profit Margin"+"</td>");
//					out.println("<td width='6%' COLSPAN='1' align='center'>"+"&nbsp;"+"</td>");
out.println("<td width='6%' COLSPAN='1' align='right'>"+md+"</td>");
out.println("<td width='6%' COLSPAN='1' align='right'>"+for1.format((md/sp)*100)+" %</td>");
//out.println("<td width='6%' COLSPAN='4' align='right'>"+"&nbsp;"+"</td>");
//out.println("<td width='6%' colspan='3' align='left'>"+"Catchall WT "+for1.format(catchallwt)+"</td>");
//out.println("<td width='6%' COLSPAN='3' align='right'>"+"&nbsp;"+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td width='6%' COLSPAN='2' align='right'>"+"Sell Price"+"</td>");
//					out.println("<td width='6%' COLSPAN='1' align='center'>"+"&nbsp;"+"</td>");
out.println("<td width='6%' COLSPAN='1' align='right'>"+sp+"</td>");
out.println("<td width='6%' COLSPAN='1' align='right'>"+"100%"+"</td>");
//out.println("<td width='6%' COLSPAN='4' align='right'>"+"&nbsp;"+"</td>");
//out.println("<td width='6%' colspan='3' align='left' >"+"Catchall Desc "+(catchall_desc)+"</td>");
//out.println("<td width='6%' COLSPAN='3' align='right'>"+"&nbsp;"+"</td>");
out.println("</tr>");
if(exchName!= null && exchName.equals("CAD")){
	out.println("<tr>");
	out.println("<td width='6%' COLSPAN='2' align='right'>"+"Canadian Sell Price"+"</td>");
	out.println("<td width='6%' COLSPAN='1' align='right'>"+exchName+"&nbsp;"+for12.format(sp*new Double(exchRate).doubleValue())+"</td>");
	out.println("<td width='6%' COLSPAN='1' align='right'>"+"100%"+"</td>");
	out.println("</tr>");
}
// from John's Request on July 02
out.println("<tr>");
out.println("<td width='6%' COLSPAN='2' align='right'>"+"Installation Price"+"</td>");
out.println("<td width='6%' COLSPAN='1' align='right'>"+install+"</td>");
//out.println("<td width='6%' COLSPAN='11' align='right'>"+"&nbsp;"+"</td>");
out.println("</tr>");
// from John's Request on July 02
out.println("<tr>");
out.println("<td width='6%' COLSPAN='2' align='right'>"+"Total Price"+"</td>");
out.println("<td width='6%' COLSPAN='1' align='right'>"+total_price+"</td>");
//out.println("<td width='6%' COLSPAN='11' align='right'>"+"&nbsp;"+"</td>");
out.println("</tr>");
// From john changes done
out.println("<tr>");
if(exchName!= null && exchName.equals("CAD")){
	out.println("<td width='6%' COLSPAN='2' align='right'>"+"Price/Sq.Ft.<BR>(Price/Sq.M)<BR>"+"</td>");
	out.println("<td width='6%' COLSPAN='1' align='right'>"+dollarsf +"<BR>("+for12.format(new Double(total_price).doubleValue()/new Float((tsarea+0.5)*.0929).intValue())+")</td>");
}
else{
	out.println("<td width='6%' COLSPAN='2' align='right'>"+"Price/Sq.Ft."+"</td>");
	out.println("<td width='6%' COLSPAN='1' align='right'>"+dollarsf +"</td>");

}
out.println("<td width='6%' COLSPAN='5' align='right'>"+"&nbsp;"+"</td>");
out.println("<td width='6%' colspan='3' align='left' >"+"Labor cost &nbsp; 23.00"+"</td>");
//out.println("<td width='6%' COLSPAN='3' align='right'>"+"&nbsp;"+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td width='6%' COLSPAN='2' align='right'>"+"Price/Lb."+"</td>");
//					out.println("<td width='6%' COLSPAN='1' align='center'>"+"&nbsp;"+"</td>");
out.println("<td width='6%' COLSPAN='1' align='right'>"+yield+"</td>");
out.println("<td width='6%' COLSPAN='5' align='right'>"+"&nbsp;"+"</td>");
out.println("<td width='6%' colspan='3' align='left' nowrap>"+"Crated Weight "+for1.format(crated_weight)+"</td>");
//out.println("<td width='6%' COLSPAN='3' align='right'>"+"&nbsp;"+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td width='6%' COLSPAN='2' align='right'>"+"Mark Up"+"</td>");
//				out.println("<td width='6%' COLSPAN='1' align='center'>"+"&nbsp;"+"</td>");
out.println("<td width='6%' COLSPAN='1' align='right'>"+for1.format(sp/(tcg+catchall))+"</td>");
out.println("<td width='6%' COLSPAN='5' align='right'>"+"&nbsp;"+"</td>");
if(product_id.equals("GRILLE")){
//out.println(grillecost+"::"+vaccost+"::"+rfcost+"::"+econocost);
String alcost="";
if(grillecost.trim().length()>0 && !grillecost.equals("0")){
alcost=alcost+"Grille Alum Cost "+grillecost +"<BR>";
}
if(vaccost.trim().length()>0 && !vaccost.equals("0")){
alcost=alcost+"VAC Alum Cost "+vaccost +"<BR>";
}
if(rfcost.trim().length()>0 && !rfcost.equals("0")){
alcost=alcost+"RF VAC Alum Cost "+ rfcost +"<BR>";
}
if(econocost.trim().length()>0 && !econocost.equals("0")){
alcost=alcost+"ECONO Alum Cost "+econocost +"<BR>";
}
out.println(galCost+"::");
if(galCost.trim().length()>0){
alcost=alcost+"Galv Cost "+galCost+"<BR>";
}
if(alcost.trim().length()>0){
out.println("<td width='6%' colspan='3' align='left' nowrap>"+alcost+"</td>");
}
else{
out.println("<td width='6%' colspan='3' align='left' nowrap></td>");
}
}
else{
out.println("<td width='6%' colspan='3' align='left' nowrap>"+"Alum Cost "+extcostlb+"</td></tr>");
out.println("<Tr><td width='6%' colspan='8' align='left' nowrap></td>");
out.println("<td width='6%' colspan='3' align='left' nowrap>"+"Galv Cost "+galCost+"</td>");
}
//out.println("<td width='6%' COLSPAN='3' align='right'>"+"&nbsp;"+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td width='6%' COLSPAN='12' align='right'>"+"&nbsp;"+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td width='6%' COLSPAN='12' align='right'>"+"&nbsp;"+"</td>");
out.println("</tr>");
out.println("<tr>");
out.println("<td width='6%' COLSPAN='12' align='right'>"+"&nbsp;"+"</td>");
out.println("</tr>");


}//If
else{
out.println("<font color='red'><b>Please select a valid order  no....."+"</font>"+"</b>"+"<br>");

}

}
isModular=false;// this forces the second loop to do the other grilles
//}

if(product_id.equals("LVR")){
out.println("<tr><td width='6%' colspan='12' align='center'>");
out.println("Margin Target @ 10% Commission: 18%");
out.println("</td></tr>");

out.println("<tr><td width='6%' colspan='12' align='center'>");
out.println("Price/Lb Target: $7.10");
out.println("</td></tr>");



}

out.println("<tr><td width='6%' colspan='12' align='center'>"+"==================================================================================================================="+"</td></tr>");
out.println("<tr><td width='6%' colspan='12' align='right'>");
out.println("&nbsp;&nbsp;&nbsp;&nbsp;<b> <b></b> </b>"+"<b>"+""+"</font></b>"+"&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
out.println("&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<b> Order Number # </b>"+"<b>"+onumber+"</font></b>");
out.println("</td></tr>");
stmt.close();
myConn.close();

				%>
	</table>
</body>
</html>

<%

 }
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>