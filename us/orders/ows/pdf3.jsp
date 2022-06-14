<META http-equiv=Content-Type content="text/html; charset=utf-8">


<%@ page language="java"  contentType="text/html; charset=UTF-8" import="jcifs.smb.*" import="java.nio.charset.Charset" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" import="javax.mail.*" import="java.util.*" import="java.math.*" import="java.sql.*" import="javax.mail.internet.*" import="javax.activation.*" import="java.net.*" import="java.text.*" import="org.zefer.pd4ml.PD4ML" import="org.zefer.pd4ml.PD4Constants" import="java.awt.Insets" errorPage="error.jsp" %>
<%@ include file="../../../db_con.jsp"%>
<%@ include file="../../../dbcon1.jsp"%>
<%
	out.println("<font size='2' color='red'>Please do not close this window.  It will close itself when it is finished.</font>");
	String url=request.getParameter("url");
	String order_no=request.getParameter("order_no");
	out.println(url+"<BR><BR>"+order_no+"<BR>");

	url=url.replaceAll(" ","%");
	out.println(url+"<BR><BR>"+order_no);
	String counter="";
	String file_details="";
	String product_id="";
	String group_id="";
	String creator_id="";
	boolean isInImsCounter=false;
	ResultSet rs1=stmt.executeQuery("select numFiles,file_details from cs_ims_counter where order_no='"+order_no.trim()+"'");
	if(rs1 != null){
		while(rs1.next()){
			counter=rs1.getString(1);
			file_details=rs1.getString(2);
			isInImsCounter=true;
		}
	}
	rs1.close();
	ResultSet rs2=stmt.executeQuery("select product_id,creator_id from cs_project where order_no='"+order_no.trim()+"'");
	if(rs2 != null){
		while(rs2.next()){
			product_id=rs2.getString(1);
			creator_id=rs2.getString(2);
		}
	}
	rs2.close();
ResultSet rsSys=stmt.executeQuery("select group_id from cs_reps where rep_no='"+creator_id+"'");
if(rsSys != null){
	while(rsSys.next()){
		group_id=rsSys.getString("group_id");	
	}
}
rsSys.close();
if(group_id==null){
	group_id="";
}
	if(counter == null || counter.equals("null") || counter.trim().length()<1){
		counter="00";
	}
	else if(counter.trim().length()<2){
		counter="0"+counter;
	}
	if(product_id.equals("GCP")){
		product_id="GCU";
	}
	else if(product_id.equals("GE")){
		product_id.equals("GRA");
	}
	else if(product_id.equals("GRILLE")){
		product_id.equals("GRL");
	}
	else if(product_id.equals("EJC")){
		product_id="TPG";
	}
	String saveFile = product_id+order_no.trim()+counter+".pdf";
	String fileName="";
	try{

		String filepath="mun-imsx01/dropbox/erapid/workcopy/"+saveFile;
		if( application.getInitParameter("HOST").toUpperCase().indexOf("DEV")>0){
				filepath="lebhq-imsxdev/dropbox/erapid/workcopy/"+saveFile;
		}
		if(group_id.startsWith("Can")){
			filepath=filepath.replaceAll("dropbox/erapid","dropbox/canada");
		}
		SmbFile s = new SmbFile("smb://c-sgroup;erapidprod:cseprod3@"+filepath);
		SmbFileOutputStream fos = new SmbFileOutputStream(s);

		java.net.URL targetURL = new java.net.URL (url) ;
		PD4ML html = new PD4ML();
		html.protectPhysicalUnitDimensions();
		html.setPageSize(PD4Constants.LETTER);
		html.render(targetURL, fos);
	}
	catch(Exception e){
		out.println(e);
		String from = "erapiderror@c-sgroup.com" ;
		String to = "roanesa@c-sgroup.com";
		String cc = "gsuisham@c-sgroup.com";
		String host ="lebhq-notes.c-sgroup.com";
		String subject = "WORK COPY TRANSFER TO IMS ERROR.  QUOTE NUMBER :"+product_id+order_no;
		String message = "WORK COPY TRANSFER TO IMS ERROR.  QUOTE NUMBER :"+product_id+order_no+"\n\n\n"+e;
		Properties prop =System.getProperties();
		prop.put("mail.smtp.host",host);
		Session ses1  = Session.getDefaultInstance(prop,null);
		MimeMessage msg = new MimeMessage(ses1);
		msg.addFrom(new InternetAddress().parse(from));
		msg.addRecipients(Message.RecipientType.TO,new InternetAddress().parse(to));
		msg.addRecipients(Message.RecipientType.CC,new InternetAddress().parse(cc));
		msg.setSubject(subject);
		BodyPart messageBodyPart = new MimeBodyPart();
		messageBodyPart.setText(message);
		Multipart multipart = new MimeMultipart();
		multipart.addBodyPart(messageBodyPart);
		msg.setContent(multipart);
		Transport.send(msg);
		return;
	}
      	java.util.Date date=new java.util.Date();

stmt.close();
stmts.close();
myConn.close();
myConns.close();
%>


<body onload='javascript:window.close()'>