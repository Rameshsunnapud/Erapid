<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<%@ page language="java" import="java.sql.*" import="java.text.*" import="java.util.*" import="java.net.*" import="java.io.*" import="java.math.*" errorPage="error.jsp" %>
<%
		String order_no = request.getParameter("orderNo");//
		String cmd = request.getParameter("cmd");//what page
		String t = request.getParameter("t-s");//what page
// The rounding format
NumberFormat for1 = NumberFormat.getInstance();
      for1.setMaximumFractionDigits(0);

	// Getting current Date
	java.util.Date uDate = new java.util.Date(); // Right now
//	uDate
	java.sql.Date sDate = new java.sql.Date(uDate.getTime());
	String titl="";
	String bgcolor="";
if (t==null){
t="nohed";
}
String message="";
%>
<%@ include file="../../db_con.jsp"%>
<%
String due_date="";String bpcs_no="";String planner="";String dept="";String project_name="";String customer="";

// get the records for the header
ResultSet rs_efs_shop_paper = stmt.executeQuery("SELECT * FROM cs_efs_shop_paper where order_no like '"+order_no+"' ");
		if (rs_efs_shop_paper !=null) {
		while (rs_efs_shop_paper.next()){
			 bpcs_no=rs_efs_shop_paper.getString(2);
			 due_date=rs_efs_shop_paper.getString(3);
			 planner=rs_efs_shop_paper.getString(4);
									    }
									 }
rs_efs_shop_paper.close();
//
String project_type="";
ResultSet rs_project = stmt.executeQuery("SELECT Project_name,cust_name,project_type FROM cs_project where Order_no like '"+order_no+"' ");
		if (rs_project !=null) {
		while (rs_project.next()){
			project_name=rs_project.getString(1);
			customer=rs_project.getString(2);
			project_type=rs_project.getString(3);
			//due_date=rs_project.getString(3);
			//planned_date=rs_project.getString(4);
									    }
								   }
rs_project.close();
String cust_name1="";String cust_addr1="";String cust_addr2="";String city="";String state="";String country="";String zip_code="";String phone="";
String fax="";

if(customer != null && customer.length()>2 && (project_type ==null || project_type.trim().length()==0)){
ResultSet rs_cust=stmt.executeQuery("select * from cs_customers where cust_no ='"+customer.substring(2)+"'");
if(rs_cust != null){
	while(rs_cust.next()){
		cust_name1=rs_cust.getString("cust_name1");
		cust_addr1=rs_cust.getString("cust_addr1");
		cust_addr2=rs_cust.getString("cust_addr2");
		city=rs_cust.getString("city");
		state=rs_cust.getString("state");
		country=rs_cust.getString("country");
		zip_code=rs_cust.getString("zip_code");
		phone=rs_cust.getString("phone");
		fax=rs_cust.getString("fax");
	}
}
}
if(cust_name1==null||cust_name1.trim().length()<1){ cust_name1="";}else{cust_name1=cust_name1+"<BR>";}
if(cust_addr1==null||cust_addr1.trim().length()<1){ cust_addr1="";}else{ cust_addr1= cust_addr1+"<BR>";}
if(cust_addr2==null||cust_addr2.trim().length()<1){ cust_addr2="";}else{ cust_addr2= cust_addr2+"<BR>";}
if(city==null||city.trim().length()<1){ city="";}else{ city= city+",&nbsp;";}
if(state==null||state.trim().length()<1){ state="";}else{ state= state+",&nbsp;";}
if(country==null||country.trim().length()<1){ country="";}else{ country=country +"<BR>";}
if(zip_code==null||zip_code.trim().length()<1){ zip_code="";}else{ zip_code=zip_code +"<BR>";}
if(phone==null||phone.trim().length()<1){ phone="";}else{phone=phone +"<BR>";}
if(fax==null||fax.trim().length()<1){ fax="";}else{fax = fax+"<BR>";}
//out.println(cmd);

if(cmd.equals("1")){
for1.setMaximumFractionDigits(2);
//	out.println("The page is "+order_no+"the command"+cmd);
	titl="Hardware List Summary";
		int count=0;Vector part_no=new Vector();Vector detail_desc=new Vector();Vector qty=new Vector();Vector unit=new Vector();
		ResultSet rs_materails = stmt.executeQuery("SELECT part_no,cast(detail_desc as varchar) as a1,sum(qty),unit FROM cs_materials_output where order_no like '"+order_no+"' and text_identifier in('hardware','frames_hardware','pans_hardware') group by part_no,cast(detail_desc as varchar),unit order by part_no");
		if (rs_materails !=null) {
        while (rs_materails.next()) {
		part_no.addElement(rs_materails.getString (1));
		detail_desc.addElement(rs_materails.getString (2));
		qty.addElement(rs_materails.getString (3));
		unit.addElement(rs_materails.getString (4));
		count++;
									}
							    }
		if (t.equals("hed")){
%>
<%@ include file="headertop.shop.jsp"%>
<%@ include file="rep12.html"%>
<%
		}
		else{
%>
<%@ include file="header.shop.jsp"%>
<%@ include file="rep12.html"%>
<%
		}
					for (int m=0;m<count;m++){
					if ((m%2)==1){bgcolor="tdt";}else {bgcolor="battr";}
							out.println("<tr>");
							out.println("<TD align='left' class='"+bgcolor+"'>"+(m+1)+"</td>");
							out.println("<TD align='left' class='"+bgcolor+"'>"+part_no.elementAt(m)+"</td>");
							out.println("<TD align='left' class='"+bgcolor+"'>"+detail_desc.elementAt(m)+"</td>");
							out.println("<TD align='left' class='"+bgcolor+"'>"+unit.elementAt(m)+"</td>");
							out.println("<TD align='right' class='"+bgcolor+"'>"+for1.format((new Double (qty.elementAt(m).toString()).doubleValue()))+"</td>");
							out.println("</tr>");
											}
//out.println("The count for the hardware"+count);
%>
<%@ include file="footer.head.jsp"%>
<%
stmt.close();
rs_materails.close();
for1.setMaximumFractionDigits(0);
}

else if (cmd.equals("2")){
for1.setMaximumFractionDigits(2);
//	out.println("The page is "+order_no+"the command"+cmd);
	titl="Inventory Relief Summary";
	int count=0;Vector part_no=new Vector();Vector detail_desc=new Vector();Vector qty=new Vector();Vector unit=new Vector();
		ResultSet rs_materails = stmt.executeQuery("SELECT part_no,cast(detail_desc as varchar) as a1,sum(qty),unit FROM cs_materials_output where order_no like '"+order_no+"' and text_identifier not in ('hardware','frames_hardware','pans_hardware') group by part_no,cast(detail_desc as varchar),unit order by part_no");
		if (rs_materails !=null) {
        while (rs_materails.next()) {
		part_no.addElement(rs_materails.getString (1));
		detail_desc.addElement(rs_materails.getString (2));
		qty.addElement(rs_materails.getString (3));
		unit.addElement(rs_materails.getString (4));
		count++;
									}
							    }
		if (t.equals("hed")){
%>
<%@ include file="headertop.shop.jsp"%>
<%@ include file="rep12.html"%>
<%
		}
		else{
%>
<%@ include file="header.shop.jsp"%>
<%@ include file="rep12.html"%>
<%
		}
					for (int m=0;m<count;m++){
					if ((m%2)==1){bgcolor="tdt";}else {bgcolor="battr";}
							out.println("<tr>");
							out.println("<TD align='left' class='"+bgcolor+"'>"+(m+1)+"</td>");
							out.println("<TD align='left' class='"+bgcolor+"'>"+part_no.elementAt(m)+"</td>");
							out.println("<TD align='left' class='"+bgcolor+"'>"+detail_desc.elementAt(m)+"</td>");
							out.println("<TD align='left' class='"+bgcolor+"'>"+unit.elementAt(m)+"</td>");
							out.println("<TD align='right' class='"+bgcolor+"'>"+for1.format((new Double (qty.elementAt(m).toString()).doubleValue()))+"</td>");
							out.println("</tr>");
											}
//out.println("The count for the hardware"+count);
%>
<%@ include file="footer.head.jsp"%>
<%
stmt.close();
rs_materails.close();
for1.setMaximumFractionDigits(0);
}
else if (cmd.equals("3")){
//	out.println("The page is "+order_no+"the command"+cmd);
	titl="Cut Sheet/Assembly Sheet";
	int count=0;Vector line_no=new Vector();Vector block_code=new Vector();Vector detail_desc=new Vector();Vector setup_time=new Vector();Vector routing_time=new Vector();
	Vector line_no_group=new Vector();Vector tot_group=new Vector();int count_group=0;
		ResultSet rs_materails = stmt.executeQuery("SELECT item_no,detail_desc,block_code,setup_time,routing_time FROM cs_routings_output where order_no like '"+order_no+"' order by item_no,seq_no");
		if (rs_materails !=null) {
        while (rs_materails.next()) {
		line_no.addElement(rs_materails.getString (1));
		detail_desc.addElement(rs_materails.getString (2));
		block_code.addElement(rs_materails.getString (3));
		setup_time.addElement(new Double(rs_materails.getDouble (4)).toString());
		routing_time.addElement(new Double(rs_materails.getDouble (5)).toString());
		count++;
									}
							    }

		ResultSet rs_materails_gr = stmt.executeQuery("SELECT item_no,count(*) FROM cs_routings_output where order_no like '"+order_no+"' group by item_no");
		if (rs_materails_gr !=null) {
        while (rs_materails_gr.next()) {
		line_no_group.addElement(rs_materails_gr.getString (1));
		tot_group.addElement(rs_materails_gr.getString (2));
		count_group++;
									}
							    }
rs_materails.close();
rs_materails_gr.close();
stmt.close();
//out.println("the "+count_group);
//out.println("the "+count);
for (int a=0;a<count_group;a++){
								if (t.equals("hed")){
%>
<%@ include file="headertop.shop.jsp"%>
<%
		}
		else{
%>
<%@ include file="header.shop.jsp"%>

<%
		}
out.println("<tr><td align='left' valign='top' nowrap><table width='20%' border='0' cellspacing='0' cellpadding='0'><tr><td nowrap><h1>"+"Cut Sheet:"+"</h1></td></tr></table></td></tr>");
out.println("<tr><td align='center' valign='top' nowrap><table width='95%' border='0' cellspacing='1' cellpadding='2'>");
out.println("<tr>");
out.println("<td class='darktr'>#</td>");
out.println("<td class='darktr'>Description</td>");
out.println("</tr>");
int cs=0;
for (int m=0;m<count;m++){
if ((cs%2)==1){bgcolor="battr";}else {bgcolor="tdt";}
// block_code is cutlist
if ((block_code.elementAt(m).toString().endsWith("CUT"))&(line_no.elementAt(m).toString().equals(line_no_group.elementAt(a).toString()))){
	out.println("<tr>");
	out.println("<TD align='left' class='"+bgcolor+"'>"+(cs+1)+"</td>");
	out.println("<TD align='left' class='"+bgcolor+"'>"+detail_desc.elementAt(m)+"</td>");
	out.println("</tr>");
	cs++;
													}
					}
cs=0;
out.println("</table></td></tr>");
out.println("<tr><td align='center' valign='top'>&nbsp;</td></tr>");
out.println("<tr><td align='left' valign='top' nowrap><table width='20%' border='0' cellspacing='0' cellpadding='0'><tr><td nowrap><h1>"+"Assembly Sheet:"+"</h1></td></tr></table></td></tr>");
out.println("<tr><td align='center' valign='top' nowrap><table width='95%' border='0' cellspacing='1' cellpadding='2'>");
out.println("<tr>");
out.println("<td class='darktr'>#</td>");
out.println("<td class='darktr'>Description</td>");
out.println("</tr>");
for (int mn=0;mn<count;mn++){
if ((cs%2)==1){bgcolor="battr";}else {bgcolor="tdt";}
// block_code is assembly
//					if (block_code.elementAt(mn).toString().equals("ASSEMBLY")){
if ((block_code.elementAt(mn).toString().equals("ASSEMBLY"))&(line_no.elementAt(mn).toString().equals(line_no_group.elementAt(a).toString()))){
	out.println("<tr>");
	out.println("<TD align='left' class='"+bgcolor+"'>"+(cs+1)+"</td>");
	out.println("<TD align='left' class='"+bgcolor+"'>"+detail_desc.elementAt(mn)+"</td>");
	out.println("</tr>");
	cs++;
													  }
					}
out.println("</table></td></tr>");
out.println("<tr><td align='center' valign='top'>&nbsp;</td></tr>");
out.println("<tr><td align='left' valign='top' nowrap><table width='20%' border='0' cellspacing='0' cellpadding='0'><tr><td nowrap><h1>"+"Routing Time:"+"</h1></td></tr></table></td></tr>");
out.println("<tr><td align='left' valign='top' nowrap><table width='10%' border='0' cellspacing='1' cellpadding='2'>");
out.println("<tr>");
out.println("<td width='10%' nowrap>&nbsp;&nbsp;&nbsp;&nbsp;</td>");
out.println("<td class='darktr'>Process</td>");
out.println("<td class='darktr' nowrap>Time(in hrs.)</td>");
out.println("</tr>");
double set_time=0.0;double cut_time=0.0;double route_time=0.0;double assembly_time=0.0;
for (int mno=0;mno<count;mno++){
if ((cs%2)==1){bgcolor="battr";}else {bgcolor="tdt";}
// block_code is assembly
if (line_no.elementAt(mno).toString().equals(line_no_group.elementAt(a).toString())){
set_time=set_time+new Double (setup_time.elementAt(mno).toString()).doubleValue();
																				}
//			if (block_code.elementAt(mno).toString().equals("CUTLIST")){
if ((block_code.elementAt(mno).toString().endsWith("CUT"))&(line_no.elementAt(mno).toString().equals(line_no_group.elementAt(a).toString()))){
cut_time=cut_time+new Double (routing_time.elementAt(mno).toString()).doubleValue();
													   }
//				if (block_code.elementAt(mno).toString().equals("ROUTING")){
if ((block_code.elementAt(mno).toString().endsWith("ROUT"))&(line_no.elementAt(mno).toString().equals(line_no_group.elementAt(a).toString()))){
route_time=route_time+new Double (routing_time.elementAt(mno).toString()).doubleValue();
													   }
//					if (block_code.elementAt(mno).toString().equals("OPERATIONS")){
if ((block_code.elementAt(mno).toString().endsWith("OPS"))&(line_no.elementAt(mno).toString().equals(line_no_group.elementAt(a).toString()))){
assembly_time=assembly_time+new Double (routing_time.elementAt(mno).toString()).doubleValue();
													   }
						  }
	for1.setMaximumFractionDigits(2);
	out.println("<tr>");
	out.println("<td>&nbsp;</td>");
	out.println("<TD align='left' class='tdt'>"+"Set-up:"+"</td>");
	out.println("<TD align='left' class='tdt'>"+for1.format(set_time)+"</td>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<td>&nbsp;</td>");
	out.println("<TD align='left' class='battr'>"+"Cutting:"+"</td>");
	out.println("<TD align='left' class='battr'>"+for1.format(cut_time)+"</td>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<td>&nbsp;</td>");
	out.println("<TD align='left' class='tdt'>"+"Routing:"+"</td>");
	out.println("<TD align='left' class='tdt'>"+for1.format(route_time)+"</td>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<td>&nbsp;</td>");
	out.println("<TD align='left' class='battr'>"+"Assembly:"+"</td>");
	out.println("<TD align='left' class='battr'>"+for1.format(assembly_time)+"</td>");
	out.println("</tr>");
//out.println("The count for the hardware"+count);
//re-intalizing vars
set_time=0.0;cut_time=0.0;route_time=0.0;assembly_time=0.0;
%>
<%@ include file="footer.head.jsp"%>
<%
if ((count_group-a)>1){
out.println("<p class='pbr'>&nbsp;</p>");
        }
}//outer for loop
}
//The new report for operations

else if (cmd.equals("10")){
//	out.println("The page is "+order_no+"the command"+cmd);
	titl="Operations Summary";
	int count=0;Vector line_no=new Vector();Vector block_code=new Vector();Vector detail_desc=new Vector();Vector setup_time=new Vector();Vector routing_time=new Vector();
	Vector line_no_group=new Vector();Vector tot_group=new Vector();int count_group=0;
		ResultSet rs_materails = stmt.executeQuery("SELECT item_no,detail_desc,block_code,setup_time,routing_time FROM cs_routings_output where order_no like '"+order_no+"' order by item_no,seq_no");
		if (rs_materails !=null) {
        while (rs_materails.next()) {
		line_no.addElement(rs_materails.getString (1));
		detail_desc.addElement(rs_materails.getString (2));
		block_code.addElement(rs_materails.getString (3));
		setup_time.addElement(new Double(rs_materails.getDouble (4)).toString());
		routing_time.addElement(new Double(rs_materails.getDouble (5)).toString());
		count++;
									}
							    }
		ResultSet rs_materails_gr = stmt.executeQuery("SELECT item_no,count(*) FROM cs_routings_output where order_no like '"+order_no+"' group by item_no");
		if (rs_materails_gr !=null) {
        while (rs_materails_gr.next()) {
		line_no_group.addElement(rs_materails_gr.getString (1));
		tot_group.addElement(rs_materails_gr.getString (2));
		count_group++;
									}
							    }
rs_materails.close();
rs_materails_gr.close();
stmt.close();
//out.println("the "+count_group);
//out.println("the "+count);
for (int a=0;a<count_group;a++){
								if (t.equals("hed")){
%>
<%@ include file="headertop.shop.jsp"%>
<%
		}
		else{
%>
<%@ include file="header.shop.jsp"%>

<%
		}
int cs=0;
out.println("<tr><td align='center' valign='top'>&nbsp;</td></tr>");
out.println("<tr><td align='left' valign='top' nowrap><table width='20%' border='0' cellspacing='0' cellpadding='0'><tr><td nowrap><h1>"+"Operations:"+"</h1></td></tr></table></td></tr>");
out.println("<tr><td align='center' valign='top' nowrap><table width='95%' border='0' cellspacing='1' cellpadding='2'>");
out.println("<tr>");
out.println("<td class='darktr'>#</td>");
out.println("<td class='darktr'>Description</td>");
out.println("</tr>");
for (int mn=0;mn<count;mn++){
if ((cs%2)==1){bgcolor="battr";}else {bgcolor="tdt";}
// block_code is assembly
//					if (block_code.elementAt(mn).toString().equals("ASSEMBLY")){
if ((block_code.elementAt(mn).toString().endsWith("ROUT"))&(line_no.elementAt(mn).toString().equals(line_no_group.elementAt(a).toString()))){
	out.println("<tr>");
	out.println("<TD align='left' class='"+bgcolor+"'>"+(cs+1)+"</td>");
	out.println("<TD align='left' class='"+bgcolor+"'>"+detail_desc.elementAt(mn)+"</td>");
	out.println("</tr>");
	cs++;
													  }
if ((block_code.elementAt(mn).toString().endsWith("OPS"))&(line_no.elementAt(mn).toString().equals(line_no_group.elementAt(a).toString()))){
	out.println("<tr>");
	out.println("<TD align='left' class='"+bgcolor+"'>"+(cs+1)+"</td>");
	out.println("<TD align='left' class='"+bgcolor+"'>"+detail_desc.elementAt(mn)+"</td>");
	out.println("</tr>");
	cs++;
													  }
					}
out.println("</table></td></tr>");

//out.println("The count for the hardware"+count);
//re-intalizing vars
%>
<%@ include file="footer.head.jsp"%>
<%
if ((count_group-a)>1){
out.println("<p class='pbr'>&nbsp;</p>");
        }
}//outer for loop
}
//The new report for operations
else if (cmd.equals("4")){
for1.setMaximumFractionDigits(0);
titl="Packing List";
int count=0;
Vector block_code=new Vector();
Vector detail_desc=new Vector();
Vector qty_ordered=new Vector();
Vector item_no=new Vector();
Vector line_no_group=new Vector();
Vector tot_group=new Vector();
int count_group=0;
int count_mat=0;
Vector seq_no=new Vector();
// The materials output table
Vector item_no_mat=new Vector();Vector detail_desc_mat=new Vector();Vector qty_mat=new Vector();
ResultSet rs_materails = stmt.executeQuery("SELECT item_no,cast(detail_desc as varchar) as a1,qty_ordered,block_code,seq_no FROM cs_routings_output where order_no like '"+order_no+"' order by item_no,seq_no");
if (rs_materails !=null) {
while (rs_materails.next()) {
item_no.addElement(rs_materails.getString (1));
detail_desc.addElement(rs_materails.getString (2));
qty_ordered.addElement(rs_materails.getString (3));
block_code.addElement(rs_materails.getString (4));
seq_no.addElement(rs_materails.getString (5));
count++;
							}
					    }
ResultSet rs_materails_gr = stmt.executeQuery("SELECT item_no,count(*) FROM cs_routings_output where order_no like '"+order_no+"' group by item_no order by item_no");
if (rs_materails_gr !=null) {
while (rs_materails_gr.next()) {
line_no_group.addElement(rs_materails_gr.getString (1));
tot_group.addElement(rs_materails_gr.getString (2));
count_group++;
		}
    }

ResultSet rs_materails_mat = stmt.executeQuery("SELECT cast(detail_desc as varchar) as a1,sum(qty) FROM cs_materials_output where order_no like '"+order_no+"' and text_identifier in ('hardware','frames_hardware','pans_hardware') group by cast(detail_desc as varchar)");
//SELECT item_no,detail_desc,qty FROM cs_materials_output where order_no like '"+order_no+"' and text_identifier ='hardware' order by item_no,sequence
if (rs_materails_mat !=null) {
while (rs_materails_mat.next()) {
//item_no_mat.addElement(rs_materails_mat.getString (1));
detail_desc_mat.addElement(rs_materails_mat.getString (1));
qty_mat.addElement(rs_materails_mat.getString (2));
count_mat++;
							}
						}
rs_materails.close();
rs_materails_gr.close();
rs_materails_mat.close();
stmt.close();

	for (int ii=0;ii<2;ii++){	// outer for loop for printing two reports twice
		if (t.equals("hed")){
%>
<%@ include file="headertop.shop.jsp"%>
<%
		}
		else{
%>
<%@ include file="header.shop.jsp"%>

<%
		}
		int cp=0;String col="";
	for (int i=0;i<count_group;i++){
				for (int j=0;j<count;j++){
						if (item_no.elementAt(j).toString().equals(line_no_group.elementAt(i).toString()))   {
										if ((block_code.elementAt(j).toString().equals("PACKLIST"))){
										if((seq_no.elementAt(j).toString().equals("0.000"))){col="darktr";}
										else{col="";}
										out.println("<tr><td width='95%' align='center' valign='top' ><table width='95%' border='0' cellspacing='0' cellpadding='0'><tr><td width ='100%' class='"+col+"'>"+detail_desc.elementAt(j)+"</td></tr></table></td></tr>");
																									}

										if ((block_code.elementAt(j).toString().endsWith("PACK"))){
										if(cp<=0){
										out.println("<tr><td align='center' valign='top' >");
										out.println("<table width='95%' border='0' cellspacing='1' cellpadding='2'>");
										out.println("<tr>");
										out.println("<td class='tdt'>&nbsp;::</td>");
										out.println("<td class='tdt'>Qty Ordered</td>");
										out.println("<td class='tdt'>Qty Packed</td>");
										out.println("<td class='tdt'>Carton #</td>");
										out.println("<td class='tdt'>Back Order</td>");
										out.println("<td class='tdt'>Weight</td>");
										out.println("</tr>");
												}
										out.println("<tr><td align='left' valign='top' nowrap>"+detail_desc.elementAt(j)+"</td>");
										out.println("<td align='center' valign='top' nowrap>"+for1.format(new Double(qty_ordered.elementAt(j).toString()).doubleValue())+"</td>");
										out.println("<td align='left' valign='top' nowrap>"+"___________"+"</td>");
										out.println("<td align='left' valign='top' nowrap>"+"___________"+"</td>");
										out.println("<td align='left' valign='top' nowrap>"+"___________"+"</td>");
										out.println("<td align='left' valign='top' nowrap>"+"___________"+"</td>");
										out.println("</tr>");
										cp++;

																										}
																											 }
										 }
										 cp=0;
								out.println("<tr><td align='left' valign='top' >"+"&nbsp;"+"</td></tr>");
								out.println("</table></td></tr>");
								   }
				if (count_mat>0){
		out.println("<tr><td align='left' valign='top' nowrap><table width='15%' border='0' cellspacing='0' cellpadding='0'><tr><td nowrap><h1>"+"Hardware:"+"</h1></td></tr></table></td></tr>");
		out.println("<tr><td align='center' valign='top' >");
		out.println("<table width='95%' border='0' cellspacing='1' cellpadding='2'>");
		out.println("<tr>");
		out.println("<td class='tdt'>&nbsp;::</td>");
		out.println("<td class='tdt'>Qty Ordered</td>");
		out.println("<td class='tdt'>Qty Packed</td>");
		out.println("<td class='tdt'>Carton #</td>");
		out.println("<td class='tdt'>Back Order</td>");
		out.println("<td class='tdt'>Weight</td>");
		out.println("</tr>");

				for (int jk=0;jk<count_mat;jk++){
//				if (item_no_mat.elementAt(jk).toString().equals(line_no_group.elementAt(i).toString())){//for line grouping of hardware
				out.println("<tr><td align='left' valign='top' >"+detail_desc_mat.elementAt(jk)+"</td>");
				out.println("<td align='center' valign='top' nowrap>"+for1.format(new Double(qty_mat.elementAt(jk).toString()).doubleValue())+"</td>");
				out.println("<td align='left' valign='top' nowrap>"+"___________"+"</td>");
				out.println("<td align='left' valign='top' nowrap>"+"___________"+"</td>");
				out.println("<td align='left' valign='top' nowrap>"+"___________"+"</td>");
				out.println("<td align='left' valign='top' nowrap>"+"___________"+"</td>");
				out.println("</tr>");
													//											  }
												}
			out.println("</table></td></tr>");
				}


%>
<%@ include file="footer.head.jsp"%>
<%
//	out.println("Not yet  "+order_no+"   It's comming soon.........."+cmd);
//	out.println("The page is "+order_no+"the command"+cmd);
if (ii<=0){out.println("<p class='pbr'>&nbsp;</p>");}
	}// outer for loop for printing two reports twice
}

else if(cmd.equals("40")){
	boolean isBackOrder=false;
	/*
	ResultSet rsIsBackOrder=stmt.executeQuery("select count(*) from cs_back_order where order_no='"+order_no+"'");
	if(rsIsBackOrder != null){
		while(rsIsBackOrder.next()){
			if(rsIsBackOrder.getInt(1)>0){
				isBackOrder=true;
			}
		}
	}
	rsIsBackOrder.close();
	*/
	java.util.Date date=new java.util.Date();
	out.println("<table border='0' width='95%'>");
	out.println("<tr><td width='33%' nowrap>&nbsp;</td><td width='33%' align='center'>PACKING LIST</td><td width='33%'>&nbsp;</td></tr>");
	out.println("<tr><td width='33%' nowrap>CONSTRUCTION SPECIALTIES CO.<br>895 Lakefront Prom.<br> Mississauga, On, L5E 2C2<BR>&nbsp;</td><td width='33%' align='center'>&nbsp;</td><td width='33%'>&nbsp;</td></tr>");
	String year="0"+(date.getYear()-100);
	if(year.trim().length()>2){
		year=year.substring(year.length()-2);
	}
	out.println("<tr><td width='33%'>RUN DATE "+(date.getMonth()+1)+"/"+date.getDate()+"/"+year+"</td><td width='33%'>&nbsp;</td><td width='33%' ALIGN='left' rowspan='6'>"+cust_name1+cust_addr1+cust_addr2+city+state+country+zip_code+phone+fax+"</td></tr>");
	out.println("<tr><td width='33%'>&nbsp;</td><td width='33%'>&nbsp;</td></tr>");
	out.println("<tr><td width='33%'>JOB # - "+order_no+"</td><td width='33%'>&nbsp;</td></tr>");
	out.println("<tr><td width='33%'>JOB NAME - " + project_name+"</td><td width='33%'>&nbsp;</td></tr>");
	out.println("<tr><td width='33%'>CUSTOMER - "+customer+"</td><td width='33%' align='right'> &nbsp;"+"&nbsp;"+"</td></tr>");
	//out.println("<tr><td width='33%'>BLDG. LEVEL - "+ "&nbsp;"+"</td><td with='33%'>&nbsp;</td></tr>");
	out.println("<tr><td colspan='3'><hr></td></tr></table>");
	Vector item_no=new Vector();
	ResultSet rsItems=stmt.executeQuery("select distinct item_no from cs_materials_output where order_no='"+order_no+"'");
	if(rsItems != null){
		while(rsItems.next()){
			item_no.addElement(rsItems.getString(1));
		}
	}
	boolean isGrid=false;

	rsItems.close();
	out.println("<table border='0' width='95%'>");
	for(int x=0; x<item_no.size(); x++){


		ResultSet rsRouting=stmt.executeQuery("select detail_desc from cs_routings_output where order_no='"+order_no+"' and item_no='"+item_no.elementAt(x).toString()+"' and block_code='packlist' order by cast(seq_no as integer)");
		if(rsRouting != null){
			while(rsRouting.next()){
				out.println("<tr><td colspan='9'>"+rsRouting.getString(1).trim()+"</td></tr>");
			}
		}
		out.println("<tr><td colspan='9'><hr></td></tr>");
		out.println("<tr><td WIDTH='10%'>PART NUMBER</TD><TD WIDTH='30%'>DESCRIPTION</TD><TD WIDTH='10%' align='center'>QTY ORDERED</TD><TD WIDTH='10%' align='center'>QTY PREV. SHIPPED</TD><TD WIDTH='10%'>UOM</TD><TD WIDTH='10%'>QTY SHIPPED</TD><TD WIDTH='10%'>CTN #</TD><TD WIDTH='10%'>QTY ON BACK ORDER</TD><TD WIDTH='10%'>WEIGHT</TD></TR>");
		ResultSet rsMaterial=stmt.executeQuery("Select * from cs_routings_output where order_no='"+order_no+"' and item_no='"+item_no.elementAt(x).toString()+"' and cast(block_code as varchar) like '%pack' ");
		if(rsMaterial != null){
			while(rsMaterial.next()){
				out.println("<tr><td colspan='2'>"+item_no.elementAt(x).toString()+"::"+rsMaterial.getString("detail_desc")+"</td><td align='center'>"+rsMaterial.getString("qty_ordered")+"</td>");
				double qtyShipped=0;
				if(isBackOrder){
					ResultSet rsQty=stmt.executeQuery("select qty_back_ordered from cs_back_order where order_no='"+order_no+"' and item_no='"+item_no.elementAt(x).toString()+"' and part_no='"+rsMaterial.getString("detail_desc")+"'");
					if(rsQty != null){
						while(rsQty.next()){
							qtyShipped=rsQty.getDouble(1);
						}
					}
					rsQty.close();
				}
				out.println("<td align='center'>"+qtyShipped+"</td><td>&nbsp;</td><td>______</td><td>______</td><td>______</td><td>______</td></tr>");
			}
		}
		rsMaterial.close();
		out.println("<tr><td colspan='8'><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<u>HARDWARE</u></td></tr>");
		ResultSet rsMaterial2=stmt.executeQuery("Select order_no, item_no, part_no, cast(detail_desc as varchar(2000)) as a1, sum(cast(qty as numeric)) as a2, unit,bpcs_part_main from cs_materials_output where order_no='"+order_no+"' and text_identifier in ('hardware','frames_hardware','pans_hardware') and item_no='"+item_no.elementAt(x).toString()+"' group by part_no,order_no,item_no,cast(detail_desc as varchar(2000)),unit,bpcs_part_main ");
		if(rsMaterial2 != null){
			while(rsMaterial2.next()){
				if(rsMaterial2.getString("bpcs_part_main").startsWith("G")){
					isGrid=true;
				}
				double qtyShipped=0;
				if(isBackOrder){
					ResultSet rsQty=stmt.executeQuery("select qty_back_ordered from cs_back_order where order_no='"+order_no+"' and item_no='"+item_no.elementAt(x).toString()+"' and part_no='"+rsMaterial2.getString("part_no")+"'");
					if(rsQty != null){
						while(rsQty.next()){
							qtyShipped=rsQty.getDouble(1);
						}
					}
					rsQty.close();
				}
				//out.println(rsMaterial2.getString("bpcs_part_main")+"<BR>");
				out.println("<tr><td>"+item_no.elementAt(x).toString()+"::"+rsMaterial2.getString("part_no")+"</td><td>"+rsMaterial2.getString("a1")+"</td>");
				out.println("<td align='center'>"+rsMaterial2.getString("a2")+"</td><td align='center'>"+qtyShipped+"</td><td>"+rsMaterial2.getString("Unit")+"</td><td>______</td><td>______</td><td>______</td><td>______</td></tr>");
			}
		}
		rsMaterial2.close();
		out.println("<tr><td colspan='9'><hr></td></tr>");
	}

	//out.println("<table width='95%' border='0'>");
	if(isGrid){
		double qtyShipped=0;
		if(isBackOrder){
			ResultSet rsQty=stmt.executeQuery("select qty_back_ordered from cs_back_order where order_no='"+order_no+"' and item_no='x' and part_no='LIFT TOOL'");
			if(rsQty != null){
				while(rsQty.next()){
					qtyShipped=rsQty.getDouble(1);
				}
			}
			rsQty.close();
		}
		out.println("<tr><td WIDTH='10%'>&nbsp;</td><td WIDTH='30%'>LIFT TOOL</TD><TD WIDTH='10%' align='center'>1.00</TD><td align='center'>"+qtyShipped+"</td><td WIDTH='10%'>&nbsp;</td><td WIDTH='10%'>______</td><td WIDTH='10%'>______</td><td WIDTH='10%'>______</td><td WIDTH='10%'>______</td></tr>");
	}
	double qtyShipped=0;
	if(isBackOrder){
		ResultSet rsQty=stmt.executeQuery("select qty_back_ordered from cs_back_order where order_no='"+order_no+"' and item_no='x' and part_no='INSTRUCTIONS'");
		if(rsQty != null){
			while(rsQty.next()){
				qtyShipped=rsQty.getDouble(1);
			}
		}
		rsQty.close();
	}
	out.println("<tr><td WIDTH='10%'>&nbsp;</td><td WIDTH='30%'>INSTALLATION INSTRUCTIONS / HARDWARE</TD><TD WIDTH='10%' align='center'>1.00</TD><td align='center'>"+qtyShipped+"</td><td WIDTH='10%'>&nbsp;</td><td WIDTH='10%'>______</td><td WIDTH='10%'>______</td><td WIDTH='10%'>______</td><td WIDTH='10%'>______</td></tr>");
	out.println("<tr><td colspan='9'><hr></td></tr></table>");
	out.println("<table width='95%' border='0'>");
	out.println("<tr>  <td style='font-size:8pt' WIDTH='10%'>PACKED BY</TD>  <td style='font-size:8pt' WIDTH='15%'>__________________</td>  <td style='font-size:8pt' WIDTH='10%'>SHIPPER</td>  <td style='font-size:8pt' WIDTH='15%'>__________________</td>  <td style='font-size:8pt' COLSPAN='2' WIDTH='50%'><b>CUSTOMER NOTE:</b> CS MUST BE NOTIFIED OF ANY DESCREPANCIES WITHIN TEN(10) DAYS.</TD></TR>");
	out.println("<tr><td style='font-size:8pt'>NO. OF CRATES</td>  <td style='font-size:8pt' colspan='3'>__________________</td>  <td style='font-size:8pt' WIDTH='10%'>DATE SHIPPED</TD>  <td style='font-size:8pt' WIDTH='40%'>__________________</td></TR>");
	out.println("<tr><td style='font-size:8pt'>WEIGHT</td>  <td style='font-size:8pt' colspan='3'>__________________</td><td style='font-size:8pt'>CARRIER</TD><td style='font-size:8pt' WIDTH='40%'>__________________</td></TR>");
	out.println("<tr>  <td style='font-size:8pt' colspan='8'><hr></td></tr></table>");

}
else if(cmd.equals("41")){






	out.println("<html><head>Back Order</head><body><form name='form1' action='back_order_save.jsp'>");




		boolean isBackOrder=false;
		ResultSet rsIsBackOrder=stmt.executeQuery("select count(*) from cs_back_order where order_no='"+order_no+"'");
		if(rsIsBackOrder != null){
			while(rsIsBackOrder.next()){
				if(rsIsBackOrder.getInt(1)>0){
					isBackOrder=true;
				}
			}
		}
		rsIsBackOrder.close();





		java.util.Date date=new java.util.Date();
		out.println("<table border='0' width='95%'>");
		out.println("<input type='hidden' name='order_no' value='"+order_no+"'>");
		out.println("<tr><td width='33%' nowrap>&nbsp;</td><td width='33%' align='center'>PACKING LIST</td><td width='33%'>&nbsp;</td></tr>");
		out.println("<tr><td width='33%' nowrap>CONSTRUCTION SPECIALTIES CO.<br>895 Lakefront Prom.<br> Mississauga, On, L5E 2C2<BR>&nbsp;</td><td width='33%' align='center'>&nbsp;</td><td width='33%'>&nbsp;</td></tr>");
		String year="0"+(date.getYear()-100);
		if(year.trim().length()>2){
			year=year.substring(year.length()-2);
		}
		out.println("<tr><td width='33%'>RUN DATE "+(date.getMonth()+1)+"/"+date.getDate()+"/"+year+"</td><td width='33%'>&nbsp;</td><td width='33%' ALIGN='left' rowspan='6'>"+cust_name1+cust_addr1+cust_addr2+city+state+country+zip_code+phone+fax+"</td></tr>");
		out.println("<tr><td width='33%'>&nbsp;</td><td width='33%'>&nbsp;</td></tr>");
		out.println("<tr><td width='33%'>JOB # - "+order_no+"</td><td width='33%'>&nbsp;</td></tr>");
		out.println("<tr><td width='33%'>JOB NAME - " + project_name+"</td><td width='33%'>&nbsp;</td></tr>");
		out.println("<tr><td width='33%'>CUSTOMER - "+customer+"</td><td width='33%' align='right'> &nbsp;"+"&nbsp;"+"</td></tr>");
		//out.println("<tr><td width='33%'>BLDG. LEVEL - "+ "&nbsp;"+"</td><td with='33%'>&nbsp;</td></tr>");
		out.println("<tr><td colspan='3'><hr></td></tr></table>");
		Vector item_no=new Vector();
		ResultSet rsItems=stmt.executeQuery("select distinct item_no from cs_materials_output where order_no='"+order_no+"'");
		if(rsItems != null){
			while(rsItems.next()){
				item_no.addElement(rsItems.getString(1));
			}
		}
		boolean isGrid=false;
		double backOrder=0;
		rsItems.close();
		out.println("<table border='0' width='95%'>");
		for(int x=0; x<item_no.size(); x++){


			ResultSet rsRouting=stmt.executeQuery("select detail_desc from cs_routings_output where order_no='"+order_no+"' and item_no='"+item_no.elementAt(x).toString()+"' and block_code='packlist' order by cast(seq_no as integer)");
			if(rsRouting != null){
				while(rsRouting.next()){
					out.println("<tr><td colspan='6'>"+rsRouting.getString(1)+"</td></tr>");
				}
			}
			out.println("<tr><td colspan='6'><hr></td></tr>");
			out.println("<tr><td >PART NUMBER</TD><TD >DESCRIPTION</TD><TD align='center'>QTY ORDERED</TD><TD >UOM</TD><TD >QTY SHIPPED</TD></TR>");
			ResultSet rsMaterial=stmt.executeQuery("Select * from cs_routings_output where order_no='"+order_no+"' and item_no='"+item_no.elementAt(x).toString()+"' and cast(block_code as varchar) like '%pack' ");
			if(rsMaterial != null){
				while(rsMaterial.next()){
					out.println("<tr><td ><input type='hidden' name='item_no' value='"+item_no.elementAt(x).toString()+"'>");
					out.println("<input type='text' name='part_no' value='"+rsMaterial.getString("detail_desc")+"'></td>");
					out.println("<td><input type='text' name='desc' value=''></td>");
					out.println("<td align='center'><input type='text' name='qty' value='"+rsMaterial.getString("qty_ordered")+"'></td>");
					out.println("<td><input type='text' name='uom' value=''></td>");
					if(isBackOrder){
						ResultSet rsBack=stmt.executeQuery("select qty_back_ordered from cs_back_order where order_no='"+order_no+"' and item_no='"+item_no.elementAt(x).toString()+"' and part_no='"+rsMaterial.getString("detail_desc")+"'");
						if(rsBack != null){
							while(rsBack.next()){
								backOrder=rsBack.getDouble(1);
							}
						}
						rsBack.close();
					}
					out.println("<td><input type='text' name='back_order' value='"+backOrder+"'></td></tr>");
					backOrder=0;
				}
			}
			rsMaterial.close();
			out.println("<tr><td colspan='8'><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<u>HARDWARE</u></td></tr>");
			ResultSet rsMaterial2=stmt.executeQuery("Select order_no, item_no, part_no, cast(detail_desc as varchar(2000)) as a1, sum(cast(qty as numeric)) as a2, unit,bpcs_part_main from cs_materials_output where order_no='"+order_no+"' and text_identifier in ('hardware','frames_hardware','pans_hardware') and item_no='"+item_no.elementAt(x).toString()+"' group by part_no,order_no,item_no,cast(detail_desc as varchar(2000)),unit,bpcs_part_main ");
			if(rsMaterial2 != null){
				while(rsMaterial2.next()){
					if(rsMaterial2.getString("bpcs_part_main").startsWith("G")){
						isGrid=true;
					}

					out.println("<tr><td><input type='hidden' name='item_no' value='"+item_no.elementAt(x).toString()+"'>");
					out.println("<input type='text' name='part_no' value='"+rsMaterial2.getString("part_no")+"'></td>");
					out.println("<td><input type='text' name='desc' value='"+rsMaterial2.getString("a1")+"'></td>");
					out.println("<td align='center'><input type='text' name='qty' value='"+rsMaterial2.getString("a2")+"'></td>");
					out.println("<td><input type='text' name='uom' value='"+rsMaterial2.getString("Unit")+"'></td>");
					if(isBackOrder){
						ResultSet rsBack=stmt.executeQuery("select qty_back_ordered from cs_back_order where order_no='"+order_no+"' and item_no='"+item_no.elementAt(x).toString()+"' and part_no='"+rsMaterial2.getString("part_no")+"'");
						if(rsBack != null){
							while(rsBack.next()){
								backOrder=rsBack.getDouble(1);
							}
						}
						rsBack.close();
					}
					out.println("<td><input type='text' name='back_order' value='"+backOrder+"'></td></tr>");
					backOrder=0;

				}
			}
			rsMaterial2.close();
			out.println("<tr><td colspan='8'><hr></td></tr>");
		}

		//out.println("<table width='95%' border='0'>");
		if(isGrid){
			if(isBackOrder){
				ResultSet rsBack=stmt.executeQuery("select qty_back_ordered from cs_back_order where order_no='"+order_no+"' and item_no='x' and part_no='LIFT TOOL'");
				if(rsBack != null){
					while(rsBack.next()){
						backOrder=rsBack.getDouble(1);
					}
				}
				rsBack.close();
			}
			out.println("<tr><td ><input type='hidden' name='item_no' value='x'><input type='text' name='part_no' value='LIFT TOOL'></td><td WIDTH='30%'><input type='text' name='desc' value='LIFT TOOL'></TD><TD WIDTH='10%' align='center'><input type='text' name='qty' value='1.00'></TD><td WIDTH='10%'><input type='text' name='uom' value=''></td><td WIDTH='10%'><input type='text' name='back_order' value='"+backOrder+"'></td></tr>");
			backOrder=0;
		}
		if(isBackOrder){
			ResultSet rsBack=stmt.executeQuery("select qty_back_ordered from cs_back_order where order_no='"+order_no+"' and item_no='x' and part_no='INSTRUCTIONS'");
			if(rsBack != null){
				while(rsBack.next()){
					backOrder=rsBack.getDouble(1);
				}
			}
			rsBack.close();
		}
		out.println("<tr><td WIDTH='10%'><input type='hidden' name='item_no' value='x'><input type='text' name='part_no' value='INSTRUCTIONS'></td><td WIDTH='30%'><input type='text' name='desc' value='INSTALLATION INSTRUCTIONS / HARDWARE'></TD><TD WIDTH='10%' align='center'><input type='text' name='qty' value='1.00'></TD><td WIDTH='10%'><input type='text' name='uom' value=''></td><td WIDTH='10%'><input type='text' name='back_order' value='"+backOrder+"'></td></tr>");
		out.println("<tr><td colspan='8'><hr></td></tr></table>");
		out.println("<input type='submit' value='submit' name='submit'>");
	out.println("</form></body></html>");










































}
else{
		URL output_st = new URL("https://"+application.getInitParameter("HOST")+"/erapid/us/reports/shop.transfer.jsp?orderNo="+order_no+"&cmd=1");
		URL output_st1 = new URL("https://"+application.getInitParameter("HOST")+"/erapid/us/reports/shop.transfer.jsp?orderNo="+order_no+"&cmd=2");
		URL output_st2 = new URL("https://"+application.getInitParameter("HOST")+"/erapid/us/reports/shop.transfer.jsp?orderNo="+order_no+"&cmd=3");
		URL output_st3 = new URL("https://"+application.getInitParameter("HOST")+"/erapid/us/reports/shop.transfer.jsp?orderNo="+order_no+"&cmd=4");
		URL output_st10 = new URL("https://"+application.getInitParameter("HOST")+"/erapid/us/reports/shop.transfer.jsp?orderNo="+order_no+"&cmd=10");

		BufferedReader in = new BufferedReader(	new InputStreamReader(output_st.openStream()));
		String inputLine;
		while ((inputLine = in.readLine()) != null){
		out.println(inputLine);
		}
out.println("<p class='pbr'>&nbsp;</p>");
		BufferedReader in1 = new BufferedReader(new InputStreamReader(output_st1.openStream()));
		String inputLine1;
		while ((inputLine1 = in1.readLine()) != null){
		out.println(inputLine1);
		}
out.println("<p class='pbr'>&nbsp;</p>");
		BufferedReader in2 = new BufferedReader(new InputStreamReader(output_st2.openStream()));
		String inputLine2;
		while ((inputLine2 = in2.readLine()) != null){
		out.println(inputLine2);
		}
out.println("<p class='pbr'>&nbsp;</p>");
		BufferedReader in10 = new BufferedReader(new InputStreamReader(output_st10.openStream()));
		String inputLine10;
		while ((inputLine10 = in10.readLine()) != null){
		out.println(inputLine10);
		}
out.println("<p class='pbr'>&nbsp;</p>");
		BufferedReader in3 = new BufferedReader(new InputStreamReader(output_st3.openStream()));
		String inputLine3;
		while ((inputLine3 = in3.readLine()) != null){
		out.println(inputLine3);
		}
		in.close();	in1.close();in2.close();in3.close();
//		out.println("The page is "+order_no+"the command"+cmd);

}
//stmt.close();
myConn.close();


}
catch(Exception e){
out.println(e);
}
%>





