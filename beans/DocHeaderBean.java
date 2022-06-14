package com.csgroup.general;

import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;
import org.w3c.dom.*;
import java.io.*;
import java.sql.*;
import java.util.*;


public class DocHeaderBean{

	org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String dbServerName = "";
	String dbServerPort = "";
	String erapidDB = "";
	String erapidSysDB = "";
	String erapidDBUsername = "";
	String erapidDBPassword = "";

	String query = "";

	String orderNo = "";
	String docType = "";
	String docRevision = "";
	String expiresDate = "";
	String docDate = "";
	String entryDate = "";
	String dueDate = "";
	String promiseDate = "";
	String docStatus = "";
	String docCustomer = "";
	String docSalesPerson = "";
	String docPriority = "";
	String poDate = "";
	String ecStatus = "";
	String winLoss = "";
	String winLossDesc = "";
	String shipDate = "";

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
			query = "select * from doc_header where doc_number='" + orderNo + "'";
			ResultSet rs1 = stmt.executeQuery(query);
			if(rs1 != null){
				while(rs1.next()){
					orderNo = rs1.getString("doc_number");
					docType = rs1.getString("doc_type");
					docRevision = rs1.getString("doc_revision");
					docStatus = rs1.getString("doc_status");
					docCustomer = rs1.getString("doc_customer");
					docSalesPerson = rs1.getString("doc_salesperson");
					docPriority = rs1.getString("doc_priority");
					poDate = rs1.getString("po_date");
					ecStatus = rs1.getString("ec_status");
					winLoss = rs1.getString("win_loss");
					winLossDesc = rs1.getString("win_loss_desc");
					shipDate = rs1.getString("ship_date");

					expiresDate = rs1.getString("expires_date");
					docDate = rs1.getString("doc_date");
					entryDate = rs1.getString("entry_date");
					dueDate = rs1.getString("due_date");
					promiseDate = rs1.getString("promise_date");
				}
			}
			rs1.close();
			stmt.close();
			myConn.close();

			if(expiresDate != null && expiresDate.trim().length() > 10){
				expiresDate = expiresDate.substring(0,10);
			}
			if(docDate != null && docDate.trim().length() > 10){
				docDate = docDate.substring(0,10);
			}
			if(entryDate != null && entryDate.trim().length() > 10){
				entryDate = entryDate.substring(0,10);
			}
			if(dueDate != null && dueDate.trim().length() > 10){
				dueDate = dueDate.substring(0,10);
			}
			if(promiseDate != null && promiseDate.trim().length() > 10){
				promiseDate = promiseDate.substring(0,10);
			}
			if(shipDate != null && shipDate.trim().length() > 10){
				shipDate = shipDate.substring(0,10);
			}
		}
		catch(Exception e){
			logger.debug(" DogHeaderBean.setOrderNo");
			logger.debug(e.getMessage());
			logger.debug(" DogHeaderBean.setOrderNo END");
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

	public String getOrderNo(){
		return orderNo;
	}

	public String getDocType(){
		return docType;
	}

	public String getDocRevision(){
		return docRevision;
	}

	public String getExpiresDate(){
		return expiresDate;
	}

	public String getDocDate(){
		return docDate;
	}

	public String getEntryDate(){
		return entryDate;
	}

	public String getDueDate(){
		return dueDate;
	}

	public String getPromiseDate(){
		return promiseDate;
	}

	public String getDocStatus(){
		return docStatus;
	}

	public String getDocCustomer(){
		return docCustomer;
	}

	public String getDocSalesPerson(){
		return docSalesPerson;
	}

	public String getDocPriority(){
		return docPriority;
	}

	public String getPoDate(){
		return poDate;
	}

	public String getEcStatus(){
		return ecStatus;
	}

	public String getWinLoss(){
		return winLoss;
	}

	public String getWinLossDesc(){
		return winLossDesc;
	}

	public String getShipDate(){
		return shipDate;
	}

	private static String getTagValue(String sTag,Element eElement){
		NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		return nValue.getNodeValue();
	}
}
