<%@ page import="com.sun.jersey.api.client.*" %>
<%@ page import="org.csgroup.optimizer.polland.Optimizer.*" %>
<%@ page import="java.util.*" %>

<%
         System.out.println("WE ARE STARTING****************"); 


	String ordeNo=request.getParameter("orderNo");
		
	    String myCanvas="";
		String myTd1="";
		String myTd2="";
		int iterator=1;
		System.out.println("Before Client");
		Client client = Client.create();
		System.out.println("After Client "+ordeNo);
		WebResource webResource = client
				   .resource("http://lebhq-opt:8080/Optimizer/optapi/optimizer?orderNo="+ordeNo+"&get_emp_details=get+layouts");
				   ClientResponse jsonResponse = webResource.accept("application/json")
                .get(ClientResponse.class);
				   System.out.println("After Client Response");
				if (jsonResponse.getStatus() != 200) {
			    throw new RuntimeException("Failed : HTTP error code : "
				+ jsonResponse.getStatus());
			   }
		RepositorySheets sheets = jsonResponse.getEntity(RepositorySheets.class);
		List<Rep> repList=	sheets.getRep();	
		List<Cutpiece> cutPieceList=sheets.getCutpieces();
		List<Sheet> sheetsList=sheets.getSheets();
		int it=0;
				
				
%>

<!DOCTYPE html>
<html>
<head>
<script type='text/javascript'
	src='http://lebhq-erintdev.c-sgroup.com/erapid/javascript/excanvas.js'></script>
<!-- Title Goes Here -->
<title></title>
<style>
th {
	border: 1px solid black;
}

td {
	border: 1px solid black;
	text-align: left;
}

#p1 {
	margin-top: 10px;
}

@media print {
	canvas {
		page-break-inside: avoid;
	}
	#div1{
		page-break-inside: avoid;
		margin-bottom:90px
	}
	#div2{
		page-break-inside: avoid;
	}
}
</style>
</head>
<body>
	<div style='position: none; width: 760px; padding: 1px; margin: auto;'>
		<img style='margin-left: 10px; margin-top: 5px;'
			src='http://csimages.c-sgroup.com/eRapid/cs_logo_poland.jpg' alt='CS' />
		<div>
			<p
				style='text-align: right; margin-right: 20px; margin-top: -30px; color: black; font-size: 8pt; font-family: Arial;'>C/S
				POLSKA SP.Z O.O.</p>
			<p
				style='text-align: right; margin-right: 20px; margin-top: 1px; color: black; font-size: 8pt; font-family: Arial;'>ul.
				Szczeci&#x144;ska 34</p>
			<p
				style='text-align: right; margin-right: 20px; margin-top: -10px; color: black; font-size: 8pt; font-family: Arial;'>73-108
				Kobylanka k. Szczecina</p>
			<p
				style='text-align: right; margin-right: 20px; margin-top: 1px; color: black; font-size: 8pt; font-family: Arial;'>telefon
				913913510,915610450</p>
			<p
				style='text-align: right; margin-right: 20px; margin-top: -10px; color: black; font-size: 8pt; font-family: Arial;'>fax
				913913528,913913527</p>
			<p
				style='text-align: right; margin-right: 20px; margin-top: 1px; color: black; font-size: 8pt; font-family: Arial;'>NIP
				781-10-02-551</p>
			<p
				style='text-align: right; margin-right: 20px; margin-top: -10px; color: black; font-size: 8pt; font-family: Arial;'>Prezes
				Zarz&#x105;du: Marek Markowski</p>
			<p
				style='text-align: right; margin-right: 20px; margin-top: -10px; color: black; font-size: 8pt; font-family: Arial;'>06116022020000000035444690
				Bank Millenium S.A.</p>
		</div>
		<div>
			<p style='text-align: center; font-size: 12pt; font-family: Arial;'>
				<b>Optymizer</b>
			</p>
		</div>
		<div>
			<p
				style='margin-left: 15px; text-align: left; font-size: 8pt; font-family: Arial; margin-top: 1px;'>
				<b>Nr Oferty:</b> <%=sheets.getOrderNo() %>
			</p>
		</div>
		<div>
			<p
				style='margin-left: 15px; text-align: left; font-size: 8pt; font-family: Arial; margin-top: -10px;'>
				<b>Nazwa Inwestycji:</b> <%=sheets.getProject() %> </b>
			</p>
		</div>
		<div>
			<p
				style='margin-left: 15px; text-align: left; font-size: 8pt; font-family: Arial; margin-top: -5px;'>
				<b><u>ZESTWIENIE P&#x141;YT</u></b>
			</p>
		</div>
		<div>
			<table
				style='border-collapse: collapse; margin-top: -5px; margin-left: 15px; border: 1px solid black; width: 700px; font-size: 8pt; font-family: Arial;'>
				<tr style='background-color: #D3D3D3;'>
					<th style='text-align: left;'>P&#x142;yta</th>
					<th style='text-align: left;'>Kolor</th>
					<th style='text-align: left;'>Ilo&#x15b;&#x107;</th>
					<th style='text-align: left;'>Zu&#x17c;ycia%</th>
				</tr>
				<!---  first    -->
				<%  for(Rep rep:repList){
					
				%>
				<tr>
					<td style='text-align: right;'><%= rep.getRepdm() %></td>
					<td style='text-align: right;'><%= rep.getRepclr() %></td>
					<td style='text-align: right;'><%= rep.getRepqty() %></td>
					<td style='text-align: right;'><%= rep.getRepperc() %></td>
				</tr>
				<% } %>
				
			</table>
			<%  repList=null;  %>
			
			<div>
				<p
					style='margin-left: 15px; margin-top: 25px; text-align: left; font-size: 8pt; font-family: Arial;'>
					<b><u>ZESTWIENIE ODCINK&Oacute;W</u></b>
				</p>
			</div>
			<table
				style='border-collapse: collapse; margin-top: -5px; margin-left: 15px; border: 1px solid black; width: 700px; font-size: 8pt; font-family: Arial;'>
				<tr style='background-color: #D3D3D3;'>
					<th style='text-align: left;'>Nr Linii</th>
					<th style='text-align: left;'>P&#x142;yta</th>
					<th style='text-align: left;'>Kolor</th>
					<th style='text-align: left;'>Ilo&#x15b;&#x107;</th>
					<th style='text-align: left;'>D&#x142;ugo&#x15b;&#x107;</th>
					<th style='text-align: left;'>Szeroko&#x15b;&#x107;</th>
				</tr>
				<%  for(Cutpiece cutPiece:cutPieceList){

						  String[] repStr = cutPiece.getCutdm().split("x");
			              String	rep_length = repStr[1].split("\\.")[0];
			              String	rep_width = repStr[2].split("\\.")[0];
						  
						  String	sheet_length = cutPiece.getLen();
			              String	sheet_width = cutPiece.getWth();
						  
						  long rep_len, rep_wid,dem_len, dem_wid;
			              rep_len = Integer.parseInt(rep_length);
			              rep_wid = Integer.parseInt(rep_width);
						  
						  dem_len = Integer.parseInt(sheet_length);
			              dem_wid = Integer.parseInt(sheet_width);
						  long totalRepSheet =  rep_len * rep_wid;
						  long totalDemSheet =  dem_len * dem_wid;
						  
							if(totalDemSheet > totalRepSheet){
								%>
					<tr style='font-weight:bold; font-size: 8pt'>
					<td style='text-align: left;'>* <%= cutPiece.getLineNo() %></td>
					<td style='text-align: left;'><%=cutPiece.getCutdm() %></td>
					<td style='text-align: left;'><%=cutPiece.getCutclr() %></td>
					<td style='text-align: left;'><%=cutPiece.getCutqty() %></td>
					<td style='text-align: left;'><%=cutPiece.getLen() %></td>
					<td style='text-align: left;'><%= cutPiece.getWth() %></td>
				</tr>
				<%
							}else if((dem_len > rep_len)  || (dem_wid > rep_wid)){
							%>	
							
							<tr style='font-weight:bold; font-size: 8pt'>
					<td style='text-align: left;'>* <%= cutPiece.getLineNo() %></td>
					<td style='text-align: left;'><%=cutPiece.getCutdm() %></td>
					<td style='text-align: left;'><%=cutPiece.getCutclr() %></td>
					<td style='text-align: left;'><%=cutPiece.getCutqty() %></td>
					<td style='text-align: left;'><%=cutPiece.getLen() %></td>
					<td style='text-align: left;'><%= cutPiece.getWth() %></td>
				</tr>
								
							<%	}else{
								%>
									<tr>
					<td style='text-align: right;'> <%= cutPiece.getLineNo() %></td>
					<td style='text-align: right;'><%=cutPiece.getCutdm() %></td>
					<td style='text-align: right;'><%=cutPiece.getCutclr() %></td>
					<td style='text-align: right;'><%=cutPiece.getCutqty() %></td>
					<td style='text-align: right;'><%=cutPiece.getLen() %></td>
					<td style='text-align: right;'><%= cutPiece.getWth() %></td>
				</tr>
				<%
							}%>
					
				        

			
				<% } %>
				
			</table>
			<p style='font-size:12px;margin-top:0px;margin-left:15px;'>UWAGA! Odcinki oznaczone gwiazdk&#x0105; ( * ) NIE ZOSTA&#x0141;Y uj&#x0119;te w kalkulacji. Brak mo&#x017A;liwo&#x015B;ci rotacji p&#x0142;yty.</p>
			<%  
			  cutPieceList=null;  
			 int first=0,second=0; 
			String sheetLen="",sheetWidth="",sheetDim="", innerHtmlStr=null;
			for(Sheet sheet:sheetsList){
				sheet.setSheetNo(""+iterator);
				sheetDim=sheet.getSheetdm();
				String [] dims=sheetDim.split("x");
				sheetLen=String.valueOf(Integer.parseInt(dims[1])/10);
				sheetWidth=String.valueOf(Integer.parseInt(dims[2])/10);
				List<String> cutsList=sheet.getCuts();
				List<String> wasteList=sheet.getWaste();
				myCanvas="myCanvas"+iterator+"a";
			
				%>
			<div id='div1' style='margin-bottom:125px'>
				<div>
					<p id='p1'
						style='margin-left: 15px; text-align: left; font-size: 8pt; font-family: Arial;'>
						<b><u>ROZMIESZCZENIE ODCINK&Oacute;W</u></b>
					</p>
					<p id='p2'
						style='margin-left: 15px; text-align: left; font-size: 8pt; font-family: Arial; margin-top: -5px;'>
						<b>P&#x142;yta Nr:</b> <%=sheet.getSheetNo()  %>
					</p>
					<p id='p3'
						style='margin-left: 15px; text-align: left; font-size: 8pt; font-family: Arial; margin-top: -10px;'>
						<b>P&#x142;yta:</b> <%=sheet.getSheetdm()  %></b>
					</p>
					<p id='p4'
						style='margin-left: 15px; text-align: left; font-size: 8pt; font-family: Arial; margin-top: -10px;'>
						<b>Kolor:</b> <%=sheet.getSheetclr()  %>
					</p>
					<p id='p5'
						style='margin-left: 15px; text-align: left; font-size: 8pt; font-family: Arial; margin-top: -10px;'>
						<b>Zu&#x17c;ycie:</b> <%=sheet.getSheetper()  %></b>
					</p>
				</div>
				<div style='margin: auto; width: 75%;'>
					<canvas id='<%=myCanvas%>' width='<%=sheetLen  %>' height='<%=sheetWidth  %>'
						style='border: 1px solid black; margin-left: 50px; float: left;'>Your browser does not support the HTML5 canvas tag.</canvas>
					<div id='div2'>
					<table id='myTable1'
						style='text-align: center; border-collapse: collapse; float: right;'>
						<tr>
							<th>&nbsp&nbspNr &nbsp&nbsp</th>
							<th>&nbsp&nbspOdcinek&nbsp&nbsp</th>
						</tr>
						<% 
						 

						for(int i=0;i<cutsList.size();i++){ 
						 myTd1="myTd1"+sheet.getSheetNo()+i;
						 myTd2="myTd2"+sheet.getSheetNo()+i;
						
						%>
						<tr>
							<td style='text-align: center;' id='<%=myTd1%>'></td>
							<td style='text-align: center;' id='<%=myTd2%>'></td>
						</tr>
						<%  }  %>
						
					</table>
					</div>
				</div>
				<div>
					<p id='p6' style='margin-left: 150px;margin-top:<%=(Integer.parseInt(dims[2])/10)+20  %>px'></p>
					<p id='p7' style='margin-left: 150px;'>Odpad: W</p>
					<script type='text/javascript'>
						var c = document.getElementById('<%=myCanvas%>');
						if (typeof window.G_vmlCanvasManager != 'undefined') {
							c = window.G_vmlCanvasManager.initElement(c);
							var cxt = c.getContext('2d');
						} else {
							var cxt = c.getContext('2d');
						}
						<%   
                         
						it=0;
						for(String cutt:cutsList){   
						
						dims=cutt.split("_");
						first=Integer.parseInt(dims[0]);
						first=first+1;
						second=Integer.parseInt(dims[1]);
						second=second+1;
						innerHtmlStr=(Integer.parseInt(dims[2])*10)+"*"+(Integer.parseInt(dims[3])*10);
						 myTd1="myTd1"+sheet.getSheetNo()+it;
						 myTd2="myTd2"+sheet.getSheetNo()+it;
						 it=it+1;
						%>
						cxt.rect(<%=dims[0]%>, <%=dims[1]%>, <%=dims[2]%>, <%=dims[3]%>);
						cxt.stroke();
						cxt.font = '10px Times New Roman';
						cxt.textBaseline = 'top';
						cxt.fillText('<%=dims[4]%>', <%=first %>, <%=second %>);
						cxt.restore();
						var c1 = document.getElementById('<%=myTd1%>');
						c1.innerHTML = '<%=dims[4]%>';
						var c2 = document.getElementById('<%=myTd2%>');
						c2.innerHTML = '<%=innerHtmlStr %>';
						<%   
						cutt=null;
						} 
                        cutsList=null;
						%>
						
						
						<% for(String waste:wasteList){ 
                           dims=waste.split("_");
						   int waste_x=Integer.parseInt(dims[0])+1;
						   int waste_y=Integer.parseInt(dims[1])+1;
						%>
						
						cxt.font = '10px Times New Roman';
						cxt.textBaseline = 'top';
						cxt.fillText('w', <%=waste_x%>, <%=waste_y%>);
						
						<% 
						waste=null;
						
						}
                        wasteList=null;
						%>
						
						
						
						
					</script>
				</div>
			</div>
			
			
			<%  iterator++;
			
			sheet=null;
			}  %>
		</div>
	</div>
</body>

<%  
	sheets=null;
	System.out.println("WE ARE DONE****************");
%>
</html>