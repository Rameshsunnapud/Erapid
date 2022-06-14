payload = dict("string");
jsonobj = json();
Lines = "";
allLines = jsonarray();
tempAllLines = jsonarray();
isEmpty = true;
tmpjsonarray = jsonarray();
modelDocNo = "";
tmpModelDocNo = "";
mdlQty = 1;
mdlCount = -1;
bomLines = "";
noOfLines = 0;
linesCount = 0;
listPrice = 0.0;
netPrice = 0.0;
netAmount = 0.0;
allocatedOverage = 0.0;
line2jason = json();
isBOMPresent = false;
grommetsQtyArray = string[];
curtainsQtyArray = string[];
fabricQtyArray = string[];
meshQtyArray = string[];
weightsQtyArray = string[];
tieBackQtyArray = string[]; 
curtainslistPriceArray = dict("float[]");
curtainsdescriptionArray = dict("string[]"); 
curtainsnetPriceArray = dict("float[]");
curtainsnetAmountArray = dict("float[]");
allocatedOverageArray = dict("float[]");
curtainsunitCostArray = dict("float[]");
seqNumberArray = dict("string[]");
configChangeArray = dict("string[]");
commPctArray = dict("float[]"); 
commPctArr = float[]; 
involveCat = "PS";
salesChannel = salesChannel_t;
returnRequestInitiated = "N";
returnOrderNumber = "";
projectName = project_quote; 
if(returnRequestInitiated_t){
                returnRequestInitiated = "Y";
                salesChannel = salesChannelReturns_t;
                returnOrderNumber = returnedOrderNumber_t;
                projectName = projectReturn_t;
}
results = bmql ("select ICSValue from Involvement_Category where SfdcFieldValue = $involvementCategory_t"); 
for result in results{
   involveCat = get(result, "ICSValue");
}
CarName_OM = "";
ServLevel_OM = "";
ModeTrans_OM = ""; 
shippingMethodArr = split(shippingMethodCode_quote,"-");
CarrierName = shippingMethodArr[0];
ServiceLevel = shippingMethodArr[1];
ModeOfTransport = shippingMethodArr[2]; 
results = bmql ("select CarrierName_OM , ServiceLevel_OM, ModeOfTransport_OM from Shipping_Method where CarrierName = $CarrierName AND ServiceLevel = $ServiceLevel AND ModeOfTransport = $ModeOfTransport"); 
for result in results{
   CarName_OM = get(result, "CarrierName_OM");
   ServLevel_OM = get(result, "ServiceLevel_OM");
   ModeTrans_OM = get(result, "ModeOfTransport_OM");
}
jsonput(jsonobj, "TransactionId", bs_id);
jsonput(jsonobj, "createdDate_t", createdDate_t);
jsonput(jsonobj, "customerPartyId_t", invoiceToPartyID_t); //bill to PartyId
jsonput(jsonobj, "invoiceToPartyID_t", billToCustAccId_t); // bill to cust account id
jsonput(jsonobj, "invoiceToPartySiteID_t", billToSiteUseID_t); //bill to site use id
jsonput(jsonobj, "shipToPartyID_t", shipToPartyID_t); // shipto party id
jsonput(jsonobj, "shipToPartySiteID_t", shipToPartySiteID_t); // ship to party site id 
orderTypeSalesChannel = orderType_quote + " - " + salesChannel; 
jsonput(jsonobj, "currency_t", oRCL_INT_TargetCurrency_t);
jsonput(jsonobj, "orderType_quote", orderTypeSalesChannel);
jsonput(jsonobj, "businessUnit_quote", businessUnit_quote);
jsonput(jsonobj, "transactionId_t", transactionId_t);
jsonput(jsonobj, "version_t", string(version_t));  
jsonput(jsonobj, "paymentTerms_t", paymentTerms_t);
jsonput(jsonobj, "purchaseOrderNumber_t", purchaseOrderNumber_t);
jsonput(jsonobj, "salesChannel_t", salesChannel);
jsonput(jsonobj, "cancelReason_t", cancelReason_t);
jsonput(jsonobj, "oRCL_ERP_PartialShipAllowed_t", string(oRCL_ERP_PartialShipAllowed_t));  
jsonput(jsonobj, "opportunityNumber_t", opportunityNumber_t);
jsonput(jsonobj, "changeOrderType_quote", changeOrderType_quote);
jsonput(jsonobj, "customerPONbr_quote", customerPONbr_quote);
jsonput(jsonobj, "poReceivedDate_quote", poReceivedDate_quote);
jsonput(jsonobj, "requestedDate_quote", requestedDate_quote);
jsonput(jsonobj, "sOAContact_quote", sOAContact_quote);
jsonput(jsonobj, "returnReason_quote", returnReason_quote);
jsonput(jsonobj, "opportunityType_quote", opportunityType_quote);
jsonput(jsonobj, "projectType_quote", projectType_quote);
jsonput(jsonobj, "marketType_quote", marketType_quote);
jsonput(jsonobj, "territoryName_quote", territoryName_quote);
jsonput(jsonobj, "orderNotes_quote", orderNotes_quote);
jsonput(jsonobj, "jobProjectName_quote", projectName);
jsonput(jsonobj, "projectManager_quote", projectManager_quote);
jsonput(jsonobj, "department_quote", department_quote);
jsonput(jsonobj, "reason_quote", reason_quote);
jsonput(jsonobj, "responsibleParty_quote", responsibleParty_quote);
jsonput(jsonobj, "commissionPct_quote", commisionsPct_quote);
jsonput(jsonobj, "SalesOrderRegion", region_quote);
jsonput(jsonobj, "customerGroupCode_quote", customerGroupCode_quote); 
jsonput(jsonobj, "orderRepID", orderRepID);
jsonput(jsonobj, "SpecRepId", specRepID_quote);
jsonput(jsonobj, "territoryRepId", territoryRepID_quote); 
jsonput(jsonobj, "isCommissionable_t", isCommissionable_t); 
jsonput(jsonobj, "involvementCategory_quote", involveCat);
jsonput(jsonobj, "endUserCustomer_t", endUserCustomer_t);
jsonput(jsonobj, "endUserCustomerSiteID_t", endUserPartySiteId_t);
jsonput(jsonobj, "endUserAddressLine1_t", endUserAddressLine1_t);
jsonput(jsonobj, "originalOrderNumber_quote", originalOrderNumber_quote);
jsonput(jsonobj, "multipleRelease_t", multipleRelease_t);
jsonput(jsonobj, "sendSOA_quote", sendSOA_quote);
jsonput(jsonobj, "sBU_t", sBU_t);
jsonput(jsonobj, "estimatedShipDateRequired_t", estimatedShipDateRequired_t );
jsonput(jsonobj, "sendPriceLineDetails_t", sendPriceLineDetails_t);
jsonput(jsonobj, "CSfreightAndCrate", string(CSfreightAndCrate));
jsonput(jsonobj, "_customer_t_first_name", _transaction_quoteToCustomer_t_first_name);
jsonput(jsonobj, "_customer_t_last_name", _transaction_quoteToCustomer_t_last_name);
jsonput(jsonobj, "_invoiceTo_t_first_name", _transaction_invoiceTo_t_first_name);
jsonput(jsonobj, "_invoiceTo_t_last_name", _transaction_invoiceTo_t_last_name);
jsonput(jsonobj, "_shipTo_t_first_name", _transaction_shipTo_t_first_name);
jsonput(jsonobj, "_shipTo_t_last_name", _transaction_shipTo_t_last_name);
jsonput(jsonobj, "BuyingPartyName", buyingPartyName_t);
jsonput(jsonobj, "ShipToPartyName", _transaction_shipTo_t_company_name);
jsonput(jsonobj, "ShipToAddress1", _transaction_shipTo_t_address);
jsonput(jsonobj, "ShipToAddress2", _transaction_shipTo_t_address_2);
jsonput(jsonobj, "ShipToCity", _transaction_shipTo_t_city);
jsonput(jsonobj, "ShipToPostalCode", _transaction_shipTo_t_zip);
jsonput(jsonobj, "ShipToState", _transaction_shipTo_t_state);
jsonput(jsonobj, "ShipToCountry", _transaction_shipTo_t_country);
jsonput(jsonobj, "BillToCustomerName", _transaction_invoiceTo_t_company_name);
jsonput(jsonobj, "BillToAddress1", _transaction_invoiceTo_t_address);
jsonput(jsonobj, "BillToAddress2", _transaction_invoiceTo_t_address_2);
jsonput(jsonobj, "BillToCity", _transaction_invoiceTo_t_city);
jsonput(jsonobj, "BillToPostalCode", _transaction_invoiceTo_t_zip);
jsonput(jsonobj, "BillToState", _transaction_invoiceTo_t_state);
jsonput(jsonobj, "BillToCountry", _transaction_invoiceTo_t_country);
jsonput(jsonobj, "requestType_quote", requestType_quote);
jsonput(jsonobj, "division", division_quote);
jsonput(jsonobj, "noCharge", noCharge_quote); 
jsonput(jsonobj, "orderRep_quote", orderRepID);
jsonput(jsonobj, "influencerRep_quote", influencerRepID_quote);
jsonput(jsonobj, "estimatedShipDate", ""); 
jsonput(jsonobj, "returnOrderNumber", returnOrderNumber);
jsonput(jsonobj, "shipOrderComplete", shipLinesTogether_quote);
jsonput(jsonobj, "infSpecRepId", influencerSpecRepID_t);
jsonput(jsonobj, "infSpecRepPerc", influencerSpecRepPct_t);
jsonput(jsonobj, "infSpecRepTotCom", totalInfluencerSpecRepVal_quote);
jsonput(jsonobj, "infTerRepId", influencerTerrRepID_quote);
jsonput(jsonobj, "infTerRepPerc", influencerTerrRepPct_t);
jsonput(jsonobj, "infTerRepTotCom", totalInfluencerTerrRepVal_quote);
jsonput(jsonobj, "draftingScheduler", draftingScheduler_t);
jsonput(jsonobj, "Attribute1", "");
jsonput(jsonobj, "Attribute2", "");
jsonput(jsonobj, "Attribute3", "");
jsonput(jsonobj, "Attribute4", "");
jsonput(jsonobj, "Attribute5", "");
jsonput(jsonobj, "Attribute6", "");
jsonput(jsonobj, "Attribute7", "");
jsonput(jsonobj, "Attribute8", "");
jsonput(jsonobj, "Attribute9", "");
jsonput(jsonobj, "Attribute10", "");
jsonput(jsonobj, "Attribute11", returnRequestInitiated);
jsonput(jsonobj, "Attribute12", totalTax_t);
jsonput(jsonobj, "Attribute13", CarName_OM);
jsonput(jsonobj, "Attribute14", ServLevel_OM);
jsonput(jsonobj, "Attribute15", ModeTrans_OM);
jsonput(jsonobj, "Attribute16", freightTerms_t);
jsonput(jsonobj, "Attribute17", incoTerms_t);
jsonput(jsonobj, "Attribute18", packingInstructions_quote);
jsonput(jsonobj, "Attribute19", shippingInstructions_quote); 
if(changeOrderInitiated_t){
                jsonput(jsonobj, "Attribute20", "Y");
}
else{
                jsonput(jsonobj, "Attribute20", "N");
} 
jsonput(jsonobj, "quoteType", quoteType_t);
jsonput(jsonobj, "customerServiceContact", orderPlacedBy_t);
jsonput(jsonobj, "architect", architect_quote);
jsonput(jsonobj, "impactTerritory", impactTerritory_t);
jsonput(jsonobj, "isAccountType", isAccountType_t);
jsonput(jsonobj, "commissionable", commisionableAmount_quote);
jsonput(jsonobj, "convertedOrder", convertedOrderNew_quote);
jsonput(jsonobj, "legacyOrderNumber", legacyOrderNumber_t);
jsonput(jsonobj, "legacyDropShipPoNumber", legacyDropShipPONumber_t);
jsonput(jsonobj, "draftingContactName", draftingContactName_t);
jsonput(jsonobj, "draftingContactEmail", draftingContactEmail_t);
jsonput(jsonobj, "originalDrafter", originalDrafter_t);
jsonput(jsonobj, "originalDraftingProject", originalDraftingProject_t);
jsonput(jsonobj, "enduserContact", endUserContact_t); 
jsonput(jsonobj, "enduserPhoneNumber", endUserPhoneNumber_t);
jsonput(jsonobj, "influencerRepName", influencerRepName_t);
jsonput(jsonobj, "influencerRepEmail", influencerRepEmail_t);
jsonput(jsonobj, "orderRepName", orderRepName_t);
jsonput(jsonobj, "orderRepEmail", orderRepEmail_t);
jsonput(jsonobj, "standardCommission", standardCommission_t);
jsonput(jsonobj, "overage", overageAmount_quote);
jsonput(jsonobj, "overagePercentForReps", overagePCTForReps_quote);
jsonput(jsonobj, "SpecRepName", specRepName_t);
jsonput(jsonobj, "SpecRepEmail", specRepEmail_t);
jsonput(jsonobj, "territoryRepName", territoryRepName_t);
jsonput(jsonobj, "territoryRepEmail", territoryRepEmail_t);
jsonput(jsonobj, "rmaCustomerContact", rMACustomerContact_t);
jsonput(jsonobj, "returnAddress", returnAddressNew_t);
jsonput(jsonobj, "overageAmount", overageAmount_quote); 
jsonput(jsonobj, "submittalsNeedByDate", draftNeedByDate_t);
jsonput(jsonobj, "influencerRepId",  influencerRepID_quote);
jsonput(jsonobj, "InfRepPCTOfCommission", influencerRepPct_t);
jsonput(jsonobj, "InfReptotalCommission", totalInfluencerRepVal_quote);
jsonput(jsonobj, "OrderRepPCTOfCommission", orderRepPct_t);
jsonput(jsonobj, "OrderReptotalCommission", totalValueOrderRepVal_quote);
jsonput(jsonobj, "SpecRepPCTOfCommission", specRepPct_t);
jsonput(jsonobj, "SpecReptotalCommission", totalSpecRepVal_quote);
jsonput(jsonobj, "terRepPCTOfCommission", territoryRepPct_t);
jsonput(jsonobj, "terReptotalCommission", totalTrcRepVal_quote); 
docnum = "";
modelNameArray = string[];
docNumArray = string[];
jSONPartNumArray = string[];
quantityPNDict = dict("string");
partTypeDict = dict("string");
modelPartNumDict = dict("string[]");
updatedModelDict = dict("string");
updatedModelDocNumDict = dict("string[]");
modelNameDict = dict("string"); 
for eachline in transactionLine{
                if(eachline._parent_doc_number <> "")
                {
                                if(containskey(modelPartNumDict, eachline.rootElementDocumentNo_l))
                                {
                                                tempArray = get(modelPartNumDict, eachline.rootElementDocumentNo_l);
                                                append(tempArray, eachline._part_number);
                                                put(modelPartNumDict, eachline.rootElementDocumentNo_l, tempArray);
                                }
                                else
                                {
                                                tempArray = string[];
                                                append(tempArray, eachline._part_number);
                                                put(modelPartNumDict, eachline.rootElementDocumentNo_l, tempArray);
                                }
                }
                if(eachline.copyOf_l <> 0 AND containskey(updatedModelDocNumDict, eachline.copyOf_l))
                {
                                tempArray = get(updatedModelDocNumDict, eachline.copyOf_l);
                                append(tempArray, eachline._document_number);
                                put(updatedModelDocNumDict, eachline.copyOf_l, tempArray);
                }
                else
                {
                                if(eachline.copyOf_l <> 0)
                                {
                                                tempArray = string[];
                                                append(tempArray, eachline._document_number);
                                                put(updatedModelDocNumDict, eachline.copyOf_l, tempArray);
                                }
                }
                if(eachline.copyOf_l <> 0 AND NOT containskey(updatedModelDict, eachline.copyOf_l))
                {
                                put(updatedModelDict, eachline.copyOf_l, eachline._document_number);
                }
}
print modelPartNumDict;
isFulTypeBlank = false;
modelName = "";
for line in transactionLine
{
    docnum = line._document_number; // Make a local copy ...    
    if(line._line_bom_part_number ==""){
                                if(containskey(modelNameDict,line.rootElementDocumentNo_l)){
                                                modelName = get(modelNameDict,line.rootElementDocumentNo_l);                     
                                               
                                }                               
                }               
                if(line.fulfillmentType_line == "")
                {
                                isFulTypeBlank = true;
                }
                if(line._model_name <> "" AND line._line_bom_part_number <> "")
                {
                               
                                modelName = line._model_name;
                                modelVariableName = line._model_variable_name;
                                append(modelNameArray, modelVariableName);
                                append(docNumArray, docnum);
                                put(modelNameDict,line._document_number,modelName);
                               
                if(modelName == "Cubicle Curtains" OR modelName == "Cubicle Track" OR modelVariableName == "cubicleCurtains" OR modelVariableName == "surfaceMountedAluminum" OR modelVariableName == "surfaceMountedStainlessSteel" OR modelVariableName == "vASeries" OR modelVariableName == "acrovyn_cr" OR modelVariableName == "surfaceMounted" OR modelVariableName == "cubicleTrack" OR modelVariableName == "ePDM" OR modelVariableName == "ePDMRubber" OR modelVariableName == "flushMountedStainlessSteel" OR modelVariableName == "acrovyn_wc" OR modelVariableName == "hRBSeries" OR modelVariableName == "doorKnobProtector" OR modelVariableName == "hRSeries" OR modelVariableName == "hRSSeries" OR modelVariableName == "kickAndPushPlates" OR modelVariableName == "allMetal_cr")
                                {
                                                isBOMPresent = true;
                                }                               
                                mdlQty = 1;
                                modelDocNo = line._document_number;
                                bomLines = "";
                                noOfLines = 0;
                                linesCount = 0;
                                mdlCount = mdlCount + 1;
                                listPrice = 0.0;
                                netPrice = 0.0;
                                netAmount  = 0.0;
                                allocatedOverage = 0.0;
                                seqNumber = ""; 
                                lineFields = string[];
                                append(lineFields ,"_document_number");
                                append(lineFields ,"_part_desc");
                                append(lineFields ,"listPrice_l");
                                append(lineFields ,"netPrice_l");
                                append(lineFields ,"requestedUnitOfMeasure_l");
                                append(lineFields ,"oRCL_ERP_ShippingInstr_l");
                                append(lineFields ,"taxExempt_l");
                                if(line.returnType_l == ""){
                                                append(lineFields ,"fulfillmentType_line");
                                                append(lineFields ,"actionCode_l");
                                }
                                else{
                                                append(lineFields ,"returnType_l");
                                                append(lineFields ,"returnsActionCode_l");
                                }
                                append(lineFields ,"allocatedOverage_line");
                                append(lineFields ,"adjustedExtendedPrice_line");
                                append(lineFields ,"cancelReason_l");                               
                                append(lineFields ,"contractStartDate_l");
                                append(lineFields ,"contractEndDate_l");
                                append(lineFields ,"OriginalLineReference_l");
                                append(lineFields , "layoutRequired_l");
                                append(lineFields , "_model_segment_name");
                                append(lineFields , "lineDiscountPercent_l");
                                append(lineFields , "newOldExistingFlag_l");
                                append(lineFields , "returnToWarehouse_l");
                                append(lineFields , "returnReason_l");
                                append(lineFields , "unitCost_l");                               
                                validateBomModel = false;
                                flattenChild = false;
                                isSalesBom = true;
                                dict = dict("anytype");      
                                Lines = jsontostr(commerce.getBomStructure(atoi(bs_id),atoi(docnum),lineFields,validateBomModel,flattenChild,isSalesBom,dict));                               
                                bomLines = replace(Lines,",\"children\":[]","");
                                bomLines = replace(bomLines, "layoutRequired_l","layoutrequired");
                                bomLines = replace(bomLines, "_model_segment_name","productLine");
                                bomLines = replace(bomLines, "returnReason_l","returnReason");
                                bomLines = replace(bomLines, "newOldExistingFlag_l","newOldExistingFlag");
                                bomLines = replace(bomLines, "OriginalLineReference_l","OriginalLineReference");
                                bomLines = replace(bomLines, "returnToWarehouse_l","requestedFulfillmentOrganizationCode");
                                bomLines = replace(bomLines, "unitCost_l","estimatedCost");                               
                                jsonarrayappend(tmpjsonarray,json(bomLines));
                                partNumarray = jsonpathgetmultiple(json(bomLines), "$..partNumber");                               
                                allPartNumLoopArray = range(jsonarraysize(partNumarray));
                                for eachPN in allPartNumLoopArray
                                {
                                                partNum = jsonarrayget(partNumarray, eachPN);
                                                if(findinarray(jSONPartNumArray, partNum) == -1)
                                                {
                                                                append(jSONPartNumArray, partNum);
                                                }
                                }
                                for modelLines in transactionLine
                                {
                                                if(modelLines._line_bom_part_number == "" AND modelName == modelLines._parent_line_item AND modelLines.rootElementDocumentNo_l == modelDocNo ){
                                                                noOfLines = noOfLines + 1;
                                                }
                                }
                               
                               
                }
                elif(line._line_bom_part_number == "" AND line._parent_line_item == "" AND line._model_name==""){
                                // Added By Amrita - 29th for Returns
                                isEmpty = false;
                                commPctNonbom = line.commissionPecent_l;
                                if(line.overrideCommissionNew_l > 0.0)
                                {
                                                commPctNonbom =  line.overrideCommissionNew_l;
                                }
                   nonBomLine = json();
                   jsonput(nonBomLine, "partNumber" , line._part_number);
                   jsonput(nonBomLine, "cpqItemDescription" , line._part_desc);
                  
                   // Returns
                   if(returnRequestInitiated_t AND line.returnsActionCode_l <> "X"){
                                   jsonput(nonBomLine, "quantity" , line.returnQuantity_l);
                   }
                   else{
                                                jsonput(nonBomLine, "quantity" , line.requestedQuantity_l);
                   }
                   if(line._model_name <> ""){
                                   jsonput(nonBomLine, "isModel" , true);
                   }
                   else{
                                jsonput(nonBomLine, "isModel" , false); 
                   }
                   jsonput(nonBomLine, "listPrice_l" , line.listPrice_l);
                   jsonput(nonBomLine, "netPrice_l" , line.netPrice_l);
                   jsonput(nonBomLine, "requestedUnitOfMeasure_l" , line.requestedUnitOfMeasure_l);
                   jsonput(nonBomLine, "oRCL_ERP_ShippingInstr_l" , line.oRCL_ERP_ShippingInstr_l);
                   if(line.returnType_l == ""){
                                   jsonput(nonBomLine, "fulfillmentType_line" , line.fulfillmentType_line);
                                   jsonput(nonBomLine, "actionCode_l" , line.actionCode_l);
                   }
                   else{
                                   jsonput(nonBomLine, "fulfillmentType_line" , line.returnType_l);
                                   jsonput(nonBomLine, "actionCode_l" , line.returnsActionCode_l);
                   }
                   jsonput(nonBomLine, "allocatedOverage_line" , line.allocatedOverage_line);
                   jsonput(nonBomLine, "contractStartDate_l" , line.contractStartDate_l);
                   jsonput(nonBomLine, "contractEndDate_l" , line.contractEndDate_l);
                   jsonput(nonBomLine, "taxExempt_l" , line.taxExempt_l);
                   jsonput(nonBomLine, "adjustedExtendedPrice_line" , line.adjustedExtendedPrice_line);
                   jsonput(nonBomLine, "adjustedUnitPrice_line" , line.adjustedUnitPrice_line);
                   jsonput(nonBomLine, "cancelReason_l" , line.cancelReason_l);
                   jsonput(nonBomLine, "rootElementDocumentNo_l" , line.rootElementDocumentNo_l);
                   jsonput(nonBomLine, "seqNumber" , line.parentSeqNumber_l);
                   jsonput(nonBomLine, "configChange" , "N");
                   jsonput(nonBomLine, "requestedFulfillmentOrganizationCode", line.returnToWarehouse_l);
                   jsonput(nonBomLine, "estimatedCost", line.unitCost_l);
                   jsonput(nonBomLine, "returnReason", line.returnReason_l);
                   jsonput(nonBomLine, "Attribute2", "");
                   jsonput(nonBomLine, "Attribute3", "");
                   jsonput(nonBomLine, "Attribute4", "");
                   jsonput(nonBomLine, "Attribute5", "");
                   jsonput(nonBomLine, "Attribute6", "");
                   jsonput(nonBomLine, "Attribute7", "");
                   jsonput(nonBomLine, "Attribute8", "");
                   jsonput(nonBomLine, "Attribute9", "");
                   jsonput(nonBomLine, "layoutrequired", line.layoutrequired_l);
                   jsonput(nonBomLine, "commissionPctLine", commPctNonbom);               
                   jsonarrayappend(allLines,nonBomLine);
    }
elif(line._line_bom_part_number == "" AND line._parent_line_item == "Cubicle Accessories" AND line._model_name==""){
                                // Added By Amrita - 29th for Returns
                                isEmpty = false;
                                commPctNonbom = line.commissionPecent_l;
                                if(line.overrideCommissionNew_l > 0.0)
                                {
                                                commPctNonbom =  line.overrideCommissionNew_l;
                                }
                   nonBomLine = json();
                   jsonput(nonBomLine, "partNumber" , line._part_number);
                   jsonput(nonBomLine, "cpqItemDescription" , line._part_desc);
                   jsonput(nonBomLine, "quantity" , line.requestedQuantity_l);
                   if(line._model_name <> ""){
                                   jsonput(nonBomLine, "isModel" , true);
                   }
                   else{
                                jsonput(nonBomLine, "isModel" , false); 
                   }
                   jsonput(nonBomLine, "listPrice_l" , line.listPrice_l);
                   jsonput(nonBomLine, "netPrice_l" , line.netPrice_l);
                   jsonput(nonBomLine, "requestedUnitOfMeasure_l" , line.requestedUnitOfMeasure_l);
                   jsonput(nonBomLine, "oRCL_ERP_ShippingInstr_l" , line.oRCL_ERP_ShippingInstr_l);
                   if(line.returnType_l == ""){
                                   jsonput(nonBomLine, "fulfillmentType_line" , line.fulfillmentType_line);
                                   jsonput(nonBomLine, "actionCode_l" , line.actionCode_l);
                   }
                   else{
                                   jsonput(nonBomLine, "fulfillmentType_line" , line.returnType_l);
                                   jsonput(nonBomLine, "actionCode_l" , line.returnsActionCode_l);
                   }
                   jsonput(nonBomLine, "allocatedOverage_line" , line.allocatedOverage_line);
                   jsonput(nonBomLine, "contractStartDate_l" , line.contractStartDate_l);
                   jsonput(nonBomLine, "contractEndDate_l" , line.contractEndDate_l);
                   jsonput(nonBomLine, "taxExempt_l" , line.taxExempt_l);
                   jsonput(nonBomLine, "adjustedExtendedPrice_line" , line.adjustedExtendedPrice_line);
                   jsonput(nonBomLine, "adjustedUnitPrice_line" , line.adjustedUnitPrice_line);
                   jsonput(nonBomLine, "cancelReason_l" , line.cancelReason_l);
                   jsonput(nonBomLine, "rootElementDocumentNo_l" , line.rootElementDocumentNo_l);
                   jsonput(nonBomLine, "seqNumber" , line.parentSeqNumber_l);
                   jsonput(nonBomLine, "configChange" , "N");
                   jsonput(nonBomLine, "requestedFulfillmentOrganizationCode", line.returnToWarehouse_l);
                   jsonput(nonBomLine, "estimatedCost", line.unitCost_l);
                   jsonput(nonBomLine, "returnReason", line.returnReason_l);
                   jsonput(nonBomLine, "Attribute2", "");
                   jsonput(nonBomLine, "Attribute3", "");
                   jsonput(nonBomLine, "Attribute4", "");
                   jsonput(nonBomLine, "Attribute5", "");
                   jsonput(nonBomLine, "Attribute6", "");
                   jsonput(nonBomLine, "Attribute7", "");
                   jsonput(nonBomLine, "Attribute8", "");
                   jsonput(nonBomLine, "Attribute9", "");
                   jsonput(nonBomLine, "layoutrequired", line.layoutrequired_l);
                   jsonput(nonBomLine, "commissionPctLine", commPctNonbom);               
                   jsonarrayappend(allLines,nonBomLine);
    }
                elif(line._line_bom_part_number == "" AND line._parent_line_item <> "" AND modelName == line._parent_line_item AND NOT isBOMPresent )
                {               
                                isEmpty = false;
                                modelQty = line.requestedQuantity_l;
                                if(returnRequestInitiated_t AND line.returnsActionCode_l <> "X"){
                                   modelQty = line.returnQuantity_l;
                                }
                                rootEleDocNo = line.rootElementDocumentNo_l;
                                seqNumber = line.parentSeqNumber_l;
                                configChange = "N";
                                if(containskey(modelPartNumDict, rootEleDocNo) OR (line.copyOf_l <> 0 AND containskey(modelPartNumDict, line.copyOf_l)))
                                {
                                                newConfigPartsArray = get(modelPartNumDict, rootEleDocNo);
                                                oldConfigPartsArray = string[];
                                               
                                                if(line.copyOf_l == 0 AND line.actionCode_l == "R" AND containskey(updatedModelDict, atoi(rootEleDocNo)))
                                                {
                                                                tempKey = get(updatedModelDict, atoi(rootEleDocNo));
                                                                oldConfigPartsArray = get(modelPartNumDict, tempKey);
                                                }
                                                if(line.copyOf_l <> 0)
                                                {
                                                                oldConfigPartsArray = get(modelPartNumDict, string(line.copyOf_l));
                                                }
                                                                                               
                                                if(NOT ISNULL(newConfigPartsArray) AND NOT ISNULL(oldConfigPartsArray) AND NOT ISEMPTY(newConfigPartsArray) AND NOT ISEMPTY(oldConfigPartsArray))
                                                {
                                                                sort_newConfig = sort(newConfigPartsArray);
                                                                sort_oldConfig = sort(oldConfigPartsArray);
                                                               
                                                                newPartString = join(sort_newConfig, "$$");
                                                                oldPartString = join(sort_oldConfig, "$$");
                                                               
                                                                if(newPartString <> oldPartString)
                                                                {
                                                                                seqNumber = line._group_sequence_number;
                                                                                configChange = "Y";
                                                                }
                                                }                                             
                                }
                               
                                if(rootEleDocNo == modelDocNo)
                                {
                                                listPrice = line.listPrice_l;
                                                netPrice  = line.adjustedUnitPrice_line;
                                                netAmount = line.adjustedExtendedPrice_line;
                                                allocatedOverage = line.allocatedOverage_line;
                                                commPct =  line.commissionPecent_l;
                                                unitCost  = line.unitCost_l;
                                                if(line.overrideCommissionNew_l >0.0){
                                                                commPct =  line.overrideCommissionNew_l;
                                                }
                                                mdlQty    = modelQty; 
                                                LinesJson = jsonarrayget(tmpjsonarray,mdlCount,"json");                                                
                                                linesCount = linesCount + 1;                                               
                                                if((linesCount == 1) OR (linesCount <> noOfLines and linesCount <> 1) OR (linesCount == noOfLines and linesCount <> 1))
                                                {
                                                                jsonput(LinesJson,"quantity",string(mdlQty));
                                                                jsonput(LinesJson,"listPrice",string(listPrice));
                                                                jsonput(LinesJson,"netPrice",string(netPrice));
                                                                jsonput(LinesJson,"netAmount",string(netAmount));
                                                                jsonput(LinesJson,"allocatedOverage",string(allocatedOverage));
                                                                jsonput(LinesJson,"seqNumber",seqNumber);
                                                                jsonput(LinesJson,"configChange",configChange);
                                                                jsonput(LinesJson,"commissionPctLine",commPct);
                                                                jsonput(LinesJson,"estimatedCost",string(unitCost));
                                                                jsonarrayappend(allLines,LinesJson);
                                                }                                                             
                                }                               
                }               
                elif(line._line_bom_part_number == "" AND modelName == line._parent_line_item AND isBOMPresent)
                {                               
                                isEmpty = false;
                                modelQty = line.requestedQuantity_l;
                                if(returnRequestInitiated_t AND line.returnsActionCode_l <> "X"){
                                   modelQty = line.returnQuantity_l;
                                }
                                rootEleDocNo = line.rootElementDocumentNo_l;
                                seqNumber = line.parentSeqNumber_l;
                                configChange = "N";
                                if(containskey(modelPartNumDict, rootEleDocNo) OR (line.copyOf_l <> 0 AND containskey(modelPartNumDict, line.copyOf_l)))
                                {
                                                newConfigPartsArray = get(modelPartNumDict, rootEleDocNo);
                                                oldConfigPartsArray = string[];
                                               
                                                if(line.copyOf_l == 0 AND line.actionCode_l == "R" AND containskey(updatedModelDict, atoi(rootEleDocNo)))
                                                {
                                                                tempKey = get(updatedModelDict, atoi(rootEleDocNo));
                                                                oldConfigPartsArray = get(modelPartNumDict, tempKey);
                                                }
                                                if(line.copyOf_l <> 0)
                                                {
                                                                oldConfigPartsArray = get(modelPartNumDict, string(line.copyOf_l));
                                                }
                                                                                               
                                                if(NOT ISNULL(newConfigPartsArray) AND NOT ISNULL(oldConfigPartsArray) AND NOT ISEMPTY(newConfigPartsArray) AND NOT ISEMPTY(oldConfigPartsArray))
                                                {
                                                                sort_newConfig = sort(newConfigPartsArray);
                                                                sort_oldConfig = sort(oldConfigPartsArray);
                                                               
                                                                newPartString = join(sort_newConfig, "$$");
                                                                oldPartString = join(sort_oldConfig, "$$");
                                                               
                                                                if(newPartString <> oldPartString)
                                                                {
                                                                                seqNumber = line._group_sequence_number;
                                                                                configChange = "Y";
                                                                }
                                                }                                             
                                }                      
                    tempArrayFloat = float[];
                                                if(containskey(curtainsdescriptionArray, line.rootElementDocumentNo_l)){
                                                tempArray = get(curtainsdescriptionArray, line.rootElementDocumentNo_l);
                                                append(tempArray, line._part_desc);
                                                put(curtainsdescriptionArray, line.rootElementDocumentNo_l, tempArray);
                                                }
                                                else{
                                                tempArray = string[];
                                                append(tempArray, line._part_desc);
                                                put(curtainsdescriptionArray, line.rootElementDocumentNo_l, tempArray);
                                                }
                                               
                                                if(containskey(curtainslistPriceArray, line.rootElementDocumentNo_l)){
                                                tempArrayFloat = get(curtainslistPriceArray, line.rootElementDocumentNo_l);
                                                append(tempArrayFloat, line.listPrice_l);
                                                put(curtainslistPriceArray, line.rootElementDocumentNo_l, tempArrayFloat);
                                                }
                                                else{
                                                tempArrayFloat = float[];
                                                append(tempArrayFloat, line.listPrice_l);
                                                put(curtainslistPriceArray, line.rootElementDocumentNo_l, tempArrayFloat);
                                                }
                                               
                                                if(containskey(curtainsnetPriceArray, line.rootElementDocumentNo_l)){
                                                tempArrayFloat = get(curtainsnetPriceArray, line.rootElementDocumentNo_l);
                                                append(tempArrayFloat, line.adjustedUnitPrice_line);
                                                put(curtainsnetPriceArray, line.rootElementDocumentNo_l, tempArrayFloat);
                                                }
                                                else{
                                                tempArrayFloat = float[];
                                                append(tempArrayFloat, line.adjustedUnitPrice_line);
                                                put(curtainsnetPriceArray, line.rootElementDocumentNo_l, tempArrayFloat);
                                                }
                                               
                                                if(containskey(curtainsunitCostArray, line.rootElementDocumentNo_l)){
                                                tempArrayFloat = get(curtainsunitCostArray, line.rootElementDocumentNo_l);
                                                append(tempArrayFloat, line.unitCost_l);
                                                put(curtainsunitCostArray, line.rootElementDocumentNo_l, tempArrayFloat);
                                                }
                                                else{
                                                tempArrayFloat = float[];
                                                append(tempArrayFloat, line.unitCost_l);
                                                put(curtainsunitCostArray, line.rootElementDocumentNo_l, tempArrayFloat);
                                                }
                                               
                                                if(containskey(curtainsnetAmountArray, line.rootElementDocumentNo_l)){
                                                tempArrayFloat = get(curtainsnetAmountArray, line.rootElementDocumentNo_l);
                                                append(tempArrayFloat, line.adjustedExtendedPrice_line);
                                                put(curtainsnetAmountArray, line.rootElementDocumentNo_l, tempArrayFloat);
                                                }
                                                else{
                                                tempArrayFloat = float[];
                                                append(tempArrayFloat, line.adjustedExtendedPrice_line);
                                                put(curtainsnetAmountArray, line.rootElementDocumentNo_l, tempArrayFloat);
                                                }
                                               
                                                if(containskey(allocatedOverageArray, line.rootElementDocumentNo_l)){
                                                tempArrayFloat = get(allocatedOverageArray, line.rootElementDocumentNo_l);
                                                append(tempArrayFloat, line.allocatedOverage_line);
                                                put(allocatedOverageArray, line.rootElementDocumentNo_l, tempArrayFloat);
                                                }
                                                else{
                                                tempArrayFloat = float[];
                                                append(tempArrayFloat, line.allocatedOverage_line);
                                                put(allocatedOverageArray, line.rootElementDocumentNo_l, tempArrayFloat);
                                                }
                                               
                                                if(containskey(configChangeArray, line.rootElementDocumentNo_l)){
                                                tempArray = get(configChangeArray, line.rootElementDocumentNo_l);
                                                append(tempArray, configChange);
                                                put(configChangeArray, line.rootElementDocumentNo_l, tempArray);
                                                }
                                                else{
                                                tempArray = string[];
                                                append(tempArray, configChange);
                                                put(configChangeArray, line.rootElementDocumentNo_l, tempArray);
                                                }
                                               
                                                if(containskey(seqNumberArray, line.rootElementDocumentNo_l)){
                                                tempArray = get(seqNumberArray, line.rootElementDocumentNo_l);
                                                append(tempArray, seqNumber);
                                                put(seqNumberArray, line.rootElementDocumentNo_l, tempArray);
                                                }
                                                else{
                                                tempArray = string[];
                                                append(tempArray, seqNumber);
                                                put(seqNumberArray, line.rootElementDocumentNo_l, tempArray);
                                                }
                                               
                                                commPct =  line.commissionPecent_l;
                                                if(line.overrideCommissionNew_l > 0.0){
                                                                commPct =  line.overrideCommissionNew_l;
                                                }
                                               
                                                if(containskey(commPctArray, line.rootElementDocumentNo_l)){
                                                tempArrayFloat = get(commPctArray, line.rootElementDocumentNo_l);
                                                append(tempArrayFloat, commPct);
                                                put(commPctArray, line.rootElementDocumentNo_l, tempArrayFloat);
                                                }
                                                else{
                                                tempArrayFloat = float[];
                                                append(tempArrayFloat, commPct);
                                                put(commPctArray, line.rootElementDocumentNo_l, tempArrayFloat);
                                                }

                }
}
print curtainsdescriptionArray;
results = bmql("select Part, Attr, Type from ItemQtyMap where Part IN $jSONPartNumArray");
for result in results
{
                attributeName = get(result, "Attr");
                partNumberRecord = get(result, "Part");
                type = get(result, "Type");
                put(quantityPNDict, partNumberRecord, attributeName);
                put(partTypeDict, partNumberRecord, type);               
} 
multiplePartsDict = dict("string");
multiparts = bmql("select Part_Number,Part from Multiple_Parts where Part_Number IN $jSONPartNumArray");
for multipart in multiparts
{
                partNbr = get(multipart, "Part_Number");
                pdhPart = get(multipart, "Part");
                put(multiplePartsDict, partNbr, pdhPart);
                print multiplePartsDict;
}
loopAttributeDict = dict("string");
loopAttributes = bmql("select Model, LoopAttr from Config_LoopAttr where Model IN $modelNameArray");
for eachLoopAttr in loopAttributes
{
                eachMdl = get(eachLoopAttr, "Model");
                LoopAttr = get(eachLoopAttr, "LoopAttr");
               
                put(loopAttributeDict, eachMdl, LoopAttr);         
} 
modelNumIndex = 0; 
for eachModel in modelNameArray
{ 
                if(containskey(loopAttributeDict, eachModel))
                {
                                loopQtyArray = string[1];
                                if(NOT isnull(getconfigattrvalue(docNumArray[modelNumIndex], get(loopAttributeDict, eachModel))))
                                {             
                                                loopQtyArray = split(getconfigattrvalue(docNumArray[modelNumIndex], get(loopAttributeDict, eachModel)), "$,$");
                                }
                               
                                noOfCurtains = sizeofarray(loopQtyArray);
                                tempLoopArray = range(noOfCurtains);
                                for eachCurtain in tempLoopArray
                                {
                                                //j=j+1;
                                                tempLinesJson = jsonarrayget(tmpjsonarray, modelNumIndex, "json");
                                                LinesJsonCopy = jsoncopy(tempLinesJson);
                                                jarray = jsonpathgetmultiple(tempLinesJson, "$..partNumber");
                                               
                                                allPNLoopArray = range(jsonarraysize(jarray));
                                               
                                                for eachPN in allPNLoopArray
                                                {
                                                                if(containskey(quantityPNDict, jsonarrayget(jarray, eachPN)) AND get(partTypeDict, jsonarrayget(jarray, eachPN)) <> "Model")
                                                                {
                                                                                jobjLine = jsonpathgetsingle(LinesJsonCopy, "$..children[?(@.partNumber ==" + "\'" + jsonarrayget(jarray, eachPN) + "\'" + ")]","json");
                                                                                if(NOT isnull(get(multiplePartsDict,jsonarrayget(jarray, eachPN))))
                                                                                {
                                                                                                jsonput(jobjLine,"partNumber", get(multiplePartsDict,jsonarrayget(jarray, eachPN)));
                                                                                }
                                                                                quantityAttribute = get(quantityPNDict, jsonarrayget(jarray, eachPN));
                                                                                if(NOT isnull(getconfigattrvalue(docNumArray[modelNumIndex], quantityAttribute)))
                                                                                {
                                                                                                qtyArray = split(getconfigattrvalue(docNumArray[modelNumIndex], quantityAttribute), "$,$");
                                                                                                //if(isnumber(qtyArray[eachCurtain]) AND qtyArray[eachCurtain] <> "0.0")// AND atoi(qtyArray[eachCurtain]) > 0)
                                                                                                if(isnumber(qtyArray[eachCurtain]))
                                                                                                {
                                                                                                                jsonput(jobjLine,"quantity", qtyArray[eachCurtain]);
                                                                                                }
                                                                                }
                                                                }
                                                                if(containskey(quantityPNDict, jsonarrayget(jarray, eachPN)) AND get(partTypeDict, jsonarrayget(jarray, eachPN)) == "Model")
                                                                {
                                                                                quantityAttribute = get(quantityPNDict, jsonarrayget(jarray, eachPN));
                                                                                if(NOT isnull(getconfigattrvalue(docNumArray[modelNumIndex], quantityAttribute)))
                                                                                {
                                                                                                qtyArray = split(getconfigattrvalue(docNumArray[modelNumIndex], quantityAttribute), "$,$");
                                                                                               
                                                                                                if(isnumber(qtyArray[eachCurtain]))// AND atoi(qtyArray[eachCurtain]) > 0)
                                                                                                {
                                                                                                                jsonput(LinesJsonCopy,"quantity", qtyArray[eachCurtain]);
                                                                                                }
                                                                                }
                                                                }
                                                                tmplistPrice = float[];
                                                                tmplistPrice  = get(curtainslistPriceArray,docNumArray[modelNumIndex]);
                                                                jsonput(LinesJsonCopy,"listPrice", tmplistPrice[eachCurtain]);
                                                                tmpnetPrice = float[];
                                                                tmpnetPrice  = get(curtainsnetPriceArray,docNumArray[modelNumIndex]);
                                                                jsonput(LinesJsonCopy,"netPrice", tmpnetPrice[eachCurtain]);
                                                                tmpnetAmount = float[];
                                                                tmpnetAmount  = get(curtainsnetAmountArray,docNumArray[modelNumIndex]);
                                                                jsonput(LinesJsonCopy,"netAmount", tmpnetAmount[eachCurtain]);
                                                                tmpallocatedOverage = float[];
                                                                tmpallocatedOverage  = get(allocatedOverageArray,docNumArray[modelNumIndex]);
                                                                jsonput(LinesJsonCopy,"allocatedOverage", tmpallocatedOverage[eachCurtain]);
                                                                tmpseqNumber = String[];
                                                                tmpseqNumber  = get(seqNumberArray,docNumArray[modelNumIndex]);
                                                                jsonput(LinesJsonCopy,"seqNumber", tmpseqNumber[eachCurtain]);
                                                                tmpconfigChange = String[];
                                                                tmpconfigChange  = get(configChangeArray,docNumArray[modelNumIndex]);
                                                                jsonput(LinesJsonCopy,"configChange", tmpconfigChange[eachCurtain]);
                                                                tmpcommissionPctLine = float[];
                                                                tmpcommissionPctLine  = get(commPctArray,docNumArray[modelNumIndex]);
                                                                jsonput(LinesJsonCopy,"commissionPctLine", tmpcommissionPctLine[eachCurtain]);
                                                                tmpestimatedCost = float[];
                                                                tmpestimatedCost  = get(curtainsunitCostArray,docNumArray[modelNumIndex]);
                                                                jsonput(LinesJsonCopy,"estimatedCost", tmpestimatedCost[eachCurtain]);
                                                                tmppartdesc = String[];
                                                                tmppartdesc  = get(curtainsdescriptionArray,docNumArray[modelNumIndex]);
                                                                jsonput(LinesJsonCopy,"cpqItemDescription", tmppartdesc[eachCurtain]);
                                                               
                                                               
                                                }
                                                jsonarrayappend(allLines, LinesJsonCopy);
                                }
                                modelNumIndex = modelNumIndex + 1;
                }
} 
headerJson = jsonobj;
if(isEmpty){
                jsonput(headerJson, "Line", tmpjsonarray);
}
else{
                jsonput(headerJson, "Line", allLines);
} 
print headerJson; 
if(NOT isFulTypeBlank){
                return headerJson;
}else{
                return jsonobj;
}