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
	//alert("HERE"+document.form1.table.value); 
	var x=document.form1.table.value;
	if(x==0){
		div0.style.visibility='visible';	
	}
	else{
		div0.style.visibility='hidden';
	}
	if(x==1){
		div1.style.visibility='visible';	
	}
	else{
		div1.style.visibility='hidden';
	}
	if(x==2){
		div2.style.visibility='visible';	
	}
	else{
		div2.style.visibility='hidden';
	}
	if(x==3){
		div3.style.visibility='visible';	
	}
	else{
		div3.style.visibility='hidden';
	}
	if(x==4){
		div4.style.visibility='visible';	
	}
	else{
		div4.style.visibility='hidden';
	}
	if(x==5){
		div5.style.visibility='visible';	
	}
	else{
		div5.style.visibility='hidden';
	}
	if(x==6){
		div6.style.visibility='visible';	
	}
	else{
		div6.style.visibility='hidden';
	}
	if(x==7){
		div7.style.visibility='visible';	
	}
	else{
		div7.style.visibility='hidden';
	}
	if(x==8){
		div8.style.visibility='visible';	
	}
	else{
		div8.style.visibility='hidden';
	}
	if(x==9){
		div9.style.visibility='visible';	
	}
	else{
		div9.style.visibility='hidden';
	}
	if(x==10){
		div10.style.visibility='visible';	
	}
	else{
		div10.style.visibility='hidden';
	}
	if(x==11){
		div11.style.visibility='visible';	
	}
	else{
		div11.style.visibility='hidden';
	}
	if(x==12){
		div12.style.visibility='visible';	
	}
	else{
		div12.style.visibility='hidden';
	}
	if(x==13){
		div13.style.visibility='visible';	
	}
	else{
		div13.style.visibility='hidden';
	}
	if(x==14){
		div14.style.visibility='visible';	
	}
	else{
		div14.style.visibility='hidden';
	}
	if(x==15){
		div15.style.visibility='visible';	
	}
	else{
		div15.style.visibility='hidden';
	}
	
	
}
</script>
<body onload='initSelectedNotes()'>
<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" import="java.lang.*" errorPage="error.jsp" %>
<%@ include file="db_con.jsp"%>
<%
NumberFormat for1 = NumberFormat.getInstance(); 
for1.setMaximumFractionDigits(3);
myConn.setAutoCommit(false);
out.println(" <center><font color='336699' size='3'><b>WELCOME TO GE MAINTENANCE</b></font><center>");
//out.println("<table width='100%'><tr><td align='center'><input type='button' name='x' onclick='forwarding()' value='COSTING MAINTENANCE'></td><td align='center'><input type='button' name='x2' onclick='forwarding2()' value='PRICE BREAK MAINTENANCE'></td></tr>");
//out.println("<tr><td colspan='2' align='center'><input type='button' name='x3' onclick='closethis()' value='CLOSE' ></td></tr></table>");
String mode=request.getParameter("mode");
String table=request.getParameter("table");
if(mode==null || mode.equals("null")){
	mode="";
}
if(table==null || table.equals("null")){
	table="";
}
String tableName[] = new String[1];
String specificWhere[]=new String[1];
String columnNames[][] = new String[1][4];
String keys[][] = new String[1][3];//if number of keys changes, you will have to add more input to the filter boxes
int numColumns[] = new int[1];

tableName[0]="CS_GE_COSTS";
specificWhere[0]="";
columnNames[0][0]="MODELCONTROL";
columnNames[0][1]="MODEL_COST";
columnNames[0][2]="STOCKED_COST";
columnNames[0][3]="COMPONENT_COST";
keys[0][0]="MODELCONTROL";
keys[0][1]="MODEL_COST";
keys[0][2]="STOCKED_COST";

out.println("<form name='form1' action='ge_maint_home2.jsp'>");
out.println("<input type='hidden' name='mode' value='tablePreview'>");
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
	out.println("<div id='div"+x+"' style='visibility:hidden;position: absolute; left: 10px; top: 80px; height: 400px; width: 100px; padding: 1em '>");
	for(int y=0; y<keys[x].length; y++){
		if(keys[x][y] != null && keys[x][y].trim().length()>0){
			out.println("<label for='"+keys[x][y]+"'><Input type='text' name='"+keys[x][y]+tableName[x]+"' >"+keys[x][y]+"</label>");
		}
	}
	out.println("</div>");	
}
out.println("<div id='test' style='position: absolute; left: 300px; top: 80px; height: 400px; width: 100px; padding: 1em '>");
out.println("<BR><BR><BR><table border='1'><tr><td>");
out.println("</td><td><select name='table' onchange='set()'>");
out.println(selectOptions);
out.println("</select></td>");
out.println("<td><input type='submit' value='submit'></td></tr></table><BR><BR>");
out.println("</form>");
out.println("</div>");
if(mode != null && mode.equals("tablePreview")&&table!=null&&!table.equals("null")){
	out.println("<form name='form2'>");
	//out.println(request.getParameter("MODEL")+"HERE<BR>");
	out.println("<input type='hidden' name='table' value='"+table+"'>");
	out.println("<div id='test' style='position: absolute; left: 10px; top: 200px; height: 400px; width: 100px; padding: 1em '>");
	int x=Integer.parseInt(table);
	int rowCount=0;
	String sql="Select ";
	out.println("<table border='1'><tr>");
	for(int y=0;y<columnNames[x].length; y++){
		if(columnNames[x][y] != null && columnNames[x][y].trim().length()>0){
			sql=sql+columnNames[x][y]+",";
			out.println("<td>"+columnNames[x][y]+"</td>");
			rowCount++;
		}
	}
	sql=sql.substring(0,sql.length()-1)+" from "+tableName[x];
	out.println("<td>EDIT</td><TD>DELETE</td></tr>");
	String whereClause=" ";
	if(specificWhere[x] != null && specificWhere[x].trim().length()>0){
		whereClause=specificWhere[x];
	}
	else{
		whereClause=" where ";
	}
	for(int j=0; j<keys[x].length; j++){
		if(keys[x][j] != null && keys[x][j].trim().length()>0){
			String tempKey=request.getParameter(keys[x][j]+tableName[x]);
			if(tempKey==null||tempKey.equals("null")){
				tempKey="";
			}
			whereClause=whereClause+keys[x][j]+" like '"+tempKey+"%' and ";		
		}
	}
	whereClause=whereClause.substring(0,whereClause.length()-5);
	sql=sql+whereClause;
	String key="";
	//out.println(sql);
	
	ResultSet rs1=stmt.executeQuery(sql);
	if(rs1 != null){
		while(rs1.next()){
			out.println("<tr>");
			for(int i=1; i<rowCount+1; i++){
				if(rs1.getString(i) != null && rs1.getString(i).trim().length()>0){
					String field=rs1.getString(i);
					if(i>1){
						try{
							field=for1.format(new Double(field).doubleValue());
						}
						catch(Exception e){
							field=field;
						}
					}
					else{
						field=field;
					}
					out.println("<td>"+field+"</td>");
				}
				else{
					out.println("<td>&nbsp;</td>");
				}
			}
			for(int z=0; z<keys[x].length; z++){
				if(keys[x][z] != null && keys[x][z].trim().length()>0){
					key=key+"&key"+(z+1)+"="+rs1.getString(keys[x][z]);			
				}
			}
			key="ge_maint_home2.jsp?table="+table+key;
			String editKey=key+"&mode=edit";
			String deleteKey=key+"&mode=delete";
			out.println("<td><input type='button' name='EDIT' value='EDIT' onclick=javascript:document.location.href='"+editKey+"'></td>");
			out.println("<td><input type='button' name='DELETE' value='DELETE' onclick=formCheck('"+deleteKey+"')></td>");
			out.println("</tr>");
			key="";
		}
	}
	rs1.close();
	
	out.println("</table>");
	out.println("</div");
	out.println("</form");
}
else if(mode != null && mode.equals("edit")){
	out.println("<form name='editForm' action='ge_maint_home2.jsp'>");
	out.println("<input type='hidden' name='mode' value='editSave'>");
	out.println("<input type='hidden' name='table' value='"+table+"'>");
	out.println("<div id='test' style='position: absolute; left: 10px; top: 200px; height: 400px; width: 100px; padding: 1em '>");
	int x=Integer.parseInt(table);
	int numKeys=keys[x].length;
	String keyValues[]=new String[numKeys];
	String whereClause=" ";
	if(specificWhere[x] != null && specificWhere[x].trim().length()>0){
		whereClause=specificWhere[x];
	}
	else{
		whereClause=" where ";
	}
	String sql="";
	for(int i=0; i<keyValues.length; i++){
		if(keys[x][i] != null && keys[x][i].trim().length()>0){
			keyValues[i]=request.getParameter("key"+(i+1));
			whereClause=whereClause+keys[x][i]+"='"+keyValues[i]+"' and ";
		}
	}
	whereClause=whereClause.substring(0,whereClause.length()-4);	
	out.println("<table border='1'><tr>");
	for(int y=0;y<columnNames[x].length; y++){
		if(columnNames[x][y] != null && columnNames[x][y].trim().length()>0){
			boolean isKey=false;
			for(int z=0; z<keys[x].length; z++){
				if(columnNames[x][y].equals(keys[x][z])){
					isKey=true;
				}
			}
			if(! isKey){
				out.println("<td>"+columnNames[x][y]+"</td>");
			}
			else{
				out.println("<td><font color='blue'>"+columnNames[x][y]+"</font></td>");
			}
		}
	}
	out.println("</tr>");	
	whereClause="select * from "+tableName[x]+whereClause;
	ResultSet rsEdit=stmt.executeQuery(whereClause);
	if(rsEdit != null){
		while(rsEdit.next()){
			out.println("<tr>");
			for(int yy=0;yy<columnNames[x].length; yy++){
				if(columnNames[x][yy] != null && columnNames[x][yy].trim().length()>0){
					boolean isKey=false;
					for(int z=0; z<keys[x].length; z++){
						if(columnNames[x][yy].equals(keys[x][z])){
							isKey=true;
						}
					}
					String tempx=rsEdit.getString(columnNames[x][yy]);
					if(tempx == null || tempx.equals("null")){
						tempx="";
					}
					if(! isKey){
						out.println("<td><input type='text' name='"+columnNames[x][yy]+"' value='"+tempx+"'></td>");
					}
					else{
						out.println("<td><input type='text' name='"+columnNames[x][yy]+"' value='"+tempx+"' readonly></td>");
					}
				}
			}
			out.println("</tr>");
		}
	}
	rsEdit.close();
	out.println("<input type='submit' name='submit' value='submit'>");
	out.println("</div>");
	out.println("</form>");
}
else if(mode != null && mode.equals("delete")){
	out.println("<form name='editSave'  action='ge_maint_home2.jsp'>");
	out.println("<input type='hidden' name='mode' value='reset'>");
	out.println("<input type='hidden' name='table' value='"+table+"'>");
	out.println("<div id='test' style='position: absolute; left: 10px; top: 200px; height: 400px; width: 800px; padding: 1em '>");
	int x=Integer.parseInt(table);
	String sqlDelete="delete from "+tableName[x] +" where ";
	for(int z=0; z<keys[x].length; z++){
		if(keys[x][z] !=null && keys[x][z].trim().length()>0){
			sqlDelete=sqlDelete+keys[x][z]+"='"+request.getParameter("key"+(z+1))+"' and ";;
		}
	}
	sqlDelete=sqlDelete.substring(0,sqlDelete.trim().length()-4);
	try{
		int rsDelete=stmt.executeUpdate(sqlDelete);
	}
	catch (java.sql.SQLException e){
		out.println("Problem with deleteing from table");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;		
	}
	out.println("</div>");
	out.println("</form>");	
}
else if(mode != null && mode.equals("editSave")){
	out.println("<form name='editSave' onsubmit='ge_maint_home2.jsp'>");
	out.println("<input type='hidden' name='mode' value='reset'>");
	out.println("<input type='hidden' name='table' value='"+table+"'>");
	out.println("<div id='test' style='position: absolute; left: 10px; top: 200px; height: 400px; width: 800px; padding: 1em '>");
	int x=Integer.parseInt(table);
	Vector tempValues=new Vector();
	String newValues="update "+tableName[x]+" set ";
	String keyValues=" ";
	if(specificWhere[x] != null && specificWhere[x].trim().length()>0){
		keyValues=specificWhere[x];
	}
	else{
		keyValues=" where ";
	}	
	for(int y=0;y<columnNames[x].length; y++){
		if(columnNames[x][y] != null && columnNames[x][y].trim().length()>0){
			boolean isKey=false;
			for(int z=0; z<keys[x].length; z++){
				if(columnNames[x][y].equals(keys[x][z])){
					isKey=true;
				}
			}
			if(! isKey){
				newValues=newValues+columnNames[x][y]+"=?,";
				String tempx=request.getParameter(columnNames[x][y]);
				if(tempx.equals("null") || tempx.trim().length()==0){
					tempx="";
				}
				tempValues.addElement(tempx);
			}
			else{
				keyValues=keyValues+columnNames[x][y]+"=? and ";
			}
		}
	}
	for(int z=0; z<keys[x].length; z++){
		if(keys[x][z] !=null && keys[x][z].trim().length()>0){
			tempValues.addElement(request.getParameter(keys[x][z]));
		}
	}
	newValues=newValues.substring(0,newValues.length()-1);
	keyValues=keyValues.substring(0,keyValues.length()-4);
	String updateSQL=newValues+keyValues;	
	try{
		java.sql.PreparedStatement updateTable=myConn.prepareStatement(updateSQL);
		for(int w=0; w<tempValues.size(); w++){
			updateTable.setString((w+1),tempValues.elementAt(w).toString());
		}
		int rocount=updateTable.executeUpdate();
	}
	catch (java.sql.SQLException e){
		out.println("Problem with entering into table");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;		
	}
	out.println("</div>");
	out.println("</form>");
}
myConn.commit();
stmt.close();
myConn.close();
%>
</body>
</html>