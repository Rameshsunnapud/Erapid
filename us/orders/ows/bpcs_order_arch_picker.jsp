<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>

<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<html>
	<HEAD>
		<link rel='stylesheet' href='style1.css' type='text/css' />
		<SCRIPT LANGUAGE="JavaScript">
			<!-- Begin
			function SelObj(formname,selname,textname,str){
				this.formname=formname;
				this.selname=selname;
				this.textname=textname;
				this.select_str=str||'';
				this.selectArr=new Array();
				this.initialize=initialize;
				this.bldInitial=bldInitial;
				this.bldUpdate=bldUpdate;
			}

			function initialize(){
				if(this.select_str==''){
					for(var i=0;i<document.forms[this.formname][this.selname].options.length;i++){
						this.selectArr[i]=document.forms[this.formname][this.selname].options[i];
						this.select_str+=document.forms[this.formname][this.selname].options[i].value+":"+
							   document.forms[this.formname][this.selname].options[i].text+",";
					}
				}
				else{
					var tempArr=this.select_str.split(',');
					for(var i=0;i<tempArr.length;i++){
						var prop=tempArr[i].split(':');
						this.selectArr[i]=new Option(prop[1],prop[0]);
					}
				}
				return;
			}
			function bldInitial(){
				this.initialize();
				for(var i=0;i<this.selectArr.length;i++)
					document.forms[this.formname][this.selname].options[i]=this.selectArr[i];
				document.forms[this.formname][this.selname].options.length=this.selectArr.length;
				return;
			}

			function bldUpdate(){
				var str=document.forms[this.formname][this.textname].value.replace('^\\s*','');
				if(str==''){
					this.bldInitial();
					return;
				}
				this.initialize();
				var j=0;
				pattern1=new RegExp("^"+str,"i");
				for(var i=0;i<this.selectArr.length;i++)
					if(pattern1.test(this.selectArr[i].text))
						document.forms[this.formname][this.selname].options[j++]=this.selectArr[i];
				document.forms[this.formname][this.selname].options.length=j;
				if(j==1){
					document.forms[this.formname][this.selname].options[0].selected=true;
					//document.forms[this.formname][this.textname].value = document.forms[this.formname][this.selname].options[0].text;
				}
			}
			function setUp(){
				obj1=new SelObj('selectform','selectmenu','entry');
				// menuform is the name of the form you use
				// itemlist is the name of the select pulldown menu you use
				// entry is the name of text box you use for typing in
				obj1.bldInitial();
				document.selectform.selectmenu.focus();
			}
			//  End -->
		</script>

		<SCRIPT LANGUAGE="JavaScript">
			<!-- Begin
			function sendValue(s){
				var selvalue=s.options[s.selectedIndex].value;
				var m=document.selectform.tmode.value;
				//alert(m);

				var tmp=selvalue;
				var iLoc;
				var szBuf;
				iLoc=tmp.search("@");

				if(m==1){
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.ship_name.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.ship_addr1.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.ship_addr2.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.city.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.state.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.zip.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.ship_phone.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.ship_fax.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.ship_email.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.ship_cust_bpcs_no.value=szBuf;
				}
				if(m==2){
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.invoice_name.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.invoice_addr1.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.invoice_addr2.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.invoice_city.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.invoice_state.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.invoice_zip.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.invoice_phone.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.invoice_fax.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.invoice_email.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.invoice_cust_bpcs_no.value=szBuf;
				}

				if(m==3){
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.arch_name.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.arch_addr1.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.arch_addr2.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.arch_city.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.arch_state.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.arch_zip.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.arch_phone.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.arch_fax.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.arch_email.value=szBuf;

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.arch_cust_bpcs_no.value=szBuf;
				}

				//szBuf = tmp.slice( iLoc+1, tmp.length-(tmp.length-iLoc) );
				//	alert(szBuf);
				//	return szBuf;
				//szBuf = tmp.slice( iLoc+1, tmp.length-(tmp.length-iLoc) );
				//window.opener.document.selectform.cust_addr1.value = szBuf;


				window.close();
			}
			//  End -->
		</script>
		<title>
			Cust Search Results
		</title>
	</HEAD>
	<BODY OnLoad="javascript:setUp()" bgcolor="whitesmoke">
		<%@ page language="java" import="java.sql.*"   errorPage="error.jsp" %>
		<%

org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
				String entry = request.getParameter("entry");//Login id
				String entry_no = request.getParameter("entry_no");
				String rep_no = request.getParameter("rep_no");//Login id
				String mode = request.getParameter("tmode");//Login id
				//HttpSession UserSession = request.getSession();
				//String country_code_session=UserSession.getValue("country_code").toString();
				//String usergroup=UserSession.getValue("usergroup").toString();
	//String country_code=userSession.getCountry();

	String country_code_session=userSession.getCountry();

	String usergroup=userSession.getGroup();

						String query="";
		//	if(country_code_session.equals("GB")){rep_no="%";}
			//if(country_code_session.equals("GB")){
			////	if(!(UserSession.getValue("usergroup").toString().equals("UK-DIST"))){rep_no="%";}
		   // }
					if(usergroup.startsWith("Grand")){
					out.println("Hello");
					rep_no="GE%";
					}


		//		out.println("Teasting country"+country_code_session+rep_no);
			query = "select TOP 20 a.name,a.city_or_town__c,a.state_province__C,a.country__c,a.fax,phone,a.postal_code_or_zip_code__c from Account a inner join recordtype r on a.recordtypeid=r.id where (type like '%architect%' or type like '%consultant/engineer%') and (r.name='C/S US' or r.name='CS Impact')  ";
			if(entry != null && entry.trim().length() > 0){
				query = query + "and  a.name like '" + entry + "%' ";
			}

		%>

	<center>
		<h1> Customer's with the Name "<%= entry %>" </h1>
		<form name="selectform" onSubmit="javascript:window.location=document.selectform.selectmenu.options[document.selectform.selectmenu.selectedIndex].value;
				return false;">
			<h1 class='subhead'>Name Filter</h1>
			<font face="verdana" size="-6"><b>Enter few letters of the name:</b></font>
			<input type="text" name="entry" class='text' onKeyUp="javascript:obj1.bldUpdate();">
			<input type="hidden" name="tmode" value=<%=mode%>>
			<br><br><b><font face="verdana" size="-6">Pick a Customer:</font></b>
			<select name="selectmenu" size="8" class='big2'>
				<%
				%>
				<%@ include file="../../../db_con.jsp"%>
				<%@ include file="../../../db_con_sfdc.jsp"%>
				<%
					PreparedStatement query_customer =null;
						//out.println("test")
/*
						if ((usergroup.toString().startsWith("GCP"))){
								//out.println("YES1");
						query_customer = myConn.prepareStatement("select * from cs_customers where cust_name1 like ? and country_code='"+country_code_session+"' and created_rep_no in ('GC0','"+rep_no+"') and dormant not like 'Y' order by cust_name1");
						query_customer.setString(1,entry+"%");
					//	out.println("YES");
						}
						else if ((usergroup.toString().startsWith("Grand"))){
								//out.println("YES1");
						query_customer = myConn.prepareStatement("select * from cs_customers where cust_name1 like ? and country_code='"+country_code_session+"' and created_rep_no like '"+rep_no+"' and dormant not like 'Y' order by cust_name1");
						query_customer.setString(1,entry+"%");
					//	out.println("YES");
						}

						else{
							 if(entry_no.equals(""))
						{
						query_customer = myConn.prepareStatement("select * from cs_customers where cust_name1 like ? and country_code='"+country_code_session+"' and dormant not like 'Y' and created_rep_no like ? order by cust_name1");
						}
						else
						{
						query_customer = myConn.prepareStatement("select * from cs_customers where bpcs_cust_no like ? and country_code='"+country_code_session+"' and dormant not like 'Y' and created_rep_no like ? order by cust_name1");
						}
*/





//query_customer = myConn_sfdc.prepareStatement(query);


						//out.println("NO1");
						//query_customer.setString(1,entry+"%");
					  //	query_customer.setString(2,rep_no);
					 // query_customer.setString(2,"%");
					//	out.println("NO");
						ResultSet myResult = stmt_sfdc.executeQuery(query);
						if (myResult !=null) {
						while (myResult.next()){
//logger.debug("4");
						//logger.debug(query+"::"+myResult.getString("a.name"));
						String cn1 = myResult.getString(1);
//logger.debug("a");
						String ca1 = "";
						String ca2 = "";
						String cct = myResult.getString(2);
//logger.debug("b");
						String cst = myResult.getString(3);
//logger.debug("c");
						String czp = myResult.getString(7);
//logger.debug("d");
						String cp = myResult.getString(6);
//logger.debug("e");
						String cf = myResult.getString(5);
//logger.debug("f");
						String cn = "";
						String cbn = "";
						String order4 = "";
						order4=country_code_session+order4;
//logger.debug("5");
				%>
				<option value="<%= cn1 %> @<%= ca1 %>@<%= ca2 %>@<%= cct %>@<%= cst %>@<%= czp %>@<%= cp %>@<%= cf %>@<%= cn %>"> <%= cn1 %> ,<%= ca1 %><%= ca2 %> , <%= cct %>, <%= cst %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<%           }
					}
					%>
			</select><p>
				<%
//logger.debug("after");
//out.println("::"+query+"::");
			//query_customer.close();
			//myResult.close();
			stmt.close();
			myConn.close();
stmt_sfdc.close();
myConn_sfdc.close();

				%>
				<input type="button" value="Select" class='button' onClick="sendValue(this.form.selectmenu);">
		</form>
		<div align= 'right'>

		</div>
	</center>
</body>
</html>
<%
}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>
