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
		<title>ADS Maint</title>
		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>
	<script language="JavaScript">
		function initSelectedNotes( ){
			this.moveTo(0,0);
			this.resizeTo(screen.width,screen.height);
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
			if(x==16){
				div16.style.visibility='visible';
			}
			else{
				div16.style.visibility='hidden';
			}
			if(x==17){
				div17.style.visibility='visible';
			}
			else{
				div17.style.visibility='hidden';
			}
			if(x==18){
				div18.style.visibility='visible';
			}
			else{
				div18.style.visibility='hidden';
			}
			if(x==19){
				div19.style.visibility='visible';
			}
			else{
				div19.style.visibility='hidden';
			}
			if(x==20){
				div20.style.visibility='visible';
			}
			else{
				div20.style.visibility='hidden';
			}
			if(x==21){
				div21.style.visibility='visible';
			}
			else{
				div21.style.visibility='hidden';
			}
		}
	</script>
	<body onload='initSelectedNotes()'>
		<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" import="java.lang.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con.jsp"%>
		<%
		NumberFormat for1 = NumberFormat.getInstance();
		for1.setMaximumFractionDigits(3);
		myConn.setAutoCommit(false);
		out.println(" <center><font color='336699' size='3'><b>WELCOME TO ADS MAINTENANCE</b></font><center>");
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
		String tableName[] = new String[22];
		String specificWhere[]=new String[22];
		String columnNames[][] = new String[22][21];
		String keys[][] = new String[22][3];//if number of keys changes, you will have to add more input to the filter boxes

		tableName[0]="CS_DEFAULTS";
		specificWhere[0]=" where product_id='ADS' and ";
		//columnNames[0][0]="PRODUCT_ID";
		columnNames[0][0]="HRRATE";
		columnNames[0][1]="ENGHRRATE";
		columnNames[0][2]="PMHRRATE";
		columnNames[0][3]="FCPERC";
		keys[0][0]="";

		tableName[1]="CS_ADS_AMS";
		specificWhere[1]=" ";
		columnNames[1][0]="MODEL";
		columnNames[1][1]="M2";
		columnNames[1][2]="M7";
		columnNames[1][3]="M8";
		columnNames[1][4]="WEIGHT";
		columnNames[1][5]="UM";
		columnNames[1][6]="DESCRIPTION";
		columnNames[1][7]="EDIT_DATE";
		keys[1][0]="MODEL";

		tableName[2]="CS_ADS_AST";
		specificWhere[2]=" ";
		columnNames[2][0]="MODEL";
		columnNames[2][1]="TYPE";
		columnNames[2][2]="DESCRIPTION";
		columnNames[2][3]="M4";
		columnNames[2][4]="M9";
		columnNames[2][5]="M49";
		columnNames[2][6]="M99";
		columnNames[2][7]="M100";
		columnNames[2][8]="WEIGHT";
		columnNames[2][9]="UM";
		columnNames[2][10]="EDIT_DATE";
		keys[2][0]="MODEL";
		keys[2][1]="TYPE";

		tableName[3]="CS_ADS_BLOCKING";
		specificWhere[3]=" ";
		columnNames[3][0]="MODEL";
		columnNames[3][1]="RATING";
		columnNames[3][2]="SIZES";
		columnNames[3][3]="DESCRIPTION";
		columnNames[3][4]="M9";
		columnNames[3][5]="M49";
		columnNames[3][6]="M99";
		columnNames[3][7]="M100";
		columnNames[3][8]="WEIGHT";
		columnNames[3][9]="UM";
		columnNames[3][10]="EDIT_DATE";
		keys[3][0]="MODEL";
		keys[3][1]="RATING";
		keys[3][2]="SIZES";

		tableName[4]="CS_ADS_COORDINATION";
		specificWhere[4]=" ";
		columnNames[4][0]="COORDINATION";
		columnNames[4][1]="CHARGE";
		keys[4][0]="COORDINATION";

		tableName[5]="CS_ADS_CORE";
		specificWhere[5]=" ";
		columnNames[5][0]="MODEL";
		columnNames[5][1]="TYPE";
		columnNames[5][2]="CORE";
		columnNames[5][3]="DESCRIPTION";
		columnNames[5][4]="STD";
		columnNames[5][5]="THICK";
		columnNames[5][6]="M10";
		columnNames[5][7]="M29";
		columnNames[5][8]="M100";
		columnNames[5][9]="M239";
		columnNames[5][10]="M240";
		columnNames[5][11]="NOM_SIZE";
		columnNames[5][12]="ORDER_NO";
		columnNames[5][13]="NOM_WID";
		columnNames[5][14]="NOM_HGT";
		columnNames[5][15]="WEIGHT";
		columnNames[5][16]="UM";
		columnNames[5][17]="DOOR";
		columnNames[5][18]="PAIR_CORES";
		columnNames[5][19]="RAIL_CORES";
		columnNames[5][20]="EDIT_DATE";
		keys[5][0]="MODEL";

		tableName[6]="CS_ADS_CVR";
		specificWhere[6]=" ";
		columnNames[6][0]="RATING";
		columnNames[6][1]="COST";
		columnNames[6][2]="WEIGHT";
		columnNames[6][3]="UM";
		columnNames[6][4]="DESCRIPTION";
		columnNames[6][5]="EDIT_DATE";
		keys[6][0]="RATING";

		tableName[7]="CS_ADS_CYL_TEMP";
		specificWhere[7]=" ";
		columnNames[7][0]="MANUFACTURER";
		columnNames[7][1]="EXIT_MAN";
		columnNames[7][2]="EXIT_MOD";
		columnNames[7][3]="MFG_TEMP";
		columnNames[7][4]="ADS_TEMP";
		keys[7][0]="EXIT_MAN";
		keys[7][1]="EXIT_MOD";

		tableName[8]="CS_ADS_EDGES";
		specificWhere[8]=" ";
		columnNames[8][0]="STYLE";
		columnNames[8][1]="TYPE";
		columnNames[8][2]="MAX_HGT";
		columnNames[8][3]="DESCRIPTION";
		columnNames[8][4]="M4";
		columnNames[8][5]="M9";
		columnNames[8][6]="M49";
		columnNames[8][7]="M99";
		columnNames[8][8]="M100";
		columnNames[8][9]="WEIGHT";
		columnNames[8][10]="UM";
		columnNames[8][11]="EDIT_DATE";
		keys[8][0]="STYLE";
		keys[8][1]="TYPE";
		keys[8][2]="MAX_HGT";

		tableName[9]="CS_ADS_EXIT_DEVICES";
		specificWhere[9]=" ";
		columnNames[9][0]="MANUFACTURER";
		columnNames[9][1]="EXIT_MAIN";
		columnNames[9][2]="TYPE";
		columnNames[9][3]="EXIT_MODEL";
		columnNames[9][4]="MODEL";
		columnNames[9][5]="FUNC";
		columnNames[9][6]="TRI";
		columnNames[9][7]="MFG_TEMP";
		columnNames[9][8]="ADS_TEMP";
		columnNames[9][9]="REVISION_DATE";
		keys[9][0]="EXIT_MODEL";

		tableName[10]="CS_ADS_FLUSHBOLTS";
		specificWhere[10]=" ";
		columnNames[10][0]="MANUFACTURER";
		columnNames[10][1]="FBOLT_MAN";
		columnNames[10][2]="FBOLT_MOD";
		columnNames[10][3]="MODEL";
		columnNames[10][4]="TYPE";
		columnNames[10][5]="MFG_TEMP";
		columnNames[10][6]="KVAL";
		columnNames[10][7]="EFF_DATE";
		keys[10][0]="FBOLT_MOD";

		tableName[11]="CS_ADS_FRAMES";
		specificWhere[11]=" ";
		columnNames[11][0]="MANUF";
		columnNames[11][1]="HEIGHT";
		columnNames[11][2]="HINGE";
		columnNames[11][3]="H1";
		columnNames[11][4]="H2";
		columnNames[11][5]="H3";
		columnNames[11][6]="STRIKE";
		columnNames[11][7]="CL0";
		columnNames[11][8]="ML0";
		keys[11][0]="MANUF";
		keys[11][1]="HEIGHT";
		keys[11][2]="HINGE";

		tableName[12]="CS_ADS_LABOR";
		specificWhere[12]=" ";
		columnNames[12][0]="MODEL";
		columnNames[12][1]="TYPE";
		columnNames[12][2]="COOR";
		columnNames[12][3]="DESCRIPTION";
		columnNames[12][4]="HOURS";
		columnNames[12][5]="RATE";
		columnNames[12][6]="COST";
		columnNames[12][7]="EFF";
		columnNames[12][8]="VAL";
		columnNames[12][9]="EDIT_DATE";
		keys[12][0]="MODEL";
		keys[12][1]="TYPE";
		keys[12][2]="COOR";

		tableName[13]="CS_ADS_LFK";
		specificWhere[13]=" ";
		columnNames[13][0]="MODEL";
		columnNames[13][1]="INFO";
		columnNames[13][2]="DESCRIPTION";
		columnNames[13][3]="MULT";
		columnNames[13][4]="ADDS";
		columnNames[13][5]="MAT";
		columnNames[13][6]="UM";
		columnNames[13][7]="WEIGHT";
		columnNames[13][8]="EDIT_DATE";
		keys[13][0]="MODEL";
		keys[13][1]="INFO";

		tableName[14]="CS_ADS_MACHINE";
		specificWhere[14]=" ";
		columnNames[14][0]="TYPE";
		columnNames[14][1]="COOR";
		columnNames[14][2]="LVL";
		columnNames[14][3]="DESCRIPTION";
		columnNames[14][4]="HOURS";
		columnNames[14][5]="RATE";
		columnNames[14][6]="COST";
		columnNames[14][7]="EFF";
		columnNames[14][8]="VAL";
		columnNames[14][9]="EDIT_DATE";
		keys[14][0]="TYPE";
		keys[14][1]="COOR";
		keys[14][2]="LVL";

		tableName[15]="CS_ADS_MARGIN";
		specificWhere[15]=" ";
		columnNames[15][0]="MODEL";
		columnNames[15][1]="DESCRIPTION";
		columnNames[15][2]="CS30";
		columnNames[15][3]="CS99";
		columnNames[15][4]="CS100";
		columnNames[15][5]="DECO30";
		columnNames[15][6]="DECO99";
		columnNames[15][7]="DECO100";
		columnNames[15][8]="EDIT_DATE";
		keys[15][0]="MODEL";

		tableName[16]="CS_ADS_MISC";
		specificWhere[16]=" ";
		columnNames[16][0]="ITEM";
		columnNames[16][1]="COST";
		columnNames[16][2]="WEIGHT";
		columnNames[16][3]="UM";
		columnNames[16][4]="DESCRIPTION";
		columnNames[16][5]="EDIT_DATE";
		keys[16][0]="ITEM";

		tableName[17]="CS_ADS_PIVOTS";
		specificWhere[17]=" ";
		columnNames[17][0]="manufacturer";
		columnNames[17][1]="hinge_man";
		columnNames[17][2]="pivot_mod";
		columnNames[17][3]="type";
		columnNames[17][4]="model";
		columnNames[17][5]="mfg_temp";
		columnNames[17][6]="edit_date";
		columnNames[17][7]="ads_temp";
		keys[17][0]="pivot_mod";

		tableName[18]="CS_ADS_ROUTING_ADJUST";
		specificWhere[18]=" ";
		columnNames[18][0]="feature_block";
		columnNames[18][1]="feature_detail";
		columnNames[18][2]="ssizes";
		columnNames[18][3]="options";
		columnNames[18][4]="machine_level";
		columnNames[18][5]="ropno_660";
		columnNames[18][6]="ropno_675";
		columnNames[18][7]="ropno_700";
		columnNames[18][8]="ropno_710";
		columnNames[18][9]="ropno_720";
		columnNames[18][10]="ropno_750";
		columnNames[18][11]="ropno_760";
		columnNames[18][12]="notes";
		columnNames[18][13]="effective_date";
		keys[18][0]="feature_block";
		keys[18][1]="feature_detail";
		keys[18][2]="ssizes";

		tableName[19]="CS_ADS_SHEET";
		specificWhere[19]=" ";
		columnNames[19][0]="MODEL";
		columnNames[19][1]="SIZE1";
		columnNames[19][2]="TYPE";
		columnNames[19][3]="UM";
		columnNames[19][4]="DESCRIPTION";
		columnNames[19][5]="M10";
		columnNames[19][6]="M29";
		columnNames[19][7]="M100";
		columnNames[19][8]="M239";
		columnNames[19][9]="M240";
		columnNames[19][10]="MINIMUM";
		columnNames[19][11]="WEIGHT";
		columnNames[19][12]="EDIT_DATE";
		keys[19][0]="MODEL";
		keys[19][1]="SIZE1";
		keys[19][2]="TYPE";

		tableName[20]="CS_ADS_SSKP";
		specificWhere[20]=" ";
		columnNames[20][0]="MODEL_NUMBER";
		columnNames[20][1]="NOMINAL_WIDTH";
		columnNames[20][2]="WIDTH";
		columnNames[20][3]="HEIGHT";
		columnNames[20][4]="TYPE";
		columnNames[20][5]="M9";
		columnNames[20][6]="M49";
		columnNames[20][7]="M99";
		columnNames[20][8]="M100";
		columnNames[20][9]="DOOR_WIDTH";
		columnNames[20][10]="WEIGHT";
		columnNames[20][11]="UM";
		columnNames[20][12]="DESCRIPTION";
		columnNames[20][13]="EDIT_DATE";
		keys[20][0]="MODEL_NUMBER";

		tableName[21]="CS_ADS_STILE";
		specificWhere[21]=" ";
		columnNames[21][0]="MODEL";
		columnNames[21][1]="SHAPE";
		columnNames[21][2]="RATING";
		columnNames[21][3]="DESCRIPTION";
		columnNames[21][4]="M9";
		columnNames[21][5]="M49";
		columnNames[21][6]="M99";
		columnNames[21][7]="M100";
		columnNames[21][8]="WEIGHT";
		columnNames[21][9]="UM";
		columnNames[21][10]="EDIT_DATE";
		keys[21][0]="MODEL";
		keys[21][1]="SHAPE";
		keys[21][2]="RATING";

		out.println("<form name='form1' action='ads_maint_home.jsp'>");
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
			try{
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
						for(int z=0; z<keys[x].length; z++){
							if(keys[x][z] != null && keys[x][z].trim().length()>0){
								key=key+"&key"+(z+1)+"="+rs1.getString(keys[x][z]);
							}
						}
						key="ads_maint_home.jsp?table="+table+key;
						String editKey=key+"&mode=edit";
						String deleteKey=key+"&mode=delete";
						out.println("<td><input type='button' name='EDIT' value='EDIT' onclick=javascript:document.location.href='"+editKey+"'></td>");
						out.println("<td><input type='button' name='DELETE' value='DELETE' onclick=formCheck('"+deleteKey+"')></td>");
						out.println("</tr>");
						key="";
					}
				}
				rs1.close();
			}
			catch(Exception e){
				out.println(e);
			}
			out.println("</table>");
			out.println("</div");
			out.println("</form");
		}
		else if(mode != null && mode.equals("edit")){
			out.println("<form name='editForm' action='ads_maint_home.jsp'>");
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
			out.println("<form name='editSave'  action='ads_maint_home.jsp'>");
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
			out.println("<form name='editSave' onsubmit='ads_maint_home.jsp'>");
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
					if(tempValues.elementAt(w).toString().trim().length()==0){
						updateTable.setString((w+1),null);
					}
					else{
						updateTable.setString((w+1),tempValues.elementAt(w).toString());
					}
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
<%
}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>