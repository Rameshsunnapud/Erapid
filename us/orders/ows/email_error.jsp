<%@ page language="java" import="javax.mail.*" import="java.util.*" import="java.math.*" import="java.sql.*" import="javax.mail.internet.*" import="javax.activation.*" import="java.net.*" import="java.text.*" errorPage="error.jsp" %>
<%@ include file="../../../db_con.jsp"%>
<%
try{
				
	String from = "erapiderror@c-sgroup.com" ;
	String to = "gsuisham@c-sgroup.com";
	String host ="lebhq-notes.c-sgroup.com";
	String subject = "TRANSFER TO IMS ERROR.  QUOTE NUMBER :";
	String message = "TRANSFER TO IMS ERROR.  QUOTE NUMBER :";
	Properties prop =System.getProperties();
	prop.put("mail.smtp.host",host);
	Session ses1  = Session.getDefaultInstance(prop,null);
	MimeMessage msg = new MimeMessage(ses1);
	msg.addFrom(new InternetAddress().parse(from));
	msg.addRecipients(Message.RecipientType.TO,new InternetAddress().parse(to));
	msg.setSubject(subject);
	BodyPart messageBodyPart = new MimeBodyPart();
	messageBodyPart.setText(message);	
	Multipart multipart = new MimeMultipart();
	multipart.addBodyPart(messageBodyPart);	
	msg.setContent(multipart);
	Transport.send(msg);
	out.println(" An Email has been successfully delivered<br> to following recipients:<br> "+to+"<br>");	
}
catch(javax.mail.internet.AddressException ae){
	out.println(ae);
	ae.printStackTrace();
}
catch(javax.mail.MessagingException me){
	out.println(me);
	me.printStackTrace();
}
catch(Exception e){
	out.println(e);
	e.printStackTrace();
}
%>