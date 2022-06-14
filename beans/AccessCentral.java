package com.csgroup.general;

import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;
import org.w3c.dom.*;
import java.io.*;
import java.sql.*;
import java.util.*;


public class AccessCentral{

	org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String dbServerName = "";
	String dbServerPort = "";
	String erapidDB = "";
	String erapidSysDB = "";
	String erapidDBUsername = "";
	String erapidDBPassword = "";

	String query = "";

	public String getFreight(double pIndTOTWT,String city,String state,String orderNo,String sectionLines){
		//logger.debug("Get freight::" + pIndTOTWT + "::" + state + "::" + city);
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
			String columnName = "";
			if(pIndTOTWT < 300){
				columnName = "max300";
			}
			else if(pIndTOTWT <= 500){
				columnName = "max500";
			}
			else if(pIndTOTWT <= 1000){
				columnName = "max1000";
			}
			else if(pIndTOTWT <= 2000){
				columnName = "max2000";
			}
			else if(pIndTOTWT <= 5000){
				columnName = "max5000";
			}
			else if(pIndTOTWT <= 10000){
				columnName = "max10000";
			}
			else if(pIndTOTWT <= 20000){
				columnName = "max2000";
			}
			else if(pIndTOTWT <= 30000){
				columnName = "max30000";
			}
			else if(pIndTOTWT <= 100000){
				columnName = "max100000";
			}
			String tempValue = "0";
			//logger.debug("HERE accesscental.java line 85" + "Select " + columnName + " from cs_grille_ltl where state='" + state + "' and city='" + city + "'<BR>");
			if(city != null && city.length() > 0 && state != null && state.length() > 0 && columnName != null & columnName.length() > 0){
				ResultSet rsTransport = stmt.executeQuery("Select " + columnName + " from cs_grille_ltl where state='" + state + "' and city='" + city + "'");
				if(rsTransport != null){
					while(rsTransport.next()){
						//logger.debug(pIndTOTWT + "::" + rsTransport.getString(1));
						tempValue = "" + ((new Double(rsTransport.getString(1)).doubleValue()) * pIndTOTWT);
						//logger.debug(tempValue);
					}
				}
				rsTransport.close();
			}
			
			if(city.toUpperCase().equals("HONOLULU") && state.toUpperCase().equals("HI")){
				logger.debug("ACCESS CENTRAL line 99 is Honolulu");
				Vector SYSDEPTH = new Vector();
				Vector SQFT = new Vector();

				String query = "SELECT * FROM cs_costing WHERE order_no='" + orderNo + "'";
				if(sectionLines != null && sectionLines.trim().length() > 0 && !sectionLines.equals("null")){
					query = "SELECT * FROM cs_costing WHERE order_no='" + orderNo + "' and item_no in(" + sectionLines + ")";
				}
				logger.debug(query);
				ResultSet rsCosting = stmt.executeQuery(query);
				if(rsCosting != null){
					while(rsCosting.next()){
						//logger.debug(rsCosting.getString("ssedge_code"));
						SYSDEPTH.addElement(rsCosting.getString("ssedge_code"));
						SQFT.addElement(rsCosting.getString("sqft"));
					}
				}
				rsCosting.close();
				logger.debug(SYSDEPTH+"::"+tempValue + ":: before<BR>");
				for(int x = 0;x < SYSDEPTH.size();x++){
					double tempSysDepth = 0;
					if(SYSDEPTH.elementAt(x).toString().toUpperCase().indexOf("MM") > 0){
						String temp = "";
						temp = SYSDEPTH.elementAt(x).toString().replace("mm","");
						temp = SYSDEPTH.elementAt(x).toString().replace("MM","");
						tempSysDepth = (new Double(temp).doubleValue() * 0.0393701) + 3;
					}
					else{

						String temp = "";
						temp = SYSDEPTH.elementAt(x).toString().replace("\"","");
						String[] g = temp.split(" ");
						double tempDepth = 0;
						for(int i = 0;i < g.length;i++){
							boolean isFract = false;
							for(int ii = 0;ii < g[i].length();ii++){
								char c = g[i].charAt(ii);
								int j = (int) c;
								if(j == 47){
									isFract = true;
								}
							}
							if(isFract){
								String[] frac = g[i].split("/");
								tempDepth = tempDepth + new Double(frac[0]).doubleValue() / new Double(frac[1]).doubleValue();
							}
							else{
								tempDepth = tempDepth + new Double(g[i]).doubleValue();
							}
						}
						tempSysDepth = tempSysDepth + tempDepth + 3;

						//String temp = "";
						//temp = SYSDEPTH.elementAt(x).toString().replace("\"","");
						//logger.debug(temp + ":: should not have double quote");
						//tempSysDepth = tempSysDepth + new Double(temp).doubleValue() + 3;
					}
					logger.debug(tempSysDepth + "::" + SQFT.elementAt(x).toString() + "::" + tempValue + "<BR>");
					tempValue = "" + (new Double(tempValue).doubleValue() + (((tempSysDepth / 12) * new Double(SQFT.elementAt(x).toString()).doubleValue()) * 12.0));
				}
				logger.debug(tempValue + ":: after<BR>");
			}
                        if(new Double(tempValue).doubleValue()<0){
                            tempValue="0";
                        }
			//logger.debug("HERE accesscental.java line 95");
			Element resultx = doc2.createElement("searchresult");
			resultList.appendChild(resultx);
			Element a = doc2.createElement("freight");
			a.appendChild(doc2.createTextNode(tempValue.trim() + "#"));
			resultx.appendChild(a);

			TransformerFactory tFact = TransformerFactory.newInstance();
			Transformer trans = tFact.newTransformer();
			StringWriter writer = new StringWriter();
			StreamResult result = new StreamResult(writer);
			DOMSource source = new DOMSource(doc2);
			trans.transform(source,result);
			html = writer.toString().trim();

		}
		catch(Exception e){
			logger.debug("AccessCentral Bean.getFrieght");
			logger.debug(e.getMessage());
			logger.debug("AccessCentral Bean.getFrieght END");
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
		return html;
	}

	private static String getTagValue(String sTag,Element eElement){
		NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		return nValue.getNodeValue();
	}
}
