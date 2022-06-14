package com.csgroup.general;

import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;
import org.w3c.dom.*;
import java.io.*;
import java.sql.*;
import java.util.*;


public class SectionBean{

	org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String dbServerName = "";
	String dbServerPort = "";
	String erapidDB = "";
	String erapidSysDB = "";
	String erapidDBUsername = "";
	String erapidDBPassword = "";

	String query = "";
	String orderNo = "";

	public String getSectionNotes(String orderNo,String sectionNo){
		String div = "";
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
			String tempExc = "";
			String tempQlf = "";
			String tempFree = "";
			ResultSet rs1 = stmt.executeQuery("select section_qual,section_excl,section_notes from cs_quote_sectiosn where order_no='" + orderNo + "'");
			if(rs1 != null){
				while(rs1.next()){
					if(rs1.getString("section_qual") != null){
						tempQlf = rs1.getString("section_qual");
					}
					if(rs1.getString("section_excl") != null){
						tempExc = rs1.getString("section_excl");
					}
					if(rs1.getString("section_notes") != null){
						tempFree = rs1.getString("section_notes");
					}
				}
			}
			rs1.close();

		}
		catch(Exception e){
			logger.debug(" SectionBean.getSectionNotes");
			logger.debug(e.getMessage());
			logger.debug(" SectionBean.getSeectionNotes END");
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
		return div;
	}

	public boolean checkSections(String orderNo){
		boolean isGood = true;
		return isGood;
	}

	private static String getTagValue(String sTag,Element eElement){
		NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		return nValue.getNodeValue();
	}
}
