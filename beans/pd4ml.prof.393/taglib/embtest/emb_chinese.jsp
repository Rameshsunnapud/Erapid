<%@ taglib uri="/WEB-INF/tlds/pd4ml.tld" prefix="pd4ml" %><%@page
contentType="text/html; charset=utf-8"%><pd4ml:transform
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
		<font face="SimSun">
<p>賲乇丨亘丕, 丕賱毓丕賱賲!</p>
<p>賲鬲賵賮乇 賮賷 123 賲噩賲賵毓丞 賱睾丞. <br>
丕賱丿賯丞 賯氐賵賶.<br>
丕賱鬲氐賲賷賲 丕賱兀賮囟賱.<br>
丕賱賮賴乇爻 丕賱兀賰亘乇.<br>
丕賱鬲胤賵賷乇 丕賱賲鬲賵賮乇 亘爻賴賵賱丞 丕賱廿賳爻丕賳賷.<br>
&nbsp;</p>
</font><br>
	</body>

</html>
</pd4ml:transform>



