package com.csgroup.general;

import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;

import org.w3c.dom.*;

import java.io.*;
import java.sql.*;
import java.util.*;


public class ArchitectBean{

	org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String dbSFDCServerName = "";
	String dbSFDCServerPort = "";
	String SFDCDB = "";
	String SFDCDBUsername = "";
	String SFDCDBPassword = "";
	String WEBServerName;

	String query = "";
	String query2 = "";
	String queryback = "";
	String archNo = "";
	String firstName = "";
	String lastName = "";
	String firmAddress = "";
	String firmCity = "";
	String firmState = "";
	String zip = "";
	String tel = "";
	String fax = "";
	String email = "";
	String countryCode = "";

	public String getArchitects(String name,String city,String state){
		String div = "";
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
					this.dbSFDCServerName = "" + getTagValue("dbSFDCServerName",eElement);
					this.dbSFDCServerPort = "" + getTagValue("dbSFDCServerPort",eElement);
					this.SFDCDB = "" + getTagValue("SFDCDB",eElement);
					this.SFDCDBUsername = "" + getTagValue("SFDCDBUsername",eElement);
					this.SFDCDBPassword = "" + getTagValue("SFDCDBPassword",eElement);
				}
			}
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			Element resultList = doc2.createElement("search");
			doc2.appendChild(resultList);

			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			Connection myConn_sfdc = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbSFDCServerName + ":" + dbSFDCServerPort + "/" + SFDCDB,SFDCDBUsername,SFDCDBPassword);
			Statement stmt_sfdc = myConn_sfdc.createStatement();
			stmt_sfdc.executeUpdate("set ANSI_warnings off");

			query = "select TOP 20 a.name,a.city_or_town__c,a.state_province__C,a.country__c,a.fax,phone,a.postal_code_or_zip_code__c from Account a inner join recordtype r on a.recordtypeid=r.id where (type like '%architect%' or type like '%consultant/engineer%') and (r.name='C/S US' or r.name='CS Impact') ";
			if(name != null && name.trim().length() > 0){
				query = query + "and  a.name like '" + name + "%' ";
			}
			if(city != null && city.trim().length() > 0){
				query = query + "and a.city_or_town__c like '" + city + "%' ";
			}
			if(state != null && state.trim().length() > 0){
				query = query + "and a.state_province__c like '" + state + "%' ";
			}
			query = query + "order by a.name ";
			ResultSet rs1 = stmt_sfdc.executeQuery(query);
			if(rs1 != null){
				while(rs1.next()){
					String tempName = rs1.getString(1);
					String tempCity = rs1.getString(2);
					String tempState = rs1.getString(3);
					String tempZip = rs1.getString(7);
					String tempTel = rs1.getString(6);
					String tempFax = rs1.getString(5);
					String tempCountry = rs1.getString(4);
					if(tempName == null){
						tempName = "";
					}
					if(tempCity == null){
						tempCity = "";
					}
					if(tempState == null){
						tempState = "";
					}
					if(tempZip == null){
						tempZip = "";
					}
					if(tempTel == null){
						tempTel = "";
					}
					if(tempFax == null){
						tempFax = "";
					}
					if(tempCountry == null){
						tempCountry = "";
					}
					Element result = doc2.createElement("searchresult");
					resultList.appendChild(result);
					Element a = doc2.createElement("name");
					a.appendChild(doc2.createTextNode(tempName.trim() + "#"));
					result.appendChild(a);
					Element e = doc2.createElement("city");
					e.appendChild(doc2.createTextNode(tempCity.trim() + "#"));
					result.appendChild(e);
					Element tel = doc2.createElement("tel");
					tel.appendChild(doc2.createTextNode(tempTel.trim() + "#"));
					result.appendChild(tel);
					Element fax = doc2.createElement("fax");
					fax.appendChild(doc2.createTextNode(tempFax.trim() + "#"));
					result.appendChild(fax);
					Element b = doc2.createElement("country");
					b.appendChild(doc2.createTextNode(tempCountry.trim() + "#"));
					result.appendChild(b);
					Element c = doc2.createElement("zip");
					c.appendChild(doc2.createTextNode(tempZip.trim() + "#"));
					result.appendChild(c);
					Element d = doc2.createElement("state");
					d.appendChild(doc2.createTextNode(tempState.trim() + "#"));
					result.appendChild(d);

				}
			}
			rs1.close();
			TransformerFactory tFact = TransformerFactory.newInstance();
			Transformer trans = tFact.newTransformer();
			StringWriter writer = new StringWriter();
			StreamResult result = new StreamResult(writer);
			DOMSource source = new DOMSource(doc2);
			trans.transform(source,result);
			div = writer.toString().trim();
			//logger.debug(div);
			myConn_sfdc.close();
		}
		catch(Exception e){
			logger.debug("ArchitectBean.getArchitectDiv");
			logger.debug(e.getMessage());
			logger.debug("ArchitectBean.getArchitectDiv END");
		}
		return div;
	}

	private static String getTagValue(String sTag,Element eElement){
		NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		return nValue.getNodeValue();
	}

}
