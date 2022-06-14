function formCheck(formobj){

	var alertMsg="Please complete the following fields before you proceed:\n";
	var l_Msg=alertMsg.length;

	//alert(formobj.OT1.value);
	if((formobj.arch_detect.value=="")||(formobj.arch_detect.value==null)||(formobj.arch_detect.value=="Y")){

		//	alert("This is good"+formobj.arch_detect.value);
		//1) Enter name of mandatory fields

		var fieldRequired="";
		var fieldDescription="";
		//alert("HERE0");
		//alert(formobj.product_id.value+"1");
		//alert("HERE1"+formobj.submittals_by.value);
		if(formobj.product_id.value=="ADS"){
			//alert("HERE2");
			if(document.getElementById("submittals_by")){
				fieldRequired=Array("cs_company","sales_region","cust_name1","phone","city","contact_name","","customer_po_no","payment_name","payment_address1","payment_city","payment_state","payment_zip","payment_credit_type","payment_credit_no","payment_exp_date","payment_material_sales","payment_tax","payment_total_charged","ship_name","city","state","zip","ship_phone","submittals_by","arch_name","arch_city","arch_state","arch_detect","ship_rdate","OT","nonconfig_notes","overage","commission","commDollar","nonconfigPrice","month","year","invoice_name","invoice_city","invoice_state","invoice_zip","invoice_phone","payment_cvc","notice_ship","billed_email","name_ship","contact_name","phone_ship","","production_approved_date","drafting_email");
				//2) Enter field description to appear in the dialog box
				fieldDescription=Array("CS group company","Sales Region","Billing Customer Name","Billing Customer Phone","Billing Customer City","Billing Contact Name","Billing Customer Type","P.O. Number","Name on the Credit Card","Credit card Adrress","Credit card City","Credit card State","Credit card zip","Credit card Type like Visa,Master Card","Credit card Number","Credit card Expire Date","Total Material Sales($)","Tax($)","Total Charged to the Card($)","Ship Name","Ship City","Ship State","Ship Zip","Ship phone"," Submitalls By","Architect's Name","Architect's City","Architect's State","Select a Order Architect","Delivery Request Date","Order Status","Non Configured Product Notes","Overage","Commission Percent","Commission Dollars","Price","Credit Card Expire Month","Credit Card Expire Year","Invoice name","Inovice City","Invoice State","Invoice Zip","Invoice Phone","Credit card CVC no","Delivery Notice","Billing Email","Shipping Delivery Name","Contact Name","Delivery Phone","Color","Production Approved Date","Drafting email");

			}
			else{
				fieldRequired=Array("cs_company","sales_region","cust_name1","phone","city","contact_name","","customer_po_no","payment_name","payment_address1","payment_city","payment_state","payment_zip","payment_credit_type","payment_credit_no","payment_exp_date","payment_material_sales","payment_tax","payment_total_charged","ship_name","city","state","zip","ship_phone","submittals_by","arch_name","arch_city","arch_state","arch_detect","ship_rdate","OT","nonconfig_notes","overage","commission","commDollar","nonconfigPrice","month","year","invoice_name","invoice_city","invoice_state","invoice_zip","invoice_phone","payment_cvc","notice_ship","billed_email","name_ship","contact_name","phone_ship","","production_approved_date");
				//2) Enter field description to appear in the dialog box
				fieldDescription=Array("CS group company","Sales Region","Billing Customer Name","Billing Customer Phone","Billing Customer City","Billing Contact Name","Billing Customer Type","P.O. Number","Name on the Credit Card","Credit card Adrress","Credit card City","Credit card State","Credit card zip","Credit card Type like Visa,Master Card","Credit card Number","Credit card Expire Date","Total Material Sales($)","Tax($)","Total Charged to the Card($)","Ship Name","Ship City","Ship State","Ship Zip","Ship phone"," Submitalls By","Architect's Name","Architect's City","Architect's State","Select a Order Architect","Delivery Request Date","Order Status","Non Configured Product Notes","Overage","Commission Percent","Commission Dollars","Price","Credit Card Expire Month","Credit Card Expire Year","Invoice name","Inovice City","Invoice State","Invoice Zip","Invoice Phone","Credit card CVC no","Delivery Notice","Billing Email","Shipping Delivery Name","Contact Name","Delivery Phone","Color","Production Approved Date");
			}
			if(document.getElementById("ship_rdate")&&formobj.ship_rdate.value!=""&&(formobj.product_id.value=="ADS")){
				var date3=new Date(formobj.ship_rdate.value.substring(2,4),formobj.ship_rdate.value.substring(5,7),formobj.ship_rdate.value.substring(8,10));
				var date4=new Date(formobj.todaysDate.value.substring(2,4),formobj.todaysDate.value.substring(5,7),formobj.todaysDate.value.substring(8,10));
				if(date4>date3){
					//alert("today is great or equals to selected date");
					alertMsg+=" - Requested ship date cannot be older than current date, please correct";
				}
			}
			
		}
		else if(formobj.product_id.value=="LVR"){
			//alert("HERELVR");
			fieldRequired=Array("cs_company","sales_region","cust_name1","phone","customer_po_no","payment_name","payment_address1","payment_city","payment_state","payment_zip","payment_credit_type","payment_credit_no","payment_exp_date","payment_material_sales","payment_tax","payment_total_charged","ship_name","ship_addr1","city","state","zip","ship_phone","submittals_by","arch_name","arch_city","arch_state","arch_detect","ship_rdate","OT","nonconfig_notes","overage","commission","commDollar","nonconfigPrice","month","year","invoice_name","invoice_addr1","invoice_city","invoice_state","invoice_zip","invoice_phone","payment_cvc","extra_order_notes");
			fieldDescription=Array("CS group company","Sales Region","Billing Customer Name","Billing Customer Phone","P.O. Number","Name on the Credit Card","Credit card Adrress","Credit card City","Credit card State","Credit card zip","Credit card Type like Visa,Master Card","Credit card Number","Credit card Expire Date","Total Material Sales($)","Tax($)","Total Charged to the Card($)","Ship Name","Ship Address","Ship City","Ship State","Ship Zip","Ship phone"," Submitalls By","Architect's Name","Architect's City","Architect's State","Select a Order Architect","Delivery Request Date","Order Status","Non Configured Product Notes","Overage","Commission Percent","Commission Dollars","Price","Credit Card Expire Month","Credit Card Expire Year","Invoice name","Invoice Address1","Inovice City","Invoice State","Invoice Zip","Invoice Phone","Credit card CVC no","ADDS/DEDUCTS Taken (Enter 'None' if Not Applicable)");
			
			if(document.getElementById("ship_rdate")&&formobj.ship_rdate.value!=""){
				var date3=new Date(formobj.ship_rdate.value.substring(2,4),formobj.ship_rdate.value.substring(5,7),formobj.ship_rdate.value.substring(8,10));
				var date4=new Date(formobj.todaysDate.value.substring(2,4),formobj.todaysDate.value.substring(5,7),formobj.todaysDate.value.substring(8,10));
				if(date4>date3){
					//alert("today is great or equals to selected date");
					alertMsg+=" - Requested ship date cannot be older than current date, please correct";
				}
			}
			
		}
		else{
			//alert("HERE");
			//alert(formobj.OT1.value);
			if(document.getElementById("DR")&&formobj.OT1.value=="DR"&&formobj.product_id.value=="EFS"){
				//alert("HERE4");
				//alert(formobj.submittals_by.value);
				if(document.getElementById("submittals_by")&&formobj.submittals_by.value=="FACTORY"){
					fieldRequired=Array("cs_company","sales_region","cust_name1","phone","customer_po_no","payment_name","payment_address1","payment_city","payment_state","payment_zip","payment_credit_type","payment_credit_no","payment_exp_date","payment_material_sales","payment_tax","payment_total_charged","ship_name","ship_addr1","city","state","zip","ship_phone","submittals_by","arch_name","arch_city","arch_state","arch_detect","ship_rdate","OT","nonconfig_notes","overage","commission","commDollar","nonconfigPrice","month","year","invoice_name","invoice_addr1","invoice_city","invoice_state","invoice_zip","invoice_phone","payment_cvc","billed_email","drafting_email");
					//2) Enter field description to appear in the dialog box
					fieldDescription=Array("CS group company","Sales Region","Billing Customer Name","Billing Customer Phone","P.O. Number","Name on the Credit Card","Credit card Adrress","Credit card City","Credit card State","Credit card zip","Credit card Type like Visa,Master Card","Credit card Number","Credit card Expire Date","Total Material Sales($)","Tax($)","Total Charged to the Card($)","Ship Name","Ship Address","Ship City","Ship State","Ship Zip","Ship phone"," Submittals By","Architect's Name","Architect's City","Architect's State","Select a Order Architect","Delivery Request Date","Order Status","Non Configured Product Notes","Overage","Commission Percent","Commission Dollars","Price","Credit Card Expire Month","Credit Card Expire Year","Invoice name","Invoice Address1","Inovice City","Invoice State","Invoice Zip","Invoice Phone","Credit card CVC no","Billing Email","Drafting email");

				}
				else{
					fieldRequired=Array("cs_company","sales_region","cust_name1","phone","customer_po_no","payment_name","payment_address1","payment_city","payment_state","payment_zip","payment_credit_type","payment_credit_no","payment_exp_date","payment_material_sales","payment_tax","payment_total_charged","ship_name","ship_addr1","city","state","zip","ship_phone","submittals_by","arch_name","arch_city","arch_state","arch_detect","ship_rdate","OT","nonconfig_notes","overage","commission","commDollar","nonconfigPrice","month","year","invoice_name","invoice_addr1","invoice_city","invoice_state","invoice_zip","invoice_phone","payment_cvc","billed_email");
					//2) Enter field description to appear in the dialog box
					fieldDescription=Array("CS group company","Sales Region","Billing Customer Name","Billing Customer Phone","P.O. Number","Name on the Credit Card","Credit card Adrress","Credit card City","Credit card State","Credit card zip","Credit card Type like Visa,Master Card","Credit card Number","Credit card Expire Date","Total Material Sales($)","Tax($)","Total Charged to the Card($)","Ship Name","Ship Address","Ship City","Ship State","Ship Zip","Ship phone"," Submittals By","Architect's Name","Architect's City","Architect's State","Select a Order Architect","Delivery Request Date","Order Status","Non Configured Product Notes","Overage","Commission Percent","Commission Dollars","Price","Credit Card Expire Month","Credit Card Expire Year","Invoice name","Invoice Address1","Inovice City","Invoice State","Invoice Zip","Invoice Phone","Credit card CVC no","Billing Email");
				}
				var date1=new Date(formobj.date_require.value.substring(2,4),formobj.date_require.value.substring(5,7),formobj.date_require.value.substring(8,10));
				var date2=new Date(formobj.todaysDate.value.substring(2,4),formobj.todaysDate.value.substring(5,7),formobj.todaysDate.value.substring(8,10));
				//alert(date1+"::"+date2);
				if(date2>=date1){
					//alert("today is great or equals to selected date");
					alertMsg+=" - Required date can not be today or before today\n";
				}


			}
			else if(document.getElementById("submittals_by")&&formobj.submittals_by.value=="FACTORY"&&(formobj.product_id.value=="IWP"||formobj.product_id.value=="EFS")){
				fieldRequired=Array("cs_company","sales_region","cust_name1","phone","customer_po_no","payment_name","payment_address1","payment_city","payment_state","payment_zip","payment_credit_type","payment_credit_no","payment_exp_date","payment_material_sales","payment_tax","payment_total_charged","ship_name","ship_addr1","city","state","zip","ship_phone","submittals_by","arch_name","arch_city","arch_state","arch_detect","ship_rdate","OT","nonconfig_notes","overage","commission","commDollar","nonconfigPrice","month","year","invoice_name","invoice_addr1","invoice_city","invoice_state","invoice_zip","invoice_phone","payment_cvc","billed_email","drafting_email");
				//2) Enter field description to appear in the dialog box
				fieldDescription=Array("CS group company","Sales Region","Billing Customer Name","Billing Customer Phone","P.O. Number","Name on the Credit Card","Credit card Adrress","Credit card City","Credit card State","Credit card zip","Credit card Type like Visa,Master Card","Credit card Number","Credit card Expire Date","Total Material Sales($)","Tax($)","Total Charged to the Card($)","Ship Name","Ship Address","Ship City","Ship State","Ship Zip","Ship phone"," Submitalls By","Architect's Name","Architect's City","Architect's State","Select a Order Architect","Delivery Request Date","Order Status","Non Configured Product Notes","Overage","Commission Percent","Commission Dollars","Price","Credit Card Expire Month","Credit Card Expire Year","Invoice name","Invoice Address1","Inovice City","Invoice State","Invoice Zip","Invoice Phone","Credit card CVC no","Billing Email","Drafting Email");
			}
			else{
				if(document.getElementById("submittals_by")&&formobj.product_id.value=="EJC"){
					fieldRequired=Array("cs_company","sales_region","cust_name1","phone","customer_po_no","payment_name","payment_address1","payment_city","payment_state","payment_zip","payment_credit_type","payment_credit_no","payment_exp_date","payment_material_sales","payment_tax","payment_total_charged","ship_name","ship_addr1","city","state","zip","ship_phone","submittals_by","arch_name","arch_city","arch_state","arch_detect","ship_rdate","OT","nonconfig_notes","overage","commission","commDollar","nonconfigPrice","month","year","invoice_name","invoice_addr1","invoice_city","invoice_state","invoice_zip","invoice_phone","payment_cvc","billed_email","drafting_email");
					//2) Enter field description to appear in the dialog box
					fieldDescription=Array("CS group company","Sales Region","Billing Customer Name","Billing Customer Phone","P.O. Number","Name on the Credit Card","Credit card Adrress","Credit card City","Credit card State","Credit card zip","Credit card Type like Visa,Master Card","Credit card Number","Credit card Expire Date","Total Material Sales($)","Tax($)","Total Charged to the Card($)","Ship Name","Ship Address","Ship City","Ship State","Ship Zip","Ship phone"," Submitalls By","Architect's Name","Architect's City","Architect's State","Select a Order Architect","Delivery Request Date","Order Status","Non Configured Product Notes","Overage","Commission Percent","Commission Dollars","Price","Credit Card Expire Month","Credit Card Expire Year","Invoice name","Invoice Address1","Inovice City","Invoice State","Invoice Zip","Invoice Phone","Credit card CVC no","Billing Email","Drafting Email");

				}
				else{
					//alert("HERE4");
					fieldRequired=Array("cs_company","sales_region","cust_name1","phone","customer_po_no","payment_name","payment_address1","payment_city","payment_state","payment_zip","payment_credit_type","payment_credit_no","payment_exp_date","payment_material_sales","payment_tax","payment_total_charged","ship_name","ship_addr1","city","state","zip","ship_phone","submittals_by","arch_name","arch_city","arch_state","arch_detect","ship_rdate","OT","nonconfig_notes","overage","commission","commDollar","nonconfigPrice","month","year","invoice_name","invoice_addr1","invoice_city","invoice_state","invoice_zip","invoice_phone","payment_cvc","billed_email");
					//2) Enter field description to appear in the dialog box
					fieldDescription=Array("CS group company","Sales Region","Billing Customer Name","Billing Customer Phone","P.O. Number","Name on the Credit Card","Credit card Adrress","Credit card City","Credit card State","Credit card zip","Credit card Type like Visa,Master Card","Credit card Number","Credit card Expire Date","Total Material Sales($)","Tax($)","Total Charged to the Card($)","Ship Name","Ship Address","Ship City","Ship State","Ship Zip","Ship phone"," Submitalls By","Architect's Name","Architect's City","Architect's State","Select a Order Architect","Delivery Request Date","Order Status","Non Configured Product Notes","Overage","Commission Percent","Commission Dollars","Price","Credit Card Expire Month","Credit Card Expire Year","Invoice name","Invoice Address1","Inovice City","Invoice State","Invoice Zip","Invoice Phone","Credit card CVC no","Billing Email");
				}
			}
			if(document.getElementById("ship_rdate")&&formobj.product_id.value=="EFS"){
				var date3=new Date(formobj.ship_rdate.value.substring(2,4),formobj.ship_rdate.value.substring(5,7),formobj.ship_rdate.value.substring(8,10));
				var date4=new Date(formobj.todaysDate.value.substring(2,4),formobj.todaysDate.value.substring(5,7),formobj.todaysDate.value.substring(8,10));
				if(date4>=date3){
					//alert("today is great or equals to selected date");
					alertMsg+=" - Requested ship date can not be today or before today\n";
				}
			}
			if(document.getElementById("ship_rdate")&&formobj.ship_rdate.value!=""&&formobj.product_id.value!="EFS"){
				var date3=new Date(formobj.ship_rdate.value.substring(2,4),formobj.ship_rdate.value.substring(5,7),formobj.ship_rdate.value.substring(8,10));
				var date4=new Date(formobj.todaysDate.value.substring(2,4),formobj.todaysDate.value.substring(5,7),formobj.todaysDate.value.substring(8,10));
				if(date4>date3){
					//alert("today is great or equals to selected date");
					alertMsg+=" - Requested ship date cannot be older than current date, please correct!!";
				}
			}
			
			
		}
		//alert("HERE8");
		//3) Enter dialog message
		//alert(fieldRequired.length);
		for(var i=0;i<fieldRequired.length;i++){

			//alert(fieldRequired[i]);
			var obj=formobj.elements[fieldRequired[i]];
			//alert(obj);
			if(obj){
				//alert(obj.type);
				switch(obj.type){
					case "select-one":
						if(obj.selectedIndex==-1||obj.options[obj.selectedIndex].text==""){
							alertMsg+=" - "+fieldDescription[i]+"\n";
						}
						break;
					case "select-multiple":
						if(obj.selectedIndex==-1){
							alertMsg+=" - "+fieldDescription[i]+"\n";
						}
						break;
					case "text":
					case "textarea":
						//alert(obj.value);
						if(obj.value==""||obj.value==null){
							if(fieldDescription[i]=="Invoice Address1"){
								var obj2=formobj.elements["invoice_addr2"];
								if(obj2){
									//alert("invoice 2 exists"+obj2.value);
									if(Trim(obj2.value)==""||obj2.value==null){
										alertMsg+=" - "+fieldDescription[i]+"\n"
									}
								}
								else{
									alertMsg+=" - "+fieldDescription[i]+" \n"
								}
							}
							else if(fieldDescription[i]=="Ship Address"){
								var obj2=formobj.elements["ship_addr2"];
								if(obj2){
									//alert("ship 2 exists");
									if(obj2.value==""||obj2.value==null){
										alertMsg+=" - "+fieldDescription[i]+" \n"
									}
								}
								else{
									alertMsg+=" - "+fieldDescription[i]+" \n"
								}
							}
							else{
								alertMsg+=" - "+fieldDescription[i]+" \n";
							}
						}
						if(fieldRequired[i]=="drafting_email"){
							var a=obj.value.indexOf("@");
							if(a>0){
								var b=obj.value.indexOf(".",a);
								if(b<0){
									alertMsg+=" - "+fieldDescription[i]+" bad email format \n";
								}
							}
							else{
								alertMsg+=" - "+fieldDescription[i]+" bad email format \n";
							}
						}
						break;














					default:
						if(obj.value==""||obj.value==null){
							alertMsg+=" - "+fieldDescription[i]+"\n";
						}
				}
			}
		}
	}
	else{
		//1) Enter name of mandatory fields
		var fieldRequired;
		var fieldDescription;
		//alert(formobj.product_id.value+"2");
		if(formobj.product_id.value=="ADS"){
			//alert("2");
			if(document.getElementById("submittals_by")){
				fieldRequired=Array("cs_company","sales_region","cust_name1","phone","city","contact_name","","customer_po_no","payment_name","payment_address1","payment_city","payment_state","payment_zip","payment_credit_type","payment_credit_no","payment_exp_date","payment_material_sales","payment_tax","payment_total_charged","ship_name","city","state","zip","ship_phone","submittals_by","arch_detect","ship_rdate","OT","month","year","invoice_name","invoice_city","invoice_state","invoice_zip","invoice_phone","notice_ship","billed_email","name_ship","contact_name","phone_ship","","production_approved_date","drafting_email");
				fieldDescription=Array("CS group company","Sales Region","Billing Customer Name","Billing Customer Phone","Billing Customer City","Billing Contact Name","Billing Customer Type","P.O. Number","Name on the Credit Card","Credit card Adrress","Credit card City","Credit card State","Credit card zip","Credit card Type like Visa,Master Card","Credit card Number","Credit card Expire Date","Total Material Sales($)","Tax($)","Total Charged to the Card($)","Ship Name","City","State","Zip","Ship phone"," Submitalls By","Select a Order Architect","Delivery Request Date","Order Status","Credit Card Expire Month","Credit Card Expire Year","Invoice name","Inovice City","Invoice State","Invoice Zip","Invoice Phone","Delivery Notice","Billing Email","Shipping Delivery Name","Contact Name","Delivery Phone","Color","Production Approved Date","Drafting Email");
			}
			else{
				fieldRequired=Array("cs_company","sales_region","cust_name1","phone","city","contact_name","","customer_po_no","payment_name","payment_address1","payment_city","payment_state","payment_zip","payment_credit_type","payment_credit_no","payment_exp_date","payment_material_sales","payment_tax","payment_total_charged","ship_name","city","state","zip","ship_phone","submittals_by","arch_detect","ship_rdate","OT","month","year","invoice_name","invoice_city","invoice_state","invoice_zip","invoice_phone","notice_ship","billed_email","name_ship","contact_name","phone_ship","","production_approved_date");
				fieldDescription=Array("CS group company","Sales Region","Billing Customer Name","Billing Customer Phone","Billing Customer City","Billing Contact Name","Billing Customer Type","P.O. Number","Name on the Credit Card","Credit card Adrress","Credit card City","Credit card State","Credit card zip","Credit card Type like Visa,Master Card","Credit card Number","Credit card Expire Date","Total Material Sales($)","Tax($)","Total Charged to the Card($)","Ship Name","City","State","Zip","Ship phone"," Submitalls By","Select a Order Architect","Delivery Request Date","Order Status","Credit Card Expire Month","Credit Card Expire Year","Invoice name","Inovice City","Invoice State","Invoice Zip","Invoice Phone","Delivery Notice","Billing Email","Shipping Delivery Name","Contact Name","Delivery Phone","Color","Production Approved Date");
			}
			
			if(document.getElementById("ship_rdate")&&formobj.ship_rdate.value!=""&&(formobj.product_id.value=="ADS")){
				var date3=new Date(formobj.ship_rdate.value.substring(2,4),formobj.ship_rdate.value.substring(5,7),formobj.ship_rdate.value.substring(8,10));
				var date4=new Date(formobj.todaysDate.value.substring(2,4),formobj.todaysDate.value.substring(5,7),formobj.todaysDate.value.substring(8,10));
				if(date4>date3){
					//alert("today is great or equals to selected date");
					alertMsg+=" - Requested ship date cannot be older than current date, please correct";
				}
			}
			
		}
		else if(formobj.product_id.value=="LVR"){
			fieldRequired=Array("cs_company","sales_region","cust_name1","phone","customer_po_no","payment_name","payment_address1","payment_city","payment_state","payment_zip","payment_credit_type","payment_credit_no","payment_exp_date","payment_material_sales","payment_tax","payment_total_charged","ship_name","ship_addr1","city","state","zip","ship_phone","submittals_by","arch_detect","ship_rdate","OT","month","year","invoice_name","invoice_addr1","invoice_city","invoice_state","invoice_zip","invoice_phone","extra_order_notes");
			//2) Enter field description to appear in the dialog box
			fieldDescription=Array("CS group company","Sales Region","Billing Customer Name","Billing Customer Phone","P.O. Number","Name on the Credit Card","Credit card Adrress","Credit card City","Credit card State","Credit card zip","Credit card Type like Visa,Master Card","Credit card Number","Credit card Expire Date","Total Material Sales($)","Tax($)","Total Charged to the Card($)","Ship Name","Ship Address","City","State","Zip","Ship phone"," Submitalls By","Select a Order Architect","Delivery Request Date","Order Status","Credit Card Expire Month","Credit Card Expire Year","Invoice name","Invoice Address1","Inovice City","Invoice State","Invoice Zip","Invoice Phone","ADDS/DEDUCTS Taken (Enter 'None' if Not Applicable)");
			
			if(document.getElementById("ship_rdate")&&formobj.ship_rdate.value!=""){
				var date3=new Date(formobj.ship_rdate.value.substring(2,4),formobj.ship_rdate.value.substring(5,7),formobj.ship_rdate.value.substring(8,10));
				var date4=new Date(formobj.todaysDate.value.substring(2,4),formobj.todaysDate.value.substring(5,7),formobj.todaysDate.value.substring(8,10));
				if(date4>date3){
					//alert("today is great or equals to selected date");
					alertMsg+=" - Requested ship date cannot be older than current date, please correct";
				}
			}
			
		}
		else{
			//fieldRequired = Array("cs_company","sales_region","cust_name1","phone","customer_po_no","payment_name","payment_address1","payment_city","payment_state","payment_zip","payment_credit_type","payment_credit_no","payment_exp_date","payment_material_sales","payment_tax","payment_total_charged","ship_name","ship_addr1","city","state","zip","ship_phone","submittals_by","arch_detect","ship_rdate","OT","month","year","invoice_name","invoice_addr1","invoice_city","invoice_state","invoice_zip","invoice_phone");
			//2) Enter field description to appear in the dialog box
			//fieldDescription = Array("CS group company","Sales Region","Billing Customer Name","Billing Customer Phone","P.O. Number","Name on the Credit Card","Credit card Adrress","Credit card City","Credit card State","Credit card zip","Credit card Type like Visa,Master Card","Credit card Number","Credit card Expire Date","Total Material Sales($)","Tax($)","Total Charged to the Card($)","Ship Name","Ship Address","City","State","Zip","Ship phone"," Submitalls By","Select a Order Architect", "Delivery Request Date","Order Status","Credit Card Expire Month", "Credit Card Expire Year","Invoice name", "Invoice Address1","Inovice City","Invoice State","Invoice Zip","Invoice Phone");
			//alert("HERE2x");
			if(document.getElementById("DR")&&formobj.OT1.value=="DR"&&formobj.product_id.value=="EFS"){
				if(document.getElementById("submittals_by")&&formobj.submittals_by.value=="FACTORY"){
					fieldRequired=Array("cs_company","sales_region","cust_name1","phone","customer_po_no","payment_name","payment_address1","payment_city","payment_state","payment_zip","payment_credit_type","payment_credit_no","payment_exp_date","payment_material_sales","payment_tax","payment_total_charged","ship_name","ship_addr1","city","state","zip","ship_phone","submittals_by","arch_detect","ship_rdate","OT","month","year","invoice_name","invoice_addr1","invoice_city","invoice_state","invoice_zip","invoice_phone","billed_email","drafting_email");
					fieldDescription=Array("CS group company","Sales Region","Billing Customer Name","Billing Customer Phone","P.O. Number","Name on the Credit Card","Credit card Adrress","Credit card City","Credit card State","Credit card zip","Credit card Type like Visa,Master Card","Credit card Number","Credit card Expire Date","Total Material Sales($)","Tax($)","Total Charged to the Card($)","Ship Name","Ship Address","City","State","Zip","Ship phone"," Submitalls By","Select a Order Architect","Delivery Request Date","Order Status","Credit Card Expire Month","Credit Card Expire Year","Invoice name","Invoice Address1","Inovice City","Invoice State","Invoice Zip","Invoice Phone","Billing Email","Drafting Email");
				}
				else{
					fieldRequired=Array("cs_company","sales_region","cust_name1","phone","customer_po_no","payment_name","payment_address1","payment_city","payment_state","payment_zip","payment_credit_type","payment_credit_no","payment_exp_date","payment_material_sales","payment_tax","payment_total_charged","ship_name","ship_addr1","city","state","zip","ship_phone","submittals_by","arch_detect","ship_rdate","OT","month","year","invoice_name","invoice_addr1","invoice_city","invoice_state","invoice_zip","invoice_phone","billed_email");
					fieldDescription=Array("CS group company","Sales Region","Billing Customer Name","Billing Customer Phone","P.O. Number","Name on the Credit Card","Credit card Adrress","Credit card City","Credit card State","Credit card zip","Credit card Type like Visa,Master Card","Credit card Number","Credit card Expire Date","Total Material Sales($)","Tax($)","Total Charged to the Card($)","Ship Name","Ship Address","City","State","Zip","Ship phone"," Submitalls By","Select a Order Architect","Delivery Request Date","Order Status","Credit Card Expire Month","Credit Card Expire Year","Invoice name","Invoice Address1","Inovice City","Invoice State","Invoice Zip","Invoice Phone","Billing Email");
				}
				var date1=new Date(formobj.date_require.value.substring(2,4),formobj.date_require.value.substring(5,7),formobj.date_require.value.substring(8,10));
				var date2=new Date(formobj.todaysDate.value.substring(2,4),formobj.todaysDate.value.substring(5,7),formobj.todaysDate.value.substring(8,10));
				//alert(date1+"::"+date2);
				if(date2>=date1){
					//alert("today is great or equals to selected date");
					alertMsg+=" - Required date can not be today or before today\n";
				}
			}
			else if(document.getElementById("submittals_by")&&formobj.submittals_by.value=="FACTORY"&&formobj.product_id.value=="IWP"){
				fieldRequired=Array("cs_company","sales_region","cust_name1","phone","customer_po_no","payment_name","payment_address1","payment_city","payment_state","payment_zip","payment_credit_type","payment_credit_no","payment_exp_date","payment_material_sales","payment_tax","payment_total_charged","ship_name","ship_addr1","city","state","zip","ship_phone","submittals_by","arch_detect","ship_rdate","OT","month","year","invoice_name","invoice_addr1","invoice_city","invoice_state","invoice_zip","invoice_phone","billed_email","drafting_email");
				//2) Enter field description to appear in the dialog box
				fieldDescription=Array("CS group company","Sales Region","Billing Customer Name","Billing Customer Phone","P.O. Number","Name on the Credit Card","Credit card Adrress","Credit card City","Credit card State","Credit card zip","Credit card Type like Visa,Master Card","Credit card Number","Credit card Expire Date","Total Material Sales($)","Tax($)","Total Charged to the Card($)","Ship Name","Ship Address","City","State","Zip","Ship phone"," Submitalls By","Select a Order Architect","Delivery Request Date","Order Status","Credit Card Expire Month","Credit Card Expire Year","Invoice name","Invoice Address1","Inovice City","Invoice State","Invoice Zip","Invoice Phone","Billing Email","Drafting Email");
			}
			else{
				//alert("here3x::"+formobj.product_id.value+"::");
				if(document.getElementById("submittals_by")&&formobj.product_id.value=="EJC"){
					// alert("4x");
					fieldRequired=Array("cs_company","sales_region","cust_name1","phone","customer_po_no","payment_name","payment_address1","payment_city","payment_state","payment_zip","payment_credit_type","payment_credit_no","payment_exp_date","payment_material_sales","payment_tax","payment_total_charged","ship_name","ship_addr1","city","state","zip","ship_phone","submittals_by","arch_detect","ship_rdate","OT","month","year","invoice_name","invoice_addr1","invoice_city","invoice_state","invoice_zip","invoice_phone","billed_email","drafting_email");
					fieldDescription=Array("CS group company","Sales Region","Billing Customer Name","Billing Customer Phone","P.O. Number","Name on the Credit Card","Credit card Adrress","Credit card City","Credit card State","Credit card zip","Credit card Type like Visa,Master Card","Credit card Number","Credit card Expire Date","Total Material Sales($)","Tax($)","Total Charged to the Card($)","Ship Name","Ship Address","City","State","Zip","Ship phone"," Submitalls By","Select a Order Architect","Delivery Request Date","Order Status","Credit Card Expire Month","Credit Card Expire Year","Invoice name","Invoice Address1","Inovice City","Invoice State","Invoice Zip","Invoice Phone","Billing Email","Drafting Email");

				}
				else{
					//alert("5x");
					fieldRequired=Array("cs_company","sales_region","cust_name1","phone","customer_po_no","payment_name","payment_address1","payment_city","payment_state","payment_zip","payment_credit_type","payment_credit_no","payment_exp_date","payment_material_sales","payment_tax","payment_total_charged","ship_name","ship_addr1","city","state","zip","ship_phone","submittals_by","arch_detect","ship_rdate","OT","month","year","invoice_name","invoice_addr1","invoice_city","invoice_state","invoice_zip","invoice_phone","billed_email");
					fieldDescription=Array("CS group company","Sales Region","Billing Customer Name","Billing Customer Phone","P.O. Number","Name on the Credit Card","Credit card Adrress","Credit card City","Credit card State","Credit card zip","Credit card Type like Visa,Master Card","Credit card Number","Credit card Expire Date","Total Material Sales($)","Tax($)","Total Charged to the Card($)","Ship Name","Ship Address","City","State","Zip","Ship phone"," Submitalls By","Select a Order Architect","Delivery Request Date","Order Status","Credit Card Expire Month","Credit Card Expire Year","Invoice name","Invoice Address1","Inovice City","Invoice State","Invoice Zip","Invoice Phone","Billing Email");
				}
			}
			if(document.getElementById("ship_rdate")&&formobj.product_id.value=="EFS"){
				var date3=new Date(formobj.ship_rdate.value.substring(2,4),formobj.ship_rdate.value.substring(5,7),formobj.ship_rdate.value.substring(8,10));
				var date4=new Date(formobj.todaysDate.value.substring(2,4),formobj.todaysDate.value.substring(5,7),formobj.todaysDate.value.substring(8,10));
				if(date4>=date3){
					//alert("today is great or equals to selected date");
					alertMsg+=" - Requested ship date can not be today or before today\n";
				}
			}
			if(document.getElementById("ship_rdate")&&formobj.ship_rdate.value!=""&&(formobj.product_id.value!="EFS")){
				var date3=new Date(formobj.ship_rdate.value.substring(2,4),formobj.ship_rdate.value.substring(5,7),formobj.ship_rdate.value.substring(8,10));
				var date4=new Date(formobj.todaysDate.value.substring(2,4),formobj.todaysDate.value.substring(5,7),formobj.todaysDate.value.substring(8,10));
				if(date4>date3){
					//alert("today is great or equals to selected date");
					alertMsg+=" - Requested ship date cannot be older than current date, please correct";
				}
			}
			
		}
		//alert("4");
		//3) Enter dialog message

		for(var i=0;i<fieldRequired.length;i++){
			//alert(fieldRequired[i]);
			var obj=formobj.elements[fieldRequired[i]];
			if(obj){

				switch(obj.type){
					case "select-one":
						if(obj.selectedIndex==-1||obj.options[obj.selectedIndex].text==""){
							alertMsg+=" - "+fieldDescription[i]+"\n";
						}
						break;
					case "select-multiple":
						if(obj.selectedIndex==-1){
							alertMsg+=" - "+fieldDescription[i]+"\n";
						}
						break;
					case "text":

					case "textarea":
						//alert(fieldDescription[i]+"x"+obj.value+"x");

						if(obj.value==""||obj.value==null){
							if(fieldDescription[i]=="Invoice Address1"){
								var obj2=formobj.elements["invoice_addr2"];
								if(obj2){
									//alert("invoice 2 exists"+obj2.value);
									if(Trim(obj2.value)==""||obj2.value==null){
										alertMsg+=" - "+fieldDescription[i]+"\n"
									}
								}
								else{
									alertMsg+=" - "+fieldDescription[i]+" \n"
								}
							}
							else if(fieldDescription[i]=="Ship Address"){
								var obj2=formobj.elements["ship_addr2"];
								if(obj2){
									//alert("ship 2 exists");
									if(obj2.value==""||obj2.value==null){
										alertMsg+=" - "+fieldDescription[i]+" \n"
									}
								}
								else{
									alertMsg+=" - "+fieldDescription[i]+" \n"
								}
							}
							else{
								alertMsg+=" - "+fieldDescription[i]+" \n";
							}
						}
						else if(fieldDescription[i]=="Delivery Request Date"){
							//alert("got here");
							if(obj.value.indexOf("-")<=0){
								//alert("got here 2");
								alertMsg+=" - "+fieldDescription[i]+"\n";
							}
						}
						break;
					default:
						if(obj.value==""||obj.value==null){
							alertMsg+=" - "+fieldDescription[i]+"\n";
						}
				}
			}

		}
		var obj2=formobj.elements["billed_email"];
		if(obj2){

			if(document.selectform.email_acknowledgement.checked){
				if(obj2.value==""||obj2.value==null){
					alertMsg+=" - Email Acknowledgement checked with not email address in billing customer \n";
				}
			}
		}

	}





	if(alertMsg.length==l_Msg){
		return true;
	}else{
		alert(alertMsg);
		return false;
	}
}

function LTrim(str){
	//alert("ltrim");
	var whitespace=new String(" \t\n\r");
	var s=new String(str);

	if(whitespace.indexOf(s.charAt(0))!=-1){
		var j=0,i=s.length;
		while(j<i&&whitespace.indexOf(s.charAt(j))!=-1)
			j++;
		s=s.substring(j,i);
	}
	return s;
}
function RTrim(str){
	//alert("rtrim");
	var whitespace=new String(" \t\n\r");
	var s=new String(str);
	if(whitespace.indexOf(s.charAt(s.length-1))!=-1){
		var i=s.length-1;
		while(i>=0&&whitespace.indexOf(s.charAt(i))!=-1)
			i--;
		s=s.substring(0,i+1);
	}
	return s;
}
function Trim(str){
	//alert("trim");
	return RTrim(LTrim(str));
}


