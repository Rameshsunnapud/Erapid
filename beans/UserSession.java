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


public class UserSession{

	org.slf4j.Logger logger = org.slf4j.LoggerFactory.getLogger("erapidLogger");
	String repNo = "";
	String userId = "";
	String userName = "";
	String repAccount = "";
	String styleSheet = "";
	String address1 = "";
	String address2 = "";
	String city = "";
	String state = "";
	String email = "";
	String zip = "";
	String telephone = "";
	String fax = "";
	String group = "";
	String orderNo = "";
	String lineNo = "";
	String country = "";
	String dbServerName = "";
	String dbServerPort;
	String erapidDB = "";
	String erapidSysDB = "";
	String erapidDBUsername = "";
	String erapidDBPassword = "";
	String helpMenu = "";
	String userSecurityMenu = "";
	String unitPrice = "";
        String blockErapidQuoting="N";
	boolean isSalesForceSession = false;

	String query = "";
	Vector products = new Vector();
	Vector productsDescription = new Vector();
	Vector editProducts = new Vector();
	Vector editProductsDescription = new Vector();
	Vector reps = new Vector();
	Vector repsNames = new Vector();
	Vector reps2 = new Vector();
	Vector repsNames2 = new Vector();

	String env = "";
	
	public void setRepNo(String x){
		this.repNo = x;
	}

	
	public void setUserId(String x){
		products.clear();
		productsDescription.clear();
		editProducts.clear();
		editProductsDescription.clear();
		reps.clear();
		repsNames.clear();
		reps2.clear();
		repsNames2.clear();
		repNo = "";
		userId = "";
		userName = "";
		repAccount = "";
		styleSheet = "";
		address1 = "";
		address2 = "";
		city = "";
		state = "";
		email = "";
		zip = "";
		telephone = "";
		fax = "";
		group = "";
		orderNo = "";
		lineNo = "";
		country = "";
		helpMenu = "";
		userSecurityMenu = "";
		unitPrice = "";
		this.userId = x;
		Connection myConnSys = null;
		Statement stmtSys = null;
		Connection myConn = null;
		Statement stmt = null;
		try{

			//Vector rep_nos = new Vector();
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
			myConnSys = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidSysDB,erapidDBUsername,erapidDBPassword);
			stmtSys = myConnSys.createStatement();
			stmtSys.executeUpdate("set ANSI_warnings off");
			query = "Select rep_no_text,group_id,user_id,rep_name,country_code,rep_account,style_sheet,address1,address2,rep_city,state,email,zip,telephone,fax from cs_reps where user_id = '" + userId + "'";
			ResultSet rs1 = stmt.executeQuery(query);
			if(rs1 != null){
				while(rs1.next()){
					this.repNo = rs1.getString(1);
					this.userId = rs1.getString(3);
					this.userName = rs1.getString(4);
					this.group = rs1.getString(2);
					this.country = rs1.getString(5);
					this.repAccount = rs1.getString(6);
					this.styleSheet = rs1.getString(7);
					this.address1 = rs1.getString(8);
					this.address2 = rs1.getString(9);
					this.city = rs1.getString(10);
					this.state = rs1.getString(11);
					this.email = rs1.getString(12);
					this.zip = rs1.getString(13);
					this.telephone = rs1.getString(14);
					this.fax = rs1.getString(15);
				}
			}
			rs1.close();
			if(this.repAccount == null){
				this.repAccount = "";
			}
			if(this.styleSheet == null){
				this.styleSheet = "";
			}
			if(this.address1 == null){
				this.address1 = "";
			}
			if(this.address2 == null){
				this.address2 = "";
			}
			if(this.city == null){
				this.city = "";
			}
			if(this.state == null){
				this.state = "";
			}
			if(this.email == null){
				this.email = "";
			}
			if(this.zip == null){
				this.zip = "";
			}
			if(this.telephone == null){
				this.telephone = "";
			}
			if(this.fax == null){
				this.fax = "";
			}
			Properties properties = new Properties();
                        query="select * from cs_block_erapid_quoting where rep_no='"+this.repNo+"' and block_new_quotes='Y'";
                        ResultSet rs2=stmt.executeQuery(query);
                        if(rs2 != null){
                            while(rs2.next()){
                                blockErapidQuoting="Y";
                            }
                        }
                        rs2.close();
                        
			query = "SELECT * FROM logia_group where group_id = '" + group + "'";
			ResultSet rs3 = stmtSys.executeQuery(query);
			if(rs3 != null){
				while(rs3.next()){
					String testbinary = "" + rs3.getBytes(4);
					java.io.ObjectInputStream objectinputstream = new java.io.ObjectInputStream(new java.io.ByteArrayInputStream(rs3.getBytes(4)));
					properties = (Properties) objectinputstream.readObject();
				}
			}
			rs3.close();
			//this.products.addElement("4");

			Vector it_key = new Vector();
			Vector it_values = new Vector();
			Enumeration e = properties.propertyNames();
			String key = "";
			String value = "";
			String finalProductString = "";
			while(e.hasMoreElements()){
				key = (String) e.nextElement();
				value = properties.getProperty(key);
				//this.products.addElement(value+"::"+key);
				it_key.addElement(key);
				//this.products.addElement(key+":::"+value);
				it_values.addElement(value);
			}
			Vector final_products = new Vector();
			Vector final_products_desc = new Vector();
			Vector productsx = new Vector();
			Vector product_desc = new Vector();
			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			ResultSet rsProducts = stmt.executeQuery("SELECT PRODUCT_ID,PRODUCT_NAME FROM PRODUCTS WHERE USER_STAT3='Y' ORDER BY product_name,product_id  desc");
			if(rsProducts != null){
				while(rsProducts.next()){
					productsx.addElement(rsProducts.getString(1));
					//this.products.addElement(rsProducts.getString( 1 ));
					product_desc.addElement(rsProducts.getString(2));
					//logger.debug(rsProducts.getString(1)+"::"+rsProducts.getString(2)+"::");
					//this.products.addElement(rsProducts.getString( 1 )+"::<BR>");
				}
			}
			rsProducts.close();
			for(int j = 0;j < productsx.size();j++){

				for(int i = 0;i < it_key.size();i++){
					if(it_values.elementAt(i).equals("D")){
						if(productsx.elementAt(j).toString().equals(it_key.elementAt(i).toString())){
							//usfinal_products.addElement(productsx.elementAt(j).toString());
							//usfinal_products_desc.addElement(product_desc.elementAt(j).toString());
							this.products.addElement(productsx.elementAt(j).toString());
							this.productsDescription.addElement(product_desc.elementAt(j).toString());

						}
					}
				}// if loop
			}// for loop
			//help menu
			query = "select name,url from cs_help_links where country='" + country + "' order by cast(line as numeric)";
			//logger.debug(query);
			//helpMenu=query;
			helpMenu = "";
			ResultSet rsHelp = stmt.executeQuery(query);
			if(rsHelp != null){
				while(rsHelp.next()){
					helpMenu = helpMenu + "<li><a href='" + rsHelp.getString("url") + "' target='_blank'><span>" + rsHelp.getString("name") + "</span></a></li>";
				}
			}
			rsHelp.close();
			//logger.debug(helpMenu);

			query = "select * from cs_user_security where user_id in ('" + userId + "','every') and group_id in('" + group + "','*') and not task='Unit price'";
			//logger.debug(query);
			userSecurityMenu = "";
			ResultSet rsUserSecurity = stmt.executeQuery(query);
			if(rsUserSecurity != null){
				while(rsUserSecurity.next()){
					userSecurityMenu = userSecurityMenu + "<li><a href='" + rsUserSecurity.getString("url") + "' target='_blank'><span>" + rsUserSecurity.getString("task") + "</span></a></li>";
				}
			}
			rsUserSecurity.close();
			userSecurityMenu = userSecurityMenu.replaceAll("%USERNAME%",this.userId);
			query = "select * from cs_user_security where user_id in ('" + userId + "','every') and group_id='" + group + "' and task='Unit price'";
			//logger.debug("usersession.java line 180::" + query);
			unitPrice = "";
			ResultSet rsUserSecurity2 = stmt.executeQuery(query);
			if(rsUserSecurity2 != null){
				while(rsUserSecurity2.next()){
					for(int i = 0;i < this.products.size();i++){
						unitPrice = unitPrice + "<li><a href='" + rsUserSecurity2.getString("url").replaceAll("%PID%",this.products.elementAt(i).toString()) + "' target='_blank'><span>" + this.products.elementAt(i).toString() + "</span></a></li>";
					}
				}
			}
			rsUserSecurity2.close();
			unitPrice = unitPrice.replaceAll("%USERNAME%",this.userId);

			if(this.group.toUpperCase().indexOf("REP") < 0){
				query = "SELECT rep_no_text, rep_name FROM cs_reps where rep_no_text!='" + repNo + "' and category ='rep' ORDER BY rep_name,rep_no_text";
				Class.forName("net.sourceforge.jtds.jdbc.Driver");
				myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
				stmt = myConn.createStatement();
				stmt.executeUpdate("set ANSI_warnings off");
				ResultSet rsRepNum = stmt.executeQuery(query);
				if(rsRepNum != null){
					while(rsRepNum.next()){
						reps.addElement(rsRepNum.getString(1));
						repsNames.addElement(rsRepNum.getString(2));
					}
				}
				rsRepNum.close();
				query = "SELECT rep_no_text, rep_name FROM cs_reps where rep_no_text!='" + repNo + "' ORDER BY rep_name,rep_no_text";
				ResultSet rsRepNum2 = stmt.executeQuery(query);
				if(rsRepNum2 != null){
					while(rsRepNum2.next()){
						reps2.addElement(rsRepNum2.getString(1));
						repsNames2.addElement(rsRepNum2.getString(2));
					}
				}
				rsRepNum2.close();
			}
			if(this.group.toUpperCase().indexOf("REP") >= 0 && !this.group.toUpperCase().equals("REP-DLVR")){

				editProducts.addElement("ADS");
				editProducts.addElement("GE");
				editProductsDescription.addElement("Acrovyn Door Sytems");
				editProductsDescription.addElement("Impact Specialties");
			}
		}
		catch(Exception e){
			logger.debug("UserSession.setUserId()");
			logger.debug(e + "::" + query);
			logger.debug("UserSession END");
		}
		finally{
			try{
				stmt.close();
				myConn.close();
				myConnSys.close();
				stmtSys.close();
			}
			catch(SQLException e){
				/* ignored */
			}
		}
	}

	private static String getTagValue(String sTag,Element eElement){
		NodeList nlList = eElement.getElementsByTagName(sTag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		return nValue.getNodeValue();
	}

	public void setUserName(String x){
		this.userName = x;
	}

	public void setGroup(String x){
		this.group = x;
	}

	public void setOrderNo(String x){
		this.orderNo = x;
	}

	public void setLineNo(String x){
		this.lineNo = x;
	}

	public void setCountry(String x){
		this.country = x;
	}

	public void setSalesForceSession(boolean x){
		this.isSalesForceSession = x;
	}

	public boolean getSalesForceSession(){
		return isSalesForceSession;
	}

	public String getRepNo(){
		return repNo;
	}

	public String getUserId(){
		return userId;
	}
        public String getblockErapidQuoting(){
            return blockErapidQuoting;
	}

	public String getUserName(){
		return userName;
	}

	public String getRepAccount(){
		return repAccount;
	}

	public String getStyleSheet(){
		return styleSheet;
	}

	public String getAddress1(){
		return address1;
	}

	public String getAddress2(){
		return address2;
	}

	public String getCity(){
		return city;
	}

	public String getState(){
		return state;
	}

	public String getEmail(){
		return email;
	}

	public String getZip(){
		return zip;
	}

	public String getTelephone(){
		return telephone;
	}

	public String getFax(){
		return fax;
	}

	public String getGroup(){
		return group;
	}

	public String getOrderNo(){
		return orderNo;
	}

	public String getLineNo(){
		return lineNo;
	}

	public String getCountry(){
		return country;
	}

	public String getHelpMenu(){
		return helpMenu;
	}

	public String getUserSecurity(){
		//  pull from user security table and add to tools menu..
		return userSecurityMenu;
	}

	public String getUnitPrice(){
		//  pull from user security table and add to tools menu..
		return unitPrice;
	}

	public String[] getProducts(){
		int counter = products.size();
		String[] productReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			productReturn[i] = products.elementAt(i).toString();
		}
		return productReturn;
	}

	public String[] getProductsDescription(){
		int counter = productsDescription.size();
		String[] productReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			productReturn[i] = productsDescription.elementAt(i).toString();
		}
		return productReturn;
	}

	public String[] getEditProducts(){
		int counter = editProducts.size();
		String[] productReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			productReturn[i] = editProducts.elementAt(i).toString();
		}
		return productReturn;
	}

	public String[] getEditProductsDescription(){
		int counter = editProductsDescription.size();
		String[] productReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			productReturn[i] = editProductsDescription.elementAt(i).toString();
		}
		return productReturn;
	}

	public String[] getReps(){
		int counter = reps.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			repReturn[i] = reps.elementAt(i).toString();
		}
		return repReturn;
	}

	public String[] getRepsNames(){
		int counter = repsNames.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			repReturn[i] = repsNames.elementAt(i).toString();
		}
		return repReturn;
	}

	public String[] getReps2(){
		int counter = reps2.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			repReturn[i] = reps2.elementAt(i).toString();
		}
		return repReturn;
	}

	public String[] getRepsNames2(){
		int counter = repsNames2.size();
		String[] repReturn = new String[counter];
		for(int i = 0;i < counter;i++){
			repReturn[i] = repsNames2.elementAt(i).toString();
		}
		return repReturn;
	}

	public String saveRep(String repNo,String repName,String repId,String repAccount,String styleSheet,String address1,String address2,String city,String state,String telephone,String fax,String email,String zip){
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
					dbServerName = "" + getTagValue("dbServerName",eElement);
					dbServerPort = "" + getTagValue("dbServerPort",eElement);
					erapidDB = "" + getTagValue("erapidDB",eElement);
					erapidDBUsername = "" + getTagValue("erapidDBUsername",eElement);
					erapidDBPassword = "" + getTagValue("erapidDBPassword",eElement);
				}
			}
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			myConn = DriverManager.getConnection("jdbc:jtds:sqlserver://" + dbServerName + ":" + dbServerPort + "/" + erapidDB,erapidDBUsername,erapidDBPassword);
			stmt = myConn.createStatement();
			stmt.executeUpdate("set ANSI_warnings off");
			java.sql.PreparedStatement updateRep = myConn.prepareStatement("UPDATE cs_reps set style_sheet=?,address1=?,address2=?,rep_city=?,state=?,telephone=?,fax=?,email=?,zip=? where user_id=? and rep_no=?");
			updateRep.setString(1,styleSheet);
			updateRep.setString(2,address1);
			updateRep.setString(3,address2);
			updateRep.setString(4,city);
			updateRep.setString(5,state);
			updateRep.setString(6,telephone);
			updateRep.setString(7,fax);
			updateRep.setString(8,email);
			updateRep.setString(9,zip);
			updateRep.setString(10,repId);
			updateRep.setString(11,repNo);
			int rocount = updateRep.executeUpdate();
			updateRep.close();
			result = "update complete: " + rocount + " rows updated";

			setUserId(repId);
		}
		catch(Exception e){
			result = "failed";
			logger.debug("UserSession.saveRep()");
			logger.debug(e.getMessage());
			logger.debug("UserSession.saveRep() END");
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
	
	public void setEnv(String x)
	{
		this.env = x;
	}
	
	public String getEnv(){
		return env;
	}
}
