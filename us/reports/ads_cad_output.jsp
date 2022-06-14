<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%><html>

			<SCRIPT LANGUAGE="JavaScript">

				function finalPrice(){
					var agree=confirm("Final pricing?");
					if(agree){
						var the_width=1000;
						var the_height=1000;
						var from_top=200;
						var from_left=125;
						var has_toolbar='no';
						var has_location='no';
						var has_directories='no';
						var has_status='yes';
						var has_menubar='yes';
						var has_scrollbars='yes';
						var is_resizable='yes';
						var the_atts='width='+the_width+',height='+the_height+',top='+from_top+',screenY='+from_top+',left='+from_left+',screenX='+from_left;
						the_atts+=',toolbar='+has_toolbar+',location='+has_location+',directories='+has_directories+',status='+has_status;
						the_atts+=',menubar='+has_menubar+',scrollbars='+has_scrollbars+',resizable='+is_resizable;
						var emailurl="ads_final_pricing_send.jsp?order_no="+document.adsform.order_no.value;
						window.open(emailurl,'xx',the_atts);
					}
				}
				</script>
	<head>
		<title>ADS</title>
		<script language="JavaScript" src="date-picker.js"></script>
		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>
	<body onload='finalPrice()'>
		<%@ page language="java" import="java.sql.*" import="java.net.*" import="java.io.*" import="java.util.*" errorPage="error.jsp" %>
		<%@ include file="../../db_con.jsp"%>
		<%@ include file="../../dbcon1.jsp"%>
		<%
		String order_no=request.getParameter("q_no");
                //out.println(order_no +":: order number<BR>");
		String bpcs_order_no="";
		String project_name="";
		String project_loc="";
		String cust_name="";
		String cust_loc=",";
		String arch_name="";
		String arch_loc="";
		String rep_name="";
		String cust_no="";
		String rep_no="";
		String project_type="";
		FileOutputStream p;
		PrintStream out1;
		Properties ht=new Properties();
		%>
		<form name='adsform'>
			<input type='hidden' name='order_no' value='<%=order_no%>'>
		</form>
		<%
		try{

			ResultSet rs0=stmt.executeQuery("select bpcs_order_no, project_name,job_loc,project_state, cust_loc,cust_name,creator_id,arch_name,arch_loc,project_type from cs_project where order_no='"+order_no+"'");
			if(rs0 != null){
				while(rs0.next()){
					if(rs0.getString(1) != null && rs0.getString(1).trim().length()>0){
						bpcs_order_no=rs0.getString(1).replace(',',';');
					}
					if(rs0.getString(2) != null && rs0.getString(2).trim().length()>0){
						project_name=rs0.getString(2).replace(',',';');
					}
					if(rs0.getString("job_loc") != null && rs0.getString("job_loc").trim().length()>0){
						project_loc=rs0.getString("job_loc").replace(',',';');
					}
					if(rs0.getString("project_state") != null && rs0.getString("project_state").trim().length()>0){
						project_loc=project_loc+","+rs0.getString("project_state").replace(',',';');
					}
					else{
						project_loc=project_loc+", ";
					}
					if(rs0.getString("arch_name") != null && rs0.getString("arch_name").trim().length()>0){
						arch_name=rs0.getString("arch_name").replace(',',';');
					}
					if(rs0.getString("arch_loc") != null && rs0.getString("arch_loc").trim().length()>0){
						arch_loc=rs0.getString("arch_loc").replace(',',';');
					}
					cust_no=rs0.getString("cust_name").replace(',',';');
					rep_no=rs0.getString("creator_id").replace(',',';');
					project_type=rs0.getString("project_type");
				}
			}
			rs0.close();
			if(project_type==null){
				project_type="";
			}







		//out.println(cust_no);
		if(cust_no!=null && cust_no.startsWith("US")){
			cust_no=cust_no.substring(2);
		}
		if(project_type.equals("SFDC")||cust_no.length()>=10){
		%>
		<%@ include file="../../db_con_sfdc.jsp"%>
		<%
		ResultSet rsSf=stmt_sfdc.executeQuery("select * from contact where id='"+cust_no+"'");
		if(rsSf != null){
		while(rsSf.next()){
			cust_name=rsSf.getString("name");
			if(rsSf.getString("City_or_Town__c")!=null && !rsSf.getString("City_or_Town__c").equals("null") && rsSf.getString("City_or_Town__c").trim().length()>0){
				cust_loc=rsSf.getString("City_or_Town__c").replace(',',';')+",";
			}
			if(rsSf.getString("State_or_Province__c")!=null && !rsSf.getString("State_or_Province__c").equals("null") && rsSf.getString("State_or_Province__c").trim().length()>0){
				cust_loc=cust_loc+","+rsSf.getString("State_or_Province__c").replace(',',';');
			}
			else{
				cust_loc=cust_loc+" ";
			}

		}
	}
	rsSf.close();
	stmt_sfdc.close();
	myConn_sfdc.close();
	}
	else{
		ResultSet rsCust=stmt.executeQuery("select * from cs_customers where cust_no='"+cust_no+"' and country_code='US'");

		if(rsCust != null){
			while(rsCust.next()){
				cust_name=rsCust.getString("cust_name1");
				if( rsCust.getString("state") != null&&rsCust.getString("state").trim().length()>0){
					cust_loc=rsCust.getString("city").replace(',',';')+","+rsCust.getString("state").replace(',',';');
				}
				else{
					cust_loc=rsCust.getString("city").replace(',',';')+","+" ";
				}
			}
		}
		rsCust.close();
	}


	ResultSet rsRep=stmt.executeQuery("select * from cs_reps where rep_no='"+rep_no+"' and country_code='us'");
	if(rsRep != null){
		while(rsRep.next()){
			rep_name=rsRep.getString("rep_name");
		}
	}
	rsRep.close();
	cust_name=cust_name.replace(',',';');
	bpcs_order_no=bpcs_order_no.replace(',',';');
	project_name=project_name.replace(',',';');

	File f = new File("d:/transfer/ads/"+order_no+".csv");
	if(! f.exists()){
		p=new FileOutputStream("d:/transfer/ads/"+order_no+".csv");
	}
	else{
		p=new FileOutputStream("d:/transfer/ads/"+order_no+".csv", false);
	}
	out1 = new PrintStream(p);

	// isize = the number of columns pulled from the db.
	   int isize=94;


	ResultSet rs1=stmt.executeQuery("select * from cs_ads_output a left join cs_ads_machine_output b on a.order_no=b.order_no and a.line_no=b.line_no where a.order_no='"+order_no+"' order by cast(a.line_no as numeric)");
	if(rs1 != null){
		while(rs1.next()){
			String output="";

			for(int i=1; i<=isize; i++){
				//out.println(rs1.getString(i)+"<BR>");
				if(rs1.getString(i) != null){
					output=output+rs1.getString(i).replace(',',';')+",";
				}
				else{
					output=output+",";
				}
			}
			output=output+bpcs_order_no+"BPCS ORDER NUMB#ER,"+project_name+",";
			for(int ii=97; ii<=192; ii++){
				if(rs1.getString(ii) != null){
					output=output+rs1.getString(ii).replace(',',';')+",";
				}
				else{
					output=output+",";
				}
			}



			output=output+","+project_loc+","+arch_name+","+arch_loc+","+cust_name+","+cust_loc+","+rep_name+"";
			//out.println(output+"<BR>");
			out1.println(output);

		}
	}

	rs1.close();
/*
	ResultSet rs1=stmt.executeQuery("select * from cs_ads_output where order_no='"+order_no+"' order by cast(line_no as numeric)");
	if(rs1 != null){
		while(rs1.next()){
			String output="";

			for(int i=1; i<=isize; i++){
				//out.println(rs1.getString(i)+"<BR>");
				if(rs1.getString(i) != null){
					output=output+rs1.getString(i).replace(',',';')+",";
				}
				else{
					output=output+",";
				}
			}
			output=output+bpcs_order_no+"BPCS ORDER NUMB#ER,"+project_name+",";

			ResultSet rs2 =stmt.executeQuery("select * from cs_ads_machine_output where order_no='"+order_no+"' and line_no='"+rs1.getString("line_no")+"'");
			if(rs2 != null){
				while(rs2.next()){
					//out.println("HERE");
					for(int ii=3; ii<=98; ii++){
						if(rs2.getString(ii) != null){
							output=output+rs2.getString(ii).replace(',',';')+",";
						}
						else{
							output=output+",";
						}
					}
				}
			}
			rs2.close();


			output=output+","+project_loc+","+arch_name+","+arch_loc+","+cust_name+","+cust_loc+","+rep_name+"";
			//out.println(output+"<BR>");
			out1.println(output);

		}
	}

	rs1.close();
*/

	out1.close();
	out.println(" file ready <BR>");


}
catch (Exception e){
    out.println ("Error writing to file::<BR><BR>" + e);
}


stmt.close();
myConn.close();
stmts.close();
myConns.close();
}
catch(Exception e){
out.println(e);
}
		%>
	</body>
</html>