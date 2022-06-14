<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<META http-equiv=Content-Type content="text/html; charset=utf-8">


<%@ page language="java"  contentType="text/html; charset=UTF-8" import="jcifs.smb.*" import="java.nio.charset.Charset" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" import="javax.mail.*" import="java.util.*" import="java.math.*" import="java.sql.*" import="javax.mail.internet.*" import="javax.activation.*" import="java.net.*" import="java.text.*" import="org.zefer.pd4ml.PD4ML" import="org.zefer.pd4ml.PD4Constants" import="java.awt.Insets" errorPage="error.jsp" %>
<%@ include file="../../../db_con.jsp"%>
<%@ include file="../../../dbcon1.jsp"%>
<%
org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
org.slf4j.Logger imsLogger = org.slf4j.LoggerFactory.getLogger("imsLogger");  
out.println("<font size='2' color='red'>Please do not close this window.  It will close itself when it is finished.</font><BR>");
String order_no=request.getParameter("order_no"); 
String url1=request.getParameter("url1");
String url2=request.getParameter("url2");
String url3=request.getParameter("url3");
String url4="https://"+ application.getInitParameter("HOST")+"/erapid/us/orders/ows/credit_card_form.jsp?order_no="+order_no;

//out.println(url1+"<BR>"+url2+"<br>"+url3+"<BR><BR>"+order_no+"<BR>");
url1=url1.replaceAll(" ","%");
url2=url2.replaceAll(" ","%");
url3=url3.replaceAll(" ","%");
//out.println(url1+"::1<BR>"+url2+"::2<br>"+url3+"::3<BR><BR>"+order_no+"<BR>");
/*
if(url1.indexOf("lebhq")<0){
	url1="http://"+ application.getInitParameter("HOST")+"/erapid/us/"+url1;
}
if(url2.indexOf("lebhq")<0){
	url2="http://"+ application.getInitParameter("HOST")+"/erapid/us/"+url2;
}
if(url3.indexOf("lebhq")<0){
	url3="http://"+ application.getInitParameter("HOST")+"/erapid/us/"+url3;
}

logger.debug(url1);
logger.debug(url2);
logger.debug(url3);
logger.debug(url4);
*/
out.println("Line 45");
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
if(counter == null || counter.equals("null") || counter.trim().length()<1){
	counter="00";
}
else if(counter.trim().length()<2){
	counter="0"+counter;
}
counterInit=counter;
boolean sendpdf=true;
ResultSet rs2=stmt.executeQuery("select product_id,creator_id,quote_origin from cs_project where order_no='"+order_no.trim()+"'");
if(rs2 != null){
	while(rs2.next()){
		product_id=rs2.getString(1);
		creator_id=rs2.getString(2);
if(rs2.getString("quote_origin")!=null){
		if(rs2.getString("product_id").equals("ADS")&& rs2.getString("quote_origin")!=null && (rs2.getString("quote_origin").equals("As Build")||rs2.getString("quote_origin").equals("change")||rs2.getString("quote_origin").equals("release")||rs2.getString("quote_origin").equals("revision")||rs2.getString("quote_origin").equals("submittal"))||rs2.getString("quote_origin").equals("sample")){
			sendpdf=false;
		}
}
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
if(product_id.equals("ADS")){
	url1="";
	url2="";
}
out.println("Line 125");
String saveFile ="";
String transfered="";
String fileName="";
java.util.Date date=new java.util.Date();
if(sendpdf){
	for(int y=0; y<3; y++){
		try{
			if(url1 != null && url1.trim().length()>0){
if(url1.indexOf("lebhq")<0){
	url1="https://"+ application.getInitParameter("HOST")+"/erapid/us/"+url1;
}

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
				//out.println(filepath);
				if(group_id.startsWith("Can")){
					filepath=filepath.replaceAll("dropbox/erapid","dropbox/canada");
				}
				SmbFile s1 = new SmbFile("smb://c-sgroup;erapidprod:cseprod3@");
				SmbFile s = new SmbFile(s1,filepath,SmbFile.FILE_NO_SHARE);

				//SmbFile s1 = new SmbFile("smb://c-sgroup;erapidprod:cseprod3@"+filepath);



				SmbFileOutputStream fos = new SmbFileOutputStream(s);
				java.net.URL targetURL = new java.net.URL (url1) ;

/*

				PD4ML html = new PD4ML();
				html.protectPhysicalUnitDimensions();
				html.setPageSize(PD4Constants.LETTER);
*/


			PD4ML html = new PD4ML();


			html.outputFormat(PD4Constants.PDF);
			html.setHtmlWidth(1000);



				html.setPageSize(PD4Constants.LETTER);
				Insets inset = new Insets(5,4,1,6);
				html.setPageInsetsMM(inset);
				//html.setPageSizeMM(new Dimension(210,297));

html.render(targetURL, fos);




				transfered=transfered+"work copy worked...";

				file_details=file_details+"<tr><td>WORK COPY</td><td>"+saveFile+"</td><td>WORK COPY</td><td>NA</td><td>Clean</td><td>"+date+"</td></tr>";
				//out.println("1"+file_details+"<BR>");

			}

			if(url2 != null && url2.trim().length()>0){
				if(url2.indexOf("lebhq")<0){
					url2="https://"+ application.getInitParameter("HOST")+"/erapid/us/"+url2;
				}
				out.println("Line 195 "+url2);
				counter=""+(Integer.parseInt(counter)+1);
				if(counter == null || counter.equals("null") || counter.trim().length()<1){
					counter="00";
				}
				else if(counter.trim().length()<2){
					counter="0"+counter;
				}
				saveFile = counter+product_id+order_no.trim()+".pdf";
				String filepath="mun-imsx01/dropbox/erapid/repworkcopy/"+saveFile;
				if( application.getInitParameter("HOST").toUpperCase().indexOf("DEV")>0){
					filepath="lebhq-imsxdev/dropbox/erapid/repworkcopy/"+saveFile;
				}
				if(group_id.startsWith("Can")){
					filepath=filepath.replaceAll("dropbox/erapid","dropbox/canada");
				}
				//imsLogger.debug(url2+"::"+filepath+"::"+order_no);
				SmbFile s1 = new SmbFile("smb://c-sgroup;erapidprod:cseprod3@");
				SmbFile s = new SmbFile(s1,filepath,SmbFile.FILE_NO_SHARE);
				//SmbFile s = new SmbFile("smb://c-sgroup;erapidprod:cseprod3@"+filepath);
				SmbFileOutputStream fos = new SmbFileOutputStream(s);
				java.net.URL targetURL = new java.net.URL (url2) ;
				PD4ML html = new PD4ML();
				html.protectPhysicalUnitDimensions();
				html.setPageSize(PD4Constants.LETTER);
				html.render(targetURL, fos);

				transfered=transfered+"rep work copy worked...";
				file_details=file_details+"<tr><td>REP WORK COPY</td><td>"+saveFile+"</td><td>REP WORK COPY</td><td>NA</td><td>Clean</td><td>"+date+"</td></tr>";
				//out.println("2"+file_details+"<BR>");
			}
			if(url3 != null && url3.trim().length()>0){
				if(url3.indexOf("lebhq")<0){
					url3="https://"+ application.getInitParameter("HOST")+"/erapid/us/"+url3;
				}
				out.println("Line 228");
				String sectionname="all";
				if(url3.indexOf("sections=")>0){
					sectionname=url3.substring(url3.indexOf("sections=")+9);
					if(sectionname.indexOf("&")>0){
						sectionname=sectionname.substring(0,sectionname.indexOf("&"));
					}
					if(sectionname.endsWith(",")){
						sectionname=sectionname.substring(0,sectionname.length()-1);
					}
				}

				counter=""+(Integer.parseInt(counter)+1);
				if(counter == null || counter.equals("null") || counter.trim().length()<1){
					counter="00";
				}
				else if(counter.trim().length()<2){
					counter="0"+counter;
				}
				int numsec=0;
				ResultSet rsnumsec=stmt.executeQuery("select sections from cs_quote_sections where order_no='"+order_no+"'");
				if(rsnumsec != null){
					while(rsnumsec.next()){
						numsec=rsnumsec.getInt(1);
					}
				}
				rsnumsec.close();
				if(numsec>1){
					saveFile = counter+product_id+order_no.trim()+" section "+sectionname +".pdf";
				}
				else{
					saveFile = counter+product_id+order_no.trim()+".pdf";
				}
				String filepath="mun-imsx01/dropbox/erapid/ows/"+saveFile;
				if( application.getInitParameter("HOST").toUpperCase().indexOf("DEV")>0){
					filepath="lebhq-imsxdev/dropbox/erapid/ows/"+saveFile;
				}
				if(group_id.startsWith("Can")){
					filepath=filepath.replaceAll("dropbox/erapid","dropbox/canada");
				}
				SmbFile s1 = new SmbFile("smb://c-sgroup;erapidprod:cseprod3@");
				SmbFile s = new SmbFile(s1,filepath,SmbFile.FILE_NO_SHARE);
				//SmbFile s = new SmbFile("smb://c-sgroup;erapidprod:cseprod3@"+filepath);
				SmbFileOutputStream fos = new SmbFileOutputStream(s);
				java.net.URL targetURL = new java.net.URL (url3) ;
				PD4ML html = new PD4ML();
				html.protectPhysicalUnitDimensions();
				html.setPageSize(PD4Constants.LETTER);
				html.render(targetURL, fos);



				String filepathx="lebhq-imsx01/dropbox/erapid/owstest/"+saveFile;
//out.println("1");
				if( application.getInitParameter("HOST").toUpperCase().indexOf("DEV")>0){
					filepathx="lebhq-imsxdev/dropbox/erapid/owstest/"+saveFile;
				}
//out.println("2");
				SmbFile s1x = new SmbFile("smb://c-sgroup;erapidprod:cseprod3@");
//out.println("3");
				SmbFile sx = new SmbFile(s1x,filepathx,SmbFile.FILE_NO_SHARE);
//out.println("4");
				//SmbFile s = new SmbFile("smb://c-sgroup;erapidprod:cseprod3@"+filepath);
				SmbFileOutputStream fosx = new SmbFileOutputStream(sx);
//out.println("5");
				java.net.URL targetURLx = new java.net.URL (url3) ;
//out.println("6");
				PD4ML htmlx = new PD4ML();
//out.println("7");
				htmlx.protectPhysicalUnitDimensions();
//out.println("8");
				htmlx.setPageSize(PD4Constants.LETTER);
//out.println("9");
				htmlx.render(targetURLx, fosx);
//out.println("10");




				transfered=transfered+"ows worked...";
				file_details=file_details+"<tr><td>ORDER WRITE-UP</td><td>"+saveFile+"</td><td>ORDER WRITE-UP</td><td>NA</td><td>Clean</td><td>"+date+"</td></tr>";
				//out.println("3"+file_details+"<BR>");

			}
			if(url4 != null && url4.trim().length()>0 &&isCreditCard){
				out.println("Line 282");
				counter=""+(Integer.parseInt(counter)+1);
				if(counter == null || counter.equals("null") || counter.trim().length()<1){
					counter="00";
				}
				else if(counter.trim().length()<2){
					counter="0"+counter;
				}
				saveFile = counter+product_id+order_no.trim()+".pdf";
				String filepath="mun-imsx01/dropbox/erapid/ccf/"+saveFile;
				if( application.getInitParameter("HOST").toUpperCase().indexOf("DEV")>0){
					filepath="lebhq-imsxdev/dropbox/erapid/ccf/"+saveFile;
				}
				if(group_id.startsWith("Can")){
					filepath=filepath.replaceAll("dropbox/erapid","dropbox/canada");
				}
				SmbFile s1 = new SmbFile("smb://c-sgroup;erapidprod:cseprod3@");
				SmbFile s = new SmbFile(s1,filepath,SmbFile.FILE_NO_SHARE);
					//SmbFile s = new SmbFile("smb://c-sgroup;erapidprod:cseprod3@"+filepath);
				SmbFileOutputStream fos = new SmbFileOutputStream(s);
				java.net.URL targetURL = new java.net.URL (url4) ;
				PD4ML html = new PD4ML();
				html.protectPhysicalUnitDimensions();
				html.setPageSize(PD4Constants.LETTER);
				html.render(targetURL, fos);
				transfered=transfered+"rep work copy worked...";
				file_details=file_details+"<tr><td>Credit Card Form</td><td>"+saveFile+"</td><td>Credit Card Form</td><td>NA</td><td>Clean</td><td>"+date+"</td></tr>";
			}
			out.println(transfered);
			ResultSet rs1x=stmt.executeQuery("select numFiles,file_details from cs_ims_counter where order_no='"+order_no.trim()+"'");
			if(rs1x != null){
				while(rs1x.next()){
					isInImsCounter=true;
				}
			}
			rs1x.close();
			//file_details=file_details+"<tr><td>ORDER WRITE-UP</td><td>"+saveFile+"</td><td>ORDER WRITE-UP</td><td>NA</td><td>Clean</td><td>"+date+"</td></tr>";
			if(Integer.parseInt(counterInit)>0||isInImsCounter){
				out.println("Line 318");
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
<body> onload='javascript:window.close()'>
	<%
}
catch(Exception e){

	out.println("                         ENTER CATCH ----------------- > ");
	out.println(e);
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
}
}
else{
	%>
<body onload='javascript:window.close()'>
	<%
}
stmt.close();
stmts.close();
myConn.close();
myConns.close();
}
catch(Exception e){
out.println(e);
}
	%>