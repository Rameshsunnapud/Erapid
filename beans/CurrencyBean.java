package com.csgroup.general;

import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;
import org.w3c.dom.*;

import java.io.*;
import java.sql.*;
import java.util.*;


public class CurrencyBean{

	org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String serverName;
	String fullServerName;
	String dbServerName = "";
	String dbServerPort = "";
	String erapidDB = "";
	String erapidSysDB = "";
	String erapidDBUsername = "";
	String erapidDBPassword = "";
	String dbBPCSServerName = "";
	String BPCSDB = "";
	String BPCSUSRDB = "";
	String BPCSDBUsername = "";
	String BPCSDBPassword = "";

	String query = "";
	String exchName = "";
	String exchRate = "";
	String exchRateDate = "";

	private static String getTagValue(String sTag,Element eElement){
		NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		return nValue.getNodeValue();
	}

	public String getCurrency(String countryTo,String countryFrom){
		String div = "";
		//logger.debug(countryTo + "<-- to :: from-->" + countryFrom);
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
					this.serverName = "" + getTagValue("serverName",eElement);
					this.fullServerName = "" + getTagValue("fullServerName",eElement);
					this.dbServerName = "" + getTagValue("dbServerName",eElement);
					this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
					this.erapidDB = "" + getTagValue("erapidDB",eElement);
					this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
					this.dbBPCSServerName = "" + getTagValue("dbBPCSServerName",eElement);
					this.BPCSDB = "" + getTagValue("BPCSDB",eElement);
					this.BPCSUSRDB = "" + getTagValue("BPCSUSRDB",eElement);
					this.BPCSDBUsername = "" + getTagValue("BPCSDBUsername",eElement);
					this.BPCSDBPassword = "" + getTagValue("BPCSDBPassword",eElement);
				}
			}
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			Element resultList = doc2.createElement("search");
			doc2.appendChild(resultList);
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			DriverManager.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
			Connection con_bpcs = DriverManager.getConnection("jdbc:as400://" + dbBPCSServerName + "/" + BPCSDB + ";naming=sql;errors=full",BPCSDBUsername,BPCSDBPassword);
			Statement stmt_bpcs = con_bpcs.createStatement();
			query = "select CCNVFC,CCNVDT,CCTOCR,CCFRCR from GCC where CCFRCR='" + countryFrom + "' and CCTOCR='" + countryTo + "' order by CCNVDT";
			ResultSet rs1 = stmt_bpcs.executeQuery(query);
			if(rs1 != null){
				while(rs1.next()){
					//logger.debug(rs1.getString(1) + "::" + rs1.getString(2) + "::" + rs1.getString(3) + "::" + rs1.getString(4) + "::");
					exchName = rs1.getString(3);
					exchRate = rs1.getString(1);
					exchRateDate = rs1.getString(2);

					Element result = doc2.createElement("searchresult");
					resultList.appendChild(result);
					Element a = doc2.createElement("exchName");
					a.appendChild(doc2.createTextNode(rs1.getString(3) + "#"));
					result.appendChild(a);
					Element b = doc2.createElement("exchRate");
					b.appendChild(doc2.createTextNode(rs1.getString(1) + "#"));
					result.appendChild(b);
					Element c = doc2.createElement("exchRateDate");
					c.appendChild(doc2.createTextNode(rs1.getString(2) + "#"));
					result.appendChild(c);
				}
			}
			rs1.close();
			//result = exchName + "::" + exchRate + "::" + exchRateDate;
			TransformerFactory tFact = TransformerFactory.newInstance();
			Transformer trans = tFact.newTransformer();
			StringWriter writer = new StringWriter();
			StreamResult result = new StreamResult(writer);
			DOMSource source = new DOMSource(doc2);
			trans.transform(source,result);
			div = writer.toString().trim();

		}
		catch(Exception e){
			logger.debug("CurrencyBean.getCurrency");
			logger.debug(query);
			logger.debug(e.getMessage());
			logger.debug("CurrencyBean.getCurrency END");
		}
		return div;

	}

	public String getCurrencyByRepNo(String custNo){
		String to = "";
		String from = "USD";
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
			Connection myConn1;
			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			String query = "select country from cs_customers where cust_no_text='" + custNo + "'";
			ResultSet rs1 = stmt.executeQuery(query);
			if(rs1 != null){
				while(rs1.next()){
					to = rs1.getString(1);
				}
			}
			rs1.close();
			if(to == null){
				to = "";
			}
			//logger.debug(to + "::1::" + custNo);
			if(to.equals("CA") || to.equals("CANADA")){
				to = "CAD";
			}
			else{
				to = "USD";
			}
			//logger.debug(to + "::2");
			result = getCurrency(to,from);

		}
		catch(Exception e){
			logger.debug("CurrencyBean.getCurrencyByRepNo");
			logger.debug(e.getMessage());
			logger.debug("CurrencyBean.getCurrencyByRepNo END");

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

	public boolean checkExchange(String orderNo){
		boolean isGood = true;
		String query = "";
		Connection con_bpcs = null;
		Statement stmt_bpcs = null;
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
					this.serverName = "" + getTagValue("serverName",eElement);
					this.fullServerName = "" + getTagValue("fullServerName",eElement);
					this.dbServerName = "" + getTagValue("dbServerName",eElement);
					this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
					this.erapidDB = "" + getTagValue("erapidDB",eElement);
					this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
					this.dbBPCSServerName = "" + getTagValue("dbBPCSServerName",eElement);
					this.BPCSDB = "" + getTagValue("BPCSDB",eElement);
					this.BPCSUSRDB = "" + getTagValue("BPCSUSRDB",eElement);
					this.BPCSDBUsername = "" + getTagValue("BPCSDBUsername",eElement);
					this.BPCSDBPassword = "" + getTagValue("BPCSDBPassword",eElement);

				}
			}
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			Element resultList = doc2.createElement("search");
			doc2.appendChild(resultList);
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			DriverManager.registerDriver(new com.ibm.as400.access.AS400JDBCDriver());
			con_bpcs = DriverManager.getConnection("jdbc:as400://" + dbBPCSServerName + "/" + BPCSDB + ";naming=sql;errors=full",BPCSDBUsername,BPCSDBPassword);
			stmt_bpcs = con_bpcs.createStatement();
			Class.forName("net.sourceforge.jtds.jdbc.Driver");

			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");

			//java.sql.Date today = new java.sql.Date();
		}
		catch(Exception e){
			logger.debug("ValidationBean.checkExchange");
			logger.debug(e.getMessage());
			logger.debug("ValidationBean.checkExchange END");
		}
		finally{
			try{
				stmt.close();
				myConn.close();
				stmt_bpcs.close();
				con_bpcs.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
		return isGood;
	}

	public void updateExchange(String orderNo,String type){
		if(type.equals("CA") || type.equals("CANADA") || type.equals("CAD")){
			type = "CAD";
		}
		else{
			type = "USD";
		}
		//logger.debug(orderNo + "::" + type);
		getCurrency(type,"USD");
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
			java.sql.PreparedStatement updateCsProject = myConn.prepareStatement("UPDATE cs_project set exch_name=?,exch_rate=?,exch_rate_date=? WHERE order_no= ?");
			updateCsProject.setString(1,exchName);
			updateCsProject.setString(2,exchRate);
			updateCsProject.setString(3,exchRateDate);
			updateCsProject.setString(4,orderNo);
			int rocount = updateCsProject.executeUpdate();
			updateCsProject.close();

		}
		catch(Exception e){
			logger.debug("CurrencyBean.updateExchange");
			logger.debug(e.getMessage());
			logger.debug("CurrencyBean.updateExchange END");
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

}
