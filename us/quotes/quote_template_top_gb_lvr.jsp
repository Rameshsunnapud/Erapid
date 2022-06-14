<div class="Title"><label>QUOTE TYPE<label><hr></div>

<table  width='100%' cellspacing='0' cellpadding='0' border='0'>
	<tr>
		<td class='data'>
			
				<%
					 if(type.equals("1")|type.equals("2")){
						out.println("This quotation is based on furnishing the types, quantities, and sizes listed herein. If quantities or types deviate from those listed, price is subject to increase or decrease proportionately.<b> All Purchase Orders must be made out to ");
						if ( (doc_priority.equals("E")) ){
							out.println("Construction Specialties, Inc. without exception. </b>");
						}
						else{
							out.println("Construction Specialties, Inc. without exception. </b>");
						}
						if(!(isInternational)) {
							out.println("Please sign below & forward to CS Representative, name & address as listed in the quotation header above.");
						}
					 }
					 else{
						out.println(" All as per plans and specifications, including any addenda referenced below, except that the following terms, conditions, and product descriptions shall apply.");
					 }
				%>
			
		</td>
	</tr>
</tr>

</table>
<!--
<br>
<table  width='100%' cellspacing='0' cellpadding='0' border='0'>
	<tr>
		<td class='data'>
			<%
				if( (section != null || division != null) &&((section.trim()).length()>0)|((division.trim()).length()>0) )  {
					if(section_desc != null){
						if((section_desc.trim()).length()>0){
							out.println("	<tr><td width='30%' class='mainbodyh'><b>Division:</b> "+ division +"</td>	");
							out.println("	<td width='30%' class='mainbodyh'><b>Section:</b> "+ section +"</td>");
							out.println("<td width='40%' class='mainbodyh'>"+section_desc+"</td>");
						}
						else{
							out.println("	<tr><td width='30%' class='mainbodyh'><b>Division:</b> "+ division +"</td>	");
							out.println("	<td width='30%' class='mainbodyh'><b>Section:</b> "+ section +"</td>");
							out.println("<td width='40%' class='mainbodyh'>&nbsp;</td>");
						}
					}
					else{
						out.println("	<tr><td width='30%' class='mainbodyh'><b>Division:</b> "+ division +"</td>	");
						out.println("	<td width='30%' class='mainbodyh'><b>Section:</b> "+ section +"</td>");
						out.println("<td width='40%' class='mainbodyh'>&nbsp;</td>");
					}																	
				}
			%>
		</td>
	<tr>
<br>
-->