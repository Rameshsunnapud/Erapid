<%@ page import="java.lang.String.*" contentType="text/html" pageEncoding="utf-8" %><jsp:useBean id="tblMaint" class="com.csgroup.general.TableMaint" scope="page"/><%
    org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");

    String tableName = request.getParameter("table");
//    response.setContentType("application/octet-stream");
//    response.setHeader("Content-Disposition","attachment;filename="+ tableName +".xml");
    String browserType = request.getHeader("User-Agent");
    out.println("<FONT COLOR='red' size='4'>DOWNLOADING! PLEASE WAIT</FONT>");
    String filepath = tblMaint.writeExcelFile(tableName,browserType);
    out.println(filepath);

    out.println("<a href='../../shared/"+ filepath +"'>Right-click me and click \"Save Target As...\" to get file (Internet Explorer). Make sure to keep the name.</a>");
    

%> 