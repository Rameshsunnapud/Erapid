<%@ include file="../../db_con_web.jsp"%>
<%@ include file="../../db_con.jsp"%>
<%
//out.println("start");
myConn.setAutoCommit(false);
String web_order_no="";
String web_product_id="";
String web_rep_no="";
String imported_lines="";
int maxLine=1;
ResultSet rsWeb1=stmt.executeQuery("select project_type_id,product_id,creator_id from cs_project where order_no='"+orderNo+"'");
if(rsWeb1 !=null){
	while(rsWeb1.next()){
		web_order_no=rsWeb1.getString("project_type_id");
		web_product_id=rsWeb1.getString("product_id");
		web_rep_no=rsWeb1.getString("creator_id");
	}
}
rsWeb1.close();

java.util.Date uDatex = new java.util.Date();
java.sql.Date date2 = new java.sql.Date(uDatex.getTime());
Vector doc_number=new Vector();
Vector dp_number=new Vector();
Vector doc_priority=new Vector();
Vector doc_description=new Vector();
Vector expires_date=new Vector();
Vector due_date=new Vector();
Vector promise_date=new Vector();
Vector doc_status=new Vector();
Vector doc_title=new Vector();
Vector doc_customer=new Vector();
Vector ship_to=new Vector();
Vector doc_terms=new Vector();
Vector plant_no=new Vector();
Vector doc_so_num=new Vector();
Vector doc_so_date=new Vector();
Vector doc_so_user=new Vector();
Vector doc_office=new Vector();
Vector dcm_id=new Vector();
Vector dcm_id2=new Vector();
Vector dcm_id3=new Vector();
Vector dcm_id4=new Vector();
Vector dcm_id5=new Vector();
Vector fob=new Vector();
Vector ship_method=new Vector();
Vector ship_carrier=new Vector();
Vector ship_pmt_method=new Vector();
Vector discount_factor=new Vector();
Vector po_number=new Vector();
Vector po_date=new Vector();
Vector taxable=new Vector();
Vector config_string=new Vector();
Vector frozen_string=new Vector();
Vector ec_statusy=new Vector();
Vector comments=new Vector();
Vector default_rec =new Vector();
Vector freeze_rec=new Vector();
Vector rev_history=new Vector();
Vector created_by=new Vector();
Vector rev_date=new Vector();
Vector win_loss_desc=new Vector();
Vector group_owner=new Vector();
Vector reason_code=new Vector();
Vector header_directory=new Vector();
Vector doc_download=new Vector();
Vector doc_stage=new Vector();
Vector dm_complete=new Vector();
Vector submitted_state=new Vector();
Vector speed_number=new Vector();
Vector from_quote=new Vector();
Vector ship_date=new Vector();
Vector pv_status=new Vector();
Vector mv_status=new Vector();
ResultSet rsWeb2=stmt_web.executeQuery("select * from doc_header where doc_number='"+web_order_no+"'");
if(rsWeb2 !=null){
	while(rsWeb2.next()){
		doc_number.addElement(rsWeb2.getString("doc_number"));
		dp_number.addElement(rsWeb2.getString("dp_number"));
		doc_priority.addElement(rsWeb2.getString("doc_priority"));
		doc_description.addElement(rsWeb2.getString("doc_description"));
		expires_date.addElement("");

		due_date.addElement("");
		promise_date.addElement("");
		doc_status.addElement(rsWeb2.getString("doc_status"));
		doc_title.addElement(rsWeb2.getString("doc_title"));
		doc_customer.addElement(rsWeb2.getString("doc_customer"));
		ship_to.addElement(rsWeb2.getString("ship_to"));
		doc_terms.addElement(rsWeb2.getString("doc_terms"));
		plant_no.addElement(rsWeb2.getString("plant_no"));
		doc_so_num.addElement(rsWeb2.getString("doc_so_num"));
		doc_so_date.addElement("");
		doc_so_user.addElement(rsWeb2.getString("doc_so_user"));
		doc_office.addElement(rsWeb2.getString("doc_office"));
		dcm_id.addElement(rsWeb2.getString("dcm_id"));
		dcm_id2.addElement(rsWeb2.getString("dcm_id2"));
		dcm_id3.addElement(rsWeb2.getString("dcm_id3"));
		dcm_id4.addElement(rsWeb2.getString("dcm_id4"));
		dcm_id5.addElement(rsWeb2.getString("dcm_id5"));
		fob.addElement(rsWeb2.getString("fob"));
		ship_method.addElement(rsWeb2.getString("ship_method"));
		ship_carrier.addElement(rsWeb2.getString("ship_carrier"));
		ship_pmt_method.addElement(rsWeb2.getString("ship_pmt_method"));
		discount_factor.addElement(rsWeb2.getString("discount_factor"));
		po_number.addElement(rsWeb2.getString("po_number"));
		po_date.addElement(rsWeb2.getString("po_date"));
		taxable.addElement(rsWeb2.getString("taxable"));
		config_string.addElement(rsWeb2.getString("config_string"));
		frozen_string.addElement(rsWeb2.getString("frozen_string"));
		ec_statusy.addElement(rsWeb2.getString("ec_status"));
		comments.addElement(rsWeb2.getString("comments"));
		default_rec.addElement(rsWeb2.getString("default_rec"));
		freeze_rec.addElement(rsWeb2.getString("freeze_rec"));
		rev_history.addElement(rsWeb2.getString("rev_history"));
		created_by.addElement(rsWeb2.getString("created_by"));
		rev_date.addElement(rsWeb2.getString("rev_date"));
		win_loss_desc.addElement(rsWeb2.getString("win_loss_desc"));
		group_owner.addElement(rsWeb2.getString("group_owner"));
		reason_code.addElement(rsWeb2.getString("reason_code"));
		header_directory.addElement(rsWeb2.getString("header_directory"));
		doc_download.addElement(rsWeb2.getString("doc_download"));
		doc_stage.addElement(rsWeb2.getString("doc_stage"));
		dm_complete.addElement(rsWeb2.getString("dm_complete"));
		submitted_state.addElement(rsWeb2.getString("submitted_state"));
		speed_number.addElement(rsWeb2.getString("speed_number"));
		from_quote.addElement(rsWeb2.getString("from_quote"));
		ship_date.addElement(rsWeb2.getString("ship_date"));
		pv_status.addElement(rsWeb2.getString("pv_status"));
		mv_status.addElement(rsWeb2.getString("mv_status"));
	}
}
rsWeb2.close();
int countHeader=0;
ResultSet rsWeb25=stmt.executeQuery("select count(*) from doc_header where doc_number='"+orderNo+"'");
if(rsWeb25 != null){
	while(rsWeb25.next()){
		countHeader=rsWeb25.getInt(1);
	}
}
rsWeb25.close();

//out.println("Count header = "+countHeader+"<BR>");
if(countHeader<1){
	try{
		for(int x=0; x<doc_number.size(); x++){
			//out.println(expires_date.elementAt(x).toString()+"::1<BR>");
			if(expires_date==null){
				expires_date.setElementAt("",x);
			}
			//out.println(expires_date.elementAt(x).toString()+"::2<BR>");
			String insert ="INSERT INTO doc_header VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
			PreparedStatement insertDocHeader = myConn.prepareStatement(insert);
			insertDocHeader.setString(1,orderNo);
			insertDocHeader.setString(2,"O");
			insertDocHeader.setString(3,"1");
			insertDocHeader.setString(4,dp_number.elementAt(x).toString());
			insertDocHeader.setString(5,doc_description.elementAt(x).toString());
			insertDocHeader.setString(6,""+expires_date.elementAt(x).toString());
			insertDocHeader.setString(7,""+date2);
			insertDocHeader.setString(8,""+date2);
			insertDocHeader.setString(9,due_date.elementAt(x).toString());
			insertDocHeader.setString(10,promise_date.elementAt(x).toString());
			insertDocHeader.setString(11,doc_status.elementAt(x).toString());
			insertDocHeader.setString(12,doc_title.elementAt(x).toString());
			insertDocHeader.setString(13,doc_customer.elementAt(x).toString());
			insertDocHeader.setString(14,ship_to.elementAt(x).toString());
			insertDocHeader.setString(15,web_rep_no);
			insertDocHeader.setString(16,doc_terms.elementAt(x).toString());
			insertDocHeader.setString(17,plant_no.elementAt(x).toString());
			insertDocHeader.setString(18,doc_so_num.elementAt(x).toString());
			insertDocHeader.setString(19,doc_so_date.elementAt(x).toString());
			insertDocHeader.setString(20,doc_so_user.elementAt(x).toString());
			insertDocHeader.setString(21,doc_office.elementAt(x).toString());
			insertDocHeader.setString(22,dcm_id.elementAt(x).toString());
			insertDocHeader.setString(23,dcm_id2.elementAt(x).toString());
			insertDocHeader.setString(24,dcm_id3.elementAt(x).toString());
			insertDocHeader.setString(25,dcm_id4.elementAt(x).toString());
			insertDocHeader.setString(26,dcm_id5.elementAt(x).toString());
			insertDocHeader.setString(27,fob.elementAt(x).toString());
			insertDocHeader.setString(28,ship_method.elementAt(x).toString());
			insertDocHeader.setString(29,ship_carrier.elementAt(x).toString());
			insertDocHeader.setString(30,ship_pmt_method.elementAt(x).toString());
			insertDocHeader.setString(31,discount_factor.elementAt(x).toString());
			// changed by AC as it was hard coded to "C" and must copy over from web store
			if(web_product_id.equals("EJC")){
				insertDocHeader.setString(32,"C");
			}
			else{
				insertDocHeader.setString(32,doc_priority.elementAt(x).toString());
			}
			insertDocHeader.setString(33,"0");
			insertDocHeader.setString(34,po_number.elementAt(x).toString());
			insertDocHeader.setString(35,"");
			//po_date.elementAt(x).toString());
			insertDocHeader.setString(36,taxable.elementAt(x).toString());
			insertDocHeader.setString(37,web_product_id);
			insertDocHeader.setString(38,config_string.elementAt(x).toString());
			insertDocHeader.setString(39,frozen_string.elementAt(x).toString());
			insertDocHeader.setString(40,ec_statusy.elementAt(x).toString());
			insertDocHeader.setString(41,comments.elementAt(x).toString());
			insertDocHeader.setString(42,default_rec.elementAt(x).toString());
			insertDocHeader.setString(43,freeze_rec.elementAt(x).toString());
			insertDocHeader.setString(44,rev_history.elementAt(x).toString());
			insertDocHeader.setString(45,created_by.elementAt(x).toString());
			insertDocHeader.setString(46,"");
			//rev_date.elementAt(x).toString());
			insertDocHeader.setString(47,"CLOSE");
			insertDocHeader.setString(48,win_loss_desc.elementAt(x).toString());
			insertDocHeader.setString(49,group_owner.elementAt(x).toString());
			insertDocHeader.setString(50,reason_code.elementAt(x).toString());
			insertDocHeader.setString(51,header_directory.elementAt(x).toString());
			insertDocHeader.setString(52,doc_download.elementAt(x).toString());
			insertDocHeader.setString(53,doc_stage.elementAt(x).toString());
			insertDocHeader.setString(54,dm_complete.elementAt(x).toString());
			insertDocHeader.setString(55,submitted_state.elementAt(x).toString());
			insertDocHeader.setString(56,speed_number.elementAt(x).toString());
			insertDocHeader.setString(57,from_quote.elementAt(x).toString());
			insertDocHeader.setString(58,"");
			//ship_date.elementAt(x).toString());
			insertDocHeader.setString(59,pv_status.elementAt(x).toString());
			insertDocHeader.setString(60,mv_status.elementAt(x).toString());
			insertDocHeader.setString(61,"");
			insertDocHeader.setString(62,"");
			insertDocHeader.setString(63,"");
			insertDocHeader.setString(64,"");
			insertDocHeader.setString(65,"");
			insertDocHeader.setString(66,"");
			insertDocHeader.setString(67,"");
			int rocount = insertDocHeader.executeUpdate();
			insertDocHeader.close();
			//out.println("HERE3<BR>");
		}
	}
	catch (java.sql.SQLException e)
	{
		out.println("Problem INSERTING INTO doc_header table"+"<br>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
	}

}

myConn.commit();
//logger.debug("Web order #= "+web_order_no+", "+web_product_id+"<BR>");
String pidlines="";
ResultSet rspidlines=stmt_web.executeQuery("select line_no from cs_ws_output where order_no='"+web_order_no+"' and product_id='"+web_product_id+"'");
if(rspidlines !=null){
	while(rspidlines.next()){
		pidlines=pidlines+"'"+rspidlines.getString(1)+"',";
		maxLine=rspidlines.getInt(1);
	}
}
rspidlines.close();
if(pidlines.trim().length()>0){
		pidlines=pidlines.substring(0,pidlines.length()-1);
}
//out.println("Line numbers found: "+pidlines+"<BR>");

Vector doc_numberx=new Vector();
Vector doc_line=new Vector();
Vector line_id=new Vector();
Vector item_number=new Vector();
Vector item_type=new Vector();
Vector item_group=new Vector();
Vector item_desc=new Vector();
Vector commentsx=new Vector();
Vector plant_nox=new Vector();
Vector warehouse=new Vector();
Vector qty_ord=new Vector();
Vector unit_measure=new Vector();
Vector cost=new Vector();
Vector default_price=new Vector();
Vector taxablex=new Vector();
Vector serial_no=new Vector();
Vector blanket_order=new Vector();
Vector release_date=new Vector();
Vector cust_code=new Vector();
Vector fobx=new Vector();
Vector ship_tox=new Vector();
Vector ship_methodx=new Vector();
Vector ship_carrierx=new Vector();
Vector ship_pmt_methodx=new Vector();
Vector ship_datex=new Vector();
Vector speed_numberx=new Vector();
Vector smartpart_in=new Vector();
Vector smartpart_out=new Vector();
Vector attributes_string=new Vector();
Vector config_stringx=new Vector();
Vector frozen_stringx=new Vector();
Vector ec_statusx=new Vector();
Vector configured_system=new Vector();
Vector freeze_recx=new Vector();
Vector rev_historyx=new Vector();
Vector rev_datex=new Vector();
Vector reason_codex=new Vector();
Vector group_ownerx=new Vector();
Vector dm_completex=new Vector();
Vector submitted_statex=new Vector();
Vector subtotal_code=new Vector();
Vector from_quote_line=new Vector();
Vector root_id=new Vector();
if(pidlines.trim().length()>0){ // Below modified by AC 3/1/2017 to sort lines as integer
	ResultSet rsWeb3=stmt_web.executeQuery("select * from doc_line where doc_number='"+web_order_no+"' and doc_line in ("+pidlines+") order by cast(doc_line as integer)");
	if(rsWeb3 !=null){
		while(rsWeb3.next()){
			doc_line.addElement(rsWeb3.getString("doc_line"));
			doc_numberx.addElement(rsWeb3.getString("doc_number"));
			line_id.addElement(rsWeb3.getString("line_id"));
			item_number.addElement(rsWeb3.getString("item_number"));
			item_type.addElement(rsWeb3.getString("item_type"));
			item_group.addElement(rsWeb3.getString("item_group"));
			item_desc.addElement(rsWeb3.getString("item_desc"));
			commentsx.addElement(rsWeb3.getString("comments"));
			plant_nox.addElement(rsWeb3.getString("plant_no"));
			warehouse.addElement(rsWeb3.getString("warehouse"));
			qty_ord.addElement(rsWeb3.getString("qty_ord"));
			unit_measure.addElement(rsWeb3.getString("unit_measure"));
			cost.addElement(rsWeb3.getString("cost"));
			default_price.addElement(rsWeb3.getString("default_price"));
			taxablex.addElement(rsWeb3.getString("taxable"));
			serial_no.addElement(rsWeb3.getString("serial_no"));
			blanket_order.addElement(rsWeb3.getString("blanket_order"));
			release_date.addElement(rsWeb3.getString("release_date"));
			cust_code.addElement(rsWeb3.getString("cust_code"));
			fobx.addElement(rsWeb3.getString("fob"));
			ship_tox.addElement(rsWeb3.getString("ship_to"));
			ship_methodx.addElement(rsWeb3.getString("ship_method"));
			ship_carrierx.addElement(rsWeb3.getString("ship_carrier"));
			ship_pmt_methodx.addElement(rsWeb3.getString("ship_pmt_method"));
			ship_datex.addElement(rsWeb3.getString("ship_date"));
			speed_numberx.addElement(rsWeb3.getString("speed_number"));
			smartpart_in.addElement(rsWeb3.getString("smartpart_in"));
			smartpart_out.addElement(rsWeb3.getString("smartpart_out"));
			config_stringx.addElement("");
			attributes_string.addElement("");
			frozen_stringx.addElement(rsWeb3.getString("frozen_string"));
			ec_statusx.addElement(rsWeb3.getString("ec_status"));
			configured_system.addElement(rsWeb3.getString("configured_system"));
			freeze_recx.addElement(rsWeb3.getString("freeze_rec"));
			rev_historyx.addElement(rsWeb3.getString("rev_history"));
			rev_datex.addElement(rsWeb3.getString("rev_date"));
			reason_codex.addElement(rsWeb3.getString("reason_code"));
			group_ownerx.addElement(rsWeb3.getString("group_owner"));
			dm_completex.addElement(rsWeb3.getString("dm_complete"));
			submitted_statex.addElement(rsWeb3.getString("submitted_state"));
			subtotal_code.addElement(rsWeb3.getString("subtotal_code"));
			from_quote_line.addElement(rsWeb3.getString("from_quote_line"));
			root_id.addElement(rsWeb3.getString("root_id"));
		}
	}
	rsWeb3.close();
}
for(int i=0; i<doc_numberx.size();i++){
	//	out.println(i+"::<BR>");
	String tempconfigstring="";
	String tempqty="";
	String tempUnitPrice="";
	String tempPriceString="";
	String tempAttributesString="";
	ResultSet rsWeb4=stmt_web.executeQuery("select config_string,qty,unit_price,price_string,attributes_string from cs_ws_output where order_no='"+web_order_no+"' and line_no='"+doc_line.elementAt(i).toString()+"'");
	if(rsWeb4 != null){
		while(rsWeb4.next()){
			tempconfigstring=rsWeb4.getString(1);
			tempqty=rsWeb4.getString(2);
			tempUnitPrice=rsWeb4.getString("unit_price");
			tempPriceString=rsWeb4.getString("price_string");
			tempAttributesString=rsWeb4.getString("attributes_string");
		}
	}
	rsWeb4.close();
	if(tempPriceString == null) tempPriceString = "";
	if(web_product_id.equals("EJC")){

		if(tempAttributesString != null && tempAttributesString.startsWith("ACC/FB")){
			tempconfigstring = tempconfigstring.substring(0,tempconfigstring.indexOf("&"+tempAttributesString))+tempconfigstring.substring(tempAttributesString.length()+1+tempconfigstring.indexOf("&"+tempAttributesString));
		}
		String tempvalues="";
		String tempvalues2="";
		if(tempPriceString.trim().length()>0){
			tempvalues=tempPriceString.substring(tempPriceString.indexOf("["),tempPriceString.indexOf("}"));
		} else {
			tempvalues="[0.00#0.00}";
			tempPriceString="[0.00#0.00}";
			out.println("<font color='red'><b>ERROR!!! Missing Pricing!!! - Check output!!!</b></font><br><br>");
		}
		tempvalues2=tempvalues.substring(tempvalues.indexOf("#")+1);
		tempvalues=tempvalues.substring(1,tempvalues.indexOf("#"));

		//out.println(tempvalues2+"::<BR>");
		tempPriceString=tempPriceString.substring(0,tempPriceString.indexOf("[")+1)+"```"+tempPriceString.substring(tempPriceString.indexOf("}"));

		String cleanconfigstring = tempconfigstring.replaceAll("}","]").replaceAll("#%Q%#",tempqty);

		tempconfigstring=tempconfigstring+"&"+tempPriceString.replaceAll("```",tempvalues);

		if(tempAttributesString != null && tempAttributesString.trim().length()>0){
			tempAttributesString=tempAttributesString+"&"+tempPriceString.replaceAll("```",tempvalues2);
			tempAttributesString=tempAttributesString.replaceAll("#%Q%#",tempqty);
			tempAttributesString=tempAttributesString.replaceAll("}","]");
			tempAttributesString=tempAttributesString + "&" + cleanconfigstring;
			//out.println(tempAttributesString+"::<BR>");
			attributes_string.setElementAt(tempAttributesString,i);
		}
	}
	tempconfigstring=tempconfigstring.replaceAll("#%Q%#",tempqty);
	if(web_product_id.equals("EFS")||web_product_id.equals("GCP")){
		double tempprice=new Double(tempUnitPrice).doubleValue()*new Double(tempqty).doubleValue();
		tempconfigstring=tempconfigstring+"&"+tempPriceString;
	}
	String tempprstr = "";
	if(tempPriceString.length() > 0){
		tempprstr = "&" + tempPriceString.replaceAll("}","]");
	}
	tempconfigstring=tempconfigstring.replaceAll("}","]");
	if(web_product_id.equals("IWP")){
		tempconfigstring=tempconfigstring+tempprstr+"&DISC/UP["+tempUnitPrice+"]";
	}
	config_stringx.setElementAt(tempconfigstring,i);
}
int linecount=0;

if(pidlines.trim().length()>0){
	ResultSet rsWeb5=stmt.executeQuery("select count(*) from doc_line where doc_number='"+orderNo+"'");
// and doc_line in ("+pidlines+")");
	if(rsWeb5 != null){
		while(rsWeb5.next()){
			linecount=rsWeb5.getInt(1);
		}
	}
	rsWeb5.close();
}
//out.println(linecount);

ResultSet rsWeb6=stmt_web.executeQuery("select * from cs_ws_output where order_no='"+web_order_no+"' and product_id='"+web_product_id+"' and not line_no in (select doc_line from doc_line where doc_number='"+web_order_no+"')");
if(rsWeb6 != null){
	while(rsWeb6.next()){
		//out.println("HERE");
		doc_line.addElement(rsWeb6.getString("line_no"));
		doc_numberx.addElement(rsWeb6.getString("order_no"));
		line_id.addElement("");
		item_number.addElement("");
		item_type.addElement("");
		item_group.addElement("");
		item_desc.addElement("");
		commentsx.addElement("");
		plant_nox.addElement("");
		warehouse.addElement("");
		qty_ord.addElement("1");
		unit_measure.addElement("");
		cost.addElement("0");
		default_price.addElement("0");
		taxablex.addElement("");
		serial_no.addElement("");
		blanket_order.addElement("");
		release_date.addElement(null);
		cust_code.addElement("");
		fobx.addElement("");
		ship_tox.addElement("");
		ship_methodx.addElement("");
		ship_carrierx.addElement("");
		ship_pmt_methodx.addElement("");
		ship_datex.addElement(null);
		speed_numberx.addElement("");
		smartpart_in.addElement("");
		smartpart_out.addElement("");
		attributes_string.addElement("");
		String price_string=rsWeb6.getString("price_string");
		String tempconfigstring=rsWeb6.getString("config_string");
		tempconfigstring=tempconfigstring.replaceAll("#%Q%#",rsWeb6.getString("qty"));
		tempconfigstring=tempconfigstring.replaceAll("}","]");
		if(web_product_id.equals("IWP")){
			tempconfigstring=tempconfigstring+"&DISC/UP["+rsWeb6.getString("unit_price")+"]";
		}
		// EJC portion added by AC for intuitive EJC accessories that have a null price string
		if(web_product_id.equals("EJC") && price_string == null){
			tempconfigstring=tempconfigstring+"&FPCALC/UP["+rsWeb6.getString("unit_price")+"],CP[10]";
		}
		config_stringx.addElement(tempconfigstring);
		frozen_stringx.addElement("");
		ec_statusx.addElement("PASSED");
		configured_system.addElement("N");
		freeze_recx.addElement("");
		rev_historyx.addElement("Initial Revision");
		rev_datex.addElement(""+date2);
		reason_codex.addElement("");
		group_ownerx.addElement("users");
		dm_completex.addElement("Y");
		submitted_statex.addElement("Y");
		subtotal_code.addElement("");
		from_quote_line.addElement("");
		root_id.addElement("");
	}
}
rsWeb6.close();
int line_counter=0;

//out.println(doc_numberx.size()+"::"+attributes_string.size()+"::<BR>");
//out.println(linecount+"::<BR>");



if(linecount<1){
	for(int x=0; x<doc_numberx.size(); x++){
		try{
			line_counter++;
			String insert ="INSERT INTO doc_line VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
			PreparedStatement insertDocLine = myConn.prepareStatement(insert);
			insertDocLine.setString(1,orderNo);
			insertDocLine.setString(2,""+line_counter);
			insertDocLine.setString(3,"0");
			insertDocLine.setString(4,"O");
			insertDocLine.setString(5,"1");
			insertDocLine.setString(6,line_id.elementAt(x).toString());
			insertDocLine.setString(7,item_number.elementAt(x).toString());
			insertDocLine.setString(8,item_type.elementAt(x).toString());
			insertDocLine.setString(9,item_group.elementAt(x).toString());
			insertDocLine.setString(10,item_desc.elementAt(x).toString());
			insertDocLine.setString(11,commentsx.elementAt(x).toString());
			insertDocLine.setString(12,plant_nox.elementAt(x).toString());
			insertDocLine.setString(13,warehouse.elementAt(x).toString());
			insertDocLine.setDate(14,date2);
			insertDocLine.setDate(15,date2);
			insertDocLine.setString(16,qty_ord.elementAt(x).toString());
			insertDocLine.setString(17,unit_measure.elementAt(x).toString());
			insertDocLine.setString(18,cost.elementAt(x).toString());
			insertDocLine.setString(19,default_price.elementAt(x).toString());
			insertDocLine.setString(20,"0");
			insertDocLine.setString(21,"0");
			insertDocLine.setString(22,taxablex.elementAt(x).toString());
			insertDocLine.setString(23,serial_no.elementAt(x).toString());
			insertDocLine.setString(24,blanket_order.elementAt(x).toString());
			insertDocLine.setString(25,"");
			insertDocLine.setString(26,cust_code.elementAt(x).toString());
			insertDocLine.setString(27,fobx.elementAt(x).toString());
			insertDocLine.setString(28,ship_tox.elementAt(x).toString());
			insertDocLine.setString(29,ship_methodx.elementAt(x).toString());
			insertDocLine.setString(30,ship_carrierx.elementAt(x).toString());
			insertDocLine.setString(31,ship_pmt_methodx.elementAt(x).toString());
			insertDocLine.setString(32,"");
			insertDocLine.setString(33,speed_numberx.elementAt(x).toString());
			insertDocLine.setString(34,smartpart_in.elementAt(x).toString());
			insertDocLine.setString(35,smartpart_out.elementAt(x).toString());
			insertDocLine.setString(36,web_product_id);
			insertDocLine.setString(37,config_stringx.elementAt(x).toString());
			insertDocLine.setString(38,frozen_stringx.elementAt(x).toString());
			insertDocLine.setString(39,ec_statusx.elementAt(x).toString());
			insertDocLine.setString(40,configured_system.elementAt(x).toString());
			insertDocLine.setString(41,"Y");
			insertDocLine.setString(42,freeze_recx.elementAt(x).toString());
			insertDocLine.setString(43,rev_historyx.elementAt(x).toString());
			insertDocLine.setString(44,"");
			insertDocLine.setString(45,web_rep_no);
			insertDocLine.setString(46,reason_codex.elementAt(x).toString());
			insertDocLine.setString(47,group_ownerx.elementAt(x).toString());
			insertDocLine.setString(48,dm_completex.elementAt(x).toString());
			insertDocLine.setString(49,submitted_statex.elementAt(x).toString());
			insertDocLine.setString(50,"0");
			insertDocLine.setString(51,subtotal_code.elementAt(x).toString());
			insertDocLine.setString(52,from_quote_line.elementAt(x).toString());
			insertDocLine.setString(53,"PASSED");
			insertDocLine.setString(54,"PASSED");
			insertDocLine.setString(55,root_id.elementAt(x).toString());
			insertDocLine.setString(56,"");
			insertDocLine.setString(57,"");
			insertDocLine.setString(58,"");
			insertDocLine.setString(59,"");
			insertDocLine.setString(60,"");
			int rocount = insertDocLine.executeUpdate();
			insertDocLine.close();


			imported_lines = web_order_no + ", Lines: " + pidlines;
			}
		catch (Exception e){
			out.println("Problem with ENTERING TO doc_line table"+"<br>");
			out.println("Illegal Operation try again/Report Error"+"<br>");
			myConn.rollback();
			out.println(e.toString());
			return;
		}
	}


	for(int x=0; x<doc_numberx.size(); x++){
		try{
			if( web_product_id.equals("EJC")){
			//	out.println(attributes_string.elementAt(x).toString()+"::<BR>");
				if(attributes_string.elementAt(x) != null && attributes_string.elementAt(x).toString().trim().length()>0 && attributes_string.elementAt(x).toString().startsWith("ACC/FB")){
					maxLine++;
					line_counter++;
					String insert2 ="INSERT INTO doc_line VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) ";
					PreparedStatement insertDocLine2 = myConn.prepareStatement(insert2);
					insertDocLine2.setString(1,orderNo);
					insertDocLine2.setString(2,""+maxLine);
					insertDocLine2.setString(3,"0");
					insertDocLine2.setString(4,"O");
					insertDocLine2.setString(5,"1");
					insertDocLine2.setString(6,line_id.elementAt(x).toString());
					insertDocLine2.setString(7,item_number.elementAt(x).toString());
					insertDocLine2.setString(8,item_type.elementAt(x).toString());
					insertDocLine2.setString(9,item_group.elementAt(x).toString());
					insertDocLine2.setString(10,item_desc.elementAt(x).toString());
					insertDocLine2.setString(11,commentsx.elementAt(x).toString());
					insertDocLine2.setString(12,plant_nox.elementAt(x).toString());
					insertDocLine2.setString(13,warehouse.elementAt(x).toString());
					insertDocLine2.setDate(14,date2);
					insertDocLine2.setDate(15,date2);
					insertDocLine2.setString(16,qty_ord.elementAt(x).toString());
					insertDocLine2.setString(17,unit_measure.elementAt(x).toString());
					insertDocLine2.setString(18,cost.elementAt(x).toString());
					insertDocLine2.setString(19,default_price.elementAt(x).toString());
					insertDocLine2.setString(20,"0");
					insertDocLine2.setString(21,"0");
					insertDocLine2.setString(22,taxablex.elementAt(x).toString());
					insertDocLine2.setString(23,serial_no.elementAt(x).toString());
					insertDocLine2.setString(24,blanket_order.elementAt(x).toString());
					insertDocLine2.setString(25,"");
					//release_date.elementAt(x).toString());
					insertDocLine2.setString(26,cust_code.elementAt(x).toString());
					insertDocLine2.setString(27,fobx.elementAt(x).toString());
					insertDocLine2.setString(28,ship_tox.elementAt(x).toString());
					insertDocLine2.setString(29,ship_methodx.elementAt(x).toString());
					insertDocLine2.setString(30,ship_carrierx.elementAt(x).toString());
					insertDocLine2.setString(31,ship_pmt_methodx.elementAt(x).toString());
					insertDocLine2.setString(32,"");
					//ship_datex.elementAt(x).toString());
					insertDocLine2.setString(33,speed_numberx.elementAt(x).toString());
					insertDocLine2.setString(34,smartpart_in.elementAt(x).toString());
					insertDocLine2.setString(35,smartpart_out.elementAt(x).toString());
					insertDocLine2.setString(36,web_product_id);
					insertDocLine2.setString(37,attributes_string.elementAt(x).toString());
					insertDocLine2.setString(38,frozen_stringx.elementAt(x).toString());
					insertDocLine2.setString(39,ec_statusx.elementAt(x).toString());
					insertDocLine2.setString(40,configured_system.elementAt(x).toString());
					insertDocLine2.setString(41,"Y");
					insertDocLine2.setString(42,freeze_recx.elementAt(x).toString());
					insertDocLine2.setString(43,rev_historyx.elementAt(x).toString());
					insertDocLine2.setString(44,"");
					//rev_datex.elementAt(x).toString());
					insertDocLine2.setString(45,web_rep_no);
					insertDocLine2.setString(46,reason_codex.elementAt(x).toString());
					insertDocLine2.setString(47,group_ownerx.elementAt(x).toString());
					insertDocLine2.setString(48,dm_completex.elementAt(x).toString());
					insertDocLine2.setString(49,submitted_statex.elementAt(x).toString());
					insertDocLine2.setString(50,"0");
					insertDocLine2.setString(51,subtotal_code.elementAt(x).toString());
					insertDocLine2.setString(52,from_quote_line.elementAt(x).toString());
					insertDocLine2.setString(53,"PASSED");
					insertDocLine2.setString(54,"PASSED");
					insertDocLine2.setString(55,root_id.elementAt(x).toString());
					insertDocLine2.setString(56,"");
					insertDocLine2.setString(57,"");
					insertDocLine2.setString(58,"");
					insertDocLine2.setString(59,"");
					insertDocLine2.setString(60,"");
					int rocount2 = insertDocLine2.executeUpdate();
					insertDocLine2.close();

				}
			}
		}
		catch (java.sql.SQLException e){
		out.println("Problem with ENTERING TO doc_line table EJC FB>");
		out.println("Illegal Operation try again/Report Error"+"<br>");
		myConn.rollback();
		out.println(e.toString());
		return;
		}
	}
}
//out.println(line_counter+"::");
//logger.debug("web order import ::"+orderNo+"::: number of lines::"+line_counter);
myConn.commit();
myConn.setAutoCommit(true);
%>