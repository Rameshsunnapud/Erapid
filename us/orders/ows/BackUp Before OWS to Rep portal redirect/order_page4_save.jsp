<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<%@ page language="java" import="java.util.*" import="java.text.*" import="java.sql.*" import="java.net.*" import="java.io.*" errorPage="error.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
	function popUpx(){
		//alert("HERE");
		var newWindowx2;
		//alert(document.form1x.product_id.value);
		//history.go(0);
		//location.reload(true);
		if(document.form1x.product_id.value!="GE"){
			var props='scrollBars=yes,resizable=yes,toolbar=yes,menubar=yes,location=yes,directories=yes,width=700,height=450';
			newWindowx2=window.open(document.form1x.url.value,"Add_from_Src_to_Destx2",props);
		}
		document.form1x.submit();
	}
</script>
<%
// REUQEST objects
		String order_no = request.getParameter("order_no");//
		String rep_no = request.getParameter("rep_no");//	new or old
%>
<%@ include file="../../../db_con.jsp"%>
<%


/*

out.println(name);
*/
// Greg's code starts here
String numSections=request.getParameter("numSections");
String submitted=request.getParameter("submitted");
String[] checkedX=request.getParameterValues("sss");
String button1=request.getParameter("button1");
String urlLink=request.getParameter("urlLink");
String isResend=request.getParameter("isResend");
String product_id="";
//urlLink=urlLink+"&sections="+submitted;
Vector check= new Vector();
//out.println(button1);

//ut.println(numSections+"num Sectionsx<BR>");
//out.println(submitted+"submitted x<BR>");
//out.println(urlLink+"<BR>");
////out.println(checkedX+"xBR>");
ResultSet rsProduct=stmt.executeQuery("select product_id from cs_project where order_no='"+order_no+"'");
if(rsProduct != null){
	while(rsProduct.next()){
		product_id=rsProduct.getString(1);
	}
}
rsProduct.close();
if(button1.equals("1")){

	int numSec=Integer.parseInt(numSections);
	if(submitted != null && submitted.trim().length()>0 && !(submitted.equals("null"))){
	}
	else{
	submitted="";
	}

	ResultSet current=stmt.executeQuery("select section_transfer from cs_quote_sections where order_no='"+order_no+"'");
	if(current !=null){
		while(current.next()){
			if(current.getString(1)!=null && current.getString(1).trim().length()>0){
				submitted=submitted+current.getString(1);
			}
		}
	}
	current.close();
	String test=submitted;
	int h=0;
	while(test.length()>0 && h<100){
		int start=0;
		int end=0;
		start=test.indexOf("=");
		//out.println(test.substring(0,start)+"x<BR>");
		check.addElement(test.substring(0,start));
		end=test.indexOf(";");
		test=test.substring(end+1);
		h++;
	}

	//out.println(submitted+":::<BR>");
	java.util.Date date = new java.util.Date();
	DateFormat df1 = DateFormat.getDateInstance(DateFormat.SHORT);
	String curMinutes = "00" + date.getMinutes();
	curMinutes = curMinutes.substring(curMinutes.length() -2);
	String currentTime=df1.format(date)+"@"+date.getHours()+":"+curMinutes;

	if(checkedX != null && !(checkedX.equals("null"))){
		for(int f=0; f < checkedX.length; f++){
			boolean isOk=true;
			//out.println(checkedX[f]);
			if(checkedX[f]!= null && checkedX[f].trim().length()>0){
				for(int ggg=0; ggg<check.size(); ggg++){
					if(checkedX[f].equals(check.elementAt(ggg).toString())){
						isOk=false;
						//out.println("false<BR>");
						//button1="9";
					}
				}
				if(isOk){
					submitted=submitted+checkedX[f]+"="+currentTime+";";
				}
			}
		}
	}
	//out.println(submitted+"+++<BR>");
	if(checkedX !=null && checkedX.length>0 && !(checkedX.equals("null"))){
		try	{
				int nrow= stmt.executeUpdate("UPDATE cs_quote_sections SET section_transfer='"+submitted+"', sections_checked='' WHERE order_no ='"+order_no+"'");
			}
		catch (java.sql.SQLException e){
			out.println("Problem with entering submitted sections"+"<br>");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}
	}

// Greg's code ends here

}
if(button1.equals("9")){
	java.util.Date date = new java.util.Date();
	DateFormat df1 = DateFormat.getDateInstance(DateFormat.SHORT);
	String currentTime=df1.format(date)+"@"+date.getHours()+":"+date.getMinutes();
	String resend="";
	ResultSet rsResend=stmt.executeQuery("select resend from cs_quote_sections where order_no='"+order_no+"'");
	if(rsResend != null){
		while(rsResend.next()){
			if(rsResend.getString(1) != null && rsResend.getString(1).trim().length()>0){
				resend=rsResend.getString(1);
			}
		}
	}
	rsResend.close();
	HttpSession UserSession1 = request.getSession();
	String name="";
	if(UserSession1.getAttribute("username")==null){
	name="";
	}
	else{
		name=UserSession1.getAttribute("username").toString();
	}
	resend=resend+currentTime+":"+name+":"+isResend+"#";
	try{
		int nrow= stmt.executeUpdate("UPDATE cs_quote_sections SET resend='"+resend+"' WHERE order_no ='"+order_no+"'");
	}
	catch (java.sql.SQLException e){
		out.println("Problem with updating sections table for resent sections"+"<br>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}

}
else{

	//out.println("here<BR>");
	String saveOnly="";
	if(checkedX != null){

		for(int w=0; w<checkedX.length; w++){
			saveOnly=saveOnly+checkedX[w]+",";
		}
	}

	//out.println("save only "+saveOnly+"<BR>");
	if(saveOnly.length()>0){
		try{
			int nrow= stmt.executeUpdate("UPDATE cs_quote_sections SET sections_checked='"+saveOnly+"' WHERE order_no ='"+order_no+"'");
		}
		catch(java.sql.SQLException e){
			out.println("Problem with entering saved sections"+"<br>");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;

		}
	}

}



myConn.setAutoCommit(false);
myConn.commit();//added just to be sure :)
stmt.close();
myConn.close();
String sectionOut="";
if(checkedX != null){

	for(int w=0; w<checkedX.length; w++){
		sectionOut=sectionOut+checkedX[w]+",";
	}
}
if(sectionOut.trim().length()<1){
		sectionOut=urlLink+"&sections=all";
}
else{
		sectionOut=urlLink+"&sections="+sectionOut;
}
//out.println(sectionOut);

// The out put for the page 4 for the order sheet
//URL yahoo = new URL("http://"+ application.getInitParameter("HOST")+"/erapid/us/orders/ows/order_transfer.jsp?cmd=4&order_no="+order_no+"&id="+rep_no+" ");

String fullUrl="https://"+ application.getInitParameter("HOST")+"/erapid/us/orders/ows/"+sectionOut;





//URL yahoo = new URL("http://"+ application.getInitParameter("HOST")+"/erapid/us/orders/ows/"+sectionOut);

out.println("<body onload='popUpx()'>");

out.println("<form name='form1x' action='order_transfer.jsp'>");
out.println("<input type='hidden' name='url' value='"+fullUrl+"'>");
out.println("<input type='hidden' name='cmd' value='5'>");
out.println("<input type='hidden' name='order_no' value='"+order_no+"'>");
out.println("<input type='hidden' name='id' value='"+rep_no+"'>");
out.println("<input type='hidden' name='product_id' value='"+product_id+"'>");
/*
URL yahoo = new URL("http://"+ application.getInitParameter("HOST")+"/erapid/us/orders/ows/order_transfer.jsp?cmd=5&order_no="+order_no+"&id="+rep_no+" ");

BufferedReader in = new BufferedReader(	new InputStreamReader(yahoo.openStream()));
	String inputLine;
	while ((inputLine = in.readLine()) != null)
out.println(inputLine);
in.close();
*/


out.println("</form>");

out.println("</body>");



// The out put for the page 4 for the order sheet done

}
catch(Exception e){
out.println(e);
}
%>
