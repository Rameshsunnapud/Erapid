
<%@ page language="java" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" errorPage="error.jsp" %>
<% 		String order_no = request.getParameter("sp-q");//	
 		String edit = request.getParameter("eh-q");//	
%>	
<%@ include file="db_con.jsp"%>
<%
//vars for editing the header info
String due_date="";String bpcs_no="";String planner="";String dept="";
// For the bill of materials transfer
Vector item_no=new Vector();
Vector qty=new Vector();
Vector text_identifier=new Vector();
Vector bpcs_part_main=new Vector();
Vector bpcs_part_sub=new Vector();
Vector detail_desc=new Vector();
Vector item_no_rout=new Vector();int rout_tot_count=0;int mat_tot_count=0;
Vector frame_counter=new Vector();Vector csquotes_qty=new Vector();Vector csquotes_line_no=new Vector();

// For the bill of materials transfer end
//
Vector bpcs_shop_order_no=new Vector();
Vector seq_no=new Vector();
//

String project_name="";
		ResultSet rs_project = stmt.executeQuery("SELECT Project_name FROM cs_project where Order_no like '"+order_no+"' ");
  		if (rs_project !=null) {
		while (rs_project.next()){
			project_name=rs_project.getString(1);
									    }
								      }								  

//
int count_shop=0;int bpcs_mat_count=0;
		ResultSet rs_efs_shop_paper = stmt.executeQuery("SELECT count(*) FROM cs_efs_shop_paper where order_no like '"+order_no+"' ");
  		if (rs_efs_shop_paper !=null) {
		while (rs_efs_shop_paper.next()){
			count_shop=rs_efs_shop_paper.getInt(1);			
									    }
								      }
		ResultSet rs_bpcs_mat_shop_orders = stmt.executeQuery("SELECT count(*) FROM cs_bpcs_mat_shop_orders where cse_order_no like '"+order_no+"' ");
  		if (rs_bpcs_mat_shop_orders !=null) {
		while (rs_bpcs_mat_shop_orders.next()){
			bpcs_mat_count=rs_bpcs_mat_shop_orders.getInt(1);
									    }
								      }
									  
if (count_shop<=0){
%>	
<%@ include file="home.jsp"%>
<% 
}
else if((bpcs_mat_count>0)) {
		if(edit.equals("1")){ 
			URL output_st = new URL("http://"+application.getInitParameter("HOST")+"/custom/orders/efs/shop.transfer.jsp?sp-q="+order_no+"&cmd=1&t-s=hed");
			BufferedReader in = new BufferedReader(	new InputStreamReader(output_st.openStream()));
			String inputLine;
			while ((inputLine = in.readLine()) != null)
			out.println(inputLine);
			in.close();
		}
		else{
				ResultSet rs_efs_shop_paper1 = stmt.executeQuery("SELECT * FROM cs_efs_shop_paper where order_no like '"+order_no+"' ");
		  		if (rs_efs_shop_paper1 !=null) {
				while (rs_efs_shop_paper1.next()){
					 bpcs_no=rs_efs_shop_paper1.getString(2);			
		     		 due_date=rs_efs_shop_paper1.getString(3);
					 planner=rs_efs_shop_paper1.getString(4);											
				}
				}
				ResultSet rs_efs_bpcs_mat_shop_orders = stmt.executeQuery("SELECT * FROM cs_bpcs_mat_shop_orders where cse_order_no like '"+order_no+"' ");
		  		if (rs_efs_bpcs_mat_shop_orders !=null) {
				while (rs_efs_bpcs_mat_shop_orders.next()){
				seq_no.addElement(rs_efs_bpcs_mat_shop_orders.getString ("seq_no"));
				detail_desc.addElement(rs_efs_bpcs_mat_shop_orders.getString("prod_desc"));
				bpcs_part_sub.addElement(rs_efs_bpcs_mat_shop_orders.getString ("bpcs_part_sub"));
				qty.addElement(rs_efs_bpcs_mat_shop_orders.getString ("qty"));				
				item_no.addElement(rs_efs_bpcs_mat_shop_orders.getString ("item_no"));
				bpcs_shop_order_no.addElement(rs_efs_bpcs_mat_shop_orders.getString ("bpcs_shop_order_no"));
				mat_tot_count++;
				}
				}
				ResultSet rs_efs_routing_output1 = stmt.executeQuery("SELECT * FROM cs_routings_output where order_no='"+order_no+"'  and block_code='assembly' and seq_no='1' ");
		  		if (rs_efs_routing_output1 !=null) {
				while (rs_efs_routing_output1.next()){
					item_no_rout.addElement(rs_efs_routing_output1.getString("item_no"));							
					rout_tot_count++;
				}
				}
rs_efs_bpcs_mat_shop_orders.close();
rs_efs_routing_output1.close();
				%>	
				<%@ include file="home.jsp"%>
				<%
		   }
}
else {
		if(edit.equals("1")){ 
			URL output_st = new URL("http://"+application.getInitParameter("HOST")+"/custom/orders/efs/shop.transfer.jsp?sp-q="+order_no+"&cmd=1&t-s=hed");
			BufferedReader in = new BufferedReader(	new InputStreamReader(output_st.openStream()));
			String inputLine;
			while ((inputLine = in.readLine()) != null)
			out.println(inputLine);
			in.close();
		}
		else{
				ResultSet rs_efs_shop_paper1 = stmt.executeQuery("SELECT * FROM cs_efs_shop_paper where order_no like '"+order_no+"' ");
		  		if (rs_efs_shop_paper1 !=null) {
				while (rs_efs_shop_paper1.next()){
				bpcs_no=rs_efs_shop_paper1.getString(2);			
		     	due_date=rs_efs_shop_paper1.getString(3);
				planner=rs_efs_shop_paper1.getString(4);											
				}
				}
			// New adddition for output to BPCS shop order's
				ResultSet rs_cs_materials_output1 = stmt.executeQuery("SELECT * FROM cs_materials_output where order_no like '"+order_no+"' order by item_no");
		  		if (rs_cs_materials_output1 !=null) {
				while (rs_cs_materials_output1.next()){
				item_no.addElement(rs_cs_materials_output1.getString ("item_no"));
				qty.addElement(rs_cs_materials_output1.getString ("qty"));
				text_identifier.addElement(rs_cs_materials_output1.getString ("text_identifier"));				
				bpcs_part_main.addElement(rs_cs_materials_output1.getString ("bpcs_part_main"));				
				bpcs_part_sub.addElement(rs_cs_materials_output1.getString ("bpcs_part_sub"));
				mat_tot_count++;	
				}
				}
				ResultSet rs_efs_routing_output1 = stmt.executeQuery("SELECT * FROM cs_routings_output where order_no='"+order_no+"'  and block_code='assembly' and seq_no='1' ");
		  		if (rs_efs_routing_output1 !=null) {
				while (rs_efs_routing_output1.next()){
					item_no_rout.addElement(rs_efs_routing_output1.getString("item_no"));						
					detail_desc.addElement(rs_efs_routing_output1.getString("detail_desc"));
					rout_tot_count++;
				}
				}
				ResultSet rs_efs_csquotes = stmt.executeQuery("SELECT line_no,qty FROM csquotes where order_no='"+order_no+"' group by line_no,qty	");
		  		if (rs_efs_csquotes !=null) {
				while (rs_efs_csquotes.next()){
					csquotes_line_no.addElement(rs_efs_csquotes.getString("line_no"));				
					csquotes_qty.addElement(rs_efs_csquotes.getString("qty"));					
				}
				}
rs_cs_materials_output1.close();
rs_efs_routing_output1.close();
rs_efs_csquotes.close();
				%>	
				<%@ include file="home.jsp"%>
				<%
		   }
		   

}

// Statment closing
stmt.close();
rs_project.close();
rs_efs_shop_paper.close();
myConn.close();
%>






	




	








	
	








