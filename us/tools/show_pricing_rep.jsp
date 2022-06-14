<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%

try{
%>
<html>
	<head>
		<title>Show Pricing</title>

		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>
	<body>


		<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" errorPage="error.jsp" %>
		<%@ include file="../../db_con.jsp"%>
		<%@ include file="../../db_con_bpcsusr.jsp"%>
		<%


				java.util.Date myDate = new java.util.Date();
				String x1=""+(myDate.getYear()+1900);
				String x2=""+(myDate.getMonth()+1);
				String x3=""+myDate.getDate();
				if(x2.trim().length()<2){
					x2="0"+x2;
				}
				if(x3.trim().length()<2){
					x3="0"+x3;
				}
				String x4=x2+"/"+x3+"/"+x1;
				//out.println(x4);
				out.println("<table aign='center' border='0' width='100%'><tr><td width='25%' align='left' valign='top'>DATE: "+x4+"</td><td width='50%' align='center' valign='top'><font size='3'>CONFIDENTIAL PROPERTY OF CS</font></td><td width='25%' align='right'>LIST GOOD FOR <br>30 DAYS FROM<br>DATE SHOWN</td></tr></table>");


				// this is used to set default on pull down menu
				String tableNum1 = request.getParameter("mode");
				int tableNumber1 = Integer.parseInt(tableNum1);
				String selected[]= new String[7];

				for (int j=0; j<=6; j++){
					selected[j]="";
					if (j == tableNumber1){
						selected[j]="selected";
					}
				}
				selected[4]="selected";
				// show's pull down menu and text box to search new within the page

				out.println("<form action='show_pricing_rep.jsp' method='post'>");
				out.println("<table align=center border=0 cellspacing='1' cellpadding='2'>");
				out.println("<tr><td width='15%'>Product:</td><td width='15%'>");
				out.println("<select name='mode' size =1>");
				//out.println("<option value='0'"+selected[0]+">EFS</option>");
				//out.println("<option value='1'"+selected[1]+">EFS ADDERS</option>");
				//out.println("<option value='2'"+selected[2]+">EJC</option>");
				//out.println("<option value='3'"+selected[3]+">EJC_FB</option>");
				out.println("<option value='4'"+selected[4]+">IWP</option>");
				//out.println("<option value='5'"+selected[5]+">IWP_BPCS</option>");
				//out.println("<option value='6'"+selected[6]+">PART</option>");
				out.println("</SELECT></td>");
				out.println("<td width='15%'>Search for:</td><td width='15%'>");
				out.println("<input type=text name='param' size=15></td>");
				out.println("<td width='15%'><input type=submit value='SUBMIT'></tr></table></form>");

		%>

		<%

		//Greg Suisham - CS Group
		//mode which is a number for the table is passed in threw the url, as well as the string we are searching the table for
		//this is page check the url mode attribute and given the results runs a specific query with a specific table header

		//get variables for url
		String tableNum = request.getParameter("mode");
		String param = request.getParameter("param");
		int tableNumber = Integer.parseInt(tableNum);

		//strings to print the html table headers
		String tableHeaders[] = new String[7];


		tableHeaders[0]="<TABLE cellspacing=0 cellpadding=2 id=header border='1' style='table-layout:fixed' width='100%'><COL WIDTH='300'><COL WIDTH='300'><COL WIDTH='300'><tr><th width=500 bgcolor='lightgrey'>MODEL</th><th width=500 bgcolor='lightgrey'>BOOK</th><th width=500 bgcolor='lightgrey'>COST</th></tr></TABLE><DIV STYLE='overflow: auto; height: 500; border-left: 1px gray solid; border-bottom: 1px gray solid; padding:0px; margin: 0px'><TABLE cellspacing=0 cellpadding=2 BORDER='1' width='100%'  style='table-layout:fixed'><COL WIDTH='300'><COL WIDTH='300'><COL WIDTH='300'>";
		tableHeaders[1]="<TABLE cellspacing=0 cellpadding=2 id=header border='1' style='table-layout:fixed' width='100%'><COL WIDTH=100><COL WIDTH=100><COL WIDTH=500><COL WIDTH=100><COL WIDTH=100><tr><th width=150 bgcolor='lightgrey'>MODEL</th><th width=200 bgcolor='lightgrey'>BOOK</th><th width=500 bgcolor='lightgrey'>DESCRIPTION</th><th width=200 bgcolor='lightgrey'>COST</th><th width=200 bgcolor='lightgrey'>UM</th></tr></TABLE><DIV STYLE='overflow: auto; height: 500; border-left: 1px gray solid; border-bottom: 1px gray solid; padding:0px; margin: 0px'><TABLE cellspacing=0 cellpadding=2 BORDER='1' width='100%'  style='table-layout:fixed'><COL WIDTH=100><COL WIDTH=100><COL WIDTH=500><COL WIDTH=100><COL WIDTH=100>";
		tableHeaders[2]="<TABLE cellspacing=0 cellpadding=2 id=header border='1' WIDTH='100%'><COL WIDTH=100><COL WIDTH=50><COL WIDTH=50><COL WIDTH=50><COL WIDTH=50><COL WIDTH=50><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><tr><th bgcolor='lightgrey'>MODEL</th><th bgcolor='lightgrey'>U<br>O<br>M</th><th bgcolor='lightgrey'>WGT</th><th bgcolor='lightgrey'>COST</th><th bgcolor='lightgrey'>BOOK</th><th bgcolor='lightgrey'>VB</th><th bgcolor='lightgrey'>FB1</th><th bgcolor='lightgrey'>FB2</th><th bgcolor='lightgrey'>FB2L</th><th bgcolor='lightgrey'>FB3</th><th bgcolor='lightgrey'>FB4</th></tr></TABLE><DIV STYLE='overflow: auto; height: 500; border-left: 1px gray solid; border-bottom: 1px gray solid; padding:0px; margin: 0px'><TABLE cellspacing=0 cellpadding=2 BORDER='1' width='100%'  style='table-layout:fixed'><COL WIDTH=100><COL WIDTH=50><COL WIDTH=50><COL WIDTH=50><COL WIDTH=50><COL WIDTH=50><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100>";
		tableHeaders[3]="<TABLE cellspacing=0 cellpadding=2 id=header border='1' style='table-layout:fixed' width='100%'><COL WIDTH=200><COL WIDTH=100><COL WIDTH=200><COL WIDTH=200><COL WIDTH=200><tr><th bgcolor='lightgrey'>MODEL</th><th bgcolor='lightgrey'>UM</th><th bgcolor='lightgrey'>WEIGHT</th><th bgcolor='lightgrey'>COST</th><th bgcolor='lightgrey'>BOOK</th></tr></TABLE><DIV STYLE='overflow: auto; height: 500; border-left: 1px gray solid; border-bottom: 1px gray solid; padding:0px; margin: 0px'><TABLE cellspacing=0 cellpadding=2 BORDER='1' width='100%'  style='table-layout:fixed'><COL WIDTH=200><COL WIDTH=100><COL WIDTH=200><COL WIDTH=200><COL WIDTH=200>";

		tableHeaders[4]="<TABLE cellspacing=0 cellpadding=2 border='1'  width='100%'><tr><td>MODEL</td><td>UM</td><td>BOOK PRICE</td><td>Description</td></tr>";













		tableHeaders[5]="<TABLE cellspacing=0 cellpadding=2 id=header border='1' style='table-layout:fixed' width='100%'><COL WIDTH=100><COL WIDTH=100><COL WIDTH=50><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=150><tr><th bgcolor='lightgrey'>BPCS</th><th bgcolor='lightgrey'>MODEL</th><th bgcolor='lightgrey'>UM</th><th bgcolor='lightgrey'>COST</th><th bgcolor='lightgrey'>L4_PRICE</th><th bgcolor='lightgrey'>L5_PRICE</th><th bgcolor='lightgrey'>L6_PRICE</th><th bgcolor='lightgrey'>WGT</th><th bgcolor='lightgrey'>Description</th></tr></TABLE><DIV STYLE='overflow: auto; height: 500; border-left: 1px gray solid; border-bottom: 1px gray solid; padding:0px; margin: 0px'><TABLE cellspacing=0 cellpadding=2 BORDER='1' width='100%'  style='table-layout:fixed'><COL WIDTH=100><COL WIDTH=100><COL WIDTH=50><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=150>";
		tableHeaders[6]="<TABLE cellspacing=0 cellpadding=2 id=header border='1' style='table-layout:fixed' width='100%'><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=50><COL WIDTH=50><COL WIDTH=100><COL WIDTH=100><COL WIDTH=150><COL WIDTH=150><tr><th width=200 bgcolor='lightgrey'>ITEM#</th><th bgcolor='lightgrey'>PURCHASE COST</th><th bgcolor='lightgrey'>BUISNESS UNIT</th><th bgcolor='lightgrey'>PURCHASING UOM</th><th bgcolor='lightgrey'>STOCK UOM</th><th bgcolor='lightgrey'>PURCHASE WEIGHT</th><th bgcolor='lightgrey'>INVENTORY QTY</th><th bgcolor='lightgrey'>ITEM DESCRIPTION</th><th bgcolor='lightgrey'>ITEM DESCRIPTION 2</th></tr></TABLE><DIV STYLE='overflow: auto; height: 500; border-left: 1px gray solid; border-bottom: 1px gray solid; padding:0px; margin: 0px'><TABLE cellspacing=0 cellpadding=2 BORDER='1' width='100%'  style='table-layout:fixed'><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=50><COL WIDTH=50><COL WIDTH=100><COL WIDTH=100><COL WIDTH=150><COL WIDTH=150>";




















		String querys[] = new String[7];
		int numColumns[] = new int[7];
		int formatArray[][] = new int[7][11];

		querys[0]="Select model, book, cost from CS_EFS_PRICING where model like '" + param + "%' and (inactive not like 'Y' or inactive is null) order by model";
		numColumns[0]=3;
		formatArray[0][0]=0;formatArray[0][1]=1;formatArray[0][2]=1;


		querys[1]="Select model, book, description, cost, um from CS_EFS_ADDERS where model like '" + param + "%' order by model";
		numColumns[1]=5;
		formatArray[1][0]=0;formatArray[1][1]=1;formatArray[1][2]=0;formatArray[1][3]=1;formatArray[1][4]=0;


		querys[2]="Select model, uom, weight, cost, book, vb, fb1, fb2, fb2l, fb3, fb4 from CS_EJC_PRICING where model like '"+param+"%' and (inactive not like 'Y' or inactive is null) order by model";
		numColumns[2]=11;
		formatArray[2][0]=0;formatArray[2][1]=0;formatArray[2][2]=1;formatArray[2][3]=1;formatArray[2][4] = 1; formatArray[2][5]=0;formatArray[2][6]=0;formatArray[2][7]=0;formatArray[2][8]=0;formatArray[2][9]=0;formatArray[2][10]=0;

		querys[3]="select model, um, weight, cost, book from CS_EJC_FB where model like '"+param+"%' order by model";
		numColumns[3]=5;
		formatArray[3][0]=0;formatArray[3][1]=0;formatArray[3][2]=1;formatArray[3][3]=1;formatArray[3][4]=1;

		querys[4]="Select model, UM,L4_Price,description from cs_IWP_PRICING where model like '"+param.trim()+"%' and (inactive not like 'Y' or inactive is null) and (pb='' or pb is null) order by model";
		numColumns[4]=4;
		formatArray[4][0]=0;formatArray[4][1]=0;formatArray[4][2]=1;formatArray[4][3]=0;

		querys[5]="Select bpcs, model, UM, cost, l4_price, l5_price, l6_price, wgt,description from cs_iwp_pricing where bpcs like '"+param+"%' and (inactive not like 'Y' or inactive is null) order by bpcs";
		numColumns[5]=9;
		formatArray[5][0]=0;formatArray[5][1]=0;formatArray[5][2]=0;formatArray[5][3]=1;formatArray[5][4]=1;formatArray[5][5]=1;formatArray[5][6]=1;formatArray[5][7]=0;formatArray[5][8]=0;

		querys[6]="Select PRCITM,PRCCST,PRCSBU,PRCPUM,PRCSUM,PRCWGT,PRCBAL,PRCDSC,PRCDS2 from PRC001PF where PRCITM like '"+param.toUpperCase()+"%' order by PRCSBU,PRCITM";
		numColumns[6]=9;
		formatArray[6][0]=0;formatArray[6][1]=1;formatArray[6][2]=0;formatArray[6][3]=0;formatArray[6][4]=0;formatArray[6][5]=1;formatArray[6][6]=1;formatArray[6][7]=0;


		String backCol;
		String tblFormat;
		String result;
		int decIndex;

		try{

			if(param.trim().length() > 0){

				out.println("<center><font size=5><b>Items found that start with '" + param + " '<b></font><br><br><center>");

				out.println(tableHeaders[tableNumber]);
				//out.println(tableNumber);
				ResultSet rs_query;
				if(tableNumber ==6){
					rs_query = stmt_bpcsusr.executeQuery(querys[tableNumber]);
				}
				else{
					rs_query = stmt.executeQuery(querys[tableNumber]);
				}
				if (rs_query !=null) {
					int col=0;
					while (rs_query.next()) {
						// used to change the color of each row to keep it legiable.
						if(col%2==0){
							 backCol = "#ffffff";
						}
						else{
								backCol="#c0c0c0";
						}
						out.println("<tr>");
						for(int i=1; i<=numColumns[tableNumber]; i++){
							// prints each cell of the table
							if(formatArray[tableNumber][i-1] == 1 ){
								tblFormat = "right";
							}
							else{
								tblFormat = "center";
							}
							result=rs_query.getString(i);
							if(result == null){
								result="&nbsp;";
							}
							if(formatArray[tableNumber][i-1]==1){
								result=result+"0000";
								decIndex=result.indexOf(".");
								result=result.substring(0,decIndex+5);

							}
							out.println("<td bgcolor='"+backCol+"' align ='" + tblFormat +"'>"+result+"</td>");
						}
						col=col+1;
					}
				}
				rs_query.close();

			}

		}
		catch (Exception e){
			out.println ("Error connecting to Database  ::  " + e);
		}
	

stmt.close();
stmt_bpcsusr.close();
myConn.close();
con_bpcsusr.close();
		%>
	</table>
</body>
</html>
<%

}
catch(Exception e){
out.println(e);
}
%>