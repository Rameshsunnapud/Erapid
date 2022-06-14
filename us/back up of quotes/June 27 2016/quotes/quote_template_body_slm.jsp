<%
	out.println("<table width='100%'>");
	out.println("<tr><td  class='maindesc'><b><u>DESCRIPTION</b></u></td><td  class='maindesc'><b><u>QTY</b></u></td><td  class='maindesc'><b><u>PRICE</b></u></td></tr>");
	ResultSet rsSlm=stmt.executeQuery("select descript,qty,extended_price from csquotes where order_no='"+order_no+"' and not block_id='a_aproduct' order by line_no, block_id");
	if(rsSlm != null){
		while(rsSlm.next()){
			out.println("<tr>");
			for(int i=1; i<4; i++){
				out.println("<td  class='maindesc'>"+rsSlm.getString(i)+"</td>");
			}
			out.println("</tr>");
		}
	}
	rsSlm.close();
	out.println("</table>");
%>