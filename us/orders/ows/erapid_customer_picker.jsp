<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="session"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
	   erapidBean.setServerName("server1");
}
try{%>
<html>
	<HEAD>
		<link rel='stylesheet' href='style1.css' type='text/css' />
		<script language="JavaScript" src="sorttable.js"></script>
		<SCRIPT LANGUAGE="JavaScript">
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
			function SendValue2(s){
				if(document.selectform.cust_no.length>1){
					//alert(document.selectform.cust_no[s].value+"::"+document.selectform.customer[s].value);
					var selvalue=document.selectform.cust_no[s].value;
					window.opener.document.calform.cust_no.value=selvalue;
					var selvalue2=document.selectform.customer[s].value;
					window.opener.document.calform.customer.value=selvalue2;
				}
				else{
					var selvalue=document.selectform.cust_no.value;
					window.opener.document.calform.cust_no.value=selvalue;
					var selvalue2=document.selectform.customer.value;
					window.opener.document.calform.customer.value=selvalue2;

				}
				window.close();
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
				}
			}
			function setUp(){
				obj1=new SelObj('selectform','selectmenu','entry');
				obj1.bldInitial();
			}
		</script>
















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
					//alert(szBuf+":1");
					for(index=0;index<window.opener.document.selectform.state.length;index++){
						//alert("::"+window.opener.document.selectform.state[index].value +"::"+szBuf+"::");
						//alert(szBuf);
						for(index2=0;index2<document.selectform.stateName.length;index2++){
							if(document.selectform.stateName[index2].value==szBuf){
								//alert(szBuf);
								szBuf=document.selectform.stateCode[index2].value
								//alert(szBuf);
							}
						}
						if(window.opener.document.selectform.state[index].value==szBuf){
							//alert("HERE");
							window.opener.document.selectform.state.selectedIndex=index;
						}
					}
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
						for(index2=0;index2<document.selectform.stateName.length;index2++){
							if(document.selectform.stateName[index2].value==szBuf){
								//alert(szBuf);
								szBuf=document.selectform.stateCode[index2].value
								//alert(szBuf);
							}
						}
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
					//szBuf = tmp.slice( 0, tmp.length);
					window.opener.document.selectform.eu_cust_bpcs_no.value=szBuf;
				}
				window.close();
			}

			//  End -->
		</script>
		<%
				//HttpSession UserSession_rep = request.getSession();
				//String rep_no= UserSession_rep.getAttribute("rep_no").toString();
				String rep_no= userSession.getRepNo();
				//String rep_no = request.getParameter("rep_no");//Login id
				String isHeader=request.getParameter("isHeader");
				String cmd=request.getParameter("cmd");
				String mode=request.getParameter("mode");
				String entry_no_result=request.getParameter("entry_no");
				String cust_name_result=request.getParameter("cust_name");
				String addr1_result=request.getParameter("addr1");
				String addr2_result=request.getParameter("addr2");
				String city_result=request.getParameter("city");
				String state_result=request.getParameter("state");
				String zip_result=request.getParameter("zip");
				String phone_result=request.getParameter("phone");
		%>
		<title>
			Cust Search Results
		</title>
	</HEAD>
	<%@ page language="java" import="java.sql.*" errorPage="error.jsp" %>
	<center>
		<h1> Customer's with the Name "<%= cust_name_result %>" </h1>
		<form name='selectform'>

			<%





			if(entry_no_result==null){
				entry_no_result="";
			}
			if(cust_name_result==null){
				cust_name_result="";
			}
			if(addr1_result==null){
				addr1_result="";
			}
			if(addr2_result==null){
				addr2_result="";
			}
			if(city_result==null){
				city_result="";
			}
			if(state_result==null){
				state_result="";
			}
			if(zip_result==null){
				zip_result="";
			}
			if(phone_result==null){
				phone_result="";
			}

			if(cmd==null){
				cmd="";
			}
			%>
			<center>
				<%@ include file="../../../db_con.jsp"%>
				<%@ include file="../../../db_con_psa.jsp"%>

				<%
				ResultSet rsStates=stmt.executeQuery("select state_code,state_name from cs_state_codes");
				if(rsStates != null){
					while(rsStates.next()){
						out.println("<input type='hidden' name='stateCode' value='"+rsStates.getString(1)+"'>");
						out.println("<input type='hidden' name='stateName' value='"+rsStates.getString(2)+"'>");
					}
				}
				rsStates.close();
				String repList="'"+rep_no;
				ResultSet rsMapping=stmt.executeQuery("Select rep_cust from cs_rep_mapping where rep_no='"+rep_no+"'");
				if(rsMapping != null){
					while(rsMapping.next()){
						repList=repList+","+rsMapping.getString(1)+"";
					}
				}
				rsMapping.close();
				for(int a=0; a<repList.length(); a++){
					int x=repList.indexOf(",",a);
						if(x>0){
							repList=repList.substring(0,x)+"'"+repList.substring(x,x+1)+"'"+repList.substring(x+1);
							a=x+2;
						}
				}
				repList=repList+"'";
				int custno=0;String cust_no="";
				String customer="";String addr1="";String city="";String state="";String phone="";String email="";
				String show="";
				//HttpSession UserSession = request.getSession();
				//String country_code_session=UserSession.getValue("country_code").toString();
				//String group=UserSession.getValue("usergroup").toString();
				String group=userSession.getGroup();
				String country_code_session=userSession.getCountry();
				//out.println(group);
				String tempQuery="";
				%>
				<center>
					<form name="selectform" onSubmit="javascript:window.location=document.selectform.selectmenu.options[document.selectform.selectmenu.selectedIndex].value;
							return false;">
					<!--<h1> Customer's with the Name "<%= cust_name_result %>" </h1>-->
						<input type='hidden' name='mode' value='<%=mode%>'>
						<select name="selectmenu" size="8" class='big2x'>

							<%

							PreparedStatement query_customer = null;
							if(group.equals("GrandE")){
								if(entry_no_result.trim().length()>0){
									tempQuery="select cust_name1,cust_no,cust_addr1,city,state,phone,email,bill_cust from cs_customers where bpcs_cust_no like ? and country_code='"+country_code_session+"' and (dormant is null or dormant not like 'Y') and created_rep_no like 'ge%' order by cust_name1";
									query_customer = myConn.prepareStatement(tempQuery);
									query_customer.setString(1,entry_no_result+"%");
								}
								else{
									tempQuery="select cust_name1,cust_no,cust_addr1,city,state,phone,email,bill_cust from cs_customers where cust_name1 like ? ";
									if(addr1_result.trim().length()>0){
										tempQuery=tempQuery+"and cust_addr1 like ?";
									}
									if(addr2_result.trim().length()>0){
										tempQuery=tempQuery+"and cust_addr2 like ? ";
									}
									if(city_result.trim().length()>0){
										tempQuery=tempQuery+"and city like ? ";
									}
									if(state_result.trim().length()>0){
										tempQuery=tempQuery+"and state like ? ";
									}
									if(zip_result.trim().length()>0){
										tempQuery=tempQuery+"and zip_code like ?";
									}
									if(phone_result.trim().length()>0){
										tempQuery=tempQuery+"and phone like ? ";
									}
									tempQuery=tempQuery+"and country_code='"+country_code_session+"' and (dormant is null or dormant not like 'Y') and created_rep_no like 'ge%' order by cust_name1";
									query_customer = myConn.prepareStatement(tempQuery);
									query_customer.setString(1,cust_name_result+"%");
									int i=2;
									if(addr1_result.trim().length()>0){
										query_customer.setString(i,addr1_result+"%");
										i++;
									}
									if(addr2_result.trim().length()>0){
										query_customer.setString(3,addr2_result+"%");
										i++;
									}
									if(city_result.trim().length()>0){
										query_customer.setString(4,city_result+"%");
										i++;
									}
									if(state_result.trim().length()>0){
										query_customer.setString(5,state_result+"%");
										i++;
									}
									if(zip_result.trim().length()>0){
										query_customer.setString(6,zip_result+"%");
										i++;
									}
									if(phone_result.trim().length()>0){
										query_customer.setString(7,phone_result+"%");
										i++;
									}
								}
							}
							else{
								if(entry_no_result.trim().length()>0){
									//out.println("HERE2<BR>");
									tempQuery="select cust_name1,cust_no,cust_addr1,cust_addr2,city,state,phone,email,bill_cust from cs_customers where bpcs_cust_no like ? and country_code='"+country_code_session+"' and (dormant is null or dormant not like 'Y') and created_rep_no in ("+repList+") order by cust_name1";
									query_customer = myConn.prepareStatement(tempQuery);
									query_customer.setString(1,entry_no_result+"%");
								}
								else{
									//out.println("HERE1<BR>");
									tempQuery="select cust_name1,cust_no,cust_addr1,city,state,phone,email,bill_cust,zip_code,cust_addr2,attention from cs_customers where cust_name1 like ? ";
									if(addr1_result.trim().length()>0){
										tempQuery=tempQuery+"and cust_addr1 like ?";
									}
									if(addr2_result.trim().length()>0){
										tempQuery=tempQuery+"and cust_addr2 like ? ";
									}
									if(city_result.trim().length()>0){
										tempQuery=tempQuery+"and city like ? ";
									}
									if(state_result.trim().length()>0){
										tempQuery=tempQuery+"and state like ? ";
									}
									if(zip_result.trim().length()>0){
										tempQuery=tempQuery+"and zip_code like ?";
									}
									if(phone_result.trim().length()>0){
										tempQuery=tempQuery+"and phone like ? ";
									}
									tempQuery=tempQuery+"and country_code='"+country_code_session+"' and (dormant is null or dormant not like 'Y') and created_rep_no in ("+repList+") order by cust_name1";
									//out.println(tempQuery);
									query_customer = myConn.prepareStatement(tempQuery);
									query_customer.setString(1,cust_name_result+"%");
									int i=2;
									if(addr1_result.trim().length()>0){
										query_customer.setString(i,addr1_result+"%");
										i++;
									}
									if(addr2_result.trim().length()>0){
										query_customer.setString(3,addr2_result+"%");
										i++;
									}
									if(city_result.trim().length()>0){
										query_customer.setString(4,city_result+"%");
										i++;
									}
									if(state_result.trim().length()>0){
										query_customer.setString(5,state_result+"%");
										i++;
									}
									if(zip_result.trim().length()>0){
										query_customer.setString(6,zip_result+"%");
										i++;
									}
									if(phone_result.trim().length()>0){
										query_customer.setString(7,phone_result+"%");
										i++;
									}

								}
							}

							String test1="";
							ResultSet myResult = query_customer.executeQuery();
							if (myResult !=null) {
								while (myResult.next()){
									/*

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


											String custstring=rs1.getString(4)+"@"+rs1.getString(5)+"@"+rs1.getString(6)+"@"+rs1.getString(7)+"@"+rs1.getString(8).trim()+"@"+rs1.getString(9)+"@"+rs1.getString(10)+"@  @"+rs1.getString(11)+"@"+rs1.getString(1)+"@";
											out.println("<option value='"+custstring+"'>");

											for(int i=1; i<=11;i++){
												if(i!=2&&i!=3){
													out.println(rs1.getString(i).trim()+", ");
												}
											}

											out.println("</option>");

									*/



									String custstring=myResult.getString("cust_name1")+"@"+myResult.getString("cust_addr1")+"@"+myResult.getString("cust_addr2")+"@"+myResult.getString("city")+"@"+myResult.getString("state").trim()+"@"+myResult.getString("zip_code")+"@"+myResult.getString("phone")+"@ @"+myResult.getString("attention")+"@0@";
									out.println("<option value='"+custstring+"'>");
									out.println(myResult.getString("cust_no")+",");
									out.println(myResult.getString("cust_name1")+",");
									out.println(myResult.getString("cust_addr1")+",");
									out.println(myResult.getString("cust_addr2")+",");
									out.println(myResult.getString("city")+",");
									out.println(myResult.getString("state")+",");
									out.println(myResult.getString("zip_code")+",");
									out.println(myResult.getString("phone"));

									out.println("</option>");




									/*
									out.println("<tr>");
									if (customer==null){customer="";}
									out.println("<td width=10% nowrap>"+customer+"</td>");
									out.println("</td>");
									out.println("<td width=5% nowrap>");
									out.println("<input type='button' name='Select' value='Select' onclick=SendValue2('"+custno+"') class='button'>");
									out.println("<input type='hidden' name='cust_no' value='"+cust_no+"'>");
									out.println("<input type='hidden' name='customer' value='"+customer+"'>");
									out.println("</td>");
									if (addr1==null){addr1="";}
									out.println("<td width=10% nowrap>"+addr1+"&nbsp;</td>");
									if (city==null){city="";}
									out.println("<td width=5% nowrap>"+city+"&nbsp;</td>");
									if (state==null){state="";}
									out.println("<td width=5% nowrap>"+state+"&nbsp;</td>");
									if (phone==null){phone="";}
									out.println("<td width=10% nowrap>"+phone+"&nbsp;</td>");
									if (email==null){email="";}
									out.println("<td width=10% nowrap>"+email+"&nbsp;</td>");
									if (show!=null){if (show.equals("N")){show="NO";}else{show="YES";}}
									else{show="NO";}
									out.println("<td width=10% nowrap>"+show+"&nbsp;</td>");
									out.println("</tr>");
									*/
									custno++;

								}
							}
							%>
						</select><BR>
						<input type="button" value="Select" class='button' onClick="sendValue(this.form.selectmenu);">
					</form>
					<%


					query_customer.close();
					stmt.close();
					myConn.close();
					myConn_psa.close();

					if (custno<=0){
						out.println("<br><font color='red' size='2'>There are no customers matching search criteria</font><br><br>");
						out.println("<input type='button' name='addc' value='Add new customer' onclick=javascript:document.location.href='https://"+ application.getInitParameter("HOST")+"/erapid/us/new_customer.jsp?id="+ rep_no +"' class='button'>");
					}

					}
					  catch(Exception e){
					  out.println(e);
					  }
					%>
				</center>
				<div align= 'right'>
				</div>
		</form>
	</body>
</html>

