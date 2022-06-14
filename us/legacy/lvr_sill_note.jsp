<%

int sillCount=0;
ResultSet rsSill=stmt.executeQuery("select count(*) from cs_costing where order_no='"+order_no+"' and (core_code like '%097%' or core_code like '%155%' or core_code like '%157%') and not ssh_code like '%slpn'");
if(rsSill != null){
	while(rsSill.next()){
		sillCount=rsSill.getInt(1);
	}
}
rsSill.close();

if(sillCount >0){

	String tempQual="";
	ResultSet rsSillProject=stmt.executeQuery("select qualifying_notes from cs_project where order_no='"+order_no+"'");
	if(rsSillProject != null){
		while(rsSillProject.next()){
			tempQual=rsSillProject.getString(1);
		}
	}
	rsSillProject.close();
	
	if(tempQual != null && !tempQual.equals("null")&&tempQual.trim().length()>0){
		boolean isThere=false;
		if(tempQual.indexOf(",97,")>=0){
			isThere=true;
		}
		if(!isThere){
			if(tempQual.length()>=3){
				if(tempQual.substring(tempQual.length()-3).indexOf(",97")>=0){
					isThere=true;
				}
				if(tempQual.substring(0,3).indexOf("97,")>=0){
					isThere=true;
				}
			}
		}
		if(!isThere){
			if(tempQual.endsWith(",")){
				tempQual=tempQual.substring(0,tempQual.length()-1);
			}
			tempQual=tempQual+",97";
		}	
	}
	else{
		tempQual="97";
	}
	try{
		java.sql.PreparedStatement psQual=myConn.prepareStatement("UPDATE cs_project SET qualifying_notes =? WHERE Order_no =? ");
		psQual.setString(1,tempQual);
		psQual.setString(2,order_no);
		int reQual=psQual.executeUpdate();
		psQual.close();
	}
	catch (java.sql.SQLException e)	{
		out.println("Problem with ENTERING Qualifying notes TO Projects"+"<br>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}	
	
	
}


%>