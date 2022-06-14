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
		<link rel='stylesheet' href='style1.css' type='text/css' />
		<%
		String pid = request.getParameter("pid");
		String pl = request.getParameter("place");
		String tl1 = request.getParameter("tbox");
		%>
		<script language="JavaScript">
<!--

			function LTrim(str){
				var whitespace=new String(" \t\n\r");
				var s=new String(str);

				if(whitespace.indexOf(s.charAt(0))!=-1){
					var j=0,i=s.length;
					while(j<i&&whitespace.indexOf(s.charAt(j))!=-1)
						j++;
					s=s.substring(j,i);
				}
				return s;
			}

			function RTrim(str){
				var whitespace=new String(" \t\n\r");
				var s=new String(str);

				if(whitespace.indexOf(s.charAt(s.length-1))!=-1){
					var i=s.length-1;
					while(i>=0&&whitespace.indexOf(s.charAt(i))!=-1)
						i--;
					s=s.substring(0,i+1);
				}

				return s;
			}

			function Trim(str){
				return RTrim(LTrim(str));
			}

			function checkNotes(iIndex){
				var src=window.document.forms[0];
				var iSize=src.tb.value;
				for(var i=0;i<iSize;i++){
					if(src.C1[i].value==iIndex)
						src.C1[i].checked=true;
				}
			}


			// Add the selected items in the parent by calling method of parent
			function addSelectedNotesToParent( ){
				//top.window.document.selectform_pl.close.value="TEST";
				top.window.close();
			}



			function initSelectedNotes(){
				var destList=window.document.forms[0];
				//var srcList = self.opener.window.document.forms[0].taNotesExclusions;

				// get notes from parent window
				//for (var i=0;i<de_no;i++)
				//{
				var szNotes="";
				var lc=<%= pl %>;
				//alert(lc);
				szNotes=self.opener.window.document.forms[0].e[lc-1].value;

				//alert(szNotes);

				if(szNotes=="")
					return;

				// add ","
				if(szNotes.slice(szNotes.length,1)!=","){
					szNotes+=","
				}

				// remove encoded hex chars..
				szNotes=unescape(szNotes);

				// iterate id notes from parent
				var iIndex;
				var iLoc=1;
				do{
					iLoc=szNotes.search(",");
					if(iLoc>=0){
						iIndex=szNotes.slice(0,iLoc);

						//alert(iIndex);
						checkNotes(iIndex);
						szNotes=Trim(szNotes.slice(iLoc+1,szNotes.length));
					}
				}while(iLoc>=0);
				//}
			}

-->
		</SCRIPT>
	</head>
	<body onLoad="initSelectedNotes()">
	<center>
		<form method="POST">
			<table>
				<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>

				<%@ include file="../../../db_con.jsp"%>
				<%
				if(pid.endsWith("LVR")|pid.equals("BV")){pid="LVR";}
				Vector code=new Vector();Vector desc=new Vector();int count=0;
					    ResultSet rs = stmt.executeQuery("SELECT * FROM cs_exc_notes where product_id like '"+pid+"' order by code");
					  while ( rs.next() ) {
					   code.addElement(rs.getString( 1 )) ;
					  desc.addElement(rs.getString( 2 )) ;
					   count++;
										   }
				if (count>0){
				%>
				<input type="hidden" name="tb" value='<%= count %>'>
				<input type="hidden" name="pl_hold" value='<%= pl %>'>
				<input type="hidden" name="tl" value='<%= tl1 %>'>
				<b><h1>Exclusion Notes:</h1></b>
				<%
				for (int mn=0;mn<count;mn++){
				out.println("<tr><td><input type='checkbox' name='C1' value='"+code.elementAt(mn)+"'>"+code.elementAt(mn)+" Note: "+desc.elementAt(mn)+"</tr></td>");
											}
				%>

				<tr><td>&nbsp;</td></tr>
				<tr><td align="center">	<input type="button" class='button' value="Done" onClick = "javascript:addSelectedNotesToParent()"></tr></td>
			</table>
		</form>
		<%
		}
		else {
		out.println("There are no standarad exclusions for <b>"+pid+"</b> .please contact the <b>"+pid+" </b>product team for more info");
		}
		rs.close();
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