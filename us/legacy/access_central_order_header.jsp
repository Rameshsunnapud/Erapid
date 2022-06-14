<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<html><HEAD>
		<script language="JavaScript" src="date-picker.js"></script>
		<title>Order Header</title>
		<link rel='stylesheet' href='style1.css' type='text/css' />
		<SCRIPT LANGUAGE="JavaScript">
			<!-- Begin
		 function toForm(){
				document.selectform.project_name.focus();
			}
			function validate(){
				var x=document.selectform.bpcs_order_no.value;
				x=x.replace(/^\s*|\s*$/g,"");
				//alert(x.length);
				if(x.replace(/^\s*|\s*$/g,"").length<1){
					alert("Please enter a BPCS number");
					return false;

				}
				else{
					return true;
				}
			}

		</script>
	</HEAD>
	<BODY bgcolor="whitesmoke" onLoad="toForm()">
	<center>
		<h1 align="left">Order Information</h1>
		<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con.jsp"%>
		<%
		String order_no = request.getParameter("order_no");
		String product = request.getParameter("product");
		String cust_po_no="";
		int n1count=0;
		ResultSet rsn1=stmt.executeQuery("select cust_po from cs_n1 where order_number='"+order_no+"'");
		if(rsn1 != null){
			while(rsn1.next()){
				cust_po_no=rsn1.getString(1);
				n1count++;
			}
		}
		rsn1.close();
		if(cust_po_no == null || cust_po_no.equals("null")){
			cust_po_no="";
		}
		//Ship variables
		String ship_name="";String ship_name2="";String ship_addr1="";String ship_addr2="";String city="";String state="";
		String zip="";String ship_phone="";String ship_date="";String ship_country="";String ship_attention="";String ship_inst="";int ship_count=0;
		// Getting the shipping info
				ResultSet rs_ship = stmt.executeQuery("SELECT * FROM SHIPPING where Order_no like '"+order_no+"' ");
				if (rs_ship !=null) {
			   while (rs_ship.next()) {
				ship_name= rs_ship.getString("Name_1");
				ship_name2= rs_ship.getString("Name_2");
				ship_addr1= rs_ship.getString("Address_1");
				ship_addr2= rs_ship.getString("Address_2");
				city= rs_ship.getString("City");
				state= rs_ship.getString("State");
				zip= rs_ship.getString("Zip_code");
				ship_phone= rs_ship.getString("Phone");
				ship_country= rs_ship.getString("Country");
				ship_attention= rs_ship.getString("Attention");
				ship_date= rs_ship.getString("ship_date");
				ship_inst= rs_ship.getString("special_instructions");
				ship_count++;
									  }
								   }
		    rs_ship.close();
		if(ship_name==null){ship_name="";}
		if(ship_name2==null){ship_name2="";}
		if(ship_addr1==null){ship_addr1="";}
		if(ship_addr2==null){ship_addr2="";}
		if(city==null){city="";}
		if(state==null){state="";}
		if(zip==null){zip="";}
		if(ship_phone==null){ship_phone="";}
		if(ship_country==null){ship_country="";}
		if(ship_attention==null){ship_attention="";}
		if(ship_date==null||ship_date.equals("null")){ship_date="";}
		if(ship_inst==null){ship_inst="";}

		//cs_project vars
		String project_name="";String job_loc="";String arch_name="";String arch_loc="";String cust_name="";String cust_loc="";
		String agent_name="";String project_type="";String cust_id="";String rep_no="";String bpcs_order_no="";String bpcs_work_order_no="";
			ResultSet rs_project = stmt.executeQuery("SELECT * FROM cs_project where Order_no like '"+order_no+"' ");
				if (rs_project !=null) {
			   while (rs_project.next()) {
				project_name= rs_project.getString("Project_name");
				job_loc= rs_project.getString("Job_loc");
				arch_name= rs_project.getString("arch_name");
				arch_loc= rs_project.getString("arch_loc");
				bpcs_order_no= rs_project.getString("bpcs_order_no");
				bpcs_work_order_no= rs_project.getString("bpcs_work_order_no");
				cust_id= rs_project.getString("cust_name");

				project_type= rs_project.getString("project_type");
				rep_no= rs_project.getString("creator_id");
				}
				}
			    rs_project.close();
		if(bpcs_order_no==null){bpcs_order_no="";}
		if(bpcs_work_order_no==null){bpcs_work_order_no="";}
		int bill_count=0;

				ResultSet rs_bill = stmt.executeQuery("SELECT * FROM cs_billed_customers where order_no like '"+order_no+"' and created_rep_no like '"+rep_no+"' ");
				if (rs_bill !=null) {
			   while (rs_bill.next()) {
				cust_name= rs_bill.getString("cust_name1");
				cust_loc= rs_bill.getString("city");
				bill_count++;
									    }
							 }
			   rs_bill.close();

				if(bill_count<=0){
				 if( !(project_type==null) ){

				   String Country_Code = cust_id.substring(0,2);
				   if ((Country_Code.equals("GB")) | (Country_Code.equals("US"))){	cust_id=cust_id.substring(2);}
				   out.println(cust_id+"::"+rep_no+"::<BR>");
				   /*
					ResultSet rs_customer1 = stmt.executeQuery("SELECT * FROM cs_customers where cust_no='"+cust_id+"' and created_rep_no like '"+rep_no+"'");
					if (rs_customer1 !=null) {
				   while ( rs_customer1.next() ) {
					cust_name= rs_customer1.getString("cust_name1");
					cust_loc= rs_customer1.getString("city");
											    }
											}
					rs_customer1.close();
					*/

				 }

				}

		int arch_count=0;
				ResultSet rs_arch1 = stmt.executeQuery("select * from cs_order_architects where order_no= '"+order_no+"' ");
				if (rs_arch1 !=null) {
			   while (rs_arch1.next()) {
				arch_name= rs_arch1.getString("name1");
				arch_loc= rs_arch1.getString("city");
				arch_count++;
									}
							}
				rs_arch1.close();
				//out.println(agent_name+"::<BR>");
		String layout_doneby="";String detailer="";String checker="";String drawing_date="";String project_desc="";int order_count=0;
				ResultSet rs_order = stmt.executeQuery("SELECT * FROM cs_order_info where order_no like '"+order_no+"' ");
				if (rs_order !=null) {
			   while (rs_order.next()) {
				layout_doneby=rs_order.getString("layout_done_by");
				detailer=rs_order.getString("detailer_initial");
				checker=rs_order.getString("checker_initial");
				drawing_date=rs_order.getString("drawing_date");
				project_desc=rs_order.getString("project_desc");
				agent_name= rs_order.getString("agent_name");
				order_count++;
				}
				}
				//out.println(agent_name+"::::<BR>");
				if(agent_name==null){ agent_name="";}
				//out.println(agent_name+"::::<BR>");
		if(drawing_date == null ||drawing_date.equals("null")){
			drawing_date="";
		}
			rs_order.close();
			stmt.close();
			myConn.close();

		%>
		<form name="selectform" action="access_central_order_header_save.jsp"  onsubmit="return validate()">
			<input type='hidden' name="order_count" value='<%= order_count %>'>
			<input type='hidden' name="arch_count" value='<%= arch_count %>'>
			<input type='hidden' name="bill_count" value='<%= bill_count %>'>
			<input type='hidden' name="ship_count" value='<%= ship_count %>'>
			<input type='hidden' name="n1count" value='<%= n1count %>'>
			<input type='hidden' name="order_no" value='<%= order_no %>'>
			<input type='hidden' name="rep_no" value='<%= rep_no %>'>
			<input type='hidden' name="silent" value='true'>
			<table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
				<tr>
					<td class='noheader' align='left' colspan='1'>&nbsp;</td>
					<td class='header2' align='center' colspan='2' ><b><font size='2'>Project Information:</font></b></td>
					<td class='noheader' align='left' colspan='1'>&nbsp;</td>
				</tr>
				<tr>
					<td class='noheader' align='left' colspan='1'>&nbsp;</td>
					<td class='header' align='right' ><b>Project Name *:</b></td>
					<td class='header'><input type='text' value='<%= project_name %>' name="project_name" readonly class='text1'></td>
					<td class='noheader' align='left' colspan='1'>&nbsp;</td>
				</tr>
				<tr>
					<td class='noheader' align='left' colspan='1'>&nbsp;</td>
					<td class='noheader' align='right' ><b>BPCS Order Number:</b></td>
					<td class='noheader'><input type='text' value='<%= bpcs_order_no %>' name="bpcs_order_no" class='notext1'></td>
					<td class='noheader' align='left' colspan='1'>&nbsp;</td>
				</tr>
				<tr>
					<td class='header2' align='center' colspan='2'><b><font size='2'>Shop Paper:</font></b></td>
					<td class='header2' align='center' colspan='2'><b><font size='2'>Ship to Information:</font></b></td>
				</tr>
				<tr><td class='header' align='right' >BPCS Work Order No :</td>
					<td class='header'><input type='text' value='<%= bpcs_work_order_no %>' name="bpcs_work_order_no" class='text1'></td>
					<td class='header' align='right' >Name1:</td>
					<td class='header'><input type='text' value='<%= ship_name %>' name="ship_name" class='text1'></td>
				</tr>
				<tr><td class='noheader' align='right' >Layout done by :</td>
					<td class='noheader'><input type='text' value='<%= layout_doneby %>' name="layout_doneby" class='notext1'></td>
					<td class='noheader' align='right' >Name2:</td>
					<td class='noheader'><input type='text' value='<%= ship_name2 %>' name="ship_name2" class='notext1'></td>
				</tr>
				<tr><td class='header' align='right' >Customer P.O.# :</td>
					<td class='header'><input type='text' value='<%= cust_po_no %>' name="cust_po_no" class='notext1'></td>
					<td class='header' align='right' >Address1:</td>
					<td class='header'><input type='text' value='<%= ship_addr1 %>' name="Address_1" class='text1'></td>
				</tr>
				<tr>
					<td class='header2' align='center' colspan='2'><b><font size='2'>Integrated Drawing Generator:</font></b></td>
					<td class='noheader' align='right' >Address2:</td>
					<td class='noheader'><input type='text' value='<%= ship_addr2 %>' name="Address_2" class='notext1'></td>
				</tr>
				<tr>
					<td class='header' align='right' >Job Location  *:</td>
					<td class='header'><input type='text' value='<%= job_loc %>' name="job_loc" readonly class='text1'></td>
					<td class='header' align='right' >City:</td>
					<td class='header'><input type='text' value='<%= city %>' name="city" class='text1'></td>

				</tr>
				<tr><td class='noheader' align='right' > Architect's name :</td>
					<td class='noheader'><input type='text' value='<%= arch_name %>' name="arch_name" class='notext1'></td>
					<td class='noheader' align='right' >State:</td>
					<td class='noheader'><input type='text' value='<%= state %>' name="state" class='notext1'></td>

				</tr>
				<tr><td class='header' align='right' >Architect location :</td>
					<td class='header'><input type='text' value='<%= arch_loc %>' name="arch_loc" class='text1'></td>
					<td class='header' align='right' >Zip Code:</td>
					<td class='header'><input type='text' value='<%= zip %>' name="zip_code" class='text1'></td>

				</tr>
				<tr><td class='noheader' align='right' >Customer name  :</td>
					<td class='noheader'><input type='text' value='<%= cust_name %>' name="cust_name" class='notext1'></td>
					<td class='noheader' align='right' >Country:</td>
					<td class='noheader'><input type='text' value='<%= ship_country %>' name="country" class='notext1'></td>

				</tr>
				<tr><td class='header' align='right' >Customer Location :</td>
					<td class='header'><input type='text' value='<%= cust_loc %>' name="cust_loc" class='text1'></td>
					<td class='header' align='right' >Attention:</td>
					<td class='header'><input type='text' value='<%= ship_attention %>' name="attention" class='text1'></td>

				</tr>
				<tr><td class='noheader' align='right' >Agent's name :</td>
					<td class='noheader'><input type='text' value='<%= agent_name %>' name="agent_name" class='notext1' ></td>
					<td class='noheader' align='right' >Ship Date:</td>
					<td class='noheader'><input type='text' value='<%= ship_date %>' name="ship_date" class='notext1'><a href="javascript:show_calendar('selectform.ship_date');" onmouseover="window.status='Date Picker';
							return true;" onmouseout="window.status='';
									return true;"><img src="images/show-calendar.gif" width=24 height=22 border=0></a> </td>

				</tr>
				<tr><td class='header' align='right' >Detailer's Initials  :</td>
					<td class='header'><input type='text' value='<%= detailer %>' name="detailer" class='text1'></td>
					<td class='header' align='right' >Phone:</td>
					<td class='header'><input type='text' value='<%= ship_phone %>' name="phone" class='text1'></td>

				</tr>
				<tr><td class='noheader' align='right' >Checker's Initials :</td>
					<td class='noheader'><input type='text' value='<%= checker %>' name="checker" class='notext1'></td>
					<td class='noheader' align='right' ># of hours prior to delivery :</td>
					<td class='noheader'><input type='text' value='<%= ship_inst %>' name="special_instructions" class='notext1'></td>

				</tr>
				<tr><td class='header' align='right' >Drawing date  :	 </td>
					<td class='header'><input type='text' value='<%= drawing_date %>' name="drawing_date" class='text1'><a href="javascript:show_calendar('selectform.drawing_date');" onmouseover="window.status='Date Picker';
							return true;" onmouseout="window.status='';
									return true;"><img src="images/show-calendar.gif" width=24 height=22 border=0></a></td>
					<td class='header' align='right' >&nbsp;</td>
					<td class='header'>&nbsp;</td>

				</tr>
				<tr><td class='noheader' align='right' >Project Description :</td>
					<td class='noheader'><input type='text' value='<%= project_desc %>' name="project_desc" class='notext1'></td>
				</tr>

				<tr>

					<td class='noheader' align='center' colspan='4'>* -- Read Only field</td>
				</tr>
			</table>
			<br>
			<input type='submit' name='Add' value='Save' class='button'>
		</form>
		<%

		%>
	</center>
</body>
</html>
<%
 }
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>