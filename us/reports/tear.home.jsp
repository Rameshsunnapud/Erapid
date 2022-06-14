
<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

		String order_no = request.getParameter("orderNo");//Login id
		String pid = request.getParameter("pid");
		String line_no=request.getParameter("line_no");
		//HttpSession UserSession1 = request.getSession();
		//String name=UserSession1.getAttribute("username").toString();
		String name="tearsheet";
if(pid==null){
pid="";
}
%>
<%@ page language="java" import="java.sql.*" import="java.net.*" import="java.io.*" import="java.util.*" errorPage="error.jsp" %>
<%@ include file="../../db_con.jsp"%>
<%@ include file="../../db_con_sfdc.jsp" %>
<%
String product="";String doc_type="";String rep_tear_sheet="";String project_type="";
String rep_quote=""; String cust_no="";String sfdcAccount="";
String cust_name1="";String ccode="";
ResultSet rs_project = stmt.executeQuery("SELECT product_id,rep_tear_sheet,project_type,rep_quote,Cust_name,accountId FROM cs_project where Order_no like '"+order_no+"'");
if (rs_project !=null) {
        while (rs_project.next()) {
		product= rs_project.getString("product_id").trim();
		project_type= rs_project.getString("project_type");
		rep_tear_sheet= rs_project.getString("rep_tear_sheet");
		rep_quote=rs_project.getString("rep_quote");
		cust_no=rs_project.getString("Cust_name");
		sfdcAccount=rs_project.getString("accountId");
	}
}
rs_project.close();

if(sfdcAccount==null || sfdcAccount.equals("null")){
	sfdcAccount="";
}

if ((project_type==null)||(project_type.startsWith("nul"))||project_type.trim().length()==0){
    ccode=cust_no.substring(0,2);
if ((ccode.equals("US"))) {cust_no=cust_no.substring(2);}
    else {ccode="US";}
    ResultSet rs_customers = stmt.executeQuery("SELECT cust_name1 FROM cs_customers where cust_no like '"+cust_no+"' and country_code='"+ccode+"' ");
    if (rs_customers !=null) {
while (rs_customers.next()) {
    cust_name1= rs_customers.getString("cust_name1");
}
}
rs_customers.close();
}

if(sfdcAccount != null && sfdcAccount.trim().length()>0){
	ResultSet rsSfAccount2=stmt_sfdc.executeQuery("select name from account where id='"+sfdcAccount+"'");
	if(rsSfAccount2 != null){
		while(rsSfAccount2.next()){
			if(rsSfAccount2.getString(1) != null && rsSfAccount2.getString(1).trim().length()>0){
					cust_name1=rsSfAccount2.getString(1);
			}
		}
	}
	rsSfAccount2.close();
}

if(rep_quote == null ){
	rep_quote="";
}

if(project_type==null ||project_type.trim().equals("") || project_type.equals("RP")){
	rep_tear_sheet="2";
}
else{
        if(rep_tear_sheet==null ||rep_tear_sheet.trim().equals("")){rep_tear_sheet="1";}
}
ResultSet rs_docheader=stmt.executeQuery("select doc_type from doc_header where doc_number like '"+order_no+"'");
if(rs_docheader != null){
	while(rs_docheader.next()){
		doc_type=rs_docheader.getString(1);
	}
}
rs_docheader.close();
if(product.equals("EFS")){
//out.println("The product is EFS");
%>
<%@ include file="tear.sheet.efs.jsp"%>
<%
						}
else if (product.equals("EJC")){
//out.println("The product is IWP");
%>
<%@ include file="tear.sheet.ejc.jsp"%>
<%
						}
else if (product.equals("LVR")){
//out.println("The product is IWP");
%>
<%@ include file="tear.sheet.lvr.jsp"%>
<%
						}

else if (product.equals("IWP")||product.equals("GE")){
//out.println("The product is IWP");
%>
<%@ include file="tear.sheet.iwp.jsp"%>
<%
						}

else {
//out.println("The product is EJC");
%>
<%@ include file="tear.sheet.efs.jsp"%>
<%
		}


}
catch(Exception e){
out.println(e);
}
%>
