<META http-equiv=Content-Type content="text/html; charset=utf-8">

<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<%@ page language="java"  contentType="text/html; charset=UTF-8" import="jcifs.smb.*" import="java.nio.charset.Charset" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" import="javax.mail.*" import="java.util.*" import="java.math.*" import="java.sql.*" import="javax.mail.internet.*" import="javax.activation.*" import="java.net.*" import="java.text.*" import="org.zefer.pd4ml.PD4ML" import="org.zefer.pd4ml.PD4Constants" import="java.awt.Insets" errorPage="error.jsp" %>
<%@ include file="../../../db_con.jsp"%>
<%@ include file="../../../dbcon1.jsp"%>
<%
out.println("<font size='2' color='red'>Please do not close this window.  It will close itself when it is finished.</font><BR>");
String order_no=request.getParameter("order_no");
String url1="https://"+application.getInitParameter("HOST")+"/erapid/us/orders/ows/ads_order_report.jsp?order_no="+order_no;
String url2="https://"+application.getInitParameter("HOST")+"/erapid/us/reports/work_copy_home_ads.jsp?q_no="+order_no;
String counter="";
String counterInit="";
String file_details="";
String product_id="";
String creator_id="";
String group_id="";
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
//out.println(counter+"::<BR>");
if(counter == null || counter.equals("null") || counter.trim().length()<1){
	counter="00";
}
else if(counter.trim().length()<2){
	counter="0"+counter;
}
//out.println("select numFiles,file_details from cs_ims_counter where order_no='"+order_no.trim()+"'<BR>"+counter+"::<BR>");
counterInit=counter;


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
boolean isCreditCard=false;
ResultSet rs3=stmt.executeQuery("select count(*) from cs_payment_details where order_no='"+order_no.trim()+"'");
if(rs3 != null){
	while(rs3.next()){
		if(rs3.getInt(1)>0){
			isCreditCard=true;
		}
	}
}
rs3.close();
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
	product_id="GRA";
}
else if(product_id.equals("GRILLE")){
	product_id="GRL";
}
else if(product_id.equals("EJC")){
	product_id="TPG";
}

String saveFile ="";
String transfered="";
String fileName="";
java.util.Date date=new java.util.Date();
for(int y=0; y<3; y++){
	try{
		if(url1 != null && url1.trim().length()>0){

			counter=""+(Integer.parseInt(counter)+1);
			if(counter == null || counter.equals("null") || counter.trim().length()<1){
				counter="00";
			}
			else if(counter.trim().length()<2){
				counter="0"+counter;
			}
			saveFile = counter+product_id+order_no.trim()+".pdf";
			String filepath="mun-imsx01/dropbox/erapid/owssales/"+saveFile;
			if( application.getInitParameter("HOST").toUpperCase().indexOf("DEV")>0){
				filepath="lebhq-imsxdev/dropbox/erapid/owssales/"+saveFile;
			}
			if(group_id.startsWith("Can")){
				filepath=filepath.replaceAll("dropbox/erapid","dropbox/canada");
			}
			////out.println(filepath);

			SmbFile s = new SmbFile("smb://c-sgroup;erapidprod:cseprod3@"+filepath);
			SmbFileOutputStream fos = new SmbFileOutputStream(s);
			java.net.URL targetURL = new java.net.URL (url1) ;
			PD4ML html = new PD4ML();
			html.protectPhysicalUnitDimensions();
			html.setPageSize(PD4Constants.LETTER);
			html.render(targetURL, fos);

			transfered=transfered+"work copy worked...";

			//file_details=file_details+"<tr><td>WORK COPY</td><td>"+saveFile+"</td><td>WORK COPY</td><td>NA</td><td>Clean</td><td>"+date+"</td></tr>";
			//out.println("1"+file_details+"<BR>");

		}

		if(url2 != null && url2.trim().length()>0){

			counter=""+(Integer.parseInt(counter)+1);
			if(counter == null || counter.equals("null") || counter.trim().length()<1){
				counter="00";
			}
			else if(counter.trim().length()<2){
				counter="0"+counter;
			}
			saveFile = counter+product_id+order_no.trim()+".pdf";
			String filepath="mun-imsx01/dropbox/erapid/workcopy/"+saveFile;
			if( application.getInitParameter("HOST").toUpperCase().indexOf("DEV")>0){
				filepath="lebhq-imsxdev/dropbox/erapid/workcopy/"+saveFile;
			}
			if(group_id.startsWith("Can")){
				filepath=filepath.replaceAll("dropbox/erapid","dropbox/canada");
			}
			SmbFile s = new SmbFile("smb://c-sgroup;erapidprod:cseprod3@"+filepath);
			SmbFileOutputStream fos = new SmbFileOutputStream(s);
			java.net.URL targetURL = new java.net.URL (url2) ;
			PD4ML html = new PD4ML();
			html.protectPhysicalUnitDimensions();
			html.setPageSize(PD4Constants.LETTER);
			html.render(targetURL, fos);

			transfered=transfered+"ows...";
			//file_details=file_details+"<tr><td>REP WORK COPY</td><td>"+saveFile+"</td><td>REP WORK COPY</td><td>NA</td><td>Clean</td><td>"+date+"</td></tr>";
			//out.println("2"+file_details+"<BR>");
		}

		//out.println(transfered);
		if(Integer.parseInt(counterInit)>0||isInImsCounter){
			java.sql.PreparedStatement ps=myConn.prepareStatement("UPDATE cs_ims_counter SET numFiles =?,file_details=? WHERE Order_no =? ");
			ps.setString(1,counter.trim());
			ps.setString(2,file_details);
			ps.setString(3,order_no.trim());
			int re=ps.executeUpdate();
			ps.close();
		}
		else{
			String insert ="INSERT INTO cs_ims_counter(order_no,file_details,numFiles) VALUES(?,?,?) ";
			PreparedStatement insert_ims = myConn.prepareStatement(insert);
			insert_ims.setString(1,order_no.trim());
			insert_ims.setString(2,file_details);
			insert_ims.setString(3,counter.trim());
			int rocount = insert_ims.executeUpdate();
			insert_ims.close();
		}
		y=3;
%>
<body onload='javascript:window.close()'>
	<%
}
catch(Exception e){
	out.println(" IF YOU SEE THIS MESSAGE, YOUR FILES DID NOT TRANSFER::"+e);
	if(y>=2){
		//out.println(" IF YOU SEE THIS MESSAGE, YOUR FILES DID NOT TRANSFER::"+e);
		String from = "erapiderror@c-sgroup.com" ;
		String to = "roanesa@c-sgroup.com";
		String cc = "gsuisham@c-sgroup.com";
		String host ="lebhq-notes.c-sgroup.com";
		String subject = "TRANSFER TO IMS ERROR.  QUOTE NUMBER :"+product_id+order_no+" By Rep Number :"+creator_id +" :::  3 ATTEMPTS FAILED";
		String message = "TRANSFER TO IMS ERROR.  QUOTE NUMBER :"+product_id+order_no+" By Rep Number :"+creator_id+"\n\n\n"+e+"\n\n\n"+transfered+"\n\n\n* not all 3 files available to all quotes (psa vs rep, and product line specific)";
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
		out.println(e);
	}
	return;
}
try{
	String ordersheet="";
	ResultSet rsordersheet=stmt.executeQuery("select order_sheet_sent from cs_ims_counter where order_no='"+order_no+"'");
	if(rsordersheet != null){
		while(rsordersheet.next()){
			ordersheet=rsordersheet.getString(1);
		}
	}
	rsordersheet.close();
	//out.println(ordersheet);
	if(ordersheet==null || !ordersheet.equals("yes")){
		//out.println("send");
		String from = "adsneworders@c-sgroup.com" ;
		String to = "adsneworders@c-sgroup.com";
		String host ="lebhq-notes.c-sgroup.com";
		String subject = "TRANSFER COMPLETE.  QUOTE NUMBER :"+order_no+"";
		String message = "TRANSFER COMPLETE.  QUOTE NUMBER :"+order_no+"";
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


		java.sql.PreparedStatement ps=myConn.prepareStatement("UPDATE cs_ims_counter SET order_sheet_sent =? WHERE Order_no =? ");
		ps.setString(1,"yes");
		ps.setString(2,order_no.trim());
		int re=ps.executeUpdate();
		ps.close();
	}
	//else{
		//out.println("dont send");
	//}



}
catch(Exception e){
	out.println(e);

}

}
stmt.close();
stmts.close();
myConn.close();
myConns.close();

	%>
	<%
}
catch(Exception e){
out.println(e);
}
	%>