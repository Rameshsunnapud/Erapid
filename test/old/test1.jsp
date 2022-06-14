<%@ page language="java" import="java.text.*" import="java.util.*"  errorPage="error.jsp" %>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/>
<%
userSession.setUserId("gsuisham");
userSession.setUserName("Greg Suisham");
userSession.setGroup("super");
userSession.setOrderNo("123456_00");
userSession.setLineNo("1");

String userId=userSession.getUserId();
String userName=userSession.getUserName();
String group=userSession.getGroup();
String orderNo=userSession.getOrderNo();
String lineNo=userSession.getLineNo();

out.println(userId+"::userid<BR>");
out.println(userName+"::userName<BR>");
out.println(group+"::group<BR>");
out.println(orderNo+"::orderNo<BR>");
out.println(lineNo+"::lineNo<BR>");

%>