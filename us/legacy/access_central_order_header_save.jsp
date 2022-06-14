<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<html><HEAD>
		<title>Order Header Save</title>
		<link rel='stylesheet' href='style1.css' type='text/css' />
		<SCRIPT LANGUAGE="JavaScript">
			<!-- Begin
		function n_window(theurl)
			{
				// set width and height
				var the_width=800;
				var the_height=625;
				// set window position
				var from_top=0;
				var from_left=125;
				// set other attributes
				var has_toolbar='no';
				var has_location='no';
				var has_directories='no';
				var has_status='yes';
				var has_menubar='yes';
				var has_scrollbars='yes';
				var is_resizable='yes';
				// atrributes put together
				var the_atts='width='+the_width+',height='+the_height+',top='+from_top+',screenY='+from_top+',left='+from_left+',screenX='+from_left;
				the_atts+=',toolbar='+has_toolbar+',location='+has_location+',directories='+has_directories+',status='+has_status;
				the_atts+=',menubar='+has_menubar+',scrollbars='+has_scrollbars+',resizable='+is_resizable;
				// open the window
				window.open(theurl,'',the_atts);
			}
			function forwardUrl(){
				x=document.selectform.url.value;
				//alert(x);
				document.location.href=x;
			}

			//-->


		</script>
	</HEAD>
	<BODY bgcolor="whitesmoke" onload="forwardUrl()">
	<center>
		<!--<h1 align="left">Out Put</h1>-->
		<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con.jsp"%>
		<%
		//HttpSession UserSession1 = request.getSession();
		//String name= UserSession1.getAttribute("username").toString();
		String name="gsuisham";
		String order_no = request.getParameter("order_no");//
		String agent_name=request.getParameter("agent_name");
		//out.println(agent_name+"::<BR>");
		String order_count = request.getParameter("order_count");
		String arch_count = request.getParameter("arch_count");
		String bill_count = request.getParameter("bill_count");
		String cust_po_no=request.getParameter("cust_po_no");
		if(cust_po_no == null || cust_po_no.equals("null")){
			cust_po_no="";
		}
		String n1count=request.getParameter("n1count");
		if(n1count==null || n1count.equals("null")||n1count.trim().length()==0){
			n1count="0";
		}
		String rep_no = request.getParameter("rep_no");
		//billing info
		String cust_name= request.getParameter("cust_name");
		String cust_loc= request.getParameter("cust_loc");
		//architectinfo
		String arch_name= request.getParameter("arch_name");
		String arch_loc= request.getParameter("arch_loc");
		//Order info
		String layout_doneby=request.getParameter("layout_doneby");
		String detailer=request.getParameter("detailer");
		String checker=request.getParameter("checker");
		String drawing_date=request.getParameter("drawing_date");
		boolean drawDate=true;
		//out.println(drawing_date+"::Drawing date<BR>");
		if(drawing_date == null || drawing_date.equals("null")||drawing_date.trim().length()<1){
			drawDate=false;
		}
		String project_desc=request.getParameter("project_desc");
		//Ship info
		String ship_count = request.getParameter("ship_count");
		String ship_name= request.getParameter("ship_name");
		String ship_name2= request.getParameter("ship_name2");
		String ship_addr1= request.getParameter("Address_1");
		String ship_addr2= request.getParameter("Address_2");
		String city= request.getParameter("city");
		String state= request.getParameter("state");
		String zip= request.getParameter("zip_code");
		String ship_phone= request.getParameter("phone");
		String ship_country= request.getParameter("country");
		String ship_attention= request.getParameter("attention");
		String ship_date= request.getParameter("ship_date");
		boolean shipDate=true;
		if(ship_date == null || ship_date.equals("null")||ship_date.trim().length()<1){
			shipDate=false;
		}
		String ship_inst= request.getParameter("special_instructions");
		//project info
		String bpcs_order_no=request.getParameter("bpcs_order_no");
		String bpcs_work_order_no=request.getParameter("bpcs_work_order_no");
		//out.println(bpcs_order_no+"::"+bpcs_work_order_no+"<BR>");


		// update project table by Greg dec 8/05
		try	{
			String insert ="update cs_project set bpcs_order_no=?,bpcs_work_order_no=? WHERE order_no= ? ";
			PreparedStatement update_project = myConn.prepareStatement(insert);
			update_project.setString(1,bpcs_order_no);
			update_project.setString(2,bpcs_work_order_no);
			update_project.setString(3,order_no);
			int rocount = update_project.executeUpdate();
			//out.println(rocount+" update project<BR>");
			update_project.close();
		}
		catch (java.sql.SQLException e){
			out.println("Problem with Updating data TO cs_project TABLEs"+"<br>");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}

		if(bill_count.equals("0")){
			// Getting the new billed customer number from the
			ResultSet rs = stmt.executeQuery("select rec_no from rec_no_control where tablename='billed_customers'");
			String cust_no="";int number=0;
			while(rs.next())
				{
				 cust_no = rs.getString("rec_no");
				number=Integer.parseInt(cust_no);
				}
			// cs_billed_customers inserting
			number++;
				try
				{
					int nrow= stmt.executeUpdate("UPDATE rec_no_control SET rec_no ="+number+" WHERE tablename ='billed_customers'");
					//myConn.commit();
				}
				catch (java.sql.SQLException e)
				{
					out.println("Problem with Updating rec_no_control"+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					myConn.rollback();
					out.println(e.toString());
					return;
				}
			number--;

		try	{
			String insert ="INSERT INTO cs_billed_customers(order_no,cust_name1,city,cust_no,country_code,created_rep_no)VALUES(?,?,?,?,?,?) ";
			PreparedStatement update_customer = myConn.prepareStatement(insert);
					update_customer.setString(1,order_no);
					update_customer.setString(2,cust_name);
					update_customer.setString(3,cust_loc);
					update_customer.setInt(4,number);
					update_customer.setString(5,"US");
					update_customer.setString(6,rep_no);
					int rocount = update_customer.executeUpdate();
					update_customer.close();
			}
			catch (java.sql.SQLException e)
			{
				out.println("Problem with InsertING data TO cs_billed_customers TABLEs"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
		}
		else{
				try	{
						String insert ="update cs_billed_customers set cust_name1=?,city=? WHERE order_no= ? ";
						PreparedStatement update_customer = myConn.prepareStatement(insert);
						update_customer.setString(1,cust_name);
						update_customer.setString(2,cust_loc);
						update_customer.setString(3,order_no);
						int rocount = update_customer.executeUpdate();
						update_customer.close();
				}
				catch (java.sql.SQLException e)
				{
					out.println("Problem with UpdatING data TO cs_billed_customers TABLEs"+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					myConn.rollback();
					out.println(e.toString());
					return;
				}
		}


		if(arch_count.equals("0")){
		try	{
			String insert ="INSERT INTO cs_order_architects(order_no,name1,city)VALUES(?,?,?) ";
			PreparedStatement update_customer = myConn.prepareStatement(insert);
					update_customer.setString(1,order_no);
					update_customer.setString(2,arch_name);
					update_customer.setString(3,arch_loc);
					int rocount = update_customer.executeUpdate();
					update_customer.close();
			}
			catch (java.sql.SQLException e)
			{
				out.println("Problem with InsertING data TO cs_order_architect TABLEs"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
		}
		else{
				try	{
						String insert ="update cs_order_architects set name1=?,city=? WHERE order_no= ? ";
						PreparedStatement update_customer = myConn.prepareStatement(insert);
						update_customer.setString(1,arch_name);
						update_customer.setString(2,arch_loc);
						update_customer.setString(3,order_no);
						int rocount = update_customer.executeUpdate();
						update_customer.close();
				}
				catch (java.sql.SQLException e)
				{
					out.println("Problem with UpdatING data TO cs_order_architect TABLEs"+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					myConn.rollback();
					out.println(e.toString());
					return;
				}
		}

		if(order_count.equals("0")){
		try	{
			String insert ="";
			if(drawDate){
				insert="INSERT INTO cs_order_info(order_no,layout_done_by,detailer_initial,checker_initial,project_desc,agent_name,drawing_date)VALUES(?,?,?,?,?,?,?) ";
			}
			else{
				insert="INSERT INTO cs_order_info(order_no,layout_done_by,detailer_initial,checker_initial,agent_name,project_desc)VALUES(?,?,?,?,?,?) ";
			}

			PreparedStatement update_customer = myConn.prepareStatement(insert);
					update_customer.setString(1,order_no);
						update_customer.setString(2,layout_doneby);
					update_customer.setString(3,detailer);
					update_customer.setString(4,checker);
					update_customer.setString(5,project_desc);
					update_customer.setString(6,agent_name);
					if(drawDate){
						update_customer.setString(7,drawing_date);
					}
					int rocount = update_customer.executeUpdate();
					update_customer.close();
			}
			catch (java.sql.SQLException e)
			{
				out.println("Problem with InsertING data TO order info TABLEs"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
		}
		else{
				try	{
						String insert="";
						if(drawDate){
							insert ="update cs_order_info set layout_done_by=?,detailer_initial=?,checker_initial=?,agent_name=?,drawing_date=?,project_desc=? WHERE order_no= ? ";
						}
						else{
							insert ="update cs_order_info set layout_done_by=?,detailer_initial=?,checker_initial=?,agent_name=?,project_desc=? WHERE order_no= ? ";
						}
						PreparedStatement update_customer = myConn.prepareStatement(insert);
						update_customer.setString(1,layout_doneby);
						update_customer.setString(2,detailer);
						update_customer.setString(3,checker);
						update_customer.setString(4,agent_name);
						if(drawDate){
							update_customer.setString(5,drawing_date);
							update_customer.setString(6,project_desc);
							update_customer.setString(7,order_no);
						}
						else{
							update_customer.setString(5,project_desc);
							update_customer.setString(6,order_no);
						}
						int rocount = update_customer.executeUpdate();
						update_customer.close();
				}
				catch (java.sql.SQLException e)
				{
					out.println("Problem with UpdatING data TO order info TABLEs2"+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					myConn.rollback();
					out.println(e.toString());
					return;
				}
		}

		//Shiiping information
		if(ship_count.equals("0")){
		// Inserting the shipping info
				try	{
					String insert ="";
					if(shipDate){
						insert="INSERT INTO SHIPPING(Order_no,Name_1,Name_2,Address_1,Address_2,City,State,Zip_code,country,Phone,attention,special_instructions,ship_date)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?) ";
					}
					else{
						insert="INSERT INTO SHIPPING(Order_no,Name_1,Name_2,Address_1,Address_2,City,State,Zip_code,country,Phone,attention,special_instructions)VALUES(?,?,?,?,?,?,?,?,?,?,?,?) ";
					}
					PreparedStatement update_customer = myConn.prepareStatement(insert);
							update_customer.setString(1,order_no);
							update_customer.setString(2,ship_name);
							update_customer.setString(3,ship_name2);
							update_customer.setString(4,ship_addr1);
							update_customer.setString(5,ship_addr2);
							update_customer.setString(6,city);
							update_customer.setString(7,state);
							update_customer.setString(8,zip);
							update_customer.setString(9,ship_country);
							update_customer.setString(10,ship_phone);
							update_customer.setString(11,ship_attention);
							update_customer.setString(12,ship_inst);
							if(shipDate){
								update_customer.setString(13,ship_date);
							}
							int rocount = update_customer.executeUpdate();
							update_customer.close();
					}
					catch (java.sql.SQLException e)
					{
						out.println("Problem with Inserting data TO Shipping TABLEs3"+"<br>");
						out.println("Illegal Operation try again/Report Error"+"<br>");
						myConn.rollback();
						out.println(e.toString());
						return;
					}
		}else{
				try	{
					String insert ="";
					if(shipDate){
						insert ="update shipping	set Name_1=?,Name_2=?,Address_1=?,Address_2=?,city=?,state=?,zip_code=?,country=?,phone=?,attention=?,ship_date=?,special_instructions=? WHERE order_no= ? ";
					}
					else{
						insert ="update shipping	set Name_1=?,Name_2=?,Address_1=?,Address_2=?,city=?,state=?,zip_code=?,country=?,phone=?,attention=?,special_instructions=? WHERE order_no= ? ";
					}
					PreparedStatement update_customer = myConn.prepareStatement(insert);
							update_customer.setString(1,ship_name);
							update_customer.setString(2,ship_name2);
							update_customer.setString(3,ship_addr1);
							update_customer.setString(4,ship_addr2);
							update_customer.setString(5,city);
							update_customer.setString(6,state);
							update_customer.setString(7,zip);
							update_customer.setString(8,ship_country);
							update_customer.setString(9,ship_phone);
							update_customer.setString(10,ship_attention);
							if(shipDate){
								update_customer.setString(11,ship_date);
								update_customer.setString(12,ship_inst);
								update_customer.setString(13,order_no);
							}
							else{
								//update_customer.setString(11,ship_date);
								update_customer.setString(11,ship_inst);
								update_customer.setString(12,order_no);
							}
							int rocount = update_customer.executeUpdate();
							update_customer.close();
					}
					catch (java.sql.SQLException e)
					{
						out.println("Problem with Updating data TO Shipping TABLEs4"+"<br>");
						out.println("Illegal Operation try again/Report Error"+"<br>");
						myConn.rollback();
						out.println(e.toString());
						return;
					}
		}

		if(n1count.equals("0")){
		//out.println("HERE1"+cust_po_no);
			try{
			String insert ="INSERT INTO cs_n1(order_number,cust_po)VALUES(?,?) ";
			PreparedStatement update_customer = myConn.prepareStatement(insert);
					update_customer.setString(1,order_no);
						update_customer.setString(2,cust_po_no);
					int rocount = update_customer.executeUpdate();
					update_customer.close();
			}
			catch (java.sql.SQLException e)
			{
				out.println("Problem with InsertING data TO cs_n1 TABLEs"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
		}
		else{
		//out.println("here2"+cust_po_no);
				try	{
						String insert ="update cs_n1 set cust_po=? WHERE order_number= ? ";
						PreparedStatement update_customer = myConn.prepareStatement(insert);
							update_customer.setString(1,cust_po_no);
						update_customer.setString(2,order_no);
						int rocount = update_customer.executeUpdate();
						update_customer.close();
				}
				catch (java.sql.SQLException e)
				{
					out.println("Problem with UpdatING data TO cs_order_architect TABLEs"+"<br>");
					out.println("Illegal Operation try again/Report Error"+"<br>");
					myConn.rollback();
					out.println(e.toString());
					return;
				}
		}
		//

		String doc_type=null;String win_loss=null;
		ResultSet rs_project = stmt.executeQuery("SELECT doc_type,win_loss FROM doc_header where doc_number like '"+order_no+"'");
				if (rs_project !=null) {
			   while (rs_project.next()) {
				doc_type= rs_project.getString("doc_type");
				win_loss= rs_project.getString("win_loss");
									    }
								   }
								  // myConn.commit();

		stmt.close();
		myConn.close();

		String url="access_central_idg.jsp?environment=Development&doc_revision=1&doc_type="+ doc_type +"&doc_number="+ order_no +"&username="+name+"&silent=true";
		%>
		<form name="selectform" >
			<input type='hidden' name='url' value='<%=url%>'>
		</form>
	</center>
</body>
</html>
<%

 }
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>