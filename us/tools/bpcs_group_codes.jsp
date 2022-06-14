<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<%
//if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
//        erapidBean.setServerName("server1");
//}
try{

%><html>
	<head>
		<title>BPCS Group Codes</title>

		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>
	<body>
		<SCRIPT LANGUAGE="JavaScript">
			function forwarding(){
				document.location.href='ge_maint_home.jsp';
			}
		</script>
		<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con_bpcs.jsp"%>
		<%@ include file="../../../db_con.jsp"%>
		<%

		out.println("Running BPCS group codes update.");

		Vector cccode= new Vector();
		Vector ccdesc= new Vector();
		Vector cccodeCur= new Vector();
		Vector ccdescCur= new Vector();
		Vector cccodeUpdate=new Vector();
		Vector ccdescUpdate=new Vector();
		Vector cccodeNew=new Vector();
		Vector ccdescNew=new Vector();
		Vector cccodeDelete=new Vector();
		int b=0;
		int c=0;

		ResultSet rs=stmt_bpcs.executeQuery("Select CCCODE, CCDESC from zcc where CCTABL = 'CUSTGRP' and CCSDSC='GE'");
		if(rs !=null){
			while(rs.next()){
				cccode.addElement(rs.getString(1));
				ccdesc.addElement(rs.getString(2));
				//out.println("<tr><Td>"+rs.getString(1)+"</td>");
				//out.println("<Td>"+rs.getString(2)+"</td></tr>");
			}
		}
		rs.close();
		//out.println("1");
		ResultSet rs2=stmt.executeQuery("Select ccode, ccdesc from cs_ge_group_codes order by ccode");
		if(rs2 != null){
			while(rs2.next()){
				cccodeCur.addElement(rs2.getString(1));
				ccdescCur.addElement(rs2.getString(2));
				//out.println(rs2.getString(1)+"::"+rs2.getString(2)+"<BR>");
			}
		}
		rs2.close();
//out.println("2");
		for(int h=0; h<cccode.size(); h++){
			boolean isMatch=false;
			for(int i=0; i<cccodeCur.size(); i++){
				if(cccode.elementAt(h).toString().trim().equals(cccodeCur.elementAt(i).toString().trim())){
					isMatch=true;
					if(!(ccdesc.elementAt(h).toString().trim().equals(ccdescCur.elementAt(i).toString().trim()))){
						cccodeUpdate.addElement(cccode.elementAt(h).toString());
						ccdescUpdate.addElement(ccdesc.elementAt(h).toString());
					}
				}
			}
			if(! isMatch){
				b++;
				cccodeNew.addElement(cccode.elementAt(h).toString());
				ccdescNew.addElement(ccdesc.elementAt(h).toString());
			}
			else{
				c++;
			}
		}

		out.println(c+"matches<BR>"+b+"<font color='red'>mismatches</font><BR><BR>");
		out.println("<table border='1'><tr><Td>cccode</td><td>ccdesc</td></tr>");
		System.out.println(c+" matches<BR>"+b+" mismatches<BR><BR>");

		for(int j=0; j<cccodeNew.size(); j++){
			out.println("<tr><td>"+cccodeNew.elementAt(j).toString()+"</td><td>"+ccdescNew.elementAt(j).toString()+"</td></tr>");
		}
		out.println("</table><BR><BR>");


		// finds records to delete(records in cs that aren't in bpcs)
		out.println("<table border='1'><tr><td>not in bpcs</td></tr>");
		for(int hh=0; hh<cccodeCur.size(); hh++){
			boolean isMatch=false;
			for(int ii=0; ii<cccode.size(); ii++){
				if(cccode.elementAt(ii).toString().trim().equals(cccodeCur.elementAt(hh).toString().trim())){
					isMatch=true;
				}
			}
			if(! isMatch){
				cccodeDelete.addElement(cccodeCur.elementAt(hh).toString());
				out.println("<tr><td>"+cccodeCur.elementAt(hh).toString()+"</td></tr>");
			}
		}
		out.println("</table><br><BR>");



		out.println("<table border='1'><tr><Td cosplan='2'>Update</td></tr>");
		for(int q=0; q<cccodeUpdate.size(); q++){
			out.println("<tr><td>"+cccodeUpdate.elementAt(q).toString()+"</td><td>"+ccdescUpdate.elementAt(q).toString()+"</td></tr>");
		}
		out.println("</table>");
		myConn.setAutoCommit(false);

		//INSERT NEW CODES
		for(int p=0; p<cccodeNew.size(); p++){
			try{
				String updateString ="INSERT INTO cs_ge_group_codes (ccode, ccdesc)VALUES(?,?) ";
				java.sql.PreparedStatement updateCodes = myConn.prepareStatement(updateString);
				updateCodes.setString(1,cccodeNew.elementAt(p).toString());
				updateCodes.setString(2,ccdescNew.elementAt(p).toString());
				int rocount=updateCodes.executeUpdate();
				updateCodes.close();
			}
			catch (java.sql.SQLException e){
				out.println("Problem with entering into cs_ge_group_codes table");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
		}

		//UPDATE EXISTING CODES
		for(int v=0; v<cccodeUpdate.size(); v++){
				try
				{
				String insert ="update cs_ge_group_codes set ccdesc=? WHERE ccode= ?";
				PreparedStatement updateCodes2 = myConn.prepareStatement(insert);
						updateCodes2.setString(1,ccdescUpdate.elementAt(v).toString());
						updateCodes2.setString(2,cccodeUpdate.elementAt(v).toString());
						int rocount = updateCodes2.executeUpdate();
						updateCodes2.close();
				}
				catch (java.sql.SQLException e)
				{
					out.println("Problem with Updating cs_ge_group_codes TABLEs"+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					myConn.rollback();
					out.println(e.toString());
					return;
			}
		}



		// DELETE UNMATCHED CODES
		for(int bb=0; bb<cccodeDelete.size(); bb++){
			try{
				stmt.executeUpdate("delete from cs_ge_group_codes where ccode='"+cccodeDelete.elementAt(bb).toString()+"' ");
			}
			catch (java.sql.SQLException e){
				out.println("Problem with deleting from cs_ge_group_codes table");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
		}

		myConn.commit();
		stmt.close();

		out.println("DONE<br>");
		%>
		<input type='button' name='x' onclick='forwarding()' value='GE MAINTENANCE HOME'>
	</body>
</html>
<%
}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>
