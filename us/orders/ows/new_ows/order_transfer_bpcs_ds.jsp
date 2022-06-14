<%
String final_ds_out="";
String refType="C";
String wherexValue = "";
Vector refNoV=new Vector();
Vector docAppV=new Vector();
Vector wherexV=new Vector();
ResultSet rsORD=stmt.executeQuery("select email,bpcs_cust_no from cs_billed_customers where order_no='"+order_no+"'");
if(rsORD != null){
	while(rsORD.next()){
		if(rsORD.getString(1)!=null && rsORD.getString(1).trim().length()>0){
			docAppV.addElement("ORD");
			wherexV.addElement(rsORD.getString(1));
			refNoV.addElement(rsORD.getString(2));
		}
	}
}
rsORD.close();
ResultSet rsINV=stmt.executeQuery("select email,bpcs_cust_no from cs_invoice where order_no='"+order_no+"'");
if(rsINV != null){
	while(rsINV.next()){
		if(rsINV.getString(1)!=null && rsINV.getString(1).trim().length()>0){
			docAppV.addElement("BIL");
			wherexV.addElement(rsINV.getString(1));
			refNoV.addElement(rsINV.getString(2));
		}
	}
}
rsINV.close();
ResultSet rsSHP=stmt.executeQuery("select email,bpcs_cust_no from shipping where order_no='"+order_no+"'");
if(rsSHP != null){
	while(rsSHP.next()){
		if(rsSHP.getString(1)!=null && rsSHP.getString(1).trim().length()>0){
			docAppV.addElement("SHP");
			wherexV.addElement(rsSHP.getString(1));
			refNoV.addElement(rsSHP.getString(2));
		}
	}
}
rsSHP.close();
for(int emailcounter=0; emailcounter<docAppV.size(); emailcounter++){
	String docApp=docAppV.elementAt(emailcounter).toString();
	String wherex=wherexV.elementAt(emailcounter).toString();
	String refNo=refNoV.elementAt(emailcounter).toString();
	if(docApp.length()<3){
		String tv="";
		for(int v=0;v<(3-docApp.length());v++){
			tv=" "+tv;
		}
		docApp=docApp+tv;
	}
	if(refNo.length()<6){
		String tv="";
		for(int v=0;v<(6-refNo.length());v++){
			tv="0"+tv;
		}
		refNo=tv+refNo;
	}
	if(wherex.length()<50){
		String tv="";
		for(int v=0;v<(50-wherex.length());v++){
			tv=" "+tv;
		}
		wherex=wherex+tv;
	}
	
	
	wherexValue = wherex.toUpperCase();
	
	final_ds_out=final_ds_out+"FD"+order_no+docApp+refType+refNo+wherexValue+"\r\n";
}
%>