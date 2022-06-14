<%@ page language="java" import="java.util.*" import="java.sql.*" import="java.net.*" import="java.io.*" errorPage="error.jsp" %>
<%
// cs_efs_shoppaper header 
		String order_no = request.getParameter("order_no");//	
		String bpcs_no = request.getParameter("bpcs_no");//	
		String due_date = request.getParameter("due_date");//
		String planner = request.getParameter("planner");//						
// cs_materials_output
int shop_orders = new Integer(request.getParameter("shop_orders")).intValue();//
%>
<%@ include file="db_con.jsp"%>
<% 	
				myConn.setAutoCommit(false);
	try
			{				
				int nrow= stmt.executeUpdate("delete from cs_efs_shop_paper WHERE order_no like '"+order_no+"'");
				int nrow1= stmt.executeUpdate("delete from cs_bpcs_mat_shop_orders WHERE cse_order_no like '"+order_no+"'");
				
			}
			catch (java.sql.SQLException e)
			{
				out.println("Problem with deleting the efs shop paper header info"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
			
			try	{				
				String insert ="INSERT INTO cs_efs_shop_paper(order_no,bpcs_order_no,due_date,planner)VALUES(?,?,?,?) ";	
				PreparedStatement update_customer = myConn.prepareStatement(insert);	
			          	update_customer.setString(1,order_no);
			          	update_customer.setString(2,bpcs_no);			
			          	update_customer.setString(3,due_date);
			          	update_customer.setString(4,planner);						
						int rocount = update_customer.executeUpdate();
						update_customer.close();
				}
				catch (java.sql.SQLException e)
				{
					out.println("Problem with ENTERING THE  EFS  Header info "+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					myConn.rollback();
					out.println(e.toString());
					return;
				}

				try	{
				String seq_no="seq_no";String product="product";String bpcs_part_no="bpcs_part_no";String qty="qty";String item_no="item_no";String shop_order="shop_order";String C="C";
					 for (int ik=1;ik<=shop_orders;ik++){
					 //seq_no,product,bocs_part_no,qty,item_no	 
						 	seq_no=seq_no+ik;
							product=product+ik;
							bpcs_part_no=bpcs_part_no+ik;
							item_no=item_no+ik;
							shop_order=shop_order+ik;
//out.println("shop # "+ik+" >"+request.getParameter(shop_order).trim()+"<");
							qty=qty+ik;		
							C=C+ik;
							String transfer=request.getParameter(C);
							if (transfer==null){transfer="N";}else {transfer="Y";}		
								String insert ="INSERT INTO cs_bpcs_mat_shop_orders(cse_order_no,seq_no,prod_desc,bpcs_part_sub,item_no,bpcs_shop_order_no,transfer,qty)VALUES(?,?,?,?,?,?,?,?) ";	
						        PreparedStatement update_mat_shop_orders = myConn.prepareStatement(insert);	
					          	update_mat_shop_orders.setString(1,order_no);
					          	update_mat_shop_orders.setString(2,request.getParameter(seq_no));			
					          	update_mat_shop_orders.setString(3,request.getParameter(product));
					          	update_mat_shop_orders.setString(4,request.getParameter(bpcs_part_no));
					          	update_mat_shop_orders.setString(5,request.getParameter(item_no));
					          	update_mat_shop_orders.setString(6,request.getParameter(shop_order).trim());
					          	update_mat_shop_orders.setString(7,transfer);	
					          	update_mat_shop_orders.setString(8,request.getParameter(qty));
								int rocount = update_mat_shop_orders.executeUpdate();
								update_mat_shop_orders.close();
								seq_no="seq_no";product="product";bpcs_part_no="bpcs_part_no";qty="qty";item_no="item_no";shop_order="shop_order";C="C";								
					 }
				}
				catch (java.sql.SQLException e)
				{
					out.println("Problem with ENTERING THE  EFS 2 Header info "+shop_orders+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					myConn.rollback();
					out.println(e.toString());
					return;
				}
myConn.commit();
myConn.close();	

// once it is saved the first report is shown
URL output_st = new URL("https://"+application.getInitParameter("HOST")+"/custom/orders/efs/shop.transfer.jsp?cmd=3&sp-q="+order_no+"&t-s=hed");
BufferedReader in = new BufferedReader(	new InputStreamReader(output_st.openStream()));
	String inputLine;
	while ((inputLine = in.readLine()) != null)
out.println(inputLine);
in.close();
%>	
