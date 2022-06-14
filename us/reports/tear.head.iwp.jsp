<table width='100%' border='0' cellpadding='0' cellspacing='0' class='test1'>
	<tr><td>
			<table  width='100%' border='0' cellpadding='0' cellspacing='0'>
				<tr>
					<td colspan='4' align='center' style='border-left: 1px solid;border-right: 1px solid;border-top: 1px solid;border-bottom: 1px solid;'><%= description_group.elementAt(m) %></td>
					<td  align='center' width='3%' style='border-right: 1px solid;border-top: 1px solid;border-bottom: 1px solid;'>NO.</td>
					<td  align='center' width='11%' style='border-right: 1px solid;border-top: 1px solid;border-bottom: 1px solid;'>REV./F&amp;F REL.</td>
					<td  align='center' width='5%' style='border-right: 1px solid;border-top: 1px solid;border-bottom: 1px solid;'>DATE</td>
					<td  align='center' width='3%' style='border-right: 1px solid;border-top: 1px solid;border-bottom: 1px solid;'>BY</td>
				</tr>
				<tr>

		<!--<td class='boxl'>INSERT STYLE:<%= ins_style_group.elementAt(m) %></td>-->
		<!--<td class='box'>INSERT COLOR: <%= ins_col_group.elementAt(m) %></td>-->
		<!--<td class='box'>CATALOG NUMBER: <%= cat_no_group.elementAt(m) %></td>-->
					<td  colspan='4' style='border-left: 1px solid;border-right: 1px solid;border-bottom: 1px solid;'>PART NUMBER: <%= part_no_group.elementAt(m) %></td>
					<td  align='center' width='3%' style='border-right: 1px solid;border-bottom: 1px solid;'>&nbsp;</td>
					<td  align='center' width='11%' style='border-right: 1px solid;border-bottom: 1px solid;'>&nbsp;</td>
					<td  align='center' width='5%' style='border-right: 1px solid;border-bottom: 1px solid;'>&nbsp;</td>
					<td  align='center' width='3%' style='border-right: 1px solid;border-bottom: 1px solid;'>&nbsp;</td>
				</tr>
			</table>
		</td></tr>
	<tr><td align='left' width='90%'>
			<!-- Dummy Table header with a column added donot why logia is creatig-->
			<table  width='100%' border='0' cellpadding='0' cellspacing='0'><tr><td style='border-left: 1px solid;border-right: 1px solid;'>
						<!-- Dummy Table header done-->
						<!--<img src='config15.jpg' width='910' height='515' border='0' alt=''>-->
						<%
						//out.println("The image starting");
URL yahoo = new URL(erapidBean.getCpqServerName()+"/cse/web/jsp/custom_interface/print_interface.jsp?environment=Development&username="+name+"&doc_number="+order_no+"&doc_line="+item_no.elementAt(n)+"&doc_revision=1&doc_type="+doc_type);
BufferedReader in = new BufferedReader(	new InputStreamReader(yahoo.openStream()));
	String inputLine;
	String totalLine="";
	while ((inputLine = in.readLine()) != null){
		totalLine=totalLine+inputLine;
	}
	totalLine=totalLine.replaceFirst("<img ","<img width='930' height='550' ");
	String imageString="";
	imageString=totalLine.substring(totalLine.indexOf("<img"));
	imageString=imageString.substring(0,imageString.indexOf(">")+1);
	out.println(imageString);
	//out.println(totalLine);
in.close();
						/*
						URL yahoo = new URL("http://"+ application.getInitParameter("HOST")+"/cse/web/jsp/custom_interface/print_interface.jsp?environment=Development&username="+name+"&doc_number="+order_no+"&doc_line="+item_no.elementAt(n)+"&doc_revision=1&doc_type="+doc_type);
						//"/elo/elogiaoe?cmd=CI&action=PRINT&uid="+name+"&order_no="+order_no+"&item_no="+item_no.elementAt(n)+" ");
						BufferedReader in = new BufferedReader(	new InputStreamReader(yahoo.openStream()));
							String inputLine;
							while ((inputLine = in.readLine()) != null)
						out.println(inputLine);
						in.close();
						//out.println("The image done");
						*/
						%>
					</td></tr>

