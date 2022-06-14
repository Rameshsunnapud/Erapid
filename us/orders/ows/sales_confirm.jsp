<html>
<head>

	<link rel='stylesheet' href='../../../style1.css' type='text/css'/>
</head>

<%@ page language="java" import="javax.mail.*" import="java.util.*" import="java.math.*" import="java.sql.*" import="javax.mail.internet.*" import="javax.activation.*" import="java.net.*" import="java.text.*" errorPage="error.jsp" %>
<%@ include file="../../../db_con.jsp"%>
<%

String order_no = request.getParameter("order_no");
String rep_no = request.getParameter("rep_no");
String product_id="";

ResultSet rs0=stmt.executeQuery("select product_id from cs_project where order_no='"+order_no+"'");
if(rs0 != null){
	while(rs0.next()){
		product_id=rs0.getString(1);
	}
}
rs0.close();

String to="";
//out.println("select email from cs_sbu_contacts where rep_no='"+rep_no+"' and product_id='"+product_id+"'");

ResultSet rs1=stmt.executeQuery("select sales_person from cs_sbu_contacts where rep_no='"+rep_no+"' and product_id='"+product_id+"'");
if(rs1 != null){
	while(rs1.next()){
		to=rs1.getString("sales_person");
	}
}
rs1.close();


String from="";
ResultSet rs1x=stmt.executeQuery("select email from cs_reps where rep_no='"+rep_no+"'");
if(rs1x != null){
	while(rs1x.next()){
		from=rs1x.getString("email");
	}
}
rs1x.close();
if(from==null || from.equals("null")){
	from="bpcs_transfer@c-sgroup.com";
}
to="gsuisham@c-sgroup.com";
try{

	String host ="LEBHQ-SMTP01.c-sgroup.com";
	String subject = "Order Transferred "+order_no;
	String message = "New order has been Transferred under quote #"+order_no+" and it must be reviewed by sales prior to order entry.\r\n";

	String message_footer="\r\n";








	Properties prop =System.getProperties();
	prop.put("mail.smtp.host",host);
	Session ses1  = Session.getDefaultInstance(prop,null);
	MimeMessage msg = new MimeMessage(ses1);
	msg.addFrom(new InternetAddress().parse(from));
	msg.setReplyTo(new InternetAddress().parse(from));
	msg.addRecipients(Message.RecipientType.TO,new InternetAddress().parse(to));

	msg.setSubject(order_no+" Drafting form");
	BodyPart messageBodyPart = new MimeBodyPart();
	// Fill the message
	messageBodyPart.setText(message);
	Multipart multipart = new MimeMultipart();
	multipart.addBodyPart(messageBodyPart);
	// Part two is attachment
	/*
	messageBodyPart = new MimeBodyPart();

	DataSource source = new URLDataSource(new URL(url));
	messageBodyPart.setDataHandler(new DataHandler(source));
	messageBodyPart.setFileName(attachName);
	multipart.addBodyPart(messageBodyPart);
	*/
	msg.setContent(multipart);
	messageBodyPart = new MimeBodyPart();
	messageBodyPart.setText(message_footer);
  	multipart.addBodyPart(messageBodyPart);
	Transport.send(msg);



















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
stmt.close();
myConn.close();
%>
</body>
</html>