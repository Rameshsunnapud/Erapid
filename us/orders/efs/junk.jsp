 for (int i=0;i<counter;i++){
		try
		{				
		String insert ="update cs_bpcs_mat_shop_orders set trasnfer=?,bpcs_transfer=? WHERE cse_order_no= ? and bpcs_shop_order_no=?";	
		PreparedStatement update_customer = myConn.prepareStatement(insert);	
	          	update_customer.setString(1,"N");
				update_customer.setString(2,"Y");
				update_customer.setString(3,order_no);
				update_customer.setString(4,shop_order_no.elementAt(i) );
				int rocount = update_customer.executeUpdate();
				update_customer.close();
		}
		catch (java.sql.SQLException e)
		{
			out.println("Problem with Updating customer TABLEs"+"<br>");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}
}

			
			 for(int i=0;i<counter;i++){
						 final_out=final_out+i;
						 final_out=final_out+" "+"MN";
						 final_out=final_out+" "+part_sub.elementAt(i);
						 final_out=final_out+" "+qty.elementAt(i);
						 final_out=final_out+" "+"  ";
	 	 				 final_out=final_out+" "+"N";
					 	 final_out=final_out+" "+"2";
						 final_out=final_out+" "+shop_order_no.elementAt(i);						 						 												 						 						
				         BufferedWriter out1 = new BufferedWriter(new FileWriter(dir_path+"\\"+"B"+shop_order_no.elementAt(i)+"01_"+".txt"));
						 out1.write(final_out);
						 out.write("out put done "+"<br>");
 						 out.flush();
						 out1.flush();
						 out1.close();
				 }

				 
				 
//				  out.println("Test"+product_desc.elementAt(i).toString()+"item_no"+shop_item_no.elementAt(i).toString()+"<br>");
			   			for(int k=0;k<counter1;k++){
							if( (shop_item_no.elementAt(i).toString().equals(item_no.elementAt(k).toString())) & (!(text_identifier.elementAt(k).toString().startsWith("FRAME"))) ){
						       out.println("The product"+item_no.elementAt(k)+"::"+part_no.elementAt(k)+"<br>");
							}
					    }
				 