package com.csgroup.general;


import java.awt.Dimension;
import java.awt.Insets;
import java.io.File;
import java.io.StringWriter;

import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;

import org.w3c.dom.*;
import org.zefer.pd4ml.PD4Constants;
import org.zefer.pd4ml.PD4ML;
import org.zefer.pd4ml.PD4PageMark;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.*;
import java.math.*;
import java.io.*;
import java.awt.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;
import java.net.*;
import java.sql.SQLException;
import jcifs.smb.SmbFile;

public class Convertor{

	org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String dbServerName = "";
	String dbServerPort = "";
	String erapidDB = "";
	String erapidSysDB = "";
	String erapidDBUsername = "";
	String erapidDBPassword = "";
	String fullServerName = "";

	String query = "";

	public String htmlToRtf(String url,String intl,String order_no,String paper,String isLandscape,String isLVRSummary){
		String path = "";
		try{
			String tempProduct = getProduct(order_no);
                        if(url.startsWith("http://")){
                            url=url.replace("http:","https:");
                        }
			if(!url.startsWith("http://")){
				url = "http://" + url;
			}
			if(order_no != null && !url.endsWith(order_no)){
				//	url = url+"?orderNo="+order_no;
			}
			java.util.Date date1 = new java.util.Date();
			String fileNameAdder = "" + date1.getTime();
			String fileName = order_no + "_" + fileNameAdder + ".rtf";
			//String fileName=order_no+".rtf";
			File f = new File("D:/erapid/shared/" + fileName);
			f.deleteOnExit();
			path = fileName;
			java.io.FileOutputStream fos = new java.io.FileOutputStream(f);
			java.net.URL targetURL = new java.net.URL(url);
			PD4ML html = new PD4ML();
			// html.enableDebugInfo();
			html.outputFormat(PD4Constants.RTF);
			html.setHtmlWidth(1000);
			html.addStyle("d:/erapid/css/quotes2.css",true);
			html.useTTF("d:/erapid/beans/pd4fonts.properties",true);
			//html.useTTF("c:/windows/fonts",true);
			//html.protectPhysicalUnitDimensions();
			PD4PageMark header = new PD4PageMark();
			//html.setPageSize(PD4Constants.A4);
			html.setPageSize(PD4Constants.LETTER);
			//Insets inset = new Insets(5,10,1,6);
			//html.setPageInsetsMM(inset);
			//html.setPageSizeMM(new Dimension(210,297));
			header.setAreaHeight(30);
			header.setHtmlTemplate("<p align='right'><font size='2'>" + order_no + "<BR>Page " + "$[page] of $[total]</font>");
			html.setPageFooter(header);
			html.render(targetURL,fos);
			logger.info("convert.htmltortf completed successfully");
		}
		catch(Exception e){
			logger.debug("convert.htmltortf");
			logger.debug(e.getMessage());
			logger.debug("convert.htmltortf end");
		}
		return path;
	}

	public String htmlToPdf(String url,String intl,String order_no,String paper,String isLandscape,String isLVRSummary){
		String path = "";
		try{
			String tempProduct = getProduct(order_no);
			if(url.startsWith("http://")){
                            url=url.replace("http:","https:");
                        }
			if(!url.startsWith("https://")){
				url = "https://" + url;
			}
			//logger.debug("convertor line 118::" + url);
			if(order_no != null && url.indexOf("orderNo") <= 0){
				if(url.indexOf("jsp&") > 0){
					url = url.replace("jsp&","jsp?orderNo=" + order_no + "&");
				}
				else{
					url = url + "?orderNo=" + order_no;
				}
			}
			//logger.debug("convertor line 124::" + url);
			java.util.Date date1 = new java.util.Date();
			String fileNameAdder = "" + date1.getTime();
			String fileName = order_no + "_" + fileNameAdder + ".pdf";
			//String fileName=order_no+".pdf";
			File f = new File("D:/erapid/shared/" + fileName);
			f.deleteOnExit();
			path = fileName;
			java.io.FileOutputStream fos = new java.io.FileOutputStream(f);
			java.net.URL targetURL = new java.net.URL(url);
			PD4ML html = new PD4ML();
			html.setPermissions("empty",0xffffffff ^ PD4Constants.AllowFillingForms ^ PD4Constants.AllowFillingForms ^ PD4Constants.AllowModify,true);
			//html.enableDebugInfo();
			//html.setHtmlWidth(1000);
			//html.addStyle("d:/erapid/css/quotesConvertor.css",true);
			//html.useTTF("d:/erapid/beans/pd4fonts.properties",true);
			//html.protectPhysicalUnitDimensions();

			html.outputFormat(PD4Constants.PDF);
			html.setHtmlWidth(1000);
			//html.addStyle("d:/erapid/css/quotesConvertor.css",true);
			html.addStyle("d:/erapid/css/quotes2.css",true);
			html.useTTF("d:/erapid/beans/pd4fonts.properties",true);

			PD4PageMark header = new PD4PageMark();
			if(url.indexOf("tear") >= 0){
				Insets inset = new Insets(0,0,0,0);
				html.setPageInsets(inset);
				html.setPageSize(html.changePageOrientation(PD4Constants.LETTER));
				html.setHtmlWidth(1000);
			}
			else{
				html.setPageSize(PD4Constants.LETTER);
				Insets inset = new Insets(5,4,1,6);
				html.setPageInsetsMM(inset);
				html.setPageSizeMM(new Dimension(210,297));
				header.setAreaHeight(30);
			}
			header.setHtmlTemplate("<p align='right'><font size='2'>" + order_no + "<BR>Page " + "$[page] of $[total]</font>");
			html.setPageFooter(header);
			html.render(targetURL,fos);
			logger.info("convert.htmltopdf completed successfully");
		}
		catch(Exception e){
			logger.debug("convert.htmltopdf");
			logger.debug(e.getMessage());
			logger.debug("convert.htmltopdf end");
		}
		return path;
	}

	public String htmlToIMS(String url,String intl,String order_no,String paper,String isLandscape,String isLVRSummary,String type){
		String div = "Returned from IMS conversion method";
		Connection myConn = null;
		Statement stmt = null;
		//logger.debug("convertor.htmltoims::" + url + "::" + intl + "::" + order_no + "::" + paper + "::" + isLandscape + "::" + isLVRSummary + "::" + type);
		try{
			logger.info("Started IMS conversion");
			String IMSServer = "";
			String erapidServer = "";
			String path = htmlToPdf(url,"",order_no,"","","");
			logger.info("Path of the file in erusdev "+path+" and "+url);
			//logger.debug("convertor.htmltoims line 148::" + path);
			File fXmlFile = new File("d:\\erapid\\erapid.xml");
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("instance");
			for(int temp = 0;temp < nList.getLength();temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					Element eElement = (Element) nNode;
					dbServerPort = "" + getTagValue("dbServerPort",eElement);
					dbServerName = "" + getTagValue("dbServerName",eElement);
					erapidDB = "" + getTagValue("erapidDB",eElement);
					erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
					fullServerName = "" + getTagValue("fullServerName",eElement);
					IMSServer = "" + getTagValue("IMSServer",eElement);
					erapidServer = "" + getTagValue("serverName",eElement);
				}
			}
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			String counterInit = "";
			String counter = "";
			String folder = "";
			String fileDetails = "";
			boolean isInImsCounter = false;
			ResultSet rs1 = stmt.executeQuery("select numFiles,quote_file_details from cs_ims_counter where order_no='" + order_no.trim() + "'");
			if(rs1 != null){
				while(rs1.next()){
					counter = rs1.getString(1);
					fileDetails = rs1.getString(2);
					isInImsCounter = true;
					//counterInit++;
				}
			}
			rs1.close();

			if(counter == null || counter.equals("null") || counter.trim().length() < 1){
				counter = "00";
			}
			else if(counter.trim().length() < 2){
				counter = "0" + counter;
			}
			counterInit = counter;
			counter = "" + (Integer.parseInt(counter) + 1);

			if(counter == null || counter.equals("null") || counter.trim().length() < 1){
				counter = "00";
			}
			else if(counter.trim().length() < 2){
				counter = "0" + counter;
			}
			if(fileDetails == null || fileDetails.equals("null")){
				fileDetails = "";
			}
			if(type.equals("1")){
				folder = "TQ";
			}
			else if(type.equals("2")){
				folder = "PS";
			}
			else if(type.equals("3")){
				folder = "LINEITEM";
			}
			else if(type.equals("4")){
				folder = "PSQ";
			}
			else if(type.equals("5")){
				folder = "lineitemintl";
			}
			else if(type.equals("6")){
				folder = "tqintl";
			}
			else if(type.equals("summary")){
				folder = "summarysheet";
			}
			else if(type.equals("change")){
				folder = "changerequest";
			}
			else if(type.equals("workcopy")){
				folder = "workcopy";
			}
			else{
				folder = "QTWORKCOPY";
			}
			url = url.replaceAll(" ","%");
			String group_id = "";
			String product_id = "";
			String creator_id = "";
			String bpcs_order_no = "";
			ResultSet rs2 = stmt.executeQuery("select product_id,creator_id,bpcs_order_no,quote_type from cs_project where order_no='" + order_no.trim() + "'");
			if(rs2 != null){
				while(rs2.next()){
					product_id = rs2.getString(1);
					creator_id = rs2.getString(2);
					bpcs_order_no = rs2.getString(3);
					if(rs2.getString(4).equals("Q") && type.equals("workcopy")){
						folder = "QTWORKCOPY";
					}
				}
			}
			rs2.close();
			ResultSet rsSys = stmt.executeQuery("select group_id from cs_reps where rep_no='" + creator_id + "'");
			if(rsSys != null){
				while(rsSys.next()){
					group_id = rsSys.getString("group_id");
				}
			}
			rsSys.close();
			if(bpcs_order_no == null){
				bpcs_order_no = "";
			}
			if(product_id.equals("GCP")){
				product_id = "GCU";
			}
			else if(product_id.equals("GE")){
				product_id = "GRA";
			}
			else if(product_id.equals("GRILLE")){
				product_id = "GRL";
			}
			else if(product_id.equals("EJC")){
				product_id = "TPG";
			}
			if(group_id == null){
				group_id = "";
			}
			String saveFile = "";
			String transfered = "";
			String fileName = "";
			java.util.Date date = new java.util.Date();
			//logger.debug("convertor line 270:" + path);

			saveFile = counter + product_id + order_no.trim() + ".pdf";
			if(type.equals("change")){
				saveFile = counter + product_id + bpcs_order_no.trim() + order_no.trim() + ".pdf";
			}

			String filepath = IMSServer + "/dropbox/erapid/" + folder + "/" + saveFile;

			if(group_id.startsWith("Can")){
				filepath = filepath.replaceAll("dropbox/erapid","dropbox/canada");
			}

			path = erapidServer + "/shared/" + path;
			String filepath1 = IMSServer + "/dropbox/erapid/temptransfer/" + saveFile;
			logger.debug("convertor.htmltoims line 284::" + filepath);
			logger.debug("convertor.htmltoims line 284::" + filepath1);
			logger.debug("convertor.htmltoims line 284::" + path);
			SmbFile toTemp = new SmbFile("smb://c-sgroup;erapidprod:cseprod3@" + filepath1);
			SmbFile to = new SmbFile("smb://c-sgroup;erapidprod:cseprod3@" + filepath);
			SmbFile from = new SmbFile("smb://c-sgroup;erapidprod:cseprod3@" + path);
			from.copyTo(toTemp);

			toTemp.copyTo(to);
			//logger.debug(path + "::" + from.length());
			//logger.debug(filepath1 + "::" + toTemp.length());
			//logger.debug(filepath + "::" + to.length());
			toTemp.delete();
			from.delete();
			/*
			 if(Integer.parseInt(counterInit) > 0 || isInImsCounter){
			 java.sql.PreparedStatement ps = myConn.prepareStatement("UPDATE cs_ims_counter SET numFiles =?,quote_file_details=? WHERE Order_no =? ");
			 ps.setString(1,counter.trim());
			 ps.setString(2,fileDetails);
			 ps.setString(3,order_no.trim());
			 int re = ps.executeUpdate();
			 ps.close();
			 }
			 else{
			 String insert = "INSERT INTO cs_ims_counter(order_no,quote_file_details,numFiles) VALUES(?,?,?) ";
			 java.sql.PreparedStatement insert_ims = myConn.prepareStatement(insert);
			 insert_ims.setString(1,order_no.trim());
			 insert_ims.setString(2,fileDetails);
			 insert_ims.setString(3,counter.trim());
			 int rocount = insert_ims.executeUpdate();
			 insert_ims.close();
			 }
			 */
		}
		catch(Exception e){
			logger.debug("Convertor.htmlToIMS");
			logger.debug(e.getMessage());
			logger.debug("Convertor.htmlToIMS END");
		}
		finally{
			try{
				stmt.close();
				myConn.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
		return div;
	}

	public String emailPdf(String url,String intl,String order_no,String paper,String isLandscape,String isLVRSummary,String to,String from,String cc,String bcc,String bcc2,String messagex,String dirname,String attachfiles,String productId,String rep_no,String bcc3,String userId){
		String div = "";
		String resultx = "";
		Connection myConn = null;
		Statement stmt = null;
		try{
			if(attachfiles != null){
				attachfiles = attachfiles.replaceAll("bbb","&");
				attachfiles = attachfiles.replaceAll("aaa","=");
			}
			File fXmlFile = new File("d:\\erapid\\erapid.xml");
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("instance");
			for(int temp = 0;temp < nList.getLength();temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					Element eElement = (Element) nNode;
					dbServerPort = "" + getTagValue("dbServerPort",eElement);
					dbServerName = "" + getTagValue("dbServerName",eElement);
					erapidDB = "" + getTagValue("erapidDB",eElement);
					erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
					fullServerName = "" + getTagValue("fullServerName",eElement);
				}
			}
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			String project_name = "PROJECT_NAME";
			String user_id = "";
			String rep_name = "";
			String rep_account = "";
			String rep_telephone = "";
			String rep_fax = "";
			String rep_email = "";
			String product_id_subject = "";
			query = "Select rep_no_text,rep_name,rep_account,telephone,fax,email,email2,user_id,rep_no_text from cs_reps where rep_no_text= '" + rep_no + "' and user_id='" + userId + "'";
			ResultSet rs1 = stmt.executeQuery(query);
			if(rs1 != null){
				while(rs1.next()){
					user_id = rs1.getString("user_id");
					rep_name = rs1.getString("rep_name");
					rep_account = rs1.getString("rep_account");
					rep_telephone = rs1.getString("telephone");
					rep_fax = rs1.getString("fax");
					rep_email = rs1.getString("email");
				}
			}
			rs1.close();
			if(rep_name == null || rep_name.trim().length() == 0){
				query = "Select rep_no_text,rep_name,rep_account,telephone,fax,email,email2,user_id,rep_no_text from cs_reps where rep_no_text= '" + rep_no + "'";
				ResultSet rs1x = stmt.executeQuery(query);
				if(rs1x != null){
					while(rs1x.next()){
						user_id = rs1x.getString("user_id");
						rep_name = rs1x.getString("rep_name");
						rep_account = rs1x.getString("rep_account");
						rep_telephone = rs1x.getString("telephone");
						rep_fax = rs1x.getString("fax");
						rep_email = rs1x.getString("email");
					}
				}
				rs1x.close();
			}
			String replyTo = rep_email;
			if((from == null || from.trim().length() == 0 || from.indexOf("LEBHQ") >= 0) && !(rep_email == null && rep_email.length() == 0)){
				if(rep_email.indexOf("c-sgroup") >= 0){
					from = rep_email;
				}
			}
			if(from.indexOf("c-sgroup") < 0){
				from = "no_reply_" + productId.toLowerCase() + "@c-sgroup.com";
			}
			query = "select project_name,product_id from cs_project where order_no='" + order_no + "'";
			ResultSet rs2 = stmt.executeQuery(query);
			if(rs2 != null){
				while(rs2.next()){
					project_name = rs2.getString("project_name");
					product_id_subject = rs2.getString("product_id");
				}
			}
			rs2.close();
			String subject = "";
			String message = "";
			String host = "LEBHQ-SMTP01.c-sgroup.com";
			Properties prop = System.getProperties();
			//logger.debug("convertor line 244::" + url);
			url = url.replaceAll("!","&");
			//logger.debug("convertor line 251::" + url);
			String fileName = htmlToPdf(url,intl,order_no,paper,isLandscape,isLVRSummary);

			prop.put("mail.smtp.host",host);
			Session ses1 = Session.getDefaultInstance(prop,null);
			MimeMessage msg = new MimeMessage(ses1);
			msg.addFrom(new InternetAddress().parse(from));
			msg.addRecipients(Message.RecipientType.TO,new InternetAddress().parse(to));
			msg.addRecipients(Message.RecipientType.CC,new InternetAddress().parse(cc));
			if(replyTo != null && replyTo.trim().length() > 0){
				msg.setReplyTo(new InternetAddress().parse(replyTo));
			}
			//msg.addRecipients(Message.RecipientType.BCC,new InternetAddress().parse(rep_email));
			if(bcc != null && !bcc.equals("null") && bcc.trim().length() > 0){
				msg.addRecipients(Message.RecipientType.BCC,new InternetAddress().parse(bcc));
			}
			if(bcc2 != null && !bcc2.equals("null") && bcc2.trim().length() > 0){
				msg.addRecipients(Message.RecipientType.BCC,new InternetAddress().parse(bcc2));
			}
			if(bcc3 != null && !bcc3.equals("null") && bcc3.trim().length() > 0){
				msg.addRecipients(Message.RecipientType.BCC,new InternetAddress().parse(bcc3));
			}
			//logger.debug(from + "::" + to + "::" + cc + "::" + rep_email + "::" + bcc + "::" + bcc2 + ":::" + bcc3);
			subject = "CS Quote for project " + project_name;
			subject = subject + " " + product_id_subject;
			String extraNotes = "";
			String adderx = "";

			message = message + "<html><head><META http-equiv='Content-Type' content='text/html; charset=utf-8'>";
			message = message + "</head>";
			message = message + "<body>";
			message = message + "<table border='0' width='85%' cellspacing='0' cellpading='0' align='center' >";
			message = message + "<tr><td>Below is the Construction Specialties quote " + order_no + " attached.</td></tr>";
			message = message + "<tr><td>Project: \'" + project_name + "\' </td></tr>";
			message = message + "<tr><td>&nbsp;</td></tr>";
			message = message + "<tr><td> " + messagex + " </td></tr>";
			message = message + "<tr><td>&nbsp;</td></tr>";
			message = message + "<tr><td>====================</td></tr>";
			message = message + "<tr><td>This email message and any files transmitted with it is for the sole </td></tr>";
			message = message + "<tr><td>use of the intended recipient(s) and may contain confidential and privileged </td></tr>";
			message = message + "<tr><td>information. Any unauthorized review, use, disclosure or distribution of this</td></tr>";
			message = message + "<tr><td>email content is prohibited. If you are not the intended recipient, please</td></tr>";
			message = message + "<tr><td>destroy all paper and electronic copies of the original message.</td></tr>";
			message = message + "<tr><td>====================</td></tr>";
			if(!(rep_name == null || rep_name.trim().startsWith("nu") || rep_name.trim().equals(""))){
				message = message + "<tr><td>" + rep_name + "</td></tr>";
			}
			if(!(rep_account == null || rep_account.trim().startsWith("nu") || rep_account.trim().equals(""))){
				message = message + "<tr><td>" + rep_account + "<td></tr>";
			}
			message = message + "<tr><td>" + "Tel: " + rep_telephone + " Fax: " + rep_fax + "</td></tr>";
			if(!(rep_email == null || rep_email.trim().startsWith("nu") || rep_email.trim().equals(""))){
				message = message + "<tr><td>" + "Email: " + rep_email + "</td></tr>";
			}
			message = message + "<br><tr><td>" + adderx + "</td></tr>";	///comments for rep extra contact
			message = message + "</table><br><br>";//end of the first table
			msg.setSubject(subject,"UTF-8");
			BodyPart messageBodyPart = new MimeBodyPart();
			messageBodyPart.setContent(message,"text/html; charset=\"UTF-8\"");
			Multipart multipart = new MimeMultipart();
			multipart.addBodyPart(messageBodyPart);
			messageBodyPart = new MimeBodyPart();
			DataSource source = new URLDataSource(new URL(fullServerName + "/erapid/shared/" + fileName));
			messageBodyPart.setDataHandler(new DataHandler(source));
			String fileNamex = "";
			fileNamex = "Quote" + order_no + ".pdf";
			messageBodyPart.setFileName(fileNamex);
			multipart.addBodyPart(messageBodyPart);
			msg.setContent(multipart);
			messageBodyPart = new MimeBodyPart();
			Vector fileNames = new Vector();
			if(attachfiles != null && attachfiles.trim().length() > 0){

				while(attachfiles.length() > 0){
					int start = 0;
					int end = attachfiles.substring(1).indexOf("#");
					end++;
					fileNames.addElement(attachfiles.substring(1,end));
					attachfiles = attachfiles.substring(end + 1);
					if(attachfiles.length() < 3 || attachfiles.indexOf("#") < 0){
						attachfiles = "";
					}
				}
			}
			for(int i = 0;i < fileNames.size();i++){
				String url3 = fileNames.elementAt(i).toString();
				//logger.debug(url3);

				String tempfilename = fileNames.elementAt(i).toString().substring(0,fileNames.elementAt(i).toString().indexOf(".jsp"));

				if(tempfilename.indexOf("tear.") >= 0){
					String fileNamex2 = htmlToPdf(url3,intl,order_no,paper,isLandscape,isLVRSummary);

					tempfilename = "tearsheet";

					DataSource source3 = new URLDataSource(new URL(fullServerName + "/erapid/shared/" + fileNamex2));
					messageBodyPart.setDataHandler(new DataHandler(source3));

					messageBodyPart.setFileName(tempfilename + ".pdf");
					multipart.addBodyPart(messageBodyPart);
					msg.setContent(multipart);
					messageBodyPart = new MimeBodyPart();
				}
				else{
					DataSource source3 = new URLDataSource(new URL(url3));
					messageBodyPart.setDataHandler(new DataHandler(source3));

					//logger.debug(tempfilename);
					messageBodyPart.setFileName(tempfilename + ".html");
					multipart.addBodyPart(messageBodyPart);
					msg.setContent(multipart);
					messageBodyPart = new MimeBodyPart();
				}
			}
			File l_Directory = new File(dirname);
			File[] l_files = l_Directory.listFiles();
			for(int c = 0;c < l_files.length;c++){
				String filename = "" + l_files[c];
				int lastIndex = filename.lastIndexOf("\\");
				String tempFileName = filename.substring(lastIndex);
				if(lastIndex < 0){
					lastIndex = 0;
				}
				String url3 = "file:///" + l_files[c];
				filename = filename;
				DataSource source3 = new URLDataSource(new URL(url3));
				messageBodyPart.setDataHandler(new DataHandler(source3));
				messageBodyPart.setFileName(tempFileName);
				multipart.addBodyPart(messageBodyPart);
				msg.setContent(multipart);
				messageBodyPart = new MimeBodyPart();
			}
			Transport.send(msg);
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			Element emailresultx = doc2.createElement("emailResult");
			doc2.appendChild(emailresultx);
			Element searchresult = doc2.createElement("emailResult2");
			emailresultx.appendChild(searchresult);
			resultx = "EMAIL SENT";
			Element resultElement = doc2.createElement("result");
			resultElement.appendChild(doc2.createTextNode(resultx + "#"));
			searchresult.appendChild(resultElement);
			Element bccElement = doc2.createElement("bcc");
			bccElement.appendChild(doc2.createTextNode(rep_email + "#"));
			searchresult.appendChild(bccElement);
			TransformerFactory tFact = TransformerFactory.newInstance();
			Transformer trans = tFact.newTransformer();
			StringWriter writer = new StringWriter();
			StreamResult result = new StreamResult(writer);
			DOMSource sourcex2 = new DOMSource(doc2);
			trans.transform(sourcex2,result);
			div = writer.toString().trim();
		}
		catch(Exception e){
			logger.debug("convertor.emailPdf");
			logger.debug(e.getMessage());
			logger.debug("convertor.emailPdf end");
			try{
				DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
				DocumentBuilder build = dFact.newDocumentBuilder();
				Document doc2 = build.newDocument();
				Element emailresultx = doc2.createElement("emailResult");
				doc2.appendChild(emailresultx);
				Element searchresult = doc2.createElement("emailResult2");
				emailresultx.appendChild(searchresult);
				resultx = "EMAIL SENT";
				Element resultElement = doc2.createElement("result");
				resultElement.appendChild(doc2.createTextNode(e + "#"));
				searchresult.appendChild(resultElement);
				TransformerFactory tFact = TransformerFactory.newInstance();
				Transformer trans = tFact.newTransformer();
				StringWriter writer = new StringWriter();
				StreamResult result = new StreamResult(writer);
				DOMSource sourcex = new DOMSource(doc2);
				trans.transform(sourcex,result);
				div = writer.toString().trim();
			}
			catch(Exception e2){
				logger.debug("convertor.emailPdf2");
				logger.debug(e2.getMessage());
				logger.debug("convertor.emailPdf end");
			}
		}
		finally{
			try{
				stmt.close();
				myConn.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
		return div;
	}

	private String getProduct(String ordernox){
		String tempId = "";
		Connection myConn = null;
		Statement stmt = null;
		try{
			//logger.debug(url);
			File fXmlFile = new File("d:\\erapid\\erapid.xml");
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("instance");
			for(int temp = 0;temp < nList.getLength();temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					Element eElement = (Element) nNode;
					dbServerPort = "" + getTagValue("dbServerPort",eElement);
					dbServerName = "" + getTagValue("dbServerName",eElement);
					erapidDB = "" + getTagValue("erapidDB",eElement);
					erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
					fullServerName = "" + getTagValue("fullServerName",eElement);
				}
			}
			//logger.debug(dirname+"::"+messagex+"::"+attachfiles);
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			ResultSet rs1 = stmt.executeQuery("select product_id from cs_project where order_no='" + ordernox + "'");
			if(rs1 != null){
				while(rs1.next()){
					tempId = rs1.getString(1);
				}
			}
			rs1.close();
		}
		catch(Exception e){
			logger.debug("convertor.getProduct");
			logger.debug(e.getMessage());
			logger.debug("convertor.getProduct end");
		}
		finally{
			try{
				stmt.close();
				myConn.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
		return tempId;
	}

	private static String getTagValue(String sTag,Element eElement){
		NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		return nValue.getNodeValue();
	}
}
