<% request.setCharacterEncoding( response.getCharacterEncoding() ); %>
<link rel='stylesheet' href='../css/styleMain.css' type='text/css' />
<script language="JavaScript" src="../javascript/ajax.js"		></script>
<script language="JavaScript" src="../javascript/architect.js"	></script>
<jsp:useBean id="architect" 	class="com.csgroup.general.ArchitectBean" 	scope="page"/>
<%@ page language="java" import="java.text.*" import="java.util.*" import="java.io.*"   contentType="text/html; charset=utf-8" pageEncoding="utf-8" errorPage="error.jsp" %>
<body onload="getArchitects()">
	<form  name='form1'>
		<table width='100%' border='0' CELLPADDING='0' CELLSPACING='0'>
			<tr>
				<td>Name:</td><td><input type='text' name='name' onkeyup='JavaScript:getArchitects()'></TD>
				<td>City:</td><td><input type='text' name='city' onkeyup='JavaScript:getArchitects()'></TD>
			</tr>
			<tr>
				<td>State:</td><td><input type='text' name='state' onkeyup='JavaScript:getArchitects()'></TD>

			</tr>
			<tr>
				<td colspan='2'><input type='button' class='button' name='close' value='Close'   onclick='closex()'></TD>
			</tr>
		</table>
	</form>
	<div id="resultx" class='resultsx'></div>
</body>