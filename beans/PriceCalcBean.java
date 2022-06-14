package com.csgroup.general;

import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;

import java.math.*;
import java.text.*;
import org.w3c.dom.*;

import java.io.*;
import java.sql.*;
import java.util.*;



public class PriceCalcBean{

	org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");

	String dbServerName = "";
	String dbServerPort = "";
	String erapidDB = "";
	String erapidSysDB = "";
	String erapidDBUsername = "";
	String erapidDBPassword = "";

	String query = "";
	String orderNo = "";
	String productId = "";
	double totalCost = 0;
	double totalTax = 0;
	double total = 0;
	double weightEst = 0;
	String distance = "0";
	String transport = "0";
	double installDistance = 0;
	double installDiscount = 0;
	double taxPerc = 0;
	String transCost = "0";
	String vat = "0";
	double installSheet = 0;
	double installProfile = 0;
	double installCrew = 0;
	double installPrice = 0;
	String setupCost = "";
	String overage = "";
	String handlingCost = "";
	String freightCost = "";
	String assignedRepNo = "";
	String currency = "";
	String carriageType = "";
	String internalNotes = "";
	String xChange = "0";
	String curSym = "";
	String curName = "";
	String taxZip = "";
	String taxExempt = "";
	String freightOverride = "";
	String commission = "";
	String isCustomColorChargeAdded="no";
	double customColorCharges=0.0;

	boolean isException = false;
	boolean isOverageShow = false;
	double overageMax = 0;

	public void setOrderNo(String x){
		this.orderNo = x;
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
			String query = "select extended_price,weight,qty,field20,product_id,deduct from csquotes where order_no='" + orderNo + "'";
			ResultSet rs1 = stmt.executeQuery(query);
			totalCost = 0;
			totalTax = 0;
			//logger.debug(totalCost +":: total cost1");
			if(rs1 != null){
				while(rs1.next()){
					if(rs1.getString("extended_price") != null && rs1.getString("extended_price").trim().length() > 0){
						String deduct = rs1.getString("deduct");
						if(deduct == null){
							deduct = "";
						}
						if(deduct.toUpperCase().equals("DEDUCT")){
							totalCost = totalCost - rs1.getDouble("extended_price");
						}
						else{
							totalCost = totalCost + rs1.getDouble("extended_price");
						}
						//logger.debug("PRICE CALCBEAN LINE 97:::" + rs1.getString("extended_Price"));
					}
				}
			}
			rs1.close();
			total = totalCost;
			//logger.debug(totalCost +":: total cost2");

			try{
				query = "select product_id, carriage_charge,freight_city,setup_cost,assigned_rep_no,creator_id,currency,carriage_type,internal_notes,overage,handling_cost,freight_cost,tax_zip,tax_exempt,handling_override,commission,configured_price from cs_project where order_no='" + orderNo + "'";
				//logger.debug(query);
				ResultSet rs2 = stmt.executeQuery(query);
				if(rs2 != null){
					while(rs2.next()){
						productId = rs2.getString("product_id");
						if(productId.equals("LVR") || productId.equals("GRILLE")){
							totalCost = rs2.getDouble("configured_price");
							total = totalCost;
						}
						if(rs2.getString("freight_city") != null && rs2.getString("freight_city").trim().length() > 0){
							distance = rs2.getString("freight_city");
						}
						if(rs2.getString("carriage_charge") != null && rs2.getString("carriage_charge").trim().length() > 0){
							transport = rs2.getString("carriage_charge");
						}
						if(rs2.getString("setup_cost") != null && rs2.getString("setup_cost").trim().length() > 0){
							setupCost = rs2.getString("setup_cost");
						}
						if(rs2.getString("overage") != null && rs2.getString("overage").trim().length() > 0){
							overage = rs2.getString("overage");
						}
						if(rs2.getString("handling_cost") != null && rs2.getString("handling_cost").trim().length() > 0){
							handlingCost = rs2.getString("handling_cost");
						}
						if(rs2.getString("freight_cost") != null && rs2.getString("freight_cost").trim().length() > 0){
							freightCost = rs2.getString("freight_cost");
						}
						if(rs2.getString("assigned_rep_no") != null && rs2.getString("assigned_rep_no").trim().length() > 0){
							assignedRepNo = rs2.getString("assigned_rep_no");
						}
						else{
							assignedRepNo = rs2.getString("creator_id");
						}
						if(rs2.getString("currency") != null && rs2.getString("currency").trim().length() > 0){
							currency = rs2.getString("currency");
						}
						if(rs2.getString("carriage_type") != null && rs2.getString("carriage_type").trim().length() > 0){
							carriageType = rs2.getString("carriage_type");
						}
						if(rs2.getString("internal_notes") != null && rs2.getString("internal_notes").trim().length() > 0){
							internalNotes = rs2.getString("internal_notes");
						}
						if(rs2.getString("tax_zip") != null && rs2.getString("tax_zip").trim().length() > 0){
							taxZip = rs2.getString("tax_zip");
						}
						if(rs2.getString("tax_exempt") != null && rs2.getString("tax_exempt").trim().length() > 0){
							taxExempt = rs2.getString("tax_exempt");
						}
						if(rs2.getString("handling_override") != null && rs2.getString("handling_override").trim().length() > 0){
							freightOverride = rs2.getString("handling_override");
						}
						if(rs2.getString("commission") != null && rs2.getString("commission").trim().length() > 0){
							commission = rs2.getString("commission");
						}
					}
				}
				rs2.close();
				if(productId.equals("ADS")){
					ResultSet rsADSCalc = stmt.executeQuery("select lineprice from cs_ads_price_calc where order_no ='" + orderNo + "' and model='global'");
					if(rsADSCalc != null){
						while(rsADSCalc.next()){
							totalCost = rsADSCalc.getDouble(1);
						}
					}
					rsADSCalc.close();
					total = totalCost;
				}
				if(setupCost == null || setupCost.trim().length() == 0){
					//setupCost = "0";
				}
				if(overage == null || overage.trim().length() == 0){
					//overage = "0";
				}
				if(handlingCost == null || handlingCost.trim().length() == 0){
					//handlingCost = "0";
				}
				if(freightCost == null || freightCost.trim().length() == 0){
					//freightCost = "0";
				}
				if(transport == null || transport.trim().length() == 0){
					//transport = "0";
				}
				double tempSetupCost = 0;
				if(setupCost != null && setupCost.trim().length() > 0){
					tempSetupCost = new Double(setupCost).doubleValue();
				}
				double tempOverage = 0;
				if(overage != null && overage.trim().length() > 0){
					tempOverage = new Double(overage).doubleValue();
				}
				double tempHandlingCost = 0;
				if(handlingCost != null && handlingCost.trim().length() > 0){
					tempHandlingCost = new Double(handlingCost).doubleValue();
				}
				double tempFreightCost = 0;
				if(freightCost != null && freightCost.trim().length() > 0){
					tempFreightCost = new Double(freightCost).doubleValue();
				}
				total = total + tempSetupCost + tempFreightCost + tempFreightCost + tempHandlingCost + tempOverage;
				//stmt.close();
				myConn.close();
			}
			catch(Exception e){
				logger.debug("PriceCalcBean");
				logger.debug("getValues() RS2");
				logger.debug(e.getMessage());
				logger.debug("PriceCalcBean END");
			}
		}
		catch(Exception e){
			logger.debug("PriceCalcBean");
			logger.debug("getValues() RS1");
			logger.debug(e.getMessage());
			logger.debug("PriceCalcBean END");
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

	public String getCheckBoxes(String checkProduct,String group,String projectType){
		String result = "";
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
			Vector file_names = new Vector();
			Vector doc_names = new Vector();
			//logger.debug("select doc_name,file_name from cs_email_files where product_id in ('*','" + checkProduct + "') and group_id in('*','" + group + "') and project_type in ('*','" + projectType + "') and not not_group_id like '%" + group + "%' order by doc_number");
			ResultSet rsFiles = stmt.executeQuery("select doc_name,file_name from cs_email_files where product_id in ('*','" + checkProduct + "') and group_id in('*','" + group + "') and project_type in ('*','" + projectType + "') and not not_group_id like '%" + group + "%' order by doc_number");
			if(rsFiles != null){
				while(rsFiles.next()){
					doc_names.addElement(rsFiles.getString(1));
					file_names.addElement(rsFiles.getString(2));
				}
			}
			rsFiles.close();
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			Element resultList = doc2.createElement("checkboxes");
			doc2.appendChild(resultList);
			Element checkboxes = doc2.createElement("values");
			resultList.appendChild(checkboxes);
			for(int i = 0;i < file_names.size();i++){
				Element doc_name = doc2.createElement("doc_name");
				String tempDocName = doc_names.elementAt(i).toString();
				if(tempDocName == null){
					tempDocName = "";
				}
				tempDocName = tempDocName + "#";
				doc_name.appendChild(doc2.createTextNode(tempDocName));
				checkboxes.appendChild(doc_name);
				Element file_name = doc2.createElement("file_name");
				String tempFileName = file_names.elementAt(i).toString();
				if(tempFileName == null){
					tempFileName = "";
				}
				tempFileName = tempFileName + "#";
				file_name.appendChild(doc2.createTextNode(tempFileName));
				checkboxes.appendChild(file_name);
			}
			TransformerFactory tFact = TransformerFactory.newInstance();
			Transformer trans = tFact.newTransformer();
			StringWriter writer = new StringWriter();
			StreamResult resultx = new StreamResult(writer);
			DOMSource source = new DOMSource(doc2);
			trans.transform(source,resultx);
			result = writer.toString().trim();
			//stmt.close();
			myConn.close();
		}
		catch(Exception e){
			logger.debug("pricecalcbean.getcheckboxes");
			logger.debug(e.getMessage());
			logger.debug("pricecalcbean.getcheckboxes end");
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

	public String getPriceCalc(String userId,String group){
		//logger.debug("PriceCalcBean.getPriceCalc line 266");
		String html = "";
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
			setOrderNo(orderNo);
			String productId = "";
			String projectType = "";
			int numDecimals = 2;
			query = "select project_type,product_id from cs_project where order_no='" + orderNo.trim() + "'";
			ResultSet rs1 = stmt.executeQuery(query);
			if(rs1 != null){
				while(rs1.next()){
					productId = rs1.getString("product_id");
					projectType = rs1.getString("project_type");
				}
			}
			rs1.close();
			if(projectType == null || projectType.equals("null") || projectType.trim().length() == 0){
				projectType = "";
			}
			query = "select numDecimals from cs_rounding where product_id='" + productId + "' and group_id in ('" + group + "','*') and user_id in ('" + userId + "','*') and project_type='" + projectType + "'";
			ResultSet rs2 = stmt.executeQuery(query);
			if(rs2 != null){
				while(rs2.next()){
					numDecimals = rs2.getInt(1);
				}
			}
			rs2.close();
			overageRules(orderNo);
			if(!isOverageShow){
				overage = "0";
			}
			DecimalFormat for12 = new DecimalFormat("#.##");
			for12.setMaximumFractionDigits(2);
			for12.setMinimumFractionDigits(2);
			DecimalFormat f0 = new DecimalFormat("#.##");
			f0.setMaximumFractionDigits(numDecimals);
			f0.setMinimumFractionDigits(numDecimals);
			//logger.debug(totalCost + "::" + commission + "::price calc bean 334");
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			String orderNoTemp = orderNo.trim();
			String productIdTemp = productId.trim();
			Element resultList = doc2.createElement("priceCalc");
			doc2.appendChild(resultList);
			Element result = doc2.createElement("values");
			resultList.appendChild(result);
			Element orderNox = doc2.createElement("orderNo");
			orderNox.appendChild(doc2.createTextNode(orderNoTemp));
			result.appendChild(orderNox);
			Element productIdx = doc2.createElement("productId");
			productIdx.appendChild(doc2.createTextNode(productIdTemp));
			result.appendChild(productIdx);
			Element totalCostx = doc2.createElement("totalCost");
			totalCostx.appendChild(doc2.createTextNode("" + f0.format(totalCost)));
			result.appendChild(totalCostx);
			Element totalTaxx = doc2.createElement("totalTax");
			totalTaxx.appendChild(doc2.createTextNode("" + for12.format(totalTax)));
			result.appendChild(totalTaxx);
			Element totalx = doc2.createElement("total");
			totalx.appendChild(doc2.createTextNode("" + for12.format(total)));
			result.appendChild(totalx);
			Element weightEstx = doc2.createElement("weightEst");
			weightEstx.appendChild(doc2.createTextNode("" + weightEst));
			result.appendChild(weightEstx);
			Element distancex = doc2.createElement("distance");
			distancex.appendChild(doc2.createTextNode(distance));
			result.appendChild(distancex);
			Element transportx = doc2.createElement("transport");
			if(transport != null && transport.trim().length() > 0){
				transport = "" + for12.format(new Double(transport).doubleValue());
			}
			transportx.appendChild(doc2.createTextNode(transport));
			result.appendChild(transportx);
			Element installDistancex = doc2.createElement("installDistance");
			installDistancex.appendChild(doc2.createTextNode("" + installDistance));
			result.appendChild(installDistancex);
			Element taxPercx = doc2.createElement("taxPerc");
			taxPercx.appendChild(doc2.createTextNode("" + taxPerc));
			result.appendChild(taxPercx);
			Element transCostx = doc2.createElement("transCost");
			transCostx.appendChild(doc2.createTextNode("" + transCost));
			result.appendChild(transCostx);
			Element vatx = doc2.createElement("vat");
			vatx.appendChild(doc2.createTextNode("" + vat));
			result.appendChild(vatx);
			Element installSheetx = doc2.createElement("installSheet");
			installSheetx.appendChild(doc2.createTextNode("" + installSheet));
			result.appendChild(installSheetx);
			Element installCrewx = doc2.createElement("installCrew");
			installCrewx.appendChild(doc2.createTextNode("" + installCrew));
			result.appendChild(installCrewx);
			Element installProfilex = doc2.createElement("installProfile");
			installProfilex.appendChild(doc2.createTextNode("" + installProfile));
			result.appendChild(installProfilex);
			Element installPricex = doc2.createElement("installPrice");
			installPricex.appendChild(doc2.createTextNode("" + installPrice));
			result.appendChild(installPricex);
			Element setupCostx = doc2.createElement("setupCost");
			if(setupCost != null && setupCost.trim().length() > 0){
				setupCost = "" + for12.format(new Double(setupCost).doubleValue());
			}
			setupCostx.appendChild(doc2.createTextNode("#" + setupCost));
			result.appendChild(setupCostx);
			Element overagex = doc2.createElement("overage");
			if(overage != null && overage.trim().length() > 0){
				overage = "" + for12.format(new Double(overage).doubleValue());
			}
			overagex.appendChild(doc2.createTextNode("#" + overage));
			result.appendChild(overagex);
			Element overageMaxx = doc2.createElement("overageMax");
			overageMaxx.appendChild(doc2.createTextNode("#" + overageMax));
			result.appendChild(overageMaxx);
			Element handlingCostx = doc2.createElement("handlingCost");
			if(handlingCost != null && handlingCost.trim().length() > 0){
				handlingCost = "" + for12.format(new Double(handlingCost).doubleValue());
			}
			handlingCostx.appendChild(doc2.createTextNode("#" + handlingCost));
			result.appendChild(handlingCostx);
			Element freightCostx = doc2.createElement("freightCost");
			if(freightCost != null && freightCost.trim().length() > 0){
				freightCost = "" + for12.format(new Double(freightCost).doubleValue());
			}
			freightCostx.appendChild(doc2.createTextNode("#" + freightCost));
			result.appendChild(freightCostx);
			Element assignedRepNox = doc2.createElement("assignedRepNo");
			assignedRepNox.appendChild(doc2.createTextNode("" + assignedRepNo));
			result.appendChild(assignedRepNox);
			Element currencyx = doc2.createElement("currency");
			currencyx.appendChild(doc2.createTextNode("#" + currency));
			result.appendChild(currencyx);
			Element xChangex = doc2.createElement("xChange");
			xChangex.appendChild(doc2.createTextNode("#" + xChange));
			result.appendChild(xChangex);
			Element curSymx = doc2.createElement("curSym");
			curSymx.appendChild(doc2.createTextNode("#" + curSym));
			result.appendChild(curSymx);
			Element curNamex = doc2.createElement("curName");
			curNamex.appendChild(doc2.createTextNode("#" + curName));
			result.appendChild(curNamex);
			Element carriageTypex = doc2.createElement("carriageType");
			carriageTypex.appendChild(doc2.createTextNode("#" + carriageType));
			result.appendChild(carriageTypex);
			Element internalNotesx = doc2.createElement("internalNotes");
			internalNotesx.appendChild(doc2.createTextNode("#" + internalNotes));
			result.appendChild(internalNotesx);
			Element taxZipx = doc2.createElement("taxZip");
			taxZipx.appendChild(doc2.createTextNode("#" + taxZip));
			result.appendChild(taxZipx);
			Element taxExemptx = doc2.createElement("taxExempt");
			taxExemptx.appendChild(doc2.createTextNode("#" + taxExempt));
			result.appendChild(taxExemptx);
			Element freightOverridex = doc2.createElement("freightOverride");
			freightOverridex.appendChild(doc2.createTextNode("#" + freightOverride));
			result.appendChild(freightOverridex);
			Element commissionx = doc2.createElement("commission");
			commissionx.appendChild(doc2.createTextNode("#" + commission));
			result.appendChild(commissionx);
			TransformerFactory tFact = TransformerFactory.newInstance();
			Transformer trans = tFact.newTransformer();
			StringWriter writer = new StringWriter();
			StreamResult resultx = new StreamResult(writer);
			DOMSource source = new DOMSource(doc2);
			trans.transform(source,resultx);
			html = writer.toString().trim();
			//logger.debug("pricecalcbean 468:::" + html);
			//
			myConn.close();

		}
		catch(Exception e){
			logger.debug("PriceCalcBean.getPriceCalc()");
			logger.debug(e.getMessage());
			logger.debug("PriceCalcBean.getPriceCalc() END");
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
		//logger.debug("price calc bean line 398::" + html);
		return html;
	}

	public String savePriceCalc(String orderNo,String totalCost,String totalTax,String total,String weightEst,String weight,String distance,String transport,double installDistance,double installDiscount,String overage,String handlingCost,String freightCost,String setupCost,String currency,String assignedRepNo,String carriageType,String internalNotes,String shipZip,String taxExempt,String freightOverride,String userId,String group,String commission){
		String div = "";
		//logger.debug("savePriceCalc::<BR>");
		//logger.debug(installDistance+":: install distance");
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
			if(orderNo.trim().length() > 0){
				try{
					installSheet = 0;
					installProfile = 0;
					installCrew = 0;
					installPrice = 0;
					int installCount = 0;
					ResultSet rsInstall = stmt.executeQuery("select count(*) from csquotes where order_no like '" + orderNo + "' and field18 ='INSTALLATION'");
					if(rsInstall != null){
						while(rsInstall.next()){
							installCount = rsInstall.getInt(1);
						}
					}
					rsInstall.close();
					if(installCount > 0){
						installPrice = installDistance * 1.6;
						ResultSet rsInstallSum = stmt.executeQuery("Select weight from csquotes where order_no='" + orderNo + "' and not (field18='INSTALLATION') AND weight is not null AND NOT Weight = ''");
						if(rsInstallSum != null){
							while(rsInstallSum.next()){
								if(rsInstallSum.getString(1) != null && rsInstallSum.getString(1).trim().length() > 0){
									installPrice = installPrice + rsInstallSum.getDouble(1);
								}
							}
						}
						rsInstallSum.close();
						installPrice = installPrice * (100 - installDiscount) / 100;

					}
					transCost = "0";
					vat = "0";
					if(setupCost == null || setupCost.trim().length() == 0){
						setupCost = "0";
					}
					if(overage == null || overage.trim().length() == 0){
						overage = "0";
					}
					if(handlingCost == null || handlingCost.trim().length() == 0){
						handlingCost = "0";
					}
					if(freightCost == null || freightCost.trim().length() == 0){
						freightCost = "0";
					}
					if(commission == null || commission.trim().length() == 0){
						commission = null;
					}
					String quer1 = "";
					if(shipZip == null || shipZip.trim().length() <= 0){
						quer1 = "UPDATE cs_PROJECT SET overage =?,handling_cost =?,freight_cost =?,configured_price =?, setup_cost=?,tax_zip=?,tax_exempt=?,handling_override=?,tax_code='',commission=? WHERE Order_no =? ";
					}
					else{
						quer1 = "UPDATE cs_PROJECT SET overage =?,handling_cost =?,freight_cost =?,configured_price =?, setup_cost=?,tax_zip=?,tax_exempt=?,handling_override=?,commission=? WHERE Order_no =? ";
					}
					java.sql.PreparedStatement ps = myConn.prepareStatement(quer1);
					ps.setString(1,overage);
					ps.setString(2,handlingCost);
					ps.setString(3,freightCost);
					ps.setString(4,totalCost);
					ps.setString(5,setupCost);

					ps.setString(6,shipZip);
					ps.setString(7,taxExempt);
					ps.setString(8,freightOverride);
					ps.setString(9,commission);
					ps.setString(10,orderNo);
					int re = ps.executeUpdate();
					this.installDistance = installDistance;
					/*
					 java.sql.PreparedStatement ps2 = myConn.prepareStatement("update csquotes set weight=? where order_no=? and field18='INSTALLATION'");
					 ps2.setString(1,"" + installPrice);
					 ps2.setString(2,orderNo);
					 int re2 = ps2.executeUpdate();
					 */

				}
				catch(Exception e){
					logger.debug(" PriceCalcBean.savePriceCalc");
					logger.debug(e.getMessage());
					logger.debug(" PriceCalcBean.savePriceCalc END");
				}

			}
			//logger.debug(setupCost+":: before xml");
			setOrderNo(orderNo);
		}
		catch(Exception e){
			logger.debug("PriceCalcBean.savePriceCalc");
			logger.debug(e.getMessage());
			logger.debug("PriceCalcBean.savePriceCalc END");
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
		return getPriceCalc(userId,group);

	}

	public String extraCharges(String orderNoX,String charge,String productId,String total){
		//logger.debug(charge + ":: charge type & prodcut id is" + productId);
		String div = "";
		String condition = "";
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
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			Element resultList = doc2.createElement("search");
			doc2.appendChild(resultList);

			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);

			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			String quoteOrigin = "";
			String creatorId = "";
			String projectType = "";
			ResultSet rsIsSample = stmt.executeQuery("select quote_origin,creator_id,project_Type from cs_project where order_no='" + orderNoX + "'");
			if(rsIsSample != null){
				while(rsIsSample.next()){
					quoteOrigin = rsIsSample.getString(1);
					creatorId = rsIsSample.getString(2);
					projectType = rsIsSample.getString(3);
				}
			}
			rsIsSample.close();
			if(quoteOrigin == null){
				quoteOrigin = "";
			}
			//**********************************************************
			//INSERT CONDITIONS HERE
			//**********************************************************
			logger.debug(orderNoX + "::"+ charge + "::" + productId + "::" + total);
			if(!(quoteOrigin.equals("sample") || projectType.toUpperCase().equals("WEB"))){
				if((charge.equals("handling") && (productId.equals("IWP") || productId.equals("EFS") || productId.equals("EJC") || productId.equals("ADS")))
						|| (charge.equals("freight") && (productId.equals("EJC")))) {
					//logger.debug("CALC IS LONG::select run_cost from csquotes where order_no='" + orderNoX + "'");
					//for is long
					ResultSet rsx = stmt.executeQuery("select oversize from csquotes where order_no='" + orderNoX + "'");
					if(rsx != null){
						while(rsx.next()){

							if(rsx.getString("oversize") != null && rsx.getString("oversize").toUpperCase().trim().equals("X")){
								condition = "true";
							}
							//logger.debug(rsx.getString("run_cost") + "::" + condition);
						}
					}
					rsx.close();
				}
				//logger.debug(charge + ":: charge type & prodcut id is" + productId);
				if(charge.equals("handling") && productId.equals("GCP")){
					//logger.debug("GCP Freight is long ::select prod_code from csquotes where order_no='" + orderNoX + "'");
					//for is long
					ResultSet rsx = stmt.executeQuery("select prod_code from csquotes where order_no='" + orderNoX + "'");
					if(rsx != null){
						while(rsx.next()){

							if(rsx.getString("prod_code") != null && rsx.getString("prod_code").toUpperCase().trim().equals("X")){
								condition = "true";
							}
							//logger.debug(rsx.getString("prod_code") + "::" + condition);
						}
					}
					rsx.close();
				}
				//logger.debug(charge + "::" + productId + "::" + total + "::END");
				//efs duromat/powdercoat/gridline
				//end efs duromat/powdercoat/gridline
				//**********************************************************
				//END CONDITIONS
				//**********************************************************
				query = "select * from cs_price_calc_charges where product_id='" + productId + "' and charge='" + charge + "' and cast(min as numeric)<='" + total + "' and cast(max as numeric)>'" + total + "'";
				//logger.debug("pricecalcbean.java line 636::" + query);
				//logger.debug(div);
				ResultSet rs1 = stmt.executeQuery(query);
				if(rs1 != null){
					while(rs1.next()){
						if(condition != null && !condition.equals("null") && rs1.getString("condition") != null && !rs1.getString("condition").equals("null") && rs1.getString("condition").equals(condition)){
							div = rs1.getString("extra");
						}
						else{
							div = "" + (new Double(rs1.getString("surcharge")).doubleValue() + new Double(total).doubleValue() * new Double(rs1.getString("multiplier")).doubleValue());
						}
						
					}
				}
				rs1.close();
				
				//Following is the code for automatically adding extra changes
				String query_extc = "select extra from cs_price_calc_charges where product_id='" + productId + "' and charge = 'handling_extra' and condition_name in (select distinct oversize_extra from csquotes where Order_no = '" + orderNoX + "')";
				
				ResultSet rs_extc = stmt.executeQuery(query_extc);
				if(rs_extc != null){
					while(rs_extc.next()){
						logger.debug("Auto add extra charges : " + rs_extc.getString("extra"));
						if (div != null && !div.isEmpty()) {
							div = "" + (new Double(div).doubleValue() + new Double(rs_extc.getString("extra")).doubleValue());
						} else {
							div = "" + (new Double(div).doubleValue());
						}
						logger.debug("Auto add extra charges After : " + div);
					}
				}
				rs_extc.close();
				//End of Auto add Extra charges 
				
				
				//logger.debug(div);
				if(charge.equals("setup") && productId.equals("EFS")){
					//logger.debug("setupEFS line 675 price calc bean");
					//EFS GRIDLINE PRICING
                                        /*
					String gridLine = "";
					double gridPrice = 0;
					ResultSet rsGrid = stmt.executeQuery("Select line_no from csquotes where block_id = 'A_APRODUCT' and descript like 'GRIDLINE%' and Order_no like '" + orderNoX + "%' ");
					if(rsGrid != null){
						while(rsGrid.next()){
							gridLine = gridLine + "," + rsGrid.getString(1);
						}
					}
					rsGrid.close();
					//logger.debug(gridLine + ":: gridline lines");
					if(gridLine.length() > 0){
						gridLine = gridLine.substring(1);
						ResultSet rsGrid2 = stmt.executeQuery("Select bpcs_qty,qty from csquotes where block_id='A_GPRICES' and line_no in (" + gridLine + ") and Order_no like '" + orderNoX + "%' ");
						if(rsGrid2 != null){
							while(rsGrid2.next()){
								gridPrice = gridPrice + ((new Double(rsGrid2.getString(1)).doubleValue()) * 2.5 * (new Double(rsGrid2.getString(2)).doubleValue()));
							}
						}
						rsGrid2.close();
					}
					//logger.debug(gridPrice + "::Select bpcs_qty,qty from csquotes where block_id='A_GPRICES' and line_no in (" + gridLine + ") and Order_no like '" + orderNoX + "%' ");

					if(div != null && div.trim().length() > 0){
						div = "" + (new Double(div).doubleValue() + gridPrice);
					}
					else{
						div = "" + gridPrice;
					}
*/
					//END EFS GRIDLINE PRICING
					//EFS POWDER COATING
					String powder = " ,";
					//logger.debug("a");
					ResultSet myResult4 = stmt.executeQuery("select distinct bpcs_part_no from csquotes where Order_no like '" + orderNoX + "%' and bpcs_part_no like '%p' and bpcs_part_no not like 'gfss%' and bpcs_part_no not like 'gfalang%' and block_id = 'b_frames'");
					if(myResult4 != null){
						while(myResult4.next()){
							powder = powder + myResult4.getString(1) + ",";
							logger.debug(powder + ":: powder");
						}
					}
					myResult4.close();
					//logger.debug("b");
					String sqlPowder = "select distinct bpcs_part_no from csquotes where Order_no like '" + orderNoX + "%' and not block_id like '%_misc%' and bpcs_part_no like '%p%' and bpcs_part_no not like 'gfss%' and bpcs_part_no not like 'gfalang%' and (bpcs_part_no like 'g%' or bpcs_part_no like 'm%' or bpcs_part_no like 't%')";
					//logger.debug(sqlPowder+"::<BR>");
					ResultSet myResult41 = stmt.executeQuery(sqlPowder);
					if(myResult41 != null){
						while(myResult41.next()){
							if(myResult41.getString(1).substring(myResult41.getString(1).length() - 1).equals("P") || (myResult41.getString(1).substring(myResult41.getString(1).length() - 2).startsWith("P") && (myResult41.getString(1).substring(myResult41.getString(1).length() - 1).equals("L") || myResult41.getString(1).substring(myResult41.getString(1).length() - 1).equals("Z"))) || (myResult41.getString(1).substring(myResult41.getString(1).length() - 3).startsWith("P") && (myResult41.getString(1).substring(myResult41.getString(1).length() - 2).equals("ZL") || myResult41.getString(1).substring(myResult41.getString(1).length() - 2).equals("LZ")))){
								powder = powder + myResult41.getString(1) + ",";
								//logger.debug(powder+":: powder");
							}
						}
					}
					myResult41.close();
					//logger.debug("c");
					int start = 0;
					int end = 0;
					int x = 0;
					String powderColor = "";
					String compare = " ";
					double powderCoatingCharge = 0;
					while(end < powder.length() && x < 100 && start > -1){
						start = powder.indexOf(",",start);
						end = powder.indexOf(",",start + 1);
						if(start > 0 && end > start){
							/*
							 this is the new code for powdercoat
							 */
							String tempPowder = powder.substring(start,end);
							if(!tempPowder.endsWith("P")){
								tempPowder = tempPowder.substring(0,tempPowder.indexOf("P") + 1);
							}
							powderColor = powderColor + tempPowder.substring(tempPowder.length() - 2,tempPowder.length() - 1);
						}
						if(end < 0){
							end = powder.length();
						}
						x++;
						start = end;
					}
					for(int i = 0;i < powderColor.length();i++){
						if(i < powderColor.length()){
							if(compare.indexOf(powderColor.substring(i,i + 1)) < 0){
								compare = compare + powderColor.substring(i,i + 1);
							}
						}
					}
					if(compare.trim().length() > 0){
						//powderCoatingCharge=300+150*(compare.trim().length()-1);
						powderCoatingCharge = 200;
					}
					if(div != null && div.trim().length() > 0){
						div = "" + (new Double(div).doubleValue() + powderCoatingCharge);
					}
					else{
						div = "" + powderCoatingCharge;
					}

					//ENDS EFS POWDER COATING
				}
				//HAWAII REP FREIGHT SURCHARGE
				if(charge.equals("freight") && (creatorId.equals("147") || creatorId.equals("351"))){
					double t = 0;
					double freightCost = 0;
					ResultSet myResult1 = stmt.executeQuery("select extended_price from csquotes where Order_no like '" + orderNoX + "%' ");
					if(myResult1 != null){
						while(myResult1.next()){
							t = (t + new BigDecimal(myResult1.getString(1).trim()).doubleValue());
						}
					}
					myResult1.close();
					//if(t <= 300){
					freightCost = t * 0.25;
					/*
					 }
					 else if(t <= 1000){
					 freightCost = t * 0.15;
					 }
					 else{
					 freightCost = t * 0.08;
					 }
					 */
					if(div != null && div.trim().length() > 0){
						div = "" + (new Double(div).doubleValue() + freightCost);
					}
					else{
						div = "" + freightCost;
					}
				}
				//END HAWAII REP FREIGHT SURCHARGE
			}
			
			

				
			
			
			
			Element resulty = doc2.createElement("searchresult");
			resultList.appendChild(resulty);
			Element chargename = doc2.createElement("chargename");
			chargename.appendChild(doc2.createTextNode(charge.trim() + "#"));
			resulty.appendChild(chargename);
			//Element customColor = doc2.createElement("isCustomColorChargeAdded");
			//customColor.appendChild(doc2.createTextNode(isCustomColorChargeAdded.trim() + "#"));
			//searchresult.appendChild(customColor);
			Element chargex = doc2.createElement("chargex");
			chargex.appendChild(doc2.createTextNode(div.trim() + "#"));
			resulty.appendChild(chargex);
			TransformerFactory tFact = TransformerFactory.newInstance();
			Transformer trans = tFact.newTransformer();
			StringWriter writer = new StringWriter();
			StreamResult result = new StreamResult(writer);
			DOMSource source = new DOMSource(doc2);
			trans.transform(source,result);
			div = writer.toString().trim();

		}
		catch(Exception e){
			logger.debug("PriceCaclBean.extraCharges");
			logger.debug(e.getMessage());
			logger.debug("PriceCaclBean.extraCharges END");
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
		logger.debug("PriceCalcBean.extracharges::  charge::"+charge+"  productId::"+productId+"  total::"+total+"  result::"+div);
		return div;

	}
	
	public String labelCharges(String charge,String productId,String group,String condition){
		String result = "";
		Connection myConn = null;
		Statement stmt = null;
		//logger.debug(charge + "::" + productId + "::" + group + "::" + condition);
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
			if(group.toUpperCase().indexOf("REP") >= 0){
				group = "REP";
			}
			if(charge.toUpperCase().equals("OVERAGE")){
				overageRules(orderNo);
				if(isOverageShow){
					query = "select * from cs_price_calc_charges_control where product_id='" + productId.trim() + "' and group_id in ('" + group.trim() + "','*') and condition in ('" + condition.trim() + "','*') and charge='" + charge + "' order by group_id,condition";

					int count = 0;
					ResultSet rs1 = stmt.executeQuery(query);
					if(rs1 != null){
						while(rs1.next()){
							count++;
							result = rs1.getString("label");

						}
					}
					rs1.close();
				}
			}
			else{
				query = "select * from cs_price_calc_charges_control where product_id='" + productId.trim() + "' and group_id in ('" + group.trim() + "','*') and condition in ('" + condition.trim() + "','*') and charge='" + charge + "' order by group_id,condition";

				int count = 0;
				ResultSet rs1 = stmt.executeQuery(query);
				if(rs1 != null){
					while(rs1.next()){
						count++;
						result = rs1.getString("label");

					}
				}
				rs1.close();
			}
			//stmt.close();
			myConn.close();
		}
		catch(Exception e){
			logger.debug("PriceCaclBean.labelCharges");
			logger.debug(e.getMessage());
			logger.debug("PriceCaclBean.labelCharges END");
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

	public String getConditions(String orderNo,String group,String charge,String repNo,String productId){
		String result = "";
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
			if(charge.toUpperCase().equals("OVERAGE") && productId.toUpperCase().equals("IWP")){
				Vector discounts = new Vector();
				ResultSet rs_discount = stmt.executeQuery("Select field19,bpcs_tier from csquotes where order_no like '" + orderNo + "'");
				if(rs_discount != null){
					while(rs_discount.next()){
						String disCount = rs_discount.getString(1);
						discounts.addElement(disCount);
					}
				}
				rs_discount.close();
				String[] reps = {"104","289","116","178","108","324","163","118","164","275","356","366","383","999"};
				boolean applyOverageLimit = false;
				for(int i = 0;i < reps.length;i++){
					if(reps[i].equals(repNo)){
						for(int y = 0;y < discounts.size();y++){
							if(!(discounts.elementAt(y).toString().equals("B") || discounts.elementAt(y).toString().equals("BOOK") || discounts.elementAt(y).toString().equals("0") || discounts.elementAt(y).toString().trim().length() == 0)){
								try{
									if(new Double(discounts.elementAt(y).toString()).doubleValue() > 35){
										result = "disOver";
										y = discounts.size();
									}
								}
								catch(Exception e){
									y = discounts.size();
								}
							}
						}
					}
				}
			}//end overage iwp
			//logger.debug(charge + "::");
			if(charge.toUpperCase().equals("OVERAGE") && productId.toUpperCase().equals("EJC")){
				//logger.debug("Select field19 from csquotes where order_no like '" + orderNo + "'");
				ResultSet rs_discount = stmt.executeQuery("Select field19 from csquotes where order_no like '" + orderNo + "'");
				if(rs_discount != null){
					while(rs_discount.next()){
						String disCount = rs_discount.getString(1);

						if(disCount != null && disCount.trim().length() > 0){
							if(!(disCount.equals("B") || disCount.trim().equals("BOOK") || disCount.trim().equals("0"))){
								result = "disOver";
							}
						}
						//logger.debug(disCount + "::" + result);
					}
				}
			}
			//stmt.close();
			myConn.close();
		}
		catch(Exception e){
			logger.debug("PriceCaclBean.getConditions");
			logger.debug(e.getMessage());
			logger.debug("PriceCaclBean.getCondtions END");
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

	public String getLVRRepPrice(String orderNo,String commission,String product){
		String html = "";
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
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			Element resultList = doc2.createElement("search");
			doc2.appendChild(resultList);
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);

			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			query = "select * from cs_lvr_sp_factor where product_id='" + product + "' and com_percent='" + commission + "' order by cast(com_percent as integer) desc";
			String com_perc = "";
			String sp_factor = "";
			String lcost_factor = "";
			String c_cost = "";
			ResultSet myResult1 = stmt.executeQuery("select (sum(RUN_COST)+sum(SETUP_COST)+sum(STD_COST)) AS C_COST from cs_costing where Order_no like '" + orderNo + "%' ");
			if(myResult1 != null){
				while(myResult1.next()){
					c_cost = myResult1.getString(1);
				}
			}
			myResult1.close();
			ResultSet myResult2 = stmt.executeQuery(query);
			if(myResult2 != null){
				while(myResult2.next()){
					com_perc = myResult2.getString(1);
					sp_factor = myResult2.getString(2);
					lcost_factor = myResult2.getString(3);
				}
			}
			myResult2.close();
			
			
			
						
			//GJM-590 Custom color charges addition for LVR 100dollars.
			logger.debug("Product Id 1222 "+product);
			if(null!= product && !product.isEmpty() && product.equals("LVR")){
				logger.debug("Inside line 1224 "+product);
			String noOfSections="0";
			ResultSet rsSections = stmt.executeQuery("select sections from cs_quote_sections where order_no='" + orderNo + "'");
			if(rsSections != null){
				while(rsSections.next()){
					noOfSections = rsSections.getString("sections");
				}
			}
			rsSections.close();
			if(noOfSections==null)
			{
				noOfSections="0";
			}
			String sel="";
			if(Integer.parseInt(noOfSections)<2){
		sel = "SELECT distinct finish FROM cs_costing WHERE order_no='"+orderNo+ "'";
		System.out.println("Query: "+sel+"<BR>");
		}
		else{
			String sectionLines="";
			sel = "SELECT distinct finish FROM cs_costing WHERE order_no='"+orderNo+ "' and item_no in("+sectionLines+")";
			System.out.println("Query: "+sel+"<BR>");
		}
		
		

		ResultSet rsCustom=stmt.executeQuery(sel );
		if(rsCustom != null){
			while(rsCustom.next()){
				logger.debug("Custom Color code is : "+rsCustom.getString(1));
				if(rsCustom.getString(1).equals("C_BONDED")){
					isCustomColorChargeAdded="yes";
					customColorCharges=customColorCharges+100;
				}
				if(rsCustom.getString(1).equals("VKM00")){
					isCustomColorChargeAdded="yes";
					customColorCharges=customColorCharges+100;
				}
				if(rsCustom.getString(1).equals("CL599")){
					isCustomColorChargeAdded="yes";
					customColorCharges=customColorCharges+100;
				}
				if(rsCustom.getString(1).equals("DC499")){
					isCustomColorChargeAdded="yes";
					customColorCharges=customColorCharges+100;
				}
				if(rsCustom.getString(1).equals("KY599")){
					isCustomColorChargeAdded="yes";
					customColorCharges=customColorCharges+100;
				}
				if(rsCustom.getString(1).equals("MC799")){
					isCustomColorChargeAdded="yes";
					customColorCharges=customColorCharges+100;
				}
				if(rsCustom.getString(1).equals("TX699")){
					isCustomColorChargeAdded="yes";
					customColorCharges=customColorCharges+100;
				}
				if(rsCustom.getString(1).startsWith("PC_CUSTOM")){
					isCustomColorChargeAdded="yes";
					customColorCharges=customColorCharges+100;
				}
                if(rsCustom.getString(1).startsWith("GCL500")){
                    isCustomColorChargeAdded="yes";
					customColorCharges=customColorCharges+100;
                }
                if(rsCustom.getString(1).startsWith("GKY599")){
                    isCustomColorChargeAdded="yes";
					customColorCharges=customColorCharges+100;
                }
                if(rsCustom.getString(1).startsWith("GMC799")){
                    isCustomColorChargeAdded="yes";
					customColorCharges=customColorCharges+100;
                }
                if(rsCustom.getString(1).startsWith("GTX699")){
                    isCustomColorChargeAdded="yes";
					customColorCharges=customColorCharges+100;
                }
                if(rsCustom.getString(1).startsWith("PCCustom_NOAL")){
                     isCustomColorChargeAdded="yes";
					 customColorCharges=customColorCharges+100;
                }
				if(rsCustom.getString(1).equals("FM599")){
					isCustomColorChargeAdded="yes";
					customColorCharges=customColorCharges+100;
				}
				if(rsCustom.getString(1).equals("FM799")){
					isCustomColorChargeAdded="yes";
					customColorCharges=customColorCharges+100;
				}
				if(rsCustom.getString(1).equals("FM699")){
					isCustomColorChargeAdded="yes";
					customColorCharges=customColorCharges+100;
				}
			}
		}
		rsCustom.close();
		
		}
		//End of GJM 590
			
			
			
			
			
			
			
			BigDecimal d1 = new BigDecimal(c_cost);
			double d2 = d1.doubleValue() + new Double(lcost_factor).doubleValue();
			double t = 0;
			t = (d2 / new Double(sp_factor).doubleValue());
logger.debug("PPRICE CALC BEAN::1293" );
			Element resulty = doc2.createElement("searchresult");
			resultList.appendChild(resulty);
			Element chargename = doc2.createElement("price");
			chargename.appendChild(doc2.createTextNode(t + "#"));
			resulty.appendChild(chargename);
			logger.debug("PPRICE CALC BEAN::1299" );
			Element customColor = doc2.createElement("customColor");
			customColor.appendChild(doc2.createTextNode(isCustomColorChargeAdded + "#"));
			resulty.appendChild(customColor);
			Element customColorCharge = doc2.createElement("customColorCharges");
			customColorCharge.appendChild(doc2.createTextNode(customColorCharges + "#"));
			resulty.appendChild(customColorCharge);
			logger.debug("PPRICE CALC BEAN::1304" );
			TransformerFactory tFact = TransformerFactory.newInstance();
			Transformer trans = tFact.newTransformer();
			StringWriter writer = new StringWriter();
			StreamResult result = new StreamResult(writer);
			DOMSource source = new DOMSource(doc2);
			trans.transform(source,result);
			html = writer.toString().trim();
			myConn.close();
		}
		catch(Exception e){
			logger.debug("PriceCalcBean.getLVRRepPrice");
			logger.debug(e.getMessage());
			logger.debug("PriceCalcBean.getLVRRepPrice END");
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
		logger.debug("PPRICE CALC BEAN::" + html);
		return html;

	}

	public void overageRules(String orderNo){
		String result = "";
		Connection myConn = null;
		Statement stmt = null;
		try{
			String creatorId = "";
			String groupType = "REP";
			String productId = "";
			String docPriority = "";
			String exceptionList = "";

			double commDollars = 0;
			double commPerc = 0;
			Vector linePrice = new Vector();
			Vector lineComm = new Vector();
			Vector lineComm2 = new Vector();
			double matCost = 0;
			double matMin = 0;
			double matMax = 0;
			double commMin = 0;
			double commMax = 0;
			double excCommMin = 0;
			double excCommMax = 0;

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
			ResultSet rs1 = stmt.executeQuery("select creator_id,product_id from cs_project where order_no='" + orderNo + "'");
			if(rs1 != null){
				while(rs1.next()){
					creatorId = rs1.getString(1);
					productId = rs1.getString(2);
				}
			}
			rs1.close();
			if(creatorId != null && creatorId.trim().length() > 0 && (productId.equals("EJC") || productId.equals("EFS") || productId.equals("IWP"))){
				//logger.debug("a" + orderNo);
				ResultSet rs2 = stmt.executeQuery("select group_id from cs_reps where rep_no_text='" + creatorId + "'");
				if(rs2 != null){
					while(rs2.next()){
						if(rs2.getString(1).toUpperCase().indexOf("REP") < 0){
							groupType = "FACTORY";
						}
					}
				}
				rs2.close();
				//logger.debug("b");
				//result = result + "::" + groupType + "<BR>";
				ResultSet rs3 = stmt.executeQuery("select extended_price,deduct,field16,wdth,field20 from csquotes where order_no='" + orderNo + "'");
				if(rs3 != null){
					while(rs3.next()){
						if(rs3.getString("extended_price") != null && rs3.getDouble("extended_price") > 0){
							String deduct = rs3.getString("deduct");
							if(deduct == null){
								deduct = "";
							}
							if(deduct.toUpperCase().equals("DEDUCT")){
								matCost = matCost - rs3.getDouble("extended_price");
							}
							else{
								matCost = matCost + rs3.getDouble("extended_price");
							}
							linePrice.addElement(rs3.getString("extended_price"));
							lineComm.addElement(rs3.getString("field16"));
							if(productId.equals("EJC")){
								lineComm2.addElement(rs3.getString("field20"));
							}
							else{
								lineComm2.addElement(rs3.getString("wdth"));
							}
						}
					}
				}
				rs3.close();
				//logger.debug("c");
				ResultSet rs4 = stmt.executeQuery("select doc_priority from doc_header where doc_number='" + orderNo + "'");
				if(rs4 != null){
					while(rs4.next()){
						docPriority = rs4.getString(1);
					}
				}
				rs4.close();
				for(int i = 0;i < lineComm.size();i++){
					commDollars = commDollars + (new Double(linePrice.elementAt(i).toString()).doubleValue() * new Double(lineComm.elementAt(i).toString()).doubleValue());
				}
				if(matCost > 0){
					/*if(docPriority.equals("E")){
						commPerc = commDollars / (matCost);
					}
					else{*/
						commPerc = commDollars / (matCost * .91);
					//}
				}
				DecimalFormat df = new DecimalFormat("#####.##");
				//logger.debug("d" + commPerc + "::" + matCost + ":::" + commDollars);
				//	commPerc = 0;
				//}
				commPerc = commPerc * 100;
				//logger.debug(commPerc + "::<br>");
				commPerc = new Double(df.format(commPerc));
				//logger.debug(commPerc + "::<BR>");
				ResultSet rs5 = stmt.executeQuery("select * from cs_overage_rules where group_type='" + groupType + "' and mat_min < " + matCost + " and (mat_max>=" + matCost + " or mat_max is null) and product_id='" + productId + "'");
				if(rs5 != null){
					while(rs5.next()){
						exceptionList = rs5.getString("exception_list");
						matMin = rs5.getDouble("mat_min");
						matMax = rs5.getDouble("mat_max");
						commMin = rs5.getDouble("comm_min");
						commMax = rs5.getDouble("comm_max");
						excCommMin = rs5.getDouble("exc_comm_min");
						excCommMax = rs5.getDouble("exc_comm_max");
						overageMax = rs5.getDouble("exc_overage_max");
					}
				}
				rs5.close();
				//logger.debug("e");
				if(exceptionList != null && (exceptionList.startsWith(creatorId + ",") || exceptionList.endsWith("," + creatorId) || exceptionList.indexOf("," + creatorId + ",") > 0 || exceptionList.equals("*"))){
					//result = result + " in exception list";
					if(commPerc >= excCommMin && commPerc < excCommMax){
						isException = true;
						isOverageShow = true;
					}
					else{
						overageMax = 0;
					}
				}
				//logger.debug("f");
				if(!isException){
					if(commPerc >= commMin && commPerc <= commMax){
						isOverageShow = true;
						overageMax = 0;
					}
					else{
						overageMax = 0;
					}
				}
				//logger.debug("g");
			}
			else{
				isOverageShow = true;
			}

		}
		catch(Exception e){
			logger.debug("PriceCalcBean.overageRules");
			logger.debug(e.getMessage());
			logger.debug("PriceCalcBean.overageRules END");
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
