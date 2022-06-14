<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<%@ page language="java" import="java.sql.*" import="java.text.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>
<%@ include file="../../../db_con.jsp"%>
<link rel='stylesheet' href='../../quotes/style1.css' type='text/css' />
<html>
	<header>
		<SCRIPT language="JavaScript">

			function lastElement(x,y,z){
				//alert(y+"::"+z);
				document.editsave.lastelement.value=x;
				document.editsave.index1.value=y;
				document.editsave.index2.value=z;
			}
			function setformfocus(){
				//alert(document.editsave.lastelement.value);
				if(document.editsave.index1.value=="undefined"){
					var mytext=document.getElementById(document.editsave.lastelement.value);
					mytext.focus();
					//alert(document.getElementById(document.editsave.lastelement.value).value);
				}
				else{
					var mytext=document.getElementById(document.editsave.index1.value);
					//alert(mytext);
					mytext.focus();
				}

				//document.editsave.descriptnew.focus();
			}
		</script>
		<title>
			Shop paper
		</title>
	</header>

	<%
	String order_no=request.getParameter("order_no");
	String lastelement=request.getParameter("lastelement");
	String index1=request.getParameter("index1");
	String index2=request.getParameter("index2");
	String project_name="";
	String bpcs_ord="";
	String shop_ord="";
	String cust_po="";
	String shipto_shipdate="";
	String name1="";
	String name2="";
	String add1="";
	String add2="";
	String city="";
	String state="";
	String zip="";
	String attnname="";
	String phone="";
	String hrs_notice="";
	String layout_done_by="";
	String linetemp="0";
	String line_max="0";
	Vector line_no=new Vector();
	Vector descript=new Vector();
	Vector qty=new Vector();
	Vector mark=new Vector();
	Vector shipped=new Vector();
	Vector sect=new Vector();
	Vector ctn=new Vector();
	Vector model=new Vector();
	Vector width=new Vector();
	Vector height=new Vector();
	Vector sections=new Vector();
	Vector shape_id=new Vector();
	Vector shape=new Vector();
	Vector custom=new Vector();
	Vector screen=new Vector();
	Vector quantity=new Vector();
	Vector finish_id=new Vector();
	Vector finish=new Vector();
	Vector screen_descript=new Vector();
	Vector order_line_no=new Vector();
	Vector markx=new Vector();
	Vector l1descript=new Vector();
	Vector part_number=new Vector();
	Vector rec_no=new Vector();
	java.util.Date today=new java.util.Date();
	String date=today.getMonth()+"/"+today.getDate()+"/"+(String.valueOf(today.getYear()).substring(1));
	ResultSet rs0=stmt.executeQuery("select project_name from cs_project where order_no='"+order_no+"'");
	if(rs0 != null){
		while(rs0.next()){
			project_name=rs0.getString(1);
		}
	}
	rs0.close();
	ResultSet rs1=stmt.executeQuery("select * from cs_n1 where order_number = '"+order_no+"'");
	if(rs1 != null){
		while(rs1.next()){
			bpcs_ord=rs1.getString("bpcs_ord");
			shop_ord=rs1.getString("shop_ord");
			cust_po=rs1.getString("cust_po");
			shipto_shipdate=rs1.getString("shipto_shipdate");
			name1=rs1.getString("shipto_name1");
			name2=rs1.getString("shipto_name2");
			add1=rs1.getString("shipto_add1");
			add2=rs1.getString("shipto_add2");
			city=rs1.getString("shipto_city");
			state=rs1.getString("shipto_state");
			zip=rs1.getString("shipto_zip");
			attnname=rs1.getString("shipto_attname");
			phone=rs1.getString("shipto_phone");
			hrs_notice=rs1.getString("hrs_notice");
			layout_done_by=rs1.getString("layout_person");
		}
	}
	rs1.close();

	ResultSet rs2=stmt.executeQuery("select description,part_quantity,notes,mark_#,order_line_no,shipped,sect,ctn,rec_no,part_number from cs_l5 where order_number='"+order_no+"' and  (notes like 'clip%' or notes like 'added item%' or notes like 'compmull%' or notes like 'pan%' or notes like 'flashing%' or notes like 'angle%' or notes like 'loose%' or notes like 'insulated blank off%' or notes like 'front 7305 head%' or notes like 'userentered') and not part_quantity='0' order by cast(order_line_no as numeric),part_number,rec_no");
	if(rs2 != null){
		while(rs2.next()){
			descript.addElement(rs2.getString(1));
			qty.addElement(""+rs2.getInt(2));
			mark.addElement(rs2.getString(4));
			line_no.addElement(rs2.getString(5));
			if(rs2.getString(6)!=null){
				shipped.addElement(rs2.getString(6));
			}
			else{
				shipped.addElement("");
			}
			if(rs2.getString(7)!=null){
				sect.addElement(rs2.getString(7));
			}
			else{
				sect.addElement("");
			}
			if(rs2.getString(8)!=null){
				ctn.addElement(rs2.getString(8));
			}
			else{
				ctn.addElement("");
			}
			rec_no.addElement(rs2.getString("rec_no"));
			part_number.addElement(rs2.getString("part_number"));
		}
	}
	rs2.close();
	ResultSet rs3=stmt.executeQuery("select * from cs_l1 where order_number='"+order_no+"' order by cast(order_line_no as numeric)");
	if(rs3 != null){
		while(rs3.next()){
			if(rs3.getString("model") != null){
				model.addElement(rs3.getString("model"));
			}
			else{
				model.addElement("");
			}
			if(rs3.getString("width") != null){
				width.addElement(rs3.getString("width"));
			}
			else{
				width.addElement("");
			}
			if(rs3.getString("height") != null){
				height.addElement(rs3.getString("height"));
			}
			else{
				height.addElement("");
			}
			if(rs3.getString("sections") != null){
				sections.addElement(rs3.getString("sections"));
			}
			else{
				sections.addElement("");
			}
			if(rs3.getString("shape") != null){
				shape_id.addElement(rs3.getString("shape"));
			}
			else{
				shape_id.addElement("");
			}
			if(rs3.getString("cust_po_no") != null){
				custom.addElement(rs3.getString("cust_po_no"));
			}
			else{
				custom.addElement("");
			}
			if(rs3.getString("screen_id")!= null){
				screen.addElement(rs3.getString("screen_id"));
			}
			else{
				screen.addElement("");
			}
			if(rs3.getString("descript") != null){
				l1descript.addElement(rs3.getString("descript"));
			}
			else{
				l1descript.addElement("");
			}
			if(rs3.getString("finish_id") != null){
				finish_id.addElement(rs3.getString("finish_id"));
			}
			else{
				finish_id.addElement("");
			}
			quantity.addElement(rs3.getString("quantity"));
			screen_descript.addElement("");
			finish.addElement("");
			shape.addElement("");
			order_line_no.addElement(rs3.getString("order_line_no"));
			markx.addElement(rs3.getString("mark_#"));
		}
	}
	rs3.close();
	for(int e=0; e<screen.size(); e++){
		ResultSet rs4=stmt.executeQuery("select mid_descript from cs_screen where code='"+screen.elementAt(e).toString()+"'");
		if(rs4 != null){
			while(rs4.next()){
				if(rs4.getString(1) != null){

						screen_descript.setElementAt(rs4.getString(1),e);

					//out.println(rs4.getString(1)+"::<BR>");
				}
			}
		}
		rs4.close();
		//out.println(finish_id.elementAt(e).toString()+"::<BR>");
		ResultSet rs5=stmt.executeQuery("select mid_desc from cs_finish where code='"+finish_id.elementAt(e).toString()+"'");
		if(rs5 != null){
			while(rs5.next()){
				if(rs5.getString(1) != null){
					finish.setElementAt(rs5.getString(1),e);
				}
			}
		}
		rs5.close();
		ResultSet rs6=stmt.executeQuery("SELECT detail_name FROM feature_detail WHERE product_id='LVR' AND block_code='SHAPE' and detail_code='"+shape_id.elementAt(e).toString()+"'");
		if(rs6 != null){
			while(rs6.next()){
				shape.setElementAt(rs6.getString(1),e);
			}
		}
		rs6.close();
		if(width.elementAt(e).toString().endsWith(".01250")){
			String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
			width.setElementAt(tempwidth+"&#8539;",e);
		}
		else if(width.elementAt(e).toString().endsWith(".2500")){
			String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
			width.setElementAt(tempwidth+"&#188;",e);
		}
		else if(width.elementAt(e).toString().endsWith(".3750")){
			String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
			width.setElementAt(tempwidth+"&#8540;",e);
		}
		else if(width.elementAt(e).toString().endsWith(".5000")){
			String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
			width.setElementAt(tempwidth+"&#189;",e);
		}
		else if(width.elementAt(e).toString().endsWith(".6250")){
			String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
			width.setElementAt(tempwidth+"&#8541;",e);
		}
		else if(width.elementAt(e).toString().endsWith(".7500")){
			String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
			width.setElementAt(tempwidth+"&#190;",e);
		}
		else if(width.elementAt(e).toString().endsWith(".8750")){
			String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
			width.setElementAt(tempwidth+"&#8542;",e);
		}
		if(height.elementAt(e).toString().endsWith(".01250")){
			String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
			height.setElementAt(tempheight+"&#8539;",e);
		}
		else if(height.elementAt(e).toString().endsWith(".2500")){
			String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
			height.setElementAt(tempheight+"&#188;",e);
		}
		else if(height.elementAt(e).toString().endsWith(".3750")){
			String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
			height.setElementAt(tempheight+"&#8540;",e);
		}
		else if(height.elementAt(e).toString().endsWith(".5000")){
			String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
			height.setElementAt(tempheight+"&#189;",e);
		}
		else if(height.elementAt(e).toString().endsWith(".6250")){
			String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
			height.setElementAt(tempheight+"&#8541;",e);
		}
		else if(height.elementAt(e).toString().endsWith(".7500")){
			String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
			height.setElementAt(tempheight+"&#190;",e);
		}
		else if(height.elementAt(e).toString().endsWith(".8750")){
			String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
			height.setElementAt(tempheight+"&#8542;",e);
		}
	}
	//header starts here
	if(lastelement != null && !lastelement.equals("null") && lastelement.trim().length()>0){
		out.println("<body onload='setformfocus();'>");
	}
	else{
		out.println("<body >");
	}
	out.println("<form name='editsave' method='post' action='shoppaper_save.jsp'>");
	out.println("<input type='hidden' name='lastelement' value='"+lastelement+"'>");
	out.println("<input type='hidden' name='index1' value='"+index1+"'>");
	out.println("<input type='hidden' name='index2' value='"+index2+"'>");
	out.println("<input type='hidden' name='order_no' value='"+order_no+"'>");
	out.println("<table border='0' width='100%'>");
	out.println("<tr><td width='25%' valign='top'><img src='http://csimages.c-sgroup.com/eRapid/cs_logo.jpg' alt='CS Logo'></td>");
	out.println("<td width='50%' align='center'><B>Construction Specialties, Inc.<BR>3 Werner Way<BR>Lebanon, New Jersey 08833<BR>Customer Service: 888.331.2031 </b></td>");
	out.println("<td width='25%'>PACKING LIST</td>");
	out.println("</table>");
	out.println("<table border='0' width='100%'>");
	out.println("<tr><td colspan='4'><B><font size='3'>"+project_name+"</font></b></td></tr>");
	if(layout_done_by == null || layout_done_by.trim().length()==0){
		layout_done_by="layout done by' class='hint";
	}
	if(name1 == null || name1.trim().length()==0){
		name1="name1' class='hint";
	}
	if( name2== null || name2.trim().length()==0){
		name2="name2' class='hint";
	}
	if( add1== null || add1.trim().length()==0){
		add1="addres1' class='hint";
	}
	if( add2== null || add2.trim().length()==0){
		add2="address2' class='hint";
	}
	if( city== null || city.trim().length()==0){
		city="city' class='hint";
	}
	if( state== null || state.trim().length()==0){
		state="state' class='hint";
	}
	if( zip== null || zip.trim().length()==0){
		zip="zip' class='hint";
	}
	if( bpcs_ord== null || bpcs_ord.trim().length()==0){
		bpcs_ord="bpcs order no' class='hint";
	}
	if( shop_ord== null || shop_ord.trim().length()==0){
		shop_ord="shop order no' class='hint";
	}
	if( cust_po== null || cust_po.trim().length()==0){
		cust_po="customer po' class='hint";
	}
	if( hrs_notice== null || hrs_notice.trim().length()==0){
		hrs_notice="hours notice' class='hint";
	}
	if( shipto_shipdate== null || shipto_shipdate.trim().length()==0){
		shipto_shipdate="ship date' class='hint";
	}
	if( attnname== null || attnname.trim().length()==0){
		attnname="attention name' class='hint";
	}
	if( phone== null || phone.trim().length()==0){
		phone="phone' class='hint";
	}
	if( lastelement== null || lastelement.trim().length()==0){
		lastelement="";
	}
	if( lastelement== null || lastelement.trim().length()==0){
		lastelement="";
	}
	if( lastelement== null || lastelement.trim().length()==0){
		lastelement="";
	}
	%>
	<tr><td align='left' width='15%'>Erapid No:</td>
		<td align='left' width='35%'><%=order_no%></td>
		<td rowspan='5' valign='top' align='Left' width='15%'>Ship To:</td>
		<td rowspan='5' valign='top' align='left' width='35%'>
			<input type='text' style=' background-color: #c0c0c0;width:100px;' name='name1' value='<%=name1%>'  onfocus="if(this.className=='hint'){
			this.className='';
			this.value='';
		}" onblur="lastElement(this.name);
				if(this.value==''){
					this.className='hint';
					this.value='name1';
				}"><BR>
			<input type='text' style=' background-color: #c0c0c0;width:100px;' name='name2' value='<%=name2%>'  onfocus="if(this.className=='hint'){
			this.className='';
			this.value='';
		}" onblur="lastElement(this.name);
				if(this.value==''){
					this.className='hint';
					this.value='name2';
				}"><BR>
			<input type='text' style=' background-color: #c0c0c0;width:100px;' name='add1' value='<%=add1%>'  onfocus="if(this.className=='hint'){
			this.className='';
			this.value='';
		}" onblur="lastElement(this.name);
				if(this.value==''){
					this.className='hint';
					this.value='address1';
				}"><BR>
			<input type='text' style=' background-color: #c0c0c0;width:100px;' name='add2' value='<%=add2%>' onfocus="if(this.className=='hint'){
			this.className='';
			this.value='';
		}" onblur="lastElement(this.name);
				if(this.value==''){
					this.className='hint';
					this.value='address2';
				}"><BR>
			<input type='text' style=' background-color: #c0c0c0;width:100px;' name='city' value='<%=city%>'  onfocus="if(this.className=='hint'){
			this.className='';
			this.value='';
		}" onblur="lastElement(this.name);
				if(this.value==''){
					this.className='hint';
					this.value='city';
				}">,
			<input type='text' style=' background-color: #c0c0c0;width:100px;' name='state' value='<%=state%>'  onfocus="if(this.className=='hint'){
			this.className='';
			this.value='';
		}" onblur="lastElement(this.name);
				if(this.value==''){
					this.className='hint';
					this.value='state';
				}">&nbsp;
			<input type='text' style=' background-color: #c0c0c0;width:100px;' name='zip' value='<%=zip%>' onfocus="if(this.className=='hint'){
			this.className='';
			this.value='';
		}" onblur="lastElement(this.name);
				if(this.value==''){
					this.className='hint';
					this.value='zip';
				}"></td></tr>
	<tr><td align='left'>BPCS No:</td>
		<td align='left'>
			<input type='text' style=' background-color: #c0c0c0;width:100px;' name='bpcs_ord' value='<%=bpcs_ord%>'  onfocus="if(this.className=='hint'){
			this.className='';
			this.value='';
		}" onblur="lastElement(this.name);
				if(this.value==''){
					this.className='hint';
					this.value='bpcs order no';
				}"></td></tr>
	<tr><td align='left'>Shop Order No:</td><td align='left'>
			<input type='text' style=' background-color: #c0c0c0;width:100px;' name='shop_ord' value='<%=shop_ord%>'  onfocus="if(this.className=='hint'){
			this.className='';
			this.value='';
		}" onblur="lastElement(this.name);
				if(this.value==''){
					this.className='hint';
					this.value='shop order no';
				}"></td></tr>
	<tr><td align='left'>Customer Order No:</td><td align='left'>
			<input type='text' style=' background-color: #c0c0c0;width:100px;' name='cust_po' value='<%=cust_po%>' onfocus="if(this.className=='hint'){
			this.className='';
			this.value='';
		}" onblur="lastElement(this.name);
				if(this.value==''){
					this.className='hint';
					this.value='customer po';
				}"></td></tr>
	<tr><td align='left'>&nbsp;</td><td align='left'>&nbsp;</td></tr>
	<tr><td colspan='2'>Ship Date</td><td colspan='2'>
			<input type='text' style=' background-color: #c0c0c0;width:100px;' name='hrs_notice' value='<%=hrs_notice%>'  onfocus="if(this.className=='hint'){
			this.className='';
			this.value='';
		}" onblur="lastElement(this.name);
				if(this.value==''){
					this.className='hint';
					this.value='hours notice';
				}">
			Hours notice required prior to delivery</td></tr>
	<tr><td colspan='2'>
			<input type='text' style=' background-color: #c0c0c0;width:100px;' name='shipto_shipdate' value='<%=shipto_shipdate%>'  onfocus="if(this.className=='hint'){
			this.className='';
			this.value='';
		}" onblur="lastElement(this.name);
				if(this.value==''){
					this.className='hint';
					this.value='ship date';
				}"></td>
		<td colspan='2'>Call
			<input type='text' style=' background-color: #c0c0c0;width:100px;' name='attname' value='<%=attnname%>'  onfocus="if(this.className=='hint'){
			this.className='';
			this.value='';
		}" onblur="lastElement(this.name);
				if(this.value==''){
					this.className='hint';
					this.value='attention name';
				}"> at
			<input type='text' style=' background-color: #c0c0c0;width:100px;' name='phone' value='<%=phone%>' onfocus="if(this.className=='hint'){
			this.className='';
			this.value='';
		}" onblur="lastElement(this.name);
				if(this.value==''){
					this.className='hint';
					this.value='phone number';
				}"></td></tr>
			<%
			out.println("</table>");
			out.println("<hr>");
			//header ends here
			//body starts here
			out.println("<table border='1' width='100%'>");
			out.println("<tr><td colspan='2' align='center'>QUANTITY</td><td colspan='4'>&nbsp;</td></tr>");
			out.println("<tr><td width='5%' align='center'>ORDERED</td><td width='5%' align='center'>PREVIOUSLY SHIPPED</td><td width='5%' align='center'>SHIPPED</td><td width='75%' align='center' colspan='1'>CONTENTS</td><td width='5%' align='center'>(SECT.)</td><td width='5%' align='center'>CARTON NO.</td></tr>");
			for(int t=0; t<model.size(); t++){
				linetemp=order_line_no.elementAt(t).toString();
				if(new Double(order_line_no.elementAt(t).toString()).doubleValue()>new Double(line_max).doubleValue()){
					line_max=order_line_no.elementAt(t).toString();
				}
				String tempModel=markx.elementAt(t).toString()+" "+model.elementAt(t).toString()+"&nbsp;"+width.elementAt(t).toString()+" x "+height.elementAt(t).toString()+"&nbsp;"+sections.elementAt(t).toString()+" Section(s) "+shape.elementAt(t).toString();
				String temp2=finish.elementAt(t).toString()+" "+custom.elementAt(t).toString()+" "+screen_descript.elementAt(t).toString();
				tempModel=tempModel.trim()+"<BR>"+temp2.trim();
				if(l1descript.elementAt(t)!= null & l1descript.elementAt(t).toString().trim().length()>0){
					tempModel=markx.elementAt(t).toString()+" "+l1descript.elementAt(t).toString();
				}
				out.println("<tr>");
				out.println("<td align='center'><b>"+quantity.elementAt(t).toString()+"<b></td>");
				out.println("<td>&nbsp;</td>");
				out.println("<td>&nbsp;</td>");
				out.println("<td colspan='2'><b>"+tempModel+"</b></td>");
				//out.println("<td>&nbsp;</td>");
				out.println("<td>&nbsp;</td>");
				out.println("</tr>");
				int reccounter=0;
				for(int i=0;i<descript.size(); i++){

					if(line_no.elementAt(i).equals(order_line_no.elementAt(t).toString())){
						out.println("<tr>");
						out.println("<input type='hidden' name='rec_no' value='"+rec_no.elementAt(i).toString()+"'>");
						out.println("<input type='hidden' name='line_no' value='"+line_no.elementAt(i).toString()+"'>");
						out.println("<input type='hidden' name='mark' value='"+mark.elementAt(i).toString()+"'>");
						out.println("<td align='center'><input type='text' style=' background-color: #c0c0c0;width:50px;' name='qty' value='"+qty.elementAt(i).toString()+"' onblur='lastElement(this.name,"+t+","+i+");'></td>");
						out.println("<td><input type='text' style=' background-color: #c0c0c0;width:50px;' name='prevshipped' value='"+shipped.elementAt(i).toString()+"' readonly onblur='lastElement(this.name,"+t+","+i+");'></td>");
						out.println("<td><input type='text' style=' background-color: #c0c0c0;width:50px;' name='shipped' value='' onblur='lastElement(this.name,"+t+","+i+");'></td>");
						out.println("<td valign='center'>"+"<input type='text' name='descript' value='"+descript.elementAt(i).toString()+"' style=' background-color: #c0c0c0;width:1000px;height=50px' onblur='lastElement(this.name,"+t+","+i+");'></td>");
						//if(part_number.elementAt(i).toString().equals("99-99-999")){
						//	out.println("<td width='10%' align='right'>&nbsp;</td>");
						//}
						//else{
						//	out.println("<td width='10%' align='right'>"+part_number.elementAt(i).toString()+"</td>");
						//}
						out.println("<input type='hidden' name='part_number' value='"+part_number+"'>");
						out.println("<td><input type='text' style=' background-color: #c0c0c0;width:50px;' name='sect' value='"+sect.elementAt(i).toString()+"' onblur='lastElement(this.name,"+t+","+i+");'></td>");
						out.println("<td><input type='text' style=' background-color: #c0c0c0;width:50px;' name='ctn' value='"+ctn.elementAt(i).toString()+"' onblur='lastElement(this.name,"+t+","+i+");'></td>");
						out.println("</tr>");
						reccounter++;
					}

				}

				reccounter++;
				out.println("<tr>");
				out.println("<input type='hidden' name='rec_no' value='"+reccounter+"'>");
				out.println("<input type='hidden' name='line_no' value='"+linetemp+"'>");

				out.println("<input type='hidden' name='part_number' value=''>");
				String newx="new";
			%>
	<input type='hidden' name='mark' value='<%=markx.elementAt(t).toString()%>'>
	<td align='center'><input type='text' style=' background-color: #0099FF;width:50px;' name='qty' id='"<%=t%>' class='hint' value='QTY' onfocus="if(this.className=='hint'){
				this.className='';
				this.value='';
			}" onblur="lastElement(this.name,'<%=t%>','new');
					if(this.value==''){
						this.className='hint';
						this.value='QTY';
					}"></td>
	<td><input type='text' style=' background-color: #0099FF;width:50px;' name='prevshipped' class='hint' value='PREV SHIPPED' onfocus="if(this.className=='hint'){
				this.className='';
				this.value='';
			}" onblur="lastElement(this.name,'<%=t%>','new');
					if(this.value==''){
						this.className='hint';
						this.value='PREV SHIPPED';
					}"></td>
	<td><input type='text' style=' background-color: #0099FF;width:50px;' name='shipped' class='hint' value='SHIPPED' onfocus="if(this.className=='hint'){
				this.className='';
				this.value='';
			}" onblur="lastElement(this.name,'<%=t%>','new');
					if(this.value==''){
						this.className='hint';
						this.value='SHIPPED';
					}"></td>
	<td valign='center'><%=markx.elementAt(t).toString()%>
		<input type='text' name='descript' value='DESCRIPTION TO ADD TO LINE ABOVE'  class='hint' onfocus="if(this.className=='hint'){
				this.className='';
				this.value='';
			}" onblur="lastElement(this.name,'<%=t%>','new');
					if(this.value==''){
						this.className='hint';
						this.value='DESCRIPTION TO ADD TO LINE ABOVE';
					}" style=' background-color: #0099FF;width:1000px;height=50px'></td>
	<input type='text' name='<%=t%>' value='<%=t%>' style=' width:1px;height=1px'>
	<td><input type='text' style=' background-color: #0099FF;width:50px;' name='sect' class='hint' value='SECTION' onfocus="if(this.className=='hint'){
				this.className='';
				this.value='';
			}" onblur="lastElement(this.name,'<%=t%>','new');
					if(this.value==''){
						this.className='hint';
						this.value='SECTION';
					}"></td>
	<td><input type='text' style=' background-color: #0099FF;width:50px;' name='ctn' class='hint' value='CTN' onfocus="if(this.className=='hint'){
				this.className='';
				this.value='';
			}" onblur="lastElement(this.name,'<%=t%>','new');
					if(this.value==''){
						this.className='hint';
						this.value='CTN';
					}"></td>
		<%
		out.println("</tr>");

	}
	out.println("<tr>");
	out.println("<td>&nbsp;</td>");
	out.println("<td>&nbsp;</td>");
	out.println("<td>&nbsp;</td>");
	out.println("<td>&nbsp;</td>");
	out.println("<td>&nbsp;</td>");
	//out.println("<td>&nbsp;</td>");
	out.println("<td>&nbsp;</td>");
	out.println("</tr>");
	out.println("<tr>");
	out.println("<input type='hidden' name='line_no_new' value='"+(Integer.parseInt(line_max)+1)+"'>");
		%>
	<td align='center'><input type='text' style=' background-color: #3300FF;width:50px;color:FFFFFF; ' name='qtynew' class='hint' value='QTY' onfocus="if(this.className=='hint'){
			this.className='';
			this.value='';
		}" onblur="lastElement(this.name);
				if(this.value==''){
					this.className='hint';
					this.value='QTY';
				}"></td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
	<td valign='center'><input type='text' style=' background-color: #3300FF;width:50px;color:FFFFFF;' class='hint' name='marknew' value='MARK' onfocus="if(this.className=='hint'){
			this.className='';
			this.value='';
		}" onblur="lastElement(this.name);
				if(this.value==''){
					this.className='hint';
					this.value='MARK';
				}">
		<input type='text' name='descriptnew' value='DESCRIPTION FOR NEW LINE ITEM'  class='hint' onfocus="if(this.className=='hint'){
			this.className='';
			this.value='';
		}" onblur="lastElement(this.name);
				if(this.value==''){
					this.className='hint';
					this.value='DESCRIPTION FOR NEW LINE';
				}" style=' background-color: #3300FF;width:1000px;height=50px;color:FFFFFF;'></td>
	<td>&nbsp;</td>
	<!--<td>&nbsp;</td>-->
	<td>&nbsp;</td>
	<%
	out.println("</tr>");
	out.println("<tr><td colspan='6' align='center'><input type='submit' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='save' value='SAVE' >");
	out.println("<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='Packing List' value='Packing List' onclick=javascript:document.location.href='shoppaper_main.jsp?order_no="+order_no+"'>");
	out.println("<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='Close' value='Close' onclick='javascript:window.close();'>");
	//out.println("<input type='button' class='button6' onmouseover=this.className='button7' onmouseout=this.className='button6' name='active' value='active' onclick='javascript:alert(document.activeElement.name);'>");
	out.println("</table>");
	out.println("<BR><BR><BR><BR><BR>");
	//body ends here
	//footer starts here
	out.println("<hr>");
	out.println("<table border='0' width='100%'><tr><td width='10%' align='right'>"+date+"</td><td align='center' width='80%'>Layout by ");
	%>




	<input type='text' style=' background-color: #c0c0c0;width:100px;' name='layout_done_by' value='<%=layout_done_by%>' onfocus="if(this.className=='hint'){
			this.className='';
			this.value='';
		}" onblur="lastElement(this.name);
				if(this.value==''){
					this.className='hint';
					this.value='layout done by';
				}">

	<%





	//+layout_done_by+
	out.println("</center></td><td width='10%'>&nbsp;</td></tr>");
	//footer ends here
	out.println("</form>");
	stmt.close();
	myConn.close();
	}
	catch(Exception e){
	out.println(e);
	}

	%>
</body>
</html>