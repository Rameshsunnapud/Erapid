package com.csgroup.general;

import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;
import org.w3c.dom.*;
import java.io.*;
import java.sql.*;
import java.util.*;


public class ButtonsBean{

	org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String dbServerName = "";
	String dbServerPort = "";
	String erapidDB = "";
	String erapidSysDB = "";
	String erapidDBUsername = "";
	String erapidDBPassword = "";

	String query = "";

	public String getButtons(String page,String productId,String country,String groupId,String orderNo){
		String html = "";
		String isExpired = "";
		String isSpecial = "";
		String docType = "";
		String winLoss = "";
		String projectType = "";
		String quoteOrigin = "";
		double configuredPrice = 0;
		Connection myConn = null;
		Statement stmt = null;
		boolean isOverLimit = false;
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

			query = "select doc_type,win_loss from doc_header where doc_number='" + orderNo + "'";
			ResultSet rs0 = stmt.executeQuery(query);
			if(rs0 != null){
				while(rs0.next()){
					docType = rs0.getString("doc_type");
					winLoss = rs0.getString("win_loss");
				}
			}
			rs0.close();
			query = "select project_type,configured_price,overage,handling_cost,setup_cost,freight_cost,quote_origin from cs_project where order_no='" + orderNo + "'";
			//logger.debug(query);
			ResultSet rsProject = stmt.executeQuery(query);
			if(rsProject != null){
				while(rsProject.next()){
					projectType = rsProject.getString(1);
					configuredPrice = rsProject.getDouble(2) + rsProject.getDouble(3) + rsProject.getDouble(4) + rsProject.getDouble(5) + rsProject.getDouble(6);
					quoteOrigin = rsProject.getString("quote_origin");
				}
			}
			rsProject.close();
			//logger.debug(quoteOrigin);
			if(projectType == null || projectType.trim().length() == 0){
				projectType = "rep";
			}
			//logger.debug(quoteOrigin+"::: quote origin");

			ResultSet rsspecial = stmt.executeQuery("select count(*) from csquotes where order_no='" + orderNo + "' and (block_id='specials' or field18 like 'spec%')");
			if(rsspecial != null){
				while(rsspecial.next()){
					if(rsspecial.getInt(1) > 0){
						isSpecial = "y";
					}
				}
			}
			rsspecial.close();
			//logger.debug(groupId + ":: group id");
			if(groupId.toUpperCase().indexOf("REP") >= 0 && !groupId.toUpperCase().equals("REP_FE")){
				query = "select max_price from cs_rep_limits where product_id='" + productId + "'";
				//logger.debug(query);
				//logger.debug(configuredPrice);
				ResultSet rs0x = stmt.executeQuery(query);
				if(rs0x != null){
					while(rs0x.next()){
						//logger.debug(rs0x.getDouble(1) + "::");
						if(configuredPrice > rs0x.getDouble(1) && (projectType.equals("rep")||projectType.equals("RP"))){
							isOverLimit = true;
						}
					}
				}
				rs0x.close();
			}
			query = "select * from cs_button_security where page='" + page + "' and (quote_origin = '" + quoteOrigin + "' or quote_origin='*') and (not_quote_origin is null or not not_quote_origin='" + quoteOrigin + "') and (product_id like '%" + productId + "%' or product_id='*') and country='" + country + "' and (doc_type='" + docType + "' or doc_type='*') and (project_type='" + projectType + "' or project_type='*') and (win_loss='" + winLoss + "' or win_loss='*') and ";
			if(groupId.toUpperCase().indexOf("REP") >= 0 && !groupId.toUpperCase().equals("REP_FE")){
				query = query + "(group_id like 'REP%' or group_id='*')";
			}
			else{
				query = query + "(group_id='" + groupId + "' or group_id='*' or '" + groupId + "' like group_id)";
			}
			query = query + " and not (not_group_id like '%" + groupId + "%')";
			if(isExpired != null && isExpired.trim().length() > 0){
				query = query + " and (isexpired='" + isExpired + "' or isexpired='*')";
			}
			if(isSpecial != null && isSpecial.trim().length() > 0){
				query = query + " and (isSpecial='" + isSpecial + "' or isSpecial='*')";
			}
			query = query + " order by seq";
			logger.debug(query);
			DocumentBuilderFactory dFact = DocumentBuilderFactory.newInstance();
			DocumentBuilder build = dFact.newDocumentBuilder();
			Document doc2 = build.newDocument();
			Element resultList = doc2.createElement("buttons");
			doc2.appendChild(resultList);
			if(!isOverLimit){
				ResultSet rs1 = stmt.executeQuery(query);
				if(rs1 != null){
					while(rs1.next()){
						Element buttonresults = doc2.createElement("buttonsresults");
						resultList.appendChild(buttonresults);
						Element nameElement = doc2.createElement("name");
						nameElement.appendChild(doc2.createTextNode(rs1.getString("name")));
						buttonresults.appendChild(nameElement);
						Element actionElement = doc2.createElement("action");
						actionElement.appendChild(doc2.createTextNode(rs1.getString("action")));
						buttonresults.appendChild(actionElement);

						Element urlElement = doc2.createElement("url");
						urlElement.appendChild(doc2.createTextNode(rs1.getString("url")));
						buttonresults.appendChild(urlElement);
						Element urlAddElement = doc2.createElement("urlAdd");
						urlAddElement.appendChild(doc2.createTextNode(rs1.getString("urlAdd") + "#"));
						buttonresults.appendChild(urlAddElement);
						Element seqElement = doc2.createElement("seq");
						seqElement.appendChild(doc2.createTextNode(rs1.getString("seq") + "#"));
						buttonresults.appendChild(seqElement);
						String jsfunction = rs1.getString("jsfunction");
						if(jsfunction == null || jsfunction.trim().length() == 0){
							jsfunction = "#";
						}
						Element jsfunctionElement = doc2.createElement("jsfunction");
						jsfunctionElement.appendChild(doc2.createTextNode(jsfunction));
						buttonresults.appendChild(jsfunctionElement);
						Element imstypeElement = doc2.createElement("imstype");
						imstypeElement.appendChild(doc2.createTextNode(rs1.getString("imstype") + "#"));
						buttonresults.appendChild(imstypeElement);
						//html=html+"::"+rs1.getString("name")+"::"+rs1.getString("action")+"::"+jsfunction+"::<BR>";
					}
				}
				rs1.close();
			}
			else{
				Element buttonresults = doc2.createElement("buttonsresults");
				resultList.appendChild(buttonresults);
				Element nameElement = doc2.createElement("name");
				nameElement.appendChild(doc2.createTextNode("QUOTE OVER PRICE LIMIT"));
				buttonresults.appendChild(nameElement);
				Element actionElement = doc2.createElement("action");
				actionElement.appendChild(doc2.createTextNode("QUOTE OVER PRICE LIMIT"));
				buttonresults.appendChild(actionElement);
				Element a = doc2.createElement("seq");
				a.appendChild(doc2.createTextNode("QUOTE OVER PRICE LIMIT"));
				buttonresults.appendChild(a);

				Element urlElement = doc2.createElement("url");
				urlElement.appendChild(doc2.createTextNode("" + "#"));
				buttonresults.appendChild(urlElement);
				Element urlAddElement = doc2.createElement("urlAdd");
				urlAddElement.appendChild(doc2.createTextNode("" + "#"));
				buttonresults.appendChild(urlAddElement);
				String jsfunction = "";
				if(jsfunction == null || jsfunction.trim().length() == 0){
					jsfunction = "#";
				}
				Element jsfunctionElement = doc2.createElement("jsfunction");
				jsfunctionElement.appendChild(doc2.createTextNode(jsfunction));
				buttonresults.appendChild(jsfunctionElement);
				Element imstypeElement = doc2.createElement("imstype");
				imstypeElement.appendChild(doc2.createTextNode("#"));
				buttonresults.appendChild(imstypeElement);
			}

			TransformerFactory tFact = TransformerFactory.newInstance();
			Transformer trans = tFact.newTransformer();
			StringWriter writer = new StringWriter();
			StreamResult result = new StreamResult(writer);
			DOMSource source = new DOMSource(doc2);
			trans.transform(source,result);
			html = writer.toString().trim();

		}
		catch(Exception e){
			logger.debug("ButtonsBean.getButtons()");
			logger.debug(e.getMessage());
			logger.debug("ButtonsBean.getButtons() END");
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
		//logger.debug(html);
		return html;
	}

	private static String getTagValue(String sTag,Element eElement){
		NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		return nValue.getNodeValue();
	}
}
