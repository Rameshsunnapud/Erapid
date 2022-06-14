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
function del(num){
	//alert(num);
	document.show.recordNum.value=num;
	document.show.operation.value="delete"; 
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
<%@ include file="db_con.jsp"%>
<%

HttpSession UserSessionX = request.getSession();
String operation=request.getParameter("operation");
myConn.setAutoCommit(false);

if(operation == null || operation.trim().length()<1 || operation.equals("show")){
	//Vector comp_code = new Vector();
	Vector model = new Vector();
	Vector bpcs = new Vector();
	Vector rail1 = new Vector();
	Vector rail2 = new Vector();
	Vector railin = new Vector();
	Vector brkt = new Vector();
	Vector cap1 = new Vector();
	Vector cap2 = new Vector();
	Vector capin = new Vector();


	ResultSet rs1=stmt.executeQuery("select * from cs_iwp_sample order by model,bpcs");
	if(rs1 != null){
		while(rs1.next()){
			if(rs1.getString("model") != null){
				model.addElement(rs1.getString("model"));
			}
			else{
				model.addElement("");
			}
			if(rs1.getString("bpcs") != null){
				bpcs.addElement(rs1.getString("bpcs"));
			}
			else{
				bpcs.addElement("");
			}
			if(rs1.getString("rail1") != null){
				rail1.addElement(rs1.getString("rail1"));
			}
			else{
				rail1.addElement("");
			}
			if(rs1.getString("rail2") != null){
				rail2.addElement(rs1.getString("rail2"));
			}
			else{
				rail2.addElement("");
			}
			if(rs1.getString("railin") != null){
				railin.addElement(rs1.getString("railin"));
			}
			else{
				railin.addElement("");
			}
			if(rs1.getString("brkt") != null){
				brkt.addElement(rs1.getString("brkt"));
			}
			else{
				brkt.addElement("");
			}
			if(rs1.getString("cap1") != null){
				cap1.addElement(rs1.getString("cap1"));
			}
			else{
				cap1.addElement("");
			}
			if(rs1.getString("cap2") != null){
				cap2.addElement(rs1.getString("cap2"));
			}
			else{
				cap2.addElement("");
			}
			if(rs1.getString("capin") != null){
				capin.addElement(rs1.getString("capin"));
			}
			else{
				capin.addElement("");
			}			
		}
	}
	rs1.close();

	out.println("<form name='show' action='iwp_sample_maint.jsp'>");
	out.println("<input type='hidden' name='operation' value=''>");
	out.println("<input type='hidden' name='recordNum' value=''>");

	out.println("<table border='1' width='100%'>");
	out.println("<tr><td>model</td><td>bpcs</td><td>rail1</td><td>rail2</td><td>railin</td><td>brkt</td><td>cap1</td><td>cap2</td><td>capin</td><td>edit</td></tr>");
	for(int a=0; a<model.size(); a++){
		out.println("<tr>");
		out.println("<td>"+model.elementAt(a).toString()+"&nbsp;</td>");
		out.println("<td>"+bpcs.elementAt(a).toString()+"&nbsp;</td>");
		out.println("<td>"+rail1.elementAt(a).toString()+"&nbsp;</td>");
		out.println("<td>"+rail2.elementAt(a).toString()+"&nbsp;</td>");
		out.println("<td>"+railin.elementAt(a).toString()+"&nbsp;</td>");
		out.println("<td>"+brkt.elementAt(a).toString()+"&nbsp;</td>");
		out.println("<td>"+cap1.elementAt(a).toString()+"&nbsp;</td>");
		out.println("<td>"+cap2.elementAt(a).toString()+"&nbsp;</td>");
		out.println("<td>"+capin.elementAt(a).toString()+"&nbsp;</td>");
		out.println("<td><input type='button' name='Edit' value='Edit' onclick='goNow("+a+")'><input type='button' name='Delete' value='Delete' onclick='del("+a+")'></td>");
	}
	out.println("<tr><td colspan='10' align='center'><input type='button' name='add' value='ADD NEW MODEL' onclick='addNew()'></td></tr>");
	out.println("</table>");
	out.println("</form>");
}
else if(operation.equals("edit")){
	String model = "";
	String bpcs = "";
	String rail1 = "";
	String rail2 = "";
	String railin = "";
	String brkt = "";
	String cap1 = "";
	String cap2 = "";
	String capin = "";
	String recordNum=request.getParameter("recordNum");
	int recNo=Integer.parseInt(recordNum);	
	int a=0;	
	ResultSet rs1=stmt.executeQuery("select * from cs_iwp_sample order by model,bpcs");
	if(rs1 != null){	
		while(rs1.next()){		
			if(a==recNo){
				model=rs1.getString("model");
				bpcs=rs1.getString("bpcs");
				rail1=rs1.getString("rail1");
				rail2=rs1.getString("rail2");
				railin=rs1.getString("railin");
				brkt=rs1.getString("brkt");
				cap1=rs1.getString("cap1");
				cap2=rs1.getString("cap2");
				capin=rs1.getString("capin");				
			}
			a++;			
		}
		
	}
	rs1.close();
	if(model==null||model.equals("null")){
		model="";
	}
	if(bpcs==null||bpcs.equals("null")){
		bpcs="";
	}
	if(rail1==null||rail1.equals("null")){
		rail1="";
	}
	if(rail2==null||rail2.equals("null")){
		rail2="";
	}
	if(railin==null||railin.equals("null")){
		railin="";
	}
	if(brkt==null||brkt.equals("null")){
		brkt="";
	}
	if(cap1==null||cap1.equals("null")){
		cap1="";
	}
	if(cap2==null||cap2.equals("null")){
		cap2="";
	}
	if(capin==null||capin.equals("null")){
		capin="";
	}
	out.println("<form name='editThis' action='iwp_sample_maint.jsp'>");
	out.println("<input type='hidden' name='operation' value=''>");
	out.println("<input type='hidden' name='recordNum' value=''>");
	out.println("<table border='1' width='100%'>");
	out.println("<tr><td>model</td><td>bpcs</td><td>rail1</td><td>rail2</td><td>railin</td><td>brkt</td><td>cap1</td><td>cap2</td><td>capin</td><td>edit</td></tr>");
	out.println("<tr>");
	out.println("<td><input type='text' name='model' value='"+model+"' readonly></td>");
	out.println("<td><input type='text' name='bpcs' value='"+bpcs+"'></td>");
	out.println("<td><input type='text' name='rail1' value='"+rail1+"'></td>");
	out.println("<td><input type='text' name='rail2' value='"+rail2+"'></td>");
	out.println("<td><input type='text' name='railin' value='"+railin+"'></td>");
	out.println("<td><input type='text' name='brkt' value='"+brkt+"'></td>");
	out.println("<td><input type='text' name='cap1' value='"+cap1+"'></td>");
	out.println("<td><input type='text' name='cap2' value='"+cap2+"'></td>");
	out.println("<td><input type='text' name='capin' value='"+capin+"'></td>");
	out.println("<td><input type='button' name='Save' value='Save' onclick='goNow1("+a+")'>");
	out.println("<input type='button' name='Cancel' value='Cancel' onclick='goBack()'></td>");
	out.println("</table>");
	out.println("</form>");	
	
}
else if(operation.equals("add")){
	out.println("<form name='addThis' action='iwp_sample_maint.jsp'>");
	out.println("<input type='hidden' name='operation' value=''>");
	out.println("<table border='1' width='100%'>");
	out.println("<tr><td>model</td><td>bpcs</td><td>rail1</td><td>rail2</td><td>railin</td><td>brkt</td><td>cap1</td><td>cap2</td><td>capin</td><td>edit</td></tr>");
	out.println("<tr>");
	out.println("<td><input type='text' name='model'></td>");
	out.println("<td><input type='text' name='bpcs'></td>");
	out.println("<td><input type='text' name='rail1'></td>");
	out.println("<td><input type='text' name='rail2'></td>");
	out.println("<td><input type='text' name='railin'></td>");
	out.println("<td><input type='text' name='brkt'></td>");
	out.println("<td><input type='text' name='cap1'></td>");
	out.println("<td><input type='text' name='cap2'></td>");
	out.println("<td><input type='text' name='capin'></td>");		
	out.println("<td><input type='button' name='Save' value='Save' onclick='goNow2()'>");
	out.println("<input type='button' name='Cancel' value='Cancel' onclick='goBack2()'></td>");
	out.println("</table>");
	out.println("</form>");	
}
else if(operation.equals("editSave")){
	String model=request.getParameter("model");
	String bpcs=request.getParameter("bpcs");
	String rail1=request.getParameter("rail1");
	String rail2=request.getParameter("rail2");
	String railin=request.getParameter("railin");
	String brkt=request.getParameter("brkt");
	String cap1=request.getParameter("cap1");
	String cap2=request.getParameter("cap2");
	String capin=request.getParameter("capin");
	try{
		java.sql.PreparedStatement update_iwpsample = myConn.prepareStatement("UPDATE cs_iwp_sample set bpcs=?,rail1=?,rail2=?,railin=?,brkt=?,cap1=?,cap2=?,capin=? where model= ?  ");
		update_iwpsample.setString(1,bpcs);
		update_iwpsample.setString(2,rail1);
		update_iwpsample.setString(3,rail2);
		update_iwpsample.setString(4,railin);
		update_iwpsample.setString(5,brkt);
		update_iwpsample.setString(6,cap1);
		update_iwpsample.setString(7,cap2);
		update_iwpsample.setString(8,capin);
		update_iwpsample.setString(9,model);

		int roCount=update_iwpsample.executeUpdate();
	}
	catch (java.sql.SQLException e)
	{
		out.println("Problem with updating cs_iwp_sample table"+"<br>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}
	out.println("<form name='editDone' action='iwp_sample_maint.jsp'>");
	out.println("<input type='hidden' name='operation' value=''>");
	out.println("<input type='hidden' name='recordNum' value=''>");
	out.println("<table border='1' width='100%'>");
	out.println("<tr><td>model</td><td>bpcs</td><td>rail1</td><td>rail2</td><td>railin</td><td>brkt</td><td>cap1</td><td>cap2</td><td>capin</td><td>edit</td></tr>");
	out.println("<tr>");
	out.println("<td>"+model+"&nbsp;</td>");
	out.println("<td>"+bpcs+"&nbsp;</td>");
	out.println("<td>"+rail1+"&nbsp;</td>");
	out.println("<td>"+rail2+"&nbsp;</td>");
	out.println("<td>"+railin+"&nbsp;</td>");
	out.println("<td>"+brkt+"&nbsp;</td>");
	out.println("<td>"+cap1+"&nbsp;</td>");
	out.println("<td>"+cap2+"&nbsp;</td>");
	out.println("<td>"+capin+"&nbsp;</td>");
	out.println("<td><input type='button' name='continue' value='Continue' onclick='goBack1()'></td>");
	out.println("</table>");
	out.println("</form>");		
}

else if(operation.equals("addSave")){
	String message="";
	boolean isGood=true;
	String model=request.getParameter("model");
	String bpcs=request.getParameter("bpcs");
	String rail1=request.getParameter("rail1");
	String rail2=request.getParameter("rail2");
	String railin=request.getParameter("railin");
	String brkt=request.getParameter("brkt");
	String cap1=request.getParameter("cap1");
	String cap2=request.getParameter("cap2");
	String capin=request.getParameter("capin");
	if(model == null || model.trim().length()<=0){
		isGood=false;
		message=message+"No Model added!<BR>";
	}
	if(!isGood){
		message=message+"Please Try Again!!!";
		out.println(message);
		out.println("<form name='addThis' action='iwp_sample_maint.jsp'>");
		out.println("<input type='hidden' name='operation' value=''>");
		out.println("<input type='hidden' name='recordNum' value=''>");
		out.println("<table border='1' width='100%'>");
		out.println("<tr><td>model</td><td>bpcs</td><td>rail1</td><td>rail2</td><td>railin</td><td>brkt</td><td>cap1</td><td>cap2</td><td>capin</td><td>edit</td></tr>");
		out.println("<tr>");
		out.println("<td><input type='text' name='model' value='"+model+"' ></td>");
		out.println("<td><input type='text' name='bpcs' value='"+bpcs+"'></td>");
		out.println("<td><input type='text' name='rail1' value='"+rail1+"'></td>");
		out.println("<td><input type='text' name='rail2' value='"+rail2+"'></td>");
		out.println("<td><input type='text' name='railin' value='"+railin+"'></td>");
		out.println("<td><input type='text' name='brkt' value='"+brkt+"'></td>");
		out.println("<td><input type='text' name='cap1' value='"+cap1+"'></td>");
		out.println("<td><input type='text' name='cap2' value='"+cap2+"'></td>");
		out.println("<td><input type='text' name='capin' value='"+capin+"'></td>");
		out.println("<td><input type='button' name='Save' value='Save' onclick='goNow2()'>");
		out.println("<input type='button' name='Cancel' value='Cancel' onclick='goBack2()'></td>");
		out.println("</table>");
		out.println("</form>");			
	}
	else{
		int rowCount=0;
		ResultSet rs1=stmt.executeQuery("select count(*) from cs_iwp_sample where model='"+model+"'");
		if(rs1 != null){
			while(rs1.next()){
				rowCount=rs1.getInt(1);		
			}
		}
		rs1.close();
		if(rowCount>0){
			message="Keys already exist in this table.  Please try to either change the code.  Or if you are trying to update a record.  Please go back and click the edit button instead.";
			out.println(message);
			out.println("<form name='addThis' action='iwp_sample_maint.jsp'>");
			out.println("<input type='hidden' name='operation' value=''>");
			out.println("<input type='hidden' name='recordNum' value=''>");
			out.println("<table border='1' width='100%'>");
			out.println("<tr><td>model</td><td>bpcs</td><td>rail1</td><td>rail2</td><td>railin</td><td>brkt</td><td>cap1</td><td>cap2</td><td>capin</td><td>edit</td></tr>");
			out.println("<tr>");
			out.println("<td><input type='text' name='model' value='"+model+"' ></td>");
			out.println("<td><input type='text' name='bpcs' value='"+bpcs+"'></td>");
			out.println("<td><input type='text' name='rail1' value='"+rail1+"'></td>");
			out.println("<td><input type='text' name='rail2' value='"+rail2+"'></td>");
			out.println("<td><input type='text' name='railin' value='"+railin+"'></td>");
			out.println("<td><input type='text' name='brkt' value='"+brkt+"'></td>");
			out.println("<td><input type='text' name='cap1' value='"+cap1+"'></td>");
			out.println("<td><input type='text' name='cap2' value='"+cap2+"'></td>");
			out.println("<td><input type='text' name='capin' value='"+capin+"'></td>");	
			out.println("<td><input type='button' name='Save' value='Save' onclick='goNow2()'>");
			out.println("<input type='button' name='Cancel' value='Cancel' onclick='goBack2()'></td>");
			out.println("</table>");
			out.println("</form>");			
		
		}
		else{	
			myConn.setAutoCommit(false);
			try{				
				String insert ="INSERT INTO cs_iwp_sample(model,bpcs,rail1,rail2,railin,brkt,cap1,cap2,capin)VALUES(?,?,?,?,?,?,?,?,?) ";	
				PreparedStatement update_sample = myConn.prepareStatement(insert);	
				update_sample.setString(1,model);
				update_sample.setString(2,bpcs);
				update_sample.setString(3,rail1);
				update_sample.setString(4,rail2);
				update_sample.setString(5,railin);
				update_sample.setString(6,brkt);
				update_sample.setString(7,cap1);
				update_sample.setString(8,cap2);
				update_sample.setString(9,capin);
				int rocount = update_sample.executeUpdate();
				update_sample.close();				
				out.println("<form name='editDone' action='iwp_sample_maint.jsp'>");
				out.println("<input type='hidden' name='operation' value=''>");
				out.println("<input type='hidden' name='recordNum' value=''>");
				out.println("<table border='1' width='100%'>");
				out.println("<tr><td>model</td><td>bpcs</td><td>rail1</td><td>rail2</td><td>railin</td><td>brkt</td><td>cap1</td><td>cap2</td><td>capin</td><td>edit</td></tr>");
				out.println("<tr>");
				out.println("<td>"+model+"&nbsp;</td>");
				out.println("<td>"+bpcs+"&nbsp;</td>");
				out.println("<td>"+rail1+"&nbsp;</td>");
				out.println("<td>"+rail2+"&nbsp;</td>");
				out.println("<td>"+railin+"&nbsp;</td>");
				out.println("<td>"+brkt+"&nbsp;</td>");
				out.println("<td>"+cap1+"&nbsp;</td>");
				out.println("<td>"+cap2+"&nbsp;</td>");
				out.println("<td>"+capin+"&nbsp;</td>");
				out.println("<td><input type='button' name='continue' value='Continue' onclick='goBack1()'></td>");
				out.println("</table>");
				out.println("</form>");					
					
			}
			catch (java.sql.SQLException e)
			{
				out.println("Problem with ENTERING TO cs_iwp_sample TABLEs"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
			myConn.commit();
		}
	}
}
else if(operation.equals("delete")){
	String model = "";
	String recordNum=request.getParameter("recordNum");
	int recNo=Integer.parseInt(recordNum);	
	int a=0;	
	ResultSet rs1=stmt.executeQuery("select * from cs_iwp_sample order by model,bpcs");
	if(rs1 != null){	
		while(rs1.next()){		
			if(a==recNo){
				model=rs1.getString("model");			
			}
			a++;			
		}
		
	}
	rs1.close();
	if(model==null||model.equals("null")){
		model="";
	}
	myConn.setAutoCommit(false);
	try{
		String sqlDelete="delete from cs_iwp_sample where model='"+model+"'";
		int rsDelete=stmt.executeUpdate(sqlDelete);
	}
	catch (java.sql.SQLException e){
		out.println("Problem with deleteing from table");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;		
	}
	myConn.commit();
	out.println("<form name='editDone' action='iwp_sample_maint.jsp'>");
	out.println("<input type='hidden' name='operation' value=''>");
	out.println("<input type='hidden' name='recordNum' value=''>");
	out.println("<table border='1' width='100%'>");	
	out.println("<td><input type='button' name='continue' value='Continue' onclick='goBack1()'></td>");
	out.println("</table>");
	out.println("</form>");	
	
}
stmt.close();
myConn.commit();
myConn.close();	
%>
</body>
</html>