<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<%
//if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
//        erapidBean.setServerName("server1");
//}
        String emailBody="List of issues:: \r\n";
try{

%>
<%@ page language="java"  contentType="text/html; charset=UTF-8" import="jcifs.smb.*" import="java.nio.charset.Charset" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" import="javax.mail.*" import="java.util.*" import="java.math.*" import="java.sql.*" import="javax.mail.internet.*" import="javax.activation.*" import="java.net.*" import="java.text.*" import="org.zefer.pd4ml.PD4ML" import="org.zefer.pd4ml.PD4Constants" import="java.awt.Insets" errorPage="error.jsp" %>

<%@ include file="../../../db_con.jsp"%>
<%      

        String queryAdder="";        
        for(int i=-5; i<=0; i++){
            Calendar cal=Calendar.getInstance();
            cal.add(Calendar.DATE,i);
            java.util.Date day1=cal.getTime();
            queryAdder=queryAdder+" or (b.section_transfer like '%="+(day1.getMonth()+1)+"/"+day1.getDate()+"/"+(day1.getYear()-100)+"@%') ";
        }
        queryAdder= queryAdder.substring(3);
	String sectionQuery="select * from cs_quote_sections where order_no in (";
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

			emailBody=emailBody+count+"     ";
			emailBody=emailBody+"Quote#:"+order_no.elementAt(y).toString()+"     ";
			emailBody=emailBody+"BpcsOrderNumber:"+bpcs_order_no.elementAt(y).toString()+"     ";
			emailBody=emailBody+"ProjetName:"+project_name.elementAt(y).toString()+"     ";
			emailBody=emailBody+"SBU:"+product_id.elementAt(y).toString()+"     ";
			emailBody=emailBody+"RepNo:"+creator_id.elementAt(y).toString()+"     ";
			emailBody=emailBody+"UserId:"+user_id.elementAt(y).toString()+"     ";
			emailBody=emailBody+"AssignedRepNo:"+assigned_rep_no.elementAt(y).toString()+"     ";
			emailBody=emailBody+"ProjectType:"+project_type.elementAt(y).toString()+"     ";
			emailBody=emailBody+"sectionTransfer:"+section_transfer.elementAt(y).toString()+"     ";
			emailBody=emailBody+"\r\n";
			count++;
		}
	}
	sectionQuery=sectionQuery.replaceAll("''","','")+")";
	emailBody=emailBody+sectionQuery;
        

}
  catch(Exception e){
	out.println(e);
  }

try{
			String from = "erapiderror@c-sgroup.com" ;
			String to = "gsuisham@c-sgroup.com";
			//String host ="lebhq-notes.c-sgroup.com";
			String host ="LEBHQ-SMTP01.c-sgroup.com";
			String subject = "ERROR With Transfer ";
			String message = emailBody;
			Properties prop =System.getProperties();
			prop.put("mail.smtp.host",host);
			Session ses1  = Session.getDefaultInstance(prop,null);
			MimeMessage msg = new MimeMessage(ses1);
			msg.addFrom(new InternetAddress().parse(from));
			msg.addRecipients(Message.RecipientType.TO,new InternetAddress().parse(to));
			//msg.addRecipients(Message.RecipientType.CC,new InternetAddress().parse(cc));
			msg.setSubject(subject);
			BodyPart messageBodyPart = new MimeBodyPart();
			messageBodyPart.setText(message);
			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(messageBodyPart);
			msg.setContent(multipart);
			Transport.send(msg);

}
catch(Exception ee){
			String from = "erapiderror@c-sgroup.com" ;
			String to = "khicks@c-sgroup.com";
			//String host ="lebhq-notes.c-sgroup.com";
			String host ="LEBHQ-SMTP01.c-sgroup.com";
			String subject = "ERROR With Transfer ";
			String message = emailBody;
			Properties prop =System.getProperties();
			prop.put("mail.smtp.host",host);
			Session ses1  = Session.getDefaultInstance(prop,null);
			MimeMessage msg = new MimeMessage(ses1);
			msg.addFrom(new InternetAddress().parse(from));
			msg.addRecipients(Message.RecipientType.TO,new InternetAddress().parse(to));
			//msg.addRecipients(Message.RecipientType.CC,new InternetAddress().parse(cc));
			msg.setSubject(subject);
			BodyPart messageBodyPart = new MimeBodyPart();
			messageBodyPart.setText(message);
			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(messageBodyPart);
			msg.setContent(multipart);
			Transport.send(msg);
			//out.println(e);
			//return;
}

%>
