<%@ page language="java" import="java.sql.*" import="java.text.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<%@ include file="../../../db_con.jsp"%>
<link rel='stylesheet' href='../../quotes/style1.css' type='text/css' />
<html>
	<header>
		<title>
			Shop paper
		</title>
	</header>
	<body>
		<%
		NumberFormat for0 = NumberFormat.getInstance();
		for0.setMaximumFractionDigits(0);
		myConn.setAutoCommit(false);
		String order_no=request.getParameter("order_no");
		//n1
		String bpcs_ord=request.getParameter("bpcs_ord");
		String shop_ord=request.getParameter("shop_ord");
		String cust_po=request.getParameter("cust_po");
		String shipto_shipdate=request.getParameter("shipto_shipdate");
		String name1=request.getParameter("name1");
		String name2=request.getParameter("name2");
		String add1=request.getParameter("add1");
		String add2=request.getParameter("add2");
		String city=request.getParameter("city");
		String state=request.getParameter("state");
		String zip=request.getParameter("zip");
		String hrs_notice=request.getParameter("hrs_notice");
		String attname=request.getParameter("attname");
		String phone=request.getParameter("phone");
		String lastelement=request.getParameter("lastelement");
		String index1=request.getParameter("index1");
		String index2=request.getParameter("index2");
		String layout_done_by=request.getParameter("layout_done_by");
		if(layout_done_by == null || layout_done_by.equals("layout done by")){
			layout_done_by="";
		}
		if(name1 == null || name1.equals("name1")){
			name1="";
		}
		if( name2== null || name2.equals("name2")){
			name2="";
		}
		if( add1== null || add1.equals("address1")){
			add1="";
		}
		if( add2== null || add2.equals("address2")){
			add2="";
		}
		if( city== null || city.equals("city")){
			city="";
		}
		if( state== null || state.equals("state")){
			state="";
		}
		if( zip== null || zip.equals("zip")){
			zip="";
		}
		if( bpcs_ord== null || bpcs_ord.equals("bpcs order no")){
			bpcs_ord="";
		}
		if( shop_ord== null || shop_ord.equals("shop order no")){
			shop_ord="";
		}
		if( cust_po== null || cust_po.equals("customer po")){
			cust_po="";
		}
		if( hrs_notice== null || hrs_notice.equals("hours notice")){
			hrs_notice="";
		}
		if( shipto_shipdate== null || shipto_shipdate.equals("ship date")){
			shipto_shipdate="";
		}
		if( attname== null || attname.equals("attention name")){
			attname="";
		}
		if( phone== null || phone.equals("phone")){
			phone="";
		}
		//l1
		String qtynew=request.getParameter("qtynew");
		String prevshippednew=request.getParameter("prevshippednew");
		String shippednew=request.getParameter("shippednew");
		String marknew=request.getParameter("marknew");
		String descriptnew=request.getParameter("descriptnew");
		String sectnew=request.getParameter("sectnew");
		String ctnnew=request.getParameter("ctnnew");
		String line_no_new=request.getParameter("line_no_new");
		//l5
		String[] qty=request.getParameterValues("qty");
		String[] prevshipped=request.getParameterValues("prevshipped");
		String[] shipped=request.getParameterValues("shipped");
		String[] mark=request.getParameterValues("mark");
		String[] descript=request.getParameterValues("descript");
		String[] sect=request.getParameterValues("sect");
		String[] ctn=request.getParameterValues("ctn");
		String[] rec_no=request.getParameterValues("rec_no");
		String[] line_no=request.getParameterValues("line_no");
		String[] part_number=request.getParameterValues("part_number");
		if(qtynew==null || qtynew.startsWith("QTY")){
			qtynew="";
		}
		if(prevshippednew==null || prevshippednew.startsWith("PREV")){
			prevshippednew="";
		}
		if(shippednew==null || shippednew.startsWith("SHIPPED")){
			shippednew="";
		}
		if(marknew==null || marknew.startsWith("MARK")){
			marknew="";
		}
		if(descriptnew==null || descriptnew.startsWith("DESCRIPTION FOR")){
			descriptnew="";
		}
		if(sectnew==null || sectnew.startsWith("SECTION")){
			sectnew="";
		}
		if(ctnnew==null || ctnnew.startsWith("CTN")){
			ctnnew="";
		}
		/*
		for(int y=0; y<qty.length; y++){
			out.println(qty[y]+"::<BR>");
			out.println(shipped[y]+"::<BR>");
			out.println(mark[y]+"::<BR>");
			out.println(descript[y]+"::<BR>");
			out.println(sect[y]+"::<BR>");
			out.println(ctn[y]+"::<BR>");
			out.println(order_no);
			out.println(rec_no[y]+"::<BR>");
			out.println(line_no[y]+"::<BR><BR>");
		}

		out.println(name1+"::<BR>");
		out.println(name2+"::<BR>");
		out.println(add1+"::<BR>");
		out.println(add2+"::<BR>");
		out.println(city+"::<BR>");
		out.println(state+"::<BR>");
		out.println(zip+"::<BR>");
		out.println(bpcs_ord+"::<BR>");
		out.println(shop_ord+"::<BR>");
		out.println(cust_po+"::<BR>");
		out.println(shipto_shipdate+"::<BR>");
		out.println(attname+"::<BR>");
		out.println(phone+"::<BR>");
		*/


		String n1count="";
		ResultSet rsn1count=stmt.executeQuery("select count(*) from cs_n1 where order_number='"+order_no+"'");
		if(rsn1count != null){
			while(rsn1count.next()){
				n1count=rsn1count.getString(1);
			}
		}
		rsn1count.close();
		if(n1count.equals("0")){
			try{
				String insert ="INSERT INTO cs_n1(order_number,bpcs_ord,shop_ord,cust_po,shipto_shipdate,shipto_name1,shipto_name2,shipto_add1,shipto_add2,shipto_city,shipto_state,shipto_zip,hrs_notice,shipto_attname,shipto_phone,layout_person)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
				PreparedStatement update_customer = myConn.prepareStatement(insert);
				update_customer.setString(1,order_no);
				update_customer.setString(2, bpcs_ord);
				update_customer.setString(3,shop_ord);
				update_customer.setString(4,cust_po);
				update_customer.setString(5,shipto_shipdate);
				update_customer.setString(6,name1);
				update_customer.setString(7,name2);
				update_customer.setString(8,add1);
				update_customer.setString(9,add2);
				update_customer.setString(10,city);
				update_customer.setString(11,state);
				update_customer.setString(12,zip);
				update_customer.setString(13,hrs_notice);
				update_customer.setString(14,attname);
				update_customer.setString(15,phone);
				update_customer.setString(16,layout_done_by);
				int rocount = update_customer.executeUpdate();
				update_customer.close();
			}
			catch (java.sql.SQLException e){
				out.println("Problem with inserting data TO cs_n1 TABLEs"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
		}
		else{
			try{
				String insert ="update cs_n1 set bpcs_ord =?,shop_ord =?,cust_po =?,shipto_shipdate =?,shipto_name1 =?,shipto_name2 =?,shipto_add1 =?,shipto_add2 =?,shipto_city =?,shipto_state =?,shipto_zip =?,hrs_notice =?,shipto_attname =?,shipto_phone =?,layout_person=? WHERE order_number= ? ";
				PreparedStatement update_customer = myConn.prepareStatement(insert);
				update_customer.setString(1, bpcs_ord);
				update_customer.setString(2,shop_ord);
				update_customer.setString(3,cust_po);
				update_customer.setString(4,shipto_shipdate);
				update_customer.setString(5,name1);
				update_customer.setString(6,name2);
				update_customer.setString(7,add1);
				update_customer.setString(8,add2);
				update_customer.setString(9,city);
				update_customer.setString(10,state);
				update_customer.setString(11,zip);
				update_customer.setString(12,hrs_notice);
				update_customer.setString(13,attname);
				update_customer.setString(14,phone);
				update_customer.setString(15,layout_done_by);
				update_customer.setString(16,order_no);
				int rocount = update_customer.executeUpdate();
				update_customer.close();
			}
			catch (java.sql.SQLException e){
				out.println("Problem with updating cs_n1 table"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
		}

		String shipcount="";
		ResultSet rsship=stmt.executeQuery("select count(*) from shipping where order_no='"+order_no+"'");
		if(rsship != null){
			while(rsship.next()){
				shipcount=rsship.getString(1);
			}
		}
		rsship.close();
		if(shipcount.equals("0")){
			try{
				String insertship="insert into shipping(order_no,name_1,name_2,address_1,address_2,city,state,zip_code,attention,phone,special_instructions) Values(?,?,?,?,?,?,?,?,?,?,?)";
				PreparedStatement update_ship=myConn.prepareStatement(insertship);
				update_ship.setString(1,order_no);
				update_ship.setString(2,name1);
				update_ship.setString(3,name2);
				update_ship.setString(4,add1);
				update_ship.setString(5,add2);
				update_ship.setString(6,city);
				update_ship.setString(7,state);
				update_ship.setString(8,zip);
				update_ship.setString(9,attname);
				update_ship.setString(10,phone);
				update_ship.setString(11,hrs_notice);
				int rocount=update_ship.executeUpdate();
				update_ship.close();
			}
			catch (java.sql.SQLException e){
				out.println("Problem with inserting data TO shipping TABLEs"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
		}
		else{
			try{
				String insertship="update shipping set name_1=?,name_2=?,address_1=?,address_2=?,city=?,state=?,zip_code=?,attention=?,phone=?,special_instructions=? where order_no=?";
				PreparedStatement update_ship=myConn.prepareStatement(insertship);
				update_ship.setString(1,name1);
				update_ship.setString(2,name2);
				update_ship.setString(3,add1);
				update_ship.setString(4,add2);
				update_ship.setString(5,city);
				update_ship.setString(6,state);
				update_ship.setString(7,zip);
				update_ship.setString(8,attname);
				update_ship.setString(9,phone);
				update_ship.setString(10,hrs_notice);
				update_ship.setString(11,order_no);
				int rocount=update_ship.executeUpdate();
				update_ship.close();
			}
			catch (java.sql.SQLException e){
				out.println("Problem with updating shipping table"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}

		}

		for(int i=0; i<qty.length; i++){
			if((qty[i].trim().length()>0&&!qty[i].startsWith("QTY"))||(descript[i].length()>0&&!descript[i].startsWith("DESCRIPTION TO ADD"))){
				if(qty[i]== null || qty[i].startsWith("QTY")){
					qty[i]="";
				}
				//out.println(line_no[i]+"::"+shipped[i]+":::"+sect[i]+":::"+ctn[i]+"<BR><BR>");
				if(shipped[i]== null ||shipped[i].trim().length()==0|| shipped[i].startsWith("SHIPPED")){
					shipped[i]="0";
				}
				if(shipped[i]== null || shipped[i].trim().length()==0||shipped[i].startsWith("PREV S")){
					shipped[i]="0";
				}
				if(prevshipped[i]== null || prevshipped[i].trim().length()==0||prevshipped[i].startsWith("SHIPPED")){
					prevshipped[i]="0";
				}
				if(prevshipped[i]== null || prevshipped[i].trim().length()==0||prevshipped[i].startsWith("PREV S")){
					prevshipped[i]="0";
				}
				if(mark[i]== null || mark[i].startsWith("MARK")){
					mark[i]="";
				}
				if(descript[i]== null || descript[i].startsWith("DESCRIPTION TO ADD")){
					descript[i]="";
				}
				if(sect[i]== null || sect[i].startsWith("SECT")){
					sect[i]="";
				}
				if(ctn[i]== null || ctn[i].startsWith("CTN")){
					ctn[i]="";
				}
				String shippedx="0";
				shippedx=""+for0.format(new Double((new Double(prevshipped[i]).doubleValue()+new Double(shipped[i]).doubleValue())).doubleValue());
				//out.println(rec_no[i]+"::"+descript[i]+"::<BR>");
				if(part_number[i].trim().length()>0){
					if(part_number[i]=="99-99-999"){
						//update
						try{



							String insert ="update cs_l5 set part_quantity=?,shipped=?,mark_#=?,description=?,sect=?,ctn=? WHERE order_number= ? and rec_no=? and order_line_no=?";
							//out.println(insert+"::"+rec_no[i]+":<BR>");
							PreparedStatement updatel5 = myConn.prepareStatement(insert);
							updatel5.setString(1,qty[i]);
							updatel5.setString(2,shippedx);
							updatel5.setString(3,mark[i]);
							updatel5.setString(4,descript[i]);
							updatel5.setString(5,sect[i]);
							updatel5.setString(6,ctn[i]);
							updatel5.setString(7,order_no);
							updatel5.setString(8,rec_no[i]);
							updatel5.setString(9,line_no[i]);
							int rocount = updatel5.executeUpdate();
							updatel5.close();

						}
						catch (java.sql.SQLException e){
							out.println("Problem with updating cs_l5 table"+"<br>");
							out.println("Illegal Operation try again/Report Error"+"<br>");
							myConn.rollback();
							out.println(e.toString());
							return;
						}
					}
					else{
						//update
						try{
							String insert ="update cs_l5 set part_quantity=?,shipped=?,mark_#=?,description=?,sect=?,ctn=? WHERE order_number= ? and rec_no=? and order_line_no=?";
							//out.println(insert+rec_no[i]+"<BR>");
							PreparedStatement updatel5 = myConn.prepareStatement(insert);
							updatel5.setString(1,qty[i]);
							updatel5.setString(2,shippedx);
							updatel5.setString(3,mark[i]);
							updatel5.setString(4,descript[i]);
							updatel5.setString(5,sect[i]);
							updatel5.setString(6,ctn[i]);
							updatel5.setString(7,order_no);
							updatel5.setString(8,rec_no[i]);
							updatel5.setString(9,line_no[i]);
							int rocount = updatel5.executeUpdate();
							updatel5.close();

						}
						catch (java.sql.SQLException e){
							out.println("Problem with updating cs_l5 table"+"<br>");
							out.println("Illegal Operation try again/Report Error"+"<br>");
							myConn.rollback();
							out.println(e.toString());
							return;
						}
					}

				}

				else{
					//insert
					try{
						String insert ="INSERT INTO cs_l5(order_number,rec_no,order_line_no,part_quantity,shipped,mark_#,description,sect,ctn,notes,product_id,part_number)VALUES(?,?,?,?,?,?,?,?,?,?,?,?) ";
						PreparedStatement updatel5 = myConn.prepareStatement(insert);
						updatel5.setString(1,order_no);
						updatel5.setString(2,rec_no[i]);
						updatel5.setString(3,line_no[i]);
						updatel5.setString(4,qty[i]);
						updatel5.setString(5,shippedx);
						updatel5.setString(6,mark[i]);
						updatel5.setString(7,descript[i]);
						updatel5.setString(8,sect[i]);
						updatel5.setString(9,ctn[i]);
						updatel5.setString(10,"userentered");
						updatel5.setString(11,"LVR");
						updatel5.setString(12,"99-99-999");
						int rocount = updatel5.executeUpdate();
						updatel5.close();
					}
					catch (java.sql.SQLException e){
						out.println("Problem with inserting into  cs_l5 table"+"<br>");
						out.println("Illegal Operation try again/Report Error"+"<br>");
						myConn.rollback();
						out.println(e.toString());
						return;
					}
				}

			}
		}
		if((qtynew.trim().length()>0&&!qtynew.startsWith("QTY"))||(descriptnew.length()>0&&!descriptnew.startsWith("DESCRIPTION FOR NEW"))){
			if(qtynew== null || qtynew.startsWith("QTY")){
				qtynew="";
			}
			if(marknew== null || marknew.startsWith("MARK")){
				marknew="";
			}
			if(descriptnew== null || descriptnew.startsWith("DESCRIPTION FOR NEW")){
				descriptnew="";
			}
			try{
				String insert ="INSERT INTO cs_l1(order_number,order_line_no,product_id,mark_#,quantity,descript)VALUES(?,?,?,?,?,?) ";
				PreparedStatement updatel1 = myConn.prepareStatement(insert);
				updatel1.setString(1,order_no);
				updatel1.setString(2,line_no_new);
				updatel1.setString(3,"LVR");
				updatel1.setString(4,marknew);
				updatel1.setString(5,qtynew);
				updatel1.setString(6,descriptnew);
				int rocount = updatel1.executeUpdate();
				updatel1.close();
			}
			catch (java.sql.SQLException e){
				out.println("Problem with inserting into  cs_l1 table"+"<br>");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}
		}
		myConn.commit();
		stmt.close();
		myConn.close();


		}
		catch(Exception e){
		out.println(e);
		}
		%>
	<body onLoad="javascript:document.location.href='shoppaper_edit.jsp?order_no=<%=order_no%>&lastelement=<%=lastelement%>&index1=<%=index1%>&index2=<%=index2%>'">