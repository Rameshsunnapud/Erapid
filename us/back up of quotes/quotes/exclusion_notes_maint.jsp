<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<script language="JavaScript" src="../../test/date-picker.js"		></script>
<%
//if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
//        erapidBean.setServerName("server1");
//}
try{

%>
<html>
	<head>
		<title>Exclusion Notes</title>
		<script language="JavaScript" src="date-picker.js"></script>
		<script language="JavaScript">
			function goNow(num){
				//alert(num);
				document.show.recordNum.value=num;
				document.show.operation.value="edit";
				document.show.submit();
			}
			function addNew(num){
				document.show.operation.value="add";
				document.show.submit();
			}
			function goNow1(num){
				//alert(num);
				document.editThis.recordNum.value=num;
				document.editThis.operation.value="editSave";
				document.editThis.submit();
			}
			function goNow2(num){
				document.addThis.operation.value="addSave";
				document.addThis.submit();
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
		</script>
		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>
	<body>
		<%@ page language="java" import="java.sql.*" import="java.util.*" errorPage="error.jsp" %>
		<%@ include file="../../db_con.jsp"%>
		<%
		String group_id=userSession.getGroup();
		String userName=request.getParameter("username");
//out.println(group_id+"::"+userSession.getUserId()+"::"+userName);
		if(group_id == null){
			group_id="";
		}
		if(userName==null){
			userName="";
		}
		if(userName.trim().length()>0){
//out.println(group_id+"::<BR>");
			userSession.setUserId(userName);
			group_id=userSession.getGroup();
//out.println(group_id+"::<BR>");
		}
		if(group_id.equals("Admins")||group_id.equals("admins")||group_id.equals("develop") || group_id.equals("Develop")||group_id.equals("super")){
		out.println("<form name='showx' action='exclusion_notes_maint.jsp'>");
			out.println("PRODUCT ID:<select name='sbu' onchange='document.showx.submit();'>");
			out.println("<option value=''></option>");
			ResultSet rsPRODUCT=stmt.executeQuery("select product_id from products where product_status='d'");
			if(rsPRODUCT != null){
				while(rsPRODUCT.next()){
					out.println("<option value='"+rsPRODUCT.getString(1)+"'>"+rsPRODUCT.getString(1)+"</option>");
				}
			}
			rsPRODUCT.close();
			out.println("</select></form>");
		}
                                else if(userName.toLowerCase().equals("esom")){
			out.println("<form name='showx' action='exclusion_notes_maint.jsp'>");
			out.println("PRODUCT ID:<select name='sbu' onchange='document.showx.submit();'>");
			out.println("<option value=''></option>");

					out.println("<option value='LVR'>LVR</option>");
                                        out.println("<option value='GRILLE'>GRILLE</option>");
                                        out.println("<option value='FSM'>FSM</option>");

			out.println("</select></form>");
		}
		String sbu=request.getParameter("sbu");
		//out.println(sbu);

		if(sbu==null){
			sbu="";
		}
		if(sbu.length()==0){
			//out.println(group_id);

			if(group_id.equals("ADS")){
				sbu="ADS";
			}
			else if(group_id.equals("APC")){
				sbu="APC";
			}
			else if(group_id.equals("EFS-ADMIN")){
				sbu="EFS";
			}
			else if(group_id.equals("EJC-ADMIN")){
				sbu="EJC";
			}
			else if(group_id.equals("Explovent")){
				sbu="Explovent";
			}
			else if(group_id.equals("GCubicle")||group_id.equals("GCubicleD")){
				sbu="GCP";
			}
			else if(group_id.equals("GrandE")){
				sbu="GE";
			}
			else if(group_id.equals("IWP-ADMIN")){
				sbu="IWP";
			}
			else if(group_id.equals("LVR-ADMIN")){
				sbu="LVR";
			}
			else if(userName.toLowerCase().equals("esom")){
				sbu="LVR";
			}
else if(userName.toLowerCase().equals("rdasilva")||userName.toLowerCase().equals("mvalero")){
				sbu="GRILLE";
			}
			else if(userName.toLowerCase().equals("acoruso")){
				sbu="FSM";
			}
		}








		String operation=request.getParameter("operation");
		myConn.setAutoCommit(false);

		if(operation == null || operation.trim().length()<1 || operation.equals("show")){
			//Vector comp_code = new Vector();
			Vector code = new Vector();
			Vector description = new Vector();
			Vector set_default=new Vector();
			Vector type=new Vector();
			Vector effectiveDate=new Vector();
			ResultSet rs1=stmt.executeQuery("select * from cs_exc_notes where product_id = '"+sbu+"' order by code,  description");
			if(rs1 != null){
				while(rs1.next()){
					//comp_code.addElement(rs1.getString("comp_code"));
					code.addElement(rs1.getString("code"));

					description.addElement(rs1.getString("description"));
					if(rs1.getString("set_default") != null){
						set_default.addElement(rs1.getString("set_default"));
					}
					else{
						set_default.addElement("");
					}
					if(rs1.getString("effective_date") != null){
						effectiveDate.addElement(rs1.getString("effective_date"));
					}
					else{
						effectiveDate.addElement("");
					}
					if(rs1.getString("type") != null){
						type.addElement(rs1.getString("type"));
					}
					else{
						type.addElement("");
					}
				}
			}
			rs1.close();

			out.println("<form name='show' action='exclusion_notes_maint.jsp'>");
			out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
			out.println("<input type='hidden' name='operation' value=''>");
			out.println("<input type='hidden' name='recordNum' value=''>");
			out.println("<b><font color='red'>WARNING! Any modifications will affect ALL existing quotes that reference the same note.</font></b><BR><BR>");
			out.println("<table border='1' width='100%'>");
			if(sbu.equals("ADS")){
				out.println("<tr><td width='5%'>Code</td><td width='75%'>Description</td><td width='5%'>Effective Date</td><td width='5%'>Default</td><td width='5%'>Type</td><td width='5%'>Edit</td></tr>");
			}
			else{
				out.println("<tr><td width='5%'>Code</td><td width='80%'>Description</td><td width='5%'>Effective Date</td><td width='5%'>Default</td><td width='5%'>Edit</td></tr>");
			}
			for(int a=0; a<code.size(); a++){
				out.println("<tr>");
				//out.println("<td>"+comp_code.elementAt(a).toString()+"</td>");
				out.println("<td>"+code.elementAt(a).toString()+"</td>");
				out.println("<td>"+description.elementAt(a).toString()+"</td>");
				out.println("<td>&nbsp;"+effectiveDate.elementAt(a).toString()+"</td>");
				out.println("<td>&nbsp;"+set_default.elementAt(a).toString()+"</td>");
				if(sbu.equals("ADS")){
					out.println("<td>&nbsp;"+type.elementAt(a).toString()+"</td>");
				}
				out.println("<td><input type='button' name='Edit' value='Edit' onclick='goNow("+a+")'></td>");
			}
			out.println("<tr><td colspan='4' align='center'><input type='button' name='add' value='ADD NEW NOTE' onclick='addNew()'></td></tr>");
			out.println("</table>");
			out.println("</form>");
		}
		else if(operation.equals("edit")){

			String recordNum=request.getParameter("recordNum");
			//String comp_code="";
			String code="";
			String description="";
			String set_default="";
			String type="";
			String effective_date="";
			int recNo=Integer.parseInt(recordNum);

			int a=0;

			ResultSet rs1=stmt.executeQuery("select * from cs_exc_notes where product_id = '"+sbu+"' order by code,  description");
			if(rs1 != null){

				while(rs1.next()){

					if(a==recNo){
						//comp_code=rs1.getString("comp_code");
						code=rs1.getString("code");
						description=rs1.getString("description");
						if(rs1.getString("set_default") !=null){
							set_default=rs1.getString("set_default");
						}
if(rs1.getString("effective_date") !=null){
							effective_date=rs1.getString("effective_date");
						}
						if(rs1.getString("type") !=null){
							type=rs1.getString("type");
						}
					}
					a++;

				}

			}
			rs1.close();

			out.println("<form name='editThis' action='exclusion_notes_maint.jsp'>");
			out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
			out.println("<input type='hidden' name='operation' value=''>");
			out.println("<input type='hidden' name='recordNum' value=''>");
			if(!sbu.equals("ADS")){
				out.println("<input type='hidden' name='type' value=''>");
			}
			out.println("<table border='1' width='100%'>");
			if(sbu.equals("ADS")){
				out.println("<tr><td width='5%'>Code</td><td width='75%'>Description</td><td width='5%'>Effective Date</td><td width='5%'>Default</td><td width='5%'>Type</td><td width='5%'>Edit</td></tr>");
			}
			else{
				out.println("<tr><td width='5%'>Code</td><td width='80%'>Description</td><td width='5%'>Effective Date</td><td width='5%'>Default</td><td width='5%'>Edit</td></tr>");
			}
			out.println("<tr>");
			//out.println("<td><input type='text' name='compCode' value='"+comp_code+"' readonly></td>");
			out.println("<td><input type='text' name='code' value='"+code+"' readonly></td>");
			out.println("<td><textarea name='description' rows='3' cols='100'>"+description+"</textarea></td>");

out.println("<td><input type='text' name='effectiveDate' value='"+effective_date+"'><a href=javascript:show_calendar('editThis.effectiveDate'); 	onmouseover='return true;'	onmouseout='return true;' ><img src='../../images/cal.gif' width=19 height=18 border=0></a></td>");
			String checked="";
			//out.print(set_default+"::");
			if(set_default.toLowerCase().trim().equals("y")){
				checked="checked='yes'";
			}

			out.println("<td><input type='checkbox' name='set_default' "+checked+"></td>");
			if(sbu.equals("ADS")){
				String selectDoor="";
				String selectFrame="";
				if(type.equals("DOOR")){
					selectDoor="selected";
				}
				if(type.equals("FRAME")){
					selectFrame="selected";
				}
				out.println("<td><select name='type'>");
				out.println("<option value='DOOR' "+selectDoor+">DOOR</option>");
				out.println("<option value='FRAME' "+selectFrame+">FRAME</option>");
				out.println("</select></td>");
			}

			out.println("<td><input type='button' name='Save' value='Save' onclick='goNow1("+a+")'>");
			out.println("<input type='button' name='Cancel' value='Cancel' onclick='goBack()'></td>");
			out.println("</table>");
			out.println("</form>");

		}
		else if(operation.equals("add")){
			out.println("<form name='addThis' action='exclusion_notes_maint.jsp'>");
			out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
			out.println("<input type='hidden' name='operation' value=''>");
			if(!sbu.equals("ADS")){
				out.println("<input type='hidden' name='type' value=''>");
			}
			out.println("<table border='1' width='100%'>");
			out.println("<tr><td width='5%'>Code</td><td width='80%'>Description</td><td width='5%'>Effective Date</td><td width='5%'>Default</td><td width='5%'>Save</td></tr>");
			out.println("<tr>");
			//out.println("<td><input type='text' name='compCode' value='' ></td>");
			out.println("<td><input type='text' name='code' value=''></td>");
			out.println("<td><textarea name='description' rows='3' cols='75'></textarea></td>");
out.println("<td><input type='text' name='effectiveDate' value=''><a href=javascript:show_calendar('addThis.effectiveDate'); 	onmouseover='return true;'	onmouseout='return true;' ><img src='../../images/cal.gif' width=19 height=18 border=0></a></td>");

			out.println("<td><input type='checkbox' name='set_default' ></td>");
			if(sbu.equals("ADS")){
				out.println("<td><select name='type'>");
				out.println("<option value='' ></option>");
				out.println("<option value='DOOR'>Door</option>");
				out.println("<option value='FRAME'>FRAME</option>");
				out.println("</select></td>");
			}
			out.println("<td><input type='button' name='Save' value='Save' onclick='goNow2()'>");
			out.println("<input type='button' name='Cancel' value='Cancel' onclick='goBack2()'></td>");
			out.println("</table>");
			out.println("</form>");
		}
		else if(operation.equals("editSave")){

			//String compCode=request.getParameter("compCode");
			String code=request.getParameter("code");
			String description=request.getParameter("description");
			//out.println(sbu+"::"+compCode+"::"+code+"::"+description);
			String set_default=request.getParameter("set_default");
String effectiveDate=request.getParameter("effectiveDate");
			String type=request.getParameter("type");
			//out.println(set_default);
			if(set_default !=null && set_default.equals("on")){
				set_default="Y";
			}
			else{
				set_default="";
			}
			try{
				java.sql.PreparedStatement update_qlfNotes = myConn.prepareStatement("UPDATE cs_exc_notes set description= ?,set_default=?,type=?,effective_date=? where product_id= ? and code=? ");
				update_qlfNotes.setString(1,description);
				update_qlfNotes.setString(2,set_default);
				update_qlfNotes.setString(3,type);
update_qlfNotes.setString(4,effectiveDate);
				update_qlfNotes.setString(5,sbu);
				update_qlfNotes.setString(6,code);

				int roCount=update_qlfNotes.executeUpdate();
			}
			catch (java.sql.SQLException e)
			{
				out.println("Problem with updating cs_exc_notes table"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
			out.println("<form name='editDone' action='exclusion_notes_maint.jsp'>");
			out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
			out.println("<input type='hidden' name='operation' value=''>");
			out.println("<input type='hidden' name='recordNum' value=''>");
			out.println("<table border='1' width='100%'>");
			if(sbu.equals("ADS")){
				out.println("<tr><td width='5%'>Code</td><td width='75%'>Description</td><td width='5%'>Effective Date</td><td width='5%'>Default</td><td width='5%'>Type</td><td width='5%'>Continue</td></tr>");
			}
			else{
				out.println("<tr><td width='5%'>Code</td><td width='80%'>Description</td><td width='5%'>Effective Date</td><td width='5%'>Default</td><td width='5%'>Continue</td></tr>");
			}
			out.println("<tr>");
			//out.println("<td>"+compCode+"</td>");
			out.println("<td>"+code+"</td>");
			out.println("<td>"+description+"</td>");
out.println("<td>&nbsp;"+effectiveDate+"</td>");
			out.println("<td>&nbsp;"+set_default+"</td>");

			if(sbu.equals("ADS")){
				out.println("<td>&nbsp;"+type+"</td>");
			}
			out.println("<td><input type='button' name='continue' value='Continue' onclick='goBack1()'></td>");
			out.println("</table>");
			out.println("</form>");
		}
		else if(operation.equals("addSave")){
			//String compCode = request.getParameter("compCode");
			String code = request.getParameter("code");
			String description = request.getParameter("description");
			boolean isGood=true;
			String message="";
			String set_default=request.getParameter("set_default");
			String effectiveDate=request.getParameter("effectiveDate");
			String type=request.getParameter("type");
			if(set_default !=null && set_default.equals("on")){
				set_default="Y";
			}
			else{
				set_default="";
			}
			//if(compCode == null || compCode.trim().length()<=0){
			//	isGood=false;
			//	message=message+"No Comp Code added!<BR>";
			//}
			if(sbu.equals("ADS")){
				if(type==null || type.trim().length()<=0){
					isGood=false;
					message=message+"Must select DOOR or FRAME!<BR>";
				}
			}
			if(code == null || code.trim().length()<=0){
				isGood=false;
				message=message+"No Code added!<BR>";
			}
			else{
				boolean isNumeric=true;
				for(int b=0; b<code.length(); b++){
					if(!Character.isDigit(code.charAt(b))){
						isNumeric=false;
					}
				}
				if(!isNumeric){
					isGood=false;
					message=message+"Code is Not Numeric!<BR>";
				}
			}
			if(description == null || description.trim().length()<=0){
				isGood=false;
				message=message+"No Description added!<BR>";
			}
			if(!isGood){
				message=message+"Please Try Again!!!";
				out.println(message);
				out.println("<form name='addThis' action='exclusion_notes_maint.jsp'>");
				out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
				out.println("<input type='hidden' name='operation' value=''>");
				out.println("<input type='hidden' name='recordNum' value=''>");
				out.println("<table border='1' width='100%'>");
				if(sbu.equals("ADS")){
					out.println("<tr><td width='5%'>Code</td><td width='75%'>Description</td><td width='5%'>Effective Date</td><td width='5%'>Default</td><td width='5%'>Type</td><td width='5%'>Save</td></tr>");
				}
				else{
					out.println("<tr><td width='5%'>Code</td><td width='80%'>Description</td><td width='5%'>Effective Date</td><td width='5%'>Default</td><td width='5%'>Save</td></tr>");
				}
				out.println("<tr>");

				out.println("<td><input type='text' name='code' value='"+code+"'></td>");
				out.println("<td><textarea name='description' rows='3' cols='100'>"+description+"</textarea></td>");
				String checked="";
				//out.print(set_default+"::");
				if(set_default.toLowerCase().trim().equals("y")){
					checked="checked='yes'";
				}
out.println("<td><input type='text' name='effectiveDate' value='"+effectiveDate+"'><a href=javascript:show_calendar('addThis.effectiveDate'); 	onmouseover='return true;'	onmouseout='return true;' ><img src='../../images/cal.gif' width=19 height=18 border=0></a></td>");

				//out.println("<td><input type='text' name='effectiveDate' value='"+effectiveDate+"'></td>");
				out.println("<td><input type='checkbox' name='set_default' "+checked+".</td>");
				if(sbu.equals("ADS")){
					String selectDoor="";
					String selectFrame="";
					if(type.equals("DOOR")){
						selectDoor="selected";
					}
					if(type.equals("FRAME")){
						selectFrame="selected";
					}
					out.println("<td><select name='type'>");
					out.println("<option value='' ></option>");
					out.println("<option value='DOOR' "+selectDoor+">DOOR</option>");
					out.println("<option value='FRAME' "+selectFrame+">FRAME</option>");
					out.println("</select></td>");
				}
				out.println("<td><input type='button' name='Save' value='Save' onclick='goNow2()'>");
				out.println("<input type='button' name='Cancel' value='Cancel' onclick='goBack2()'></td>");
				out.println("</table>");
				out.println("</form>");
			}
			else{
				int rowCount=0;
				ResultSet rs1=stmt.executeQuery("select count(*) from cs_exc_notes where product_id='"+sbu+"' and code='"+code+"'");
				if(rs1 != null){
					while(rs1.next()){
						rowCount=rs1.getInt(1);
					}
				}
				rs1.close();
				if(rowCount>0){
					message="Keys already exist in this table.  Please try to either change the code.  Or if you are trying to update a record.  Please go back and click the edit button instead.";
					out.println(message);
					out.println("<form name='addThis' action='exclusion_notes_maint.jsp'>");
					out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
					out.println("<input type='hidden' name='operation' value=''>");
					out.println("<input type='hidden' name='recordNum' value=''>");
					out.println("<table border='1' width='100%'>");
					if(sbu.equals("ADS")){
						out.println("<tr><td width='5%'>Code</td><td width='75%'>Description</td><td width='5%'>Effective Date</td><td width='5%'>Default</td><td width='5%'>Type</td><td width='5%'>Save</td></tr>");
					}
					else{
						out.println("<tr><td width='5%'>Code</td><td width='80%'>Description</td><td width='5%'>Effective Date</td><td width='5%'>Default</td><td width='5%'>Save</td></tr>");
					}
					out.println("<tr>");
					//out.println("<td><input type='text' name='compCode' value='"+compCode+"' ></td>");
					out.println("<td><input type='text' name='code' value='"+code+"'></td>");
					out.println("<td><textarea name='description' rows='3' cols='100'>"+description+"</textarea></td>");
					String checked="";
					//out.print(set_default+"::");
					if(set_default.toLowerCase().trim().equals("y")){
						checked="checked='yes'";
					}
					out.println("<td><input type='text' name='effectiveDate' value='"+effectiveDate+"'></td>");
					out.println("<td><input type='checkbox' name='set_default' "+checked+".</td>");
					if(sbu.equals("ADS")){
						String selectDoor="";
						String selectFrame="";
						if(type.equals("DOOR")){
							selectDoor="selected";
						}
						if(type.equals("FRAME")){
							selectFrame="selected";
						}
						out.println("<td><select name='type'>");
						out.println("<option value='DOOR' "+selectDoor+">DOOR</option>");
						out.println("<option value='FRAME' "+selectFrame+">FRAME</option>");
						out.println("</select></td>");
					}
					out.println("<td><input type='button' name='Save' value='Save' onclick='goNow2()'>");
					out.println("<input type='button' name='Cancel' value='Cancel' onclick='goBack2()'></td>");
					out.println("</table>");
					out.println("</form>");

				}
				else{
					try{
						String insert ="INSERT INTO cs_exc_notes(code,product_id,description,set_default,type,effective_date)VALUES(?,?,?,?,?,?) ";
						PreparedStatement update_qlf_notes = myConn.prepareStatement(insert);
						//update_qlf_notes.setString(1,compCode.toUpperCase());
						update_qlf_notes.setString(1,code);
						update_qlf_notes.setString(2,sbu.toUpperCase());
						update_qlf_notes.setString(3,description);
						update_qlf_notes.setString(4,set_default);
						update_qlf_notes.setString(5,type);
						update_qlf_notes.setString(6,effectiveDate);
						int rocount = update_qlf_notes.executeUpdate();
						update_qlf_notes.close();
						out.println("<form name='editDone' action='exclusion_notes_maint.jsp'>");
						out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
						out.println("<input type='hidden' name='operation' value=''>");
						out.println("<input type='hidden' name='recordNum' value=''>");
						out.println("<table border='1' width='100%'>");
						if(sbu.equals("ADS")){
							out.println("<tr><td width='5%'>Code</td><td width='80%'>Description</td><td width='5%'>Default</td><td width='5%'>Type</td><td width='5%'>Continue</td></tr>");
						}
						else{
							out.println("<tr><td width='5%'>Code</td><td width='85%'>Description</td><td width='5%'>Default</td><td width='5%'>Continue</td></tr>");
						}
						out.println("<tr>");
						//out.println("<td>"+compCode+"</td>");
						out.println("<td>"+code+"</td>");
						out.println("<td>"+description+"</td>");
						out.println("<td>"+effectiveDate+"</td>");
						out.println("<td>"+set_default+"</td>");
						if(sbu.equals("ADS")){
							out.println("<td>"+type+"</td>");
						}
						out.println("<td><input type='button' name='continue' value='Continue' onclick='goBack1()'></td>");
						out.println("</table>");
						out.println("</form>");

					}
					catch (java.sql.SQLException e)
					{
						out.println("Problem with ENTERING TO cs_exc_notes TABLEs"+"<br>");
						out.println("Illegal Operation try again/Report Error"+"<br>");
						myConn.rollback();
						out.println(e.toString());
						return;
					}
				}


			}
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