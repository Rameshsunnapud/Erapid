<%@ page isErrorPage="true" import="java.io.*" contentType="text/html"%>

<HTML>
    <HEAD>
        <TITLE> custom error page </TITLE>
    </head>
    <body>
       <h2>ID10T: Your application has generated a 500 error</h2>


Message:
<%= exception.toString()%>

StackTrace:
<%
	StringWriter stringWriter = new StringWriter();
	PrintWriter printWriter = new PrintWriter(stringWriter);
	exception.printStackTrace(printWriter);
	out.println(stringWriter);
	printWriter.close();
	stringWriter.close();
%>

    </body>
</html>
