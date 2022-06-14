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
<link rel='stylesheet' href='../../quotes/style1.css' type='text/css'/>
<html>



	<body>
		<%
		String order_no=request.getParameter("order_no");
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
		Vector line_no=new Vector();
		Vector descript=new Vector();
		Vector qty=new Vector();
		Vector mark=new Vector();
		Vector model=new Vector();
		Vector width=new Vector();
		Vector height=new Vector();
		Vector sections=new Vector();
		Vector shape_id=new Vector();
		Vector shape=new Vector();
		Vector custom=new Vector();
		Vector screen=new Vector();
		Vector quantity=new Vector();
		Vector screen_descript=new Vector();
		Vector order_line_no=new Vector();
		Vector l1descript=new Vector();
		Vector markx=new Vector();
		Vector part_number=new Vector();
		Vector finish_id=new Vector();
		Vector clips_finish=new Vector();
		Vector finish=new Vector();
		Vector shipped=new Vector();
		Vector sect=new Vector();
		Vector ctn=new Vector();
		Vector notes=new Vector();
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
		ResultSet rs2=stmt.executeQuery("select description,part_quantity,notes,mark_#,order_line_no,part_number,shipped,sect,ctn,notes,gaugeforshear from cs_l5 where order_number='"+order_no+"' and  (notes like 'clip%' or notes like 'added item%' or notes like 'compmull%' or notes like 'pan%' or notes like 'flashing%' or notes like 'angle%' or notes like 'loose%' or notes like 'insulated blank off%' or notes like 'front 7305 head%' or notes like 'userentered') and not part_quantity='0' order by cast(order_line_no as numeric),part_number,rec_no");
		if(rs2 != null){
			while(rs2.next()){
				String tempdescript=rs2.getString(1);
				//out.println(rs2.getString("notes")+"::<BR>");
				if(rs2.getString("notes").trim().equals("Pan")){
					tempdescript=rs2.getString("gaugeforshear")+" SILL PAN @ ";
					String templength=rs2.getString(1);
					templength=templength.substring(templength.indexOf(" "),templength.indexOf("\""));
					tempdescript=tempdescript+templength+" LG";
				}











				//out.println(tempdescript+"::<BR>");
				tempdescript=tempdescript.replaceAll(".0625","<sup>1</sup>&frasl;<sub>16</sub>");
				tempdescript=tempdescript.replaceAll(".1250","&#8539;"	);
				tempdescript=tempdescript.replaceAll(".1875","<sup>3</sup>&frasl;<sub>16</sub>"	);
				tempdescript=tempdescript.replaceAll(".2500","&#188;");
				tempdescript=tempdescript.replaceAll(".3125","<sup>5</sup>&frasl;<sub>16</sub>"	);
				tempdescript=tempdescript.replaceAll(".3750","&#8540;");
				tempdescript=tempdescript.replaceAll(".4375","<sup>7</sup>&frasl;<sub>16</sub>"	);
				tempdescript=tempdescript.replaceAll(".5000","&#189;");
				tempdescript=tempdescript.replaceAll(".5625","<sup>9</sup>&frasl;<sub>16</sub>"	);
				tempdescript=tempdescript.replaceAll(".6250","&#8541;");
				tempdescript=tempdescript.replaceAll(".6875","<sup>11</sup>&frasl;<sub>16</sub>");
				tempdescript=tempdescript.replaceAll(".7500","&#190;");
				tempdescript=tempdescript.replaceAll(".8125","<sup>13</sup>&frasl;<sub>16</sub>");
				tempdescript=tempdescript.replaceAll(".8750","&#8542;");
				tempdescript=tempdescript.replaceAll(".9375","<sup>15</sup>&frasl;<sub>16</sub>");
				//out.println(tempdescript+"::<BR>");
				tempdescript=tempdescript.replaceAll(".125","&#8539;"	);
				tempdescript=tempdescript.replaceAll(".375","&#8540;");
				tempdescript=tempdescript.replaceAll(".500","&#189;");
				tempdescript=tempdescript.replaceAll(".625","&#8541;");
				tempdescript=tempdescript.replaceAll(".750","&#190;");
				tempdescript=tempdescript.replaceAll(".875","&#8542;");
				/*
				tempdescript=tempdescript.replaceAll(".25","&#188;");
				tempdescript=tempdescript.replaceAll(".50","&#189;");
				tempdescript=tempdescript.replaceAll(".75","&#190;");
				tempdescript=tempdescript.replaceAll(".5","&#189;");
				*/
			//	out.println(tempdescript+"::<BR>");
				descript.addElement(tempdescript);
				//out.println(rs2.getString(1)+"::<br>");
				qty.addElement(""+rs2.getInt(2));
				mark.addElement(rs2.getString(4));
				line_no.addElement(rs2.getString(5));
				part_number.addElement(rs2.getString(6));
				if(rs2.getString(7) != null){
					shipped.addElement(rs2.getString(7));
				}
				else{
					shipped.addElement("");
				}
				if(rs2.getString(8) != null){
					sect.addElement(rs2.getString(8));
				}
				else{
					sect.addElement("");
				}
				if(rs2.getString(9) != null){
					ctn.addElement(rs2.getString(9));
				}
				else{
					ctn.addElement("");
				}
				if(rs2.getString("notes") != null){
					notes.addElement(rs2.getString("notes"));
				}
				else{
					notes.addElement("");
				}
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
				if(rs3.getString("clips_finish") != null){
					clips_finish.addElement(rs3.getString("clips_finish"));
				}
				else{
					clips_finish.addElement("");
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
			//out.println(screen.elementAt(e).toString()+"::<BR>");
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
			if(width.elementAt(e).toString().endsWith(".0625")){
				String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
				width.setElementAt(tempwidth+"<sup>1</sup>&frasl;<sub>16</sub>&quot;",e);
			}
			if(width.elementAt(e).toString().endsWith(".01250")){
				String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
				width.setElementAt(tempwidth+"&#8539;&quot;",e);
			}
			else if(width.elementAt(e).toString().endsWith(".1875")){
				String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
				width.setElementAt(tempwidth+"<sup>3</sup>&frasl;<sub>16</sub>&quot;",e);
			}
			else if(width.elementAt(e).toString().endsWith(".2500")){
				String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
				width.setElementAt(tempwidth+"&#188;&quot;",e);
			}
			else if(width.elementAt(e).toString().endsWith(".3125")){
				String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
				width.setElementAt(tempwidth+"<sup>5</sup>&frasl;<sub>16</sub>&quot;",e);
			}
			else if(width.elementAt(e).toString().endsWith(".3750")){
				String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
				width.setElementAt(tempwidth+"&#8540;&quot;",e);
			}
			else if(width.elementAt(e).toString().endsWith(".4375")){
				String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
				width.setElementAt(tempwidth+"<sup>7</sup>&frasl;<sub>16</sub>&quot;",e);
			}
			else if(width.elementAt(e).toString().endsWith(".5000")){
				String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
				width.setElementAt(tempwidth+"&#189;&quot;",e);
			}
			else if(width.elementAt(e).toString().endsWith(".5625")){
				String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
				width.setElementAt(tempwidth+"<sup>9</sup>&frasl;<sub>16</sub>&quot;",e);
			}
			else if(width.elementAt(e).toString().endsWith(".6250")){
				String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
				width.setElementAt(tempwidth+"&#8541;&quot;",e);
			}
			else if(width.elementAt(e).toString().endsWith(".6875")){
				String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
				width.setElementAt(tempwidth+"<sup>11</sup>&frasl;<sub>16</sub>&quot;",e);
			}
			else if(width.elementAt(e).toString().endsWith(".7500")){
				String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
				width.setElementAt(tempwidth+"&#190;&quot;",e);
			}
			else if(width.elementAt(e).toString().endsWith(".8125")){
				String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
				width.setElementAt(tempwidth+"<sup>13</sup>&frasl;<sub>16</sub>&quot;",e);
			}
			else if(width.elementAt(e).toString().endsWith(".8750")){
				String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
				width.setElementAt(tempwidth+"&#8542;&quot;",e);
			}
			else if(width.elementAt(e).toString().endsWith(".9375")){
				String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
				width.setElementAt(tempwidth+"<sup>15</sup>&frasl;<sub>16</sub>&quot;",e);
			}
			else if(width.elementAt(e).toString().endsWith(".0000")){
				String tempwidth=width.elementAt(e).toString().substring(0,width.elementAt(e).toString().indexOf("."));
				width.setElementAt(tempwidth+"&quot;",e);
			}
			if(height.elementAt(e).toString().endsWith(".0625")){
				String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
				height.setElementAt(tempheight+"<sup>1</sup>&frasl;<sub>16</sub>&quot;",e);
			}
			if(height.elementAt(e).toString().endsWith(".01250")){
				String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
				height.setElementAt(tempheight+"&#8539;&quot;",e);
			}
			else if(height.elementAt(e).toString().endsWith(".1875")){
				String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
				height.setElementAt(tempheight+"<sup>3</sup>&frasl;<sub>16</sub>&quot;",e);
			}
			else if(height.elementAt(e).toString().endsWith(".2500")){
				String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
				height.setElementAt(tempheight+"&#188;&quot;",e);
			}
			else if(height.elementAt(e).toString().endsWith(".3125")){
				String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
				height.setElementAt(tempheight+"<sup>5</sup>&frasl;<sub>16</sub>&quot;",e);
			}
			else if(height.elementAt(e).toString().endsWith(".3750")){
				String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
				height.setElementAt(tempheight+"&#8540;&quot;",e);
			}
			else if(height.elementAt(e).toString().endsWith(".4375")){
				String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
				height.setElementAt(tempheight+"<sup>7</sup>&frasl;<sub>16</sub>&quot;",e);
			}
			else if(height.elementAt(e).toString().endsWith(".5000")){
				String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
				height.setElementAt(tempheight+"&#189;&quot;",e);
			}
			else if(height.elementAt(e).toString().endsWith(".5625")){
				String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
				height.setElementAt(tempheight+"<sup>9</sup>&frasl;<sub>16</sub>&quot;",e);
			}
			else if(height.elementAt(e).toString().endsWith(".6250")){
				String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
				height.setElementAt(tempheight+"&#8541;&quot;",e);
			}
			else if(height.elementAt(e).toString().endsWith(".6875")){
				String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
				height.setElementAt(tempheight+"<sup>11</sup>&frasl;<sub>16</sub>&quot;",e);
			}
			else if(height.elementAt(e).toString().endsWith(".7500")){
				String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
				height.setElementAt(tempheight+"&#190;&quot;",e);
			}
			else if(height.elementAt(e).toString().endsWith(".8125")){
				String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
				height.setElementAt(tempheight+"<sup>13</sup>&frasl;<sub>16</sub>&quot;",e);
			}
			else if(height.elementAt(e).toString().endsWith(".8750")){
				String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
				height.setElementAt(tempheight+"&#8542;&quot;",e);
			}
			else if(height.elementAt(e).toString().endsWith(".9375")){
				String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
				height.setElementAt(tempheight+"<sup>15</sup>&frasl;<sub>16</sub>&quot;",e);
			}
			else if(height.elementAt(e).toString().endsWith(".0000")){
				String tempheight=height.elementAt(e).toString().substring(0,height.elementAt(e).toString().indexOf("."));
				height.setElementAt(tempheight+"&quot;",e);
			}
		}
		String touchup_paint="";
		Vector s1=new Vector();
		ResultSet rs7=stmt.executeQuery("select distinct finish_id from cs_l1 where order_number='"+order_no+"' order by finish_id");
		if(rs7 != null){
			while(rs7.next()){
				if(rs7.getString(1) != null && rs7.getString(1).trim().length()>0){
					String touchuptemp="";
					if(!rs7.getString(1).equals("ML000")){
						s1.addElement(rs7.getString(1));
					}
				}
			}
		}
		rs7.close();

		for(int g=0; g<s1.size(); g++){
			String touchuptemp="";
			//out.println(s1.elementAt(g).toString()+"::<BR>");
			if(s1.elementAt(g).toString().equals("KY599")){
				//out.println("1");
				ResultSet rs9=stmt.executeQuery("select distinct cust_po_no from cs_l1 where order_number ='"+order_no+"' and finish_id='KY599'");
				if(rs9 != null){
					while(rs9.next()){
						touchuptemp="KY599 "+rs9.getString(1)+" Touch up Paint";
						touchup_paint=touchup_paint+"<tr><td align='center'>1</td><td>&nbsp;</td><td>"+touchuptemp+"</td><td>&nbsp;</td><td>&nbsp;</td></tr>";
					}
				}
				rs9.close();
				touchuptemp="KY599 "+"::"+" Touch up Paint";

			}


			else{


				ResultSet rs8=stmt.executeQuery("select mid_desc from cs_finish where code='"+s1.elementAt(g).toString()+"'");
				if(rs8 != null){
					while(rs8.next()){
						touchuptemp=rs8.getString(1)+" Touch up Paint";
						touchup_paint=touchup_paint+"<tr><td align='center'>1</td><td>&nbsp;</td><td>"+touchuptemp+"</td><td>&nbsp;</td><td>&nbsp;</td></tr>";
					}
				}
				rs8.close();
			}


		}

		if(name1 != null && name1.trim().length()>0){
			name1=name1+"<BR>";
		}
		if(name2 != null && name2.trim().length()>0){
			name2=name2+"<BR>";
		}
		if(add1 != null && add1.trim().length()>0){
			add1=add1+"<BR>";
		}
		if(add2 != null && add2.trim().length()>0){
			add2=add2+"<BR>";
		}
		//header starts here
		out.println("<!-- header -->");
		out.println("<table border='0' width='100%' >");
		out.println("<tr><td width='25%' valign='top'><img src='http://csimages.c-sgroup.com/eRapid/cs_logo.jpg' alt='CS Logo' width='200px'</td>");
		out.println("<td width='50%' align='center'><B>Construction Specialties, Inc.<BR>3 Werner Way<BR>Lebanon, New Jersey 08833<BR>Customer Service: 888.331.2031 </b></td>");
		out.println("<td width='25%'>PACKING LIST</td>");
		out.println("</table>");
		out.println("<table border='0' width='100%'>");
		out.println("<tr><td colspan='4'><B><font size='3'>"+project_name+"</font></b></td></tr>");
		out.println("<tr><td align='left' width='25%'>eRapid No:<BR>BPCS No:<br>Shop Order No:<BR>Customer Order No:</td><td align='left' width='25%'>"+order_no+"<BR>"+bpcs_ord+"<BR>"+shop_ord+"<BR>"+cust_po+"</td><td  valign='top' align='Left' width='15%'>Ship To:</td><td valign='top' align='left' width='35%'>"+name1+name2+add1+add2+city+","+state+"&nbsp;"+zip+"</td></tr>");
		out.println("<tr><td align='left' colspan='2'>&nbsp;</td><td align='left' colspan='2'>&nbsp;</td></tr>");
		out.println("<tr><td colspan='2'>Ship Date</td><td colspan='2'>"+hrs_notice+" Hours notice required prior to delivery</td></tr>");
		out.println("<tr><td colspan='2'>"+shipto_shipdate+"</td><td colspan='2'>Call "+attnname+" at "+phone+"</td></tr>");

		out.println("</table><Br>");
		out.println("<!-- end header -->");
		//out.println("<hr>");
		//header ends here
		//body starts here
		out.println("<table  border=1 cellpadding=0 bordercolor='#000000' cellspacing=-1 style='{border-collapse:collapse;}' width='100%' >");
		out.println("<tr><td colspan='2' align='center' width='20%' >QUANTITY</td><td colspan='4' width='80%'>&nbsp;</td></tr>");
		out.println("<tr><td width='10%' align='center'>ORDERED</td><td width='10%' align='center'>SHIPPED</td><td colspan='2' width='60%' align='center'>CONTENTS</td><td width='10%' align='center'>CARTON NO.</td></tr>");

		for(int t=0; t<model.size(); t++){

			String tempModel=markx.elementAt(t).toString()+" "+model.elementAt(t).toString()+"&nbsp;"+width.elementAt(t).toString()+" x "+height.elementAt(t).toString()+"&nbsp;"+sections.elementAt(t).toString()+" Section(s) "+shape.elementAt(t).toString();

			String temp2=finish.elementAt(t).toString()+" "+custom.elementAt(t).toString()+" "+screen_descript.elementAt(t).toString();

			tempModel=tempModel.trim()+"<BR>"+temp2.trim();

			if(l1descript.elementAt(t)!= null & l1descript.elementAt(t).toString().trim().length()>0){
				tempModel=markx.elementAt(t).toString()+" "+l1descript.elementAt(t).toString();
			}

			out.println("<tr>");
			out.println("<td align='center'><b>"+quantity.elementAt(t).toString()+"<b></td>");
			out.println("<td>&nbsp;</td>");
			out.println("<td colspan='2'><b>"+tempModel+"</b></td>");
			//out.println("<td>&nbsp;</td>");
			out.println("<td>&nbsp;</td>");
			out.println("</tr>");
			for(int i=0;i<descript.size(); i++){
				if(line_no.elementAt(i).equals(order_line_no.elementAt(t).toString())){
					if(!(notes.elementAt(i).toString().toLowerCase().startsWith("clip") || (notes.elementAt(i).toString().toLowerCase().startsWith("loose")&&!notes.elementAt(i).toString().toLowerCase().startsWith("loose blade")))||(notes.elementAt(i).toString().toLowerCase().startsWith("clip") || notes.elementAt(i).toString().toLowerCase().startsWith("loose"))&&!(clips_finish.elementAt(t).toString().toUpperCase().equals("ML000")||clips_finish.elementAt(t).toString().trim().length()==0)){
						out.println("<tr>");
						out.println("<td align='center' width='10%'>"+qty.elementAt(i).toString()+"</td>");
						out.println("<td width='10%'>"+shipped.elementAt(i).toString()+"&nbsp;</td>");
						out.println("<td width='50%' colspan='2'>"+descript.elementAt(i).toString()+"</td>");
						//if(part_number.elementAt(i).toString().equals("99-99-999")){
						//	out.println("<td width='10%' align='right'>&nbsp;</td>");
						//}
						//else{
						//	out.println("<td width='10%' align='right'>"+part_number.elementAt(i).toString()+"</td>");
						//}
						//out.println("<td width='10%'>"+sect.elementAt(i).toString()+"&nbsp;</td>");
						out.println("<td width='10%'>"+ctn.elementAt(i).toString()+"&nbsp;</td>");
						out.println("</tr>");
					}
				}
			}

			if(clips_finish.elementAt(t).toString().toUpperCase().equals("ML000")||clips_finish.elementAt(t).toString().trim().length()==0){
				String clips="";
				for(int i=0;i<descript.size(); i++){
					if(line_no.elementAt(i).equals(order_line_no.elementAt(t).toString())){
						//out.println(notes.elementAt(i).toString()+"::"+clips_finish.elementAt(t).toString()+"::<BR>");
						if((notes.elementAt(i).toString().toLowerCase().startsWith("clip") || (notes.elementAt(i).toString().toLowerCase().startsWith("loose")&&!notes.elementAt(i).toString().toLowerCase().startsWith("loose blade")) )&&(clips_finish.elementAt(t).toString().toUpperCase().equals("ML000")||clips_finish.elementAt(t).toString().trim().length()==0)){
							clips=clips+"<tr>";
							clips=clips+"<td align='center' width='10%'>"+qty.elementAt(i).toString()+"</td>";
							clips=clips+"<td width='10%'>"+shipped.elementAt(i).toString()+"&nbsp;</td>";
							clips=clips+"<td width='50%' colspan='2'>"+" "+descript.elementAt(i).toString()+"</td>";
							//if(part_number.elementAt(i).toString().equals("99-99-999")){
							//	clips=clips+"<td width='10%' align='right'>&nbsp;</td>";
							//}
							//else{
							//	clips=clips+"<td width='10%' align='right'>"+part_number.elementAt(i).toString()+"</td>";
							//}
							//clips=clips+"<td width='10%'>"+sect.elementAt(i).toString()+"&nbsp;</td>";
							clips=clips+"<td width='10%'>"+ctn.elementAt(i).toString()+"&nbsp;</td>";
							clips=clips+"</tr>";
						}
					}
				}
				if(clips.trim().length()>0){
					out.println("<tr>");
					out.println("<td>&nbsp;</td>");
					out.println("<td>&nbsp;</td>");
					out.println("<td align='center' colspan='2'><B>MILL FINISH</b></td>");
					out.println("<td >&nbsp;</td>");
					//out.println("<td>&nbsp;</td>");
					//out.println("<td>&nbsp;</td>");
					out.println("</tr>");
					out.println(clips);
				}
			}

			out.println("<tr>");
			out.println("<td>&nbsp;</td>");
			out.println("<td>&nbsp;</td>");
			out.println("<td colspan='2'>&nbsp;</td>");
			//out.println("<td>&nbsp;</td>");
			//out.println("<td>&nbsp;</td>");
			out.println("<td>&nbsp;</td>");
			out.println("</tr>");

		}
		out.println(touchup_paint);

		out.println("</table>");
		out.println("<BR><BR><BR><BR><BR>");
		//body ends here
		//footer starts here
		//out.println("<hr>");
		out.println("<table border='0' width='100%'><tr><td width='10%' align='right'>"+date+"</td><td align='center' width='80%'>Layout by "+layout_done_by+"</td><td width='10%'>&nbsp;</td></tr></table>");
		//footer ends here
}
catch(Exception e){
out.println(e);
}
		%>

	</body>
</html>
