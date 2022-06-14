<%@ page language="java"  contentType="text/html; charset=UTF-8" import="jcifs.smb.*" import="java.nio.charset.Charset" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" import="javax.mail.*" import="java.util.*" import="java.math.*" import="java.sql.*" import="javax.mail.internet.*" import="javax.activation.*" import="java.net.*" import="java.text.*" import="org.zefer.pd4ml.PD4ML" import="org.zefer.pd4ml.PD4Constants" import="java.awt.Insets" errorPage="error.jsp" %>
<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<script language="JavaScript">
var count=0;
function openWindow(){
	if(count<document.form1.orderNo.length){
		var globalUpdate= document.form1.cpqServerName.value+"/cse/cfglauncher?cmd=CI&cwf=true&csc=true&readonly=true&qt=L&revision=1&username="+document.form1.userId[count].value+"&pid=SYS_GCH&orderno="+document.form1.orderNo[count].value+"&item_no=1000&subline_no=0&doc_type="+document.form1.qtype[count].value+"&detail1=DATA|ORDER|"+document.form1.orderNo[count].value+"&detail2=DATA|TYPE|OU&detail3=DATA|PID|"+document.form1.product[count].value+"&canurl=http://google.com&returl=http://google.com";
		win2=window.open(globalUpdate,"x2","");
		count=count+1;
		isClosed();
	}
	else{
		self.close();
	}
}
function isClosed(){
	if (!win2.closed){
		setTimeout("isClosed()",1000);
	}
	else{
		openWindow();
	}		
}
</script>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
	%>
	<%@ include file="../db_con.jsp"%>
	<%
	String dirPath="D:\\erapid\\scheduled\\log\\";  
    	File dir = new File(dirPath);    
    	File[] files = dir.listFiles();    
    	if (files == null || files.length == 0) {
      		out.println("no files");
    	}
    	File lastModifiedFile = files[0];
    	for (int i = 1; i < files.length; i++) {
       		if (lastModifiedFile.lastModified() < files[i].lastModified()) {
           		lastModifiedFile = files[i];
       		}
    	}
	StringBuilder contentBuilder = new StringBuilder();
	BufferedReader br = new BufferedReader(new FileReader(lastModifiedFile));
    	String orders="";
    	String sCurrentLine;
    	String orderHTML="";
    	while ((sCurrentLine = br.readLine()) != null){
		contentBuilder.append(sCurrentLine).append("\n");
		int i=sCurrentLine.indexOf("::order no");
                int x=sCurrentLine.indexOf("::")+2;
                if(i>0&&x>0){
                	orders=orders+sCurrentLine.substring(x,i).trim()+",";
                }
	}
	if(orders.length()>0){
		orders=orders.substring(0,orders.length()-1);
		orders="'"+orders+"'";
		orders=orders.replaceAll(",","','");
		//REMOVE THIS CODE		
		orders="'212415_00','212413_00','212412_00','212408_00','212379_00','212378_00','212377_00','212341_00'";		
		//end remove this code
		ResultSet rs1=stmt.executeQuery("select Order_no,product_id, user_id, quote_type from cs_project where order_no in ("+orders+") and product_id='ads'");
		if(rs1 != null){
			while(rs1.next()){
				orderHTML=orderHTML+"<input type='text' name='orderNo' value='"+rs1.getString(1)+"'>";
				orderHTML=orderHTML+"<input type='hidden' name='product' value='"+rs1.getString(2)+"'>";
				orderHTML=orderHTML+"<input type='hidden' name='userId' value='"+rs1.getString(3)+"'>";
				orderHTML=orderHTML+"<input type='hidden' name='qtype' value='"+rs1.getString(4)+"'>";
			}
		}
		rs1.close();
    	}
%>
<body onload="openWindow()">
<form name='form1'>
<%=orderHTML%>
<input type='hidden' name='cpqServerName' value='<%=erapidBean.getCpqServerName()%>'>
</form>
</body>
<%
}
catch(Exception e){
	out.println("ERROR::"+e);
}
%>