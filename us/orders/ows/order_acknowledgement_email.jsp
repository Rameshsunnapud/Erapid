<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" import="javax.mail.*" import="java.util.*" import="java.math.*"  import="java.sql.*" import="javax.mail.internet.*" import="javax.activation.*" import="java.net.*" import="java.text.*" import="javax.mail.Authenticator.*" errorPage="error.jsp" %>
<%

try{
%>

<html>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Insert title here</title>
	</head>
	<body>
		<%
		org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
		log.debug("Order Acknowledgement mail is getting processed with session userId ... "+userId);
		try{
		String productId=""; String projectName = ""; String creatorId = "";  String userID = ""; String groupId = "";
		String customerPoNo=""; String phoneDetails=""; String csRepEmail=""; String billEmail=""; String csRepresentative="";
		boolean repUser = false;
		stmt = myConn.createStatement();
		ResultSet csProjectRS=stmt.executeQuery("select product_id, project_name, creator_id, user_id from cs_project where order_no='"+order_no+"'");
		if(csProjectRS != null){
			while(csProjectRS.next()){
				productId=csProjectRS.getString("product_id");
				projectName=csProjectRS.getString("project_name");
				creatorId=csProjectRS.getString("creator_id");
				userID=csProjectRS.getString("user_id");
			}
		}
		csProjectRS.close();
		
		ResultSet csRepsRS=stmt.executeQuery("select group_id, rep_name, telephone, email from cs_reps where user_id='"+userId+"'");
		if(csRepsRS != null){
			while(csRepsRS.next()){
				groupId = csRepsRS.getString("group_id");
				csRepresentative=csRepsRS.getString("rep_name");
				  phoneDetails= csRepsRS.getString("telephone");
				   csRepEmail=csRepsRS.getString("email");
			}
		}
		csRepsRS.close();
		
		if(groupId.toUpperCase().indexOf("REP")>=0){
			repUser=true;
		}
		log.debug("Logged-in-User is Rep-User ? : "+repUser);
		
		if(repUser){
			
		ResultSet csBillCustRS = stmt.executeQuery("SELECT customer_po_no, email FROM cs_billed_customers where order_no like '"+order_no+"'");
		if (csBillCustRS !=null) {
			   while (csBillCustRS.next()) {
				   customerPoNo= csBillCustRS.getString("customer_po_no");
				   billEmail=csBillCustRS.getString("email");
				 
			   }
		}
		csBillCustRS.close();
		
		log.debug("Dynamic values for the mail are : ");
		log.debug("Project Name is : "+projectName);
		log.debug("Order Number is : "+order_no);
		log.debug("Customer PO Number is : "+customerPoNo);
		log.debug("CS Representative is : "+csRepresentative);
		log.debug("Phone is : "+phoneDetails);
		log.debug("Email is (Also as CC email): "+csRepEmail);
		String toAddress=billEmail;
		String ccAddress = csRepEmail;
		String fromAddress="OrderReceived@c-sgroup.com";
	
		//Setting mail properties here - OUTLOOK HOST
		/*Properties mailProperties = new Properties();
		mailProperties.setProperty("mail.transport.protocol", "smtp");
		mailProperties.setProperty("mail.host", "LEBHQ-SMTP01.c-sgroup.com");
		mailProperties.put("mail.smtp.starttls.enable", "true");
		mailProperties.put("mail.smtp.auth", "true");
	    javax.mail.Session mailSession = javax.mail.Session.getInstance(mailProperties, 
	                        new javax.mail.Authenticator(){
	                           protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
	                              return new javax.mail.PasswordAuthentication("vsingh@c-sgroup.com", "");
	                           }});*/
	     
	   	 String smtpHostServer = "LEBHQ-SMTP01.c-sgroup.com";
   		 Properties props = System.getProperties();
   		 props.put("mail.smtp.host", smtpHostServer);
   		 javax.mail.Session mailSession = javax.mail.Session.getInstance(props, null);
   		 System.out.println("Mail session created..." + mailSession);
   		 
	  	 MimeMessage msg = new MimeMessage(mailSession);
	 
		 //Subject  
		 String subjectLine = "We have received your order - "+projectName;
		 msg.setSubject(subjectLine);
		 
		 // -- Set the FROM, CC and TO fields:   
	     msg.setFrom(new InternetAddress(fromAddress));
		 msg.setRecipients(Message.RecipientType.CC, InternetAddress.parse(ccAddress, false));
	     msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toAddress,false));
	     
	   		String  messageString = "<!doctype html>"
	   		 		+ "<html lang='en' xmlns='http://www.w3.org/1999/xhtml' xmlns:v='urn:schemas-microsoft-com:vml' xmlns:o='urn:schemas-microsoft-com:office:office'>" 		
	   		 		+ "<head>"
	   		     		+ "<!--[if gte mso 9]><xml>"
	   		     		+ "<o:OfficeDocumentSettings>"
	   		     		+ "<o:AllowPNG/>"
	   		     		+ "<o:PixelsPerInch>96</o:PixelsPerInch>"
	   		     		+ "</o:OfficeDocumentSettings>"
	   		     		+ "</xml><![endif]-->"
	   		     		+ "<title>Construction Specialties</title>"
	   		     		+ "<style>"
	   		     		+ "/* CLIENT-SPECIFIC STYLES */"
	   		     		+ "img{-ms-interpolation-mode: bicubic;}"
	   		     		+ "/* Force IE to smoothly render resized images. */"
	   		     		+ "#outlook a{padding:0;}"
	   		     		+ "/* Force Outlook 2007 and up to provide a 'view in browser' message. */"
	   		     		+ "table{mso-table-lspace:0pt;mso-table-rspace:0pt;} "
	   		     		+ "/* Remove spacing between tables in Outlook 2007 and up. */"
	   		     		+ ".ReadMsgBody{width:100%;} "
	   		     		+ ".ExternalClass{width:100%;} "
	   		     		+ "/* Force Outlook.com to display emails at full width. */"
	   		     		+ "p, a, li, td, blockquote{mso-line-height-rule:exactly;} "
	   		     		+ "/* Force Outlook to render line heights as they're originally set. */"
	   		     		+ "a[href^='tel'], a[href^='sms']{color:inherit;cursor:default; text-decoration:none;} "
	   		     		+ "/* Force mobile devices to inherit declared link styles. */"
	   		     		+ "p, a, li, td, body, table, blockquote{-ms-text-size-adjust:100%;-webkit-text-size-adjust:100%;} "
	   		     		+ "/* Prevent Windows- and Webkit-based mobile platforms from changing declared text sizes. */"
	   		     		+ ".ExternalClass, .ExternalClass p, .ExternalClass td, .ExternalClass div, .ExternalClass span, .ExternalClass font{line-height:100%;}"
	   		     		+ "/* Force Outlook.com to display line heights normally. */"
	   		     		+ "span.address a{color:#333333;}"
	   		     		+ "a{color:#cd202c;}"
	   		     		+ "@media only screen and (max-width:600px){"
	   		     		+ "table[id='bodyTable']{"
	   		     		+ "width:100%;"
	   		     		+ "}"
	   		     		+ "td[class='stack']{"
	   		     		+ "width:90%;padding-right:5% !important;padding-left:5% !important;"
	   		     		+ "}"
	   		     		+ "img{"
	   		     		+ "max-width:100%;	height:auto;"
	   		     		+ "}"
	   		     		+ "</style>"
	   		     		+ "</head>"
	   		     		
	   		     		+ "<body bgcolor='#eff0f2' style='background:#eff0f2;'>"
	   		     		+ "<table width='100%' border='0' style='background:#eff0f2; mso-padding-alt: 0px 0px 0px 0px;'>"
	   		     		+ "<tr>"
	   		     		+ "<td>"
	   		     		+ "<table id='bodyTable' width='704'  border='0' align='center' style='background:#eff0f2; margin-left:auto;margin-right:auto; border-collapse:collapse; background-clip:padding-box; '>"
	   		     		+ "<!--Header-->"																						
	   		     		+ "<tr>"
		   		     	+ "<td bgcolor='#4A4B4C' style='text-align:right; font-size:12px; font-family:Arial, Helvetica, sans-serif;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:10px;border-top-width:4px;border-top-style:solid; border-top-color:#cd202c; border-left-style:solid; border-left-color:#4a4b4c; border-left-width:1px; border-right-style:solid; border-right-color:#4a4b4c; border-right-width:1px; height:10px; border-collapse:collapse; background-clip:padding-box;'>"
		   		     			+ "</td>"
	   		     		+ "</tr>"
	   		     		+ "<!--End Header-->"
	   		     		+ "<!--Body-->"
	   		     		+ "<tr>"
	   		     		+ "<td bgcolor='#ffffff' style='border-right-width:1px;border-right-style:solid;border-right-color:#4a4b4c;border-bottom-width:1px;border-bottom-style:solid;border-bottom-color:#4a4b4c;border-left-width:1px;border-left-style:solid;border-left-color:#4a4b4c; border-collapse:collapse; background-clip:padding-box;'>"
	   		     		+ "<table width='100%' border='0'  border:solid 1px #4A4B4C;>"
	   		     		+ "<!--Logo -->"
	   		     		+ "<tr>"
	   		     		+ "<td class='stack' style='padding-top:35px;padding-right:60px;padding-bottom:15px;padding-left:62px;'>"
	   		     		+ "<a href='http://www.c-sgroup.com/'><img src='http://csimages.c-sgroup.com/eRapid/Medium-CS-Flat.jpeg' width='235' height='34' border='0' style='display:block;' alt='Construction Specialties'/></a>"
	   		     		+ "</td>"
	   		     		+ "</tr>"
	   		     		+ "<!--End Logo-->"
	   		     		+ "<!--Content-->"
	   		     		+ "<tr>"
	   		     		+ "<td class='stack' style='font-family:Arial, Helvetica, sans-serif;font-size:10pt;line-height:13pt;padding-top:41px;padding-right:25px;padding-bottom:36px;padding-left:27px;'> <!-- increased font size from 7pt initially to now 10 pt -->"
	   		     		+ "<div id='body_content'>"
	   		     		+ "<h2 style='text-align:center;font-size:11pt; font-weight:bold;margin-top:0px;margin-bottom:53px;'> Thank you for your order! </h2>"
	   		     		+ "<p style='margin-top:0px;margin-bottom:20px;'> This message is to notify you that your order has been received and is being reviewed. We anticipate completing our review and sending you a formal order acknowledgement within 48 hours, and this review will not impact your order's lead time. "
	   		     		+ "Your order details are listed below."
	   		     		+ "<br> <HR WIDTH='90%' size='1px' color='#999594' ALIGN='LEFT'>"
	   		       		+ "</p>"
	   		       		+ "<p style='margin-top:20px;margin-bottom:42px;'>"
	   		       		+ "<span style='font-weight:bold;'>Project Name:</span> "
	   		       				+ ""+projectName+""
	   		       		+ "<BR>"
	   		       		+ "<span style='font-weight:bold;'> Quote No.: </span> "
	   		       				+ ""+order_no+""
	   		       		+ "<BR>"
	   		       		+ "<span style='font-weight:bold;'> Customer PO No.: </span> "
	   		       				+ ""+customerPoNo+""
	   		       		+ "</P>"
	   		       		+ "<!--<HR WIDTH='90%' size='1px' color='#999594' ALIGN='LEFT'> -->"
	   		       		+ "<p style='margin-top:42px;margin-bottom:20px;'>"
	   		       		+ "Please note that this is a no-reply email address and your reply will not be monitored."
	   		       		+ "<br>"
	   		       		+ "If you need assistance, please contact:"
	   		       		+ "</P>"
	   		       		+ "<HR WIDTH='90%' size='1px' color='#999594' ALIGN='LEFT'>"
	   		       		+ "<p style=' margin-top:20px;margin-bottom:20px;'>"
	   		       		+ "<span style='font-weight:bold;'> CS Representative: </span> "
	   		       				+ ""+csRepresentative+""
	   		       		+ "<br>"
	   		       		+ "<span style='font-weight:bold;'> Phone: </span>"
	   		       				+ ""+phoneDetails+""
	   		       		+ "<br>"
	   		       		+ "<span style='font-weight:bold;'> Email: </span>"
	   		       				+ ""+csRepEmail+""
	   		       		+ "</p>"
	   		       		+ "</div>"
	   		       		+ "</td>"
	   		       		+ "</tr>"
	   		     		+ "<!--End Content-->"
	   		     		+ "</table>"
	   		     		+ "</td>"
	   		     		+ "</tr>"
	   		     		+ "<!--End Body-->"
	   		     		+ "<!--Footer-->"
	   		     		+ "<!--Social-->"
	   		     		+ "<tr>"
	   		     		+ "<td style='padding-top:43px;padding-bottom:10px;'>"
	   		     		+ "<div  id='social'>"
	   		     		+ "<table width='200' border='0' cellspacing='0' cellpadding='0' align='center' style='margin-right:auto;margin-left:auto;'>"
	   		     		+ "<tr>"
	   		     		+ "<td align='center' style='padding-right:10px;padding-left:10px;'>"
	   		     		+ "<a target='_blank' href='https://www.linkedin.com/company/38519'><img src='https://www.venafi.com/assets/img/email/linkedin_20x20.png' alt='LinkedIn' border='0' width='20' height='20' style='border:none; display:block; font-family: Calibri, arial, sans-serif; font-size: 12px; line-height:20px; outline:none; text-decoration:none;' /></a>"
	   		     		+ "</td>"
	   		     		+ "<td align='center' style='padding-right:10px;padding-left:10px;'>"
	   		     		+ "<a target='_blank' href='http://twitter.com/csinconline'><img src='https://www.venafi.com/assets/img/email/twitter_20x20.png' alt='Twitter' border='0' width='20' height='20' style='border:none; display:block; font-family: Calibri, arial, sans-serif; font-size: 10px; line-height:20px; outline:none; text-decoration:none;' /></a>"
	   		     		+ "</td>"
	   		     		+ "<td align='center' style='padding-right:10px;padding-left:10px;'>"
	   		     		+ "<a target='_blank' href='https://www.youtube.com/user/csinccompany'><img src='https://www.venafi.com/assets/img/email/youtube_20x20.png' alt='YouTube' border='0' width='20' height='20' style='border:none; display:block; font-family: Calibri, arial, sans-serif; font-size: 10px; line-height:20px; outline:none; text-decoration:none;' /></a>"
	   		     		+ "</td>"
	   		     		+ "<td align='center' style='padding-right:10px;padding-left:10px;'>"
	   		     		+ "<a target='_blank' href='https://www.facebook.com/constructionspecialties'><img src='https://www.venafi.com/assets/img/email/facebook_20x20.png' alt='Facebook' border='0' width='20' height='20' style='border:none; display:block; font-family: Calibri, arial, sans-serif; font-size: 10px; line-height:20px; outline:none; text-decoration:none;' /></a>"
	   		     		+ "</td>"
	   		     		+ "<td align='center' style='padding-right:10px;padding-left:10px;'>"
	   		     		+ "<a target='_blank' href=''><img src='http://go.venafi.com/rs/041-OML-787/images/ForwardFriend.png' alt='Forward to Friend' border='0' width='20' height='20' style='border:none; display:block; font-family: Calibri, arial, sans-serif; font-size: 10px; line-height:20px; outline:none; text-decoration:none;' /></a>"
	   		     		+ "</td>"
	   		     		+ "</tr>"
	   		     		+ "</table>"
	   		     		+ "</div>"
	   		     		+ "</td>"
	   		     		+ "</tr>"
	   		     		+ "<!--End Social-->"
	   		     		+ "<tr> <!-- changing font-size from 12px to 6pt -->"
	   		     		+ "<td style='text-align:center;font-size:6pt;color:#333333;font-family:Arial, Helvetica, sans-serif;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:10px;'>"
	   		     		+ "<div class='mktEditable' id='footer'>"
	   		     		+ "<span class='address'>3 Werner Way, Lebanon, New Jersey 08833 | 888.331.2031</span>"
	   		     		+ "</div>"
	   		     		+ "</td>"
	   		     		+ "</tr>"
	   		     		+ "<!--End Footer-->"
	   		     		+ "<!--Product Links Token-->"
	   		     		+ "<tr>"
	   		     		+ "<td style='text-align:center;font-size:12px;color:#333333;font-family:Arial, Helvetica, sans-serif;padding-top:10px;padding-right:10px;padding-bottom:10px;padding-left:10px;'>"
	   		     		+ "<div class='mktEditable' id='product-links'>"
	   		     		+ "</div>"
	   		     		+ "</td>"
	   		     		+ "</tr>"
	   		     		+ "<!--End Product Links Token--> "
	   		     		+ "</table>"
	   		     		+ "<!--End Body Table-->"
	   		     		+ "</td>"
	   		     		+ "</tr>"
	   		     		+ "</table>"
	   		     		+ "</body>"
	   		     		+ "</html>";
						
	   msg.setContent(messageString, "text/html");
	   msg.setSentDate(new java.util.Date());
	   Transport.send(msg);
	   log.debug("-- Order Acknowledgement E-Mail Sent Sucessfully!! for order number : "+order_no+" --");
	   log.debug("-- Order Acknowledgement E-Mail Sent Sucessfully!! for order number : "+order_no+" --");
	   
   }else{
	   log.debug("-- logged in user is cs-internal user or cs-estimator, won't be sending the order acknowledgement mail....--  "+order_no);
	   out.println("-- logged in user is cs-internal user or cs-estimator, won't be sending the order acknowledgement mail....--  ");
	}
	   
   	
	}
	catch(javax.mail.internet.AddressException ae){
		out.println("---OAE file AddressException "+ae);
		System.out.println(ae);
		ae.printStackTrace();
	}
	catch(javax.mail.MessagingException me){
		out.println("---OAE file MessagingException "+me);
		System.out.println(me);
		me.printStackTrace();
	}
	
	catch(Exception e){
		out.println("-- OAE file Exception "+e.getMessage());
		System.out.println(e);
		e.printStackTrace();
	}
	
	finally{
	if(myConn!=null){
		try {
			stmt.close();
			myConn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}}
	}
	
		
	%>
</body>
</html>
<%
}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>