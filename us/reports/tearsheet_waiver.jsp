<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
String order_no = request.getParameter("order_no");//Login id
String prepared_by="";
String prepared_by_email="";
%>
<%@ page language="java" pageEncoding="utf-8" import="java.text.*" import="java.sql.*" import="java.math.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="../../db_con.jsp"%>
<%@ include file="../../dbcon1.jsp"%>
<%
String doc_type_alt="";
String bpcs_order_no="";
String bpcs_cust_no="";
String product="";String Project_name="";String Arch_name="";String Arch_loc="";String section="";String division="";
String rep_no="";String cust_no="";String project_city="";String project_state="";String agent_name="";
String project_type="";String carriage_charge="";String rep_notes=""; String creator_user_id="";
ResultSet rs_project = stmt.executeQuery("SELECT * FROM cs_project where Order_no like '"+order_no+"'");
if (rs_project !=null) {
	while (rs_project.next()) {
		   Project_name= rs_project.getString("Project_name");
		if(!(Project_name != null)){Project_name="";}
		project_city= rs_project.getString("job_loc");
		project_state= rs_project.getString("Project_state");
		cust_no= rs_project.getString("Cust_name");
		Arch_name= rs_project.getString("Arch_name");
		Arch_loc= rs_project.getString("Arch_loc");
		agent_name= rs_project.getString("Agent_name");
		product= rs_project.getString("product_id").trim();
		rep_no= rs_project.getString("creator_id");
		section= rs_project.getString("section");
		division= rs_project.getString("division");
		bpcs_order_no= rs_project.getString("bpcs_order_no");
		project_type= rs_project.getString("project_type");
		creator_user_id=rs_project.getString("user_id");;
	}
}
boolean isCanadian=false;
boolean isInternational=false;
String session_group_id="";

String session_rep_no="";
String session_rep_no1="";
HttpSession UserSession_rep = request.getSession();
if(UserSession_rep!=null){
	if(UserSession_rep.getAttribute("rep_no") != null){
		session_rep_no1= UserSession_rep.getAttribute("rep_no").toString();
	}
	if(UserSession_rep.getAttribute("usergroup") != null){
		session_group_id= UserSession_rep.getAttribute("usergroup").toString();
	}
}
if(agent_name==null){agent_name="";}
String cust_name1="";String cust_addr1="";String cust_addr2="";String city="";String state="";String zip_code="";String ccode="";String cust_contact_name="";
String cust_fax="";String cust_phone="";
int countx=0;
if ((project_type==null)||(project_type.startsWith("nul"))){
	ccode=cust_no.substring(0,2);
	if ((ccode.equals("US"))) {cust_no=cust_no.substring(2);}
	else {ccode="US";}
	ResultSet rs_customers = stmt.executeQuery("SELECT * FROM cs_customers where cust_no like '"+cust_no+"' and country_code='"+ccode+"' ");
	if (rs_customers !=null) {
		while (rs_customers.next()) {
			bpcs_cust_no=rs_customers.getString("bpcs_cust_no");
			cust_name1= rs_customers.getString("cust_name1");
			cust_addr1= rs_customers.getString("cust_addr1");
			cust_addr2= rs_customers.getString("cust_addr2");
			city= rs_customers.getString("city");
			state= rs_customers.getString("state");
			zip_code= rs_customers.getString("zip_code");
			cust_phone= rs_customers.getString("phone");
			cust_fax= rs_customers.getString("fax");
			cust_contact_name= rs_customers.getString("contact_name");
			countx++;
		}
	}
	rs_customers.close();
}
else{
%>
<%@ include file="../../db_con_psa.jsp"%>
<%

ResultSet rs_psa = stmt_psa.executeQuery("SELECT * FROM dba.account where acct_id like '"+cust_no+"'");
	while ( rs_psa.next() ) {
		cust_name1= rs_psa.getString("acctname");
		cust_addr1= rs_psa.getString("addr1");
		cust_addr2= rs_psa.getString("addr2");
		city= rs_psa.getString("town");
		state= rs_psa.getString("county");
		zip_code= rs_psa.getString("postcode");
		cust_phone= rs_psa.getString("tel");
		cust_fax= rs_psa.getString("fax");
		countx++;
	}
	rs_psa.close();
}
if(countx==0){
	ccode=cust_no.substring(0,2);
	   if ((ccode.equals("US"))) {cust_no=cust_no.substring(2);}
	else {ccode="US";}
	ResultSet rs_customers = stmt.executeQuery("SELECT * FROM cs_customers where cust_no like '"+cust_no+"' and country_code='"+ccode+"' ");
	if (rs_customers !=null) {
		   while (rs_customers.next()) {
			bpcs_cust_no=rs_customers.getString("bpcs_cust_no");
			cust_name1= rs_customers.getString("cust_name1");
			cust_addr1= rs_customers.getString("cust_addr1");
			cust_addr2= rs_customers.getString("cust_addr2");
			city= rs_customers.getString("city");
			state= rs_customers.getString("state");
			zip_code= rs_customers.getString("zip_code");
			cust_phone= rs_customers.getString("phone");
			cust_fax= rs_customers.getString("fax");
			cust_contact_name= rs_customers.getString("contact_name");
		}
	}
	rs_customers.close();
}

if(bpcs_cust_no==null){
bpcs_cust_no="";
}
String rep_account="";String address1="";String address2="";String rep_city="";String rep_state="";String rep_zip_code="";
String rep_telephone="";String rep_fax="";String rep_email=""; String rep_name="";String rccode="";

if(rep_no.length()>2){
rccode=rep_no.substring(0,2);
}
if((session_group_id.toUpperCase().startsWith("REP") && project_type != null && project_type.equals("PSA"))){rep_no=session_rep_no;}
String sql="";int rep_count=0;
ResultSet rs_rep_check = stmt.executeQuery("SELECT count(*) FROM cs_reps where rep_no like '"+rep_no+"' and user_id like '"+creator_user_id+"%' ");
if (rs_rep_check  !=null) {
while (rs_rep_check.next()) {
	rep_count= rs_rep_check.getInt(1);
}
}
rs_rep_check.close();
if(creator_user_id==null||rep_count==0){
sql="SELECT * FROM cs_reps where rep_no like '"+rep_no+"' order by user_id desc";
}
else{
sql="SELECT * FROM cs_reps where rep_no like '"+rep_no+"' and user_id like '"+creator_user_id+"%' order by user_id desc ";
}
ResultSet rs_reps = stmt.executeQuery(sql);
if (rs_reps !=null) {
while (rs_reps.next()) {
	rep_account= rs_reps.getString("rep_account");
	address1= rs_reps.getString("address1");
	address2= rs_reps.getString("address2");
	rep_city= rs_reps.getString("rep_city");
	rep_state= rs_reps.getString("state");
	rep_zip_code= rs_reps.getString("zip");
	rep_telephone= rs_reps.getString("telephone");
	rep_fax= rs_reps.getString("fax");
	rep_email= rs_reps.getString("email");
	rep_name = rs_reps.getString("rep_name");
}
}
rs_reps.close();
//dates
String edate="";String odate="";String doc_priority="";
ResultSet rs_eorders = stmt.executeQuery("SELECT doc_date,entry_date,doc_priority FROM doc_header where doc_number like '"+order_no+"'");
if (rs_eorders !=null) {
   while (rs_eorders.next()) {
	odate= rs_eorders.getString(1).substring(0,10);
	edate= rs_eorders.getString(2).substring(0,10);
	doc_priority= rs_eorders.getString(3);
}
}
rs_eorders.close();
%>




<table cellspacing='0' cellpadding='0' border='0' width='100%'>
	<tr>
		<%
		out.println("<td align='left'><img src='http://csimages.c-sgroup.com/eRapid/cs_logo.jpg' alt='CS Logo'></td>");
		%>
	</tr>
	<%
	//out.println(doc_priority+"::<BR>");
	if ( (doc_priority.equals("E")) ||doc_type_alt.equals("dl")){
		if(session_group_id.startsWith("Decolink")||doc_type_alt.equals("dl")){
			out.println("<tr><td align='center' class='maintitle'><b>CS Eldercare Interiors</b>");
			out.println("<br><font class='subtitle'>Formerly DecoLink Division<br>");
			//out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
			//out.println("<br><font class='subtitle'>CS ElderCare Interiors Division<br>");
			out.println("225 Regency Court<br>Brookfield, WI 53045<br>Phone: 888.331.2031<br>");
		}else{
			out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b><BR>");
			out.println("P.O. Box 380<br>Muncy, PA 17756");
		}
		out.println("</font></td></tr>");
	}
	else{
		if(session_group_id.startsWith("Decolink")||doc_type_alt.equals("dl")){
			out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
			out.println("<br><font class='subtitle'>CS ElderCare Interiors Division<br>");
			out.println("225 Regency Court<br>Brookfield, WI 53045<br>Phone: 888.331.2031<br>");
		}else if(isInternational) {
			out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
			out.println("<br><font class='subtitle'>");
			out.println("3 Werner Way<br>Lebanon, NJ 08833");
		}
		else{
			out.println("<tr><td align='center' class='maintitle'><b>CONSTRUCTION SPECIALTIES, INC</b>");
			out.println("<br><font class='subtitle'>");
			out.println("P.O. Box 380<br>Muncy, PA 17756");
		}
		out.println("</font></td></tr>");

	}
	%>
</table>
<!-- end header -->
<table cellspacing='0' cellpadding='0' border='0' width='100%'>
	<tr>
		<td width='55%' valign='top' rowspan='3' nowrap class='mainbody'>
			<%
			if(cust_name1==null){cust_name1="";}
			if(cust_addr1==null){cust_addr1="";}
			if(cust_addr2==null){cust_addr2="";}
			if(cust_phone==null){cust_phone="";}
			if(bpcs_order_no==null || bpcs_order_no.equals("null")){
				bpcs_order_no="";
			}
			if(cust_fax==null){cust_fax="";}
			if(cust_name1.trim().length()>0){out.println(cust_name1+"<br>");}
			if(cust_addr1.trim().length()>0){out.println(cust_addr1+"<br>");}
			if(cust_addr2.trim().length()>0){out.println(cust_addr2+"<br>");}
			%>
			<%= city %>,&nbsp;<%= state %>&nbsp;<%= zip_code %>&nbsp;<br>
			<%
			if(cust_phone != null && cust_phone.trim().length() >0){
				out.println("Phone: "+cust_phone+"<br>");
			}
			if(cust_fax != null && cust_fax.trim().length() > 0){
				out.println("Fax: "+cust_fax+"<br>");
			}
			%>
			<b>Attention: </b><%= agent_name %>
		</td>
		<td width='15%' valign='top' align='LEFT' class='mainbody'><b>Quote No:<b><BR><b>Quote Date: </b><BR><b>Bid Date: </b><BR><b>Order No:</b></td>
					<td width='30%' valign='top' class='mainbody'><%out.println("&nbsp;&nbsp; "+order_no); %><br><%out.println("&nbsp;&nbsp; "+odate); %><br><%out.println("&nbsp;&nbsp; "+edate );%><BR><%out.println("&nbsp;&nbsp; "+bpcs_order_no );%></td>
					</tr>
					</table>
					<br>
					<table cellspacing='0' cellpadding='0' border='0' width='100%'>
						<tr><td nowrap valign='top' width='15%' class='mainbody'><b>Project:
									<br><br><br>
									<b>Architect:</b>&nbsp;
								</b>&nbsp;</td>
							<td width='40%' nowrap valign='top' class='mainbody'><%= Project_name %><br>
								<%
								if(project_city!=null&project_state!=null&project_state.trim().length()>0&project_city.trim().length()>0){
									if(project_city.startsWith("null")){project_city="";}
									if(project_state.startsWith("null")){project_state="";}
									if(project_state.trim().length()>0&project_city.trim().length()>0){
										out.println(project_city+",  "+project_state);
									}else{out.println(project_city+project_state+"");}

								}else{out.println(project_city+project_state+"");}
								%>
								<BR><%= Arch_name %>
							</td>
							<td valign='top' width='45%' nowrap class='mainbody'><b>CS Representative:</b><br>
								<%
								if(rep_account==null){rep_account="";}
								if(rep_city==null){rep_city="";}
								if(rep_state==null){rep_state="";}
								if(rep_zip_code==null){rep_zip_code="";}
								if(rep_telephone==null){rep_telephone="";}
								if(rep_fax==null){rep_fax="";}
								if(rep_email==null){rep_email="";}
								if(rep_name==null){rep_name="";}
								if(!(session_group_id.startsWith("Decolink")||doc_type_alt.trim().equals("dl"))){
								%>
								<%= rep_account %><br>
								<%
								if(address1==null||address1.trim().length()<1){address1="";}
								else{out.println(address1+"<br>");}
								if(address2==null||address2.trim().length()<1){address2="";}
								else{out.println(address2+"<br>");}
								if(rep_city.trim().length()>0){
									out.println(rep_city.trim()+", ");
								}
								%>
								<%= rep_state %>&nbsp;<%= rep_zip_code %><br>
								<%
							}
							else{
								if(rep_name.trim().length()>0){
									out.println("<B>"+rep_name +"</b><br>");
								}
							}
								%>
								<b>Phone:</b> <%= rep_telephone %><br>
								<b>Fax No:</b> <%= rep_fax %><br>
								<b>e-mail:</b> <%= rep_email %>
							</td>
						</tr>
					</table>
					<BR><Br>
					Construction Specialties acknowledges that you are requesting to waive drawings for the above mentioned plans and specs order. By signing below, you are approving the types, quantities and dimensions as shown on the tear sheets provided by Construction Specialties or your local representative in lieu of full layouts. If discrepancies occur between the approved tear sheets versus actual on-site requirements, the burden of proof will be upon <%=cust_name1%> to show that our take-off was deficient. Should this occur, measures would be taken to remedy the situation until sufficient documentation is produced by <%=cust_name1%> and/or Construction Specialties providing a definitive cause of discrepancy.
					<br><BR>
					We thank you for your order and look forward to successful completion of this project.
					<br><BR>
					Please sign below as approval and return this form. No further action will be taken by Construction Specialties until we receive written approval.
					<BR><BR>
					<table width='50%'>
						<tr>
							<td width='30%'>
								<B><U>Acceptance:</b></u>
							</td>
							<td width='70%'>
								&nbsp;
							</td>
						</tr>
						<tr>
							<td >
								Customer Name:
							</td>
							<td width='70%'>
								..................................................................................
							</td>
						</tr>
						<tr>
							<td colspan='2'>
								&nbsp;
							</td>
						</tr>
						<tr>
							<td >
								Customer Signature
							</td>
							<td width='70%'>
								..................................................................................
							</td>
						</tr>
						<tr>
							<td colspan='2'>
								&nbsp;
							</td>
						</tr>
						<tr>
							<td >
								Date:
							</td>
							<td width='70%'>
								..................................................................................
							</td>
						</tr>
					</table>
					<%
					stmts.close();
					myConns.close();
					stmt.close();
					myConn.close();
					}
					catch(Exception e){
					out.println(e);
					}
					%>





