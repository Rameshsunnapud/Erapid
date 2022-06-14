<%@ taglib uri="/WEB-INF/tlds/pd4ml.tld" prefix="pd4ml" %><pd4ml:transform
	screenWidth="400"
	pageFormat="A5"
	pageOrientation="landscape"
	pageInsets="15,15,15,15,points"
	inline="true"
	debug="true"
	fileName="myreport.pdf">

<pd4ml:header
	titleTemplate="Header with \\ (escape) chars"
	pageNumberTemplate="default"
	titleAlignment="left"
	fontSize="14"
	color="#008000"
	fontFace="Comic Sans MS"
	fontStyle="bolditalic"
	areaHeight="36"/>

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
	</head>
	<body>
		<font face="Tahoma">Header should have font 'Comic Sans MS'</font><br>
	</body>

</html>
</pd4ml:transform>



