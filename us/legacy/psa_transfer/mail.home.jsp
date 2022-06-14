<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<script type="text/javascript">
	function showHide(){
		var div1=document.getElementById('div1');
		if(div1.className=='hidden'){
			div1.className='visible';
		}
		else{
			div1.className='hidden';
		}
	}
	//following added by AC to populate rep email into "to" field
	function setEmail(){
		var email=document.selectform.rep_email.value;
		var cust=document.selectform.email_to.value;
		var to=document.selectform.to.value;
		if(document.getElementById('self').checked){
			document.selectform.to.value=email;
		}else{
			document.selectform.to.value=cust;
		}
	}
	// following added by AC to prevent bad email addresses
	function validateEmail(){

		var email=document.selectform.to.value;
		var cc=document.selectform.cc.value;
		var msg="";
		if(cc.length>0){

			if(cc.indexOf(' ')>=0){
				msg=msg+"Spaces not allowed in cc addresses.";

			}else if(cc.indexOf('@')==-1){
				msg=msg+"Missing @ symbol, example: user@domain.com in cc";

			}else if(cc.substring(cc.indexOf('@')).indexOf('.')==-1){
				msg=msg+"Missing dot-something, such as .com, .net in cc";

			}
		}
		if(email.length>0){

			if(email.indexOf(' ')>=0){
				alert("Spaces not allowed in email addresses.");
				return false;
			}else if(email.indexOf('@')==-1){
				alert("Missing @ symbol, example: user@domain.com");
				return false;
			}else if(email.substring(email.indexOf('@')).indexOf('.')==-1){
				alert("Missing dot-something, such as .com, .net");
				return false;
			}
			else{
				if(msg.length>0){
					alert(msg);
					return false
				}
				else{
					return true;
				}

			}

		}
		else{
			if(msg.length>0){
				alert(msg);
				return false;
			}
			else{
				alert("Enter email address");
				return false;
			}
		}
	}
</script>
<html>
	<head>
		<title>Quote Mailing</title>
		<link rel='stylesheet' href='style1.css' type='text/css'/>
	</head>
	<body>
		<h1>Mail to::</h1>
		<%@ page language="java" import="java.sql.*" import="java.util.*" errorPage="error.jsp" %>
		<%@ include file="../../../db_con_psa.jsp"%>
		<%@ include file="../../../db_con.jsp"%>
		<%@ include file="../../../dbcon1.jsp"%>
		<%
				HttpSession UserSession_rep = request.getSession();
				String session_rep_no= "";
				String session_group="";
				String session_name="";
				if(UserSession_rep!=null){
		//				String name= UserSession1.getAttribute("username").toString();
						if(UserSession_rep.getAttribute("rep_no") != null){
							session_rep_no= UserSession_rep.getAttribute("rep_no").toString();
							session_group = UserSession_rep.getAttribute("usergroup").toString();
							if(UserSession_rep.getAttribute("username") != null){
							    session_name = UserSession_rep.getAttribute("username").toString();
							}
						}
				   }

				String q_no = request.getParameter("orderNo");//Total Price

				String tp = request.getParameter("tp");//Total Price
				// for Internal quotes
				String QuoteID = request.getParameter("QuoteID");//Login id
				String AcctID = request.getParameter("AcctID");//totals
				String UserID= request.getParameter("UserID");//totals
				String total=request.getParameter("total");
				//out.println(UserID);
				String userTemp="";
				String product_id="";String rep_no="";String project_type="";String cust_no="";String rep_quote="";
				String o_cost="";String handling_cost="";String freight_cost="";String project_name="";String commission="";
				ResultSet rs_project = stmt.executeQuery("SELECT * FROM cs_project where Order_no like '"+q_no+"'");
				if (rs_project !=null) {
				   while (rs_project.next()) {
						product_id= rs_project.getString("product_id");
						project_name = rs_project.getString("project_name");
						rep_no=rs_project.getString("creator_id");
						project_type=rs_project.getString("project_type");
						cust_no= rs_project.getString("Cust_name");
						o_cost = rs_project.getString("overage");
						handling_cost = rs_project.getString("handling_cost");
						freight_cost = rs_project.getString("freight_cost");
						commission= rs_project.getString("commission");
						//		out.println(rep_no+"project type"+project_type);
						userTemp=rs_project.getString("user_id");
						if(userTemp == null){userTemp="";}
						rep_quote= rs_project.getString("rep_quote");
					}
				}
				rs_project.close();
		if(total == null){
			total="";
		}
		// Getting the group_id
		String group_id="";
		   ResultSet rs1 = stmt.executeQuery("SELECT * FROM cs_reps where rep_no like '"+rep_no+"'");
			  while ( rs1.next() ) {
					group_id=rs1.getString("group_id");
			}
			rs1.close();
			stmts.close();
		    myConns.close()	;
						//Cust_no editing
							String ccode="US";
							//Getting customer info from the cs_customers table
							String cust_name1="";String cust_addr1="";String cust_addr2="";String city="";String state="";String zip_code="";String cust_contact_name="";
							String cust_fax="";String cust_phone="";String email_to="";
							if( (project_type==null||project_type.startsWith("nu")||project_type.trim().length()==0) ){
								ResultSet rs_customers = stmt.executeQuery("SELECT * FROM cs_customers where cust_no like '"+cust_no+"' and country_code='"+ccode+"' ");
								if (rs_customers !=null) {
							   while (rs_customers.next()) {
								cust_name1= rs_customers.getString("cust_name1");
								cust_addr1= rs_customers.getString("cust_addr1");
								cust_addr2= rs_customers.getString("cust_addr2");
								city= rs_customers.getString("city");
								state= rs_customers.getString("state");
								zip_code= rs_customers.getString("zip_code");
								cust_phone= rs_customers.getString("phone");
								cust_fax= rs_customers.getString("fax");
								email_to= rs_customers.getString("email");
								cust_contact_name= rs_customers.getString("contact_name");
							    }
							    }
								rs_customers.close();
							}
							else{
								String cont_id="";
								ResultSet rs_psa_quotes_issued = stmt_psa.executeQuery("SELECT * FROM dba.quotes_issued where quote_id like '"+QuoteID+"' and acct_id like '"+AcctID+"' ");
								if (rs_psa_quotes_issued !=null) {
								while (rs_psa_quotes_issued.next()) {
											cont_id= rs_psa_quotes_issued.getString(4);
									}
								}
									rs_psa_quotes_issued.close();
								if((cont_id!=null)){
								ResultSet rs_psa_contact = stmt_psa.executeQuery("SELECT * FROM dba.contact where cont_id like '"+cont_id+"'");
									if (rs_psa_contact !=null) {
									while (rs_psa_contact.next()) {
										//		agent_name= rs_psa_contact.getString(4);
										//		agent_name=agent_name+" "+rs_psa_contact.getString(3);
												email_to= rs_psa_contact.getString("e_mail");
		//									out.println("t"+email_to);
										}
									}
									rs_psa_contact.close();
								}
							}

		String rep_account="";String address1="";String address2="";String rep_city="";String rep_state="";String rep_zip_code="";
		String rep_telephone="";String rep_fax="";String rep_email=""; String rep_name="";String rccode="";
		//out.println(session_rep_no+"<--- rep number::<BR>"+session_name+"<-- session name::user temp-->"+userTemp);
		if(session_rep_no == null || session_rep_no.trim().length()==0){
			ResultSet rsRepNo=stmt.executeQuery("select rep_no from cs_reps where user_id='"+UserID+"'");
			if(rsRepNo != null){
				while(rsRepNo.next()){
					//out.println(rsRepNo.getString(1)+"::<BR>");
					session_rep_no=rsRepNo.getString(1);
					session_name=UserID;
				}
			}
			rsRepNo.close();
		}
		int repCount=0;
		ResultSet rs_reps = stmt.executeQuery("SELECT * FROM cs_reps where rep_no like '"+session_rep_no+"' and (user_id='"+session_name+"' or user_id is null or user_id='') order by user_id");
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
				//out.println(rep_email+"::"+session_rep_no+"::"+session_name+"::"+rs_reps.getString("user_id"));
				repCount++;
			}
		}
		if(repCount<=0){
			ResultSet rs_repsx = stmt.executeQuery("SELECT * FROM cs_reps where rep_no like '"+session_rep_no+"' and (user_id='"+userTemp+"' or user_id is null or user_id='') order by user_id");
			if (rs_repsx !=null) {
				while (rs_repsx.next()) {
					rep_account= rs_repsx.getString("rep_account");
					address1= rs_repsx.getString("address1");
					address2= rs_repsx.getString("address2");
					rep_city= rs_repsx.getString("rep_city");
					rep_state= rs_repsx.getString("state");
					rep_zip_code= rs_repsx.getString("zip");
					rep_telephone= rs_repsx.getString("telephone");
					rep_fax= rs_repsx.getString("fax");
					rep_email= rs_repsx.getString("email");
					rep_name = rs_repsx.getString("rep_name");
					//out.println(rep_email+"::"+session_rep_no+"::"+rs_reps.getString("user_id"));
					repCount++;
				}
			}
		}
		if(repCount<=0){
			ResultSet rs_repsx = stmt.executeQuery("SELECT * FROM cs_reps where rep_no like '"+session_rep_no+"' order by user_id");
			if (rs_repsx !=null) {
				while (rs_repsx.next()) {
					rep_account= rs_repsx.getString("rep_account");
					address1= rs_repsx.getString("address1");
					address2= rs_repsx.getString("address2");
					rep_city= rs_repsx.getString("rep_city");
					rep_state= rs_repsx.getString("state");
					rep_zip_code= rs_repsx.getString("zip");
					rep_telephone= rs_repsx.getString("telephone");
					rep_fax= rs_repsx.getString("fax");
					rep_email= rs_repsx.getString("email");
					rep_name = rs_repsx.getString("rep_name");
					//out.println(rep_email+"::"+session_rep_no+"::"+rs_reps.getString("user_id"));
					repCount++;
				}
			}
		}
		rs_reps.close();
		rs_project.close();
		stmt.close();
		myConn.close();
		stmt_psa.close();
		myConn_psa.close();

		//Checking for nulls
		if(email_to==null){email_to="";}
		//out.println("Goest to "+email_to);
		%>
		<form name="selectform"  method="post" action="mail.delivery.jsp" onsubmit="return validateEmail()">

			<input type='hidden' name="q_no" value="<%= q_no %>">
			<input type='hidden' name="product_id" value="<%= product_id %>">
			<input type='hidden' name="rep_no" value="<%= rep_no %>">
			<input type='hidden' name="project_type" value="<%= project_type %>">
			<input type='hidden' name="from" value="<%= rep_email %>">
			<input type='hidden' name="overage" value="<%= o_cost %>">
			<input type='hidden' name="handling_cost" value="<%= handling_cost %>">
			<input type='hidden' name="freight_cost" value="<%= freight_cost %>">
			<input type='hidden' name="project_name" value="<%= project_name %>">
			<input type='hidden' name="rep_account" value="<%= rep_account %>">
			<input type='hidden' name="address1" value="<%= address1 %>">
			<input type='hidden' name="address2" value="<%= address2 %>">
			<input type='hidden' name="rep_city" value="<%= rep_city %>">
			<input type='hidden' name="state" value="<%= rep_state %>">
			<input type='hidden' name="rep_zip_code" value="<%= rep_zip_code %>">
			<input type='hidden' name="rep_telephone" value="<%= rep_telephone %>">
			<input type='hidden' name="rep_fax" value="<%= rep_fax %>">
			<input type='hidden' name="rep_email" value="<%= rep_email %>">
			<input type='hidden' name="email_to" value="<%= email_to %>">
			<input type='hidden' name="rep_name" value="<%= rep_name %>">
			<input type='hidden' name="tp" value="<%= tp %>">
			<input type='hidden' name="QuoteID" value="<%= QuoteID %>">
			<input type='hidden' name="AcctID" value="<%= AcctID %>">
			<input type='hidden' name="UserID" value="<%= UserID %>">
			<input type='hidden' name="group_id" value="<%= group_id %>">
			<input type='hidden' name="total" value="<%= total%>">
			<input type='hidden' name="commission" value="<%= commission %>">
			<table border='0' width='75%'>
				<tr><td align='center' colspan='2'><input type='checkbox' name='self' onclick='setEmail()'>Fill out my email address in the 'Mail to:' field</td></tr>
				<tr><td class='noheader' align='right'>Mail to:</td>
					<td class='noheader'><input type='text' name="to" value="<%= email_to.trim() %>" class='notext1' ></td>
				</tr>
				<tr><td class='header' align='right'>cc:</td>
					<td class='header'><input type='text' name="cc" class='text1'></td>
				</tr>
				<%
				if( !((project_type==null)||(project_type.startsWith("nu"))||project_type.trim().length()==0)||product_id.equals("APC")){
				if(!session_group.toUpperCase().startsWith("REP")&&!product_id.equals("APC")){
						//out.println("Test1");
				%>
				<tr><td class='noheader' align='right'>Quote Type:</td>
					<td class='noheader'>
						<select name='q_type'>
							<option value='1'>Types & Quantities</option>
							<%	if (!( product_id .equals("GE")|group_id.startsWith("Decolink") )){ %>
							<option value='2'>Plans & Specs</option>
							<%  }%>
							<%	if (!(product_id.equals("LVR")|product_id.equals("BV")|product_id.equals("GRILLE")|product_id.equals("GCP")|product_id.equals("EFS")|product_id.equals("DADE_LVR"))) {%>
							<option value='3'>Line & Item</option>
							<%	}%>
							<%
							if (!( product_id.equals("GE")|group_id.startsWith("Decolink") )){
								if ((product_id.equals("IWP")|product_id.equals("EJC"))) {
							%>
							<option value='4'>Plans & Specs with Quantities</option>
							<%
						}
					}
							if (product_id.equals("IWP")) {
							%>
							<option value='5'>Line & Item International</option>
							<option value='6'>Types & Quantities International</option>
							<%
						}

							%>








						</select>&nbsp;&nbsp;
						Show Commission:<input type='checkbox' name='show' >
					</td>
				</tr>
				<%
				   }
			else{
				if(rep_quote==null){out.println("<input type='hidden' name='q_type' value='1'>");}
				else{out.println("<input type='hidden' name='q_type' value='"+rep_quote+"'>");}
			}
		}else{
		//out.println("test2");
				%>
				<tr><td class='noheader' align='right'>Quote Type:</td>
					<td class='noheader'>
						<select name='q_type'>
							<option value='1'>Types & Quantities</option>
							<%	if (!(product_id.equals("LVR")|product_id.equals("BV")|product_id.equals("GRILLE")|product_id.equals("GCP")|product_id.equals("EFS")|product_id.equals("DADE_LVR"))) {%>
							<option value='2'>Line & Item</option>
							<%	}%>
						</select>
					</td>
				</tr>
				<%
				}
				%>
				<tr><td class='noheader' align='right'>Message:</td>
					<td class='noheader'><textarea name='message' cols=30 rows=6></textarea></td>
				</tr>
				<tr><td align='center' colspan='2'>&nbsp;&nbsp;</td></tr>
				<tr><td align='center' colspan='2'><input type='checkbox' name='tearsheet' >Attach Tearsheets</td></tr>
						<%
						if (product_id.equals("IWP")||product_id.equals("EJC")||product_id.equals("EFS")){
						%>
				<tr><td align='center' colspan='2'><input type='checkbox' name='credit' >Attach Credit Application</td></tr>
						<%
					}
						%>
				<tr><td align='center' colspan='2'><input type='checkbox' name='copy' onclick='showHide()'>Send copy to my inbox</td></tr>


			</table>

			<div id='div1' class='hidden'>
				<table width='75%'>
					<tr><td>
					<tr><td align='center' colspan='2'><input type='text' name='useremail' value='<%=rep_email%>' class='notext1' readonly></td></tr>
					</td></tr></table>
			</div>
			<table width='75%'>

				<tr><td align='center' colspan='2'><input type='submit' name='Add' value='EMAIL' class='button'></td></tr>
			</table>

		</form>
	</body>
</html>

<%
}
catch(Exception e){

	out.println(e);
}

%>