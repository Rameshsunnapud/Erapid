<%@ taglib uri="/WEB-INF/tlds/pd4ml.tld" prefix="pd4ml" %><%@page
contentType="text/html; charset=WINDOWS-874"%><pd4ml:transform
	screenWidth="400"
	pageFormat="A5"
	pageOrientation="landscape"
	pageInsets="15,15,15,15,points"
	inline="true"
	debug="true"
	outline="headings"
	fileName="myreport.pdf">


<!--
TODO:
1. adjust fonts directory below.
2. make sure that the directory contains pd4fonts.properties file
3. for more info see PD4ML.useTTF( String, boolean ) Java API docs
-->
<pd4ml:usettf from="/windows/fonts"/>

<pd4ml:header
	titleTemplate="สวัสดีครับ"
	pageNumberTemplate="default"
	titleAlignment="left"
	fontSize="14"
	color="#008000"
	fontFace="AngsanaUPC"
	fontStyle="plain"
	areaHeight="36"/>


<HTML>
<HEAD>
<META http-equiv="Content-Type" content="text/html; charset=WINDOWS-874">
</HEAD>
<BODY>
<font face="AngsanaUPC" size="+4">สวัสดีครับ</font>

<h1><font face="AngsanaUPC">สวัสดีครับ</font></h1>
<h2><font face="AngsanaUPC">สวัสดีครับ</font></h2>
<h3><font face="AngsanaUPC">สวัสดีครับ</font></h3>

</BODY>
</HTML>

</html>
</pd4ml:transform>


