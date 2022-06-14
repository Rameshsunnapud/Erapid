<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="../../../db_con_psa.jsp"%>
<%@ include file="../../../db_con.jsp"%>
<%
String order_no = request.getParameter("orderNo");
myConn.setAutoCommit(false);
int rows=0;
int rows_p=0;
int rows_l=0;

//elogiadev table checking
try
	{
		//java.sql.Statement s2 = myConn1.createStatement();
		String elogia="SELECT count(*) FROM csquotes where ORDER_NO ='"+order_no+"'";
		java.sql.ResultSet rs = stmt.executeQuery(elogia);
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
//		//java.sql.Statement s1 = myConn.createStatement();
		String psa="SELECT count(*) from dba.cs_quotes where QUOTE_NO ='"+order_no+"'";
		java.sql.ResultSet rs = stmt_psa.executeQuery(psa);
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

if (rows_l<=0 ){out.println("<font size='3.5' color='Red'><b>"+"There is no data for this quote.  Please run Global Updates and try again."+"</b></font>");}
//else if (rows_p > 0 ){out.println("<font size='3.5' color='Red'><b>"+"This Quote Number already exists in PSA. <br> Remove it from PSA before you update it"+"</b></font>");}
else{


//cs_quote_Sections
int sections=0;String section_info="";String section_group="";int count_line=0;Vector items=new Vector();
try
	{
		//java.sql.Statement s_sect = myConn1.createStatement();
		String cs_quote_sect="SELECT * FROM cs_quote_sections where ORDER_NO ='"+order_no+"'";
		java.sql.ResultSet rs = stmt.executeQuery(cs_quote_sect);
		while(rs.next()){
		section_info =  rs.getString(2);
		sections =  rs.getInt(3);
		section_group =  rs.getString(4);
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
	//java.sql.Statement stmt_eitems = myConn1.createStatement();
    ResultSet rs5 = stmt.executeQuery("SELECT * FROM doc_line where doc_number like '"+order_no+"' order by cast(doc_line as integer)");
	if (rs5!=null){
	while(rs5.next()){
	items.addElement(rs5.getString("doc_line"));
	count_line++;
				 }
				 }
				 rs5.close();

//sections
int desc_count=0;String desc_value="";String var="";
Vector sect_name=new Vector();Vector sect_value=new Vector();
Vector sect_group=new Vector();Vector sect_group_lines=new Vector();//final description
	if(sections<=0){
	sect_group.addElement("BASE");
//	out.println("Testing"+sect_group.elementAt(0).toString());
	}
	else{
		// line groups
		for(int i=0;i<sections;i++){
			desc_count=i+1;
			var="s"+desc_count+"=";
			int config_s1= section_info.indexOf(var);
			if(config_s1>=0){
			int config_s2=section_info.indexOf(";",config_s1+1);
			desc_value=section_info.substring(config_s1+var.length(),config_s2);
			}else{desc_value="";}
			sect_name.addElement("s"+desc_count);sect_value.addElement(desc_value);
		}
		desc_count=0;var="";desc_value="";String group_sect="";String group_line="";
			 for(int j=0;j<sections;j++){
				for(int kl=0;kl<count_line;kl++){
					var=items.elementAt(kl).toString()+"=";
					int config_s1= section_group.indexOf(var);
					if(config_s1>=0){
					int config_s2=section_group.indexOf(";",config_s1+1);
					desc_value=section_group.substring(config_s1+var.length(),config_s2);
					}else{desc_value="";}
					if(desc_value.equals(sect_name.elementAt(j).toString())){
						 if(group_line.trim().length()>0){
						group_line=group_line+","+items.elementAt(kl).toString();
						}
						else{
						group_line=group_line+items.elementAt(kl).toString();
						}
					}
				}
			sect_group.addElement(sect_value.elementAt(j).toString());sect_group_lines.addElement(group_line);
				group_line="";
			 }
	}//if sections not 0

//Begin the quote data
		Vector c1 =new Vector();Vector c2 =new Vector();Vector c3 =new Vector();Vector c4 =new Vector();Vector c5 =new Vector();
		Vector c6 =new Vector();Vector c7 =new Vector();Vector c8 =new Vector();Vector c9 =new Vector();Vector c10 =new Vector();Vector c11 =new Vector();
		//line item pricing
		Vector  line_item_group =new Vector();Vector line_sum_group =new Vector();double tot_sum=0;int k=0;double tot_sum_group=0;
		String overage="";String line_cost="";double totprice=0;String handling_cost="";String freight_cost="";String product="";
		//Getting the data for the line item pricing
		//java.sql.Statement stmt_sum = myConn1.createStatement();
		//java.sql.Statement stmt_project = myConn1.createStatement();
		ResultSet rs_csquotes_sum = stmt.executeQuery("SELECT line_no, sum(cast(extended_price as decimal)) FROM CSQUOTES where order_no='"+order_no+"' group by line_no order by cast(Line_no as integer)");
		if (rs_csquotes_sum !=null) {
         while (rs_csquotes_sum.next()) {
		 line_item_group.addElement(rs_csquotes_sum.getString(1));
		 line_sum_group.addElement(rs_csquotes_sum.getString(2));
		 tot_sum=tot_sum+new Double(rs_csquotes_sum.getString(2)).doubleValue();
		 k++;
//		 out.println("tot_sum"+tot_sum+"<br>");
		 }
		}
		rs_csquotes_sum.close();
		ResultSet rs_project = stmt.executeQuery("SELECT product_id,overage,handling_cost,freight_cost FROM cs_project where order_no='"+order_no+"' ");
		if (rs_project !=null) {
         while (rs_project.next()) {
         product= rs_project.getString(1);
		  overage =rs_project.getString(2);
		  handling_cost =rs_project.getString(3);
		  freight_cost =rs_project.getString(4);
		 }
		}
		rs_project.close();
//End the quote data
double price_line_one=0.0;double grand_total=0.0;
double extra_charges=new Double(overage).doubleValue()+new Double(handling_cost).doubleValue()+new Double(freight_cost).doubleValue();
grand_total=tot_sum+extra_charges;
int tr=0;
   for(int ye=0;ye<sect_group.size();ye++){
//   out.println("THE group is "+sect_group.elementAt(ye).toString()+"The lines are"+sect_group_lines.elementAt(ye).toString()+"<br>");
		try
			{
				//java.sql.Statement s1 = myConn1.createStatement();
//				java.sql.ResultSet rsn=stmt.executeQuery("select * from csquotes where order_no='"+order_no+"' and Block_ID !='A_APRODUCT'and Block_ID like 'A%' and line_no in("+sect_group_lines.elementAt(ye).toString()+") order by cast(Line_no as integer)" );
				String stat1="";
				if(sections==0){
				stat1="select * from csquotes where order_no='"+order_no+"' and Block_ID !='A_APRODUCT' and Block_ID like 'A%'  order by cast(Line_no as integer)" ;
				}
				else{
				stat1="select (select sum(cast(extended_price as decimal)) from csquotes where order_no='"+order_no+"' and Block_ID !='A_APRODUCT' and Block_ID like 'A%'  and line_no in("+sect_group_lines.elementAt(ye).toString()+")), * from csquotes where order_no='"+order_no+"' and Block_ID !='A_APRODUCT' and Block_ID like 'A%'  and line_no in("+sect_group_lines.elementAt(ye).toString()+") order by cast(Line_no as integer)";
				}
				java.sql.ResultSet rsn=stmt.executeQuery(stat1);
				while(rsn.next()){
				tr++;
				rows++;
//				out.println("Test");
				c1.addElement(rsn.getString("ORDER_NO"));
				String line_no_cs=rsn.getString("LINE_NO");
				c2.addElement((new Integer(rows)));
				c3.addElement(rsn.getString("PRODUCT_ID"));
				c4.addElement(rsn.getString("DESCRIPT"));
				for (int n=0;n<k;n++){
					if (line_item_group.elementAt(n).toString().equals(line_no_cs)){
					line_cost=line_sum_group.elementAt(n).toString();
					BigDecimal d1 = new BigDecimal(line_cost);
					BigDecimal d2 = new BigDecimal(tot_sum);//total configured price
					BigDecimal d3_o = new BigDecimal(new Double(overage).doubleValue()+new Double(handling_cost).doubleValue()+new Double(freight_cost).doubleValue());
					BigDecimal d3 = d1.divide(d2,BigDecimal.ROUND_HALF_UP);
					BigDecimal d4 = d3.multiply(d3_o);
//					d4 = d4.setScale(0, BigDecimal.ROUND_HALF_UP);
//					d1 = d1.setScale(0, BigDecimal.ROUND_HALF_UP);
					BigDecimal d_finalprice =new BigDecimal(d1.doubleValue()+d4.doubleValue());
					d_finalprice = d_finalprice.setScale(0, BigDecimal.ROUND_HALF_UP);
					totprice=d_finalprice.doubleValue();
//					totprice=(new Double(line_cost)).doubleValue()+d4.doubleValue();
//				out.println("lineno"+line_no_cs+" Tot "+totprice+"line cost:"+d1.doubleValue()+"totsum:"+tot_sum+"d3_0:"+d3_o.doubleValue()+"Overage:"+overage+"handling:"+handling_cost+"freight:"+freight_cost+"<br>");
					}
				}
//				c5.addElement(rsn.getString("Extended_Price"));
				c5.addElement(new String().valueOf(totprice));
				c6.addElement(rsn.getString("BLOCK_ID"));
				c7.addElement(rsn.getString("SEQUENCE_NO"));
//				String qty_=rsn.getString("QTY");
//		   		out.println(tot_sum_group+"tr"+"<br>");
				c10.addElement(rsn.getString("QTY"));
				c11.addElement(rsn.getString("UoM"));
				if(sections>0){
					if(tr==1){c8.addElement(sect_group.elementAt(ye).toString());
					BigDecimal dnew = new BigDecimal(-(grand_total- (rsn.getDouble(1))-((rsn.getDouble(1)*extra_charges)/tot_sum) ));
							dnew = dnew.setScale(0, BigDecimal.ROUND_HALF_UP);
							c9.addElement(dnew.toString());
//							c9.addElement(new String().valueOf(-(tot_sum-rsn.getDouble(1)) ));
	//						 price_line_one=price_line_one+totprice;
	//						tot_sum_group=0;
					}else{c8.addElement("");
					c9.addElement("0");
					}
				}
				else{c9.addElement("0");
					if(tr==1){c8.addElement(sect_group.elementAt(ye).toString());}
					else{c8.addElement("");}
				}
			  }
			  rsn.close();
			}
			catch (java.sql.SQLException e)	{
				out.println("Problem with Entering CSquotes Data BAse");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				out.println(e.toString());
				return;
			}
			tr=0;
   }// The for Loop

//   for(int y=0;y<rows;y++){
//   out.println("test"+c9.elementAt(y));
 //  }
   // IOnserting into csquotes
//   	if(sections>0){
 //     	c9.removeElementAt(0);
//		c9.add(0,new String().valueOf(-price_line_one));//adding the first line's subtract total;   // IOnserting into csquotes
	//}

		String psaseq="";
		for (int i=0;i<rows;i++){
		try{
			    psaseq=(new Integer((i+1)).toString());
				for(int x=0;x<(6-(psaseq.length()));x++){
					psaseq="0"+psaseq;
				}
				String updateString ="INSERT INTO dba.cs_quotes (PSA_SEQ,QUOTE_NO,LINE_NO,PRODUCT_ID,DESCRIPTION,LINE_TOTAL,BLOCK_ID,SEQUENCE_NO,UNITS,CURRENCY_ID,QTY,WEIGHT,WEIGHT_UNIT,BID_TYPE)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
				java.sql.PreparedStatement updateSales = myConn_psa.prepareStatement(updateString);
				updateSales.setString(1,psaseq);
				updateSales.setString(2,(c1.elementAt(i).toString()));
				updateSales.setString(3,(c2.elementAt(i).toString()));
				updateSales.setString(4,(c3.elementAt(i).toString()));
				updateSales.setString(5,(c4.elementAt(i).toString()));
				updateSales.setDouble(6,(new Double((c5.elementAt(i).toString())).doubleValue()));
				updateSales.setString(7,(c6.elementAt(i).toString()));
				updateSales.setDouble(8,(new Double((c7.elementAt(i).toString())).doubleValue()));
			   updateSales.setString(9,(c11.elementAt(i).toString()));
				updateSales.setString(10,"007");
				updateSales.setString(11,(c10.elementAt(i).toString()));
				updateSales.setString(12,(c9.elementAt(i).toString()));
				updateSales.setString(13,"LB");
				updateSales.setString(14,(c8.elementAt(i).toString()));//bid type
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
		}

   //Insereting into csquotes done



//out.println("test"+c1.size());
myConn.commit();
out.println("<font size='3.5' color='Blue'><b>"+"The Data for this has been Transfered to PSA"+"</b></font>");
}
stmt.close();
stmt_psa.close();
myConn.close();
myConn_psa.close();

 }
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>
