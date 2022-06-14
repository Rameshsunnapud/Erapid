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
//out.println("out"+rows_l);
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
//  out.println(order_no+"elogia:"+rows_l+"<br>"+"PSA:"+rows_p+"<br>");
/*
if (rows_p>0 ){
		try
			{
				int nrow= stmt_psa.executeUpdate("delete from dba.cs_quotes WHERE quote_no = '"+order_no+"'");
			}
			catch (java.sql.SQLException e)
			{
				out.println("Problem with deleting CSquotestable"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
//				myConn.rollback();
				out.println(e.toString());
				return;
			}
out.println("<font size='2.5' color='Blue'><b>"+"The Data already existing in PSA, has been Removed.<br> "+"</b></font>");
}
*/
if (rows_l<=0 ){out.println("<font size='3.5' color='Red'><b>"+"There is no Datamanager Output for this Quote,make sure to run Datamanger before you proceed"+"</b></font>");}
else if (rows_p > 0 ){out.println("<font size='3.5' color='Red'><b>"+"This Quote Number already exists in PSA. <br> Remove it from PSA before you update it"+"</b></font>");}
else{
Vector c1 =new Vector();Vector c2 =new Vector();Vector c3 =new Vector();
Vector c4 =new Vector();Vector c5 =new Vector();Vector c6 =new Vector();
Vector c7 =new Vector();Vector c8 =new Vector();Vector c9 =new Vector();
Vector c10 =new Vector();Vector c11 =new Vector();Vector c12 =new Vector();
Vector c13 =new Vector();double t=0;

//	out.println("the total"+t);
// FROM dba.cs_project
String overage="";String handling_cost="";String freight_cost="";String product="";String commission="";String config_price="";String setup_cost="";
java.sql.Statement stmt_project = myConn.createStatement();
		ResultSet rs_project = stmt_project.executeQuery("SELECT product_id,configured_price,overage,handling_cost,freight_cost,setup_cost,commission FROM cs_project where order_no='"+order_no+"' ");
		if (rs_project !=null) {
         while (rs_project.next()) {
		  product= rs_project.getString(1);
		  config_price =rs_project.getString(2);
		  overage =rs_project.getString(3);
		  handling_cost =rs_project.getString(4);
		  freight_cost =rs_project.getString(5);
		  setup_cost =rs_project.getString(6);
		 commission= rs_project.getString("commission");
		 }
		}
		rs_project.close();
		stmt_project.close();
		if(overage==null){overage="0";}if( handling_cost==null){ handling_cost="0";}if(freight_cost==null){freight_cost="0";}
		if(config_price==null){config_price="0";}if( setup_cost==null){ setup_cost="0";}
		if(commission==null){commission="0";}
		commission=""+(new Double(commission).doubleValue()/100+1);
		double misc_total=Double.parseDouble(overage)+Double.parseDouble(handling_cost)+Double.parseDouble(freight_cost)+Double.parseDouble(config_price)+Double.parseDouble(setup_cost);
/*
try
	{
		java.sql.Statement s1 = myConn.createStatement();
		ResultSet rsn = s1.executeQuery("SELECT cast(CSQUOTES.descript as varchar(700)) as a1,CAST (SUM(cast (QTY as decimal)) AS INTEGER),uom,sum(cast(extended_price as decimal)) FROM CSQUOTES where order_no = '"+order_no+"' and block_id != 'a_aproduct' and cast(CSQUOTES.descript as varchar(700))!='' GROUP BY cast(CSQUOTES.descript as varchar(700)),UOM  ");
		while(rsn.next()){
		rows++;
		c1.addElement(order_no);
		c2.addElement(rows+"");
		c3.addElement("GCP");
		c4.addElement(rsn.getString("a1"));
		c5.addElement(""+new Double(rsn.getString(4)).doubleValue()*new Double(commission).doubleValue());
		c6.addElement("CSE");
		c7.addElement("1");
		c8.addElement(rsn.getString(3));
		c10.addElement(rsn.getString(2));
		t=t+Double.parseDouble(rsn.getString(4));
        }
        rsn.close();
	}
	catch (java.sql.SQLException e)	{
		out.println("Problem with Entering erapid Data BAse");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		out.println(e.toString());
		return;
	}*/

//out.println("::"+misc_total+" HERE"+commission);

// from porject done
String psaseq="";
//for (int i=0;i<rows;i++){
try{
	    psaseq=(new Integer((1)).toString());
		for(int x=0;x<(6-(psaseq.length()));x++){
			psaseq="0"+psaseq;
		}
		String updateString ="INSERT INTO dba.cs_quotes (PSA_SEQ,QUOTE_NO,LINE_NO,PRODUCT_ID,DESCRIPTION,LINE_TOTAL,BLOCK_ID,SEQUENCE_NO,UNITS,CURRENCY_ID,QTY,WEIGHT,WEIGHT_UNIT,BID_TYPE)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
		java.sql.PreparedStatement updateSales = myConn_psa.prepareStatement(updateString);
		updateSales.setString(1,psaseq);
		updateSales.setString(2,order_no);//quote_no
		updateSales.setString(3,"1");//line_no
		updateSales.setString(4,product);//product_id
		updateSales.setString(5,"Quote total");//descript
		updateSales.setDouble(6,misc_total);//price
		updateSales.setString(7,"SUMMARY");//block_id
		updateSales.setDouble(8,1);//sequence no
        updateSales.setString(9,"EA");//units
		updateSales.setString(10,"007");//cuurency
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
		myConn_psa.rollback();
		out.println(e.toString());
		return;
	}

//}

myConn_psa.commit();


out.println("<font size='3.5' color='Blue'><b>"+"The Data for this has been Transfered to PSA"+"</b></font>");

}
//s1.close();
stmt.close();
stmt_psa.close();
myConn_psa.close();
myConn.close();

 }
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>