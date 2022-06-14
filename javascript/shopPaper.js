function doThis(){
	if(document.madForm.nav_no.value.length > 0 ) {
                document.madForm.url.value="../documentGenerator.jsp?orderNo="+document.madForm.order_no.value+"&urlx=reports/efs_uk_shoppaper.jsp&urlAddx=&action=rtf&navNo="+document.madForm.nav_no.value;
		n_window();
	}
	else{
		alert("Enter a nav Number");
		return false;
	}
}


function n_window(){
        //alert(document.madForm.url.value);
	//alert("n windows");
	var the_width=450;
	var the_height=400;
	var from_top=60;
	var from_left=560;
	var has_toolbar='no';
	var has_location='no';
	var has_directories='no';
	var has_status='yes';
	var has_menubar='yes';
	var has_scrollbars='yes';
	var is_resizable='yes';
	var the_atts='width='+the_width+',height='+the_height+',top='+from_top+',screenY='+from_top+',left='+from_left+',screenX='+from_left;
	the_atts+=',toolbar='+has_toolbar+',location='+has_location+',directories='+has_directories+',status='+has_status;
	the_atts+=',menubar='+has_menubar+',scrollbars='+has_scrollbars+',resizable='+is_resizable;
	window.open(document.madForm.url.value,'',the_atts);
}