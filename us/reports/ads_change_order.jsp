<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<%@ page language="java" import="java.util.*" import="java.sql.*" import="javax.mail.*" import="java.net.*" import="java.io.*" import="java.util.*" import="java.math.*" import="javax.mail.internet.*" import="javax.activation.*"  errorPage="error.jsp" %>
<%@ include file="../../db_con.jsp"%>

<%
String email=request.getParameter("email");
String order_no=request.getParameter("order_no");
String parent=order_no;
FileOutputStream p;
PrintStream out1;
Vector q_no=new Vector();
ResultSet rs0=stmt.executeQuery("select distinct quote_no from cs_ads_order_entry where quote_no like '"+parent+"%' order by quote_no");
if(rs0 != null){
	while(rs0.next()){
		q_no.addElement(rs0.getString("quote_no"));
	}
}
rs0.close();
String output="";
File f = new File("d:/transfer/ads/change"+order_no+".csv");
if(! f.exists()){
	p=new FileOutputStream("d:/transfer/ads/change"+order_no+".csv");
}
else{
	p=new FileOutputStream("d:/transfer/ads/change"+order_no+".csv", false);
}
out1 = new PrintStream(p);
output=output+"<tr><td></td><td>Total Doors</td><td>Total $</td><td>NR</td><td>20</td><td>45</td><td>60</td><td>90</td><td>LL</td><td>LL 20</td><td>Kickplates</td><td>Light Kits</td><td>Light Cutouts</td><td>20 minute wood lip bead.</td><td>Wood veneered metal lite kits.</td><td>Wood lip lite bead in maple.</td><td>Wood lite bead in maple</td><td>Acrovyn wrapped metal lite frame kit.</td><td>Metal primed lite frame kit.</td><td>Galvanized lite bead.</td><td>Lead lined lite bead.</td><td>Painted metal lite kits.</td><td>Stainless steel lite bead.</td></tr>";
output=output.replace(',',';');
output=output.replaceAll("<td>","");
output=output.replaceAll("</td>",",");
output=output.replaceAll("<tr>","");
output=output.replaceAll("</tr>","");
out1.println(output);
output="";
for(int i=0; i<q_no.size(); i++){
	Vector qty=new Vector();
	Vector acore=new Vector();
	Vector lk=new Vector();
	Vector kpn=new Vector();
	Vector ml=new Vector();
	Vector doorsize=new Vector();
	Vector machine_notes=new Vector();
	ResultSet rs1=stmt.executeQuery("select qty,acore,lk,kpn,ml,machine_notes,doorsize from cs_ads_order_entry where quote_no = '"+q_no.elementAt(i).toString()+"' and not abpcs is null and not abpcs=''");
	if(rs1 != null){
		while(rs1.next()){
			doorsize.addElement(rs1.getString("doorsize"));
			qty.addElement(rs1.getString("qty"));
			acore.addElement(rs1.getString("acore"));
			lk.addElement(rs1.getString("lk"));
			kpn.addElement(rs1.getString("kpn"));
			ml.addElement(rs1.getString("ml"));
			machine_notes.addElement(rs1.getString("machine_notes"));
			//out.println(rs1.getString("qty")+"::<BR>");
		}
	}
	rs1.close();
	String price="";
	int qtyfinal=0;
	int lkfinal=0;
	int kpnfinal=0;
	int ratingnr=0;
	int rating20=0;
	int rating45=0;
	int rating60=0;
	int rating90=0;
	int ratingllnr=0;
	int ratingll20=0;
	int ml0=0;
	int ml1=0;
	int ml2=0;
	int lktype1=0;
	int lktype2=0;
	int lktype3=0;
	int lktype4=0;
	int lktype5=0;
	int lktype6=0;
	int lktype7=0;
	int lktype8=0;
	int lktype9=0;
	int lktype10=0;
	int cutouts=0;
	for(int x=0; x<qty.size(); x++){
		qtyfinal=qtyfinal+Integer.parseInt(qty.elementAt(x).toString());
		if(kpn.elementAt(x).toString().trim().length()>0){
			kpnfinal=kpnfinal+Integer.parseInt(kpn.elementAt(x).toString());
		}
		if(acore.elementAt(x).toString().trim().length()>0){
			if(acore.elementAt(x).toString().equals("NR")){
				ratingnr=ratingnr+Integer.parseInt(qty.elementAt(x).toString());
			}
			else if(acore.elementAt(x).toString().equals("20")){
				rating20=rating20+Integer.parseInt(qty.elementAt(x).toString());
			}
			else if(acore.elementAt(x).toString().equals("45")){
				rating45=rating45+Integer.parseInt(qty.elementAt(x).toString());
			}
			else if(acore.elementAt(x).toString().equals("60")){
				rating60=rating60+Integer.parseInt(qty.elementAt(x).toString());
			}
			else if(acore.elementAt(x).toString().equals("90")){
				rating90=rating90+Integer.parseInt(qty.elementAt(x).toString());
			}
			else if(acore.elementAt(x).toString().equals("LLNR")){
				ratingllnr=ratingllnr+Integer.parseInt(qty.elementAt(x).toString());
			}
			else if(acore.elementAt(x).toString().equals("LL20")){
				ratingll20=ratingll20+Integer.parseInt(qty.elementAt(x).toString());
			}
		}
		if(ml.elementAt(x).toString().trim().length()>0){
			if(ml.elementAt(x).toString().equals("0")){
				ml0=ml0+Integer.parseInt(qty.elementAt(x).toString());
			}
			else if(ml.elementAt(x).toString().equals("1")){
				ml1=ml1+Integer.parseInt(qty.elementAt(x).toString());
			}
			else if(ml.elementAt(x).toString().equals("2")){
				ml2=ml2+Integer.parseInt(qty.elementAt(x).toString());
			}
		}

	}
	ResultSet rs2=stmt.executeQuery("select descript,qty from csquotes where order_no='"+q_no.elementAt(i).toString()+"' and block_id='b_lfk'");
	if(rs2 != null){
		while(rs2.next()){
			lkfinal=lkfinal+rs2.getInt(2);
			if(rs2.getString(1) != null && rs2.getString(1).indexOf("20 minute wood lip bead.")>=0){
				lktype1=lktype1+rs2.getInt(2);
			}
			if(rs2.getString(1) != null && rs2.getString(1).indexOf("Wood veneered metal lite kits.")>=0){
				lktype2=lktype2+rs2.getInt(2);
			}
			if(rs2.getString(1) != null && rs2.getString(1).indexOf("Wood lip lite bead in maple.")>=0){
				lktype3=lktype3+rs2.getInt(2);
			}
			if(rs2.getString(1) != null && rs2.getString(1).indexOf("Wood lite bead in maple")>=0){
				lktype4=lktype4+rs2.getInt(2);
			}
			if(rs2.getString(1) != null && rs2.getString(1).indexOf("Acrovyn wrapped metal lite frame kit.")>=0){
				lktype5=lktype5+rs2.getInt(2);
			}
			if(rs2.getString(1) != null && rs2.getString(1).indexOf("Metal primed lite frame kit.")>=0){
				lktype6=lktype6+rs2.getInt(2);
			}
			if(rs2.getString(1) != null && rs2.getString(1).indexOf("Galvanized lite bead.")>=0){
				lktype7=lktype7+rs2.getInt(2);
			}
			if(rs2.getString(1) != null && rs2.getString(1).indexOf("Lead lined lite bead.")>=0){
				lktype8=lktype8+rs2.getInt(2);
			}
			if(rs2.getString(1) != null && rs2.getString(1).indexOf("Painted metal lite kits.")>=0){
				lktype9=lktype9+rs2.getInt(2);
			}
			if(rs2.getString(1) != null && rs2.getString(1).indexOf("Stainless steel lite bead.")>=0){
				lktype10=lktype10+rs2.getInt(2);
			}

		}
	}
	rs2.close();
	ResultSet rs3=stmt.executeQuery("select linePrice from cs_ads_price_calc where model='global' and order_no='"+q_no.elementAt(i).toString()+"'");
	if(rs3 != null){
		while(rs3.next()){
			price=rs3.getString(1);
		}
	}
	rs3.close();
	ResultSet rs4=stmt.executeQuery("select descript,qty,bpcs_confirm from csquotes where order_no='"+q_no.elementAt(i).toString()+"' and block_id='a_core'");
	if(rs4 != null){
		while(rs4.next()){
			if(rs4.getString("bpcs_confirm") != null && rs4.getString("bpcs_confirm").trim().length()>0){
				cutouts=cutouts+rs4.getInt("bpcs_confirm");
			}
		}
	}
	rs4.close();
	output=output+"<tr>";
	output=output+"<td>"+q_no.elementAt(i).toString()+"</td>";
	output=output+"<td>"+qtyfinal+"</td>";
	output=output+"<td>"+price+"</td>";
	output=output+"<td>"+ratingnr+"</td>";
	output=output+"<td>"+rating20+"</td>";
	output=output+"<td>"+rating45+"</td>";
	output=output+"<td>"+rating60+"</td>";
	output=output+"<td>"+rating90+"</td>";
	output=output+"<td>"+ratingllnr+"</td>";
	output=output+"<td>"+ratingll20+"</td>";
	output=output+"<td>"+kpnfinal+"</td>";
	output=output+"<td>"+lkfinal+"</td>";
	output=output+"<td>"+cutouts+"</td>";
	output=output+"<td>"+lktype1+"</td>";
	output=output+"<td>"+lktype2+"</td>";
	output=output+"<td>"+lktype3+"</td>";
	output=output+"<td>"+lktype4+"</td>";
	output=output+"<td>"+lktype5+"</td>";
	output=output+"<td>"+lktype6+"</td>";
	output=output+"<td>"+lktype7+"</td>";
	output=output+"<td>"+lktype8+"</td>";
	output=output+"<td>"+lktype9+"</td>";
	output=output+"<td>"+lktype10+"</td>";
	output=output+"</tr>";
	output=output.replace(',',';');
	output=output.replaceAll("<td>","");
	output=output.replaceAll("</td>",",");
	output=output.replaceAll("<tr>","");
	output=output.replaceAll("</tr>","");
	out1.println(output);
	output="";
	String[] machining={" Cylindrical lockset.", " Deadbolts.", " Mortised card lock and raceway.", " Mortise lock.", " Roller catch.", " Butt hinges and pilot holes.", " Concealed door bottoms.", " Continuous hinges.", " Concealed overhead closers/holders/stops.", " Door pulls.", " Exit device holes.", " Electronic hinge.", " Electronic Power Transfer (Includes Raceway).", " Electronic raceways.", " Electronic strike.", " Finger pull cylindrical.", " Intermediate pivot hinge.", " Less bottom rod.", " Mortised exit devices.", " Pivots.", " Push plate.", " Push and pull bars.", " Rim type exit devices.", " Sentronic closers.", " Surface door bottoms.", " Surface vertical rod exit devices.", " Viewer.", " Wall magnets.", " Flushbolts.", " Machining by others."};
	int[] machining_count=new int[machining.length];
	for(int ii=0; ii<machining.length; ii++){
		for(int y=0; y<machine_notes.size(); y++){
			if(machine_notes.elementAt(y) != null && machine_notes.elementAt(y).toString().indexOf(machining[ii])>=0){
				machining_count[ii]=machining_count[ii]+Integer.parseInt(qty.elementAt(y).toString());
			}
		}

	}
	out1.println(" ");
	String[] cores={"NR","20","45","60","90","LL","LL 20"};
	int numsizes=0;
	ResultSet rs5=stmt.executeQuery("select count(distinct doorsize) from cs_ads_order_entry where quote_no='"+order_no+"'");
	if(rs5 != null){
		while(rs5.next()){
			numsizes=rs5.getInt(1);
		}
	}
	rs5.close();
	String[] sizes=new String[numsizes];
	int[] sizesQty=new int[numsizes];
	int count2=0;
	ResultSet rs6=stmt.executeQuery("select distinct doorsize from cs_ads_order_entry where quote_no='"+order_no+"' order by doorsize");
	if(rs6 != null){
		while(rs6.next()){
			sizes[count2]=rs6.getString(1);
			count2++;
		}
	}
	rs6.close();
	output=output+"<tr><td>MACHINE</td><td>QTY</td><td></td><td></td><td></td><td></td><td></td><td>STOCK SIZES USED</td>";
	for(int u=0; u<sizes.length; u++){
		output=output+"<td>"+sizes[u]+"</td>";
	}
	output=output+"</tr>";
	output=output.replace(',',';');
	output=output.replaceAll("<td>","");
	output=output.replaceAll("</td>",",");
	output=output.replaceAll("<tr>","");
	output=output.replaceAll("</tr>","");
	out1.println(output);
	output="";
	for(int t=0; t<machining.length; t++){
		output=output+"<tr>";
		output=output+"<td>"+machining[t]+"</td><td>"+machining_count[t]+"</td><td></td><td></td><td></td><td></td><td></td>";
		if(t<cores.length){
			int tempcount=0;
			output=output+"<td>"+cores[t]+"</td>";
			for(int r=0; r<sizes.length; r++){
				output=output+"<td>";
				for(int e=0; e<acore.size(); e++){
					if(cores[t].equals(acore.elementAt(e).toString()) && sizes[r].equals(doorsize.elementAt(e).toString())){
						tempcount=tempcount+Integer.parseInt(qty.elementAt(e).toString());
					}
				}
				output=output+tempcount+"</td>";
				tempcount=0;
			}
		}
		output=output+"</tr>";
		output=output.replace(',',';');
		output=output.replaceAll("<td>","");
		output=output.replaceAll("</td>",",");
		output=output.replaceAll("<tr>","");
		output=output.replaceAll("</tr>","");
		out1.println(output);
		output="";
	}
}
out1.close();
try{
	String product="ADS";
	//String host ="lebhq-notes02.c-sgroup.com";
	String host ="LEBHQ-SMTP01.c-sgroup.com";
	String from="noreply@c-sgroup.com";
	Properties prop =System.getProperties();
	prop.put("mail.smtp.host",host);
	Session ses1  = Session.getDefaultInstance(prop,null);
	MimeMessage msg = new MimeMessage(ses1);
	String valid_from = "";
        if(from.indexOf("@")>0){
              	valid_from = from.substring(from.indexOf("@"));
		if(valid_from.equals("@c-sgroup.com")){
			msg.addFrom(new InternetAddress().parse(from));
		}else{
			msg.addFrom(new InternetAddress().parse("no_reply_"+product.toLowerCase()+"@c-sgroup.com"));
		}
	} else {
		msg.addFrom(new InternetAddress().parse("no_reply_"+product.toLowerCase()+"@c-sgroup.com"));
	}
	msg.setReplyTo(new InternetAddress().parse(from));
	msg.addRecipients(Message.RecipientType.TO,new InternetAddress().parse(email));
	msg.setSubject("ADS CHANGE ORDER "+order_no);
	BodyPart messageBodyPart = new MimeBodyPart();
	File l_file = new File( "d:/transfer/ads/change"+order_no+".csv") ;
	String url3="file:///"+l_file;
	String filename=""+l_file;
	Multipart multipart = new MimeMultipart();
	DataSource source3 = new URLDataSource(new URL(url3));
	messageBodyPart.setDataHandler(new DataHandler(source3));
	messageBodyPart.setFileName(filename);
	multipart.addBodyPart(messageBodyPart);
	msg.setContent(multipart);
	messageBodyPart = new MimeBodyPart();
	Transport.send(msg);
	out.println(" An eMail will be sent<br>to the following recipients:<br><br><b>To: "+email+"<br>");
}
catch(javax.mail.internet.AddressException ae){
	ae.printStackTrace();
	out.println(ae);
}
catch(javax.mail.MessagingException me){
	me.printStackTrace();
	out.println(me);
}
stmt.close();
myConn.close();
 }
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>