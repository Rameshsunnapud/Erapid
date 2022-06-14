<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<%
//if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
//        erapidBean.setServerName("server1");
//}
try{

%>
<%@ page language="java" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" errorPage="error.jsp" %>
<%@ include file="../../../db_con.jsp"%>
<%
        String queryAdder="";        
        for(int i=-5; i<=0; i++){
            Calendar cal=Calendar.getInstance();
            cal.add(Calendar.DATE,i);
            java.util.Date day1=cal.getTime();
            queryAdder=queryAdder+" or (b.section_transfer like '%="+(day1.getMonth()+1)+"/"+day1.getDate()+"/"+(day1.getYear()-100)+"@%') ";
        }
        /*
	String dateWhere="";
	for(int i=5; i<=30; i++){
		dateWhere=dateWhere+" or (b.section_transfer LIKE '%=6/"+i+"/17@%')";
	}
	for(int i=1; i<=31; i++){
		dateWhere=dateWhere+" or (b.section_transfer LIKE '%=7/"+i+"/17@%')";
	}
	dateWhere=dateWhere.substring(3);
        */
        queryAdder= queryAdder.substring(3);
	String sectionQuery="select * from cs_quote_sections where order_no in (";
	//String query="SELECT     a.Order_no, a.BPCS_Order_no, a.Project_name, a.product_id, a.creator_id, a.user_id, a.assigned_rep_no,a.project_type, b.section_transfer FROM         cs_project AS a INNER JOIN cs_quote_sections AS b ON a.Order_no = b.order_no WHERE     (a.BPCS_Order_no IS NULL OR a.BPCS_Order_no = '') AND ("+dateWhere+")";
	String query="SELECT     a.Order_no, a.BPCS_Order_no, a.Project_name, a.product_id, a.creator_id, a.user_id, a.assigned_rep_no,a.project_type, b.section_transfer FROM         cs_project AS a INNER JOIN cs_quote_sections AS b ON a.Order_no = b.order_no WHERE     (a.BPCS_Order_no IS NULL OR a.BPCS_Order_no = '') AND ("+queryAdder+")";
        Vector order_no=new Vector();
	Vector bpcs_order_no=new Vector();
	Vector project_name=new Vector();
	Vector product_id=new Vector();
	Vector creator_id=new Vector();
	Vector user_id=new Vector();
	Vector assigned_rep_no=new Vector();
	Vector project_type=new Vector();
	Vector section_transfer=new Vector();
	ResultSet rs0=stmt.executeQuery(query);
	if(rs0 !=null){
		while(rs0.next()){
			order_no.addElement(rs0.getString("order_no"));
			if(rs0.getString("bpcs_order_no")!=null){
				bpcs_order_no.addElement(rs0.getString("bpcs_order_no"));
			}
			else{
				bpcs_order_no.addElement("");
			}
			if(rs0.getString("project_name")!=null){
				project_name.addElement(rs0.getString("project_name"));
			}
			else{
				project_name.addElement("");
			}
			if(rs0.getString("product_id")!=null){
				product_id.addElement(rs0.getString("product_id"));
			}
			else{
				product_id.addElement("");
			}
			if(rs0.getString("creator_id")!=null){
				creator_id.addElement(rs0.getString("creator_id"));
			}
			else{
				creator_id.addElement("");
			}
			if(rs0.getString("user_id")!=null){
				user_id.addElement(rs0.getString("user_id"));
			}
			else{
				user_id.addElement("");
			}
			if(rs0.getString("assigned_rep_no")!=null){
				assigned_rep_no.addElement(rs0.getString("assigned_rep_no"));
			}
			else{
				assigned_rep_no.addElement("");
			}
			if(rs0.getString("project_type")!=null){
				project_type.addElement(rs0.getString("project_type"));
			}
			else{
				project_type.addElement("");
			}
			if(rs0.getString("section_transfer")!=null){
				section_transfer.addElement(rs0.getString("section_transfer"));
			}
			else{
				section_transfer.addElement("");
			}
		}
	}
	rs0.close();
	String[] directoryName=new  String[7];
	directoryName[0]="D:\\transfer\\BPCS_OE\\testing";
	directoryName[1]="D:\\transfer\\BPCS_OE\\testing\\ads";
	directoryName[2]="D:\\transfer\\BPCS_OE\\testing\\efs";
	directoryName[3]="D:\\transfer\\BPCS_OE\\testing\\ejc";
	directoryName[4]="D:\\transfer\\BPCS_OE\\testing\\gcp";
	directoryName[5]="D:\\transfer\\BPCS_OE\\testing\\ge";
	directoryName[6]="D:\\transfer\\BPCS_OE\\testing\\iwp";
	out.println("<table border='1' width='100%'>");

	out.println("<tr><td></td><td><b>ORDER NO</b></td><td><b>BPCS ORDER NO</b></td><td><b>PROJECT NAME</b></td><td><b>PRODUCT ID</b></td><td><b>CREATOR ID</b></td><td><b>USER ID</b></td><td><b>ASSIGNED REP NUMBER</b></td><td><b>PROJECT TYPE</B></TD></tr>");
	int count=1;
	for(int y=0; y<order_no.size(); y++){
		boolean match=false;
		for(int i=0; i<=6; i++){
			File directory=new File(directoryName[i]);
			File[] fList=directory.listFiles();
			for(File file: fList){
					if(file.getName().equals("O"+order_no.elementAt(y).toString()+".txt")){
						match=true;
					}
			}
		}
		if(!match){
			sectionQuery=sectionQuery+"'"+order_no.elementAt(y).toString()+"'";
			out.println("<tr>");
			out.println("<td>"+count+"</td>");
			out.println("<td>"+order_no.elementAt(y).toString()+"</td>");
			out.println("<td>"+bpcs_order_no.elementAt(y).toString()+"</td>");
			out.println("<td>"+project_name.elementAt(y).toString()+"</td>");
			out.println("<td>"+product_id.elementAt(y).toString()+"</td>");
			out.println("<td>"+creator_id.elementAt(y).toString()+"</td>");
			out.println("<td>"+user_id.elementAt(y).toString()+"</td>");
			out.println("<td>"+assigned_rep_no.elementAt(y).toString()+"</td>");
			out.println("<td>"+project_type.elementAt(y).toString()+"</td>");
			out.println("<td>"+section_transfer.elementAt(y).toString()+"</td>");
			out.println("</tr>");
			count++;
		}
	}
	sectionQuery=sectionQuery.replaceAll("''","','")+")";
	out.println(sectionQuery);

}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>
