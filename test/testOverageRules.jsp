<%@ page language="java" import="java.text.*" import="java.util.*" import="java.io.*"  %>
<jsp:useBean id="priceCalc" class="com.csgroup.general.PriceCalcBean" scope="page"/>
<%
String orderNo="101019_00";
out.println(priceCalc.overageRules(orderNo));
%>