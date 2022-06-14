<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<%
//if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
//        erapidBean.setServerName("server1");
//}
try{

%>
<html>
	<head>
		<title>Show Pricing</title>

		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>
	<body>
		<%
		//if ((request.getSession()!=null)){

			//HttpSession usersession=request.getSession();
			String group=request.getParameter("group");
			//if(usersession != null&&usersession.getValue("usergroup") != null){
				//out.println("HERE");
			//	group=usersession.getValue("usergroup").toString();
			//}
			//out.println(group+":: GROUP");
			//if(group != null && group.trim().length()>0){
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

				// show's pull down menu and text box to search new within the page
				if(group.toUpperCase().equals("EJC-ADMIN")){
					out.println("<form action='show_pricing.jsp' method='post'><input type='hidden' name='group' value='"+group+"'><table align=center border=0 cellspacing='1' cellpadding='2'><tr><td width='15%'>Product:</td><td width='15%'><select name='mode' size =1><option value='0'"+selected[0]+">EFS<option value='1'"+selected[1]+">EFS ADDERS<option value='2'"+selected[2]+">EJC<!--<option value='3'"+selected[3]+">EJC_FB--><option value='3'"+selected[3]+">IWP<option value='4'"+selected[4]+">IWP_BPCS</SELECT></td><td width='15%'>Search for:</td><td width='15%'><input type=text name='param' size=15></td><td width='15%'><input type=submit value='SUBMIT'></tr></table></form>");
				}
				else{
					out.println("<form action='show_pricing.jsp' method='post'><input type='hidden' name='group' value='"+group+"'><table align=center border=0 cellspacing='1' cellpadding='2'><tr><td width='15%'>Product:</td><td width='15%'><select name='mode' size =1><option value='0'"+selected[0]+">EFS<option value='1'"+selected[1]+">EFS ADDERS<option value='2'"+selected[2]+">EJC<!--<option value='3'"+selected[3]+">EJC_FB--><option value='3'"+selected[3]+">IWP<option value='4'"+selected[4]+">IWP_BPCS<option value='5'"+selected[5]+">PART</SELECT></td><td width='15%'>Search for:</td><td width='15%'><input type=text name='param' size=15></td><td width='15%'><input type=submit value='SUBMIT'></tr></table></form>");
				}
		%>

		<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con.jsp"%>
		<%@ include file="../../../db_con_bpcsusr.jsp"%>
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
		/*
		tableHeaders[0]="<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'><tr><td width='10%' bgcolor='yellow'><b>MODEL<b></td><td width='10%' bgcolor='yellow'><b>BOOK<b></td><td width='10%' bgcolor='yellow'><b>COST<b></td>";
		tableHeaders[1]="<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'><tr><td width='10%' bgcolor='yellow'><b>MODEL<b></td><td width='10%' bgcolor='yellow'><b>BOOK<b></td><td width='20%' bgcolor='yellow'><b>Description<b></td><td width='10%' bgcolor='yellow'><b>COST<b></td><td width='10%' bgcolor='yellow'><b>UM<b></td>";
		tableHeaders[2]="<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'><tr><td width='10%' bgcolor='yellow'><b>MODEL<b></td><td width='10%' bgcolor='yellow'><b>UOM</td><td width='10%' bgcolor='yellow'><b>WEIGHT</td><td width='10%' bgcolor='yellow'><b>COST</td><td width='10%' bgcolor='yellow'><b>BOOK</td><td width='10%' bgcolor='yellow'><b>VB</td><td width='10%' bgcolor='yellow'><b>FB1</td><td width='10%' bgcolor='yellow'><b>FB2</td><td width='10%' bgcolor='yellow'><b>FB2L</td><td width='10%' bgcolor='yellow'><b>FB3</td><td width='10%' bgcolor='yellow'><b>FB4</td></tr>";
		tableHeaders[3]="<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'><tr><td width='10%' bgcolor='yellow'><b>MODEL<b></td><td width='10%' bgcolor='yellow'><b>UM<b></td><td width='10%' bgcolor='yellow'><b>WEIGHT<b></td><td width='10%' bgcolor='yellow'><b>COST<b></td><td width='10%' bgcolor='yellow'><b>BOOK<b></td>";
		tableHeaders[4]="<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'><tr><td width='10%' bgcolor='yellow'><b>MODEL<b></td><td width='10%' bgcolor='yellow'><b>BPCS<b></td><td width='10%' bgcolor='yellow'><b>UM</b></td><td width='10%' bgcolor='yellow'><b>COST<b></td><td width='10%' bgcolor='yellow'><b>L4_PRICE<b></td><td width='10%' bgcolor='yellow'><b>L5_PRICE<b></td><td width='10%' bgcolor='yellow'><b>L6_PRICE<b></td><td width='10%' bgcolor='yellow'><b>WGT<b></td>";
		tableHeaders[5]="<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'><tr><td width='10%' bgcolor='yellow'><b>BPCS<b></td><td width='10%' bgcolor='yellow'><b>MODEL<b></td><td width='10%' bgcolor='yellow'><b>UM</b></td><td width='10%' bgcolor='yellow'><b>COST<b></td><td width='10%' bgcolor='yellow'><b>L4_PRICE<b></td><td width='10%' bgcolor='yellow'><b>L5_PRICE<b></td><td width='10%' bgcolor='yellow'><b>L6_PRICE<b></td><td width='10%' bgcolor='yellow'><b>WGT<b></td>";
		tableHeaders[6]="<table width='80%' align='center' cellspacing='1' cellpadding='2' border='0'><tr><td width='10%' bgcolor='yellow'><b>Item Number<b></td><td width='10%' bgcolor='yellow'><b>Purchase Cost<b></td><td width='10%' bgcolor='yellow'><b>Business Unit</b></td><td width='10%' bgcolor='yellow'><b>Purchasing UOM<b></td><td width='10%' bgcolor='yellow'><b>Stock UOM<b></td><td width='10%' bgcolor='yellow'><b>Purchase Weight<b></td><td width='10%' bgcolor='yellow'><b>Inventory Qty<b></td><td width='10%' bgcolor='yellow'><b>Item Description<b></td><td width='10%' bgcolor='yellow'><b>Item Description<b></td>";
		*/


		tableHeaders[0]="<TABLE cellspacing=0 cellpadding=2 id=header border='1' style='table-layout:fixed' width='100%'><COL WIDTH='300'><COL WIDTH='300'><COL WIDTH='300'><tr><th width=500 bgcolor='lightgrey'>MODEL</th><th width=500 bgcolor='lightgrey'>BOOK</th><th width=500 bgcolor='lightgrey'>COST</th></tr></TABLE><DIV STYLE='overflow: auto; height: 500; border-left: 1px gray solid; border-bottom: 1px gray solid; padding:0px; margin: 0px'><TABLE cellspacing=0 cellpadding=2 BORDER='1' width='100%'  style='table-layout:fixed'><COL WIDTH='300'><COL WIDTH='300'><COL WIDTH='300'>";
		tableHeaders[1]="<TABLE cellspacing=0 cellpadding=2 id=header border='1' style='table-layout:fixed' width='100%'><COL WIDTH=100><COL WIDTH=100><COL WIDTH=500><COL WIDTH=100><COL WIDTH=100><tr><th width=150 bgcolor='lightgrey'>MODEL</th><th width=200 bgcolor='lightgrey'>BOOK</th><th width=500 bgcolor='lightgrey'>DESCRIPTION</th><th width=200 bgcolor='lightgrey'>COST</th><th width=200 bgcolor='lightgrey'>UM</th></tr></TABLE><DIV STYLE='overflow: auto; height: 500; border-left: 1px gray solid; border-bottom: 1px gray solid; padding:0px; margin: 0px'><TABLE cellspacing=0 cellpadding=2 BORDER='1' width='100%'  style='table-layout:fixed'><COL WIDTH=100><COL WIDTH=100><COL WIDTH=500><COL WIDTH=100><COL WIDTH=100>";
		tableHeaders[2]="<TABLE cellspacing=0 cellpadding=2 id=header border='1' WIDTH='100%'><COL WIDTH=100><COL WIDTH=50><COL WIDTH=50><COL WIDTH=50><COL WIDTH=50><COL WIDTH=50><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><tr><th bgcolor='lightgrey'>MODEL</th><th bgcolor='lightgrey'>U<br>O<br>M</th><th bgcolor='lightgrey'>WGT</th><th bgcolor='lightgrey'>COST</th><th bgcolor='lightgrey'>BOOK</th><th bgcolor='lightgrey'>VB</th><th bgcolor='lightgrey'>FB1</th><th bgcolor='lightgrey'>FB2</th><th bgcolor='lightgrey'>FB2L</th><th bgcolor='lightgrey'>FB3</th><th bgcolor='lightgrey'>FB4</th></tr></TABLE><DIV STYLE='overflow: auto; height: 500; border-left: 1px gray solid; border-bottom: 1px gray solid; padding:0px; margin: 0px'><TABLE cellspacing=0 cellpadding=2 BORDER='1' width='100%'  style='table-layout:fixed'><COL WIDTH=100><COL WIDTH=50><COL WIDTH=50><COL WIDTH=50><COL WIDTH=50><COL WIDTH=50><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100>";
		//tableHeaders[3]="<TABLE cellspacing=0 cellpadding=2 id=header border='1' style='table-layout:fixed' width='100%'><COL WIDTH=200><COL WIDTH=100><COL WIDTH=200><COL WIDTH=200><COL WIDTH=200><tr><th bgcolor='lightgrey'>MODEL</th><th bgcolor='lightgrey'>UM</th><th bgcolor='lightgrey'>WEIGHT</th><th bgcolor='lightgrey'>COST</th><th bgcolor='lightgrey'>BOOK</th></tr></TABLE><DIV STYLE='overflow: auto; height: 500; border-left: 1px gray solid; border-bottom: 1px gray solid; padding:0px; margin: 0px'><TABLE cellspacing=0 cellpadding=2 BORDER='1' width='100%'  style='table-layout:fixed'><COL WIDTH=200><COL WIDTH=100><COL WIDTH=200><COL WIDTH=200><COL WIDTH=200>";
		tableHeaders[3]="<TABLE cellspacing=0 cellpadding=2 id=header border='1' style='table-layout:fixed' width='100%'><COL WIDTH=100><COL WIDTH=100><COL WIDTH=50><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=150><tr><th bgcolor='lightgrey'>MODEL</th><th bgcolor='lightgrey'>BPCS</th><th bgcolor='lightgrey'>UM</th><th bgcolor='lightgrey'>COST</th><th bgcolor='lightgrey'>L4_PRICE</th><th bgcolor='lightgrey'>L5_PRICE</th><th bgcolor='lightgrey'>L6_PRICE</th><th bgcolor='lightgrey'>L8_PRICE</th><th bgcolor='lightgrey'>L10_PRICE</th><th bgcolor='lightgrey'>WGT</th><th bgcolor='lightgrey'>Description</th></tr></TABLE><DIV STYLE='overflow: auto; height: 500; border-left: 1px gray solid; border-bottom: 1px gray solid; padding:0px; margin: 0px'><TABLE cellspacing=0 cellpadding=2 BORDER='1' width='100%'  style='table-layout:fixed'><COL WIDTH=100><COL WIDTH=100><COL WIDTH=50><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=150>";
		tableHeaders[4]="<TABLE cellspacing=0 cellpadding=2 id=header border='1' style='table-layout:fixed' width='100%'><COL WIDTH=100><COL WIDTH=100><COL WIDTH=50><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=150><tr><th bgcolor='lightgrey'>BPCS</th><th bgcolor='lightgrey'>MODEL</th><th bgcolor='lightgrey'>UM</th><th bgcolor='lightgrey'>COST</th><th bgcolor='lightgrey'>L4_PRICE</th><th bgcolor='lightgrey'>L5_PRICE</th><th bgcolor='lightgrey'>L6_PRICE</th><th bgcolor='lightgrey'>WGT</th><th bgcolor='lightgrey'>Description</th></tr></TABLE><DIV STYLE='overflow: auto; height: 500; border-left: 1px gray solid; border-bottom: 1px gray solid; padding:0px; margin: 0px'><TABLE cellspacing=0 cellpadding=2 BORDER='1' width='100%'  style='table-layout:fixed'><COL WIDTH=100><COL WIDTH=100><COL WIDTH=50><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=150>";
		tableHeaders[5]="<TABLE cellspacing=0 cellpadding=2 id=header border='1' style='table-layout:fixed' width='100%'><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=50><COL WIDTH=50><COL WIDTH=100><COL WIDTH=100><COL WIDTH=150><COL WIDTH=150><tr><th width=200 bgcolor='lightgrey'>ITEM#</th><th bgcolor='lightgrey'>PURCHASE COST</th><th bgcolor='lightgrey'>BUISNESS UNIT</th><th bgcolor='lightgrey'>PURCHASING UOM</th><th bgcolor='lightgrey'>STOCK UOM</th><th bgcolor='lightgrey'>PURCHASE WEIGHT</th><th bgcolor='lightgrey'>INVENTORY QTY</th><th bgcolor='lightgrey'>ITEM DESCRIPTION</th><th bgcolor='lightgrey'>ITEM DESCRIPTION 2</th></tr></TABLE><DIV STYLE='overflow: auto; height: 500; border-left: 1px gray solid; border-bottom: 1px gray solid; padding:0px; margin: 0px'><TABLE cellspacing=0 cellpadding=2 BORDER='1' width='100%'  style='table-layout:fixed'><COL WIDTH=100><COL WIDTH=100><COL WIDTH=100><COL WIDTH=50><COL WIDTH=50><COL WIDTH=100><COL WIDTH=100><COL WIDTH=150><COL WIDTH=150>";




















		String querys[] = new String[7];
		int numColumns[] = new int[7];
		int formatArray[][] = new int[7][12];

		querys[0]="Select model, book, cost from CS_EFS_PRICING where model like '" + param + "%' and (inactive not like 'Y' or inactive is null) order by model";
		numColumns[0]=3;
		formatArray[0][0]=0;formatArray[0][1]=1;formatArray[0][2]=1;


		querys[1]="Select model, book, description, cost, um from CS_EFS_ADDERS where model like '" + param + "%' order by model";
		numColumns[1]=5;
		formatArray[1][0]=0;formatArray[1][1]=1;formatArray[1][2]=0;formatArray[1][3]=1;formatArray[1][4]=0;


		querys[2]="Select model, uom, weight, cost, book, vb, fb1, fb2, fb2l, fb3, fb4 from CS_EJC_PRICING where model like '"+param+"%' and (inactive not like 'Y' or inactive is null) order by model";
		numColumns[2]=11;
		formatArray[2][0]=0;formatArray[2][1]=0;formatArray[2][2]=1;formatArray[2][3]=1;formatArray[2][4] = 1; formatArray[2][5]=0;formatArray[2][6]=0;formatArray[2][7]=0;formatArray[2][8]=0;formatArray[2][9]=0;formatArray[2][10]=0;

/*
		querys[3]="select model, um, weight, cost, book from CS_EJC_FB where model like '"+param+"%' order by model";
		numColumns[3]=5;
		formatArray[3][0]=0;formatArray[3][1]=0;formatArray[3][2]=1;formatArray[3][3]=1;formatArray[3][4]=1;
*/
		querys[3]="Select model, BPCS, UM, COSt, L4_Price, L5_PRICE, L6_price,l8_price,l10_price, wgt,description from cs_IWP_PRICING where model like '"+param+"%' and (inactive not like 'Y' or inactive is null) order by model";
		numColumns[3]=11;
		formatArray[3][0]=0;formatArray[3][1]=0;formatArray[3][2]=0;formatArray[3][3]=1;formatArray[3][4]=1;formatArray[3][5]=1;formatArray[3][6]=1;formatArray[3][7]=1;formatArray[3][8]=1;formatArray[3][9]=0;formatArray[3][10]=0;

		querys[4]="Select bpcs, model, UM, cost, l4_price, l5_price, l6_price, wgt,description from cs_iwp_pricing where bpcs like '"+param+"%' and (inactive not like 'Y' or inactive is null) order by bpcs";
		numColumns[4]=9;
		formatArray[4][0]=0;formatArray[4][1]=0;formatArray[4][2]=0;formatArray[4][3]=1;formatArray[4][4]=1;formatArray[4][5]=1;formatArray[4][6]=1;formatArray[4][7]=0;formatArray[4][8]=0;

		querys[5]="Select PRCITM,PRCCST,PRCSBU,PRCPUM,PRCSUM,PRCWGT,PRCBAL,PRCDSC,PRCDS2 from PRC001PF where PRCITM like '"+param.toUpperCase()+"%' order by PRCSBU,PRCITM";
		numColumns[5]=9;
		formatArray[5][0]=0;formatArray[5][1]=1;formatArray[5][2]=0;formatArray[5][3]=0;formatArray[5][4]=0;formatArray[5][5]=1;formatArray[5][6]=1;formatArray[5][7]=0;


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
				if(tableNumber ==5){
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
								result=" &nbsp; ";
							}
							if(formatArray[tableNumber][i-1]==1){
								if(!result.equals(" &nbsp; ")){
									result=result+"0000";
									decIndex=result.indexOf(".");
									if(decIndex>=0){
										result=result.substring(0,decIndex+5);
									}
								}

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
	//}
	//else{
	//	out.println("<font color='red' size='6'>Access this page through Erapid only</font>");
	//}
//}
//else{
//	out.println("<font color='red' size='6'>Access this page through Erapid only</font>");
//}

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
