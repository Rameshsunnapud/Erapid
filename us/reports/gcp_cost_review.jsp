<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%><html>
	<head>
		<title>GCP</title>
		<link rel='stylesheet' href='../../css/styleMain.css' type='text/css' />
	</head>
	<script language="Javascript">
		function resetx(){
			document.form1.calcPrice.value=(document.form1.initialPrice.value*1).toFixed(2);
			document.form1.calcPrice2.value=(document.form1.initialPrice.value*1).toFixed(2);
			document.form1.calcGM.value=(document.form1.initialGM.value*1).toFixed(2);
			document.form1.calcGM2.value=(document.form1.initialGM.value*1).toFixed(2);
			document.form1.calcComm.value=(document.form1.initialComm.value*1).toFixed(2);
		}
		function calc(){
			//alert("calc ");
			var gmCalc=((document.form1.calcPrice.value-document.form1.initialCost.value)/document.form1.calcPrice.value)-((document.form1.calcComm.value*.91)/100);
			//alert("2");
			document.form1.calcGM.value=(gmCalc*100).toFixed(2);
			//alert("3");
			var priceCalc=document.form1.initialCost.value/(1-((document.form1.calcGM2.value/100+(document.form1.calcComm.value*.91)/100)));
			//alert("4");
			document.form1.calcPrice2.value=priceCalc.toFixed(2);
			//alert("5");

		}
	</script>
	<body>
		<form name='form1'>
			<%@ page language="java" import="java.sql.*" import="java.net.*" import="java.text.*" import="java.io.*" import="java.util.*" errorPage="error.jsp" %>
			<%@ include file="../../db_con.jsp"%>
			<%
			DecimalFormat for2 = new DecimalFormat("####.##");
			for2.setMaximumFractionDigits(2);
			for2.setMinimumFractionDigits(2);
			Vector type = new Vector();
			Vector model = new Vector();
			Vector cost = new Vector();
			Vector qty = new Vector();
			Vector uom = new Vector();
			Vector price = new Vector();
			Vector margin = new Vector();
			Vector commission = new Vector();

			Vector manufacturer = new Vector();
			Vector pattern = new Vector();
			Vector fabricDirection = new Vector();
			Vector fabricCountry = new Vector();
			double marginDollars=0;
			double commissionDollars=0;
			String orderNox=request.getParameter("orderNo");
			ResultSet rs1=stmt.executeQuery("select type,model,sum(cast (cost as float)) as a1,sum(cast(qty as float)) as a2,sum(cast(price as float)) as a3,uom,margin,commission,manufacturer,pattern,fabric_direction,fabric_country from cs_cost_review where order_no='"+orderNox+"' group by type,model,margin,commission,manufacturer,pattern,fabric_direction,uom,fabric_country order by type,model,manufacturer,pattern ");
			if(rs1 != null){
				while(rs1.next()){
					if(rs1.getString("type")!=null){
						type.addElement(rs1.getString("type"));
					}
					else{
						type.addElement("");
					}
					if(rs1.getString("model")!=null){
						model.addElement(rs1.getString("model"));
					}
					else{
						model.addElement("");
					}
					if(rs1.getString("a1")!=null){
						cost.addElement(rs1.getString("a1"));
					}
					else{
						cost.addElement("");
					}
					if(rs1.getString("a2")!=null){
						qty.addElement(rs1.getString("a2"));
					}
					else{
						qty.addElement("");
					}
					if(rs1.getString("uom")!=null){
						uom.addElement(rs1.getString("uom"));
					}
					else{
						uom.addElement("");
					}
					if(rs1.getString("a3")!=null){
						price.addElement(rs1.getString("a3"));
					}
					else{
						price.addElement("");
					}
					if(rs1.getString("margin")!=null){
						margin.addElement(rs1.getString("margin"));
						marginDollars=marginDollars+ new Double(rs1.getString("a3")).doubleValue()*(new Double(rs1.getString("margin")).doubleValue()/100);
						//out.println(rs1.getString("a3")+"*"+rs1.getString("margin")+"="+new Double(rs1.getString("a3")).doubleValue()*(new Double(rs1.getString("margin")).doubleValue()/100)+"<BR>");
					}
					else{
						margin.addElement("");
					}
					if(rs1.getString("commission")!=null){
						commission.addElement(rs1.getString("commission"));
						commissionDollars=commissionDollars+ (new Double(rs1.getString("a3")).doubleValue()*.91)*(new Double(rs1.getString("commission")).doubleValue()/100);
					}
					else{
						commission.addElement("");
					}
					if(rs1.getString("manufacturer")!=null){
						manufacturer.addElement(rs1.getString("manufacturer"));
					}
					else{
						manufacturer.addElement("");
					}
					if(rs1.getString("pattern")!=null){
						pattern.addElement(rs1.getString("pattern"));
					}
					else{
						pattern.addElement("");
					}
					if(rs1.getString("fabric_direction")!=null){
						fabricDirection.addElement(rs1.getString("fabric_direction"));
					}
					else{
						fabricDirection.addElement("");
					}
					if(rs1.getString("fabric_country")!=null){
						fabricCountry.addElement(rs1.getString("fabric_country"));
					}
					else{
						fabricCountry.addElement("");
					}
				}
			}
			rs1.close();
			Vector distinctType=new Vector();
			ResultSet rs2=stmt.executeQuery("select distinct type from cs_cost_review where order_no='"+orderNox+"' ");
			if(rs2 != null){
				while(rs2.next()){
					distinctType.addElement(rs2.getString(1));
				}
			}
			rs2.close();
			Vector groupType=new Vector();
			Vector groupPrice=new Vector();
			Vector groupCost=new Vector();
			Vector groupGM=new Vector();
			Vector groupComm=new Vector();
			for(int i=0; i<distinctType.size(); i++){
				ResultSet rs3=stmt.executeQuery("select sum(cast(price as float)) as a1, sum(cast(cost as float)) as a2 from cs_cost_review where order_no='"+orderNox+"' and type='"+distinctType.elementAt(i).toString()+"'");
				if(rs3 != null){
					while(rs3.next()){
						groupType.addElement(distinctType.elementAt(i).toString());
						groupPrice.addElement(rs3.getString("a1"));
						groupCost.addElement(rs3.getString("a2"));
						groupGM.addElement("");
						groupComm.addElement("");
					}
				}
				rs3.close();
			}
			double totalPrice=0;
			double totalCost=0;
			double totalGM=0;
			double totalComm=0;
			ResultSet rs4=stmt.executeQuery("select sum(cast(price as float)) as a1, sum(cast(cost as float)) as a2 from cs_cost_review where order_no='"+orderNox+"'");
			if(rs4 != null){
				while(rs4.next()){
					totalPrice=rs4.getDouble("a1");
					totalCost=rs4.getDouble("a2");
				}
			}
			rs4.close();
			totalGM=(marginDollars/totalPrice)*100;
			totalComm=(commissionDollars/(totalPrice*.91))*100;
			out.println("<table border='1' width='50%'>");
			out.println("<input type='hidden' name='initialPrice' value='"+totalPrice+"'>");
			out.println("<input type='hidden' name='initialCost' value='"+totalCost+"'>");
			out.println("<input type='hidden' name='initialGM' value='"+totalGM+"'>");
			out.println("<input type='hidden' name='initialComm' value='"+totalComm+"'>");
			out.println("<tr  class='header1'>");
			out.println("<td width='20%'>&nbsp;</td>");
			out.println("<td width='20%'>Job Listed</td>");
			out.println("<td width='20%'>Change Price</td>");
			out.println("<td width='20%'>Change Margin</td>");
			out.println("<td width='20%'></td>");
			out.println("</tr>");
			out.println("<tr >");
			out.println("<td>Total Price</td>");
			out.println("<td align='right'>"+for2.format(totalPrice)+"</td>");
			out.println("<td><input type='text' name='calcPrice' value='"+for2.format(totalPrice)+"' ></td>");
			out.println("<td><input type='text' name='calcPrice2' value='"+for2.format(totalPrice)+"' bgcolor='grey' readonly></td>");
			out.println("<td><input type='button' class='button' name='Calc' value='Calc' onclick='calc()'></td>");
			out.println("</tr>");
			out.println("<tr >");
			out.println("<td>Total Cost</td>");
			out.println("<td align='right'>"+for2.format(totalCost)+"</td>");
			out.println("<td></td>");
			out.println("<td>&nbsp;</td>");
			out.println("<td><input type='button' class='button' name='reset' value='Reset' onclick='resetx()'></td>");
			out.println("</tr>");
			out.println("<tr >");
			out.println("<td>Job GM% "+for2.format(marginDollars)+"</td>");
			out.println("<td align='right'>"+for2.format(totalGM)+"</td>");
			out.println("<td><input type='text' name='calcGM' value='"+for2.format(totalGM)+"' readonly ></td>");
			out.println("<td><input type='text' name='calcGM2' value='"+for2.format(totalGM)+"' ></td>");
			out.println("<td>&nbsp;</td>");
			out.println("</tr>");
			out.println("<tr >");
			out.println("<td>Job Comm% "+ for2.format(commissionDollars)+"</td>");
			out.println("<td align='right'>"+for2.format(totalComm)+"</td>");
			out.println("<td colspan='2' align='center'><input type='text' name='calcComm' value='"+for2.format(totalComm)+"' ></td>");
			out.println("<td>&nbsp;</td>");
			out.println("</tr>");
			out.println("</table>");
			out.println("<table border='1' width='50%'>");
			out.println("<tr  class='header1'>");
			out.println("<td width='20%'>type</td>");
			out.println("<td width='20%'>total price</td>");
			out.println("<td width='20%'>total cost</td>");
			out.println("<td width='20%'>gm</td>");
			out.println("<td width='20%'>comm</td>");
			out.println("</tr>");
			for(int i=0; i<groupType.size(); i++){
				out.println("<tr>");
				out.println("<td >"+groupType.elementAt(i).toString()+"</td>");
				out.println("<td align='right'>"+for2.format(new Double(groupPrice.elementAt(i).toString()).doubleValue())+"</td>");
				out.println("<td align='right'>"+for2.format(new Double(groupCost.elementAt(i).toString()).doubleValue())+"</td>");
				out.println("<td align='right'>"+groupGM.elementAt(i).toString()+"</td>");
				out.println("<td align='right'>"+groupComm.elementAt(i).toString()+"</td>");
				out.println("</tr>");
			}
			out.println("</table>");
			out.println("<table border='1' width='100%'>");
			out.println("<tr  class='header1'>");
			out.println("<td>type</td>");
			out.println("<td>model</td>");
			out.println("<td>cost</td>");
			out.println("<td>qty</td>");
			out.println("<td>uom</td>");
			out.println("<td>price</td>");
			out.println("<td>margin</td>");
			out.println("<td>commission</td>");
			out.println("<td>manufacturer</td>");
			out.println("<td>pattern</td>");
			out.println("<td>fabric_direction</td>");
			out.println("<td>fabric_country</td>");
			out.println("</tr>");
			for(int i=0; i<type.size(); i++){
				out.println("<tr>");
				out.println("<td >"+type.elementAt(i).toString()+"</td>");
				out.println("<td >"+model.elementAt(i).toString()+"</td>");
				out.println("<td align='right'>"+for2.format(new Double(cost.elementAt(i).toString()).doubleValue())+"</td>");
				out.println("<td align='right'>"+for2.format(new Double(qty.elementAt(i).toString()).doubleValue())+"</td>");
				out.println("<td >"+uom.elementAt(i).toString()+"</td>");
				out.println("<td align='right'>"+for2.format(new Double(price.elementAt(i).toString()).doubleValue())+"</td>");
				out.println("<td align='right'>"+for2.format(new Double(margin.elementAt(i).toString()).doubleValue())+"</td>");
				out.println("<td align='right'>"+for2.format(new Double(commission.elementAt(i).toString()).doubleValue())+"</td>");
				out.println("<td >"+manufacturer.elementAt(i).toString()+"</td>");
				out.println("<td >"+pattern.elementAt(i).toString()+"</td>");
				out.println("<td >"+fabricDirection.elementAt(i).toString()+"</td>");
				out.println("<td >"+fabricCountry.elementAt(i).toString()+"</td>");
				out.println("</tr>");
			}
			out.println("</table>");
			stmt.close();
			myConn.close();
		}
		catch(Exception e){
		out.println(e);
		}
			%>
		</form>
	</body>
</html>