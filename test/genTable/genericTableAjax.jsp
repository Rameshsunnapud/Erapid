<%@ page language="java" import="java.lang.String.*" contentType="text/html;charset=ISO-8859-1" %><jsp:useBean id="tblMaint" class="com.csgroup.general.TableMaint" scope="page"/><jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="page"/><% 

org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
String tableName = request.getParameter("table");
String functName = request.getParameter("method");
String[] prods = userSession.getProducts();

if(functName.equals("getHTMLTableRows")){
    String userID = request.getParameter("userID");
    out.println(tblMaint.getHTMLTableRows(tableName,prods,userID));
}
else if(functName.equals("updateTableRecord")){
    String values = request.getParameter("cols");
    out.println(tblMaint.updateTableRecord(tableName,values));
}
else if(functName.equals("insertTableRecord")){
    String values = request.getParameter("cols");
    out.println(tblMaint.insertTableRecord(tableName,values));
}
else if(functName.equals("searchTblFilter")){
    String query = request.getParameter("query");
    String multi = request.getParameter("multi");
    String isSuper = request.getParameter("isSuper");

    out.println(tblMaint.searchTblFilter(tableName,query,multi,isSuper));
}
else if(functName.equals("uploadExcelFile")){
    String file = request.getParameter("file");
    logger.debug(file);
    out.println(tblMaint.uploadExcelFile(tableName,file));
}
else if(functName.equals("deleteEntry")){
    String data = request.getParameter("columns");
    out.println(tblMaint.deleteEntry(tableName,data));
}
else{
    out.println("Error:No function was set!");
}
//switch(function){
//    case "getHTMLTableRows":
//        logger.debug(tableName);
//        out.println(tblMaint.getHTMLTableRows(tableName));
//        break;
//    case "updateGenTable":
//
//        break;
//    default;
//        out.println("Error:No function was set!")
//        break;
//    //String json = "['HTML':'"+ tblMaint.getHTMLTableRows(tableName).replaceAll("'","") +"']";
//    //out.println(json);
//
//}
        
%>