
<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<%@ page language="java" import="java.sql.*" import="java.util.*" errorPage="error.jsp" %>
<%@ include file="../../../db_con_psa.jsp"%>
<%@ include file="../../../db_con.jsp"%>
<%
String order_no = request.getParameter("orderNo");

int rows=0;
int rows_p=0;
int rows_l=0;

//elogiadev table checking
try
	{
		java.sql.Statement s2 = myConn.createStatement();
		String elogia="SELECT count(*) FROM csquotes where ORDER_NO ='"+order_no+"'";
		java.sql.ResultSet rs = s2.executeQuery(elogia);
		while(rs.next()){
		rows_l =  rs.getInt(1);
						}
						rs.close();
	}
catch (java.sql.SQLException e)
	{
		out.println("Probelm with Getting if the quote exists in erapid table ");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		out.println(e.toString());
		return;
	}

//psa table checking
try
	{
		java.sql.Statement s1 = myConn_psa.createStatement();
		String psa="SELECT count(*) from dba.cs_quotes where QUOTE_NO ='"+order_no+"'";
		java.sql.ResultSet rs = s1.executeQuery(psa);
		while(rs.next()){
		rows_p =  rs.getInt(1);

						}
						rs.close();
	}
catch (java.sql.SQLException e)
	{
		out.println("Probelm with Getting if the order exists in PSA ");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		out.println(e.toString());
		return;
	}
//  out.println(order_no+"elogia:"+rows_l+"<br>"+"PSA:"+rows_p+"<br>");

if (rows_l<=0 ){out.println("<font size='3.5' color='Red'><b>"+"There is no data for this quote.  Please run Global Updates and try again."+"</b></font>");}
else if (rows_p > 0 ){
	myConn_psa.setAutoCommit(false);
	try{
		String psaDelete="delete from dba.cs_quotes where quote_no='"+order_no+"'";
			int rsDelete=stmt_psa.executeUpdate(psaDelete);
	}
	catch (java.sql.SQLException e){
		out.println("Problem with deleting from cs_ge_vendor_items table");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn_psa.rollback();
		out.println(e.toString());
		return;
	}
	myConn_psa.commit();
//	out.println("<font size='3.5' color='Red'><b>"+"Record cleared from PSA<BR>"+"</b></font>");

}
//else{
if(rows_l >0){
//out.println( "insert in psa to commence");
double totalPrice=0;
	Vector c1 =new Vector();
	Vector c2 =new Vector();
	Vector c3 =new Vector();
	Vector c4 =new Vector();
	Vector c5 =new Vector();
	Vector c6 =new Vector();
	Vector c7 =new Vector();
	Vector c8 =new Vector();
	Vector c9 =new Vector();Vector c10 =new Vector();Vector c11 =new Vector();Vector c12 =new Vector();
	Vector c13 =new Vector();
	String s1="";	String s2="";
	try
		{
//			ResultSet rsSum=stmt.executeQuery("select (SELECT sum(cast(extended_price as decimal))FROM CSQUOTES where order_no='"+order_no+"' and product_id!='GE') as v1,(SELECT sum(cast(Extended_Price  as numeric)*cast(field19 as numeric))FROM CSQUOTES where order_no='"+order_no+"' and product_id='GE' and not block_id='b_notes') as v2 FROM CSQUOTES where order_no='"+order_no+"'  order by cast(Line_no as integer)" );
			ResultSet rsSum=stmt.executeQuery("SELECT sum(cast(extended_price as decimal))FROM CSQUOTES where order_no='"+order_no+"'") ;
			if(rsSum != null){
				while(rsSum.next()){
//					totalPrice=(new Double(rsSum.getString(3)).doubleValue());
					s1=	rsSum.getString(1);
				//	s2= rsSum.getString(2);
					totalPrice=(new Double(rsSum.getString(1)).doubleValue());
					//if(s2==null){totalPrice=(new Double(rsSum.getString(1)).doubleValue());}
				}
			}
			rsSum.close();

	}
	catch (java.sql.SQLException e)	{
		out.println("Problem with Entering erapid Data BAse");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		out.println(e.toString());
		return;
	}

//	out.println(totalPrice +":: total price2<BR>");
// FROM cs_project
String overage="";String handling_cost="";String freight_cost="";String product="";
java.sql.Statement stmt_project = myConn.createStatement();
		ResultSet rs_project = stmt_project.executeQuery("SELECT product_id,overage,handling_cost,freight_cost FROM cs_project where order_no='"+order_no+"' ");
		if (rs_project !=null) {
         while (rs_project.next()) {
		  product= rs_project.getString(1);
		  overage =rs_project.getString(2);
		  handling_cost =rs_project.getString(3);
		  freight_cost =rs_project.getString(4);
		 }
		}
		rs_project.close();
double misc_total=Double.parseDouble(overage)+Double.parseDouble(handling_cost)+Double.parseDouble(freight_cost)	;
totalPrice=totalPrice+misc_total;
//out.println(totalPrice +":: total price3<BR>");
stmt_project.close();
// from porject done

String psaseq="";
//for (int i=0;i<rows;i++){
try{
	    psaseq=(new Integer((2)).toString());
		for(int x=0;x<(6-(psaseq.length()));x++){
			psaseq="0"+psaseq;
		}
		String updateString ="INSERT INTO dba.cs_quotes (PSA_SEQ,QUOTE_NO,LINE_NO,PRODUCT_ID,DESCRIPTION,LINE_TOTAL,BLOCK_ID,SEQUENCE_NO,UNITS,CURRENCY_ID,QTY,WEIGHT,WEIGHT_UNIT,BID_TYPE)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
		java.sql.PreparedStatement updateSales = myConn_psa.prepareStatement(updateString);
		updateSales.setString(1,psaseq);
		updateSales.setString(2,order_no);
		updateSales.setString(3,"1");
		updateSales.setString(4,"GE");
		updateSales.setString(5,"Quote total");
		updateSales.setDouble(6,totalPrice);
		updateSales.setString(7,"SUMMARY");
		updateSales.setDouble(8,1);
		updateSales.setString(9,"EA");
		updateSales.setString(10,"007");
		updateSales.setString(11,"1");
		updateSales.setString(12,"0");
		updateSales.setString(13,"LB");
		updateSales.setString(14,"BASE");
		int rocount = updateSales.executeUpdate();
		updateSales.close();
	}
	catch (java.sql.SQLException e)
	{
		out.println("Problem with Entering PSA Data BAse");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}
psaseq="";


myConn.commit();


out.println("<font size='3.5' color='Blue'><b>"+"The Data for this Quote is Transfered to PSA"+"</b></font>");

}

myConn_psa.commit();
stmt_psa.close();
stmt.close();
myConn.close();
myConn_psa.close();

 }
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>
