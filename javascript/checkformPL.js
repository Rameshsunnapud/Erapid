

function formCheck(formobj){

//alert("HERE2");
	var alertMsg = "Proszę uzupełnij następujące Pola:\n";
	
	var l_Msg = alertMsg.length;


	var fieldRequired = Array( "projectName", "docType", "custLoc","custName","shipPhone","marketType","projectState","quoteSource");
	//2) Enter field description to appear in the dialog box
	var fieldDescription = Array("Nazwa Inwestycji","Typ","Klient"," Kontakt","Kontakt -Telefon ", "Projekt - Grupa","Inwestycja – wojew.","Źródło Oferty");
	//3) Enter dialog message

	
	for (var i = 0; i < fieldRequired.length; i++){
		var obj = formobj.elements[fieldRequired[i]];
		if(i==9){
			if(obj.value=="empty"){
				alertMsg+= " - " + fieldDescription[i] + "\n";
			}
	}
	else{
			if (obj){
				switch(obj.type){
				case "select-one":
					if (obj.selectedIndex == -1 || obj.options[obj.selectedIndex].text == ""){
						alertMsg += " - " + fieldDescription[i] + "\n";
					}
					break;
				case "select-multiple":
					if (obj.selectedIndex == -1){
						alertMsg += " - " + fieldDescription[i] + "\n";
					}
					break;
				case "text":
				case "textarea":
					if (obj.value == "" || obj.value == null || obj.value == " "){
						alertMsg += " - " + fieldDescription[i] + "\n";
					}
					break;
				default:
					if (obj.value == "" || obj.value == null || obj.value == " "){
						alertMsg += " - " + fieldDescription[i] + "\n";
					}
				}
			}
		}
	}
	if (alertMsg.length == l_Msg){
		return true;
	}else{
		alert(alertMsg);
		return false;
	}
}


