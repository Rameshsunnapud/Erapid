<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.lang.*" import="java.io.*" import="java.text.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="../../../db_con.jsp"%>
<html>

	<script language="Javascript">
		function forwardElogia(){
			//alert(document.createInt.url.value);
			if(document.createInt.createTxt.value=="true"){
				var x=document.createInt.url.value+"?environment=Development&doc_number="+document.createInt.doc_number.value+"&doc_revision=1&doc_type="+document.createInt.doc_type.value+"&username="+document.createInt.username.value+"&silent=true";
				//alert(x);
				document.location.href=x;
			}
			else{
				//alert("false");
				//window.close();
				window.parent.postMessage("*","*");
				//document.location.href="order_list.jsp?order_no="+document.nocreate.doc_number.value;
			}
		}
	</script>



	<body onLoad="javascript:forwardElogia();">
		<%
		String order_no=request.getParameter("doc_number");
		String environment=request.getParameter("environment");
		String doc_revision=request.getParameter("doc_revision");
		String doc_type=request.getParameter("doc_type");
		//out.println(doc_type);
		String username=request.getParameter("username");
		String project_name="";
		String job_loc="";
		String agent_name="";
		String bpcs_order_no="";
		String detailer_initial="";
		String checker_initial="";
		String drawing_date="";
		String project_desc="";
		String arch_name="";
		String arch_loc="";
		String cust_name="";
		String cust_loc="";
		String rep_no="";
		String product_id="";
		String bpcs_work_order_no="";
		String name1="";
		String name2="";
		String addr1="";
		String addr2="";
		String city="";
		String state="";
		String zip="";
		String country="";
		String attn="";
		String ship_date="";
		String phone="";
		String numHours="";
		String layout_done_by="";
		//order_no="007027_00";
		String cust_po_no="";
		ResultSet rsn1=stmt.executeQuery("select cust_po from cs_n1 where order_number='"+order_no+"'");
		if(rsn1 != null){
			while(rsn1.next()){
				cust_po_no=rsn1.getString(1);
			}
		}
		rsn1.close();
		ResultSet rs=stmt.executeQuery("Select project_name,job_loc,agent_name,bpcs_order_no,creator_id,product_id,bpcs_work_order_no FROM cs_project where order_no ='"+order_no+"'");
		if(rs != null){
			while(rs.next()){
				project_name=rs.getString(1);
				job_loc=rs.getString(2);
				//agent_name=rs.getString(3);
				bpcs_order_no=rs.getString(4);
				rep_no=rs.getString(5);
				product_id=rs.getString(6);
				bpcs_work_order_no=rs.getString(7);
			}
		}
		rs.close();
		if(project_name == null){
			project_name="";
		}
		if(job_loc == null){
			job_loc="";
		}
		if(agent_name == null){
			agent_name="";
		}
		if(bpcs_order_no == null){
			bpcs_order_no="";
		}
		bpcs_order_no=bpcs_order_no.trim();
		if(rep_no == null){
			rep_no="";
		}
		if(product_id == null){
			product_id="";
		}
		if(bpcs_work_order_no == null){
			bpcs_work_order_no="";
		}

		ResultSet rs1=stmt.executeQuery("select detailer_initial,checker_initial,drawing_date,project_desc,layout_done_by,agent_name from cs_order_info where order_no ='"+order_no+"'");
		if(rs1 != null){
			while(rs1.next()){
				detailer_initial=rs1.getString(1);
				checker_initial=rs1.getString(2);
				drawing_date=rs1.getString(3);
				project_desc=rs1.getString(4);
				layout_done_by=rs1.getString(5);
				agent_name=rs1.getString(6);
			}
		}
		if(drawing_date != null){
			DateFormat dateFormat=new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date date=dateFormat.parse(drawing_date);

			String month=(date.getMonth()+1)+"/";
			String day=(date.getDate())+"/";
			String year=(date.getYear()+1900)+" ";
			if(month.trim().length()==2){
				month="0"+month;
			}
			if(day.trim().length()==2){
				day="0"+day;
			}
			year=year.trim();
			year=year.substring(2);
			drawing_date=month+day+year;
		}
		else{
			drawing_date="";
		}
		rs1.close();
		if(detailer_initial == null){
			detailer_initial="";
		}
		if(checker_initial == null){
			checker_initial="";
		}
		if(drawing_date == null){
			drawing_date="";
		}
		if(project_desc == null){
			project_desc="";
		}
		if(layout_done_by == null){
			layout_done_by="";
		}

		ResultSet rs2=stmt.executeQuery("select name1,city from cs_order_architects where order_no='"+order_no+"'");
		if(rs2 != null){
			while(rs2.next()){
				arch_name=rs2.getString(1);
				arch_loc=rs2.getString(2);
			}
		}
		rs2.close();
		if(arch_name == null){
			arch_name="";
		}
		if(arch_loc == null){
			arch_loc="";
		}
		//out.println(rep_no);
		ResultSet rs3=stmt.executeQuery("select cust_name1, city from cs_billed_customers where order_no='"+order_no+"' and created_rep_no ='"+rep_no+"'");
		if(rs3 != null){
			while(rs3.next()){
				cust_name=rs3.getString(1);
				cust_loc=rs3.getString(2);
			}
		}
		rs3.close();
		if(cust_name == null){
			cust_name="";
		}
		if(cust_loc == null){
			cust_loc="";
		}
		ResultSet rs4=stmt.executeQuery("select name_1,name_2,address_1,address_2,city,state,zip_code,country,attention,ship_date,phone,special_instructions from shipping where order_no='"+order_no+"'");
		if(rs4 != null){
			while(rs4.next()){
				name1=rs4.getString(1);
				name2=rs4.getString(2);
				addr1=rs4.getString(3);
				addr2=rs4.getString(4);
				city=rs4.getString(5);
				state=rs4.getString(6);
				zip=rs4.getString(7);
				country=rs4.getString(8);
				attn=rs4.getString(9);
				ship_date=rs4.getString(10);
				phone=rs4.getString(11);
				numHours=rs4.getString(12);


			}
		}
		rs4.close();
		if(name1 == null){
			name1="";
		}
		if(name2 == null){
			name2="";
		}
		if(addr1 == null){
			addr1="";
		}
		if(addr2 == null){
			addr2="";
		}
		if(city == null){
			city="";
		}
		if(state == null){
			state="";
		}
		if(zip == null){
			zip="";
		}
		if(country == null){
			country="";
		}
		if(attn == null){
			attn="";
		}
		if(phone == null){
			phone="";
		}
		if(ship_date == null){
			ship_date="";
		}
		if(numHours == null){
			numHours="";
		}

		// delete existing record from cs_n1 table
		myConn.setAutoCommit(false);
		//out.println(order_no+"::"+bpcs_order_no+"::"+bpcs_work_order_no+"::"+numHours+"::"+layout_done_by+"<BR>");
		//out.println(project_name+"::"+name1+"::"+name2+"::"+addr1+"::"+addr2+"<BR>");
		//out.println(city+"::"+state+"::"+zip+"::"+country+"::"+attn+"<BR>");
		//out.println(phone+"::"+ship_date+"<BR>");

		try{
			stmt.executeUpdate("delete from cs_n1 where order_number='"+order_no+"' ");
		}
		catch (java.sql.SQLException e){
			out.println("Problem with deleting from cs_n1 table");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}

		// insert into cs_n1 table
		try{
			String updateString ="INSERT INTO cs_n1 (order_number,product_id,order_line_no,bpcs_ord,shop_ord,hrs_notice,layout_person,record_type,project_name,shipto_name1,shipto_name2,shipto_add1,shipto_add2,shipto_city,shipto_state,shipto_zip,shipto_county,shipto_attname,shipto_phone,shipto_shipdate,cust_po)VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
				java.sql.PreparedStatement updateN1 = myConn.prepareStatement(updateString);
				updateN1.setString(1,order_no);
				updateN1.setString(2,"NOTES");
				updateN1.setString(3,"1");
				updateN1.setString(4,bpcs_order_no);
				updateN1.setString(5,bpcs_work_order_no);
				updateN1.setString(6,numHours);
				updateN1.setString(7,layout_done_by);
				updateN1.setString(8,"1");
				updateN1.setString(9,project_name);
				updateN1.setString(10,name1);
				updateN1.setString(11,name2);
				updateN1.setString(12,addr1);
				updateN1.setString(13,addr2);
				updateN1.setString(14,city);
				updateN1.setString(15,state);
				updateN1.setString(16,zip);
				updateN1.setString(17,country);
				updateN1.setString(18,attn);
				updateN1.setString(19,phone);
				updateN1.setString(20,ship_date);
				updateN1.setString(21,cust_po_no);
				int rocount=updateN1.executeUpdate();
				updateN1.close();
			}
			catch (java.sql.SQLException e){
				out.println("Problem with entering into cs_n1 table");
				out.println("Illegal Operation try again/Report Error"+"<br>");
				myConn.rollback();
				out.println(e.toString());
				return;
			}

		//out.println(order_no+"::"+project_name+"::"+job_loc+"::"+agent_name+"::"+bpcs_order_no+"::"+detailer_initial+"::"+checker_initial+"::"+drawing_date+"::"+project_desc+"::"+arch_name+"::"+arch_loc+"::"+cust_name+"::"+cust_loc+"::"+rep_no);
		if(order_no.length()<30){
			String tv="";
			for(int v=0;v<(30-order_no.length());v++){
				tv=" "+tv;
			}
			order_no=order_no+tv;
		}
		if(project_name.length()<30){
			String tv="";
			for(int v=0;v<(30-project_name.length());v++){
				tv=" "+tv;
			}
			project_name=project_name+tv;
		}
		if(job_loc.length()<30){
			String tv="";
			for(int v=0;v<(30-job_loc.length());v++){
				tv=" "+tv;
			}
			job_loc=job_loc+tv;
		}
		if(agent_name.length()<30){
			String tv="";
			for(int v=0;v<(30-agent_name.length());v++){
				tv=" "+tv;
			}
			agent_name=agent_name+tv;
		}
		if(bpcs_order_no.length()<30){
			String tv="";
			for(int v=0;v<(30-bpcs_order_no.length());v++){
				tv=" "+tv;
			}
			bpcs_order_no=bpcs_order_no+tv;
		}
		if(detailer_initial.length()<30){
			String tv="";
			for(int v=0;v<(30-detailer_initial.length());v++){
				tv=" "+tv;
			}
			detailer_initial=detailer_initial+tv;
		}
		if(checker_initial.length()<30){
			String tv="";
			for(int v=0;v<(30-checker_initial.length());v++){
				tv=" "+tv;
			}
			checker_initial=checker_initial+tv;
		}
		if(drawing_date.length()<30){
			String tv="";
			for(int v=0;v<(30-drawing_date.length());v++){
				tv=" "+tv;
			}
			drawing_date=drawing_date+tv;
		}
		if(project_desc.length()<30){
			String tv="";
			for(int v=0;v<(30-project_desc.length());v++){
				tv=" "+tv;
			}
			project_desc=project_desc+tv;
		}
		if(arch_name.length()<30){
			String tv="";
			for(int v=0;v<(30-arch_name.length());v++){
				tv=" "+tv;
			}
			arch_name=arch_name+tv;
		}
		if(arch_loc.length()<30){
			String tv="";
			for(int v=0;v<(30-arch_loc.length());v++){
				tv=" "+tv;
			}
			arch_loc=arch_loc+tv;
		}
		if(cust_name.length()<30){
			String tv="";
			for(int v=0;v<(30-cust_name.length());v++){
				tv=" "+tv;
			}
			cust_name=cust_name+tv;
		}
		if(cust_loc.length()<30){
			String tv="";
			for(int v=0;v<(30-cust_loc.length());v++){
				tv=" "+tv;
			}
			cust_loc=cust_loc+tv;
		}
		Vector cString= new Vector();
		//out.println(order_no+"::<BR>"+"Select count(*) from doc_line where doc_number='"+order_no+"'<BR><BR>");
		//ResultSet rsCfSt=stmt.executeQuery("Select count(*) from products");
		//out.println("::"+order_no+"::<BR>");
		ResultSet rsCfSt=stmt.executeQuery("Select config_string from doc_line where doc_number='"+order_no.trim()+"'");
		if(rsCfSt != null){
			while(rsCfSt.next()){
				cString.addElement(rsCfSt.getString(1));
				//out.println(rsCfSt.getString(1)+":::::<BR><BR>");
			}
			//out.println("done looping threw resultset<BR>");
		}

		boolean createTxt=false;
		String currentVms="";
		//out.println(cString.size()+"HERE<BR>");
		for(int cs=0; cs<cString.size(); cs++){
			String configString=cString.elementAt(cs).toString();
			int foundAt0=configString.indexOf("DRWG");
			//out.println(foundAt0+"::");
			if(foundAt0>0){
				createTxt=true;
			}

			// stuff Arthur may need
			/*
			int foundAt=configString.indexOf("VMS_STATUS");
			if(foundAt>0 && foundAt+12 <= configString.length()){
				currentVms=configString.substring(foundAt+11,foundat+12);
			}
			if(currentVms.equals("]")){
				currentVms="0";
			}
			*/
		}
		%>
		<FORM method=GEt name=createInt>
			<input type='hidden' name='createTxt' value=<%=createTxt%>>
			<%
			//out.println(createTxt);
			String url="";
			if(createTxt){
				//out.println("<BR>"+order_no+"::"+project_name+"::"+job_loc+"::"+agent_name+"::"+bpcs_order_no+"::"+detailer_initial+"::"+checker_initial+"::"+drawing_date+"::"+project_desc+"::"+arch_name+"::"+arch_loc+"::"+cust_name+"::"+cust_loc+"::"+rep_no);
				String startLine="0         ";
				String none="NONE                ";
				String title="TITLEBLOCK          ";
				String order_info="ORDERINFO           ";
				String outputStr=startLine+none+order_info+"YES                           "+"\r\n";
				outputStr=outputStr+startLine+none+order_info+project_name.substring(0,30)+"\r\n";
				outputStr=outputStr+startLine+none+order_info+project_desc.substring(0,30)+"\r\n";
				outputStr=outputStr+startLine+none+order_info+"PROCESSED                     "+"\r\n";
				outputStr=outputStr+startLine+none+order_info+"NOTES                         "+"\r\n";
				outputStr=outputStr+startLine+title+title+job_loc.substring(0,30)+"\r\n";
				outputStr=outputStr+startLine+title+title+cust_name.substring(0,30)+"\r\n";
				outputStr=outputStr+startLine+title+title+cust_loc.substring(0,30)+"\r\n";
				outputStr=outputStr+startLine+title+title+arch_name.substring(0,30)+"\r\n";
				outputStr=outputStr+startLine+title+title+arch_loc.substring(0,30)+"\r\n";
				outputStr=outputStr+startLine+title+title+agent_name.substring(0,30)+"\r\n";
				outputStr=outputStr+startLine+title+title+detailer_initial.substring(0,30)+"\r\n";
				outputStr=outputStr+startLine+title+title+checker_initial.substring(0,30)+"\r\n";
				outputStr=outputStr+startLine+title+title+drawing_date.substring(0,30)+"\r\n";
				outputStr=outputStr+startLine+title+title+project_name.substring(0,30)+"\r\n";
				outputStr=outputStr+startLine+title+title+bpcs_order_no.substring(0,30)+"\r\n";
				//out.println(outputStr);

				String dir_path="D:\\TRANSFER\\DwgOutput\\";
				BufferedWriter out1 = new BufferedWriter(new FileWriter(dir_path+"\\"+"O"+order_no.trim()+".txt"));
				out1.write(outputStr);
				out.flush();
				out1.flush();
				out1.close();
			url="https://"+ application.getInitParameter("HOST") +"/cse/web/jsp/custom_interface/create_interface.jsp";
			//url=url+"?doc_number="+order_no+"&environment="+environment+"&doc_revision=1&doc_type="+doc_type+"&username="+username;
			//out.println(url);

			%>

			<input type='hidden' name='url' value=<%= url %> >
			<input type='hidden' name='doc_number' value=<%= order_no %> >
			<input type='hidden' name='environment' value=<%= environment%> >
			<input type='hidden' name='doc_revision' value=<%= doc_revision %> >
			<input type='hidden' name='doc_type' value=<%= doc_type %> >
			<input type='hidden' name='username' value=<%= username %> >
			<input type='hidden' name='silent' value='true'>

			<%
			}



			myConn.commit();
			stmt.close();
			myConn.close();
			%>
		</form>
		<form name='nocreate'>
			<input type='hidden' name='doc_number' value=<%= order_no %> >
		</form>
	</body>
</html>
<%

 }
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>