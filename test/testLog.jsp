testLog.jsp
<%@ page language="java" import="java.text.*" import="java.util.*" import="java.io.*"  %>
a
<html><body>
<%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
org.slf4j.Logger logger2 = org.slf4j.LoggerFactory.getLogger("imsLogger");
logger.debug("application log test");
logger2.debug("ims log test");
out.println("done");
%>
</body></html>