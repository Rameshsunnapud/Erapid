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
		<font face="Courier">Hello, World!</font><br>
		<font face="Arial">should be 'Hello, World!' above</font><br>

		<font face="Arial" size="+2">

<p>مرحبا, العالم!</p>
<p>متوفر في 123 مجموعة لغة.
الدقة قصوى.
التصميم الأفضل.
الفهرس الأكبر.
التطوير المتوفر بسهولة الإنساني.
&nbsp;</p>


</font>
		<font face="SimSun">賲乇丨亘丕, 丕賱毓丕賱賲!</font><br>
		<font face="Wingdings">Hello, World! (wing)</font><br>
		<input type="submit" value="مرحبا, 1970 العالم!">
	</body>

</html>
</pd4ml:transform>



