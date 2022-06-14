<jsp:useBean id="erapidBean" class="com.csgroup.general.ErapidBean" scope="application"/>
<jsp:useBean id="convertor" class="com.csgroup.general.Convertor" scope="application"/>
<jsp:useBean id="userSession" class="com.csgroup.general.UserSession" scope="application"/>
<script language="JavaScript" src="../../javascript/ajax.js"></script>
<%
if(erapidBean.getServerName()==null||erapidBean.getServerName().equals("null")||erapidBean.getServerName().trim().length()==0){
        erapidBean.setServerName("server1");
}
try{
%>
<html>
	<head>
		<title>Access Central</title>

		<link rel='stylesheet' href='style1.css' type='text/css' />
	</head>

	<SCRIPT LANGUAGE="JavaScript">

		try{
			function checkCanada(hrrate,enghrrate,pmhrrate){
				checkFreightOverride();
				if(document.displayForm.group.value=="CanEstim"&&document.displayForm.countRows.value<1){
					var newValue=document.displayForm.pIndTOTWT.value*0.1;
					var newValue2=Math.round(document.displayForm.pIndTOTWT.value*0.65);
					newValue=newValue+newValue2;
					alert("Bonjour Canada!!!");
					document.displayForm.pInfFC.value=newValue.toFixed(2);
					hoursChange(hrrate,enghrrate,pmhrrate);
				}
				if(document.displayForm.pInfCOST.value>50000&&document.displayForm.pInfPMHOURS.value==0){
                                    //alert("HERE");
					calcProject();
				}
				if(document.displayForm.interco.value=="on"){
					document.displayForm.pInfFC.value=(0.1*document.displayForm.pIndTOTWT.value).toFixed(2);
					hoursChange(document.displayForm.dh_rate.value,document.displayForm.eh_rate.value,document.displayForm.pm_rate.value);
					document.displayForm.pInfCOMMPERC.value="0";
					commChange();
					document.displayForm.pInfMARGPERC.value="20";
					margChange();
				}
				//if(document.displayForm.city.value=="Honolulu"&&document.displayForm.state.value=="HI"&&document.displayForm.exportCrate.value==0){
                               
				if(((document.displayForm.city.value=="Honolulu"&&document.displayForm.state.value=="HI") || document.displayForm.state.value=="NL" || document.displayForm.state.value=="PE" || document.displayForm.state.value=="NS" || document.displayForm.state.value=="NB" || document.displayForm.state.value=="QC" || document.displayForm.state.value=="ON" || document.displayForm.state.value=="MB" || document.displayForm.state.value=="SK" || document.displayForm.state.value=="AB" || document.displayForm.state.value=="BC" || document.displayForm.state.value=="YT" || document.displayForm.state.value=="NT" || document.displayForm.state.value=="NU" )&&document.displayForm.exportCrate.value==0){        
//alert("IS Canada or HI");
					calcExport();
                                           if(document.displayForm.VS_ID.value=="GRILLE"){
                                       //  alert("HI QUOTe"+document.displayForm.VS_ID.value);
                                         calcExportGrille();
                                           }
				}
			}
			function checkFreightOverride(){
				if(document.displayForm.manualFreight.value!="Y"){
					if(document.displayForm.pIndTOTWT.value>100000){
						alert("FREIGHT OVER 100,000 POUND MUST BE ENTERED MANUALLY");
					}
				}
			}
			function markOverride(a,b,c){
				document.displayForm.manualFreight.value="Y";
			}
			function resetForm(){
				window.location=document.displayForm.urlReset.value;
				//window.location ="access_central_calc.jsp?reset=yes&q_no="+document.displayForm.order_no.value+"&type="+document.displayForm.ordertype.value+"&reset=yes&cityx="+document.displayForm.city.value+"&statex="+document.displayForm.state.value;
			}
			function freightChange(hrrate,enghrrate,pmhrrate){
				
				document.displayForm.pInfFC.value=document.displayForm.pInfFREIGHT.value*1+document.displayForm.pInfCRATE.value*1+document.displayForm.exportCrate.value*1;
				
				hoursChange(hrrate,enghrrate,pmhrrate);
			}
			function startScript(){
				var pInfALLHOURS=document.displayForm.pInfDHOURS.value+", "+document.displayForm.pInfLHOURS.value+", "+document.displayForm.pInfEHOURS.value+", "+document.displayForm.pInfPMHOURS.value;
				document.displayForm.pInfALLHOURS.value=pInfALLHOURS;
				var pInfFCPERC=(document.displayForm.pInfFC.value/document.displayForm.pInfSELLPRICE.value*100*100.0)/100;
				document.displayForm.pInfFCPERC.value=pInfFCPERC.toFixed(2);
				var pInfSUBTOTAL=(document.displayForm.pInfCOST.value)*1+document.displayForm.pInfADMINDOLLARS.value*1+document.displayForm.pInfFC.value*1+document.displayForm.pInfCATCHALL.value*1;// * 100.0) / 100;
				document.displayForm.pInfSUBTOTAL.value=pInfSUBTOTAL.toFixed(2);
				var pInfCOMMFCPERC=(document.displayForm.pInfCOMMDOLLARS.value*1/document.displayForm.pInfSELLPRICE.value*1*100*100.0)/100;
				document.displayForm.pInfCOMMFCPERC.value=pInfCOMMFCPERC.toFixed(2);
			}
			function endScript(){

				var pInfADMINPERC=(document.displayForm.pInfADMINDOLLARS.value*1/document.displayForm.pInfSELLPRICE.value*1*100*100.0)/100;
				document.displayForm.pInfADMINPERC.value=pInfADMINPERC.toFixed(2);
				var pInfCATCHALLPERC=(document.displayForm.pInfCATCHALL.value*1/document.displayForm.pInfSELLPRICE.value*1*100*100.0)/100;
				document.displayForm.pInfCATCHALLPERC.value=pInfCATCHALLPERC.toFixed(2);
				var pInfSUBTOTPERC=(document.displayForm.pInfSUBTOTAL.value*1/document.displayForm.pInfSELLPRICE.value*1*100*100.0)/100.0;
				document.displayForm.pInfSUBTOTPERC.value=pInfSUBTOTPERC.toFixed(2);
				var pInfCOSTPERC=(document.displayForm.pInfCOST.value*1/document.displayForm.pInfSELLPRICE.value*1*100*100.0)/100;
				
				document.displayForm.pInfCOSTPERC.value=pInfCOSTPERC.toFixed(2);
				var pInfTOTAL=document.displayForm.pInfSELLPRICE.value*1+document.displayForm.pInfINSTALL.value*1;
				document.displayForm.pInfTOTAL.value=pInfTOTAL.toFixed(2);
				var pIndYIELD="";
				if(document.displayForm.pIndTOTWT.value==0){
					pIndYIELD=0;
				}
				else{
					pIndYIELD=(document.displayForm.pInfSELLPRICE.value*1/(document.displayForm.pIndTOTWT.value*1)*100.0)/100.0;
				}
				
				document.displayForm.pIndYIELD.value=pIndYIELD.toFixed(2);
				var pIndTOTSF=document.displayForm.VR_SQFT.value*1;
				document.displayForm.pIndTOTSF.value=pIndTOTSF.toFixed(2);
				var pIndDOLLARSF="";
				if(pIndTOTSF==0){
					pIndDOLLARSF=0.0;
				}
				else{
					pIndDOLLARSF=(document.displayForm.pInfSELLPRICE.value/pIndTOTSF*100.0)/100.0;
				}
				document.displayForm.pIndDOLLARSF.value=pIndDOLLARSF.toFixed(2);
				var pIndUNITPRICE=(document.displayForm.pInfSELLPRICE.value*1/document.displayForm.VR_TOTQTY.value*1*100.0)/100.0;
				document.displayForm.pIndUNITPRICE.value=pIndUNITPRICE.toFixed(2);


			}

			function hoursChange(hrrate,enghrrate,pmhrrate){
				startScript();
				var pInfALLHOURS=document.displayForm.pInfDHOURS.value+", "+document.displayForm.pInfLHOURS.value+", "+document.displayForm.pInfEHOURS.value+", "+document.displayForm.pInfPMHOURS.value;
				document.displayForm.pInfALLHOURS.value=pInfALLHOURS;
				var pInfD=document.displayForm.pInfDHOURS.value*1*hrrate*1;
				document.displayForm.pInfD.value=pInfD.toFixed(2);
				var pInfL=document.displayForm.pInfLHOURS.value*1*hrrate*1;
				document.displayForm.pInfL.value=pInfL.toFixed(2);
				var pInfE=document.displayForm.pInfEHOURS.value*1*enghrrate*1;
				document.displayForm.pInfE.value=pInfE.toFixed(2);
				var pInfP=document.displayForm.pInfPMHOURS.value*1*pmhrrate*1;
				document.displayForm.pInfP.value=pInfP.toFixed(2);
				var pInfTOTHOURS=(document.displayForm.pInfDHOURS.value*1+document.displayForm.pInfLHOURS.value*1+document.displayForm.pInfEHOURS.value*1+document.displayForm.pInfPMHOURS.value*1);
				document.displayForm.pInfTOTHOURS.value=pInfTOTHOURS.toFixed(2);
				var pInfADMINDOLLARS=pInfD*1+pInfE*1+pInfL*1+pInfP*1;
				document.displayForm.pInfADMINDOLLARS.value=pInfADMINDOLLARS.toFixed(2);
				var pInfSUBTOTAL=(document.displayForm.pInfCOST.value*1)+(document.displayForm.pInfADMINDOLLARS.value*1)+(document.displayForm.pInfFC.value*1)+(document.displayForm.pInfCATCHALL.value*1);
				document.displayForm.pInfSUBTOTAL.value=pInfSUBTOTAL.toFixed(2);
				var pInfSELLPRICE=((100*(pInfSUBTOTAL*1-document.displayForm.pInfFC.value*1*document.displayForm.pInfCOMMPERC.value*1/100.0))/(100.0-document.displayForm.pInfMARGPERC.value*1-document.displayForm.pInfCOMMPERC.value*1));
				document.displayForm.pInfSELLPRICE.value=pInfSELLPRICE.toFixed(2);
				var can=document.displayForm.pInfSELLPRICE.value*document.displayForm.exchRate.value;
				document.displayForm.pInfSELLPRICECAN.value=can.toFixed(2);
				var pInfCOMMDOLLARS=(pInfSELLPRICE*1*0.91*document.displayForm.pInfCOMMPERC.value*1/100*100.0)/100;
				document.displayForm.pInfCOMMDOLLARS.value=pInfCOMMDOLLARS.toFixed(2);
				var pInfMARGDOLLARS=(pInfSELLPRICE*document.displayForm.pInfMARGPERC.value/100*100.0)/100;
				document.displayForm.pInfMARGDOLLARS.value=pInfMARGDOLLARS.toFixed(2);
				var pInfCOMMFCPERC=(pInfCOMMDOLLARS/pInfSELLPRICE*100*100.0)/100;
				document.displayForm.pInfCOMMFCPERC.value=pInfCOMMFCPERC.toFixed(2);
				endScript();
				sellChange();
			}
			function commDollarUpdate(t){
				document.displayForm.pInfCOMMDOLLARS.value=document.displayForm.pInfKACOMMDOLLARS.value*1+document.displayForm.pInfSTDCOMMDOLLARS.value*1;
				dollarChange();
				var x=0;
				if(document.displayForm.pInfCOMMDOLLARS.value>0){
					x=document.displayForm.pInfKACOMMDOLLARS.value*1/document.displayForm.pInfCOMMDOLLARS.value*1;
				}

				x=x*document.displayForm.pInfCOMMPERC.value;
				document.displayForm.pInfKACOMMPERC.value=x.toFixed(2);
				if(document.displayForm.pInfCOMMDOLLARS.value>0){
					x=document.displayForm.pInfSTDCOMMDOLLARS.value*1/document.displayForm.pInfCOMMDOLLARS.value*1;
				}
				else{
					x=0;
				}
				x=x*document.displayForm.pInfCOMMPERC.value;
				document.displayForm.pInfSTDCOMMPERC.value=x.toFixed(2);
			}
			function commUpdate(t){
				document.displayForm.pInfCOMMPERC.value=document.displayForm.pInfKACOMMPERC.value*1+document.displayForm.pInfSTDCOMMPERC.value*1;
				commChange();
				var x=0;
				if(document.displayForm.pInfCOMMPERC.value>0){
					x=document.displayForm.pInfKACOMMPERC.value*1/document.displayForm.pInfCOMMPERC.value*1;
				}
				x=x*document.displayForm.pInfCOMMDOLLARS.value;
				document.displayForm.pInfKACOMMDOLLARS.value=x.toFixed(2);
				if(document.displayForm.pInfCOMMPERC.value>0){
					x=document.displayForm.pInfSTDCOMMPERC.value*1/document.displayForm.pInfCOMMPERC.value*1;
				}
				else{
					x=0;
				}
				x=x*document.displayForm.pInfCOMMDOLLARS.value;
				document.displayForm.pInfSTDCOMMDOLLARS.value=x.toFixed(2);
			}
			function dollarChange(){
				startScript();
				var pInfSELLPRICE=document.displayForm.pInfSUBTOTAL.value*1+document.displayForm.pInfCOMMDOLLARS.value*1+document.displayForm.pInfMARGDOLLARS.value*1;
				document.displayForm.pInfSELLPRICE.value=pInfSELLPRICE.toFixed(2);
				var can=document.displayForm.pInfSELLPRICE.value*document.displayForm.exchRate.value;
				document.displayForm.pInfSELLPRICECAN.value=can.toFixed(2);
				var pInfMARGPERC=(document.displayForm.pInfMARGDOLLARS.value*1/pInfSELLPRICE*100*100.0)/100;
				document.displayForm.pInfMARGPERC.value=pInfMARGPERC.toFixed(2);
				var pInfCOMMPERC=(100*document.displayForm.pInfCOMMDOLLARS.value*1/(pInfSELLPRICE*0.91)*100.0)/100;
				document.displayForm.pInfCOMMPERC.value=pInfCOMMPERC.toFixed(2);
				var pInfCOMMFCPERC=(document.displayForm.pInfCOMMDOLLARS.value*1/pInfSELLPRICE*100*100.0)/100;
				document.displayForm.pInfCOMMFCPERC.value=pInfCOMMFCPERC.toFixed(2);
				endScript();
			}

			function margChange(){
				startScript();
				var pInfCOMMDOLLARS=0;
				var pInfSELLPRICE=0;
				var pInfMARGDOLLARS=0;
				var pInfCOMMFCPERC=0;
				var pInfSELLPRICE=((100*document.displayForm.pInfSUBTOTAL.value-document.displayForm.pInfFC.value*document.displayForm.pInfCOMMPERC.value)/(100.0-document.displayForm.pInfCOMMPERC.value-document.displayForm.pInfMARGPERC.value));
				document.displayForm.pInfSELLPRICE.value=pInfSELLPRICE.toFixed(2);
				var can=document.displayForm.pInfSELLPRICE.value*document.displayForm.exchRate.value;
				document.displayForm.pInfSELLPRICECAN.value=can.toFixed(2);
				var pInfMARGDOLLARS=(pInfSELLPRICE*document.displayForm.pInfMARGPERC.value/100*100.0)/100;
				document.displayForm.pInfMARGDOLLARS.value=pInfMARGDOLLARS.toFixed(2);
				var pInfCOMMDOLLARS=(pInfSELLPRICE*0.91*document.displayForm.pInfCOMMPERC.value/100*100.0)/100;
				document.displayForm.pInfCOMMDOLLARS.value=pInfCOMMDOLLARS.toFixed(2);
				var pInfCOMMFCPERC=(pInfCOMMDOLLARS/pInfSELLPRICE*100*100.0)/100;
				document.displayForm.pInfCOMMFCPERC.value=pInfCOMMFCPERC.toFixed(2);
				endScript();
			}

			function commChange(){
				startScript();
				var pInfSELLPRICE=((100*document.displayForm.pInfSUBTOTAL.value-document.displayForm.pInfFC.value*document.displayForm.pInfCOMMPERC.value)/(100.0-document.displayForm.pInfCOMMPERC.value-document.displayForm.pInfMARGPERC.value)*100.0)/100;
				document.displayForm.pInfSELLPRICE.value=pInfSELLPRICE.toFixed(2);
				var can=document.displayForm.pInfSELLPRICE.value*document.displayForm.exchRate.value;
				document.displayForm.pInfSELLPRICECAN.value=can.toFixed(2);
				var pInfMARGDOLLARS=(pInfSELLPRICE*document.displayForm.pInfMARGPERC.value/100.0);
				document.displayForm.pInfMARGDOLLARS.value=pInfMARGDOLLARS.toFixed(2);
				var pInfCOMMDOLLARS=(pInfSELLPRICE*0.91*document.displayForm.pInfCOMMPERC.value/100*100.0)/100;
				document.displayForm.pInfCOMMDOLLARS.value=pInfCOMMDOLLARS.toFixed(2);
				var pInfCOMMFCPERC=(pInfCOMMDOLLARS/pInfSELLPRICE*100*100.0)/100;
				document.displayForm.pInfCOMMFCPERC.value=pInfCOMMFCPERC.toFixed(2);
				endScript();
			}

			function sellChange(){
				var can=document.displayForm.pInfSELLPRICE.value*document.displayForm.exchRate.value;
				document.displayForm.pInfSELLPRICECAN.value=can.toFixed(2);
				startScript();
				var pInfCOMMDOLLARS=(document.displayForm.pInfSELLPRICE.value*0.91*document.displayForm.pInfCOMMPERC.value/100*100.0)/100;
				document.displayForm.pInfCOMMDOLLARS.value=pInfCOMMDOLLARS.toFixed(2);
				var pInfMARGDOLLARS=(document.displayForm.pInfSELLPRICE.value-pInfCOMMDOLLARS-document.displayForm.pInfSUBTOTAL.value);
				document.displayForm.pInfMARGDOLLARS.value=pInfMARGDOLLARS.toFixed(2);
				var pInfMARGPERC=(pInfMARGDOLLARS/document.displayForm.pInfSELLPRICE.value*100*100.0)/100;
				document.displayForm.pInfMARGPERC.value=pInfMARGPERC.toFixed(2);
				var pInfCOMMFCPERC=(pInfCOMMDOLLARS/document.displayForm.pInfSELLPRICE.value*100*100.0)/100;
				document.displayForm.pInfCOMMFCPERC.value=pInfCOMMFCPERC.toFixed(2);
				endScript();
			}

			function installChange(){
				startScript();
				endScript();
			}
			function catchAllCheckx(){

			}
			function catchallprice(a,b,c){
				var catchallprice=0;
				if(document.displayForm.pInfCATCHALL1.value>0||document.displayForm.pInfCATCHALL1.value<0){
					catchallprice=catchallprice*1+document.displayForm.pInfCATCHALL1.value*1;
				}
				if(document.displayForm.pInfCATCHALL2.value>0||document.displayForm.pInfCATCHALL2.value<0){
					catchallprice=catchallprice*1+document.displayForm.pInfCATCHALL2.value*1;
				}
				if(document.displayForm.pInfCATCHALL3.value>0||document.displayForm.pInfCATCHALL3.value<0){
					catchallprice=catchallprice*1+document.displayForm.pInfCATCHALL3.value*1;
				}
				if(document.displayForm.pInfCATCHALL4.value>0||document.displayForm.pInfCATCHALL4.value<0){
					catchallprice=catchallprice*1+document.displayForm.pInfCATCHALL4.value*1;
				}
				if(document.displayForm.pInfCATCHALL5.value>0||document.displayForm.pInfCATCHALL5.value<0){
					catchallprice=catchallprice*1+document.displayForm.pInfCATCHALL5.value*1;
				}
				document.displayForm.pInfCATCHALL.value=catchallprice;
				hoursChange(a,b,c);
			}
			function catchallwt(){
				var catchallwt=0;
				if(document.displayForm.pInfCATCHALLWT1.value>0||document.displayForm.pInfCATCHALLWT1.value<0){
					catchallwt=catchallwt*1+document.displayForm.pInfCATCHALLWT1.value*1;
				}
				if(document.displayForm.pInfCATCHALLWT2.value>0||document.displayForm.pInfCATCHALLWT2.value<0){
					catchallwt=catchallwt*1+document.displayForm.pInfCATCHALLWT2.value*1;
				}
				if(document.displayForm.pInfCATCHALLWT3.value>0||document.displayForm.pInfCATCHALLWT3.value<0){
					catchallwt=catchallwt*1+document.displayForm.pInfCATCHALLWT3.value*1;
				}
				if(document.displayForm.pInfCATCHALLWT4.value>0||document.displayForm.pInfCATCHALLWT4.value<0){
					catchallwt=catchallwt*1+document.displayForm.pInfCATCHALLWT4.value*1;
				}
				if(document.displayForm.pInfCATCHALLWT5.value>0||document.displayForm.pInfCATCHALLWT5.value<0){
					catchallwt=catchallwt*1+document.displayForm.pInfCATCHALLWT5.value*1;
				}
				document.displayForm.pInfCATCHALLWT.value=catchallwt;
                                 
                                // alert(document.displayForm.pIndTOTWTbeforeCatchall.value);
                                // start of change as per Eric Som in email to Greg on nov 5 2019 titles RE: erapid Catchall Question
                                if(document.displayForm.pIndTOTWTbeforeCatchall.value*1<250){
                                        catchallwt = catchallwt * 1.56;
                                }
                                else if(document.displayForm.pIndTOTWTbeforeCatchall.value*1<500){
                                        catchallwt = catchallwt * 1.36;
                                }
                                else if(document.displayForm.pIndTOTWTbeforeCatchall.value*1<2000){
                                        catchallwt = catchallwt * 1.29;
                                }
                                else if(document.displayForm.pIndTOTWTbeforeCatchall.value*1<5000){
                                        catchallwt = catchallwt * 1.25;
                                }
                                else if(document.displayForm.pIndTOTWTbeforeCatchall.value*1<10000){
                                        catchallwt = catchallwt * 1.22;
                                }
                                else{
                                        catchallwt = catchallwt * 1.20;
                                }                   
                                
                                 document.displayForm.pIndTOTWT.value=(catchallwt+document.displayForm.pIndTOTWTbeforeCatchall.value*1).toFixed(2);  
                                 //alert(document.displayForm.pIndTOTWTbeforeCatchall.value+"::"+catchallwt+"::"+document.displayForm.pIndTOTWT.value);
                                 //document.displayForm.pIndTOTWT.value=(catchallwt*1.05+document.displayForm.pIndTOTWTbeforeCatchall.value*1).toFixed(2);
                                 // end change as per Eric Som 
				x();
				weightChange();
			}
			function fcChange(a,b,c){
				var fc=0;
				if(document.displayForm.pInfFREIGHT.value>0){
					fc=fc*1+document.displayForm.pInfFREIGHT.value*1;
				}
				if(document.displayForm.pInfCRATE.value>0){
					fc=fc*1+document.displayForm.pInfCRATE.value*1;
				}
				document.displayForm.pInfFC.value=fc;
				hoursChange(a,b,c);
			}
			function weightChange(){
				var pIndTOTWT=document.displayForm.pIndTOTWT.value;
				
				var pInfCRATE=0;
				if(pIndTOTWT<500){
					pInfCRATE=(pIndTOTWT/75)*35;
				}
				else if(pIndTOTWT<3000){
					pInfCRATE=(pIndTOTWT/100)*35;
				}
				else{
					pInfCRATE=(pIndTOTWT/100)*35;
				}
				if(pInfCRATE<35){
					pInfCRATE=35;
				}
				document.displayForm.pInfCRATE.value=pInfCRATE.toFixed(2);
				freightChange(document.displayForm.dh_rate.value,document.displayForm.eh_rate.value,document.displayForm.pm_rate.value);
				if(document.displayForm.manualFreight.value!="Y"){
					var values="&weight="+document.displayForm.pIndTOTWT.value;
					values=values+"&city="+document.displayForm.city.value;
					values=values+"&state="+document.displayForm.state.value;
					values=values+"&orderNo="+document.displayForm.q_no.value;
					values=values+"&sectionLines="+document.displayForm.sectionLines.value;
					var req=new XMLHttpRequest();
					var handlerFunction=getReadyStateHandler(req,weightChange2);
					req.onreadystatechange=handlerFunction;
					req.open("post","accessCentralChangeWeight.jsp",true);
					req.setRequestHeader("Content-Type","application/x-www-form-urlencoded; charset=utf-8");
					req.send(values);
				}
			}
			function weightChange2(searchXML){
                          //  alert("weightChange2");
				var count=searchXML.getElementsByTagName("freight").length;
                            //    alert("0");
				for(var i=0;i<count;i++){
					var x=searchXML.getElementsByTagName("freight")[i].childNodes[0].nodeValue.replace("#","");
					document.displayForm.pInfFREIGHT.value=(x*1);
					
				}
                              //  alert("1");
				if(document.displayForm.exportx.value=="on"){
					var x=(document.displayForm.pIndTOTWT.value/100)*35;
					document.displayForm.exportCrate.value=x.toFixed(2);
				}
				freightChange(document.displayForm.dh_rate.value,document.displayForm.eh_rate.value,document.displayForm.pm_rate.value);
			}
			function x(){
				var yeild=0;
				yeild=document.displayForm.pInfSELLPRICE.value/(document.displayForm.pIndTOTWT.value*1);
				document.displayForm.pIndYIELD.value=yeild.toFixed(2);
			}

			function calcEng(){
				//alert("calcEng() method has invoked !!");
				var numHours=((document.displayForm.pIndTOTSF.value*0.2)+900)/80;
				document.displayForm.pInfEHOURS.value=numHours.toFixed(2);
				hoursChange(document.displayForm.dh_rate.value,document.displayForm.eh_rate.value,document.displayForm.pm_rate.value);
			}
			function calcEngOSHPD(){
				var numHours=(((document.displayForm.pIndTOTSF.value*0.25)+1000)/80)*1.5;
				document.displayForm.pInfEHOURS.value=numHours.toFixed(2);
				hoursChange(document.displayForm.dh_rate.value,document.displayForm.eh_rate.value,document.displayForm.pm_rate.value);
			}
			function calcEngBlast(){
				var numHours=18.75;
				var remainSf=document.displayForm.pIndTOTSF.value*1-400;
				if(remainSf>0){
					numHours=numHours+remainSf*0.020;
				}
				document.displayForm.pInfEHOURS.value=numHours.toFixed(2);
				hoursChange(document.displayForm.dh_rate.value,document.displayForm.eh_rate.value,document.displayForm.pm_rate.value);
			}
                        function calcEngSunInHouse(){
				var numHours=((document.displayForm.pIndTOTSF.value*0.2)+300)/80;
				document.displayForm.pInfEHOURS.value=numHours.toFixed(2);
				hoursChange(document.displayForm.dh_rate.value,document.displayForm.eh_rate.value,document.displayForm.pm_rate.value);
			}
                        function calcEngSunOutside(){
				var numHours=((document.displayForm.pIndTOTSF.value*0.45)+1100)/80;
				document.displayForm.pInfEHOURS.value=numHours.toFixed(2);
				hoursChange(document.displayForm.dh_rate.value,document.displayForm.eh_rate.value,document.displayForm.pm_rate.value);
			}
                        function calcEngSunOshpd(){
				var numHours=(((document.displayForm.pIndTOTSF.value*0.45)+1100)/80)*2;
				document.displayForm.pInfEHOURS.value=numHours.toFixed(2);
				hoursChange(document.displayForm.dh_rate.value,document.displayForm.eh_rate.value,document.displayForm.pm_rate.value);
			}
			function calcProject(){
                            //alert("calc project"+document.displayForm.pInfPMHOURS.value);
				var numHours=(document.displayForm.pInfSUBTOTAL.value*.02)/80;
				document.displayForm.pInfPMHOURS.value=numHours.toFixed(2);
				hoursChange(document.displayForm.dh_rate.value,document.displayForm.eh_rate.value,document.displayForm.pm_rate.value);
			}
                        
			function roundCanada(){
				var can=document.displayForm.pInfSELLPRICECAN.value;
				var roundCan=Math.ceil(can/5)*5;
				document.displayForm.pInfSELLPRICECAN.value=roundCan;
				document.displayForm.pInfSELLPRICE.value=(roundCan/document.displayForm.exchRate.value).toFixed(2);
				sellChange();
			}
                        function calcExportGrille(){
				
                                if(document.displayForm.manualFreight.value!="Y" && document.displayForm.exportCrate.value==0){
					document.displayForm.exportx.value="on";
                                        document.displayForm.exportCrate.value=document.displayForm.pInfCRATE.value;
					catchallwt();
				}
				else{
					alert("You can not use this button when frieght has be changed manually or export has already been set.  ");
				}
			}
			function calcExport(){
				if(document.displayForm.manualFreight.value!="Y" && document.displayForm.exportCrate.value==0){
					document.displayForm.exportx.value="on";
					catchallwt();
				}
				else{
					alert("You can not use this button when frieght has be changed manually or export has already been set.  ");
				}
			}
			function addFasteners(){
				if(document.displayForm.pInfCATCHALL_DESC5.value.indexOf("FASTENERS ADDED")<0){
					var x=document.displayForm.pIndMATLESSFIN.value*.07;
					var y=document.displayForm.pIndTOTWT.value*.01;
					var z=" FASTENERS ADDED";
					var x1=document.displayForm.pInfCATCHALL5.value;
					var y2=document.displayForm.pInfCATCHALLWT5.value;
					var z2=document.displayForm.pInfCATCHALL_DESC5.value;
					document.displayForm.pInfCATCHALL5.value=(x*1+x1*1).toFixed(2);
					catchallprice(document.displayForm.dh_rate.value,document.displayForm.eh_rate.value,document.displayForm.pm_rate.value);
					document.displayForm.pInfCATCHALLWT5.value=(y*1+y2*1).toFixed(2);
					catchallwt();
					document.displayForm.pInfCATCHALL_DESC5.value=z2+" "+z;
				}
				else{
					alert("Fastners already added");
				}

			}
                        function submitThis(){
                            
                            if(document.displayForm.VS_ID.value=="FSM"&&document.displayForm.pInfFREIGHT.value*1<=0){
                                alert("You must enter a freight value.");
                            }
                            else{
                                document.displayForm.submit();
                            }
                        }
                        function TWOyrWty(){
                           document.displayForm.pInfCATCHALL_DESC4.value =" 2 Year Warranty Applied";
                           document.displayForm.pInfCATCHALL4.value=0;
                           catchallprice(document.displayForm.dh_rate.value,document.displayForm.eh_rate.value,document.displayForm.pm_rate.value);
                        }
                        function THREEyrWty(){
                           document.displayForm.pInfCATCHALL_DESC4.value =" 3 Year Warranty Applied";
                           document.displayForm.pInfCATCHALL4.value=(document.displayForm.pInfCOST.value*.01).toFixed(2);
                           catchallprice(document.displayForm.dh_rate.value,document.displayForm.eh_rate.value,document.displayForm.pm_rate.value);
                        }
                        function FOURyrWty(){
                           document.displayForm.pInfCATCHALL_DESC4.value =" 4 Year Warranty Applied";
                           document.displayForm.pInfCATCHALL4.value=(document.displayForm.pInfCOST.value*.02).toFixed(2);
                           catchallprice(document.displayForm.dh_rate.value,document.displayForm.eh_rate.value,document.displayForm.pm_rate.value);
                        }
                        function FIVEyrWty(){
                           document.displayForm.pInfCATCHALL_DESC4.value =" 5 Year Warranty Applied";
                           document.displayForm.pInfCATCHALL4.value=(document.displayForm.pInfCOST.value*.03).toFixed(2);
                           catchallprice(document.displayForm.dh_rate.value,document.displayForm.eh_rate.value,document.displayForm.pm_rate.value);
                        }

		}
		catch(err){
			alert("JAVASCRIPT ERROR"+err.message);
		}
	</script>
	<noscript><FONT COLOR=red SIZE='3'>Your browser does not support JavaScript!  CONTACT ERAPID TEAM IF YOU SEE THIS MESSAGE!!!</FONT></noscript>

	<%@ page language="java" import="java.text.*" import="java.sql.*" import="java.util.*" import="java.math.*" errorPage="error.jsp" %>

	<%@ include file="../../../db_con.jsp"%>

	<%
	Vector pbModel=new Vector();
	Vector pbDifference=new Vector();
	double costDifference=0;
	String manualFreight="";

	ResultSet rsPB=stmt.executeQuery("select model, difference from cs_lvr_finish_pb");
	if(rsPB != null){
		while(rsPB.next()){
			pbModel.addElement(rsPB.getString(1));
			pbDifference.addElement(rsPB.getString(2));
			//out.println(rsPB.getString(1)+"::"+rsPB.getString(2)+"<BR>");
		}
	}
	rsPB.close();
	String section_name="";
	if(request.getParameter("section_name") != null&&request.getParameter("section_name").trim().length()>0){
		section_name=request.getParameter("section_name");
		out.println("SECTION:  "+section_name);

	}
	// Code by Greg and Arthur
	// Started June 28/05
	// Will replace access central on configurator
	String interco=request.getParameter("interco");
	String reset=request.getParameter("reset");
	//out.println(interco);
	//out.println(reset);
	if(interco==null){
		interco="off";
	}
String export=request.getParameter("export");
if(export==null){
	export="off";
}
	String sectionLines=request.getParameter("sectionLines");
	String section=request.getParameter("section");
	//out.println(sectionLines+"<--::"+section+"::"+request.getParameter("isNotSec")+"<BR>");
	boolean  isNotSec=true; boolean runCalcEngg = false; boolean resetAndRunCalcEngg = false;
	if(request.getParameter("isNotSec") != null && request.getParameter("isNotSec").equals("false")){
		isNotSec=false;
	}
	String cityState=request.getParameter("cityState");
	if((cityState == null)){
		cityState="";

	}	
	
	boolean costCompare=true;
	boolean isSf=false;
	int countRows=Integer.parseInt(request.getParameter("countRows"));

	//out.println(countRows+ " :: GSO");

	int VI_MIN_SUBLINE=0;
	int VI_MAX_SUBLINE=0;
	int VI_N_OF_SUBL=0;
	int VI_N_OF_COST=0;
	String VS_ID="";
	String order_no = request.getParameter("q_no");//Login id
	String ordertype= request.getParameter("type");//type
	//out.println(order_no+":::"+ordertype+"<BR>");
	double dlspeed=0.0;
	double hrrate=0.0;
	double enghrrate=0.0;
	double pmhrrate=0.0;
	double defcommperc=0.0;
	double fcperc=0.0;
	double defmargperc=0.0;
	double commfcperc=0.0;
	double spfactor=0.0;

	String cityx=request.getParameter("cityx");
	String statex=request.getParameter("statex");
	//out.println("CityState Value : "+cityState);
	String qtype=request.getParameter("qtype"); //quote type = TQ, SS, PD, PS
	String CSDECO=request.getParameter("CSDECO"); //cs or deco = C or D
	String desc=request.getParameter("DESC");
	String add=request.getParameter("ADD");
	String sect=request.getParameter("SECT");
	String date=request.getParameter("DATE");
	String status="";
	String urlReset="access_central_calc.jsp?q_no="+order_no+"&type="+ordertype+"&countRows=0&qtype="+qtype+"&CSDECO="+CSDECO+"&DESC="+desc+"&ADD="+add+"&SECT="+sect+"&DATE"+date+"&cityState="+cityState+"&cityx=no&statex=no&section="+section+"&isNotSec="+isNotSec+"&interco="+interco+"&sectionLines="+sectionLines;


	//out.println(urlReset+"::<br>");
	//out.println(CSDECO+"x"+desc+"x"+add+"x"+sect+"x"+date+"<br>");
		double extraCharge5=0;
		String extraChargeDesc5="";
	double VR_STDCOST=0.0;
	double VR_RUNCOST=0.0;
	double VR_SETUPCOST=0.0;

	double VR_TOTFINCOST=0.0;
	double VR_TOTSF=0.0;
	double VR_TOTQTY=0.0;
	double VR_SQFT=0.0;
	String VR_SYSDEPTH="0";
	double VR_ADJWEIGHT=0.0;
	double exportCrate=0;
	double pInfFREIGHT=0.0;
	double pInfCRATE=0.0;
	double pIndDOLLARSF=0.0;
	double pIndMATLESSFIN=0.0;
	double pIndTOTPAINTSF=0.0;
	double pIndTOTPERIM=0.0;
	double pIndTOTSF=0.0;
	double pIndTOTWT=0.0;
	double pIndUNITPRICE=0.0;
	double pIndYIELD=0.0;
	double pInfADMINDOLLARS=0.0;
	double pInfADMINPERC=0.0;
	String pInfALLHOURS="";
	double pInfCATCHALL=0.0;
	double pInfCATCHALLPERC=0.0;
	double pInfCATCHALLWT=0.0;
	String pInfCATCHALL_DESC="";
	String pInfCATCHALL_DESC1="";
	String pInfCATCHALL_DESC2="";
	String pInfCATCHALL_DESC3="";
	String pInfCATCHALL_DESC4="";
	String pInfCATCHALL_DESC5="";
	double pInfCATCHALL1=0.0;
	double pInfCATCHALL2=0.0;
	double pInfCATCHALL3=0.0;
	double pInfCATCHALL4=0.0;
	double pInfCATCHALL5=0.0;
	double pInfCATCHALLWT1=0.0;
	double pInfCATCHALLWT2=0.0;
	double pInfCATCHALLWT3=0.0;
	double pInfCATCHALLWT4=0.0;
	double pInfCATCHALLWT5=0.0;
	double pInfCOMMDOLLARS=0.0;
	double pInfCOMMFCPERC=0.0;

	double pInfSTDCOMMDOLLARS=0.0;
	double pInfSTDCOMMPERC=0.0;
	double pInfKACOMMDOLLARS=0.0;
	double pInfKACOMMPERC=0.0;

	double pInfCOMMPERC=0.0;
	double pInfCOST=0.0;
	double pInfCOSTPERC=0.0;
	double pInfD=0.0;
	double pInfDHOURS=0.0;
	double pInfE=0.0;
	double pInfEHOURS=0.0;
	double pInfFC=0.0;
	double pInfFCPERC=0.0;
	double pInfINSTALL=0.0;
	double pInfL=0.0;
	double pInfLHOURS=0.0;
	double pInfMARGDOLLARS=0.0;
	double pInfMARGPERC=0.0;
	double pInfP=0.0;
	double pInfPMHOURS=0.0;
	double pInfSELLPERC=0.0;
	double pInfSELLPRICE=0.0;
	double pInfSELLPRICECAN=0.0;
	double pInfSUBTOTAL=0.0;
	double pInfSUBTOTPERC=0.0;
	double pInfTOTAL=0.0;
	double pInfTOTHOURS=0.0;
	String exchName="";
	String exchRate="";
	String exchRateDate="";
	String group=userSession.getGroup();
	// get max and min subline values
	ResultSet rsCan=stmt.executeQuery("select exch_name,exch_rate,exch_rate_date from cs_project where order_no='"+order_no+"'");
	if(rsCan != null){
		while(rsCan.next()){
			exchName=rsCan.getString("exch_name");
			exchRate=rsCan.getString("exch_rate");
			exchRateDate=rsCan.getString("exch_rate_date");
		}
	}
	rsCan.close();
//out.println(exchName+"::"+exchRate+"::"+exchRateDate);
	ResultSet rs=stmt.executeQuery("Select doc_line,product_id from doc_line where doc_number='"+order_no+"' and (doc_line =(select min(cast(doc_line as int)) from doc_line where doc_number='"+order_no+"') or doc_line=(select max(cast(doc_line as int)) from doc_line where doc_number='"+order_no+"'))");
	if(rs != null){
		while(rs.next()){
			VI_MIN_SUBLINE=rs.getInt(1);
			if(VI_MAX_SUBLINE==0){
				VS_ID=rs.getString(2);
			}
			if(VI_MIN_SUBLINE>VI_MAX_SUBLINE){
				int x=VI_MAX_SUBLINE;
				VI_MAX_SUBLINE=VI_MIN_SUBLINE;
				VI_MIN_SUBLINE=x;
			}
			else{
				VS_ID=rs.getString(2);
	// Change VS_ID to be read from the PROJECT table instead of the first subline
	// This way we can delete all references to VI_MIN_SUBLINE
			}
		}
	}
	rs.close();
	
	//if((VS_ID.equals("GRILLE")) && (cityState.contains("CA")||cityState.contains("FL")) && !(pInfEHOURS > 0.0)){
	//	runCalcEngg = true;
	//}
	
	//out.println(pInfEHOURS+": --------->>>>>> "+runCalcEngg);	
	
	ResultSet rsSf=stmt.executeQuery("select distinct product_id from csquotes where order_no='"+order_no+"'");
	if(rsSf != null){
		while(rsSf.next()){
			//out.println(rsSf.getString(1)+"::<BR>");
			if(rsSf.getString(1)!= null && rsSf.getString(1).equals("GEN")){
				isSf=true;
			}
		}
	}
	rsSf.close();

	String city="";
	String state="";


	String VS_RES_STRING = "";
	String VS_CONFIG_STRING = "";
	String VS_MISMATCH = "";

	int n_of_sublines=0;
	String keyword=",MK[";
	int[] subline=new int[VI_MAX_SUBLINE];
	String[] mark_c=new String[VI_MAX_SUBLINE];
	String[] product_c=new String[VI_MAX_SUBLINE];
	int[] subl_c=new int[VI_MAX_SUBLINE];
	//double[] cost_c=new double[VI_MAX_SUBLINE];
	double[] weight_c=new double[VI_MAX_SUBLINE];
	String[] qty_c=new String[VI_MAX_SUBLINE];
	String[] model_c=new String[VI_MAX_SUBLINE];
	String[] finish_c=new String[VI_MAX_SUBLINE];
	String[] screen_c=new String[VI_MAX_SUBLINE];
	String[] sched_mark=new String[VI_MAX_SUBLINE];
	String[] sched_qty=new String[VI_MAX_SUBLINE];
	String[] sched_size=new String[VI_MAX_SUBLINE];

String[] SYSDEPTH=new String[VI_MAX_SUBLINE];
String[] SQFT=new String[VI_MAX_SUBLINE];
	String[] gals=new String[VI_MAX_SUBLINE];
	String[] finish=new String[VI_MAX_SUBLINE];


	//int[] schedule=new int[VI_MAX_SUBLINE];
	String[] opts_c=new String[VI_MAX_SUBLINE];
	int[] sched_max=new int[7];
	String VS_DESC = "";
	double setup_qty=0;
	double VR_WEIGHT=0.0;
	int VI_HAS_OPTIONS = 0;
	int VI_TEST_TYPE = 0;
	int desc_grp=0;
	int rows=0;

	if(VS_ID.equals("ADS")){
		//replicate ads_sum_cost formula
	%>
	<%//@ include file="access_central_ads.jsp"%>
	<%
	//out.println("ADS job:"+isNotSec+" <BR>");
}

// Find the sublines in the doc_line table.
try{
	String sel="";
	if(isNotSec){
		sel = "SELECT config_string,doc_line FROM doc_line WHERE doc_number='"+order_no+"'";
	}
	else{
		sel = "SELECT config_string,doc_line FROM doc_line WHERE doc_number='"+order_no+"' and doc_line in("+sectionLines+")";
	}

	//out.println("Running: "+sel);
    ResultSet rs01=stmt.executeQuery(sel);
    int k=0;
    while (rs01.next() ){

       VS_CONFIG_STRING=rs01.getString("config_string");
       subline[k]=rs01.getInt("doc_line");
       int foundat=VS_CONFIG_STRING.indexOf(keyword);
       int maxpos=VS_CONFIG_STRING.length();
       int string2=foundat+25;
       if (string2 > maxpos){
           string2 = maxpos;
       }
       String mark=VS_CONFIG_STRING.substring(foundat+4, string2);
       foundat=mark.indexOf("]");
       if(foundat >0){
			mark_c[k]="Mark: "+mark.substring(0,foundat);
		}
       n_of_sublines++;
		// retrieving FLAG/DM_INDEX

       int subl=rs01.getInt("doc_line");
       if(subl != subline[k]){
           out.println("ERROR in order #: "+order_no+" Mismatch - Line: "+subline[k]+" has {LOGIA/SUBLINENO} in the string as: "+subl);
           VS_MISMATCH=VS_MISMATCH+subline[k]+",";
           }

       k++;
       VI_N_OF_SUBL=k;
    }
    rs01.close();
}
catch(Exception e){
   out.println("ERROR While processing String..."+e);
}
try{
	for (int k=0; k<n_of_sublines; k++){
    	int s=k+1;
        String sel = "UPDATE doc_line SET item_desc = '"+mark_c[k]+"' WHERE doc_number='"+order_no+"' AND doc_line='"+subline[k]+"'";
        int rs02=stmt.executeUpdate(sel);
		//out.println("<font color='blue'>While running: "+sel+", "+rs02+" records found.<BR>");
    }
}
catch(Exception e00){
   out.println("ERROR: While performing UPDATE... "+e00);
}

if (!VS_MISMATCH.equals("")){
      out.println("ERROR: Open and re-save the following lines: "+VS_MISMATCH+" or call IT for help.");
}
// end of Updatedesc formula

if(ordertype.equals("Q")){

	//Summary formula - Retrieve and summarize costs for all sublines
	//out.println("<font color='black'> order type = q<BR>");
	//out.println("<font color='black'> run formula 'summary'<BR>");

	double VR_PERIM=0.0;
	double VR_TOTSURF=0.0;
	double VR_TOTCOMM=0.0;
	double VR_TOTPRICE=0.0;

	String VS_ORDERNO = order_no;

	// Options added to schedule for ADS
	if(VS_ID.equals("ADS")||VS_ID.equals("GRILLE")){
	    VI_HAS_OPTIONS = 1;
	}
	else {
	    VI_HAS_OPTIONS = 0;
	}

	if(qtype.equals("TQ") || qtype.equals("SS")){
	   VI_TEST_TYPE = 1;
	}
	else {
	   VI_TEST_TYPE = 0;
	}

	double[] nasty_setup=new double[VI_MAX_SUBLINE];

	setup_qty=0.0;

	char spacer_tab = 9;
	String spacer="" + spacer_tab + spacer_tab;
	String crlf="\r\n";


	if(VI_HAS_OPTIONS > 0){
	    spacer="   ";
	    }

	// part of Reporting formula - Output pricing for reporting

	double VR_RATIO = 0.0;

	// end of part of Reporting formula

// THIS IS WHERE CLEARDMRECS WAS

	try
	   {
	    VR_STDCOST=0.0;
	    VR_RUNCOST=0.0;
	    VR_SETUPCOST=0.0;
	    VR_WEIGHT=0.0;
	    VR_SQFT=0.0;
	    VR_PERIM=0.0;
	    VR_TOTFINCOST=0.0;
	    VR_TOTSURF=0.0;
	    VR_TOTCOMM=0.0;
	    VR_TOTPRICE=0.0;
	    VR_TOTQTY=0.0;
		String sel="";
		if(isNotSec){
		sel = "SELECT * FROM cs_costing WHERE order_no='"+VS_ORDERNO+ "'";
		//out.println("Query: "+sel+"<BR>");
		}
		else{
			sel = "SELECT * FROM cs_costing WHERE order_no='"+VS_ORDERNO+ "' and item_no in("+sectionLines+")";
			//out.println("Query: "+sel+"<BR>");
		}
	   // out.println("Running query: "+sel);
	    ResultSet rs00=stmt.executeQuery(sel);
	    sched_max[0]=4; // Mark
	    sched_max[1]=4; // Qty.
	    sched_max[2]=4; // Size
	    rows=0;
	    while (rs00.next() ){
//out.println("There is rs00.next<br>");
			// following from Reporting formula
		   subl_c[rows]=rs00.getInt("item_no");
		    //cost_c[rows]=rs00.getDouble("std_cost")+rs00.getDouble("run_cost");
		   // weight_c[rows]=rs00.getDouble("weight");
		    //qty_c[rows]=rs00.getString("qty");

if(rs00.getString("product_id").equals("SUN")&&rs00.getString("actuator")!=null && (rs00.getString("actuator").equals("1")||rs00.getString("actuator").equals("2")||rs00.getString("actuator").equals("3"))){
    pInfCATCHALL_DESC1="Custom part selected, elaborate";
//out.println(rs00.getString("actuator")+":: actuator<BR>");
}
		    // end of stuff from Reporting formula

		product_c[rows]=rs00.getString("product_id");
		model_c[rows]=rs00.getString("model");
//out.println(rs00.getString("model"));
		finish[rows]=rs00.getString("finish");
		gals[rows]=rs00.getString("gals");
		//out.println(rs00.getString("finish")+"::"+rs00.getString("gals")+"<BR>");
		   ////finish_c[rows]=rs00.getString("finish");
		   //screen_c[rows]=rs00.getString("screen");
		  // opts_c[rows]=rs00.getString("s_options");
		   VR_STDCOST=VR_STDCOST+rs00.getDouble("std_cost");
		   VR_RUNCOST=VR_RUNCOST+rs00.getDouble("run_cost");
		   double cur_cost=rs00.getDouble("setup_cost");
		   nasty_setup[rows]=cur_cost;
// Added by AC based on old ACCESS_CENTRAL
		if (product_c[rows].equals("GRILLE")){
			if (rows!=0){
				for (int p=0;p<rows;p++){
					if (model_c[p].equals(model_c[rows])){
					//	cur_cost=0;
//commented out according to Aaron on Jan 31/19 by Greg
					}
				}
			}
			// out.println("Setup cost for line #"+rows+" model "+model_c[rows]+" is "+cur_cost+"<br>");
		}
// End of addition
		    //cost_c[rows]=cost_c[rows]+cur_cost;   // from Reporting formula
		   VR_SETUPCOST= VR_SETUPCOST+cur_cost;  // nasty setup cost will override this later
			// out.println("Setup cost "+VR_SETUPCOST+"<br>");
		   VR_WEIGHT= VR_WEIGHT+rs00.getDouble("weight");
		   VR_SQFT= VR_SQFT+rs00.getDouble("sqft");
		   SYSDEPTH[rows]= rs00.getString("ssedge_code");
			SQFT[rows]= rs00.getString("sqft");
		   VR_PERIM= VR_PERIM+rs00.getDouble("perim");
		   VR_TOTFINCOST= VR_TOTFINCOST+rs00.getDouble("fin_cost");
		   VR_TOTSURF= VR_TOTSURF+rs00.getDouble("totsurf");
		   VR_TOTCOMM=VR_TOTCOMM+rs00.getDouble("commission");
		   VR_TOTPRICE=VR_TOTPRICE+rs00.getDouble("price");
		   String tmp_qty=rs00.getString("qty");
		   VR_TOTQTY=VR_TOTQTY+Double.valueOf(tmp_qty).doubleValue();
		   tmp_qty=tmp_qty.substring(0,tmp_qty.length()-3);

		   sched_mark[rows]=rs00.getString("mark");
		   if(sched_mark[rows].length() > sched_max[0]){
			   sched_max[0]=sched_mark[rows].length();
			   }
		   sched_qty[rows]= tmp_qty;
		   if(sched_qty[rows].length() > sched_max[1]){
			   sched_max[1]=sched_qty[rows].length();
			   }
		   sched_size[rows]=rs00.getString("width") + " x " + rs00.getString("height");
		   if(sched_size[rows].length() > sched_max[2]){
			   sched_max[2]=sched_size[rows].length();
			   }
		  //out.println("<Br>"+rows+"<--<BR>");

		   rows++;
		   }
	    VI_N_OF_COST=rows;
//out.println(VI_N_OF_COST+"::<BR>");
		// Find the number of sublines and subline numbers in the cs_costing table.
		if(VI_N_OF_COST > VI_N_OF_SUBL){
		    out.println("Mismatch: found "+VI_N_OF_COST+" entries in 'cs_ costing' for "+VI_N_OF_SUBL+" sublines - they will be deleted.");
		 }
		rs00.close();


		if(isNotSec){
		sel = "SELECT distinct finish FROM cs_costing WHERE order_no='"+VS_ORDERNO+ "'";
		//out.println("Query: "+sel+"<BR>");
		}
		else{
			sel = "SELECT distinct finish FROM cs_costing WHERE order_no='"+VS_ORDERNO+ "' and item_no in("+sectionLines+")";
			//out.println("Query: "+sel+"<BR>");
		}
		boolean isCL599=false;
		boolean isDC499=false;
		boolean isKY599=false;
		boolean isMC799=false;
		boolean isTX699=false;
				boolean isFM599=false;
				boolean isFM799=false;
				boolean isFM699=false;
                boolean isPCCustom=false;
                boolean isGCL500=false;
                boolean isGKY599=false;
                boolean isGMC799=false;
                boolean isGTX699=false;
                boolean isPCCustom_NOAL=false;
				boolean isC_BONDED=false;
				boolean isVKM00=false;

		ResultSet rsCustom=stmt.executeQuery(sel );
		if(rsCustom != null){
			while(rsCustom.next()){
				if(rsCustom.getString(1).equals("C_BONDED")){
					isC_BONDED=true;
				}
				if(rsCustom.getString(1).equals("VKM00")){
					isVKM00=true;
				}
				if(rsCustom.getString(1).equals("CL599")){
					isCL599=true;
				}
				if(rsCustom.getString(1).equals("DC499")){
					isDC499=true;
				}
				if(rsCustom.getString(1).equals("KY599")){
					isKY599=true;
				}
				if(rsCustom.getString(1).equals("MC799")){
					isMC799=true;
				}
				if(rsCustom.getString(1).equals("TX699")){
					isTX699=true;
				}
				if(rsCustom.getString(1).equals("FM599")){
					isFM599=true;
				}
				if(rsCustom.getString(1).equals("FM799")){
					isFM799=true;
				}
				if(rsCustom.getString(1).equals("FM699")){
					isFM699=true;
				}
				if(rsCustom.getString(1).startsWith("PC_CUSTOM")){
					isPCCustom=true;
				}
                                if(rsCustom.getString(1).startsWith("GCL500")){
                                    isGCL500=true;
                                }
                                if(rsCustom.getString(1).startsWith("GKY599")){
                                    isGKY599=true;
                                }
                                if(rsCustom.getString(1).startsWith("GMC799")){
                                    isGMC799=true;
                                }
                                if(rsCustom.getString(1).startsWith("GTX699")){
                                    isGTX699=true;
                                }
                                if(rsCustom.getString(1).startsWith("PCCustom_NOAL")){
                                    isPCCustom_NOAL=true;
                                }
			}
		}
		rsCustom.close();
		
		if(isC_BONDED){
			extraCharge5=extraCharge5+50;
			extraChargeDesc5=extraChargeDesc5+" C_BONDED";
		}
		if(isVKM00){
			extraCharge5=extraCharge5+50;
			extraChargeDesc5=extraChargeDesc5+" VKM00";
		}
		if(isCL599){
			extraCharge5=extraCharge5+50;
			extraChargeDesc5=extraChargeDesc5+" CL599";
		}
		if(isDC499){
			extraCharge5=extraCharge5+50;
			extraChargeDesc5=extraChargeDesc5+" DC499";
		}
		if(isKY599){
			extraCharge5=extraCharge5+50;
			extraChargeDesc5=extraChargeDesc5+" KY599";
		}
		if(isMC799){
			extraCharge5=extraCharge5+50;
			extraChargeDesc5=extraChargeDesc5+" MC799";
		}
		if(isTX699){
			extraCharge5=extraCharge5+50;
			extraChargeDesc5=extraChargeDesc5+" TX699";
		}
		if(isFM599){
			extraCharge5=extraCharge5+50;
			extraChargeDesc5=extraChargeDesc5+" FM599";
		}
		if(isFM799){
			extraCharge5=extraCharge5+50;
			extraChargeDesc5=extraChargeDesc5+" FM799";
		}
		if(isFM699){
			extraCharge5=extraCharge5+50;
			extraChargeDesc5=extraChargeDesc5+" FM699";
		}
		if(isPCCustom){
			extraCharge5=extraCharge5+50;
			extraChargeDesc5=extraChargeDesc5+" Powder Coat Custom";
		}
		if(isGCL500){
			extraCharge5=extraCharge5+50;
			extraChargeDesc5=extraChargeDesc5+" GCL500";
		}
		if(isGKY599){
			extraCharge5=extraCharge5+50;
			extraChargeDesc5=extraChargeDesc5+" GKY599";
		}
		if(isGMC799){
			extraCharge5=extraCharge5+50;
			extraChargeDesc5=extraChargeDesc5+" GMC799";
		}
		if(isGTX699){
			extraCharge5=extraCharge5+50;
			extraChargeDesc5=extraChargeDesc5+" GTX699";
		}
		if(isPCCustom_NOAL){
			extraCharge5=extraCharge5+50;
			extraChargeDesc5=extraChargeDesc5+" PCCustom_NOAL";
		}
		if(isPCCustom_NOAL){
			extraCharge5=extraCharge5+50;
			extraChargeDesc5=extraChargeDesc5+" PCCustom_NOAL";
		}



	pInfCATCHALL_DESC5=extraChargeDesc5;

	pInfCATCHALL5=extraCharge5;







		//out.println("This is Greg's new code for finishing cost.<BR><table border='1'><tr><TD>model</TD><TD>price</TD><TD>gals</TD></TR>");
		for(int i=0; i<pbModel.size(); i++){
			//out.println("HERE"+pbModel.size()+"::<BR>");
			double difference=0;
			double totGals=0;

			for(int x=0; x<VI_MAX_SUBLINE; x++){
				//out.println(x+"::<BR>");
				//out.println("::"+pbModel.elementAt(i).toString()+"::"+finish[x]+"::<BR>");

				if(pbModel.elementAt(i).toString().equals(finish[x])){
					if(gals[x]!= null && gals[x].trim().length()>0){
						totGals=totGals+new Double(gals[x]).doubleValue();
						difference=difference+new Double(gals[x]).doubleValue()*new Double(pbDifference.elementAt(i).toString()).doubleValue();
					}
					//out.println(gals[x]+"::"+pbDifference.elementAt(i).toString()+"<BR>");
				}
			}

			//out.println("<TR><TD>"+pbModel.elementAt(i).toString()+"</TD><TD>"+difference+"</TD><TD>"+totGals+"</TD></TR>");
			if(totGals>=110){
				costDifference=costDifference+difference;
				//out.println("<TR><TD COLSPAN='3'>TOTAL DIFFERENCE "+costDifference+"</TD></TR>");
			}
		}
		//out.println("<TR><TD COLSPAN='3'>TOTAL DIFFERENCE "+costDifference+"</TD></TR>");
		//out.println("</table>");














































	    }
	catch(Exception e0)
	   {
	   //out.println("ERROR: While reading costs..."+e0+"<BR>");
	   }

// START of Cleardmrecs formula - Delete records in CS tables populated by Data Manager

		// This code was updated to delete orphaned entries in the cs_costing table when lines are deleted.

		String VS_MARKS = " ";

		// Find the orphans and delete them in the cs_costing table or warn about missing cost entries
		try
		    {
		// out.println("Found "+VI_N_OF_COST+" entries in 'cs_ costing' for "+VI_N_OF_SUBL+" sublines.");

		    for(int i=0; i<VI_N_OF_COST; i++){
			  int cur_cost=subline[i];
			  int mismatch=0;
			  boolean match=false;
			  for(int j=0; j<VI_N_OF_SUBL; j++){
				  if(cur_cost == subline[j]){
					 match=true;
					 }
				  }
			   if(!match){
				  String sel1 = "DELETE FROM cs_costing WHERE order_no ='"+VS_ORDERNO+"' AND item_no='"+cur_cost+"'";
				  int rs1=stmt.executeUpdate(sel1);
				  out.println("Delete orphaned entry for line "+cur_cost+" from 'cs_costing' result: "+rs1);
				  }
			  }

		    for (int m=0;m<VI_N_OF_SUBL;m++){
			  boolean got_match=false;
			  int n=0;
			  //if(VI_N_OF_COST >1){
					// out.println( subl_c[n]+"::"+subline[m]+"<BR>");
			  for (n=0;n<VI_N_OF_COST;n++){

				 if ( subl_c[n]==subline[m]){
					// out.println( subl_c[n]+"::"+subline[m]+"<BR>");
					got_match=true;
				    }
				 }
			  // }
			   if (!got_match) {
				 VS_MARKS=VS_MARKS+subline[m]+", ";
				 out.println("No entry for line "+subline[m]+" in the cs_costing table!");
				 }
			   }
		    }
		catch(Exception e2)
		   {
			myConn.rollback();
		    out.println("ERROR deleting cs_costing table: "+e2);
		   }
//out.println(VI_N_OF_SUBL+"::"+VI_N_OF_COST+"<BR>");
		if(VI_N_OF_SUBL > VI_N_OF_COST){
			out.println("ERROR: Re-submit lines: "+VS_MARKS);
			}

// end of Cleardmrecs formula
// try block e1
	if (VS_ID.equals("ADS")){
		VR_SETUPCOST = setup_qty * 2;
		if (VR_SETUPCOST < 34.0 && setup_qty > 0) {
			VR_SETUPCOST=34.0;
			}
		}

// try block e3

//out.println("<font color='blue'>VI_ = "+VI_TEST_TYPE+"<BR>");

//out.println("<font color='blue'>{LVRDATA/STDCOST} = "+VR_STDCOST+"<BR>");
//out.println("<font color='blue'>{LVRDATA/RUNCOST} = "+VR_RUNCOST+"<BR>");

if (VS_ID.equals("GRILLE")){

urlReset="access_central_calc.jsp?reset=yes&q_no="+order_no+"&cityState="+cityState+"&cityx="+cityx+"&statex="+statex+"&type="+ordertype+"&countRows=0&qtype="+qtype+"&CSDECO="+CSDECO+"&DESC="+desc+"&ADD="+add+"&SECT="+sect+"&DATE"+date+"&section="+section+"&isNotSec="+isNotSec+"&sectionLines="+sectionLines;
//out.println(urlReset);
	//out.println("<font color='blue'>Total Grille Setup cost = "+VR_SETUPCOST+"<BR><BR>");
}
if(urlReset.length()>600){
urlReset=urlReset.substring(0,600);
}
//out.println("<font color='blue'>{LVRDATA/WEIGHT} = "+VR_WEIGHT+"<BR>");
//out.println("<font color='blue'>{LVRDATA/TOTSF} = "+VR_SQFT+"<BR>");
//out.println("<font color='blue'>{LVRDATA/TOTPERIM} = "+VR_PERIM+"<BR>");
//out.println("<font color='blue'>{LVRDATA/TOTFINCOST} = "+VR_TOTFINCOST+"<BR>");
//out.println("<font color='blue'>{LVRDATA/TOTPAINTSF} = "+VR_TOTSURF+"<BR>");
//out.println("<font color='blue'>{LVRDATA/TOTCOMM} = "+VR_TOTCOMM+"<BR>");
//out.println("<font color='blue'>{LVRDATA/TOTPRICE} = "+VR_TOTPRICE+"<BR>");
//out.println("<font color='blue'>{LVRDATA/TOTQTY} = "+VR_TOTQTY+"<BR>");
//double summary = VR_STDCOST + VR_RUNCOST + VR_SETUPCOST;
//out.println("<font color='blue'>{INFO/SUMMARY} = "+summary+"<BR>");

	// end of Summary formula

	// run database query of cs_defaults
	//out.println("<font color='black'> query db cs_defaults table for "+VS_ID+"<BR>");
	ResultSet rs2=stmt.executeQuery("select * from cs_defaults where product_id ='"+VS_ID+"' and warhse='2'");
	if(rs2 != null){
		while(rs2.next()){
			dlspeed=rs2.getDouble("dlspeed");
			hrrate=rs2.getDouble("hrrate");
			enghrrate=rs2.getDouble("enghrrate");
			pmhrrate=rs2.getDouble("pmhrrate");
			defcommperc=rs2.getDouble("defcommperc");
			fcperc=rs2.getDouble("fcperc");
			defmargperc=rs2.getDouble("defmargperc");
			commfcperc=rs2.getDouble("commfcperc");
			spfactor=rs2.getDouble("spfactor");
	    //out.println("<font color='blue'>{defmargperc} = "+defmargperc+"<BR>");
	    //out.println("<font color='blue'>{commfcperc} = "+commfcperc+"<BR>");
		}
	}
	rs2.close();
	//out.println("<font color='blue'>results of query dlspeed="+dlspeed+" spfactor="+spfactor+" etc....<BR>");


	//Initreset formula - Initialization and reset of the SPC
	//out.println("<font color='black'> run initreset formula<BR>");
//out.println(" p inf cost "+pInfCOST+"<BR>");
	//pInfCOST = VR_STDCOST + VR_RUNCOST + VR_SETUPCOST-costDifference;
	pInfCOST = VR_STDCOST + VR_RUNCOST + VR_SETUPCOST;
	//		 out.println("VR_STDCOST: "+VR_STDCOST+"Run cost::"+VR_RUNCOST+"Setup cost: "+VR_SETUPCOST+"<br>");
	//		 out.println("pInf cost "+pInfCOST+"<br>");
	pIndTOTPERIM = VR_PERIM;
	pIndMATLESSFIN = VR_STDCOST - VR_TOTFINCOST;

	if(VS_ID.equals("ADS")){
		//out.println("<font color='black'> ADS<BR>");
		pInfFCPERC = 9.0;

		if(CSDECO.equals("D")){
		defcommperc = 15.0;
		commfcperc = 13.65;
		}
	}  // ADS

	else {
		//if(group.equals("CanEstim")){
		///	double tempShip=VR_WEIGHT*1.2*.1;
		///	BigDecimal bd = new BigDecimal(VR_WEIGHT);
		///	bd=bd.setScale(0,BigDecimal.ROUND_UP);
		///	tempShip=bd.doubleValue()*.65+tempShip;
		//	out.println(tempShip);
		///	pInfFC=tempShip;
		//}
		//else{
			//out.println("<font color='black'> LVR<BR>");
			// MODIFIED AC 10/4/02 TO MATCH AS 400, PER GERALD
			if (pInfCOST <= 5200){
				pInfFCPERC = (long)((12.75 - pInfCOST * 3.25 / 5200.0) * 100);
				pInfFCPERC = pInfFCPERC / 100.0;
			}
			if (pInfCOST > 5200 && pInfCOST <= 16700){
				pInfFCPERC = (long)((9.51 + (5200 - pInfCOST) * 2.51 / 11500.0) * 100);
				pInfFCPERC = pInfFCPERC / 100.0;
			}
			if (pInfCOST > 16700){
				pInfFCPERC = 7.0;
			}

			//J.H. ADDED THE  LINE BELOW TO THE FORMULA ON 3/23/05. THIS WAS NEEDED DUE TO AN
			// INCREASE IN FREIGHT COSTS. I WAS INSTRUCTED TO INCREASE FREIGHT AND CRATE RATES
			// FROM 9% TO 10.75%. THIS WAS EASY IN ERAPID DUE TO THE FACT THAT F&C WAS A FIXED 9%. IN
			// THE FORMULAS IT VARIES BASED ON JOB COST. SO IN THE FORMULAS I SIMPLY MULTIPLIED THE
			// PREVIOUSLY CALCULATED FCPERC BY 1.194 THIS IS EQUAL TO 10.75/9.
			// Modified on 9/25/06 per T.SZ. to increase all fc by 2%

			//pInfFCPERC = pInfFCPERC * 1.194 * 1.02;
			// Modified on 05/02/08 per ES. to increase all fc by 4%
			if(VS_ID.equals("LVR") || VS_ID.equals("GRILLE")){

				pInfFCPERC = (pInfFCPERC * 1.194 * 1.02)+2;
			}
			else{
				pInfFCPERC = pInfFCPERC * 1.194 * 1.02;
			}
			//out.println(pInfFCPERC+":: HERE");
		//}

	} // LVR
	//out.println("<font color='blue'>{pInfFCPERC} = "+pInfFCPERC+"<BR>");

		// SPFACTOR  CAN BE CALCULATED BASED ON CONSTANTS IN THE DEFAULTS TABLE. THE .659
		// NUMBER IS CALCULATED BY TAKING (100 - DEFAULT MARGIN PERCENT (DEFMARGPERC) -
		// COMMISION FREIGHT AND CRATE PERCENT (COMMFCPERC)) / 100. HENCE FOR LOUVERS THE
		// FORMULA IS (100 - *25 - 9.1) / 100 = .659. FOR GRILLES IT IS (100 - 35 - 10.8) / 100 = .542.


	    //out.println("<font color='blue'>FCPERC = "+pInfFCPERC+"<BR>");
		pInfCATCHALL = 0.0+extraCharge5;
		pInfINSTALL = 0.0;
		pInfCOMMPERC = defcommperc;
		pInfSTDCOMMPERC=pInfCOMMPERC;

		pInfMARGPERC = defmargperc;
if(VS_ID.equals("FSM")){
    int countDoorSizes=0;
    ResultSet rsNumDoors=stmt.executeQuery("select distinct width,height from cs_costing where order_no='"+order_no+"'");
    if(rsNumDoors != null){
        while(rsNumDoors.next()){
            countDoorSizes++;
        }
    }
    rsNumDoors.close();
    pInfDHOURS=8*countDoorSizes;
    pInfLHOURS=8*countDoorSizes;
    pInfEHOURS=6*countDoorSizes;
}
else{

		//pInfDHOURS = Math.round(pInfCOST / dlspeed / 2 * 100.0) / 100.0;
		//pInfLHOURS = Math.round(pInfCOST / dlspeed / 2 * 50.0) / 100.0;
		pInfDHOURS = Math.round(pInfCOST / dlspeed);
		pInfLHOURS = Math.round(pInfCOST / dlspeed / 2);
		pInfEHOURS = 0.0;
}
boolean isDade=false;
boolean isPerformLouvers = false;
//out.println("isPerformLouvers----"+isPerformLouvers);
//out.println("pInfEHOURS-Before 2 hours addition--"+pInfEHOURS);
for(int i=0; i<model_c.length; i++){
  //  out.println(model_c[i]+"::");
    if(!isDade&&model_c[i]!=null&&model_c[i].startsWith("DC")){
        pInfEHOURS=pInfEHOURS+4;
        isDade=true;
    }
	 if(!isPerformLouvers && model_c[i]!=null && ( model_c[i].equalsIgnoreCase("PL4080") || model_c[i].equalsIgnoreCase("PL5700")   )){
        pInfEHOURS=pInfEHOURS+2;
        isPerformLouvers=true;
    }  
}

//out.println("pInfEHOURS-After 2 hours addition--"+pInfEHOURS);
		pInfPMHOURS = 0.0;
		pInfTOTHOURS = pInfDHOURS + pInfLHOURS + pInfEHOURS + pInfPMHOURS;
		pInfD = pInfDHOURS * hrrate;
		pInfL = pInfLHOURS * hrrate;
		pInfE = pInfEHOURS * enghrrate;
		pInfP = pInfPMHOURS * pmhrrate;
		pInfADMINDOLLARS = pInfD + pInfE + pInfL + pInfP;
		spfactor = Math.round((((100 - defmargperc - commfcperc) / 100) - pInfFCPERC / 100) * 10000.0) / 10000.0;
		pInfSELLPRICE = Math.round((pInfCATCHALL + pInfADMINDOLLARS + pInfCOST) / spfactor) + 0.0;
		//out.println("c"+pInfCATCHALL+"admin"+pInfADMINDOLLARS+"cost"+pInfCOST+"sale"+pInfSELLPRICE+"spfactor"+spfactor);
		pInfCOSTPERC = Math.round(pInfCOST / pInfSELLPRICE * 100 * 100.0) / 100.0;
		//out.println("pInfCOSTPERC " + pInfCOSTPERC);
		pInfADMINPERC = Math.round(pInfADMINDOLLARS / pInfSELLPRICE * 100 * 100.0) / 100.0;
		pInfCATCHALLPERC = pInfCATCHALL / pInfSELLPRICE * 100.0;
		// pInfCATCHALLWT = 0;
		pInfSUBTOTPERC = pInfSUBTOTAL / pInfSELLPRICE * 100.0;
		pInfFC = Math.round(pInfFCPERC / 100 * pInfSELLPRICE * 100.0) / 100.0;
		// this is where pInfFC is initialized
		pInfSUBTOTAL = Math.round((pInfCOST + pInfADMINDOLLARS + pInfFC + pInfCATCHALL) * 100.0) / 100.0;
		pInfMARGDOLLARS = Math.round(pInfSELLPRICE * pInfMARGPERC / 100 * 100.0) / 100.0;
		pInfCOMMDOLLARS = Math.round(commfcperc / 100 * pInfSELLPRICE * 100.0) / 100.0;
		pInfSTDCOMMDOLLARS=pInfCOMMDOLLARS;

		pInfTOTAL = Math.round(pInfSELLPRICE + pInfINSTALL);
		pInfCOMMFCPERC = Math.round(pInfCOMMDOLLARS / pInfSELLPRICE * 100 * 100.0) / 100.0;
		pIndTOTSF = VR_TOTSF;
/*

		if(VR_WEIGHT<400){
			pIndTOTWT = VR_WEIGHT * 1.3;
		}
		else if(VR_WEIGHT<3000){
			pIndTOTWT = VR_WEIGHT * 1.2;
		}
		else{
			pIndTOTWT = VR_WEIGHT * 1.15;
		}
*/
//out.println(" VR_WEIGHT 1 :: " +VR_WEIGHT+" ::<BR>");
//out.println(" pIndTOTWT 1 :: " + pIndTOTWT+" ::<BR>");
//changed on April 11 2019 by Greg as reqeusted in tac 83586
/*
		if(VR_WEIGHT<250){
			pIndTOTWT = VR_WEIGHT * 1.5;
		}
		else if(VR_WEIGHT<500){
			pIndTOTWT = VR_WEIGHT * 1.3;
		}
		else if(VR_WEIGHT<2000){
			pIndTOTWT = VR_WEIGHT * 1.23;
		}
		else if(VR_WEIGHT<5000){
			pIndTOTWT = VR_WEIGHT * 1.2;
		}
		else if(VR_WEIGHT<10000){
			pIndTOTWT = VR_WEIGHT * 1.18;
		}
		else{
			pIndTOTWT = VR_WEIGHT * 1.16;
		}
*/
		if(VR_WEIGHT<250){
			pIndTOTWT = VR_WEIGHT * 1.56;
		}
		else if(VR_WEIGHT<500){
			pIndTOTWT = VR_WEIGHT * 1.36;
		}
		else if(VR_WEIGHT<2000){
			pIndTOTWT = VR_WEIGHT * 1.29;
		}
		else if(VR_WEIGHT<5000){
			pIndTOTWT = VR_WEIGHT * 1.25;
		}
		else if(VR_WEIGHT<10000){
			pIndTOTWT = VR_WEIGHT * 1.22;
		}
		else{
			pIndTOTWT = VR_WEIGHT * 1.20;
		}
//out.println(" VR_WEIGHT 2 :: " +VR_WEIGHT+" ::<BR>");
//out.println(" pIndTOTWT 2 :: " + pIndTOTWT+" ::<BR>");

// pIndTOTWT is set here
// following is code for correcting freight for grilles

	int v=cityState.indexOf("@");
	if(v>0){
		city=cityState.substring(0,v);
		if(v<cityState.length()){
			state=cityState.substring(v+1);
		}
	}
//out.println("HERE4"+VS_ID+"::"+cityx+"::"+statex+"::"+city+"::"+state+"::"+cityState);
//if(((VS_ID.equals("GRILLE")||VS_ID.equals("LVR")) && !(cityx.equals(city) && statex.equals(state)))||(reset!=null && reset.equals("yes"))){
	//out.println("HERE4.5");
	String columnName="";
	if(pIndTOTWT < 300){
		columnName="max300";
	}
	else if(pIndTOTWT <= 500){
		columnName="max500";
	}
	else if(pIndTOTWT <= 1000){
		columnName="max1000";
	}
	else if(pIndTOTWT <= 2000){
		columnName="max2000";
	}
	else if(pIndTOTWT <= 5000){
		columnName="max5000";
	}
	else if(pIndTOTWT <= 10000){
		columnName="max10000";
	}
	else if(pIndTOTWT <= 20000){
		columnName="max2000";
	}
	else if(pIndTOTWT <= 30000){
		columnName="max30000";
	}
	else if(pIndTOTWT <= 100000){
		columnName="max100000";
	}
	//out.println("HERE5");
	//out.println(" pIndTOTWT GSO " + pIndTOTWT);
	//out.println(" Query " + "Select "+columnName+" from cs_grille_ltl where state='"+state+"' and city='"+city+"'");
	if(city != null && city.length()>0 && state != null && state.length() >0 && columnName != null & columnName.length() >0){
		ResultSet rsTransport=stmt.executeQuery("Select "+columnName+" from cs_grille_ltl where state='"+state+"' and city='"+city+"'");
		if(rsTransport != null){
			while(rsTransport.next()){
				pInfFREIGHT=(new Double(rsTransport.getString(1)).doubleValue())*pIndTOTWT;
			}
		}
		rsTransport.close();
//out.println(pInfFREIGHT+"::GSO1<BR>");
		if(city.equals("Honolulu") && state.equals("HI")){
			for(int x=0; x<VI_MAX_SUBLINE; x++){
				if(SYSDEPTH[x]!=null && SQFT[x]!=null){
					double tempSysDepth=0;
					//out.println(SYSDEPTH[x]+"::<BR>");
					if(SYSDEPTH[x].toUpperCase().indexOf("MM")>0){
						SYSDEPTH[x]=SYSDEPTH[x].replace("mm", "");
						SYSDEPTH[x]=SYSDEPTH[x].replace("MM", "");
						tempSysDepth=(new Double(SYSDEPTH[x]).doubleValue()*0.0393701)+3;
					}
					else{
						SYSDEPTH[x]=SYSDEPTH[x].replace("\"", "");
						String[] g=SYSDEPTH[x].split(" ");
						double tempDepth=0;
						for(int i=0; i<g.length; i++){
							boolean isFract=false;
							for (int ii = 0; ii < g[i].length(); ii++) {
								char c = g[i].charAt(ii);
								int j = (int)c;
								if(j==47){
									isFract=true;
								}
							}
							if(isFract){
								String[] frac = g[i].split("/");
								tempDepth=tempDepth+new Double(frac[0]).doubleValue()/new Double(frac[1]).doubleValue();
							}
							else{
								tempDepth=tempDepth+new Double(g[i]).doubleValue();
							}
						}
						tempSysDepth=tempSysDepth+tempDepth+3;
					}
					pInfFREIGHT=pInfFREIGHT+(((tempSysDepth/12)*new Double(SQFT[x]).doubleValue())*12.0);
				}
			}
		}
	}
	else{
		pInfFREIGHT=0;
	}
//out.println("HERE6");
//out.println(pIndTOTWT+" GSO HERE2<BR>");
//out.println(pInfCRATE+" GSO pInfCRATE<BR>");
	//pInfCRATE=(pIndTOTWT/100)*28;
	//new crate calc as per Eric Jensen Nov 30 2012
	if(pIndTOTWT<500){
		pInfCRATE=(pIndTOTWT/75)*35;
	}
	else if(pIndTOTWT<3000){
		pInfCRATE=(pIndTOTWT/100)*35;
	}
	else{
		pInfCRATE=(pIndTOTWT/100)*35;
	}
	//out.println(pInfCRATE+" GSO pInfCRATE 2 <BR>");
	if(pInfCRATE<35){
		pInfCRATE=35;
	}
	//if(export.equals("on")){
		//out.println(pIndTOTWT+"::"+pInfCATCHALLWT);
	//	exportCrate=((pIndTOTWT+ pInfCATCHALLWT)/100)*35;
	//}
	pInfFC=pInfCRATE+pInfFREIGHT+exportCrate;

//must run changeFreight code here to correct numbers

	pInfSUBTOTAL = pInfCOST + pInfADMINDOLLARS + pInfFC + pInfCATCHALL;

	pInfSELLPRICE = ((100 * (pInfSUBTOTAL - pInfFC * pInfCOMMPERC / 100.0)) / (100.0 - pInfMARGPERC - pInfCOMMPERC));

	pInfFCPERC = (pInfFC / pInfSELLPRICE * 100 * 100.0) / 100;
	pInfCOMMDOLLARS = (pInfSELLPRICE * 0.91 * pInfCOMMPERC / 100 * 100.0) / 100;
	pInfSTDCOMMDOLLARS=pInfCOMMDOLLARS;
	//out.println("HERE7");
	pInfMARGDOLLARS = (pInfSELLPRICE * pInfMARGPERC / 100 * 100.0) / 100;
	pInfCOMMFCPERC = (pInfCOMMDOLLARS / pInfSELLPRICE * 100 * 100.0) / 100;
	pInfADMINPERC = (pInfADMINDOLLARS / pInfSELLPRICE * 100 * 100.0) / 100;
	pInfSUBTOTPERC = (pInfSUBTOTAL / pInfSELLPRICE * 100 * 100.0) / 100.0;
	//out.println(" pInfCOST : "+pInfCOST+" pInfSELLPRICEc : "+pInfSELLPRICE);
	pInfCOSTPERC = (pInfCOST / pInfSELLPRICE * 100 * 100.0) / 100;
	pInfTOTAL = pInfSELLPRICE + pInfINSTALL;
// end of changeFreight stuff

//out.println("HERE3");

		pIndYIELD = Math.round(pInfSELLPRICE / pIndTOTWT * 100.0) / 100.0;
		//out.println("HERE1"+pIndYIELD+"<BR>");
		pIndDOLLARSF = Math.round(pInfSELLPRICE / VR_TOTSF * 100.0) / 100.0;
		pIndUNITPRICE = Math.round(pInfSELLPRICE / VR_TOTQTY * 100.0) / 100.0;
		pInfSELLPERC = 100.0;
		//{FLAGS/INIT} = 1

		VR_ADJWEIGHT = pIndTOTWT + pInfCATCHALLWT * 1.2;

//out.println("<font color='blue'>{INF/COST} = "+pInfCOST+"<BR>");
//out.println("<font color='blue'>{INF/SELLPRICE} = "+pInfSELLPRICE+"<BR>");
		// end of Initreset formula

	//Modify formula - Update all fields based on modified values
	//out.println("<font color='black'>Run Modify formula<BR><BR>");

	//{FLAGS/BID_DESC} = {QUOTE_DATA/DESC}

	// Restore information from subline
	pIndTOTPAINTSF = VR_TOTSURF;
	//out.println("pInfALLHOURS-After 2 hours addition--"+pInfEHOURS);
	pInfALLHOURS = pInfDHOURS + ", " + pInfLHOURS + ", " + pInfEHOURS + ", " + pInfPMHOURS;

	pInfSUBTOTPERC = Math.round(pInfSUBTOTAL / pInfSELLPRICE * 100 * 100.0) / 100.0;

	if(pIndTOTWT == 0){
		pIndYIELD = 0.0;
		//out.println("HERE2"+pIndYIELD+"<BR>");
	}
	else {
		pIndYIELD = Math.round(pInfSELLPRICE / (pIndTOTWT + pInfCATCHALLWT * 1.2) * 100.0) / 100.0;
		//out.println("HERE3"+pIndYIELD+"<BR>");
	}
	pIndTOTSF = VR_SQFT;
	if(pIndTOTSF == 0){
		pIndDOLLARSF = 0.0;
	}
	else {
		pIndDOLLARSF = Math.round(pInfSELLPRICE / pIndTOTSF * 100.0) / 100.0;
	}
	pIndUNITPRICE = Math.round(pInfSELLPRICE / VR_TOTQTY * 100.0) / 100.0;

	VR_ADJWEIGHT = pIndTOTWT + pInfCATCHALLWT * 1.2;

	// end of modify formula

} // end of if ordertype = q

	DecimalFormat for1 = new DecimalFormat("###.##");
	for1.setMaximumFractionDigits(2);
	for1.setMinimumFractionDigits(2);

if(countRows>0){
	double pInfFREIGHTold=(new Double(for1.format(pInfFREIGHT)).doubleValue());
	pInfFREIGHT=(new Double(request.getParameter("pInfFREIGHT")).doubleValue());
	String cityStateOld=cityx+"@"+statex;
	if(!VS_ID.equals("FSM")){
	if(!(cityState.equals(cityStateOld))){
		//out.println(cityx+"@"+statex+":::"+cityState);
		costCompare=false;
	}
	else if(!(pInfFREIGHT==pInfFREIGHTold)){
		manualFreight="Y";
	}
}
	pInfCRATE=(new Double(request.getParameter("pInfCRATE")).doubleValue());
	pIndDOLLARSF=(new Double(request.getParameter("pIndDOLLARSF")).doubleValue());
	pIndMATLESSFIN=(new Double(request.getParameter("pIndMATLESSFIN")).doubleValue());
	pIndTOTPAINTSF=(new Double(request.getParameter("pIndTOTPAINTSF")).doubleValue());
	pIndTOTPERIM=(new Double(request.getParameter("pIndTOTPERIM")).doubleValue());
	pIndTOTSF=(new Double(request.getParameter("pIndTOTSF")).doubleValue());
	pIndUNITPRICE=(new Double(request.getParameter("pIndUNITPRICE")).doubleValue());
	pIndYIELD=(new Double(request.getParameter("pIndYIELD")).doubleValue());
	pInfCATCHALL_DESC=((request.getParameter("pInfCATCHALL_DESC")));
	pInfADMINDOLLARS=(new Double(request.getParameter("pInfADMINDOLLARS")).doubleValue());
	pInfADMINPERC=(new Double(request.getParameter("pInfADMINPERC")).doubleValue());
	pInfALLHOURS=((request.getParameter("pInfALLHOURS")));
	pInfCATCHALL=(new Double(request.getParameter("pInfCATCHALL")).doubleValue());
	pInfCATCHALLPERC=(new Double(request.getParameter("pInfCATCHALLPERC")).doubleValue());
	pInfCATCHALLWT=(new Double(request.getParameter("pInfCATCHALLWT")).doubleValue());
	//if(export.equals("on")){
	//out.println(pIndTOTWT+"::"+pInfCATCHALLWT);
	//exportCrate=((pIndTOTWT+ pInfCATCHALLWT)/100)*35;
	if(request.getParameter("pInfExportCrate") != null && request.getParameter("pInfExportCrate").trim().length()>0 &&  !request.getParameter("pInfExportCrate").equals("null")){
		exportCrate=(new Double(request.getParameter("pInfExportCrate")).doubleValue());
	}
	else{
		exportCrate=0;
	}




	//}
	pInfCOMMDOLLARS=(new Double(request.getParameter("pInfCOMMDOLLARS")).doubleValue());
	pInfCOMMFCPERC=(new Double(request.getParameter("pInfCOMMFCPERC")).doubleValue());
	pInfCOMMPERC=(new Double(request.getParameter("pInfCOMMPERC")).doubleValue());

	pInfSTDCOMMDOLLARS=(new Double(request.getParameter("pInfSTDCOMMDOLLARS")).doubleValue());
	pInfSTDCOMMPERC=(new Double(request.getParameter("pInfSTDCOMMPERC")).doubleValue());

	pInfKACOMMDOLLARS=(new Double(request.getParameter("pInfKACOMMDOLLARS")).doubleValue());
	pInfKACOMMPERC=(new Double(request.getParameter("pInfKACOMMPERC")).doubleValue());
if(pInfCOMMDOLLARS>0 && pInfSTDCOMMDOLLARS==0 && pInfKACOMMDOLLARS==0){
		pInfSTDCOMMDOLLARS=pInfCOMMDOLLARS;
		pInfSTDCOMMPERC=pInfCOMMPERC;
}
	double pInfCOSTOld=(new Double(for1.format(pInfCOST)).doubleValue());
	pInfCOST=(new Double(request.getParameter("pInfCOST")).doubleValue());
	if(!(pInfCOSTOld==pInfCOST)){
		costCompare=false;
	}
	pInfCOSTPERC=(new Double(request.getParameter("pInfCOSTPERC")).doubleValue());
	pInfD=(new Double(request.getParameter("pInfD")).doubleValue());
	pInfDHOURS=(new Double(request.getParameter("pInfDHOURS")).doubleValue());
	pInfE=(new Double(request.getParameter("pInfE")).doubleValue());
	pInfEHOURS=(new Double(request.getParameter("pInfEHOURS")).doubleValue());
	pInfFC=(new Double(request.getParameter("pInfFC")).doubleValue());
	pInfFCPERC=(new Double(request.getParameter("pInfFCPERC")).doubleValue());
	pInfINSTALL=(new Double(request.getParameter("pInfINSTALL")).doubleValue());
	pInfL=(new Double(request.getParameter("pInfL")).doubleValue());
	pInfLHOURS=(new Double(request.getParameter("pInfLHOURS")).doubleValue());
	pInfMARGDOLLARS=(new Double(request.getParameter("pInfMARGDOLLARS")).doubleValue());
	pInfMARGPERC=(new Double(request.getParameter("pInfMARGPERC")).doubleValue());
	pInfP=(new Double(request.getParameter("pInfP")).doubleValue());
	pInfPMHOURS=(new Double(request.getParameter("pInfPMHOURS")).doubleValue());
	pInfSELLPERC=(new Double(request.getParameter("pInfSELLPERC")).doubleValue());
	pInfSELLPRICE=(new Double(request.getParameter("pInfSELLPRICE")).doubleValue());
	pInfSUBTOTAL=(new Double(request.getParameter("pInfSUBTOTAL")).doubleValue());
	pInfSUBTOTPERC=(new Double(request.getParameter("pInfSUBTOTPERC")).doubleValue());
	pInfTOTAL=(new Double(request.getParameter("pInfTOTAL")).doubleValue());
	pInfTOTHOURS=(new Double(request.getParameter("pInfTOTHOURS")).doubleValue());
	pInfCATCHALL_DESC1=request.getParameter("pInfCATCHALL_DESC1");
	pInfCATCHALL_DESC2=request.getParameter("pInfCATCHALL_DESC2");
	pInfCATCHALL_DESC3=request.getParameter("pInfCATCHALL_DESC3");
	pInfCATCHALL_DESC4=request.getParameter("pInfCATCHALL_DESC4");
	pInfCATCHALL_DESC5=request.getParameter("pInfCATCHALL_DESC5");
	pInfCATCHALL1=(new Double(request.getParameter("pInfCATCHALL1")).doubleValue());
	pInfCATCHALL2=(new Double(request.getParameter("pInfCATCHALL2")).doubleValue());
	pInfCATCHALL3=(new Double(request.getParameter("pInfCATCHALL3")).doubleValue());
	pInfCATCHALL4=(new Double(request.getParameter("pInfCATCHALL4")).doubleValue());
	pInfCATCHALL5=(new Double(request.getParameter("pInfCATCHALL5")).doubleValue());
	pInfCATCHALLWT1=(new Double(request.getParameter("pInfCATCHALLWT1")).doubleValue());
	pInfCATCHALLWT2=(new Double(request.getParameter("pInfCATCHALLWT2")).doubleValue());
	pInfCATCHALLWT3=(new Double(request.getParameter("pInfCATCHALLWT3")).doubleValue());
	pInfCATCHALLWT4=(new Double(request.getParameter("pInfCATCHALLWT4")).doubleValue());
	pInfCATCHALLWT5=(new Double(request.getParameter("pInfCATCHALLWT5")).doubleValue());
	//out.println("HERExxxxxx");
}
else
{
	
	String query2="";
	if(isNotSec){
		query2="Select * from cs_access_central where order_no='"+order_no+"'";
	}
	else{
		query2="Select * from cs_access_central where order_no='"+order_no+"' and section_no='s"+section+"'";
	}
	ResultSet rs1=stmt.executeQuery(query2);
	if(rs1 != null){
		while(rs1.next()){
		
			pInfCATCHALLWT=(new Double(rs1.getString("pinfcatchallwt")).doubleValue());
			pInfCATCHALL=(new Double(rs1.getString("pinfcatchall")).doubleValue());
			pInfCATCHALLPERC=(new Double(rs1.getString("pInfcatchallperc")).doubleValue());
			pInfCATCHALL_DESC=rs1.getString("pinfcatchall_desc");

			pInfCATCHALL_DESC1=rs1.getString("pinfCATCHALL_DESC1");
			pInfCATCHALL_DESC2=rs1.getString("pinfCATCHALL_DESC2");
			pInfCATCHALL_DESC3=rs1.getString("pinfCATCHALL_DESC3");
			pInfCATCHALL_DESC4=rs1.getString("pinfCATCHALL_DESC4");
			pInfCATCHALL_DESC5=rs1.getString("pinfCATCHALL_DESC5");
			
			boolean isMultiCatchall=false;
			if(rs1.getString("pInfcatchall1")!= null && rs1.getString("pInfcatchall1").trim().length()>0){
				pInfCATCHALL1=(new Double(rs1.getString("pInfcatchall1")).doubleValue());
				isMultiCatchall=true;
			}
			if(rs1.getString("pInfcatchall2")!= null && rs1.getString("pInfcatchall2").trim().length()>0){
				pInfCATCHALL2=(new Double(rs1.getString("pInfcatchall2")).doubleValue());
				isMultiCatchall=true;
			}
			if(rs1.getString("pInfcatchall3")!= null && rs1.getString("pInfcatchall3").trim().length()>0){
				pInfCATCHALL3=(new Double(rs1.getString("pInfcatchall3")).doubleValue());
				isMultiCatchall=true;
			}
			if(rs1.getString("pInfcatchall4")!= null && rs1.getString("pInfcatchall4").trim().length()>0){
				pInfCATCHALL4=(new Double(rs1.getString("pInfcatchall4")).doubleValue());
				isMultiCatchall=true;
			}
			if(rs1.getString("pInfcatchall5")!= null && rs1.getString("pInfcatchall5").trim().length()>0){
				pInfCATCHALL5=(new Double(rs1.getString("pInfcatchall5")).doubleValue());
				isMultiCatchall=true;
			}
			if(rs1.getString("pInfCATCHALLWT1")!= null && rs1.getString("pInfCATCHALLWT1").trim().length()>0){
				pInfCATCHALLWT1=(new Double(rs1.getString("pInfCATCHALLWT1")).doubleValue());
				isMultiCatchall=true;
			}
			if(rs1.getString("pInfCATCHALLWT2")!= null && rs1.getString("pInfCATCHALLWT2").trim().length()>0){
				pInfCATCHALLWT2=(new Double(rs1.getString("pInfCATCHALLWT2")).doubleValue());
				isMultiCatchall=true;
			}
			if(rs1.getString("pInfCATCHALLWT3")!= null && rs1.getString("pInfCATCHALLWT3").trim().length()>0){
				pInfCATCHALLWT3=(new Double(rs1.getString("pInfCATCHALLWT3")).doubleValue());
				isMultiCatchall=true;
			}
			if(rs1.getString("pInfCATCHALLWT4")!= null && rs1.getString("pInfCATCHALLWT4").trim().length()>0){
				pInfCATCHALLWT4=(new Double(rs1.getString("pInfCATCHALLWT4")).doubleValue());
				isMultiCatchall=true;
			}
			if(rs1.getString("pInfCATCHALLWT5")!= null && rs1.getString("pInfCATCHALLWT5").trim().length()>0){
				pInfCATCHALLWT5=(new Double(rs1.getString("pInfCATCHALLWT5")).doubleValue());
				isMultiCatchall=true;
			}
			if(!isMultiCatchall){
				pInfCATCHALL_DESC1=pInfCATCHALL_DESC;
				pInfCATCHALLWT1=pInfCATCHALLWT;
				pInfCATCHALL1=pInfCATCHALL;
			}
		}
		
	}
}
if((VS_ID.equals("GRILLE")) && (cityState.contains("CA")||cityState.contains("FL")) && !(pInfEHOURS > 0.0)){
		runCalcEngg = true;
	}
if((VS_ID.equals("GRILLE")) && (cityState.contains("CA")||cityState.contains("FL"))){
		resetAndRunCalcEngg = true;
	}
//out.println(pInfEHOURS+": -----later---->>>>>> "+runCalcEngg);

// Code for correcting Freight for grilles was here
//out.println("HERE1");
//out.println(urlReset);
//out.println(pInfSELLPRICE+"::"+pIndTOTWT+"::"+pInfCATCHALLWT);
VR_ADJWEIGHT = pIndTOTWT;
if(exchRate==null || exchRate.trim().length()==0){
	exchRate="0";
}
pInfSELLPRICECAN=pInfSELLPRICE*new Double(exchRate).doubleValue();
//+ pInfCATCHALLWT * 1.2;
//out.println(VR_ADJWEIGHT);
	%>
	<%@ include file="access_central_display.jsp"%>
	<%
	stmt.close();
	myConn.close();

	}
	catch(Exception e){
		//logger.debug("access_central_calc.jsp");
		//logger.debug(e);
		//logger.debug("access_central_calc end");
		out.println(e);
		  }
	%>