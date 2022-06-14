<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<META http-equiv=Content-Type content="text/html; charset=utf-8">


<%@ page language="java"  contentType="text/html; charset=UTF-8" import="jcifs.smb.*" import="java.nio.charset.Charset" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" import="javax.mail.*" import="java.util.*" import="java.math.*" import="java.sql.*" import="javax.mail.internet.*" import="javax.activation.*" import="java.net.*" import="java.text.*" import="org.zefer.pd4ml.PD4ML" import="org.zefer.pd4ml.PD4Constants" import="java.awt.Insets" errorPage="error.jsp" %>
<%@ include file="../../../db_con.jsp"%>
<%//@ include file="../../../db_con_sys.jsp"%>
<%
out.println("<font size='2' color='red'>Please do not close this window.  It will close itself when it is finished.</font><BR>");

String url3=request.getParameter("url3");
String type=request.getParameter("type");
String order_no=request.getParameter("order_no");
String file_details="";
String counterInit="";
String isLandscape=request.getParameter("isLandscape");
	if(isLandscape==null){
		isLandscape="";
	}
String counter="";
//int counterInit=0;
out.println(type+"<br>"+url3+":::<BR><BR>"+order_no+"::::<BR>");
String folder="";
boolean isInImsCounter=false;
ResultSet rs1=stmt.executeQuery("select numFiles,quote_file_details from cs_ims_counter where order_no='"+order_no.trim()+"'");
if(rs1 != null){
	while(rs1.next()){
		counter=rs1.getString(1);
		file_details=rs1.getString(2);
		isInImsCounter=true;
		//counterInit++;
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
counter=""+(Integer.parseInt(counter)+1);

if(counter == null || counter.equals("null") || counter.trim().length()<1){
	counter="00";
}
else if(counter.trim().length()<2){
	counter="0"+counter;
}

//out.println(counter+"::"+counterInit+"::<BR>");


if(file_details ==null || file_details.equals("null")){
	file_details="";
}
if(type.equals("1")){
	folder="TQ";
}
else if(type.equals("3")){
	folder="PS";
}
else if(type.equals("2")){
	folder="LINEITEM";
}
else if(type.equals("4")){
	folder="PSQ";
}
else if(type.equals("5")){
	folder="lineitemintl";
}
else if(type.equals("6")){
	folder="tqintl";
}
else if(type.equals("summary")){
	folder="summarysheet";
}
else if(type.equals("change")){
	folder="changerequest";
}
else if(type.equals("workcopy")){
	folder="workcopy";
}
else{
	folder="workcopy";
}
url3=url3.replaceAll(" ","%");
out.println("FOLDER:::"+folder);
String group_id="";
String product_id="";
String creator_id="";
String bpcs_order_no="";
ResultSet rs2=stmt.executeQuery("select product_id,creator_id,bpcs_order_no from cs_project where order_no='"+order_no.trim()+"'");
if(rs2 != null){
	while(rs2.next()){
		product_id=rs2.getString(1);
		creator_id=rs2.getString(2);
		bpcs_order_no=rs2.getString(3);
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
if(bpcs_order_no==null){
	bpcs_order_no="";
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
if(group_id==null){
	group_id="";
}
String saveFile ="";
String transfered="";
String fileName="";
java.util.Date date=new java.util.Date();
for(int y=0; y<3; y++){
	try{
		if(url3 != null && url3.trim().length()>0){
			saveFile =counter+product_id+order_no.trim()+".pdf";
			if(type.equals("change")){
				saveFile =counter+product_id+bpcs_order_no.trim()+order_no.trim()+".pdf";
			}
			String filepath="mun-imsx01/dropbox/erapid/"+folder+"/"+saveFile;
			if( application.getInitParameter("HOST").toUpperCase().indexOf("DEV")>0){
				filepath="lebhq-imsxdev/dropbox/erapid/"+folder+"/"+saveFile;
			}
			if(group_id.startsWith("Can")){
				filepath=filepath.replaceAll("dropbox/erapid","dropbox/canada");
			}

			out.println(filepath+"::<BR>"+type+":::<BR>");

			SmbFile s = new SmbFile("smb://c-sgroup;erapidprod:cseprod3@"+filepath);

			SmbFileOutputStream fos = new SmbFileOutputStream(s);
			out.println(saveFile+"HERE1<BR>");

if(url3.indexOf("lebhq")<0){
url3="http://"+ application.getInitParameter("HOST")+"/erapid/us/"+url3;
}
out.println(url3);
			java.net.URL targetURL = new java.net.URL (url3) ;
			out.println("HERE2<BR>");
			PD4ML html = new PD4ML();

			html.protectPhysicalUnitDimensions();

		if(isLandscape.toUpperCase().equals("YES")){

				Insets inset=new Insets(0,0,0,0);
				html.setPageInsets(inset);
				html.setPageSize(html.changePageOrientation(PD4Constants.LETTER));
				html.setHtmlWidth(1000);

		}
		else{
			html.setPageSize(PD4Constants.LETTER);

		}
			html.render(targetURL, fos);
			transfered=transfered+"transfere worked...";
			file_details=file_details+"<tr><td>"+folder+"</td><td>"+saveFile+"</td><td>"+date+"</td></tr>";

		}

		out.println(transfered);
		if(Integer.parseInt(counterInit)>0 ||isInImsCounter){
			out.println("HERE1");
			java.sql.PreparedStatement ps=myConn.prepareStatement("UPDATE cs_ims_counter SET numFiles =?,quote_file_details=? WHERE Order_no =? ");
			ps.setString(1,counter.trim());
			ps.setString(2,file_details);
			ps.setString(3,order_no.trim());
			int re=ps.executeUpdate();
			ps.close();
			out.println("HERE2");
		}
		else{
			out.println("HERE3");
			String insert ="INSERT INTO cs_ims_counter(order_no,quote_file_details,numFiles) VALUES(?,?,?) ";
			PreparedStatement insert_ims = myConn.prepareStatement(insert);
			insert_ims.setString(1,order_no.trim());
			//out.println("HERE5");
			insert_ims.setString(2,file_details);
			insert_ims.setString(3,counter.trim());
			//out.println("HERE6");
			int rocount = insert_ims.executeUpdate();
			//out.println("HERE7"+insert);
			insert_ims.close();
			//out.println("HERE4");
		}
		y=3;
		out.println("HERE");
%>
<body onload='javascript:window.close()'>
	<%
}
catch(Exception e){
	if(y>=2){
		out.println(" IF YOU SEE THIS MESSAGE, YOUR FILES DID NOT TRANSFER::"+e);
		String from = "erapiderror@c-sgroup.com" ;
		String to = "roanesa@c-sgroup.com";
		String cc = "gsuisham@c-sgroup.com";
		//String host ="lebhq-notes.c-sgroup.com";
		String host ="LEBHQ-SMTP01.c-sgroup.com";
		String subject = "TRANSFER TO IMS ERROR.  QUOTE NUMBER :"+product_id+order_no+" By Rep Number :"+creator_id +" :::  3 ATTEMPTS FAILED";
		String message = "TRANSFER TO IMS ERROR.  QUOTE NUMBER :"+product_id+order_no+" By Rep Number :"+creator_id+"\n\n\n"+e+"\n\n\n"+transfered+"\n\n\n* quote not transfered)";
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
stmt.close();
//stmts.close();
myConn.close();
//myConns.close();

	}
	catch(Exception e){

		out.println(e);
	}

	%>