<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<%
//if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
//        erapidBean.setServerName("server1");
//}
try{

%><%-- Set the content type header with the JSP directive --%>
<%@ page contentType="application/vnd.ms-excel" import="java.sql.*"  import="java.text.*"  import="java.util.*" errorPage="error.jsp" %>

<%-- Set the content disposition header --%>
<% response.setHeader("Content-Disposition", "attachment; filename=\"mult-table.xls\""); %>
<%@ include file="../../../db_con.jsp"%>
<%//@ include file="db_con_bpcsusr.jsp"%>
<%
String usedModels=request.getParameter("usedModels");
String usedItems=request.getParameter("usedItems");
if(usedModels==null || usedModels.equals("null")){
	usedModels="";
}
if(usedItems==null || usedItems.equals("null")){
	usedItems="";
}
//out.println(usedModels+"::"+usedItems);
DecimalFormat for1 = new DecimalFormat("###.##");
for1.setMaximumFractionDigits(4);
for1.setMinimumFractionDigits(4);
java.util.Date myDate = new java.util.Date();
String x1=""+(myDate.getYear()+1900);
String x2=""+(myDate.getMonth()+1);
String x3=""+myDate.getDate();
if(x2.trim().length()<2){
	x2="0"+x2;
}
if(x3.trim().length()<2){
	x3="0"+x3;
}
String x4=x2+"/"+x3+"/"+x1;
//out.println(x4);
out.println("<table aign='center' border='0' width='100%'><tr><td width='25%' align='left' valign='top'>DATE: "+x4+"</td><td width='50%' align='center' valign='top'><font size='3'>CONFIDENTIAL PROPERTY OF CS</font></td><td width='25%' align='right'>&nbsp;</td></tr></table>");

if(usedModels.trim().length()>0){
%>
<TABLE cellspacing=0 cellpadding=2 id=header width='1250px' border='1'>
	<tr>
		<td width='5%'  bgcolor='lightgrey'>SBU</td>
		<td width='13%'  bgcolor='lightgrey'>MODEL</td>
		<td width='12%'  bgcolor='lightgrey'>BPCS</td>
		<td width='37%' bgcolor='lightgrey'>DESC</td>
		<td width='5%'  bgcolor='lightgrey'>UM</td>
		<td width='6%'  bgcolor='lightgrey'>UNIT WEIGHT</td>
		<td width='6%'  bgcolor='lightgrey'>IC PRICE</td>
		<td width='6%'  bgcolor='lightgrey'>SAMPLE PRICE</td>
		<td width='6%' bgcolor='lightgrey'>METRIC</td>
		<td width='6%' bgcolor='lightgrey'>UM METRIC</td>
		<td width='6%' bgcolor='lightgrey'>UNIT WEIGHT METRIC</td>
		<td width='10%' bgcolor='lightgrey'>EFFECTIVE DATE</td>
	</tr>
	<%

	if(usedModels.endsWith("-")){
		usedModels=usedModels.substring(0,usedModels.length()-1);
	}
	usedModels=usedModels.replaceAll("-","','");

	ResultSet rsUsedModels=stmt.executeQuery("Select * from cs_ic_price where model in ('"+usedModels+"') order by sbu,model");
	if(rsUsedModels != null){
		while(rsUsedModels.next()){
			String sbux="&nbsp;";
			if(rsUsedModels.getString("sbu") != null){
				sbux=rsUsedModels.getString("sbu");
			}
			String typex="&nbsp;";
			if(rsUsedModels.getString("type") != null){
				typex=rsUsedModels.getString("type");
			}
			String modelx="&nbsp;";
			if(rsUsedModels.getString("model") != null){
				modelx=rsUsedModels.getString("model");
			}
			String bpcsx="&nbsp;";
			if(rsUsedModels.getString("bpcs") != null){
				bpcsx=rsUsedModels.getString("bpcs");
			}
			String descriptionx="&nbsp;";
			if(rsUsedModels.getString("description") != null){
				descriptionx=rsUsedModels.getString("description");
			}
			String codex="&nbsp;";
			if(rsUsedModels.getString("code") != null){
				codex=rsUsedModels.getString("code");
			}
			String umx="&nbsp;";
			if(rsUsedModels.getString("um") != null){
				umx=rsUsedModels.getString("um");
			}
			String unit_weightx="0";
			if(rsUsedModels.getString("unit_weight") != null){
				unit_weightx=rsUsedModels.getString("unit_weight");
			}
			String muncyx="0";
			if(rsUsedModels.getString("muncy") != null){
				muncyx=rsUsedModels.getString("muncy");
			}
			String muncy_slx="0";
			if(rsUsedModels.getString("muncy_sl") != null){
				muncy_slx=rsUsedModels.getString("muncy_sl");
			}
			String int_bookx="0";
			if(rsUsedModels.getString("int_book") != null){
				int_bookx=rsUsedModels.getString("int_book");
			}
			String effective_datex="";
			if(rsUsedModels.getString("effective_date") != null){
				effective_datex=rsUsedModels.getString("effective_date").substring(0,10);
			}
			String metricx="0";
			if(rsUsedModels.getString("Metric") != null){
				metricx=rsUsedModels.getString("Metric");
			}
			String um_metricx="";
			if(rsUsedModels.getString("UM_Metric") != null){
				um_metricx=rsUsedModels.getString("UM_Metric");
			}
			String um_wgt_metricx="0";
			if(rsUsedModels.getString("UM_Wgt_Metric") != null){
				um_wgt_metricx=rsUsedModels.getString("UM_Wgt_Metric");
			}
			out.println("<tr>");
			out.println("<td width='5%'  >"+sbux+"</td>");
			out.println("<td width='13%'  >"+modelx+"</td>");
			out.println("<td width='12%'  >"+bpcsx+"</td>");
			out.println("<td width='37%' >"+descriptionx+"</td>");
			out.println("<td width='5%'  >"+umx+"</td>");
			out.println("<td width='6%'  align='right'>"+for1.format(new Double(unit_weightx).doubleValue())+"</td>");
			out.println("<td width='6%'  align='right'>"+for1.format(new Double(muncyx).doubleValue())+"</td>");
			out.println("<td width='6%'  align='right'>"+for1.format(new Double(muncy_slx).doubleValue())+"</td>");
			out.println("<td width='6%'  align='right'>"+for1.format(new Double(metricx).doubleValue())+"</td>");
			out.println("<td width='6%'  align='right'>"+um_metricx+"</td>");
			out.println("<td width='6%'  align='right'>"+for1.format(new Double(um_wgt_metricx).doubleValue())+"</td>");
			out.println("<td width='10%' >"+effective_datex+"</td>");
			out.println("</tr>");
		}
	}
	rsUsedModels.close();
	out.println("</table>");
}
if(usedItems.trim().length()>0){
	%>
	<TABLE cellspacing=0 cellpadding=2 id=header width='1250px' border='1'>
		<tr>
			<td width='10%' bgcolor='lightgrey'>ITEM<BR>NUMBER</td>
			<td width='10%' bgcolor='lightgrey'>STOCK COST</td>
			<td width='10%' bgcolor='lightgrey'>BUSINESS UNIT</td>
			<td width='10%' bgcolor='lightgrey'>STOCK UOM</td>
			<td width='10%' bgcolor='lightgrey'>WEIGHT</td>
			<td width='10%' bgcolor='lightgrey'>INVENTORY QTY</td>
			<td width='20%' bgcolor='lightgrey'>ITEM DESCRIPTION</td>
			<td width='20%' bgcolor='lightgrey'>ITEM DESCRIPTION 2</td>
		</tr>
		<%
		if(usedItems.endsWith("-")){
			usedItems=usedItems.substring(0,usedItems.length()-1);
		}
		usedItems=usedItems.replaceAll("-","','");
		Vector sbux=new Vector();
		Vector codex=new Vector();
		Vector multix=new Vector();
		Vector intlMultix=new Vector();
		ResultSet rs0x=stmt.executeQuery("select sbu,code,muncy,east from cs_ic_multiplier where type='p' order by cast(code as integer)");
		if(rs0x != null){
			while(rs0x.next()){
				if(rs0x.getString(1).equals("EJC")){
					sbux.addElement("TPG");
				}
				else{
					sbux.addElement(rs0x.getString(1));
				}
				codex.addElement(rs0x.getString(2).substring(0,2));
				multix.addElement(rs0x.getString(3));
				if(rs0x.getString(4) != null && rs0x.getString(4).trim().length()>0){
					intlMultix.addElement(rs0x.getString(4));
				}
				else{
					intlMultix.addElement("0");
				}
			}
		}
		rs0x.close();
		String query2x="Select PRCITM,PRCCST,PRCSBU,PRCSUM,PRCWGT,PRCBAL,PRCDSC,PRCDS2 from CS_PRC001PF where PRCITM in ('"+usedItems+"') order by PRCSBU,PRCITM";
		//out.println(query2x);
		int count2=0;
		ResultSet rsUsedItems=stmt.executeQuery(query2x);
		if(rsUsedItems != null){
			out.println("<tr>");
			while(rsUsedItems.next()){
				boolean isGood=false;
				String multiplier="";
				String intlMultiplier="";
				if(rsUsedItems.getString(3) != null &&(rsUsedItems.getString(3).equals("EFS")|rsUsedItems.getString(3).equals("IWP")|rsUsedItems.getString(3).equals("TPG"))|rsUsedItems.getString(3).equals("MS0")){
					for(int count=0; count<sbux.size(); count++){
						if(rsUsedItems.getString(3).equals(sbux.elementAt(count).toString()) && rsUsedItems.getString(1).substring(0,2).equals(codex.elementAt(count).toString())&& !isGood){
							multiplier=multix.elementAt(count).toString();
							intlMultiplier=intlMultix.elementAt(count).toString();
							isGood=true;
						}
						else if(!isGood && rsUsedItems.getString(3).equals(sbux.elementAt(count).toString())){
							multiplier=multix.elementAt(count).toString();
							intlMultiplier=intlMultix.elementAt(count).toString();
						}
					}
				}
				else{
					multiplier=multix.elementAt(1).toString();
					intlMultiplier=intlMultix.elementAt(1).toString();
				}
				count2++;
				for(int a=1; a<=8; a++){
					String align="";
					//count2++;
					if(a==2 | a==6 ){
						align="align='right'";
					}
					else{
						align="align='left'";
					}
					if(rsUsedItems.getString(a) != null && rsUsedItems.getString(a).trim().length()>0){
						String wth=" width='10%'";
						if(a==1){
							out.println("<input type='hidden' name='item' value='"+rsUsedItems.getString(a).trim()+"'>");
						}
						if(a==7 || a==8){
							wth=" width='20%'";
						}
						if(a==2){
							out.println("<td "+align+" "+wth+">"+for1.format(new Double(rsUsedItems.getString(a)).doubleValue() * new Double(multiplier).doubleValue())+"</td>");
						}
						else{
							out.println("<td "+align+" "+wth+">"+rsUsedItems.getString(a)+"</td>");
						}
					}
					else{
						out.println("<td>&nbsp;</td>");
					}
				}
				out.println("</tr>");
			}
			out.println("</table>");
		}
		rsUsedItems.close();
		//stmt_bpcsusr.close();
		out.println("</table>");
	}
	//stmt_bpcsusr.close();
	//con_bpcsusr.close();
	stmt.close();
	myConn.close();
		%>

	</table>
	<%
	}
	  catch(Exception e){
		out.println("ERROR::"+e);
	  }
	%>