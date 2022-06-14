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
		<title>Show Competitor</title>

		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>
	<body>
		<%
//out.println(userSession.getUserId()+":::");
		//if ((userSession.getUserId()!=null)){

			String group=userSession.getGroup();

			//if(group != null && group.trim().length()>0){
		%>

		<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con.jsp"%>
		<%

		//Greg Suisham - CS Group
		//mode which is a number for the table is passed in threw the url, as well as the string we are searching the table for
		//this is page check the url mode attribute and given the results runs a specific query with a specific table header

		//get variables for url

		String tableNum = request.getParameter("mode");
		String param = request.getParameter("param");
		String company=request.getParameter("company");
		if(company==null){ company="";}
		if(param==null){ param="";}

		out.println("<form action='show_competitor.jsp' method='post'>");
		out.println("<table align=center border=0 cellspacing='1' cellpadding='2'>");
		String selected="";
		//out.println(company);
		out.println("<tr><td width='30%'><select name='company' size =1>");
		if(company.equals("CS")){
			selected="selected";
		}
		out.println("<option value='CS' "+selected+">CS</OPTION>");
		selected="";
		if(company.equals("IPC")){
			selected="selected";
		}
		out.println("<option value='IPC' "+selected+">IPC</OPTION>");
		selected="";
		if(company.equals("PAWLING")){
			selected="selected";
		}
		out.println("<option value='PAWLING' "+selected+">PAWLING</OPTION>");
		selected="";
		if(company.equals("KOROGARD")){
		selected="selected";
		}
		out.println("<option value='KOROGARD' "+selected+">KOROGARD</OPTION>");
		selected="";
		if(company.equals("ARDEN")){
			selected="selected";
		}
		out.println("<option value='ARDEN' "+selected+">ARDEN</OPTION>");
		selected="";
		if(company.equals("WALLGAURD")){
			selected="selected";
		}
		out.println("<option value='WALLGAURD' "+selected+">WALLGAURD</OPTION>");
		selected="";
		if(company.equals("BALCO")){
			selected="selected";
		}
		out.println("<option value='BALCO' "+selected+">BALCO</OPTION>");
		selected="";
		if(company.equals("TEPROMARK")){
			selected="selected";
		}
		out.println("<option value='TEPROMARK' "+selected+">TEPROMARK</OPTION>");
		selected="";
		if(company.equals("NYSTROM")){
			selected="selected";
		}
		out.println("<option value='NYSTROM' "+selected+">NYSTROM</OPTION>");
		selected="";
		if(company.equals("ALPAR")){
			selected="selected";
		}
		out.println("<option value='ALPAR' "+selected+">ALPAR</OPTION>");
		selected="";
		out.println("</select></td>");

		out.println("<td width='30%'><input type=text name='param' size=15></td><td width='30%'><input type=submit value='SUBMIT'></tr></table></form>");



		int tableNumber = 0;

		String querys[] = new String[1];
		int numColumns[] = new int[1];
		int formatArray[][] = new int[1][10];
		String tableHeaders[] = new String[1];
		tableHeaders[0]="<TABLE width='100%'><TR><td align='center' class='header'>CS</TD><td align='center' class='header'>IPC</TD><td align='center' class='header'>PAWLING</TD><td align='center' class='header'>KOROGARD</TD><td align='center' class='header'>ARDEN</TD><td align='center' class='header'>WALLGAURD</TD><td align='center' class='header'>BALCO</TD><td align='center' class='header'>TEPROMARK</TD><td align='center' class='header'>NYSTROM</TD><td align='center' class='header'>ALPAR</TD></TR>";


		querys[0]="Select cs, ipc, pawling, korogard, arden, wallgaurd,balco,tepromark,nystrom,alpar from cs_iwp_competitor where "+company+" like '" + param + "%' order by cs";
















		numColumns[0]=10;
		formatArray[0][0]=0;formatArray[0][1]=0;formatArray[0][2]=0;formatArray[0][3]=0;formatArray[0][4]=0;formatArray[0][5]=0;formatArray[0][6]=0;formatArray[0][7]=0;formatArray[0][8]=0;formatArray[0][9]=0;
		String backCol;
		String tblFormat;
		String result;
		int decIndex;

		try{

			if(param.trim().length() > 0){

				out.println("<center><font size=5><b>Items found that start with '" + param + " '<b></font><br><br><center>");
				out.println(tableHeaders[tableNumber]);

				ResultSet rs_query;
				rs_query = stmt.executeQuery(querys[tableNumber]);
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
		myConn.close();

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