<META http-equiv=Content-Type content="text/html; charset=utf-8">


<%@ page language="java"  contentType="text/html; charset=UTF-8" import="jcifs.smb.*" import="java.nio.charset.Charset" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" import="javax.mail.*" import="java.util.*" import="java.math.*" import="java.sql.*" import="javax.mail.internet.*" import="javax.activation.*" import="java.net.*" import="java.text.*" import="org.zefer.pd4ml.PD4ML" import="org.zefer.pd4ml.PD4Constants" import="java.awt.Insets" errorPage="error.jsp" %>
<%@ include file="../../../db_con.jsp"%>
<%@ include file="../../../dbcon1.jsp"%>
<%
	out.println("<font size='2' color='red'>Please do not close this window.  It will close itself when it is finished.</font>");
	String url=request.getParameter("url");
	String order_no=request.getParameter("order_no");
	out.println(url+"<BR><BR>"+order_no);
	url=url.replaceAll(" ","%");
	if(order_no == null || order_no.trim().length()<9){
			order_no=url.substring(url.indexOf("order_no=")+9,url.length());
			//out.println(order_no+"HERE");
			order_no=order_no.substring(0,order_no.indexOf("&"));
			//out.println(order_no+"HERE");
	}
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
	String saveFile = counter+product_id+order_no.trim()+".pdf";
	String fileName="";



	String filepath="mun-imsx01/dropbox/erapid/ows/"+saveFile;
	if( application.getInitParameter("HOST").toUpperCase().indexOf("DEV")>0){
		filepath="lebhq-imsxdev/dropbox/erapid/ows/"+saveFile;
	}
	if(group_id.startsWith("Can")){
		filepath=filepath.replaceAll("dropbox/erapid","dropbox/canada");
	}	

      	try{
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
		String subject = "OWS TRANSFER TO IMS ERROR.  QUOTE NUMBER :"+product_id+order_no;
		String message = "OWS TRANSFER TO IMS ERROR.  QUOTE NUMBER :"+product_id+order_no+"\n\n\n"+e;
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
      	file_details=file_details+"<tr><td>ORDER WRITE-UP</td><td>"+saveFile+"</td><td>ORDER WRITE-UP</td><td>NA</td><td>Clean</td><td>"+date+"</td></tr>";
      if(Integer.parseInt(counter)>0||isInImsCounter){
		counter=(""+(Integer.parseInt(counter)+1)).trim();
		try{
			java.sql.PreparedStatement ps=myConn.prepareStatement("UPDATE cs_ims_counter SET numFiles =?,file_details=? WHERE Order_no =? ");
			ps.setString(1,counter.trim());
			ps.setString(2,file_details);
			ps.setString(3,order_no.trim());
			int re=ps.executeUpdate();
			ps.close();
		}
		catch (java.sql.SQLException e)	{
			out.println("Problem with updating cs_ims_counter table"+"<br>");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}
	}
	else{
		counter=(""+(Integer.parseInt(counter)+1)).trim();
			try{
				String insert ="INSERT INTO cs_ims_counter(order_no,file_details,numFiles) VALUES(?,?,?) ";
				PreparedStatement insert_ims = myConn.prepareStatement(insert);
				insert_ims.setString(1,order_no.trim());
				insert_ims.setString(2,file_details);
				insert_ims.setString(3,counter.trim());
				int rocount = insert_ims.executeUpdate();
				insert_ims.close();
			}
			catch (java.sql.SQLException e){
				out.println("Problem with ENTERING TO cs_ims_counter"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}

	}

stmt.close();
stmts.close();
myConn.close();
myConns.close();
%>


<body onload='javascript:window.close()'>