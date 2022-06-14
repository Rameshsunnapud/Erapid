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



public class TaxCalc{

	org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String dbServerName = "";
	String dbServerPort = "";
	String erapidDB = "";
	String erapidSysDB = "";
	String erapidDBUsername = "";
	String erapidDBPassword = "";

	String dbUSRepServerName = "";
	String dbUSRepServerPort = "";
	String USRepDB = "";
	String USRepDBUsername = "";
	String USRepDBPassword = "";

	String dbBPCSServerName = "";
	String BPCSDB = "";
	String BPCSDBUsername = "";
	String BPCSDBPassword = "";
	Connection con_bpcs;
	Statement stmt_bpcs;

	String query = "";
	String zipCode = "";
	String taxCode = "";
	String taxExempt = "";
	String taxExemptCode = "";
	String state = "";
	String taxRate = "";
	boolean isTaxState = false;
	boolean isValidZip = false;

	public void setZip(String zip){
		zipCode = zip;
		Connection myConn = null;
		Statement stmt = null;
		Connection myConnRepData = null;
		Statement stmtRepData = null;
		Connection con_bpcs = null;
		Statement stmt_bpcs = null;
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
					dbUSRepServerPort = "" + getTagValue("dbUSRepServerPort",eElement);
					dbUSRepServerName = "" + getTagValue("dbUSRepServerName",eElement);
					USRepDB = "" + getTagValue("USRepDB",eElement);
					USRepDBUsername = "" + getTagValue("USRepDBUsername",eElement);
					USRepDBPassword = "" + getTagValue("USRepDBPassword",eElement);
					dbBPCSServerName = "" + getTagValue("dbBPCSServerName",eElement);
					BPCSDB = "" + getTagValue("BPCSDB",eElement);
					BPCSDBUsername = "" + getTagValue("BPCSDBUsername",eElement);
					BPCSDBPassword = "" + getTagValue("BPCSDBPassword",eElement);
				}
			}
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			//Class.forName("com.newatlanta.jturbo.driver.Driver");
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			myConnRepData = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbUSRepServerName + ":" + dbUSRepServerPort + "/" + USRepDB,USRepDBUsername,USRepDBPassword);
			//= DriverManager.getConnection("jdbc:JTurbo://" + dbUSRepServerName + ":" + dbUSRepServerPort + "/" + USRepDB + "/sql70=true/sp=false",USRepDBUsername,USRepDBPassword);
			stmtRepData = myConnRepData.createStatement();
			stmtRepData.executeUpdate("set ANSI_warnings off");
			DriverManager.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
			con_bpcs = DriverManager.getConnection("jdbc:as400://" + dbBPCSServerName + "/" + BPCSDB + ";naming=sql;errors=full",BPCSDBUsername,"logiasrv");
			stmt_bpcs = con_bpcs.createStatement();
			query = "select taxcode,taxpercentage,taxexemptcode,stateabbrev from tax_rep2 where zip='" + zipCode + "'";
			int taxperccount = 0;
			ResultSet rs1 = stmtRepData.executeQuery(query);
			if(rs1 != null){
				while(rs1.next()){
					taxCode = rs1.getString("taxcode");
					taxExemptCode = rs1.getString("taxexemptcode");
					state = rs1.getString("stateabbrev");
					taxperccount++;
					isValidZip = true;
				}
			}
			rs1.close();
			//logger.debug("1");
			ResultSet rstaxstate = stmtRepData.executeQuery("select count(*) from cs_freight_tax_state where state='" + state + "'");
			if(rstaxstate != null){
				while(rstaxstate.next()){
					if(rstaxstate.getInt(1) > 0){
						isTaxState = true;
					}
				}
			}
			rstaxstate.close();
			//logger.debug("2");
			if(taxperccount <= 0){
				zipCode = "";
				taxCode = "";
				taxExemptCode = "";
				taxExempt = "";
				state = "";
				isTaxState = false;
				taxRate = "0";
				isValidZip = false;
			}
			else{
				String tax_code_temp = "'";
				double temp_tax_perc = 0;

				ResultSet rsbpcs = stmt_bpcs.executeQuery("select RTRC01,RTRC02,RTRC03,RTRC04,RTRC05,RTRC06,RTRC07,RTRC08,RTRC09,RTRC10 from ZRT where RTICDE='PROD' and RTCVCD='" + taxCode + "'");
				if(rsbpcs != null){
					while(rsbpcs.next()){
						for(int v = 1;v <= 10;v++){
							if(rsbpcs.getString(v) != null && rsbpcs.getString(v).trim().length() > 0){
								tax_code_temp = tax_code_temp + rsbpcs.getString(v) + "','";
							}
						}
					}
				}
				rsbpcs.close();
				if(tax_code_temp.trim().length() > 1){
					tax_code_temp = tax_code_temp.substring(0,tax_code_temp.length() - 2);
					ResultSet rsbpcs2 = stmt_bpcs.executeQuery("select RCCRTE from ZRC where RCRTCD in (" + tax_code_temp + ")");
					if(rsbpcs2 != null){
						while(rsbpcs2.next()){
							if(rsbpcs2.getString(1) != null && rsbpcs2.getString(1).trim().length() > 0){
								temp_tax_perc = temp_tax_perc + new Double(rsbpcs2.getString(1)).doubleValue();
							}
						}
					}
					rsbpcs2.close();
					taxRate = "" + temp_tax_perc;
				}
				else{
					zipCode = "";
					taxCode = "";
					taxExemptCode = "";
					taxExempt = "";
					state = "";
					isTaxState = false;
					isValidZip = false;
					taxRate = "0";
				}
			}
		}
		catch(Exception e){
			logger.debug("TaxCal.setZip");
			logger.debug(e.getMessage());
			logger.debug("TaxCal.setZip END");
		}
		finally{
			try{
				stmt.close();
				myConn.close();
				myConnRepData.close();
				stmtRepData.close();
				con_bpcs.close();
				stmt_bpcs.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
	}

	public String getZip(){
		return zipCode;
	}

	public String getTaxRate(){
		return taxRate;
	}

	public boolean getIsValidZip(){
		return isValidZip;
	}

	public boolean getIsTaxState(){
		return isTaxState;
	}

	public String getTaxValue(String value,String zip){
		String result = "";
		try{
			setZip(zip);
			if(taxRate == null || taxRate.trim().length() == 0 || taxExempt.equals("Y")){
				taxRate = "0";
			}
			logger.debug("line 202::" + taxRate + "::" + value);
			if(value.trim().length() > 0){
				result = "" + (new Double(value).doubleValue() * (new Double(taxRate).doubleValue() / 100));
			}
			else{
				result = "0";
			}
			//logger.debug("line 209::" + result);
		}
		catch(Exception e){
			result = "0";
			logger.debug("TaxCalc.taxValue");
			logger.debug(e.getMessage());
			logger.debug("TaxCalc.taxValue END");
		}
		return result;
	}

	public String getTotalTaxValue(String orderNo){
		String result = "";
		String tempZip = "";

		String overage = "0";
		String handling = "0";
		String freight = "0";
		String setup = "0";
		String product = "";
		String projectType = "";
		boolean isOverageFreight = false;
		boolean isHandlingFreight = false;
		boolean isFreightFreight = false;
		boolean isSetupFreight = false;
		double lineTotal = 0;
		double orderTotal = 0;
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
					dbUSRepServerPort = "" + getTagValue("dbUSRepServerPort",eElement);
					dbUSRepServerName = "" + getTagValue("dbUSRepServerName",eElement);
					USRepDB = "" + getTagValue("USRepDB",eElement);
					USRepDBUsername = "" + getTagValue("USRepDBUsername",eElement);
					USRepDBPassword = "" + getTagValue("USRepDBPassword",eElement);
					dbBPCSServerName = "" + getTagValue("dbBPCSServerName",eElement);
					BPCSDB = "" + getTagValue("BPCSDB",eElement);
					BPCSDBUsername = "" + getTagValue("BPCSDBUsername",eElement);
					BPCSDBPassword = "" + getTagValue("BPCSDBPassword",eElement);
				}
			}
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			query = "select tax_zip,tax_code,tax_exempt,setup_cost,freight_cost,handling_cost,overage,product_id,project_type,configured_price from cs_project where order_no='" + orderNo + "'";

			ResultSet rs1 = stmt.executeQuery(query);
			if(rs1 != null){
				while(rs1.next()){
					tempZip = rs1.getString("tax_zip");
					taxExempt = rs1.getString("tax_exempt");
					product = rs1.getString("product_id");
					if(rs1.getString("setup_cost") != null && rs1.getString("setup_cost").trim().length() > 0 && !rs1.getString("setup_cost").toLowerCase().equals("null")){
						setup = rs1.getString("setup_cost");
					}
					if(rs1.getString("handling_cost") != null && rs1.getString("handling_cost").trim().length() > 0 && !rs1.getString("handling_cost").toLowerCase().equals("null")){
						handling = rs1.getString("handling_cost");
					}
					if(rs1.getString("freight_cost") != null && rs1.getString("freight_cost").trim().length() > 0 && !rs1.getString("freight_cost").toLowerCase().equals("null")){
						freight = rs1.getString("freight_cost");
					}
					if(rs1.getString("overage") != null && rs1.getString("overage").trim().length() > 0 && !rs1.getString("overage").toLowerCase().equals("null")){
						overage = rs1.getString("overage");
					}
					projectType = rs1.getString("project_type");
					if(product.equals("LVR") || product.equals("GRILLE")){
						lineTotal = rs1.getDouble("configured_price");
					}
				}
			}
			rs1.close();
			setZip(tempZip);
			if(taxRate == null || taxRate.trim().length() == 0 || taxExempt.equals("Y")){
				taxRate = "0";
				taxCode = taxExemptCode;
			}

			String quer1 = "";
			quer1 = "UPDATE cs_PROJECT SET tax_perc =?,tax_code=? where order_no=?";
			java.sql.PreparedStatement ps = myConn.prepareStatement(quer1);
			ps.setString(1,taxRate);
			ps.setString(2,taxCode);
			ps.setString(3,orderNo);
			int re = ps.executeUpdate();
			if(!(product.equals("LVR") || product.equals("GRILLE"))){
				query = "select extended_price from csquotes where order_no = '" + orderNo + "' and not extended_price is null and not extended_price='' and cast(extended_price as float)>0  AND (NOT EXISTS (SELECT NULL AS Expr1 FROM cs_no_tax_parts WHERE (part_no = CSQUOTES.field18)))";
				ResultSet rs2 = stmt.executeQuery(query);
				if(rs2 != null){
					while(rs2.next()){
						lineTotal = lineTotal + rs2.getDouble(1);
					}
				}
				rs2.close();
			}
			query = "select charge from cs_price_calc_charges_control where not isFreight is null and isFreight='y' and product_id='" + product + "'";
			ResultSet rs3 = stmt.executeQuery(query);
			if(rs3 != null){
				while(rs3.next()){
					if(rs3.getString("charge") != null && rs3.getString("charge").equals("overage")){
						isOverageFreight = true;
					}
					else if(rs3.getString("charge") != null && rs3.getString("charge").equals("setup")){
						isSetupFreight = true;
					}
					else if(rs3.getString("charge") != null && rs3.getString("charge").equals("handling")){
						isHandlingFreight = true;
					}
					else if(rs3.getString("charge") != null && rs3.getString("charge").equals("freight")){
						isFreightFreight = true;
					}

				}
			}
			rs3.close();
			if(setup == null || setup.trim().length() == 0 || (isSetupFreight && !isTaxState)){
				setup = "0";
			}
			if(handling == null || handling.trim().length() == 0 || (isHandlingFreight && !isTaxState)){
				handling = "0";
			}
			if(freight == null || freight.trim().length() == 0 || (isFreightFreight && !isTaxState)){
				freight = "0";
			}
			if(overage == null || overage.trim().length() == 0 || (isOverageFreight && !isTaxState)){
				overage = "0";
			}
			int numDec = 0;
			//logger.debug(product + "::" + projectType);
			if(projectType == null || projectType.equals("null")){
				projectType = "";
			}
			//logger.debug("select numDecimals from cs_rounding where product_id='" + product + "' and project_type='" + projectType + "'");
			ResultSet rsRounding = stmt.executeQuery("select numDecimals from cs_rounding where product_id='" + product + "' and project_type='" + projectType + "'");
			if(rsRounding != null){
				while(rsRounding.next()){
					numDec = rsRounding.getInt(1);
				}
			}
			rsRounding.close();
			DecimalFormat df = new DecimalFormat("####.##");
			df.setMaximumFractionDigits(numDec);
			df.setMinimumFractionDigits(numDec);
			orderTotal = new Double(df.format(lineTotal)).doubleValue() + new Double(setup).doubleValue() + new Double(handling).doubleValue() + new Double(freight).doubleValue() + new Double(overage).doubleValue();
			//logger.debug(orderTotal + ":: order total" + orderNo + "::" + numDec + "::: line 360");
			result = getTaxValue("" + orderTotal,zipCode);
			/*
			 ""+(orderTotal*(new Double(taxRate).doubleValue()/100));
			 if(value.trim().length()>0){
			 result=""+(new Double(value).doubleValue()*(new Double(taxRate).doubleValue()/100));
			 }
			 else{
			 result="0";
			 }
			 */
		}
		catch(Exception e){
			result = "0";
			logger.debug("TaxCalc.taxValue");
			logger.debug(e.getMessage());
			logger.debug("TaxCalc.taxValue END");
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

	public String getTotalTaxValueXML(String orderNo){
		String resultXML = "";
		//String value = getTotalTaxValue(orderNo);
		//logger.debug(getTotalTaxValue(orderNo));
		//logger.debug(getZip());
		//logger.debug(getTaxRate());
		//logger.debug(getIsValidZip());
		try{
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			String orderNoTemp = orderNo.trim();
			Element resultList = doc2.createElement("tax");
			doc2.appendChild(resultList);
			Element result = doc2.createElement("values");
			resultList.appendChild(result);
			Element orderNox = doc2.createElement("orderNo");
			orderNox.appendChild(doc2.createTextNode(orderNoTemp));
			result.appendChild(orderNox);
			Element taxTotal = doc2.createElement("taxTotal");
			taxTotal.appendChild(doc2.createTextNode(getTotalTaxValue(orderNo)));
			result.appendChild(taxTotal);
			Element taxZip = doc2.createElement("taxZip");
			taxZip.appendChild(doc2.createTextNode(getZip()));
			result.appendChild(taxZip);
			Element taxRate = doc2.createElement("taxRate");
			taxRate.appendChild(doc2.createTextNode(getTaxRate()));
			result.appendChild(taxRate);
			Element taxIsValidZip = doc2.createElement("taxIsValidZip");
			taxIsValidZip.appendChild(doc2.createTextNode("" + getIsValidZip()));
			result.appendChild(taxIsValidZip);
			Element taxIsTaxState = doc2.createElement("taxIsTaxState");
			taxIsTaxState.appendChild(doc2.createTextNode("" + getIsTaxState()));
			result.appendChild(taxIsTaxState);
			TransformerFactory tFact = TransformerFactory.newInstance();
			Transformer trans = tFact.newTransformer();
			StringWriter writer = new StringWriter();
			StreamResult resultx = new StreamResult(writer);
			DOMSource source = new DOMSource(doc2);
			trans.transform(source,resultx);
			resultXML = writer.toString().trim();
		}
		catch(Exception e){
			logger.debug("TaxCalc.getTotalTaxValueXML");
			logger.debug(e.getMessage());
			logger.debug("TaxCalc.getTotalTaxValueXML END");
		}
		return resultXML;
	}

	public String getSecTotalTaxValue(String orderNo,String secNo){
		String result = "";

		return result;
	}

	private static String getTagValue(String sTag,Element eElement){
		NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		return nValue.getNodeValue();
	}
}
