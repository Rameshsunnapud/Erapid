<jsp:useBean id="tax" 	class="com.csgroup.general.TaxCalc" 	scope="page"/> 
<%@ page language="java" import="java.text.*" import="java.util.*" import="java.io.*"   errorPage="error.jsp" %>
<% 
tax.setZip("90210");
//out.println(tax.getZip()+":: Get zip<BR><BR>");
//out.println(tax.taxValue("1000","90210"));
out.println(tax.getTotalTaxValue("022060_10")+"<BR><BR>");
out.println(tax.getZip()+":: Get zip<BR><BR>");
out.println(tax.getTaxRate()+":: Get zip<BR><BR>");
out.println(tax.getIsValidZip()+":: Get zip<BR><BR>");
%>