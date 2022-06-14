package com.csgroup.general;

import java.io.File;
import java.sql.*;
import java.util.*;
import javax.xml.parsers.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;
import org.w3c.dom.*;


public class AdminBean{

	org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String messageUS = "";
	String messageTypeUS = "";
	String dbServerName = "";
	String dbServerPort = "";
	String erapidDB = "";
	String erapidSysDB = "";
	String erapidDBUsername = "";
	String erapidDBPassword = "";

	String env = "";
	
	public void setEnv(String x)
	{
		this.env = x;
	}
	public String getButtons(){
		Connection myConn = null;
		Statement stmt = null;
		try{
			//logger.debug("1");
			String htmlbuttons = "";
			Vector rep_nos = new Vector();
			File fXmlFile = new File("d:\\erapid\\erapid.xml");
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("instance");
			//logger.debug("2");
			for(int temp = 0;temp < nList.getLength();temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					//logger.debug("2.2");
					Element eElement = (Element) nNode;
					this.dbServerName = "" + getTagValue("dbServerName",eElement);
					this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
					this.erapidDB = "" + getTagValue("erapidDB",eElement);
					//logger.debug("2.4");
					this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
					//logger.debug("2.6");
					this.messageUS = "" + getTagValue("messageUS",eElement);
					this.messageTypeUS = "" + getTagValue("messageTypeUS",eElement);
					//logger.debug("2.8");
				}
			}
			//logger.debug("3");

			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			//logger.debug("4");
			String query2 = "select rep_no_text,group_id, user_id,rep_name from cs_reps where not group_id='webuser' order by user_id";
			ResultSet rs2 = stmt.executeQuery(query2);
			if(rs2 != null){
				while(rs2.next()){
					htmlbuttons = htmlbuttons + "<li data-value='text'><a href='loginLog.jsp?username=" + rs2.getString(3) + "&env=" + env + "&initialusername=admin'><span>" + rs2.getString(1) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + rs2.getString(4) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(" + rs2.getString(2) + ")</span></a></li>";
				}
			}
			rs2.close();

			//logger.debug("5");
			return (htmlbuttons);

		}
		catch(Exception e){
			logger.debug("AdminBean.getButtons");
			logger.debug(e.getMessage());
			logger.debug("AdminBean.getButtons end");
			return ("" + e);
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

	public String getGroups(){
		Connection myConn = null;
		Statement stmt = null;
		try{
			//logger.debug("1");
			String htmlbuttons = "";
			Vector rep_nos = new Vector();
			File fXmlFile = new File("d:\\erapid\\erapid.xml");
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			NodeList nList = doc.getElementsByTagName("instance");
			//logger.debug("2");
			for(int temp = 0;temp < nList.getLength();temp++){
				Node nNode = nList.item(temp);
				if(nNode.getNodeType() == Node.ELEMENT_NODE){
					//logger.debug("2.2");
					Element eElement = (Element) nNode;
					this.dbServerName = "" + getTagValue("dbServerName",eElement);
					this.dbServerPort = "" + getTagValue("dbServerPort",eElement);
					this.erapidDB = "" + getTagValue("erapidDB",eElement);
					//logger.debug("2.4");
					this.erapidSysDB = "" + getTagValue("erapidSysDB",eElement);
					this.erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					this.erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
					//logger.debug("2.6");
					this.messageUS = "" + getTagValue("messageUS",eElement);
					this.messageTypeUS = "" + getTagValue("messageTypeUS",eElement);
					//logger.debug("2.8");
				}
			}
			//logger.debug("3");

			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			//logger.debug("4");
			String query2 = "select distinct group_id from cs_reps where not group_id='webuser' order by group_id";
			ResultSet rs2 = stmt.executeQuery(query2);
			if(rs2 != null){
				while(rs2.next()){
					htmlbuttons = htmlbuttons + "<option value='" + rs2.getString(1) + "'>" + rs2.getString(1) + "</option>";

				}
			}
			rs2.close();
			stmt.close();
			myConn.close();
			//logger.debug("5");
			return (htmlbuttons);

		}
		catch(Exception e){
			logger.debug("AdminBean.getButtons");
			logger.debug(e.getMessage());
			logger.debug("AdminBean.getButtons end");
			return ("" + e);
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

	public void saveMessage(String saveMessageUS,String saveMessageTypeUS){
		try{
			String filepath = "d:\\erapid\\erapid.xml";
			File fXmlFile = new File(filepath);
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(fXmlFile);
			doc.getDocumentElement().normalize();
			Node instance = doc.getElementsByTagName("instance").item(0);
			NodeList list = instance.getChildNodes();
			for(int i = 0;i < list.getLength();i++){
				Node node = list.item(i);
				if("messageUS".equals(node.getNodeName())){
					node.setTextContent(saveMessageUS);
				}
				if("messageTypeUS".equals(node.getNodeName())){
					node.setTextContent(saveMessageTypeUS);
				}
			}
			TransformerFactory transformerFactory = TransformerFactory.newInstance();
			Transformer transformer = transformerFactory.newTransformer();
			DOMSource source = new DOMSource(doc);
			StreamResult result = new StreamResult(new File(filepath));
			transformer.transform(source,result);
		}
		catch(Exception e){
			logger.debug("AdminBean.saveMessage");
			logger.debug(e.getMessage());
			logger.debug("AdminBean.saveMessage end");
		}
	}

	public String getMessageUS(){
		return messageUS;
	}

	public String getMessageTypeUS(){
		return messageTypeUS;
	}

	public String getDbServerName(){
		return dbServerName;
	}

	public String getDbServerPort(){
		return dbServerPort;
	}

	public String getErapidDB(){
		return erapidDB;
	}

	public String getErapidSysDB(){
		return erapidSysDB;
	}

	public String getErapidDBUsername(){
		return erapidDBUsername;
	}

	public String getErapidDBPassword(){
		return erapidDBPassword;
	}

	private static String getTagValue(String sTag,Element eElement){
		NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		return nValue.getNodeValue();
	}
}
