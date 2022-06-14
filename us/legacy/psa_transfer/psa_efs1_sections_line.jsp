<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<%@ page language="java" import="java.sql.*" import="java.net.*" import="java.io.*"  import="java.math.*" import="java.util.*" errorPage="error.jsp" %>
<%@ include file="../../../db_con_psa.jsp"%>
<%@ include file="../../../db_con.jsp"%>
<%
String order_no = request.getParameter("orderNo");
myConn.setAutoCommit(false);
int rows=0;
int rows_p=0;
int rows_l=0;

try
	{
//		//stmt_psa = myConn.createStatement();
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
try
	{
//		//java.sql.Statement s2 = myConn1.createStatement();
		String elogia="SELECT count(*) FROM csquotes where ORDER_NO ='"+order_no+"'";
		java.sql.ResultSet rs = stmt.executeQuery(elogia);
		while(rs.next()){
		rows_l =  rs.getInt(1);
						}
						rs.close();
//						out.println("The count"+rows_l+elogia);
	}
catch (java.sql.SQLException e)
	{
		out.println("Probelm with Getting if the quote exists in erapid table ");
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

if (rows_l<=0 ){
out.println("<font size='3.5' color='Red'><b>"+"There is no data for this quote.  Please run Global Updates and try again."+"</b></font>");
}
//else if (rows_p > 0 )
//{
//out.println("<font size='3.5' color='Red'><b>"+"This Quote Number already exists in PSA. <br> Remove it from PSA before you update it"+"</b></font>");
//}
else{
//Sections begin
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
	sect_group.addElement("");
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
//sections end
// FROM cs_project
String overage="";String handling_cost="";String freight_cost="";String product="";String setup_cost="";
//java.sql.Statement stmt_project = myConn1.createStatement();
		ResultSet rs_project = stmt.executeQuery("SELECT product_id,overage,handling_cost,freight_cost,setup_cost FROM cs_project where order_no='"+order_no+"' ");
		if (rs_project !=null) {
         while (rs_project.next()) {
		  product= rs_project.getString(1);
		  overage =rs_project.getString(2);
		  handling_cost =rs_project.getString(3);
		  freight_cost =rs_project.getString(4);
		  setup_cost =rs_project.getString(5);
		 }
		}
		rs_project.close();
double misc_total=Double.parseDouble(overage)+Double.parseDouble(handling_cost)+Double.parseDouble(freight_cost)+Double.parseDouble(setup_cost);
//project done


//for the csquotes data storagee
String final_desc="";
int k_new=0;String bgcolor_new="";Vector desc_new=new Vector();Vector qty_new=new Vector();Vector extended_price_new=new Vector();
Vector line_no_new=new Vector();double totprice=0.0;Vector desc_new_group=new Vector();Vector block_id=new Vector();Vector desc_new_group_line=new Vector();Vector line_group_line=new Vector();
Vector uom_new=new Vector();Vector bpcs_uom=new Vector();Vector bpcs_qty=new Vector();double tot_sum=0;
//Vector line_block=new Vector();Vector line_block_price=new Vector();

// for quote description
int bcount=0;int grp_count=0;int grp_count1=0;String dim_unit="";String unit_price_new="";String line_tot_price="";
double unit_price1=0;int main_color=0;String qty_bpcs="";double tot_price1=0;String qty_origi="";
String dimension="";String cuts_notches="";	String logo="";String template_art="";String texture_color="";
String dimension1="";String cuts_notches1="";	String logo1="";String template_art1="";String texture_color1="";
//for inseting the data in to psa
		String psaseq="";
   for(int ye=0;ye<sect_group.size();ye++){
//   out.println("The size: "+sect_group.size()+"::"+sect_group_lines.elementAt(ye).toString());
		String stat1="";String stat2="";String stat3="";String stat4="";k_new=0;
		line_no_new.removeAllElements();desc_new.removeAllElements();extended_price_new.removeAllElements();block_id.removeAllElements();
		uom_new.removeAllElements();qty_new.removeAllElements();bpcs_qty.removeAllElements();bpcs_uom.removeAllElements();
		desc_new_group.removeAllElements();desc_new_group_line.removeAllElements();line_group_line.removeAllElements();
		if(sections==0){
		stat1="select * from csquotes where order_no='"+order_no+"' and product_id='EFS' order by cast(line_no as integer),block_id " ;
		}
		else{
		stat1="select * from csquotes where order_no='"+order_no+"' and product_id='EFS' and line_no in("+sect_group_lines.elementAt(ye).toString()+") order by cast(line_no as integer),block_id ";
		}
    	ResultSet rs_csquotes_new = stmt.executeQuery(stat1);
		if (rs_csquotes_new !=null) {
        while (rs_csquotes_new.next()) {
		line_no_new.addElement(rs_csquotes_new.getString("line_no"));
		desc_new.addElement(rs_csquotes_new.getString("descript"));
		extended_price_new.addElement(rs_csquotes_new.getString("extended_price"));
    	tot_sum=tot_sum+new Double(rs_csquotes_new.getString("extended_price")).doubleValue();
		block_id.addElement(rs_csquotes_new.getString("Block_ID"));
		uom_new.addElement(rs_csquotes_new.getString("uom"));
		qty_new.addElement(rs_csquotes_new.getString("qty"));
		bpcs_qty.addElement(rs_csquotes_new.getString("bpcs_qty"));
		bpcs_uom.addElement(rs_csquotes_new.getString("bpcs_um"));
		k_new++;
									}
								}
								rs_csquotes_new.close();
		if(sections==0){
		stat2="select cast(CSQUOTES.descript as varchar(700)) as a1 from csquotes where order_no='"+order_no+"'  and product_id='EFS' and block_id='A_APRODUCT' group by cast(CSQUOTES.descript as varchar(700))";
		}
		else{
		stat2="select cast(CSQUOTES.descript as varchar(700)) as a1 from csquotes where order_no='"+order_no+"'  and product_id='EFS' and block_id='A_APRODUCT' and line_no in("+sect_group_lines.elementAt(ye).toString()+") group by cast(CSQUOTES.descript as varchar(700))";
		}
	ResultSet rs_csquotes_new_group = stmt.executeQuery(stat2);
		if (rs_csquotes_new_group !=null) {
		   while (rs_csquotes_new_group.next()) {
			desc_new_group.addElement(rs_csquotes_new_group.getString("a1"));
			}
		}
		if(sections==0){
				stat3="select cast(CSQUOTES.descript as varchar(700)) as a2,line_no,sum(cast(extended_price as decimal)) from csquotes where order_no='"+order_no+"'  and product_id='EFS' and block_id='A_APRODUCT' group by cast(CSQUOTES.descript as varchar(700)),line_no";
		}
		else{
				stat3="select cast(CSQUOTES.descript as varchar(700)) as a2,line_no,sum(cast(extended_price as decimal)) from csquotes where order_no='"+order_no+"'  and product_id='EFS' and block_id='A_APRODUCT' and line_no in("+sect_group_lines.elementAt(ye).toString()+") group by cast(CSQUOTES.descript as varchar(700)),line_no";
		}

	ResultSet rs_csquotes_new_group_line = stmt.executeQuery(stat3);
		if (rs_csquotes_new_group_line !=null) {
		   while (rs_csquotes_new_group_line.next()) {
			desc_new_group_line.addElement(rs_csquotes_new_group_line.getString("a2"));
			line_group_line.addElement(rs_csquotes_new_group_line.getString("line_no"));
			}

		}
		rs_csquotes_new_group_line.close();
// Data gathering done
// data manupalation satarted
	for(int ng=0;ng<desc_new_group.size();ng++){
		for (int n=0;n<desc_new_group_line.size();n++){
			if( (desc_new_group.elementAt(ng).toString().equals(desc_new_group_line.elementAt(n).toString()))) {
			   for(int nl=0;nl<k_new;nl++){
				    if((line_group_line.elementAt(n).toString().equals(line_no_new.elementAt(nl).toString())) ){
							 if(grp_count==0){
								 if( !((block_id.elementAt(nl).toString().trim().equals("A_APRODUCT"))|(block_id.elementAt(nl).toString().trim().startsWith("E_DIM"))) ){
									   if( ((block_id.elementAt(nl).toString().startsWith("B_"))) ){
										final_desc=final_desc+"\r"+desc_new.elementAt(nl).toString();
										main_color++;
//										out.println(line_no_new.elementAt(nl).toString()+" The final desc1: "+final_desc+"<br>");
										}// If for the B_block done
									// For the A_Block
								   if( ((block_id.elementAt(nl).toString().startsWith("A_"))) ){
										final_desc=final_desc+"\r"+desc_new.elementAt(nl).toString();
										main_color++;
//										out.println(line_no_new.elementAt(nl).toString()+"The final desc2: "+final_desc+"<br>");
										}//If for the A_Block's done
								  }
							   }//if group_count==0;
					}
				}// the for loop
//				final_desc=final_desc+"\r\n";
			   for(int nl=0;nl<k_new;nl++){
					if((line_group_line.elementAt(n).toString().equals(line_no_new.elementAt(nl).toString())) ) {
								 if((block_id.elementAt(nl).toString().trim().equals("E_DIM1")) ){
										final_desc=final_desc+"\r";
										String dim=(desc_new.elementAt(nl)).toString();
										int n_s=dim.indexOf("@");
										int n_s1=dim.indexOf("@",n_s+1);
										int n_s2=dim.indexOf("@",n_s1+1);
										int n_s3=dim.indexOf("@",n_s2+1);
										dimension=dim.substring(0,n_s);
										cuts_notches=dim.substring(n_s+1,n_s1);
										logo=dim.substring(n_s1+1,n_s2);
										template_art=dim.substring(n_s2+1,n_s3);
										texture_color=dim.substring(n_s3+1,dim.length());
										if (dimension.equals("")){dimension="";}else{if(!(qty_new.elementAt(nl).toString().trim().equals(""))){qty_origi="("+qty_new.elementAt(nl).toString().trim()+")"+" @ ";}else{qty_origi="";}}
										if (cuts_notches.equals("")){cuts_notches="";}
										else{
											int n_sp=cuts_notches.indexOf("\\r");
											int n_sp1=cuts_notches.indexOf("\\r",n_sp+1);
											int n_sp2=cuts_notches.indexOf("\\r",n_sp1+1);
											if(n_sp>0){ if(cuts_notches.substring(0,n_sp).trim().length()>0){cuts_notches1=cuts_notches.substring(0,n_sp)+"\r";} }
											if(n_sp>=0&n_sp1>0){ if(cuts_notches.substring(n_sp+2,n_sp1).trim().length()>0){cuts_notches1=cuts_notches1+cuts_notches.substring(n_sp+2,n_sp1)+"\r";}}
											if(n_sp>=0&n_sp1>=0&n_sp2>0){ if(cuts_notches.substring(n_sp1+2,n_sp2).trim().length()>0){ cuts_notches1=cuts_notches1+cuts_notches.substring(n_sp1+2,n_sp2)+"\r";}}
											if(n_sp2>0){cuts_notches1=cuts_notches1+cuts_notches.substring(n_sp2+2,cuts_notches.length())+"\r";}
//											out.println(line_no_new.elementAt(nl).toString()+"::"+block_id.elementAt(nl).toString().trim()+" n_sp: "+n_sp+" text1:"+cuts_notches.substring(0,n_sp)+"@ ");
//											out.println(" n_sp1: "+n_sp1+" text2:"+cuts_notches.substring(n_sp+2,n_sp1)+"@ ");
//											out.println(" n_sp2: "+n_sp2+" text3:"+cuts_notches.substring(n_sp1+2,n_sp2)+"@ "+"<br>");
	//										cuts_notches=cuts_notches+"\r";
	//										out.println("hello "+cuts_notches1+"<br>");
										}
										if (logo.equals("")){logo="";}else{logo=logo+"\r";}
										if (template_art.equals("")){template_art="";}else{template_art=template_art+"\r";}
										if (texture_color.equals("")){texture_color="";}else{cuts_notches=texture_color+"\r";}
								//		final_desc=final_desc+qty_origi;
										final_desc=final_desc+cuts_notches1;
										final_desc=final_desc+logo;
										final_desc=final_desc+template_art;
										final_desc=final_desc+texture_color;
										final_desc=final_desc+qty_origi;
										final_desc=final_desc+dimension;
										final_desc=final_desc+"\r\n"	;
		//							out.println("The final desc3: "+final_desc+"<br>");
								}
					}
			   }//inner for
				grp_count++;grp_count1++;dim_unit="";unit_price_new="";line_tot_price="";dimension="";cuts_notches="";logo="";template_art="";texture_color="";
				dimension1="";cuts_notches1="";logo1="";template_art1="";texture_color1="";
			 }//IF LOOP
		bcount++;
		}//INSIDE FOR
		grp_count=0;grp_count1=0;bcount=0;
	}//OUT SIDE FOR
// data manupalation
//out.println("final_desc: "+final_desc+"<br>");
  //Inserting into PSA
try{
			    psaseq=(new Integer((ye+1)).toString());
				for(int x=0;x<(6-(psaseq.length()));x++){psaseq="0"+psaseq;}
		String updateString ="INSERT INTO dba.cs_quotes (PSA_SEQ,QUOTE_NO,LINE_NO,PRODUCT_ID,DESCRIPTION,LINE_TOTAL,BLOCK_ID,SEQUENCE_NO,UNITS,CURRENCY_ID,QTY,WEIGHT,WEIGHT_UNIT,BID_TYPE)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
		java.sql.PreparedStatement stmtx = myConn_psa.prepareStatement(updateString);
//stmt = myConn.prepareStatement(updateString);
		stmtx.setString(1,psaseq);
		stmtx.setString(2,order_no);
		stmtx.setInt(3,(ye+1));
		stmtx.setString(4,product);
		stmtx.setString(5,final_desc);
//		stmtx.setDouble(6,(misc_total+tot_sum));
		BigDecimal dnew = new BigDecimal((misc_total+tot_sum));
		dnew = dnew.setScale(0, BigDecimal.ROUND_HALF_UP);
		stmtx.setDouble(6,(dnew.doubleValue()));
		stmtx.setString(7,product);
		stmtx.setDouble(8,1);
        stmtx.setString(9,"EA");
		stmtx.setString(10,"007");
		stmtx.setString(11,"1");
		stmtx.setDouble(12,0.0);
		stmtx.setString(13,"LB");
		stmtx.setString(14,(sect_group.elementAt(ye).toString()));
		int rocount = stmtx.executeUpdate();
		stmtx.close();
	}
	catch (java.sql.SQLException e)
	{
		out.println("Problem with Entering PSA Data BAse");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}
	tot_sum=0;final_desc="";
//	   out.println("The final desc: "+final_desc);
   }//sections groups for loop

myConn.commit();
//out.println(final_desc);
out.println("<font size='3.5' color='Blue'><b>"+"Data for this Quote has been Transfered to PSA"+"</b></font>");
}
//s1.close();
stmt.close();
myConn.close();
//myConn1.close();
stmt_psa.close();
myConn_psa.close();

 }
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>