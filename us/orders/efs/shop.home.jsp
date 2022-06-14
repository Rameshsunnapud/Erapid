<%@ page language="java" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" errorPage="error.jsp" %>
<% 		String order_no = request.getParameter("sp-q");//	
 		String edit = request.getParameter("eh-q");//	
%>	
<%@ include file="db_con.jsp"%>
<%@ include file="../../quotes/db_con_bpcsusr.jsp"%>
<%
HttpSession UserSession1 = request.getSession();
String name="";
if(UserSession1.getValue("userNameRQS") != null){
	name=UserSession1.getValue("userNameRQS").toString();
}
else{
	name="";
}

//out.println("Test"+name);
		if(edit.equals("1")){ 
			URL output_st = new URL("https://"+application.getInitParameter("HOST")+"/custom/orders/efs/shop.transfer.jsp?sp-q="+order_no+"&cmd=3&t-s=hed");
			BufferedReader in = new BufferedReader(	new InputStreamReader(output_st.openStream()));
			String inputLine;
			while ((inputLine = in.readLine()) != null)
			out.println(inputLine);
			in.close();
		}
		else{
		
			//vars for editing the header info
			String due_date="";String bpcs_no="";String planner="";String dept="";String project_name="";
			// For the bill of materials transfer
			Vector item_no=new Vector();
			Vector qty=new Vector();
			Vector text_identifier=new Vector();
			Vector bpcs_part_main=new Vector();
			Vector bpcs_part_sub=new Vector();
			Vector detail_desc=new Vector();
			Vector item_no_rout=new Vector();int rout_tot_count=0;int mat_tot_count=0;
			Vector frame_counter=new Vector();Vector rout_sum_bpcs_part_main=new Vector();Vector rout_sum_bpcs_part_sub=new Vector();
			int count_shop=0;int bpcs_mat_count=0;int frame_count=0;
			// For the bill of materials transfer end
			//vars for the bpcs_mat_shop_orders begin 
			Vector bpcs_shop_order_no=new Vector();	Vector bpcs_part_sub_bpcs=new Vector();	Vector qty_bpcs=new Vector();
			Vector item_no_bpcs=new Vector();Vector seq_no=new Vector();Vector detail_desc_bpcs=new Vector();int bpcs_mat_tot_count=0;			
			Vector transfer=new Vector();Vector transfer_bpcs=new Vector();						
			//vars for the bpcs_mat_shop_orders end

			
			
			
					ResultSet rs_project = stmt.executeQuery("SELECT Project_name FROM cs_project where Order_no like '"+order_no+"' ");
			  		if (rs_project !=null) {
					while (rs_project.next()){
					project_name=rs_project.getString(1);
											 }
											}
				ResultSet rs_efs_shop_paper1 = stmt.executeQuery("SELECT * FROM cs_efs_shop_paper where order_no like '"+order_no+"' ");
		  		if (rs_efs_shop_paper1 !=null) {
				while (rs_efs_shop_paper1.next()){
					 bpcs_no=rs_efs_shop_paper1.getString(2);			
		     		 due_date=rs_efs_shop_paper1.getString(3);
					 planner=rs_efs_shop_paper1.getString(4);
					 count_shop++;											
				}
				}
		  		String ship_date="";
		  		ResultSet rs_ship = stmt.executeQuery("SELECT * FROM SHIPPING where Order_no like '"+order_no+"' ");
		  		if (rs_ship !=null) {
		        while (rs_ship.next()) {
		        	ship_date= rs_ship.getString("request_date");
		        }		        
		  		}
		  		rs_ship.close();
		  		if(planner==null|planner.trim().equals("")){planner=name;};
		  		if(due_date==null|due_date.trim().equals("")){due_date=ship_date;};
		  		
		  		//getting BPCS order no
		  		String bpcs_order_no="";int count_ord=0;
		  		String sql_bpcs="SELECT C.HOORD FROM BPCSUSRFFG.CEH AS C WHERE C.HOQUT='"+order_no+"' GROUP BY C.HOORD";
				   ResultSet rs_bpcs12 = stmt_bpcsusr.executeQuery(sql_bpcs);
			       while ( rs_bpcs12.next() ) {
			    	   bpcs_order_no=rs_bpcs12.getString(1);
			    	   count_ord++;
	          						        }
			       rs_bpcs12.close();
			       stmt_bpcsusr.close();
			       con_bpcsusr.close();
			       if(count_ord>0){if( bpcs_no==null| bpcs_no.trim().equals("")){ bpcs_no=bpcs_order_no;};}
				// To check if there are any lines in
				ResultSet rs_efs_bpcs_mat_shop_orders = stmt.executeQuery("SELECT * FROM cs_bpcs_mat_shop_orders where cse_order_no like '"+order_no+"' ");
		  		if (rs_efs_bpcs_mat_shop_orders !=null) {
				while (rs_efs_bpcs_mat_shop_orders.next()){
				seq_no.addElement(rs_efs_bpcs_mat_shop_orders.getString ("seq_no"));
				detail_desc_bpcs.addElement(rs_efs_bpcs_mat_shop_orders.getString("prod_desc"));
				bpcs_part_sub_bpcs.addElement(rs_efs_bpcs_mat_shop_orders.getString ("bpcs_part_sub"));
				qty_bpcs.addElement(rs_efs_bpcs_mat_shop_orders.getString ("qty"));				
				item_no_bpcs.addElement(rs_efs_bpcs_mat_shop_orders.getString ("item_no"));
				bpcs_shop_order_no.addElement(rs_efs_bpcs_mat_shop_orders.getString ("bpcs_shop_order_no"));
				transfer.addElement(rs_efs_bpcs_mat_shop_orders.getString ("transfer"));
//				transfer_bpcs.addElement(rs_efs_bpcs_mat_shop_orders.getString ("bpcs_transfer"));
				bpcs_mat_tot_count++;
				}
				}
			
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
				ResultSet rs_efs_rout_sum = stmt.executeQuery("SELECT bpcs_part_main,bpcs_part_sub FROM cs_routings_output where order_no='"+order_no+"' and block_code like 'frame%' group by bpcs_part_main,bpcs_part_sub");
		  		if (rs_efs_rout_sum !=null) {
				while (rs_efs_rout_sum.next()){
					rout_sum_bpcs_part_main.addElement(rs_efs_rout_sum.getString(1));				
					rout_sum_bpcs_part_sub.addElement(rs_efs_rout_sum.getString(2));
					frame_count++;
				}
				}
				//
				int ikea=0;Vector transfered_jobs=new Vector();Vector transfered_shop_no=new Vector();Vector transfered_counter=new Vector();
				ResultSet rs_bpcs_mat_transfered_jobs = stmt.executeQuery("SELECT * FROM cs_bpcs_mat_transfered_jobs where cse_order_no like '"+order_no+"' ");
				if (rs_bpcs_mat_transfered_jobs !=null) {
				while (rs_bpcs_mat_transfered_jobs.next()){
				transfered_shop_no.addElement(rs_bpcs_mat_transfered_jobs.getString("bpcs_shop_order_no"));				
				transfered_jobs.addElement(rs_bpcs_mat_transfered_jobs.getString("transfer"));					
				transfered_counter.addElement(rs_bpcs_mat_transfered_jobs.getString("counter"));									
				ikea++;
				}
				}
				%>	
				<%@ include file="home.jsp"%>
				<%				
				// Statment closing
				stmt.close();
				rs_project.close();
				rs_efs_shop_paper1.close();
				rs_cs_materials_output1.close();
	//			rs_efs_bpcs_mat_shop_orders.close();
				rs_efs_routing_output1.close();
//				rs_efs_csquotes.close();
				rs_bpcs_mat_transfered_jobs.close();
				rs_efs_rout_sum.close();
				myConn.close();
				
		   }		   

%>
	      
	      	      
		  	  

	                                                
 	        
                                         
    

	