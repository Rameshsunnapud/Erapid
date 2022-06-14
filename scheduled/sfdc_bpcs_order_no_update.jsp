<%@ page language="java"  contentType="text/html; charset=UTF-8" import="jcifs.smb.*" import="java.nio.charset.Charset" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" import="javax.mail.*" import="java.util.*" import="java.math.*" import="java.sql.*" import="javax.mail.internet.*" import="javax.activation.*" import="java.net.*" import="java.text.*" import="org.zefer.pd4ml.PD4ML" import="org.zefer.pd4ml.PD4Constants" import="java.awt.Insets" errorPage="error.jsp" %>
<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<%
try{
%>
<%@ include file="../db_con_sfdc.jsp"%>
<%@ include file="../db_con_bpcs.jsp"%>
<%@ include file="../db_con.jsp"%>
<%
java.util.Date uDate = new java.util.Date(); // Right now
Format formatter = new SimpleDateFormat("yyyyMMdd");
String tdate=formatter.format(uDate);
String bpcs_order_date=tdate;
java.util.Date date1 = new java.util.Date();
String fileNameAdder = "" + date1.getTime();

String bpcs_status="WON";
String server=application.getInitParameter("HOST");
DateFormat dateformat = new SimpleDateFormat ("yyyy-MM-dd");
Vector bpcs_order_no = new Vector();
Vector bpcs_erapid_no = new Vector();
Vector bpcs_order_no2 = new Vector();
Vector bpcs_erapid_no2 = new Vector();
String final_out="";
int count=0;
int count2=0;
int count3=0;
String sql_bpcs="SELECT D.HORD,d.chad6 FROM BPCSFFG.ECH AS D WHERE D.CHBOCL != 8 and D.HEDTE ='"+tdate+"'";
ResultSet rs_bpcs = stmt_bpcs.executeQuery(sql_bpcs);
while ( rs_bpcs.next() ) {
    if(rs_bpcs.getString(2).trim().length()>0&&rs_bpcs.getString(2).indexOf("_")>0){
        bpcs_order_no.addElement(rs_bpcs.getString(1).trim());
        bpcs_erapid_no.addElement(rs_bpcs.getString(2).trim());
        count++;
    }
}
rs_bpcs.close();
sql_bpcs="SELECT C.HOORD,C.HOQUT FROM BPCSUSRFFG.CEH AS C WHERE C.HOQOR = 'E' AND C.HOORD IN ( SELECT D.HORD FROM BPCSFFG.ECH AS D WHERE D.CHBOCL != 8 and D.HEDTE ='"+tdate+"' ) GROUP BY C.HOORD,C.HOQUT";
ResultSet rs_bpcs2 = stmt_bpcs.executeQuery(sql_bpcs);
while ( rs_bpcs2.next() ) {
    if(rs_bpcs2.getString(2).trim().length()>0&&rs_bpcs2.getString(2).indexOf("_")>0){
        bpcs_order_no.addElement(rs_bpcs2.getString(1).trim());
        bpcs_erapid_no.addElement(rs_bpcs2.getString(2).trim());
        count++;
    }
}
rs_bpcs2.close();
for(int k=0;k<bpcs_erapid_no.size();k++){
    ResultSet rs1=stmt.executeQuery("select count(*) from cs_project where order_no='"+bpcs_erapid_no.elementAt(k).toString()+"' and project_type='sfdc'");
    if(rs1 != null){
        while(rs1.next()){
            if(rs1.getInt(1)>0){
                bpcs_order_no2.addElement(bpcs_order_no.elementAt(k).toString());
                bpcs_erapid_no2.addElement(bpcs_erapid_no.elementAt(k).toString());
            }
        }
    }
    rs1.close();
}
for (int i=0; i<bpcs_erapid_no2.size();i++){
    if(server.equals("lebhq-csedev.c-sgroup.com")){
	out.println(" DEV SERVER--SFDC STATUS SCRIPT WONT RUN");
    }
    else{
		stmt_sfdc.executeUpdate( "set ANSI_warnings on");
		stmt_sfdc.executeUpdate( "set ANSI_NULLS on");
		if(bpcs_erapid_no2.elementAt(i).toString() != null && bpcs_erapid_no2.elementAt(i).toString().trim().length()>0 && bpcs_order_no2.elementAt(i).toString() != null && bpcs_order_no2.elementAt(i).toString().trim().length()>0 && bpcs_order_date != null && bpcs_order_date.trim().length()>0){
			try{
				CallableStatement cs = myConn_sfdc.prepareCall("{call dbo.cspUpdateOrderNo(?,?,?,?)}");
				cs.setString(1,bpcs_erapid_no2.elementAt(i).toString().trim());
				cs.setString(2,bpcs_status.toUpperCase());
				cs.setString(3,bpcs_order_no2.elementAt(i).toString().trim());
				cs.setString(4,bpcs_order_date);
				cs.execute();
				cs.close();
				count2++;
				final_out=final_out+"UPDATE ::"+bpcs_erapid_no2.elementAt(i).toString()+"::order no "+bpcs_order_no2.elementAt(i).toString().trim()+"::bpcs order no"+bpcs_order_date+":: bpcs order date"+bpcs_status+":: bpcs status \r\n";
            }
            catch (java.sql.SQLException e) {
               //out.println("Problem with salesforce stored procedure<br>");
               //out.println("Illegal Operation try again/Report Error"+"<br>");
			//out.println(e.toString());
               count3++;
               final_out=final_out+"ERROR :: sfdc stored procedure :: "+e+"::"+bpcs_erapid_no2.elementAt(i).toString()+"::order no "+bpcs_order_no2.elementAt(i).toString().trim()+"::bpcs order no"+bpcs_order_date+":: bpcs order date"+bpcs_status+":: bpcs status \r\n";
			String from = "erapiderror@c-sgroup.com" ;
			String to = "gsuisham@c-sgroup.com";
			//String host ="lebhq-notes.c-sgroup.com";
			String host ="LEBHQ-SMTP01.c-sgroup.com";
			String subject = "Problem with salesforce stored procedure erus";
			String message = "Problem with salesforce stored procedure:::"+e+" \r\n \r\n "+final_out;
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
			return;
            }
        }
        else{
            count3++;
            final_out=final_out+"ERROR2 ::"+bpcs_erapid_no2.elementAt(i).toString()+"::order no "+bpcs_order_no2.elementAt(i).toString().trim()+"::bpcs order no"+bpcs_order_date+":: bpcs order date"+bpcs_status+":: bpcs status \r\n";
        }
        stmt_sfdc.executeUpdate( "set ANSI_warnings off");
        stmt_sfdc.executeUpdate( "set ANSI_NULLS off");
    }
}

stmt_sfdc.executeUpdate( "set ANSI_NULLS off");
final_out=final_out+"BPCS Total::"+count+"::SFDC updated::"+count2+"::Erapid Exception::"+count3+"::"+tdate+"\r\n";
String dir_path="D:\\erapid\\scheduled\\log\\";
//out.println(dir_path);
String fileName=tdate+date1.getTime()+"SFDC.txt";

BufferedWriter out1 = new BufferedWriter(new FileWriter(dir_path+"\\"+fileName));

out1.write(final_out);
out1.flush();
out1.close();
stmt_sfdc.close();
myConn_sfdc.close();
stmt_bpcs.close();
con_bpcs.close();
stmt.close();
myConn.close();
}
catch(Exception eee){

			String from = "erapiderror@c-sgroup.com" ;
			String to = "gsuisham@c-sgroup.com";
			//String host ="lebhq-notes.c-sgroup.com";
			String host ="LEBHQ-SMTP01.c-sgroup.com";
			String subject = "Problem with salesforce stored procedure";
			String message = "Problem with salesforce stored procedure:::"+eee;
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
			return;
}


	}
	  catch(Exception e){
		out.println("ERROR::"+e);
	  }
%>
<body >done
</body>