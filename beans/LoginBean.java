package com.csgroup.general;

import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import org.w3c.dom.Document;
import org.w3c.dom.NodeList;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import java.io.File;
import java.sql.*;
import java.util.*;


public class LoginBean{

	org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String userName = "";
	String admin = "";
	String hide = "";
	String env = "";
	
	public void setUserName(String x){
		this.userName = x;
	}

	public void setEnv(String x)
	{
		this.env = x;
	}
	private static String getTagValue(String sTag,Element eElement){
		NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		return nValue.getNodeValue();
	}

	public String getAdmin(){
		String isAdmin = "false";
		Connection myConn = null;
		Statement stmt = null;
		try{
			String dbServerName = "";
			String dbServerPort = "";
			String erapidDB = "";
			String erapidSysDB = "";
			String erapidDBUsername = "";
			String erapidDBPassword = "";
			String htmlbuttons = "";
			Vector rep_nos = new Vector();
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
					dbServerName = "" + getTagValue("dbServerName",eElement);
					dbServerPort = "" + getTagValue("dbServerPort",eElement);
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

			String query = "select count(*) from cs_reps where user_id='" + userName + "' and group_id in ('Admins','super','UK-DEVELOP')";
			ResultSet rs1 = stmt.executeQuery(query);
			if(rs1 != null){
				while(rs1.next()){
					if(rs1.getInt(1) > 0){
						isAdmin = "true";
					}
				}
			}
			rs1.close();
			stmt.close();
			myConn.close();
		}
		catch(Exception e){
			logger.debug("LoginBean.getAdmin");
			logger.debug(e.getMessage());
			logger.debug("LoginBean.getAdmin end");
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
		return (isAdmin);

	}

	public String getButtons(){
		Connection myConn = null;
		Statement stmt = null;
		try{
			String dbServerName = "";
			String dbServerPort = "";
			String erapidDB = "";
			String erapidSysDB = "";
			String erapidDBUsername = "";
			String erapidDBPassword = "";
			String htmlbuttons = "";
			String repName = "";
			Vector rep_nos = new Vector();
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
					dbServerName = "" + getTagValue("dbServerName",eElement);
					dbServerPort = "" + getTagValue("dbServerPort",eElement);
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
			String query = "Select Distinct rep_no_text,group_id,user_id,rep_name from cs_reps where rep_name = (Select rep_name from cs_reps where  user_id = '" + userName + "') order by rep_no_text";
			ResultSet rs1 = stmt.executeQuery(query);
			if(rs1 != null){
				while(rs1.next()){
					//htmlbuttons=htmlbuttons+rs1.getString(1)+"::"+rs1.getString(2)+"<input type='submit' name='login' value='"+rs1.getString(3)+"' class='button' onmouseover=this.className='button5'	onmouseout=this.className='button' style='width:150;height:30' onclick='document.webLoginFrm.login.value="+rs1.getString(3)+"'; onmousedown='document.webLoginFrm.repNo.value="+rs1.getString(1)+"';><BR>";
					rep_nos.addElement(rs1.getString(1));
					repName = rs1.getString("rep_name");
				}
			}
			rs1.close();
			String oldRepNo = "";
			int counterx = 0;
			for(int i = 0;i < rep_nos.size();i++){
				String query2 = "select rep_no_text,group_id, user_id,rep_name from cs_reps where rep_no_text='" + rep_nos.elementAt(i).toString() + "' order by rep_no_text,user_id, rep_name";
				ResultSet rs2 = stmt.executeQuery(query2);
				if(rs2 != null){
					while(rs2.next()){
						//if(oldRepNo.equals(rep_nos.elementAt(i).toString())){
						if(repName.equals(rs2.getString(4))){
							htmlbuttons = htmlbuttons + "<li value='" + rep_nos.elementAt(i).toString() + "'><a href='loginLog.jsp?username=" + rs2.getString(3) + "&initialusername=" + userName + "&env=" + env +"'><span>" + rs2.getString(1) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + rs2.getString(4) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(" + rs2.getString(3) + ")</span></a></li>";
						}
						else{
							hide = hide + counterx + ",";
							htmlbuttons = htmlbuttons + "<li value='" + rep_nos.elementAt(i).toString() + "'><a href='loginLog.jsp?username=" + rs2.getString(3) + "&initialusername=" + userName + "&env=" + env + "'><span>" + rs2.getString(1) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" + rs2.getString(4) + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(" + rs2.getString(3) + ")</span></a></li>";
						}
						oldRepNo = rep_nos.elementAt(i).toString();
						counterx++;
					}
				}
				rs2.close();
			}
			stmt.close();
			myConn.close();
			return (htmlbuttons);
		}
		catch(Exception e){
			logger.debug("LoginBean.getButtons");
			logger.debug(e.getMessage());
			logger.debug("LoginBean.getButtons end");
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

	public String getHide(){
		return hide;
	}
}
