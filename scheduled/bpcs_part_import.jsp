<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>

<%@ page language="java"  import="java.sql.*"  import="java.text.*"  import="java.util.*" errorPage="error.jsp" %>
<%@ include file="../db_con.jsp"%>
<%@ include file="../db_con_bpcsusrmm.jsp"%>
<%
myConn.setAutoCommit(false);
Vector PRCITM=new Vector();
Vector PRCCST=new Vector();
Vector PRCSBU=new Vector();
Vector PRCSUM=new Vector();
Vector PRCWGT=new Vector();
Vector PRCBAL=new Vector();
Vector PRCDSC=new Vector();
Vector PRCDS2=new Vector();
String query1="Select PRCITM,PRCCST,PRCSBU,PRCSUM,PRCWGT,PRCBAL,PRCDSC,PRCDS2 from PRC001PF order by PRCSBU,PRCITM";
ResultSet rsUsedItems=stmt_bpcsusrmm.executeQuery(query1);
if(rsUsedItems != null){
	while(rsUsedItems.next()){
		PRCITM.addElement(rsUsedItems.getString("PRCITM"));
		PRCCST.addElement(rsUsedItems.getString("PRCCST"));
		PRCSBU.addElement(rsUsedItems.getString("PRCSBU"));
		PRCSUM.addElement(rsUsedItems.getString("PRCSUM"));
		PRCWGT.addElement(rsUsedItems.getString("PRCWGT"));
		PRCBAL.addElement(rsUsedItems.getString("PRCBAL"));
		PRCDSC.addElement(rsUsedItems.getString("PRCDSC"));
		PRCDS2.addElement(rsUsedItems.getString("PRCDS2"));
	}
}
rsUsedItems.close();
if(PRCITM.size()>0){
	int rsDelete=stmt.executeUpdate("delete from cs_prc001pf");
	myConn.commit();
	for(int i=0; i<PRCITM.size(); i++){
		try{
			String insert ="INSERT INTO cs_prc001pf(prcitm,prccst,prcsbu,prcsum,prcwgt,prcbal,prcdsc,prcds2) VALUES(?,?,?,?,?,?,?,?) ";
			PreparedStatement update_customer = myConn.prepareStatement(insert);
			update_customer.setString(1,PRCITM.elementAt(i).toString() );
			update_customer.setString(2,PRCCST.elementAt(i).toString() );
			update_customer.setString(3,PRCSBU.elementAt(i).toString() );
			update_customer.setString(4,PRCSUM.elementAt(i).toString() );
			update_customer.setString(5,PRCWGT.elementAt(i).toString() );
			update_customer.setString(6,PRCBAL.elementAt(i).toString() );
			update_customer.setString(7,PRCDSC.elementAt(i).toString() );
			update_customer.setString(8,PRCDS2.elementAt(i).toString() );
			int rocount = update_customer.executeUpdate();
			update_customer.close();
		}
		catch (java.sql.SQLException e){;
			out.println("Problem with ENTERING TO shipping"+"<br>");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}
		myConn.commit();
	}
}
stmt_bpcsusrmm.close();
con_bpcsusrmm.close();
stmt.close();
myConn.close();
%>
<body onload='javascript:window.close();'>
<%
	}
	  catch(Exception e){
		out.println("ERROR::"+e);
	  }
			%>