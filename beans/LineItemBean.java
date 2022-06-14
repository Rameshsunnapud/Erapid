package com.csgroup.general;

import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;
import org.w3c.dom.*;
import java.io.*;
import java.sql.*;
import java.util.*;
import java.text.*;



public class LineItemBean{

	org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String dbServerName = "";
	String dbServerPort = "";
	String erapidDB = "";
	String erapidSysDB = "";
	String erapidDBUsername = "";
	String erapidDBPassword = "";

	String query = "";
	String orderNox = "";
	int installCount = 0;
	Vector orderNo = new Vector();
	Vector status = new Vector();
	Vector lineNo = new Vector();
	Vector orderType = new Vector();
	Vector productId = new Vector();
	Vector description = new Vector();
	Vector extendedPrice = new Vector();
	Vector recordNo = new Vector();
	Vector blockId = new Vector();
	Vector sequenceNo = new Vector();
	Vector uom = new Vector();
	Vector sqm = new Vector();
	Vector qty = new Vector();
	Vector sqmp = new Vector();
	Vector weight = new Vector();
	Vector field16 = new Vector();
	Vector field17 = new Vector();
	Vector field18 = new Vector();
	Vector field19 = new Vector();
	Vector field20 = new Vector();
	Vector runCost = new Vector();
	Vector stdCost = new Vector();
	Vector setupCost = new Vector();
	Vector priceFlag = new Vector();
	Vector lgth = new Vector();
	Vector wdth = new Vector();
	Vector color = new Vector();
	Vector stock = new Vector();
	Vector prodCode = new Vector();
	Vector deduct = new Vector();

	Vector priceBand = new Vector();
	Vector quoteDescript = new Vector();

	public void clear(){
		orderNo.removeAllElements();
		status.removeAllElements();
		lineNo.removeAllElements();
		orderType.removeAllElements();
		productId.removeAllElements();
		description.removeAllElements();
		extendedPrice.removeAllElements();
		recordNo.removeAllElements();
		blockId.removeAllElements();
		sequenceNo.removeAllElements();
		uom.removeAllElements();
		sqm.removeAllElements();
		qty.removeAllElements();
		sqmp.removeAllElements();
		weight.removeAllElements();
		field16.removeAllElements();
		field17.removeAllElements();
		field18.removeAllElements();
		field19.removeAllElements();
		field20.removeAllElements();
		runCost.removeAllElements();
		stdCost.removeAllElements();
		setupCost.removeAllElements();
		priceFlag.removeAllElements();
		lgth.removeAllElements();
		wdth.removeAllElements();
		color.removeAllElements();
		stock.removeAllElements();
		prodCode.removeAllElements();
		priceBand.removeAllElements();
		quoteDescript.removeAllElements();
		deduct.removeAllElements();
	}

	public void setOrderNo(String x){
		clear();
		Connection myConn = null;
		Statement stmt = null;
		this.orderNox = x;
		try{
			DecimalFormat df2 = new DecimalFormat("####.##");
			df2.setMaximumFractionDigits(2);
			df2.setMinimumFractionDigits(2);
			File fXmlFile = new File("d:\\erapid\\erapid.xml");
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("instance");
			for(int temp = 0;temp < nList.getLength();temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					Element eElement = (Element) nNode;
					dbServerPort = "" + getTagValue("dbServerPort",eElement);
					dbServerName = "" + getTagValue("dbServerName",eElement);
					erapidDB = "" + getTagValue("erapidDB",eElement);
					erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
				}
			}
			Class.forName("net.sourceforge.jtds.jdbc.Driver");

			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			String tempProductId = "";
			boolean isNotAA = false;
			ResultSet rsPid = stmt.executeQuery("select product_id from cs_project where order_no='" + orderNox + "'");
			if(rsPid != null){
				while(rsPid.next()){
					tempProductId = rsPid.getString(1);
				}
			}
			rsPid.close();
			ResultSet rsNoAA = stmt.executeQuery("select product_id from products where not product_id like 'inc%' and not product_id like 'sys%' and not product_id in (select product_id from price_block where (block_code='a_aproduct' or block_code='descriptions'))");
			if(rsNoAA != null){
				while(rsNoAA.next()){
					if(rsNoAA.getString(1).equals(tempProductId)){
						isNotAA = true;
					}
				}
			}
			rsNoAA.close();
			if(orderNox != null && orderNox.trim().length() > 0){
				if(isNotAA){
					query = "SELECT a.doc_number as a, a.ec_status as b,a.doc_line as c,b.order_type as d,a.product_id as e,b.descript as f,b.extended_price as g,b.record_no as h,b.block_id as i,b.sequence_no as j,b.uom as k,b.sqm as l,b.qty as m,b.sqmp as n,b.weight as o,b.field16 as p,b.field17 as q,b.field18 as r,b.field19 as s,b.field20 as t,b.run_cost as u,b.std_cost as v,b.setup_cost as w,b.price_flag as x,b.lgth as y,b.wdth as z,b.color as aa,b.stock as bb,b.prod_code as cc,b.deduct as dd FROM doc_line a with (nolock) left join CSQUOTES b with (nolock) on a.doc_number=b.Order_no and a.doc_line=b.line_no where a.doc_number='" + orderNox + "'   order by cast(a.doc_line as numeric)";
				}
				else{
					query = "SELECT a.doc_number as a, a.ec_status as b,a.doc_line as c,b.order_type as d,a.product_id as e,b.descript as f,b.extended_price as g,b.record_no as h,b.block_id as i,b.sequence_no as j,b.uom as k,b.sqm as l,b.qty as m,b.sqmp as n,b.weight as o,b.field16 as p,b.field17 as q,b.field18 as r,b.field19 as s,b.field20 as t,b.run_cost as u,b.std_cost as v,b.setup_cost as w,b.price_flag as x,b.lgth as y,b.wdth as z,b.color as aa,b.stock as bb,b.prod_code as cc,b.deduct as dd FROM doc_line a with (nolock) left join CSQUOTES b with (nolock) on a.doc_number=b.Order_no and a.doc_line=b.line_no and b.Block_ID in ('a_aproduct','descriptions') where a.doc_number='" + orderNox + "'  order by cast(a.doc_line as numeric)";
				}
				ResultSet rs1 = stmt.executeQuery(query);
				//logger.debug(query);
				String tempLineNo = "";
				if(orderNox != null && orderNox.trim().length() > 0){
					if(rs1 != null){
						while(rs1.next()){
							orderNo.addElement(rs1.getString("a"));
							status.addElement(rs1.getString("b"));
							lineNo.addElement(rs1.getString("c"));
							orderType.addElement(rs1.getString("d"));
							productId.addElement(rs1.getString("e"));
							if(rs1.getString("e") != null && (rs1.getString("e").equals("WALLGLAZE_PL") || rs1.getString("e").equals("EFS_PL"))){
								//logger.debug("R");
								description.addElement(rs1.getString("r"));
							}
							else{
								//logger.debug("F::"+rs1.getString("f")+"::");
								description.addElement(rs1.getString("f"));
							}
							extendedPrice.addElement(rs1.getString("g"));
							recordNo.addElement(rs1.getString("h"));
							blockId.addElement(rs1.getString("i"));
							sequenceNo.addElement(rs1.getString("j"));
							uom.addElement(rs1.getString("k"));
							if(rs1.getString("l") != null){
								sqm.addElement(rs1.getString("l"));
							}
							else{
								sqm.addElement("");
							}
							qty.addElement(rs1.getString("m"));
							if(rs1.getString("n") != null){
								sqmp.addElement(rs1.getString("n"));
							}
							else{
								sqmp.addElement("");
							}

							weight.addElement(rs1.getString("o"));
							field16.addElement(rs1.getString("p"));
							field17.addElement(rs1.getString("q"));
							field18.addElement(rs1.getString("r"));
							field19.addElement(rs1.getString("s"));
							field20.addElement(rs1.getString("t"));
							runCost.addElement(rs1.getString("u"));
							stdCost.addElement(rs1.getString("v"));
							setupCost.addElement(rs1.getString("w"));
							priceFlag.addElement(rs1.getString("x"));
							lgth.addElement(rs1.getString("y"));
							wdth.addElement(rs1.getString("z"));
							color.addElement(rs1.getString("aa"));
							stock.addElement(rs1.getString("bb"));
							prodCode.addElement(rs1.getString("cc"));
							if(rs1.getString("dd") != null){
								deduct.addElement(rs1.getString("dd"));
							}
							else{
								deduct.addElement("");
							}
						}
					}
					rs1.close();
					for(int i = 0;i < lineNo.size();i++){
						query = "select sum(cast (extended_price as float)) from csquotes where order_no='" + orderNo.elementAt(i).toString() + "' and line_no='" + lineNo.elementAt(i).toString() + "' and not extended_price is null and not extended_price=''";
						ResultSet rs2 = stmt.executeQuery(query);
						if(rs2 != null){
							while(rs2.next()){
								double tempPrice = 0;
								if(rs2.getString(1) != null && rs2.getString(1).trim().length() > 0){
									tempPrice = new Double(rs2.getString(1)).doubleValue();
								}
								extendedPrice.setElementAt(df2.format(tempPrice),i);
							}
						}
						rs2.close();
					}

					ResultSet rsInstall = stmt.executeQuery("select count(*) from csquotes where order_no like '" + orderNox.trim() + "' and field18 ='INSTALLATION'");
					if(rsInstall != null){
						while(rsInstall.next()){
							this.installCount = rsInstall.getInt(1);

						}
					}
					rsInstall.close();
				}
			}

			//query=tempLineNo;
		}
		catch(Exception e){
			logger.debug("LineItemBean.setOrderNo");
			logger.debug(e.getMessage());
			logger.debug("LineItemBean.setOrderNo end");
			query = query + "::" + e;
		}
		finally{
			try{
				stmt.close();
				myConn.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
	}

	public int getInstallCount(){
		return installCount;
	}

	public String getQuery(){
		return query;
	}

	public String[] getOrderNo(){
		int counter = orderNo.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(orderNo.elementAt(i) != null){
				repReturn[i] = orderNo.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getLineNo(){
		int counter = lineNo.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(lineNo.elementAt(i) != null){
				repReturn[i] = lineNo.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getOrderType(){
		int counter = orderType.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(orderType.elementAt(i) != null){
				repReturn[i] = orderType.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getProductId(){
		int counter = productId.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(productId.elementAt(i) != null){
				repReturn[i] = productId.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getDescription(){
		int counter = description.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(description.elementAt(i) != null){
				repReturn[i] = description.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getExtendedPrice(){
		int counter = extendedPrice.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(extendedPrice.elementAt(i) != null){
				repReturn[i] = extendedPrice.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getRecordNo(){
		int counter = recordNo.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(recordNo.elementAt(i) != null){
				repReturn[i] = recordNo.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getBlockId(){
		int counter = blockId.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(blockId.elementAt(i) != null){
				repReturn[i] = blockId.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getSequenceNo(){
		int counter = sequenceNo.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(sequenceNo.elementAt(i) != null){
				repReturn[i] = sequenceNo.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getUom(){
		int counter = uom.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(uom.elementAt(i) != null){
				repReturn[i] = uom.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getSqm(){
		int counter = sqm.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(sqm.elementAt(i) != null){
				repReturn[i] = sqm.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getQty(){
		int counter = qty.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(qty.elementAt(i) != null){
				repReturn[i] = qty.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getSqmp(){
		int counter = sqmp.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(sqmp.elementAt(i) != null){
				repReturn[i] = sqmp.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getWeight(){
		int counter = weight.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(weight.elementAt(i) != null){
				repReturn[i] = weight.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getField16(){
		int counter = field16.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(field16.elementAt(i) != null){
				repReturn[i] = field16.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getField17(){
		int counter = field17.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(field17.elementAt(i) != null){
				repReturn[i] = field17.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getField18(){
		int counter = field18.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(field18.elementAt(i) != null){
				repReturn[i] = field18.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getField19(){
		int counter = field19.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(field19.elementAt(i) != null){
				repReturn[i] = field19.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getField20(){
		int counter = field20.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(field20.elementAt(i) != null){
				repReturn[i] = field20.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getRunCost(){
		int counter = runCost.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(runCost.elementAt(i) != null){
				repReturn[i] = runCost.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getStdCost(){
		int counter = stdCost.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(stdCost.elementAt(i) != null){
				repReturn[i] = stdCost.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getSetupCost(){
		int counter = setupCost.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(setupCost.elementAt(i) != null){
				repReturn[i] = setupCost.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getPriceFlag(){
		int counter = priceFlag.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(priceFlag.elementAt(i) != null){
				repReturn[i] = priceFlag.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getLgth(){
		int counter = lgth.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(lgth.elementAt(i) != null){
				repReturn[i] = lgth.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getWdth(){
		int counter = wdth.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(wdth.elementAt(i) != null){
				repReturn[i] = wdth.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getColor(){
		int counter = color.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(color.elementAt(i) != null){
				repReturn[i] = color.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getStock(){
		int counter = stock.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(stock.elementAt(i) != null){
				repReturn[i] = stock.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getProdCode(){
		int counter = prodCode.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(prodCode.elementAt(i) != null){
				repReturn[i] = prodCode.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String[] getStatus(){
		int counter = status.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			if(status.elementAt(i) != null){
				repReturn[i] = status.elementAt(i).toString();
			}
			else{
				repReturn[i] = "";
			}
		}
		return repReturn;
	}

	public String getXml(String x){
		this.setOrderNo(x);
		String div = "";
		try{
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			Element searchresultx = doc2.createElement("lineItemList");
			doc2.appendChild(searchresultx);
			for(int i = 0;i < orderNo.size();i++){
				Element searchresult = doc2.createElement("lineItem");
				searchresultx.appendChild(searchresult);
				String tempOrderNo = orderNo.elementAt(i).toString();
				if(tempOrderNo == null){
					tempOrderNo = "";
				}
				Element orderNoElement = doc2.createElement("orderNo");
				orderNoElement.appendChild(doc2.createTextNode(tempOrderNo + "#"));
				searchresult.appendChild(orderNoElement);
				String tempStatus = status.elementAt(i).toString();
				if(tempStatus == null){
					tempStatus = "";
				}
				Element statusElement = doc2.createElement("status");
				statusElement.appendChild(doc2.createTextNode(tempStatus + "#"));
				searchresult.appendChild(statusElement);
				String tempLineNo = lineNo.elementAt(i).toString();
				if(tempLineNo == null){
					tempLineNo = "";
				}
				Element lineNoElement = doc2.createElement("lineNo");
				lineNoElement.appendChild(doc2.createTextNode(tempLineNo + "#"));
				searchresult.appendChild(lineNoElement);
				String tempProductId = "";
				if(productId.elementAt(i) != null){
					tempProductId = productId.elementAt(i).toString();
				}
				Element productIdElement = doc2.createElement("productId");
				productIdElement.appendChild(doc2.createTextNode(tempProductId + "#"));
				searchresult.appendChild(productIdElement);
				String tempDescription = "";
				if(description.elementAt(i) != null){
					tempDescription = description.elementAt(i).toString();
				}
				Element descriptionElement = doc2.createElement("description");
				descriptionElement.appendChild(doc2.createTextNode(tempDescription + "#"));
				searchresult.appendChild(descriptionElement);
				String tempExtendedPrice = "";
				if(extendedPrice.elementAt(i) != null){
					tempExtendedPrice = extendedPrice.elementAt(i).toString();
				}
				Element extendedPriceElement = doc2.createElement("extendedPrice");
				extendedPriceElement.appendChild(doc2.createTextNode(tempExtendedPrice + "#"));
				searchresult.appendChild(extendedPriceElement);
				String tempUom = "";
				if(uom.elementAt(i) != null){
					tempUom = uom.elementAt(i).toString();
				}
				Element uomElement = doc2.createElement("uom");
				uomElement.appendChild(doc2.createTextNode(tempUom + "#"));
				searchresult.appendChild(uomElement);
				String tempQty = "";
				if(qty.elementAt(i) != null){
					tempQty = qty.elementAt(i).toString();
				}
				Element qtyElement = doc2.createElement("qty");
				qtyElement.appendChild(doc2.createTextNode(tempQty + "#"));
				searchresult.appendChild(qtyElement);

				String tempField19 = "";
				if(field19.elementAt(i) != null){
					tempField19 = field19.elementAt(i).toString();
				}
				Element field19Element = doc2.createElement("field19");
				field19Element.appendChild(doc2.createTextNode(tempField19 + "#"));
				searchresult.appendChild(field19Element);

				String tempfield18 = "";
				if(field18.elementAt(i) != null){
					tempfield18 = field18.elementAt(i).toString();
				}
				Element field18Element = doc2.createElement("field18");
				field18Element.appendChild(doc2.createTextNode(tempfield18 + "#"));
				searchresult.appendChild(field18Element);
				String tempField17 = "";
				if(field17.elementAt(i) != null){
					tempField17 = field17.elementAt(i).toString();
				}
				Element field17Element = doc2.createElement("field17");
				field17Element.appendChild(doc2.createTextNode(tempField17 + "#"));
				searchresult.appendChild(field17Element);
				String tempWdth = "";
				if(wdth.elementAt(i) != null){
					tempWdth = wdth.elementAt(i).toString();
				}
				Element wdthElement = doc2.createElement("wdth");
				wdthElement.appendChild(doc2.createTextNode(tempWdth + "#"));
				searchresult.appendChild(wdthElement);
				String tempLgth = "";
				if(lgth.elementAt(i) != null){
					tempLgth = lgth.elementAt(i).toString();
				}
				Element lgthElement = doc2.createElement("lgth");
				lgthElement.appendChild(doc2.createTextNode(tempLgth + "#"));
				searchresult.appendChild(lgthElement);

				String tempSqmp = sqmp.elementAt(i).toString();
				if(tempSqmp == null){
					tempSqmp = "";
				}
				Element sqmpElement = doc2.createElement("sqmp");
				sqmpElement.appendChild(doc2.createTextNode(tempSqmp + "#"));
				searchresult.appendChild(sqmpElement);
				String tempSqm = sqm.elementAt(i).toString();
				if(tempSqm == null){
					tempSqm = "";
				}
				Element sqmElement = doc2.createElement("sqm");
				sqmElement.appendChild(doc2.createTextNode(tempSqm + "#"));
				searchresult.appendChild(sqmElement);

				String tempDeduct = deduct.elementAt(i).toString();
				if(tempDeduct == null){
					tempDeduct = "";
				}
				Element deductElement = doc2.createElement("deduct");
				deductElement.appendChild(doc2.createTextNode(tempDeduct + "#"));
				searchresult.appendChild(deductElement);

			}
			TransformerFactory tFact = TransformerFactory.newInstance();
			Transformer trans = tFact.newTransformer();
			StringWriter writer = new StringWriter();
			StreamResult result = new StreamResult(writer);
			DOMSource source = new DOMSource(doc2);
			trans.transform(source,result);
			div = writer.toString().trim();
		}
		catch(Exception e){
			//div=" ";
			logger.debug(" LineItemBean.getxml");
			logger.debug(e.getMessage());
			logger.debug(div);
			logger.debug(" LineItemBean.getxml END");
		}
		return div;
	}

	public String deleteLines(String orderNox,String linesDelete,String productDelete,String countryDelete){
		String result = "done";
		Connection myConn = null;
		Statement stmt = null;
		//logger.debug("delete " + orderNox + "::" + linesDelete + "::" + productDelete + "::" + countryDelete);
		try{
			File fXmlFile = new File("d:\\erapid\\erapid.xml");
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("instance");
			for(int temp = 0;temp < nList.getLength();temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					Element eElement = (Element) nNode;
					dbServerPort = "" + getTagValue("dbServerPort",eElement);
					dbServerName = "" + getTagValue("dbServerName",eElement);
					erapidDB = "" + getTagValue("erapidDB",eElement);
					erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
				}

			}
			Class.forName("net.sourceforge.jtds.jdbc.Driver");

			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			query = "select * from cs_copy_dm where product_id in('" + productDelete + "','*') and country in ('" + countryDelete + "','*') and not line_no_col is null ";
			ResultSet rsDm = stmt.executeQuery(query);
			Vector tableNames = new Vector();
			Vector orderNoCols = new Vector();
			Vector lineNoCols = new Vector();
			if(rsDm != null){
				while(rsDm.next()){
					tableNames.addElement(rsDm.getString("table_name"));
					orderNoCols.addElement(rsDm.getString("order_no_col"));
					lineNoCols.addElement(rsDm.getString("line_no_col"));
					//logger.debug(rsDm.getString("table_name") + "::" + rsDm.getString("order_no_col") + "::" + rsDm.getString("line_no_col"));
				}
			}
			rsDm.close();

			for(int i = 0;i < tableNames.size();i++){

				linesDelete = linesDelete.replaceAll("##","','");

				linesDelete = linesDelete.replaceAll("#","'");

				String deleteQuery = "delete from " + tableNames.elementAt(i).toString() + " where " + orderNoCols.elementAt(i).toString() + " = '" + orderNox + "' and " + lineNoCols.elementAt(i).toString() + " in (" + linesDelete + ")";

				int rocount = stmt.executeUpdate(deleteQuery);

			}

		}
		catch(Exception e){
			result = "FAILED" + e;
			logger.debug("LineItemBean.deleteLines");
			logger.debug(e.getMessage());
			logger.debug("LineItemBean.deleteLines end");

		}
		finally{
			try{
				stmt.close();
				myConn.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
		return result;
	}

	public void setAddDeduct(String orderNo,String lineNo,String addDeduct){
		Connection myConn = null;
		Statement stmt = null;
		try{
			File fXmlFile = new File("d:\\erapid\\erapid.xml");
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("instance");
			for(int temp = 0;temp < nList.getLength();temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					Element eElement = (Element) nNode;
					dbServerPort = "" + getTagValue("dbServerPort",eElement);
					dbServerName = "" + getTagValue("dbServerName",eElement);
					erapidDB = "" + getTagValue("erapidDB",eElement);
					erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
				}

			}
			Class.forName("net.sourceforge.jtds.jdbc.Driver");

			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			//logger.debug("UPDATE csquotes set deduct=? where order_no=? and line=?" + addDeduct + "::" + orderNo + "::" + lineNo);
			java.sql.PreparedStatement updateCSQUOTES = myConn.prepareStatement("UPDATE csquotes set deduct=? where order_no=? and line_no=?");
			updateCSQUOTES.setString(1,addDeduct);
			updateCSQUOTES.setString(2,orderNo);
			updateCSQUOTES.setString(3,lineNo);
			int rocount = updateCSQUOTES.executeUpdate();
			updateCSQUOTES.close();

		}
		catch(Exception e){
			logger.debug("LineItemBean.setAddDeduct");
			logger.debug(e.getMessage());
			logger.debug("LineItemBean.setAddDeduct end");

		}
		finally{
			try{
				stmt.close();
				myConn.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
	}

	private static String getTagValue(String sTag,Element eElement){
		NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		return nValue.getNodeValue();
	}
}
