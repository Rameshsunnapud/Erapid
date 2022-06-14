<html>
<head>
<title>GE Maint</title>
<link rel='stylesheet' href='style1.css' type='text/css' />
</head>
<script language="JavaScript">
function initSelectedNotes( ) {
	this.moveTo(0, 0);
	this.resizeTo(screen.width, screen.height);
	set();
}
function formCheck(x){
	var msg
	var test
	msg=" Are you sure?";
	test=confirm(msg);		
	if(test){
		document.location.href=x;
	}	
}
function set(){
	try{
		if(eval(document.editSave)){
			if(document.editSave.mode.value=="reset"){
				document.editSave.mode.value="tablePreview";
				document.editSave.submit();
			}
		}
	}
	catch(e){
		alert(e);
	}
	var x=document.form1.table.value;
	//if(x==0){
	//	div0.style.visibility='visible';	
	//}
	//else{
	//	div0.style.visibility='hidden';
	//}
	//if(x==1){
	//	div1.style.visibility='visible';	
	//}
	//else{
	//	div1.style.visibility='hidden';
	//}
	//if(x==2){
	//	div2.style.visibility='visible';	
	//}
	//else{
	//	div2.style.visibility='hidden';
	//}
}
</script>
<body onload='initSelectedNotes()'>
<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" import="java.lang.*" errorPage="error.jsp" %>
<%@ include file="db_con.jsp"%>
<%
DecimalFormat for1 = new DecimalFormat("####.###");
for1.setMaximumFractionDigits(3);
myConn.setAutoCommit(false);
out.println(" <center><font color='336699' size='3'><b>WELCOME TO GE MAINTENANCE</b></font><center>");
String mode=request.getParameter("mode");
String table=request.getParameter("table");
if(mode==null || mode.equals("null")){
	mode="";
}
if(table==null || table.equals("null")){
	table="";
}
String tableName[] = new String[4];
String specificWhere[]=new String[4];
String columnNames[][] = new String[4][16];
String keys[][] = new String[4][3];//if number of keys changes, you will have to add more input to the filter boxes

tableName[0]="CS_GE_COSTS";
specificWhere[0]=" ";
columnNames[0][0] = "MODELCONTROL";
columnNames[0][1] = "MODEL_COST";
columnNames[0][2] = "STOCKED_COST";
columnNames[0][3] = "COMPONENT_COST";
columnNames[0][4] = "WHSE";
columnNames[0][5] = "CALCMODEL_COST40";
columnNames[0][6] = "CALCMODEL_COST45";
columnNames[0][7] = "CALCMODEL_COST50";
columnNames[0][8] = "CALCSTOCKED_COST40";
columnNames[0][9] = "CALCSTOCKED_COST45";
columnNames[0][10]= "CALCSTOCKED_COST50";
columnNames[0][11]= "CALCCOMPONENT_COST40";
columnNames[0][12]= "CALCCOMPONENT_COST45";
columnNames[0][13]= "CALCCOMPONENT_COST50";
keys[0][0]="MODELCONTROL";

tableName[1]="CS_GE_PRICING";
specificWhere[1]=" ";
columnNames[1][0] = "MODEL";
columnNames[1][1] = "DESCRIPTION";
columnNames[1][2] = "COST";
columnNames[1][3] = "UM";
columnNames[1][4] = "BPCS";
columnNames[1][5] = "WHSE";
columnNames[1][6] = "CALCCOST40";
columnNames[1][7] = "CALCCOST45";
columnNames[1][8] = "CALCCOST50";
keys[1][0]="MODEL";
keys[1][1]="DESCRIPTION";
keys[1][2]="BPCS";

tableName[2]="CS_ELM_PRICING";
specificWhere[2]=" ";
columnNames[2][0] = "MODEL";
columnNames[2][1] = "DESCRIPTION";
columnNames[2][2] = "BPCS";
columnNames[2][3] = "WHSE";
columnNames[2][4] = "COST";
columnNames[2][5] = "UM";
columnNames[2][6] = "L1";
columnNames[2][7] = "L2";
columnNames[2][8] = "L3";
columnNames[2][9] = "L4";
columnNames[2][10]= "L5";
columnNames[2][11]= "L6";
columnNames[2][12]= "L7";
columnNames[2][13]= "L8";
columnNames[2][14]= "L9";
columnNames[2][15]= "L10";
keys[2][0]="MODEL";
keys[2][1]="DESCRIPTION";
keys[2][2]="BPCS";

tableName[3]="CS_GE_VENDOR_ITEMS";
specificWhere[3]=" ";
columnNames[3][0] = "PART_NO";
columnNames[3][1] = "ITEM_NAME";
columnNames[3][2] = "DESCRIPTION";
columnNames[3][3] = "PART_COST";
columnNames[3][4] = "PART_UM";
columnNames[3][5] = "DATE_UPDATED";
columnNames[3][6] = "WHSE";
columnNames[3][7] = "CALCPART_COST40";
columnNames[3][8] = "CALCPART_COST45";
columnNames[3][9] = "CALCPART_COST50";
keys[3][0]="PART_NO";
keys[3][1]="ITEM_NAME";
keys[3][2]="DESCRIPTION";

out.println("<form name='form1' action='ge_search_new.jsp'>");
out.println("<input type='hidden' name='mode' value='tablePreview'>");
out.println("<table><tr><td>");
String select="";
String selectOptions="";
for(int x=0; x<tableName.length; x++){
	if(table != null && table.trim().length()>0){
		if(x==Integer.parseInt(table)){
			select="selected";
		}
	}	
	selectOptions=selectOptions+"<option value='"+x+"' "+select+">"+tableName[x]+"</option>";
	select="";
}
//out.println("<div id='div"+x+"' style='visibility:hidden;position: absolute; left: 10px; top: 80px; height: 400px; width: 100px; padding: 1em '>");
//for(int y=0; y<keys[x].length; y++){
//	if(keys[x][y] != null && keys[x][y].trim().length()>0){
out.println("<label for='resultx'><Input type='text' name='resultx' >search for</label>");
//	}
//}
//out.println("</div>");	
//out.println("</td>");
//out.println("<div id='test' style='position: absolute; left: 300px; top: 80px; height: 400px; width: 100px; padding: 1em '>");
//out.println("<BR><BR><BR><table border='1'><tr><td>");
out.println("</td><td><select name='table' onchange='set()'>");
out.println(selectOptions);
out.println("</select></td>");

out.println("<td><input type='submit' value='submit'></td></tr></table><BR><BR>");
out.println("</form>");
//out.println("</div>");
out.println("<form name='form2'>");
out.println("<input type='hidden' name='table' value='"+table+"'>");
//out.println("<div id='test' style='position: absolute; left: 10px; top: 200px; height: 400px; width: 100px; padding: 1em '>");
if(!table.equals("null")&&table.trim().length()>0){
	int x=Integer.parseInt(table);
	int rowCount=0;
	String sql="Select ";
	String sql2="";
	out.println("<center><table border='1'><tr>");
	
	for(int y=0;y<columnNames[x].length; y++){
		if(columnNames[x][y] != null && columnNames[x][y].trim().length()>0){
			if(!columnNames[x][y].startsWith("CALC")){			
				sql=sql+columnNames[x][y]+",";
				out.println("<td>"+columnNames[x][y]+"</td>");
				//rowCount++;
			}
			else{
				out.println("<td align='center'>"+columnNames[x][y].substring(4,columnNames[x][y].length()-2) +"<BR>"+columnNames[x][y].substring(columnNames[x][y].length()-2) +"% GP</td>");
				sql2=sql2+"(cast("+columnNames[x][y].substring(4,columnNames[x][y].length()-2)+" as float))/(1-"+new Double(columnNames[x][y].substring(columnNames[x][y].length()-2)).doubleValue()/100+"),";
			}
			rowCount++;
		}
	}
	if(sql2.trim().length()>1){
		sql=sql+sql2;
	}
	sql=sql.substring(0,sql.length()-1)+" from "+tableName[x];
	//out.println(sql+"::<BR>");
	out.println("</tr>");
	String whereClause=" ";
	if(specificWhere[x] != null && specificWhere[x].trim().length()>0){
		whereClause=specificWhere[x];
	}
	else{
		whereClause=" where ";
	}
	for(int j=0; j<keys[x].length; j++){
		if(keys[x][j] != null && keys[x][j].trim().length()>0){
			String tempKey=request.getParameter("resultx");
			if(tempKey==null||tempKey.equals("null")){
				tempKey="";
			}
			whereClause=whereClause+keys[x][j]+" like '%"+tempKey+"%' or ";		
		}
	}
	whereClause=whereClause.substring(0,whereClause.length()-4);
	sql=sql+whereClause;
	String key="";
	//out.println(sql+"::<BR>");

	ResultSet rs1=stmt.executeQuery(sql);
	if(rs1 != null){
		while(rs1.next()){
			out.println("<tr>");
			for(int i=1; i<rowCount+1; i++){
			
				if(rs1.getString(i) != null && rs1.getString(i).trim().length()>0){
					String field=rs1.getString(i);
					try{
						field=for1.format(new Double(field).doubleValue());
					}
					catch(Exception e){
						field=field;
					}
					out.println("<td>"+field+"</td>");
				}
				else{
					out.println("<td>&nbsp;</td>");
				}
			}
		}
	}
	rs1.close();

	out.println("</table></center>");
	out.println("</div");
	out.println("</form");
	
}
myConn.commit();
stmt.close();
myConn.close();
%>
</body>
</html>