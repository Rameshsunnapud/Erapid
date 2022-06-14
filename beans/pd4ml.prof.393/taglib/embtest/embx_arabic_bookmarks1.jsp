<%@ taglib uri="/WEB-INF/tlds/pd4ml.tld" prefix="pd4ml" %><%@page
contentType="text/html; charset=UTF-8"%><pd4ml:transform
	screenWidth="400"
	pageFormat="A5"
	pageOrientation="landscape"
	pageInsets="15,15,15,15,points"
	inline="true"
	debug="true"
	outline="anchors"
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
		<title>مرحبا, العالم!</title>
		<META http-equiv=Content-Type content="text/html; charset=utf-8">
	</head>
	<body>
		<font face="Tahoma">Hello, World!</font><br>
		<font face="Arial">

<p>متوفر في 123 مجموعة لغة.
الدقة قصوى.
التصميم الأفضل.
الفهرس الأكبر.
التطوير المتوفر بسهولة الإنساني.
&nbsp;</p>

		</font>
		<p>
		<a name="2"><font face="Arial">مرحبا, العالم!</font></a><br>
		<a name="3"><font face="Arial"></font></a><br>
		<a name="1"><font face="Arial">الدقة قصوى.</font></a><br>
		<input type="submit" value="الفهرس الأكبر.">
	</body>

</html>
</pd4ml:transform>



