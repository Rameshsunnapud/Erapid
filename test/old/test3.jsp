<%@ page language="java" import="java.text.*" import="java.util.*"  errorPage="error.jsp" %>
<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:setProperty name="erapidBean" property="serverName" value="GREG" />
<%

out.println("HERE<BR>");
erapidBean.setServerName("test");
out.println(erapidBean.getServerName()+"::server name<BR>");
out.println(erapidBean.getFullServerName()+"::full server name<BR>");
out.println(erapidBean.getDbServerName()+"::dbservername<BR>");
out.println(erapidBean.getErapidDB()+"::erapiddb<BR>");
out.println(erapidBean.getErapidSysDB()+"::erapidsysdb<BR>");
out.println(erapidBean.getErapidDBUsername()+"::username<BR>");
out.println(erapidBean.getErapidDBPassword()+"::password<BR>");


%>