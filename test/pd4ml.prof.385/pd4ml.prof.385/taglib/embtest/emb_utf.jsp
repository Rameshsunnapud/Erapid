<%@ taglib uri="/WEB-INF/tlds/pd4ml.tld" prefix="pd4ml" %><%@page
contentType="text/html; charset=UTF-8"%><pd4ml:transform
	screenWidth="400"
	pageFormat="A5"
	pageOrientation="landscape"
	pageInsets="15,15,15,15,points"
	inline="true"
	debug="true"
	fileName="myreport.pdf">

<!--
TODO:
1. adjust fonts directory below.
2. make sure that the directory contains pd4fonts.properties file
3. for more info see PD4ML.useTTF( String, boolean ) Java API docs
-->
<pd4ml:usettf from="/windows/fonts"/>

<html>
	<head>
		<title>PD4ML embedded fonts test</title>
		<META http-equiv=Content-Type content="text/html; charset=utf-8">
	</head>
	<body>
		<font face="Tahoma">Hello, World!</font><br>
		<font face="Verdana">Привет, Мир!</font><br>
		<font face="SimSun">賲乇丨亘丕, 丕賱毓丕賱賲!</font><br>
	</body>

</html>
</pd4ml:transform>



