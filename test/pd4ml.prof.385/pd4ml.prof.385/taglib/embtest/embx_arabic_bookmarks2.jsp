<%@ taglib uri="/WEB-INF/tlds/pd4ml.tld" prefix="pd4ml" %><%@page
contentType="text/html; charset=UTF-8"%><pd4ml:transform
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

<html>
	<head>
		<title>PD4ML embedded fonts test</title>
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
		<h1><font face="Arial">التصميم الأفضل.</font></h1><br>
		<h2><font face="Arial">الدقة قصوى.</font></h2><br>
		<h2><font face="Arial">التصميم الأفضل.</h2><br>
		<h1><font face="Arial">الفهرس الأكبر.</h1><br>
		<h2><font face="Arial">الفهرس الأكبر.</font></h2><br>
		<h2><font face="Arial">الدقة قصوى.</h2><br>
	</body>

</html>
</pd4ml:transform>



