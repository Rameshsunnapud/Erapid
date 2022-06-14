<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{

%>
<html>
	<head>
		<title>ADS</title>
		<link rel='stylesheet' href='styleAds.css' type='text/css' />
	</head>
	<SCRIPT LANGUAGE="JavaScript">
		<!-- Begin
		function draftChange(){
			var x=0;
			for(var ii=0;ii<document.form1.countx.value;ii++){
				if(document.form1.drafting[ii].value.length>0){
					x=x+document.form1.drafting[ii].value*1;
				}
			}
			document.form1.globalDrafting.value=x;
			document.form1.draftingHours.value=document.form1.globalDrafting.value/document.form1.draftingRate.value;
			priceChange();
		}
		function layoutChange(){
			var x=0;
			for(var ii=0;ii<document.form1.countx.value;ii++){
				if(document.form1.layout[ii].value.length>0){
					x=x+document.form1.layout[ii].value*1;
				}
			}
			document.form1.globalLayout.value=x;
			document.form1.layoutHours.value=document.form1.globalLayout.value/document.form1.layoutRate.value;
			priceChange();
		}
		function projectMgmtChange(){
			var x=0;
			for(var ii=0;ii<document.form1.countx.value;ii++){
				if(document.form1.projectMgmt[ii].value.length>0){
					x=x+document.form1.projectMgmt[ii].value*1;
				}
			}
			document.form1.globalProjectMgmt.value=x;
			document.form1.projectMgmtHours.value=document.form1.globalProjectMgmt.value/document.form1.projectMgmtRate.value;
			priceChange();
		}
		function catchallChange(){
			var x=0;
			for(var ii=0;ii<document.form1.countx.value;ii++){
				if(document.form1.catchall[ii].value.length>0){
					x=x+document.form1.catchall[ii].value*1;
				}
			}
			document.form1.globalCatchall.value=x;
			priceChange();
		}
		function freightChange(){
			var x=0;
			//alert("1");
			if(document.form1.countx.value>1){
				for(var ii=0;ii<document.form1.countx.value;ii++){
					if(document.form1.freight[ii].value.length>0){
						x=x+document.form1.freight[ii].value*1;
					}
				}
			}
			else{
				if(document.form1.freight.value.length>0){
					x=x+document.form1.freight.value*1;
				}
			}
			document.form1.globalFreight.value=x;
			priceChange();
		}
		function globalCoordinationChange(){
			var x=document.form1.globalCoordination.value;
			if(document.form1.countx.value>1){
				for(var ii=0;ii<document.form1.countx.value;ii++){
					if(document.form1.model[ii].value!="KP"&&document.form1.model[ii].value!="EDGE"&&document.form1.model[ii].value!="LFK"){
						document.form1.coordination[ii].value=x;
						document.form1.coordinationDollar[ii].value=document.form1.charge[x].value*document.form1.qty[ii].value;
					}
					else{
						document.form1.coordination[ii].value="0";
						document.form1.coordinationDollar[ii].value="0";
					}
				}
			}
			else{
				if(document.form1.model.value!="KP"&&document.form1.model.value!="EDGE"&&document.form1.model.value!="LFK"){
					document.form1.coordination.value=x;
					document.form1.coordinationDollar.value=document.form1.charge[x].value*document.form1.qty.value;
				}
				else{
					document.form1.coordination.value="0";
					document.form1.coordinationDollar.value="0";
				}
			}
			priceChange();
		}
		function globalDraftingChange(){
			if(document.form1.countx.value>1){
				for(var ii=0;ii<document.form1.countx.value;ii++){
					if(document.form1.globalDrafting.value.length>0){
						//alert(document.form1.costPerc[ii].value+"::: a");
						document.form1.drafting[ii].value=(document.form1.globalDrafting.value*document.form1.costPerc[ii].value);
					}
				}
			}
			else{
				document.form1.drafting.value=(document.form1.globalDrafting.value*document.form1.costPerc.value);
			}
			document.form1.draftingHours.value=document.form1.globalDrafting.value/document.form1.draftingRate.value;
			priceChange();
		}
		function globalLayoutChange(){
			if(document.form1.countx.value>1){
				for(var ii=0;ii<document.form1.countx.value;ii++){
					if(document.form1.globalLayout.value.length>0){
						document.form1.layout[ii].value=(document.form1.globalLayout.value*document.form1.costPerc[ii].value);
					}
				}
			}
			else{
				document.form1.layout.value=(document.form1.globalLayout.value*document.form1.costPerc.value);
			}
			document.form1.layoutHours.value=document.form1.globalLayout.value/document.form1.layoutRate.value;
			priceChange();
		}
		function globalProjectMgmtChange(){
			if(document.form1.countx.value>1){
				for(var ii=0;ii<document.form1.countx.value;ii++){
					if(document.form1.globalProjectMgmt.value.length>0){
						document.form1.projectMgmt[ii].value=(document.form1.globalProjectMgmt.value*document.form1.costPerc[ii].value);
					}
				}
			}
			else{
				document.form1.projectMgmt.value=(document.form1.globalProjectMgmt.value*document.form1.costPerc.value);
			}
			document.form1.projectMgmtHours.value=document.form1.globalProjectMgmt.value/document.form1.projectMgmtRate.value
			priceChange();
		}
		function globalCatchallChange(){
			if(document.form1.countx.value>1){
				for(var ii=0;ii<document.form1.countx.value;ii++){
					if(document.form1.globalCatchall.value.length>0){
						document.form1.catchall[ii].value=(document.form1.globalCatchall.value*document.form1.costPerc[ii].value);
					}
				}
			}
			else{
				document.form1.catchall.value=(document.form1.globalCatchall.value*document.form1.costPerc.value);
			}
			priceChange();
		}
		function globalFreightChange(){
			if(document.form1.countx.value>1){
				for(var ii=0;ii<document.form1.countx.value;ii++){
					if(document.form1.globalFreight.value.length>0){
						document.form1.freight[ii].value=(document.form1.globalFreight.value*document.form1.costPerc[ii].value);
					}
				}
			}
			else{
				document.form1.freight.value=(document.form1.globalFreight.value*document.form1.costPerc.value);
			}
			priceChange();
		}
		function draftingHoursChange(){
			document.form1.globalDrafting.value=document.form1.draftingHours.value*document.form1.draftingRate.value;

			globalDraftingChange();

		}
		function layoutHoursChange(){
			document.form1.globalLayout.value=document.form1.layoutHours.value*document.form1.layoutRate.value;
			globalLayoutChange();
			priceChange();
		}
		function projectMgmtHoursChange(){
			document.form1.globalProjectMgmt.value=document.form1.projectMgmtHours.value*document.form1.projectMgmtRate.value;
			globalProjectMgmtChange();
			priceChange();
		}
		function freightCrate(){
			//alert("freight and crate");
			if(document.form1.countx.value>1){
				//alert("1");
				for(var ii=0;ii<document.form1.countx.value;ii++){
					var temp=0;
					var tempCost=0;
					tempCost=document.form1.cost[ii].value*1;
					//+document.form1.drafting[ii].value*1+document.form1.layout[ii].value*1+document.form1.catchall[ii].value*1+document.form1.commission[ii].value*1;
					temp=(tempCost/((1-(document.form1.fcperc.value/100)-document.form1.freightCommFactor.value*1-(document.form1.margin[ii].value/100))*100))*(document.form1.fcperc.value*1);
					document.form1.freight[ii].value=temp;
					//alert(temp+"::"+tempCost+"/1-"+document.form1.fcperc.value+"::"+document.form1.freightCommFactor.value+"::"+document.form1.margin[ii].value);
				}
			}
			else{
				var temp=0;
				var tempCost=0;
				tempCost=document.form1.cost.value*1;
				temp=(tempCost/((1-(document.form1.fcperc.value/100)-document.form1.freightCommFactor.value*1-(document.form1.margin.value/100))*100))*(document.form1.fcperc.value*1);
				document.form1.freight.value=temp;
			}

			freightChange();
			priceChange();
		}
		function priceChange(){

			var globalPrice=0;
			var globalCost=0;
			var globalComm=0;
			//alert("1");
			if(document.form1.countx.value>1){
				//alert("2");
				for(var ii=0;ii<document.form1.countx.value;ii++){
					var lineCost=0;
					var linePrice=0;
					var lineCommission=0;
					lineCost=lineCost+document.form1.cost[ii].value*1;
					if(document.form1.drafting[ii].value.length>0){
						lineCost=lineCost+document.form1.drafting[ii].value*1;
					}
					if(document.form1.layout[ii].value.length>0){
						lineCost=lineCost+document.form1.layout[ii].value*1;
					}
					if(document.form1.projectMgmt[ii].value.length>0){
						lineCost=lineCost+document.form1.projectMgmt[ii].value*1;
					}
					if(document.form1.freight[ii].value.length>0){
						lineCost=lineCost+document.form1.freight[ii].value*1;
					}
					if(document.form1.catchall[ii].value.length>0){
						lineCost=lineCost+document.form1.catchall[ii].value*1;
					}
					if(document.form1.coordinationDollar[ii].value.length>0){
						//lineCost=lineCost+document.form1.coordinationDollar[ii].value*1;
					}
					globalCost=globalCost+lineCost;
					if(document.form1.globalCommission.value.length>0){
						if(document.form1.CSDECO.value=="C"){
							var a=0;
							a=1-(document.form1.margin[ii].value/100);
							var c=0;
							c=document.form1.globalCommission.value/100;
							var b=0;
							b=c*0.91;
							lineCommission=((lineCost/(a-b))*0.91)*c;
						}
						else{
							lineCommission=lineCost/(1-(document.form1.margin[ii].value/100)-(document.form1.globalCommission.value/100))*(document.form1.globalCommission.value/100)
						}
					}
					else{
						lineCommission=0;
					}
					globalComm=globalComm+lineCommission;
					lineCost=lineCost+lineCommission;
					linePrice=lineCost/(1-(document.form1.margin[ii].value/100))+document.form1.coordinationDollar[ii].value*1;
					document.form1.unitprice[ii].value=linePrice/document.form1.qty[ii].value*1;
					document.form1.price[ii].value=linePrice;
					document.form1.commission[ii].value=lineCommission;
					globalPrice=globalPrice+linePrice;
				}
			}
			else{
				//alert("3");
				var lineCost=0;
				var linePrice=0;
				var lineCommission=0;
				lineCost=lineCost+document.form1.cost.value*1;
				if(document.form1.drafting.value.length>0){
					lineCost=lineCost+document.form1.drafting.value*1;
				}
				if(document.form1.layout.value.length>0){
					lineCost=lineCost+document.form1.layout.value*1;
				}
				if(document.form1.projectMgmt.value.length>0){
					lineCost=lineCost+document.form1.projectMgmt.value*1;
				}
				if(document.form1.freight.value.length>0){
					lineCost=lineCost+document.form1.freight.value*1;
				}
				if(document.form1.catchall.value.length>0){
					lineCost=lineCost+document.form1.catchall.value*1;
				}
				if(document.form1.coordinationDollar.value.length>0){
					//lineCost=lineCost+document.form1.coordinationDollar.value*1;
				}
				globalCost=globalCost+lineCost;
				if(document.form1.globalCommission.value.length>0){
					if(document.form1.CSDECO.value=="C"){
						var a=0;
						a=1-(document.form1.margin.value/100);
						var c=0;
						c=document.form1.globalCommission.value/100;
						var b=0;
						b=c*0.91;
						lineCommission=((lineCost/(a-b))*0.91)*c;
					}
					else{
						lineCommission=lineCost/(1-(document.form1.margin.value/100)-(document.form1.globalCommission.value/100))*(document.form1.globalCommission.value/100)
					}
				}
				else{
					lineCommission=0;
				}
				globalComm=globalComm+lineCommission;
				lineCost=lineCost+lineCommission;
				linePrice=lineCost/(1-(document.form1.margin.value/100))+document.form1.coordinationDollar.value*1;
				document.form1.unitprice.value=linePrice/document.form1.qty.value*1;
				document.form1.price.value=linePrice;
				document.form1.commission.value=lineCommission;
				globalPrice=globalPrice+linePrice;
			}
			//alert("4");
			document.form1.globalPrice.value=globalPrice;
			document.form1.globalCommissionDollar.value=globalComm;
			document.form1.globalMargin.value=((globalPrice-globalComm-globalCost)/globalPrice)*100;
			document.form1.csadsCount.value=1;
			//alert("5");
			init();
		}
		function init(){
			//alert("HERE");
			if(document.form1.csadsCount.value==0){
				priceChange();
			}
			if(document.form1.globalMargin.value.length=0){
				document.form1.globalMargin.value=0.00;
			}
			else{
				document.form1.globalMargin.value=(Math.round(document.form1.globalMargin.value*100)/100);
			}
			if(document.form1.globalPrice.value.length=0){
				document.form1.globalPrice.value=0.00;
				document.form1.globalCanPrice.value=0.00;
			}
			else{
				document.form1.globalPrice.value=(Math.round(document.form1.globalPrice.value*100)/100);
				document.form1.globalCanPrice.value=(Math.round(document.form1.globalPrice.value*document.form1.exchRate.value*100)/100);
			}
			if(document.form1.globalCommissionDollar.value.length=0){
				document.form1.globalCommissionDollar.value=0.00;
			}
			else{
				document.form1.globalCommissionDollar.value=(Math.round(document.form1.globalCommissionDollar.value*100)/100);
			}
			if(document.form1.globalCommission.value.length=0){
				document.form1.globalCommission.value=0.00;
			}
			else{
				document.form1.globalCommission.value=(Math.round(document.form1.globalCommission.value*100)/100);
			}
			if(document.form1.globalFreight.value.length=0){
				document.form1.globalFreight.value=0.00;
			}
			else{
				document.form1.globalFreight.value=(Math.round(document.form1.globalFreight.value*100)/100);
			}
			if(document.form1.globalCatchall.value.length=0){
				document.form1.globalCatchall.value=0.00;
			}
			else{
				document.form1.globalCatchall.value=(Math.round(document.form1.globalCatchall.value*100)/100);
			}
			if(document.form1.globalProjectMgmt.value.length=0){
				document.form1.globalProjectMgmt.value=0.00;
			}
			else{
				document.form1.globalProjectMgmt.value=(Math.round(document.form1.globalProjectMgmt.value*100)/100);
			}
			if(document.form1.projectMgmtHours.value.length=0){
				document.form1.projectMgmtHours.value=0.00;
			}
			else{
				document.form1.projectMgmtHours.value=(Math.round(document.form1.projectMgmtHours.value*100)/100);
			}
			if(document.form1.globalLayout.value.length=0){
				document.form1.globalLayout.value=0.00;
			}
			else{
				document.form1.globalLayout.value=(Math.round(document.form1.globalLayout.value*100)/100);
			}
			if(document.form1.layoutHours.value.length=0){
				document.form1.layoutHours.value=0.00;
			}
			else{
				document.form1.layoutHours.value=(Math.round(document.form1.layoutHours.value*100)/100);
			}
			if(document.form1.globalDrafting.value.length=0){
				document.form1.globalDrafting.value=0.00;
			}
			else{
				document.form1.globalDrafting.value=(Math.round(document.form1.globalDrafting.value*100)/100);
			}
			if(document.form1.draftingHours.value.length=0){
				document.form1.draftingHours.value=0.00;
			}
			else{
				document.form1.draftingHours.value=(Math.round(document.form1.draftingHours.value*100)/100);
			}
			if(document.form1.countx.value>1){
				for(var ii=0;ii<document.form1.countx.value;ii++){

					if(document.form1.qty[ii].value.length=0){
						document.form1.qty[ii].value=0.00;
					}
					else{
						document.form1.qty[ii].value=(Math.round(document.form1.qty[ii].value*100)/100);
					}
					if(document.form1.cost[ii].value.length=0){
						document.form1.cost[ii].value=0.00;
					}
					else{
						document.form1.cost[ii].value=(Math.round(document.form1.cost[ii].value*100)/100);
					}
					if(document.form1.margin[ii].value.length=0){
						document.form1.margin[ii].value=0.00;
					}
					else{
						document.form1.margin[ii].value=(Math.round(document.form1.margin[ii].value*100)/100);
					}
					if(document.form1.drafting[ii].value.length=0){
						document.form1.drafting[ii].value=0.00;
					}
					else{
						document.form1.drafting[ii].value=(Math.round(document.form1.drafting[ii].value*100)/100);
					}
					if(document.form1.layout[ii].value.length=0){
						document.form1.layout[ii].value=0.00;
					}
					else{
						document.form1.layout[ii].value=(Math.round(document.form1.layout[ii].value*100)/100);
					}
					if(document.form1.projectMgmt[ii].value.length=0){
						document.form1.projectMgmt[ii].value=0.00;
					}
					else{
						document.form1.projectMgmt[ii].value=(Math.round(document.form1.projectMgmt[ii].value*100)/100);
					}
					if(document.form1.catchall[ii].value.length=0){
						document.form1.catchall[ii].value=0.00;
					}
					else{
						document.form1.catchall[ii].value=(Math.round(document.form1.catchall[ii].value*100)/100);
					}
					if(document.form1.freight[ii].value.length=0){
						document.form1.freight[ii].value=0.00;
					}
					else{
						document.form1.freight[ii].value=(Math.round(document.form1.freight[ii].value*100)/100);
					}
					if(document.form1.commission[ii].value.length=0){
						document.form1.commission[ii].value=0.00;
					}
					else{
						document.form1.commission[ii].value=(Math.round(document.form1.commission[ii].value*100)/100);
					}
					if(document.form1.coordinationDollar[ii].value.length=0){
						document.form1.coordinationDollar[ii].value=0.00;
					}
					else{
						document.form1.coordinationDollar[ii].value=(Math.round(document.form1.coordinationDollar[ii].value*100)/100);
					}
					if(document.form1.price[ii].value.length=0){
						document.form1.price[ii].value=0.00;
					}
					else{
						document.form1.price[ii].value=(Math.round(document.form1.price[ii].value*100)/100);
					}
					if(document.form1.coordination[ii].value.length=0){
						document.form1.coordination[ii].value=0;
					}
					else{
						document.form1.coordination[ii].value=(Math.round(document.form1.coordination[ii].value));
					}
				}
			}
			else{
				if(document.form1.qty.value.length=0){
					document.form1.qty.value=0.00;
				}
				else{
					document.form1.qty.value=(Math.round(document.form1.qty.value*100)/100);
				}
				if(document.form1.cost.value.length=0){
					document.form1.cost.value=0.00;
				}
				else{
					document.form1.cost.value=(Math.round(document.form1.cost.value*100)/100);
				}
				if(document.form1.margin.value.length=0){
					document.form1.margin.value=0.00;
				}
				else{
					document.form1.margin.value=(Math.round(document.form1.margin.value*100)/100);
				}
				if(document.form1.drafting.value.length=0){
					document.form1.drafting.value=0.00;
				}
				else{
					document.form1.drafting.value=(Math.round(document.form1.drafting.value*100)/100);
				}
				if(document.form1.layout.value.length=0){
					document.form1.layout.value=0.00;
				}
				else{
					document.form1.layout.value=(Math.round(document.form1.layout.value*100)/100);
				}
				if(document.form1.projectMgmt.value.length=0){
					document.form1.projectMgmt.value=0.00;
				}
				else{
					document.form1.projectMgmt.value=(Math.round(document.form1.projectMgmt.value*100)/100);
				}
				if(document.form1.catchall.value.length=0){
					document.form1.catchall.value=0.00;
				}
				else{
					document.form1.catchall.value=(Math.round(document.form1.catchall.value*100)/100);
				}
				if(document.form1.freight.value.length=0){
					document.form1.freight.value=0.00;
				}
				else{
					document.form1.freight.value=(Math.round(document.form1.freight.value*100)/100);
				}
				if(document.form1.commission.value.length=0){
					document.form1.commission.value=0.00;
				}
				else{
					document.form1.commission.value=(Math.round(document.form1.commission.value*100)/100);
				}
				if(document.form1.coordinationDollar.value.length=0){
					document.form1.coordinationDollar.value=0.00;
				}
				else{
					document.form1.coordinationDollar.value=(Math.round(document.form1.coordinationDollar.value*100)/100);
				}
				if(document.form1.price.value.length=0){
					document.form1.price.value=0.00;
				}
				else{
					document.form1.price.value=(Math.round(document.form1.price.value*100)/100);
				}
				if(document.form1.coordination.value.length=0){
					document.form1.coordination.value=0;
				}
				else{
					document.form1.coordination.value=(Math.round(document.form1.coordination.value));
				}
			}
			//alert("after");

		}
		function refresh(){
			draftingHoursChange();
			layoutHoursChange();
			projectMgmtHoursChange();
			globalCatchallChange();
			globalCoordinationChange();
			freightCrate();
			priceChange();
			init();
		}
		function resetx(){

			document.form1.draftingHours.value=0;
			document.form1.layoutHours.value=0;
			document.form1.projectMgmtHours.value=0;
			document.form1.globalCatchall.value=0;
			document.form1.globalFreight.value=0;
			document.form1.globalCoordination.value=0;
			document.form1.globalCommission.value=document.form1.defaultCommission.value;
			if(document.form1.countx.value>1){
				for(var ii=0;ii<document.form1.countx.value;ii++){
					document.form1.margin[ii].value=document.form1.defaultMargin[ii].value;
				}
			}
			else{
				document.form1.margin.value=document.form1.defaultMargin.value;
			}
			refresh();
		}
	</script>

	<%@ page language="java" import="java.sql.*" import="java.util.*" import="java.text.*" errorPage="error.jsp" %>
	<%@ include file="../../../db_con.jsp"%>
	<%
	NumberFormat for1 = NumberFormat.getInstance();
	for1.setMaximumFractionDigits(2);
	for1.setMinimumFractionDigits(2);
	NumberFormat for2 = NumberFormat.getInstance();
	for2.setMaximumFractionDigits(0);
	for2.setMinimumFractionDigits(0);
	String ordertype= request.getParameter("type");//type
	String order_no = request.getParameter("q_no");
	String q_no=order_no;
	String message="<font color='blue'>Pricing For Job No "+q_no+"<font>";
String name=userSession.getUserId();
	%>
	<%//@ include file="rqs_head.jsp"%>
	<%
	String DESC=request.getParameter("DESC");
	String ADD=request.getParameter("ADD");
	String SECT=request.getParameter("SECT");
	String DATE=request.getParameter("DATE");
	String CSDECO=request.getParameter("CSDECO");
	String layoutRate="";
	String draftingRate="";
	String projectMgmtRate="";
	String globalCatchall="";
	String globalDrafting="";
	String globalLayout="";
	String globalProjectMgmt="";
	String globalCoordination="";
	String globalFreight="";
	String globalMargin="";
	String globalPrice="";
	String globalCanPrice="";
	String globalCost="";
	String globalCommissionDollar="";
	String draftingHours="";
	String layoutHours="";
	String projectMgmtHours="";
	message="";
	String globalCommission="";
	String selected="";
	String defaultCommission="";
	String freightCommFactor="";
	double fcperc=0;
	double costTotal=0;
	String exch="";
	double exchRate=0;

	int csquoteCount=0;
	int csadsCount=0;

	boolean readValue=false;
	//coordination
	Vector coordinationLevel=new Vector();
	Vector charge=new Vector();

	//csquotes
	Vector costPerc = new Vector();
	Vector block_id = new Vector();
	Vector model=new Vector();
	Vector qty=new Vector();
	Vector cost = new Vector();
	Vector field = new Vector();

	//cs_ads_price_calc
	Vector model2=new Vector();
	Vector qty2=new Vector();
	Vector cost2=new Vector();
	Vector catchall=new Vector();
	Vector drafting=new Vector();
	Vector layout=new Vector();
	Vector projectMgmt=new Vector();
	Vector coordination=new Vector();
	Vector coordinationDollar=new Vector();
	Vector defaultMargin=new Vector();
	Vector margin = new Vector();
	Vector linePrice=new Vector();
	Vector freight=new Vector();
	Vector commission=new Vector();

	ResultSet rsCo=stmt.executeQuery("select * from cs_ads_coordination order by coordination");
	if(rsCo != null){
		while(rsCo.next()){

			coordinationLevel.addElement(rsCo.getString("coordination"));
			charge.addElement(rsCo.getString("charge"));
			//out.println("1::"+rsCo.getString("coordination")+"::"+rsCo.getString("charge")+"<BR><BR>");
		}
	}
	rsCo.close();
	ResultSet rs0=stmt.executeQuery("select * from cs_defaults where product_id='ADS'");
	if(rs0 != null){
		while(rs0.next()){
			draftingRate=rs0.getString("enghrrate");
			layoutRate=rs0.getString("hrrate");
			projectMgmtRate=rs0.getString("pmhrrate");
			fcperc=new Double(rs0.getString("fcperc")).doubleValue();
			//out.println("2::"+rs0.getString("enghrrate")+"<BR");
		}//
	}
	rs0.close();
	ResultSet rsProject=stmt.executeQuery("select exch_name,exch_rate from cs_project where order_no='"+order_no+"'");
	if(rsProject != null){
		while(rsProject.next()){
			exch=rsProject.getString("exch_name");
			exchRate=rsProject.getDouble("exch_rate");
		}
	}
	rsProject.close();
//out.println(exchRate+"::"+exch);
	try{
	ResultSet rsCSQUOTES=stmt.executeQuery("select field18,sum(cast(field19 as decimal)), sum(cast(extended_price as float)) from csquotes where order_no='"+order_no+"' and not block_id ='A_APRODUCT' and not field19='' group by field18 order by field18");
	if(rsCSQUOTES != null){
		while(rsCSQUOTES.next()){
			//block_id.addElement(rsCSQUOTES.getString(1));
			//out.println(rsCSQUOTES.getString(1)+"::"+rsCSQUOTES.getString(2)+"<BR>");
			//out.println("3::"+rsCSQUOTES.getString(1)+"::"+rsCSQUOTES.getString(2)+"::"+rsCSQUOTES.getString(3));
			model.addElement(rsCSQUOTES.getString(1));
			qty.addElement(rsCSQUOTES.getString(2));
			cost.addElement(rsCSQUOTES.getString(3));
			String temp="";
			if(CSDECO.equals("I")){
				temp="IC";
			}
			else{
				if(CSDECO.equals("D")){
					temp="DECO";
				}
				else{
					temp="CS";
				}
				if(new Double(rsCSQUOTES.getString(2)).doubleValue()<=30){
					temp=temp+"30";
				}
				else if(new Double(rsCSQUOTES.getString(2)).doubleValue()< 100){
					temp=temp+"99";
				}
				else{
					temp=temp+"100";
				}
			}
			field.addElement(temp);
			csquoteCount++;
			costTotal=costTotal+new Double(rsCSQUOTES.getString(3)).doubleValue();
		}
	}
	rsCSQUOTES.close();
	}
	catch(Exception e){
		out.println("CSQUOTES ERROR:::"+e);
	}

	ResultSet rs=stmt.executeQuery("select * from cs_ads_price_calc where order_no='"+order_no+"' and model='GLOBAL'");
	if(rs != null){
		if(rs.next()){
			if(rs.getString("catchall") != null){
				globalCatchall=rs.getString("catchall");
			}
			if(rs.getString("draftingDollars") != null){
				globalDrafting=rs.getString("draftingDollars");
			}
			if(rs.getString("layoutDollars") != null){
				globalLayout=rs.getString("layoutDollars");
			}
			if(rs.getString("projectMgmtDollars") != null){
				globalProjectMgmt=rs.getString("projectMgmtDollars");
			}
			if(rs.getString("coordination") != null){
				globalCoordination=rs.getString("coordination");
			}

			if(rs.getString("freight") != null){
				globalFreight=rs.getString("freight");
			}
			if(rs.getString("margin") != null){
				globalMargin=rs.getString("margin");
			}
			if(rs.getString("linePrice") != null){
				globalPrice=rs.getString("linePrice");
			}
			if(rs.getString("canLinePrice") != null){
				globalCanPrice=rs.getString("canLinePrice");
			}
			if(rs.getString("cost") != null){
				globalCost=rs.getString("cost");
			}
			if(rs.getString("commissionDollars") != null){
				globalCommissionDollar=rs.getString("commissionDollars");
			}
			if(rs.getString("commission") != null){
				globalCommission=rs.getString("commission");
			}

			if(rs.getString("drafting") != null){
				draftingHours=rs.getString("drafting");
			}
			if(rs.getString("layout") != null){
				layoutHours=rs.getString("layout");
			}
			if(rs.getString("projectMgmt") != null){
				projectMgmtHours=rs.getString("projectMgmt");
			}
		}
	}
	rs.close();
	if(globalCommission == null || globalCommission.trim().length()<1){
		if(CSDECO.startsWith("C")){
			globalCommission="10";

		}
		else if(CSDECO.startsWith("I")){
			globalCommission="0";

		}
		else{
			globalCommission="12";

		}
	}

	if(CSDECO.startsWith("C")){
		defaultCommission="10";
		freightCommFactor="0.091";
	}
	else if(CSDECO.startsWith("I")){
		defaultCommission="0";
freightCommFactor="0";

	}
	else{
		defaultCommission="12";
		freightCommFactor="0.12";
	}

	ResultSet rs1=stmt.executeQuery("select * from cs_ads_price_calc where order_no='"+order_no+"' and not model='GLOBAL' order by model");
	if(rs1 != null){
		while(rs1.next()){
			model2.addElement(rs1.getString("model"));
			qty2.addElement(rs1.getString("qty"));
			cost2.addElement(rs1.getString("cost"));
			catchall.addElement(rs1.getString("catchall"));
			drafting.addElement(rs1.getString("drafting"));
			layout.addElement(rs1.getString("layout"));
			projectMgmt.addElement(rs1.getString("projectMgmt"));
			coordination.addElement(rs1.getString("coordination"));
			coordinationDollar.addElement(rs1.getString("coordinationDollars"));
			margin.addElement(""+new Double(rs1.getString("margin")).doubleValue()/100);
			out.println(rs1.getString("margin")+"::"+rs1.getString("commission")+"::<BR>");
			linePrice.addElement(rs1.getString("linePrice"));
			freight.addElement(rs1.getString("freight"));
			commission.addElement(rs1.getString("commission"));
			csadsCount++;
			readValue=true;
		}
	}
	rs1.close();

	if(readValue){
		if(csadsCount==csquoteCount){
			for(int i=0; i<model.size(); i++){
				if(model.elementAt(i).toString().equals(model2.elementAt(i).toString())){

					if(new Double(qty.elementAt(i).toString()).doubleValue()==new Double(qty2.elementAt(i).toString()).doubleValue()){
						//out.println(cost.elementAt(i).toString()+"::"+cost2.elementAt(i).toString()+"<BR>");
						if(for1.format(new Double(cost.elementAt(i).toString()).doubleValue()).equals(for1.format(new Double(cost2.elementAt(i).toString()).doubleValue()))){
							readValue=true;
						}
						else{
							readValue=false;
							message="cost has changed" ;
						}


					}
					else{
						readValue=false;
						message="qty's have changed";
					}

				}
				else{
					readValue=false;
					message="model has changed";
				}
			}
		}
		else{
			readValue=false;
			message="Number of models has changed.";
		}
	}
	else{
		message="";
	}
	for(int yy=0; yy<model.size(); yy++){
		String sqlx="select "+field.elementAt(yy).toString()+" from cs_ads_margin where model='"+model.elementAt(yy).toString()+"'";
		ResultSet rsMarginx=stmt.executeQuery(sqlx);
		if(rsMarginx != null){
			while(rsMarginx.next()){
				defaultMargin.addElement(""+new Double(rsMarginx.getString(1)).doubleValue()*100);
			}
		}
		rsMarginx.close();
	}
	//out.println(defaultMargin+"::<BR>");
	//out.println("HERE2"+readValue);
	if(!readValue){
		int test=0;
		test=margin.size();

		for(int y=0; y<model.size(); y++){

			//out.println(y+"::HERE<BR>");
			String sql="select "+field.elementAt(y).toString()+" from cs_ads_margin where model='"+model.elementAt(y).toString()+"'";
			//out.println(sql+"::"+test+"::");

			ResultSet rsMargin=stmt.executeQuery(sql);
			//out.println(sql+"<BR>");
			if(rsMargin != null){
				while(rsMargin.next()){
					if(rsMargin.getString(1) != null){
						//out.println(y+"::"+margin.size()+"::"+test+"::"+rsMargin.getString(1)+"::"+y+"::"+model.elementAt(y).toString()+"::HERE<BR>");
						//out.println(test+"::"+y+"::<BR>");

						if(test>0&&y<test){
							margin.setElementAt(rsMargin.getString(1),y);
						}
						else{
							margin.addElement(rsMargin.getString(1));
						}

						//out.println("xxx");
					}
				}
			}
			rsMargin.close();

			//out.println("HERE1");
			//out.println("<BR>");

			if(globalCoordination != null && globalCoordination.trim().length()>0&&csadsCount<1){
			//out.println("HERE2");
				if((model.elementAt(y).toString().equals("EDGE")||model.elementAt(y).toString().equals("KP")||model.elementAt(y).toString().equals("LFK"))){
					coordination.addElement("0");
					coordinationDollar.addElement("0");
					//out.println(model.elementAt(y).toString()+":::HERE<BR>");
				}
				else{
					double tempx=0;
					tempx=new Double(charge.elementAt((int)new Double(globalCoordination).doubleValue()).toString()).doubleValue()*new Double(qty.elementAt(y).toString()).doubleValue();
					coordination.addElement(globalCoordination);
					coordinationDollar.addElement(""+tempx);
				}
				//out.println("HERE3");
			}
			else if(globalCoordination != null && globalCoordination.trim().length()>0){
				//out.println("HERE4");
				if(globalCoordination.equals("0.00")||(model.elementAt(y).toString().equals("EDGE")||model.elementAt(y).toString().equals("KP")||model.elementAt(y).toString().equals("LFK"))){
					//out.println("a");
					if(coordinationDollar.size()<y){
						coordinationDollar.setElementAt("0",y);
						coordination.setElementAt("0",y);
					//out.println("b");
					}
					else{
						coordinationDollar.addElement("0");
						coordination.addElement("0");
					}
				}
				else{
					//out.println("c");
					double tempx=0;
					//out.println("d"+(int)new Double(globalCoordination).doubleValue());
					tempx=new Double(charge.elementAt((int)new Double(globalCoordination).doubleValue()).toString()).doubleValue()*new Double(qty.elementAt(y).toString()).doubleValue();
					//out.println("e");
					if(coordinationDollar.size()<y){
						coordinationDollar.setElementAt(""+tempx,y);
						//out.println("f");
						coordination.setElementAt(globalCoordination,y);
					}
					else{
						coordinationDollar.addElement(""+tempx);
						coordination.addElement(globalCoordination);
					}
				}
			}

		}

	}
	//out.println("HERE21");
	//out.println("HERE2");

	if(!readValue){
	//out.println("HERE");
	%>
	<body onload='refresh();'>
		<%
	}
	else{
//out.println("HERE2");
		%>
	<body onload='init();'>
		<%
	}

	out.println(message);
	out.println("<form name='form1' action='ads_price_calc_page3.jsp' method='post'>");
	for(int z=0; z<charge.size(); z++){
		out.println("<input type='hidden' name='charge' value='"+charge.elementAt(z).toString()+"'>");
	}
	out.println("<input type='hidden' name='exch' value='"+exch+"'>");
	out.println("<input type='hidden' name='exchRate' value='"+exchRate+"'>");
	out.println("<input type='hidden' name='fcperc' value='"+fcperc+"'>");
	out.println("<input type='hidden' name='order_no' value='"+order_no+"'>");
	out.println("<input type='hidden' name='defaultCommission' value='"+defaultCommission+"'>");
	out.println("<input type='hidden' name='DESC' value='"+DESC+"'>");
	out.println("<input type='hidden' name='ADD' value='"+ADD+"'>");
	out.println("<input type='hidden' name='SECT' value='"+SECT+"'>");
	out.println("<input type='hidden' name='DATE' value='"+DATE+"'>");
	out.println("<input type='hidden' name='CSDECO' value='"+CSDECO+"'>");
	out.println("<input type='hidden' name='layoutRate' value='"+layoutRate+"'>");
	out.println("<input type='hidden' name='draftingRate' value='"+draftingRate+"'>");
	out.println("<input type='hidden' name='projectMgmtRate' value='"+projectMgmtRate+"'>");
	out.println("<input type='hidden' name='countx' value='"+csquoteCount+"'>");
	out.println("<input type='hidden' name='csadsCount' value='"+csadsCount+"'>");
	out.println("<input type='hidden' name='freightCommFactor' value='"+freightCommFactor+"'>");
	out.println("<table border='1' width='100%'>");

	out.println("<tr><td colspan='6' align='center'>Global</td></tr>");
	out.println("<tr><td>Drafting</td><td>hrs<input type='text' size='10' name='draftingHours' value='"+draftingHours+"' onchange='draftingHoursChange()'>$<input type='text' size='10' name='globalDrafting' value='"+globalDrafting+"' onchange='globalDraftingChange()'></td>");
	out.println("<td>Layout</td><td>hrs<input type='text' size='10' name='layoutHours' value='"+layoutHours+"' onchange='layoutHoursChange()'>$<input type='text' size='10' name='globalLayout' value='"+globalLayout+"' onchange='globalLayoutChange()'></td>");
	out.println("<td>Project Management</td><td>hrs<input type='text' size='10' name='projectMgmtHours' value='"+projectMgmtHours+"' onchange='projectMgmtHoursChange()'>$<input type='text' size='10' name='globalProjectMgmt' value='"+globalProjectMgmt+"' onchange='globalProjectMgmtChange()'></td></tr>");
	out.println("<tr><td>Catchall</td><td>$<input type='text' size='10' name='globalCatchall' value='"+globalCatchall+"' onchange='globalCatchallChange()'></td>");
	out.println("<td>Freight and Crate</td><td>$<input type='text' size='10' name='globalFreight' value='"+globalFreight+"' onchange='globalFreightChange()'></td>");
	out.println("<td>Commission</td><td>%<input type='text' size='10' name='globalCommission' value='"+globalCommission+"' onchange='priceChange()'>$<input type='text' size='10' name='globalCommissionDollar' value='"+globalCommissionDollar+"' readonly class='notext1'></td></tr>");
	out.println("<tr><td>Coordination</td><td>");
	//out.println(globalCoordination+"::::<BR>");
		out.println("<select name='globalCoordination' onchange='globalCoordinationChange()'>");
			//out.println("<option value=''></option>");
			if(globalCoordination.equals("0.00")){ selected="selected";}
			out.println("<option value='0' "+selected+">By Others</option>");
			selected="";
			if(globalCoordination.equals("1.00")){ selected="selected";}
			out.println("<option value='1' "+selected+">No Frames</option>");
			selected="";
			if(globalCoordination.equals("2.00")){ selected="selected";}
			out.println("<option value='2' "+selected+">Existing Frames</option>");
		out.println("</select>");
	out.println("</td>");
	out.println("<td>Price</td><td>$<input type='text' size='10' name='globalPrice' value='"+globalPrice+"' readonly class='notext1'>");
	if(exchRate>0 && exchRate!=1){
		out.println(exch+"<input type='text' size='10' name='globalCanPrice' value='"+globalCanPrice+"' readonly class='notext1'>");
	}
	else{
		out.println(exch+"<input type='hidden' name='globalCanPrice' value='"+globalCanPrice+"' >");
	}
	out.println("</td>");
	out.println("<td>Margin</td><td>%<input type='text' size='10' name='globalMargin' value='"+globalMargin+"' readonly class='notext1'></td></tr>");

	out.println("</table>");
	out.println("<table border='1' width='100%'>");
	out.println("<tr><td colspan='13' align='center'>Model Specifics</td></tr>");
	out.println("<tr><td>Model</td><td>Qty</td><td>Cost($)</td><td>Margin(%)</td><td>Drafting($)</td><td>Layout($)</td><td>Project Mgmt($)</td><td>Catchall($)</td><td>F&C($)</td><td>Comm($)</td><td>Coordination</td><td>Unit Price($)</td><td>Price($)</td></tr>");
	double perc=0;
	for(int x=0; x<model.size(); x++){
		out.println("<input type='hidden' name='defaultMargin' value='"+defaultMargin.elementAt(x).toString()+"'>");
//out.println(cost.elementAt(x).toString()+"::"+costTotal);
		double temp=new Double(cost.elementAt(x).toString()).doubleValue()/costTotal;
		costPerc.addElement(""+temp);
		out.println("<tr>");
		//out.println(margin.elementAt(x).toString()+"::HEREx<BR>");
		out.println("<td><input type='text' size='8' name='model' value='"+model.elementAt(x).toString()+"' readonly class='notext1'>");
		out.println("<input type='hidden' name='costPerc' value='"+costPerc.elementAt(x).toString()+"' ></td>");
		out.println("<td><input type='text' size='3' name='qty' value='"+qty.elementAt(x).toString()+"' readonly class='notext1'></td>");
		out.println("<td><input type='text' size='6' name='cost' value='"+cost.elementAt(x).toString()+"' readonly class='notext1'></td>");
		out.println("<td><input type='text' size='3' name='margin' value='"+new Double(margin.elementAt(x).toString()).doubleValue()*100+"' onchange='freightCrate()'></td>");
		if(readValue){
			out.println("<td><input type='text' size='7' name='drafting' value='"+drafting.elementAt(x).toString()+"' onchange='draftChange()'></td>");
			out.println("<td><input type='text' size='7' name='layout' value='"+layout.elementAt(x).toString()+"' onchange='layoutChange()'></td>");
			out.println("<td><input type='text' size='7' name='projectMgmt' value='"+projectMgmt.elementAt(x).toString()+"' onchange='projectMgmtChange()'></td>");
			out.println("<td><input type='text' size='7' name='catchall' value='"+catchall.elementAt(x).toString()+"' onchange='catchallChange()'></td>");
			out.println("<td><input type='text' size='7' name='freight' value='"+freight.elementAt(x).toString()+"' onchange='freightChange()'></td>");
			out.println("<td><input type='text' size='7' name='commission' value='"+commission.elementAt(x).toString()+"' readonly class='notext1'></td>");
			out.println("<td><input type='text' size='1' name='coordination' value='"+coordination.elementAt(x).toString()+"' readonly class='notext1'>$<input type='text' size='1' name='coordinationDollar' value='"+coordinationDollar.elementAt(x).toString()+"' readonly class='notext1'></td>");
			out.println("<td><input type='text' size='7' name='unitprice' value='"+for1.format(new Double(linePrice.elementAt(x).toString()).doubleValue()/new Double(qty.elementAt(x).toString()).doubleValue())+"' readonly class='notext1'></td>");
			out.println("<td><input type='text' size='7' name='price' value='"+linePrice.elementAt(x).toString()+"' readonly class='notext1'></td>");
		}
		else{
			out.println("<td><input type='text' size='7' name='drafting' value='&nbsp;' onchange='draftChange()'></td>");
			out.println("<td><input type='text' size='7' name='layout' value='&nbsp;' onchange='layoutChange()'></td>");
			out.println("<td><input type='text' size='7' name='projectMgmt' value='&nbsp;' onchange='projectMgmtChange()'></td>");
			out.println("<td><input type='text' size='7' name='catchall' value='&nbsp;' onchange='catchallChange()'></td>");
			out.println("<td><input type='text' size='7' name='freight' value='&nbsp;' onchange='freightChange()'></td>");
			out.println("<td><input type='text' size='7' name='commission' value='&nbsp;' readonly class='notext1'></td>");
			out.println("<td><input type='text' size='1' name='coordination' value='&nbsp;' readonly class='notext1'>$<input type='text' size='1' name='coordinationDollar' value='&nbsp;' readonly class='notext1'></td>");
			out.println("<td><input type='text' size='7' name='unitprice' value='&nbsp;' readonly class='notext1'></td>");
			out.println("<td><input type='text' size='7' name='price' value='&nbsp;' readonly class='notext1'></td>");
		}
		out.println("</tr>");
	}
	out.println("<tr><td colspan='13'><input type='submit' value='Submit'><input type='button' name='reset' value='Reset' onclick='resetx()'></td></tr>");
	out.println("</table>");

	stmt.close();
	myConn.close();

		%>
	</body>
</html>
<%
}
  catch(Exception e){
	out.println("ERROR::"+e);
  }
%>