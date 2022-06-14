<% request.setCharacterEncoding( response.getCharacterEncoding() ); %>
<link rel='stylesheet' href='../css/styleMain.css' type='text/css' />
<%@ page language="java" import="java.text.*" import="java.util.*" import="java.io.*"   contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="error.jsp" %>
<script language="JavaScript" src="../javascript/tableMaint.js"		></script>
<script language="JavaScript" src="../javascript/ajax.js"			></script>
<jsp:useBean id="tableMaint" 	class="com.csgroup.general.TableMaint"		scope="page"/>
<body>
	*remember Greg is hard coded right now.  Remove this message when that is updated.
	<form name='form1'>
		<%
		out.println("<select name='tableName' onchange='selectTable()'>");
		out.println("<option value=''></option>");
		out.println(tableMaint.getTables("gsuisham","super"));
		out.println("</select>");
		out.println("<input type='hidden' name='html'>");
		out.println("<input type='hidden' name='rowcount'>");
		%>
	</form>
	<div	 id='tableResults'	class='displayResults' >
		<form name='form2'>

		</form>
	</div>
	<div id='loadingResults' class='loadResults' >
		<center><table width='100%' height='100%' border='0' ><tr><td align='center'><font color='red' size='3'>LOADING....</font></td></tr></table></center>
	</div>
</body>