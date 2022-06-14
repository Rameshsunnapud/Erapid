<html>
	<head>
		<title>Qualifying Notes</title>
		<script language="JavaScript" src="date-picker.js"></script>
		<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
		<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
		<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
		<%
		//if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
		//        erapidBean.setServerName("server1");
		//}
		try{

		%>
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
		out.println(group_id+"::"+userSession.getUserId()+"::"+userName);
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
out.println("<form name='showx' action='pricing_options_maint.jsp'>");
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
			out.println("<form name='showx' action='pricing_options_maint.jsp'>");
			out.println("PRODUCT ID:<select name='sbu' onchange='document.showx.submit();'>");
			out.println("<option value=''></option>");

					out.println("<option value='LVR'>LVR</option>");
                                        out.println("<option value='GRILLE'>GRILLE</option>");
                                        out.println("<option value='FSM'>FSM</option>");

			out.println("</select></form>");
		}
		String sbu=request.getParameter("sbu");
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
			else if(group_id.toUpperCase().equals("GCUBICLE")){
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
			else if(userName.toLowerCase().equals("rdasilva")){
				sbu="GRILLE";
			}
else if(userName.toLowerCase().equals("mvalero")){
				sbu="GRILLE";
			}
		}
		String operation=request.getParameter("operation");
		myConn.setAutoCommit(false);

		if(operation == null || operation.trim().length()<1 || operation.equals("show")){
			Vector code = new Vector();
			Vector description = new Vector();

			Vector set_default=new Vector();

			ResultSet rs1=stmt.executeQuery("select * from cs_pricing_options where product_id = '"+sbu+"' order by code,  cast(description as varchar)" );
			if(rs1 != null){
				while(rs1.next()){
					code.addElement(rs1.getString("code"));
					if(rs1.getString("description") != null){
						description.addElement(rs1.getString("description"));
					}
					else{
						description.addElement("&nbsp;");
					}
					if(rs1.getString("set_default") != null){
						set_default.addElement(rs1.getString("set_default"));
					}
					else{
						set_default.addElement("");
					}
				}
			}
			rs1.close();

			out.println("<form name='show' action='pricing_options_maint.jsp'>");
			out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
			out.println("<input type='hidden' name='operation' value=''>");
			out.println("<input type='hidden' name='recordNum' value=''>");
			out.println("<b><font color='red'>WARNING! Any modifications will affect ALL existing quotes that reference the same note.</font></b><BR><BR>");
			out.println("<table border='1' width='100%'>");
			out.println("<tr><td width='5%'>Code</td><td width='75%'>Description</td>");
			out.println("<td width='5%'>Default</td>");
			out.println("<td width='5%'>Edit</td></tr>");
			for(int a=0; a<code.size(); a++){
				out.println("<tr>");
				out.println("<td>"+code.elementAt(a).toString()+"</td>");
				out.println("<td>"+description.elementAt(a).toString()+"</td>");
				out.println("<td>&nbsp;"+set_default.elementAt(a).toString()+"</td>");
				out.println("<td><input type='button' name='Edit' value='Edit' onclick='goNow("+a+")'></td>");
			}
			out.println("<tr><td colspan='6' align='center'><input type='button' name='add' value='ADD NEW NOTE' onclick='addNew()'></td></tr>");
			out.println("</table>");
			out.println("</form>");
		}
		else if(operation.equals("edit")){

			String recordNum=request.getParameter("recordNum");
			String code="";
			String description="";

			String set_default="";
			int recNo=Integer.parseInt(recordNum);

			int a=0;

			ResultSet rs1=stmt.executeQuery("select * from cs_pricing_options where product_id = '"+sbu+"' order by code,  cast(description as varchar)");
			if(rs1 != null){

				while(rs1.next()){

					if(a==recNo){
						code=rs1.getString("code");
						description=rs1.getString("description");
						if(rs1.getString("set_default") !=null){
							set_default=rs1.getString("set_default");
						}
					}
					a++;

				}

			}
			rs1.close();

			out.println("<form name='editThis' action='pricing_options_maint.jsp'>");
			out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
			out.println("<input type='hidden' name='operation' value=''>");
			out.println("<input type='hidden' name='recordNum' value=''>");
			out.println("<table border='1' width='100%'>");
			out.println("<tr><td width='5%'>Code</td><td width='70%'>Description</td>");
			out.println("<td width='5'>Default</td><td width='5%'>Save</td></tr>");
			out.println("<tr>");
			out.println("<td><input type='text' name='code' value='"+code+"' readonly></td>");
			out.println("<td><textarea name='description' rows='3' cols='40'>"+description+"</textarea></td>");



			String checked="";

			if(set_default.toLowerCase().trim().equals("y")){
				checked="checked='yes'";
			}
			out.println("<td><input type='checkbox' name='set_default' "+checked+"></td>");
			out.println("<td><input type='button' name='Save' value='Save' onclick='goNow1("+a+")'>");
			out.println("<input type='button' name='Cancel' value='Cancel' onclick='goBack()'></td>");
			out.println("</table>");
			out.println("</form>");

		}
		else if(operation.equals("add")){


			out.println("<form name='addThis' action='pricing_options_maint.jsp'>");
			out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
			out.println("<input type='hidden' name='operation' value=''>");
			out.println("<table border='1' width='100%'>");
			out.println("<tr><td width='5%'>Code</td><td width='85%'>Description</td>");
			out.println("<td width='5%'>Default</td><td width='5%'>Save</td></tr>");
			out.println("<tr>");

			out.println("<td><input type='text' name='code' value=''></td>");
			out.println("<td><textarea name='description' rows='3' cols='40'></textarea></td>");

			out.println("<td><input type='checkbox' name='set_default' ></td>");
			out.println("<td><input type='button' name='Save' value='Save' onclick='goNow2()'>");
			out.println("<input type='button' name='Cancel' value='Cancel' onclick='goBack2()'></td>");
			out.println("</table>");
			out.println("</form>");
		}
		else if(operation.equals("editSave")){

			String code=request.getParameter("code");
			String description=request.getParameter("description");

			String set_default=request.getParameter("set_default");
			//out.println(set_default);
			if(set_default !=null && set_default.equals("on")){
				set_default="Y";
			}
			else{
				set_default="";
			}
		try{
				java.sql.PreparedStatement update_qlfNotes = myConn.prepareStatement("UPDATE cs_pricing_options set description= ?,set_default=? where product_id= ? and code=? ");
				update_qlfNotes.setString(1,description);
				update_qlfNotes.setString(2,set_default);
			    update_qlfNotes.setString(3,sbu);
				update_qlfNotes.setString(4,code);
				int roCount=update_qlfNotes.executeUpdate();
			}
			catch (java.sql.SQLException e)
			{
				out.println("Problem with updating cs_pricing_options table"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
			out.println("<form name='editDone' action='pricing_options_maint.jsp'>");
			out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
			out.println("<input type='hidden' name='operation' value=''>");
			out.println("<input type='hidden' name='recordNum' value=''>");
			out.println("<table border='1' width='100%'>");
			out.println("<tr><td width='5%'>Comp Code</td><td width='5%'>Code</td><td width='70%'>Description</td>");

			out.println("<td widht='5%'>Default</td><td width='5%'>Continue</td></tr>");
			out.println("<tr>");
			out.println("<td>"+code+"</td>");
			out.println("<td>"+description+"</td>");

			out.println("<td>"+set_default+"</td><td><input type='button' name='continue' value='Continue' onclick='goBack1()'></td>");
			out.println("</table>");
			out.println("</form>");
		}
		else if(operation.equals("addSave")){
			String code = request.getParameter("code");
			String description = request.getParameter("description");

			String set_default=request.getParameter("set_default");
			if(set_default !=null && set_default.equals("on")){
				set_default="Y";
			}
			else{
				set_default="";
			}
			boolean isGood=true;
			String message="";

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
				out.println("<form name='addThis' action='pricing_options_maint.jsp'>");
				out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
				out.println("<input type='hidden' name='operation' value=''>");
				out.println("<input type='hidden' name='recordNum' value=''>");
				out.println("<table border='1' width='100%'>");
				out.println("<tr><td width='5%'>Comp Code</td><td width='5%'>Code</td><td width='70%'>Description</td>");

				out.println("<td width='5%'>Default</td><td width='5%'>Save</td></tr>");
				out.println("<tr>");

				out.println("<td><input type='text' name='code' value='"+code+"'></td>");
				out.println("<td><textarea name='description' rows='3' cols='100'>"+description+"</textarea></td>");

				out.println("<td><input type='checkbox' name='set_default' ></td>");
				out.println("<td><input type='button' name='Save' value='Save' onclick='goNow2()'>");
				out.println("<input type='button' name='Cancel' value='Cancel' onclick='goBack2()'></td>");
				out.println("</table>");
				out.println("</form>");
			}
			else{
				int rowCount=0;
				ResultSet rs1=stmt.executeQuery("select count(*) from cs_pricing_options where product_id='"+sbu+"' and code='"+code+"'");
				if(rs1 != null){
					while(rs1.next()){
						rowCount=rs1.getInt(1);
					}
				}
				rs1.close();
				if(rowCount>0){
					message="Keys already exist in this table.  Please try to either change the comp code, or code.  Or if you are trying to update a record.  Please go back and click the edit button instead.";
					out.println(message);
					out.println("<form name='addThis' action='pricing_options_maint.jsp'>");
					out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
					out.println("<input type='hidden' name='operation' value=''>");
					out.println("<input type='hidden' name='recordNum' value=''>");
					out.println("<table border='1' width='100%'>");
					out.println("<tr><td width='5%'>Code</td><td width='70%'>Description</td>");

					out.println("<td width='5'>Default</td><td width='5%'>Save</td></tr>");
					out.println("<tr>");
					out.println("<td><input type='text' name='code' value='"+code+"'></td>");
					out.println("<td><textarea name='description' rows='3' cols='100'>"+description+"</textarea></td>");

					out.println("<td><input type='checkbox' name='set_default' ></td>");
					out.println("<td><input type='button' name='Save' value='Save' onclick='goNow2()'>");
					out.println("<input type='button' name='Cancel' value='Cancel' onclick='goBack2()'></td>");
					out.println("</table>");
					out.println("</form>");

				}
				else{
					try{
						String insert ="INSERT INTO cs_pricing_options(code,product_id,description,set_default)VALUES(?,?,?,?) ";
						PreparedStatement update_qlf_notes = myConn.prepareStatement(insert);
						update_qlf_notes.setString(1,code);
						update_qlf_notes.setString(2,sbu.toUpperCase());
						update_qlf_notes.setString(3,description);
						update_qlf_notes.setString(4,set_default);
						int rocount = update_qlf_notes.executeUpdate();
						update_qlf_notes.close();
						out.println("<form name='editDone' action='pricing_options_maint.jsp'>");
						out.println("<input type='hidden' name='sbu' value='"+sbu+"'>");
						out.println("<input type='hidden' name='operation' value=''>");
						out.println("<input type='hidden' name='recordNum' value=''>");
						out.println("<table border='1' width='100%'>");
						out.println("<tr><td width='5%'>Comp Code</td><td width='5%'>Code</td><td width='70%'>Description</td>");

						out.println("<td width='5'>Default</td><td width='5%'>Continue</td></tr>");
						out.println("<tr>");

						out.println("<td>"+code+"</td>");
						out.println("<td>"+description+"</td>");

						out.println("<td>"+set_default+"</td><td><input type='button' name='continue' value='Continue' onclick='goBack1()'></td>");
						out.println("</table>");
						out.println("</form>");

					}
					catch (java.sql.SQLException e)
					{
						out.println("Problem with ENTERING TO cs_pricing_options TABLEs"+"<br>");
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