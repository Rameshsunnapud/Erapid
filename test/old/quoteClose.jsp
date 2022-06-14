
<%

	String xx="";	
try{
	File transfer= new File("d:/Transfer/login.log");
	FileReader in=new FileReader(transfer);
	int c;

	boolean write=false;
	while((c=in.read()) != -1){

		if(c == 93){
			write=false;
		}
		if(write){
			xx=xx+(char)c;
		}
		if(c == 91){
			write=true;
			xx="";
		}
	}
	in.close();
	//out.println(xx);
}
catch(Exception e){
	out.println(e);
}

java.util.Date dateLast= new java.util.Date(xx);
//out.println(dateLast);
String dateLastx=(dateLast.getMonth()+1)+"/"+dateLast.getDate()+"/"+(dateLast.getYear()+1900);
java.util.Date date=new java.util.Date();
String datex="";
datex=(date.getMonth()+1)+"/"+date.getDate()+"/"+(date.getYear()+1900);
java.util.Date dateLastFinal=new java.util.Date(dateLast.getMonth(),dateLast.getDate(),dateLast.getYear());
java.util.Date dateFinal=new java.util.Date(date.getMonth(),date.getDate(),date.getYear());

if(dateFinal.after(dateLastFinal)){
	//out.println(" <table border='1'>");
	ResultSet rsStatus=stmt.executeQuery("Select count(*) from doc_header where expires_date < '"+datex+"' and win_loss = 'OPEN' ");
	if(rsStatus != null){
		while(rsStatus.next()){
			//out.println("<tr><td>"+rsStatus.getString(1)+"</td></tr>");
		}
	}
	rsStatus.close();
	//out.println("</table>");
	
	String update ="update doc_header set win_loss ='CLOSE' WHERE doc_number in (Select doc_number from doc_header where expires_date < '"+datex+"' and win_loss = 'OPEN' and doc_customer like 'PL%')";
	//out.println(update);
	
	PreparedStatement update_status = myConn.prepareStatement(update);
	int rocount = update_status.executeUpdate();
	update_status.close();
	
	//out.println(rocount);
}

%>
