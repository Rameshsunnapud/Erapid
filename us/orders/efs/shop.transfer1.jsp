
<%@ page language="java" import="java.sql.*" import="java.text.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%  	
		String order_no = request.getParameter("sp-q");//	
		String cmd = request.getParameter("cmd");//what page
		String t = request.getParameter("t-s");//what page		
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
<%@ include file="db_con.jsp"%>
<%
int count_shop=0;
		ResultSet rs_efs_shop_paper = stmt.executeQuery("SELECT count(*) FROM cs_efs_shop_paper where order_no like '"+order_no+"' ");
  		if (rs_efs_shop_paper !=null) {
		while (rs_efs_shop_paper.next()){
			count_shop=rs_efs_shop_paper.getInt(1);
									    }
								      }
out.println("The shop count"+count_shop); 
if(count_shop<=0){
message="<font color='red'> The Order you selected\"<strong>"+order_no+"</strong>\"doesn't exist . Please try a valid order Number</font>";
//out.println("The count is zero");
%>	
<%@ include file="home.jsp"%>
<%
//out.println("The search ");
}
else{
if(cmd.equals("1")){
//	out.println("The page is "+order_no+"the command"+cmd);
	titl="Hardware List Summary";
	int count=0;Vector part_no=new Vector();Vector detail_desc=new Vector();Vector qty=new Vector();Vector unit=new Vector();
		ResultSet rs_materails = stmt.executeQuery("SELECT part_no,detail_desc,sum(qty),unit FROM cs_materials_output where order_no like '"+order_no+"' and text_identifier like 'hardware%' group by part_no,detail_desc,unit order by part_no");
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
							out.println("<TD align='right' class='"+bgcolor+"'>"+qty.elementAt(m)+"</td>");														
							out.println("</tr>");
						   					}
//out.println("The count for the hardware"+count);	
%>	
<%@ include file="footer.head.jsp"%>
<%
}
else if (cmd.equals("2")){
//	out.println("The page is "+order_no+"the command"+cmd);
	titl="Inventory Relief Summary";
	int count=0;Vector part_no=new Vector();Vector detail_desc=new Vector();Vector qty=new Vector();Vector unit=new Vector();
		ResultSet rs_materails = stmt.executeQuery("SELECT part_no,detail_desc,sum(qty),unit FROM cs_materials_output where order_no like '"+order_no+"' and text_identifier not like 'hardware%' group by part_no,detail_desc,unit order by part_no");
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
							out.println("<TD align='right' class='"+bgcolor+"'>"+qty.elementAt(m)+"</td>");														
							out.println("</tr>");
						   					}
//out.println("The count for the hardware"+count);	
%>	
<%@ include file="footer.head.jsp"%>
<%	
}
else if (cmd.equals("3")){
	out.println("The page is "+order_no+"the command"+cmd);	
}
else if (cmd.equals("4")){
	out.println("The page is "+order_no+"the command"+cmd);	
}
else{
	out.println("The page is "+order_no+"the command"+cmd);	
	
}

}
%>	
