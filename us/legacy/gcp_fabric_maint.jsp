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
		<title>Exclusion Notes</title>
		<script language="JavaScript" src="date-picker.js"></script>
		<script language="JavaScript">
			function goNow(num){
				document.show.recordNum.value=num;
				document.show.operation.value="edit";
				document.show.submit();
			}
			function addNew(num){
				document.show.operation.value="add";
				document.show.submit();
			}
			function goNow1(num){
				document.editThis.recordNum.value=num;
				document.editThis.operation.value="editSave";
				document.editThis.submit();
			}
			function goNow2(num){
				document.addThis.operation.value="addSave";
				document.addThis.submit();
			}
			function goNow3(num){
				document.show.recordNum.value=num;
				document.show.operation.value="delete";
				document.show.submit();
			}
			function goBack(num){
				document.editThis.operation.value="show";
				document.editThis.submit();
			}
			function goBack1(num){
				document.editDone.operation.value="show";
				document.editDone.submit();
			}
			function goBack2(){
				document.addThis.operation.value="show";
				document.addThis.submit();
			}
			function doThis(){
				var url="gcp_fabric_maint.jsp?manufacturerSelect="+document.show.manufacturerSelect.value;
				document.location.href=url;
			}
			function selectMan(){
				document.addThis.manufacturer.value=document.addThis.selectManu.value;
			}
			function selectMan2(){
				document.addThis.selectManu.value="";
			}
			function selectPatternx(){
				//alert("HERE");
				document.addThis.pattern_name.value=document.addThis.selectPattern.value;
			}
			function selectPatternx2(){
				document.addThis.selectPattern.value="";
			}
		</script>
		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>
	<body>
		<%@ page language="java" import="java.sql.*" import="java.util.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con.jsp"%>
		<%
		String sbu=request.getParameter("sbu");
		String operation=request.getParameter("operation");
		String manufacturerSelect=request.getParameter("manufacturerSelect");
		String userId=request.getParameter("userId");
		//out.println("::"+manufacturerSelect+"::<BR>");
		myConn.setAutoCommit(false);
		if(operation == null || operation.trim().length()<1 || operation.equals("show")){
			out.println("<form name='show' action='gcp_fabric_maint.jsp'>");

			//Vector comp_code = new Vector();
			Vector manufacturer = new Vector();
			Vector pattern_name = new Vector();
			Vector pattern_color = new Vector();
			Vector roll_width = new Vector();
			Vector fabric_repeats = new Vector();
			Vector nafta = new Vector();
			Vector yard_cost = new Vector();
			Vector seam_type=new Vector();
			Vector part_no=new Vector();
			String query1="select * from cs_gcp_fabrics where (dormant is null or not dormant='y')  order by manufacturer,pattern_name,pattern_color";
			if(manufacturerSelect != null && manufacturerSelect.trim().length()>0 && !manufacturerSelect.equals("null")){
				query1="select * from cs_gcp_fabrics where pattern_name='"+manufacturerSelect+"' and (dormant is null or not dormant='y') order by manufacturer,pattern_name,pattern_color";
			}
			ResultSet rs1=stmt.executeQuery(query1);
			if(rs1 != null){
				while(rs1.next()){
					manufacturer.addElement(rs1.getString("manufacturer"));
					pattern_name.addElement(rs1.getString("pattern_name"));
					pattern_color.addElement(rs1.getString("pattern_color"));
					if(rs1.getString("roll_width") != null){
						roll_width.addElement(rs1.getString("roll_width"));
					}
					else{
						roll_width.addElement("");
					}
					if(rs1.getString("fabric_repeats") != null){
						fabric_repeats.addElement(rs1.getString("fabric_repeats"));
					}
					else{
						fabric_repeats.addElement("");
					}
					if(rs1.getString("nafta") != null){
						nafta.addElement(rs1.getString("nafta"));
					}
					else{
						nafta.addElement("");
					}
					if(rs1.getString("yard_cost") != null){
						yard_cost.addElement(rs1.getString("yard_cost"));
					}
					else{
						yard_cost.addElement("");
					}
					if(rs1.getString("seam_type") != null){
						seam_type.addElement(rs1.getString("seam_type"));
					}
					else{
						seam_type.addElement("");
					}
					if(rs1.getString("part_number") != null){
						part_no.addElement(rs1.getString("part_number"));
					}
					else{
						part_no.addElement("");
					}
				}
			}
			rs1.close();
			//out.println("<form name='show' action='gcp_fabric_maint.jsp'>");
			out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
			out.println("<input type='hidden' name='operation' value=''>");
			out.println("<input type='hidden' name='recordNum' value=''>");
			out.println("<input type='hidden' name='userId' value='"+userId+"'>");
			out.println("<table border='1' width='100%'><tr>");
			out.println("<td colspan='3' align='center'>Select pattern:");
			out.println("<select name='manufacturerSelect'>");
			out.println("<option value=''></option>");
			ResultSet rs0=stmt.executeQuery("select distinct pattern_name from cs_gcp_fabrics where (dormant is null or not dormant='y') order by pattern_name");
			if(rs0 != null){
				while(rs0.next()){
					String select="";
					if(manufacturerSelect != null && manufacturerSelect.replaceAll(" ","").equals(rs0.getString(1).replaceAll(" ",""))){
						select="selected";
					}
					//out.println(manufacturerSelect+"::<BR>");
					out.println("<option value='"+rs0.getString(1)+"' "+select+">"+rs0.getString(1)+"</option>");
				}
			}
			rs0.close();
			out.println("</select>&nbsp;&nbsp;&nbsp;<input type='button' name='go' value='Filter pattern' onclick='doThis()'></td>");
			out.println("<td colspan='7' align='center'><input type='button' name='add' value='Add New Entry' onclick='addNew()'></td></tr>");
			out.println("<tr>");
			out.println("<td width='10%'>Manufacturer</td>");
			out.println("<td width='10%'>Pattern Name</td>");
			out.println("<td width='15%'>Pattern Color</td>");
			out.println("<td width='10%'>Roll Width</td>");
			out.println("<td width='10%'>Fabric Repeats</td>");
			out.println("<td width='5%'>Nafta</td>");
			out.println("<td width='10%'>Yard Cost</td>");
			out.println("<td width='5%'>Seam Type</td>");
			out.println("<td width='10%'>Part No.</td>");
			out.println("<td width='15%'>Edit</td>");
			out.println("</tr>");

			for(int a=0; a<manufacturer.size(); a++){
				out.println("<tr>");
				out.println("<td>"+manufacturer.elementAt(a).toString()+"&nbsp;</td>");
				out.println("<td>"+pattern_name.elementAt(a).toString()+"&nbsp;</td>");
				out.println("<td>"+pattern_color.elementAt(a).toString()+"&nbsp;</td>");
				out.println("<td>"+roll_width.elementAt(a).toString()+"&nbsp;</td>");
				out.println("<td>"+fabric_repeats.elementAt(a).toString()+"&nbsp;</td>");
				out.println("<td>"+nafta.elementAt(a).toString()+"&nbsp;</td>");
				out.println("<td>"+yard_cost.elementAt(a).toString()+"&nbsp;</td>");
				out.println("<td>"+seam_type.elementAt(a).toString()+"&nbsp;</td>");
				out.println("<td>"+part_no.elementAt(a).toString()+"&nbsp;</td>");
				out.println("<td><input type='button' name='Edit' value='Edit' onclick='goNow("+a+")'>");
				out.println("<input type='button' name='Delete' value='Delete' onclick=goNow3('"+a+"')></td>");
			}

			out.println("</table>");
			out.println("</form>");
		}
		else if(operation.equals("edit")){
			String recordNum=request.getParameter("recordNum");
			String manufacturer="";
			String pattern_name="";
			String pattern_color="";
			String roll_width="";
			String fabric_repeats="";
			String nafta="";
			String yard_cost="";
			String seam_type="";
			String part_no="";
			String dormant="";
			int recNo=Integer.parseInt(recordNum);
			if(pattern_color == null || pattern_color.equals("null")){
				pattern_color="";
			}
			int a=0;
			String query2="select * from cs_gcp_fabrics where (dormant is null or not dormant='y') order by manufacturer,pattern_name,pattern_color";
			if(manufacturerSelect != null && manufacturerSelect.trim().length()>0 && !manufacturerSelect.equals("null")){
					query2="select * from cs_gcp_fabrics where pattern_name='"+manufacturerSelect+"' and (dormant is null or not dormant='y')  order by manufacturer,pattern_name,pattern_color";
			}
			ResultSet rs1=stmt.executeQuery(query2);
			if(rs1 != null){

				while(rs1.next()){

					if(a==recNo){
						manufacturer=rs1.getString("manufacturer");
						pattern_name=rs1.getString("pattern_name");
						if(rs1.getString("pattern_color") !=null){
							pattern_color=rs1.getString("pattern_color");
						}
						if(rs1.getString("roll_width") !=null){
							roll_width=rs1.getString("roll_width");
						}
						if(rs1.getString("fabric_repeats") !=null){
							fabric_repeats=rs1.getString("fabric_repeats");
						}
						if(rs1.getString("nafta") !=null){
							nafta=rs1.getString("nafta");
						}
						if(rs1.getString("yard_cost") !=null){
							yard_cost=rs1.getString("yard_cost");
						}
						if(rs1.getString("seam_type") !=null){
							seam_type=rs1.getString("seam_type");
						}
						if(rs1.getString("part_number") !=null){
							part_no=rs1.getString("part_number");
						}
						if(rs1.getString("dormant") !=null){
							dormant=rs1.getString("dormant");
						}
					}
					a++;
				}
			}
			rs1.close();
			out.println(seam_type);
			out.println("<form name='editThis' action='gcp_fabric_maint.jsp' method='post'>");
			out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
			out.println("<input type='hidden' name='operation' value=''>");
			out.println("<input type='hidden' name='recordNum' value=''>");
			out.println("<input type='hidden' name='userId' value='"+userId+"'>");
			out.println("<input type='hidden' name='manufacturerSelect' value='"+manufacturerSelect+"'>");
			out.println("<table border='1' width='100%'>");
			out.println("<tr><td >Manufacturer</td><td >Pattern Name</td><td >Pattern Color</td><td >Roll Width</td><td >Fabric Repeats</td><td >Nafta</td><td >Yard Cost</td><td >Seam Type</td><td >Part No.</td><td>Dormant</td><td>Save</td></tr>");
			out.println("<tr>");
			out.println("<td><input type='text' name='manufacturer' value='"+manufacturer+"' readonly></td>");
			out.println("<td><input type='text' name='pattern_name' value='"+pattern_name+"' readonly></td>");
			out.println("<td><input type='text' name='pattern_color' value='"+pattern_color+"' readonly></td>");
			out.println("<td><input type='text' name='roll_width' value='"+roll_width+"'></td>");
			out.println("<td><input type='text' name='fabric_repeats' value='"+fabric_repeats+"'></td>");
			out.println("<td><input type='text' name='nafta' value='"+nafta+"'></td>");
			out.println("<td><input type='text' name='yard_cost' value='"+yard_cost+"'></td>");
			out.println("<td>");
			//out.println("<input type='text' name='seam_type' value='"+seam_type+"'>");
			out.println("<select name='seam_type'>");
			out.println("<option value=''></option>");
			String selected="";
			if(seam_type.equals("B")){
				selected="selected";
			}
			out.println("<option value='B' "+selected+">B</option>");
			selected="";
			if(seam_type.equals("R")){
				selected="selected";
			}
			out.println("<option value='R' "+selected+">R</option>");
			selected="";
			if(seam_type.equals("S")){
				selected="selected";
			}
			out.println("<option value='S' "+selected+">S</option>");
			selected="";
			out.println("</select></td>");
			out.println("<td><input type='text' name='part_no' value='"+part_no+"'></td>");
			out.println("<td><input type='checkbox' name='dormant' ></td>");
			out.println("<td><input type='button' name='Save' value='Save' onclick='goNow1("+a+")'>");
			out.println("<input type='button' name='Cancel' value='Cancel' onclick='goBack()'></td>");
			out.println("</table>");
			out.println("</form>");

		}
		else if(operation.equals("add")){
			out.println("<form name='addThis' action='gcp_fabric_maint.jsp'>");
			out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
			out.println("<input type='hidden' name='operation' value=''>");
			out.println("<input type='hidden' name='manufacturerSelect' value='"+manufacturerSelect+"'>");
			out.println("<input type='hidden' name='userId' value='"+userId+"'>");
			out.println("<table border='1' width='100%'>");
			out.println("<tr><td >Manufacturer</td><td >Pattern Name</td><td >Pattern Color</td><td >Roll Width</td><td >Fabric Repeats</td><td >Nafta</td><td >Yard Cost</td><td >Seam Type</td><td >Part No.</td><td>Save</td></tr>");
			out.println("<tr>");
			out.println("<td><select name='selectManu' onchange='selectMan()'>");
			out.println("<option value=''></option>");
			ResultSet rs0=stmt.executeQuery("select distinct manufacturer from cs_gcp_fabrics where (dormant is null or not dormant='y')  order by manufacturer");
			if(rs0 != null){
				while(rs0.next()){
					out.println("<option value='"+rs0.getString(1)+"' >"+rs0.getString(1)+"</option>");
				}
			}
			rs0.close();
			out.println("</select><input type='text' name='manufacturer' value='' onkeydown='selectMan2()'></td>");
			out.println("<td><select name='selectPattern' onchange='selectPatternx()'>");
			out.println("<option value=''></option>");
			ResultSet rs1=stmt.executeQuery("select distinct pattern_name from cs_gcp_fabrics where (dormant is null or not dormant='y') order by pattern_name");
			if(rs1 != null){
				while(rs1.next()){
					out.println("<option value='"+rs1.getString(1)+"' >"+rs1.getString(1)+"</option>");
				}
			}
			rs1.close();
			out.println("</select><input type='text' name='pattern_name' value='' onkeydown='selectPatternx2()'></td>");
			out.println("<td><input type='text' name='pattern_color' value=''></td>");
			out.println("<td><input type='text' name='roll_width' value=''></td>");
			out.println("<td><input type='text' name='fabric_repeats' value=''></td>");
			out.println("<td><input type='text' name='nafta' value=''></td>");
			out.println("<td><input type='text' name='yard_cost' value=''></td>");
			out.println("<td>");
			//out.println("<input type='text' name='seam_type' value='"+seam_type+"'>");
			out.println("<select name='seam_type'>");
			out.println("<option value=''></option>");
			out.println("<option value='B' >B</option>");
			out.println("<option value='R' >R</option>");
			out.println("<option value='S' >S</option>");
			out.println("</select></td>");
			out.println("<td><input type='text' name='part_no' value=''></td>");
			out.println("<td><input type='button' name='Save' value='Save' onclick='goNow2()'>");
			out.println("<input type='button' name='Cancel' value='Cancel' onclick='goBack2()'></td>");
			out.println("</table>");
			out.println("</form>");
		}
		else if(operation.equals("editSave")){
			String manufacturer=request.getParameter("manufacturer");
			String pattern_name=request.getParameter("pattern_name");
			String pattern_color=request.getParameter("pattern_color");
			if(pattern_color == null || pattern_color.equals("null")){
				pattern_color="";
			}
			String roll_width=request.getParameter("roll_width");
			String fabric_repeats=request.getParameter("fabric_repeats");
			String nafta=request.getParameter("nafta");
			String yard_cost=request.getParameter("yard_cost");
			String seam_type=request.getParameter("seam_type");
			String part_no=request.getParameter("part_no");
			String dormant=request.getParameter("dormant");
			out.println("dormant::"+dormant);
			if(dormant != null && dormant.equals("on")){
				dormant="Y";
			}
			else{
				dormant="";
			}
			try{
				java.sql.PreparedStatement update_qlfNotes = myConn.prepareStatement("UPDATE cs_gcp_fabrics set roll_width=?,fabric_repeats=?,nafta= ?,yard_cost=?,seam_type=?,part_number=?,user_id=?,dormant=? where manufacturer= ? and pattern_name=? and pattern_color=? " );
				update_qlfNotes.setString(1,roll_width);
				update_qlfNotes.setString(2,fabric_repeats);
				update_qlfNotes.setString(3,nafta);
				update_qlfNotes.setString(4,yard_cost);
				update_qlfNotes.setString(5,seam_type);
				update_qlfNotes.setString(6,part_no);
				update_qlfNotes.setString(7,userId);
				update_qlfNotes.setString(8,dormant);
				update_qlfNotes.setString(9,manufacturer);
				update_qlfNotes.setString(10,pattern_name);
				update_qlfNotes.setString(11,pattern_color);

				int roCount=update_qlfNotes.executeUpdate();
//out.println(roCount+":: rowcount");
			}
			catch (java.sql.SQLException e)
			{
				out.println("Problem with updating cs_gcp_fabrics table"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
			out.println("<form name='editDone' action='gcp_fabric_maint.jsp'>");
			out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
			out.println("<input type='hidden' name='operation' value=''>");
			out.println("<input type='hidden' name='recordNum' value=''>");
			out.println("<input type='hidden' name='userId' value='"+userId+"'>");
			out.println("<input type='hidden' name='manufacturerSelect' value='"+manufacturerSelect+"'>");
			out.println("<table border='1' width='100%'>");
			out.println("<tr><td >Manufacturer</td><td >Pattern Name</td><td >Pattern Color</td><td >Roll Width</td><td >Fabric Repeats</td><td >Nafta</td><td >Yard Cost</td><td >Seam Type</td><td >Part No.</td><td>Continue</td></tr>");
			out.println("<tr>");
			out.println("<td>"+manufacturer+"</td>");
			out.println("<td>"+pattern_name+"</td>");
			out.println("<td>"+pattern_color+"</td>");
			out.println("<td>"+roll_width+"</td>");
			out.println("<td>"+fabric_repeats+"</td>");
			out.println("<td>"+nafta+"</td>");
			out.println("<td>"+yard_cost+"</td>");
			out.println("<td>"+seam_type+"</td>");
			out.println("<td>"+part_no+"</td>");
			out.println("<td><input type='button' name='continue' value='Continue' onclick='goBack1()'></td>");
			out.println("</table>");
			out.println("</form>");
		}
		else if(operation.equals("addSave")){
			boolean isGood=true;
			String message="";
			String manufacturer=request.getParameter("manufacturer");
			String pattern_name=request.getParameter("pattern_name");
			String pattern_color=request.getParameter("pattern_color");
			String roll_width=request.getParameter("roll_width");
			String fabric_repeats=request.getParameter("fabric_repeats");
			String nafta=request.getParameter("nafta");
			String yard_cost=request.getParameter("yard_cost");
			String seam_type=request.getParameter("seam_type");
			String part_no=request.getParameter("part_no");
			if(pattern_color == null || pattern_color.equals("null")){
				pattern_color="";
			}
			if(manufacturer == null || manufacturer.trim().length()<=0){
				isGood=false;
				message=message+"No manufacturer added!<BR>";
			}
			else if(pattern_name == null || pattern_name.trim().length()<=0){
				isGood=false;
				message=message+"No pattern added!<BR>";
			}
			if(!isGood){
				message=message+"Please Try Again!!!";
				out.println(message);
		%>
		<INPUT TYPE="button" VALUE="Go Back" onClick="history.go(-1);
				return true;">
		<%
	}
	else{
		int rowCount=0;
		ResultSet rs1=stmt.executeQuery("select count(*) from cs_gcp_fabrics where manufacturer='"+manufacturer+"' and pattern_name='"+pattern_name+"' and pattern_color='"+pattern_color+"'");
		if(rs1 != null){
			while(rs1.next()){
				rowCount=rs1.getInt(1);
			}
		}
		rs1.close();
		if(rowCount>0){
			message="Keys already exist in this table.  Please try to either change the code.  Or if you are trying to update a record.  Please go back and click the edit button instead.";
			out.println(message);
		%>
		<INPUT TYPE="button" VALUE="Go Back" onClick="history.go(-1);
				return true;">
		<%
	}
	else{
		try{
			String insert ="INSERT INTO cs_gcp_fabrics(manufacturer,pattern_name,pattern_color,roll_width,fabric_repeats,nafta,yard_cost,seam_type,part_number,user_id,dormant)VALUES(?,?,?,?,?,?,?,?,?,?,?) ";
			PreparedStatement update_gcp_fabric = myConn.prepareStatement(insert);
			update_gcp_fabric.setString(1,manufacturer);
			update_gcp_fabric.setString(2,pattern_name);
			update_gcp_fabric.setString(3,pattern_color);
			update_gcp_fabric.setString(4,roll_width);
			update_gcp_fabric.setString(5,fabric_repeats);
			update_gcp_fabric.setString(6,nafta);
			update_gcp_fabric.setString(7,yard_cost);
			update_gcp_fabric.setString(8,seam_type);
			update_gcp_fabric.setString(9,part_no);
			update_gcp_fabric.setString(10,userId);
			update_gcp_fabric.setString(11,"");
			int rocount = update_gcp_fabric.executeUpdate();
			update_gcp_fabric.close();
			out.println("<form name='editDone' action='gcp_fabric_maint.jsp'>");
			out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
			out.println("<input type='hidden' name='operation' value=''>");
			out.println("<input type='hidden' name='recordNum' value=''>");
			out.println("<input type='hidden' name='manufacturerSelect' value='"+manufacturerSelect+"'>");
			out.println("<input type='hidden' name='userId' value='"+userId+"'>");
			out.println("<table border='1' width='100%'>");
			out.println("<tr><td >Manufacturer</td><td >Pattern Name</td><td >Pattern Color</td><td >Roll Width</td><td >Fabric Repeats</td><td >Nafta</td><td >Yard Cost</td><td >Seam Type</td>td >Part No.</td><td>Continue</td></tr>");
			out.println("<tr>");
			out.println("<td>"+manufacturer+"</td>");
			out.println("<td>"+pattern_name+"</td>");
			out.println("<td>"+pattern_color+"</td>");
			out.println("<td>"+roll_width+"</td>");
			out.println("<td>"+fabric_repeats+"</td>");
			out.println("<td>"+nafta+"</td>");
			out.println("<td>"+yard_cost+"</td>");
			out.println("<td>"+seam_type+"</td>");
			out.println("<td>"+part_no+"</td>");
			out.println("<td><input type='button' name='continue' value='Continue' onclick='goBack1()'></td>");
			out.println("</table>");
			out.println("</form>");	;

		}
		catch (java.sql.SQLException e){
			out.println("Problem with ENTERING TO cs_gcp_fabrics TABLEs"+"<br>");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}
	}
}
}
else if(operation.equals("delete")){
String recordNum=request.getParameter("recordNum");
String manufacturer="";
String pattern_name="";
String pattern_color="";
String roll_width="";
String fabric_repeats="";
String nafta="";
String yard_cost="";
int recNo=Integer.parseInt(recordNum);
if(pattern_color == null || pattern_color.equals("null")){
	pattern_color="";
}
int a=0;
String query3="select * from cs_gcp_fabrics where (dormant is null or not dormant='y') order by manufacturer,pattern_name,pattern_color";
if(manufacturerSelect != null && manufacturerSelect.trim().length()>0 && !manufacturerSelect.equals("null")){
	query3="select * from cs_gcp_fabrics where manufacturer='"+manufacturerSelect+"' and (dormant is null or not dormant='y')  order by manufacturer,pattern_name,pattern_color";
}
out.println(query3+"::<BR>");
ResultSet rs1=stmt.executeQuery(query3);
if(rs1 != null){

	while(rs1.next()){
		if(a==recNo){
			manufacturer=rs1.getString("manufacturer");
			pattern_name=rs1.getString("pattern_name");
			if(rs1.getString("pattern_color") !=null){
				pattern_color=rs1.getString("pattern_color");
			}
		}
		a++;
	}
}
rs1.close();

try{
	//out.println("delete from cs_gcp_fabrics where manufacturer='"+manufacturer+"' and pattern_name='"+pattern_name+"' and pattern_color='"+pattern_color+"'<BR>");
	int rsDelete=stmt.executeUpdate("delete from cs_gcp_fabrics where manufacturer='"+manufacturer+"' and pattern_name='"+pattern_name+"' and pattern_color='"+pattern_color+"'");
	//out.println(rsDelete);
}
catch (java.sql.SQLException e){
	out.println("Problem with deleteing from table");
	out.println("Illegal Operation try again/Report Error"+"<br>");
	myConn.rollback();
	out.println(e.toString());
	return;
}
out.println("<form name='editDone' action='gcp_fabric_maint.jsp'>");
out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
out.println("<input type='hidden' name='operation' value=''>");
out.println("<input type='hidden' name='recordNum' value=''>");
out.println("<input type='hidden' name='userId' value='"+userId+"'>");
out.println("<input type='hidden' name='manufacturerSelect' value='"+manufacturerSelect+"'>");
out.println("<table border='1' width='100%'>");
//out.println("<tr><td >Manufacturer</td><td >Pattern Name</td><td >Pattern Color</td><td >Roll Width</td><td >Fabric Repeats</td><td >Nafta</td><td >Yard Cost</td><td>Continue</td></tr>");
out.println("<tr>");
out.println("<td><input type='button' name='continue' value='Continue' onclick='goBack1()'></td>");
out.println("</table>");
out.println("</form>");	;
}
stmt.close();
myConn.commit();
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