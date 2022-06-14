
<html>
	<HEAD>
		<link rel='stylesheet' href='style1.css' type='text/css' />


		<SCRIPT LANGUAGE="JavaScript">
			<!-- Begin
			function sendValue(s){
				var selvalue=s.options[s.selectedIndex].value;
				var m=document.selectform.mode.value;
				//alert(m);
				var tmp=selvalue;
				var iLoc;
				var szBuf;
				iLoc=tmp.search("@");
				if(m==1){
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.cust_name1.value=szBuf;
					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.cust_addr1.value=szBuf;
					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.cust_addr2.value=szBuf;
					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.city.value=szBuf;
					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					//window.opener.document.selectform.statex.value = szBuf;
					for(index=0;index<window.opener.document.selectform.state.length;index++){
						//alert("::"+window.opener.document.selectform.state[index].value +"::"+szBuf+"::");
						if(window.opener.document.selectform.state[index].value==szBuf){
							//alert("HERE");
							window.opener.document.selectform.state.selectedIndex=index;
						}
					}
					//alert(szBuf);
					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.zip_code.value=szBuf;
					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.phone.value=szBuf;
					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.fax.value=szBuf;
					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.contact_name.value=szBuf;
					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.bill_cust_bpcs_no.value=szBuf;
					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");

					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.bill_cust_bpcs_no_alt.value=szBuf;
				}
				if(m==2){
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.eu_cust_name1.value=szBuf;
					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.eu_cust_addr1.value=szBuf;
					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.eu_cust_addr2.value=szBuf;
					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.eu_city.value=szBuf;
					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.eu_state.value=szBuf;
					for(index=0;index<window.opener.document.selectform.eu_state.length;index++){
						if(window.opener.document.selectform.eu_state[index].value==szBuf){
							window.opener.document.selectform.eu_state.selectedIndex=index;
						}
					}

					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.eu_zip_code.value=szBuf;
					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.eu_phone.value=szBuf;
					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.eu_fax.value=szBuf;
					tmp=tmp.slice(iLoc+1,tmp.length)
					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					tmp=tmp.slice(iLoc+1,tmp.length)

					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					tmp=tmp.slice(iLoc+1,tmp.length)
					//szBuf = tmp.slice( 0, tmp.length);
					window.opener.document.selectform.eu_cust_bpcs_no.value=szBuf;

					iLoc=tmp.search("@");
					szBuf=tmp.slice(0,tmp.length-(tmp.length-iLoc));
					window.opener.document.selectform.eu_cust_bpcs_no_alt.value=szBuf;
				}
				window.close();
			}
			//  End -->
		</script>
		<title>
			Cust Search Results
		</title>
	</HEAD>
	<BODY OnLoad="javascript:setUp()" bgcolor="whitesmoke">
		<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
		<%
		String entry_no = request.getParameter("entry_no");
		String rep_no = request.getParameter("rep_no");//Login id
		String cust_name= request.getParameter("cust_name");
		String addr1= request.getParameter("addr1");
		String addr2= request.getParameter("addr2");
		String city= request.getParameter("city");
		String state= request.getParameter("state");
		String zip= request.getParameter("zip");
		String mode=request.getParameter("mode");
		String phone= request.getParameter("phone");
		String addr_type= request.getParameter("addr_type");
		String table="<table border='1'>";
		%>
	<center>
		<h1> Customer's with the Name "<%= cust_name %>" </h1>
		<form name="selectform" onSubmit="javascript:window.location=document.selectform.selectmenu.options[document.selectform.selectmenu.selectedIndex].value;
				return false;">
			<h1 class='subhead'>Name Filter</h1>
			<input type='hidden' name='mode' value='<%=mode%>'>
			<font face="verdana" size="-6"><b>Enter few letters of the name:</b></font>
			<input type="text" name="entry" class='text' onKeyUp="javascript:obj1.bldUpdate();">
			<br><br><b><font face="verdana" size="-6">Pick a Customer:</font></b>
			<select name="selectmenu" size="8" class='big2x'>

				<%@ include file="db_con_bpcs.jsp"%>
				<%@ include file="db_con_bpcsusrmm.jsp"%>
				<%
				if(entry_no != null && entry_no.trim().length()>0){
					try{
						int count=0;
						//String query="SELECT ccust, cnme, cad1, cad2, cad3, cste, czip, cphon, stadtp, tship, tname, tatn, tadr1, tadr2, tadr3, tste, tpost, tphone, CMFAXN from bcanfpg/rcm left outer join bcanfpg/est on ccust = tcust where ccust = "+entry_no+" and cmid='CM' order by ccust, stadtp, tship";
						String query="SELECT ccust, cnme, cad1, cad2, cad3, cste, czip, cphon, stadtp, tship, tname, tatn, tadr1, tadr2, tadr3, tste, tpost, tphone, CMFAXN from bpcsffg/rcm left outer join bpcsffg/est on ccust = tcust where ccust = "+entry_no+" and cmid='CM' order by ccust, stadtp, tship";

						ResultSet rs0=stmt_bpcsusrmm.executeQuery(query);
						if(rs0 != null){
							while(rs0.next()){
								if(count==0){
									String custstring2=rs0.getString(2)+"@"+rs0.getString(3).trim()+"@"+rs0.getString(4)+"@"+rs0.getString(5)+"@"+rs0.getString(6).trim()+"@"+rs0.getString(7)+"@"+rs0.getString(8)+"@"+rs0.getString(19)+"@"+rs0.getString(12)+"@"+rs0.getString(1)+"@@";
								custstring2=custstring2.replaceAll("\"","'");
								out.println("<option value=\""+custstring2+"\">");
									for(int i=1; i<9; i++){
										out.println(rs0.getString(i).trim()+", ");
									}
									//out.println(rs0.getString(10).trim()+", ");
									out.println("</option>");
								}
								count++;
								String custstring=rs0.getString(2)+"@"+rs0.getString(13).trim()+"@"+rs0.getString(14)+"@"+rs0.getString(15)+"@"+rs0.getString(16).trim()+"@"+rs0.getString(17)+"@"+rs0.getString(18)+"@"+rs0.getString(19)+"@"+rs0.getString(12)+"@"+rs0.getString(1)+"@"+rs0.getString(10)+"@";
								custstring=custstring.replaceAll("\"","'");
								out.println("<option value=\""+custstring+"\">");
								for(int i=1; i<=18; i++){
									if(i<3 || i>12){
										out.println(rs0.getString(i).trim()+", ");
									}
								}
							//	out.println(rs0.getString(10).trim()+", ");
								out.println("</option>");
							}
						}
						rs0.close();
					}
					catch(SQLException e){
						out.println("SQL EXCEPTION:<BR>"+e);
					}
					catch(Exception ee){
						out.println("EXCPTION:<BR>"+ee);
					}
				}
				else{
				%>

				<%
				try{
					CallableStatement cs = con_bpcsusrmm.prepareCall("CALL RCM001STP (?,?,?,?,?,?,?,?)",ResultSet.TYPE_SCROLL_INSENSITIVE,ResultSet.CONCUR_READ_ONLY );
					cs.setString(1,cust_name.toUpperCase().trim());
					cs.setString(2,addr1.toUpperCase());
					cs.setString(3,addr2.toUpperCase());
					cs.setString(4,city.toUpperCase());
					cs.setString(5,state.toUpperCase().trim());
					cs.setString(6,zip.toUpperCase());
					cs.setString(7,phone.toUpperCase());
					cs.setString(8,addr_type.toUpperCase());
					ResultSet rs1 = cs.executeQuery();
					//out.println("<table border='1'>");
					if(rs1 != null){
						while(rs1.next()){
							if(!rs1.getString(4).startsWith("**")){
								String custstring=rs1.getString(4)+"@"+rs1.getString(5)+"@"+rs1.getString(6)+"@"+rs1.getString(7)+"@"+rs1.getString(8).trim()+"@"+rs1.getString(9)+"@"+rs1.getString(10)+"@  @"+rs1.getString(11)+"@"+rs1.getString(1)+"@"+rs1.getString(2)+"@";
								custstring=custstring.replaceAll("\"","'");
								out.println("<option value=\""+custstring+"\">");

								for(int i=1; i<=11;i++){
									if(i!=2&&i!=3){
										out.println(rs1.getString(i).trim()+", ");
									}
								}

								out.println("</option>");

								table=table+"<tr>";
								for(int i=1; i<=11;i++){
									if(i!=2&&i!=3){
										table=table+"<td>"+rs1.getString(i)+"</td>";
									}
								}
								table=table+"</tr>";
							}
						}
					}
					rs1.close();
					cs.close();
				}
				catch(SQLException e){
					out.println("SQL EXCEPTION:<BR>"+e);
				}
				catch(Exception ee){
					out.println("EXCPTION:<BR>"+ee);
				}

				%>
			</select><p>
				<%
			}
			//out.println(table+"</table>");
			stmt_bpcsusrmm.close();
			con_bpcsusrmm.close();
			stmt_bpcsffg.close();
			con_bpcsffg.close();
				%>
				<input type="button" value="Select" class='button' onClick="sendValue(this.form.selectmenu);">
		</form>

		<form name='erapidform' action='erapid_customer_picker.jsp'>
			<input type='hidden' name='mode' value='<%=mode%>'>
			<input type='hidden' name='rep_no' value='<%=rep_no%>'>
			<input type='hidden' name='cust_name' value='<%=cust_name%>'>
			<input type='hidden' name='addr1' value='<%=addr1%>'>
			<input type='hidden' name='addr2' value='<%=addr2%>'>
			<input type='hidden' name='city' value='<%=city%>'>
			<input type='hidden' name='state' value='<%=state%>'>
			<input type='hidden' name='zip' value='<%=zip%>'>
			<input type='hidden' name='phone' value='<%=phone%>'>
			<input type="button" value="Search My Erapid Database" class='button' onclick='javascript:document.erapidform.submit()'>
		</form>
		<div align= 'right'>
		</div>
	</center>
</body>
</html>