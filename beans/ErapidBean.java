package com.csgroup.general;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import java.io.File;


public class ErapidBean{

	org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String serverName;
	String fullServerName;
	String cpqServerName;
	String dbServerName;
	String dbServerPort;
	String erapidDB;
	String erapidSysDB;
	String erapidDBUsername;
	String erapidDBPassword;
	String dbUSRepServerName;
	String dbUSRepServerPort;
	String USRepDB;
	String USRepDBUsername;
	String USRepDBPassword;
	String dbPSAServerName;
	String dbPSAServerPort;
	String PSADB;
	String PSADBUsername;
	String PSADBPassword;
	String messageUS;
	String messageTypeUS = "";
	String dbBPCSServerName = "";
	String BPCSDB = "";
	String BPCSUSRDB = "";
	String BPCSDBUsername = "";
	String BPCSDBPassword = "";
	String dbSFDCServerName = "";
	String dbSFDCServerPort = "";
	String SFDCDB = "";
	String SFDCDBUsername = "";
	String SFDCDBPassword = "";
	String WEBServerName;
	String WEBServerPort;
	String WEBDB;
	String WEBDBUsername;
	String WEBDBPassword;

	private static String getTagValue(String sTag,Element eElement){
		NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		return nValue.getNodeValue();
	}

	public void setServerName(String x){
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
					this.cpqServerName = "" + getTagValue("cpqServerName",eElement);
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
					this.dbUSRepServerName = "" + getTagValue("dbUSRepServerName",eElement);
					this.dbUSRepServerPort = "" + getTagValue("dbUSRepServerPort",eElement);
					this.USRepDB = "" + getTagValue("USRepDB",eElement);
					this.USRepDBUsername = "" + getTagValue("USRepDBUsername",eElement);
					this.USRepDBPassword = "" + getTagValue("USRepDBPassword",eElement);
					this.dbPSAServerName = "" + getTagValue("dbPSAServerName",eElement);
					this.dbPSAServerPort = "" + getTagValue("dbPSAServerPort",eElement);
					this.PSADB = "" + getTagValue("PSADB",eElement);
					this.PSADBUsername = "" + getTagValue("PSADBUsername",eElement);
					this.PSADBPassword = "" + getTagValue("PSADBPassword",eElement);
					this.messageUS = "" + getTagValue("messageUS",eElement);
					this.messageTypeUS = "" + getTagValue("messageTypeUS",eElement);
					this.dbSFDCServerName = "" + getTagValue("dbSFDCServerName",eElement);
					this.dbSFDCServerPort = "" + getTagValue("dbSFDCServerPort",eElement);
					this.SFDCDB = "" + getTagValue("SFDCDB",eElement);
					this.SFDCDBUsername = "" + getTagValue("SFDCDBUsername",eElement);
					this.SFDCDBPassword = "" + getTagValue("SFDCDBPassword",eElement);
					this.WEBServerName = "" + getTagValue("WEBServerName",eElement);
					this.WEBServerPort = "" + getTagValue("WEBServerPort",eElement);
					this.WEBDB = "" + getTagValue("WEBDB",eElement);
					this.WEBDBUsername = "" + getTagValue("WEBDBUsername",eElement);
					this.WEBDBPassword = "" + getTagValue("WEBDBPassword",eElement);
				}
			}
		}
		catch(Exception e){
			this.serverName = "" + e;
		}
		//logger.debug(dbUSRepServerName + "::" + dbUSRepServerPort + "::" + USRepDB + "::" + USRepDBUsername + "::" + USRepDBPassword + ":: erapid bean line 80");
	}

	public String getServerName(){
		return serverName;
	}

	public String getFullServerName(){
		return fullServerName;
	}

	public String getCpqServerName(){
		return cpqServerName;
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

	public String getDbSFDCServerName(){
		return dbSFDCServerName;
	}

	public String getDbSFDCServerPort(){
		return dbSFDCServerPort;
	}

	public String getSFDCDB(){
		return SFDCDB;
	}

	public String getSFDCDBUsername(){
		return SFDCDBUsername;
	}

	public String getSFDCDBPassword(){
		return SFDCDBPassword;
	}

	public String getDbBPCSServerName(){
		return dbBPCSServerName;
	}

	public String getBPCSDB(){
		return BPCSDB;
	}

	public String getBPCSUSRDB(){
		return BPCSUSRDB;
	}

	public String getBPCSDBUsername(){
		return BPCSDBUsername;
	}

	public String getBPCSDBPassword(){
		return BPCSDBPassword;
	}

	public String getUSRepDbServerName(){
		return dbUSRepServerName;
	}

	public String getUSRepDbServerPort(){
		return dbUSRepServerPort;
	}

	public String getUSRepDB(){
		return USRepDB;
	}

	public String getUSRepDBUsername(){
		return USRepDBUsername;
	}

	public String getUSRepDBPassword(){
		return USRepDBPassword;
	}

	public String getPSADbServerName(){
		return dbPSAServerName;
	}

	public String getPSADbServerPort(){
		return dbPSAServerPort;
	}

	public String getPSADBUsername(){
		return PSADBUsername;
	}

	public String getPSADBPassword(){
		return PSADBPassword;
	}

	public String getPSADB(){
		return PSADB;
	}

	public String getWEBServerName(){
		return WEBServerName;
	}

	public String getWEBServerPort(){
		return WEBServerPort;
	}

	public String getWEBDB(){
		return WEBDB;
	}

	public String getWEBDBUsername(){
		return WEBDBUsername;
	}

	public String getWEBDBPassword(){
		return WEBDBPassword;
	}

	public String getMessageUS(){
		return messageUS;
	}

	public String getMessageTypeUS(){
		return messageTypeUS;
	}
}
